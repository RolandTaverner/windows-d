// Written in the D programming language.

module windows.win32.system.taskscheduler;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : BOOL, BSTR, HRESULT, HWND, PWSTR, SYSTEMTIME,
                                         VARIANT_BOOL;
public import windows.win32.system.com : IDispatch, IUnknown, SAFEARRAY;
public import windows.win32.system.variant : VARIANT;
public import windows.win32.ui.controls : HPROPSHEETPAGE;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/ne-mstask-task_trigger_type))], [])
alias TASK_TRIGGER_TYPE = int;
enum : int
{
    TASK_TIME_TRIGGER_ONCE            = 0x00000000,
    TASK_TIME_TRIGGER_DAILY           = 0x00000001,
    TASK_TIME_TRIGGER_WEEKLY          = 0x00000002,
    TASK_TIME_TRIGGER_MONTHLYDATE     = 0x00000003,
    TASK_TIME_TRIGGER_MONTHLYDOW      = 0x00000004,
    TASK_EVENT_TRIGGER_ON_IDLE        = 0x00000005,
    TASK_EVENT_TRIGGER_AT_SYSTEMSTART = 0x00000006,
    TASK_EVENT_TRIGGER_AT_LOGON       = 0x00000007,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/ne-mstask-taskpage))], [])
alias TASKPAGE = int;
enum : int
{
    TASKPAGE_TASK     = 0x00000000,
    TASKPAGE_SCHEDULE = 0x00000001,
    TASKPAGE_SETTINGS = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/ne-taskschd-task_run_flags))], [])
alias TASK_RUN_FLAGS = int;
enum : int
{
    TASK_RUN_NO_FLAGS           = 0x00000000,
    TASK_RUN_AS_SELF            = 0x00000001,
    TASK_RUN_IGNORE_CONSTRAINTS = 0x00000002,
    TASK_RUN_USE_SESSION_ID     = 0x00000004,
    TASK_RUN_USER_SID           = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/ne-taskschd-task_enum_flags))], [])
alias TASK_ENUM_FLAGS = int;
enum : int
{
    TASK_ENUM_HIDDEN = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/ne-taskschd-task_logon_type))], [])
alias TASK_LOGON_TYPE = int;
enum : int
{
    TASK_LOGON_NONE                          = 0x00000000,
    TASK_LOGON_PASSWORD                      = 0x00000001,
    TASK_LOGON_S4U                           = 0x00000002,
    TASK_LOGON_INTERACTIVE_TOKEN             = 0x00000003,
    TASK_LOGON_GROUP                         = 0x00000004,
    TASK_LOGON_SERVICE_ACCOUNT               = 0x00000005,
    TASK_LOGON_INTERACTIVE_TOKEN_OR_PASSWORD = 0x00000006,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/ne-taskschd-task_runlevel_type))], [])
alias TASK_RUNLEVEL_TYPE = int;
enum : int
{
    TASK_RUNLEVEL_LUA     = 0x00000000,
    TASK_RUNLEVEL_HIGHEST = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/ne-taskschd-task_processtokensid_type))], [])
alias TASK_PROCESSTOKENSID_TYPE = int;
enum : int
{
    TASK_PROCESSTOKENSID_NONE         = 0x00000000,
    TASK_PROCESSTOKENSID_UNRESTRICTED = 0x00000001,
    TASK_PROCESSTOKENSID_DEFAULT      = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/ne-taskschd-task_state))], [])
alias TASK_STATE = int;
enum : int
{
    TASK_STATE_UNKNOWN  = 0x00000000,
    TASK_STATE_DISABLED = 0x00000001,
    TASK_STATE_QUEUED   = 0x00000002,
    TASK_STATE_READY    = 0x00000003,
    TASK_STATE_RUNNING  = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/ne-taskschd-task_creation))], [])
alias TASK_CREATION = int;
enum : int
{
    TASK_VALIDATE_ONLY                = 0x00000001,
    TASK_CREATE                       = 0x00000002,
    TASK_UPDATE                       = 0x00000004,
    TASK_CREATE_OR_UPDATE             = 0x00000006,
    TASK_DISABLE                      = 0x00000008,
    TASK_DONT_ADD_PRINCIPAL_ACE       = 0x00000010,
    TASK_IGNORE_REGISTRATION_TRIGGERS = 0x00000020,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/ne-taskschd-task_trigger_type2))], [])
alias TASK_TRIGGER_TYPE2 = int;
enum : int
{
    TASK_TRIGGER_EVENT                = 0x00000000,
    TASK_TRIGGER_TIME                 = 0x00000001,
    TASK_TRIGGER_DAILY                = 0x00000002,
    TASK_TRIGGER_WEEKLY               = 0x00000003,
    TASK_TRIGGER_MONTHLY              = 0x00000004,
    TASK_TRIGGER_MONTHLYDOW           = 0x00000005,
    TASK_TRIGGER_IDLE                 = 0x00000006,
    TASK_TRIGGER_REGISTRATION         = 0x00000007,
    TASK_TRIGGER_BOOT                 = 0x00000008,
    TASK_TRIGGER_LOGON                = 0x00000009,
    TASK_TRIGGER_SESSION_STATE_CHANGE = 0x0000000b,
    TASK_TRIGGER_CUSTOM_TRIGGER_01    = 0x0000000c,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/ne-taskschd-task_session_state_change_type))], [])
alias TASK_SESSION_STATE_CHANGE_TYPE = int;
enum : int
{
    TASK_CONSOLE_CONNECT    = 0x00000001,
    TASK_CONSOLE_DISCONNECT = 0x00000002,
    TASK_REMOTE_CONNECT     = 0x00000003,
    TASK_REMOTE_DISCONNECT  = 0x00000004,
    TASK_SESSION_LOCK       = 0x00000007,
    TASK_SESSION_UNLOCK     = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/ne-taskschd-task_action_type))], [])
alias TASK_ACTION_TYPE = int;
enum : int
{
    TASK_ACTION_EXEC         = 0x00000000,
    TASK_ACTION_COM_HANDLER  = 0x00000005,
    TASK_ACTION_SEND_EMAIL   = 0x00000006,
    TASK_ACTION_SHOW_MESSAGE = 0x00000007,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/ne-taskschd-task_instances_policy))], [])
alias TASK_INSTANCES_POLICY = int;
enum : int
{
    TASK_INSTANCES_PARALLEL      = 0x00000000,
    TASK_INSTANCES_QUEUE         = 0x00000001,
    TASK_INSTANCES_IGNORE_NEW    = 0x00000002,
    TASK_INSTANCES_STOP_EXISTING = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/ne-taskschd-task_compatibility))], [])
alias TASK_COMPATIBILITY = int;
enum : int
{
    TASK_COMPATIBILITY_AT   = 0x00000000,
    TASK_COMPATIBILITY_V1   = 0x00000001,
    TASK_COMPATIBILITY_V2   = 0x00000002,
    TASK_COMPATIBILITY_V2_1 = 0x00000003,
    TASK_COMPATIBILITY_V2_2 = 0x00000004,
    TASK_COMPATIBILITY_V2_3 = 0x00000005,
    TASK_COMPATIBILITY_V2_4 = 0x00000006,
}

// Constants


enum : uint
{
    TASK_SUNDAY    = 0x00000001,
    TASK_MONDAY    = 0x00000002,
    TASK_TUESDAY   = 0x00000004,
    TASK_WEDNESDAY = 0x00000008,
}

enum uint TASK_THURSDAY = 0x00000010;

enum : uint
{
    TASK_FRIDAY   = 0x00000020,
    TASK_SATURDAY = 0x00000040,
}

enum uint TASK_FIRST_WEEK = 0x00000001;
enum uint TASK_SECOND_WEEK = 0x00000002;
enum uint TASK_THIRD_WEEK = 0x00000003;
enum uint TASK_FOURTH_WEEK = 0x00000004;
enum uint TASK_LAST_WEEK = 0x00000005;

enum : uint
{
    TASK_JANUARY  = 0x00000001,
    TASK_FEBRUARY = 0x00000002,
}

