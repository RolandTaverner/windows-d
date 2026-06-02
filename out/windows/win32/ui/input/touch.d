// Written in the D programming language.

module windows.win32.ui.input.touch;

public import windows.core;
public import windows.win32.foundation : BOOL, HANDLE, HRESULT, HWND, POINTS;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums


alias GESTURECONFIG_ID = uint;
enum : uint
{
    GID_BEGIN        = 0x00000001U,
    GID_END          = 0x00000002U,
    GID_ZOOM         = 0x00000003U,
    GID_PAN          = 0x00000004U,
    GID_ROTATE       = 0x00000005U,
    GID_TWOFINGERTAP = 0x00000006U,
    GID_PRESSANDTAP  = 0x00000007U,
    GID_ROLLOVER     = 0x00000007U,
}

alias TOUCHEVENTF_FLAGS = uint;
enum : uint
{
    TOUCHEVENTF_MOVE       = 0x00000001U,
    TOUCHEVENTF_DOWN       = 0x00000002U,
    TOUCHEVENTF_UP         = 0x00000004U,
    TOUCHEVENTF_INRANGE    = 0x00000008U,
    TOUCHEVENTF_PRIMARY    = 0x00000010U,
    TOUCHEVENTF_NOCOALESCE = 0x00000020U,
    TOUCHEVENTF_PEN        = 0x00000040U,
    TOUCHEVENTF_PALM       = 0x00000080U,
}

alias TOUCHINPUTMASKF_MASK = uint;
enum : uint
{
    TOUCHINPUTMASKF_TIMEFROMSYSTEM = 0x00000001U,
    TOUCHINPUTMASKF_EXTRAINFO      = 0x00000002U,
    TOUCHINPUTMASKF_CONTACTAREA    = 0x00000004U,
}

