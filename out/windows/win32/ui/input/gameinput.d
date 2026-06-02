// Written in the D programming language.

module windows.win32.ui.input.gameinput;

public import windows.core;
public import windows.win32.foundation : APP_LOCAL_DEVICE_ID, HANDLE, HRESULT, PSTR, PWSTR;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums


enum GameInputKind : int
{
    GameInputKindUnknown          = 0x00000000,
    GameInputKindRawDeviceReport  = 0x00000001,
    GameInputKindControllerAxis   = 0x00000002,
    GameInputKindControllerButton = 0x00000004,
    GameInputKindControllerSwitch = 0x00000008,
    GameInputKindController       = 0x0000000e,
    GameInputKindKeyboard         = 0x00000010,
    GameInputKindMouse            = 0x00000020,
    GameInputKindTouch            = 0x00000100,
    GameInputKindMotion           = 0x00001000,
    GameInputKindArcadeStick      = 0x00010000,
    GameInputKindFlightStick      = 0x00020000,
    GameInputKindGamepad          = 0x00040000,
    GameInputKindRacingWheel      = 0x00080000,
    GameInputKindUiNavigation     = 0x01000000,
}

enum GameInputEnumerationKind : int
{
    GameInputNoEnumeration       = 0x00000000,
    GameInputAsyncEnumeration    = 0x00000001,
    GameInputBlockingEnumeration = 0x00000002,
}

enum GameInputFocusPolicy : int
{
    GameInputDefaultFocusPolicy             = 0x00000000,
    GameInputDisableBackgroundInput         = 0x00000001,
    GameInputExclusiveForegroundInput       = 0x00000002,
    GameInputDisableBackgroundGuideButton   = 0x00000004,
    GameInputExclusiveForegroundGuideButton = 0x00000008,
    GameInputDisableBackgroundShareButton   = 0x00000010,
    GameInputExclusiveForegroundShareButton = 0x00000020,
}

enum GameInputSwitchKind : int
{
    GameInputUnknownSwitchKind = 0xffffffff,
    GameInput2WaySwitch        = 0x00000000,
    GameInput4WaySwitch        = 0x00000001,
    GameInput8WaySwitch        = 0x00000002,
}

enum GameInputSwitchPosition : int
{
    GameInputSwitchCenter    = 0x00000000,
    GameInputSwitchUp        = 0x00000001,
    GameInputSwitchUpRight   = 0x00000002,
    GameInputSwitchRight     = 0x00000003,
    GameInputSwitchDownRight = 0x00000004,
    GameInputSwitchDown      = 0x00000005,
    GameInputSwitchDownLeft  = 0x00000006,
    GameInputSwitchLeft      = 0x00000007,
    GameInputSwitchUpLeft    = 0x00000008,
}

enum GameInputKeyboardKind : int
{
    GameInputUnknownKeyboard = 0xffffffff,
    GameInputAnsiKeyboard    = 0x00000000,
    GameInputIsoKeyboard     = 0x00000001,
    GameInputKsKeyboard      = 0x00000002,
    GameInputAbntKeyboard    = 0x00000003,
    GameInputJisKeyboard     = 0x00000004,
}

enum GameInputMouseButtons : int
{
    GameInputMouseNone           = 0x00000000,
    GameInputMouseLeftButton     = 0x00000001,
    GameInputMouseRightButton    = 0x00000002,
    GameInputMouseMiddleButton   = 0x00000004,
    GameInputMouseButton4        = 0x00000008,
    GameInputMouseButton5        = 0x00000010,
    GameInputMouseWheelTiltLeft  = 0x00000020,
    GameInputMouseWheelTiltRight = 0x00000040,
}

enum GameInputTouchShape : int
{
    GameInputTouchShapeUnknown       = 0xffffffff,
    GameInputTouchShapePoint         = 0x00000000,
    GameInputTouchShape1DLinear      = 0x00000001,
    GameInputTouchShape1DRadial      = 0x00000002,
    GameInputTouchShape1DIrregular   = 0x00000003,
    GameInputTouchShape2DRectangular = 0x00000004,
    GameInputTouchShape2DElliptical  = 0x00000005,
    GameInputTouchShape2DIrregular   = 0x00000006,
}

enum GameInputMotionAccuracy : int
{
    GameInputMotionAccuracyUnknown = 0xffffffff,
    GameInputMotionUnavailable     = 0x00000000,
    GameInputMotionUnreliable      = 0x00000001,
    GameInputMotionApproximate     = 0x00000002,
    GameInputMotionAccurate        = 0x00000003,
}

enum GameInputArcadeStickButtons : int
{
    GameInputArcadeStickNone     = 0x00000000,
    GameInputArcadeStickMenu     = 0x00000001,
    GameInputArcadeStickView     = 0x00000002,
    GameInputArcadeStickUp       = 0x00000004,
    GameInputArcadeStickDown     = 0x00000008,
    GameInputArcadeStickLeft     = 0x00000010,
    GameInputArcadeStickRight    = 0x00000020,
    GameInputArcadeStickAction1  = 0x00000040,
    GameInputArcadeStickAction2  = 0x00000080,
    GameInputArcadeStickAction3  = 0x00000100,
    GameInputArcadeStickAction4  = 0x00000200,
    GameInputArcadeStickAction5  = 0x00000400,
    GameInputArcadeStickAction6  = 0x00000800,
    GameInputArcadeStickSpecial1 = 0x00001000,
    GameInputArcadeStickSpecial2 = 0x00002000,
}

enum GameInputFlightStickButtons : int
{
    GameInputFlightStickNone          = 0x00000000,
    GameInputFlightStickMenu          = 0x00000001,
    GameInputFlightStickView          = 0x00000002,
    GameInputFlightStickFirePrimary   = 0x00000004,
    GameInputFlightStickFireSecondary = 0x00000008,
}

