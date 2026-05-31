// Written in the D programming language.

module windows.win32.ui.tabletpc;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : BOOL, BSTR, COLORREF, HANDLE_PTR, HRESULT,
                                         HWND, POINT, PWSTR, RECT, VARIANT_BOOL;
public import windows.win32.graphics.gdi : XFORM;
public import windows.win32.system.com : IDataObject, IDispatch, IUnknown, SAFEARRAY;
public import windows.win32.system.ole : IFontDisp, IPictureDisp, OLE_HANDLE;
public import windows.win32.system.variant : VARIANT;
public import windows.win32.ui.controls : NMHDR;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tpcshrd/ne-tpcshrd-property_units))], [])
alias PROPERTY_UNITS = int;
enum : int
{
    PROPERTY_UNITS_DEFAULT     = 0x00000000,
    PROPERTY_UNITS_INCHES      = 0x00000001,
    PROPERTY_UNITS_CENTIMETERS = 0x00000002,
    PROPERTY_UNITS_DEGREES     = 0x00000003,
    PROPERTY_UNITS_RADIANS     = 0x00000004,
    PROPERTY_UNITS_SECONDS     = 0x00000005,
    PROPERTY_UNITS_POUNDS      = 0x00000006,
    PROPERTY_UNITS_GRAMS       = 0x00000007,
    PROPERTY_UNITS_SILINEAR    = 0x00000008,
    PROPERTY_UNITS_SIROTATION  = 0x00000009,
    PROPERTY_UNITS_ENGLINEAR   = 0x0000000a,
    PROPERTY_UNITS_ENGROTATION = 0x0000000b,
    PROPERTY_UNITS_SLUGS       = 0x0000000c,
    PROPERTY_UNITS_KELVIN      = 0x0000000d,
    PROPERTY_UNITS_FAHRENHEIT  = 0x0000000e,
    PROPERTY_UNITS_AMPERE      = 0x0000000f,
    PROPERTY_UNITS_CANDELA     = 0x00000010,
}
alias INK_METRIC_FLAGS = int;
enum : int
{
    IMF_FONT_SELECTED_IN_HDC = 0x00000001,
    IMF_ITALIC               = 0x00000002,
    IMF_BOLD                 = 0x00000004,
}
alias GET_DANDIDATE_FLAGS = int;
enum : int
{
    TCF_ALLOW_RECOGNITION = 0x00000001,
    TCF_FORCE_RECOGNITION = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-inkselectionconstants))], [])
enum InkSelectionConstants : int
{
    ISC_FirstElement = 0x00000000,
    ISC_AllElements  = 0xffffffff,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-inkboundingboxmode))], [])
enum InkBoundingBoxMode : int
{
    IBBM_Default    = 0x00000000,
    IBBM_NoCurveFit = 0x00000001,
    IBBM_CurveFit   = 0x00000002,
    IBBM_PointsOnly = 0x00000003,
    IBBM_Union      = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-inkextractflags))], [])
enum InkExtractFlags : int
{
    IEF_CopyFromOriginal   = 0x00000000,
    IEF_RemoveFromOriginal = 0x00000001,
    IEF_Default            = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-inkpersistenceformat))], [])
enum InkPersistenceFormat : int
{
    IPF_InkSerializedFormat       = 0x00000000,
    IPF_Base64InkSerializedFormat = 0x00000001,
    IPF_GIF                       = 0x00000002,
    IPF_Base64GIF                 = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-inkpersistencecompressionmode))], [])
enum InkPersistenceCompressionMode : int
{
    IPCM_Default            = 0x00000000,
    IPCM_MaximumCompression = 0x00000001,
    IPCM_NoCompression      = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-inkpentip))], [])
enum InkPenTip : int
{
    IPT_Ball      = 0x00000000,
    IPT_Rectangle = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-inkrasteroperation))], [])
enum InkRasterOperation : int
{
    IRO_Black       = 0x00000001,
    IRO_NotMergePen = 0x00000002,
    IRO_MaskNotPen  = 0x00000003,
    IRO_NotCopyPen  = 0x00000004,
    IRO_MaskPenNot  = 0x00000005,
    IRO_Not         = 0x00000006,
    IRO_XOrPen      = 0x00000007,
    IRO_NotMaskPen  = 0x00000008,
    IRO_MaskPen     = 0x00000009,
    IRO_NotXOrPen   = 0x0000000a,
    IRO_NoOperation = 0x0000000b,
    IRO_MergeNotPen = 0x0000000c,
    IRO_CopyPen     = 0x0000000d,
    IRO_MergePenNot = 0x0000000e,
    IRO_MergePen    = 0x0000000f,
    IRO_White       = 0x00000010,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-inkmousepointer))], [])
enum InkMousePointer : int
{
    IMP_Default        = 0x00000000,
    IMP_Arrow          = 0x00000001,
    IMP_Crosshair      = 0x00000002,
    IMP_Ibeam          = 0x00000003,
    IMP_SizeNESW       = 0x00000004,
    IMP_SizeNS         = 0x00000005,
    IMP_SizeNWSE       = 0x00000006,
    IMP_SizeWE         = 0x00000007,
    IMP_UpArrow        = 0x00000008,
    IMP_Hourglass      = 0x00000009,
    IMP_NoDrop         = 0x0000000a,
    IMP_ArrowHourglass = 0x0000000b,
    IMP_ArrowQuestion  = 0x0000000c,
    IMP_SizeAll        = 0x0000000d,
    IMP_Hand           = 0x0000000e,
    IMP_Custom         = 0x00000063,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-inkclipboardmodes))], [])
enum InkClipboardModes : int
{
    ICB_Copy        = 0x00000000,
    ICB_Cut         = 0x00000001,
    ICB_ExtractOnly = 0x00000030,
    ICB_DelayedCopy = 0x00000020,
    ICB_Default     = 0x00000000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-inkclipboardformats))], [])
enum InkClipboardFormats : int
{
    ICF_None                = 0x00000000,
    ICF_InkSerializedFormat = 0x00000001,
    ICF_SketchInk           = 0x00000002,
    ICF_TextInk             = 0x00000006,
    ICF_EnhancedMetafile    = 0x00000008,
    ICF_Metafile            = 0x00000020,
    ICF_Bitmap              = 0x00000040,
    ICF_PasteMask           = 0x00000007,
    ICF_CopyMask            = 0x0000007f,
    ICF_Default             = 0x0000007f,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-selectionhitresult))], [])
enum SelectionHitResult : int
{
    SHR_None      = 0x00000000,
    SHR_NW        = 0x00000001,
    SHR_SE        = 0x00000002,
    SHR_NE        = 0x00000003,
    SHR_SW        = 0x00000004,
    SHR_E         = 0x00000005,
    SHR_W         = 0x00000006,
    SHR_N         = 0x00000007,
    SHR_S         = 0x00000008,
    SHR_Selection = 0x00000009,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-inkrecognitionstatus))], [])
enum InkRecognitionStatus : int
{
    IRS_NoError                     = 0x00000000,
    IRS_Interrupted                 = 0x00000001,
    IRS_ProcessFailed               = 0x00000002,
    IRS_InkAddedFailed              = 0x00000004,
    IRS_SetAutoCompletionModeFailed = 0x00000008,
    IRS_SetStrokesFailed            = 0x00000010,
    IRS_SetGuideFailed              = 0x00000020,
    IRS_SetFlagsFailed              = 0x00000040,
    IRS_SetFactoidFailed            = 0x00000080,
    IRS_SetPrefixSuffixFailed       = 0x00000100,
    IRS_SetWordListFailed           = 0x00000200,
}
alias DISPID_InkRectangle = int;
enum : int
{
    DISPID_IRTop          = 0x00000001,
    DISPID_IRLeft         = 0x00000002,
    DISPID_IRBottom       = 0x00000003,
    DISPID_IRRight        = 0x00000004,
    DISPID_IRGetRectangle = 0x00000005,
    DISPID_IRSetRectangle = 0x00000006,
    DISPID_IRData         = 0x00000007,
}
alias DISPID_InkExtendedProperty = int;
enum : int
{
    DISPID_IEPGuid = 0x00000001,
    DISPID_IEPData = 0x00000002,
}
alias DISPID_InkExtendedProperties = int;
enum : int
{
    DISPID_IEPs_NewEnum          = 0xfffffffc,
    DISPID_IEPsItem              = 0x00000000,
    DISPID_IEPsCount             = 0x00000001,
    DISPID_IEPsAdd               = 0x00000002,
    DISPID_IEPsRemove            = 0x00000003,
    DISPID_IEPsClear             = 0x00000004,
    DISPID_IEPsDoesPropertyExist = 0x00000005,
}
alias DISPID_InkDrawingAttributes = int;
enum : int
{
    DISPID_DAHeight             = 0x00000001,
    DISPID_DAColor              = 0x00000002,
    DISPID_DAWidth              = 0x00000003,
    DISPID_DAFitToCurve         = 0x00000004,
    DISPID_DAIgnorePressure     = 0x00000005,
    DISPID_DAAntiAliased        = 0x00000006,
    DISPID_DATransparency       = 0x00000007,
    DISPID_DARasterOperation    = 0x00000008,
    DISPID_DAPenTip             = 0x00000009,
    DISPID_DAClone              = 0x0000000a,
    DISPID_DAExtendedProperties = 0x0000000b,
}
alias DISPID_InkTransform = int;
enum : int
{
    DISPID_ITReset        = 0x00000001,
    DISPID_ITTranslate    = 0x00000002,
    DISPID_ITRotate       = 0x00000003,
    DISPID_ITReflect      = 0x00000004,
    DISPID_ITShear        = 0x00000005,
    DISPID_ITScale        = 0x00000006,
    DISPID_ITeM11         = 0x00000007,
    DISPID_ITeM12         = 0x00000008,
    DISPID_ITeM21         = 0x00000009,
    DISPID_ITeM22         = 0x0000000a,
    DISPID_ITeDx          = 0x0000000b,
    DISPID_ITeDy          = 0x0000000c,
    DISPID_ITGetTransform = 0x0000000d,
    DISPID_ITSetTransform = 0x0000000e,
    DISPID_ITData         = 0x0000000f,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-inkapplicationgesture))], [])
enum InkApplicationGesture : int
{
    IAG_AllGestures     = 0x00000000,
    IAG_NoGesture       = 0x0000f000,
    IAG_Scratchout      = 0x0000f001,
    IAG_Triangle        = 0x0000f002,
    IAG_Square          = 0x0000f003,
    IAG_Star            = 0x0000f004,
    IAG_Check           = 0x0000f005,
    IAG_Curlicue        = 0x0000f010,
    IAG_DoubleCurlicue  = 0x0000f011,
    IAG_Circle          = 0x0000f020,
    IAG_DoubleCircle    = 0x0000f021,
    IAG_SemiCircleLeft  = 0x0000f028,
    IAG_SemiCircleRight = 0x0000f029,
    IAG_ChevronUp       = 0x0000f030,
    IAG_ChevronDown     = 0x0000f031,
    IAG_ChevronLeft     = 0x0000f032,
    IAG_ChevronRight    = 0x0000f033,
    IAG_ArrowUp         = 0x0000f038,
    IAG_ArrowDown       = 0x0000f039,
    IAG_ArrowLeft       = 0x0000f03a,
    IAG_ArrowRight      = 0x0000f03b,
    IAG_Up              = 0x0000f058,
    IAG_Down            = 0x0000f059,
    IAG_Left            = 0x0000f05a,
    IAG_Right           = 0x0000f05b,
    IAG_UpDown          = 0x0000f060,
    IAG_DownUp          = 0x0000f061,
    IAG_LeftRight       = 0x0000f062,
    IAG_RightLeft       = 0x0000f063,
    IAG_UpLeftLong      = 0x0000f064,
    IAG_UpRightLong     = 0x0000f065,
    IAG_DownLeftLong    = 0x0000f066,
    IAG_DownRightLong   = 0x0000f067,
    IAG_UpLeft          = 0x0000f068,
    IAG_UpRight         = 0x0000f069,
    IAG_DownLeft        = 0x0000f06a,
    IAG_DownRight       = 0x0000f06b,
    IAG_LeftUp          = 0x0000f06c,
    IAG_LeftDown        = 0x0000f06d,
    IAG_RightUp         = 0x0000f06e,
    IAG_RightDown       = 0x0000f06f,
    IAG_Exclamation     = 0x0000f0a4,
    IAG_Tap             = 0x0000f0f0,
    IAG_DoubleTap       = 0x0000f0f1,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-inksystemgesture))], [])
enum InkSystemGesture : int
{
    ISG_Tap        = 0x00000010,
    ISG_DoubleTap  = 0x00000011,
    ISG_RightTap   = 0x00000012,
    ISG_Drag       = 0x00000013,
    ISG_RightDrag  = 0x00000014,
    ISG_HoldEnter  = 0x00000015,
    ISG_HoldLeave  = 0x00000016,
    ISG_HoverEnter = 0x00000017,
    ISG_HoverLeave = 0x00000018,
    ISG_Flick      = 0x0000001f,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-inkrecognitionconfidence))], [])
enum InkRecognitionConfidence : int
{
    IRC_Strong       = 0x00000000,
    IRC_Intermediate = 0x00000001,
    IRC_Poor         = 0x00000002,
}
alias DISPID_InkGesture = int;
enum : int
{
    DISPID_IGId          = 0x00000000,
    DISPID_IGGetHotPoint = 0x00000001,
    DISPID_IGConfidence  = 0x00000002,
}
alias DISPID_InkCursor = int;
enum : int
{
    DISPID_ICsrName              = 0x00000000,
    DISPID_ICsrId                = 0x00000001,
    DISPID_ICsrDrawingAttributes = 0x00000002,
    DISPID_ICsrButtons           = 0x00000003,
    DISPID_ICsrInverted          = 0x00000004,
    DISPID_ICsrTablet            = 0x00000005,
}
alias DISPID_InkCursors = int;
enum : int
{
    DISPID_ICs_NewEnum = 0xfffffffc,
    DISPID_ICsItem     = 0x00000000,
    DISPID_ICsCount    = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-inkcursorbuttonstate))], [])
enum InkCursorButtonState : int
{
    ICBS_Unavailable = 0x00000000,
    ICBS_Up          = 0x00000001,
    ICBS_Down        = 0x00000002,
}
alias DISPID_InkCursorButton = int;
enum : int
{
    DISPID_ICBName  = 0x00000000,
    DISPID_ICBId    = 0x00000001,
    DISPID_ICBState = 0x00000002,
}
alias DISPID_InkCursorButtons = int;
enum : int
{
    DISPID_ICBs_NewEnum = 0xfffffffc,
    DISPID_ICBsItem     = 0x00000000,
    DISPID_ICBsCount    = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-tablethardwarecapabilities))], [])
enum TabletHardwareCapabilities : int
{
    THWC_Integrated             = 0x00000001,
    THWC_CursorMustTouch        = 0x00000002,
    THWC_HardProximity          = 0x00000004,
    THWC_CursorsHavePhysicalIds = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-tabletpropertymetricunit))], [])
enum TabletPropertyMetricUnit : int
{
    TPMU_Default     = 0x00000000,
    TPMU_Inches      = 0x00000001,
    TPMU_Centimeters = 0x00000002,
    TPMU_Degrees     = 0x00000003,
    TPMU_Radians     = 0x00000004,
    TPMU_Seconds     = 0x00000005,
    TPMU_Pounds      = 0x00000006,
    TPMU_Grams       = 0x00000007,
}
alias DISPID_InkTablet = int;
enum : int
{
    DISPID_ITName                      = 0x00000000,
    DISPID_ITPlugAndPlayId             = 0x00000001,
    DISPID_ITPropertyMetrics           = 0x00000002,
    DISPID_ITIsPacketPropertySupported = 0x00000003,
    DISPID_ITMaximumInputRectangle     = 0x00000004,
    DISPID_ITHardwareCapabilities      = 0x00000005,
}
enum TabletDeviceKind : int
{
    TDK_Mouse = 0x00000000,
    TDK_Pen   = 0x00000001,
    TDK_Touch = 0x00000002,
}
alias DISPID_InkTablet2 = int;
enum : int
{
    DISPID_IT2DeviceKind = 0x00000000,
}
alias DISPID_InkTablet3 = int;
enum : int
{
    DISPID_IT3IsMultiTouch   = 0x00000000,
    DISPID_IT3MaximumCursors = 0x00000001,
}
alias DISPID_InkTablets = int;
enum : int
{
    DISPID_ITs_NewEnum                  = 0xfffffffc,
    DISPID_ITsItem                      = 0x00000000,
    DISPID_ITsDefaultTablet             = 0x00000001,
    DISPID_ITsCount                     = 0x00000002,
    DISPID_ITsIsPacketPropertySupported = 0x00000003,
}
alias DISPID_InkStrokeDisp = int;
enum : int
{
    DISPID_ISDInkIndex                            = 0x00000001,
    DISPID_ISDID                                  = 0x00000002,
    DISPID_ISDGetBoundingBox                      = 0x00000003,
    DISPID_ISDDrawingAttributes                   = 0x00000004,
    DISPID_ISDFindIntersections                   = 0x00000005,
    DISPID_ISDGetRectangleIntersections           = 0x00000006,
    DISPID_ISDClip                                = 0x00000007,
    DISPID_ISDHitTestCircle                       = 0x00000008,
    DISPID_ISDNearestPoint                        = 0x00000009,
    DISPID_ISDSplit                               = 0x0000000a,
    DISPID_ISDExtendedProperties                  = 0x0000000b,
    DISPID_ISDInk                                 = 0x0000000c,
    DISPID_ISDBezierPoints                        = 0x0000000d,
    DISPID_ISDPolylineCusps                       = 0x0000000e,
    DISPID_ISDBezierCusps                         = 0x0000000f,
    DISPID_ISDSelfIntersections                   = 0x00000010,
    DISPID_ISDPacketCount                         = 0x00000011,
    DISPID_ISDPacketSize                          = 0x00000012,
    DISPID_ISDPacketDescription                   = 0x00000013,
    DISPID_ISDDeleted                             = 0x00000014,
    DISPID_ISDGetPacketDescriptionPropertyMetrics = 0x00000015,
    DISPID_ISDGetPoints                           = 0x00000016,
    DISPID_ISDSetPoints                           = 0x00000017,
    DISPID_ISDGetPacketData                       = 0x00000018,
    DISPID_ISDGetPacketValuesByProperty           = 0x00000019,
    DISPID_ISDSetPacketValuesByProperty           = 0x0000001a,
    DISPID_ISDGetFlattenedBezierPoints            = 0x0000001b,
    DISPID_ISDScaleToRectangle                    = 0x0000001c,
    DISPID_ISDTransform                           = 0x0000001d,
    DISPID_ISDMove                                = 0x0000001e,
    DISPID_ISDRotate                              = 0x0000001f,
    DISPID_ISDShear                               = 0x00000020,
    DISPID_ISDScale                               = 0x00000021,
}
alias DISPID_InkStrokes = int;
enum : int
{
    DISPID_ISs_NewEnum                = 0xfffffffc,
    DISPID_ISsItem                    = 0x00000000,
    DISPID_ISsCount                   = 0x00000001,
    DISPID_ISsValid                   = 0x00000002,
    DISPID_ISsInk                     = 0x00000003,
    DISPID_ISsAdd                     = 0x00000004,
    DISPID_ISsAddStrokes              = 0x00000005,
    DISPID_ISsRemove                  = 0x00000006,
    DISPID_ISsRemoveStrokes           = 0x00000007,
    DISPID_ISsToString                = 0x00000008,
    DISPID_ISsModifyDrawingAttributes = 0x00000009,
    DISPID_ISsGetBoundingBox          = 0x0000000a,
    DISPID_ISsScaleToRectangle        = 0x0000000b,
    DISPID_ISsTransform               = 0x0000000c,
    DISPID_ISsMove                    = 0x0000000d,
    DISPID_ISsRotate                  = 0x0000000e,
    DISPID_ISsShear                   = 0x0000000f,
    DISPID_ISsScale                   = 0x00000010,
    DISPID_ISsClip                    = 0x00000011,
    DISPID_ISsRecognitionResult       = 0x00000012,
    DISPID_ISsRemoveRecognitionResult = 0x00000013,
}
alias DISPID_InkCustomStrokes = int;
enum : int
{
    DISPID_ICSs_NewEnum = 0xfffffffc,
    DISPID_ICSsItem     = 0x00000000,
    DISPID_ICSsCount    = 0x00000001,
    DISPID_ICSsAdd      = 0x00000002,
    DISPID_ICSsRemove   = 0x00000003,
    DISPID_ICSsClear    = 0x00000004,
}
alias DISPID_StrokeEvent = int;
enum : int
{
    DISPID_SEStrokesAdded   = 0x00000001,
    DISPID_SEStrokesRemoved = 0x00000002,
}
alias DISPID_Ink = int;
enum : int
{
    DISPID_IStrokes                    = 0x00000001,
    DISPID_IExtendedProperties         = 0x00000002,
    DISPID_IGetBoundingBox             = 0x00000003,
    DISPID_IDeleteStrokes              = 0x00000004,
    DISPID_IDeleteStroke               = 0x00000005,
    DISPID_IExtractStrokes             = 0x00000006,
    DISPID_IExtractWithRectangle       = 0x00000007,
    DISPID_IDirty                      = 0x00000008,
    DISPID_ICustomStrokes              = 0x00000009,
    DISPID_IClone                      = 0x0000000a,
    DISPID_IHitTestCircle              = 0x0000000b,
    DISPID_IHitTestWithRectangle       = 0x0000000c,
    DISPID_IHitTestWithLasso           = 0x0000000d,
    DISPID_INearestPoint               = 0x0000000e,
    DISPID_ICreateStrokes              = 0x0000000f,
    DISPID_ICreateStroke               = 0x00000010,
    DISPID_IAddStrokesAtRectangle      = 0x00000011,
    DISPID_IClip                       = 0x00000012,
    DISPID_ISave                       = 0x00000013,
    DISPID_ILoad                       = 0x00000014,
    DISPID_ICreateStrokeFromPoints     = 0x00000015,
    DISPID_IClipboardCopyWithRectangle = 0x00000016,
    DISPID_IClipboardCopy              = 0x00000017,
    DISPID_ICanPaste                   = 0x00000018,
    DISPID_IClipboardPaste             = 0x00000019,
}
alias DISPID_InkEvent = int;
enum : int
{
    DISPID_IEInkAdded   = 0x00000001,
    DISPID_IEInkDeleted = 0x00000002,
}
alias DISPID_InkRenderer = int;
enum : int
{
    DISPID_IRGetViewTransform          = 0x00000001,
    DISPID_IRSetViewTransform          = 0x00000002,
    DISPID_IRGetObjectTransform        = 0x00000003,
    DISPID_IRSetObjectTransform        = 0x00000004,
    DISPID_IRDraw                      = 0x00000005,
    DISPID_IRDrawStroke                = 0x00000006,
    DISPID_IRPixelToInkSpace           = 0x00000007,
    DISPID_IRInkSpaceToPixel           = 0x00000008,
    DISPID_IRPixelToInkSpaceFromPoints = 0x00000009,
    DISPID_IRInkSpaceToPixelFromPoints = 0x0000000a,
    DISPID_IRMeasure                   = 0x0000000b,
    DISPID_IRMeasureStroke             = 0x0000000c,
    DISPID_IRMove                      = 0x0000000d,
    DISPID_IRRotate                    = 0x0000000e,
    DISPID_IRScale                     = 0x0000000f,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-inkcollectoreventinterest))], [])
enum InkCollectorEventInterest : int
{
    ICEI_DefaultEvents    = 0xffffffff,
    ICEI_CursorDown       = 0x00000000,
    ICEI_Stroke           = 0x00000001,
    ICEI_NewPackets       = 0x00000002,
    ICEI_NewInAirPackets  = 0x00000003,
    ICEI_CursorButtonDown = 0x00000004,
    ICEI_CursorButtonUp   = 0x00000005,
    ICEI_CursorInRange    = 0x00000006,
    ICEI_CursorOutOfRange = 0x00000007,
    ICEI_SystemGesture    = 0x00000008,
    ICEI_TabletAdded      = 0x00000009,
    ICEI_TabletRemoved    = 0x0000000a,
    ICEI_MouseDown        = 0x0000000b,
    ICEI_MouseMove        = 0x0000000c,
    ICEI_MouseUp          = 0x0000000d,
    ICEI_MouseWheel       = 0x0000000e,
    ICEI_DblClick         = 0x0000000f,
    ICEI_AllEvents        = 0x00000010,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-inkmousebutton))], [])