alias REGISTER_TOUCH_WINDOW_FLAGS = uint;
enum : uint
{
    TWF_FINETOUCH = 0x00000001U,
    TWF_WANTPALM  = 0x00000002U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/ne-manipulations-manipulation_processor_manipulations
alias MANIPULATION_PROCESSOR_MANIPULATIONS = int;
enum : int
{
    MANIPULATION_NONE        = 0x00000000,
    MANIPULATION_TRANSLATE_X = 0x00000001,
    MANIPULATION_TRANSLATE_Y = 0x00000002,
    MANIPULATION_SCALE       = 0x00000004,
    MANIPULATION_ROTATE      = 0x00000008,
    MANIPULATION_ALL         = 0x0000000f,
}

// Structs


@RAIIFree!CloseGestureInfoHandle
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HGESTUREINFO
{
    void* Value;
}

@RAIIFree!CloseTouchInputHandle
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HTOUCHINPUT
{
    void* Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-touchinput
struct TOUCHINPUT
{
    int                  x;
    int                  y;
    HANDLE               hSource;
    uint                 dwID;
    TOUCHEVENTF_FLAGS    dwFlags;
    TOUCHINPUTMASKF_MASK dwMask;
    uint                 dwTime;
    size_t               dwExtraInfo;
    uint                 cxContact;
    uint                 cyContact;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-gestureinfo
struct GESTUREINFO
{
    uint   cbSize;
    uint   dwFlags;
    uint   dwID;
    HWND   hwndTarget;
    POINTS ptsLocation;
    uint   dwInstanceID;
    uint   dwSequenceID;
    ulong  ullArguments;
    uint   cbExtraArgs;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-gesturenotifystruct
struct GESTURENOTIFYSTRUCT
{
    uint   cbSize;
    uint   dwFlags;
    HWND   hwndTarget;
    POINTS ptsLocation;
    uint   dwInstanceID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-gestureconfig
struct GESTURECONFIG
{
    GESTURECONFIG_ID dwID;
    uint             dwWant;
    uint             dwBlock;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("USER32.dll")
BOOL GetTouchInputInfo(HTOUCHINPUT hTouchInput, uint cInputs, TOUCHINPUT* pInputs, int cbSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("USER32.dll")
BOOL CloseTouchInputHandle(HTOUCHINPUT hTouchInput);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("USER32.dll")
BOOL RegisterTouchWindow(HWND hwnd, REGISTER_TOUCH_WINDOW_FLAGS ulFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("USER32.dll")
BOOL UnregisterTouchWindow(HWND hwnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("USER32.dll")
BOOL IsTouchWindow(HWND hwnd, uint* pulFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("USER32.dll")
BOOL GetGestureInfo(HGESTUREINFO hGestureInfo, GESTUREINFO* pGestureInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("USER32.dll")
BOOL GetGestureExtraArgs(HGESTUREINFO hGestureInfo, uint cbExtraArgs, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* pExtraArgs);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("USER32.dll")
BOOL CloseGestureInfoHandle(HGESTUREINFO hGestureInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("USER32.dll")
BOOL SetGestureConfig(HWND hwnd, uint dwReserved, uint cIDs, GESTURECONFIG* pGestureConfig, uint cbSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("USER32.dll")
BOOL GetGestureConfig(HWND hwnd, uint dwReserved, uint dwFlags, uint* pcIDs, GESTURECONFIG* pGestureConfig, 
                      uint cbSize);


// Interfaces

@GUID("abb27087-4ce0-4e58-a0cb-e24df96814be")
struct InertiaProcessor;

@GUID("597d4fb0-47fd-4aff-89b9-c6cfae8cf08e")
struct ManipulationProcessor;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nn-manipulations-_imanipulationevents
@GUID("4f62c8da-9c53-4b22-93df-927a862bbb03")
interface _IManipulationEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-_imanipulationevents-manipulationstarted
    HRESULT ManipulationStarted(float x, float y);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-_imanipulationevents-manipulationdelta
    HRESULT ManipulationDelta(float x, float y, float translationDeltaX, float translationDeltaY, float scaleDelta, 
                              float expansionDelta, float rotationDelta, float cumulativeTranslationX, 
                              float cumulativeTranslationY, float cumulativeScale, float cumulativeExpansion, 
                              float cumulativeRotation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-_imanipulationevents-manipulationcompleted
    HRESULT ManipulationCompleted(float x, float y, float cumulativeTranslationX, float cumulativeTranslationY, 
                                  float cumulativeScale, float cumulativeExpansion, float cumulativeRotation);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nn-manipulations-iinertiaprocessor
@GUID("18b00c6d-c5ee-41b1-90a9-9d4a929095ad")
interface IInertiaProcessor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-get_initialoriginx
    HRESULT get_InitialOriginX(float* x);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-put_initialoriginx
    HRESULT put_InitialOriginX(float x);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-get_initialoriginy
    HRESULT get_InitialOriginY(float* y);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-put_initialoriginy
    HRESULT put_InitialOriginY(float y);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-get_initialvelocityx
    HRESULT get_InitialVelocityX(float* x);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-put_initialvelocityx
    HRESULT put_InitialVelocityX(float x);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-get_initialvelocityy
    HRESULT get_InitialVelocityY(float* y);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-put_initialvelocityy
    HRESULT put_InitialVelocityY(float y);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-get_initialangularvelocity
    HRESULT get_InitialAngularVelocity(float* velocity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-put_initialangularvelocity
    HRESULT put_InitialAngularVelocity(float velocity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-get_initialexpansionvelocity
    HRESULT get_InitialExpansionVelocity(float* velocity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-put_initialexpansionvelocity
    HRESULT put_InitialExpansionVelocity(float velocity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-get_initialradius
    HRESULT get_InitialRadius(float* radius);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-put_initialradius
    HRESULT put_InitialRadius(float radius);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-get_boundaryleft
    HRESULT get_BoundaryLeft(float* left);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-put_boundaryleft
    HRESULT put_BoundaryLeft(float left);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-get_boundarytop
    HRESULT get_BoundaryTop(float* top);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-put_boundarytop
    HRESULT put_BoundaryTop(float top);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-get_boundaryright
    HRESULT get_BoundaryRight(float* right);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-put_boundaryright
    HRESULT put_BoundaryRight(float right);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-get_boundarybottom
    HRESULT get_BoundaryBottom(float* bottom);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-put_boundarybottom
    HRESULT put_BoundaryBottom(float bottom);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-get_elasticmarginleft
    HRESULT get_ElasticMarginLeft(float* left);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-put_elasticmarginleft
    HRESULT put_ElasticMarginLeft(float left);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-get_elasticmargintop
    HRESULT get_ElasticMarginTop(float* top);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-put_elasticmargintop
    HRESULT put_ElasticMarginTop(float top);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-get_elasticmarginright
    HRESULT get_ElasticMarginRight(float* right);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-put_elasticmarginright
    HRESULT put_ElasticMarginRight(float right);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-get_elasticmarginbottom
    HRESULT get_ElasticMarginBottom(float* bottom);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-put_elasticmarginbottom
    HRESULT put_ElasticMarginBottom(float bottom);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-get_desireddisplacement
    HRESULT get_DesiredDisplacement(float* displacement);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-put_desireddisplacement
    HRESULT put_DesiredDisplacement(float displacement);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-get_desiredrotation
    HRESULT get_DesiredRotation(float* rotation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-put_desiredrotation
    HRESULT put_DesiredRotation(float rotation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-get_desiredexpansion
    HRESULT get_DesiredExpansion(float* expansion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-put_desiredexpansion
    HRESULT put_DesiredExpansion(float expansion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-get_desireddeceleration
    HRESULT get_DesiredDeceleration(float* deceleration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-put_desireddeceleration
    HRESULT put_DesiredDeceleration(float deceleration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-get_desiredangulardeceleration
    HRESULT get_DesiredAngularDeceleration(float* deceleration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-put_desiredangulardeceleration
    HRESULT put_DesiredAngularDeceleration(float deceleration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-get_desiredexpansiondeceleration
    HRESULT get_DesiredExpansionDeceleration(float* deceleration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-put_desiredexpansiondeceleration
    HRESULT put_DesiredExpansionDeceleration(float deceleration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-get_initialtimestamp
    HRESULT get_InitialTimestamp(uint* timestamp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-put_initialtimestamp
    HRESULT put_InitialTimestamp(uint timestamp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-process
    HRESULT Process(BOOL* completed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-processtime
    HRESULT ProcessTime(uint timestamp, BOOL* completed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-complete
    HRESULT Complete();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-iinertiaprocessor-completetime
    HRESULT CompleteTime(uint timestamp);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nn-manipulations-imanipulationprocessor
@GUID("a22ac519-8300-48a0-bef4-f1be8737dba4")
interface IManipulationProcessor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-imanipulationprocessor-get_supportedmanipulations
    HRESULT get_SupportedManipulations(MANIPULATION_PROCESSOR_MANIPULATIONS* manipulations);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-imanipulationprocessor-put_supportedmanipulations
    HRESULT put_SupportedManipulations(MANIPULATION_PROCESSOR_MANIPULATIONS manipulations);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-imanipulationprocessor-get_pivotpointx
    HRESULT get_PivotPointX(float* pivotPointX);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-imanipulationprocessor-put_pivotpointx
    HRESULT put_PivotPointX(float pivotPointX);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-imanipulationprocessor-get_pivotpointy
    HRESULT get_PivotPointY(float* pivotPointY);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-imanipulationprocessor-put_pivotpointy
    HRESULT put_PivotPointY(float pivotPointY);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-imanipulationprocessor-get_pivotradius
    HRESULT get_PivotRadius(float* pivotRadius);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-imanipulationprocessor-put_pivotradius
    HRESULT put_PivotRadius(float pivotRadius);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-imanipulationprocessor-completemanipulation
    HRESULT CompleteManipulation();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-imanipulationprocessor-processdown
    HRESULT ProcessDown(uint manipulatorId, float x, float y);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-imanipulationprocessor-processmove
    HRESULT ProcessMove(uint manipulatorId, float x, float y);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-imanipulationprocessor-processup
    HRESULT ProcessUp(uint manipulatorId, float x, float y);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-imanipulationprocessor-processdownwithtime
    HRESULT ProcessDownWithTime(uint manipulatorId, float x, float y, uint timestamp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-imanipulationprocessor-processmovewithtime
    HRESULT ProcessMoveWithTime(uint manipulatorId, float x, float y, uint timestamp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-imanipulationprocessor-processupwithtime
    HRESULT ProcessUpWithTime(uint manipulatorId, float x, float y, uint timestamp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-imanipulationprocessor-getvelocityx
    HRESULT GetVelocityX(float* velocityX);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-imanipulationprocessor-getvelocityy
    HRESULT GetVelocityY(float* velocityY);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-imanipulationprocessor-getexpansionvelocity
    HRESULT GetExpansionVelocity(float* expansionVelocity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-imanipulationprocessor-getangularvelocity
    HRESULT GetAngularVelocity(float* angularVelocity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-imanipulationprocessor-get_minimumscalerotateradius
    HRESULT get_MinimumScaleRotateRadius(float* minRadius);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/manipulations/nf-manipulations-imanipulationprocessor-put_minimumscalerotateradius
    HRESULT put_MinimumScaleRotateRadius(float minRadius);
}


// GUIDs

const GUID CLSID_InertiaProcessor      = GUIDOF!InertiaProcessor;
const GUID CLSID_ManipulationProcessor = GUIDOF!ManipulationProcessor;

const GUID IID_IInertiaProcessor      = GUIDOF!IInertiaProcessor;
const GUID IID_IManipulationProcessor = GUIDOF!IManipulationProcessor;
const GUID IID__IManipulationEvents   = GUIDOF!_IManipulationEvents;
