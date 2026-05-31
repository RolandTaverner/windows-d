// Written in the D programming language.

module windows.win32.ui.ribbon;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : HINSTANCE, HRESULT, HWND, PROPERTYKEY, PWSTR;
public import windows.win32.graphics.gdi : HBITMAP;
public import windows.win32.system.com : IStream, IUnknown;
public import windows.win32.system.com.structuredstorage : PROPVARIANT;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/ne-uiribbon-ui_contextavailability))], [])
alias UI_CONTEXTAVAILABILITY = int;
enum : int
{
    UI_CONTEXTAVAILABILITY_NOTAVAILABLE = 0x00000000,
    UI_CONTEXTAVAILABILITY_AVAILABLE    = 0x00000001,
    UI_CONTEXTAVAILABILITY_ACTIVE       = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/ne-uiribbon-ui_fontproperties))], [])
alias UI_FONTPROPERTIES = int;
enum : int
{
    UI_FONTPROPERTIES_NOTAVAILABLE = 0x00000000,
    UI_FONTPROPERTIES_NOTSET       = 0x00000001,
    UI_FONTPROPERTIES_SET          = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/ne-uiribbon-ui_fontverticalposition))], [])
alias UI_FONTVERTICALPOSITION = int;
enum : int
{
    UI_FONTVERTICALPOSITION_NOTAVAILABLE = 0x00000000,
    UI_FONTVERTICALPOSITION_NOTSET       = 0x00000001,
    UI_FONTVERTICALPOSITION_SUPERSCRIPT  = 0x00000002,
    UI_FONTVERTICALPOSITION_SUBSCRIPT    = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/ne-uiribbon-ui_fontunderline))], [])
alias UI_FONTUNDERLINE = int;
enum : int
{
    UI_FONTUNDERLINE_NOTAVAILABLE = 0x00000000,
    UI_FONTUNDERLINE_NOTSET       = 0x00000001,
    UI_FONTUNDERLINE_SET          = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/ne-uiribbon-ui_fontdeltasize))], [])
alias UI_FONTDELTASIZE = int;
enum : int
{
    UI_FONTDELTASIZE_GROW   = 0x00000000,
    UI_FONTDELTASIZE_SHRINK = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/ne-uiribbon-ui_controldock))], [])
alias UI_CONTROLDOCK = int;
enum : int
{
    UI_CONTROLDOCK_TOP    = 0x00000001,
    UI_CONTROLDOCK_BOTTOM = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/ne-uiribbon-ui_swatchcolortype))], [])
alias UI_SWATCHCOLORTYPE = int;
enum : int
{
    UI_SWATCHCOLORTYPE_NOCOLOR   = 0x00000000,
    UI_SWATCHCOLORTYPE_AUTOMATIC = 0x00000001,
    UI_SWATCHCOLORTYPE_RGB       = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/ne-uiribbon-ui_swatchcolormode))], [])
alias UI_SWATCHCOLORMODE = int;
enum : int
{
    UI_SWATCHCOLORMODE_NORMAL     = 0x00000000,
    UI_SWATCHCOLORMODE_MONOCHROME = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/ne-uiribbon-ui_eventtype))], [])
alias UI_EVENTTYPE = int;
enum : int
{
    UI_EVENTTYPE_ApplicationMenuOpened   = 0x00000000,
    UI_EVENTTYPE_RibbonMinimized         = 0x00000001,
    UI_EVENTTYPE_RibbonExpanded          = 0x00000002,
    UI_EVENTTYPE_ApplicationModeSwitched = 0x00000003,
    UI_EVENTTYPE_TabActivated            = 0x00000004,
    UI_EVENTTYPE_MenuOpened              = 0x00000005,
    UI_EVENTTYPE_CommandExecuted         = 0x00000006,
    UI_EVENTTYPE_TooltipShown            = 0x00000007,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/ne-uiribbon-ui_eventlocation))], [])