enum InkMouseButton : int
{
    IMF_Left   = 0x00000001,
    IMF_Right  = 0x00000002,
    IMF_Middle = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-inkshiftkeymodifierflags))], [])
enum InkShiftKeyModifierFlags : int
{
    IKM_Shift   = 0x00000001,
    IKM_Control = 0x00000002,
    IKM_Alt     = 0x00000004,
}
alias DISPID_InkCollectorEvent = int;
enum : int
{
    DISPID_ICEStroke              = 0x00000001,
    DISPID_ICECursorDown          = 0x00000002,
    DISPID_ICENewPackets          = 0x00000003,
    DISPID_ICENewInAirPackets     = 0x00000004,
    DISPID_ICECursorButtonDown    = 0x00000005,
    DISPID_ICECursorButtonUp      = 0x00000006,
    DISPID_ICECursorInRange       = 0x00000007,
    DISPID_ICECursorOutOfRange    = 0x00000008,
    DISPID_ICESystemGesture       = 0x00000009,
    DISPID_ICEGesture             = 0x0000000a,
    DISPID_ICETabletAdded         = 0x0000000b,
    DISPID_ICETabletRemoved       = 0x0000000c,
    DISPID_IOEPainting            = 0x0000000d,
    DISPID_IOEPainted             = 0x0000000e,
    DISPID_IOESelectionChanging   = 0x0000000f,
    DISPID_IOESelectionChanged    = 0x00000010,
    DISPID_IOESelectionMoving     = 0x00000011,
    DISPID_IOESelectionMoved      = 0x00000012,
    DISPID_IOESelectionResizing   = 0x00000013,
    DISPID_IOESelectionResized    = 0x00000014,
    DISPID_IOEStrokesDeleting     = 0x00000015,
    DISPID_IOEStrokesDeleted      = 0x00000016,
    DISPID_IPEChangeUICues        = 0x00000017,
    DISPID_IPEClick               = 0x00000018,
    DISPID_IPEDblClick            = 0x00000019,
    DISPID_IPEInvalidated         = 0x0000001a,
    DISPID_IPEMouseDown           = 0x0000001b,
    DISPID_IPEMouseEnter          = 0x0000001c,
    DISPID_IPEMouseHover          = 0x0000001d,
    DISPID_IPEMouseLeave          = 0x0000001e,
    DISPID_IPEMouseMove           = 0x0000001f,
    DISPID_IPEMouseUp             = 0x00000020,
    DISPID_IPEMouseWheel          = 0x00000021,
    DISPID_IPESizeModeChanged     = 0x00000022,
    DISPID_IPEStyleChanged        = 0x00000023,
    DISPID_IPESystemColorsChanged = 0x00000024,
    DISPID_IPEKeyDown             = 0x00000025,
    DISPID_IPEKeyPress            = 0x00000026,
    DISPID_IPEKeyUp               = 0x00000027,
    DISPID_IPEResize              = 0x00000028,
    DISPID_IPESizeChanged         = 0x00000029,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-inkoverlayeditingmode))], [])
enum InkOverlayEditingMode : int
{
    IOEM_Ink    = 0x00000000,
    IOEM_Delete = 0x00000001,
    IOEM_Select = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-inkoverlayattachmode))], [])
enum InkOverlayAttachMode : int
{
    IOAM_Behind  = 0x00000000,
    IOAM_InFront = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-inkpicturesizemode))], [])
enum InkPictureSizeMode : int
{
    IPSM_AutoSize     = 0x00000000,
    IPSM_CenterImage  = 0x00000001,
    IPSM_Normal       = 0x00000002,
    IPSM_StretchImage = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-inkoverlayerasermode))], [])
enum InkOverlayEraserMode : int
{
    IOERM_StrokeErase = 0x00000000,
    IOERM_PointErase  = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-inkcollectionmode))], [])
enum InkCollectionMode : int
{
    ICM_InkOnly       = 0x00000000,
    ICM_GestureOnly   = 0x00000001,
    ICM_InkAndGesture = 0x00000002,
}
alias DISPID_InkCollector = int;
enum : int
{
    DISPID_ICEnabled                        = 0x00000001,
    DISPID_ICHwnd                           = 0x00000002,
    DISPID_ICPaint                          = 0x00000003,
    DISPID_ICText                           = 0x00000004,
    DISPID_ICDefaultDrawingAttributes       = 0x00000005,
    DISPID_ICRenderer                       = 0x00000006,
    DISPID_ICInk                            = 0x00000007,
    DISPID_ICAutoRedraw                     = 0x00000008,
    DISPID_ICCollectingInk                  = 0x00000009,
    DISPID_ICSetEventInterest               = 0x0000000a,
    DISPID_ICGetEventInterest               = 0x0000000b,
    DISPID_IOEditingMode                    = 0x0000000c,
    DISPID_IOSelection                      = 0x0000000d,
    DISPID_IOAttachMode                     = 0x0000000e,
    DISPID_IOHitTestSelection               = 0x0000000f,
    DISPID_IODraw                           = 0x00000010,
    DISPID_IPPicture                        = 0x00000011,
    DISPID_IPSizeMode                       = 0x00000012,
    DISPID_IPBackColor                      = 0x00000013,
    DISPID_ICCursors                        = 0x00000014,
    DISPID_ICMarginX                        = 0x00000015,
    DISPID_ICMarginY                        = 0x00000016,
    DISPID_ICSetWindowInputRectangle        = 0x00000017,
    DISPID_ICGetWindowInputRectangle        = 0x00000018,
    DISPID_ICTablet                         = 0x00000019,
    DISPID_ICSetAllTabletsMode              = 0x0000001a,
    DISPID_ICSetSingleTabletIntegratedMode  = 0x0000001b,
    DISPID_ICCollectionMode                 = 0x0000001c,
    DISPID_ICSetGestureStatus               = 0x0000001d,
    DISPID_ICGetGestureStatus               = 0x0000001e,
    DISPID_ICDynamicRendering               = 0x0000001f,
    DISPID_ICDesiredPacketDescription       = 0x00000020,
    DISPID_IOEraserMode                     = 0x00000021,
    DISPID_IOEraserWidth                    = 0x00000022,
    DISPID_ICMouseIcon                      = 0x00000023,
    DISPID_ICMousePointer                   = 0x00000024,
    DISPID_IPInkEnabled                     = 0x00000025,
    DISPID_ICSupportHighContrastInk         = 0x00000026,
    DISPID_IOSupportHighContrastSelectionUI = 0x00000027,
}
alias DISPID_InkRecognizer = int;
enum : int
{
    DISPID_RecoClsid                      = 0x00000001,
    DISPID_RecoName                       = 0x00000002,
    DISPID_RecoVendor                     = 0x00000003,
    DISPID_RecoCapabilities               = 0x00000004,
    DISPID_RecoLanguageID                 = 0x00000005,
    DISPID_RecoPreferredPacketDescription = 0x00000006,
    DISPID_RecoCreateRecognizerContext    = 0x00000007,
    DISPID_RecoSupportedProperties        = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-inkrecognizercapabilities))], [])
enum InkRecognizerCapabilities : int
{
    IRC_DontCare                     = 0x00000001,
    IRC_Object                       = 0x00000002,
    IRC_FreeInput                    = 0x00000004,
    IRC_LinedInput                   = 0x00000008,
    IRC_BoxedInput                   = 0x00000010,
    IRC_CharacterAutoCompletionInput = 0x00000020,
    IRC_RightAndDown                 = 0x00000040,
    IRC_LeftAndDown                  = 0x00000080,
    IRC_DownAndLeft                  = 0x00000100,
    IRC_DownAndRight                 = 0x00000200,
    IRC_ArbitraryAngle               = 0x00000400,
    IRC_Lattice                      = 0x00000800,
    IRC_AdviseInkChange              = 0x00001000,
    IRC_StrokeReorder                = 0x00002000,
    IRC_Personalizable               = 0x00004000,
    IRC_PrefersArbitraryAngle        = 0x00008000,
    IRC_PrefersParagraphBreaking     = 0x00010000,
    IRC_PrefersSegmentation          = 0x00020000,
    IRC_Cursive                      = 0x00040000,
    IRC_TextPrediction               = 0x00080000,
    IRC_Alpha                        = 0x00100000,
    IRC_Beta                         = 0x00200000,
}
alias DISPID_InkRecognizer2 = int;
enum : int
{
    DISPID_RecoId            = 0x00000000,
    DISPID_RecoUnicodeRanges = 0x00000001,
}
alias DISPID_InkRecognizers = int;
enum : int
{
    DISPID_IRecos_NewEnum             = 0xfffffffc,
    DISPID_IRecosItem                 = 0x00000000,
    DISPID_IRecosCount                = 0x00000001,
    DISPID_IRecosGetDefaultRecognizer = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-inkrecognizercharacterautocompletionmode))], [])
enum InkRecognizerCharacterAutoCompletionMode : int
{
    IRCACM_Full   = 0x00000000,
    IRCACM_Prefix = 0x00000001,
    IRCACM_Random = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-inkrecognitionmodes))], [])
enum InkRecognitionModes : int
{
    IRM_None                   = 0x00000000,
    IRM_WordModeOnly           = 0x00000001,
    IRM_Coerce                 = 0x00000002,
    IRM_TopInkBreaksOnly       = 0x00000004,
    IRM_PrefixOk               = 0x00000008,
    IRM_LineMode               = 0x00000010,
    IRM_DisablePersonalization = 0x00000020,
    IRM_AutoSpace              = 0x00000040,
    IRM_Max                    = 0x00000080,
}
alias DISPID_InkRecognitionEvent = int;
enum : int
{
    DISPID_IRERecognitionWithAlternates = 0x00000001,
    DISPID_IRERecognition               = 0x00000002,
}
alias DISPID_InkRecoContext = int;
enum : int
{
    DISPID_IRecoCtx_Strokes                           = 0x00000001,
    DISPID_IRecoCtx_CharacterAutoCompletionMode       = 0x00000002,
    DISPID_IRecoCtx_Factoid                           = 0x00000003,
    DISPID_IRecoCtx_WordList                          = 0x00000004,
    DISPID_IRecoCtx_Recognizer                        = 0x00000005,
    DISPID_IRecoCtx_Guide                             = 0x00000006,
    DISPID_IRecoCtx_Flags                             = 0x00000007,
    DISPID_IRecoCtx_PrefixText                        = 0x00000008,
    DISPID_IRecoCtx_SuffixText                        = 0x00000009,
    DISPID_IRecoCtx_StopRecognition                   = 0x0000000a,
    DISPID_IRecoCtx_Clone                             = 0x0000000b,
    DISPID_IRecoCtx_Recognize                         = 0x0000000c,
    DISPID_IRecoCtx_StopBackgroundRecognition         = 0x0000000d,
    DISPID_IRecoCtx_EndInkInput                       = 0x0000000e,
    DISPID_IRecoCtx_BackgroundRecognize               = 0x0000000f,
    DISPID_IRecoCtx_BackgroundRecognizeWithAlternates = 0x00000010,
    DISPID_IRecoCtx_IsStringSupported                 = 0x00000011,
}
alias DISPID_InkRecoContext2 = int;
enum : int
{
    DISPID_IRecoCtx2_EnabledUnicodeRanges = 0x00000000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ne-msinkaut-inkrecognitionalternatesselection))], [])
enum InkRecognitionAlternatesSelection : int
{
    IRAS_Start        = 0x00000000,
    IRAS_DefaultCount = 0x0000000a,
    IRAS_All          = 0xffffffff,
}
alias DISPID_InkRecognitionResult = int;
enum : int
{
    DISPID_InkRecognitionResult_TopString               = 0x00000001,
    DISPID_InkRecognitionResult_TopAlternate            = 0x00000002,
    DISPID_InkRecognitionResult_Strokes                 = 0x00000003,
    DISPID_InkRecognitionResult_TopConfidence           = 0x00000004,
    DISPID_InkRecognitionResult_AlternatesFromSelection = 0x00000005,
    DISPID_InkRecognitionResult_ModifyTopAlternate      = 0x00000006,
    DISPID_InkRecognitionResult_SetResultOnStrokes      = 0x00000007,
}
alias DISPID_InkRecoAlternate = int;
enum : int
{
    DISPID_InkRecoAlternate_String                               = 0x00000001,
    DISPID_InkRecoAlternate_LineNumber                           = 0x00000002,
    DISPID_InkRecoAlternate_Baseline                             = 0x00000003,
    DISPID_InkRecoAlternate_Midline                              = 0x00000004,
    DISPID_InkRecoAlternate_Ascender                             = 0x00000005,
    DISPID_InkRecoAlternate_Descender                            = 0x00000006,
    DISPID_InkRecoAlternate_Confidence                           = 0x00000007,
    DISPID_InkRecoAlternate_Strokes                              = 0x00000008,
    DISPID_InkRecoAlternate_GetStrokesFromStrokeRanges           = 0x00000009,
    DISPID_InkRecoAlternate_GetStrokesFromTextRange              = 0x0000000a,
    DISPID_InkRecoAlternate_GetTextRangeFromStrokes              = 0x0000000b,
    DISPID_InkRecoAlternate_GetPropertyValue                     = 0x0000000c,
    DISPID_InkRecoAlternate_LineAlternates                       = 0x0000000d,
    DISPID_InkRecoAlternate_ConfidenceAlternates                 = 0x0000000e,
    DISPID_InkRecoAlternate_AlternatesWithConstantPropertyValues = 0x0000000f,
}
alias DISPID_InkRecognitionAlternates = int;
enum : int
{
    DISPID_InkRecognitionAlternates_NewEnum = 0xfffffffc,
    DISPID_InkRecognitionAlternates_Item    = 0x00000000,
    DISPID_InkRecognitionAlternates_Count   = 0x00000001,
    DISPID_InkRecognitionAlternates_Strokes = 0x00000002,
}
alias DISPID_InkRecognizerGuide = int;
enum : int
{
    DISPID_IRGWritingBox = 0x00000001,
    DISPID_IRGDrawnBox   = 0x00000002,
    DISPID_IRGRows       = 0x00000003,
    DISPID_IRGColumns    = 0x00000004,
    DISPID_IRGMidline    = 0x00000005,
    DISPID_IRGGuideData  = 0x00000006,
}
alias DISPID_InkWordList = int;
enum : int
{
    DISPID_InkWordList_AddWord    = 0x00000000,
    DISPID_InkWordList_RemoveWord = 0x00000001,
    DISPID_InkWordList_Merge      = 0x00000002,
}
alias DISPID_InkWordList2 = int;
enum : int
{
    DISPID_InkWordList2_AddWords = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut15/ne-msinkaut15-inkdivisiontype))], [])
enum InkDivisionType : int
{
    IDT_Segment   = 0x00000000,
    IDT_Line      = 0x00000001,
    IDT_Paragraph = 0x00000002,
    IDT_Drawing   = 0x00000003,
}
alias DISPID_InkDivider = int;
enum : int
{
    DISPID_IInkDivider_Strokes           = 0x00000001,
    DISPID_IInkDivider_RecognizerContext = 0x00000002,
    DISPID_IInkDivider_LineHeight        = 0x00000003,
    DISPID_IInkDivider_Divide            = 0x00000004,
}
alias DISPID_InkDivisionResult = int;
enum : int
{
    DISPID_IInkDivisionResult_Strokes      = 0x00000001,
    DISPID_IInkDivisionResult_ResultByType = 0x00000002,
}
alias DISPID_InkDivisionUnit = int;
enum : int
{
    DISPID_IInkDivisionUnit_Strokes           = 0x00000001,
    DISPID_IInkDivisionUnit_DivisionType      = 0x00000002,
    DISPID_IInkDivisionUnit_RecognizedString  = 0x00000003,
    DISPID_IInkDivisionUnit_RotationTransform = 0x00000004,
}
alias DISPID_InkDivisionUnits = int;
enum : int
{
    DISPID_IInkDivisionUnits_NewEnum = 0xfffffffc,
    DISPID_IInkDivisionUnits_Item    = 0x00000000,
    DISPID_IInkDivisionUnits_Count   = 0x00000001,
}
alias DISPID_PenInputPanel = int;
enum : int
{
    DISPID_PIPAttachedEditWindow = 0x00000000,
    DISPID_PIPFactoid            = 0x00000001,
    DISPID_PIPCurrentPanel       = 0x00000002,
    DISPID_PIPDefaultPanel       = 0x00000003,
    DISPID_PIPVisible            = 0x00000004,
    DISPID_PIPTop                = 0x00000005,
    DISPID_PIPLeft               = 0x00000006,
    DISPID_PIPWidth              = 0x00000007,
    DISPID_PIPHeight             = 0x00000008,
    DISPID_PIPMoveTo             = 0x00000009,
    DISPID_PIPCommitPendingInput = 0x0000000a,
    DISPID_PIPRefresh            = 0x0000000b,
    DISPID_PIPBusy               = 0x0000000c,
    DISPID_PIPVerticalOffset     = 0x0000000d,
    DISPID_PIPHorizontalOffset   = 0x0000000e,
    DISPID_PIPEnableTsf          = 0x0000000f,
    DISPID_PIPAutoShow           = 0x00000010,
}
alias DISPID_PenInputPanelEvents = int;
enum : int
{
    DISPID_PIPEVisibleChanged = 0x00000000,
    DISPID_PIPEPanelChanged   = 0x00000001,
    DISPID_PIPEInputFailed    = 0x00000002,
    DISPID_PIPEPanelMoving    = 0x00000003,
}
enum VisualState : int
{
    InPlace      = 0x00000000,
    Floating     = 0x00000001,
    DockedTop    = 0x00000002,
    DockedBottom = 0x00000003,
    Closed       = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/ne-peninputpanel-interactionmode))], [])
enum InteractionMode : int
{
    InteractionMode_InPlace      = 0x00000000,
    InteractionMode_Floating     = 0x00000001,
    InteractionMode_DockedTop    = 0x00000002,
    InteractionMode_DockedBottom = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/ne-peninputpanel-inplacestate))], [])
enum InPlaceState : int
{
    InPlaceState_Auto        = 0x00000000,
    InPlaceState_HoverTarget = 0x00000001,
    InPlaceState_Expanded    = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/ne-peninputpanel-panelinputarea))], [])
enum PanelInputArea : int
{
    PanelInputArea_Auto         = 0x00000000,
    PanelInputArea_Keyboard     = 0x00000001,
    PanelInputArea_WritingPad   = 0x00000002,
    PanelInputArea_CharacterPad = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/ne-peninputpanel-correctionmode))], [])
enum CorrectionMode : int
{
    CorrectionMode_NotVisible             = 0x00000000,
    CorrectionMode_PreInsertion           = 0x00000001,
    CorrectionMode_PostInsertionCollapsed = 0x00000002,
    CorrectionMode_PostInsertionExpanded  = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/ne-peninputpanel-correctionposition))], [])
enum CorrectionPosition : int
{
    CorrectionPosition_Auto   = 0x00000000,
    CorrectionPosition_Bottom = 0x00000001,
    CorrectionPosition_Top    = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/ne-peninputpanel-inplacedirection))], [])
enum InPlaceDirection : int
{
    InPlaceDirection_Auto   = 0x00000000,
    InPlaceDirection_Bottom = 0x00000001,
    InPlaceDirection_Top    = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/ne-peninputpanel-eventmask))], [])
enum EventMask : int
{
    EventMask_InPlaceStateChanging      = 0x00000001,
    EventMask_InPlaceStateChanged       = 0x00000002,
    EventMask_InPlaceSizeChanging       = 0x00000004,
    EventMask_InPlaceSizeChanged        = 0x00000008,
    EventMask_InputAreaChanging         = 0x00000010,
    EventMask_InputAreaChanged          = 0x00000020,
    EventMask_CorrectionModeChanging    = 0x00000040,
    EventMask_CorrectionModeChanged     = 0x00000080,
    EventMask_InPlaceVisibilityChanging = 0x00000100,
    EventMask_InPlaceVisibilityChanged  = 0x00000200,
    EventMask_TextInserting             = 0x00000400,
    EventMask_TextInserted              = 0x00000800,
    EventMask_All                       = 0x00000fff,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/ne-peninputpanel-paneltype))], [])
enum PanelType : int
{
    PT_Default     = 0x00000000,
    PT_Inactive    = 0x00000001,
    PT_Handwriting = 0x00000002,
    PT_Keyboard    = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tabflicks/ne-tabflicks-flickdirection))], [])
alias FLICKDIRECTION = int;
enum : int
{
    FLICKDIRECTION_MIN       = 0x00000000,
    FLICKDIRECTION_RIGHT     = 0x00000000,
    FLICKDIRECTION_UPRIGHT   = 0x00000001,
    FLICKDIRECTION_UP        = 0x00000002,
    FLICKDIRECTION_UPLEFT    = 0x00000003,
    FLICKDIRECTION_LEFT      = 0x00000004,
    FLICKDIRECTION_DOWNLEFT  = 0x00000005,
    FLICKDIRECTION_DOWN      = 0x00000006,
    FLICKDIRECTION_DOWNRIGHT = 0x00000007,
    FLICKDIRECTION_INVALID   = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tabflicks/ne-tabflicks-flickmode))], [])
alias FLICKMODE = int;
enum : int
{
    FLICKMODE_MIN      = 0x00000000,
    FLICKMODE_OFF      = 0x00000000,
    FLICKMODE_ON       = 0x00000001,
    FLICKMODE_LEARNING = 0x00000002,
    FLICKMODE_MAX      = 0x00000002,
    FLICKMODE_DEFAULT  = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tabflicks/ne-tabflicks-flickaction_commandcode))], [])
alias FLICKACTION_COMMANDCODE = int;
enum : int
{
    FLICKACTION_COMMANDCODE_NULL        = 0x00000000,
    FLICKACTION_COMMANDCODE_SCROLL      = 0x00000001,
    FLICKACTION_COMMANDCODE_APPCOMMAND  = 0x00000002,
    FLICKACTION_COMMANDCODE_CUSTOMKEY   = 0x00000003,
    FLICKACTION_COMMANDCODE_KEYMODIFIER = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tabflicks/ne-tabflicks-scrolldirection))], [])
alias SCROLLDIRECTION = int;
enum : int
{
    SCROLLDIRECTION_UP   = 0x00000000,
    SCROLLDIRECTION_DOWN = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tabflicks/ne-tabflicks-keymodifier))], [])
alias KEYMODIFIER = int;
enum : int
{
    KEYMODIFIER_CONTROL = 0x00000001,
    KEYMODIFIER_MENU    = 0x00000002,
    KEYMODIFIER_SHIFT   = 0x00000004,
    KEYMODIFIER_WIN     = 0x00000008,
    KEYMODIFIER_ALTGR   = 0x00000010,
    KEYMODIFIER_EXT     = 0x00000020,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/ne-inked-mousebutton))], [])
enum MouseButton : int
{
    NO_BUTTON     = 0x00000000,
    LEFT_BUTTON   = 0x00000001,
    RIGHT_BUTTON  = 0x00000002,
    MIDDLE_BUTTON = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/ne-inked-selalignmentconstants))], [])
enum SelAlignmentConstants : int
{
    rtfLeft   = 0x00000000,
    rtfRight  = 0x00000001,
    rtfCenter = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/ne-inked-dispid_inkedit))], [])
