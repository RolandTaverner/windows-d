// Written in the D programming language.

module windows.win32.ui.interactioncontext;

public import windows.core;
public import windows.win32.foundation : HRESULT;
public import windows.win32.ui.input.pointer : POINTER_INFO;
public import windows.win32.ui.windowsandmessaging : POINTER_INPUT_TYPE;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/interactioncontext/ne-interactioncontext-interaction_id
alias INTERACTION_ID = int;
enum : int
{
    INTERACTION_ID_NONE          = 0x00000000,
    INTERACTION_ID_MANIPULATION  = 0x00000001,
    INTERACTION_ID_TAP           = 0x00000002,
    INTERACTION_ID_SECONDARY_TAP = 0x00000003,
    INTERACTION_ID_HOLD          = 0x00000004,
    INTERACTION_ID_DRAG          = 0x00000005,
    INTERACTION_ID_CROSS_SLIDE   = 0x00000006,
    INTERACTION_ID_MAX           = 0xffffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/interactioncontext/ne-interactioncontext-interaction_flags
alias INTERACTION_FLAGS = uint;
enum : uint
{
    INTERACTION_FLAG_NONE    = 0x00000000U,
    INTERACTION_FLAG_BEGIN   = 0x00000001U,
    INTERACTION_FLAG_END     = 0x00000002U,
    INTERACTION_FLAG_CANCEL  = 0x00000004U,
    INTERACTION_FLAG_INERTIA = 0x00000008U,
    INTERACTION_FLAG_MAX     = 0xffffffffU,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/interactioncontext/ne-interactioncontext-interaction_configuration_flags
alias INTERACTION_CONFIGURATION_FLAGS = uint;
enum : uint
{
    INTERACTION_CONFIGURATION_FLAG_NONE                                 = 0x00000000U,
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION                         = 0x00000001U,
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_TRANSLATION_X           = 0x00000002U,
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_TRANSLATION_Y           = 0x00000004U,
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_ROTATION                = 0x00000008U,
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_SCALING                 = 0x00000010U,
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_TRANSLATION_INERTIA     = 0x00000020U,
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_ROTATION_INERTIA        = 0x00000040U,
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_SCALING_INERTIA         = 0x00000080U,
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_RAILS_X                 = 0x00000100U,
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_RAILS_Y                 = 0x00000200U,
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_EXACT                   = 0x00000400U,
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_MULTIPLE_FINGER_PANNING = 0x00000800U,
    INTERACTION_CONFIGURATION_FLAG_CROSS_SLIDE                          = 0x00000001U,
    INTERACTION_CONFIGURATION_FLAG_CROSS_SLIDE_HORIZONTAL               = 0x00000002U,
    INTERACTION_CONFIGURATION_FLAG_CROSS_SLIDE_SELECT                   = 0x00000004U,
    INTERACTION_CONFIGURATION_FLAG_CROSS_SLIDE_SPEED_BUMP               = 0x00000008U,
    INTERACTION_CONFIGURATION_FLAG_CROSS_SLIDE_REARRANGE                = 0x00000010U,
    INTERACTION_CONFIGURATION_FLAG_CROSS_SLIDE_EXACT                    = 0x00000020U,
    INTERACTION_CONFIGURATION_FLAG_TAP                                  = 0x00000001U,
    INTERACTION_CONFIGURATION_FLAG_TAP_DOUBLE                           = 0x00000002U,
    INTERACTION_CONFIGURATION_FLAG_TAP_MULTIPLE_FINGER                  = 0x00000004U,
    INTERACTION_CONFIGURATION_FLAG_SECONDARY_TAP                        = 0x00000001U,
    INTERACTION_CONFIGURATION_FLAG_HOLD                                 = 0x00000001U,
    INTERACTION_CONFIGURATION_FLAG_HOLD_MOUSE                           = 0x00000002U,
    INTERACTION_CONFIGURATION_FLAG_HOLD_MULTIPLE_FINGER                 = 0x00000004U,
    INTERACTION_CONFIGURATION_FLAG_DRAG                                 = 0x00000001U,
    INTERACTION_CONFIGURATION_FLAG_MAX                                  = 0xffffffffU,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/interactioncontext/ne-interactioncontext-inertia_parameter
alias INERTIA_PARAMETER = int;
enum : int
{
    INERTIA_PARAMETER_TRANSLATION_DECELERATION = 0x00000001,
    INERTIA_PARAMETER_TRANSLATION_DISPLACEMENT = 0x00000002,
    INERTIA_PARAMETER_ROTATION_DECELERATION    = 0x00000003,
    INERTIA_PARAMETER_ROTATION_ANGLE           = 0x00000004,
    INERTIA_PARAMETER_EXPANSION_DECELERATION   = 0x00000005,
    INERTIA_PARAMETER_EXPANSION_EXPANSION      = 0x00000006,
    INERTIA_PARAMETER_MAX                      = 0xffffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/interactioncontext/ne-interactioncontext-interaction_state
alias INTERACTION_STATE = int;
enum : int
{
    INTERACTION_STATE_IDLE                = 0x00000000,
    INTERACTION_STATE_IN_INTERACTION      = 0x00000001,
    INTERACTION_STATE_POSSIBLE_DOUBLE_TAP = 0x00000002,
    INTERACTION_STATE_MAX                 = 0xffffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/interactioncontext/ne-interactioncontext-interaction_context_property
alias INTERACTION_CONTEXT_PROPERTY = int;
enum : int
{
    INTERACTION_CONTEXT_PROPERTY_MEASUREMENT_UNITS       = 0x00000001,
    INTERACTION_CONTEXT_PROPERTY_INTERACTION_UI_FEEDBACK = 0x00000002,
    INTERACTION_CONTEXT_PROPERTY_FILTER_POINTERS         = 0x00000003,
    INTERACTION_CONTEXT_PROPERTY_MAX                     = 0xffffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/interactioncontext/ne-interactioncontext-cross_slide_threshold
alias CROSS_SLIDE_THRESHOLD = int;
enum : int
{
    CROSS_SLIDE_THRESHOLD_SELECT_START     = 0x00000000,
    CROSS_SLIDE_THRESHOLD_SPEED_BUMP_START = 0x00000001,
    CROSS_SLIDE_THRESHOLD_SPEED_BUMP_END   = 0x00000002,
    CROSS_SLIDE_THRESHOLD_REARRANGE_START  = 0x00000003,
    CROSS_SLIDE_THRESHOLD_COUNT            = 0x00000004,
    CROSS_SLIDE_THRESHOLD_MAX              = 0xffffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/interactioncontext/ne-interactioncontext-cross_slide_flags
alias CROSS_SLIDE_FLAGS = uint;
enum : uint
{
    CROSS_SLIDE_FLAGS_NONE       = 0x00000000U,
    CROSS_SLIDE_FLAGS_SELECT     = 0x00000001U,
    CROSS_SLIDE_FLAGS_SPEED_BUMP = 0x00000002U,
    CROSS_SLIDE_FLAGS_REARRANGE  = 0x00000004U,
    CROSS_SLIDE_FLAGS_MAX        = 0xffffffffU,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/interactioncontext/ne-interactioncontext-mouse_wheel_parameter
alias MOUSE_WHEEL_PARAMETER = int;
enum : int
{
    MOUSE_WHEEL_PARAMETER_CHAR_TRANSLATION_X = 0x00000001,
    MOUSE_WHEEL_PARAMETER_CHAR_TRANSLATION_Y = 0x00000002,
    MOUSE_WHEEL_PARAMETER_DELTA_SCALE        = 0x00000003,
    MOUSE_WHEEL_PARAMETER_DELTA_ROTATION     = 0x00000004,
    MOUSE_WHEEL_PARAMETER_PAGE_TRANSLATION_X = 0x00000005,
    MOUSE_WHEEL_PARAMETER_PAGE_TRANSLATION_Y = 0x00000006,
    MOUSE_WHEEL_PARAMETER_MAX                = 0xffffffff,
}

alias TAP_PARAMETER = int;
enum : int
{
    TAP_PARAMETER_MIN_CONTACT_COUNT = 0x00000000,
    TAP_PARAMETER_MAX_CONTACT_COUNT = 0x00000001,
    TAP_PARAMETER_MAX               = 0xffffffff,
}

alias HOLD_PARAMETER = int;
enum : int
{
    HOLD_PARAMETER_MIN_CONTACT_COUNT     = 0x00000000,
    HOLD_PARAMETER_MAX_CONTACT_COUNT     = 0x00000001,
    HOLD_PARAMETER_THRESHOLD_RADIUS      = 0x00000002,
    HOLD_PARAMETER_THRESHOLD_START_DELAY = 0x00000003,
    HOLD_PARAMETER_MAX                   = 0xffffffff,
}

alias TRANSLATION_PARAMETER = int;
enum : int
{
    TRANSLATION_PARAMETER_MIN_CONTACT_COUNT = 0x00000000,
    TRANSLATION_PARAMETER_MAX_CONTACT_COUNT = 0x00000001,
    TRANSLATION_PARAMETER_MAX               = 0xffffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/interactioncontext/ne-interactioncontext-manipulation_rails_state
alias MANIPULATION_RAILS_STATE = int;
enum : int
{
    MANIPULATION_RAILS_STATE_UNDECIDED = 0x00000000,
    MANIPULATION_RAILS_STATE_FREE      = 0x00000001,
    MANIPULATION_RAILS_STATE_RAILED    = 0x00000002,
    MANIPULATION_RAILS_STATE_MAX       = 0xffffffff,
}

// Callbacks

alias INTERACTION_CONTEXT_OUTPUT_CALLBACK = void function(void* clientData, 
                                                          const(INTERACTION_CONTEXT_OUTPUT)* output);
alias INTERACTION_CONTEXT_OUTPUT_CALLBACK2 = void function(void* clientData, 
                                                           const(INTERACTION_CONTEXT_OUTPUT2)* output);

// Structs


@RAIIFree!DestroyInteractionContext
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HINTERACTIONCONTEXT
{
    void* Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/interactioncontext/ns-interactioncontext-manipulation_transform
struct MANIPULATION_TRANSFORM
{
    float translationX;
    float translationY;
    float scale;
    float expansion;
    float rotation;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/interactioncontext/ns-interactioncontext-manipulation_velocity
struct MANIPULATION_VELOCITY
{
    float velocityX;
    float velocityY;
    float velocityExpansion;
    float velocityAngular;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/interactioncontext/ns-interactioncontext-interaction_arguments_manipulation
struct INTERACTION_ARGUMENTS_MANIPULATION
{
    MANIPULATION_TRANSFORM delta;
    MANIPULATION_TRANSFORM cumulative;
    MANIPULATION_VELOCITY velocity;
    MANIPULATION_RAILS_STATE railsState;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/interactioncontext/ns-interactioncontext-interaction_arguments_tap
struct INTERACTION_ARGUMENTS_TAP
{
    uint count;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/interactioncontext/ns-interactioncontext-interaction_arguments_cross_slide
struct INTERACTION_ARGUMENTS_CROSS_SLIDE
{
    CROSS_SLIDE_FLAGS flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/interactioncontext/ns-interactioncontext-interaction_context_output
struct INTERACTION_CONTEXT_OUTPUT
{
    INTERACTION_ID     interactionId;
    INTERACTION_FLAGS  interactionFlags;
    POINTER_INPUT_TYPE inputType;
    float              x;
    float              y;
    union arguments
    {
        INTERACTION_ARGUMENTS_MANIPULATION manipulation;
        INTERACTION_ARGUMENTS_TAP tap;
        INTERACTION_ARGUMENTS_CROSS_SLIDE crossSlide;
    }
}

struct INTERACTION_CONTEXT_OUTPUT2
{
    INTERACTION_ID     interactionId;
    INTERACTION_FLAGS  interactionFlags;
    POINTER_INPUT_TYPE inputType;
    uint               contactCount;
    uint               currentContactCount;
    float              x;
    float              y;
    union arguments
    {
        INTERACTION_ARGUMENTS_MANIPULATION manipulation;
        INTERACTION_ARGUMENTS_TAP tap;
        INTERACTION_ARGUMENTS_CROSS_SLIDE crossSlide;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/interactioncontext/ns-interactioncontext-interaction_context_configuration
struct INTERACTION_CONTEXT_CONFIGURATION
{
    INTERACTION_ID interactionId;
    INTERACTION_CONFIGURATION_FLAGS enable;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/interactioncontext/ns-interactioncontext-cross_slide_parameter
struct CROSS_SLIDE_PARAMETER
{
    CROSS_SLIDE_THRESHOLD threshold;
    float distance;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("NInput.dll")
HRESULT CreateInteractionContext(HINTERACTIONCONTEXT* interactionContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("NInput.dll")
HRESULT DestroyInteractionContext(HINTERACTIONCONTEXT interactionContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("NInput.dll")
HRESULT RegisterOutputCallbackInteractionContext(HINTERACTIONCONTEXT interactionContext, 
                                                 INTERACTION_CONTEXT_OUTPUT_CALLBACK outputCallback, 
                                                 void* clientData);

@DllImport("NInput.dll")
HRESULT RegisterOutputCallbackInteractionContext2(HINTERACTIONCONTEXT interactionContext, 
                                                  INTERACTION_CONTEXT_OUTPUT_CALLBACK2 outputCallback, 
                                                  void* clientData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("NInput.dll")
HRESULT SetInteractionConfigurationInteractionContext(HINTERACTIONCONTEXT interactionContext, 
                                                      uint configurationCount, 
                                                      const(INTERACTION_CONTEXT_CONFIGURATION)* configuration);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("NInput.dll")
HRESULT GetInteractionConfigurationInteractionContext(HINTERACTIONCONTEXT interactionContext, 
                                                      uint configurationCount, 
                                                      INTERACTION_CONTEXT_CONFIGURATION* configuration);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("NInput.dll")
HRESULT SetPropertyInteractionContext(HINTERACTIONCONTEXT interactionContext, 
                                      INTERACTION_CONTEXT_PROPERTY contextProperty, uint value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("NInput.dll")
HRESULT GetPropertyInteractionContext(HINTERACTIONCONTEXT interactionContext, 
                                      INTERACTION_CONTEXT_PROPERTY contextProperty, uint* value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("NInput.dll")
HRESULT SetInertiaParameterInteractionContext(HINTERACTIONCONTEXT interactionContext, 
                                              INERTIA_PARAMETER inertiaParameter, float value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("NInput.dll")
HRESULT GetInertiaParameterInteractionContext(HINTERACTIONCONTEXT interactionContext, 
                                              INERTIA_PARAMETER inertiaParameter, float* value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("NInput.dll")
HRESULT SetCrossSlideParametersInteractionContext(HINTERACTIONCONTEXT interactionContext, uint parameterCount, 
                                                  CROSS_SLIDE_PARAMETER* crossSlideParameters);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("NInput.dll")
HRESULT GetCrossSlideParameterInteractionContext(HINTERACTIONCONTEXT interactionContext, 
                                                 CROSS_SLIDE_THRESHOLD threshold, float* distance);

@DllImport("NInput.dll")
HRESULT SetTapParameterInteractionContext(HINTERACTIONCONTEXT interactionContext, TAP_PARAMETER parameter, 
                                          float value);

@DllImport("NInput.dll")
HRESULT GetTapParameterInteractionContext(HINTERACTIONCONTEXT interactionContext, TAP_PARAMETER parameter, 
                                          float* value);

@DllImport("NInput.dll")
HRESULT SetHoldParameterInteractionContext(HINTERACTIONCONTEXT interactionContext, HOLD_PARAMETER parameter, 
                                           float value);

@DllImport("NInput.dll")
HRESULT GetHoldParameterInteractionContext(HINTERACTIONCONTEXT interactionContext, HOLD_PARAMETER parameter, 
                                           float* value);

@DllImport("NInput.dll")
HRESULT SetTranslationParameterInteractionContext(HINTERACTIONCONTEXT interactionContext, 
                                                  TRANSLATION_PARAMETER parameter, float value);

@DllImport("NInput.dll")
HRESULT GetTranslationParameterInteractionContext(HINTERACTIONCONTEXT interactionContext, 
                                                  TRANSLATION_PARAMETER parameter, float* value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("NInput.dll")
HRESULT SetMouseWheelParameterInteractionContext(HINTERACTIONCONTEXT interactionContext, 
                                                 MOUSE_WHEEL_PARAMETER parameter, float value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("NInput.dll")
HRESULT GetMouseWheelParameterInteractionContext(HINTERACTIONCONTEXT interactionContext, 
                                                 MOUSE_WHEEL_PARAMETER parameter, float* value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("NInput.dll")
HRESULT ResetInteractionContext(HINTERACTIONCONTEXT interactionContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("NInput.dll")
HRESULT GetStateInteractionContext(HINTERACTIONCONTEXT interactionContext, const(POINTER_INFO)* pointerInfo, 
                                   INTERACTION_STATE* state);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("NInput.dll")
HRESULT AddPointerInteractionContext(HINTERACTIONCONTEXT interactionContext, uint pointerId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("NInput.dll")
HRESULT RemovePointerInteractionContext(HINTERACTIONCONTEXT interactionContext, uint pointerId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("NInput.dll")
HRESULT ProcessPointerFramesInteractionContext(HINTERACTIONCONTEXT interactionContext, uint entriesCount, 
                                               uint pointerCount, const(POINTER_INFO)* pointerInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("NInput.dll")
HRESULT BufferPointerPacketsInteractionContext(HINTERACTIONCONTEXT interactionContext, uint entriesCount, 
                                               const(POINTER_INFO)* pointerInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("NInput.dll")
HRESULT ProcessBufferedPacketsInteractionContext(HINTERACTIONCONTEXT interactionContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("NInput.dll")
HRESULT ProcessInertiaInteractionContext(HINTERACTIONCONTEXT interactionContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("NInput.dll")
HRESULT StopInteractionContext(HINTERACTIONCONTEXT interactionContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("NInput.dll")
HRESULT SetPivotInteractionContext(HINTERACTIONCONTEXT interactionContext, float x, float y, float radius);


