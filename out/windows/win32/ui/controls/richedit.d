// Written in the D programming language.

module windows.win32.ui.controls.richedit;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : BOOL, BSTR, CHAR, COLORREF, HANDLE, HGLOBAL,
                                         HRESULT, HWND, LPARAM, LRESULT, POINT,
                                         PSTR, PWSTR, RECT, RECTL, SIZE, WPARAM;
public import windows.win32.graphics.direct2d : ID2D1RenderTarget;
public import windows.win32.graphics.gdi : FONT_CHARSET, HBITMAP, HDC, HPALETTE, HRGN,
                                           SYS_COLOR_INDEX;
public import windows.win32.system.com : DVASPECT, DVTARGETDEVICE, IDataObject, IDispatch,
                                         IStream, IUnknown;
public import windows.win32.system.com.structuredstorage : IStorage;
public import windows.win32.system.ole : DROPEFFECT, IDropTarget, IOleClientSite,
                                         IOleInPlaceFrame, IOleInPlaceUIWindow,
                                         IOleObject, OLEINPLACEFRAMEINFO;
public import windows.win32.system.systemservices : MODIFIERKEYS_FLAGS, RECO_FLAGS;
public import windows.win32.system.variant : VARIANT;
public import windows.win32.ui.controls : NMHDR;
public import windows.win32.ui.input.ime : HIMC;
public import windows.win32.ui.windowsandmessaging : HCURSOR, HMENU, SCROLLBAR_CONSTANTS,
                                                     SCROLL_WINDOW_FLAGS;

extern(Windows) @nogc nothrow:


// Enums

alias CFM_MASK = uint;
enum : uint
{
    CFM_SUBSCRIPT     = 0x00030000,
    CFM_SUPERSCRIPT   = 0x00030000,
    CFM_EFFECTS       = 0x4000003f,
    CFM_ALL           = 0xf800003f,
    CFM_BOLD          = 0x00000001,
    CFM_CHARSET       = 0x08000000,
    CFM_COLOR         = 0x40000000,
    CFM_FACE          = 0x20000000,
    CFM_ITALIC        = 0x00000002,
    CFM_OFFSET        = 0x10000000,
    CFM_PROTECTED     = 0x00000010,
    CFM_SIZE          = 0x80000000,
    CFM_STRIKEOUT     = 0x00000008,
    CFM_UNDERLINE     = 0x00000004,
    CFM_LINK          = 0x00000020,
    CFM_SMALLCAPS     = 0x00000040,
    CFM_ALLCAPS       = 0x00000080,
    CFM_HIDDEN        = 0x00000100,
    CFM_OUTLINE       = 0x00000200,
    CFM_SHADOW        = 0x00000400,
    CFM_EMBOSS        = 0x00000800,
    CFM_IMPRINT       = 0x00001000,
    CFM_DISABLED      = 0x00002000,
    CFM_REVISED       = 0x00004000,
    CFM_REVAUTHOR     = 0x00008000,
    CFM_ANIMATION     = 0x00040000,
    CFM_STYLE         = 0x00080000,
    CFM_KERNING       = 0x00100000,
    CFM_SPACING       = 0x00200000,
    CFM_WEIGHT        = 0x00400000,
    CFM_UNDERLINETYPE = 0x00800000,
    CFM_COOKIE        = 0x01000000,
    CFM_LCID          = 0x02000000,
    CFM_BACKCOLOR     = 0x04000000,
    CFM_EFFECTS2      = 0x44037fff,
    CFM_ALL2          = 0xffffffff,
    CFM_FONTBOUND     = 0x00100000,
    CFM_LINKPROTECTED = 0x00800000,
    CFM_EXTENDED      = 0x02000000,
    CFM_MATHNOBUILDUP = 0x08000000,
    CFM_MATH          = 0x10000000,
    CFM_MATHORDINARY  = 0x20000000,
    CFM_ALLEFFECTS    = 0x7e137fff,
}
alias CFE_EFFECTS = uint;
enum : uint
{
    CFE_ALLCAPS       = 0x00000080,
    CFE_AUTOBACKCOLOR = 0x04000000,
    CFE_DISABLED      = 0x00002000,
    CFE_EMBOSS        = 0x00000800,
    CFE_HIDDEN        = 0x00000100,
    CFE_IMPRINT       = 0x00001000,
    CFE_OUTLINE       = 0x00000200,
    CFE_REVISED       = 0x00004000,
    CFE_SHADOW        = 0x00000400,
    CFE_SMALLCAPS     = 0x00000040,
    CFE_AUTOCOLOR     = 0x40000000,
    CFE_BOLD          = 0x00000001,
    CFE_ITALIC        = 0x00000002,
    CFE_STRIKEOUT     = 0x00000008,
    CFE_UNDERLINE     = 0x00000004,
    CFE_PROTECTED     = 0x00000010,
    CFE_LINK          = 0x00000020,
    CFE_SUBSCRIPT     = 0x00010000,
    CFE_SUPERSCRIPT   = 0x00020000,
    CFE_FONTBOUND     = 0x00100000,
    CFE_LINKPROTECTED = 0x00800000,
    CFE_EXTENDED      = 0x02000000,
    CFE_MATHNOBUILDUP = 0x08000000,
    CFE_MATH          = 0x10000000,
    CFE_MATHORDINARY  = 0x20000000,
}
alias PARAFORMAT_MASK = uint;
enum : uint
{
    PFM_STARTINDENT       = 0x00000001,
    PFM_RIGHTINDENT       = 0x00000002,
    PFM_OFFSET            = 0x00000004,
    PFM_ALIGNMENT         = 0x00000008,
    PFM_TABSTOPS          = 0x00000010,
    PFM_NUMBERING         = 0x00000020,
    PFM_OFFSETINDENT      = 0x80000000,
    PFM_SPACEBEFORE       = 0x00000040,
    PFM_SPACEAFTER        = 0x00000080,
    PFM_LINESPACING       = 0x00000100,
    PFM_STYLE             = 0x00000400,
    PFM_BORDER            = 0x00000800,
    PFM_SHADING           = 0x00001000,
    PFM_NUMBERINGSTYLE    = 0x00002000,
    PFM_NUMBERINGTAB      = 0x00004000,
    PFM_NUMBERINGSTART    = 0x00008000,
    PFM_RTLPARA           = 0x00010000,
    PFM_KEEP              = 0x00020000,
    PFM_KEEPNEXT          = 0x00040000,
    PFM_PAGEBREAKBEFORE   = 0x00080000,
    PFM_NOLINENUMBER      = 0x00100000,
    PFM_NOWIDOWCONTROL    = 0x00200000,
    PFM_DONOTHYPHEN       = 0x00400000,
    PFM_SIDEBYSIDE        = 0x00800000,
    PFM_COLLAPSED         = 0x01000000,
    PFM_OUTLINELEVEL      = 0x02000000,
    PFM_BOX               = 0x04000000,
    PFM_RESERVED2         = 0x08000000,
    PFM_TABLEROWDELIMITER = 0x10000000,
    PFM_TEXTWRAPPINGBREAK = 0x20000000,
    PFM_TABLE             = 0x40000000,
    PFM_ALL               = 0x8001003f,
    PFM_EFFECTS           = 0x50ff0000,
    PFM_ALL2              = 0xd0fffdff,
}
alias RICH_EDIT_GET_CONTEXT_MENU_SEL_TYPE = ushort;
enum : ushort
{
    SEL_EMPTY          = 0x0000,
    SEL_TEXT           = 0x0001,
    SEL_OBJECT         = 0x0002,
    SEL_MULTICHAR      = 0x0004,
    SEL_MULTIOBJECT    = 0x0008,
    GCM_RIGHTMOUSEDROP = 0x8000,
}
alias RICH_EDIT_GET_OBJECT_FLAGS = uint;
enum : uint
{
    REO_GETOBJ_POLEOBJ        = 0x00000001,
    REO_GETOBJ_PSTG           = 0x00000002,
    REO_GETOBJ_POLESITE       = 0x00000004,
    REO_GETOBJ_NO_INTERFACES  = 0x00000000,
    REO_GETOBJ_ALL_INTERFACES = 0x00000007,
}
alias PARAFORMAT_BORDERS = ushort;
enum : ushort
{
    PARAFORMAT_BORDERS_LEFT      = 0x0001,
    PARAFORMAT_BORDERS_RIGHT     = 0x0002,
    PARAFORMAT_BORDERS_TOP       = 0x0004,
    PARAFORMAT_BORDERS_BOTTOM    = 0x0008,
    PARAFORMAT_BORDERS_INSIDE    = 0x0010,
    PARAFORMAT_BORDERS_OUTSIDE   = 0x0020,
    PARAFORMAT_BORDERS_AUTOCOLOR = 0x0040,
}
alias PARAFORMAT_SHADING_STYLE = ushort;
enum : ushort
{
    PARAFORMAT_SHADING_STYLE_NONE            = 0x0000,
    PARAFORMAT_SHADING_STYLE_DARK_HORIZ      = 0x0001,
    PARAFORMAT_SHADING_STYLE_DARK_VERT       = 0x0002,
    PARAFORMAT_SHADING_STYLE_DARK_DOWN_DIAG  = 0x0003,
    PARAFORMAT_SHADING_STYLE_DARK_UP_DIAG    = 0x0004,
    PARAFORMAT_SHADING_STYLE_DARK_GRID       = 0x0005,
    PARAFORMAT_SHADING_STYLE_DARK_TRELLIS    = 0x0006,
    PARAFORMAT_SHADING_STYLE_LIGHT_HORZ      = 0x0007,
    PARAFORMAT_SHADING_STYLE_LIGHT_VERT      = 0x0008,
    PARAFORMAT_SHADING_STYLE_LIGHT_DOWN_DIAG = 0x0009,
    PARAFORMAT_SHADING_STYLE_LIGHT_UP_DIAG   = 0x000a,
    PARAFORMAT_SHADING_STYLE_LIGHT_GRID      = 0x000b,
    PARAFORMAT_SHADING_STYLE_LIGHT_TRELLIS   = 0x000c,
}
alias GETTEXTEX_FLAGS = uint;
enum : uint
{
    GT_DEFAULT      = 0x00000000,
    GT_NOHIDDENTEXT = 0x00000008,
    GT_RAWTEXT      = 0x00000004,
    GT_SELECTION    = 0x00000002,
    GT_USECRLF      = 0x00000001,
}
alias ENDCOMPOSITIONNOTIFY_CODE = uint;
enum : uint
{
    ECN_ENDCOMPOSITION = 0x00000001,
    ECN_NEWTEXT        = 0x00000002,
}
alias IMECOMPTEXT_FLAGS = uint;
enum : uint
{
    ICT_RESULTREADSTR = 0x00000001,
}
alias GETTEXTLENGTHEX_FLAGS = uint;
enum : uint
{
    GTL_DEFAULT  = 0x00000000,
    GTL_USECRLF  = 0x00000001,
    GTL_PRECISE  = 0x00000002,
    GTL_CLOSE    = 0x00000004,
    GTL_NUMCHARS = 0x00000008,
    GTL_NUMBYTES = 0x00000010,
}
alias REOBJECT_FLAGS = uint;
enum : uint
{
    REO_ALIGNTORIGHT    = 0x00000100,
    REO_BELOWBASELINE   = 0x00000002,
    REO_BLANK           = 0x00000010,
    REO_CANROTATE       = 0x00000080,
    REO_DONTNEEDPALETTE = 0x00000020,
    REO_DYNAMICSIZE     = 0x00000008,
    REO_GETMETAFILE     = 0x00400000,
    REO_HILITED         = 0x01000000,
    REO_INPLACEACTIVE   = 0x02000000,
    REO_INVERTEDSELECT  = 0x00000004,
    REO_LINK            = 0x80000000,
    REO_LINKAVAILABLE   = 0x00800000,
    REO_OPEN            = 0x04000000,
    REO_OWNERDRAWSELECT = 0x00000040,
    REO_RESIZABLE       = 0x00000001,
    REO_SELECTED        = 0x08000000,
    REO_STATIC          = 0x40000000,
    REO_USEASBACKGROUND = 0x00000400,
    REO_WRAPTEXTAROUND  = 0x00000200,
}
alias PARAFORMAT_NUMBERING_STYLE = ushort;
enum : ushort
{
    PFNS_PAREN     = 0x0000,
    PFNS_PARENS    = 0x0100,
    PFNS_PERIOD    = 0x0200,
    PFNS_PLAIN     = 0x0300,
    PFNS_NONUMBER  = 0x0400,
    PFNS_NEWNUMBER = 0x8000,
}
alias PARAFORMAT_ALIGNMENT = ushort;
enum : ushort
{
    PFA_LEFT             = 0x0001,
    PFA_RIGHT            = 0x0002,
    PFA_CENTER           = 0x0003,
    PFA_JUSTIFY          = 0x0004,
    PFA_FULL_INTERWORD   = 0x0004,
    PFA_FULL_NEWSPAPER   = 0x0005,
    PFA_FULL_INTERLETTER = 0x0006,
    PFA_FULL_SCALED      = 0x0007,
    PFA_FULL_GLYPHS      = 0x0008,
}
alias PARAFORMAT_NUMBERING = ushort;
enum : ushort
{
    PFN_BULLET   = 0x0001,
    PFN_ARABIC   = 0x0002,
    PFN_LCLETTER = 0x0003,
    PFN_UCLETTER = 0x0004,
    PFN_LCROMAN  = 0x0005,
    PFN_UCROMAN  = 0x0006,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ne-richedit-textmode))], [])
alias TEXTMODE = int;
enum : int
{
    TM_PLAINTEXT       = 0x00000001,
    TM_RICHTEXT        = 0x00000002,
    TM_SINGLELEVELUNDO = 0x00000004,
    TM_MULTILEVELUNDO  = 0x00000008,
    TM_SINGLECODEPAGE  = 0x00000010,
    TM_MULTICODEPAGE   = 0x00000020,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ne-richedit-undonameid))], [])
alias UNDONAMEID = int;
enum : int
{
    UID_UNKNOWN   = 0x00000000,
    UID_TYPING    = 0x00000001,
    UID_DELETE    = 0x00000002,
    UID_DRAGDROP  = 0x00000003,
    UID_CUT       = 0x00000004,
    UID_PASTE     = 0x00000005,
    UID_AUTOTABLE = 0x00000006,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ne-richedit-khyph))], [])
alias KHYPH = int;
enum : int
{
    khyphNil          = 0x00000000,
    khyphNormal       = 0x00000001,
    khyphAddBefore    = 0x00000002,
    khyphChangeBefore = 0x00000003,
    khyphDeleteBefore = 0x00000004,
    khyphChangeAfter  = 0x00000005,
    khyphDelAndChange = 0x00000006,
}
alias TXTBACKSTYLE = int;
enum : int
{
    TXTBACK_TRANSPARENT = 0x00000000,
    TXTBACK_OPAQUE      = 0x00000001,
}
alias TXTHITRESULT = int;
enum : int
{
    TXTHITRESULT_NOHIT       = 0x00000000,
    TXTHITRESULT_TRANSPARENT = 0x00000001,
    TXTHITRESULT_CLOSE       = 0x00000002,
    TXTHITRESULT_HIT         = 0x00000003,
}
alias TXTNATURALSIZE = int;
enum : int
{
    TXTNS_FITTOCONTENT2   = 0x00000000,
    TXTNS_FITTOCONTENT    = 0x00000001,
    TXTNS_ROUNDTOLINE     = 0x00000002,
    TXTNS_FITTOCONTENT3   = 0x00000003,
    TXTNS_FITTOCONTENTWSP = 0x00000004,
    TXTNS_INCLUDELASTLINE = 0x40000000,
    TXTNS_EMU             = 0x80000000,
}
alias TXTVIEW = int;
enum : int
{
    TXTVIEW_ACTIVE   = 0x00000000,
    TXTVIEW_INACTIVE = 0xffffffff,
}
alias CHANGETYPE = int;
enum : int
{
    CN_GENERIC     = 0x00000000,
    CN_TEXTCHANGED = 0x00000001,
    CN_NEWUNDO     = 0x00000002,
    CN_NEWREDO     = 0x00000004,
}
alias CARET_FLAGS = int;
enum : int
{
    CARET_NONE     = 0x00000000,
    CARET_CUSTOM   = 0x00000001,
    CARET_RTL      = 0x00000002,
    CARET_ITALIC   = 0x00000020,
    CARET_NULL     = 0x00000040,
    CARET_ROTATE90 = 0x00000080,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/ne-tom-tomconstants))], [])
