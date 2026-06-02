// Written in the D programming language.

module windows.win32.system.taskscheduler;

public import windows.core;
public import windows.win32.foundation : BOOL, BSTR, HRESULT, HWND, PWSTR, SYSTEMTIME,
                                         VARIANT_BOOL;
public import windows.win32.system.com : IDispatch, IUnknown, SAFEARRAY;
public import windows.win32.system.variant : VARIANT;
public import windows.win32.ui.controls : HPROPSHEETPAGE;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/ne-mstask-task_trigger_type
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/ne-mstask-taskpage
alias TASKPAGE = int;
enum : int
{
    TASKPAGE_TASK     = 0x00000000,
    TASKPAGE_SCHEDULE = 0x00000001,
    TASKPAGE_SETTINGS = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/ne-taskschd-task_run_flags
alias TASK_RUN_FLAGS = int;
enum : int
{
    TASK_RUN_NO_FLAGS           = 0x00000000,
    TASK_RUN_AS_SELF            = 0x00000001,
    TASK_RUN_IGNORE_CONSTRAINTS = 0x00000002,
    TASK_RUN_USE_SESSION_ID     = 0x00000004,
    TASK_RUN_USER_SID           = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/ne-taskschd-task_enum_flags
alias TASK_ENUM_FLAGS = int;
enum : int
{
    TASK_ENUM_HIDDEN = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/ne-taskschd-task_logon_type
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/ne-taskschd-task_runlevel_type
alias TASK_RUNLEVEL_TYPE = int;
enum : int
{
    TASK_RUNLEVEL_LUA     = 0x00000000,
    TASK_RUNLEVEL_HIGHEST = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/ne-taskschd-task_processtokensid_type
alias TASK_PROCESSTOKENSID_TYPE = int;
enum : int
{
    TASK_PROCESSTOKENSID_NONE         = 0x00000000,
    TASK_PROCESSTOKENSID_UNRESTRICTED = 0x00000001,
    TASK_PROCESSTOKENSID_DEFAULT      = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/ne-taskschd-task_state
alias TASK_STATE = int;
enum : int
{
    TASK_STATE_UNKNOWN  = 0x00000000,
    TASK_STATE_DISABLED = 0x00000001,
    TASK_STATE_QUEUED   = 0x00000002,
    TASK_STATE_READY    = 0x00000003,
    TASK_STATE_RUNNING  = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/ne-taskschd-task_creation
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/ne-taskschd-task_trigger_type2
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/ne-taskschd-task_session_state_change_type
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/ne-taskschd-task_action_type
alias TASK_ACTION_TYPE = int;
enum : int
{
    TASK_ACTION_EXEC         = 0x00000000,
    TASK_ACTION_COM_HANDLER  = 0x00000005,
    TASK_ACTION_SEND_EMAIL   = 0x00000006,
    TASK_ACTION_SHOW_MESSAGE = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/ne-taskschd-task_instances_policy
alias TASK_INSTANCES_POLICY = int;
enum : int
{
    TASK_INSTANCES_PARALLEL      = 0x00000000,
    TASK_INSTANCES_QUEUE         = 0x00000001,
    TASK_INSTANCES_IGNORE_NEW    = 0x00000002,
    TASK_INSTANCES_STOP_EXISTING = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/ne-taskschd-task_compatibility
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
    TASK_SUNDAY    = 0x00000001U,
    TASK_MONDAY    = 0x00000002U,
    TASK_TUESDAY   = 0x00000004U,
    TASK_WEDNESDAY = 0x00000008U,
}

enum uint TASK_THURSDAY = 0x00000010U;

enum : uint
{
    TASK_FRIDAY   = 0x00000020U,
    TASK_SATURDAY = 0x00000040U,
}

enum uint TASK_FIRST_WEEK = 0x00000001U;
enum uint TASK_SECOND_WEEK = 0x00000002U;
enum uint TASK_THIRD_WEEK = 0x00000003U;
enum uint TASK_FOURTH_WEEK = 0x00000004U;
enum uint TASK_LAST_WEEK = 0x00000005U;

enum : uint
{
    TASK_JANUARY  = 0x00000001U,
    TASK_FEBRUARY = 0x00000002U,
}

enum : uint
{
    TASK_MARCH     = 0x00000004U,
    TASK_APRIL     = 0x00000008U,
    TASK_MAY       = 0x00000010U,
    TASK_JUNE      = 0x00000020U,
    TASK_JULY      = 0x00000040U,
    TASK_AUGUST    = 0x00000080U,
    TASK_SEPTEMBER = 0x00000100U,
}

enum : uint
{
    TASK_OCTOBER  = 0x00000200U,
    TASK_NOVEMBER = 0x00000400U,
}

enum uint TASK_DECEMBER = 0x00000800U;

enum : uint
{
    TASK_FLAG_INTERACTIVE        = 0x00000001U,
    TASK_FLAG_DELETE_WHEN_DONE   = 0x00000002U,
    TASK_FLAG_DISABLED           = 0x00000004U,
    TASK_FLAG_START_ONLY_IF_IDLE = 0x00000010U,
}

enum uint TASK_FLAG_KILL_ON_IDLE_END = 0x00000020U;
enum uint TASK_FLAG_DONT_START_IF_ON_BATTERIES = 0x00000040U;
enum uint TASK_FLAG_KILL_IF_GOING_ON_BATTERIES = 0x00000080U;
enum uint TASK_FLAG_RUN_ONLY_IF_DOCKED = 0x00000100U;

enum : uint
{
    TASK_FLAG_HIDDEN                       = 0x00000200U,
    TASK_FLAG_RUN_IF_CONNECTED_TO_INTERNET = 0x00000400U,
}

enum uint TASK_FLAG_RESTART_ON_IDLE_RESUME = 0x00000800U;
enum uint TASK_FLAG_SYSTEM_REQUIRED = 0x00001000U;
enum uint TASK_FLAG_RUN_ONLY_IF_LOGGED_ON = 0x00002000U;

enum : uint
{
    TASK_TRIGGER_FLAG_HAS_END_DATE         = 0x00000001U,
    TASK_TRIGGER_FLAG_KILL_AT_DURATION_END = 0x00000002U,
    TASK_TRIGGER_FLAG_DISABLED             = 0x00000004U,
}

enum uint TASK_MAX_RUN_TIMES = 0x000005a0U;

enum : GUID
{
    CLSID_CTask          = GUID("148bd520-a2ab-11ce-b11f-00aa00530503"),
    CLSID_CTaskScheduler = GUID("148bd52a-a2ab-11ce-b11f-00aa00530503"),
}

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/ns-mstask-daily
struct DAILY
{
    ushort DaysInterval;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/ns-mstask-weekly
struct WEEKLY
{
    ushort WeeksInterval;
    ushort rgfDaysOfTheWeek;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/ns-mstask-monthlydate
struct MONTHLYDATE
{
    uint   rgfDays;
    ushort rgfMonths;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/ns-mstask-monthlydow
struct MONTHLYDOW
{
    ushort wWhichWeek;
    ushort rgfDaysOfTheWeek;
    ushort rgfMonths;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/ns-mstask-trigger_type_union
union TRIGGER_TYPE_UNION
{
    DAILY       Daily;
    WEEKLY      Weekly;
    MONTHLYDATE MonthlyDate;
    MONTHLYDOW  MonthlyDOW;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/ns-mstask-task_trigger
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

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nn-mstask-itasktrigger
@GUID("148bd52b-a2ab-11ce-b11f-00aa00530503")
interface ITaskTrigger : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itasktrigger-settrigger
    HRESULT SetTrigger(const(TASK_TRIGGER)* pTrigger);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itasktrigger-gettrigger
    HRESULT GetTrigger(TASK_TRIGGER* pTrigger);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itasktrigger-gettriggerstring
    HRESULT GetTriggerString(PWSTR* ppwszTrigger);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nn-mstask-ischeduledworkitem
@GUID("a6b952f0-a4b1-11d0-997d-00aa006887ec")
interface IScheduledWorkItem : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-createtrigger
    HRESULT CreateTrigger(ushort* piNewTrigger, ITaskTrigger* ppTrigger);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-deletetrigger
    HRESULT DeleteTrigger(ushort iTrigger);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-gettriggercount
    HRESULT GetTriggerCount(ushort* pwCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-gettrigger
    HRESULT GetTrigger(ushort iTrigger, ITaskTrigger* ppTrigger);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-gettriggerstring
    HRESULT GetTriggerString(ushort iTrigger, PWSTR* ppwszTrigger);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-getruntimes
    HRESULT GetRunTimes(const(SYSTEMTIME)* pstBegin, const(SYSTEMTIME)* pstEnd, ushort* pCount, 
                        SYSTEMTIME** rgstTaskTimes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-getnextruntime
    HRESULT GetNextRunTime(SYSTEMTIME* pstNextRun);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-setidlewait
    HRESULT SetIdleWait(ushort wIdleMinutes, ushort wDeadlineMinutes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-getidlewait
    HRESULT GetIdleWait(ushort* pwIdleMinutes, ushort* pwDeadlineMinutes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-run
    HRESULT Run();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-terminate
    HRESULT Terminate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-editworkitem
    HRESULT EditWorkItem(HWND hParent, uint dwReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-getmostrecentruntime
    HRESULT GetMostRecentRunTime(SYSTEMTIME* pstLastRun);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-getstatus
    HRESULT GetStatus(HRESULT* phrStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-getexitcode
    HRESULT GetExitCode(uint* pdwExitCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-setcomment
    HRESULT SetComment(const(PWSTR) pwszComment);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-getcomment
    HRESULT GetComment(PWSTR* ppwszComment);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-setcreator
    HRESULT SetCreator(const(PWSTR) pwszCreator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-getcreator
    HRESULT GetCreator(PWSTR* ppwszCreator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-setworkitemdata
    HRESULT SetWorkItemData(ushort cbData, ubyte* rgbData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-getworkitemdata
    HRESULT GetWorkItemData(ushort* pcbData, ubyte** prgbData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-seterrorretrycount
    HRESULT SetErrorRetryCount(ushort wRetryCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-geterrorretrycount
    HRESULT GetErrorRetryCount(ushort* pwRetryCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-seterrorretryinterval
    HRESULT SetErrorRetryInterval(ushort wRetryInterval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-geterrorretryinterval
    HRESULT GetErrorRetryInterval(ushort* pwRetryInterval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-setflags
    HRESULT SetFlags(uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-getflags
    HRESULT GetFlags(uint* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-setaccountinformation
    HRESULT SetAccountInformation(const(PWSTR) pwszAccountName, const(PWSTR) pwszPassword);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ischeduledworkitem-getaccountinformation
    HRESULT GetAccountInformation(PWSTR* ppwszAccountName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nn-mstask-itask
@GUID("148bd524-a2ab-11ce-b11f-00aa00530503")
interface ITask : IScheduledWorkItem
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itask-setapplicationname
    HRESULT SetApplicationName(const(PWSTR) pwszApplicationName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itask-getapplicationname
    HRESULT GetApplicationName(PWSTR* ppwszApplicationName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itask-setparameters
    HRESULT SetParameters(const(PWSTR) pwszParameters);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itask-getparameters
    HRESULT GetParameters(PWSTR* ppwszParameters);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itask-setworkingdirectory
    HRESULT SetWorkingDirectory(const(PWSTR) pwszWorkingDirectory);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itask-getworkingdirectory
    HRESULT GetWorkingDirectory(PWSTR* ppwszWorkingDirectory);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itask-setpriority
    HRESULT SetPriority(uint dwPriority);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itask-getpriority
    HRESULT GetPriority(uint* pdwPriority);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itask-settaskflags
    HRESULT SetTaskFlags(uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itask-gettaskflags
    HRESULT GetTaskFlags(uint* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itask-setmaxruntime
    HRESULT SetMaxRunTime(uint dwMaxRunTimeMS);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itask-getmaxruntime
    HRESULT GetMaxRunTime(uint* pdwMaxRunTimeMS);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nn-mstask-ienumworkitems
@GUID("148bd528-a2ab-11ce-b11f-00aa00530503")
interface IEnumWorkItems : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Next(uint celt, PWSTR** rgpwszNames, uint* pceltFetched);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ienumworkitems-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-ienumworkitems-clone
    HRESULT Clone(IEnumWorkItems* ppEnumWorkItems);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nn-mstask-itaskscheduler
@GUID("148bd527-a2ab-11ce-b11f-00aa00530503")
interface ITaskScheduler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itaskscheduler-settargetcomputer
    HRESULT SetTargetComputer(const(PWSTR) pwszComputer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itaskscheduler-gettargetcomputer
    HRESULT GetTargetComputer(PWSTR* ppwszComputer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itaskscheduler-enum
    HRESULT Enum(IEnumWorkItems* ppEnumWorkItems);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itaskscheduler-activate
    HRESULT Activate(const(PWSTR) pwszName, const(GUID)* riid, IUnknown* ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itaskscheduler-delete
    HRESULT Delete(const(PWSTR) pwszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itaskscheduler-newworkitem
    HRESULT NewWorkItem(const(PWSTR) pwszTaskName, const(GUID)* rclsid, const(GUID)* riid, IUnknown* ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itaskscheduler-addworkitem
    HRESULT AddWorkItem(const(PWSTR) pwszTaskName, IScheduledWorkItem pWorkItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-itaskscheduler-isoftype
    HRESULT IsOfType(const(PWSTR) pwszName, const(GUID)* riid);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nn-mstask-iprovidetaskpage
@GUID("4086658a-cbbb-11cf-b604-00c04fd8d565")
interface IProvideTaskPage : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstask/nf-mstask-iprovidetaskpage-getpage
    HRESULT GetPage(TASKPAGE tpType, BOOL fPersistChanges, HPROPSHEETPAGE* phPage);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itaskfoldercollection
@GUID("79184a66-8664-423f-97f1-637356a5d812")
interface ITaskFolderCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfoldercollection-get_count
    HRESULT get_Count(int* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfoldercollection-get_item
    HRESULT get_Item(VARIANT index, ITaskFolder* ppFolder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfoldercollection-get__newenum
    HRESULT get__NewEnum(IUnknown* ppEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itaskservice
@GUID("2faba4c7-4da9-4013-9697-20cc3fd40f85")
interface ITaskService : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskservice-getfolder
    HRESULT GetFolder(BSTR path, ITaskFolder* ppFolder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskservice-getrunningtasks
    HRESULT GetRunningTasks(int flags, IRunningTaskCollection* ppRunningTasks);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskservice-newtask
    HRESULT NewTask(uint flags, ITaskDefinition* ppDefinition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskservice-connect
    HRESULT Connect(VARIANT serverName, VARIANT user, VARIANT domain, VARIANT password);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskservice-get_connected
    HRESULT get_Connected(VARIANT_BOOL* pConnected);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskservice-get_targetserver
    HRESULT get_TargetServer(BSTR* pServer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskservice-get_connecteduser
    HRESULT get_ConnectedUser(BSTR* pUser);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskservice-get_connecteddomain
    HRESULT get_ConnectedDomain(BSTR* pDomain);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskservice-get_highestversion
    HRESULT get_HighestVersion(uint* pVersion);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itaskhandler
@GUID("839d7762-5121-4009-9234-4f0d19394f04")
interface ITaskHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskhandler-start
    HRESULT Start(IUnknown pHandlerServices, BSTR data);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskhandler-stop
    HRESULT Stop(HRESULT* pRetCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskhandler-pause
    HRESULT Pause();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskhandler-resume
    HRESULT Resume();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itaskhandlerstatus
@GUID("eaec7a8f-27a0-4ddc-8675-14726a01a38a")
interface ITaskHandlerStatus : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskhandlerstatus-updatestatus
    HRESULT UpdateStatus(short percentComplete, BSTR statusMessage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskhandlerstatus-taskcompleted
    HRESULT TaskCompleted(HRESULT taskErrCode);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itaskvariables
@GUID("3e4c9351-d966-4b8b-bb87-ceba68bb0107")
interface ITaskVariables : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskvariables-getinput
    HRESULT GetInput(BSTR* pInput);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskvariables-setoutput
    HRESULT SetOutput(BSTR input);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskvariables-getcontext
    HRESULT GetContext(BSTR* pContext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itasknamedvaluepair
@GUID("39038068-2b46-4afd-8662-7bb6f868d221")
interface ITaskNamedValuePair : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasknamedvaluepair-get_name
    HRESULT get_Name(BSTR* pName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasknamedvaluepair-put_name
    HRESULT put_Name(BSTR name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasknamedvaluepair-get_value
    HRESULT get_Value(BSTR* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasknamedvaluepair-put_value
    HRESULT put_Value(BSTR value);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itasknamedvaluecollection
@GUID("b4ef826b-63c3-46e4-a504-ef69e4f7ea4d")
interface ITaskNamedValueCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasknamedvaluecollection-get_count
    HRESULT get_Count(int* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasknamedvaluecollection-get_item
    HRESULT get_Item(int index, ITaskNamedValuePair* ppPair);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasknamedvaluecollection-get__newenum
    HRESULT get__NewEnum(IUnknown* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasknamedvaluecollection-create
    HRESULT Create(BSTR name, BSTR value, ITaskNamedValuePair* ppPair);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasknamedvaluecollection-remove
    HRESULT Remove(int index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasknamedvaluecollection-clear
    HRESULT Clear();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-irunningtask
@GUID("653758fb-7b9a-4f1e-a471-beeb8e9b834e")
interface IRunningTask : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irunningtask-get_name
    HRESULT get_Name(BSTR* pName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irunningtask-get_instanceguid
    HRESULT get_InstanceGuid(BSTR* pGuid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irunningtask-get_path
    HRESULT get_Path(BSTR* pPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irunningtask-get_state
    HRESULT get_State(TASK_STATE* pState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irunningtask-get_currentaction
    HRESULT get_CurrentAction(BSTR* pName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irunningtask-stop
    HRESULT Stop();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irunningtask-refresh
    HRESULT Refresh();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irunningtask-get_enginepid
    HRESULT get_EnginePID(uint* pPID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-irunningtaskcollection
@GUID("6a67614b-6828-4fec-aa54-6d52e8f1f2db")
interface IRunningTaskCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irunningtaskcollection-get_count
    HRESULT get_Count(int* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irunningtaskcollection-get_item
    HRESULT get_Item(VARIANT index, IRunningTask* ppRunningTask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irunningtaskcollection-get__newenum
    HRESULT get__NewEnum(IUnknown* ppEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-iregisteredtask
@GUID("9c86f320-dee3-4dd1-b972-a303f26b061e")
interface IRegisteredTask : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-get_name
    HRESULT get_Name(BSTR* pName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-get_path
    HRESULT get_Path(BSTR* pPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-get_state
    HRESULT get_State(TASK_STATE* pState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-get_enabled
    HRESULT get_Enabled(VARIANT_BOOL* pEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-put_enabled
    HRESULT put_Enabled(VARIANT_BOOL enabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-run
    HRESULT Run(VARIANT params, IRunningTask* ppRunningTask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-runex
    HRESULT RunEx(VARIANT params, int flags, int sessionID, BSTR user, IRunningTask* ppRunningTask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-getinstances
    HRESULT GetInstances(int flags, IRunningTaskCollection* ppRunningTasks);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-get_lastruntime
    HRESULT get_LastRunTime(double* pLastRunTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-get_lasttaskresult
    HRESULT get_LastTaskResult(int* pLastTaskResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-get_numberofmissedruns
    HRESULT get_NumberOfMissedRuns(int* pNumberOfMissedRuns);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-get_nextruntime
    HRESULT get_NextRunTime(double* pNextRunTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-get_definition
    HRESULT get_Definition(ITaskDefinition* ppDefinition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-get_xml
    HRESULT get_Xml(BSTR* pXml);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-getsecuritydescriptor
    HRESULT GetSecurityDescriptor(int securityInformation, BSTR* pSddl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-setsecuritydescriptor
    HRESULT SetSecurityDescriptor(BSTR sddl, int flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-stop
    HRESULT Stop(int flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtask-getruntimes
    HRESULT GetRunTimes(const(SYSTEMTIME)* pstStart, const(SYSTEMTIME)* pstEnd, uint* pCount, 
                        SYSTEMTIME** pRunTimes);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itrigger
@GUID("09941815-ea89-4b5b-89e0-2a773801fac3")
interface ITrigger : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itrigger-get_type
    HRESULT get_Type(TASK_TRIGGER_TYPE2* pType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itrigger-get_id
    HRESULT get_Id(BSTR* pId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itrigger-put_id
    HRESULT put_Id(BSTR id);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itrigger-get_repetition
    HRESULT get_Repetition(IRepetitionPattern* ppRepeat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itrigger-put_repetition
    HRESULT put_Repetition(IRepetitionPattern pRepeat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itrigger-get_executiontimelimit
    HRESULT get_ExecutionTimeLimit(BSTR* pTimeLimit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itrigger-put_executiontimelimit
    HRESULT put_ExecutionTimeLimit(BSTR timelimit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itrigger-get_startboundary
    HRESULT get_StartBoundary(BSTR* pStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itrigger-put_startboundary
    HRESULT put_StartBoundary(BSTR start);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itrigger-get_endboundary
    HRESULT get_EndBoundary(BSTR* pEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itrigger-put_endboundary
    HRESULT put_EndBoundary(BSTR end);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itrigger-get_enabled
    HRESULT get_Enabled(VARIANT_BOOL* pEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itrigger-put_enabled
    HRESULT put_Enabled(VARIANT_BOOL enabled);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-iidletrigger
@GUID("d537d2b0-9fb3-4d34-9739-1ff5ce7b1ef3")
interface IIdleTrigger : ITrigger
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-ilogontrigger
@GUID("72dade38-fae4-4b3e-baf4-5d009af02b1c")
interface ILogonTrigger : ITrigger
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-ilogontrigger-get_delay
    HRESULT get_Delay(BSTR* pDelay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-ilogontrigger-put_delay
    HRESULT put_Delay(BSTR delay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-ilogontrigger-get_userid
    HRESULT get_UserId(BSTR* pUser);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-ilogontrigger-put_userid
    HRESULT put_UserId(BSTR user);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-isessionstatechangetrigger
@GUID("754da71b-4385-4475-9dd9-598294fa3641")
interface ISessionStateChangeTrigger : ITrigger
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-isessionstatechangetrigger-get_delay
    HRESULT get_Delay(BSTR* pDelay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-isessionstatechangetrigger-put_delay
    HRESULT put_Delay(BSTR delay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-isessionstatechangetrigger-get_userid
    HRESULT get_UserId(BSTR* pUser);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-isessionstatechangetrigger-put_userid
    HRESULT put_UserId(BSTR user);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-isessionstatechangetrigger-get_statechange
    HRESULT get_StateChange(TASK_SESSION_STATE_CHANGE_TYPE* pType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-isessionstatechangetrigger-put_statechange
    HRESULT put_StateChange(TASK_SESSION_STATE_CHANGE_TYPE type);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-ieventtrigger
@GUID("d45b0167-9653-4eef-b94f-0732ca7af251")
interface IEventTrigger : ITrigger
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-ieventtrigger-get_subscription
    HRESULT get_Subscription(BSTR* pQuery);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-ieventtrigger-put_subscription
    HRESULT put_Subscription(BSTR query);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-ieventtrigger-get_delay
    HRESULT get_Delay(BSTR* pDelay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-ieventtrigger-put_delay
    HRESULT put_Delay(BSTR delay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-ieventtrigger-get_valuequeries
    HRESULT get_ValueQueries(ITaskNamedValueCollection* ppNamedXPaths);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-ieventtrigger-put_valuequeries
    HRESULT put_ValueQueries(ITaskNamedValueCollection pNamedXPaths);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itimetrigger
@GUID("b45747e0-eba7-4276-9f29-85c5bb300006")
interface ITimeTrigger : ITrigger
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itimetrigger-get_randomdelay
    HRESULT get_RandomDelay(BSTR* pRandomDelay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itimetrigger-put_randomdelay
    HRESULT put_RandomDelay(BSTR randomDelay);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-idailytrigger
@GUID("126c5cd8-b288-41d5-8dbf-e491446adc5c")
interface IDailyTrigger : ITrigger
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-idailytrigger-get_daysinterval
    HRESULT get_DaysInterval(short* pDays);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-idailytrigger-put_daysinterval
    HRESULT put_DaysInterval(short days);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-idailytrigger-get_randomdelay
    HRESULT get_RandomDelay(BSTR* pRandomDelay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-idailytrigger-put_randomdelay
    HRESULT put_RandomDelay(BSTR randomDelay);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-iweeklytrigger
@GUID("5038fc98-82ff-436d-8728-a512a57c9dc1")
interface IWeeklyTrigger : ITrigger
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iweeklytrigger-get_daysofweek
    HRESULT get_DaysOfWeek(short* pDays);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iweeklytrigger-put_daysofweek
    HRESULT put_DaysOfWeek(short days);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iweeklytrigger-get_weeksinterval
    HRESULT get_WeeksInterval(short* pWeeks);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iweeklytrigger-put_weeksinterval
    HRESULT put_WeeksInterval(short weeks);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iweeklytrigger-get_randomdelay
    HRESULT get_RandomDelay(BSTR* pRandomDelay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iweeklytrigger-put_randomdelay
    HRESULT put_RandomDelay(BSTR randomDelay);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-imonthlytrigger
@GUID("97c45ef1-6b02-4a1a-9c0e-1ebfba1500ac")
interface IMonthlyTrigger : ITrigger
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlytrigger-get_daysofmonth
    HRESULT get_DaysOfMonth(int* pDays);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlytrigger-put_daysofmonth
    HRESULT put_DaysOfMonth(int days);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlytrigger-get_monthsofyear
    HRESULT get_MonthsOfYear(short* pMonths);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlytrigger-put_monthsofyear
    HRESULT put_MonthsOfYear(short months);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlytrigger-get_runonlastdayofmonth
    HRESULT get_RunOnLastDayOfMonth(VARIANT_BOOL* pLastDay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlytrigger-put_runonlastdayofmonth
    HRESULT put_RunOnLastDayOfMonth(VARIANT_BOOL lastDay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlytrigger-get_randomdelay
    HRESULT get_RandomDelay(BSTR* pRandomDelay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlytrigger-put_randomdelay
    HRESULT put_RandomDelay(BSTR randomDelay);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-imonthlydowtrigger
@GUID("77d025a3-90fa-43aa-b52e-cda5499b946a")
interface IMonthlyDOWTrigger : ITrigger
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlydowtrigger-get_daysofweek
    HRESULT get_DaysOfWeek(short* pDays);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlydowtrigger-put_daysofweek
    HRESULT put_DaysOfWeek(short days);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlydowtrigger-get_weeksofmonth
    HRESULT get_WeeksOfMonth(short* pWeeks);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlydowtrigger-put_weeksofmonth
    HRESULT put_WeeksOfMonth(short weeks);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlydowtrigger-get_monthsofyear
    HRESULT get_MonthsOfYear(short* pMonths);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlydowtrigger-put_monthsofyear
    HRESULT put_MonthsOfYear(short months);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlydowtrigger-get_runonlastweekofmonth
    HRESULT get_RunOnLastWeekOfMonth(VARIANT_BOOL* pLastWeek);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlydowtrigger-put_runonlastweekofmonth
    HRESULT put_RunOnLastWeekOfMonth(VARIANT_BOOL lastWeek);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlydowtrigger-get_randomdelay
    HRESULT get_RandomDelay(BSTR* pRandomDelay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imonthlydowtrigger-put_randomdelay
    HRESULT put_RandomDelay(BSTR randomDelay);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-iboottrigger
@GUID("2a9c35da-d357-41f4-bbc1-207ac1b1f3cb")
interface IBootTrigger : ITrigger
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iboottrigger-get_delay
    HRESULT get_Delay(BSTR* pDelay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iboottrigger-put_delay
    HRESULT put_Delay(BSTR delay);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-iregistrationtrigger
@GUID("4c8fec3a-c218-4e0c-b23d-629024db91a2")
interface IRegistrationTrigger : ITrigger
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationtrigger-get_delay
    HRESULT get_Delay(BSTR* pDelay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationtrigger-put_delay
    HRESULT put_Delay(BSTR delay);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-iaction
@GUID("bae54997-48b1-4cbe-9965-d6be263ebea4")
interface IAction : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iaction-get_id
    HRESULT get_Id(BSTR* pId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iaction-put_id
    HRESULT put_Id(BSTR Id);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iaction-get_type
    HRESULT get_Type(TASK_ACTION_TYPE* pType);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-iexecaction
@GUID("4c3d624d-fd6b-49a3-b9b7-09cb3cd3f047")
interface IExecAction : IAction
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iexecaction-get_path
    HRESULT get_Path(BSTR* pPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iexecaction-put_path
    HRESULT put_Path(BSTR path);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iexecaction-get_arguments
    HRESULT get_Arguments(BSTR* pArgument);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iexecaction-put_arguments
    HRESULT put_Arguments(BSTR argument);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iexecaction-get_workingdirectory
    HRESULT get_WorkingDirectory(BSTR* pWorkingDirectory);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iexecaction-put_workingdirectory
    HRESULT put_WorkingDirectory(BSTR workingDirectory);
}

@GUID("f2a82542-bda5-4e6b-9143-e2bf4f8987b6")
interface IExecAction2 : IExecAction
{
    HRESULT get_HideAppWindow(VARIANT_BOOL* pHideAppWindow);
    HRESULT put_HideAppWindow(VARIANT_BOOL hideAppWindow);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-ishowmessageaction
@GUID("505e9e68-af89-46b8-a30f-56162a83d537")
interface IShowMessageAction : IAction
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-ishowmessageaction-get_title
    HRESULT get_Title(BSTR* pTitle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-ishowmessageaction-put_title
    HRESULT put_Title(BSTR title);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-ishowmessageaction-get_messagebody
    HRESULT get_MessageBody(BSTR* pMessageBody);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-ishowmessageaction-put_messagebody
    HRESULT put_MessageBody(BSTR messageBody);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-icomhandleraction
@GUID("6d2fd252-75c5-4f66-90ba-2a7d8cc3039f")
interface IComHandlerAction : IAction
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-icomhandleraction-get_classid
    HRESULT get_ClassId(BSTR* pClsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-icomhandleraction-put_classid
    HRESULT put_ClassId(BSTR clsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-icomhandleraction-get_data
    HRESULT get_Data(BSTR* pData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-icomhandleraction-put_data
    HRESULT put_Data(BSTR data);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-iemailaction
@GUID("10f62c64-7e16-4314-a0c2-0c3683f99d40")
interface IEmailAction : IAction
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-get_server
    HRESULT get_Server(BSTR* pServer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-put_server
    HRESULT put_Server(BSTR server);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-get_subject
    HRESULT get_Subject(BSTR* pSubject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-put_subject
    HRESULT put_Subject(BSTR subject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-get_to
    HRESULT get_To(BSTR* pTo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-put_to
    HRESULT put_To(BSTR to);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-get_cc
    HRESULT get_Cc(BSTR* pCc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-put_cc
    HRESULT put_Cc(BSTR cc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-get_bcc
    HRESULT get_Bcc(BSTR* pBcc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-put_bcc
    HRESULT put_Bcc(BSTR bcc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-get_replyto
    HRESULT get_ReplyTo(BSTR* pReplyTo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-put_replyto
    HRESULT put_ReplyTo(BSTR replyTo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-get_from
    HRESULT get_From(BSTR* pFrom);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-put_from
    HRESULT put_From(BSTR from);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-get_headerfields
    HRESULT get_HeaderFields(ITaskNamedValueCollection* ppHeaderFields);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-put_headerfields
    HRESULT put_HeaderFields(ITaskNamedValueCollection pHeaderFields);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-get_body
    HRESULT get_Body(BSTR* pBody);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-put_body
    HRESULT put_Body(BSTR body_);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-get_attachments
    HRESULT get_Attachments(SAFEARRAY** pAttachements);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iemailaction-put_attachments
    HRESULT put_Attachments(SAFEARRAY* pAttachements);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itriggercollection
@GUID("85df5081-1b24-4f32-878a-d9d14df4cb77")
interface ITriggerCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itriggercollection-get_count
    HRESULT get_Count(int* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itriggercollection-get_item
    HRESULT get_Item(int index, ITrigger* ppTrigger);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itriggercollection-get__newenum
    HRESULT get__NewEnum(IUnknown* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itriggercollection-create
    HRESULT Create(TASK_TRIGGER_TYPE2 type, ITrigger* ppTrigger);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itriggercollection-remove
    HRESULT Remove(VARIANT index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itriggercollection-clear
    HRESULT Clear();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-iactioncollection
@GUID("02820e19-7b98-4ed2-b2e8-fdccceff619b")
interface IActionCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iactioncollection-get_count
    HRESULT get_Count(int* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iactioncollection-get_item
    HRESULT get_Item(int index, IAction* ppAction);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iactioncollection-get__newenum
    HRESULT get__NewEnum(IUnknown* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iactioncollection-get_xmltext
    HRESULT get_XmlText(BSTR* pText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iactioncollection-put_xmltext
    HRESULT put_XmlText(BSTR text);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iactioncollection-create
    HRESULT Create(TASK_ACTION_TYPE type, IAction* ppAction);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iactioncollection-remove
    HRESULT Remove(VARIANT index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iactioncollection-clear
    HRESULT Clear();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iactioncollection-get_context
    HRESULT get_Context(BSTR* pContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iactioncollection-put_context
    HRESULT put_Context(BSTR context);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-iprincipal
@GUID("d98d51e5-c9b4-496a-a9c1-18980261cf0f")
interface IPrincipal : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal-get_id
    HRESULT get_Id(BSTR* pId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal-put_id
    HRESULT put_Id(BSTR Id);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal-get_displayname
    HRESULT get_DisplayName(BSTR* pName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal-put_displayname
    HRESULT put_DisplayName(BSTR name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal-get_userid
    HRESULT get_UserId(BSTR* pUser);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal-put_userid
    HRESULT put_UserId(BSTR user);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal-get_logontype
    HRESULT get_LogonType(TASK_LOGON_TYPE* pLogon);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal-put_logontype
    HRESULT put_LogonType(TASK_LOGON_TYPE logon);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal-get_groupid
    HRESULT get_GroupId(BSTR* pGroup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal-put_groupid
    HRESULT put_GroupId(BSTR group);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal-get_runlevel
    HRESULT get_RunLevel(TASK_RUNLEVEL_TYPE* pRunLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal-put_runlevel
    HRESULT put_RunLevel(TASK_RUNLEVEL_TYPE runLevel);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-iprincipal2
@GUID("248919ae-e345-4a6d-8aeb-e0d3165c904e")
interface IPrincipal2 : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal2-get_processtokensidtype
    HRESULT get_ProcessTokenSidType(TASK_PROCESSTOKENSID_TYPE* pProcessTokenSidType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal2-put_processtokensidtype
    HRESULT put_ProcessTokenSidType(TASK_PROCESSTOKENSID_TYPE processTokenSidType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal2-get_requiredprivilegecount
    HRESULT get_RequiredPrivilegeCount(int* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal2-get_requiredprivilege
    HRESULT get_RequiredPrivilege(int index, BSTR* pPrivilege);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iprincipal2-addrequiredprivilege
    HRESULT AddRequiredPrivilege(BSTR privilege);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-iregistrationinfo
@GUID("416d8b73-cb41-4ea1-805c-9be9a5ac4a74")
interface IRegistrationInfo : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-get_description
    HRESULT get_Description(BSTR* pDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-put_description
    HRESULT put_Description(BSTR description);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-get_author
    HRESULT get_Author(BSTR* pAuthor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-put_author
    HRESULT put_Author(BSTR author);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-get_version
    HRESULT get_Version(BSTR* pVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-put_version
    HRESULT put_Version(BSTR version_);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-get_date
    HRESULT get_Date(BSTR* pDate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-put_date
    HRESULT put_Date(BSTR date);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-get_documentation
    HRESULT get_Documentation(BSTR* pDocumentation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-put_documentation
    HRESULT put_Documentation(BSTR documentation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-get_xmltext
    HRESULT get_XmlText(BSTR* pText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-put_xmltext
    HRESULT put_XmlText(BSTR text);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-get_uri
    HRESULT get_URI(BSTR* pUri);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-put_uri
    HRESULT put_URI(BSTR uri);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-get_securitydescriptor
    HRESULT get_SecurityDescriptor(VARIANT* pSddl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-put_securitydescriptor
    HRESULT put_SecurityDescriptor(VARIANT sddl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-get_source
    HRESULT get_Source(BSTR* pSource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregistrationinfo-put_source
    HRESULT put_Source(BSTR source);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itaskdefinition
@GUID("f5bc8fc5-536d-4f77-b852-fbc1356fdeb6")
interface ITaskDefinition : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskdefinition-get_registrationinfo
    HRESULT get_RegistrationInfo(IRegistrationInfo* ppRegistrationInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskdefinition-put_registrationinfo
    HRESULT put_RegistrationInfo(IRegistrationInfo pRegistrationInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskdefinition-get_triggers
    HRESULT get_Triggers(ITriggerCollection* ppTriggers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskdefinition-put_triggers
    HRESULT put_Triggers(ITriggerCollection pTriggers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskdefinition-get_settings
    HRESULT get_Settings(ITaskSettings* ppSettings);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskdefinition-put_settings
    HRESULT put_Settings(ITaskSettings pSettings);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskdefinition-get_data
    HRESULT get_Data(BSTR* pData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskdefinition-put_data
    HRESULT put_Data(BSTR data);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskdefinition-get_principal
    HRESULT get_Principal(IPrincipal* ppPrincipal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskdefinition-put_principal
    HRESULT put_Principal(IPrincipal pPrincipal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskdefinition-get_actions
    HRESULT get_Actions(IActionCollection* ppActions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskdefinition-put_actions
    HRESULT put_Actions(IActionCollection pActions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskdefinition-get_xmltext
    HRESULT get_XmlText(BSTR* pXml);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskdefinition-put_xmltext
    HRESULT put_XmlText(BSTR xml);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itasksettings
@GUID("8fd4711d-2d02-4c8c-87e3-eff699de127e")
interface ITaskSettings : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_allowdemandstart
    HRESULT get_AllowDemandStart(VARIANT_BOOL* pAllowDemandStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_allowdemandstart
    HRESULT put_AllowDemandStart(VARIANT_BOOL allowDemandStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_restartinterval
    HRESULT get_RestartInterval(BSTR* pRestartInterval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_restartinterval
    HRESULT put_RestartInterval(BSTR restartInterval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_restartcount
    HRESULT get_RestartCount(int* pRestartCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_restartcount
    HRESULT put_RestartCount(int restartCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_multipleinstances
    HRESULT get_MultipleInstances(TASK_INSTANCES_POLICY* pPolicy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_multipleinstances
    HRESULT put_MultipleInstances(TASK_INSTANCES_POLICY policy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_stopifgoingonbatteries
    HRESULT get_StopIfGoingOnBatteries(VARIANT_BOOL* pStopIfOnBatteries);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_stopifgoingonbatteries
    HRESULT put_StopIfGoingOnBatteries(VARIANT_BOOL stopIfOnBatteries);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_disallowstartifonbatteries
    HRESULT get_DisallowStartIfOnBatteries(VARIANT_BOOL* pDisallowStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_disallowstartifonbatteries
    HRESULT put_DisallowStartIfOnBatteries(VARIANT_BOOL disallowStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_allowhardterminate
    HRESULT get_AllowHardTerminate(VARIANT_BOOL* pAllowHardTerminate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_allowhardterminate
    HRESULT put_AllowHardTerminate(VARIANT_BOOL allowHardTerminate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_startwhenavailable
    HRESULT get_StartWhenAvailable(VARIANT_BOOL* pStartWhenAvailable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_startwhenavailable
    HRESULT put_StartWhenAvailable(VARIANT_BOOL startWhenAvailable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_xmltext
    HRESULT get_XmlText(BSTR* pText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_xmltext
    HRESULT put_XmlText(BSTR text);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_runonlyifnetworkavailable
    HRESULT get_RunOnlyIfNetworkAvailable(VARIANT_BOOL* pRunOnlyIfNetworkAvailable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_runonlyifnetworkavailable
    HRESULT put_RunOnlyIfNetworkAvailable(VARIANT_BOOL runOnlyIfNetworkAvailable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_executiontimelimit
    HRESULT get_ExecutionTimeLimit(BSTR* pExecutionTimeLimit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_executiontimelimit
    HRESULT put_ExecutionTimeLimit(BSTR executionTimeLimit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_enabled
    HRESULT get_Enabled(VARIANT_BOOL* pEnabled);
    HRESULT put_Enabled(VARIANT_BOOL enabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_deleteexpiredtaskafter
    HRESULT get_DeleteExpiredTaskAfter(BSTR* pExpirationDelay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_deleteexpiredtaskafter
    HRESULT put_DeleteExpiredTaskAfter(BSTR expirationDelay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_priority
    HRESULT get_Priority(int* pPriority);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_priority
    HRESULT put_Priority(int priority);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_compatibility
    HRESULT get_Compatibility(TASK_COMPATIBILITY* pCompatLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_compatibility
    HRESULT put_Compatibility(TASK_COMPATIBILITY compatLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_hidden
    HRESULT get_Hidden(VARIANT_BOOL* pHidden);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_hidden
    HRESULT put_Hidden(VARIANT_BOOL hidden);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_idlesettings
    HRESULT get_IdleSettings(IIdleSettings* ppIdleSettings);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_idlesettings
    HRESULT put_IdleSettings(IIdleSettings pIdleSettings);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_runonlyifidle
    HRESULT get_RunOnlyIfIdle(VARIANT_BOOL* pRunOnlyIfIdle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_runonlyifidle
    HRESULT put_RunOnlyIfIdle(VARIANT_BOOL runOnlyIfIdle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_waketorun
    HRESULT get_WakeToRun(VARIANT_BOOL* pWake);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_waketorun
    HRESULT put_WakeToRun(VARIANT_BOOL wake);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-get_networksettings
    HRESULT get_NetworkSettings(INetworkSettings* ppNetworkSettings);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings-put_networksettings
    HRESULT put_NetworkSettings(INetworkSettings pNetworkSettings);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itasksettings2
@GUID("2c05c3f0-6eed-4c05-a15f-ed7d7a98a369")
interface ITaskSettings2 : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings2-get_disallowstartonremoteappsession
    HRESULT get_DisallowStartOnRemoteAppSession(VARIANT_BOOL* pDisallowStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings2-put_disallowstartonremoteappsession
    HRESULT put_DisallowStartOnRemoteAppSession(VARIANT_BOOL disallowStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings2-get_useunifiedschedulingengine
    HRESULT get_UseUnifiedSchedulingEngine(VARIANT_BOOL* pUseUnifiedEngine);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings2-put_useunifiedschedulingengine
    HRESULT put_UseUnifiedSchedulingEngine(VARIANT_BOOL useUnifiedEngine);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itasksettings3
@GUID("0ad9d0d7-0c7f-4ebb-9a5f-d1c648dca528")
interface ITaskSettings3 : ITaskSettings
{
    HRESULT get_DisallowStartOnRemoteAppSession(VARIANT_BOOL* pDisallowStart);
    HRESULT put_DisallowStartOnRemoteAppSession(VARIANT_BOOL disallowStart);
    HRESULT get_UseUnifiedSchedulingEngine(VARIANT_BOOL* pUseUnifiedEngine);
    HRESULT put_UseUnifiedSchedulingEngine(VARIANT_BOOL useUnifiedEngine);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings3-get_maintenancesettings
    HRESULT get_MaintenanceSettings(IMaintenanceSettings* ppMaintenanceSettings);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings3-put_maintenancesettings
    HRESULT put_MaintenanceSettings(IMaintenanceSettings pMaintenanceSettings);
    HRESULT CreateMaintenanceSettings(IMaintenanceSettings* ppMaintenanceSettings);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings3-get_volatile
    HRESULT get_Volatile(VARIANT_BOOL* pVolatile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itasksettings3-put_volatile
    HRESULT put_Volatile(VARIANT_BOOL Volatile);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-imaintenancesettings
@GUID("a6024fa8-9652-4adb-a6bf-5cfcd877a7ba")
interface IMaintenanceSettings : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imaintenancesettings-put_period
    HRESULT put_Period(BSTR value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imaintenancesettings-get_period
    HRESULT get_Period(BSTR* target);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imaintenancesettings-put_deadline
    HRESULT put_Deadline(BSTR value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imaintenancesettings-get_deadline
    HRESULT get_Deadline(BSTR* target);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imaintenancesettings-put_exclusive
    HRESULT put_Exclusive(VARIANT_BOOL value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-imaintenancesettings-get_exclusive
    HRESULT get_Exclusive(VARIANT_BOOL* target);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-iregisteredtaskcollection
@GUID("86627eb4-42a7-41e4-a4d9-ac33a72f2d52")
interface IRegisteredTaskCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtaskcollection-get_count
    HRESULT get_Count(int* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtaskcollection-get_item
    HRESULT get_Item(VARIANT index, IRegisteredTask* ppRegisteredTask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iregisteredtaskcollection-get__newenum
    HRESULT get__NewEnum(IUnknown* ppEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-itaskfolder
@GUID("8cfac062-a080-4c15-9a88-aa7c2af80dfc")
interface ITaskFolder : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfolder-get_name
    HRESULT get_Name(BSTR* pName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfolder-get_path
    HRESULT get_Path(BSTR* pPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfolder-getfolder
    HRESULT GetFolder(BSTR path, ITaskFolder* ppFolder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfolder-getfolders
    HRESULT GetFolders(int flags, ITaskFolderCollection* ppFolders);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfolder-createfolder
    HRESULT CreateFolder(BSTR subFolderName, VARIANT sddl, ITaskFolder* ppFolder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfolder-deletefolder
    HRESULT DeleteFolder(BSTR subFolderName, int flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfolder-gettask
    HRESULT GetTask(BSTR path, IRegisteredTask* ppTask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfolder-gettasks
    HRESULT GetTasks(int flags, IRegisteredTaskCollection* ppTasks);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfolder-deletetask
    HRESULT DeleteTask(BSTR name, int flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfolder-registertask
    HRESULT RegisterTask(BSTR path, BSTR xmlText, int flags, VARIANT userId, VARIANT password, 
                         TASK_LOGON_TYPE logonType, VARIANT sddl, IRegisteredTask* ppTask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfolder-registertaskdefinition
    HRESULT RegisterTaskDefinition(BSTR path, ITaskDefinition pDefinition, int flags, VARIANT userId, 
                                   VARIANT password, TASK_LOGON_TYPE logonType, VARIANT sddl, 
                                   IRegisteredTask* ppTask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfolder-getsecuritydescriptor
    HRESULT GetSecurityDescriptor(int securityInformation, BSTR* pSddl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-itaskfolder-setsecuritydescriptor
    HRESULT SetSecurityDescriptor(BSTR sddl, int flags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-iidlesettings
@GUID("84594461-0053-4342-a8fd-088fabf11f32")
interface IIdleSettings : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iidlesettings-get_idleduration
    HRESULT get_IdleDuration(BSTR* pDelay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iidlesettings-put_idleduration
    HRESULT put_IdleDuration(BSTR delay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iidlesettings-get_waittimeout
    HRESULT get_WaitTimeout(BSTR* pTimeout);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iidlesettings-put_waittimeout
    HRESULT put_WaitTimeout(BSTR timeout);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iidlesettings-get_stoponidleend
    HRESULT get_StopOnIdleEnd(VARIANT_BOOL* pStop);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iidlesettings-put_stoponidleend
    HRESULT put_StopOnIdleEnd(VARIANT_BOOL stop);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iidlesettings-get_restartonidle
    HRESULT get_RestartOnIdle(VARIANT_BOOL* pRestart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-iidlesettings-put_restartonidle
    HRESULT put_RestartOnIdle(VARIANT_BOOL restart);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-inetworksettings
@GUID("9f7dea84-c30b-4245-80b6-00e9f646f1b4")
interface INetworkSettings : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-inetworksettings-get_name
    HRESULT get_Name(BSTR* pName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-inetworksettings-put_name
    HRESULT put_Name(BSTR name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-inetworksettings-get_id
    HRESULT get_Id(BSTR* pId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-inetworksettings-put_id
    HRESULT put_Id(BSTR id);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nn-taskschd-irepetitionpattern
@GUID("7fb9acf1-26be-400e-85b5-294b9c75dfd6")
interface IRepetitionPattern : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irepetitionpattern-get_interval
    HRESULT get_Interval(BSTR* pInterval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irepetitionpattern-put_interval
    HRESULT put_Interval(BSTR interval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irepetitionpattern-get_duration
    HRESULT get_Duration(BSTR* pDuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irepetitionpattern-put_duration
    HRESULT put_Duration(BSTR duration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irepetitionpattern-get_stopatdurationend
    HRESULT get_StopAtDurationEnd(VARIANT_BOOL* pStop);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/taskschd/nf-taskschd-irepetitionpattern-put_stopatdurationend
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