alias UI_EVENTLOCATION = int;
enum : int
{
    UI_EVENTLOCATION_Ribbon          = 0x00000000,
    UI_EVENTLOCATION_QAT             = 0x00000001,
    UI_EVENTLOCATION_ApplicationMenu = 0x00000002,
    UI_EVENTLOCATION_ContextPopup    = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/ne-uiribbon-ui_invalidations))], [])
alias UI_INVALIDATIONS = int;
enum : int
{
    UI_INVALIDATIONS_STATE         = 0x00000001,
    UI_INVALIDATIONS_VALUE         = 0x00000002,
    UI_INVALIDATIONS_PROPERTY      = 0x00000004,
    UI_INVALIDATIONS_ALLPROPERTIES = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/ne-uiribbon-ui_collectionchange))], [])
alias UI_COLLECTIONCHANGE = int;
enum : int
{
    UI_COLLECTIONCHANGE_INSERT  = 0x00000000,
    UI_COLLECTIONCHANGE_REMOVE  = 0x00000001,
    UI_COLLECTIONCHANGE_REPLACE = 0x00000002,
    UI_COLLECTIONCHANGE_RESET   = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/ne-uiribbon-ui_executionverb))], [])
alias UI_EXECUTIONVERB = int;
enum : int
{
    UI_EXECUTIONVERB_EXECUTE       = 0x00000000,
    UI_EXECUTIONVERB_PREVIEW       = 0x00000001,
    UI_EXECUTIONVERB_CANCELPREVIEW = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/ne-uiribbon-ui_commandtype))], [])
alias UI_COMMANDTYPE = int;
enum : int
{
    UI_COMMANDTYPE_UNKNOWN           = 0x00000000,
    UI_COMMANDTYPE_GROUP             = 0x00000001,
    UI_COMMANDTYPE_ACTION            = 0x00000002,
    UI_COMMANDTYPE_ANCHOR            = 0x00000003,
    UI_COMMANDTYPE_CONTEXT           = 0x00000004,
    UI_COMMANDTYPE_COLLECTION        = 0x00000005,
    UI_COMMANDTYPE_COMMANDCOLLECTION = 0x00000006,
    UI_COMMANDTYPE_DECIMAL           = 0x00000007,
    UI_COMMANDTYPE_BOOLEAN           = 0x00000008,
    UI_COMMANDTYPE_FONT              = 0x00000009,
    UI_COMMANDTYPE_RECENTITEMS       = 0x0000000a,
    UI_COMMANDTYPE_COLORANCHOR       = 0x0000000b,
    UI_COMMANDTYPE_COLORCOLLECTION   = 0x0000000c,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/ne-uiribbon-ui_viewtype))], [])
alias UI_VIEWTYPE = int;
enum : int
{
    UI_VIEWTYPE_RIBBON = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/ne-uiribbon-ui_viewverb))], [])
alias UI_VIEWVERB = int;
enum : int
{
    UI_VIEWVERB_CREATE  = 0x00000000,
    UI_VIEWVERB_DESTROY = 0x00000001,
    UI_VIEWVERB_SIZE    = 0x00000002,
    UI_VIEWVERB_ERROR   = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/ne-uiribbon-ui_ownership))], [])
alias UI_OWNERSHIP = int;
enum : int
{
    UI_OWNERSHIP_TRANSFER = 0x00000000,
    UI_OWNERSHIP_COPY     = 0x00000001,
}

// Constants


enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/windowsribbon/windowsribbon-ui-all-commands))], [])*/uint UI_ALL_COMMANDS = 0x00000000;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/windowsribbon/windowsribbon-ui-collection-invalidindex))], [])*/uint UI_COLLECTION_INVALIDINDEX = 0xffffffff;
enum GUID LIBID_UIRibbon = GUID("942f35c2-e83b-45ef-b085-ac295dd63d5b");

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/ns-uiribbon-ui_eventparams_command))], [])
struct UI_EVENTPARAMS_COMMAND
{
    uint             CommandID;
    const(PWSTR)     CommandName;
    uint             ParentCommandID;
    const(PWSTR)     ParentCommandName;
    uint             SelectionIndex;
    UI_EVENTLOCATION Location;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/ns-uiribbon-ui_eventparams))], [])