alias DISPID_InkEdit = int;
enum : int
{
    DISPID_Text               = 0x00000000,
    DISPID_TextRTF            = 0x00000001,
    DISPID_Hwnd               = 0x00000002,
    DISPID_DisableNoScroll    = 0x00000003,
    DISPID_Locked             = 0x00000004,
    DISPID_Enabled            = 0x00000005,
    DISPID_MaxLength          = 0x00000006,
    DISPID_MultiLine          = 0x00000007,
    DISPID_ScrollBars         = 0x00000008,
    DISPID_RTSelStart         = 0x00000009,
    DISPID_RTSelLength        = 0x0000000a,
    DISPID_RTSelText          = 0x0000000b,
    DISPID_SelAlignment       = 0x0000000c,
    DISPID_SelBold            = 0x0000000d,
    DISPID_SelCharOffset      = 0x0000000e,
    DISPID_SelColor           = 0x0000000f,
    DISPID_SelFontName        = 0x00000010,
    DISPID_SelFontSize        = 0x00000011,
    DISPID_SelItalic          = 0x00000012,
    DISPID_SelRTF             = 0x00000013,
    DISPID_SelUnderline       = 0x00000014,
    DISPID_DragIcon           = 0x00000015,
    DISPID_Status             = 0x00000016,
    DISPID_UseMouseForInput   = 0x00000017,
    DISPID_InkMode            = 0x00000018,
    DISPID_InkInsertMode      = 0x00000019,
    DISPID_RecoTimeout        = 0x0000001a,
    DISPID_DrawAttr           = 0x0000001b,
    DISPID_Recognizer         = 0x0000001c,
    DISPID_Factoid            = 0x0000001d,
    DISPID_SelInk             = 0x0000001e,
    DISPID_SelInksDisplayMode = 0x0000001f,
    DISPID_Recognize          = 0x00000020,
    DISPID_GetGestStatus      = 0x00000021,
    DISPID_SetGestStatus      = 0x00000022,
    DISPID_Refresh            = 0x00000023,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/ne-inked-dispid_inkeditevents))], [])
alias DISPID_InkEditEvents = int;
enum : int
{
    DISPID_IeeChange            = 0x00000001,
    DISPID_IeeSelChange         = 0x00000002,
    DISPID_IeeKeyDown           = 0x00000003,
    DISPID_IeeKeyUp             = 0x00000004,
    DISPID_IeeMouseUp           = 0x00000005,
    DISPID_IeeMouseDown         = 0x00000006,
    DISPID_IeeKeyPress          = 0x00000007,
    DISPID_IeeDblClick          = 0x00000008,
    DISPID_IeeClick             = 0x00000009,
    DISPID_IeeMouseMove         = 0x0000000a,
    DISPID_IeeCursorDown        = 0x00000015,
    DISPID_IeeStroke            = 0x00000016,
    DISPID_IeeGesture           = 0x00000017,
    DISPID_IeeRecognitionResult = 0x00000018,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/ne-inked-inkmode))], [])
enum InkMode : int
{
    IEM_Disabled      = 0x00000000,
    IEM_Ink           = 0x00000001,
    IEM_InkAndGesture = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/ne-inked-inkinsertmode))], [])
enum InkInsertMode : int
{
    IEM_InsertText = 0x00000000,
    IEM_InsertInk  = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/ne-inked-inkeditstatus))], [])
enum InkEditStatus : int
{
    IES_Idle        = 0x00000000,
    IES_Collecting  = 0x00000001,
    IES_Recognizing = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/ne-inked-inkdisplaymode))], [])
enum InkDisplayMode : int
{
    IDM_Ink  = 0x00000000,
    IDM_Text = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/ne-inked-appearanceconstants))], [])
enum AppearanceConstants : int
{
    rtfFlat   = 0x00000000,
    rtfThreeD = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/ne-inked-borderstyleconstants))], [])
enum BorderStyleConstants : int
{
    rtfNoBorder    = 0x00000000,
    rtfFixedSingle = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/ne-inked-scrollbarsconstants))], [])
enum ScrollBarsConstants : int
{
    rtfNone       = 0x00000000,
    rtfHorizontal = 0x00000001,
    rtfVertical   = 0x00000002,
    rtfBoth       = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/micaut/ne-micaut-micuielement))], [])
alias MICUIELEMENT = int;
enum : int
{
    MICUIELEMENT_BUTTON_WRITE           = 0x00000001,
    MICUIELEMENT_BUTTON_ERASE           = 0x00000002,
    MICUIELEMENT_BUTTON_CORRECT         = 0x00000004,
    MICUIELEMENT_BUTTON_CLEAR           = 0x00000008,
    MICUIELEMENT_BUTTON_UNDO            = 0x00000010,
    MICUIELEMENT_BUTTON_REDO            = 0x00000020,
    MICUIELEMENT_BUTTON_INSERT          = 0x00000040,
    MICUIELEMENT_BUTTON_CANCEL          = 0x00000080,
    MICUIELEMENT_INKPANEL_BACKGROUND    = 0x00000100,
    MICUIELEMENT_RESULTPANEL_BACKGROUND = 0x00000200,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/micaut/ne-micaut-micuielementstate))], [])
alias MICUIELEMENTSTATE = int;
enum : int
{
    MICUIELEMENTSTATE_NORMAL   = 0x00000001,
    MICUIELEMENTSTATE_HOT      = 0x00000002,
    MICUIELEMENTSTATE_PRESSED  = 0x00000003,
    MICUIELEMENTSTATE_DISABLED = 0x00000004,
}
alias DISPID_MathInputControlEvents = int;
enum : int
{
    DISPID_MICInsert = 0x00000000,
    DISPID_MICClose  = 0x00000001,
    DISPID_MICPaint  = 0x00000002,
    DISPID_MICClear  = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/ne-rtscom-realtimestylusdatainterest))], [])
enum RealTimeStylusDataInterest : int
{
    RTSDI_AllData                = 0xffffffff,
    RTSDI_None                   = 0x00000000,
    RTSDI_Error                  = 0x00000001,
    RTSDI_RealTimeStylusEnabled  = 0x00000002,
    RTSDI_RealTimeStylusDisabled = 0x00000004,
    RTSDI_StylusNew              = 0x00000008,
    RTSDI_StylusInRange          = 0x00000010,
    RTSDI_InAirPackets           = 0x00000020,
    RTSDI_StylusOutOfRange       = 0x00000040,
    RTSDI_StylusDown             = 0x00000080,
    RTSDI_Packets                = 0x00000100,
    RTSDI_StylusUp               = 0x00000200,
    RTSDI_StylusButtonUp         = 0x00000400,
    RTSDI_StylusButtonDown       = 0x00000800,
    RTSDI_SystemEvents           = 0x00001000,
    RTSDI_TabletAdded            = 0x00002000,
    RTSDI_TabletRemoved          = 0x00004000,
    RTSDI_CustomStylusDataAdded  = 0x00008000,
    RTSDI_UpdateMapping          = 0x00010000,
    RTSDI_DefaultEvents          = 0x00009386,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/ne-rtscom-stylusqueue))], [])
enum StylusQueue : int
{
    SyncStylusQueue           = 0x00000001,
    AsyncStylusQueueImmediate = 0x00000002,
    AsyncStylusQueue          = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/ne-rtscom-realtimestyluslocktype))], [])
enum RealTimeStylusLockType : int
{
    RTSLT_ObjLock         = 0x00000001,
    RTSLT_SyncEventLock   = 0x00000002,
    RTSLT_AsyncEventLock  = 0x00000004,
    RTSLT_ExcludeCallback = 0x00000008,
    RTSLT_SyncObjLock     = 0x0000000b,
    RTSLT_AsyncObjLock    = 0x0000000d,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rectypes/ne-rectypes-line_metrics))], [])
alias LINE_METRICS = int;
enum : int
{
    LM_BASELINE  = 0x00000000,
    LM_MIDLINE   = 0x00000001,
    LM_ASCENDER  = 0x00000002,
    LM_DESCENDER = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rectypes/ne-rectypes-confidence_level))], [])
alias CONFIDENCE_LEVEL = int;
enum : int
{
    CFL_STRONG       = 0x00000000,
    CFL_INTERMEDIATE = 0x00000001,
    CFL_POOR         = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rectypes/ne-rectypes-alt_breaks))], [])
alias ALT_BREAKS = int;
enum : int
{
    ALT_BREAKS_SAME   = 0x00000000,
    ALT_BREAKS_UNIQUE = 0x00000001,
    ALT_BREAKS_FULL   = 0x00000002,
}
alias RECO_TYPE = int;
enum : int
{
    RECO_TYPE_WSTRING = 0x00000000,
    RECO_TYPE_WCHAR   = 0x00000001,
}

// Constants


enum const(wchar)* MICROSOFT_URL_EXPERIENCE_PROPERTY = "Microsoft TIP URL Experience";
enum const(wchar)* MICROSOFT_TIP_NO_INSERT_BUTTON_PROPERTY = "Microsoft TIP No Insert Option";
enum const(wchar)* MICROSOFT_TIP_COMBOBOXLIST_PROPERTY = "Microsoft TIP ComboBox List Window Identifier";
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/tablet/microsoft-tip-opening-msg))], [])*/const(wchar)* MICROSOFT_TIP_OPENING_MSG = "TabletInputPanelOpening";
enum uint SAFE_PARTIAL = 0x00000001;
enum uint BEST_COMPLETE = 0x00000002;
enum uint MAX_VENDORNAME = 0x00000020;
enum uint MAX_FRIENDLYNAME = 0x00000040;
enum uint MAX_LANGUAGES = 0x00000040;

enum : uint
{
    CAC_FULL   = 0x00000000,
    CAC_PREFIX = 0x00000001,
}

enum uint CAC_RANDOM = 0x00000002;

enum : uint
{
    ASYNC_RECO_INTERRUPTED       = 0x00000001,
    ASYNC_RECO_PROCESS_FAILED    = 0x00000002,
    ASYNC_RECO_ADDSTROKE_FAILED  = 0x00000004,
    ASYNC_RECO_SETCACMODE_FAILED = 0x00000008,
}

enum uint ASYNC_RECO_RESETCONTEXT_FAILED = 0x00000010;

enum : uint
{
    ASYNC_RECO_SETGUIDE_FAILED       = 0x00000020,
    ASYNC_RECO_SETFLAGS_FAILED       = 0x00000040,
    ASYNC_RECO_SETFACTOID_FAILED     = 0x00000080,
    ASYNC_RECO_SETTEXTCONTEXT_FAILED = 0x00000100,
    ASYNC_RECO_SETWORDLIST_FAILED    = 0x00000200,
}

enum int RF_DONTCARE = 0x00000001;
enum int RF_OBJECT = 0x00000002;
enum int RF_FREE_INPUT = 0x00000004;
enum int RF_LINED_INPUT = 0x00000008;
enum int RF_BOXED_INPUT = 0x00000010;
enum int RF_CAC_INPUT = 0x00000020;
enum int RF_RIGHT_AND_DOWN = 0x00000040;
enum int RF_LEFT_AND_DOWN = 0x00000080;

enum : int
{
    RF_DOWN_AND_LEFT  = 0x00000100,
    RF_DOWN_AND_RIGHT = 0x00000200,
}

enum int RF_ARBITRARY_ANGLE = 0x00000400;
enum int RF_LATTICE = 0x00000800;
enum int RF_ADVISEINKCHANGE = 0x00001000;
enum int RF_STROKEREORDER = 0x00002000;
enum int RF_PERSONALIZABLE = 0x00004000;
enum int RF_PERFORMSLINEBREAKING = 0x00010000;
enum int RF_REQUIRESSEGMENTATIONBREAKING = 0x00020000;
enum uint FLICK_WM_HANDLED_MASK = 0x00000001;
enum uint NUM_FLICK_DIRECTIONS = 0x00000008;

enum : uint
{
    WM_TABLET_DEFBASE                  = 0x000002c0,
    WM_TABLET_MAXOFFSET                = 0x00000020,
    WM_TABLET_ADDED                    = 0x000002c8,
    WM_TABLET_DELETED                  = 0x000002c9,
    WM_TABLET_FLICK                    = 0x000002cb,
    WM_TABLET_QUERYSYSTEMGESTURESTATUS = 0x000002cc,
}

enum : uint
{
    TABLET_DISABLE_PRESSANDHOLD      = 0x00000001,
    TABLET_DISABLE_PENTAPFEEDBACK    = 0x00000008,
    TABLET_DISABLE_PENBARRELFEEDBACK = 0x00000010,
    TABLET_DISABLE_TOUCHUIFORCEON    = 0x00000100,
    TABLET_DISABLE_TOUCHUIFORCEOFF   = 0x00000200,
    TABLET_DISABLE_TOUCHSWITCH       = 0x00008000,
    TABLET_DISABLE_FLICKS            = 0x00010000,
}

enum : uint
{
    TABLET_ENABLE_FLICKSONCONTEXT   = 0x00020000,
    TABLET_ENABLE_FLICKLEARNINGMODE = 0x00040000,
}

enum : uint
{
    TABLET_DISABLE_SMOOTHSCROLLING   = 0x00080000,
    TABLET_DISABLE_FLICKFALLBACKKEYS = 0x00100000,
}

enum uint TABLET_ENABLE_MULTITOUCHDATA = 0x01000000;

enum : uint
{
    MAX_PACKET_PROPERTY_COUNT = 0x00000020,
    MAX_PACKET_BUTTON_COUNT   = 0x00000020,
}

enum uint IP_CURSOR_DOWN = 0x00000001;
enum uint IP_INVERTED = 0x00000002;
enum uint IP_MARGIN = 0x00000004;
enum const(wchar)* INK_SERIALIZED_FORMAT = "Ink Serialized Format";

enum : const(wchar)*
{
    STR_GUID_X              = "{598A6A8F-52C0-4BA0-93AF-AF357411A561}",
    STR_GUID_Y              = "{B53F9F75-04E0-4498-A7EE-C30DBB5A9011}",
    STR_GUID_Z              = "{735ADB30-0EBB-4788-A0E4-0F316490055D}",
    STR_GUID_PAKETSTATUS    = "{6E0E07BF-AFE7-4CF7-87D1-AF6446208418}",
    STR_GUID_TIMERTICK      = "{436510C5-FED3-45D1-8B76-71D3EA7A829D}",
    STR_GUID_SERIALNUMBER   = "{78A81B56-0935-4493-BAAE-00541A8A16C4}",
    STR_GUID_NORMALPRESSURE = "{7307502D-F9F4-4E18-B3F2-2CE1B1A3610C}",
}

enum const(wchar)* STR_GUID_TANGENTPRESSURE = "{6DA4488B-5244-41EC-905B-32D89AB80809}";
enum const(wchar)* STR_GUID_BUTTONPRESSURE = "{8B7FEFC4-96AA-4BFE-AC26-8A5F0BE07BF5}";
enum const(wchar)* STR_GUID_XTILTORIENTATION = "{A8D07B3A-8BF0-40B0-95A9-B80A6BB787BF}";
enum const(wchar)* STR_GUID_YTILTORIENTATION = "{0E932389-1D77-43AF-AC00-5B950D6D4B2D}";
enum const(wchar)* STR_GUID_AZIMUTHORIENTATION = "{029123B4-8828-410B-B250-A0536595E5DC}";
enum const(wchar)* STR_GUID_ALTITUDEORIENTATION = "{82DEC5C7-F6BA-4906-894F-66D68DFC456C}";
enum const(wchar)* STR_GUID_TWISTORIENTATION = "{0D324960-13B2-41E4-ACE6-7AE9D43D2D3B}";

enum : const(wchar)*
{
    STR_GUID_PITCHROTATION           = "{7F7E57B7-BE37-4BE1-A356-7A84160E1893}",
    STR_GUID_ROLLROTATION            = "{5D5D5E56-6BA9-4C5B-9FB0-851C91714E56}",
    STR_GUID_YAWROTATION             = "{6A849980-7C3A-45B7-AA82-90A262950E89}",
    STR_GUID_WIDTH                   = "{BAABE94D-2712-48F5-BE9D-8F8B5EA0711A}",
    STR_GUID_HEIGHT                  = "{E61858D2-E447-4218-9D3F-18865C203DF4}",
    STR_GUID_FINGERCONTACTCONFIDENCE = "{E706C804-57F0-4F00-8A0C-853D57789BE9}",
}

enum const(wchar)* STR_GUID_DEVICE_CONTACT_ID = "{02585B91-049B-4750-9615-DF8948AB3C9C}";

enum : const(wchar)*
{
    INKRECOGNITIONPROPERTY_LINENUMBER         = "{DBF29F2C-5289-4BE8-B3D8-6EF63246253E}",
    INKRECOGNITIONPROPERTY_BOXNUMBER          = "{2C243E3A-F733-4EB6-B1F8-B5DC5C2C4CDA}",
    INKRECOGNITIONPROPERTY_SEGMENTATION       = "{B3C0FE6C-FB51-4164-BA2F-844AF8F983DA}",
    INKRECOGNITIONPROPERTY_HOTPOINT           = "{CA6F40DC-5292-452a-91FB-2181C0BEC0DE}",
    INKRECOGNITIONPROPERTY_MAXIMUMSTROKECOUNT = "{BF0EEC4E-4B7D-47a9-8CFA-234DD24BD22A}",
    INKRECOGNITIONPROPERTY_POINTSPERINCH      = "{7ED16B76-889C-468e-8276-0021B770187E}",
    INKRECOGNITIONPROPERTY_CONFIDENCELEVEL    = "{7DFE11A7-FB5D-4958-8765-154ADF0D833F}",
    INKRECOGNITIONPROPERTY_LINEMETRICS        = "{8CC24B27-30A9-4b96-9056-2D3A90DA0727}",
}

enum : const(wchar)*
{
    FACTOID_NONE             = "NONE",
    FACTOID_DEFAULT          = "DEFAULT",
    FACTOID_SYSTEMDICTIONARY = "SYSDICT",
}

enum : const(wchar)*
{
    FACTOID_WORDLIST     = "WORDLIST",
    FACTOID_EMAIL        = "EMAIL",
    FACTOID_WEB          = "WEB",
    FACTOID_ONECHAR      = "ONECHAR",
    FACTOID_NUMBER       = "NUMBER",
    FACTOID_DIGIT        = "DIGIT",
    FACTOID_NUMBERSIMPLE = "NUMSIMPLE",
}

enum : const(wchar)*
{
    FACTOID_CURRENCY       = "CURRENCY",
    FACTOID_POSTALCODE     = "POSTALCODE",
    FACTOID_PERCENT        = "PERCENT",
    FACTOID_DATE           = "DATE",
    FACTOID_TIME           = "TIME",
    FACTOID_TELEPHONE      = "TELEPHONE",
    FACTOID_FILENAME       = "FILENAME",
    FACTOID_UPPERCHAR      = "UPPERCHAR",
    FACTOID_LOWERCHAR      = "LOWERCHAR",
    FACTOID_PUNCCHAR       = "PUNCCHAR",
    FACTOID_JAPANESECOMMON = "JPN_COMMON",
}

enum : const(wchar)*
{
    FACTOID_CHINESESIMPLECOMMON      = "CHS_COMMON",
    FACTOID_CHINESETRADITIONALCOMMON = "CHT_COMMON",
}

enum const(wchar)* FACTOID_KOREANCOMMON = "KOR_COMMON";

enum : const(wchar)*
{
    FACTOID_HIRAGANA     = "HIRAGANA",
    FACTOID_KATAKANA     = "KATAKANA",
    FACTOID_KANJICOMMON  = "KANJI_COMMON",
    FACTOID_KANJIRARE    = "KANJI_RARE",
    FACTOID_BOPOMOFO     = "BOPOMOFO",
    FACTOID_JAMO         = "JAMO",
    FACTOID_HANGULCOMMON = "HANGUL_COMMON",
    FACTOID_HANGULRARE   = "HANGUL_RARE",
}

enum const(wchar)* MICROSOFT_PENINPUT_PANEL_PROPERTY_T = "Microsoft PenInputPanel 1.5";

enum : const(wchar)*
{
    INKEDIT_CLASSW = "INKEDIT",
    INKEDIT_CLASS  = "INKEDIT",
}

enum uint IEC__BASE = 0x00000600;
enum uint EM_GETINKMODE = 0x00000601;
enum uint EM_SETINKMODE = 0x00000602;
enum uint EM_GETINKINSERTMODE = 0x00000603;
enum uint EM_SETINKINSERTMODE = 0x00000604;
enum uint EM_GETDRAWATTR = 0x00000605;
enum uint EM_SETDRAWATTR = 0x00000606;
enum uint EM_GETRECOTIMEOUT = 0x00000607;
enum uint EM_SETRECOTIMEOUT = 0x00000608;
enum uint EM_GETGESTURESTATUS = 0x00000609;
enum uint EM_SETGESTURESTATUS = 0x0000060a;
enum uint EM_GETRECOGNIZER = 0x0000060b;
enum uint EM_SETRECOGNIZER = 0x0000060c;
enum uint EM_GETFACTOID = 0x0000060d;
enum uint EM_SETFACTOID = 0x0000060e;
enum uint EM_GETSELINK = 0x0000060f;
enum uint EM_SETSELINK = 0x00000610;
enum uint EM_GETMOUSEICON = 0x00000611;
enum uint EM_SETMOUSEICON = 0x00000612;
enum uint EM_GETMOUSEPOINTER = 0x00000613;
enum uint EM_SETMOUSEPOINTER = 0x00000614;
enum uint EM_GETSTATUS = 0x00000615;
enum uint EM_RECOGNIZE = 0x00000616;
enum uint EM_GETUSEMOUSEFORINPUT = 0x00000617;
enum uint EM_SETUSEMOUSEFORINPUT = 0x00000618;
enum uint EM_SETSELINKDISPLAYMODE = 0x00000619;
enum uint EM_GETSELINKDISPLAYMODE = 0x0000061a;

enum : uint
{
    IECN__BASE             = 0x00000800,
    IECN_STROKE            = 0x00000801,
    IECN_GESTURE           = 0x00000802,
    IECN_RECOGNITIONRESULT = 0x00000803,
}

enum : uint
{
    RECOFLAG_WORDMODE               = 0x00000001,
    RECOFLAG_COERCE                 = 0x00000002,
    RECOFLAG_SINGLESEG              = 0x00000004,
    RECOFLAG_PREFIXOK               = 0x00000008,
    RECOFLAG_LINEMODE               = 0x00000010,
    RECOFLAG_DISABLEPERSONALIZATION = 0x00000020,
}

enum uint RECOFLAG_AUTOSPACE = 0x00000040;
enum int RECOCONF_LOWCONFIDENCE = 0xffffffff;
enum uint RECOCONF_MEDIUMCONFIDENCE = 0x00000000;
enum uint RECOCONF_HIGHCONFIDENCE = 0x00000001;
enum uint RECOCONF_NOTSET = 0x00000080;

enum : uint
{
    GESTURE_NULL         = 0x0000f000,
    GESTURE_SCRATCHOUT   = 0x0000f001,
    GESTURE_TRIANGLE     = 0x0000f002,
    GESTURE_SQUARE       = 0x0000f003,
    GESTURE_STAR         = 0x0000f004,
    GESTURE_CHECK        = 0x0000f005,
    GESTURE_INFINITY     = 0x0000f006,
    GESTURE_CROSS        = 0x0000f007,
    GESTURE_PARAGRAPH    = 0x0000f008,
    GESTURE_SECTION      = 0x0000f009,
    GESTURE_BULLET       = 0x0000f00a,
    GESTURE_BULLET_CROSS = 0x0000f00b,
}

enum : uint
{
    GESTURE_SQUIGGLE        = 0x0000f00c,
    GESTURE_SWAP            = 0x0000f00d,
    GESTURE_OPENUP          = 0x0000f00e,
    GESTURE_CLOSEUP         = 0x0000f00f,
    GESTURE_CURLICUE        = 0x0000f010,
    GESTURE_DOUBLE_CURLICUE = 0x0000f011,
}

enum : uint
{
    GESTURE_RECTANGLE     = 0x0000f012,
    GESTURE_CIRCLE        = 0x0000f020,
    GESTURE_DOUBLE_CIRCLE = 0x0000f021,
}

enum : uint
{
    GESTURE_CIRCLE_TAP       = 0x0000f022,
    GESTURE_CIRCLE_CIRCLE    = 0x0000f023,
    GESTURE_CIRCLE_CROSS     = 0x0000f025,
    GESTURE_CIRCLE_LINE_VERT = 0x0000f026,
    GESTURE_CIRCLE_LINE_HORZ = 0x0000f027,
}

enum : uint
{
    GESTURE_SEMICIRCLE_LEFT  = 0x0000f028,
    GESTURE_SEMICIRCLE_RIGHT = 0x0000f029,
}

enum : uint
{
    GESTURE_CHEVRON_UP    = 0x0000f030,
    GESTURE_CHEVRON_DOWN  = 0x0000f031,
    GESTURE_CHEVRON_LEFT  = 0x0000f032,
    GESTURE_CHEVRON_RIGHT = 0x0000f033,
}