enum GameInputGamepadButtons : int
{
    GameInputGamepadNone            = 0x00000000,
    GameInputGamepadMenu            = 0x00000001,
    GameInputGamepadView            = 0x00000002,
    GameInputGamepadA               = 0x00000004,
    GameInputGamepadB               = 0x00000008,
    GameInputGamepadX               = 0x00000010,
    GameInputGamepadY               = 0x00000020,
    GameInputGamepadDPadUp          = 0x00000040,
    GameInputGamepadDPadDown        = 0x00000080,
    GameInputGamepadDPadLeft        = 0x00000100,
    GameInputGamepadDPadRight       = 0x00000200,
    GameInputGamepadLeftShoulder    = 0x00000400,
    GameInputGamepadRightShoulder   = 0x00000800,
    GameInputGamepadLeftThumbstick  = 0x00001000,
    GameInputGamepadRightThumbstick = 0x00002000,
}

enum GameInputRacingWheelButtons : int
{
    GameInputRacingWheelNone         = 0x00000000,
    GameInputRacingWheelMenu         = 0x00000001,
    GameInputRacingWheelView         = 0x00000002,
    GameInputRacingWheelPreviousGear = 0x00000004,
    GameInputRacingWheelNextGear     = 0x00000008,
    GameInputRacingWheelDpadUp       = 0x00000010,
    GameInputRacingWheelDpadDown     = 0x00000020,
    GameInputRacingWheelDpadLeft     = 0x00000040,
    GameInputRacingWheelDpadRight    = 0x00000080,
}

enum GameInputUiNavigationButtons : int
{
    GameInputUiNavigationNone        = 0x00000000,
    GameInputUiNavigationMenu        = 0x00000001,
    GameInputUiNavigationView        = 0x00000002,
    GameInputUiNavigationAccept      = 0x00000004,
    GameInputUiNavigationCancel      = 0x00000008,
    GameInputUiNavigationUp          = 0x00000010,
    GameInputUiNavigationDown        = 0x00000020,
    GameInputUiNavigationLeft        = 0x00000040,
    GameInputUiNavigationRight       = 0x00000080,
    GameInputUiNavigationContext1    = 0x00000100,
    GameInputUiNavigationContext2    = 0x00000200,
    GameInputUiNavigationContext3    = 0x00000400,
    GameInputUiNavigationContext4    = 0x00000800,
    GameInputUiNavigationPageUp      = 0x00001000,
    GameInputUiNavigationPageDown    = 0x00002000,
    GameInputUiNavigationPageLeft    = 0x00004000,
    GameInputUiNavigationPageRight   = 0x00008000,
    GameInputUiNavigationScrollUp    = 0x00010000,
    GameInputUiNavigationScrollDown  = 0x00020000,
    GameInputUiNavigationScrollLeft  = 0x00040000,
    GameInputUiNavigationScrollRight = 0x00080000,
}

enum GameInputSystemButtons : int
{
    GameInputSystemButtonNone  = 0x00000000,
    GameInputSystemButtonGuide = 0x00000001,
    GameInputSystemButtonShare = 0x00000002,
}

enum GameInputDeviceStatus : int
{
    GameInputDeviceNoStatus      = 0x00000000,
    GameInputDeviceConnected     = 0x00000001,
    GameInputDeviceInputEnabled  = 0x00000002,
    GameInputDeviceOutputEnabled = 0x00000004,
    GameInputDeviceRawIoEnabled  = 0x00000008,
    GameInputDeviceAudioCapture  = 0x00000010,
    GameInputDeviceAudioRender   = 0x00000020,
    GameInputDeviceSynchronized  = 0x00000040,
    GameInputDeviceWireless      = 0x00000080,
    GameInputDeviceUserIdle      = 0x00100000,
    GameInputDeviceAnyStatus     = 0x00ffffff,
}

enum GameInputBatteryStatus : int
{
    GameInputBatteryUnknown     = 0xffffffff,
    GameInputBatteryNotPresent  = 0x00000000,
    GameInputBatteryDischarging = 0x00000001,
    GameInputBatteryIdle        = 0x00000002,
    GameInputBatteryCharging    = 0x00000003,
}

enum GameInputDeviceFamily : int
{
    GameInputFamilyVirtual   = 0xffffffff,
    GameInputFamilyAggregate = 0x00000000,
    GameInputFamilyXboxOne   = 0x00000001,
    GameInputFamilyXbox360   = 0x00000002,
    GameInputFamilyHid       = 0x00000003,
    GameInputFamilyI8042     = 0x00000004,
}

enum GameInputDeviceCapabilities : int
{
    GameInputDeviceCapabilityNone            = 0x00000000,
    GameInputDeviceCapabilityAudio           = 0x00000001,
    GameInputDeviceCapabilityPluginModule    = 0x00000002,
    GameInputDeviceCapabilityPowerOff        = 0x00000004,
    GameInputDeviceCapabilitySynchronization = 0x00000008,
    GameInputDeviceCapabilityWireless        = 0x00000010,
}

enum GameInputRawDeviceReportKind : int
{
    GameInputRawInputReport   = 0x00000000,
    GameInputRawOutputReport  = 0x00000001,
    GameInputRawFeatureReport = 0x00000002,
}

enum GameInputRawDeviceReportItemFlags : int
{
    GameInputDefaultItem    = 0x00000000,
    GameInputConstantItem   = 0x00000001,
    GameInputArrayItem      = 0x00000002,
    GameInputRelativeItem   = 0x00000004,
    GameInputWraparoundItem = 0x00000008,
    GameInputNonlinearItem  = 0x00000010,
    GameInputStableItem     = 0x00000020,
    GameInputNullableItem   = 0x00000040,
    GameInputVolatileItem   = 0x00000080,
    GameInputBufferedItem   = 0x00000100,
}

enum GameInputRawDeviceItemCollectionKind : int
{
    GameInputUnknownItemCollection       = 0xffffffff,
    GameInputPhysicalItemCollection      = 0x00000000,
    GameInputApplicationItemCollection   = 0x00000001,
    GameInputLogicalItemCollection       = 0x00000002,
    GameInputReportItemCollection        = 0x00000003,
    GameInputNamedArrayItemCollection    = 0x00000004,
    GameInputUsageSwitchItemCollection   = 0x00000005,
    GameInputUsageModifierItemCollection = 0x00000006,
}