enum : uint
{
    TASK_MARCH     = 0x00000004,
    TASK_APRIL     = 0x00000008,
    TASK_MAY       = 0x00000010,
    TASK_JUNE      = 0x00000020,
    TASK_JULY      = 0x00000040,
    TASK_AUGUST    = 0x00000080,
    TASK_SEPTEMBER = 0x00000100,
}

enum : uint
{
    TASK_OCTOBER  = 0x00000200,
    TASK_NOVEMBER = 0x00000400,
}

enum uint TASK_DECEMBER = 0x00000800;

enum : uint
{
    TASK_FLAG_INTERACTIVE        = 0x00000001,
    TASK_FLAG_DELETE_WHEN_DONE   = 0x00000002,
    TASK_FLAG_DISABLED           = 0x00000004,
    TASK_FLAG_START_ONLY_IF_IDLE = 0x00000010,
}

enum uint TASK_FLAG_KILL_ON_IDLE_END = 0x00000020;
enum uint TASK_FLAG_DONT_START_IF_ON_BATTERIES = 0x00000040;
enum uint TASK_FLAG_KILL_IF_GOING_ON_BATTERIES = 0x00000080;
enum uint TASK_FLAG_RUN_ONLY_IF_DOCKED = 0x00000100;

enum : uint
{
    TASK_FLAG_HIDDEN                       = 0x00000200,
    TASK_FLAG_RUN_IF_CONNECTED_TO_INTERNET = 0x00000400,
}

enum uint TASK_FLAG_RESTART_ON_IDLE_RESUME = 0x00000800;
enum uint TASK_FLAG_SYSTEM_REQUIRED = 0x00001000;
enum uint TASK_FLAG_RUN_ONLY_IF_LOGGED_ON = 0x00002000;

enum : uint
{
    TASK_TRIGGER_FLAG_HAS_END_DATE         = 0x00000001,
    TASK_TRIGGER_FLAG_KILL_AT_DURATION_END = 0x00000002,
    TASK_TRIGGER_FLAG_DISABLED             = 0x00000004,
}

enum uint TASK_MAX_RUN_TIMES = 0x000005a0;

enum : GUID
{
    CLSID_CTask          = GUID("148bd520-a2ab-11ce-b11f-00aa00530503"),
    CLSID_CTaskScheduler = GUID("148bd52a-a2ab-11ce-b11f-00aa00530503"),
}

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/ns-mstask-daily))], [])
struct DAILY
{
    ushort DaysInterval;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/ns-mstask-weekly))], [])
struct WEEKLY
{
    ushort WeeksInterval;
    ushort rgfDaysOfTheWeek;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/ns-mstask-monthlydate))], [])
struct MONTHLYDATE
{
    uint   rgfDays;
    ushort rgfMonths;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/ns-mstask-monthlydow))], [])
struct MONTHLYDOW
{
    ushort wWhichWeek;
    ushort rgfDaysOfTheWeek;
    ushort rgfMonths;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/ns-mstask-trigger_type_union))], [])
union TRIGGER_TYPE_UNION
{
    DAILY       Daily;
    WEEKLY      Weekly;
    MONTHLYDATE MonthlyDate;
    MONTHLYDOW  MonthlyDOW;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/ns-mstask-task_trigger))], [])
struct TASK_TRIGGER
{
    ushort             cbTriggerSize;
    ushort             Reserved1;
    ushort             wBeginYear;
    ushort             wBeginMonth;
    ushort             wBeginDay;
    ushort             wEndYear;
    ushort             wEndMonth;
    ushort             wEndDay;
    ushort             wStartHour;
    ushort             wStartMinute;
    uint               MinutesDuration;
    uint               MinutesInterval;
    uint               rgFlags;
    TASK_TRIGGER_TYPE  TriggerType;
    TRIGGER_TYPE_UNION Type;
    ushort             Reserved2;
    ushort             wRandomMinutesInterval;
}

// Interfaces

@GUID("0f87369f-a4e5-4cfc-bd3e-73e6154572dd")
struct TaskScheduler;

@GUID("f2a69db7-da2c-4352-9066-86fee6dacac9")
struct TaskHandlerPS;

@GUID("9f15266d-d7ba-48f0-93c1-e6895f6fe5ac")
struct TaskHandlerStatusPS;

@GUID("148bd52b-a2ab-11ce-b11f-00aa00530503")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nn-mstask-itasktrigger))], [])
interface ITaskTrigger : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itasktrigger-settrigger))], [])
    HRESULT SetTrigger(const(TASK_TRIGGER)* pTrigger);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itasktrigger-gettrigger))], [])
    HRESULT GetTrigger(TASK_TRIGGER* pTrigger);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itasktrigger-gettriggerstring))], [])
    HRESULT GetTriggerString(PWSTR* ppwszTrigger);
}

@GUID("a6b952f0-a4b1-11d0-997d-00aa006887ec")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nn-mstask-ischeduledworkitem))], [])
interface IScheduledWorkItem : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-createtrigger))], [])
    HRESULT CreateTrigger(ushort* piNewTrigger, ITaskTrigger* ppTrigger);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-deletetrigger))], [])
    HRESULT DeleteTrigger(ushort iTrigger);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-gettriggercount))], [])
    HRESULT GetTriggerCount(ushort* pwCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-gettrigger))], [])
    HRESULT GetTrigger(ushort iTrigger, ITaskTrigger* ppTrigger);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-gettriggerstring))], [])
    HRESULT GetTriggerString(ushort iTrigger, PWSTR* ppwszTrigger);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-getruntimes))], [])
    HRESULT GetRunTimes(const(SYSTEMTIME)* pstBegin, const(SYSTEMTIME)* pstEnd, ushort* pCount, 
                        SYSTEMTIME** rgstTaskTimes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-getnextruntime))], [])
    HRESULT GetNextRunTime(SYSTEMTIME* pstNextRun);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-setidlewait))], [])
    HRESULT SetIdleWait(ushort wIdleMinutes, ushort wDeadlineMinutes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-getidlewait))], [])
    HRESULT GetIdleWait(ushort* pwIdleMinutes, ushort* pwDeadlineMinutes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-run))], [])
    HRESULT Run();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-terminate))], [])
    HRESULT Terminate();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-editworkitem))], [])
    HRESULT EditWorkItem(HWND hParent, uint dwReserved);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-getmostrecentruntime))], [])
    HRESULT GetMostRecentRunTime(SYSTEMTIME* pstLastRun);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-getstatus))], [])
    HRESULT GetStatus(HRESULT* phrStatus);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-getexitcode))], [])
    HRESULT GetExitCode(uint* pdwExitCode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-setcomment))], [])
    HRESULT SetComment(const(PWSTR) pwszComment);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-getcomment))], [])
    HRESULT GetComment(PWSTR* ppwszComment);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-setcreator))], [])
    HRESULT SetCreator(const(PWSTR) pwszCreator);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-getcreator))], [])
    HRESULT GetCreator(PWSTR* ppwszCreator);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-setworkitemdata))], [])
    HRESULT SetWorkItemData(ushort cbData, ubyte* rgbData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-getworkitemdata))], [])
    HRESULT GetWorkItemData(ushort* pcbData, ubyte** prgbData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-seterrorretrycount))], [])
    HRESULT SetErrorRetryCount(ushort wRetryCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-geterrorretrycount))], [])
    HRESULT GetErrorRetryCount(ushort* pwRetryCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-seterrorretryinterval))], [])
    HRESULT SetErrorRetryInterval(ushort wRetryInterval);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-geterrorretryinterval))], [])
    HRESULT GetErrorRetryInterval(ushort* pwRetryInterval);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-setflags))], [])
    HRESULT SetFlags(uint dwFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-getflags))], [])
    HRESULT GetFlags(uint* pdwFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-setaccountinformation))], [])
    HRESULT SetAccountInformation(const(PWSTR) pwszAccountName, const(PWSTR) pwszPassword);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-getaccountinformation))], [])
    HRESULT GetAccountInformation(PWSTR* ppwszAccountName);
}