enum : uint
{
    GESTURE_ARROW_UP           = 0x0000f038,
    GESTURE_ARROW_DOWN         = 0x0000f039,
    GESTURE_ARROW_LEFT         = 0x0000f03a,
    GESTURE_ARROW_RIGHT        = 0x0000f03b,
    GESTURE_DOUBLE_ARROW_UP    = 0x0000f03c,
    GESTURE_DOUBLE_ARROW_DOWN  = 0x0000f03d,
    GESTURE_DOUBLE_ARROW_LEFT  = 0x0000f03e,
    GESTURE_DOUBLE_ARROW_RIGHT = 0x0000f03f,
}

enum : uint
{
    GESTURE_UP_ARROW_LEFT  = 0x0000f040,
    GESTURE_UP_ARROW_RIGHT = 0x0000f041,
}

enum : uint
{
    GESTURE_DOWN_ARROW_LEFT  = 0x0000f042,
    GESTURE_DOWN_ARROW_RIGHT = 0x0000f043,
}

enum : uint
{
    GESTURE_LEFT_ARROW_UP   = 0x0000f044,
    GESTURE_LEFT_ARROW_DOWN = 0x0000f045,
}

enum : uint
{
    GESTURE_RIGHT_ARROW_UP   = 0x0000f046,
    GESTURE_RIGHT_ARROW_DOWN = 0x0000f047,
}

enum : uint
{
    GESTURE_UP                 = 0x0000f058,
    GESTURE_DOWN               = 0x0000f059,
    GESTURE_LEFT               = 0x0000f05a,
    GESTURE_RIGHT              = 0x0000f05b,
    GESTURE_DIAGONAL_LEFTUP    = 0x0000f05c,
    GESTURE_DIAGONAL_RIGHTUP   = 0x0000f05d,
    GESTURE_DIAGONAL_LEFTDOWN  = 0x0000f05e,
    GESTURE_DIAGONAL_RIGHTDOWN = 0x0000f05f,
}

enum : uint
{
    GESTURE_UP_DOWN       = 0x0000f060,
    GESTURE_DOWN_UP       = 0x0000f061,
    GESTURE_LEFT_RIGHT    = 0x0000f062,
    GESTURE_RIGHT_LEFT    = 0x0000f063,
    GESTURE_UP_LEFT_LONG  = 0x0000f064,
    GESTURE_UP_RIGHT_LONG = 0x0000f065,
}

enum : uint
{
    GESTURE_DOWN_LEFT_LONG  = 0x0000f066,
    GESTURE_DOWN_RIGHT_LONG = 0x0000f067,
}

enum : uint
{
    GESTURE_UP_LEFT      = 0x0000f068,
    GESTURE_UP_RIGHT     = 0x0000f069,
    GESTURE_DOWN_LEFT    = 0x0000f06a,
    GESTURE_DOWN_RIGHT   = 0x0000f06b,
    GESTURE_LEFT_UP      = 0x0000f06c,
    GESTURE_LEFT_DOWN    = 0x0000f06d,
    GESTURE_RIGHT_UP     = 0x0000f06e,
    GESTURE_RIGHT_DOWN   = 0x0000f06f,
    GESTURE_LETTER_A     = 0x0000f080,
    GESTURE_LETTER_B     = 0x0000f081,
    GESTURE_LETTER_C     = 0x0000f082,
    GESTURE_LETTER_D     = 0x0000f083,
    GESTURE_LETTER_E     = 0x0000f084,
    GESTURE_LETTER_F     = 0x0000f085,
    GESTURE_LETTER_G     = 0x0000f086,
    GESTURE_LETTER_H     = 0x0000f087,
    GESTURE_LETTER_I     = 0x0000f088,
    GESTURE_LETTER_J     = 0x0000f089,
    GESTURE_LETTER_K     = 0x0000f08a,
    GESTURE_LETTER_L     = 0x0000f08b,
    GESTURE_LETTER_M     = 0x0000f08c,
    GESTURE_LETTER_N     = 0x0000f08d,
    GESTURE_LETTER_O     = 0x0000f08e,
    GESTURE_LETTER_P     = 0x0000f08f,
    GESTURE_LETTER_Q     = 0x0000f090,
    GESTURE_LETTER_R     = 0x0000f091,
    GESTURE_LETTER_S     = 0x0000f092,
    GESTURE_LETTER_T     = 0x0000f093,
    GESTURE_LETTER_U     = 0x0000f094,
    GESTURE_LETTER_V     = 0x0000f095,
    GESTURE_LETTER_W     = 0x0000f096,
    GESTURE_LETTER_X     = 0x0000f097,
    GESTURE_LETTER_Y     = 0x0000f098,
    GESTURE_LETTER_Z     = 0x0000f099,
    GESTURE_DIGIT_0      = 0x0000f09a,
    GESTURE_DIGIT_1      = 0x0000f09b,
    GESTURE_DIGIT_2      = 0x0000f09c,
    GESTURE_DIGIT_3      = 0x0000f09d,
    GESTURE_DIGIT_4      = 0x0000f09e,
    GESTURE_DIGIT_5      = 0x0000f09f,
    GESTURE_DIGIT_6      = 0x0000f0a0,
    GESTURE_DIGIT_7      = 0x0000f0a1,
    GESTURE_DIGIT_8      = 0x0000f0a2,
    GESTURE_DIGIT_9      = 0x0000f0a3,
    GESTURE_EXCLAMATION  = 0x0000f0a4,
    GESTURE_QUESTION     = 0x0000f0a5,
    GESTURE_SHARP        = 0x0000f0a6,
    GESTURE_DOLLAR       = 0x0000f0a7,
    GESTURE_ASTERISK     = 0x0000f0a8,
    GESTURE_PLUS         = 0x0000f0a9,
    GESTURE_DOUBLE_UP    = 0x0000f0b8,
    GESTURE_DOUBLE_DOWN  = 0x0000f0b9,
    GESTURE_DOUBLE_LEFT  = 0x0000f0ba,
    GESTURE_DOUBLE_RIGHT = 0x0000f0bb,
}

enum : uint
{
    GESTURE_TRIPLE_UP    = 0x0000f0bc,
    GESTURE_TRIPLE_DOWN  = 0x0000f0bd,
    GESTURE_TRIPLE_LEFT  = 0x0000f0be,
    GESTURE_TRIPLE_RIGHT = 0x0000f0bf,
}

enum : uint
{
    GESTURE_BRACKET_OVER  = 0x0000f0e4,
    GESTURE_BRACKET_UNDER = 0x0000f0e5,
    GESTURE_BRACKET_LEFT  = 0x0000f0e6,
    GESTURE_BRACKET_RIGHT = 0x0000f0e7,
    GESTURE_BRACE_OVER    = 0x0000f0e8,
    GESTURE_BRACE_UNDER   = 0x0000f0e9,
    GESTURE_BRACE_LEFT    = 0x0000f0ea,
    GESTURE_BRACE_RIGHT   = 0x0000f0eb,
    GESTURE_TAP           = 0x0000f0f0,
    GESTURE_DOUBLE_TAP    = 0x0000f0f1,
    GESTURE_TRIPLE_TAP    = 0x0000f0f2,
    GESTURE_QUAD_TAP      = 0x0000f0f3,
}

enum uint FACILITY_INK = 0x00000028;

enum : GUID
{
    GUID_PACKETPROPERTY_GUID_X                       = GUID("598a6a8f-52c0-4ba0-93af-af357411a561"),
    GUID_PACKETPROPERTY_GUID_Y                       = GUID("b53f9f75-04e0-4498-a7ee-c30dbb5a9011"),
    GUID_PACKETPROPERTY_GUID_Z                       = GUID("735adb30-0ebb-4788-a0e4-0f316490055d"),
    GUID_PACKETPROPERTY_GUID_PACKET_STATUS           = GUID("6e0e07bf-afe7-4cf7-87d1-af6446208418"),
    GUID_PACKETPROPERTY_GUID_TIMER_TICK              = GUID("436510c5-fed3-45d1-8b76-71d3ea7a829d"),
    GUID_PACKETPROPERTY_GUID_SERIAL_NUMBER           = GUID("78a81b56-0935-4493-baae-00541a8a16c4"),
    GUID_PACKETPROPERTY_GUID_NORMAL_PRESSURE         = GUID("7307502d-f9f4-4e18-b3f2-2ce1b1a3610c"),
    GUID_PACKETPROPERTY_GUID_TANGENT_PRESSURE        = GUID("6da4488b-5244-41ec-905b-32d89ab80809"),
    GUID_PACKETPROPERTY_GUID_BUTTON_PRESSURE         = GUID("8b7fefc4-96aa-4bfe-ac26-8a5f0be07bf5"),
    GUID_PACKETPROPERTY_GUID_X_TILT_ORIENTATION      = GUID("a8d07b3a-8bf0-40b0-95a9-b80a6bb787bf"),
    GUID_PACKETPROPERTY_GUID_Y_TILT_ORIENTATION      = GUID("0e932389-1d77-43af-ac00-5b950d6d4b2d"),
    GUID_PACKETPROPERTY_GUID_AZIMUTH_ORIENTATION     = GUID("029123b4-8828-410b-b250-a0536595e5dc"),
    GUID_PACKETPROPERTY_GUID_ALTITUDE_ORIENTATION    = GUID("82dec5c7-f6ba-4906-894f-66d68dfc456c"),
    GUID_PACKETPROPERTY_GUID_TWIST_ORIENTATION       = GUID("0d324960-13b2-41e4-ace6-7ae9d43d2d3b"),
    GUID_PACKETPROPERTY_GUID_PITCH_ROTATION          = GUID("7f7e57b7-be37-4be1-a356-7a84160e1893"),
    GUID_PACKETPROPERTY_GUID_ROLL_ROTATION           = GUID("5d5d5e56-6ba9-4c5b-9fb0-851c91714e56"),
    GUID_PACKETPROPERTY_GUID_YAW_ROTATION            = GUID("6a849980-7c3a-45b7-aa82-90a262950e89"),
    GUID_PACKETPROPERTY_GUID_WIDTH                   = GUID("baabe94d-2712-48f5-be9d-8f8b5ea0711a"),
    GUID_PACKETPROPERTY_GUID_HEIGHT                  = GUID("e61858d2-e447-4218-9d3f-18865c203df4"),
    GUID_PACKETPROPERTY_GUID_FINGERCONTACTCONFIDENCE = GUID("e706c804-57f0-4f00-8a0c-853d57789be9"),
    GUID_PACKETPROPERTY_GUID_DEVICE_CONTACT_ID       = GUID("02585b91-049b-4750-9615-df8948ab3c9c"),
}

enum int InkMinTransparencyValue = 0x00000000;
enum int InkMaxTransparencyValue = 0x000000ff;

enum : int
{
    InkCollectorClipInkToMargin = 0x00000000,
    InkCollectorDefaultMargin   = 0x80000000,
}

enum GUID GUID_GESTURE_DATA = GUID("41e4ec0f-26aa-455a-9aa5-2cd36cf63fb9");
enum GUID GUID_DYNAMIC_RENDERER_CACHED_DATA = GUID("bf531b92-25bf-4a95-89ad-0e476b34b4f5");

// Callbacks

alias PfnRecoCallback = HRESULT function(uint param0, ubyte* param1, HRECOCONTEXT param2);

// Structs


@RAIIFree!DestroyAlternate
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/tablet/hrecoalt-handle))], [])
struct HRECOALT
{
    void* Value;
}

@RAIIFree!DestroyContext
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/tablet/hrecocontext-handle))], [])
struct HRECOCONTEXT
{
    void* Value;
}

@RAIIFree!DestroyRecognizer
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/tablet/hrecognizer-handle))], [])
struct HRECOGNIZER
{
    void* Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HRECOLATTICE
{
    void* Value;
}

@RAIIFree!DestroyWordList
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/tablet/hrecowordlist-handle))], [])
struct HRECOWORDLIST
{
    void* Value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tpcshrd/ns-tpcshrd-system_event_data))], [])
struct SYSTEM_EVENT_DATA
{
    ubyte bModifier;
    wchar wKey;
    int   xPos;
    int   yPos;
    ubyte bCursorMode;
    uint  dwButtonState;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tpcshrd/ns-tpcshrd-stroke_range))], [])
struct STROKE_RANGE
{
    uint iStrokeBegin;
    uint iStrokeEnd;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tpcshrd/ns-tpcshrd-property_metrics))], [])
struct PROPERTY_METRICS
{
    int            nLogicalMin;
    int            nLogicalMax;
    PROPERTY_UNITS Units;
    float          fResolution;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tpcshrd/ns-tpcshrd-packet_property))], [])
struct PACKET_PROPERTY
{
    GUID             guid;
    PROPERTY_METRICS PropertyMetrics;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tpcshrd/ns-tpcshrd-packet_description))], [])
struct PACKET_DESCRIPTION
{
    uint             cbPacketSize;
    uint             cPacketProperties;
    PACKET_PROPERTY* pPacketProperties;
    uint             cButtons;
    GUID*            pguidButtons;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ns-msinkaut-inkmetric))], [])
struct INKMETRIC
{
    int      iHeight;
    int      iFontAscent;
    int      iFontDescent;
    uint     dwFlags;
    COLORREF color;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/ns-msinkaut-inkrecoguide))], [])
struct InkRecoGuide
{
    RECT rectWritingBox;
    RECT rectDrawnBox;
    int  cRows;
    int  cColumns;
    int  midline;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tabflicks/ns-tabflicks-flick_point))], [])
struct FLICK_POINT
{
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(y)), FixedArgSig(ElementSig(16)), FixedArgSig(ElementSig(16))], [])*/int _bitfield155;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tabflicks/ns-tabflicks-flick_data))], [])
struct FLICK_DATA
{
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(iActionArgument)), FixedArgSig(ElementSig(16)), FixedArgSig(ElementSig(16))], [])*/int _bitfield156;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/ns-inked-iec_strokeinfo))], [])
struct IEC_STROKEINFO
{
    NMHDR          nmhdr;
    IInkCursor     Cursor;
    IInkStrokeDisp Stroke;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/ns-inked-iec_gestureinfo))], [])
struct IEC_GESTUREINFO
{
    NMHDR       nmhdr;
    IInkCursor  Cursor;
    IInkStrokes Strokes;
    VARIANT     Gestures;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/ns-inked-iec_recognitionresultinfo))], [])
struct IEC_RECOGNITIONRESULTINFO
{
    NMHDR nmhdr;
    IInkRecognitionResult RecognitionResult;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/ns-rtscom-stylusinfo))], [])
struct StylusInfo
{
    uint tcid;
    uint cid;
    BOOL bIsInvertedCursor;
}

struct GESTURE_DATA
{
    int gestureId;
    int recoConfidence;
    int strokeCount;
}

struct DYNAMIC_RENDERER_CACHED_DATA
{
    int              strokeId;
    IDynamicRenderer dynamicRenderer;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rectypes/ns-rectypes-reco_guide))], [])
struct RECO_GUIDE
{
    int xOrigin;
    int yOrigin;
    int cxBox;
    int cyBox;
    int cxBase;
    int cyBase;
    int cHorzBox;
    int cVertBox;
    int cyMid;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rectypes/ns-rectypes-reco_attrs))], [])
struct RECO_ATTRS
{
    uint       dwRecoCapabilityFlags;
    wchar[32]  awcVendorName;
    wchar[64]  awcFriendlyName;
    ushort[64] awLanguageId;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rectypes/ns-rectypes-reco_range))], [])
struct RECO_RANGE
{
    uint iwcBegin;
    uint cCount;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rectypes/ns-rectypes-line_segment))], [])
struct LINE_SEGMENT
{
    POINT PtA;
    POINT PtB;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rectypes/ns-rectypes-lattice_metrics))], [])
struct LATTICE_METRICS
{
    LINE_SEGMENT lsBaseline;
    short        iMidlineOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rectypes/ns-rectypes-reco_lattice_property))], [])
struct RECO_LATTICE_PROPERTY
{
    GUID   guidProperty;
    ushort cbPropertyValue;
    ubyte* pPropertyValue;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rectypes/ns-rectypes-reco_lattice_properties))], [])
struct RECO_LATTICE_PROPERTIES
{
    uint cProperties;
    RECO_LATTICE_PROPERTY** apProps;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rectypes/ns-rectypes-reco_lattice_element))], [])
struct RECO_LATTICE_ELEMENT
{
    int    score;
    ushort type;
    ubyte* pData;
    uint   ulNextColumn;
    uint   ulStrokeNumber;
    RECO_LATTICE_PROPERTIES epProp;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rectypes/ns-rectypes-reco_lattice_column))], [])
struct RECO_LATTICE_COLUMN
{
    uint  key;
    RECO_LATTICE_PROPERTIES cpProp;
    uint  cStrokes;
    uint* pStrokes;
    uint  cLatticeElements;
    RECO_LATTICE_ELEMENT* pLatticeElements;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rectypes/ns-rectypes-reco_lattice))], [])
struct RECO_LATTICE
{
    uint                 ulColumnCount;
    RECO_LATTICE_COLUMN* pLatticeColumns;
    uint                 ulPropertyCount;
    GUID*                pGuidProperties;
    uint                 ulBestResultColumnCount;
    uint*                pulBestResultColumns;
    uint*                pulBestResultIndexes;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rectypes/ns-rectypes-character_range))], [])
struct CHARACTER_RANGE
{
    wchar  wcLow;
    ushort cChars;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT CreateRecognizer(GUID* pCLSID, HRECOGNIZER* phrec);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT DestroyRecognizer(HRECOGNIZER hrec);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT GetRecoAttributes(HRECOGNIZER hrec, RECO_ATTRS* pRecoAttrs);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT CreateContext(HRECOGNIZER hrec, HRECOCONTEXT* phrc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT DestroyContext(HRECOCONTEXT hrc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT GetResultPropertyList(HRECOGNIZER hrec, uint* pPropertyCount, GUID* pPropertyGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT GetPreferredPacketDescription(HRECOGNIZER hrec, PACKET_DESCRIPTION* pPacketDescription);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT GetUnicodeRanges(HRECOGNIZER hrec, uint* pcRanges, CHARACTER_RANGE* pcr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT AddStroke(HRECOCONTEXT hrc, const(PACKET_DESCRIPTION)* pPacketDesc, uint cbPacket, const(ubyte)* pPacket, 
                  const(XFORM)* pXForm);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT GetBestResultString(HRECOCONTEXT hrc, uint* pcSize, PWSTR pwcBestResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT DestroyAlternate(HRECOALT hrcalt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT SetGuide(HRECOCONTEXT hrc, const(RECO_GUIDE)* pGuide, uint iIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT GetGuide(HRECOCONTEXT hrc, RECO_GUIDE* pGuide, uint* piIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT AdviseInkChange(HRECOCONTEXT hrc, BOOL bNewStroke);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT SetCACMode(HRECOCONTEXT hrc, int iMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT EndInkInput(HRECOCONTEXT hrc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT CloneContext(HRECOCONTEXT hrc, HRECOCONTEXT* pCloneHrc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT ResetContext(HRECOCONTEXT hrc);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/recapis/nf-recapis-process))], [])
@DllImport("inkobjcore.dll")
HRESULT Process(HRECOCONTEXT hrc, BOOL* pbPartialProcessing);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT SetFactoid(HRECOCONTEXT hrc, uint cwcFactoid, const(PWSTR) pwcFactoid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT SetFlags(HRECOCONTEXT hrc, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT GetLatticePtr(HRECOCONTEXT hrc, RECO_LATTICE** ppLattice);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT SetTextContext(HRECOCONTEXT hrc, uint cwcBefore, const(PWSTR) pwcBefore, uint cwcAfter, 
                       const(PWSTR) pwcAfter);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT GetEnabledUnicodeRanges(HRECOCONTEXT hrc, uint* pcRanges, CHARACTER_RANGE* pcr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT SetEnabledUnicodeRanges(HRECOCONTEXT hrc, uint cRanges, CHARACTER_RANGE* pcr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT GetContextPropertyList(HRECOCONTEXT hrc, uint* pcProperties, GUID* pPropertyGUIDS);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT GetContextPropertyValue(HRECOCONTEXT hrc, GUID* pGuid, uint* pcbSize, ubyte* pProperty);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT SetContextPropertyValue(HRECOCONTEXT hrc, GUID* pGuid, uint cbSize, ubyte* pProperty);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT IsStringSupported(HRECOCONTEXT hrc, uint wcString, const(PWSTR) pwcString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT SetWordList(HRECOCONTEXT hrc, HRECOWORDLIST hwl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT GetContextPreferenceFlags(HRECOCONTEXT hrc, uint* pdwContextPreferenceFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT GetRightSeparator(HRECOCONTEXT hrc, uint* pcSize, PWSTR pwcRightSeparator);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT GetLeftSeparator(HRECOCONTEXT hrc, uint* pcSize, PWSTR pwcLeftSeparator);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT DestroyWordList(HRECOWORDLIST hwl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT AddWordsToWordList(HRECOWORDLIST hwl, PWSTR pwcWords);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT MakeWordList(HRECOGNIZER hrec, PWSTR pBuffer, HRECOWORDLIST* phwl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT GetAllRecognizers(GUID** recognizerClsids, uint* count);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("inkobjcore.dll")
HRESULT LoadCachedAttributes(GUID clsid, RECO_ATTRS* pRecoAttributes);


// Interfaces

@GUID("937c1a34-151d-4610-9ca6-a8cc9bdb5d83")
struct InkDisp;

@GUID("65d00646-cde3-4a88-9163-6769f0f1a97d")
struct InkOverlay;

@GUID("04a1e553-fe36-4fde-865e-344194e69424")
struct InkPicture;

@GUID("43fb1553-ad74-4ee8-88e4-3e6daac915db")
struct InkCollector;

@GUID("d8bf32a2-05a5-44c3-b3aa-5e80ac7d2576")
struct InkDrawingAttributes;

@GUID("43b07326-aae0-4b62-a83d-5fd768b7353c")
struct InkRectangle;

@GUID("9c1cc6e4-d7eb-4eeb-9091-15a7c8791ed9")
struct InkRenderer;

@GUID("e3d5d93c-1663-4a78-a1a7-22375dfebaee")
struct InkTransform;

@GUID("9fd4e808-f6e6-4e65-98d3-aa39054c1255")
struct InkRecognizers;

@GUID("aac46a37-9229-4fc0-8cce-4497569bf4d1")
struct InkRecognizerContext;

@GUID("8770d941-a63a-4671-a375-2855a18eba73")
struct InkRecognizerGuide;

@GUID("6e4fcb12-510a-4d40-9304-1da10ae9147c")
struct InkTablets;

@GUID("9de85094-f71f-44f1-8471-15a2fa76fcf3")
struct InkWordList;

@GUID("48f491bc-240e-4860-b079-a1e94d3d2c86")
struct InkStrokes;

@GUID("13de4a42-8d21-4c8e-bf9c-8f69cb068fca")
struct Ink;

@GUID("f0291081-e87c-4e07-97da-a0a03761e586")
struct SketchInk;

@GUID("8854f6a0-4683-4ae7-9191-752fe64612c3")
struct InkDivider;

@GUID("9f074ee2-e6e9-4d8a-a047-eb5b5c3c55da")
struct HandwrittenTextInsertion;

@GUID("f744e496-1b5a-489e-81dc-fbd7ac6298a8")
struct PenInputPanel;

@GUID("f9b189d7-228b-4f2b-8650-b97f59e02c8c")
struct TextInputPanel;

@GUID("802b1fb9-056b-4720-b0cc-80d23b71171e")
struct PenInputPanel_Internal;

@GUID("e5ca59f5-57c4-4dd8-9bd6-1deeedd27af4")
struct InkEdit;

@GUID("c561816c-14d8-4090-830c-98d994b21c7b")
struct MathInputControl;

@GUID("e26b366d-f998-43ce-836f-cb6d904432b0")
struct RealTimeStylus;

@GUID("ecd32aea-746f-4dcb-bf68-082757faff18")
struct DynamicRenderer;

@GUID("ea30c654-c62c-441f-ac00-95f9a196782c")
struct GestureRecognizer;

@GUID("e810cee7-6e51-4cb0-aa3a-0b985b70daf7")
struct StrokeBuilder;

@GUID("807c1e6c-1d00-453f-b920-b61bb7cdd997")
struct TipAutoCompleteClient;

@GUID("9794ff82-6071-4717-8a8b-6ac7c64a686e")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinkrectangle))], [])
interface IInkRectangle : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrectangle-get_top))], [])
    HRESULT get_Top(int* Units);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrectangle-put_top))], [])
    HRESULT put_Top(int Units);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrectangle-get_left))], [])
    HRESULT get_Left(int* Units);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrectangle-put_left))], [])
    HRESULT put_Left(int Units);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrectangle-get_bottom))], [])
    HRESULT get_Bottom(int* Units);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrectangle-put_bottom))], [])
    HRESULT put_Bottom(int Units);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrectangle-get_right))], [])
    HRESULT get_Right(int* Units);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrectangle-put_right))], [])
    HRESULT put_Right(int Units);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrectangle-get_data))], [])
    HRESULT get_Data(RECT* Rect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrectangle-put_data))], [])
    HRESULT put_Data(RECT Rect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrectangle-getrectangle))], [])
    HRESULT GetRectangle(int* Top, int* Left, int* Bottom, int* Right);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrectangle-setrectangle))], [])
    HRESULT SetRectangle(int Top, int Left, int Bottom, int Right);
}

