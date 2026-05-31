// Written in the D programming language.

module windows.win32.ui.animation;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, HRESULT;
public import windows.win32.graphics.directcomposition : IDCompositionAnimation;
public import windows.win32.system.com.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/ne-uianimation-ui_animation_update_result
alias UI_ANIMATION_UPDATE_RESULT = int;
enum : int
{
    UI_ANIMATION_UPDATE_NO_CHANGE         = 0x00000000,
    UI_ANIMATION_UPDATE_VARIABLES_CHANGED = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/ne-uianimation-ui_animation_manager_status
alias UI_ANIMATION_MANAGER_STATUS = int;
enum : int
{
    UI_ANIMATION_MANAGER_IDLE = 0x00000000,
    UI_ANIMATION_MANAGER_BUSY = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/ne-uianimation-ui_animation_mode
alias UI_ANIMATION_MODE = int;
enum : int
{
    UI_ANIMATION_MODE_DISABLED       = 0x00000000,
    UI_ANIMATION_MODE_SYSTEM_DEFAULT = 0x00000001,
    UI_ANIMATION_MODE_ENABLED        = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/ne-uianimation-ui_animation_repeat_mode
alias UI_ANIMATION_REPEAT_MODE = int;
enum : int
{
    UI_ANIMATION_REPEAT_MODE_NORMAL    = 0x00000000,
    UI_ANIMATION_REPEAT_MODE_ALTERNATE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/ne-uianimation-ui_animation_rounding_mode
alias UI_ANIMATION_ROUNDING_MODE = int;
enum : int
{
    UI_ANIMATION_ROUNDING_NEAREST = 0x00000000,
    UI_ANIMATION_ROUNDING_FLOOR   = 0x00000001,
    UI_ANIMATION_ROUNDING_CEILING = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/ne-uianimation-ui_animation_storyboard_status
alias UI_ANIMATION_STORYBOARD_STATUS = int;
enum : int
{
    UI_ANIMATION_STORYBOARD_BUILDING              = 0x00000000,
    UI_ANIMATION_STORYBOARD_SCHEDULED             = 0x00000001,
    UI_ANIMATION_STORYBOARD_CANCELLED             = 0x00000002,
    UI_ANIMATION_STORYBOARD_PLAYING               = 0x00000003,
    UI_ANIMATION_STORYBOARD_TRUNCATED             = 0x00000004,
    UI_ANIMATION_STORYBOARD_FINISHED              = 0x00000005,
    UI_ANIMATION_STORYBOARD_READY                 = 0x00000006,
    UI_ANIMATION_STORYBOARD_INSUFFICIENT_PRIORITY = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/ne-uianimation-ui_animation_scheduling_result
alias UI_ANIMATION_SCHEDULING_RESULT = int;
enum : int
{
    UI_ANIMATION_SCHEDULING_UNEXPECTED_FAILURE    = 0x00000000,
    UI_ANIMATION_SCHEDULING_INSUFFICIENT_PRIORITY = 0x00000001,
    UI_ANIMATION_SCHEDULING_ALREADY_SCHEDULED     = 0x00000002,
    UI_ANIMATION_SCHEDULING_SUCCEEDED             = 0x00000003,
    UI_ANIMATION_SCHEDULING_DEFERRED              = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/ne-uianimation-ui_animation_priority_effect
alias UI_ANIMATION_PRIORITY_EFFECT = int;
enum : int
{
    UI_ANIMATION_PRIORITY_EFFECT_FAILURE = 0x00000000,
    UI_ANIMATION_PRIORITY_EFFECT_DELAY   = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/ne-uianimation-ui_animation_slope
alias UI_ANIMATION_SLOPE = int;
enum : int
{
    UI_ANIMATION_SLOPE_INCREASING = 0x00000000,
    UI_ANIMATION_SLOPE_DECREASING = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/ne-uianimation-ui_animation_dependencies
alias UI_ANIMATION_DEPENDENCIES = int;
enum : int
{
    UI_ANIMATION_DEPENDENCY_NONE                = 0x00000000,
    UI_ANIMATION_DEPENDENCY_INTERMEDIATE_VALUES = 0x00000001,
    UI_ANIMATION_DEPENDENCY_FINAL_VALUE         = 0x00000002,
    UI_ANIMATION_DEPENDENCY_FINAL_VELOCITY      = 0x00000004,
    UI_ANIMATION_DEPENDENCY_DURATION            = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/ne-uianimation-ui_animation_idle_behavior
alias UI_ANIMATION_IDLE_BEHAVIOR = int;
enum : int
{
    UI_ANIMATION_IDLE_BEHAVIOR_CONTINUE = 0x00000000,
    UI_ANIMATION_IDLE_BEHAVIOR_DISABLE  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/ne-uianimation-ui_animation_timer_client_status
alias UI_ANIMATION_TIMER_CLIENT_STATUS = int;
enum : int
{
    UI_ANIMATION_TIMER_CLIENT_IDLE = 0x00000000,
    UI_ANIMATION_TIMER_CLIENT_BUSY = 0x00000001,
}

// Constants


enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/UIAnimation/ui-animation-seconds-eventually))], [])*/int
{
    UI_ANIMATION_SECONDS_EVENTUALLY                    = 0xffffffff,
    UI_ANIMATION_REPEAT_INDEFINITELY                   = 0xffffffff,
    UI_ANIMATION_REPEAT_INDEFINITELY_CONCLUDE_AT_END   = 0xffffffff,
    UI_ANIMATION_REPEAT_INDEFINITELY_CONCLUDE_AT_START = 0xfffffffe,
}

enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/UIAnimation/ui-animation-seconds-infinite))], [])*/int UI_ANIMATION_SECONDS_INFINITE = 0xffffffff;

// Structs


struct UI_ANIMATION_KEYFRAME
{
    ptrdiff_t Value;
}

// Interfaces

@GUID("4c1fc63a-695c-47e8-a339-1a194be3d0b8")
struct UIAnimationManager;

@GUID("d25d8842-8884-4a4a-b321-091314379bdd")
struct UIAnimationManager2;

@GUID("1d6322ad-aa85-4ef5-a828-86d71067d145")
struct UIAnimationTransitionLibrary;

@GUID("812f944a-c5c8-4cd9-b0a6-b3da802f228d")
struct UIAnimationTransitionLibrary2;

@GUID("8a9b1cdd-fcd7-419c-8b44-42fd17db1887")
struct UIAnimationTransitionFactory;

@GUID("84302f97-7f7b-4040-b190-72ac9d18e420")
struct UIAnimationTransitionFactory2;

@GUID("bfcd4a0c-06b6-4384-b768-0daa792c380e")
struct UIAnimationTimer;

@GUID("9169896c-ac8d-4e7d-94e5-67fa4dc2f2e8")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationmanager
interface IUIAnimationManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager-createanimationvariable
    HRESULT CreateAnimationVariable(double initialValue, IUIAnimationVariable* variable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager-scheduletransition
    HRESULT ScheduleTransition(IUIAnimationVariable variable, IUIAnimationTransition transition, double timeNow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager-createstoryboard
    HRESULT CreateStoryboard(IUIAnimationStoryboard* storyboard);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager-finishallstoryboards
    HRESULT FinishAllStoryboards(double completionDeadline);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager-abandonallstoryboards
    HRESULT AbandonAllStoryboards();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager-update
    HRESULT Update(double timeNow, UI_ANIMATION_UPDATE_RESULT* updateResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager-getvariablefromtag
    HRESULT GetVariableFromTag(IUnknown object, uint id, IUIAnimationVariable* variable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager-getstoryboardfromtag
    HRESULT GetStoryboardFromTag(IUnknown object, uint id, IUIAnimationStoryboard* storyboard);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager-getstatus
    HRESULT GetStatus(UI_ANIMATION_MANAGER_STATUS* status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager-setanimationmode
    HRESULT SetAnimationMode(UI_ANIMATION_MODE mode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager-pause
    HRESULT Pause();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager-resume
    HRESULT Resume();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager-setmanagereventhandler
    HRESULT SetManagerEventHandler(IUIAnimationManagerEventHandler handler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager-setcancelprioritycomparison
    HRESULT SetCancelPriorityComparison(IUIAnimationPriorityComparison comparison);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager-settrimprioritycomparison
    HRESULT SetTrimPriorityComparison(IUIAnimationPriorityComparison comparison);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager-setcompressprioritycomparison
    HRESULT SetCompressPriorityComparison(IUIAnimationPriorityComparison comparison);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager-setconcludeprioritycomparison
    HRESULT SetConcludePriorityComparison(IUIAnimationPriorityComparison comparison);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager-setdefaultlongestacceptabledelay
    HRESULT SetDefaultLongestAcceptableDelay(double delay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager-shutdown
    HRESULT Shutdown();
}

@GUID("8ceeb155-2849-4ce5-9448-91ff70e1e4d9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationvariable
interface IUIAnimationVariable : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable-getvalue
    HRESULT GetValue(double* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable-getfinalvalue
    HRESULT GetFinalValue(double* finalValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable-getpreviousvalue
    HRESULT GetPreviousValue(double* previousValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable-getintegervalue
    HRESULT GetIntegerValue(int* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable-getfinalintegervalue
    HRESULT GetFinalIntegerValue(int* finalValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable-getpreviousintegervalue
    HRESULT GetPreviousIntegerValue(int* previousValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable-getcurrentstoryboard
    HRESULT GetCurrentStoryboard(IUIAnimationStoryboard* storyboard);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable-setlowerbound
    HRESULT SetLowerBound(double bound);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable-setupperbound
    HRESULT SetUpperBound(double bound);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable-setroundingmode
    HRESULT SetRoundingMode(UI_ANIMATION_ROUNDING_MODE mode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable-settag
    HRESULT SetTag(IUnknown object, uint id);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable-gettag
    HRESULT GetTag(IUnknown* object, uint* id);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable-setvariablechangehandler
    HRESULT SetVariableChangeHandler(IUIAnimationVariableChangeHandler handler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable-setvariableintegerchangehandler
    HRESULT SetVariableIntegerChangeHandler(IUIAnimationVariableIntegerChangeHandler handler);
}

@GUID("a8ff128f-9bf9-4af1-9e67-e5e410defb84")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationstoryboard
interface IUIAnimationStoryboard : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard-addtransition
    HRESULT AddTransition(IUIAnimationVariable variable, IUIAnimationTransition transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard-addkeyframeatoffset
    HRESULT AddKeyframeAtOffset(UI_ANIMATION_KEYFRAME existingKeyframe, double offset, 
                                UI_ANIMATION_KEYFRAME* keyframe);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard-addkeyframeaftertransition
    HRESULT AddKeyframeAfterTransition(IUIAnimationTransition transition, UI_ANIMATION_KEYFRAME* keyframe);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard-addtransitionatkeyframe
    HRESULT AddTransitionAtKeyframe(IUIAnimationVariable variable, IUIAnimationTransition transition, 
                                    UI_ANIMATION_KEYFRAME startKeyframe);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard-addtransitionbetweenkeyframes
    HRESULT AddTransitionBetweenKeyframes(IUIAnimationVariable variable, IUIAnimationTransition transition, 
                                          UI_ANIMATION_KEYFRAME startKeyframe, UI_ANIMATION_KEYFRAME endKeyframe);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard-repeatbetweenkeyframes
    HRESULT RepeatBetweenKeyframes(UI_ANIMATION_KEYFRAME startKeyframe, UI_ANIMATION_KEYFRAME endKeyframe, 
                                   int repetitionCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard-holdvariable
    HRESULT HoldVariable(IUIAnimationVariable variable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard-setlongestacceptabledelay
    HRESULT SetLongestAcceptableDelay(double delay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard-schedule
    HRESULT Schedule(double timeNow, UI_ANIMATION_SCHEDULING_RESULT* schedulingResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard-conclude
    HRESULT Conclude();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard-finish
    HRESULT Finish(double completionDeadline);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard-abandon
    HRESULT Abandon();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard-settag
    HRESULT SetTag(IUnknown object, uint id);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard-gettag
    HRESULT GetTag(IUnknown* object, uint* id);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard-getstatus
    HRESULT GetStatus(UI_ANIMATION_STORYBOARD_STATUS* status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard-getelapsedtime
    HRESULT GetElapsedTime(double* elapsedTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard-setstoryboardeventhandler
    HRESULT SetStoryboardEventHandler(IUIAnimationStoryboardEventHandler handler);
}

@GUID("dc6ce252-f731-41cf-b610-614b6ca049ad")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationtransition
interface IUIAnimationTransition : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransition-setinitialvalue
    HRESULT SetInitialValue(double value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransition-setinitialvelocity
    HRESULT SetInitialVelocity(double velocity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransition-isdurationknown
    HRESULT IsDurationKnown();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransition-getduration
    HRESULT GetDuration(double* duration);
}

@GUID("783321ed-78a3-4366-b574-6af607a64788")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationmanagereventhandler
interface IUIAnimationManagerEventHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanagereventhandler-onmanagerstatuschanged
    HRESULT OnManagerStatusChanged(UI_ANIMATION_MANAGER_STATUS newStatus, 
                                   UI_ANIMATION_MANAGER_STATUS previousStatus);
}

@GUID("6358b7ba-87d2-42d5-bf71-82e919dd5862")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationvariablechangehandler
interface IUIAnimationVariableChangeHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariablechangehandler-onvaluechanged
    HRESULT OnValueChanged(IUIAnimationStoryboard storyboard, IUIAnimationVariable variable, double newValue, 
                           double previousValue);
}

@GUID("bb3e1550-356e-44b0-99da-85ac6017865e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationvariableintegerchangehandler
interface IUIAnimationVariableIntegerChangeHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariableintegerchangehandler-onintegervaluechanged
    HRESULT OnIntegerValueChanged(IUIAnimationStoryboard storyboard, IUIAnimationVariable variable, int newValue, 
                                  int previousValue);
}

@GUID("3d5c9008-ec7c-4364-9f8a-9af3c58cbae6")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationstoryboardeventhandler
interface IUIAnimationStoryboardEventHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboardeventhandler-onstoryboardstatuschanged
    HRESULT OnStoryboardStatusChanged(IUIAnimationStoryboard storyboard, UI_ANIMATION_STORYBOARD_STATUS newStatus, 
                                      UI_ANIMATION_STORYBOARD_STATUS previousStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboardeventhandler-onstoryboardupdated
    HRESULT OnStoryboardUpdated(IUIAnimationStoryboard storyboard);
}

@GUID("83fa9b74-5f86-4618-bc6a-a2fac19b3f44")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationprioritycomparison
interface IUIAnimationPriorityComparison : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationprioritycomparison-haspriority
    HRESULT HasPriority(IUIAnimationStoryboard scheduledStoryboard, IUIAnimationStoryboard newStoryboard, 
                        UI_ANIMATION_PRIORITY_EFFECT priorityEffect);
}

@GUID("ca5a14b1-d24f-48b8-8fe4-c78169ba954e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationtransitionlibrary
interface IUIAnimationTransitionLibrary : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary-createinstantaneoustransition
    HRESULT CreateInstantaneousTransition(double finalValue, IUIAnimationTransition* transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary-createconstanttransition
    HRESULT CreateConstantTransition(double duration, IUIAnimationTransition* transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary-creatediscretetransition
    HRESULT CreateDiscreteTransition(double delay, double finalValue, double hold, 
                                     IUIAnimationTransition* transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary-createlineartransition
    HRESULT CreateLinearTransition(double duration, double finalValue, IUIAnimationTransition* transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary-createlineartransitionfromspeed
    HRESULT CreateLinearTransitionFromSpeed(double speed, double finalValue, IUIAnimationTransition* transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary-createsinusoidaltransitionfromvelocity
    HRESULT CreateSinusoidalTransitionFromVelocity(double duration, double period, 
                                                   IUIAnimationTransition* transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary-createsinusoidaltransitionfromrange
    HRESULT CreateSinusoidalTransitionFromRange(double duration, double minimumValue, double maximumValue, 
                                                double period, UI_ANIMATION_SLOPE slope, 
                                                IUIAnimationTransition* transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary-createacceleratedeceleratetransition
    HRESULT CreateAccelerateDecelerateTransition(double duration, double finalValue, double accelerationRatio, 
                                                 double decelerationRatio, IUIAnimationTransition* transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary-createreversaltransition
    HRESULT CreateReversalTransition(double duration, IUIAnimationTransition* transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary-createcubictransition
    HRESULT CreateCubicTransition(double duration, double finalValue, double finalVelocity, 
                                  IUIAnimationTransition* transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary-createsmoothstoptransition
    HRESULT CreateSmoothStopTransition(double maximumDuration, double finalValue, 
                                       IUIAnimationTransition* transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary-createparabolictransitionfromacceleration
    HRESULT CreateParabolicTransitionFromAcceleration(double finalValue, double finalVelocity, double acceleration, 
                                                      IUIAnimationTransition* transition);
}

@GUID("7815cbba-ddf7-478c-a46c-7b6c738b7978")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationinterpolator
interface IUIAnimationInterpolator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationinterpolator-setinitialvalueandvelocity
    HRESULT SetInitialValueAndVelocity(double initialValue, double initialVelocity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationinterpolator-setduration
    HRESULT SetDuration(double duration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationinterpolator-getduration
    HRESULT GetDuration(double* duration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationinterpolator-getfinalvalue
    HRESULT GetFinalValue(double* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationinterpolator-interpolatevalue
    HRESULT InterpolateValue(double offset, double* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationinterpolator-interpolatevelocity
    HRESULT InterpolateVelocity(double offset, double* velocity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationinterpolator-getdependencies
    HRESULT GetDependencies(UI_ANIMATION_DEPENDENCIES* initialValueDependencies, 
                            UI_ANIMATION_DEPENDENCIES* initialVelocityDependencies, 
                            UI_ANIMATION_DEPENDENCIES* durationDependencies);
}

@GUID("fcd91e03-3e3b-45ad-bbb1-6dfc8153743d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationtransitionfactory
interface IUIAnimationTransitionFactory : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionfactory-createtransition
    HRESULT CreateTransition(IUIAnimationInterpolator interpolator, IUIAnimationTransition* transition);
}

@GUID("6b0efad1-a053-41d6-9085-33a689144665")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationtimer
interface IUIAnimationTimer : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtimer-settimerupdatehandler
    HRESULT SetTimerUpdateHandler(IUIAnimationTimerUpdateHandler updateHandler, 
                                  UI_ANIMATION_IDLE_BEHAVIOR idleBehavior);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtimer-settimereventhandler
    HRESULT SetTimerEventHandler(IUIAnimationTimerEventHandler handler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtimer-enable
    HRESULT Enable();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtimer-disable
    HRESULT Disable();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtimer-isenabled
    HRESULT IsEnabled();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtimer-gettime
    HRESULT GetTime(double* seconds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtimer-setframeratethreshold
    HRESULT SetFrameRateThreshold(uint framesPerSecond);
}

@GUID("195509b7-5d5e-4e3e-b278-ee3759b367ad")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationtimerupdatehandler
interface IUIAnimationTimerUpdateHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtimerupdatehandler-onupdate
    HRESULT OnUpdate(double timeNow, UI_ANIMATION_UPDATE_RESULT* result);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtimerupdatehandler-settimerclienteventhandler
    HRESULT SetTimerClientEventHandler(IUIAnimationTimerClientEventHandler handler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtimerupdatehandler-cleartimerclienteventhandler
    HRESULT ClearTimerClientEventHandler();
}

@GUID("bedb4db6-94fa-4bfb-a47f-ef2d9e408c25")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationtimerclienteventhandler
interface IUIAnimationTimerClientEventHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtimerclienteventhandler-ontimerclientstatuschanged
    HRESULT OnTimerClientStatusChanged(UI_ANIMATION_TIMER_CLIENT_STATUS newStatus, 
                                       UI_ANIMATION_TIMER_CLIENT_STATUS previousStatus);
}

@GUID("274a7dea-d771-4095-abbd-8df7abd23ce3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationtimereventhandler
interface IUIAnimationTimerEventHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtimereventhandler-onpreupdate
    HRESULT OnPreUpdate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtimereventhandler-onpostupdate
    HRESULT OnPostUpdate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtimereventhandler-onrenderingtooslow
    HRESULT OnRenderingTooSlow(uint framesPerSecond);
}

@GUID("d8b6f7d4-4109-4d3f-acee-879926968cb1")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationmanager2
interface IUIAnimationManager2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager2-createanimationvectorvariable
    HRESULT CreateAnimationVectorVariable(const(double)* initialValue, uint cDimension, 
                                          IUIAnimationVariable2* variable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager2-createanimationvariable
    HRESULT CreateAnimationVariable(double initialValue, IUIAnimationVariable2* variable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager2-scheduletransition
    HRESULT ScheduleTransition(IUIAnimationVariable2 variable, IUIAnimationTransition2 transition, double timeNow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager2-createstoryboard
    HRESULT CreateStoryboard(IUIAnimationStoryboard2* storyboard);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager2-finishallstoryboards
    HRESULT FinishAllStoryboards(double completionDeadline);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager2-abandonallstoryboards
    HRESULT AbandonAllStoryboards();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager2-update
    HRESULT Update(double timeNow, UI_ANIMATION_UPDATE_RESULT* updateResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager2-getvariablefromtag
    HRESULT GetVariableFromTag(IUnknown object, uint id, IUIAnimationVariable2* variable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager2-getstoryboardfromtag
    HRESULT GetStoryboardFromTag(IUnknown object, uint id, IUIAnimationStoryboard2* storyboard);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager2-estimatenexteventtime
    HRESULT EstimateNextEventTime(double* seconds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager2-getstatus
    HRESULT GetStatus(UI_ANIMATION_MANAGER_STATUS* status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager2-setanimationmode
    HRESULT SetAnimationMode(UI_ANIMATION_MODE mode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager2-pause
    HRESULT Pause();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager2-resume
    HRESULT Resume();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager2-setmanagereventhandler
    HRESULT SetManagerEventHandler(IUIAnimationManagerEventHandler2 handler, BOOL fRegisterForNextAnimationEvent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager2-setcancelprioritycomparison
    HRESULT SetCancelPriorityComparison(IUIAnimationPriorityComparison2 comparison);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager2-settrimprioritycomparison
    HRESULT SetTrimPriorityComparison(IUIAnimationPriorityComparison2 comparison);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager2-setcompressprioritycomparison
    HRESULT SetCompressPriorityComparison(IUIAnimationPriorityComparison2 comparison);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager2-setconcludeprioritycomparison
    HRESULT SetConcludePriorityComparison(IUIAnimationPriorityComparison2 comparison);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager2-setdefaultlongestacceptabledelay
    HRESULT SetDefaultLongestAcceptableDelay(double delay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanager2-shutdown
    HRESULT Shutdown();
}

@GUID("4914b304-96ab-44d9-9e77-d5109b7e7466")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationvariable2
interface IUIAnimationVariable2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable2-getdimension
    HRESULT GetDimension(uint* dimension);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable2-getvalue
    HRESULT GetValue(double* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable2-getvectorvalue
    HRESULT GetVectorValue(double* value, uint cDimension);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable2-getcurve
    HRESULT GetCurve(IDCompositionAnimation animation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable2-getvectorcurve
    HRESULT GetVectorCurve(IDCompositionAnimation* animation, uint cDimension);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable2-getfinalvalue
    HRESULT GetFinalValue(double* finalValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable2-getfinalvectorvalue
    HRESULT GetFinalVectorValue(double* finalValue, uint cDimension);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable2-getpreviousvalue
    HRESULT GetPreviousValue(double* previousValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable2-getpreviousvectorvalue
    HRESULT GetPreviousVectorValue(double* previousValue, uint cDimension);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable2-getintegervalue
    HRESULT GetIntegerValue(int* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable2-getintegervectorvalue
    HRESULT GetIntegerVectorValue(int* value, uint cDimension);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable2-getfinalintegervalue
    HRESULT GetFinalIntegerValue(int* finalValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable2-getfinalintegervectorvalue
    HRESULT GetFinalIntegerVectorValue(int* finalValue, uint cDimension);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable2-getpreviousintegervalue
    HRESULT GetPreviousIntegerValue(int* previousValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable2-getpreviousintegervectorvalue
    HRESULT GetPreviousIntegerVectorValue(int* previousValue, uint cDimension);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable2-getcurrentstoryboard
    HRESULT GetCurrentStoryboard(IUIAnimationStoryboard2* storyboard);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable2-setlowerbound
    HRESULT SetLowerBound(double bound);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable2-setlowerboundvector
    HRESULT SetLowerBoundVector(const(double)* bound, uint cDimension);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable2-setupperbound
    HRESULT SetUpperBound(double bound);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable2-setupperboundvector
    HRESULT SetUpperBoundVector(const(double)* bound, uint cDimension);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable2-setroundingmode
    HRESULT SetRoundingMode(UI_ANIMATION_ROUNDING_MODE mode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable2-settag
    HRESULT SetTag(IUnknown object, uint id);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable2-gettag
    HRESULT GetTag(IUnknown* object, uint* id);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable2-setvariablechangehandler
    HRESULT SetVariableChangeHandler(IUIAnimationVariableChangeHandler2 handler, 
                                     BOOL fRegisterForNextAnimationEvent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable2-setvariableintegerchangehandler
    HRESULT SetVariableIntegerChangeHandler(IUIAnimationVariableIntegerChangeHandler2 handler, 
                                            BOOL fRegisterForNextAnimationEvent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariable2-setvariablecurvechangehandler
    HRESULT SetVariableCurveChangeHandler(IUIAnimationVariableCurveChangeHandler2 handler);
}

@GUID("62ff9123-a85a-4e9b-a218-435a93e268fd")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationtransition2
interface IUIAnimationTransition2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransition2-getdimension
    HRESULT GetDimension(uint* dimension);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransition2-setinitialvalue
    HRESULT SetInitialValue(double value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransition2-setinitialvectorvalue
    HRESULT SetInitialVectorValue(const(double)* value, uint cDimension);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransition2-setinitialvelocity
    HRESULT SetInitialVelocity(double velocity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransition2-setinitialvectorvelocity
    HRESULT SetInitialVectorVelocity(const(double)* velocity, uint cDimension);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransition2-isdurationknown
    HRESULT IsDurationKnown();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransition2-getduration
    HRESULT GetDuration(double* duration);
}

@GUID("f6e022ba-bff3-42ec-9033-e073f33e83c3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationmanagereventhandler2
interface IUIAnimationManagerEventHandler2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationmanagereventhandler2-onmanagerstatuschanged
    HRESULT OnManagerStatusChanged(UI_ANIMATION_MANAGER_STATUS newStatus, 
                                   UI_ANIMATION_MANAGER_STATUS previousStatus);
}

@GUID("63acc8d2-6eae-4bb0-b879-586dd8cfbe42")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationvariablechangehandler2
interface IUIAnimationVariableChangeHandler2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariablechangehandler2-onvaluechanged
    HRESULT OnValueChanged(IUIAnimationStoryboard2 storyboard, IUIAnimationVariable2 variable, double* newValue, 
                           double* previousValue, uint cDimension);
}

@GUID("829b6cf1-4f3a-4412-ae09-b243eb4c6b58")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationvariableintegerchangehandler2
interface IUIAnimationVariableIntegerChangeHandler2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariableintegerchangehandler2-onintegervaluechanged
    HRESULT OnIntegerValueChanged(IUIAnimationStoryboard2 storyboard, IUIAnimationVariable2 variable, 
                                  int* newValue, int* previousValue, uint cDimension);
}

@GUID("72895e91-0145-4c21-9192-5aab40eddf80")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationvariablecurvechangehandler2
interface IUIAnimationVariableCurveChangeHandler2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationvariablecurvechangehandler2-oncurvechanged
    HRESULT OnCurveChanged(IUIAnimationVariable2 variable);
}

@GUID("bac5f55a-ba7c-414c-b599-fbf850f553c6")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationstoryboardeventhandler2
interface IUIAnimationStoryboardEventHandler2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboardeventhandler2-onstoryboardstatuschanged
    HRESULT OnStoryboardStatusChanged(IUIAnimationStoryboard2 storyboard, UI_ANIMATION_STORYBOARD_STATUS newStatus, 
                                      UI_ANIMATION_STORYBOARD_STATUS previousStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboardeventhandler2-onstoryboardupdated
    HRESULT OnStoryboardUpdated(IUIAnimationStoryboard2 storyboard);
}

@GUID("2d3b15a4-4762-47ab-a030-b23221df3ae0")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationloopiterationchangehandler2
interface IUIAnimationLoopIterationChangeHandler2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationloopiterationchangehandler2-onloopiterationchanged
    HRESULT OnLoopIterationChanged(IUIAnimationStoryboard2 storyboard, size_t id, uint newIterationCount, 
                                   uint oldIterationCount);
}

@GUID("5b6d7a37-4621-467c-8b05-70131de62ddb")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationprioritycomparison2
interface IUIAnimationPriorityComparison2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationprioritycomparison2-haspriority
    HRESULT HasPriority(IUIAnimationStoryboard2 scheduledStoryboard, IUIAnimationStoryboard2 newStoryboard, 
                        UI_ANIMATION_PRIORITY_EFFECT priorityEffect);
}

@GUID("03cfae53-9580-4ee3-b363-2ece51b4af6a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationtransitionlibrary2
interface IUIAnimationTransitionLibrary2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary2-createinstantaneoustransition
    HRESULT CreateInstantaneousTransition(double finalValue, IUIAnimationTransition2* transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary2-createinstantaneousvectortransition
    HRESULT CreateInstantaneousVectorTransition(const(double)* finalValue, uint cDimension, 
                                                IUIAnimationTransition2* transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary2-createconstanttransition
    HRESULT CreateConstantTransition(double duration, IUIAnimationTransition2* transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary2-creatediscretetransition
    HRESULT CreateDiscreteTransition(double delay, double finalValue, double hold, 
                                     IUIAnimationTransition2* transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary2-creatediscretevectortransition
    HRESULT CreateDiscreteVectorTransition(double delay, const(double)* finalValue, uint cDimension, double hold, 
                                           IUIAnimationTransition2* transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary2-createlineartransition
    HRESULT CreateLinearTransition(double duration, double finalValue, IUIAnimationTransition2* transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary2-createlinearvectortransition
    HRESULT CreateLinearVectorTransition(double duration, const(double)* finalValue, uint cDimension, 
                                         IUIAnimationTransition2* transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary2-createlineartransitionfromspeed
    HRESULT CreateLinearTransitionFromSpeed(double speed, double finalValue, IUIAnimationTransition2* transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary2-createlinearvectortransitionfromspeed
    HRESULT CreateLinearVectorTransitionFromSpeed(double speed, const(double)* finalValue, uint cDimension, 
                                                  IUIAnimationTransition2* transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary2-createsinusoidaltransitionfromvelocity
    HRESULT CreateSinusoidalTransitionFromVelocity(double duration, double period, 
                                                   IUIAnimationTransition2* transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary2-createsinusoidaltransitionfromrange
    HRESULT CreateSinusoidalTransitionFromRange(double duration, double minimumValue, double maximumValue, 
                                                double period, UI_ANIMATION_SLOPE slope, 
                                                IUIAnimationTransition2* transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary2-createacceleratedeceleratetransition
    HRESULT CreateAccelerateDecelerateTransition(double duration, double finalValue, double accelerationRatio, 
                                                 double decelerationRatio, IUIAnimationTransition2* transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary2-createreversaltransition
    HRESULT CreateReversalTransition(double duration, IUIAnimationTransition2* transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary2-createcubictransition
    HRESULT CreateCubicTransition(double duration, double finalValue, double finalVelocity, 
                                  IUIAnimationTransition2* transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary2-createcubicvectortransition
    HRESULT CreateCubicVectorTransition(double duration, const(double)* finalValue, const(double)* finalVelocity, 
                                        uint cDimension, IUIAnimationTransition2* transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary2-createsmoothstoptransition
    HRESULT CreateSmoothStopTransition(double maximumDuration, double finalValue, 
                                       IUIAnimationTransition2* transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary2-createparabolictransitionfromacceleration
    HRESULT CreateParabolicTransitionFromAcceleration(double finalValue, double finalVelocity, double acceleration, 
                                                      IUIAnimationTransition2* transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary2-createcubicbezierlineartransition
    HRESULT CreateCubicBezierLinearTransition(double duration, double finalValue, double x1, double y1, double x2, 
                                              double y2, IUIAnimationTransition2* ppTransition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionlibrary2-createcubicbezierlinearvectortransition
    HRESULT CreateCubicBezierLinearVectorTransition(double duration, const(double)* finalValue, uint cDimension, 
                                                    double x1, double y1, double x2, double y2, 
                                                    IUIAnimationTransition2* ppTransition);
}

@GUID("bab20d63-4361-45da-a24f-ab8508846b5b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationprimitiveinterpolation
interface IUIAnimationPrimitiveInterpolation : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationprimitiveinterpolation-addcubic
    HRESULT AddCubic(uint dimension, double beginOffset, float constantCoefficient, float linearCoefficient, 
                     float quadraticCoefficient, float cubicCoefficient);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationprimitiveinterpolation-addsinusoidal
    HRESULT AddSinusoidal(uint dimension, double beginOffset, float bias, float amplitude, float frequency, 
                          float phase);
}

@GUID("ea76aff8-ea22-4a23-a0ef-a6a966703518")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationinterpolator2
interface IUIAnimationInterpolator2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationinterpolator2-getdimension
    HRESULT GetDimension(uint* dimension);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationinterpolator2-setinitialvalueandvelocity
    HRESULT SetInitialValueAndVelocity(double* initialValue, double* initialVelocity, uint cDimension);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationinterpolator2-setduration
    HRESULT SetDuration(double duration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationinterpolator2-getduration
    HRESULT GetDuration(double* duration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationinterpolator2-getfinalvalue
    HRESULT GetFinalValue(double* value, uint cDimension);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationinterpolator2-interpolatevalue
    HRESULT InterpolateValue(double offset, double* value, uint cDimension);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationinterpolator2-interpolatevelocity
    HRESULT InterpolateVelocity(double offset, double* velocity, uint cDimension);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationinterpolator2-getprimitiveinterpolation
    HRESULT GetPrimitiveInterpolation(IUIAnimationPrimitiveInterpolation interpolation, uint cDimension);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationinterpolator2-getdependencies
    HRESULT GetDependencies(UI_ANIMATION_DEPENDENCIES* initialValueDependencies, 
                            UI_ANIMATION_DEPENDENCIES* initialVelocityDependencies, 
                            UI_ANIMATION_DEPENDENCIES* durationDependencies);
}

@GUID("937d4916-c1a6-42d5-88d8-30344d6efe31")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationtransitionfactory2
interface IUIAnimationTransitionFactory2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationtransitionfactory2-createtransition
    HRESULT CreateTransition(IUIAnimationInterpolator2 interpolator, IUIAnimationTransition2* transition);
}

@GUID("ae289cd2-12d4-4945-9419-9e41be034df2")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nn-uianimation-iuianimationstoryboard2
interface IUIAnimationStoryboard2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard2-addtransition
    HRESULT AddTransition(IUIAnimationVariable2 variable, IUIAnimationTransition2 transition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard2-addkeyframeatoffset
    HRESULT AddKeyframeAtOffset(UI_ANIMATION_KEYFRAME existingKeyframe, double offset, 
                                UI_ANIMATION_KEYFRAME* keyframe);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard2-addkeyframeaftertransition
    HRESULT AddKeyframeAfterTransition(IUIAnimationTransition2 transition, UI_ANIMATION_KEYFRAME* keyframe);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard2-addtransitionatkeyframe
    HRESULT AddTransitionAtKeyframe(IUIAnimationVariable2 variable, IUIAnimationTransition2 transition, 
                                    UI_ANIMATION_KEYFRAME startKeyframe);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard2-addtransitionbetweenkeyframes
    HRESULT AddTransitionBetweenKeyframes(IUIAnimationVariable2 variable, IUIAnimationTransition2 transition, 
                                          UI_ANIMATION_KEYFRAME startKeyframe, UI_ANIMATION_KEYFRAME endKeyframe);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard2-repeatbetweenkeyframes
    HRESULT RepeatBetweenKeyframes(UI_ANIMATION_KEYFRAME startKeyframe, UI_ANIMATION_KEYFRAME endKeyframe, 
                                   double cRepetition, UI_ANIMATION_REPEAT_MODE repeatMode, 
                                   IUIAnimationLoopIterationChangeHandler2 pIterationChangeHandler, size_t id, 
                                   BOOL fRegisterForNextAnimationEvent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard2-holdvariable
    HRESULT HoldVariable(IUIAnimationVariable2 variable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard2-setlongestacceptabledelay
    HRESULT SetLongestAcceptableDelay(double delay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard2-setskipduration
    HRESULT SetSkipDuration(double secondsDuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard2-schedule
    HRESULT Schedule(double timeNow, UI_ANIMATION_SCHEDULING_RESULT* schedulingResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard2-conclude
    HRESULT Conclude();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard2-finish
    HRESULT Finish(double completionDeadline);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard2-abandon
    HRESULT Abandon();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard2-settag
    HRESULT SetTag(IUnknown object, uint id);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard2-gettag
    HRESULT GetTag(IUnknown* object, uint* id);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard2-getstatus
    HRESULT GetStatus(UI_ANIMATION_STORYBOARD_STATUS* status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard2-getelapsedtime
    HRESULT GetElapsedTime(double* elapsedTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uianimation/nf-uianimation-iuianimationstoryboard2-setstoryboardeventhandler
    HRESULT SetStoryboardEventHandler(IUIAnimationStoryboardEventHandler2 handler, 
                                      BOOL fRegisterStatusChangeForNextAnimationEvent, 
                                      BOOL fRegisterUpdateForNextAnimationEvent);
}


// GUIDs

const GUID CLSID_UIAnimationManager            = GUIDOF!UIAnimationManager;
const GUID CLSID_UIAnimationManager2           = GUIDOF!UIAnimationManager2;
const GUID CLSID_UIAnimationTimer              = GUIDOF!UIAnimationTimer;
const GUID CLSID_UIAnimationTransitionFactory  = GUIDOF!UIAnimationTransitionFactory;
const GUID CLSID_UIAnimationTransitionFactory2 = GUIDOF!UIAnimationTransitionFactory2;
const GUID CLSID_UIAnimationTransitionLibrary  = GUIDOF!UIAnimationTransitionLibrary;
const GUID CLSID_UIAnimationTransitionLibrary2 = GUIDOF!UIAnimationTransitionLibrary2;

const GUID IID_IUIAnimationInterpolator                  = GUIDOF!IUIAnimationInterpolator;
const GUID IID_IUIAnimationInterpolator2                 = GUIDOF!IUIAnimationInterpolator2;
const GUID IID_IUIAnimationLoopIterationChangeHandler2   = GUIDOF!IUIAnimationLoopIterationChangeHandler2;
const GUID IID_IUIAnimationManager                       = GUIDOF!IUIAnimationManager;
const GUID IID_IUIAnimationManager2                      = GUIDOF!IUIAnimationManager2;
const GUID IID_IUIAnimationManagerEventHandler           = GUIDOF!IUIAnimationManagerEventHandler;
const GUID IID_IUIAnimationManagerEventHandler2          = GUIDOF!IUIAnimationManagerEventHandler2;
const GUID IID_IUIAnimationPrimitiveInterpolation        = GUIDOF!IUIAnimationPrimitiveInterpolation;
const GUID IID_IUIAnimationPriorityComparison            = GUIDOF!IUIAnimationPriorityComparison;
const GUID IID_IUIAnimationPriorityComparison2           = GUIDOF!IUIAnimationPriorityComparison2;
const GUID IID_IUIAnimationStoryboard                    = GUIDOF!IUIAnimationStoryboard;
const GUID IID_IUIAnimationStoryboard2                   = GUIDOF!IUIAnimationStoryboard2;
const GUID IID_IUIAnimationStoryboardEventHandler        = GUIDOF!IUIAnimationStoryboardEventHandler;
const GUID IID_IUIAnimationStoryboardEventHandler2       = GUIDOF!IUIAnimationStoryboardEventHandler2;
const GUID IID_IUIAnimationTimer                         = GUIDOF!IUIAnimationTimer;
const GUID IID_IUIAnimationTimerClientEventHandler       = GUIDOF!IUIAnimationTimerClientEventHandler;
const GUID IID_IUIAnimationTimerEventHandler             = GUIDOF!IUIAnimationTimerEventHandler;
const GUID IID_IUIAnimationTimerUpdateHandler            = GUIDOF!IUIAnimationTimerUpdateHandler;
const GUID IID_IUIAnimationTransition                    = GUIDOF!IUIAnimationTransition;
const GUID IID_IUIAnimationTransition2                   = GUIDOF!IUIAnimationTransition2;
const GUID IID_IUIAnimationTransitionFactory             = GUIDOF!IUIAnimationTransitionFactory;
const GUID IID_IUIAnimationTransitionFactory2            = GUIDOF!IUIAnimationTransitionFactory2;
const GUID IID_IUIAnimationTransitionLibrary             = GUIDOF!IUIAnimationTransitionLibrary;
const GUID IID_IUIAnimationTransitionLibrary2            = GUIDOF!IUIAnimationTransitionLibrary2;
const GUID IID_IUIAnimationVariable                      = GUIDOF!IUIAnimationVariable;
const GUID IID_IUIAnimationVariable2                     = GUIDOF!IUIAnimationVariable2;
const GUID IID_IUIAnimationVariableChangeHandler         = GUIDOF!IUIAnimationVariableChangeHandler;
const GUID IID_IUIAnimationVariableChangeHandler2        = GUIDOF!IUIAnimationVariableChangeHandler2;
const GUID IID_IUIAnimationVariableCurveChangeHandler2   = GUIDOF!IUIAnimationVariableCurveChangeHandler2;
const GUID IID_IUIAnimationVariableIntegerChangeHandler  = GUIDOF!IUIAnimationVariableIntegerChangeHandler;
const GUID IID_IUIAnimationVariableIntegerChangeHandler2 = GUIDOF!IUIAnimationVariableIntegerChangeHandler2;