alias tomConstants = int;
enum : int
{
    tomFalse                           = 0x00000000,
    tomTrue                            = 0xffffffff,
    tomUndefined                       = 0xff676981,
    tomToggle                          = 0xff676982,
    tomAutoColor                       = 0xff676983,
    tomDefault                         = 0xff676984,
    tomSuspend                         = 0xff676985,
    tomResume                          = 0xff676986,
    tomApplyNow                        = 0x00000000,
    tomApplyLater                      = 0x00000001,
    tomTrackParms                      = 0x00000002,
    tomCacheParms                      = 0x00000003,
    tomApplyTmp                        = 0x00000004,
    tomDisableSmartFont                = 0x00000008,
    tomEnableSmartFont                 = 0x00000009,
    tomUsePoints                       = 0x0000000a,
    tomUseTwips                        = 0x0000000b,
    tomBackward                        = 0xc0000001,
    tomForward                         = 0x3fffffff,
    tomMove                            = 0x00000000,
    tomExtend                          = 0x00000001,
    tomNoSelection                     = 0x00000000,
    tomSelectionIP                     = 0x00000001,
    tomSelectionNormal                 = 0x00000002,
    tomSelectionFrame                  = 0x00000003,
    tomSelectionColumn                 = 0x00000004,
    tomSelectionRow                    = 0x00000005,
    tomSelectionBlock                  = 0x00000006,
    tomSelectionInlineShape            = 0x00000007,
    tomSelectionShape                  = 0x00000008,
    tomSelStartActive                  = 0x00000001,
    tomSelAtEOL                        = 0x00000002,
    tomSelOvertype                     = 0x00000004,
    tomSelActive                       = 0x00000008,
    tomSelReplace                      = 0x00000010,
    tomEnd                             = 0x00000000,
    tomStart                           = 0x00000020,
    tomCollapseEnd                     = 0x00000000,
    tomCollapseStart                   = 0x00000001,
    tomClientCoord                     = 0x00000100,
    tomAllowOffClient                  = 0x00000200,
    tomTransform                       = 0x00000400,
    tomObjectArg                       = 0x00000800,
    tomAtEnd                           = 0x00001000,
    tomNone                            = 0x00000000,
    tomSingle                          = 0x00000001,
    tomWords                           = 0x00000002,
    tomDouble                          = 0x00000003,
    tomDotted                          = 0x00000004,
    tomDash                            = 0x00000005,
    tomDashDot                         = 0x00000006,
    tomDashDotDot                      = 0x00000007,
    tomWave                            = 0x00000008,
    tomThick                           = 0x00000009,
    tomHair                            = 0x0000000a,
    tomDoubleWave                      = 0x0000000b,
    tomHeavyWave                       = 0x0000000c,
    tomLongDash                        = 0x0000000d,
    tomThickDash                       = 0x0000000e,
    tomThickDashDot                    = 0x0000000f,
    tomThickDashDotDot                 = 0x00000010,
    tomThickDotted                     = 0x00000011,
    tomThickLongDash                   = 0x00000012,
    tomLineSpaceSingle                 = 0x00000000,
    tomLineSpace1pt5                   = 0x00000001,
    tomLineSpaceDouble                 = 0x00000002,
    tomLineSpaceAtLeast                = 0x00000003,
    tomLineSpaceExactly                = 0x00000004,
    tomLineSpaceMultiple               = 0x00000005,
    tomLineSpacePercent                = 0x00000006,
    tomAlignLeft                       = 0x00000000,
    tomAlignCenter                     = 0x00000001,
    tomAlignRight                      = 0x00000002,
    tomAlignJustify                    = 0x00000003,
    tomAlignDecimal                    = 0x00000003,
    tomAlignBar                        = 0x00000004,
    tomDefaultTab                      = 0x00000005,
    tomAlignInterWord                  = 0x00000003,
    tomAlignNewspaper                  = 0x00000004,
    tomAlignInterLetter                = 0x00000005,
    tomAlignScaled                     = 0x00000006,
    tomSpaces                          = 0x00000000,
    tomDots                            = 0x00000001,
    tomDashes                          = 0x00000002,
    tomLines                           = 0x00000003,
    tomThickLines                      = 0x00000004,
    tomEquals                          = 0x00000005,
    tomTabBack                         = 0xfffffffd,
    tomTabNext                         = 0xfffffffe,
    tomTabHere                         = 0xffffffff,
    tomListNone                        = 0x00000000,
    tomListBullet                      = 0x00000001,
    tomListNumberAsArabic              = 0x00000002,
    tomListNumberAsLCLetter            = 0x00000003,
    tomListNumberAsUCLetter            = 0x00000004,
    tomListNumberAsLCRoman             = 0x00000005,
    tomListNumberAsUCRoman             = 0x00000006,
    tomListNumberAsSequence            = 0x00000007,
    tomListNumberedCircle              = 0x00000008,
    tomListNumberedBlackCircleWingding = 0x00000009,
    tomListNumberedWhiteCircleWingding = 0x0000000a,
    tomListNumberedArabicWide          = 0x0000000b,
    tomListNumberedChS                 = 0x0000000c,
    tomListNumberedChT                 = 0x0000000d,
    tomListNumberedJpnChS              = 0x0000000e,
    tomListNumberedJpnKor              = 0x0000000f,
    tomListNumberedArabic1             = 0x00000010,
    tomListNumberedArabic2             = 0x00000011,
    tomListNumberedHebrew              = 0x00000012,
    tomListNumberedThaiAlpha           = 0x00000013,
    tomListNumberedThaiNum             = 0x00000014,
    tomListNumberedHindiAlpha          = 0x00000015,
    tomListNumberedHindiAlpha1         = 0x00000016,
    tomListNumberedHindiNum            = 0x00000017,
    tomListParentheses                 = 0x00010000,
    tomListPeriod                      = 0x00020000,
    tomListPlain                       = 0x00030000,
    tomListNoNumber                    = 0x00040000,
    tomListMinus                       = 0x00080000,
    tomIgnoreNumberStyle               = 0x01000000,
    tomParaStyleNormal                 = 0xffffffff,
    tomParaStyleHeading1               = 0xfffffffe,
    tomParaStyleHeading2               = 0xfffffffd,
    tomParaStyleHeading3               = 0xfffffffc,
    tomParaStyleHeading4               = 0xfffffffb,
    tomParaStyleHeading5               = 0xfffffffa,
    tomParaStyleHeading6               = 0xfffffff9,
    tomParaStyleHeading7               = 0xfffffff8,
    tomParaStyleHeading8               = 0xfffffff7,
    tomParaStyleHeading9               = 0xfffffff6,
    tomCharacter                       = 0x00000001,
    tomWord                            = 0x00000002,
    tomSentence                        = 0x00000003,
    tomParagraph                       = 0x00000004,
    tomLine                            = 0x00000005,
    tomStory                           = 0x00000006,
    tomScreen                          = 0x00000007,
    tomSection                         = 0x00000008,
    tomTableColumn                     = 0x00000009,
    tomColumn                          = 0x00000009,
    tomRow                             = 0x0000000a,
    tomWindow                          = 0x0000000b,
    tomCell                            = 0x0000000c,
    tomCharFormat                      = 0x0000000d,
    tomParaFormat                      = 0x0000000e,
    tomTable                           = 0x0000000f,
    tomObject                          = 0x00000010,
    tomPage                            = 0x00000011,
    tomHardParagraph                   = 0x00000012,
    tomCluster                         = 0x00000013,
    tomInlineObject                    = 0x00000014,
    tomInlineObjectArg                 = 0x00000015,
    tomLeafLine                        = 0x00000016,
    tomLayoutColumn                    = 0x00000017,
    tomProcessId                       = 0x40000001,
    tomMatchWord                       = 0x00000002,
    tomMatchCase                       = 0x00000004,
    tomMatchPattern                    = 0x00000008,
    tomUnknownStory                    = 0x00000000,
    tomMainTextStory                   = 0x00000001,
    tomFootnotesStory                  = 0x00000002,
    tomEndnotesStory                   = 0x00000003,
    tomCommentsStory                   = 0x00000004,
    tomTextFrameStory                  = 0x00000005,
    tomEvenPagesHeaderStory            = 0x00000006,
    tomPrimaryHeaderStory              = 0x00000007,
    tomEvenPagesFooterStory            = 0x00000008,
    tomPrimaryFooterStory              = 0x00000009,
    tomFirstPageHeaderStory            = 0x0000000a,
    tomFirstPageFooterStory            = 0x0000000b,
    tomScratchStory                    = 0x0000007f,
    tomFindStory                       = 0x00000080,
    tomReplaceStory                    = 0x00000081,
    tomStoryInactive                   = 0x00000000,
    tomStoryActiveDisplay              = 0x00000001,
    tomStoryActiveUI                   = 0x00000002,
    tomStoryActiveDisplayUI            = 0x00000003,
    tomNoAnimation                     = 0x00000000,
    tomLasVegasLights                  = 0x00000001,
    tomBlinkingBackground              = 0x00000002,
    tomSparkleText                     = 0x00000003,
    tomMarchingBlackAnts               = 0x00000004,
    tomMarchingRedAnts                 = 0x00000005,
    tomShimmer                         = 0x00000006,
    tomWipeDown                        = 0x00000007,
    tomWipeRight                       = 0x00000008,
    tomAnimationMax                    = 0x00000008,
    tomLowerCase                       = 0x00000000,
    tomUpperCase                       = 0x00000001,
    tomTitleCase                       = 0x00000002,
    tomSentenceCase                    = 0x00000004,
    tomToggleCase                      = 0x00000005,
    tomReadOnly                        = 0x00000100,
    tomShareDenyRead                   = 0x00000200,
    tomShareDenyWrite                  = 0x00000400,
    tomPasteFile                       = 0x00001000,
    tomCreateNew                       = 0x00000010,
    tomCreateAlways                    = 0x00000020,
    tomOpenExisting                    = 0x00000030,
    tomOpenAlways                      = 0x00000040,
    tomTruncateExisting                = 0x00000050,
    tomRTF                             = 0x00000001,
    tomText                            = 0x00000002,
    tomHTML                            = 0x00000003,
    tomWordDocument                    = 0x00000004,
    tomBold                            = 0x80000001,
    tomItalic                          = 0x80000002,
    tomUnderline                       = 0x80000004,
    tomStrikeout                       = 0x80000008,
    tomProtected                       = 0x80000010,
    tomLink                            = 0x80000020,
    tomSmallCaps                       = 0x80000040,
    tomAllCaps                         = 0x80000080,
    tomHidden                          = 0x80000100,
    tomOutline                         = 0x80000200,
    tomShadow                          = 0x80000400,
    tomEmboss                          = 0x80000800,
    tomImprint                         = 0x80001000,
    tomDisabled                        = 0x80002000,
    tomRevised                         = 0x80004000,
    tomSubscriptCF                     = 0x80010000,
    tomSuperscriptCF                   = 0x80020000,
    tomFontBound                       = 0x80100000,
    tomLinkProtected                   = 0x80800000,
    tomInlineObjectStart               = 0x81000000,
    tomExtendedChar                    = 0x82000000,
    tomAutoBackColor                   = 0x84000000,
    tomMathZoneNoBuildUp               = 0x88000000,
    tomMathZone                        = 0x90000000,
    tomMathZoneOrdinary                = 0xa0000000,
    tomAutoTextColor                   = 0xc0000000,
    tomMathZoneDisplay                 = 0x00040000,
    tomParaEffectRTL                   = 0x00000001,
    tomParaEffectKeep                  = 0x00000002,
    tomParaEffectKeepNext              = 0x00000004,
    tomParaEffectPageBreakBefore       = 0x00000008,
    tomParaEffectNoLineNumber          = 0x00000010,
    tomParaEffectNoWidowControl        = 0x00000020,
    tomParaEffectDoNotHyphen           = 0x00000040,
    tomParaEffectSideBySide            = 0x00000080,
    tomParaEffectCollapsed             = 0x00000100,
    tomParaEffectOutlineLevel          = 0x00000200,
    tomParaEffectBox                   = 0x00000400,
    tomParaEffectTableRowDelimiter     = 0x00001000,
    tomParaEffectTable                 = 0x00004000,
    tomModWidthPairs                   = 0x00000001,
    tomModWidthSpace                   = 0x00000002,
    tomAutoSpaceAlpha                  = 0x00000004,
    tomAutoSpaceNumeric                = 0x00000008,
    tomAutoSpaceParens                 = 0x00000010,
    tomEmbeddedFont                    = 0x00000020,
    tomDoublestrike                    = 0x00000040,
    tomOverlapping                     = 0x00000080,
    tomNormalCaret                     = 0x00000000,
    tomKoreanBlockCaret                = 0x00000001,
    tomNullCaret                       = 0x00000002,
    tomIncludeInset                    = 0x00000001,
    tomUnicodeBiDi                     = 0x00000001,
    tomMathCFCheck                     = 0x00000004,
    tomUnlink                          = 0x00000008,
    tomUnhide                          = 0x00000010,
    tomCheckTextLimit                  = 0x00000020,
    tomIgnoreCurrentFont               = 0x00000000,
    tomMatchCharRep                    = 0x00000001,
    tomMatchFontSignature              = 0x00000002,
    tomMatchAscii                      = 0x00000004,
    tomGetHeightOnly                   = 0x00000008,
    tomMatchMathFont                   = 0x00000010,
    tomCharset                         = 0x80000000,
    tomCharRepFromLcid                 = 0x40000000,
    tomAnsi                            = 0x00000000,
    tomEastEurope                      = 0x00000001,
    tomCyrillic                        = 0x00000002,
    tomGreek                           = 0x00000003,
    tomTurkish                         = 0x00000004,
    tomHebrew                          = 0x00000005,
    tomArabic                          = 0x00000006,
    tomBaltic                          = 0x00000007,
    tomVietnamese                      = 0x00000008,
    tomDefaultCharRep                  = 0x00000009,
    tomSymbol                          = 0x0000000a,
    tomThai                            = 0x0000000b,
    tomShiftJIS                        = 0x0000000c,
    tomGB2312                          = 0x0000000d,
    tomHangul                          = 0x0000000e,
    tomBIG5                            = 0x0000000f,
    tomPC437                           = 0x00000010,
    tomOEM                             = 0x00000011,
    tomMac                             = 0x00000012,
    tomArmenian                        = 0x00000013,
    tomSyriac                          = 0x00000014,
    tomThaana                          = 0x00000015,
    tomDevanagari                      = 0x00000016,
    tomBengali                         = 0x00000017,
    tomGurmukhi                        = 0x00000018,
    tomGujarati                        = 0x00000019,
    tomOriya                           = 0x0000001a,
    tomTamil                           = 0x0000001b,
    tomTelugu                          = 0x0000001c,
    tomKannada                         = 0x0000001d,
    tomMalayalam                       = 0x0000001e,
    tomSinhala                         = 0x0000001f,
    tomLao                             = 0x00000020,
    tomTibetan                         = 0x00000021,
    tomMyanmar                         = 0x00000022,
    tomGeorgian                        = 0x00000023,
    tomJamo                            = 0x00000024,
    tomEthiopic                        = 0x00000025,
    tomCherokee                        = 0x00000026,
    tomAboriginal                      = 0x00000027,
    tomOgham                           = 0x00000028,
    tomRunic                           = 0x00000029,
    tomKhmer                           = 0x0000002a,
    tomMongolian                       = 0x0000002b,
    tomBraille                         = 0x0000002c,
    tomYi                              = 0x0000002d,
    tomLimbu                           = 0x0000002e,
    tomTaiLe                           = 0x0000002f,
    tomNewTaiLue                       = 0x00000030,
    tomSylotiNagri                     = 0x00000031,
    tomKharoshthi                      = 0x00000032,
    tomKayahli                         = 0x00000033,
    tomUsymbol                         = 0x00000034,
    tomEmoji                           = 0x00000035,
    tomGlagolitic                      = 0x00000036,
    tomLisu                            = 0x00000037,
    tomVai                             = 0x00000038,
    tomNKo                             = 0x00000039,
    tomOsmanya                         = 0x0000003a,
    tomPhagsPa                         = 0x0000003b,
    tomGothic                          = 0x0000003c,
    tomDeseret                         = 0x0000003d,
    tomTifinagh                        = 0x0000003e,
    tomCharRepMax                      = 0x0000003f,
    tomRE10Mode                        = 0x00000001,
    tomUseAtFont                       = 0x00000002,
    tomTextFlowMask                    = 0x0000000c,
    tomTextFlowES                      = 0x00000000,
    tomTextFlowSW                      = 0x00000004,
    tomTextFlowWN                      = 0x00000008,
    tomTextFlowNE                      = 0x0000000c,
    tomNoIME                           = 0x00080000,
    tomSelfIME                         = 0x00040000,
    tomNoUpScroll                      = 0x00010000,
    tomNoVpScroll                      = 0x00040000,
    tomNoLink                          = 0x00000000,
    tomClientLink                      = 0x00000001,
    tomFriendlyLinkName                = 0x00000002,
    tomFriendlyLinkAddress             = 0x00000003,
    tomAutoLinkURL                     = 0x00000004,
    tomAutoLinkEmail                   = 0x00000005,
    tomAutoLinkPhone                   = 0x00000006,
    tomAutoLinkPath                    = 0x00000007,
    tomCompressNone                    = 0x00000000,
    tomCompressPunctuation             = 0x00000001,
    tomCompressPunctuationAndKana      = 0x00000002,
    tomCompressMax                     = 0x00000002,
    tomUnderlinePositionAuto           = 0x00000000,
    tomUnderlinePositionBelow          = 0x00000001,
    tomUnderlinePositionAbove          = 0x00000002,
    tomUnderlinePositionMax            = 0x00000002,
    tomFontAlignmentAuto               = 0x00000000,
    tomFontAlignmentTop                = 0x00000001,
    tomFontAlignmentBaseline           = 0x00000002,
    tomFontAlignmentBottom             = 0x00000003,
    tomFontAlignmentCenter             = 0x00000004,
    tomFontAlignmentMax                = 0x00000004,
    tomRubyBelow                       = 0x00000080,
    tomRubyAlignCenter                 = 0x00000000,
    tomRubyAlign010                    = 0x00000001,
    tomRubyAlign121                    = 0x00000002,
    tomRubyAlignLeft                   = 0x00000003,
    tomRubyAlignRight                  = 0x00000004,
    tomLimitsDefault                   = 0x00000000,
    tomLimitsUnderOver                 = 0x00000001,
    tomLimitsSubSup                    = 0x00000002,
    tomUpperLimitAsSuperScript         = 0x00000003,
    tomLimitsOpposite                  = 0x00000004,
    tomShowLLimPlaceHldr               = 0x00000008,
    tomShowULimPlaceHldr               = 0x00000010,
    tomDontGrowWithContent             = 0x00000040,
    tomGrowWithContent                 = 0x00000080,
    tomSubSupAlign                     = 0x00000001,
    tomLimitAlignMask                  = 0x00000003,
    tomLimitAlignCenter                = 0x00000000,
    tomLimitAlignLeft                  = 0x00000001,
    tomLimitAlignRight                 = 0x00000002,
    tomShowDegPlaceHldr                = 0x00000008,
    tomAlignDefault                    = 0x00000000,
    tomAlignMatchAscentDescent         = 0x00000002,
    tomMathVariant                     = 0x00000020,
    tomStyleDefault                    = 0x00000000,
    tomStyleScriptScriptCramped        = 0x00000001,
    tomStyleScriptScript               = 0x00000002,
    tomStyleScriptCramped              = 0x00000003,
    tomStyleScript                     = 0x00000004,
    tomStyleTextCramped                = 0x00000005,
    tomStyleText                       = 0x00000006,
    tomStyleDisplayCramped             = 0x00000007,
    tomStyleDisplay                    = 0x00000008,
    tomMathRelSize                     = 0x00000040,
    tomDecDecSize                      = 0x000000fe,
    tomDecSize                         = 0x000000ff,
    tomIncSize                         = 0x00000041,
    tomIncIncSize                      = 0x00000042,
    tomGravityUI                       = 0x00000000,
    tomGravityBack                     = 0x00000001,
    tomGravityFore                     = 0x00000002,
    tomGravityIn                       = 0x00000003,
    tomGravityOut                      = 0x00000004,
    tomGravityBackward                 = 0x20000000,
    tomGravityForward                  = 0x40000000,
    tomAdjustCRLF                      = 0x00000001,
    tomUseCRLF                         = 0x00000002,
    tomTextize                         = 0x00000004,
    tomAllowFinalEOP                   = 0x00000008,
    tomFoldMathAlpha                   = 0x00000010,
    tomNoHidden                        = 0x00000020,
    tomIncludeNumbering                = 0x00000040,
    tomTranslateTableCell              = 0x00000080,
    tomNoMathZoneBrackets              = 0x00000100,
    tomConvertMathChar                 = 0x00000200,
    tomNoUCGreekItalic                 = 0x00000400,
    tomAllowMathBold                   = 0x00000800,
    tomLanguageTag                     = 0x00001000,
    tomConvertRTF                      = 0x00002000,
    tomApplyRtfDocProps                = 0x00004000,
    tomPhantomShow                     = 0x00000001,
    tomPhantomZeroWidth                = 0x00000002,
    tomPhantomZeroAscent               = 0x00000004,
    tomPhantomZeroDescent              = 0x00000008,
    tomPhantomTransparent              = 0x00000010,
    tomPhantomASmash                   = 0x00000005,
    tomPhantomDSmash                   = 0x00000009,
    tomPhantomHSmash                   = 0x00000003,
    tomPhantomSmash                    = 0x0000000d,
    tomPhantomHorz                     = 0x0000000c,
    tomPhantomVert                     = 0x00000002,
    tomBoxHideTop                      = 0x00000001,
    tomBoxHideBottom                   = 0x00000002,
    tomBoxHideLeft                     = 0x00000004,
    tomBoxHideRight                    = 0x00000008,
    tomBoxStrikeH                      = 0x00000010,
    tomBoxStrikeV                      = 0x00000020,
    tomBoxStrikeTLBR                   = 0x00000040,
    tomBoxStrikeBLTR                   = 0x00000080,
    tomBoxAlignCenter                  = 0x00000001,
    tomSpaceMask                       = 0x0000001c,
    tomSpaceDefault                    = 0x00000000,
    tomSpaceUnary                      = 0x00000004,
    tomSpaceBinary                     = 0x00000008,
    tomSpaceRelational                 = 0x0000000c,
    tomSpaceSkip                       = 0x00000010,
    tomSpaceOrd                        = 0x00000014,
    tomSpaceDifferential               = 0x00000018,
    tomSizeText                        = 0x00000020,
    tomSizeScript                      = 0x00000040,
    tomSizeScriptScript                = 0x00000060,
    tomNoBreak                         = 0x00000080,
    tomTransparentForPositioning       = 0x00000100,
    tomTransparentForSpacing           = 0x00000200,
    tomStretchCharBelow                = 0x00000000,
    tomStretchCharAbove                = 0x00000001,
    tomStretchBaseBelow                = 0x00000002,
    tomStretchBaseAbove                = 0x00000003,
    tomMatrixAlignMask                 = 0x00000003,
    tomMatrixAlignCenter               = 0x00000000,
    tomMatrixAlignTopRow               = 0x00000001,
    tomMatrixAlignBottomRow            = 0x00000003,
    tomShowMatPlaceHldr                = 0x00000008,
    tomEqArrayLayoutWidth              = 0x00000001,
    tomEqArrayAlignMask                = 0x0000000c,
    tomEqArrayAlignCenter              = 0x00000000,
    tomEqArrayAlignTopRow              = 0x00000004,
    tomEqArrayAlignBottomRow           = 0x0000000c,
    tomMathManualBreakMask             = 0x0000007f,
    tomMathBreakLeft                   = 0x0000007d,
    tomMathBreakCenter                 = 0x0000007e,
    tomMathBreakRight                  = 0x0000007f,
    tomMathEqAlign                     = 0x00000080,
    tomMathArgShadingStart             = 0x00000251,
    tomMathArgShadingEnd               = 0x00000252,
    tomMathObjShadingStart             = 0x00000253,
    tomMathObjShadingEnd               = 0x00000254,
    tomFunctionTypeNone                = 0x00000000,
    tomFunctionTypeTakesArg            = 0x00000001,
    tomFunctionTypeTakesLim            = 0x00000002,
    tomFunctionTypeTakesLim2           = 0x00000003,
    tomFunctionTypeIsLim               = 0x00000004,
    tomMathParaAlignDefault            = 0x00000000,
    tomMathParaAlignCenterGroup        = 0x00000001,
    tomMathParaAlignCenter             = 0x00000002,
    tomMathParaAlignLeft               = 0x00000003,
    tomMathParaAlignRight              = 0x00000004,
    tomMathDispAlignMask               = 0x00000003,
    tomMathDispAlignCenterGroup        = 0x00000000,
    tomMathDispAlignCenter             = 0x00000001,
    tomMathDispAlignLeft               = 0x00000002,
    tomMathDispAlignRight              = 0x00000003,
    tomMathDispIntUnderOver            = 0x00000004,
    tomMathDispFracTeX                 = 0x00000008,
    tomMathDispNaryGrow                = 0x00000010,
    tomMathDocEmptyArgMask             = 0x00000060,
    tomMathDocEmptyArgAuto             = 0x00000000,
    tomMathDocEmptyArgAlways           = 0x00000020,
    tomMathDocEmptyArgNever            = 0x00000040,
    tomMathDocSbSpOpUnchanged          = 0x00000080,
    tomMathDocDiffMask                 = 0x00000300,
    tomMathDocDiffDefault              = 0x00000000,
    tomMathDocDiffUpright              = 0x00000100,
    tomMathDocDiffItalic               = 0x00000200,
    tomMathDocDiffOpenItalic           = 0x00000300,
    tomMathDispNarySubSup              = 0x00000400,
    tomMathDispDef                     = 0x00000800,
    tomMathEnableRtl                   = 0x00001000,
    tomMathBrkBinMask                  = 0x00030000,
    tomMathBrkBinBefore                = 0x00000000,
    tomMathBrkBinAfter                 = 0x00010000,
    tomMathBrkBinDup                   = 0x00020000,
    tomMathBrkBinSubMask               = 0x000c0000,
    tomMathBrkBinSubMM                 = 0x00000000,
    tomMathBrkBinSubPM                 = 0x00040000,
    tomMathBrkBinSubMP                 = 0x00080000,
    tomSelRange                        = 0x00000255,
    tomHstring                         = 0x00000254,
    tomFontPropTeXStyle                = 0x0000033c,
    tomFontPropAlign                   = 0x0000033d,
    tomFontStretch                     = 0x0000033e,
    tomFontStyle                       = 0x0000033f,
    tomFontStyleUpright                = 0x00000000,
    tomFontStyleOblique                = 0x00000001,
    tomFontStyleItalic                 = 0x00000002,
    tomFontStretchDefault              = 0x00000000,
    tomFontStretchUltraCondensed       = 0x00000001,
    tomFontStretchExtraCondensed       = 0x00000002,
    tomFontStretchCondensed            = 0x00000003,
    tomFontStretchSemiCondensed        = 0x00000004,
    tomFontStretchNormal               = 0x00000005,
    tomFontStretchSemiExpanded         = 0x00000006,
    tomFontStretchExpanded             = 0x00000007,
    tomFontStretchExtraExpanded        = 0x00000008,
    tomFontStretchUltraExpanded        = 0x00000009,
    tomFontWeightDefault               = 0x00000000,
    tomFontWeightThin                  = 0x00000064,
    tomFontWeightExtraLight            = 0x000000c8,
    tomFontWeightLight                 = 0x0000012c,
    tomFontWeightNormal                = 0x00000190,
    tomFontWeightRegular               = 0x00000190,
    tomFontWeightMedium                = 0x000001f4,
    tomFontWeightSemiBold              = 0x00000258,
    tomFontWeightBold                  = 0x000002bc,
    tomFontWeightExtraBold             = 0x00000320,
    tomFontWeightBlack                 = 0x00000384,
    tomFontWeightHeavy                 = 0x00000384,
    tomFontWeightExtraBlack            = 0x000003b6,
    tomParaPropMathAlign               = 0x00000437,
    tomDocMathBuild                    = 0x00000080,
    tomMathLMargin                     = 0x00000081,
    tomMathRMargin                     = 0x00000082,
    tomMathWrapIndent                  = 0x00000083,
    tomMathWrapRight                   = 0x00000084,
    tomMathPostSpace                   = 0x00000086,
    tomMathPreSpace                    = 0x00000085,
    tomMathInterSpace                  = 0x00000087,
    tomMathIntraSpace                  = 0x00000088,
    tomCanCopy                         = 0x00000089,
    tomCanRedo                         = 0x0000008a,
    tomCanUndo                         = 0x0000008b,
    tomUndoLimit                       = 0x0000008c,
    tomDocAutoLink                     = 0x0000008d,
    tomEllipsisMode                    = 0x0000008e,
    tomEllipsisState                   = 0x0000008f,
    tomEllipsisNone                    = 0x00000000,
    tomEllipsisEnd                     = 0x00000001,
    tomEllipsisWord                    = 0x00000003,
    tomEllipsisPresent                 = 0x00000001,
    tomVTopCell                        = 0x00000001,
    tomVLowCell                        = 0x00000002,
    tomHStartCell                      = 0x00000004,
    tomHContCell                       = 0x00000008,
    tomRowUpdate                       = 0x00000001,
    tomRowApplyDefault                 = 0x00000000,
    tomCellStructureChangeOnly         = 0x00000001,
    tomRowHeightActual                 = 0x0000080b,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/ne-tom-objecttype))], [])