@GUID("db489209-b7c3-411d-90f6-1548cfff271e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinkextendedproperty))], [])
interface IInkExtendedProperty : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkextendedproperty-get_guid))], [])
    HRESULT get_Guid(BSTR* Guid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkextendedproperty-get_data))], [])
    HRESULT get_Data(VARIANT* Data);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkextendedproperty-put_data))], [])
    HRESULT put_Data(VARIANT Data);
}

@GUID("89f2a8be-95a9-4530-8b8f-88e971e3e25f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinkextendedproperties))], [])
interface IInkExtendedProperties : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkextendedproperties-get_count))], [])
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkextendedproperties-item))], [])
    HRESULT Item(VARIANT Identifier, IInkExtendedProperty* Item);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkextendedproperties-add))], [])
    HRESULT Add(BSTR Guid, VARIANT Data, IInkExtendedProperty* InkExtendedProperty);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkextendedproperties-remove))], [])
    HRESULT Remove(VARIANT Identifier);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkextendedproperties-clear))], [])
    HRESULT Clear();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkextendedproperties-doespropertyexist))], [])
    HRESULT DoesPropertyExist(BSTR Guid, VARIANT_BOOL* DoesPropertyExist);
}

@GUID("bf519b75-0a15-4623-adc9-c00d436a8092")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinkdrawingattributes))], [])
interface IInkDrawingAttributes : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdrawingattributes-get_color))], [])
    HRESULT get_Color(int* CurrentColor);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdrawingattributes-put_color))], [])
    HRESULT put_Color(int NewColor);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdrawingattributes-get_width))], [])
    HRESULT get_Width(float* CurrentWidth);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdrawingattributes-put_width))], [])
    HRESULT put_Width(float NewWidth);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdrawingattributes-get_height))], [])
    HRESULT get_Height(float* CurrentHeight);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdrawingattributes-put_height))], [])
    HRESULT put_Height(float NewHeight);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdrawingattributes-get_fittocurve))], [])
    HRESULT get_FitToCurve(VARIANT_BOOL* Flag);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdrawingattributes-put_fittocurve))], [])
    HRESULT put_FitToCurve(VARIANT_BOOL Flag);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdrawingattributes-get_ignorepressure))], [])
    HRESULT get_IgnorePressure(VARIANT_BOOL* Flag);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdrawingattributes-put_ignorepressure))], [])
    HRESULT put_IgnorePressure(VARIANT_BOOL Flag);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdrawingattributes-get_antialiased))], [])
    HRESULT get_AntiAliased(VARIANT_BOOL* Flag);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdrawingattributes-put_antialiased))], [])
    HRESULT put_AntiAliased(VARIANT_BOOL Flag);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdrawingattributes-get_transparency))], [])
    HRESULT get_Transparency(int* CurrentTransparency);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdrawingattributes-put_transparency))], [])
    HRESULT put_Transparency(int NewTransparency);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdrawingattributes-get_rasteroperation))], [])
    HRESULT get_RasterOperation(InkRasterOperation* CurrentRasterOperation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdrawingattributes-put_rasteroperation))], [])
    HRESULT put_RasterOperation(InkRasterOperation NewRasterOperation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdrawingattributes-get_pentip))], [])
    HRESULT get_PenTip(InkPenTip* CurrentPenTip);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdrawingattributes-put_pentip))], [])
    HRESULT put_PenTip(InkPenTip NewPenTip);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdrawingattributes-get_extendedproperties))], [])
    HRESULT get_ExtendedProperties(IInkExtendedProperties* Properties);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdrawingattributes-clone))], [])
    HRESULT Clone(IInkDrawingAttributes* DrawingAttributes);
}

@GUID("615f1d43-8703-4565-88e2-8201d2ecd7b7")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinktransform))], [])
interface IInkTransform : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktransform-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktransform-translate))], [])
    HRESULT Translate(float HorizontalComponent, float VerticalComponent);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktransform-rotate))], [])
    HRESULT Rotate(float Degrees, float x, float y);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktransform-reflect))], [])
    HRESULT Reflect(VARIANT_BOOL Horizontally, VARIANT_BOOL Vertically);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktransform-shear))], [])
    HRESULT Shear(float HorizontalComponent, float VerticalComponent);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktransform-scaletransform))], [])
    HRESULT ScaleTransform(float HorizontalMultiplier, float VerticalMultiplier);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktransform-gettransform))], [])
    HRESULT GetTransform(float* eM11, float* eM12, float* eM21, float* eM22, float* eDx, float* eDy);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktransform-settransform))], [])
    HRESULT SetTransform(float eM11, float eM12, float eM21, float eM22, float eDx, float eDy);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktransform-get_em11))], [])
    HRESULT get_eM11(float* Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktransform-put_em11))], [])
    HRESULT put_eM11(float Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktransform-get_em12))], [])
    HRESULT get_eM12(float* Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktransform-put_em12))], [])
    HRESULT put_eM12(float Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktransform-get_em21))], [])
    HRESULT get_eM21(float* Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktransform-put_em21))], [])
    HRESULT put_eM21(float Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktransform-get_em22))], [])
    HRESULT get_eM22(float* Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktransform-put_em22))], [])
    HRESULT put_eM22(float Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktransform-get_edx))], [])
    HRESULT get_eDx(float* Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktransform-put_edx))], [])
    HRESULT put_eDx(float Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktransform-get_edy))], [])
    HRESULT get_eDy(float* Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktransform-put_edy))], [])
    HRESULT put_eDy(float Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktransform-get_data))], [])
    HRESULT get_Data(XFORM* XForm);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktransform-put_data))], [])
    HRESULT put_Data(XFORM XForm);
}

@GUID("3bdc0a97-04e5-4e26-b813-18f052d41def")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinkgesture))], [])
interface IInkGesture : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkgesture-get_confidence))], [])
    HRESULT get_Confidence(InkRecognitionConfidence* Confidence);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkgesture-get_id))], [])
    HRESULT get_Id(InkApplicationGesture* Id);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkgesture-gethotpoint))], [])
    HRESULT GetHotPoint(int* X, int* Y);
}

@GUID("ad30c630-40c5-4350-8405-9c71012fc558")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinkcursor))], [])
interface IInkCursor : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcursor-get_name))], [])
    HRESULT get_Name(BSTR* Name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcursor-get_id))], [])
    HRESULT get_Id(int* Id);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcursor-get_inverted))], [])
    HRESULT get_Inverted(VARIANT_BOOL* Status);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcursor-get_drawingattributes))], [])
    HRESULT get_DrawingAttributes(IInkDrawingAttributes* Attributes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcursor-putref_drawingattributes))], [])
    HRESULT putref_DrawingAttributes(IInkDrawingAttributes Attributes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcursor-get_tablet))], [])
    HRESULT get_Tablet(IInkTablet* Tablet);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcursor-get_buttons))], [])
    HRESULT get_Buttons(IInkCursorButtons* Buttons);
}

@GUID("a248c1ac-c698-4e06-9e5c-d57f77c7e647")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinkcursors))], [])
interface IInkCursors : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcursors-get_count))], [])
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcursors-item))], [])
    HRESULT Item(int Index, IInkCursor* Cursor);
}

@GUID("85ef9417-1d59-49b2-a13c-702c85430894")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinkcursorbutton))], [])
interface IInkCursorButton : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcursorbutton-get_name))], [])
    HRESULT get_Name(BSTR* Name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcursorbutton-get_id))], [])
    HRESULT get_Id(BSTR* Id);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcursorbutton-get_state))], [])
    HRESULT get_State(InkCursorButtonState* CurrentState);
}

@GUID("3671cc40-b624-4671-9fa0-db119d952d54")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinkcursorbuttons))], [])
interface IInkCursorButtons : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcursorbuttons-get_count))], [])
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcursorbuttons-item))], [])
    HRESULT Item(VARIANT Identifier, IInkCursorButton* Button);
}

@GUID("2de25eaa-6ef8-42d5-aee9-185bc81b912d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinktablet))], [])
interface IInkTablet : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktablet-get_name))], [])
    HRESULT get_Name(BSTR* Name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktablet-get_plugandplayid))], [])
    HRESULT get_PlugAndPlayId(BSTR* Id);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktablet-get_maximuminputrectangle))], [])
    HRESULT get_MaximumInputRectangle(IInkRectangle* Rectangle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktablet-get_hardwarecapabilities))], [])
    HRESULT get_HardwareCapabilities(TabletHardwareCapabilities* Capabilities);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktablet-ispacketpropertysupported))], [])
    HRESULT IsPacketPropertySupported(BSTR packetPropertyName, VARIANT_BOOL* Supported);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktablet-getpropertymetrics))], [])
    HRESULT GetPropertyMetrics(BSTR propertyName, int* Minimum, int* Maximum, TabletPropertyMetricUnit* Units, 
                               float* Resolution);
}

@GUID("90c91ad2-fa36-49d6-9516-ce8d570f6f85")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinktablet2))], [])
interface IInkTablet2 : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktablet2-get_devicekind))], [])
    HRESULT get_DeviceKind(TabletDeviceKind* Kind);
}

@GUID("7e313997-1327-41dd-8ca9-79f24be17250")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinktablet3))], [])
interface IInkTablet3 : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktablet3-get_ismultitouch))], [])
    HRESULT get_IsMultiTouch(VARIANT_BOOL* pIsMultiTouch);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktablet3-get_maximumcursors))], [])
    HRESULT get_MaximumCursors(uint* pMaximumCursors);
}

@GUID("112086d9-7779-4535-a699-862b43ac1863")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinktablets))], [])
interface IInkTablets : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktablets-get_count))], [])
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktablets-get_defaulttablet))], [])
    HRESULT get_DefaultTablet(IInkTablet* DefaultTablet);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktablets-item))], [])
    HRESULT Item(int Index, IInkTablet* Tablet);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinktablets-ispacketpropertysupported))], [])
    HRESULT IsPacketPropertySupported(BSTR packetPropertyName, VARIANT_BOOL* Supported);
}

@GUID("43242fea-91d1-4a72-963e-fbb91829cfa2")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinkstrokedisp))], [])
interface IInkStrokeDisp : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-get_id))], [])
    HRESULT get_ID(int* ID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-get_bezierpoints))], [])
    HRESULT get_BezierPoints(VARIANT* Points);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-get_drawingattributes))], [])
    HRESULT get_DrawingAttributes(IInkDrawingAttributes* DrawAttrs);
    HRESULT putref_DrawingAttributes(IInkDrawingAttributes DrawAttrs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-get_ink))], [])
    HRESULT get_Ink(IInkDisp* Ink);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-get_extendedproperties))], [])
    HRESULT get_ExtendedProperties(IInkExtendedProperties* Properties);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-get_polylinecusps))], [])
    HRESULT get_PolylineCusps(VARIANT* Cusps);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-get_beziercusps))], [])
    HRESULT get_BezierCusps(VARIANT* Cusps);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-get_selfintersections))], [])
    HRESULT get_SelfIntersections(VARIANT* Intersections);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-get_packetcount))], [])
    HRESULT get_PacketCount(int* plCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-get_packetsize))], [])
    HRESULT get_PacketSize(int* plSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-get_packetdescription))], [])
    HRESULT get_PacketDescription(VARIANT* PacketDescription);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-get_deleted))], [])
    HRESULT get_Deleted(VARIANT_BOOL* Deleted);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-getboundingbox))], [])
    HRESULT GetBoundingBox(InkBoundingBoxMode BoundingBoxMode, IInkRectangle* Rectangle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-findintersections))], [])
    HRESULT FindIntersections(IInkStrokes Strokes, VARIANT* Intersections);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-getrectangleintersections))], [])
    HRESULT GetRectangleIntersections(IInkRectangle Rectangle, VARIANT* Intersections);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-clip))], [])
    HRESULT Clip(IInkRectangle Rectangle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-hittestcircle))], [])
    HRESULT HitTestCircle(int X, int Y, float Radius, VARIANT_BOOL* Intersects);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-nearestpoint))], [])
    HRESULT NearestPoint(int X, int Y, float* Distance, float* Point);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-split))], [])
    HRESULT Split(float SplitAt, IInkStrokeDisp* NewStroke);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-getpacketdescriptionpropertymetrics))], [])
    HRESULT GetPacketDescriptionPropertyMetrics(BSTR PropertyName, int* Minimum, int* Maximum, 
                                                TabletPropertyMetricUnit* Units, float* Resolution);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-getpoints))], [])
    HRESULT GetPoints(int Index, int Count, VARIANT* Points);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-setpoints))], [])
    HRESULT SetPoints(VARIANT Points, int Index, int Count, int* NumberOfPointsSet);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-getpacketdata))], [])
    HRESULT GetPacketData(int Index, int Count, VARIANT* PacketData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-getpacketvaluesbyproperty))], [])
    HRESULT GetPacketValuesByProperty(BSTR PropertyName, int Index, int Count, VARIANT* PacketValues);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-setpacketvaluesbyproperty))], [])
    HRESULT SetPacketValuesByProperty(BSTR bstrPropertyName, VARIANT PacketValues, int Index, int Count, 
                                      int* NumberOfPacketsSet);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-getflattenedbezierpoints))], [])
    HRESULT GetFlattenedBezierPoints(int FittingError, VARIANT* FlattenedBezierPoints);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-transform))], [])
    HRESULT Transform(IInkTransform Transform, VARIANT_BOOL ApplyOnPenWidth);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-scaletorectangle))], [])
    HRESULT ScaleToRectangle(IInkRectangle Rectangle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-move))], [])
    HRESULT Move(float HorizontalComponent, float VerticalComponent);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-rotate))], [])
    HRESULT Rotate(float Degrees, float x, float y);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-shear))], [])
    HRESULT Shear(float HorizontalMultiplier, float VerticalMultiplier);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokedisp-scaletransform))], [])
    HRESULT ScaleTransform(float HorizontalMultiplier, float VerticalMultiplier);
}

@GUID("f1f4c9d8-590a-4963-b3ae-1935671bb6f3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinkstrokes))], [])
interface IInkStrokes : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokes-get_count))], [])
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokes-get_ink))], [])
    HRESULT get_Ink(IInkDisp* Ink);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokes-get_recognitionresult))], [])
    HRESULT get_RecognitionResult(IInkRecognitionResult* RecognitionResult);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokes-tostring))], [])
    HRESULT ToString(BSTR* ToString);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokes-item))], [])
    HRESULT Item(int Index, IInkStrokeDisp* Stroke);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokes-add))], [])
    HRESULT Add(IInkStrokeDisp InkStroke);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokes-addstrokes))], [])
    HRESULT AddStrokes(IInkStrokes InkStrokes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokes-remove))], [])
    HRESULT Remove(IInkStrokeDisp InkStroke);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokes-removestrokes))], [])
    HRESULT RemoveStrokes(IInkStrokes InkStrokes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokes-modifydrawingattributes))], [])
    HRESULT ModifyDrawingAttributes(IInkDrawingAttributes DrawAttrs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokes-getboundingbox))], [])
    HRESULT GetBoundingBox(InkBoundingBoxMode BoundingBoxMode, IInkRectangle* BoundingBox);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokes-transform))], [])
    HRESULT Transform(IInkTransform Transform, VARIANT_BOOL ApplyOnPenWidth);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokes-scaletorectangle))], [])
    HRESULT ScaleToRectangle(IInkRectangle Rectangle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokes-move))], [])
    HRESULT Move(float HorizontalComponent, float VerticalComponent);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokes-rotate))], [])
    HRESULT Rotate(float Degrees, float x, float y);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokes-shear))], [])
    HRESULT Shear(float HorizontalMultiplier, float VerticalMultiplier);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokes-scaletransform))], [])
    HRESULT ScaleTransform(float HorizontalMultiplier, float VerticalMultiplier);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokes-clip))], [])
    HRESULT Clip(IInkRectangle Rectangle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkstrokes-removerecognitionresult))], [])
    HRESULT RemoveRecognitionResult();
}

@GUID("7e23a88f-c30e-420f-9bdb-28902543f0c1")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinkcustomstrokes))], [])
interface IInkCustomStrokes : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcustomstrokes-get_count))], [])
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcustomstrokes-item))], [])
    HRESULT Item(VARIANT Identifier, IInkStrokes* Strokes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcustomstrokes-add))], [])
    HRESULT Add(BSTR Name, IInkStrokes Strokes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcustomstrokes-remove))], [])
    HRESULT Remove(VARIANT Identifier);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcustomstrokes-clear))], [])
    HRESULT Clear();
}

@GUID("f33053ec-5d25-430a-928f-76a6491dde15")
interface _IInkStrokesEvents : IDispatch
{
}

@GUID("9d398fa0-c4e2-4fcd-9973-975caaf47ea6")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinkdisp))], [])
interface IInkDisp : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdisp-get_strokes))], [])
    HRESULT get_Strokes(IInkStrokes* Strokes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdisp-get_extendedproperties))], [])
    HRESULT get_ExtendedProperties(IInkExtendedProperties* Properties);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdisp-get_dirty))], [])
    HRESULT get_Dirty(VARIANT_BOOL* Dirty);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdisp-put_dirty))], [])
    HRESULT put_Dirty(VARIANT_BOOL Dirty);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdisp-get_customstrokes))], [])
    HRESULT get_CustomStrokes(IInkCustomStrokes* ppunkInkCustomStrokes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdisp-getboundingbox))], [])
    HRESULT GetBoundingBox(InkBoundingBoxMode BoundingBoxMode, IInkRectangle* Rectangle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdisp-deletestrokes))], [])
    HRESULT DeleteStrokes(IInkStrokes Strokes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdisp-deletestroke))], [])
    HRESULT DeleteStroke(IInkStrokeDisp Stroke);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdisp-extractstrokes))], [])
    HRESULT ExtractStrokes(IInkStrokes Strokes, InkExtractFlags ExtractFlags, IInkDisp* ExtractedInk);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdisp-extractwithrectangle))], [])
    HRESULT ExtractWithRectangle(IInkRectangle Rectangle, InkExtractFlags extractFlags, IInkDisp* ExtractedInk);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdisp-clip))], [])
    HRESULT Clip(IInkRectangle Rectangle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdisp-clone))], [])
    HRESULT Clone(IInkDisp* NewInk);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdisp-hittestcircle))], [])
    HRESULT HitTestCircle(int X, int Y, float radius, IInkStrokes* Strokes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdisp-hittestwithrectangle))], [])
    HRESULT HitTestWithRectangle(IInkRectangle SelectionRectangle, float IntersectPercent, IInkStrokes* Strokes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdisp-hittestwithlasso))], [])
    HRESULT HitTestWithLasso(VARIANT Points, float IntersectPercent, VARIANT* LassoPoints, IInkStrokes* Strokes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdisp-nearestpoint))], [])
    HRESULT NearestPoint(int X, int Y, float* PointOnStroke, float* DistanceFromPacket, IInkStrokeDisp* Stroke);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdisp-createstrokes))], [])
    HRESULT CreateStrokes(VARIANT StrokeIds, IInkStrokes* Strokes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdisp-addstrokesatrectangle))], [])
    HRESULT AddStrokesAtRectangle(IInkStrokes SourceStrokes, IInkRectangle TargetRectangle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdisp-save))], [])
    HRESULT Save(InkPersistenceFormat PersistenceFormat, InkPersistenceCompressionMode CompressionMode, 
                 VARIANT* Data);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdisp-load))], [])
    HRESULT Load(VARIANT Data);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdisp-createstroke))], [])
    HRESULT CreateStroke(VARIANT PacketData, VARIANT PacketDescription, IInkStrokeDisp* Stroke);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdisp-clipboardcopywithrectangle))], [])
    HRESULT ClipboardCopyWithRectangle(IInkRectangle Rectangle, InkClipboardFormats ClipboardFormats, 
                                       InkClipboardModes ClipboardModes, IDataObject* DataObject);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdisp-clipboardcopy))], [])
    HRESULT ClipboardCopy(IInkStrokes strokes, InkClipboardFormats ClipboardFormats, 
                          InkClipboardModes ClipboardModes, IDataObject* DataObject);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdisp-canpaste))], [])
    HRESULT CanPaste(IDataObject DataObject, VARIANT_BOOL* CanPaste);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkdisp-clipboardpaste))], [])
    HRESULT ClipboardPaste(int x, int y, IDataObject DataObject, IInkStrokes* Strokes);
}

@GUID("427b1865-ca3f-479a-83a9-0f420f2a0073")
interface _IInkEvents : IDispatch
{
}

@GUID("e6257a9c-b511-4f4c-a8b0-a7dbc9506b83")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinkrenderer))], [])
interface IInkRenderer : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrenderer-getviewtransform))], [])
    HRESULT GetViewTransform(IInkTransform ViewTransform);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrenderer-setviewtransform))], [])
    HRESULT SetViewTransform(IInkTransform ViewTransform);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrenderer-getobjecttransform))], [])
    HRESULT GetObjectTransform(IInkTransform ObjectTransform);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrenderer-setobjecttransform))], [])
    HRESULT SetObjectTransform(IInkTransform ObjectTransform);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrenderer-draw))], [])
    HRESULT Draw(ptrdiff_t hDC, IInkStrokes Strokes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrenderer-drawstroke))], [])
    HRESULT DrawStroke(ptrdiff_t hDC, IInkStrokeDisp Stroke, IInkDrawingAttributes DrawingAttributes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrenderer-pixeltoinkspace))], [])
    HRESULT PixelToInkSpace(ptrdiff_t hDC, int* x, int* y);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrenderer-inkspacetopixel))], [])
    HRESULT InkSpaceToPixel(ptrdiff_t hdcDisplay, int* x, int* y);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrenderer-pixeltoinkspacefrompoints))], [])
    HRESULT PixelToInkSpaceFromPoints(ptrdiff_t hDC, VARIANT* Points);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrenderer-inkspacetopixelfrompoints))], [])
    HRESULT InkSpaceToPixelFromPoints(ptrdiff_t hDC, VARIANT* Points);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrenderer-measure))], [])
    HRESULT Measure(IInkStrokes Strokes, IInkRectangle* Rectangle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrenderer-measurestroke))], [])
    HRESULT MeasureStroke(IInkStrokeDisp Stroke, IInkDrawingAttributes DrawingAttributes, IInkRectangle* Rectangle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrenderer-move))], [])
    HRESULT Move(float HorizontalComponent, float VerticalComponent);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrenderer-rotate))], [])
    HRESULT Rotate(float Degrees, float x, float y);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrenderer-scaletransform))], [])
    HRESULT ScaleTransform(float HorizontalMultiplier, float VerticalMultiplier, VARIANT_BOOL ApplyOnPenWidth);
}