enum GameInputRawDevicePhysicalUnitKind : int
{
    GameInputPhysicalUnitUnknown             = 0xffffffff,
    GameInputPhysicalUnitNone                = 0x00000000,
    GameInputPhysicalUnitTime                = 0x00000001,
    GameInputPhysicalUnitFrequency           = 0x00000002,
    GameInputPhysicalUnitLength              = 0x00000003,
    GameInputPhysicalUnitVelocity            = 0x00000004,
    GameInputPhysicalUnitAcceleration        = 0x00000005,
    GameInputPhysicalUnitMass                = 0x00000006,
    GameInputPhysicalUnitMomentum            = 0x00000007,
    GameInputPhysicalUnitForce               = 0x00000008,
    GameInputPhysicalUnitPressure            = 0x00000009,
    GameInputPhysicalUnitAngle               = 0x0000000a,
    GameInputPhysicalUnitAngularVelocity     = 0x0000000b,
    GameInputPhysicalUnitAngularAcceleration = 0x0000000c,
    GameInputPhysicalUnitAngularMass         = 0x0000000d,
    GameInputPhysicalUnitAngularMomentum     = 0x0000000e,
    GameInputPhysicalUnitAngularTorque       = 0x0000000f,
    GameInputPhysicalUnitElectricCurrent     = 0x00000010,
    GameInputPhysicalUnitElectricCharge      = 0x00000011,
    GameInputPhysicalUnitElectricPotential   = 0x00000012,
    GameInputPhysicalUnitEnergy              = 0x00000013,
    GameInputPhysicalUnitPower               = 0x00000014,
    GameInputPhysicalUnitTemperature         = 0x00000015,
    GameInputPhysicalUnitLuminousIntensity   = 0x00000016,
    GameInputPhysicalUnitLuminousFlux        = 0x00000017,
    GameInputPhysicalUnitIlluminance         = 0x00000018,
}

enum GameInputLabel : int
{
    GameInputLabelUnknown                  = 0xffffffff,
    GameInputLabelNone                     = 0x00000000,
    GameInputLabelXboxGuide                = 0x00000001,
    GameInputLabelXboxBack                 = 0x00000002,
    GameInputLabelXboxStart                = 0x00000003,
    GameInputLabelXboxMenu                 = 0x00000004,
    GameInputLabelXboxView                 = 0x00000005,
    GameInputLabelXboxA                    = 0x00000007,
    GameInputLabelXboxB                    = 0x00000008,
    GameInputLabelXboxX                    = 0x00000009,
    GameInputLabelXboxY                    = 0x0000000a,
    GameInputLabelXboxDPadUp               = 0x0000000b,
    GameInputLabelXboxDPadDown             = 0x0000000c,
    GameInputLabelXboxDPadLeft             = 0x0000000d,
    GameInputLabelXboxDPadRight            = 0x0000000e,
    GameInputLabelXboxLeftShoulder         = 0x0000000f,
    GameInputLabelXboxLeftTrigger          = 0x00000010,
    GameInputLabelXboxLeftStickButton      = 0x00000011,
    GameInputLabelXboxRightShoulder        = 0x00000012,
    GameInputLabelXboxRightTrigger         = 0x00000013,
    GameInputLabelXboxRightStickButton     = 0x00000014,
    GameInputLabelXboxPaddle1              = 0x00000015,
    GameInputLabelXboxPaddle2              = 0x00000016,
    GameInputLabelXboxPaddle3              = 0x00000017,
    GameInputLabelXboxPaddle4              = 0x00000018,
    GameInputLabelLetterA                  = 0x00000019,
    GameInputLabelLetterB                  = 0x0000001a,
    GameInputLabelLetterC                  = 0x0000001b,
    GameInputLabelLetterD                  = 0x0000001c,
    GameInputLabelLetterE                  = 0x0000001d,
    GameInputLabelLetterF                  = 0x0000001e,
    GameInputLabelLetterG                  = 0x0000001f,
    GameInputLabelLetterH                  = 0x00000020,
    GameInputLabelLetterI                  = 0x00000021,
    GameInputLabelLetterJ                  = 0x00000022,
    GameInputLabelLetterK                  = 0x00000023,
    GameInputLabelLetterL                  = 0x00000024,
    GameInputLabelLetterM                  = 0x00000025,
    GameInputLabelLetterN                  = 0x00000026,
    GameInputLabelLetterO                  = 0x00000027,
    GameInputLabelLetterP                  = 0x00000028,
    GameInputLabelLetterQ                  = 0x00000029,
    GameInputLabelLetterR                  = 0x0000002a,
    GameInputLabelLetterS                  = 0x0000002b,
    GameInputLabelLetterT                  = 0x0000002c,
    GameInputLabelLetterU                  = 0x0000002d,
    GameInputLabelLetterV                  = 0x0000002e,
    GameInputLabelLetterW                  = 0x0000002f,
    GameInputLabelLetterX                  = 0x00000030,
    GameInputLabelLetterY                  = 0x00000031,
    GameInputLabelLetterZ                  = 0x00000032,
    GameInputLabelNumber0                  = 0x00000033,
    GameInputLabelNumber1                  = 0x00000034,
    GameInputLabelNumber2                  = 0x00000035,
    GameInputLabelNumber3                  = 0x00000036,
    GameInputLabelNumber4                  = 0x00000037,
    GameInputLabelNumber5                  = 0x00000038,
    GameInputLabelNumber6                  = 0x00000039,
    GameInputLabelNumber7                  = 0x0000003a,
    GameInputLabelNumber8                  = 0x0000003b,
    GameInputLabelNumber9                  = 0x0000003c,
    GameInputLabelArrowUp                  = 0x0000003d,
    GameInputLabelArrowUpRight             = 0x0000003e,
    GameInputLabelArrowRight               = 0x0000003f,
    GameInputLabelArrowDownRight           = 0x00000040,
    GameInputLabelArrowDown                = 0x00000041,
    GameInputLabelArrowDownLLeft           = 0x00000042,
    GameInputLabelArrowLeft                = 0x00000043,
    GameInputLabelArrowUpLeft              = 0x00000044,
    GameInputLabelArrowUpDown              = 0x00000045,
    GameInputLabelArrowLeftRight           = 0x00000046,
    GameInputLabelArrowUpDownLeftRight     = 0x00000047,
    GameInputLabelArrowClockwise           = 0x00000048,
    GameInputLabelArrowCounterClockwise    = 0x00000049,
    GameInputLabelArrowReturn              = 0x0000004a,
    GameInputLabelIconBranding             = 0x0000004b,
    GameInputLabelIconHome                 = 0x0000004c,
    GameInputLabelIconMenu                 = 0x0000004d,
    GameInputLabelIconCross                = 0x0000004e,
    GameInputLabelIconCircle               = 0x0000004f,
    GameInputLabelIconSquare               = 0x00000050,
    GameInputLabelIconTriangle             = 0x00000051,
    GameInputLabelIconStar                 = 0x00000052,
    GameInputLabelIconDPadUp               = 0x00000053,
    GameInputLabelIconDPadDown             = 0x00000054,
    GameInputLabelIconDPadLeft             = 0x00000055,
    GameInputLabelIconDPadRight            = 0x00000056,
    GameInputLabelIconDialClockwise        = 0x00000057,
    GameInputLabelIconDialCounterClockwise = 0x00000058,
    GameInputLabelIconSliderLeftRight      = 0x00000059,
    GameInputLabelIconSliderUpDown         = 0x0000005a,
    GameInputLabelIconWheelUpDown          = 0x0000005b,
    GameInputLabelIconPlus                 = 0x0000005c,
    GameInputLabelIconMinus                = 0x0000005d,
    GameInputLabelIconSuspension           = 0x0000005e,
    GameInputLabelHome                     = 0x0000005f,
    GameInputLabelGuide                    = 0x00000060,
    GameInputLabelMode                     = 0x00000061,
    GameInputLabelSelect                   = 0x00000062,
    GameInputLabelMenu                     = 0x00000063,
    GameInputLabelView                     = 0x00000064,
    GameInputLabelBack                     = 0x00000065,
    GameInputLabelStart                    = 0x00000066,
    GameInputLabelOptions                  = 0x00000067,
    GameInputLabelShare                    = 0x00000068,
    GameInputLabelUp                       = 0x00000069,
    GameInputLabelDown                     = 0x0000006a,
    GameInputLabelLeft                     = 0x0000006b,
    GameInputLabelRight                    = 0x0000006c,
    GameInputLabelLB                       = 0x0000006d,
    GameInputLabelLT                       = 0x0000006e,
    GameInputLabelLSB                      = 0x0000006f,
    GameInputLabelL1                       = 0x00000070,
    GameInputLabelL2                       = 0x00000071,
    GameInputLabelL3                       = 0x00000072,
    GameInputLabelRB                       = 0x00000073,
    GameInputLabelRT                       = 0x00000074,
    GameInputLabelRSB                      = 0x00000075,
    GameInputLabelR1                       = 0x00000076,
    GameInputLabelR2                       = 0x00000077,
    GameInputLabelR3                       = 0x00000078,
    GameInputLabelP1                       = 0x00000079,
    GameInputLabelP2                       = 0x0000007a,
    GameInputLabelP3                       = 0x0000007b,
    GameInputLabelP4                       = 0x0000007c,
}