@GUID("148bd524-a2ab-11ce-b11f-00aa00530503")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nn-mstask-itask))], [])
interface ITask : IScheduledWorkItem
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itask-setapplicationname))], [])
    HRESULT SetApplicationName(const(PWSTR) pwszApplicationName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itask-getapplicationname))], [])
    HRESULT GetApplicationName(PWSTR* ppwszApplicationName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itask-setparameters))], [])
    HRESULT SetParameters(const(PWSTR) pwszParameters);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itask-getparameters))], [])
    HRESULT GetParameters(PWSTR* ppwszParameters);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itask-setworkingdirectory))], [])
    HRESULT SetWorkingDirectory(const(PWSTR) pwszWorkingDirectory);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itask-getworkingdirectory))], [])
    HRESULT GetWorkingDirectory(PWSTR* ppwszWorkingDirectory);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itask-setpriority))], [])
    HRESULT SetPriority(uint dwPriority);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itask-getpriority))], [])
    HRESULT GetPriority(uint* pdwPriority);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itask-settaskflags))], [])
    HRESULT SetTaskFlags(uint dwFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itask-gettaskflags))], [])
    HRESULT GetTaskFlags(uint* pdwFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itask-setmaxruntime))], [])
    HRESULT SetMaxRunTime(uint dwMaxRunTimeMS);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itask-getmaxruntime))], [])
    HRESULT GetMaxRunTime(uint* pdwMaxRunTimeMS);
}

@GUID("148bd528-a2ab-11ce-b11f-00aa00530503")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nn-mstask-ienumworkitems))], [])
interface IEnumWorkItems : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Next(uint celt, PWSTR** rgpwszNames, uint* pceltFetched);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ienumworkitems-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ienumworkitems-clone))], [])
    HRESULT Clone(IEnumWorkItems* ppEnumWorkItems);
}

@GUID("148bd527-a2ab-11ce-b11f-00aa00530503")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nn-mstask-itaskscheduler))], [])
interface ITaskScheduler : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itaskscheduler-settargetcomputer))], [])
    HRESULT SetTargetComputer(const(PWSTR) pwszComputer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itaskscheduler-gettargetcomputer))], [])
    HRESULT GetTargetComputer(PWSTR* ppwszComputer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itaskscheduler-enum))], [])
    HRESULT Enum(IEnumWorkItems* ppEnumWorkItems);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itaskscheduler-activate))], [])
    HRESULT Activate(const(PWSTR) pwszName, const(GUID)* riid, IUnknown* ppUnk);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itaskscheduler-delete))], [])
    HRESULT Delete(const(PWSTR) pwszName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itaskscheduler-newworkitem))], [])
    HRESULT NewWorkItem(const(PWSTR) pwszTaskName, const(GUID)* rclsid, const(GUID)* riid, IUnknown* ppUnk);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itaskscheduler-addworkitem))], [])
    HRESULT AddWorkItem(const(PWSTR) pwszTaskName, IScheduledWorkItem pWorkItem);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itaskscheduler-isoftype))], [])
    HRESULT IsOfType(const(PWSTR) pwszName, const(GUID)* riid);
}

@GUID("4086658a-cbbb-11cf-b604-00c04fd8d565")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nn-mstask-iprovidetaskpage))], [])
interface IProvideTaskPage : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-iprovidetaskpage-getpage))], [])
    HRESULT GetPage(TASKPAGE tpType, BOOL fPersistChanges, HPROPSHEETPAGE* phPage);
}

@GUID("79184a66-8664-423f-97f1-637356a5d812")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itaskfoldercollection))], [])
interface ITaskFolderCollection : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfoldercollection-get_count))], [])
    HRESULT get_Count(int* pCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfoldercollection-get_item))], [])
    HRESULT get_Item(VARIANT index, ITaskFolder* ppFolder);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfoldercollection-get__newenum))], [])
    HRESULT get__NewEnum(IUnknown* ppEnum);
}

@GUID("2faba4c7-4da9-4013-9697-20cc3fd40f85")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itaskservice))], [])
interface ITaskService : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskservice-getfolder))], [])
    HRESULT GetFolder(BSTR path, ITaskFolder* ppFolder);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskservice-getrunningtasks))], [])
    HRESULT GetRunningTasks(int flags, IRunningTaskCollection* ppRunningTasks);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskservice-newtask))], [])
    HRESULT NewTask(uint flags, ITaskDefinition* ppDefinition);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskservice-connect))], [])
    HRESULT Connect(VARIANT serverName, VARIANT user, VARIANT domain, VARIANT password);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskservice-get_connected))], [])
    HRESULT get_Connected(VARIANT_BOOL* pConnected);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskservice-get_targetserver))], [])
    HRESULT get_TargetServer(BSTR* pServer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskservice-get_connecteduser))], [])
    HRESULT get_ConnectedUser(BSTR* pUser);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskservice-get_connecteddomain))], [])
    HRESULT get_ConnectedDomain(BSTR* pDomain);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskservice-get_highestversion))], [])
    HRESULT get_HighestVersion(uint* pVersion);
}

@GUID("839d7762-5121-4009-9234-4f0d19394f04")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itaskhandler))], [])
interface ITaskHandler : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskhandler-start))], [])
    HRESULT Start(IUnknown pHandlerServices, BSTR data);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskhandler-stop))], [])
    HRESULT Stop(HRESULT* pRetCode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskhandler-pause))], [])
    HRESULT Pause();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskhandler-resume))], [])
    HRESULT Resume();
}

@GUID("eaec7a8f-27a0-4ddc-8675-14726a01a38a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itaskhandlerstatus))], [])
interface ITaskHandlerStatus : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskhandlerstatus-updatestatus))], [])
    HRESULT UpdateStatus(short percentComplete, BSTR statusMessage);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskhandlerstatus-taskcompleted))], [])
    HRESULT TaskCompleted(HRESULT taskErrCode);
}

@GUID("3e4c9351-d966-4b8b-bb87-ceba68bb0107")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itaskvariables))], [])
interface ITaskVariables : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskvariables-getinput))], [])
    HRESULT GetInput(BSTR* pInput);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskvariables-setoutput))], [])
    HRESULT SetOutput(BSTR input);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskvariables-getcontext))], [])
    HRESULT GetContext(BSTR* pContext);
}

@GUID("39038068-2b46-4afd-8662-7bb6f868d221")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itasknamedvaluepair))], [])
interface ITaskNamedValuePair : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasknamedvaluepair-get_name))], [])
    HRESULT get_Name(BSTR* pName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasknamedvaluepair-put_name))], [])
    HRESULT put_Name(BSTR name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasknamedvaluepair-get_value))], [])
    HRESULT get_Value(BSTR* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasknamedvaluepair-put_value))], [])
    HRESULT put_Value(BSTR value);
}

@GUID("b4ef826b-63c3-46e4-a504-ef69e4f7ea4d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itasknamedvaluecollection))], [])
interface ITaskNamedValueCollection : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasknamedvaluecollection-get_count))], [])
    HRESULT get_Count(int* pCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasknamedvaluecollection-get_item))], [])
    HRESULT get_Item(int index, ITaskNamedValuePair* ppPair);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasknamedvaluecollection-get__newenum))], [])
    HRESULT get__NewEnum(IUnknown* ppEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasknamedvaluecollection-create))], [])
    HRESULT Create(BSTR name, BSTR value, ITaskNamedValuePair* ppPair);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasknamedvaluecollection-remove))], [])
    HRESULT Remove(int index);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasknamedvaluecollection-clear))], [])
    HRESULT Clear();
}

@GUID("653758fb-7b9a-4f1e-a471-beeb8e9b834e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-irunningtask))], [])
interface IRunningTask : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irunningtask-get_name))], [])
    HRESULT get_Name(BSTR* pName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irunningtask-get_instanceguid))], [])
    HRESULT get_InstanceGuid(BSTR* pGuid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irunningtask-get_path))], [])
    HRESULT get_Path(BSTR* pPath);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irunningtask-get_state))], [])
    HRESULT get_State(TASK_STATE* pState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irunningtask-get_currentaction))], [])
    HRESULT get_CurrentAction(BSTR* pName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irunningtask-stop))], [])
    HRESULT Stop();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irunningtask-refresh))], [])
    HRESULT Refresh();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irunningtask-get_enginepid))], [])
    HRESULT get_EnginePID(uint* pPID);
}