@GUID("f0f060b5-8b1f-4a7c-89ec-880692588a4f")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinkcollector))], [])
interface IInkCollector : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-get_hwnd))], [])
    HRESULT get_hWnd(ptrdiff_t* CurrentWindow);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-put_hwnd))], [])
    HRESULT put_hWnd(ptrdiff_t NewWindow);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-get_enabled))], [])
    HRESULT get_Enabled(VARIANT_BOOL* Collecting);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-put_enabled))], [])
    HRESULT put_Enabled(VARIANT_BOOL Collecting);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-get_defaultdrawingattributes))], [])
    HRESULT get_DefaultDrawingAttributes(IInkDrawingAttributes* CurrentAttributes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-putref_defaultdrawingattributes))], [])
    HRESULT putref_DefaultDrawingAttributes(IInkDrawingAttributes NewAttributes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-get_renderer))], [])
    HRESULT get_Renderer(IInkRenderer* CurrentInkRenderer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-putref_renderer))], [])
    HRESULT putref_Renderer(IInkRenderer NewInkRenderer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-get_ink))], [])
    HRESULT get_Ink(IInkDisp* Ink);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-putref_ink))], [])
    HRESULT putref_Ink(IInkDisp NewInk);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-get_autoredraw))], [])
    HRESULT get_AutoRedraw(VARIANT_BOOL* AutoRedraw);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-put_autoredraw))], [])
    HRESULT put_AutoRedraw(VARIANT_BOOL AutoRedraw);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-get_collectingink))], [])
    HRESULT get_CollectingInk(VARIANT_BOOL* Collecting);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-get_collectionmode))], [])
    HRESULT get_CollectionMode(InkCollectionMode* Mode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-put_collectionmode))], [])
    HRESULT put_CollectionMode(InkCollectionMode Mode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-get_dynamicrendering))], [])
    HRESULT get_DynamicRendering(VARIANT_BOOL* Enabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-put_dynamicrendering))], [])
    HRESULT put_DynamicRendering(VARIANT_BOOL Enabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-get_desiredpacketdescription))], [])
    HRESULT get_DesiredPacketDescription(VARIANT* PacketGuids);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-put_desiredpacketdescription))], [])
    HRESULT put_DesiredPacketDescription(VARIANT PacketGuids);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-get_mouseicon))], [])
    HRESULT get_MouseIcon(IPictureDisp* MouseIcon);
    HRESULT put_MouseIcon(IPictureDisp MouseIcon);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-putref_mouseicon))], [])
    HRESULT putref_MouseIcon(IPictureDisp MouseIcon);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-get_mousepointer))], [])
    HRESULT get_MousePointer(InkMousePointer* MousePointer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-put_mousepointer))], [])
    HRESULT put_MousePointer(InkMousePointer MousePointer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-get_cursors))], [])
    HRESULT get_Cursors(IInkCursors* Cursors);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-get_marginx))], [])
    HRESULT get_MarginX(int* MarginX);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-put_marginx))], [])
    HRESULT put_MarginX(int MarginX);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-get_marginy))], [])
    HRESULT get_MarginY(int* MarginY);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-put_marginy))], [])
    HRESULT put_MarginY(int MarginY);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-get_tablet))], [])
    HRESULT get_Tablet(IInkTablet* SingleTablet);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-get_supporthighcontrastink))], [])
    HRESULT get_SupportHighContrastInk(VARIANT_BOOL* Support);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-put_supporthighcontrastink))], [])
    HRESULT put_SupportHighContrastInk(VARIANT_BOOL Support);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-setgesturestatus))], [])
    HRESULT SetGestureStatus(InkApplicationGesture Gesture, VARIANT_BOOL Listen);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-getgesturestatus))], [])
    HRESULT GetGestureStatus(InkApplicationGesture Gesture, VARIANT_BOOL* Listening);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-getwindowinputrectangle))], [])
    HRESULT GetWindowInputRectangle(IInkRectangle* WindowInputRectangle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-setwindowinputrectangle))], [])
    HRESULT SetWindowInputRectangle(IInkRectangle WindowInputRectangle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-setalltabletsmode))], [])
    HRESULT SetAllTabletsMode(VARIANT_BOOL UseMouseForInput);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-setsingletabletintegratedmode))], [])
    HRESULT SetSingleTabletIntegratedMode(IInkTablet Tablet);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-geteventinterest))], [])
    HRESULT GetEventInterest(InkCollectorEventInterest EventId, VARIANT_BOOL* Listen);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkcollector-seteventinterest))], [])
    HRESULT SetEventInterest(InkCollectorEventInterest EventId, VARIANT_BOOL Listen);
}

@GUID("11a583f2-712d-4fea-abcf-ab4af38ea06b")
interface _IInkCollectorEvents : IDispatch
{
}

@GUID("b82a463b-c1c5-45a3-997c-deab5651b67a")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinkoverlay))], [])
interface IInkOverlay : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-get_hwnd))], [])
    HRESULT get_hWnd(ptrdiff_t* CurrentWindow);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-put_hwnd))], [])
    HRESULT put_hWnd(ptrdiff_t NewWindow);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-get_enabled))], [])
    HRESULT get_Enabled(VARIANT_BOOL* Collecting);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-put_enabled))], [])
    HRESULT put_Enabled(VARIANT_BOOL Collecting);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-get_defaultdrawingattributes))], [])
    HRESULT get_DefaultDrawingAttributes(IInkDrawingAttributes* CurrentAttributes);
    HRESULT putref_DefaultDrawingAttributes(IInkDrawingAttributes NewAttributes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-get_renderer))], [])
    HRESULT get_Renderer(IInkRenderer* CurrentInkRenderer);
    HRESULT putref_Renderer(IInkRenderer NewInkRenderer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-get_ink))], [])
    HRESULT get_Ink(IInkDisp* Ink);
    HRESULT putref_Ink(IInkDisp NewInk);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-get_autoredraw))], [])
    HRESULT get_AutoRedraw(VARIANT_BOOL* AutoRedraw);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-put_autoredraw))], [])
    HRESULT put_AutoRedraw(VARIANT_BOOL AutoRedraw);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-get_collectingink))], [])
    HRESULT get_CollectingInk(VARIANT_BOOL* Collecting);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-get_collectionmode))], [])
    HRESULT get_CollectionMode(InkCollectionMode* Mode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-put_collectionmode))], [])
    HRESULT put_CollectionMode(InkCollectionMode Mode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-get_dynamicrendering))], [])
    HRESULT get_DynamicRendering(VARIANT_BOOL* Enabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-put_dynamicrendering))], [])
    HRESULT put_DynamicRendering(VARIANT_BOOL Enabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-get_desiredpacketdescription))], [])
    HRESULT get_DesiredPacketDescription(VARIANT* PacketGuids);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-put_desiredpacketdescription))], [])
    HRESULT put_DesiredPacketDescription(VARIANT PacketGuids);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-get_mouseicon))], [])
    HRESULT get_MouseIcon(IPictureDisp* MouseIcon);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-put_mouseicon))], [])
    HRESULT put_MouseIcon(IPictureDisp MouseIcon);
    HRESULT putref_MouseIcon(IPictureDisp MouseIcon);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-get_mousepointer))], [])
    HRESULT get_MousePointer(InkMousePointer* MousePointer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-put_mousepointer))], [])
    HRESULT put_MousePointer(InkMousePointer MousePointer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-get_editingmode))], [])
    HRESULT get_EditingMode(InkOverlayEditingMode* EditingMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-put_editingmode))], [])
    HRESULT put_EditingMode(InkOverlayEditingMode EditingMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-get_selection))], [])
    HRESULT get_Selection(IInkStrokes* Selection);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-put_selection))], [])
    HRESULT put_Selection(IInkStrokes Selection);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-get_erasermode))], [])
    HRESULT get_EraserMode(InkOverlayEraserMode* EraserMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-put_erasermode))], [])
    HRESULT put_EraserMode(InkOverlayEraserMode EraserMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-get_eraserwidth))], [])
    HRESULT get_EraserWidth(int* EraserWidth);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-put_eraserwidth))], [])
    HRESULT put_EraserWidth(int newEraserWidth);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-get_attachmode))], [])
    HRESULT get_AttachMode(InkOverlayAttachMode* AttachMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-put_attachmode))], [])
    HRESULT put_AttachMode(InkOverlayAttachMode AttachMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-get_cursors))], [])
    HRESULT get_Cursors(IInkCursors* Cursors);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-get_marginx))], [])
    HRESULT get_MarginX(int* MarginX);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-put_marginx))], [])
    HRESULT put_MarginX(int MarginX);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-get_marginy))], [])
    HRESULT get_MarginY(int* MarginY);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-put_marginy))], [])
    HRESULT put_MarginY(int MarginY);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-get_tablet))], [])
    HRESULT get_Tablet(IInkTablet* SingleTablet);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-get_supporthighcontrastink))], [])
    HRESULT get_SupportHighContrastInk(VARIANT_BOOL* Support);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-put_supporthighcontrastink))], [])
    HRESULT put_SupportHighContrastInk(VARIANT_BOOL Support);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-get_supporthighcontrastselectionui))], [])
    HRESULT get_SupportHighContrastSelectionUI(VARIANT_BOOL* Support);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-put_supporthighcontrastselectionui))], [])
    HRESULT put_SupportHighContrastSelectionUI(VARIANT_BOOL Support);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-hittestselection))], [])
    HRESULT HitTestSelection(int x, int y, SelectionHitResult* SelArea);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-draw))], [])
    HRESULT Draw(IInkRectangle Rect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-setgesturestatus))], [])
    HRESULT SetGestureStatus(InkApplicationGesture Gesture, VARIANT_BOOL Listen);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-getgesturestatus))], [])
    HRESULT GetGestureStatus(InkApplicationGesture Gesture, VARIANT_BOOL* Listening);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-getwindowinputrectangle))], [])
    HRESULT GetWindowInputRectangle(IInkRectangle* WindowInputRectangle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-setwindowinputrectangle))], [])
    HRESULT SetWindowInputRectangle(IInkRectangle WindowInputRectangle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-setalltabletsmode))], [])
    HRESULT SetAllTabletsMode(VARIANT_BOOL UseMouseForInput);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-setsingletabletintegratedmode))], [])
    HRESULT SetSingleTabletIntegratedMode(IInkTablet Tablet);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-geteventinterest))], [])
    HRESULT GetEventInterest(InkCollectorEventInterest EventId, VARIANT_BOOL* Listen);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkoverlay-seteventinterest))], [])
    HRESULT SetEventInterest(InkCollectorEventInterest EventId, VARIANT_BOOL Listen);
}

@GUID("31179b69-e563-489e-b16f-712f1e8a0651")
interface _IInkOverlayEvents : IDispatch
{
}

@GUID("e85662e0-379a-40d7-9b5c-757d233f9923")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinkpicture))], [])
interface IInkPicture : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-get_hwnd))], [])
    HRESULT get_hWnd(ptrdiff_t* CurrentWindow);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-get_defaultdrawingattributes))], [])
    HRESULT get_DefaultDrawingAttributes(IInkDrawingAttributes* CurrentAttributes);
    HRESULT putref_DefaultDrawingAttributes(IInkDrawingAttributes NewAttributes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-get_renderer))], [])
    HRESULT get_Renderer(IInkRenderer* CurrentInkRenderer);
    HRESULT putref_Renderer(IInkRenderer NewInkRenderer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-get_ink))], [])
    HRESULT get_Ink(IInkDisp* Ink);
    HRESULT putref_Ink(IInkDisp NewInk);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-get_autoredraw))], [])
    HRESULT get_AutoRedraw(VARIANT_BOOL* AutoRedraw);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-put_autoredraw))], [])
    HRESULT put_AutoRedraw(VARIANT_BOOL AutoRedraw);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-get_collectingink))], [])
    HRESULT get_CollectingInk(VARIANT_BOOL* Collecting);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-get_collectionmode))], [])
    HRESULT get_CollectionMode(InkCollectionMode* Mode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-put_collectionmode))], [])
    HRESULT put_CollectionMode(InkCollectionMode Mode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-get_dynamicrendering))], [])
    HRESULT get_DynamicRendering(VARIANT_BOOL* Enabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-put_dynamicrendering))], [])
    HRESULT put_DynamicRendering(VARIANT_BOOL Enabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-get_desiredpacketdescription))], [])
    HRESULT get_DesiredPacketDescription(VARIANT* PacketGuids);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-put_desiredpacketdescription))], [])
    HRESULT put_DesiredPacketDescription(VARIANT PacketGuids);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-get_mouseicon))], [])
    HRESULT get_MouseIcon(IPictureDisp* MouseIcon);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-put_mouseicon))], [])
    HRESULT put_MouseIcon(IPictureDisp MouseIcon);
    HRESULT putref_MouseIcon(IPictureDisp MouseIcon);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-get_mousepointer))], [])
    HRESULT get_MousePointer(InkMousePointer* MousePointer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-put_mousepointer))], [])
    HRESULT put_MousePointer(InkMousePointer MousePointer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-get_editingmode))], [])
    HRESULT get_EditingMode(InkOverlayEditingMode* EditingMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-put_editingmode))], [])
    HRESULT put_EditingMode(InkOverlayEditingMode EditingMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-get_selection))], [])
    HRESULT get_Selection(IInkStrokes* Selection);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-put_selection))], [])
    HRESULT put_Selection(IInkStrokes Selection);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-get_erasermode))], [])
    HRESULT get_EraserMode(InkOverlayEraserMode* EraserMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-put_erasermode))], [])
    HRESULT put_EraserMode(InkOverlayEraserMode EraserMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-get_eraserwidth))], [])
    HRESULT get_EraserWidth(int* EraserWidth);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-put_eraserwidth))], [])
    HRESULT put_EraserWidth(int newEraserWidth);
    HRESULT putref_Picture(IPictureDisp pPicture);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-put_picture))], [])
    HRESULT put_Picture(IPictureDisp pPicture);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-get_picture))], [])
    HRESULT get_Picture(IPictureDisp* ppPicture);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-put_sizemode))], [])
    HRESULT put_SizeMode(InkPictureSizeMode smNewSizeMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-get_sizemode))], [])
    HRESULT get_SizeMode(InkPictureSizeMode* smSizeMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-put_backcolor))], [])
    HRESULT put_BackColor(uint newColor);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-get_backcolor))], [])
    HRESULT get_BackColor(uint* pColor);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-get_cursors))], [])
    HRESULT get_Cursors(IInkCursors* Cursors);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-get_marginx))], [])
    HRESULT get_MarginX(int* MarginX);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-put_marginx))], [])
    HRESULT put_MarginX(int MarginX);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-get_marginy))], [])
    HRESULT get_MarginY(int* MarginY);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-put_marginy))], [])
    HRESULT put_MarginY(int MarginY);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-get_tablet))], [])
    HRESULT get_Tablet(IInkTablet* SingleTablet);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-get_supporthighcontrastink))], [])
    HRESULT get_SupportHighContrastInk(VARIANT_BOOL* Support);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-put_supporthighcontrastink))], [])
    HRESULT put_SupportHighContrastInk(VARIANT_BOOL Support);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-get_supporthighcontrastselectionui))], [])
    HRESULT get_SupportHighContrastSelectionUI(VARIANT_BOOL* Support);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-put_supporthighcontrastselectionui))], [])
    HRESULT put_SupportHighContrastSelectionUI(VARIANT_BOOL Support);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-hittestselection))], [])
    HRESULT HitTestSelection(int x, int y, SelectionHitResult* SelArea);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-setgesturestatus))], [])
    HRESULT SetGestureStatus(InkApplicationGesture Gesture, VARIANT_BOOL Listen);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-getgesturestatus))], [])
    HRESULT GetGestureStatus(InkApplicationGesture Gesture, VARIANT_BOOL* Listening);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-getwindowinputrectangle))], [])
    HRESULT GetWindowInputRectangle(IInkRectangle* WindowInputRectangle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-setwindowinputrectangle))], [])
    HRESULT SetWindowInputRectangle(IInkRectangle WindowInputRectangle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-setalltabletsmode))], [])
    HRESULT SetAllTabletsMode(VARIANT_BOOL UseMouseForInput);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-setsingletabletintegratedmode))], [])
    HRESULT SetSingleTabletIntegratedMode(IInkTablet Tablet);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-geteventinterest))], [])
    HRESULT GetEventInterest(InkCollectorEventInterest EventId, VARIANT_BOOL* Listen);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-seteventinterest))], [])
    HRESULT SetEventInterest(InkCollectorEventInterest EventId, VARIANT_BOOL Listen);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-get_inkenabled))], [])
    HRESULT get_InkEnabled(VARIANT_BOOL* Collecting);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-put_inkenabled))], [])
    HRESULT put_InkEnabled(VARIANT_BOOL Collecting);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-get_enabled))], [])
    HRESULT get_Enabled(VARIANT_BOOL* pbool);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkpicture-put_enabled))], [])
    HRESULT put_Enabled(VARIANT_BOOL vbool);
}

@GUID("60ff4fee-22ff-4484-acc1-d308d9cd7ea3")
interface _IInkPictureEvents : IDispatch
{
}

@GUID("782bf7cf-034b-4396-8a32-3a1833cf6b56")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinkrecognizer))], [])
interface IInkRecognizer : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizer-get_name))], [])
    HRESULT get_Name(BSTR* Name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizer-get_vendor))], [])
    HRESULT get_Vendor(BSTR* Vendor);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizer-get_capabilities))], [])
    HRESULT get_Capabilities(InkRecognizerCapabilities* CapabilitiesFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizer-get_languages))], [])
    HRESULT get_Languages(VARIANT* Languages);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizer-get_supportedproperties))], [])
    HRESULT get_SupportedProperties(VARIANT* SupportedProperties);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizer-get_preferredpacketdescription))], [])
    HRESULT get_PreferredPacketDescription(VARIANT* PreferredPacketDescription);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizer-createrecognizercontext))], [])
    HRESULT CreateRecognizerContext(IInkRecognizerContext* Context);
}

@GUID("6110118a-3a75-4ad6-b2aa-04b2b72bbe65")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinkrecognizer2))], [])
interface IInkRecognizer2 : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizer2-get_id))], [])
    HRESULT get_Id(BSTR* pbstrId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizer2-get_unicoderanges))], [])
    HRESULT get_UnicodeRanges(VARIANT* UnicodeRanges);
}

@GUID("9ccc4f12-b0b7-4a8b-bf58-4aeca4e8cefd")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinkrecognizers))], [])
interface IInkRecognizers : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizers-get_count))], [])
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizers-getdefaultrecognizer))], [])
    HRESULT GetDefaultRecognizer(int lcid, IInkRecognizer* DefaultRecognizer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizers-item))], [])
    HRESULT Item(int Index, IInkRecognizer* InkRecognizer);
}

@GUID("17bce92f-2e21-47fd-9d33-3c6afbfd8c59")
interface _IInkRecognitionEvents : IDispatch
{
}

@GUID("c68f52f9-32a3-4625-906c-44fc23b40958")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinkrecognizercontext))], [])
interface IInkRecognizerContext : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizercontext-get_strokes))], [])
    HRESULT get_Strokes(IInkStrokes* Strokes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizercontext-putref_strokes))], [])
    HRESULT putref_Strokes(IInkStrokes Strokes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizercontext-get_characterautocompletionmode))], [])
    HRESULT get_CharacterAutoCompletionMode(InkRecognizerCharacterAutoCompletionMode* Mode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizercontext-put_characterautocompletionmode))], [])
    HRESULT put_CharacterAutoCompletionMode(InkRecognizerCharacterAutoCompletionMode Mode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizercontext-get_factoid))], [])
    HRESULT get_Factoid(BSTR* Factoid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizercontext-put_factoid))], [])
    HRESULT put_Factoid(BSTR factoid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizercontext-get_guide))], [])
    HRESULT get_Guide(IInkRecognizerGuide* RecognizerGuide);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizercontext-putref_guide))], [])
    HRESULT putref_Guide(IInkRecognizerGuide RecognizerGuide);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizercontext-get_prefixtext))], [])
    HRESULT get_PrefixText(BSTR* Prefix);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizercontext-put_prefixtext))], [])
    HRESULT put_PrefixText(BSTR Prefix);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizercontext-get_suffixtext))], [])
    HRESULT get_SuffixText(BSTR* Suffix);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizercontext-put_suffixtext))], [])
    HRESULT put_SuffixText(BSTR Suffix);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizercontext-get_recognitionflags))], [])
    HRESULT get_RecognitionFlags(InkRecognitionModes* Modes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizercontext-put_recognitionflags))], [])
    HRESULT put_RecognitionFlags(InkRecognitionModes Modes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizercontext-get_wordlist))], [])
    HRESULT get_WordList(IInkWordList* WordList);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizercontext-putref_wordlist))], [])
    HRESULT putref_WordList(IInkWordList WordList);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizercontext-get_recognizer))], [])
    HRESULT get_Recognizer(IInkRecognizer* Recognizer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizercontext-recognize))], [])
    HRESULT Recognize(InkRecognitionStatus* RecognitionStatus, IInkRecognitionResult* RecognitionResult);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizercontext-stopbackgroundrecognition))], [])
    HRESULT StopBackgroundRecognition();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizercontext-endinkinput))], [])
    HRESULT EndInkInput();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizercontext-backgroundrecognize))], [])
    HRESULT BackgroundRecognize(VARIANT CustomData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizercontext-backgroundrecognizewithalternates))], [])
    HRESULT BackgroundRecognizeWithAlternates(VARIANT CustomData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizercontext-clone))], [])
    HRESULT Clone(IInkRecognizerContext* RecoContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizercontext-isstringsupported))], [])
    HRESULT IsStringSupported(BSTR String, VARIANT_BOOL* Supported);
}

@GUID("d6f0e32f-73d8-408e-8e9f-5fea592c363f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinkrecognizercontext2))], [])
interface IInkRecognizerContext2 : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizercontext2-get_enabledunicoderanges))], [])
    HRESULT get_EnabledUnicodeRanges(VARIANT* UnicodeRanges);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizercontext2-put_enabledunicoderanges))], [])
    HRESULT put_EnabledUnicodeRanges(VARIANT UnicodeRanges);
}

@GUID("3bc129a8-86cd-45ad-bde8-e0d32d61c16d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinkrecognitionresult))], [])
interface IInkRecognitionResult : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognitionresult-get_topstring))], [])
    HRESULT get_TopString(BSTR* TopString);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognitionresult-get_topalternate))], [])
    HRESULT get_TopAlternate(IInkRecognitionAlternate* TopAlternate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognitionresult-get_topconfidence))], [])
    HRESULT get_TopConfidence(InkRecognitionConfidence* TopConfidence);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognitionresult-get_strokes))], [])
    HRESULT get_Strokes(IInkStrokes* Strokes);
    HRESULT AlternatesFromSelection(int selectionStart, int selectionLength, int maximumAlternates, 
                                    IInkRecognitionAlternates* AlternatesFromSelection);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognitionresult-modifytopalternate))], [])
    HRESULT ModifyTopAlternate(IInkRecognitionAlternate Alternate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognitionresult-setresultonstrokes))], [])
    HRESULT SetResultOnStrokes();
}

@GUID("b7e660ad-77e4-429b-adda-873780d1fc4a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinkrecognitionalternate))], [])
interface IInkRecognitionAlternate : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognitionalternate-get_string))], [])
    HRESULT get_String(BSTR* RecoString);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognitionalternate-get_confidence))], [])
    HRESULT get_Confidence(InkRecognitionConfidence* Confidence);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognitionalternate-get_baseline))], [])
    HRESULT get_Baseline(VARIANT* Baseline);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognitionalternate-get_midline))], [])
    HRESULT get_Midline(VARIANT* Midline);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognitionalternate-get_ascender))], [])
    HRESULT get_Ascender(VARIANT* Ascender);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognitionalternate-get_descender))], [])
    HRESULT get_Descender(VARIANT* Descender);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognitionalternate-get_linenumber))], [])
    HRESULT get_LineNumber(int* LineNumber);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognitionalternate-get_strokes))], [])
    HRESULT get_Strokes(IInkStrokes* Strokes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognitionalternate-get_linealternates))], [])
    HRESULT get_LineAlternates(IInkRecognitionAlternates* LineAlternates);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognitionalternate-get_confidencealternates))], [])
    HRESULT get_ConfidenceAlternates(IInkRecognitionAlternates* ConfidenceAlternates);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognitionalternate-getstrokesfromstrokeranges))], [])
    HRESULT GetStrokesFromStrokeRanges(IInkStrokes Strokes, IInkStrokes* GetStrokesFromStrokeRanges);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognitionalternate-getstrokesfromtextrange))], [])
    HRESULT GetStrokesFromTextRange(int* selectionStart, int* selectionLength, 
                                    IInkStrokes* GetStrokesFromTextRange);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognitionalternate-gettextrangefromstrokes))], [])
    HRESULT GetTextRangeFromStrokes(IInkStrokes Strokes, int* selectionStart, int* selectionLength);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognitionalternate-alternateswithconstantpropertyvalues))], [])
    HRESULT AlternatesWithConstantPropertyValues(BSTR PropertyType, 
                                                 IInkRecognitionAlternates* AlternatesWithConstantPropertyValues);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognitionalternate-getpropertyvalue))], [])
    HRESULT GetPropertyValue(BSTR PropertyType, VARIANT* PropertyValue);
}