enum GameInputLocation : int
{
    GameInputLocationUnknown  = 0xffffffff,
    GameInputLocationChassis  = 0x00000000,
    GameInputLocationDisplay  = 0x00000001,
    GameInputLocationAxis     = 0x00000002,
    GameInputLocationButton   = 0x00000003,
    GameInputLocationSwitch   = 0x00000004,
    GameInputLocationKey      = 0x00000005,
    GameInputLocationTouchPad = 0x00000006,
}

enum GameInputFeedbackAxes : int
{
    GameInputFeedbackAxisNone     = 0x00000000,
    GameInputFeedbackAxisLinearX  = 0x00000001,
    GameInputFeedbackAxisLinearY  = 0x00000002,
    GameInputFeedbackAxisLinearZ  = 0x00000004,
    GameInputFeedbackAxisAngularX = 0x00000008,
    GameInputFeedbackAxisAngularY = 0x00000010,
    GameInputFeedbackAxisAngularZ = 0x00000020,
    GameInputFeedbackAxisNormal   = 0x00000040,
}

enum GameInputFeedbackEffectState : int
{
    GameInputFeedbackStopped = 0x00000000,
    GameInputFeedbackRunning = 0x00000001,
    GameInputFeedbackPaused  = 0x00000002,
}

enum GameInputForceFeedbackEffectKind : int
{
    GameInputForceFeedbackConstant         = 0x00000000,
    GameInputForceFeedbackRamp             = 0x00000001,
    GameInputForceFeedbackSineWave         = 0x00000002,
    GameInputForceFeedbackSquareWave       = 0x00000003,
    GameInputForceFeedbackTriangleWave     = 0x00000004,
    GameInputForceFeedbackSawtoothUpWave   = 0x00000005,
    GameInputForceFeedbackSawtoothDownWave = 0x00000006,
    GameInputForceFeedbackSpring           = 0x00000007,
    GameInputForceFeedbackFriction         = 0x00000008,
    GameInputForceFeedbackDamper           = 0x00000009,
    GameInputForceFeedbackInertia          = 0x0000000a,
}

enum GameInputRumbleMotors : int
{
    GameInputRumbleNone          = 0x00000000,
    GameInputRumbleLowFrequency  = 0x00000001,
    GameInputRumbleHighFrequency = 0x00000002,
    GameInputRumbleLeftTrigger   = 0x00000004,
    GameInputRumbleRightTrigger  = 0x00000008,
}

// Constants


enum uint FACILITY_GAMEINPUT = 0x0000038aU;

enum : HRESULT
{
    GAMEINPUT_E_DEVICE_DISCONNECTED       = HRESULT(0x838a0001),
    GAMEINPUT_E_DEVICE_NOT_FOUND          = HRESULT(0x838a0002),
    GAMEINPUT_E_READING_NOT_FOUND         = HRESULT(0x838a0003),
    GAMEINPUT_E_REFERENCE_READING_TOO_OLD = HRESULT(0x838a0004),
}

enum HRESULT GAMEINPUT_E_TIMESTAMP_OUT_OF_RANGE = HRESULT(0x838a0005);
enum HRESULT GAMEINPUT_E_INSUFFICIENT_FORCE_FEEDBACK_RESOURCES = HRESULT(0x838a0006);

// Callbacks

alias GameInputReadingCallback = void function(ulong callbackToken, void* context, IGameInputReading reading, 
                                               bool hasOverrunOccurred);