@GUID("6a67614b-6828-4fec-aa54-6d52e8f1f2db")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-irunningtaskcollection))], [])
interface IRunningTaskCollection : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irunningtaskcollection-get_count))], [])
    HRESULT get_Count(int* pCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irunningtaskcollection-get_item))], [])
    HRESULT get_Item(VARIANT index, IRunningTask* ppRunningTask);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irunningtaskcollection-get__newenum))], [])
    HRESULT get__NewEnum(IUnknown* ppEnum);
}

@GUID("9c86f320-dee3-4dd1-b972-a303f26b061e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-iregisteredtask))], [])
interface IRegisteredTask : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-get_name))], [])
    HRESULT get_Name(BSTR* pName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-get_path))], [])
    HRESULT get_Path(BSTR* pPath);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-get_state))], [])
    HRESULT get_State(TASK_STATE* pState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-get_enabled))], [])
    HRESULT get_Enabled(VARIANT_BOOL* pEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-put_enabled))], [])
    HRESULT put_Enabled(VARIANT_BOOL enabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-run))], [])
    HRESULT Run(VARIANT params, IRunningTask* ppRunningTask);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-runex))], [])
    HRESULT RunEx(VARIANT params, int flags, int sessionID, BSTR user, IRunningTask* ppRunningTask);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-getinstances))], [])
    HRESULT GetInstances(int flags, IRunningTaskCollection* ppRunningTasks);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-get_lastruntime))], [])
    HRESULT get_LastRunTime(double* pLastRunTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-get_lasttaskresult))], [])
    HRESULT get_LastTaskResult(int* pLastTaskResult);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-get_numberofmissedruns))], [])
    HRESULT get_NumberOfMissedRuns(int* pNumberOfMissedRuns);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-get_nextruntime))], [])
    HRESULT get_NextRunTime(double* pNextRunTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-get_definition))], [])
    HRESULT get_Definition(ITaskDefinition* ppDefinition);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-get_xml))], [])
    HRESULT get_Xml(BSTR* pXml);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-getsecuritydescriptor))], [])
    HRESULT GetSecurityDescriptor(int securityInformation, BSTR* pSddl);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-setsecuritydescriptor))], [])
    HRESULT SetSecurityDescriptor(BSTR sddl, int flags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-stop))], [])
    HRESULT Stop(int flags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-getruntimes))], [])
    HRESULT GetRunTimes(const(SYSTEMTIME)* pstStart, const(SYSTEMTIME)* pstEnd, uint* pCount, 
                        SYSTEMTIME** pRunTimes);
}

@GUID("09941815-ea89-4b5b-89e0-2a773801fac3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itrigger))], [])
interface ITrigger : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itrigger-get_type))], [])
    HRESULT get_Type(TASK_TRIGGER_TYPE2* pType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itrigger-get_id))], [])
    HRESULT get_Id(BSTR* pId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itrigger-put_id))], [])
    HRESULT put_Id(BSTR id);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itrigger-get_repetition))], [])
    HRESULT get_Repetition(IRepetitionPattern* ppRepeat);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itrigger-put_repetition))], [])
    HRESULT put_Repetition(IRepetitionPattern pRepeat);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itrigger-get_executiontimelimit))], [])
    HRESULT get_ExecutionTimeLimit(BSTR* pTimeLimit);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itrigger-put_executiontimelimit))], [])
    HRESULT put_ExecutionTimeLimit(BSTR timelimit);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itrigger-get_startboundary))], [])
    HRESULT get_StartBoundary(BSTR* pStart);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itrigger-put_startboundary))], [])
    HRESULT put_StartBoundary(BSTR start);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itrigger-get_endboundary))], [])
    HRESULT get_EndBoundary(BSTR* pEnd);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itrigger-put_endboundary))], [])
    HRESULT put_EndBoundary(BSTR end);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itrigger-get_enabled))], [])
    HRESULT get_Enabled(VARIANT_BOOL* pEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itrigger-put_enabled))], [])
    HRESULT put_Enabled(VARIANT_BOOL enabled);
}

@GUID("d537d2b0-9fb3-4d34-9739-1ff5ce7b1ef3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-iidletrigger))], [])
interface IIdleTrigger : ITrigger
{
}

@GUID("72dade38-fae4-4b3e-baf4-5d009af02b1c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-ilogontrigger))], [])
interface ILogonTrigger : ITrigger
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-ilogontrigger-get_delay))], [])
    HRESULT get_Delay(BSTR* pDelay);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-ilogontrigger-put_delay))], [])
    HRESULT put_Delay(BSTR delay);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-ilogontrigger-get_userid))], [])
    HRESULT get_UserId(BSTR* pUser);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-ilogontrigger-put_userid))], [])
    HRESULT put_UserId(BSTR user);
}

@GUID("754da71b-4385-4475-9dd9-598294fa3641")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-isessionstatechangetrigger))], [])
interface ISessionStateChangeTrigger : ITrigger
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-isessionstatechangetrigger-get_delay))], [])
    HRESULT get_Delay(BSTR* pDelay);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-isessionstatechangetrigger-put_delay))], [])
    HRESULT put_Delay(BSTR delay);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-isessionstatechangetrigger-get_userid))], [])
    HRESULT get_UserId(BSTR* pUser);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-isessionstatechangetrigger-put_userid))], [])
    HRESULT put_UserId(BSTR user);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-isessionstatechangetrigger-get_statechange))], [])
    HRESULT get_StateChange(TASK_SESSION_STATE_CHANGE_TYPE* pType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-isessionstatechangetrigger-put_statechange))], [])
    HRESULT put_StateChange(TASK_SESSION_STATE_CHANGE_TYPE type);
}

@GUID("d45b0167-9653-4eef-b94f-0732ca7af251")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-ieventtrigger))], [])
interface IEventTrigger : ITrigger
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-ieventtrigger-get_subscription))], [])
    HRESULT get_Subscription(BSTR* pQuery);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-ieventtrigger-put_subscription))], [])
    HRESULT put_Subscription(BSTR query);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-ieventtrigger-get_delay))], [])
    HRESULT get_Delay(BSTR* pDelay);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-ieventtrigger-put_delay))], [])
    HRESULT put_Delay(BSTR delay);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-ieventtrigger-get_valuequeries))], [])
    HRESULT get_ValueQueries(ITaskNamedValueCollection* ppNamedXPaths);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-ieventtrigger-put_valuequeries))], [])
    HRESULT put_ValueQueries(ITaskNamedValueCollection pNamedXPaths);
}

@GUID("b45747e0-eba7-4276-9f29-85c5bb300006")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itimetrigger))], [])
interface ITimeTrigger : ITrigger
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itimetrigger-get_randomdelay))], [])
    HRESULT get_RandomDelay(BSTR* pRandomDelay);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itimetrigger-put_randomdelay))], [])
    HRESULT put_RandomDelay(BSTR randomDelay);
}

@GUID("126c5cd8-b288-41d5-8dbf-e491446adc5c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-idailytrigger))], [])
interface IDailyTrigger : ITrigger
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-idailytrigger-get_daysinterval))], [])
    HRESULT get_DaysInterval(short* pDays);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-idailytrigger-put_daysinterval))], [])
    HRESULT put_DaysInterval(short days);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-idailytrigger-get_randomdelay))], [])
    HRESULT get_RandomDelay(BSTR* pRandomDelay);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-idailytrigger-put_randomdelay))], [])
    HRESULT put_RandomDelay(BSTR randomDelay);
}