@GUID("286a167f-9f19-4c61-9d53-4f07be622b84")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinkrecognitionalternates))], [])
interface IInkRecognitionAlternates : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognitionalternates-get_count))], [])
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognitionalternates-get_strokes))], [])
    HRESULT get_Strokes(IInkStrokes* Strokes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognitionalternates-item))], [])
    HRESULT Item(int Index, IInkRecognitionAlternate* InkRecoAlternate);
}

@GUID("d934be07-7b84-4208-9136-83c20994e905")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinkrecognizerguide))], [])
interface IInkRecognizerGuide : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizerguide-get_writingbox))], [])
    HRESULT get_WritingBox(IInkRectangle* Rectangle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizerguide-put_writingbox))], [])
    HRESULT put_WritingBox(IInkRectangle Rectangle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizerguide-get_drawnbox))], [])
    HRESULT get_DrawnBox(IInkRectangle* Rectangle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizerguide-put_drawnbox))], [])
    HRESULT put_DrawnBox(IInkRectangle Rectangle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizerguide-get_rows))], [])
    HRESULT get_Rows(int* Units);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizerguide-put_rows))], [])
    HRESULT put_Rows(int Units);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizerguide-get_columns))], [])
    HRESULT get_Columns(int* Units);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizerguide-put_columns))], [])
    HRESULT put_Columns(int Units);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizerguide-get_midline))], [])
    HRESULT get_Midline(int* Units);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizerguide-put_midline))], [])
    HRESULT put_Midline(int Units);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizerguide-get_guidedata))], [])
    HRESULT get_GuideData(InkRecoGuide* pRecoGuide);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkrecognizerguide-put_guidedata))], [])
    HRESULT put_GuideData(InkRecoGuide recoGuide);
}

@GUID("76ba3491-cb2f-406b-9961-0e0c4cdaaef2")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinkwordlist))], [])
interface IInkWordList : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkwordlist-addword))], [])
    HRESULT AddWord(BSTR NewWord);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkwordlist-removeword))], [])
    HRESULT RemoveWord(BSTR RemoveWord);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkwordlist-merge))], [])
    HRESULT Merge(IInkWordList MergeWordList);
}

@GUID("14542586-11bf-4f5f-b6e7-49d0744aab6e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinkwordlist2))], [])
interface IInkWordList2 : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinkwordlist2-addwords))], [])
    HRESULT AddWords(BSTR NewWords);
}

@GUID("03f8e511-43a1-11d3-8bb6-0080c7d6bad5")
interface IInk : IDispatch
{
}

@GUID("9c1c5ad6-f22f-4de4-b453-a2cc482e7c33")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nn-msinkaut-iinklineinfo))], [])
interface IInkLineInfo : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinklineinfo-setformat))], [])
    HRESULT SetFormat(INKMETRIC* pim);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinklineinfo-getformat))], [])
    HRESULT GetFormat(INKMETRIC* pim);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinklineinfo-getinkextent))], [])
    HRESULT GetInkExtent(INKMETRIC* pim, uint* pnWidth);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinklineinfo-getcandidate))], [])
    HRESULT GetCandidate(uint nCandidateNum, PWSTR pwcRecogWord, uint* pcwcRecogWord, uint dwFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinklineinfo-setcandidate))], [])
    HRESULT SetCandidate(uint nCandidateNum, PWSTR strRecogWord);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut/nf-msinkaut-iinklineinfo-recognize))], [])
    HRESULT Recognize();
}

@GUID("b4563688-98eb-4646-b279-44da14d45748")
interface ISketchInk : IDispatch
{
}

@GUID("5de00405-f9a4-4651-b0c5-c317defd58b9")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut15/nn-msinkaut15-iinkdivider))], [])
interface IInkDivider : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut15/nf-msinkaut15-iinkdivider-get_strokes))], [])
    HRESULT get_Strokes(IInkStrokes* Strokes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut15/nf-msinkaut15-iinkdivider-putref_strokes))], [])
    HRESULT putref_Strokes(IInkStrokes Strokes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut15/nf-msinkaut15-iinkdivider-get_recognizercontext))], [])
    HRESULT get_RecognizerContext(IInkRecognizerContext* RecognizerContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut15/nf-msinkaut15-iinkdivider-putref_recognizercontext))], [])
    HRESULT putref_RecognizerContext(IInkRecognizerContext RecognizerContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut15/nf-msinkaut15-iinkdivider-get_lineheight))], [])
    HRESULT get_LineHeight(int* LineHeight);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut15/nf-msinkaut15-iinkdivider-put_lineheight))], [])
    HRESULT put_LineHeight(int LineHeight);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut15/nf-msinkaut15-iinkdivider-divide))], [])
    HRESULT Divide(IInkDivisionResult* InkDivisionResult);
}

@GUID("2dbec0a7-74c7-4b38-81eb-aa8ef0c24900")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut15/nn-msinkaut15-iinkdivisionresult))], [])
interface IInkDivisionResult : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut15/nf-msinkaut15-iinkdivisionresult-get_strokes))], [])
    HRESULT get_Strokes(IInkStrokes* Strokes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut15/nf-msinkaut15-iinkdivisionresult-resultbytype))], [])
    HRESULT ResultByType(InkDivisionType divisionType, IInkDivisionUnits* InkDivisionUnits);
}

@GUID("85aee342-48b0-4244-9dd5-1ed435410fab")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut15/nn-msinkaut15-iinkdivisionunit))], [])
interface IInkDivisionUnit : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut15/nf-msinkaut15-iinkdivisionunit-get_strokes))], [])
    HRESULT get_Strokes(IInkStrokes* Strokes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut15/nf-msinkaut15-iinkdivisionunit-get_divisiontype))], [])
    HRESULT get_DivisionType(InkDivisionType* divisionType);
    HRESULT get_RecognizedString(BSTR* RecoString);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut15/nf-msinkaut15-iinkdivisionunit-get_rotationtransform))], [])
    HRESULT get_RotationTransform(IInkTransform* RotationTransform);
}

@GUID("1bb5ddc2-31cc-4135-ab82-2c66c9f00c41")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut15/nn-msinkaut15-iinkdivisionunits))], [])
interface IInkDivisionUnits : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut15/nf-msinkaut15-iinkdivisionunits-get_count))], [])
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msinkaut15/nf-msinkaut15-iinkdivisionunits-item))], [])
    HRESULT Item(int Index, IInkDivisionUnit* InkDivisionUnit);
}

@GUID("fa7a4083-5747-4040-a182-0b0e9fd4fac7")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nn-peninputpanel-ipeninputpanel))], [])
interface IPenInputPanel : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-ipeninputpanel-get_busy))], [])
    HRESULT get_Busy(VARIANT_BOOL* Busy);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-ipeninputpanel-get_factoid))], [])
    HRESULT get_Factoid(BSTR* Factoid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-ipeninputpanel-put_factoid))], [])
    HRESULT put_Factoid(BSTR Factoid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-ipeninputpanel-get_attachededitwindow))], [])
    HRESULT get_AttachedEditWindow(int* AttachedEditWindow);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-ipeninputpanel-put_attachededitwindow))], [])
    HRESULT put_AttachedEditWindow(int AttachedEditWindow);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-ipeninputpanel-get_currentpanel))], [])
    HRESULT get_CurrentPanel(PanelType* CurrentPanel);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-ipeninputpanel-put_currentpanel))], [])
    HRESULT put_CurrentPanel(PanelType CurrentPanel);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-ipeninputpanel-get_defaultpanel))], [])
    HRESULT get_DefaultPanel(PanelType* pDefaultPanel);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-ipeninputpanel-put_defaultpanel))], [])
    HRESULT put_DefaultPanel(PanelType DefaultPanel);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-ipeninputpanel-get_visible))], [])
    HRESULT get_Visible(VARIANT_BOOL* Visible);
    HRESULT put_Visible(VARIANT_BOOL Visible);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-ipeninputpanel-get_top))], [])
    HRESULT get_Top(int* Top);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-ipeninputpanel-get_left))], [])
    HRESULT get_Left(int* Left);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-ipeninputpanel-get_width))], [])
    HRESULT get_Width(int* Width);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-ipeninputpanel-get_height))], [])
    HRESULT get_Height(int* Height);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-ipeninputpanel-get_verticaloffset))], [])
    HRESULT get_VerticalOffset(int* VerticalOffset);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-ipeninputpanel-put_verticaloffset))], [])
    HRESULT put_VerticalOffset(int VerticalOffset);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-ipeninputpanel-get_horizontaloffset))], [])
    HRESULT get_HorizontalOffset(int* HorizontalOffset);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-ipeninputpanel-put_horizontaloffset))], [])
    HRESULT put_HorizontalOffset(int HorizontalOffset);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-ipeninputpanel-get_autoshow))], [])
    HRESULT get_AutoShow(VARIANT_BOOL* pAutoShow);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-ipeninputpanel-put_autoshow))], [])
    HRESULT put_AutoShow(VARIANT_BOOL AutoShow);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-ipeninputpanel-moveto))], [])
    HRESULT MoveTo(int Left, int Top);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-ipeninputpanel-commitpendinginput))], [])
    HRESULT CommitPendingInput();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-ipeninputpanel-refresh))], [])
    HRESULT Refresh();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-ipeninputpanel-enabletsf))], [])
    HRESULT EnableTsf(VARIANT_BOOL Enable);
}

@GUID("b7e489da-3719-439f-848f-e7acbd820f17")
interface _IPenInputPanelEvents : IDispatch
{
}

@GUID("56fdea97-ecd6-43e7-aa3a-816be7785860")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nn-peninputpanel-ihandwrittentextinsertion))], [])
interface IHandwrittenTextInsertion : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-ihandwrittentextinsertion-insertrecognitionresultsarray))], [])
    HRESULT InsertRecognitionResultsArray(SAFEARRAY* psaAlternates, uint locale, 
                                          BOOL fAlternateContainsAutoSpacingInformation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-ihandwrittentextinsertion-insertinkrecognitionresult))], [])
    HRESULT InsertInkRecognitionResult(IInkRecognitionResult pIInkRecoResult, uint locale, 
                                       BOOL fAlternateContainsAutoSpacingInformation);
}

@GUID("27560408-8e64-4fe1-804e-421201584b31")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nn-peninputpanel-itextinputpaneleventsink))], [])
interface ITextInputPanelEventSink : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpaneleventsink-inplacestatechanging))], [])
    HRESULT InPlaceStateChanging(InPlaceState oldInPlaceState, InPlaceState newInPlaceState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpaneleventsink-inplacestatechanged))], [])
    HRESULT InPlaceStateChanged(InPlaceState oldInPlaceState, InPlaceState newInPlaceState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpaneleventsink-inplacesizechanging))], [])
    HRESULT InPlaceSizeChanging(RECT oldBoundingRectangle, RECT newBoundingRectangle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpaneleventsink-inplacesizechanged))], [])
    HRESULT InPlaceSizeChanged(RECT oldBoundingRectangle, RECT newBoundingRectangle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpaneleventsink-inputareachanging))], [])
    HRESULT InputAreaChanging(PanelInputArea oldInputArea, PanelInputArea newInputArea);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpaneleventsink-inputareachanged))], [])
    HRESULT InputAreaChanged(PanelInputArea oldInputArea, PanelInputArea newInputArea);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpaneleventsink-correctionmodechanging))], [])
    HRESULT CorrectionModeChanging(CorrectionMode oldCorrectionMode, CorrectionMode newCorrectionMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpaneleventsink-correctionmodechanged))], [])
    HRESULT CorrectionModeChanged(CorrectionMode oldCorrectionMode, CorrectionMode newCorrectionMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpaneleventsink-inplacevisibilitychanging))], [])
    HRESULT InPlaceVisibilityChanging(BOOL oldVisible, BOOL newVisible);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpaneleventsink-inplacevisibilitychanged))], [])
    HRESULT InPlaceVisibilityChanged(BOOL oldVisible, BOOL newVisible);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpaneleventsink-textinserting))], [])
    HRESULT TextInserting(SAFEARRAY* Ink);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpaneleventsink-textinserted))], [])
    HRESULT TextInserted(SAFEARRAY* Ink);
}

@GUID("6b6a65a5-6af3-46c2-b6ea-56cd1f80df71")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nn-peninputpanel-itextinputpanel))], [])
interface ITextInputPanel : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpanel-get_attachededitwindow))], [])
    HRESULT get_AttachedEditWindow(HWND* AttachedEditWindow);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpanel-put_attachededitwindow))], [])
    HRESULT put_AttachedEditWindow(HWND AttachedEditWindow);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpanel-get_currentinteractionmode))], [])
    HRESULT get_CurrentInteractionMode(InteractionMode* CurrentInteractionMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpanel-get_defaultinplacestate))], [])
    HRESULT get_DefaultInPlaceState(InPlaceState* State);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpanel-put_defaultinplacestate))], [])
    HRESULT put_DefaultInPlaceState(InPlaceState State);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpanel-get_currentinplacestate))], [])
    HRESULT get_CurrentInPlaceState(InPlaceState* State);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpanel-get_defaultinputarea))], [])
    HRESULT get_DefaultInputArea(PanelInputArea* Area);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpanel-put_defaultinputarea))], [])
    HRESULT put_DefaultInputArea(PanelInputArea Area);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpanel-get_currentinputarea))], [])
    HRESULT get_CurrentInputArea(PanelInputArea* Area);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpanel-get_currentcorrectionmode))], [])
    HRESULT get_CurrentCorrectionMode(CorrectionMode* Mode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpanel-get_preferredinplacedirection))], [])
    HRESULT get_PreferredInPlaceDirection(InPlaceDirection* Direction);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpanel-put_preferredinplacedirection))], [])
    HRESULT put_PreferredInPlaceDirection(InPlaceDirection Direction);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpanel-get_expandpostinsertioncorrection))], [])
    HRESULT get_ExpandPostInsertionCorrection(BOOL* Expand);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpanel-put_expandpostinsertioncorrection))], [])
    HRESULT put_ExpandPostInsertionCorrection(BOOL Expand);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpanel-get_inplacevisibleonfocus))], [])
    HRESULT get_InPlaceVisibleOnFocus(BOOL* Visible);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpanel-put_inplacevisibleonfocus))], [])
    HRESULT put_InPlaceVisibleOnFocus(BOOL Visible);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpanel-get_inplaceboundingrectangle))], [])
    HRESULT get_InPlaceBoundingRectangle(RECT* BoundingRectangle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpanel-get_popupcorrectionheight))], [])
    HRESULT get_PopUpCorrectionHeight(int* Height);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpanel-get_popdowncorrectionheight))], [])
    HRESULT get_PopDownCorrectionHeight(int* Height);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpanel-commitpendinginput))], [])
    HRESULT CommitPendingInput();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpanel-setinplacevisibility))], [])
    HRESULT SetInPlaceVisibility(BOOL Visible);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpanel-setinplaceposition))], [])
    HRESULT SetInPlacePosition(int xPosition, int yPosition, CorrectionPosition position);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpanel-setinplacehovertargetposition))], [])
    HRESULT SetInPlaceHoverTargetPosition(int xPosition, int yPosition);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpanel-advise))], [])
    HRESULT Advise(ITextInputPanelEventSink EventSink, uint EventMask);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpanel-unadvise))], [])
    HRESULT Unadvise(ITextInputPanelEventSink EventSink);
}

@GUID("4af81847-fdc4-4fc3-ad0b-422479c1b935")
interface IInputPanelWindowHandle : IUnknown
{
    HRESULT get_AttachedEditWindow32(int* AttachedEditWindow);
    HRESULT put_AttachedEditWindow32(int AttachedEditWindow);
    HRESULT get_AttachedEditWindow64(long* AttachedEditWindow);
    HRESULT put_AttachedEditWindow64(long AttachedEditWindow);
}

@GUID("9f424568-1920-48cc-9811-a993cbf5adba")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nn-peninputpanel-itextinputpanelruninfo))], [])
interface ITextInputPanelRunInfo : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/peninputpanel/nf-peninputpanel-itextinputpanelruninfo-istiprunning))], [])
    HRESULT IsTipRunning(BOOL* pfRunning);
}

@GUID("f2127a19-fbfb-4aed-8464-3f36d78cfefb")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nn-inked-iinkedit))], [])
interface IInkEdit : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_status))], [])
    HRESULT get_Status(InkEditStatus* pStatus);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_usemouseforinput))], [])
    HRESULT get_UseMouseForInput(VARIANT_BOOL* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_usemouseforinput))], [])
    HRESULT put_UseMouseForInput(VARIANT_BOOL newVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_inkmode))], [])
    HRESULT get_InkMode(InkMode* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_inkmode))], [])
    HRESULT put_InkMode(InkMode newVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_inkinsertmode))], [])
    HRESULT get_InkInsertMode(InkInsertMode* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_inkinsertmode))], [])
    HRESULT put_InkInsertMode(InkInsertMode newVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_drawingattributes))], [])
    HRESULT get_DrawingAttributes(IInkDrawingAttributes* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-putref_drawingattributes))], [])
    HRESULT putref_DrawingAttributes(IInkDrawingAttributes newVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_recognitiontimeout))], [])
    HRESULT get_RecognitionTimeout(int* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_recognitiontimeout))], [])
    HRESULT put_RecognitionTimeout(int newVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_recognizer))], [])
    HRESULT get_Recognizer(IInkRecognizer* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-putref_recognizer))], [])
    HRESULT putref_Recognizer(IInkRecognizer newVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_factoid))], [])
    HRESULT get_Factoid(BSTR* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_factoid))], [])
    HRESULT put_Factoid(BSTR newVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_selinks))], [])
    HRESULT get_SelInks(VARIANT* pSelInk);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_selinks))], [])
    HRESULT put_SelInks(VARIANT SelInk);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_selinksdisplaymode))], [])
    HRESULT get_SelInksDisplayMode(InkDisplayMode* pInkDisplayMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_selinksdisplaymode))], [])
    HRESULT put_SelInksDisplayMode(InkDisplayMode InkDisplayMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-recognize))], [])
    HRESULT Recognize();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-getgesturestatus))], [])
    HRESULT GetGestureStatus(InkApplicationGesture Gesture, VARIANT_BOOL* pListen);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-setgesturestatus))], [])
    HRESULT SetGestureStatus(InkApplicationGesture Gesture, VARIANT_BOOL Listen);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_backcolor))], [])
    HRESULT put_BackColor(uint clr);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_backcolor))], [])
    HRESULT get_BackColor(uint* pclr);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_appearance))], [])
    HRESULT get_Appearance(AppearanceConstants* pAppearance);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_appearance))], [])
    HRESULT put_Appearance(AppearanceConstants pAppearance);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_borderstyle))], [])
    HRESULT get_BorderStyle(BorderStyleConstants* pBorderStyle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_borderstyle))], [])
    HRESULT put_BorderStyle(BorderStyleConstants pBorderStyle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_hwnd))], [])
    HRESULT get_Hwnd(OLE_HANDLE* pohHwnd);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_font))], [])
    HRESULT get_Font(IFontDisp* ppFont);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-putref_font))], [])
    HRESULT putref_Font(IFontDisp ppFont);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_text))], [])
    HRESULT get_Text(BSTR* pbstrText);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_text))], [])
    HRESULT put_Text(BSTR pbstrText);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_mouseicon))], [])
    HRESULT get_MouseIcon(IPictureDisp* MouseIcon);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_mouseicon))], [])
    HRESULT put_MouseIcon(IPictureDisp MouseIcon);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-putref_mouseicon))], [])
    HRESULT putref_MouseIcon(IPictureDisp MouseIcon);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_mousepointer))], [])
    HRESULT get_MousePointer(InkMousePointer* MousePointer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_mousepointer))], [])
    HRESULT put_MousePointer(InkMousePointer MousePointer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_locked))], [])
    HRESULT get_Locked(VARIANT_BOOL* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_locked))], [])
    HRESULT put_Locked(VARIANT_BOOL newVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_enabled))], [])
    HRESULT get_Enabled(VARIANT_BOOL* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_enabled))], [])
    HRESULT put_Enabled(VARIANT_BOOL newVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_maxlength))], [])
    HRESULT get_MaxLength(int* plMaxLength);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_maxlength))], [])
    HRESULT put_MaxLength(int lMaxLength);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_multiline))], [])
    HRESULT get_MultiLine(VARIANT_BOOL* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_multiline))], [])
    HRESULT put_MultiLine(VARIANT_BOOL newVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_scrollbars))], [])
    HRESULT get_ScrollBars(ScrollBarsConstants* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_scrollbars))], [])
    HRESULT put_ScrollBars(ScrollBarsConstants newVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_disablenoscroll))], [])
    HRESULT get_DisableNoScroll(VARIANT_BOOL* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_disablenoscroll))], [])
    HRESULT put_DisableNoScroll(VARIANT_BOOL newVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_selalignment))], [])
    HRESULT get_SelAlignment(VARIANT* pvarSelAlignment);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_selalignment))], [])
    HRESULT put_SelAlignment(VARIANT pvarSelAlignment);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_selbold))], [])
    HRESULT get_SelBold(VARIANT* pvarSelBold);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_selbold))], [])
    HRESULT put_SelBold(VARIANT pvarSelBold);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_selitalic))], [])
    HRESULT get_SelItalic(VARIANT* pvarSelItalic);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_selitalic))], [])
    HRESULT put_SelItalic(VARIANT pvarSelItalic);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_selunderline))], [])
    HRESULT get_SelUnderline(VARIANT* pvarSelUnderline);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_selunderline))], [])
    HRESULT put_SelUnderline(VARIANT pvarSelUnderline);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_selcolor))], [])
    HRESULT get_SelColor(VARIANT* pvarSelColor);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_selcolor))], [])
    HRESULT put_SelColor(VARIANT pvarSelColor);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_selfontname))], [])
    HRESULT get_SelFontName(VARIANT* pvarSelFontName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_selfontname))], [])
    HRESULT put_SelFontName(VARIANT pvarSelFontName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_selfontsize))], [])
    HRESULT get_SelFontSize(VARIANT* pvarSelFontSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_selfontsize))], [])
    HRESULT put_SelFontSize(VARIANT pvarSelFontSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_selcharoffset))], [])
    HRESULT get_SelCharOffset(VARIANT* pvarSelCharOffset);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_selcharoffset))], [])
    HRESULT put_SelCharOffset(VARIANT pvarSelCharOffset);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_textrtf))], [])
    HRESULT get_TextRTF(BSTR* pbstrTextRTF);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_textrtf))], [])
    HRESULT put_TextRTF(BSTR pbstrTextRTF);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_selstart))], [])
    HRESULT get_SelStart(int* plSelStart);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_selstart))], [])
    HRESULT put_SelStart(int plSelStart);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_sellength))], [])
    HRESULT get_SelLength(int* plSelLength);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_sellength))], [])
    HRESULT put_SelLength(int plSelLength);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_seltext))], [])
    HRESULT get_SelText(BSTR* pbstrSelText);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_seltext))], [])
    HRESULT put_SelText(BSTR pbstrSelText);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-get_selrtf))], [])
    HRESULT get_SelRTF(BSTR* pbstrSelRTF);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-put_selrtf))], [])
    HRESULT put_SelRTF(BSTR pbstrSelRTF);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inked/nf-inked-iinkedit-refresh))], [])
    HRESULT Refresh();
}

@GUID("e3b0b797-a72e-46db-a0d7-6c9eba8e9bbc")
interface _IInkEditEvents : IDispatch
{
}

