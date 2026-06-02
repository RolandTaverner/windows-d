// Written in the D programming language.

module windows.win32.graphics.dwm;

public import windows.core;
public import windows.win32.foundation : BOOL, HRESULT, HWND, LPARAM, LRESULT, POINT,
                                         RECT, SIZE, WPARAM;
public import windows.win32.graphics.gdi : HBITMAP, HRGN;
public import windows.win32.ui.controls : MARGINS;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dwmapi/ne-dwmapi-dwmwindowattribute
alias DWMWINDOWATTRIBUTE = int;
enum : int
{
    DWMWA_NCRENDERING_ENABLED            = 0x00000001,
    DWMWA_NCRENDERING_POLICY             = 0x00000002,
    DWMWA_TRANSITIONS_FORCEDISABLED      = 0x00000003,
    DWMWA_ALLOW_NCPAINT                  = 0x00000004,
    DWMWA_CAPTION_BUTTON_BOUNDS          = 0x00000005,
    DWMWA_NONCLIENT_RTL_LAYOUT           = 0x00000006,
    DWMWA_FORCE_ICONIC_REPRESENTATION    = 0x00000007,
    DWMWA_FLIP3D_POLICY                  = 0x00000008,
    DWMWA_EXTENDED_FRAME_BOUNDS          = 0x00000009,
    DWMWA_HAS_ICONIC_BITMAP              = 0x0000000a,
    DWMWA_DISALLOW_PEEK                  = 0x0000000b,
    DWMWA_EXCLUDED_FROM_PEEK             = 0x0000000c,
    DWMWA_CLOAK                          = 0x0000000d,
    DWMWA_CLOAKED                        = 0x0000000e,
    DWMWA_FREEZE_REPRESENTATION          = 0x0000000f,
    DWMWA_PASSIVE_UPDATE_MODE            = 0x00000010,
    DWMWA_USE_HOSTBACKDROPBRUSH          = 0x00000011,
    DWMWA_USE_IMMERSIVE_DARK_MODE        = 0x00000014,
    DWMWA_WINDOW_CORNER_PREFERENCE       = 0x00000021,
    DWMWA_BORDER_COLOR                   = 0x00000022,
    DWMWA_CAPTION_COLOR                  = 0x00000023,
    DWMWA_TEXT_COLOR                     = 0x00000024,
    DWMWA_VISIBLE_FRAME_BORDER_THICKNESS = 0x00000025,
    DWMWA_SYSTEMBACKDROP_TYPE            = 0x00000026,
    DWMWA_REDIRECTIONBITMAP_ALPHA        = 0x00000027,
    DWMWA_BORDER_MARGINS                 = 0x00000028,
    DWMWA_LAST                           = 0x00000029,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dwmapi/ne-dwmapi-dwm_window_corner_preference
alias DWM_WINDOW_CORNER_PREFERENCE = int;
enum : int
{
    DWMWCP_DEFAULT    = 0x00000000,
    DWMWCP_DONOTROUND = 0x00000001,
    DWMWCP_ROUND      = 0x00000002,
    DWMWCP_ROUNDSMALL = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dwmapi/ne-dwmapi-dwm_systembackdrop_type
alias DWM_SYSTEMBACKDROP_TYPE = int;
enum : int
{
    DWMSBT_AUTO            = 0x00000000,
    DWMSBT_NONE            = 0x00000001,
    DWMSBT_MAINWINDOW      = 0x00000002,
    DWMSBT_TRANSIENTWINDOW = 0x00000003,
    DWMSBT_TABBEDWINDOW    = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dwmapi/ne-dwmapi-dwmncrenderingpolicy
alias DWMNCRENDERINGPOLICY = int;
enum : int
{
    DWMNCRP_USEWINDOWSTYLE = 0x00000000,
    DWMNCRP_DISABLED       = 0x00000001,
    DWMNCRP_ENABLED        = 0x00000002,
    DWMNCRP_LAST           = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dwmapi/ne-dwmapi-dwmflip3dwindowpolicy
alias DWMFLIP3DWINDOWPOLICY = int;
enum : int
{
    DWMFLIP3D_DEFAULT      = 0x00000000,
    DWMFLIP3D_EXCLUDEBELOW = 0x00000001,
    DWMFLIP3D_EXCLUDEABOVE = 0x00000002,
    DWMFLIP3D_LAST         = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dwmapi/ne-dwmapi-dwm_source_frame_sampling
alias DWM_SOURCE_FRAME_SAMPLING = int;
enum : int
{
    DWM_SOURCE_FRAME_SAMPLING_POINT    = 0x00000000,
    DWM_SOURCE_FRAME_SAMPLING_COVERAGE = 0x00000001,
    DWM_SOURCE_FRAME_SAMPLING_LAST     = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dwmapi/ne-dwmapi-dwmtransition_ownedwindow_target
alias DWMTRANSITION_OWNEDWINDOW_TARGET = int;
enum : int
{
    DWMTRANSITION_OWNEDWINDOW_NULL       = 0xffffffff,
    DWMTRANSITION_OWNEDWINDOW_REPOSITION = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dwmapi/ne-dwmapi-gesture_type
alias GESTURE_TYPE = int;
enum : int
{
    GT_PEN_TAP                 = 0x00000000,
    GT_PEN_DOUBLETAP           = 0x00000001,
    GT_PEN_RIGHTTAP            = 0x00000002,
    GT_PEN_PRESSANDHOLD        = 0x00000003,
    GT_PEN_PRESSANDHOLDABORT   = 0x00000004,
    GT_TOUCH_TAP               = 0x00000005,
    GT_TOUCH_DOUBLETAP         = 0x00000006,
    GT_TOUCH_RIGHTTAP          = 0x00000007,
    GT_TOUCH_PRESSANDHOLD      = 0x00000008,
    GT_TOUCH_PRESSANDHOLDABORT = 0x00000009,
    GT_TOUCH_PRESSANDTAP       = 0x0000000a,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dwmapi/ne-dwmapi-dwm_showcontact
alias DWM_SHOWCONTACT = uint;
enum : uint
{
    DWMSC_DOWN      = 0x00000001U,
    DWMSC_UP        = 0x00000002U,
    DWMSC_DRAG      = 0x00000004U,
    DWMSC_HOLD      = 0x00000008U,
    DWMSC_PENBARREL = 0x00000010U,
    DWMSC_NONE      = 0x00000000U,
    DWMSC_ALL       = 0xffffffffU,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dwmapi/ne-dwmapi-dwm_tab_window_requirements
alias DWM_TAB_WINDOW_REQUIREMENTS = int;
enum : int
{
    DWMTWR_NONE                  = 0x00000000,
    DWMTWR_IMPLEMENTED_BY_SYSTEM = 0x00000001,
    DWMTWR_WINDOW_RELATIONSHIP   = 0x00000002,
    DWMTWR_WINDOW_STYLES         = 0x00000004,
    DWMTWR_WINDOW_REGION         = 0x00000008,
    DWMTWR_WINDOW_DWM_ATTRIBUTES = 0x00000010,
    DWMTWR_WINDOW_MARGINS        = 0x00000020,
    DWMTWR_TABBING_ENABLED       = 0x00000040,
    DWMTWR_USER_POLICY           = 0x00000080,
    DWMTWR_GROUP_POLICY          = 0x00000100,
    DWMTWR_APP_COMPAT            = 0x00000200,
}

// Constants


enum : uint
{
    DWM_BB_ENABLE                = 0x00000001U,
    DWM_BB_BLURREGION            = 0x00000002U,
    DWM_BB_TRANSITIONONMAXIMIZED = 0x00000004U,
}

enum : uint
{
    DWMWA_COLOR_DEFAULT = 0xffffffffU,
    DWMWA_COLOR_NONE    = 0xfffffffeU,
}

enum : uint
{
    DWM_CLOAKED_APP       = 0x00000001U,
    DWM_CLOAKED_SHELL     = 0x00000002U,
    DWM_CLOAKED_INHERITED = 0x00000004U,
}

enum : uint
{
    DWM_TNP_RECTDESTINATION      = 0x00000001U,
    DWM_TNP_RECTSOURCE           = 0x00000002U,
    DWM_TNP_OPACITY              = 0x00000004U,
    DWM_TNP_VISIBLE              = 0x00000008U,
    DWM_TNP_SOURCECLIENTAREAONLY = 0x00000010U,
}

enum int DWM_FRAME_DURATION_DEFAULT = 0xffffffff;
enum uint DWM_EC_DISABLECOMPOSITION = 0x00000000U;
enum uint DWM_EC_ENABLECOMPOSITION = 0x00000001U;
enum uint DWM_SIT_DISPLAYFRAME = 0x00000001U;
enum uint c_DwmMaxQueuedBuffers = 0x00000008U;

enum : uint
{
    c_DwmMaxMonitors = 0x00000010U,
    c_DwmMaxAdapters = 0x00000010U,
}

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dwmapi/ns-dwmapi-dwm_blurbehind
struct DWM_BLURBEHIND
{
align (1):
    uint dwFlags;
    BOOL fEnable;
    HRGN hRgnBlur;
    BOOL fTransitionOnMaximized;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dwmapi/ns-dwmapi-dwm_thumbnail_properties
struct DWM_THUMBNAIL_PROPERTIES
{
align (1):
    uint  dwFlags;
    RECT  rcDestination;
    RECT  rcSource;
    ubyte opacity;
    BOOL  fVisible;
    BOOL  fSourceClientAreaOnly;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dwmapi/ns-dwmapi-unsigned_ratio
struct UNSIGNED_RATIO
{
align (1):
    uint uiNumerator;
    uint uiDenominator;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dwmapi/ns-dwmapi-dwm_timing_info
struct DWM_TIMING_INFO
{
align (1):
    uint           cbSize;
    UNSIGNED_RATIO rateRefresh;
    ulong          qpcRefreshPeriod;
    UNSIGNED_RATIO rateCompose;
    ulong          qpcVBlank;
    ulong          cRefresh;
    uint           cDXRefresh;
    ulong          qpcCompose;
    ulong          cFrame;
    uint           cDXPresent;
    ulong          cRefreshFrame;
    ulong          cFrameSubmitted;
    uint           cDXPresentSubmitted;
    ulong          cFrameConfirmed;
    uint           cDXPresentConfirmed;
    ulong          cRefreshConfirmed;
    uint           cDXRefreshConfirmed;
    ulong          cFramesLate;
    uint           cFramesOutstanding;
    ulong          cFrameDisplayed;
    ulong          qpcFrameDisplayed;
    ulong          cRefreshFrameDisplayed;
    ulong          cFrameComplete;
    ulong          qpcFrameComplete;
    ulong          cFramePending;
    ulong          qpcFramePending;
    ulong          cFramesDisplayed;
    ulong          cFramesComplete;
    ulong          cFramesPending;
    ulong          cFramesAvailable;
    ulong          cFramesDropped;
    ulong          cFramesMissed;
    ulong          cRefreshNextDisplayed;
    ulong          cRefreshNextPresented;
    ulong          cRefreshesDisplayed;
    ulong          cRefreshesPresented;
    ulong          cRefreshStarted;
    ulong          cPixelsReceived;
    ulong          cPixelsDrawn;
    ulong          cBuffersEmpty;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dwmapi/ns-dwmapi-dwm_present_parameters
struct DWM_PRESENT_PARAMETERS
{
align (1):
    uint           cbSize;
    BOOL           fQueue;
    ulong          cRefreshStart;
    uint           cBuffer;
    BOOL           fUseSourceRate;
    UNSIGNED_RATIO rateSource;
    uint           cRefreshesPerFrame;
    DWM_SOURCE_FRAME_SAMPLING eSampling;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mileffects/ns-mileffects-milmatrix3x2d
struct MilMatrix3x2D
{
align (1):
    double S_11;
    double S_12;
    double S_21;
    double S_22;
    double DX;
    double DY;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dwmapi.dll")
BOOL DwmDefWindowProc(HWND hWnd, uint msg, WPARAM wParam, LPARAM lParam, LRESULT* plResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dwmapi.dll")
HRESULT DwmEnableBlurBehindWindow(HWND hWnd, const(DWM_BLURBEHIND)* pBlurBehind);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dwmapi.dll")
HRESULT DwmEnableComposition(uint uCompositionAction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dwmapi.dll")
HRESULT DwmEnableMMCSS(BOOL fEnableMMCSS);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dwmapi.dll")
HRESULT DwmExtendFrameIntoClientArea(HWND hWnd, const(MARGINS)* pMarInset);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dwmapi.dll")
HRESULT DwmGetColorizationColor(uint* pcrColorization, BOOL* pfOpaqueBlend);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dwmapi.dll")
HRESULT DwmGetCompositionTimingInfo(HWND hwnd, DWM_TIMING_INFO* pTimingInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dwmapi.dll")
HRESULT DwmGetWindowAttribute(HWND hwnd, 
                              /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(DWMWINDOWATTRIBUTE))], [])*/uint dwAttribute, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvAttribute, 
                              uint cbAttribute);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dwmapi.dll")
HRESULT DwmIsCompositionEnabled(BOOL* pfEnabled);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dwmapi.dll")
HRESULT DwmModifyPreviousDxFrameDuration(HWND hwnd, int cRefreshes, BOOL fRelative);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dwmapi.dll")
HRESULT DwmQueryThumbnailSourceSize(ptrdiff_t hThumbnail, SIZE* pSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dwmapi.dll")
HRESULT DwmRegisterThumbnail(HWND hwndDestination, HWND hwndSource, ptrdiff_t* phThumbnailId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dwmapi.dll")
HRESULT DwmSetDxFrameDuration(HWND hwnd, int cRefreshes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dwmapi.dll")
HRESULT DwmSetPresentParameters(HWND hwnd, DWM_PRESENT_PARAMETERS* pPresentParams);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dwmapi.dll")
HRESULT DwmSetWindowAttribute(HWND hwnd, 
                              /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(DWMWINDOWATTRIBUTE))], [])*/uint dwAttribute, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(void)* pvAttribute, 
                              uint cbAttribute);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dwmapi.dll")
HRESULT DwmUnregisterThumbnail(ptrdiff_t hThumbnailId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dwmapi.dll")
HRESULT DwmUpdateThumbnailProperties(ptrdiff_t hThumbnailId, const(DWM_THUMBNAIL_PROPERTIES)* ptnProperties);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("dwmapi.dll")
HRESULT DwmSetIconicThumbnail(HWND hwnd, HBITMAP hbmp, uint dwSITFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("dwmapi.dll")
HRESULT DwmSetIconicLivePreviewBitmap(HWND hwnd, HBITMAP hbmp, POINT* pptClient, uint dwSITFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("dwmapi.dll")
HRESULT DwmInvalidateIconicBitmaps(HWND hwnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dwmapi.dll")
HRESULT DwmAttachMilContent(HWND hwnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dwmapi.dll")
HRESULT DwmDetachMilContent(HWND hwnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dwmapi.dll")
HRESULT DwmFlush();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dwmapi.dll")
HRESULT DwmGetGraphicsStreamTransformHint(uint uIndex, MilMatrix3x2D* pTransform);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dwmapi.dll")
HRESULT DwmGetGraphicsStreamClient(uint uIndex, GUID* pClientUuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dwmapi.dll")
HRESULT DwmGetTransportAttributes(BOOL* pfIsRemoting, BOOL* pfIsConnected, uint* pDwGeneration);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("dwmapi.dll")
HRESULT DwmTransitionOwnedWindow(HWND hwnd, DWMTRANSITION_OWNEDWINDOW_TARGET target);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("dwmapi.dll")
HRESULT DwmRenderGesture(GESTURE_TYPE gt, uint cContacts, const(uint)* pdwPointerID, const(POINT)* pPoints);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("dwmapi.dll")
HRESULT DwmTetherContact(uint dwPointerID, BOOL fEnable, POINT ptTether);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("dwmapi.dll")
HRESULT DwmShowContact(uint dwPointerID, DWM_SHOWCONTACT eShowContact);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
@DllImport("dwmapi.dll")
HRESULT DwmGetUnmetTabRequirements(HWND appWindow, DWM_TAB_WINDOW_REQUIREMENTS* value);