@GUID("5038fc98-82ff-436d-8728-a512a57c9dc1")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-iweeklytrigger))], [])
interface IWeeklyTrigger : ITrigger
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iweeklytrigger-get_daysofweek))], [])
    HRESULT get_DaysOfWeek(short* pDays);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iweeklytrigger-put_daysofweek))], [])
    HRESULT put_DaysOfWeek(short days);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iweeklytrigger-get_weeksinterval))], [])
    HRESULT get_WeeksInterval(short* pWeeks);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iweeklytrigger-put_weeksinterval))], [])
    HRESULT put_WeeksInterval(short weeks);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iweeklytrigger-get_randomdelay))], [])
    HRESULT get_RandomDelay(BSTR* pRandomDelay);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iweeklytrigger-put_randomdelay))], [])
    HRESULT put_RandomDelay(BSTR randomDelay);
}

@GUID("97c45ef1-6b02-4a1a-9c0e-1ebfba1500ac")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-imonthlytrigger))], [])
interface IMonthlyTrigger : ITrigger
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlytrigger-get_daysofmonth))], [])
    HRESULT get_DaysOfMonth(int* pDays);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlytrigger-put_daysofmonth))], [])
    HRESULT put_DaysOfMonth(int days);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlytrigger-get_monthsofyear))], [])
    HRESULT get_MonthsOfYear(short* pMonths);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlytrigger-put_monthsofyear))], [])
    HRESULT put_MonthsOfYear(short months);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlytrigger-get_runonlastdayofmonth))], [])
    HRESULT get_RunOnLastDayOfMonth(VARIANT_BOOL* pLastDay);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlytrigger-put_runonlastdayofmonth))], [])
    HRESULT put_RunOnLastDayOfMonth(VARIANT_BOOL lastDay);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlytrigger-get_randomdelay))], [])
    HRESULT get_RandomDelay(BSTR* pRandomDelay);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlytrigger-put_randomdelay))], [])
    HRESULT put_RandomDelay(BSTR randomDelay);
}

@GUID("77d025a3-90fa-43aa-b52e-cda5499b946a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-imonthlydowtrigger))], [])
interface IMonthlyDOWTrigger : ITrigger
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlydowtrigger-get_daysofweek))], [])
    HRESULT get_DaysOfWeek(short* pDays);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlydowtrigger-put_daysofweek))], [])
    HRESULT put_DaysOfWeek(short days);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlydowtrigger-get_weeksofmonth))], [])
    HRESULT get_WeeksOfMonth(short* pWeeks);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlydowtrigger-put_weeksofmonth))], [])
    HRESULT put_WeeksOfMonth(short weeks);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlydowtrigger-get_monthsofyear))], [])
    HRESULT get_MonthsOfYear(short* pMonths);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlydowtrigger-put_monthsofyear))], [])
    HRESULT put_MonthsOfYear(short months);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlydowtrigger-get_runonlastweekofmonth))], [])
    HRESULT get_RunOnLastWeekOfMonth(VARIANT_BOOL* pLastWeek);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlydowtrigger-put_runonlastweekofmonth))], [])
    HRESULT put_RunOnLastWeekOfMonth(VARIANT_BOOL lastWeek);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlydowtrigger-get_randomdelay))], [])
    HRESULT get_RandomDelay(BSTR* pRandomDelay);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlydowtrigger-put_randomdelay))], [])
    HRESULT put_RandomDelay(BSTR randomDelay);
}

@GUID("2a9c35da-d357-41f4-bbc1-207ac1b1f3cb")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-iboottrigger))], [])
interface IBootTrigger : ITrigger
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iboottrigger-get_delay))], [])
    HRESULT get_Delay(BSTR* pDelay);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iboottrigger-put_delay))], [])
    HRESULT put_Delay(BSTR delay);
}

@GUID("4c8fec3a-c218-4e0c-b23d-629024db91a2")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-iregistrationtrigger))], [])
interface IRegistrationTrigger : ITrigger
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationtrigger-get_delay))], [])
    HRESULT get_Delay(BSTR* pDelay);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationtrigger-put_delay))], [])
    HRESULT put_Delay(BSTR delay);
}

@GUID("bae54997-48b1-4cbe-9965-d6be263ebea4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-iaction))], [])
interface IAction : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iaction-get_id))], [])
    HRESULT get_Id(BSTR* pId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iaction-put_id))], [])
    HRESULT put_Id(BSTR Id);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iaction-get_type))], [])
    HRESULT get_Type(TASK_ACTION_TYPE* pType);
}

@GUID("4c3d624d-fd6b-49a3-b9b7-09cb3cd3f047")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-iexecaction))], [])
interface IExecAction : IAction
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iexecaction-get_path))], [])
    HRESULT get_Path(BSTR* pPath);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iexecaction-put_path))], [])
    HRESULT put_Path(BSTR path);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iexecaction-get_arguments))], [])
    HRESULT get_Arguments(BSTR* pArgument);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iexecaction-put_arguments))], [])
    HRESULT put_Arguments(BSTR argument);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iexecaction-get_workingdirectory))], [])
    HRESULT get_WorkingDirectory(BSTR* pWorkingDirectory);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iexecaction-put_workingdirectory))], [])
    HRESULT put_WorkingDirectory(BSTR workingDirectory);
}

@GUID("f2a82542-bda5-4e6b-9143-e2bf4f8987b6")
interface IExecAction2 : IExecAction
{
    HRESULT get_HideAppWindow(VARIANT_BOOL* pHideAppWindow);
    HRESULT put_HideAppWindow(VARIANT_BOOL hideAppWindow);
}

@GUID("505e9e68-af89-46b8-a30f-56162a83d537")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-ishowmessageaction))], [])
interface IShowMessageAction : IAction
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-ishowmessageaction-get_title))], [])
    HRESULT get_Title(BSTR* pTitle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-ishowmessageaction-put_title))], [])
    HRESULT put_Title(BSTR title);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-ishowmessageaction-get_messagebody))], [])
    HRESULT get_MessageBody(BSTR* pMessageBody);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-ishowmessageaction-put_messagebody))], [])
    HRESULT put_MessageBody(BSTR messageBody);
}

@GUID("6d2fd252-75c5-4f66-90ba-2a7d8cc3039f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-icomhandleraction))], [])
interface IComHandlerAction : IAction
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-icomhandleraction-get_classid))], [])
    HRESULT get_ClassId(BSTR* pClsid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-icomhandleraction-put_classid))], [])
    HRESULT put_ClassId(BSTR clsid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-icomhandleraction-get_data))], [])
    HRESULT get_Data(BSTR* pData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-icomhandleraction-put_data))], [])
    HRESULT put_Data(BSTR data);
}

@GUID("10f62c64-7e16-4314-a0c2-0c3683f99d40")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-iemailaction))], [])
interface IEmailAction : IAction
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-get_server))], [])
    HRESULT get_Server(BSTR* pServer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-put_server))], [])
    HRESULT put_Server(BSTR server);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-get_subject))], [])
    HRESULT get_Subject(BSTR* pSubject);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-put_subject))], [])
    HRESULT put_Subject(BSTR subject);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-get_to))], [])
    HRESULT get_To(BSTR* pTo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-put_to))], [])
    HRESULT put_To(BSTR to);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-get_cc))], [])
    HRESULT get_Cc(BSTR* pCc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-put_cc))], [])
    HRESULT put_Cc(BSTR cc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-get_bcc))], [])
    HRESULT get_Bcc(BSTR* pBcc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-put_bcc))], [])
    HRESULT put_Bcc(BSTR bcc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-get_replyto))], [])
    HRESULT get_ReplyTo(BSTR* pReplyTo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-put_replyto))], [])
    HRESULT put_ReplyTo(BSTR replyTo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-get_from))], [])
    HRESULT get_From(BSTR* pFrom);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-put_from))], [])
    HRESULT put_From(BSTR from);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-get_headerfields))], [])
    HRESULT get_HeaderFields(ITaskNamedValueCollection* ppHeaderFields);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-put_headerfields))], [])
    HRESULT put_HeaderFields(ITaskNamedValueCollection pHeaderFields);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-get_body))], [])
    HRESULT get_Body(BSTR* pBody);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-put_body))], [])
    HRESULT put_Body(BSTR body_);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-get_attachments))], [])
    HRESULT get_Attachments(SAFEARRAY** pAttachements);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-put_attachments))], [])
    HRESULT put_Attachments(SAFEARRAY* pAttachements);
}