alias GameInputDeviceCallback = void function(ulong callbackToken, void* context, IGameInputDevice device, 
                                              ulong timestamp, GameInputDeviceStatus currentStatus, 
                                              GameInputDeviceStatus previousStatus);
alias GameInputSystemButtonCallback = void function(ulong callbackToken, void* context, IGameInputDevice device, 
                                                    ulong timestamp, GameInputSystemButtons currentButtons, 
                                                    GameInputSystemButtons previousButtons);
alias GameInputKeyboardLayoutCallback = void function(ulong callbackToken, void* context, IGameInputDevice device, 
                                                      ulong timestamp, uint currentLayout, uint previousLayout);

// Structs


struct GameInputKeyState
{
    uint  scanCode;
    uint  codePoint;
    ubyte virtualKey;
    ubyte isDeadKey;
}

struct GameInputMouseState
{
    GameInputMouseButtons buttons;
    long positionX;
    long positionY;
    long wheelX;
    long wheelY;
}

struct GameInputTouchState
{
    ulong touchId;
    uint  sensorIndex;
    float positionX;
    float positionY;
    float pressure;
    float proximity;
    float contactRectTop;
    float contactRectLeft;
    float contactRectRight;
    float contactRectBottom;
}

struct GameInputMotionState
{
    float accelerationX;
    float accelerationY;
    float accelerationZ;
    float angularVelocityX;
    float angularVelocityY;
    float angularVelocityZ;
    float magneticFieldX;
    float magneticFieldY;
    float magneticFieldZ;
    float orientationW;
    float orientationX;
    float orientationY;
    float orientationZ;
    GameInputMotionAccuracy accelerometerAccuracy;
    GameInputMotionAccuracy gyroscopeAccuracy;
    GameInputMotionAccuracy magnetometerAccuracy;
    GameInputMotionAccuracy orientationAccuracy;
}

struct GameInputArcadeStickState
{
    GameInputArcadeStickButtons buttons;
}

struct GameInputFlightStickState
{
    GameInputFlightStickButtons buttons;
    GameInputSwitchPosition hatSwitch;
    float roll;
    float pitch;
    float yaw;
    float throttle;
}

struct GameInputGamepadState
{
    GameInputGamepadButtons buttons;
    float leftTrigger;
    float rightTrigger;
    float leftThumbstickX;
    float leftThumbstickY;
    float rightThumbstickX;
    float rightThumbstickY;
}

struct GameInputRacingWheelState
{
    GameInputRacingWheelButtons buttons;
    int   patternShifterGear;
    float wheel;
    float throttle;
    float brake;
    float clutch;
    float handbrake;
}

struct GameInputUiNavigationState
{
    GameInputUiNavigationButtons buttons;
}

struct GameInputBatteryState
{
    float chargeRate;
    float maxChargeRate;
    float remainingCapacity;
    float fullChargeCapacity;
    GameInputBatteryStatus status;
}

struct GameInputString
{
    uint        sizeInBytes;
    uint        codePointCount;
    const(PSTR) data;
}

struct GameInputUsage
{
    ushort page;
    ushort id;
}

struct GameInputVersion
{
    ushort major;
    ushort minor;
    ushort build;
    ushort revision;
}

struct GameInputRawDeviceItemCollectionInfo
{
    GameInputRawDeviceItemCollectionKind kind;
    uint childCount;
    uint siblingCount;
    uint usageCount;
    const(GameInputUsage)* usages;
    const(GameInputRawDeviceItemCollectionInfo)* parent;
    const(GameInputRawDeviceItemCollectionInfo)* firstSibling;
    const(GameInputRawDeviceItemCollectionInfo)* previousSibling;
    const(GameInputRawDeviceItemCollectionInfo)* nextSibling;
    const(GameInputRawDeviceItemCollectionInfo)* lastSibling;
    const(GameInputRawDeviceItemCollectionInfo)* firstChild;
    const(GameInputRawDeviceItemCollectionInfo)* lastChild;
}

struct GameInputRawDeviceReportItemInfo
{
    uint   bitOffset;
    uint   bitSize;
    long   logicalMin;
    long   logicalMax;
    double physicalMin;
    double physicalMax;
    GameInputRawDevicePhysicalUnitKind physicalUnits;
    uint   rawPhysicalUnits;
    int    rawPhysicalUnitsExponent;
    GameInputRawDeviceReportItemFlags flags;
    uint   usageCount;
    const(GameInputUsage)* usages;
    const(GameInputRawDeviceItemCollectionInfo)* collection;
    const(GameInputString)* itemString;
}

struct GameInputRawDeviceReportInfo
{
    GameInputRawDeviceReportKind kind;
    uint id;
    uint size;
    uint itemCount;
    const(GameInputRawDeviceReportItemInfo)* items;
}

struct GameInputControllerAxisInfo
{
    GameInputKind  mappedInputKinds;
    GameInputLabel label;
    ubyte          isContinuous;
    ubyte          isNonlinear;
    ubyte          isQuantized;
    ubyte          hasRestValue;
    float          restValue;
    ulong          resolution;
    ushort         legacyDInputIndex;
    ushort         legacyHidIndex;
    uint           rawReportIndex;
    const(GameInputRawDeviceReportInfo)* inputReport;
    const(GameInputRawDeviceReportItemInfo)* inputReportItem;
}

struct GameInputControllerButtonInfo
{
    GameInputKind  mappedInputKinds;
    GameInputLabel label;
    ushort         legacyDInputIndex;
    ushort         legacyHidIndex;
    uint           rawReportIndex;
    const(GameInputRawDeviceReportInfo)* inputReport;
    const(GameInputRawDeviceReportItemInfo)* inputReportItem;
}

struct GameInputControllerSwitchInfo
{
    GameInputKind       mappedInputKinds;
    GameInputLabel      label;
    GameInputLabel[9]   positionLabels;
    GameInputSwitchKind kind;
    ushort              legacyDInputIndex;
    ushort              legacyHidIndex;
    uint                rawReportIndex;
    const(GameInputRawDeviceReportInfo)* inputReport;
    const(GameInputRawDeviceReportItemInfo)* inputReportItem;
}

struct GameInputKeyboardInfo
{
    GameInputKeyboardKind kind;
    uint layout;
    uint keyCount;
    uint functionKeyCount;
    uint maxSimultaneousKeys;
    uint platformType;
    uint platformSubtype;
    const(GameInputString)* nativeLanguage;
}