alias OBJECTTYPE = int;
enum : int
{
    tomSimpleText       = 0x00000000,
    tomRuby             = 0x00000001,
    tomHorzVert         = 0x00000002,
    tomWarichu          = 0x00000003,
    tomEq               = 0x00000009,
    tomMath             = 0x0000000a,
    tomAccent           = 0x0000000a,
    tomBox              = 0x0000000b,
    tomBoxedFormula     = 0x0000000c,
    tomBrackets         = 0x0000000d,
    tomBracketsWithSeps = 0x0000000e,
    tomEquationArray    = 0x0000000f,
    tomFraction         = 0x00000010,
    tomFunctionApply    = 0x00000011,
    tomLeftSubSup       = 0x00000012,
    tomLowerLimit       = 0x00000013,
    tomMatrix           = 0x00000014,
    tomNary             = 0x00000015,
    tomOpChar           = 0x00000016,
    tomOverbar          = 0x00000017,
    tomPhantom          = 0x00000018,
    tomRadical          = 0x00000019,
    tomSlashedFraction  = 0x0000001a,
    tomStack            = 0x0000001b,
    tomStretchStack     = 0x0000001c,
    tomSubscript        = 0x0000001d,
    tomSubSup           = 0x0000001e,
    tomSuperscript      = 0x0000001f,
    tomUnderbar         = 0x00000020,
    tomUpperLimit       = 0x00000021,
    tomObjectMax        = 0x00000021,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/ne-tom-mancode))], [])
alias MANCODE = int;
enum : int
{
    MBOLD   = 0x00000010,
    MITAL   = 0x00000020,
    MGREEK  = 0x00000040,
    MROMN   = 0x00000000,
    MSCRP   = 0x00000001,
    MFRAK   = 0x00000002,
    MOPEN   = 0x00000003,
    MSANS   = 0x00000004,
    MMONO   = 0x00000005,
    MMATH   = 0x00000006,
    MISOL   = 0x00000007,
    MINIT   = 0x00000008,
    MTAIL   = 0x00000009,
    MSTRCH  = 0x0000000a,
    MLOOP   = 0x0000000b,
    MOPENA  = 0x0000000c,
}

// Constants


enum uint cchTextLimitDefault = 0x00007fff;
enum const(wchar)* MSFTEDIT_CLASS = "RICHEDIT50W";

enum : /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)*
{
    CERICHEDIT_CLASSA = "RichEditCEA",
    CERICHEDIT_CLASSW = "RichEditCEW",
}

enum : /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)*
{
    RICHEDIT_CLASSA   = "RichEdit20A",
    RICHEDIT_CLASS10A = "RICHEDIT",
    RICHEDIT_CLASSW   = "RichEdit20W",
    RICHEDIT_CLASS    = "RichEdit20W",
}

enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-canpaste))], [])*/uint EM_CANPASTE = 0x00000432;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-displayband))], [])*/uint EM_DISPLAYBAND = 0x00000433;

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-exgetsel))], [])*/uint
{
    EM_EXGETSEL       = 0x00000434,
    EM_EXLIMITTEXT    = 0x00000435,
    EM_EXLINEFROMCHAR = 0x00000436,
}

enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-exsetsel))], [])*/uint EM_EXSETSEL = 0x00000437;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-findtext))], [])*/uint EM_FINDTEXT = 0x00000438;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-formatrange))], [])*/uint EM_FORMATRANGE = 0x00000439;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-getcharformat))], [])*/uint EM_GETCHARFORMAT = 0x0000043a;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-geteventmask))], [])*/uint EM_GETEVENTMASK = 0x0000043b;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-getoleinterface))], [])*/uint EM_GETOLEINTERFACE = 0x0000043c;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-getparaformat))], [])*/uint EM_GETPARAFORMAT = 0x0000043d;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-getseltext))], [])*/uint EM_GETSELTEXT = 0x0000043e;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-hideselection))], [])*/uint EM_HIDESELECTION = 0x0000043f;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-pastespecial))], [])*/uint EM_PASTESPECIAL = 0x00000440;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-requestresize))], [])*/uint EM_REQUESTRESIZE = 0x00000441;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-selectiontype))], [])*/uint EM_SELECTIONTYPE = 0x00000442;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-setbkgndcolor))], [])*/uint EM_SETBKGNDCOLOR = 0x00000443;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-setcharformat))], [])*/uint EM_SETCHARFORMAT = 0x00000444;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-seteventmask))], [])*/uint EM_SETEVENTMASK = 0x00000445;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-setolecallback))], [])*/uint EM_SETOLECALLBACK = 0x00000446;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-setparaformat))], [])*/uint EM_SETPARAFORMAT = 0x00000447;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-settargetdevice))], [])*/uint EM_SETTARGETDEVICE = 0x00000448;

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-streamin))], [])*/uint
{
    EM_STREAMIN  = 0x00000449,
    EM_STREAMOUT = 0x0000044a,
}

enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-gettextrange))], [])*/uint EM_GETTEXTRANGE = 0x0000044b;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-findwordbreak))], [])*/uint EM_FINDWORDBREAK = 0x0000044c;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-setoptions))], [])*/uint EM_SETOPTIONS = 0x0000044d;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-getoptions))], [])*/uint EM_GETOPTIONS = 0x0000044e;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-findtextex))], [])*/uint EM_FINDTEXTEX = 0x0000044f;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-getwordbreakprocex))], [])*/uint EM_GETWORDBREAKPROCEX = 0x00000450;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-setwordbreakprocex))], [])*/uint EM_SETWORDBREAKPROCEX = 0x00000451;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-setundolimit))], [])*/uint EM_SETUNDOLIMIT = 0x00000452;

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-redo))], [])*/uint
{
    EM_REDO    = 0x00000454,
    EM_CANREDO = 0x00000455,
}

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-getundoname))], [])*/uint
{
    EM_GETUNDONAME = 0x00000456,
    EM_GETREDONAME = 0x00000457,
}

enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-stopgrouptyping))], [])*/uint EM_STOPGROUPTYPING = 0x00000458;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-settextmode))], [])*/uint EM_SETTEXTMODE = 0x00000459;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-gettextmode))], [])*/uint EM_GETTEXTMODE = 0x0000045a;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-autourldetect))], [])*/uint EM_AUTOURLDETECT = 0x0000045b;

enum : uint
{
    AURL_ENABLEURL          = 0x00000001,
    AURL_ENABLEEMAILADDR    = 0x00000002,
    AURL_ENABLETELNO        = 0x00000004,
    AURL_ENABLEEAURLS       = 0x00000008,
    AURL_ENABLEDRIVELETTERS = 0x00000010,
}

enum uint AURL_DISABLEMIXEDLGC = 0x00000020;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-getautourldetect))], [])*/uint EM_GETAUTOURLDETECT = 0x0000045c;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-setpalette))], [])*/uint EM_SETPALETTE = 0x0000045d;

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-gettextex))], [])*/uint
{
    EM_GETTEXTEX       = 0x0000045e,
    EM_GETTEXTLENGTHEX = 0x0000045f,
}

enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-showscrollbar))], [])*/uint EM_SHOWSCROLLBAR = 0x00000460;

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-settextex))], [])*/uint
{
    EM_SETTEXTEX      = 0x00000461,
    EM_SETPUNCTUATION = 0x00000464,
}

enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-getpunctuation))], [])*/uint EM_GETPUNCTUATION = 0x00000465;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-setwordwrapmode))], [])*/uint EM_SETWORDWRAPMODE = 0x00000466;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-getwordwrapmode))], [])*/uint EM_GETWORDWRAPMODE = 0x00000467;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-setimecolor))], [])*/uint EM_SETIMECOLOR = 0x00000468;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-getimecolor))], [])*/uint EM_GETIMECOLOR = 0x00000469;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-setimeoptions))], [])*/uint EM_SETIMEOPTIONS = 0x0000046a;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-getimeoptions))], [])*/uint EM_GETIMEOPTIONS = 0x0000046b;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-convposition))], [])*/uint EM_CONVPOSITION = 0x0000046c;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-setlangoptions))], [])*/uint EM_SETLANGOPTIONS = 0x00000478;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-getlangoptions))], [])*/uint EM_GETLANGOPTIONS = 0x00000479;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-getimecompmode))], [])*/uint EM_GETIMECOMPMODE = 0x0000047a;

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-findtextw))], [])*/uint
{
    EM_FINDTEXTW   = 0x0000047b,
    EM_FINDTEXTEXW = 0x0000047c,
}

enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-reconversion))], [])*/uint EM_RECONVERSION = 0x0000047d;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-setimemodebias))], [])*/uint EM_SETIMEMODEBIAS = 0x0000047e;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-getimemodebias))], [])*/uint EM_GETIMEMODEBIAS = 0x0000047f;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-setbidioptions))], [])*/uint EM_SETBIDIOPTIONS = 0x000004c8;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-getbidioptions))], [])*/uint EM_GETBIDIOPTIONS = 0x000004c9;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-settypographyoptions))], [])*/uint EM_SETTYPOGRAPHYOPTIONS = 0x000004ca;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-gettypographyoptions))], [])*/uint EM_GETTYPOGRAPHYOPTIONS = 0x000004cb;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-seteditstyle))], [])*/uint EM_SETEDITSTYLE = 0x000004cc;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-geteditstyle))], [])*/uint EM_GETEDITSTYLE = 0x000004cd;
enum uint SES_EMULATESYSEDIT = 0x00000001;
enum uint SES_BEEPONMAXTEXT = 0x00000002;
enum uint SES_EXTENDBACKCOLOR = 0x00000004;
enum uint SES_MAPCPS = 0x00000008;
enum uint SES_HYPERLINKTOOLTIPS = 0x00000008;
enum uint SES_EMULATE10 = 0x00000010;
enum uint SES_DEFAULTLATINLIGA = 0x00000010;
enum uint SES_USECRLF = 0x00000020;
enum uint SES_NOFOCUSLINKNOTIFY = 0x00000020;
enum uint SES_USEAIMM = 0x00000040;

enum : uint
{
    SES_NOIME      = 0x00000080,
    SES_ALLOWBEEPS = 0x00000100,
}

enum uint SES_UPPERCASE = 0x00000200;
enum uint SES_LOWERCASE = 0x00000400;
enum uint SES_NOINPUTSEQUENCECHK = 0x00000800;

enum : uint
{
    SES_BIDI              = 0x00001000,
    SES_SCROLLONKILLFOCUS = 0x00002000,
}

enum uint SES_XLTCRCRLFTOCR = 0x00004000;
enum uint SES_DRAFTMODE = 0x00008000;
enum uint SES_USECTF = 0x00010000;
enum uint SES_HIDEGRIDLINES = 0x00020000;
enum uint SES_USEATFONT = 0x00040000;
enum uint SES_CUSTOMLOOK = 0x00080000;
enum uint SES_LBSCROLLNOTIFY = 0x00100000;

enum : uint
{
    SES_CTFALLOWEMBED    = 0x00200000,
    SES_CTFALLOWSMARTTAG = 0x00400000,
    SES_CTFALLOWPROOFING = 0x00800000,
}

enum uint SES_LOGICALCARET = 0x01000000;
enum uint SES_WORDDRAGDROP = 0x02000000;
enum uint SES_SMARTDRAGDROP = 0x04000000;
enum uint SES_MULTISELECT = 0x08000000;
enum uint SES_CTFNOLOCK = 0x10000000;
enum uint SES_NOEALINEHEIGHTADJUST = 0x20000000;
enum uint SES_MAX = 0x20000000;

enum : uint
{
    IMF_AUTOKEYBOARD = 0x00000001,
    IMF_AUTOFONT     = 0x00000002,
}

enum uint IMF_IMECANCELCOMPLETE = 0x00000004;
enum uint IMF_IMEALWAYSSENDNOTIFY = 0x00000008;
enum uint IMF_AUTOFONTSIZEADJUST = 0x00000010;
enum uint IMF_UIFONTS = 0x00000020;
enum uint IMF_NOIMPLICITLANG = 0x00000040;
enum uint IMF_DUALFONT = 0x00000080;
enum uint IMF_NOKBDLIDFIXUP = 0x00000200;
enum uint IMF_NORTFFONTSUBSTITUTE = 0x00000400;
enum uint IMF_SPELLCHECKING = 0x00000800;
enum uint IMF_TKBPREDICTION = 0x00001000;
enum uint IMF_IMEUIINTEGRATION = 0x00002000;
enum uint ICM_NOTOPEN = 0x00000000;

enum : uint
{
    ICM_LEVEL3     = 0x00000001,
    ICM_LEVEL2     = 0x00000002,
    ICM_LEVEL2_5   = 0x00000003,
    ICM_LEVEL2_SUI = 0x00000004,
}

enum uint ICM_CTF = 0x00000005;
enum uint TO_ADVANCEDTYPOGRAPHY = 0x00000001;
enum uint TO_SIMPLELINEBREAK = 0x00000002;
enum uint TO_DISABLECUSTOMTEXTOUT = 0x00000004;
enum uint TO_ADVANCEDLAYOUT = 0x00000008;
enum uint EM_OUTLINE = 0x000004dc;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-getscrollpos))], [])*/uint EM_GETSCROLLPOS = 0x000004dd;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-setscrollpos))], [])*/uint EM_SETSCROLLPOS = 0x000004de;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-setfontsize))], [])*/uint EM_SETFONTSIZE = 0x000004df;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-getzoom))], [])*/uint EM_GETZOOM = 0x000004e0;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-setzoom))], [])*/uint EM_SETZOOM = 0x000004e1;
enum uint EM_GETVIEWKIND = 0x000004e2;
enum uint EM_SETVIEWKIND = 0x000004e3;
enum uint EM_GETPAGE = 0x000004e4;
enum uint EM_SETPAGE = 0x000004e5;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-gethyphenateinfo))], [])*/uint EM_GETHYPHENATEINFO = 0x000004e6;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-sethyphenateinfo))], [])*/uint EM_SETHYPHENATEINFO = 0x000004e7;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-getpagerotate))], [])*/uint EM_GETPAGEROTATE = 0x000004eb;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-setpagerotate))], [])*/uint EM_SETPAGEROTATE = 0x000004ec;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-getctfmodebias))], [])*/uint EM_GETCTFMODEBIAS = 0x000004ed;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-setctfmodebias))], [])*/uint EM_SETCTFMODEBIAS = 0x000004ee;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-getctfopenstatus))], [])*/uint EM_GETCTFOPENSTATUS = 0x000004f0;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-setctfopenstatus))], [])*/uint EM_SETCTFOPENSTATUS = 0x000004f1;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-getimecomptext))], [])*/uint EM_GETIMECOMPTEXT = 0x000004f2;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-isime))], [])*/uint EM_ISIME = 0x000004f3;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-getimeproperty))], [])*/uint EM_GETIMEPROPERTY = 0x000004f4;
enum uint EM_GETQUERYRTFOBJ = 0x0000050d;

enum : uint
{
    EM_SETQUERYRTFOBJ                 = 0x0000050e,
    EM_SETQUERYCONVERTOLELINKCALLBACK = 0x00000593,
}

enum uint EM_SETDISABLEOLELINKCONVERSION = 0x00000594;

enum : uint
{
    EPR_0   = 0x00000000,
    EPR_270 = 0x00000001,
    EPR_180 = 0x00000002,
    EPR_90  = 0x00000003,
    EPR_SE  = 0x00000005,
}

enum : uint
{
    CTFMODEBIAS_DEFAULT               = 0x00000000,
    CTFMODEBIAS_FILENAME              = 0x00000001,
    CTFMODEBIAS_NAME                  = 0x00000002,
    CTFMODEBIAS_READING               = 0x00000003,
    CTFMODEBIAS_DATETIME              = 0x00000004,
    CTFMODEBIAS_CONVERSATION          = 0x00000005,
    CTFMODEBIAS_NUMERIC               = 0x00000006,
    CTFMODEBIAS_HIRAGANA              = 0x00000007,
    CTFMODEBIAS_KATAKANA              = 0x00000008,
    CTFMODEBIAS_HANGUL                = 0x00000009,
    CTFMODEBIAS_HALFWIDTHKATAKANA     = 0x0000000a,
    CTFMODEBIAS_FULLWIDTHALPHANUMERIC = 0x0000000b,
}

enum uint CTFMODEBIAS_HALFWIDTHALPHANUMERIC = 0x0000000c;

enum : uint
{
    IMF_SMODE_PLAURALCLAUSE = 0x00000001,
    IMF_SMODE_NONE          = 0x00000002,
}

enum : uint
{
    EMO_EXIT    = 0x00000000,
    EMO_ENTER   = 0x00000001,
    EMO_PROMOTE = 0x00000002,
}

enum uint EMO_EXPAND = 0x00000003;
enum uint EMO_MOVESELECTION = 0x00000004;
enum uint EMO_GETVIEWMODE = 0x00000005;

enum : uint
{
    EMO_EXPANDSELECTION = 0x00000000,
    EMO_EXPANDDOCUMENT  = 0x00000001,
}

enum uint VM_NORMAL = 0x00000004;
enum uint VM_OUTLINE = 0x00000002;
enum uint VM_PAGE = 0x00000009;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-inserttable))], [])*/uint EM_INSERTTABLE = 0x000004e8;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-getautocorrectproc))], [])*/uint EM_GETAUTOCORRECTPROC = 0x000004e9;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-setautocorrectproc))], [])*/uint EM_SETAUTOCORRECTPROC = 0x000004ea;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-callautocorrectproc))], [])*/uint EM_CALLAUTOCORRECTPROC = 0x000004ff;
enum uint ATP_NOCHANGE = 0x00000000;
enum uint ATP_CHANGE = 0x00000001;
enum uint ATP_NODELIMITER = 0x00000002;
enum uint ATP_REPLACEALLTEXT = 0x00000004;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-gettableparms))], [])*/uint EM_GETTABLEPARMS = 0x00000509;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-seteditstyleex))], [])*/uint EM_SETEDITSTYLEEX = 0x00000513;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-geteditstyleex))], [])*/uint EM_GETEDITSTYLEEX = 0x00000514;

enum : uint
{
    SES_EX_NOTABLE           = 0x00000004,
    SES_EX_NOMATH            = 0x00000040,
    SES_EX_HANDLEFRIENDLYURL = 0x00000100,
}

enum : uint
{
    SES_EX_NOTHEMING          = 0x00080000,
    SES_EX_NOACETATESELECTION = 0x00100000,
}

enum uint SES_EX_USESINGLELINE = 0x00200000;

enum : uint
{
    SES_EX_MULTITOUCH     = 0x08000000,
    SES_EX_HIDETEMPFORMAT = 0x10000000,
}

enum uint SES_EX_USEMOUSEWPARAM = 0x20000000;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-getstorytype))], [])*/uint EM_GETSTORYTYPE = 0x00000522;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-setstorytype))], [])*/uint EM_SETSTORYTYPE = 0x00000523;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-getellipsismode))], [])*/uint EM_GETELLIPSISMODE = 0x00000531;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-setellipsismode))], [])*/uint EM_SETELLIPSISMODE = 0x00000532;

enum : uint
{
    ELLIPSIS_MASK = 0x00000003,
    ELLIPSIS_NONE = 0x00000000,
    ELLIPSIS_END  = 0x00000001,
    ELLIPSIS_WORD = 0x00000003,
}

enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-settableparms))], [])*/uint EM_SETTABLEPARMS = 0x00000533;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-gettouchoptions))], [])*/uint EM_GETTOUCHOPTIONS = 0x00000536;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-settouchoptions))], [])*/uint EM_SETTOUCHOPTIONS = 0x00000537;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-insertimage))], [])*/uint EM_INSERTIMAGE = 0x0000053a;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-setuianame))], [])*/uint EM_SETUIANAME = 0x00000540;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/em-getellipsisstate))], [])*/uint EM_GETELLIPSISSTATE = 0x00000542;
enum uint RTO_SHOWHANDLES = 0x00000001;
enum uint RTO_DISABLEHANDLES = 0x00000002;
enum uint RTO_READINGMODE = 0x00000003;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/en-msgfilter))], [])*/uint EN_MSGFILTER = 0x00000700;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/en-requestresize))], [])*/uint EN_REQUESTRESIZE = 0x00000701;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/en-selchange))], [])*/uint EN_SELCHANGE = 0x00000702;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/en-dropfiles))], [])*/uint EN_DROPFILES = 0x00000703;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/en-protected))], [])*/uint EN_PROTECTED = 0x00000704;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/en-correcttext))], [])*/uint EN_CORRECTTEXT = 0x00000705;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/en-stopnoundo))], [])*/uint EN_STOPNOUNDO = 0x00000706;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/en-imechange))], [])*/uint EN_IMECHANGE = 0x00000707;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/en-saveclipboard))], [])*/uint EN_SAVECLIPBOARD = 0x00000708;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/en-oleopfailed))], [])*/uint EN_OLEOPFAILED = 0x00000709;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/en-objectpositions))], [])*/uint EN_OBJECTPOSITIONS = 0x0000070a;

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/en-link))], [])*/uint
{
    EN_LINK         = 0x0000070b,
    EN_DRAGDROPDONE = 0x0000070c,
}

enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/en-paragraphexpanded))], [])*/uint EN_PARAGRAPHEXPANDED = 0x0000070d;
enum uint EN_PAGECHANGE = 0x0000070e;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/en-lowfirtf))], [])*/uint EN_LOWFIRTF = 0x0000070f;

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/en-alignltr))], [])*/uint
{
    EN_ALIGNLTR = 0x00000710,
    EN_ALIGNRTL = 0x00000711,
}

enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/en-clipformat))], [])*/uint EN_CLIPFORMAT = 0x00000712;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/en-startcomposition))], [])*/uint EN_STARTCOMPOSITION = 0x00000713;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Controls/en-endcomposition))], [])*/uint EN_ENDCOMPOSITION = 0x00000714;

enum : uint
{
    ENM_NONE   = 0x00000000,
    ENM_CHANGE = 0x00000001,
}

enum uint ENM_UPDATE = 0x00000002;

enum : uint
{
    ENM_SCROLL       = 0x00000004,
    ENM_SCROLLEVENTS = 0x00000008,
}

enum uint ENM_DRAGDROPDONE = 0x00000010;
enum uint ENM_PARAGRAPHEXPANDED = 0x00000020;
enum uint ENM_PAGECHANGE = 0x00000040;
enum uint ENM_CLIPFORMAT = 0x00000080;
enum uint ENM_KEYEVENTS = 0x00010000;
enum uint ENM_MOUSEEVENTS = 0x00020000;
enum uint ENM_REQUESTRESIZE = 0x00040000;
enum uint ENM_SELCHANGE = 0x00080000;
enum uint ENM_DROPFILES = 0x00100000;
enum uint ENM_PROTECTED = 0x00200000;
enum uint ENM_CORRECTTEXT = 0x00400000;
enum uint ENM_IMECHANGE = 0x00800000;
enum uint ENM_LANGCHANGE = 0x01000000;
enum uint ENM_OBJECTPOSITIONS = 0x02000000;

enum : uint
{
    ENM_LINK     = 0x04000000,
    ENM_LOWFIRTF = 0x08000000,
}

enum uint ENM_STARTCOMPOSITION = 0x10000000;
enum uint ENM_ENDCOMPOSITION = 0x20000000;
enum uint ENM_GROUPTYPINGCHANGE = 0x40000000;
enum uint ENM_HIDELINKTOOLTIP = 0x80000000;
enum uint ES_SAVESEL = 0x00008000;
enum uint ES_SUNKEN = 0x00004000;
enum uint ES_DISABLENOSCROLL = 0x00002000;
enum uint ES_SELECTIONBAR = 0x01000000;
enum uint ES_NOOLEDRAGDROP = 0x00000008;
enum uint ES_EX_NOCALLOLEINIT = 0x00000000;
enum uint ES_VERTICAL = 0x00400000;
enum uint ES_NOIME = 0x00080000;
enum uint ES_SELFIME = 0x00040000;
enum uint ECO_AUTOWORDSELECTION = 0x00000001;

enum : uint
{
    ECO_AUTOVSCROLL = 0x00000040,
    ECO_AUTOHSCROLL = 0x00000080,
}

enum uint ECO_NOHIDESEL = 0x00000100;
enum uint ECO_READONLY = 0x00000800;
enum uint ECO_WANTRETURN = 0x00001000;

enum : uint
{
    ECO_SAVESEL      = 0x00008000,
    ECO_SELECTIONBAR = 0x01000000,
}

enum uint ECO_VERTICAL = 0x00400000;

enum : uint
{
    ECOOP_SET = 0x00000001,
    ECOOP_OR  = 0x00000002,
    ECOOP_AND = 0x00000003,
    ECOOP_XOR = 0x00000004,
}

enum : uint
{
    WB_MOVEWORDPREV = 0x00000004,
    WB_MOVEWORDNEXT = 0x00000005,
}

enum uint WB_PREVBREAK = 0x00000006;
enum uint WB_NEXTBREAK = 0x00000007;
enum uint PC_FOLLOWING = 0x00000001;
enum uint PC_LEADING = 0x00000002;
enum uint PC_OVERFLOW = 0x00000003;
enum uint PC_DELIMITER = 0x00000004;

enum : uint
{
    WBF_WORDWRAP  = 0x00000010,
    WBF_WORDBREAK = 0x00000020,
}

enum uint WBF_OVERFLOW = 0x00000040;

enum : uint
{
    WBF_LEVEL1 = 0x00000080,
    WBF_LEVEL2 = 0x00000100,
}