@GUID("85df5081-1b24-4f32-878a-d9d14df4cb77")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itriggercollection))], [])
interface ITriggerCollection : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itriggercollection-get_count))], [])
    HRESULT get_Count(int* pCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itriggercollection-get_item))], [])
    HRESULT get_Item(int index, ITrigger* ppTrigger);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itriggercollection-get__newenum))], [])
    HRESULT get__NewEnum(IUnknown* ppEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itriggercollection-create))], [])
    HRESULT Create(TASK_TRIGGER_TYPE2 type, ITrigger* ppTrigger);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itriggercollection-remove))], [])
    HRESULT Remove(VARIANT index);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itriggercollection-clear))], [])
    HRESULT Clear();
}

@GUID("02820e19-7b98-4ed2-b2e8-fdccceff619b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-iactioncollection))], [])
interface IActionCollection : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iactioncollection-get_count))], [])
    HRESULT get_Count(int* pCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iactioncollection-get_item))], [])
    HRESULT get_Item(int index, IAction* ppAction);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iactioncollection-get__newenum))], [])
    HRESULT get__NewEnum(IUnknown* ppEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iactioncollection-get_xmltext))], [])
    HRESULT get_XmlText(BSTR* pText);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iactioncollection-put_xmltext))], [])
    HRESULT put_XmlText(BSTR text);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iactioncollection-create))], [])
    HRESULT Create(TASK_ACTION_TYPE type, IAction* ppAction);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iactioncollection-remove))], [])
    HRESULT Remove(VARIANT index);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iactioncollection-clear))], [])
    HRESULT Clear();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iactioncollection-get_context))], [])
    HRESULT get_Context(BSTR* pContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iactioncollection-put_context))], [])
    HRESULT put_Context(BSTR context);
}

@GUID("d98d51e5-c9b4-496a-a9c1-18980261cf0f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-iprincipal))], [])
interface IPrincipal : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal-get_id))], [])
    HRESULT get_Id(BSTR* pId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal-put_id))], [])
    HRESULT put_Id(BSTR Id);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal-get_displayname))], [])
    HRESULT get_DisplayName(BSTR* pName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal-put_displayname))], [])
    HRESULT put_DisplayName(BSTR name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal-get_userid))], [])
    HRESULT get_UserId(BSTR* pUser);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal-put_userid))], [])
    HRESULT put_UserId(BSTR user);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal-get_logontype))], [])
    HRESULT get_LogonType(TASK_LOGON_TYPE* pLogon);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal-put_logontype))], [])
    HRESULT put_LogonType(TASK_LOGON_TYPE logon);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal-get_groupid))], [])
    HRESULT get_GroupId(BSTR* pGroup);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal-put_groupid))], [])
    HRESULT put_GroupId(BSTR group);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal-get_runlevel))], [])
    HRESULT get_RunLevel(TASK_RUNLEVEL_TYPE* pRunLevel);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal-put_runlevel))], [])
    HRESULT put_RunLevel(TASK_RUNLEVEL_TYPE runLevel);
}

@GUID("248919ae-e345-4a6d-8aeb-e0d3165c904e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-iprincipal2))], [])
interface IPrincipal2 : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal2-get_processtokensidtype))], [])
    HRESULT get_ProcessTokenSidType(TASK_PROCESSTOKENSID_TYPE* pProcessTokenSidType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal2-put_processtokensidtype))], [])
    HRESULT put_ProcessTokenSidType(TASK_PROCESSTOKENSID_TYPE processTokenSidType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal2-get_requiredprivilegecount))], [])
    HRESULT get_RequiredPrivilegeCount(int* pCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal2-get_requiredprivilege))], [])
    HRESULT get_RequiredPrivilege(int index, BSTR* pPrivilege);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal2-addrequiredprivilege))], [])
    HRESULT AddRequiredPrivilege(BSTR privilege);
}

@GUID("416d8b73-cb41-4ea1-805c-9be9a5ac4a74")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-iregistrationinfo))], [])
interface IRegistrationInfo : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-get_description))], [])
    HRESULT get_Description(BSTR* pDescription);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-put_description))], [])
    HRESULT put_Description(BSTR description);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-get_author))], [])
    HRESULT get_Author(BSTR* pAuthor);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-put_author))], [])
    HRESULT put_Author(BSTR author);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-get_version))], [])
    HRESULT get_Version(BSTR* pVersion);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-put_version))], [])
    HRESULT put_Version(BSTR version_);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-get_date))], [])
    HRESULT get_Date(BSTR* pDate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-put_date))], [])
    HRESULT put_Date(BSTR date);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-get_documentation))], [])
    HRESULT get_Documentation(BSTR* pDocumentation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-put_documentation))], [])
    HRESULT put_Documentation(BSTR documentation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-get_xmltext))], [])
    HRESULT get_XmlText(BSTR* pText);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-put_xmltext))], [])
    HRESULT put_XmlText(BSTR text);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-get_uri))], [])
    HRESULT get_URI(BSTR* pUri);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-put_uri))], [])
    HRESULT put_URI(BSTR uri);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-get_securitydescriptor))], [])
    HRESULT get_SecurityDescriptor(VARIANT* pSddl);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-put_securitydescriptor))], [])
    HRESULT put_SecurityDescriptor(VARIANT sddl);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-get_source))], [])
    HRESULT get_Source(BSTR* pSource);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-put_source))], [])
    HRESULT put_Source(BSTR source);
}

@GUID("f5bc8fc5-536d-4f77-b852-fbc1356fdeb6")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itaskdefinition))], [])
interface ITaskDefinition : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskdefinition-get_registrationinfo))], [])
    HRESULT get_RegistrationInfo(IRegistrationInfo* ppRegistrationInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskdefinition-put_registrationinfo))], [])
    HRESULT put_RegistrationInfo(IRegistrationInfo pRegistrationInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskdefinition-get_triggers))], [])
    HRESULT get_Triggers(ITriggerCollection* ppTriggers);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskdefinition-put_triggers))], [])
    HRESULT put_Triggers(ITriggerCollection pTriggers);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskdefinition-get_settings))], [])
    HRESULT get_Settings(ITaskSettings* ppSettings);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskdefinition-put_settings))], [])
    HRESULT put_Settings(ITaskSettings pSettings);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskdefinition-get_data))], [])
    HRESULT get_Data(BSTR* pData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskdefinition-put_data))], [])
    HRESULT put_Data(BSTR data);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskdefinition-get_principal))], [])
    HRESULT get_Principal(IPrincipal* ppPrincipal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskdefinition-put_principal))], [])
    HRESULT put_Principal(IPrincipal pPrincipal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskdefinition-get_actions))], [])
    HRESULT get_Actions(IActionCollection* ppActions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskdefinition-put_actions))], [])
    HRESULT put_Actions(IActionCollection pActions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskdefinition-get_xmltext))], [])
    HRESULT get_XmlText(BSTR* pXml);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskdefinition-put_xmltext))], [])
    HRESULT put_XmlText(BSTR xml);
}