struct GameInputMouseInfo
{
    GameInputMouseButtons supportedButtons;
    uint  sampleRate;
    uint  sensorDpi;
    ubyte hasWheelX;
    ubyte hasWheelY;
}

struct GameInputTouchSensorInfo
{
    GameInputKind       mappedInputKinds;
    GameInputLabel      label;
    GameInputLocation   location;
    uint                locationId;
    ulong               resolutionX;
    ulong               resolutionY;
    GameInputTouchShape shape;
    float               aspectRatio;
    float               orientation;
    float               physicalWidth;
    float               physicalHeight;
    float               maxPressure;
    float               maxProximity;
    uint                maxTouchPoints;
}

struct GameInputMotionInfo
{
    float maxAcceleration;
    float maxAngularVelocity;
    float maxMagneticFieldStrength;
}

struct GameInputArcadeStickInfo
{
    GameInputLabel menuButtonLabel;
    GameInputLabel viewButtonLabel;
    GameInputLabel stickUpLabel;
    GameInputLabel stickDownLabel;
    GameInputLabel stickLeftLabel;
    GameInputLabel stickRightLabel;
    GameInputLabel actionButton1Label;
    GameInputLabel actionButton2Label;
    GameInputLabel actionButton3Label;
    GameInputLabel actionButton4Label;
    GameInputLabel actionButton5Label;
    GameInputLabel actionButton6Label;
    GameInputLabel specialButton1Label;
    GameInputLabel specialButton2Label;
}

struct GameInputFlightStickInfo
{
    GameInputLabel      menuButtonLabel;
    GameInputLabel      viewButtonLabel;
    GameInputLabel      firePrimaryButtonLabel;
    GameInputLabel      fireSecondaryButtonLabel;
    GameInputSwitchKind hatSwitchKind;
}

struct GameInputGamepadInfo
{
    GameInputLabel menuButtonLabel;
    GameInputLabel viewButtonLabel;
    GameInputLabel aButtonLabel;
    GameInputLabel bButtonLabel;
    GameInputLabel xButtonLabel;
    GameInputLabel yButtonLabel;
    GameInputLabel dpadUpLabel;
    GameInputLabel dpadDownLabel;
    GameInputLabel dpadLeftLabel;
    GameInputLabel dpadRightLabel;
    GameInputLabel leftShoulderButtonLabel;
    GameInputLabel rightShoulderButtonLabel;
    GameInputLabel leftThumbstickButtonLabel;
    GameInputLabel rightThumbstickButtonLabel;
}

struct GameInputRacingWheelInfo
{
    GameInputLabel menuButtonLabel;
    GameInputLabel viewButtonLabel;
    GameInputLabel previousGearButtonLabel;
    GameInputLabel nextGearButtonLabel;
    GameInputLabel dpadUpLabel;
    GameInputLabel dpadDownLabel;
    GameInputLabel dpadLeftLabel;
    GameInputLabel dpadRightLabel;
    ubyte          hasClutch;
    ubyte          hasHandbrake;
    ubyte          hasPatternShifter;
    int            minPatternShifterGear;
    int            maxPatternShifterGear;
    float          maxWheelAngle;
}

struct GameInputUiNavigationInfo
{
    GameInputLabel menuButtonLabel;
    GameInputLabel viewButtonLabel;
    GameInputLabel acceptButtonLabel;
    GameInputLabel cancelButtonLabel;
    GameInputLabel upButtonLabel;
    GameInputLabel downButtonLabel;
    GameInputLabel leftButtonLabel;
    GameInputLabel rightButtonLabel;
    GameInputLabel contextButton1Label;
    GameInputLabel contextButton2Label;
    GameInputLabel contextButton3Label;
    GameInputLabel contextButton4Label;
    GameInputLabel pageUpButtonLabel;
    GameInputLabel pageDownButtonLabel;
    GameInputLabel pageLeftButtonLabel;
    GameInputLabel pageRightButtonLabel;
    GameInputLabel scrollUpButtonLabel;
    GameInputLabel scrollDownButtonLabel;
    GameInputLabel scrollLeftButtonLabel;
    GameInputLabel scrollRightButtonLabel;
    GameInputLabel guideButtonLabel;
}

struct GameInputForceFeedbackMotorInfo
{
    GameInputFeedbackAxes supportedAxes;
    GameInputLocation location;
    uint              locationId;
    uint              maxSimultaneousEffects;
    ubyte             isConstantEffectSupported;
    ubyte             isRampEffectSupported;
    ubyte             isSineWaveEffectSupported;
    ubyte             isSquareWaveEffectSupported;
    ubyte             isTriangleWaveEffectSupported;
    ubyte             isSawtoothUpWaveEffectSupported;
    ubyte             isSawtoothDownWaveEffectSupported;
    ubyte             isSpringEffectSupported;
    ubyte             isFrictionEffectSupported;
    ubyte             isDamperEffectSupported;
    ubyte             isInertiaEffectSupported;
}

struct GameInputHapticWaveformInfo
{
    GameInputUsage usage;
    ubyte          isDurationSupported;
    ubyte          isIntensitySupported;
    ubyte          isRepeatSupported;
    ubyte          isRepeatDelaySupported;
    ulong          defaultDuration;
}

struct GameInputHapticFeedbackMotorInfo
{
    GameInputRumbleMotors mappedRumbleMotors;
    GameInputLocation location;
    uint              locationId;
    uint              waveformCount;
    const(GameInputHapticWaveformInfo)* waveformInfo;
}