enum uint WBF_CUSTOM = 0x00000200;

enum : uint
{
    IMF_FORCENONE    = 0x00000001,
    IMF_FORCEENABLE  = 0x00000002,
    IMF_FORCEDISABLE = 0x00000004,
}

enum uint IMF_CLOSESTATUSWINDOW = 0x00000008;
enum uint IMF_VERTICAL = 0x00000020;

enum : uint
{
    IMF_FORCEACTIVE   = 0x00000040,
    IMF_FORCEINACTIVE = 0x00000080,
    IMF_FORCEREMEMBER = 0x00000100,
}

enum uint IMF_MULTIPLEEDIT = 0x00000400;
enum uint yHeightCharPtsMost = 0x00000666;
enum uint SCF_SELECTION = 0x00000001;

enum : uint
{
    SCF_WORD    = 0x00000002,
    SCF_DEFAULT = 0x00000000,
}

enum : uint
{
    SCF_ALL        = 0x00000004,
    SCF_USEUIRULES = 0x00000008,
}

enum uint SCF_ASSOCIATEFONT = 0x00000010;
enum uint SCF_NOKBUPDATE = 0x00000020;
enum uint SCF_ASSOCIATEFONT2 = 0x00000040;
enum uint SCF_SMARTFONT = 0x00000080;
enum uint SCF_CHARREPFROMLCID = 0x00000100;
enum uint SPF_DONTSETDEFAULT = 0x00000002;
enum uint SPF_SETDEFAULT = 0x00000004;

enum : uint
{
    SF_TEXT      = 0x00000001,
    SF_RTF       = 0x00000002,
    SF_RTFNOOBJS = 0x00000003,
}

enum uint SF_TEXTIZED = 0x00000004;
enum uint SF_UNICODE = 0x00000010;
enum uint SF_USECODEPAGE = 0x00000020;
enum uint SF_NCRFORNONASCII = 0x00000040;
enum uint SFF_WRITEXTRAPAR = 0x00000080;
enum uint SFF_SELECTION = 0x00008000;

enum : uint
{
    SFF_PLAINRTF         = 0x00004000,
    SFF_PERSISTVIEWSCALE = 0x00002000,
}

enum uint SFF_KEEPDOCINFO = 0x00001000;
enum uint SFF_PWD = 0x00000800;
enum uint SF_RTFVAL = 0x00000700;
enum uint MAX_TAB_STOPS = 0x00000020;
enum uint lDefaultTab = 0x000002d0;
enum uint MAX_TABLE_CELLS = 0x0000003f;

enum : uint
{
    GCMF_GRIPPER  = 0x00000001,
    GCMF_SPELLING = 0x00000002,
}

enum uint GCMF_TOUCHMENU = 0x00004000;
enum uint GCMF_MOUSEMENU = 0x00002000;
enum uint OLEOP_DOVERB = 0x00000001;

enum : const(wchar)*
{
    CF_RTF       = "Rich Text Format",
    CF_RTFNOOBJS = "Rich Text Format Without Objects",
}

enum const(wchar)* CF_RETEXTOBJ = "RichEdit Text and Objects";
enum uint ST_DEFAULT = 0x00000000;
enum uint ST_KEEPUNDO = 0x00000001;
enum uint ST_SELECTION = 0x00000002;
enum uint ST_NEWCHARS = 0x00000004;
enum uint ST_UNICODE = 0x00000008;
enum uint BOM_DEFPARADIR = 0x00000001;
enum uint BOM_PLAINTEXT = 0x00000002;
enum uint BOM_NEUTRALOVERRIDE = 0x00000004;

enum : uint
{
    BOM_CONTEXTREADING   = 0x00000008,
    BOM_CONTEXTALIGNMENT = 0x00000010,
}

enum uint BOM_LEGACYBIDICLASS = 0x00000040;
enum uint BOM_UNICODEBIDI = 0x00000080;
enum uint BOE_RTLDIR = 0x00000001;
enum uint BOE_PLAINTEXT = 0x00000002;
enum uint BOE_NEUTRALOVERRIDE = 0x00000004;

enum : uint
{
    BOE_CONTEXTREADING   = 0x00000008,
    BOE_CONTEXTALIGNMENT = 0x00000010,
}

enum uint BOE_FORCERECALC = 0x00000020;
enum uint BOE_LEGACYBIDICLASS = 0x00000040;
enum uint BOE_UNICODEBIDI = 0x00000080;
enum const(wchar)* RICHEDIT60_CLASS = "RICHEDIT60W";
enum uint AURL_ENABLEEA = 0x00000001;
enum uint GCM_TOUCHMENU = 0x00004000;
enum uint GCM_MOUSEMENU = 0x00002000;
enum HRESULT S_MSG_KEY_IGNORED = HRESULT(0x00040201);

enum : uint
{
    TXTBIT_RICHTEXT        = 0x00000001,
    TXTBIT_MULTILINE       = 0x00000002,
    TXTBIT_READONLY        = 0x00000004,
    TXTBIT_SHOWACCELERATOR = 0x00000008,
}

enum uint TXTBIT_USEPASSWORD = 0x00000010;
enum uint TXTBIT_HIDESELECTION = 0x00000020;
enum uint TXTBIT_SAVESELECTION = 0x00000040;
enum uint TXTBIT_AUTOWORDSEL = 0x00000080;

enum : uint
{
    TXTBIT_VERTICAL     = 0x00000100,
    TXTBIT_SELBARCHANGE = 0x00000200,
}

enum : uint
{
    TXTBIT_WORDWRAP    = 0x00000400,
    TXTBIT_ALLOWBEEP   = 0x00000800,
    TXTBIT_DISABLEDRAG = 0x00001000,
}

enum uint TXTBIT_VIEWINSETCHANGE = 0x00002000;
enum uint TXTBIT_BACKSTYLECHANGE = 0x00004000;
enum uint TXTBIT_MAXLENGTHCHANGE = 0x00008000;
enum uint TXTBIT_SCROLLBARCHANGE = 0x00010000;
enum uint TXTBIT_CHARFORMATCHANGE = 0x00020000;
enum uint TXTBIT_PARAFORMATCHANGE = 0x00040000;
enum uint TXTBIT_EXTENTCHANGE = 0x00080000;
enum uint TXTBIT_CLIENTRECTCHANGE = 0x00100000;
enum uint TXTBIT_USECURRENTBKG = 0x00200000;
enum uint TXTBIT_NOTHREADREFCOUNT = 0x00400000;
enum uint TXTBIT_SHOWPASSWORD = 0x00800000;

enum : uint
{
    TXTBIT_D2DDWRITE           = 0x01000000,
    TXTBIT_D2DSIMPLETYPOGRAPHY = 0x02000000,
}

enum : uint
{
    TXTBIT_D2DPIXELSNAPPED  = 0x04000000,
    TXTBIT_D2DSUBPIXELLINES = 0x08000000,
}

enum uint TXTBIT_FLASHLASTPASSWORDCHAR = 0x10000000;
enum uint TXTBIT_ADVANCEDINPUT = 0x20000000;
enum uint TXES_ISDIALOG = 0x00000001;

enum : int
{
    REO_NULL          = 0x00000000,
    REO_READWRITEMASK = 0x000007ff,
}

// Callbacks

alias AutoCorrectProc = int function(ushort langid, const(PWSTR) pszBefore, PWSTR pszAfter, int cchAfter, 
                                     int* pcchReplaced);
alias EDITWORDBREAKPROCEX = int function(PSTR pchText, int cchText, ubyte bCharSet, int action);
alias EDITSTREAMCALLBACK = uint function(size_t dwCookie, ubyte* pbBuff, int cb, int* pcb);
alias PCreateTextServices = HRESULT function(IUnknown punkOuter, ITextHost pITextHost, IUnknown* ppUnk);
alias PShutdownTextServices = HRESULT function(IUnknown pTextServices);

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-richedit_image_parameters))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct RICHEDIT_IMAGE_PARAMETERS
{
align (4):
    int          xWidth;
    int          yHeight;
    int          Ascent;
    int          Type;
    const(PWSTR) pwszAlternateText;
    IStream      pIStream;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-endcompositionnotify))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct ENDCOMPOSITIONNOTIFY
{
align (4):
    NMHDR nmhdr;
    ENDCOMPOSITIONNOTIFY_CODE dwCode;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-textrangea))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct TEXTRANGEA
{
align (4):
    CHARRANGE chrg;
    PSTR      lpstrText;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-textrangew))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct TEXTRANGEW
{
align (4):
    CHARRANGE chrg;
    PWSTR     lpstrText;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-editstream))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct EDITSTREAM
{
align (4):
    size_t             dwCookie;
    uint               dwError;
    EDITSTREAMCALLBACK pfnCallback;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-findtexta))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct FINDTEXTA
{
align (4):
    CHARRANGE   chrg;
    const(PSTR) lpstrText;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-findtextw))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct FINDTEXTW
{
align (4):
    CHARRANGE    chrg;
    const(PWSTR) lpstrText;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-findtextexa))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct FINDTEXTEXA
{
align (4):
    CHARRANGE   chrg;
    const(PSTR) lpstrText;
    CHARRANGE   chrgText;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-findtextexw))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct FINDTEXTEXW
{
align (4):
    CHARRANGE    chrg;
    const(PWSTR) lpstrText;
    CHARRANGE    chrgText;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-formatrange))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct FORMATRANGE
{
align (4):
    HDC       hdc;
    HDC       hdcTarget;
    RECT      rc;
    RECT      rcPage;
    CHARRANGE chrg;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-msgfilter))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct MSGFILTER
{
align (4):
    NMHDR  nmhdr;
    uint   msg;
    WPARAM wParam;
    LPARAM lParam;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-reqresize))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct REQRESIZE
{
align (4):
    NMHDR nmhdr;
    RECT  rc;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-selchange))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct SELCHANGE
{
align (4):
    NMHDR     nmhdr;
    CHARRANGE chrg;
    RICH_EDIT_GET_CONTEXT_MENU_SEL_TYPE seltyp;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-clipboardformat))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct CLIPBOARDFORMAT
{
align (4):
    NMHDR  nmhdr;
    ushort cf;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-getcontextmenuex))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct GETCONTEXTMENUEX
{
align (4):
    CHARRANGE chrg;
    uint      dwFlags;
    POINT     pt;
    void*     pvReserved;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-endropfiles))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct ENDROPFILES
{
align (4):
    NMHDR  nmhdr;
    HANDLE hDrop;
    int    cp;
    BOOL   fProtected;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-enprotected))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct ENPROTECTED
{
align (4):
    NMHDR     nmhdr;
    uint      msg;
    WPARAM    wParam;
    LPARAM    lParam;
    CHARRANGE chrg;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-ensaveclipboard))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct ENSAVECLIPBOARD
{
align (4):
    NMHDR nmhdr;
    int   cObjectCount;
    int   cch;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-enoleopfailed))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct ENOLEOPFAILED
{
align (4):
    NMHDR   nmhdr;
    int     iob;
    int     lOper;
    HRESULT hr;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-objectpositions))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct OBJECTPOSITIONS
{
align (4):
    NMHDR nmhdr;
    int   cObjectCount;
    int*  pcpPositions;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-enlink))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct ENLINK
{
align (4):
    NMHDR     nmhdr;
    uint      msg;
    WPARAM    wParam;
    LPARAM    lParam;
    CHARRANGE chrg;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-enlowfirtf))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct ENLOWFIRTF
{
align (4):
    NMHDR nmhdr;
    PSTR  szControl;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-encorrecttext))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct ENCORRECTTEXT
{
align (4):
    NMHDR     nmhdr;
    CHARRANGE chrg;
    RICH_EDIT_GET_CONTEXT_MENU_SEL_TYPE seltyp;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-punctuation))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct PUNCTUATION
{
align (4):
    uint iSize;
    PSTR szPunctuation;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-repastespecial))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct REPASTESPECIAL
{
align (4):
    DVASPECT dwAspect;
    size_t   dwParam;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-gettextex))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct GETTEXTEX
{
align (4):
    uint            cb;
    GETTEXTEX_FLAGS flags;
    uint            codepage;
    const(PSTR)     lpDefaultChar;
    BOOL*           lpUsedDefChar;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-hyphenateinfo))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct HYPHENATEINFO
{
align (4):
    short     cbSize;
    short     dxHyphenateZone;
    ptrdiff_t pfnHyphenate;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-imecomptext))], [])
struct IMECOMPTEXT
{
    int               cb;
    IMECOMPTEXT_FLAGS flags;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-tablerowparms))], [])
struct TABLEROWPARMS
{
    ubyte cbRow;
    ubyte cbCell;
    ubyte cCell;
    ubyte cRow;
    int   dxCellMargin;
    int   dxIndent;
    int   dyHeight;
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(fIdentCells)), FixedArgSig(ElementSig(7)), FixedArgSig(ElementSig(1))], [])*/uint _bitfield148;
    int   cpStartRow;
    ubyte bTableLevel;
    ubyte iCell;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-tablecellparms))], [])
struct TABLECELLPARMS
{
    int      dxWidth;
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(fMergeCont)), FixedArgSig(ElementSig(6)), FixedArgSig(ElementSig(1))], [])*/ushort _bitfield149;
    ushort   wShading;
    short    dxBrdrLeft;
    short    dyBrdrTop;
    short    dxBrdrRight;
    short    dyBrdrBottom;
    COLORREF crBrdrLeft;
    COLORREF crBrdrTop;
    COLORREF crBrdrRight;
    COLORREF crBrdrBottom;
    COLORREF crBackPat;
    COLORREF crForePat;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-richedit_image_parameters))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct RICHEDIT_IMAGE_PARAMETERS
{
    int          xWidth;
    int          yHeight;
    int          Ascent;
    int          Type;
    const(PWSTR) pwszAlternateText;
    IStream      pIStream;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-endcompositionnotify))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct ENDCOMPOSITIONNOTIFY
{
    NMHDR nmhdr;
    ENDCOMPOSITIONNOTIFY_CODE dwCode;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-charformata))], [])
struct CHARFORMATA
{
    uint         cbSize;
    CFM_MASK     dwMask;
    CFE_EFFECTS  dwEffects;
    int          yHeight;
    int          yOffset;
    COLORREF     crTextColor;
    FONT_CHARSET bCharSet;
    ubyte        bPitchAndFamily;
    CHAR[32]     szFaceName;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-charformatw))], [])
struct CHARFORMATW
{
    uint         cbSize;
    CFM_MASK     dwMask;
    CFE_EFFECTS  dwEffects;
    int          yHeight;
    int          yOffset;
    COLORREF     crTextColor;
    FONT_CHARSET bCharSet;
    ubyte        bPitchAndFamily;
    wchar[32]    szFaceName;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-charformat2w))], [])
struct CHARFORMAT2W
{
    CHARFORMATW         Base;
    ushort              wWeight;
    short               sSpacing;
    COLORREF            crBackColor;
    uint                lcid;
    _Anonymous_e__Union Anonymous;
    short               sStyle;
    ushort              wKerning;
    ubyte               bUnderlineType;
    ubyte               bAnimation;
    ubyte               bRevAuthor;
    ubyte               bUnderlineColor;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-charformat2a))], [])
struct CHARFORMAT2A
{
    CHARFORMATA         Base;
    ushort              wWeight;
    short               sSpacing;
    COLORREF            crBackColor;
    uint                lcid;
    _Anonymous_e__Union Anonymous;
    short               sStyle;
    ushort              wKerning;
    ubyte               bUnderlineType;
    ubyte               bAnimation;
    ubyte               bRevAuthor;
    ubyte               bUnderlineColor;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-charrange))], [])
struct CHARRANGE
{
    int cpMin;
    int cpMax;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-textrangea))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct TEXTRANGEA
{
    CHARRANGE chrg;
    PSTR      lpstrText;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-textrangew))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct TEXTRANGEW
{
    CHARRANGE chrg;
    PWSTR     lpstrText;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-editstream))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct EDITSTREAM
{
    size_t             dwCookie;
    uint               dwError;
    EDITSTREAMCALLBACK pfnCallback;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-findtexta))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct FINDTEXTA
{
    CHARRANGE   chrg;
    const(PSTR) lpstrText;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-findtextw))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct FINDTEXTW
{
    CHARRANGE    chrg;
    const(PWSTR) lpstrText;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-findtextexa))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct FINDTEXTEXA
{
    CHARRANGE   chrg;
    const(PSTR) lpstrText;
    CHARRANGE   chrgText;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-findtextexw))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct FINDTEXTEXW
{
    CHARRANGE    chrg;
    const(PWSTR) lpstrText;
    CHARRANGE    chrgText;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-formatrange))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct FORMATRANGE
{
    HDC       hdc;
    HDC       hdcTarget;
    RECT      rc;
    RECT      rcPage;
    CHARRANGE chrg;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-paraformat))], [])
struct PARAFORMAT
{
    uint                 cbSize;
    PARAFORMAT_MASK      dwMask;
    PARAFORMAT_NUMBERING wNumbering;
    _Anonymous_e__Union  Anonymous;
    int                  dxStartIndent;
    int                  dxRightIndent;
    int                  dxOffset;
    PARAFORMAT_ALIGNMENT wAlignment;
    short                cTabCount;
    uint[32]             rgxTabs;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-paraformat2))], [])
struct PARAFORMAT2
{
    PARAFORMAT         Base;
    int                dySpaceBefore;
    int                dySpaceAfter;
    int                dyLineSpacing;
    short              sStyle;
    ubyte              bLineSpacingRule;
    ubyte              bOutlineLevel;
    ushort             wShadingWeight;
    PARAFORMAT_SHADING_STYLE wShadingStyle;
    ushort             wNumberingStart;
    PARAFORMAT_NUMBERING_STYLE wNumberingStyle;
    ushort             wNumberingTab;
    ushort             wBorderSpace;
    ushort             wBorderWidth;
    PARAFORMAT_BORDERS wBorders;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-msgfilter))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct MSGFILTER
{
    NMHDR  nmhdr;
    uint   msg;
    WPARAM wParam;
    LPARAM lParam;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-reqresize))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct REQRESIZE
{
    NMHDR nmhdr;
    RECT  rc;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-selchange))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct SELCHANGE
{
    NMHDR     nmhdr;
    CHARRANGE chrg;
    RICH_EDIT_GET_CONTEXT_MENU_SEL_TYPE seltyp;
}