struct UI_EVENTPARAMS
{
    UI_EVENTTYPE        EventType;
    _Anonymous_e__Union Anonymous;
}

// Interfaces

@GUID("926749fa-2615-4987-8845-c33e65f2b957")
struct UIRibbonFramework;

@GUID("0f7434b6-59b6-4250-999e-d168d6ae4293")
struct UIRibbonImageFromBitmapFactory;

@GUID("c205bb48-5b1c-4219-a106-15bd0a5f24e2")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nn-uiribbon-iuisimplepropertyset))], [])
interface IUISimplePropertySet : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuisimplepropertyset-getvalue))], [])
    HRESULT GetValue(const(PROPERTYKEY)* key, PROPVARIANT* value);
}

@GUID("803982ab-370a-4f7e-a9e7-8784036a6e26")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nn-uiribbon-iuiribbon))], [])
interface IUIRibbon : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuiribbon-getheight))], [])
    HRESULT GetHeight(uint* cy);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuiribbon-loadsettingsfromstream))], [])
    HRESULT LoadSettingsFromStream(IStream pStream);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuiribbon-savesettingstostream))], [])
    HRESULT SaveSettingsToStream(IStream pStream);
}

@GUID("f4f0385d-6872-43a8-ad09-4c339cb3f5c5")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nn-uiribbon-iuiframework))], [])
interface IUIFramework : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuiframework-initialize))], [])
    HRESULT Initialize(HWND frameWnd, IUIApplication application);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuiframework-destroy))], [])
    HRESULT Destroy();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuiframework-loadui))], [])
    HRESULT LoadUI(HINSTANCE instance, const(PWSTR) resourceName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuiframework-getview))], [])
    HRESULT GetView(uint viewId, const(GUID)* riid, void** ppv);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuiframework-getuicommandproperty))], [])
    HRESULT GetUICommandProperty(uint commandId, const(PROPERTYKEY)* key, PROPVARIANT* value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuiframework-setuicommandproperty))], [])
    HRESULT SetUICommandProperty(uint commandId, const(PROPERTYKEY)* key, const(PROPVARIANT)* value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuiframework-invalidateuicommand))], [])
    HRESULT InvalidateUICommand(uint commandId, UI_INVALIDATIONS flags, const(PROPERTYKEY)* key);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuiframework-flushpendinginvalidations))], [])
    HRESULT FlushPendingInvalidations();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuiframework-setmodes))], [])
    HRESULT SetModes(int iModes);
}

@GUID("ec3e1034-dbf4-41a1-95d5-03e0f1026e05")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nn-uiribbon-iuieventlogger))], [])
interface IUIEventLogger : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuieventlogger-onuievent))], [])
    void OnUIEvent(UI_EVENTPARAMS* pEventParams);
}

@GUID("3be6ea7f-9a9b-4198-9368-9b0f923bd534")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nn-uiribbon-iuieventingmanager))], [])
interface IUIEventingManager : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuieventingmanager-seteventlogger))], [])
    HRESULT SetEventLogger(IUIEventLogger eventLogger);
}

@GUID("eea11f37-7c46-437c-8e55-b52122b29293")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nn-uiribbon-iuicontextualui))], [])
interface IUIContextualUI : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuicontextualui-showatlocation))], [])
    HRESULT ShowAtLocation(int x, int y);
}

@GUID("df4f45bf-6f9d-4dd7-9d68-d8f9cd18c4db")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nn-uiribbon-iuicollection))], [])
interface IUICollection : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuicollection-getcount))], [])
    HRESULT GetCount(uint* count);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuicollection-getitem))], [])
    HRESULT GetItem(uint index, IUnknown* item);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuicollection-add))], [])
    HRESULT Add(IUnknown item);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuicollection-insert))], [])
    HRESULT Insert(uint index, IUnknown item);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuicollection-removeat))], [])
    HRESULT RemoveAt(uint index);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuicollection-replace))], [])
    HRESULT Replace(uint indexReplaced, IUnknown itemReplaceWith);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuicollection-clear))], [])
    HRESULT Clear();
}