@GUID("eba615aa-fac6-4738-ba5f-ff09e9fe473e")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/micaut/nn-micaut-imathinputcontrol))], [])
interface IMathInputControl : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/micaut/nf-micaut-imathinputcontrol-show))], [])
    HRESULT Show();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/micaut/nf-micaut-imathinputcontrol-hide))], [])
    HRESULT Hide();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/micaut/nf-micaut-imathinputcontrol-isvisible))], [])
    HRESULT IsVisible(VARIANT_BOOL* pvbShown);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/micaut/nf-micaut-imathinputcontrol-getposition))], [])
    HRESULT GetPosition(int* Left, int* Top, int* Right, int* Bottom);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/micaut/nf-micaut-imathinputcontrol-setposition))], [])
    HRESULT SetPosition(int Left, int Top, int Right, int Bottom);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/micaut/nf-micaut-imathinputcontrol-clear))], [])
    HRESULT Clear();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/micaut/nf-micaut-imathinputcontrol-setcustompaint))], [])
    HRESULT SetCustomPaint(int Element, VARIANT_BOOL Paint);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/micaut/nf-micaut-imathinputcontrol-setcaptiontext))], [])
    HRESULT SetCaptionText(BSTR CaptionText);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/micaut/nf-micaut-imathinputcontrol-loadink))], [])
    HRESULT LoadInk(IInkDisp Ink);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/micaut/nf-micaut-imathinputcontrol-setownerwindow))], [])
    HRESULT SetOwnerWindow(ptrdiff_t OwnerWindow);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/micaut/nf-micaut-imathinputcontrol-enableextendedbuttons))], [])
    HRESULT EnableExtendedButtons(VARIANT_BOOL Extended);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/micaut/nf-micaut-imathinputcontrol-getpreviewheight))], [])
    HRESULT GetPreviewHeight(int* Height);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/micaut/nf-micaut-imathinputcontrol-setpreviewheight))], [])
    HRESULT SetPreviewHeight(int Height);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/micaut/nf-micaut-imathinputcontrol-enableautogrow))], [])
    HRESULT EnableAutoGrow(VARIANT_BOOL AutoGrow);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/micaut/nf-micaut-imathinputcontrol-addfunctionname))], [])
    HRESULT AddFunctionName(BSTR FunctionName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/micaut/nf-micaut-imathinputcontrol-removefunctionname))], [])
    HRESULT RemoveFunctionName(BSTR FunctionName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/micaut/nf-micaut-imathinputcontrol-gethovericon))], [])
    HRESULT GetHoverIcon(IPictureDisp* HoverImage);
}

@GUID("683336b5-a47d-4358-96f9-875a472ae70a")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/micaut/nn-micaut-_imathinputcontrolevents))], [])
interface _IMathInputControlEvents : IDispatch
{
}

@GUID("a8bb5d22-3144-4a7b-93cd-f34a16be513a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nn-rtscom-irealtimestylus))], [])
interface IRealTimeStylus : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-get_enabled))], [])
    HRESULT get_Enabled(BOOL* pfEnable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-put_enabled))], [])
    HRESULT put_Enabled(BOOL fEnable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-get_hwnd))], [])
    HRESULT get_HWND(HANDLE_PTR* phwnd);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-put_hwnd))], [])
    HRESULT put_HWND(HANDLE_PTR hwnd);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-get_windowinputrectangle))], [])
    HRESULT get_WindowInputRectangle(RECT* prcWndInputRect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-put_windowinputrectangle))], [])
    HRESULT put_WindowInputRectangle(const(RECT)* prcWndInputRect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-addstylussyncplugin))], [])
    HRESULT AddStylusSyncPlugin(uint iIndex, IStylusSyncPlugin piPlugin);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-removestylussyncplugin))], [])
    HRESULT RemoveStylusSyncPlugin(uint iIndex, IStylusSyncPlugin* ppiPlugin);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-removeallstylussyncplugins))], [])
    HRESULT RemoveAllStylusSyncPlugins();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-getstylussyncplugin))], [])
    HRESULT GetStylusSyncPlugin(uint iIndex, IStylusSyncPlugin* ppiPlugin);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-getstylussyncplugincount))], [])
    HRESULT GetStylusSyncPluginCount(uint* pcPlugins);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-addstylusasyncplugin))], [])
    HRESULT AddStylusAsyncPlugin(uint iIndex, IStylusAsyncPlugin piPlugin);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-removestylusasyncplugin))], [])
    HRESULT RemoveStylusAsyncPlugin(uint iIndex, IStylusAsyncPlugin* ppiPlugin);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-removeallstylusasyncplugins))], [])
    HRESULT RemoveAllStylusAsyncPlugins();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-getstylusasyncplugin))], [])
    HRESULT GetStylusAsyncPlugin(uint iIndex, IStylusAsyncPlugin* ppiPlugin);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-getstylusasyncplugincount))], [])
    HRESULT GetStylusAsyncPluginCount(uint* pcPlugins);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-get_childrealtimestylusplugin))], [])
    HRESULT get_ChildRealTimeStylusPlugin(IRealTimeStylus* ppiRTS);
    HRESULT putref_ChildRealTimeStylusPlugin(IRealTimeStylus piRTS);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-addcustomstylusdatatoqueue))], [])
    HRESULT AddCustomStylusDataToQueue(StylusQueue sq, const(GUID)* pGuidId, uint cbData, ubyte* pbData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-clearstylusqueues))], [])
    HRESULT ClearStylusQueues();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-setalltabletsmode))], [])
    HRESULT SetAllTabletsMode(BOOL fUseMouseForInput);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-setsingletabletmode))], [])
    HRESULT SetSingleTabletMode(IInkTablet piTablet);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-gettablet))], [])
    HRESULT GetTablet(IInkTablet* ppiSingleTablet);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-gettabletcontextidfromtablet))], [])
    HRESULT GetTabletContextIdFromTablet(IInkTablet piTablet, uint* ptcid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-gettabletfromtabletcontextid))], [])
    HRESULT GetTabletFromTabletContextId(uint tcid, IInkTablet* ppiTablet);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-getalltabletcontextids))], [])
    HRESULT GetAllTabletContextIds(uint* pcTcidCount, uint** ppTcids);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-getstyluses))], [])
    HRESULT GetStyluses(IInkCursors* ppiInkCursors);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-getstylusforid))], [])
    HRESULT GetStylusForId(uint sid, IInkCursor* ppiInkCursor);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-setdesiredpacketdescription))], [])
    HRESULT SetDesiredPacketDescription(uint cProperties, const(GUID)* pPropertyGuids);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-getdesiredpacketdescription))], [])
    HRESULT GetDesiredPacketDescription(uint* pcProperties, GUID** ppPropertyGuids);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus-getpacketdescriptiondata))], [])
    HRESULT GetPacketDescriptionData(uint tcid, float* pfInkToDeviceScaleX, float* pfInkToDeviceScaleY, 
                                     uint* pcPacketProperties, PACKET_PROPERTY** ppPacketProperties);
}

@GUID("b5f2a6cd-3179-4a3e-b9c4-bb5865962be2")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nn-rtscom-irealtimestylus2))], [])
interface IRealTimeStylus2 : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus2-get_flicksenabled))], [])
    HRESULT get_FlicksEnabled(BOOL* pfEnable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus2-put_flicksenabled))], [])
    HRESULT put_FlicksEnabled(BOOL fEnable);
}

@GUID("d70230a3-6986-4051-b57a-1cf69f4d9db5")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nn-rtscom-irealtimestylus3))], [])
interface IRealTimeStylus3 : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus3-get_multitouchenabled))], [])
    HRESULT get_MultiTouchEnabled(BOOL* pfEnable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylus3-put_multitouchenabled))], [])
    HRESULT put_MultiTouchEnabled(BOOL fEnable);
}

@GUID("aa87eab8-ab4a-4cea-b5cb-46d84c6a2509")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nn-rtscom-irealtimestylussynchronization))], [])
interface IRealTimeStylusSynchronization : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylussynchronization-acquirelock))], [])
    HRESULT AcquireLock(RealTimeStylusLockType lock);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-irealtimestylussynchronization-releaselock))], [])
    HRESULT ReleaseLock(RealTimeStylusLockType lock);
}

@GUID("a5fd4e2d-c44b-4092-9177-260905eb672b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nn-rtscom-istrokebuilder))], [])
interface IStrokeBuilder : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-istrokebuilder-createstroke))], [])
    HRESULT CreateStroke(uint cPktBuffLength, const(int)* pPackets, uint cPacketProperties, 
                         const(PACKET_PROPERTY)* pPacketProperties, float fInkToDeviceScaleX, 
                         float fInkToDeviceScaleY, IInkStrokeDisp* ppIInkStroke);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-istrokebuilder-beginstroke))], [])
    HRESULT BeginStroke(uint tcid, uint sid, const(int)* pPacket, uint cPacketProperties, 
                        PACKET_PROPERTY* pPacketProperties, float fInkToDeviceScaleX, float fInkToDeviceScaleY, 
                        IInkStrokeDisp* ppIInkStroke);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-istrokebuilder-appendpackets))], [])
    HRESULT AppendPackets(uint tcid, uint sid, uint cPktBuffLength, const(int)* pPackets);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-istrokebuilder-endstroke))], [])
    HRESULT EndStroke(uint tcid, uint sid, IInkStrokeDisp* ppIInkStroke, RECT* pDirtyRect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-istrokebuilder-get_ink))], [])
    HRESULT get_Ink(IInkDisp* ppiInkObj);
    HRESULT putref_Ink(IInkDisp piInkObj);
}

@GUID("a81436d8-4757-4fd1-a185-133f97c6c545")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nn-rtscom-istylusplugin))], [])
interface IStylusPlugin : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-istylusplugin-realtimestylusenabled))], [])
    HRESULT RealTimeStylusEnabled(IRealTimeStylus piRtsSrc, uint cTcidCount, const(uint)* pTcids);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-istylusplugin-realtimestylusdisabled))], [])
    HRESULT RealTimeStylusDisabled(IRealTimeStylus piRtsSrc, uint cTcidCount, const(uint)* pTcids);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-istylusplugin-stylusinrange))], [])
    HRESULT StylusInRange(IRealTimeStylus piRtsSrc, uint tcid, uint sid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-istylusplugin-stylusoutofrange))], [])
    HRESULT StylusOutOfRange(IRealTimeStylus piRtsSrc, uint tcid, uint sid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-istylusplugin-stylusdown))], [])
    HRESULT StylusDown(IRealTimeStylus piRtsSrc, const(StylusInfo)* pStylusInfo, uint cPropCountPerPkt, 
                       int* pPacket, int** ppInOutPkt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-istylusplugin-stylusup))], [])
    HRESULT StylusUp(IRealTimeStylus piRtsSrc, const(StylusInfo)* pStylusInfo, uint cPropCountPerPkt, int* pPacket, 
                     int** ppInOutPkt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-istylusplugin-stylusbuttondown))], [])
    HRESULT StylusButtonDown(IRealTimeStylus piRtsSrc, uint sid, const(GUID)* pGuidStylusButton, POINT* pStylusPos);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-istylusplugin-stylusbuttonup))], [])
    HRESULT StylusButtonUp(IRealTimeStylus piRtsSrc, uint sid, const(GUID)* pGuidStylusButton, POINT* pStylusPos);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-istylusplugin-inairpackets))], [])
    HRESULT InAirPackets(IRealTimeStylus piRtsSrc, const(StylusInfo)* pStylusInfo, uint cPktCount, 
                         uint cPktBuffLength, int* pPackets, uint* pcInOutPkts, int** ppInOutPkts);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-istylusplugin-packets))], [])
    HRESULT Packets(IRealTimeStylus piRtsSrc, const(StylusInfo)* pStylusInfo, uint cPktCount, uint cPktBuffLength, 
                    int* pPackets, uint* pcInOutPkts, int** ppInOutPkts);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-istylusplugin-customstylusdataadded))], [])
    HRESULT CustomStylusDataAdded(IRealTimeStylus piRtsSrc, const(GUID)* pGuidId, uint cbData, 
                                  const(ubyte)* pbData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-istylusplugin-systemevent))], [])
    HRESULT SystemEvent(IRealTimeStylus piRtsSrc, uint tcid, uint sid, ushort event, SYSTEM_EVENT_DATA eventdata);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-istylusplugin-tabletadded))], [])
    HRESULT TabletAdded(IRealTimeStylus piRtsSrc, IInkTablet piTablet);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-istylusplugin-tabletremoved))], [])
    HRESULT TabletRemoved(IRealTimeStylus piRtsSrc, int iTabletIndex);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-istylusplugin-error))], [])
    HRESULT Error(IRealTimeStylus piRtsSrc, IStylusPlugin piPlugin, RealTimeStylusDataInterest dataInterest, 
                  HRESULT hrErrorCode, ptrdiff_t* lptrKey);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-istylusplugin-updatemapping))], [])
    HRESULT UpdateMapping(IRealTimeStylus piRtsSrc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-istylusplugin-datainterest))], [])
    HRESULT DataInterest(RealTimeStylusDataInterest* pDataInterest);
}

@GUID("a157b174-482f-4d71-a3f6-3a41ddd11be9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nn-rtscom-istylussyncplugin))], [])
interface IStylusSyncPlugin : IStylusPlugin
{
}

@GUID("a7cca85a-31bc-4cd2-aadc-3289a3af11c8")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nn-rtscom-istylusasyncplugin))], [])
interface IStylusAsyncPlugin : IStylusPlugin
{
}

@GUID("a079468e-7165-46f9-b7af-98ad01a93009")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nn-rtscom-idynamicrenderer))], [])
interface IDynamicRenderer : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-idynamicrenderer-get_enabled))], [])
    HRESULT get_Enabled(BOOL* bEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-idynamicrenderer-put_enabled))], [])
    HRESULT put_Enabled(BOOL bEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-idynamicrenderer-get_hwnd))], [])
    HRESULT get_HWND(HANDLE_PTR* hwnd);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-idynamicrenderer-put_hwnd))], [])
    HRESULT put_HWND(HANDLE_PTR hwnd);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-idynamicrenderer-get_cliprectangle))], [])
    HRESULT get_ClipRectangle(RECT* prcClipRect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-idynamicrenderer-put_cliprectangle))], [])
    HRESULT put_ClipRectangle(const(RECT)* prcClipRect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-idynamicrenderer-get_clipregion))], [])
    HRESULT get_ClipRegion(HANDLE_PTR* phClipRgn);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-idynamicrenderer-put_clipregion))], [])
    HRESULT put_ClipRegion(HANDLE_PTR hClipRgn);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-idynamicrenderer-get_drawingattributes))], [])
    HRESULT get_DrawingAttributes(IInkDrawingAttributes* ppiDA);
    HRESULT putref_DrawingAttributes(IInkDrawingAttributes piDA);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-idynamicrenderer-get_datacacheenabled))], [])
    HRESULT get_DataCacheEnabled(BOOL* pfCacheData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-idynamicrenderer-put_datacacheenabled))], [])
    HRESULT put_DataCacheEnabled(BOOL fCacheData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-idynamicrenderer-releasecacheddata))], [])
    HRESULT ReleaseCachedData(uint strokeId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-idynamicrenderer-refresh))], [])
    HRESULT Refresh();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-idynamicrenderer-draw))], [])
    HRESULT Draw(HANDLE_PTR hDC);
}

@GUID("ae9ef86b-7054-45e3-ae22-3174dc8811b7")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nn-rtscom-igesturerecognizer))], [])
interface IGestureRecognizer : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-igesturerecognizer-get_enabled))], [])
    HRESULT get_Enabled(BOOL* pfEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-igesturerecognizer-put_enabled))], [])
    HRESULT put_Enabled(BOOL fEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-igesturerecognizer-get_maxstrokecount))], [])
    HRESULT get_MaxStrokeCount(int* pcStrokes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-igesturerecognizer-put_maxstrokecount))], [])
    HRESULT put_MaxStrokeCount(int cStrokes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-igesturerecognizer-enablegestures))], [])
    HRESULT EnableGestures(uint cGestures, const(int)* pGestures);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rtscom/nf-rtscom-igesturerecognizer-reset))], [])
    HRESULT Reset();
}

@GUID("7c6cf46d-8404-46b9-ad33-f5b6036d4007")
interface ITipAutoCompleteProvider : IUnknown
{
    HRESULT UpdatePendingText(BSTR bstrPendingText);
    HRESULT Show(BOOL fShow);
}

@GUID("5e078e03-8265-4bbe-9487-d242edbef910")
interface ITipAutoCompleteClient : IUnknown
{
    HRESULT AdviseProvider(HWND hWndField, ITipAutoCompleteProvider pIProvider);
    HRESULT UnadviseProvider(HWND hWndField, ITipAutoCompleteProvider pIProvider);
    HRESULT UserSelection();
    HRESULT PreferredRects(RECT* prcACList, RECT* prcField, RECT* prcModifiedACList, BOOL* pfShownAboveTip);
    HRESULT RequestShowUI(HWND hWndList, BOOL* pfAllowShowing);
}


// GUIDs

const GUID CLSID_DynamicRenderer          = GUIDOF!DynamicRenderer;
const GUID CLSID_GestureRecognizer        = GUIDOF!GestureRecognizer;
const GUID CLSID_HandwrittenTextInsertion = GUIDOF!HandwrittenTextInsertion;
const GUID CLSID_Ink                      = GUIDOF!Ink;
const GUID CLSID_InkCollector             = GUIDOF!InkCollector;
const GUID CLSID_InkDisp                  = GUIDOF!InkDisp;
const GUID CLSID_InkDivider               = GUIDOF!InkDivider;
const GUID CLSID_InkDrawingAttributes     = GUIDOF!InkDrawingAttributes;
const GUID CLSID_InkEdit                  = GUIDOF!InkEdit;
const GUID CLSID_InkOverlay               = GUIDOF!InkOverlay;
const GUID CLSID_InkPicture               = GUIDOF!InkPicture;
const GUID CLSID_InkRecognizerContext     = GUIDOF!InkRecognizerContext;
const GUID CLSID_InkRecognizerGuide       = GUIDOF!InkRecognizerGuide;
const GUID CLSID_InkRecognizers           = GUIDOF!InkRecognizers;
const GUID CLSID_InkRectangle             = GUIDOF!InkRectangle;
const GUID CLSID_InkRenderer              = GUIDOF!InkRenderer;
const GUID CLSID_InkStrokes               = GUIDOF!InkStrokes;
const GUID CLSID_InkTablets               = GUIDOF!InkTablets;
const GUID CLSID_InkTransform             = GUIDOF!InkTransform;
const GUID CLSID_InkWordList              = GUIDOF!InkWordList;
const GUID CLSID_MathInputControl         = GUIDOF!MathInputControl;
const GUID CLSID_PenInputPanel            = GUIDOF!PenInputPanel;
const GUID CLSID_PenInputPanel_Internal   = GUIDOF!PenInputPanel_Internal;
const GUID CLSID_RealTimeStylus           = GUIDOF!RealTimeStylus;
const GUID CLSID_SketchInk                = GUIDOF!SketchInk;
const GUID CLSID_StrokeBuilder            = GUIDOF!StrokeBuilder;
const GUID CLSID_TextInputPanel           = GUIDOF!TextInputPanel;
const GUID CLSID_TipAutoCompleteClient    = GUIDOF!TipAutoCompleteClient;

const GUID IID_IDynamicRenderer               = GUIDOF!IDynamicRenderer;
const GUID IID_IGestureRecognizer             = GUIDOF!IGestureRecognizer;
const GUID IID_IHandwrittenTextInsertion      = GUIDOF!IHandwrittenTextInsertion;
const GUID IID_IInk                           = GUIDOF!IInk;
const GUID IID_IInkCollector                  = GUIDOF!IInkCollector;
const GUID IID_IInkCursor                     = GUIDOF!IInkCursor;
const GUID IID_IInkCursorButton               = GUIDOF!IInkCursorButton;
const GUID IID_IInkCursorButtons              = GUIDOF!IInkCursorButtons;
const GUID IID_IInkCursors                    = GUIDOF!IInkCursors;
const GUID IID_IInkCustomStrokes              = GUIDOF!IInkCustomStrokes;
const GUID IID_IInkDisp                       = GUIDOF!IInkDisp;
const GUID IID_IInkDivider                    = GUIDOF!IInkDivider;
const GUID IID_IInkDivisionResult             = GUIDOF!IInkDivisionResult;
const GUID IID_IInkDivisionUnit               = GUIDOF!IInkDivisionUnit;
const GUID IID_IInkDivisionUnits              = GUIDOF!IInkDivisionUnits;
const GUID IID_IInkDrawingAttributes          = GUIDOF!IInkDrawingAttributes;
const GUID IID_IInkEdit                       = GUIDOF!IInkEdit;
const GUID IID_IInkExtendedProperties         = GUIDOF!IInkExtendedProperties;
const GUID IID_IInkExtendedProperty           = GUIDOF!IInkExtendedProperty;
const GUID IID_IInkGesture                    = GUIDOF!IInkGesture;
const GUID IID_IInkLineInfo                   = GUIDOF!IInkLineInfo;
const GUID IID_IInkOverlay                    = GUIDOF!IInkOverlay;
const GUID IID_IInkPicture                    = GUIDOF!IInkPicture;
const GUID IID_IInkRecognitionAlternate       = GUIDOF!IInkRecognitionAlternate;
const GUID IID_IInkRecognitionAlternates      = GUIDOF!IInkRecognitionAlternates;
const GUID IID_IInkRecognitionResult          = GUIDOF!IInkRecognitionResult;
const GUID IID_IInkRecognizer                 = GUIDOF!IInkRecognizer;
const GUID IID_IInkRecognizer2                = GUIDOF!IInkRecognizer2;
const GUID IID_IInkRecognizerContext          = GUIDOF!IInkRecognizerContext;
const GUID IID_IInkRecognizerContext2         = GUIDOF!IInkRecognizerContext2;
const GUID IID_IInkRecognizerGuide            = GUIDOF!IInkRecognizerGuide;
const GUID IID_IInkRecognizers                = GUIDOF!IInkRecognizers;
const GUID IID_IInkRectangle                  = GUIDOF!IInkRectangle;
const GUID IID_IInkRenderer                   = GUIDOF!IInkRenderer;
const GUID IID_IInkStrokeDisp                 = GUIDOF!IInkStrokeDisp;
const GUID IID_IInkStrokes                    = GUIDOF!IInkStrokes;
const GUID IID_IInkTablet                     = GUIDOF!IInkTablet;
const GUID IID_IInkTablet2                    = GUIDOF!IInkTablet2;
const GUID IID_IInkTablet3                    = GUIDOF!IInkTablet3;
const GUID IID_IInkTablets                    = GUIDOF!IInkTablets;
const GUID IID_IInkTransform                  = GUIDOF!IInkTransform;
const GUID IID_IInkWordList                   = GUIDOF!IInkWordList;
const GUID IID_IInkWordList2                  = GUIDOF!IInkWordList2;
const GUID IID_IInputPanelWindowHandle        = GUIDOF!IInputPanelWindowHandle;
const GUID IID_IMathInputControl              = GUIDOF!IMathInputControl;
const GUID IID_IPenInputPanel                 = GUIDOF!IPenInputPanel;
const GUID IID_IRealTimeStylus                = GUIDOF!IRealTimeStylus;
const GUID IID_IRealTimeStylus2               = GUIDOF!IRealTimeStylus2;
const GUID IID_IRealTimeStylus3               = GUIDOF!IRealTimeStylus3;
const GUID IID_IRealTimeStylusSynchronization = GUIDOF!IRealTimeStylusSynchronization;
const GUID IID_ISketchInk                     = GUIDOF!ISketchInk;
const GUID IID_IStrokeBuilder                 = GUIDOF!IStrokeBuilder;
const GUID IID_IStylusAsyncPlugin             = GUIDOF!IStylusAsyncPlugin;
const GUID IID_IStylusPlugin                  = GUIDOF!IStylusPlugin;
const GUID IID_IStylusSyncPlugin              = GUIDOF!IStylusSyncPlugin;
const GUID IID_ITextInputPanel                = GUIDOF!ITextInputPanel;
const GUID IID_ITextInputPanelEventSink       = GUIDOF!ITextInputPanelEventSink;
const GUID IID_ITextInputPanelRunInfo         = GUIDOF!ITextInputPanelRunInfo;
const GUID IID_ITipAutoCompleteClient         = GUIDOF!ITipAutoCompleteClient;
const GUID IID_ITipAutoCompleteProvider       = GUIDOF!ITipAutoCompleteProvider;
const GUID IID__IInkCollectorEvents           = GUIDOF!_IInkCollectorEvents;
const GUID IID__IInkEditEvents                = GUIDOF!_IInkEditEvents;
const GUID IID__IInkEvents                    = GUIDOF!_IInkEvents;
const GUID IID__IInkOverlayEvents             = GUIDOF!_IInkOverlayEvents;
const GUID IID__IInkPictureEvents             = GUIDOF!_IInkPictureEvents;
const GUID IID__IInkRecognitionEvents         = GUIDOF!_IInkRecognitionEvents;
const GUID IID__IInkStrokesEvents             = GUIDOF!_IInkStrokesEvents;
const GUID IID__IMathInputControlEvents       = GUIDOF!_IMathInputControlEvents;
const GUID IID__IPenInputPanelEvents          = GUIDOF!_IPenInputPanelEvents;