struct GROUPTYPINGCHANGE
{
align (4):
    NMHDR nmhdr;
    BOOL  fGroupTyping;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-clipboardformat))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct CLIPBOARDFORMAT
{
    NMHDR  nmhdr;
    ushort cf;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-getcontextmenuex))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct GETCONTEXTMENUEX
{
    CHARRANGE chrg;
    uint      dwFlags;
    POINT     pt;
    void*     pvReserved;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-endropfiles))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct ENDROPFILES
{
    NMHDR  nmhdr;
    HANDLE hDrop;
    int    cp;
    BOOL   fProtected;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-enprotected))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct ENPROTECTED
{
    NMHDR     nmhdr;
    uint      msg;
    WPARAM    wParam;
    LPARAM    lParam;
    CHARRANGE chrg;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-ensaveclipboard))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct ENSAVECLIPBOARD
{
    NMHDR nmhdr;
    int   cObjectCount;
    int   cch;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-enoleopfailed))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct ENOLEOPFAILED
{
    NMHDR   nmhdr;
    int     iob;
    int     lOper;
    HRESULT hr;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-objectpositions))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct OBJECTPOSITIONS
{
    NMHDR nmhdr;
    int   cObjectCount;
    int*  pcpPositions;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-enlink))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct ENLINK
{
    NMHDR     nmhdr;
    uint      msg;
    WPARAM    wParam;
    LPARAM    lParam;
    CHARRANGE chrg;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-enlowfirtf))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct ENLOWFIRTF
{
    NMHDR nmhdr;
    PSTR  szControl;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-encorrecttext))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct ENCORRECTTEXT
{
    NMHDR     nmhdr;
    CHARRANGE chrg;
    RICH_EDIT_GET_CONTEXT_MENU_SEL_TYPE seltyp;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-punctuation))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct PUNCTUATION
{
    uint iSize;
    PSTR szPunctuation;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-compcolor))], [])
struct COMPCOLOR
{
    COLORREF crText;
    COLORREF crBackground;
    uint     dwEffects;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-repastespecial))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct REPASTESPECIAL
{
    DVASPECT dwAspect;
    size_t   dwParam;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-settextex))], [])
struct SETTEXTEX
{
    uint flags;
    uint codepage;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-gettextex))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct GETTEXTEX
{
    uint            cb;
    GETTEXTEX_FLAGS flags;
    uint            codepage;
    const(PSTR)     lpDefaultChar;
    BOOL*           lpUsedDefChar;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-gettextlengthex))], [])
struct GETTEXTLENGTHEX
{
    GETTEXTLENGTHEX_FLAGS flags;
    uint codepage;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-bidioptions))], [])
struct BIDIOPTIONS
{
    uint   cbSize;
    ushort wMask;
    ushort wEffects;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-hyphresult))], [])
struct HYPHRESULT
{
    KHYPH khyph;
    int   ichHyph;
    wchar chHyph;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-hyphenateinfo))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct HYPHENATEINFO
{
    short     cbSize;
    short     dxHyphenateZone;
    ptrdiff_t pfnHyphenate;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/ns-textserv-changenotify))], [])
struct CHANGENOTIFY
{
    /*FIELD ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(CHANGETYPE))], [])*/uint dwChangeType;
    void* pvCookieData;
}

union CARET_INFO
{
    HBITMAP     hbitmap;
    CARET_FLAGS caretFlags;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/ns-richole-reobject))], [])
struct REOBJECT
{
    uint           cbStruct;
    int            cp;
    GUID           clsid;
    IOleObject     poleobj;
    IStorage       pstg;
    IOleClientSite polesite;
    SIZE           sizel;
    uint           dvaspect;
    REOBJECT_FLAGS dwFlags;
    uint           dwUser;
}

// Interfaces

//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nl-textserv-itextservices))], [])
interface ITextServices : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-txsendmessage))], [])
    HRESULT TxSendMessage(uint msg, WPARAM wparam, LPARAM lparam, LRESULT* plresult);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-txdraw))], [])
    HRESULT TxDraw(DVASPECT dwDrawAspect, int lindex, void* pvAspect, DVTARGETDEVICE* ptd, HDC hdcDraw, 
                   HDC hicTargetDev, RECTL* lprcBounds, RECTL* lprcWBounds, RECT* lprcUpdate, ptrdiff_t pfnContinue, 
                   uint dwContinue, int lViewId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-txgethscroll))], [])
    HRESULT TxGetHScroll(int* plMin, int* plMax, int* plPos, int* plPage, BOOL* pfEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-txgetvscroll))], [])
    HRESULT TxGetVScroll(int* plMin, int* plMax, int* plPos, int* plPage, BOOL* pfEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-ontxsetcursor))], [])
    HRESULT OnTxSetCursor(DVASPECT dwDrawAspect, int lindex, void* pvAspect, DVTARGETDEVICE* ptd, HDC hdcDraw, 
                          HDC hicTargetDev, RECT* lprcClient, int x, int y);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-txqueryhitpoint))], [])
    HRESULT TxQueryHitPoint(DVASPECT dwDrawAspect, int lindex, void* pvAspect, DVTARGETDEVICE* ptd, HDC hdcDraw, 
                            HDC hicTargetDev, RECT* lprcClient, int x, int y, uint* pHitResult);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-ontxinplaceactivate))], [])
    HRESULT OnTxInPlaceActivate(RECT* prcClient);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-ontxinplacedeactivate))], [])
    HRESULT OnTxInPlaceDeactivate();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-ontxuiactivate))], [])
    HRESULT OnTxUIActivate();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-ontxuideactivate))], [])
    HRESULT OnTxUIDeactivate();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-txgettext))], [])
    HRESULT TxGetText(BSTR* pbstrText);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-txsettext))], [])
    HRESULT TxSetText(const(PWSTR) pszText);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-txgetcurtargetx))], [])
    HRESULT TxGetCurTargetX(int* param0);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-txgetbaselinepos))], [])
    HRESULT TxGetBaseLinePos(int* param0);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-txgetnaturalsize))], [])
    HRESULT TxGetNaturalSize(uint dwAspect, HDC hdcDraw, HDC hicTargetDev, DVTARGETDEVICE* ptd, uint dwMode, 
                             const(SIZE)* psizelExtent, int* pwidth, int* pheight);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-txgetdroptarget))], [])
    HRESULT TxGetDropTarget(IDropTarget* ppDropTarget);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-ontxpropertybitschange))], [])
    HRESULT OnTxPropertyBitsChange(uint dwMask, uint dwBits);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-txgetcachedsize))], [])
    HRESULT TxGetCachedSize(uint* pdwWidth, uint* pdwHeight);
}

//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nl-textserv-itexthost))], [])
interface ITextHost : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txgetdc))], [])
    HDC      TxGetDC();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txreleasedc))], [])
    int      TxReleaseDC(HDC hdc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txshowscrollbar))], [])
    BOOL     TxShowScrollBar(int fnBar, BOOL fShow);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txenablescrollbar))], [])
    BOOL     TxEnableScrollBar(SCROLLBAR_CONSTANTS fuSBFlags, int fuArrowflags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txsetscrollrange))], [])
    BOOL     TxSetScrollRange(int fnBar, int nMinPos, int nMaxPos, BOOL fRedraw);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txsetscrollpos))], [])
    BOOL     TxSetScrollPos(int fnBar, int nPos, BOOL fRedraw);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txinvalidaterect))], [])
    void     TxInvalidateRect(RECT* prc, BOOL fMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txviewchange))], [])
    void     TxViewChange(BOOL fUpdate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txcreatecaret))], [])
    BOOL     TxCreateCaret(HBITMAP hbmp, int xWidth, int yHeight);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txshowcaret))], [])
    BOOL     TxShowCaret(BOOL fShow);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txsetcaretpos))], [])
    BOOL     TxSetCaretPos(int x, int y);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txsettimer))], [])
    BOOL     TxSetTimer(uint idTimer, uint uTimeout);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txkilltimer))], [])
    void     TxKillTimer(uint idTimer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txscrollwindowex))], [])
    void     TxScrollWindowEx(int dx, int dy, RECT* lprcScroll, RECT* lprcClip, HRGN hrgnUpdate, RECT* lprcUpdate, 
                              SCROLL_WINDOW_FLAGS fuScroll);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txsetcapture))], [])
    void     TxSetCapture(BOOL fCapture);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txsetfocus))], [])
    void     TxSetFocus();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txsetcursor))], [])
    void     TxSetCursor(HCURSOR hcur, BOOL fText);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txscreentoclient))], [])
    BOOL     TxScreenToClient(POINT* lppt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txclienttoscreen))], [])
    BOOL     TxClientToScreen(POINT* lppt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txactivate))], [])
    HRESULT  TxActivate(int* plOldState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txdeactivate))], [])
    HRESULT  TxDeactivate(int lNewState);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txgetclientrect))], [])
    HRESULT  TxGetClientRect(RECT* prc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txgetviewinset))], [])
    HRESULT  TxGetViewInset(RECT* prc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txgetcharformat))], [])
    HRESULT  TxGetCharFormat(const(CHARFORMATW)** ppCF);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txgetparaformat))], [])
    HRESULT  TxGetParaFormat(const(PARAFORMAT)** ppPF);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txgetsyscolor))], [])
    COLORREF TxGetSysColor(SYS_COLOR_INDEX nIndex);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txgetbackstyle))], [])
    HRESULT  TxGetBackStyle(TXTBACKSTYLE* pstyle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txgetmaxlength))], [])
    HRESULT  TxGetMaxLength(uint* plength);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txgetscrollbars))], [])
    HRESULT  TxGetScrollBars(uint* pdwScrollBar);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txgetpasswordchar))], [])
    HRESULT  TxGetPasswordChar(byte* pch);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txgetacceleratorpos))], [])
    HRESULT  TxGetAcceleratorPos(int* pcp);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txgetextent))], [])
    HRESULT  TxGetExtent(SIZE* lpExtent);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-ontxcharformatchange))], [])
    HRESULT  OnTxCharFormatChange(const(CHARFORMATW)* pCF);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-ontxparaformatchange))], [])
    HRESULT  OnTxParaFormatChange(const(PARAFORMAT)* pPF);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txgetpropertybits))], [])
    HRESULT  TxGetPropertyBits(uint dwMask, uint* pdwBits);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txnotify))], [])
    HRESULT  TxNotify(uint iNotify, void* pv);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-tximmgetcontext))], [])
    HIMC     TxImmGetContext();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-tximmreleasecontext))], [])
    void     TxImmReleaseContext(HIMC himc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txgetselectionbarwidth))], [])
    HRESULT  TxGetSelectionBarWidth(int* lSelBarWidth);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nn-textserv-irichedituiaoverrides))], [])
interface IRicheditUiaOverrides : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-irichedituiaoverrides-getpropertyoverridevalue))], [])
    HRESULT GetPropertyOverrideValue(int propertyId, VARIANT* pRetValue);
}

//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nl-textserv-itexthost2))], [])
interface ITextHost2 : ITextHost
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost2-txisdoubleclickpending))], [])
    BOOL     TxIsDoubleClickPending();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost2-txgetwindow))], [])
    HRESULT  TxGetWindow(HWND* phwnd);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost2-txsetforegroundwindow))], [])
    HRESULT  TxSetForegroundWindow();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost2-txgetpalette))], [])
    HPALETTE TxGetPalette();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost2-txgeteastasianflags))], [])
    HRESULT  TxGetEastAsianFlags(int* pFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost2-txsetcursor2))], [])
    HCURSOR  TxSetCursor2(HCURSOR hcur, BOOL bText);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost2-txfreetextservicesnotification))], [])
    void     TxFreeTextServicesNotification();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost2-txgeteditstyle))], [])
    HRESULT  TxGetEditStyle(uint dwItem, uint* pdwData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost2-txgetwindowstyles))], [])
    HRESULT  TxGetWindowStyles(uint* pdwStyle, uint* pdwExStyle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost2-txshowdropcaret))], [])
    HRESULT  TxShowDropCaret(BOOL fShow, HDC hdc, RECT* prc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost2-txdestroycaret))], [])
    HRESULT  TxDestroyCaret();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost2-txgethorzextent))], [])
    HRESULT  TxGetHorzExtent(int* plHorzExtent);
}

//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nl-textserv-itextservices2))], [])
interface ITextServices2 : ITextServices
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices2-txgetnaturalsize2))], [])
    HRESULT TxGetNaturalSize2(uint dwAspect, HDC hdcDraw, HDC hicTargetDev, DVTARGETDEVICE* ptd, uint dwMode, 
                              const(SIZE)* psizelExtent, int* pwidth, int* pheight, int* pascent);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices2-txdrawd2d))], [])
    HRESULT TxDrawD2D(ID2D1RenderTarget pRenderTarget, RECTL* lprcBounds, RECT* lprcUpdate, int lViewId);
}

@GUID("00020d00-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/nn-richole-iricheditole))], [])
interface IRichEditOle : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-getclientsite))], [])
    HRESULT GetClientSite(IOleClientSite* lplpolesite);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-getobjectcount))], [])
    int     GetObjectCount();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-getlinkcount))], [])
    int     GetLinkCount();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-getobject))], [])
    HRESULT GetObject(int iob, REOBJECT* lpreobject, RICH_EDIT_GET_OBJECT_FLAGS dwFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-insertobject))], [])
    HRESULT InsertObject(REOBJECT* lpreobject);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-convertobject))], [])
    HRESULT ConvertObject(int iob, const(GUID)* rclsidNew, const(PSTR) lpstrUserTypeNew);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-activateas))], [])
    HRESULT ActivateAs(const(GUID)* rclsid, const(GUID)* rclsidAs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-sethostnames))], [])
    HRESULT SetHostNames(const(PSTR) lpstrContainerApp, const(PSTR) lpstrContainerObj);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-setlinkavailable))], [])
    HRESULT SetLinkAvailable(int iob, BOOL fAvailable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-setdvaspect))], [])
    HRESULT SetDvaspect(int iob, uint dvaspect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-handsoffstorage))], [])
    HRESULT HandsOffStorage(int iob);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-savecompleted))], [])
    HRESULT SaveCompleted(int iob, IStorage lpstg);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-inplacedeactivate))], [])
    HRESULT InPlaceDeactivate();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-contextsensitivehelp))], [])
    HRESULT ContextSensitiveHelp(BOOL fEnterMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-getclipboarddata))], [])
    HRESULT GetClipboardData(CHARRANGE* lpchrg, uint reco, IDataObject* lplpdataobj);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-importdataobject))], [])
    HRESULT ImportDataObject(IDataObject lpdataobj, ushort cf, HGLOBAL hMetaPict);
}

@GUID("00020d03-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/nn-richole-iricheditolecallback))], [])
interface IRichEditOleCallback : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditolecallback-getnewstorage))], [])
    HRESULT GetNewStorage(IStorage* lplpstg);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditolecallback-getinplacecontext))], [])
    HRESULT GetInPlaceContext(IOleInPlaceFrame* lplpFrame, IOleInPlaceUIWindow* lplpDoc, 
                              OLEINPLACEFRAMEINFO* lpFrameInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditolecallback-showcontainerui))], [])
    HRESULT ShowContainerUI(BOOL fShow);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditolecallback-queryinsertobject))], [])
    HRESULT QueryInsertObject(GUID* lpclsid, IStorage lpstg, int cp);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditolecallback-deleteobject))], [])
    HRESULT DeleteObject(IOleObject lpoleobj);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditolecallback-queryacceptdata))], [])
    HRESULT QueryAcceptData(IDataObject lpdataobj, ushort* lpcfFormat, RECO_FLAGS reco, BOOL fReally, 
                            HGLOBAL hMetaPict);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditolecallback-contextsensitivehelp))], [])
    HRESULT ContextSensitiveHelp(BOOL fEnterMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditolecallback-getclipboarddata))], [])
    HRESULT GetClipboardData(CHARRANGE* lpchrg, uint reco, IDataObject* lplpdataobj);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditolecallback-getdragdropeffect))], [])
    HRESULT GetDragDropEffect(BOOL fDrag, MODIFIERKEYS_FLAGS grfKeyState, DROPEFFECT* pdwEffect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditolecallback-getcontextmenu))], [])
    HRESULT GetContextMenu(RICH_EDIT_GET_CONTEXT_MENU_SEL_TYPE seltype, IOleObject lpoleobj, CHARRANGE* lpchrg, 
                           HMENU* lphmenu);
}

@GUID("8cc497c0-a1df-11ce-8098-00aa0047be5d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextdocument))], [])
interface ITextDocument : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-getname))], [])
    HRESULT GetName(BSTR* pName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-getselection))], [])
    HRESULT GetSelection(ITextSelection* ppSel);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-getstorycount))], [])
    HRESULT GetStoryCount(int* pCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-getstoryranges))], [])
    HRESULT GetStoryRanges(ITextStoryRanges* ppStories);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-getsaved))], [])
    HRESULT GetSaved(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-setsaved))], [])
    HRESULT SetSaved(tomConstants Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-getdefaulttabstop))], [])
    HRESULT GetDefaultTabStop(float* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-setdefaulttabstop))], [])
    HRESULT SetDefaultTabStop(float Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-new))], [])
    HRESULT New();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-open))], [])
    HRESULT Open(VARIANT* pVar, tomConstants Flags, int CodePage);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-save))], [])
    HRESULT Save(VARIANT* pVar, tomConstants Flags, int CodePage);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-freeze))], [])
    HRESULT Freeze(int* pCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-unfreeze))], [])
    HRESULT Unfreeze(int* pCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-begineditcollection))], [])
    HRESULT BeginEditCollection();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-endeditcollection))], [])
    HRESULT EndEditCollection();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-undo))], [])
    HRESULT Undo(int Count, int* pCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-redo))], [])
    HRESULT Redo(int Count, int* pCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-range))], [])
    HRESULT Range(int cpActive, int cpAnchor, ITextRange* ppRange);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-rangefrompoint))], [])
    HRESULT RangeFromPoint(int x, int y, ITextRange* ppRange);
}