@GUID("8fd4711d-2d02-4c8c-87e3-eff699de127e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itasksettings))], [])
interface ITaskSettings : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_allowdemandstart))], [])
    HRESULT get_AllowDemandStart(VARIANT_BOOL* pAllowDemandStart);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_allowdemandstart))], [])
    HRESULT put_AllowDemandStart(VARIANT_BOOL allowDemandStart);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_restartinterval))], [])
    HRESULT get_RestartInterval(BSTR* pRestartInterval);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_restartinterval))], [])
    HRESULT put_RestartInterval(BSTR restartInterval);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_restartcount))], [])
    HRESULT get_RestartCount(int* pRestartCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_restartcount))], [])
    HRESULT put_RestartCount(int restartCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_multipleinstances))], [])
    HRESULT get_MultipleInstances(TASK_INSTANCES_POLICY* pPolicy);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_multipleinstances))], [])
    HRESULT put_MultipleInstances(TASK_INSTANCES_POLICY policy);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_stopifgoingonbatteries))], [])
    HRESULT get_StopIfGoingOnBatteries(VARIANT_BOOL* pStopIfOnBatteries);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_stopifgoingonbatteries))], [])
    HRESULT put_StopIfGoingOnBatteries(VARIANT_BOOL stopIfOnBatteries);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_disallowstartifonbatteries))], [])
    HRESULT get_DisallowStartIfOnBatteries(VARIANT_BOOL* pDisallowStart);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_disallowstartifonbatteries))], [])
    HRESULT put_DisallowStartIfOnBatteries(VARIANT_BOOL disallowStart);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_allowhardterminate))], [])
    HRESULT get_AllowHardTerminate(VARIANT_BOOL* pAllowHardTerminate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_allowhardterminate))], [])
    HRESULT put_AllowHardTerminate(VARIANT_BOOL allowHardTerminate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_startwhenavailable))], [])
    HRESULT get_StartWhenAvailable(VARIANT_BOOL* pStartWhenAvailable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_startwhenavailable))], [])
    HRESULT put_StartWhenAvailable(VARIANT_BOOL startWhenAvailable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_xmltext))], [])
    HRESULT get_XmlText(BSTR* pText);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_xmltext))], [])
    HRESULT put_XmlText(BSTR text);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_runonlyifnetworkavailable))], [])
    HRESULT get_RunOnlyIfNetworkAvailable(VARIANT_BOOL* pRunOnlyIfNetworkAvailable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_runonlyifnetworkavailable))], [])
    HRESULT put_RunOnlyIfNetworkAvailable(VARIANT_BOOL runOnlyIfNetworkAvailable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_executiontimelimit))], [])
    HRESULT get_ExecutionTimeLimit(BSTR* pExecutionTimeLimit);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_executiontimelimit))], [])
    HRESULT put_ExecutionTimeLimit(BSTR executionTimeLimit);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_enabled))], [])
    HRESULT get_Enabled(VARIANT_BOOL* pEnabled);
    HRESULT put_Enabled(VARIANT_BOOL enabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_deleteexpiredtaskafter))], [])
    HRESULT get_DeleteExpiredTaskAfter(BSTR* pExpirationDelay);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_deleteexpiredtaskafter))], [])
    HRESULT put_DeleteExpiredTaskAfter(BSTR expirationDelay);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_priority))], [])
    HRESULT get_Priority(int* pPriority);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_priority))], [])
    HRESULT put_Priority(int priority);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_compatibility))], [])
    HRESULT get_Compatibility(TASK_COMPATIBILITY* pCompatLevel);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_compatibility))], [])
    HRESULT put_Compatibility(TASK_COMPATIBILITY compatLevel);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_hidden))], [])
    HRESULT get_Hidden(VARIANT_BOOL* pHidden);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_hidden))], [])
    HRESULT put_Hidden(VARIANT_BOOL hidden);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_idlesettings))], [])
    HRESULT get_IdleSettings(IIdleSettings* ppIdleSettings);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_idlesettings))], [])
    HRESULT put_IdleSettings(IIdleSettings pIdleSettings);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_runonlyifidle))], [])
    HRESULT get_RunOnlyIfIdle(VARIANT_BOOL* pRunOnlyIfIdle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_runonlyifidle))], [])
    HRESULT put_RunOnlyIfIdle(VARIANT_BOOL runOnlyIfIdle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_waketorun))], [])
    HRESULT get_WakeToRun(VARIANT_BOOL* pWake);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_waketorun))], [])
    HRESULT put_WakeToRun(VARIANT_BOOL wake);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_networksettings))], [])
    HRESULT get_NetworkSettings(INetworkSettings* ppNetworkSettings);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_networksettings))], [])
    HRESULT put_NetworkSettings(INetworkSettings pNetworkSettings);
}

@GUID("2c05c3f0-6eed-4c05-a15f-ed7d7a98a369")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itasksettings2))], [])
interface ITaskSettings2 : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings2-get_disallowstartonremoteappsession))], [])
    HRESULT get_DisallowStartOnRemoteAppSession(VARIANT_BOOL* pDisallowStart);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings2-put_disallowstartonremoteappsession))], [])
    HRESULT put_DisallowStartOnRemoteAppSession(VARIANT_BOOL disallowStart);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings2-get_useunifiedschedulingengine))], [])
    HRESULT get_UseUnifiedSchedulingEngine(VARIANT_BOOL* pUseUnifiedEngine);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings2-put_useunifiedschedulingengine))], [])
    HRESULT put_UseUnifiedSchedulingEngine(VARIANT_BOOL useUnifiedEngine);
}

@GUID("0ad9d0d7-0c7f-4ebb-9a5f-d1c648dca528")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itasksettings3))], [])
interface ITaskSettings3 : ITaskSettings
{
    HRESULT get_DisallowStartOnRemoteAppSession(VARIANT_BOOL* pDisallowStart);
    HRESULT put_DisallowStartOnRemoteAppSession(VARIANT_BOOL disallowStart);
    HRESULT get_UseUnifiedSchedulingEngine(VARIANT_BOOL* pUseUnifiedEngine);
    HRESULT put_UseUnifiedSchedulingEngine(VARIANT_BOOL useUnifiedEngine);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings3-get_maintenancesettings))], [])
    HRESULT get_MaintenanceSettings(IMaintenanceSettings* ppMaintenanceSettings);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings3-put_maintenancesettings))], [])
    HRESULT put_MaintenanceSettings(IMaintenanceSettings pMaintenanceSettings);
    HRESULT CreateMaintenanceSettings(IMaintenanceSettings* ppMaintenanceSettings);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings3-get_volatile))], [])
    HRESULT get_Volatile(VARIANT_BOOL* pVolatile);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings3-put_volatile))], [])
    HRESULT put_Volatile(VARIANT_BOOL Volatile);
}

@GUID("a6024fa8-9652-4adb-a6bf-5cfcd877a7ba")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-imaintenancesettings))], [])
interface IMaintenanceSettings : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imaintenancesettings-put_period))], [])
    HRESULT put_Period(BSTR value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imaintenancesettings-get_period))], [])
    HRESULT get_Period(BSTR* target);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imaintenancesettings-put_deadline))], [])
    HRESULT put_Deadline(BSTR value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imaintenancesettings-get_deadline))], [])
    HRESULT get_Deadline(BSTR* target);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imaintenancesettings-put_exclusive))], [])
    HRESULT put_Exclusive(VARIANT_BOOL value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imaintenancesettings-get_exclusive))], [])
    HRESULT get_Exclusive(VARIANT_BOOL* target);
}

@GUID("86627eb4-42a7-41e4-a4d9-ac33a72f2d52")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-iregisteredtaskcollection))], [])
interface IRegisteredTaskCollection : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtaskcollection-get_count))], [])
    HRESULT get_Count(int* pCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtaskcollection-get_item))], [])
    HRESULT get_Item(VARIANT index, IRegisteredTask* ppRegisteredTask);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtaskcollection-get__newenum))], [])
    HRESULT get__NewEnum(IUnknown* ppEnum);
}