struct GameInputDeviceInfo
{
    uint                infoSize;
    ushort              vendorId;
    ushort              productId;
    ushort              revisionNumber;
    ubyte               interfaceNumber;
    ubyte               collectionNumber;
    GameInputUsage      usage;
    GameInputVersion    hardwareVersion;
    GameInputVersion    firmwareVersion;
    APP_LOCAL_DEVICE_ID deviceId;
    APP_LOCAL_DEVICE_ID deviceRootId;
    GameInputDeviceFamily deviceFamily;
    GameInputDeviceCapabilities capabilities;
    GameInputKind       supportedInput;
    GameInputRumbleMotors supportedRumbleMotors;
    uint                inputReportCount;
    uint                outputReportCount;
    uint                featureReportCount;
    uint                controllerAxisCount;
    uint                controllerButtonCount;
    uint                controllerSwitchCount;
    uint                touchPointCount;
    uint                touchSensorCount;
    uint                forceFeedbackMotorCount;
    uint                hapticFeedbackMotorCount;
    uint                deviceStringCount;
    uint                deviceDescriptorSize;
    const(GameInputRawDeviceReportInfo)* inputReportInfo;
    const(GameInputRawDeviceReportInfo)* outputReportInfo;
    const(GameInputRawDeviceReportInfo)* featureReportInfo;
    const(GameInputControllerAxisInfo)* controllerAxisInfo;
    const(GameInputControllerButtonInfo)* controllerButtonInfo;
    const(GameInputControllerSwitchInfo)* controllerSwitchInfo;
    const(GameInputKeyboardInfo)* keyboardInfo;
    const(GameInputMouseInfo)* mouseInfo;
    const(GameInputTouchSensorInfo)* touchSensorInfo;
    const(GameInputMotionInfo)* motionInfo;
    const(GameInputArcadeStickInfo)* arcadeStickInfo;
    const(GameInputFlightStickInfo)* flightStickInfo;
    const(GameInputGamepadInfo)* gamepadInfo;
    const(GameInputRacingWheelInfo)* racingWheelInfo;
    const(GameInputUiNavigationInfo)* uiNavigationInfo;
    const(GameInputForceFeedbackMotorInfo)* forceFeedbackMotorInfo;
    const(GameInputHapticFeedbackMotorInfo)* hapticFeedbackMotorInfo;
    const(GameInputString)* displayName;
    const(GameInputString)* deviceStrings;
    const(void)*        deviceDescriptorData;
    GameInputSystemButtons supportedSystemButtons;
}

struct GameInputForceFeedbackEnvelope
{
    ulong attackDuration;
    ulong sustainDuration;
    ulong releaseDuration;
    float attackGain;
    float sustainGain;
    float releaseGain;
    uint  playCount;
    ulong repeatDelay;
}

struct GameInputForceFeedbackMagnitude
{
    float linearX;
    float linearY;
    float linearZ;
    float angularX;
    float angularY;
    float angularZ;
    float normal;
}

struct GameInputForceFeedbackConditionParams
{
    GameInputForceFeedbackMagnitude magnitude;
    float positiveCoefficient;
    float negativeCoefficient;
    float maxPositiveMagnitude;
    float maxNegativeMagnitude;
    float deadZone;
    float bias;
}

struct GameInputForceFeedbackConstantParams
{
    GameInputForceFeedbackEnvelope envelope;
    GameInputForceFeedbackMagnitude magnitude;
}

struct GameInputForceFeedbackPeriodicParams
{
    GameInputForceFeedbackEnvelope envelope;
    GameInputForceFeedbackMagnitude magnitude;
    float frequency;
    float phase;
    float bias;
}

struct GameInputForceFeedbackRampParams
{
    GameInputForceFeedbackEnvelope envelope;
    GameInputForceFeedbackMagnitude startMagnitude;
    GameInputForceFeedbackMagnitude endMagnitude;
}

struct GameInputForceFeedbackParams
{
    GameInputForceFeedbackEffectKind kind;
    union data
    {
        GameInputForceFeedbackConstantParams constant;
        GameInputForceFeedbackRampParams ramp;
        GameInputForceFeedbackPeriodicParams sineWave;
        GameInputForceFeedbackPeriodicParams squareWave;
        GameInputForceFeedbackPeriodicParams triangleWave;
        GameInputForceFeedbackPeriodicParams sawtoothUpWave;
        GameInputForceFeedbackPeriodicParams sawtoothDownWave;
        GameInputForceFeedbackConditionParams spring;
        GameInputForceFeedbackConditionParams friction;
        GameInputForceFeedbackConditionParams damper;
        GameInputForceFeedbackConditionParams inertia;
    }
}

struct GameInputHapticFeedbackParams
{
    uint  waveformIndex;
    ulong duration;
    float intensity;
    uint  playCount;
    ulong repeatDelay;
}

struct GameInputRumbleParams
{
    float lowFrequency;
    float highFrequency;
    float leftTrigger;
    float rightTrigger;
}

// Functions

@DllImport("GameInput.dll")
HRESULT GameInputCreate(IGameInput* gameInput);


// Interfaces

@GUID("11be2a7e-4254-445a-9c09-ffc40f006918")
interface IGameInput : IUnknown
{
    ulong   GetCurrentTimestamp();
    HRESULT GetCurrentReading(GameInputKind inputKind, IGameInputDevice device, IGameInputReading* reading);
    HRESULT GetNextReading(IGameInputReading referenceReading, GameInputKind inputKind, IGameInputDevice device, 
                           IGameInputReading* reading);
    HRESULT GetPreviousReading(IGameInputReading referenceReading, GameInputKind inputKind, 
                               IGameInputDevice device, IGameInputReading* reading);
    HRESULT GetTemporalReading(ulong timestamp, IGameInputDevice device, IGameInputReading* reading);
    HRESULT RegisterReadingCallback(IGameInputDevice device, GameInputKind inputKind, float analogThreshold, 
                                    void* context, GameInputReadingCallback callbackFunc, ulong* callbackToken);
    HRESULT RegisterDeviceCallback(IGameInputDevice device, GameInputKind inputKind, 
                                   GameInputDeviceStatus statusFilter, GameInputEnumerationKind enumerationKind, 
                                   void* context, GameInputDeviceCallback callbackFunc, ulong* callbackToken);
    HRESULT RegisterSystemButtonCallback(IGameInputDevice device, GameInputSystemButtons buttonFilter, 
                                         void* context, GameInputSystemButtonCallback callbackFunc, 
                                         ulong* callbackToken);
    HRESULT RegisterKeyboardLayoutCallback(IGameInputDevice device, void* context, 
                                           GameInputKeyboardLayoutCallback callbackFunc, ulong* callbackToken);
    void    StopCallback(ulong callbackToken);
    bool    UnregisterCallback(ulong callbackToken, ulong timeoutInMicroseconds);
    HRESULT CreateDispatcher(IGameInputDispatcher* dispatcher);
    HRESULT CreateAggregateDevice(GameInputKind inputKind, IGameInputDevice* device);
    HRESULT FindDeviceFromId(const(APP_LOCAL_DEVICE_ID)* value, IGameInputDevice* device);
    HRESULT FindDeviceFromObject(IUnknown value, IGameInputDevice* device);
    HRESULT FindDeviceFromPlatformHandle(HANDLE value, IGameInputDevice* device);
    HRESULT FindDeviceFromPlatformString(const(PWSTR) value, IGameInputDevice* device);
    HRESULT EnableOemDeviceSupport(ushort vendorId, ushort productId, ubyte interfaceNumber, 
                                   ubyte collectionNumber);
    void    SetFocusPolicy(GameInputFocusPolicy policy);
}