@GUID("8cc497c2-a1df-11ce-8098-00aa0047be5d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextrange))], [])
interface ITextRange : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-gettext))], [])
    HRESULT GetText(BSTR* pbstr);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-settext))], [])
    HRESULT SetText(BSTR bstr);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-getchar))], [])
    HRESULT GetChar(int* pChar);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-setchar))], [])
    HRESULT SetChar(int Char);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-getduplicate))], [])
    HRESULT GetDuplicate(ITextRange* ppRange);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-getformattedtext))], [])
    HRESULT GetFormattedText(ITextRange* ppRange);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-setformattedtext))], [])
    HRESULT SetFormattedText(ITextRange pRange);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-getstart))], [])
    HRESULT GetStart(int* pcpFirst);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-setstart))], [])
    HRESULT SetStart(int cpFirst);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-getend))], [])
    HRESULT GetEnd(int* pcpLim);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-setend))], [])
    HRESULT SetEnd(int cpLim);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-getfont))], [])
    HRESULT GetFont(ITextFont* ppFont);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-setfont))], [])
    HRESULT SetFont(ITextFont pFont);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-getpara))], [])
    HRESULT GetPara(ITextPara* ppPara);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-setpara))], [])
    HRESULT SetPara(ITextPara pPara);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-getstorylength))], [])
    HRESULT GetStoryLength(int* pCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-getstorytype))], [])
    HRESULT GetStoryType(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-collapse))], [])
    HRESULT Collapse(int bStart);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-expand))], [])
    HRESULT Expand(int Unit, int* pDelta);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-getindex))], [])
    HRESULT GetIndex(int Unit, int* pIndex);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-setindex))], [])
    HRESULT SetIndex(int Unit, int Index, int Extend);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-setrange))], [])
    HRESULT SetRange(int cpAnchor, int cpActive);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-inrange))], [])
    HRESULT InRange(ITextRange pRange, int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-instory))], [])
    HRESULT InStory(ITextRange pRange, int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-isequal))], [])
    HRESULT IsEqual(ITextRange pRange, int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-select))], [])
    HRESULT Select();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-startof))], [])
    HRESULT StartOf(int Unit, int Extend, int* pDelta);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-endof))], [])
    HRESULT EndOf(int Unit, int Extend, int* pDelta);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-move))], [])
    HRESULT Move(int Unit, int Count, int* pDelta);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-movestart))], [])
    HRESULT MoveStart(int Unit, int Count, int* pDelta);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-moveend))], [])
    HRESULT MoveEnd(int Unit, int Count, int* pDelta);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-movewhile))], [])
    HRESULT MoveWhile(VARIANT* Cset, int Count, int* pDelta);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-movestartwhile))], [])
    HRESULT MoveStartWhile(VARIANT* Cset, int Count, int* pDelta);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-moveendwhile))], [])
    HRESULT MoveEndWhile(VARIANT* Cset, int Count, int* pDelta);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-moveuntil))], [])
    HRESULT MoveUntil(VARIANT* Cset, int Count, int* pDelta);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-movestartuntil))], [])
    HRESULT MoveStartUntil(VARIANT* Cset, int Count, int* pDelta);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-moveenduntil))], [])
    HRESULT MoveEndUntil(VARIANT* Cset, int Count, int* pDelta);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-findtext))], [])
    HRESULT FindText(BSTR bstr, int Count, tomConstants Flags, int* pLength);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-findtextstart))], [])
    HRESULT FindTextStart(BSTR bstr, int Count, tomConstants Flags, int* pLength);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-findtextend))], [])
    HRESULT FindTextEnd(BSTR bstr, int Count, tomConstants Flags, int* pLength);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-delete))], [])
    HRESULT Delete(int Unit, int Count, int* pDelta);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-cut))], [])
    HRESULT Cut(VARIANT* pVar);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-copy))], [])
    HRESULT Copy(VARIANT* pVar);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-paste))], [])
    HRESULT Paste(VARIANT* pVar, int Format);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-canpaste))], [])
    HRESULT CanPaste(VARIANT* pVar, int Format, int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-canedit))], [])
    HRESULT CanEdit(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-changecase))], [])
    HRESULT ChangeCase(tomConstants Type);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-getpoint))], [])
    HRESULT GetPoint(tomConstants Type, int* px, int* py);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-setpoint))], [])
    HRESULT SetPoint(int x, int y, tomConstants Type, int Extend);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-scrollintoview))], [])
    HRESULT ScrollIntoView(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-getembeddedobject))], [])
    HRESULT GetEmbeddedObject(IUnknown* ppObject);
}

@GUID("8cc497c1-a1df-11ce-8098-00aa0047be5d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextselection))], [])
interface ITextSelection : ITextRange
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextselection-getflags))], [])
    HRESULT GetFlags(int* pFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextselection-setflags))], [])
    HRESULT SetFlags(int Flags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextselection-gettype))], [])
    HRESULT GetType(int* pType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextselection-moveleft))], [])
    HRESULT MoveLeft(int Unit, int Count, int Extend, int* pDelta);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextselection-moveright))], [])
    HRESULT MoveRight(int Unit, int Count, int Extend, int* pDelta);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextselection-moveup))], [])
    HRESULT MoveUp(int Unit, int Count, int Extend, int* pDelta);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextselection-movedown))], [])
    HRESULT MoveDown(int Unit, int Count, int Extend, int* pDelta);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextselection-homekey))], [])
    HRESULT HomeKey(tomConstants Unit, int Extend, int* pDelta);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextselection-endkey))], [])
    HRESULT EndKey(int Unit, int Extend, int* pDelta);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextselection-typetext))], [])
    HRESULT TypeText(BSTR bstr);
}

@GUID("8cc497c3-a1df-11ce-8098-00aa0047be5d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextfont))], [])
interface ITextFont : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getduplicate))], [])
    HRESULT GetDuplicate(ITextFont* ppFont);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setduplicate))], [])
    HRESULT SetDuplicate(ITextFont pFont);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-canchange))], [])
    HRESULT CanChange(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-isequal))], [])
    HRESULT IsEqual(ITextFont pFont, int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-reset))], [])
    HRESULT Reset(tomConstants Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getstyle))], [])
    HRESULT GetStyle(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setstyle))], [])
    HRESULT SetStyle(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getallcaps))], [])
    HRESULT GetAllCaps(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setallcaps))], [])
    HRESULT SetAllCaps(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getanimation))], [])
    HRESULT GetAnimation(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setanimation))], [])
    HRESULT SetAnimation(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getbackcolor))], [])
    HRESULT GetBackColor(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setbackcolor))], [])
    HRESULT SetBackColor(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getbold))], [])
    HRESULT GetBold(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setbold))], [])
    HRESULT SetBold(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getemboss))], [])
    HRESULT GetEmboss(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setemboss))], [])
    HRESULT SetEmboss(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getforecolor))], [])
    HRESULT GetForeColor(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setforecolor))], [])
    HRESULT SetForeColor(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-gethidden))], [])
    HRESULT GetHidden(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-sethidden))], [])
    HRESULT SetHidden(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getengrave))], [])
    HRESULT GetEngrave(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setengrave))], [])
    HRESULT SetEngrave(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getitalic))], [])
    HRESULT GetItalic(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setitalic))], [])
    HRESULT SetItalic(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getkerning))], [])
    HRESULT GetKerning(float* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setkerning))], [])
    HRESULT SetKerning(float Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getlanguageid))], [])
    HRESULT GetLanguageID(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setlanguageid))], [])
    HRESULT SetLanguageID(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getname))], [])
    HRESULT GetName(BSTR* pbstr);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setname))], [])
    HRESULT SetName(BSTR bstr);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getoutline))], [])
    HRESULT GetOutline(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setoutline))], [])
    HRESULT SetOutline(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getposition))], [])
    HRESULT GetPosition(float* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setposition))], [])
    HRESULT SetPosition(float Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getprotected))], [])
    HRESULT GetProtected(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setprotected))], [])
    HRESULT SetProtected(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getshadow))], [])
    HRESULT GetShadow(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setshadow))], [])
    HRESULT SetShadow(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getsize))], [])
    HRESULT GetSize(float* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setsize))], [])
    HRESULT SetSize(float Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getsmallcaps))], [])
    HRESULT GetSmallCaps(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setsmallcaps))], [])
    HRESULT SetSmallCaps(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getspacing))], [])
    HRESULT GetSpacing(float* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setspacing))], [])
    HRESULT SetSpacing(float Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getstrikethrough))], [])
    HRESULT GetStrikeThrough(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setstrikethrough))], [])
    HRESULT SetStrikeThrough(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getsubscript))], [])
    HRESULT GetSubscript(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setsubscript))], [])
    HRESULT SetSubscript(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getsuperscript))], [])
    HRESULT GetSuperscript(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setsuperscript))], [])
    HRESULT SetSuperscript(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getunderline))], [])
    HRESULT GetUnderline(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setunderline))], [])
    HRESULT SetUnderline(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getweight))], [])
    HRESULT GetWeight(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setweight))], [])
    HRESULT SetWeight(int Value);
}

@GUID("8cc497c4-a1df-11ce-8098-00aa0047be5d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextpara))], [])
interface ITextPara : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getduplicate))], [])
    HRESULT GetDuplicate(ITextPara* ppPara);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setduplicate))], [])
    HRESULT SetDuplicate(ITextPara pPara);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-canchange))], [])
    HRESULT CanChange(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-isequal))], [])
    HRESULT IsEqual(ITextPara pPara, int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-reset))], [])
    HRESULT Reset(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getstyle))], [])
    HRESULT GetStyle(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setstyle))], [])
    HRESULT SetStyle(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getalignment))], [])
    HRESULT GetAlignment(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setalignment))], [])
    HRESULT SetAlignment(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-gethyphenation))], [])
    HRESULT GetHyphenation(tomConstants* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-sethyphenation))], [])
    HRESULT SetHyphenation(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getfirstlineindent))], [])
    HRESULT GetFirstLineIndent(float* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getkeeptogether))], [])
    HRESULT GetKeepTogether(tomConstants* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setkeeptogether))], [])
    HRESULT SetKeepTogether(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getkeepwithnext))], [])
    HRESULT GetKeepWithNext(tomConstants* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setkeepwithnext))], [])
    HRESULT SetKeepWithNext(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getleftindent))], [])
    HRESULT GetLeftIndent(float* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getlinespacing))], [])
    HRESULT GetLineSpacing(float* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getlinespacingrule))], [])
    HRESULT GetLineSpacingRule(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getlistalignment))], [])
    HRESULT GetListAlignment(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setlistalignment))], [])
    HRESULT SetListAlignment(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getlistlevelindex))], [])
    HRESULT GetListLevelIndex(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setlistlevelindex))], [])
    HRESULT SetListLevelIndex(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getliststart))], [])
    HRESULT GetListStart(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setliststart))], [])
    HRESULT SetListStart(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getlisttab))], [])
    HRESULT GetListTab(float* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setlisttab))], [])
    HRESULT SetListTab(float Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getlisttype))], [])
    HRESULT GetListType(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setlisttype))], [])
    HRESULT SetListType(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getnolinenumber))], [])
    HRESULT GetNoLineNumber(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setnolinenumber))], [])
    HRESULT SetNoLineNumber(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getpagebreakbefore))], [])
    HRESULT GetPageBreakBefore(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setpagebreakbefore))], [])
    HRESULT SetPageBreakBefore(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getrightindent))], [])
    HRESULT GetRightIndent(float* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setrightindent))], [])
    HRESULT SetRightIndent(float Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setindents))], [])
    HRESULT SetIndents(float First, float Left, float Right);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setlinespacing))], [])
    HRESULT SetLineSpacing(int Rule, float Spacing);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getspaceafter))], [])
    HRESULT GetSpaceAfter(float* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setspaceafter))], [])
    HRESULT SetSpaceAfter(float Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getspacebefore))], [])
    HRESULT GetSpaceBefore(float* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setspacebefore))], [])
    HRESULT SetSpaceBefore(float Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getwidowcontrol))], [])
    HRESULT GetWidowControl(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setwidowcontrol))], [])
    HRESULT SetWidowControl(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-gettabcount))], [])
    HRESULT GetTabCount(int* pCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-addtab))], [])
    HRESULT AddTab(float tbPos, int tbAlign, int tbLeader);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-clearalltabs))], [])
    HRESULT ClearAllTabs();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-deletetab))], [])
    HRESULT DeleteTab(float tbPos);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-gettab))], [])
    HRESULT GetTab(int iTab, float* ptbPos, int* ptbAlign, int* ptbLeader);
}

@GUID("8cc497c5-a1df-11ce-8098-00aa0047be5d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextstoryranges))], [])
interface ITextStoryRanges : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstoryranges-_newenum))], [])
    HRESULT _NewEnum(IUnknown* ppunkEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstoryranges-item))], [])
    HRESULT Item(int Index, ITextRange* ppRange);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstoryranges-getcount))], [])
    HRESULT GetCount(int* pCount);
}

@GUID("c241f5e0-7206-11d8-a2c7-00a0d1d6c6b3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextdocument2))], [])
interface ITextDocument2 : ITextDocument
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getcarettype))], [])
    HRESULT GetCaretType(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-setcarettype))], [])
    HRESULT SetCaretType(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getdisplays))], [])
    HRESULT GetDisplays(ITextDisplays* ppDisplays);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getdocumentfont))], [])
    HRESULT GetDocumentFont(ITextFont2* ppFont);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-setdocumentfont))], [])
    HRESULT SetDocumentFont(ITextFont2 pFont);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getdocumentpara))], [])
    HRESULT GetDocumentPara(ITextPara2* ppPara);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-setdocumentpara))], [])
    HRESULT SetDocumentPara(ITextPara2 pPara);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-geteastasianflags))], [])
    HRESULT GetEastAsianFlags(tomConstants* pFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getgenerator))], [])
    HRESULT GetGenerator(BSTR* pbstr);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-setimeinprogress))], [])
    HRESULT SetIMEInProgress(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getnotificationmode))], [])
    HRESULT GetNotificationMode(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-setnotificationmode))], [])
    HRESULT SetNotificationMode(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getselection2))], [])
    HRESULT GetSelection2(ITextSelection2* ppSel);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getstoryranges2))], [])
    HRESULT GetStoryRanges2(ITextStoryRanges2* ppStories);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-gettypographyoptions))], [])
    HRESULT GetTypographyOptions(int* pOptions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getversion))], [])
    HRESULT GetVersion(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getwindow))], [])
    HRESULT GetWindow(long* pHwnd);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-attachmsgfilter))], [])
    HRESULT AttachMsgFilter(IUnknown pFilter);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-checktextlimit))], [])
    HRESULT CheckTextLimit(int cch, int* pcch);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getcallmanager))], [])
    HRESULT GetCallManager(IUnknown* ppVoid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getclientrect))], [])
    HRESULT GetClientRect(tomConstants Type, int* pLeft, int* pTop, int* pRight, int* pBottom);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-geteffectcolor))], [])
    HRESULT GetEffectColor(int Index, int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getimmcontext))], [])
    HRESULT GetImmContext(long* pContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getpreferredfont))], [])
    HRESULT GetPreferredFont(int cp, int CharRep, int Options, int curCharRep, int curFontSize, BSTR* pbstr, 
                             int* pPitchAndFamily, int* pNewFontSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getproperty))], [])
    HRESULT GetProperty(int Type, int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getstrings))], [])
    HRESULT GetStrings(ITextStrings* ppStrs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-notify))], [])
    HRESULT Notify(int Notify);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-range2))], [])
    HRESULT Range2(int cpActive, int cpAnchor, ITextRange2* ppRange);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-rangefrompoint2))], [])
    HRESULT RangeFromPoint2(int x, int y, int Type, ITextRange2* ppRange);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-releasecallmanager))], [])
    HRESULT ReleaseCallManager(IUnknown pVoid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-releaseimmcontext))], [])
    HRESULT ReleaseImmContext(long Context);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-seteffectcolor))], [])
    HRESULT SetEffectColor(int Index, int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-setproperty))], [])
    HRESULT SetProperty(int Type, int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-settypographyoptions))], [])
    HRESULT SetTypographyOptions(int Options, int Mask);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-sysbeep))], [])
    HRESULT SysBeep();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-update))], [])
    HRESULT Update(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-updatewindow))], [])
    HRESULT UpdateWindow();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getmathproperties))], [])
    HRESULT GetMathProperties(int* pOptions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-setmathproperties))], [])
    HRESULT SetMathProperties(int Options, int Mask);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getactivestory))], [])
    HRESULT GetActiveStory(ITextStory* ppStory);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-setactivestory))], [])
    HRESULT SetActiveStory(ITextStory pStory);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getmainstory))], [])
    HRESULT GetMainStory(ITextStory* ppStory);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getnewstory))], [])
    HRESULT GetNewStory(ITextStory* ppStory);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getstory))], [])
    HRESULT GetStory(int Index, ITextStory* ppStory);
}