@GUID("8cfac062-a080-4c15-9a88-aa7c2af80dfc")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itaskfolder))], [])
interface ITaskFolder : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfolder-get_name))], [])
    HRESULT get_Name(BSTR* pName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfolder-get_path))], [])
    HRESULT get_Path(BSTR* pPath);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfolder-getfolder))], [])
    HRESULT GetFolder(BSTR path, ITaskFolder* ppFolder);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfolder-getfolders))], [])
    HRESULT GetFolders(int flags, ITaskFolderCollection* ppFolders);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfolder-createfolder))], [])
    HRESULT CreateFolder(BSTR subFolderName, VARIANT sddl, ITaskFolder* ppFolder);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfolder-deletefolder))], [])
    HRESULT DeleteFolder(BSTR subFolderName, int flags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfolder-gettask))], [])
    HRESULT GetTask(BSTR path, IRegisteredTask* ppTask);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfolder-gettasks))], [])
    HRESULT GetTasks(int flags, IRegisteredTaskCollection* ppTasks);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfolder-deletetask))], [])
    HRESULT DeleteTask(BSTR name, int flags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfolder-registertask))], [])
    HRESULT RegisterTask(BSTR path, BSTR xmlText, int flags, VARIANT userId, VARIANT password, 
                         TASK_LOGON_TYPE logonType, VARIANT sddl, IRegisteredTask* ppTask);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfolder-registertaskdefinition))], [])
    HRESULT RegisterTaskDefinition(BSTR path, ITaskDefinition pDefinition, int flags, VARIANT userId, 
                                   VARIANT password, TASK_LOGON_TYPE logonType, VARIANT sddl, 
                                   IRegisteredTask* ppTask);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfolder-getsecuritydescriptor))], [])
    HRESULT GetSecurityDescriptor(int securityInformation, BSTR* pSddl);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfolder-setsecuritydescriptor))], [])
    HRESULT SetSecurityDescriptor(BSTR sddl, int flags);
}

@GUID("84594461-0053-4342-a8fd-088fabf11f32")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-iidlesettings))], [])
interface IIdleSettings : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iidlesettings-get_idleduration))], [])
    HRESULT get_IdleDuration(BSTR* pDelay);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iidlesettings-put_idleduration))], [])
    HRESULT put_IdleDuration(BSTR delay);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iidlesettings-get_waittimeout))], [])
    HRESULT get_WaitTimeout(BSTR* pTimeout);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iidlesettings-put_waittimeout))], [])
    HRESULT put_WaitTimeout(BSTR timeout);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iidlesettings-get_stoponidleend))], [])
    HRESULT get_StopOnIdleEnd(VARIANT_BOOL* pStop);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iidlesettings-put_stoponidleend))], [])
    HRESULT put_StopOnIdleEnd(VARIANT_BOOL stop);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iidlesettings-get_restartonidle))], [])
    HRESULT get_RestartOnIdle(VARIANT_BOOL* pRestart);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iidlesettings-put_restartonidle))], [])
    HRESULT put_RestartOnIdle(VARIANT_BOOL restart);
}

@GUID("9f7dea84-c30b-4245-80b6-00e9f646f1b4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-inetworksettings))], [])
interface INetworkSettings : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-inetworksettings-get_name))], [])
    HRESULT get_Name(BSTR* pName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-inetworksettings-put_name))], [])
    HRESULT put_Name(BSTR name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-inetworksettings-get_id))], [])
    HRESULT get_Id(BSTR* pId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-inetworksettings-put_id))], [])
    HRESULT put_Id(BSTR id);
}

@GUID("7fb9acf1-26be-400e-85b5-294b9c75dfd6")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-irepetitionpattern))], [])
interface IRepetitionPattern : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irepetitionpattern-get_interval))], [])
    HRESULT get_Interval(BSTR* pInterval);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irepetitionpattern-put_interval))], [])
    HRESULT put_Interval(BSTR interval);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irepetitionpattern-get_duration))], [])
    HRESULT get_Duration(BSTR* pDuration);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irepetitionpattern-put_duration))], [])
    HRESULT put_Duration(BSTR duration);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irepetitionpattern-get_stopatdurationend))], [])
    HRESULT get_StopAtDurationEnd(VARIANT_BOOL* pStop);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irepetitionpattern-put_stopatdurationend))], [])
    HRESULT put_StopAtDurationEnd(VARIANT_BOOL stop);
}


// GUIDs

const GUID CLSID_TaskHandlerPS       = GUIDOF!TaskHandlerPS;
const GUID CLSID_TaskHandlerStatusPS = GUIDOF!TaskHandlerStatusPS;
const GUID CLSID_TaskScheduler       = GUIDOF!TaskScheduler;

const GUID IID_IAction                    = GUIDOF!IAction;
const GUID IID_IActionCollection          = GUIDOF!IActionCollection;
const GUID IID_IBootTrigger               = GUIDOF!IBootTrigger;
const GUID IID_IComHandlerAction          = GUIDOF!IComHandlerAction;
const GUID IID_IDailyTrigger              = GUIDOF!IDailyTrigger;
const GUID IID_IEmailAction               = GUIDOF!IEmailAction;
const GUID IID_IEnumWorkItems             = GUIDOF!IEnumWorkItems;
const GUID IID_IEventTrigger              = GUIDOF!IEventTrigger;
const GUID IID_IExecAction                = GUIDOF!IExecAction;
const GUID IID_IExecAction2               = GUIDOF!IExecAction2;
const GUID IID_IIdleSettings              = GUIDOF!IIdleSettings;
const GUID IID_IIdleTrigger               = GUIDOF!IIdleTrigger;
const GUID IID_ILogonTrigger              = GUIDOF!ILogonTrigger;
const GUID IID_IMaintenanceSettings       = GUIDOF!IMaintenanceSettings;
const GUID IID_IMonthlyDOWTrigger         = GUIDOF!IMonthlyDOWTrigger;
const GUID IID_IMonthlyTrigger            = GUIDOF!IMonthlyTrigger;
const GUID IID_INetworkSettings           = GUIDOF!INetworkSettings;
const GUID IID_IPrincipal                 = GUIDOF!IPrincipal;
const GUID IID_IPrincipal2                = GUIDOF!IPrincipal2;
const GUID IID_IProvideTaskPage           = GUIDOF!IProvideTaskPage;
const GUID IID_IRegisteredTask            = GUIDOF!IRegisteredTask;
const GUID IID_IRegisteredTaskCollection  = GUIDOF!IRegisteredTaskCollection;
const GUID IID_IRegistrationInfo          = GUIDOF!IRegistrationInfo;
const GUID IID_IRegistrationTrigger       = GUIDOF!IRegistrationTrigger;
const GUID IID_IRepetitionPattern         = GUIDOF!IRepetitionPattern;
const GUID IID_IRunningTask               = GUIDOF!IRunningTask;
const GUID IID_IRunningTaskCollection     = GUIDOF!IRunningTaskCollection;
const GUID IID_IScheduledWorkItem         = GUIDOF!IScheduledWorkItem;
const GUID IID_ISessionStateChangeTrigger = GUIDOF!ISessionStateChangeTrigger;
const GUID IID_IShowMessageAction         = GUIDOF!IShowMessageAction;
const GUID IID_ITask                      = GUIDOF!ITask;
const GUID IID_ITaskDefinition            = GUIDOF!ITaskDefinition;
const GUID IID_ITaskFolder                = GUIDOF!ITaskFolder;
const GUID IID_ITaskFolderCollection      = GUIDOF!ITaskFolderCollection;
const GUID IID_ITaskHandler               = GUIDOF!ITaskHandler;
const GUID IID_ITaskHandlerStatus         = GUIDOF!ITaskHandlerStatus;
const GUID IID_ITaskNamedValueCollection  = GUIDOF!ITaskNamedValueCollection;
const GUID IID_ITaskNamedValuePair        = GUIDOF!ITaskNamedValuePair;
const GUID IID_ITaskScheduler             = GUIDOF!ITaskScheduler;
const GUID IID_ITaskService               = GUIDOF!ITaskService;
const GUID IID_ITaskSettings              = GUIDOF!ITaskSettings;
const GUID IID_ITaskSettings2             = GUIDOF!ITaskSettings2;
const GUID IID_ITaskSettings3             = GUIDOF!ITaskSettings3;
const GUID IID_ITaskTrigger               = GUIDOF!ITaskTrigger;
const GUID IID_ITaskVariables             = GUIDOF!ITaskVariables;
const GUID IID_ITimeTrigger               = GUIDOF!ITimeTrigger;
const GUID IID_ITrigger                   = GUIDOF!ITrigger;
const GUID IID_ITriggerCollection         = GUIDOF!ITriggerCollection;
const GUID IID_IWeeklyTrigger             = GUIDOF!IWeeklyTrigger;
