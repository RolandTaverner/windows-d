// Written in the D programming language.

module windows.win32.devices.pwm;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOLEAN;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pwm/ne-pwm-pwm_polarity
alias PWM_POLARITY = int;
enum : int
{
    PWM_ACTIVE_HIGH = 0x00000000,
    PWM_ACTIVE_LOW  = 0x00000001,
}

// Constants


enum GUID GUID_DEVINTERFACE_PWM_CONTROLLER = GUID("60824b4c-eed1-4c9c-b49c-1b961461a819");
enum const(wchar)* GUID_DEVINTERFACE_PWM_CONTROLLER_WSZ = "{60824B4C-EED1-4C9C-B49C-1B961461A819}";

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/pwm/ni-pwm-ioctl_pwm_controller_get_info))], [])*/uint
{
    IOCTL_PWM_CONTROLLER_GET_INFO           = 0x00040000U,
    IOCTL_PWM_CONTROLLER_GET_ACTUAL_PERIOD  = 0x00040004U,
    IOCTL_PWM_CONTROLLER_SET_DESIRED_PERIOD = 0x00048008U,
}

enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/pwm/ni-pwm-ioctl_pwm_pin_get_active_duty_cycle_percentage))], [])*/uint IOCTL_PWM_PIN_GET_ACTIVE_DUTY_CYCLE_PERCENTAGE = 0x00040190U;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/pwm/ni-pwm-ioctl_pwm_pin_set_active_duty_cycle_percentage))], [])*/uint IOCTL_PWM_PIN_SET_ACTIVE_DUTY_CYCLE_PERCENTAGE = 0x00048194U;

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/pwm/ni-pwm-ioctl_pwm_pin_get_polarity))], [])*/uint
{
    IOCTL_PWM_PIN_GET_POLARITY = 0x00040198U,
    IOCTL_PWM_PIN_SET_POLARITY = 0x0004819cU,
    IOCTL_PWM_PIN_START        = 0x000481a3U,
    IOCTL_PWM_PIN_STOP         = 0x000481a7U,
    IOCTL_PWM_PIN_IS_STARTED   = 0x000401a8U,
}

enum : int
{
    PWM_IOCTL_ID_CONTROLLER_GET_INFO           = 0x00000000,
    PWM_IOCTL_ID_CONTROLLER_GET_ACTUAL_PERIOD  = 0x00000001,
    PWM_IOCTL_ID_CONTROLLER_SET_DESIRED_PERIOD = 0x00000002,
}

enum int PWM_IOCTL_ID_PIN_GET_ACTIVE_DUTY_CYCLE_PERCENTAGE = 0x00000064;
enum int PWM_IOCTL_ID_PIN_SET_ACTIVE_DUTY_CYCLE_PERCENTAGE = 0x00000065;

enum : int
{
    PWM_IOCTL_ID_PIN_GET_POLARITY = 0x00000066,
    PWM_IOCTL_ID_PIN_SET_POLARITY = 0x00000067,
    PWM_IOCTL_ID_PIN_START        = 0x00000068,
    PWM_IOCTL_ID_PIN_STOP         = 0x00000069,
    PWM_IOCTL_ID_PIN_IS_STARTED   = 0x0000006a,
}

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pwm/ns-pwm-pwm_controller_info
struct PWM_CONTROLLER_INFO
{
    size_t Size;
    uint   PinCount;
    ulong  MinimumPeriod;
    ulong  MaximumPeriod;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DevIO/pwm-controller-get-actual-period-output
struct PWM_CONTROLLER_GET_ACTUAL_PERIOD_OUTPUT
{
    ulong ActualPeriod;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pwm/ns-pwm-pwm_controller_set_desired_period_input
struct PWM_CONTROLLER_SET_DESIRED_PERIOD_INPUT
{
    ulong DesiredPeriod;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pwm/ns-pwm-pwm_controller_set_desired_period_output
struct PWM_CONTROLLER_SET_DESIRED_PERIOD_OUTPUT
{
    ulong ActualPeriod;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DevIO/pwm-pin-get-active-duty-cycle-percentage-output
struct PWM_PIN_GET_ACTIVE_DUTY_CYCLE_PERCENTAGE_OUTPUT
{
    ulong Percentage;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DevIO/pwm-pin-set-active-duty-cycle-percentage-input
struct PWM_PIN_SET_ACTIVE_DUTY_CYCLE_PERCENTAGE_INPUT
{
    ulong Percentage;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DevIO/pwm-pin-get-polarity-output
struct PWM_PIN_GET_POLARITY_OUTPUT
{
    PWM_POLARITY Polarity;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pwm/ns-pwm-pwm_pin_set_polarity_input
struct PWM_PIN_SET_POLARITY_INPUT
{
    PWM_POLARITY Polarity;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DevIO/pwm-pin-is-started-output
struct PWM_PIN_IS_STARTED_OUTPUT
{
    BOOLEAN IsStarted;
}