@GUID("2156947a-e1fa-4de0-a30b-d812931dbd8d")
interface IGameInputReading : IUnknown
{
    GameInputKind GetInputKind();
    ulong GetSequenceNumber(GameInputKind inputKind);
    ulong GetTimestamp();
    void  GetDevice(IGameInputDevice* device);
    bool  GetRawReport(IGameInputRawDeviceReport* report);
    uint  GetControllerAxisCount();
    uint  GetControllerAxisState(uint stateArrayCount, float* stateArray);
    uint  GetControllerButtonCount();
    uint  GetControllerButtonState(uint stateArrayCount, bool* stateArray);
    uint  GetControllerSwitchCount();
    uint  GetControllerSwitchState(uint stateArrayCount, GameInputSwitchPosition* stateArray);
    uint  GetKeyCount();
    uint  GetKeyState(uint stateArrayCount, GameInputKeyState* stateArray);
    bool  GetMouseState(GameInputMouseState* state);
    uint  GetTouchCount();
    uint  GetTouchState(uint stateArrayCount, GameInputTouchState* stateArray);
    bool  GetMotionState(GameInputMotionState* state);
    bool  GetArcadeStickState(GameInputArcadeStickState* state);
    bool  GetFlightStickState(GameInputFlightStickState* state);
    bool  GetGamepadState(GameInputGamepadState* state);
    bool  GetRacingWheelState(GameInputRacingWheelState* state);
    bool  GetUiNavigationState(GameInputUiNavigationState* state);
}

@GUID("31dd86fb-4c1b-408a-868f-439b3cd47125")
interface IGameInputDevice : IUnknown
{
    GameInputDeviceInfo* GetDeviceInfo();
    GameInputDeviceStatus GetDeviceStatus();
    void    GetBatteryState(GameInputBatteryState* state);
    HRESULT CreateForceFeedbackEffect(uint motorIndex, const(GameInputForceFeedbackParams)* params, 
                                      IGameInputForceFeedbackEffect* effect);
    bool    IsForceFeedbackMotorPoweredOn(uint motorIndex);
    void    SetForceFeedbackMotorGain(uint motorIndex, float masterGain);
    HRESULT SetHapticMotorState(uint motorIndex, const(GameInputHapticFeedbackParams)* params);
    void    SetRumbleState(const(GameInputRumbleParams)* params);
    void    SetInputSynchronizationState(ubyte enabled);
    void    SendInputSynchronizationHint();
    void    PowerOff();
    HRESULT CreateRawDeviceReport(uint reportId, GameInputRawDeviceReportKind reportKind, 
                                  IGameInputRawDeviceReport* report);
    HRESULT GetRawDeviceFeature(uint reportId, IGameInputRawDeviceReport* report);
    HRESULT SetRawDeviceFeature(IGameInputRawDeviceReport report);
    HRESULT SendRawDeviceOutput(IGameInputRawDeviceReport report);
    HRESULT SendRawDeviceOutputWithResponse(IGameInputRawDeviceReport requestReport, 
                                            IGameInputRawDeviceReport* responseReport);
    HRESULT ExecuteRawDeviceIoControl(uint controlCode, size_t inputBufferSize, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* inputBuffer, 
                                      size_t outputBufferSize, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* outputBuffer, 
                                      size_t* outputSize);
    bool    AcquireExclusiveRawDeviceAccess(ulong timeoutInMicroseconds);
    void    ReleaseExclusiveRawDeviceAccess();
}

@GUID("415eed2e-98cb-42c2-8f28-b94601074e31")
interface IGameInputDispatcher : IUnknown
{
    bool    Dispatch(ulong quotaInMicroseconds);
    HRESULT OpenWaitHandle(HANDLE* waitHandle);
}

@GUID("51bda05e-f742-45d9-b085-9444ae48381d")
interface IGameInputForceFeedbackEffect : IUnknown
{
    void  GetDevice(IGameInputDevice* device);
    uint  GetMotorIndex();
    float GetGain();
    void  SetGain(float gain);
    void  GetParams(GameInputForceFeedbackParams* params);
    bool  SetParams(const(GameInputForceFeedbackParams)* params);
    GameInputFeedbackEffectState GetState();
    void  SetState(GameInputFeedbackEffectState state);
}

@GUID("61f08cf1-1ffc-40ca-a2b8-e1ab8bc5b6dc")
interface IGameInputRawDeviceReport : IUnknown
{
    void   GetDevice(IGameInputDevice* device);
    GameInputRawDeviceReportInfo* GetReportInfo();
    size_t GetRawDataSize();
    size_t GetRawData(size_t bufferSize, void* buffer);
    bool   SetRawData(size_t bufferSize, const(void)* buffer);
    bool   GetItemValue(uint itemIndex, long* value);
    bool   SetItemValue(uint itemIndex, long value);
    bool   ResetItemValue(uint itemIndex);
    bool   ResetAllItems();
}


// GUIDs


const GUID IID_IGameInput                    = GUIDOF!IGameInput;
const GUID IID_IGameInputDevice              = GUIDOF!IGameInputDevice;
const GUID IID_IGameInputDispatcher          = GUIDOF!IGameInputDispatcher;
const GUID IID_IGameInputForceFeedbackEffect = GUIDOF!IGameInputForceFeedbackEffect;
const GUID IID_IGameInputRawDeviceReport     = GUIDOF!IGameInputRawDeviceReport;
const GUID IID_IGameInputReading             = GUIDOF!IGameInputReading;