@GUID("c241f5e2-7206-11d8-a2c7-00a0d1d6c6b3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextrange2))], [])
interface ITextRange2 : ITextSelection
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getcch))], [])
    HRESULT GetCch(int* pcch);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getcells))], [])
    HRESULT GetCells(IUnknown* ppCells);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getcolumn))], [])
    HRESULT GetColumn(IUnknown* ppColumn);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getcount))], [])
    HRESULT GetCount(int* pCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getduplicate2))], [])
    HRESULT GetDuplicate2(ITextRange2* ppRange);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getfont2))], [])
    HRESULT GetFont2(ITextFont2* ppFont);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-setfont2))], [])
    HRESULT SetFont2(ITextFont2 pFont);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getformattedtext2))], [])
    HRESULT GetFormattedText2(ITextRange2* ppRange);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-setformattedtext2))], [])
    HRESULT SetFormattedText2(ITextRange2 pRange);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getgravity))], [])
    HRESULT GetGravity(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-setgravity))], [])
    HRESULT SetGravity(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getpara2))], [])
    HRESULT GetPara2(ITextPara2* ppPara);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-setpara2))], [])
    HRESULT SetPara2(ITextPara2 pPara);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getrow))], [])
    HRESULT GetRow(ITextRow* ppRow);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getstartpara))], [])
    HRESULT GetStartPara(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-gettable))], [])
    HRESULT GetTable(IUnknown* ppTable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-geturl))], [])
    HRESULT GetURL(BSTR* pbstr);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-seturl))], [])
    HRESULT SetURL(BSTR bstr);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-addsubrange))], [])
    HRESULT AddSubrange(int cp1, int cp2, int Activate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-buildupmath))], [])
    HRESULT BuildUpMath(int Flags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-deletesubrange))], [])
    HRESULT DeleteSubrange(int cpFirst, int cpLim);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-find))], [])
    HRESULT Find(ITextRange2 pRange, int Count, int Flags, int* pDelta);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getchar2))], [])
    HRESULT GetChar2(int* pChar, int Offset);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getdropcap))], [])
    HRESULT GetDropCap(int* pcLine, int* pPosition);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getinlineobject))], [])
    HRESULT GetInlineObject(int* pType, int* pAlign, int* pChar, int* pChar1, int* pChar2, int* pCount, 
                            int* pTeXStyle, int* pcCol, int* pLevel);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getproperty))], [])
    HRESULT GetProperty(int Type, int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getrect))], [])
    HRESULT GetRect(int Type, int* pLeft, int* pTop, int* pRight, int* pBottom, int* pHit);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getsubrange))], [])
    HRESULT GetSubrange(int iSubrange, int* pcpFirst, int* pcpLim);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-gettext2))], [])
    HRESULT GetText2(int Flags, BSTR* pbstr);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-hextounicode))], [])
    HRESULT HexToUnicode();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-inserttable))], [])
    HRESULT InsertTable(int cCol, int cRow, int AutoFit);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-linearize))], [])
    HRESULT Linearize(int Flags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-setactivesubrange))], [])
    HRESULT SetActiveSubrange(int cpAnchor, int cpActive);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-setdropcap))], [])
    HRESULT SetDropCap(int cLine, int Position);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-setproperty))], [])
    HRESULT SetProperty(int Type, int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-settext2))], [])
    HRESULT SetText2(int Flags, BSTR bstr);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-unicodetohex))], [])
    HRESULT UnicodeToHex();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-setinlineobject))], [])
    HRESULT SetInlineObject(int Type, int Align, int Char, int Char1, int Char2, int Count, int TeXStyle, int cCol);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getmathfunctiontype))], [])
    HRESULT GetMathFunctionType(BSTR bstr, int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-insertimage))], [])
    HRESULT InsertImage(int width, int height, int ascent, int Type, BSTR bstrAltText, IStream pStream);
}

@GUID("c241f5e1-7206-11d8-a2c7-00a0d1d6c6b3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextselection2))], [])
interface ITextSelection2 : ITextRange2
{
}

@GUID("c241f5e3-7206-11d8-a2c7-00a0d1d6c6b3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextfont2))], [])
interface ITextFont2 : ITextFont
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getcount))], [])
    HRESULT GetCount(int* pCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getautoligatures))], [])
    HRESULT GetAutoLigatures(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setautoligatures))], [])
    HRESULT SetAutoLigatures(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getautospacealpha))], [])
    HRESULT GetAutospaceAlpha(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setautospacealpha))], [])
    HRESULT SetAutospaceAlpha(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getautospacenumeric))], [])
    HRESULT GetAutospaceNumeric(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setautospacenumeric))], [])
    HRESULT SetAutospaceNumeric(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getautospaceparens))], [])
    HRESULT GetAutospaceParens(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setautospaceparens))], [])
    HRESULT SetAutospaceParens(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getcharrep))], [])
    HRESULT GetCharRep(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setcharrep))], [])
    HRESULT SetCharRep(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getcompressionmode))], [])
    HRESULT GetCompressionMode(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setcompressionmode))], [])
    HRESULT SetCompressionMode(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getcookie))], [])
    HRESULT GetCookie(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setcookie))], [])
    HRESULT SetCookie(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getdoublestrike))], [])
    HRESULT GetDoubleStrike(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setdoublestrike))], [])
    HRESULT SetDoubleStrike(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getduplicate2))], [])
    HRESULT GetDuplicate2(ITextFont2* ppFont);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setduplicate2))], [])
    HRESULT SetDuplicate2(ITextFont2 pFont);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getlinktype))], [])
    HRESULT GetLinkType(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getmathzone))], [])
    HRESULT GetMathZone(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setmathzone))], [])
    HRESULT SetMathZone(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getmodwidthpairs))], [])
    HRESULT GetModWidthPairs(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setmodwidthpairs))], [])
    HRESULT SetModWidthPairs(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getmodwidthspace))], [])
    HRESULT GetModWidthSpace(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setmodwidthspace))], [])
    HRESULT SetModWidthSpace(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getoldnumbers))], [])
    HRESULT GetOldNumbers(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setoldnumbers))], [])
    HRESULT SetOldNumbers(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getoverlapping))], [])
    HRESULT GetOverlapping(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setoverlapping))], [])
    HRESULT SetOverlapping(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getpositionsubsuper))], [])
    HRESULT GetPositionSubSuper(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setpositionsubsuper))], [])
    HRESULT SetPositionSubSuper(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getscaling))], [])
    HRESULT GetScaling(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setscaling))], [])
    HRESULT SetScaling(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getspaceextension))], [])
    HRESULT GetSpaceExtension(float* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setspaceextension))], [])
    HRESULT SetSpaceExtension(float Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getunderlinepositionmode))], [])
    HRESULT GetUnderlinePositionMode(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setunderlinepositionmode))], [])
    HRESULT SetUnderlinePositionMode(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-geteffects))], [])
    HRESULT GetEffects(int* pValue, int* pMask);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-geteffects2))], [])
    HRESULT GetEffects2(int* pValue, int* pMask);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getproperty))], [])
    HRESULT GetProperty(int Type, int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getpropertyinfo))], [])
    HRESULT GetPropertyInfo(int Index, int* pType, int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-isequal2))], [])
    HRESULT IsEqual2(ITextFont2 pFont, int* pB);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-seteffects))], [])
    HRESULT SetEffects(int Value, int Mask);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-seteffects2))], [])
    HRESULT SetEffects2(int Value, int Mask);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setproperty))], [])
    HRESULT SetProperty(int Type, int Value);
}

@GUID("c241f5e4-7206-11d8-a2c7-00a0d1d6c6b3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextpara2))], [])
interface ITextPara2 : ITextPara
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-getborders))], [])
    HRESULT GetBorders(IUnknown* ppBorders);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-getduplicate2))], [])
    HRESULT GetDuplicate2(ITextPara2* ppPara);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-setduplicate2))], [])
    HRESULT SetDuplicate2(ITextPara2 pPara);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-getfontalignment))], [])
    HRESULT GetFontAlignment(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-setfontalignment))], [])
    HRESULT SetFontAlignment(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-gethangingpunctuation))], [])
    HRESULT GetHangingPunctuation(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-sethangingpunctuation))], [])
    HRESULT SetHangingPunctuation(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-getsnaptogrid))], [])
    HRESULT GetSnapToGrid(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-setsnaptogrid))], [])
    HRESULT SetSnapToGrid(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-gettrimpunctuationatstart))], [])
    HRESULT GetTrimPunctuationAtStart(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-settrimpunctuationatstart))], [])
    HRESULT SetTrimPunctuationAtStart(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-geteffects))], [])
    HRESULT GetEffects(int* pValue, int* pMask);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-getproperty))], [])
    HRESULT GetProperty(int Type, int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-isequal2))], [])
    HRESULT IsEqual2(ITextPara2 pPara, int* pB);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-seteffects))], [])
    HRESULT SetEffects(int Value, int Mask);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-setproperty))], [])
    HRESULT SetProperty(int Type, int Value);
}

@GUID("c241f5e5-7206-11d8-a2c7-00a0d1d6c6b3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextstoryranges2))], [])
interface ITextStoryRanges2 : ITextStoryRanges
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstoryranges2-item2))], [])
    HRESULT Item2(int Index, ITextRange2* ppRange);
}

@GUID("c241f5f3-7206-11d8-a2c7-00a0d1d6c6b3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextstory))], [])
interface ITextStory : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstory-getactive))], [])
    HRESULT GetActive(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstory-setactive))], [])
    HRESULT SetActive(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstory-getdisplay))], [])
    HRESULT GetDisplay(IUnknown* ppDisplay);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstory-getindex))], [])
    HRESULT GetIndex(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstory-gettype))], [])
    HRESULT GetType(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstory-settype))], [])
    HRESULT SetType(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstory-getproperty))], [])
    HRESULT GetProperty(int Type, int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstory-getrange))], [])
    HRESULT GetRange(int cpActive, int cpAnchor, ITextRange2* ppRange);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstory-gettext))], [])
    HRESULT GetText(int Flags, BSTR* pbstr);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstory-setformattedtext))], [])
    HRESULT SetFormattedText(IUnknown pUnk);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstory-setproperty))], [])
    HRESULT SetProperty(int Type, int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstory-settext))], [])
    HRESULT SetText(int Flags, BSTR bstr);
}

@GUID("c241f5e7-7206-11d8-a2c7-00a0d1d6c6b3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextstrings))], [])
interface ITextStrings : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-item))], [])
    HRESULT Item(int Index, ITextRange2* ppRange);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-getcount))], [])
    HRESULT GetCount(int* pCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-add))], [])
    HRESULT Add(BSTR bstr);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-append))], [])
    HRESULT Append(ITextRange2 pRange, int iString);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-cat2))], [])
    HRESULT Cat2(int iString);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-cattop2))], [])
    HRESULT CatTop2(BSTR bstr);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-deleterange))], [])
    HRESULT DeleteRange(ITextRange2 pRange);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-encodefunction))], [])
    HRESULT EncodeFunction(int Type, int Align, int Char, int Char1, int Char2, int Count, int TeXStyle, int cCol, 
                           ITextRange2 pRange);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-getcch))], [])
    HRESULT GetCch(int iString, int* pcch);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-insertnullstr))], [])
    HRESULT InsertNullStr(int iString);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-moveboundary))], [])
    HRESULT MoveBoundary(int iString, int cch);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-prefixtop))], [])
    HRESULT PrefixTop(BSTR bstr);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-remove))], [])
    HRESULT Remove(int iString, int cString);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-setformattedtext))], [])
    HRESULT SetFormattedText(ITextRange2 pRangeD, ITextRange2 pRangeS);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-setopcp))], [])
    HRESULT SetOpCp(int iString, int cp);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-suffixtop))], [])
    HRESULT SuffixTop(BSTR bstr, ITextRange2 pRange);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-swap))], [])
    HRESULT Swap();
}

@GUID("c241f5ef-7206-11d8-a2c7-00a0d1d6c6b3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextrow))], [])
interface ITextRow : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getalignment))], [])
    HRESULT GetAlignment(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setalignment))], [])
    HRESULT SetAlignment(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getcellcount))], [])
    HRESULT GetCellCount(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setcellcount))], [])
    HRESULT SetCellCount(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getcellcountcache))], [])
    HRESULT GetCellCountCache(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setcellcountcache))], [])
    HRESULT SetCellCountCache(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getcellindex))], [])
    HRESULT GetCellIndex(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setcellindex))], [])
    HRESULT SetCellIndex(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getcellmargin))], [])
    HRESULT GetCellMargin(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setcellmargin))], [])
    HRESULT SetCellMargin(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getheight))], [])
    HRESULT GetHeight(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setheight))], [])
    HRESULT SetHeight(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getindent))], [])
    HRESULT GetIndent(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setindent))], [])
    HRESULT SetIndent(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getkeeptogether))], [])
    HRESULT GetKeepTogether(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setkeeptogether))], [])
    HRESULT SetKeepTogether(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getkeepwithnext))], [])
    HRESULT GetKeepWithNext(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setkeepwithnext))], [])
    HRESULT SetKeepWithNext(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getnestlevel))], [])
    HRESULT GetNestLevel(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getrtl))], [])
    HRESULT GetRTL(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setrtl))], [])
    HRESULT SetRTL(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getcellalignment))], [])
    HRESULT GetCellAlignment(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setcellalignment))], [])
    HRESULT SetCellAlignment(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getcellcolorback))], [])
    HRESULT GetCellColorBack(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setcellcolorback))], [])
    HRESULT SetCellColorBack(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getcellcolorfore))], [])
    HRESULT GetCellColorFore(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setcellcolorfore))], [])
    HRESULT SetCellColorFore(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getcellmergeflags))], [])
    HRESULT GetCellMergeFlags(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setcellmergeflags))], [])
    HRESULT SetCellMergeFlags(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getcellshading))], [])
    HRESULT GetCellShading(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setcellshading))], [])
    HRESULT SetCellShading(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getcellverticaltext))], [])
    HRESULT GetCellVerticalText(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setcellverticaltext))], [])
    HRESULT SetCellVerticalText(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getcellwidth))], [])
    HRESULT GetCellWidth(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setcellwidth))], [])
    HRESULT SetCellWidth(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getcellbordercolors))], [])
    HRESULT GetCellBorderColors(int* pcrLeft, int* pcrTop, int* pcrRight, int* pcrBottom);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getcellborderwidths))], [])
    HRESULT GetCellBorderWidths(int* pduLeft, int* pduTop, int* pduRight, int* pduBottom);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setcellbordercolors))], [])
    HRESULT SetCellBorderColors(int crLeft, int crTop, int crRight, int crBottom);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setcellborderwidths))], [])
    HRESULT SetCellBorderWidths(int duLeft, int duTop, int duRight, int duBottom);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-apply))], [])
    HRESULT Apply(int cRow, tomConstants Flags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-canchange))], [])
    HRESULT CanChange(int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getproperty))], [])
    HRESULT GetProperty(int Type, int* pValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-insert))], [])
    HRESULT Insert(int cRow);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-isequal))], [])
    HRESULT IsEqual(ITextRow pRow, int* pB);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-reset))], [])
    HRESULT Reset(int Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setproperty))], [])
    HRESULT SetProperty(int Type, int Value);
}

@GUID("c241f5f2-7206-11d8-a2c7-00a0d1d6c6b3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextdisplays))], [])
interface ITextDisplays : IDispatch
{
}

@GUID("01c25500-4268-11d1-883a-3c8b00c10000")
interface ITextDocument2Old : ITextDocument
{
    HRESULT AttachMsgFilter(IUnknown pFilter);
    HRESULT SetEffectColor(int Index, COLORREF cr);
    HRESULT GetEffectColor(int Index, COLORREF* pcr);
    HRESULT GetCaretType(int* pCaretType);
    HRESULT SetCaretType(int CaretType);
    HRESULT GetImmContext(long* pContext);
    HRESULT ReleaseImmContext(long Context);
    HRESULT GetPreferredFont(int cp, int CharRep, int Option, int CharRepCur, int curFontSize, BSTR* pbstr, 
                             int* pPitchAndFamily, int* pNewFontSize);
    HRESULT GetNotificationMode(int* pMode);
    HRESULT SetNotificationMode(int Mode);
    HRESULT GetClientRect(int Type, int* pLeft, int* pTop, int* pRight, int* pBottom);
    HRESULT GetSelection2(ITextSelection* ppSel);
    HRESULT GetWindow(int* phWnd);
    HRESULT GetFEFlags(int* pFlags);
    HRESULT UpdateWindow();
    HRESULT CheckTextLimit(int cch, int* pcch);
    HRESULT IMEInProgress(int Value);
    HRESULT SysBeep();
    HRESULT Update(int Mode);
    HRESULT Notify(int Notify);
    HRESULT GetDocumentFont(ITextFont* ppITextFont);
    HRESULT GetDocumentPara(ITextPara* ppITextPara);
    HRESULT GetCallManager(IUnknown* ppVoid);
    HRESULT ReleaseCallManager(IUnknown pVoid);
}


// GUIDs


const GUID IID_IRichEditOle         = GUIDOF!IRichEditOle;
const GUID IID_IRichEditOleCallback = GUIDOF!IRichEditOleCallback;
const GUID IID_ITextDisplays        = GUIDOF!ITextDisplays;
const GUID IID_ITextDocument        = GUIDOF!ITextDocument;
const GUID IID_ITextDocument2       = GUIDOF!ITextDocument2;
const GUID IID_ITextDocument2Old    = GUIDOF!ITextDocument2Old;
const GUID IID_ITextFont            = GUIDOF!ITextFont;
const GUID IID_ITextFont2           = GUIDOF!ITextFont2;
const GUID IID_ITextPara            = GUIDOF!ITextPara;
const GUID IID_ITextPara2           = GUIDOF!ITextPara2;
const GUID IID_ITextRange           = GUIDOF!ITextRange;
const GUID IID_ITextRange2          = GUIDOF!ITextRange2;
const GUID IID_ITextRow             = GUIDOF!ITextRow;
const GUID IID_ITextSelection       = GUIDOF!ITextSelection;
const GUID IID_ITextSelection2      = GUIDOF!ITextSelection2;
const GUID IID_ITextStory           = GUIDOF!ITextStory;
const GUID IID_ITextStoryRanges     = GUIDOF!ITextStoryRanges;
const GUID IID_ITextStoryRanges2    = GUIDOF!ITextStoryRanges2;
const GUID IID_ITextStrings         = GUIDOF!ITextStrings;