@GUID("6502ae91-a14d-44b5-bbd0-62aacc581d52")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nn-uiribbon-iuicollectionchangedevent))], [])
interface IUICollectionChangedEvent : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuicollectionchangedevent-onchanged))], [])
    HRESULT OnChanged(UI_COLLECTIONCHANGE action, uint oldIndex, IUnknown oldItem, uint newIndex, IUnknown newItem);
}

@GUID("75ae0a2d-dc03-4c9f-8883-069660d0beb6")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nn-uiribbon-iuicommandhandler))], [])
interface IUICommandHandler : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuicommandhandler-execute))], [])
    HRESULT Execute(uint commandId, UI_EXECUTIONVERB verb, const(PROPERTYKEY)* key, 
                    const(PROPVARIANT)* currentValue, IUISimplePropertySet commandExecutionProperties);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuicommandhandler-updateproperty))], [])
    HRESULT UpdateProperty(uint commandId, const(PROPERTYKEY)* key, const(PROPVARIANT)* currentValue, 
                           PROPVARIANT* newValue);
}

@GUID("d428903c-729a-491d-910d-682a08ff2522")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nn-uiribbon-iuiapplication))], [])
interface IUIApplication : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuiapplication-onviewchanged))], [])
    HRESULT OnViewChanged(uint viewId, UI_VIEWTYPE typeID, IUnknown view, UI_VIEWVERB verb, int uReasonCode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuiapplication-oncreateuicommand))], [])
    HRESULT OnCreateUICommand(uint commandId, UI_COMMANDTYPE typeID, IUICommandHandler* commandHandler);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuiapplication-ondestroyuicommand))], [])
    HRESULT OnDestroyUICommand(uint commandId, UI_COMMANDTYPE typeID, IUICommandHandler commandHandler);
}

@GUID("23c8c838-4de6-436b-ab01-5554bb7c30dd")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nn-uiribbon-iuiimage))], [])
interface IUIImage : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuiimage-getbitmap))], [])
    HRESULT GetBitmap(HBITMAP* bitmap);
}

@GUID("18aba7f3-4c1c-4ba2-bf6c-f5c3326fa816")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nn-uiribbon-iuiimagefrombitmap))], [])
interface IUIImageFromBitmap : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uiribbon/nf-uiribbon-iuiimagefrombitmap-createimage))], [])
    HRESULT CreateImage(HBITMAP bitmap, UI_OWNERSHIP options, IUIImage* image);
}


// GUIDs

const GUID CLSID_UIRibbonFramework              = GUIDOF!UIRibbonFramework;
const GUID CLSID_UIRibbonImageFromBitmapFactory = GUIDOF!UIRibbonImageFromBitmapFactory;

const GUID IID_IUIApplication            = GUIDOF!IUIApplication;
const GUID IID_IUICollection             = GUIDOF!IUICollection;
const GUID IID_IUICollectionChangedEvent = GUIDOF!IUICollectionChangedEvent;
const GUID IID_IUICommandHandler         = GUIDOF!IUICommandHandler;
const GUID IID_IUIContextualUI           = GUIDOF!IUIContextualUI;
const GUID IID_IUIEventLogger            = GUIDOF!IUIEventLogger;
const GUID IID_IUIEventingManager        = GUIDOF!IUIEventingManager;
const GUID IID_IUIFramework              = GUIDOF!IUIFramework;
const GUID IID_IUIImage                  = GUIDOF!IUIImage;
const GUID IID_IUIImageFromBitmap        = GUIDOF!IUIImageFromBitmap;
const GUID IID_IUIRibbon                 = GUIDOF!IUIRibbon;
const GUID IID_IUISimplePropertySet      = GUIDOF!IUISimplePropertySet;
