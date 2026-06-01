// Written in the D programming language.

module windows.win32.web.mshtml;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOL, BSTR, HGLOBAL, HRESULT, HWND,
                                                    LRESULT, POINT, PWSTR, RECT, SIZE,
                                                    VARIANT_BOOL;
public import windows.win32.graphics.dxgi.common : DXGI_FORMAT;
public import windows.win32.graphics.gdi : HDC, HRGN, LOGFONTW;
public import windows.win32.system.com.com : IClassFactory, IDataObject, IDispatch,
                                             IEnumUnknown, IMoniker, IUnknown,
                                             SAFEARRAY;
public import windows.win32.system.diagnostics.debug_.activescript : IActiveScriptError;
public import windows.win32.system.ole : IDispatchEx, IDropTarget, IOleCommandTarget,
                                         IOleInPlaceActiveObject, IOleInPlaceFrame,
                                         IOleInPlaceUIWindow;
public import windows.win32.system.variant : VARIANT;
public import windows.win32.ui.input.ime : IActiveIMMApp;
public import windows.win32.ui.windowsandmessaging : MSG;

extern(Windows) @nogc nothrow:


// Enums


alias htmlDesignMode = int;
enum : int
{
    htmlDesignModeInherit = 0xfffffffe,
    htmlDesignModeOn      = 0xffffffff,
    htmlDesignModeOff     = 0x00000000,
    htmlDesignMode_Max    = 0x7fffffff,
}

alias htmlZOrder = int;
enum : int
{
    htmlZOrderFront = 0x00000000,
    htmlZOrderBack  = 0x00000001,
    htmlZOrder_Max  = 0x7fffffff,
}

alias htmlClear = int;
enum : int
{
    htmlClearNotSet = 0x00000000,
    htmlClearAll    = 0x00000001,
    htmlClearLeft   = 0x00000002,
    htmlClearRight  = 0x00000003,
    htmlClearBoth   = 0x00000004,
    htmlClearNone   = 0x00000005,
    htmlClear_Max   = 0x7fffffff,
}

alias htmlControlAlign = int;
enum : int
{
    htmlControlAlignNotSet    = 0x00000000,
    htmlControlAlignLeft      = 0x00000001,
    htmlControlAlignCenter    = 0x00000002,
    htmlControlAlignRight     = 0x00000003,
    htmlControlAlignTextTop   = 0x00000004,
    htmlControlAlignAbsMiddle = 0x00000005,
    htmlControlAlignBaseline  = 0x00000006,
    htmlControlAlignAbsBottom = 0x00000007,
    htmlControlAlignBottom    = 0x00000008,
    htmlControlAlignMiddle    = 0x00000009,
    htmlControlAlignTop       = 0x0000000a,
    htmlControlAlign_Max      = 0x7fffffff,
}

alias htmlBlockAlign = int;
enum : int
{
    htmlBlockAlignNotSet  = 0x00000000,
    htmlBlockAlignLeft    = 0x00000001,
    htmlBlockAlignCenter  = 0x00000002,
    htmlBlockAlignRight   = 0x00000003,
    htmlBlockAlignJustify = 0x00000004,
    htmlBlockAlign_Max    = 0x7fffffff,
}

alias htmlReadyState = int;
enum : int
{
    htmlReadyStateuninitialized = 0x00000000,
    htmlReadyStateloading       = 0x00000001,
    htmlReadyStateloaded        = 0x00000002,
    htmlReadyStateinteractive   = 0x00000003,
    htmlReadyStatecomplete      = 0x00000004,
    htmlReadyState_Max          = 0x7fffffff,
}

alias htmlLoop = int;
enum : int
{
    htmlLoopLoopInfinite = 0xffffffff,
    htmlLoop_Max         = 0x7fffffff,
}

alias mediaType = int;
enum : int
{
    mediaTypeNotSet     = 0x00000000,
    mediaTypeAll        = 0x000001ff,
    mediaTypeAural      = 0x00000001,
    mediaTypeBraille    = 0x00000002,
    mediaTypeEmbossed   = 0x00000004,
    mediaTypeHandheld   = 0x00000008,
    mediaTypePrint      = 0x00000010,
    mediaTypeProjection = 0x00000020,
    mediaTypeScreen     = 0x00000040,
    mediaTypeTty        = 0x00000080,
    mediaTypeTv         = 0x00000100,
    mediaType_Max       = 0x7fffffff,
}

enum DomConstructor : int
{
    DomConstructorObject                      = 0x00000000,
    DomConstructorAttr                        = 0x00000001,
    DomConstructorBehaviorUrnsCollection      = 0x00000002,
    DomConstructorBookmarkCollection          = 0x00000003,
    DomConstructorCompatibleInfo              = 0x00000004,
    DomConstructorCompatibleInfoCollection    = 0x00000005,
    DomConstructorControlRangeCollection      = 0x00000006,
    DomConstructorCSSCurrentStyleDeclaration  = 0x00000007,
    DomConstructorCSSRuleList                 = 0x00000008,
    DomConstructorCSSRuleStyleDeclaration     = 0x00000009,
    DomConstructorCSSStyleDeclaration         = 0x0000000a,
    DomConstructorCSSStyleRule                = 0x0000000b,
    DomConstructorCSSStyleSheet               = 0x0000000c,
    DomConstructorDataTransfer                = 0x0000000d,
    DomConstructorDOMImplementation           = 0x0000000e,
    DomConstructorElement                     = 0x0000000f,
    DomConstructorEvent                       = 0x00000010,
    DomConstructorHistory                     = 0x00000011,
    DomConstructorHTCElementBehaviorDefaults  = 0x00000012,
    DomConstructorHTMLAnchorElement           = 0x00000013,
    DomConstructorHTMLAreaElement             = 0x00000014,
    DomConstructorHTMLAreasCollection         = 0x00000015,
    DomConstructorHTMLBaseElement             = 0x00000016,
    DomConstructorHTMLBaseFontElement         = 0x00000017,
    DomConstructorHTMLBGSoundElement          = 0x00000018,
    DomConstructorHTMLBlockElement            = 0x00000019,
    DomConstructorHTMLBodyElement             = 0x0000001a,
    DomConstructorHTMLBRElement               = 0x0000001b,
    DomConstructorHTMLButtonElement           = 0x0000001c,
    DomConstructorHTMLCollection              = 0x0000001d,
    DomConstructorHTMLCommentElement          = 0x0000001e,
    DomConstructorHTMLDDElement               = 0x0000001f,
    DomConstructorHTMLDivElement              = 0x00000020,
    DomConstructorHTMLDocument                = 0x00000021,
    DomConstructorHTMLDListElement            = 0x00000022,
    DomConstructorHTMLDTElement               = 0x00000023,
    DomConstructorHTMLEmbedElement            = 0x00000024,
    DomConstructorHTMLFieldSetElement         = 0x00000025,
    DomConstructorHTMLFontElement             = 0x00000026,
    DomConstructorHTMLFormElement             = 0x00000027,
    DomConstructorHTMLFrameElement            = 0x00000028,
    DomConstructorHTMLFrameSetElement         = 0x00000029,
    DomConstructorHTMLGenericElement          = 0x0000002a,
    DomConstructorHTMLHeadElement             = 0x0000002b,
    DomConstructorHTMLHeadingElement          = 0x0000002c,
    DomConstructorHTMLHRElement               = 0x0000002d,
    DomConstructorHTMLHtmlElement             = 0x0000002e,
    DomConstructorHTMLIFrameElement           = 0x0000002f,
    DomConstructorHTMLImageElement            = 0x00000030,
    DomConstructorHTMLInputElement            = 0x00000031,
    DomConstructorHTMLIsIndexElement          = 0x00000032,
    DomConstructorHTMLLabelElement            = 0x00000033,
    DomConstructorHTMLLegendElement           = 0x00000034,
    DomConstructorHTMLLIElement               = 0x00000035,
    DomConstructorHTMLLinkElement             = 0x00000036,
    DomConstructorHTMLMapElement              = 0x00000037,
    DomConstructorHTMLMarqueeElement          = 0x00000038,
    DomConstructorHTMLMetaElement             = 0x00000039,
    DomConstructorHTMLModelessDialog          = 0x0000003a,
    DomConstructorHTMLNamespaceInfo           = 0x0000003b,
    DomConstructorHTMLNamespaceInfoCollection = 0x0000003c,
    DomConstructorHTMLNextIdElement           = 0x0000003d,
    DomConstructorHTMLNoShowElement           = 0x0000003e,
    DomConstructorHTMLObjectElement           = 0x0000003f,
    DomConstructorHTMLOListElement            = 0x00000040,
    DomConstructorHTMLOptionElement           = 0x00000041,
    DomConstructorHTMLParagraphElement        = 0x00000042,
    DomConstructorHTMLParamElement            = 0x00000043,
    DomConstructorHTMLPhraseElement           = 0x00000044,
    DomConstructorHTMLPluginsCollection       = 0x00000045,
    DomConstructorHTMLPopup                   = 0x00000046,
    DomConstructorHTMLScriptElement           = 0x00000047,
    DomConstructorHTMLSelectElement           = 0x00000048,
    DomConstructorHTMLSpanElement             = 0x00000049,
    DomConstructorHTMLStyleElement            = 0x0000004a,
    DomConstructorHTMLTableCaptionElement     = 0x0000004b,
    DomConstructorHTMLTableCellElement        = 0x0000004c,
    DomConstructorHTMLTableColElement         = 0x0000004d,
    DomConstructorHTMLTableElement            = 0x0000004e,
    DomConstructorHTMLTableRowElement         = 0x0000004f,
    DomConstructorHTMLTableSectionElement     = 0x00000050,
    DomConstructorHTMLTextAreaElement         = 0x00000051,
    DomConstructorHTMLTextElement             = 0x00000052,
    DomConstructorHTMLTitleElement            = 0x00000053,
    DomConstructorHTMLUListElement            = 0x00000054,
    DomConstructorHTMLUnknownElement          = 0x00000055,
    DomConstructorImage                       = 0x00000056,
    DomConstructorLocation                    = 0x00000057,
    DomConstructorNamedNodeMap                = 0x00000058,
    DomConstructorNavigator                   = 0x00000059,
    DomConstructorNodeList                    = 0x0000005a,
    DomConstructorOption                      = 0x0000005b,
    DomConstructorScreen                      = 0x0000005c,
    DomConstructorSelection                   = 0x0000005d,
    DomConstructorStaticNodeList              = 0x0000005e,
    DomConstructorStorage                     = 0x0000005f,
    DomConstructorStyleSheetList              = 0x00000060,
    DomConstructorStyleSheetPage              = 0x00000061,
    DomConstructorStyleSheetPageList          = 0x00000062,
    DomConstructorText                        = 0x00000063,
    DomConstructorTextRange                   = 0x00000064,
    DomConstructorTextRangeCollection         = 0x00000065,
    DomConstructorTextRectangle               = 0x00000066,
    DomConstructorTextRectangleList           = 0x00000067,
    DomConstructorWindow                      = 0x00000068,
    DomConstructorXDomainRequest              = 0x00000069,
    DomConstructorXMLHttpRequest              = 0x0000006a,
    DomConstructorMax                         = 0x0000006b,
    DomConstructor_Max                        = 0x7fffffff,
}

alias styleTextTransform = int;
enum : int
{
    styleTextTransformNotSet     = 0x00000000,
    styleTextTransformCapitalize = 0x00000001,
    styleTextTransformLowercase  = 0x00000002,
    styleTextTransformUppercase  = 0x00000003,
    styleTextTransformNone       = 0x00000004,
    styleTextTransform_Max       = 0x7fffffff,
}

alias styleDataRepeat = int;
enum : int
{
    styleDataRepeatNone  = 0x00000000,
    styleDataRepeatInner = 0x00000001,
    styleDataRepeat_Max  = 0x7fffffff,
}

alias styleOverflow = int;
enum : int
{
    styleOverflowNotSet  = 0x00000000,
    styleOverflowAuto    = 0x00000001,
    styleOverflowHidden  = 0x00000002,
    styleOverflowVisible = 0x00000003,
    styleOverflowScroll  = 0x00000004,
    styleOverflow_Max    = 0x7fffffff,
}

alias styleMsOverflowStyle = int;
enum : int
{
    styleMsOverflowStyleNotSet                = 0x00000000,
    styleMsOverflowStyleAuto                  = 0x00000001,
    styleMsOverflowStyleNone                  = 0x00000002,
    styleMsOverflowStyleScrollbar             = 0x00000003,
    styleMsOverflowStyleMsAutoHidingScrollbar = 0x00000004,
    styleMsOverflowStyle_Max                  = 0x7fffffff,
}

alias styleTableLayout = int;
enum : int
{
    styleTableLayoutNotSet = 0x00000000,
    styleTableLayoutAuto   = 0x00000001,
    styleTableLayoutFixed  = 0x00000002,
    styleTableLayout_Max   = 0x7fffffff,
}

alias styleBorderCollapse = int;
enum : int
{
    styleBorderCollapseNotSet   = 0x00000000,
    styleBorderCollapseSeparate = 0x00000001,
    styleBorderCollapseCollapse = 0x00000002,
    styleBorderCollapse_Max     = 0x7fffffff,
}

alias styleCaptionSide = int;
enum : int
{
    styleCaptionSideNotSet = 0x00000000,
    styleCaptionSideTop    = 0x00000001,
    styleCaptionSideBottom = 0x00000002,
    styleCaptionSideLeft   = 0x00000003,
    styleCaptionSideRight  = 0x00000004,
    styleCaptionSide_Max   = 0x7fffffff,
}

alias styleEmptyCells = int;
enum : int
{
    styleEmptyCellsNotSet = 0x00000000,
    styleEmptyCellsShow   = 0x00000001,
    styleEmptyCellsHide   = 0x00000002,
    styleEmptyCells_Max   = 0x7fffffff,
}

alias styleFontStyle = int;
enum : int
{
    styleFontStyleNotSet  = 0x00000000,
    styleFontStyleItalic  = 0x00000001,
    styleFontStyleOblique = 0x00000002,
    styleFontStyleNormal  = 0x00000003,
    styleFontStyle_Max    = 0x7fffffff,
}

alias styleFontVariant = int;
enum : int
{
    styleFontVariantNotSet    = 0x00000000,
    styleFontVariantSmallCaps = 0x00000001,
    styleFontVariantNormal    = 0x00000002,
    styleFontVariant_Max      = 0x7fffffff,
}

alias styleBackgroundRepeat = int;
enum : int
{
    styleBackgroundRepeatRepeat   = 0x00000000,
    styleBackgroundRepeatRepeatX  = 0x00000001,
    styleBackgroundRepeatRepeatY  = 0x00000002,
    styleBackgroundRepeatNoRepeat = 0x00000003,
    styleBackgroundRepeatNotSet   = 0x00000004,
    styleBackgroundRepeat_Max     = 0x7fffffff,
}

alias styleBackgroundAttachment = int;
enum : int
{
    styleBackgroundAttachmentFixed  = 0x00000000,
    styleBackgroundAttachmentScroll = 0x00000001,
    styleBackgroundAttachmentNotSet = 0x00000002,
    styleBackgroundAttachment_Max   = 0x7fffffff,
}

alias styleBackgroundAttachment3 = int;
enum : int
{
    styleBackgroundAttachment3Fixed  = 0x00000000,
    styleBackgroundAttachment3Scroll = 0x00000001,
    styleBackgroundAttachment3Local  = 0x00000002,
    styleBackgroundAttachment3NotSet = 0x00000003,
    styleBackgroundAttachment3_Max   = 0x7fffffff,
}

alias styleBackgroundClip = int;
enum : int
{
    styleBackgroundClipBorderBox  = 0x00000000,
    styleBackgroundClipPaddingBox = 0x00000001,
    styleBackgroundClipContentBox = 0x00000002,
    styleBackgroundClipNotSet     = 0x00000003,
    styleBackgroundClip_Max       = 0x7fffffff,
}

alias styleBackgroundOrigin = int;
enum : int
{
    styleBackgroundOriginBorderBox  = 0x00000000,
    styleBackgroundOriginPaddingBox = 0x00000001,
    styleBackgroundOriginContentBox = 0x00000002,
    styleBackgroundOriginNotSet     = 0x00000003,
    styleBackgroundOrigin_Max       = 0x7fffffff,
}

alias styleVerticalAlign = int;
enum : int
{
    styleVerticalAlignAuto       = 0x00000000,
    styleVerticalAlignBaseline   = 0x00000001,
    styleVerticalAlignSub        = 0x00000002,
    styleVerticalAlignSuper      = 0x00000003,
    styleVerticalAlignTop        = 0x00000004,
    styleVerticalAlignTextTop    = 0x00000005,
    styleVerticalAlignMiddle     = 0x00000006,
    styleVerticalAlignBottom     = 0x00000007,
    styleVerticalAlignTextBottom = 0x00000008,
    styleVerticalAlignInherit    = 0x00000009,
    styleVerticalAlignNotSet     = 0x0000000a,
    styleVerticalAlign_Max       = 0x7fffffff,
}

alias styleFontWeight = int;
enum : int
{
    styleFontWeightNotSet  = 0x00000000,
    styleFontWeight100     = 0x00000001,
    styleFontWeight200     = 0x00000002,
    styleFontWeight300     = 0x00000003,
    styleFontWeight400     = 0x00000004,
    styleFontWeight500     = 0x00000005,
    styleFontWeight600     = 0x00000006,
    styleFontWeight700     = 0x00000007,
    styleFontWeight800     = 0x00000008,
    styleFontWeight900     = 0x00000009,
    styleFontWeightNormal  = 0x0000000a,
    styleFontWeightBold    = 0x0000000b,
    styleFontWeightBolder  = 0x0000000c,
    styleFontWeightLighter = 0x0000000d,
    styleFontWeight_Max    = 0x7fffffff,
}

alias styleFontSize = int;
enum : int
{
    styleFontSizeXXSmall = 0x00000000,
    styleFontSizeXSmall  = 0x00000001,
    styleFontSizeSmall   = 0x00000002,
    styleFontSizeMedium  = 0x00000003,
    styleFontSizeLarge   = 0x00000004,
    styleFontSizeXLarge  = 0x00000005,
    styleFontSizeXXLarge = 0x00000006,
    styleFontSizeSmaller = 0x00000007,
    styleFontSizeLarger  = 0x00000008,
    styleFontSize_Max    = 0x7fffffff,
}

alias styleZIndex = int;
enum : int
{
    styleZIndexAuto = 0x80000001,
    styleZIndex_Max = 0x7fffffff,
}

alias styleWidowsOrphans = int;
enum : int
{
    styleWidowsOrphansNotSet = 0x80000001,
    styleWidowsOrphans_Max   = 0x7fffffff,
}

alias styleAuto = int;
enum : int
{
    styleAutoAuto = 0x00000000,
    styleAuto_Max = 0x7fffffff,
}

alias styleNone = int;
enum : int
{
    styleNoneNone = 0x00000000,
    styleNone_Max = 0x7fffffff,
}

alias styleNormal = int;
enum : int
{
    styleNormalNormal = 0x00000000,
    styleNormal_Max   = 0x7fffffff,
}

alias styleBorderWidth = int;
enum : int
{
    styleBorderWidthThin   = 0x00000000,
    styleBorderWidthMedium = 0x00000001,
    styleBorderWidthThick  = 0x00000002,
    styleBorderWidth_Max   = 0x7fffffff,
}

alias stylePosition = int;
enum : int
{
    stylePositionNotSet        = 0x00000000,
    stylePositionstatic        = 0x00000001,
    stylePositionrelative      = 0x00000002,
    stylePositionabsolute      = 0x00000003,
    stylePositionfixed         = 0x00000004,
    stylePositionMsPage        = 0x00000005,
    stylePositionMsDeviceFixed = 0x00000006,
    stylePosition_Max          = 0x7fffffff,
}

alias styleBorderStyle = int;
enum : int
{
    styleBorderStyleNotSet      = 0x00000000,
    styleBorderStyleDotted      = 0x00000001,
    styleBorderStyleDashed      = 0x00000002,
    styleBorderStyleSolid       = 0x00000003,
    styleBorderStyleDouble      = 0x00000004,
    styleBorderStyleGroove      = 0x00000005,
    styleBorderStyleRidge       = 0x00000006,
    styleBorderStyleInset       = 0x00000007,
    styleBorderStyleOutset      = 0x00000008,
    styleBorderStyleWindowInset = 0x00000009,
    styleBorderStyleNone        = 0x0000000a,
    styleBorderStyleHidden      = 0x0000000b,
    styleBorderStyle_Max        = 0x7fffffff,
}

alias styleOutlineStyle = int;
enum : int
{
    styleOutlineStyleNotSet      = 0x00000000,
    styleOutlineStyleDotted      = 0x00000001,
    styleOutlineStyleDashed      = 0x00000002,
    styleOutlineStyleSolid       = 0x00000003,
    styleOutlineStyleDouble      = 0x00000004,
    styleOutlineStyleGroove      = 0x00000005,
    styleOutlineStyleRidge       = 0x00000006,
    styleOutlineStyleInset       = 0x00000007,
    styleOutlineStyleOutset      = 0x00000008,
    styleOutlineStyleWindowInset = 0x00000009,
    styleOutlineStyleNone        = 0x0000000a,
    styleOutlineStyle_Max        = 0x7fffffff,
}

alias styleStyleFloat = int;
enum : int
{
    styleStyleFloatNotSet = 0x00000000,
    styleStyleFloatLeft   = 0x00000001,
    styleStyleFloatRight  = 0x00000002,
    styleStyleFloatNone   = 0x00000003,
    styleStyleFloat_Max   = 0x7fffffff,
}

alias styleDisplay = int;
enum : int
{
    styleDisplayNotSet            = 0x00000000,
    styleDisplayBlock             = 0x00000001,
    styleDisplayInline            = 0x00000002,
    styleDisplayListItem          = 0x00000003,
    styleDisplayNone              = 0x00000004,
    styleDisplayTableHeaderGroup  = 0x00000005,
    styleDisplayTableFooterGroup  = 0x00000006,
    styleDisplayInlineBlock       = 0x00000007,
    styleDisplayTable             = 0x00000008,
    styleDisplayInlineTable       = 0x00000009,
    styleDisplayTableRow          = 0x0000000a,
    styleDisplayTableRowGroup     = 0x0000000b,
    styleDisplayTableColumn       = 0x0000000c,
    styleDisplayTableColumnGroup  = 0x0000000d,
    styleDisplayTableCell         = 0x0000000e,
    styleDisplayTableCaption      = 0x0000000f,
    styleDisplayRunIn             = 0x00000010,
    styleDisplayRuby              = 0x00000011,
    styleDisplayRubyBase          = 0x00000012,
    styleDisplayRubyText          = 0x00000013,
    styleDisplayRubyBaseContainer = 0x00000014,
    styleDisplayRubyTextContainer = 0x00000015,
    styleDisplayMsFlexbox         = 0x00000016,
    styleDisplayMsInlineFlexbox   = 0x00000017,
    styleDisplayMsGrid            = 0x00000018,
    styleDisplayMsInlineGrid      = 0x00000019,
    styleDisplayFlex              = 0x0000001a,
    styleDisplayInlineFlex        = 0x0000001b,
    styleDisplayWebkitBox         = 0x0000001c,
    styleDisplayWebkitInlineBox   = 0x0000001d,
    styleDisplay_Max              = 0x7fffffff,
}

alias styleVisibility = int;
enum : int
{
    styleVisibilityNotSet   = 0x00000000,
    styleVisibilityInherit  = 0x00000001,
    styleVisibilityVisible  = 0x00000002,
    styleVisibilityHidden   = 0x00000003,
    styleVisibilityCollapse = 0x00000004,
    styleVisibility_Max     = 0x7fffffff,
}

alias styleListStyleType = int;
enum : int
{
    styleListStyleTypeNotSet             = 0x00000000,
    styleListStyleTypeDisc               = 0x00000001,
    styleListStyleTypeCircle             = 0x00000002,
    styleListStyleTypeSquare             = 0x00000003,
    styleListStyleTypeDecimal            = 0x00000004,
    styleListStyleTypeLowerRoman         = 0x00000005,
    styleListStyleTypeUpperRoman         = 0x00000006,
    styleListStyleTypeLowerAlpha         = 0x00000007,
    styleListStyleTypeUpperAlpha         = 0x00000008,
    styleListStyleTypeNone               = 0x00000009,
    styleListStyleTypeDecimalLeadingZero = 0x0000000a,
    styleListStyleTypeGeorgian           = 0x0000000b,
    styleListStyleTypeArmenian           = 0x0000000c,
    styleListStyleTypeUpperLatin         = 0x0000000d,
    styleListStyleTypeLowerLatin         = 0x0000000e,
    styleListStyleTypeUpperGreek         = 0x0000000f,
    styleListStyleTypeLowerGreek         = 0x00000010,
    styleListStyleType_Max               = 0x7fffffff,
}

alias styleListStylePosition = int;
enum : int
{
    styleListStylePositionNotSet  = 0x00000000,
    styleListStylePositionInside  = 0x00000001,
    styleListStylePositionOutSide = 0x00000002,
    styleListStylePosition_Max    = 0x7fffffff,
}

alias styleWhiteSpace = int;
enum : int
{
    styleWhiteSpaceNotSet  = 0x00000000,
    styleWhiteSpaceNormal  = 0x00000001,
    styleWhiteSpacePre     = 0x00000002,
    styleWhiteSpaceNowrap  = 0x00000003,
    styleWhiteSpacePreline = 0x00000004,
    styleWhiteSpacePrewrap = 0x00000005,
    styleWhiteSpace_Max    = 0x7fffffff,
}

alias stylePageBreak = int;
enum : int
{
    stylePageBreakNotSet = 0x00000000,
    stylePageBreakAuto   = 0x00000001,
    stylePageBreakAlways = 0x00000002,
    stylePageBreakLeft   = 0x00000003,
    stylePageBreakRight  = 0x00000004,
    stylePageBreakAvoid  = 0x00000005,
    stylePageBreak_Max   = 0x7fffffff,
}

alias stylePageBreakInside = int;
enum : int
{
    stylePageBreakInsideNotSet = 0x00000000,
    stylePageBreakInsideAuto   = 0x00000001,
    stylePageBreakInsideAvoid  = 0x00000002,
    stylePageBreakInside_Max   = 0x7fffffff,
}

alias styleCursor = int;
enum : int
{
    styleCursorAuto          = 0x00000000,
    styleCursorCrosshair     = 0x00000001,
    styleCursorDefault       = 0x00000002,
    styleCursorHand          = 0x00000003,
    styleCursorMove          = 0x00000004,
    styleCursorE_resize      = 0x00000005,
    styleCursorNe_resize     = 0x00000006,
    styleCursorNw_resize     = 0x00000007,
    styleCursorN_resize      = 0x00000008,
    styleCursorSe_resize     = 0x00000009,
    styleCursorSw_resize     = 0x0000000a,
    styleCursorS_resize      = 0x0000000b,
    styleCursorW_resize      = 0x0000000c,
    styleCursorText          = 0x0000000d,
    styleCursorWait          = 0x0000000e,
    styleCursorHelp          = 0x0000000f,
    styleCursorPointer       = 0x00000010,
    styleCursorProgress      = 0x00000011,
    styleCursorNot_allowed   = 0x00000012,
    styleCursorNo_drop       = 0x00000013,
    styleCursorVertical_text = 0x00000014,
    styleCursorall_scroll    = 0x00000015,
    styleCursorcol_resize    = 0x00000016,
    styleCursorrow_resize    = 0x00000017,
    styleCursorNone          = 0x00000018,
    styleCursorContext_menu  = 0x00000019,
    styleCursorEw_resize     = 0x0000001a,
    styleCursorNs_resize     = 0x0000001b,
    styleCursorNesw_resize   = 0x0000001c,
    styleCursorNwse_resize   = 0x0000001d,
    styleCursorCell          = 0x0000001e,
    styleCursorCopy          = 0x0000001f,
    styleCursorAlias         = 0x00000020,
    styleCursorcustom        = 0x00000021,
    styleCursorNotSet        = 0x00000022,
    styleCursor_Max          = 0x7fffffff,
}

alias styleDir = int;
enum : int
{
    styleDirNotSet      = 0x00000000,
    styleDirLeftToRight = 0x00000001,
    styleDirRightToLeft = 0x00000002,
    styleDirInherit     = 0x00000003,
    styleDir_Max        = 0x7fffffff,
}

alias styleBidi = int;
enum : int
{
    styleBidiNotSet   = 0x00000000,
    styleBidiNormal   = 0x00000001,
    styleBidiEmbed    = 0x00000002,
    styleBidiOverride = 0x00000003,
    styleBidiInherit  = 0x00000004,
    styleBidi_Max     = 0x7fffffff,
}

alias styleImeMode = int;
enum : int
{
    styleImeModeAuto     = 0x00000000,
    styleImeModeActive   = 0x00000001,
    styleImeModeInactive = 0x00000002,
    styleImeModeDisabled = 0x00000003,
    styleImeModeNotSet   = 0x00000004,
    styleImeMode_Max     = 0x7fffffff,
}

alias styleRubyAlign = int;
enum : int
{
    styleRubyAlignNotSet           = 0x00000000,
    styleRubyAlignAuto             = 0x00000001,
    styleRubyAlignLeft             = 0x00000002,
    styleRubyAlignCenter           = 0x00000003,
    styleRubyAlignRight            = 0x00000004,
    styleRubyAlignDistributeLetter = 0x00000005,
    styleRubyAlignDistributeSpace  = 0x00000006,
    styleRubyAlignLineEdge         = 0x00000007,
    styleRubyAlign_Max             = 0x7fffffff,
}

alias styleRubyPosition = int;
enum : int
{
    styleRubyPositionNotSet = 0x00000000,
    styleRubyPositionAbove  = 0x00000001,
    styleRubyPositionInline = 0x00000002,
    styleRubyPosition_Max   = 0x7fffffff,
}

alias styleRubyOverhang = int;
enum : int
{
    styleRubyOverhangNotSet     = 0x00000000,
    styleRubyOverhangAuto       = 0x00000001,
    styleRubyOverhangWhitespace = 0x00000002,
    styleRubyOverhangNone       = 0x00000003,
    styleRubyOverhang_Max       = 0x7fffffff,
}

alias styleLayoutGridChar = int;
enum : int
{
    styleLayoutGridCharNotSet = 0x00000000,
    styleLayoutGridCharAuto   = 0x00000001,
    styleLayoutGridCharNone   = 0x00000002,
    styleLayoutGridChar_Max   = 0x7fffffff,
}

alias styleLayoutGridLine = int;
enum : int
{
    styleLayoutGridLineNotSet = 0x00000000,
    styleLayoutGridLineAuto   = 0x00000001,
    styleLayoutGridLineNone   = 0x00000002,
    styleLayoutGridLine_Max   = 0x7fffffff,
}

alias styleLayoutGridMode = int;
enum : int
{
    styleLayoutGridModeNotSet = 0x00000000,
    styleLayoutGridModeChar   = 0x00000001,
    styleLayoutGridModeLine   = 0x00000002,
    styleLayoutGridModeBoth   = 0x00000003,
    styleLayoutGridModeNone   = 0x00000004,
    styleLayoutGridMode_Max   = 0x7fffffff,
}

alias styleLayoutGridType = int;
enum : int
{
    styleLayoutGridTypeNotSet = 0x00000000,
    styleLayoutGridTypeLoose  = 0x00000001,
    styleLayoutGridTypeStrict = 0x00000002,
    styleLayoutGridTypeFixed  = 0x00000003,
    styleLayoutGridType_Max   = 0x7fffffff,
}

alias styleLineBreak = int;
enum : int
{
    styleLineBreakNotSet = 0x00000000,
    styleLineBreakNormal = 0x00000001,
    styleLineBreakStrict = 0x00000002,
    styleLineBreak_Max   = 0x7fffffff,
}

alias styleWordBreak = int;
enum : int
{
    styleWordBreakNotSet   = 0x00000000,
    styleWordBreakNormal   = 0x00000001,
    styleWordBreakBreakAll = 0x00000002,
    styleWordBreakKeepAll  = 0x00000003,
    styleWordBreak_Max     = 0x7fffffff,
}

alias styleWordWrap = int;
enum : int
{
    styleWordWrapNotSet = 0x00000000,
    styleWordWrapOff    = 0x00000001,
    styleWordWrapOn     = 0x00000002,
    styleWordWrap_Max   = 0x7fffffff,
}

alias styleTextJustify = int;
enum : int
{
    styleTextJustifyNotSet             = 0x00000000,
    styleTextJustifyInterWord          = 0x00000001,
    styleTextJustifyNewspaper          = 0x00000002,
    styleTextJustifyDistribute         = 0x00000003,
    styleTextJustifyDistributeAllLines = 0x00000004,
    styleTextJustifyInterIdeograph     = 0x00000005,
    styleTextJustifyInterCluster       = 0x00000006,
    styleTextJustifyKashida            = 0x00000007,
    styleTextJustifyAuto               = 0x00000008,
    styleTextJustify_Max               = 0x7fffffff,
}

alias styleTextAlignLast = int;
enum : int
{
    styleTextAlignLastNotSet  = 0x00000000,
    styleTextAlignLastLeft    = 0x00000001,
    styleTextAlignLastCenter  = 0x00000002,
    styleTextAlignLastRight   = 0x00000003,
    styleTextAlignLastJustify = 0x00000004,
    styleTextAlignLastAuto    = 0x00000005,
    styleTextAlignLast_Max    = 0x7fffffff,
}

alias styleTextJustifyTrim = int;
enum : int
{
    styleTextJustifyTrimNotSet       = 0x00000000,
    styleTextJustifyTrimNone         = 0x00000001,
    styleTextJustifyTrimPunctuation  = 0x00000002,
    styleTextJustifyTrimPunctAndKana = 0x00000003,
    styleTextJustifyTrim_Max         = 0x7fffffff,
}

alias styleAccelerator = int;
enum : int
{
    styleAcceleratorFalse = 0x00000000,
    styleAcceleratorTrue  = 0x00000001,
    styleAccelerator_Max  = 0x7fffffff,
}

alias styleLayoutFlow = int;
enum : int
{
    styleLayoutFlowHorizontal          = 0x00000000,
    styleLayoutFlowVerticalIdeographic = 0x00000001,
    styleLayoutFlowNotSet              = 0x00000002,
    styleLayoutFlow_Max                = 0x7fffffff,
}

alias styleBlockProgression = int;
enum : int
{
    styleBlockProgressionTb     = 0x00000000,
    styleBlockProgressionRl     = 0x00000001,
    styleBlockProgressionBt     = 0x00000002,
    styleBlockProgressionLr     = 0x00000003,
    styleBlockProgressionNotSet = 0x00000004,
    styleBlockProgression_Max   = 0x7fffffff,
}

alias styleWritingMode = int;
enum : int
{
    styleWritingModeLrtb   = 0x00000000,
    styleWritingModeTbrl   = 0x00000001,
    styleWritingModeRltb   = 0x00000002,
    styleWritingModeBtrl   = 0x00000003,
    styleWritingModeNotSet = 0x00000004,
    styleWritingModeTblr   = 0x00000005,
    styleWritingModeBtlr   = 0x00000006,
    styleWritingModeLrbt   = 0x00000007,
    styleWritingModeRlbt   = 0x00000008,
    styleWritingModeLr     = 0x00000009,
    styleWritingModeRl     = 0x0000000a,
    styleWritingModeTb     = 0x0000000b,
    styleWritingMode_Max   = 0x7fffffff,
}

alias styleBool = int;
enum : int
{
    styleBoolFalse = 0x00000000,
    styleBoolTrue  = 0x00000001,
    styleBool_Max  = 0x7fffffff,
}

alias styleTextUnderlinePosition = int;
enum : int
{
    styleTextUnderlinePositionBelow  = 0x00000000,
    styleTextUnderlinePositionAbove  = 0x00000001,
    styleTextUnderlinePositionAuto   = 0x00000002,
    styleTextUnderlinePositionNotSet = 0x00000003,
    styleTextUnderlinePosition_Max   = 0x7fffffff,
}

alias styleTextOverflow = int;
enum : int
{
    styleTextOverflowClip     = 0x00000000,
    styleTextOverflowEllipsis = 0x00000001,
    styleTextOverflowNotSet   = 0x00000002,
    styleTextOverflow_Max     = 0x7fffffff,
}

alias styleInterpolation = int;
enum : int
{
    styleInterpolationNotSet = 0x00000000,
    styleInterpolationNN     = 0x00000001,
    styleInterpolationBCH    = 0x00000002,
    styleInterpolation_Max   = 0x7fffffff,
}

alias styleBoxSizing = int;
enum : int
{
    styleBoxSizingNotSet     = 0x00000000,
    styleBoxSizingContentBox = 0x00000001,
    styleBoxSizingBorderBox  = 0x00000002,
    styleBoxSizing_Max       = 0x7fffffff,
}

alias styleFlex = int;
enum : int
{
    styleFlexNone   = 0x00000000,
    styleFlexNotSet = 0x00000001,
    styleFlex_Max   = 0x7fffffff,
}

alias styleFlexBasis = int;
enum : int
{
    styleFlexBasisAuto   = 0x00000000,
    styleFlexBasisNotSet = 0x00000001,
    styleFlexBasis_Max   = 0x7fffffff,
}

alias styleFlexDirection = int;
enum : int
{
    styleFlexDirectionRow           = 0x00000000,
    styleFlexDirectionRowReverse    = 0x00000001,
    styleFlexDirectionColumn        = 0x00000002,
    styleFlexDirectionColumnReverse = 0x00000003,
    styleFlexDirectionNotSet        = 0x00000004,
    styleFlexDirection_Max          = 0x7fffffff,
}

alias styleWebkitBoxOrient = int;
enum : int
{
    styleWebkitBoxOrientHorizontal = 0x00000000,
    styleWebkitBoxOrientInlineAxis = 0x00000001,
    styleWebkitBoxOrientVertical   = 0x00000002,
    styleWebkitBoxOrientBlockAxis  = 0x00000003,
    styleWebkitBoxOrientNotSet     = 0x00000004,
    styleWebkitBoxOrient_Max       = 0x7fffffff,
}

alias styleWebkitBoxDirection = int;
enum : int
{
    styleWebkitBoxDirectionNormal  = 0x00000000,
    styleWebkitBoxDirectionReverse = 0x00000001,
    styleWebkitBoxDirectionNotSet  = 0x00000002,
    styleWebkitBoxDirection_Max    = 0x7fffffff,
}

alias styleFlexWrap = int;
enum : int
{
    styleFlexWrapNowrap      = 0x00000000,
    styleFlexWrapWrap        = 0x00000001,
    styleFlexWrapWrapReverse = 0x00000002,
    styleFlexWrapNotSet      = 0x00000003,
    styleFlexWrap_Max        = 0x7fffffff,
}

alias styleAlignItems = int;
enum : int
{
    styleAlignItemsFlexStart = 0x00000000,
    styleAlignItemsFlexEnd   = 0x00000001,
    styleAlignItemsCenter    = 0x00000002,
    styleAlignItemsBaseline  = 0x00000003,
    styleAlignItemsStretch   = 0x00000004,
    styleAlignItemsNotSet    = 0x00000005,
    styleAlignItems_Max      = 0x7fffffff,
}

alias styleMsFlexAlign = int;
enum : int
{
    styleMsFlexAlignStart    = 0x00000000,
    styleMsFlexAlignEnd      = 0x00000001,
    styleMsFlexAlignCenter   = 0x00000002,
    styleMsFlexAlignBaseline = 0x00000003,
    styleMsFlexAlignStretch  = 0x00000004,
    styleMsFlexAlignNotSet   = 0x00000005,
    styleMsFlexAlign_Max     = 0x7fffffff,
}

alias styleMsFlexItemAlign = int;
enum : int
{
    styleMsFlexItemAlignStart    = 0x00000000,
    styleMsFlexItemAlignEnd      = 0x00000001,
    styleMsFlexItemAlignCenter   = 0x00000002,
    styleMsFlexItemAlignBaseline = 0x00000003,
    styleMsFlexItemAlignStretch  = 0x00000004,
    styleMsFlexItemAlignAuto     = 0x00000005,
    styleMsFlexItemAlignNotSet   = 0x00000006,
    styleMsFlexItemAlign_Max     = 0x7fffffff,
}

alias styleAlignSelf = int;
enum : int
{
    styleAlignSelfFlexStart = 0x00000000,
    styleAlignSelfFlexEnd   = 0x00000001,
    styleAlignSelfCenter    = 0x00000002,
    styleAlignSelfBaseline  = 0x00000003,
    styleAlignSelfStretch   = 0x00000004,
    styleAlignSelfAuto      = 0x00000005,
    styleAlignSelfNotSet    = 0x00000006,
    styleAlignSelf_Max      = 0x7fffffff,
}

alias styleJustifyContent = int;
enum : int
{
    styleJustifyContentFlexStart    = 0x00000000,
    styleJustifyContentFlexEnd      = 0x00000001,
    styleJustifyContentCenter       = 0x00000002,
    styleJustifyContentSpaceBetween = 0x00000003,
    styleJustifyContentSpaceAround  = 0x00000004,
    styleJustifyContentNotSet       = 0x00000005,
    styleJustifyContent_Max         = 0x7fffffff,
}

alias styleMsFlexPack = int;
enum : int
{
    styleMsFlexPackStart      = 0x00000000,
    styleMsFlexPackEnd        = 0x00000001,
    styleMsFlexPackCenter     = 0x00000002,
    styleMsFlexPackJustify    = 0x00000003,
    styleMsFlexPackDistribute = 0x00000004,
    styleMsFlexPackNotSet     = 0x00000005,
    styleMsFlexPack_Max       = 0x7fffffff,
}

alias styleWebkitBoxPack = int;
enum : int
{
    styleWebkitBoxPackStart   = 0x00000000,
    styleWebkitBoxPackEnd     = 0x00000001,
    styleWebkitBoxPackCenter  = 0x00000002,
    styleWebkitBoxPackJustify = 0x00000003,
    styleWebkitBoxPackNotSet  = 0x00000005,
    styleWebkitBoxPack_Max    = 0x7fffffff,
}

alias styleMsFlexLinePack = int;
enum : int
{
    styleMsFlexLinePackStart      = 0x00000000,
    styleMsFlexLinePackEnd        = 0x00000001,
    styleMsFlexLinePackCenter     = 0x00000002,
    styleMsFlexLinePackJustify    = 0x00000003,
    styleMsFlexLinePackDistribute = 0x00000004,
    styleMsFlexLinePackStretch    = 0x00000005,
    styleMsFlexLinePackNotSet     = 0x00000006,
    styleMsFlexLinePack_Max       = 0x7fffffff,
}

alias styleAlignContent = int;
enum : int
{
    styleAlignContentFlexStart    = 0x00000000,
    styleAlignContentFlexEnd      = 0x00000001,
    styleAlignContentCenter       = 0x00000002,
    styleAlignContentSpaceBetween = 0x00000003,
    styleAlignContentSpaceAround  = 0x00000004,
    styleAlignContentStretch      = 0x00000005,
    styleAlignContentNotSet       = 0x00000006,
    styleAlignContent_Max         = 0x7fffffff,
}

alias styleColumnFill = int;
enum : int
{
    styleColumnFillAuto    = 0x00000000,
    styleColumnFillBalance = 0x00000001,
    styleColumnFillNotSet  = 0x00000002,
    styleColumnFill_Max    = 0x7fffffff,
}

alias styleColumnSpan = int;
enum : int
{
    styleColumnSpanNone   = 0x00000000,
    styleColumnSpanAll    = 0x00000001,
    styleColumnSpanOne    = 0x00000002,
    styleColumnSpanNotSet = 0x00000003,
    styleColumnSpan_Max   = 0x7fffffff,
}

alias styleBreak = int;
enum : int
{
    styleBreakNotSet      = 0x00000000,
    styleBreakAuto        = 0x00000001,
    styleBreakAlways      = 0x00000002,
    styleBreakAvoid       = 0x00000003,
    styleBreakLeft        = 0x00000004,
    styleBreakRight       = 0x00000005,
    styleBreakPage        = 0x00000006,
    styleBreakColumn      = 0x00000007,
    styleBreakAvoidPage   = 0x00000008,
    styleBreakAvoidColumn = 0x00000009,
    styleBreak_Max        = 0x7fffffff,
}

alias styleBreakInside = int;
enum : int
{
    styleBreakInsideNotSet      = 0x00000000,
    styleBreakInsideAuto        = 0x00000001,
    styleBreakInsideAvoid       = 0x00000002,
    styleBreakInsideAvoidPage   = 0x00000003,
    styleBreakInsideAvoidColumn = 0x00000004,
    styleBreakInside_Max        = 0x7fffffff,
}

alias styleMsScrollChaining = int;
enum : int
{
    styleMsScrollChainingNotSet  = 0x00000000,
    styleMsScrollChainingNone    = 0x00000001,
    styleMsScrollChainingChained = 0x00000002,
    styleMsScrollChaining_Max    = 0x7fffffff,
}

alias styleMsContentZooming = int;
enum : int
{
    styleMsContentZoomingNotSet = 0x00000000,
    styleMsContentZoomingNone   = 0x00000001,
    styleMsContentZoomingZoom   = 0x00000002,
    styleMsContentZooming_Max   = 0x7fffffff,
}

alias styleMsContentZoomSnapType = int;
enum : int
{
    styleMsContentZoomSnapTypeNotSet    = 0x00000000,
    styleMsContentZoomSnapTypeNone      = 0x00000001,
    styleMsContentZoomSnapTypeMandatory = 0x00000002,
    styleMsContentZoomSnapTypeProximity = 0x00000003,
    styleMsContentZoomSnapType_Max      = 0x7fffffff,
}

alias styleMsScrollRails = int;
enum : int
{
    styleMsScrollRailsNotSet = 0x00000000,
    styleMsScrollRailsNone   = 0x00000001,
    styleMsScrollRailsRailed = 0x00000002,
    styleMsScrollRails_Max   = 0x7fffffff,
}

alias styleMsContentZoomChaining = int;
enum : int
{
    styleMsContentZoomChainingNotSet  = 0x00000000,
    styleMsContentZoomChainingNone    = 0x00000001,
    styleMsContentZoomChainingChained = 0x00000002,
    styleMsContentZoomChaining_Max    = 0x7fffffff,
}

alias styleMsScrollSnapType = int;
enum : int
{
    styleMsScrollSnapTypeNotSet    = 0x00000000,
    styleMsScrollSnapTypeNone      = 0x00000001,
    styleMsScrollSnapTypeMandatory = 0x00000002,
    styleMsScrollSnapTypeProximity = 0x00000003,
    styleMsScrollSnapType_Max      = 0x7fffffff,
}

alias styleGridColumn = int;
enum : int
{
    styleGridColumnNotSet = 0x00000000,
    styleGridColumn_Max   = 0x7fffffff,
}

alias styleGridColumnAlign = int;
enum : int
{
    styleGridColumnAlignCenter  = 0x00000000,
    styleGridColumnAlignEnd     = 0x00000001,
    styleGridColumnAlignStart   = 0x00000002,
    styleGridColumnAlignStretch = 0x00000003,
    styleGridColumnAlignNotSet  = 0x00000004,
    styleGridColumnAlign_Max    = 0x7fffffff,
}

alias styleGridColumnSpan = int;
enum : int
{
    styleGridColumnSpanNotSet = 0x00000000,
    styleGridColumnSpan_Max   = 0x7fffffff,
}

alias styleGridRow = int;
enum : int
{
    styleGridRowNotSet = 0x00000000,
    styleGridRow_Max   = 0x7fffffff,
}

alias styleGridRowAlign = int;
enum : int
{
    styleGridRowAlignCenter  = 0x00000000,
    styleGridRowAlignEnd     = 0x00000001,
    styleGridRowAlignStart   = 0x00000002,
    styleGridRowAlignStretch = 0x00000003,
    styleGridRowAlignNotSet  = 0x00000004,
    styleGridRowAlign_Max    = 0x7fffffff,
}

alias styleGridRowSpan = int;
enum : int
{
    styleGridRowSpanNotSet = 0x00000000,
    styleGridRowSpan_Max   = 0x7fffffff,
}

alias styleWrapThrough = int;
enum : int
{
    styleWrapThroughNotSet = 0x00000000,
    styleWrapThroughWrap   = 0x00000001,
    styleWrapThroughNone   = 0x00000002,
    styleWrapThrough_Max   = 0x7fffffff,
}

alias styleWrapFlow = int;
enum : int
{
    styleWrapFlowNotSet  = 0x00000000,
    styleWrapFlowAuto    = 0x00000001,
    styleWrapFlowBoth    = 0x00000002,
    styleWrapFlowStart   = 0x00000003,
    styleWrapFlowEnd     = 0x00000004,
    styleWrapFlowClear   = 0x00000005,
    styleWrapFlowMinimum = 0x00000006,
    styleWrapFlowMaximum = 0x00000007,
    styleWrapFlow_Max    = 0x7fffffff,
}

alias styleAlignmentBaseline = int;
enum : int
{
    styleAlignmentBaselineNotSet         = 0x00000000,
    styleAlignmentBaselineAfterEdge      = 0x00000001,
    styleAlignmentBaselineAlphabetic     = 0x00000002,
    styleAlignmentBaselineAuto           = 0x00000003,
    styleAlignmentBaselineBaseline       = 0x00000004,
    styleAlignmentBaselineBeforeEdge     = 0x00000005,
    styleAlignmentBaselineCentral        = 0x00000006,
    styleAlignmentBaselineHanging        = 0x00000007,
    styleAlignmentBaselineMathematical   = 0x00000008,
    styleAlignmentBaselineMiddle         = 0x00000009,
    styleAlignmentBaselineTextAfterEdge  = 0x0000000a,
    styleAlignmentBaselineTextBeforeEdge = 0x0000000b,
    styleAlignmentBaselineIdeographic    = 0x0000000c,
    styleAlignmentBaseline_Max           = 0x7fffffff,
}

alias styleBaselineShift = int;
enum : int
{
    styleBaselineShiftBaseline = 0x00000000,
    styleBaselineShiftSub      = 0x00000001,
    styleBaselineShiftSuper    = 0x00000002,
    styleBaselineShift_Max     = 0x7fffffff,
}

alias styleClipRule = int;
enum : int
{
    styleClipRuleNotSet  = 0x00000000,
    styleClipRuleNonZero = 0x00000001,
    styleClipRuleEvenOdd = 0x00000002,
    styleClipRule_Max    = 0x7fffffff,
}

alias styleDominantBaseline = int;
enum : int
{
    styleDominantBaselineNotSet         = 0x00000000,
    styleDominantBaselineAlphabetic     = 0x00000001,
    styleDominantBaselineAuto           = 0x00000002,
    styleDominantBaselineCentral        = 0x00000003,
    styleDominantBaselineHanging        = 0x00000004,
    styleDominantBaselineIdeographic    = 0x00000005,
    styleDominantBaselineMathematical   = 0x00000006,
    styleDominantBaselineMiddle         = 0x00000007,
    styleDominantBaselineNoChange       = 0x00000008,
    styleDominantBaselineResetSize      = 0x00000009,
    styleDominantBaselineTextAfterEdge  = 0x0000000a,
    styleDominantBaselineTextBeforeEdge = 0x0000000b,
    styleDominantBaselineUseScript      = 0x0000000c,
    styleDominantBaseline_Max           = 0x7fffffff,
}

alias styleFillRule = int;
enum : int
{
    styleFillRuleNotSet  = 0x00000000,
    styleFillRuleNonZero = 0x00000001,
    styleFillRuleEvenOdd = 0x00000002,
    styleFillRule_Max    = 0x7fffffff,
}

alias styleFontStretch = int;
enum : int
{
    styleFontStretchNotSet         = 0x00000000,
    styleFontStretchWider          = 0x00000001,
    styleFontStretchNarrower       = 0x00000002,
    styleFontStretchUltraCondensed = 0x00000003,
    styleFontStretchExtraCondensed = 0x00000004,
    styleFontStretchCondensed      = 0x00000005,
    styleFontStretchSemiCondensed  = 0x00000006,
    styleFontStretchNormal         = 0x00000007,
    styleFontStretchSemiExpanded   = 0x00000008,
    styleFontStretchExpanded       = 0x00000009,
    styleFontStretchExtraExpanded  = 0x0000000a,
    styleFontStretchUltraExpanded  = 0x0000000b,
    styleFontStretch_Max           = 0x7fffffff,
}

alias stylePointerEvents = int;
enum : int
{
    stylePointerEventsNotSet         = 0x00000000,
    stylePointerEventsVisiblePainted = 0x00000001,
    stylePointerEventsVisibleFill    = 0x00000002,
    stylePointerEventsVisibleStroke  = 0x00000003,
    stylePointerEventsVisible        = 0x00000004,
    stylePointerEventsPainted        = 0x00000005,
    stylePointerEventsFill           = 0x00000006,
    stylePointerEventsStroke         = 0x00000007,
    stylePointerEventsAll            = 0x00000008,
    stylePointerEventsNone           = 0x00000009,
    stylePointerEventsInitial        = 0x0000000a,
    stylePointerEventsAuto           = 0x0000000b,
    stylePointerEvents_Max           = 0x7fffffff,
}

alias styleEnableBackground = int;
enum : int
{
    styleEnableBackgroundNotSet     = 0x00000000,
    styleEnableBackgroundAccumulate = 0x00000001,
    styleEnableBackgroundNew        = 0x00000002,
    styleEnableBackgroundInherit    = 0x00000003,
    styleEnableBackground_Max       = 0x7fffffff,
}

alias styleStrokeLinecap = int;
enum : int
{
    styleStrokeLinecapNotSet = 0x00000000,
    styleStrokeLinecapButt   = 0x00000001,
    styleStrokeLinecapRound  = 0x00000002,
    styleStrokeLinecapSquare = 0x00000003,
    styleStrokeLinecap_Max   = 0x7fffffff,
}

alias styleStrokeLinejoin = int;
enum : int
{
    styleStrokeLinejoinNotSet = 0x00000000,
    styleStrokeLinejoinMiter  = 0x00000001,
    styleStrokeLinejoinRound  = 0x00000002,
    styleStrokeLinejoinBevel  = 0x00000003,
    styleStrokeLinejoin_Max   = 0x7fffffff,
}

alias styleTextAnchor = int;
enum : int
{
    styleTextAnchorNotSet = 0x00000000,
    styleTextAnchorStart  = 0x00000001,
    styleTextAnchorMiddle = 0x00000002,
    styleTextAnchorEnd    = 0x00000003,
    styleTextAnchor_Max   = 0x7fffffff,
}

alias styleAttrType = int;
enum : int
{
    styleAttrTypeString     = 0x00000000,
    styleAttrTypeColor      = 0x00000001,
    styleAttrTypeUrl        = 0x00000002,
    styleAttrTypeInteger    = 0x00000003,
    styleAttrTypeNumber     = 0x00000004,
    styleAttrTypeLength     = 0x00000005,
    styleAttrTypePx         = 0x00000006,
    styleAttrTypeEm         = 0x00000007,
    styleAttrTypeEx         = 0x00000008,
    styleAttrTypeIn         = 0x00000009,
    styleAttrTypeCm         = 0x0000000a,
    styleAttrTypeMm         = 0x0000000b,
    styleAttrTypePt         = 0x0000000c,
    styleAttrTypePc         = 0x0000000d,
    styleAttrTypeRem        = 0x0000000e,
    styleAttrTypeCh         = 0x0000000f,
    styleAttrTypeVh         = 0x00000010,
    styleAttrTypeVw         = 0x00000011,
    styleAttrTypeVmin       = 0x00000012,
    styleAttrTypePercentage = 0x00000013,
    styleAttrTypeAngle      = 0x00000014,
    styleAttrTypeDeg        = 0x00000015,
    styleAttrTypeRad        = 0x00000016,
    styleAttrTypeGrad       = 0x00000017,
    styleAttrTypeTime       = 0x00000018,
    styleAttrTypeS          = 0x00000019,
    styleAttrTypeMs         = 0x0000001a,
    styleAttrType_Max       = 0x7fffffff,
}

alias styleInitialColor = int;
enum : int
{
    styleInitialColorNoInitial     = 0x00000000,
    styleInitialColorColorProperty = 0x00000001,
    styleInitialColorTransparent   = 0x00000002,
    styleInitialColorInvert        = 0x00000003,
    styleInitialColor_Max          = 0x7fffffff,
}

alias styleInitialString = int;
enum : int
{
    styleInitialStringNoInitial = 0x00000000,
    styleInitialStringNone      = 0x00000001,
    styleInitialStringAuto      = 0x00000002,
    styleInitialStringNormal    = 0x00000003,
    styleInitialString_Max      = 0x7fffffff,
}

alias styleTransformOriginX = int;
enum : int
{
    styleTransformOriginXNotSet = 0x00000000,
    styleTransformOriginXLeft   = 0x00000001,
    styleTransformOriginXCenter = 0x00000002,
    styleTransformOriginXRight  = 0x00000003,
    styleTransformOriginX_Max   = 0x7fffffff,
}

alias styleTransformOriginY = int;
enum : int
{
    styleTransformOriginYNotSet = 0x00000000,
    styleTransformOriginYTop    = 0x00000001,
    styleTransformOriginYCenter = 0x00000002,
    styleTransformOriginYBottom = 0x00000003,
    styleTransformOriginY_Max   = 0x7fffffff,
}

alias stylePerspectiveOriginX = int;
enum : int
{
    stylePerspectiveOriginXNotSet = 0x00000000,
    stylePerspectiveOriginXLeft   = 0x00000001,
    stylePerspectiveOriginXCenter = 0x00000002,
    stylePerspectiveOriginXRight  = 0x00000003,
    stylePerspectiveOriginX_Max   = 0x7fffffff,
}

alias stylePerspectiveOriginY = int;
enum : int
{
    stylePerspectiveOriginYNotSet = 0x00000000,
    stylePerspectiveOriginYTop    = 0x00000001,
    stylePerspectiveOriginYCenter = 0x00000002,
    stylePerspectiveOriginYBottom = 0x00000003,
    stylePerspectiveOriginY_Max   = 0x7fffffff,
}

alias styleTransformStyle = int;
enum : int
{
    styleTransformStyleFlat       = 0x00000000,
    styleTransformStylePreserve3D = 0x00000001,
    styleTransformStyleNotSet     = 0x00000002,
    styleTransformStyle_Max       = 0x7fffffff,
}

alias styleBackfaceVisibility = int;
enum : int
{
    styleBackfaceVisibilityVisible = 0x00000000,
    styleBackfaceVisibilityHidden  = 0x00000001,
    styleBackfaceVisibilityNotSet  = 0x00000002,
    styleBackfaceVisibility_Max    = 0x7fffffff,
}

alias styleTextSizeAdjust = int;
enum : int
{
    styleTextSizeAdjustNone = 0x00000000,
    styleTextSizeAdjustAuto = 0x00000001,
    styleTextSizeAdjust_Max = 0x7fffffff,
}

alias styleColorInterpolationFilters = int;
enum : int
{
    styleColorInterpolationFiltersAuto      = 0x00000000,
    styleColorInterpolationFiltersSRgb      = 0x00000001,
    styleColorInterpolationFiltersLinearRgb = 0x00000002,
    styleColorInterpolationFiltersNotSet    = 0x00000003,
    styleColorInterpolationFilters_Max      = 0x7fffffff,
}

alias styleHyphens = int;
enum : int
{
    styleHyphensNone   = 0x00000000,
    styleHyphensManual = 0x00000001,
    styleHyphensAuto   = 0x00000002,
    styleHyphensNotSet = 0x00000003,
    styleHyphens_Max   = 0x7fffffff,
}

alias styleHyphenateLimitLines = int;
enum : int
{
    styleHyphenateLimitLinesNoLimit = 0x00000000,
    styleHyphenateLimitLines_Max    = 0x7fffffff,
}

alias styleMsAnimationPlayState = int;
enum : int
{
    styleMsAnimationPlayStateRunning = 0x00000000,
    styleMsAnimationPlayStatePaused  = 0x00000001,
    styleMsAnimationPlayStateNotSet  = 0x00000002,
    styleMsAnimationPlayState_Max    = 0x7fffffff,
}

alias styleMsAnimationDirection = int;
enum : int
{
    styleMsAnimationDirectionNormal           = 0x00000000,
    styleMsAnimationDirectionAlternate        = 0x00000001,
    styleMsAnimationDirectionReverse          = 0x00000002,
    styleMsAnimationDirectionAlternateReverse = 0x00000003,
    styleMsAnimationDirectionNotSet           = 0x00000004,
    styleMsAnimationDirection_Max             = 0x7fffffff,
}

alias styleMsAnimationFillMode = int;
enum : int
{
    styleMsAnimationFillModeNone      = 0x00000000,
    styleMsAnimationFillModeForwards  = 0x00000001,
    styleMsAnimationFillModeBackwards = 0x00000002,
    styleMsAnimationFillModeBoth      = 0x00000003,
    styleMsAnimationFillModeNotSet    = 0x00000004,
    styleMsAnimationFillMode_Max      = 0x7fffffff,
}

alias styleMsHighContrastAdjust = int;
enum : int
{
    styleMsHighContrastAdjustNotSet = 0x00000000,
    styleMsHighContrastAdjustAuto   = 0x00000001,
    styleMsHighContrastAdjustNone   = 0x00000002,
    styleMsHighContrastAdjust_Max   = 0x7fffffff,
}

alias styleMsUserSelect = int;
enum : int
{
    styleMsUserSelectAuto    = 0x00000000,
    styleMsUserSelectText    = 0x00000001,
    styleMsUserSelectElement = 0x00000002,
    styleMsUserSelectNone    = 0x00000003,
    styleMsUserSelectNotSet  = 0x00000004,
    styleMsUserSelect_Max    = 0x7fffffff,
}

alias styleMsTouchAction = int;
enum : int
{
    styleMsTouchActionNotSet        = 0xffffffff,
    styleMsTouchActionNone          = 0x00000000,
    styleMsTouchActionAuto          = 0x00000001,
    styleMsTouchActionManipulation  = 0x00000002,
    styleMsTouchActionDoubleTapZoom = 0x00000004,
    styleMsTouchActionPanX          = 0x00000008,
    styleMsTouchActionPanY          = 0x00000010,
    styleMsTouchActionPinchZoom     = 0x00000020,
    styleMsTouchActionCrossSlideX   = 0x00000040,
    styleMsTouchActionCrossSlideY   = 0x00000080,
    styleMsTouchAction_Max          = 0x7fffffff,
}

alias styleMsTouchSelect = int;
enum : int
{
    styleMsTouchSelectGrippers = 0x00000000,
    styleMsTouchSelectNone     = 0x00000001,
    styleMsTouchSelectNotSet   = 0x00000002,
    styleMsTouchSelect_Max     = 0x7fffffff,
}

alias styleMsScrollTranslation = int;
enum : int
{
    styleMsScrollTranslationNotSet = 0x00000000,
    styleMsScrollTranslationNone   = 0x00000001,
    styleMsScrollTranslationVtoH   = 0x00000002,
    styleMsScrollTranslation_Max   = 0x7fffffff,
}

alias styleBorderImageRepeat = int;
enum : int
{
    styleBorderImageRepeatStretch = 0x00000000,
    styleBorderImageRepeatRepeat  = 0x00000001,
    styleBorderImageRepeatRound   = 0x00000002,
    styleBorderImageRepeatSpace   = 0x00000003,
    styleBorderImageRepeatNotSet  = 0x00000004,
    styleBorderImageRepeat_Max    = 0x7fffffff,
}

alias styleBorderImageSliceFill = int;
enum : int
{
    styleBorderImageSliceFillNotSet = 0x00000000,
    styleBorderImageSliceFillFill   = 0x00000001,
    styleBorderImageSliceFill_Max   = 0x7fffffff,
}

alias styleMsImeAlign = int;
enum : int
{
    styleMsImeAlignAuto   = 0x00000000,
    styleMsImeAlignAfter  = 0x00000001,
    styleMsImeAlignNotSet = 0x00000002,
    styleMsImeAlign_Max   = 0x7fffffff,
}

alias styleMsTextCombineHorizontal = int;
enum : int
{
    styleMsTextCombineHorizontalNone   = 0x00000000,
    styleMsTextCombineHorizontalAll    = 0x00000001,
    styleMsTextCombineHorizontalDigits = 0x00000002,
    styleMsTextCombineHorizontalNotSet = 0x00000003,
    styleMsTextCombineHorizontal_Max   = 0x7fffffff,
}

alias styleWebkitAppearance = int;
enum : int
{
    styleWebkitAppearanceNone                         = 0x00000000,
    styleWebkitAppearanceCapsLockIndicator            = 0x00000001,
    styleWebkitAppearanceButton                       = 0x00000002,
    styleWebkitAppearanceButtonBevel                  = 0x00000003,
    styleWebkitAppearanceCaret                        = 0x00000004,
    styleWebkitAppearanceCheckbox                     = 0x00000005,
    styleWebkitAppearanceDefaultButton                = 0x00000006,
    styleWebkitAppearanceListbox                      = 0x00000007,
    styleWebkitAppearanceListitem                     = 0x00000008,
    styleWebkitAppearanceMediaFullscreenButton        = 0x00000009,
    styleWebkitAppearanceMediaMuteButton              = 0x0000000a,
    styleWebkitAppearanceMediaPlayButton              = 0x0000000b,
    styleWebkitAppearanceMediaSeekBackButton          = 0x0000000c,
    styleWebkitAppearanceMediaSeekForwardButton       = 0x0000000d,
    styleWebkitAppearanceMediaSlider                  = 0x0000000e,
    styleWebkitAppearanceMediaSliderthumb             = 0x0000000f,
    styleWebkitAppearanceMenulist                     = 0x00000010,
    styleWebkitAppearanceMenulistButton               = 0x00000011,
    styleWebkitAppearanceMenulistText                 = 0x00000012,
    styleWebkitAppearanceMenulistTextfield            = 0x00000013,
    styleWebkitAppearancePushButton                   = 0x00000014,
    styleWebkitAppearanceRadio                        = 0x00000015,
    styleWebkitAppearanceSearchfield                  = 0x00000016,
    styleWebkitAppearanceSearchfieldCancelButton      = 0x00000017,
    styleWebkitAppearanceSearchfieldDecoration        = 0x00000018,
    styleWebkitAppearanceSearchfieldResultsButton     = 0x00000019,
    styleWebkitAppearanceSearchfieldResultsDecoration = 0x0000001a,
    styleWebkitAppearanceSliderHorizontal             = 0x0000001b,
    styleWebkitAppearanceSliderVertical               = 0x0000001c,
    styleWebkitAppearanceSliderthumbHorizontal        = 0x0000001d,
    styleWebkitAppearanceSliderthumbVertical          = 0x0000001e,
    styleWebkitAppearanceSquareButton                 = 0x0000001f,
    styleWebkitAppearanceTextarea                     = 0x00000020,
    styleWebkitAppearanceTextfield                    = 0x00000021,
    styleWebkitAppearanceNotSet                       = 0x00000022,
    styleWebkitAppearance_Max                         = 0x7fffffff,
}

alias styleViewportSize = int;
enum : int
{
    styleViewportSizeAuto         = 0x00000000,
    styleViewportSizeDeviceWidth  = 0x00000001,
    styleViewportSizeDeviceHeight = 0x00000002,
    styleViewportSize_Max         = 0x7fffffff,
}

alias styleUserZoom = int;
enum : int
{
    styleUserZoomNotSet = 0x00000000,
    styleUserZoomZoom   = 0x00000001,
    styleUserZoomFixed  = 0x00000002,
    styleUserZoom_Max   = 0x7fffffff,
}

alias styleTextLineThroughStyle = int;
enum : int
{
    styleTextLineThroughStyleUndefined = 0x00000000,
    styleTextLineThroughStyleSingle    = 0x00000001,
    styleTextLineThroughStyleDouble    = 0x00000002,
    styleTextLineThroughStyle_Max      = 0x7fffffff,
}

alias styleTextUnderlineStyle = int;
enum : int
{
    styleTextUnderlineStyleUndefined        = 0x00000000,
    styleTextUnderlineStyleSingle           = 0x00000001,
    styleTextUnderlineStyleDouble           = 0x00000002,
    styleTextUnderlineStyleWords            = 0x00000003,
    styleTextUnderlineStyleDotted           = 0x00000004,
    styleTextUnderlineStyleThick            = 0x00000005,
    styleTextUnderlineStyleDash             = 0x00000006,
    styleTextUnderlineStyleDotDash          = 0x00000007,
    styleTextUnderlineStyleDotDotDash       = 0x00000008,
    styleTextUnderlineStyleWave             = 0x00000009,
    styleTextUnderlineStyleSingleAccounting = 0x0000000a,
    styleTextUnderlineStyleDoubleAccounting = 0x0000000b,
    styleTextUnderlineStyleThickDash        = 0x0000000c,
    styleTextUnderlineStyle_Max             = 0x7fffffff,
}

alias styleTextEffect = int;
enum : int
{
    styleTextEffectNone    = 0x00000000,
    styleTextEffectEmboss  = 0x00000001,
    styleTextEffectEngrave = 0x00000002,
    styleTextEffectOutline = 0x00000003,
    styleTextEffect_Max    = 0x7fffffff,
}

alias styleDefaultTextSelection = int;
enum : int
{
    styleDefaultTextSelectionFalse = 0x00000000,
    styleDefaultTextSelectionTrue  = 0x00000001,
    styleDefaultTextSelection_Max  = 0x7fffffff,
}

alias styleTextDecoration = int;
enum : int
{
    styleTextDecorationNone        = 0x00000000,
    styleTextDecorationUnderline   = 0x00000001,
    styleTextDecorationOverline    = 0x00000002,
    styleTextDecorationLineThrough = 0x00000003,
    styleTextDecorationBlink       = 0x00000004,
    styleTextDecoration_Max        = 0x7fffffff,
}

alias textDecoration = int;
enum : int
{
    textDecorationNone        = 0x00000000,
    textDecorationUnderline   = 0x00000001,
    textDecorationOverline    = 0x00000002,
    textDecorationLineThrough = 0x00000003,
    textDecorationBlink       = 0x00000004,
    textDecoration_Max        = 0x7fffffff,
}

alias htmlListType = int;
enum : int
{
    htmlListTypeNotSet     = 0x00000000,
    htmlListTypeLargeAlpha = 0x00000001,
    htmlListTypeSmallAlpha = 0x00000002,
    htmlListTypeLargeRoman = 0x00000003,
    htmlListTypeSmallRoman = 0x00000004,
    htmlListTypeNumbers    = 0x00000005,
    htmlListTypeDisc       = 0x00000006,
    htmlListTypeCircle     = 0x00000007,
    htmlListTypeSquare     = 0x00000008,
    htmlListType_Max       = 0x7fffffff,
}

alias htmlMethod = int;
enum : int
{
    htmlMethodNotSet = 0x00000000,
    htmlMethodGet    = 0x00000001,
    htmlMethodPost   = 0x00000002,
    htmlMethod_Max   = 0x7fffffff,
}

alias htmlWrap = int;
enum : int
{
    htmlWrapOff  = 0x00000001,
    htmlWrapSoft = 0x00000002,
    htmlWrapHard = 0x00000003,
    htmlWrap_Max = 0x7fffffff,
}

alias htmlDir = int;
enum : int
{
    htmlDirNotSet      = 0x00000000,
    htmlDirLeftToRight = 0x00000001,
    htmlDirRightToLeft = 0x00000002,
    htmlDir_Max        = 0x7fffffff,
}

alias htmlEditable = int;
enum : int
{
    htmlEditableInherit = 0x00000000,
    htmlEditableTrue    = 0x00000001,
    htmlEditableFalse   = 0x00000002,
    htmlEditable_Max    = 0x7fffffff,
}

alias htmlInput = int;
enum : int
{
    htmlInputNotSet         = 0x00000000,
    htmlInputButton         = 0x00000001,
    htmlInputCheckbox       = 0x00000002,
    htmlInputFile           = 0x00000003,
    htmlInputHidden         = 0x00000004,
    htmlInputImage          = 0x00000005,
    htmlInputPassword       = 0x00000006,
    htmlInputRadio          = 0x00000007,
    htmlInputReset          = 0x00000008,
    htmlInputSelectOne      = 0x00000009,
    htmlInputSelectMultiple = 0x0000000a,
    htmlInputSubmit         = 0x0000000b,
    htmlInputText           = 0x0000000c,
    htmlInputTextarea       = 0x0000000d,
    htmlInputRichtext       = 0x0000000e,
    htmlInputRange          = 0x0000000f,
    htmlInputUrl            = 0x00000010,
    htmlInputEmail          = 0x00000011,
    htmlInputNumber         = 0x00000012,
    htmlInputTel            = 0x00000013,
    htmlInputSearch         = 0x00000014,
    htmlInput_Max           = 0x7fffffff,
}

alias htmlSpellCheck = int;
enum : int
{
    htmlSpellCheckNotSet  = 0x00000000,
    htmlSpellCheckTrue    = 0x00000001,
    htmlSpellCheckFalse   = 0x00000002,
    htmlSpellCheckDefault = 0x00000003,
    htmlSpellCheck_Max    = 0x7fffffff,
}

alias htmlEncoding = int;
enum : int
{
    htmlEncodingURL       = 0x00000000,
    htmlEncodingMultipart = 0x00000001,
    htmlEncodingText      = 0x00000002,
    htmlEncoding_Max      = 0x7fffffff,
}

alias htmlAdjacency = int;
enum : int
{
    htmlAdjacencyBeforeBegin = 0x00000001,
    htmlAdjacencyAfterBegin  = 0x00000002,
    htmlAdjacencyBeforeEnd   = 0x00000003,
    htmlAdjacencyAfterEnd    = 0x00000004,
    htmlAdjacency_Max        = 0x7fffffff,
}

alias htmlTabIndex = int;
enum : int
{
    htmlTabIndexNotSet = 0xffff8000,
    htmlTabIndex_Max   = 0x7fffffff,
}

alias htmlComponent = int;
enum : int
{
    htmlComponentClient        = 0x00000000,
    htmlComponentSbLeft        = 0x00000001,
    htmlComponentSbPageLeft    = 0x00000002,
    htmlComponentSbHThumb      = 0x00000003,
    htmlComponentSbPageRight   = 0x00000004,
    htmlComponentSbRight       = 0x00000005,
    htmlComponentSbUp          = 0x00000006,
    htmlComponentSbPageUp      = 0x00000007,
    htmlComponentSbVThumb      = 0x00000008,
    htmlComponentSbPageDown    = 0x00000009,
    htmlComponentSbDown        = 0x0000000a,
    htmlComponentSbLeft2       = 0x0000000b,
    htmlComponentSbPageLeft2   = 0x0000000c,
    htmlComponentSbRight2      = 0x0000000d,
    htmlComponentSbPageRight2  = 0x0000000e,
    htmlComponentSbUp2         = 0x0000000f,
    htmlComponentSbPageUp2     = 0x00000010,
    htmlComponentSbDown2       = 0x00000011,
    htmlComponentSbPageDown2   = 0x00000012,
    htmlComponentSbTop         = 0x00000013,
    htmlComponentSbBottom      = 0x00000014,
    htmlComponentOutside       = 0x00000015,
    htmlComponentGHTopLeft     = 0x00000016,
    htmlComponentGHLeft        = 0x00000017,
    htmlComponentGHTop         = 0x00000018,
    htmlComponentGHBottomLeft  = 0x00000019,
    htmlComponentGHTopRight    = 0x0000001a,
    htmlComponentGHBottom      = 0x0000001b,
    htmlComponentGHRight       = 0x0000001c,
    htmlComponentGHBottomRight = 0x0000001d,
    htmlComponent_Max          = 0x7fffffff,
}

alias htmlApplyLocation = int;
enum : int
{
    htmlApplyLocationInside  = 0x00000000,
    htmlApplyLocationOutside = 0x00000001,
    htmlApplyLocation_Max    = 0x7fffffff,
}

alias htmlGlyphMode = int;
enum : int
{
    htmlGlyphModeNone  = 0x00000000,
    htmlGlyphModeBegin = 0x00000001,
    htmlGlyphModeEnd   = 0x00000002,
    htmlGlyphModeBoth  = 0x00000003,
    htmlGlyphMode_Max  = 0x7fffffff,
}

alias htmlDraggable = int;
enum : int
{
    htmlDraggableAuto  = 0x00000000,
    htmlDraggableTrue  = 0x00000001,
    htmlDraggableFalse = 0x00000002,
    htmlDraggable_Max  = 0x7fffffff,
}

alias htmlUnit = int;
enum : int
{
    htmlUnitCharacter = 0x00000001,
    htmlUnitWord      = 0x00000002,
    htmlUnitSentence  = 0x00000003,
    htmlUnitTextEdit  = 0x00000006,
    htmlUnit_Max      = 0x7fffffff,
}

alias htmlEndPoints = int;
enum : int
{
    htmlEndPointsStartToStart = 0x00000001,
    htmlEndPointsStartToEnd   = 0x00000002,
    htmlEndPointsEndToStart   = 0x00000003,
    htmlEndPointsEndToEnd     = 0x00000004,
    htmlEndPoints_Max         = 0x7fffffff,
}

alias htmlDirection = int;
enum : int
{
    htmlDirectionForward  = 0x0001869f,
    htmlDirectionBackward = 0xfffe7961,
    htmlDirection_Max     = 0x7fffffff,
}

alias htmlStart = int;
enum : int
{
    htmlStartfileopen  = 0x00000000,
    htmlStartmouseover = 0x00000001,
    htmlStart_Max      = 0x7fffffff,
}

alias bodyScroll = int;
enum : int
{
    bodyScrollyes     = 0x00000001,
    bodyScrollno      = 0x00000002,
    bodyScrollauto    = 0x00000004,
    bodyScrolldefault = 0x00000003,
    bodyScroll_Max    = 0x7fffffff,
}

alias htmlSelectType = int;
enum : int
{
    htmlSelectTypeSelectOne      = 0x00000001,
    htmlSelectTypeSelectMultiple = 0x00000002,
    htmlSelectType_Max           = 0x7fffffff,
}

alias htmlSelectExFlag = int;
enum : int
{
    htmlSelectExFlagNone                  = 0x00000000,
    htmlSelectExFlagHideSelectionInDesign = 0x00000001,
    htmlSelectExFlag_Max                  = 0x7fffffff,
}

alias htmlSelection = int;
enum : int
{
    htmlSelectionNone    = 0x00000000,
    htmlSelectionText    = 0x00000001,
    htmlSelectionControl = 0x00000002,
    htmlSelectionTable   = 0x00000003,
    htmlSelection_Max    = 0x7fffffff,
}

alias htmlMarqueeBehavior = int;
enum : int
{
    htmlMarqueeBehaviorscroll    = 0x00000001,
    htmlMarqueeBehaviorslide     = 0x00000002,
    htmlMarqueeBehavioralternate = 0x00000003,
    htmlMarqueeBehavior_Max      = 0x7fffffff,
}

alias htmlMarqueeDirection = int;
enum : int
{
    htmlMarqueeDirectionleft  = 0x00000001,
    htmlMarqueeDirectionright = 0x00000003,
    htmlMarqueeDirectionup    = 0x00000005,
    htmlMarqueeDirectiondown  = 0x00000007,
    htmlMarqueeDirection_Max  = 0x7fffffff,
}

alias htmlPersistState = int;
enum : int
{
    htmlPersistStateNormal   = 0x00000000,
    htmlPersistStateFavorite = 0x00000001,
    htmlPersistStateHistory  = 0x00000002,
    htmlPersistStateSnapshot = 0x00000003,
    htmlPersistStateUserData = 0x00000004,
    htmlPersistState_Max     = 0x7fffffff,
}

alias htmlDropEffect = int;
enum : int
{
    htmlDropEffectCopy = 0x00000000,
    htmlDropEffectLink = 0x00000001,
    htmlDropEffectMove = 0x00000002,
    htmlDropEffectNone = 0x00000003,
    htmlDropEffect_Max = 0x7fffffff,
}

alias htmlEffectAllowed = int;
enum : int
{
    htmlEffectAllowedCopy          = 0x00000000,
    htmlEffectAllowedLink          = 0x00000001,
    htmlEffectAllowedMove          = 0x00000002,
    htmlEffectAllowedCopyLink      = 0x00000003,
    htmlEffectAllowedCopyMove      = 0x00000004,
    htmlEffectAllowedLinkMove      = 0x00000005,
    htmlEffectAllowedAll           = 0x00000006,
    htmlEffectAllowedNone          = 0x00000007,
    htmlEffectAllowedUninitialized = 0x00000008,
    htmlEffectAllowed_Max          = 0x7fffffff,
}

alias htmlCompatMode = int;
enum : int
{
    htmlCompatModeBackCompat = 0x00000000,
    htmlCompatModeCSS1Compat = 0x00000001,
    htmlCompatMode_Max       = 0x7fffffff,
}

alias htmlCaptionAlign = int;
enum : int
{
    htmlCaptionAlignNotSet  = 0x00000000,
    htmlCaptionAlignLeft    = 0x00000001,
    htmlCaptionAlignCenter  = 0x00000002,
    htmlCaptionAlignRight   = 0x00000003,
    htmlCaptionAlignJustify = 0x00000004,
    htmlCaptionAlignTop     = 0x00000005,
    htmlCaptionAlignBottom  = 0x00000006,
    htmlCaptionAlign_Max    = 0x7fffffff,
}

alias htmlCaptionVAlign = int;
enum : int
{
    htmlCaptionVAlignNotSet = 0x00000000,
    htmlCaptionVAlignTop    = 0x00000001,
    htmlCaptionVAlignBottom = 0x00000002,
    htmlCaptionVAlign_Max   = 0x7fffffff,
}

alias htmlFrame = int;
enum : int
{
    htmlFrameNotSet = 0x00000000,
    htmlFramevoid   = 0x00000001,
    htmlFrameabove  = 0x00000002,
    htmlFramebelow  = 0x00000003,
    htmlFramehsides = 0x00000004,
    htmlFramelhs    = 0x00000005,
    htmlFramerhs    = 0x00000006,
    htmlFramevsides = 0x00000007,
    htmlFramebox    = 0x00000008,
    htmlFrameborder = 0x00000009,
    htmlFrame_Max   = 0x7fffffff,
}

alias htmlRules = int;
enum : int
{
    htmlRulesNotSet = 0x00000000,
    htmlRulesnone   = 0x00000001,
    htmlRulesgroups = 0x00000002,
    htmlRulesrows   = 0x00000003,
    htmlRulescols   = 0x00000004,
    htmlRulesall    = 0x00000005,
    htmlRules_Max   = 0x7fffffff,
}

alias htmlCellAlign = int;
enum : int
{
    htmlCellAlignNotSet = 0x00000000,
    htmlCellAlignLeft   = 0x00000001,
    htmlCellAlignCenter = 0x00000002,
    htmlCellAlignRight  = 0x00000003,
    htmlCellAlignMiddle = 0x00000002,
    htmlCellAlign_Max   = 0x7fffffff,
}

alias htmlCellVAlign = int;
enum : int
{
    htmlCellVAlignNotSet   = 0x00000000,
    htmlCellVAlignTop      = 0x00000001,
    htmlCellVAlignMiddle   = 0x00000002,
    htmlCellVAlignBottom   = 0x00000003,
    htmlCellVAlignBaseline = 0x00000004,
    htmlCellVAlignCenter   = 0x00000002,
    htmlCellVAlign_Max     = 0x7fffffff,
}

alias frameScrolling = int;
enum : int
{
    frameScrollingyes  = 0x00000001,
    frameScrollingno   = 0x00000002,
    frameScrollingauto = 0x00000004,
    frameScrolling_Max = 0x7fffffff,
}

alias sandboxAllow = int;
enum : int
{
    sandboxAllowScripts       = 0x00000000,
    sandboxAllowSameOrigin    = 0x00000001,
    sandboxAllowTopNavigation = 0x00000002,
    sandboxAllowForms         = 0x00000003,
    sandboxAllowPopups        = 0x00000004,
    sandboxAllow_Max          = 0x7fffffff,
}

alias svgAngleType = int;
enum : int
{
    SVG_ANGLETYPE_UNKNOWN     = 0x00000000,
    SVG_ANGLETYPE_UNSPECIFIED = 0x00000001,
    SVG_ANGLETYPE_DEG         = 0x00000002,
    SVG_ANGLETYPE_RAD         = 0x00000003,
    SVG_ANGLETYPE_GRAD        = 0x00000004,
    svgAngleType_Max          = 0x7fffffff,
}

alias svgExternalResourcesRequired = int;
enum : int
{
    svgExternalResourcesRequiredFalse = 0x00000000,
    svgExternalResourcesRequiredTrue  = 0x00000001,
    svgExternalResourcesRequired_Max  = 0x7fffffff,
}

alias svgFocusable = int;
enum : int
{
    svgFocusableNotSet = 0x00000000,
    svgFocusableAuto   = 0x00000001,
    svgFocusableTrue   = 0x00000002,
    svgFocusableFalse  = 0x00000003,
    svgFocusable_Max   = 0x7fffffff,
}

alias svgLengthType = int;
enum : int
{
    SVG_LENGTHTYPE_UNKNOWN    = 0x00000000,
    SVG_LENGTHTYPE_NUMBER     = 0x00000001,
    SVG_LENGTHTYPE_PERCENTAGE = 0x00000002,
    SVG_LENGTHTYPE_EMS        = 0x00000003,
    SVG_LENGTHTYPE_EXS        = 0x00000004,
    SVG_LENGTHTYPE_PX         = 0x00000005,
    SVG_LENGTHTYPE_CM         = 0x00000006,
    SVG_LENGTHTYPE_MM         = 0x00000007,
    SVG_LENGTHTYPE_IN         = 0x00000008,
    SVG_LENGTHTYPE_PT         = 0x00000009,
    SVG_LENGTHTYPE_PC         = 0x0000000a,
    svgLengthType_Max         = 0x7fffffff,
}

alias svgPathSegType = int;
enum : int
{
    PATHSEG_UNKNOWN                      = 0x00000000,
    PATHSEG_CLOSEPATH                    = 0x00000001,
    PATHSEG_MOVETO_ABS                   = 0x00000002,
    PATHSEG_MOVETO_REL                   = 0x00000003,
    PATHSEG_LINETO_ABS                   = 0x00000004,
    PATHSEG_LINETO_REL                   = 0x00000005,
    PATHSEG_CURVETO_CUBIC_ABS            = 0x00000006,
    PATHSEG_CURVETO_CUBIC_REL            = 0x00000007,
    PATHSEG_CURVETO_QUADRATIC_ABS        = 0x00000008,
    PATHSEG_CURVETO_QUADRATIC_REL        = 0x00000009,
    PATHSEG_ARC_ABS                      = 0x0000000a,
    PATHSEG_ARC_REL                      = 0x0000000b,
    PATHSEG_LINETO_HORIZONTAL_ABS        = 0x0000000c,
    PATHSEG_LINETO_HORIZONTAL_REL        = 0x0000000d,
    PATHSEG_LINETO_VERTICAL_ABS          = 0x0000000e,
    PATHSEG_LINETO_VERTICAL_REL          = 0x0000000f,
    PATHSEG_CURVETO_CUBIC_SMOOTH_ABS     = 0x00000010,
    PATHSEG_CURVETO_CUBIC_SMOOTH_REL     = 0x00000011,
    PATHSEG_CURVETO_QUADRATIC_SMOOTH_ABS = 0x00000012,
    PATHSEG_CURVETO_QUADRATIC_SMOOTH_REL = 0x00000013,
    svgPathSegType_Max                   = 0x7fffffff,
}

alias svgTransformType = int;
enum : int
{
    SVG_TRANSFORM_UNKNOWN   = 0x00000000,
    SVG_TRANSFORM_MATRIX    = 0x00000001,
    SVG_TRANSFORM_TRANSLATE = 0x00000002,
    SVG_TRANSFORM_SCALE     = 0x00000003,
    SVG_TRANSFORM_ROTATE    = 0x00000004,
    SVG_TRANSFORM_SKEWX     = 0x00000005,
    SVG_TRANSFORM_SKEWY     = 0x00000006,
    svgTransformType_Max    = 0x7fffffff,
}

alias svgPreserveAspectRatioAlignType = int;
enum : int
{
    SVG_PRESERVEASPECTRATIO_UNKNOWN     = 0x00000000,
    SVG_PRESERVEASPECTRATIO_NONE        = 0x00000001,
    SVG_PRESERVEASPECTRATIO_XMINYMIN    = 0x00000002,
    SVG_PRESERVEASPECTRATIO_XMIDYMIN    = 0x00000003,
    SVG_PRESERVEASPECTRATIO_XMAXYMIN    = 0x00000004,
    SVG_PRESERVEASPECTRATIO_XMINYMID    = 0x00000005,
    SVG_PRESERVEASPECTRATIO_XMIDYMID    = 0x00000006,
    SVG_PRESERVEASPECTRATIO_XMAXYMID    = 0x00000007,
    SVG_PRESERVEASPECTRATIO_XMINYMAX    = 0x00000008,
    SVG_PRESERVEASPECTRATIO_XMIDYMAX    = 0x00000009,
    SVG_PRESERVEASPECTRATIO_XMAXYMAX    = 0x0000000a,
    svgPreserveAspectRatioAlignType_Max = 0x7fffffff,
}

alias svgPreserveAspectMeetOrSliceType = int;
enum : int
{
    SVG_MEETORSLICE_UNKNOWN              = 0x00000000,
    SVG_MEETORSLICE_MEET                 = 0x00000001,
    SVG_MEETORSLICE_SLICE                = 0x00000002,
    svgPreserveAspectMeetOrSliceType_Max = 0x7fffffff,
}

alias svgUnitTypes = int;
enum : int
{
    SVG_UNITTYPE_UNKNOWN           = 0x00000000,
    SVG_UNITTYPE_USERSPACEONUSE    = 0x00000001,
    SVG_UNITTYPE_OBJECTBOUNDINGBOX = 0x00000002,
    svgUnitTypes_Max               = 0x7fffffff,
}

alias svgSpreadMethod = int;
enum : int
{
    SVG_SPREADMETHOD_UNKNOWN = 0x00000000,
    SVG_SPREADMETHOD_PAD     = 0x00000001,
    SVG_SPREADMETHOD_REFLECT = 0x00000002,
    SVG_SPREADMETHOD_REPEAT  = 0x00000003,
    svgSpreadMethod_Max      = 0x7fffffff,
}

alias svgFeblendMode = int;
enum : int
{
    SVG_FEBLEND_MODE_UNKNOWN  = 0x00000000,
    SVG_FEBLEND_MODE_NORMAL   = 0x00000001,
    SVG_FEBLEND_MODE_MULTIPLY = 0x00000002,
    SVG_FEBLEND_MODE_SCREEN   = 0x00000003,
    SVG_FEBLEND_MODE_DARKEN   = 0x00000004,
    SVG_FEBLEND_MODE_LIGHTEN  = 0x00000005,
    svgFeblendMode_Max        = 0x7fffffff,
}

alias svgFecolormatrixType = int;
enum : int
{
    SVG_FECOLORMATRIX_TYPE_UNKNOWN          = 0x00000000,
    SVG_FECOLORMATRIX_TYPE_MATRIX           = 0x00000001,
    SVG_FECOLORMATRIX_TYPE_SATURATE         = 0x00000002,
    SVG_FECOLORMATRIX_TYPE_HUEROTATE        = 0x00000003,
    SVG_FECOLORMATRIX_TYPE_LUMINANCETOALPHA = 0x00000004,
    svgFecolormatrixType_Max                = 0x7fffffff,
}

alias svgFecomponenttransferType = int;
enum : int
{
    SVG_FECOMPONENTTRANSFER_TYPE_UNKNOWN  = 0x00000000,
    SVG_FECOMPONENTTRANSFER_TYPE_IDENTITY = 0x00000001,
    SVG_FECOMPONENTTRANSFER_TYPE_TABLE    = 0x00000002,
    SVG_FECOMPONENTTRANSFER_TYPE_DISCRETE = 0x00000003,
    SVG_FECOMPONENTTRANSFER_TYPE_LINEAR   = 0x00000004,
    SVG_FECOMPONENTTRANSFER_TYPE_GAMMA    = 0x00000005,
    svgFecomponenttransferType_Max        = 0x7fffffff,
}

alias svgFecompositeOperator = int;
enum : int
{
    SVG_FECOMPOSITE_OPERATOR_UNKNOWN    = 0x00000000,
    SVG_FECOMPOSITE_OPERATOR_OVER       = 0x00000001,
    SVG_FECOMPOSITE_OPERATOR_IN         = 0x00000002,
    SVG_FECOMPOSITE_OPERATOR_OUT        = 0x00000003,
    SVG_FECOMPOSITE_OPERATOR_ATOP       = 0x00000004,
    SVG_FECOMPOSITE_OPERATOR_XOR        = 0x00000005,
    SVG_FECOMPOSITE_OPERATOR_ARITHMETIC = 0x00000006,
    svgFecompositeOperator_Max          = 0x7fffffff,
}

alias svgEdgemode = int;
enum : int
{
    SVG_EDGEMODE_UNKNOWN   = 0x00000000,
    SVG_EDGEMODE_DUPLICATE = 0x00000001,
    SVG_EDGEMODE_WRAP      = 0x00000002,
    SVG_EDGEMODE_NONE      = 0x00000003,
    svgEdgemode_Max        = 0x7fffffff,
}

alias svgPreserveAlpha = int;
enum : int
{
    SVG_PRESERVEALPHA_FALSE = 0x00000000,
    SVG_PRESERVEALPHA_TRUE  = 0x00000001,
    svgPreserveAlpha_Max    = 0x7fffffff,
}

alias svgChannel = int;
enum : int
{
    SVG_CHANNEL_UNKNOWN = 0x00000000,
    SVG_CHANNEL_R       = 0x00000001,
    SVG_CHANNEL_G       = 0x00000002,
    SVG_CHANNEL_B       = 0x00000003,
    SVG_CHANNEL_A       = 0x00000004,
    svgChannel_Max      = 0x7fffffff,
}

alias svgMorphologyOperator = int;
enum : int
{
    SVG_MORPHOLOGY_OPERATOR_UNKNOWN = 0x00000000,
    SVG_MORPHOLOGY_OPERATOR_ERODE   = 0x00000001,
    SVG_MORPHOLOGY_OPERATOR_DILATE  = 0x00000002,
    svgMorphologyOperator_Max       = 0x7fffffff,
}

alias svgTurbulenceType = int;
enum : int
{
    SVG_TURBULENCE_TYPE_UNKNOWN     = 0x00000000,
    SVG_TURBULENCE_TYPE_FACTALNOISE = 0x00000001,
    SVG_TURBULENCE_TYPE_TURBULENCE  = 0x00000002,
    svgTurbulenceType_Max           = 0x7fffffff,
}

alias svgStitchtype = int;
enum : int
{
    SVG_STITCHTYPE_UNKNOWN  = 0x00000000,
    SVG_STITCHTYPE_STITCH   = 0x00000001,
    SVG_STITCHTYPE_NOSTITCH = 0x00000002,
    svgStitchtype_Max       = 0x7fffffff,
}

alias svgMarkerUnits = int;
enum : int
{
    SVG_MARKERUNITS_UNKNOWN        = 0x00000000,
    SVG_MARKERUNITS_USERSPACEONUSE = 0x00000001,
    SVG_MARKERUNITS_STROKEWIDTH    = 0x00000002,
    svgMarkerUnits_Max             = 0x7fffffff,
}

alias svgMarkerOrient = int;
enum : int
{
    SVG_MARKER_ORIENT_UNKNOWN = 0x00000000,
    SVG_MARKER_ORIENT_AUTO    = 0x00000001,
    SVG_MARKER_ORIENT_ANGLE   = 0x00000002,
    svgMarkerOrient_Max       = 0x7fffffff,
}

alias svgMarkerOrientAttribute = int;
enum : int
{
    svgMarkerOrientAttributeAuto = 0x00000000,
    svgMarkerOrientAttribute_Max = 0x7fffffff,
}

alias htmlMediaNetworkState = int;
enum : int
{
    htmlMediaNetworkStateEmpty    = 0x00000000,
    htmlMediaNetworkStateIdle     = 0x00000001,
    htmlMediaNetworkStateLoading  = 0x00000002,
    htmlMediaNetworkStateNoSource = 0x00000003,
    htmlMediaNetworkState_Max     = 0x7fffffff,
}

alias htmlMediaReadyState = int;
enum : int
{
    htmlMediaReadyStateHaveNothing     = 0x00000000,
    htmlMediaReadyStateHaveMetadata    = 0x00000001,
    htmlMediaReadyStateHaveCurrentData = 0x00000002,
    htmlMediaReadyStateHaveFutureData  = 0x00000003,
    htmlMediaReadyStateHaveEnoughData  = 0x00000004,
    htmlMediaReadyState_Max            = 0x7fffffff,
}

alias htmlMediaErr = int;
enum : int
{
    htmlMediaErrAborted         = 0x00000000,
    htmlMediaErrNetwork         = 0x00000001,
    htmlMediaErrDecode          = 0x00000002,
    htmlMediaErrSrcNotSupported = 0x00000003,
    htmlMediaErr_Max            = 0x7fffffff,
}

alias lengthAdjust = int;
enum : int
{
    LENGTHADJUST_UNKNOWN          = 0x00000000,
    LENGTHADJUST_SPACING          = 0x00000001,
    LENGTHADJUST_SPACINGANDGLYPHS = 0x00000002,
    lengthAdjust_Max              = 0x7fffffff,
}

alias textpathMethodtype = int;
enum : int
{
    TEXTPATH_METHODTYPE_UNKNOWN = 0x00000000,
    TEXTPATH_METHODTYPE_ALIGN   = 0x00000001,
    TEXTPATH_METHODTYPE_STRETCH = 0x00000002,
    textpathMethodtype_Max      = 0x7fffffff,
}

alias textpathSpacingtype = int;
enum : int
{
    TEXTPATH_SPACINGTYPE_UNKNOWN = 0x00000000,
    TEXTPATH_SPACINGTYPE_AUTO    = 0x00000001,
    TEXTPATH_SPACINGTYPE_EXACT   = 0x00000002,
    textpathSpacingtype_Max      = 0x7fffffff,
}

alias ELEMENT_CORNER = int;
enum : int
{
    ELEMENT_CORNER_NONE        = 0x00000000,
    ELEMENT_CORNER_TOP         = 0x00000001,
    ELEMENT_CORNER_LEFT        = 0x00000002,
    ELEMENT_CORNER_BOTTOM      = 0x00000003,
    ELEMENT_CORNER_RIGHT       = 0x00000004,
    ELEMENT_CORNER_TOPLEFT     = 0x00000005,
    ELEMENT_CORNER_TOPRIGHT    = 0x00000006,
    ELEMENT_CORNER_BOTTOMLEFT  = 0x00000007,
    ELEMENT_CORNER_BOTTOMRIGHT = 0x00000008,
    ELEMENT_CORNER_Max         = 0x7fffffff,
}

alias SECUREURLHOSTVALIDATE_FLAGS = int;
enum : int
{
    SUHV_PROMPTBEFORENO             = 0x00000001,
    SUHV_SILENTYES                  = 0x00000002,
    SUHV_UNSECURESOURCE             = 0x00000004,
    SECUREURLHOSTVALIDATE_FLAGS_Max = 0x7fffffff,
}

alias POINTER_GRAVITY = int;
enum : int
{
    POINTER_GRAVITY_Left  = 0x00000000,
    POINTER_GRAVITY_Right = 0x00000001,
    POINTER_GRAVITY_Max   = 0x7fffffff,
}

alias ELEMENT_ADJACENCY = int;
enum : int
{
    ELEM_ADJ_BeforeBegin  = 0x00000000,
    ELEM_ADJ_AfterBegin   = 0x00000001,
    ELEM_ADJ_BeforeEnd    = 0x00000002,
    ELEM_ADJ_AfterEnd     = 0x00000003,
    ELEMENT_ADJACENCY_Max = 0x7fffffff,
}

alias MARKUP_CONTEXT_TYPE = int;
enum : int
{
    CONTEXT_TYPE_None       = 0x00000000,
    CONTEXT_TYPE_Text       = 0x00000001,
    CONTEXT_TYPE_EnterScope = 0x00000002,
    CONTEXT_TYPE_ExitScope  = 0x00000003,
    CONTEXT_TYPE_NoScope    = 0x00000004,
    MARKUP_CONTEXT_TYPE_Max = 0x7fffffff,
}

alias FINDTEXT_FLAGS = int;
enum : int
{
    FINDTEXT_BACKWARDS               = 0x00000001,
    FINDTEXT_WHOLEWORD               = 0x00000002,
    FINDTEXT_MATCHCASE               = 0x00000004,
    FINDTEXT_RAW                     = 0x00020000,
    FINDTEXT_MATCHREPEATEDWHITESPACE = 0x00040000,
    FINDTEXT_MATCHDIAC               = 0x20000000,
    FINDTEXT_MATCHKASHIDA            = 0x40000000,
    FINDTEXT_MATCHALEFHAMZA          = 0x80000000,
    FINDTEXT_FLAGS_Max               = 0x7fffffff,
}

alias MOVEUNIT_ACTION = int;
enum : int
{
    MOVEUNIT_PREVCHAR         = 0x00000000,
    MOVEUNIT_NEXTCHAR         = 0x00000001,
    MOVEUNIT_PREVCLUSTERBEGIN = 0x00000002,
    MOVEUNIT_NEXTCLUSTERBEGIN = 0x00000003,
    MOVEUNIT_PREVCLUSTEREND   = 0x00000004,
    MOVEUNIT_NEXTCLUSTEREND   = 0x00000005,
    MOVEUNIT_PREVWORDBEGIN    = 0x00000006,
    MOVEUNIT_NEXTWORDBEGIN    = 0x00000007,
    MOVEUNIT_PREVWORDEND      = 0x00000008,
    MOVEUNIT_NEXTWORDEND      = 0x00000009,
    MOVEUNIT_PREVPROOFWORD    = 0x0000000a,
    MOVEUNIT_NEXTPROOFWORD    = 0x0000000b,
    MOVEUNIT_NEXTURLBEGIN     = 0x0000000c,
    MOVEUNIT_PREVURLBEGIN     = 0x0000000d,
    MOVEUNIT_NEXTURLEND       = 0x0000000e,
    MOVEUNIT_PREVURLEND       = 0x0000000f,
    MOVEUNIT_PREVSENTENCE     = 0x00000010,
    MOVEUNIT_NEXTSENTENCE     = 0x00000011,
    MOVEUNIT_PREVBLOCK        = 0x00000012,
    MOVEUNIT_NEXTBLOCK        = 0x00000013,
    MOVEUNIT_ACTION_Max       = 0x7fffffff,
}

alias PARSE_FLAGS = int;
enum : int
{
    PARSE_ABSOLUTIFYIE40URLS = 0x00000001,
    PARSE_DISABLEVML         = 0x00000002,
    PARSE_FLAGS_Max          = 0x7fffffff,
}

alias ELEMENT_TAG_ID = int;
enum : int
{
    TAGID_NULL                    = 0x00000000,
    TAGID_UNKNOWN                 = 0x00000001,
    TAGID_A                       = 0x00000002,
    TAGID_ACRONYM                 = 0x00000003,
    TAGID_ADDRESS                 = 0x00000004,
    TAGID_APPLET                  = 0x00000005,
    TAGID_AREA                    = 0x00000006,
    TAGID_B                       = 0x00000007,
    TAGID_BASE                    = 0x00000008,
    TAGID_BASEFONT                = 0x00000009,
    TAGID_BDO                     = 0x0000000a,
    TAGID_BGSOUND                 = 0x0000000b,
    TAGID_BIG                     = 0x0000000c,
    TAGID_BLINK                   = 0x0000000d,
    TAGID_BLOCKQUOTE              = 0x0000000e,
    TAGID_BODY                    = 0x0000000f,
    TAGID_BR                      = 0x00000010,
    TAGID_BUTTON                  = 0x00000011,
    TAGID_CAPTION                 = 0x00000012,
    TAGID_CENTER                  = 0x00000013,
    TAGID_CITE                    = 0x00000014,
    TAGID_CODE                    = 0x00000015,
    TAGID_COL                     = 0x00000016,
    TAGID_COLGROUP                = 0x00000017,
    TAGID_COMMENT                 = 0x00000018,
    TAGID_COMMENT_RAW             = 0x00000019,
    TAGID_DD                      = 0x0000001a,
    TAGID_DEL                     = 0x0000001b,
    TAGID_DFN                     = 0x0000001c,
    TAGID_DIR                     = 0x0000001d,
    TAGID_DIV                     = 0x0000001e,
    TAGID_DL                      = 0x0000001f,
    TAGID_DT                      = 0x00000020,
    TAGID_EM                      = 0x00000021,
    TAGID_EMBED                   = 0x00000022,
    TAGID_FIELDSET                = 0x00000023,
    TAGID_FONT                    = 0x00000024,
    TAGID_FORM                    = 0x00000025,
    TAGID_FRAME                   = 0x00000026,
    TAGID_FRAMESET                = 0x00000027,
    TAGID_GENERIC                 = 0x00000028,
    TAGID_H1                      = 0x00000029,
    TAGID_H2                      = 0x0000002a,
    TAGID_H3                      = 0x0000002b,
    TAGID_H4                      = 0x0000002c,
    TAGID_H5                      = 0x0000002d,
    TAGID_H6                      = 0x0000002e,
    TAGID_HEAD                    = 0x0000002f,
    TAGID_HR                      = 0x00000030,
    TAGID_HTML                    = 0x00000031,
    TAGID_I                       = 0x00000032,
    TAGID_IFRAME                  = 0x00000033,
    TAGID_IMG                     = 0x00000034,
    TAGID_INPUT                   = 0x00000035,
    TAGID_INS                     = 0x00000036,
    TAGID_KBD                     = 0x00000037,
    TAGID_LABEL                   = 0x00000038,
    TAGID_LEGEND                  = 0x00000039,
    TAGID_LI                      = 0x0000003a,
    TAGID_LINK                    = 0x0000003b,
    TAGID_LISTING                 = 0x0000003c,
    TAGID_MAP                     = 0x0000003d,
    TAGID_MARQUEE                 = 0x0000003e,
    TAGID_MENU                    = 0x0000003f,
    TAGID_META                    = 0x00000040,
    TAGID_NEXTID                  = 0x00000041,
    TAGID_NOBR                    = 0x00000042,
    TAGID_NOEMBED                 = 0x00000043,
    TAGID_NOFRAMES                = 0x00000044,
    TAGID_NOSCRIPT                = 0x00000045,
    TAGID_OBJECT                  = 0x00000046,
    TAGID_OL                      = 0x00000047,
    TAGID_OPTION                  = 0x00000048,
    TAGID_P                       = 0x00000049,
    TAGID_PARAM                   = 0x0000004a,
    TAGID_PLAINTEXT               = 0x0000004b,
    TAGID_PRE                     = 0x0000004c,
    TAGID_Q                       = 0x0000004d,
    TAGID_RP                      = 0x0000004e,
    TAGID_RT                      = 0x0000004f,
    TAGID_RUBY                    = 0x00000050,
    TAGID_S                       = 0x00000051,
    TAGID_SAMP                    = 0x00000052,
    TAGID_SCRIPT                  = 0x00000053,
    TAGID_SELECT                  = 0x00000054,
    TAGID_SMALL                   = 0x00000055,
    TAGID_SPAN                    = 0x00000056,
    TAGID_STRIKE                  = 0x00000057,
    TAGID_STRONG                  = 0x00000058,
    TAGID_STYLE                   = 0x00000059,
    TAGID_SUB                     = 0x0000005a,
    TAGID_SUP                     = 0x0000005b,
    TAGID_TABLE                   = 0x0000005c,
    TAGID_TBODY                   = 0x0000005d,
    TAGID_TC                      = 0x0000005e,
    TAGID_TD                      = 0x0000005f,
    TAGID_TEXTAREA                = 0x00000060,
    TAGID_TFOOT                   = 0x00000061,
    TAGID_TH                      = 0x00000062,
    TAGID_THEAD                   = 0x00000063,
    TAGID_TITLE                   = 0x00000064,
    TAGID_TR                      = 0x00000065,
    TAGID_TT                      = 0x00000066,
    TAGID_U                       = 0x00000067,
    TAGID_UL                      = 0x00000068,
    TAGID_VAR                     = 0x00000069,
    TAGID_WBR                     = 0x0000006a,
    TAGID_XMP                     = 0x0000006b,
    TAGID_ROOT                    = 0x0000006c,
    TAGID_OPTGROUP                = 0x0000006d,
    TAGID_ABBR                    = 0x0000006e,
    TAGID_SVG_A                   = 0x0000006f,
    TAGID_SVG_ALTGLYPH            = 0x00000070,
    TAGID_SVG_ALTGLYPHDEF         = 0x00000071,
    TAGID_SVG_ALTGLYPHITEM        = 0x00000072,
    TAGID_SVG_ANIMATE             = 0x00000073,
    TAGID_SVG_ANIMATECOLOR        = 0x00000074,
    TAGID_SVG_ANIMATEMOTION       = 0x00000075,
    TAGID_SVG_ANIMATETRANSFORM    = 0x00000076,
    TAGID_SVG_CIRCLE              = 0x00000077,
    TAGID_SVG_CLIPPATH            = 0x00000078,
    TAGID_SVG_COLOR_PROFILE       = 0x00000079,
    TAGID_SVG_CURSOR              = 0x0000007a,
    TAGID_SVG_DEFINITION_SRC      = 0x0000007b,
    TAGID_SVG_DEFS                = 0x0000007c,
    TAGID_SVG_DESC                = 0x0000007d,
    TAGID_SVG_ELLIPSE             = 0x0000007e,
    TAGID_SVG_FEBLEND             = 0x0000007f,
    TAGID_SVG_FECOLORMATRIX       = 0x00000080,
    TAGID_SVG_FECOMPONENTTRANSFER = 0x00000081,
    TAGID_SVG_FECOMPOSITE         = 0x00000082,
    TAGID_SVG_FECONVOLVEMATRIX    = 0x00000083,
    TAGID_SVG_FEDIFFUSELIGHTING   = 0x00000084,
    TAGID_SVG_FEDISPLACEMENTMAP   = 0x00000085,
    TAGID_SVG_FEDISTANTLIGHT      = 0x00000086,
    TAGID_SVG_FEFLOOD             = 0x00000087,
    TAGID_SVG_FEFUNCA             = 0x00000088,
    TAGID_SVG_FEFUNCB             = 0x00000089,
    TAGID_SVG_FEFUNCG             = 0x0000008a,
    TAGID_SVG_FEFUNCR             = 0x0000008b,
    TAGID_SVG_FEGAUSSIANBLUR      = 0x0000008c,
    TAGID_SVG_FEIMAGE             = 0x0000008d,
    TAGID_SVG_FEMERGE             = 0x0000008e,
    TAGID_SVG_FEMERGENODE         = 0x0000008f,
    TAGID_SVG_FEMORPHOLOGY        = 0x00000090,
    TAGID_SVG_FEOFFSET            = 0x00000091,
    TAGID_SVG_FEPOINTLIGHT        = 0x00000092,
    TAGID_SVG_FESPECULARLIGHTING  = 0x00000093,
    TAGID_SVG_FESPOTLIGHT         = 0x00000094,
    TAGID_SVG_FETILE              = 0x00000095,
    TAGID_SVG_FETURBULENCE        = 0x00000096,
    TAGID_SVG_FILTER              = 0x00000097,
    TAGID_SVG_FONT                = 0x00000098,
    TAGID_SVG_FONT_FACE           = 0x00000099,
    TAGID_SVG_FONT_FACE_FORMAT    = 0x0000009a,
    TAGID_SVG_FONT_FACE_NAME      = 0x0000009b,
    TAGID_SVG_FONT_FACE_SRC       = 0x0000009c,
    TAGID_SVG_FONT_FACE_URI       = 0x0000009d,
    TAGID_SVG_FOREIGNOBJECT       = 0x0000009e,
    TAGID_SVG_G                   = 0x0000009f,
    TAGID_SVG_GLYPH               = 0x000000a0,
    TAGID_SVG_GLYPHREF            = 0x000000a1,
    TAGID_SVG_HKERN               = 0x000000a2,
    TAGID_SVG_IMAGE               = 0x000000a3,
    TAGID_SVG_LINE                = 0x000000a4,
    TAGID_SVG_LINEARGRADIENT      = 0x000000a5,
    TAGID_SVG_MARKER              = 0x000000a6,
    TAGID_SVG_MASK                = 0x000000a7,
    TAGID_SVG_METADATA            = 0x000000a8,
    TAGID_SVG_MISSING_GLYPH       = 0x000000a9,
    TAGID_SVG_MPATH               = 0x000000aa,
    TAGID_SVG_PATH                = 0x000000ab,
    TAGID_SVG_PATTERN             = 0x000000ac,
    TAGID_SVG_POLYGON             = 0x000000ad,
    TAGID_SVG_POLYLINE            = 0x000000ae,
    TAGID_SVG_RADIALGRADIENT      = 0x000000af,
    TAGID_SVG_RECT                = 0x000000b0,
    TAGID_SVG_SCRIPT              = 0x000000b1,
    TAGID_SVG_SET                 = 0x000000b2,
    TAGID_SVG_STOP                = 0x000000b3,
    TAGID_SVG_STYLE               = 0x000000b4,
    TAGID_SVG_SVG                 = 0x000000b5,
    TAGID_SVG_SWITCH              = 0x000000b6,
    TAGID_SVG_SYMBOL              = 0x000000b7,
    TAGID_SVG_TEXT                = 0x000000b8,
    TAGID_SVG_TEXTPATH            = 0x000000b9,
    TAGID_SVG_TITLE               = 0x000000ba,
    TAGID_SVG_TREF                = 0x000000bb,
    TAGID_SVG_TSPAN               = 0x000000bc,
    TAGID_SVG_USE                 = 0x000000bd,
    TAGID_SVG_VIEW                = 0x000000be,
    TAGID_SVG_VKERN               = 0x000000bf,
    TAGID_AUDIO                   = 0x000000c0,
    TAGID_SOURCE                  = 0x000000c1,
    TAGID_VIDEO                   = 0x000000c2,
    TAGID_CANVAS                  = 0x000000c3,
    TAGID_DOCTYPE                 = 0x000000c4,
    TAGID_KEYGEN                  = 0x000000c5,
    TAGID_PROCESSINGINSTRUCTION   = 0x000000c6,
    TAGID_ARTICLE                 = 0x000000c7,
    TAGID_ASIDE                   = 0x000000c8,
    TAGID_FIGCAPTION              = 0x000000c9,
    TAGID_FIGURE                  = 0x000000ca,
    TAGID_FOOTER                  = 0x000000cb,
    TAGID_HEADER                  = 0x000000cc,
    TAGID_HGROUP                  = 0x000000cd,
    TAGID_MARK                    = 0x000000ce,
    TAGID_NAV                     = 0x000000cf,
    TAGID_SECTION                 = 0x000000d0,
    TAGID_PROGRESS                = 0x000000d1,
    TAGID_MATHML_ANNOTATION_XML   = 0x000000d2,
    TAGID_MATHML_MATH             = 0x000000d3,
    TAGID_MATHML_MI               = 0x000000d4,
    TAGID_MATHML_MN               = 0x000000d5,
    TAGID_MATHML_MO               = 0x000000d6,
    TAGID_MATHML_MS               = 0x000000d7,
    TAGID_MATHML_MTEXT            = 0x000000d8,
    TAGID_DATALIST                = 0x000000d9,
    TAGID_TRACK                   = 0x000000da,
    TAGID_ISINDEX                 = 0x000000db,
    TAGID_COMMAND                 = 0x000000dc,
    TAGID_DETAILS                 = 0x000000dd,
    TAGID_SUMMARY                 = 0x000000de,
    TAGID_X_MS_WEBVIEW            = 0x000000df,
    TAGID_COUNT                   = 0x000000e0,
    TAGID_LAST_PREDEFINED         = 0x00002710,
    ELEMENT_TAG_ID_Max            = 0x7fffffff,
}

alias SELECTION_TYPE = int;
enum : int
{
    SELECTION_TYPE_None    = 0x00000000,
    SELECTION_TYPE_Caret   = 0x00000001,
    SELECTION_TYPE_Text    = 0x00000002,
    SELECTION_TYPE_Control = 0x00000003,
    SELECTION_TYPE_Max     = 0x7fffffff,
}

alias SAVE_SEGMENTS_FLAGS = int;
enum : int
{
    SAVE_SEGMENTS_NoIE4SelectionCompat = 0x00000001,
    SAVE_SEGMENTS_FLAGS_Max            = 0x7fffffff,
}

alias CARET_DIRECTION = int;
enum : int
{
    CARET_DIRECTION_INDETERMINATE = 0x00000000,
    CARET_DIRECTION_SAME          = 0x00000001,
    CARET_DIRECTION_BACKWARD      = 0x00000002,
    CARET_DIRECTION_FORWARD       = 0x00000003,
    CARET_DIRECTION_Max           = 0x7fffffff,
}

alias LINE_DIRECTION = int;
enum : int
{
    LINE_DIRECTION_RightToLeft = 0x00000001,
    LINE_DIRECTION_LeftToRight = 0x00000002,
    LINE_DIRECTION_Max         = 0x7fffffff,
}

alias HT_OPTIONS = int;
enum : int
{
    HT_OPT_AllowAfterEOL = 0x00000001,
    HT_OPTIONS_Max       = 0x7fffffff,
}

alias HT_RESULTS = int;
enum : int
{
    HT_RESULTS_Glyph = 0x00000001,
    HT_RESULTS_Max   = 0x7fffffff,
}

alias DISPLAY_MOVEUNIT = int;
enum : int
{
    DISPLAY_MOVEUNIT_PreviousLine     = 0x00000001,
    DISPLAY_MOVEUNIT_NextLine         = 0x00000002,
    DISPLAY_MOVEUNIT_CurrentLineStart = 0x00000003,
    DISPLAY_MOVEUNIT_CurrentLineEnd   = 0x00000004,
    DISPLAY_MOVEUNIT_TopOfWindow      = 0x00000005,
    DISPLAY_MOVEUNIT_BottomOfWindow   = 0x00000006,
    DISPLAY_MOVEUNIT_Max              = 0x7fffffff,
}

alias DISPLAY_GRAVITY = int;
enum : int
{
    DISPLAY_GRAVITY_PreviousLine = 0x00000001,
    DISPLAY_GRAVITY_NextLine     = 0x00000002,
    DISPLAY_GRAVITY_Max          = 0x7fffffff,
}

alias DISPLAY_BREAK = int;
enum : int
{
    DISPLAY_BREAK_None  = 0x00000000,
    DISPLAY_BREAK_Block = 0x00000001,
    DISPLAY_BREAK_Break = 0x00000002,
    DISPLAY_BREAK_Max   = 0x7fffffff,
}

alias COORD_SYSTEM = int;
enum : int
{
    COORD_SYSTEM_GLOBAL    = 0x00000000,
    COORD_SYSTEM_PARENT    = 0x00000001,
    COORD_SYSTEM_CONTAINER = 0x00000002,
    COORD_SYSTEM_CONTENT   = 0x00000003,
    COORD_SYSTEM_FRAME     = 0x00000004,
    COORD_SYSTEM_CLIENT    = 0x00000005,
    COORD_SYSTEM_Max       = 0x7fffffff,
}

alias DEV_CONSOLE_MESSAGE_LEVEL = int;
enum : int
{
    DCML_INFORMATIONAL            = 0x00000000,
    DCML_WARNING                  = 0x00000001,
    DCML_ERROR                    = 0x00000002,
    DEV_CONSOLE_MESSAGE_LEVEL_Max = 0x7fffffff,
}

alias DOM_EVENT_PHASE = int;
enum : int
{
    DEP_CAPTURING_PHASE = 0x00000001,
    DEP_AT_TARGET       = 0x00000002,
    DEP_BUBBLING_PHASE  = 0x00000003,
    DOM_EVENT_PHASE_Max = 0x7fffffff,
}

alias SCRIPT_TIMER_TYPE = int;
enum : int
{
    STT_TIMEOUT           = 0x00000000,
    STT_INTERVAL          = 0x00000001,
    STT_IMMEDIATE         = 0x00000002,
    STT_ANIMATION_FRAME   = 0x00000003,
    SCRIPT_TIMER_TYPE_Max = 0x7fffffff,
}

alias HTML_PAINTER = int;
enum : int
{
    HTMLPAINTER_OPAQUE         = 0x00000001,
    HTMLPAINTER_TRANSPARENT    = 0x00000002,
    HTMLPAINTER_ALPHA          = 0x00000004,
    HTMLPAINTER_COMPLEX        = 0x00000008,
    HTMLPAINTER_OVERLAY        = 0x00000010,
    HTMLPAINTER_HITTEST        = 0x00000020,
    HTMLPAINTER_SURFACE        = 0x00000100,
    HTMLPAINTER_3DSURFACE      = 0x00000200,
    HTMLPAINTER_NOBAND         = 0x00000400,
    HTMLPAINTER_NODC           = 0x00001000,
    HTMLPAINTER_NOPHYSICALCLIP = 0x00002000,
    HTMLPAINTER_NOSAVEDC       = 0x00004000,
    HTMLPAINTER_SUPPORTS_XFORM = 0x00008000,
    HTMLPAINTER_EXPAND         = 0x00010000,
    HTMLPAINTER_NOSCROLLBITS   = 0x00020000,
    HTML_PAINTER_Max           = 0x7fffffff,
}

alias HTML_PAINT_ZORDER = int;
enum : int
{
    HTMLPAINT_ZORDER_NONE               = 0x00000000,
    HTMLPAINT_ZORDER_REPLACE_ALL        = 0x00000001,
    HTMLPAINT_ZORDER_REPLACE_CONTENT    = 0x00000002,
    HTMLPAINT_ZORDER_REPLACE_BACKGROUND = 0x00000003,
    HTMLPAINT_ZORDER_BELOW_CONTENT      = 0x00000004,
    HTMLPAINT_ZORDER_BELOW_FLOW         = 0x00000005,
    HTMLPAINT_ZORDER_ABOVE_FLOW         = 0x00000006,
    HTMLPAINT_ZORDER_ABOVE_CONTENT      = 0x00000007,
    HTMLPAINT_ZORDER_WINDOW_TOP         = 0x00000008,
    HTML_PAINT_ZORDER_Max               = 0x7fffffff,
}

alias HTML_PAINT_DRAW_FLAGS = int;
enum : int
{
    HTMLPAINT_DRAW_UPDATEREGION = 0x00000001,
    HTMLPAINT_DRAW_USE_XFORM    = 0x00000002,
    HTML_PAINT_DRAW_FLAGS_Max   = 0x7fffffff,
}

alias HTML_PAINT_EVENT_FLAGS = int;
enum : int
{
    HTMLPAINT_EVENT_TARGET     = 0x00000001,
    HTMLPAINT_EVENT_SETCURSOR  = 0x00000002,
    HTML_PAINT_EVENT_FLAGS_Max = 0x7fffffff,
}

alias HTML_PAINT_DRAW_INFO_FLAGS = int;
enum : int
{
    HTMLPAINT_DRAWINFO_VIEWPORT     = 0x00000001,
    HTMLPAINT_DRAWINFO_UPDATEREGION = 0x00000002,
    HTMLPAINT_DRAWINFO_XFORM        = 0x00000004,
    HTML_PAINT_DRAW_INFO_FLAGS_Max  = 0x7fffffff,
}

alias HTMLDlgFlag = int;
enum : int
{
    HTMLDlgFlagNo     = 0x00000000,
    HTMLDlgFlagOff    = 0x00000000,
    HTMLDlgFlag0      = 0x00000000,
    HTMLDlgFlagYes    = 0x00000001,
    HTMLDlgFlagOn     = 0x00000001,
    HTMLDlgFlag1      = 0x00000001,
    HTMLDlgFlagNotSet = 0xffffffff,
    HTMLDlgFlag_Max   = 0x7fffffff,
}

enum HTMLDlgBorder : int
{
    HTMLDlgBorderThin  = 0x00000000,
    HTMLDlgBorderThick = 0x00040000,
    HTMLDlgBorder_Max  = 0x7fffffff,
}

alias HTMLDlgEdge = int;
enum : int
{
    HTMLDlgEdgeSunken = 0x00000000,
    HTMLDlgEdgeRaised = 0x00000010,
    HTMLDlgEdge_Max   = 0x7fffffff,
}

enum HTMLDlgCenter : int
{
    HTMLDlgCenterNo      = 0x00000000,
    HTMLDlgCenterOff     = 0x00000000,
    HTMLDlgCenter0       = 0x00000000,
    HTMLDlgCenterYes     = 0x00000001,
    HTMLDlgCenterOn      = 0x00000001,
    HTMLDlgCenter1       = 0x00000001,
    HTMLDlgCenterParent  = 0x00000001,
    HTMLDlgCenterDesktop = 0x00000002,
    HTMLDlgCenter_Max    = 0x7fffffff,
}

alias HTMLAppFlag = int;
enum : int
{
    HTMLAppFlagNo   = 0x00000000,
    HTMLAppFlagOff  = 0x00000000,
    HTMLAppFlag0    = 0x00000000,
    HTMLAppFlagYes  = 0x00000001,
    HTMLAppFlagOn   = 0x00000001,
    HTMLAppFlag1    = 0x00000001,
    HTMLAppFlag_Max = 0x7fffffff,
}

enum HTMLMinimizeFlag : int
{
    HTMLMinimizeFlagNo   = 0x00000000,
    HTMLMinimizeFlagYes  = 0x00020000,
    HTMLMinimizeFlag_Max = 0x7fffffff,
}

enum HTMLMaximizeFlag : int
{
    HTMLMaximizeFlagNo   = 0x00000000,
    HTMLMaximizeFlagYes  = 0x00010000,
    HTMLMaximizeFlag_Max = 0x7fffffff,
}

enum HTMLCaptionFlag : int
{
    HTMLCaptionFlagNo   = 0x00000000,
    HTMLCaptionFlagYes  = 0x00c00000,
    HTMLCaptionFlag_Max = 0x7fffffff,
}

enum HTMLSysMenuFlag : int
{
    HTMLSysMenuFlagNo   = 0x00000000,
    HTMLSysMenuFlagYes  = 0x00080000,
    HTMLSysMenuFlag_Max = 0x7fffffff,
}

alias HTMLBorder = int;
enum : int
{
    HTMLBorderNone   = 0x00000000,
    HTMLBorderThick  = 0x00040000,
    HTMLBorderDialog = 0x00400000,
    HTMLBorderThin   = 0x00800000,
    HTMLBorder_Max   = 0x7fffffff,
}

enum HTMLBorderStyle : int
{
    HTMLBorderStyleNormal   = 0x00000000,
    HTMLBorderStyleRaised   = 0x00000100,
    HTMLBorderStyleSunken   = 0x00000200,
    HTMLBorderStylecombined = 0x00000300,
    HTMLBorderStyleStatic   = 0x00020000,
    HTMLBorderStyle_Max     = 0x7fffffff,
}

enum HTMLWindowState : int
{
    HTMLWindowStateNormal   = 0x00000001,
    HTMLWindowStateMaximize = 0x00000003,
    HTMLWindowStateMinimize = 0x00000006,
    HTMLWindowState_Max     = 0x7fffffff,
}

alias BEHAVIOR_EVENT = int;
enum : int
{
    BEHAVIOREVENT_FIRST                 = 0x00000000,
    BEHAVIOREVENT_CONTENTREADY          = 0x00000000,
    BEHAVIOREVENT_DOCUMENTREADY         = 0x00000001,
    BEHAVIOREVENT_APPLYSTYLE            = 0x00000002,
    BEHAVIOREVENT_DOCUMENTCONTEXTCHANGE = 0x00000003,
    BEHAVIOREVENT_CONTENTSAVE           = 0x00000004,
    BEHAVIOREVENT_LAST                  = 0x00000004,
    BEHAVIOR_EVENT_Max                  = 0x7fffffff,
}

alias BEHAVIOR_EVENT_FLAGS = int;
enum : int
{
    BEHAVIOREVENTFLAGS_BUBBLE           = 0x00000001,
    BEHAVIOREVENTFLAGS_STANDARDADDITIVE = 0x00000002,
    BEHAVIOR_EVENT_FLAGS_Max            = 0x7fffffff,
}

alias BEHAVIOR_RENDER_INFO = int;
enum : int
{
    BEHAVIORRENDERINFO_BEFOREBACKGROUND  = 0x00000001,
    BEHAVIORRENDERINFO_AFTERBACKGROUND   = 0x00000002,
    BEHAVIORRENDERINFO_BEFORECONTENT     = 0x00000004,
    BEHAVIORRENDERINFO_AFTERCONTENT      = 0x00000008,
    BEHAVIORRENDERINFO_AFTERFOREGROUND   = 0x00000020,
    BEHAVIORRENDERINFO_ABOVECONTENT      = 0x00000028,
    BEHAVIORRENDERINFO_ALLLAYERS         = 0x000000ff,
    BEHAVIORRENDERINFO_DISABLEBACKGROUND = 0x00000100,
    BEHAVIORRENDERINFO_DISABLENEGATIVEZ  = 0x00000200,
    BEHAVIORRENDERINFO_DISABLECONTENT    = 0x00000400,
    BEHAVIORRENDERINFO_DISABLEPOSITIVEZ  = 0x00000800,
    BEHAVIORRENDERINFO_DISABLEALLLAYERS  = 0x00000f00,
    BEHAVIORRENDERINFO_HITTESTING        = 0x00001000,
    BEHAVIORRENDERINFO_SURFACE           = 0x00100000,
    BEHAVIORRENDERINFO_3DSURFACE         = 0x00200000,
    BEHAVIOR_RENDER_INFO_Max             = 0x7fffffff,
}

alias BEHAVIOR_RELATION = int;
enum : int
{
    BEHAVIOR_FIRSTRELATION = 0x00000000,
    BEHAVIOR_SAMEELEMENT   = 0x00000000,
    BEHAVIOR_PARENT        = 0x00000001,
    BEHAVIOR_CHILD         = 0x00000002,
    BEHAVIOR_SIBLING       = 0x00000003,
    BEHAVIOR_LASTRELATION  = 0x00000003,
    BEHAVIOR_RELATION_Max  = 0x7fffffff,
}

alias BEHAVIOR_LAYOUT_INFO = int;
enum : int
{
    BEHAVIORLAYOUTINFO_FULLDELEGATION = 0x00000001,
    BEHAVIORLAYOUTINFO_MODIFYNATURAL  = 0x00000002,
    BEHAVIORLAYOUTINFO_MAPSIZE        = 0x00000004,
    BEHAVIOR_LAYOUT_INFO_Max          = 0x7fffffff,
}

alias BEHAVIOR_LAYOUT_MODE = int;
enum : int
{
    BEHAVIORLAYOUTMODE_NATURAL          = 0x00000001,
    BEHAVIORLAYOUTMODE_MINWIDTH         = 0x00000002,
    BEHAVIORLAYOUTMODE_MAXWIDTH         = 0x00000004,
    BEHAVIORLAYOUTMODE_MEDIA_RESOLUTION = 0x00004000,
    BEHAVIORLAYOUTMODE_FINAL_PERCENT    = 0x00008000,
    BEHAVIOR_LAYOUT_MODE_Max            = 0x7fffffff,
}

alias ELEMENTDESCRIPTOR_FLAGS = int;
enum : int
{
    ELEMENTDESCRIPTORFLAGS_LITERAL        = 0x00000001,
    ELEMENTDESCRIPTORFLAGS_NESTED_LITERAL = 0x00000002,
    ELEMENTDESCRIPTOR_FLAGS_Max           = 0x7fffffff,
}

alias ELEMENTNAMESPACE_FLAGS = int;
enum : int
{
    ELEMENTNAMESPACEFLAGS_ALLOWANYTAG         = 0x00000001,
    ELEMENTNAMESPACEFLAGS_QUERYFORUNKNOWNTAGS = 0x00000002,
    ELEMENTNAMESPACE_FLAGS_Max                = 0x7fffffff,
}

alias VIEW_OBJECT_ALPHA_MODE = int;
enum : int
{
    VIEW_OBJECT_ALPHA_MODE_IGNORE        = 0x00000000,
    VIEW_OBJECT_ALPHA_MODE_PREMULTIPLIED = 0x00000001,
    VIEW_OBJECT_ALPHA_MODE_Max           = 0x7fffffff,
}

alias VIEW_OBJECT_COMPOSITION_MODE = int;
enum : int
{
    VIEW_OBJECT_COMPOSITION_MODE_LEGACY           = 0x00000000,
    VIEW_OBJECT_COMPOSITION_MODE_SURFACEPRESENTER = 0x00000001,
    VIEW_OBJECT_COMPOSITION_MODE_Max              = 0x7fffffff,
}

alias DOCHOSTUITYPE = int;
enum : int
{
    DOCHOSTUITYPE_BROWSE = 0x00000000,
    DOCHOSTUITYPE_AUTHOR = 0x00000001,
}

alias DOCHOSTUIDBLCLK = int;
enum : int
{
    DOCHOSTUIDBLCLK_DEFAULT        = 0x00000000,
    DOCHOSTUIDBLCLK_SHOWPROPERTIES = 0x00000001,
    DOCHOSTUIDBLCLK_SHOWCODE       = 0x00000002,
}

alias DOCHOSTUIFLAG = int;
enum : int
{
    DOCHOSTUIFLAG_DIALOG                         = 0x00000001,
    DOCHOSTUIFLAG_DISABLE_HELP_MENU              = 0x00000002,
    DOCHOSTUIFLAG_NO3DBORDER                     = 0x00000004,
    DOCHOSTUIFLAG_SCROLL_NO                      = 0x00000008,
    DOCHOSTUIFLAG_DISABLE_SCRIPT_INACTIVE        = 0x00000010,
    DOCHOSTUIFLAG_OPENNEWWIN                     = 0x00000020,
    DOCHOSTUIFLAG_DISABLE_OFFSCREEN              = 0x00000040,
    DOCHOSTUIFLAG_FLAT_SCROLLBAR                 = 0x00000080,
    DOCHOSTUIFLAG_DIV_BLOCKDEFAULT               = 0x00000100,
    DOCHOSTUIFLAG_ACTIVATE_CLIENTHIT_ONLY        = 0x00000200,
    DOCHOSTUIFLAG_OVERRIDEBEHAVIORFACTORY        = 0x00000400,
    DOCHOSTUIFLAG_CODEPAGELINKEDFONTS            = 0x00000800,
    DOCHOSTUIFLAG_URL_ENCODING_DISABLE_UTF8      = 0x00001000,
    DOCHOSTUIFLAG_URL_ENCODING_ENABLE_UTF8       = 0x00002000,
    DOCHOSTUIFLAG_ENABLE_FORMS_AUTOCOMPLETE      = 0x00004000,
    DOCHOSTUIFLAG_ENABLE_INPLACE_NAVIGATION      = 0x00010000,
    DOCHOSTUIFLAG_IME_ENABLE_RECONVERSION        = 0x00020000,
    DOCHOSTUIFLAG_THEME                          = 0x00040000,
    DOCHOSTUIFLAG_NOTHEME                        = 0x00080000,
    DOCHOSTUIFLAG_NOPICS                         = 0x00100000,
    DOCHOSTUIFLAG_NO3DOUTERBORDER                = 0x00200000,
    DOCHOSTUIFLAG_DISABLE_EDIT_NS_FIXUP          = 0x00400000,
    DOCHOSTUIFLAG_LOCAL_MACHINE_ACCESS_CHECK     = 0x00800000,
    DOCHOSTUIFLAG_DISABLE_UNTRUSTEDPROTOCOL      = 0x01000000,
    DOCHOSTUIFLAG_HOST_NAVIGATES                 = 0x02000000,
    DOCHOSTUIFLAG_ENABLE_REDIRECT_NOTIFICATION   = 0x04000000,
    DOCHOSTUIFLAG_USE_WINDOWLESS_SELECTCONTROL   = 0x08000000,
    DOCHOSTUIFLAG_USE_WINDOWED_SELECTCONTROL     = 0x10000000,
    DOCHOSTUIFLAG_ENABLE_ACTIVEX_INACTIVATE_MODE = 0x20000000,
    DOCHOSTUIFLAG_DPI_AWARE                      = 0x40000000,
}

// Constants


enum uint DISPID_STYLESHEETSCOLLECTION_NAMED_MAX = 0x001e847fU;
enum uint IDM_UNKNOWN = 0x00000000U;

enum : uint
{
    IDM_ALIGNBOTTOM            = 0x00000001U,
    IDM_ALIGNHORIZONTALCENTERS = 0x00000002U,
}

enum : uint
{
    IDM_ALIGNLEFT            = 0x00000003U,
    IDM_ALIGNRIGHT           = 0x00000004U,
    IDM_ALIGNTOGRID          = 0x00000005U,
    IDM_ALIGNTOP             = 0x00000006U,
    IDM_ALIGNVERTICALCENTERS = 0x00000007U,
}

enum : uint
{
    IDM_ARRANGEBOTTOM = 0x00000008U,
    IDM_ARRANGERIGHT  = 0x00000009U,
}

enum : uint
{
    IDM_BRINGFORWARD = 0x0000000aU,
    IDM_BRINGTOFRONT = 0x0000000bU,
}

enum : uint
{
    IDM_CENTERHORIZONTALLY = 0x0000000cU,
    IDM_CENTERVERTICALLY   = 0x0000000dU,
}

enum : uint
{
    IDM_CODE   = 0x0000000eU,
    IDM_DELETE = 0x00000011U,
}

enum : uint
{
    IDM_FONTNAME = 0x00000012U,
    IDM_FONTSIZE = 0x00000013U,
}

enum : uint
{
    IDM_GROUP                 = 0x00000014U,
    IDM_HORIZSPACECONCATENATE = 0x00000015U,
    IDM_HORIZSPACEDECREASE    = 0x00000016U,
    IDM_HORIZSPACEINCREASE    = 0x00000017U,
    IDM_HORIZSPACEMAKEEQUAL   = 0x00000018U,
}

enum uint IDM_INSERTOBJECT = 0x00000019U;
enum uint IDM_MULTILEVELREDO = 0x0000001eU;

enum : uint
{
    IDM_SENDBACKWARD = 0x00000020U,
    IDM_SENDTOBACK   = 0x00000021U,
}

enum uint IDM_SHOWTABLE = 0x00000022U;

enum : uint
{
    IDM_SIZETOCONTROL       = 0x00000023U,
    IDM_SIZETOCONTROLHEIGHT = 0x00000024U,
    IDM_SIZETOCONTROLWIDTH  = 0x00000025U,
    IDM_SIZETOFIT           = 0x00000026U,
    IDM_SIZETOGRID          = 0x00000027U,
}

enum uint IDM_SNAPTOGRID = 0x00000028U;

enum : uint
{
    IDM_TABORDER = 0x00000029U,
    IDM_TOOLBOX  = 0x0000002aU,
}

enum uint IDM_MULTILEVELUNDO = 0x0000002cU;
enum uint IDM_UNGROUP = 0x0000002dU;

enum : uint
{
    IDM_VERTSPACECONCATENATE = 0x0000002eU,
    IDM_VERTSPACEDECREASE    = 0x0000002fU,
    IDM_VERTSPACEINCREASE    = 0x00000030U,
    IDM_VERTSPACEMAKEEQUAL   = 0x00000031U,
}

enum uint IDM_JUSTIFYFULL = 0x00000032U;
enum uint IDM_BACKCOLOR = 0x00000033U;

enum : uint
{
    IDM_BOLD        = 0x00000034U,
    IDM_BORDERCOLOR = 0x00000035U,
}

enum : uint
{
    IDM_FLAT      = 0x00000036U,
    IDM_FORECOLOR = 0x00000037U,
}

enum uint IDM_ITALIC = 0x00000038U;

enum : uint
{
    IDM_JUSTIFYCENTER  = 0x00000039U,
    IDM_JUSTIFYGENERAL = 0x0000003aU,
    IDM_JUSTIFYLEFT    = 0x0000003bU,
    IDM_JUSTIFYRIGHT   = 0x0000003cU,
}

enum uint IDM_RAISED = 0x0000003dU;
enum uint IDM_SUNKEN = 0x0000003eU;
enum uint IDM_UNDERLINE = 0x0000003fU;
enum uint IDM_CHISELED = 0x00000040U;
enum uint IDM_ETCHED = 0x00000041U;
enum uint IDM_SHADOWED = 0x00000042U;

enum : uint
{
    IDM_FIND     = 0x00000043U,
    IDM_SHOWGRID = 0x00000045U,
}

enum : uint
{
    IDM_OBJECTVERBLIST0    = 0x00000048U,
    IDM_OBJECTVERBLIST1    = 0x00000049U,
    IDM_OBJECTVERBLIST2    = 0x0000004aU,
    IDM_OBJECTVERBLIST3    = 0x0000004bU,
    IDM_OBJECTVERBLIST4    = 0x0000004cU,
    IDM_OBJECTVERBLIST5    = 0x0000004dU,
    IDM_OBJECTVERBLIST6    = 0x0000004eU,
    IDM_OBJECTVERBLIST7    = 0x0000004fU,
    IDM_OBJECTVERBLIST8    = 0x00000050U,
    IDM_OBJECTVERBLIST9    = 0x00000051U,
    IDM_OBJECTVERBLISTLAST = 0x00000051U,
}

enum uint IDM_CONVERTOBJECT = 0x00000052U;

enum : uint
{
    IDM_CUSTOMCONTROL = 0x00000053U,
    IDM_CUSTOMIZEITEM = 0x00000054U,
}

enum uint IDM_RENAME = 0x00000055U;
enum uint IDM_IMPORT = 0x00000056U;
enum uint IDM_NEWPAGE = 0x00000057U;

enum : uint
{
    IDM_MOVE   = 0x00000058U,
    IDM_CANCEL = 0x00000059U,
}

enum : uint
{
    IDM_FONT          = 0x0000005aU,
    IDM_STRIKETHROUGH = 0x0000005bU,
}

enum uint IDM_DELETEWORD = 0x0000005cU;
enum uint IDM_EXECPRINT = 0x0000005dU;
enum uint IDM_JUSTIFYNONE = 0x0000005eU;

enum : uint
{
    IDM_TRISTATEBOLD      = 0x0000005fU,
    IDM_TRISTATEITALIC    = 0x00000060U,
    IDM_TRISTATEUNDERLINE = 0x00000061U,
}

enum uint IDM_FORWARDDELETE = 0x00000062U;
enum uint IDM_FOLLOW_ANCHOR = 0x000007d8U;

enum : uint
{
    IDM_INSINPUTIMAGE  = 0x00000842U,
    IDM_INSINPUTBUTTON = 0x00000843U,
    IDM_INSINPUTRESET  = 0x00000844U,
    IDM_INSINPUTSUBMIT = 0x00000845U,
    IDM_INSINPUTUPLOAD = 0x00000846U,
}

enum uint IDM_INSFIELDSET = 0x00000847U;
enum uint IDM_PASTEINSERT = 0x00000848U;
enum uint IDM_REPLACE = 0x00000849U;
enum uint IDM_EDITSOURCE = 0x0000084aU;
enum uint IDM_BOOKMARK = 0x0000084bU;
enum uint IDM_HYPERLINK = 0x0000084cU;
enum uint IDM_UNLINK = 0x0000084dU;
enum uint IDM_BROWSEMODE = 0x0000084eU;
enum uint IDM_EDITMODE = 0x0000084fU;
enum uint IDM_UNBOOKMARK = 0x00000850U;
enum uint IDM_TOOLBARS = 0x00000852U;
enum uint IDM_STATUSBAR = 0x00000853U;
enum uint IDM_FORMATMARK = 0x00000854U;
enum uint IDM_TEXTONLY = 0x00000855U;
enum uint IDM_OPTIONS = 0x00000857U;

enum : uint
{
    IDM_FOLLOWLINKC = 0x00000858U,
    IDM_FOLLOWLINKN = 0x00000859U,
}

enum uint IDM_VIEWSOURCE = 0x0000085bU;
enum uint IDM_ZOOMPOPUP = 0x0000085cU;

enum : uint
{
    IDM_BASELINEFONT1 = 0x0000085dU,
    IDM_BASELINEFONT2 = 0x0000085eU,
    IDM_BASELINEFONT3 = 0x0000085fU,
    IDM_BASELINEFONT4 = 0x00000860U,
    IDM_BASELINEFONT5 = 0x00000861U,
}

enum uint IDM_HORIZONTALLINE = 0x00000866U;

enum : uint
{
    IDM_LINEBREAKNORMAL = 0x00000867U,
    IDM_LINEBREAKLEFT   = 0x00000868U,
    IDM_LINEBREAKRIGHT  = 0x00000869U,
    IDM_LINEBREAKBOTH   = 0x0000086aU,
}

enum uint IDM_NONBREAK = 0x0000086bU;
enum uint IDM_SPECIALCHAR = 0x0000086cU;
enum uint IDM_HTMLSOURCE = 0x0000086dU;
enum uint IDM_IFRAME = 0x0000086eU;
enum uint IDM_HTMLCONTAIN = 0x0000086fU;

enum : uint
{
    IDM_TEXTBOX  = 0x00000871U,
    IDM_TEXTAREA = 0x00000872U,
}

enum uint IDM_CHECKBOX = 0x00000873U;
enum uint IDM_RADIOBUTTON = 0x00000874U;
enum uint IDM_DROPDOWNBOX = 0x00000875U;
enum uint IDM_LISTBOX = 0x00000876U;
enum uint IDM_BUTTON = 0x00000877U;

enum : uint
{
    IDM_IMAGE  = 0x00000878U,
    IDM_OBJECT = 0x00000879U,
}

enum : uint
{
    IDM_1D       = 0x0000087aU,
    IDM_IMAGEMAP = 0x0000087bU,
}

enum : uint
{
    IDM_FILE    = 0x0000087cU,
    IDM_COMMENT = 0x0000087dU,
}

enum uint IDM_SCRIPT = 0x0000087eU;
enum uint IDM_JAVAAPPLET = 0x0000087fU;

enum : uint
{
    IDM_PLUGIN    = 0x00000880U,
    IDM_PAGEBREAK = 0x00000881U,
}

enum uint IDM_HTMLAREA = 0x00000882U;
enum uint IDM_PARAGRAPH = 0x00000884U;

enum : uint
{
    IDM_FORM    = 0x00000885U,
    IDM_MARQUEE = 0x00000886U,
}

enum : uint
{
    IDM_LIST      = 0x00000887U,
    IDM_ORDERLIST = 0x00000888U,
}

enum uint IDM_UNORDERLIST = 0x00000889U;
enum uint IDM_INDENT = 0x0000088aU;
enum uint IDM_OUTDENT = 0x0000088bU;
enum uint IDM_PREFORMATTED = 0x0000088cU;
enum uint IDM_ADDRESS = 0x0000088dU;

enum : uint
{
    IDM_BLINK       = 0x0000088eU,
    IDM_DIV         = 0x0000088fU,
    IDM_TABLEINSERT = 0x00000898U,
}

enum uint IDM_RCINSERT = 0x00000899U;
enum uint IDM_CELLINSERT = 0x0000089aU;
enum uint IDM_CAPTIONINSERT = 0x0000089bU;

enum : uint
{
    IDM_CELLMERGE  = 0x0000089cU,
    IDM_CELLSPLIT  = 0x0000089dU,
    IDM_CELLSELECT = 0x0000089eU,
}

enum uint IDM_ROWSELECT = 0x0000089fU;
enum uint IDM_COLUMNSELECT = 0x000008a0U;

enum : uint
{
    IDM_TABLESELECT     = 0x000008a1U,
    IDM_TABLEPROPERTIES = 0x000008a2U,
}

enum uint IDM_CELLPROPERTIES = 0x000008a3U;
enum uint IDM_ROWINSERT = 0x000008a4U;
enum uint IDM_COLUMNINSERT = 0x000008a5U;

enum : uint
{
    IDM_HELP_CONTENT = 0x000008acU,
    IDM_HELP_ABOUT   = 0x000008adU,
    IDM_HELP_README  = 0x000008aeU,
}

enum uint IDM_REMOVEFORMAT = 0x000008b6U;
enum uint IDM_PAGEINFO = 0x000008b7U;
enum uint IDM_TELETYPE = 0x000008b8U;
enum uint IDM_GETBLOCKFMTS = 0x000008b9U;
enum uint IDM_BLOCKFMT = 0x000008baU;
enum uint IDM_SHOWHIDE_CODE = 0x000008bbU;

enum : uint
{
    IDM_TABLE      = 0x000008bcU,
    IDM_COPYFORMAT = 0x000008bdU,
}

enum uint IDM_PASTEFORMAT = 0x000008beU;

enum : uint
{
    IDM_GOTO           = 0x000008bfU,
    IDM_CHANGEFONT     = 0x000008c0U,
    IDM_CHANGEFONTSIZE = 0x000008c1U,
    IDM_CHANGECASE     = 0x000008c6U,
}

enum uint IDM_SHOWSPECIALCHAR = 0x000008c9U;

enum : uint
{
    IDM_SUBSCRIPT   = 0x000008c7U,
    IDM_SUPERSCRIPT = 0x000008c8U,
}

enum uint IDM_CENTERALIGNPARA = 0x000008caU;
enum uint IDM_LEFTALIGNPARA = 0x000008cbU;
enum uint IDM_RIGHTALIGNPARA = 0x000008ccU;
enum uint IDM_REMOVEPARAFORMAT = 0x000008cdU;

enum : uint
{
    IDM_APPLYNORMAL   = 0x000008ceU,
    IDM_APPLYHEADING1 = 0x000008cfU,
    IDM_APPLYHEADING2 = 0x000008d0U,
    IDM_APPLYHEADING3 = 0x000008d1U,
}

enum uint IDM_DOCPROPERTIES = 0x000008d4U;
enum uint IDM_ADDFAVORITES = 0x000008d5U;
enum uint IDM_COPYSHORTCUT = 0x000008d6U;
enum uint IDM_SAVEBACKGROUND = 0x000008d7U;
enum uint IDM_SETWALLPAPER = 0x000008d8U;
enum uint IDM_COPYBACKGROUND = 0x000008d9U;
enum uint IDM_CREATESHORTCUT = 0x000008daU;

enum : uint
{
    IDM_PAGE       = 0x000008dbU,
    IDM_SAVETARGET = 0x000008dcU,
}

enum uint IDM_SHOWPICTURE = 0x000008ddU;
enum uint IDM_SAVEPICTURE = 0x000008deU;

enum : uint
{
    IDM_DYNSRCPLAY = 0x000008dfU,
    IDM_DYNSRCSTOP = 0x000008e0U,
}

enum uint IDM_PRINTTARGET = 0x000008e1U;

enum : uint
{
    IDM_IMGARTPLAY   = 0x000008e2U,
    IDM_IMGARTSTOP   = 0x000008e3U,
    IDM_IMGARTREWIND = 0x000008e4U,
}

enum uint IDM_PRINTQUERYJOBSPENDING = 0x000008e5U;
enum uint IDM_SETDESKTOPITEM = 0x000008e6U;
enum uint IDM_CONTEXTMENU = 0x000008e8U;

enum : uint
{
    IDM_GOBACKWARD = 0x000008eaU,
    IDM_GOFORWARD  = 0x000008ebU,
}

enum uint IDM_PRESTOP = 0x000008ecU;

enum : uint
{
    IDM_GOTOCLIPBOARDADDRESS = 0x000008edU,
    IDM_GOTOCLIPBOARDTEXT    = 0x000008eeU,
}

enum : uint
{
    IDM_MP_MYPICS       = 0x000008efU,
    IDM_MP_EMAILPICTURE = 0x000008f0U,
}

enum uint IDM_MP_PRINTPICTURE = 0x000008f1U;
enum uint IDM_CREATELINK = 0x000008f2U;
enum uint IDM_COPYCONTENT = 0x000008f3U;
enum uint IDM_LANGUAGE = 0x000008f4U;
enum uint IDM_GETPRINTTEMPLATE = 0x000008f7U;
enum uint IDM_SETPRINTTEMPLATE = 0x000008f8U;
enum uint IDM_TEMPLATE_PAGESETUP = 0x000008faU;
enum uint IDM_REFRESH = 0x000008fcU;
enum uint IDM_STOPDOWNLOAD = 0x000008fdU;
enum uint IDM_ENABLE_INTERACTION = 0x000008feU;
enum uint IDM_LAUNCHDEBUGGER = 0x00000906U;
enum uint IDM_BREAKATNEXT = 0x00000907U;

enum : uint
{
    IDM_INSINPUTHIDDEN   = 0x00000908U,
    IDM_INSINPUTPASSWORD = 0x00000909U,
}

enum uint IDM_OVERWRITE = 0x0000090aU;
enum uint IDM_PARSECOMPLETE = 0x0000090bU;
enum uint IDM_HTMLEDITMODE = 0x0000090cU;
enum uint IDM_REGISTRYREFRESH = 0x0000090dU;
enum uint IDM_COMPOSESETTINGS = 0x0000090eU;

enum : uint
{
    IDM_SHOWALLTAGS         = 0x00000917U,
    IDM_SHOWALIGNEDSITETAGS = 0x00000911U,
}

enum : uint
{
    IDM_SHOWSCRIPTTAGS             = 0x00000912U,
    IDM_SHOWSTYLETAGS              = 0x00000913U,
    IDM_SHOWCOMMENTTAGS            = 0x00000914U,
    IDM_SHOWAREATAGS               = 0x00000915U,
    IDM_SHOWUNKNOWNTAGS            = 0x00000916U,
    IDM_SHOWMISCTAGS               = 0x00000910U,
    IDM_SHOWZEROBORDERATDESIGNTIME = 0x00000918U,
}

enum uint IDM_AUTODETECT = 0x00000919U;
enum uint IDM_SCRIPTDEBUGGER = 0x0000091aU;
enum uint IDM_GETBYTESDOWNLOADED = 0x0000091bU;

enum : uint
{
    IDM_NOACTIVATENORMALOLECONTROLS  = 0x0000091cU,
    IDM_NOACTIVATEDESIGNTIMECONTROLS = 0x0000091dU,
    IDM_NOACTIVATEJAVAAPPLETS        = 0x0000091eU,
}

enum uint IDM_NOFIXUPURLSONPASTE = 0x0000091fU;
enum uint IDM_EMPTYGLYPHTABLE = 0x00000920U;
enum uint IDM_ADDTOGLYPHTABLE = 0x00000921U;
enum uint IDM_REMOVEFROMGLYPHTABLE = 0x00000922U;
enum uint IDM_REPLACEGLYPHCONTENTS = 0x00000923U;
enum uint IDM_SHOWWBRTAGS = 0x00000924U;
enum uint IDM_PERSISTSTREAMSYNC = 0x00000925U;
enum uint IDM_SETDIRTY = 0x00000926U;
enum uint IDM_RUNURLSCRIPT = 0x00000927U;
enum uint IDM_ZOOMRATIO = 0x00000928U;

enum : uint
{
    IDM_GETZOOMNUMERATOR   = 0x00000929U,
    IDM_GETZOOMDENOMINATOR = 0x0000092aU,
}

enum : uint
{
    IDM_DIRLTR = 0x0000092eU,
    IDM_DIRRTL = 0x0000092fU,
}

enum : uint
{
    IDM_BLOCKDIRLTR = 0x00000930U,
    IDM_BLOCKDIRRTL = 0x00000931U,
}

enum : uint
{
    IDM_INLINEDIRLTR = 0x00000932U,
    IDM_INLINEDIRRTL = 0x00000933U,
}

enum uint IDM_ISTRUSTEDDLG = 0x00000934U;
enum uint IDM_INSERTSPAN = 0x00000935U;
enum uint IDM_LOCALIZEEDITOR = 0x00000936U;
enum uint IDM_SAVEPRETRANSFORMSOURCE = 0x00000942U;
enum uint IDM_VIEWPRETRANSFORMSOURCE = 0x00000943U;

enum : uint
{
    IDM_SCROLL_HERE      = 0x0000094cU,
    IDM_SCROLL_TOP       = 0x0000094dU,
    IDM_SCROLL_BOTTOM    = 0x0000094eU,
    IDM_SCROLL_PAGEUP    = 0x0000094fU,
    IDM_SCROLL_PAGEDOWN  = 0x00000950U,
    IDM_SCROLL_UP        = 0x00000951U,
    IDM_SCROLL_DOWN      = 0x00000952U,
    IDM_SCROLL_LEFTEDGE  = 0x00000953U,
    IDM_SCROLL_RIGHTEDGE = 0x00000954U,
    IDM_SCROLL_PAGELEFT  = 0x00000955U,
    IDM_SCROLL_PAGERIGHT = 0x00000956U,
    IDM_SCROLL_LEFT      = 0x00000957U,
    IDM_SCROLL_RIGHT     = 0x00000958U,
}

enum uint IDM_MULTIPLESELECTION = 0x00000959U;

enum : uint
{
    IDM_2D_POSITION = 0x0000095aU,
    IDM_2D_ELEMENT  = 0x0000095bU,
}

enum uint IDM_1D_ELEMENT = 0x0000095cU;
enum uint IDM_ABSOLUTE_POSITION = 0x0000095dU;
enum uint IDM_LIVERESIZE = 0x0000095eU;
enum uint IDM_ATOMICSELECTION = 0x0000095fU;
enum uint IDM_AUTOURLDETECT_MODE = 0x00000960U;

enum : uint
{
    IDM_IE50_PASTE      = 0x00000961U,
    IDM_IE50_PASTE_MODE = 0x00000962U,
}

enum uint IDM_GETIPRINT = 0x00000963U;
enum uint IDM_DISABLE_EDITFOCUS_UI = 0x00000964U;
enum uint IDM_RESPECTVISIBILITY_INDESIGN = 0x00000965U;
enum uint IDM_CSSEDITING_LEVEL = 0x00000966U;
enum uint IDM_UI_OUTDENT = 0x00000967U;
enum uint IDM_UPDATEPAGESTATUS = 0x00000968U;
enum uint IDM_IME_ENABLE_RECONVERSION = 0x00000969U;
enum uint IDM_KEEPSELECTION = 0x0000096aU;
enum uint IDM_UNLOADDOCUMENT = 0x0000096bU;
enum uint IDM_OVERRIDE_CURSOR = 0x00000974U;
enum uint IDM_PEERHITTESTSAMEINEDIT = 0x00000977U;
enum uint IDM_TRUSTAPPCACHE = 0x00000979U;
enum uint IDM_BACKGROUNDIMAGECACHE = 0x0000097eU;
enum uint IDM_GETUSERACTIONTIME = 0x0000097fU;
enum uint IDM_BEGINUSERACTION = 0x00000980U;
enum uint IDM_ENDUSERACTION = 0x00000981U;
enum uint IDM_SETCUSTOMCURSOR = 0x00000982U;
enum uint IDM_FOLLOWLINKT = 0x00000983U;
enum uint IDM_CARETBROWSINGMODE = 0x00000984U;

enum : uint
{
    IDM_STYLEMENU_SETNOSTYLE          = 0x00000985U,
    IDM_STYLEMENU_GETNOSTYLE          = 0x00000986U,
    IDM_STYLEMENU_GETPREFSTYLE        = 0x00000987U,
    IDM_STYLEMENU_CHANGESELECTEDSTYLE = 0x00000988U,
}

enum : uint
{
    IDM_MEDIA_PLAYPAUSE         = 0x00000989U,
    IDM_MEDIA_MUTEUNMUTE        = 0x0000098aU,
    IDM_MEDIA_PLAY              = 0x0000098bU,
    IDM_MEDIA_PAUSE             = 0x0000098cU,
    IDM_MEDIA_STOP              = 0x0000098dU,
    IDM_MEDIA_FULLSCREEN_TOGGLE = 0x0000098eU,
    IDM_MEDIA_FULLSCREEN_EXIT   = 0x0000098fU,
}

enum : uint
{
    IDM_MEDIA_VOLUME_UP       = 0x00000990U,
    IDM_MEDIA_VOLUME_DOWN     = 0x00000991U,
    IDM_MEDIA_SEEK_TO_START   = 0x00000992U,
    IDM_MEDIA_SEEK_TO_END     = 0x00000993U,
    IDM_MEDIA_SEEK_FWD_SMALL  = 0x00000994U,
    IDM_MEDIA_SEEK_BACK_SMALL = 0x00000995U,
    IDM_MEDIA_SEEK_FWD_LARGE  = 0x00000996U,
    IDM_MEDIA_SEEK_BACK_LARGE = 0x00000997U,
}

enum : uint
{
    IDM_MEDIA_RATE_FASTER         = 0x00000998U,
    IDM_MEDIA_RATE_SLOWER         = 0x00000999U,
    IDM_MEDIA_SHOWCONTROLS_TOGGLE = 0x0000099aU,
}

enum uint IDM_MEDIA_ZOOMMODE_TOGGLE = 0x0000099bU;

enum : uint
{
    IDM_MEDIA_FRAMESTEP_FWD        = 0x0000099cU,
    IDM_MEDIA_FRAMESTEP_BACK       = 0x0000099dU,
    IDM_MEDIA_MUTE                 = 0x0000099eU,
    IDM_MEDIA_UNMUTE               = 0x0000099fU,
    IDM_MEDIA_SHOW_AUDIO_ACCESS    = 0x000009a0U,
    IDM_MEDIA_SHOW_SUBTITLE_ACCESS = 0x000009a1U,
}

enum : uint
{
    IDM_MEDIA_PLAYRATE0 = 0x000009b0U,
    IDM_MEDIA_PLAYRATE1 = 0x000009b1U,
    IDM_MEDIA_PLAYRATE2 = 0x000009b2U,
    IDM_MEDIA_PLAYRATE3 = 0x000009b3U,
    IDM_MEDIA_PLAYRATE4 = 0x000009b4U,
    IDM_MEDIA_PLAYRATE5 = 0x000009b5U,
    IDM_MEDIA_PLAYRATE6 = 0x000009b6U,
    IDM_MEDIA_PLAYRATE7 = 0x000009b7U,
    IDM_MEDIA_PLAYRATE8 = 0x000009b8U,
    IDM_MEDIA_PLAYRATE9 = 0x000009b9U,
}

enum : uint
{
    IDM_PASTECONTENTONLY = 0x000009c4U,
    IDM_PASTETEXTONLY    = 0x000009c5U,
}

enum uint IDM_INSERTHTML = 0x000009c6U;
enum uint IDM_DEFAULTBLOCK = 0x0000179eU;

enum : uint
{
    IDM_MIMECSET__FIRST__ = 0x00000e19U,
    IDM_MIMECSET__LAST__  = 0x00000e73U,
}

enum : uint
{
    IDM_MENUEXT_FIRST__ = 0x00000e74U,
    IDM_MENUEXT_LAST__  = 0x00000e94U,
    IDM_MENUEXT_COUNT   = 0x00000e95U,
}

enum uint IDM_ADDCONSOLEMESSAGERECEIVER = 0x00000ed8U;
enum uint IDM_REMOVECONSOLEMESSAGERECEIVER = 0x00000ed9U;
enum uint IDM_STARTDIAGNOSTICSMODE = 0x00000edaU;
enum uint IDM_GETSCRIPTENGINE = 0x00000edbU;
enum uint IDM_ADDDEBUGCALLBACKRECEIVER = 0x00000edcU;
enum uint IDM_REMOVEDEBUGCALLBACKRECEIVER = 0x00000eddU;
enum uint IDM_DEFAULTPARAGRAPHSEPARATOR = 0x00000f3cU;
enum uint IDM_BEGINUNDOUNIT = 0x00000f3dU;
enum uint IDM_ENDUNDOUNIT = 0x00000f3eU;
enum uint IDM_CLEARUNDO = 0x00000f3fU;
enum uint IDM_INSPECTELEMENT = 0x00000f40U;
enum uint IDM_SHAREPICTURE = 0x00000f41U;
enum uint IDM_ENABLE_OBJECT_RESIZING = 0x00000f42U;
enum uint IDM_INSERTTEXT = 0x00000f43U;
enum uint IDM_LAUNCHURICALLBACK = 0x00000f44U;

enum : uint
{
    IDM_FOLLOWLINKN_INPRIVATE = 0x00000f45U,
    IDM_FOLLOWLINKT_INPRIVATE = 0x00000f46U,
    IDM_FOLLOWLINKEDGE        = 0x00000f47U,
}

enum : uint
{
    IDM_OPEN       = 0x000007d0U,
    IDM_NEW        = 0x000007d1U,
    IDM_SAVE       = 0x00000046U,
    IDM_SAVEAS     = 0x00000047U,
    IDM_SAVECOPYAS = 0x000007d2U,
}

enum uint IDM_PRINTPREVIEW = 0x000007d3U;

enum : uint
{
    IDM_SHOWPRINT     = 0x000007daU,
    IDM_SHOWPAGESETUP = 0x000007dbU,
}

enum : uint
{
    IDM_PRINT     = 0x0000001bU,
    IDM_PAGESETUP = 0x000007d4U,
}

enum : uint
{
    IDM_SPELL        = 0x000007d5U,
    IDM_PASTESPECIAL = 0x000007d6U,
}

enum uint IDM_CLEARSELECTION = 0x000007d7U;
enum uint IDM_PROPERTIES = 0x0000001cU;

enum : uint
{
    IDM_REDO      = 0x0000001dU,
    IDM_UNDO      = 0x0000002bU,
    IDM_SELECTALL = 0x0000001fU,
}

enum uint IDM_ZOOMPERCENT = 0x00000032U;
enum uint IDM_GETZOOM = 0x00000044U;

enum : uint
{
    IDM_STOP    = 0x0000085aU,
    IDM_COPY    = 0x0000000fU,
    IDM_CUT     = 0x00000010U,
    IDM_PASTE   = 0x0000001aU,
    IDM_SAVEPDF = 0x00000063U,
}

enum uint IDM_TOGGLEREADINGBAR = 0x00003b69U;
enum uint IDM_ADDPDFHIGHLIGHT = 0x00003b6aU;
enum uint IDM_DELETEPDFHIGHLIGHT = 0x00003b6bU;
enum uint IDM_ADDPDFNOTE = 0x00003b6cU;
enum uint IDM_OPENPDFNOTE = 0x00003b6dU;
enum uint IDM_EDITPDFHIGHLIGHT = 0x00003b6eU;
enum uint IDM_PINKHIGHLIGHT = 0x00003b6fU;
enum uint IDM_BLUEHIGHLIGHT = 0x00003b70U;
enum uint IDM_GREENHIGHLIGHT = 0x00003b71U;
enum uint IDM_YELLOWHIGHLIGHT = 0x00003b72U;
enum uint IDM_NONEHIGHLIGHT = 0x00003b73U;
enum uint IDM_PDFREADALOUD = 0x00003b74U;
enum uint IDM_SHAREPDF = 0x00003b75U;
enum uint IDM_PDFDEFINE = 0x00003b76U;

enum : int
{
    CMD_ZOOM_PAGEWIDTH = 0xffffffff,
    CMD_ZOOM_ONEPAGE   = 0xfffffffe,
    CMD_ZOOM_TWOPAGES  = 0xfffffffd,
    CMD_ZOOM_SELECTION = 0xfffffffc,
    CMD_ZOOM_FIT       = 0xfffffffb,
}

enum uint IDM_CONTEXT = 0x00000001U;

enum : uint
{
    IDM_HWND               = 0x00000002U,
    IDM_NEW_TOPLEVELWINDOW = 0x00001b8aU,
}

enum uint IDM_PRESERVEUNDOALWAYS = 0x000017a1U;
enum uint IDM_PERSISTDEFAULTVALUES = 0x00001bbcU;
enum uint IDM_PROTECTMETATAGS = 0x00001bbdU;
enum uint IDM_GETFRAMEZONE = 0x00001795U;
enum uint IDM_REFRESH_THIS = 0x0000179aU;
enum uint IDM_MENUEXT_PLACEHOLDER = 0x0000179fU;

enum : uint
{
    IDM_FIRE_PRINTTEMPLATEUP   = 0x00003a98U,
    IDM_FIRE_PRINTTEMPLATEDOWN = 0x00003a99U,
}

enum uint IDM_SETPRINTHANDLES = 0x00003a9aU;
enum uint IDM_CLEARAUTHENTICATIONCACHE = 0x00003a9bU;
enum uint IDM_GETUSERINITFLAGS = 0x00003a9cU;
enum uint IDM_GETDOCDLGFLAGS = 0x00003a9dU;
enum uint IDM_OLEWINDOWSTATECHANGED = 0x00003a9eU;
enum uint IDM_ACTIVEXINSTALLSCOPE = 0x00003a9fU;
enum uint IDM_SETSESSIONDOCUMENTMODE = 0x00003aa0U;
enum uint IDM_GETSESSIONDOCUMENTMODE = 0x00003aa1U;
enum uint IDM_SETPROFILINGONSTART = 0x00003aa2U;
enum uint IDM_GETPROFILINGONSTART = 0x00003aa3U;
enum uint IDM_SETSCRIPTCONSOLE = 0x00003aa4U;
enum uint IDM_SETNAVIGATEEVENTSINK = 0x00003aa5U;
enum uint IDM_SETDEVTOOLBARCONSOLE = 0x00003aa8U;
enum uint IDM_POPSTATEEVENT = 0x00003aa9U;
enum uint IDM_SETPARTIALLAYOUTSTATUS = 0x00003aadU;
enum uint IDM_GETPARTIALLAYOUTSTATUS = 0x00003aaeU;
enum uint IDM_ADDPARTIALTESTSTEPCOUNT = 0x00003aafU;
enum uint IDM_SETL9QUIRKSEMULATIONENABLED = 0x00003ab0U;
enum uint IDM_GETL9QUIRKSEMULATIONENABLED = 0x00003ab1U;
enum uint IDM_SETPOINTERLOCKCONSENT = 0x00003ab2U;
enum uint IDM_GETDEFAULTZOOMLEVEL = 0x00003ab3U;
enum uint IDM_GETELEMENTBOUNDINGBOX = 0x00003ab4U;
enum uint IDM_SETGEOLOCATIONCONSENT = 0x00003ab5U;
enum uint IDM_ACTIVEXFILTERINGENABLED = 0x00003ab6U;

enum : uint
{
    IDM_SHARE              = 0x00003ab7U,
    IDM_SHAREAPPCACHEEVENT = 0x00003ab9U,
}

enum uint IDM_GETPRINTMANAGERDOCSOURCE = 0x00003abeU;
enum uint IDM_SETEXTRAHEADERS = 0x00003abfU;
enum uint IDM_SETACCESSIBILITYNAME = 0x00003ac0U;
enum uint IDM_UPDATESETTINGSFROMREGISTRY = 0x00003ac1U;
enum uint IDM_PERFORMEDITACTIVATION = 0x00003ac2U;
enum uint IDM_SETDEFAULTBACKGROUNDCOLOR = 0x00003ac3U;
enum uint IDM_GETDEFAULTBACKGROUNDCOLOR = 0x00003ac4U;
enum uint IDM_NOTIFYZOOMANDSCROLLANIMATIONEND = 0x00003ac5U;
enum uint IDM_NOTIFYCONTEXTMENUDISMISSED = 0x00003ac6U;
enum uint IDM_GETPRINTMANAGERDOCSOURCEASYNC = 0x00003ac7U;
enum uint IDM_SETPAGEACTIONALLOWEDFLAGS = 0x00003afcU;
enum uint IDM_INVOKEFLIPAHEADTARGET = 0x00003b60U;
enum uint IDM_ENABLEFLIPAHEADTARGET = 0x00003b61U;

enum : uint
{
    IDM_DEBUGGERDYNAMICATTACH              = 0x00003b62U,
    IDM_DEBUGGERDYNAMICDETACH              = 0x00003b63U,
    IDM_DEBUGGERDYNAMICATTACHSOURCERUNDOWN = 0x00003b64U,
}

enum uint IDM_GETDEBUGGERSTATE = 0x00003b65U;
enum uint IDM_SELECTIONSEARCH = 0x00003b66U;
enum uint IDM_SHOWSHAREUI = 0x00003b67U;
enum uint IDM_RUNFLASH = 0x00003b68U;
enum uint DISPID_INTERNAL_CELEMENTCLASSCACHE = 0x80000000U;

enum : uint
{
    DISPID_HTMLOBJECT   = 0x000101f4U,
    DISPID_ELEMENT      = 0x000103e8U,
    DISPID_SITE         = 0x000107d0U,
    DISPID_OBJECT       = 0x00010bb8U,
    DISPID_STYLE        = 0x00010fa0U,
    DISPID_BASE_STYLE   = 0x00011194U,
    DISPID_ATTRS        = 0x00011388U,
    DISPID_EVENTS       = 0x00011770U,
    DISPID_XOBJ_EXPANDO = 0x00011b58U,
    DISPID_XOBJ_ORDINAL = 0x00011f40U,
}

enum : uint
{
    DISPID_ACTIVEX_EXPANDO_BASE = 0x00011b58U,
    DISPID_ACTIVEX_EXPANDO_MAX  = 0x00011f3fU,
}

enum : uint
{
    DISPID_OBJECT_ORDINAL_BASE = 0x00011f40U,
    DISPID_OBJECT_ORDINAL_MAX  = 0x00012327U,
}

enum : uint
{
    DISPID_COLLECTION_MIN = 0x000f4240U,
    DISPID_COLLECTION_MAX = 0x002dc6bfU,
}

enum : uint
{
    DISPID_STYLESHEETSCOLLECTION_NAMED_BASE   = 0x000f4240U,
    DISPID_STYLESHEETSCOLLECTION_ORDINAL_BASE = 0x001e8480U,
    DISPID_STYLESHEETSCOLLECTION_ORDINAL_MAX  = 0x002dc6bfU,
}

enum : uint
{
    DISPID_EXPANDO_BASE               = 0x002dc6c0U,
    DISPID_EXPANDO_MAX                = 0x003d08ffU,
    DISPID_EVENTHOOK_SENSITIVE_BASE   = 0x003d0900U,
    DISPID_EVENTHOOK_SENSITIVE_MAX    = 0x0044aa1fU,
    DISPID_EVENTHOOK_INSENSITIVE_BASE = 0x0044aa20U,
    DISPID_EVENTHOOK_INSENSITIVE_MAX  = 0x004c4b3fU,
}

enum uint DISPID_PEER_HOLDER_BASE = 0x004c4b40U;

enum : uint
{
    DISPID_CANVASPIXELARRAY_BASE = 0x004c4b40U,
    DISPID_CANVASPIXELARRAY_MAX  = 0x77359400U,
}

enum : uint
{
    DISPID_CommonCtrl_FONTNAME        = 0x00000001U,
    DISPID_CommonCtrl_FONTSIZE        = 0x00000002U,
    DISPID_CommonCtrl_FONTBOLD        = 0x00000003U,
    DISPID_CommonCtrl_FONTITAL        = 0x00000004U,
    DISPID_CommonCtrl_FONTUNDER       = 0x00000005U,
    DISPID_CommonCtrl_FONTSTRIKE      = 0x00000006U,
    DISPID_CommonCtrl_FONTWEIGHT      = 0x00000007U,
    DISPID_CommonCtrl_FONTCHARSET     = 0x00000008U,
    DISPID_CommonCtrl_FONTSUPERSCRIPT = 0x00000009U,
    DISPID_CommonCtrl_FONTSUBSCRIPT   = 0x0000000aU,
}

enum int DISPID_MSDATASRCINTERFACE = 0xfffff0c4;
enum int DISPID_ADVISEDATASRCCHANGEEVENT = 0xfffff0c3;

enum : uint
{
    DISPID_HTMLDLG      = 0x000061a8U,
    DISPID_HTMLDLGMODEL = 0x00006590U,
    DISPID_HTMLPOPUP    = 0x00006978U,
    DISPID_HTMLAPP      = 0x00001388U,
}

enum : uint
{
    STDPROPID_XOBJ_NAME           = 0x00010000U,
    STDPROPID_XOBJ_INDEX          = 0x00010001U,
    STDPROPID_IE3XOBJ_OBJECTALIGN = 0x00010001U,
}

enum : uint
{
    STDPROPID_XOBJ_BASEHREF        = 0x00010002U,
    STDPROPID_XOBJ_LEFT            = 0x00010003U,
    STDPROPID_XOBJ_TOP             = 0x00010004U,
    STDPROPID_XOBJ_WIDTH           = 0x00010005U,
    STDPROPID_XOBJ_HEIGHT          = 0x00010006U,
    STDPROPID_XOBJ_VISIBLE         = 0x00010007U,
    STDPROPID_XOBJ_PARENT          = 0x00010008U,
    STDPROPID_XOBJ_DRAGMODE        = 0x00010009U,
    STDPROPID_XOBJ_DRAGICON        = 0x0001000aU,
    STDPROPID_XOBJ_TAG             = 0x0001000bU,
    STDPROPID_XOBJ_TABSTOP         = 0x0001000eU,
    STDPROPID_XOBJ_TABINDEX        = 0x0001000fU,
    STDPROPID_XOBJ_HELPCONTEXTID   = 0x00010032U,
    STDPROPID_XOBJ_DEFAULT         = 0x00010037U,
    STDPROPID_XOBJ_CANCEL          = 0x00010038U,
    STDPROPID_XOBJ_LEFTNORUN       = 0x00010039U,
    STDPROPID_XOBJ_TOPNORUN        = 0x0001003aU,
    STDPROPID_XOBJ_ALIGNPERSIST    = 0x0001003cU,
    STDPROPID_XOBJ_LINKTIMEOUT     = 0x0001003dU,
    STDPROPID_XOBJ_LINKTOPIC       = 0x0001003eU,
    STDPROPID_XOBJ_LINKITEM        = 0x0001003fU,
    STDPROPID_XOBJ_LINKMODE        = 0x00010040U,
    STDPROPID_XOBJ_DATACHANGED     = 0x00010041U,
    STDPROPID_XOBJ_DATAFIELD       = 0x00010042U,
    STDPROPID_XOBJ_DATASOURCE      = 0x00010043U,
    STDPROPID_XOBJ_WHATSTHISHELPID = 0x00010044U,
    STDPROPID_XOBJ_CONTROLTIPTEXT  = 0x00010045U,
    STDPROPID_XOBJ_STATUSBARTEXT   = 0x00010046U,
    STDPROPID_XOBJ_APPLICATION     = 0x00010047U,
    STDPROPID_XOBJ_BLOCKALIGN      = 0x00010048U,
    STDPROPID_XOBJ_CONTROLALIGN    = 0x00010049U,
    STDPROPID_XOBJ_STYLE           = 0x0001004aU,
    STDPROPID_XOBJ_COUNT           = 0x0001004bU,
    STDPROPID_XOBJ_DISABLED        = 0x0001004cU,
    STDPROPID_XOBJ_RIGHT           = 0x0001004dU,
    STDPROPID_XOBJ_BOTTOM          = 0x0001004eU,
    STDPROPID_XOBJ_GETSVGDOCUMENT  = 0x0001004fU,
}

enum : uint
{
    STDDISPID_XOBJ_ONFOCUS           = 0x00010001U,
    STDDISPID_XOBJ_BEFOREUPDATE      = 0x00010004U,
    STDDISPID_XOBJ_AFTERUPDATE       = 0x00010005U,
    STDDISPID_XOBJ_ONROWEXIT         = 0x00010006U,
    STDDISPID_XOBJ_ONROWENTER        = 0x00010007U,
    STDDISPID_XOBJ_ONMOUSEOVER       = 0x00010008U,
    STDDISPID_XOBJ_ONMOUSEOUT        = 0x00010009U,
    STDDISPID_XOBJ_ONHELP            = 0x0001000aU,
    STDDISPID_XOBJ_ONDRAGSTART       = 0x0001000bU,
    STDDISPID_XOBJ_ONSELECTSTART     = 0x0001000cU,
    STDDISPID_XOBJ_ERRORUPDATE       = 0x0001000dU,
    STDDISPID_XOBJ_ONDATASETCHANGED  = 0x0001000eU,
    STDDISPID_XOBJ_ONDATAAVAILABLE   = 0x0001000fU,
    STDDISPID_XOBJ_ONDATASETCOMPLETE = 0x00010010U,
    STDDISPID_XOBJ_ONFILTER          = 0x00010011U,
    STDDISPID_XOBJ_ONLOSECAPTURE     = 0x00010012U,
    STDDISPID_XOBJ_ONPROPERTYCHANGE  = 0x00010013U,
    STDDISPID_XOBJ_ONDRAG            = 0x00010014U,
    STDDISPID_XOBJ_ONDRAGEND         = 0x00010015U,
    STDDISPID_XOBJ_ONDRAGENTER       = 0x00010016U,
    STDDISPID_XOBJ_ONDRAGOVER        = 0x00010017U,
    STDDISPID_XOBJ_ONDRAGLEAVE       = 0x00010018U,
    STDDISPID_XOBJ_ONDROP            = 0x00010019U,
    STDDISPID_XOBJ_ONCUT             = 0x0001001aU,
    STDDISPID_XOBJ_ONCOPY            = 0x0001001bU,
    STDDISPID_XOBJ_ONPASTE           = 0x0001001cU,
    STDDISPID_XOBJ_ONBEFORECUT       = 0x0001001dU,
    STDDISPID_XOBJ_ONBEFORECOPY      = 0x0001001eU,
    STDDISPID_XOBJ_ONBEFOREPASTE     = 0x0001001fU,
    STDDISPID_XOBJ_ONROWSDELETE      = 0x00010020U,
    STDDISPID_XOBJ_ONROWSINSERTED    = 0x00010021U,
    STDDISPID_XOBJ_ONCELLCHANGE      = 0x00010022U,
}

enum uint DISPID_NORMAL_FIRST = 0x000003e8U;
enum uint DISPID_IE8_NORMAL_FIRST = 0x0000047eU;

enum : uint
{
    DISPID_ANCHOR         = 0x000003e8U,
    DISPID_BLOCK          = 0x000003e8U,
    DISPID_BODY           = 0x000007d0U,
    DISPID_BR             = 0x000003e8U,
    DISPID_BGSOUND        = 0x000003e8U,
    DISPID_DD             = 0x000003e8U,
    DISPID_DIR            = 0x000003e8U,
    DISPID_DIV            = 0x000003e8U,
    DISPID_DL             = 0x000003e8U,
    DISPID_DT             = 0x000003e8U,
    DISPID_EFONT          = 0x000003e8U,
    DISPID_FORM           = 0x000003e8U,
    DISPID_HEADER         = 0x000003e8U,
    DISPID_HEDELEMS       = 0x000003e8U,
    DISPID_HR             = 0x000003e8U,
    DISPID_LABEL          = 0x000003e8U,
    DISPID_LI             = 0x000003e8U,
    DISPID_IMGBASE        = 0x000003e8U,
    DISPID_IMG            = 0x000007d0U,
    DISPID_INPUTIMAGE     = 0x000007d0U,
    DISPID_INPUT          = 0x000007d0U,
    DISPID_INPUTTEXTBASE  = 0x00000bb8U,
    DISPID_INPUTTEXT      = 0x00000fa0U,
    DISPID_MENU           = 0x000003e8U,
    DISPID_OL             = 0x000003e8U,
    DISPID_PARA           = 0x000003e8U,
    DISPID_SELECT         = 0x000003e8U,
    DISPID_SELECTOBJ      = 0x000003e8U,
    DISPID_TABLE          = 0x000003e8U,
    DISPID_TEXTSITE       = 0x000003e8U,
    DISPID_TEXTAREA       = 0x00001388U,
    DISPID_MARQUEE        = 0x00001770U,
    DISPID_RICHTEXT       = 0x00001b58U,
    DISPID_BUTTON         = 0x00001f40U,
    DISPID_UL             = 0x000003e8U,
    DISPID_PHRASE         = 0x000003e8U,
    DISPID_UNKNOWNPDL     = 0x000003e8U,
    DISPID_COMMENTPDL     = 0x000003e8U,
    DISPID_TABLECELL      = 0x000007d0U,
    DISPID_RANGE          = 0x000003e8U,
    DISPID_SELECTION      = 0x000003e8U,
    DISPID_OPTION         = 0x000003e8U,
    DISPID_1D             = 0x000007d0U,
    DISPID_MAP            = 0x000003e8U,
    DISPID_AREA           = 0x000003e8U,
    DISPID_PARAM          = 0x000003e8U,
    DISPID_TABLESECTION   = 0x000003e8U,
    DISPID_TABLEROW       = 0x000003e8U,
    DISPID_TABLECOL       = 0x000003e8U,
    DISPID_SCRIPT         = 0x000003e8U,
    DISPID_STYLESHEET     = 0x000003e8U,
    DISPID_STYLERULE      = 0x000003e8U,
    DISPID_BASE_STYLERULE = 0x0000044cU,
}

enum : uint
{
    DISPID_STYLEPAGE       = 0x000003e8U,
    DISPID_STYLESHEETS_COL = 0x000003e8U,
    DISPID_STYLERULES_COL  = 0x000003e8U,
    DISPID_STYLEPAGES_COL  = 0x000003e8U,
}

enum : uint
{
    DISPID_MEDIALIST     = 0x000003e8U,
    DISPID_MIMETYPES_COL = 0x000003e8U,
}

enum uint DISPID_PLUGINS_COL = 0x000003e8U;

enum : uint
{
    DISPID_2D          = 0x000003e8U,
    DISPID_OMWINDOW    = 0x000003e8U,
    DISPID_EVENTOBJ    = 0x000003e8U,
    DISPID_PERSISTDATA = 0x000003e8U,
}

enum : uint
{
    DISPID_OLESITE      = 0x000003e8U,
    DISPID_FRAMESET     = 0x000003e8U,
    DISPID_LINK         = 0x000003e8U,
    DISPID_STYLEELEMENT = 0x000003e8U,
}

enum : uint
{
    DISPID_FILTERS      = 0x000003e8U,
    DISPID_OMRECT       = 0x000003e8U,
    DISPID_DOMATTRIBUTE = 0x000003e8U,
    DISPID_DOMTEXTNODE  = 0x000003e8U,
}

enum : uint
{
    DISPID_GENERIC              = 0x000003e8U,
    DISPID_URN_COLL             = 0x000003e8U,
    DISPID_NAMESPACE_COLLECTION = 0x000003e8U,
    DISPID_NAMESPACE            = 0x000003e8U,
    DISPID_TAGNAMES_COLLECTION  = 0x000003e8U,
}

enum : uint
{
    DISPID_XMLHTTPREQUEST = 0x000003e8U,
    DISPID_XMLSERIALIZER  = 0x000003e8U,
}

enum : uint
{
    DISPID_DOMPARSER                         = 0x000003e8U,
    DISPID_DOCUMENTCOMPATIBLEINFO_COLLECTION = 0x000003e8U,
    DISPID_DOCUMENTCOMPATIBLEINFO            = 0x000003e8U,
}

enum uint DISPID_XDOMAINREQUEST = 0x000003e8U;

enum : uint
{
    DISPID_DOMSTORAGEITEM = 0x000003e8U,
    DISPID_DOMSTORAGE     = 0x000003e8U,
    DISPID_DOMSTORAGELIST = 0x000003e8U,
}

enum : uint
{
    DISPID_RULESAPPLIED            = 0x000003e8U,
    DISPID_RULESAPPLIED_COLLECTION = 0x000003e8U,
}

enum uint DISPID_STYLESHEETRULESAPPLIED_COLLECTION = 0x000003e8U;
enum uint DISPID_PROCESSINGINSTRUCTION = 0x000003e8U;
enum uint DISPID_MSPOINTERPOINT = 0x000003e8U;

enum : uint
{
    DISPID_WEBSOCKET        = 0x000003e8U,
    DISPID_APPLICATIONCACHE = 0x000003e8U,
}

enum : uint
{
    DISPID_DOMEVENT           = 0x000003e8U,
    DISPID_DOMUIEVENT         = 0x00000401U,
    DISPID_DOMMOUSEEVENT      = 0x0000041aU,
    DISPID_DOMMOUSEWHEELEVENT = 0x00000433U,
}

enum : uint
{
    DISPID_DOMWHEELEVENT       = 0x0000044cU,
    DISPID_DOMTEXTEVENT        = 0x00000465U,
    DISPID_DOMKEYBOARDEVENT    = 0x0000047eU,
    DISPID_DOMCOMPOSITIONEVENT = 0x00000497U,
    DISPID_DOMCUSTOMEVENT      = 0x000004b0U,
    DISPID_DOMMUTATIONEVENT    = 0x000004c9U,
    DISPID_DOMFOCUSEVENT       = 0x000004e2U,
}

enum uint DISPID_SVGZOOMEVENT = 0x000004fbU;

enum : uint
{
    DISPID_DOMSITEMODEEVENT     = 0x00000514U,
    DISPID_DOMMESSAGEEVENT      = 0x0000052dU,
    DISPID_DOMSTORAGEEVENT      = 0x00000546U,
    DISPID_DOMBEFOREUNLOADEVENT = 0x0000055fU,
}

enum : uint
{
    DISPID_DOMDRAGEVENT           = 0x00000578U,
    DISPID_DOMMSPOINTEREVENT      = 0x00000591U,
    DISPID_DOMMSGESTUREEVENT      = 0x000005aaU,
    DISPID_DOMMSTRANSITIONEVENT   = 0x000005c3U,
    DISPID_DOMMSANIMATIONEVENT    = 0x000005dcU,
    DISPID_DOMMSMANIPULATIONEVENT = 0x000005f5U,
}

enum : uint
{
    DISPID_DOMPROGRESSEVENT = 0x0000060eU,
    DISPID_DOMCLOSEEVENT    = 0x000005f5U,
}

enum uint DISPID_HTMLDOCUMENT = 0x000003e8U;

enum : uint
{
    DISPID_OMDOCUMENT   = 0x000003e8U,
    DISPID_DATATRANSFER = 0x000003e8U,
}

enum : uint
{
    DISPID_XMLDECL            = 0x000003e8U,
    DISPID_DOCFRAG            = 0x000003e8U,
    DISPID_ILINEINFO          = 0x000003e8U,
    DISPID_IHTMLCOMPUTEDSTYLE = 0x000003e8U,
}

enum : uint
{
    DISPID_DOMRANGE      = 0x000003e8U,
    DISPID_HTMLSELECTION = 0x000003e8U,
}

enum : uint
{
    DISPID_DOMTRAVERSAL = 0x000003e8U,
    DISPID_DOMEXCEPTION = 0x000003e8U,
}

enum uint DISPID_SVGEXCEPTION = 0x000003e8U;
enum uint DISPID_RANGEEXCEPTION = 0x000003e8U;
enum uint DISPID_EVENTEXCEPTION = 0x000003e8U;
enum uint DISPID_DOCUMENTTYPE = 0x000003e8U;

enum : uint
{
    DISPID_MEDIA        = 0x000003e8U,
    DISPID_MEDIAERROR   = 0x000003e8U,
    DISPID_TIMERANGES   = 0x000003e8U,
    DISPID_SOURCE       = 0x000003e8U,
    DISPID_TRACK        = 0x000003e8U,
    DISPID_AUDIO        = 0x0000041aU,
    DISPID_VIDEO        = 0x0000041aU,
    DISPID_STYLEMEDIA   = 0x000003e8U,
    DISPID_PROGRESS     = 0x000003e8U,
    DISPID_PLAYTO       = 0x000003e8U,
    DISPID_PLAYTODEVICE = 0x000003e8U,
}

enum : uint
{
    DISPID_WINDOW           = 0x00000001U,
    DISPID_SCREEN           = 0x000003e8U,
    DISPID_FRAMESCOLLECTION = 0x000003e8U,
}

enum : uint
{
    DISPID_HISTORY          = 0x00000001U,
    DISPID_LOCATION         = 0x00000001U,
    DISPID_NAVIGATOR        = 0x00000001U,
    DISPID_CLIENTCAPS       = 0x00000001U,
    DISPID_TEMPLATE_PRINTER = 0x00000001U,
}

enum uint DISPID_PRINTMANAGER_TEMPLATE_PRINTER = 0x000001f5U;

enum : uint
{
    DISPID_COLLECTION  = 0x000005dcU,
    DISPID_OPTIONS_COL = 0x000005dcU,
}

enum : uint
{
    DISPID_CHECKBOX  = 0x000003e8U,
    DISPID_RADIO     = 0x000007d0U,
    DISPID_FRAMESITE = 0x00010bb8U,
    DISPID_FRAME     = 0x00010fa0U,
    DISPID_IFRAME    = 0x00010fa0U,
}

enum : uint
{
    WEBOC_DISPIDBASE = 0x00011388U,
    WEBOC_DISPIDMAX  = 0x000113ecU,
}

enum uint DISPID_PROTECTEDELEMENT = 0x000003e8U;

enum : uint
{
    DISPID_DEFAULTS          = 0x000003e8U,
    DISPID_MARKUP            = 0x000003e8U,
    DISPID_DOMIMPLEMENTATION = 0x000003e8U,
}

enum : uint
{
    DISPID_MEDIAQUERY               = 0x000003e8U,
    DISPID_HTML5ATTRIBUTESELECTORCI = 0x000003e8U,
}

enum : uint
{
    DISPID_SVGMIXINS              = 0x000003e8U,
    DISPID_SVGELEMENT             = 0x00000406U,
    DISPID_SVGELEMENT_BASE        = 0x0000041aU,
    DISPID_SVGAELEMENT            = 0x0000041aU,
    DISPID_SVGALTGLYPHDEFELEMENT  = 0x0000041aU,
    DISPID_SVGALTGLYPHELEMENT     = 0x0000041aU,
    DISPID_SVGALTGLYPHITEMELEMENT = 0x0000041aU,
}

enum : uint
{
    DISPID_SVGANGLE                   = 0x000003e8U,
    DISPID_SVGANIMATECOLORELEMENT     = 0x0000041aU,
    DISPID_SVGANIMATEDANGLE           = 0x000003e8U,
    DISPID_SVGANIMATEDBOOLEAN         = 0x000003e8U,
    DISPID_SVGANIMATEDENUMERATION     = 0x000003e8U,
    DISPID_SVGANIMATEDINTEGER         = 0x000003e8U,
    DISPID_SVGANIMATEDLENGTH          = 0x000003e8U,
    DISPID_SVGANIMATEDLENGTHLIST      = 0x000003e8U,
    DISPID_SVGANIMATEDNUMBER          = 0x000003e8U,
    DISPID_SVGANIMATEDNUMBERLIST      = 0x000003e8U,
    DISPID_SVGANIMATEDPOINTS          = 0x000003e8U,
    DISPID_SVGANIMATEDRECT            = 0x000003e8U,
    DISPID_SVGANIMATEDSTRING          = 0x000003e8U,
    DISPID_SVGANIMATEELEMENT          = 0x0000041aU,
    DISPID_SVGANIMATEMOTIONELEMENT    = 0x0000041aU,
    DISPID_SVGANIMATETRANSFORMELEMENT = 0x0000041aU,
}

enum : uint
{
    DISPID_SVGCIRCLEELEMENT        = 0x0000041aU,
    DISPID_SVGCLIPPATHELEMENT      = 0x0000041aU,
    DISPID_SVGCOLOR_PROFILEELEMENT = 0x0000041aU,
}

enum : uint
{
    DISPID_SVGCURSORELEMENT              = 0x0000041aU,
    DISPID_SVGDEFINITION_SRCELEMENT      = 0x0000041aU,
    DISPID_SVGDEFSELEMENT                = 0x0000041aU,
    DISPID_SVGDESCELEMENT                = 0x0000041aU,
    DISPID_SVGELEMENTINSTANCE            = 0x000003e8U,
    DISPID_SVGELEMENTINSTANCELIST        = 0x000003e8U,
    DISPID_SVGELLIPSEELEMENT             = 0x0000041aU,
    DISPID_SVGFEBLENDELEMENT             = 0x0000041aU,
    DISPID_SVGFECOLORMATRIXELEMENT       = 0x0000041aU,
    DISPID_SVGFECOMPONENTTRANSFERELEMENT = 0x0000041aU,
}

enum uint DISPID_SVGCOMPONENTTRANSFERFUNCTIONELEMENT = 0x0000041aU;

enum : uint
{
    DISPID_SVGFECOMPOSITEELEMENT      = 0x0000041aU,
    DISPID_SVGFECONVOLVEMATRIXELEMENT = 0x0000041aU,
}

enum : uint
{
    DISPID_SVGFEDIFFUSELIGHTINGELEMENT = 0x0000041aU,
    DISPID_SVGFEDISPLACEMENTMAPELEMENT = 0x0000041aU,
    DISPID_SVGFEDISTANTLIGHTELEMENT    = 0x0000041aU,
}

enum : uint
{
    DISPID_SVGFEFLOODELEMENT        = 0x0000041aU,
    DISPID_SVGFEFUNCAELEMENT        = 0x0000041aU,
    DISPID_SVGFEFUNCBELEMENT        = 0x0000041aU,
    DISPID_SVGFEFUNCGELEMENT        = 0x0000041aU,
    DISPID_SVGFEFUNCRELEMENT        = 0x0000041aU,
    DISPID_SVGFEGAUSSIANBLURELEMENT = 0x0000041aU,
}

enum : uint
{
    DISPID_SVGFEIMAGEELEMENT            = 0x0000041aU,
    DISPID_SVGFEMERGEELEMENT            = 0x0000041aU,
    DISPID_SVGFEMERGENODEELEMENT        = 0x0000041aU,
    DISPID_SVGFEMORPHOLOGYELEMENT       = 0x0000041aU,
    DISPID_SVGFEOFFSETELEMENT           = 0x0000041aU,
    DISPID_SVGFEPOINTLIGHTELEMENT       = 0x0000041aU,
    DISPID_SVGFESPECULARLIGHTINGELEMENT = 0x0000041aU,
}

enum : uint
{
    DISPID_SVGFESPOTLIGHTELEMENT  = 0x0000041aU,
    DISPID_SVGFETILEELEMENT       = 0x0000041aU,
    DISPID_SVGFETURBULENCEELEMENT = 0x0000041aU,
}

enum : uint
{
    DISPID_SVGFILTERELEMENT           = 0x0000041aU,
    DISPID_SVGFONT_FACE_FORMATELEMENT = 0x0000041aU,
    DISPID_SVGFONT_FACE_NAMEELEMENT   = 0x0000041aU,
    DISPID_SVGFONT_FACE_SRCELEMENT    = 0x0000041aU,
    DISPID_SVGFONT_FACE_URIELEMENT    = 0x0000041aU,
    DISPID_SVGFONT_FACEELEMENT        = 0x0000041aU,
    DISPID_SVGFONTELEMENT             = 0x0000041aU,
    DISPID_SVGFOREIGNOBJECTELEMENT    = 0x0000041aU,
}

enum : uint
{
    DISPID_SVGGELEMENT        = 0x0000041aU,
    DISPID_SVGGLYPHELEMENT    = 0x0000041aU,
    DISPID_SVGGLYPHREFELEMENT = 0x0000041aU,
    DISPID_SVGGRADIENTELEMENT = 0x0000041aU,
}

enum : uint
{
    DISPID_SVGHKERNELEMENT        = 0x0000041aU,
    DISPID_SVGIMAGEELEMENT        = 0x0000041aU,
    DISPID_SVGLENGTH              = 0x000003e8U,
    DISPID_SVGLENGTHLIST          = 0x000003e8U,
    DISPID_SVGPRESERVEASPECTRATIO = 0x000003e8U,
}

enum uint DISPID_SVGANIMATEDPRESERVEASPECTRATIO = 0x000003e8U;

enum : uint
{
    DISPID_SVGPOINT                 = 0x000003e8U,
    DISPID_SVGPOINTLIST             = 0x000003e8U,
    DISPID_SVGLINEARGRADIENTELEMENT = 0x0000042eU,
    DISPID_SVGLINEELEMENT           = 0x0000041aU,
    DISPID_SVGMARKERELEMENT         = 0x0000041aU,
    DISPID_SVGMASKELEMENT           = 0x0000041aU,
    DISPID_SVGMETADATAELEMENT       = 0x0000041aU,
    DISPID_SVGMISSING_GLYPHELEMENT  = 0x0000041aU,
}

enum : uint
{
    DISPID_SVGMPATHELEMENT    = 0x0000041aU,
    DISPID_SVGNUMBER          = 0x000003e8U,
    DISPID_SVGNUMBERLIST      = 0x000003e8U,
    DISPID_SVGPATHELEMENT     = 0x0000041aU,
    DISPID_SVGPATTERNELEMENT  = 0x0000041aU,
    DISPID_SVGPOLYGONELEMENT  = 0x0000041aU,
    DISPID_SVGPOLYLINEELEMENT = 0x0000041aU,
}

enum uint DISPID_SVGRADIALGRADIENTELEMENT = 0x0000042eU;

enum : uint
{
    DISPID_SVGRECT                        = 0x000003e8U,
    DISPID_SVGRECTELEMENT                 = 0x0000041aU,
    DISPID_SVGSCRIPTELEMENT               = 0x0000041aU,
    DISPID_SVGSETELEMENT                  = 0x0000041aU,
    DISPID_SVGSTOPELEMENT                 = 0x0000041aU,
    DISPID_SVGSTRINGLIST                  = 0x000003e8U,
    DISPID_SVGSTYLEELEMENT                = 0x0000041aU,
    DISPID_SVGSVGELEMENT                  = 0x0000041aU,
    DISPID_SVGSWITCHELEMENT               = 0x0000041aU,
    DISPID_SVGSYMBOLELEMENT               = 0x0000041aU,
    DISPID_SVGTITLEELEMENT                = 0x0000041aU,
    DISPID_SVGTREFELEMENT                 = 0x0000041aU,
    DISPID_SVGTEXTCONTENTELEMENT          = 0x0000041aU,
    DISPID_SVGTEXTCONTENTELEMENT_BASE     = 0x0000042eU,
    DISPID_SVGTEXTPOSITIONINGELEMENT      = 0x0000042eU,
    DISPID_SVGTEXTPOSITIONINGELEMENT_BASE = 0x00000442U,
}

enum : uint
{
    DISPID_SVGTEXTELEMENT     = 0x00000442U,
    DISPID_SVGTSPANELEMENT    = 0x00000442U,
    DISPID_SVGTEXTPATHELEMENT = 0x0000042eU,
}

enum : uint
{
    DISPID_SVGUSEELEMENT            = 0x0000041aU,
    DISPID_SVGVIEWELEMENT           = 0x0000041aU,
    DISPID_SVGVKERNELEMENT          = 0x0000041aU,
    DISPID_SVGMATRIX                = 0x000003e8U,
    DISPID_SVGTRANSFORM             = 0x000003e8U,
    DISPID_SVGTRANSFORMLIST         = 0x000003e8U,
    DISPID_SVGANIMATEDTRANSFORMLIST = 0x000003e8U,
}

enum : uint
{
    DISPID_SVGPATHSEG                          = 0x000003e8U,
    DISPID_SVGPATHSEG_BASE                     = 0x000003fcU,
    DISPID_SVGPATHSEGLIST                      = 0x000003e8U,
    DISPID_SVGPATHSEGARCABS                    = 0x000003fcU,
    DISPID_SVGPATHSEGARCREL                    = 0x000003fcU,
    DISPID_SVGPATHSEGCLOSEPATH                 = 0x000003fcU,
    DISPID_SVGPATHSEGMOVETOABS                 = 0x000003fcU,
    DISPID_SVGPATHSEGMOVETOREL                 = 0x000003fcU,
    DISPID_SVGPATHSEGLINETOABS                 = 0x000003fcU,
    DISPID_SVGPATHSEGLINETOREL                 = 0x000003fcU,
    DISPID_SVGPATHSEGCURVETOCUBICABS           = 0x000003fcU,
    DISPID_SVGPATHSEGCURVETOCUBICREL           = 0x000003fcU,
    DISPID_SVGPATHSEGCURVETOCUBICSMOOTHABS     = 0x000003fcU,
    DISPID_SVGPATHSEGCURVETOCUBICSMOOTHREL     = 0x000003fcU,
    DISPID_SVGPATHSEGCURVETOQUADRATICABS       = 0x000003fcU,
    DISPID_SVGPATHSEGCURVETOQUADRATICREL       = 0x000003fcU,
    DISPID_SVGPATHSEGCURVETOQUADRATICSMOOTHABS = 0x000003fcU,
    DISPID_SVGPATHSEGCURVETOQUADRATICSMOOTHREL = 0x000003fcU,
    DISPID_SVGPATHSEGLINETOHORIZONTALABS       = 0x000003fcU,
    DISPID_SVGPATHSEGLINETOHORIZONTALREL       = 0x000003fcU,
    DISPID_SVGPATHSEGLINETOVERTICALABS         = 0x000003fcU,
    DISPID_SVGPATHSEGLINETOVERTICALREL         = 0x000003fcU,
}

enum : uint
{
    DISPID_CANVASELEMENT         = 0x000003e8U,
    DISPID_CANVASRENDERCONTEXT2D = 0x000003e8U,
    DISPID_CANVASGRADIENT        = 0x000003e8U,
    DISPID_CANVASTEXTMETRICS     = 0x000003e8U,
    DISPID_CANVASIMAGEDATA       = 0x000003e8U,
    DISPID_CANVASPIXELARRAY      = 0x000003e8U,
}

enum : uint
{
    DISPID_PERFORMANCE           = 0x000003e8U,
    DISPID_PERFORMANCENAVIGATION = 0x000003e8U,
    DISPID_PERFORMANCETIMING     = 0x000003e8U,
}

enum uint DISPID_MSHTMLWEBVIEWELEMENT = 0x000003e8U;

enum : uint
{
    DISPID_WEBGEOLOCATION       = 0x000003e8U,
    DISPID_WEBGEOPOSITION       = 0x000003e8U,
    DISPID_WEBGEOCOORDINATES    = 0x000003e8U,
    DISPID_WEBGEOPOSITION_ERROR = 0x000003e8U,
}

enum : uint
{
    DISPID_DATALIST          = 0x000003e8U,
    DISPID_IE8_ANCHOR        = 0x0000047eU,
    DISPID_IE8_AREA          = 0x0000047eU,
    DISPID_IE8_BASE          = 0x0000047eU,
    DISPID_IE8_BODY          = 0x0000047eU,
    DISPID_IE8_FORM          = 0x0000047eU,
    DISPID_IE8_HEAD          = 0x0000047eU,
    DISPID_IE8_IMG           = 0x0000047eU,
    DISPID_IE8_INPUT         = 0x0000047eU,
    DISPID_IE8_LINK          = 0x0000047eU,
    DISPID_IE8_MOD           = 0x0000047eU,
    DISPID_IE8_SCRIPT        = 0x0000047eU,
    DISPID_IE8_ATTR          = 0x0000047eU,
    DISPID_IE8_NAMEDNODEMAP  = 0x0000047eU,
    DISPID_IE8_COLLECTION    = 0x0000047eU,
    DISPID_IE8_PARAM         = 0x0000047eU,
    DISPID_IE8_EMBED         = 0x0000047eU,
    DISPID_IE8_BLOCK         = 0x0000047eU,
    DISPID_IE8_META          = 0x0000047eU,
    DISPID_IE8_STYLE         = 0x0000047eU,
    DISPID_IE8_SELECT        = 0x0000047eU,
    DISPID_IE8_ELEMENTBASE   = 0x000104b0U,
    DISPID_IE8_ELEMENTMAX    = 0x000104d8U,
    DISPID_IE8_ELEMENT       = 0x000104b0U,
    DISPID_IE8_FRAMESITEBASE = 0x00011018U,
    DISPID_IE8_FRAMEMAX      = 0x00011387U,
    DISPID_IE8_FRAME         = 0x00011018U,
    DISPID_IE8_IFRAME        = 0x00011018U,
    DISPID_IE8_OBJECTBASE    = 0x00010bd6U,
    DISPID_IE8_OBJECTMAX     = 0x00010f9fU,
    DISPID_IE8_OBJECT        = 0x00010bd6U,
    DISPID_IE9_ELEMENTBASE   = 0x000104e2U,
    DISPID_IE9_ELEMENTMAX    = 0x00010505U,
    DISPID_IE9_ELEMENT       = 0x000104e2U,
    DISPID_IE10_ELEMENTBASE  = 0x00010506U,
    DISPID_IE10_ELEMENTMAX   = 0x000107cfU,
    DISPID_IE10_ELEMENT      = 0x00010506U,
}

enum uint DISP10_IE10_XMSARIAFLOWFROM = 0x00010513U;
enum int DISPID_WINDOWOBJECT = 0xffffea84;
enum int DISPID_PERFORMANCEOBJECT = 0xffffea7f;
enum int DISPID_LOCATIONOBJECT = 0xffffea7e;
enum int DISPID_HISTORYOBJECT = 0xffffea7d;
enum int DISPID_NAVIGATOROBJECT = 0xffffea7c;
enum int DISPID_SECURITYCTX = 0xffffea79;

enum : int
{
    DISPID_AMBIENT_DLCONTROL = 0xffffea78,
    DISPID_AMBIENT_USERAGENT = 0xffffea77,
}

enum int DISPID_SECURITYDOMAIN = 0xffffea76;

enum : int
{
    DISPID_DEBUG_ISSECUREPROXY            = 0xffffea75,
    DISPID_DEBUG_TRUSTEDPROXY             = 0xffffea74,
    DISPID_DEBUG_INTERNALWINDOW           = 0xffffea73,
    DISPID_DEBUG_ENABLESECUREPROXYASSERTS = 0xffffea72,
}

enum : uint
{
    DLCTL_DLIMAGES          = 0x00000010U,
    DLCTL_VIDEOS            = 0x00000020U,
    DLCTL_BGSOUNDS          = 0x00000040U,
    DLCTL_NO_SCRIPTS        = 0x00000080U,
    DLCTL_NO_JAVA           = 0x00000100U,
    DLCTL_NO_RUNACTIVEXCTLS = 0x00000200U,
}

enum uint DLCTL_NO_DLACTIVEXCTLS = 0x00000400U;
enum uint DLCTL_DOWNLOADONLY = 0x00000800U;
enum uint DLCTL_NO_FRAMEDOWNLOAD = 0x00001000U;
enum uint DLCTL_RESYNCHRONIZE = 0x00002000U;
enum uint DLCTL_PRAGMA_NO_CACHE = 0x00004000U;

enum : uint
{
    DLCTL_NO_BEHAVIORS   = 0x00008000U,
    DLCTL_NO_METACHARSET = 0x00010000U,
}

enum : uint
{
    DLCTL_URL_ENCODING_DISABLE_UTF8 = 0x00020000U,
    DLCTL_URL_ENCODING_ENABLE_UTF8  = 0x00040000U,
}

enum : uint
{
    DLCTL_NOFRAMES     = 0x00080000U,
    DLCTL_FORCEOFFLINE = 0x10000000U,
}

enum uint DLCTL_NO_CLIENTPULL = 0x20000000U;

enum : uint
{
    DLCTL_SILENT                = 0x40000000U,
    DLCTL_OFFLINEIFNOTCONNECTED = 0x80000000U,
    DLCTL_OFFLINE               = 0x80000000U,
}

enum : uint
{
    DISPID_ONABORT           = 0x000003e8U,
    DISPID_ONCHANGE          = 0x000003e9U,
    DISPID_ONERROR           = 0x000003eaU,
    DISPID_ONLOAD            = 0x000003ebU,
    DISPID_ONSELECT          = 0x000003eeU,
    DISPID_ONSUBMIT          = 0x000003efU,
    DISPID_ONUNLOAD          = 0x000003f0U,
    DISPID_ONBOUNCE          = 0x000003f1U,
    DISPID_ONFINISH          = 0x000003f2U,
    DISPID_ONSTART           = 0x000003f3U,
    DISPID_ONLAYOUT          = 0x000003f5U,
    DISPID_ONSCROLL          = 0x000003f6U,
    DISPID_ONRESET           = 0x000003f7U,
    DISPID_ONRESIZE          = 0x000003f8U,
    DISPID_ONBEFOREUNLOAD    = 0x000003f9U,
    DISPID_ONCHANGEFOCUS     = 0x000003faU,
    DISPID_ONCHANGEBLUR      = 0x000003fbU,
    DISPID_ONPERSIST         = 0x000003fcU,
    DISPID_ONPERSISTSAVE     = 0x000003fdU,
    DISPID_ONPERSISTLOAD     = 0x000003feU,
    DISPID_ONCONTEXTMENU     = 0x000003ffU,
    DISPID_ONBEFOREPRINT     = 0x00000400U,
    DISPID_ONAFTERPRINT      = 0x00000401U,
    DISPID_ONSTOP            = 0x00000402U,
    DISPID_ONBEFOREEDITFOCUS = 0x00000403U,
}

enum : uint
{
    DISPID_ONMOUSEHOVER     = 0x00000404U,
    DISPID_ONCONTENTREADY   = 0x00000405U,
    DISPID_ONLAYOUTCOMPLETE = 0x00000406U,
}

enum : uint
{
    DISPID_ONPAGE           = 0x00000407U,
    DISPID_ONLINKEDOVERFLOW = 0x00000408U,
}

enum : uint
{
    DISPID_ONMOUSEWHEEL       = 0x00000409U,
    DISPID_ONBEFOREDEACTIVATE = 0x0000040aU,
}

enum : uint
{
    DISPID_ONMOVE            = 0x0000040bU,
    DISPID_ONCONTROLSELECT   = 0x0000040cU,
    DISPID_ONSELECTIONCHANGE = 0x0000040dU,
}

enum : uint
{
    DISPID_ONMOVESTART          = 0x0000040eU,
    DISPID_ONMOVEEND            = 0x0000040fU,
    DISPID_ONRESIZESTART        = 0x00000410U,
    DISPID_ONRESIZEEND          = 0x00000411U,
    DISPID_ONMOUSEENTER         = 0x00000412U,
    DISPID_ONMOUSELEAVE         = 0x00000413U,
    DISPID_ONACTIVATE           = 0x00000414U,
    DISPID_ONDEACTIVATE         = 0x00000415U,
    DISPID_ONMULTILAYOUTCLEANUP = 0x00000416U,
}

enum uint DISPID_ONBEFOREACTIVATE = 0x00000417U;

enum : uint
{
    DISPID_ONFOCUSIN              = 0x00000418U,
    DISPID_ONFOCUSOUT             = 0x00000419U,
    DISPID_ONVALUECHANGE          = 0x0000041aU,
    DISPID_ONSELECTADD            = 0x0000041bU,
    DISPID_ONSELECTREMOVE         = 0x0000041cU,
    DISPID_ONSELECTWITHIN         = 0x0000041dU,
    DISPID_ONSYSTEMSCROLLINGSTART = 0x0000041eU,
    DISPID_ONSYSTEMSCROLLINGEND   = 0x0000041fU,
}

enum uint DISPID_ONOBJECTCONTENTSCROLLED = 0x00000420U;

enum : uint
{
    DISPID_ONSTORAGE        = 0x00000421U,
    DISPID_ONSTORAGECOMMIT  = 0x00000422U,
    DISPID_ONSHOW           = 0x00000423U,
    DISPID_ONHIDE           = 0x00000424U,
    DISPID_ONALERT          = 0x00000425U,
    DISPID_ONPOPUPMENUSTART = 0x00000426U,
    DISPID_ONPOPUPMENUEND   = 0x00000427U,
    DISPID_ONONLINE         = 0x00000428U,
    DISPID_ONOFFLINE        = 0x00000429U,
    DISPID_ONHASHCHANGE     = 0x0000042aU,
    DISPID_ONMESSAGE        = 0x0000042bU,
    DISPID_ONDOMMUTATION    = 0x0000042cU,
}

enum : uint
{
    DISPID_SVGLOAD            = 0x0000042dU,
    DISPID_SVGUNLOAD          = 0x0000042eU,
    DISPID_SVGABORT           = 0x0000042fU,
    DISPID_SVGERROR           = 0x00000430U,
    DISPID_SVGRESIZE          = 0x00000431U,
    DISPID_SVGSCROLL          = 0x00000432U,
    DISPID_SVGZOOM            = 0x00000433U,
    DISPID_MSPOINTERDOWN      = 0x00000434U,
    DISPID_MSPOINTERMOVE      = 0x00000435U,
    DISPID_MSPOINTERUP        = 0x00000436U,
    DISPID_MSPOINTEROVER      = 0x00000437U,
    DISPID_MSPOINTEROUT       = 0x00000438U,
    DISPID_MSPOINTERCANCEL    = 0x00000439U,
    DISPID_MSPOINTERHOVER     = 0x0000043aU,
    DISPID_MSGESTURESTART     = 0x0000043bU,
    DISPID_MSGESTURECHANGE    = 0x0000043cU,
    DISPID_MSGESTUREEND       = 0x0000043dU,
    DISPID_MSGESTUREHOLD      = 0x0000043eU,
    DISPID_MSGESTURETAP       = 0x0000043fU,
    DISPID_MSGESTUREDOUBLETAP = 0x00000440U,
}

enum : uint
{
    DISPID_MSINERTIASTART       = 0x00000441U,
    DISPID_MSLOSTPOINTERCAPTURE = 0x00000442U,
}

enum uint DISPID_MSGOTPOINTERCAPTURE = 0x00000443U;

enum : uint
{
    DISPID_MSTRANSITIONSTART    = 0x00000444U,
    DISPID_MSTRANSITIONEND      = 0x00000445U,
    DISPID_MSANIMATIONSTART     = 0x00000446U,
    DISPID_MSANIMATIONEND       = 0x00000447U,
    DISPID_MSANIMATIONITERATION = 0x00000448U,
}

enum : uint
{
    DISPID_MSGESTUREINIT              = 0x00000449U,
    DISPID_MSMANIPULATIONSTATECHANGED = 0x0000044aU,
}

enum : uint
{
    DISPID_ONOPEN              = 0x0000044bU,
    DISPID_ONCLOSE             = 0x0000044cU,
    DISPID_MSPOINTERENTER      = 0x0000044dU,
    DISPID_MSPOINTERLEAVE      = 0x0000044eU,
    DISPID_MSORIENTATIONCHANGE = 0x0000044fU,
}

enum : uint
{
    DISPID_ONDEVICEORIENTATION       = 0x00000450U,
    DISPID_ONDEVICEMOTION            = 0x00000451U,
    DISPID_ONPAGESHOW                = 0x00000452U,
    DISPID_ONPAGEHIDE                = 0x00000453U,
    DISPID_ONCOMPASSNEEDSCALIBRATION = 0x00000454U,
}

enum : uint
{
    DISPID_A_FIRST           = 0x00011388U,
    DISPID_A_MIN             = 0x00011388U,
    DISPID_A_MAX             = 0x0001176fU,
    DISPID_A_BACKGROUNDIMAGE = 0x00011389U,
}

enum : uint
{
    DISPID_A_COLOR                     = 0x0001138aU,
    DISPID_A_TEXTTRANSFORM             = 0x0001138cU,
    DISPID_A_NOWRAP                    = 0x0001138dU,
    DISPID_A_LINEHEIGHT                = 0x0001138eU,
    DISPID_A_TEXTINDENT                = 0x0001138fU,
    DISPID_A_LETTERSPACING             = 0x00011390U,
    DISPID_A_LANG                      = 0x00011391U,
    DISPID_A_OVERFLOW                  = 0x00011392U,
    DISPID_A_PADDING                   = 0x00011393U,
    DISPID_A_PADDINGTOP                = 0x00011394U,
    DISPID_A_PADDINGRIGHT              = 0x00011395U,
    DISPID_A_PADDINGBOTTOM             = 0x00011396U,
    DISPID_A_PADDINGLEFT               = 0x00011397U,
    DISPID_A_CLEAR                     = 0x00011398U,
    DISPID_A_LISTTYPE                  = 0x00011399U,
    DISPID_A_FONTFACE                  = 0x0001139aU,
    DISPID_A_FONTSIZE                  = 0x0001139bU,
    DISPID_A_TEXTDECORATIONLINETHROUGH = 0x0001139cU,
    DISPID_A_TEXTDECORATIONUNDERLINE   = 0x0001139dU,
    DISPID_A_TEXTDECORATIONBLINK       = 0x0001139eU,
    DISPID_A_TEXTDECORATIONNONE        = 0x0001139fU,
}

enum : uint
{
    DISPID_A_FONTSTYLE             = 0x000113a0U,
    DISPID_A_FONTVARIANT           = 0x000113a1U,
    DISPID_A_BASEFONT              = 0x000113a2U,
    DISPID_A_FONTWEIGHT            = 0x000113a3U,
    DISPID_A_TABLEBORDERCOLOR      = 0x000113a4U,
    DISPID_A_TABLEBORDERCOLORLIGHT = 0x000113a5U,
    DISPID_A_TABLEBORDERCOLORDARK  = 0x000113a6U,
    DISPID_A_TABLEVALIGN           = 0x000113a7U,
    DISPID_A_BACKGROUND            = 0x000113a8U,
    DISPID_A_BACKGROUNDPOSX        = 0x000113a9U,
    DISPID_A_BACKGROUNDPOSY        = 0x000113aaU,
}

enum uint DISPID_A_TEXTDECORATION = 0x000113abU;

enum : uint
{
    DISPID_A_MARGIN          = 0x000113acU,
    DISPID_A_MARGINTOP       = 0x000113adU,
    DISPID_A_MARGINRIGHT     = 0x000113aeU,
    DISPID_A_MARGINBOTTOM    = 0x000113afU,
    DISPID_A_MARGINLEFT      = 0x000113b0U,
    DISPID_A_FONT            = 0x000113b1U,
    DISPID_A_FONTSIZEKEYWORD = 0x000113b2U,
    DISPID_A_FONTSIZECOMBINE = 0x000113b3U,
}

enum : uint
{
    DISPID_A_BACKGROUNDREPEAT     = 0x000113b4U,
    DISPID_A_BACKGROUNDATTACHMENT = 0x000113b5U,
    DISPID_A_BACKGROUNDPOSITION   = 0x000113b6U,
}

enum : uint
{
    DISPID_A_WORDSPACING       = 0x000113b7U,
    DISPID_A_VERTICALALIGN     = 0x000113b8U,
    DISPID_A_BORDER            = 0x000113b9U,
    DISPID_A_BORDERTOP         = 0x000113baU,
    DISPID_A_BORDERRIGHT       = 0x000113bbU,
    DISPID_A_BORDERBOTTOM      = 0x000113bcU,
    DISPID_A_BORDERLEFT        = 0x000113bdU,
    DISPID_A_BORDERCOLOR       = 0x000113beU,
    DISPID_A_BORDERTOPCOLOR    = 0x000113bfU,
    DISPID_A_BORDERRIGHTCOLOR  = 0x000113c0U,
    DISPID_A_BORDERBOTTOMCOLOR = 0x000113c1U,
    DISPID_A_BORDERLEFTCOLOR   = 0x000113c2U,
    DISPID_A_BORDERWIDTH       = 0x000113c3U,
    DISPID_A_BORDERTOPWIDTH    = 0x000113c4U,
    DISPID_A_BORDERRIGHTWIDTH  = 0x000113c5U,
    DISPID_A_BORDERBOTTOMWIDTH = 0x000113c6U,
    DISPID_A_BORDERLEFTWIDTH   = 0x000113c7U,
    DISPID_A_BORDERSTYLE       = 0x000113c8U,
    DISPID_A_BORDERTOPSTYLE    = 0x000113c9U,
    DISPID_A_BORDERRIGHTSTYLE  = 0x000113caU,
    DISPID_A_BORDERBOTTOMSTYLE = 0x000113cbU,
    DISPID_A_BORDERLEFTSTYLE   = 0x000113ccU,
}

enum uint DISPID_A_TEXTDECORATIONOVERLINE = 0x000113cdU;

enum : uint
{
    DISPID_A_FLOAT             = 0x000113ceU,
    DISPID_A_DISPLAY           = 0x000113cfU,
    DISPID_A_LISTSTYLETYPE     = 0x000113d0U,
    DISPID_A_LISTSTYLEPOSITION = 0x000113d1U,
    DISPID_A_LISTSTYLEIMAGE    = 0x000113d2U,
    DISPID_A_LISTSTYLE         = 0x000113d3U,
    DISPID_A_WHITESPACE        = 0x000113d4U,
    DISPID_A_PAGEBREAKBEFORE   = 0x000113d5U,
    DISPID_A_PAGEBREAKAFTER    = 0x000113d6U,
}

enum : uint
{
    DISPID_A_SCROLL     = 0x000113d7U,
    DISPID_A_VISIBILITY = 0x000113d8U,
    DISPID_A_HIDDEN     = 0x000113d9U,
    DISPID_A_FILTER     = 0x000113daU,
    DISPID_DEFAULTVALUE = 0x000113dbU,
}

enum uint DISPID_A_BORDERCOLLAPSE = 0x000113dcU;

enum : uint
{
    DISPID_A_POSITION       = 0x000113e2U,
    DISPID_A_ZINDEX         = 0x000113e3U,
    DISPID_A_CLIP           = 0x000113e4U,
    DISPID_A_CLIPRECTTOP    = 0x000113e5U,
    DISPID_A_CLIPRECTRIGHT  = 0x000113e6U,
    DISPID_A_CLIPRECTBOTTOM = 0x000113e7U,
    DISPID_A_CLIPRECTLEFT   = 0x000113e8U,
    DISPID_A_FONTFACESRC    = 0x000113e9U,
    DISPID_A_TABLELAYOUT    = 0x000113eaU,
    DISPID_A_STYLETEXT      = 0x000113ebU,
    DISPID_A_LANGUAGE       = 0x000113ecU,
    DISPID_A_VALUE          = 0x000113edU,
    DISPID_A_CURSOR         = 0x000113eeU,
    DISPID_A_EVENTSINK      = 0x000113efU,
    DISPID_A_PROPNOTIFYSINK = 0x000113f0U,
}

enum uint DISPID_A_ROWSETNOTIFYSINK = 0x000113f1U;

enum : uint
{
    DISPID_INTERNAL_INLINESTYLEAA         = 0x000113f2U,
    DISPID_INTERNAL_CSTYLEPTRCACHE        = 0x000113f3U,
    DISPID_INTERNAL_CRUNTIMESTYLEPTRCACHE = 0x000113f4U,
    DISPID_INTERNAL_INVOKECONTEXT         = 0x000113f5U,
}

enum uint DISPID_A_BGURLIMGCTXCACHEINDEX = 0x000113f6U;
enum uint DISPID_A_LIURLIMGCTXCACHEINDEX = 0x000113f7U;
enum uint DISPID_A_ROWSETASYNCHNOTIFYSINK = 0x000113f8U;
enum uint DISPID_INTERNAL_FILTERPTRCACHE = 0x000113f9U;
enum uint DISPID_A_ROWPOSITIONCHANGESINK = 0x000113faU;

enum : uint
{
    DISPID_A_BEHAVIOR     = 0x000113fbU,
    DISPID_A_READYSTATE   = 0x000113fcU,
    DISPID_A_DIR          = 0x000113fdU,
    DISPID_A_UNICODEBIDI  = 0x000113feU,
    DISPID_A_DIRECTION    = 0x000113ffU,
    DISPID_A_IMEMODE      = 0x00011400U,
    DISPID_A_RUBYALIGN    = 0x00011401U,
    DISPID_A_RUBYPOSITION = 0x00011402U,
    DISPID_A_RUBYOVERHANG = 0x00011403U,
}

enum : uint
{
    DISPID_INTERNAL_ONBEHAVIOR_CONTENTREADY  = 0x00011404U,
    DISPID_INTERNAL_ONBEHAVIOR_DOCUMENTREADY = 0x00011405U,
}

enum uint DISPID_INTERNAL_CDOMCHILDRENPTRCACHE = 0x00011406U;

enum : uint
{
    DISPID_A_LAYOUTGRIDCHAR        = 0x00011407U,
    DISPID_A_LAYOUTGRIDLINE        = 0x00011408U,
    DISPID_A_LAYOUTGRIDMODE        = 0x00011409U,
    DISPID_A_LAYOUTGRIDTYPE        = 0x0001140aU,
    DISPID_A_LAYOUTGRID            = 0x0001140bU,
    DISPID_A_TEXTAUTOSPACE         = 0x0001140cU,
    DISPID_A_LINEBREAK             = 0x0001140dU,
    DISPID_A_WORDBREAK             = 0x0001140eU,
    DISPID_A_TEXTJUSTIFY           = 0x0001140fU,
    DISPID_A_TEXTJUSTIFYTRIM       = 0x00011410U,
    DISPID_A_TEXTKASHIDA           = 0x00011411U,
    DISPID_A_OVERFLOWX             = 0x00011413U,
    DISPID_A_OVERFLOWY             = 0x00011414U,
    DISPID_A_HTCDISPATCHITEM_VALUE = 0x00011415U,
}

enum : uint
{
    DISPID_A_DOCFRAGMENT             = 0x00011416U,
    DISPID_A_HTCDD_ELEMENT           = 0x00011417U,
    DISPID_A_HTCDD_CREATEEVENTOBJECT = 0x00011418U,
}

enum : uint
{
    DISPID_A_URNATOM          = 0x00011419U,
    DISPID_A_UNIQUEPEERNUMBER = 0x0001141aU,
}

enum uint DISPID_A_ACCELERATOR = 0x0001141bU;

enum : uint
{
    DISPID_INTERNAL_ONBEHAVIOR_APPLYSTYLE = 0x0001141cU,
    DISPID_INTERNAL_RUNTIMESTYLEAA        = 0x0001141dU,
}

enum uint DISPID_A_HTCDISPATCHITEM_VALUE_SCRIPTSONLY = 0x0001141eU;
enum uint DISPID_A_EXTENDEDTAGDESC = 0x0001141fU;

enum : uint
{
    DISPID_A_ROTATE                 = 0x00011420U,
    DISPID_A_ZOOM                   = 0x00011421U,
    DISPID_A_HTCDD_PROTECTEDELEMENT = 0x00011422U,
}

enum uint DISPID_A_LAYOUTFLOW = 0x00011423U;
enum uint DISPID_INTERNAL_FILTERNATIVEINFOPTRCACHE = 0x00011424U;
enum uint DISPID_A_HTCDD_ISMARKUPSHARED = 0x00011425U;

enum : uint
{
    DISPID_A_WORDWRAP              = 0x00011426U,
    DISPID_A_TEXTUNDERLINEPOSITION = 0x00011427U,
}

enum : uint
{
    DISPID_A_HASLAYOUT = 0x00011428U,
    DISPID_A_MEDIA     = 0x00011429U,
    DISPID_A_EDITABLE  = 0x0001142aU,
    DISPID_A_HIDEFOCUS = 0x0001142bU,
}

enum uint DISPID_INTERNAL_LAYOUTRECTREGISTRYPTRCACHE = 0x0001142cU;
enum uint DISPID_A_HTCDD_DEFAULTS = 0x0001142dU;

enum : uint
{
    DISPID_A_TEXTLINETHROUGHSTYLE = 0x0001142eU,
    DISPID_A_TEXTUNDERLINESTYLE   = 0x0001142fU,
    DISPID_A_TEXTEFFECT           = 0x00011430U,
    DISPID_A_TEXTBACKGROUNDCOLOR  = 0x00011431U,
}

enum uint DISPID_A_RENDERINGPRIORITY = 0x00011432U;

enum : uint
{
    DISPID_INTERNAL_DWNPOSTPTRCACHE          = 0x00011433U,
    DISPID_INTERNAL_CODEPAGESETTINGSPTRCACHE = 0x00011434U,
}

enum : uint
{
    DISPID_INTERNAL_DWNDOCPTRCACHE                  = 0x00011435U,
    DISPID_INTERNAL_DATABINDTASKPTRCACHE            = 0x00011436U,
    DISPID_INTERNAL_URLLOCATIONCACHE                = 0x00011437U,
    DISPID_INTERNAL_ARYELEMENTRELEASENOTIFYPTRCACHE = 0x00011438U,
}

enum uint DISPID_INTERNAL_PEERFACTORYURLMAPPTRCACHE = 0x00011439U;

enum : uint
{
    DISPID_INTERNAL_STMDIRTYPTRCACHE        = 0x0001143aU,
    DISPID_INTERNAL_COMPUTEFORMATSTATECACHE = 0x0001143bU,
}

enum : uint
{
    DISPID_A_SCROLLBARBASECOLOR       = 0x0001143cU,
    DISPID_A_SCROLLBARFACECOLOR       = 0x0001143dU,
    DISPID_A_SCROLLBAR3DLIGHTCOLOR    = 0x0001143eU,
    DISPID_A_SCROLLBARSHADOWCOLOR     = 0x0001143fU,
    DISPID_A_SCROLLBARHIGHLIGHTCOLOR  = 0x00011440U,
    DISPID_A_SCROLLBARDARKSHADOWCOLOR = 0x00011441U,
    DISPID_A_SCROLLBARARROWCOLOR      = 0x00011442U,
}

enum uint DISPID_INTERNAL_ONBEHAVIOR_CONTENTSAVE = 0x00011443U;
enum uint DISPID_A_DEFAULTTEXTSELECTION = 0x00011444U;

enum : uint
{
    DISPID_A_TEXTDECORATIONCOLOR = 0x00011445U,
    DISPID_A_TEXTCOLOR           = 0x00011446U,
    DISPID_A_STYLETEXTDECORATION = 0x00011447U,
}

enum uint DISPID_A_WRITINGMODE = 0x00011448U;

enum : uint
{
    DISPID_INTERNAL_MEDIA_REFERENCE   = 0x00011449U,
    DISPID_INTERNAL_GENERICCOMPLUSREF = 0x0001144aU,
    DISPID_INTERNAL_FOCUSITEMS        = 0x0001144bU,
}

enum uint DISPID_A_SCROLLBARTRACKCOLOR = 0x0001144cU;
enum uint DISPID_INTERNAL_DWNHEADERCACHE = 0x0001144dU;

enum : uint
{
    DISPID_A_FROZEN           = 0x0001144eU,
    DISPID_A_VIEWINHERITSTYLE = 0x0001144fU,
}

enum uint DISPID_INTERNAL_FRAMESCOLLECTION = 0x00011450U;

enum : uint
{
    DISPID_A_BGURLIMGCTXCACHEINDEX_FLINE   = 0x00011451U,
    DISPID_A_BGURLIMGCTXCACHEINDEX_FLETTER = 0x00011452U,
}

enum : uint
{
    DISPID_A_TEXTALIGNLAST    = 0x00011453U,
    DISPID_A_TEXTKASHIDASPACE = 0x00011454U,
}

enum uint DISPID_INTERNAL_FONTHISTORYINDEX = 0x00011455U;
enum uint DISPID_A_ALLOWTRANSPARENCY = 0x00011456U;
enum uint DISPID_INTERNAL_URLSEARCHCACHE = 0x00011457U;

enum : uint
{
    DISPID_A_ISBLOCK      = 0x00011458U,
    DISPID_A_TEXTOVERFLOW = 0x00011459U,
}

enum uint DISPID_INTERNAL_CATTRIBUTECOLLPTRCACHE = 0x0001145aU;
enum uint DISPID_A_MINHEIGHT = 0x0001145bU;
enum uint DISPID_INTERNAL_INVOKECONTEXTDOCUMENT = 0x0001145cU;

enum : uint
{
    DISPID_A_INTERPOLATION                          = 0x0001145dU,
    DISPID_A_MAXHEIGHT                              = 0x0001145eU,
    DISPID_A_MINWIDTH                               = 0x0001145fU,
    DISPID_A_MAXWIDTH                               = 0x00011460U,
    DISPID_INTERNAL_ARYOBJECTRELEASECLEANUPPTRCACHE = 0x00011461U,
}

enum : uint
{
    DISPID_A_CONTENT          = 0x00011462U,
    DISPID_A_CAPTIONSIDE      = 0x00011463U,
    DISPID_A_COUNTERINCREMENT = 0x00011464U,
    DISPID_A_COUNTERRESET     = 0x00011465U,
    DISPID_A_OUTLINE          = 0x00011466U,
    DISPID_A_OUTLINEWIDTH     = 0x00011467U,
    DISPID_A_OUTLINESTYLE     = 0x00011468U,
    DISPID_A_OUTLINECOLOR     = 0x00011469U,
    DISPID_A_BOXSIZING        = 0x0001146aU,
    DISPID_A_BORDERSPACING    = 0x0001146bU,
    DISPID_A_ORPHANS          = 0x0001146cU,
    DISPID_A_WIDOWS           = 0x0001146dU,
    DISPID_A_PAGEBREAKINSIDE  = 0x0001146eU,
}

enum : uint
{
    DISPID_A_MS_BEHAVIOR                 = 0x0001146fU,
    DISPID_A_MS_SCROLLBARBASECOLOR       = 0x00011470U,
    DISPID_A_MS_SCROLLBARFACECOLOR       = 0x00011471U,
    DISPID_A_MS_SCROLLBAR3DLIGHTCOLOR    = 0x00011472U,
    DISPID_A_MS_SCROLLBARSHADOWCOLOR     = 0x00011473U,
    DISPID_A_MS_SCROLLBARHIGHLIGHTCOLOR  = 0x00011474U,
    DISPID_A_MS_SCROLLBARDARKSHADOWCOLOR = 0x00011475U,
    DISPID_A_MS_SCROLLBARARROWCOLOR      = 0x00011476U,
    DISPID_A_MS_SCROLLBARTRACKCOLOR      = 0x00011477U,
}

enum : uint
{
    DISPID_A_MS_TEXTALIGNLAST         = 0x00011478U,
    DISPID_A_MS_TEXTOVERFLOW          = 0x00011479U,
    DISPID_A_MS_TEXTUNDERLINEPOSITION = 0x0001147aU,
}

enum : uint
{
    DISPID_A_MS_WRITINGMODE      = 0x0001147bU,
    DISPID_A_MS_IMEMODE          = 0x0001147cU,
    DISPID_A_MS_BACKGROUNDPOSX   = 0x0001147dU,
    DISPID_A_MS_BACKGROUNDPOSY   = 0x0001147eU,
    DISPID_A_MS_ACCELERATOR      = 0x0001147fU,
    DISPID_A_MS_LAYOUTFLOW       = 0x00011480U,
    DISPID_A_MS_ZOOM             = 0x00011481U,
    DISPID_A_EMPTYCELLS          = 0x00011482U,
    DISPID_A_MS_BLOCKPROGRESSION = 0x00011483U,
}

enum : uint
{
    DISPID_A_QUOTES                                 = 0x00011484U,
    DISPID_INTERNAL_BGURLIMGCTXCACHEINDEX_GCBEFORE  = 0x00011485U,
    DISPID_INTERNAL_BGURLIMGCTXCACHEINDEX_GCAFTER   = 0x00011486U,
    DISPID_INTERNAL_BGURLIMGCTXCACHEINDEX_URLBEFORE = 0x00011487U,
    DISPID_INTERNAL_BGURLIMGCTXCACHEINDEX_URLAFTER  = 0x00011488U,
}

enum : uint
{
    DISPID_AAHEADER                        = 0x00011489U,
    DISPID_INTERNAL_GETTERSETTERCOLLECTION = 0x0001148aU,
}

enum : uint
{
    DISPID_A_MS_LAYOUTGRIDCHAR   = 0x0001148bU,
    DISPID_A_MS_LAYOUTGRIDLINE   = 0x0001148cU,
    DISPID_A_MS_LAYOUTGRIDMODE   = 0x0001148dU,
    DISPID_A_MS_LAYOUTGRIDTYPE   = 0x0001148eU,
    DISPID_A_MS_LAYOUTGRID       = 0x0001148fU,
    DISPID_A_MS_LINEBREAK        = 0x00011490U,
    DISPID_A_MS_FILTER           = 0x00011491U,
    DISPID_A_MS_OVERFLOWX        = 0x00011492U,
    DISPID_A_MS_OVERFLOWY        = 0x00011493U,
    DISPID_A_MS_TEXTAUTOSPACE    = 0x00011494U,
    DISPID_A_MS_TEXTJUSTIFY      = 0x00011495U,
    DISPID_A_MS_TEXTKASHIDASPACE = 0x00011496U,
    DISPID_A_MS_WORDBREAK        = 0x00011497U,
    DISPID_A_MS_WORDWRAP         = 0x00011498U,
}

enum uint DISPID_INTERNAL_URIBEFOREREDIRECT = 0x00011499U;
enum uint DISPID_A_ALIGNMENTBASELINE = 0x0001149eU;

enum : uint
{
    DISPID_A_BASELINESHIFT    = 0x0001149fU,
    DISPID_A_DOMINANTBASELINE = 0x000114a0U,
}

enum : uint
{
    DISPID_A_FONTSIZEADJUST             = 0x000114a1U,
    DISPID_A_FONTSTRETCH                = 0x000114a2U,
    DISPID_A_OPACITY                    = 0x000114a3U,
    DISPID_A_CLIPPATH                   = 0x000114a4U,
    DISPID_A_CLIPRULE                   = 0x000114a5U,
    DISPID_A_FILL                       = 0x000114a6U,
    DISPID_A_FILLOPACITY                = 0x000114a7U,
    DISPID_A_FILLRULE                   = 0x000114a8U,
    DISPID_A_KERNING                    = 0x000114a9U,
    DISPID_A_MARKER                     = 0x000114aaU,
    DISPID_A_MARKEREND                  = 0x000114abU,
    DISPID_A_MARKERMID                  = 0x000114acU,
    DISPID_A_MARKERSTART                = 0x000114adU,
    DISPID_A_MASK                       = 0x000114aeU,
    DISPID_A_POINTEREVENTS              = 0x000114afU,
    DISPID_A_STOPCOLOR                  = 0x000114b0U,
    DISPID_A_STOPOPACITY                = 0x000114b1U,
    DISPID_A_STROKE                     = 0x000114b2U,
    DISPID_A_STROKEDASHARRAY            = 0x000114b3U,
    DISPID_A_STROKEDASHOFFSET           = 0x000114b4U,
    DISPID_A_STROKELINECAP              = 0x000114b5U,
    DISPID_A_STROKELINEJOIN             = 0x000114b6U,
    DISPID_A_STROKEMITERLIMIT           = 0x000114b7U,
    DISPID_A_STROKEOPACITY              = 0x000114b8U,
    DISPID_A_STROKEWIDTH                = 0x000114b9U,
    DISPID_A_TEXTANCHOR                 = 0x000114baU,
    DISPID_A_GLYPHORIENTATIONHORIZONTAL = 0x000114bbU,
    DISPID_A_GLYPHORIENTATIONVERTICAL   = 0x000114bcU,
}

enum : uint
{
    DISPID_A_CSSFLOAT                = 0x000114bdU,
    DISPID_A_BORDERRADIUS            = 0x000114beU,
    DISPID_A_BORDERTOPLEFTRADIUS     = 0x000114bfU,
    DISPID_A_BORDERTOPRIGHTRADIUS    = 0x000114c0U,
    DISPID_A_BORDERBOTTOMRIGHTRADIUS = 0x000114c1U,
    DISPID_A_BORDERBOTTOMLEFTRADIUS  = 0x000114c2U,
}

enum : uint
{
    DISPID_A_MS_TRANSFORM                = 0x000114c3U,
    DISPID_A_IE9_BACKGROUNDCLIP          = 0x000114c4U,
    DISPID_A_IE9_BACKGROUNDORIGIN        = 0x000114c5U,
    DISPID_A_IE9_BACKGROUNDSIZE          = 0x000114c6U,
    DISPID_A_IE9_BOXSHADOW               = 0x000114c7U,
    DISPID_A_MS_TRANSFORMORIGIN          = 0x000114cdU,
    DISPID_A_MS_TRANSFORMORIGINX         = 0x000114ceU,
    DISPID_A_MS_TRANSFORMORIGINY         = 0x000114cfU,
    DISPID_A_MS_TEXTSIZEADJUST           = 0x000114d0U,
    DISPID_A_MS_TRANSITIONPROPERTY       = 0x000114d2U,
    DISPID_A_MS_TRANSITIONDURATION       = 0x000114d3U,
    DISPID_A_MS_TRANSITIONTIMINGFUNCTION = 0x000114d4U,
    DISPID_A_MS_TRANSITIONDELAY          = 0x000114d5U,
    DISPID_A_MS_TRANSITION               = 0x000114d6U,
    DISPID_A_COLUMNS                     = 0x000114d7U,
    DISPID_A_COLUMNCOUNT                 = 0x000114d8U,
    DISPID_A_COLUMNWIDTH                 = 0x000114d9U,
    DISPID_A_COLUMNGAP                   = 0x000114daU,
    DISPID_A_COLUMNFILL                  = 0x000114dbU,
    DISPID_A_COLUMNSPAN                  = 0x000114dcU,
    DISPID_A_COLUMNRULE                  = 0x000114ddU,
    DISPID_A_COLUMNRULESTYLE             = 0x000114deU,
    DISPID_A_COLUMNRULEWIDTH             = 0x000114dfU,
    DISPID_A_COLUMNRULECOLOR             = 0x000114e0U,
}

enum : uint
{
    DISPID_A_BREAKBEFORE           = 0x000114e1U,
    DISPID_A_BREAKAFTER            = 0x000114e2U,
    DISPID_A_BREAKINSIDE           = 0x000114e3U,
    DISPID_A_MS_TRANSFORMORIGINZ   = 0x000114e4U,
    DISPID_A_MS_PERSPECTIVE        = 0x000114e5U,
    DISPID_A_MS_PERSPECTIVEORIGIN  = 0x000114e6U,
    DISPID_A_MS_PERSPECTIVEORIGINX = 0x000114e7U,
    DISPID_A_MS_PERSPECTIVEORIGINY = 0x000114e8U,
}

enum : uint
{
    DISPID_A_MS_TRANSFORMSTYLE     = 0x000114e9U,
    DISPID_A_MS_BACKFACEVISIBILITY = 0x000114eaU,
}

enum : uint
{
    DISPID_A_MS_SCROLLCHAINING      = 0x000114ebU,
    DISPID_A_MS_CONTENTZOOMING      = 0x000114ecU,
    DISPID_A_MS_CONTENTZOOMSNAPTYPE = 0x000114edU,
}

enum : uint
{
    DISPID_A_MS_SCROLLRAILS         = 0x000114eeU,
    DISPID_A_MS_CONTENTZOOMCHAINING = 0x000114efU,
}

enum : uint
{
    DISPID_A_MS_SCROLLSNAPTYPE        = 0x000114f0U,
    DISPID_A_MS_CONTENTZOOMLIMIT      = 0x000114f1U,
    DISPID_A_MS_CONTENTZOOMSNAP       = 0x000114f2U,
    DISPID_A_MS_CONTENTZOOMSNAPPOINTS = 0x000114f3U,
    DISPID_A_MS_CONTENTZOOMFACTOR     = 0x000114f4U,
    DISPID_A_MS_CONTENTZOOMLIMITMIN   = 0x000114f5U,
    DISPID_A_MS_CONTENTZOOMLIMITMAX   = 0x000114f6U,
}

enum : uint
{
    DISPID_A_MS_SCROLLSNAPX       = 0x000114f7U,
    DISPID_A_MS_SCROLLSNAPY       = 0x000114f8U,
    DISPID_A_MS_SCROLLSNAPPOINTSX = 0x000114f9U,
    DISPID_A_MS_SCROLLSNAPPOINTSY = 0x000114faU,
}

enum : uint
{
    DISPID_A_SPELLCHECK                 = 0x000114fbU,
    DISPID_A_MS_GRIDCOLUMN              = 0x000114fcU,
    DISPID_A_MS_GRIDCOLUMNALIGN         = 0x000114fdU,
    DISPID_A_MS_GRIDCOLUMNS             = 0x000114feU,
    DISPID_A_MS_GRIDCOLUMNSPAN          = 0x000114ffU,
    DISPID_A_MS_GRIDROW                 = 0x00011501U,
    DISPID_A_MS_GRIDROWALIGN            = 0x00011502U,
    DISPID_A_MS_GRIDROWS                = 0x00011503U,
    DISPID_A_MS_GRIDROWSPAN             = 0x00011504U,
    DISPID_A_MS_ANIMATIONNAME           = 0x00011505U,
    DISPID_A_MS_ANIMATIONDURATION       = 0x00011506U,
    DISPID_A_MS_ANIMATIONTIMINGFUNCTION = 0x00011507U,
    DISPID_A_MS_ANIMATIONDELAY          = 0x00011508U,
    DISPID_A_MS_ANIMATIONDIRECTION      = 0x00011509U,
    DISPID_A_MS_ANIMATIONPLAYSTATE      = 0x0001150aU,
    DISPID_A_MS_ANIMATIONITERATIONCOUNT = 0x0001150bU,
    DISPID_A_MS_ANIMATION               = 0x0001150cU,
    DISPID_A_MS_ANIMATIONFILLMODE       = 0x0001150dU,
}

enum : uint
{
    DISPID_A_FLOODCOLOR                = 0x0001150eU,
    DISPID_A_FLOODOPACITY              = 0x0001150fU,
    DISPID_A_COLORINTERPOLATIONFILTERS = 0x00011510U,
}

enum : uint
{
    DISPID_A_LIGHTINGCOLOR      = 0x00011511U,
    DISPID_A_MS_SCROLLLIMITXMIN = 0x00011512U,
    DISPID_A_MS_SCROLLLIMITYMIN = 0x00011513U,
    DISPID_A_MS_SCROLLLIMITXMAX = 0x00011514U,
    DISPID_A_MS_SCROLLLIMITYMAX = 0x00011515U,
    DISPID_A_MS_SCROLLLIMIT     = 0x00011516U,
    DISPID_A_MS_OVERFLOWSTYLE   = 0x00011517U,
}

enum : uint
{
    DISPID_A_TEXTSHADOW               = 0x00011518U,
    DISPID_A_MS_WRAPTHROUGH           = 0x00011519U,
    DISPID_A_MS_FLOWFROM              = 0x0001151aU,
    DISPID_A_MS_FLOWINTO              = 0x0001151bU,
    DISPID_A_MS_HYPHENS               = 0x0001151cU,
    DISPID_A_MS_HYPHENATE_LIMIT_ZONE  = 0x0001151dU,
    DISPID_A_MS_HYPHENATE_LIMIT_CHARS = 0x0001151eU,
    DISPID_A_MS_HYPHENATE_LIMIT_LINES = 0x0001151fU,
}

enum : uint
{
    DISPID_A_DRAGGABLE             = 0x00011520U,
    DISPID_A_MS_HIGHCONTRASTADJUST = 0x00011521U,
}

enum uint DISPID_A_ENABLEBACKGROUND = 0x00011522U;

enum : uint
{
    DISPID_A_MS_WRAPMARGIN          = 0x00011523U,
    DISPID_A_MS_WRAPFLOW            = 0x00011525U,
    DISPID_A_MS_FONTFEATURESETTINGS = 0x00011526U,
}

enum : uint
{
    DISPID_A_MS_USERSELECT  = 0x00011527U,
    DISPID_A_MS_TOUCHACTION = 0x00011528U,
}

enum : uint
{
    DISPID_A_CLASSLIST                = 0x00011529U,
    DISPID_A_MS_SCROLLTRANSLATION     = 0x0001152aU,
    DISPID_A_MS_FLEX                  = 0x0001152bU,
    DISPID_A_MS_FLEXPOSITIVE          = 0x0001152cU,
    DISPID_A_MS_FLEXNEGATIVE          = 0x0001152dU,
    DISPID_A_MS_FLEXPREFERREDSIZE     = 0x0001152eU,
    DISPID_A_MS_FLEXFLOW              = 0x0001152fU,
    DISPID_A_MS_FLEXDIRECTION         = 0x00011530U,
    DISPID_A_MS_FLEXWRAP              = 0x00011531U,
    DISPID_A_MS_FLEXALIGN             = 0x00011532U,
    DISPID_A_MS_FLEXITEMALIGN         = 0x00011533U,
    DISPID_A_MS_FLEXPACK              = 0x00011534U,
    DISPID_A_MS_FLEXLINEPACK          = 0x00011535U,
    DISPID_A_MS_FLEXORDER             = 0x00011536U,
    DISPID_A_TRANSFORM                = 0x00011537U,
    DISPID_A_TRANSFORMORIGIN          = 0x00011538U,
    DISPID_A_TRANSITIONPROPERTY       = 0x00011539U,
    DISPID_A_TRANSITIONDURATION       = 0x0001153aU,
    DISPID_A_TRANSITIONTIMINGFUNCTION = 0x0001153bU,
    DISPID_A_TRANSITIONDELAY          = 0x0001153cU,
    DISPID_A_TRANSITION               = 0x0001153dU,
    DISPID_A_PERSPECTIVE              = 0x0001153eU,
    DISPID_A_PERSPECTIVEORIGIN        = 0x0001153fU,
}

enum uint DISPID_A_TRANSFORMSTYLE = 0x00011540U;
enum uint DISPID_A_BACKFACEVISIBILITY = 0x00011541U;

enum : uint
{
    DISPID_A_ANIMATIONNAME           = 0x00011542U,
    DISPID_A_ANIMATIONDURATION       = 0x00011543U,
    DISPID_A_ANIMATIONTIMINGFUNCTION = 0x00011544U,
    DISPID_A_ANIMATIONDELAY          = 0x00011545U,
    DISPID_A_ANIMATIONDIRECTION      = 0x00011546U,
    DISPID_A_ANIMATIONPLAYSTATE      = 0x00011547U,
    DISPID_A_ANIMATIONITERATIONCOUNT = 0x00011548U,
    DISPID_A_ANIMATION               = 0x00011549U,
    DISPID_A_ANIMATIONFILLMODE       = 0x0001154aU,
}

enum uint DISPID_A_FONTFEATURESETTINGS = 0x0001154bU;

enum : uint
{
    DISPID_A_TRANSFORMORIGINX = 0x0001154cU,
    DISPID_A_TRANSFORMORIGINY = 0x0001154dU,
    DISPID_A_TRANSFORMORIGINZ = 0x0001154eU,
}

enum : uint
{
    DISPID_A_PERSPECTIVEORIGINX = 0x00011550U,
    DISPID_A_PERSPECTIVEORIGINY = 0x00011551U,
}

enum uint DISPID_A_MS_TOUCHSELECT = 0x00011552U;

enum : uint
{
    DISPID_INTERNAL_ERRORPAGEREFRESHURL = 0x00011553U,
    DISPID_INTERNAL_ERRORPAGEREASON     = 0x00011554U,
    DISPID_INTERNAL_ERRORPAGEDWNPOST    = 0x00011555U,
}

enum : uint
{
    DISPID_A_FLEXDIRECTION  = 0x00011556U,
    DISPID_A_FLEXWRAP       = 0x00011557U,
    DISPID_A_FLEXFLOW       = 0x00011558U,
    DISPID_A_ORDER          = 0x00011559U,
    DISPID_A_FLEX           = 0x0001155aU,
    DISPID_A_FLEXGROW       = 0x0001155bU,
    DISPID_A_FLEXSHRINK     = 0x0001155cU,
    DISPID_A_FLEXBASIS      = 0x0001155dU,
    DISPID_A_JUSTIFYCONTENT = 0x0001155eU,
}

enum : uint
{
    DISPID_A_ALIGNITEMS        = 0x0001155fU,
    DISPID_A_ALIGNSELF         = 0x00011560U,
    DISPID_A_ALIGNCONTENT      = 0x00011561U,
    DISPID_A_BORDERIMAGE       = 0x00011562U,
    DISPID_A_BORDERIMAGESOURCE = 0x00011563U,
    DISPID_A_BORDERIMAGESLICE  = 0x00011564U,
    DISPID_A_BORDERIMAGEWIDTH  = 0x00011565U,
    DISPID_A_BORDERIMAGEOUTSET = 0x00011566U,
    DISPID_A_BORDERIMAGEREPEAT = 0x00011567U,
}

enum : uint
{
    DISPID_A_DATASET                  = 0x00011568U,
    DISPID_A_MS_IMEALIGN              = 0x00011569U,
    DISPID_A_MS_TEXTCOMBINEHORIZONTAL = 0x0001156aU,
}

enum : uint
{
    DISPID_A_TOUCHACTION                     = 0x0001156bU,
    DISPID_A_WEBKIT_APPEARANCE               = 0x0001156cU,
    DISPID_A_WEBKIT_BOXALIGN                 = 0x0001156dU,
    DISPID_A_WEBKIT_BOXORDINALGROUP          = 0x0001156eU,
    DISPID_A_WEBKIT_BOXPACK                  = 0x0001156fU,
    DISPID_A_WEBKIT_BOXFLEX                  = 0x00011570U,
    DISPID_A_WEBKIT_BOXORIENT                = 0x00011571U,
    DISPID_A_WEBKIT_BOXDIRECTION             = 0x00011572U,
    DISPID_A_WEBKIT_ANIMATIONFILLMODE        = 0x00011573U,
    DISPID_A_WEBKIT_TRANSFORM                = 0x00011574U,
    DISPID_A_WEBKIT_BACKGROUNDSIZE           = 0x00011575U,
    DISPID_A_WEBKIT_BACKFACEVISIBILITY       = 0x00011576U,
    DISPID_A_WEBKIT_BOXSIZING                = 0x00011577U,
    DISPID_A_WEBKIT_USERSELECT               = 0x00011578U,
    DISPID_A_WEBKIT_ANIMATION                = 0x00011579U,
    DISPID_A_WEBKIT_TRANSITION               = 0x0001157aU,
    DISPID_A_WEBKIT_ANIMATIONNAME            = 0x0001157bU,
    DISPID_A_WEBKIT_ANIMATIONDURATION        = 0x0001157cU,
    DISPID_A_WEBKIT_ANIMATIONTIMINGFUNCTION  = 0x0001157dU,
    DISPID_A_WEBKIT_ANIMATIONDELAY           = 0x0001157eU,
    DISPID_A_WEBKIT_ANIMATIONITERATIONCOUNT  = 0x0001157fU,
    DISPID_A_WEBKIT_ANIMATIONDIRECTION       = 0x00011580U,
    DISPID_A_WEBKIT_ANIMATIONPLAYSTATE       = 0x00011581U,
    DISPID_A_WEBKIT_TRANSITIONPROPERTY       = 0x00011582U,
    DISPID_A_WEBKIT_TRANSITIONDURATION       = 0x00011583U,
    DISPID_A_WEBKIT_TRANSITIONTIMINGFUNCTION = 0x00011584U,
    DISPID_A_WEBKIT_TRANSITIONDELAY          = 0x00011585U,
    DISPID_A_WEBKIT_BACKGROUNDATTACHMENT     = 0x00011586U,
    DISPID_A_WEBKIT_BACKGROUNDCOLOR          = 0x00011587U,
    DISPID_A_WEBKIT_BACKGROUNDCLIP           = 0x00011588U,
    DISPID_A_WEBKIT_BACKGROUNDIMAGE          = 0x00011589U,
    DISPID_A_WEBKIT_BACKGROUNDREPEAT         = 0x0001158aU,
    DISPID_A_WEBKIT_BACKGROUNDORIGIN         = 0x0001158bU,
    DISPID_A_WEBKIT_BACKGROUNDPOSITION       = 0x0001158cU,
    DISPID_A_WEBKIT_BACKGROUNDPOSITIONX      = 0x0001158dU,
    DISPID_A_WEBKIT_BACKGROUNDPOSITIONY      = 0x0001158eU,
    DISPID_A_WEBKIT_BACKGROUND               = 0x0001158fU,
    DISPID_A_WEBKIT_TRANSFORMORIGIN          = 0x00011590U,
    DISPID_A_WEBKIT_TRANSFORMORIGINX         = 0x00011591U,
    DISPID_A_WEBKIT_TRANSFORMORIGINY         = 0x00011592U,
    DISPID_A_WEBKIT_TRANSFORMORIGINZ         = 0x00011593U,
    DISPID_A_WEBKIT_TEXTSIZEADJUST           = 0x00011594U,
    DISPID_A_WEBKIT_BORDERIMAGE              = 0x00011595U,
    DISPID_A_WEBKIT_BORDERIMAGESOURCE        = 0x00011596U,
    DISPID_A_WEBKIT_BORDERIMAGESLICE         = 0x00011597U,
    DISPID_A_WEBKIT_BORDERIMAGEWIDTH         = 0x00011598U,
    DISPID_A_WEBKIT_BORDERIMAGEOUTSET        = 0x00011599U,
    DISPID_A_WEBKIT_BORDERIMAGEREPEAT        = 0x0001159aU,
}

enum : uint
{
    DISPID_INTERNAL_FIRST                = 0x000115e0U,
    DISPID_INTERNAL_BACKGROUNDDEFINITION = 0x000115e1U,
}

enum : uint
{
    DISPID_A_MEDIAORIENTATION          = 0x000115e2U,
    DISPID_A_MEDIAMAXWIDTH             = 0x000115e3U,
    DISPID_A_MEDIAMINWIDTH             = 0x000115e4U,
    DISPID_A_MEDIAWIDTH                = 0x000115e5U,
    DISPID_A_MEDIAMAXHEIGHT            = 0x000115e6U,
    DISPID_A_MEDIAMINHEIGHT            = 0x000115e7U,
    DISPID_A_MEDIAHEIGHT               = 0x000115e8U,
    DISPID_A_MEDIAMAXDEVICEWIDTH       = 0x000115e9U,
    DISPID_A_MEDIAMINDEVICEWIDTH       = 0x000115eaU,
    DISPID_A_MEDIADEVICEWIDTH          = 0x000115ebU,
    DISPID_A_MEDIAMAXDEVICEHEIGHT      = 0x000115ecU,
    DISPID_A_MEDIAMINDEVICEHEIGHT      = 0x000115edU,
    DISPID_A_MEDIADEVICEHEIGHT         = 0x000115eeU,
    DISPID_A_MEDIAMAXASPECTRATIO       = 0x000115efU,
    DISPID_A_MEDIAMINASPECTRATIO       = 0x000115f0U,
    DISPID_A_MEDIAASPECTRATIO          = 0x000115f1U,
    DISPID_A_MEDIAMAXDEVICEASPECTRATIO = 0x000115f2U,
    DISPID_A_MEDIAMINDEVICEASPECTRATIO = 0x000115f3U,
    DISPID_A_MEDIADEVICEASPECTRATIO    = 0x000115f4U,
    DISPID_A_MEDIAMAXCOLOR             = 0x000115f5U,
    DISPID_A_MEDIAMINCOLOR             = 0x000115f6U,
    DISPID_A_MEDIACOLOR                = 0x000115f7U,
    DISPID_A_MEDIAMAXCOLORINDEX        = 0x000115f8U,
    DISPID_A_MEDIAMINCOLORINDEX        = 0x000115f9U,
    DISPID_A_MEDIACOLORINDEX           = 0x000115faU,
    DISPID_A_MEDIAMAXMONOCHROME        = 0x000115fbU,
    DISPID_A_MEDIAMINMONOCHROME        = 0x000115fcU,
    DISPID_A_MEDIAMONOCHROME           = 0x000115fdU,
    DISPID_A_MEDIAMAXRESOLUTION        = 0x000115feU,
    DISPID_A_MEDIAMINRESOLUTION        = 0x000115ffU,
    DISPID_A_MEDIARESOLUTION           = 0x00011600U,
}

enum : uint
{
    DISPID_INTERNAL_CATTRIBUTEPTRCACHE   = 0x00011601U,
    DISPID_INTERNAL_FONTFACEUNICODERANGE = 0x00011602U,
    DISPID_INTERNAL_TOUCHTARGETHANDLER   = 0x00011603U,
    DISPID_INTERNAL_PAGEFLOWCOLLECTION   = 0x00011604U,
    DISPID_INTERNAL_NAMEDFLOWCOLLECTION  = 0x00011605U,
}

enum uint DISPID_A_MEDIAMSHIGHCONTRAST = 0x00011606U;

enum : uint
{
    DISPID_INTERNAL_A_MS_HYPHENATE_LIMIT_WORDS  = 0x00011607U,
    DISPID_INTERNAL_A_MS_HYPHENATE_LIMIT_BEFORE = 0x00011608U,
    DISPID_INTERNAL_A_MS_HYPHENATE_LIMIT_AFTER  = 0x00011609U,
}

enum uint DISPID_A_MEDIAMSVIEWSTATE = 0x0001160aU;

enum : uint
{
    DISPID_INTERNAL_ARIAATOMIC       = 0x0001160bU,
    DISPID_INTERNAL_ARIAAUTOCOMPLETE = 0x0001160cU,
    DISPID_INTERNAL_ARIADROPEFFECT   = 0x0001160dU,
    DISPID_INTERNAL_ARIAGRABBED      = 0x0001160eU,
    DISPID_INTERNAL_ARIALABEL        = 0x0001160fU,
    DISPID_INTERNAL_ARIAMULTILINE    = 0x00011610U,
    DISPID_INTERNAL_ARIAORIENTATION  = 0x00011611U,
    DISPID_INTERNAL_ARIASORT         = 0x00011612U,
    DISPID_INTERNAL_ARIAVALUETEXT    = 0x00011613U,
}

enum : uint
{
    DISPID_A_MEDIAGRID              = 0x00011614U,
    DISPID_A_MEDIASCAN              = 0x00011615U,
    DISPID_A_ACCEVENTRECORDID_START = 0x00011616U,
    DISPID_A_ACCEVENTRECORDID_END   = 0x00011629U,
}

enum : uint
{
    DISPID_INTERNAL_REQUIRED         = 0x0001162aU,
    DISPID_INTERNAL_CSS_PARSEDARY    = 0x0001162bU,
    DISPID_INTERNAL_SOURCELOCATION   = 0x0001162cU,
    DISPID_INTERNAL_CSS_TRACEDSTYLES = 0x0001162dU,
}

enum uint DISPID_A_BDURLIMGCTXCACHEINDEX = 0x0001162eU;

enum : uint
{
    DISPID_A_MEDIAWEBKITDEVICEPIXELRATIO    = 0x0001162fU,
    DISPID_A_MEDIAWEBKITMAXDEVICEPIXELRATIO = 0x00011630U,
    DISPID_A_MEDIAWEBKITMINDEVICEPIXELRATIO = 0x00011631U,
}

enum uint DISPID_SVGSTYLABLE_CLASSNAME_PROP = 0x000003e9U;

enum : uint
{
    DISPID_SVGLOCATABLE_NEARESTVIEWPORTELEMENT  = 0x000003eaU,
    DISPID_SVGLOCATABLE_FARTHESTVIEWPORTELEMENT = 0x000003ebU,
    DISPID_SVGLOCATABLE_GETBBOX                 = 0x000003ecU,
    DISPID_SVGLOCATABLE_GETCTM                  = 0x000003edU,
    DISPID_SVGLOCATABLE_GETSCREENCTM            = 0x000003eeU,
    DISPID_SVGLOCATABLE_GETTRANSFORMTOELEMENT   = 0x000003efU,
}

enum : uint
{
    DISPID_SVGTRANSFORMABLE_TRANSFORM_ATTR = 0x000003f0U,
    DISPID_SVGTRANSFORMABLE_TRANSFORM_PROP = 0x000003f1U,
}

enum : uint
{
    DISPID_SVGTESTS_REQUIREDFEATURES_ATTR   = 0x000003f2U,
    DISPID_SVGTESTS_REQUIREDFEATURES_PROP   = 0x000003f3U,
    DISPID_SVGTESTS_REQUIREDEXTENSIONS_ATTR = 0x000003f4U,
    DISPID_SVGTESTS_REQUIREDEXTENSIONS_PROP = 0x000003f5U,
    DISPID_SVGTESTS_SYSTEMLANGUAGE_ATTR     = 0x000003f6U,
    DISPID_SVGTESTS_SYSTEMLANGUAGE_PROP     = 0x000003f7U,
    DISPID_SVGTESTS_HASEXTENSION            = 0x000003f8U,
}

enum : uint
{
    DISPID_SVGLANGSPACE_XMLLANG  = 0x000003f9U,
    DISPID_SVGLANGSPACE_XMLSPACE = 0x000003faU,
}

enum : uint
{
    DISPID_SVGEXTERNALRESOURCESREQUIRED_EXTERNALRESOURCESREQUIRED_ATTR = 0x000003fbU,
    DISPID_SVGEXTERNALRESOURCESREQUIRED_EXTERNALRESOURCESREQUIRED_PROP = 0x000003fcU,
}

enum : uint
{
    DISPID_SVGFITTOVIEWBOX_VIEWBOX_ATTR             = 0x000003fdU,
    DISPID_SVGFITTOVIEWBOX_VIEWBOX_PROP             = 0x000003feU,
    DISPID_SVGFITTOVIEWBOX_PRESERVEASPECTRATIO_ATTR = 0x000003ffU,
    DISPID_SVGFITTOVIEWBOX_PRESERVEASPECTRATIO_PROP = 0x00000400U,
}

enum uint DISPID_SVGZOOMANDPAN_ZOOMANDPAN = 0x00000401U;
enum uint DISPID_SVGURIREFERENCE_HREF = 0x00000402U;
enum uint DISPID_EVPROP_ONMOUSEOVER = 0x00011770U;
enum uint DISPID_EVMETH_ONMOUSEOVER = 0x00010008U;
enum uint DISPID_EVPROP_ONMOUSEOUT = 0x00011771U;
enum uint DISPID_EVMETH_ONMOUSEOUT = 0x00010009U;
enum uint DISPID_EVPROP_ONMOUSEDOWN = 0x00011772U;
enum int DISPID_EVMETH_ONMOUSEDOWN = 0xfffffda3;
enum uint DISPID_EVPROP_ONMOUSEUP = 0x00011773U;
enum int DISPID_EVMETH_ONMOUSEUP = 0xfffffda1;
enum uint DISPID_EVPROP_ONMOUSEMOVE = 0x00011774U;
enum int DISPID_EVMETH_ONMOUSEMOVE = 0xfffffda2;
enum uint DISPID_EVPROP_ONKEYDOWN = 0x00011775U;
enum int DISPID_EVMETH_ONKEYDOWN = 0xfffffda6;
enum uint DISPID_EVPROP_ONKEYUP = 0x00011776U;
enum int DISPID_EVMETH_ONKEYUP = 0xfffffda4;
enum uint DISPID_EVPROP_ONKEYPRESS = 0x00011777U;
enum int DISPID_EVMETH_ONKEYPRESS = 0xfffffda5;
enum uint DISPID_EVPROP_ONCLICK = 0x00011778U;
enum int DISPID_EVMETH_ONCLICK = 0xfffffda8;
enum uint DISPID_EVPROP_ONDBLCLICK = 0x00011779U;
enum int DISPID_EVMETH_ONDBLCLICK = 0xfffffda7;

enum : uint
{
    DISPID_EVPROP_ONSELECT  = 0x0001177aU,
    DISPID_EVMETH_ONSELECT  = 0x000003eeU,
    DISPID_EVPROP_ONSUBMIT  = 0x0001177bU,
    DISPID_EVMETH_ONSUBMIT  = 0x000003efU,
    DISPID_EVPROP_ONRESET   = 0x0001177cU,
    DISPID_EVMETH_ONRESET   = 0x000003f7U,
    DISPID_EVPROP_ONHELP    = 0x0001177dU,
    DISPID_EVMETH_ONHELP    = 0x0001000aU,
    DISPID_EVPROP_ONFOCUS   = 0x0001177eU,
    DISPID_EVMETH_ONFOCUS   = 0x00010001U,
    DISPID_EVPROP_ONBLUR    = 0x0001177fU,
    DISPID_EVPROP_ONROWEXIT = 0x00011782U,
}

enum uint DISPID_EVMETH_ONROWEXIT = 0x00010006U;
enum uint DISPID_EVPROP_ONROWENTER = 0x00011783U;
enum uint DISPID_EVMETH_ONROWENTER = 0x00010007U;

enum : uint
{
    DISPID_EVPROP_ONBOUNCE       = 0x00011784U,
    DISPID_EVMETH_ONBOUNCE       = 0x000003f1U,
    DISPID_EVPROP_ONBEFOREUPDATE = 0x00011785U,
}

enum uint DISPID_EVMETH_ONBEFOREUPDATE = 0x00010004U;
enum uint DISPID_EVPROP_ONAFTERUPDATE = 0x00011786U;
enum uint DISPID_EVMETH_ONAFTERUPDATE = 0x00010005U;

enum : uint
{
    DISPID_EVPROP_ONBEFOREDRAGOVER    = 0x00011787U,
    DISPID_EVPROP_ONBEFOREDROPORPASTE = 0x00011788U,
    DISPID_EVPROP_ONREADYSTATECHANGE  = 0x00011789U,
}

enum int DISPID_EVMETH_ONREADYSTATECHANGE = 0xfffffd9f;

enum : uint
{
    DISPID_EVPROP_ONFINISH    = 0x0001178aU,
    DISPID_EVMETH_ONFINISH    = 0x000003f2U,
    DISPID_EVPROP_ONSTART     = 0x0001178bU,
    DISPID_EVMETH_ONSTART     = 0x000003f3U,
    DISPID_EVPROP_ONABORT     = 0x0001178cU,
    DISPID_EVMETH_ONABORT     = 0x000003e8U,
    DISPID_EVPROP_ONERROR     = 0x0001178dU,
    DISPID_EVMETH_ONERROR     = 0x000003eaU,
    DISPID_EVPROP_ONCHANGE    = 0x0001178eU,
    DISPID_EVMETH_ONCHANGE    = 0x000003e9U,
    DISPID_EVPROP_ONSCROLL    = 0x0001178fU,
    DISPID_EVMETH_ONSCROLL    = 0x000003f6U,
    DISPID_EVPROP_ONLOAD      = 0x00011790U,
    DISPID_EVMETH_ONLOAD      = 0x000003ebU,
    DISPID_EVPROP_ONUNLOAD    = 0x00011791U,
    DISPID_EVMETH_ONUNLOAD    = 0x000003f0U,
    DISPID_EVPROP_ONLAYOUT    = 0x00011792U,
    DISPID_EVMETH_ONLAYOUT    = 0x000003f5U,
    DISPID_EVPROP_ONDRAGSTART = 0x00011793U,
}

enum uint DISPID_EVMETH_ONDRAGSTART = 0x0001000bU;

enum : uint
{
    DISPID_EVPROP_ONRESIZE      = 0x00011794U,
    DISPID_EVMETH_ONRESIZE      = 0x000003f8U,
    DISPID_EVPROP_ONSELECTSTART = 0x00011795U,
}

enum uint DISPID_EVMETH_ONSELECTSTART = 0x0001000cU;
enum uint DISPID_EVPROP_ONERRORUPDATE = 0x00011796U;
enum uint DISPID_EVMETH_ONERRORUPDATE = 0x0001000dU;
enum uint DISPID_EVPROP_ONBEFOREUNLOAD = 0x00011797U;
enum uint DISPID_EVMETH_ONBEFOREUNLOAD = 0x000003f9U;
enum uint DISPID_EVPROP_ONDATASETCHANGED = 0x00011798U;
enum uint DISPID_EVMETH_ONDATASETCHANGED = 0x0001000eU;
enum uint DISPID_EVPROP_ONDATAAVAILABLE = 0x00011799U;
enum uint DISPID_EVMETH_ONDATAAVAILABLE = 0x0001000fU;
enum uint DISPID_EVPROP_ONDATASETCOMPLETE = 0x0001179aU;
enum uint DISPID_EVMETH_ONDATASETCOMPLETE = 0x00010010U;

enum : uint
{
    DISPID_EVPROP_ONFILTER      = 0x0001179bU,
    DISPID_EVMETH_ONFILTER      = 0x00010011U,
    DISPID_EVPROP_ONCHANGEFOCUS = 0x0001179cU,
}

enum uint DISPID_EVMETH_ONCHANGEFOCUS = 0x000003faU;
enum uint DISPID_EVPROP_ONCHANGEBLUR = 0x0001179dU;
enum uint DISPID_EVMETH_ONCHANGEBLUR = 0x000003fbU;
enum uint DISPID_EVPROP_ONLOSECAPTURE = 0x0001179eU;
enum uint DISPID_EVMETH_ONLOSECAPTURE = 0x00010012U;
enum uint DISPID_EVPROP_ONPROPERTYCHANGE = 0x0001179fU;
enum uint DISPID_EVMETH_ONPROPERTYCHANGE = 0x00010013U;
enum uint DISPID_EVPROP_ONPERSISTSAVE = 0x000117a0U;
enum uint DISPID_EVMETH_ONPERSISTSAVE = 0x000003fdU;

enum : uint
{
    DISPID_EVPROP_ONDRAG    = 0x000117a1U,
    DISPID_EVMETH_ONDRAG    = 0x00010014U,
    DISPID_EVPROP_ONDRAGEND = 0x000117a2U,
}

enum uint DISPID_EVMETH_ONDRAGEND = 0x00010015U;
enum uint DISPID_EVPROP_ONDRAGENTER = 0x000117a3U;
enum uint DISPID_EVMETH_ONDRAGENTER = 0x00010016U;
enum uint DISPID_EVPROP_ONDRAGOVER = 0x000117a4U;
enum uint DISPID_EVMETH_ONDRAGOVER = 0x00010017U;
enum uint DISPID_EVPROP_ONDRAGLEAVE = 0x000117a5U;
enum uint DISPID_EVMETH_ONDRAGLEAVE = 0x00010018U;

enum : uint
{
    DISPID_EVPROP_ONDROP      = 0x000117a6U,
    DISPID_EVMETH_ONDROP      = 0x00010019U,
    DISPID_EVPROP_ONCUT       = 0x000117a7U,
    DISPID_EVMETH_ONCUT       = 0x0001001aU,
    DISPID_EVPROP_ONCOPY      = 0x000117a8U,
    DISPID_EVMETH_ONCOPY      = 0x0001001bU,
    DISPID_EVPROP_ONPASTE     = 0x000117a9U,
    DISPID_EVMETH_ONPASTE     = 0x0001001cU,
    DISPID_EVPROP_ONBEFORECUT = 0x000117aaU,
}

enum uint DISPID_EVMETH_ONBEFORECUT = 0x0001001dU;
enum uint DISPID_EVPROP_ONBEFORECOPY = 0x000117abU;
enum uint DISPID_EVMETH_ONBEFORECOPY = 0x0001001eU;
enum uint DISPID_EVPROP_ONBEFOREPASTE = 0x000117acU;
enum uint DISPID_EVMETH_ONBEFOREPASTE = 0x0001001fU;
enum uint DISPID_EVPROP_ONPERSISTLOAD = 0x000117adU;
enum uint DISPID_EVMETH_ONPERSISTLOAD = 0x000003feU;
enum uint DISPID_EVPROP_ONROWSDELETE = 0x000117aeU;
enum uint DISPID_EVMETH_ONROWSDELETE = 0x00010020U;
enum uint DISPID_EVPROP_ONROWSINSERTED = 0x000117afU;
enum uint DISPID_EVMETH_ONROWSINSERTED = 0x00010021U;
enum uint DISPID_EVPROP_ONCELLCHANGE = 0x000117b0U;
enum uint DISPID_EVMETH_ONCELLCHANGE = 0x00010022U;
enum uint DISPID_EVPROP_ONCONTEXTMENU = 0x000117b1U;
enum uint DISPID_EVMETH_ONCONTEXTMENU = 0x000003ffU;
enum uint DISPID_EVPROP_ONBEFOREPRINT = 0x000117b2U;
enum uint DISPID_EVMETH_ONBEFOREPRINT = 0x00000400U;
enum uint DISPID_EVPROP_ONAFTERPRINT = 0x000117b3U;
enum uint DISPID_EVMETH_ONAFTERPRINT = 0x00000401U;

enum : uint
{
    DISPID_EVPROP_ONSTOP            = 0x000117b4U,
    DISPID_EVMETH_ONSTOP            = 0x00000402U,
    DISPID_EVPROP_ONBEFOREEDITFOCUS = 0x000117b5U,
}

enum uint DISPID_EVMETH_ONBEFOREEDITFOCUS = 0x00000403U;

enum : uint
{
    DISPID_EVPROP_ONATTACHEVENT = 0x000117b6U,
    DISPID_EVPROP_ONMOUSEHOVER  = 0x000117b7U,
}

enum uint DISPID_EVMETH_ONMOUSEHOVER = 0x00000404U;
enum uint DISPID_EVPROP_ONCONTENTREADY = 0x000117b8U;
enum uint DISPID_EVMETH_ONCONTENTREADY = 0x00000405U;
enum uint DISPID_EVPROP_ONLAYOUTCOMPLETE = 0x000117b9U;
enum uint DISPID_EVMETH_ONLAYOUTCOMPLETE = 0x00000406U;

enum : uint
{
    DISPID_EVPROP_ONPAGE           = 0x000117baU,
    DISPID_EVMETH_ONPAGE           = 0x00000407U,
    DISPID_EVPROP_ONLINKEDOVERFLOW = 0x000117bbU,
}

enum uint DISPID_EVMETH_ONLINKEDOVERFLOW = 0x00000408U;
enum uint DISPID_EVPROP_ONMOUSEWHEEL = 0x000117bcU;
enum uint DISPID_EVMETH_ONMOUSEWHEEL = 0x00000409U;
enum uint DISPID_EVPROP_ONBEFOREDEACTIVATE = 0x000117bdU;
enum uint DISPID_EVMETH_ONBEFOREDEACTIVATE = 0x0000040aU;

enum : uint
{
    DISPID_EVPROP_ONMOVE          = 0x000117beU,
    DISPID_EVMETH_ONMOVE          = 0x0000040bU,
    DISPID_EVPROP_ONCONTROLSELECT = 0x000117bfU,
}

enum uint DISPID_EVMETH_ONCONTROLSELECT = 0x0000040cU;
enum uint DISPID_EVPROP_ONSELECTIONCHANGE = 0x000117c0U;
enum uint DISPID_EVMETH_ONSELECTIONCHANGE = 0x0000040dU;
enum uint DISPID_EVPROP_ONMOVESTART = 0x000117c1U;
enum uint DISPID_EVMETH_ONMOVESTART = 0x0000040eU;
enum uint DISPID_EVPROP_ONMOVEEND = 0x000117c2U;
enum uint DISPID_EVMETH_ONMOVEEND = 0x0000040fU;
enum uint DISPID_EVPROP_ONRESIZESTART = 0x000117c3U;
enum uint DISPID_EVMETH_ONRESIZESTART = 0x00000410U;
enum uint DISPID_EVPROP_ONRESIZEEND = 0x000117c4U;
enum uint DISPID_EVMETH_ONRESIZEEND = 0x00000411U;
enum uint DISPID_EVPROP_ONMOUSEENTER = 0x000117c5U;
enum uint DISPID_EVMETH_ONMOUSEENTER = 0x00000412U;
enum uint DISPID_EVPROP_ONMOUSELEAVE = 0x000117c6U;
enum uint DISPID_EVMETH_ONMOUSELEAVE = 0x00000413U;
enum uint DISPID_EVPROP_ONACTIVATE = 0x000117c7U;
enum uint DISPID_EVMETH_ONACTIVATE = 0x00000414U;
enum uint DISPID_EVPROP_ONDEACTIVATE = 0x000117c8U;
enum uint DISPID_EVMETH_ONDEACTIVATE = 0x00000415U;
enum uint DISPID_EVPROP_ONMULTILAYOUTCLEANUP = 0x000117c9U;
enum uint DISPID_EVMETH_ONMULTILAYOUTCLEANUP = 0x00000416U;
enum uint DISPID_EVPROP_ONBEFOREACTIVATE = 0x000117caU;
enum uint DISPID_EVMETH_ONBEFOREACTIVATE = 0x00000417U;
enum uint DISPID_EVPROP_ONFOCUSIN = 0x000117cbU;
enum uint DISPID_EVMETH_ONFOCUSIN = 0x00000418U;
enum uint DISPID_EVPROP_ONFOCUSOUT = 0x000117ccU;
enum uint DISPID_EVMETH_ONFOCUSOUT = 0x00000419U;
enum uint DISPID_EVPROP_ONVALUECHANGE = 0x000117cdU;
enum uint DISPID_EVMETH_ONVALUECHANGE = 0x0000041aU;
enum uint DISPID_EVPROP_ONSELECTADD = 0x000117ceU;
enum uint DISPID_EVMETH_ONSELECTADD = 0x0000041bU;
enum uint DISPID_EVPROP_ONSELECTREMOVE = 0x000117cfU;
enum uint DISPID_EVMETH_ONSELECTREMOVE = 0x0000041cU;
enum uint DISPID_EVPROP_ONSELECTWITHIN = 0x000117d0U;
enum uint DISPID_EVMETH_ONSELECTWITHIN = 0x0000041dU;
enum uint DISPID_EVPROP_ONSYSTEMSCROLLINGSTART = 0x000117d1U;
enum uint DISPID_EVMETH_ONSYSTEMSCROLLINGSTART = 0x0000041eU;
enum uint DISPID_EVPROP_ONSYSTEMSCROLLINGEND = 0x000117d2U;
enum uint DISPID_EVMETH_ONSYSTEMSCROLLINGEND = 0x0000041fU;
enum uint DISPID_EVPROP_ONOBJECTCONTENTSCROLLED = 0x000117d3U;
enum uint DISPID_EVMETH_ONOBJECTCONTENTSCROLLED = 0x00000420U;
enum uint DISPID_EVPROP_ONSTORAGE = 0x000117d4U;
enum uint DISPID_EVMETH_ONSTORAGE = 0x00000421U;
enum uint DISPID_EVPROP_ONSTORAGECOMMIT = 0x000117d5U;
enum uint DISPID_EVMETH_ONSTORAGECOMMIT = 0x00000422U;

enum : uint
{
    DISPID_EVPROP_ONSHOW           = 0x000117d6U,
    DISPID_EVMETH_ONSHOW           = 0x00000423U,
    DISPID_EVPROP_ONHIDE           = 0x000117d7U,
    DISPID_EVMETH_ONHIDE           = 0x00000424U,
    DISPID_EVPROP_ONALERT          = 0x000117d8U,
    DISPID_EVMETH_ONALERT          = 0x00000425U,
    DISPID_EVPROP_ONPOPUPMENUSTART = 0x000117d9U,
}

enum uint DISPID_EVMETH_ONPOPUPMENUSTART = 0x00000426U;
enum uint DISPID_EVPROP_ONPOPUPMENUEND = 0x000117daU;
enum uint DISPID_EVMETH_ONPOPUPMENUEND = 0x00000427U;

enum : uint
{
    DISPID_EVPROP_ONONLINE  = 0x000117dbU,
    DISPID_EVMETH_ONONLINE  = 0x00000428U,
    DISPID_EVPROP_ONOFFLINE = 0x000117dcU,
}

enum uint DISPID_EVMETH_ONOFFLINE = 0x00000429U;
enum uint DISPID_EVPROP_ONHASHCHANGE = 0x000117ddU;
enum uint DISPID_EVMETH_ONHASHCHANGE = 0x0000042aU;
enum uint DISPID_EVPROP_ONMESSAGE = 0x000117deU;
enum uint DISPID_EVMETH_ONMESSAGE = 0x0000042bU;
enum uint DISPID_EVPROP_ONDOMMUTATION = 0x000117dfU;
enum uint DISPID_EVMETH_ONDOMMUTATION = 0x0000042cU;

enum : uint
{
    DISPID_EVPROP_SINKLIMIT                       = 0x000117dfU,
    DISPID_EVPROP_TIMEOUT                         = 0x000117e0U,
    DISPID_EVPROP_WHEEL                           = 0x000117e1U,
    DISPID_EVPROP_SVGLOAD                         = 0x000117e2U,
    DISPID_EVPROP_SVGUNLOAD                       = 0x000117e3U,
    DISPID_EVPROP_SVGABORT                        = 0x000117e4U,
    DISPID_EVPROP_SVGERROR                        = 0x000117e5U,
    DISPID_EVPROP_SVGRESIZE                       = 0x000117e6U,
    DISPID_EVPROP_SVGSCROLL                       = 0x000117e7U,
    DISPID_EVPROP_SVGZOOM                         = 0x000117e8U,
    DISPID_EVPROP_ONMSTHUMBNAILCLICK              = 0x000117e9U,
    DISPID_EVPROP_COMPOSITIONSTART                = 0x000117eaU,
    DISPID_EVPROP_COMPOSITIONUPDATE               = 0x000117ebU,
    DISPID_EVPROP_COMPOSITIONEND                  = 0x000117ecU,
    DISPID_EVPROP_DOMATTRMODIFIED                 = 0x000117edU,
    DISPID_EVPROP_DOMCONTENTLOADED                = 0x000117eeU,
    DISPID_EVPROP_INPUT                           = 0x000117efU,
    DISPID_EVPROP_DOMCHARDATAMODIFIED             = 0x000117f0U,
    DISPID_EVPROP_TEXTINPUT                       = 0x000117f1U,
    DISPID_EVPROP_ONMSSITEMODEJUMPLISTITEMREMOVED = 0x000117f2U,
}

enum : uint
{
    DISPID_EVPROP_DOMNODEINSERTED              = 0x000117f3U,
    DISPID_EVPROP_DOMNODEREMOVED               = 0x000117f4U,
    DISPID_EVPROP_DOMSUBTREEMODIFIED           = 0x000117f5U,
    DISPID_EVPROP_CANPLAY                      = 0x000117f6U,
    DISPID_EVPROP_CANPLAYTHROUGH               = 0x000117f7U,
    DISPID_EVPROP_DURATIONCHANGE               = 0x000117f8U,
    DISPID_EVPROP_EMPTIED                      = 0x000117f9U,
    DISPID_EVPROP_ENDED                        = 0x000117faU,
    DISPID_EVPROP_LOADEDDATA                   = 0x000117fbU,
    DISPID_EVPROP_LOADEDMETADATA               = 0x000117fcU,
    DISPID_EVPROP_LOADSTART                    = 0x000117fdU,
    DISPID_EVPROP_PAUSE                        = 0x000117feU,
    DISPID_EVPROP_PLAY                         = 0x000117ffU,
    DISPID_EVPROP_PLAYING                      = 0x00011800U,
    DISPID_EVPROP_PROGRESS                     = 0x00011801U,
    DISPID_EVPROP_RATECHANGE                   = 0x00011802U,
    DISPID_EVPROP_SEEKED                       = 0x00011803U,
    DISPID_EVPROP_SEEKING                      = 0x00011804U,
    DISPID_EVPROP_STALLED                      = 0x00011805U,
    DISPID_EVPROP_SUSPEND                      = 0x00011806U,
    DISPID_EVPROP_TIMEUPDATE                   = 0x00011807U,
    DISPID_EVPROP_VOLUMECHANGE                 = 0x00011808U,
    DISPID_EVPROP_WAITING                      = 0x00011809U,
    DISPID_EVPROP_ONMSPOINTERDOWN              = 0x0001180aU,
    DISPID_EVPROP_ONMSPOINTERMOVE              = 0x0001180bU,
    DISPID_EVPROP_ONMSPOINTERUP                = 0x0001180cU,
    DISPID_EVPROP_ONMSPOINTEROVER              = 0x0001180dU,
    DISPID_EVPROP_ONMSPOINTEROUT               = 0x0001180eU,
    DISPID_EVPROP_ONMSPOINTERCANCEL            = 0x0001180fU,
    DISPID_EVPROP_ONMSPOINTERHOVER             = 0x00011810U,
    DISPID_EVPROP_MSCONNECT                    = 0x00011811U,
    DISPID_EVPROP_MSDISCONNECT                 = 0x00011812U,
    DISPID_EVPROP_ONMSGESTURESTART             = 0x00011813U,
    DISPID_EVPROP_ONMSGESTURECHANGE            = 0x00011814U,
    DISPID_EVPROP_ONMSGESTUREEND               = 0x00011815U,
    DISPID_EVPROP_ONMSGESTUREHOLD              = 0x00011816U,
    DISPID_EVPROP_ONMSGESTURETAP               = 0x00011817U,
    DISPID_EVPROP_ONMSGESTUREDOUBLETAP         = 0x00011818U,
    DISPID_EVPROP_ONMSINERTIASTART             = 0x00011819U,
    DISPID_EVPROP_ONMSLOSTPOINTERCAPTURE       = 0x0001181aU,
    DISPID_EVPROP_ONMSGOTPOINTERCAPTURE        = 0x0001181bU,
    DISPID_EVPROP_ONMSCONTENTZOOM              = 0x0001181cU,
    DISPID_EVPROP_ONTRANSITIONSTART            = 0x0001181dU,
    DISPID_EVPROP_ONTRANSITIONEND              = 0x0001181eU,
    DISPID_EVPROP_ONANIMATIONSTART             = 0x0001181fU,
    DISPID_EVPROP_ONANIMATIONEND               = 0x00011820U,
    DISPID_EVPROP_ONANIMATIONITERATION         = 0x00011821U,
    DISPID_EVPROP_ONMSMANIPULATIONSTATECHANGED = 0x00011822U,
}

enum : uint
{
    DISPID_EVPROP_ONOPEN                 = 0x00011823U,
    DISPID_EVPROP_ONCLOSE                = 0x00011824U,
    DISPID_EVPROP_CHECKING               = 0x00011825U,
    DISPID_EVPROP_NOUPDATE               = 0x00011826U,
    DISPID_EVPROP_DOWNLOADING            = 0x00011827U,
    DISPID_EVPROP_UPDATEREADY            = 0x00011828U,
    DISPID_EVPROP_CACHED                 = 0x00011829U,
    DISPID_EVPROP_OBSOLETE               = 0x0001182aU,
    DISPID_EVPROP_LOADEND                = 0x0001182bU,
    DISPID_EVPROP_INVALID                = 0x0001182cU,
    DISPID_EVPROP_ONSUCCESS              = 0x0001182dU,
    DISPID_EVPROP_ONBLOCKED              = 0x0001182eU,
    DISPID_EVPROP_ONCOMPLETE             = 0x0001182fU,
    DISPID_EVPROP_ONPOPSTATE             = 0x00011830U,
    DISPID_EVPROP_ONCUECHANGE            = 0x00011831U,
    DISPID_EVPROP_ONENTER                = 0x00011832U,
    DISPID_EVPROP_ONEXIT                 = 0x00011833U,
    DISPID_EVPROP_VISIBILITYCHANGE       = 0x00011834U,
    DISPID_EVPROP_ONMSREGIONUPDATE       = 0x00011835U,
    DISPID_EVPROP_ONUPGRADENEEDED        = 0x00011836U,
    DISPID_EVPROP_ONMSVIDEOFORMATCHANGED = 0x00011837U,
}

enum : uint
{
    DISPID_EVPROP_ADDTRACK                                       = 0x00011838U,
    DISPID_EVPROP_ONMSVIDEOFRAMESTEPCOMPLETED                    = 0x00011839U,
    DISPID_EVPROP_ONMSHOLDVISUAL                                 = 0x0001183aU,
    DISPID_EVPROP_ONMSVIDEOOPTIMALLAYOUTCHANGED                  = 0x0001183bU,
    DISPID_EVPROP_ONMSFULLSCREENCHANGE                           = 0x0001183cU,
    DISPID_EVPROP_ONMSFULLSCREENERROR                            = 0x0001183dU,
    DISPID_EVPROP_MSELEMENTRESIZE                                = 0x0001183eU,
    DISPID_EVPROP_ONSOURCEOPEN                                   = 0x0001183fU,
    DISPID_EVPROP_ONSOURCECLOSE                                  = 0x00011840U,
    DISPID_EVPROP_ONSOURCEENDED                                  = 0x00011841U,
    DISPID_EVPROP_ONADDSOURCEBUFFER                              = 0x00011842U,
    DISPID_EVPROP_ONREMOVESOURCEBUFFER                           = 0x00011843U,
    DISPID_EVPROP_ONMSNEEDKEY                                    = 0x00011844U,
    DISPID_EVPROP_ONMSKEYMESSAGE                                 = 0x00011845U,
    DISPID_EVPROP_ONMSKEYERROR                                   = 0x00011846U,
    DISPID_EVPROP_ONMSKEYADDED                                   = 0x00011847U,
    DISPID_EVPROP_MSHTMLWEBVIEW_ONDOMCONTENTLOADED               = 0x00011848U,
    DISPID_EVPROP_MSHTMLWEBVIEW_ONCONTENTLOADING                 = 0x00011849U,
    DISPID_EVPROP_MSHTMLWEBVIEW_ONNAVIGATIONSTARTING             = 0x0001184aU,
    DISPID_EVPROP_MSHTMLWEBVIEW_ONNAVIGATIONCOMPLETED            = 0x0001184bU,
    DISPID_EVPROP_MSHTMLWEBVIEW_ONFRAMEDOMCONTENTLOADED          = 0x0001184cU,
    DISPID_EVPROP_MSHTMLWEBVIEW_ONFRAMECONTENTLOADING            = 0x0001184dU,
    DISPID_EVPROP_MSHTMLWEBVIEW_ONFRAMENAVIGATIONSTARTING        = 0x0001184eU,
    DISPID_EVPROP_MSHTMLWEBVIEW_ONFRAMENAVIGATIONCOMPLETED       = 0x0001184fU,
    DISPID_EVPROP_MSHTMLWEBVIEW_ONSCRIPTNOTIFY                   = 0x00011850U,
    DISPID_EVPROP_MSHTMLWEBVIEW_ONUNVIEWABLECONTENT              = 0x00011851U,
    DISPID_EVPROP_MSHTMLWEBVIEW_ONUNSAFECONTENTWARNINGDISPLAYING = 0x00011852U,
    DISPID_EVPROP_MSHTMLWEBVIEW_ONLONGRUNNINGSCRIPTDETECTED      = 0x00011853U,
}

enum : uint
{
    DISPID_EVPROP_WEBGLCONTEXTLOST          = 0x00011854U,
    DISPID_EVPROP_WEBGLCONTEXTRESTORED      = 0x00011855U,
    DISPID_EVPROP_ONUPDATESTART             = 0x00011856U,
    DISPID_EVPROP_ONUPDATE                  = 0x00011857U,
    DISPID_EVPROP_ONUPDATEEND               = 0x00011858U,
    DISPID_EVPROP_ONMSPOINTERENTER          = 0x00011859U,
    DISPID_EVPROP_ONMSPOINTERLEAVE          = 0x0001185aU,
    DISPID_EVPROP_ONMSSITEPINNED            = 0x0001185bU,
    DISPID_EVPROP_MSORIENTATIONCHANGE       = 0x0001185cU,
    DISPID_EVPROP_ONDEVICEORIENTATION       = 0x0001185dU,
    DISPID_EVPROP_ONDEVICEMOTION            = 0x0001185eU,
    DISPID_EVPROP_ONPAGESHOW                = 0x0001185fU,
    DISPID_EVPROP_ONPAGEHIDE                = 0x00011860U,
    DISPID_EVPROP_ONMSCANDIDATEWINDOWSHOW   = 0x00011861U,
    DISPID_EVPROP_ONMSCANDIDATEWINDOWUPDATE = 0x00011862U,
    DISPID_EVPROP_ONMSCANDIDATEWINDOWHIDE   = 0x00011863U,
}

enum uint DISPID_EVPROP_HTML5ONREADYSTATECHANGE = 0x00011864U;

enum : uint
{
    DISPID_EVPROP_REMOVETRACK               = 0x00011865U,
    DISPID_EVPROP_ONCOMPASSNEEDSCALIBRATION = 0x00011866U,
}

enum uint DISPID_EVPROP_MSHTMLWEBVIEW_ONCONTAINSFULLSCREENELEMENTCHANGED = 0x00011867U;

enum : uint
{
    DISPID_EVPROP_ONTOUCHSTART               = 0x00011868U,
    DISPID_EVPROP_ONTOUCHEND                 = 0x00011869U,
    DISPID_EVPROP_ONTOUCHMOVE                = 0x0001186aU,
    DISPID_EVPROP_ONTOUCHCANCEL              = 0x0001186bU,
    DISPID_EVPROP_ONWEBKITTRANSITIONEND      = 0x0001186cU,
    DISPID_EVPROP_ONWEBKITANIMATIONSTART     = 0x0001186dU,
    DISPID_EVPROP_ONWEBKITANIMATIONEND       = 0x0001186eU,
    DISPID_EVPROP_ONWEBKITANIMATIONITERATION = 0x0001186fU,
}

enum uint DISPID_EVPROP_WEBGLCONTEXTCREATIONERROR = 0x00011870U;

enum : uint
{
    DISPID_EVPROP_ONDOMFOCUSIN      = 0x00011871U,
    DISPID_EVPROP_ONDOMFOCUSOUT     = 0x00011872U,
    DISPID_EVPROP_ORIENTATIONCHANGE = 0x00011873U,
    DISPID_EVPROPS_COUNT            = 0x00000104U,
}

enum uint DISPID_IHTMLFILTERSCOLLECTION_LENGTH = 0x000003e9U;
enum int DISPID_IHTMLFILTERSCOLLECTION__NEWENUM = 0xfffffffc;
enum uint DISPID_IHTMLFILTERSCOLLECTION_ITEM = 0x00000000U;
enum uint DISPID_IHTMLDOMCONSTRUCTOR_CONSTRUCTOR = 0x000101fdU;

enum : uint
{
    DISPID_IHTMLCSSSTYLEDECLARATION_LENGTH              = 0x00011195U,
    DISPID_IHTMLCSSSTYLEDECLARATION_PARENTRULE          = 0x00011196U,
    DISPID_IHTMLCSSSTYLEDECLARATION_GETPROPERTYVALUE    = 0x00011197U,
    DISPID_IHTMLCSSSTYLEDECLARATION_GETPROPERTYPRIORITY = 0x00011198U,
    DISPID_IHTMLCSSSTYLEDECLARATION_REMOVEPROPERTY      = 0x00011199U,
    DISPID_IHTMLCSSSTYLEDECLARATION_SETPROPERTY         = 0x0001119aU,
    DISPID_IHTMLCSSSTYLEDECLARATION_ITEM                = 0x00000000U,
    DISPID_IHTMLCSSSTYLEDECLARATION_FONTFAMILY          = 0x0001139aU,
    DISPID_IHTMLCSSSTYLEDECLARATION_FONTSTYLE           = 0x000113a0U,
    DISPID_IHTMLCSSSTYLEDECLARATION_FONTVARIANT         = 0x000113a1U,
    DISPID_IHTMLCSSSTYLEDECLARATION_FONTWEIGHT          = 0x000113a3U,
    DISPID_IHTMLCSSSTYLEDECLARATION_FONTSIZE            = 0x0001139bU,
    DISPID_IHTMLCSSSTYLEDECLARATION_FONT                = 0x000113b1U,
    DISPID_IHTMLCSSSTYLEDECLARATION_COLOR               = 0x0001138aU,
    DISPID_IHTMLCSSSTYLEDECLARATION_BACKGROUND          = 0x000113a8U,
}

enum int DISPID_IHTMLCSSSTYLEDECLARATION_BACKGROUNDCOLOR = 0xfffffe0b;

enum : uint
{
    DISPID_IHTMLCSSSTYLEDECLARATION_BACKGROUNDIMAGE                 = 0x00011389U,
    DISPID_IHTMLCSSSTYLEDECLARATION_BACKGROUNDREPEAT                = 0x000113b4U,
    DISPID_IHTMLCSSSTYLEDECLARATION_BACKGROUNDATTACHMENT            = 0x000113b5U,
    DISPID_IHTMLCSSSTYLEDECLARATION_BACKGROUNDPOSITION              = 0x000113b6U,
    DISPID_IHTMLCSSSTYLEDECLARATION_BACKGROUNDPOSITIONX             = 0x000113a9U,
    DISPID_IHTMLCSSSTYLEDECLARATION_BACKGROUNDPOSITIONY             = 0x000113aaU,
    DISPID_IHTMLCSSSTYLEDECLARATION_WORDSPACING                     = 0x000113b7U,
    DISPID_IHTMLCSSSTYLEDECLARATION_LETTERSPACING                   = 0x00011390U,
    DISPID_IHTMLCSSSTYLEDECLARATION_TEXTDECORATION                  = 0x000113abU,
    DISPID_IHTMLCSSSTYLEDECLARATION_VERTICALALIGN                   = 0x000113b8U,
    DISPID_IHTMLCSSSTYLEDECLARATION_TEXTTRANSFORM                   = 0x0001138cU,
    DISPID_IHTMLCSSSTYLEDECLARATION_TEXTALIGN                       = 0x00010048U,
    DISPID_IHTMLCSSSTYLEDECLARATION_TEXTINDENT                      = 0x0001138fU,
    DISPID_IHTMLCSSSTYLEDECLARATION_LINEHEIGHT                      = 0x0001138eU,
    DISPID_IHTMLCSSSTYLEDECLARATION_MARGINTOP                       = 0x000113adU,
    DISPID_IHTMLCSSSTYLEDECLARATION_MARGINRIGHT                     = 0x000113aeU,
    DISPID_IHTMLCSSSTYLEDECLARATION_MARGINBOTTOM                    = 0x000113afU,
    DISPID_IHTMLCSSSTYLEDECLARATION_MARGINLEFT                      = 0x000113b0U,
    DISPID_IHTMLCSSSTYLEDECLARATION_MARGIN                          = 0x000113acU,
    DISPID_IHTMLCSSSTYLEDECLARATION_PADDINGTOP                      = 0x00011394U,
    DISPID_IHTMLCSSSTYLEDECLARATION_PADDINGRIGHT                    = 0x00011395U,
    DISPID_IHTMLCSSSTYLEDECLARATION_PADDINGBOTTOM                   = 0x00011396U,
    DISPID_IHTMLCSSSTYLEDECLARATION_PADDINGLEFT                     = 0x00011397U,
    DISPID_IHTMLCSSSTYLEDECLARATION_PADDING                         = 0x00011393U,
    DISPID_IHTMLCSSSTYLEDECLARATION_BORDER                          = 0x000113b9U,
    DISPID_IHTMLCSSSTYLEDECLARATION_BORDERTOP                       = 0x000113baU,
    DISPID_IHTMLCSSSTYLEDECLARATION_BORDERRIGHT                     = 0x000113bbU,
    DISPID_IHTMLCSSSTYLEDECLARATION_BORDERBOTTOM                    = 0x000113bcU,
    DISPID_IHTMLCSSSTYLEDECLARATION_BORDERLEFT                      = 0x000113bdU,
    DISPID_IHTMLCSSSTYLEDECLARATION_BORDERCOLOR                     = 0x000113beU,
    DISPID_IHTMLCSSSTYLEDECLARATION_BORDERTOPCOLOR                  = 0x000113bfU,
    DISPID_IHTMLCSSSTYLEDECLARATION_BORDERRIGHTCOLOR                = 0x000113c0U,
    DISPID_IHTMLCSSSTYLEDECLARATION_BORDERBOTTOMCOLOR               = 0x000113c1U,
    DISPID_IHTMLCSSSTYLEDECLARATION_BORDERLEFTCOLOR                 = 0x000113c2U,
    DISPID_IHTMLCSSSTYLEDECLARATION_BORDERWIDTH                     = 0x000113c3U,
    DISPID_IHTMLCSSSTYLEDECLARATION_BORDERTOPWIDTH                  = 0x000113c4U,
    DISPID_IHTMLCSSSTYLEDECLARATION_BORDERRIGHTWIDTH                = 0x000113c5U,
    DISPID_IHTMLCSSSTYLEDECLARATION_BORDERBOTTOMWIDTH               = 0x000113c6U,
    DISPID_IHTMLCSSSTYLEDECLARATION_BORDERLEFTWIDTH                 = 0x000113c7U,
    DISPID_IHTMLCSSSTYLEDECLARATION_BORDERSTYLE                     = 0x000113c8U,
    DISPID_IHTMLCSSSTYLEDECLARATION_BORDERTOPSTYLE                  = 0x000113c9U,
    DISPID_IHTMLCSSSTYLEDECLARATION_BORDERRIGHTSTYLE                = 0x000113caU,
    DISPID_IHTMLCSSSTYLEDECLARATION_BORDERBOTTOMSTYLE               = 0x000113cbU,
    DISPID_IHTMLCSSSTYLEDECLARATION_BORDERLEFTSTYLE                 = 0x000113ccU,
    DISPID_IHTMLCSSSTYLEDECLARATION_WIDTH                           = 0x00010005U,
    DISPID_IHTMLCSSSTYLEDECLARATION_HEIGHT                          = 0x00010006U,
    DISPID_IHTMLCSSSTYLEDECLARATION_STYLEFLOAT                      = 0x000113ceU,
    DISPID_IHTMLCSSSTYLEDECLARATION_CLEAR                           = 0x00011398U,
    DISPID_IHTMLCSSSTYLEDECLARATION_DISPLAY                         = 0x000113cfU,
    DISPID_IHTMLCSSSTYLEDECLARATION_VISIBILITY                      = 0x000113d8U,
    DISPID_IHTMLCSSSTYLEDECLARATION_LISTSTYLETYPE                   = 0x000113d0U,
    DISPID_IHTMLCSSSTYLEDECLARATION_LISTSTYLEPOSITION               = 0x000113d1U,
    DISPID_IHTMLCSSSTYLEDECLARATION_LISTSTYLEIMAGE                  = 0x000113d2U,
    DISPID_IHTMLCSSSTYLEDECLARATION_LISTSTYLE                       = 0x000113d3U,
    DISPID_IHTMLCSSSTYLEDECLARATION_WHITESPACE                      = 0x000113d4U,
    DISPID_IHTMLCSSSTYLEDECLARATION_TOP                             = 0x00010004U,
    DISPID_IHTMLCSSSTYLEDECLARATION_LEFT                            = 0x00010003U,
    DISPID_IHTMLCSSSTYLEDECLARATION_ZINDEX                          = 0x000113e3U,
    DISPID_IHTMLCSSSTYLEDECLARATION_OVERFLOW                        = 0x00011392U,
    DISPID_IHTMLCSSSTYLEDECLARATION_PAGEBREAKBEFORE                 = 0x000113d5U,
    DISPID_IHTMLCSSSTYLEDECLARATION_PAGEBREAKAFTER                  = 0x000113d6U,
    DISPID_IHTMLCSSSTYLEDECLARATION_CSSTEXT                         = 0x000113ebU,
    DISPID_IHTMLCSSSTYLEDECLARATION_CURSOR                          = 0x000113eeU,
    DISPID_IHTMLCSSSTYLEDECLARATION_CLIP                            = 0x000113e4U,
    DISPID_IHTMLCSSSTYLEDECLARATION_FILTER                          = 0x000113daU,
    DISPID_IHTMLCSSSTYLEDECLARATION_TABLELAYOUT                     = 0x000113eaU,
    DISPID_IHTMLCSSSTYLEDECLARATION_BORDERCOLLAPSE                  = 0x000113dcU,
    DISPID_IHTMLCSSSTYLEDECLARATION_DIRECTION                       = 0x000113ffU,
    DISPID_IHTMLCSSSTYLEDECLARATION_BEHAVIOR                        = 0x000113fbU,
    DISPID_IHTMLCSSSTYLEDECLARATION_POSITION                        = 0x000113e2U,
    DISPID_IHTMLCSSSTYLEDECLARATION_UNICODEBIDI                     = 0x000113feU,
    DISPID_IHTMLCSSSTYLEDECLARATION_BOTTOM                          = 0x0001004eU,
    DISPID_IHTMLCSSSTYLEDECLARATION_RIGHT                           = 0x0001004dU,
    DISPID_IHTMLCSSSTYLEDECLARATION_IMEMODE                         = 0x00011400U,
    DISPID_IHTMLCSSSTYLEDECLARATION_RUBYALIGN                       = 0x00011401U,
    DISPID_IHTMLCSSSTYLEDECLARATION_RUBYPOSITION                    = 0x00011402U,
    DISPID_IHTMLCSSSTYLEDECLARATION_RUBYOVERHANG                    = 0x00011403U,
    DISPID_IHTMLCSSSTYLEDECLARATION_LAYOUTGRIDCHAR                  = 0x00011407U,
    DISPID_IHTMLCSSSTYLEDECLARATION_LAYOUTGRIDLINE                  = 0x00011408U,
    DISPID_IHTMLCSSSTYLEDECLARATION_LAYOUTGRIDMODE                  = 0x00011409U,
    DISPID_IHTMLCSSSTYLEDECLARATION_LAYOUTGRIDTYPE                  = 0x0001140aU,
    DISPID_IHTMLCSSSTYLEDECLARATION_LAYOUTGRID                      = 0x0001140bU,
    DISPID_IHTMLCSSSTYLEDECLARATION_TEXTAUTOSPACE                   = 0x0001140cU,
    DISPID_IHTMLCSSSTYLEDECLARATION_WORDBREAK                       = 0x0001140eU,
    DISPID_IHTMLCSSSTYLEDECLARATION_LINEBREAK                       = 0x0001140dU,
    DISPID_IHTMLCSSSTYLEDECLARATION_TEXTJUSTIFY                     = 0x0001140fU,
    DISPID_IHTMLCSSSTYLEDECLARATION_TEXTJUSTIFYTRIM                 = 0x00011410U,
    DISPID_IHTMLCSSSTYLEDECLARATION_TEXTKASHIDA                     = 0x00011411U,
    DISPID_IHTMLCSSSTYLEDECLARATION_OVERFLOWX                       = 0x00011413U,
    DISPID_IHTMLCSSSTYLEDECLARATION_OVERFLOWY                       = 0x00011414U,
    DISPID_IHTMLCSSSTYLEDECLARATION_ACCELERATOR                     = 0x0001141bU,
    DISPID_IHTMLCSSSTYLEDECLARATION_LAYOUTFLOW                      = 0x00011423U,
    DISPID_IHTMLCSSSTYLEDECLARATION_ZOOM                            = 0x00011421U,
    DISPID_IHTMLCSSSTYLEDECLARATION_WORDWRAP                        = 0x00011426U,
    DISPID_IHTMLCSSSTYLEDECLARATION_TEXTUNDERLINEPOSITION           = 0x00011427U,
    DISPID_IHTMLCSSSTYLEDECLARATION_SCROLLBARBASECOLOR              = 0x0001143cU,
    DISPID_IHTMLCSSSTYLEDECLARATION_SCROLLBARFACECOLOR              = 0x0001143dU,
    DISPID_IHTMLCSSSTYLEDECLARATION_SCROLLBAR3DLIGHTCOLOR           = 0x0001143eU,
    DISPID_IHTMLCSSSTYLEDECLARATION_SCROLLBARSHADOWCOLOR            = 0x0001143fU,
    DISPID_IHTMLCSSSTYLEDECLARATION_SCROLLBARHIGHLIGHTCOLOR         = 0x00011440U,
    DISPID_IHTMLCSSSTYLEDECLARATION_SCROLLBARDARKSHADOWCOLOR        = 0x00011441U,
    DISPID_IHTMLCSSSTYLEDECLARATION_SCROLLBARARROWCOLOR             = 0x00011442U,
    DISPID_IHTMLCSSSTYLEDECLARATION_SCROLLBARTRACKCOLOR             = 0x0001144cU,
    DISPID_IHTMLCSSSTYLEDECLARATION_WRITINGMODE                     = 0x00011448U,
    DISPID_IHTMLCSSSTYLEDECLARATION_TEXTALIGNLAST                   = 0x00011453U,
    DISPID_IHTMLCSSSTYLEDECLARATION_TEXTKASHIDASPACE                = 0x00011454U,
    DISPID_IHTMLCSSSTYLEDECLARATION_TEXTOVERFLOW                    = 0x00011459U,
    DISPID_IHTMLCSSSTYLEDECLARATION_MINHEIGHT                       = 0x0001145bU,
    DISPID_IHTMLCSSSTYLEDECLARATION_MSINTERPOLATIONMODE             = 0x0001145dU,
    DISPID_IHTMLCSSSTYLEDECLARATION_MAXHEIGHT                       = 0x0001145eU,
    DISPID_IHTMLCSSSTYLEDECLARATION_MINWIDTH                        = 0x0001145fU,
    DISPID_IHTMLCSSSTYLEDECLARATION_MAXWIDTH                        = 0x00011460U,
    DISPID_IHTMLCSSSTYLEDECLARATION_CONTENT                         = 0x00011462U,
    DISPID_IHTMLCSSSTYLEDECLARATION_CAPTIONSIDE                     = 0x00011463U,
    DISPID_IHTMLCSSSTYLEDECLARATION_COUNTERINCREMENT                = 0x00011464U,
    DISPID_IHTMLCSSSTYLEDECLARATION_COUNTERRESET                    = 0x00011465U,
    DISPID_IHTMLCSSSTYLEDECLARATION_OUTLINE                         = 0x00011466U,
    DISPID_IHTMLCSSSTYLEDECLARATION_OUTLINEWIDTH                    = 0x00011467U,
    DISPID_IHTMLCSSSTYLEDECLARATION_OUTLINESTYLE                    = 0x00011468U,
    DISPID_IHTMLCSSSTYLEDECLARATION_OUTLINECOLOR                    = 0x00011469U,
    DISPID_IHTMLCSSSTYLEDECLARATION_BOXSIZING                       = 0x0001146aU,
    DISPID_IHTMLCSSSTYLEDECLARATION_BORDERSPACING                   = 0x0001146bU,
    DISPID_IHTMLCSSSTYLEDECLARATION_ORPHANS                         = 0x0001146cU,
    DISPID_IHTMLCSSSTYLEDECLARATION_WIDOWS                          = 0x0001146dU,
    DISPID_IHTMLCSSSTYLEDECLARATION_PAGEBREAKINSIDE                 = 0x0001146eU,
    DISPID_IHTMLCSSSTYLEDECLARATION_EMPTYCELLS                      = 0x00011482U,
    DISPID_IHTMLCSSSTYLEDECLARATION_MSBLOCKPROGRESSION              = 0x00011483U,
    DISPID_IHTMLCSSSTYLEDECLARATION_QUOTES                          = 0x00011484U,
    DISPID_IHTMLCSSSTYLEDECLARATION_ALIGNMENTBASELINE               = 0x0001149eU,
    DISPID_IHTMLCSSSTYLEDECLARATION_BASELINESHIFT                   = 0x0001149fU,
    DISPID_IHTMLCSSSTYLEDECLARATION_DOMINANTBASELINE                = 0x000114a0U,
    DISPID_IHTMLCSSSTYLEDECLARATION_FONTSIZEADJUST                  = 0x000114a1U,
    DISPID_IHTMLCSSSTYLEDECLARATION_FONTSTRETCH                     = 0x000114a2U,
    DISPID_IHTMLCSSSTYLEDECLARATION_OPACITY                         = 0x000114a3U,
    DISPID_IHTMLCSSSTYLEDECLARATION_CLIPPATH                        = 0x000114a4U,
    DISPID_IHTMLCSSSTYLEDECLARATION_CLIPRULE                        = 0x000114a5U,
    DISPID_IHTMLCSSSTYLEDECLARATION_FILL                            = 0x000114a6U,
    DISPID_IHTMLCSSSTYLEDECLARATION_FILLOPACITY                     = 0x000114a7U,
    DISPID_IHTMLCSSSTYLEDECLARATION_FILLRULE                        = 0x000114a8U,
    DISPID_IHTMLCSSSTYLEDECLARATION_KERNING                         = 0x000114a9U,
    DISPID_IHTMLCSSSTYLEDECLARATION_MARKER                          = 0x000114aaU,
    DISPID_IHTMLCSSSTYLEDECLARATION_MARKEREND                       = 0x000114abU,
    DISPID_IHTMLCSSSTYLEDECLARATION_MARKERMID                       = 0x000114acU,
    DISPID_IHTMLCSSSTYLEDECLARATION_MARKERSTART                     = 0x000114adU,
    DISPID_IHTMLCSSSTYLEDECLARATION_MASK                            = 0x000114aeU,
    DISPID_IHTMLCSSSTYLEDECLARATION_POINTEREVENTS                   = 0x000114afU,
    DISPID_IHTMLCSSSTYLEDECLARATION_STOPCOLOR                       = 0x000114b0U,
    DISPID_IHTMLCSSSTYLEDECLARATION_STOPOPACITY                     = 0x000114b1U,
    DISPID_IHTMLCSSSTYLEDECLARATION_STROKE                          = 0x000114b2U,
    DISPID_IHTMLCSSSTYLEDECLARATION_STROKEDASHARRAY                 = 0x000114b3U,
    DISPID_IHTMLCSSSTYLEDECLARATION_STROKEDASHOFFSET                = 0x000114b4U,
    DISPID_IHTMLCSSSTYLEDECLARATION_STROKELINECAP                   = 0x000114b5U,
    DISPID_IHTMLCSSSTYLEDECLARATION_STROKELINEJOIN                  = 0x000114b6U,
    DISPID_IHTMLCSSSTYLEDECLARATION_STROKEMITERLIMIT                = 0x000114b7U,
    DISPID_IHTMLCSSSTYLEDECLARATION_STROKEOPACITY                   = 0x000114b8U,
    DISPID_IHTMLCSSSTYLEDECLARATION_STROKEWIDTH                     = 0x000114b9U,
    DISPID_IHTMLCSSSTYLEDECLARATION_TEXTANCHOR                      = 0x000114baU,
    DISPID_IHTMLCSSSTYLEDECLARATION_GLYPHORIENTATIONHORIZONTAL      = 0x000114bbU,
    DISPID_IHTMLCSSSTYLEDECLARATION_GLYPHORIENTATIONVERTICAL        = 0x000114bcU,
    DISPID_IHTMLCSSSTYLEDECLARATION_BORDERRADIUS                    = 0x000114beU,
    DISPID_IHTMLCSSSTYLEDECLARATION_BORDERTOPLEFTRADIUS             = 0x000114bfU,
    DISPID_IHTMLCSSSTYLEDECLARATION_BORDERTOPRIGHTRADIUS            = 0x000114c0U,
    DISPID_IHTMLCSSSTYLEDECLARATION_BORDERBOTTOMRIGHTRADIUS         = 0x000114c1U,
    DISPID_IHTMLCSSSTYLEDECLARATION_BORDERBOTTOMLEFTRADIUS          = 0x000114c2U,
    DISPID_IHTMLCSSSTYLEDECLARATION_CLIPTOP                         = 0x000113e5U,
    DISPID_IHTMLCSSSTYLEDECLARATION_CLIPRIGHT                       = 0x000113e6U,
    DISPID_IHTMLCSSSTYLEDECLARATION_CLIPBOTTOM                      = 0x000113e7U,
    DISPID_IHTMLCSSSTYLEDECLARATION_CLIPLEFT                        = 0x000113e8U,
    DISPID_IHTMLCSSSTYLEDECLARATION_CSSFLOAT                        = 0x000114bdU,
    DISPID_IHTMLCSSSTYLEDECLARATION_BACKGROUNDCLIP                  = 0x000114c4U,
    DISPID_IHTMLCSSSTYLEDECLARATION_BACKGROUNDORIGIN                = 0x000114c5U,
    DISPID_IHTMLCSSSTYLEDECLARATION_BACKGROUNDSIZE                  = 0x000114c6U,
    DISPID_IHTMLCSSSTYLEDECLARATION_BOXSHADOW                       = 0x000114c7U,
    DISPID_IHTMLCSSSTYLEDECLARATION_MSTRANSFORM                     = 0x000114c3U,
    DISPID_IHTMLCSSSTYLEDECLARATION_MSTRANSFORMORIGIN               = 0x000114cdU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSSCROLLCHAINING               = 0x000114ebU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSCONTENTZOOMING               = 0x000114ecU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSCONTENTZOOMSNAPTYPE          = 0x000114edU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSSCROLLRAILS                  = 0x000114eeU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSCONTENTZOOMCHAINING          = 0x000114efU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSSCROLLSNAPTYPE               = 0x000114f0U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSCONTENTZOOMLIMIT             = 0x000114f1U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSCONTENTZOOMSNAP              = 0x000114f2U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSCONTENTZOOMSNAPPOINTS        = 0x000114f3U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSCONTENTZOOMLIMITMIN          = 0x000114f5U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSCONTENTZOOMLIMITMAX          = 0x000114f6U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSSCROLLSNAPX                  = 0x000114f7U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSSCROLLSNAPY                  = 0x000114f8U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSSCROLLSNAPPOINTSX            = 0x000114f9U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSSCROLLSNAPPOINTSY            = 0x000114faU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSGRIDCOLUMN                   = 0x000114fcU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSGRIDCOLUMNALIGN              = 0x000114fdU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSGRIDCOLUMNS                  = 0x000114feU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSGRIDCOLUMNSPAN               = 0x000114ffU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSGRIDROW                      = 0x00011501U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSGRIDROWALIGN                 = 0x00011502U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSGRIDROWS                     = 0x00011503U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSGRIDROWSPAN                  = 0x00011504U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSWRAPTHROUGH                  = 0x00011519U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSWRAPMARGIN                   = 0x00011523U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSWRAPFLOW                     = 0x00011525U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSANIMATIONNAME                = 0x00011505U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSANIMATIONDURATION            = 0x00011506U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSANIMATIONTIMINGFUNCTION      = 0x00011507U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSANIMATIONDELAY               = 0x00011508U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSANIMATIONDIRECTION           = 0x00011509U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSANIMATIONPLAYSTATE           = 0x0001150aU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSANIMATIONITERATIONCOUNT      = 0x0001150bU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSANIMATION                    = 0x0001150cU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSANIMATIONFILLMODE            = 0x0001150dU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_COLORINTERPOLATIONFILTERS      = 0x00011510U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_COLUMNCOUNT                    = 0x000114d8U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_COLUMNWIDTH                    = 0x000114d9U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_COLUMNGAP                      = 0x000114daU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_COLUMNFILL                     = 0x000114dbU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_COLUMNSPAN                     = 0x000114dcU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_COLUMNS                        = 0x000114d7U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_COLUMNRULE                     = 0x000114ddU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_COLUMNRULECOLOR                = 0x000114e0U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_COLUMNRULESTYLE                = 0x000114deU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_COLUMNRULEWIDTH                = 0x000114dfU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_BREAKBEFORE                    = 0x000114e1U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_BREAKAFTER                     = 0x000114e2U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_BREAKINSIDE                    = 0x000114e3U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_FLOODCOLOR                     = 0x0001150eU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_FLOODOPACITY                   = 0x0001150fU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_LIGHTINGCOLOR                  = 0x00011511U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSSCROLLLIMITXMIN              = 0x00011512U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSSCROLLLIMITYMIN              = 0x00011513U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSSCROLLLIMITXMAX              = 0x00011514U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSSCROLLLIMITYMAX              = 0x00011515U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSSCROLLLIMIT                  = 0x00011516U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_TEXTSHADOW                     = 0x00011518U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSFLOWFROM                     = 0x0001151aU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSFLOWINTO                     = 0x0001151bU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSHYPHENS                      = 0x0001151cU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSHYPHENATELIMITZONE           = 0x0001151dU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSHYPHENATELIMITCHARS          = 0x0001151eU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSHYPHENATELIMITLINES          = 0x0001151fU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSHIGHCONTRASTADJUST           = 0x00011521U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_ENABLEBACKGROUND               = 0x00011522U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSFONTFEATURESETTINGS          = 0x00011526U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSUSERSELECT                   = 0x00011527U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSOVERFLOWSTYLE                = 0x00011517U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSTRANSFORMSTYLE               = 0x000114e9U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSBACKFACEVISIBILITY           = 0x000114eaU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSPERSPECTIVE                  = 0x000114e5U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSPERSPECTIVEORIGIN            = 0x000114e6U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSTRANSITIONPROPERTY           = 0x000114d2U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSTRANSITIONDURATION           = 0x000114d3U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSTRANSITIONTIMINGFUNCTION     = 0x000114d4U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSTRANSITIONDELAY              = 0x000114d5U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSTRANSITION                   = 0x000114d6U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSTOUCHACTION                  = 0x00011528U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSSCROLLTRANSLATION            = 0x0001152aU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSFLEX                         = 0x0001152bU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSFLEXPOSITIVE                 = 0x0001152cU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSFLEXNEGATIVE                 = 0x0001152dU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSFLEXPREFERREDSIZE            = 0x0001152eU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSFLEXFLOW                     = 0x0001152fU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSFLEXDIRECTION                = 0x00011530U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSFLEXWRAP                     = 0x00011531U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSFLEXALIGN                    = 0x00011532U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSFLEXITEMALIGN                = 0x00011533U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSFLEXPACK                     = 0x00011534U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSFLEXLINEPACK                 = 0x00011535U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSFLEXORDER                    = 0x00011536U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_MSTOUCHSELECT                  = 0x00011552U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_TRANSFORM                      = 0x00011537U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_TRANSFORMORIGIN                = 0x00011538U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_TRANSFORMSTYLE                 = 0x00011540U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_BACKFACEVISIBILITY             = 0x00011541U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_PERSPECTIVE                    = 0x0001153eU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_PERSPECTIVEORIGIN              = 0x0001153fU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_TRANSITIONPROPERTY             = 0x00011539U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_TRANSITIONDURATION             = 0x0001153aU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_TRANSITIONTIMINGFUNCTION       = 0x0001153bU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_TRANSITIONDELAY                = 0x0001153cU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_TRANSITION                     = 0x0001153dU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_FONTFEATURESETTINGS            = 0x0001154bU,
    DISPID_IHTMLCSSSTYLEDECLARATION2_ANIMATIONNAME                  = 0x00011542U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_ANIMATIONDURATION              = 0x00011543U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_ANIMATIONTIMINGFUNCTION        = 0x00011544U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_ANIMATIONDELAY                 = 0x00011545U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_ANIMATIONDIRECTION             = 0x00011546U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_ANIMATIONPLAYSTATE             = 0x00011547U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_ANIMATIONITERATIONCOUNT        = 0x00011548U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_ANIMATION                      = 0x00011549U,
    DISPID_IHTMLCSSSTYLEDECLARATION2_ANIMATIONFILLMODE              = 0x0001154aU,
    DISPID_IHTMLCSSSTYLEDECLARATION3_FLEX                           = 0x0001155aU,
    DISPID_IHTMLCSSSTYLEDECLARATION3_FLEXDIRECTION                  = 0x00011556U,
    DISPID_IHTMLCSSSTYLEDECLARATION3_FLEXWRAP                       = 0x00011557U,
    DISPID_IHTMLCSSSTYLEDECLARATION3_FLEXFLOW                       = 0x00011558U,
    DISPID_IHTMLCSSSTYLEDECLARATION3_FLEXGROW                       = 0x0001155bU,
    DISPID_IHTMLCSSSTYLEDECLARATION3_FLEXSHRINK                     = 0x0001155cU,
    DISPID_IHTMLCSSSTYLEDECLARATION3_FLEXBASIS                      = 0x0001155dU,
    DISPID_IHTMLCSSSTYLEDECLARATION3_JUSTIFYCONTENT                 = 0x0001155eU,
    DISPID_IHTMLCSSSTYLEDECLARATION3_ALIGNITEMS                     = 0x0001155fU,
    DISPID_IHTMLCSSSTYLEDECLARATION3_ALIGNSELF                      = 0x00011560U,
    DISPID_IHTMLCSSSTYLEDECLARATION3_ALIGNCONTENT                   = 0x00011561U,
    DISPID_IHTMLCSSSTYLEDECLARATION3_BORDERIMAGE                    = 0x00011562U,
    DISPID_IHTMLCSSSTYLEDECLARATION3_BORDERIMAGESOURCE              = 0x00011563U,
    DISPID_IHTMLCSSSTYLEDECLARATION3_BORDERIMAGESLICE               = 0x00011564U,
    DISPID_IHTMLCSSSTYLEDECLARATION3_BORDERIMAGEWIDTH               = 0x00011565U,
    DISPID_IHTMLCSSSTYLEDECLARATION3_BORDERIMAGEOUTSET              = 0x00011566U,
    DISPID_IHTMLCSSSTYLEDECLARATION3_BORDERIMAGEREPEAT              = 0x00011567U,
    DISPID_IHTMLCSSSTYLEDECLARATION3_MSIMEALIGN                     = 0x00011569U,
    DISPID_IHTMLCSSSTYLEDECLARATION3_MSTEXTCOMBINEHORIZONTAL        = 0x0001156aU,
    DISPID_IHTMLCSSSTYLEDECLARATION3_TOUCHACTION                    = 0x0001156bU,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITAPPEARANCE               = 0x0001156cU,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITUSERSELECT               = 0x00011578U,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITBOXALIGN                 = 0x0001156dU,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITBOXORDINALGROUP          = 0x0001156eU,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITBOXPACK                  = 0x0001156fU,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITBOXFLEX                  = 0x00011570U,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITBOXORIENT                = 0x00011571U,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITBOXDIRECTION             = 0x00011572U,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITTRANSFORM                = 0x00011574U,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITBACKGROUNDSIZE           = 0x00011575U,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITBACKFACEVISIBILITY       = 0x00011576U,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITANIMATION                = 0x00011579U,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITTRANSITION               = 0x0001157aU,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITANIMATIONNAME            = 0x0001157bU,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITANIMATIONDURATION        = 0x0001157cU,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITANIMATIONTIMINGFUNCTION  = 0x0001157dU,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITANIMATIONDELAY           = 0x0001157eU,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITANIMATIONITERATIONCOUNT  = 0x0001157fU,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITANIMATIONDIRECTION       = 0x00011580U,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITANIMATIONPLAYSTATE       = 0x00011581U,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITTRANSITIONPROPERTY       = 0x00011582U,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITTRANSITIONDURATION       = 0x00011583U,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITTRANSITIONTIMINGFUNCTION = 0x00011584U,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITTRANSITIONDELAY          = 0x00011585U,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITBACKGROUNDATTACHMENT     = 0x00011586U,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITBACKGROUNDCOLOR          = 0x00011587U,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITBACKGROUNDCLIP           = 0x00011588U,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITBACKGROUNDIMAGE          = 0x00011589U,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITBACKGROUNDREPEAT         = 0x0001158aU,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITBACKGROUNDORIGIN         = 0x0001158bU,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITBACKGROUNDPOSITION       = 0x0001158cU,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITBACKGROUNDPOSITIONX      = 0x0001158dU,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITBACKGROUNDPOSITIONY      = 0x0001158eU,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITBACKGROUND               = 0x0001158fU,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITTRANSFORMORIGIN          = 0x00011590U,
    DISPID_IHTMLCSSSTYLEDECLARATION4_MSTEXTSIZEADJUST               = 0x000114d0U,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITTEXTSIZEADJUST           = 0x00011594U,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITBORDERIMAGE              = 0x00011595U,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITBORDERIMAGESOURCE        = 0x00011596U,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITBORDERIMAGESLICE         = 0x00011597U,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITBORDERIMAGEWIDTH         = 0x00011598U,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITBORDERIMAGEOUTSET        = 0x00011599U,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITBORDERIMAGEREPEAT        = 0x0001159aU,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITBOXSIZING                = 0x00011577U,
    DISPID_IHTMLCSSSTYLEDECLARATION4_WEBKITANIMATIONFILLMODE        = 0x00011573U,
}

enum : uint
{
    DISPID_IHTMLSTYLEENABLED_MSGETPROPERTYENABLED = 0x0001119bU,
    DISPID_IHTMLSTYLEENABLED_MSPUTPROPERTYENABLED = 0x0001119cU,
}

enum : uint
{
    DISPID_IHTMLSTYLE_FONTFAMILY  = 0x0001139aU,
    DISPID_IHTMLSTYLE_FONTSTYLE   = 0x000113a0U,
    DISPID_IHTMLSTYLE_FONTVARIANT = 0x000113a1U,
    DISPID_IHTMLSTYLE_FONTWEIGHT  = 0x000113a3U,
    DISPID_IHTMLSTYLE_FONTSIZE    = 0x0001139bU,
    DISPID_IHTMLSTYLE_FONT        = 0x000113b1U,
    DISPID_IHTMLSTYLE_COLOR       = 0x0001138aU,
    DISPID_IHTMLSTYLE_BACKGROUND  = 0x000113a8U,
}

enum int DISPID_IHTMLSTYLE_BACKGROUNDCOLOR = 0xfffffe0b;

enum : uint
{
    DISPID_IHTMLSTYLE_BACKGROUNDIMAGE           = 0x00011389U,
    DISPID_IHTMLSTYLE_BACKGROUNDREPEAT          = 0x000113b4U,
    DISPID_IHTMLSTYLE_BACKGROUNDATTACHMENT      = 0x000113b5U,
    DISPID_IHTMLSTYLE_BACKGROUNDPOSITION        = 0x000113b6U,
    DISPID_IHTMLSTYLE_BACKGROUNDPOSITIONX       = 0x000113a9U,
    DISPID_IHTMLSTYLE_BACKGROUNDPOSITIONY       = 0x000113aaU,
    DISPID_IHTMLSTYLE_WORDSPACING               = 0x000113b7U,
    DISPID_IHTMLSTYLE_LETTERSPACING             = 0x00011390U,
    DISPID_IHTMLSTYLE_TEXTDECORATION            = 0x000113abU,
    DISPID_IHTMLSTYLE_TEXTDECORATIONNONE        = 0x0001139fU,
    DISPID_IHTMLSTYLE_TEXTDECORATIONUNDERLINE   = 0x0001139dU,
    DISPID_IHTMLSTYLE_TEXTDECORATIONOVERLINE    = 0x000113cdU,
    DISPID_IHTMLSTYLE_TEXTDECORATIONLINETHROUGH = 0x0001139cU,
    DISPID_IHTMLSTYLE_TEXTDECORATIONBLINK       = 0x0001139eU,
    DISPID_IHTMLSTYLE_VERTICALALIGN             = 0x000113b8U,
    DISPID_IHTMLSTYLE_TEXTTRANSFORM             = 0x0001138cU,
    DISPID_IHTMLSTYLE_TEXTALIGN                 = 0x00010048U,
    DISPID_IHTMLSTYLE_TEXTINDENT                = 0x0001138fU,
    DISPID_IHTMLSTYLE_LINEHEIGHT                = 0x0001138eU,
    DISPID_IHTMLSTYLE_MARGINTOP                 = 0x000113adU,
    DISPID_IHTMLSTYLE_MARGINRIGHT               = 0x000113aeU,
    DISPID_IHTMLSTYLE_MARGINBOTTOM              = 0x000113afU,
    DISPID_IHTMLSTYLE_MARGINLEFT                = 0x000113b0U,
    DISPID_IHTMLSTYLE_MARGIN                    = 0x000113acU,
    DISPID_IHTMLSTYLE_PADDINGTOP                = 0x00011394U,
    DISPID_IHTMLSTYLE_PADDINGRIGHT              = 0x00011395U,
    DISPID_IHTMLSTYLE_PADDINGBOTTOM             = 0x00011396U,
    DISPID_IHTMLSTYLE_PADDINGLEFT               = 0x00011397U,
    DISPID_IHTMLSTYLE_PADDING                   = 0x00011393U,
    DISPID_IHTMLSTYLE_BORDER                    = 0x000113b9U,
    DISPID_IHTMLSTYLE_BORDERTOP                 = 0x000113baU,
    DISPID_IHTMLSTYLE_BORDERRIGHT               = 0x000113bbU,
    DISPID_IHTMLSTYLE_BORDERBOTTOM              = 0x000113bcU,
    DISPID_IHTMLSTYLE_BORDERLEFT                = 0x000113bdU,
    DISPID_IHTMLSTYLE_BORDERCOLOR               = 0x000113beU,
    DISPID_IHTMLSTYLE_BORDERTOPCOLOR            = 0x000113bfU,
    DISPID_IHTMLSTYLE_BORDERRIGHTCOLOR          = 0x000113c0U,
    DISPID_IHTMLSTYLE_BORDERBOTTOMCOLOR         = 0x000113c1U,
    DISPID_IHTMLSTYLE_BORDERLEFTCOLOR           = 0x000113c2U,
    DISPID_IHTMLSTYLE_BORDERWIDTH               = 0x000113c3U,
    DISPID_IHTMLSTYLE_BORDERTOPWIDTH            = 0x000113c4U,
    DISPID_IHTMLSTYLE_BORDERRIGHTWIDTH          = 0x000113c5U,
    DISPID_IHTMLSTYLE_BORDERBOTTOMWIDTH         = 0x000113c6U,
    DISPID_IHTMLSTYLE_BORDERLEFTWIDTH           = 0x000113c7U,
    DISPID_IHTMLSTYLE_BORDERSTYLE               = 0x000113c8U,
    DISPID_IHTMLSTYLE_BORDERTOPSTYLE            = 0x000113c9U,
    DISPID_IHTMLSTYLE_BORDERRIGHTSTYLE          = 0x000113caU,
    DISPID_IHTMLSTYLE_BORDERBOTTOMSTYLE         = 0x000113cbU,
    DISPID_IHTMLSTYLE_BORDERLEFTSTYLE           = 0x000113ccU,
    DISPID_IHTMLSTYLE_WIDTH                     = 0x00010005U,
    DISPID_IHTMLSTYLE_HEIGHT                    = 0x00010006U,
    DISPID_IHTMLSTYLE_STYLEFLOAT                = 0x000113ceU,
    DISPID_IHTMLSTYLE_CLEAR                     = 0x00011398U,
    DISPID_IHTMLSTYLE_DISPLAY                   = 0x000113cfU,
    DISPID_IHTMLSTYLE_VISIBILITY                = 0x000113d8U,
    DISPID_IHTMLSTYLE_LISTSTYLETYPE             = 0x000113d0U,
    DISPID_IHTMLSTYLE_LISTSTYLEPOSITION         = 0x000113d1U,
    DISPID_IHTMLSTYLE_LISTSTYLEIMAGE            = 0x000113d2U,
    DISPID_IHTMLSTYLE_LISTSTYLE                 = 0x000113d3U,
    DISPID_IHTMLSTYLE_WHITESPACE                = 0x000113d4U,
    DISPID_IHTMLSTYLE_TOP                       = 0x00010004U,
    DISPID_IHTMLSTYLE_LEFT                      = 0x00010003U,
    DISPID_IHTMLSTYLE_POSITION                  = 0x000113e2U,
    DISPID_IHTMLSTYLE_ZINDEX                    = 0x000113e3U,
    DISPID_IHTMLSTYLE_OVERFLOW                  = 0x00011392U,
    DISPID_IHTMLSTYLE_PAGEBREAKBEFORE           = 0x000113d5U,
    DISPID_IHTMLSTYLE_PAGEBREAKAFTER            = 0x000113d6U,
    DISPID_IHTMLSTYLE_CSSTEXT                   = 0x000113ebU,
    DISPID_IHTMLSTYLE_PIXELTOP                  = 0x00010fa0U,
    DISPID_IHTMLSTYLE_PIXELLEFT                 = 0x00010fa1U,
    DISPID_IHTMLSTYLE_PIXELWIDTH                = 0x00010fa2U,
    DISPID_IHTMLSTYLE_PIXELHEIGHT               = 0x00010fa3U,
    DISPID_IHTMLSTYLE_POSTOP                    = 0x00010fa4U,
    DISPID_IHTMLSTYLE_POSLEFT                   = 0x00010fa5U,
    DISPID_IHTMLSTYLE_POSWIDTH                  = 0x00010fa6U,
    DISPID_IHTMLSTYLE_POSHEIGHT                 = 0x00010fa7U,
    DISPID_IHTMLSTYLE_CURSOR                    = 0x000113eeU,
    DISPID_IHTMLSTYLE_CLIP                      = 0x000113e4U,
    DISPID_IHTMLSTYLE_FILTER                    = 0x000113daU,
    DISPID_IHTMLSTYLE_SETATTRIBUTE              = 0x000101f5U,
    DISPID_IHTMLSTYLE_GETATTRIBUTE              = 0x000101f6U,
    DISPID_IHTMLSTYLE_REMOVEATTRIBUTE           = 0x000101f7U,
    DISPID_IHTMLSTYLE_TOSTRING                  = 0x00010fa8U,
    DISPID_IHTMLSTYLE2_TABLELAYOUT              = 0x000113eaU,
    DISPID_IHTMLSTYLE2_BORDERCOLLAPSE           = 0x000113dcU,
    DISPID_IHTMLSTYLE2_DIRECTION                = 0x000113ffU,
    DISPID_IHTMLSTYLE2_BEHAVIOR                 = 0x000113fbU,
    DISPID_IHTMLSTYLE2_SETEXPRESSION            = 0x000101f8U,
    DISPID_IHTMLSTYLE2_GETEXPRESSION            = 0x000101f9U,
    DISPID_IHTMLSTYLE2_REMOVEEXPRESSION         = 0x000101faU,
    DISPID_IHTMLSTYLE2_POSITION                 = 0x000113e2U,
    DISPID_IHTMLSTYLE2_UNICODEBIDI              = 0x000113feU,
    DISPID_IHTMLSTYLE2_BOTTOM                   = 0x0001004eU,
    DISPID_IHTMLSTYLE2_RIGHT                    = 0x0001004dU,
    DISPID_IHTMLSTYLE2_PIXELBOTTOM              = 0x00010fa9U,
    DISPID_IHTMLSTYLE2_PIXELRIGHT               = 0x00010faaU,
    DISPID_IHTMLSTYLE2_POSBOTTOM                = 0x00010fabU,
    DISPID_IHTMLSTYLE2_POSRIGHT                 = 0x00010facU,
    DISPID_IHTMLSTYLE2_IMEMODE                  = 0x00011400U,
    DISPID_IHTMLSTYLE2_RUBYALIGN                = 0x00011401U,
    DISPID_IHTMLSTYLE2_RUBYPOSITION             = 0x00011402U,
    DISPID_IHTMLSTYLE2_RUBYOVERHANG             = 0x00011403U,
    DISPID_IHTMLSTYLE2_LAYOUTGRIDCHAR           = 0x00011407U,
    DISPID_IHTMLSTYLE2_LAYOUTGRIDLINE           = 0x00011408U,
    DISPID_IHTMLSTYLE2_LAYOUTGRIDMODE           = 0x00011409U,
    DISPID_IHTMLSTYLE2_LAYOUTGRIDTYPE           = 0x0001140aU,
    DISPID_IHTMLSTYLE2_LAYOUTGRID               = 0x0001140bU,
    DISPID_IHTMLSTYLE2_WORDBREAK                = 0x0001140eU,
    DISPID_IHTMLSTYLE2_LINEBREAK                = 0x0001140dU,
    DISPID_IHTMLSTYLE2_TEXTJUSTIFY              = 0x0001140fU,
    DISPID_IHTMLSTYLE2_TEXTJUSTIFYTRIM          = 0x00011410U,
    DISPID_IHTMLSTYLE2_TEXTKASHIDA              = 0x00011411U,
    DISPID_IHTMLSTYLE2_TEXTAUTOSPACE            = 0x0001140cU,
    DISPID_IHTMLSTYLE2_OVERFLOWX                = 0x00011413U,
    DISPID_IHTMLSTYLE2_OVERFLOWY                = 0x00011414U,
    DISPID_IHTMLSTYLE2_ACCELERATOR              = 0x0001141bU,
    DISPID_IHTMLSTYLE3_LAYOUTFLOW               = 0x00011423U,
    DISPID_IHTMLSTYLE3_ZOOM                     = 0x00011421U,
    DISPID_IHTMLSTYLE3_WORDWRAP                 = 0x00011426U,
    DISPID_IHTMLSTYLE3_TEXTUNDERLINEPOSITION    = 0x00011427U,
    DISPID_IHTMLSTYLE3_SCROLLBARBASECOLOR       = 0x0001143cU,
    DISPID_IHTMLSTYLE3_SCROLLBARFACECOLOR       = 0x0001143dU,
    DISPID_IHTMLSTYLE3_SCROLLBAR3DLIGHTCOLOR    = 0x0001143eU,
    DISPID_IHTMLSTYLE3_SCROLLBARSHADOWCOLOR     = 0x0001143fU,
    DISPID_IHTMLSTYLE3_SCROLLBARHIGHLIGHTCOLOR  = 0x00011440U,
    DISPID_IHTMLSTYLE3_SCROLLBARDARKSHADOWCOLOR = 0x00011441U,
    DISPID_IHTMLSTYLE3_SCROLLBARARROWCOLOR      = 0x00011442U,
    DISPID_IHTMLSTYLE3_SCROLLBARTRACKCOLOR      = 0x0001144cU,
    DISPID_IHTMLSTYLE3_WRITINGMODE              = 0x00011448U,
    DISPID_IHTMLSTYLE3_TEXTALIGNLAST            = 0x00011453U,
    DISPID_IHTMLSTYLE3_TEXTKASHIDASPACE         = 0x00011454U,
    DISPID_IHTMLSTYLE4_TEXTOVERFLOW             = 0x00011459U,
    DISPID_IHTMLSTYLE4_MINHEIGHT                = 0x0001145bU,
    DISPID_IHTMLSTYLE5_MSINTERPOLATIONMODE      = 0x0001145dU,
    DISPID_IHTMLSTYLE5_MAXHEIGHT                = 0x0001145eU,
    DISPID_IHTMLSTYLE5_MINWIDTH                 = 0x0001145fU,
    DISPID_IHTMLSTYLE5_MAXWIDTH                 = 0x00011460U,
    DISPID_IHTMLSTYLE6_CONTENT                  = 0x00011462U,
    DISPID_IHTMLSTYLE6_CAPTIONSIDE              = 0x00011463U,
    DISPID_IHTMLSTYLE6_COUNTERINCREMENT         = 0x00011464U,
    DISPID_IHTMLSTYLE6_COUNTERRESET             = 0x00011465U,
    DISPID_IHTMLSTYLE6_OUTLINE                  = 0x00011466U,
    DISPID_IHTMLSTYLE6_OUTLINEWIDTH             = 0x00011467U,
    DISPID_IHTMLSTYLE6_OUTLINESTYLE             = 0x00011468U,
    DISPID_IHTMLSTYLE6_OUTLINECOLOR             = 0x00011469U,
    DISPID_IHTMLSTYLE6_BOXSIZING                = 0x0001146aU,
    DISPID_IHTMLSTYLE6_BORDERSPACING            = 0x0001146bU,
    DISPID_IHTMLSTYLE6_ORPHANS                  = 0x0001146cU,
    DISPID_IHTMLSTYLE6_WIDOWS                   = 0x0001146dU,
    DISPID_IHTMLSTYLE6_PAGEBREAKINSIDE          = 0x0001146eU,
    DISPID_IHTMLSTYLE6_EMPTYCELLS               = 0x00011482U,
    DISPID_IHTMLSTYLE6_MSBLOCKPROGRESSION       = 0x00011483U,
    DISPID_IHTMLSTYLE6_QUOTES                   = 0x00011484U,
    DISPID_IHTMLRULESTYLE_FONTFAMILY            = 0x0001139aU,
    DISPID_IHTMLRULESTYLE_FONTSTYLE             = 0x000113a0U,
    DISPID_IHTMLRULESTYLE_FONTVARIANT           = 0x000113a1U,
    DISPID_IHTMLRULESTYLE_FONTWEIGHT            = 0x000113a3U,
    DISPID_IHTMLRULESTYLE_FONTSIZE              = 0x0001139bU,
    DISPID_IHTMLRULESTYLE_FONT                  = 0x000113b1U,
    DISPID_IHTMLRULESTYLE_COLOR                 = 0x0001138aU,
    DISPID_IHTMLRULESTYLE_BACKGROUND            = 0x000113a8U,
}

enum int DISPID_IHTMLRULESTYLE_BACKGROUNDCOLOR = 0xfffffe0b;

enum : uint
{
    DISPID_IHTMLRULESTYLE_BACKGROUNDIMAGE           = 0x00011389U,
    DISPID_IHTMLRULESTYLE_BACKGROUNDREPEAT          = 0x000113b4U,
    DISPID_IHTMLRULESTYLE_BACKGROUNDATTACHMENT      = 0x000113b5U,
    DISPID_IHTMLRULESTYLE_BACKGROUNDPOSITION        = 0x000113b6U,
    DISPID_IHTMLRULESTYLE_BACKGROUNDPOSITIONX       = 0x000113a9U,
    DISPID_IHTMLRULESTYLE_BACKGROUNDPOSITIONY       = 0x000113aaU,
    DISPID_IHTMLRULESTYLE_WORDSPACING               = 0x000113b7U,
    DISPID_IHTMLRULESTYLE_LETTERSPACING             = 0x00011390U,
    DISPID_IHTMLRULESTYLE_TEXTDECORATION            = 0x000113abU,
    DISPID_IHTMLRULESTYLE_TEXTDECORATIONNONE        = 0x0001139fU,
    DISPID_IHTMLRULESTYLE_TEXTDECORATIONUNDERLINE   = 0x0001139dU,
    DISPID_IHTMLRULESTYLE_TEXTDECORATIONOVERLINE    = 0x000113cdU,
    DISPID_IHTMLRULESTYLE_TEXTDECORATIONLINETHROUGH = 0x0001139cU,
    DISPID_IHTMLRULESTYLE_TEXTDECORATIONBLINK       = 0x0001139eU,
    DISPID_IHTMLRULESTYLE_VERTICALALIGN             = 0x000113b8U,
    DISPID_IHTMLRULESTYLE_TEXTTRANSFORM             = 0x0001138cU,
    DISPID_IHTMLRULESTYLE_TEXTALIGN                 = 0x00010048U,
    DISPID_IHTMLRULESTYLE_TEXTINDENT                = 0x0001138fU,
    DISPID_IHTMLRULESTYLE_LINEHEIGHT                = 0x0001138eU,
    DISPID_IHTMLRULESTYLE_MARGINTOP                 = 0x000113adU,
    DISPID_IHTMLRULESTYLE_MARGINRIGHT               = 0x000113aeU,
    DISPID_IHTMLRULESTYLE_MARGINBOTTOM              = 0x000113afU,
    DISPID_IHTMLRULESTYLE_MARGINLEFT                = 0x000113b0U,
    DISPID_IHTMLRULESTYLE_MARGIN                    = 0x000113acU,
    DISPID_IHTMLRULESTYLE_PADDINGTOP                = 0x00011394U,
    DISPID_IHTMLRULESTYLE_PADDINGRIGHT              = 0x00011395U,
    DISPID_IHTMLRULESTYLE_PADDINGBOTTOM             = 0x00011396U,
    DISPID_IHTMLRULESTYLE_PADDINGLEFT               = 0x00011397U,
    DISPID_IHTMLRULESTYLE_PADDING                   = 0x00011393U,
    DISPID_IHTMLRULESTYLE_BORDER                    = 0x000113b9U,
    DISPID_IHTMLRULESTYLE_BORDERTOP                 = 0x000113baU,
    DISPID_IHTMLRULESTYLE_BORDERRIGHT               = 0x000113bbU,
    DISPID_IHTMLRULESTYLE_BORDERBOTTOM              = 0x000113bcU,
    DISPID_IHTMLRULESTYLE_BORDERLEFT                = 0x000113bdU,
    DISPID_IHTMLRULESTYLE_BORDERCOLOR               = 0x000113beU,
    DISPID_IHTMLRULESTYLE_BORDERTOPCOLOR            = 0x000113bfU,
    DISPID_IHTMLRULESTYLE_BORDERRIGHTCOLOR          = 0x000113c0U,
    DISPID_IHTMLRULESTYLE_BORDERBOTTOMCOLOR         = 0x000113c1U,
    DISPID_IHTMLRULESTYLE_BORDERLEFTCOLOR           = 0x000113c2U,
    DISPID_IHTMLRULESTYLE_BORDERWIDTH               = 0x000113c3U,
    DISPID_IHTMLRULESTYLE_BORDERTOPWIDTH            = 0x000113c4U,
    DISPID_IHTMLRULESTYLE_BORDERRIGHTWIDTH          = 0x000113c5U,
    DISPID_IHTMLRULESTYLE_BORDERBOTTOMWIDTH         = 0x000113c6U,
    DISPID_IHTMLRULESTYLE_BORDERLEFTWIDTH           = 0x000113c7U,
    DISPID_IHTMLRULESTYLE_BORDERSTYLE               = 0x000113c8U,
    DISPID_IHTMLRULESTYLE_BORDERTOPSTYLE            = 0x000113c9U,
    DISPID_IHTMLRULESTYLE_BORDERRIGHTSTYLE          = 0x000113caU,
    DISPID_IHTMLRULESTYLE_BORDERBOTTOMSTYLE         = 0x000113cbU,
    DISPID_IHTMLRULESTYLE_BORDERLEFTSTYLE           = 0x000113ccU,
    DISPID_IHTMLRULESTYLE_WIDTH                     = 0x00010005U,
    DISPID_IHTMLRULESTYLE_HEIGHT                    = 0x00010006U,
    DISPID_IHTMLRULESTYLE_STYLEFLOAT                = 0x000113ceU,
    DISPID_IHTMLRULESTYLE_CLEAR                     = 0x00011398U,
    DISPID_IHTMLRULESTYLE_DISPLAY                   = 0x000113cfU,
    DISPID_IHTMLRULESTYLE_VISIBILITY                = 0x000113d8U,
    DISPID_IHTMLRULESTYLE_LISTSTYLETYPE             = 0x000113d0U,
    DISPID_IHTMLRULESTYLE_LISTSTYLEPOSITION         = 0x000113d1U,
    DISPID_IHTMLRULESTYLE_LISTSTYLEIMAGE            = 0x000113d2U,
    DISPID_IHTMLRULESTYLE_LISTSTYLE                 = 0x000113d3U,
    DISPID_IHTMLRULESTYLE_WHITESPACE                = 0x000113d4U,
    DISPID_IHTMLRULESTYLE_TOP                       = 0x00010004U,
    DISPID_IHTMLRULESTYLE_LEFT                      = 0x00010003U,
    DISPID_IHTMLRULESTYLE_POSITION                  = 0x000113e2U,
    DISPID_IHTMLRULESTYLE_ZINDEX                    = 0x000113e3U,
    DISPID_IHTMLRULESTYLE_OVERFLOW                  = 0x00011392U,
    DISPID_IHTMLRULESTYLE_PAGEBREAKBEFORE           = 0x000113d5U,
    DISPID_IHTMLRULESTYLE_PAGEBREAKAFTER            = 0x000113d6U,
    DISPID_IHTMLRULESTYLE_CSSTEXT                   = 0x000113ebU,
    DISPID_IHTMLRULESTYLE_CURSOR                    = 0x000113eeU,
    DISPID_IHTMLRULESTYLE_CLIP                      = 0x000113e4U,
    DISPID_IHTMLRULESTYLE_FILTER                    = 0x000113daU,
    DISPID_IHTMLRULESTYLE_SETATTRIBUTE              = 0x000101f5U,
    DISPID_IHTMLRULESTYLE_GETATTRIBUTE              = 0x000101f6U,
    DISPID_IHTMLRULESTYLE_REMOVEATTRIBUTE           = 0x000101f7U,
    DISPID_IHTMLRULESTYLE2_TABLELAYOUT              = 0x000113eaU,
    DISPID_IHTMLRULESTYLE2_BORDERCOLLAPSE           = 0x000113dcU,
    DISPID_IHTMLRULESTYLE2_DIRECTION                = 0x000113ffU,
    DISPID_IHTMLRULESTYLE2_BEHAVIOR                 = 0x000113fbU,
    DISPID_IHTMLRULESTYLE2_POSITION                 = 0x000113e2U,
    DISPID_IHTMLRULESTYLE2_UNICODEBIDI              = 0x000113feU,
    DISPID_IHTMLRULESTYLE2_BOTTOM                   = 0x0001004eU,
    DISPID_IHTMLRULESTYLE2_RIGHT                    = 0x0001004dU,
    DISPID_IHTMLRULESTYLE2_PIXELBOTTOM              = 0x00010fa9U,
    DISPID_IHTMLRULESTYLE2_PIXELRIGHT               = 0x00010faaU,
    DISPID_IHTMLRULESTYLE2_POSBOTTOM                = 0x00010fabU,
    DISPID_IHTMLRULESTYLE2_POSRIGHT                 = 0x00010facU,
    DISPID_IHTMLRULESTYLE2_IMEMODE                  = 0x00011400U,
    DISPID_IHTMLRULESTYLE2_RUBYALIGN                = 0x00011401U,
    DISPID_IHTMLRULESTYLE2_RUBYPOSITION             = 0x00011402U,
    DISPID_IHTMLRULESTYLE2_RUBYOVERHANG             = 0x00011403U,
    DISPID_IHTMLRULESTYLE2_LAYOUTGRIDCHAR           = 0x00011407U,
    DISPID_IHTMLRULESTYLE2_LAYOUTGRIDLINE           = 0x00011408U,
    DISPID_IHTMLRULESTYLE2_LAYOUTGRIDMODE           = 0x00011409U,
    DISPID_IHTMLRULESTYLE2_LAYOUTGRIDTYPE           = 0x0001140aU,
    DISPID_IHTMLRULESTYLE2_LAYOUTGRID               = 0x0001140bU,
    DISPID_IHTMLRULESTYLE2_TEXTAUTOSPACE            = 0x0001140cU,
    DISPID_IHTMLRULESTYLE2_WORDBREAK                = 0x0001140eU,
    DISPID_IHTMLRULESTYLE2_LINEBREAK                = 0x0001140dU,
    DISPID_IHTMLRULESTYLE2_TEXTJUSTIFY              = 0x0001140fU,
    DISPID_IHTMLRULESTYLE2_TEXTJUSTIFYTRIM          = 0x00011410U,
    DISPID_IHTMLRULESTYLE2_TEXTKASHIDA              = 0x00011411U,
    DISPID_IHTMLRULESTYLE2_OVERFLOWX                = 0x00011413U,
    DISPID_IHTMLRULESTYLE2_OVERFLOWY                = 0x00011414U,
    DISPID_IHTMLRULESTYLE2_ACCELERATOR              = 0x0001141bU,
    DISPID_IHTMLRULESTYLE3_LAYOUTFLOW               = 0x00011423U,
    DISPID_IHTMLRULESTYLE3_ZOOM                     = 0x00011421U,
    DISPID_IHTMLRULESTYLE3_WORDWRAP                 = 0x00011426U,
    DISPID_IHTMLRULESTYLE3_TEXTUNDERLINEPOSITION    = 0x00011427U,
    DISPID_IHTMLRULESTYLE3_SCROLLBARBASECOLOR       = 0x0001143cU,
    DISPID_IHTMLRULESTYLE3_SCROLLBARFACECOLOR       = 0x0001143dU,
    DISPID_IHTMLRULESTYLE3_SCROLLBAR3DLIGHTCOLOR    = 0x0001143eU,
    DISPID_IHTMLRULESTYLE3_SCROLLBARSHADOWCOLOR     = 0x0001143fU,
    DISPID_IHTMLRULESTYLE3_SCROLLBARHIGHLIGHTCOLOR  = 0x00011440U,
    DISPID_IHTMLRULESTYLE3_SCROLLBARDARKSHADOWCOLOR = 0x00011441U,
    DISPID_IHTMLRULESTYLE3_SCROLLBARARROWCOLOR      = 0x00011442U,
    DISPID_IHTMLRULESTYLE3_SCROLLBARTRACKCOLOR      = 0x0001144cU,
    DISPID_IHTMLRULESTYLE3_WRITINGMODE              = 0x00011448U,
    DISPID_IHTMLRULESTYLE3_TEXTALIGNLAST            = 0x00011453U,
    DISPID_IHTMLRULESTYLE3_TEXTKASHIDASPACE         = 0x00011454U,
    DISPID_IHTMLRULESTYLE4_TEXTOVERFLOW             = 0x00011459U,
    DISPID_IHTMLRULESTYLE4_MINHEIGHT                = 0x0001145bU,
    DISPID_IHTMLRULESTYLE5_MSINTERPOLATIONMODE      = 0x0001145dU,
    DISPID_IHTMLRULESTYLE5_MAXHEIGHT                = 0x0001145eU,
    DISPID_IHTMLRULESTYLE5_MINWIDTH                 = 0x0001145fU,
    DISPID_IHTMLRULESTYLE5_MAXWIDTH                 = 0x00011460U,
    DISPID_IHTMLRULESTYLE6_CONTENT                  = 0x00011462U,
    DISPID_IHTMLRULESTYLE6_CAPTIONSIDE              = 0x00011463U,
    DISPID_IHTMLRULESTYLE6_COUNTERINCREMENT         = 0x00011464U,
    DISPID_IHTMLRULESTYLE6_COUNTERRESET             = 0x00011465U,
    DISPID_IHTMLRULESTYLE6_OUTLINE                  = 0x00011466U,
    DISPID_IHTMLRULESTYLE6_OUTLINEWIDTH             = 0x00011467U,
    DISPID_IHTMLRULESTYLE6_OUTLINESTYLE             = 0x00011468U,
    DISPID_IHTMLRULESTYLE6_OUTLINECOLOR             = 0x00011469U,
    DISPID_IHTMLRULESTYLE6_BOXSIZING                = 0x0001146aU,
    DISPID_IHTMLRULESTYLE6_BORDERSPACING            = 0x0001146bU,
    DISPID_IHTMLRULESTYLE6_ORPHANS                  = 0x0001146cU,
    DISPID_IHTMLRULESTYLE6_WIDOWS                   = 0x0001146dU,
    DISPID_IHTMLRULESTYLE6_PAGEBREAKINSIDE          = 0x0001146eU,
    DISPID_IHTMLRULESTYLE6_EMPTYCELLS               = 0x00011482U,
    DISPID_IHTMLRULESTYLE6_MSBLOCKPROGRESSION       = 0x00011483U,
    DISPID_IHTMLRULESTYLE6_QUOTES                   = 0x00011484U,
    DISPID_IHTMLCSSRULE_TYPE                        = 0x0000044dU,
    DISPID_IHTMLCSSRULE_CSSTEXT                     = 0x0000044eU,
    DISPID_IHTMLCSSRULE_PARENTRULE                  = 0x0000044fU,
    DISPID_IHTMLCSSRULE_PARENTSTYLESHEET            = 0x00000450U,
    DISPID_IHTMLCSSIMPORTRULE_HREF                  = 0x000003e9U,
    DISPID_IHTMLCSSIMPORTRULE_MEDIA                 = 0x000003eaU,
    DISPID_IHTMLCSSIMPORTRULE_STYLESHEET            = 0x000003ebU,
    DISPID_IHTMLCSSMEDIARULE_MEDIA                  = 0x000003e9U,
    DISPID_IHTMLCSSMEDIARULE_CSSRULES               = 0x000003eaU,
    DISPID_IHTMLCSSMEDIARULE_INSERTRULE             = 0x000003ebU,
    DISPID_IHTMLCSSMEDIARULE_DELETERULE             = 0x000003ecU,
    DISPID_IHTMLCSSMEDIALIST_MEDIATEXT              = 0x000003e9U,
    DISPID_IHTMLCSSMEDIALIST_LENGTH                 = 0x000003eaU,
    DISPID_IHTMLCSSMEDIALIST_ITEM                   = 0x000003ebU,
    DISPID_IHTMLCSSMEDIALIST_APPENDMEDIUM           = 0x000003ecU,
    DISPID_IHTMLCSSMEDIALIST_DELETEMEDIUM           = 0x000003edU,
    DISPID_IHTMLCSSNAMESPACERULE_NAMESPACEURI       = 0x000003e9U,
    DISPID_IHTMLCSSNAMESPACERULE_PREFIX             = 0x000003eaU,
}

enum : uint
{
    DISPID_IHTMLMSCSSKEYFRAMERULE_KEYTEXT     = 0x000003e9U,
    DISPID_IHTMLMSCSSKEYFRAMERULE_STYLE       = 0x000003eaU,
    DISPID_IHTMLMSCSSKEYFRAMESRULE_NAME       = 0x000003e9U,
    DISPID_IHTMLMSCSSKEYFRAMESRULE_CSSRULES   = 0x000003eaU,
    DISPID_IHTMLMSCSSKEYFRAMESRULE_APPENDRULE = 0x000003ebU,
    DISPID_IHTMLMSCSSKEYFRAMESRULE_DELETERULE = 0x000003ecU,
    DISPID_IHTMLMSCSSKEYFRAMESRULE_FINDRULE   = 0x000003edU,
}

enum : uint
{
    DISPID_IHTMLRENDERSTYLE_TEXTLINETHROUGHSTYLE = 0x0001142eU,
    DISPID_IHTMLRENDERSTYLE_TEXTUNDERLINESTYLE   = 0x0001142fU,
    DISPID_IHTMLRENDERSTYLE_TEXTEFFECT           = 0x00011430U,
    DISPID_IHTMLRENDERSTYLE_TEXTCOLOR            = 0x00011446U,
    DISPID_IHTMLRENDERSTYLE_TEXTBACKGROUNDCOLOR  = 0x00011431U,
    DISPID_IHTMLRENDERSTYLE_TEXTDECORATIONCOLOR  = 0x00011445U,
    DISPID_IHTMLRENDERSTYLE_RENDERINGPRIORITY    = 0x00011432U,
    DISPID_IHTMLRENDERSTYLE_DEFAULTTEXTSELECTION = 0x00011444U,
    DISPID_IHTMLRENDERSTYLE_TEXTDECORATION       = 0x00011447U,
}

enum : uint
{
    DISPID_IHTMLCURRENTSTYLE_POSITION   = 0x000113e2U,
    DISPID_IHTMLCURRENTSTYLE_STYLEFLOAT = 0x000113ceU,
    DISPID_IHTMLCURRENTSTYLE_COLOR      = 0x0001138aU,
}

enum int DISPID_IHTMLCURRENTSTYLE_BACKGROUNDCOLOR = 0xfffffe0b;

enum : uint
{
    DISPID_IHTMLCURRENTSTYLE_FONTFAMILY                = 0x0001139aU,
    DISPID_IHTMLCURRENTSTYLE_FONTSTYLE                 = 0x000113a0U,
    DISPID_IHTMLCURRENTSTYLE_FONTVARIANT               = 0x000113a1U,
    DISPID_IHTMLCURRENTSTYLE_FONTWEIGHT                = 0x000113a3U,
    DISPID_IHTMLCURRENTSTYLE_FONTSIZE                  = 0x0001139bU,
    DISPID_IHTMLCURRENTSTYLE_BACKGROUNDIMAGE           = 0x00011389U,
    DISPID_IHTMLCURRENTSTYLE_BACKGROUNDPOSITIONX       = 0x000113a9U,
    DISPID_IHTMLCURRENTSTYLE_BACKGROUNDPOSITIONY       = 0x000113aaU,
    DISPID_IHTMLCURRENTSTYLE_BACKGROUNDREPEAT          = 0x000113b4U,
    DISPID_IHTMLCURRENTSTYLE_BORDERLEFTCOLOR           = 0x000113c2U,
    DISPID_IHTMLCURRENTSTYLE_BORDERTOPCOLOR            = 0x000113bfU,
    DISPID_IHTMLCURRENTSTYLE_BORDERRIGHTCOLOR          = 0x000113c0U,
    DISPID_IHTMLCURRENTSTYLE_BORDERBOTTOMCOLOR         = 0x000113c1U,
    DISPID_IHTMLCURRENTSTYLE_BORDERTOPSTYLE            = 0x000113c9U,
    DISPID_IHTMLCURRENTSTYLE_BORDERRIGHTSTYLE          = 0x000113caU,
    DISPID_IHTMLCURRENTSTYLE_BORDERBOTTOMSTYLE         = 0x000113cbU,
    DISPID_IHTMLCURRENTSTYLE_BORDERLEFTSTYLE           = 0x000113ccU,
    DISPID_IHTMLCURRENTSTYLE_BORDERTOPWIDTH            = 0x000113c4U,
    DISPID_IHTMLCURRENTSTYLE_BORDERRIGHTWIDTH          = 0x000113c5U,
    DISPID_IHTMLCURRENTSTYLE_BORDERBOTTOMWIDTH         = 0x000113c6U,
    DISPID_IHTMLCURRENTSTYLE_BORDERLEFTWIDTH           = 0x000113c7U,
    DISPID_IHTMLCURRENTSTYLE_LEFT                      = 0x00010003U,
    DISPID_IHTMLCURRENTSTYLE_TOP                       = 0x00010004U,
    DISPID_IHTMLCURRENTSTYLE_WIDTH                     = 0x00010005U,
    DISPID_IHTMLCURRENTSTYLE_HEIGHT                    = 0x00010006U,
    DISPID_IHTMLCURRENTSTYLE_PADDINGLEFT               = 0x00011397U,
    DISPID_IHTMLCURRENTSTYLE_PADDINGTOP                = 0x00011394U,
    DISPID_IHTMLCURRENTSTYLE_PADDINGRIGHT              = 0x00011395U,
    DISPID_IHTMLCURRENTSTYLE_PADDINGBOTTOM             = 0x00011396U,
    DISPID_IHTMLCURRENTSTYLE_TEXTALIGN                 = 0x00010048U,
    DISPID_IHTMLCURRENTSTYLE_TEXTDECORATION            = 0x000113abU,
    DISPID_IHTMLCURRENTSTYLE_DISPLAY                   = 0x000113cfU,
    DISPID_IHTMLCURRENTSTYLE_VISIBILITY                = 0x000113d8U,
    DISPID_IHTMLCURRENTSTYLE_ZINDEX                    = 0x000113e3U,
    DISPID_IHTMLCURRENTSTYLE_LETTERSPACING             = 0x00011390U,
    DISPID_IHTMLCURRENTSTYLE_LINEHEIGHT                = 0x0001138eU,
    DISPID_IHTMLCURRENTSTYLE_TEXTINDENT                = 0x0001138fU,
    DISPID_IHTMLCURRENTSTYLE_VERTICALALIGN             = 0x000113b8U,
    DISPID_IHTMLCURRENTSTYLE_BACKGROUNDATTACHMENT      = 0x000113b5U,
    DISPID_IHTMLCURRENTSTYLE_MARGINTOP                 = 0x000113adU,
    DISPID_IHTMLCURRENTSTYLE_MARGINRIGHT               = 0x000113aeU,
    DISPID_IHTMLCURRENTSTYLE_MARGINBOTTOM              = 0x000113afU,
    DISPID_IHTMLCURRENTSTYLE_MARGINLEFT                = 0x000113b0U,
    DISPID_IHTMLCURRENTSTYLE_CLEAR                     = 0x00011398U,
    DISPID_IHTMLCURRENTSTYLE_LISTSTYLETYPE             = 0x000113d0U,
    DISPID_IHTMLCURRENTSTYLE_LISTSTYLEPOSITION         = 0x000113d1U,
    DISPID_IHTMLCURRENTSTYLE_LISTSTYLEIMAGE            = 0x000113d2U,
    DISPID_IHTMLCURRENTSTYLE_CLIPTOP                   = 0x000113e5U,
    DISPID_IHTMLCURRENTSTYLE_CLIPRIGHT                 = 0x000113e6U,
    DISPID_IHTMLCURRENTSTYLE_CLIPBOTTOM                = 0x000113e7U,
    DISPID_IHTMLCURRENTSTYLE_CLIPLEFT                  = 0x000113e8U,
    DISPID_IHTMLCURRENTSTYLE_OVERFLOW                  = 0x00011392U,
    DISPID_IHTMLCURRENTSTYLE_PAGEBREAKBEFORE           = 0x000113d5U,
    DISPID_IHTMLCURRENTSTYLE_PAGEBREAKAFTER            = 0x000113d6U,
    DISPID_IHTMLCURRENTSTYLE_CURSOR                    = 0x000113eeU,
    DISPID_IHTMLCURRENTSTYLE_TABLELAYOUT               = 0x000113eaU,
    DISPID_IHTMLCURRENTSTYLE_BORDERCOLLAPSE            = 0x000113dcU,
    DISPID_IHTMLCURRENTSTYLE_DIRECTION                 = 0x000113ffU,
    DISPID_IHTMLCURRENTSTYLE_BEHAVIOR                  = 0x000113fbU,
    DISPID_IHTMLCURRENTSTYLE_GETATTRIBUTE              = 0x000101f6U,
    DISPID_IHTMLCURRENTSTYLE_UNICODEBIDI               = 0x000113feU,
    DISPID_IHTMLCURRENTSTYLE_RIGHT                     = 0x0001004dU,
    DISPID_IHTMLCURRENTSTYLE_BOTTOM                    = 0x0001004eU,
    DISPID_IHTMLCURRENTSTYLE_IMEMODE                   = 0x00011400U,
    DISPID_IHTMLCURRENTSTYLE_RUBYALIGN                 = 0x00011401U,
    DISPID_IHTMLCURRENTSTYLE_RUBYPOSITION              = 0x00011402U,
    DISPID_IHTMLCURRENTSTYLE_RUBYOVERHANG              = 0x00011403U,
    DISPID_IHTMLCURRENTSTYLE_TEXTAUTOSPACE             = 0x0001140cU,
    DISPID_IHTMLCURRENTSTYLE_LINEBREAK                 = 0x0001140dU,
    DISPID_IHTMLCURRENTSTYLE_WORDBREAK                 = 0x0001140eU,
    DISPID_IHTMLCURRENTSTYLE_TEXTJUSTIFY               = 0x0001140fU,
    DISPID_IHTMLCURRENTSTYLE_TEXTJUSTIFYTRIM           = 0x00011410U,
    DISPID_IHTMLCURRENTSTYLE_TEXTKASHIDA               = 0x00011411U,
    DISPID_IHTMLCURRENTSTYLE_BLOCKDIRECTION            = 0x000113fdU,
    DISPID_IHTMLCURRENTSTYLE_LAYOUTGRIDCHAR            = 0x00011407U,
    DISPID_IHTMLCURRENTSTYLE_LAYOUTGRIDLINE            = 0x00011408U,
    DISPID_IHTMLCURRENTSTYLE_LAYOUTGRIDMODE            = 0x00011409U,
    DISPID_IHTMLCURRENTSTYLE_LAYOUTGRIDTYPE            = 0x0001140aU,
    DISPID_IHTMLCURRENTSTYLE_BORDERSTYLE               = 0x000113c8U,
    DISPID_IHTMLCURRENTSTYLE_BORDERCOLOR               = 0x000113beU,
    DISPID_IHTMLCURRENTSTYLE_BORDERWIDTH               = 0x000113c3U,
    DISPID_IHTMLCURRENTSTYLE_PADDING                   = 0x00011393U,
    DISPID_IHTMLCURRENTSTYLE_MARGIN                    = 0x000113acU,
    DISPID_IHTMLCURRENTSTYLE_ACCELERATOR               = 0x0001141bU,
    DISPID_IHTMLCURRENTSTYLE_OVERFLOWX                 = 0x00011413U,
    DISPID_IHTMLCURRENTSTYLE_OVERFLOWY                 = 0x00011414U,
    DISPID_IHTMLCURRENTSTYLE_TEXTTRANSFORM             = 0x0001138cU,
    DISPID_IHTMLCURRENTSTYLE2_LAYOUTFLOW               = 0x00011423U,
    DISPID_IHTMLCURRENTSTYLE2_WORDWRAP                 = 0x00011426U,
    DISPID_IHTMLCURRENTSTYLE2_TEXTUNDERLINEPOSITION    = 0x00011427U,
    DISPID_IHTMLCURRENTSTYLE2_HASLAYOUT                = 0x00011428U,
    DISPID_IHTMLCURRENTSTYLE2_SCROLLBARBASECOLOR       = 0x0001143cU,
    DISPID_IHTMLCURRENTSTYLE2_SCROLLBARFACECOLOR       = 0x0001143dU,
    DISPID_IHTMLCURRENTSTYLE2_SCROLLBAR3DLIGHTCOLOR    = 0x0001143eU,
    DISPID_IHTMLCURRENTSTYLE2_SCROLLBARSHADOWCOLOR     = 0x0001143fU,
    DISPID_IHTMLCURRENTSTYLE2_SCROLLBARHIGHLIGHTCOLOR  = 0x00011440U,
    DISPID_IHTMLCURRENTSTYLE2_SCROLLBARDARKSHADOWCOLOR = 0x00011441U,
    DISPID_IHTMLCURRENTSTYLE2_SCROLLBARARROWCOLOR      = 0x00011442U,
    DISPID_IHTMLCURRENTSTYLE2_SCROLLBARTRACKCOLOR      = 0x0001144cU,
    DISPID_IHTMLCURRENTSTYLE2_WRITINGMODE              = 0x00011448U,
    DISPID_IHTMLCURRENTSTYLE2_ZOOM                     = 0x00011421U,
    DISPID_IHTMLCURRENTSTYLE2_FILTER                   = 0x000113daU,
    DISPID_IHTMLCURRENTSTYLE2_TEXTALIGNLAST            = 0x00011453U,
    DISPID_IHTMLCURRENTSTYLE2_TEXTKASHIDASPACE         = 0x00011454U,
    DISPID_IHTMLCURRENTSTYLE2_ISBLOCK                  = 0x00011458U,
    DISPID_IHTMLCURRENTSTYLE3_TEXTOVERFLOW             = 0x00011459U,
    DISPID_IHTMLCURRENTSTYLE3_MINHEIGHT                = 0x0001145bU,
    DISPID_IHTMLCURRENTSTYLE3_WORDSPACING              = 0x000113b7U,
    DISPID_IHTMLCURRENTSTYLE3_WHITESPACE               = 0x000113d4U,
    DISPID_IHTMLCURRENTSTYLE4_MSINTERPOLATIONMODE      = 0x0001145dU,
    DISPID_IHTMLCURRENTSTYLE4_MAXHEIGHT                = 0x0001145eU,
    DISPID_IHTMLCURRENTSTYLE4_MINWIDTH                 = 0x0001145fU,
    DISPID_IHTMLCURRENTSTYLE4_MAXWIDTH                 = 0x00011460U,
    DISPID_IHTMLCURRENTSTYLE5_CAPTIONSIDE              = 0x00011463U,
    DISPID_IHTMLCURRENTSTYLE5_OUTLINE                  = 0x00011466U,
    DISPID_IHTMLCURRENTSTYLE5_OUTLINEWIDTH             = 0x00011467U,
    DISPID_IHTMLCURRENTSTYLE5_OUTLINESTYLE             = 0x00011468U,
    DISPID_IHTMLCURRENTSTYLE5_OUTLINECOLOR             = 0x00011469U,
    DISPID_IHTMLCURRENTSTYLE5_BOXSIZING                = 0x0001146aU,
    DISPID_IHTMLCURRENTSTYLE5_BORDERSPACING            = 0x0001146bU,
    DISPID_IHTMLCURRENTSTYLE5_ORPHANS                  = 0x0001146cU,
    DISPID_IHTMLCURRENTSTYLE5_WIDOWS                   = 0x0001146dU,
    DISPID_IHTMLCURRENTSTYLE5_PAGEBREAKINSIDE          = 0x0001146eU,
    DISPID_IHTMLCURRENTSTYLE5_EMPTYCELLS               = 0x00011482U,
    DISPID_IHTMLCURRENTSTYLE5_MSBLOCKPROGRESSION       = 0x00011483U,
    DISPID_IHTMLCURRENTSTYLE5_QUOTES                   = 0x00011484U,
}

enum : uint
{
    DISPID_IHTMLRECT_LEFT             = 0x000003e9U,
    DISPID_IHTMLRECT_TOP              = 0x000003eaU,
    DISPID_IHTMLRECT_RIGHT            = 0x000003ebU,
    DISPID_IHTMLRECT_BOTTOM           = 0x000003ecU,
    DISPID_IHTMLRECT2_WIDTH           = 0x000003edU,
    DISPID_IHTMLRECT2_HEIGHT          = 0x000003eeU,
    DISPID_IHTMLRECTCOLLECTION_LENGTH = 0x000005dcU,
}

enum int DISPID_IHTMLRECTCOLLECTION__NEWENUM = 0xfffffffc;
enum uint DISPID_IHTMLRECTCOLLECTION_ITEM = 0x00000000U;

enum : uint
{
    DISPID_IHTMLDOMNODE_NODETYPE                 = 0x00010416U,
    DISPID_IHTMLDOMNODE_PARENTNODE               = 0x00010417U,
    DISPID_IHTMLDOMNODE_HASCHILDNODES            = 0x00010418U,
    DISPID_IHTMLDOMNODE_CHILDNODES               = 0x00010419U,
    DISPID_IHTMLDOMNODE_ATTRIBUTES               = 0x0001041aU,
    DISPID_IHTMLDOMNODE_INSERTBEFORE             = 0x0001041bU,
    DISPID_IHTMLDOMNODE_REMOVECHILD              = 0x0001041cU,
    DISPID_IHTMLDOMNODE_REPLACECHILD             = 0x0001041dU,
    DISPID_IHTMLDOMNODE_CLONENODE                = 0x00010425U,
    DISPID_IHTMLDOMNODE_REMOVENODE               = 0x0001042aU,
    DISPID_IHTMLDOMNODE_SWAPNODE                 = 0x0001042cU,
    DISPID_IHTMLDOMNODE_REPLACENODE              = 0x0001042bU,
    DISPID_IHTMLDOMNODE_APPENDCHILD              = 0x00010431U,
    DISPID_IHTMLDOMNODE_NODENAME                 = 0x00010432U,
    DISPID_IHTMLDOMNODE_NODEVALUE                = 0x00010433U,
    DISPID_IHTMLDOMNODE_FIRSTCHILD               = 0x00010434U,
    DISPID_IHTMLDOMNODE_LASTCHILD                = 0x00010435U,
    DISPID_IHTMLDOMNODE_PREVIOUSSIBLING          = 0x00010436U,
    DISPID_IHTMLDOMNODE_NEXTSIBLING              = 0x00010437U,
    DISPID_IHTMLDOMNODE2_OWNERDOCUMENT           = 0x00010459U,
    DISPID_IHTMLDOMNODE3_PREFIX                  = 0x00010460U,
    DISPID_IHTMLDOMNODE3_LOCALNAME               = 0x0001045eU,
    DISPID_IHTMLDOMNODE3_NAMESPACEURI            = 0x0001045fU,
    DISPID_IHTMLDOMNODE3_TEXTCONTENT             = 0x00010467U,
    DISPID_IHTMLDOMNODE3_ISEQUALNODE             = 0x00010461U,
    DISPID_IHTMLDOMNODE3_LOOKUPNAMESPACEURI      = 0x00010462U,
    DISPID_IHTMLDOMNODE3_LOOKUPPREFIX            = 0x00010463U,
    DISPID_IHTMLDOMNODE3_ISDEFAULTNAMESPACE      = 0x00010464U,
    DISPID_IHTMLDOMNODE3_IE9_APPENDCHILD         = 0x000104f4U,
    DISPID_IHTMLDOMNODE3_IE9_INSERTBEFORE        = 0x000104f5U,
    DISPID_IHTMLDOMNODE3_IE9_REMOVECHILD         = 0x000104f6U,
    DISPID_IHTMLDOMNODE3_IE9_REPLACECHILD        = 0x000104f7U,
    DISPID_IHTMLDOMNODE3_ISSAMENODE              = 0x00010465U,
    DISPID_IHTMLDOMNODE3_COMPAREDOCUMENTPOSITION = 0x00010466U,
    DISPID_IHTMLDOMNODE3_ISSUPPORTED             = 0x000104fdU,
    DISPID_IHTMLDOMATTRIBUTE_NODENAME            = 0x000003e8U,
    DISPID_IHTMLDOMATTRIBUTE_NODEVALUE           = 0x000003eaU,
    DISPID_IHTMLDOMATTRIBUTE_SPECIFIED           = 0x000003e9U,
    DISPID_IHTMLDOMATTRIBUTE2_NAME               = 0x000003ebU,
    DISPID_IHTMLDOMATTRIBUTE2_VALUE              = 0x000003ecU,
    DISPID_IHTMLDOMATTRIBUTE2_EXPANDO            = 0x000003edU,
    DISPID_IHTMLDOMATTRIBUTE2_NODETYPE           = 0x000003eeU,
    DISPID_IHTMLDOMATTRIBUTE2_PARENTNODE         = 0x000003efU,
    DISPID_IHTMLDOMATTRIBUTE2_CHILDNODES         = 0x000003f0U,
    DISPID_IHTMLDOMATTRIBUTE2_FIRSTCHILD         = 0x000003f1U,
    DISPID_IHTMLDOMATTRIBUTE2_LASTCHILD          = 0x000003f2U,
    DISPID_IHTMLDOMATTRIBUTE2_PREVIOUSSIBLING    = 0x000003f3U,
    DISPID_IHTMLDOMATTRIBUTE2_NEXTSIBLING        = 0x000003f4U,
    DISPID_IHTMLDOMATTRIBUTE2_ATTRIBUTES         = 0x000003f5U,
    DISPID_IHTMLDOMATTRIBUTE2_OWNERDOCUMENT      = 0x000003f6U,
    DISPID_IHTMLDOMATTRIBUTE2_INSERTBEFORE       = 0x000003f7U,
    DISPID_IHTMLDOMATTRIBUTE2_REPLACECHILD       = 0x000003f8U,
    DISPID_IHTMLDOMATTRIBUTE2_REMOVECHILD        = 0x000003f9U,
    DISPID_IHTMLDOMATTRIBUTE2_APPENDCHILD        = 0x000003faU,
    DISPID_IHTMLDOMATTRIBUTE2_HASCHILDNODES      = 0x000003fbU,
    DISPID_IHTMLDOMATTRIBUTE2_CLONENODE          = 0x000003fcU,
    DISPID_IHTMLDOMATTRIBUTE3_IE8_NODEVALUE      = 0x00000481U,
    DISPID_IHTMLDOMATTRIBUTE3_IE8_VALUE          = 0x00000482U,
    DISPID_IHTMLDOMATTRIBUTE3_IE8_SPECIFIED      = 0x0000047eU,
    DISPID_IHTMLDOMATTRIBUTE3_OWNERELEMENT       = 0x0000047fU,
    DISPID_IHTMLDOMATTRIBUTE4_IE9_NODEVALUE      = 0x00000487U,
    DISPID_IHTMLDOMATTRIBUTE4_IE9_NODENAME       = 0x00000488U,
    DISPID_IHTMLDOMATTRIBUTE4_IE9_NAME           = 0x00000489U,
    DISPID_IHTMLDOMATTRIBUTE4_IE9_VALUE          = 0x0000048aU,
    DISPID_IHTMLDOMATTRIBUTE4_IE9_FIRSTCHILD     = 0x0000048bU,
    DISPID_IHTMLDOMATTRIBUTE4_IE9_LASTCHILD      = 0x0000048cU,
    DISPID_IHTMLDOMATTRIBUTE4_IE9_CHILDNODES     = 0x0000048dU,
    DISPID_IHTMLDOMATTRIBUTE4_HASATTRIBUTES      = 0x0000048eU,
    DISPID_IHTMLDOMATTRIBUTE4_IE9_HASCHILDNODES  = 0x0000048fU,
    DISPID_IHTMLDOMATTRIBUTE4_NORMALIZE          = 0x00000492U,
    DISPID_IHTMLDOMATTRIBUTE4_IE9_SPECIFIED      = 0x00000493U,
}

enum : uint
{
    DISPID_IHTMLDOMTEXTNODE_DATA                      = 0x000003e8U,
    DISPID_IHTMLDOMTEXTNODE_TOSTRING                  = 0x000003e9U,
    DISPID_IHTMLDOMTEXTNODE_LENGTH                    = 0x000003eaU,
    DISPID_IHTMLDOMTEXTNODE_SPLITTEXT                 = 0x000003ebU,
    DISPID_IHTMLDOMTEXTNODE2_SUBSTRINGDATA            = 0x000003ecU,
    DISPID_IHTMLDOMTEXTNODE2_APPENDDATA               = 0x000003edU,
    DISPID_IHTMLDOMTEXTNODE2_INSERTDATA               = 0x000003eeU,
    DISPID_IHTMLDOMTEXTNODE2_DELETEDATA               = 0x000003efU,
    DISPID_IHTMLDOMTEXTNODE2_REPLACEDATA              = 0x000003f0U,
    DISPID_IHTMLDOMTEXTNODE3_IE9_SUBSTRINGDATA        = 0x000003f2U,
    DISPID_IHTMLDOMTEXTNODE3_IE9_INSERTDATA           = 0x000003f3U,
    DISPID_IHTMLDOMTEXTNODE3_IE9_DELETEDATA           = 0x000003f4U,
    DISPID_IHTMLDOMTEXTNODE3_IE9_REPLACEDATA          = 0x000003f5U,
    DISPID_IHTMLDOMTEXTNODE3_IE9_SPLITTEXT            = 0x000003f1U,
    DISPID_IHTMLDOMTEXTNODE3_WHOLETEXT                = 0x000003f6U,
    DISPID_IHTMLDOMTEXTNODE3_REPLACEWHOLETEXT         = 0x000003f7U,
    DISPID_IHTMLDOMTEXTNODE3_HASATTRIBUTES            = 0x000003f9U,
    DISPID_IHTMLDOMTEXTNODE3_NORMALIZE                = 0x000003fbU,
    DISPID_IHTMLDOMIMPLEMENTATION_HASFEATURE          = 0x000003e8U,
    DISPID_IHTMLDOMIMPLEMENTATION2_CREATEDOCUMENTTYPE = 0x000003e9U,
    DISPID_IHTMLDOMIMPLEMENTATION2_CREATEDOCUMENT     = 0x000003eaU,
    DISPID_IHTMLDOMIMPLEMENTATION2_CREATEHTMLDOCUMENT = 0x000003ebU,
    DISPID_IHTMLDOMIMPLEMENTATION2_IE9_HASFEATURE     = 0x000003ecU,
}

enum uint DISPID_IHTMLATTRIBUTECOLLECTION_LENGTH = 0x000005dcU;
enum int DISPID_IHTMLATTRIBUTECOLLECTION__NEWENUM = 0xfffffffc;

enum : uint
{
    DISPID_IHTMLATTRIBUTECOLLECTION_ITEM                 = 0x00000000U,
    DISPID_IHTMLATTRIBUTECOLLECTION2_GETNAMEDITEM        = 0x000005ddU,
    DISPID_IHTMLATTRIBUTECOLLECTION2_SETNAMEDITEM        = 0x000005deU,
    DISPID_IHTMLATTRIBUTECOLLECTION2_REMOVENAMEDITEM     = 0x000005dfU,
    DISPID_IHTMLATTRIBUTECOLLECTION3_IE8_GETNAMEDITEM    = 0x0000047eU,
    DISPID_IHTMLATTRIBUTECOLLECTION3_IE8_SETNAMEDITEM    = 0x0000047fU,
    DISPID_IHTMLATTRIBUTECOLLECTION3_IE8_REMOVENAMEDITEM = 0x00000480U,
    DISPID_IHTMLATTRIBUTECOLLECTION3_IE8_ITEM            = 0x00000482U,
    DISPID_IHTMLATTRIBUTECOLLECTION3_IE8_LENGTH          = 0x00000481U,
    DISPID_IHTMLATTRIBUTECOLLECTION4_GETNAMEDITEMNS      = 0x00000483U,
    DISPID_IHTMLATTRIBUTECOLLECTION4_SETNAMEDITEMNS      = 0x00000484U,
    DISPID_IHTMLATTRIBUTECOLLECTION4_REMOVENAMEDITEMNS   = 0x00000485U,
    DISPID_IHTMLATTRIBUTECOLLECTION4_IE9_GETNAMEDITEM    = 0x00000486U,
    DISPID_IHTMLATTRIBUTECOLLECTION4_IE9_SETNAMEDITEM    = 0x00000487U,
    DISPID_IHTMLATTRIBUTECOLLECTION4_IE9_REMOVENAMEDITEM = 0x00000488U,
    DISPID_IHTMLATTRIBUTECOLLECTION4_IE9_ITEM            = 0x00000489U,
    DISPID_IHTMLATTRIBUTECOLLECTION4_IE9_LENGTH          = 0x0000048aU,
}

enum uint DISPID_IHTMLDOMCHILDRENCOLLECTION_LENGTH = 0x000005dcU;
enum int DISPID_IHTMLDOMCHILDRENCOLLECTION__NEWENUM = 0xfffffffc;

enum : uint
{
    DISPID_IHTMLDOMCHILDRENCOLLECTION_ITEM      = 0x00000000U,
    DISPID_IHTMLDOMCHILDRENCOLLECTION2_IE9_ITEM = 0x00000001U,
}

enum : uint
{
    DISPID_IHTMLELEMENT_SETATTRIBUTE           = 0x000101f5U,
    DISPID_IHTMLELEMENT_GETATTRIBUTE           = 0x000101f6U,
    DISPID_IHTMLELEMENT_REMOVEATTRIBUTE        = 0x000101f7U,
    DISPID_IHTMLELEMENT_CLASSNAME              = 0x000103e9U,
    DISPID_IHTMLELEMENT_ID                     = 0x000103eaU,
    DISPID_IHTMLELEMENT_TAGNAME                = 0x000103ecU,
    DISPID_IHTMLELEMENT_PARENTELEMENT          = 0x00010008U,
    DISPID_IHTMLELEMENT_STYLE                  = 0x0001004aU,
    DISPID_IHTMLELEMENT_ONHELP                 = 0x0001177dU,
    DISPID_IHTMLELEMENT_ONCLICK                = 0x00011778U,
    DISPID_IHTMLELEMENT_ONDBLCLICK             = 0x00011779U,
    DISPID_IHTMLELEMENT_ONKEYDOWN              = 0x00011775U,
    DISPID_IHTMLELEMENT_ONKEYUP                = 0x00011776U,
    DISPID_IHTMLELEMENT_ONKEYPRESS             = 0x00011777U,
    DISPID_IHTMLELEMENT_ONMOUSEOUT             = 0x00011771U,
    DISPID_IHTMLELEMENT_ONMOUSEOVER            = 0x00011770U,
    DISPID_IHTMLELEMENT_ONMOUSEMOVE            = 0x00011774U,
    DISPID_IHTMLELEMENT_ONMOUSEDOWN            = 0x00011772U,
    DISPID_IHTMLELEMENT_ONMOUSEUP              = 0x00011773U,
    DISPID_IHTMLELEMENT_DOCUMENT               = 0x000103faU,
    DISPID_IHTMLELEMENT_TITLE                  = 0x00010045U,
    DISPID_IHTMLELEMENT_LANGUAGE               = 0x000113ecU,
    DISPID_IHTMLELEMENT_ONSELECTSTART          = 0x00011795U,
    DISPID_IHTMLELEMENT_SCROLLINTOVIEW         = 0x000103fbU,
    DISPID_IHTMLELEMENT_CONTAINS               = 0x000103fcU,
    DISPID_IHTMLELEMENT_SOURCEINDEX            = 0x00010400U,
    DISPID_IHTMLELEMENT_RECORDNUMBER           = 0x00010401U,
    DISPID_IHTMLELEMENT_LANG                   = 0x00011391U,
    DISPID_IHTMLELEMENT_OFFSETLEFT             = 0x000103f0U,
    DISPID_IHTMLELEMENT_OFFSETTOP              = 0x000103f1U,
    DISPID_IHTMLELEMENT_OFFSETWIDTH            = 0x000103f2U,
    DISPID_IHTMLELEMENT_OFFSETHEIGHT           = 0x000103f3U,
    DISPID_IHTMLELEMENT_OFFSETPARENT           = 0x000103f4U,
    DISPID_IHTMLELEMENT_INNERHTML              = 0x00010402U,
    DISPID_IHTMLELEMENT_INNERTEXT              = 0x00010403U,
    DISPID_IHTMLELEMENT_OUTERHTML              = 0x00010404U,
    DISPID_IHTMLELEMENT_OUTERTEXT              = 0x00010405U,
    DISPID_IHTMLELEMENT_INSERTADJACENTHTML     = 0x00010406U,
    DISPID_IHTMLELEMENT_INSERTADJACENTTEXT     = 0x00010407U,
    DISPID_IHTMLELEMENT_PARENTTEXTEDIT         = 0x00010408U,
    DISPID_IHTMLELEMENT_ISTEXTEDIT             = 0x0001040aU,
    DISPID_IHTMLELEMENT_CLICK                  = 0x00010409U,
    DISPID_IHTMLELEMENT_FILTERS                = 0x0001040bU,
    DISPID_IHTMLELEMENT_ONDRAGSTART            = 0x00011793U,
    DISPID_IHTMLELEMENT_TOSTRING               = 0x0001040cU,
    DISPID_IHTMLELEMENT_ONBEFOREUPDATE         = 0x00011785U,
    DISPID_IHTMLELEMENT_ONAFTERUPDATE          = 0x00011786U,
    DISPID_IHTMLELEMENT_ONERRORUPDATE          = 0x00011796U,
    DISPID_IHTMLELEMENT_ONROWEXIT              = 0x00011782U,
    DISPID_IHTMLELEMENT_ONROWENTER             = 0x00011783U,
    DISPID_IHTMLELEMENT_ONDATASETCHANGED       = 0x00011798U,
    DISPID_IHTMLELEMENT_ONDATAAVAILABLE        = 0x00011799U,
    DISPID_IHTMLELEMENT_ONDATASETCOMPLETE      = 0x0001179aU,
    DISPID_IHTMLELEMENT_ONFILTERCHANGE         = 0x0001179bU,
    DISPID_IHTMLELEMENT_CHILDREN               = 0x0001040dU,
    DISPID_IHTMLELEMENT_ALL                    = 0x0001040eU,
    DISPID_IHTMLELEMENT2_SCOPENAME             = 0x0001040fU,
    DISPID_IHTMLELEMENT2_SETCAPTURE            = 0x00010410U,
    DISPID_IHTMLELEMENT2_RELEASECAPTURE        = 0x00010411U,
    DISPID_IHTMLELEMENT2_ONLOSECAPTURE         = 0x0001179eU,
    DISPID_IHTMLELEMENT2_COMPONENTFROMPOINT    = 0x00010412U,
    DISPID_IHTMLELEMENT2_DOSCROLL              = 0x00010413U,
    DISPID_IHTMLELEMENT2_ONSCROLL              = 0x0001178fU,
    DISPID_IHTMLELEMENT2_ONDRAG                = 0x000117a1U,
    DISPID_IHTMLELEMENT2_ONDRAGEND             = 0x000117a2U,
    DISPID_IHTMLELEMENT2_ONDRAGENTER           = 0x000117a3U,
    DISPID_IHTMLELEMENT2_ONDRAGOVER            = 0x000117a4U,
    DISPID_IHTMLELEMENT2_ONDRAGLEAVE           = 0x000117a5U,
    DISPID_IHTMLELEMENT2_ONDROP                = 0x000117a6U,
    DISPID_IHTMLELEMENT2_ONBEFORECUT           = 0x000117aaU,
    DISPID_IHTMLELEMENT2_ONCUT                 = 0x000117a7U,
    DISPID_IHTMLELEMENT2_ONBEFORECOPY          = 0x000117abU,
    DISPID_IHTMLELEMENT2_ONCOPY                = 0x000117a8U,
    DISPID_IHTMLELEMENT2_ONBEFOREPASTE         = 0x000117acU,
    DISPID_IHTMLELEMENT2_ONPASTE               = 0x000117a9U,
    DISPID_IHTMLELEMENT2_CURRENTSTYLE          = 0x000103efU,
    DISPID_IHTMLELEMENT2_ONPROPERTYCHANGE      = 0x0001179fU,
    DISPID_IHTMLELEMENT2_GETCLIENTRECTS        = 0x00010414U,
    DISPID_IHTMLELEMENT2_GETBOUNDINGCLIENTRECT = 0x00010415U,
    DISPID_IHTMLELEMENT2_SETEXPRESSION         = 0x000101f8U,
    DISPID_IHTMLELEMENT2_GETEXPRESSION         = 0x000101f9U,
    DISPID_IHTMLELEMENT2_REMOVEEXPRESSION      = 0x000101faU,
    DISPID_IHTMLELEMENT2_TABINDEX              = 0x0001000fU,
    DISPID_IHTMLELEMENT2_FOCUS                 = 0x000107d0U,
    DISPID_IHTMLELEMENT2_ACCESSKEY             = 0x000107d5U,
    DISPID_IHTMLELEMENT2_ONBLUR                = 0x0001177fU,
    DISPID_IHTMLELEMENT2_ONFOCUS               = 0x0001177eU,
    DISPID_IHTMLELEMENT2_ONRESIZE              = 0x00011794U,
    DISPID_IHTMLELEMENT2_BLUR                  = 0x000107d2U,
    DISPID_IHTMLELEMENT2_ADDFILTER             = 0x000107e1U,
    DISPID_IHTMLELEMENT2_REMOVEFILTER          = 0x000107e2U,
    DISPID_IHTMLELEMENT2_CLIENTHEIGHT          = 0x000107e3U,
    DISPID_IHTMLELEMENT2_CLIENTWIDTH           = 0x000107e4U,
    DISPID_IHTMLELEMENT2_CLIENTTOP             = 0x000107e5U,
    DISPID_IHTMLELEMENT2_CLIENTLEFT            = 0x000107e6U,
    DISPID_IHTMLELEMENT2_ATTACHEVENT           = 0x000101fbU,
    DISPID_IHTMLELEMENT2_DETACHEVENT           = 0x000101fcU,
    DISPID_IHTMLELEMENT2_READYSTATE            = 0x000113fcU,
    DISPID_IHTMLELEMENT2_ONREADYSTATECHANGE    = 0x00011789U,
    DISPID_IHTMLELEMENT2_ONROWSDELETE          = 0x000117aeU,
    DISPID_IHTMLELEMENT2_ONROWSINSERTED        = 0x000117afU,
    DISPID_IHTMLELEMENT2_ONCELLCHANGE          = 0x000117b0U,
    DISPID_IHTMLELEMENT2_DIR                   = 0x000113fdU,
    DISPID_IHTMLELEMENT2_CREATECONTROLRANGE    = 0x00010420U,
    DISPID_IHTMLELEMENT2_SCROLLHEIGHT          = 0x00010421U,
    DISPID_IHTMLELEMENT2_SCROLLWIDTH           = 0x00010422U,
    DISPID_IHTMLELEMENT2_SCROLLTOP             = 0x00010423U,
    DISPID_IHTMLELEMENT2_SCROLLLEFT            = 0x00010424U,
    DISPID_IHTMLELEMENT2_CLEARATTRIBUTES       = 0x00010426U,
    DISPID_IHTMLELEMENT2_MERGEATTRIBUTES       = 0x00010427U,
    DISPID_IHTMLELEMENT2_ONCONTEXTMENU         = 0x000117b1U,
    DISPID_IHTMLELEMENT2_INSERTADJACENTELEMENT = 0x0001042dU,
    DISPID_IHTMLELEMENT2_APPLYELEMENT          = 0x00010429U,
    DISPID_IHTMLELEMENT2_GETADJACENTTEXT       = 0x0001042eU,
    DISPID_IHTMLELEMENT2_REPLACEADJACENTTEXT   = 0x0001042fU,
    DISPID_IHTMLELEMENT2_CANHAVECHILDREN       = 0x00010430U,
    DISPID_IHTMLELEMENT2_ADDBEHAVIOR           = 0x00010438U,
    DISPID_IHTMLELEMENT2_REMOVEBEHAVIOR        = 0x00010439U,
    DISPID_IHTMLELEMENT2_RUNTIMESTYLE          = 0x00010428U,
    DISPID_IHTMLELEMENT2_BEHAVIORURNS          = 0x0001043aU,
    DISPID_IHTMLELEMENT2_TAGURN                = 0x0001043bU,
    DISPID_IHTMLELEMENT2_ONBEFOREEDITFOCUS     = 0x000117b5U,
    DISPID_IHTMLELEMENT2_READYSTATEVALUE       = 0x0001043cU,
    DISPID_IHTMLELEMENT2_GETELEMENTSBYTAGNAME  = 0x0001043dU,
    DISPID_IHTMLELEMENT3_MERGEATTRIBUTES       = 0x00010448U,
    DISPID_IHTMLELEMENT3_ISMULTILINE           = 0x00010449U,
    DISPID_IHTMLELEMENT3_CANHAVEHTML           = 0x0001044aU,
    DISPID_IHTMLELEMENT3_ONLAYOUTCOMPLETE      = 0x000117b9U,
    DISPID_IHTMLELEMENT3_ONPAGE                = 0x000117baU,
    DISPID_IHTMLELEMENT3_INFLATEBLOCK          = 0x0001044cU,
    DISPID_IHTMLELEMENT3_ONBEFOREDEACTIVATE    = 0x000117bdU,
    DISPID_IHTMLELEMENT3_SETACTIVE             = 0x0001044dU,
    DISPID_IHTMLELEMENT3_CONTENTEDITABLE       = 0x0001142aU,
    DISPID_IHTMLELEMENT3_ISCONTENTEDITABLE     = 0x0001044eU,
    DISPID_IHTMLELEMENT3_HIDEFOCUS             = 0x0001142bU,
    DISPID_IHTMLELEMENT3_DISABLED              = 0x0001004cU,
    DISPID_IHTMLELEMENT3_ISDISABLED            = 0x00010451U,
    DISPID_IHTMLELEMENT3_ONMOVE                = 0x000117beU,
    DISPID_IHTMLELEMENT3_ONCONTROLSELECT       = 0x000117bfU,
    DISPID_IHTMLELEMENT3_FIREEVENT             = 0x00010452U,
    DISPID_IHTMLELEMENT3_ONRESIZESTART         = 0x000117c3U,
    DISPID_IHTMLELEMENT3_ONRESIZEEND           = 0x000117c4U,
    DISPID_IHTMLELEMENT3_ONMOVESTART           = 0x000117c1U,
    DISPID_IHTMLELEMENT3_ONMOVEEND             = 0x000117c2U,
    DISPID_IHTMLELEMENT3_ONMOUSEENTER          = 0x000117c5U,
    DISPID_IHTMLELEMENT3_ONMOUSELEAVE          = 0x000117c6U,
    DISPID_IHTMLELEMENT3_ONACTIVATE            = 0x000117c7U,
    DISPID_IHTMLELEMENT3_ONDEACTIVATE          = 0x000117c8U,
    DISPID_IHTMLELEMENT3_DRAGDROP              = 0x00010453U,
    DISPID_IHTMLELEMENT3_GLYPHMODE             = 0x00010454U,
    DISPID_IHTMLELEMENT4_ONMOUSEWHEEL          = 0x000117bcU,
    DISPID_IHTMLELEMENT4_NORMALIZE             = 0x00010458U,
    DISPID_IHTMLELEMENT4_GETATTRIBUTENODE      = 0x00010455U,
    DISPID_IHTMLELEMENT4_SETATTRIBUTENODE      = 0x00010456U,
    DISPID_IHTMLELEMENT4_REMOVEATTRIBUTENODE   = 0x00010457U,
    DISPID_IHTMLELEMENT4_ONBEFOREACTIVATE      = 0x000117caU,
    DISPID_IHTMLELEMENT4_ONFOCUSIN             = 0x000117cbU,
    DISPID_IHTMLELEMENT4_ONFOCUSOUT            = 0x000117ccU,
}

enum : uint
{
    DISPID_IELEMENTSELECTOR_QUERYSELECTOR    = 0x0001045aU,
    DISPID_IELEMENTSELECTOR_QUERYSELECTORALL = 0x0001045bU,
}

enum : uint
{
    DISPID_IHTMLUNIQUENAME_UNIQUENUMBER = 0x0001041eU,
    DISPID_IHTMLUNIQUENAME_UNIQUEID     = 0x0001041fU,
}

enum : uint
{
    DISPID_IHTMLELEMENT5_IE8_GETATTRIBUTENODE                      = 0x000104b0U,
    DISPID_IHTMLELEMENT5_IE8_SETATTRIBUTENODE                      = 0x000104b1U,
    DISPID_IHTMLELEMENT5_IE8_REMOVEATTRIBUTENODE                   = 0x000104b2U,
    DISPID_IHTMLELEMENT5_HASATTRIBUTE                              = 0x000104b3U,
    DISPID_IHTMLELEMENT5_ROLE                                      = 0x000104b4U,
    DISPID_IHTMLELEMENT5_ARIABUSY                                  = 0x000104b5U,
    DISPID_IHTMLELEMENT5_ARIACHECKED                               = 0x000104b6U,
    DISPID_IHTMLELEMENT5_ARIADISABLED                              = 0x000104b7U,
    DISPID_IHTMLELEMENT5_ARIAEXPANDED                              = 0x000104b8U,
    DISPID_IHTMLELEMENT5_ARIAHASPOPUP                              = 0x000104b9U,
    DISPID_IHTMLELEMENT5_ARIAHIDDEN                                = 0x000104baU,
    DISPID_IHTMLELEMENT5_ARIAINVALID                               = 0x000104bbU,
    DISPID_IHTMLELEMENT5_ARIAMULTISELECTABLE                       = 0x000104bcU,
    DISPID_IHTMLELEMENT5_ARIAPRESSED                               = 0x000104bdU,
    DISPID_IHTMLELEMENT5_ARIAREADONLY                              = 0x000104beU,
    DISPID_IHTMLELEMENT5_ARIAREQUIRED                              = 0x000104bfU,
    DISPID_IHTMLELEMENT5_ARIASECRET                                = 0x000104c0U,
    DISPID_IHTMLELEMENT5_ARIASELECTED                              = 0x000104c1U,
    DISPID_IHTMLELEMENT5_IE8_GETATTRIBUTE                          = 0x000104c2U,
    DISPID_IHTMLELEMENT5_IE8_SETATTRIBUTE                          = 0x000104c3U,
    DISPID_IHTMLELEMENT5_IE8_REMOVEATTRIBUTE                       = 0x000104c4U,
    DISPID_IHTMLELEMENT5_IE8_ATTRIBUTES                            = 0x000104c5U,
    DISPID_IHTMLELEMENT5_ARIAVALUENOW                              = 0x000104c6U,
    DISPID_IHTMLELEMENT5_ARIAPOSINSET                              = 0x000104c7U,
    DISPID_IHTMLELEMENT5_ARIASETSIZE                               = 0x000104c8U,
    DISPID_IHTMLELEMENT5_ARIALEVEL                                 = 0x000104c9U,
    DISPID_IHTMLELEMENT5_ARIAVALUEMIN                              = 0x000104caU,
    DISPID_IHTMLELEMENT5_ARIAVALUEMAX                              = 0x000104cbU,
    DISPID_IHTMLELEMENT5_ARIACONTROLS                              = 0x000104ccU,
    DISPID_IHTMLELEMENT5_ARIADESCRIBEDBY                           = 0x000104cdU,
    DISPID_IHTMLELEMENT5_ARIAFLOWTO                                = 0x000104ceU,
    DISPID_IHTMLELEMENT5_ARIALABELLEDBY                            = 0x000104cfU,
    DISPID_IHTMLELEMENT5_ARIAACTIVEDESCENDANT                      = 0x000104d0U,
    DISPID_IHTMLELEMENT5_ARIAOWNS                                  = 0x000104d1U,
    DISPID_IHTMLELEMENT5_HASATTRIBUTES                             = 0x000104d2U,
    DISPID_IHTMLELEMENT5_ARIALIVE                                  = 0x000104d3U,
    DISPID_IHTMLELEMENT5_ARIARELEVANT                              = 0x000104d4U,
    DISPID_IHTMLELEMENT6_GETATTRIBUTENS                            = 0x000104e5U,
    DISPID_IHTMLELEMENT6_SETATTRIBUTENS                            = 0x000104e6U,
    DISPID_IHTMLELEMENT6_REMOVEATTRIBUTENS                         = 0x000104e7U,
    DISPID_IHTMLELEMENT6_GETATTRIBUTENODENS                        = 0x000104e2U,
    DISPID_IHTMLELEMENT6_SETATTRIBUTENODENS                        = 0x000104e3U,
    DISPID_IHTMLELEMENT6_HASATTRIBUTENS                            = 0x000104e4U,
    DISPID_IHTMLELEMENT6_IE9_GETATTRIBUTE                          = 0x000104ecU,
    DISPID_IHTMLELEMENT6_IE9_SETATTRIBUTE                          = 0x000104edU,
    DISPID_IHTMLELEMENT6_IE9_REMOVEATTRIBUTE                       = 0x000104eeU,
    DISPID_IHTMLELEMENT6_IE9_GETATTRIBUTENODE                      = 0x000104e8U,
    DISPID_IHTMLELEMENT6_IE9_SETATTRIBUTENODE                      = 0x000104e9U,
    DISPID_IHTMLELEMENT6_IE9_REMOVEATTRIBUTENODE                   = 0x000104eaU,
    DISPID_IHTMLELEMENT6_IE9_HASATTRIBUTE                          = 0x000104ebU,
    DISPID_IHTMLELEMENT6_GETELEMENTSBYTAGNAMENS                    = 0x000104efU,
    DISPID_IHTMLELEMENT6_IE9_TAGNAME                               = 0x000104f1U,
    DISPID_IHTMLELEMENT6_IE9_NODENAME                              = 0x000104f2U,
    DISPID_IHTMLELEMENT6_GETELEMENTSBYCLASSNAME                    = 0x000104f3U,
    DISPID_IHTMLELEMENT6_MSMATCHESSELECTOR                         = 0x000104feU,
    DISPID_IHTMLELEMENT6_ONABORT                                   = 0x0001178cU,
    DISPID_IHTMLELEMENT6_ONCANPLAY                                 = 0x000117f6U,
    DISPID_IHTMLELEMENT6_ONCANPLAYTHROUGH                          = 0x000117f7U,
    DISPID_IHTMLELEMENT6_ONCHANGE                                  = 0x0001178eU,
    DISPID_IHTMLELEMENT6_ONDURATIONCHANGE                          = 0x000117f8U,
    DISPID_IHTMLELEMENT6_ONEMPTIED                                 = 0x000117f9U,
    DISPID_IHTMLELEMENT6_ONENDED                                   = 0x000117faU,
    DISPID_IHTMLELEMENT6_ONERROR                                   = 0x0001178dU,
    DISPID_IHTMLELEMENT6_ONINPUT                                   = 0x000117efU,
    DISPID_IHTMLELEMENT6_ONLOAD                                    = 0x00011790U,
    DISPID_IHTMLELEMENT6_ONLOADEDDATA                              = 0x000117fbU,
    DISPID_IHTMLELEMENT6_ONLOADEDMETADATA                          = 0x000117fcU,
    DISPID_IHTMLELEMENT6_ONLOADSTART                               = 0x000117fdU,
    DISPID_IHTMLELEMENT6_ONPAUSE                                   = 0x000117feU,
    DISPID_IHTMLELEMENT6_ONPLAY                                    = 0x000117ffU,
    DISPID_IHTMLELEMENT6_ONPLAYING                                 = 0x00011800U,
    DISPID_IHTMLELEMENT6_ONPROGRESS                                = 0x00011801U,
    DISPID_IHTMLELEMENT6_ONRATECHANGE                              = 0x00011802U,
    DISPID_IHTMLELEMENT6_ONRESET                                   = 0x0001177cU,
    DISPID_IHTMLELEMENT6_ONSEEKED                                  = 0x00011803U,
    DISPID_IHTMLELEMENT6_ONSEEKING                                 = 0x00011804U,
    DISPID_IHTMLELEMENT6_ONSELECT                                  = 0x0001177aU,
    DISPID_IHTMLELEMENT6_ONSTALLED                                 = 0x00011805U,
    DISPID_IHTMLELEMENT6_ONSUBMIT                                  = 0x0001177bU,
    DISPID_IHTMLELEMENT6_ONSUSPEND                                 = 0x00011806U,
    DISPID_IHTMLELEMENT6_ONTIMEUPDATE                              = 0x00011807U,
    DISPID_IHTMLELEMENT6_ONVOLUMECHANGE                            = 0x00011808U,
    DISPID_IHTMLELEMENT6_ONWAITING                                 = 0x00011809U,
    DISPID_IHTMLELEMENT6_IE9_HASATTRIBUTES                         = 0x000104ffU,
    DISPID_IHTMLELEMENT7_ONMSPOINTERDOWN                           = 0x0001180aU,
    DISPID_IHTMLELEMENT7_ONMSPOINTERMOVE                           = 0x0001180bU,
    DISPID_IHTMLELEMENT7_ONMSPOINTERUP                             = 0x0001180cU,
    DISPID_IHTMLELEMENT7_ONMSPOINTEROVER                           = 0x0001180dU,
    DISPID_IHTMLELEMENT7_ONMSPOINTEROUT                            = 0x0001180eU,
    DISPID_IHTMLELEMENT7_ONMSPOINTERCANCEL                         = 0x0001180fU,
    DISPID_IHTMLELEMENT7_ONMSPOINTERHOVER                          = 0x00011810U,
    DISPID_IHTMLELEMENT7_ONMSLOSTPOINTERCAPTURE                    = 0x0001181aU,
    DISPID_IHTMLELEMENT7_ONMSGOTPOINTERCAPTURE                     = 0x0001181bU,
    DISPID_IHTMLELEMENT7_ONMSGESTURESTART                          = 0x00011813U,
    DISPID_IHTMLELEMENT7_ONMSGESTURECHANGE                         = 0x00011814U,
    DISPID_IHTMLELEMENT7_ONMSGESTUREEND                            = 0x00011815U,
    DISPID_IHTMLELEMENT7_ONMSGESTUREHOLD                           = 0x00011816U,
    DISPID_IHTMLELEMENT7_ONMSGESTURETAP                            = 0x00011817U,
    DISPID_IHTMLELEMENT7_ONMSGESTUREDOUBLETAP                      = 0x00011818U,
    DISPID_IHTMLELEMENT7_ONMSINERTIASTART                          = 0x00011819U,
    DISPID_IHTMLELEMENT7_MSSETPOINTERCAPTURE                       = 0x00010506U,
    DISPID_IHTMLELEMENT7_MSRELEASEPOINTERCAPTURE                   = 0x00010507U,
    DISPID_IHTMLELEMENT7_ONMSTRANSITIONSTART                       = 0x0001181dU,
    DISPID_IHTMLELEMENT7_ONMSTRANSITIONEND                         = 0x0001181eU,
    DISPID_IHTMLELEMENT7_ONMSANIMATIONSTART                        = 0x0001181fU,
    DISPID_IHTMLELEMENT7_ONMSANIMATIONEND                          = 0x00011820U,
    DISPID_IHTMLELEMENT7_ONMSANIMATIONITERATION                    = 0x00011821U,
    DISPID_IHTMLELEMENT7_ONINVALID                                 = 0x0001182cU,
    DISPID_IHTMLELEMENT7_XMSACCELERATORKEY                         = 0x00010512U,
    DISPID_IHTMLELEMENT7_SPELLCHECK                                = 0x000114fbU,
    DISPID_IHTMLELEMENT7_ONMSMANIPULATIONSTATECHANGED              = 0x00011822U,
    DISPID_IHTMLELEMENT7_ONCUECHANGE                               = 0x00011831U,
    DISPID_IHTMLELEMENTAPPLIEDSTYLES_MSGETRULESAPPLIED             = 0x0001045cU,
    DISPID_IHTMLELEMENTAPPLIEDSTYLES_MSGETRULESAPPLIEDWITHANCESTOR = 0x0001045dU,
}

enum : uint
{
    DISPID_IELEMENTTRAVERSAL_FIRSTELEMENTCHILD      = 0x000104f8U,
    DISPID_IELEMENTTRAVERSAL_LASTELEMENTCHILD       = 0x000104f9U,
    DISPID_IELEMENTTRAVERSAL_PREVIOUSELEMENTSIBLING = 0x000104faU,
    DISPID_IELEMENTTRAVERSAL_NEXTELEMENTSIBLING     = 0x000104fbU,
    DISPID_IELEMENTTRAVERSAL_CHILDELEMENTCOUNT      = 0x000104fcU,
}

enum : uint
{
    DISPID_IHTMLDATABINDING_DATAFLD      = 0x000103fdU,
    DISPID_IHTMLDATABINDING_DATASRC      = 0x000103feU,
    DISPID_IHTMLDATABINDING_DATAFORMATAS = 0x000103ffU,
}

enum : uint
{
    DISPID_HTMLELEMENTEVENTS4_ONABORT         = 0x000003e8U,
    DISPID_HTMLELEMENTEVENTS4_ONCHANGE        = 0x000003e9U,
    DISPID_HTMLELEMENTEVENTS4_ONERROR         = 0x000003eaU,
    DISPID_HTMLELEMENTEVENTS4_ONLOAD          = 0x000003ebU,
    DISPID_HTMLELEMENTEVENTS4_ONRESET         = 0x000003f7U,
    DISPID_HTMLELEMENTEVENTS4_ONSELECT        = 0x000003eeU,
    DISPID_HTMLELEMENTEVENTS4_ONSUBMIT        = 0x000003efU,
    DISPID_HTMLELEMENTEVENTS4_ONMSCONTENTZOOM = 0x0001181cU,
    DISPID_HTMLELEMENTEVENTS3_ONONLINE        = 0x00000428U,
    DISPID_HTMLELEMENTEVENTS3_ONOFFLINE       = 0x00000429U,
    DISPID_HTMLELEMENTEVENTS2_ONHELP          = 0x0001000aU,
}

enum : int
{
    DISPID_HTMLELEMENTEVENTS2_ONCLICK    = 0xfffffda8,
    DISPID_HTMLELEMENTEVENTS2_ONDBLCLICK = 0xfffffda7,
    DISPID_HTMLELEMENTEVENTS2_ONKEYPRESS = 0xfffffda5,
    DISPID_HTMLELEMENTEVENTS2_ONKEYDOWN  = 0xfffffda6,
    DISPID_HTMLELEMENTEVENTS2_ONKEYUP    = 0xfffffda4,
}

enum : uint
{
    DISPID_HTMLELEMENTEVENTS2_ONMOUSEOUT  = 0x00010009U,
    DISPID_HTMLELEMENTEVENTS2_ONMOUSEOVER = 0x00010008U,
}

enum : int
{
    DISPID_HTMLELEMENTEVENTS2_ONMOUSEMOVE = 0xfffffda2,
    DISPID_HTMLELEMENTEVENTS2_ONMOUSEDOWN = 0xfffffda3,
    DISPID_HTMLELEMENTEVENTS2_ONMOUSEUP   = 0xfffffda1,
}

enum : uint
{
    DISPID_HTMLELEMENTEVENTS2_ONSELECTSTART     = 0x0001000cU,
    DISPID_HTMLELEMENTEVENTS2_ONFILTERCHANGE    = 0x00010011U,
    DISPID_HTMLELEMENTEVENTS2_ONDRAGSTART       = 0x0001000bU,
    DISPID_HTMLELEMENTEVENTS2_ONBEFOREUPDATE    = 0x00010004U,
    DISPID_HTMLELEMENTEVENTS2_ONAFTERUPDATE     = 0x00010005U,
    DISPID_HTMLELEMENTEVENTS2_ONERRORUPDATE     = 0x0001000dU,
    DISPID_HTMLELEMENTEVENTS2_ONROWEXIT         = 0x00010006U,
    DISPID_HTMLELEMENTEVENTS2_ONROWENTER        = 0x00010007U,
    DISPID_HTMLELEMENTEVENTS2_ONDATASETCHANGED  = 0x0001000eU,
    DISPID_HTMLELEMENTEVENTS2_ONDATAAVAILABLE   = 0x0001000fU,
    DISPID_HTMLELEMENTEVENTS2_ONDATASETCOMPLETE = 0x00010010U,
    DISPID_HTMLELEMENTEVENTS2_ONLOSECAPTURE     = 0x00010012U,
    DISPID_HTMLELEMENTEVENTS2_ONPROPERTYCHANGE  = 0x00010013U,
    DISPID_HTMLELEMENTEVENTS2_ONSCROLL          = 0x000003f6U,
    DISPID_HTMLELEMENTEVENTS2_ONFOCUS           = 0x00010001U,
    DISPID_HTMLELEMENTEVENTS2_ONRESIZE          = 0x000003f8U,
    DISPID_HTMLELEMENTEVENTS2_ONDRAG            = 0x00010014U,
    DISPID_HTMLELEMENTEVENTS2_ONDRAGEND         = 0x00010015U,
    DISPID_HTMLELEMENTEVENTS2_ONDRAGENTER       = 0x00010016U,
    DISPID_HTMLELEMENTEVENTS2_ONDRAGOVER        = 0x00010017U,
    DISPID_HTMLELEMENTEVENTS2_ONDRAGLEAVE       = 0x00010018U,
    DISPID_HTMLELEMENTEVENTS2_ONDROP            = 0x00010019U,
    DISPID_HTMLELEMENTEVENTS2_ONBEFORECUT       = 0x0001001dU,
    DISPID_HTMLELEMENTEVENTS2_ONCUT             = 0x0001001aU,
    DISPID_HTMLELEMENTEVENTS2_ONBEFORECOPY      = 0x0001001eU,
    DISPID_HTMLELEMENTEVENTS2_ONCOPY            = 0x0001001bU,
    DISPID_HTMLELEMENTEVENTS2_ONBEFOREPASTE     = 0x0001001fU,
    DISPID_HTMLELEMENTEVENTS2_ONPASTE           = 0x0001001cU,
    DISPID_HTMLELEMENTEVENTS2_ONCONTEXTMENU     = 0x000003ffU,
    DISPID_HTMLELEMENTEVENTS2_ONROWSDELETE      = 0x00010020U,
    DISPID_HTMLELEMENTEVENTS2_ONROWSINSERTED    = 0x00010021U,
    DISPID_HTMLELEMENTEVENTS2_ONCELLCHANGE      = 0x00010022U,
}

enum int DISPID_HTMLELEMENTEVENTS2_ONREADYSTATECHANGE = 0xfffffd9f;

enum : uint
{
    DISPID_HTMLELEMENTEVENTS2_ONLAYOUTCOMPLETE   = 0x00000406U,
    DISPID_HTMLELEMENTEVENTS2_ONPAGE             = 0x00000407U,
    DISPID_HTMLELEMENTEVENTS2_ONMOUSEENTER       = 0x00000412U,
    DISPID_HTMLELEMENTEVENTS2_ONMOUSELEAVE       = 0x00000413U,
    DISPID_HTMLELEMENTEVENTS2_ONACTIVATE         = 0x00000414U,
    DISPID_HTMLELEMENTEVENTS2_ONDEACTIVATE       = 0x00000415U,
    DISPID_HTMLELEMENTEVENTS2_ONBEFOREDEACTIVATE = 0x0000040aU,
    DISPID_HTMLELEMENTEVENTS2_ONBEFOREACTIVATE   = 0x00000417U,
    DISPID_HTMLELEMENTEVENTS2_ONFOCUSIN          = 0x00000418U,
    DISPID_HTMLELEMENTEVENTS2_ONFOCUSOUT         = 0x00000419U,
    DISPID_HTMLELEMENTEVENTS2_ONMOVE             = 0x0000040bU,
    DISPID_HTMLELEMENTEVENTS2_ONCONTROLSELECT    = 0x0000040cU,
    DISPID_HTMLELEMENTEVENTS2_ONMOVESTART        = 0x0000040eU,
    DISPID_HTMLELEMENTEVENTS2_ONMOVEEND          = 0x0000040fU,
    DISPID_HTMLELEMENTEVENTS2_ONRESIZESTART      = 0x00000410U,
    DISPID_HTMLELEMENTEVENTS2_ONRESIZEEND        = 0x00000411U,
    DISPID_HTMLELEMENTEVENTS2_ONMOUSEWHEEL       = 0x00000409U,
    DISPID_HTMLELEMENTEVENTS_ONHELP              = 0x0001000aU,
}

enum : int
{
    DISPID_HTMLELEMENTEVENTS_ONCLICK    = 0xfffffda8,
    DISPID_HTMLELEMENTEVENTS_ONDBLCLICK = 0xfffffda7,
    DISPID_HTMLELEMENTEVENTS_ONKEYPRESS = 0xfffffda5,
    DISPID_HTMLELEMENTEVENTS_ONKEYDOWN  = 0xfffffda6,
    DISPID_HTMLELEMENTEVENTS_ONKEYUP    = 0xfffffda4,
}

enum : uint
{
    DISPID_HTMLELEMENTEVENTS_ONMOUSEOUT  = 0x00010009U,
    DISPID_HTMLELEMENTEVENTS_ONMOUSEOVER = 0x00010008U,
}

enum : int
{
    DISPID_HTMLELEMENTEVENTS_ONMOUSEMOVE = 0xfffffda2,
    DISPID_HTMLELEMENTEVENTS_ONMOUSEDOWN = 0xfffffda3,
    DISPID_HTMLELEMENTEVENTS_ONMOUSEUP   = 0xfffffda1,
}

enum : uint
{
    DISPID_HTMLELEMENTEVENTS_ONSELECTSTART     = 0x0001000cU,
    DISPID_HTMLELEMENTEVENTS_ONFILTERCHANGE    = 0x00010011U,
    DISPID_HTMLELEMENTEVENTS_ONDRAGSTART       = 0x0001000bU,
    DISPID_HTMLELEMENTEVENTS_ONBEFOREUPDATE    = 0x00010004U,
    DISPID_HTMLELEMENTEVENTS_ONAFTERUPDATE     = 0x00010005U,
    DISPID_HTMLELEMENTEVENTS_ONERRORUPDATE     = 0x0001000dU,
    DISPID_HTMLELEMENTEVENTS_ONROWEXIT         = 0x00010006U,
    DISPID_HTMLELEMENTEVENTS_ONROWENTER        = 0x00010007U,
    DISPID_HTMLELEMENTEVENTS_ONDATASETCHANGED  = 0x0001000eU,
    DISPID_HTMLELEMENTEVENTS_ONDATAAVAILABLE   = 0x0001000fU,
    DISPID_HTMLELEMENTEVENTS_ONDATASETCOMPLETE = 0x00010010U,
    DISPID_HTMLELEMENTEVENTS_ONLOSECAPTURE     = 0x00010012U,
    DISPID_HTMLELEMENTEVENTS_ONPROPERTYCHANGE  = 0x00010013U,
    DISPID_HTMLELEMENTEVENTS_ONSCROLL          = 0x000003f6U,
    DISPID_HTMLELEMENTEVENTS_ONFOCUS           = 0x00010001U,
    DISPID_HTMLELEMENTEVENTS_ONRESIZE          = 0x000003f8U,
    DISPID_HTMLELEMENTEVENTS_ONDRAG            = 0x00010014U,
    DISPID_HTMLELEMENTEVENTS_ONDRAGEND         = 0x00010015U,
    DISPID_HTMLELEMENTEVENTS_ONDRAGENTER       = 0x00010016U,
    DISPID_HTMLELEMENTEVENTS_ONDRAGOVER        = 0x00010017U,
    DISPID_HTMLELEMENTEVENTS_ONDRAGLEAVE       = 0x00010018U,
    DISPID_HTMLELEMENTEVENTS_ONDROP            = 0x00010019U,
    DISPID_HTMLELEMENTEVENTS_ONBEFORECUT       = 0x0001001dU,
    DISPID_HTMLELEMENTEVENTS_ONCUT             = 0x0001001aU,
    DISPID_HTMLELEMENTEVENTS_ONBEFORECOPY      = 0x0001001eU,
    DISPID_HTMLELEMENTEVENTS_ONCOPY            = 0x0001001bU,
    DISPID_HTMLELEMENTEVENTS_ONBEFOREPASTE     = 0x0001001fU,
    DISPID_HTMLELEMENTEVENTS_ONPASTE           = 0x0001001cU,
    DISPID_HTMLELEMENTEVENTS_ONCONTEXTMENU     = 0x000003ffU,
    DISPID_HTMLELEMENTEVENTS_ONROWSDELETE      = 0x00010020U,
    DISPID_HTMLELEMENTEVENTS_ONROWSINSERTED    = 0x00010021U,
    DISPID_HTMLELEMENTEVENTS_ONCELLCHANGE      = 0x00010022U,
}

enum int DISPID_HTMLELEMENTEVENTS_ONREADYSTATECHANGE = 0xfffffd9f;

enum : uint
{
    DISPID_HTMLELEMENTEVENTS_ONBEFOREEDITFOCUS  = 0x00000403U,
    DISPID_HTMLELEMENTEVENTS_ONLAYOUTCOMPLETE   = 0x00000406U,
    DISPID_HTMLELEMENTEVENTS_ONPAGE             = 0x00000407U,
    DISPID_HTMLELEMENTEVENTS_ONBEFOREDEACTIVATE = 0x0000040aU,
    DISPID_HTMLELEMENTEVENTS_ONBEFOREACTIVATE   = 0x00000417U,
    DISPID_HTMLELEMENTEVENTS_ONMOVE             = 0x0000040bU,
    DISPID_HTMLELEMENTEVENTS_ONCONTROLSELECT    = 0x0000040cU,
    DISPID_HTMLELEMENTEVENTS_ONMOVESTART        = 0x0000040eU,
    DISPID_HTMLELEMENTEVENTS_ONMOVEEND          = 0x0000040fU,
    DISPID_HTMLELEMENTEVENTS_ONRESIZESTART      = 0x00000410U,
    DISPID_HTMLELEMENTEVENTS_ONRESIZEEND        = 0x00000411U,
    DISPID_HTMLELEMENTEVENTS_ONMOUSEENTER       = 0x00000412U,
    DISPID_HTMLELEMENTEVENTS_ONMOUSELEAVE       = 0x00000413U,
    DISPID_HTMLELEMENTEVENTS_ONMOUSEWHEEL       = 0x00000409U,
    DISPID_HTMLELEMENTEVENTS_ONACTIVATE         = 0x00000414U,
    DISPID_HTMLELEMENTEVENTS_ONDEACTIVATE       = 0x00000415U,
    DISPID_HTMLELEMENTEVENTS_ONFOCUSIN          = 0x00000418U,
    DISPID_HTMLELEMENTEVENTS_ONFOCUSOUT         = 0x00000419U,
}

enum : uint
{
    DISPID_IHTMLELEMENTDEFAULTS_STYLE            = 0x000003e9U,
    DISPID_IHTMLELEMENTDEFAULTS_TABSTOP          = 0x000003eaU,
    DISPID_IHTMLELEMENTDEFAULTS_VIEWINHERITSTYLE = 0x0001144fU,
    DISPID_IHTMLELEMENTDEFAULTS_VIEWMASTERTAB    = 0x000003eeU,
    DISPID_IHTMLELEMENTDEFAULTS_SCROLLSEGMENTX   = 0x000003ebU,
    DISPID_IHTMLELEMENTDEFAULTS_SCROLLSEGMENTY   = 0x000003ecU,
    DISPID_IHTMLELEMENTDEFAULTS_ISMULTILINE      = 0x000003f0U,
    DISPID_IHTMLELEMENTDEFAULTS_CONTENTEDITABLE  = 0x0001142aU,
    DISPID_IHTMLELEMENTDEFAULTS_CANHAVEHTML      = 0x000003f1U,
    DISPID_IHTMLELEMENTDEFAULTS_VIEWLINK         = 0x000003f3U,
    DISPID_IHTMLELEMENTDEFAULTS_FROZEN           = 0x0001144eU,
}

enum : uint
{
    DISPID_IHTCDEFAULTDISPATCH_ELEMENT           = 0x00011417U,
    DISPID_IHTCDEFAULTDISPATCH_CREATEEVENTOBJECT = 0x00011418U,
    DISPID_IHTCDEFAULTDISPATCH_DEFAULTS          = 0x0001142dU,
    DISPID_IHTCDEFAULTDISPATCH_DOCUMENT          = 0x00011416U,
}

enum : uint
{
    DISPID_IHTCPROPERTYBEHAVIOR_FIRECHANGE = 0x000101f4U,
    DISPID_IHTCPROPERTYBEHAVIOR_VALUE      = 0x00011415U,
}

enum uint DISPID_IHTCEVENTBEHAVIOR_FIRE = 0x000101f4U;

enum : uint
{
    DISPID_IHTCATTACHBEHAVIOR_FIREEVENT   = 0x00000000U,
    DISPID_IHTCATTACHBEHAVIOR_DETACHEVENT = 0x000101f4U,
    DISPID_IHTCATTACHBEHAVIOR2_FIREEVENT  = 0x00000000U,
}

enum : uint
{
    DISPID_IHTCDESCBEHAVIOR_URN  = 0x000101f4U,
    DISPID_IHTCDESCBEHAVIOR_NAME = 0x000101f5U,
}

enum : uint
{
    DISPID_IHTMLURNCOLLECTION_LENGTH = 0x000003e9U,
    DISPID_IHTMLURNCOLLECTION_ITEM   = 0x00000000U,
}

enum : uint
{
    DISPID_IHTMLGENERICELEMENT_RECORDSET      = 0x000003e9U,
    DISPID_IHTMLGENERICELEMENT_NAMEDRECORDSET = 0x000003eaU,
}

enum : uint
{
    DISPID_IHTMLSTYLESHEETRULE_SELECTORTEXT            = 0x000003e9U,
    DISPID_IHTMLSTYLESHEETRULE_STYLE                   = 0x0001004aU,
    DISPID_IHTMLSTYLESHEETRULE_READONLY                = 0x000003eaU,
    DISPID_IHTMLSTYLESHEETRULEAPPLIED_MSSPECIFICITY    = 0x000003ebU,
    DISPID_IHTMLSTYLESHEETRULEAPPLIED_MSGETSPECIFICITY = 0x000003ecU,
    DISPID_IHTMLSTYLESHEETRULE2_IE9_SELECTORTEXT       = 0x000003edU,
    DISPID_IHTMLSTYLESHEETRULESCOLLECTION_LENGTH       = 0x000003e9U,
    DISPID_IHTMLSTYLESHEETRULESCOLLECTION_ITEM         = 0x00000000U,
    DISPID_IHTMLSTYLESHEETRULESCOLLECTION2_IE9_LENGTH  = 0x000003ebU,
    DISPID_IHTMLSTYLESHEETRULESCOLLECTION2_IE9_ITEM    = 0x000003eaU,
    DISPID_IHTMLSTYLESHEETPAGE_SELECTOR                = 0x000003e9U,
    DISPID_IHTMLSTYLESHEETPAGE_PSEUDOCLASS             = 0x000003eaU,
    DISPID_IHTMLSTYLESHEETPAGE2_SELECTORTEXT           = 0x000003ebU,
    DISPID_IHTMLSTYLESHEETPAGE2_STYLE                  = 0x0001004aU,
    DISPID_IHTMLSTYLESHEETPAGESCOLLECTION_LENGTH       = 0x000003e9U,
    DISPID_IHTMLSTYLESHEETPAGESCOLLECTION_ITEM         = 0x00000000U,
    DISPID_IHTMLSTYLESHEET_TITLE                       = 0x000003e9U,
    DISPID_IHTMLSTYLESHEET_PARENTSTYLESHEET            = 0x000003eaU,
    DISPID_IHTMLSTYLESHEET_OWNINGELEMENT               = 0x000003ebU,
    DISPID_IHTMLSTYLESHEET_DISABLED                    = 0x0001004cU,
    DISPID_IHTMLSTYLESHEET_READONLY                    = 0x000003ecU,
    DISPID_IHTMLSTYLESHEET_IMPORTS                     = 0x000003edU,
    DISPID_IHTMLSTYLESHEET_HREF                        = 0x000003eeU,
    DISPID_IHTMLSTYLESHEET_TYPE                        = 0x000003efU,
    DISPID_IHTMLSTYLESHEET_ID                          = 0x000003f0U,
    DISPID_IHTMLSTYLESHEET_ADDIMPORT                   = 0x000003f1U,
    DISPID_IHTMLSTYLESHEET_ADDRULE                     = 0x000003f2U,
    DISPID_IHTMLSTYLESHEET_REMOVEIMPORT                = 0x000003f3U,
    DISPID_IHTMLSTYLESHEET_REMOVERULE                  = 0x000003f4U,
    DISPID_IHTMLSTYLESHEET_MEDIA                       = 0x000003f5U,
    DISPID_IHTMLSTYLESHEET_CSSTEXT                     = 0x000003f6U,
    DISPID_IHTMLSTYLESHEET_RULES                       = 0x000003f7U,
    DISPID_IHTMLSTYLESHEET2_PAGES                      = 0x000003f8U,
    DISPID_IHTMLSTYLESHEET2_ADDPAGERULE                = 0x000003f9U,
    DISPID_IHTMLSTYLESHEET3_IE8_HREF                   = 0x0000047eU,
    DISPID_IHTMLSTYLESHEET3_ISALTERNATE                = 0x0000047fU,
    DISPID_IHTMLSTYLESHEET3_ISPREFALTERNATE            = 0x00000480U,
    DISPID_IHTMLSTYLESHEET4_IE9_TYPE                   = 0x00000481U,
    DISPID_IHTMLSTYLESHEET4_IE9_HREF                   = 0x00000482U,
    DISPID_IHTMLSTYLESHEET4_IE9_TITLE                  = 0x00000483U,
    DISPID_IHTMLSTYLESHEET4_OWNERNODE                  = 0x00000484U,
    DISPID_IHTMLSTYLESHEET4_OWNERRULE                  = 0x00000485U,
    DISPID_IHTMLSTYLESHEET4_CSSRULES                   = 0x00000486U,
    DISPID_IHTMLSTYLESHEET4_IE9_MEDIA                  = 0x00000487U,
    DISPID_IHTMLSTYLESHEET4_INSERTRULE                 = 0x00000488U,
    DISPID_IHTMLSTYLESHEET4_DELETERULE                 = 0x00000489U,
    DISPID_IHTMLSTYLESHEETSCOLLECTION_LENGTH           = 0x000003e9U,
}

enum int DISPID_IHTMLSTYLESHEETSCOLLECTION__NEWENUM = 0xfffffffc;

enum : uint
{
    DISPID_IHTMLSTYLESHEETSCOLLECTION_ITEM      = 0x00000000U,
    DISPID_IHTMLSTYLESHEETSCOLLECTION2_IE9_ITEM = 0x000003eaU,
}

enum : uint
{
    DISPID_IHTMLLINKELEMENT_HREF               = 0x000003edU,
    DISPID_IHTMLLINKELEMENT_REL                = 0x000003eeU,
    DISPID_IHTMLLINKELEMENT_REV                = 0x000003efU,
    DISPID_IHTMLLINKELEMENT_TYPE               = 0x000003f0U,
    DISPID_IHTMLLINKELEMENT_READYSTATE         = 0x000113fcU,
    DISPID_IHTMLLINKELEMENT_ONREADYSTATECHANGE = 0x00011789U,
    DISPID_IHTMLLINKELEMENT_ONLOAD             = 0x00011790U,
    DISPID_IHTMLLINKELEMENT_ONERROR            = 0x0001178dU,
    DISPID_IHTMLLINKELEMENT_STYLESHEET         = 0x000003f6U,
    DISPID_IHTMLLINKELEMENT_DISABLED           = 0x0001004cU,
    DISPID_IHTMLLINKELEMENT_MEDIA              = 0x000003f8U,
    DISPID_IHTMLLINKELEMENT2_TARGET            = 0x000003f9U,
    DISPID_IHTMLLINKELEMENT3_CHARSET           = 0x000003faU,
    DISPID_IHTMLLINKELEMENT3_HREFLANG          = 0x000003fbU,
    DISPID_IHTMLLINKELEMENT4_IE8_HREF          = 0x0000047eU,
    DISPID_IHTMLLINKELEMENT5_SHEET             = 0x000003fcU,
}

enum : uint
{
    DISPID_HTMLLINKELEMENTEVENTS2_ONLOAD  = 0x000003ebU,
    DISPID_HTMLLINKELEMENTEVENTS2_ONERROR = 0x000003eaU,
    DISPID_HTMLLINKELEMENTEVENTS_ONLOAD   = 0x000003ebU,
    DISPID_HTMLLINKELEMENTEVENTS_ONERROR  = 0x000003eaU,
}

enum : uint
{
    DISPID_IHTMLTXTRANGE_HTMLTEXT              = 0x000003ebU,
    DISPID_IHTMLTXTRANGE_TEXT                  = 0x000003ecU,
    DISPID_IHTMLTXTRANGE_PARENTELEMENT         = 0x000003eeU,
    DISPID_IHTMLTXTRANGE_DUPLICATE             = 0x000003f0U,
    DISPID_IHTMLTXTRANGE_INRANGE               = 0x000003f2U,
    DISPID_IHTMLTXTRANGE_ISEQUAL               = 0x000003f3U,
    DISPID_IHTMLTXTRANGE_SCROLLINTOVIEW        = 0x000003f4U,
    DISPID_IHTMLTXTRANGE_COLLAPSE              = 0x000003f5U,
    DISPID_IHTMLTXTRANGE_EXPAND                = 0x000003f6U,
    DISPID_IHTMLTXTRANGE_MOVE                  = 0x000003f7U,
    DISPID_IHTMLTXTRANGE_MOVESTART             = 0x000003f8U,
    DISPID_IHTMLTXTRANGE_MOVEEND               = 0x000003f9U,
    DISPID_IHTMLTXTRANGE_SELECT                = 0x00000400U,
    DISPID_IHTMLTXTRANGE_PASTEHTML             = 0x00000402U,
    DISPID_IHTMLTXTRANGE_MOVETOELEMENTTEXT     = 0x000003e9U,
    DISPID_IHTMLTXTRANGE_SETENDPOINT           = 0x00000401U,
    DISPID_IHTMLTXTRANGE_COMPAREENDPOINTS      = 0x000003faU,
    DISPID_IHTMLTXTRANGE_FINDTEXT              = 0x000003fbU,
    DISPID_IHTMLTXTRANGE_MOVETOPOINT           = 0x000003fcU,
    DISPID_IHTMLTXTRANGE_GETBOOKMARK           = 0x000003fdU,
    DISPID_IHTMLTXTRANGE_MOVETOBOOKMARK        = 0x000003f1U,
    DISPID_IHTMLTXTRANGE_QUERYCOMMANDSUPPORTED = 0x00000403U,
    DISPID_IHTMLTXTRANGE_QUERYCOMMANDENABLED   = 0x00000404U,
    DISPID_IHTMLTXTRANGE_QUERYCOMMANDSTATE     = 0x00000405U,
    DISPID_IHTMLTXTRANGE_QUERYCOMMANDINDETERM  = 0x00000406U,
    DISPID_IHTMLTXTRANGE_QUERYCOMMANDTEXT      = 0x00000407U,
    DISPID_IHTMLTXTRANGE_QUERYCOMMANDVALUE     = 0x00000408U,
    DISPID_IHTMLTXTRANGE_EXECCOMMAND           = 0x00000409U,
    DISPID_IHTMLTXTRANGE_EXECCOMMANDSHOWHELP   = 0x0000040aU,
}

enum : uint
{
    DISPID_IHTMLTEXTRANGEMETRICS_OFFSETTOP              = 0x0000040bU,
    DISPID_IHTMLTEXTRANGEMETRICS_OFFSETLEFT             = 0x0000040cU,
    DISPID_IHTMLTEXTRANGEMETRICS_BOUNDINGTOP            = 0x0000040dU,
    DISPID_IHTMLTEXTRANGEMETRICS_BOUNDINGLEFT           = 0x0000040eU,
    DISPID_IHTMLTEXTRANGEMETRICS_BOUNDINGWIDTH          = 0x0000040fU,
    DISPID_IHTMLTEXTRANGEMETRICS_BOUNDINGHEIGHT         = 0x00000410U,
    DISPID_IHTMLTEXTRANGEMETRICS2_GETCLIENTRECTS        = 0x00000411U,
    DISPID_IHTMLTEXTRANGEMETRICS2_GETBOUNDINGCLIENTRECT = 0x00000412U,
}

enum uint DISPID_IHTMLTXTRANGECOLLECTION_LENGTH = 0x000005dcU;
enum int DISPID_IHTMLTXTRANGECOLLECTION__NEWENUM = 0xfffffffc;
enum uint DISPID_IHTMLTXTRANGECOLLECTION_ITEM = 0x00000000U;

enum : uint
{
    DISPID_IHTMLDOMRANGE_STARTCONTAINER          = 0x000003e9U,
    DISPID_IHTMLDOMRANGE_STARTOFFSET             = 0x000003eaU,
    DISPID_IHTMLDOMRANGE_ENDCONTAINER            = 0x000003ebU,
    DISPID_IHTMLDOMRANGE_ENDOFFSET               = 0x000003ecU,
    DISPID_IHTMLDOMRANGE_COLLAPSED               = 0x000003edU,
    DISPID_IHTMLDOMRANGE_COMMONANCESTORCONTAINER = 0x000003eeU,
    DISPID_IHTMLDOMRANGE_SETSTART                = 0x000003efU,
    DISPID_IHTMLDOMRANGE_SETEND                  = 0x000003f0U,
    DISPID_IHTMLDOMRANGE_SETSTARTBEFORE          = 0x000003f1U,
    DISPID_IHTMLDOMRANGE_SETSTARTAFTER           = 0x000003f2U,
    DISPID_IHTMLDOMRANGE_SETENDBEFORE            = 0x000003f3U,
    DISPID_IHTMLDOMRANGE_SETENDAFTER             = 0x000003f4U,
    DISPID_IHTMLDOMRANGE_COLLAPSE                = 0x000003f5U,
    DISPID_IHTMLDOMRANGE_SELECTNODE              = 0x000003f6U,
    DISPID_IHTMLDOMRANGE_SELECTNODECONTENTS      = 0x000003f7U,
    DISPID_IHTMLDOMRANGE_COMPAREBOUNDARYPOINTS   = 0x000003f8U,
    DISPID_IHTMLDOMRANGE_DELETECONTENTS          = 0x000003f9U,
    DISPID_IHTMLDOMRANGE_EXTRACTCONTENTS         = 0x000003faU,
    DISPID_IHTMLDOMRANGE_CLONECONTENTS           = 0x000003fbU,
    DISPID_IHTMLDOMRANGE_INSERTNODE              = 0x000003fcU,
    DISPID_IHTMLDOMRANGE_SURROUNDCONTENTS        = 0x000003fdU,
    DISPID_IHTMLDOMRANGE_CLONERANGE              = 0x000003feU,
    DISPID_IHTMLDOMRANGE_TOSTRING                = 0x000003ffU,
    DISPID_IHTMLDOMRANGE_DETACH                  = 0x00000400U,
    DISPID_IHTMLDOMRANGE_GETCLIENTRECTS          = 0x00000401U,
    DISPID_IHTMLDOMRANGE_GETBOUNDINGCLIENTRECT   = 0x00000402U,
}

enum : uint
{
    DISPID_IHTMLFORMELEMENT_ACTION   = 0x000003e9U,
    DISPID_IHTMLFORMELEMENT_DIR      = 0x000113fdU,
    DISPID_IHTMLFORMELEMENT_ENCODING = 0x000003ebU,
    DISPID_IHTMLFORMELEMENT_METHOD   = 0x000003ecU,
    DISPID_IHTMLFORMELEMENT_ELEMENTS = 0x000003edU,
    DISPID_IHTMLFORMELEMENT_TARGET   = 0x000003eeU,
    DISPID_IHTMLFORMELEMENT_NAME     = 0x00010000U,
    DISPID_IHTMLFORMELEMENT_ONSUBMIT = 0x0001177bU,
    DISPID_IHTMLFORMELEMENT_ONRESET  = 0x0001177cU,
    DISPID_IHTMLFORMELEMENT_SUBMIT   = 0x000003f1U,
    DISPID_IHTMLFORMELEMENT_RESET    = 0x000003f2U,
    DISPID_IHTMLFORMELEMENT_LENGTH   = 0x000005dcU,
}

enum int DISPID_IHTMLFORMELEMENT__NEWENUM = 0xfffffffc;

enum : uint
{
    DISPID_IHTMLFORMELEMENT_ITEM           = 0x00000000U,
    DISPID_IHTMLFORMELEMENT_TAGS           = 0x000005deU,
    DISPID_IHTMLFORMELEMENT2_ACCEPTCHARSET = 0x000003f3U,
    DISPID_IHTMLFORMELEMENT2_URNS          = 0x000005e1U,
    DISPID_IHTMLFORMELEMENT3_NAMEDITEM     = 0x000005e2U,
}

enum : uint
{
    DISPID_IHTMLSUBMITDATA_APPENDNAMEVALUEPAIR = 0x000003f4U,
    DISPID_IHTMLSUBMITDATA_APPENDNAMEFILEPAIR  = 0x000003f5U,
    DISPID_IHTMLSUBMITDATA_APPENDITEMSEPARATOR = 0x000003f6U,
}

enum uint DISPID_IHTMLFORMELEMENT4_IE8_ACTION = 0x0000047eU;

enum : uint
{
    DISPID_HTMLFORMELEMENTEVENTS2_ONSUBMIT = 0x000003efU,
    DISPID_HTMLFORMELEMENTEVENTS2_ONRESET  = 0x000003f7U,
    DISPID_HTMLFORMELEMENTEVENTS_ONSUBMIT  = 0x000003efU,
    DISPID_HTMLFORMELEMENTEVENTS_ONRESET   = 0x000003f7U,
}

enum : uint
{
    DISPID_IHTMLCONTROLELEMENT_TABINDEX     = 0x0001000fU,
    DISPID_IHTMLCONTROLELEMENT_FOCUS        = 0x000107d0U,
    DISPID_IHTMLCONTROLELEMENT_ACCESSKEY    = 0x000107d5U,
    DISPID_IHTMLCONTROLELEMENT_ONBLUR       = 0x0001177fU,
    DISPID_IHTMLCONTROLELEMENT_ONFOCUS      = 0x0001177eU,
    DISPID_IHTMLCONTROLELEMENT_ONRESIZE     = 0x00011794U,
    DISPID_IHTMLCONTROLELEMENT_BLUR         = 0x000107d2U,
    DISPID_IHTMLCONTROLELEMENT_ADDFILTER    = 0x000107e1U,
    DISPID_IHTMLCONTROLELEMENT_REMOVEFILTER = 0x000107e2U,
    DISPID_IHTMLCONTROLELEMENT_CLIENTHEIGHT = 0x000107e3U,
    DISPID_IHTMLCONTROLELEMENT_CLIENTWIDTH  = 0x000107e4U,
    DISPID_IHTMLCONTROLELEMENT_CLIENTTOP    = 0x000107e5U,
    DISPID_IHTMLCONTROLELEMENT_CLIENTLEFT   = 0x000107e6U,
}

enum : uint
{
    DISPID_IHTMLTEXTCONTAINER_CREATECONTROLRANGE = 0x000003e9U,
    DISPID_IHTMLTEXTCONTAINER_SCROLLHEIGHT       = 0x000003eaU,
    DISPID_IHTMLTEXTCONTAINER_SCROLLWIDTH        = 0x000003ebU,
    DISPID_IHTMLTEXTCONTAINER_SCROLLTOP          = 0x000003ecU,
    DISPID_IHTMLTEXTCONTAINER_SCROLLLEFT         = 0x000003edU,
    DISPID_IHTMLTEXTCONTAINER_ONSCROLL           = 0x0001178fU,
}

enum : uint
{
    DISPID_HTMLTEXTCONTAINEREVENTS2_ONCHANGE = 0x000003e9U,
    DISPID_HTMLTEXTCONTAINEREVENTS2_ONSELECT = 0x000003eeU,
    DISPID_HTMLTEXTCONTAINEREVENTS_ONCHANGE  = 0x000003e9U,
    DISPID_HTMLTEXTCONTAINEREVENTS_ONSELECT  = 0x000003eeU,
}

enum : uint
{
    DISPID_IHTMLCONTROLRANGE_SELECT                = 0x000003eaU,
    DISPID_IHTMLCONTROLRANGE_ADD                   = 0x000003ebU,
    DISPID_IHTMLCONTROLRANGE_REMOVE                = 0x000003ecU,
    DISPID_IHTMLCONTROLRANGE_ITEM                  = 0x00000000U,
    DISPID_IHTMLCONTROLRANGE_SCROLLINTOVIEW        = 0x000003eeU,
    DISPID_IHTMLCONTROLRANGE_QUERYCOMMANDSUPPORTED = 0x000003efU,
    DISPID_IHTMLCONTROLRANGE_QUERYCOMMANDENABLED   = 0x000003f0U,
    DISPID_IHTMLCONTROLRANGE_QUERYCOMMANDSTATE     = 0x000003f1U,
    DISPID_IHTMLCONTROLRANGE_QUERYCOMMANDINDETERM  = 0x000003f2U,
    DISPID_IHTMLCONTROLRANGE_QUERYCOMMANDTEXT      = 0x000003f3U,
    DISPID_IHTMLCONTROLRANGE_QUERYCOMMANDVALUE     = 0x000003f4U,
    DISPID_IHTMLCONTROLRANGE_EXECCOMMAND           = 0x000003f5U,
    DISPID_IHTMLCONTROLRANGE_EXECCOMMANDSHOWHELP   = 0x000003f6U,
    DISPID_IHTMLCONTROLRANGE_COMMONPARENTELEMENT   = 0x000003f7U,
    DISPID_IHTMLCONTROLRANGE_LENGTH                = 0x000003edU,
    DISPID_IHTMLCONTROLRANGE2_ADDELEMENT           = 0x000003f8U,
}

enum : uint
{
    DISPID_IHTMLIMGELEMENT_ISMAP            = 0x000007d2U,
    DISPID_IHTMLIMGELEMENT_USEMAP           = 0x000007d8U,
    DISPID_IHTMLIMGELEMENT_MIMETYPE         = 0x000007daU,
    DISPID_IHTMLIMGELEMENT_FILESIZE         = 0x000007dbU,
    DISPID_IHTMLIMGELEMENT_FILECREATEDDATE  = 0x000007dcU,
    DISPID_IHTMLIMGELEMENT_FILEMODIFIEDDATE = 0x000007ddU,
    DISPID_IHTMLIMGELEMENT_FILEUPDATEDDATE  = 0x000007deU,
    DISPID_IHTMLIMGELEMENT_PROTOCOL         = 0x000007dfU,
    DISPID_IHTMLIMGELEMENT_HREF             = 0x000007e0U,
    DISPID_IHTMLIMGELEMENT_NAMEPROP         = 0x000007e1U,
    DISPID_IHTMLIMGELEMENT_BORDER           = 0x000003ecU,
    DISPID_IHTMLIMGELEMENT_VSPACE           = 0x000003edU,
    DISPID_IHTMLIMGELEMENT_HSPACE           = 0x000003eeU,
    DISPID_IHTMLIMGELEMENT_ALT              = 0x000003eaU,
    DISPID_IHTMLIMGELEMENT_SRC              = 0x000003ebU,
    DISPID_IHTMLIMGELEMENT_LOWSRC           = 0x000003efU,
    DISPID_IHTMLIMGELEMENT_VRML             = 0x000003f0U,
    DISPID_IHTMLIMGELEMENT_DYNSRC           = 0x000003f1U,
    DISPID_IHTMLIMGELEMENT_READYSTATE       = 0x000113fcU,
    DISPID_IHTMLIMGELEMENT_COMPLETE         = 0x000003f2U,
    DISPID_IHTMLIMGELEMENT_LOOP             = 0x000003f3U,
    DISPID_IHTMLIMGELEMENT_ALIGN            = 0x00010049U,
    DISPID_IHTMLIMGELEMENT_ONLOAD           = 0x00011790U,
    DISPID_IHTMLIMGELEMENT_ONERROR          = 0x0001178dU,
    DISPID_IHTMLIMGELEMENT_ONABORT          = 0x0001178cU,
    DISPID_IHTMLIMGELEMENT_NAME             = 0x00010000U,
    DISPID_IHTMLIMGELEMENT_WIDTH            = 0x00010005U,
    DISPID_IHTMLIMGELEMENT_HEIGHT           = 0x00010006U,
    DISPID_IHTMLIMGELEMENT_START            = 0x000003f5U,
    DISPID_IHTMLIMGELEMENT2_LONGDESC        = 0x000007e3U,
    DISPID_IHTMLIMGELEMENT3_IE8_LONGDESC    = 0x0000047fU,
    DISPID_IHTMLIMGELEMENT3_IE8_VRML        = 0x00000480U,
    DISPID_IHTMLIMGELEMENT3_IE8_LOWSRC      = 0x00000481U,
    DISPID_IHTMLIMGELEMENT3_IE8_DYNSRC      = 0x00000482U,
    DISPID_IHTMLIMGELEMENT4_NATURALWIDTH    = 0x00000483U,
    DISPID_IHTMLIMGELEMENT4_NATURALHEIGHT   = 0x00000484U,
}

enum : uint
{
    DISPID_IHTMLMSIMGELEMENT_MSPLAYTODISABLED = 0x00000485U,
    DISPID_IHTMLMSIMGELEMENT_MSPLAYTOPRIMARY  = 0x00000486U,
}

enum uint DISPID_IHTMLIMAGEELEMENTFACTORY_CREATE = 0x00000000U;

enum : uint
{
    DISPID_HTMLIMGEVENTS2_ONLOAD  = 0x000003ebU,
    DISPID_HTMLIMGEVENTS2_ONERROR = 0x000003eaU,
    DISPID_HTMLIMGEVENTS2_ONABORT = 0x000003e8U,
    DISPID_HTMLIMGEVENTS_ONLOAD   = 0x000003ebU,
    DISPID_HTMLIMGEVENTS_ONERROR  = 0x000003eaU,
    DISPID_HTMLIMGEVENTS_ONABORT  = 0x000003e8U,
}

enum : uint
{
    DISPID_IHTMLBODYELEMENT_BACKGROUND   = 0x00011389U,
    DISPID_IHTMLBODYELEMENT_BGPROPERTIES = 0x000113b5U,
    DISPID_IHTMLBODYELEMENT_LEFTMARGIN   = 0x000113b0U,
    DISPID_IHTMLBODYELEMENT_TOPMARGIN    = 0x000113adU,
    DISPID_IHTMLBODYELEMENT_RIGHTMARGIN  = 0x000113aeU,
    DISPID_IHTMLBODYELEMENT_BOTTOMMARGIN = 0x000113afU,
    DISPID_IHTMLBODYELEMENT_NOWRAP       = 0x0001138dU,
}

enum int DISPID_IHTMLBODYELEMENT_BGCOLOR = 0xfffffe0b;

enum : uint
{
    DISPID_IHTMLBODYELEMENT_TEXT            = 0x0001138aU,
    DISPID_IHTMLBODYELEMENT_LINK            = 0x000007daU,
    DISPID_IHTMLBODYELEMENT_VLINK           = 0x000007dcU,
    DISPID_IHTMLBODYELEMENT_ALINK           = 0x000007dbU,
    DISPID_IHTMLBODYELEMENT_ONLOAD          = 0x00011790U,
    DISPID_IHTMLBODYELEMENT_ONUNLOAD        = 0x00011791U,
    DISPID_IHTMLBODYELEMENT_SCROLL          = 0x000113d7U,
    DISPID_IHTMLBODYELEMENT_ONSELECT        = 0x0001177aU,
    DISPID_IHTMLBODYELEMENT_ONBEFOREUNLOAD  = 0x00011797U,
    DISPID_IHTMLBODYELEMENT_CREATETEXTRANGE = 0x000007ddU,
    DISPID_IHTMLBODYELEMENT2_ONBEFOREPRINT  = 0x000117b2U,
    DISPID_IHTMLBODYELEMENT2_ONAFTERPRINT   = 0x000117b3U,
    DISPID_IHTMLBODYELEMENT3_IE8_BACKGROUND = 0x0000047eU,
    DISPID_IHTMLBODYELEMENT3_ONONLINE       = 0x000117dbU,
    DISPID_IHTMLBODYELEMENT3_ONOFFLINE      = 0x000117dcU,
    DISPID_IHTMLBODYELEMENT3_ONHASHCHANGE   = 0x000117ddU,
    DISPID_IHTMLBODYELEMENT4_ONMESSAGE      = 0x000117deU,
    DISPID_IHTMLBODYELEMENT4_ONSTORAGE      = 0x000117d4U,
    DISPID_IHTMLBODYELEMENT5_ONPOPSTATE     = 0x00011830U,
}

enum : uint
{
    DISPID_IHTMLFONTELEMENT_COLOR          = 0x0001138aU,
    DISPID_IHTMLFONTELEMENT_FACE           = 0x0001139aU,
    DISPID_IHTMLFONTELEMENT_SIZE           = 0x0001139bU,
    DISPID_IHTMLANCHORELEMENT_HREF         = 0x00000000U,
    DISPID_IHTMLANCHORELEMENT_TARGET       = 0x000003ebU,
    DISPID_IHTMLANCHORELEMENT_REL          = 0x000003edU,
    DISPID_IHTMLANCHORELEMENT_REV          = 0x000003eeU,
    DISPID_IHTMLANCHORELEMENT_URN          = 0x000003efU,
    DISPID_IHTMLANCHORELEMENT_METHODS      = 0x000003f0U,
    DISPID_IHTMLANCHORELEMENT_NAME         = 0x00010000U,
    DISPID_IHTMLANCHORELEMENT_HOST         = 0x000003f4U,
    DISPID_IHTMLANCHORELEMENT_HOSTNAME     = 0x000003f5U,
    DISPID_IHTMLANCHORELEMENT_PATHNAME     = 0x000003f6U,
    DISPID_IHTMLANCHORELEMENT_PORT         = 0x000003f7U,
    DISPID_IHTMLANCHORELEMENT_PROTOCOL     = 0x000003f8U,
    DISPID_IHTMLANCHORELEMENT_SEARCH       = 0x000003f9U,
    DISPID_IHTMLANCHORELEMENT_HASH         = 0x000003faU,
    DISPID_IHTMLANCHORELEMENT_ONBLUR       = 0x0001177fU,
    DISPID_IHTMLANCHORELEMENT_ONFOCUS      = 0x0001177eU,
    DISPID_IHTMLANCHORELEMENT_ACCESSKEY    = 0x000107d5U,
    DISPID_IHTMLANCHORELEMENT_PROTOCOLLONG = 0x00000407U,
    DISPID_IHTMLANCHORELEMENT_MIMETYPE     = 0x00000406U,
    DISPID_IHTMLANCHORELEMENT_NAMEPROP     = 0x00000408U,
    DISPID_IHTMLANCHORELEMENT_TABINDEX     = 0x0001000fU,
    DISPID_IHTMLANCHORELEMENT_FOCUS        = 0x000107d0U,
    DISPID_IHTMLANCHORELEMENT_BLUR         = 0x000107d2U,
    DISPID_IHTMLANCHORELEMENT2_CHARSET     = 0x000003ffU,
    DISPID_IHTMLANCHORELEMENT2_COORDS      = 0x00000400U,
    DISPID_IHTMLANCHORELEMENT2_HREFLANG    = 0x00000401U,
    DISPID_IHTMLANCHORELEMENT2_SHAPE       = 0x00000402U,
    DISPID_IHTMLANCHORELEMENT2_TYPE        = 0x00000403U,
    DISPID_IHTMLANCHORELEMENT3_IE8_SHAPE   = 0x0000047fU,
    DISPID_IHTMLANCHORELEMENT3_IE8_COORDS  = 0x00000480U,
    DISPID_IHTMLANCHORELEMENT3_IE8_HREF    = 0x00000481U,
}

enum : uint
{
    DISPID_IHTMLLABELELEMENT_HTMLFOR   = 0x000003e8U,
    DISPID_IHTMLLABELELEMENT_ACCESSKEY = 0x000107d5U,
    DISPID_IHTMLLABELELEMENT2_FORM     = 0x000003eaU,
    DISPID_IHTMLLISTELEMENT2_COMPACT   = 0x000003e9U,
}

enum : uint
{
    DISPID_IHTMLULISTELEMENT_COMPACT   = 0x000003e9U,
    DISPID_IHTMLULISTELEMENT_TYPE      = 0x00011399U,
    DISPID_IHTMLOLISTELEMENT_COMPACT   = 0x000003e9U,
    DISPID_IHTMLOLISTELEMENT_START     = 0x000003ebU,
    DISPID_IHTMLOLISTELEMENT_TYPE      = 0x00011399U,
    DISPID_IHTMLLIELEMENT_TYPE         = 0x00011399U,
    DISPID_IHTMLLIELEMENT_VALUE        = 0x000003e9U,
    DISPID_IHTMLBLOCKELEMENT_CLEAR     = 0x00011398U,
    DISPID_IHTMLBLOCKELEMENT2_CITE     = 0x000003e9U,
    DISPID_IHTMLBLOCKELEMENT2_WIDTH    = 0x000003eaU,
    DISPID_IHTMLBLOCKELEMENT3_IE8_CITE = 0x0000047eU,
}

enum : uint
{
    DISPID_IHTMLDIVELEMENT_ALIGN     = 0x00010048U,
    DISPID_IHTMLDIVELEMENT_NOWRAP    = 0x0001138dU,
    DISPID_IHTMLDDELEMENT_NOWRAP     = 0x0001138dU,
    DISPID_IHTMLDTELEMENT_NOWRAP     = 0x0001138dU,
    DISPID_IHTMLBRELEMENT_CLEAR      = 0x00011398U,
    DISPID_IHTMLDLISTELEMENT_COMPACT = 0x000003e9U,
}

enum : uint
{
    DISPID_IHTMLHRELEMENT_ALIGN            = 0x00010048U,
    DISPID_IHTMLHRELEMENT_COLOR            = 0x0001138aU,
    DISPID_IHTMLHRELEMENT_NOSHADE          = 0x000003e9U,
    DISPID_IHTMLHRELEMENT_WIDTH            = 0x00010005U,
    DISPID_IHTMLHRELEMENT_SIZE             = 0x00010006U,
    DISPID_IHTMLPARAELEMENT_ALIGN          = 0x00010048U,
    DISPID_IHTMLELEMENTCOLLECTION_TOSTRING = 0x000005ddU,
    DISPID_IHTMLELEMENTCOLLECTION_LENGTH   = 0x000005dcU,
}

enum int DISPID_IHTMLELEMENTCOLLECTION__NEWENUM = 0xfffffffc;

enum : uint
{
    DISPID_IHTMLELEMENTCOLLECTION_ITEM           = 0x00000000U,
    DISPID_IHTMLELEMENTCOLLECTION_TAGS           = 0x000005deU,
    DISPID_IHTMLELEMENTCOLLECTION2_URNS          = 0x000005e1U,
    DISPID_IHTMLELEMENTCOLLECTION3_NAMEDITEM     = 0x000005e2U,
    DISPID_IHTMLELEMENTCOLLECTION4_IE8_LENGTH    = 0x0000047eU,
    DISPID_IHTMLELEMENTCOLLECTION4_IE8_ITEM      = 0x00000480U,
    DISPID_IHTMLELEMENTCOLLECTION4_IE8_NAMEDITEM = 0x00000481U,
}

enum uint DISPID_IHTMLHEADERELEMENT_ALIGN = 0x00010048U;

enum : uint
{
    DISPID_IHTMLSELECTELEMENT_SIZE          = 0x000003eaU,
    DISPID_IHTMLSELECTELEMENT_MULTIPLE      = 0x000003ebU,
    DISPID_IHTMLSELECTELEMENT_NAME          = 0x00010000U,
    DISPID_IHTMLSELECTELEMENT_OPTIONS       = 0x000003edU,
    DISPID_IHTMLSELECTELEMENT_ONCHANGE      = 0x0001178eU,
    DISPID_IHTMLSELECTELEMENT_SELECTEDINDEX = 0x000003f2U,
    DISPID_IHTMLSELECTELEMENT_TYPE          = 0x000003f4U,
    DISPID_IHTMLSELECTELEMENT_VALUE         = 0x000003f3U,
    DISPID_IHTMLSELECTELEMENT_DISABLED      = 0x0001004cU,
    DISPID_IHTMLSELECTELEMENT_FORM          = 0x000107d4U,
    DISPID_IHTMLSELECTELEMENT_ADD           = 0x000005dfU,
    DISPID_IHTMLSELECTELEMENT_REMOVE        = 0x000005e0U,
    DISPID_IHTMLSELECTELEMENT_LENGTH        = 0x000005dcU,
}

enum int DISPID_IHTMLSELECTELEMENT__NEWENUM = 0xfffffffc;

enum : uint
{
    DISPID_IHTMLSELECTELEMENT_ITEM       = 0x00000000U,
    DISPID_IHTMLSELECTELEMENT_TAGS       = 0x000005deU,
    DISPID_IHTMLSELECTELEMENT2_URNS      = 0x000005e1U,
    DISPID_IHTMLSELECTELEMENT4_NAMEDITEM = 0x000005e2U,
    DISPID_IHTMLSELECTELEMENT5_IE8_ADD   = 0x0000047eU,
    DISPID_IHTMLSELECTELEMENT6_IE9_ADD   = 0x0000047fU,
    DISPID_IHTMLSELECTELEMENT6_IE9_VALUE = 0x00000480U,
}

enum : uint
{
    DISPID_HTMLSELECTELEMENTEVENTS2_ONCHANGE = 0x000003e9U,
    DISPID_HTMLSELECTELEMENTEVENTS_ONCHANGE  = 0x000003e9U,
}

enum : uint
{
    DISPID_IHTMLSELECTIONOBJECT_CREATERANGE            = 0x000003e9U,
    DISPID_IHTMLSELECTIONOBJECT_EMPTY                  = 0x000003eaU,
    DISPID_IHTMLSELECTIONOBJECT_CLEAR                  = 0x000003ebU,
    DISPID_IHTMLSELECTIONOBJECT_TYPE                   = 0x000003ecU,
    DISPID_IHTMLSELECTIONOBJECT2_CREATERANGECOLLECTION = 0x000003edU,
    DISPID_IHTMLSELECTIONOBJECT2_TYPEDETAIL            = 0x000003eeU,
    DISPID_IHTMLSELECTION_ANCHORNODE                   = 0x000003e9U,
    DISPID_IHTMLSELECTION_ANCHOROFFSET                 = 0x000003eaU,
    DISPID_IHTMLSELECTION_FOCUSNODE                    = 0x000003ebU,
    DISPID_IHTMLSELECTION_FOCUSOFFSET                  = 0x000003ecU,
    DISPID_IHTMLSELECTION_ISCOLLAPSED                  = 0x000003edU,
    DISPID_IHTMLSELECTION_COLLAPSE                     = 0x000003eeU,
    DISPID_IHTMLSELECTION_COLLAPSETOSTART              = 0x000003efU,
    DISPID_IHTMLSELECTION_COLLAPSETOEND                = 0x000003f0U,
    DISPID_IHTMLSELECTION_SELECTALLCHILDREN            = 0x000003f1U,
    DISPID_IHTMLSELECTION_DELETEFROMDOCUMENT           = 0x000003f2U,
    DISPID_IHTMLSELECTION_RANGECOUNT                   = 0x000003f3U,
    DISPID_IHTMLSELECTION_GETRANGEAT                   = 0x000003f4U,
    DISPID_IHTMLSELECTION_ADDRANGE                     = 0x000003f5U,
    DISPID_IHTMLSELECTION_REMOVERANGE                  = 0x000003f6U,
    DISPID_IHTMLSELECTION_REMOVEALLRANGES              = 0x000003f7U,
    DISPID_IHTMLSELECTION_TOSTRING                     = 0x000003f8U,
}

enum : uint
{
    DISPID_IHTMLOPTIONELEMENT_SELECTED        = 0x000003e9U,
    DISPID_IHTMLOPTIONELEMENT_VALUE           = 0x000003eaU,
    DISPID_IHTMLOPTIONELEMENT_DEFAULTSELECTED = 0x000003ebU,
    DISPID_IHTMLOPTIONELEMENT_INDEX           = 0x000003edU,
    DISPID_IHTMLOPTIONELEMENT_TEXT            = 0x000003ecU,
    DISPID_IHTMLOPTIONELEMENT_FORM            = 0x000003eeU,
    DISPID_IHTMLOPTIONELEMENT3_LABEL          = 0x000003efU,
    DISPID_IHTMLOPTIONELEMENT4_IE9_VALUE      = 0x000003f0U,
    DISPID_IHTMLOPTIONELEMENTFACTORY_CREATE   = 0x00000000U,
}

enum : uint
{
    DISPID_IHTMLINPUTELEMENT_TYPE                  = 0x000007d0U,
    DISPID_IHTMLINPUTELEMENT_VALUE                 = 0x000113edU,
    DISPID_IHTMLINPUTELEMENT_NAME                  = 0x00010000U,
    DISPID_IHTMLINPUTELEMENT_STATUS                = 0x000007d1U,
    DISPID_IHTMLINPUTELEMENT_DISABLED              = 0x0001004cU,
    DISPID_IHTMLINPUTELEMENT_FORM                  = 0x000107d4U,
    DISPID_IHTMLINPUTELEMENT_SIZE                  = 0x000007d2U,
    DISPID_IHTMLINPUTELEMENT_MAXLENGTH             = 0x000007d3U,
    DISPID_IHTMLINPUTELEMENT_SELECT                = 0x000007d4U,
    DISPID_IHTMLINPUTELEMENT_ONCHANGE              = 0x0001178eU,
    DISPID_IHTMLINPUTELEMENT_ONSELECT              = 0x0001177aU,
    DISPID_IHTMLINPUTELEMENT_DEFAULTVALUE          = 0x000113dbU,
    DISPID_IHTMLINPUTELEMENT_READONLY              = 0x000007d5U,
    DISPID_IHTMLINPUTELEMENT_CREATETEXTRANGE       = 0x000007d6U,
    DISPID_IHTMLINPUTELEMENT_INDETERMINATE         = 0x000007d7U,
    DISPID_IHTMLINPUTELEMENT_DEFAULTCHECKED        = 0x000007d8U,
    DISPID_IHTMLINPUTELEMENT_CHECKED               = 0x000007d9U,
    DISPID_IHTMLINPUTELEMENT_BORDER                = 0x000007dcU,
    DISPID_IHTMLINPUTELEMENT_VSPACE                = 0x000007ddU,
    DISPID_IHTMLINPUTELEMENT_HSPACE                = 0x000007deU,
    DISPID_IHTMLINPUTELEMENT_ALT                   = 0x000007daU,
    DISPID_IHTMLINPUTELEMENT_SRC                   = 0x000007dbU,
    DISPID_IHTMLINPUTELEMENT_LOWSRC                = 0x000007dfU,
    DISPID_IHTMLINPUTELEMENT_VRML                  = 0x000007e0U,
    DISPID_IHTMLINPUTELEMENT_DYNSRC                = 0x000007e1U,
    DISPID_IHTMLINPUTELEMENT_READYSTATE            = 0x000113fcU,
    DISPID_IHTMLINPUTELEMENT_COMPLETE              = 0x000007e2U,
    DISPID_IHTMLINPUTELEMENT_LOOP                  = 0x000007e3U,
    DISPID_IHTMLINPUTELEMENT_ALIGN                 = 0x00010049U,
    DISPID_IHTMLINPUTELEMENT_ONLOAD                = 0x00011790U,
    DISPID_IHTMLINPUTELEMENT_ONERROR               = 0x0001178dU,
    DISPID_IHTMLINPUTELEMENT_ONABORT               = 0x0001178cU,
    DISPID_IHTMLINPUTELEMENT_WIDTH                 = 0x00010005U,
    DISPID_IHTMLINPUTELEMENT_HEIGHT                = 0x00010006U,
    DISPID_IHTMLINPUTELEMENT_START                 = 0x000007e4U,
    DISPID_IHTMLINPUTELEMENT2_ACCEPT               = 0x000007e6U,
    DISPID_IHTMLINPUTELEMENT2_USEMAP               = 0x000007e7U,
    DISPID_IHTMLINPUTELEMENT3_IE8_SRC              = 0x0000047eU,
    DISPID_IHTMLINPUTELEMENT3_IE8_LOWSRC           = 0x0000047fU,
    DISPID_IHTMLINPUTELEMENT3_IE8_VRML             = 0x00000480U,
    DISPID_IHTMLINPUTELEMENT3_IE8_DYNSRC           = 0x00000481U,
    DISPID_IHTMLINPUTBUTTONELEMENT_TYPE            = 0x000007d0U,
    DISPID_IHTMLINPUTBUTTONELEMENT_VALUE           = 0x000113edU,
    DISPID_IHTMLINPUTBUTTONELEMENT_NAME            = 0x00010000U,
    DISPID_IHTMLINPUTBUTTONELEMENT_STATUS          = 0x000007e5U,
    DISPID_IHTMLINPUTBUTTONELEMENT_DISABLED        = 0x0001004cU,
    DISPID_IHTMLINPUTBUTTONELEMENT_FORM            = 0x000107d4U,
    DISPID_IHTMLINPUTBUTTONELEMENT_CREATETEXTRANGE = 0x000007d6U,
}

enum : uint
{
    DISPID_IHTMLINPUTHIDDENELEMENT_TYPE            = 0x000007d0U,
    DISPID_IHTMLINPUTHIDDENELEMENT_VALUE           = 0x000113edU,
    DISPID_IHTMLINPUTHIDDENELEMENT_NAME            = 0x00010000U,
    DISPID_IHTMLINPUTHIDDENELEMENT_STATUS          = 0x000007e5U,
    DISPID_IHTMLINPUTHIDDENELEMENT_DISABLED        = 0x0001004cU,
    DISPID_IHTMLINPUTHIDDENELEMENT_FORM            = 0x000107d4U,
    DISPID_IHTMLINPUTHIDDENELEMENT_CREATETEXTRANGE = 0x000007d6U,
}

enum : uint
{
    DISPID_IHTMLINPUTTEXTELEMENT_TYPE               = 0x000007d0U,
    DISPID_IHTMLINPUTTEXTELEMENT_VALUE              = 0x000113edU,
    DISPID_IHTMLINPUTTEXTELEMENT_NAME               = 0x00010000U,
    DISPID_IHTMLINPUTTEXTELEMENT_STATUS             = 0x000007e5U,
    DISPID_IHTMLINPUTTEXTELEMENT_DISABLED           = 0x0001004cU,
    DISPID_IHTMLINPUTTEXTELEMENT_FORM               = 0x000107d4U,
    DISPID_IHTMLINPUTTEXTELEMENT_DEFAULTVALUE       = 0x000113dbU,
    DISPID_IHTMLINPUTTEXTELEMENT_SIZE               = 0x000007d2U,
    DISPID_IHTMLINPUTTEXTELEMENT_MAXLENGTH          = 0x000007d3U,
    DISPID_IHTMLINPUTTEXTELEMENT_SELECT             = 0x000007d4U,
    DISPID_IHTMLINPUTTEXTELEMENT_ONCHANGE           = 0x0001178eU,
    DISPID_IHTMLINPUTTEXTELEMENT_ONSELECT           = 0x0001177aU,
    DISPID_IHTMLINPUTTEXTELEMENT_READONLY           = 0x000007d5U,
    DISPID_IHTMLINPUTTEXTELEMENT_CREATETEXTRANGE    = 0x000007d6U,
    DISPID_IHTMLINPUTTEXTELEMENT2_SELECTIONSTART    = 0x000007e9U,
    DISPID_IHTMLINPUTTEXTELEMENT2_SELECTIONEND      = 0x000007eaU,
    DISPID_IHTMLINPUTTEXTELEMENT2_SETSELECTIONRANGE = 0x000007ebU,
}

enum : uint
{
    DISPID_IHTMLINPUTFILEELEMENT_TYPE      = 0x000007d0U,
    DISPID_IHTMLINPUTFILEELEMENT_NAME      = 0x00010000U,
    DISPID_IHTMLINPUTFILEELEMENT_STATUS    = 0x000007e5U,
    DISPID_IHTMLINPUTFILEELEMENT_DISABLED  = 0x0001004cU,
    DISPID_IHTMLINPUTFILEELEMENT_FORM      = 0x000107d4U,
    DISPID_IHTMLINPUTFILEELEMENT_SIZE      = 0x000007d2U,
    DISPID_IHTMLINPUTFILEELEMENT_MAXLENGTH = 0x000007d3U,
    DISPID_IHTMLINPUTFILEELEMENT_SELECT    = 0x000007d4U,
    DISPID_IHTMLINPUTFILEELEMENT_ONCHANGE  = 0x0001178eU,
    DISPID_IHTMLINPUTFILEELEMENT_ONSELECT  = 0x0001177aU,
    DISPID_IHTMLINPUTFILEELEMENT_VALUE     = 0x000113edU,
}

enum : uint
{
    DISPID_IHTMLOPTIONBUTTONELEMENT_VALUE          = 0x000113edU,
    DISPID_IHTMLOPTIONBUTTONELEMENT_TYPE           = 0x000007d0U,
    DISPID_IHTMLOPTIONBUTTONELEMENT_NAME           = 0x00010000U,
    DISPID_IHTMLOPTIONBUTTONELEMENT_CHECKED        = 0x000007d9U,
    DISPID_IHTMLOPTIONBUTTONELEMENT_DEFAULTCHECKED = 0x000007d8U,
    DISPID_IHTMLOPTIONBUTTONELEMENT_ONCHANGE       = 0x0001178eU,
    DISPID_IHTMLOPTIONBUTTONELEMENT_DISABLED       = 0x0001004cU,
    DISPID_IHTMLOPTIONBUTTONELEMENT_STATUS         = 0x000007d1U,
    DISPID_IHTMLOPTIONBUTTONELEMENT_INDETERMINATE  = 0x000007d7U,
    DISPID_IHTMLOPTIONBUTTONELEMENT_FORM           = 0x000107d4U,
}

enum : uint
{
    DISPID_IHTMLINPUTIMAGE_TYPE                 = 0x000007d0U,
    DISPID_IHTMLINPUTIMAGE_DISABLED             = 0x0001004cU,
    DISPID_IHTMLINPUTIMAGE_BORDER               = 0x000007dcU,
    DISPID_IHTMLINPUTIMAGE_VSPACE               = 0x000007ddU,
    DISPID_IHTMLINPUTIMAGE_HSPACE               = 0x000007deU,
    DISPID_IHTMLINPUTIMAGE_ALT                  = 0x000007daU,
    DISPID_IHTMLINPUTIMAGE_SRC                  = 0x000007dbU,
    DISPID_IHTMLINPUTIMAGE_LOWSRC               = 0x000007dfU,
    DISPID_IHTMLINPUTIMAGE_VRML                 = 0x000007e0U,
    DISPID_IHTMLINPUTIMAGE_DYNSRC               = 0x000007e1U,
    DISPID_IHTMLINPUTIMAGE_READYSTATE           = 0x000113fcU,
    DISPID_IHTMLINPUTIMAGE_COMPLETE             = 0x000007e2U,
    DISPID_IHTMLINPUTIMAGE_LOOP                 = 0x000007e3U,
    DISPID_IHTMLINPUTIMAGE_ALIGN                = 0x00010049U,
    DISPID_IHTMLINPUTIMAGE_ONLOAD               = 0x00011790U,
    DISPID_IHTMLINPUTIMAGE_ONERROR              = 0x0001178dU,
    DISPID_IHTMLINPUTIMAGE_ONABORT              = 0x0001178cU,
    DISPID_IHTMLINPUTIMAGE_NAME                 = 0x00010000U,
    DISPID_IHTMLINPUTIMAGE_WIDTH                = 0x00010005U,
    DISPID_IHTMLINPUTIMAGE_HEIGHT               = 0x00010006U,
    DISPID_IHTMLINPUTIMAGE_START                = 0x000007e4U,
    DISPID_IHTMLINPUTRANGEELEMENT_DISABLED      = 0x0001004cU,
    DISPID_IHTMLINPUTRANGEELEMENT_TYPE          = 0x000007d0U,
    DISPID_IHTMLINPUTRANGEELEMENT_ALT           = 0x000007daU,
    DISPID_IHTMLINPUTRANGEELEMENT_NAME          = 0x00010000U,
    DISPID_IHTMLINPUTRANGEELEMENT_VALUE         = 0x000113edU,
    DISPID_IHTMLINPUTRANGEELEMENT_MIN           = 0x000007ecU,
    DISPID_IHTMLINPUTRANGEELEMENT_MAX           = 0x000007edU,
    DISPID_IHTMLINPUTRANGEELEMENT_STEP          = 0x000007eeU,
    DISPID_IHTMLINPUTRANGEELEMENT_VALUEASNUMBER = 0x000007efU,
    DISPID_IHTMLINPUTRANGEELEMENT_STEPUP        = 0x000007f1U,
    DISPID_IHTMLINPUTRANGEELEMENT_STEPDOWN      = 0x000007f0U,
}

enum : uint
{
    DISPID_HTMLINPUTTEXTELEMENTEVENTS2_ONCHANGE = 0x000003e9U,
    DISPID_HTMLINPUTTEXTELEMENTEVENTS2_ONSELECT = 0x000003eeU,
    DISPID_HTMLINPUTTEXTELEMENTEVENTS2_ONLOAD   = 0x000003ebU,
    DISPID_HTMLINPUTTEXTELEMENTEVENTS2_ONERROR  = 0x000003eaU,
    DISPID_HTMLINPUTTEXTELEMENTEVENTS2_ONABORT  = 0x000003e8U,
}

enum : uint
{
    DISPID_HTMLINPUTIMAGEEVENTS2_ONLOAD        = 0x000003ebU,
    DISPID_HTMLINPUTIMAGEEVENTS2_ONERROR       = 0x000003eaU,
    DISPID_HTMLINPUTIMAGEEVENTS2_ONABORT       = 0x000003e8U,
    DISPID_HTMLINPUTTEXTELEMENTEVENTS_ONCHANGE = 0x000003e9U,
    DISPID_HTMLINPUTTEXTELEMENTEVENTS_ONSELECT = 0x000003eeU,
    DISPID_HTMLINPUTTEXTELEMENTEVENTS_ONLOAD   = 0x000003ebU,
    DISPID_HTMLINPUTTEXTELEMENTEVENTS_ONERROR  = 0x000003eaU,
    DISPID_HTMLINPUTTEXTELEMENTEVENTS_ONABORT  = 0x000003e8U,
}

enum : uint
{
    DISPID_HTMLINPUTIMAGEEVENTS_ONLOAD  = 0x000003ebU,
    DISPID_HTMLINPUTIMAGEEVENTS_ONERROR = 0x000003eaU,
    DISPID_HTMLINPUTIMAGEEVENTS_ONABORT = 0x000003e8U,
}

enum : uint
{
    DISPID_IHTMLTEXTAREAELEMENT_TYPE               = 0x000007d0U,
    DISPID_IHTMLTEXTAREAELEMENT_VALUE              = 0x000113edU,
    DISPID_IHTMLTEXTAREAELEMENT_NAME               = 0x00010000U,
    DISPID_IHTMLTEXTAREAELEMENT_STATUS             = 0x000007d1U,
    DISPID_IHTMLTEXTAREAELEMENT_DISABLED           = 0x0001004cU,
    DISPID_IHTMLTEXTAREAELEMENT_FORM               = 0x000107d4U,
    DISPID_IHTMLTEXTAREAELEMENT_DEFAULTVALUE       = 0x000113dbU,
    DISPID_IHTMLTEXTAREAELEMENT_SELECT             = 0x00001b5dU,
    DISPID_IHTMLTEXTAREAELEMENT_ONCHANGE           = 0x0001178eU,
    DISPID_IHTMLTEXTAREAELEMENT_ONSELECT           = 0x0001177aU,
    DISPID_IHTMLTEXTAREAELEMENT_READONLY           = 0x00001b5cU,
    DISPID_IHTMLTEXTAREAELEMENT_ROWS               = 0x00001b59U,
    DISPID_IHTMLTEXTAREAELEMENT_COLS               = 0x00001b5aU,
    DISPID_IHTMLTEXTAREAELEMENT_WRAP               = 0x00001b5bU,
    DISPID_IHTMLTEXTAREAELEMENT_CREATETEXTRANGE    = 0x00001b5eU,
    DISPID_IHTMLTEXTAREAELEMENT2_SELECTIONSTART    = 0x00001b5fU,
    DISPID_IHTMLTEXTAREAELEMENT2_SELECTIONEND      = 0x00001b60U,
    DISPID_IHTMLTEXTAREAELEMENT2_SETSELECTIONRANGE = 0x00001b61U,
}

enum : uint
{
    DISPID_IHTMLBUTTONELEMENT_TYPE            = 0x000007d0U,
    DISPID_IHTMLBUTTONELEMENT_VALUE           = 0x000113edU,
    DISPID_IHTMLBUTTONELEMENT_NAME            = 0x00010000U,
    DISPID_IHTMLBUTTONELEMENT_STATUS          = 0x00001f41U,
    DISPID_IHTMLBUTTONELEMENT_DISABLED        = 0x0001004cU,
    DISPID_IHTMLBUTTONELEMENT_FORM            = 0x000107d4U,
    DISPID_IHTMLBUTTONELEMENT_CREATETEXTRANGE = 0x00001f42U,
    DISPID_IHTMLBUTTONELEMENT2_IE9_TYPE       = 0x00001f43U,
}

enum int DISPID_IHTMLMARQUEEELEMENT_BGCOLOR = 0xfffffe0b;

enum : uint
{
    DISPID_IHTMLMARQUEEELEMENT_SCROLLDELAY  = 0x00001770U,
    DISPID_IHTMLMARQUEEELEMENT_DIRECTION    = 0x00001771U,
    DISPID_IHTMLMARQUEEELEMENT_BEHAVIOR     = 0x00001772U,
    DISPID_IHTMLMARQUEEELEMENT_SCROLLAMOUNT = 0x00001773U,
    DISPID_IHTMLMARQUEEELEMENT_LOOP         = 0x00001774U,
    DISPID_IHTMLMARQUEEELEMENT_VSPACE       = 0x00001775U,
    DISPID_IHTMLMARQUEEELEMENT_HSPACE       = 0x00001776U,
    DISPID_IHTMLMARQUEEELEMENT_ONFINISH     = 0x0001178aU,
    DISPID_IHTMLMARQUEEELEMENT_ONSTART      = 0x0001178bU,
    DISPID_IHTMLMARQUEEELEMENT_ONBOUNCE     = 0x00011784U,
    DISPID_IHTMLMARQUEEELEMENT_WIDTH        = 0x00010005U,
    DISPID_IHTMLMARQUEEELEMENT_HEIGHT       = 0x00010006U,
    DISPID_IHTMLMARQUEEELEMENT_TRUESPEED    = 0x00001777U,
    DISPID_IHTMLMARQUEEELEMENT_START        = 0x0000177aU,
    DISPID_IHTMLMARQUEEELEMENT_STOP         = 0x0000177bU,
}

enum : uint
{
    DISPID_HTMLMARQUEEELEMENTEVENTS2_ONBOUNCE = 0x000003f1U,
    DISPID_HTMLMARQUEEELEMENTEVENTS2_ONFINISH = 0x000003f2U,
    DISPID_HTMLMARQUEEELEMENTEVENTS2_ONSTART  = 0x000003f3U,
    DISPID_HTMLMARQUEEELEMENTEVENTS_ONBOUNCE  = 0x000003f1U,
    DISPID_HTMLMARQUEEELEMENTEVENTS_ONFINISH  = 0x000003f2U,
    DISPID_HTMLMARQUEEELEMENTEVENTS_ONSTART   = 0x000003f3U,
}

enum : uint
{
    DISPID_IHTMLHTMLELEMENT_VERSION      = 0x000003e9U,
    DISPID_IHTMLHEADELEMENT_PROFILE      = 0x000003e9U,
    DISPID_IHTMLHEADELEMENT2_IE8_PROFILE = 0x0000047eU,
}

enum : uint
{
    DISPID_IHTMLTITLEELEMENT_TEXT     = 0x000113edU,
    DISPID_IHTMLMETAELEMENT_HTTPEQUIV = 0x000003e9U,
    DISPID_IHTMLMETAELEMENT_CONTENT   = 0x000003eaU,
    DISPID_IHTMLMETAELEMENT_NAME      = 0x00010000U,
    DISPID_IHTMLMETAELEMENT_URL       = 0x000003ebU,
    DISPID_IHTMLMETAELEMENT_CHARSET   = 0x000003f5U,
    DISPID_IHTMLMETAELEMENT2_SCHEME   = 0x000003fcU,
    DISPID_IHTMLMETAELEMENT3_IE8_URL  = 0x0000047eU,
}

enum : uint
{
    DISPID_IHTMLBASEELEMENT_HREF      = 0x000003ebU,
    DISPID_IHTMLBASEELEMENT_TARGET    = 0x000003ecU,
    DISPID_IHTMLBASEELEMENT2_IE8_HREF = 0x0000047eU,
}

enum : uint
{
    DISPID_IHTMLISINDEXELEMENT_PROMPT = 0x000003f2U,
    DISPID_IHTMLISINDEXELEMENT_ACTION = 0x000003f3U,
    DISPID_IHTMLISINDEXELEMENT2_FORM  = 0x000003f4U,
}

enum : uint
{
    DISPID_IHTMLNEXTIDELEMENT_N       = 0x000003f4U,
    DISPID_IHTMLBASEFONTELEMENT_COLOR = 0x0001138aU,
    DISPID_IHTMLBASEFONTELEMENT_FACE  = 0x0001139aU,
    DISPID_IHTMLBASEFONTELEMENT_SIZE  = 0x000113a2U,
}

enum : uint
{
    DISPID_IOMHISTORY_LENGTH  = 0x00000001U,
    DISPID_IOMHISTORY_BACK    = 0x00000002U,
    DISPID_IOMHISTORY_FORWARD = 0x00000003U,
    DISPID_IOMHISTORY_GO      = 0x00000004U,
}

enum : uint
{
    DISPID_IHTMLOPSPROFILE_ADDREQUEST     = 0x00000001U,
    DISPID_IHTMLOPSPROFILE_CLEARREQUEST   = 0x00000002U,
    DISPID_IHTMLOPSPROFILE_DOREQUEST      = 0x00000003U,
    DISPID_IHTMLOPSPROFILE_GETATTRIBUTE   = 0x00000004U,
    DISPID_IHTMLOPSPROFILE_SETATTRIBUTE   = 0x00000005U,
    DISPID_IHTMLOPSPROFILE_COMMITCHANGES  = 0x00000006U,
    DISPID_IHTMLOPSPROFILE_ADDREADREQUEST = 0x00000007U,
    DISPID_IHTMLOPSPROFILE_DOREADREQUEST  = 0x00000008U,
    DISPID_IHTMLOPSPROFILE_DOWRITEREQUEST = 0x00000009U,
}

enum : uint
{
    DISPID_IOMNAVIGATOR_APPCODENAME     = 0x00000001U,
    DISPID_IOMNAVIGATOR_APPNAME         = 0x00000002U,
    DISPID_IOMNAVIGATOR_APPVERSION      = 0x00000003U,
    DISPID_IOMNAVIGATOR_USERAGENT       = 0x00000004U,
    DISPID_IOMNAVIGATOR_JAVAENABLED     = 0x00000005U,
    DISPID_IOMNAVIGATOR_TAINTENABLED    = 0x00000006U,
    DISPID_IOMNAVIGATOR_MIMETYPES       = 0x00000007U,
    DISPID_IOMNAVIGATOR_PLUGINS         = 0x00000008U,
    DISPID_IOMNAVIGATOR_COOKIEENABLED   = 0x00000009U,
    DISPID_IOMNAVIGATOR_OPSPROFILE      = 0x0000000aU,
    DISPID_IOMNAVIGATOR_TOSTRING        = 0x0000000bU,
    DISPID_IOMNAVIGATOR_CPUCLASS        = 0x0000000cU,
    DISPID_IOMNAVIGATOR_SYSTEMLANGUAGE  = 0x0000000dU,
    DISPID_IOMNAVIGATOR_BROWSERLANGUAGE = 0x0000000eU,
    DISPID_IOMNAVIGATOR_USERLANGUAGE    = 0x0000000fU,
    DISPID_IOMNAVIGATOR_PLATFORM        = 0x00000010U,
    DISPID_IOMNAVIGATOR_APPMINORVERSION = 0x00000011U,
    DISPID_IOMNAVIGATOR_CONNECTIONSPEED = 0x00000012U,
    DISPID_IOMNAVIGATOR_ONLINE          = 0x00000013U,
    DISPID_IOMNAVIGATOR_USERPROFILE     = 0x00000014U,
}

enum : uint
{
    DISPID_INAVIGATORGEOLOCATION_GEOLOCATION = 0x00000015U,
    DISPID_INAVIGATORDONOTTRACK_MSDONOTTRACK = 0x00000016U,
}

enum : uint
{
    DISPID_IHTMLLOCATION_HREF              = 0x00000000U,
    DISPID_IHTMLLOCATION_PROTOCOL          = 0x00000001U,
    DISPID_IHTMLLOCATION_HOST              = 0x00000002U,
    DISPID_IHTMLLOCATION_HOSTNAME          = 0x00000003U,
    DISPID_IHTMLLOCATION_PORT              = 0x00000004U,
    DISPID_IHTMLLOCATION_PATHNAME          = 0x00000005U,
    DISPID_IHTMLLOCATION_SEARCH            = 0x00000006U,
    DISPID_IHTMLLOCATION_HASH              = 0x00000007U,
    DISPID_IHTMLLOCATION_RELOAD            = 0x00000008U,
    DISPID_IHTMLLOCATION_REPLACE           = 0x00000009U,
    DISPID_IHTMLLOCATION_ASSIGN            = 0x0000000aU,
    DISPID_IHTMLLOCATION_TOSTRING          = 0x0000000bU,
    DISPID_IHTMLMIMETYPESCOLLECTION_LENGTH = 0x00000001U,
}

enum : uint
{
    DISPID_IHTMLPLUGINSCOLLECTION_LENGTH  = 0x00000001U,
    DISPID_IHTMLPLUGINSCOLLECTION_REFRESH = 0x00000002U,
}

enum uint DISPID_IHTMLBOOKMARKCOLLECTION_LENGTH = 0x000005ddU;
enum int DISPID_IHTMLBOOKMARKCOLLECTION__NEWENUM = 0xfffffffc;
enum uint DISPID_IHTMLBOOKMARKCOLLECTION_ITEM = 0x00000000U;

enum : uint
{
    DISPID_IHTMLDATATRANSFER_SETDATA       = 0x000003e9U,
    DISPID_IHTMLDATATRANSFER_GETDATA       = 0x000003eaU,
    DISPID_IHTMLDATATRANSFER_CLEARDATA     = 0x000003ebU,
    DISPID_IHTMLDATATRANSFER_DROPEFFECT    = 0x000003ecU,
    DISPID_IHTMLDATATRANSFER_EFFECTALLOWED = 0x000003edU,
}

enum : uint
{
    DISPID_IHTMLEVENTOBJ_SRCELEMENT            = 0x000003e9U,
    DISPID_IHTMLEVENTOBJ_ALTKEY                = 0x000003eaU,
    DISPID_IHTMLEVENTOBJ_CTRLKEY               = 0x000003ebU,
    DISPID_IHTMLEVENTOBJ_SHIFTKEY              = 0x000003ecU,
    DISPID_IHTMLEVENTOBJ_RETURNVALUE           = 0x000003efU,
    DISPID_IHTMLEVENTOBJ_CANCELBUBBLE          = 0x000003f0U,
    DISPID_IHTMLEVENTOBJ_FROMELEMENT           = 0x000003f1U,
    DISPID_IHTMLEVENTOBJ_TOELEMENT             = 0x000003f2U,
    DISPID_IHTMLEVENTOBJ_KEYCODE               = 0x000003f3U,
    DISPID_IHTMLEVENTOBJ_BUTTON                = 0x000003f4U,
    DISPID_IHTMLEVENTOBJ_TYPE                  = 0x000003f5U,
    DISPID_IHTMLEVENTOBJ_QUALIFIER             = 0x000003f6U,
    DISPID_IHTMLEVENTOBJ_REASON                = 0x000003f7U,
    DISPID_IHTMLEVENTOBJ_X                     = 0x000003edU,
    DISPID_IHTMLEVENTOBJ_Y                     = 0x000003eeU,
    DISPID_IHTMLEVENTOBJ_CLIENTX               = 0x000003fcU,
    DISPID_IHTMLEVENTOBJ_CLIENTY               = 0x000003fdU,
    DISPID_IHTMLEVENTOBJ_OFFSETX               = 0x000003feU,
    DISPID_IHTMLEVENTOBJ_OFFSETY               = 0x000003ffU,
    DISPID_IHTMLEVENTOBJ_SCREENX               = 0x00000400U,
    DISPID_IHTMLEVENTOBJ_SCREENY               = 0x00000401U,
    DISPID_IHTMLEVENTOBJ_SRCFILTER             = 0x00000402U,
    DISPID_IHTMLEVENTOBJ2_SETATTRIBUTE         = 0x000101f5U,
    DISPID_IHTMLEVENTOBJ2_GETATTRIBUTE         = 0x000101f6U,
    DISPID_IHTMLEVENTOBJ2_REMOVEATTRIBUTE      = 0x000101f7U,
    DISPID_IHTMLEVENTOBJ2_PROPERTYNAME         = 0x00000403U,
    DISPID_IHTMLEVENTOBJ2_BOOKMARKS            = 0x00000407U,
    DISPID_IHTMLEVENTOBJ2_RECORDSET            = 0x00000408U,
    DISPID_IHTMLEVENTOBJ2_DATAFLD              = 0x00000409U,
    DISPID_IHTMLEVENTOBJ2_BOUNDELEMENTS        = 0x0000040aU,
    DISPID_IHTMLEVENTOBJ2_REPEAT               = 0x0000040bU,
    DISPID_IHTMLEVENTOBJ2_SRCURN               = 0x0000040cU,
    DISPID_IHTMLEVENTOBJ2_SRCELEMENT           = 0x000003e9U,
    DISPID_IHTMLEVENTOBJ2_ALTKEY               = 0x000003eaU,
    DISPID_IHTMLEVENTOBJ2_CTRLKEY              = 0x000003ebU,
    DISPID_IHTMLEVENTOBJ2_SHIFTKEY             = 0x000003ecU,
    DISPID_IHTMLEVENTOBJ2_FROMELEMENT          = 0x000003f1U,
    DISPID_IHTMLEVENTOBJ2_TOELEMENT            = 0x000003f2U,
    DISPID_IHTMLEVENTOBJ2_BUTTON               = 0x000003f4U,
    DISPID_IHTMLEVENTOBJ2_TYPE                 = 0x000003f5U,
    DISPID_IHTMLEVENTOBJ2_QUALIFIER            = 0x000003f6U,
    DISPID_IHTMLEVENTOBJ2_REASON               = 0x000003f7U,
    DISPID_IHTMLEVENTOBJ2_X                    = 0x000003edU,
    DISPID_IHTMLEVENTOBJ2_Y                    = 0x000003eeU,
    DISPID_IHTMLEVENTOBJ2_CLIENTX              = 0x000003fcU,
    DISPID_IHTMLEVENTOBJ2_CLIENTY              = 0x000003fdU,
    DISPID_IHTMLEVENTOBJ2_OFFSETX              = 0x000003feU,
    DISPID_IHTMLEVENTOBJ2_OFFSETY              = 0x000003ffU,
    DISPID_IHTMLEVENTOBJ2_SCREENX              = 0x00000400U,
    DISPID_IHTMLEVENTOBJ2_SCREENY              = 0x00000401U,
    DISPID_IHTMLEVENTOBJ2_SRCFILTER            = 0x00000402U,
    DISPID_IHTMLEVENTOBJ2_DATATRANSFER         = 0x0000040dU,
    DISPID_IHTMLEVENTOBJ3_CONTENTOVERFLOW      = 0x0000040eU,
    DISPID_IHTMLEVENTOBJ3_SHIFTLEFT            = 0x0000040fU,
    DISPID_IHTMLEVENTOBJ3_ALTLEFT              = 0x00000410U,
    DISPID_IHTMLEVENTOBJ3_CTRLLEFT             = 0x00000411U,
    DISPID_IHTMLEVENTOBJ3_IMECOMPOSITIONCHANGE = 0x00000412U,
    DISPID_IHTMLEVENTOBJ3_IMENOTIFYCOMMAND     = 0x00000413U,
    DISPID_IHTMLEVENTOBJ3_IMENOTIFYDATA        = 0x00000414U,
    DISPID_IHTMLEVENTOBJ3_IMEREQUEST           = 0x00000416U,
    DISPID_IHTMLEVENTOBJ3_IMEREQUESTDATA       = 0x00000417U,
    DISPID_IHTMLEVENTOBJ3_KEYBOARDLAYOUT       = 0x00000415U,
    DISPID_IHTMLEVENTOBJ3_BEHAVIORCOOKIE       = 0x00000418U,
    DISPID_IHTMLEVENTOBJ3_BEHAVIORPART         = 0x00000419U,
    DISPID_IHTMLEVENTOBJ3_NEXTPAGE             = 0x0000041aU,
    DISPID_IHTMLEVENTOBJ4_WHEELDELTA           = 0x0000041bU,
    DISPID_IHTMLEVENTOBJ5_URL                  = 0x0000041cU,
    DISPID_IHTMLEVENTOBJ5_DATA                 = 0x0000041eU,
    DISPID_IHTMLEVENTOBJ5_SOURCE               = 0x0000041fU,
    DISPID_IHTMLEVENTOBJ5_ORIGIN               = 0x0000041dU,
    DISPID_IHTMLEVENTOBJ5_ISSESSION            = 0x00000420U,
    DISPID_IHTMLEVENTOBJ6_ACTIONURL            = 0x00000422U,
    DISPID_IHTMLEVENTOBJ6_BUTTONID             = 0x00000421U,
}

enum : uint
{
    DISPID_IHTMLSTYLEMEDIA_TYPE        = 0x000003e9U,
    DISPID_IHTMLSTYLEMEDIA_MATCHMEDIUM = 0x000003eaU,
}

enum : uint
{
    DISPID_IHTMLFRAMESCOLLECTION2_ITEM   = 0x00000000U,
    DISPID_IHTMLFRAMESCOLLECTION2_LENGTH = 0x000003e9U,
}

enum : uint
{
    DISPID_IHTMLSCREEN_COLORDEPTH           = 0x000003e9U,
    DISPID_IHTMLSCREEN_BUFFERDEPTH          = 0x000003eaU,
    DISPID_IHTMLSCREEN_WIDTH                = 0x000003ebU,
    DISPID_IHTMLSCREEN_HEIGHT               = 0x000003ecU,
    DISPID_IHTMLSCREEN_UPDATEINTERVAL       = 0x000003edU,
    DISPID_IHTMLSCREEN_AVAILHEIGHT          = 0x000003eeU,
    DISPID_IHTMLSCREEN_AVAILWIDTH           = 0x000003efU,
    DISPID_IHTMLSCREEN_FONTSMOOTHINGENABLED = 0x000003f0U,
    DISPID_IHTMLSCREEN2_LOGICALXDPI         = 0x000003f1U,
    DISPID_IHTMLSCREEN2_LOGICALYDPI         = 0x000003f2U,
    DISPID_IHTMLSCREEN2_DEVICEXDPI          = 0x000003f3U,
    DISPID_IHTMLSCREEN2_DEVICEYDPI          = 0x000003f4U,
    DISPID_IHTMLSCREEN3_SYSTEMXDPI          = 0x000003f5U,
    DISPID_IHTMLSCREEN3_SYSTEMYDPI          = 0x000003f6U,
    DISPID_IHTMLSCREEN4_PIXELDEPTH          = 0x000003f7U,
}

enum : uint
{
    DISPID_IHTMLWINDOW2_FRAMES                  = 0x0000044cU,
    DISPID_IHTMLWINDOW2_DEFAULTSTATUS           = 0x0000044dU,
    DISPID_IHTMLWINDOW2_STATUS                  = 0x0000044eU,
    DISPID_IHTMLWINDOW2_SETTIMEOUT              = 0x00000494U,
    DISPID_IHTMLWINDOW2_CLEARTIMEOUT            = 0x00000450U,
    DISPID_IHTMLWINDOW2_ALERT                   = 0x00000451U,
    DISPID_IHTMLWINDOW2_CONFIRM                 = 0x00000456U,
    DISPID_IHTMLWINDOW2_PROMPT                  = 0x00000457U,
    DISPID_IHTMLWINDOW2_IMAGE                   = 0x00000465U,
    DISPID_IHTMLWINDOW2_LOCATION                = 0x0000000eU,
    DISPID_IHTMLWINDOW2_HISTORY                 = 0x00000002U,
    DISPID_IHTMLWINDOW2_CLOSE                   = 0x00000003U,
    DISPID_IHTMLWINDOW2_OPENER                  = 0x00000004U,
    DISPID_IHTMLWINDOW2_NAVIGATOR               = 0x00000005U,
    DISPID_IHTMLWINDOW2_NAME                    = 0x0000000bU,
    DISPID_IHTMLWINDOW2_PARENT                  = 0x0000000cU,
    DISPID_IHTMLWINDOW2_OPEN                    = 0x0000000dU,
    DISPID_IHTMLWINDOW2_SELF                    = 0x00000014U,
    DISPID_IHTMLWINDOW2_TOP                     = 0x00000015U,
    DISPID_IHTMLWINDOW2_WINDOW                  = 0x00000016U,
    DISPID_IHTMLWINDOW2_NAVIGATE                = 0x00000019U,
    DISPID_IHTMLWINDOW2_ONFOCUS                 = 0x0001177eU,
    DISPID_IHTMLWINDOW2_ONBLUR                  = 0x0001177fU,
    DISPID_IHTMLWINDOW2_ONLOAD                  = 0x00011790U,
    DISPID_IHTMLWINDOW2_ONBEFOREUNLOAD          = 0x00011797U,
    DISPID_IHTMLWINDOW2_ONUNLOAD                = 0x00011791U,
    DISPID_IHTMLWINDOW2_ONHELP                  = 0x0001177dU,
    DISPID_IHTMLWINDOW2_ONERROR                 = 0x0001178dU,
    DISPID_IHTMLWINDOW2_ONRESIZE                = 0x00011794U,
    DISPID_IHTMLWINDOW2_ONSCROLL                = 0x0001178fU,
    DISPID_IHTMLWINDOW2_DOCUMENT                = 0x0000047fU,
    DISPID_IHTMLWINDOW2_EVENT                   = 0x00000480U,
    DISPID_IHTMLWINDOW2__NEWENUM                = 0x00000481U,
    DISPID_IHTMLWINDOW2_SHOWMODALDIALOG         = 0x00000482U,
    DISPID_IHTMLWINDOW2_SHOWHELP                = 0x00000483U,
    DISPID_IHTMLWINDOW2_SCREEN                  = 0x00000484U,
    DISPID_IHTMLWINDOW2_OPTION                  = 0x00000485U,
    DISPID_IHTMLWINDOW2_FOCUS                   = 0x00000486U,
    DISPID_IHTMLWINDOW2_CLOSED                  = 0x00000017U,
    DISPID_IHTMLWINDOW2_BLUR                    = 0x00000487U,
    DISPID_IHTMLWINDOW2_SCROLL                  = 0x00000488U,
    DISPID_IHTMLWINDOW2_CLIENTINFORMATION       = 0x00000489U,
    DISPID_IHTMLWINDOW2_SETINTERVAL             = 0x00000495U,
    DISPID_IHTMLWINDOW2_CLEARINTERVAL           = 0x0000048bU,
    DISPID_IHTMLWINDOW2_OFFSCREENBUFFERING      = 0x0000048cU,
    DISPID_IHTMLWINDOW2_EXECSCRIPT              = 0x0000048dU,
    DISPID_IHTMLWINDOW2_TOSTRING                = 0x0000048eU,
    DISPID_IHTMLWINDOW2_SCROLLBY                = 0x0000048fU,
    DISPID_IHTMLWINDOW2_SCROLLTO                = 0x00000490U,
    DISPID_IHTMLWINDOW2_MOVETO                  = 0x00000006U,
    DISPID_IHTMLWINDOW2_MOVEBY                  = 0x00000007U,
    DISPID_IHTMLWINDOW2_RESIZETO                = 0x00000009U,
    DISPID_IHTMLWINDOW2_RESIZEBY                = 0x00000008U,
    DISPID_IHTMLWINDOW2_EXTERNAL                = 0x00000491U,
    DISPID_IHTMLWINDOW3_SCREENLEFT              = 0x00000492U,
    DISPID_IHTMLWINDOW3_SCREENTOP               = 0x00000493U,
    DISPID_IHTMLWINDOW3_ATTACHEVENT             = 0x000101fbU,
    DISPID_IHTMLWINDOW3_DETACHEVENT             = 0x000101fcU,
    DISPID_IHTMLWINDOW3_SETTIMEOUT              = 0x0000044fU,
    DISPID_IHTMLWINDOW3_SETINTERVAL             = 0x0000048aU,
    DISPID_IHTMLWINDOW3_PRINT                   = 0x00000496U,
    DISPID_IHTMLWINDOW3_ONBEFOREPRINT           = 0x000117b2U,
    DISPID_IHTMLWINDOW3_ONAFTERPRINT            = 0x000117b3U,
    DISPID_IHTMLWINDOW3_CLIPBOARDDATA           = 0x00000497U,
    DISPID_IHTMLWINDOW3_SHOWMODELESSDIALOG      = 0x00000498U,
    DISPID_IHTMLWINDOW4_CREATEPOPUP             = 0x0000049cU,
    DISPID_IHTMLWINDOW4_FRAMEELEMENT            = 0x0000049dU,
    DISPID_IHTMLWINDOW5_XMLHTTPREQUEST          = 0x000004a6U,
    DISPID_IHTMLWINDOW6_XDOMAINREQUEST          = 0x000004a7U,
    DISPID_IHTMLWINDOW6_SESSIONSTORAGE          = 0x000004a8U,
    DISPID_IHTMLWINDOW6_LOCALSTORAGE            = 0x000004a9U,
    DISPID_IHTMLWINDOW6_ONHASHCHANGE            = 0x000117ddU,
    DISPID_IHTMLWINDOW6_MAXCONNECTIONSPERSERVER = 0x000004aaU,
    DISPID_IHTMLWINDOW6_POSTMESSAGE             = 0x000004acU,
    DISPID_IHTMLWINDOW6_TOSTATICHTML            = 0x000004adU,
    DISPID_IHTMLWINDOW6_ONMESSAGE               = 0x000117deU,
    DISPID_IHTMLWINDOW6_MSWRITEPROFILERMARK     = 0x000004aeU,
    DISPID_IHTMLWINDOW7_GETSELECTION            = 0x000004afU,
    DISPID_IHTMLWINDOW7_GETCOMPUTEDSTYLE        = 0x000004b0U,
    DISPID_IHTMLWINDOW7_STYLEMEDIA              = 0x000004b2U,
    DISPID_IHTMLWINDOW7_PERFORMANCE             = 0x000004b3U,
    DISPID_IHTMLWINDOW7_INNERWIDTH              = 0x000004b4U,
    DISPID_IHTMLWINDOW7_INNERHEIGHT             = 0x000004b5U,
    DISPID_IHTMLWINDOW7_PAGEXOFFSET             = 0x000004b6U,
    DISPID_IHTMLWINDOW7_PAGEYOFFSET             = 0x000004b7U,
    DISPID_IHTMLWINDOW7_SCREENX                 = 0x000004b8U,
    DISPID_IHTMLWINDOW7_SCREENY                 = 0x000004b9U,
    DISPID_IHTMLWINDOW7_OUTERWIDTH              = 0x000004baU,
    DISPID_IHTMLWINDOW7_OUTERHEIGHT             = 0x000004bbU,
    DISPID_IHTMLWINDOW7_ONABORT                 = 0x0001178cU,
    DISPID_IHTMLWINDOW7_ONCANPLAY               = 0x000117f6U,
    DISPID_IHTMLWINDOW7_ONCANPLAYTHROUGH        = 0x000117f7U,
    DISPID_IHTMLWINDOW7_ONCHANGE                = 0x0001178eU,
    DISPID_IHTMLWINDOW7_ONCLICK                 = 0x00011778U,
    DISPID_IHTMLWINDOW7_ONCONTEXTMENU           = 0x000117b1U,
    DISPID_IHTMLWINDOW7_ONDBLCLICK              = 0x00011779U,
    DISPID_IHTMLWINDOW7_ONDRAG                  = 0x000117a1U,
    DISPID_IHTMLWINDOW7_ONDRAGEND               = 0x000117a2U,
    DISPID_IHTMLWINDOW7_ONDRAGENTER             = 0x000117a3U,
    DISPID_IHTMLWINDOW7_ONDRAGLEAVE             = 0x000117a5U,
    DISPID_IHTMLWINDOW7_ONDRAGOVER              = 0x000117a4U,
    DISPID_IHTMLWINDOW7_ONDRAGSTART             = 0x00011793U,
    DISPID_IHTMLWINDOW7_ONDROP                  = 0x000117a6U,
    DISPID_IHTMLWINDOW7_ONDURATIONCHANGE        = 0x000117f8U,
    DISPID_IHTMLWINDOW7_ONFOCUSIN               = 0x000117cbU,
    DISPID_IHTMLWINDOW7_ONFOCUSOUT              = 0x000117ccU,
    DISPID_IHTMLWINDOW7_ONINPUT                 = 0x000117efU,
    DISPID_IHTMLWINDOW7_ONEMPTIED               = 0x000117f9U,
    DISPID_IHTMLWINDOW7_ONENDED                 = 0x000117faU,
    DISPID_IHTMLWINDOW7_ONKEYDOWN               = 0x00011775U,
    DISPID_IHTMLWINDOW7_ONKEYPRESS              = 0x00011777U,
    DISPID_IHTMLWINDOW7_ONKEYUP                 = 0x00011776U,
    DISPID_IHTMLWINDOW7_ONLOADEDDATA            = 0x000117fbU,
    DISPID_IHTMLWINDOW7_ONLOADEDMETADATA        = 0x000117fcU,
    DISPID_IHTMLWINDOW7_ONLOADSTART             = 0x000117fdU,
    DISPID_IHTMLWINDOW7_ONMOUSEDOWN             = 0x00011772U,
    DISPID_IHTMLWINDOW7_ONMOUSEENTER            = 0x000117c5U,
    DISPID_IHTMLWINDOW7_ONMOUSELEAVE            = 0x000117c6U,
    DISPID_IHTMLWINDOW7_ONMOUSEMOVE             = 0x00011774U,
    DISPID_IHTMLWINDOW7_ONMOUSEOUT              = 0x00011771U,
    DISPID_IHTMLWINDOW7_ONMOUSEOVER             = 0x00011770U,
    DISPID_IHTMLWINDOW7_ONMOUSEUP               = 0x00011773U,
    DISPID_IHTMLWINDOW7_ONMOUSEWHEEL            = 0x000117bcU,
    DISPID_IHTMLWINDOW7_ONOFFLINE               = 0x000117dcU,
    DISPID_IHTMLWINDOW7_ONONLINE                = 0x000117dbU,
    DISPID_IHTMLWINDOW7_ONPROGRESS              = 0x00011801U,
    DISPID_IHTMLWINDOW7_ONRATECHANGE            = 0x00011802U,
    DISPID_IHTMLWINDOW7_ONREADYSTATECHANGE      = 0x00011789U,
    DISPID_IHTMLWINDOW7_ONRESET                 = 0x0001177cU,
    DISPID_IHTMLWINDOW7_ONSEEKED                = 0x00011803U,
    DISPID_IHTMLWINDOW7_ONSEEKING               = 0x00011804U,
    DISPID_IHTMLWINDOW7_ONSELECT                = 0x0001177aU,
    DISPID_IHTMLWINDOW7_ONSTALLED               = 0x00011805U,
    DISPID_IHTMLWINDOW7_ONSTORAGE               = 0x000117d4U,
    DISPID_IHTMLWINDOW7_ONSUBMIT                = 0x0001177bU,
    DISPID_IHTMLWINDOW7_ONSUSPEND               = 0x00011806U,
    DISPID_IHTMLWINDOW7_ONTIMEUPDATE            = 0x00011807U,
    DISPID_IHTMLWINDOW7_ONPAUSE                 = 0x000117feU,
    DISPID_IHTMLWINDOW7_ONPLAY                  = 0x000117ffU,
    DISPID_IHTMLWINDOW7_ONPLAYING               = 0x00011800U,
    DISPID_IHTMLWINDOW7_ONVOLUMECHANGE          = 0x00011808U,
    DISPID_IHTMLWINDOW7_ONWAITING               = 0x00011809U,
    DISPID_IHTMLWINDOW8_ONMSPOINTERDOWN         = 0x0001180aU,
    DISPID_IHTMLWINDOW8_ONMSPOINTERMOVE         = 0x0001180bU,
    DISPID_IHTMLWINDOW8_ONMSPOINTERUP           = 0x0001180cU,
    DISPID_IHTMLWINDOW8_ONMSPOINTEROVER         = 0x0001180dU,
    DISPID_IHTMLWINDOW8_ONMSPOINTEROUT          = 0x0001180eU,
    DISPID_IHTMLWINDOW8_ONMSPOINTERCANCEL       = 0x0001180fU,
    DISPID_IHTMLWINDOW8_ONMSPOINTERHOVER        = 0x00011810U,
    DISPID_IHTMLWINDOW8_ONMSGESTURESTART        = 0x00011813U,
    DISPID_IHTMLWINDOW8_ONMSGESTURECHANGE       = 0x00011814U,
    DISPID_IHTMLWINDOW8_ONMSGESTUREEND          = 0x00011815U,
    DISPID_IHTMLWINDOW8_ONMSGESTUREHOLD         = 0x00011816U,
    DISPID_IHTMLWINDOW8_ONMSGESTURETAP          = 0x00011817U,
    DISPID_IHTMLWINDOW8_ONMSGESTUREDOUBLETAP    = 0x00011818U,
    DISPID_IHTMLWINDOW8_ONMSINERTIASTART        = 0x00011819U,
    DISPID_IHTMLWINDOW8_APPLICATIONCACHE        = 0x000004bdU,
    DISPID_IHTMLWINDOW8_ONPOPSTATE              = 0x00011830U,
}

enum : uint
{
    DISPID_HTMLWINDOWEVENTS3_ONHASHCHANGE   = 0x0000042aU,
    DISPID_HTMLWINDOWEVENTS3_ONMESSAGE      = 0x0000042bU,
    DISPID_HTMLWINDOWEVENTS2_ONLOAD         = 0x000003ebU,
    DISPID_HTMLWINDOWEVENTS2_ONUNLOAD       = 0x000003f0U,
    DISPID_HTMLWINDOWEVENTS2_ONHELP         = 0x0001000aU,
    DISPID_HTMLWINDOWEVENTS2_ONFOCUS        = 0x00010001U,
    DISPID_HTMLWINDOWEVENTS2_ONERROR        = 0x000003eaU,
    DISPID_HTMLWINDOWEVENTS2_ONRESIZE       = 0x000003f8U,
    DISPID_HTMLWINDOWEVENTS2_ONSCROLL       = 0x000003f6U,
    DISPID_HTMLWINDOWEVENTS2_ONBEFOREUNLOAD = 0x000003f9U,
    DISPID_HTMLWINDOWEVENTS2_ONBEFOREPRINT  = 0x00000400U,
    DISPID_HTMLWINDOWEVENTS2_ONAFTERPRINT   = 0x00000401U,
    DISPID_HTMLWINDOWEVENTS_ONLOAD          = 0x000003ebU,
    DISPID_HTMLWINDOWEVENTS_ONUNLOAD        = 0x000003f0U,
    DISPID_HTMLWINDOWEVENTS_ONHELP          = 0x0001000aU,
    DISPID_HTMLWINDOWEVENTS_ONFOCUS         = 0x00010001U,
    DISPID_HTMLWINDOWEVENTS_ONERROR         = 0x000003eaU,
    DISPID_HTMLWINDOWEVENTS_ONRESIZE        = 0x000003f8U,
    DISPID_HTMLWINDOWEVENTS_ONSCROLL        = 0x000003f6U,
    DISPID_HTMLWINDOWEVENTS_ONBEFOREUNLOAD  = 0x000003f9U,
    DISPID_HTMLWINDOWEVENTS_ONBEFOREPRINT   = 0x00000400U,
    DISPID_HTMLWINDOWEVENTS_ONAFTERPRINT    = 0x00000401U,
}

enum : uint
{
    DISPID_IHTMLDOCUMENTCOMPATIBLEINFO_USERAGENT        = 0x000003e9U,
    DISPID_IHTMLDOCUMENTCOMPATIBLEINFO_VERSION          = 0x000003eaU,
    DISPID_IHTMLDOCUMENTCOMPATIBLEINFOCOLLECTION_LENGTH = 0x000003e9U,
    DISPID_IHTMLDOCUMENTCOMPATIBLEINFOCOLLECTION_ITEM   = 0x00000000U,
    DISPID_IHTMLDOCUMENT_SCRIPT                         = 0x000003e9U,
    DISPID_IHTMLDOCUMENT2_ALL                           = 0x000003ebU,
    DISPID_IHTMLDOCUMENT2_BODY                          = 0x000003ecU,
    DISPID_IHTMLDOCUMENT2_ACTIVEELEMENT                 = 0x000003edU,
    DISPID_IHTMLDOCUMENT2_IMAGES                        = 0x000003f3U,
    DISPID_IHTMLDOCUMENT2_APPLETS                       = 0x000003f0U,
    DISPID_IHTMLDOCUMENT2_LINKS                         = 0x000003f1U,
    DISPID_IHTMLDOCUMENT2_FORMS                         = 0x000003f2U,
    DISPID_IHTMLDOCUMENT2_ANCHORS                       = 0x000003efU,
    DISPID_IHTMLDOCUMENT2_TITLE                         = 0x000003f4U,
    DISPID_IHTMLDOCUMENT2_SCRIPTS                       = 0x000003f5U,
    DISPID_IHTMLDOCUMENT2_DESIGNMODE                    = 0x000003f6U,
    DISPID_IHTMLDOCUMENT2_SELECTION                     = 0x000003f9U,
    DISPID_IHTMLDOCUMENT2_READYSTATE                    = 0x000003faU,
    DISPID_IHTMLDOCUMENT2_FRAMES                        = 0x000003fbU,
    DISPID_IHTMLDOCUMENT2_EMBEDS                        = 0x000003f7U,
    DISPID_IHTMLDOCUMENT2_PLUGINS                       = 0x000003fdU,
    DISPID_IHTMLDOCUMENT2_ALINKCOLOR                    = 0x000003feU,
}

enum int DISPID_IHTMLDOCUMENT2_BGCOLOR = 0xfffffe0b;

enum : uint
{
    DISPID_IHTMLDOCUMENT2_FGCOLOR                         = 0x0001138aU,
    DISPID_IHTMLDOCUMENT2_LINKCOLOR                       = 0x00000400U,
    DISPID_IHTMLDOCUMENT2_VLINKCOLOR                      = 0x000003ffU,
    DISPID_IHTMLDOCUMENT2_REFERRER                        = 0x00000403U,
    DISPID_IHTMLDOCUMENT2_LOCATION                        = 0x00000402U,
    DISPID_IHTMLDOCUMENT2_LASTMODIFIED                    = 0x00000404U,
    DISPID_IHTMLDOCUMENT2_URL                             = 0x00000401U,
    DISPID_IHTMLDOCUMENT2_DOMAIN                          = 0x00000405U,
    DISPID_IHTMLDOCUMENT2_COOKIE                          = 0x00000406U,
    DISPID_IHTMLDOCUMENT2_EXPANDO                         = 0x00000407U,
    DISPID_IHTMLDOCUMENT2_CHARSET                         = 0x00000408U,
    DISPID_IHTMLDOCUMENT2_DEFAULTCHARSET                  = 0x00000409U,
    DISPID_IHTMLDOCUMENT2_MIMETYPE                        = 0x00000411U,
    DISPID_IHTMLDOCUMENT2_FILESIZE                        = 0x00000412U,
    DISPID_IHTMLDOCUMENT2_FILECREATEDDATE                 = 0x00000413U,
    DISPID_IHTMLDOCUMENT2_FILEMODIFIEDDATE                = 0x00000414U,
    DISPID_IHTMLDOCUMENT2_FILEUPDATEDDATE                 = 0x00000415U,
    DISPID_IHTMLDOCUMENT2_SECURITY                        = 0x00000416U,
    DISPID_IHTMLDOCUMENT2_PROTOCOL                        = 0x00000417U,
    DISPID_IHTMLDOCUMENT2_NAMEPROP                        = 0x00000418U,
    DISPID_IHTMLDOCUMENT2_WRITE                           = 0x0000041eU,
    DISPID_IHTMLDOCUMENT2_WRITELN                         = 0x0000041fU,
    DISPID_IHTMLDOCUMENT2_OPEN                            = 0x00000420U,
    DISPID_IHTMLDOCUMENT2_CLOSE                           = 0x00000421U,
    DISPID_IHTMLDOCUMENT2_CLEAR                           = 0x00000422U,
    DISPID_IHTMLDOCUMENT2_QUERYCOMMANDSUPPORTED           = 0x00000423U,
    DISPID_IHTMLDOCUMENT2_QUERYCOMMANDENABLED             = 0x00000424U,
    DISPID_IHTMLDOCUMENT2_QUERYCOMMANDSTATE               = 0x00000425U,
    DISPID_IHTMLDOCUMENT2_QUERYCOMMANDINDETERM            = 0x00000426U,
    DISPID_IHTMLDOCUMENT2_QUERYCOMMANDTEXT                = 0x00000427U,
    DISPID_IHTMLDOCUMENT2_QUERYCOMMANDVALUE               = 0x00000428U,
    DISPID_IHTMLDOCUMENT2_EXECCOMMAND                     = 0x00000429U,
    DISPID_IHTMLDOCUMENT2_EXECCOMMANDSHOWHELP             = 0x0000042aU,
    DISPID_IHTMLDOCUMENT2_CREATEELEMENT                   = 0x0000042bU,
    DISPID_IHTMLDOCUMENT2_ONHELP                          = 0x0001177dU,
    DISPID_IHTMLDOCUMENT2_ONCLICK                         = 0x00011778U,
    DISPID_IHTMLDOCUMENT2_ONDBLCLICK                      = 0x00011779U,
    DISPID_IHTMLDOCUMENT2_ONKEYUP                         = 0x00011776U,
    DISPID_IHTMLDOCUMENT2_ONKEYDOWN                       = 0x00011775U,
    DISPID_IHTMLDOCUMENT2_ONKEYPRESS                      = 0x00011777U,
    DISPID_IHTMLDOCUMENT2_ONMOUSEUP                       = 0x00011773U,
    DISPID_IHTMLDOCUMENT2_ONMOUSEDOWN                     = 0x00011772U,
    DISPID_IHTMLDOCUMENT2_ONMOUSEMOVE                     = 0x00011774U,
    DISPID_IHTMLDOCUMENT2_ONMOUSEOUT                      = 0x00011771U,
    DISPID_IHTMLDOCUMENT2_ONMOUSEOVER                     = 0x00011770U,
    DISPID_IHTMLDOCUMENT2_ONREADYSTATECHANGE              = 0x00011789U,
    DISPID_IHTMLDOCUMENT2_ONAFTERUPDATE                   = 0x00011786U,
    DISPID_IHTMLDOCUMENT2_ONROWEXIT                       = 0x00011782U,
    DISPID_IHTMLDOCUMENT2_ONROWENTER                      = 0x00011783U,
    DISPID_IHTMLDOCUMENT2_ONDRAGSTART                     = 0x00011793U,
    DISPID_IHTMLDOCUMENT2_ONSELECTSTART                   = 0x00011795U,
    DISPID_IHTMLDOCUMENT2_ELEMENTFROMPOINT                = 0x0000042cU,
    DISPID_IHTMLDOCUMENT2_PARENTWINDOW                    = 0x0000040aU,
    DISPID_IHTMLDOCUMENT2_STYLESHEETS                     = 0x0000042dU,
    DISPID_IHTMLDOCUMENT2_ONBEFOREUPDATE                  = 0x00011785U,
    DISPID_IHTMLDOCUMENT2_ONERRORUPDATE                   = 0x00011796U,
    DISPID_IHTMLDOCUMENT2_TOSTRING                        = 0x0000042eU,
    DISPID_IHTMLDOCUMENT2_CREATESTYLESHEET                = 0x0000042fU,
    DISPID_IHTMLDOCUMENT3_RELEASECAPTURE                  = 0x00000430U,
    DISPID_IHTMLDOCUMENT3_RECALC                          = 0x00000431U,
    DISPID_IHTMLDOCUMENT3_CREATETEXTNODE                  = 0x00000432U,
    DISPID_IHTMLDOCUMENT3_DOCUMENTELEMENT                 = 0x00000433U,
    DISPID_IHTMLDOCUMENT3_UNIQUEID                        = 0x00000435U,
    DISPID_IHTMLDOCUMENT3_ATTACHEVENT                     = 0x000101fbU,
    DISPID_IHTMLDOCUMENT3_DETACHEVENT                     = 0x000101fcU,
    DISPID_IHTMLDOCUMENT3_ONROWSDELETE                    = 0x000117aeU,
    DISPID_IHTMLDOCUMENT3_ONROWSINSERTED                  = 0x000117afU,
    DISPID_IHTMLDOCUMENT3_ONCELLCHANGE                    = 0x000117b0U,
    DISPID_IHTMLDOCUMENT3_ONDATASETCHANGED                = 0x00011798U,
    DISPID_IHTMLDOCUMENT3_ONDATAAVAILABLE                 = 0x00011799U,
    DISPID_IHTMLDOCUMENT3_ONDATASETCOMPLETE               = 0x0001179aU,
    DISPID_IHTMLDOCUMENT3_ONPROPERTYCHANGE                = 0x0001179fU,
    DISPID_IHTMLDOCUMENT3_DIR                             = 0x000113fdU,
    DISPID_IHTMLDOCUMENT3_ONCONTEXTMENU                   = 0x000117b1U,
    DISPID_IHTMLDOCUMENT3_ONSTOP                          = 0x000117b4U,
    DISPID_IHTMLDOCUMENT3_CREATEDOCUMENTFRAGMENT          = 0x00000434U,
    DISPID_IHTMLDOCUMENT3_PARENTDOCUMENT                  = 0x00000436U,
    DISPID_IHTMLDOCUMENT3_ENABLEDOWNLOAD                  = 0x00000437U,
    DISPID_IHTMLDOCUMENT3_BASEURL                         = 0x00000438U,
    DISPID_IHTMLDOCUMENT3_CHILDNODES                      = 0x00010419U,
    DISPID_IHTMLDOCUMENT3_INHERITSTYLESHEETS              = 0x0000043aU,
    DISPID_IHTMLDOCUMENT3_ONBEFOREEDITFOCUS               = 0x000117b5U,
    DISPID_IHTMLDOCUMENT3_GETELEMENTSBYNAME               = 0x0000043eU,
    DISPID_IHTMLDOCUMENT3_GETELEMENTBYID                  = 0x00000440U,
    DISPID_IHTMLDOCUMENT3_GETELEMENTSBYTAGNAME            = 0x0000043fU,
    DISPID_IHTMLDOCUMENT4_FOCUS                           = 0x00000441U,
    DISPID_IHTMLDOCUMENT4_HASFOCUS                        = 0x00000442U,
    DISPID_IHTMLDOCUMENT4_ONSELECTIONCHANGE               = 0x000117c0U,
    DISPID_IHTMLDOCUMENT4_NAMESPACES                      = 0x00000443U,
    DISPID_IHTMLDOCUMENT4_CREATEDOCUMENTFROMURL           = 0x00000444U,
    DISPID_IHTMLDOCUMENT4_MEDIA                           = 0x00000445U,
    DISPID_IHTMLDOCUMENT4_CREATEEVENTOBJECT               = 0x00000446U,
    DISPID_IHTMLDOCUMENT4_FIREEVENT                       = 0x00000447U,
    DISPID_IHTMLDOCUMENT4_CREATERENDERSTYLE               = 0x00000448U,
    DISPID_IHTMLDOCUMENT4_ONCONTROLSELECT                 = 0x000117bfU,
    DISPID_IHTMLDOCUMENT4_URLUNENCODED                    = 0x00000449U,
    DISPID_IHTMLDOCUMENT5_ONMOUSEWHEEL                    = 0x000117bcU,
    DISPID_IHTMLDOCUMENT5_DOCTYPE                         = 0x0000044aU,
    DISPID_IHTMLDOCUMENT5_IMPLEMENTATION                  = 0x0000044bU,
    DISPID_IHTMLDOCUMENT5_CREATEATTRIBUTE                 = 0x0000044cU,
    DISPID_IHTMLDOCUMENT5_CREATECOMMENT                   = 0x0000044dU,
    DISPID_IHTMLDOCUMENT5_ONFOCUSIN                       = 0x000117cbU,
    DISPID_IHTMLDOCUMENT5_ONFOCUSOUT                      = 0x000117ccU,
    DISPID_IHTMLDOCUMENT5_ONACTIVATE                      = 0x000117c7U,
    DISPID_IHTMLDOCUMENT5_ONDEACTIVATE                    = 0x000117c8U,
    DISPID_IHTMLDOCUMENT5_ONBEFOREACTIVATE                = 0x000117caU,
    DISPID_IHTMLDOCUMENT5_ONBEFOREDEACTIVATE              = 0x000117bdU,
    DISPID_IHTMLDOCUMENT5_COMPATMODE                      = 0x0000044eU,
    DISPID_IHTMLDOCUMENT6_COMPATIBLE                      = 0x0000044fU,
    DISPID_IHTMLDOCUMENT6_DOCUMENTMODE                    = 0x00000450U,
    DISPID_IHTMLDOCUMENT6_ONSTORAGE                       = 0x000117d4U,
    DISPID_IHTMLDOCUMENT6_ONSTORAGECOMMIT                 = 0x000117d5U,
    DISPID_IHTMLDOCUMENT6_IE8_GETELEMENTBYID              = 0x00000453U,
    DISPID_IHTMLDOCUMENT6_UPDATESETTINGS                  = 0x00000455U,
    DISPID_IHTMLDOCUMENT7_DEFAULTVIEW                     = 0x00000456U,
    DISPID_IHTMLDOCUMENT7_CREATECDATASECTION              = 0x00000463U,
    DISPID_IHTMLDOCUMENT7_GETSELECTION                    = 0x00000458U,
    DISPID_IHTMLDOCUMENT7_GETELEMENTSBYTAGNAMENS          = 0x00000459U,
    DISPID_IHTMLDOCUMENT7_CREATEELEMENTNS                 = 0x0000045aU,
    DISPID_IHTMLDOCUMENT7_CREATEATTRIBUTENS               = 0x0000045bU,
    DISPID_IHTMLDOCUMENT7_ONMSTHUMBNAILCLICK              = 0x000117e9U,
    DISPID_IHTMLDOCUMENT7_CHARACTERSET                    = 0x0000045dU,
    DISPID_IHTMLDOCUMENT7_IE9_CREATEELEMENT               = 0x0000045eU,
    DISPID_IHTMLDOCUMENT7_IE9_CREATEATTRIBUTE             = 0x0000045fU,
    DISPID_IHTMLDOCUMENT7_GETELEMENTSBYCLASSNAME          = 0x00000460U,
    DISPID_IHTMLDOCUMENT7_CREATEPROCESSINGINSTRUCTION     = 0x00000464U,
    DISPID_IHTMLDOCUMENT7_ADOPTNODE                       = 0x00000465U,
    DISPID_IHTMLDOCUMENT7_ONMSSITEMODEJUMPLISTITEMREMOVED = 0x000117f2U,
    DISPID_IHTMLDOCUMENT7_IE9_ALL                         = 0x00000466U,
    DISPID_IHTMLDOCUMENT7_INPUTENCODING                   = 0x00000467U,
    DISPID_IHTMLDOCUMENT7_XMLENCODING                     = 0x00000468U,
    DISPID_IHTMLDOCUMENT7_XMLSTANDALONE                   = 0x00000469U,
    DISPID_IHTMLDOCUMENT7_XMLVERSION                      = 0x0000046aU,
    DISPID_IHTMLDOCUMENT7_HASATTRIBUTES                   = 0x0000046cU,
    DISPID_IHTMLDOCUMENT7_ONABORT                         = 0x0001178cU,
    DISPID_IHTMLDOCUMENT7_ONBLUR                          = 0x0001177fU,
    DISPID_IHTMLDOCUMENT7_ONCANPLAY                       = 0x000117f6U,
    DISPID_IHTMLDOCUMENT7_ONCANPLAYTHROUGH                = 0x000117f7U,
    DISPID_IHTMLDOCUMENT7_ONCHANGE                        = 0x0001178eU,
    DISPID_IHTMLDOCUMENT7_ONDRAG                          = 0x000117a1U,
    DISPID_IHTMLDOCUMENT7_ONDRAGEND                       = 0x000117a2U,
    DISPID_IHTMLDOCUMENT7_ONDRAGENTER                     = 0x000117a3U,
    DISPID_IHTMLDOCUMENT7_ONDRAGLEAVE                     = 0x000117a5U,
    DISPID_IHTMLDOCUMENT7_ONDRAGOVER                      = 0x000117a4U,
    DISPID_IHTMLDOCUMENT7_ONDROP                          = 0x000117a6U,
    DISPID_IHTMLDOCUMENT7_ONDURATIONCHANGE                = 0x000117f8U,
    DISPID_IHTMLDOCUMENT7_ONEMPTIED                       = 0x000117f9U,
    DISPID_IHTMLDOCUMENT7_ONENDED                         = 0x000117faU,
    DISPID_IHTMLDOCUMENT7_ONERROR                         = 0x0001178dU,
    DISPID_IHTMLDOCUMENT7_ONFOCUS                         = 0x0001177eU,
    DISPID_IHTMLDOCUMENT7_ONINPUT                         = 0x000117efU,
    DISPID_IHTMLDOCUMENT7_ONLOAD                          = 0x00011790U,
    DISPID_IHTMLDOCUMENT7_ONLOADEDDATA                    = 0x000117fbU,
    DISPID_IHTMLDOCUMENT7_ONLOADEDMETADATA                = 0x000117fcU,
    DISPID_IHTMLDOCUMENT7_ONLOADSTART                     = 0x000117fdU,
    DISPID_IHTMLDOCUMENT7_ONPAUSE                         = 0x000117feU,
    DISPID_IHTMLDOCUMENT7_ONPLAY                          = 0x000117ffU,
    DISPID_IHTMLDOCUMENT7_ONPLAYING                       = 0x00011800U,
    DISPID_IHTMLDOCUMENT7_ONPROGRESS                      = 0x00011801U,
    DISPID_IHTMLDOCUMENT7_ONRATECHANGE                    = 0x00011802U,
    DISPID_IHTMLDOCUMENT7_ONRESET                         = 0x0001177cU,
    DISPID_IHTMLDOCUMENT7_ONSCROLL                        = 0x0001178fU,
    DISPID_IHTMLDOCUMENT7_ONSEEKED                        = 0x00011803U,
    DISPID_IHTMLDOCUMENT7_ONSEEKING                       = 0x00011804U,
    DISPID_IHTMLDOCUMENT7_ONSELECT                        = 0x0001177aU,
    DISPID_IHTMLDOCUMENT7_ONSTALLED                       = 0x00011805U,
    DISPID_IHTMLDOCUMENT7_ONSUBMIT                        = 0x0001177bU,
    DISPID_IHTMLDOCUMENT7_ONSUSPEND                       = 0x00011806U,
    DISPID_IHTMLDOCUMENT7_ONTIMEUPDATE                    = 0x00011807U,
    DISPID_IHTMLDOCUMENT7_ONVOLUMECHANGE                  = 0x00011808U,
    DISPID_IHTMLDOCUMENT7_ONWAITING                       = 0x00011809U,
    DISPID_IHTMLDOCUMENT7_NORMALIZE                       = 0x0000046eU,
    DISPID_IHTMLDOCUMENT7_IMPORTNODE                      = 0x0000046fU,
    DISPID_IHTMLDOCUMENT7_IE9_PARENTWINDOW                = 0x00000470U,
    DISPID_IHTMLDOCUMENT7_IE9_BODY                        = 0x00000471U,
    DISPID_IHTMLDOCUMENT7_HEAD                            = 0x00000472U,
    DISPID_IHTMLDOCUMENT8_ONMSCONTENTZOOM                 = 0x0001181cU,
    DISPID_IHTMLDOCUMENT8_ONMSPOINTERDOWN                 = 0x0001180aU,
    DISPID_IHTMLDOCUMENT8_ONMSPOINTERMOVE                 = 0x0001180bU,
    DISPID_IHTMLDOCUMENT8_ONMSPOINTERUP                   = 0x0001180cU,
    DISPID_IHTMLDOCUMENT8_ONMSPOINTEROVER                 = 0x0001180dU,
    DISPID_IHTMLDOCUMENT8_ONMSPOINTEROUT                  = 0x0001180eU,
    DISPID_IHTMLDOCUMENT8_ONMSPOINTERCANCEL               = 0x0001180fU,
    DISPID_IHTMLDOCUMENT8_ONMSPOINTERHOVER                = 0x00011810U,
    DISPID_IHTMLDOCUMENT8_ONMSGESTURESTART                = 0x00011813U,
    DISPID_IHTMLDOCUMENT8_ONMSGESTURECHANGE               = 0x00011814U,
    DISPID_IHTMLDOCUMENT8_ONMSGESTUREEND                  = 0x00011815U,
    DISPID_IHTMLDOCUMENT8_ONMSGESTUREHOLD                 = 0x00011816U,
    DISPID_IHTMLDOCUMENT8_ONMSGESTURETAP                  = 0x00011817U,
    DISPID_IHTMLDOCUMENT8_ONMSGESTUREDOUBLETAP            = 0x00011818U,
    DISPID_IHTMLDOCUMENT8_ONMSINERTIASTART                = 0x00011819U,
    DISPID_IHTMLDOCUMENT8_ELEMENTSFROMPOINT               = 0x00000473U,
    DISPID_IHTMLDOCUMENT8_ELEMENTSFROMRECT                = 0x00000474U,
    DISPID_IHTMLDOCUMENT8_ONMSMANIPULATIONSTATECHANGED    = 0x00011822U,
    DISPID_IHTMLDOCUMENT8_MSCAPSLOCKWARNINGOFF            = 0x00000475U,
}

enum : uint
{
    DISPID_IDOCUMENTEVENT_CREATEEVENT         = 0x00000454U,
    DISPID_IDOCUMENTRANGE_CREATERANGE         = 0x00000457U,
    DISPID_IDOCUMENTSELECTOR_QUERYSELECTOR    = 0x00000451U,
    DISPID_IDOCUMENTSELECTOR_QUERYSELECTORALL = 0x00000452U,
}

enum : uint
{
    DISPID_IDOCUMENTTRAVERSAL_CREATENODEITERATOR = 0x00000461U,
    DISPID_IDOCUMENTTRAVERSAL_CREATETREEWALKER   = 0x00000462U,
}

enum : uint
{
    DISPID_HTMLDOCUMENTEVENTS4_ONMSTHUMBNAILCLICK              = 0x000117e9U,
    DISPID_HTMLDOCUMENTEVENTS4_ONMSSITEMODEJUMPLISTITEMREMOVED = 0x000117f2U,
    DISPID_HTMLDOCUMENTEVENTS3_ONSTORAGE                       = 0x00000421U,
    DISPID_HTMLDOCUMENTEVENTS3_ONSTORAGECOMMIT                 = 0x00000422U,
    DISPID_HTMLDOCUMENTEVENTS2_ONHELP                          = 0x0001000aU,
}

enum : int
{
    DISPID_HTMLDOCUMENTEVENTS2_ONCLICK     = 0xfffffda8,
    DISPID_HTMLDOCUMENTEVENTS2_ONDBLCLICK  = 0xfffffda7,
    DISPID_HTMLDOCUMENTEVENTS2_ONKEYDOWN   = 0xfffffda6,
    DISPID_HTMLDOCUMENTEVENTS2_ONKEYUP     = 0xfffffda4,
    DISPID_HTMLDOCUMENTEVENTS2_ONKEYPRESS  = 0xfffffda5,
    DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEDOWN = 0xfffffda3,
    DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEMOVE = 0xfffffda2,
    DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEUP   = 0xfffffda1,
}

enum : uint
{
    DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEOUT  = 0x00010009U,
    DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEOVER = 0x00010008U,
}

enum int DISPID_HTMLDOCUMENTEVENTS2_ONREADYSTATECHANGE = 0xfffffd9f;

enum : uint
{
    DISPID_HTMLDOCUMENTEVENTS2_ONBEFOREUPDATE     = 0x00010004U,
    DISPID_HTMLDOCUMENTEVENTS2_ONAFTERUPDATE      = 0x00010005U,
    DISPID_HTMLDOCUMENTEVENTS2_ONROWEXIT          = 0x00010006U,
    DISPID_HTMLDOCUMENTEVENTS2_ONROWENTER         = 0x00010007U,
    DISPID_HTMLDOCUMENTEVENTS2_ONDRAGSTART        = 0x0001000bU,
    DISPID_HTMLDOCUMENTEVENTS2_ONSELECTSTART      = 0x0001000cU,
    DISPID_HTMLDOCUMENTEVENTS2_ONERRORUPDATE      = 0x0001000dU,
    DISPID_HTMLDOCUMENTEVENTS2_ONCONTEXTMENU      = 0x000003ffU,
    DISPID_HTMLDOCUMENTEVENTS2_ONSTOP             = 0x00000402U,
    DISPID_HTMLDOCUMENTEVENTS2_ONROWSDELETE       = 0x00010020U,
    DISPID_HTMLDOCUMENTEVENTS2_ONROWSINSERTED     = 0x00010021U,
    DISPID_HTMLDOCUMENTEVENTS2_ONCELLCHANGE       = 0x00010022U,
    DISPID_HTMLDOCUMENTEVENTS2_ONPROPERTYCHANGE   = 0x00010013U,
    DISPID_HTMLDOCUMENTEVENTS2_ONDATASETCHANGED   = 0x0001000eU,
    DISPID_HTMLDOCUMENTEVENTS2_ONDATAAVAILABLE    = 0x0001000fU,
    DISPID_HTMLDOCUMENTEVENTS2_ONDATASETCOMPLETE  = 0x00010010U,
    DISPID_HTMLDOCUMENTEVENTS2_ONBEFOREEDITFOCUS  = 0x00000403U,
    DISPID_HTMLDOCUMENTEVENTS2_ONSELECTIONCHANGE  = 0x0000040dU,
    DISPID_HTMLDOCUMENTEVENTS2_ONCONTROLSELECT    = 0x0000040cU,
    DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEWHEEL       = 0x00000409U,
    DISPID_HTMLDOCUMENTEVENTS2_ONFOCUSIN          = 0x00000418U,
    DISPID_HTMLDOCUMENTEVENTS2_ONFOCUSOUT         = 0x00000419U,
    DISPID_HTMLDOCUMENTEVENTS2_ONACTIVATE         = 0x00000414U,
    DISPID_HTMLDOCUMENTEVENTS2_ONDEACTIVATE       = 0x00000415U,
    DISPID_HTMLDOCUMENTEVENTS2_ONBEFOREACTIVATE   = 0x00000417U,
    DISPID_HTMLDOCUMENTEVENTS2_ONBEFOREDEACTIVATE = 0x0000040aU,
    DISPID_HTMLDOCUMENTEVENTS_ONHELP              = 0x0001000aU,
}

enum : int
{
    DISPID_HTMLDOCUMENTEVENTS_ONCLICK     = 0xfffffda8,
    DISPID_HTMLDOCUMENTEVENTS_ONDBLCLICK  = 0xfffffda7,
    DISPID_HTMLDOCUMENTEVENTS_ONKEYDOWN   = 0xfffffda6,
    DISPID_HTMLDOCUMENTEVENTS_ONKEYUP     = 0xfffffda4,
    DISPID_HTMLDOCUMENTEVENTS_ONKEYPRESS  = 0xfffffda5,
    DISPID_HTMLDOCUMENTEVENTS_ONMOUSEDOWN = 0xfffffda3,
    DISPID_HTMLDOCUMENTEVENTS_ONMOUSEMOVE = 0xfffffda2,
    DISPID_HTMLDOCUMENTEVENTS_ONMOUSEUP   = 0xfffffda1,
}

enum : uint
{
    DISPID_HTMLDOCUMENTEVENTS_ONMOUSEOUT  = 0x00010009U,
    DISPID_HTMLDOCUMENTEVENTS_ONMOUSEOVER = 0x00010008U,
}

enum int DISPID_HTMLDOCUMENTEVENTS_ONREADYSTATECHANGE = 0xfffffd9f;

enum : uint
{
    DISPID_HTMLDOCUMENTEVENTS_ONBEFOREUPDATE     = 0x00010004U,
    DISPID_HTMLDOCUMENTEVENTS_ONAFTERUPDATE      = 0x00010005U,
    DISPID_HTMLDOCUMENTEVENTS_ONROWEXIT          = 0x00010006U,
    DISPID_HTMLDOCUMENTEVENTS_ONROWENTER         = 0x00010007U,
    DISPID_HTMLDOCUMENTEVENTS_ONDRAGSTART        = 0x0001000bU,
    DISPID_HTMLDOCUMENTEVENTS_ONSELECTSTART      = 0x0001000cU,
    DISPID_HTMLDOCUMENTEVENTS_ONERRORUPDATE      = 0x0001000dU,
    DISPID_HTMLDOCUMENTEVENTS_ONCONTEXTMENU      = 0x000003ffU,
    DISPID_HTMLDOCUMENTEVENTS_ONSTOP             = 0x00000402U,
    DISPID_HTMLDOCUMENTEVENTS_ONROWSDELETE       = 0x00010020U,
    DISPID_HTMLDOCUMENTEVENTS_ONROWSINSERTED     = 0x00010021U,
    DISPID_HTMLDOCUMENTEVENTS_ONCELLCHANGE       = 0x00010022U,
    DISPID_HTMLDOCUMENTEVENTS_ONPROPERTYCHANGE   = 0x00010013U,
    DISPID_HTMLDOCUMENTEVENTS_ONDATASETCHANGED   = 0x0001000eU,
    DISPID_HTMLDOCUMENTEVENTS_ONDATAAVAILABLE    = 0x0001000fU,
    DISPID_HTMLDOCUMENTEVENTS_ONDATASETCOMPLETE  = 0x00010010U,
    DISPID_HTMLDOCUMENTEVENTS_ONBEFOREEDITFOCUS  = 0x00000403U,
    DISPID_HTMLDOCUMENTEVENTS_ONSELECTIONCHANGE  = 0x0000040dU,
    DISPID_HTMLDOCUMENTEVENTS_ONCONTROLSELECT    = 0x0000040cU,
    DISPID_HTMLDOCUMENTEVENTS_ONMOUSEWHEEL       = 0x00000409U,
    DISPID_HTMLDOCUMENTEVENTS_ONFOCUSIN          = 0x00000418U,
    DISPID_HTMLDOCUMENTEVENTS_ONFOCUSOUT         = 0x00000419U,
    DISPID_HTMLDOCUMENTEVENTS_ONACTIVATE         = 0x00000414U,
    DISPID_HTMLDOCUMENTEVENTS_ONDEACTIVATE       = 0x00000415U,
    DISPID_HTMLDOCUMENTEVENTS_ONBEFOREACTIVATE   = 0x00000417U,
    DISPID_HTMLDOCUMENTEVENTS_ONBEFOREDEACTIVATE = 0x0000040aU,
}

enum : uint
{
    DISPID_IWEBBRIDGE_URL       = 0x00000001U,
    DISPID_IWEBBRIDGE_SCROLLBAR = 0x00000002U,
    DISPID_IWEBBRIDGE_EMBED     = 0x00000003U,
    DISPID_IWEBBRIDGE_EVENT     = 0x00000480U,
}

enum : int
{
    DISPID_IWEBBRIDGE_READYSTATE = 0xfffffdf3,
    DISPID_IWEBBRIDGE_ABOUTBOX   = 0xfffffdd8,
}

enum : uint
{
    DISPID_IWBSCRIPTCONTROL_RAISEEVENT         = 0x00000001U,
    DISPID_IWBSCRIPTCONTROL_BUBBLEEVENT        = 0x00000002U,
    DISPID_IWBSCRIPTCONTROL_SETCONTEXTMENU     = 0x00000003U,
    DISPID_IWBSCRIPTCONTROL_SELECTABLECONTENT  = 0x00000004U,
    DISPID_IWBSCRIPTCONTROL_FROZEN             = 0x00000005U,
    DISPID_IWBSCRIPTCONTROL_SCROLLBAR          = 0x00000007U,
    DISPID_IWBSCRIPTCONTROL_VERSION            = 0x00000008U,
    DISPID_IWBSCRIPTCONTROL_VISIBILITY         = 0x00000009U,
    DISPID_IWBSCRIPTCONTROL_ONVISIBILITYCHANGE = 0x0000000aU,
}

enum uint DISPID_DWEBBRIDGEEVENTS_ONSCRIPTLETEVENT = 0x00000001U;

enum : int
{
    DISPID_DWEBBRIDGEEVENTS_ONREADYSTATECHANGE = 0xfffffd9f,
    DISPID_DWEBBRIDGEEVENTS_ONCLICK            = 0xfffffda8,
    DISPID_DWEBBRIDGEEVENTS_ONDBLCLICK         = 0xfffffda7,
    DISPID_DWEBBRIDGEEVENTS_ONKEYDOWN          = 0xfffffda6,
    DISPID_DWEBBRIDGEEVENTS_ONKEYUP            = 0xfffffda4,
    DISPID_DWEBBRIDGEEVENTS_ONKEYPRESS         = 0xfffffda5,
    DISPID_DWEBBRIDGEEVENTS_ONMOUSEDOWN        = 0xfffffda3,
    DISPID_DWEBBRIDGEEVENTS_ONMOUSEMOVE        = 0xfffffda2,
    DISPID_DWEBBRIDGEEVENTS_ONMOUSEUP          = 0xfffffda1,
}

enum : uint
{
    DISPID_IHTMLEMBEDELEMENT_HIDDEN           = 0x00010bc2U,
    DISPID_IHTMLEMBEDELEMENT_PALETTE          = 0x00010bbcU,
    DISPID_IHTMLEMBEDELEMENT_PLUGINSPAGE      = 0x00010bbdU,
    DISPID_IHTMLEMBEDELEMENT_SRC              = 0x00010bbeU,
    DISPID_IHTMLEMBEDELEMENT_UNITS            = 0x00010bc0U,
    DISPID_IHTMLEMBEDELEMENT_NAME             = 0x00010000U,
    DISPID_IHTMLEMBEDELEMENT_WIDTH            = 0x00010005U,
    DISPID_IHTMLEMBEDELEMENT_HEIGHT           = 0x00010006U,
    DISPID_IHTMLEMBEDELEMENT2_IE8_SRC         = 0x0000047eU,
    DISPID_IHTMLEMBEDELEMENT2_IE8_PLUGINSPAGE = 0x0000047fU,
}

enum uint DISPID_IHTMLAREASCOLLECTION_LENGTH = 0x000005dcU;
enum int DISPID_IHTMLAREASCOLLECTION__NEWENUM = 0xfffffffc;

enum : uint
{
    DISPID_IHTMLAREASCOLLECTION_ITEM           = 0x00000000U,
    DISPID_IHTMLAREASCOLLECTION_TAGS           = 0x000005deU,
    DISPID_IHTMLAREASCOLLECTION_ADD            = 0x000005dfU,
    DISPID_IHTMLAREASCOLLECTION_REMOVE         = 0x000005e0U,
    DISPID_IHTMLAREASCOLLECTION2_URNS          = 0x000005e1U,
    DISPID_IHTMLAREASCOLLECTION3_NAMEDITEM     = 0x000005e2U,
    DISPID_IHTMLAREASCOLLECTION4_IE8_LENGTH    = 0x0000047eU,
    DISPID_IHTMLAREASCOLLECTION4_IE8_ITEM      = 0x00000480U,
    DISPID_IHTMLAREASCOLLECTION4_IE8_NAMEDITEM = 0x00000481U,
}

enum : uint
{
    DISPID_IHTMLMAPELEMENT_AREAS        = 0x000003eaU,
    DISPID_IHTMLMAPELEMENT_NAME         = 0x00010000U,
    DISPID_IHTMLAREAELEMENT_SHAPE       = 0x000003e9U,
    DISPID_IHTMLAREAELEMENT_COORDS      = 0x000003eaU,
    DISPID_IHTMLAREAELEMENT_HREF        = 0x00000000U,
    DISPID_IHTMLAREAELEMENT_TARGET      = 0x000003ecU,
    DISPID_IHTMLAREAELEMENT_ALT         = 0x000003edU,
    DISPID_IHTMLAREAELEMENT_NOHREF      = 0x000003eeU,
    DISPID_IHTMLAREAELEMENT_HOST        = 0x000003efU,
    DISPID_IHTMLAREAELEMENT_HOSTNAME    = 0x000003f0U,
    DISPID_IHTMLAREAELEMENT_PATHNAME    = 0x000003f1U,
    DISPID_IHTMLAREAELEMENT_PORT        = 0x000003f2U,
    DISPID_IHTMLAREAELEMENT_PROTOCOL    = 0x000003f3U,
    DISPID_IHTMLAREAELEMENT_SEARCH      = 0x000003f4U,
    DISPID_IHTMLAREAELEMENT_HASH        = 0x000003f5U,
    DISPID_IHTMLAREAELEMENT_ONBLUR      = 0x0001177fU,
    DISPID_IHTMLAREAELEMENT_ONFOCUS     = 0x0001177eU,
    DISPID_IHTMLAREAELEMENT_TABINDEX    = 0x0001000fU,
    DISPID_IHTMLAREAELEMENT_FOCUS       = 0x000107d0U,
    DISPID_IHTMLAREAELEMENT_BLUR        = 0x000107d2U,
    DISPID_IHTMLAREAELEMENT2_IE8_SHAPE  = 0x0000047fU,
    DISPID_IHTMLAREAELEMENT2_IE8_COORDS = 0x00000480U,
    DISPID_IHTMLAREAELEMENT2_IE8_HREF   = 0x00000481U,
}

enum : uint
{
    DISPID_IHTMLTABLECAPTION_ALIGN  = 0x00010048U,
    DISPID_IHTMLTABLECAPTION_VALIGN = 0x000113a7U,
}

enum : uint
{
    DISPID_IHTMLCOMMENTELEMENT_TEXT               = 0x000003e9U,
    DISPID_IHTMLCOMMENTELEMENT_ATOMIC             = 0x000003eaU,
    DISPID_IHTMLCOMMENTELEMENT2_DATA              = 0x000003ebU,
    DISPID_IHTMLCOMMENTELEMENT2_LENGTH            = 0x000003ecU,
    DISPID_IHTMLCOMMENTELEMENT2_SUBSTRINGDATA     = 0x000003edU,
    DISPID_IHTMLCOMMENTELEMENT2_APPENDDATA        = 0x000003eeU,
    DISPID_IHTMLCOMMENTELEMENT2_INSERTDATA        = 0x000003efU,
    DISPID_IHTMLCOMMENTELEMENT2_DELETEDATA        = 0x000003f0U,
    DISPID_IHTMLCOMMENTELEMENT2_REPLACEDATA       = 0x000003f1U,
    DISPID_IHTMLCOMMENTELEMENT3_IE9_SUBSTRINGDATA = 0x000003f2U,
    DISPID_IHTMLCOMMENTELEMENT3_IE9_INSERTDATA    = 0x000003f3U,
    DISPID_IHTMLCOMMENTELEMENT3_IE9_DELETEDATA    = 0x000003f4U,
    DISPID_IHTMLCOMMENTELEMENT3_IE9_REPLACEDATA   = 0x000003f5U,
}

enum : uint
{
    DISPID_IHTMLPHRASEELEMENT2_CITE     = 0x000003e9U,
    DISPID_IHTMLPHRASEELEMENT2_DATETIME = 0x000003eaU,
    DISPID_IHTMLPHRASEELEMENT3_IE8_CITE = 0x0000047eU,
}

enum : uint
{
    DISPID_IHTMLTABLE_COLS        = 0x000003e9U,
    DISPID_IHTMLTABLE_BORDER      = 0x000003eaU,
    DISPID_IHTMLTABLE_FRAME       = 0x000003ecU,
    DISPID_IHTMLTABLE_RULES       = 0x000003ebU,
    DISPID_IHTMLTABLE_CELLSPACING = 0x000003edU,
    DISPID_IHTMLTABLE_CELLPADDING = 0x000003eeU,
    DISPID_IHTMLTABLE_BACKGROUND  = 0x00011389U,
}

enum int DISPID_IHTMLTABLE_BGCOLOR = 0xfffffe0b;

enum : uint
{
    DISPID_IHTMLTABLE_BORDERCOLOR        = 0x000113a4U,
    DISPID_IHTMLTABLE_BORDERCOLORLIGHT   = 0x000113a5U,
    DISPID_IHTMLTABLE_BORDERCOLORDARK    = 0x000113a6U,
    DISPID_IHTMLTABLE_ALIGN              = 0x00010049U,
    DISPID_IHTMLTABLE_REFRESH            = 0x000003f7U,
    DISPID_IHTMLTABLE_ROWS               = 0x000003f8U,
    DISPID_IHTMLTABLE_WIDTH              = 0x00010005U,
    DISPID_IHTMLTABLE_HEIGHT             = 0x00010006U,
    DISPID_IHTMLTABLE_DATAPAGESIZE       = 0x000003f9U,
    DISPID_IHTMLTABLE_NEXTPAGE           = 0x000003faU,
    DISPID_IHTMLTABLE_PREVIOUSPAGE       = 0x000003fbU,
    DISPID_IHTMLTABLE_THEAD              = 0x000003fcU,
    DISPID_IHTMLTABLE_TFOOT              = 0x000003fdU,
    DISPID_IHTMLTABLE_TBODIES            = 0x00000400U,
    DISPID_IHTMLTABLE_CAPTION            = 0x00000401U,
    DISPID_IHTMLTABLE_CREATETHEAD        = 0x00000402U,
    DISPID_IHTMLTABLE_DELETETHEAD        = 0x00000403U,
    DISPID_IHTMLTABLE_CREATETFOOT        = 0x00000404U,
    DISPID_IHTMLTABLE_DELETETFOOT        = 0x00000405U,
    DISPID_IHTMLTABLE_CREATECAPTION      = 0x00000406U,
    DISPID_IHTMLTABLE_DELETECAPTION      = 0x00000407U,
    DISPID_IHTMLTABLE_INSERTROW          = 0x00000408U,
    DISPID_IHTMLTABLE_DELETEROW          = 0x00000409U,
    DISPID_IHTMLTABLE_READYSTATE         = 0x000113fcU,
    DISPID_IHTMLTABLE_ONREADYSTATECHANGE = 0x00011789U,
    DISPID_IHTMLTABLE2_FIRSTPAGE         = 0x0000040bU,
    DISPID_IHTMLTABLE2_LASTPAGE          = 0x0000040cU,
    DISPID_IHTMLTABLE2_CELLS             = 0x0000040dU,
    DISPID_IHTMLTABLE2_MOVEROW           = 0x0000040eU,
    DISPID_IHTMLTABLE3_SUMMARY           = 0x0000040fU,
    DISPID_IHTMLTABLE4_IE9_THEAD         = 0x00000410U,
    DISPID_IHTMLTABLE4_IE9_TFOOT         = 0x00000411U,
    DISPID_IHTMLTABLE4_IE9_CAPTION       = 0x00000412U,
    DISPID_IHTMLTABLE4_IE9_INSERTROW     = 0x00000413U,
    DISPID_IHTMLTABLE4_IE9_DELETEROW     = 0x00000414U,
    DISPID_IHTMLTABLE4_CREATETBODY       = 0x00000415U,
    DISPID_IHTMLTABLECOL_SPAN            = 0x000003e9U,
    DISPID_IHTMLTABLECOL_WIDTH           = 0x00010005U,
    DISPID_IHTMLTABLECOL_ALIGN           = 0x00010048U,
    DISPID_IHTMLTABLECOL_VALIGN          = 0x000113a7U,
    DISPID_IHTMLTABLECOL2_CH             = 0x000003eaU,
    DISPID_IHTMLTABLECOL2_CHOFF          = 0x000003ebU,
    DISPID_IHTMLTABLECOL3_IE9_CH         = 0x000003ecU,
    DISPID_IHTMLTABLECOL3_IE9_CHOFF      = 0x000003edU,
    DISPID_IHTMLTABLESECTION_ALIGN       = 0x00010048U,
    DISPID_IHTMLTABLESECTION_VALIGN      = 0x000113a7U,
}

enum int DISPID_IHTMLTABLESECTION_BGCOLOR = 0xfffffe0b;

enum : uint
{
    DISPID_IHTMLTABLESECTION_ROWS           = 0x000003e8U,
    DISPID_IHTMLTABLESECTION_INSERTROW      = 0x000003e9U,
    DISPID_IHTMLTABLESECTION_DELETEROW      = 0x000003eaU,
    DISPID_IHTMLTABLESECTION2_MOVEROW       = 0x000003ebU,
    DISPID_IHTMLTABLESECTION3_CH            = 0x000003ecU,
    DISPID_IHTMLTABLESECTION3_CHOFF         = 0x000003edU,
    DISPID_IHTMLTABLESECTION4_IE9_CH        = 0x000003eeU,
    DISPID_IHTMLTABLESECTION4_IE9_CHOFF     = 0x000003efU,
    DISPID_IHTMLTABLESECTION4_IE9_INSERTROW = 0x000003f0U,
    DISPID_IHTMLTABLESECTION4_IE9_DELETEROW = 0x000003f1U,
    DISPID_IHTMLTABLEROW_ALIGN              = 0x00010048U,
    DISPID_IHTMLTABLEROW_VALIGN             = 0x000113a7U,
}

enum int DISPID_IHTMLTABLEROW_BGCOLOR = 0xfffffe0b;

enum : uint
{
    DISPID_IHTMLTABLEROW_BORDERCOLOR         = 0x000113a4U,
    DISPID_IHTMLTABLEROW_BORDERCOLORLIGHT    = 0x000113a5U,
    DISPID_IHTMLTABLEROW_BORDERCOLORDARK     = 0x000113a6U,
    DISPID_IHTMLTABLEROW_ROWINDEX            = 0x000003e8U,
    DISPID_IHTMLTABLEROW_SECTIONROWINDEX     = 0x000003e9U,
    DISPID_IHTMLTABLEROW_CELLS               = 0x000003eaU,
    DISPID_IHTMLTABLEROW_INSERTCELL          = 0x000003ebU,
    DISPID_IHTMLTABLEROW_DELETECELL          = 0x000003ecU,
    DISPID_IHTMLTABLEROW2_HEIGHT             = 0x00010006U,
    DISPID_IHTMLTABLEROW3_CH                 = 0x000003f1U,
    DISPID_IHTMLTABLEROW3_CHOFF              = 0x000003f2U,
    DISPID_IHTMLTABLEROW4_IE9_CH             = 0x000003f3U,
    DISPID_IHTMLTABLEROW4_IE9_CHOFF          = 0x000003f4U,
    DISPID_IHTMLTABLEROW4_IE9_INSERTCELL     = 0x000003f5U,
    DISPID_IHTMLTABLEROW4_IE9_DELETECELL     = 0x000003f6U,
    DISPID_IHTMLTABLEROWMETRICS_CLIENTHEIGHT = 0x000107e3U,
    DISPID_IHTMLTABLEROWMETRICS_CLIENTWIDTH  = 0x000107e4U,
    DISPID_IHTMLTABLEROWMETRICS_CLIENTTOP    = 0x000107e5U,
    DISPID_IHTMLTABLEROWMETRICS_CLIENTLEFT   = 0x000107e6U,
    DISPID_IHTMLTABLECELL_ROWSPAN            = 0x000007d1U,
    DISPID_IHTMLTABLECELL_COLSPAN            = 0x000007d2U,
    DISPID_IHTMLTABLECELL_ALIGN              = 0x00010048U,
    DISPID_IHTMLTABLECELL_VALIGN             = 0x000113a7U,
}

enum int DISPID_IHTMLTABLECELL_BGCOLOR = 0xfffffe0b;

enum : uint
{
    DISPID_IHTMLTABLECELL_NOWRAP           = 0x0001138dU,
    DISPID_IHTMLTABLECELL_BACKGROUND       = 0x00011389U,
    DISPID_IHTMLTABLECELL_BORDERCOLOR      = 0x000113a4U,
    DISPID_IHTMLTABLECELL_BORDERCOLORLIGHT = 0x000113a5U,
    DISPID_IHTMLTABLECELL_BORDERCOLORDARK  = 0x000113a6U,
    DISPID_IHTMLTABLECELL_WIDTH            = 0x00010005U,
    DISPID_IHTMLTABLECELL_HEIGHT           = 0x00010006U,
    DISPID_IHTMLTABLECELL_CELLINDEX        = 0x000007d3U,
    DISPID_IHTMLTABLECELL2_ABBR            = 0x000007d4U,
    DISPID_IHTMLTABLECELL2_AXIS            = 0x000007d5U,
    DISPID_IHTMLTABLECELL2_CH              = 0x000007d6U,
    DISPID_IHTMLTABLECELL2_CHOFF           = 0x000007d7U,
    DISPID_IHTMLTABLECELL2_HEADERS         = 0x000007d8U,
    DISPID_IHTMLTABLECELL2_SCOPE           = 0x000007d9U,
    DISPID_IHTMLTABLECELL3_IE9_CH          = 0x000007daU,
    DISPID_IHTMLTABLECELL3_IE9_CHOFF       = 0x000007dbU,
}

enum : uint
{
    DISPID_IHTMLSCRIPTELEMENT_SRC          = 0x000003e9U,
    DISPID_IHTMLSCRIPTELEMENT_HTMLFOR      = 0x000003ecU,
    DISPID_IHTMLSCRIPTELEMENT_EVENT        = 0x000003edU,
    DISPID_IHTMLSCRIPTELEMENT_TEXT         = 0x000003eeU,
    DISPID_IHTMLSCRIPTELEMENT_DEFER        = 0x000003efU,
    DISPID_IHTMLSCRIPTELEMENT_READYSTATE   = 0x000113fcU,
    DISPID_IHTMLSCRIPTELEMENT_ONERROR      = 0x0001178dU,
    DISPID_IHTMLSCRIPTELEMENT_TYPE         = 0x000003f1U,
    DISPID_IHTMLSCRIPTELEMENT2_CHARSET     = 0x000003f2U,
    DISPID_IHTMLSCRIPTELEMENT3_IE8_SRC     = 0x0000047eU,
    DISPID_IHTMLSCRIPTELEMENT4_USEDCHARSET = 0x000003f3U,
}

enum : uint
{
    DISPID_HTMLSCRIPTEVENTS2_ONERROR = 0x000003eaU,
    DISPID_HTMLSCRIPTEVENTS_ONERROR  = 0x000003eaU,
}

enum : uint
{
    DISPID_IHTMLOBJECTELEMENT_OBJECT             = 0x00010bb9U,
    DISPID_IHTMLOBJECTELEMENT_CLASSID            = 0x00010bbaU,
    DISPID_IHTMLOBJECTELEMENT_DATA               = 0x00010bbbU,
    DISPID_IHTMLOBJECTELEMENT_RECORDSET          = 0x00010bbdU,
    DISPID_IHTMLOBJECTELEMENT_ALIGN              = 0x00010049U,
    DISPID_IHTMLOBJECTELEMENT_NAME               = 0x00010000U,
    DISPID_IHTMLOBJECTELEMENT_CODEBASE           = 0x00010bbeU,
    DISPID_IHTMLOBJECTELEMENT_CODETYPE           = 0x00010bbfU,
    DISPID_IHTMLOBJECTELEMENT_CODE               = 0x00010bc0U,
    DISPID_IHTMLOBJECTELEMENT_BASEHREF           = 0x00010002U,
    DISPID_IHTMLOBJECTELEMENT_TYPE               = 0x00010bc1U,
    DISPID_IHTMLOBJECTELEMENT_FORM               = 0x000107d4U,
    DISPID_IHTMLOBJECTELEMENT_WIDTH              = 0x00010005U,
    DISPID_IHTMLOBJECTELEMENT_HEIGHT             = 0x00010006U,
    DISPID_IHTMLOBJECTELEMENT_READYSTATE         = 0x00010bc2U,
    DISPID_IHTMLOBJECTELEMENT_ONREADYSTATECHANGE = 0x00011789U,
    DISPID_IHTMLOBJECTELEMENT_ONERROR            = 0x0001178dU,
    DISPID_IHTMLOBJECTELEMENT_ALTHTML            = 0x00010bc3U,
    DISPID_IHTMLOBJECTELEMENT_VSPACE             = 0x00010bc4U,
    DISPID_IHTMLOBJECTELEMENT_HSPACE             = 0x00010bc5U,
    DISPID_IHTMLOBJECTELEMENT2_NAMEDRECORDSET    = 0x00010bc6U,
    DISPID_IHTMLOBJECTELEMENT2_CLASSID           = 0x00010bbaU,
    DISPID_IHTMLOBJECTELEMENT2_DATA              = 0x00010bbbU,
    DISPID_IHTMLOBJECTELEMENT3_ARCHIVE           = 0x00010bc7U,
    DISPID_IHTMLOBJECTELEMENT3_ALT               = 0x00010bc8U,
    DISPID_IHTMLOBJECTELEMENT3_DECLARE           = 0x00010bc9U,
    DISPID_IHTMLOBJECTELEMENT3_STANDBY           = 0x00010bcaU,
    DISPID_IHTMLOBJECTELEMENT3_BORDER            = 0x00010bcbU,
    DISPID_IHTMLOBJECTELEMENT3_USEMAP            = 0x00010bccU,
    DISPID_IHTMLOBJECTELEMENT4_CONTENTDOCUMENT   = 0x00010bd6U,
    DISPID_IHTMLOBJECTELEMENT4_IE8_CODEBASE      = 0x00010bd7U,
    DISPID_IHTMLOBJECTELEMENT4_IE8_DATA          = 0x00010bd8U,
    DISPID_IHTMLOBJECTELEMENT5_IE9_OBJECT        = 0x00010bd9U,
}

enum : uint
{
    DISPID_IHTMLPARAMELEMENT_NAME           = 0x000003e9U,
    DISPID_IHTMLPARAMELEMENT_VALUE          = 0x000003eaU,
    DISPID_IHTMLPARAMELEMENT_TYPE           = 0x000003ebU,
    DISPID_IHTMLPARAMELEMENT_VALUETYPE      = 0x000003ecU,
    DISPID_IHTMLPARAMELEMENT2_NAME          = 0x000003e9U,
    DISPID_IHTMLPARAMELEMENT2_TYPE          = 0x000003ebU,
    DISPID_IHTMLPARAMELEMENT2_VALUE         = 0x000003eaU,
    DISPID_IHTMLPARAMELEMENT2_IE8_VALUETYPE = 0x0000047eU,
}

enum : uint
{
    DISPID_HTMLOBJECTELEMENTEVENTS2_ONBEFOREUPDATE     = 0x00010004U,
    DISPID_HTMLOBJECTELEMENTEVENTS2_ONAFTERUPDATE      = 0x00010005U,
    DISPID_HTMLOBJECTELEMENTEVENTS2_ONERRORUPDATE      = 0x0001000dU,
    DISPID_HTMLOBJECTELEMENTEVENTS2_ONROWEXIT          = 0x00010006U,
    DISPID_HTMLOBJECTELEMENTEVENTS2_ONROWENTER         = 0x00010007U,
    DISPID_HTMLOBJECTELEMENTEVENTS2_ONDATASETCHANGED   = 0x0001000eU,
    DISPID_HTMLOBJECTELEMENTEVENTS2_ONDATAAVAILABLE    = 0x0001000fU,
    DISPID_HTMLOBJECTELEMENTEVENTS2_ONDATASETCOMPLETE  = 0x00010010U,
    DISPID_HTMLOBJECTELEMENTEVENTS2_ONERROR            = 0x00010013U,
    DISPID_HTMLOBJECTELEMENTEVENTS2_ONROWSDELETE       = 0x00010020U,
    DISPID_HTMLOBJECTELEMENTEVENTS2_ONROWSINSERTED     = 0x00010021U,
    DISPID_HTMLOBJECTELEMENTEVENTS2_ONCELLCHANGE       = 0x00010022U,
    DISPID_HTMLOBJECTELEMENTEVENTS2_ONREADYSTATECHANGE = 0x00010014U,
    DISPID_HTMLOBJECTELEMENTEVENTS_ONBEFOREUPDATE      = 0x00010004U,
    DISPID_HTMLOBJECTELEMENTEVENTS_ONAFTERUPDATE       = 0x00010005U,
    DISPID_HTMLOBJECTELEMENTEVENTS_ONERRORUPDATE       = 0x0001000dU,
    DISPID_HTMLOBJECTELEMENTEVENTS_ONROWEXIT           = 0x00010006U,
    DISPID_HTMLOBJECTELEMENTEVENTS_ONROWENTER          = 0x00010007U,
    DISPID_HTMLOBJECTELEMENTEVENTS_ONDATASETCHANGED    = 0x0001000eU,
    DISPID_HTMLOBJECTELEMENTEVENTS_ONDATAAVAILABLE     = 0x0001000fU,
    DISPID_HTMLOBJECTELEMENTEVENTS_ONDATASETCOMPLETE   = 0x00010010U,
    DISPID_HTMLOBJECTELEMENTEVENTS_ONERROR             = 0x00010013U,
    DISPID_HTMLOBJECTELEMENTEVENTS_ONROWSDELETE        = 0x00010020U,
    DISPID_HTMLOBJECTELEMENTEVENTS_ONROWSINSERTED      = 0x00010021U,
    DISPID_HTMLOBJECTELEMENTEVENTS_ONCELLCHANGE        = 0x00010022U,
    DISPID_HTMLOBJECTELEMENTEVENTS_ONREADYSTATECHANGE  = 0x00010014U,
}

enum : uint
{
    DISPID_IHTMLFRAMEBASE_SRC                 = 0x00010bb8U,
    DISPID_IHTMLFRAMEBASE_NAME                = 0x00010000U,
    DISPID_IHTMLFRAMEBASE_BORDER              = 0x00010bbaU,
    DISPID_IHTMLFRAMEBASE_FRAMEBORDER         = 0x00010bbbU,
    DISPID_IHTMLFRAMEBASE_FRAMESPACING        = 0x00010bbcU,
    DISPID_IHTMLFRAMEBASE_MARGINWIDTH         = 0x00010bbdU,
    DISPID_IHTMLFRAMEBASE_MARGINHEIGHT        = 0x00010bbeU,
    DISPID_IHTMLFRAMEBASE_NORESIZE            = 0x00010bbfU,
    DISPID_IHTMLFRAMEBASE_SCROLLING           = 0x00010bc0U,
    DISPID_IHTMLFRAMEBASE2_CONTENTWINDOW      = 0x00010bc1U,
    DISPID_IHTMLFRAMEBASE2_ONLOAD             = 0x00011790U,
    DISPID_IHTMLFRAMEBASE2_ONREADYSTATECHANGE = 0x00011789U,
    DISPID_IHTMLFRAMEBASE2_READYSTATE         = 0x000113fcU,
    DISPID_IHTMLFRAMEBASE2_ALLOWTRANSPARENCY  = 0x00011456U,
    DISPID_IHTMLFRAMEBASE3_LONGDESC           = 0x00010bc2U,
}

enum : uint
{
    DISPID_HTMLFRAMESITEEVENTS2_ONLOAD = 0x000003ebU,
    DISPID_HTMLFRAMESITEEVENTS_ONLOAD  = 0x000003ebU,
}

enum : uint
{
    DISPID_IHTMLFRAMEELEMENT_BORDERCOLOR      = 0x00010fa1U,
    DISPID_IHTMLFRAMEELEMENT2_HEIGHT          = 0x00010006U,
    DISPID_IHTMLFRAMEELEMENT2_WIDTH           = 0x00010005U,
    DISPID_IHTMLFRAMEELEMENT3_CONTENTDOCUMENT = 0x00011018U,
    DISPID_IHTMLFRAMEELEMENT3_IE8_SRC         = 0x00011019U,
    DISPID_IHTMLFRAMEELEMENT3_IE8_LONGDESC    = 0x0001101aU,
    DISPID_IHTMLFRAMEELEMENT3_IE8_FRAMEBORDER = 0x0001101bU,
}

enum : uint
{
    DISPID_IHTMLIFRAMEELEMENT_VSPACE           = 0x00010fa1U,
    DISPID_IHTMLIFRAMEELEMENT_HSPACE           = 0x00010fa2U,
    DISPID_IHTMLIFRAMEELEMENT_ALIGN            = 0x00010049U,
    DISPID_IHTMLIFRAMEELEMENT2_HEIGHT          = 0x00010006U,
    DISPID_IHTMLIFRAMEELEMENT2_WIDTH           = 0x00010005U,
    DISPID_IHTMLIFRAMEELEMENT3_CONTENTDOCUMENT = 0x00011018U,
    DISPID_IHTMLIFRAMEELEMENT3_IE8_SRC         = 0x00011019U,
    DISPID_IHTMLIFRAMEELEMENT3_IE8_LONGDESC    = 0x0001101aU,
    DISPID_IHTMLIFRAMEELEMENT3_IE8_FRAMEBORDER = 0x0001101bU,
}

enum : uint
{
    DISPID_IHTMLDIVPOSITION_ALIGN     = 0x00010049U,
    DISPID_IHTMLFIELDSETELEMENT_ALIGN = 0x00010049U,
    DISPID_IHTMLFIELDSETELEMENT2_FORM = 0x000107d4U,
}

enum : uint
{
    DISPID_IHTMLLEGENDELEMENT_ALIGN = 0x00010049U,
    DISPID_IHTMLLEGENDELEMENT2_FORM = 0x000107d4U,
}

enum : uint
{
    DISPID_IHTMLSPANFLOW_ALIGN                 = 0x00010049U,
    DISPID_IHTMLFRAMESETELEMENT_ROWS           = 0x000003e8U,
    DISPID_IHTMLFRAMESETELEMENT_COLS           = 0x000003e9U,
    DISPID_IHTMLFRAMESETELEMENT_BORDER         = 0x000003eaU,
    DISPID_IHTMLFRAMESETELEMENT_BORDERCOLOR    = 0x000003ebU,
    DISPID_IHTMLFRAMESETELEMENT_FRAMEBORDER    = 0x000003ecU,
    DISPID_IHTMLFRAMESETELEMENT_FRAMESPACING   = 0x000003edU,
    DISPID_IHTMLFRAMESETELEMENT_NAME           = 0x00010000U,
    DISPID_IHTMLFRAMESETELEMENT_ONLOAD         = 0x00011790U,
    DISPID_IHTMLFRAMESETELEMENT_ONUNLOAD       = 0x00011791U,
    DISPID_IHTMLFRAMESETELEMENT_ONBEFOREUNLOAD = 0x00011797U,
    DISPID_IHTMLFRAMESETELEMENT2_ONBEFOREPRINT = 0x000117b2U,
    DISPID_IHTMLFRAMESETELEMENT2_ONAFTERPRINT  = 0x000117b3U,
    DISPID_IHTMLFRAMESETELEMENT3_ONHASHCHANGE  = 0x000117ddU,
    DISPID_IHTMLFRAMESETELEMENT3_ONMESSAGE     = 0x000117deU,
    DISPID_IHTMLFRAMESETELEMENT3_ONOFFLINE     = 0x000117dcU,
    DISPID_IHTMLFRAMESETELEMENT3_ONONLINE      = 0x000117dbU,
    DISPID_IHTMLFRAMESETELEMENT3_ONSTORAGE     = 0x000117d4U,
}

enum : uint
{
    DISPID_IHTMLBGSOUND_SRC                = 0x000003e9U,
    DISPID_IHTMLBGSOUND_LOOP               = 0x000003eaU,
    DISPID_IHTMLBGSOUND_VOLUME             = 0x000003ebU,
    DISPID_IHTMLBGSOUND_BALANCE            = 0x000003ecU,
    DISPID_IHTMLFONTNAMESCOLLECTION_LENGTH = 0x000005ddU,
}

enum int DISPID_IHTMLFONTNAMESCOLLECTION__NEWENUM = 0xfffffffc;

enum : uint
{
    DISPID_IHTMLFONTNAMESCOLLECTION_ITEM   = 0x00000000U,
    DISPID_IHTMLFONTSIZESCOLLECTION_LENGTH = 0x000005deU,
}

enum int DISPID_IHTMLFONTSIZESCOLLECTION__NEWENUM = 0xfffffffc;

enum : uint
{
    DISPID_IHTMLFONTSIZESCOLLECTION_FORFONT = 0x000005dfU,
    DISPID_IHTMLFONTSIZESCOLLECTION_ITEM    = 0x00000000U,
}

enum : uint
{
    DISPID_IHTMLOPTIONSHOLDER_DOCUMENT                  = 0x000005dfU,
    DISPID_IHTMLOPTIONSHOLDER_FONTS                     = 0x000005e0U,
    DISPID_IHTMLOPTIONSHOLDER_EXECARG                   = 0x000005e1U,
    DISPID_IHTMLOPTIONSHOLDER_ERRORLINE                 = 0x000005e2U,
    DISPID_IHTMLOPTIONSHOLDER_ERRORCHARACTER            = 0x000005e3U,
    DISPID_IHTMLOPTIONSHOLDER_ERRORCODE                 = 0x000005e4U,
    DISPID_IHTMLOPTIONSHOLDER_ERRORMESSAGE              = 0x000005e5U,
    DISPID_IHTMLOPTIONSHOLDER_ERRORDEBUG                = 0x000005e6U,
    DISPID_IHTMLOPTIONSHOLDER_UNSECUREDWINDOWOFDOCUMENT = 0x000005e7U,
    DISPID_IHTMLOPTIONSHOLDER_FINDTEXT                  = 0x000005e8U,
    DISPID_IHTMLOPTIONSHOLDER_ANYTHINGAFTERFRAMESET     = 0x000005e9U,
    DISPID_IHTMLOPTIONSHOLDER_SIZES                     = 0x000005eaU,
    DISPID_IHTMLOPTIONSHOLDER_OPENFILEDLG               = 0x000005ebU,
    DISPID_IHTMLOPTIONSHOLDER_SAVEFILEDLG               = 0x000005ecU,
    DISPID_IHTMLOPTIONSHOLDER_CHOOSECOLORDLG            = 0x000005edU,
    DISPID_IHTMLOPTIONSHOLDER_SHOWSECURITYINFO          = 0x000005eeU,
    DISPID_IHTMLOPTIONSHOLDER_ISAPARTMENTMODEL          = 0x000005efU,
    DISPID_IHTMLOPTIONSHOLDER_GETCHARSET                = 0x000005f0U,
    DISPID_IHTMLOPTIONSHOLDER_SECURECONNECTIONINFO      = 0x000005f1U,
}

enum : uint
{
    DISPID_IHTMLSTYLEELEMENT_TYPE               = 0x000003eaU,
    DISPID_IHTMLSTYLEELEMENT_READYSTATE         = 0x000113fcU,
    DISPID_IHTMLSTYLEELEMENT_ONREADYSTATECHANGE = 0x00011789U,
    DISPID_IHTMLSTYLEELEMENT_ONLOAD             = 0x00011790U,
    DISPID_IHTMLSTYLEELEMENT_ONERROR            = 0x0001178dU,
    DISPID_IHTMLSTYLEELEMENT_STYLESHEET         = 0x000003ecU,
    DISPID_IHTMLSTYLEELEMENT_DISABLED           = 0x0001004cU,
    DISPID_IHTMLSTYLEELEMENT_MEDIA              = 0x000003eeU,
    DISPID_IHTMLSTYLEELEMENT2_SHEET             = 0x000003efU,
}

enum : uint
{
    DISPID_HTMLSTYLEELEMENTEVENTS2_ONLOAD  = 0x000003ebU,
    DISPID_HTMLSTYLEELEMENTEVENTS2_ONERROR = 0x000003eaU,
    DISPID_HTMLSTYLEELEMENTEVENTS_ONLOAD   = 0x000003ebU,
    DISPID_HTMLSTYLEELEMENTEVENTS_ONERROR  = 0x000003eaU,
}

enum : uint
{
    DISPID_IHTMLSTYLEFONTFACE_FONTSRC = 0x000113e9U,
    DISPID_IHTMLSTYLEFONTFACE2_STYLE  = 0x0001004aU,
}

enum : uint
{
    DISPID_IHTMLXDOMAINREQUEST_RESPONSETEXT  = 0x000003ebU,
    DISPID_IHTMLXDOMAINREQUEST_TIMEOUT       = 0x000003ecU,
    DISPID_IHTMLXDOMAINREQUEST_CONTENTTYPE   = 0x000003edU,
    DISPID_IHTMLXDOMAINREQUEST_ONPROGRESS    = 0x000003eeU,
    DISPID_IHTMLXDOMAINREQUEST_ONERROR       = 0x0001178dU,
    DISPID_IHTMLXDOMAINREQUEST_ONTIMEOUT     = 0x000117e0U,
    DISPID_IHTMLXDOMAINREQUEST_ONLOAD        = 0x00011790U,
    DISPID_IHTMLXDOMAINREQUEST_ABORT         = 0x000003f2U,
    DISPID_IHTMLXDOMAINREQUEST_OPEN          = 0x000003f3U,
    DISPID_IHTMLXDOMAINREQUEST_SEND          = 0x000003f4U,
    DISPID_IHTMLXDOMAINREQUESTFACTORY_CREATE = 0x00000000U,
}

enum : uint
{
    DISPID_IHTMLSTORAGE_LENGTH         = 0x000003e9U,
    DISPID_IHTMLSTORAGE_REMAININGSPACE = 0x000003eaU,
    DISPID_IHTMLSTORAGE_KEY            = 0x000003eeU,
    DISPID_IHTMLSTORAGE_GETITEM        = 0x000003ebU,
    DISPID_IHTMLSTORAGE_SETITEM        = 0x000003ecU,
    DISPID_IHTMLSTORAGE_REMOVEITEM     = 0x000003edU,
    DISPID_IHTMLSTORAGE_CLEAR          = 0x000003efU,
    DISPID_IHTMLSTORAGE2_IE9_SETITEM   = 0x000003f0U,
}

enum : uint
{
    DISPID_IEVENTTARGET_ADDEVENTLISTENER    = 0x000101feU,
    DISPID_IEVENTTARGET_REMOVEEVENTLISTENER = 0x000101ffU,
    DISPID_IEVENTTARGET_DISPATCHEVENT       = 0x00010200U,
}

enum : uint
{
    DISPID_IDOMEVENT_BUBBLES                  = 0x000003e9U,
    DISPID_IDOMEVENT_CANCELABLE               = 0x000003eaU,
    DISPID_IDOMEVENT_CURRENTTARGET            = 0x000003ebU,
    DISPID_IDOMEVENT_DEFAULTPREVENTED         = 0x000003ecU,
    DISPID_IDOMEVENT_EVENTPHASE               = 0x000003edU,
    DISPID_IDOMEVENT_TARGET                   = 0x000003eeU,
    DISPID_IDOMEVENT_TIMESTAMP                = 0x000003efU,
    DISPID_IDOMEVENT_TYPE                     = 0x000003f0U,
    DISPID_IDOMEVENT_INITEVENT                = 0x000003f1U,
    DISPID_IDOMEVENT_PREVENTDEFAULT           = 0x000003f2U,
    DISPID_IDOMEVENT_STOPPROPAGATION          = 0x000003f3U,
    DISPID_IDOMEVENT_STOPIMMEDIATEPROPAGATION = 0x000003f4U,
    DISPID_IDOMEVENT_ISTRUSTED                = 0x000003f5U,
    DISPID_IDOMEVENT_CANCELBUBBLE             = 0x000003f6U,
    DISPID_IDOMEVENT_SRCELEMENT               = 0x000003f7U,
    DISPID_IDOMUIEVENT_VIEW                   = 0x00000402U,
    DISPID_IDOMUIEVENT_DETAIL                 = 0x00000403U,
    DISPID_IDOMUIEVENT_INITUIEVENT            = 0x00000404U,
}

enum : uint
{
    DISPID_IDOMMOUSEEVENT_SCREENX          = 0x0000041bU,
    DISPID_IDOMMOUSEEVENT_SCREENY          = 0x0000041cU,
    DISPID_IDOMMOUSEEVENT_CLIENTX          = 0x0000041dU,
    DISPID_IDOMMOUSEEVENT_CLIENTY          = 0x0000041eU,
    DISPID_IDOMMOUSEEVENT_CTRLKEY          = 0x0000041fU,
    DISPID_IDOMMOUSEEVENT_SHIFTKEY         = 0x00000420U,
    DISPID_IDOMMOUSEEVENT_ALTKEY           = 0x00000421U,
    DISPID_IDOMMOUSEEVENT_METAKEY          = 0x00000422U,
    DISPID_IDOMMOUSEEVENT_BUTTON           = 0x00000423U,
    DISPID_IDOMMOUSEEVENT_RELATEDTARGET    = 0x00000424U,
    DISPID_IDOMMOUSEEVENT_INITMOUSEEVENT   = 0x00000425U,
    DISPID_IDOMMOUSEEVENT_GETMODIFIERSTATE = 0x00000426U,
    DISPID_IDOMMOUSEEVENT_BUTTONS          = 0x00000427U,
    DISPID_IDOMMOUSEEVENT_FROMELEMENT      = 0x00000428U,
    DISPID_IDOMMOUSEEVENT_TOELEMENT        = 0x00000429U,
    DISPID_IDOMMOUSEEVENT_X                = 0x0000042aU,
    DISPID_IDOMMOUSEEVENT_Y                = 0x0000042bU,
    DISPID_IDOMMOUSEEVENT_OFFSETX          = 0x0000042cU,
    DISPID_IDOMMOUSEEVENT_OFFSETY          = 0x0000042dU,
    DISPID_IDOMMOUSEEVENT_PAGEX            = 0x0000042eU,
    DISPID_IDOMMOUSEEVENT_PAGEY            = 0x0000042fU,
    DISPID_IDOMMOUSEEVENT_LAYERX           = 0x00000430U,
    DISPID_IDOMMOUSEEVENT_LAYERY           = 0x00000431U,
    DISPID_IDOMMOUSEEVENT_WHICH            = 0x00000432U,
    DISPID_IDOMDRAGEVENT_DATATRANSFER      = 0x00000579U,
    DISPID_IDOMDRAGEVENT_INITDRAGEVENT     = 0x0000057aU,
}

enum : uint
{
    DISPID_IDOMMOUSEWHEELEVENT_WHEELDELTA          = 0x00000434U,
    DISPID_IDOMMOUSEWHEELEVENT_INITMOUSEWHEELEVENT = 0x00000435U,
}

enum : uint
{
    DISPID_IDOMWHEELEVENT_DELTAX         = 0x0000044dU,
    DISPID_IDOMWHEELEVENT_DELTAY         = 0x0000044eU,
    DISPID_IDOMWHEELEVENT_DELTAZ         = 0x0000044fU,
    DISPID_IDOMWHEELEVENT_DELTAMODE      = 0x00000450U,
    DISPID_IDOMWHEELEVENT_INITWHEELEVENT = 0x00000451U,
}

enum : uint
{
    DISPID_IDOMTEXTEVENT_DATA                  = 0x00000466U,
    DISPID_IDOMTEXTEVENT_INPUTMETHOD           = 0x00000467U,
    DISPID_IDOMTEXTEVENT_INITTEXTEVENT         = 0x00000468U,
    DISPID_IDOMTEXTEVENT_LOCALE                = 0x00000469U,
    DISPID_IDOMKEYBOARDEVENT_KEY               = 0x0000047fU,
    DISPID_IDOMKEYBOARDEVENT_LOCATION          = 0x00000480U,
    DISPID_IDOMKEYBOARDEVENT_CTRLKEY           = 0x00000481U,
    DISPID_IDOMKEYBOARDEVENT_SHIFTKEY          = 0x00000482U,
    DISPID_IDOMKEYBOARDEVENT_ALTKEY            = 0x00000483U,
    DISPID_IDOMKEYBOARDEVENT_METAKEY           = 0x00000484U,
    DISPID_IDOMKEYBOARDEVENT_REPEAT            = 0x00000485U,
    DISPID_IDOMKEYBOARDEVENT_GETMODIFIERSTATE  = 0x00000486U,
    DISPID_IDOMKEYBOARDEVENT_INITKEYBOARDEVENT = 0x00000487U,
    DISPID_IDOMKEYBOARDEVENT_KEYCODE           = 0x00000488U,
    DISPID_IDOMKEYBOARDEVENT_CHARCODE          = 0x00000489U,
    DISPID_IDOMKEYBOARDEVENT_WHICH             = 0x0000048aU,
    DISPID_IDOMKEYBOARDEVENT_IE9_CHAR          = 0x0000048bU,
    DISPID_IDOMKEYBOARDEVENT_LOCALE            = 0x0000048cU,
}

enum : uint
{
    DISPID_IDOMCOMPOSITIONEVENT_DATA                 = 0x00000498U,
    DISPID_IDOMCOMPOSITIONEVENT_INITCOMPOSITIONEVENT = 0x00000499U,
    DISPID_IDOMCOMPOSITIONEVENT_LOCALE               = 0x0000049aU,
}

enum : uint
{
    DISPID_IDOMMUTATIONEVENT_RELATEDNODE       = 0x000004caU,
    DISPID_IDOMMUTATIONEVENT_PREVVALUE         = 0x000004cbU,
    DISPID_IDOMMUTATIONEVENT_NEWVALUE          = 0x000004ccU,
    DISPID_IDOMMUTATIONEVENT_ATTRNAME          = 0x000004cdU,
    DISPID_IDOMMUTATIONEVENT_ATTRCHANGE        = 0x000004ceU,
    DISPID_IDOMMUTATIONEVENT_INITMUTATIONEVENT = 0x000004cfU,
}

enum uint DISPID_IDOMBEFOREUNLOADEVENT_RETURNVALUE = 0x00000560U;

enum : uint
{
    DISPID_IDOMFOCUSEVENT_RELATEDTARGET  = 0x000004e3U,
    DISPID_IDOMFOCUSEVENT_INITFOCUSEVENT = 0x000004e4U,
}

enum : uint
{
    DISPID_IDOMCUSTOMEVENT_DETAIL          = 0x000004b1U,
    DISPID_IDOMCUSTOMEVENT_INITCUSTOMEVENT = 0x000004b2U,
}

enum uint DISPID_ICANVASGRADIENT_ADDCOLORSTOP = 0x000003e8U;

enum : uint
{
    DISPID_ICANVASTEXTMETRICS_WIDTH                           = 0x000003e8U,
    DISPID_ICANVASIMAGEDATA_WIDTH                             = 0x000003e8U,
    DISPID_ICANVASIMAGEDATA_HEIGHT                            = 0x000003e9U,
    DISPID_ICANVASIMAGEDATA_DATA                              = 0x000003eaU,
    DISPID_ICANVASPIXELARRAY_LENGTH                           = 0x000003e8U,
    DISPID_ICANVASRENDERINGCONTEXT2D_CANVAS                   = 0x000003e8U,
    DISPID_ICANVASRENDERINGCONTEXT2D_RESTORE                  = 0x000003e9U,
    DISPID_ICANVASRENDERINGCONTEXT2D_SAVE                     = 0x000003eaU,
    DISPID_ICANVASRENDERINGCONTEXT2D_ROTATE                   = 0x000003ebU,
    DISPID_ICANVASRENDERINGCONTEXT2D_SCALE                    = 0x000003ecU,
    DISPID_ICANVASRENDERINGCONTEXT2D_SETTRANSFORM             = 0x000003edU,
    DISPID_ICANVASRENDERINGCONTEXT2D_TRANSFORM                = 0x000003eeU,
    DISPID_ICANVASRENDERINGCONTEXT2D_TRANSLATE                = 0x000003efU,
    DISPID_ICANVASRENDERINGCONTEXT2D_GLOBALALPHA              = 0x000003f0U,
    DISPID_ICANVASRENDERINGCONTEXT2D_GLOBALCOMPOSITEOPERATION = 0x000003f1U,
    DISPID_ICANVASRENDERINGCONTEXT2D_FILLSTYLE                = 0x000003f2U,
    DISPID_ICANVASRENDERINGCONTEXT2D_STROKESTYLE              = 0x000003f3U,
    DISPID_ICANVASRENDERINGCONTEXT2D_CREATELINEARGRADIENT     = 0x000003f4U,
    DISPID_ICANVASRENDERINGCONTEXT2D_CREATERADIALGRADIENT     = 0x000003f5U,
    DISPID_ICANVASRENDERINGCONTEXT2D_CREATEPATTERN            = 0x000003f6U,
    DISPID_ICANVASRENDERINGCONTEXT2D_LINECAP                  = 0x000003f7U,
    DISPID_ICANVASRENDERINGCONTEXT2D_LINEJOIN                 = 0x000003f8U,
    DISPID_ICANVASRENDERINGCONTEXT2D_LINEWIDTH                = 0x000003f9U,
    DISPID_ICANVASRENDERINGCONTEXT2D_MITERLIMIT               = 0x000003faU,
    DISPID_ICANVASRENDERINGCONTEXT2D_SHADOWBLUR               = 0x000003fbU,
    DISPID_ICANVASRENDERINGCONTEXT2D_SHADOWCOLOR              = 0x000003fcU,
    DISPID_ICANVASRENDERINGCONTEXT2D_SHADOWOFFSETX            = 0x000003fdU,
    DISPID_ICANVASRENDERINGCONTEXT2D_SHADOWOFFSETY            = 0x000003feU,
    DISPID_ICANVASRENDERINGCONTEXT2D_CLEARRECT                = 0x000003ffU,
    DISPID_ICANVASRENDERINGCONTEXT2D_FILLRECT                 = 0x00000400U,
    DISPID_ICANVASRENDERINGCONTEXT2D_STROKERECT               = 0x00000401U,
    DISPID_ICANVASRENDERINGCONTEXT2D_ARC                      = 0x00000402U,
    DISPID_ICANVASRENDERINGCONTEXT2D_ARCTO                    = 0x00000403U,
    DISPID_ICANVASRENDERINGCONTEXT2D_BEGINPATH                = 0x00000404U,
    DISPID_ICANVASRENDERINGCONTEXT2D_BEZIERCURVETO            = 0x00000405U,
    DISPID_ICANVASRENDERINGCONTEXT2D_CLIP                     = 0x00000406U,
    DISPID_ICANVASRENDERINGCONTEXT2D_CLOSEPATH                = 0x00000407U,
    DISPID_ICANVASRENDERINGCONTEXT2D_FILL                     = 0x00000408U,
    DISPID_ICANVASRENDERINGCONTEXT2D_LINETO                   = 0x00000409U,
    DISPID_ICANVASRENDERINGCONTEXT2D_MOVETO                   = 0x0000040aU,
    DISPID_ICANVASRENDERINGCONTEXT2D_QUADRATICCURVETO         = 0x0000040bU,
    DISPID_ICANVASRENDERINGCONTEXT2D_RECT                     = 0x0000040cU,
    DISPID_ICANVASRENDERINGCONTEXT2D_STROKE                   = 0x0000040dU,
    DISPID_ICANVASRENDERINGCONTEXT2D_ISPOINTINPATH            = 0x0000040eU,
    DISPID_ICANVASRENDERINGCONTEXT2D_FONT                     = 0x0000040fU,
    DISPID_ICANVASRENDERINGCONTEXT2D_TEXTALIGN                = 0x00000410U,
    DISPID_ICANVASRENDERINGCONTEXT2D_TEXTBASELINE             = 0x00000411U,
    DISPID_ICANVASRENDERINGCONTEXT2D_FILLTEXT                 = 0x00000412U,
    DISPID_ICANVASRENDERINGCONTEXT2D_MEASURETEXT              = 0x00000413U,
    DISPID_ICANVASRENDERINGCONTEXT2D_STROKETEXT               = 0x00000414U,
    DISPID_ICANVASRENDERINGCONTEXT2D_DRAWIMAGE                = 0x00000415U,
    DISPID_ICANVASRENDERINGCONTEXT2D_CREATEIMAGEDATA          = 0x00000416U,
    DISPID_ICANVASRENDERINGCONTEXT2D_GETIMAGEDATA             = 0x00000417U,
    DISPID_ICANVASRENDERINGCONTEXT2D_PUTIMAGEDATA             = 0x00000418U,
}

enum : uint
{
    DISPID_IHTMLCANVASELEMENT_WIDTH      = 0x00010005U,
    DISPID_IHTMLCANVASELEMENT_HEIGHT     = 0x00010006U,
    DISPID_IHTMLCANVASELEMENT_GETCONTEXT = 0x000003e9U,
    DISPID_IHTMLCANVASELEMENT_TODATAURL  = 0x000003eaU,
}

enum : uint
{
    DISPID_IDOMPROGRESSEVENT_LENGTHCOMPUTABLE  = 0x0000060fU,
    DISPID_IDOMPROGRESSEVENT_LOADED            = 0x00000610U,
    DISPID_IDOMPROGRESSEVENT_TOTAL             = 0x00000611U,
    DISPID_IDOMPROGRESSEVENT_INITPROGRESSEVENT = 0x00000612U,
}

enum : uint
{
    DISPID_IDOMMESSAGEEVENT_DATA             = 0x0000052eU,
    DISPID_IDOMMESSAGEEVENT_ORIGIN           = 0x0000052fU,
    DISPID_IDOMMESSAGEEVENT_SOURCE           = 0x00000530U,
    DISPID_IDOMMESSAGEEVENT_INITMESSAGEEVENT = 0x00000531U,
}

enum : uint
{
    DISPID_IDOMSITEMODEEVENT_BUTTONID  = 0x00000515U,
    DISPID_IDOMSITEMODEEVENT_ACTIONURL = 0x00000516U,
}

enum : uint
{
    DISPID_IDOMSTORAGEEVENT_KEY              = 0x00000547U,
    DISPID_IDOMSTORAGEEVENT_OLDVALUE         = 0x00000548U,
    DISPID_IDOMSTORAGEEVENT_NEWVALUE         = 0x00000549U,
    DISPID_IDOMSTORAGEEVENT_URL              = 0x0000054aU,
    DISPID_IDOMSTORAGEEVENT_STORAGEAREA      = 0x0000054bU,
    DISPID_IDOMSTORAGEEVENT_INITSTORAGEEVENT = 0x0000054cU,
}

enum : uint
{
    DISPID_IHTMLXMLHTTPREQUEST_READYSTATE            = 0x000003eaU,
    DISPID_IHTMLXMLHTTPREQUEST_RESPONSEBODY          = 0x000003ebU,
    DISPID_IHTMLXMLHTTPREQUEST_RESPONSETEXT          = 0x000003ecU,
    DISPID_IHTMLXMLHTTPREQUEST_RESPONSEXML           = 0x000003edU,
    DISPID_IHTMLXMLHTTPREQUEST_STATUS                = 0x000003eeU,
    DISPID_IHTMLXMLHTTPREQUEST_STATUSTEXT            = 0x000003efU,
    DISPID_IHTMLXMLHTTPREQUEST_ONREADYSTATECHANGE    = 0x00011789U,
    DISPID_IHTMLXMLHTTPREQUEST_ABORT                 = 0x000003f1U,
    DISPID_IHTMLXMLHTTPREQUEST_OPEN                  = 0x000003f2U,
    DISPID_IHTMLXMLHTTPREQUEST_SEND                  = 0x000003f3U,
    DISPID_IHTMLXMLHTTPREQUEST_GETALLRESPONSEHEADERS = 0x000003f4U,
    DISPID_IHTMLXMLHTTPREQUEST_GETRESPONSEHEADER     = 0x000003f5U,
    DISPID_IHTMLXMLHTTPREQUEST_SETREQUESTHEADER      = 0x000003f6U,
    DISPID_IHTMLXMLHTTPREQUEST2_TIMEOUT              = 0x000003f7U,
    DISPID_IHTMLXMLHTTPREQUEST2_ONTIMEOUT            = 0x000117e0U,
    DISPID_IHTMLXMLHTTPREQUESTFACTORY_CREATE         = 0x00000000U,
}

enum : uint
{
    DISPID_HTMLXMLHTTPREQUESTEVENTS_ONTIMEOUT          = 0x000003f8U,
    DISPID_HTMLXMLHTTPREQUESTEVENTS_ONREADYSTATECHANGE = 0x000003f0U,
}

enum : uint
{
    DISPID_ISVGANGLE_UNITTYPE                = 0x000003e8U,
    DISPID_ISVGANGLE_VALUE                   = 0x000003e9U,
    DISPID_ISVGANGLE_VALUEINSPECIFIEDUNITS   = 0x000003eaU,
    DISPID_ISVGANGLE_VALUEASSTRING           = 0x000003ebU,
    DISPID_ISVGANGLE_NEWVALUESPECIFIEDUNITS  = 0x000003ecU,
    DISPID_ISVGANGLE_CONVERTTOSPECIFIEDUNITS = 0x000003edU,
}

enum uint DISPID_ISVGSTYLABLE_CLASSNAME = 0x000003e9U;

enum : uint
{
    DISPID_ISVGLOCATABLE_NEARESTVIEWPORTELEMENT  = 0x000003eaU,
    DISPID_ISVGLOCATABLE_FARTHESTVIEWPORTELEMENT = 0x000003ebU,
    DISPID_ISVGLOCATABLE_GETBBOX                 = 0x000003ecU,
    DISPID_ISVGLOCATABLE_GETCTM                  = 0x000003edU,
    DISPID_ISVGLOCATABLE_GETSCREENCTM            = 0x000003eeU,
    DISPID_ISVGLOCATABLE_GETTRANSFORMTOELEMENT   = 0x000003efU,
}

enum uint DISPID_ISVGTRANSFORMABLE_TRANSFORM = 0x000003f1U;

enum : uint
{
    DISPID_ISVGTESTS_REQUIREDFEATURES   = 0x000003f3U,
    DISPID_ISVGTESTS_REQUIREDEXTENSIONS = 0x000003f5U,
    DISPID_ISVGTESTS_SYSTEMLANGUAGE     = 0x000003f7U,
    DISPID_ISVGTESTS_HASEXTENSION       = 0x000003f8U,
}

enum : uint
{
    DISPID_ISVGLANGSPACE_XMLLANG  = 0x000003f9U,
    DISPID_ISVGLANGSPACE_XMLSPACE = 0x000003faU,
}

enum uint DISPID_ISVGEXTERNALRESOURCESREQUIRED_EXTERNALRESOURCESREQUIRED = 0x000003fcU;

enum : uint
{
    DISPID_ISVGFITTOVIEWBOX_VIEWBOX             = 0x000003feU,
    DISPID_ISVGFITTOVIEWBOX_PRESERVEASPECTRATIO = 0x00000400U,
}

enum uint DISPID_ISVGZOOMANDPAN_ZOOMANDPAN = 0x00000401U;
enum uint DISPID_ISVGURIREFERENCE_HREF = 0x00000402U;

enum : uint
{
    DISPID_ISVGANIMATEDANGLE_BASEVAL         = 0x000003e8U,
    DISPID_ISVGANIMATEDANGLE_ANIMVAL         = 0x000003e9U,
    DISPID_ISVGANIMATEDTRANSFORMLIST_BASEVAL = 0x000003e8U,
    DISPID_ISVGANIMATEDTRANSFORMLIST_ANIMVAL = 0x000003e9U,
    DISPID_ISVGANIMATEDBOOLEAN_BASEVAL       = 0x000003e8U,
    DISPID_ISVGANIMATEDBOOLEAN_ANIMVAL       = 0x000003e9U,
    DISPID_ISVGANIMATEDENUMERATION_BASEVAL   = 0x000003e8U,
    DISPID_ISVGANIMATEDENUMERATION_ANIMVAL   = 0x000003e9U,
    DISPID_ISVGANIMATEDINTEGER_BASEVAL       = 0x000003e8U,
    DISPID_ISVGANIMATEDINTEGER_ANIMVAL       = 0x000003e9U,
    DISPID_ISVGANIMATEDLENGTH_BASEVAL        = 0x000003e8U,
    DISPID_ISVGANIMATEDLENGTH_ANIMVAL        = 0x000003e9U,
    DISPID_ISVGANIMATEDLENGTHLIST_BASEVAL    = 0x000003e8U,
    DISPID_ISVGANIMATEDLENGTHLIST_ANIMVAL    = 0x000003e9U,
    DISPID_ISVGANIMATEDNUMBER_BASEVAL        = 0x000003e8U,
    DISPID_ISVGANIMATEDNUMBER_ANIMVAL        = 0x000003e9U,
    DISPID_ISVGANIMATEDNUMBERLIST_BASEVAL    = 0x000003e8U,
    DISPID_ISVGANIMATEDNUMBERLIST_ANIMVAL    = 0x000003e9U,
    DISPID_ISVGANIMATEDRECT_BASEVAL          = 0x000003e8U,
    DISPID_ISVGANIMATEDRECT_ANIMVAL          = 0x000003e9U,
    DISPID_ISVGANIMATEDSTRING_BASEVAL        = 0x000003e8U,
    DISPID_ISVGANIMATEDSTRING_ANIMVAL        = 0x000003e9U,
}

enum uint DISPID_ISVGCLIPPATHELEMENT_CLIPPATHUNITS = 0x0000041bU;
enum uint DISPID_ISVGDOCUMENT_ROOTELEMENT = 0x0000045cU;
enum uint DISPID_IGETSVGDOCUMENT_GETSVGDOCUMENT = 0x0001004fU;

enum : uint
{
    DISPID_ISVGELEMENT_XMLBASE         = 0x00000408U,
    DISPID_ISVGELEMENT_OWNERSVGELEMENT = 0x00000409U,
    DISPID_ISVGELEMENT_VIEWPORTELEMENT = 0x0000040aU,
    DISPID_ISVGELEMENT_FOCUSABLE       = 0x0000040cU,
}

enum : uint
{
    DISPID_ISVGLENGTH_UNITTYPE                = 0x000003e8U,
    DISPID_ISVGLENGTH_VALUE                   = 0x000003e9U,
    DISPID_ISVGLENGTH_VALUEINSPECIFIEDUNITS   = 0x000003eaU,
    DISPID_ISVGLENGTH_VALUEASSTRING           = 0x000003ebU,
    DISPID_ISVGLENGTH_NEWVALUESPECIFIEDUNITS  = 0x000003ecU,
    DISPID_ISVGLENGTH_CONVERTTOSPECIFIEDUNITS = 0x000003edU,
    DISPID_ISVGLENGTHLIST_NUMBEROFITEMS       = 0x000003e8U,
    DISPID_ISVGLENGTHLIST_CLEAR               = 0x000003e9U,
    DISPID_ISVGLENGTHLIST_INITIALIZE          = 0x000003eaU,
    DISPID_ISVGLENGTHLIST_GETITEM             = 0x000003ebU,
    DISPID_ISVGLENGTHLIST_INSERTITEMBEFORE    = 0x000003ecU,
    DISPID_ISVGLENGTHLIST_REPLACEITEM         = 0x000003edU,
    DISPID_ISVGLENGTHLIST_REMOVEITEM          = 0x000003eeU,
    DISPID_ISVGLENGTHLIST_APPENDITEM          = 0x000003efU,
}

enum : uint
{
    DISPID_ISVGMATRIX_A                    = 0x000003e8U,
    DISPID_ISVGMATRIX_B                    = 0x000003e9U,
    DISPID_ISVGMATRIX_C                    = 0x000003eaU,
    DISPID_ISVGMATRIX_D                    = 0x000003ebU,
    DISPID_ISVGMATRIX_E                    = 0x000003ecU,
    DISPID_ISVGMATRIX_F                    = 0x000003edU,
    DISPID_ISVGMATRIX_MULTIPLY             = 0x000003eeU,
    DISPID_ISVGMATRIX_INVERSE              = 0x000003efU,
    DISPID_ISVGMATRIX_TRANSLATE            = 0x000003f0U,
    DISPID_ISVGMATRIX_SCALE                = 0x000003f1U,
    DISPID_ISVGMATRIX_SCALENONUNIFORM      = 0x000003f2U,
    DISPID_ISVGMATRIX_ROTATE               = 0x000003f3U,
    DISPID_ISVGMATRIX_ROTATEFROMVECTOR     = 0x000003f4U,
    DISPID_ISVGMATRIX_FLIPX                = 0x000003f5U,
    DISPID_ISVGMATRIX_FLIPY                = 0x000003f6U,
    DISPID_ISVGMATRIX_SKEWX                = 0x000003f7U,
    DISPID_ISVGMATRIX_SKEWY                = 0x000003f8U,
    DISPID_ISVGNUMBER_VALUE                = 0x000003e8U,
    DISPID_ISVGNUMBERLIST_NUMBEROFITEMS    = 0x000003e8U,
    DISPID_ISVGNUMBERLIST_CLEAR            = 0x000003e9U,
    DISPID_ISVGNUMBERLIST_INITIALIZE       = 0x000003eaU,
    DISPID_ISVGNUMBERLIST_GETITEM          = 0x000003ebU,
    DISPID_ISVGNUMBERLIST_INSERTITEMBEFORE = 0x000003ecU,
    DISPID_ISVGNUMBERLIST_REPLACEITEM      = 0x000003edU,
    DISPID_ISVGNUMBERLIST_REMOVEITEM       = 0x000003eeU,
    DISPID_ISVGNUMBERLIST_APPENDITEM       = 0x000003efU,
}

enum : uint
{
    DISPID_ISVGPATTERNELEMENT_PATTERNUNITS        = 0x0000041bU,
    DISPID_ISVGPATTERNELEMENT_PATTERNCONTENTUNITS = 0x0000041dU,
    DISPID_ISVGPATTERNELEMENT_PATTERNTRANSFORM    = 0x0000041fU,
    DISPID_ISVGPATTERNELEMENT_X                   = 0x00000421U,
    DISPID_ISVGPATTERNELEMENT_Y                   = 0x00000423U,
    DISPID_ISVGPATTERNELEMENT_WIDTH               = 0x00000425U,
    DISPID_ISVGPATTERNELEMENT_HEIGHT              = 0x00000427U,
    DISPID_ISVGPATHSEG_PATHSEGTYPE                = 0x000003e8U,
    DISPID_ISVGPATHSEG_PATHSEGTYPEASLETTER        = 0x000003e9U,
    DISPID_ISVGPATHSEGARCABS_X                    = 0x000003fcU,
    DISPID_ISVGPATHSEGARCABS_Y                    = 0x000003fdU,
    DISPID_ISVGPATHSEGARCABS_R1                   = 0x000003feU,
    DISPID_ISVGPATHSEGARCABS_R2                   = 0x000003ffU,
    DISPID_ISVGPATHSEGARCABS_ANGLE                = 0x00000400U,
    DISPID_ISVGPATHSEGARCABS_LARGEARCFLAG         = 0x00000401U,
    DISPID_ISVGPATHSEGARCABS_SWEEPFLAG            = 0x00000402U,
    DISPID_ISVGPATHSEGARCREL_X                    = 0x000003fcU,
    DISPID_ISVGPATHSEGARCREL_Y                    = 0x000003fdU,
    DISPID_ISVGPATHSEGARCREL_R1                   = 0x000003feU,
    DISPID_ISVGPATHSEGARCREL_R2                   = 0x000003ffU,
    DISPID_ISVGPATHSEGARCREL_ANGLE                = 0x00000400U,
    DISPID_ISVGPATHSEGARCREL_LARGEARCFLAG         = 0x00000401U,
    DISPID_ISVGPATHSEGARCREL_SWEEPFLAG            = 0x00000402U,
    DISPID_ISVGPATHSEGMOVETOABS_X                 = 0x000003fcU,
    DISPID_ISVGPATHSEGMOVETOABS_Y                 = 0x000003fdU,
    DISPID_ISVGPATHSEGMOVETOREL_X                 = 0x000003fcU,
    DISPID_ISVGPATHSEGMOVETOREL_Y                 = 0x000003fdU,
    DISPID_ISVGPATHSEGLINETOABS_X                 = 0x000003fcU,
    DISPID_ISVGPATHSEGLINETOABS_Y                 = 0x000003fdU,
    DISPID_ISVGPATHSEGLINETOREL_X                 = 0x000003fcU,
    DISPID_ISVGPATHSEGLINETOREL_Y                 = 0x000003fdU,
    DISPID_ISVGPATHSEGCURVETOCUBICABS_X           = 0x000003fcU,
    DISPID_ISVGPATHSEGCURVETOCUBICABS_Y           = 0x000003fdU,
    DISPID_ISVGPATHSEGCURVETOCUBICABS_X1          = 0x000003feU,
    DISPID_ISVGPATHSEGCURVETOCUBICABS_Y1          = 0x000003ffU,
    DISPID_ISVGPATHSEGCURVETOCUBICABS_X2          = 0x00000400U,
    DISPID_ISVGPATHSEGCURVETOCUBICABS_Y2          = 0x00000401U,
    DISPID_ISVGPATHSEGCURVETOCUBICREL_X           = 0x000003fcU,
    DISPID_ISVGPATHSEGCURVETOCUBICREL_Y           = 0x000003fdU,
    DISPID_ISVGPATHSEGCURVETOCUBICREL_X1          = 0x000003feU,
    DISPID_ISVGPATHSEGCURVETOCUBICREL_Y1          = 0x000003ffU,
    DISPID_ISVGPATHSEGCURVETOCUBICREL_X2          = 0x00000400U,
    DISPID_ISVGPATHSEGCURVETOCUBICREL_Y2          = 0x00000401U,
    DISPID_ISVGPATHSEGCURVETOCUBICSMOOTHABS_X     = 0x000003fcU,
    DISPID_ISVGPATHSEGCURVETOCUBICSMOOTHABS_Y     = 0x000003fdU,
    DISPID_ISVGPATHSEGCURVETOCUBICSMOOTHABS_X2    = 0x000003feU,
    DISPID_ISVGPATHSEGCURVETOCUBICSMOOTHABS_Y2    = 0x000003ffU,
    DISPID_ISVGPATHSEGCURVETOCUBICSMOOTHREL_X     = 0x000003fcU,
    DISPID_ISVGPATHSEGCURVETOCUBICSMOOTHREL_Y     = 0x000003fdU,
    DISPID_ISVGPATHSEGCURVETOCUBICSMOOTHREL_X2    = 0x000003feU,
    DISPID_ISVGPATHSEGCURVETOCUBICSMOOTHREL_Y2    = 0x000003ffU,
    DISPID_ISVGPATHSEGCURVETOQUADRATICABS_X       = 0x000003fcU,
    DISPID_ISVGPATHSEGCURVETOQUADRATICABS_Y       = 0x000003fdU,
    DISPID_ISVGPATHSEGCURVETOQUADRATICABS_X1      = 0x000003feU,
    DISPID_ISVGPATHSEGCURVETOQUADRATICABS_Y1      = 0x000003ffU,
    DISPID_ISVGPATHSEGCURVETOQUADRATICREL_X       = 0x000003fcU,
    DISPID_ISVGPATHSEGCURVETOQUADRATICREL_Y       = 0x000003fdU,
    DISPID_ISVGPATHSEGCURVETOQUADRATICREL_X1      = 0x000003feU,
    DISPID_ISVGPATHSEGCURVETOQUADRATICREL_Y1      = 0x000003ffU,
    DISPID_ISVGPATHSEGCURVETOQUADRATICSMOOTHABS_X = 0x000003fcU,
    DISPID_ISVGPATHSEGCURVETOQUADRATICSMOOTHABS_Y = 0x000003fdU,
    DISPID_ISVGPATHSEGCURVETOQUADRATICSMOOTHREL_X = 0x000003fcU,
    DISPID_ISVGPATHSEGCURVETOQUADRATICSMOOTHREL_Y = 0x000003fdU,
}

enum : uint
{
    DISPID_ISVGPATHSEGLINETOHORIZONTALABS_X = 0x000003fcU,
    DISPID_ISVGPATHSEGLINETOHORIZONTALREL_X = 0x000003fcU,
    DISPID_ISVGPATHSEGLINETOVERTICALABS_Y   = 0x000003fcU,
    DISPID_ISVGPATHSEGLINETOVERTICALREL_Y   = 0x000003fcU,
    DISPID_ISVGPATHSEGLIST_NUMBEROFITEMS    = 0x000003e8U,
    DISPID_ISVGPATHSEGLIST_CLEAR            = 0x000003e9U,
    DISPID_ISVGPATHSEGLIST_INITIALIZE       = 0x000003eaU,
    DISPID_ISVGPATHSEGLIST_GETITEM          = 0x000003ebU,
    DISPID_ISVGPATHSEGLIST_INSERTITEMBEFORE = 0x000003ecU,
    DISPID_ISVGPATHSEGLIST_REPLACEITEM      = 0x000003edU,
    DISPID_ISVGPATHSEGLIST_REMOVEITEM       = 0x000003eeU,
    DISPID_ISVGPATHSEGLIST_APPENDITEM       = 0x000003efU,
}

enum : uint
{
    DISPID_ISVGPOINT_X                    = 0x000003e8U,
    DISPID_ISVGPOINT_Y                    = 0x000003e9U,
    DISPID_ISVGPOINT_MATRIXTRANSFORM      = 0x000003eaU,
    DISPID_ISVGPOINTLIST_NUMBEROFITEMS    = 0x000003e8U,
    DISPID_ISVGPOINTLIST_CLEAR            = 0x000003e9U,
    DISPID_ISVGPOINTLIST_INITIALIZE       = 0x000003eaU,
    DISPID_ISVGPOINTLIST_GETITEM          = 0x000003ebU,
    DISPID_ISVGPOINTLIST_INSERTITEMBEFORE = 0x000003ecU,
    DISPID_ISVGPOINTLIST_REPLACEITEM      = 0x000003edU,
    DISPID_ISVGPOINTLIST_REMOVEITEM       = 0x000003eeU,
    DISPID_ISVGPOINTLIST_APPENDITEM       = 0x000003efU,
}

enum : uint
{
    DISPID_ISVGRECT_X                      = 0x000003e8U,
    DISPID_ISVGRECT_Y                      = 0x000003e9U,
    DISPID_ISVGRECT_WIDTH                  = 0x000003eaU,
    DISPID_ISVGRECT_HEIGHT                 = 0x000003ebU,
    DISPID_ISVGSTRINGLIST_NUMBEROFITEMS    = 0x000003e8U,
    DISPID_ISVGSTRINGLIST_CLEAR            = 0x000003e9U,
    DISPID_ISVGSTRINGLIST_INITIALIZE       = 0x000003eaU,
    DISPID_ISVGSTRINGLIST_GETITEM          = 0x000003ebU,
    DISPID_ISVGSTRINGLIST_INSERTITEMBEFORE = 0x000003ecU,
    DISPID_ISVGSTRINGLIST_REPLACEITEM      = 0x000003edU,
    DISPID_ISVGSTRINGLIST_REMOVEITEM       = 0x000003eeU,
    DISPID_ISVGSTRINGLIST_APPENDITEM       = 0x000003efU,
}

enum : uint
{
    DISPID_ISVGTRANSFORM_TYPE         = 0x000003e8U,
    DISPID_ISVGTRANSFORM_MATRIX       = 0x000003e9U,
    DISPID_ISVGTRANSFORM_ANGLE        = 0x000003eaU,
    DISPID_ISVGTRANSFORM_SETMATRIX    = 0x000003ebU,
    DISPID_ISVGTRANSFORM_SETTRANSLATE = 0x000003ecU,
    DISPID_ISVGTRANSFORM_SETSCALE     = 0x000003edU,
    DISPID_ISVGTRANSFORM_SETROTATE    = 0x000003eeU,
    DISPID_ISVGTRANSFORM_SETSKEWX     = 0x000003efU,
    DISPID_ISVGTRANSFORM_SETSKEWY     = 0x000003f0U,
}

enum : uint
{
    DISPID_ISVGSVGELEMENT_X                            = 0x0000041cU,
    DISPID_ISVGSVGELEMENT_Y                            = 0x0000041eU,
    DISPID_ISVGSVGELEMENT_WIDTH                        = 0x00000420U,
    DISPID_ISVGSVGELEMENT_HEIGHT                       = 0x00000422U,
    DISPID_ISVGSVGELEMENT_CONTENTSCRIPTTYPE            = 0x00000423U,
    DISPID_ISVGSVGELEMENT_CONTENTSTYLETYPE             = 0x00000424U,
    DISPID_ISVGSVGELEMENT_VIEWPORT                     = 0x00000425U,
    DISPID_ISVGSVGELEMENT_PIXELUNITTOMILLIMETERX       = 0x00000426U,
    DISPID_ISVGSVGELEMENT_PIXELUNITTOMILLIMETERY       = 0x00000427U,
    DISPID_ISVGSVGELEMENT_SCREENPIXELTOMILLIMETERX     = 0x00000428U,
    DISPID_ISVGSVGELEMENT_SCREENPIXELTOMILLIMETERY     = 0x00000429U,
    DISPID_ISVGSVGELEMENT_USECURRENTVIEW               = 0x0000042aU,
    DISPID_ISVGSVGELEMENT_CURRENTVIEW                  = 0x0000042bU,
    DISPID_ISVGSVGELEMENT_CURRENTSCALE                 = 0x0000042cU,
    DISPID_ISVGSVGELEMENT_CURRENTTRANSLATE             = 0x0000042dU,
    DISPID_ISVGSVGELEMENT_SUSPENDREDRAW                = 0x0000042eU,
    DISPID_ISVGSVGELEMENT_UNSUSPENDREDRAW              = 0x0000042fU,
    DISPID_ISVGSVGELEMENT_UNSUSPENDREDRAWALL           = 0x00000430U,
    DISPID_ISVGSVGELEMENT_FORCEREDRAW                  = 0x00000431U,
    DISPID_ISVGSVGELEMENT_PAUSEANIMATIONS              = 0x00000432U,
    DISPID_ISVGSVGELEMENT_UNPAUSEANIMATIONS            = 0x00000433U,
    DISPID_ISVGSVGELEMENT_ANIMATIONSPAUSED             = 0x00000434U,
    DISPID_ISVGSVGELEMENT_GETCURRENTTIME               = 0x00000435U,
    DISPID_ISVGSVGELEMENT_SETCURRENTTIME               = 0x00000436U,
    DISPID_ISVGSVGELEMENT_GETINTERSECTIONLIST          = 0x00000437U,
    DISPID_ISVGSVGELEMENT_GETENCLOSURELIST             = 0x00000438U,
    DISPID_ISVGSVGELEMENT_CHECKINTERSECTION            = 0x00000439U,
    DISPID_ISVGSVGELEMENT_CHECKENCLOSURE               = 0x0000043aU,
    DISPID_ISVGSVGELEMENT_DESELECTALL                  = 0x0000043bU,
    DISPID_ISVGSVGELEMENT_CREATESVGNUMBER              = 0x0000043cU,
    DISPID_ISVGSVGELEMENT_CREATESVGLENGTH              = 0x0000043dU,
    DISPID_ISVGSVGELEMENT_CREATESVGANGLE               = 0x0000043eU,
    DISPID_ISVGSVGELEMENT_CREATESVGPOINT               = 0x0000043fU,
    DISPID_ISVGSVGELEMENT_CREATESVGMATRIX              = 0x00000440U,
    DISPID_ISVGSVGELEMENT_CREATESVGRECT                = 0x00000441U,
    DISPID_ISVGSVGELEMENT_CREATESVGTRANSFORM           = 0x00000442U,
    DISPID_ISVGSVGELEMENT_CREATESVGTRANSFORMFROMMATRIX = 0x00000443U,
    DISPID_ISVGSVGELEMENT_GETELEMENTBYID               = 0x00000444U,
}

enum : uint
{
    DISPID_ISVGUSEELEMENT_X                    = 0x0000041cU,
    DISPID_ISVGUSEELEMENT_Y                    = 0x0000041eU,
    DISPID_ISVGUSEELEMENT_WIDTH                = 0x00000420U,
    DISPID_ISVGUSEELEMENT_HEIGHT               = 0x00000422U,
    DISPID_ISVGUSEELEMENT_INSTANCEROOT         = 0x00000423U,
    DISPID_ISVGUSEELEMENT_ANIMATEDINSTANCEROOT = 0x00000424U,
}

enum : uint
{
    DISPID_IHTMLSTYLESHEETRULESAPPLIEDCOLLECTION_ITEM                       = 0x00000000U,
    DISPID_IHTMLSTYLESHEETRULESAPPLIEDCOLLECTION_LENGTH                     = 0x000003e9U,
    DISPID_IHTMLSTYLESHEETRULESAPPLIEDCOLLECTION_PROPERTYAPPLIEDBY          = 0x000003eaU,
    DISPID_IHTMLSTYLESHEETRULESAPPLIEDCOLLECTION_PROPERTYAPPLIEDTRACE       = 0x000003ecU,
    DISPID_IHTMLSTYLESHEETRULESAPPLIEDCOLLECTION_PROPERTYAPPLIEDTRACELENGTH = 0x000003edU,
}

enum : uint
{
    DISPID_IRULESAPPLIED_ELEMENT                                = 0x000003e9U,
    DISPID_IRULESAPPLIED_INLINESTYLES                           = 0x000003eaU,
    DISPID_IRULESAPPLIED_APPLIEDRULES                           = 0x000003ebU,
    DISPID_IRULESAPPLIED_PROPERTYISINLINE                       = 0x000003ecU,
    DISPID_IRULESAPPLIED_PROPERTYISINHERITABLE                  = 0x000003edU,
    DISPID_IRULESAPPLIED_HASINHERITABLEPROPERTY                 = 0x000003eeU,
    DISPID_IRULESAPPLIEDCOLLECTION_ITEM                         = 0x00000000U,
    DISPID_IRULESAPPLIEDCOLLECTION_LENGTH                       = 0x000003e9U,
    DISPID_IRULESAPPLIEDCOLLECTION_ELEMENT                      = 0x000003eaU,
    DISPID_IRULESAPPLIEDCOLLECTION_PROPERTYINHERITEDFROM        = 0x000003ebU,
    DISPID_IRULESAPPLIEDCOLLECTION_PROPERTYCOUNT                = 0x000003ecU,
    DISPID_IRULESAPPLIEDCOLLECTION_PROPERTY                     = 0x000003edU,
    DISPID_IRULESAPPLIEDCOLLECTION_PROPERTYINHERITEDTRACE       = 0x000003eeU,
    DISPID_IRULESAPPLIEDCOLLECTION_PROPERTYINHERITEDTRACELENGTH = 0x000003efU,
}

enum : uint
{
    DISPID_ISVGTRANSFORMLIST_NUMBEROFITEMS                = 0x000003e8U,
    DISPID_ISVGTRANSFORMLIST_CLEAR                        = 0x000003e9U,
    DISPID_ISVGTRANSFORMLIST_INITIALIZE                   = 0x000003eaU,
    DISPID_ISVGTRANSFORMLIST_GETITEM                      = 0x000003ebU,
    DISPID_ISVGTRANSFORMLIST_INSERTITEMBEFORE             = 0x000003ecU,
    DISPID_ISVGTRANSFORMLIST_REPLACEITEM                  = 0x000003edU,
    DISPID_ISVGTRANSFORMLIST_REMOVEITEM                   = 0x000003eeU,
    DISPID_ISVGTRANSFORMLIST_APPENDITEM                   = 0x000003efU,
    DISPID_ISVGTRANSFORMLIST_CREATESVGTRANSFORMFROMMATRIX = 0x000003f0U,
    DISPID_ISVGTRANSFORMLIST_CONSOLIDATE                  = 0x000003f1U,
}

enum : uint
{
    DISPID_ISVGANIMATEDPOINTS_POINTS         = 0x0000041aU,
    DISPID_ISVGANIMATEDPOINTS_ANIMATEDPOINTS = 0x0000041cU,
}

enum : uint
{
    DISPID_ISVGCIRCLEELEMENT_CX  = 0x0000041cU,
    DISPID_ISVGCIRCLEELEMENT_CY  = 0x0000041eU,
    DISPID_ISVGCIRCLEELEMENT_R   = 0x00000420U,
    DISPID_ISVGELLIPSEELEMENT_CX = 0x0000041cU,
    DISPID_ISVGELLIPSEELEMENT_CY = 0x0000041eU,
    DISPID_ISVGELLIPSEELEMENT_RX = 0x00000420U,
    DISPID_ISVGELLIPSEELEMENT_RY = 0x00000422U,
}

enum : uint
{
    DISPID_ISVGLINEELEMENT_X1                                 = 0x0000041cU,
    DISPID_ISVGLINEELEMENT_Y1                                 = 0x0000041eU,
    DISPID_ISVGLINEELEMENT_X2                                 = 0x00000420U,
    DISPID_ISVGLINEELEMENT_Y2                                 = 0x00000422U,
    DISPID_ISVGRECTELEMENT_X                                  = 0x0000041cU,
    DISPID_ISVGRECTELEMENT_Y                                  = 0x0000041eU,
    DISPID_ISVGRECTELEMENT_WIDTH                              = 0x00000420U,
    DISPID_ISVGRECTELEMENT_HEIGHT                             = 0x00000422U,
    DISPID_ISVGRECTELEMENT_RX                                 = 0x00000424U,
    DISPID_ISVGRECTELEMENT_RY                                 = 0x00000426U,
    DISPID_ISVGANIMATEDPATHDATA_PATHSEGLIST                   = 0x0000041cU,
    DISPID_ISVGANIMATEDPATHDATA_NORMALIZEDPATHSEGLIST         = 0x00000434U,
    DISPID_ISVGANIMATEDPATHDATA_ANIMATEDPATHSEGLIST           = 0x00000435U,
    DISPID_ISVGANIMATEDPATHDATA_ANIMATEDNORMALIZEDPATHSEGLIST = 0x00000436U,
}

enum : uint
{
    DISPID_ISVGPATHELEMENT_PATHLENGTH                                = 0x0000041dU,
    DISPID_ISVGPATHELEMENT_GETTOTALLENGTH                            = 0x00000431U,
    DISPID_ISVGPATHELEMENT_GETPOINTATLENGTH                          = 0x00000432U,
    DISPID_ISVGPATHELEMENT_GETPATHSEGATLENGTH                        = 0x00000433U,
    DISPID_ISVGPATHELEMENT_CREATESVGPATHSEGCLOSEPATH                 = 0x0000041eU,
    DISPID_ISVGPATHELEMENT_CREATESVGPATHSEGMOVETOABS                 = 0x0000041fU,
    DISPID_ISVGPATHELEMENT_CREATESVGPATHSEGMOVETOREL                 = 0x00000420U,
    DISPID_ISVGPATHELEMENT_CREATESVGPATHSEGLINETOABS                 = 0x00000421U,
    DISPID_ISVGPATHELEMENT_CREATESVGPATHSEGLINETOREL                 = 0x00000422U,
    DISPID_ISVGPATHELEMENT_CREATESVGPATHSEGCURVETOCUBICABS           = 0x00000423U,
    DISPID_ISVGPATHELEMENT_CREATESVGPATHSEGCURVETOCUBICREL           = 0x00000424U,
    DISPID_ISVGPATHELEMENT_CREATESVGPATHSEGCURVETOQUADRATICABS       = 0x00000425U,
    DISPID_ISVGPATHELEMENT_CREATESVGPATHSEGCURVETOQUADRATICREL       = 0x00000426U,
    DISPID_ISVGPATHELEMENT_CREATESVGPATHSEGARCABS                    = 0x00000427U,
    DISPID_ISVGPATHELEMENT_CREATESVGPATHSEGARCREL                    = 0x00000428U,
    DISPID_ISVGPATHELEMENT_CREATESVGPATHSEGLINETOHORIZONTALABS       = 0x00000429U,
    DISPID_ISVGPATHELEMENT_CREATESVGPATHSEGLINETOHORIZONTALREL       = 0x0000042aU,
    DISPID_ISVGPATHELEMENT_CREATESVGPATHSEGLINETOVERTICALABS         = 0x0000042bU,
    DISPID_ISVGPATHELEMENT_CREATESVGPATHSEGLINETOVERTICALREL         = 0x0000042cU,
    DISPID_ISVGPATHELEMENT_CREATESVGPATHSEGCURVETOCUBICSMOOTHABS     = 0x0000042dU,
    DISPID_ISVGPATHELEMENT_CREATESVGPATHSEGCURVETOCUBICSMOOTHREL     = 0x0000042eU,
    DISPID_ISVGPATHELEMENT_CREATESVGPATHSEGCURVETOQUADRATICSMOOTHABS = 0x0000042fU,
    DISPID_ISVGPATHELEMENT_CREATESVGPATHSEGCURVETOQUADRATICSMOOTHREL = 0x00000430U,
}

enum : uint
{
    DISPID_ISVGPRESERVEASPECTRATIO_ALIGN       = 0x000003e8U,
    DISPID_ISVGPRESERVEASPECTRATIO_MEETORSLICE = 0x000003e9U,
}

enum : uint
{
    DISPID_ISVGANIMATEDPRESERVEASPECTRATIO_BASEVAL = 0x000003e8U,
    DISPID_ISVGANIMATEDPRESERVEASPECTRATIO_ANIMVAL = 0x000003e9U,
}

enum : uint
{
    DISPID_ISVGIMAGEELEMENT_X      = 0x0000041bU,
    DISPID_ISVGIMAGEELEMENT_Y      = 0x0000041dU,
    DISPID_ISVGIMAGEELEMENT_WIDTH  = 0x0000041fU,
    DISPID_ISVGIMAGEELEMENT_HEIGHT = 0x00000421U,
}

enum uint DISPID_ISVGSTOPELEMENT_OFFSET = 0x0000041bU;

enum : uint
{
    DISPID_ISVGGRADIENTELEMENT_GRADIENTUNITS     = 0x0000041bU,
    DISPID_ISVGGRADIENTELEMENT_GRADIENTTRANSFORM = 0x0000041dU,
    DISPID_ISVGGRADIENTELEMENT_SPREADMETHOD      = 0x0000041fU,
}

enum : uint
{
    DISPID_ISVGLINEARGRADIENTELEMENT_X1 = 0x0000042fU,
    DISPID_ISVGLINEARGRADIENTELEMENT_Y1 = 0x00000431U,
    DISPID_ISVGLINEARGRADIENTELEMENT_X2 = 0x00000433U,
    DISPID_ISVGLINEARGRADIENTELEMENT_Y2 = 0x00000435U,
}

enum : uint
{
    DISPID_ISVGRADIALGRADIENTELEMENT_CX = 0x0000042fU,
    DISPID_ISVGRADIALGRADIENTELEMENT_CY = 0x00000431U,
    DISPID_ISVGRADIALGRADIENTELEMENT_R  = 0x00000433U,
    DISPID_ISVGRADIALGRADIENTELEMENT_FX = 0x00000435U,
    DISPID_ISVGRADIALGRADIENTELEMENT_FY = 0x00000437U,
}

enum : uint
{
    DISPID_ISVGMASKELEMENT_MASKUNITS          = 0x0000041bU,
    DISPID_ISVGMASKELEMENT_MASKCONTENTUNITS   = 0x0000041dU,
    DISPID_ISVGMASKELEMENT_X                  = 0x0000041fU,
    DISPID_ISVGMASKELEMENT_Y                  = 0x00000421U,
    DISPID_ISVGMASKELEMENT_WIDTH              = 0x00000423U,
    DISPID_ISVGMASKELEMENT_HEIGHT             = 0x00000425U,
    DISPID_ISVGMARKERELEMENT_REFX             = 0x0000041bU,
    DISPID_ISVGMARKERELEMENT_REFY             = 0x0000041dU,
    DISPID_ISVGMARKERELEMENT_MARKERUNITS      = 0x0000041fU,
    DISPID_ISVGMARKERELEMENT_MARKERWIDTH      = 0x00000421U,
    DISPID_ISVGMARKERELEMENT_MARKERHEIGHT     = 0x00000423U,
    DISPID_ISVGMARKERELEMENT_ORIENTTYPE       = 0x00000425U,
    DISPID_ISVGMARKERELEMENT_ORIENTANGLE      = 0x00000426U,
    DISPID_ISVGMARKERELEMENT_SETORIENTTOAUTO  = 0x00000427U,
    DISPID_ISVGMARKERELEMENT_SETORIENTTOANGLE = 0x00000428U,
}

enum : uint
{
    DISPID_ISVGZOOMEVENT_ZOOMRECTSCREEN    = 0x000004fcU,
    DISPID_ISVGZOOMEVENT_PREVIOUSSCALE     = 0x000004fdU,
    DISPID_ISVGZOOMEVENT_PREVIOUSTRANSLATE = 0x000004feU,
    DISPID_ISVGZOOMEVENT_NEWSCALE          = 0x000004ffU,
    DISPID_ISVGZOOMEVENT_NEWTRANSLATE      = 0x00000500U,
}

enum : uint
{
    DISPID_ISVGAELEMENT_TARGET        = 0x0000041cU,
    DISPID_ISVGVIEWELEMENT_VIEWTARGET = 0x0000041cU,
}

enum : uint
{
    DISPID_IHTMLMEDIAERROR_CODE         = 0x000003e8U,
    DISPID_IHTMLTIMERANGES_LENGTH       = 0x000003e8U,
    DISPID_IHTMLTIMERANGES_START        = 0x000003e9U,
    DISPID_IHTMLTIMERANGES_END          = 0x000003eaU,
    DISPID_IHTMLTIMERANGES2_STARTDOUBLE = 0x000003ebU,
    DISPID_IHTMLTIMERANGES2_ENDDOUBLE   = 0x000003ecU,
}

enum : uint
{
    DISPID_IHTMLMEDIAELEMENT_ERROR                      = 0x000003e8U,
    DISPID_IHTMLMEDIAELEMENT_SRC                        = 0x000003e9U,
    DISPID_IHTMLMEDIAELEMENT_CURRENTSRC                 = 0x000003eaU,
    DISPID_IHTMLMEDIAELEMENT_NETWORKSTATE               = 0x000003ebU,
    DISPID_IHTMLMEDIAELEMENT_PRELOAD                    = 0x000003ecU,
    DISPID_IHTMLMEDIAELEMENT_BUFFERED                   = 0x000003edU,
    DISPID_IHTMLMEDIAELEMENT_LOAD                       = 0x000003eeU,
    DISPID_IHTMLMEDIAELEMENT_CANPLAYTYPE                = 0x000003efU,
    DISPID_IHTMLMEDIAELEMENT_SEEKING                    = 0x000003f1U,
    DISPID_IHTMLMEDIAELEMENT_CURRENTTIME                = 0x000003f2U,
    DISPID_IHTMLMEDIAELEMENT_INITIALTIME                = 0x000003f3U,
    DISPID_IHTMLMEDIAELEMENT_DURATION                   = 0x000003f4U,
    DISPID_IHTMLMEDIAELEMENT_PAUSED                     = 0x000003f5U,
    DISPID_IHTMLMEDIAELEMENT_DEFAULTPLAYBACKRATE        = 0x000003f6U,
    DISPID_IHTMLMEDIAELEMENT_PLAYBACKRATE               = 0x000003f7U,
    DISPID_IHTMLMEDIAELEMENT_PLAYED                     = 0x000003f8U,
    DISPID_IHTMLMEDIAELEMENT_SEEKABLE                   = 0x000003f9U,
    DISPID_IHTMLMEDIAELEMENT_ENDED                      = 0x000003faU,
    DISPID_IHTMLMEDIAELEMENT_AUTOPLAY                   = 0x000003fbU,
    DISPID_IHTMLMEDIAELEMENT_LOOP                       = 0x000003fcU,
    DISPID_IHTMLMEDIAELEMENT_PLAY                       = 0x000003fdU,
    DISPID_IHTMLMEDIAELEMENT_PAUSE                      = 0x000003feU,
    DISPID_IHTMLMEDIAELEMENT_CONTROLS                   = 0x000003ffU,
    DISPID_IHTMLMEDIAELEMENT_VOLUME                     = 0x00000400U,
    DISPID_IHTMLMEDIAELEMENT_MUTED                      = 0x00000401U,
    DISPID_IHTMLMEDIAELEMENT_AUTOBUFFER                 = 0x00000402U,
    DISPID_IHTMLMEDIAELEMENT2_CURRENTTIMEDOUBLE         = 0x00000403U,
    DISPID_IHTMLMEDIAELEMENT2_INITIALTIMEDOUBLE         = 0x00000404U,
    DISPID_IHTMLMEDIAELEMENT2_DURATIONDOUBLE            = 0x00000405U,
    DISPID_IHTMLMEDIAELEMENT2_DEFAULTPLAYBACKRATEDOUBLE = 0x00000406U,
    DISPID_IHTMLMEDIAELEMENT2_PLAYBACKRATEDOUBLE        = 0x00000407U,
    DISPID_IHTMLMEDIAELEMENT2_VOLUMEDOUBLE              = 0x00000408U,
}

enum : uint
{
    DISPID_IHTMLMSMEDIAELEMENT_MSPLAYTODISABLED = 0x00000409U,
    DISPID_IHTMLMSMEDIAELEMENT_MSPLAYTOPRIMARY  = 0x0000040aU,
}

enum : uint
{
    DISPID_IHTMLSOURCEELEMENT_SRC   = 0x000003e8U,
    DISPID_IHTMLSOURCEELEMENT_TYPE  = 0x000003e9U,
    DISPID_IHTMLSOURCEELEMENT_MEDIA = 0x000003eaU,
}

enum : uint
{
    DISPID_IHTMLVIDEOELEMENT_WIDTH       = 0x00010005U,
    DISPID_IHTMLVIDEOELEMENT_HEIGHT      = 0x00010006U,
    DISPID_IHTMLVIDEOELEMENT_VIDEOWIDTH  = 0x0000041aU,
    DISPID_IHTMLVIDEOELEMENT_VIDEOHEIGHT = 0x0000041bU,
    DISPID_IHTMLVIDEOELEMENT_POSTER      = 0x0000041cU,
}

enum uint DISPID_IHTMLAUDIOELEMENTFACTORY_CREATE = 0x00000000U;

enum : uint
{
    DISPID_ISVGELEMENTINSTANCE_CORRESPONDINGELEMENT    = 0x000003e8U,
    DISPID_ISVGELEMENTINSTANCE_CORRESPONDINGUSEELEMENT = 0x000003e9U,
    DISPID_ISVGELEMENTINSTANCE_PARENTNODE              = 0x000003eaU,
    DISPID_ISVGELEMENTINSTANCE_CHILDNODES              = 0x000003ebU,
    DISPID_ISVGELEMENTINSTANCE_FIRSTCHILD              = 0x000003ecU,
    DISPID_ISVGELEMENTINSTANCE_LASTCHILD               = 0x000003edU,
    DISPID_ISVGELEMENTINSTANCE_PREVIOUSSIBLING         = 0x000003eeU,
    DISPID_ISVGELEMENTINSTANCE_NEXTSIBLING             = 0x000003efU,
    DISPID_ISVGELEMENTINSTANCELIST_LENGTH              = 0x000003e8U,
    DISPID_ISVGELEMENTINSTANCELIST_ITEM                = 0x000003e9U,
}

enum : uint
{
    DISPID_IDOMEXCEPTION_CODE    = 0x000003e8U,
    DISPID_IDOMEXCEPTION_MESSAGE = 0x000003e9U,
}

enum : uint
{
    DISPID_IRANGEEXCEPTION_CODE    = 0x000003e8U,
    DISPID_IRANGEEXCEPTION_MESSAGE = 0x000003e9U,
}

enum : uint
{
    DISPID_ISVGEXCEPTION_CODE    = 0x000003e8U,
    DISPID_ISVGEXCEPTION_MESSAGE = 0x000003e9U,
}

enum : uint
{
    DISPID_IEVENTEXCEPTION_CODE    = 0x000003e8U,
    DISPID_IEVENTEXCEPTION_MESSAGE = 0x000003e9U,
}

enum : uint
{
    DISPID_ISVGSCRIPTELEMENT_TYPE = 0x0000041cU,
    DISPID_ISVGSTYLEELEMENT_TYPE  = 0x0000041bU,
    DISPID_ISVGSTYLEELEMENT_MEDIA = 0x0000041cU,
}

enum : uint
{
    DISPID_ISVGTEXTCONTENTELEMENT_TEXTLENGTH             = 0x0000041dU,
    DISPID_ISVGTEXTCONTENTELEMENT_LENGTHADJUST           = 0x0000041bU,
    DISPID_ISVGTEXTCONTENTELEMENT_GETNUMBEROFCHARS       = 0x0000041eU,
    DISPID_ISVGTEXTCONTENTELEMENT_GETCOMPUTEDTEXTLENGTH  = 0x0000041fU,
    DISPID_ISVGTEXTCONTENTELEMENT_GETSUBSTRINGLENGTH     = 0x00000420U,
    DISPID_ISVGTEXTCONTENTELEMENT_GETSTARTPOSITIONOFCHAR = 0x00000421U,
    DISPID_ISVGTEXTCONTENTELEMENT_GETENDPOSITIONOFCHAR   = 0x00000422U,
    DISPID_ISVGTEXTCONTENTELEMENT_GETEXTENTOFCHAR        = 0x00000423U,
    DISPID_ISVGTEXTCONTENTELEMENT_GETROTATIONOFCHAR      = 0x00000424U,
    DISPID_ISVGTEXTCONTENTELEMENT_GETCHARNUMATPOSITION   = 0x00000425U,
    DISPID_ISVGTEXTCONTENTELEMENT_SELECTSUBSTRING        = 0x00000426U,
}

enum : uint
{
    DISPID_ISVGTEXTPOSITIONINGELEMENT_X      = 0x0000042fU,
    DISPID_ISVGTEXTPOSITIONINGELEMENT_Y      = 0x00000431U,
    DISPID_ISVGTEXTPOSITIONINGELEMENT_DX     = 0x00000433U,
    DISPID_ISVGTEXTPOSITIONINGELEMENT_DY     = 0x00000435U,
    DISPID_ISVGTEXTPOSITIONINGELEMENT_ROTATE = 0x00000437U,
}

enum : uint
{
    DISPID_IDOMDOCUMENTTYPE_NAME           = 0x000003e8U,
    DISPID_IDOMDOCUMENTTYPE_ENTITIES       = 0x000003e9U,
    DISPID_IDOMDOCUMENTTYPE_NOTATIONS      = 0x000003eaU,
    DISPID_IDOMDOCUMENTTYPE_PUBLICID       = 0x000003ebU,
    DISPID_IDOMDOCUMENTTYPE_SYSTEMID       = 0x000003ecU,
    DISPID_IDOMDOCUMENTTYPE_INTERNALSUBSET = 0x000003edU,
}

enum : uint
{
    DISPID_IDOMNODEITERATOR_ROOT                   = 0x000003e8U,
    DISPID_IDOMNODEITERATOR_WHATTOSHOW             = 0x000003e9U,
    DISPID_IDOMNODEITERATOR_FILTER                 = 0x000003eaU,
    DISPID_IDOMNODEITERATOR_EXPANDENTITYREFERENCES = 0x000003ebU,
    DISPID_IDOMNODEITERATOR_NEXTNODE               = 0x000003f2U,
    DISPID_IDOMNODEITERATOR_PREVIOUSNODE           = 0x000003f3U,
    DISPID_IDOMNODEITERATOR_DETACH                 = 0x000003f4U,
}

enum : uint
{
    DISPID_IDOMTREEWALKER_ROOT                   = 0x000003e8U,
    DISPID_IDOMTREEWALKER_WHATTOSHOW             = 0x000003e9U,
    DISPID_IDOMTREEWALKER_FILTER                 = 0x000003eaU,
    DISPID_IDOMTREEWALKER_EXPANDENTITYREFERENCES = 0x000003ebU,
    DISPID_IDOMTREEWALKER_CURRENTNODE            = 0x000003fcU,
    DISPID_IDOMTREEWALKER_PARENTNODE             = 0x000003fdU,
    DISPID_IDOMTREEWALKER_FIRSTCHILD             = 0x000003feU,
    DISPID_IDOMTREEWALKER_LASTCHILD              = 0x000003ffU,
    DISPID_IDOMTREEWALKER_PREVIOUSSIBLING        = 0x00000400U,
    DISPID_IDOMTREEWALKER_NEXTSIBLING            = 0x00000401U,
    DISPID_IDOMTREEWALKER_PREVIOUSNODE           = 0x00000402U,
    DISPID_IDOMTREEWALKER_NEXTNODE               = 0x00000403U,
}

enum : uint
{
    DISPID_IDOMPROCESSINGINSTRUCTION_TARGET = 0x000003e8U,
    DISPID_IDOMPROCESSINGINSTRUCTION_DATA   = 0x000003e9U,
}

enum : uint
{
    DISPID_IHTMLPERFORMANCE_NAVIGATION                       = 0x000003e8U,
    DISPID_IHTMLPERFORMANCE_TIMING                           = 0x000003e9U,
    DISPID_IHTMLPERFORMANCE_TOSTRING                         = 0x000003eaU,
    DISPID_IHTMLPERFORMANCE_TOJSON                           = 0x000003ebU,
    DISPID_IHTMLPERFORMANCENAVIGATION_TYPE                   = 0x000003e8U,
    DISPID_IHTMLPERFORMANCENAVIGATION_REDIRECTCOUNT          = 0x000003e9U,
    DISPID_IHTMLPERFORMANCENAVIGATION_TOSTRING               = 0x000003eaU,
    DISPID_IHTMLPERFORMANCENAVIGATION_TOJSON                 = 0x000003ebU,
    DISPID_IHTMLPERFORMANCETIMING_NAVIGATIONSTART            = 0x000003e8U,
    DISPID_IHTMLPERFORMANCETIMING_UNLOADEVENTSTART           = 0x000003e9U,
    DISPID_IHTMLPERFORMANCETIMING_UNLOADEVENTEND             = 0x000003eaU,
    DISPID_IHTMLPERFORMANCETIMING_REDIRECTSTART              = 0x000003ebU,
    DISPID_IHTMLPERFORMANCETIMING_REDIRECTEND                = 0x000003ecU,
    DISPID_IHTMLPERFORMANCETIMING_FETCHSTART                 = 0x000003edU,
    DISPID_IHTMLPERFORMANCETIMING_DOMAINLOOKUPSTART          = 0x000003eeU,
    DISPID_IHTMLPERFORMANCETIMING_DOMAINLOOKUPEND            = 0x000003efU,
    DISPID_IHTMLPERFORMANCETIMING_CONNECTSTART               = 0x000003f0U,
    DISPID_IHTMLPERFORMANCETIMING_CONNECTEND                 = 0x000003f1U,
    DISPID_IHTMLPERFORMANCETIMING_REQUESTSTART               = 0x000003f2U,
    DISPID_IHTMLPERFORMANCETIMING_RESPONSESTART              = 0x000003f3U,
    DISPID_IHTMLPERFORMANCETIMING_RESPONSEEND                = 0x000003f4U,
    DISPID_IHTMLPERFORMANCETIMING_DOMLOADING                 = 0x000003f5U,
    DISPID_IHTMLPERFORMANCETIMING_DOMINTERACTIVE             = 0x000003f6U,
    DISPID_IHTMLPERFORMANCETIMING_DOMCONTENTLOADEDEVENTSTART = 0x000003f7U,
    DISPID_IHTMLPERFORMANCETIMING_DOMCONTENTLOADEDEVENTEND   = 0x000003f8U,
    DISPID_IHTMLPERFORMANCETIMING_DOMCOMPLETE                = 0x000003f9U,
    DISPID_IHTMLPERFORMANCETIMING_LOADEVENTSTART             = 0x000003faU,
    DISPID_IHTMLPERFORMANCETIMING_LOADEVENTEND               = 0x000003fbU,
    DISPID_IHTMLPERFORMANCETIMING_MSFIRSTPAINT               = 0x000003fcU,
    DISPID_IHTMLPERFORMANCETIMING_TOSTRING                   = 0x000003fdU,
    DISPID_IHTMLPERFORMANCETIMING_TOJSON                     = 0x000003feU,
}

enum : uint
{
    DISPID_ITEMPLATEPRINTER_STARTDOC                      = 0x00000001U,
    DISPID_ITEMPLATEPRINTER_STOPDOC                       = 0x00000002U,
    DISPID_ITEMPLATEPRINTER_PRINTBLANKPAGE                = 0x00000003U,
    DISPID_ITEMPLATEPRINTER_PRINTPAGE                     = 0x00000004U,
    DISPID_ITEMPLATEPRINTER_ENSUREPRINTDIALOGDEFAULTS     = 0x00000005U,
    DISPID_ITEMPLATEPRINTER_SHOWPRINTDIALOG               = 0x00000006U,
    DISPID_ITEMPLATEPRINTER_SHOWPAGESETUPDIALOG           = 0x00000007U,
    DISPID_ITEMPLATEPRINTER_PRINTNONNATIVE                = 0x00000008U,
    DISPID_ITEMPLATEPRINTER_PRINTNONNATIVEFRAMES          = 0x00000009U,
    DISPID_ITEMPLATEPRINTER_FRAMESETDOCUMENT              = 0x0000000aU,
    DISPID_ITEMPLATEPRINTER_FRAMEACTIVE                   = 0x0000000bU,
    DISPID_ITEMPLATEPRINTER_FRAMEASSHOWN                  = 0x0000000cU,
    DISPID_ITEMPLATEPRINTER_SELECTION                     = 0x0000000dU,
    DISPID_ITEMPLATEPRINTER_SELECTEDPAGES                 = 0x0000000eU,
    DISPID_ITEMPLATEPRINTER_CURRENTPAGE                   = 0x0000000fU,
    DISPID_ITEMPLATEPRINTER_CURRENTPAGEAVAIL              = 0x00000010U,
    DISPID_ITEMPLATEPRINTER_COLLATE                       = 0x00000011U,
    DISPID_ITEMPLATEPRINTER_DUPLEX                        = 0x00000012U,
    DISPID_ITEMPLATEPRINTER_COPIES                        = 0x00000013U,
    DISPID_ITEMPLATEPRINTER_PAGEFROM                      = 0x00000014U,
    DISPID_ITEMPLATEPRINTER_PAGETO                        = 0x00000015U,
    DISPID_ITEMPLATEPRINTER_TABLEOFLINKS                  = 0x00000016U,
    DISPID_ITEMPLATEPRINTER_ALLLINKEDDOCUMENTS            = 0x00000017U,
    DISPID_ITEMPLATEPRINTER_HEADER                        = 0x00000018U,
    DISPID_ITEMPLATEPRINTER_FOOTER                        = 0x00000019U,
    DISPID_ITEMPLATEPRINTER_MARGINLEFT                    = 0x0000001aU,
    DISPID_ITEMPLATEPRINTER_MARGINRIGHT                   = 0x0000001bU,
    DISPID_ITEMPLATEPRINTER_MARGINTOP                     = 0x0000001cU,
    DISPID_ITEMPLATEPRINTER_MARGINBOTTOM                  = 0x0000001dU,
    DISPID_ITEMPLATEPRINTER_PAGEWIDTH                     = 0x0000001eU,
    DISPID_ITEMPLATEPRINTER_PAGEHEIGHT                    = 0x0000001fU,
    DISPID_ITEMPLATEPRINTER_UNPRINTABLELEFT               = 0x00000020U,
    DISPID_ITEMPLATEPRINTER_UNPRINTABLETOP                = 0x00000021U,
    DISPID_ITEMPLATEPRINTER_UNPRINTABLERIGHT              = 0x00000022U,
    DISPID_ITEMPLATEPRINTER_UNPRINTABLEBOTTOM             = 0x00000023U,
    DISPID_ITEMPLATEPRINTER_UPDATEPAGESTATUS              = 0x00000024U,
    DISPID_ITEMPLATEPRINTER2_SELECTIONENABLED             = 0x00000025U,
    DISPID_ITEMPLATEPRINTER2_FRAMEACTIVEENABLED           = 0x00000026U,
    DISPID_ITEMPLATEPRINTER2_ORIENTATION                  = 0x00000027U,
    DISPID_ITEMPLATEPRINTER2_USEPRINTERCOPYCOLLATE        = 0x00000028U,
    DISPID_ITEMPLATEPRINTER2_DEVICESUPPORTS               = 0x00000029U,
    DISPID_ITEMPLATEPRINTER3_HEADERFOOTERFONT             = 0x0000002aU,
    DISPID_ITEMPLATEPRINTER3_GETPAGEMARGINTOP             = 0x0000002bU,
    DISPID_ITEMPLATEPRINTER3_GETPAGEMARGINRIGHT           = 0x0000002cU,
    DISPID_ITEMPLATEPRINTER3_GETPAGEMARGINBOTTOM          = 0x0000002dU,
    DISPID_ITEMPLATEPRINTER3_GETPAGEMARGINLEFT            = 0x0000002eU,
    DISPID_ITEMPLATEPRINTER3_GETPAGEMARGINTOPIMPORTANT    = 0x0000002fU,
    DISPID_ITEMPLATEPRINTER3_GETPAGEMARGINRIGHTIMPORTANT  = 0x00000030U,
    DISPID_ITEMPLATEPRINTER3_GETPAGEMARGINBOTTOMIMPORTANT = 0x00000031U,
    DISPID_ITEMPLATEPRINTER3_GETPAGEMARGINLEFTIMPORTANT   = 0x00000032U,
}

enum : uint
{
    DISPID_IPRINTMANAGERTEMPLATEPRINTER_STARTPRINT              = 0x000001f5U,
    DISPID_IPRINTMANAGERTEMPLATEPRINTER_DRAWPREVIEWPAGE         = 0x000001f6U,
    DISPID_IPRINTMANAGERTEMPLATEPRINTER_SETPAGECOUNT            = 0x000001f7U,
    DISPID_IPRINTMANAGERTEMPLATEPRINTER_INVALIDATEPREVIEW       = 0x000001f8U,
    DISPID_IPRINTMANAGERTEMPLATEPRINTER_GETPRINTTASKOPTIONVALUE = 0x000001f9U,
    DISPID_IPRINTMANAGERTEMPLATEPRINTER_ENDPRINT                = 0x000001faU,
    DISPID_IPRINTMANAGERTEMPLATEPRINTER2_SHOWHEADERFOOTER       = 0x000001fbU,
    DISPID_IPRINTMANAGERTEMPLATEPRINTER2_SHRINKTOFIT            = 0x000001fcU,
    DISPID_IPRINTMANAGERTEMPLATEPRINTER2_PERCENTSCALE           = 0x000001fdU,
}

enum : uint
{
    DISPID_ISVGTEXTPATHELEMENT_STARTOFFSET = 0x0000042fU,
    DISPID_ISVGTEXTPATHELEMENT_METHOD      = 0x00000431U,
    DISPID_ISVGTEXTPATHELEMENT_SPACING     = 0x00000433U,
}

enum uint DISPID_IDOMXMLSERIALIZER_SERIALIZETOSTRING = 0x000003e8U;
enum uint DISPID_IDOMPARSER_PARSEFROMSTRING = 0x000003e8U;
enum uint DISPID_IDOMXMLSERIALIZERFACTORY_CREATE = 0x00000000U;
enum uint DISPID_IDOMPARSERFACTORY_CREATE = 0x00000000U;

enum : uint
{
    DISPID_IHTMLPROGRESSELEMENT_VALUE    = 0x00000000U,
    DISPID_IHTMLPROGRESSELEMENT_MAX      = 0x000003e8U,
    DISPID_IHTMLPROGRESSELEMENT_POSITION = 0x000003e9U,
    DISPID_IHTMLPROGRESSELEMENT_FORM     = 0x000107d4U,
}

enum : uint
{
    DISPID_IDOMMSTRANSITIONEVENT_PROPERTYNAME          = 0x000005c4U,
    DISPID_IDOMMSTRANSITIONEVENT_ELAPSEDTIME           = 0x000005c5U,
    DISPID_IDOMMSTRANSITIONEVENT_INITMSTRANSITIONEVENT = 0x000005c6U,
}

enum : uint
{
    DISPID_IDOMMSANIMATIONEVENT_ANIMATIONNAME        = 0x000005ddU,
    DISPID_IDOMMSANIMATIONEVENT_ELAPSEDTIME          = 0x000005deU,
    DISPID_IDOMMSANIMATIONEVENT_INITMSANIMATIONEVENT = 0x000005dfU,
}

enum : uint
{
    DISPID_IWEBGEOLOCATION_GETCURRENTPOSITION  = 0x000003e9U,
    DISPID_IWEBGEOLOCATION_WATCHPOSITION       = 0x000003eaU,
    DISPID_IWEBGEOLOCATION_CLEARWATCH          = 0x000003ebU,
    DISPID_IWEBGEOCOORDINATES_LATITUDE         = 0x000003e9U,
    DISPID_IWEBGEOCOORDINATES_LONGITUDE        = 0x000003eaU,
    DISPID_IWEBGEOCOORDINATES_ALTITUDE         = 0x000003ebU,
    DISPID_IWEBGEOCOORDINATES_ACCURACY         = 0x000003ecU,
    DISPID_IWEBGEOCOORDINATES_ALTITUDEACCURACY = 0x000003edU,
    DISPID_IWEBGEOCOORDINATES_HEADING          = 0x000003eeU,
    DISPID_IWEBGEOCOORDINATES_SPEED            = 0x000003efU,
    DISPID_IWEBGEOPOSITIONERROR_CODE           = 0x000003e9U,
    DISPID_IWEBGEOPOSITIONERROR_MESSAGE        = 0x000003eaU,
    DISPID_IWEBGEOPOSITION_COORDS              = 0x000003e9U,
    DISPID_IWEBGEOPOSITION_TIMESTAMP           = 0x000003eaU,
}

enum : uint
{
    DISPID_ICLIENTCAPS_JAVAENABLED           = 0x00000001U,
    DISPID_ICLIENTCAPS_COOKIEENABLED         = 0x00000002U,
    DISPID_ICLIENTCAPS_CPUCLASS              = 0x00000003U,
    DISPID_ICLIENTCAPS_SYSTEMLANGUAGE        = 0x00000004U,
    DISPID_ICLIENTCAPS_USERLANGUAGE          = 0x00000005U,
    DISPID_ICLIENTCAPS_PLATFORM              = 0x00000006U,
    DISPID_ICLIENTCAPS_CONNECTIONSPEED       = 0x00000007U,
    DISPID_ICLIENTCAPS_ONLINE                = 0x00000008U,
    DISPID_ICLIENTCAPS_COLORDEPTH            = 0x00000009U,
    DISPID_ICLIENTCAPS_BUFFERDEPTH           = 0x0000000aU,
    DISPID_ICLIENTCAPS_WIDTH                 = 0x0000000bU,
    DISPID_ICLIENTCAPS_HEIGHT                = 0x0000000cU,
    DISPID_ICLIENTCAPS_AVAILHEIGHT           = 0x0000000dU,
    DISPID_ICLIENTCAPS_AVAILWIDTH            = 0x0000000eU,
    DISPID_ICLIENTCAPS_CONNECTIONTYPE        = 0x0000000fU,
    DISPID_ICLIENTCAPS_ISCOMPONENTINSTALLED  = 0x00000010U,
    DISPID_ICLIENTCAPS_GETCOMPONENTVERSION   = 0x00000011U,
    DISPID_ICLIENTCAPS_COMPAREVERSIONS       = 0x00000012U,
    DISPID_ICLIENTCAPS_ADDCOMPONENTREQUEST   = 0x00000013U,
    DISPID_ICLIENTCAPS_DOCOMPONENTREQUEST    = 0x00000014U,
    DISPID_ICLIENTCAPS_CLEARCOMPONENTREQUEST = 0x00000015U,
}

enum : uint
{
    DISPID_IDOMMSMANIPULATIONEVENT_LASTSTATE               = 0x000005f6U,
    DISPID_IDOMMSMANIPULATIONEVENT_CURRENTSTATE            = 0x000005f7U,
    DISPID_IDOMMSMANIPULATIONEVENT_INITMSMANIPULATIONEVENT = 0x000005f8U,
}

enum : uint
{
    DISPID_IDOMCLOSEEVENT_WASCLEAN       = 0x000005f6U,
    DISPID_IDOMCLOSEEVENT_INITCLOSEEVENT = 0x000005f9U,
}

enum : uint
{
    DISPID_IHTMLAPPLICATIONCACHE_STATUS        = 0x000003e9U,
    DISPID_IHTMLAPPLICATIONCACHE_ONCHECKING    = 0x00011825U,
    DISPID_IHTMLAPPLICATIONCACHE_ONERROR       = 0x0001178dU,
    DISPID_IHTMLAPPLICATIONCACHE_ONNOUPDATE    = 0x00011826U,
    DISPID_IHTMLAPPLICATIONCACHE_ONDOWNLOADING = 0x00011827U,
    DISPID_IHTMLAPPLICATIONCACHE_ONPROGRESS    = 0x00011801U,
    DISPID_IHTMLAPPLICATIONCACHE_ONUPDATEREADY = 0x00011828U,
    DISPID_IHTMLAPPLICATIONCACHE_ONCACHED      = 0x00011829U,
    DISPID_IHTMLAPPLICATIONCACHE_ONOBSOLETE    = 0x0001182aU,
    DISPID_IHTMLAPPLICATIONCACHE_UPDATE        = 0x000003eaU,
    DISPID_IHTMLAPPLICATIONCACHE_SWAPCACHE     = 0x000003ebU,
    DISPID_IHTMLAPPLICATIONCACHE_ABORT         = 0x000003ecU,
}

enum : uint
{
    DISPID_ILINEINFO_X             = 0x000003e9U,
    DISPID_ILINEINFO_BASELINE      = 0x000003eaU,
    DISPID_ILINEINFO_TEXTDESCENT   = 0x000003ebU,
    DISPID_ILINEINFO_TEXTHEIGHT    = 0x000003ecU,
    DISPID_ILINEINFO_LINEDIRECTION = 0x000003edU,
}

enum : uint
{
    DISPID_IHTMLCOMPUTEDSTYLE_BOLD            = 0x000003e9U,
    DISPID_IHTMLCOMPUTEDSTYLE_ITALIC          = 0x000003eaU,
    DISPID_IHTMLCOMPUTEDSTYLE_UNDERLINE       = 0x000003ebU,
    DISPID_IHTMLCOMPUTEDSTYLE_OVERLINE        = 0x000003ecU,
    DISPID_IHTMLCOMPUTEDSTYLE_STRIKEOUT       = 0x000003edU,
    DISPID_IHTMLCOMPUTEDSTYLE_SUBSCRIPT       = 0x000003eeU,
    DISPID_IHTMLCOMPUTEDSTYLE_SUPERSCRIPT     = 0x000003efU,
    DISPID_IHTMLCOMPUTEDSTYLE_EXPLICITFACE    = 0x000003f0U,
    DISPID_IHTMLCOMPUTEDSTYLE_FONTWEIGHT      = 0x000003f1U,
    DISPID_IHTMLCOMPUTEDSTYLE_FONTSIZE        = 0x000003f2U,
    DISPID_IHTMLCOMPUTEDSTYLE_FONTNAME        = 0x000003f3U,
    DISPID_IHTMLCOMPUTEDSTYLE_HASBGCOLOR      = 0x000003f4U,
    DISPID_IHTMLCOMPUTEDSTYLE_TEXTCOLOR       = 0x000003f5U,
    DISPID_IHTMLCOMPUTEDSTYLE_BACKGROUNDCOLOR = 0x000003f6U,
    DISPID_IHTMLCOMPUTEDSTYLE_PREFORMATTED    = 0x000003f7U,
    DISPID_IHTMLCOMPUTEDSTYLE_DIRECTION       = 0x000003f8U,
    DISPID_IHTMLCOMPUTEDSTYLE_BLOCKDIRECTION  = 0x000003f9U,
    DISPID_IHTMLCOMPUTEDSTYLE_OL              = 0x000003faU,
    DISPID_IHTMLDLGSAFEHELPER_CHOOSECOLORDLG  = 0x00000001U,
    DISPID_IHTMLDLGSAFEHELPER_GETCHARSET      = 0x00000002U,
    DISPID_IHTMLDLGSAFEHELPER_FONTS           = 0x00000003U,
    DISPID_IHTMLDLGSAFEHELPER_BLOCKFORMATS    = 0x00000004U,
}

enum int DISPID_IBLOCKFORMATS__NEWENUM = 0xfffffffc;

enum : uint
{
    DISPID_IBLOCKFORMATS_COUNT = 0x00000001U,
    DISPID_IBLOCKFORMATS_ITEM  = 0x00000000U,
}

enum int DISPID_IFONTNAMES__NEWENUM = 0xfffffffc;

enum : uint
{
    DISPID_IFONTNAMES_COUNT = 0x00000001U,
    DISPID_IFONTNAMES_ITEM  = 0x00000000U,
}

enum : uint
{
    DISPID_IHTMLNAMESPACE_NAME               = 0x000003e8U,
    DISPID_IHTMLNAMESPACE_URN                = 0x000003e9U,
    DISPID_IHTMLNAMESPACE_TAGNAMES           = 0x000003eaU,
    DISPID_IHTMLNAMESPACE_READYSTATE         = 0x000113fcU,
    DISPID_IHTMLNAMESPACE_ONREADYSTATECHANGE = 0x00011789U,
    DISPID_IHTMLNAMESPACE_DOIMPORT           = 0x000003ebU,
    DISPID_IHTMLNAMESPACE_ATTACHEVENT        = 0x000101fbU,
    DISPID_IHTMLNAMESPACE_DETACHEVENT        = 0x000101fcU,
    DISPID_IHTMLNAMESPACECOLLECTION_LENGTH   = 0x000003e8U,
    DISPID_IHTMLNAMESPACECOLLECTION_ITEM     = 0x00000000U,
    DISPID_IHTMLNAMESPACECOLLECTION_ADD      = 0x000003e9U,
}

enum int DISPID_HTMLNAMESPACEEVENTS_ONREADYSTATECHANGE = 0xfffffd9f;
enum uint DISPID_IHTMLIPRINTCOLLECTION_LENGTH = 0x000005ddU;
enum int DISPID_IHTMLIPRINTCOLLECTION__NEWENUM = 0xfffffffc;
enum uint DISPID_IHTMLIPRINTCOLLECTION_ITEM = 0x00000000U;

enum : uint
{
    DISPID_IHTMLDIALOG_DIALOGTOP       = 0x00010004U,
    DISPID_IHTMLDIALOG_DIALOGLEFT      = 0x00010003U,
    DISPID_IHTMLDIALOG_DIALOGWIDTH     = 0x00010005U,
    DISPID_IHTMLDIALOG_DIALOGHEIGHT    = 0x00010006U,
    DISPID_IHTMLDIALOG_DIALOGARGUMENTS = 0x000061a8U,
    DISPID_IHTMLDIALOG_MENUARGUMENTS   = 0x000061b5U,
    DISPID_IHTMLDIALOG_RETURNVALUE     = 0x000061a9U,
    DISPID_IHTMLDIALOG_CLOSE           = 0x000061b3U,
    DISPID_IHTMLDIALOG_TOSTRING        = 0x000061b4U,
    DISPID_IHTMLDIALOG2_STATUS         = 0x000061b6U,
    DISPID_IHTMLDIALOG2_RESIZABLE      = 0x000061b7U,
    DISPID_IHTMLDIALOG3_UNADORNED      = 0x000061b8U,
    DISPID_IHTMLDIALOG3_DIALOGHIDE     = 0x000061afU,
}

enum : uint
{
    DISPID_IHTMLMODELESSINIT_PARAMETERS   = 0x000061a8U,
    DISPID_IHTMLMODELESSINIT_OPTIONSTRING = 0x000061a9U,
    DISPID_IHTMLMODELESSINIT_MONIKER      = 0x000061aeU,
    DISPID_IHTMLMODELESSINIT_DOCUMENT     = 0x000061afU,
}

enum : uint
{
    DISPID_IHTMLPOPUP_SHOW                  = 0x00006979U,
    DISPID_IHTMLPOPUP_HIDE                  = 0x0000697aU,
    DISPID_IHTMLPOPUP_DOCUMENT              = 0x0000697bU,
    DISPID_IHTMLPOPUP_ISOPEN                = 0x0000697cU,
    DISPID_IHTMLAPPBEHAVIOR_APPLICATIONNAME = 0x00001388U,
    DISPID_IHTMLAPPBEHAVIOR_VERSION         = 0x00001389U,
    DISPID_IHTMLAPPBEHAVIOR_ICON            = 0x0000138aU,
    DISPID_IHTMLAPPBEHAVIOR_SINGLEINSTANCE  = 0x0000138bU,
    DISPID_IHTMLAPPBEHAVIOR_MINIMIZEBUTTON  = 0x0000138dU,
    DISPID_IHTMLAPPBEHAVIOR_MAXIMIZEBUTTON  = 0x0000138eU,
    DISPID_IHTMLAPPBEHAVIOR_BORDER          = 0x0000138fU,
    DISPID_IHTMLAPPBEHAVIOR_BORDERSTYLE     = 0x00001390U,
    DISPID_IHTMLAPPBEHAVIOR_SYSMENU         = 0x00001391U,
    DISPID_IHTMLAPPBEHAVIOR_CAPTION         = 0x00001392U,
    DISPID_IHTMLAPPBEHAVIOR_WINDOWSTATE     = 0x00001393U,
    DISPID_IHTMLAPPBEHAVIOR_SHOWINTASKBAR   = 0x00001394U,
    DISPID_IHTMLAPPBEHAVIOR_COMMANDLINE     = 0x00001395U,
    DISPID_IHTMLAPPBEHAVIOR2_CONTEXTMENU    = 0x00001396U,
    DISPID_IHTMLAPPBEHAVIOR2_INNERBORDER    = 0x00001397U,
    DISPID_IHTMLAPPBEHAVIOR2_SCROLL         = 0x00001398U,
    DISPID_IHTMLAPPBEHAVIOR2_SCROLLFLAT     = 0x00001399U,
    DISPID_IHTMLAPPBEHAVIOR2_SELECTION      = 0x0000139aU,
    DISPID_IHTMLAPPBEHAVIOR3_NAVIGABLE      = 0x0000139bU,
}

enum uint DISPID_IHTMLTXTRANGEINTERNAL_GET_VISIBLETEXT = 0x0000041aU;

enum : uint
{
    DISPID_IE9EVENTS_ABORT            = 0x000003e8U,
    DISPID_IE9EVENTS_ACTIVATE         = 0x00000414U,
    DISPID_IE9EVENTS_AFTERPRINT       = 0x00000401U,
    DISPID_IE9EVENTS_BEFOREACTIVATE   = 0x00000417U,
    DISPID_IE9EVENTS_BEFOREDEACTIVATE = 0x0000040aU,
    DISPID_IE9EVENTS_BEFOREUNLOAD     = 0x000003f9U,
    DISPID_IE9EVENTS_BEFOREPRINT      = 0x00000400U,
    DISPID_IE9EVENTS_BOUNCE           = 0x000003f1U,
    DISPID_IE9EVENTS_CHANGE           = 0x000003e9U,
}

enum int DISPID_IE9EVENTS_CLICK = 0xfffffda8;

enum : uint
{
    DISPID_IE9EVENTS_COMPLETE         = 0x0001182fU,
    DISPID_IE9EVENTS_CONTEXTMENU      = 0x000003ffU,
    DISPID_IE9EVENTS_DEACTIVATE       = 0x00000415U,
    DISPID_IE9EVENTS_DOMCONTENTLOADED = 0x000117eeU,
    DISPID_IE9EVENTS_SUCCESS          = 0x0001182dU,
    DISPID_IE9EVENTS_ERROR            = 0x000003eaU,
    DISPID_IE9EVENTS_FINISH           = 0x000003f2U,
    DISPID_IE9EVENTS_FOCUS            = 0x00010001U,
    DISPID_IE9EVENTS_FOCUSIN          = 0x00000418U,
    DISPID_IE9EVENTS_FOCUSOUT         = 0x00000419U,
    DISPID_IE9EVENTS_HASHCHANGE       = 0x0000042aU,
    DISPID_IE9EVENTS_HELP             = 0x0001000aU,
    DISPID_IE9EVENTS_INPUT            = 0x000117efU,
    DISPID_IE9EVENTS_LOAD             = 0x000003ebU,
}

enum : int
{
    DISPID_IE9EVENTS_KEYDOWN  = 0xfffffda6,
    DISPID_IE9EVENTS_KEYPRESS = 0xfffffda5,
    DISPID_IE9EVENTS_KEYUP    = 0xfffffda4,
}

enum : uint
{
    DISPID_IE9EVENTS_MESSAGE = 0x0000042bU,
    DISPID_IE9EVENTS_ONLINE  = 0x00000428U,
    DISPID_IE9EVENTS_OFFLINE = 0x00000429U,
}

enum int DISPID_IE9EVENTS_READYSTATECHANGE = 0xfffffd9f;

enum : uint
{
    DISPID_IE9EVENTS_RESET           = 0x000003f7U,
    DISPID_IE9EVENTS_RESIZE          = 0x000003f8U,
    DISPID_IE9EVENTS_SCROLL          = 0x000003f6U,
    DISPID_IE9EVENTS_SELECT          = 0x000003eeU,
    DISPID_IE9EVENTS_SELECTIONCHANGE = 0x0000040dU,
    DISPID_IE9EVENTS_SELECTSTART     = 0x0001000cU,
    DISPID_IE9EVENTS_START           = 0x000003f3U,
    DISPID_IE9EVENTS_STOP            = 0x00000402U,
    DISPID_IE9EVENTS_STORAGE         = 0x00000421U,
    DISPID_IE9EVENTS_STORAGECOMMIT   = 0x00000422U,
    DISPID_IE9EVENTS_SUBMIT          = 0x000003efU,
    DISPID_IE9EVENTS_TEXTINPUT       = 0x000117f1U,
    DISPID_IE9EVENTS_TIMEOUT         = 0x00000000U,
    DISPID_IE9EVENTS_UNLOAD          = 0x000003f0U,
    DISPID_IE9EVENTS_WHEEL           = 0x000117e1U,
}

enum : int
{
    DISPID_IE9EVENTS_DBLCLICK  = 0xfffffda7,
    DISPID_IE9EVENTS_MOUSEDOWN = 0xfffffda3,
}

enum : uint
{
    DISPID_IE9EVENTS_MOUSEENTER = 0x00000412U,
    DISPID_IE9EVENTS_MOUSELEAVE = 0x00000413U,
}

enum int DISPID_IE9EVENTS_MOUSEMOVE = 0xfffffda2;

enum : uint
{
    DISPID_IE9EVENTS_MOUSEOUT  = 0x00010009U,
    DISPID_IE9EVENTS_MOUSEOVER = 0x00010008U,
}

enum int DISPID_IE9EVENTS_MOUSEUP = 0xfffffda1;

enum : uint
{
    DISPID_IE9EVENTS_MOUSEWHEEL                    = 0x00000409U,
    DISPID_IE9EVENTS_BEFORECOPY                    = 0x0001001eU,
    DISPID_IE9EVENTS_BEFORECUT                     = 0x0001001dU,
    DISPID_IE9EVENTS_BEFOREPASTE                   = 0x0001001fU,
    DISPID_IE9EVENTS_COPY                          = 0x0001001bU,
    DISPID_IE9EVENTS_CUT                           = 0x0001001aU,
    DISPID_IE9EVENTS_DRAG                          = 0x00010014U,
    DISPID_IE9EVENTS_DRAGEND                       = 0x00010015U,
    DISPID_IE9EVENTS_DRAGENTER                     = 0x00010016U,
    DISPID_IE9EVENTS_DRAGLEAVE                     = 0x00010018U,
    DISPID_IE9EVENTS_DRAGOVER                      = 0x00010017U,
    DISPID_IE9EVENTS_DRAGSTART                     = 0x0001000bU,
    DISPID_IE9EVENTS_DROP                          = 0x00010019U,
    DISPID_IE9EVENTS_PASTE                         = 0x0001001cU,
    DISPID_IE9EVENTS_MSBEFOREEDITFOCUS             = 0x00000403U,
    DISPID_IE9EVENTS_MSCONTROLSELECT               = 0x0000040cU,
    DISPID_IE9EVENTS_MSCONTROLRESIZESTART          = 0x00000410U,
    DISPID_IE9EVENTS_MSCONTROLRESIZEEND            = 0x00000411U,
    DISPID_IE9EVENTS_COMPOSITIONSTART              = 0x000117eaU,
    DISPID_IE9EVENTS_COMPOSITIONUPDATE             = 0x000117ebU,
    DISPID_IE9EVENTS_COMPOSITIONEND                = 0x000117ecU,
    DISPID_IE9EVENTS_DOMATTRMODIFIED               = 0x000117edU,
    DISPID_IE9EVENTS_DOMCHARACTERDATAMODIFIED      = 0x000117f0U,
    DISPID_IE9EVENTS_DOMNODEINSERTED               = 0x000117f3U,
    DISPID_IE9EVENTS_DOMNODEREMOVED                = 0x000117f4U,
    DISPID_IE9EVENTS_DOMSUBTREEMODIFIED            = 0x000117f5U,
    DISPID_IE9EVENTS_SVGLOAD                       = 0x000117e2U,
    DISPID_IE9EVENTS_SVGUNLOAD                     = 0x000117e3U,
    DISPID_IE9EVENTS_SVGABORT                      = 0x000117e4U,
    DISPID_IE9EVENTS_SVGERROR                      = 0x000117e5U,
    DISPID_IE9EVENTS_SVGRESIZE                     = 0x000117e6U,
    DISPID_IE9EVENTS_SVGSCROLL                     = 0x000117e7U,
    DISPID_IE9EVENTS_SVGZOOM                       = 0x000117e8U,
    DISPID_IE9EVENTS_MSTHUMBNAILCLICK              = 0x000117e9U,
    DISPID_IE9EVENTS_MSSITEMODEJUMPLISTITEMREMOVED = 0x000117f2U,
}

enum : uint
{
    DISPID_IE9EVENTS_CANPLAY                    = 0x000117f6U,
    DISPID_IE9EVENTS_CANPLAYTHROUGH             = 0x000117f7U,
    DISPID_IE9EVENTS_DURATIONCHANGE             = 0x000117f8U,
    DISPID_IE9EVENTS_EMPTIED                    = 0x000117f9U,
    DISPID_IE9EVENTS_ENDED                      = 0x000117faU,
    DISPID_IE9EVENTS_LOADEDDATA                 = 0x000117fbU,
    DISPID_IE9EVENTS_LOADEDMETADATA             = 0x000117fcU,
    DISPID_IE9EVENTS_LOADSTART                  = 0x000117fdU,
    DISPID_IE9EVENTS_PAUSE                      = 0x000117feU,
    DISPID_IE9EVENTS_PLAY                       = 0x000117ffU,
    DISPID_IE9EVENTS_PLAYING                    = 0x00011800U,
    DISPID_IE9EVENTS_PROGRESS                   = 0x00011801U,
    DISPID_IE9EVENTS_RATECHANGE                 = 0x00011802U,
    DISPID_IE9EVENTS_SEEKED                     = 0x00011803U,
    DISPID_IE9EVENTS_SEEKING                    = 0x00011804U,
    DISPID_IE9EVENTS_STALLED                    = 0x00011805U,
    DISPID_IE9EVENTS_SUSPEND                    = 0x00011806U,
    DISPID_IE9EVENTS_TIMEUPDATE                 = 0x00011807U,
    DISPID_IE9EVENTS_VOLUMECHANGE               = 0x00011808U,
    DISPID_IE9EVENTS_WAITING                    = 0x00011809U,
    DISPID_IE9EVENTS_BLOCKED                    = 0x0001182eU,
    DISPID_IE9EVENTS_UPGRADENEEDED              = 0x00011836U,
    DISPID_IE9EVENTS_CUECHANGE                  = 0x00011831U,
    DISPID_IE9EVENTS_ENTER                      = 0x00011832U,
    DISPID_IE9EVENTS_EXIT                       = 0x00011833U,
    DISPID_IE9EVENTS_ADDTRACK                   = 0x00011838U,
    DISPID_IE9EVENTS_REMOVETRACK                = 0x00011865U,
    DISPID_IE9EVENTS_MSPOINTERDOWN              = 0x0001180aU,
    DISPID_IE9EVENTS_MSPOINTERMOVE              = 0x0001180bU,
    DISPID_IE9EVENTS_MSPOINTERUP                = 0x0001180cU,
    DISPID_IE9EVENTS_MSPOINTEROVER              = 0x0001180dU,
    DISPID_IE9EVENTS_MSPOINTEROUT               = 0x0001180eU,
    DISPID_IE9EVENTS_MSPOINTERCANCEL            = 0x0001180fU,
    DISPID_IE9EVENTS_MSPOINTERHOVER             = 0x00011810U,
    DISPID_IE9EVENTS_MSLOSTPOINTERCAPTURE       = 0x0001181aU,
    DISPID_IE9EVENTS_MSGOTPOINTERCAPTURE        = 0x0001181bU,
    DISPID_IE9EVENTS_MSPOINTERENTER             = 0x00011859U,
    DISPID_IE9EVENTS_MSPOINTERLEAVE             = 0x0001185aU,
    DISPID_IE9EVENTS_TOUCHSTART                 = 0x00011868U,
    DISPID_IE9EVENTS_TOUCHEND                   = 0x00011869U,
    DISPID_IE9EVENTS_TOUCHMOVE                  = 0x0001186aU,
    DISPID_IE9EVENTS_TOUCHCANCEL                = 0x0001186bU,
    DISPID_IE9EVENTS_MSGESTURESTART             = 0x00011813U,
    DISPID_IE9EVENTS_MSGESTURECHANGE            = 0x00011814U,
    DISPID_IE9EVENTS_MSGESTUREEND               = 0x00011815U,
    DISPID_IE9EVENTS_MSGESTUREHOLD              = 0x00011816U,
    DISPID_IE9EVENTS_MSGESTURETAP               = 0x00011817U,
    DISPID_IE9EVENTS_MSGESTUREDOUBLETAP         = 0x00011818U,
    DISPID_IE9EVENTS_MSINERTIASTART             = 0x00011819U,
    DISPID_IE9EVENTS_MSCONTENTZOOM              = 0x0001181cU,
    DISPID_IE9EVENTS_MSHOLDVISUAL               = 0x0001183aU,
    DISPID_IE9EVENTS_TRANSITIONSTART            = 0x0001181dU,
    DISPID_IE9EVENTS_TRANSITIONEND              = 0x0001181eU,
    DISPID_IE9EVENTS_ANIMATIONSTART             = 0x0001181fU,
    DISPID_IE9EVENTS_ANIMATIONEND               = 0x00011820U,
    DISPID_IE9EVENTS_ANIMATIONITERATION         = 0x00011821U,
    DISPID_IE9EVENTS_MSMANIPULATIONSTATECHANGED = 0x00011822U,
}

enum : uint
{
    DISPID_IE9EVENTS_CHECKING                                  = 0x00011825U,
    DISPID_IE9EVENTS_NOUPDATE                                  = 0x00011826U,
    DISPID_IE9EVENTS_DOWNLOADING                               = 0x00011827U,
    DISPID_IE9EVENTS_UPDATEREADY                               = 0x00011828U,
    DISPID_IE9EVENTS_CACHED                                    = 0x00011829U,
    DISPID_IE9EVENTS_OBSOLETE                                  = 0x0001182aU,
    DISPID_IE9EVENTS_INVALID                                   = 0x0001182cU,
    DISPID_IE9EVENTS_OPEN                                      = 0x00011823U,
    DISPID_IE9EVENTS_CLOSE                                     = 0x00011824U,
    DISPID_IE9EVENTS_LOADEND                                   = 0x0001182bU,
    DISPID_IE9EVENTS_POPSTATE                                  = 0x00011830U,
    DISPID_IE9EVENTS_VISIBILITYCHANGE                          = 0x00011834U,
    DISPID_IE9EVENTS_MSREGIONUPDATE                            = 0x00011835U,
    DISPID_IE9EVENTS_MSVIDEOFORMATCHANGED                      = 0x00011837U,
    DISPID_IE9EVENTS_MSVIDEOFRAMESTEPCOMPLETED                 = 0x00011839U,
    DISPID_IE9EVENTS_MSVIDEOOPTIMALLAYOUTCHANGED               = 0x0001183bU,
    DISPID_IE9EVENTS_MSFULLSCREENCHANGE                        = 0x0001183cU,
    DISPID_IE9EVENTS_MSFULLSCREENERROR                         = 0x0001183dU,
    DISPID_IE9EVENTS_MSELEMENTRESIZE                           = 0x0001183eU,
    DISPID_IE9EVENTS_SOURCEOPEN                                = 0x0001183fU,
    DISPID_IE9EVENTS_SOURCEENDED                               = 0x00011841U,
    DISPID_IE9EVENTS_SOURCECLOSE                               = 0x00011840U,
    DISPID_IE9EVENTS_ADDSOURCEBUFFER                           = 0x00011842U,
    DISPID_IE9EVENTS_REMOVESOURCEBUFFER                        = 0x00011843U,
    DISPID_IE9EVENTS_UPDATESTART                               = 0x00011856U,
    DISPID_IE9EVENTS_UPDATE                                    = 0x00011857U,
    DISPID_IE9EVENTS_UPDATEEND                                 = 0x00011858U,
    DISPID_IE9EVENTS_MSNEEDKEY                                 = 0x00011844U,
    DISPID_IE9EVENTS_MSKEYMESSAGE                              = 0x00011845U,
    DISPID_IE9EVENTS_MSKEYERROR                                = 0x00011846U,
    DISPID_IE9EVENTS_MSKEYADDED                                = 0x00011847U,
    DISPID_IE9EVENTS_MSWEBVIEWDOMCONTENTLOADED                 = 0x00011848U,
    DISPID_IE9EVENTS_MSWEBVIEWCONTENTLOADING                   = 0x00011849U,
    DISPID_IE9EVENTS_MSWEBVIEWNAVIGATIONSTARTING               = 0x0001184aU,
    DISPID_IE9EVENTS_MSWEBVIEWNAVIGATIONCOMPLETED              = 0x0001184bU,
    DISPID_IE9EVENTS_MSWEBVIEWFRAMEDOMCONTENTLOADED            = 0x0001184cU,
    DISPID_IE9EVENTS_MSWEBVIEWFRAMECONTENTLOADING              = 0x0001184dU,
    DISPID_IE9EVENTS_MSWEBVIEWFRAMENAVIGATIONSTARTING          = 0x0001184eU,
    DISPID_IE9EVENTS_MSWEBVIEWFRAMENAVIGATIONCOMPLETED         = 0x0001184fU,
    DISPID_IE9EVENTS_MSWEBVIEWSCRIPTNOTIFY                     = 0x00011850U,
    DISPID_IE9EVENTS_MSWEBVIEWLONGRUNNINGSCRIPTDETECTED        = 0x00011853U,
    DISPID_IE9EVENTS_MSWEBVIEWUNVIEWABLECONTENTIDENTIFIED      = 0x00011851U,
    DISPID_IE9EVENTS_MSWEBVIEWUNSAFECONTENTWARNINGDISPLAYING   = 0x00011852U,
    DISPID_IE9EVENTS_MSWEBVIEWCONTAINSFULLSCREENELEMENTCHANGED = 0x00011867U,
}

enum : uint
{
    DISPID_IE9EVENTS_WEBGLCONTEXTLOST          = 0x00011854U,
    DISPID_IE9EVENTS_WEBGLCONTEXTRESTORED      = 0x00011855U,
    DISPID_IE9EVENTS_WEBGLCONTEXTCREATIONERROR = 0x00011870U,
    DISPID_IE9EVENTS_MSSITEPINNED              = 0x0001185bU,
    DISPID_IE9EVENTS_MSORIENTATIONCHANGE       = 0x0001185cU,
    DISPID_IE9EVENTS_ORIENTATIONCHANGE         = 0x00011873U,
    DISPID_IE9EVENTS_DEVICEORIENTATION         = 0x0001185dU,
    DISPID_IE9EVENTS_DEVICEMOTION              = 0x0001185eU,
    DISPID_IE9EVENTS_COMPASSNEEDSCALIBRATION   = 0x00011866U,
    DISPID_IE9EVENTS_PAGESHOW                  = 0x0001185fU,
    DISPID_IE9EVENTS_PAGEHIDE                  = 0x00011860U,
    DISPID_IE9EVENTS_MSCANDIDATEWINDOWSHOW     = 0x00011861U,
    DISPID_IE9EVENTS_MSCANDIDATEWINDOWUPDATE   = 0x00011862U,
    DISPID_IE9EVENTS_MSCANDIDATEWINDOWHIDE     = 0x00011863U,
}

enum : uint
{
    CONTEXT_MENU_DEFAULT       = 0x00000000U,
    CONTEXT_MENU_IMAGE         = 0x00000001U,
    CONTEXT_MENU_CONTROL       = 0x00000002U,
    CONTEXT_MENU_TABLE         = 0x00000003U,
    CONTEXT_MENU_TEXTSELECT    = 0x00000004U,
    CONTEXT_MENU_ANCHOR        = 0x00000005U,
    CONTEXT_MENU_UNKNOWN       = 0x00000006U,
    CONTEXT_MENU_IMGDYNSRC     = 0x00000007U,
    CONTEXT_MENU_DEBUG         = 0x00000008U,
    CONTEXT_MENU_VSCROLL       = 0x00000009U,
    CONTEXT_MENU_HSCROLL       = 0x0000000aU,
    CONTEXT_MENU_MEDIA         = 0x0000000bU,
    CONTEXT_MENU_ENTITY        = 0x0000000cU,
    CONTEXT_MENU_PDF           = 0x0000000dU,
    CONTEXT_MENU_DISABLEDFLASH = 0x0000000eU,
}

enum uint MENUEXT_SHOWDIALOG = 0x00000001U;

enum : uint
{
    HTMLDLG_NOUI           = 0x00000010U,
    HTMLDLG_MODAL          = 0x00000020U,
    HTMLDLG_MODELESS       = 0x00000040U,
    HTMLDLG_PRINT_TEMPLATE = 0x00000080U,
}

enum : uint
{
    HTMLDLG_VERIFY               = 0x00000100U,
    HTMLDLG_ALLOW_UNKNOWN_THREAD = 0x00000200U,
}

enum uint PRINT_DONTBOTHERUSER = 0x00000001U;
enum uint PRINT_WAITFORCOMPLETION = 0x00000002U;

enum : uint
{
    CMDID_SCRIPTSITE_URL             = 0x00000000U,
    CMDID_SCRIPTSITE_HTMLDLGTRUST    = 0x00000001U,
    CMDID_SCRIPTSITE_SECSTATE        = 0x00000002U,
    CMDID_SCRIPTSITE_SID             = 0x00000003U,
    CMDID_SCRIPTSITE_TRUSTEDDOC      = 0x00000004U,
    CMDID_SCRIPTSITE_SECURITY_WINDOW = 0x00000005U,
    CMDID_SCRIPTSITE_NAMESPACE       = 0x00000006U,
    CMDID_SCRIPTSITE_IURI            = 0x00000007U,
}

enum uint CMDID_HOSTCONTEXT_URL = 0x00000008U;

enum : uint
{
    CMDID_SCRIPTSITE_ALLOWRECOVERY = 0x00000009U,
    CMDID_SCRIPTSITE_BASEIURI      = 0x0000000aU,
}

enum const(wchar)* SZ_HTML_CLIENTSITE_OBJECTPARAM = "{d4db6850-5385-11d0-89e9-00a0c90a90ac}";
enum GUID CGID_DocHostCommandHandler = GUID("f38bc242-b950-11d1-8918-00c04fc2c836");
enum GUID SID_SEditCommandTarget = GUID("3050f4b5-98b5-11cf-bb82-00aa00bdce0b");
enum GUID CGID_EditStateCommands = GUID("3050f4b6-98b5-11cf-bb82-00aa00bdce0b");

enum : GUID
{
    SID_SHTMLEditHost     = GUID("3050f6a0-98b5-11cf-bb82-00aa00bdce0b"),
    SID_SHTMLEditServices = GUID("3050f7f9-98b5-11cf-bb82-00aa00bdce0b"),
}

enum : uint
{
    COOKIEACTION_NONE      = 0x00000000U,
    COOKIEACTION_ACCEPT    = 0x00000001U,
    COOKIEACTION_REJECT    = 0x00000002U,
    COOKIEACTION_DOWNGRADE = 0x00000004U,
    COOKIEACTION_LEASH     = 0x00000008U,
    COOKIEACTION_SUPPRESS  = 0x00000010U,
    COOKIEACTION_READ      = 0x00000020U,
}

enum : uint
{
    PRIVACY_URLISTOPLEVEL         = 0x00010000U,
    PRIVACY_URLHASCOMPACTPOLICY   = 0x00020000U,
    PRIVACY_URLHASPOSTDATA        = 0x00080000U,
    PRIVACY_URLHASPOLICYREFLINK   = 0x00100000U,
    PRIVACY_URLHASPOLICYREFHEADER = 0x00200000U,
    PRIVACY_URLHASP3PHEADER       = 0x00400000U,
}

enum : uint
{
    DEBUGCALLBACKNOTIFICATION_TIMEOUT        = 0x00000001U,
    DEBUGCALLBACKNOTIFICATION_INTERVAL       = 0x00000002U,
    DEBUGCALLBACKNOTIFICATION_IMMEDIATE      = 0x00000004U,
    DEBUGCALLBACKNOTIFICATION_ANIMATIONFRAME = 0x00000008U,
    DEBUGCALLBACKNOTIFICATION_DOMEVENT       = 0x00000010U,
}

enum : uint
{
    DEBUGDOMEVENTPROPAGATIONSTATUS_DEFAULTCANCELED          = 0x00000001U,
    DEBUGDOMEVENTPROPAGATIONSTATUS_STOPIMMEDIATEPROPAGATION = 0x00000002U,
    DEBUGDOMEVENTPROPAGATIONSTATUS_STOPPROPAGATION          = 0x00000004U,
}

// Callbacks

alias SHOWHTMLDIALOGFN = HRESULT function(HWND hwndParent, IMoniker pmk, VARIANT* pvarArgIn, PWSTR pchOptions, 
                                          VARIANT* pvArgOut);
alias SHOWHTMLDIALOGEXFN = HRESULT function(HWND hwndParent, IMoniker pmk, uint dwDialogFlags, VARIANT* pvarArgIn, 
                                            PWSTR pchOptions, VARIANT* pvArgOut);
alias SHOWMODELESSHTMLDIALOGFN = HRESULT function(HWND hwndParent, IMoniker pmk, VARIANT* pvarArgIn, 
                                                  VARIANT* pvarOptions, IHTMLWindow2* ppWindow);
alias IEREGISTERXMLNSFN = HRESULT function(const(PWSTR) lpszURI, GUID clsid, BOOL fMachine);
alias IEISXMLNSREGISTEREDFN = HRESULT function(const(PWSTR) lpszURI, GUID* pCLSID);

// Structs


struct HostDialogHelper
{
    ptrdiff_t Value;
}

struct HTML_PAINTER_INFO
{
    int  lFlags;
    int  lZOrder;
    GUID iidDrawObject;
    RECT rcExpand;
}

struct HTML_PAINT_XFORM
{
    float eM11;
    float eM12;
    float eM21;
    float eM22;
    float eDx;
    float eDy;
}

struct HTML_PAINT_DRAW_INFO
{
    RECT             rcViewport;
    HRGN             hrgnUpdate;
    HTML_PAINT_XFORM xform;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct DOCHOSTUIINFO
{
    uint  cbSize;
    /*FIELD ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(DOCHOSTUIFLAG))], [])*/uint dwFlags;
    /*FIELD ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(DOCHOSTUIDBLCLK))], [])*/uint dwDoubleClick;
    PWSTR pchHostCss;
    PWSTR pchHostNS;
}

// Functions

@DllImport("SHDOCVW.dll")
HRESULT DoPrivacyDlg(HWND hwndOwner, const(PWSTR) pszUrl, IEnumPrivacyRecords pPrivacyEnum, BOOL fReportAllSites);


// Interfaces

@GUID("30510741-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLCSSStyleDeclaration;

@GUID("3050f285-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLStyle;

@GUID("3050f3d0-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLRuleStyle;

@GUID("305106ef-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLCSSRule;

@GUID("305106f0-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLCSSImportRule;

@GUID("305106f1-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLCSSMediaRule;

@GUID("30510732-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLCSSMediaList;

@GUID("305106f2-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLCSSNamespaceRule;

@GUID("3051080e-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLMSCSSKeyframeRule;

@GUID("3051080f-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLMSCSSKeyframesRule;

@GUID("3050f6aa-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLRenderStyle;

@GUID("3050f3dc-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLCurrentStyle;

@GUID("3050f4b2-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLDOMAttribute;

@GUID("3050f4ba-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLDOMTextNode;

@GUID("3050f80e-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLDOMImplementation;

@GUID("3050f4cc-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLAttributeCollection;

@GUID("30510467-98b5-11cf-bb82-00aa00bdce0b")
struct StaticNodeList;

@GUID("3050f5aa-98b5-11cf-bb82-00aa00bdce0b")
struct DOMChildrenCollection;

@GUID("3050f6c8-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLDefaults;

@GUID("3050f4fc-98b5-11cf-bb82-00aa00bdce0b")
struct HTCDefaultDispatch;

@GUID("3050f5de-98b5-11cf-bb82-00aa00bdce0b")
struct HTCPropertyBehavior;

@GUID("3050f630-98b5-11cf-bb82-00aa00bdce0b")
struct HTCMethodBehavior;

@GUID("3050f4fe-98b5-11cf-bb82-00aa00bdce0b")
struct HTCEventBehavior;

@GUID("3050f5f5-98b5-11cf-bb82-00aa00bdce0b")
struct HTCAttachBehavior;

@GUID("3050f5dd-98b5-11cf-bb82-00aa00bdce0b")
struct HTCDescBehavior;

@GUID("3050f580-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLUrnCollection;

@GUID("3050f4b8-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLGenericElement;

@GUID("3050f3ce-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLStyleSheetRule;

@GUID("3050f3cd-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLStyleSheetRulesCollection;

@GUID("3050f7ef-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLStyleSheetPage;

@GUID("3050f7f1-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLStyleSheetPagesCollection;

@GUID("3050f2e4-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLStyleSheet;

@GUID("3050f37f-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLStyleSheetsCollection;

@GUID("3050f277-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLLinkElement;

@GUID("305106c3-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLDOMRange;

@GUID("3050f251-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLFormElement;

@GUID("3050f26a-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLTextElement;

@GUID("3050f241-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLImg;

@GUID("3050f38f-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLImageElementFactory;

@GUID("3050f24a-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLBody;

@GUID("3050f27b-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLFontElement;

@GUID("3050f248-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLAnchorElement;

@GUID("3050f32b-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLLabelElement;

@GUID("3050f272-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLListElement;

@GUID("3050f269-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLUListElement;

@GUID("3050f270-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLOListElement;

@GUID("3050f273-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLLIElement;

@GUID("3050f281-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLBlockElement;

@GUID("3050f27e-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLDivElement;

@GUID("3050f27f-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLDDElement;

@GUID("3050f27c-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLDTElement;

@GUID("3050f280-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLBRElement;

@GUID("3050f27d-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLDListElement;

@GUID("3050f252-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLHRElement;

@GUID("3050f26f-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLParaElement;

@GUID("3050f4cb-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLElementCollection;

@GUID("3050f27a-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLHeaderElement;

@GUID("3050f245-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLSelectElement;

@GUID("3050f2cf-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLWndSelectElement;

@GUID("3050f24d-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLOptionElement;

@GUID("3050f38d-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLOptionElementFactory;

@GUID("3050f2d0-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLWndOptionElement;

@GUID("3050f5d8-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLInputElement;

@GUID("3050f2ac-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLTextAreaElement;

@GUID("3050f2df-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLRichtextElement;

@GUID("3050f2c6-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLButtonElement;

@GUID("3050f2b9-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLMarqueeElement;

@GUID("3050f491-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLHtmlElement;

@GUID("3050f493-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLHeadElement;

@GUID("3050f284-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLTitleElement;

@GUID("3050f275-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLMetaElement;

@GUID("3050f276-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLBaseElement;

@GUID("3050f278-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLIsIndexElement;

@GUID("3050f279-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLNextIdElement;

@GUID("3050f282-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLBaseFontElement;

@GUID("3050f268-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLUnknownElement;

@GUID("feceaaa3-8405-11cf-8ba1-00aa00476da6")
struct HTMLHistory;

@GUID("3050f402-98b5-11cf-bb82-00aa00bdce0b")
struct COpsProfile;

@GUID("feceaaa6-8405-11cf-8ba1-00aa00476da6")
struct HTMLNavigator;

@GUID("163bb1e1-6e00-11cf-837a-48dc04c10000")
struct HTMLLocation;

@GUID("3050f3fe-98b5-11cf-bb82-00aa00bdce0b")
struct CMimeTypes;

@GUID("3050f3ff-98b5-11cf-bb82-00aa00bdce0b")
struct CPlugins;

@GUID("3050f48a-98b5-11cf-bb82-00aa00bdce0b")
struct CEventObj;

@GUID("3051074c-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLStyleMedia;

@GUID("3050f7f6-98b5-11cf-bb82-00aa00bdce0b")
struct FramesCollection;

@GUID("3050f35d-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLScreen;

@GUID("d48a6ec6-6a4a-11cf-94a7-444553540000")
struct HTMLWindow2;

@GUID("3050f391-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLWindowProxy;

@GUID("3051041b-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLDocumentCompatibleInfo;

@GUID("30510419-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLDocumentCompatibleInfoCollection;

@GUID("25336920-03f9-11cf-8fd0-00aa00686f13")
struct HTMLDocument;

@GUID("ae24fdae-03c6-11d1-8b76-0080c744f389")
struct Scriptlet;

@GUID("3050f25d-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLEmbed;

@GUID("3050f4ca-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLAreasCollection;

@GUID("3050f271-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLMapElement;

@GUID("3050f283-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLAreaElement;

@GUID("3050f2ec-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLTableCaption;

@GUID("3050f317-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLCommentElement;

@GUID("3050f26e-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLPhraseElement;

@GUID("3050f3f5-98b4-11cf-bb82-00aa00bdce0b")
struct HTMLSpanElement;

@GUID("3050f26b-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLTable;

@GUID("3050f26c-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLTableCol;

@GUID("3050f2e9-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLTableSection;

@GUID("3050f26d-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLTableRow;

@GUID("3050f246-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLTableCell;

@GUID("3050f28c-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLScriptElement;

@GUID("3050f38b-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLNoShowElement;

@GUID("3050f24e-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLObjectElement;

@GUID("3050f83e-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLParamElement;

@GUID("3050f312-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLFrameBase;

@GUID("3050f314-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLFrameElement;

@GUID("3050f316-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLIFrame;

@GUID("3050f249-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLDivPosition;

@GUID("3050f3e8-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLFieldSetElement;

@GUID("3050f3e9-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLLegendElement;

@GUID("3050f3e6-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLSpanFlow;

@GUID("3050f31a-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLFrameSetSite;

@GUID("3050f370-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLBGsound;

@GUID("3050f37d-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLStyleElement;

@GUID("3050f3d4-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLStyleFontFace;

@GUID("30510455-98b5-11cf-bb82-00aa00bdce0b")
struct XDomainRequest;

@GUID("30510457-98b5-11cf-bb82-00aa00bdce0b")
struct XDomainRequestFactory;

@GUID("30510475-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLStorage;

@GUID("305104bb-98b5-11cf-bb82-00aa00bdce0b")
struct DOMEvent;

@GUID("305106cb-98b5-11cf-bb82-00aa00bdce0b")
struct DOMUIEvent;

@GUID("305106cf-98b5-11cf-bb82-00aa00bdce0b")
struct DOMMouseEvent;

@GUID("30510762-98b5-11cf-bb82-00aa00bdce0b")
struct DOMDragEvent;

@GUID("305106d1-98b5-11cf-bb82-00aa00bdce0b")
struct DOMMouseWheelEvent;

@GUID("305106d3-98b5-11cf-bb82-00aa00bdce0b")
struct DOMWheelEvent;

@GUID("305106d5-98b5-11cf-bb82-00aa00bdce0b")
struct DOMTextEvent;

@GUID("305106d7-98b5-11cf-bb82-00aa00bdce0b")
struct DOMKeyboardEvent;

@GUID("305106d9-98b5-11cf-bb82-00aa00bdce0b")
struct DOMCompositionEvent;

@GUID("305106db-98b5-11cf-bb82-00aa00bdce0b")
struct DOMMutationEvent;

@GUID("30510764-98b5-11cf-bb82-00aa00bdce0b")
struct DOMBeforeUnloadEvent;

@GUID("305106cd-98b5-11cf-bb82-00aa00bdce0b")
struct DOMFocusEvent;

@GUID("305106df-98b5-11cf-bb82-00aa00bdce0b")
struct DOMCustomEvent;

@GUID("30510715-98b5-11cf-bb82-00aa00bdce0b")
struct CanvasGradient;

@GUID("30510717-98b5-11cf-bb82-00aa00bdce0b")
struct CanvasPattern;

@GUID("30510719-98b5-11cf-bb82-00aa00bdce0b")
struct CanvasTextMetrics;

@GUID("3051071b-98b5-11cf-bb82-00aa00bdce0b")
struct CanvasImageData;

@GUID("30510700-98b5-11cf-bb82-00aa00bdce0b")
struct CanvasRenderingContext2D;

@GUID("305106e5-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLCanvasElement;

@GUID("3051071f-98b5-11cf-bb82-00aa00bdce0b")
struct DOMProgressEvent;

@GUID("30510721-98b5-11cf-bb82-00aa00bdce0b")
struct DOMMessageEvent;

@GUID("30510766-98b6-11cf-bb82-00aa00bdce0b")
struct DOMSiteModeEvent;

@GUID("30510723-98b5-11cf-bb82-00aa00bdce0b")
struct DOMStorageEvent;

@GUID("30510831-98b5-11cf-bb82-00aa00bdce0b")
struct XMLHttpRequestEventTarget;

@GUID("3051040b-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLXMLHttpRequest;

@GUID("3051040d-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLXMLHttpRequestFactory;

@GUID("30510584-98b5-11cf-bb82-00aa00bdce0b")
struct SVGAngle;

@GUID("305105e4-98b5-11cf-bb82-00aa00bdce0b")
struct SVGAnimatedAngle;

@GUID("305105b1-98b5-11cf-bb82-00aa00bdce0b")
struct SVGAnimatedTransformList;

@GUID("3051058b-98b5-11cf-bb82-00aa00bdce0b")
struct SVGAnimatedBoolean;

@GUID("3051058e-98b5-11cf-bb82-00aa00bdce0b")
struct SVGAnimatedEnumeration;

@GUID("3051058f-98b5-11cf-bb82-00aa00bdce0b")
struct SVGAnimatedInteger;

@GUID("30510581-98b5-11cf-bb82-00aa00bdce0b")
struct SVGAnimatedLength;

@GUID("30510582-98b5-11cf-bb82-00aa00bdce0b")
struct SVGAnimatedLengthList;

@GUID("30510588-98b5-11cf-bb82-00aa00bdce0b")
struct SVGAnimatedNumber;

@GUID("3051058a-98b5-11cf-bb82-00aa00bdce0b")
struct SVGAnimatedNumberList;

@GUID("30510586-98b5-11cf-bb82-00aa00bdce0b")
struct SVGAnimatedRect;

@GUID("3051058c-98b5-11cf-bb82-00aa00bdce0b")
struct SVGAnimatedString;

@GUID("305105e6-98b5-11cf-bb82-00aa00bdce0b")
struct SVGClipPathElement;

@GUID("30510564-98b5-11cf-bb82-00aa00bdce0b")
struct SVGElement;

@GUID("3051057e-98b5-11cf-bb82-00aa00bdce0b")
struct SVGLength;

@GUID("30510580-98b5-11cf-bb82-00aa00bdce0b")
struct SVGLengthList;

@GUID("305105ae-98b5-11cf-bb82-00aa00bdce0b")
struct SVGMatrix;

@GUID("30510587-98b5-11cf-bb82-00aa00bdce0b")
struct SVGNumber;

@GUID("30510589-98b5-11cf-bb82-00aa00bdce0b")
struct SVGNumberList;

@GUID("305105d4-98b5-11cf-bb82-00aa00bdce0b")
struct SVGPatternElement;

@GUID("305105b3-98b5-11cf-bb82-00aa00bdce0b")
struct SVGPathSeg;

@GUID("305105bb-98b5-11cf-bb82-00aa00bdce0b")
struct SVGPathSegArcAbs;

@GUID("305105bc-98b5-11cf-bb82-00aa00bdce0b")
struct SVGPathSegArcRel;

@GUID("305105bd-98b5-11cf-bb82-00aa00bdce0b")
struct SVGPathSegClosePath;

@GUID("305105cc-98b5-11cf-bb82-00aa00bdce0b")
struct SVGPathSegMovetoAbs;

@GUID("305105cd-98b5-11cf-bb82-00aa00bdce0b")
struct SVGPathSegMovetoRel;

@GUID("305105c6-98b5-11cf-bb82-00aa00bdce0b")
struct SVGPathSegLinetoAbs;

@GUID("305105c9-98b5-11cf-bb82-00aa00bdce0b")
struct SVGPathSegLinetoRel;

@GUID("305105be-98b5-11cf-bb82-00aa00bdce0b")
struct SVGPathSegCurvetoCubicAbs;

@GUID("305105bf-98b5-11cf-bb82-00aa00bdce0b")
struct SVGPathSegCurvetoCubicRel;

@GUID("305105c0-98b5-11cf-bb82-00aa00bdce0b")
struct SVGPathSegCurvetoCubicSmoothAbs;

@GUID("305105c1-98b5-11cf-bb82-00aa00bdce0b")
struct SVGPathSegCurvetoCubicSmoothRel;

@GUID("305105c2-98b5-11cf-bb82-00aa00bdce0b")
struct SVGPathSegCurvetoQuadraticAbs;

@GUID("305105c3-98b5-11cf-bb82-00aa00bdce0b")
struct SVGPathSegCurvetoQuadraticRel;

@GUID("305105c4-98b5-11cf-bb82-00aa00bdce0b")
struct SVGPathSegCurvetoQuadraticSmoothAbs;

@GUID("305105c5-98b5-11cf-bb82-00aa00bdce0b")
struct SVGPathSegCurvetoQuadraticSmoothRel;

@GUID("305105c7-98b5-11cf-bb82-00aa00bdce0b")
struct SVGPathSegLinetoHorizontalAbs;

@GUID("305105c8-98b5-11cf-bb82-00aa00bdce0b")
struct SVGPathSegLinetoHorizontalRel;

@GUID("305105ca-98b5-11cf-bb82-00aa00bdce0b")
struct SVGPathSegLinetoVerticalAbs;

@GUID("305105cb-98b5-11cf-bb82-00aa00bdce0b")
struct SVGPathSegLinetoVerticalRel;

@GUID("305105b4-98b5-11cf-bb82-00aa00bdce0b")
struct SVGPathSegList;

@GUID("305105ba-98b5-11cf-bb82-00aa00bdce0b")
struct SVGPoint;

@GUID("305105b9-98b5-11cf-bb82-00aa00bdce0b")
struct SVGPointList;

@GUID("30510583-98b5-11cf-bb82-00aa00bdce0b")
struct SVGRect;

@GUID("3051058d-98b5-11cf-bb82-00aa00bdce0b")
struct SVGStringList;

@GUID("305105af-98b5-11cf-bb82-00aa00bdce0b")
struct SVGTransform;

@GUID("30510574-98b5-11cf-bb82-00aa00bdce0b")
struct SVGSVGElement;

@GUID("30510590-98b5-11cf-bb82-00aa00bdce0b")
struct SVGUseElement;

@GUID("eb36f845-2395-4719-b85c-d0d80e184bd9")
struct HTMLStyleSheetRulesAppliedCollection;

@GUID("7c803920-7a53-4d26-98ac-fdd23e6b9e01")
struct RulesApplied;

@GUID("671926ee-c3cf-40af-be8f-1cbaee6486e8")
struct RulesAppliedCollection;

@GUID("305106c8-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLW3CComputedStyle;

@GUID("305105b0-98b5-11cf-bb82-00aa00bdce0b")
struct SVGTransformList;

@GUID("30510578-98b5-11cf-bb82-00aa00bdce0b")
struct SVGCircleElement;

@GUID("30510579-98b5-11cf-bb82-00aa00bdce0b")
struct SVGEllipseElement;

@GUID("3051057a-98b5-11cf-bb82-00aa00bdce0b")
struct SVGLineElement;

@GUID("30510577-98b5-11cf-bb82-00aa00bdce0b")
struct SVGRectElement;

@GUID("3051057b-98b5-11cf-bb82-00aa00bdce0b")
struct SVGPolygonElement;

@GUID("3051057c-98b5-11cf-bb82-00aa00bdce0b")
struct SVGPolylineElement;

@GUID("3051056f-98b5-11cf-bb82-00aa00bdce0b")
struct SVGGElement;

@GUID("30510571-98b5-11cf-bb82-00aa00bdce0b")
struct SVGSymbolElement;

@GUID("30510570-98b5-11cf-bb82-00aa00bdce0b")
struct SVGDefsElement;

@GUID("305105b2-98b5-11cf-bb82-00aa00bdce0b")
struct SVGPathElement;

@GUID("305105d0-98b5-11cf-bb82-00aa00bdce0b")
struct SVGPreserveAspectRatio;

@GUID("305105df-98b5-11cf-bb82-00aa00bdce0b")
struct SVGTextElement;

@GUID("305105ce-98b5-11cf-bb82-00aa00bdce0b")
struct SVGAnimatedPreserveAspectRatio;

@GUID("305105cf-98b5-11cf-bb82-00aa00bdce0b")
struct SVGImageElement;

@GUID("305105d5-98b5-11cf-bb82-00aa00bdce0b")
struct SVGStopElement;

@GUID("305105d6-98b5-11cf-bb82-00aa00bdce0b")
struct SVGGradientElement;

@GUID("305105d2-98b5-11cf-bb82-00aa00bdce0b")
struct SVGLinearGradientElement;

@GUID("305105d3-98b5-11cf-bb82-00aa00bdce0b")
struct SVGRadialGradientElement;

@GUID("305105e7-98b5-11cf-bb82-00aa00bdce0b")
struct SVGMaskElement;

@GUID("305105de-98b5-11cf-bb82-00aa00bdce0b")
struct SVGMarkerElement;

@GUID("305105d9-98b5-11cf-bb82-00aa00bdce0b")
struct SVGZoomEvent;

@GUID("305105db-98b5-11cf-bb82-00aa00bdce0b")
struct SVGAElement;

@GUID("305105dc-98b5-11cf-bb82-00aa00bdce0b")
struct SVGViewElement;

@GUID("3051070a-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLMediaError;

@GUID("3051070b-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLTimeRanges;

@GUID("3051070c-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLMediaElement;

@GUID("3051070d-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLSourceElement;

@GUID("3051070e-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLAudioElement;

@GUID("305107ec-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLAudioElementFactory;

@GUID("3051070f-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLVideoElement;

@GUID("305105d8-98b5-11cf-bb82-00aa00bdce0b")
struct SVGSwitchElement;

@GUID("30510572-98b5-11cf-bb82-00aa00bdce0b")
struct SVGDescElement;

@GUID("30510573-98b5-11cf-bb82-00aa00bdce0b")
struct SVGTitleElement;

@GUID("305105d7-98b5-11cf-bb82-00aa00bdce0b")
struct SVGMetadataElement;

@GUID("30510575-98b5-11cf-bb82-00aa00bdce0b")
struct SVGElementInstance;

@GUID("30510576-98b5-11cf-bb82-00aa00bdce0b")
struct SVGElementInstanceList;

@GUID("3051072c-98b5-11cf-bb82-00aa00bdce0b")
struct DOMException;

@GUID("3051072e-98b5-11cf-bb82-00aa00bdce0b")
struct RangeException;

@GUID("30510730-98b5-11cf-bb82-00aa00bdce0b")
struct SVGException;

@GUID("3051073b-98b5-11cf-bb82-00aa00bdce0b")
struct EventException;

@GUID("305105e1-98b5-11cf-bb82-00aa00bdce0b")
struct SVGScriptElement;

@GUID("305105d1-98b5-11cf-bb82-00aa00bdce0b")
struct SVGStyleElement;

@GUID("305105dd-98b5-11cf-bb82-00aa00bdce0b")
struct SVGTextContentElement;

@GUID("305105e0-98b5-11cf-bb82-00aa00bdce0b")
struct SVGTextPositioningElement;

@GUID("30510739-98b5-11cf-bb82-00aa00bdce0b")
struct DOMDocumentType;

@GUID("30510745-98b5-11cf-bb82-00aa00bdce0b")
struct NodeIterator;

@GUID("30510747-98b5-11cf-bb82-00aa00bdce0b")
struct TreeWalker;

@GUID("30510743-98b5-11cf-bb82-00aa00bdce0b")
struct DOMProcessingInstruction;

@GUID("3051074f-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLPerformance;

@GUID("30510751-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLPerformanceNavigation;

@GUID("30510753-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLPerformanceTiming;

@GUID("305105e2-98b5-11cf-bb82-00aa00bdce0b")
struct SVGTSpanElement;

@GUID("3050f6b3-98b5-11cf-bb82-00aa00bdce0b")
struct CTemplatePrinter;

@GUID("63619f54-9d71-4c23-a08d-50d7f18db2e9")
struct CPrintManagerTemplatePrinter;

@GUID("305105eb-98b5-11cf-bb82-00aa00bdce0b")
struct SVGTextPathElement;

@GUID("3051077e-98b5-11cf-bb82-00aa00bdce0b")
struct XMLSerializer;

@GUID("30510782-98b5-11cf-bb82-00aa00bdce0b")
struct DOMParser;

@GUID("30510780-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLDOMXmlSerializerFactory;

@GUID("30510784-98b5-11cf-bb82-00aa00bdce0b")
struct DOMParserFactory;

@GUID("305107b0-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLSemanticElement;

@GUID("3050f2d5-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLProgressElement;

@GUID("305107b6-98b5-11cf-bb82-00aa00bdce0b")
struct DOMMSTransitionEvent;

@GUID("305107b8-98b5-11cf-bb82-00aa00bdce0b")
struct DOMMSAnimationEvent;

@GUID("305107c6-98b5-11cf-bb82-00aa00bdce0b")
struct WebGeolocation;

@GUID("305107c8-98b5-11cf-bb82-00aa00bdce0b")
struct WebGeocoordinates;

@GUID("305107ca-98b5-11cf-bb82-00aa00bdce0b")
struct WebGeopositionError;

@GUID("305107ce-98b5-11cf-bb82-00aa00bdce0b")
struct WebGeoposition;

@GUID("7e8bc44e-aeff-11d1-89c2-00c04fb6bfc4")
struct CClientCaps;

@GUID("30510817-98b5-11cf-bb82-00aa00bdce0b")
struct DOMMSManipulationEvent;

@GUID("30510800-98b5-11cf-bb82-00aa00bdce0b")
struct DOMCloseEvent;

@GUID("30510829-98b5-11cf-bb82-00aa00bdce0b")
struct ApplicationCache;

@GUID("3050f819-98b5-11cf-bb82-00aa00bdce0b")
struct HtmlDlgSafeHelper;

@GUID("3050f831-98b5-11cf-bb82-00aa00bdce0b")
struct BlockFormats;

@GUID("3050f83a-98b5-11cf-bb82-00aa00bdce0b")
struct FontNames;

@GUID("3050f6bc-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLNamespace;

@GUID("3050f6b9-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLNamespaceCollection;

@GUID("3050f5eb-98b5-11cf-bb82-00aa00bdce0b")
struct ThreadDialogProcParam;

@GUID("3050f28a-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLDialog;

@GUID("3050f667-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLPopup;

@GUID("3050f5cb-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLAppBehavior;

@GUID("d48a6ec9-6a4a-11cf-94a7-444553540000")
struct OldHTMLDocument;

@GUID("0d04d285-6bec-11cf-8b97-00aa00476da6")
struct OldHTMLFormElement;

@GUID("3050f2b4-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLInputButtonElement;

@GUID("3050f2ab-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLInputTextElement;

@GUID("3050f2ae-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLInputFileElement;

@GUID("3050f2be-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLOptionButtonElement;

@GUID("3050f2c4-98b5-11cf-bb82-00aa00bdce0b")
struct HTMLInputImage;

@GUID("3050f3ee-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLFiltersCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(VARIANT* pvarIndex, VARIANT* pvarResult);
}

@GUID("3051046b-98b5-11cf-bb82-00aa00bdce0b")
interface IIE70DispatchEx : IDispatchEx
{
}

@GUID("3051046c-98b5-11cf-bb82-00aa00bdce0b")
interface IIE80DispatchEx : IDispatchEx
{
}

@GUID("3050f32d-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLEventObj : IDispatch
{
    HRESULT get_srcElement(IHTMLElement* p);
    HRESULT get_altKey(VARIANT_BOOL* p);
    HRESULT get_ctrlKey(VARIANT_BOOL* p);
    HRESULT get_shiftKey(VARIANT_BOOL* p);
    HRESULT put_returnValue(VARIANT v);
    HRESULT get_returnValue(VARIANT* p);
    HRESULT put_cancelBubble(VARIANT_BOOL v);
    HRESULT get_cancelBubble(VARIANT_BOOL* p);
    HRESULT get_fromElement(IHTMLElement* p);
    HRESULT get_toElement(IHTMLElement* p);
    HRESULT put_keyCode(int v);
    HRESULT get_keyCode(int* p);
    HRESULT get_button(int* p);
    HRESULT get_type(BSTR* p);
    HRESULT get_qualifier(BSTR* p);
    HRESULT get_reason(int* p);
    HRESULT get_x(int* p);
    HRESULT get_y(int* p);
    HRESULT get_clientX(int* p);
    HRESULT get_clientY(int* p);
    HRESULT get_offsetX(int* p);
    HRESULT get_offsetY(int* p);
    HRESULT get_screenX(int* p);
    HRESULT get_screenY(int* p);
    HRESULT get_srcFilter(IDispatch* p);
}

@GUID("3050f427-98b5-11cf-bb82-00aa00bdce0b")
interface IElementBehaviorSite : IUnknown
{
    HRESULT GetElement(IHTMLElement* ppElement);
    HRESULT RegisterNotification(int lEvent);
}

@GUID("3050f425-98b5-11cf-bb82-00aa00bdce0b")
interface IElementBehavior : IUnknown
{
    HRESULT Init(IElementBehaviorSite pBehaviorSite);
    HRESULT Notify(int lEvent, VARIANT* pVar);
    HRESULT Detach();
}

@GUID("3050f429-98b5-11cf-bb82-00aa00bdce0b")
interface IElementBehaviorFactory : IUnknown
{
    HRESULT FindBehavior(BSTR bstrBehavior, BSTR bstrBehaviorUrl, IElementBehaviorSite pSite, 
                         IElementBehavior* ppBehavior);
}

@GUID("3050f489-98b5-11cf-bb82-00aa00bdce0b")
interface IElementBehaviorSiteOM : IUnknown
{
    HRESULT RegisterEvent(PWSTR pchEvent, int lFlags, int* plCookie);
    HRESULT GetEventCookie(PWSTR pchEvent, int* plCookie);
    HRESULT FireEvent(int lCookie, IHTMLEventObj pEventObject);
    HRESULT CreateEventObject(IHTMLEventObj* ppEventObject);
    HRESULT RegisterName(PWSTR pchName);
    HRESULT RegisterUrn(PWSTR pchUrn);
}

@GUID("3050f4aa-98b5-11cf-bb82-00aa00bdce0b")
interface IElementBehaviorRender : IUnknown
{
    HRESULT Draw(HDC hdc, int lLayer, RECT* pRect, IUnknown pReserved);
    HRESULT GetRenderInfo(int* plRenderInfo);
    HRESULT HitTestPoint(POINT* pPoint, IUnknown pReserved, BOOL* pbHit);
}

@GUID("3050f4a7-98b5-11cf-bb82-00aa00bdce0b")
interface IElementBehaviorSiteRender : IUnknown
{
    HRESULT Invalidate(RECT* pRect);
    HRESULT InvalidateRenderInfo();
    HRESULT InvalidateStyle();
}

@GUID("305104ba-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMEvent : IDispatch
{
    HRESULT get_bubbles(VARIANT_BOOL* p);
    HRESULT get_cancelable(VARIANT_BOOL* p);
    HRESULT get_currentTarget(IEventTarget* p);
    HRESULT get_defaultPrevented(VARIANT_BOOL* p);
    HRESULT get_eventPhase(ushort* p);
    HRESULT get_target(IEventTarget* p);
    HRESULT get_timeStamp(ulong* p);
    HRESULT get_type(BSTR* p);
    HRESULT initEvent(BSTR eventType, VARIANT_BOOL canBubble, VARIANT_BOOL cancelable);
    HRESULT preventDefault();
    HRESULT stopPropagation();
    HRESULT stopImmediatePropagation();
    HRESULT get_isTrusted(VARIANT_BOOL* p);
    HRESULT put_cancelBubble(VARIANT_BOOL v);
    HRESULT get_cancelBubble(VARIANT_BOOL* p);
    HRESULT get_srcElement(IHTMLElement* p);
}

@GUID("3051049b-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDOMConstructor : IDispatch
{
    HRESULT get_constructor(IDispatch* p);
    HRESULT LookupGetter(BSTR propname, VARIANT* ppDispHandler);
    HRESULT LookupSetter(BSTR propname, VARIANT* ppDispHandler);
    HRESULT DefineGetter(BSTR propname, VARIANT* pdispHandler);
    HRESULT DefineSetter(BSTR propname, VARIANT* pdispHandler);
}

@GUID("3050f357-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStyleSheetRule : IDispatch
{
    HRESULT put_selectorText(BSTR v);
    HRESULT get_selectorText(BSTR* p);
    HRESULT get_style(IHTMLRuleStyle* p);
    HRESULT get_readOnly(VARIANT_BOOL* p);
}

@GUID("30510740-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLCSSStyleDeclaration : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get_parentRule(VARIANT* p);
    HRESULT getPropertyValue(BSTR bstrPropertyName, BSTR* pbstrPropertyValue);
    HRESULT getPropertyPriority(BSTR bstrPropertyName, BSTR* pbstrPropertyPriority);
    HRESULT removeProperty(BSTR bstrPropertyName, BSTR* pbstrPropertyValue);
    HRESULT setProperty(BSTR bstrPropertyName, VARIANT* pvarPropertyValue, VARIANT* pvarPropertyPriority);
    HRESULT item(int index, BSTR* pbstrPropertyName);
    HRESULT put_fontFamily(BSTR v);
    HRESULT get_fontFamily(BSTR* p);
    HRESULT put_fontStyle(BSTR v);
    HRESULT get_fontStyle(BSTR* p);
    HRESULT put_fontVariant(BSTR v);
    HRESULT get_fontVariant(BSTR* p);
    HRESULT put_fontWeight(BSTR v);
    HRESULT get_fontWeight(BSTR* p);
    HRESULT put_fontSize(VARIANT v);
    HRESULT get_fontSize(VARIANT* p);
    HRESULT put_font(BSTR v);
    HRESULT get_font(BSTR* p);
    HRESULT put_color(VARIANT v);
    HRESULT get_color(VARIANT* p);
    HRESULT put_background(BSTR v);
    HRESULT get_background(BSTR* p);
    HRESULT put_backgroundColor(VARIANT v);
    HRESULT get_backgroundColor(VARIANT* p);
    HRESULT put_backgroundImage(BSTR v);
    HRESULT get_backgroundImage(BSTR* p);
    HRESULT put_backgroundRepeat(BSTR v);
    HRESULT get_backgroundRepeat(BSTR* p);
    HRESULT put_backgroundAttachment(BSTR v);
    HRESULT get_backgroundAttachment(BSTR* p);
    HRESULT put_backgroundPosition(BSTR v);
    HRESULT get_backgroundPosition(BSTR* p);
    HRESULT put_backgroundPositionX(VARIANT v);
    HRESULT get_backgroundPositionX(VARIANT* p);
    HRESULT put_backgroundPositionY(VARIANT v);
    HRESULT get_backgroundPositionY(VARIANT* p);
    HRESULT put_wordSpacing(VARIANT v);
    HRESULT get_wordSpacing(VARIANT* p);
    HRESULT put_letterSpacing(VARIANT v);
    HRESULT get_letterSpacing(VARIANT* p);
    HRESULT put_textDecoration(BSTR v);
    HRESULT get_textDecoration(BSTR* p);
    HRESULT put_verticalAlign(VARIANT v);
    HRESULT get_verticalAlign(VARIANT* p);
    HRESULT put_textTransform(BSTR v);
    HRESULT get_textTransform(BSTR* p);
    HRESULT put_textAlign(BSTR v);
    HRESULT get_textAlign(BSTR* p);
    HRESULT put_textIndent(VARIANT v);
    HRESULT get_textIndent(VARIANT* p);
    HRESULT put_lineHeight(VARIANT v);
    HRESULT get_lineHeight(VARIANT* p);
    HRESULT put_marginTop(VARIANT v);
    HRESULT get_marginTop(VARIANT* p);
    HRESULT put_marginRight(VARIANT v);
    HRESULT get_marginRight(VARIANT* p);
    HRESULT put_marginBottom(VARIANT v);
    HRESULT get_marginBottom(VARIANT* p);
    HRESULT put_marginLeft(VARIANT v);
    HRESULT get_marginLeft(VARIANT* p);
    HRESULT put_margin(BSTR v);
    HRESULT get_margin(BSTR* p);
    HRESULT put_paddingTop(VARIANT v);
    HRESULT get_paddingTop(VARIANT* p);
    HRESULT put_paddingRight(VARIANT v);
    HRESULT get_paddingRight(VARIANT* p);
    HRESULT put_paddingBottom(VARIANT v);
    HRESULT get_paddingBottom(VARIANT* p);
    HRESULT put_paddingLeft(VARIANT v);
    HRESULT get_paddingLeft(VARIANT* p);
    HRESULT put_padding(BSTR v);
    HRESULT get_padding(BSTR* p);
    HRESULT put_border(BSTR v);
    HRESULT get_border(BSTR* p);
    HRESULT put_borderTop(BSTR v);
    HRESULT get_borderTop(BSTR* p);
    HRESULT put_borderRight(BSTR v);
    HRESULT get_borderRight(BSTR* p);
    HRESULT put_borderBottom(BSTR v);
    HRESULT get_borderBottom(BSTR* p);
    HRESULT put_borderLeft(BSTR v);
    HRESULT get_borderLeft(BSTR* p);
    HRESULT put_borderColor(BSTR v);
    HRESULT get_borderColor(BSTR* p);
    HRESULT put_borderTopColor(VARIANT v);
    HRESULT get_borderTopColor(VARIANT* p);
    HRESULT put_borderRightColor(VARIANT v);
    HRESULT get_borderRightColor(VARIANT* p);
    HRESULT put_borderBottomColor(VARIANT v);
    HRESULT get_borderBottomColor(VARIANT* p);
    HRESULT put_borderLeftColor(VARIANT v);
    HRESULT get_borderLeftColor(VARIANT* p);
    HRESULT put_borderWidth(BSTR v);
    HRESULT get_borderWidth(BSTR* p);
    HRESULT put_borderTopWidth(VARIANT v);
    HRESULT get_borderTopWidth(VARIANT* p);
    HRESULT put_borderRightWidth(VARIANT v);
    HRESULT get_borderRightWidth(VARIANT* p);
    HRESULT put_borderBottomWidth(VARIANT v);
    HRESULT get_borderBottomWidth(VARIANT* p);
    HRESULT put_borderLeftWidth(VARIANT v);
    HRESULT get_borderLeftWidth(VARIANT* p);
    HRESULT put_borderStyle(BSTR v);
    HRESULT get_borderStyle(BSTR* p);
    HRESULT put_borderTopStyle(BSTR v);
    HRESULT get_borderTopStyle(BSTR* p);
    HRESULT put_borderRightStyle(BSTR v);
    HRESULT get_borderRightStyle(BSTR* p);
    HRESULT put_borderBottomStyle(BSTR v);
    HRESULT get_borderBottomStyle(BSTR* p);
    HRESULT put_borderLeftStyle(BSTR v);
    HRESULT get_borderLeftStyle(BSTR* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
    HRESULT put_styleFloat(BSTR v);
    HRESULT get_styleFloat(BSTR* p);
    HRESULT put_clear(BSTR v);
    HRESULT get_clear(BSTR* p);
    HRESULT put_display(BSTR v);
    HRESULT get_display(BSTR* p);
    HRESULT put_visibility(BSTR v);
    HRESULT get_visibility(BSTR* p);
    HRESULT put_listStyleType(BSTR v);
    HRESULT get_listStyleType(BSTR* p);
    HRESULT put_listStylePosition(BSTR v);
    HRESULT get_listStylePosition(BSTR* p);
    HRESULT put_listStyleImage(BSTR v);
    HRESULT get_listStyleImage(BSTR* p);
    HRESULT put_listStyle(BSTR v);
    HRESULT get_listStyle(BSTR* p);
    HRESULT put_whiteSpace(BSTR v);
    HRESULT get_whiteSpace(BSTR* p);
    HRESULT put_top(VARIANT v);
    HRESULT get_top(VARIANT* p);
    HRESULT put_left(VARIANT v);
    HRESULT get_left(VARIANT* p);
    HRESULT put_zIndex(VARIANT v);
    HRESULT get_zIndex(VARIANT* p);
    HRESULT put_overflow(BSTR v);
    HRESULT get_overflow(BSTR* p);
    HRESULT put_pageBreakBefore(BSTR v);
    HRESULT get_pageBreakBefore(BSTR* p);
    HRESULT put_pageBreakAfter(BSTR v);
    HRESULT get_pageBreakAfter(BSTR* p);
    HRESULT put_cssText(BSTR v);
    HRESULT get_cssText(BSTR* p);
    HRESULT put_cursor(BSTR v);
    HRESULT get_cursor(BSTR* p);
    HRESULT put_clip(BSTR v);
    HRESULT get_clip(BSTR* p);
    HRESULT put_filter(BSTR v);
    HRESULT get_filter(BSTR* p);
    HRESULT put_tableLayout(BSTR v);
    HRESULT get_tableLayout(BSTR* p);
    HRESULT put_borderCollapse(BSTR v);
    HRESULT get_borderCollapse(BSTR* p);
    HRESULT put_direction(BSTR v);
    HRESULT get_direction(BSTR* p);
    HRESULT put_behavior(BSTR v);
    HRESULT get_behavior(BSTR* p);
    HRESULT put_position(BSTR v);
    HRESULT get_position(BSTR* p);
    HRESULT put_unicodeBidi(BSTR v);
    HRESULT get_unicodeBidi(BSTR* p);
    HRESULT put_bottom(VARIANT v);
    HRESULT get_bottom(VARIANT* p);
    HRESULT put_right(VARIANT v);
    HRESULT get_right(VARIANT* p);
    HRESULT put_imeMode(BSTR v);
    HRESULT get_imeMode(BSTR* p);
    HRESULT put_rubyAlign(BSTR v);
    HRESULT get_rubyAlign(BSTR* p);
    HRESULT put_rubyPosition(BSTR v);
    HRESULT get_rubyPosition(BSTR* p);
    HRESULT put_rubyOverhang(BSTR v);
    HRESULT get_rubyOverhang(BSTR* p);
    HRESULT put_layoutGridChar(VARIANT v);
    HRESULT get_layoutGridChar(VARIANT* p);
    HRESULT put_layoutGridLine(VARIANT v);
    HRESULT get_layoutGridLine(VARIANT* p);
    HRESULT put_layoutGridMode(BSTR v);
    HRESULT get_layoutGridMode(BSTR* p);
    HRESULT put_layoutGridType(BSTR v);
    HRESULT get_layoutGridType(BSTR* p);
    HRESULT put_layoutGrid(BSTR v);
    HRESULT get_layoutGrid(BSTR* p);
    HRESULT put_textAutospace(BSTR v);
    HRESULT get_textAutospace(BSTR* p);
    HRESULT put_wordBreak(BSTR v);
    HRESULT get_wordBreak(BSTR* p);
    HRESULT put_lineBreak(BSTR v);
    HRESULT get_lineBreak(BSTR* p);
    HRESULT put_textJustify(BSTR v);
    HRESULT get_textJustify(BSTR* p);
    HRESULT put_textJustifyTrim(BSTR v);
    HRESULT get_textJustifyTrim(BSTR* p);
    HRESULT put_textKashida(VARIANT v);
    HRESULT get_textKashida(VARIANT* p);
    HRESULT put_overflowX(BSTR v);
    HRESULT get_overflowX(BSTR* p);
    HRESULT put_overflowY(BSTR v);
    HRESULT get_overflowY(BSTR* p);
    HRESULT put_accelerator(BSTR v);
    HRESULT get_accelerator(BSTR* p);
    HRESULT put_layoutFlow(BSTR v);
    HRESULT get_layoutFlow(BSTR* p);
    HRESULT put_zoom(VARIANT v);
    HRESULT get_zoom(VARIANT* p);
    HRESULT put_wordWrap(BSTR v);
    HRESULT get_wordWrap(BSTR* p);
    HRESULT put_textUnderlinePosition(BSTR v);
    HRESULT get_textUnderlinePosition(BSTR* p);
    HRESULT put_scrollbarBaseColor(VARIANT v);
    HRESULT get_scrollbarBaseColor(VARIANT* p);
    HRESULT put_scrollbarFaceColor(VARIANT v);
    HRESULT get_scrollbarFaceColor(VARIANT* p);
    HRESULT put_scrollbar3dLightColor(VARIANT v);
    HRESULT get_scrollbar3dLightColor(VARIANT* p);
    HRESULT put_scrollbarShadowColor(VARIANT v);
    HRESULT get_scrollbarShadowColor(VARIANT* p);
    HRESULT put_scrollbarHighlightColor(VARIANT v);
    HRESULT get_scrollbarHighlightColor(VARIANT* p);
    HRESULT put_scrollbarDarkShadowColor(VARIANT v);
    HRESULT get_scrollbarDarkShadowColor(VARIANT* p);
    HRESULT put_scrollbarArrowColor(VARIANT v);
    HRESULT get_scrollbarArrowColor(VARIANT* p);
    HRESULT put_scrollbarTrackColor(VARIANT v);
    HRESULT get_scrollbarTrackColor(VARIANT* p);
    HRESULT put_writingMode(BSTR v);
    HRESULT get_writingMode(BSTR* p);
    HRESULT put_textAlignLast(BSTR v);
    HRESULT get_textAlignLast(BSTR* p);
    HRESULT put_textKashidaSpace(VARIANT v);
    HRESULT get_textKashidaSpace(VARIANT* p);
    HRESULT put_textOverflow(BSTR v);
    HRESULT get_textOverflow(BSTR* p);
    HRESULT put_minHeight(VARIANT v);
    HRESULT get_minHeight(VARIANT* p);
    HRESULT put_msInterpolationMode(BSTR v);
    HRESULT get_msInterpolationMode(BSTR* p);
    HRESULT put_maxHeight(VARIANT v);
    HRESULT get_maxHeight(VARIANT* p);
    HRESULT put_minWidth(VARIANT v);
    HRESULT get_minWidth(VARIANT* p);
    HRESULT put_maxWidth(VARIANT v);
    HRESULT get_maxWidth(VARIANT* p);
    HRESULT put_content(BSTR v);
    HRESULT get_content(BSTR* p);
    HRESULT put_captionSide(BSTR v);
    HRESULT get_captionSide(BSTR* p);
    HRESULT put_counterIncrement(BSTR v);
    HRESULT get_counterIncrement(BSTR* p);
    HRESULT put_counterReset(BSTR v);
    HRESULT get_counterReset(BSTR* p);
    HRESULT put_outline(BSTR v);
    HRESULT get_outline(BSTR* p);
    HRESULT put_outlineWidth(VARIANT v);
    HRESULT get_outlineWidth(VARIANT* p);
    HRESULT put_outlineStyle(BSTR v);
    HRESULT get_outlineStyle(BSTR* p);
    HRESULT put_outlineColor(VARIANT v);
    HRESULT get_outlineColor(VARIANT* p);
    HRESULT put_boxSizing(BSTR v);
    HRESULT get_boxSizing(BSTR* p);
    HRESULT put_borderSpacing(BSTR v);
    HRESULT get_borderSpacing(BSTR* p);
    HRESULT put_orphans(VARIANT v);
    HRESULT get_orphans(VARIANT* p);
    HRESULT put_widows(VARIANT v);
    HRESULT get_widows(VARIANT* p);
    HRESULT put_pageBreakInside(BSTR v);
    HRESULT get_pageBreakInside(BSTR* p);
    HRESULT put_emptyCells(BSTR v);
    HRESULT get_emptyCells(BSTR* p);
    HRESULT put_msBlockProgression(BSTR v);
    HRESULT get_msBlockProgression(BSTR* p);
    HRESULT put_quotes(BSTR v);
    HRESULT get_quotes(BSTR* p);
    HRESULT put_alignmentBaseline(BSTR v);
    HRESULT get_alignmentBaseline(BSTR* p);
    HRESULT put_baselineShift(VARIANT v);
    HRESULT get_baselineShift(VARIANT* p);
    HRESULT put_dominantBaseline(BSTR v);
    HRESULT get_dominantBaseline(BSTR* p);
    HRESULT put_fontSizeAdjust(VARIANT v);
    HRESULT get_fontSizeAdjust(VARIANT* p);
    HRESULT put_fontStretch(BSTR v);
    HRESULT get_fontStretch(BSTR* p);
    HRESULT put_opacity(VARIANT v);
    HRESULT get_opacity(VARIANT* p);
    HRESULT put_clipPath(BSTR v);
    HRESULT get_clipPath(BSTR* p);
    HRESULT put_clipRule(BSTR v);
    HRESULT get_clipRule(BSTR* p);
    HRESULT put_fill(BSTR v);
    HRESULT get_fill(BSTR* p);
    HRESULT put_fillOpacity(VARIANT v);
    HRESULT get_fillOpacity(VARIANT* p);
    HRESULT put_fillRule(BSTR v);
    HRESULT get_fillRule(BSTR* p);
    HRESULT put_kerning(VARIANT v);
    HRESULT get_kerning(VARIANT* p);
    HRESULT put_marker(BSTR v);
    HRESULT get_marker(BSTR* p);
    HRESULT put_markerEnd(BSTR v);
    HRESULT get_markerEnd(BSTR* p);
    HRESULT put_markerMid(BSTR v);
    HRESULT get_markerMid(BSTR* p);
    HRESULT put_markerStart(BSTR v);
    HRESULT get_markerStart(BSTR* p);
    HRESULT put_mask(BSTR v);
    HRESULT get_mask(BSTR* p);
    HRESULT put_pointerEvents(BSTR v);
    HRESULT get_pointerEvents(BSTR* p);
    HRESULT put_stopColor(VARIANT v);
    HRESULT get_stopColor(VARIANT* p);
    HRESULT put_stopOpacity(VARIANT v);
    HRESULT get_stopOpacity(VARIANT* p);
    HRESULT put_stroke(BSTR v);
    HRESULT get_stroke(BSTR* p);
    HRESULT put_strokeDasharray(BSTR v);
    HRESULT get_strokeDasharray(BSTR* p);
    HRESULT put_strokeDashoffset(VARIANT v);
    HRESULT get_strokeDashoffset(VARIANT* p);
    HRESULT put_strokeLinecap(BSTR v);
    HRESULT get_strokeLinecap(BSTR* p);
    HRESULT put_strokeLinejoin(BSTR v);
    HRESULT get_strokeLinejoin(BSTR* p);
    HRESULT put_strokeMiterlimit(VARIANT v);
    HRESULT get_strokeMiterlimit(VARIANT* p);
    HRESULT put_strokeOpacity(VARIANT v);
    HRESULT get_strokeOpacity(VARIANT* p);
    HRESULT put_strokeWidth(VARIANT v);
    HRESULT get_strokeWidth(VARIANT* p);
    HRESULT put_textAnchor(BSTR v);
    HRESULT get_textAnchor(BSTR* p);
    HRESULT put_glyphOrientationHorizontal(VARIANT v);
    HRESULT get_glyphOrientationHorizontal(VARIANT* p);
    HRESULT put_glyphOrientationVertical(VARIANT v);
    HRESULT get_glyphOrientationVertical(VARIANT* p);
    HRESULT put_borderRadius(BSTR v);
    HRESULT get_borderRadius(BSTR* p);
    HRESULT put_borderTopLeftRadius(BSTR v);
    HRESULT get_borderTopLeftRadius(BSTR* p);
    HRESULT put_borderTopRightRadius(BSTR v);
    HRESULT get_borderTopRightRadius(BSTR* p);
    HRESULT put_borderBottomRightRadius(BSTR v);
    HRESULT get_borderBottomRightRadius(BSTR* p);
    HRESULT put_borderBottomLeftRadius(BSTR v);
    HRESULT get_borderBottomLeftRadius(BSTR* p);
    HRESULT put_clipTop(VARIANT v);
    HRESULT get_clipTop(VARIANT* p);
    HRESULT put_clipRight(VARIANT v);
    HRESULT get_clipRight(VARIANT* p);
    HRESULT get_clipBottom(VARIANT* p);
    HRESULT put_clipLeft(VARIANT v);
    HRESULT get_clipLeft(VARIANT* p);
    HRESULT put_cssFloat(BSTR v);
    HRESULT get_cssFloat(BSTR* p);
    HRESULT put_backgroundClip(BSTR v);
    HRESULT get_backgroundClip(BSTR* p);
    HRESULT put_backgroundOrigin(BSTR v);
    HRESULT get_backgroundOrigin(BSTR* p);
    HRESULT put_backgroundSize(BSTR v);
    HRESULT get_backgroundSize(BSTR* p);
    HRESULT put_boxShadow(BSTR v);
    HRESULT get_boxShadow(BSTR* p);
    HRESULT put_msTransform(BSTR v);
    HRESULT get_msTransform(BSTR* p);
    HRESULT put_msTransformOrigin(BSTR v);
    HRESULT get_msTransformOrigin(BSTR* p);
}

@GUID("305107d1-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLCSSStyleDeclaration2 : IDispatch
{
    HRESULT put_msScrollChaining(BSTR v);
    HRESULT get_msScrollChaining(BSTR* p);
    HRESULT put_msContentZooming(BSTR v);
    HRESULT get_msContentZooming(BSTR* p);
    HRESULT put_msContentZoomSnapType(BSTR v);
    HRESULT get_msContentZoomSnapType(BSTR* p);
    HRESULT put_msScrollRails(BSTR v);
    HRESULT get_msScrollRails(BSTR* p);
    HRESULT put_msContentZoomChaining(BSTR v);
    HRESULT get_msContentZoomChaining(BSTR* p);
    HRESULT put_msScrollSnapType(BSTR v);
    HRESULT get_msScrollSnapType(BSTR* p);
    HRESULT put_msContentZoomLimit(BSTR v);
    HRESULT get_msContentZoomLimit(BSTR* p);
    HRESULT put_msContentZoomSnap(BSTR v);
    HRESULT get_msContentZoomSnap(BSTR* p);
    HRESULT put_msContentZoomSnapPoints(BSTR v);
    HRESULT get_msContentZoomSnapPoints(BSTR* p);
    HRESULT put_msContentZoomLimitMin(VARIANT v);
    HRESULT get_msContentZoomLimitMin(VARIANT* p);
    HRESULT put_msContentZoomLimitMax(VARIANT v);
    HRESULT get_msContentZoomLimitMax(VARIANT* p);
    HRESULT put_msScrollSnapX(BSTR v);
    HRESULT get_msScrollSnapX(BSTR* p);
    HRESULT put_msScrollSnapY(BSTR v);
    HRESULT get_msScrollSnapY(BSTR* p);
    HRESULT put_msScrollSnapPointsX(BSTR v);
    HRESULT get_msScrollSnapPointsX(BSTR* p);
    HRESULT put_msScrollSnapPointsY(BSTR v);
    HRESULT get_msScrollSnapPointsY(BSTR* p);
    HRESULT put_msGridColumn(VARIANT v);
    HRESULT get_msGridColumn(VARIANT* p);
    HRESULT put_msGridColumnAlign(BSTR v);
    HRESULT get_msGridColumnAlign(BSTR* p);
    HRESULT put_msGridColumns(BSTR v);
    HRESULT get_msGridColumns(BSTR* p);
    HRESULT put_msGridColumnSpan(VARIANT v);
    HRESULT get_msGridColumnSpan(VARIANT* p);
    HRESULT put_msGridRow(VARIANT v);
    HRESULT get_msGridRow(VARIANT* p);
    HRESULT put_msGridRowAlign(BSTR v);
    HRESULT get_msGridRowAlign(BSTR* p);
    HRESULT put_msGridRows(BSTR v);
    HRESULT get_msGridRows(BSTR* p);
    HRESULT put_msGridRowSpan(VARIANT v);
    HRESULT get_msGridRowSpan(VARIANT* p);
    HRESULT put_msWrapThrough(BSTR v);
    HRESULT get_msWrapThrough(BSTR* p);
    HRESULT put_msWrapMargin(VARIANT v);
    HRESULT get_msWrapMargin(VARIANT* p);
    HRESULT put_msWrapFlow(BSTR v);
    HRESULT get_msWrapFlow(BSTR* p);
    HRESULT put_msAnimationName(BSTR v);
    HRESULT get_msAnimationName(BSTR* p);
    HRESULT put_msAnimationDuration(BSTR v);
    HRESULT get_msAnimationDuration(BSTR* p);
    HRESULT put_msAnimationTimingFunction(BSTR v);
    HRESULT get_msAnimationTimingFunction(BSTR* p);
    HRESULT put_msAnimationDelay(BSTR v);
    HRESULT get_msAnimationDelay(BSTR* p);
    HRESULT put_msAnimationDirection(BSTR v);
    HRESULT get_msAnimationDirection(BSTR* p);
    HRESULT put_msAnimationPlayState(BSTR v);
    HRESULT get_msAnimationPlayState(BSTR* p);
    HRESULT put_msAnimationIterationCount(BSTR v);
    HRESULT get_msAnimationIterationCount(BSTR* p);
    HRESULT put_msAnimation(BSTR v);
    HRESULT get_msAnimation(BSTR* p);
    HRESULT put_msAnimationFillMode(BSTR v);
    HRESULT get_msAnimationFillMode(BSTR* p);
    HRESULT put_colorInterpolationFilters(BSTR v);
    HRESULT get_colorInterpolationFilters(BSTR* p);
    HRESULT put_columnCount(VARIANT v);
    HRESULT get_columnCount(VARIANT* p);
    HRESULT put_columnWidth(VARIANT v);
    HRESULT get_columnWidth(VARIANT* p);
    HRESULT put_columnGap(VARIANT v);
    HRESULT get_columnGap(VARIANT* p);
    HRESULT put_columnFill(BSTR v);
    HRESULT get_columnFill(BSTR* p);
    HRESULT put_columnSpan(BSTR v);
    HRESULT get_columnSpan(BSTR* p);
    HRESULT put_columns(BSTR v);
    HRESULT get_columns(BSTR* p);
    HRESULT put_columnRule(BSTR v);
    HRESULT get_columnRule(BSTR* p);
    HRESULT put_columnRuleColor(VARIANT v);
    HRESULT get_columnRuleColor(VARIANT* p);
    HRESULT put_columnRuleStyle(BSTR v);
    HRESULT get_columnRuleStyle(BSTR* p);
    HRESULT put_columnRuleWidth(VARIANT v);
    HRESULT get_columnRuleWidth(VARIANT* p);
    HRESULT put_breakBefore(BSTR v);
    HRESULT get_breakBefore(BSTR* p);
    HRESULT put_breakAfter(BSTR v);
    HRESULT get_breakAfter(BSTR* p);
    HRESULT put_breakInside(BSTR v);
    HRESULT get_breakInside(BSTR* p);
    HRESULT put_floodColor(VARIANT v);
    HRESULT get_floodColor(VARIANT* p);
    HRESULT put_floodOpacity(VARIANT v);
    HRESULT get_floodOpacity(VARIANT* p);
    HRESULT put_lightingColor(VARIANT v);
    HRESULT get_lightingColor(VARIANT* p);
    HRESULT put_msScrollLimitXMin(VARIANT v);
    HRESULT get_msScrollLimitXMin(VARIANT* p);
    HRESULT put_msScrollLimitYMin(VARIANT v);
    HRESULT get_msScrollLimitYMin(VARIANT* p);
    HRESULT put_msScrollLimitXMax(VARIANT v);
    HRESULT get_msScrollLimitXMax(VARIANT* p);
    HRESULT put_msScrollLimitYMax(VARIANT v);
    HRESULT get_msScrollLimitYMax(VARIANT* p);
    HRESULT put_msScrollLimit(BSTR v);
    HRESULT get_msScrollLimit(BSTR* p);
    HRESULT put_textShadow(BSTR v);
    HRESULT get_textShadow(BSTR* p);
    HRESULT put_msFlowFrom(BSTR v);
    HRESULT get_msFlowFrom(BSTR* p);
    HRESULT put_msFlowInto(BSTR v);
    HRESULT get_msFlowInto(BSTR* p);
    HRESULT put_msHyphens(BSTR v);
    HRESULT get_msHyphens(BSTR* p);
    HRESULT put_msHyphenateLimitZone(VARIANT v);
    HRESULT get_msHyphenateLimitZone(VARIANT* p);
    HRESULT put_msHyphenateLimitChars(BSTR v);
    HRESULT get_msHyphenateLimitChars(BSTR* p);
    HRESULT put_msHyphenateLimitLines(VARIANT v);
    HRESULT get_msHyphenateLimitLines(VARIANT* p);
    HRESULT put_msHighContrastAdjust(BSTR v);
    HRESULT get_msHighContrastAdjust(BSTR* p);
    HRESULT put_enableBackground(BSTR v);
    HRESULT get_enableBackground(BSTR* p);
    HRESULT put_msFontFeatureSettings(BSTR v);
    HRESULT get_msFontFeatureSettings(BSTR* p);
    HRESULT put_msUserSelect(BSTR v);
    HRESULT get_msUserSelect(BSTR* p);
    HRESULT put_msOverflowStyle(BSTR v);
    HRESULT get_msOverflowStyle(BSTR* p);
    HRESULT put_msTransformStyle(BSTR v);
    HRESULT get_msTransformStyle(BSTR* p);
    HRESULT put_msBackfaceVisibility(BSTR v);
    HRESULT get_msBackfaceVisibility(BSTR* p);
    HRESULT put_msPerspective(VARIANT v);
    HRESULT get_msPerspective(VARIANT* p);
    HRESULT put_msPerspectiveOrigin(BSTR v);
    HRESULT get_msPerspectiveOrigin(BSTR* p);
    HRESULT put_msTransitionProperty(BSTR v);
    HRESULT get_msTransitionProperty(BSTR* p);
    HRESULT put_msTransitionDuration(BSTR v);
    HRESULT get_msTransitionDuration(BSTR* p);
    HRESULT put_msTransitionTimingFunction(BSTR v);
    HRESULT get_msTransitionTimingFunction(BSTR* p);
    HRESULT put_msTransitionDelay(BSTR v);
    HRESULT get_msTransitionDelay(BSTR* p);
    HRESULT put_msTransition(BSTR v);
    HRESULT get_msTransition(BSTR* p);
    HRESULT put_msTouchAction(BSTR v);
    HRESULT get_msTouchAction(BSTR* p);
    HRESULT put_msScrollTranslation(BSTR v);
    HRESULT get_msScrollTranslation(BSTR* p);
    HRESULT put_msFlex(BSTR v);
    HRESULT get_msFlex(BSTR* p);
    HRESULT put_msFlexPositive(VARIANT v);
    HRESULT get_msFlexPositive(VARIANT* p);
    HRESULT put_msFlexNegative(VARIANT v);
    HRESULT get_msFlexNegative(VARIANT* p);
    HRESULT put_msFlexPreferredSize(VARIANT v);
    HRESULT get_msFlexPreferredSize(VARIANT* p);
    HRESULT put_msFlexFlow(BSTR v);
    HRESULT get_msFlexFlow(BSTR* p);
    HRESULT put_msFlexDirection(BSTR v);
    HRESULT get_msFlexDirection(BSTR* p);
    HRESULT put_msFlexWrap(BSTR v);
    HRESULT get_msFlexWrap(BSTR* p);
    HRESULT put_msFlexAlign(BSTR v);
    HRESULT get_msFlexAlign(BSTR* p);
    HRESULT put_msFlexItemAlign(BSTR v);
    HRESULT get_msFlexItemAlign(BSTR* p);
    HRESULT put_msFlexPack(BSTR v);
    HRESULT get_msFlexPack(BSTR* p);
    HRESULT put_msFlexLinePack(BSTR v);
    HRESULT get_msFlexLinePack(BSTR* p);
    HRESULT put_msFlexOrder(VARIANT v);
    HRESULT get_msFlexOrder(VARIANT* p);
    HRESULT put_msTouchSelect(BSTR v);
    HRESULT get_msTouchSelect(BSTR* p);
    HRESULT put_transform(BSTR v);
    HRESULT get_transform(BSTR* p);
    HRESULT put_transformOrigin(BSTR v);
    HRESULT get_transformOrigin(BSTR* p);
    HRESULT put_transformStyle(BSTR v);
    HRESULT get_transformStyle(BSTR* p);
    HRESULT put_backfaceVisibility(BSTR v);
    HRESULT get_backfaceVisibility(BSTR* p);
    HRESULT put_perspective(VARIANT v);
    HRESULT get_perspective(VARIANT* p);
    HRESULT put_perspectiveOrigin(BSTR v);
    HRESULT get_perspectiveOrigin(BSTR* p);
    HRESULT put_transitionProperty(BSTR v);
    HRESULT get_transitionProperty(BSTR* p);
    HRESULT put_transitionDuration(BSTR v);
    HRESULT get_transitionDuration(BSTR* p);
    HRESULT put_transitionTimingFunction(BSTR v);
    HRESULT get_transitionTimingFunction(BSTR* p);
    HRESULT put_transitionDelay(BSTR v);
    HRESULT get_transitionDelay(BSTR* p);
    HRESULT put_transition(BSTR v);
    HRESULT get_transition(BSTR* p);
    HRESULT put_fontFeatureSettings(BSTR v);
    HRESULT get_fontFeatureSettings(BSTR* p);
    HRESULT put_animationName(BSTR v);
    HRESULT get_animationName(BSTR* p);
    HRESULT put_animationDuration(BSTR v);
    HRESULT get_animationDuration(BSTR* p);
    HRESULT put_animationTimingFunction(BSTR v);
    HRESULT get_animationTimingFunction(BSTR* p);
    HRESULT put_animationDelay(BSTR v);
    HRESULT get_animationDelay(BSTR* p);
    HRESULT put_animationDirection(BSTR v);
    HRESULT get_animationDirection(BSTR* p);
    HRESULT put_animationPlayState(BSTR v);
    HRESULT get_animationPlayState(BSTR* p);
    HRESULT put_animationIterationCount(BSTR v);
    HRESULT get_animationIterationCount(BSTR* p);
    HRESULT put_animation(BSTR v);
    HRESULT get_animation(BSTR* p);
    HRESULT put_animationFillMode(BSTR v);
    HRESULT get_animationFillMode(BSTR* p);
}

@GUID("3051085c-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLCSSStyleDeclaration3 : IDispatch
{
    HRESULT put_flex(BSTR v);
    HRESULT get_flex(BSTR* p);
    HRESULT put_flexDirection(BSTR v);
    HRESULT get_flexDirection(BSTR* p);
    HRESULT put_flexWrap(BSTR v);
    HRESULT get_flexWrap(BSTR* p);
    HRESULT put_flexFlow(BSTR v);
    HRESULT get_flexFlow(BSTR* p);
    HRESULT put_flexGrow(VARIANT v);
    HRESULT get_flexGrow(VARIANT* p);
    HRESULT put_flexShrink(VARIANT v);
    HRESULT get_flexShrink(VARIANT* p);
    HRESULT put_flexBasis(VARIANT v);
    HRESULT get_flexBasis(VARIANT* p);
    HRESULT put_justifyContent(BSTR v);
    HRESULT get_justifyContent(BSTR* p);
    HRESULT put_alignItems(BSTR v);
    HRESULT get_alignItems(BSTR* p);
    HRESULT put_alignSelf(BSTR v);
    HRESULT get_alignSelf(BSTR* p);
    HRESULT put_alignContent(BSTR v);
    HRESULT get_alignContent(BSTR* p);
    HRESULT put_borderImage(BSTR v);
    HRESULT get_borderImage(BSTR* p);
    HRESULT put_borderImageSource(BSTR v);
    HRESULT get_borderImageSource(BSTR* p);
    HRESULT put_borderImageSlice(BSTR v);
    HRESULT get_borderImageSlice(BSTR* p);
    HRESULT put_borderImageWidth(BSTR v);
    HRESULT get_borderImageWidth(BSTR* p);
    HRESULT put_borderImageOutset(BSTR v);
    HRESULT get_borderImageOutset(BSTR* p);
    HRESULT put_borderImageRepeat(BSTR v);
    HRESULT get_borderImageRepeat(BSTR* p);
    HRESULT put_msImeAlign(BSTR v);
    HRESULT get_msImeAlign(BSTR* p);
    HRESULT put_msTextCombineHorizontal(BSTR v);
    HRESULT get_msTextCombineHorizontal(BSTR* p);
    HRESULT put_touchAction(BSTR v);
    HRESULT get_touchAction(BSTR* p);
}

@GUID("d6100f3b-27c8-4132-afea-f0e4b1e00060")
interface IHTMLCSSStyleDeclaration4 : IDispatch
{
    HRESULT put_webkitAppearance(BSTR v);
    HRESULT get_webkitAppearance(BSTR* p);
    HRESULT put_webkitUserSelect(BSTR v);
    HRESULT get_webkitUserSelect(BSTR* p);
    HRESULT put_webkitBoxAlign(BSTR v);
    HRESULT get_webkitBoxAlign(BSTR* p);
    HRESULT put_webkitBoxOrdinalGroup(VARIANT v);
    HRESULT get_webkitBoxOrdinalGroup(VARIANT* p);
    HRESULT put_webkitBoxPack(BSTR v);
    HRESULT get_webkitBoxPack(BSTR* p);
    HRESULT put_webkitBoxFlex(VARIANT v);
    HRESULT get_webkitBoxFlex(VARIANT* p);
    HRESULT put_webkitBoxOrient(BSTR v);
    HRESULT get_webkitBoxOrient(BSTR* p);
    HRESULT put_webkitBoxDirection(BSTR v);
    HRESULT get_webkitBoxDirection(BSTR* p);
    HRESULT put_webkitTransform(BSTR v);
    HRESULT get_webkitTransform(BSTR* p);
    HRESULT put_webkitBackgroundSize(BSTR v);
    HRESULT get_webkitBackgroundSize(BSTR* p);
    HRESULT put_webkitBackfaceVisibility(BSTR v);
    HRESULT get_webkitBackfaceVisibility(BSTR* p);
    HRESULT put_webkitAnimation(BSTR v);
    HRESULT get_webkitAnimation(BSTR* p);
    HRESULT put_webkitTransition(BSTR v);
    HRESULT get_webkitTransition(BSTR* p);
    HRESULT put_webkitAnimationName(BSTR v);
    HRESULT get_webkitAnimationName(BSTR* p);
    HRESULT put_webkitAnimationDuration(BSTR v);
    HRESULT get_webkitAnimationDuration(BSTR* p);
    HRESULT put_webkitAnimationTimingFunction(BSTR v);
    HRESULT get_webkitAnimationTimingFunction(BSTR* p);
    HRESULT put_webkitAnimationDelay(BSTR v);
    HRESULT get_webkitAnimationDelay(BSTR* p);
    HRESULT put_webkitAnimationIterationCount(BSTR v);
    HRESULT get_webkitAnimationIterationCount(BSTR* p);
    HRESULT put_webkitAnimationDirection(BSTR v);
    HRESULT get_webkitAnimationDirection(BSTR* p);
    HRESULT put_webkitAnimationPlayState(BSTR v);
    HRESULT get_webkitAnimationPlayState(BSTR* p);
    HRESULT put_webkitTransitionProperty(BSTR v);
    HRESULT get_webkitTransitionProperty(BSTR* p);
    HRESULT put_webkitTransitionDuration(BSTR v);
    HRESULT get_webkitTransitionDuration(BSTR* p);
    HRESULT put_webkitTransitionTimingFunction(BSTR v);
    HRESULT get_webkitTransitionTimingFunction(BSTR* p);
    HRESULT put_webkitTransitionDelay(BSTR v);
    HRESULT get_webkitTransitionDelay(BSTR* p);
    HRESULT put_webkitBackgroundAttachment(BSTR v);
    HRESULT get_webkitBackgroundAttachment(BSTR* p);
    HRESULT put_webkitBackgroundColor(VARIANT v);
    HRESULT get_webkitBackgroundColor(VARIANT* p);
    HRESULT put_webkitBackgroundClip(BSTR v);
    HRESULT get_webkitBackgroundClip(BSTR* p);
    HRESULT put_webkitBackgroundImage(BSTR v);
    HRESULT get_webkitBackgroundImage(BSTR* p);
    HRESULT put_webkitBackgroundRepeat(BSTR v);
    HRESULT get_webkitBackgroundRepeat(BSTR* p);
    HRESULT put_webkitBackgroundOrigin(BSTR v);
    HRESULT get_webkitBackgroundOrigin(BSTR* p);
    HRESULT put_webkitBackgroundPosition(BSTR v);
    HRESULT get_webkitBackgroundPosition(BSTR* p);
    HRESULT put_webkitBackgroundPositionX(VARIANT v);
    HRESULT get_webkitBackgroundPositionX(VARIANT* p);
    HRESULT put_webkitBackgroundPositionY(VARIANT v);
    HRESULT get_webkitBackgroundPositionY(VARIANT* p);
    HRESULT put_webkitBackground(BSTR v);
    HRESULT get_webkitBackground(BSTR* p);
    HRESULT put_webkitTransformOrigin(BSTR v);
    HRESULT get_webkitTransformOrigin(BSTR* p);
    HRESULT put_msTextSizeAdjust(VARIANT v);
    HRESULT get_msTextSizeAdjust(VARIANT* p);
    HRESULT put_webkitTextSizeAdjust(VARIANT v);
    HRESULT get_webkitTextSizeAdjust(VARIANT* p);
    HRESULT put_webkitBorderImage(BSTR v);
    HRESULT get_webkitBorderImage(BSTR* p);
    HRESULT put_webkitBorderImageSource(BSTR v);
    HRESULT get_webkitBorderImageSource(BSTR* p);
    HRESULT put_webkitBorderImageSlice(BSTR v);
    HRESULT get_webkitBorderImageSlice(BSTR* p);
    HRESULT put_webkitBorderImageWidth(BSTR v);
    HRESULT get_webkitBorderImageWidth(BSTR* p);
    HRESULT put_webkitBorderImageOutset(BSTR v);
    HRESULT get_webkitBorderImageOutset(BSTR* p);
    HRESULT put_webkitBorderImageRepeat(BSTR v);
    HRESULT get_webkitBorderImageRepeat(BSTR* p);
    HRESULT put_webkitBoxSizing(BSTR v);
    HRESULT get_webkitBoxSizing(BSTR* p);
    HRESULT put_webkitAnimationFillMode(BSTR v);
    HRESULT get_webkitAnimationFillMode(BSTR* p);
}

@GUID("305104c2-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStyleEnabled : IDispatch
{
    HRESULT msGetPropertyEnabled(BSTR name, VARIANT_BOOL* p);
    HRESULT msPutPropertyEnabled(BSTR name, VARIANT_BOOL b);
}

@GUID("3059009a-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLCSSStyleDeclaration : IDispatch
{
}

@GUID("3050f25e-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStyle : IDispatch
{
    HRESULT put_fontFamily(BSTR v);
    HRESULT get_fontFamily(BSTR* p);
    HRESULT put_fontStyle(BSTR v);
    HRESULT get_fontStyle(BSTR* p);
    HRESULT put_fontVariant(BSTR v);
    HRESULT get_fontVariant(BSTR* p);
    HRESULT put_fontWeight(BSTR v);
    HRESULT get_fontWeight(BSTR* p);
    HRESULT put_fontSize(VARIANT v);
    HRESULT get_fontSize(VARIANT* p);
    HRESULT put_font(BSTR v);
    HRESULT get_font(BSTR* p);
    HRESULT put_color(VARIANT v);
    HRESULT get_color(VARIANT* p);
    HRESULT put_background(BSTR v);
    HRESULT get_background(BSTR* p);
    HRESULT put_backgroundColor(VARIANT v);
    HRESULT get_backgroundColor(VARIANT* p);
    HRESULT put_backgroundImage(BSTR v);
    HRESULT get_backgroundImage(BSTR* p);
    HRESULT put_backgroundRepeat(BSTR v);
    HRESULT get_backgroundRepeat(BSTR* p);
    HRESULT put_backgroundAttachment(BSTR v);
    HRESULT get_backgroundAttachment(BSTR* p);
    HRESULT put_backgroundPosition(BSTR v);
    HRESULT get_backgroundPosition(BSTR* p);
    HRESULT put_backgroundPositionX(VARIANT v);
    HRESULT get_backgroundPositionX(VARIANT* p);
    HRESULT put_backgroundPositionY(VARIANT v);
    HRESULT get_backgroundPositionY(VARIANT* p);
    HRESULT put_wordSpacing(VARIANT v);
    HRESULT get_wordSpacing(VARIANT* p);
    HRESULT put_letterSpacing(VARIANT v);
    HRESULT get_letterSpacing(VARIANT* p);
    HRESULT put_textDecoration(BSTR v);
    HRESULT get_textDecoration(BSTR* p);
    HRESULT put_textDecorationNone(VARIANT_BOOL v);
    HRESULT get_textDecorationNone(VARIANT_BOOL* p);
    HRESULT put_textDecorationUnderline(VARIANT_BOOL v);
    HRESULT get_textDecorationUnderline(VARIANT_BOOL* p);
    HRESULT put_textDecorationOverline(VARIANT_BOOL v);
    HRESULT get_textDecorationOverline(VARIANT_BOOL* p);
    HRESULT put_textDecorationLineThrough(VARIANT_BOOL v);
    HRESULT get_textDecorationLineThrough(VARIANT_BOOL* p);
    HRESULT put_textDecorationBlink(VARIANT_BOOL v);
    HRESULT get_textDecorationBlink(VARIANT_BOOL* p);
    HRESULT put_verticalAlign(VARIANT v);
    HRESULT get_verticalAlign(VARIANT* p);
    HRESULT put_textTransform(BSTR v);
    HRESULT get_textTransform(BSTR* p);
    HRESULT put_textAlign(BSTR v);
    HRESULT get_textAlign(BSTR* p);
    HRESULT put_textIndent(VARIANT v);
    HRESULT get_textIndent(VARIANT* p);
    HRESULT put_lineHeight(VARIANT v);
    HRESULT get_lineHeight(VARIANT* p);
    HRESULT put_marginTop(VARIANT v);
    HRESULT get_marginTop(VARIANT* p);
    HRESULT put_marginRight(VARIANT v);
    HRESULT get_marginRight(VARIANT* p);
    HRESULT put_marginBottom(VARIANT v);
    HRESULT get_marginBottom(VARIANT* p);
    HRESULT put_marginLeft(VARIANT v);
    HRESULT get_marginLeft(VARIANT* p);
    HRESULT put_margin(BSTR v);
    HRESULT get_margin(BSTR* p);
    HRESULT put_paddingTop(VARIANT v);
    HRESULT get_paddingTop(VARIANT* p);
    HRESULT put_paddingRight(VARIANT v);
    HRESULT get_paddingRight(VARIANT* p);
    HRESULT put_paddingBottom(VARIANT v);
    HRESULT get_paddingBottom(VARIANT* p);
    HRESULT put_paddingLeft(VARIANT v);
    HRESULT get_paddingLeft(VARIANT* p);
    HRESULT put_padding(BSTR v);
    HRESULT get_padding(BSTR* p);
    HRESULT put_border(BSTR v);
    HRESULT get_border(BSTR* p);
    HRESULT put_borderTop(BSTR v);
    HRESULT get_borderTop(BSTR* p);
    HRESULT put_borderRight(BSTR v);
    HRESULT get_borderRight(BSTR* p);
    HRESULT put_borderBottom(BSTR v);
    HRESULT get_borderBottom(BSTR* p);
    HRESULT put_borderLeft(BSTR v);
    HRESULT get_borderLeft(BSTR* p);
    HRESULT put_borderColor(BSTR v);
    HRESULT get_borderColor(BSTR* p);
    HRESULT put_borderTopColor(VARIANT v);
    HRESULT get_borderTopColor(VARIANT* p);
    HRESULT put_borderRightColor(VARIANT v);
    HRESULT get_borderRightColor(VARIANT* p);
    HRESULT put_borderBottomColor(VARIANT v);
    HRESULT get_borderBottomColor(VARIANT* p);
    HRESULT put_borderLeftColor(VARIANT v);
    HRESULT get_borderLeftColor(VARIANT* p);
    HRESULT put_borderWidth(BSTR v);
    HRESULT get_borderWidth(BSTR* p);
    HRESULT put_borderTopWidth(VARIANT v);
    HRESULT get_borderTopWidth(VARIANT* p);
    HRESULT put_borderRightWidth(VARIANT v);
    HRESULT get_borderRightWidth(VARIANT* p);
    HRESULT put_borderBottomWidth(VARIANT v);
    HRESULT get_borderBottomWidth(VARIANT* p);
    HRESULT put_borderLeftWidth(VARIANT v);
    HRESULT get_borderLeftWidth(VARIANT* p);
    HRESULT put_borderStyle(BSTR v);
    HRESULT get_borderStyle(BSTR* p);
    HRESULT put_borderTopStyle(BSTR v);
    HRESULT get_borderTopStyle(BSTR* p);
    HRESULT put_borderRightStyle(BSTR v);
    HRESULT get_borderRightStyle(BSTR* p);
    HRESULT put_borderBottomStyle(BSTR v);
    HRESULT get_borderBottomStyle(BSTR* p);
    HRESULT put_borderLeftStyle(BSTR v);
    HRESULT get_borderLeftStyle(BSTR* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
    HRESULT put_styleFloat(BSTR v);
    HRESULT get_styleFloat(BSTR* p);
    HRESULT put_clear(BSTR v);
    HRESULT get_clear(BSTR* p);
    HRESULT put_display(BSTR v);
    HRESULT get_display(BSTR* p);
    HRESULT put_visibility(BSTR v);
    HRESULT get_visibility(BSTR* p);
    HRESULT put_listStyleType(BSTR v);
    HRESULT get_listStyleType(BSTR* p);
    HRESULT put_listStylePosition(BSTR v);
    HRESULT get_listStylePosition(BSTR* p);
    HRESULT put_listStyleImage(BSTR v);
    HRESULT get_listStyleImage(BSTR* p);
    HRESULT put_listStyle(BSTR v);
    HRESULT get_listStyle(BSTR* p);
    HRESULT put_whiteSpace(BSTR v);
    HRESULT get_whiteSpace(BSTR* p);
    HRESULT put_top(VARIANT v);
    HRESULT get_top(VARIANT* p);
    HRESULT put_left(VARIANT v);
    HRESULT get_left(VARIANT* p);
    HRESULT get_position(BSTR* p);
    HRESULT put_zIndex(VARIANT v);
    HRESULT get_zIndex(VARIANT* p);
    HRESULT put_overflow(BSTR v);
    HRESULT get_overflow(BSTR* p);
    HRESULT put_pageBreakBefore(BSTR v);
    HRESULT get_pageBreakBefore(BSTR* p);
    HRESULT put_pageBreakAfter(BSTR v);
    HRESULT get_pageBreakAfter(BSTR* p);
    HRESULT put_cssText(BSTR v);
    HRESULT get_cssText(BSTR* p);
    HRESULT put_pixelTop(int v);
    HRESULT get_pixelTop(int* p);
    HRESULT put_pixelLeft(int v);
    HRESULT get_pixelLeft(int* p);
    HRESULT put_pixelWidth(int v);
    HRESULT get_pixelWidth(int* p);
    HRESULT put_pixelHeight(int v);
    HRESULT get_pixelHeight(int* p);
    HRESULT put_posTop(float v);
    HRESULT get_posTop(float* p);
    HRESULT put_posLeft(float v);
    HRESULT get_posLeft(float* p);
    HRESULT put_posWidth(float v);
    HRESULT get_posWidth(float* p);
    HRESULT put_posHeight(float v);
    HRESULT get_posHeight(float* p);
    HRESULT put_cursor(BSTR v);
    HRESULT get_cursor(BSTR* p);
    HRESULT put_clip(BSTR v);
    HRESULT get_clip(BSTR* p);
    HRESULT put_filter(BSTR v);
    HRESULT get_filter(BSTR* p);
    HRESULT setAttribute(BSTR strAttributeName, VARIANT AttributeValue, int lFlags);
    HRESULT getAttribute(BSTR strAttributeName, int lFlags, VARIANT* AttributeValue);
    HRESULT removeAttribute(BSTR strAttributeName, int lFlags, VARIANT_BOOL* pfSuccess);
    HRESULT toString(BSTR* String);
}

@GUID("3050f4a2-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStyle2 : IDispatch
{
    HRESULT put_tableLayout(BSTR v);
    HRESULT get_tableLayout(BSTR* p);
    HRESULT put_borderCollapse(BSTR v);
    HRESULT get_borderCollapse(BSTR* p);
    HRESULT put_direction(BSTR v);
    HRESULT get_direction(BSTR* p);
    HRESULT put_behavior(BSTR v);
    HRESULT get_behavior(BSTR* p);
    HRESULT setExpression(BSTR propname, BSTR expression, BSTR language);
    HRESULT getExpression(BSTR propname, VARIANT* expression);
    HRESULT removeExpression(BSTR propname, VARIANT_BOOL* pfSuccess);
    HRESULT put_position(BSTR v);
    HRESULT get_position(BSTR* p);
    HRESULT put_unicodeBidi(BSTR v);
    HRESULT get_unicodeBidi(BSTR* p);
    HRESULT put_bottom(VARIANT v);
    HRESULT get_bottom(VARIANT* p);
    HRESULT put_right(VARIANT v);
    HRESULT get_right(VARIANT* p);
    HRESULT put_pixelBottom(int v);
    HRESULT get_pixelBottom(int* p);
    HRESULT put_pixelRight(int v);
    HRESULT get_pixelRight(int* p);
    HRESULT put_posBottom(float v);
    HRESULT get_posBottom(float* p);
    HRESULT put_posRight(float v);
    HRESULT get_posRight(float* p);
    HRESULT put_imeMode(BSTR v);
    HRESULT get_imeMode(BSTR* p);
    HRESULT put_rubyAlign(BSTR v);
    HRESULT get_rubyAlign(BSTR* p);
    HRESULT put_rubyPosition(BSTR v);
    HRESULT get_rubyPosition(BSTR* p);
    HRESULT put_rubyOverhang(BSTR v);
    HRESULT get_rubyOverhang(BSTR* p);
    HRESULT put_layoutGridChar(VARIANT v);
    HRESULT get_layoutGridChar(VARIANT* p);
    HRESULT put_layoutGridLine(VARIANT v);
    HRESULT get_layoutGridLine(VARIANT* p);
    HRESULT put_layoutGridMode(BSTR v);
    HRESULT get_layoutGridMode(BSTR* p);
    HRESULT put_layoutGridType(BSTR v);
    HRESULT get_layoutGridType(BSTR* p);
    HRESULT put_layoutGrid(BSTR v);
    HRESULT get_layoutGrid(BSTR* p);
    HRESULT put_wordBreak(BSTR v);
    HRESULT get_wordBreak(BSTR* p);
    HRESULT put_lineBreak(BSTR v);
    HRESULT get_lineBreak(BSTR* p);
    HRESULT put_textJustify(BSTR v);
    HRESULT get_textJustify(BSTR* p);
    HRESULT put_textJustifyTrim(BSTR v);
    HRESULT get_textJustifyTrim(BSTR* p);
    HRESULT put_textKashida(VARIANT v);
    HRESULT get_textKashida(VARIANT* p);
    HRESULT put_textAutospace(BSTR v);
    HRESULT get_textAutospace(BSTR* p);
    HRESULT put_overflowX(BSTR v);
    HRESULT get_overflowX(BSTR* p);
    HRESULT put_overflowY(BSTR v);
    HRESULT get_overflowY(BSTR* p);
    HRESULT put_accelerator(BSTR v);
    HRESULT get_accelerator(BSTR* p);
}

@GUID("3050f656-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStyle3 : IDispatch
{
    HRESULT put_layoutFlow(BSTR v);
    HRESULT get_layoutFlow(BSTR* p);
    HRESULT put_zoom(VARIANT v);
    HRESULT get_zoom(VARIANT* p);
    HRESULT put_wordWrap(BSTR v);
    HRESULT get_wordWrap(BSTR* p);
    HRESULT put_textUnderlinePosition(BSTR v);
    HRESULT get_textUnderlinePosition(BSTR* p);
    HRESULT put_scrollbarBaseColor(VARIANT v);
    HRESULT get_scrollbarBaseColor(VARIANT* p);
    HRESULT put_scrollbarFaceColor(VARIANT v);
    HRESULT get_scrollbarFaceColor(VARIANT* p);
    HRESULT put_scrollbar3dLightColor(VARIANT v);
    HRESULT get_scrollbar3dLightColor(VARIANT* p);
    HRESULT put_scrollbarShadowColor(VARIANT v);
    HRESULT get_scrollbarShadowColor(VARIANT* p);
    HRESULT put_scrollbarHighlightColor(VARIANT v);
    HRESULT get_scrollbarHighlightColor(VARIANT* p);
    HRESULT put_scrollbarDarkShadowColor(VARIANT v);
    HRESULT get_scrollbarDarkShadowColor(VARIANT* p);
    HRESULT put_scrollbarArrowColor(VARIANT v);
    HRESULT get_scrollbarArrowColor(VARIANT* p);
    HRESULT put_scrollbarTrackColor(VARIANT v);
    HRESULT get_scrollbarTrackColor(VARIANT* p);
    HRESULT put_writingMode(BSTR v);
    HRESULT get_writingMode(BSTR* p);
    HRESULT put_textAlignLast(BSTR v);
    HRESULT get_textAlignLast(BSTR* p);
    HRESULT put_textKashidaSpace(VARIANT v);
    HRESULT get_textKashidaSpace(VARIANT* p);
}

@GUID("3050f816-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStyle4 : IDispatch
{
    HRESULT put_textOverflow(BSTR v);
    HRESULT get_textOverflow(BSTR* p);
    HRESULT put_minHeight(VARIANT v);
    HRESULT get_minHeight(VARIANT* p);
}

@GUID("3050f33a-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStyle5 : IDispatch
{
    HRESULT put_msInterpolationMode(BSTR v);
    HRESULT get_msInterpolationMode(BSTR* p);
    HRESULT put_maxHeight(VARIANT v);
    HRESULT get_maxHeight(VARIANT* p);
    HRESULT put_minWidth(VARIANT v);
    HRESULT get_minWidth(VARIANT* p);
    HRESULT put_maxWidth(VARIANT v);
    HRESULT get_maxWidth(VARIANT* p);
}

@GUID("30510480-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStyle6 : IDispatch
{
    HRESULT put_content(BSTR v);
    HRESULT get_content(BSTR* p);
    HRESULT put_captionSide(BSTR v);
    HRESULT get_captionSide(BSTR* p);
    HRESULT put_counterIncrement(BSTR v);
    HRESULT get_counterIncrement(BSTR* p);
    HRESULT put_counterReset(BSTR v);
    HRESULT get_counterReset(BSTR* p);
    HRESULT put_outline(BSTR v);
    HRESULT get_outline(BSTR* p);
    HRESULT put_outlineWidth(VARIANT v);
    HRESULT get_outlineWidth(VARIANT* p);
    HRESULT put_outlineStyle(BSTR v);
    HRESULT get_outlineStyle(BSTR* p);
    HRESULT put_outlineColor(VARIANT v);
    HRESULT get_outlineColor(VARIANT* p);
    HRESULT put_boxSizing(BSTR v);
    HRESULT get_boxSizing(BSTR* p);
    HRESULT put_borderSpacing(BSTR v);
    HRESULT get_borderSpacing(BSTR* p);
    HRESULT put_orphans(VARIANT v);
    HRESULT get_orphans(VARIANT* p);
    HRESULT put_widows(VARIANT v);
    HRESULT get_widows(VARIANT* p);
    HRESULT put_pageBreakInside(BSTR v);
    HRESULT get_pageBreakInside(BSTR* p);
    HRESULT put_emptyCells(BSTR v);
    HRESULT get_emptyCells(BSTR* p);
    HRESULT put_msBlockProgression(BSTR v);
    HRESULT get_msBlockProgression(BSTR* p);
    HRESULT put_quotes(BSTR v);
    HRESULT get_quotes(BSTR* p);
}

@GUID("3050f3cf-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLRuleStyle : IDispatch
{
    HRESULT put_fontFamily(BSTR v);
    HRESULT get_fontFamily(BSTR* p);
    HRESULT put_fontStyle(BSTR v);
    HRESULT get_fontStyle(BSTR* p);
    HRESULT put_fontVariant(BSTR v);
    HRESULT get_fontVariant(BSTR* p);
    HRESULT put_fontWeight(BSTR v);
    HRESULT get_fontWeight(BSTR* p);
    HRESULT put_fontSize(VARIANT v);
    HRESULT get_fontSize(VARIANT* p);
    HRESULT put_font(BSTR v);
    HRESULT get_font(BSTR* p);
    HRESULT put_color(VARIANT v);
    HRESULT get_color(VARIANT* p);
    HRESULT put_background(BSTR v);
    HRESULT get_background(BSTR* p);
    HRESULT put_backgroundColor(VARIANT v);
    HRESULT get_backgroundColor(VARIANT* p);
    HRESULT put_backgroundImage(BSTR v);
    HRESULT get_backgroundImage(BSTR* p);
    HRESULT put_backgroundRepeat(BSTR v);
    HRESULT get_backgroundRepeat(BSTR* p);
    HRESULT put_backgroundAttachment(BSTR v);
    HRESULT get_backgroundAttachment(BSTR* p);
    HRESULT put_backgroundPosition(BSTR v);
    HRESULT get_backgroundPosition(BSTR* p);
    HRESULT put_backgroundPositionX(VARIANT v);
    HRESULT get_backgroundPositionX(VARIANT* p);
    HRESULT put_backgroundPositionY(VARIANT v);
    HRESULT get_backgroundPositionY(VARIANT* p);
    HRESULT put_wordSpacing(VARIANT v);
    HRESULT get_wordSpacing(VARIANT* p);
    HRESULT put_letterSpacing(VARIANT v);
    HRESULT get_letterSpacing(VARIANT* p);
    HRESULT put_textDecoration(BSTR v);
    HRESULT get_textDecoration(BSTR* p);
    HRESULT put_textDecorationNone(VARIANT_BOOL v);
    HRESULT get_textDecorationNone(VARIANT_BOOL* p);
    HRESULT put_textDecorationUnderline(VARIANT_BOOL v);
    HRESULT get_textDecorationUnderline(VARIANT_BOOL* p);
    HRESULT put_textDecorationOverline(VARIANT_BOOL v);
    HRESULT get_textDecorationOverline(VARIANT_BOOL* p);
    HRESULT put_textDecorationLineThrough(VARIANT_BOOL v);
    HRESULT get_textDecorationLineThrough(VARIANT_BOOL* p);
    HRESULT put_textDecorationBlink(VARIANT_BOOL v);
    HRESULT get_textDecorationBlink(VARIANT_BOOL* p);
    HRESULT put_verticalAlign(VARIANT v);
    HRESULT get_verticalAlign(VARIANT* p);
    HRESULT put_textTransform(BSTR v);
    HRESULT get_textTransform(BSTR* p);
    HRESULT put_textAlign(BSTR v);
    HRESULT get_textAlign(BSTR* p);
    HRESULT put_textIndent(VARIANT v);
    HRESULT get_textIndent(VARIANT* p);
    HRESULT put_lineHeight(VARIANT v);
    HRESULT get_lineHeight(VARIANT* p);
    HRESULT put_marginTop(VARIANT v);
    HRESULT get_marginTop(VARIANT* p);
    HRESULT put_marginRight(VARIANT v);
    HRESULT get_marginRight(VARIANT* p);
    HRESULT put_marginBottom(VARIANT v);
    HRESULT get_marginBottom(VARIANT* p);
    HRESULT put_marginLeft(VARIANT v);
    HRESULT get_marginLeft(VARIANT* p);
    HRESULT put_margin(BSTR v);
    HRESULT get_margin(BSTR* p);
    HRESULT put_paddingTop(VARIANT v);
    HRESULT get_paddingTop(VARIANT* p);
    HRESULT put_paddingRight(VARIANT v);
    HRESULT get_paddingRight(VARIANT* p);
    HRESULT put_paddingBottom(VARIANT v);
    HRESULT get_paddingBottom(VARIANT* p);
    HRESULT put_paddingLeft(VARIANT v);
    HRESULT get_paddingLeft(VARIANT* p);
    HRESULT put_padding(BSTR v);
    HRESULT get_padding(BSTR* p);
    HRESULT put_border(BSTR v);
    HRESULT get_border(BSTR* p);
    HRESULT put_borderTop(BSTR v);
    HRESULT get_borderTop(BSTR* p);
    HRESULT put_borderRight(BSTR v);
    HRESULT get_borderRight(BSTR* p);
    HRESULT put_borderBottom(BSTR v);
    HRESULT get_borderBottom(BSTR* p);
    HRESULT put_borderLeft(BSTR v);
    HRESULT get_borderLeft(BSTR* p);
    HRESULT put_borderColor(BSTR v);
    HRESULT get_borderColor(BSTR* p);
    HRESULT put_borderTopColor(VARIANT v);
    HRESULT get_borderTopColor(VARIANT* p);
    HRESULT put_borderRightColor(VARIANT v);
    HRESULT get_borderRightColor(VARIANT* p);
    HRESULT put_borderBottomColor(VARIANT v);
    HRESULT get_borderBottomColor(VARIANT* p);
    HRESULT put_borderLeftColor(VARIANT v);
    HRESULT get_borderLeftColor(VARIANT* p);
    HRESULT put_borderWidth(BSTR v);
    HRESULT get_borderWidth(BSTR* p);
    HRESULT put_borderTopWidth(VARIANT v);
    HRESULT get_borderTopWidth(VARIANT* p);
    HRESULT put_borderRightWidth(VARIANT v);
    HRESULT get_borderRightWidth(VARIANT* p);
    HRESULT put_borderBottomWidth(VARIANT v);
    HRESULT get_borderBottomWidth(VARIANT* p);
    HRESULT put_borderLeftWidth(VARIANT v);
    HRESULT get_borderLeftWidth(VARIANT* p);
    HRESULT put_borderStyle(BSTR v);
    HRESULT get_borderStyle(BSTR* p);
    HRESULT put_borderTopStyle(BSTR v);
    HRESULT get_borderTopStyle(BSTR* p);
    HRESULT put_borderRightStyle(BSTR v);
    HRESULT get_borderRightStyle(BSTR* p);
    HRESULT put_borderBottomStyle(BSTR v);
    HRESULT get_borderBottomStyle(BSTR* p);
    HRESULT put_borderLeftStyle(BSTR v);
    HRESULT get_borderLeftStyle(BSTR* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
    HRESULT put_styleFloat(BSTR v);
    HRESULT get_styleFloat(BSTR* p);
    HRESULT put_clear(BSTR v);
    HRESULT get_clear(BSTR* p);
    HRESULT put_display(BSTR v);
    HRESULT get_display(BSTR* p);
    HRESULT put_visibility(BSTR v);
    HRESULT get_visibility(BSTR* p);
    HRESULT put_listStyleType(BSTR v);
    HRESULT get_listStyleType(BSTR* p);
    HRESULT put_listStylePosition(BSTR v);
    HRESULT get_listStylePosition(BSTR* p);
    HRESULT put_listStyleImage(BSTR v);
    HRESULT get_listStyleImage(BSTR* p);
    HRESULT put_listStyle(BSTR v);
    HRESULT get_listStyle(BSTR* p);
    HRESULT put_whiteSpace(BSTR v);
    HRESULT get_whiteSpace(BSTR* p);
    HRESULT put_top(VARIANT v);
    HRESULT get_top(VARIANT* p);
    HRESULT put_left(VARIANT v);
    HRESULT get_left(VARIANT* p);
    HRESULT get_position(BSTR* p);
    HRESULT put_zIndex(VARIANT v);
    HRESULT get_zIndex(VARIANT* p);
    HRESULT put_overflow(BSTR v);
    HRESULT get_overflow(BSTR* p);
    HRESULT put_pageBreakBefore(BSTR v);
    HRESULT get_pageBreakBefore(BSTR* p);
    HRESULT put_pageBreakAfter(BSTR v);
    HRESULT get_pageBreakAfter(BSTR* p);
    HRESULT put_cssText(BSTR v);
    HRESULT get_cssText(BSTR* p);
    HRESULT put_cursor(BSTR v);
    HRESULT get_cursor(BSTR* p);
    HRESULT put_clip(BSTR v);
    HRESULT get_clip(BSTR* p);
    HRESULT put_filter(BSTR v);
    HRESULT get_filter(BSTR* p);
    HRESULT setAttribute(BSTR strAttributeName, VARIANT AttributeValue, int lFlags);
    HRESULT getAttribute(BSTR strAttributeName, int lFlags, VARIANT* AttributeValue);
    HRESULT removeAttribute(BSTR strAttributeName, int lFlags, VARIANT_BOOL* pfSuccess);
}

@GUID("3050f4ac-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLRuleStyle2 : IDispatch
{
    HRESULT put_tableLayout(BSTR v);
    HRESULT get_tableLayout(BSTR* p);
    HRESULT put_borderCollapse(BSTR v);
    HRESULT get_borderCollapse(BSTR* p);
    HRESULT put_direction(BSTR v);
    HRESULT get_direction(BSTR* p);
    HRESULT put_behavior(BSTR v);
    HRESULT get_behavior(BSTR* p);
    HRESULT put_position(BSTR v);
    HRESULT get_position(BSTR* p);
    HRESULT put_unicodeBidi(BSTR v);
    HRESULT get_unicodeBidi(BSTR* p);
    HRESULT put_bottom(VARIANT v);
    HRESULT get_bottom(VARIANT* p);
    HRESULT put_right(VARIANT v);
    HRESULT get_right(VARIANT* p);
    HRESULT put_pixelBottom(int v);
    HRESULT get_pixelBottom(int* p);
    HRESULT put_pixelRight(int v);
    HRESULT get_pixelRight(int* p);
    HRESULT put_posBottom(float v);
    HRESULT get_posBottom(float* p);
    HRESULT put_posRight(float v);
    HRESULT get_posRight(float* p);
    HRESULT put_imeMode(BSTR v);
    HRESULT get_imeMode(BSTR* p);
    HRESULT put_rubyAlign(BSTR v);
    HRESULT get_rubyAlign(BSTR* p);
    HRESULT put_rubyPosition(BSTR v);
    HRESULT get_rubyPosition(BSTR* p);
    HRESULT put_rubyOverhang(BSTR v);
    HRESULT get_rubyOverhang(BSTR* p);
    HRESULT put_layoutGridChar(VARIANT v);
    HRESULT get_layoutGridChar(VARIANT* p);
    HRESULT put_layoutGridLine(VARIANT v);
    HRESULT get_layoutGridLine(VARIANT* p);
    HRESULT put_layoutGridMode(BSTR v);
    HRESULT get_layoutGridMode(BSTR* p);
    HRESULT put_layoutGridType(BSTR v);
    HRESULT get_layoutGridType(BSTR* p);
    HRESULT put_layoutGrid(BSTR v);
    HRESULT get_layoutGrid(BSTR* p);
    HRESULT put_textAutospace(BSTR v);
    HRESULT get_textAutospace(BSTR* p);
    HRESULT put_wordBreak(BSTR v);
    HRESULT get_wordBreak(BSTR* p);
    HRESULT put_lineBreak(BSTR v);
    HRESULT get_lineBreak(BSTR* p);
    HRESULT put_textJustify(BSTR v);
    HRESULT get_textJustify(BSTR* p);
    HRESULT put_textJustifyTrim(BSTR v);
    HRESULT get_textJustifyTrim(BSTR* p);
    HRESULT put_textKashida(VARIANT v);
    HRESULT get_textKashida(VARIANT* p);
    HRESULT put_overflowX(BSTR v);
    HRESULT get_overflowX(BSTR* p);
    HRESULT put_overflowY(BSTR v);
    HRESULT get_overflowY(BSTR* p);
    HRESULT put_accelerator(BSTR v);
    HRESULT get_accelerator(BSTR* p);
}

@GUID("3050f657-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLRuleStyle3 : IDispatch
{
    HRESULT put_layoutFlow(BSTR v);
    HRESULT get_layoutFlow(BSTR* p);
    HRESULT put_zoom(VARIANT v);
    HRESULT get_zoom(VARIANT* p);
    HRESULT put_wordWrap(BSTR v);
    HRESULT get_wordWrap(BSTR* p);
    HRESULT put_textUnderlinePosition(BSTR v);
    HRESULT get_textUnderlinePosition(BSTR* p);
    HRESULT put_scrollbarBaseColor(VARIANT v);
    HRESULT get_scrollbarBaseColor(VARIANT* p);
    HRESULT put_scrollbarFaceColor(VARIANT v);
    HRESULT get_scrollbarFaceColor(VARIANT* p);
    HRESULT put_scrollbar3dLightColor(VARIANT v);
    HRESULT get_scrollbar3dLightColor(VARIANT* p);
    HRESULT put_scrollbarShadowColor(VARIANT v);
    HRESULT get_scrollbarShadowColor(VARIANT* p);
    HRESULT put_scrollbarHighlightColor(VARIANT v);
    HRESULT get_scrollbarHighlightColor(VARIANT* p);
    HRESULT put_scrollbarDarkShadowColor(VARIANT v);
    HRESULT get_scrollbarDarkShadowColor(VARIANT* p);
    HRESULT put_scrollbarArrowColor(VARIANT v);
    HRESULT get_scrollbarArrowColor(VARIANT* p);
    HRESULT put_scrollbarTrackColor(VARIANT v);
    HRESULT get_scrollbarTrackColor(VARIANT* p);
    HRESULT put_writingMode(BSTR v);
    HRESULT get_writingMode(BSTR* p);
    HRESULT put_textAlignLast(BSTR v);
    HRESULT get_textAlignLast(BSTR* p);
    HRESULT put_textKashidaSpace(VARIANT v);
    HRESULT get_textKashidaSpace(VARIANT* p);
}

@GUID("3050f817-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLRuleStyle4 : IDispatch
{
    HRESULT put_textOverflow(BSTR v);
    HRESULT get_textOverflow(BSTR* p);
    HRESULT put_minHeight(VARIANT v);
    HRESULT get_minHeight(VARIANT* p);
}

@GUID("3050f335-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLRuleStyle5 : IDispatch
{
    HRESULT put_msInterpolationMode(BSTR v);
    HRESULT get_msInterpolationMode(BSTR* p);
    HRESULT put_maxHeight(VARIANT v);
    HRESULT get_maxHeight(VARIANT* p);
    HRESULT put_minWidth(VARIANT v);
    HRESULT get_minWidth(VARIANT* p);
    HRESULT put_maxWidth(VARIANT v);
    HRESULT get_maxWidth(VARIANT* p);
}

@GUID("30510471-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLRuleStyle6 : IDispatch
{
    HRESULT put_content(BSTR v);
    HRESULT get_content(BSTR* p);
    HRESULT put_captionSide(BSTR v);
    HRESULT get_captionSide(BSTR* p);
    HRESULT put_counterIncrement(BSTR v);
    HRESULT get_counterIncrement(BSTR* p);
    HRESULT put_counterReset(BSTR v);
    HRESULT get_counterReset(BSTR* p);
    HRESULT put_outline(BSTR v);
    HRESULT get_outline(BSTR* p);
    HRESULT put_outlineWidth(VARIANT v);
    HRESULT get_outlineWidth(VARIANT* p);
    HRESULT put_outlineStyle(BSTR v);
    HRESULT get_outlineStyle(BSTR* p);
    HRESULT put_outlineColor(VARIANT v);
    HRESULT get_outlineColor(VARIANT* p);
    HRESULT put_boxSizing(BSTR v);
    HRESULT get_boxSizing(BSTR* p);
    HRESULT put_borderSpacing(BSTR v);
    HRESULT get_borderSpacing(BSTR* p);
    HRESULT put_orphans(VARIANT v);
    HRESULT get_orphans(VARIANT* p);
    HRESULT put_widows(VARIANT v);
    HRESULT get_widows(VARIANT* p);
    HRESULT put_pageBreakInside(BSTR v);
    HRESULT get_pageBreakInside(BSTR* p);
    HRESULT put_emptyCells(BSTR v);
    HRESULT get_emptyCells(BSTR* p);
    HRESULT put_msBlockProgression(BSTR v);
    HRESULT get_msBlockProgression(BSTR* p);
    HRESULT put_quotes(BSTR v);
    HRESULT get_quotes(BSTR* p);
}

@GUID("3050f55a-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLStyle : IDispatch
{
}

@GUID("3050f55c-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLRuleStyle : IDispatch
{
}

@GUID("3050f2e5-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStyleSheetRulesCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT item(int index, IHTMLStyleSheetRule* ppHTMLStyleSheetRule);
}

@GUID("3050f2e3-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStyleSheet : IDispatch
{
    HRESULT put_title(BSTR v);
    HRESULT get_title(BSTR* p);
    HRESULT get_parentStyleSheet(IHTMLStyleSheet* p);
    HRESULT get_owningElement(IHTMLElement* p);
    HRESULT put_disabled(VARIANT_BOOL v);
    HRESULT get_disabled(VARIANT_BOOL* p);
    HRESULT get_readOnly(VARIANT_BOOL* p);
    HRESULT get_imports(IHTMLStyleSheetsCollection* p);
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
    HRESULT get_type(BSTR* p);
    HRESULT get_id(BSTR* p);
    HRESULT addImport(BSTR bstrURL, int lIndex, int* plIndex);
    HRESULT addRule(BSTR bstrSelector, BSTR bstrStyle, int lIndex, int* plNewIndex);
    HRESULT removeImport(int lIndex);
    HRESULT removeRule(int lIndex);
    HRESULT put_media(BSTR v);
    HRESULT get_media(BSTR* p);
    HRESULT put_cssText(BSTR v);
    HRESULT get_cssText(BSTR* p);
    HRESULT get_rules(IHTMLStyleSheetRulesCollection* p);
}

@GUID("305106e9-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLCSSRule : IDispatch
{
    HRESULT get_type(ushort* p);
    HRESULT put_cssText(BSTR v);
    HRESULT get_cssText(BSTR* p);
    HRESULT get_parentRule(IHTMLCSSRule* p);
    HRESULT get_parentStyleSheet(IHTMLStyleSheet* p);
}

@GUID("305106ea-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLCSSImportRule : IDispatch
{
    HRESULT get_href(BSTR* p);
    HRESULT put_media(VARIANT v);
    HRESULT get_media(VARIANT* p);
    HRESULT get_styleSheet(IHTMLStyleSheet* p);
}

@GUID("305106eb-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLCSSMediaRule : IDispatch
{
    HRESULT put_media(VARIANT v);
    HRESULT get_media(VARIANT* p);
    HRESULT get_cssRules(IHTMLStyleSheetRulesCollection* p);
    HRESULT insertRule(BSTR bstrRule, int lIndex, int* plNewIndex);
    HRESULT deleteRule(int lIndex);
}

@GUID("30510731-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLCSSMediaList : IDispatch
{
    HRESULT put_mediaText(BSTR v);
    HRESULT get_mediaText(BSTR* p);
    HRESULT get_length(int* p);
    HRESULT item(int index, BSTR* pbstrMedium);
    HRESULT appendMedium(BSTR bstrMedium);
    HRESULT deleteMedium(BSTR bstrMedium);
}

@GUID("305106ee-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLCSSNamespaceRule : IDispatch
{
    HRESULT get_namespaceURI(BSTR* p);
    HRESULT get_prefix(BSTR* p);
}

@GUID("3051080c-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLMSCSSKeyframeRule : IDispatch
{
    HRESULT put_keyText(BSTR v);
    HRESULT get_keyText(BSTR* p);
    HRESULT get_style(IHTMLRuleStyle* p);
}

@GUID("3051080d-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLMSCSSKeyframesRule : IDispatch
{
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT get_cssRules(IHTMLStyleSheetRulesCollection* p);
    HRESULT appendRule(BSTR bstrRule);
    HRESULT deleteRule(BSTR bstrKey);
    HRESULT findRule(BSTR bstrKey, IHTMLMSCSSKeyframeRule* ppMSKeyframeRule);
}

@GUID("3059007d-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLCSSRule : IDispatch
{
}

@GUID("3059007e-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLCSSImportRule : IDispatch
{
}

@GUID("3059007f-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLCSSMediaRule : IDispatch
{
}

@GUID("30590097-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLCSSMediaList : IDispatch
{
}

@GUID("30590080-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLCSSNamespaceRule : IDispatch
{
}

@GUID("305900de-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLMSCSSKeyframeRule : IDispatch
{
}

@GUID("305900df-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLMSCSSKeyframesRule : IDispatch
{
}

@GUID("3050f6ae-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLRenderStyle : IDispatch
{
    HRESULT put_textLineThroughStyle(BSTR v);
    HRESULT get_textLineThroughStyle(BSTR* p);
    HRESULT put_textUnderlineStyle(BSTR v);
    HRESULT get_textUnderlineStyle(BSTR* p);
    HRESULT put_textEffect(BSTR v);
    HRESULT get_textEffect(BSTR* p);
    HRESULT put_textColor(VARIANT v);
    HRESULT get_textColor(VARIANT* p);
    HRESULT put_textBackgroundColor(VARIANT v);
    HRESULT get_textBackgroundColor(VARIANT* p);
    HRESULT put_textDecorationColor(VARIANT v);
    HRESULT get_textDecorationColor(VARIANT* p);
    HRESULT put_renderingPriority(int v);
    HRESULT get_renderingPriority(int* p);
    HRESULT put_defaultTextSelection(BSTR v);
    HRESULT get_defaultTextSelection(BSTR* p);
    HRESULT put_textDecoration(BSTR v);
    HRESULT get_textDecoration(BSTR* p);
}

@GUID("3050f58b-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLRenderStyle : IDispatch
{
}

@GUID("3050f3db-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLCurrentStyle : IDispatch
{
    HRESULT get_position(BSTR* p);
    HRESULT get_styleFloat(BSTR* p);
    HRESULT get_color(VARIANT* p);
    HRESULT get_backgroundColor(VARIANT* p);
    HRESULT get_fontFamily(BSTR* p);
    HRESULT get_fontStyle(BSTR* p);
    HRESULT get_fontVariant(BSTR* p);
    HRESULT get_fontWeight(VARIANT* p);
    HRESULT get_fontSize(VARIANT* p);
    HRESULT get_backgroundImage(BSTR* p);
    HRESULT get_backgroundPositionX(VARIANT* p);
    HRESULT get_backgroundPositionY(VARIANT* p);
    HRESULT get_backgroundRepeat(BSTR* p);
    HRESULT get_borderLeftColor(VARIANT* p);
    HRESULT get_borderTopColor(VARIANT* p);
    HRESULT get_borderRightColor(VARIANT* p);
    HRESULT get_borderBottomColor(VARIANT* p);
    HRESULT get_borderTopStyle(BSTR* p);
    HRESULT get_borderRightStyle(BSTR* p);
    HRESULT get_borderBottomStyle(BSTR* p);
    HRESULT get_borderLeftStyle(BSTR* p);
    HRESULT get_borderTopWidth(VARIANT* p);
    HRESULT get_borderRightWidth(VARIANT* p);
    HRESULT get_borderBottomWidth(VARIANT* p);
    HRESULT get_borderLeftWidth(VARIANT* p);
    HRESULT get_left(VARIANT* p);
    HRESULT get_top(VARIANT* p);
    HRESULT get_width(VARIANT* p);
    HRESULT get_height(VARIANT* p);
    HRESULT get_paddingLeft(VARIANT* p);
    HRESULT get_paddingTop(VARIANT* p);
    HRESULT get_paddingRight(VARIANT* p);
    HRESULT get_paddingBottom(VARIANT* p);
    HRESULT get_textAlign(BSTR* p);
    HRESULT get_textDecoration(BSTR* p);
    HRESULT get_display(BSTR* p);
    HRESULT get_visibility(BSTR* p);
    HRESULT get_zIndex(VARIANT* p);
    HRESULT get_letterSpacing(VARIANT* p);
    HRESULT get_lineHeight(VARIANT* p);
    HRESULT get_textIndent(VARIANT* p);
    HRESULT get_verticalAlign(VARIANT* p);
    HRESULT get_backgroundAttachment(BSTR* p);
    HRESULT get_marginTop(VARIANT* p);
    HRESULT get_marginRight(VARIANT* p);
    HRESULT get_marginBottom(VARIANT* p);
    HRESULT get_marginLeft(VARIANT* p);
    HRESULT get_clear(BSTR* p);
    HRESULT get_listStyleType(BSTR* p);
    HRESULT get_listStylePosition(BSTR* p);
    HRESULT get_listStyleImage(BSTR* p);
    HRESULT get_clipTop(VARIANT* p);
    HRESULT get_clipRight(VARIANT* p);
    HRESULT get_clipBottom(VARIANT* p);
    HRESULT get_clipLeft(VARIANT* p);
    HRESULT get_overflow(BSTR* p);
    HRESULT get_pageBreakBefore(BSTR* p);
    HRESULT get_pageBreakAfter(BSTR* p);
    HRESULT get_cursor(BSTR* p);
    HRESULT get_tableLayout(BSTR* p);
    HRESULT get_borderCollapse(BSTR* p);
    HRESULT get_direction(BSTR* p);
    HRESULT get_behavior(BSTR* p);
    HRESULT getAttribute(BSTR strAttributeName, int lFlags, VARIANT* AttributeValue);
    HRESULT get_unicodeBidi(BSTR* p);
    HRESULT get_right(VARIANT* p);
    HRESULT get_bottom(VARIANT* p);
    HRESULT get_imeMode(BSTR* p);
    HRESULT get_rubyAlign(BSTR* p);
    HRESULT get_rubyPosition(BSTR* p);
    HRESULT get_rubyOverhang(BSTR* p);
    HRESULT get_textAutospace(BSTR* p);
    HRESULT get_lineBreak(BSTR* p);
    HRESULT get_wordBreak(BSTR* p);
    HRESULT get_textJustify(BSTR* p);
    HRESULT get_textJustifyTrim(BSTR* p);
    HRESULT get_textKashida(VARIANT* p);
    HRESULT get_blockDirection(BSTR* p);
    HRESULT get_layoutGridChar(VARIANT* p);
    HRESULT get_layoutGridLine(VARIANT* p);
    HRESULT get_layoutGridMode(BSTR* p);
    HRESULT get_layoutGridType(BSTR* p);
    HRESULT get_borderStyle(BSTR* p);
    HRESULT get_borderColor(BSTR* p);
    HRESULT get_borderWidth(BSTR* p);
    HRESULT get_padding(BSTR* p);
    HRESULT get_margin(BSTR* p);
    HRESULT get_accelerator(BSTR* p);
    HRESULT get_overflowX(BSTR* p);
    HRESULT get_overflowY(BSTR* p);
    HRESULT get_textTransform(BSTR* p);
}

@GUID("3050f658-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLCurrentStyle2 : IDispatch
{
    HRESULT get_layoutFlow(BSTR* p);
    HRESULT get_wordWrap(BSTR* p);
    HRESULT get_textUnderlinePosition(BSTR* p);
    HRESULT get_hasLayout(VARIANT_BOOL* p);
    HRESULT get_scrollbarBaseColor(VARIANT* p);
    HRESULT get_scrollbarFaceColor(VARIANT* p);
    HRESULT get_scrollbar3dLightColor(VARIANT* p);
    HRESULT get_scrollbarShadowColor(VARIANT* p);
    HRESULT get_scrollbarHighlightColor(VARIANT* p);
    HRESULT get_scrollbarDarkShadowColor(VARIANT* p);
    HRESULT get_scrollbarArrowColor(VARIANT* p);
    HRESULT get_scrollbarTrackColor(VARIANT* p);
    HRESULT get_writingMode(BSTR* p);
    HRESULT get_zoom(VARIANT* p);
    HRESULT get_filter(BSTR* p);
    HRESULT get_textAlignLast(BSTR* p);
    HRESULT get_textKashidaSpace(VARIANT* p);
    HRESULT get_isBlock(VARIANT_BOOL* p);
}

@GUID("3050f818-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLCurrentStyle3 : IDispatch
{
    HRESULT get_textOverflow(BSTR* p);
    HRESULT get_minHeight(VARIANT* p);
    HRESULT get_wordSpacing(VARIANT* p);
    HRESULT get_whiteSpace(BSTR* p);
}

@GUID("3050f33b-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLCurrentStyle4 : IDispatch
{
    HRESULT get_msInterpolationMode(BSTR* p);
    HRESULT get_maxHeight(VARIANT* p);
    HRESULT get_minWidth(VARIANT* p);
    HRESULT get_maxWidth(VARIANT* p);
}

@GUID("30510481-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLCurrentStyle5 : IDispatch
{
    HRESULT get_captionSide(BSTR* p);
    HRESULT get_outline(BSTR* p);
    HRESULT get_outlineWidth(VARIANT* p);
    HRESULT get_outlineStyle(BSTR* p);
    HRESULT get_outlineColor(VARIANT* p);
    HRESULT get_boxSizing(BSTR* p);
    HRESULT get_borderSpacing(BSTR* p);
    HRESULT get_orphans(VARIANT* p);
    HRESULT get_widows(VARIANT* p);
    HRESULT get_pageBreakInside(BSTR* p);
    HRESULT get_emptyCells(BSTR* p);
    HRESULT get_msBlockProgression(BSTR* p);
    HRESULT get_quotes(BSTR* p);
}

@GUID("3050f557-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLCurrentStyle : IDispatch
{
}

@GUID("3050f1ff-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLElement : IDispatch
{
    HRESULT setAttribute(BSTR strAttributeName, VARIANT AttributeValue, int lFlags);
    HRESULT getAttribute(BSTR strAttributeName, int lFlags, VARIANT* AttributeValue);
    HRESULT removeAttribute(BSTR strAttributeName, int lFlags, VARIANT_BOOL* pfSuccess);
    HRESULT put_className(BSTR v);
    HRESULT get_className(BSTR* p);
    HRESULT put_id(BSTR v);
    HRESULT get_id(BSTR* p);
    HRESULT get_tagName(BSTR* p);
    HRESULT get_parentElement(IHTMLElement* p);
    HRESULT get_style(IHTMLStyle* p);
    HRESULT put_onhelp(VARIANT v);
    HRESULT get_onhelp(VARIANT* p);
    HRESULT put_onclick(VARIANT v);
    HRESULT get_onclick(VARIANT* p);
    HRESULT put_ondblclick(VARIANT v);
    HRESULT get_ondblclick(VARIANT* p);
    HRESULT put_onkeydown(VARIANT v);
    HRESULT get_onkeydown(VARIANT* p);
    HRESULT put_onkeyup(VARIANT v);
    HRESULT get_onkeyup(VARIANT* p);
    HRESULT put_onkeypress(VARIANT v);
    HRESULT get_onkeypress(VARIANT* p);
    HRESULT put_onmouseout(VARIANT v);
    HRESULT get_onmouseout(VARIANT* p);
    HRESULT put_onmouseover(VARIANT v);
    HRESULT get_onmouseover(VARIANT* p);
    HRESULT put_onmousemove(VARIANT v);
    HRESULT get_onmousemove(VARIANT* p);
    HRESULT put_onmousedown(VARIANT v);
    HRESULT get_onmousedown(VARIANT* p);
    HRESULT put_onmouseup(VARIANT v);
    HRESULT get_onmouseup(VARIANT* p);
    HRESULT get_document(IDispatch* p);
    HRESULT put_title(BSTR v);
    HRESULT get_title(BSTR* p);
    HRESULT put_language(BSTR v);
    HRESULT get_language(BSTR* p);
    HRESULT put_onselectstart(VARIANT v);
    HRESULT get_onselectstart(VARIANT* p);
    HRESULT scrollIntoView(VARIANT varargStart);
    HRESULT contains(IHTMLElement pChild, VARIANT_BOOL* pfResult);
    HRESULT get_sourceIndex(int* p);
    HRESULT get_recordNumber(VARIANT* p);
    HRESULT put_lang(BSTR v);
    HRESULT get_lang(BSTR* p);
    HRESULT get_offsetLeft(int* p);
    HRESULT get_offsetTop(int* p);
    HRESULT get_offsetWidth(int* p);
    HRESULT get_offsetHeight(int* p);
    HRESULT get_offsetParent(IHTMLElement* p);
    HRESULT put_innerHTML(BSTR v);
    HRESULT get_innerHTML(BSTR* p);
    HRESULT put_innerText(BSTR v);
    HRESULT get_innerText(BSTR* p);
    HRESULT put_outerHTML(BSTR v);
    HRESULT get_outerHTML(BSTR* p);
    HRESULT put_outerText(BSTR v);
    HRESULT get_outerText(BSTR* p);
    HRESULT insertAdjacentHTML(BSTR where, BSTR html);
    HRESULT insertAdjacentText(BSTR where, BSTR text);
    HRESULT get_parentTextEdit(IHTMLElement* p);
    HRESULT get_isTextEdit(VARIANT_BOOL* p);
    HRESULT click();
    HRESULT get_filters(IHTMLFiltersCollection* p);
    HRESULT put_ondragstart(VARIANT v);
    HRESULT get_ondragstart(VARIANT* p);
    HRESULT toString(BSTR* String);
    HRESULT put_onbeforeupdate(VARIANT v);
    HRESULT get_onbeforeupdate(VARIANT* p);
    HRESULT put_onafterupdate(VARIANT v);
    HRESULT get_onafterupdate(VARIANT* p);
    HRESULT put_onerrorupdate(VARIANT v);
    HRESULT get_onerrorupdate(VARIANT* p);
    HRESULT put_onrowexit(VARIANT v);
    HRESULT get_onrowexit(VARIANT* p);
    HRESULT put_onrowenter(VARIANT v);
    HRESULT get_onrowenter(VARIANT* p);
    HRESULT put_ondatasetchanged(VARIANT v);
    HRESULT get_ondatasetchanged(VARIANT* p);
    HRESULT put_ondataavailable(VARIANT v);
    HRESULT get_ondataavailable(VARIANT* p);
    HRESULT put_ondatasetcomplete(VARIANT v);
    HRESULT get_ondatasetcomplete(VARIANT* p);
    HRESULT put_onfilterchange(VARIANT v);
    HRESULT get_onfilterchange(VARIANT* p);
    HRESULT get_children(IDispatch* p);
    HRESULT get_all(IDispatch* p);
}

@GUID("3050f4a3-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLRect : IDispatch
{
    HRESULT put_left(int v);
    HRESULT get_left(int* p);
    HRESULT put_top(int v);
    HRESULT get_top(int* p);
    HRESULT put_right(int v);
    HRESULT get_right(int* p);
    HRESULT put_bottom(int v);
    HRESULT get_bottom(int* p);
}

@GUID("3051076c-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLRect2 : IDispatch
{
    HRESULT get_width(float* p);
    HRESULT get_height(float* p);
}

@GUID("3050f4a4-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLRectCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(VARIANT* pvarIndex, VARIANT* pvarResult);
}

@GUID("3050f21f-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLElementCollection : IDispatch
{
    HRESULT toString(BSTR* String);
    HRESULT put_length(int v);
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(VARIANT name, VARIANT index, IDispatch* pdisp);
    HRESULT tags(VARIANT tagName, IDispatch* pdisp);
}

@GUID("3050f434-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLElement2 : IDispatch
{
    HRESULT get_scopeName(BSTR* p);
    HRESULT setCapture(VARIANT_BOOL containerCapture);
    HRESULT releaseCapture();
    HRESULT put_onlosecapture(VARIANT v);
    HRESULT get_onlosecapture(VARIANT* p);
    HRESULT componentFromPoint(int x, int y, BSTR* component);
    HRESULT doScroll(VARIANT component);
    HRESULT put_onscroll(VARIANT v);
    HRESULT get_onscroll(VARIANT* p);
    HRESULT put_ondrag(VARIANT v);
    HRESULT get_ondrag(VARIANT* p);
    HRESULT put_ondragend(VARIANT v);
    HRESULT get_ondragend(VARIANT* p);
    HRESULT put_ondragenter(VARIANT v);
    HRESULT get_ondragenter(VARIANT* p);
    HRESULT put_ondragover(VARIANT v);
    HRESULT get_ondragover(VARIANT* p);
    HRESULT put_ondragleave(VARIANT v);
    HRESULT get_ondragleave(VARIANT* p);
    HRESULT put_ondrop(VARIANT v);
    HRESULT get_ondrop(VARIANT* p);
    HRESULT put_onbeforecut(VARIANT v);
    HRESULT get_onbeforecut(VARIANT* p);
    HRESULT put_oncut(VARIANT v);
    HRESULT get_oncut(VARIANT* p);
    HRESULT put_onbeforecopy(VARIANT v);
    HRESULT get_onbeforecopy(VARIANT* p);
    HRESULT put_oncopy(VARIANT v);
    HRESULT get_oncopy(VARIANT* p);
    HRESULT put_onbeforepaste(VARIANT v);
    HRESULT get_onbeforepaste(VARIANT* p);
    HRESULT put_onpaste(VARIANT v);
    HRESULT get_onpaste(VARIANT* p);
    HRESULT get_currentStyle(IHTMLCurrentStyle* p);
    HRESULT put_onpropertychange(VARIANT v);
    HRESULT get_onpropertychange(VARIANT* p);
    HRESULT getClientRects(IHTMLRectCollection* pRectCol);
    HRESULT getBoundingClientRect(IHTMLRect* pRect);
    HRESULT setExpression(BSTR propname, BSTR expression, BSTR language);
    HRESULT getExpression(BSTR propname, VARIANT* expression);
    HRESULT removeExpression(BSTR propname, VARIANT_BOOL* pfSuccess);
    HRESULT put_tabIndex(short v);
    HRESULT get_tabIndex(short* p);
    HRESULT focus();
    HRESULT put_accessKey(BSTR v);
    HRESULT get_accessKey(BSTR* p);
    HRESULT put_onblur(VARIANT v);
    HRESULT get_onblur(VARIANT* p);
    HRESULT put_onfocus(VARIANT v);
    HRESULT get_onfocus(VARIANT* p);
    HRESULT put_onresize(VARIANT v);
    HRESULT get_onresize(VARIANT* p);
    HRESULT blur();
    HRESULT addFilter(IUnknown pUnk);
    HRESULT removeFilter(IUnknown pUnk);
    HRESULT get_clientHeight(int* p);
    HRESULT get_clientWidth(int* p);
    HRESULT get_clientTop(int* p);
    HRESULT get_clientLeft(int* p);
    HRESULT attachEvent(BSTR event, IDispatch pDisp, VARIANT_BOOL* pfResult);
    HRESULT detachEvent(BSTR event, IDispatch pDisp);
    HRESULT get_readyState(VARIANT* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
    HRESULT put_onrowsdelete(VARIANT v);
    HRESULT get_onrowsdelete(VARIANT* p);
    HRESULT put_onrowsinserted(VARIANT v);
    HRESULT get_onrowsinserted(VARIANT* p);
    HRESULT put_oncellchange(VARIANT v);
    HRESULT get_oncellchange(VARIANT* p);
    HRESULT put_dir(BSTR v);
    HRESULT get_dir(BSTR* p);
    HRESULT createControlRange(IDispatch* range);
    HRESULT get_scrollHeight(int* p);
    HRESULT get_scrollWidth(int* p);
    HRESULT put_scrollTop(int v);
    HRESULT get_scrollTop(int* p);
    HRESULT put_scrollLeft(int v);
    HRESULT get_scrollLeft(int* p);
    HRESULT clearAttributes();
    HRESULT mergeAttributes(IHTMLElement mergeThis);
    HRESULT put_oncontextmenu(VARIANT v);
    HRESULT get_oncontextmenu(VARIANT* p);
    HRESULT insertAdjacentElement(BSTR where, IHTMLElement insertedElement, IHTMLElement* inserted);
    HRESULT applyElement(IHTMLElement apply, BSTR where, IHTMLElement* applied);
    HRESULT getAdjacentText(BSTR where, BSTR* text);
    HRESULT replaceAdjacentText(BSTR where, BSTR newText, BSTR* oldText);
    HRESULT get_canHaveChildren(VARIANT_BOOL* p);
    HRESULT addBehavior(BSTR bstrUrl, VARIANT* pvarFactory, int* pCookie);
    HRESULT removeBehavior(int cookie, VARIANT_BOOL* pfResult);
    HRESULT get_runtimeStyle(IHTMLStyle* p);
    HRESULT get_behaviorUrns(IDispatch* p);
    HRESULT put_tagUrn(BSTR v);
    HRESULT get_tagUrn(BSTR* p);
    HRESULT put_onbeforeeditfocus(VARIANT v);
    HRESULT get_onbeforeeditfocus(VARIANT* p);
    HRESULT get_readyStateValue(int* p);
    HRESULT getElementsByTagName(BSTR v, IHTMLElementCollection* pelColl);
}

@GUID("30510469-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLAttributeCollection3 : IDispatch
{
    HRESULT getNamedItem(BSTR bstrName, IHTMLDOMAttribute* ppNodeOut);
    HRESULT setNamedItem(IHTMLDOMAttribute pNodeIn, IHTMLDOMAttribute* ppNodeOut);
    HRESULT removeNamedItem(BSTR bstrName, IHTMLDOMAttribute* ppNodeOut);
    HRESULT item(int index, IHTMLDOMAttribute* ppNodeOut);
    HRESULT get_length(int* p);
}

@GUID("30510738-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMDocumentType : IDispatch
{
    HRESULT get_name(BSTR* p);
    HRESULT get_entities(IDispatch* p);
    HRESULT get_notations(IDispatch* p);
    HRESULT get_publicId(VARIANT* p);
    HRESULT get_systemId(VARIANT* p);
    HRESULT get_internalSubset(VARIANT* p);
}

@GUID("305104b8-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDocument7 : IDispatch
{
    HRESULT get_defaultView(IHTMLWindow2* p);
    HRESULT createCDATASection(BSTR text, IHTMLDOMNode* newCDATASectionNode);
    HRESULT getSelection(IHTMLSelection* ppIHTMLSelection);
    HRESULT getElementsByTagNameNS(VARIANT* pvarNS, BSTR bstrLocalName, IHTMLElementCollection* pelColl);
    HRESULT createElementNS(VARIANT* pvarNS, BSTR bstrTag, IHTMLElement* newElem);
    HRESULT createAttributeNS(VARIANT* pvarNS, BSTR bstrAttrName, IHTMLDOMAttribute* ppAttribute);
    HRESULT put_onmsthumbnailclick(VARIANT v);
    HRESULT get_onmsthumbnailclick(VARIANT* p);
    HRESULT get_characterSet(BSTR* p);
    HRESULT createElement(BSTR bstrTag, IHTMLElement* newElem);
    HRESULT createAttribute(BSTR bstrAttrName, IHTMLDOMAttribute* ppAttribute);
    HRESULT getElementsByClassName(BSTR v, IHTMLElementCollection* pel);
    HRESULT createProcessingInstruction(BSTR bstrTarget, BSTR bstrData, 
                                        IDOMProcessingInstruction* newProcessingInstruction);
    HRESULT adoptNode(IHTMLDOMNode pNodeSource, IHTMLDOMNode3* ppNodeDest);
    HRESULT put_onmssitemodejumplistitemremoved(VARIANT v);
    HRESULT get_onmssitemodejumplistitemremoved(VARIANT* p);
    HRESULT get_all(IHTMLElementCollection* p);
    HRESULT get_inputEncoding(BSTR* p);
    HRESULT get_xmlEncoding(BSTR* p);
    HRESULT put_xmlStandalone(VARIANT_BOOL v);
    HRESULT get_xmlStandalone(VARIANT_BOOL* p);
    HRESULT put_xmlVersion(BSTR v);
    HRESULT get_xmlVersion(BSTR* p);
    HRESULT hasAttributes(VARIANT_BOOL* pfHasAttributes);
    HRESULT put_onabort(VARIANT v);
    HRESULT get_onabort(VARIANT* p);
    HRESULT put_onblur(VARIANT v);
    HRESULT get_onblur(VARIANT* p);
    HRESULT put_oncanplay(VARIANT v);
    HRESULT get_oncanplay(VARIANT* p);
    HRESULT put_oncanplaythrough(VARIANT v);
    HRESULT get_oncanplaythrough(VARIANT* p);
    HRESULT put_onchange(VARIANT v);
    HRESULT get_onchange(VARIANT* p);
    HRESULT put_ondrag(VARIANT v);
    HRESULT get_ondrag(VARIANT* p);
    HRESULT put_ondragend(VARIANT v);
    HRESULT get_ondragend(VARIANT* p);
    HRESULT put_ondragenter(VARIANT v);
    HRESULT get_ondragenter(VARIANT* p);
    HRESULT put_ondragleave(VARIANT v);
    HRESULT get_ondragleave(VARIANT* p);
    HRESULT put_ondragover(VARIANT v);
    HRESULT get_ondragover(VARIANT* p);
    HRESULT put_ondrop(VARIANT v);
    HRESULT get_ondrop(VARIANT* p);
    HRESULT put_ondurationchange(VARIANT v);
    HRESULT get_ondurationchange(VARIANT* p);
    HRESULT put_onemptied(VARIANT v);
    HRESULT get_onemptied(VARIANT* p);
    HRESULT put_onended(VARIANT v);
    HRESULT get_onended(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_onfocus(VARIANT v);
    HRESULT get_onfocus(VARIANT* p);
    HRESULT put_oninput(VARIANT v);
    HRESULT get_oninput(VARIANT* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onloadeddata(VARIANT v);
    HRESULT get_onloadeddata(VARIANT* p);
    HRESULT put_onloadedmetadata(VARIANT v);
    HRESULT get_onloadedmetadata(VARIANT* p);
    HRESULT put_onloadstart(VARIANT v);
    HRESULT get_onloadstart(VARIANT* p);
    HRESULT put_onpause(VARIANT v);
    HRESULT get_onpause(VARIANT* p);
    HRESULT put_onplay(VARIANT v);
    HRESULT get_onplay(VARIANT* p);
    HRESULT put_onplaying(VARIANT v);
    HRESULT get_onplaying(VARIANT* p);
    HRESULT put_onprogress(VARIANT v);
    HRESULT get_onprogress(VARIANT* p);
    HRESULT put_onratechange(VARIANT v);
    HRESULT get_onratechange(VARIANT* p);
    HRESULT put_onreset(VARIANT v);
    HRESULT get_onreset(VARIANT* p);
    HRESULT put_onscroll(VARIANT v);
    HRESULT get_onscroll(VARIANT* p);
    HRESULT put_onseeked(VARIANT v);
    HRESULT get_onseeked(VARIANT* p);
    HRESULT put_onseeking(VARIANT v);
    HRESULT get_onseeking(VARIANT* p);
    HRESULT put_onselect(VARIANT v);
    HRESULT get_onselect(VARIANT* p);
    HRESULT put_onstalled(VARIANT v);
    HRESULT get_onstalled(VARIANT* p);
    HRESULT put_onsubmit(VARIANT v);
    HRESULT get_onsubmit(VARIANT* p);
    HRESULT put_onsuspend(VARIANT v);
    HRESULT get_onsuspend(VARIANT* p);
    HRESULT put_ontimeupdate(VARIANT v);
    HRESULT get_ontimeupdate(VARIANT* p);
    HRESULT put_onvolumechange(VARIANT v);
    HRESULT get_onvolumechange(VARIANT* p);
    HRESULT put_onwaiting(VARIANT v);
    HRESULT get_onwaiting(VARIANT* p);
    HRESULT normalize();
    HRESULT importNode(IHTMLDOMNode pNodeSource, VARIANT_BOOL fDeep, IHTMLDOMNode3* ppNodeDest);
    HRESULT get_parentWindow(IHTMLWindow2* p);
    HRESULT putref_body(IHTMLElement v);
    HRESULT get_body(IHTMLElement* p);
    HRESULT get_head(IHTMLElement* p);
}

@GUID("3050f5da-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDOMNode : IDispatch
{
    HRESULT get_nodeType(int* p);
    HRESULT get_parentNode(IHTMLDOMNode* p);
    HRESULT hasChildNodes(VARIANT_BOOL* fChildren);
    HRESULT get_childNodes(IDispatch* p);
    HRESULT get_attributes(IDispatch* p);
    HRESULT insertBefore(IHTMLDOMNode newChild, VARIANT refChild, IHTMLDOMNode* node);
    HRESULT removeChild(IHTMLDOMNode oldChild, IHTMLDOMNode* node);
    HRESULT replaceChild(IHTMLDOMNode newChild, IHTMLDOMNode oldChild, IHTMLDOMNode* node);
    HRESULT cloneNode(VARIANT_BOOL fDeep, IHTMLDOMNode* clonedNode);
    HRESULT removeNode(VARIANT_BOOL fDeep, IHTMLDOMNode* removed);
    HRESULT swapNode(IHTMLDOMNode otherNode, IHTMLDOMNode* swappedNode);
    HRESULT replaceNode(IHTMLDOMNode replacement, IHTMLDOMNode* replaced);
    HRESULT appendChild(IHTMLDOMNode newChild, IHTMLDOMNode* node);
    HRESULT get_nodeName(BSTR* p);
    HRESULT put_nodeValue(VARIANT v);
    HRESULT get_nodeValue(VARIANT* p);
    HRESULT get_firstChild(IHTMLDOMNode* p);
    HRESULT get_lastChild(IHTMLDOMNode* p);
    HRESULT get_previousSibling(IHTMLDOMNode* p);
    HRESULT get_nextSibling(IHTMLDOMNode* p);
}

@GUID("3050f80b-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDOMNode2 : IDispatch
{
    HRESULT get_ownerDocument(IDispatch* p);
}

@GUID("305106e0-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDOMNode3 : IDispatch
{
    HRESULT put_prefix(VARIANT v);
    HRESULT get_prefix(VARIANT* p);
    HRESULT get_localName(VARIANT* p);
    HRESULT get_namespaceURI(VARIANT* p);
    HRESULT put_textContent(VARIANT v);
    HRESULT get_textContent(VARIANT* p);
    HRESULT isEqualNode(IHTMLDOMNode3 otherNode, VARIANT_BOOL* isEqual);
    HRESULT lookupNamespaceURI(VARIANT* pvarPrefix, VARIANT* pvarNamespaceURI);
    HRESULT lookupPrefix(VARIANT* pvarNamespaceURI, VARIANT* pvarPrefix);
    HRESULT isDefaultNamespace(VARIANT* pvarNamespace, VARIANT_BOOL* pfDefaultNamespace);
    HRESULT appendChild(IHTMLDOMNode newChild, IHTMLDOMNode* node);
    HRESULT insertBefore(IHTMLDOMNode newChild, VARIANT refChild, IHTMLDOMNode* node);
    HRESULT removeChild(IHTMLDOMNode oldChild, IHTMLDOMNode* node);
    HRESULT replaceChild(IHTMLDOMNode newChild, IHTMLDOMNode oldChild, IHTMLDOMNode* node);
    HRESULT isSameNode(IHTMLDOMNode3 otherNode, VARIANT_BOOL* isSame);
    HRESULT compareDocumentPosition(IHTMLDOMNode otherNode, ushort* flags);
    HRESULT isSupported(BSTR feature, VARIANT version_, VARIANT_BOOL* pfisSupported);
}

@GUID("3050f4b0-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDOMAttribute : IDispatch
{
    HRESULT get_nodeName(BSTR* p);
    HRESULT put_nodeValue(VARIANT v);
    HRESULT get_nodeValue(VARIANT* p);
    HRESULT get_specified(VARIANT_BOOL* p);
}

@GUID("3050f810-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDOMAttribute2 : IDispatch
{
    HRESULT get_name(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT get_expando(VARIANT_BOOL* p);
    HRESULT get_nodeType(int* p);
    HRESULT get_parentNode(IHTMLDOMNode* p);
    HRESULT get_childNodes(IDispatch* p);
    HRESULT get_firstChild(IHTMLDOMNode* p);
    HRESULT get_lastChild(IHTMLDOMNode* p);
    HRESULT get_previousSibling(IHTMLDOMNode* p);
    HRESULT get_nextSibling(IHTMLDOMNode* p);
    HRESULT get_attributes(IDispatch* p);
    HRESULT get_ownerDocument(IDispatch* p);
    HRESULT insertBefore(IHTMLDOMNode newChild, VARIANT refChild, IHTMLDOMNode* node);
    HRESULT replaceChild(IHTMLDOMNode newChild, IHTMLDOMNode oldChild, IHTMLDOMNode* node);
    HRESULT removeChild(IHTMLDOMNode oldChild, IHTMLDOMNode* node);
    HRESULT appendChild(IHTMLDOMNode newChild, IHTMLDOMNode* node);
    HRESULT hasChildNodes(VARIANT_BOOL* fChildren);
    HRESULT cloneNode(VARIANT_BOOL fDeep, IHTMLDOMAttribute* clonedNode);
}

@GUID("30510468-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDOMAttribute3 : IDispatch
{
    HRESULT put_nodeValue(VARIANT v);
    HRESULT get_nodeValue(VARIANT* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT get_specified(VARIANT_BOOL* p);
    HRESULT get_ownerElement(IHTMLElement2* p);
}

@GUID("305106f9-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDOMAttribute4 : IDispatch
{
    HRESULT put_nodeValue(VARIANT v);
    HRESULT get_nodeValue(VARIANT* p);
    HRESULT get_nodeName(BSTR* p);
    HRESULT get_name(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT get_firstChild(IHTMLDOMNode* p);
    HRESULT get_lastChild(IHTMLDOMNode* p);
    HRESULT get_childNodes(IDispatch* p);
    HRESULT hasAttributes(VARIANT_BOOL* pfHasAttributes);
    HRESULT hasChildNodes(VARIANT_BOOL* fChildren);
    HRESULT normalize();
    HRESULT get_specified(VARIANT_BOOL* p);
}

@GUID("3050f4b1-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDOMTextNode : IDispatch
{
    HRESULT put_data(BSTR v);
    HRESULT get_data(BSTR* p);
    HRESULT toString(BSTR* String);
    HRESULT get_length(int* p);
    HRESULT splitText(int offset, IHTMLDOMNode* pRetNode);
}

@GUID("3050f809-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDOMTextNode2 : IDispatch
{
    HRESULT substringData(int offset, int Count, BSTR* pbstrsubString);
    HRESULT appendData(BSTR bstrstring);
    HRESULT insertData(int offset, BSTR bstrstring);
    HRESULT deleteData(int offset, int Count);
    HRESULT replaceData(int offset, int Count, BSTR bstrstring);
}

@GUID("3051073e-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDOMTextNode3 : IDispatch
{
    HRESULT substringData(int offset, int Count, BSTR* pbstrsubString);
    HRESULT insertData(int offset, BSTR bstrstring);
    HRESULT deleteData(int offset, int Count);
    HRESULT replaceData(int offset, int Count, BSTR bstrstring);
    HRESULT splitText(int offset, IHTMLDOMNode* pRetNode);
    HRESULT get_wholeText(BSTR* p);
    HRESULT replaceWholeText(BSTR bstrText, IHTMLDOMNode* ppRetNode);
    HRESULT hasAttributes(VARIANT_BOOL* pfHasAttributes);
    HRESULT normalize();
}

@GUID("3050f80d-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDOMImplementation : IDispatch
{
    HRESULT hasFeature(BSTR bstrfeature, VARIANT version_, VARIANT_BOOL* pfHasFeature);
}

@GUID("3051073c-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDOMImplementation2 : IDispatch
{
    HRESULT createDocumentType(BSTR bstrQualifiedName, VARIANT* pvarPublicId, VARIANT* pvarSystemId, 
                               IDOMDocumentType* newDocumentType);
    HRESULT createDocument(VARIANT* pvarNS, VARIANT* pvarTagName, IDOMDocumentType pDocumentType, 
                           IHTMLDocument7* ppnewDocument);
    HRESULT createHTMLDocument(BSTR bstrTitle, IHTMLDocument7* ppnewDocument);
    HRESULT hasFeature(BSTR bstrfeature, VARIANT version_, VARIANT_BOOL* pfHasFeature);
}

@GUID("3050f564-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLDOMAttribute : IDispatch
{
}

@GUID("3050f565-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLDOMTextNode : IDispatch
{
}

@GUID("3050f58f-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLDOMImplementation : IDispatch
{
}

@GUID("3050f4c3-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLAttributeCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(VARIANT* name, IDispatch* pdisp);
}

@GUID("3050f80a-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLAttributeCollection2 : IDispatch
{
    HRESULT getNamedItem(BSTR bstrName, IHTMLDOMAttribute* newretNode);
    HRESULT setNamedItem(IHTMLDOMAttribute ppNode, IHTMLDOMAttribute* newretNode);
    HRESULT removeNamedItem(BSTR bstrName, IHTMLDOMAttribute* newretNode);
}

@GUID("305106fa-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLAttributeCollection4 : IDispatch
{
    HRESULT getNamedItemNS(VARIANT* pvarNS, BSTR bstrName, IHTMLDOMAttribute2* ppNodeOut);
    HRESULT setNamedItemNS(IHTMLDOMAttribute2 pNodeIn, IHTMLDOMAttribute2* ppNodeOut);
    HRESULT removeNamedItemNS(VARIANT* pvarNS, BSTR bstrName, IHTMLDOMAttribute2* ppNodeOut);
    HRESULT getNamedItem(BSTR bstrName, IHTMLDOMAttribute2* ppNodeOut);
    HRESULT setNamedItem(IHTMLDOMAttribute2 pNodeIn, IHTMLDOMAttribute2* ppNodeOut);
    HRESULT removeNamedItem(BSTR bstrName, IHTMLDOMAttribute2* ppNodeOut);
    HRESULT item(int index, IHTMLDOMAttribute2* ppNodeOut);
    HRESULT get_length(int* p);
}

@GUID("3050f5ab-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDOMChildrenCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(int index, IDispatch* ppItem);
}

@GUID("30510791-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDOMChildrenCollection2 : IDispatch
{
    HRESULT item(int index, IDispatch* ppItem);
}

@GUID("3050f56c-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLAttributeCollection : IDispatch
{
}

@GUID("3050f59b-98b5-11cf-bb82-00aa00bdce0b")
interface DispStaticNodeList : IDispatch
{
}

@GUID("3050f577-98b5-11cf-bb82-00aa00bdce0b")
interface DispDOMChildrenCollection : IDispatch
{
}

@GUID("3051075e-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLElementEvents4 : IDispatch
{
}

@GUID("3050f59f-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLElementEvents3 : IDispatch
{
}

@GUID("3050f60f-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLElementEvents2 : IDispatch
{
}

@GUID("3050f33c-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLElementEvents : IDispatch
{
}

@GUID("305104be-98b5-11cf-bb82-00aa00bdce0b")
interface IRulesAppliedCollection : IDispatch
{
    HRESULT item(int index, IRulesApplied* ppRulesApplied);
    HRESULT get_length(int* p);
    HRESULT get_element(IHTMLElement* p);
    HRESULT propertyInheritedFrom(BSTR name, IRulesApplied* ppRulesApplied);
    HRESULT get_propertyCount(int* p);
    HRESULT property(int index, BSTR* pbstrProperty);
    HRESULT propertyInheritedTrace(BSTR name, int index, IRulesApplied* ppRulesApplied);
    HRESULT propertyInheritedTraceLength(BSTR name, int* pLength);
}

@GUID("3050f673-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLElement3 : IDispatch
{
    HRESULT mergeAttributes(IHTMLElement mergeThis, VARIANT* pvarFlags);
    HRESULT get_isMultiLine(VARIANT_BOOL* p);
    HRESULT get_canHaveHTML(VARIANT_BOOL* p);
    HRESULT put_onlayoutcomplete(VARIANT v);
    HRESULT get_onlayoutcomplete(VARIANT* p);
    HRESULT put_onpage(VARIANT v);
    HRESULT get_onpage(VARIANT* p);
    HRESULT put_inflateBlock(VARIANT_BOOL v);
    HRESULT get_inflateBlock(VARIANT_BOOL* p);
    HRESULT put_onbeforedeactivate(VARIANT v);
    HRESULT get_onbeforedeactivate(VARIANT* p);
    HRESULT setActive();
    HRESULT put_contentEditable(BSTR v);
    HRESULT get_contentEditable(BSTR* p);
    HRESULT get_isContentEditable(VARIANT_BOOL* p);
    HRESULT put_hideFocus(VARIANT_BOOL v);
    HRESULT get_hideFocus(VARIANT_BOOL* p);
    HRESULT put_disabled(VARIANT_BOOL v);
    HRESULT get_disabled(VARIANT_BOOL* p);
    HRESULT get_isDisabled(VARIANT_BOOL* p);
    HRESULT put_onmove(VARIANT v);
    HRESULT get_onmove(VARIANT* p);
    HRESULT put_oncontrolselect(VARIANT v);
    HRESULT get_oncontrolselect(VARIANT* p);
    HRESULT fireEvent(BSTR bstrEventName, VARIANT* pvarEventObject, VARIANT_BOOL* pfCancelled);
    HRESULT put_onresizestart(VARIANT v);
    HRESULT get_onresizestart(VARIANT* p);
    HRESULT put_onresizeend(VARIANT v);
    HRESULT get_onresizeend(VARIANT* p);
    HRESULT put_onmovestart(VARIANT v);
    HRESULT get_onmovestart(VARIANT* p);
    HRESULT put_onmoveend(VARIANT v);
    HRESULT get_onmoveend(VARIANT* p);
    HRESULT put_onmouseenter(VARIANT v);
    HRESULT get_onmouseenter(VARIANT* p);
    HRESULT put_onmouseleave(VARIANT v);
    HRESULT get_onmouseleave(VARIANT* p);
    HRESULT put_onactivate(VARIANT v);
    HRESULT get_onactivate(VARIANT* p);
    HRESULT put_ondeactivate(VARIANT v);
    HRESULT get_ondeactivate(VARIANT* p);
    HRESULT dragDrop(VARIANT_BOOL* pfRet);
    HRESULT get_glyphMode(int* p);
}

@GUID("3050f80f-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLElement4 : IDispatch
{
    HRESULT put_onmousewheel(VARIANT v);
    HRESULT get_onmousewheel(VARIANT* p);
    HRESULT normalize();
    HRESULT getAttributeNode(BSTR bstrname, IHTMLDOMAttribute* ppAttribute);
    HRESULT setAttributeNode(IHTMLDOMAttribute pattr, IHTMLDOMAttribute* ppretAttribute);
    HRESULT removeAttributeNode(IHTMLDOMAttribute pattr, IHTMLDOMAttribute* ppretAttribute);
    HRESULT put_onbeforeactivate(VARIANT v);
    HRESULT get_onbeforeactivate(VARIANT* p);
    HRESULT put_onfocusin(VARIANT v);
    HRESULT get_onfocusin(VARIANT* p);
    HRESULT put_onfocusout(VARIANT v);
    HRESULT get_onfocusout(VARIANT* p);
}

@GUID("30510463-98b5-11cf-bb82-00aa00bdce0b")
interface IElementSelector : IDispatch
{
    HRESULT querySelector(BSTR v, IHTMLElement* pel);
    HRESULT querySelectorAll(BSTR v, IHTMLDOMChildrenCollection* pel);
}

@GUID("3050f669-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLElementRender : IUnknown
{
    HRESULT DrawToDC(HDC hDC);
    HRESULT SetDocumentPrinter(BSTR bstrPrinterName, HDC hDC);
}

@GUID("3050f4d0-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLUniqueName : IDispatch
{
    HRESULT get_uniqueNumber(int* p);
    HRESULT get_uniqueID(BSTR* p);
}

@GUID("3051045d-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLElement5 : IDispatch
{
    HRESULT getAttributeNode(BSTR bstrname, IHTMLDOMAttribute2* ppretAttribute);
    HRESULT setAttributeNode(IHTMLDOMAttribute2 pattr, IHTMLDOMAttribute2* ppretAttribute);
    HRESULT removeAttributeNode(IHTMLDOMAttribute2 pattr, IHTMLDOMAttribute2* ppretAttribute);
    HRESULT hasAttribute(BSTR name, VARIANT_BOOL* pfHasAttribute);
    HRESULT put_role(BSTR v);
    HRESULT get_role(BSTR* p);
    HRESULT put_ariaBusy(BSTR v);
    HRESULT get_ariaBusy(BSTR* p);
    HRESULT put_ariaChecked(BSTR v);
    HRESULT get_ariaChecked(BSTR* p);
    HRESULT put_ariaDisabled(BSTR v);
    HRESULT get_ariaDisabled(BSTR* p);
    HRESULT put_ariaExpanded(BSTR v);
    HRESULT get_ariaExpanded(BSTR* p);
    HRESULT put_ariaHaspopup(BSTR v);
    HRESULT get_ariaHaspopup(BSTR* p);
    HRESULT put_ariaHidden(BSTR v);
    HRESULT get_ariaHidden(BSTR* p);
    HRESULT put_ariaInvalid(BSTR v);
    HRESULT get_ariaInvalid(BSTR* p);
    HRESULT put_ariaMultiselectable(BSTR v);
    HRESULT get_ariaMultiselectable(BSTR* p);
    HRESULT put_ariaPressed(BSTR v);
    HRESULT get_ariaPressed(BSTR* p);
    HRESULT put_ariaReadonly(BSTR v);
    HRESULT get_ariaReadonly(BSTR* p);
    HRESULT put_ariaRequired(BSTR v);
    HRESULT get_ariaRequired(BSTR* p);
    HRESULT put_ariaSecret(BSTR v);
    HRESULT get_ariaSecret(BSTR* p);
    HRESULT put_ariaSelected(BSTR v);
    HRESULT get_ariaSelected(BSTR* p);
    HRESULT getAttribute(BSTR strAttributeName, VARIANT* AttributeValue);
    HRESULT setAttribute(BSTR strAttributeName, VARIANT AttributeValue);
    HRESULT removeAttribute(BSTR strAttributeName, VARIANT_BOOL* pfSuccess);
    HRESULT get_attributes(IHTMLAttributeCollection3* p);
    HRESULT put_ariaValuenow(BSTR v);
    HRESULT get_ariaValuenow(BSTR* p);
    HRESULT put_ariaPosinset(short v);
    HRESULT get_ariaPosinset(short* p);
    HRESULT put_ariaSetsize(short v);
    HRESULT get_ariaSetsize(short* p);
    HRESULT put_ariaLevel(short v);
    HRESULT get_ariaLevel(short* p);
    HRESULT put_ariaValuemin(BSTR v);
    HRESULT get_ariaValuemin(BSTR* p);
    HRESULT put_ariaValuemax(BSTR v);
    HRESULT get_ariaValuemax(BSTR* p);
    HRESULT put_ariaControls(BSTR v);
    HRESULT get_ariaControls(BSTR* p);
    HRESULT put_ariaDescribedby(BSTR v);
    HRESULT get_ariaDescribedby(BSTR* p);
    HRESULT put_ariaFlowto(BSTR v);
    HRESULT get_ariaFlowto(BSTR* p);
    HRESULT put_ariaLabelledby(BSTR v);
    HRESULT get_ariaLabelledby(BSTR* p);
    HRESULT put_ariaActivedescendant(BSTR v);
    HRESULT get_ariaActivedescendant(BSTR* p);
    HRESULT put_ariaOwns(BSTR v);
    HRESULT get_ariaOwns(BSTR* p);
    HRESULT hasAttributes(VARIANT_BOOL* pfHasAttributes);
    HRESULT put_ariaLive(BSTR v);
    HRESULT get_ariaLive(BSTR* p);
    HRESULT put_ariaRelevant(BSTR v);
    HRESULT get_ariaRelevant(BSTR* p);
}

@GUID("305106f8-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLElement6 : IDispatch
{
    HRESULT getAttributeNS(VARIANT* pvarNS, BSTR strAttributeName, VARIANT* AttributeValue);
    HRESULT setAttributeNS(VARIANT* pvarNS, BSTR strAttributeName, VARIANT* pvarAttributeValue);
    HRESULT removeAttributeNS(VARIANT* pvarNS, BSTR strAttributeName);
    HRESULT getAttributeNodeNS(VARIANT* pvarNS, BSTR bstrname, IHTMLDOMAttribute2* ppretAttribute);
    HRESULT setAttributeNodeNS(IHTMLDOMAttribute2 pattr, IHTMLDOMAttribute2* ppretAttribute);
    HRESULT hasAttributeNS(VARIANT* pvarNS, BSTR name, VARIANT_BOOL* pfHasAttribute);
    HRESULT getAttribute(BSTR strAttributeName, VARIANT* AttributeValue);
    HRESULT setAttribute(BSTR strAttributeName, VARIANT* pvarAttributeValue);
    HRESULT removeAttribute(BSTR strAttributeName);
    HRESULT getAttributeNode(BSTR strAttributeName, IHTMLDOMAttribute2* ppretAttribute);
    HRESULT setAttributeNode(IHTMLDOMAttribute2 pattr, IHTMLDOMAttribute2* ppretAttribute);
    HRESULT removeAttributeNode(IHTMLDOMAttribute2 pattr, IHTMLDOMAttribute2* ppretAttribute);
    HRESULT hasAttribute(BSTR name, VARIANT_BOOL* pfHasAttribute);
    HRESULT getElementsByTagNameNS(VARIANT* varNS, BSTR bstrLocalName, IHTMLElementCollection* pelColl);
    HRESULT get_tagName(BSTR* p);
    HRESULT get_nodeName(BSTR* p);
    HRESULT getElementsByClassName(BSTR v, IHTMLElementCollection* pel);
    HRESULT msMatchesSelector(BSTR v, VARIANT_BOOL* pfMatches);
    HRESULT put_onabort(VARIANT v);
    HRESULT get_onabort(VARIANT* p);
    HRESULT put_oncanplay(VARIANT v);
    HRESULT get_oncanplay(VARIANT* p);
    HRESULT put_oncanplaythrough(VARIANT v);
    HRESULT get_oncanplaythrough(VARIANT* p);
    HRESULT put_onchange(VARIANT v);
    HRESULT get_onchange(VARIANT* p);
    HRESULT put_ondurationchange(VARIANT v);
    HRESULT get_ondurationchange(VARIANT* p);
    HRESULT put_onemptied(VARIANT v);
    HRESULT get_onemptied(VARIANT* p);
    HRESULT put_onended(VARIANT v);
    HRESULT get_onended(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_oninput(VARIANT v);
    HRESULT get_oninput(VARIANT* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onloadeddata(VARIANT v);
    HRESULT get_onloadeddata(VARIANT* p);
    HRESULT put_onloadedmetadata(VARIANT v);
    HRESULT get_onloadedmetadata(VARIANT* p);
    HRESULT put_onloadstart(VARIANT v);
    HRESULT get_onloadstart(VARIANT* p);
    HRESULT put_onpause(VARIANT v);
    HRESULT get_onpause(VARIANT* p);
    HRESULT put_onplay(VARIANT v);
    HRESULT get_onplay(VARIANT* p);
    HRESULT put_onplaying(VARIANT v);
    HRESULT get_onplaying(VARIANT* p);
    HRESULT put_onprogress(VARIANT v);
    HRESULT get_onprogress(VARIANT* p);
    HRESULT put_onratechange(VARIANT v);
    HRESULT get_onratechange(VARIANT* p);
    HRESULT put_onreset(VARIANT v);
    HRESULT get_onreset(VARIANT* p);
    HRESULT put_onseeked(VARIANT v);
    HRESULT get_onseeked(VARIANT* p);
    HRESULT put_onseeking(VARIANT v);
    HRESULT get_onseeking(VARIANT* p);
    HRESULT put_onselect(VARIANT v);
    HRESULT get_onselect(VARIANT* p);
    HRESULT put_onstalled(VARIANT v);
    HRESULT get_onstalled(VARIANT* p);
    HRESULT put_onsubmit(VARIANT v);
    HRESULT get_onsubmit(VARIANT* p);
    HRESULT put_onsuspend(VARIANT v);
    HRESULT get_onsuspend(VARIANT* p);
    HRESULT put_ontimeupdate(VARIANT v);
    HRESULT get_ontimeupdate(VARIANT* p);
    HRESULT put_onvolumechange(VARIANT v);
    HRESULT get_onvolumechange(VARIANT* p);
    HRESULT put_onwaiting(VARIANT v);
    HRESULT get_onwaiting(VARIANT* p);
    HRESULT hasAttributes(VARIANT_BOOL* pfHasAttributes);
}

@GUID("305107aa-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLElement7 : IDispatch
{
    HRESULT put_onmspointerdown(VARIANT v);
    HRESULT get_onmspointerdown(VARIANT* p);
    HRESULT put_onmspointermove(VARIANT v);
    HRESULT get_onmspointermove(VARIANT* p);
    HRESULT put_onmspointerup(VARIANT v);
    HRESULT get_onmspointerup(VARIANT* p);
    HRESULT put_onmspointerover(VARIANT v);
    HRESULT get_onmspointerover(VARIANT* p);
    HRESULT put_onmspointerout(VARIANT v);
    HRESULT get_onmspointerout(VARIANT* p);
    HRESULT put_onmspointercancel(VARIANT v);
    HRESULT get_onmspointercancel(VARIANT* p);
    HRESULT put_onmspointerhover(VARIANT v);
    HRESULT get_onmspointerhover(VARIANT* p);
    HRESULT put_onmslostpointercapture(VARIANT v);
    HRESULT get_onmslostpointercapture(VARIANT* p);
    HRESULT put_onmsgotpointercapture(VARIANT v);
    HRESULT get_onmsgotpointercapture(VARIANT* p);
    HRESULT put_onmsgesturestart(VARIANT v);
    HRESULT get_onmsgesturestart(VARIANT* p);
    HRESULT put_onmsgesturechange(VARIANT v);
    HRESULT get_onmsgesturechange(VARIANT* p);
    HRESULT put_onmsgestureend(VARIANT v);
    HRESULT get_onmsgestureend(VARIANT* p);
    HRESULT put_onmsgesturehold(VARIANT v);
    HRESULT get_onmsgesturehold(VARIANT* p);
    HRESULT put_onmsgesturetap(VARIANT v);
    HRESULT get_onmsgesturetap(VARIANT* p);
    HRESULT put_onmsgesturedoubletap(VARIANT v);
    HRESULT get_onmsgesturedoubletap(VARIANT* p);
    HRESULT put_onmsinertiastart(VARIANT v);
    HRESULT get_onmsinertiastart(VARIANT* p);
    HRESULT msSetPointerCapture(int pointerId);
    HRESULT msReleasePointerCapture(int pointerId);
    HRESULT put_onmstransitionstart(VARIANT v);
    HRESULT get_onmstransitionstart(VARIANT* p);
    HRESULT put_onmstransitionend(VARIANT v);
    HRESULT get_onmstransitionend(VARIANT* p);
    HRESULT put_onmsanimationstart(VARIANT v);
    HRESULT get_onmsanimationstart(VARIANT* p);
    HRESULT put_onmsanimationend(VARIANT v);
    HRESULT get_onmsanimationend(VARIANT* p);
    HRESULT put_onmsanimationiteration(VARIANT v);
    HRESULT get_onmsanimationiteration(VARIANT* p);
    HRESULT put_oninvalid(VARIANT v);
    HRESULT get_oninvalid(VARIANT* p);
    HRESULT put_xmsAcceleratorKey(BSTR v);
    HRESULT get_xmsAcceleratorKey(BSTR* p);
    HRESULT put_spellcheck(VARIANT v);
    HRESULT get_spellcheck(VARIANT* p);
    HRESULT put_onmsmanipulationstatechanged(VARIANT v);
    HRESULT get_onmsmanipulationstatechanged(VARIANT* p);
    HRESULT put_oncuechange(VARIANT v);
    HRESULT get_oncuechange(VARIANT* p);
}

@GUID("305104bd-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLElementAppliedStyles : IDispatch
{
    HRESULT msGetRulesApplied(IRulesAppliedCollection* ppRulesAppliedCollection);
    HRESULT msGetRulesAppliedWithAncestor(VARIANT varContext, IRulesAppliedCollection* ppRulesAppliedCollection);
}

@GUID("30510736-98b5-11cf-bb82-00aa00bdce0b")
interface IElementTraversal : IDispatch
{
    HRESULT get_firstElementChild(IHTMLElement* p);
    HRESULT get_lastElementChild(IHTMLElement* p);
    HRESULT get_previousElementSibling(IHTMLElement* p);
    HRESULT get_nextElementSibling(IHTMLElement* p);
    HRESULT get_childElementCount(int* p);
}

@GUID("3050f3f2-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDatabinding : IDispatch
{
    HRESULT put_dataFld(BSTR v);
    HRESULT get_dataFld(BSTR* p);
    HRESULT put_dataSrc(BSTR v);
    HRESULT get_dataSrc(BSTR* p);
    HRESULT put_dataFormatAs(BSTR v);
    HRESULT get_dataFormatAs(BSTR* p);
}

@GUID("626fc520-a41e-11cf-a731-00a0c9082637")
interface IHTMLDocument : IDispatch
{
    HRESULT get_Script(IDispatch* p);
}

@GUID("3050f6c9-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLElementDefaults : IDispatch
{
    HRESULT get_style(IHTMLStyle* p);
    HRESULT put_tabStop(VARIANT_BOOL v);
    HRESULT get_tabStop(VARIANT_BOOL* p);
    HRESULT put_viewInheritStyle(VARIANT_BOOL v);
    HRESULT get_viewInheritStyle(VARIANT_BOOL* p);
    HRESULT put_viewMasterTab(VARIANT_BOOL v);
    HRESULT get_viewMasterTab(VARIANT_BOOL* p);
    HRESULT put_scrollSegmentX(int v);
    HRESULT get_scrollSegmentX(int* p);
    HRESULT put_scrollSegmentY(int v);
    HRESULT get_scrollSegmentY(int* p);
    HRESULT put_isMultiLine(VARIANT_BOOL v);
    HRESULT get_isMultiLine(VARIANT_BOOL* p);
    HRESULT put_contentEditable(BSTR v);
    HRESULT get_contentEditable(BSTR* p);
    HRESULT put_canHaveHTML(VARIANT_BOOL v);
    HRESULT get_canHaveHTML(VARIANT_BOOL* p);
    HRESULT putref_viewLink(IHTMLDocument v);
    HRESULT get_viewLink(IHTMLDocument* p);
    HRESULT put_frozen(VARIANT_BOOL v);
    HRESULT get_frozen(VARIANT_BOOL* p);
}

@GUID("3050f58c-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLDefaults : IDispatch
{
}

@GUID("3050f4fd-98b5-11cf-bb82-00aa00bdce0b")
interface IHTCDefaultDispatch : IDispatch
{
    HRESULT get_element(IHTMLElement* p);
    HRESULT createEventObject(IHTMLEventObj* eventObj);
    HRESULT get_defaults(IDispatch* p);
    HRESULT get_document(IDispatch* p);
}

@GUID("3050f5df-98b5-11cf-bb82-00aa00bdce0b")
interface IHTCPropertyBehavior : IDispatch
{
    HRESULT fireChange();
    HRESULT put_value(VARIANT v);
    HRESULT get_value(VARIANT* p);
}

@GUID("3050f631-98b5-11cf-bb82-00aa00bdce0b")
interface IHTCMethodBehavior : IDispatch
{
}

@GUID("3050f4ff-98b5-11cf-bb82-00aa00bdce0b")
interface IHTCEventBehavior : IDispatch
{
    HRESULT fire(IHTMLEventObj pvar);
}

@GUID("3050f5f4-98b5-11cf-bb82-00aa00bdce0b")
interface IHTCAttachBehavior : IDispatch
{
    HRESULT fireEvent(IDispatch evt);
    HRESULT detachEvent();
}

@GUID("3050f7eb-98b5-11cf-bb82-00aa00bdce0b")
interface IHTCAttachBehavior2 : IDispatch
{
    HRESULT fireEvent(VARIANT evt);
}

@GUID("3050f5dc-98b5-11cf-bb82-00aa00bdce0b")
interface IHTCDescBehavior : IDispatch
{
    HRESULT get_urn(BSTR* p);
    HRESULT get_name(BSTR* p);
}

@GUID("3050f573-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTCDefaultDispatch : IDispatch
{
}

@GUID("3050f57f-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTCPropertyBehavior : IDispatch
{
}

@GUID("3050f587-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTCMethodBehavior : IDispatch
{
}

@GUID("3050f574-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTCEventBehavior : IDispatch
{
}

@GUID("3050f583-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTCAttachBehavior : IDispatch
{
}

@GUID("3050f57e-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTCDescBehavior : IDispatch
{
}

@GUID("3050f5e2-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLUrnCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT item(int index, BSTR* ppUrn);
}

@GUID("3050f551-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLUrnCollection : IDispatch
{
}

@GUID("3050f4b7-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLGenericElement : IDispatch
{
    HRESULT get_recordset(IDispatch* p);
    HRESULT namedRecordset(BSTR dataMember, VARIANT* hierarchy, IDispatch* ppRecordset);
}

@GUID("3050f563-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLGenericElement : IDispatch
{
}

@GUID("305104c1-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStyleSheetRuleApplied : IDispatch
{
    HRESULT get_msSpecificity(int* p);
    HRESULT msGetSpecificity(int index, int* p);
}

@GUID("305106fd-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStyleSheetRule2 : IDispatch
{
    HRESULT put_selectorText(BSTR v);
    HRESULT get_selectorText(BSTR* p);
}

@GUID("305106e8-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStyleSheetRulesCollection2 : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT item(int index, IHTMLCSSRule* ppHTMLCSSRule);
}

@GUID("3050f50e-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLStyleSheetRule : IDispatch
{
}

@GUID("3050f52f-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLStyleSheetRulesCollection : IDispatch
{
}

@GUID("3050f7ee-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStyleSheetPage : IDispatch
{
    HRESULT get_selector(BSTR* p);
    HRESULT get_pseudoClass(BSTR* p);
}

@GUID("305106ed-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStyleSheetPage2 : IDispatch
{
    HRESULT put_selectorText(BSTR v);
    HRESULT get_selectorText(BSTR* p);
    HRESULT get_style(IHTMLRuleStyle* p);
}

@GUID("3050f7f0-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStyleSheetPagesCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT item(int index, IHTMLStyleSheetPage* ppHTMLStyleSheetPage);
}

@GUID("3050f540-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLStyleSheetPage : IDispatch
{
}

@GUID("3050f543-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLStyleSheetPagesCollection : IDispatch
{
}

@GUID("3050f37e-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStyleSheetsCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(VARIANT* pvarIndex, VARIANT* pvarResult);
}

@GUID("3050f3d1-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStyleSheet2 : IDispatch
{
    HRESULT get_pages(IHTMLStyleSheetPagesCollection* p);
    HRESULT addPageRule(BSTR bstrSelector, BSTR bstrStyle, int lIndex, int* plNewIndex);
}

@GUID("30510496-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStyleSheet3 : IDispatch
{
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
    HRESULT get_isAlternate(VARIANT_BOOL* p);
    HRESULT get_isPrefAlternate(VARIANT_BOOL* p);
}

@GUID("305106f4-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStyleSheet4 : IDispatch
{
    HRESULT get_type(BSTR* p);
    HRESULT get_href(VARIANT* p);
    HRESULT get_title(BSTR* p);
    HRESULT get_ownerNode(IHTMLElement* p);
    HRESULT get_ownerRule(IHTMLCSSRule* p);
    HRESULT get_cssRules(IHTMLStyleSheetRulesCollection* p);
    HRESULT get_media(VARIANT* p);
    HRESULT insertRule(BSTR bstrRule, int lIndex, int* plNewIndex);
    HRESULT deleteRule(int lIndex);
}

@GUID("3050f58d-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLStyleSheet : IDispatch
{
}

@GUID("305106e7-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStyleSheetsCollection2 : IDispatch
{
    HRESULT item(int index, VARIANT* pvarResult);
}

@GUID("3050f547-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLStyleSheetsCollection : IDispatch
{
}

@GUID("3050f61d-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLLinkElementEvents2 : IDispatch
{
}

@GUID("3050f3cc-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLLinkElementEvents : IDispatch
{
}

@GUID("3050f205-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLLinkElement : IDispatch
{
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
    HRESULT put_rel(BSTR v);
    HRESULT get_rel(BSTR* p);
    HRESULT put_rev(BSTR v);
    HRESULT get_rev(BSTR* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT get_readyState(BSTR* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT get_styleSheet(IHTMLStyleSheet* p);
    HRESULT put_disabled(VARIANT_BOOL v);
    HRESULT get_disabled(VARIANT_BOOL* p);
    HRESULT put_media(BSTR v);
    HRESULT get_media(BSTR* p);
}

@GUID("3050f4e5-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLLinkElement2 : IDispatch
{
    HRESULT put_target(BSTR v);
    HRESULT get_target(BSTR* p);
}

@GUID("3050f81e-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLLinkElement3 : IDispatch
{
    HRESULT put_charset(BSTR v);
    HRESULT get_charset(BSTR* p);
    HRESULT put_hreflang(BSTR v);
    HRESULT get_hreflang(BSTR* p);
}

@GUID("3051043a-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLLinkElement4 : IDispatch
{
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
}

@GUID("30510726-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLLinkElement5 : IDispatch
{
    HRESULT get_sheet(IHTMLStyleSheet* p);
}

@GUID("3050f524-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLLinkElement : IDispatch
{
}

@GUID("3050f220-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTxtRange : IDispatch
{
    HRESULT get_htmlText(BSTR* p);
    HRESULT put_text(BSTR v);
    HRESULT get_text(BSTR* p);
    HRESULT parentElement(IHTMLElement* parent);
    HRESULT duplicate(IHTMLTxtRange* Duplicate);
    HRESULT inRange(IHTMLTxtRange Range, VARIANT_BOOL* InRange);
    HRESULT isEqual(IHTMLTxtRange Range, VARIANT_BOOL* IsEqual);
    HRESULT scrollIntoView(VARIANT_BOOL fStart);
    HRESULT collapse(VARIANT_BOOL Start);
    HRESULT expand(BSTR Unit, VARIANT_BOOL* Success);
    HRESULT move(BSTR Unit, int Count, int* ActualCount);
    HRESULT moveStart(BSTR Unit, int Count, int* ActualCount);
    HRESULT moveEnd(BSTR Unit, int Count, int* ActualCount);
    HRESULT select();
    HRESULT pasteHTML(BSTR html);
    HRESULT moveToElementText(IHTMLElement element);
    HRESULT setEndPoint(BSTR how, IHTMLTxtRange SourceRange);
    HRESULT compareEndPoints(BSTR how, IHTMLTxtRange SourceRange, int* ret);
    HRESULT findText(BSTR String, int count, int Flags, VARIANT_BOOL* Success);
    HRESULT moveToPoint(int x, int y);
    HRESULT getBookmark(BSTR* Boolmark);
    HRESULT moveToBookmark(BSTR Bookmark, VARIANT_BOOL* Success);
    HRESULT queryCommandSupported(BSTR cmdID, VARIANT_BOOL* pfRet);
    HRESULT queryCommandEnabled(BSTR cmdID, VARIANT_BOOL* pfRet);
    HRESULT queryCommandState(BSTR cmdID, VARIANT_BOOL* pfRet);
    HRESULT queryCommandIndeterm(BSTR cmdID, VARIANT_BOOL* pfRet);
    HRESULT queryCommandText(BSTR cmdID, BSTR* pcmdText);
    HRESULT queryCommandValue(BSTR cmdID, VARIANT* pcmdValue);
    HRESULT execCommand(BSTR cmdID, VARIANT_BOOL showUI, VARIANT value, VARIANT_BOOL* pfRet);
    HRESULT execCommandShowHelp(BSTR cmdID, VARIANT_BOOL* pfRet);
}

@GUID("3050f40b-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTextRangeMetrics : IDispatch
{
    HRESULT get_offsetTop(int* p);
    HRESULT get_offsetLeft(int* p);
    HRESULT get_boundingTop(int* p);
    HRESULT get_boundingLeft(int* p);
    HRESULT get_boundingWidth(int* p);
    HRESULT get_boundingHeight(int* p);
}

@GUID("3050f4a6-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTextRangeMetrics2 : IDispatch
{
    HRESULT getClientRects(IHTMLRectCollection* pRectCol);
    HRESULT getBoundingClientRect(IHTMLRect* pRect);
}

@GUID("3050f7ed-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTxtRangeCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(VARIANT* pvarIndex, VARIANT* pvarResult);
}

@GUID("305104ae-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDOMRange : IDispatch
{
    HRESULT get_startContainer(IHTMLDOMNode* p);
    HRESULT get_startOffset(int* p);
    HRESULT get_endContainer(IHTMLDOMNode* p);
    HRESULT get_endOffset(int* p);
    HRESULT get_collapsed(VARIANT_BOOL* p);
    HRESULT get_commonAncestorContainer(IHTMLDOMNode* p);
    HRESULT setStart(IDispatch refNode, int offset);
    HRESULT setEnd(IDispatch refNode, int offset);
    HRESULT setStartBefore(IDispatch refNode);
    HRESULT setStartAfter(IDispatch refNode);
    HRESULT setEndBefore(IDispatch refNode);
    HRESULT setEndAfter(IDispatch refNode);
    HRESULT collapse(VARIANT_BOOL toStart);
    HRESULT selectNode(IDispatch refNode);
    HRESULT selectNodeContents(IDispatch refNode);
    HRESULT compareBoundaryPoints(short how, IDispatch sourceRange, int* compareResult);
    HRESULT deleteContents();
    HRESULT extractContents(IDispatch* ppDocumentFragment);
    HRESULT cloneContents(IDispatch* ppDocumentFragment);
    HRESULT insertNode(IDispatch newNode);
    HRESULT surroundContents(IDispatch newParent);
    HRESULT cloneRange(IHTMLDOMRange* ppClonedRange);
    HRESULT toString(BSTR* pRangeString);
    HRESULT detach();
    HRESULT getClientRects(IHTMLRectCollection* ppRectCol);
    HRESULT getBoundingClientRect(IHTMLRect* ppRect);
}

@GUID("3050f5a3-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLDOMRange : IDispatch
{
}

@GUID("3050f614-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLFormElementEvents2 : IDispatch
{
}

@GUID("3050f364-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLFormElementEvents : IDispatch
{
}

@GUID("3050f1f7-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLFormElement : IDispatch
{
    HRESULT put_action(BSTR v);
    HRESULT get_action(BSTR* p);
    HRESULT put_dir(BSTR v);
    HRESULT get_dir(BSTR* p);
    HRESULT put_encoding(BSTR v);
    HRESULT get_encoding(BSTR* p);
    HRESULT put_method(BSTR v);
    HRESULT get_method(BSTR* p);
    HRESULT get_elements(IDispatch* p);
    HRESULT put_target(BSTR v);
    HRESULT get_target(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_onsubmit(VARIANT v);
    HRESULT get_onsubmit(VARIANT* p);
    HRESULT put_onreset(VARIANT v);
    HRESULT get_onreset(VARIANT* p);
    HRESULT submit();
    HRESULT reset();
    HRESULT put_length(int v);
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(VARIANT name, VARIANT index, IDispatch* pdisp);
    HRESULT tags(VARIANT tagName, IDispatch* pdisp);
}

@GUID("3050f4f6-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLFormElement2 : IDispatch
{
    HRESULT put_acceptCharset(BSTR v);
    HRESULT get_acceptCharset(BSTR* p);
    HRESULT urns(VARIANT urn, IDispatch* pdisp);
}

@GUID("3050f836-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLFormElement3 : IDispatch
{
    HRESULT namedItem(BSTR name, IDispatch* pdisp);
}

@GUID("3050f645-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLSubmitData : IDispatch
{
    HRESULT appendNameValuePair(BSTR name, BSTR value);
    HRESULT appendNameFilePair(BSTR name, BSTR filename);
    HRESULT appendItemSeparator();
}

@GUID("3051042c-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLFormElement4 : IDispatch
{
    HRESULT put_action(BSTR v);
    HRESULT get_action(BSTR* p);
}

@GUID("3050f510-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLFormElement : IDispatch
{
}

@GUID("3050f612-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLControlElementEvents2 : IDispatch
{
}

@GUID("3050f4ea-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLControlElementEvents : IDispatch
{
}

@GUID("3050f4e9-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLControlElement : IDispatch
{
    HRESULT put_tabIndex(short v);
    HRESULT get_tabIndex(short* p);
    HRESULT focus();
    HRESULT put_accessKey(BSTR v);
    HRESULT get_accessKey(BSTR* p);
    HRESULT put_onblur(VARIANT v);
    HRESULT get_onblur(VARIANT* p);
    HRESULT put_onfocus(VARIANT v);
    HRESULT get_onfocus(VARIANT* p);
    HRESULT put_onresize(VARIANT v);
    HRESULT get_onresize(VARIANT* p);
    HRESULT blur();
    HRESULT addFilter(IUnknown pUnk);
    HRESULT removeFilter(IUnknown pUnk);
    HRESULT get_clientHeight(int* p);
    HRESULT get_clientWidth(int* p);
    HRESULT get_clientTop(int* p);
    HRESULT get_clientLeft(int* p);
}

@GUID("3050f218-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTextElement : IDispatch
{
}

@GUID("3050f537-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLTextElement : IDispatch
{
}

@GUID("3050f624-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLTextContainerEvents2 : IDispatch
{
}

@GUID("1ff6aa72-5842-11cf-a707-00aa00c0098d")
interface HTMLTextContainerEvents : IDispatch
{
}

@GUID("3050f230-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTextContainer : IDispatch
{
    HRESULT createControlRange(IDispatch* range);
    HRESULT get_scrollHeight(int* p);
    HRESULT get_scrollWidth(int* p);
    HRESULT put_scrollTop(int v);
    HRESULT get_scrollTop(int* p);
    HRESULT put_scrollLeft(int v);
    HRESULT get_scrollLeft(int* p);
    HRESULT put_onscroll(VARIANT v);
    HRESULT get_onscroll(VARIANT* p);
}

@GUID("3050f29c-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLControlRange : IDispatch
{
    HRESULT select();
    HRESULT add(IHTMLControlElement item);
    HRESULT remove(int index);
    HRESULT item(int index, IHTMLElement* pdisp);
    HRESULT scrollIntoView(VARIANT varargStart);
    HRESULT queryCommandSupported(BSTR cmdID, VARIANT_BOOL* pfRet);
    HRESULT queryCommandEnabled(BSTR cmdID, VARIANT_BOOL* pfRet);
    HRESULT queryCommandState(BSTR cmdID, VARIANT_BOOL* pfRet);
    HRESULT queryCommandIndeterm(BSTR cmdID, VARIANT_BOOL* pfRet);
    HRESULT queryCommandText(BSTR cmdID, BSTR* pcmdText);
    HRESULT queryCommandValue(BSTR cmdID, VARIANT* pcmdValue);
    HRESULT execCommand(BSTR cmdID, VARIANT_BOOL showUI, VARIANT value, VARIANT_BOOL* pfRet);
    HRESULT execCommandShowHelp(BSTR cmdID, VARIANT_BOOL* pfRet);
    HRESULT commonParentElement(IHTMLElement* parent);
    HRESULT get_length(int* p);
}

@GUID("3050f65e-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLControlRange2 : IDispatch
{
    HRESULT addElement(IHTMLElement item);
}

@GUID("3050f616-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLImgEvents2 : IDispatch
{
}

@GUID("3050f25b-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLImgEvents : IDispatch
{
}

@GUID("3050f240-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLImgElement : IDispatch
{
    HRESULT put_isMap(VARIANT_BOOL v);
    HRESULT get_isMap(VARIANT_BOOL* p);
    HRESULT put_useMap(BSTR v);
    HRESULT get_useMap(BSTR* p);
    HRESULT get_mimeType(BSTR* p);
    HRESULT get_fileSize(BSTR* p);
    HRESULT get_fileCreatedDate(BSTR* p);
    HRESULT get_fileModifiedDate(BSTR* p);
    HRESULT get_fileUpdatedDate(BSTR* p);
    HRESULT get_protocol(BSTR* p);
    HRESULT get_href(BSTR* p);
    HRESULT get_nameProp(BSTR* p);
    HRESULT put_border(VARIANT v);
    HRESULT get_border(VARIANT* p);
    HRESULT put_vspace(int v);
    HRESULT get_vspace(int* p);
    HRESULT put_hspace(int v);
    HRESULT get_hspace(int* p);
    HRESULT put_alt(BSTR v);
    HRESULT get_alt(BSTR* p);
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_lowsrc(BSTR v);
    HRESULT get_lowsrc(BSTR* p);
    HRESULT put_vrml(BSTR v);
    HRESULT get_vrml(BSTR* p);
    HRESULT put_dynsrc(BSTR v);
    HRESULT get_dynsrc(BSTR* p);
    HRESULT get_readyState(BSTR* p);
    HRESULT get_complete(VARIANT_BOOL* p);
    HRESULT put_loop(VARIANT v);
    HRESULT get_loop(VARIANT* p);
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_onabort(VARIANT v);
    HRESULT get_onabort(VARIANT* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_width(int v);
    HRESULT get_width(int* p);
    HRESULT put_height(int v);
    HRESULT get_height(int* p);
    HRESULT put_start(BSTR v);
    HRESULT get_start(BSTR* p);
}

@GUID("3050f826-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLImgElement2 : IDispatch
{
    HRESULT put_longDesc(BSTR v);
    HRESULT get_longDesc(BSTR* p);
}

@GUID("30510434-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLImgElement3 : IDispatch
{
    HRESULT put_longDesc(BSTR v);
    HRESULT get_longDesc(BSTR* p);
    HRESULT put_vrml(BSTR v);
    HRESULT get_vrml(BSTR* p);
    HRESULT put_lowsrc(BSTR v);
    HRESULT get_lowsrc(BSTR* p);
    HRESULT put_dynsrc(BSTR v);
    HRESULT get_dynsrc(BSTR* p);
}

@GUID("305107f6-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLImgElement4 : IDispatch
{
    HRESULT get_naturalWidth(int* p);
    HRESULT get_naturalHeight(int* p);
}

@GUID("30510793-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLMSImgElement : IDispatch
{
    HRESULT put_msPlayToDisabled(VARIANT_BOOL v);
    HRESULT get_msPlayToDisabled(VARIANT_BOOL* p);
    HRESULT put_msPlayToPrimary(VARIANT_BOOL v);
    HRESULT get_msPlayToPrimary(VARIANT_BOOL* p);
}

@GUID("3050f38e-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLImageElementFactory : IDispatch
{
    HRESULT create(VARIANT width, VARIANT height, IHTMLImgElement* __MIDL__IHTMLImageElementFactory0000);
}

@GUID("3050f51c-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLImg : IDispatch
{
}

@GUID("3050f1d8-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLBodyElement : IDispatch
{
    HRESULT put_background(BSTR v);
    HRESULT get_background(BSTR* p);
    HRESULT put_bgProperties(BSTR v);
    HRESULT get_bgProperties(BSTR* p);
    HRESULT put_leftMargin(VARIANT v);
    HRESULT get_leftMargin(VARIANT* p);
    HRESULT put_topMargin(VARIANT v);
    HRESULT get_topMargin(VARIANT* p);
    HRESULT put_rightMargin(VARIANT v);
    HRESULT get_rightMargin(VARIANT* p);
    HRESULT put_bottomMargin(VARIANT v);
    HRESULT get_bottomMargin(VARIANT* p);
    HRESULT put_noWrap(VARIANT_BOOL v);
    HRESULT get_noWrap(VARIANT_BOOL* p);
    HRESULT put_bgColor(VARIANT v);
    HRESULT get_bgColor(VARIANT* p);
    HRESULT put_text(VARIANT v);
    HRESULT get_text(VARIANT* p);
    HRESULT put_link(VARIANT v);
    HRESULT get_link(VARIANT* p);
    HRESULT put_vLink(VARIANT v);
    HRESULT get_vLink(VARIANT* p);
    HRESULT put_aLink(VARIANT v);
    HRESULT get_aLink(VARIANT* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onunload(VARIANT v);
    HRESULT get_onunload(VARIANT* p);
    HRESULT put_scroll(BSTR v);
    HRESULT get_scroll(BSTR* p);
    HRESULT put_onselect(VARIANT v);
    HRESULT get_onselect(VARIANT* p);
    HRESULT put_onbeforeunload(VARIANT v);
    HRESULT get_onbeforeunload(VARIANT* p);
    HRESULT createTextRange(IHTMLTxtRange* range);
}

@GUID("3050f5c5-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLBodyElement2 : IDispatch
{
    HRESULT put_onbeforeprint(VARIANT v);
    HRESULT get_onbeforeprint(VARIANT* p);
    HRESULT put_onafterprint(VARIANT v);
    HRESULT get_onafterprint(VARIANT* p);
}

@GUID("30510422-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLBodyElement3 : IDispatch
{
    HRESULT put_background(BSTR v);
    HRESULT get_background(BSTR* p);
    HRESULT put_ononline(VARIANT v);
    HRESULT get_ononline(VARIANT* p);
    HRESULT put_onoffline(VARIANT v);
    HRESULT get_onoffline(VARIANT* p);
    HRESULT put_onhashchange(VARIANT v);
    HRESULT get_onhashchange(VARIANT* p);
}

@GUID("30510795-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLBodyElement4 : IDispatch
{
    HRESULT put_onmessage(VARIANT v);
    HRESULT get_onmessage(VARIANT* p);
    HRESULT put_onstorage(VARIANT v);
    HRESULT get_onstorage(VARIANT* p);
}

@GUID("30510822-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLBodyElement5 : IDispatch
{
    HRESULT put_onpopstate(VARIANT v);
    HRESULT get_onpopstate(VARIANT* p);
}

@GUID("3050f507-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLBody : IDispatch
{
}

@GUID("3050f1d9-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLFontElement : IDispatch
{
    HRESULT put_color(VARIANT v);
    HRESULT get_color(VARIANT* p);
    HRESULT put_face(BSTR v);
    HRESULT get_face(BSTR* p);
    HRESULT put_size(VARIANT v);
    HRESULT get_size(VARIANT* p);
}

@GUID("3050f512-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLFontElement : IDispatch
{
}

@GUID("3050f610-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLAnchorEvents2 : IDispatch
{
}

@GUID("3050f29d-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLAnchorEvents : IDispatch
{
}

@GUID("3050f1da-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLAnchorElement : IDispatch
{
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
    HRESULT put_target(BSTR v);
    HRESULT get_target(BSTR* p);
    HRESULT put_rel(BSTR v);
    HRESULT get_rel(BSTR* p);
    HRESULT put_rev(BSTR v);
    HRESULT get_rev(BSTR* p);
    HRESULT put_urn(BSTR v);
    HRESULT get_urn(BSTR* p);
    HRESULT put_Methods(BSTR v);
    HRESULT get_Methods(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_host(BSTR v);
    HRESULT get_host(BSTR* p);
    HRESULT put_hostname(BSTR v);
    HRESULT get_hostname(BSTR* p);
    HRESULT put_pathname(BSTR v);
    HRESULT get_pathname(BSTR* p);
    HRESULT put_port(BSTR v);
    HRESULT get_port(BSTR* p);
    HRESULT put_protocol(BSTR v);
    HRESULT get_protocol(BSTR* p);
    HRESULT put_search(BSTR v);
    HRESULT get_search(BSTR* p);
    HRESULT put_hash(BSTR v);
    HRESULT get_hash(BSTR* p);
    HRESULT put_onblur(VARIANT v);
    HRESULT get_onblur(VARIANT* p);
    HRESULT put_onfocus(VARIANT v);
    HRESULT get_onfocus(VARIANT* p);
    HRESULT put_accessKey(BSTR v);
    HRESULT get_accessKey(BSTR* p);
    HRESULT get_protocolLong(BSTR* p);
    HRESULT get_mimeType(BSTR* p);
    HRESULT get_nameProp(BSTR* p);
    HRESULT put_tabIndex(short v);
    HRESULT get_tabIndex(short* p);
    HRESULT focus();
    HRESULT blur();
}

@GUID("3050f825-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLAnchorElement2 : IDispatch
{
    HRESULT put_charset(BSTR v);
    HRESULT get_charset(BSTR* p);
    HRESULT put_coords(BSTR v);
    HRESULT get_coords(BSTR* p);
    HRESULT put_hreflang(BSTR v);
    HRESULT get_hreflang(BSTR* p);
    HRESULT put_shape(BSTR v);
    HRESULT get_shape(BSTR* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
}

@GUID("3051041d-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLAnchorElement3 : IDispatch
{
    HRESULT put_shape(BSTR v);
    HRESULT get_shape(BSTR* p);
    HRESULT put_coords(BSTR v);
    HRESULT get_coords(BSTR* p);
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
}

@GUID("3050f502-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLAnchorElement : IDispatch
{
}

@GUID("3050f61c-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLLabelEvents2 : IDispatch
{
}

@GUID("3050f329-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLLabelEvents : IDispatch
{
}

@GUID("3050f32a-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLLabelElement : IDispatch
{
    HRESULT put_htmlFor(BSTR v);
    HRESULT get_htmlFor(BSTR* p);
    HRESULT put_accessKey(BSTR v);
    HRESULT get_accessKey(BSTR* p);
}

@GUID("3050f832-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLLabelElement2 : IDispatch
{
    HRESULT get_form(IHTMLFormElement* p);
}

@GUID("3050f522-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLLabelElement : IDispatch
{
}

@GUID("3050f20e-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLListElement : IDispatch
{
}

@GUID("3050f822-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLListElement2 : IDispatch
{
    HRESULT put_compact(VARIANT_BOOL v);
    HRESULT get_compact(VARIANT_BOOL* p);
}

@GUID("3050f525-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLListElement : IDispatch
{
}

@GUID("3050f1dd-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLUListElement : IDispatch
{
    HRESULT put_compact(VARIANT_BOOL v);
    HRESULT get_compact(VARIANT_BOOL* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
}

@GUID("3050f538-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLUListElement : IDispatch
{
}

@GUID("3050f1de-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLOListElement : IDispatch
{
    HRESULT put_compact(VARIANT_BOOL v);
    HRESULT get_compact(VARIANT_BOOL* p);
    HRESULT put_start(int v);
    HRESULT get_start(int* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
}

@GUID("3050f52a-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLOListElement : IDispatch
{
}

@GUID("3050f1e0-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLLIElement : IDispatch
{
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT put_value(int v);
    HRESULT get_value(int* p);
}

@GUID("3050f523-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLLIElement : IDispatch
{
}

@GUID("3050f208-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLBlockElement : IDispatch
{
    HRESULT put_clear(BSTR v);
    HRESULT get_clear(BSTR* p);
}

@GUID("3050f823-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLBlockElement2 : IDispatch
{
    HRESULT put_cite(BSTR v);
    HRESULT get_cite(BSTR* p);
    HRESULT put_width(BSTR v);
    HRESULT get_width(BSTR* p);
}

@GUID("30510494-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLBlockElement3 : IDispatch
{
    HRESULT put_cite(BSTR v);
    HRESULT get_cite(BSTR* p);
}

@GUID("3050f506-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLBlockElement : IDispatch
{
}

@GUID("3050f200-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDivElement : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_noWrap(VARIANT_BOOL v);
    HRESULT get_noWrap(VARIANT_BOOL* p);
}

@GUID("3050f50c-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLDivElement : IDispatch
{
}

@GUID("3050f1f2-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDDElement : IDispatch
{
    HRESULT put_noWrap(VARIANT_BOOL v);
    HRESULT get_noWrap(VARIANT_BOOL* p);
}

@GUID("3050f50b-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLDDElement : IDispatch
{
}

@GUID("3050f1f3-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDTElement : IDispatch
{
    HRESULT put_noWrap(VARIANT_BOOL v);
    HRESULT get_noWrap(VARIANT_BOOL* p);
}

@GUID("3050f50d-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLDTElement : IDispatch
{
}

@GUID("3050f1f0-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLBRElement : IDispatch
{
    HRESULT put_clear(BSTR v);
    HRESULT get_clear(BSTR* p);
}

@GUID("3050f53a-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLBRElement : IDispatch
{
}

@GUID("3050f1f1-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDListElement : IDispatch
{
    HRESULT put_compact(VARIANT_BOOL v);
    HRESULT get_compact(VARIANT_BOOL* p);
}

@GUID("3050f53b-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLDListElement : IDispatch
{
}

@GUID("3050f1f4-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLHRElement : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_color(VARIANT v);
    HRESULT get_color(VARIANT* p);
    HRESULT put_noShade(VARIANT_BOOL v);
    HRESULT get_noShade(VARIANT_BOOL* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_size(VARIANT v);
    HRESULT get_size(VARIANT* p);
}

@GUID("3050f53d-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLHRElement : IDispatch
{
}

@GUID("3050f1f5-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLParaElement : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
}

@GUID("3050f52c-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLParaElement : IDispatch
{
}

@GUID("3050f5ee-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLElementCollection2 : IDispatch
{
    HRESULT urns(VARIANT urn, IDispatch* pdisp);
}

@GUID("3050f835-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLElementCollection3 : IDispatch
{
    HRESULT namedItem(BSTR name, IDispatch* pdisp);
}

@GUID("30510425-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLElementCollection4 : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT item(int index, IHTMLElement2* pNode);
    HRESULT namedItem(BSTR name, IHTMLElement2* pNode);
}

@GUID("3050f56b-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLElementCollection : IDispatch
{
}

@GUID("3050f1f6-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLHeaderElement : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
}

@GUID("3050f515-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLHeaderElement : IDispatch
{
}

@GUID("3050f622-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLSelectElementEvents2 : IDispatch
{
}

@GUID("3050f302-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLSelectElementEvents : IDispatch
{
}

@GUID("3050f211-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLOptionElement : IDispatch
{
    HRESULT put_selected(VARIANT_BOOL v);
    HRESULT get_selected(VARIANT_BOOL* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_defaultSelected(VARIANT_BOOL v);
    HRESULT get_defaultSelected(VARIANT_BOOL* p);
    HRESULT put_index(int v);
    HRESULT get_index(int* p);
    HRESULT put_text(BSTR v);
    HRESULT get_text(BSTR* p);
    HRESULT get_form(IHTMLFormElement* p);
}

@GUID("3050f2d1-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLSelectElementEx : IUnknown
{
    HRESULT ShowDropdown(BOOL fShow);
    HRESULT SetSelectExFlags(uint lFlags);
    HRESULT GetSelectExFlags(uint* pFlags);
    HRESULT GetDropdownOpen(BOOL* pfOpen);
}

@GUID("3050f244-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLSelectElement : IDispatch
{
    HRESULT put_size(int v);
    HRESULT get_size(int* p);
    HRESULT put_multiple(VARIANT_BOOL v);
    HRESULT get_multiple(VARIANT_BOOL* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT get_options(IDispatch* p);
    HRESULT put_onchange(VARIANT v);
    HRESULT get_onchange(VARIANT* p);
    HRESULT put_selectedIndex(int v);
    HRESULT get_selectedIndex(int* p);
    HRESULT get_type(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_disabled(VARIANT_BOOL v);
    HRESULT get_disabled(VARIANT_BOOL* p);
    HRESULT get_form(IHTMLFormElement* p);
    HRESULT add(IHTMLElement element, VARIANT before);
    HRESULT remove(int index);
    HRESULT put_length(int v);
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(VARIANT name, VARIANT index, IDispatch* pdisp);
    HRESULT tags(VARIANT tagName, IDispatch* pdisp);
}

@GUID("3050f5ed-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLSelectElement2 : IDispatch
{
    HRESULT urns(VARIANT urn, IDispatch* pdisp);
}

@GUID("3050f838-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLSelectElement4 : IDispatch
{
    HRESULT namedItem(BSTR name, IDispatch* pdisp);
}

@GUID("3051049d-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLSelectElement5 : IDispatch
{
    HRESULT add(IHTMLOptionElement pElem, VARIANT* pvarBefore);
}

@GUID("30510760-98b6-11cf-bb82-00aa00bdce0b")
interface IHTMLSelectElement6 : IDispatch
{
    HRESULT add(IHTMLOptionElement pElem, VARIANT* pvarBefore);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
}

@GUID("3050f531-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLSelectElement : IDispatch
{
}

@GUID("3050f597-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLWndSelectElement : IDispatch
{
}

@GUID("3050f25a-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLSelectionObject : IDispatch
{
    HRESULT createRange(IDispatch* range);
    HRESULT empty();
    HRESULT clear();
    HRESULT get_type(BSTR* p);
}

@GUID("3050f7ec-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLSelectionObject2 : IDispatch
{
    HRESULT createRangeCollection(IDispatch* rangeCollection);
    HRESULT get_typeDetail(BSTR* p);
}

@GUID("305104b6-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLSelection : IDispatch
{
    HRESULT get_anchorNode(IHTMLDOMNode* p);
    HRESULT get_anchorOffset(int* p);
    HRESULT get_focusNode(IHTMLDOMNode* p);
    HRESULT get_focusOffset(int* p);
    HRESULT get_isCollapsed(VARIANT_BOOL* p);
    HRESULT collapse(IDispatch parentNode, int offfset);
    HRESULT collapseToStart();
    HRESULT collapseToEnd();
    HRESULT selectAllChildren(IDispatch parentNode);
    HRESULT deleteFromDocument();
    HRESULT get_rangeCount(int* p);
    HRESULT getRangeAt(int index, IHTMLDOMRange* ppRange);
    HRESULT addRange(IDispatch range);
    HRESULT removeRange(IDispatch range);
    HRESULT removeAllRanges();
    HRESULT toString(BSTR* pSelectionString);
}

@GUID("3050f820-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLOptionElement3 : IDispatch
{
    HRESULT put_label(BSTR v);
    HRESULT get_label(BSTR* p);
}

@GUID("305107b4-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLOptionElement4 : IDispatch
{
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
}

@GUID("3050f38c-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLOptionElementFactory : IDispatch
{
    HRESULT create(VARIANT text, VARIANT value, VARIANT defaultselected, VARIANT selected, 
                   IHTMLOptionElement* __MIDL__IHTMLOptionElementFactory0000);
}

@GUID("3050f52b-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLOptionElement : IDispatch
{
}

@GUID("3050f598-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLWndOptionElement : IDispatch
{
}

@GUID("3050f617-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLButtonElementEvents2 : IDispatch
{
}

@GUID("3050f2b3-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLButtonElementEvents : IDispatch
{
}

@GUID("3050f618-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLInputTextElementEvents2 : IDispatch
{
}

@GUID("3050f619-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLOptionButtonElementEvents2 : IDispatch
{
}

@GUID("3050f61a-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLInputFileElementEvents2 : IDispatch
{
}

@GUID("3050f61b-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLInputImageEvents2 : IDispatch
{
}

@GUID("3050f2a7-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLInputTextElementEvents : IDispatch
{
}

@GUID("3050f2bd-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLOptionButtonElementEvents : IDispatch
{
}

@GUID("3050f2af-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLInputFileElementEvents : IDispatch
{
}

@GUID("3050f2c3-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLInputImageEvents : IDispatch
{
}

@GUID("3050f5d2-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLInputElement : IDispatch
{
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_status(VARIANT_BOOL v);
    HRESULT get_status(VARIANT_BOOL* p);
    HRESULT put_disabled(VARIANT_BOOL v);
    HRESULT get_disabled(VARIANT_BOOL* p);
    HRESULT get_form(IHTMLFormElement* p);
    HRESULT put_size(int v);
    HRESULT get_size(int* p);
    HRESULT put_maxLength(int v);
    HRESULT get_maxLength(int* p);
    HRESULT select();
    HRESULT put_onchange(VARIANT v);
    HRESULT get_onchange(VARIANT* p);
    HRESULT put_onselect(VARIANT v);
    HRESULT get_onselect(VARIANT* p);
    HRESULT put_defaultValue(BSTR v);
    HRESULT get_defaultValue(BSTR* p);
    HRESULT put_readOnly(VARIANT_BOOL v);
    HRESULT get_readOnly(VARIANT_BOOL* p);
    HRESULT createTextRange(IHTMLTxtRange* range);
    HRESULT put_indeterminate(VARIANT_BOOL v);
    HRESULT get_indeterminate(VARIANT_BOOL* p);
    HRESULT put_defaultChecked(VARIANT_BOOL v);
    HRESULT get_defaultChecked(VARIANT_BOOL* p);
    HRESULT put_checked(VARIANT_BOOL v);
    HRESULT get_checked(VARIANT_BOOL* p);
    HRESULT put_border(VARIANT v);
    HRESULT get_border(VARIANT* p);
    HRESULT put_vspace(int v);
    HRESULT get_vspace(int* p);
    HRESULT put_hspace(int v);
    HRESULT get_hspace(int* p);
    HRESULT put_alt(BSTR v);
    HRESULT get_alt(BSTR* p);
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_lowsrc(BSTR v);
    HRESULT get_lowsrc(BSTR* p);
    HRESULT put_vrml(BSTR v);
    HRESULT get_vrml(BSTR* p);
    HRESULT put_dynsrc(BSTR v);
    HRESULT get_dynsrc(BSTR* p);
    HRESULT get_readyState(BSTR* p);
    HRESULT get_complete(VARIANT_BOOL* p);
    HRESULT put_loop(VARIANT v);
    HRESULT get_loop(VARIANT* p);
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_onabort(VARIANT v);
    HRESULT get_onabort(VARIANT* p);
    HRESULT put_width(int v);
    HRESULT get_width(int* p);
    HRESULT put_height(int v);
    HRESULT get_height(int* p);
    HRESULT put_start(BSTR v);
    HRESULT get_start(BSTR* p);
}

@GUID("3050f821-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLInputElement2 : IDispatch
{
    HRESULT put_accept(BSTR v);
    HRESULT get_accept(BSTR* p);
    HRESULT put_useMap(BSTR v);
    HRESULT get_useMap(BSTR* p);
}

@GUID("30510435-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLInputElement3 : IDispatch
{
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_lowsrc(BSTR v);
    HRESULT get_lowsrc(BSTR* p);
    HRESULT put_vrml(BSTR v);
    HRESULT get_vrml(BSTR* p);
    HRESULT put_dynsrc(BSTR v);
    HRESULT get_dynsrc(BSTR* p);
}

@GUID("3050f2b2-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLInputButtonElement : IDispatch
{
    HRESULT get_type(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_status(VARIANT v);
    HRESULT get_status(VARIANT* p);
    HRESULT put_disabled(VARIANT_BOOL v);
    HRESULT get_disabled(VARIANT_BOOL* p);
    HRESULT get_form(IHTMLFormElement* p);
    HRESULT createTextRange(IHTMLTxtRange* range);
}

@GUID("3050f2a4-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLInputHiddenElement : IDispatch
{
    HRESULT get_type(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_status(VARIANT v);
    HRESULT get_status(VARIANT* p);
    HRESULT put_disabled(VARIANT_BOOL v);
    HRESULT get_disabled(VARIANT_BOOL* p);
    HRESULT get_form(IHTMLFormElement* p);
    HRESULT createTextRange(IHTMLTxtRange* range);
}

@GUID("3050f2a6-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLInputTextElement : IDispatch
{
    HRESULT get_type(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_status(VARIANT v);
    HRESULT get_status(VARIANT* p);
    HRESULT put_disabled(VARIANT_BOOL v);
    HRESULT get_disabled(VARIANT_BOOL* p);
    HRESULT get_form(IHTMLFormElement* p);
    HRESULT put_defaultValue(BSTR v);
    HRESULT get_defaultValue(BSTR* p);
    HRESULT put_size(int v);
    HRESULT get_size(int* p);
    HRESULT put_maxLength(int v);
    HRESULT get_maxLength(int* p);
    HRESULT select();
    HRESULT put_onchange(VARIANT v);
    HRESULT get_onchange(VARIANT* p);
    HRESULT put_onselect(VARIANT v);
    HRESULT get_onselect(VARIANT* p);
    HRESULT put_readOnly(VARIANT_BOOL v);
    HRESULT get_readOnly(VARIANT_BOOL* p);
    HRESULT createTextRange(IHTMLTxtRange* range);
}

@GUID("3050f2d2-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLInputTextElement2 : IDispatch
{
    HRESULT put_selectionStart(int v);
    HRESULT get_selectionStart(int* p);
    HRESULT put_selectionEnd(int v);
    HRESULT get_selectionEnd(int* p);
    HRESULT setSelectionRange(int start, int end);
}

@GUID("3050f2ad-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLInputFileElement : IDispatch
{
    HRESULT get_type(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_status(VARIANT v);
    HRESULT get_status(VARIANT* p);
    HRESULT put_disabled(VARIANT_BOOL v);
    HRESULT get_disabled(VARIANT_BOOL* p);
    HRESULT get_form(IHTMLFormElement* p);
    HRESULT put_size(int v);
    HRESULT get_size(int* p);
    HRESULT put_maxLength(int v);
    HRESULT get_maxLength(int* p);
    HRESULT select();
    HRESULT put_onchange(VARIANT v);
    HRESULT get_onchange(VARIANT* p);
    HRESULT put_onselect(VARIANT v);
    HRESULT get_onselect(VARIANT* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
}

@GUID("3050f2bc-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLOptionButtonElement : IDispatch
{
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT get_type(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_checked(VARIANT_BOOL v);
    HRESULT get_checked(VARIANT_BOOL* p);
    HRESULT put_defaultChecked(VARIANT_BOOL v);
    HRESULT get_defaultChecked(VARIANT_BOOL* p);
    HRESULT put_onchange(VARIANT v);
    HRESULT get_onchange(VARIANT* p);
    HRESULT put_disabled(VARIANT_BOOL v);
    HRESULT get_disabled(VARIANT_BOOL* p);
    HRESULT put_status(VARIANT_BOOL v);
    HRESULT get_status(VARIANT_BOOL* p);
    HRESULT put_indeterminate(VARIANT_BOOL v);
    HRESULT get_indeterminate(VARIANT_BOOL* p);
    HRESULT get_form(IHTMLFormElement* p);
}

@GUID("3050f2c2-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLInputImage : IDispatch
{
    HRESULT get_type(BSTR* p);
    HRESULT put_disabled(VARIANT_BOOL v);
    HRESULT get_disabled(VARIANT_BOOL* p);
    HRESULT put_border(VARIANT v);
    HRESULT get_border(VARIANT* p);
    HRESULT put_vspace(int v);
    HRESULT get_vspace(int* p);
    HRESULT put_hspace(int v);
    HRESULT get_hspace(int* p);
    HRESULT put_alt(BSTR v);
    HRESULT get_alt(BSTR* p);
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_lowsrc(BSTR v);
    HRESULT get_lowsrc(BSTR* p);
    HRESULT put_vrml(BSTR v);
    HRESULT get_vrml(BSTR* p);
    HRESULT put_dynsrc(BSTR v);
    HRESULT get_dynsrc(BSTR* p);
    HRESULT get_readyState(BSTR* p);
    HRESULT get_complete(VARIANT_BOOL* p);
    HRESULT put_loop(VARIANT v);
    HRESULT get_loop(VARIANT* p);
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_onabort(VARIANT v);
    HRESULT get_onabort(VARIANT* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_width(int v);
    HRESULT get_width(int* p);
    HRESULT put_height(int v);
    HRESULT get_height(int* p);
    HRESULT put_start(BSTR v);
    HRESULT get_start(BSTR* p);
}

@GUID("3050f2d4-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLInputRangeElement : IDispatch
{
    HRESULT put_disabled(VARIANT_BOOL v);
    HRESULT get_disabled(VARIANT_BOOL* p);
    HRESULT get_type(BSTR* p);
    HRESULT put_alt(BSTR v);
    HRESULT get_alt(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_min(BSTR v);
    HRESULT get_min(BSTR* p);
    HRESULT put_max(BSTR v);
    HRESULT get_max(BSTR* p);
    HRESULT put_step(BSTR v);
    HRESULT get_step(BSTR* p);
    HRESULT put_valueAsNumber(double v);
    HRESULT get_valueAsNumber(double* p);
    HRESULT stepUp(int n);
    HRESULT stepDown(int n);
}

@GUID("3050f57d-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLInputElement : IDispatch
{
}

@GUID("3050f2aa-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTextAreaElement : IDispatch
{
    HRESULT get_type(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_status(VARIANT v);
    HRESULT get_status(VARIANT* p);
    HRESULT put_disabled(VARIANT_BOOL v);
    HRESULT get_disabled(VARIANT_BOOL* p);
    HRESULT get_form(IHTMLFormElement* p);
    HRESULT put_defaultValue(BSTR v);
    HRESULT get_defaultValue(BSTR* p);
    HRESULT select();
    HRESULT put_onchange(VARIANT v);
    HRESULT get_onchange(VARIANT* p);
    HRESULT put_onselect(VARIANT v);
    HRESULT get_onselect(VARIANT* p);
    HRESULT put_readOnly(VARIANT_BOOL v);
    HRESULT get_readOnly(VARIANT_BOOL* p);
    HRESULT put_rows(int v);
    HRESULT get_rows(int* p);
    HRESULT put_cols(int v);
    HRESULT get_cols(int* p);
    HRESULT put_wrap(BSTR v);
    HRESULT get_wrap(BSTR* p);
    HRESULT createTextRange(IHTMLTxtRange* range);
}

@GUID("3050f2d3-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTextAreaElement2 : IDispatch
{
    HRESULT put_selectionStart(int v);
    HRESULT get_selectionStart(int* p);
    HRESULT put_selectionEnd(int v);
    HRESULT get_selectionEnd(int* p);
    HRESULT setSelectionRange(int start, int end);
}

@GUID("3050f521-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLTextAreaElement : IDispatch
{
}

@GUID("3050f54d-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLRichtextElement : IDispatch
{
}

@GUID("3050f2bb-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLButtonElement : IDispatch
{
    HRESULT get_type(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_status(VARIANT v);
    HRESULT get_status(VARIANT* p);
    HRESULT put_disabled(VARIANT_BOOL v);
    HRESULT get_disabled(VARIANT_BOOL* p);
    HRESULT get_form(IHTMLFormElement* p);
    HRESULT createTextRange(IHTMLTxtRange* range);
}

@GUID("305106f3-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLButtonElement2 : IDispatch
{
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
}

@GUID("3050f51f-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLButtonElement : IDispatch
{
}

@GUID("3050f61f-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLMarqueeElementEvents2 : IDispatch
{
}

@GUID("3050f2b8-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLMarqueeElementEvents : IDispatch
{
}

@GUID("3050f2b5-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLMarqueeElement : IDispatch
{
    HRESULT put_bgColor(VARIANT v);
    HRESULT get_bgColor(VARIANT* p);
    HRESULT put_scrollDelay(int v);
    HRESULT get_scrollDelay(int* p);
    HRESULT put_direction(BSTR v);
    HRESULT get_direction(BSTR* p);
    HRESULT put_behavior(BSTR v);
    HRESULT get_behavior(BSTR* p);
    HRESULT put_scrollAmount(int v);
    HRESULT get_scrollAmount(int* p);
    HRESULT put_loop(int v);
    HRESULT get_loop(int* p);
    HRESULT put_vspace(int v);
    HRESULT get_vspace(int* p);
    HRESULT put_hspace(int v);
    HRESULT get_hspace(int* p);
    HRESULT put_onfinish(VARIANT v);
    HRESULT get_onfinish(VARIANT* p);
    HRESULT put_onstart(VARIANT v);
    HRESULT get_onstart(VARIANT* p);
    HRESULT put_onbounce(VARIANT v);
    HRESULT get_onbounce(VARIANT* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
    HRESULT put_trueSpeed(VARIANT_BOOL v);
    HRESULT get_trueSpeed(VARIANT_BOOL* p);
    HRESULT start();
    HRESULT stop();
}

@GUID("3050f527-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLMarqueeElement : IDispatch
{
}

@GUID("3050f81c-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLHtmlElement : IDispatch
{
    HRESULT put_version(BSTR v);
    HRESULT get_version(BSTR* p);
}

@GUID("3050f81d-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLHeadElement : IDispatch
{
    HRESULT put_profile(BSTR v);
    HRESULT get_profile(BSTR* p);
}

@GUID("3051042f-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLHeadElement2 : IDispatch
{
    HRESULT put_profile(BSTR v);
    HRESULT get_profile(BSTR* p);
}

@GUID("3050f322-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTitleElement : IDispatch
{
    HRESULT put_text(BSTR v);
    HRESULT get_text(BSTR* p);
}

@GUID("3050f203-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLMetaElement : IDispatch
{
    HRESULT put_httpEquiv(BSTR v);
    HRESULT get_httpEquiv(BSTR* p);
    HRESULT put_content(BSTR v);
    HRESULT get_content(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_url(BSTR v);
    HRESULT get_url(BSTR* p);
    HRESULT put_charset(BSTR v);
    HRESULT get_charset(BSTR* p);
}

@GUID("3050f81f-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLMetaElement2 : IDispatch
{
    HRESULT put_scheme(BSTR v);
    HRESULT get_scheme(BSTR* p);
}

@GUID("30510495-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLMetaElement3 : IDispatch
{
    HRESULT put_url(BSTR v);
    HRESULT get_url(BSTR* p);
}

@GUID("3050f204-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLBaseElement : IDispatch
{
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
    HRESULT put_target(BSTR v);
    HRESULT get_target(BSTR* p);
}

@GUID("30510420-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLBaseElement2 : IDispatch
{
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
}

@GUID("3050f560-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLHtmlElement : IDispatch
{
}

@GUID("3050f561-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLHeadElement : IDispatch
{
}

@GUID("3050f516-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLTitleElement : IDispatch
{
}

@GUID("3050f517-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLMetaElement : IDispatch
{
}

@GUID("3050f518-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLBaseElement : IDispatch
{
}

@GUID("3050f206-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLIsIndexElement : IDispatch
{
    HRESULT put_prompt(BSTR v);
    HRESULT get_prompt(BSTR* p);
    HRESULT put_action(BSTR v);
    HRESULT get_action(BSTR* p);
}

@GUID("3050f82f-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLIsIndexElement2 : IDispatch
{
    HRESULT get_form(IHTMLFormElement* p);
}

@GUID("3050f207-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLNextIdElement : IDispatch
{
    HRESULT put_n(BSTR v);
    HRESULT get_n(BSTR* p);
}

@GUID("3050f519-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLIsIndexElement : IDispatch
{
}

@GUID("3050f51a-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLNextIdElement : IDispatch
{
}

@GUID("3050f202-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLBaseFontElement : IDispatch
{
    HRESULT put_color(VARIANT v);
    HRESULT get_color(VARIANT* p);
    HRESULT put_face(BSTR v);
    HRESULT get_face(BSTR* p);
    HRESULT put_size(int v);
    HRESULT get_size(int* p);
}

@GUID("3050f504-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLBaseFontElement : IDispatch
{
}

@GUID("3050f209-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLUnknownElement : IDispatch
{
}

@GUID("3050f539-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLUnknownElement : IDispatch
{
}

@GUID("305107c5-98b5-11cf-bb82-00aa00bdce0b")
interface IWebGeolocation : IDispatch
{
    HRESULT getCurrentPosition(IDispatch successCallback, IDispatch errorCallback, IDispatch options);
    HRESULT watchPosition(IDispatch successCallback, IDispatch errorCallback, IDispatch options, int* watchId);
    HRESULT clearWatch(int watchId);
}

@GUID("3050f3fc-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLMimeTypesCollection : IDispatch
{
    HRESULT get_length(int* p);
}

@GUID("3050f3fd-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLPluginsCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT refresh(VARIANT_BOOL reload);
}

@GUID("feceaaa2-8405-11cf-8ba1-00aa00476da6")
interface IOmHistory : IDispatch
{
    HRESULT get_length(short* p);
    HRESULT back(VARIANT* pvargdistance);
    HRESULT forward(VARIANT* pvargdistance);
    HRESULT go(VARIANT* pvargdistance);
}

@GUID("3050f401-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLOpsProfile : IDispatch
{
    HRESULT addRequest(BSTR name, VARIANT reserved, VARIANT_BOOL* success);
    HRESULT clearRequest();
    HRESULT doRequest(VARIANT usage, VARIANT fname, VARIANT domain, VARIANT path, VARIANT expire, VARIANT reserved);
    HRESULT getAttribute(BSTR name, BSTR* value);
    HRESULT setAttribute(BSTR name, BSTR value, VARIANT prefs, VARIANT_BOOL* success);
    HRESULT commitChanges(VARIANT_BOOL* success);
    HRESULT addReadRequest(BSTR name, VARIANT reserved, VARIANT_BOOL* success);
    HRESULT doReadRequest(VARIANT usage, VARIANT fname, VARIANT domain, VARIANT path, VARIANT expire, 
                          VARIANT reserved);
    HRESULT doWriteRequest(VARIANT_BOOL* success);
}

@GUID("feceaaa5-8405-11cf-8ba1-00aa00476da6")
interface IOmNavigator : IDispatch
{
    HRESULT get_appCodeName(BSTR* p);
    HRESULT get_appName(BSTR* p);
    HRESULT get_appVersion(BSTR* p);
    HRESULT get_userAgent(BSTR* p);
    HRESULT javaEnabled(VARIANT_BOOL* enabled);
    HRESULT taintEnabled(VARIANT_BOOL* enabled);
    HRESULT get_mimeTypes(IHTMLMimeTypesCollection* p);
    HRESULT get_plugins(IHTMLPluginsCollection* p);
    HRESULT get_cookieEnabled(VARIANT_BOOL* p);
    HRESULT get_opsProfile(IHTMLOpsProfile* p);
    HRESULT toString(BSTR* string);
    HRESULT get_cpuClass(BSTR* p);
    HRESULT get_systemLanguage(BSTR* p);
    HRESULT get_browserLanguage(BSTR* p);
    HRESULT get_userLanguage(BSTR* p);
    HRESULT get_platform(BSTR* p);
    HRESULT get_appMinorVersion(BSTR* p);
    HRESULT get_connectionSpeed(int* p);
    HRESULT get_onLine(VARIANT_BOOL* p);
    HRESULT get_userProfile(IHTMLOpsProfile* p);
}

@GUID("305107cf-98b5-11cf-bb82-00aa00bdce0b")
interface INavigatorGeolocation : IDispatch
{
    HRESULT get_geolocation(IWebGeolocation* p);
}

@GUID("30510804-98b5-11cf-bb82-00aa00bdce0b")
interface INavigatorDoNotTrack : IDispatch
{
    HRESULT get_msDoNotTrack(BSTR* p);
}

@GUID("163bb1e0-6e00-11cf-837a-48dc04c10000")
interface IHTMLLocation : IDispatch
{
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
    HRESULT put_protocol(BSTR v);
    HRESULT get_protocol(BSTR* p);
    HRESULT put_host(BSTR v);
    HRESULT get_host(BSTR* p);
    HRESULT put_hostname(BSTR v);
    HRESULT get_hostname(BSTR* p);
    HRESULT put_port(BSTR v);
    HRESULT get_port(BSTR* p);
    HRESULT put_pathname(BSTR v);
    HRESULT get_pathname(BSTR* p);
    HRESULT put_search(BSTR v);
    HRESULT get_search(BSTR* p);
    HRESULT put_hash(BSTR v);
    HRESULT get_hash(BSTR* p);
    HRESULT reload(VARIANT_BOOL flag);
    HRESULT replace(BSTR bstr);
    HRESULT assign(BSTR bstr);
    HRESULT toString(BSTR* string);
}

@GUID("3050f549-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLHistory : IDispatch
{
}

@GUID("3050f54c-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLNavigator : IDispatch
{
}

@GUID("3050f54e-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLLocation : IDispatch
{
}

@GUID("3050f54a-98b5-11cf-bb82-00aa00bdce0b")
interface DispCPlugins : IDispatch
{
}

@GUID("3050f4ce-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLBookmarkCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(int index, VARIANT* pVarBookmark);
}

@GUID("3050f4b3-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDataTransfer : IDispatch
{
    HRESULT setData(BSTR format, VARIANT* data, VARIANT_BOOL* pret);
    HRESULT getData(BSTR format, VARIANT* pvarRet);
    HRESULT clearData(BSTR format, VARIANT_BOOL* pret);
    HRESULT put_dropEffect(BSTR v);
    HRESULT get_dropEffect(BSTR* p);
    HRESULT put_effectAllowed(BSTR v);
    HRESULT get_effectAllowed(BSTR* p);
}

@GUID("3050f48b-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLEventObj2 : IDispatch
{
    HRESULT setAttribute(BSTR strAttributeName, VARIANT AttributeValue, int lFlags);
    HRESULT getAttribute(BSTR strAttributeName, int lFlags, VARIANT* AttributeValue);
    HRESULT removeAttribute(BSTR strAttributeName, int lFlags, VARIANT_BOOL* pfSuccess);
    HRESULT put_propertyName(BSTR v);
    HRESULT get_propertyName(BSTR* p);
    HRESULT putref_bookmarks(IHTMLBookmarkCollection v);
    HRESULT get_bookmarks(IHTMLBookmarkCollection* p);
    HRESULT putref_recordset(IDispatch v);
    HRESULT get_recordset(IDispatch* p);
    HRESULT put_dataFld(BSTR v);
    HRESULT get_dataFld(BSTR* p);
    HRESULT putref_boundElements(IHTMLElementCollection v);
    HRESULT get_boundElements(IHTMLElementCollection* p);
    HRESULT put_repeat(VARIANT_BOOL v);
    HRESULT get_repeat(VARIANT_BOOL* p);
    HRESULT put_srcUrn(BSTR v);
    HRESULT get_srcUrn(BSTR* p);
    HRESULT putref_srcElement(IHTMLElement v);
    HRESULT get_srcElement(IHTMLElement* p);
    HRESULT put_altKey(VARIANT_BOOL v);
    HRESULT get_altKey(VARIANT_BOOL* p);
    HRESULT put_ctrlKey(VARIANT_BOOL v);
    HRESULT get_ctrlKey(VARIANT_BOOL* p);
    HRESULT put_shiftKey(VARIANT_BOOL v);
    HRESULT get_shiftKey(VARIANT_BOOL* p);
    HRESULT putref_fromElement(IHTMLElement v);
    HRESULT get_fromElement(IHTMLElement* p);
    HRESULT putref_toElement(IHTMLElement v);
    HRESULT get_toElement(IHTMLElement* p);
    HRESULT put_button(int v);
    HRESULT get_button(int* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT put_qualifier(BSTR v);
    HRESULT get_qualifier(BSTR* p);
    HRESULT put_reason(int v);
    HRESULT get_reason(int* p);
    HRESULT put_x(int v);
    HRESULT get_x(int* p);
    HRESULT put_y(int v);
    HRESULT get_y(int* p);
    HRESULT put_clientX(int v);
    HRESULT get_clientX(int* p);
    HRESULT put_clientY(int v);
    HRESULT get_clientY(int* p);
    HRESULT put_offsetX(int v);
    HRESULT get_offsetX(int* p);
    HRESULT put_offsetY(int v);
    HRESULT get_offsetY(int* p);
    HRESULT put_screenX(int v);
    HRESULT get_screenX(int* p);
    HRESULT put_screenY(int v);
    HRESULT get_screenY(int* p);
    HRESULT putref_srcFilter(IDispatch v);
    HRESULT get_srcFilter(IDispatch* p);
    HRESULT get_dataTransfer(IHTMLDataTransfer* p);
}

@GUID("3050f680-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLEventObj3 : IDispatch
{
    HRESULT get_contentOverflow(VARIANT_BOOL* p);
    HRESULT put_shiftLeft(VARIANT_BOOL v);
    HRESULT get_shiftLeft(VARIANT_BOOL* p);
    HRESULT put_altLeft(VARIANT_BOOL v);
    HRESULT get_altLeft(VARIANT_BOOL* p);
    HRESULT put_ctrlLeft(VARIANT_BOOL v);
    HRESULT get_ctrlLeft(VARIANT_BOOL* p);
    HRESULT get_imeCompositionChange(ptrdiff_t* p);
    HRESULT get_imeNotifyCommand(ptrdiff_t* p);
    HRESULT get_imeNotifyData(ptrdiff_t* p);
    HRESULT get_imeRequest(ptrdiff_t* p);
    HRESULT get_imeRequestData(ptrdiff_t* p);
    HRESULT get_keyboardLayout(ptrdiff_t* p);
    HRESULT get_behaviorCookie(int* p);
    HRESULT get_behaviorPart(int* p);
    HRESULT get_nextPage(BSTR* p);
}

@GUID("3050f814-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLEventObj4 : IDispatch
{
    HRESULT get_wheelDelta(int* p);
}

@GUID("30510478-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLEventObj5 : IDispatch
{
    HRESULT put_url(BSTR v);
    HRESULT get_url(BSTR* p);
    HRESULT put_data(BSTR v);
    HRESULT get_data(BSTR* p);
    HRESULT get_source(IDispatch* p);
    HRESULT put_origin(BSTR v);
    HRESULT get_origin(BSTR* p);
    HRESULT put_issession(VARIANT_BOOL v);
    HRESULT get_issession(VARIANT_BOOL* p);
}

@GUID("30510734-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLEventObj6 : IDispatch
{
    HRESULT get_actionURL(BSTR* p);
    HRESULT get_buttonID(int* p);
}

@GUID("3050f558-98b5-11cf-bb82-00aa00bdce0b")
interface DispCEventObj : IDispatch
{
}

@GUID("3051074b-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStyleMedia : IDispatch
{
    HRESULT get_type(BSTR* p);
    HRESULT matchMedium(BSTR mediaQuery, VARIANT_BOOL* matches);
}

@GUID("3059009e-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLStyleMedia : IDispatch
{
}

@GUID("332c4426-26cb-11d0-b483-00c04fd90119")
interface IHTMLFramesCollection2 : IDispatch
{
    HRESULT item(VARIANT* pvarIndex, VARIANT* pvarResult);
    HRESULT get_length(int* p);
}

@GUID("3050f5a1-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLWindowEvents3 : IDispatch
{
}

@GUID("3050f625-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLWindowEvents2 : IDispatch
{
}

@GUID("96a0a4e0-d062-11cf-94b6-00aa0060275c")
interface HTMLWindowEvents : IDispatch
{
}

@GUID("332c4425-26cb-11d0-b483-00c04fd90119")
interface IHTMLDocument2 : IHTMLDocument
{
    HRESULT get_all(IHTMLElementCollection* p);
    HRESULT get_body(IHTMLElement* p);
    HRESULT get_activeElement(IHTMLElement* p);
    HRESULT get_images(IHTMLElementCollection* p);
    HRESULT get_applets(IHTMLElementCollection* p);
    HRESULT get_links(IHTMLElementCollection* p);
    HRESULT get_forms(IHTMLElementCollection* p);
    HRESULT get_anchors(IHTMLElementCollection* p);
    HRESULT put_title(BSTR v);
    HRESULT get_title(BSTR* p);
    HRESULT get_scripts(IHTMLElementCollection* p);
    HRESULT put_designMode(BSTR v);
    HRESULT get_designMode(BSTR* p);
    HRESULT get_selection(IHTMLSelectionObject* p);
    HRESULT get_readyState(BSTR* p);
    HRESULT get_frames(IHTMLFramesCollection2* p);
    HRESULT get_embeds(IHTMLElementCollection* p);
    HRESULT get_plugins(IHTMLElementCollection* p);
    HRESULT put_alinkColor(VARIANT v);
    HRESULT get_alinkColor(VARIANT* p);
    HRESULT put_bgColor(VARIANT v);
    HRESULT get_bgColor(VARIANT* p);
    HRESULT put_fgColor(VARIANT v);
    HRESULT get_fgColor(VARIANT* p);
    HRESULT put_linkColor(VARIANT v);
    HRESULT get_linkColor(VARIANT* p);
    HRESULT put_vlinkColor(VARIANT v);
    HRESULT get_vlinkColor(VARIANT* p);
    HRESULT get_referrer(BSTR* p);
    HRESULT get_location(IHTMLLocation* p);
    HRESULT get_lastModified(BSTR* p);
    HRESULT put_URL(BSTR v);
    HRESULT get_URL(BSTR* p);
    HRESULT put_domain(BSTR v);
    HRESULT get_domain(BSTR* p);
    HRESULT put_cookie(BSTR v);
    HRESULT get_cookie(BSTR* p);
    HRESULT put_expando(VARIANT_BOOL v);
    HRESULT get_expando(VARIANT_BOOL* p);
    HRESULT put_charset(BSTR v);
    HRESULT get_charset(BSTR* p);
    HRESULT put_defaultCharset(BSTR v);
    HRESULT get_defaultCharset(BSTR* p);
    HRESULT get_mimeType(BSTR* p);
    HRESULT get_fileSize(BSTR* p);
    HRESULT get_fileCreatedDate(BSTR* p);
    HRESULT get_fileModifiedDate(BSTR* p);
    HRESULT get_fileUpdatedDate(BSTR* p);
    HRESULT get_security(BSTR* p);
    HRESULT get_protocol(BSTR* p);
    HRESULT get_nameProp(BSTR* p);
    HRESULT write(SAFEARRAY* psarray);
    HRESULT writeln(SAFEARRAY* psarray);
    HRESULT open(BSTR url, VARIANT name, VARIANT features, VARIANT replace, IDispatch* pomWindowResult);
    HRESULT close();
    HRESULT clear();
    HRESULT queryCommandSupported(BSTR cmdID, VARIANT_BOOL* pfRet);
    HRESULT queryCommandEnabled(BSTR cmdID, VARIANT_BOOL* pfRet);
    HRESULT queryCommandState(BSTR cmdID, VARIANT_BOOL* pfRet);
    HRESULT queryCommandIndeterm(BSTR cmdID, VARIANT_BOOL* pfRet);
    HRESULT queryCommandText(BSTR cmdID, BSTR* pcmdText);
    HRESULT queryCommandValue(BSTR cmdID, VARIANT* pcmdValue);
    HRESULT execCommand(BSTR cmdID, VARIANT_BOOL showUI, VARIANT value, VARIANT_BOOL* pfRet);
    HRESULT execCommandShowHelp(BSTR cmdID, VARIANT_BOOL* pfRet);
    HRESULT createElement(BSTR eTag, IHTMLElement* newElem);
    HRESULT put_onhelp(VARIANT v);
    HRESULT get_onhelp(VARIANT* p);
    HRESULT put_onclick(VARIANT v);
    HRESULT get_onclick(VARIANT* p);
    HRESULT put_ondblclick(VARIANT v);
    HRESULT get_ondblclick(VARIANT* p);
    HRESULT put_onkeyup(VARIANT v);
    HRESULT get_onkeyup(VARIANT* p);
    HRESULT put_onkeydown(VARIANT v);
    HRESULT get_onkeydown(VARIANT* p);
    HRESULT put_onkeypress(VARIANT v);
    HRESULT get_onkeypress(VARIANT* p);
    HRESULT put_onmouseup(VARIANT v);
    HRESULT get_onmouseup(VARIANT* p);
    HRESULT put_onmousedown(VARIANT v);
    HRESULT get_onmousedown(VARIANT* p);
    HRESULT put_onmousemove(VARIANT v);
    HRESULT get_onmousemove(VARIANT* p);
    HRESULT put_onmouseout(VARIANT v);
    HRESULT get_onmouseout(VARIANT* p);
    HRESULT put_onmouseover(VARIANT v);
    HRESULT get_onmouseover(VARIANT* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
    HRESULT put_onafterupdate(VARIANT v);
    HRESULT get_onafterupdate(VARIANT* p);
    HRESULT put_onrowexit(VARIANT v);
    HRESULT get_onrowexit(VARIANT* p);
    HRESULT put_onrowenter(VARIANT v);
    HRESULT get_onrowenter(VARIANT* p);
    HRESULT put_ondragstart(VARIANT v);
    HRESULT get_ondragstart(VARIANT* p);
    HRESULT put_onselectstart(VARIANT v);
    HRESULT get_onselectstart(VARIANT* p);
    HRESULT elementFromPoint(int x, int y, IHTMLElement* elementHit);
    HRESULT get_parentWindow(IHTMLWindow2* p);
    HRESULT get_styleSheets(IHTMLStyleSheetsCollection* p);
    HRESULT put_onbeforeupdate(VARIANT v);
    HRESULT get_onbeforeupdate(VARIANT* p);
    HRESULT put_onerrorupdate(VARIANT v);
    HRESULT get_onerrorupdate(VARIANT* p);
    HRESULT toString(BSTR* String);
    HRESULT createStyleSheet(BSTR bstrHref, int lIndex, IHTMLStyleSheet* ppnewStyleSheet);
}

@GUID("332c4427-26cb-11d0-b483-00c04fd90119")
interface IHTMLWindow2 : IHTMLFramesCollection2
{
    HRESULT get_frames(IHTMLFramesCollection2* p);
    HRESULT put_defaultStatus(BSTR v);
    HRESULT get_defaultStatus(BSTR* p);
    HRESULT put_status(BSTR v);
    HRESULT get_status(BSTR* p);
    HRESULT setTimeout(BSTR expression, int msec, VARIANT* language, int* timerID);
    HRESULT clearTimeout(int timerID);
    HRESULT alert(BSTR message);
    HRESULT confirm(BSTR message, VARIANT_BOOL* confirmed);
    HRESULT prompt(BSTR message, BSTR defstr, VARIANT* textdata);
    HRESULT get_Image(IHTMLImageElementFactory* p);
    HRESULT get_location(IHTMLLocation* p);
    HRESULT get_history(IOmHistory* p);
    HRESULT close();
    HRESULT put_opener(VARIANT v);
    HRESULT get_opener(VARIANT* p);
    HRESULT get_navigator(IOmNavigator* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT get_parent(IHTMLWindow2* p);
    HRESULT open(BSTR url, BSTR name, BSTR features, VARIANT_BOOL replace, IHTMLWindow2* pomWindowResult);
    HRESULT get_self(IHTMLWindow2* p);
    HRESULT get_top(IHTMLWindow2* p);
    HRESULT get_window(IHTMLWindow2* p);
    HRESULT navigate(BSTR url);
    HRESULT put_onfocus(VARIANT v);
    HRESULT get_onfocus(VARIANT* p);
    HRESULT put_onblur(VARIANT v);
    HRESULT get_onblur(VARIANT* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onbeforeunload(VARIANT v);
    HRESULT get_onbeforeunload(VARIANT* p);
    HRESULT put_onunload(VARIANT v);
    HRESULT get_onunload(VARIANT* p);
    HRESULT put_onhelp(VARIANT v);
    HRESULT get_onhelp(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_onresize(VARIANT v);
    HRESULT get_onresize(VARIANT* p);
    HRESULT put_onscroll(VARIANT v);
    HRESULT get_onscroll(VARIANT* p);
    HRESULT get_document(IHTMLDocument2* p);
    HRESULT get_event(IHTMLEventObj* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT showModalDialog(BSTR dialog, VARIANT* varArgIn, VARIANT* varOptions, VARIANT* varArgOut);
    HRESULT showHelp(BSTR helpURL, VARIANT helpArg, BSTR features);
    HRESULT get_screen(IHTMLScreen* p);
    HRESULT get_Option(IHTMLOptionElementFactory* p);
    HRESULT focus();
    HRESULT get_closed(VARIANT_BOOL* p);
    HRESULT blur();
    HRESULT scroll(int x, int y);
    HRESULT get_clientInformation(IOmNavigator* p);
    HRESULT setInterval(BSTR expression, int msec, VARIANT* language, int* timerID);
    HRESULT clearInterval(int timerID);
    HRESULT put_offscreenBuffering(VARIANT v);
    HRESULT get_offscreenBuffering(VARIANT* p);
    HRESULT execScript(BSTR code, BSTR language, VARIANT* pvarRet);
    HRESULT toString(BSTR* String);
    HRESULT scrollBy(int x, int y);
    HRESULT scrollTo(int x, int y);
    HRESULT moveTo(int x, int y);
    HRESULT moveBy(int x, int y);
    HRESULT resizeTo(int x, int y);
    HRESULT resizeBy(int x, int y);
    HRESULT get_external(IDispatch* p);
}

@GUID("3050f4ae-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLWindow3 : IDispatch
{
    HRESULT get_screenLeft(int* p);
    HRESULT get_screenTop(int* p);
    HRESULT attachEvent(BSTR event, IDispatch pDisp, VARIANT_BOOL* pfResult);
    HRESULT detachEvent(BSTR event, IDispatch pDisp);
    HRESULT setTimeout(VARIANT* expression, int msec, VARIANT* language, int* timerID);
    HRESULT setInterval(VARIANT* expression, int msec, VARIANT* language, int* timerID);
    HRESULT print();
    HRESULT put_onbeforeprint(VARIANT v);
    HRESULT get_onbeforeprint(VARIANT* p);
    HRESULT put_onafterprint(VARIANT v);
    HRESULT get_onafterprint(VARIANT* p);
    HRESULT get_clipboardData(IHTMLDataTransfer* p);
    HRESULT showModelessDialog(BSTR url, VARIANT* varArgIn, VARIANT* options, IHTMLWindow2* pDialog);
}

@GUID("3050f311-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLFrameBase : IDispatch
{
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_border(VARIANT v);
    HRESULT get_border(VARIANT* p);
    HRESULT put_frameBorder(BSTR v);
    HRESULT get_frameBorder(BSTR* p);
    HRESULT put_frameSpacing(VARIANT v);
    HRESULT get_frameSpacing(VARIANT* p);
    HRESULT put_marginWidth(VARIANT v);
    HRESULT get_marginWidth(VARIANT* p);
    HRESULT put_marginHeight(VARIANT v);
    HRESULT get_marginHeight(VARIANT* p);
    HRESULT put_noResize(VARIANT_BOOL v);
    HRESULT get_noResize(VARIANT_BOOL* p);
    HRESULT put_scrolling(BSTR v);
    HRESULT get_scrolling(BSTR* p);
}

@GUID("30510474-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStorage : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get_remainingSpace(int* p);
    HRESULT key(int lIndex, BSTR* __MIDL__IHTMLStorage0000);
    HRESULT getItem(BSTR bstrKey, VARIANT* __MIDL__IHTMLStorage0001);
    HRESULT setItem(BSTR bstrKey, BSTR bstrValue);
    HRESULT removeItem(BSTR bstrKey);
    HRESULT clear();
}

@GUID("3051074e-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLPerformance : IDispatch
{
    HRESULT get_navigation(IHTMLPerformanceNavigation* p);
    HRESULT get_timing(IHTMLPerformanceTiming* p);
    HRESULT toString(BSTR* string);
    HRESULT toJSON(VARIANT* pVar);
}

@GUID("30510828-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLApplicationCache : IDispatch
{
    HRESULT get_status(int* p);
    HRESULT put_onchecking(VARIANT v);
    HRESULT get_onchecking(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_onnoupdate(VARIANT v);
    HRESULT get_onnoupdate(VARIANT* p);
    HRESULT put_ondownloading(VARIANT v);
    HRESULT get_ondownloading(VARIANT* p);
    HRESULT put_onprogress(VARIANT v);
    HRESULT get_onprogress(VARIANT* p);
    HRESULT put_onupdateready(VARIANT v);
    HRESULT get_onupdateready(VARIANT* p);
    HRESULT put_oncached(VARIANT v);
    HRESULT get_oncached(VARIANT* p);
    HRESULT put_onobsolete(VARIANT v);
    HRESULT get_onobsolete(VARIANT* p);
    HRESULT update();
    HRESULT swapCache();
    HRESULT abort();
}

@GUID("3050f35c-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLScreen : IDispatch
{
    HRESULT get_colorDepth(int* p);
    HRESULT put_bufferDepth(int v);
    HRESULT get_bufferDepth(int* p);
    HRESULT get_width(int* p);
    HRESULT get_height(int* p);
    HRESULT put_updateInterval(int v);
    HRESULT get_updateInterval(int* p);
    HRESULT get_availHeight(int* p);
    HRESULT get_availWidth(int* p);
    HRESULT get_fontSmoothingEnabled(VARIANT_BOOL* p);
}

@GUID("3050f84a-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLScreen2 : IDispatch
{
    HRESULT get_logicalXDPI(int* p);
    HRESULT get_logicalYDPI(int* p);
    HRESULT get_deviceXDPI(int* p);
    HRESULT get_deviceYDPI(int* p);
}

@GUID("305104a1-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLScreen3 : IDispatch
{
    HRESULT get_systemXDPI(int* p);
    HRESULT get_systemYDPI(int* p);
}

@GUID("3051076b-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLScreen4 : IDispatch
{
    HRESULT get_pixelDepth(int* p);
}

@GUID("3050f6cf-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLWindow4 : IDispatch
{
    HRESULT createPopup(VARIANT* varArgIn, IDispatch* ppPopup);
    HRESULT get_frameElement(IHTMLFrameBase* p);
}

@GUID("3051040e-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLWindow5 : IDispatch
{
    HRESULT put_XMLHttpRequest(VARIANT v);
    HRESULT get_XMLHttpRequest(VARIANT* p);
}

@GUID("30510453-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLWindow6 : IDispatch
{
    HRESULT put_XDomainRequest(VARIANT v);
    HRESULT get_XDomainRequest(VARIANT* p);
    HRESULT get_sessionStorage(IHTMLStorage* p);
    HRESULT get_localStorage(IHTMLStorage* p);
    HRESULT put_onhashchange(VARIANT v);
    HRESULT get_onhashchange(VARIANT* p);
    HRESULT get_maxConnectionsPerServer(int* p);
    HRESULT postMessage(BSTR msg, VARIANT targetOrigin);
    HRESULT toStaticHTML(BSTR bstrHTML, BSTR* pbstrStaticHTML);
    HRESULT put_onmessage(VARIANT v);
    HRESULT get_onmessage(VARIANT* p);
    HRESULT msWriteProfilerMark(BSTR bstrProfilerMarkName);
}

@GUID("305104b7-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLWindow7 : IDispatch
{
    HRESULT getSelection(IHTMLSelection* ppIHTMLSelection);
    HRESULT getComputedStyle(IHTMLDOMNode varArgIn, BSTR bstrPseudoElt, IHTMLCSSStyleDeclaration* ppComputedStyle);
    HRESULT get_styleMedia(IHTMLStyleMedia* p);
    HRESULT put_performance(VARIANT v);
    HRESULT get_performance(VARIANT* p);
    HRESULT get_innerWidth(int* p);
    HRESULT get_innerHeight(int* p);
    HRESULT get_pageXOffset(int* p);
    HRESULT get_pageYOffset(int* p);
    HRESULT get_screenX(int* p);
    HRESULT get_screenY(int* p);
    HRESULT get_outerWidth(int* p);
    HRESULT get_outerHeight(int* p);
    HRESULT put_onabort(VARIANT v);
    HRESULT get_onabort(VARIANT* p);
    HRESULT put_oncanplay(VARIANT v);
    HRESULT get_oncanplay(VARIANT* p);
    HRESULT put_oncanplaythrough(VARIANT v);
    HRESULT get_oncanplaythrough(VARIANT* p);
    HRESULT put_onchange(VARIANT v);
    HRESULT get_onchange(VARIANT* p);
    HRESULT put_onclick(VARIANT v);
    HRESULT get_onclick(VARIANT* p);
    HRESULT put_oncontextmenu(VARIANT v);
    HRESULT get_oncontextmenu(VARIANT* p);
    HRESULT put_ondblclick(VARIANT v);
    HRESULT get_ondblclick(VARIANT* p);
    HRESULT put_ondrag(VARIANT v);
    HRESULT get_ondrag(VARIANT* p);
    HRESULT put_ondragend(VARIANT v);
    HRESULT get_ondragend(VARIANT* p);
    HRESULT put_ondragenter(VARIANT v);
    HRESULT get_ondragenter(VARIANT* p);
    HRESULT put_ondragleave(VARIANT v);
    HRESULT get_ondragleave(VARIANT* p);
    HRESULT put_ondragover(VARIANT v);
    HRESULT get_ondragover(VARIANT* p);
    HRESULT put_ondragstart(VARIANT v);
    HRESULT get_ondragstart(VARIANT* p);
    HRESULT put_ondrop(VARIANT v);
    HRESULT get_ondrop(VARIANT* p);
    HRESULT put_ondurationchange(VARIANT v);
    HRESULT get_ondurationchange(VARIANT* p);
    HRESULT put_onfocusin(VARIANT v);
    HRESULT get_onfocusin(VARIANT* p);
    HRESULT put_onfocusout(VARIANT v);
    HRESULT get_onfocusout(VARIANT* p);
    HRESULT put_oninput(VARIANT v);
    HRESULT get_oninput(VARIANT* p);
    HRESULT put_onemptied(VARIANT v);
    HRESULT get_onemptied(VARIANT* p);
    HRESULT put_onended(VARIANT v);
    HRESULT get_onended(VARIANT* p);
    HRESULT put_onkeydown(VARIANT v);
    HRESULT get_onkeydown(VARIANT* p);
    HRESULT put_onkeypress(VARIANT v);
    HRESULT get_onkeypress(VARIANT* p);
    HRESULT put_onkeyup(VARIANT v);
    HRESULT get_onkeyup(VARIANT* p);
    HRESULT put_onloadeddata(VARIANT v);
    HRESULT get_onloadeddata(VARIANT* p);
    HRESULT put_onloadedmetadata(VARIANT v);
    HRESULT get_onloadedmetadata(VARIANT* p);
    HRESULT put_onloadstart(VARIANT v);
    HRESULT get_onloadstart(VARIANT* p);
    HRESULT put_onmousedown(VARIANT v);
    HRESULT get_onmousedown(VARIANT* p);
    HRESULT put_onmouseenter(VARIANT v);
    HRESULT get_onmouseenter(VARIANT* p);
    HRESULT put_onmouseleave(VARIANT v);
    HRESULT get_onmouseleave(VARIANT* p);
    HRESULT put_onmousemove(VARIANT v);
    HRESULT get_onmousemove(VARIANT* p);
    HRESULT put_onmouseout(VARIANT v);
    HRESULT get_onmouseout(VARIANT* p);
    HRESULT put_onmouseover(VARIANT v);
    HRESULT get_onmouseover(VARIANT* p);
    HRESULT put_onmouseup(VARIANT v);
    HRESULT get_onmouseup(VARIANT* p);
    HRESULT put_onmousewheel(VARIANT v);
    HRESULT get_onmousewheel(VARIANT* p);
    HRESULT put_onoffline(VARIANT v);
    HRESULT get_onoffline(VARIANT* p);
    HRESULT put_ononline(VARIANT v);
    HRESULT get_ononline(VARIANT* p);
    HRESULT put_onprogress(VARIANT v);
    HRESULT get_onprogress(VARIANT* p);
    HRESULT put_onratechange(VARIANT v);
    HRESULT get_onratechange(VARIANT* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
    HRESULT put_onreset(VARIANT v);
    HRESULT get_onreset(VARIANT* p);
    HRESULT put_onseeked(VARIANT v);
    HRESULT get_onseeked(VARIANT* p);
    HRESULT put_onseeking(VARIANT v);
    HRESULT get_onseeking(VARIANT* p);
    HRESULT put_onselect(VARIANT v);
    HRESULT get_onselect(VARIANT* p);
    HRESULT put_onstalled(VARIANT v);
    HRESULT get_onstalled(VARIANT* p);
    HRESULT put_onstorage(VARIANT v);
    HRESULT get_onstorage(VARIANT* p);
    HRESULT put_onsubmit(VARIANT v);
    HRESULT get_onsubmit(VARIANT* p);
    HRESULT put_onsuspend(VARIANT v);
    HRESULT get_onsuspend(VARIANT* p);
    HRESULT put_ontimeupdate(VARIANT v);
    HRESULT get_ontimeupdate(VARIANT* p);
    HRESULT put_onpause(VARIANT v);
    HRESULT get_onpause(VARIANT* p);
    HRESULT put_onplay(VARIANT v);
    HRESULT get_onplay(VARIANT* p);
    HRESULT put_onplaying(VARIANT v);
    HRESULT get_onplaying(VARIANT* p);
    HRESULT put_onvolumechange(VARIANT v);
    HRESULT get_onvolumechange(VARIANT* p);
    HRESULT put_onwaiting(VARIANT v);
    HRESULT get_onwaiting(VARIANT* p);
}

@GUID("305107ab-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLWindow8 : IDispatch
{
    HRESULT put_onmspointerdown(VARIANT v);
    HRESULT get_onmspointerdown(VARIANT* p);
    HRESULT put_onmspointermove(VARIANT v);
    HRESULT get_onmspointermove(VARIANT* p);
    HRESULT put_onmspointerup(VARIANT v);
    HRESULT get_onmspointerup(VARIANT* p);
    HRESULT put_onmspointerover(VARIANT v);
    HRESULT get_onmspointerover(VARIANT* p);
    HRESULT put_onmspointerout(VARIANT v);
    HRESULT get_onmspointerout(VARIANT* p);
    HRESULT put_onmspointercancel(VARIANT v);
    HRESULT get_onmspointercancel(VARIANT* p);
    HRESULT put_onmspointerhover(VARIANT v);
    HRESULT get_onmspointerhover(VARIANT* p);
    HRESULT put_onmsgesturestart(VARIANT v);
    HRESULT get_onmsgesturestart(VARIANT* p);
    HRESULT put_onmsgesturechange(VARIANT v);
    HRESULT get_onmsgesturechange(VARIANT* p);
    HRESULT put_onmsgestureend(VARIANT v);
    HRESULT get_onmsgestureend(VARIANT* p);
    HRESULT put_onmsgesturehold(VARIANT v);
    HRESULT get_onmsgesturehold(VARIANT* p);
    HRESULT put_onmsgesturetap(VARIANT v);
    HRESULT get_onmsgesturetap(VARIANT* p);
    HRESULT put_onmsgesturedoubletap(VARIANT v);
    HRESULT get_onmsgesturedoubletap(VARIANT* p);
    HRESULT put_onmsinertiastart(VARIANT v);
    HRESULT get_onmsinertiastart(VARIANT* p);
    HRESULT get_applicationCache(IHTMLApplicationCache* p);
    HRESULT put_onpopstate(VARIANT v);
    HRESULT get_onpopstate(VARIANT* p);
}

@GUID("3050f591-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLScreen : IDispatch
{
}

@GUID("3050f55d-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLWindow2 : IDispatch
{
}

@GUID("3050f55e-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLWindowProxy : IDispatch
{
}

@GUID("3051041a-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDocumentCompatibleInfo : IDispatch
{
    HRESULT get_userAgent(BSTR* p);
    HRESULT get_version(BSTR* p);
}

@GUID("30510418-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDocumentCompatibleInfoCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT item(int index, IHTMLDocumentCompatibleInfo* compatibleInfo);
}

@GUID("3050f53e-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLDocumentCompatibleInfo : IDispatch
{
}

@GUID("3050f53f-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLDocumentCompatibleInfoCollection : IDispatch
{
}

@GUID("30510737-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLDocumentEvents4 : IDispatch
{
}

@GUID("3050f5a0-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLDocumentEvents3 : IDispatch
{
}

@GUID("3050f613-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLDocumentEvents2 : IDispatch
{
}

@GUID("3050f260-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLDocumentEvents : IDispatch
{
}

@GUID("305104e7-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGSVGElement : IDispatch
{
    HRESULT putref_x(ISVGAnimatedLength v);
    HRESULT get_x(ISVGAnimatedLength* p);
    HRESULT putref_y(ISVGAnimatedLength v);
    HRESULT get_y(ISVGAnimatedLength* p);
    HRESULT putref_width(ISVGAnimatedLength v);
    HRESULT get_width(ISVGAnimatedLength* p);
    HRESULT putref_height(ISVGAnimatedLength v);
    HRESULT get_height(ISVGAnimatedLength* p);
    HRESULT put_contentScriptType(BSTR v);
    HRESULT get_contentScriptType(BSTR* p);
    HRESULT put_contentStyleType(BSTR v);
    HRESULT get_contentStyleType(BSTR* p);
    HRESULT putref_viewport(ISVGRect v);
    HRESULT get_viewport(ISVGRect* p);
    HRESULT put_pixelUnitToMillimeterX(float v);
    HRESULT get_pixelUnitToMillimeterX(float* p);
    HRESULT put_pixelUnitToMillimeterY(float v);
    HRESULT get_pixelUnitToMillimeterY(float* p);
    HRESULT put_screenPixelToMillimeterX(float v);
    HRESULT get_screenPixelToMillimeterX(float* p);
    HRESULT put_screenPixelToMillimeterY(float v);
    HRESULT get_screenPixelToMillimeterY(float* p);
    HRESULT put_useCurrentView(VARIANT_BOOL v);
    HRESULT get_useCurrentView(VARIANT_BOOL* p);
    HRESULT putref_currentView(ISVGViewSpec v);
    HRESULT get_currentView(ISVGViewSpec* p);
    HRESULT put_currentScale(float v);
    HRESULT get_currentScale(float* p);
    HRESULT putref_currentTranslate(ISVGPoint v);
    HRESULT get_currentTranslate(ISVGPoint* p);
    HRESULT suspendRedraw(uint maxWaitMilliseconds, uint* pResult);
    HRESULT unsuspendRedraw(uint suspendHandeID);
    HRESULT unsuspendRedrawAll();
    HRESULT forceRedraw();
    HRESULT pauseAnimations();
    HRESULT unpauseAnimations();
    HRESULT animationsPaused(VARIANT_BOOL* pResult);
    HRESULT getCurrentTime(float* pResult);
    HRESULT setCurrentTime(float seconds);
    HRESULT getIntersectionList(ISVGRect rect, ISVGElement referenceElement, VARIANT* pResult);
    HRESULT getEnclosureList(ISVGRect rect, ISVGElement referenceElement, VARIANT* pResult);
    HRESULT checkIntersection(ISVGElement element, ISVGRect rect, VARIANT_BOOL* pResult);
    HRESULT checkEnclosure(ISVGElement element, ISVGRect rect, VARIANT_BOOL* pResult);
    HRESULT deselectAll();
    HRESULT createSVGNumber(ISVGNumber* pResult);
    HRESULT createSVGLength(ISVGLength* pResult);
    HRESULT createSVGAngle(ISVGAngle* pResult);
    HRESULT createSVGPoint(ISVGPoint* pResult);
    HRESULT createSVGMatrix(ISVGMatrix* pResult);
    HRESULT createSVGRect(ISVGRect* pResult);
    HRESULT createSVGTransform(ISVGTransform* pResult);
    HRESULT createSVGTransformFromMatrix(ISVGMatrix matrix, ISVGTransform* pResult);
    HRESULT getElementById(BSTR elementId, IHTMLElement* pResult);
}

@GUID("30510746-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMNodeIterator : IDispatch
{
    HRESULT get_root(IDispatch* p);
    HRESULT get_whatToShow(uint* p);
    HRESULT get_filter(IDispatch* p);
    HRESULT get_expandEntityReferences(VARIANT_BOOL* p);
    HRESULT nextNode(IDispatch* ppRetNode);
    HRESULT previousNode(IDispatch* ppRetNode);
    HRESULT detach();
}

@GUID("30510748-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMTreeWalker : IDispatch
{
    HRESULT get_root(IDispatch* p);
    HRESULT get_whatToShow(uint* p);
    HRESULT get_filter(IDispatch* p);
    HRESULT get_expandEntityReferences(VARIANT_BOOL* p);
    HRESULT putref_currentNode(IDispatch v);
    HRESULT get_currentNode(IDispatch* p);
    HRESULT parentNode(IDispatch* ppRetNode);
    HRESULT firstChild(IDispatch* ppRetNode);
    HRESULT lastChild(IDispatch* ppRetNode);
    HRESULT previousSibling(IDispatch* ppRetNode);
    HRESULT nextSibling(IDispatch* ppRetNode);
    HRESULT previousNode(IDispatch* ppRetNode);
    HRESULT nextNode(IDispatch* ppRetNode);
}

@GUID("30510742-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMProcessingInstruction : IDispatch
{
    HRESULT get_target(BSTR* p);
    HRESULT put_data(BSTR v);
    HRESULT get_data(BSTR* p);
}

@GUID("3050f485-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDocument3 : IDispatch
{
    HRESULT releaseCapture();
    HRESULT recalc(VARIANT_BOOL fForce);
    HRESULT createTextNode(BSTR text, IHTMLDOMNode* newTextNode);
    HRESULT get_documentElement(IHTMLElement* p);
    HRESULT get_uniqueID(BSTR* p);
    HRESULT attachEvent(BSTR event, IDispatch pDisp, VARIANT_BOOL* pfResult);
    HRESULT detachEvent(BSTR event, IDispatch pDisp);
    HRESULT put_onrowsdelete(VARIANT v);
    HRESULT get_onrowsdelete(VARIANT* p);
    HRESULT put_onrowsinserted(VARIANT v);
    HRESULT get_onrowsinserted(VARIANT* p);
    HRESULT put_oncellchange(VARIANT v);
    HRESULT get_oncellchange(VARIANT* p);
    HRESULT put_ondatasetchanged(VARIANT v);
    HRESULT get_ondatasetchanged(VARIANT* p);
    HRESULT put_ondataavailable(VARIANT v);
    HRESULT get_ondataavailable(VARIANT* p);
    HRESULT put_ondatasetcomplete(VARIANT v);
    HRESULT get_ondatasetcomplete(VARIANT* p);
    HRESULT put_onpropertychange(VARIANT v);
    HRESULT get_onpropertychange(VARIANT* p);
    HRESULT put_dir(BSTR v);
    HRESULT get_dir(BSTR* p);
    HRESULT put_oncontextmenu(VARIANT v);
    HRESULT get_oncontextmenu(VARIANT* p);
    HRESULT put_onstop(VARIANT v);
    HRESULT get_onstop(VARIANT* p);
    HRESULT createDocumentFragment(IHTMLDocument2* pNewDoc);
    HRESULT get_parentDocument(IHTMLDocument2* p);
    HRESULT put_enableDownload(VARIANT_BOOL v);
    HRESULT get_enableDownload(VARIANT_BOOL* p);
    HRESULT put_baseUrl(BSTR v);
    HRESULT get_baseUrl(BSTR* p);
    HRESULT get_childNodes(IDispatch* p);
    HRESULT put_inheritStyleSheets(VARIANT_BOOL v);
    HRESULT get_inheritStyleSheets(VARIANT_BOOL* p);
    HRESULT put_onbeforeeditfocus(VARIANT v);
    HRESULT get_onbeforeeditfocus(VARIANT* p);
    HRESULT getElementsByName(BSTR v, IHTMLElementCollection* pelColl);
    HRESULT getElementById(BSTR v, IHTMLElement* pel);
    HRESULT getElementsByTagName(BSTR v, IHTMLElementCollection* pelColl);
}

@GUID("3050f69a-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDocument4 : IDispatch
{
    HRESULT focus();
    HRESULT hasFocus(VARIANT_BOOL* pfFocus);
    HRESULT put_onselectionchange(VARIANT v);
    HRESULT get_onselectionchange(VARIANT* p);
    HRESULT get_namespaces(IDispatch* p);
    HRESULT createDocumentFromUrl(BSTR bstrUrl, BSTR bstrOptions, IHTMLDocument2* newDoc);
    HRESULT put_media(BSTR v);
    HRESULT get_media(BSTR* p);
    HRESULT createEventObject(VARIANT* pvarEventObject, IHTMLEventObj* ppEventObj);
    HRESULT fireEvent(BSTR bstrEventName, VARIANT* pvarEventObject, VARIANT_BOOL* pfCancelled);
    HRESULT createRenderStyle(BSTR v, IHTMLRenderStyle* ppIHTMLRenderStyle);
    HRESULT put_oncontrolselect(VARIANT v);
    HRESULT get_oncontrolselect(VARIANT* p);
    HRESULT get_URLUnencoded(BSTR* p);
}

@GUID("3050f80c-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDocument5 : IDispatch
{
    HRESULT put_onmousewheel(VARIANT v);
    HRESULT get_onmousewheel(VARIANT* p);
    HRESULT get_doctype(IHTMLDOMNode* p);
    HRESULT get_implementation(IHTMLDOMImplementation* p);
    HRESULT createAttribute(BSTR bstrattrName, IHTMLDOMAttribute* ppattribute);
    HRESULT createComment(BSTR bstrdata, IHTMLDOMNode* ppRetNode);
    HRESULT put_onfocusin(VARIANT v);
    HRESULT get_onfocusin(VARIANT* p);
    HRESULT put_onfocusout(VARIANT v);
    HRESULT get_onfocusout(VARIANT* p);
    HRESULT put_onactivate(VARIANT v);
    HRESULT get_onactivate(VARIANT* p);
    HRESULT put_ondeactivate(VARIANT v);
    HRESULT get_ondeactivate(VARIANT* p);
    HRESULT put_onbeforeactivate(VARIANT v);
    HRESULT get_onbeforeactivate(VARIANT* p);
    HRESULT put_onbeforedeactivate(VARIANT v);
    HRESULT get_onbeforedeactivate(VARIANT* p);
    HRESULT get_compatMode(BSTR* p);
}

@GUID("30510417-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDocument6 : IDispatch
{
    HRESULT get_compatible(IHTMLDocumentCompatibleInfoCollection* p);
    HRESULT get_documentMode(VARIANT* p);
    HRESULT put_onstorage(VARIANT v);
    HRESULT get_onstorage(VARIANT* p);
    HRESULT put_onstoragecommit(VARIANT v);
    HRESULT get_onstoragecommit(VARIANT* p);
    HRESULT getElementById(BSTR bstrId, IHTMLElement2* ppRetElement);
    HRESULT updateSettings();
}

@GUID("305107d0-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDocument8 : IDispatch
{
    HRESULT put_onmscontentzoom(VARIANT v);
    HRESULT get_onmscontentzoom(VARIANT* p);
    HRESULT put_onmspointerdown(VARIANT v);
    HRESULT get_onmspointerdown(VARIANT* p);
    HRESULT put_onmspointermove(VARIANT v);
    HRESULT get_onmspointermove(VARIANT* p);
    HRESULT put_onmspointerup(VARIANT v);
    HRESULT get_onmspointerup(VARIANT* p);
    HRESULT put_onmspointerover(VARIANT v);
    HRESULT get_onmspointerover(VARIANT* p);
    HRESULT put_onmspointerout(VARIANT v);
    HRESULT get_onmspointerout(VARIANT* p);
    HRESULT put_onmspointercancel(VARIANT v);
    HRESULT get_onmspointercancel(VARIANT* p);
    HRESULT put_onmspointerhover(VARIANT v);
    HRESULT get_onmspointerhover(VARIANT* p);
    HRESULT put_onmsgesturestart(VARIANT v);
    HRESULT get_onmsgesturestart(VARIANT* p);
    HRESULT put_onmsgesturechange(VARIANT v);
    HRESULT get_onmsgesturechange(VARIANT* p);
    HRESULT put_onmsgestureend(VARIANT v);
    HRESULT get_onmsgestureend(VARIANT* p);
    HRESULT put_onmsgesturehold(VARIANT v);
    HRESULT get_onmsgesturehold(VARIANT* p);
    HRESULT put_onmsgesturetap(VARIANT v);
    HRESULT get_onmsgesturetap(VARIANT* p);
    HRESULT put_onmsgesturedoubletap(VARIANT v);
    HRESULT get_onmsgesturedoubletap(VARIANT* p);
    HRESULT put_onmsinertiastart(VARIANT v);
    HRESULT get_onmsinertiastart(VARIANT* p);
    HRESULT elementsFromPoint(float x, float y, IHTMLDOMChildrenCollection* elementsHit);
    HRESULT elementsFromRect(float left, float top, float width, float height, 
                             IHTMLDOMChildrenCollection* elementsHit);
    HRESULT put_onmsmanipulationstatechanged(VARIANT v);
    HRESULT get_onmsmanipulationstatechanged(VARIANT* p);
    HRESULT put_msCapsLockWarningOff(VARIANT_BOOL v);
    HRESULT get_msCapsLockWarningOff(VARIANT_BOOL* p);
}

@GUID("305104bc-98b5-11cf-bb82-00aa00bdce0b")
interface IDocumentEvent : IDispatch
{
    HRESULT createEvent(BSTR eventType, IDOMEvent* ppEvent);
}

@GUID("305104af-98b5-11cf-bb82-00aa00bdce0b")
interface IDocumentRange : IDispatch
{
    HRESULT createRange(IHTMLDOMRange* ppIHTMLDOMRange);
}

@GUID("30510462-98b5-11cf-bb82-00aa00bdce0b")
interface IDocumentSelector : IDispatch
{
    HRESULT querySelector(BSTR v, IHTMLElement* pel);
    HRESULT querySelectorAll(BSTR v, IHTMLDOMChildrenCollection* pel);
}

@GUID("30510744-98b5-11cf-bb82-00aa00bdce0b")
interface IDocumentTraversal : IDispatch
{
    HRESULT createNodeIterator(IDispatch pRootNode, int ulWhatToShow, VARIANT* pFilter, 
                               VARIANT_BOOL fEntityReferenceExpansion, IDOMNodeIterator* ppNodeIterator);
    HRESULT createTreeWalker(IDispatch pRootNode, int ulWhatToShow, VARIANT* pFilter, 
                             VARIANT_BOOL fEntityReferenceExpansion, IDOMTreeWalker* ppTreeWalker);
}

@GUID("3050f55f-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLDocument : IDispatch
{
}

@GUID("a6d897ff-0a95-11d1-b0ba-006008166e11")
interface DWebBridgeEvents : IDispatch
{
}

@GUID("ae24fdad-03c6-11d1-8b76-0080c744f389")
interface IWebBridge : IDispatch
{
    HRESULT put_URL(BSTR v);
    HRESULT get_URL(BSTR* p);
    HRESULT put_Scrollbar(VARIANT_BOOL v);
    HRESULT get_Scrollbar(VARIANT_BOOL* p);
    HRESULT put_embed(VARIANT_BOOL v);
    HRESULT get_embed(VARIANT_BOOL* p);
    HRESULT get_event(IDispatch* p);
    HRESULT get_readyState(int* p);
    HRESULT AboutBox();
}

@GUID("a5170870-0cf8-11d1-8b91-0080c744f389")
interface IWBScriptControl : IDispatch
{
    HRESULT raiseEvent(BSTR name, VARIANT eventData);
    HRESULT bubbleEvent();
    HRESULT setContextMenu(VARIANT menuItemPairs);
    HRESULT put_selectableContent(VARIANT_BOOL v);
    HRESULT get_selectableContent(VARIANT_BOOL* p);
    HRESULT get_frozen(VARIANT_BOOL* p);
    HRESULT put_scrollbar(VARIANT_BOOL v);
    HRESULT get_scrollbar(VARIANT_BOOL* p);
    HRESULT get_version(BSTR* p);
    HRESULT get_visibility(VARIANT_BOOL* p);
    HRESULT put_onvisibilitychange(VARIANT v);
    HRESULT get_onvisibilitychange(VARIANT* p);
}

@GUID("3050f25f-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLEmbedElement : IDispatch
{
    HRESULT put_hidden(BSTR v);
    HRESULT get_hidden(BSTR* p);
    HRESULT get_palette(BSTR* p);
    HRESULT get_pluginspage(BSTR* p);
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_units(BSTR v);
    HRESULT get_units(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
}

@GUID("30510493-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLEmbedElement2 : IDispatch
{
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT get_pluginspage(BSTR* p);
}

@GUID("3050f52e-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLEmbed : IDispatch
{
}

@GUID("3050f61e-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLMapEvents2 : IDispatch
{
}

@GUID("3050f3ba-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLMapEvents : IDispatch
{
}

@GUID("3050f383-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLAreasCollection : IDispatch
{
    HRESULT put_length(int v);
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(VARIANT name, VARIANT index, IDispatch* pdisp);
    HRESULT tags(VARIANT tagName, IDispatch* pdisp);
    HRESULT add(IHTMLElement element, VARIANT before);
    HRESULT remove(int index);
}

@GUID("3050f5ec-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLAreasCollection2 : IDispatch
{
    HRESULT urns(VARIANT urn, IDispatch* pdisp);
}

@GUID("3050f837-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLAreasCollection3 : IDispatch
{
    HRESULT namedItem(BSTR name, IDispatch* pdisp);
}

@GUID("30510492-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLAreasCollection4 : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT item(int index, IHTMLElement2* pNode);
    HRESULT namedItem(BSTR name, IHTMLElement2* pNode);
}

@GUID("3050f266-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLMapElement : IDispatch
{
    HRESULT get_areas(IHTMLAreasCollection* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
}

@GUID("3050f56a-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLAreasCollection : IDispatch
{
}

@GUID("3050f526-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLMapElement : IDispatch
{
}

@GUID("3050f611-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLAreaEvents2 : IDispatch
{
}

@GUID("3050f366-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLAreaEvents : IDispatch
{
}

@GUID("3050f265-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLAreaElement : IDispatch
{
    HRESULT put_shape(BSTR v);
    HRESULT get_shape(BSTR* p);
    HRESULT put_coords(BSTR v);
    HRESULT get_coords(BSTR* p);
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
    HRESULT put_target(BSTR v);
    HRESULT get_target(BSTR* p);
    HRESULT put_alt(BSTR v);
    HRESULT get_alt(BSTR* p);
    HRESULT put_noHref(VARIANT_BOOL v);
    HRESULT get_noHref(VARIANT_BOOL* p);
    HRESULT put_host(BSTR v);
    HRESULT get_host(BSTR* p);
    HRESULT put_hostname(BSTR v);
    HRESULT get_hostname(BSTR* p);
    HRESULT put_pathname(BSTR v);
    HRESULT get_pathname(BSTR* p);
    HRESULT put_port(BSTR v);
    HRESULT get_port(BSTR* p);
    HRESULT put_protocol(BSTR v);
    HRESULT get_protocol(BSTR* p);
    HRESULT put_search(BSTR v);
    HRESULT get_search(BSTR* p);
    HRESULT put_hash(BSTR v);
    HRESULT get_hash(BSTR* p);
    HRESULT put_onblur(VARIANT v);
    HRESULT get_onblur(VARIANT* p);
    HRESULT put_onfocus(VARIANT v);
    HRESULT get_onfocus(VARIANT* p);
    HRESULT put_tabIndex(short v);
    HRESULT get_tabIndex(short* p);
    HRESULT focus();
    HRESULT blur();
}

@GUID("3051041f-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLAreaElement2 : IDispatch
{
    HRESULT put_shape(BSTR v);
    HRESULT get_shape(BSTR* p);
    HRESULT put_coords(BSTR v);
    HRESULT get_coords(BSTR* p);
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
}

@GUID("3050f503-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLAreaElement : IDispatch
{
}

@GUID("3050f2eb-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTableCaption : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_vAlign(BSTR v);
    HRESULT get_vAlign(BSTR* p);
}

@GUID("3050f508-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLTableCaption : IDispatch
{
}

@GUID("3050f20c-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLCommentElement : IDispatch
{
    HRESULT put_text(BSTR v);
    HRESULT get_text(BSTR* p);
    HRESULT put_atomic(int v);
    HRESULT get_atomic(int* p);
}

@GUID("3050f813-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLCommentElement2 : IDispatch
{
    HRESULT put_data(BSTR v);
    HRESULT get_data(BSTR* p);
    HRESULT get_length(int* p);
    HRESULT substringData(int offset, int Count, BSTR* pbstrsubString);
    HRESULT appendData(BSTR bstrstring);
    HRESULT insertData(int offset, BSTR bstrstring);
    HRESULT deleteData(int offset, int Count);
    HRESULT replaceData(int offset, int Count, BSTR bstrstring);
}

@GUID("3051073f-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLCommentElement3 : IDispatch
{
    HRESULT substringData(int offset, int Count, BSTR* pbstrsubString);
    HRESULT insertData(int offset, BSTR bstrstring);
    HRESULT deleteData(int offset, int Count);
    HRESULT replaceData(int offset, int Count, BSTR bstrstring);
}

@GUID("3050f50a-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLCommentElement : IDispatch
{
}

@GUID("3050f20a-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLPhraseElement : IDispatch
{
}

@GUID("3050f824-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLPhraseElement2 : IDispatch
{
    HRESULT put_cite(BSTR v);
    HRESULT get_cite(BSTR* p);
    HRESULT put_dateTime(BSTR v);
    HRESULT get_dateTime(BSTR* p);
}

@GUID("3051043d-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLPhraseElement3 : IDispatch
{
    HRESULT put_cite(BSTR v);
    HRESULT get_cite(BSTR* p);
}

@GUID("3050f3f3-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLSpanElement : IDispatch
{
}

@GUID("3050f52d-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLPhraseElement : IDispatch
{
}

@GUID("3050f548-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLSpanElement : IDispatch
{
}

@GUID("3050f623-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLTableEvents2 : IDispatch
{
}

@GUID("3050f407-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLTableEvents : IDispatch
{
}

@GUID("3050f23b-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTableSection : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_vAlign(BSTR v);
    HRESULT get_vAlign(BSTR* p);
    HRESULT put_bgColor(VARIANT v);
    HRESULT get_bgColor(VARIANT* p);
    HRESULT get_rows(IHTMLElementCollection* p);
    HRESULT insertRow(int index, IDispatch* row);
    HRESULT deleteRow(int index);
}

@GUID("3050f21e-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTable : IDispatch
{
    HRESULT put_cols(int v);
    HRESULT get_cols(int* p);
    HRESULT put_border(VARIANT v);
    HRESULT get_border(VARIANT* p);
    HRESULT put_frame(BSTR v);
    HRESULT get_frame(BSTR* p);
    HRESULT put_rules(BSTR v);
    HRESULT get_rules(BSTR* p);
    HRESULT put_cellSpacing(VARIANT v);
    HRESULT get_cellSpacing(VARIANT* p);
    HRESULT put_cellPadding(VARIANT v);
    HRESULT get_cellPadding(VARIANT* p);
    HRESULT put_background(BSTR v);
    HRESULT get_background(BSTR* p);
    HRESULT put_bgColor(VARIANT v);
    HRESULT get_bgColor(VARIANT* p);
    HRESULT put_borderColor(VARIANT v);
    HRESULT get_borderColor(VARIANT* p);
    HRESULT put_borderColorLight(VARIANT v);
    HRESULT get_borderColorLight(VARIANT* p);
    HRESULT put_borderColorDark(VARIANT v);
    HRESULT get_borderColorDark(VARIANT* p);
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT refresh();
    HRESULT get_rows(IHTMLElementCollection* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
    HRESULT put_dataPageSize(int v);
    HRESULT get_dataPageSize(int* p);
    HRESULT nextPage();
    HRESULT previousPage();
    HRESULT get_tHead(IHTMLTableSection* p);
    HRESULT get_tFoot(IHTMLTableSection* p);
    HRESULT get_tBodies(IHTMLElementCollection* p);
    HRESULT get_caption(IHTMLTableCaption* p);
    HRESULT createTHead(IDispatch* head);
    HRESULT deleteTHead();
    HRESULT createTFoot(IDispatch* foot);
    HRESULT deleteTFoot();
    HRESULT createCaption(IHTMLTableCaption* caption);
    HRESULT deleteCaption();
    HRESULT insertRow(int index, IDispatch* row);
    HRESULT deleteRow(int index);
    HRESULT get_readyState(BSTR* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
}

@GUID("3050f4ad-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTable2 : IDispatch
{
    HRESULT firstPage();
    HRESULT lastPage();
    HRESULT get_cells(IHTMLElementCollection* p);
    HRESULT moveRow(int indexFrom, int indexTo, IDispatch* row);
}

@GUID("3050f829-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTable3 : IDispatch
{
    HRESULT put_summary(BSTR v);
    HRESULT get_summary(BSTR* p);
}

@GUID("305106c2-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTable4 : IDispatch
{
    HRESULT putref_tHead(IHTMLTableSection v);
    HRESULT get_tHead(IHTMLTableSection* p);
    HRESULT putref_tFoot(IHTMLTableSection v);
    HRESULT get_tFoot(IHTMLTableSection* p);
    HRESULT putref_caption(IHTMLTableCaption v);
    HRESULT get_caption(IHTMLTableCaption* p);
    HRESULT insertRow(int index, IDispatch* row);
    HRESULT deleteRow(int index);
    HRESULT createTBody(IHTMLTableSection* tbody);
}

@GUID("3050f23a-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTableCol : IDispatch
{
    HRESULT put_span(int v);
    HRESULT get_span(int* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_vAlign(BSTR v);
    HRESULT get_vAlign(BSTR* p);
}

@GUID("3050f82a-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTableCol2 : IDispatch
{
    HRESULT put_ch(BSTR v);
    HRESULT get_ch(BSTR* p);
    HRESULT put_chOff(BSTR v);
    HRESULT get_chOff(BSTR* p);
}

@GUID("305106c4-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTableCol3 : IDispatch
{
    HRESULT put_ch(BSTR v);
    HRESULT get_ch(BSTR* p);
    HRESULT put_chOff(BSTR v);
    HRESULT get_chOff(BSTR* p);
}

@GUID("3050f5c7-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTableSection2 : IDispatch
{
    HRESULT moveRow(int indexFrom, int indexTo, IDispatch* row);
}

@GUID("3050f82b-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTableSection3 : IDispatch
{
    HRESULT put_ch(BSTR v);
    HRESULT get_ch(BSTR* p);
    HRESULT put_chOff(BSTR v);
    HRESULT get_chOff(BSTR* p);
}

@GUID("305106c5-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTableSection4 : IDispatch
{
    HRESULT put_ch(BSTR v);
    HRESULT get_ch(BSTR* p);
    HRESULT put_chOff(BSTR v);
    HRESULT get_chOff(BSTR* p);
    HRESULT insertRow(int index, IDispatch* row);
    HRESULT deleteRow(int index);
}

@GUID("3050f23c-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTableRow : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_vAlign(BSTR v);
    HRESULT get_vAlign(BSTR* p);
    HRESULT put_bgColor(VARIANT v);
    HRESULT get_bgColor(VARIANT* p);
    HRESULT put_borderColor(VARIANT v);
    HRESULT get_borderColor(VARIANT* p);
    HRESULT put_borderColorLight(VARIANT v);
    HRESULT get_borderColorLight(VARIANT* p);
    HRESULT put_borderColorDark(VARIANT v);
    HRESULT get_borderColorDark(VARIANT* p);
    HRESULT get_rowIndex(int* p);
    HRESULT get_sectionRowIndex(int* p);
    HRESULT get_cells(IHTMLElementCollection* p);
    HRESULT insertCell(int index, IDispatch* row);
    HRESULT deleteCell(int index);
}

@GUID("3050f4a1-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTableRow2 : IDispatch
{
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
}

@GUID("3050f82c-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTableRow3 : IDispatch
{
    HRESULT put_ch(BSTR v);
    HRESULT get_ch(BSTR* p);
    HRESULT put_chOff(BSTR v);
    HRESULT get_chOff(BSTR* p);
}

@GUID("305106c6-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTableRow4 : IDispatch
{
    HRESULT put_ch(BSTR v);
    HRESULT get_ch(BSTR* p);
    HRESULT put_chOff(BSTR v);
    HRESULT get_chOff(BSTR* p);
    HRESULT insertCell(int index, IDispatch* row);
    HRESULT deleteCell(int index);
}

@GUID("3050f413-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTableRowMetrics : IDispatch
{
    HRESULT get_clientHeight(int* p);
    HRESULT get_clientWidth(int* p);
    HRESULT get_clientTop(int* p);
    HRESULT get_clientLeft(int* p);
}

@GUID("3050f23d-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTableCell : IDispatch
{
    HRESULT put_rowSpan(int v);
    HRESULT get_rowSpan(int* p);
    HRESULT put_colSpan(int v);
    HRESULT get_colSpan(int* p);
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_vAlign(BSTR v);
    HRESULT get_vAlign(BSTR* p);
    HRESULT put_bgColor(VARIANT v);
    HRESULT get_bgColor(VARIANT* p);
    HRESULT put_noWrap(VARIANT_BOOL v);
    HRESULT get_noWrap(VARIANT_BOOL* p);
    HRESULT put_background(BSTR v);
    HRESULT get_background(BSTR* p);
    HRESULT put_borderColor(VARIANT v);
    HRESULT get_borderColor(VARIANT* p);
    HRESULT put_borderColorLight(VARIANT v);
    HRESULT get_borderColorLight(VARIANT* p);
    HRESULT put_borderColorDark(VARIANT v);
    HRESULT get_borderColorDark(VARIANT* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
    HRESULT get_cellIndex(int* p);
}

@GUID("3050f82d-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTableCell2 : IDispatch
{
    HRESULT put_abbr(BSTR v);
    HRESULT get_abbr(BSTR* p);
    HRESULT put_axis(BSTR v);
    HRESULT get_axis(BSTR* p);
    HRESULT put_ch(BSTR v);
    HRESULT get_ch(BSTR* p);
    HRESULT put_chOff(BSTR v);
    HRESULT get_chOff(BSTR* p);
    HRESULT put_headers(BSTR v);
    HRESULT get_headers(BSTR* p);
    HRESULT put_scope(BSTR v);
    HRESULT get_scope(BSTR* p);
}

@GUID("305106c7-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTableCell3 : IDispatch
{
    HRESULT put_ch(BSTR v);
    HRESULT get_ch(BSTR* p);
    HRESULT put_chOff(BSTR v);
    HRESULT get_chOff(BSTR* p);
}

@GUID("3050f532-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLTable : IDispatch
{
}

@GUID("3050f533-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLTableCol : IDispatch
{
}

@GUID("3050f534-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLTableSection : IDispatch
{
}

@GUID("3050f535-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLTableRow : IDispatch
{
}

@GUID("3050f536-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLTableCell : IDispatch
{
}

@GUID("3050f621-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLScriptEvents2 : IDispatch
{
}

@GUID("3050f3e2-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLScriptEvents : IDispatch
{
}

@GUID("3050f28b-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLScriptElement : IDispatch
{
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_htmlFor(BSTR v);
    HRESULT get_htmlFor(BSTR* p);
    HRESULT put_event(BSTR v);
    HRESULT get_event(BSTR* p);
    HRESULT put_text(BSTR v);
    HRESULT get_text(BSTR* p);
    HRESULT put_defer(VARIANT_BOOL v);
    HRESULT get_defer(VARIANT_BOOL* p);
    HRESULT get_readyState(BSTR* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
}

@GUID("3050f828-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLScriptElement2 : IDispatch
{
    HRESULT put_charset(BSTR v);
    HRESULT get_charset(BSTR* p);
}

@GUID("30510447-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLScriptElement3 : IDispatch
{
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
}

@GUID("30510801-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLScriptElement4 : IDispatch
{
    HRESULT get_usedCharset(BSTR* p);
}

@GUID("3050f530-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLScriptElement : IDispatch
{
}

@GUID("3050f38a-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLNoShowElement : IDispatch
{
}

@GUID("3050f528-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLNoShowElement : IDispatch
{
}

@GUID("3050f620-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLObjectElementEvents2 : IDispatch
{
}

@GUID("3050f3c4-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLObjectElementEvents : IDispatch
{
}

@GUID("3050f24f-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLObjectElement : IDispatch
{
    HRESULT get_object(IDispatch* p);
    HRESULT get_classid(BSTR* p);
    HRESULT get_data(BSTR* p);
    HRESULT putref_recordset(IDispatch v);
    HRESULT get_recordset(IDispatch* p);
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_codeBase(BSTR v);
    HRESULT get_codeBase(BSTR* p);
    HRESULT put_codeType(BSTR v);
    HRESULT get_codeType(BSTR* p);
    HRESULT put_code(BSTR v);
    HRESULT get_code(BSTR* p);
    HRESULT get_BaseHref(BSTR* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT get_form(IHTMLFormElement* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
    HRESULT get_readyState(int* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_altHtml(BSTR v);
    HRESULT get_altHtml(BSTR* p);
    HRESULT put_vspace(int v);
    HRESULT get_vspace(int* p);
    HRESULT put_hspace(int v);
    HRESULT get_hspace(int* p);
}

@GUID("3050f4cd-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLObjectElement2 : IDispatch
{
    HRESULT namedRecordset(BSTR dataMember, VARIANT* hierarchy, IDispatch* ppRecordset);
    HRESULT put_classid(BSTR v);
    HRESULT get_classid(BSTR* p);
    HRESULT put_data(BSTR v);
    HRESULT get_data(BSTR* p);
}

@GUID("3050f827-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLObjectElement3 : IDispatch
{
    HRESULT put_archive(BSTR v);
    HRESULT get_archive(BSTR* p);
    HRESULT put_alt(BSTR v);
    HRESULT get_alt(BSTR* p);
    HRESULT put_declare(VARIANT_BOOL v);
    HRESULT get_declare(VARIANT_BOOL* p);
    HRESULT put_standby(BSTR v);
    HRESULT get_standby(BSTR* p);
    HRESULT put_border(VARIANT v);
    HRESULT get_border(VARIANT* p);
    HRESULT put_useMap(BSTR v);
    HRESULT get_useMap(BSTR* p);
}

@GUID("3051043e-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLObjectElement4 : IDispatch
{
    HRESULT get_contentDocument(IDispatch* p);
    HRESULT put_codeBase(BSTR v);
    HRESULT get_codeBase(BSTR* p);
    HRESULT put_data(BSTR v);
    HRESULT get_data(BSTR* p);
}

@GUID("305104b5-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLObjectElement5 : IDispatch
{
    HRESULT put_object(BSTR v);
    HRESULT get_object(BSTR* p);
}

@GUID("3050f83d-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLParamElement : IDispatch
{
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT put_valueType(BSTR v);
    HRESULT get_valueType(BSTR* p);
}

@GUID("30510444-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLParamElement2 : IDispatch
{
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_valueType(BSTR v);
    HRESULT get_valueType(BSTR* p);
}

@GUID("3050f529-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLObjectElement : IDispatch
{
}

@GUID("3050f590-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLParamElement : IDispatch
{
}

@GUID("3050f7ff-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLFrameSiteEvents2 : IDispatch
{
}

@GUID("3050f800-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLFrameSiteEvents : IDispatch
{
}

@GUID("3050f6db-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLFrameBase2 : IDispatch
{
    HRESULT get_contentWindow(IHTMLWindow2* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
    HRESULT get_readyState(BSTR* p);
    HRESULT put_allowTransparency(VARIANT_BOOL v);
    HRESULT get_allowTransparency(VARIANT_BOOL* p);
}

@GUID("3050f82e-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLFrameBase3 : IDispatch
{
    HRESULT put_longDesc(BSTR v);
    HRESULT get_longDesc(BSTR* p);
}

@GUID("3050f541-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLFrameBase : IDispatch
{
}

@GUID("3050f313-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLFrameElement : IDispatch
{
    HRESULT put_borderColor(VARIANT v);
    HRESULT get_borderColor(VARIANT* p);
}

@GUID("3050f7f5-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLFrameElement2 : IDispatch
{
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
}

@GUID("3051042d-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLFrameElement3 : IDispatch
{
    HRESULT get_contentDocument(IDispatch* p);
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_longDesc(BSTR v);
    HRESULT get_longDesc(BSTR* p);
    HRESULT put_frameBorder(BSTR v);
    HRESULT get_frameBorder(BSTR* p);
}

@GUID("3050f513-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLFrameElement : IDispatch
{
}

@GUID("3050f315-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLIFrameElement : IDispatch
{
    HRESULT put_vspace(int v);
    HRESULT get_vspace(int* p);
    HRESULT put_hspace(int v);
    HRESULT get_hspace(int* p);
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
}

@GUID("3050f4e6-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLIFrameElement2 : IDispatch
{
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
}

@GUID("30510433-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLIFrameElement3 : IDispatch
{
    HRESULT get_contentDocument(IDispatch* p);
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_longDesc(BSTR v);
    HRESULT get_longDesc(BSTR* p);
    HRESULT put_frameBorder(BSTR v);
    HRESULT get_frameBorder(BSTR* p);
}

@GUID("3050f51b-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLIFrame : IDispatch
{
}

@GUID("3050f212-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDivPosition : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
}

@GUID("3050f3e7-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLFieldSetElement : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
}

@GUID("3050f833-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLFieldSetElement2 : IDispatch
{
    HRESULT get_form(IHTMLFormElement* p);
}

@GUID("3050f3ea-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLLegendElement : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
}

@GUID("3050f834-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLLegendElement2 : IDispatch
{
    HRESULT get_form(IHTMLFormElement* p);
}

@GUID("3050f50f-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLDivPosition : IDispatch
{
}

@GUID("3050f545-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLFieldSetElement : IDispatch
{
}

@GUID("3050f546-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLLegendElement : IDispatch
{
}

@GUID("3050f3e5-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLSpanFlow : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
}

@GUID("3050f544-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLSpanFlow : IDispatch
{
}

@GUID("3050f319-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLFrameSetElement : IDispatch
{
    HRESULT put_rows(BSTR v);
    HRESULT get_rows(BSTR* p);
    HRESULT put_cols(BSTR v);
    HRESULT get_cols(BSTR* p);
    HRESULT put_border(VARIANT v);
    HRESULT get_border(VARIANT* p);
    HRESULT put_borderColor(VARIANT v);
    HRESULT get_borderColor(VARIANT* p);
    HRESULT put_frameBorder(BSTR v);
    HRESULT get_frameBorder(BSTR* p);
    HRESULT put_frameSpacing(VARIANT v);
    HRESULT get_frameSpacing(VARIANT* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onunload(VARIANT v);
    HRESULT get_onunload(VARIANT* p);
    HRESULT put_onbeforeunload(VARIANT v);
    HRESULT get_onbeforeunload(VARIANT* p);
}

@GUID("3050f5c6-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLFrameSetElement2 : IDispatch
{
    HRESULT put_onbeforeprint(VARIANT v);
    HRESULT get_onbeforeprint(VARIANT* p);
    HRESULT put_onafterprint(VARIANT v);
    HRESULT get_onafterprint(VARIANT* p);
}

@GUID("30510796-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLFrameSetElement3 : IDispatch
{
    HRESULT put_onhashchange(VARIANT v);
    HRESULT get_onhashchange(VARIANT* p);
    HRESULT put_onmessage(VARIANT v);
    HRESULT get_onmessage(VARIANT* p);
    HRESULT put_onoffline(VARIANT v);
    HRESULT get_onoffline(VARIANT* p);
    HRESULT put_ononline(VARIANT v);
    HRESULT get_ononline(VARIANT* p);
    HRESULT put_onstorage(VARIANT v);
    HRESULT get_onstorage(VARIANT* p);
}

@GUID("3050f514-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLFrameSetSite : IDispatch
{
}

@GUID("3050f369-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLBGsound : IDispatch
{
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_loop(VARIANT v);
    HRESULT get_loop(VARIANT* p);
    HRESULT put_volume(VARIANT v);
    HRESULT get_volume(VARIANT* p);
    HRESULT put_balance(VARIANT v);
    HRESULT get_balance(VARIANT* p);
}

@GUID("3050f53c-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLBGsound : IDispatch
{
}

@GUID("3050f376-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLFontNamesCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(int index, BSTR* pBstr);
}

@GUID("3050f377-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLFontSizesCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT get_forFont(BSTR* p);
    HRESULT item(int index, int* plSize);
}

@GUID("3050f378-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLOptionsHolder : IDispatch
{
    HRESULT get_document(IHTMLDocument2* p);
    HRESULT get_fonts(IHTMLFontNamesCollection* p);
    HRESULT put_execArg(VARIANT v);
    HRESULT get_execArg(VARIANT* p);
    HRESULT put_errorLine(int v);
    HRESULT get_errorLine(int* p);
    HRESULT put_errorCharacter(int v);
    HRESULT get_errorCharacter(int* p);
    HRESULT put_errorCode(int v);
    HRESULT get_errorCode(int* p);
    HRESULT put_errorMessage(BSTR v);
    HRESULT get_errorMessage(BSTR* p);
    HRESULT put_errorDebug(VARIANT_BOOL v);
    HRESULT get_errorDebug(VARIANT_BOOL* p);
    HRESULT get_unsecuredWindowOfDocument(IHTMLWindow2* p);
    HRESULT put_findText(BSTR v);
    HRESULT get_findText(BSTR* p);
    HRESULT put_anythingAfterFrameset(VARIANT_BOOL v);
    HRESULT get_anythingAfterFrameset(VARIANT_BOOL* p);
    HRESULT sizes(BSTR fontName, IHTMLFontSizesCollection* pSizesCollection);
    HRESULT openfiledlg(VARIANT initFile, VARIANT initDir, VARIANT filter, VARIANT title, BSTR* pathName);
    HRESULT savefiledlg(VARIANT initFile, VARIANT initDir, VARIANT filter, VARIANT title, BSTR* pathName);
    HRESULT choosecolordlg(VARIANT initColor, int* rgbColor);
    HRESULT showSecurityInfo();
    HRESULT isApartmentModel(IHTMLObjectElement object, VARIANT_BOOL* fApartment);
    HRESULT getCharset(BSTR fontName, int* charset);
    HRESULT get_secureConnectionInfo(BSTR* p);
}

@GUID("3050f615-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLStyleElementEvents2 : IDispatch
{
}

@GUID("3050f3cb-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLStyleElementEvents : IDispatch
{
}

@GUID("3050f375-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStyleElement : IDispatch
{
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT get_readyState(BSTR* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT get_styleSheet(IHTMLStyleSheet* p);
    HRESULT put_disabled(VARIANT_BOOL v);
    HRESULT get_disabled(VARIANT_BOOL* p);
    HRESULT put_media(BSTR v);
    HRESULT get_media(BSTR* p);
}

@GUID("3051072a-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStyleElement2 : IDispatch
{
    HRESULT get_sheet(IHTMLStyleSheet* p);
}

@GUID("3050f511-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLStyleElement : IDispatch
{
}

@GUID("3050f3d5-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStyleFontFace : IDispatch
{
    HRESULT put_fontsrc(BSTR v);
    HRESULT get_fontsrc(BSTR* p);
}

@GUID("305106ec-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStyleFontFace2 : IDispatch
{
    HRESULT get_style(IHTMLRuleStyle* p);
}

@GUID("30590081-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLStyleFontFace : IDispatch
{
}

@GUID("30510454-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLXDomainRequest : IDispatch
{
    HRESULT get_responseText(BSTR* p);
    HRESULT put_timeout(int v);
    HRESULT get_timeout(int* p);
    HRESULT get_contentType(BSTR* p);
    HRESULT put_onprogress(VARIANT v);
    HRESULT get_onprogress(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_ontimeout(VARIANT v);
    HRESULT get_ontimeout(VARIANT* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT abort();
    HRESULT open(BSTR bstrMethod, BSTR bstrUrl);
    HRESULT send(VARIANT varBody);
}

@GUID("30510456-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLXDomainRequestFactory : IDispatch
{
    HRESULT create(IHTMLXDomainRequest* __MIDL__IHTMLXDomainRequestFactory0000);
}

@GUID("3050f599-98b5-11cf-bb82-00aa00bdce0b")
interface DispXDomainRequest : IDispatch
{
}

@GUID("30510799-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStorage2 : IDispatch
{
    HRESULT setItem(BSTR bstrKey, BSTR bstrValue);
}

@GUID("3050f59d-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLStorage : IDispatch
{
}

@GUID("305104b9-98b5-11cf-bb82-00aa00bdce0b")
interface IEventTarget : IDispatch
{
    HRESULT addEventListener(BSTR type, IDispatch listener, VARIANT_BOOL useCapture);
    HRESULT removeEventListener(BSTR type, IDispatch listener, VARIANT_BOOL useCapture);
    HRESULT dispatchEvent(IDOMEvent evt, VARIANT_BOOL* pfResult);
}

@GUID("3050f5a2-98b5-11cf-bb82-00aa00bdce0b")
interface DispDOMEvent : IDispatch
{
}

@GUID("305106ca-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMUIEvent : IDispatch
{
    HRESULT get_view(IHTMLWindow2* p);
    HRESULT get_detail(int* p);
    HRESULT initUIEvent(BSTR eventType, VARIANT_BOOL canBubble, VARIANT_BOOL cancelable, IHTMLWindow2 view, 
                        int detail);
}

@GUID("30590072-98b5-11cf-bb82-00aa00bdce0b")
interface DispDOMUIEvent : IDispatch
{
}

@GUID("305106ce-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMMouseEvent : IDispatch
{
    HRESULT get_screenX(int* p);
    HRESULT get_screenY(int* p);
    HRESULT get_clientX(int* p);
    HRESULT get_clientY(int* p);
    HRESULT get_ctrlKey(VARIANT_BOOL* p);
    HRESULT get_shiftKey(VARIANT_BOOL* p);
    HRESULT get_altKey(VARIANT_BOOL* p);
    HRESULT get_metaKey(VARIANT_BOOL* p);
    HRESULT get_button(ushort* p);
    HRESULT get_relatedTarget(IEventTarget* p);
    HRESULT initMouseEvent(BSTR eventType, VARIANT_BOOL canBubble, VARIANT_BOOL cancelable, IHTMLWindow2 viewArg, 
                           int detailArg, int screenXArg, int screenYArg, int clientXArg, int clientYArg, 
                           VARIANT_BOOL ctrlKeyArg, VARIANT_BOOL altKeyArg, VARIANT_BOOL shiftKeyArg, 
                           VARIANT_BOOL metaKeyArg, ushort buttonArg, IEventTarget relatedTargetArg);
    HRESULT getModifierState(BSTR keyArg, VARIANT_BOOL* activated);
    HRESULT get_buttons(ushort* p);
    HRESULT get_fromElement(IHTMLElement* p);
    HRESULT get_toElement(IHTMLElement* p);
    HRESULT get_x(int* p);
    HRESULT get_y(int* p);
    HRESULT get_offsetX(int* p);
    HRESULT get_offsetY(int* p);
    HRESULT get_pageX(int* p);
    HRESULT get_pageY(int* p);
    HRESULT get_layerX(int* p);
    HRESULT get_layerY(int* p);
    HRESULT get_which(ushort* p);
}

@GUID("30590073-98b5-11cf-bb82-00aa00bdce0b")
interface DispDOMMouseEvent : IDispatch
{
}

@GUID("30510761-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMDragEvent : IDispatch
{
    HRESULT get_dataTransfer(IHTMLDataTransfer* p);
    HRESULT initDragEvent(BSTR eventType, VARIANT_BOOL canBubble, VARIANT_BOOL cancelable, IHTMLWindow2 viewArg, 
                          int detailArg, int screenXArg, int screenYArg, int clientXArg, int clientYArg, 
                          VARIANT_BOOL ctrlKeyArg, VARIANT_BOOL altKeyArg, VARIANT_BOOL shiftKeyArg, 
                          VARIANT_BOOL metaKeyArg, ushort buttonArg, IEventTarget relatedTargetArg, 
                          IHTMLDataTransfer dataTransferArg);
}

@GUID("305900a7-98b5-11cf-bb82-00aa00bdce0b")
interface DispDOMDragEvent : IDispatch
{
}

@GUID("305106d0-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMMouseWheelEvent : IDispatch
{
    HRESULT get_wheelDelta(int* p);
    HRESULT initMouseWheelEvent(BSTR eventType, VARIANT_BOOL canBubble, VARIANT_BOOL cancelable, 
                                IHTMLWindow2 viewArg, int detailArg, int screenXArg, int screenYArg, int clientXArg, 
                                int clientYArg, ushort buttonArg, IEventTarget relatedTargetArg, 
                                BSTR modifiersListArg, int wheelDeltaArg);
}

@GUID("30590074-98b5-11cf-bb82-00aa00bdce0b")
interface DispDOMMouseWheelEvent : IDispatch
{
}

@GUID("305106d2-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMWheelEvent : IDispatch
{
    HRESULT get_deltaX(int* p);
    HRESULT get_deltaY(int* p);
    HRESULT get_deltaZ(int* p);
    HRESULT get_deltaMode(uint* p);
    HRESULT initWheelEvent(BSTR eventType, VARIANT_BOOL canBubble, VARIANT_BOOL cancelable, IHTMLWindow2 viewArg, 
                           int detailArg, int screenXArg, int screenYArg, int clientXArg, int clientYArg, 
                           ushort buttonArg, IEventTarget relatedTargetArg, BSTR modifiersListArg, int deltaX, 
                           int deltaY, int deltaZ, uint deltaMode);
}

@GUID("30590075-98b5-11cf-bb82-00aa00bdce0b")
interface DispDOMWheelEvent : IDispatch
{
}

@GUID("305106d4-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMTextEvent : IDispatch
{
    HRESULT get_data(BSTR* p);
    HRESULT get_inputMethod(uint* p);
    HRESULT initTextEvent(BSTR eventType, VARIANT_BOOL canBubble, VARIANT_BOOL cancelable, IHTMLWindow2 viewArg, 
                          BSTR dataArg, uint inputMethod, BSTR locale);
    HRESULT get_locale(BSTR* p);
}

@GUID("30590076-98b5-11cf-bb82-00aa00bdce0b")
interface DispDOMTextEvent : IDispatch
{
}

@GUID("305106d6-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMKeyboardEvent : IDispatch
{
    HRESULT get_key(BSTR* p);
    HRESULT get_location(uint* p);
    HRESULT get_ctrlKey(VARIANT_BOOL* p);
    HRESULT get_shiftKey(VARIANT_BOOL* p);
    HRESULT get_altKey(VARIANT_BOOL* p);
    HRESULT get_metaKey(VARIANT_BOOL* p);
    HRESULT get_repeat(VARIANT_BOOL* p);
    HRESULT getModifierState(BSTR keyArg, VARIANT_BOOL* state);
    HRESULT initKeyboardEvent(BSTR eventType, VARIANT_BOOL canBubble, VARIANT_BOOL cancelable, 
                              IHTMLWindow2 viewArg, BSTR keyArg, uint locationArg, BSTR modifiersListArg, 
                              VARIANT_BOOL repeat, BSTR locale);
    HRESULT get_keyCode(int* p);
    HRESULT get_charCode(int* p);
    HRESULT get_which(int* p);
    HRESULT get_ie9_char(VARIANT* p);
    HRESULT get_locale(BSTR* p);
}

@GUID("30590077-98b5-11cf-bb82-00aa00bdce0b")
interface DispDOMKeyboardEvent : IDispatch
{
}

@GUID("305106d8-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMCompositionEvent : IDispatch
{
    HRESULT get_data(BSTR* p);
    HRESULT initCompositionEvent(BSTR eventType, VARIANT_BOOL canBubble, VARIANT_BOOL cancelable, 
                                 IHTMLWindow2 viewArg, BSTR data, BSTR locale);
    HRESULT get_locale(BSTR* p);
}

@GUID("30590078-98b5-11cf-bb82-00aa00bdce0b")
interface DispDOMCompositionEvent : IDispatch
{
}

@GUID("305106da-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMMutationEvent : IDispatch
{
    HRESULT get_relatedNode(IDispatch* p);
    HRESULT get_prevValue(BSTR* p);
    HRESULT get_newValue(BSTR* p);
    HRESULT get_attrName(BSTR* p);
    HRESULT get_attrChange(ushort* p);
    HRESULT initMutationEvent(BSTR eventType, VARIANT_BOOL canBubble, VARIANT_BOOL cancelable, 
                              IDispatch relatedNodeArg, BSTR prevValueArg, BSTR newValueArg, BSTR attrNameArg, 
                              ushort attrChangeArg);
}

@GUID("30590079-98b5-11cf-bb82-00aa00bdce0b")
interface DispDOMMutationEvent : IDispatch
{
}

@GUID("30510763-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMBeforeUnloadEvent : IDispatch
{
    HRESULT put_returnValue(VARIANT v);
    HRESULT get_returnValue(VARIANT* p);
}

@GUID("305900a8-98b5-11cf-bb82-00aa00bdce0b")
interface DispDOMBeforeUnloadEvent : IDispatch
{
}

@GUID("305106cc-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMFocusEvent : IDispatch
{
    HRESULT get_relatedTarget(IEventTarget* p);
    HRESULT initFocusEvent(BSTR eventType, VARIANT_BOOL canBubble, VARIANT_BOOL cancelable, IHTMLWindow2 view, 
                           int detail, IEventTarget relatedTargetArg);
}

@GUID("30590071-98b5-11cf-bb82-00aa00bdce0b")
interface DispDOMFocusEvent : IDispatch
{
}

@GUID("305106de-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMCustomEvent : IDispatch
{
    HRESULT get_detail(VARIANT* p);
    HRESULT initCustomEvent(BSTR eventType, VARIANT_BOOL canBubble, VARIANT_BOOL cancelable, VARIANT* detail);
}

@GUID("3059007c-98b5-11cf-bb82-00aa00bdce0b")
interface DispDOMCustomEvent : IDispatch
{
}

@GUID("30510714-98b5-11cf-bb82-00aa00bdce0b")
interface ICanvasGradient : IDispatch
{
    HRESULT addColorStop(float offset, BSTR color);
}

@GUID("30510716-98b5-11cf-bb82-00aa00bdce0b")
interface ICanvasPattern : IDispatch
{
}

@GUID("30510718-98b5-11cf-bb82-00aa00bdce0b")
interface ICanvasTextMetrics : IDispatch
{
    HRESULT get_width(float* p);
}

@GUID("3051071a-98b5-11cf-bb82-00aa00bdce0b")
interface ICanvasImageData : IDispatch
{
    HRESULT get_width(uint* p);
    HRESULT get_height(uint* p);
    HRESULT get_data(VARIANT* p);
}

@GUID("3051071c-98b5-11cf-bb82-00aa00bdce0b")
interface ICanvasPixelArray : IDispatch
{
    HRESULT get_length(uint* p);
}

@GUID("305106e4-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLCanvasElement : IDispatch
{
    HRESULT put_width(int v);
    HRESULT get_width(int* p);
    HRESULT put_height(int v);
    HRESULT get_height(int* p);
    HRESULT getContext(BSTR contextId, ICanvasRenderingContext2D* ppContext);
    HRESULT toDataURL(BSTR type, VARIANT jpegquality, BSTR* pUrl);
}

@GUID("305106ff-98b5-11cf-bb82-00aa00bdce0b")
interface ICanvasRenderingContext2D : IDispatch
{
    HRESULT get_canvas(IHTMLCanvasElement* p);
    HRESULT restore();
    HRESULT save();
    HRESULT rotate(float angle);
    HRESULT scale(float x, float y);
    HRESULT setTransform(float m11, float m12, float m21, float m22, float dx, float dy);
    HRESULT transform(float m11, float m12, float m21, float m22, float dx, float dy);
    HRESULT translate(float x, float y);
    HRESULT put_globalAlpha(float v);
    HRESULT get_globalAlpha(float* p);
    HRESULT put_globalCompositeOperation(BSTR v);
    HRESULT get_globalCompositeOperation(BSTR* p);
    HRESULT put_fillStyle(VARIANT v);
    HRESULT get_fillStyle(VARIANT* p);
    HRESULT put_strokeStyle(VARIANT v);
    HRESULT get_strokeStyle(VARIANT* p);
    HRESULT createLinearGradient(float x0, float y0, float x1, float y1, ICanvasGradient* ppCanvasGradient);
    HRESULT createRadialGradient(float x0, float y0, float r0, float x1, float y1, float r1, 
                                 ICanvasGradient* ppCanvasGradient);
    HRESULT createPattern(IDispatch image, VARIANT repetition, ICanvasPattern* ppCanvasPattern);
    HRESULT put_lineCap(BSTR v);
    HRESULT get_lineCap(BSTR* p);
    HRESULT put_lineJoin(BSTR v);
    HRESULT get_lineJoin(BSTR* p);
    HRESULT put_lineWidth(float v);
    HRESULT get_lineWidth(float* p);
    HRESULT put_miterLimit(float v);
    HRESULT get_miterLimit(float* p);
    HRESULT put_shadowBlur(float v);
    HRESULT get_shadowBlur(float* p);
    HRESULT put_shadowColor(BSTR v);
    HRESULT get_shadowColor(BSTR* p);
    HRESULT put_shadowOffsetX(float v);
    HRESULT get_shadowOffsetX(float* p);
    HRESULT put_shadowOffsetY(float v);
    HRESULT get_shadowOffsetY(float* p);
    HRESULT clearRect(float x, float y, float w, float h);
    HRESULT fillRect(float x, float y, float w, float h);
    HRESULT strokeRect(float x, float y, float w, float h);
    HRESULT arc(float x, float y, float radius, float startAngle, float endAngle, BOOL anticlockwise);
    HRESULT arcTo(float x1, float y1, float x2, float y2, float radius);
    HRESULT beginPath();
    HRESULT bezierCurveTo(float cp1x, float cp1y, float cp2x, float cp2y, float x, float y);
    HRESULT clip();
    HRESULT closePath();
    HRESULT fill();
    HRESULT lineTo(float x, float y);
    HRESULT moveTo(float x, float y);
    HRESULT quadraticCurveTo(float cpx, float cpy, float x, float y);
    HRESULT rect(float x, float y, float w, float h);
    HRESULT stroke();
    HRESULT isPointInPath(float x, float y, VARIANT_BOOL* pResult);
    HRESULT put_font(BSTR v);
    HRESULT get_font(BSTR* p);
    HRESULT put_textAlign(BSTR v);
    HRESULT get_textAlign(BSTR* p);
    HRESULT put_textBaseline(BSTR v);
    HRESULT get_textBaseline(BSTR* p);
    HRESULT fillText(BSTR text, float x, float y, VARIANT maxWidth);
    HRESULT measureText(BSTR text, ICanvasTextMetrics* ppCanvasTextMetrics);
    HRESULT strokeText(BSTR text, float x, float y, VARIANT maxWidth);
    HRESULT drawImage(IDispatch pSrc, VARIANT a1, VARIANT a2, VARIANT a3, VARIANT a4, VARIANT a5, VARIANT a6, 
                      VARIANT a7, VARIANT a8);
    HRESULT createImageData(VARIANT a1, VARIANT a2, ICanvasImageData* ppCanvasImageData);
    HRESULT getImageData(float sx, float sy, float sw, float sh, ICanvasImageData* ppCanvasImageData);
    HRESULT putImageData(ICanvasImageData imagedata, float dx, float dy, VARIANT dirtyX, VARIANT dirtyY, 
                         VARIANT dirtyWidth, VARIANT dirtyHeight);
}

@GUID("3059008c-98b5-11cf-bb82-00aa00bdce0b")
interface DispCanvasGradient : IDispatch
{
}

@GUID("3059008d-98b5-11cf-bb82-00aa00bdce0b")
interface DispCanvasPattern : IDispatch
{
}

@GUID("3059008e-98b5-11cf-bb82-00aa00bdce0b")
interface DispCanvasTextMetrics : IDispatch
{
}

@GUID("3059008f-98b5-11cf-bb82-00aa00bdce0b")
interface DispCanvasImageData : IDispatch
{
}

@GUID("30590082-98b5-11cf-bb82-00aa00bdce0b")
interface DispCanvasRenderingContext2D : IDispatch
{
}

@GUID("3059007b-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLCanvasElement : IDispatch
{
}

@GUID("3051071e-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMProgressEvent : IDispatch
{
    HRESULT get_lengthComputable(VARIANT_BOOL* p);
    HRESULT get_loaded(ulong* p);
    HRESULT get_total(ulong* p);
    HRESULT initProgressEvent(BSTR eventType, VARIANT_BOOL canBubble, VARIANT_BOOL cancelable, 
                              VARIANT_BOOL lengthComputableArg, ulong loadedArg, ulong totalArg);
}

@GUID("30590091-98b5-11cf-bb82-00aa00bdce0b")
interface DispDOMProgressEvent : IDispatch
{
}

@GUID("30510720-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMMessageEvent : IDispatch
{
    HRESULT get_data(BSTR* p);
    HRESULT get_origin(BSTR* p);
    HRESULT get_source(IHTMLWindow2* p);
    HRESULT initMessageEvent(BSTR eventType, VARIANT_BOOL canBubble, VARIANT_BOOL cancelable, BSTR data, 
                             BSTR origin, BSTR lastEventId, IHTMLWindow2 source);
}

@GUID("30590092-98b5-11cf-bb82-00aa00bdce0b")
interface DispDOMMessageEvent : IDispatch
{
}

@GUID("30510765-98b6-11cf-bb82-00aa00bdce0b")
interface IDOMSiteModeEvent : IDispatch
{
    HRESULT get_buttonID(int* p);
    HRESULT get_actionURL(BSTR* p);
}

@GUID("305900a9-98b5-11cf-bb82-00aa00bdce0b")
interface DispDOMSiteModeEvent : IDispatch
{
}

@GUID("30510722-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMStorageEvent : IDispatch
{
    HRESULT get_key(BSTR* p);
    HRESULT get_oldValue(BSTR* p);
    HRESULT get_newValue(BSTR* p);
    HRESULT get_url(BSTR* p);
    HRESULT get_storageArea(IHTMLStorage* p);
    HRESULT initStorageEvent(BSTR eventType, VARIANT_BOOL canBubble, VARIANT_BOOL cancelable, BSTR keyArg, 
                             BSTR oldValueArg, BSTR newValueArg, BSTR urlArg, IHTMLStorage storageAreaArg);
}

@GUID("30590093-98b5-11cf-bb82-00aa00bdce0b")
interface DispDOMStorageEvent : IDispatch
{
}

@GUID("30510830-98b5-11cf-bb82-00aa00bdce0b")
interface IXMLHttpRequestEventTarget : IDispatch
{
}

@GUID("305900e7-98b5-11cf-bb82-00aa00bdce0b")
interface DispXMLHttpRequestEventTarget : IDispatch
{
}

@GUID("30510498-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLXMLHttpRequestEvents : IDispatch
{
}

@GUID("3051040a-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLXMLHttpRequest : IDispatch
{
    HRESULT get_readyState(int* p);
    HRESULT get_responseBody(VARIANT* p);
    HRESULT get_responseText(BSTR* p);
    HRESULT get_responseXML(IDispatch* p);
    HRESULT get_status(int* p);
    HRESULT get_statusText(BSTR* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
    HRESULT abort();
    HRESULT open(BSTR bstrMethod, BSTR bstrUrl, VARIANT varAsync, VARIANT varUser, VARIANT varPassword);
    HRESULT send(VARIANT varBody);
    HRESULT getAllResponseHeaders(BSTR* __MIDL__IHTMLXMLHttpRequest0000);
    HRESULT getResponseHeader(BSTR bstrHeader, BSTR* __MIDL__IHTMLXMLHttpRequest0001);
    HRESULT setRequestHeader(BSTR bstrHeader, BSTR bstrValue);
}

@GUID("30510482-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLXMLHttpRequest2 : IDispatch
{
    HRESULT put_timeout(int v);
    HRESULT get_timeout(int* p);
    HRESULT put_ontimeout(VARIANT v);
    HRESULT get_ontimeout(VARIANT* p);
}

@GUID("3051040c-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLXMLHttpRequestFactory : IDispatch
{
    HRESULT create(IHTMLXMLHttpRequest* __MIDL__IHTMLXMLHttpRequestFactory0000);
}

@GUID("3050f596-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLXMLHttpRequest : IDispatch
{
}

@GUID("305104d3-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGAngle : IDispatch
{
    HRESULT put_unitType(short v);
    HRESULT get_unitType(short* p);
    HRESULT put_value(float v);
    HRESULT get_value(float* p);
    HRESULT put_valueInSpecifiedUnits(float v);
    HRESULT get_valueInSpecifiedUnits(float* p);
    HRESULT put_valueAsString(BSTR v);
    HRESULT get_valueAsString(BSTR* p);
    HRESULT newValueSpecifiedUnits(short unitType, float valueInSpecifiedUnits);
    HRESULT convertToSpecifiedUnits(short unitType);
}

@GUID("305104c5-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGElement : IDispatch
{
    HRESULT put_xmlbase(BSTR v);
    HRESULT get_xmlbase(BSTR* p);
    HRESULT putref_ownerSVGElement(ISVGSVGElement v);
    HRESULT get_ownerSVGElement(ISVGSVGElement* p);
    HRESULT putref_viewportElement(ISVGElement v);
    HRESULT get_viewportElement(ISVGElement* p);
    HRESULT putref_focusable(ISVGAnimatedEnumeration v);
    HRESULT get_focusable(ISVGAnimatedEnumeration* p);
}

@GUID("305104d7-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGRect : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT put_width(float v);
    HRESULT get_width(float* p);
    HRESULT put_height(float v);
    HRESULT get_height(float* p);
}

@GUID("305104f6-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGMatrix : IDispatch
{
    HRESULT put_a(float v);
    HRESULT get_a(float* p);
    HRESULT put_b(float v);
    HRESULT get_b(float* p);
    HRESULT put_c(float v);
    HRESULT get_c(float* p);
    HRESULT put_d(float v);
    HRESULT get_d(float* p);
    HRESULT put_e(float v);
    HRESULT get_e(float* p);
    HRESULT put_f(float v);
    HRESULT get_f(float* p);
    HRESULT multiply(ISVGMatrix secondMatrix, ISVGMatrix* ppResult);
    HRESULT inverse(ISVGMatrix* ppResult);
    HRESULT translate(float x, float y, ISVGMatrix* ppResult);
    HRESULT scale(float scaleFactor, ISVGMatrix* ppResult);
    HRESULT scaleNonUniform(float scaleFactorX, float scaleFactorY, ISVGMatrix* ppResult);
    HRESULT rotate(float angle, ISVGMatrix* ppResult);
    HRESULT rotateFromVector(float x, float y, ISVGMatrix* ppResult);
    HRESULT flipX(ISVGMatrix* ppResult);
    HRESULT flipY(ISVGMatrix* ppResult);
    HRESULT skewX(float angle, ISVGMatrix* ppResult);
    HRESULT skewY(float angle, ISVGMatrix* ppResult);
}

@GUID("305104c8-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGStringList : IDispatch
{
    HRESULT put_numberOfItems(int v);
    HRESULT get_numberOfItems(int* p);
    HRESULT clear();
    HRESULT initialize(BSTR newItem, BSTR* ppResult);
    HRESULT getItem(int index, BSTR* ppResult);
    HRESULT insertItemBefore(BSTR newItem, int index, BSTR* ppResult);
    HRESULT replaceItem(BSTR newItem, int index, BSTR* ppResult);
    HRESULT removeItem(int index, BSTR* ppResult);
    HRESULT appendItem(BSTR newItem, BSTR* ppResult);
}

@GUID("305104d8-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGAnimatedRect : IDispatch
{
    HRESULT putref_baseVal(ISVGRect v);
    HRESULT get_baseVal(ISVGRect* p);
    HRESULT putref_animVal(ISVGRect v);
    HRESULT get_animVal(ISVGRect* p);
}

@GUID("305104c7-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGAnimatedString : IDispatch
{
    HRESULT put_baseVal(BSTR v);
    HRESULT get_baseVal(BSTR* p);
    HRESULT get_animVal(BSTR* p);
}

@GUID("305104c6-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGAnimatedBoolean : IDispatch
{
    HRESULT put_baseVal(VARIANT_BOOL v);
    HRESULT get_baseVal(VARIANT_BOOL* p);
    HRESULT put_animVal(VARIANT_BOOL v);
    HRESULT get_animVal(VARIANT_BOOL* p);
}

@GUID("305104f9-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGAnimatedTransformList : IDispatch
{
    HRESULT putref_baseVal(ISVGTransformList v);
    HRESULT get_baseVal(ISVGTransformList* p);
    HRESULT putref_animVal(ISVGTransformList v);
    HRESULT get_animVal(ISVGTransformList* p);
}

@GUID("305104fb-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGAnimatedPreserveAspectRatio : IDispatch
{
    HRESULT putref_baseVal(ISVGPreserveAspectRatio v);
    HRESULT get_baseVal(ISVGPreserveAspectRatio* p);
    HRESULT putref_animVal(ISVGPreserveAspectRatio v);
    HRESULT get_animVal(ISVGPreserveAspectRatio* p);
}

@GUID("305104da-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGStylable : IDispatch
{
    HRESULT get_className(ISVGAnimatedString* p);
}

@GUID("305104db-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGLocatable : IDispatch
{
    HRESULT get_nearestViewportElement(ISVGElement* p);
    HRESULT get_farthestViewportElement(ISVGElement* p);
    HRESULT getBBox(ISVGRect* ppResult);
    HRESULT getCTM(ISVGMatrix* ppResult);
    HRESULT getScreenCTM(ISVGMatrix* ppResult);
    HRESULT getTransformToElement(ISVGElement pElement, ISVGMatrix* ppResult);
}

@GUID("305104dc-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGTransformable : IDispatch
{
    HRESULT get_transform(ISVGAnimatedTransformList* p);
}

@GUID("305104dd-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGTests : IDispatch
{
    HRESULT get_requiredFeatures(ISVGStringList* p);
    HRESULT get_requiredExtensions(ISVGStringList* p);
    HRESULT get_systemLanguage(ISVGStringList* p);
    HRESULT hasExtension(BSTR extension, VARIANT_BOOL* pResult);
}

@GUID("305104de-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGLangSpace : IDispatch
{
    HRESULT put_xmllang(BSTR v);
    HRESULT get_xmllang(BSTR* p);
    HRESULT put_xmlspace(BSTR v);
    HRESULT get_xmlspace(BSTR* p);
}

@GUID("305104df-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGExternalResourcesRequired : IDispatch
{
    HRESULT get_externalResourcesRequired(ISVGAnimatedBoolean* p);
}

@GUID("305104e0-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGFitToViewBox : IDispatch
{
    HRESULT get_viewBox(ISVGAnimatedRect* p);
    HRESULT putref_preserveAspectRatio(ISVGAnimatedPreserveAspectRatio v);
    HRESULT get_preserveAspectRatio(ISVGAnimatedPreserveAspectRatio* p);
}

@GUID("305104e1-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGZoomAndPan : IDispatch
{
    HRESULT get_zoomAndPan(short* p);
}

@GUID("305104e3-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGURIReference : IDispatch
{
    HRESULT get_href(ISVGAnimatedString* p);
}

@GUID("305104d4-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGAnimatedAngle : IDispatch
{
    HRESULT putref_baseVal(ISVGAngle v);
    HRESULT get_baseVal(ISVGAngle* p);
    HRESULT putref_animVal(ISVGAngle v);
    HRESULT get_animVal(ISVGAngle* p);
}

@GUID("305104f8-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGTransformList : IDispatch
{
    HRESULT put_numberOfItems(int v);
    HRESULT get_numberOfItems(int* p);
    HRESULT clear();
    HRESULT initialize(ISVGTransform newItem, ISVGTransform* ppResult);
    HRESULT getItem(int index, ISVGTransform* ppResult);
    HRESULT insertItemBefore(ISVGTransform newItem, int index, ISVGTransform* ppResult);
    HRESULT replaceItem(ISVGTransform newItem, int index, ISVGTransform* ppResult);
    HRESULT removeItem(int index, ISVGTransform* ppResult);
    HRESULT appendItem(ISVGTransform newItem, ISVGTransform* ppResult);
    HRESULT createSVGTransformFromMatrix(ISVGMatrix newItem, ISVGTransform* ppResult);
    HRESULT consolidate(ISVGTransform* ppResult);
}

@GUID("305104c9-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGAnimatedEnumeration : IDispatch
{
    HRESULT put_baseVal(ushort v);
    HRESULT get_baseVal(ushort* p);
    HRESULT put_animVal(ushort v);
    HRESULT get_animVal(ushort* p);
}

@GUID("305104ca-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGAnimatedInteger : IDispatch
{
    HRESULT put_baseVal(int v);
    HRESULT get_baseVal(int* p);
    HRESULT put_animVal(int v);
    HRESULT get_animVal(int* p);
}

@GUID("305104cf-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGLength : IDispatch
{
    HRESULT put_unitType(short v);
    HRESULT get_unitType(short* p);
    HRESULT put_value(float v);
    HRESULT get_value(float* p);
    HRESULT put_valueInSpecifiedUnits(float v);
    HRESULT get_valueInSpecifiedUnits(float* p);
    HRESULT put_valueAsString(BSTR v);
    HRESULT get_valueAsString(BSTR* p);
    HRESULT newValueSpecifiedUnits(short unitType, float valueInSpecifiedUnits);
    HRESULT convertToSpecifiedUnits(short unitType);
}

@GUID("305104d0-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGAnimatedLength : IDispatch
{
    HRESULT putref_baseVal(ISVGLength v);
    HRESULT get_baseVal(ISVGLength* p);
    HRESULT putref_animVal(ISVGLength v);
    HRESULT get_animVal(ISVGLength* p);
}

@GUID("305104d1-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGLengthList : IDispatch
{
    HRESULT put_numberOfItems(int v);
    HRESULT get_numberOfItems(int* p);
    HRESULT clear();
    HRESULT initialize(ISVGLength newItem, ISVGLength* ppResult);
    HRESULT getItem(int index, ISVGLength* ppResult);
    HRESULT insertItemBefore(ISVGLength newItem, int index, ISVGLength* ppResult);
    HRESULT replaceItem(ISVGLength newItem, int index, ISVGLength* ppResult);
    HRESULT removeItem(int index, ISVGLength* ppResult);
    HRESULT appendItem(ISVGLength newItem, ISVGLength* ppResult);
}

@GUID("305104d2-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGAnimatedLengthList : IDispatch
{
    HRESULT putref_baseVal(ISVGLengthList v);
    HRESULT get_baseVal(ISVGLengthList* p);
    HRESULT putref_animVal(ISVGLengthList v);
    HRESULT get_animVal(ISVGLengthList* p);
}

@GUID("305104cb-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGNumber : IDispatch
{
    HRESULT put_value(float v);
    HRESULT get_value(float* p);
}

@GUID("305104cc-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGAnimatedNumber : IDispatch
{
    HRESULT put_baseVal(float v);
    HRESULT get_baseVal(float* p);
    HRESULT put_animVal(float v);
    HRESULT get_animVal(float* p);
}

@GUID("305104cd-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGNumberList : IDispatch
{
    HRESULT put_numberOfItems(int v);
    HRESULT get_numberOfItems(int* p);
    HRESULT clear();
    HRESULT initialize(ISVGNumber newItem, ISVGNumber* ppResult);
    HRESULT getItem(int index, ISVGNumber* ppResult);
    HRESULT insertItemBefore(ISVGNumber newItem, int index, ISVGNumber* ppResult);
    HRESULT replaceItem(ISVGNumber newItem, int index, ISVGNumber* ppResult);
    HRESULT removeItem(int index, ISVGNumber* ppResult);
    HRESULT appendItem(ISVGNumber newItem, ISVGNumber* ppResult);
}

@GUID("305104ce-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGAnimatedNumberList : IDispatch
{
    HRESULT putref_baseVal(ISVGNumberList v);
    HRESULT get_baseVal(ISVGNumberList* p);
    HRESULT putref_animVal(ISVGNumberList v);
    HRESULT get_animVal(ISVGNumberList* p);
}

@GUID("3051052d-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGClipPathElement : IDispatch
{
    HRESULT putref_clipPathUnits(ISVGAnimatedEnumeration v);
    HRESULT get_clipPathUnits(ISVGAnimatedEnumeration* p);
}

@GUID("3059003b-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGClipPathElement : IDispatch
{
}

@GUID("305104e6-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGDocument : IDispatch
{
    HRESULT get_rootElement(ISVGSVGElement* p);
}

@GUID("305105ab-98b5-11cf-bb82-00aa00bdce0b")
interface IGetSVGDocument : IDispatch
{
    HRESULT getSVGDocument(IDispatch* ppSVGDocument);
}

@GUID("30590000-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGElement : IDispatch
{
}

@GUID("305104d6-98b5-11cf-bb82-00aa00bdce0b")
interface IICCSVGColor : IDispatch
{
}

@GUID("30510524-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPaint : IDispatch
{
}

@GUID("3051052c-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPatternElement : IDispatch
{
    HRESULT putref_patternUnits(ISVGAnimatedEnumeration v);
    HRESULT get_patternUnits(ISVGAnimatedEnumeration* p);
    HRESULT putref_patternContentUnits(ISVGAnimatedEnumeration v);
    HRESULT get_patternContentUnits(ISVGAnimatedEnumeration* p);
    HRESULT putref_patternTransform(ISVGAnimatedTransformList v);
    HRESULT get_patternTransform(ISVGAnimatedTransformList* p);
    HRESULT putref_x(ISVGAnimatedLength v);
    HRESULT get_x(ISVGAnimatedLength* p);
    HRESULT putref_y(ISVGAnimatedLength v);
    HRESULT get_y(ISVGAnimatedLength* p);
    HRESULT putref_width(ISVGAnimatedLength v);
    HRESULT get_width(ISVGAnimatedLength* p);
    HRESULT putref_height(ISVGAnimatedLength v);
    HRESULT get_height(ISVGAnimatedLength* p);
}

@GUID("3059002c-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGPatternElement : IDispatch
{
}

@GUID("305104fc-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPathSeg : IDispatch
{
    HRESULT put_pathSegType(short v);
    HRESULT get_pathSegType(short* p);
    HRESULT get_pathSegTypeAsLetter(BSTR* p);
}

@GUID("30510506-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPathSegArcAbs : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT put_r1(float v);
    HRESULT get_r1(float* p);
    HRESULT put_r2(float v);
    HRESULT get_r2(float* p);
    HRESULT put_angle(float v);
    HRESULT get_angle(float* p);
    HRESULT put_largeArcFlag(VARIANT_BOOL v);
    HRESULT get_largeArcFlag(VARIANT_BOOL* p);
    HRESULT put_sweepFlag(VARIANT_BOOL v);
    HRESULT get_sweepFlag(VARIANT_BOOL* p);
}

@GUID("30510507-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPathSegArcRel : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT put_r1(float v);
    HRESULT get_r1(float* p);
    HRESULT put_r2(float v);
    HRESULT get_r2(float* p);
    HRESULT put_angle(float v);
    HRESULT get_angle(float* p);
    HRESULT put_largeArcFlag(VARIANT_BOOL v);
    HRESULT get_largeArcFlag(VARIANT_BOOL* p);
    HRESULT put_sweepFlag(VARIANT_BOOL v);
    HRESULT get_sweepFlag(VARIANT_BOOL* p);
}

@GUID("305104fd-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPathSegClosePath : IDispatch
{
}

@GUID("305104fe-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPathSegMovetoAbs : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
}

@GUID("305104ff-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPathSegMovetoRel : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
}

@GUID("30510500-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPathSegLinetoAbs : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
}

@GUID("30510501-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPathSegLinetoRel : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
}

@GUID("30510502-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPathSegCurvetoCubicAbs : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT put_x1(float v);
    HRESULT get_x1(float* p);
    HRESULT put_y1(float v);
    HRESULT get_y1(float* p);
    HRESULT put_x2(float v);
    HRESULT get_x2(float* p);
    HRESULT put_y2(float v);
    HRESULT get_y2(float* p);
}

@GUID("30510503-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPathSegCurvetoCubicRel : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT put_x1(float v);
    HRESULT get_x1(float* p);
    HRESULT put_y1(float v);
    HRESULT get_y1(float* p);
    HRESULT put_x2(float v);
    HRESULT get_x2(float* p);
    HRESULT put_y2(float v);
    HRESULT get_y2(float* p);
}

@GUID("3051050c-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPathSegCurvetoCubicSmoothAbs : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT put_x2(float v);
    HRESULT get_x2(float* p);
    HRESULT put_y2(float v);
    HRESULT get_y2(float* p);
}

@GUID("3051050d-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPathSegCurvetoCubicSmoothRel : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT put_x2(float v);
    HRESULT get_x2(float* p);
    HRESULT put_y2(float v);
    HRESULT get_y2(float* p);
}

@GUID("30510504-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPathSegCurvetoQuadraticAbs : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT put_x1(float v);
    HRESULT get_x1(float* p);
    HRESULT put_y1(float v);
    HRESULT get_y1(float* p);
}

@GUID("30510505-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPathSegCurvetoQuadraticRel : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT put_x1(float v);
    HRESULT get_x1(float* p);
    HRESULT put_y1(float v);
    HRESULT get_y1(float* p);
}

@GUID("3051050e-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPathSegCurvetoQuadraticSmoothAbs : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
}

@GUID("3051050f-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPathSegCurvetoQuadraticSmoothRel : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
}

@GUID("30510508-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPathSegLinetoHorizontalAbs : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
}

@GUID("30510509-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPathSegLinetoHorizontalRel : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
}

@GUID("3051050a-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPathSegLinetoVerticalAbs : IDispatch
{
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
}

@GUID("3051050b-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPathSegLinetoVerticalRel : IDispatch
{
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
}

@GUID("30590013-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGPathSegArcAbs : IDispatch
{
}

@GUID("30590014-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGPathSegArcRel : IDispatch
{
}

@GUID("30590015-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGPathSegClosePath : IDispatch
{
}

@GUID("30590024-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGPathSegMovetoAbs : IDispatch
{
}

@GUID("30590025-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGPathSegMovetoRel : IDispatch
{
}

@GUID("3059001e-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGPathSegLinetoAbs : IDispatch
{
}

@GUID("30590021-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGPathSegLinetoRel : IDispatch
{
}

@GUID("30590016-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGPathSegCurvetoCubicAbs : IDispatch
{
}

@GUID("30590017-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGPathSegCurvetoCubicRel : IDispatch
{
}

@GUID("30590018-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGPathSegCurvetoCubicSmoothAbs : IDispatch
{
}

@GUID("30590019-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGPathSegCurvetoCubicSmoothRel : IDispatch
{
}

@GUID("3059001a-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGPathSegCurvetoQuadraticAbs : IDispatch
{
}

@GUID("3059001b-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGPathSegCurvetoQuadraticRel : IDispatch
{
}

@GUID("3059001c-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGPathSegCurvetoQuadraticSmoothAbs : IDispatch
{
}

@GUID("3059001d-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGPathSegCurvetoQuadraticSmoothRel : IDispatch
{
}

@GUID("3059001f-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGPathSegLinetoHorizontalAbs : IDispatch
{
}

@GUID("30590020-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGPathSegLinetoHorizontalRel : IDispatch
{
}

@GUID("30590022-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGPathSegLinetoVerticalAbs : IDispatch
{
}

@GUID("30590023-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGPathSegLinetoVerticalRel : IDispatch
{
}

@GUID("30510510-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPathSegList : IDispatch
{
    HRESULT put_numberOfItems(int v);
    HRESULT get_numberOfItems(int* p);
    HRESULT clear();
    HRESULT initialize(ISVGPathSeg newItem, ISVGPathSeg* ppResult);
    HRESULT getItem(int index, ISVGPathSeg* ppResult);
    HRESULT insertItemBefore(ISVGPathSeg newItem, int index, ISVGPathSeg* ppResult);
    HRESULT replaceItem(ISVGPathSeg newItem, int index, ISVGPathSeg* ppResult);
    HRESULT removeItem(int index, ISVGPathSeg* ppResult);
    HRESULT appendItem(ISVGPathSeg newItem, ISVGPathSeg* ppResult);
}

@GUID("305104f4-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPoint : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT matrixTransform(ISVGMatrix pMatrix, ISVGPoint* ppResult);
}

@GUID("305104f5-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPointList : IDispatch
{
    HRESULT put_numberOfItems(int v);
    HRESULT get_numberOfItems(int* p);
    HRESULT clear();
    HRESULT initialize(ISVGPoint pNewItem, ISVGPoint* ppResult);
    HRESULT getItem(int index, ISVGPoint* ppResult);
    HRESULT insertItemBefore(ISVGPoint pNewItem, int index, ISVGPoint* ppResult);
    HRESULT replaceItem(ISVGPoint pNewItem, int index, ISVGPoint* ppResult);
    HRESULT removeItem(int index, ISVGPoint* ppResult);
    HRESULT appendItem(ISVGPoint pNewItem, ISVGPoint* ppResult);
}

@GUID("305104e2-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGViewSpec : IDispatch
{
}

@GUID("305104f7-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGTransform : IDispatch
{
    HRESULT put_type(short v);
    HRESULT get_type(short* p);
    HRESULT putref_matrix(ISVGMatrix v);
    HRESULT get_matrix(ISVGMatrix* p);
    HRESULT put_angle(float v);
    HRESULT get_angle(float* p);
    HRESULT setMatrix(ISVGMatrix matrix);
    HRESULT setTranslate(float tx, float ty);
    HRESULT setScale(float sx, float sy);
    HRESULT setRotate(float angle, float cx, float cy);
    HRESULT setSkewX(float angle);
    HRESULT setSkewY(float angle);
}

@GUID("30590001-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGSVGElement : IDispatch
{
}

@GUID("305104ee-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGElementInstance : IDispatch
{
    HRESULT get_correspondingElement(ISVGElement* p);
    HRESULT get_correspondingUseElement(ISVGUseElement* p);
    HRESULT get_parentNode(ISVGElementInstance* p);
    HRESULT get_childNodes(ISVGElementInstanceList* p);
    HRESULT get_firstChild(ISVGElementInstance* p);
    HRESULT get_lastChild(ISVGElementInstance* p);
    HRESULT get_previousSibling(ISVGElementInstance* p);
    HRESULT get_nextSibling(ISVGElementInstance* p);
}

@GUID("305104ed-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGUseElement : IDispatch
{
    HRESULT putref_x(ISVGAnimatedLength v);
    HRESULT get_x(ISVGAnimatedLength* p);
    HRESULT putref_y(ISVGAnimatedLength v);
    HRESULT get_y(ISVGAnimatedLength* p);
    HRESULT putref_width(ISVGAnimatedLength v);
    HRESULT get_width(ISVGAnimatedLength* p);
    HRESULT putref_height(ISVGAnimatedLength v);
    HRESULT get_height(ISVGAnimatedLength* p);
    HRESULT putref_instanceRoot(ISVGElementInstance v);
    HRESULT get_instanceRoot(ISVGElementInstance* p);
    HRESULT putref_animatedInstanceRoot(ISVGElementInstance v);
    HRESULT get_animatedInstanceRoot(ISVGElementInstance* p);
}

@GUID("30590010-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGUseElement : IDispatch
{
}

@GUID("305104c0-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLStyleSheetRulesAppliedCollection : IDispatch
{
    HRESULT item(int index, IHTMLStyleSheetRule* ppHTMLStyleSheetRule);
    HRESULT get_length(int* p);
    HRESULT propertyAppliedBy(BSTR name, IHTMLStyleSheetRule* ppRule);
    HRESULT propertyAppliedTrace(BSTR name, int index, IHTMLStyleSheetRule* ppRule);
    HRESULT propertyAppliedTraceLength(BSTR name, int* pLength);
}

@GUID("305104bf-98b5-11cf-bb82-00aa00bdce0b")
interface IRulesApplied : IDispatch
{
    HRESULT get_element(IHTMLElement* p);
    HRESULT get_inlineStyles(IHTMLStyle* p);
    HRESULT get_appliedRules(IHTMLStyleSheetRulesAppliedCollection* p);
    HRESULT propertyIsInline(BSTR name, VARIANT_BOOL* p);
    HRESULT propertyIsInheritable(BSTR name, VARIANT_BOOL* p);
    HRESULT hasInheritableProperty(VARIANT_BOOL* p);
}

@GUID("3050f5a6-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLStyleSheetRulesAppliedCollection : IDispatch
{
}

@GUID("3050f5a5-98b5-11cf-bb82-00aa00bdce0b")
interface DispRulesApplied : IDispatch
{
}

@GUID("3050f5a4-98b5-11cf-bb82-00aa00bdce0b")
interface DispRulesAppliedCollection : IDispatch
{
}

@GUID("30590070-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLW3CComputedStyle : IDispatch
{
}

@GUID("30510517-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGAnimatedPoints : IDispatch
{
    HRESULT putref_points(ISVGPointList v);
    HRESULT get_points(ISVGPointList* p);
    HRESULT putref_animatedPoints(ISVGPointList v);
    HRESULT get_animatedPoints(ISVGPointList* p);
}

@GUID("30510514-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGCircleElement : IDispatch
{
    HRESULT putref_cx(ISVGAnimatedLength v);
    HRESULT get_cx(ISVGAnimatedLength* p);
    HRESULT putref_cy(ISVGAnimatedLength v);
    HRESULT get_cy(ISVGAnimatedLength* p);
    HRESULT putref_r(ISVGAnimatedLength v);
    HRESULT get_r(ISVGAnimatedLength* p);
}

@GUID("30510515-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGEllipseElement : IDispatch
{
    HRESULT putref_cx(ISVGAnimatedLength v);
    HRESULT get_cx(ISVGAnimatedLength* p);
    HRESULT putref_cy(ISVGAnimatedLength v);
    HRESULT get_cy(ISVGAnimatedLength* p);
    HRESULT putref_rx(ISVGAnimatedLength v);
    HRESULT get_rx(ISVGAnimatedLength* p);
    HRESULT putref_ry(ISVGAnimatedLength v);
    HRESULT get_ry(ISVGAnimatedLength* p);
}

@GUID("30510516-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGLineElement : IDispatch
{
    HRESULT putref_x1(ISVGAnimatedLength v);
    HRESULT get_x1(ISVGAnimatedLength* p);
    HRESULT putref_y1(ISVGAnimatedLength v);
    HRESULT get_y1(ISVGAnimatedLength* p);
    HRESULT putref_x2(ISVGAnimatedLength v);
    HRESULT get_x2(ISVGAnimatedLength* p);
    HRESULT putref_y2(ISVGAnimatedLength v);
    HRESULT get_y2(ISVGAnimatedLength* p);
}

@GUID("30510513-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGRectElement : IDispatch
{
    HRESULT putref_x(ISVGAnimatedLength v);
    HRESULT get_x(ISVGAnimatedLength* p);
    HRESULT putref_y(ISVGAnimatedLength v);
    HRESULT get_y(ISVGAnimatedLength* p);
    HRESULT putref_width(ISVGAnimatedLength v);
    HRESULT get_width(ISVGAnimatedLength* p);
    HRESULT putref_height(ISVGAnimatedLength v);
    HRESULT get_height(ISVGAnimatedLength* p);
    HRESULT putref_rx(ISVGAnimatedLength v);
    HRESULT get_rx(ISVGAnimatedLength* p);
    HRESULT putref_ry(ISVGAnimatedLength v);
    HRESULT get_ry(ISVGAnimatedLength* p);
}

@GUID("30510519-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPolygonElement : IDispatch
{
}

@GUID("30510518-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPolylineElement : IDispatch
{
}

@GUID("3059000a-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGCircleElement : IDispatch
{
}

@GUID("3059000b-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGEllipseElement : IDispatch
{
}

@GUID("3059000c-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGLineElement : IDispatch
{
}

@GUID("30590009-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGRectElement : IDispatch
{
}

@GUID("3059000d-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGPolygonElement : IDispatch
{
}

@GUID("3059000e-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGPolylineElement : IDispatch
{
}

@GUID("305104e8-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGGElement : IDispatch
{
}

@GUID("30590002-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGGElement : IDispatch
{
}

@GUID("305104ec-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGSymbolElement : IDispatch
{
}

@GUID("30590004-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGSymbolElement : IDispatch
{
}

@GUID("305104e9-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGDefsElement : IDispatch
{
}

@GUID("30590003-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGDefsElement : IDispatch
{
}

@GUID("30510511-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGAnimatedPathData : IDispatch
{
    HRESULT putref_pathSegList(ISVGPathSegList v);
    HRESULT get_pathSegList(ISVGPathSegList* p);
    HRESULT putref_normalizedPathSegList(ISVGPathSegList v);
    HRESULT get_normalizedPathSegList(ISVGPathSegList* p);
    HRESULT putref_animatedPathSegList(ISVGPathSegList v);
    HRESULT get_animatedPathSegList(ISVGPathSegList* p);
    HRESULT putref_animatedNormalizedPathSegList(ISVGPathSegList v);
    HRESULT get_animatedNormalizedPathSegList(ISVGPathSegList* p);
}

@GUID("30510512-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPathElement : IDispatch
{
    HRESULT putref_pathLength(ISVGAnimatedNumber v);
    HRESULT get_pathLength(ISVGAnimatedNumber* p);
    HRESULT getTotalLength(float* pfltResult);
    HRESULT getPointAtLength(float fltdistance, ISVGPoint* ppPointResult);
    HRESULT getPathSegAtLength(float fltdistance, int* plResult);
    HRESULT createSVGPathSegClosePath(ISVGPathSegClosePath* ppResult);
    HRESULT createSVGPathSegMovetoAbs(float x, float y, ISVGPathSegMovetoAbs* ppResult);
    HRESULT createSVGPathSegMovetoRel(float x, float y, ISVGPathSegMovetoRel* ppResult);
    HRESULT createSVGPathSegLinetoAbs(float x, float y, ISVGPathSegLinetoAbs* ppResult);
    HRESULT createSVGPathSegLinetoRel(float x, float y, ISVGPathSegLinetoRel* ppResult);
    HRESULT createSVGPathSegCurvetoCubicAbs(float x, float y, float x1, float y1, float x2, float y2, 
                                            ISVGPathSegCurvetoCubicAbs* ppResult);
    HRESULT createSVGPathSegCurvetoCubicRel(float x, float y, float x1, float y1, float x2, float y2, 
                                            ISVGPathSegCurvetoCubicRel* ppResult);
    HRESULT createSVGPathSegCurvetoQuadraticAbs(float x, float y, float x1, float y1, 
                                                ISVGPathSegCurvetoQuadraticAbs* ppResult);
    HRESULT createSVGPathSegCurvetoQuadraticRel(float x, float y, float x1, float y1, 
                                                ISVGPathSegCurvetoQuadraticRel* ppResult);
    HRESULT createSVGPathSegArcAbs(float x, float y, float r1, float r2, float angle, VARIANT_BOOL largeArcFlag, 
                                   VARIANT_BOOL sweepFlag, ISVGPathSegArcAbs* ppResult);
    HRESULT createSVGPathSegArcRel(float x, float y, float r1, float r2, float angle, VARIANT_BOOL largeArcFlag, 
                                   VARIANT_BOOL sweepFlag, ISVGPathSegArcRel* ppResult);
    HRESULT createSVGPathSegLinetoHorizontalAbs(float x, ISVGPathSegLinetoHorizontalAbs* ppResult);
    HRESULT createSVGPathSegLinetoHorizontalRel(float x, ISVGPathSegLinetoHorizontalRel* ppResult);
    HRESULT createSVGPathSegLinetoVerticalAbs(float y, ISVGPathSegLinetoVerticalAbs* ppResult);
    HRESULT createSVGPathSegLinetoVerticalRel(float y, ISVGPathSegLinetoVerticalRel* ppResult);
    HRESULT createSVGPathSegCurvetoCubicSmoothAbs(float x, float y, float x2, float y2, 
                                                  ISVGPathSegCurvetoCubicSmoothAbs* ppResult);
    HRESULT createSVGPathSegCurvetoCubicSmoothRel(float x, float y, float x2, float y2, 
                                                  ISVGPathSegCurvetoCubicSmoothRel* ppResult);
    HRESULT createSVGPathSegCurvetoQuadraticSmoothAbs(float x, float y, 
                                                      ISVGPathSegCurvetoQuadraticSmoothAbs* ppResult);
    HRESULT createSVGPathSegCurvetoQuadraticSmoothRel(float x, float y, 
                                                      ISVGPathSegCurvetoQuadraticSmoothRel* ppResult);
}

@GUID("30590011-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGPathElement : IDispatch
{
}

@GUID("305104fa-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGPreserveAspectRatio : IDispatch
{
    HRESULT put_align(short v);
    HRESULT get_align(short* p);
    HRESULT put_meetOrSlice(short v);
    HRESULT get_meetOrSlice(short* p);
}

@GUID("3051051c-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGTextElement : IDispatch
{
}

@GUID("30590037-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGTextElement : IDispatch
{
}

@GUID("305104f0-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGImageElement : IDispatch
{
    HRESULT putref_x(ISVGAnimatedLength v);
    HRESULT get_x(ISVGAnimatedLength* p);
    HRESULT putref_y(ISVGAnimatedLength v);
    HRESULT get_y(ISVGAnimatedLength* p);
    HRESULT putref_width(ISVGAnimatedLength v);
    HRESULT get_width(ISVGAnimatedLength* p);
    HRESULT putref_height(ISVGAnimatedLength v);
    HRESULT get_height(ISVGAnimatedLength* p);
}

@GUID("30590027-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGImageElement : IDispatch
{
}

@GUID("3051052b-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGStopElement : IDispatch
{
    HRESULT putref_offset(ISVGAnimatedNumber v);
    HRESULT get_offset(ISVGAnimatedNumber* p);
}

@GUID("3059002d-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGStopElement : IDispatch
{
}

@GUID("30510528-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGGradientElement : IDispatch
{
    HRESULT putref_gradientUnits(ISVGAnimatedEnumeration v);
    HRESULT get_gradientUnits(ISVGAnimatedEnumeration* p);
    HRESULT putref_gradientTransform(ISVGAnimatedTransformList v);
    HRESULT get_gradientTransform(ISVGAnimatedTransformList* p);
    HRESULT putref_spreadMethod(ISVGAnimatedEnumeration v);
    HRESULT get_spreadMethod(ISVGAnimatedEnumeration* p);
}

@GUID("3059002e-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGGradientElement : IDispatch
{
}

@GUID("30510529-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGLinearGradientElement : IDispatch
{
    HRESULT putref_x1(ISVGAnimatedLength v);
    HRESULT get_x1(ISVGAnimatedLength* p);
    HRESULT putref_y1(ISVGAnimatedLength v);
    HRESULT get_y1(ISVGAnimatedLength* p);
    HRESULT putref_x2(ISVGAnimatedLength v);
    HRESULT get_x2(ISVGAnimatedLength* p);
    HRESULT putref_y2(ISVGAnimatedLength v);
    HRESULT get_y2(ISVGAnimatedLength* p);
}

@GUID("3059002a-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGLinearGradientElement : IDispatch
{
}

@GUID("3051052a-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGRadialGradientElement : IDispatch
{
    HRESULT putref_cx(ISVGAnimatedLength v);
    HRESULT get_cx(ISVGAnimatedLength* p);
    HRESULT putref_cy(ISVGAnimatedLength v);
    HRESULT get_cy(ISVGAnimatedLength* p);
    HRESULT putref_r(ISVGAnimatedLength v);
    HRESULT get_r(ISVGAnimatedLength* p);
    HRESULT putref_fx(ISVGAnimatedLength v);
    HRESULT get_fx(ISVGAnimatedLength* p);
    HRESULT putref_fy(ISVGAnimatedLength v);
    HRESULT get_fy(ISVGAnimatedLength* p);
}

@GUID("3059002b-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGRadialGradientElement : IDispatch
{
}

@GUID("3051052e-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGMaskElement : IDispatch
{
    HRESULT putref_maskUnits(ISVGAnimatedEnumeration v);
    HRESULT get_maskUnits(ISVGAnimatedEnumeration* p);
    HRESULT putref_maskContentUnits(ISVGAnimatedEnumeration v);
    HRESULT get_maskContentUnits(ISVGAnimatedEnumeration* p);
    HRESULT putref_x(ISVGAnimatedLength v);
    HRESULT get_x(ISVGAnimatedLength* p);
    HRESULT putref_y(ISVGAnimatedLength v);
    HRESULT get_y(ISVGAnimatedLength* p);
    HRESULT putref_width(ISVGAnimatedLength v);
    HRESULT get_width(ISVGAnimatedLength* p);
    HRESULT putref_height(ISVGAnimatedLength v);
    HRESULT get_height(ISVGAnimatedLength* p);
}

@GUID("3059003c-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGMaskElement : IDispatch
{
}

@GUID("30510525-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGMarkerElement : IDispatch
{
    HRESULT putref_refX(ISVGAnimatedLength v);
    HRESULT get_refX(ISVGAnimatedLength* p);
    HRESULT putref_refY(ISVGAnimatedLength v);
    HRESULT get_refY(ISVGAnimatedLength* p);
    HRESULT putref_markerUnits(ISVGAnimatedEnumeration v);
    HRESULT get_markerUnits(ISVGAnimatedEnumeration* p);
    HRESULT putref_markerWidth(ISVGAnimatedLength v);
    HRESULT get_markerWidth(ISVGAnimatedLength* p);
    HRESULT putref_markerHeight(ISVGAnimatedLength v);
    HRESULT get_markerHeight(ISVGAnimatedLength* p);
    HRESULT putref_orientType(ISVGAnimatedEnumeration v);
    HRESULT get_orientType(ISVGAnimatedEnumeration* p);
    HRESULT putref_orientAngle(ISVGAnimatedAngle v);
    HRESULT get_orientAngle(ISVGAnimatedAngle* p);
    HRESULT setOrientToAuto();
    HRESULT setOrientToAngle(ISVGAngle pSVGAngle);
}

@GUID("30590036-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGMarkerElement : IDispatch
{
}

@GUID("3051054e-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGZoomEvent : IDispatch
{
    HRESULT get_zoomRectScreen(ISVGRect* p);
    HRESULT get_previousScale(float* p);
    HRESULT get_previousTranslate(ISVGPoint* p);
    HRESULT get_newScale(float* p);
    HRESULT get_newTranslate(ISVGPoint* p);
}

@GUID("30590031-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGZoomEvent : IDispatch
{
}

@GUID("3051054b-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGAElement : IDispatch
{
    HRESULT putref_target(ISVGAnimatedString v);
    HRESULT get_target(ISVGAnimatedString* p);
}

@GUID("30590033-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGAElement : IDispatch
{
}

@GUID("3051054c-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGViewElement : IDispatch
{
    HRESULT putref_viewTarget(ISVGStringList v);
    HRESULT get_viewTarget(ISVGStringList* p);
}

@GUID("30590034-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGViewElement : IDispatch
{
}

@GUID("30510704-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLMediaError : IDispatch
{
    HRESULT get_code(short* p);
}

@GUID("30510705-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTimeRanges : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT start(int index, float* startTime);
    HRESULT end(int index, float* endTime);
}

@GUID("3051080b-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLTimeRanges2 : IDispatch
{
    HRESULT startDouble(int index, double* startTime);
    HRESULT endDouble(int index, double* endTime);
}

@GUID("30510706-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLMediaElement : IDispatch
{
    HRESULT get_error(IHTMLMediaError* p);
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT get_currentSrc(BSTR* p);
    HRESULT get_networkState(ushort* p);
    HRESULT put_preload(BSTR v);
    HRESULT get_preload(BSTR* p);
    HRESULT get_buffered(IHTMLTimeRanges* p);
    HRESULT load();
    HRESULT canPlayType(BSTR type, BSTR* canPlay);
    HRESULT get_seeking(VARIANT_BOOL* p);
    HRESULT put_currentTime(float v);
    HRESULT get_currentTime(float* p);
    HRESULT get_initialTime(float* p);
    HRESULT get_duration(float* p);
    HRESULT get_paused(VARIANT_BOOL* p);
    HRESULT put_defaultPlaybackRate(float v);
    HRESULT get_defaultPlaybackRate(float* p);
    HRESULT put_playbackRate(float v);
    HRESULT get_playbackRate(float* p);
    HRESULT get_played(IHTMLTimeRanges* p);
    HRESULT get_seekable(IHTMLTimeRanges* p);
    HRESULT get_ended(VARIANT_BOOL* p);
    HRESULT put_autoplay(VARIANT_BOOL v);
    HRESULT get_autoplay(VARIANT_BOOL* p);
    HRESULT put_loop(VARIANT_BOOL v);
    HRESULT get_loop(VARIANT_BOOL* p);
    HRESULT play();
    HRESULT pause();
    HRESULT put_controls(VARIANT_BOOL v);
    HRESULT get_controls(VARIANT_BOOL* p);
    HRESULT put_volume(float v);
    HRESULT get_volume(float* p);
    HRESULT put_muted(VARIANT_BOOL v);
    HRESULT get_muted(VARIANT_BOOL* p);
    HRESULT put_autobuffer(VARIANT_BOOL v);
    HRESULT get_autobuffer(VARIANT_BOOL* p);
}

@GUID("30510809-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLMediaElement2 : IDispatch
{
    HRESULT put_currentTimeDouble(double v);
    HRESULT get_currentTimeDouble(double* p);
    HRESULT get_initialTimeDouble(double* p);
    HRESULT get_durationDouble(double* p);
    HRESULT put_defaultPlaybackRateDouble(double v);
    HRESULT get_defaultPlaybackRateDouble(double* p);
    HRESULT put_playbackRateDouble(double v);
    HRESULT get_playbackRateDouble(double* p);
    HRESULT put_volumeDouble(double v);
    HRESULT get_volumeDouble(double* p);
}

@GUID("30510792-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLMSMediaElement : IDispatch
{
    HRESULT put_msPlayToDisabled(VARIANT_BOOL v);
    HRESULT get_msPlayToDisabled(VARIANT_BOOL* p);
    HRESULT put_msPlayToPrimary(VARIANT_BOOL v);
    HRESULT get_msPlayToPrimary(VARIANT_BOOL* p);
}

@GUID("30510707-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLSourceElement : IDispatch
{
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT put_media(BSTR v);
    HRESULT get_media(BSTR* p);
}

@GUID("30510708-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLAudioElement : IDispatch
{
}

@GUID("30510709-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLVideoElement : IDispatch
{
    HRESULT put_width(int v);
    HRESULT get_width(int* p);
    HRESULT put_height(int v);
    HRESULT get_height(int* p);
    HRESULT get_videoWidth(uint* p);
    HRESULT get_videoHeight(uint* p);
    HRESULT put_poster(BSTR v);
    HRESULT get_poster(BSTR* p);
}

@GUID("305107eb-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLAudioElementFactory : IDispatch
{
    HRESULT create(VARIANT src, IHTMLAudioElement* __MIDL__IHTMLAudioElementFactory0000);
}

@GUID("30590086-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLMediaError : IDispatch
{
}

@GUID("30590087-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLTimeRanges : IDispatch
{
}

@GUID("30590088-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLMediaElement : IDispatch
{
}

@GUID("30590089-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLSourceElement : IDispatch
{
}

@GUID("3059008a-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLAudioElement : IDispatch
{
}

@GUID("3059008b-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLVideoElement : IDispatch
{
}

@GUID("305104f1-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGSwitchElement : IDispatch
{
}

@GUID("30590030-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGSwitchElement : IDispatch
{
}

@GUID("305104ea-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGDescElement : IDispatch
{
}

@GUID("30590005-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGDescElement : IDispatch
{
}

@GUID("305104eb-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGTitleElement : IDispatch
{
}

@GUID("30590006-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGTitleElement : IDispatch
{
}

@GUID("30510560-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGMetadataElement : IDispatch
{
}

@GUID("3059002f-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGMetadataElement : IDispatch
{
}

@GUID("305104ef-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGElementInstanceList : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT item(int index, ISVGElementInstance* ppResult);
}

@GUID("30590007-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGElementInstance : IDispatch
{
}

@GUID("30590008-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGElementInstanceList : IDispatch
{
}

@GUID("3051072b-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMException : IDispatch
{
    HRESULT put_code(int v);
    HRESULT get_code(int* p);
    HRESULT get_message(BSTR* p);
}

@GUID("30590094-98b5-11cf-bb82-00aa00bdce0b")
interface DispDOMException : IDispatch
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-irangeexception
@GUID("3051072d-98b5-11cf-bb82-00aa00bdce0b")
interface IRangeException : IDispatch
{
    HRESULT put_code(int v);
    HRESULT get_code(int* p);
    HRESULT get_message(BSTR* p);
}

@GUID("30590095-98b5-11cf-bb82-00aa00bdce0b")
interface DispRangeException : IDispatch
{
}

@GUID("3051072f-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGException : IDispatch
{
    HRESULT put_code(int v);
    HRESULT get_code(int* p);
    HRESULT get_message(BSTR* p);
}

@GUID("30590096-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGException : IDispatch
{
}

@GUID("3051073a-98b5-11cf-bb82-00aa00bdce0b")
interface IEventException : IDispatch
{
    HRESULT put_code(int v);
    HRESULT get_code(int* p);
    HRESULT get_message(BSTR* p);
}

@GUID("30590099-98b5-11cf-bb82-00aa00bdce0b")
interface DispEventException : IDispatch
{
}

@GUID("3051054d-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGScriptElement : IDispatch
{
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
}

@GUID("30590039-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGScriptElement : IDispatch
{
}

@GUID("305104f3-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGStyleElement : IDispatch
{
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT put_media(BSTR v);
    HRESULT get_media(BSTR* p);
}

@GUID("30590029-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGStyleElement : IDispatch
{
}

@GUID("3051051a-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGTextContentElement : IDispatch
{
    HRESULT putref_textLength(ISVGAnimatedLength v);
    HRESULT get_textLength(ISVGAnimatedLength* p);
    HRESULT putref_lengthAdjust(ISVGAnimatedEnumeration v);
    HRESULT get_lengthAdjust(ISVGAnimatedEnumeration* p);
    HRESULT getNumberOfChars(int* pResult);
    HRESULT getComputedTextLength(float* pResult);
    HRESULT getSubStringLength(int charnum, int nchars, float* pResult);
    HRESULT getStartPositionOfChar(int charnum, ISVGPoint* ppResult);
    HRESULT getEndPositionOfChar(int charnum, ISVGPoint* ppResult);
    HRESULT getExtentOfChar(int charnum, ISVGRect* ppResult);
    HRESULT getRotationOfChar(int charnum, float* pResult);
    HRESULT getCharNumAtPosition(ISVGPoint point, int* pResult);
    HRESULT selectSubString(int charnum, int nchars);
}

@GUID("30590035-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGTextContentElement : IDispatch
{
}

@GUID("3051051b-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGTextPositioningElement : IDispatch
{
    HRESULT putref_x(ISVGAnimatedLengthList v);
    HRESULT get_x(ISVGAnimatedLengthList* p);
    HRESULT putref_y(ISVGAnimatedLengthList v);
    HRESULT get_y(ISVGAnimatedLengthList* p);
    HRESULT putref_dx(ISVGAnimatedLengthList v);
    HRESULT get_dx(ISVGAnimatedLengthList* p);
    HRESULT putref_dy(ISVGAnimatedLengthList v);
    HRESULT get_dy(ISVGAnimatedLengthList* p);
    HRESULT putref_rotate(ISVGAnimatedNumberList v);
    HRESULT get_rotate(ISVGAnimatedNumberList* p);
}

@GUID("30590038-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGTextPositioningElement : IDispatch
{
}

@GUID("30590098-98b5-11cf-bb82-00aa00bdce0b")
interface DispDOMDocumentType : IDispatch
{
}

@GUID("3059009c-98b5-11cf-bb82-00aa00bdce0b")
interface DispNodeIterator : IDispatch
{
}

@GUID("3059009d-98b5-11cf-bb82-00aa00bdce0b")
interface DispTreeWalker : IDispatch
{
}

@GUID("3059009b-98b5-11cf-bb82-00aa00bdce0b")
interface DispDOMProcessingInstruction : IDispatch
{
}

@GUID("30510750-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLPerformanceNavigation : IDispatch
{
    HRESULT get_type(uint* p);
    HRESULT get_redirectCount(uint* p);
    HRESULT toString(BSTR* string);
    HRESULT toJSON(VARIANT* pVar);
}

@GUID("30510752-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLPerformanceTiming : IDispatch
{
    HRESULT get_navigationStart(ulong* p);
    HRESULT get_unloadEventStart(ulong* p);
    HRESULT get_unloadEventEnd(ulong* p);
    HRESULT get_redirectStart(ulong* p);
    HRESULT get_redirectEnd(ulong* p);
    HRESULT get_fetchStart(ulong* p);
    HRESULT get_domainLookupStart(ulong* p);
    HRESULT get_domainLookupEnd(ulong* p);
    HRESULT get_connectStart(ulong* p);
    HRESULT get_connectEnd(ulong* p);
    HRESULT get_requestStart(ulong* p);
    HRESULT get_responseStart(ulong* p);
    HRESULT get_responseEnd(ulong* p);
    HRESULT get_domLoading(ulong* p);
    HRESULT get_domInteractive(ulong* p);
    HRESULT get_domContentLoadedEventStart(ulong* p);
    HRESULT get_domContentLoadedEventEnd(ulong* p);
    HRESULT get_domComplete(ulong* p);
    HRESULT get_loadEventStart(ulong* p);
    HRESULT get_loadEventEnd(ulong* p);
    HRESULT get_msFirstPaint(ulong* p);
    HRESULT toString(BSTR* string);
    HRESULT toJSON(VARIANT* pVar);
}

@GUID("3059009f-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLPerformance : IDispatch
{
}

@GUID("305900a0-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLPerformanceNavigation : IDispatch
{
}

@GUID("305900a1-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLPerformanceTiming : IDispatch
{
}

@GUID("3051051d-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGTSpanElement : IDispatch
{
}

@GUID("3059003a-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGTSpanElement : IDispatch
{
}

@GUID("3050f6b4-98b5-11cf-bb82-00aa00bdce0b")
interface ITemplatePrinter : IDispatch
{
    HRESULT startDoc(BSTR bstrTitle, VARIANT_BOOL* p);
    HRESULT stopDoc();
    HRESULT printBlankPage();
    HRESULT printPage(IDispatch pElemDisp);
    HRESULT ensurePrintDialogDefaults(VARIANT_BOOL* p);
    HRESULT showPrintDialog(VARIANT_BOOL* p);
    HRESULT showPageSetupDialog(VARIANT_BOOL* p);
    HRESULT printNonNative(IUnknown pMarkup, VARIANT_BOOL* p);
    HRESULT printNonNativeFrames(IUnknown pMarkup, VARIANT_BOOL fActiveFrame);
    HRESULT put_framesetDocument(VARIANT_BOOL v);
    HRESULT get_framesetDocument(VARIANT_BOOL* p);
    HRESULT put_frameActive(VARIANT_BOOL v);
    HRESULT get_frameActive(VARIANT_BOOL* p);
    HRESULT put_frameAsShown(VARIANT_BOOL v);
    HRESULT get_frameAsShown(VARIANT_BOOL* p);
    HRESULT put_selection(VARIANT_BOOL v);
    HRESULT get_selection(VARIANT_BOOL* p);
    HRESULT put_selectedPages(VARIANT_BOOL v);
    HRESULT get_selectedPages(VARIANT_BOOL* p);
    HRESULT put_currentPage(VARIANT_BOOL v);
    HRESULT get_currentPage(VARIANT_BOOL* p);
    HRESULT put_currentPageAvail(VARIANT_BOOL v);
    HRESULT get_currentPageAvail(VARIANT_BOOL* p);
    HRESULT put_collate(VARIANT_BOOL v);
    HRESULT get_collate(VARIANT_BOOL* p);
    HRESULT get_duplex(VARIANT_BOOL* p);
    HRESULT put_copies(ushort v);
    HRESULT get_copies(ushort* p);
    HRESULT put_pageFrom(ushort v);
    HRESULT get_pageFrom(ushort* p);
    HRESULT put_pageTo(ushort v);
    HRESULT get_pageTo(ushort* p);
    HRESULT put_tableOfLinks(VARIANT_BOOL v);
    HRESULT get_tableOfLinks(VARIANT_BOOL* p);
    HRESULT put_allLinkedDocuments(VARIANT_BOOL v);
    HRESULT get_allLinkedDocuments(VARIANT_BOOL* p);
    HRESULT put_header(BSTR v);
    HRESULT get_header(BSTR* p);
    HRESULT put_footer(BSTR v);
    HRESULT get_footer(BSTR* p);
    HRESULT put_marginLeft(int v);
    HRESULT get_marginLeft(int* p);
    HRESULT put_marginRight(int v);
    HRESULT get_marginRight(int* p);
    HRESULT put_marginTop(int v);
    HRESULT get_marginTop(int* p);
    HRESULT put_marginBottom(int v);
    HRESULT get_marginBottom(int* p);
    HRESULT get_pageWidth(int* p);
    HRESULT get_pageHeight(int* p);
    HRESULT get_unprintableLeft(int* p);
    HRESULT get_unprintableTop(int* p);
    HRESULT get_unprintableRight(int* p);
    HRESULT get_unprintableBottom(int* p);
    HRESULT updatePageStatus(int* p);
}

@GUID("3050f83f-98b5-11cf-bb82-00aa00bdce0b")
interface ITemplatePrinter2 : ITemplatePrinter
{
    HRESULT put_selectionEnabled(VARIANT_BOOL v);
    HRESULT get_selectionEnabled(VARIANT_BOOL* p);
    HRESULT put_frameActiveEnabled(VARIANT_BOOL v);
    HRESULT get_frameActiveEnabled(VARIANT_BOOL* p);
    HRESULT put_orientation(BSTR v);
    HRESULT get_orientation(BSTR* p);
    HRESULT put_usePrinterCopyCollate(VARIANT_BOOL v);
    HRESULT get_usePrinterCopyCollate(VARIANT_BOOL* p);
    HRESULT deviceSupports(BSTR bstrProperty, VARIANT* pvar);
}

@GUID("305104a3-98b5-11cf-bb82-00aa00bdce0b")
interface ITemplatePrinter3 : ITemplatePrinter2
{
    HRESULT put_headerFooterFont(BSTR v);
    HRESULT get_headerFooterFont(BSTR* p);
    HRESULT getPageMarginTop(IDispatch pageRule, int pageWidth, int pageHeight, VARIANT* pMargin);
    HRESULT getPageMarginRight(IDispatch pageRule, int pageWidth, int pageHeight, VARIANT* pMargin);
    HRESULT getPageMarginBottom(IDispatch pageRule, int pageWidth, int pageHeight, VARIANT* pMargin);
    HRESULT getPageMarginLeft(IDispatch pageRule, int pageWidth, int pageHeight, VARIANT* pMargin);
    HRESULT getPageMarginTopImportant(IDispatch pageRule, VARIANT_BOOL* pbImportant);
    HRESULT getPageMarginRightImportant(IDispatch pageRule, VARIANT_BOOL* pbImportant);
    HRESULT getPageMarginBottomImportant(IDispatch pageRule, VARIANT_BOOL* pbImportant);
    HRESULT getPageMarginLeftImportant(IDispatch pageRule, VARIANT_BOOL* pbImportant);
}

@GUID("f633be14-9eff-4c4d-929e-05717b21b3e6")
interface IPrintManagerTemplatePrinter : IDispatch
{
    HRESULT startPrint();
    HRESULT drawPreviewPage(IDispatch pElemDisp, int nPage);
    HRESULT setPageCount(int nPage);
    HRESULT invalidatePreview();
    HRESULT getPrintTaskOptionValue(BSTR bstrKey, VARIANT* pvarin);
    HRESULT endPrint();
}

@GUID("c6403497-7493-4f09-8016-54b03e9bda69")
interface IPrintManagerTemplatePrinter2 : IPrintManagerTemplatePrinter
{
    HRESULT get_showHeaderFooter(VARIANT_BOOL* p);
    HRESULT get_shrinkToFit(VARIANT_BOOL* p);
    HRESULT get_percentScale(float* p);
}

@GUID("305900e9-98b5-11cf-bb82-00aa00bdce0b")
interface DispCPrintManagerTemplatePrinter : IDispatch
{
}

@GUID("3051051f-98b5-11cf-bb82-00aa00bdce0b")
interface ISVGTextPathElement : IDispatch
{
    HRESULT putref_startOffset(ISVGAnimatedLength v);
    HRESULT get_startOffset(ISVGAnimatedLength* p);
    HRESULT putref_method(ISVGAnimatedEnumeration v);
    HRESULT get_method(ISVGAnimatedEnumeration* p);
    HRESULT putref_spacing(ISVGAnimatedEnumeration v);
    HRESULT get_spacing(ISVGAnimatedEnumeration* p);
}

@GUID("3059003d-98b5-11cf-bb82-00aa00bdce0b")
interface DispSVGTextPathElement : IDispatch
{
}

@GUID("3051077d-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMXmlSerializer : IDispatch
{
    HRESULT serializeToString(IHTMLDOMNode pNode, BSTR* pString);
}

@GUID("30510781-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMParser : IDispatch
{
    HRESULT parseFromString(BSTR xmlSource, BSTR mimeType, IHTMLDocument2* ppNode);
}

@GUID("305900ad-98b5-11cf-bb82-00aa00bdce0b")
interface DispXMLSerializer : IDispatch
{
}

@GUID("305900ae-98b5-11cf-bb82-00aa00bdce0b")
interface DispDOMParser : IDispatch
{
}

@GUID("3051077f-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMXmlSerializerFactory : IDispatch
{
    HRESULT create(IDOMXmlSerializer* __MIDL__IDOMXmlSerializerFactory0000);
}

@GUID("30510783-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMParserFactory : IDispatch
{
    HRESULT create(IDOMParser* __MIDL__IDOMParserFactory0000);
}

@GUID("305900ba-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLSemanticElement : IDispatch
{
}

@GUID("3050f2d6-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLProgressElement : IDispatch
{
    HRESULT put_value(float v);
    HRESULT get_value(float* p);
    HRESULT put_max(float v);
    HRESULT get_max(float* p);
    HRESULT get_position(float* p);
    HRESULT get_form(IHTMLFormElement* p);
}

@GUID("305900af-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLProgressElement : IDispatch
{
}

@GUID("305107b5-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMMSTransitionEvent : IDispatch
{
    HRESULT get_propertyName(BSTR* p);
    HRESULT get_elapsedTime(float* p);
    HRESULT initMSTransitionEvent(BSTR eventType, VARIANT_BOOL canBubble, VARIANT_BOOL cancelable, 
                                  BSTR propertyName, float elapsedTime);
}

@GUID("305900bb-98b5-11cf-bb82-00aa00bdce0b")
interface DispDOMMSTransitionEvent : IDispatch
{
}

@GUID("305107b7-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMMSAnimationEvent : IDispatch
{
    HRESULT get_animationName(BSTR* p);
    HRESULT get_elapsedTime(float* p);
    HRESULT initMSAnimationEvent(BSTR eventType, VARIANT_BOOL canBubble, VARIANT_BOOL cancelable, 
                                 BSTR animationName, float elapsedTime);
}

@GUID("305900bc-98b5-11cf-bb82-00aa00bdce0b")
interface DispDOMMSAnimationEvent : IDispatch
{
}

@GUID("305107c7-98b5-11cf-bb82-00aa00bdce0b")
interface IWebGeocoordinates : IDispatch
{
    HRESULT get_latitude(double* p);
    HRESULT get_longitude(double* p);
    HRESULT get_altitude(VARIANT* p);
    HRESULT get_accuracy(double* p);
    HRESULT get_altitudeAccuracy(VARIANT* p);
    HRESULT get_heading(VARIANT* p);
    HRESULT get_speed(VARIANT* p);
}

@GUID("305107c9-98b5-11cf-bb82-00aa00bdce0b")
interface IWebGeopositionError : IDispatch
{
    HRESULT get_code(int* p);
    HRESULT get_message(BSTR* p);
}

@GUID("305107cd-98b5-11cf-bb82-00aa00bdce0b")
interface IWebGeoposition : IDispatch
{
    HRESULT get_coords(IWebGeocoordinates* p);
    HRESULT get_timestamp(ulong* p);
}

@GUID("305900bd-98b5-11cf-bb82-00aa00bdce0b")
interface DispWebGeolocation : IDispatch
{
}

@GUID("305900be-98b5-11cf-bb82-00aa00bdce0b")
interface DispWebGeocoordinates : IDispatch
{
}

@GUID("305900bf-98b5-11cf-bb82-00aa00bdce0b")
interface DispWebGeopositionError : IDispatch
{
}

@GUID("305900c1-98b5-11cf-bb82-00aa00bdce0b")
interface DispWebGeoposition : IDispatch
{
}

@GUID("7e8bc44d-aeff-11d1-89c2-00c04fb6bfc4")
interface IClientCaps : IDispatch
{
    HRESULT get_javaEnabled(VARIANT_BOOL* p);
    HRESULT get_cookieEnabled(VARIANT_BOOL* p);
    HRESULT get_cpuClass(BSTR* p);
    HRESULT get_systemLanguage(BSTR* p);
    HRESULT get_userLanguage(BSTR* p);
    HRESULT get_platform(BSTR* p);
    HRESULT get_connectionSpeed(int* p);
    HRESULT get_onLine(VARIANT_BOOL* p);
    HRESULT get_colorDepth(int* p);
    HRESULT get_bufferDepth(int* p);
    HRESULT get_width(int* p);
    HRESULT get_height(int* p);
    HRESULT get_availHeight(int* p);
    HRESULT get_availWidth(int* p);
    HRESULT get_connectionType(BSTR* p);
    HRESULT isComponentInstalled(BSTR bstrName, BSTR bstrUrl, BSTR bStrVer, VARIANT_BOOL* p);
    HRESULT getComponentVersion(BSTR bstrName, BSTR bstrUrl, BSTR* pbstrVer);
    HRESULT compareVersions(BSTR bstrVer1, BSTR bstrVer2, int* p);
    HRESULT addComponentRequest(BSTR bstrName, BSTR bstrUrl, BSTR bStrVer);
    HRESULT doComponentRequest(VARIANT_BOOL* p);
    HRESULT clearComponentRequest();
}

@GUID("30510816-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMMSManipulationEvent : IDispatch
{
    HRESULT get_lastState(int* p);
    HRESULT get_currentState(int* p);
    HRESULT initMSManipulationEvent(BSTR eventType, VARIANT_BOOL canBubble, VARIANT_BOOL cancelable, 
                                    IHTMLWindow2 viewArg, int detailArg, int lastState, int currentState);
}

@GUID("305900e1-98b5-11cf-bb82-00aa00bdce0b")
interface DispDOMMSManipulationEvent : IDispatch
{
}

@GUID("305107ff-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMCloseEvent : IDispatch
{
    HRESULT get_wasClean(VARIANT_BOOL* p);
    HRESULT initCloseEvent(BSTR eventType, VARIANT_BOOL canBubble, VARIANT_BOOL cancelable, VARIANT_BOOL wasClean, 
                           int code, BSTR reason);
}

@GUID("305900dc-98b5-11cf-bb82-00aa00bdce0b")
interface DispDOMCloseEvent : IDispatch
{
}

@GUID("305900e4-98b5-11cf-bb82-00aa00bdce0b")
interface DispApplicationCache : IDispatch
{
}

@GUID("3050f3ed-98b5-11cf-bb82-00aa00bdce0b")
interface ICSSFilterSite : IUnknown
{
    HRESULT GetElement(IHTMLElement* Element);
    HRESULT FireOnFilterChangeEvent();
}

@GUID("3050f49f-98b5-11cf-bb82-00aa00bdce0b")
interface IMarkupPointer : IUnknown
{
    HRESULT OwningDoc(IHTMLDocument2* ppDoc);
    HRESULT Gravity(POINTER_GRAVITY* pGravity);
    HRESULT SetGravity(POINTER_GRAVITY Gravity);
    HRESULT Cling(BOOL* pfCling);
    HRESULT SetCling(BOOL fCLing);
    HRESULT Unposition();
    HRESULT IsPositioned(BOOL* pfPositioned);
    HRESULT GetContainer(IMarkupContainer* ppContainer);
    HRESULT MoveAdjacentToElement(IHTMLElement pElement, ELEMENT_ADJACENCY eAdj);
    HRESULT MoveToPointer(IMarkupPointer pPointer);
    HRESULT MoveToContainer(IMarkupContainer pContainer, BOOL fAtStart);
    HRESULT Left(BOOL fMove, MARKUP_CONTEXT_TYPE* pContext, IHTMLElement* ppElement, int* pcch, PWSTR pchText);
    HRESULT Right(BOOL fMove, MARKUP_CONTEXT_TYPE* pContext, IHTMLElement* ppElement, int* pcch, PWSTR pchText);
    HRESULT CurrentScope(IHTMLElement* ppElemCurrent);
    HRESULT IsLeftOf(IMarkupPointer pPointerThat, BOOL* pfResult);
    HRESULT IsLeftOfOrEqualTo(IMarkupPointer pPointerThat, BOOL* pfResult);
    HRESULT IsRightOf(IMarkupPointer pPointerThat, BOOL* pfResult);
    HRESULT IsRightOfOrEqualTo(IMarkupPointer pPointerThat, BOOL* pfResult);
    HRESULT IsEqualTo(IMarkupPointer pPointerThat, BOOL* pfAreEqual);
    HRESULT MoveUnit(MOVEUNIT_ACTION muAction);
    HRESULT FindText(PWSTR pchFindText, uint dwFlags, IMarkupPointer pIEndMatch, IMarkupPointer pIEndSearch);
}

@GUID("3050f5f9-98b5-11cf-bb82-00aa00bdce0b")
interface IMarkupContainer : IUnknown
{
    HRESULT OwningDoc(IHTMLDocument2* ppDoc);
}

@GUID("3050f648-98b5-11cf-bb82-00aa00bdce0b")
interface IMarkupContainer2 : IMarkupContainer
{
    HRESULT CreateChangeLog(IHTMLChangeSink pChangeSink, IHTMLChangeLog* ppChangeLog, BOOL fForward, 
                            BOOL fBackward);
    HRESULT RegisterForDirtyRange(IHTMLChangeSink pChangeSink, uint* pdwCookie);
    HRESULT UnRegisterForDirtyRange(uint dwCookie);
    HRESULT GetAndClearDirtyRange(uint dwCookie, IMarkupPointer pIPointerBegin, IMarkupPointer pIPointerEnd);
    int     GetVersionNumber();
    HRESULT GetMasterElement(IHTMLElement* ppElementMaster);
}

@GUID("3050f649-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLChangeLog : IUnknown
{
    HRESULT GetNextChange(ubyte* pbBuffer, int nBufferSize, int* pnRecordLength);
}

@GUID("3050f64a-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLChangeSink : IUnknown
{
    HRESULT Notify();
}

@GUID("3050f605-98b5-11cf-bb82-00aa00bdce0b")
interface ISegmentList : IUnknown
{
    HRESULT CreateIterator(ISegmentListIterator* ppIIter);
    HRESULT GetType(SELECTION_TYPE* peType);
    HRESULT IsEmpty(BOOL* pfEmpty);
}

@GUID("3050f692-98b5-11cf-bb82-00aa00bdce0b")
interface ISegmentListIterator : IUnknown
{
    HRESULT Current(ISegment* ppISegment);
    HRESULT First();
    HRESULT IsDone();
    HRESULT Advance();
}

@GUID("3050f604-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLCaret : IUnknown
{
    HRESULT MoveCaretToPointer(IDisplayPointer pDispPointer, BOOL fScrollIntoView, CARET_DIRECTION eDir);
    HRESULT MoveCaretToPointerEx(IDisplayPointer pDispPointer, BOOL fVisible, BOOL fScrollIntoView, 
                                 CARET_DIRECTION eDir);
    HRESULT MoveMarkupPointerToCaret(IMarkupPointer pIMarkupPointer);
    HRESULT MoveDisplayPointerToCaret(IDisplayPointer pDispPointer);
    HRESULT IsVisible(BOOL* pIsVisible);
    HRESULT Show(BOOL fScrollIntoView);
    HRESULT Hide();
    HRESULT InsertText(PWSTR pText, int lLen);
    HRESULT ScrollIntoView();
    HRESULT GetLocation(POINT* pPoint, BOOL fTranslate);
    HRESULT GetCaretDirection(CARET_DIRECTION* peDir);
    HRESULT SetCaretDirection(CARET_DIRECTION eDir);
}

@GUID("3050f683-98b5-11cf-bb82-00aa00bdce0b")
interface ISegment : IUnknown
{
    HRESULT GetPointers(IMarkupPointer pIStart, IMarkupPointer pIEnd);
}

@GUID("3050f68f-98b5-11cf-bb82-00aa00bdce0b")
interface IElementSegment : ISegment
{
    HRESULT GetElement(IHTMLElement* ppIElement);
    HRESULT SetPrimary(BOOL fPrimary);
    HRESULT IsPrimary(BOOL* pfPrimary);
}

@GUID("3050f690-98b5-11cf-bb82-00aa00bdce0b")
interface IHighlightSegment : ISegment
{
}

@GUID("3050f606-98b5-11cf-bb82-00aa00bdce0b")
interface IHighlightRenderingServices : IUnknown
{
    HRESULT AddSegment(IDisplayPointer pDispPointerStart, IDisplayPointer pDispPointerEnd, 
                       IHTMLRenderStyle pIRenderStyle, IHighlightSegment* ppISegment);
    HRESULT MoveSegmentToPointers(IHighlightSegment pISegment, IDisplayPointer pDispPointerStart, 
                                  IDisplayPointer pDispPointerEnd);
    HRESULT RemoveSegment(IHighlightSegment pISegment);
}

@GUID("3050f7e2-98b5-11cf-bb82-00aa00bdce0b")
interface ILineInfo : IUnknown
{
    HRESULT get_x(int* p);
    HRESULT get_baseLine(int* p);
    HRESULT get_textDescent(int* p);
    HRESULT get_textHeight(int* p);
    HRESULT get_lineDirection(int* p);
}

@GUID("3050f69e-98b5-11cf-bb82-00aa00bdce0b")
interface IDisplayPointer : IUnknown
{
    HRESULT MoveToPoint(POINT ptPoint, COORD_SYSTEM eCoordSystem, IHTMLElement pElementContext, 
                        uint dwHitTestOptions, uint* pdwHitTestResults);
    HRESULT MoveUnit(DISPLAY_MOVEUNIT eMoveUnit, int lXPos);
    HRESULT PositionMarkupPointer(IMarkupPointer pMarkupPointer);
    HRESULT MoveToPointer(IDisplayPointer pDispPointer);
    HRESULT SetPointerGravity(POINTER_GRAVITY eGravity);
    HRESULT GetPointerGravity(POINTER_GRAVITY* peGravity);
    HRESULT SetDisplayGravity(DISPLAY_GRAVITY eGravity);
    HRESULT GetDisplayGravity(DISPLAY_GRAVITY* peGravity);
    HRESULT IsPositioned(BOOL* pfPositioned);
    HRESULT Unposition();
    HRESULT IsEqualTo(IDisplayPointer pDispPointer, BOOL* pfIsEqual);
    HRESULT IsLeftOf(IDisplayPointer pDispPointer, BOOL* pfIsLeftOf);
    HRESULT IsRightOf(IDisplayPointer pDispPointer, BOOL* pfIsRightOf);
    HRESULT IsAtBOL(BOOL* pfBOL);
    HRESULT MoveToMarkupPointer(IMarkupPointer pPointer, IDisplayPointer pDispLineContext);
    HRESULT ScrollIntoView();
    HRESULT GetLineInfo(ILineInfo* ppLineInfo);
    HRESULT GetFlowElement(IHTMLElement* ppLayoutElement);
    HRESULT QueryBreaks(uint* pdwBreaks);
}

@GUID("3050f69d-98b5-11cf-bb82-00aa00bdce0b")
interface IDisplayServices : IUnknown
{
    HRESULT CreateDisplayPointer(IDisplayPointer* ppDispPointer);
    HRESULT TransformRect(RECT* pRect, COORD_SYSTEM eSource, COORD_SYSTEM eDestination, IHTMLElement pIElement);
    HRESULT TransformPoint(POINT* pPoint, COORD_SYSTEM eSource, COORD_SYSTEM eDestination, IHTMLElement pIElement);
    HRESULT GetCaret(IHTMLCaret* ppCaret);
    HRESULT GetComputedStyle(IMarkupPointer pPointer, IHTMLComputedStyle* ppComputedStyle);
    HRESULT ScrollRectIntoView(IHTMLElement pIElement, RECT rect);
    HRESULT HasFlowLayout(IHTMLElement pIElement, BOOL* pfHasFlowLayout);
}

@GUID("3050f81a-98b5-11cf-bb82-00aa00bdce0b")
interface IHtmlDlgSafeHelper : IDispatch
{
    HRESULT choosecolordlg(VARIANT initColor, VARIANT* rgbColor);
    HRESULT getCharset(BSTR fontName, VARIANT* charset);
    HRESULT get_Fonts(IDispatch* p);
    HRESULT get_BlockFormats(IDispatch* p);
}

@GUID("3050f830-98b5-11cf-bb82-00aa00bdce0b")
interface IBlockFormats : IDispatch
{
    HRESULT get__NewEnum(IUnknown* p);
    HRESULT get_Count(int* p);
    HRESULT Item(VARIANT* pvarIndex, BSTR* pbstrBlockFormat);
}

@GUID("3050f839-98b5-11cf-bb82-00aa00bdce0b")
interface IFontNames : IDispatch
{
    HRESULT get__NewEnum(IUnknown* p);
    HRESULT get_Count(int* p);
    HRESULT Item(VARIANT* pvarIndex, BSTR* pbstrFontName);
}

@GUID("3050f3ec-98b5-11cf-bb82-00aa00bdce0b")
interface ICSSFilter : IUnknown
{
    HRESULT SetSite(ICSSFilterSite pSink);
    HRESULT OnAmbientPropertyChange(int dispid);
}

@GUID("c81984c4-74c8-11d2-baa9-00c04fc2040e")
interface ISecureUrlHost : IUnknown
{
    HRESULT ValidateSecureUrl(BOOL* pfAllow, PWSTR pchUrlInQuestion, uint dwFlags);
}

@GUID("3050f4a0-98b5-11cf-bb82-00aa00bdce0b")
interface IMarkupServices : IUnknown
{
    HRESULT CreateMarkupPointer(IMarkupPointer* ppPointer);
    HRESULT CreateMarkupContainer(IMarkupContainer* ppMarkupContainer);
    HRESULT CreateElement(ELEMENT_TAG_ID tagID, PWSTR pchAttributes, IHTMLElement* ppElement);
    HRESULT CloneElement(IHTMLElement pElemCloneThis, IHTMLElement* ppElementTheClone);
    HRESULT InsertElement(IHTMLElement pElementInsert, IMarkupPointer pPointerStart, IMarkupPointer pPointerFinish);
    HRESULT RemoveElement(IHTMLElement pElementRemove);
    HRESULT Remove(IMarkupPointer pPointerStart, IMarkupPointer pPointerFinish);
    HRESULT Copy(IMarkupPointer pPointerSourceStart, IMarkupPointer pPointerSourceFinish, 
                 IMarkupPointer pPointerTarget);
    HRESULT Move(IMarkupPointer pPointerSourceStart, IMarkupPointer pPointerSourceFinish, 
                 IMarkupPointer pPointerTarget);
    HRESULT InsertText(PWSTR pchText, int cch, IMarkupPointer pPointerTarget);
    HRESULT ParseString(PWSTR pchHTML, uint dwFlags, IMarkupContainer* ppContainerResult, 
                        IMarkupPointer ppPointerStart, IMarkupPointer ppPointerFinish);
    HRESULT ParseGlobal(HGLOBAL hglobalHTML, uint dwFlags, IMarkupContainer* ppContainerResult, 
                        IMarkupPointer pPointerStart, IMarkupPointer pPointerFinish);
    HRESULT IsScopedElement(IHTMLElement pElement, BOOL* pfScoped);
    HRESULT GetElementTagId(IHTMLElement pElement, ELEMENT_TAG_ID* ptagId);
    HRESULT GetTagIDForName(BSTR bstrName, ELEMENT_TAG_ID* ptagId);
    HRESULT GetNameForTagID(ELEMENT_TAG_ID tagId, BSTR* pbstrName);
    HRESULT MovePointersToRange(IHTMLTxtRange pIRange, IMarkupPointer pPointerStart, IMarkupPointer pPointerFinish);
    HRESULT MoveRangeToPointers(IMarkupPointer pPointerStart, IMarkupPointer pPointerFinish, IHTMLTxtRange pIRange);
    HRESULT BeginUndoUnit(PWSTR pchTitle);
    HRESULT EndUndoUnit();
}

@GUID("3050f682-98b5-11cf-bb82-00aa00bdce0b")
interface IMarkupServices2 : IMarkupServices
{
    HRESULT ParseGlobalEx(HGLOBAL hglobalHTML, uint dwFlags, IMarkupContainer pContext, 
                          IMarkupContainer* ppContainerResult, IMarkupPointer pPointerStart, 
                          IMarkupPointer pPointerFinish);
    HRESULT ValidateElements(IMarkupPointer pPointerStart, IMarkupPointer pPointerFinish, 
                             IMarkupPointer pPointerTarget, IMarkupPointer pPointerStatus, 
                             IHTMLElement* ppElemFailBottom, IHTMLElement* ppElemFailTop);
    HRESULT SaveSegmentsToClipboard(ISegmentList pSegmentList, uint dwFlags);
}

@GUID("3050f6e0-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLChangePlayback : IUnknown
{
    HRESULT ExecChange(ubyte* pbRecord, BOOL fForward);
}

@GUID("3050f675-98b5-11cf-bb82-00aa00bdce0b")
interface IMarkupPointer2 : IMarkupPointer
{
    HRESULT IsAtWordBreak(BOOL* pfAtBreak);
    HRESULT GetMarkupPosition(int* plMP);
    HRESULT MoveToMarkupPosition(IMarkupContainer pContainer, int lMP);
    HRESULT MoveUnitBounded(MOVEUNIT_ACTION muAction, IMarkupPointer pIBoundary);
    HRESULT IsInsideURL(IMarkupPointer pRight, BOOL* pfResult);
    HRESULT MoveToContent(IHTMLElement pIElement, BOOL fAtStart);
}

@GUID("3050f5fa-98b5-11cf-bb82-00aa00bdce0b")
interface IMarkupTextFrags : IUnknown
{
    HRESULT GetTextFragCount(int* pcFrags);
    HRESULT GetTextFrag(int iFrag, BSTR* pbstrFrag, IMarkupPointer pPointerFrag);
    HRESULT RemoveTextFrag(int iFrag);
    HRESULT InsertTextFrag(int iFrag, BSTR bstrInsert, IMarkupPointer pPointerInsert);
    HRESULT FindTextFragFromMarkupPointer(IMarkupPointer pPointerFind, int* piFrag, BOOL* pfFragFound);
}

@GUID("e4e23071-4d07-11d2-ae76-0080c73bc199")
interface IXMLGenericParse : IUnknown
{
    HRESULT SetGenericParse(VARIANT_BOOL fDoGeneric);
}

@GUID("3050f6a0-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLEditHost : IUnknown
{
    HRESULT SnapRect(IHTMLElement pIElement, RECT* prcNew, ELEMENT_CORNER eHandle);
}

@GUID("3050f848-98b5-11cf-bb82-00aa00bdce0d")
interface IHTMLEditHost2 : IHTMLEditHost
{
    HRESULT PreDrag();
}

@GUID("3050f6c1-98b5-11cf-bb82-00aa00bdce0b")
interface ISequenceNumber : IUnknown
{
    HRESULT GetSequenceNumber(int nCurrent, int* pnNew);
}

@GUID("3050f6ca-98b5-11cf-bb82-00aa00bdce0b")
interface IIMEServices : IUnknown
{
    HRESULT GetActiveIMM(IActiveIMMApp* ppActiveIMM);
}

@GUID("3050f699-98b5-11cf-bb82-00aa00bdce0b")
interface ISelectionServicesListener : IUnknown
{
    HRESULT BeginSelectionUndo();
    HRESULT EndSelectionUndo();
    HRESULT OnSelectedElementExit(IMarkupPointer pIElementStart, IMarkupPointer pIElementEnd, 
                                  IMarkupPointer pIElementContentStart, IMarkupPointer pIElementContentEnd);
    HRESULT OnChangeType(SELECTION_TYPE eType, ISelectionServicesListener pIListener);
    HRESULT GetTypeDetail(BSTR* pTypeDetail);
}

@GUID("3050f684-98b5-11cf-bb82-00aa00bdce0b")
interface ISelectionServices : IUnknown
{
    HRESULT SetSelectionType(SELECTION_TYPE eType, ISelectionServicesListener pIListener);
    HRESULT GetMarkupContainer(IMarkupContainer* ppIContainer);
    HRESULT AddSegment(IMarkupPointer pIStart, IMarkupPointer pIEnd, ISegment* ppISegmentAdded);
    HRESULT AddElementSegment(IHTMLElement pIElement, IElementSegment* ppISegmentAdded);
    HRESULT RemoveSegment(ISegment pISegment);
    HRESULT GetSelectionServicesListener(ISelectionServicesListener* ppISelectionServicesListener);
}

@GUID("3050f662-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLEditDesigner : IUnknown
{
    HRESULT PreHandleEvent(int inEvtDispId, IHTMLEventObj pIEventObj);
    HRESULT PostHandleEvent(int inEvtDispId, IHTMLEventObj pIEventObj);
    HRESULT TranslateAccelerator(int inEvtDispId, IHTMLEventObj pIEventObj);
    HRESULT PostEditorEventNotify(int inEvtDispId, IHTMLEventObj pIEventObj);
}

@GUID("3050f663-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLEditServices : IUnknown
{
    HRESULT AddDesigner(IHTMLEditDesigner pIDesigner);
    HRESULT RemoveDesigner(IHTMLEditDesigner pIDesigner);
    HRESULT GetSelectionServices(IMarkupContainer pIContainer, ISelectionServices* ppSelSvc);
    HRESULT MoveToSelectionAnchor(IMarkupPointer pIStartAnchor);
    HRESULT MoveToSelectionEnd(IMarkupPointer pIEndAnchor);
    HRESULT SelectRange(IMarkupPointer pStart, IMarkupPointer pEnd, SELECTION_TYPE eType);
}

@GUID("3050f812-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLEditServices2 : IHTMLEditServices
{
    HRESULT MoveToSelectionAnchorEx(IDisplayPointer pIStartAnchor);
    HRESULT MoveToSelectionEndEx(IDisplayPointer pIEndAnchor);
    HRESULT FreezeVirtualCaretPos(BOOL fReCompute);
    HRESULT UnFreezeVirtualCaretPos(BOOL fReset);
}

@GUID("3050f6c3-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLComputedStyle : IUnknown
{
    HRESULT get_bold(VARIANT_BOOL* p);
    HRESULT get_italic(VARIANT_BOOL* p);
    HRESULT get_underline(VARIANT_BOOL* p);
    HRESULT get_overline(VARIANT_BOOL* p);
    HRESULT get_strikeOut(VARIANT_BOOL* p);
    HRESULT get_subScript(VARIANT_BOOL* p);
    HRESULT get_superScript(VARIANT_BOOL* p);
    HRESULT get_explicitFace(VARIANT_BOOL* p);
    HRESULT get_fontWeight(int* p);
    HRESULT get_fontSize(int* p);
    HRESULT get_fontName(byte* p);
    HRESULT get_hasBgColor(VARIANT_BOOL* p);
    HRESULT get_textColor(uint* p);
    HRESULT get_backgroundColor(uint* p);
    HRESULT get_preFormatted(VARIANT_BOOL* p);
    HRESULT get_direction(VARIANT_BOOL* p);
    HRESULT get_blockDirection(VARIANT_BOOL* p);
    HRESULT get_OL(VARIANT_BOOL* p);
    HRESULT IsEqual(IHTMLComputedStyle pComputedStyle, VARIANT_BOOL* pfEqual);
}

@GUID("30510808-98b5-11cf-bb82-00aa00bdce0b")
interface IDeveloperConsoleMessageReceiver : IUnknown
{
    HRESULT Write(const(PWSTR) source, DEV_CONSOLE_MESSAGE_LEVEL level, int messageId, const(PWSTR) messageText);
    HRESULT WriteWithUrl(const(PWSTR) source, DEV_CONSOLE_MESSAGE_LEVEL level, int messageId, 
                         const(PWSTR) messageText, const(PWSTR) fileUrl);
    HRESULT WriteWithUrlAndLine(const(PWSTR) source, DEV_CONSOLE_MESSAGE_LEVEL level, int messageId, 
                                const(PWSTR) messageText, const(PWSTR) fileUrl, uint line);
    HRESULT WriteWithUrlLineAndColumn(const(PWSTR) source, DEV_CONSOLE_MESSAGE_LEVEL level, int messageId, 
                                      const(PWSTR) messageText, const(PWSTR) fileUrl, uint line, uint column);
}

@GUID("3051083a-98b5-11cf-bb82-00aa00bdce0b")
interface IScriptEventHandler : IUnknown
{
    HRESULT FunctionName(BSTR* pbstrFunctionName);
    HRESULT DebugDocumentContext(IUnknown* ppDebugDocumentContext);
    HRESULT EventHandlerDispatch(IDispatch* ppDispHandler);
    HRESULT UsesCapture(BOOL* pfUsesCapture);
    HRESULT Cookie(ulong* pullCookie);
}

@GUID("30510842-98b5-11cf-bb82-00aa00bdce0b")
interface IDebugCallbackNotificationHandler : IUnknown
{
    HRESULT RequestedCallbackTypes(uint* pCallbackMask);
    HRESULT BeforeDispatchEvent(IUnknown pEvent);
    HRESULT DispatchEventComplete(IUnknown pEvent, uint propagationStatus);
    HRESULT BeforeInvokeDomCallback(IUnknown pEvent, IScriptEventHandler pCallback, DOM_EVENT_PHASE eStage, 
                                    uint propagationStatus);
    HRESULT InvokeDomCallbackComplete(IUnknown pEvent, IScriptEventHandler pCallback, DOM_EVENT_PHASE eStage, 
                                      uint propagationStatus);
    HRESULT BeforeInvokeCallback(SCRIPT_TIMER_TYPE eCallbackType, uint callbackCookie, IDispatch pDispHandler, 
                                 ulong ullHandlerCookie, BSTR functionName, uint line, uint column, uint cchLength, 
                                 IUnknown pDebugDocumentContext);
    HRESULT InvokeCallbackComplete(SCRIPT_TIMER_TYPE eCallbackType, uint callbackCookie, IDispatch pDispHandler, 
                                   ulong ullHandlerCookie, BSTR functionName, uint line, uint column, uint cchLength, 
                                   IUnknown pDebugDocumentContext);
}

@GUID("30510841-98b5-11cf-bb82-00aa00bdce0b")
interface IScriptEventHandlerSourceInfo : IUnknown
{
    HRESULT GetSourceInfo(BSTR* pbstrFunctionName, uint* line, uint* column, uint* cchLength);
}

@GUID("3051083b-98b5-11cf-bb82-00aa00bdce0b")
interface IDOMEventRegistrationCallback : IUnknown
{
    HRESULT OnDOMEventListenerAdded(const(PWSTR) pszEventType, IScriptEventHandler pHandler);
    HRESULT OnDOMEventListenerRemoved(ulong ullCookie);
}

@GUID("30510839-98b5-11cf-bb82-00aa00bdce0b")
interface IEventTarget2 : IUnknown
{
    HRESULT GetRegisteredEventTypes(SAFEARRAY** ppEventTypeArray);
    HRESULT GetListenersForType(const(PWSTR) pszEventType, SAFEARRAY** ppEventHandlerArray);
    HRESULT RegisterForDOMEventListeners(IDOMEventRegistrationCallback pCallback);
    HRESULT UnregisterForDOMEventListeners(IDOMEventRegistrationCallback pCallback);
}

@GUID("3050f6bd-98b5-11cf-bb82-00aa00bdce0b")
interface HTMLNamespaceEvents : IDispatch
{
}

@GUID("3050f6bb-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLNamespace : IDispatch
{
    HRESULT get_name(BSTR* p);
    HRESULT get_urn(BSTR* p);
    HRESULT get_tagNames(IDispatch* p);
    HRESULT get_readyState(VARIANT* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
    HRESULT doImport(BSTR bstrImplementationUrl);
    HRESULT attachEvent(BSTR event, IDispatch pDisp, VARIANT_BOOL* pfResult);
    HRESULT detachEvent(BSTR event, IDispatch pDisp);
}

@GUID("3050f6b8-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLNamespaceCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT item(VARIANT index, IDispatch* ppNamespace);
    HRESULT add(BSTR bstrNamespace, BSTR bstrUrn, VARIANT implementationUrl, IDispatch* ppNamespace);
}

@GUID("3050f54f-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLNamespace : IDispatch
{
}

@GUID("3050f550-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLNamespaceCollection : IDispatch
{
}

@GUID("3050f6a6-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLPainter : IUnknown
{
    HRESULT Draw(RECT rcBounds, RECT rcUpdate, int lDrawFlags, HDC hdc, void* pvDrawObject);
    HRESULT OnResize(SIZE size);
    HRESULT GetPainterInfo(HTML_PAINTER_INFO* pInfo);
    HRESULT HitTestPoint(POINT pt, BOOL* pbHit, int* plPartID);
}

@GUID("3050f6a7-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLPaintSite : IUnknown
{
    HRESULT InvalidatePainterInfo();
    HRESULT InvalidateRect(RECT* prcInvalid);
    HRESULT InvalidateRegion(HRGN rgnInvalid);
    HRESULT GetDrawInfo(int lFlags, HTML_PAINT_DRAW_INFO* pDrawInfo);
    HRESULT TransformGlobalToLocal(POINT ptGlobal, POINT* pptLocal);
    HRESULT TransformLocalToGlobal(POINT ptLocal, POINT* pptGlobal);
    HRESULT GetHitTestCookie(int* plCookie);
}

@GUID("3050f6df-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLPainterEventInfo : IUnknown
{
    HRESULT GetEventInfoFlags(int* plEventInfoFlags);
    HRESULT GetEventTarget(IHTMLElement* ppElement);
    HRESULT SetCursor(int lPartID);
    HRESULT StringFromPartID(int lPartID, BSTR* pbstrPart);
}

@GUID("3050f7e3-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLPainterOverlay : IUnknown
{
    HRESULT OnMove(RECT rcDevice);
}

@GUID("3050f6b5-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLIPrintCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(int index, IUnknown* ppIPrint);
}

@GUID("3050f844-98b5-11cf-bb82-00aa00bdce0b")
interface IEnumPrivacyRecords : IUnknown
{
    HRESULT Reset();
    HRESULT GetSize(uint* pSize);
    HRESULT GetPrivacyImpacted(BOOL* pState);
    HRESULT Next(BSTR* pbstrUrl, BSTR* pbstrPolicyRef, int* pdwReserved, uint* pdwPrivacyFlags);
}

@GUID("30510413-98b5-11cf-bb82-00aa00bdce0b")
interface IWPCBlockedUrls : IUnknown
{
    HRESULT GetCount(uint* pdwCount);
    HRESULT GetUrl(uint dwIdx, BSTR* pbstrUrl);
}

@GUID("3051049c-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDOMConstructorCollection : IDispatch
{
    HRESULT get_Attr(IDispatch* p);
    HRESULT get_BehaviorUrnsCollection(IDispatch* p);
    HRESULT get_BookmarkCollection(IDispatch* p);
    HRESULT get_CompatibleInfo(IDispatch* p);
    HRESULT get_CompatibleInfoCollection(IDispatch* p);
    HRESULT get_ControlRangeCollection(IDispatch* p);
    HRESULT get_CSSCurrentStyleDeclaration(IDispatch* p);
    HRESULT get_CSSRuleList(IDispatch* p);
    HRESULT get_CSSRuleStyleDeclaration(IDispatch* p);
    HRESULT get_CSSStyleDeclaration(IDispatch* p);
    HRESULT get_CSSStyleRule(IDispatch* p);
    HRESULT get_CSSStyleSheet(IDispatch* p);
    HRESULT get_DataTransfer(IDispatch* p);
    HRESULT get_DOMImplementation(IDispatch* p);
    HRESULT get_Element(IDispatch* p);
    HRESULT get_Event(IDispatch* p);
    HRESULT get_History(IDispatch* p);
    HRESULT get_HTCElementBehaviorDefaults(IDispatch* p);
    HRESULT get_HTMLAnchorElement(IDispatch* p);
    HRESULT get_HTMLAreaElement(IDispatch* p);
    HRESULT get_HTMLAreasCollection(IDispatch* p);
    HRESULT get_HTMLBaseElement(IDispatch* p);
    HRESULT get_HTMLBaseFontElement(IDispatch* p);
    HRESULT get_HTMLBGSoundElement(IDispatch* p);
    HRESULT get_HTMLBlockElement(IDispatch* p);
    HRESULT get_HTMLBodyElement(IDispatch* p);
    HRESULT get_HTMLBRElement(IDispatch* p);
    HRESULT get_HTMLButtonElement(IDispatch* p);
    HRESULT get_HTMLCollection(IDispatch* p);
    HRESULT get_HTMLCommentElement(IDispatch* p);
    HRESULT get_HTMLDDElement(IDispatch* p);
    HRESULT get_HTMLDivElement(IDispatch* p);
    HRESULT get_HTMLDocument(IDispatch* p);
    HRESULT get_HTMLDListElement(IDispatch* p);
    HRESULT get_HTMLDTElement(IDispatch* p);
    HRESULT get_HTMLEmbedElement(IDispatch* p);
    HRESULT get_HTMLFieldSetElement(IDispatch* p);
    HRESULT get_HTMLFontElement(IDispatch* p);
    HRESULT get_HTMLFormElement(IDispatch* p);
    HRESULT get_HTMLFrameElement(IDispatch* p);
    HRESULT get_HTMLFrameSetElement(IDispatch* p);
    HRESULT get_HTMLGenericElement(IDispatch* p);
    HRESULT get_HTMLHeadElement(IDispatch* p);
    HRESULT get_HTMLHeadingElement(IDispatch* p);
    HRESULT get_HTMLHRElement(IDispatch* p);
    HRESULT get_HTMLHtmlElement(IDispatch* p);
    HRESULT get_HTMLIFrameElement(IDispatch* p);
    HRESULT get_HTMLImageElement(IDispatch* p);
    HRESULT get_HTMLInputElement(IDispatch* p);
    HRESULT get_HTMLIsIndexElement(IDispatch* p);
    HRESULT get_HTMLLabelElement(IDispatch* p);
    HRESULT get_HTMLLegendElement(IDispatch* p);
    HRESULT get_HTMLLIElement(IDispatch* p);
    HRESULT get_HTMLLinkElement(IDispatch* p);
    HRESULT get_HTMLMapElement(IDispatch* p);
    HRESULT get_HTMLMarqueeElement(IDispatch* p);
    HRESULT get_HTMLMetaElement(IDispatch* p);
    HRESULT get_HTMLModelessDialog(IDispatch* p);
    HRESULT get_HTMLNamespaceInfo(IDispatch* p);
    HRESULT get_HTMLNamespaceInfoCollection(IDispatch* p);
    HRESULT get_HTMLNextIdElement(IDispatch* p);
    HRESULT get_HTMLNoShowElement(IDispatch* p);
    HRESULT get_HTMLObjectElement(IDispatch* p);
    HRESULT get_HTMLOListElement(IDispatch* p);
    HRESULT get_HTMLOptionElement(IDispatch* p);
    HRESULT get_HTMLParagraphElement(IDispatch* p);
    HRESULT get_HTMLParamElement(IDispatch* p);
    HRESULT get_HTMLPhraseElement(IDispatch* p);
    HRESULT get_HTMLPluginsCollection(IDispatch* p);
    HRESULT get_HTMLPopup(IDispatch* p);
    HRESULT get_HTMLScriptElement(IDispatch* p);
    HRESULT get_HTMLSelectElement(IDispatch* p);
    HRESULT get_HTMLSpanElement(IDispatch* p);
    HRESULT get_HTMLStyleElement(IDispatch* p);
    HRESULT get_HTMLTableCaptionElement(IDispatch* p);
    HRESULT get_HTMLTableCellElement(IDispatch* p);
    HRESULT get_HTMLTableColElement(IDispatch* p);
    HRESULT get_HTMLTableElement(IDispatch* p);
    HRESULT get_HTMLTableRowElement(IDispatch* p);
    HRESULT get_HTMLTableSectionElement(IDispatch* p);
    HRESULT get_HTMLTextAreaElement(IDispatch* p);
    HRESULT get_HTMLTextElement(IDispatch* p);
    HRESULT get_HTMLTitleElement(IDispatch* p);
    HRESULT get_HTMLUListElement(IDispatch* p);
    HRESULT get_HTMLUnknownElement(IDispatch* p);
    HRESULT get_Image(IDispatch* p);
    HRESULT get_Location(IDispatch* p);
    HRESULT get_NamedNodeMap(IDispatch* p);
    HRESULT get_Navigator(IDispatch* p);
    HRESULT get_NodeList(IDispatch* p);
    HRESULT get_Option(IDispatch* p);
    HRESULT get_Screen(IDispatch* p);
    HRESULT get_Selection(IDispatch* p);
    HRESULT get_StaticNodeList(IDispatch* p);
    HRESULT get_Storage(IDispatch* p);
    HRESULT get_StyleSheetList(IDispatch* p);
    HRESULT get_StyleSheetPage(IDispatch* p);
    HRESULT get_StyleSheetPageList(IDispatch* p);
    HRESULT get_Text(IDispatch* p);
    HRESULT get_TextRange(IDispatch* p);
    HRESULT get_TextRangeCollection(IDispatch* p);
    HRESULT get_TextRectangle(IDispatch* p);
    HRESULT get_TextRectangleList(IDispatch* p);
    HRESULT get_Window(IDispatch* p);
    HRESULT get_XDomainRequest(IDispatch* p);
    HRESULT get_XMLHttpRequest(IDispatch* p);
}

@GUID("3050f216-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDialog : IDispatch
{
    HRESULT put_dialogTop(VARIANT v);
    HRESULT get_dialogTop(VARIANT* p);
    HRESULT put_dialogLeft(VARIANT v);
    HRESULT get_dialogLeft(VARIANT* p);
    HRESULT put_dialogWidth(VARIANT v);
    HRESULT get_dialogWidth(VARIANT* p);
    HRESULT put_dialogHeight(VARIANT v);
    HRESULT get_dialogHeight(VARIANT* p);
    HRESULT get_dialogArguments(VARIANT* p);
    HRESULT get_menuArguments(VARIANT* p);
    HRESULT put_returnValue(VARIANT v);
    HRESULT get_returnValue(VARIANT* p);
    HRESULT close();
    HRESULT toString(BSTR* String);
}

@GUID("3050f5e0-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDialog2 : IDispatch
{
    HRESULT put_status(BSTR v);
    HRESULT get_status(BSTR* p);
    HRESULT put_resizable(BSTR v);
    HRESULT get_resizable(BSTR* p);
}

@GUID("3050f388-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLDialog3 : IDispatch
{
    HRESULT put_unadorned(BSTR v);
    HRESULT get_unadorned(BSTR* p);
    HRESULT put_dialogHide(BSTR v);
    HRESULT get_dialogHide(BSTR* p);
}

@GUID("3050f5e4-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLModelessInit : IDispatch
{
    HRESULT get_parameters(VARIANT* p);
    HRESULT get_optionString(VARIANT* p);
    HRESULT get_moniker(IUnknown* p);
    HRESULT get_document(IUnknown* p);
}

@GUID("3050f666-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLPopup : IDispatch
{
    HRESULT show(int x, int y, int w, int h, VARIANT* pElement);
    HRESULT hide();
    HRESULT get_document(IHTMLDocument* p);
    HRESULT get_isOpen(VARIANT_BOOL* p);
}

@GUID("3050f589-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLPopup : IDispatch
{
}

@GUID("3050f5ca-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLAppBehavior : IDispatch
{
    HRESULT put_applicationName(BSTR v);
    HRESULT get_applicationName(BSTR* p);
    HRESULT put_version(BSTR v);
    HRESULT get_version(BSTR* p);
    HRESULT put_icon(BSTR v);
    HRESULT get_icon(BSTR* p);
    HRESULT put_singleInstance(BSTR v);
    HRESULT get_singleInstance(BSTR* p);
    HRESULT put_minimizeButton(BSTR v);
    HRESULT get_minimizeButton(BSTR* p);
    HRESULT put_maximizeButton(BSTR v);
    HRESULT get_maximizeButton(BSTR* p);
    HRESULT put_border(BSTR v);
    HRESULT get_border(BSTR* p);
    HRESULT put_borderStyle(BSTR v);
    HRESULT get_borderStyle(BSTR* p);
    HRESULT put_sysMenu(BSTR v);
    HRESULT get_sysMenu(BSTR* p);
    HRESULT put_caption(BSTR v);
    HRESULT get_caption(BSTR* p);
    HRESULT put_windowState(BSTR v);
    HRESULT get_windowState(BSTR* p);
    HRESULT put_showInTaskBar(BSTR v);
    HRESULT get_showInTaskBar(BSTR* p);
    HRESULT get_commandLine(BSTR* p);
}

@GUID("3050f5c9-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLAppBehavior2 : IDispatch
{
    HRESULT put_contextMenu(BSTR v);
    HRESULT get_contextMenu(BSTR* p);
    HRESULT put_innerBorder(BSTR v);
    HRESULT get_innerBorder(BSTR* p);
    HRESULT put_scroll(BSTR v);
    HRESULT get_scroll(BSTR* p);
    HRESULT put_scrollFlat(BSTR v);
    HRESULT get_scrollFlat(BSTR* p);
    HRESULT put_selection(BSTR v);
    HRESULT get_selection(BSTR* p);
}

@GUID("3050f5cd-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLAppBehavior3 : IDispatch
{
    HRESULT put_navigable(BSTR v);
    HRESULT get_navigable(BSTR* p);
}

@GUID("3050f57c-98b5-11cf-bb82-00aa00bdce0b")
interface DispHTMLAppBehavior : IDispatch
{
}

@GUID("3050f51e-98b5-11cf-bb82-00aa00bdce0b")
interface DispIHTMLInputButtonElement : IDispatch
{
}

@GUID("3050f520-98b5-11cf-bb82-00aa00bdce0b")
interface DispIHTMLInputTextElement : IDispatch
{
}

@GUID("3050f542-98b5-11cf-bb82-00aa00bdce0b")
interface DispIHTMLInputFileElement : IDispatch
{
}

@GUID("3050f509-98b5-11cf-bb82-00aa00bdce0b")
interface DispIHTMLOptionButtonElement : IDispatch
{
}

@GUID("3050f51d-98b5-11cf-bb82-00aa00bdce0b")
interface DispIHTMLInputImage : IDispatch
{
}

@GUID("3050f671-98b5-11cf-bb82-00aa00bdce0b")
interface IElementNamespace : IUnknown
{
    HRESULT AddTag(BSTR bstrTagName, int lFlags);
}

@GUID("3050f670-98b5-11cf-bb82-00aa00bdce0b")
interface IElementNamespaceTable : IUnknown
{
    HRESULT AddNamespace(BSTR bstrNamespace, BSTR bstrUrn, int lFlags, VARIANT* pvarFactory);
}

@GUID("3050f672-98b5-11cf-bb82-00aa00bdce0b")
interface IElementNamespaceFactory : IUnknown
{
    HRESULT Create(IElementNamespace pNamespace);
}

@GUID("3050f805-98b5-11cf-bb82-00aa00bdce0b")
interface IElementNamespaceFactory2 : IElementNamespaceFactory
{
    HRESULT CreateWithImplementation(IElementNamespace pNamespace, BSTR bstrImplementation);
}

@GUID("3050f7fd-98b5-11cf-bb82-00aa00bdce0b")
interface IElementNamespaceFactoryCallback : IUnknown
{
    HRESULT Resolve(BSTR bstrNamespace, BSTR bstrTagName, BSTR bstrAttrs, IElementNamespace pNamespace);
}

@GUID("3050f659-98b5-11cf-bb82-00aa00bdce0b")
interface IElementBehaviorSiteOM2 : IElementBehaviorSiteOM
{
    HRESULT GetDefaults(IHTMLElementDefaults* ppDefaults);
}

@GUID("3050f4ed-98b5-11cf-bb82-00aa00bdce0b")
interface IElementBehaviorCategory : IUnknown
{
    HRESULT GetCategory(PWSTR* ppchCategory);
}

@GUID("3050f4ee-98b5-11cf-bb82-00aa00bdce0b")
interface IElementBehaviorSiteCategory : IUnknown
{
    HRESULT GetRelatedBehaviors(int lDirection, PWSTR pchCategory, IEnumUnknown* ppEnumerator);
}

@GUID("3050f646-98b5-11cf-bb82-00aa00bdce0b")
interface IElementBehaviorSubmit : IUnknown
{
    HRESULT GetSubmitInfo(IHTMLSubmitData pSubmitData);
    HRESULT Reset();
}

@GUID("3050f6b6-98b5-11cf-bb82-00aa00bdce0b")
interface IElementBehaviorFocus : IUnknown
{
    HRESULT GetFocusRect(RECT* pRect);
}

@GUID("3050f6ba-98b5-11cf-bb82-00aa00bdce0b")
interface IElementBehaviorLayout : IUnknown
{
    HRESULT GetSize(int dwFlags, SIZE sizeContent, POINT* pptTranslateBy, POINT* pptTopLeft, SIZE* psizeProposed);
    HRESULT GetLayoutInfo(int* plLayoutInfo);
    HRESULT GetPosition(int lFlags, POINT* pptTopLeft);
    HRESULT MapSize(SIZE* psizeIn, RECT* prcOut);
}

@GUID("3050f846-98b5-11cf-bb82-00aa00bdce0b")
interface IElementBehaviorLayout2 : IUnknown
{
    HRESULT GetTextDescent(int* plDescent);
}

@GUID("3050f6b7-98b5-11cf-bb82-00aa00bdce0b")
interface IElementBehaviorSiteLayout : IUnknown
{
    HRESULT InvalidateLayoutInfo();
    HRESULT InvalidateSize();
    HRESULT GetMediaResolution(SIZE* psizeResolution);
}

@GUID("3050f847-98b5-11cf-bb82-00aa00bdce0b")
interface IElementBehaviorSiteLayout2 : IUnknown
{
    HRESULT GetFontInfo(LOGFONTW* plf);
}

@GUID("3050f842-98b5-11cf-bb82-00aa00bdce0b")
interface IHostBehaviorInit : IUnknown
{
    HRESULT PopulateNamespaceTable();
}

@GUID("305106e2-98b5-11cf-bb82-00aa00bdce0b")
interface ISurfacePresenter : IUnknown
{
    HRESULT Present(uint uBuffer, RECT* pDirty);
    HRESULT GetBuffer(uint backBufferIndex, const(GUID)* riid, void** ppBuffer);
    HRESULT IsCurrent(BOOL* pIsCurrent);
}

@GUID("305106e1-98b5-11cf-bb82-00aa00bdce0b")
interface IViewObjectPresentSite : IUnknown
{
    HRESULT CreateSurfacePresenter(IUnknown pDevice, uint width, uint height, uint backBufferCount, 
                                   DXGI_FORMAT format, VIEW_OBJECT_ALPHA_MODE mode, ISurfacePresenter* ppQueue);
    HRESULT IsHardwareComposition(BOOL* pIsHardwareComposition);
    HRESULT SetCompositionMode(VIEW_OBJECT_COMPOSITION_MODE mode);
}

@GUID("305107f9-98b5-11cf-bb82-00aa00bdce0b")
interface ICanvasPixelArrayData : IUnknown
{
    HRESULT GetBufferPointer(ubyte** ppBuffer, uint* pBufferLength);
}

@GUID("305106e3-98b5-11cf-bb82-00aa00bdce0b")
interface IViewObjectPrint : IUnknown
{
    HRESULT GetPrintBitmap(IUnknown* ppPrintBitmap);
}

@GUID("305107fa-98b5-11cf-bb82-00aa00bdce0b")
interface IViewObjectPresentNotifySite : IViewObjectPresentSite
{
    HRESULT RequestFrame();
}

@GUID("305107f8-98b5-11cf-bb82-00aa00bdce0b")
interface IViewObjectPresentNotify : IUnknown
{
    HRESULT OnPreRender();
}

@GUID("30510803-98b5-11cf-bb82-00aa00bdce0b")
interface ITrackingProtection : IUnknown
{
    HRESULT EvaluateUrl(BSTR bstrUrl, BOOL* pfAllowed);
    HRESULT GetEnabled(BOOL* pfEnabled);
}

@GUID("30510861-98b5-11cf-bb82-00aa00bdce0b")
interface IBFCacheable : IUnknown
{
    HRESULT EnterBFCache();
    HRESULT ExitBFCache();
}

@GUID("53dec138-a51e-11d2-861e-00c04fa35c89")
interface IHostDialogHelper : IUnknown
{
    HRESULT ShowHTMLDialog(HWND hwndParent, IMoniker pMk, VARIANT* pvarArgIn, PWSTR pchOptions, 
                           VARIANT* pvarArgOut, IUnknown punkHost);
}

@GUID("bd3f23c0-d43e-11cf-893b-00aa00bdce1a")
interface IDocHostUIHandler : IUnknown
{
    HRESULT ShowContextMenu(uint dwID, POINT* ppt, IUnknown pcmdtReserved, IDispatch pdispReserved);
    HRESULT GetHostInfo(DOCHOSTUIINFO* pInfo);
    HRESULT ShowUI(uint dwID, IOleInPlaceActiveObject pActiveObject, IOleCommandTarget pCommandTarget, 
                   IOleInPlaceFrame pFrame, IOleInPlaceUIWindow pDoc);
    HRESULT HideUI();
    HRESULT UpdateUI();
    HRESULT EnableModeless(BOOL fEnable);
    HRESULT OnDocWindowActivate(BOOL fActivate);
    HRESULT OnFrameWindowActivate(BOOL fActivate);
    HRESULT ResizeBorder(RECT* prcBorder, IOleInPlaceUIWindow pUIWindow, BOOL fRameWindow);
    HRESULT TranslateAccelerator(MSG* lpMsg, const(GUID)* pguidCmdGroup, uint nCmdID);
    HRESULT GetOptionKeyPath(PWSTR* pchKey, uint dw);
    HRESULT GetDropTarget(IDropTarget pDropTarget, IDropTarget* ppDropTarget);
    HRESULT GetExternal(IDispatch* ppDispatch);
    HRESULT TranslateUrl(uint dwTranslate, PWSTR pchURLIn, PWSTR* ppchURLOut);
    HRESULT FilterDataObject(IDataObject pDO, IDataObject* ppDORet);
}

@GUID("3050f6d0-98b5-11cf-bb82-00aa00bdce0b")
interface IDocHostUIHandler2 : IDocHostUIHandler
{
    HRESULT GetOverrideKeyPath(PWSTR* pchKey, uint dw);
}

@GUID("3050f3f0-98b5-11cf-bb82-00aa00bdce0b")
interface ICustomDoc : IUnknown
{
    HRESULT SetUIHandler(IDocHostUIHandler pUIHandler);
}

@GUID("c4d244b0-d43e-11cf-893b-00aa00bdce1a")
interface IDocHostShowUI : IUnknown
{
    HRESULT ShowMessage(HWND hwnd, PWSTR lpstrText, PWSTR lpstrCaption, uint dwType, PWSTR lpstrHelpFile, 
                        uint dwHelpContext, LRESULT* plResult);
    HRESULT ShowHelp(HWND hwnd, PWSTR pszHelpFile, uint uCommand, uint dwData, POINT ptMouse, 
                     IDispatch pDispatchObjectHit);
}

@GUID("342d1ea0-ae25-11d1-89c5-006008c3fbfc")
interface IClassFactoryEx : IClassFactory
{
    HRESULT CreateInstanceWithContext(IUnknown punkContext, IUnknown punkOuter, const(GUID)* riid, void** ppv);
}

@GUID("3050f5fc-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLOMWindowServices : IUnknown
{
    HRESULT moveTo(int x, int y);
    HRESULT moveBy(int x, int y);
    HRESULT resizeTo(int x, int y);
    HRESULT resizeBy(int x, int y);
}

@GUID("30510858-98b5-11cf-bb82-00aa00bdce0b")
interface IDiagnosticsScriptEngineSite : IUnknown
{
    HRESULT OnMessage(const(PWSTR)* pszData, uint ulDataCount);
    HRESULT OnScriptError(IActiveScriptError pScriptError);
}

@GUID("30510859-98b5-11cf-bb82-00aa00bdce0b")
interface IDiagnosticsScriptEngine : IUnknown
{
    HRESULT EvaluateScript(const(PWSTR) pszScript, const(PWSTR) pszScriptName);
    HRESULT FireScriptMessageEvent(const(PWSTR)* pszNames, const(PWSTR)* pszValues, uint ulPropertyCount);
    HRESULT Detach();
}

@GUID("3051085a-98b5-11cf-bb82-00aa00bdce0b")
interface IDiagnosticsScriptEngineProvider : IUnknown
{
    HRESULT CreateDiagnosticsScriptEngine(IDiagnosticsScriptEngineSite pScriptSite, BOOL fDebuggingEnabled, 
                                          uint ulProcessId, IDiagnosticsScriptEngine* ppEngine);
}


// GUIDs

const GUID CLSID_ApplicationCache                     = GUIDOF!ApplicationCache;
const GUID CLSID_BlockFormats                         = GUIDOF!BlockFormats;
const GUID CLSID_CClientCaps                          = GUIDOF!CClientCaps;
const GUID CLSID_CEventObj                            = GUIDOF!CEventObj;
const GUID CLSID_CMimeTypes                           = GUIDOF!CMimeTypes;
const GUID CLSID_COpsProfile                          = GUIDOF!COpsProfile;
const GUID CLSID_CPlugins                             = GUIDOF!CPlugins;
const GUID CLSID_CPrintManagerTemplatePrinter         = GUIDOF!CPrintManagerTemplatePrinter;
const GUID CLSID_CTemplatePrinter                     = GUIDOF!CTemplatePrinter;
const GUID CLSID_CanvasGradient                       = GUIDOF!CanvasGradient;
const GUID CLSID_CanvasImageData                      = GUIDOF!CanvasImageData;
const GUID CLSID_CanvasPattern                        = GUIDOF!CanvasPattern;
const GUID CLSID_CanvasRenderingContext2D             = GUIDOF!CanvasRenderingContext2D;
const GUID CLSID_CanvasTextMetrics                    = GUIDOF!CanvasTextMetrics;
const GUID CLSID_DOMBeforeUnloadEvent                 = GUIDOF!DOMBeforeUnloadEvent;
const GUID CLSID_DOMChildrenCollection                = GUIDOF!DOMChildrenCollection;
const GUID CLSID_DOMCloseEvent                        = GUIDOF!DOMCloseEvent;
const GUID CLSID_DOMCompositionEvent                  = GUIDOF!DOMCompositionEvent;
const GUID CLSID_DOMCustomEvent                       = GUIDOF!DOMCustomEvent;
const GUID CLSID_DOMDocumentType                      = GUIDOF!DOMDocumentType;
const GUID CLSID_DOMDragEvent                         = GUIDOF!DOMDragEvent;
const GUID CLSID_DOMEvent                             = GUIDOF!DOMEvent;
const GUID CLSID_DOMException                         = GUIDOF!DOMException;
const GUID CLSID_DOMFocusEvent                        = GUIDOF!DOMFocusEvent;
const GUID CLSID_DOMKeyboardEvent                     = GUIDOF!DOMKeyboardEvent;
const GUID CLSID_DOMMSAnimationEvent                  = GUIDOF!DOMMSAnimationEvent;
const GUID CLSID_DOMMSManipulationEvent               = GUIDOF!DOMMSManipulationEvent;
const GUID CLSID_DOMMSTransitionEvent                 = GUIDOF!DOMMSTransitionEvent;
const GUID CLSID_DOMMessageEvent                      = GUIDOF!DOMMessageEvent;
const GUID CLSID_DOMMouseEvent                        = GUIDOF!DOMMouseEvent;
const GUID CLSID_DOMMouseWheelEvent                   = GUIDOF!DOMMouseWheelEvent;
const GUID CLSID_DOMMutationEvent                     = GUIDOF!DOMMutationEvent;
const GUID CLSID_DOMParser                            = GUIDOF!DOMParser;
const GUID CLSID_DOMParserFactory                     = GUIDOF!DOMParserFactory;
const GUID CLSID_DOMProcessingInstruction             = GUIDOF!DOMProcessingInstruction;
const GUID CLSID_DOMProgressEvent                     = GUIDOF!DOMProgressEvent;
const GUID CLSID_DOMSiteModeEvent                     = GUIDOF!DOMSiteModeEvent;
const GUID CLSID_DOMStorageEvent                      = GUIDOF!DOMStorageEvent;
const GUID CLSID_DOMTextEvent                         = GUIDOF!DOMTextEvent;
const GUID CLSID_DOMUIEvent                           = GUIDOF!DOMUIEvent;
const GUID CLSID_DOMWheelEvent                        = GUIDOF!DOMWheelEvent;
const GUID CLSID_EventException                       = GUIDOF!EventException;
const GUID CLSID_FontNames                            = GUIDOF!FontNames;
const GUID CLSID_FramesCollection                     = GUIDOF!FramesCollection;
const GUID CLSID_HTCAttachBehavior                    = GUIDOF!HTCAttachBehavior;
const GUID CLSID_HTCDefaultDispatch                   = GUIDOF!HTCDefaultDispatch;
const GUID CLSID_HTCDescBehavior                      = GUIDOF!HTCDescBehavior;
const GUID CLSID_HTCEventBehavior                     = GUIDOF!HTCEventBehavior;
const GUID CLSID_HTCMethodBehavior                    = GUIDOF!HTCMethodBehavior;
const GUID CLSID_HTCPropertyBehavior                  = GUIDOF!HTCPropertyBehavior;
const GUID CLSID_HTMLAnchorElement                    = GUIDOF!HTMLAnchorElement;
const GUID CLSID_HTMLAppBehavior                      = GUIDOF!HTMLAppBehavior;
const GUID CLSID_HTMLAreaElement                      = GUIDOF!HTMLAreaElement;
const GUID CLSID_HTMLAreasCollection                  = GUIDOF!HTMLAreasCollection;
const GUID CLSID_HTMLAttributeCollection              = GUIDOF!HTMLAttributeCollection;
const GUID CLSID_HTMLAudioElement                     = GUIDOF!HTMLAudioElement;
const GUID CLSID_HTMLAudioElementFactory              = GUIDOF!HTMLAudioElementFactory;
const GUID CLSID_HTMLBGsound                          = GUIDOF!HTMLBGsound;
const GUID CLSID_HTMLBRElement                        = GUIDOF!HTMLBRElement;
const GUID CLSID_HTMLBaseElement                      = GUIDOF!HTMLBaseElement;
const GUID CLSID_HTMLBaseFontElement                  = GUIDOF!HTMLBaseFontElement;
const GUID CLSID_HTMLBlockElement                     = GUIDOF!HTMLBlockElement;
const GUID CLSID_HTMLBody                             = GUIDOF!HTMLBody;
const GUID CLSID_HTMLButtonElement                    = GUIDOF!HTMLButtonElement;
const GUID CLSID_HTMLCSSImportRule                    = GUIDOF!HTMLCSSImportRule;
const GUID CLSID_HTMLCSSMediaList                     = GUIDOF!HTMLCSSMediaList;
const GUID CLSID_HTMLCSSMediaRule                     = GUIDOF!HTMLCSSMediaRule;
const GUID CLSID_HTMLCSSNamespaceRule                 = GUIDOF!HTMLCSSNamespaceRule;
const GUID CLSID_HTMLCSSRule                          = GUIDOF!HTMLCSSRule;
const GUID CLSID_HTMLCSSStyleDeclaration              = GUIDOF!HTMLCSSStyleDeclaration;
const GUID CLSID_HTMLCanvasElement                    = GUIDOF!HTMLCanvasElement;
const GUID CLSID_HTMLCommentElement                   = GUIDOF!HTMLCommentElement;
const GUID CLSID_HTMLCurrentStyle                     = GUIDOF!HTMLCurrentStyle;
const GUID CLSID_HTMLDDElement                        = GUIDOF!HTMLDDElement;
const GUID CLSID_HTMLDListElement                     = GUIDOF!HTMLDListElement;
const GUID CLSID_HTMLDOMAttribute                     = GUIDOF!HTMLDOMAttribute;
const GUID CLSID_HTMLDOMImplementation                = GUIDOF!HTMLDOMImplementation;
const GUID CLSID_HTMLDOMRange                         = GUIDOF!HTMLDOMRange;
const GUID CLSID_HTMLDOMTextNode                      = GUIDOF!HTMLDOMTextNode;
const GUID CLSID_HTMLDOMXmlSerializerFactory          = GUIDOF!HTMLDOMXmlSerializerFactory;
const GUID CLSID_HTMLDTElement                        = GUIDOF!HTMLDTElement;
const GUID CLSID_HTMLDefaults                         = GUIDOF!HTMLDefaults;
const GUID CLSID_HTMLDialog                           = GUIDOF!HTMLDialog;
const GUID CLSID_HTMLDivElement                       = GUIDOF!HTMLDivElement;
const GUID CLSID_HTMLDivPosition                      = GUIDOF!HTMLDivPosition;
const GUID CLSID_HTMLDocument                         = GUIDOF!HTMLDocument;
const GUID CLSID_HTMLDocumentCompatibleInfo           = GUIDOF!HTMLDocumentCompatibleInfo;
const GUID CLSID_HTMLDocumentCompatibleInfoCollection = GUIDOF!HTMLDocumentCompatibleInfoCollection;
const GUID CLSID_HTMLElementCollection                = GUIDOF!HTMLElementCollection;
const GUID CLSID_HTMLEmbed                            = GUIDOF!HTMLEmbed;
const GUID CLSID_HTMLFieldSetElement                  = GUIDOF!HTMLFieldSetElement;
const GUID CLSID_HTMLFontElement                      = GUIDOF!HTMLFontElement;
const GUID CLSID_HTMLFormElement                      = GUIDOF!HTMLFormElement;
const GUID CLSID_HTMLFrameBase                        = GUIDOF!HTMLFrameBase;
const GUID CLSID_HTMLFrameElement                     = GUIDOF!HTMLFrameElement;
const GUID CLSID_HTMLFrameSetSite                     = GUIDOF!HTMLFrameSetSite;
const GUID CLSID_HTMLGenericElement                   = GUIDOF!HTMLGenericElement;
const GUID CLSID_HTMLHRElement                        = GUIDOF!HTMLHRElement;
const GUID CLSID_HTMLHeadElement                      = GUIDOF!HTMLHeadElement;
const GUID CLSID_HTMLHeaderElement                    = GUIDOF!HTMLHeaderElement;
const GUID CLSID_HTMLHistory                          = GUIDOF!HTMLHistory;
const GUID CLSID_HTMLHtmlElement                      = GUIDOF!HTMLHtmlElement;
const GUID CLSID_HTMLIFrame                           = GUIDOF!HTMLIFrame;
const GUID CLSID_HTMLImageElementFactory              = GUIDOF!HTMLImageElementFactory;
const GUID CLSID_HTMLImg                              = GUIDOF!HTMLImg;
const GUID CLSID_HTMLInputButtonElement               = GUIDOF!HTMLInputButtonElement;
const GUID CLSID_HTMLInputElement                     = GUIDOF!HTMLInputElement;
const GUID CLSID_HTMLInputFileElement                 = GUIDOF!HTMLInputFileElement;
const GUID CLSID_HTMLInputImage                       = GUIDOF!HTMLInputImage;
const GUID CLSID_HTMLInputTextElement                 = GUIDOF!HTMLInputTextElement;
const GUID CLSID_HTMLIsIndexElement                   = GUIDOF!HTMLIsIndexElement;
const GUID CLSID_HTMLLIElement                        = GUIDOF!HTMLLIElement;
const GUID CLSID_HTMLLabelElement                     = GUIDOF!HTMLLabelElement;
const GUID CLSID_HTMLLegendElement                    = GUIDOF!HTMLLegendElement;
const GUID CLSID_HTMLLinkElement                      = GUIDOF!HTMLLinkElement;
const GUID CLSID_HTMLListElement                      = GUIDOF!HTMLListElement;
const GUID CLSID_HTMLLocation                         = GUIDOF!HTMLLocation;
const GUID CLSID_HTMLMSCSSKeyframeRule                = GUIDOF!HTMLMSCSSKeyframeRule;
const GUID CLSID_HTMLMSCSSKeyframesRule               = GUIDOF!HTMLMSCSSKeyframesRule;
const GUID CLSID_HTMLMapElement                       = GUIDOF!HTMLMapElement;
const GUID CLSID_HTMLMarqueeElement                   = GUIDOF!HTMLMarqueeElement;
const GUID CLSID_HTMLMediaElement                     = GUIDOF!HTMLMediaElement;
const GUID CLSID_HTMLMediaError                       = GUIDOF!HTMLMediaError;
const GUID CLSID_HTMLMetaElement                      = GUIDOF!HTMLMetaElement;
const GUID CLSID_HTMLNamespace                        = GUIDOF!HTMLNamespace;
const GUID CLSID_HTMLNamespaceCollection              = GUIDOF!HTMLNamespaceCollection;
const GUID CLSID_HTMLNavigator                        = GUIDOF!HTMLNavigator;
const GUID CLSID_HTMLNextIdElement                    = GUIDOF!HTMLNextIdElement;
const GUID CLSID_HTMLNoShowElement                    = GUIDOF!HTMLNoShowElement;
const GUID CLSID_HTMLOListElement                     = GUIDOF!HTMLOListElement;
const GUID CLSID_HTMLObjectElement                    = GUIDOF!HTMLObjectElement;
const GUID CLSID_HTMLOptionButtonElement              = GUIDOF!HTMLOptionButtonElement;
const GUID CLSID_HTMLOptionElement                    = GUIDOF!HTMLOptionElement;
const GUID CLSID_HTMLOptionElementFactory             = GUIDOF!HTMLOptionElementFactory;
const GUID CLSID_HTMLParaElement                      = GUIDOF!HTMLParaElement;
const GUID CLSID_HTMLParamElement                     = GUIDOF!HTMLParamElement;
const GUID CLSID_HTMLPerformance                      = GUIDOF!HTMLPerformance;
const GUID CLSID_HTMLPerformanceNavigation            = GUIDOF!HTMLPerformanceNavigation;
const GUID CLSID_HTMLPerformanceTiming                = GUIDOF!HTMLPerformanceTiming;
const GUID CLSID_HTMLPhraseElement                    = GUIDOF!HTMLPhraseElement;
const GUID CLSID_HTMLPopup                            = GUIDOF!HTMLPopup;
const GUID CLSID_HTMLProgressElement                  = GUIDOF!HTMLProgressElement;
const GUID CLSID_HTMLRenderStyle                      = GUIDOF!HTMLRenderStyle;
const GUID CLSID_HTMLRichtextElement                  = GUIDOF!HTMLRichtextElement;
const GUID CLSID_HTMLRuleStyle                        = GUIDOF!HTMLRuleStyle;
const GUID CLSID_HTMLScreen                           = GUIDOF!HTMLScreen;
const GUID CLSID_HTMLScriptElement                    = GUIDOF!HTMLScriptElement;
const GUID CLSID_HTMLSelectElement                    = GUIDOF!HTMLSelectElement;
const GUID CLSID_HTMLSemanticElement                  = GUIDOF!HTMLSemanticElement;
const GUID CLSID_HTMLSourceElement                    = GUIDOF!HTMLSourceElement;
const GUID CLSID_HTMLSpanElement                      = GUIDOF!HTMLSpanElement;
const GUID CLSID_HTMLSpanFlow                         = GUIDOF!HTMLSpanFlow;
const GUID CLSID_HTMLStorage                          = GUIDOF!HTMLStorage;
const GUID CLSID_HTMLStyle                            = GUIDOF!HTMLStyle;
const GUID CLSID_HTMLStyleElement                     = GUIDOF!HTMLStyleElement;
const GUID CLSID_HTMLStyleFontFace                    = GUIDOF!HTMLStyleFontFace;
const GUID CLSID_HTMLStyleMedia                       = GUIDOF!HTMLStyleMedia;
const GUID CLSID_HTMLStyleSheet                       = GUIDOF!HTMLStyleSheet;
const GUID CLSID_HTMLStyleSheetPage                   = GUIDOF!HTMLStyleSheetPage;
const GUID CLSID_HTMLStyleSheetPagesCollection        = GUIDOF!HTMLStyleSheetPagesCollection;
const GUID CLSID_HTMLStyleSheetRule                   = GUIDOF!HTMLStyleSheetRule;
const GUID CLSID_HTMLStyleSheetRulesAppliedCollection = GUIDOF!HTMLStyleSheetRulesAppliedCollection;
const GUID CLSID_HTMLStyleSheetRulesCollection        = GUIDOF!HTMLStyleSheetRulesCollection;
const GUID CLSID_HTMLStyleSheetsCollection            = GUIDOF!HTMLStyleSheetsCollection;
const GUID CLSID_HTMLTable                            = GUIDOF!HTMLTable;
const GUID CLSID_HTMLTableCaption                     = GUIDOF!HTMLTableCaption;
const GUID CLSID_HTMLTableCell                        = GUIDOF!HTMLTableCell;
const GUID CLSID_HTMLTableCol                         = GUIDOF!HTMLTableCol;
const GUID CLSID_HTMLTableRow                         = GUIDOF!HTMLTableRow;
const GUID CLSID_HTMLTableSection                     = GUIDOF!HTMLTableSection;
const GUID CLSID_HTMLTextAreaElement                  = GUIDOF!HTMLTextAreaElement;
const GUID CLSID_HTMLTextElement                      = GUIDOF!HTMLTextElement;
const GUID CLSID_HTMLTimeRanges                       = GUIDOF!HTMLTimeRanges;
const GUID CLSID_HTMLTitleElement                     = GUIDOF!HTMLTitleElement;
const GUID CLSID_HTMLUListElement                     = GUIDOF!HTMLUListElement;
const GUID CLSID_HTMLUnknownElement                   = GUIDOF!HTMLUnknownElement;
const GUID CLSID_HTMLUrnCollection                    = GUIDOF!HTMLUrnCollection;
const GUID CLSID_HTMLVideoElement                     = GUIDOF!HTMLVideoElement;
const GUID CLSID_HTMLW3CComputedStyle                 = GUIDOF!HTMLW3CComputedStyle;
const GUID CLSID_HTMLWindow2                          = GUIDOF!HTMLWindow2;
const GUID CLSID_HTMLWindowProxy                      = GUIDOF!HTMLWindowProxy;
const GUID CLSID_HTMLWndOptionElement                 = GUIDOF!HTMLWndOptionElement;
const GUID CLSID_HTMLWndSelectElement                 = GUIDOF!HTMLWndSelectElement;
const GUID CLSID_HTMLXMLHttpRequest                   = GUIDOF!HTMLXMLHttpRequest;
const GUID CLSID_HTMLXMLHttpRequestFactory            = GUIDOF!HTMLXMLHttpRequestFactory;
const GUID CLSID_HtmlDlgSafeHelper                    = GUIDOF!HtmlDlgSafeHelper;
const GUID CLSID_NodeIterator                         = GUIDOF!NodeIterator;
const GUID CLSID_OldHTMLDocument                      = GUIDOF!OldHTMLDocument;
const GUID CLSID_OldHTMLFormElement                   = GUIDOF!OldHTMLFormElement;
const GUID CLSID_RangeException                       = GUIDOF!RangeException;
const GUID CLSID_RulesApplied                         = GUIDOF!RulesApplied;
const GUID CLSID_RulesAppliedCollection               = GUIDOF!RulesAppliedCollection;
const GUID CLSID_SVGAElement                          = GUIDOF!SVGAElement;
const GUID CLSID_SVGAngle                             = GUIDOF!SVGAngle;
const GUID CLSID_SVGAnimatedAngle                     = GUIDOF!SVGAnimatedAngle;
const GUID CLSID_SVGAnimatedBoolean                   = GUIDOF!SVGAnimatedBoolean;
const GUID CLSID_SVGAnimatedEnumeration               = GUIDOF!SVGAnimatedEnumeration;
const GUID CLSID_SVGAnimatedInteger                   = GUIDOF!SVGAnimatedInteger;
const GUID CLSID_SVGAnimatedLength                    = GUIDOF!SVGAnimatedLength;
const GUID CLSID_SVGAnimatedLengthList                = GUIDOF!SVGAnimatedLengthList;
const GUID CLSID_SVGAnimatedNumber                    = GUIDOF!SVGAnimatedNumber;
const GUID CLSID_SVGAnimatedNumberList                = GUIDOF!SVGAnimatedNumberList;
const GUID CLSID_SVGAnimatedPreserveAspectRatio       = GUIDOF!SVGAnimatedPreserveAspectRatio;
const GUID CLSID_SVGAnimatedRect                      = GUIDOF!SVGAnimatedRect;
const GUID CLSID_SVGAnimatedString                    = GUIDOF!SVGAnimatedString;
const GUID CLSID_SVGAnimatedTransformList             = GUIDOF!SVGAnimatedTransformList;
const GUID CLSID_SVGCircleElement                     = GUIDOF!SVGCircleElement;
const GUID CLSID_SVGClipPathElement                   = GUIDOF!SVGClipPathElement;
const GUID CLSID_SVGDefsElement                       = GUIDOF!SVGDefsElement;
const GUID CLSID_SVGDescElement                       = GUIDOF!SVGDescElement;
const GUID CLSID_SVGElement                           = GUIDOF!SVGElement;
const GUID CLSID_SVGElementInstance                   = GUIDOF!SVGElementInstance;
const GUID CLSID_SVGElementInstanceList               = GUIDOF!SVGElementInstanceList;
const GUID CLSID_SVGEllipseElement                    = GUIDOF!SVGEllipseElement;
const GUID CLSID_SVGException                         = GUIDOF!SVGException;
const GUID CLSID_SVGGElement                          = GUIDOF!SVGGElement;
const GUID CLSID_SVGGradientElement                   = GUIDOF!SVGGradientElement;
const GUID CLSID_SVGImageElement                      = GUIDOF!SVGImageElement;
const GUID CLSID_SVGLength                            = GUIDOF!SVGLength;
const GUID CLSID_SVGLengthList                        = GUIDOF!SVGLengthList;
const GUID CLSID_SVGLineElement                       = GUIDOF!SVGLineElement;
const GUID CLSID_SVGLinearGradientElement             = GUIDOF!SVGLinearGradientElement;
const GUID CLSID_SVGMarkerElement                     = GUIDOF!SVGMarkerElement;
const GUID CLSID_SVGMaskElement                       = GUIDOF!SVGMaskElement;
const GUID CLSID_SVGMatrix                            = GUIDOF!SVGMatrix;
const GUID CLSID_SVGMetadataElement                   = GUIDOF!SVGMetadataElement;
const GUID CLSID_SVGNumber                            = GUIDOF!SVGNumber;
const GUID CLSID_SVGNumberList                        = GUIDOF!SVGNumberList;
const GUID CLSID_SVGPathElement                       = GUIDOF!SVGPathElement;
const GUID CLSID_SVGPathSeg                           = GUIDOF!SVGPathSeg;
const GUID CLSID_SVGPathSegArcAbs                     = GUIDOF!SVGPathSegArcAbs;
const GUID CLSID_SVGPathSegArcRel                     = GUIDOF!SVGPathSegArcRel;
const GUID CLSID_SVGPathSegClosePath                  = GUIDOF!SVGPathSegClosePath;
const GUID CLSID_SVGPathSegCurvetoCubicAbs            = GUIDOF!SVGPathSegCurvetoCubicAbs;
const GUID CLSID_SVGPathSegCurvetoCubicRel            = GUIDOF!SVGPathSegCurvetoCubicRel;
const GUID CLSID_SVGPathSegCurvetoCubicSmoothAbs      = GUIDOF!SVGPathSegCurvetoCubicSmoothAbs;
const GUID CLSID_SVGPathSegCurvetoCubicSmoothRel      = GUIDOF!SVGPathSegCurvetoCubicSmoothRel;
const GUID CLSID_SVGPathSegCurvetoQuadraticAbs        = GUIDOF!SVGPathSegCurvetoQuadraticAbs;
const GUID CLSID_SVGPathSegCurvetoQuadraticRel        = GUIDOF!SVGPathSegCurvetoQuadraticRel;
const GUID CLSID_SVGPathSegCurvetoQuadraticSmoothAbs  = GUIDOF!SVGPathSegCurvetoQuadraticSmoothAbs;
const GUID CLSID_SVGPathSegCurvetoQuadraticSmoothRel  = GUIDOF!SVGPathSegCurvetoQuadraticSmoothRel;
const GUID CLSID_SVGPathSegLinetoAbs                  = GUIDOF!SVGPathSegLinetoAbs;
const GUID CLSID_SVGPathSegLinetoHorizontalAbs        = GUIDOF!SVGPathSegLinetoHorizontalAbs;
const GUID CLSID_SVGPathSegLinetoHorizontalRel        = GUIDOF!SVGPathSegLinetoHorizontalRel;
const GUID CLSID_SVGPathSegLinetoRel                  = GUIDOF!SVGPathSegLinetoRel;
const GUID CLSID_SVGPathSegLinetoVerticalAbs          = GUIDOF!SVGPathSegLinetoVerticalAbs;
const GUID CLSID_SVGPathSegLinetoVerticalRel          = GUIDOF!SVGPathSegLinetoVerticalRel;
const GUID CLSID_SVGPathSegList                       = GUIDOF!SVGPathSegList;
const GUID CLSID_SVGPathSegMovetoAbs                  = GUIDOF!SVGPathSegMovetoAbs;
const GUID CLSID_SVGPathSegMovetoRel                  = GUIDOF!SVGPathSegMovetoRel;
const GUID CLSID_SVGPatternElement                    = GUIDOF!SVGPatternElement;
const GUID CLSID_SVGPoint                             = GUIDOF!SVGPoint;
const GUID CLSID_SVGPointList                         = GUIDOF!SVGPointList;
const GUID CLSID_SVGPolygonElement                    = GUIDOF!SVGPolygonElement;
const GUID CLSID_SVGPolylineElement                   = GUIDOF!SVGPolylineElement;
const GUID CLSID_SVGPreserveAspectRatio               = GUIDOF!SVGPreserveAspectRatio;
const GUID CLSID_SVGRadialGradientElement             = GUIDOF!SVGRadialGradientElement;
const GUID CLSID_SVGRect                              = GUIDOF!SVGRect;
const GUID CLSID_SVGRectElement                       = GUIDOF!SVGRectElement;
const GUID CLSID_SVGSVGElement                        = GUIDOF!SVGSVGElement;
const GUID CLSID_SVGScriptElement                     = GUIDOF!SVGScriptElement;
const GUID CLSID_SVGStopElement                       = GUIDOF!SVGStopElement;
const GUID CLSID_SVGStringList                        = GUIDOF!SVGStringList;
const GUID CLSID_SVGStyleElement                      = GUIDOF!SVGStyleElement;
const GUID CLSID_SVGSwitchElement                     = GUIDOF!SVGSwitchElement;
const GUID CLSID_SVGSymbolElement                     = GUIDOF!SVGSymbolElement;
const GUID CLSID_SVGTSpanElement                      = GUIDOF!SVGTSpanElement;
const GUID CLSID_SVGTextContentElement                = GUIDOF!SVGTextContentElement;
const GUID CLSID_SVGTextElement                       = GUIDOF!SVGTextElement;
const GUID CLSID_SVGTextPathElement                   = GUIDOF!SVGTextPathElement;
const GUID CLSID_SVGTextPositioningElement            = GUIDOF!SVGTextPositioningElement;
const GUID CLSID_SVGTitleElement                      = GUIDOF!SVGTitleElement;
const GUID CLSID_SVGTransform                         = GUIDOF!SVGTransform;
const GUID CLSID_SVGTransformList                     = GUIDOF!SVGTransformList;
const GUID CLSID_SVGUseElement                        = GUIDOF!SVGUseElement;
const GUID CLSID_SVGViewElement                       = GUIDOF!SVGViewElement;
const GUID CLSID_SVGZoomEvent                         = GUIDOF!SVGZoomEvent;
const GUID CLSID_Scriptlet                            = GUIDOF!Scriptlet;
const GUID CLSID_StaticNodeList                       = GUIDOF!StaticNodeList;
const GUID CLSID_ThreadDialogProcParam                = GUIDOF!ThreadDialogProcParam;
const GUID CLSID_TreeWalker                           = GUIDOF!TreeWalker;
const GUID CLSID_WebGeocoordinates                    = GUIDOF!WebGeocoordinates;
const GUID CLSID_WebGeolocation                       = GUIDOF!WebGeolocation;
const GUID CLSID_WebGeoposition                       = GUIDOF!WebGeoposition;
const GUID CLSID_WebGeopositionError                  = GUIDOF!WebGeopositionError;
const GUID CLSID_XDomainRequest                       = GUIDOF!XDomainRequest;
const GUID CLSID_XDomainRequestFactory                = GUIDOF!XDomainRequestFactory;
const GUID CLSID_XMLHttpRequestEventTarget            = GUIDOF!XMLHttpRequestEventTarget;
const GUID CLSID_XMLSerializer                        = GUIDOF!XMLSerializer;

const GUID IID_DWebBridgeEvents                         = GUIDOF!DWebBridgeEvents;
const GUID IID_DispApplicationCache                     = GUIDOF!DispApplicationCache;
const GUID IID_DispCEventObj                            = GUIDOF!DispCEventObj;
const GUID IID_DispCPlugins                             = GUIDOF!DispCPlugins;
const GUID IID_DispCPrintManagerTemplatePrinter         = GUIDOF!DispCPrintManagerTemplatePrinter;
const GUID IID_DispCanvasGradient                       = GUIDOF!DispCanvasGradient;
const GUID IID_DispCanvasImageData                      = GUIDOF!DispCanvasImageData;
const GUID IID_DispCanvasPattern                        = GUIDOF!DispCanvasPattern;
const GUID IID_DispCanvasRenderingContext2D             = GUIDOF!DispCanvasRenderingContext2D;
const GUID IID_DispCanvasTextMetrics                    = GUIDOF!DispCanvasTextMetrics;
const GUID IID_DispDOMBeforeUnloadEvent                 = GUIDOF!DispDOMBeforeUnloadEvent;
const GUID IID_DispDOMChildrenCollection                = GUIDOF!DispDOMChildrenCollection;
const GUID IID_DispDOMCloseEvent                        = GUIDOF!DispDOMCloseEvent;
const GUID IID_DispDOMCompositionEvent                  = GUIDOF!DispDOMCompositionEvent;
const GUID IID_DispDOMCustomEvent                       = GUIDOF!DispDOMCustomEvent;
const GUID IID_DispDOMDocumentType                      = GUIDOF!DispDOMDocumentType;
const GUID IID_DispDOMDragEvent                         = GUIDOF!DispDOMDragEvent;
const GUID IID_DispDOMEvent                             = GUIDOF!DispDOMEvent;
const GUID IID_DispDOMException                         = GUIDOF!DispDOMException;
const GUID IID_DispDOMFocusEvent                        = GUIDOF!DispDOMFocusEvent;
const GUID IID_DispDOMKeyboardEvent                     = GUIDOF!DispDOMKeyboardEvent;
const GUID IID_DispDOMMSAnimationEvent                  = GUIDOF!DispDOMMSAnimationEvent;
const GUID IID_DispDOMMSManipulationEvent               = GUIDOF!DispDOMMSManipulationEvent;
const GUID IID_DispDOMMSTransitionEvent                 = GUIDOF!DispDOMMSTransitionEvent;
const GUID IID_DispDOMMessageEvent                      = GUIDOF!DispDOMMessageEvent;
const GUID IID_DispDOMMouseEvent                        = GUIDOF!DispDOMMouseEvent;
const GUID IID_DispDOMMouseWheelEvent                   = GUIDOF!DispDOMMouseWheelEvent;
const GUID IID_DispDOMMutationEvent                     = GUIDOF!DispDOMMutationEvent;
const GUID IID_DispDOMParser                            = GUIDOF!DispDOMParser;
const GUID IID_DispDOMProcessingInstruction             = GUIDOF!DispDOMProcessingInstruction;
const GUID IID_DispDOMProgressEvent                     = GUIDOF!DispDOMProgressEvent;
const GUID IID_DispDOMSiteModeEvent                     = GUIDOF!DispDOMSiteModeEvent;
const GUID IID_DispDOMStorageEvent                      = GUIDOF!DispDOMStorageEvent;
const GUID IID_DispDOMTextEvent                         = GUIDOF!DispDOMTextEvent;
const GUID IID_DispDOMUIEvent                           = GUIDOF!DispDOMUIEvent;
const GUID IID_DispDOMWheelEvent                        = GUIDOF!DispDOMWheelEvent;
const GUID IID_DispEventException                       = GUIDOF!DispEventException;
const GUID IID_DispHTCAttachBehavior                    = GUIDOF!DispHTCAttachBehavior;
const GUID IID_DispHTCDefaultDispatch                   = GUIDOF!DispHTCDefaultDispatch;
const GUID IID_DispHTCDescBehavior                      = GUIDOF!DispHTCDescBehavior;
const GUID IID_DispHTCEventBehavior                     = GUIDOF!DispHTCEventBehavior;
const GUID IID_DispHTCMethodBehavior                    = GUIDOF!DispHTCMethodBehavior;
const GUID IID_DispHTCPropertyBehavior                  = GUIDOF!DispHTCPropertyBehavior;
const GUID IID_DispHTMLAnchorElement                    = GUIDOF!DispHTMLAnchorElement;
const GUID IID_DispHTMLAppBehavior                      = GUIDOF!DispHTMLAppBehavior;
const GUID IID_DispHTMLAreaElement                      = GUIDOF!DispHTMLAreaElement;
const GUID IID_DispHTMLAreasCollection                  = GUIDOF!DispHTMLAreasCollection;
const GUID IID_DispHTMLAttributeCollection              = GUIDOF!DispHTMLAttributeCollection;
const GUID IID_DispHTMLAudioElement                     = GUIDOF!DispHTMLAudioElement;
const GUID IID_DispHTMLBGsound                          = GUIDOF!DispHTMLBGsound;
const GUID IID_DispHTMLBRElement                        = GUIDOF!DispHTMLBRElement;
const GUID IID_DispHTMLBaseElement                      = GUIDOF!DispHTMLBaseElement;
const GUID IID_DispHTMLBaseFontElement                  = GUIDOF!DispHTMLBaseFontElement;
const GUID IID_DispHTMLBlockElement                     = GUIDOF!DispHTMLBlockElement;
const GUID IID_DispHTMLBody                             = GUIDOF!DispHTMLBody;
const GUID IID_DispHTMLButtonElement                    = GUIDOF!DispHTMLButtonElement;
const GUID IID_DispHTMLCSSImportRule                    = GUIDOF!DispHTMLCSSImportRule;
const GUID IID_DispHTMLCSSMediaList                     = GUIDOF!DispHTMLCSSMediaList;
const GUID IID_DispHTMLCSSMediaRule                     = GUIDOF!DispHTMLCSSMediaRule;
const GUID IID_DispHTMLCSSNamespaceRule                 = GUIDOF!DispHTMLCSSNamespaceRule;
const GUID IID_DispHTMLCSSRule                          = GUIDOF!DispHTMLCSSRule;
const GUID IID_DispHTMLCSSStyleDeclaration              = GUIDOF!DispHTMLCSSStyleDeclaration;
const GUID IID_DispHTMLCanvasElement                    = GUIDOF!DispHTMLCanvasElement;
const GUID IID_DispHTMLCommentElement                   = GUIDOF!DispHTMLCommentElement;
const GUID IID_DispHTMLCurrentStyle                     = GUIDOF!DispHTMLCurrentStyle;
const GUID IID_DispHTMLDDElement                        = GUIDOF!DispHTMLDDElement;
const GUID IID_DispHTMLDListElement                     = GUIDOF!DispHTMLDListElement;
const GUID IID_DispHTMLDOMAttribute                     = GUIDOF!DispHTMLDOMAttribute;
const GUID IID_DispHTMLDOMImplementation                = GUIDOF!DispHTMLDOMImplementation;
const GUID IID_DispHTMLDOMRange                         = GUIDOF!DispHTMLDOMRange;
const GUID IID_DispHTMLDOMTextNode                      = GUIDOF!DispHTMLDOMTextNode;
const GUID IID_DispHTMLDTElement                        = GUIDOF!DispHTMLDTElement;
const GUID IID_DispHTMLDefaults                         = GUIDOF!DispHTMLDefaults;
const GUID IID_DispHTMLDivElement                       = GUIDOF!DispHTMLDivElement;
const GUID IID_DispHTMLDivPosition                      = GUIDOF!DispHTMLDivPosition;
const GUID IID_DispHTMLDocument                         = GUIDOF!DispHTMLDocument;
const GUID IID_DispHTMLDocumentCompatibleInfo           = GUIDOF!DispHTMLDocumentCompatibleInfo;
const GUID IID_DispHTMLDocumentCompatibleInfoCollection = GUIDOF!DispHTMLDocumentCompatibleInfoCollection;
const GUID IID_DispHTMLElementCollection                = GUIDOF!DispHTMLElementCollection;
const GUID IID_DispHTMLEmbed                            = GUIDOF!DispHTMLEmbed;
const GUID IID_DispHTMLFieldSetElement                  = GUIDOF!DispHTMLFieldSetElement;
const GUID IID_DispHTMLFontElement                      = GUIDOF!DispHTMLFontElement;
const GUID IID_DispHTMLFormElement                      = GUIDOF!DispHTMLFormElement;
const GUID IID_DispHTMLFrameBase                        = GUIDOF!DispHTMLFrameBase;
const GUID IID_DispHTMLFrameElement                     = GUIDOF!DispHTMLFrameElement;
const GUID IID_DispHTMLFrameSetSite                     = GUIDOF!DispHTMLFrameSetSite;
const GUID IID_DispHTMLGenericElement                   = GUIDOF!DispHTMLGenericElement;
const GUID IID_DispHTMLHRElement                        = GUIDOF!DispHTMLHRElement;
const GUID IID_DispHTMLHeadElement                      = GUIDOF!DispHTMLHeadElement;
const GUID IID_DispHTMLHeaderElement                    = GUIDOF!DispHTMLHeaderElement;
const GUID IID_DispHTMLHistory                          = GUIDOF!DispHTMLHistory;
const GUID IID_DispHTMLHtmlElement                      = GUIDOF!DispHTMLHtmlElement;
const GUID IID_DispHTMLIFrame                           = GUIDOF!DispHTMLIFrame;
const GUID IID_DispHTMLImg                              = GUIDOF!DispHTMLImg;
const GUID IID_DispHTMLInputElement                     = GUIDOF!DispHTMLInputElement;
const GUID IID_DispHTMLIsIndexElement                   = GUIDOF!DispHTMLIsIndexElement;
const GUID IID_DispHTMLLIElement                        = GUIDOF!DispHTMLLIElement;
const GUID IID_DispHTMLLabelElement                     = GUIDOF!DispHTMLLabelElement;
const GUID IID_DispHTMLLegendElement                    = GUIDOF!DispHTMLLegendElement;
const GUID IID_DispHTMLLinkElement                      = GUIDOF!DispHTMLLinkElement;
const GUID IID_DispHTMLListElement                      = GUIDOF!DispHTMLListElement;
const GUID IID_DispHTMLLocation                         = GUIDOF!DispHTMLLocation;
const GUID IID_DispHTMLMSCSSKeyframeRule                = GUIDOF!DispHTMLMSCSSKeyframeRule;
const GUID IID_DispHTMLMSCSSKeyframesRule               = GUIDOF!DispHTMLMSCSSKeyframesRule;
const GUID IID_DispHTMLMapElement                       = GUIDOF!DispHTMLMapElement;
const GUID IID_DispHTMLMarqueeElement                   = GUIDOF!DispHTMLMarqueeElement;
const GUID IID_DispHTMLMediaElement                     = GUIDOF!DispHTMLMediaElement;
const GUID IID_DispHTMLMediaError                       = GUIDOF!DispHTMLMediaError;
const GUID IID_DispHTMLMetaElement                      = GUIDOF!DispHTMLMetaElement;
const GUID IID_DispHTMLNamespace                        = GUIDOF!DispHTMLNamespace;
const GUID IID_DispHTMLNamespaceCollection              = GUIDOF!DispHTMLNamespaceCollection;
const GUID IID_DispHTMLNavigator                        = GUIDOF!DispHTMLNavigator;
const GUID IID_DispHTMLNextIdElement                    = GUIDOF!DispHTMLNextIdElement;
const GUID IID_DispHTMLNoShowElement                    = GUIDOF!DispHTMLNoShowElement;
const GUID IID_DispHTMLOListElement                     = GUIDOF!DispHTMLOListElement;
const GUID IID_DispHTMLObjectElement                    = GUIDOF!DispHTMLObjectElement;
const GUID IID_DispHTMLOptionElement                    = GUIDOF!DispHTMLOptionElement;
const GUID IID_DispHTMLParaElement                      = GUIDOF!DispHTMLParaElement;
const GUID IID_DispHTMLParamElement                     = GUIDOF!DispHTMLParamElement;
const GUID IID_DispHTMLPerformance                      = GUIDOF!DispHTMLPerformance;
const GUID IID_DispHTMLPerformanceNavigation            = GUIDOF!DispHTMLPerformanceNavigation;
const GUID IID_DispHTMLPerformanceTiming                = GUIDOF!DispHTMLPerformanceTiming;
const GUID IID_DispHTMLPhraseElement                    = GUIDOF!DispHTMLPhraseElement;
const GUID IID_DispHTMLPopup                            = GUIDOF!DispHTMLPopup;
const GUID IID_DispHTMLProgressElement                  = GUIDOF!DispHTMLProgressElement;
const GUID IID_DispHTMLRenderStyle                      = GUIDOF!DispHTMLRenderStyle;
const GUID IID_DispHTMLRichtextElement                  = GUIDOF!DispHTMLRichtextElement;
const GUID IID_DispHTMLRuleStyle                        = GUIDOF!DispHTMLRuleStyle;
const GUID IID_DispHTMLScreen                           = GUIDOF!DispHTMLScreen;
const GUID IID_DispHTMLScriptElement                    = GUIDOF!DispHTMLScriptElement;
const GUID IID_DispHTMLSelectElement                    = GUIDOF!DispHTMLSelectElement;
const GUID IID_DispHTMLSemanticElement                  = GUIDOF!DispHTMLSemanticElement;
const GUID IID_DispHTMLSourceElement                    = GUIDOF!DispHTMLSourceElement;
const GUID IID_DispHTMLSpanElement                      = GUIDOF!DispHTMLSpanElement;
const GUID IID_DispHTMLSpanFlow                         = GUIDOF!DispHTMLSpanFlow;
const GUID IID_DispHTMLStorage                          = GUIDOF!DispHTMLStorage;
const GUID IID_DispHTMLStyle                            = GUIDOF!DispHTMLStyle;
const GUID IID_DispHTMLStyleElement                     = GUIDOF!DispHTMLStyleElement;
const GUID IID_DispHTMLStyleFontFace                    = GUIDOF!DispHTMLStyleFontFace;
const GUID IID_DispHTMLStyleMedia                       = GUIDOF!DispHTMLStyleMedia;
const GUID IID_DispHTMLStyleSheet                       = GUIDOF!DispHTMLStyleSheet;
const GUID IID_DispHTMLStyleSheetPage                   = GUIDOF!DispHTMLStyleSheetPage;
const GUID IID_DispHTMLStyleSheetPagesCollection        = GUIDOF!DispHTMLStyleSheetPagesCollection;
const GUID IID_DispHTMLStyleSheetRule                   = GUIDOF!DispHTMLStyleSheetRule;
const GUID IID_DispHTMLStyleSheetRulesAppliedCollection = GUIDOF!DispHTMLStyleSheetRulesAppliedCollection;
const GUID IID_DispHTMLStyleSheetRulesCollection        = GUIDOF!DispHTMLStyleSheetRulesCollection;
const GUID IID_DispHTMLStyleSheetsCollection            = GUIDOF!DispHTMLStyleSheetsCollection;
const GUID IID_DispHTMLTable                            = GUIDOF!DispHTMLTable;
const GUID IID_DispHTMLTableCaption                     = GUIDOF!DispHTMLTableCaption;
const GUID IID_DispHTMLTableCell                        = GUIDOF!DispHTMLTableCell;
const GUID IID_DispHTMLTableCol                         = GUIDOF!DispHTMLTableCol;
const GUID IID_DispHTMLTableRow                         = GUIDOF!DispHTMLTableRow;
const GUID IID_DispHTMLTableSection                     = GUIDOF!DispHTMLTableSection;
const GUID IID_DispHTMLTextAreaElement                  = GUIDOF!DispHTMLTextAreaElement;
const GUID IID_DispHTMLTextElement                      = GUIDOF!DispHTMLTextElement;
const GUID IID_DispHTMLTimeRanges                       = GUIDOF!DispHTMLTimeRanges;
const GUID IID_DispHTMLTitleElement                     = GUIDOF!DispHTMLTitleElement;
const GUID IID_DispHTMLUListElement                     = GUIDOF!DispHTMLUListElement;
const GUID IID_DispHTMLUnknownElement                   = GUIDOF!DispHTMLUnknownElement;
const GUID IID_DispHTMLUrnCollection                    = GUIDOF!DispHTMLUrnCollection;
const GUID IID_DispHTMLVideoElement                     = GUIDOF!DispHTMLVideoElement;
const GUID IID_DispHTMLW3CComputedStyle                 = GUIDOF!DispHTMLW3CComputedStyle;
const GUID IID_DispHTMLWindow2                          = GUIDOF!DispHTMLWindow2;
const GUID IID_DispHTMLWindowProxy                      = GUIDOF!DispHTMLWindowProxy;
const GUID IID_DispHTMLWndOptionElement                 = GUIDOF!DispHTMLWndOptionElement;
const GUID IID_DispHTMLWndSelectElement                 = GUIDOF!DispHTMLWndSelectElement;
const GUID IID_DispHTMLXMLHttpRequest                   = GUIDOF!DispHTMLXMLHttpRequest;
const GUID IID_DispIHTMLInputButtonElement              = GUIDOF!DispIHTMLInputButtonElement;
const GUID IID_DispIHTMLInputFileElement                = GUIDOF!DispIHTMLInputFileElement;
const GUID IID_DispIHTMLInputImage                      = GUIDOF!DispIHTMLInputImage;
const GUID IID_DispIHTMLInputTextElement                = GUIDOF!DispIHTMLInputTextElement;
const GUID IID_DispIHTMLOptionButtonElement             = GUIDOF!DispIHTMLOptionButtonElement;
const GUID IID_DispNodeIterator                         = GUIDOF!DispNodeIterator;
const GUID IID_DispRangeException                       = GUIDOF!DispRangeException;
const GUID IID_DispRulesApplied                         = GUIDOF!DispRulesApplied;
const GUID IID_DispRulesAppliedCollection               = GUIDOF!DispRulesAppliedCollection;
const GUID IID_DispSVGAElement                          = GUIDOF!DispSVGAElement;
const GUID IID_DispSVGCircleElement                     = GUIDOF!DispSVGCircleElement;
const GUID IID_DispSVGClipPathElement                   = GUIDOF!DispSVGClipPathElement;
const GUID IID_DispSVGDefsElement                       = GUIDOF!DispSVGDefsElement;
const GUID IID_DispSVGDescElement                       = GUIDOF!DispSVGDescElement;
const GUID IID_DispSVGElement                           = GUIDOF!DispSVGElement;
const GUID IID_DispSVGElementInstance                   = GUIDOF!DispSVGElementInstance;
const GUID IID_DispSVGElementInstanceList               = GUIDOF!DispSVGElementInstanceList;
const GUID IID_DispSVGEllipseElement                    = GUIDOF!DispSVGEllipseElement;
const GUID IID_DispSVGException                         = GUIDOF!DispSVGException;
const GUID IID_DispSVGGElement                          = GUIDOF!DispSVGGElement;
const GUID IID_DispSVGGradientElement                   = GUIDOF!DispSVGGradientElement;
const GUID IID_DispSVGImageElement                      = GUIDOF!DispSVGImageElement;
const GUID IID_DispSVGLineElement                       = GUIDOF!DispSVGLineElement;
const GUID IID_DispSVGLinearGradientElement             = GUIDOF!DispSVGLinearGradientElement;
const GUID IID_DispSVGMarkerElement                     = GUIDOF!DispSVGMarkerElement;
const GUID IID_DispSVGMaskElement                       = GUIDOF!DispSVGMaskElement;
const GUID IID_DispSVGMetadataElement                   = GUIDOF!DispSVGMetadataElement;
const GUID IID_DispSVGPathElement                       = GUIDOF!DispSVGPathElement;
const GUID IID_DispSVGPathSegArcAbs                     = GUIDOF!DispSVGPathSegArcAbs;
const GUID IID_DispSVGPathSegArcRel                     = GUIDOF!DispSVGPathSegArcRel;
const GUID IID_DispSVGPathSegClosePath                  = GUIDOF!DispSVGPathSegClosePath;
const GUID IID_DispSVGPathSegCurvetoCubicAbs            = GUIDOF!DispSVGPathSegCurvetoCubicAbs;
const GUID IID_DispSVGPathSegCurvetoCubicRel            = GUIDOF!DispSVGPathSegCurvetoCubicRel;
const GUID IID_DispSVGPathSegCurvetoCubicSmoothAbs      = GUIDOF!DispSVGPathSegCurvetoCubicSmoothAbs;
const GUID IID_DispSVGPathSegCurvetoCubicSmoothRel      = GUIDOF!DispSVGPathSegCurvetoCubicSmoothRel;
const GUID IID_DispSVGPathSegCurvetoQuadraticAbs        = GUIDOF!DispSVGPathSegCurvetoQuadraticAbs;
const GUID IID_DispSVGPathSegCurvetoQuadraticRel        = GUIDOF!DispSVGPathSegCurvetoQuadraticRel;
const GUID IID_DispSVGPathSegCurvetoQuadraticSmoothAbs  = GUIDOF!DispSVGPathSegCurvetoQuadraticSmoothAbs;
const GUID IID_DispSVGPathSegCurvetoQuadraticSmoothRel  = GUIDOF!DispSVGPathSegCurvetoQuadraticSmoothRel;
const GUID IID_DispSVGPathSegLinetoAbs                  = GUIDOF!DispSVGPathSegLinetoAbs;
const GUID IID_DispSVGPathSegLinetoHorizontalAbs        = GUIDOF!DispSVGPathSegLinetoHorizontalAbs;
const GUID IID_DispSVGPathSegLinetoHorizontalRel        = GUIDOF!DispSVGPathSegLinetoHorizontalRel;
const GUID IID_DispSVGPathSegLinetoRel                  = GUIDOF!DispSVGPathSegLinetoRel;
const GUID IID_DispSVGPathSegLinetoVerticalAbs          = GUIDOF!DispSVGPathSegLinetoVerticalAbs;
const GUID IID_DispSVGPathSegLinetoVerticalRel          = GUIDOF!DispSVGPathSegLinetoVerticalRel;
const GUID IID_DispSVGPathSegMovetoAbs                  = GUIDOF!DispSVGPathSegMovetoAbs;
const GUID IID_DispSVGPathSegMovetoRel                  = GUIDOF!DispSVGPathSegMovetoRel;
const GUID IID_DispSVGPatternElement                    = GUIDOF!DispSVGPatternElement;
const GUID IID_DispSVGPolygonElement                    = GUIDOF!DispSVGPolygonElement;
const GUID IID_DispSVGPolylineElement                   = GUIDOF!DispSVGPolylineElement;
const GUID IID_DispSVGRadialGradientElement             = GUIDOF!DispSVGRadialGradientElement;
const GUID IID_DispSVGRectElement                       = GUIDOF!DispSVGRectElement;
const GUID IID_DispSVGSVGElement                        = GUIDOF!DispSVGSVGElement;
const GUID IID_DispSVGScriptElement                     = GUIDOF!DispSVGScriptElement;
const GUID IID_DispSVGStopElement                       = GUIDOF!DispSVGStopElement;
const GUID IID_DispSVGStyleElement                      = GUIDOF!DispSVGStyleElement;
const GUID IID_DispSVGSwitchElement                     = GUIDOF!DispSVGSwitchElement;
const GUID IID_DispSVGSymbolElement                     = GUIDOF!DispSVGSymbolElement;
const GUID IID_DispSVGTSpanElement                      = GUIDOF!DispSVGTSpanElement;
const GUID IID_DispSVGTextContentElement                = GUIDOF!DispSVGTextContentElement;
const GUID IID_DispSVGTextElement                       = GUIDOF!DispSVGTextElement;
const GUID IID_DispSVGTextPathElement                   = GUIDOF!DispSVGTextPathElement;
const GUID IID_DispSVGTextPositioningElement            = GUIDOF!DispSVGTextPositioningElement;
const GUID IID_DispSVGTitleElement                      = GUIDOF!DispSVGTitleElement;
const GUID IID_DispSVGUseElement                        = GUIDOF!DispSVGUseElement;
const GUID IID_DispSVGViewElement                       = GUIDOF!DispSVGViewElement;
const GUID IID_DispSVGZoomEvent                         = GUIDOF!DispSVGZoomEvent;
const GUID IID_DispStaticNodeList                       = GUIDOF!DispStaticNodeList;
const GUID IID_DispTreeWalker                           = GUIDOF!DispTreeWalker;
const GUID IID_DispWebGeocoordinates                    = GUIDOF!DispWebGeocoordinates;
const GUID IID_DispWebGeolocation                       = GUIDOF!DispWebGeolocation;
const GUID IID_DispWebGeoposition                       = GUIDOF!DispWebGeoposition;
const GUID IID_DispWebGeopositionError                  = GUIDOF!DispWebGeopositionError;
const GUID IID_DispXDomainRequest                       = GUIDOF!DispXDomainRequest;
const GUID IID_DispXMLHttpRequestEventTarget            = GUIDOF!DispXMLHttpRequestEventTarget;
const GUID IID_DispXMLSerializer                        = GUIDOF!DispXMLSerializer;
const GUID IID_HTMLAnchorEvents                         = GUIDOF!HTMLAnchorEvents;
const GUID IID_HTMLAnchorEvents2                        = GUIDOF!HTMLAnchorEvents2;
const GUID IID_HTMLAreaEvents                           = GUIDOF!HTMLAreaEvents;
const GUID IID_HTMLAreaEvents2                          = GUIDOF!HTMLAreaEvents2;
const GUID IID_HTMLButtonElementEvents                  = GUIDOF!HTMLButtonElementEvents;
const GUID IID_HTMLButtonElementEvents2                 = GUIDOF!HTMLButtonElementEvents2;
const GUID IID_HTMLControlElementEvents                 = GUIDOF!HTMLControlElementEvents;
const GUID IID_HTMLControlElementEvents2                = GUIDOF!HTMLControlElementEvents2;
const GUID IID_HTMLDocumentEvents                       = GUIDOF!HTMLDocumentEvents;
const GUID IID_HTMLDocumentEvents2                      = GUIDOF!HTMLDocumentEvents2;
const GUID IID_HTMLDocumentEvents3                      = GUIDOF!HTMLDocumentEvents3;
const GUID IID_HTMLDocumentEvents4                      = GUIDOF!HTMLDocumentEvents4;
const GUID IID_HTMLElementEvents                        = GUIDOF!HTMLElementEvents;
const GUID IID_HTMLElementEvents2                       = GUIDOF!HTMLElementEvents2;
const GUID IID_HTMLElementEvents3                       = GUIDOF!HTMLElementEvents3;
const GUID IID_HTMLElementEvents4                       = GUIDOF!HTMLElementEvents4;
const GUID IID_HTMLFormElementEvents                    = GUIDOF!HTMLFormElementEvents;
const GUID IID_HTMLFormElementEvents2                   = GUIDOF!HTMLFormElementEvents2;
const GUID IID_HTMLFrameSiteEvents                      = GUIDOF!HTMLFrameSiteEvents;
const GUID IID_HTMLFrameSiteEvents2                     = GUIDOF!HTMLFrameSiteEvents2;
const GUID IID_HTMLImgEvents                            = GUIDOF!HTMLImgEvents;
const GUID IID_HTMLImgEvents2                           = GUIDOF!HTMLImgEvents2;
const GUID IID_HTMLInputFileElementEvents               = GUIDOF!HTMLInputFileElementEvents;
const GUID IID_HTMLInputFileElementEvents2              = GUIDOF!HTMLInputFileElementEvents2;
const GUID IID_HTMLInputImageEvents                     = GUIDOF!HTMLInputImageEvents;
const GUID IID_HTMLInputImageEvents2                    = GUIDOF!HTMLInputImageEvents2;
const GUID IID_HTMLInputTextElementEvents               = GUIDOF!HTMLInputTextElementEvents;
const GUID IID_HTMLInputTextElementEvents2              = GUIDOF!HTMLInputTextElementEvents2;
const GUID IID_HTMLLabelEvents                          = GUIDOF!HTMLLabelEvents;
const GUID IID_HTMLLabelEvents2                         = GUIDOF!HTMLLabelEvents2;
const GUID IID_HTMLLinkElementEvents                    = GUIDOF!HTMLLinkElementEvents;
const GUID IID_HTMLLinkElementEvents2                   = GUIDOF!HTMLLinkElementEvents2;
const GUID IID_HTMLMapEvents                            = GUIDOF!HTMLMapEvents;
const GUID IID_HTMLMapEvents2                           = GUIDOF!HTMLMapEvents2;
const GUID IID_HTMLMarqueeElementEvents                 = GUIDOF!HTMLMarqueeElementEvents;
const GUID IID_HTMLMarqueeElementEvents2                = GUIDOF!HTMLMarqueeElementEvents2;
const GUID IID_HTMLNamespaceEvents                      = GUIDOF!HTMLNamespaceEvents;
const GUID IID_HTMLObjectElementEvents                  = GUIDOF!HTMLObjectElementEvents;
const GUID IID_HTMLObjectElementEvents2                 = GUIDOF!HTMLObjectElementEvents2;
const GUID IID_HTMLOptionButtonElementEvents            = GUIDOF!HTMLOptionButtonElementEvents;
const GUID IID_HTMLOptionButtonElementEvents2           = GUIDOF!HTMLOptionButtonElementEvents2;
const GUID IID_HTMLScriptEvents                         = GUIDOF!HTMLScriptEvents;
const GUID IID_HTMLScriptEvents2                        = GUIDOF!HTMLScriptEvents2;
const GUID IID_HTMLSelectElementEvents                  = GUIDOF!HTMLSelectElementEvents;
const GUID IID_HTMLSelectElementEvents2                 = GUIDOF!HTMLSelectElementEvents2;
const GUID IID_HTMLStyleElementEvents                   = GUIDOF!HTMLStyleElementEvents;
const GUID IID_HTMLStyleElementEvents2                  = GUIDOF!HTMLStyleElementEvents2;
const GUID IID_HTMLTableEvents                          = GUIDOF!HTMLTableEvents;
const GUID IID_HTMLTableEvents2                         = GUIDOF!HTMLTableEvents2;
const GUID IID_HTMLTextContainerEvents                  = GUIDOF!HTMLTextContainerEvents;
const GUID IID_HTMLTextContainerEvents2                 = GUIDOF!HTMLTextContainerEvents2;
const GUID IID_HTMLWindowEvents                         = GUIDOF!HTMLWindowEvents;
const GUID IID_HTMLWindowEvents2                        = GUIDOF!HTMLWindowEvents2;
const GUID IID_HTMLWindowEvents3                        = GUIDOF!HTMLWindowEvents3;
const GUID IID_HTMLXMLHttpRequestEvents                 = GUIDOF!HTMLXMLHttpRequestEvents;
const GUID IID_IBFCacheable                             = GUIDOF!IBFCacheable;
const GUID IID_IBlockFormats                            = GUIDOF!IBlockFormats;
const GUID IID_ICSSFilter                               = GUIDOF!ICSSFilter;
const GUID IID_ICSSFilterSite                           = GUIDOF!ICSSFilterSite;
const GUID IID_ICanvasGradient                          = GUIDOF!ICanvasGradient;
const GUID IID_ICanvasImageData                         = GUIDOF!ICanvasImageData;
const GUID IID_ICanvasPattern                           = GUIDOF!ICanvasPattern;
const GUID IID_ICanvasPixelArray                        = GUIDOF!ICanvasPixelArray;
const GUID IID_ICanvasPixelArrayData                    = GUIDOF!ICanvasPixelArrayData;
const GUID IID_ICanvasRenderingContext2D                = GUIDOF!ICanvasRenderingContext2D;
const GUID IID_ICanvasTextMetrics                       = GUIDOF!ICanvasTextMetrics;
const GUID IID_IClassFactoryEx                          = GUIDOF!IClassFactoryEx;
const GUID IID_IClientCaps                              = GUIDOF!IClientCaps;
const GUID IID_ICustomDoc                               = GUIDOF!ICustomDoc;
const GUID IID_IDOMBeforeUnloadEvent                    = GUIDOF!IDOMBeforeUnloadEvent;
const GUID IID_IDOMCloseEvent                           = GUIDOF!IDOMCloseEvent;
const GUID IID_IDOMCompositionEvent                     = GUIDOF!IDOMCompositionEvent;
const GUID IID_IDOMCustomEvent                          = GUIDOF!IDOMCustomEvent;
const GUID IID_IDOMDocumentType                         = GUIDOF!IDOMDocumentType;
const GUID IID_IDOMDragEvent                            = GUIDOF!IDOMDragEvent;
const GUID IID_IDOMEvent                                = GUIDOF!IDOMEvent;
const GUID IID_IDOMEventRegistrationCallback            = GUIDOF!IDOMEventRegistrationCallback;
const GUID IID_IDOMException                            = GUIDOF!IDOMException;
const GUID IID_IDOMFocusEvent                           = GUIDOF!IDOMFocusEvent;
const GUID IID_IDOMKeyboardEvent                        = GUIDOF!IDOMKeyboardEvent;
const GUID IID_IDOMMSAnimationEvent                     = GUIDOF!IDOMMSAnimationEvent;
const GUID IID_IDOMMSManipulationEvent                  = GUIDOF!IDOMMSManipulationEvent;
const GUID IID_IDOMMSTransitionEvent                    = GUIDOF!IDOMMSTransitionEvent;
const GUID IID_IDOMMessageEvent                         = GUIDOF!IDOMMessageEvent;
const GUID IID_IDOMMouseEvent                           = GUIDOF!IDOMMouseEvent;
const GUID IID_IDOMMouseWheelEvent                      = GUIDOF!IDOMMouseWheelEvent;
const GUID IID_IDOMMutationEvent                        = GUIDOF!IDOMMutationEvent;
const GUID IID_IDOMNodeIterator                         = GUIDOF!IDOMNodeIterator;
const GUID IID_IDOMParser                               = GUIDOF!IDOMParser;
const GUID IID_IDOMParserFactory                        = GUIDOF!IDOMParserFactory;
const GUID IID_IDOMProcessingInstruction                = GUIDOF!IDOMProcessingInstruction;
const GUID IID_IDOMProgressEvent                        = GUIDOF!IDOMProgressEvent;
const GUID IID_IDOMSiteModeEvent                        = GUIDOF!IDOMSiteModeEvent;
const GUID IID_IDOMStorageEvent                         = GUIDOF!IDOMStorageEvent;
const GUID IID_IDOMTextEvent                            = GUIDOF!IDOMTextEvent;
const GUID IID_IDOMTreeWalker                           = GUIDOF!IDOMTreeWalker;
const GUID IID_IDOMUIEvent                              = GUIDOF!IDOMUIEvent;
const GUID IID_IDOMWheelEvent                           = GUIDOF!IDOMWheelEvent;
const GUID IID_IDOMXmlSerializer                        = GUIDOF!IDOMXmlSerializer;
const GUID IID_IDOMXmlSerializerFactory                 = GUIDOF!IDOMXmlSerializerFactory;
const GUID IID_IDebugCallbackNotificationHandler        = GUIDOF!IDebugCallbackNotificationHandler;
const GUID IID_IDeveloperConsoleMessageReceiver         = GUIDOF!IDeveloperConsoleMessageReceiver;
const GUID IID_IDiagnosticsScriptEngine                 = GUIDOF!IDiagnosticsScriptEngine;
const GUID IID_IDiagnosticsScriptEngineProvider         = GUIDOF!IDiagnosticsScriptEngineProvider;
const GUID IID_IDiagnosticsScriptEngineSite             = GUIDOF!IDiagnosticsScriptEngineSite;
const GUID IID_IDisplayPointer                          = GUIDOF!IDisplayPointer;
const GUID IID_IDisplayServices                         = GUIDOF!IDisplayServices;
const GUID IID_IDocHostShowUI                           = GUIDOF!IDocHostShowUI;
const GUID IID_IDocHostUIHandler                        = GUIDOF!IDocHostUIHandler;
const GUID IID_IDocHostUIHandler2                       = GUIDOF!IDocHostUIHandler2;
const GUID IID_IDocumentEvent                           = GUIDOF!IDocumentEvent;
const GUID IID_IDocumentRange                           = GUIDOF!IDocumentRange;
const GUID IID_IDocumentSelector                        = GUIDOF!IDocumentSelector;
const GUID IID_IDocumentTraversal                       = GUIDOF!IDocumentTraversal;
const GUID IID_IElementBehavior                         = GUIDOF!IElementBehavior;
const GUID IID_IElementBehaviorCategory                 = GUIDOF!IElementBehaviorCategory;
const GUID IID_IElementBehaviorFactory                  = GUIDOF!IElementBehaviorFactory;
const GUID IID_IElementBehaviorFocus                    = GUIDOF!IElementBehaviorFocus;
const GUID IID_IElementBehaviorLayout                   = GUIDOF!IElementBehaviorLayout;
const GUID IID_IElementBehaviorLayout2                  = GUIDOF!IElementBehaviorLayout2;
const GUID IID_IElementBehaviorRender                   = GUIDOF!IElementBehaviorRender;
const GUID IID_IElementBehaviorSite                     = GUIDOF!IElementBehaviorSite;
const GUID IID_IElementBehaviorSiteCategory             = GUIDOF!IElementBehaviorSiteCategory;
const GUID IID_IElementBehaviorSiteLayout               = GUIDOF!IElementBehaviorSiteLayout;
const GUID IID_IElementBehaviorSiteLayout2              = GUIDOF!IElementBehaviorSiteLayout2;
const GUID IID_IElementBehaviorSiteOM                   = GUIDOF!IElementBehaviorSiteOM;
const GUID IID_IElementBehaviorSiteOM2                  = GUIDOF!IElementBehaviorSiteOM2;
const GUID IID_IElementBehaviorSiteRender               = GUIDOF!IElementBehaviorSiteRender;
const GUID IID_IElementBehaviorSubmit                   = GUIDOF!IElementBehaviorSubmit;
const GUID IID_IElementNamespace                        = GUIDOF!IElementNamespace;
const GUID IID_IElementNamespaceFactory                 = GUIDOF!IElementNamespaceFactory;
const GUID IID_IElementNamespaceFactory2                = GUIDOF!IElementNamespaceFactory2;
const GUID IID_IElementNamespaceFactoryCallback         = GUIDOF!IElementNamespaceFactoryCallback;
const GUID IID_IElementNamespaceTable                   = GUIDOF!IElementNamespaceTable;
const GUID IID_IElementSegment                          = GUIDOF!IElementSegment;
const GUID IID_IElementSelector                         = GUIDOF!IElementSelector;
const GUID IID_IElementTraversal                        = GUIDOF!IElementTraversal;
const GUID IID_IEnumPrivacyRecords                      = GUIDOF!IEnumPrivacyRecords;
const GUID IID_IEventException                          = GUIDOF!IEventException;
const GUID IID_IEventTarget                             = GUIDOF!IEventTarget;
const GUID IID_IEventTarget2                            = GUIDOF!IEventTarget2;
const GUID IID_IFontNames                               = GUIDOF!IFontNames;
const GUID IID_IGetSVGDocument                          = GUIDOF!IGetSVGDocument;
const GUID IID_IHTCAttachBehavior                       = GUIDOF!IHTCAttachBehavior;
const GUID IID_IHTCAttachBehavior2                      = GUIDOF!IHTCAttachBehavior2;
const GUID IID_IHTCDefaultDispatch                      = GUIDOF!IHTCDefaultDispatch;
const GUID IID_IHTCDescBehavior                         = GUIDOF!IHTCDescBehavior;
const GUID IID_IHTCEventBehavior                        = GUIDOF!IHTCEventBehavior;
const GUID IID_IHTCMethodBehavior                       = GUIDOF!IHTCMethodBehavior;
const GUID IID_IHTCPropertyBehavior                     = GUIDOF!IHTCPropertyBehavior;
const GUID IID_IHTMLAnchorElement                       = GUIDOF!IHTMLAnchorElement;
const GUID IID_IHTMLAnchorElement2                      = GUIDOF!IHTMLAnchorElement2;
const GUID IID_IHTMLAnchorElement3                      = GUIDOF!IHTMLAnchorElement3;
const GUID IID_IHTMLAppBehavior                         = GUIDOF!IHTMLAppBehavior;
const GUID IID_IHTMLAppBehavior2                        = GUIDOF!IHTMLAppBehavior2;
const GUID IID_IHTMLAppBehavior3                        = GUIDOF!IHTMLAppBehavior3;
const GUID IID_IHTMLApplicationCache                    = GUIDOF!IHTMLApplicationCache;
const GUID IID_IHTMLAreaElement                         = GUIDOF!IHTMLAreaElement;
const GUID IID_IHTMLAreaElement2                        = GUIDOF!IHTMLAreaElement2;
const GUID IID_IHTMLAreasCollection                     = GUIDOF!IHTMLAreasCollection;
const GUID IID_IHTMLAreasCollection2                    = GUIDOF!IHTMLAreasCollection2;
const GUID IID_IHTMLAreasCollection3                    = GUIDOF!IHTMLAreasCollection3;
const GUID IID_IHTMLAreasCollection4                    = GUIDOF!IHTMLAreasCollection4;
const GUID IID_IHTMLAttributeCollection                 = GUIDOF!IHTMLAttributeCollection;
const GUID IID_IHTMLAttributeCollection2                = GUIDOF!IHTMLAttributeCollection2;
const GUID IID_IHTMLAttributeCollection3                = GUIDOF!IHTMLAttributeCollection3;
const GUID IID_IHTMLAttributeCollection4                = GUIDOF!IHTMLAttributeCollection4;
const GUID IID_IHTMLAudioElement                        = GUIDOF!IHTMLAudioElement;
const GUID IID_IHTMLAudioElementFactory                 = GUIDOF!IHTMLAudioElementFactory;
const GUID IID_IHTMLBGsound                             = GUIDOF!IHTMLBGsound;
const GUID IID_IHTMLBRElement                           = GUIDOF!IHTMLBRElement;
const GUID IID_IHTMLBaseElement                         = GUIDOF!IHTMLBaseElement;
const GUID IID_IHTMLBaseElement2                        = GUIDOF!IHTMLBaseElement2;
const GUID IID_IHTMLBaseFontElement                     = GUIDOF!IHTMLBaseFontElement;
const GUID IID_IHTMLBlockElement                        = GUIDOF!IHTMLBlockElement;
const GUID IID_IHTMLBlockElement2                       = GUIDOF!IHTMLBlockElement2;
const GUID IID_IHTMLBlockElement3                       = GUIDOF!IHTMLBlockElement3;
const GUID IID_IHTMLBodyElement                         = GUIDOF!IHTMLBodyElement;
const GUID IID_IHTMLBodyElement2                        = GUIDOF!IHTMLBodyElement2;
const GUID IID_IHTMLBodyElement3                        = GUIDOF!IHTMLBodyElement3;
const GUID IID_IHTMLBodyElement4                        = GUIDOF!IHTMLBodyElement4;
const GUID IID_IHTMLBodyElement5                        = GUIDOF!IHTMLBodyElement5;
const GUID IID_IHTMLBookmarkCollection                  = GUIDOF!IHTMLBookmarkCollection;
const GUID IID_IHTMLButtonElement                       = GUIDOF!IHTMLButtonElement;
const GUID IID_IHTMLButtonElement2                      = GUIDOF!IHTMLButtonElement2;
const GUID IID_IHTMLCSSImportRule                       = GUIDOF!IHTMLCSSImportRule;
const GUID IID_IHTMLCSSMediaList                        = GUIDOF!IHTMLCSSMediaList;
const GUID IID_IHTMLCSSMediaRule                        = GUIDOF!IHTMLCSSMediaRule;
const GUID IID_IHTMLCSSNamespaceRule                    = GUIDOF!IHTMLCSSNamespaceRule;
const GUID IID_IHTMLCSSRule                             = GUIDOF!IHTMLCSSRule;
const GUID IID_IHTMLCSSStyleDeclaration                 = GUIDOF!IHTMLCSSStyleDeclaration;
const GUID IID_IHTMLCSSStyleDeclaration2                = GUIDOF!IHTMLCSSStyleDeclaration2;
const GUID IID_IHTMLCSSStyleDeclaration3                = GUIDOF!IHTMLCSSStyleDeclaration3;
const GUID IID_IHTMLCSSStyleDeclaration4                = GUIDOF!IHTMLCSSStyleDeclaration4;
const GUID IID_IHTMLCanvasElement                       = GUIDOF!IHTMLCanvasElement;
const GUID IID_IHTMLCaret                               = GUIDOF!IHTMLCaret;
const GUID IID_IHTMLChangeLog                           = GUIDOF!IHTMLChangeLog;
const GUID IID_IHTMLChangePlayback                      = GUIDOF!IHTMLChangePlayback;
const GUID IID_IHTMLChangeSink                          = GUIDOF!IHTMLChangeSink;
const GUID IID_IHTMLCommentElement                      = GUIDOF!IHTMLCommentElement;
const GUID IID_IHTMLCommentElement2                     = GUIDOF!IHTMLCommentElement2;
const GUID IID_IHTMLCommentElement3                     = GUIDOF!IHTMLCommentElement3;
const GUID IID_IHTMLComputedStyle                       = GUIDOF!IHTMLComputedStyle;
const GUID IID_IHTMLControlElement                      = GUIDOF!IHTMLControlElement;
const GUID IID_IHTMLControlRange                        = GUIDOF!IHTMLControlRange;
const GUID IID_IHTMLControlRange2                       = GUIDOF!IHTMLControlRange2;
const GUID IID_IHTMLCurrentStyle                        = GUIDOF!IHTMLCurrentStyle;
const GUID IID_IHTMLCurrentStyle2                       = GUIDOF!IHTMLCurrentStyle2;
const GUID IID_IHTMLCurrentStyle3                       = GUIDOF!IHTMLCurrentStyle3;
const GUID IID_IHTMLCurrentStyle4                       = GUIDOF!IHTMLCurrentStyle4;
const GUID IID_IHTMLCurrentStyle5                       = GUIDOF!IHTMLCurrentStyle5;
const GUID IID_IHTMLDDElement                           = GUIDOF!IHTMLDDElement;
const GUID IID_IHTMLDListElement                        = GUIDOF!IHTMLDListElement;
const GUID IID_IHTMLDOMAttribute                        = GUIDOF!IHTMLDOMAttribute;
const GUID IID_IHTMLDOMAttribute2                       = GUIDOF!IHTMLDOMAttribute2;
const GUID IID_IHTMLDOMAttribute3                       = GUIDOF!IHTMLDOMAttribute3;
const GUID IID_IHTMLDOMAttribute4                       = GUIDOF!IHTMLDOMAttribute4;
const GUID IID_IHTMLDOMChildrenCollection               = GUIDOF!IHTMLDOMChildrenCollection;
const GUID IID_IHTMLDOMChildrenCollection2              = GUIDOF!IHTMLDOMChildrenCollection2;
const GUID IID_IHTMLDOMConstructor                      = GUIDOF!IHTMLDOMConstructor;
const GUID IID_IHTMLDOMConstructorCollection            = GUIDOF!IHTMLDOMConstructorCollection;
const GUID IID_IHTMLDOMImplementation                   = GUIDOF!IHTMLDOMImplementation;
const GUID IID_IHTMLDOMImplementation2                  = GUIDOF!IHTMLDOMImplementation2;
const GUID IID_IHTMLDOMNode                             = GUIDOF!IHTMLDOMNode;
const GUID IID_IHTMLDOMNode2                            = GUIDOF!IHTMLDOMNode2;
const GUID IID_IHTMLDOMNode3                            = GUIDOF!IHTMLDOMNode3;
const GUID IID_IHTMLDOMRange                            = GUIDOF!IHTMLDOMRange;
const GUID IID_IHTMLDOMTextNode                         = GUIDOF!IHTMLDOMTextNode;
const GUID IID_IHTMLDOMTextNode2                        = GUIDOF!IHTMLDOMTextNode2;
const GUID IID_IHTMLDOMTextNode3                        = GUIDOF!IHTMLDOMTextNode3;
const GUID IID_IHTMLDTElement                           = GUIDOF!IHTMLDTElement;
const GUID IID_IHTMLDataTransfer                        = GUIDOF!IHTMLDataTransfer;
const GUID IID_IHTMLDatabinding                         = GUIDOF!IHTMLDatabinding;
const GUID IID_IHTMLDialog                              = GUIDOF!IHTMLDialog;
const GUID IID_IHTMLDialog2                             = GUIDOF!IHTMLDialog2;
const GUID IID_IHTMLDialog3                             = GUIDOF!IHTMLDialog3;
const GUID IID_IHTMLDivElement                          = GUIDOF!IHTMLDivElement;
const GUID IID_IHTMLDivPosition                         = GUIDOF!IHTMLDivPosition;
const GUID IID_IHTMLDocument                            = GUIDOF!IHTMLDocument;
const GUID IID_IHTMLDocument2                           = GUIDOF!IHTMLDocument2;
const GUID IID_IHTMLDocument3                           = GUIDOF!IHTMLDocument3;
const GUID IID_IHTMLDocument4                           = GUIDOF!IHTMLDocument4;
const GUID IID_IHTMLDocument5                           = GUIDOF!IHTMLDocument5;
const GUID IID_IHTMLDocument6                           = GUIDOF!IHTMLDocument6;
const GUID IID_IHTMLDocument7                           = GUIDOF!IHTMLDocument7;
const GUID IID_IHTMLDocument8                           = GUIDOF!IHTMLDocument8;
const GUID IID_IHTMLDocumentCompatibleInfo              = GUIDOF!IHTMLDocumentCompatibleInfo;
const GUID IID_IHTMLDocumentCompatibleInfoCollection    = GUIDOF!IHTMLDocumentCompatibleInfoCollection;
const GUID IID_IHTMLEditDesigner                        = GUIDOF!IHTMLEditDesigner;
const GUID IID_IHTMLEditHost                            = GUIDOF!IHTMLEditHost;
const GUID IID_IHTMLEditHost2                           = GUIDOF!IHTMLEditHost2;
const GUID IID_IHTMLEditServices                        = GUIDOF!IHTMLEditServices;
const GUID IID_IHTMLEditServices2                       = GUIDOF!IHTMLEditServices2;
const GUID IID_IHTMLElement                             = GUIDOF!IHTMLElement;
const GUID IID_IHTMLElement2                            = GUIDOF!IHTMLElement2;
const GUID IID_IHTMLElement3                            = GUIDOF!IHTMLElement3;
const GUID IID_IHTMLElement4                            = GUIDOF!IHTMLElement4;
const GUID IID_IHTMLElement5                            = GUIDOF!IHTMLElement5;
const GUID IID_IHTMLElement6                            = GUIDOF!IHTMLElement6;
const GUID IID_IHTMLElement7                            = GUIDOF!IHTMLElement7;
const GUID IID_IHTMLElementAppliedStyles                = GUIDOF!IHTMLElementAppliedStyles;
const GUID IID_IHTMLElementCollection                   = GUIDOF!IHTMLElementCollection;
const GUID IID_IHTMLElementCollection2                  = GUIDOF!IHTMLElementCollection2;
const GUID IID_IHTMLElementCollection3                  = GUIDOF!IHTMLElementCollection3;
const GUID IID_IHTMLElementCollection4                  = GUIDOF!IHTMLElementCollection4;
const GUID IID_IHTMLElementDefaults                     = GUIDOF!IHTMLElementDefaults;
const GUID IID_IHTMLElementRender                       = GUIDOF!IHTMLElementRender;
const GUID IID_IHTMLEmbedElement                        = GUIDOF!IHTMLEmbedElement;
const GUID IID_IHTMLEmbedElement2                       = GUIDOF!IHTMLEmbedElement2;
const GUID IID_IHTMLEventObj                            = GUIDOF!IHTMLEventObj;
const GUID IID_IHTMLEventObj2                           = GUIDOF!IHTMLEventObj2;
const GUID IID_IHTMLEventObj3                           = GUIDOF!IHTMLEventObj3;
const GUID IID_IHTMLEventObj4                           = GUIDOF!IHTMLEventObj4;
const GUID IID_IHTMLEventObj5                           = GUIDOF!IHTMLEventObj5;
const GUID IID_IHTMLEventObj6                           = GUIDOF!IHTMLEventObj6;
const GUID IID_IHTMLFieldSetElement                     = GUIDOF!IHTMLFieldSetElement;
const GUID IID_IHTMLFieldSetElement2                    = GUIDOF!IHTMLFieldSetElement2;
const GUID IID_IHTMLFiltersCollection                   = GUIDOF!IHTMLFiltersCollection;
const GUID IID_IHTMLFontElement                         = GUIDOF!IHTMLFontElement;
const GUID IID_IHTMLFontNamesCollection                 = GUIDOF!IHTMLFontNamesCollection;
const GUID IID_IHTMLFontSizesCollection                 = GUIDOF!IHTMLFontSizesCollection;
const GUID IID_IHTMLFormElement                         = GUIDOF!IHTMLFormElement;
const GUID IID_IHTMLFormElement2                        = GUIDOF!IHTMLFormElement2;
const GUID IID_IHTMLFormElement3                        = GUIDOF!IHTMLFormElement3;
const GUID IID_IHTMLFormElement4                        = GUIDOF!IHTMLFormElement4;
const GUID IID_IHTMLFrameBase                           = GUIDOF!IHTMLFrameBase;
const GUID IID_IHTMLFrameBase2                          = GUIDOF!IHTMLFrameBase2;
const GUID IID_IHTMLFrameBase3                          = GUIDOF!IHTMLFrameBase3;
const GUID IID_IHTMLFrameElement                        = GUIDOF!IHTMLFrameElement;
const GUID IID_IHTMLFrameElement2                       = GUIDOF!IHTMLFrameElement2;
const GUID IID_IHTMLFrameElement3                       = GUIDOF!IHTMLFrameElement3;
const GUID IID_IHTMLFrameSetElement                     = GUIDOF!IHTMLFrameSetElement;
const GUID IID_IHTMLFrameSetElement2                    = GUIDOF!IHTMLFrameSetElement2;
const GUID IID_IHTMLFrameSetElement3                    = GUIDOF!IHTMLFrameSetElement3;
const GUID IID_IHTMLFramesCollection2                   = GUIDOF!IHTMLFramesCollection2;
const GUID IID_IHTMLGenericElement                      = GUIDOF!IHTMLGenericElement;
const GUID IID_IHTMLHRElement                           = GUIDOF!IHTMLHRElement;
const GUID IID_IHTMLHeadElement                         = GUIDOF!IHTMLHeadElement;
const GUID IID_IHTMLHeadElement2                        = GUIDOF!IHTMLHeadElement2;
const GUID IID_IHTMLHeaderElement                       = GUIDOF!IHTMLHeaderElement;
const GUID IID_IHTMLHtmlElement                         = GUIDOF!IHTMLHtmlElement;
const GUID IID_IHTMLIFrameElement                       = GUIDOF!IHTMLIFrameElement;
const GUID IID_IHTMLIFrameElement2                      = GUIDOF!IHTMLIFrameElement2;
const GUID IID_IHTMLIFrameElement3                      = GUIDOF!IHTMLIFrameElement3;
const GUID IID_IHTMLIPrintCollection                    = GUIDOF!IHTMLIPrintCollection;
const GUID IID_IHTMLImageElementFactory                 = GUIDOF!IHTMLImageElementFactory;
const GUID IID_IHTMLImgElement                          = GUIDOF!IHTMLImgElement;
const GUID IID_IHTMLImgElement2                         = GUIDOF!IHTMLImgElement2;
const GUID IID_IHTMLImgElement3                         = GUIDOF!IHTMLImgElement3;
const GUID IID_IHTMLImgElement4                         = GUIDOF!IHTMLImgElement4;
const GUID IID_IHTMLInputButtonElement                  = GUIDOF!IHTMLInputButtonElement;
const GUID IID_IHTMLInputElement                        = GUIDOF!IHTMLInputElement;
const GUID IID_IHTMLInputElement2                       = GUIDOF!IHTMLInputElement2;
const GUID IID_IHTMLInputElement3                       = GUIDOF!IHTMLInputElement3;
const GUID IID_IHTMLInputFileElement                    = GUIDOF!IHTMLInputFileElement;
const GUID IID_IHTMLInputHiddenElement                  = GUIDOF!IHTMLInputHiddenElement;
const GUID IID_IHTMLInputImage                          = GUIDOF!IHTMLInputImage;
const GUID IID_IHTMLInputRangeElement                   = GUIDOF!IHTMLInputRangeElement;
const GUID IID_IHTMLInputTextElement                    = GUIDOF!IHTMLInputTextElement;
const GUID IID_IHTMLInputTextElement2                   = GUIDOF!IHTMLInputTextElement2;
const GUID IID_IHTMLIsIndexElement                      = GUIDOF!IHTMLIsIndexElement;
const GUID IID_IHTMLIsIndexElement2                     = GUIDOF!IHTMLIsIndexElement2;
const GUID IID_IHTMLLIElement                           = GUIDOF!IHTMLLIElement;
const GUID IID_IHTMLLabelElement                        = GUIDOF!IHTMLLabelElement;
const GUID IID_IHTMLLabelElement2                       = GUIDOF!IHTMLLabelElement2;
const GUID IID_IHTMLLegendElement                       = GUIDOF!IHTMLLegendElement;
const GUID IID_IHTMLLegendElement2                      = GUIDOF!IHTMLLegendElement2;
const GUID IID_IHTMLLinkElement                         = GUIDOF!IHTMLLinkElement;
const GUID IID_IHTMLLinkElement2                        = GUIDOF!IHTMLLinkElement2;
const GUID IID_IHTMLLinkElement3                        = GUIDOF!IHTMLLinkElement3;
const GUID IID_IHTMLLinkElement4                        = GUIDOF!IHTMLLinkElement4;
const GUID IID_IHTMLLinkElement5                        = GUIDOF!IHTMLLinkElement5;
const GUID IID_IHTMLListElement                         = GUIDOF!IHTMLListElement;
const GUID IID_IHTMLListElement2                        = GUIDOF!IHTMLListElement2;
const GUID IID_IHTMLLocation                            = GUIDOF!IHTMLLocation;
const GUID IID_IHTMLMSCSSKeyframeRule                   = GUIDOF!IHTMLMSCSSKeyframeRule;
const GUID IID_IHTMLMSCSSKeyframesRule                  = GUIDOF!IHTMLMSCSSKeyframesRule;
const GUID IID_IHTMLMSImgElement                        = GUIDOF!IHTMLMSImgElement;
const GUID IID_IHTMLMSMediaElement                      = GUIDOF!IHTMLMSMediaElement;
const GUID IID_IHTMLMapElement                          = GUIDOF!IHTMLMapElement;
const GUID IID_IHTMLMarqueeElement                      = GUIDOF!IHTMLMarqueeElement;
const GUID IID_IHTMLMediaElement                        = GUIDOF!IHTMLMediaElement;
const GUID IID_IHTMLMediaElement2                       = GUIDOF!IHTMLMediaElement2;
const GUID IID_IHTMLMediaError                          = GUIDOF!IHTMLMediaError;
const GUID IID_IHTMLMetaElement                         = GUIDOF!IHTMLMetaElement;
const GUID IID_IHTMLMetaElement2                        = GUIDOF!IHTMLMetaElement2;
const GUID IID_IHTMLMetaElement3                        = GUIDOF!IHTMLMetaElement3;
const GUID IID_IHTMLMimeTypesCollection                 = GUIDOF!IHTMLMimeTypesCollection;
const GUID IID_IHTMLModelessInit                        = GUIDOF!IHTMLModelessInit;
const GUID IID_IHTMLNamespace                           = GUIDOF!IHTMLNamespace;
const GUID IID_IHTMLNamespaceCollection                 = GUIDOF!IHTMLNamespaceCollection;
const GUID IID_IHTMLNextIdElement                       = GUIDOF!IHTMLNextIdElement;
const GUID IID_IHTMLNoShowElement                       = GUIDOF!IHTMLNoShowElement;
const GUID IID_IHTMLOListElement                        = GUIDOF!IHTMLOListElement;
const GUID IID_IHTMLOMWindowServices                    = GUIDOF!IHTMLOMWindowServices;
const GUID IID_IHTMLObjectElement                       = GUIDOF!IHTMLObjectElement;
const GUID IID_IHTMLObjectElement2                      = GUIDOF!IHTMLObjectElement2;
const GUID IID_IHTMLObjectElement3                      = GUIDOF!IHTMLObjectElement3;
const GUID IID_IHTMLObjectElement4                      = GUIDOF!IHTMLObjectElement4;
const GUID IID_IHTMLObjectElement5                      = GUIDOF!IHTMLObjectElement5;
const GUID IID_IHTMLOpsProfile                          = GUIDOF!IHTMLOpsProfile;
const GUID IID_IHTMLOptionButtonElement                 = GUIDOF!IHTMLOptionButtonElement;
const GUID IID_IHTMLOptionElement                       = GUIDOF!IHTMLOptionElement;
const GUID IID_IHTMLOptionElement3                      = GUIDOF!IHTMLOptionElement3;
const GUID IID_IHTMLOptionElement4                      = GUIDOF!IHTMLOptionElement4;
const GUID IID_IHTMLOptionElementFactory                = GUIDOF!IHTMLOptionElementFactory;
const GUID IID_IHTMLOptionsHolder                       = GUIDOF!IHTMLOptionsHolder;
const GUID IID_IHTMLPaintSite                           = GUIDOF!IHTMLPaintSite;
const GUID IID_IHTMLPainter                             = GUIDOF!IHTMLPainter;
const GUID IID_IHTMLPainterEventInfo                    = GUIDOF!IHTMLPainterEventInfo;
const GUID IID_IHTMLPainterOverlay                      = GUIDOF!IHTMLPainterOverlay;
const GUID IID_IHTMLParaElement                         = GUIDOF!IHTMLParaElement;
const GUID IID_IHTMLParamElement                        = GUIDOF!IHTMLParamElement;
const GUID IID_IHTMLParamElement2                       = GUIDOF!IHTMLParamElement2;
const GUID IID_IHTMLPerformance                         = GUIDOF!IHTMLPerformance;
const GUID IID_IHTMLPerformanceNavigation               = GUIDOF!IHTMLPerformanceNavigation;
const GUID IID_IHTMLPerformanceTiming                   = GUIDOF!IHTMLPerformanceTiming;
const GUID IID_IHTMLPhraseElement                       = GUIDOF!IHTMLPhraseElement;
const GUID IID_IHTMLPhraseElement2                      = GUIDOF!IHTMLPhraseElement2;
const GUID IID_IHTMLPhraseElement3                      = GUIDOF!IHTMLPhraseElement3;
const GUID IID_IHTMLPluginsCollection                   = GUIDOF!IHTMLPluginsCollection;
const GUID IID_IHTMLPopup                               = GUIDOF!IHTMLPopup;
const GUID IID_IHTMLProgressElement                     = GUIDOF!IHTMLProgressElement;
const GUID IID_IHTMLRect                                = GUIDOF!IHTMLRect;
const GUID IID_IHTMLRect2                               = GUIDOF!IHTMLRect2;
const GUID IID_IHTMLRectCollection                      = GUIDOF!IHTMLRectCollection;
const GUID IID_IHTMLRenderStyle                         = GUIDOF!IHTMLRenderStyle;
const GUID IID_IHTMLRuleStyle                           = GUIDOF!IHTMLRuleStyle;
const GUID IID_IHTMLRuleStyle2                          = GUIDOF!IHTMLRuleStyle2;
const GUID IID_IHTMLRuleStyle3                          = GUIDOF!IHTMLRuleStyle3;
const GUID IID_IHTMLRuleStyle4                          = GUIDOF!IHTMLRuleStyle4;
const GUID IID_IHTMLRuleStyle5                          = GUIDOF!IHTMLRuleStyle5;
const GUID IID_IHTMLRuleStyle6                          = GUIDOF!IHTMLRuleStyle6;
const GUID IID_IHTMLScreen                              = GUIDOF!IHTMLScreen;
const GUID IID_IHTMLScreen2                             = GUIDOF!IHTMLScreen2;
const GUID IID_IHTMLScreen3                             = GUIDOF!IHTMLScreen3;
const GUID IID_IHTMLScreen4                             = GUIDOF!IHTMLScreen4;
const GUID IID_IHTMLScriptElement                       = GUIDOF!IHTMLScriptElement;
const GUID IID_IHTMLScriptElement2                      = GUIDOF!IHTMLScriptElement2;
const GUID IID_IHTMLScriptElement3                      = GUIDOF!IHTMLScriptElement3;
const GUID IID_IHTMLScriptElement4                      = GUIDOF!IHTMLScriptElement4;
const GUID IID_IHTMLSelectElement                       = GUIDOF!IHTMLSelectElement;
const GUID IID_IHTMLSelectElement2                      = GUIDOF!IHTMLSelectElement2;
const GUID IID_IHTMLSelectElement4                      = GUIDOF!IHTMLSelectElement4;
const GUID IID_IHTMLSelectElement5                      = GUIDOF!IHTMLSelectElement5;
const GUID IID_IHTMLSelectElement6                      = GUIDOF!IHTMLSelectElement6;
const GUID IID_IHTMLSelectElementEx                     = GUIDOF!IHTMLSelectElementEx;
const GUID IID_IHTMLSelection                           = GUIDOF!IHTMLSelection;
const GUID IID_IHTMLSelectionObject                     = GUIDOF!IHTMLSelectionObject;
const GUID IID_IHTMLSelectionObject2                    = GUIDOF!IHTMLSelectionObject2;
const GUID IID_IHTMLSourceElement                       = GUIDOF!IHTMLSourceElement;
const GUID IID_IHTMLSpanElement                         = GUIDOF!IHTMLSpanElement;
const GUID IID_IHTMLSpanFlow                            = GUIDOF!IHTMLSpanFlow;
const GUID IID_IHTMLStorage                             = GUIDOF!IHTMLStorage;
const GUID IID_IHTMLStorage2                            = GUIDOF!IHTMLStorage2;
const GUID IID_IHTMLStyle                               = GUIDOF!IHTMLStyle;
const GUID IID_IHTMLStyle2                              = GUIDOF!IHTMLStyle2;
const GUID IID_IHTMLStyle3                              = GUIDOF!IHTMLStyle3;
const GUID IID_IHTMLStyle4                              = GUIDOF!IHTMLStyle4;
const GUID IID_IHTMLStyle5                              = GUIDOF!IHTMLStyle5;
const GUID IID_IHTMLStyle6                              = GUIDOF!IHTMLStyle6;
const GUID IID_IHTMLStyleElement                        = GUIDOF!IHTMLStyleElement;
const GUID IID_IHTMLStyleElement2                       = GUIDOF!IHTMLStyleElement2;
const GUID IID_IHTMLStyleEnabled                        = GUIDOF!IHTMLStyleEnabled;
const GUID IID_IHTMLStyleFontFace                       = GUIDOF!IHTMLStyleFontFace;
const GUID IID_IHTMLStyleFontFace2                      = GUIDOF!IHTMLStyleFontFace2;
const GUID IID_IHTMLStyleMedia                          = GUIDOF!IHTMLStyleMedia;
const GUID IID_IHTMLStyleSheet                          = GUIDOF!IHTMLStyleSheet;
const GUID IID_IHTMLStyleSheet2                         = GUIDOF!IHTMLStyleSheet2;
const GUID IID_IHTMLStyleSheet3                         = GUIDOF!IHTMLStyleSheet3;
const GUID IID_IHTMLStyleSheet4                         = GUIDOF!IHTMLStyleSheet4;
const GUID IID_IHTMLStyleSheetPage                      = GUIDOF!IHTMLStyleSheetPage;
const GUID IID_IHTMLStyleSheetPage2                     = GUIDOF!IHTMLStyleSheetPage2;
const GUID IID_IHTMLStyleSheetPagesCollection           = GUIDOF!IHTMLStyleSheetPagesCollection;
const GUID IID_IHTMLStyleSheetRule                      = GUIDOF!IHTMLStyleSheetRule;
const GUID IID_IHTMLStyleSheetRule2                     = GUIDOF!IHTMLStyleSheetRule2;
const GUID IID_IHTMLStyleSheetRuleApplied               = GUIDOF!IHTMLStyleSheetRuleApplied;
const GUID IID_IHTMLStyleSheetRulesAppliedCollection    = GUIDOF!IHTMLStyleSheetRulesAppliedCollection;
const GUID IID_IHTMLStyleSheetRulesCollection           = GUIDOF!IHTMLStyleSheetRulesCollection;
const GUID IID_IHTMLStyleSheetRulesCollection2          = GUIDOF!IHTMLStyleSheetRulesCollection2;
const GUID IID_IHTMLStyleSheetsCollection               = GUIDOF!IHTMLStyleSheetsCollection;
const GUID IID_IHTMLStyleSheetsCollection2              = GUIDOF!IHTMLStyleSheetsCollection2;
const GUID IID_IHTMLSubmitData                          = GUIDOF!IHTMLSubmitData;
const GUID IID_IHTMLTable                               = GUIDOF!IHTMLTable;
const GUID IID_IHTMLTable2                              = GUIDOF!IHTMLTable2;
const GUID IID_IHTMLTable3                              = GUIDOF!IHTMLTable3;
const GUID IID_IHTMLTable4                              = GUIDOF!IHTMLTable4;
const GUID IID_IHTMLTableCaption                        = GUIDOF!IHTMLTableCaption;
const GUID IID_IHTMLTableCell                           = GUIDOF!IHTMLTableCell;
const GUID IID_IHTMLTableCell2                          = GUIDOF!IHTMLTableCell2;
const GUID IID_IHTMLTableCell3                          = GUIDOF!IHTMLTableCell3;
const GUID IID_IHTMLTableCol                            = GUIDOF!IHTMLTableCol;
const GUID IID_IHTMLTableCol2                           = GUIDOF!IHTMLTableCol2;
const GUID IID_IHTMLTableCol3                           = GUIDOF!IHTMLTableCol3;
const GUID IID_IHTMLTableRow                            = GUIDOF!IHTMLTableRow;
const GUID IID_IHTMLTableRow2                           = GUIDOF!IHTMLTableRow2;
const GUID IID_IHTMLTableRow3                           = GUIDOF!IHTMLTableRow3;
const GUID IID_IHTMLTableRow4                           = GUIDOF!IHTMLTableRow4;
const GUID IID_IHTMLTableRowMetrics                     = GUIDOF!IHTMLTableRowMetrics;
const GUID IID_IHTMLTableSection                        = GUIDOF!IHTMLTableSection;
const GUID IID_IHTMLTableSection2                       = GUIDOF!IHTMLTableSection2;
const GUID IID_IHTMLTableSection3                       = GUIDOF!IHTMLTableSection3;
const GUID IID_IHTMLTableSection4                       = GUIDOF!IHTMLTableSection4;
const GUID IID_IHTMLTextAreaElement                     = GUIDOF!IHTMLTextAreaElement;
const GUID IID_IHTMLTextAreaElement2                    = GUIDOF!IHTMLTextAreaElement2;
const GUID IID_IHTMLTextContainer                       = GUIDOF!IHTMLTextContainer;
const GUID IID_IHTMLTextElement                         = GUIDOF!IHTMLTextElement;
const GUID IID_IHTMLTextRangeMetrics                    = GUIDOF!IHTMLTextRangeMetrics;
const GUID IID_IHTMLTextRangeMetrics2                   = GUIDOF!IHTMLTextRangeMetrics2;
const GUID IID_IHTMLTimeRanges                          = GUIDOF!IHTMLTimeRanges;
const GUID IID_IHTMLTimeRanges2                         = GUIDOF!IHTMLTimeRanges2;
const GUID IID_IHTMLTitleElement                        = GUIDOF!IHTMLTitleElement;
const GUID IID_IHTMLTxtRange                            = GUIDOF!IHTMLTxtRange;
const GUID IID_IHTMLTxtRangeCollection                  = GUIDOF!IHTMLTxtRangeCollection;
const GUID IID_IHTMLUListElement                        = GUIDOF!IHTMLUListElement;
const GUID IID_IHTMLUniqueName                          = GUIDOF!IHTMLUniqueName;
const GUID IID_IHTMLUnknownElement                      = GUIDOF!IHTMLUnknownElement;
const GUID IID_IHTMLUrnCollection                       = GUIDOF!IHTMLUrnCollection;
const GUID IID_IHTMLVideoElement                        = GUIDOF!IHTMLVideoElement;
const GUID IID_IHTMLWindow2                             = GUIDOF!IHTMLWindow2;
const GUID IID_IHTMLWindow3                             = GUIDOF!IHTMLWindow3;
const GUID IID_IHTMLWindow4                             = GUIDOF!IHTMLWindow4;
const GUID IID_IHTMLWindow5                             = GUIDOF!IHTMLWindow5;
const GUID IID_IHTMLWindow6                             = GUIDOF!IHTMLWindow6;
const GUID IID_IHTMLWindow7                             = GUIDOF!IHTMLWindow7;
const GUID IID_IHTMLWindow8                             = GUIDOF!IHTMLWindow8;
const GUID IID_IHTMLXDomainRequest                      = GUIDOF!IHTMLXDomainRequest;
const GUID IID_IHTMLXDomainRequestFactory               = GUIDOF!IHTMLXDomainRequestFactory;
const GUID IID_IHTMLXMLHttpRequest                      = GUIDOF!IHTMLXMLHttpRequest;
const GUID IID_IHTMLXMLHttpRequest2                     = GUIDOF!IHTMLXMLHttpRequest2;
const GUID IID_IHTMLXMLHttpRequestFactory               = GUIDOF!IHTMLXMLHttpRequestFactory;
const GUID IID_IHighlightRenderingServices              = GUIDOF!IHighlightRenderingServices;
const GUID IID_IHighlightSegment                        = GUIDOF!IHighlightSegment;
const GUID IID_IHostBehaviorInit                        = GUIDOF!IHostBehaviorInit;
const GUID IID_IHostDialogHelper                        = GUIDOF!IHostDialogHelper;
const GUID IID_IHtmlDlgSafeHelper                       = GUIDOF!IHtmlDlgSafeHelper;
const GUID IID_IICCSVGColor                             = GUIDOF!IICCSVGColor;
const GUID IID_IIE70DispatchEx                          = GUIDOF!IIE70DispatchEx;
const GUID IID_IIE80DispatchEx                          = GUIDOF!IIE80DispatchEx;
const GUID IID_IIMEServices                             = GUIDOF!IIMEServices;
const GUID IID_ILineInfo                                = GUIDOF!ILineInfo;
const GUID IID_IMarkupContainer                         = GUIDOF!IMarkupContainer;
const GUID IID_IMarkupContainer2                        = GUIDOF!IMarkupContainer2;
const GUID IID_IMarkupPointer                           = GUIDOF!IMarkupPointer;
const GUID IID_IMarkupPointer2                          = GUIDOF!IMarkupPointer2;
const GUID IID_IMarkupServices                          = GUIDOF!IMarkupServices;
const GUID IID_IMarkupServices2                         = GUIDOF!IMarkupServices2;
const GUID IID_IMarkupTextFrags                         = GUIDOF!IMarkupTextFrags;
const GUID IID_INavigatorDoNotTrack                     = GUIDOF!INavigatorDoNotTrack;
const GUID IID_INavigatorGeolocation                    = GUIDOF!INavigatorGeolocation;
const GUID IID_IOmHistory                               = GUIDOF!IOmHistory;
const GUID IID_IOmNavigator                             = GUIDOF!IOmNavigator;
const GUID IID_IPrintManagerTemplatePrinter             = GUIDOF!IPrintManagerTemplatePrinter;
const GUID IID_IPrintManagerTemplatePrinter2            = GUIDOF!IPrintManagerTemplatePrinter2;
const GUID IID_IRangeException                          = GUIDOF!IRangeException;
const GUID IID_IRulesApplied                            = GUIDOF!IRulesApplied;
const GUID IID_IRulesAppliedCollection                  = GUIDOF!IRulesAppliedCollection;
const GUID IID_ISVGAElement                             = GUIDOF!ISVGAElement;
const GUID IID_ISVGAngle                                = GUIDOF!ISVGAngle;
const GUID IID_ISVGAnimatedAngle                        = GUIDOF!ISVGAnimatedAngle;
const GUID IID_ISVGAnimatedBoolean                      = GUIDOF!ISVGAnimatedBoolean;
const GUID IID_ISVGAnimatedEnumeration                  = GUIDOF!ISVGAnimatedEnumeration;
const GUID IID_ISVGAnimatedInteger                      = GUIDOF!ISVGAnimatedInteger;
const GUID IID_ISVGAnimatedLength                       = GUIDOF!ISVGAnimatedLength;
const GUID IID_ISVGAnimatedLengthList                   = GUIDOF!ISVGAnimatedLengthList;
const GUID IID_ISVGAnimatedNumber                       = GUIDOF!ISVGAnimatedNumber;
const GUID IID_ISVGAnimatedNumberList                   = GUIDOF!ISVGAnimatedNumberList;
const GUID IID_ISVGAnimatedPathData                     = GUIDOF!ISVGAnimatedPathData;
const GUID IID_ISVGAnimatedPoints                       = GUIDOF!ISVGAnimatedPoints;
const GUID IID_ISVGAnimatedPreserveAspectRatio          = GUIDOF!ISVGAnimatedPreserveAspectRatio;
const GUID IID_ISVGAnimatedRect                         = GUIDOF!ISVGAnimatedRect;
const GUID IID_ISVGAnimatedString                       = GUIDOF!ISVGAnimatedString;
const GUID IID_ISVGAnimatedTransformList                = GUIDOF!ISVGAnimatedTransformList;
const GUID IID_ISVGCircleElement                        = GUIDOF!ISVGCircleElement;
const GUID IID_ISVGClipPathElement                      = GUIDOF!ISVGClipPathElement;
const GUID IID_ISVGDefsElement                          = GUIDOF!ISVGDefsElement;
const GUID IID_ISVGDescElement                          = GUIDOF!ISVGDescElement;
const GUID IID_ISVGDocument                             = GUIDOF!ISVGDocument;
const GUID IID_ISVGElement                              = GUIDOF!ISVGElement;
const GUID IID_ISVGElementInstance                      = GUIDOF!ISVGElementInstance;
const GUID IID_ISVGElementInstanceList                  = GUIDOF!ISVGElementInstanceList;
const GUID IID_ISVGEllipseElement                       = GUIDOF!ISVGEllipseElement;
const GUID IID_ISVGException                            = GUIDOF!ISVGException;
const GUID IID_ISVGExternalResourcesRequired            = GUIDOF!ISVGExternalResourcesRequired;
const GUID IID_ISVGFitToViewBox                         = GUIDOF!ISVGFitToViewBox;
const GUID IID_ISVGGElement                             = GUIDOF!ISVGGElement;
const GUID IID_ISVGGradientElement                      = GUIDOF!ISVGGradientElement;
const GUID IID_ISVGImageElement                         = GUIDOF!ISVGImageElement;
const GUID IID_ISVGLangSpace                            = GUIDOF!ISVGLangSpace;
const GUID IID_ISVGLength                               = GUIDOF!ISVGLength;
const GUID IID_ISVGLengthList                           = GUIDOF!ISVGLengthList;
const GUID IID_ISVGLineElement                          = GUIDOF!ISVGLineElement;
const GUID IID_ISVGLinearGradientElement                = GUIDOF!ISVGLinearGradientElement;
const GUID IID_ISVGLocatable                            = GUIDOF!ISVGLocatable;
const GUID IID_ISVGMarkerElement                        = GUIDOF!ISVGMarkerElement;
const GUID IID_ISVGMaskElement                          = GUIDOF!ISVGMaskElement;
const GUID IID_ISVGMatrix                               = GUIDOF!ISVGMatrix;
const GUID IID_ISVGMetadataElement                      = GUIDOF!ISVGMetadataElement;
const GUID IID_ISVGNumber                               = GUIDOF!ISVGNumber;
const GUID IID_ISVGNumberList                           = GUIDOF!ISVGNumberList;
const GUID IID_ISVGPaint                                = GUIDOF!ISVGPaint;
const GUID IID_ISVGPathElement                          = GUIDOF!ISVGPathElement;
const GUID IID_ISVGPathSeg                              = GUIDOF!ISVGPathSeg;
const GUID IID_ISVGPathSegArcAbs                        = GUIDOF!ISVGPathSegArcAbs;
const GUID IID_ISVGPathSegArcRel                        = GUIDOF!ISVGPathSegArcRel;
const GUID IID_ISVGPathSegClosePath                     = GUIDOF!ISVGPathSegClosePath;
const GUID IID_ISVGPathSegCurvetoCubicAbs               = GUIDOF!ISVGPathSegCurvetoCubicAbs;
const GUID IID_ISVGPathSegCurvetoCubicRel               = GUIDOF!ISVGPathSegCurvetoCubicRel;
const GUID IID_ISVGPathSegCurvetoCubicSmoothAbs         = GUIDOF!ISVGPathSegCurvetoCubicSmoothAbs;
const GUID IID_ISVGPathSegCurvetoCubicSmoothRel         = GUIDOF!ISVGPathSegCurvetoCubicSmoothRel;
const GUID IID_ISVGPathSegCurvetoQuadraticAbs           = GUIDOF!ISVGPathSegCurvetoQuadraticAbs;
const GUID IID_ISVGPathSegCurvetoQuadraticRel           = GUIDOF!ISVGPathSegCurvetoQuadraticRel;
const GUID IID_ISVGPathSegCurvetoQuadraticSmoothAbs     = GUIDOF!ISVGPathSegCurvetoQuadraticSmoothAbs;
const GUID IID_ISVGPathSegCurvetoQuadraticSmoothRel     = GUIDOF!ISVGPathSegCurvetoQuadraticSmoothRel;
const GUID IID_ISVGPathSegLinetoAbs                     = GUIDOF!ISVGPathSegLinetoAbs;
const GUID IID_ISVGPathSegLinetoHorizontalAbs           = GUIDOF!ISVGPathSegLinetoHorizontalAbs;
const GUID IID_ISVGPathSegLinetoHorizontalRel           = GUIDOF!ISVGPathSegLinetoHorizontalRel;
const GUID IID_ISVGPathSegLinetoRel                     = GUIDOF!ISVGPathSegLinetoRel;
const GUID IID_ISVGPathSegLinetoVerticalAbs             = GUIDOF!ISVGPathSegLinetoVerticalAbs;
const GUID IID_ISVGPathSegLinetoVerticalRel             = GUIDOF!ISVGPathSegLinetoVerticalRel;
const GUID IID_ISVGPathSegList                          = GUIDOF!ISVGPathSegList;
const GUID IID_ISVGPathSegMovetoAbs                     = GUIDOF!ISVGPathSegMovetoAbs;
const GUID IID_ISVGPathSegMovetoRel                     = GUIDOF!ISVGPathSegMovetoRel;
const GUID IID_ISVGPatternElement                       = GUIDOF!ISVGPatternElement;
const GUID IID_ISVGPoint                                = GUIDOF!ISVGPoint;
const GUID IID_ISVGPointList                            = GUIDOF!ISVGPointList;
const GUID IID_ISVGPolygonElement                       = GUIDOF!ISVGPolygonElement;
const GUID IID_ISVGPolylineElement                      = GUIDOF!ISVGPolylineElement;
const GUID IID_ISVGPreserveAspectRatio                  = GUIDOF!ISVGPreserveAspectRatio;
const GUID IID_ISVGRadialGradientElement                = GUIDOF!ISVGRadialGradientElement;
const GUID IID_ISVGRect                                 = GUIDOF!ISVGRect;
const GUID IID_ISVGRectElement                          = GUIDOF!ISVGRectElement;
const GUID IID_ISVGSVGElement                           = GUIDOF!ISVGSVGElement;
const GUID IID_ISVGScriptElement                        = GUIDOF!ISVGScriptElement;
const GUID IID_ISVGStopElement                          = GUIDOF!ISVGStopElement;
const GUID IID_ISVGStringList                           = GUIDOF!ISVGStringList;
const GUID IID_ISVGStylable                             = GUIDOF!ISVGStylable;
const GUID IID_ISVGStyleElement                         = GUIDOF!ISVGStyleElement;
const GUID IID_ISVGSwitchElement                        = GUIDOF!ISVGSwitchElement;
const GUID IID_ISVGSymbolElement                        = GUIDOF!ISVGSymbolElement;
const GUID IID_ISVGTSpanElement                         = GUIDOF!ISVGTSpanElement;
const GUID IID_ISVGTests                                = GUIDOF!ISVGTests;
const GUID IID_ISVGTextContentElement                   = GUIDOF!ISVGTextContentElement;
const GUID IID_ISVGTextElement                          = GUIDOF!ISVGTextElement;
const GUID IID_ISVGTextPathElement                      = GUIDOF!ISVGTextPathElement;
const GUID IID_ISVGTextPositioningElement               = GUIDOF!ISVGTextPositioningElement;
const GUID IID_ISVGTitleElement                         = GUIDOF!ISVGTitleElement;
const GUID IID_ISVGTransform                            = GUIDOF!ISVGTransform;
const GUID IID_ISVGTransformList                        = GUIDOF!ISVGTransformList;
const GUID IID_ISVGTransformable                        = GUIDOF!ISVGTransformable;
const GUID IID_ISVGURIReference                         = GUIDOF!ISVGURIReference;
const GUID IID_ISVGUseElement                           = GUIDOF!ISVGUseElement;
const GUID IID_ISVGViewElement                          = GUIDOF!ISVGViewElement;
const GUID IID_ISVGViewSpec                             = GUIDOF!ISVGViewSpec;
const GUID IID_ISVGZoomAndPan                           = GUIDOF!ISVGZoomAndPan;
const GUID IID_ISVGZoomEvent                            = GUIDOF!ISVGZoomEvent;
const GUID IID_IScriptEventHandler                      = GUIDOF!IScriptEventHandler;
const GUID IID_IScriptEventHandlerSourceInfo            = GUIDOF!IScriptEventHandlerSourceInfo;
const GUID IID_ISecureUrlHost                           = GUIDOF!ISecureUrlHost;
const GUID IID_ISegment                                 = GUIDOF!ISegment;
const GUID IID_ISegmentList                             = GUIDOF!ISegmentList;
const GUID IID_ISegmentListIterator                     = GUIDOF!ISegmentListIterator;
const GUID IID_ISelectionServices                       = GUIDOF!ISelectionServices;
const GUID IID_ISelectionServicesListener               = GUIDOF!ISelectionServicesListener;
const GUID IID_ISequenceNumber                          = GUIDOF!ISequenceNumber;
const GUID IID_ISurfacePresenter                        = GUIDOF!ISurfacePresenter;
const GUID IID_ITemplatePrinter                         = GUIDOF!ITemplatePrinter;
const GUID IID_ITemplatePrinter2                        = GUIDOF!ITemplatePrinter2;
const GUID IID_ITemplatePrinter3                        = GUIDOF!ITemplatePrinter3;
const GUID IID_ITrackingProtection                      = GUIDOF!ITrackingProtection;
const GUID IID_IViewObjectPresentNotify                 = GUIDOF!IViewObjectPresentNotify;
const GUID IID_IViewObjectPresentNotifySite             = GUIDOF!IViewObjectPresentNotifySite;
const GUID IID_IViewObjectPresentSite                   = GUIDOF!IViewObjectPresentSite;
const GUID IID_IViewObjectPrint                         = GUIDOF!IViewObjectPrint;
const GUID IID_IWBScriptControl                         = GUIDOF!IWBScriptControl;
const GUID IID_IWPCBlockedUrls                          = GUIDOF!IWPCBlockedUrls;
const GUID IID_IWebBridge                               = GUIDOF!IWebBridge;
const GUID IID_IWebGeocoordinates                       = GUIDOF!IWebGeocoordinates;
const GUID IID_IWebGeolocation                          = GUIDOF!IWebGeolocation;
const GUID IID_IWebGeoposition                          = GUIDOF!IWebGeoposition;
const GUID IID_IWebGeopositionError                     = GUIDOF!IWebGeopositionError;
const GUID IID_IXMLGenericParse                         = GUIDOF!IXMLGenericParse;
const GUID IID_IXMLHttpRequestEventTarget               = GUIDOF!IXMLHttpRequestEventTarget;
