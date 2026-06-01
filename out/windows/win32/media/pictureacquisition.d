// Written in the D programming language.

module windows.win32.media.pictureacquisition;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, BSTR, FILETIME, HRESULT, HWND,
                                                    PROPERTYKEY, PWSTR, SIZE;
public import windows.win32.graphics.gdi : HBITMAP;
public import windows.win32.system.com.com : IEnumString, IStream, IUnknown;
public import windows.win32.system.com.structuredstorage : PROPVARIANT;
public import windows.win32.ui.shell.propertiessystem : IPropertyStore;
public import windows.win32.ui.windowsandmessaging : HICON;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/ne-photoacquire-user_input_string_type
alias USER_INPUT_STRING_TYPE = int;
enum : int
{
    USER_INPUT_DEFAULT      = 0x00000000,
    USER_INPUT_PATH_ELEMENT = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/ne-photoacquire-error_advise_message_type
alias ERROR_ADVISE_MESSAGE_TYPE = int;
enum : int
{
    PHOTOACQUIRE_ERROR_SKIPRETRYCANCEL = 0x00000000,
    PHOTOACQUIRE_ERROR_RETRYCANCEL     = 0x00000001,
    PHOTOACQUIRE_ERROR_YESNO           = 0x00000002,
    PHOTOACQUIRE_ERROR_OK              = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/ne-photoacquire-error_advise_result
alias ERROR_ADVISE_RESULT = int;
enum : int
{
    PHOTOACQUIRE_RESULT_YES      = 0x00000000,
    PHOTOACQUIRE_RESULT_NO       = 0x00000001,
    PHOTOACQUIRE_RESULT_OK       = 0x00000002,
    PHOTOACQUIRE_RESULT_SKIP     = 0x00000003,
    PHOTOACQUIRE_RESULT_SKIP_ALL = 0x00000004,
    PHOTOACQUIRE_RESULT_RETRY    = 0x00000005,
    PHOTOACQUIRE_RESULT_ABORT    = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/ne-photoacquire-progress_dialog_image_type
alias PROGRESS_DIALOG_IMAGE_TYPE = int;
enum : int
{
    PROGRESS_DIALOG_ICON_SMALL       = 0x00000000,
    PROGRESS_DIALOG_ICON_LARGE       = 0x00000001,
    PROGRESS_DIALOG_ICON_THUMBNAIL   = 0x00000002,
    PROGRESS_DIALOG_BITMAP_THUMBNAIL = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/ne-photoacquire-progress_dialog_checkbox_id
alias PROGRESS_DIALOG_CHECKBOX_ID = int;
enum : int
{
    PROGRESS_DIALOG_CHECKBOX_ID_DEFAULT = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/ne-photoacquire-device_selection_device_type
alias DEVICE_SELECTION_DEVICE_TYPE = int;
enum : int
{
    DST_UNKNOWN_DEVICE = 0x00000000,
    DST_WPD_DEVICE     = 0x00000001,
    DST_WIA_DEVICE     = 0x00000002,
    DST_STI_DEVICE     = 0x00000003,
    DSF_TWAIN_DEVICE   = 0x00000004,
    DST_FS_DEVICE      = 0x00000005,
    DST_DV_DEVICE      = 0x00000006,
}

// Constants


enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({15872887, 31430, 19322, 132, 67, 52, 94, 115, 31, 165, 122}, 2))], [])*/PROPERTYKEY
{
    PKEY_PhotoAcquire_RelativePathname     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({15872887, 31430, 19322, 132, 67, 52, 94, 115, 31, 165, 122}, 2))], [])*/PROPERTYKEY(GUID("00F23377-7AC6-4B7A-8443-345E731FA57A"), 2),
    PKEY_PhotoAcquire_FinalFilename        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({15872887, 31430, 19322, 132, 67, 52, 94, 115, 31, 165, 122}, 2))], [])*/PROPERTYKEY(GUID("00F23377-7AC6-4B7A-8443-345E731FA57A"), 3),
    PKEY_PhotoAcquire_GroupTag             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({15872887, 31430, 19322, 132, 67, 52, 94, 115, 31, 165, 122}, 2))], [])*/PROPERTYKEY(GUID("00F23377-7AC6-4B7A-8443-345E731FA57A"), 4),
    PKEY_PhotoAcquire_TransferResult       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({15872887, 31430, 19322, 132, 67, 52, 94, 115, 31, 165, 122}, 2))], [])*/PROPERTYKEY(GUID("00F23377-7AC6-4B7A-8443-345E731FA57A"), 5),
    PKEY_PhotoAcquire_OriginalFilename     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({15872887, 31430, 19322, 132, 67, 52, 94, 115, 31, 165, 122}, 2))], [])*/PROPERTYKEY(GUID("00F23377-7AC6-4B7A-8443-345E731FA57A"), 6),
    PKEY_PhotoAcquire_CameraSequenceNumber = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({15872887, 31430, 19322, 132, 67, 52, 94, 115, 31, 165, 122}, 2))], [])*/PROPERTYKEY(GUID("00F23377-7AC6-4B7A-8443-345E731FA57A"), 7),
    PKEY_PhotoAcquire_IntermediateFile     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({15872887, 31430, 19322, 132, 67, 52, 94, 115, 31, 165, 122}, 2))], [])*/PROPERTYKEY(GUID("00F23377-7AC6-4B7A-8443-345E731FA57A"), 8),
    PKEY_PhotoAcquire_SkipImport           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({15872887, 31430, 19322, 132, 67, 52, 94, 115, 31, 165, 122}, 2))], [])*/PROPERTYKEY(GUID("00F23377-7AC6-4B7A-8443-345E731FA57A"), 9),
    PKEY_PhotoAcquire_DuplicateDetectionID = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({15872887, 31430, 19322, 132, 67, 52, 94, 115, 31, 165, 122}, 2))], [])*/PROPERTYKEY(GUID("00F23377-7AC6-4B7A-8443-345E731FA57A"), 10),
}

enum int PROGRESS_INDETERMINATE = 0xffffffff;
enum HRESULT PHOTOACQ_ERROR_RESTART_REQUIRED = HRESULT(0x8004a001);

enum : uint
{
    PHOTOACQ_RUN_DEFAULT       = 0x00000000U,
    PHOTOACQ_NO_GALLERY_LAUNCH = 0x00000001U,
}

enum : uint
{
    PHOTOACQ_DISABLE_AUTO_ROTATE      = 0x00000002U,
    PHOTOACQ_DISABLE_PLUGINS          = 0x00000004U,
    PHOTOACQ_DISABLE_GROUP_TAG_PROMPT = 0x00000008U,
    PHOTOACQ_DISABLE_DB_INTEGRATION   = 0x00000010U,
}

enum uint PHOTOACQ_DELETE_AFTER_ACQUIRE = 0x00000020U;
enum uint PHOTOACQ_DISABLE_DUPLICATE_DETECTION = 0x00000040U;
enum uint PHOTOACQ_ENABLE_THUMBNAIL_CACHING = 0x00000080U;

enum : uint
{
    PHOTOACQ_DISABLE_METADATA_WRITE     = 0x00000100U,
    PHOTOACQ_DISABLE_THUMBNAIL_PROGRESS = 0x00000200U,
    PHOTOACQ_DISABLE_SETTINGS_LINK      = 0x00000400U,
}

enum uint PHOTOACQ_ABORT_ON_SETTINGS_UPDATE = 0x00000800U;
enum uint PHOTOACQ_IMPORT_VIDEO_AS_MULTIPLE_FILES = 0x00001000U;
enum uint DSF_WPD_DEVICES = 0x00000001U;

enum : uint
{
    DSF_WIA_CAMERAS  = 0x00000002U,
    DSF_WIA_SCANNERS = 0x00000004U,
}

enum uint DSF_STI_DEVICES = 0x00000008U;
enum uint DSF_TWAIN_DEVICES = 0x00000010U;
enum uint DSF_FS_DEVICES = 0x00000020U;
enum uint DSF_DV_DEVICES = 0x00000040U;
enum uint DSF_ALL_DEVICES = 0x0000ffffU;
enum uint DSF_CPL_MODE = 0x00010000U;
enum uint DSF_SHOW_OFFLINE = 0x00020000U;

enum : uint
{
    PAPS_PRESAVE  = 0x00000000U,
    PAPS_POSTSAVE = 0x00000001U,
}

enum uint PAPS_CLEANUP = 0x00000002U;

// Interfaces

@GUID("00f26e02-e9f2-4a9f-9fdd-5a962fb26a98")
struct PhotoAcquire;

@GUID("00f20eb5-8fd6-4d9d-b75e-36801766c8f1")
struct PhotoAcquireAutoPlayDropTarget;

@GUID("00f2b433-44e4-4d88-b2b0-2698a0a91dba")
struct PhotoAcquireAutoPlayHWEventHandler;

@GUID("00f210a1-62f0-438b-9f7e-9618d72a1831")
struct PhotoAcquireOptionsDialog;

@GUID("00f24ca0-748f-4e8a-894f-0e0357c6799f")
struct PhotoProgressDialog;

@GUID("00f29a34-b8a1-482c-bcf8-3ac7b0fe8f62")
struct PhotoAcquireDeviceSelectionDialog;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nn-photoacquire-iphotoacquireitem
@GUID("00f21c97-28bf-4c02-b842-5e4e90139a30")
interface IPhotoAcquireItem : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireitem-getitemname
    HRESULT GetItemName(BSTR* pbstrItemName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireitem-getthumbnail
    HRESULT GetThumbnail(SIZE sizeThumbnail, HBITMAP* phbmpThumbnail);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireitem-getproperty
    HRESULT GetProperty(const(PROPERTYKEY)* key, PROPVARIANT* pv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireitem-setproperty
    HRESULT SetProperty(const(PROPERTYKEY)* key, const(PROPVARIANT)* pv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireitem-getstream
    HRESULT GetStream(IStream* ppStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireitem-candelete
    HRESULT CanDelete(BOOL* pfCanDelete);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireitem-delete
    HRESULT Delete();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireitem-getsubitemcount
    HRESULT GetSubItemCount(uint* pnCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireitem-getsubitemat
    HRESULT GetSubItemAt(uint nItemIndex, IPhotoAcquireItem* ppPhotoAcquireItem);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nn-photoacquire-iuserinputstring
@GUID("00f243a1-205b-45ba-ae26-abbc53aa7a6f")
interface IUserInputString : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iuserinputstring-getsubmitbuttontext
    HRESULT GetSubmitButtonText(BSTR* pbstrSubmitButtonText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iuserinputstring-getprompt
    HRESULT GetPrompt(BSTR* pbstrPromptTitle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iuserinputstring-getstringid
    HRESULT GetStringId(BSTR* pbstrStringId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iuserinputstring-getstringtype
    HRESULT GetStringType(USER_INPUT_STRING_TYPE* pnStringType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iuserinputstring-gettooltiptext
    HRESULT GetTooltipText(BSTR* pbstrTooltipText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iuserinputstring-getmaxlength
    HRESULT GetMaxLength(uint* pcchMaxLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iuserinputstring-getdefault
    HRESULT GetDefault(BSTR* pbstrDefault);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iuserinputstring-getmrucount
    HRESULT GetMruCount(uint* pnMruCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iuserinputstring-getmruentryat
    HRESULT GetMruEntryAt(uint nIndex, BSTR* pbstrMruEntry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iuserinputstring-getimage
    HRESULT GetImage(uint nSize, HBITMAP* phBitmap, HICON* phIcon);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nn-photoacquire-iphotoacquireprogresscb
@GUID("00f2ce1e-935e-4248-892c-130f32c45cb4")
interface IPhotoAcquireProgressCB : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireprogresscb-cancelled
    HRESULT Cancelled(BOOL* pfCancelled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireprogresscb-startenumeration
    HRESULT StartEnumeration(IPhotoAcquireSource pPhotoAcquireSource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireprogresscb-founditem
    HRESULT FoundItem(IPhotoAcquireItem pPhotoAcquireItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireprogresscb-endenumeration
    HRESULT EndEnumeration(HRESULT hr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireprogresscb-starttransfer
    HRESULT StartTransfer(IPhotoAcquireSource pPhotoAcquireSource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireprogresscb-startitemtransfer
    HRESULT StartItemTransfer(uint nItemIndex, IPhotoAcquireItem pPhotoAcquireItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireprogresscb-directorycreated
    HRESULT DirectoryCreated(const(PWSTR) pszDirectory);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireprogresscb-updatetransferpercent
    HRESULT UpdateTransferPercent(BOOL fOverall, uint nPercent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireprogresscb-enditemtransfer
    HRESULT EndItemTransfer(uint nItemIndex, IPhotoAcquireItem pPhotoAcquireItem, HRESULT hr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireprogresscb-endtransfer
    HRESULT EndTransfer(HRESULT hr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireprogresscb-startdelete
    HRESULT StartDelete(IPhotoAcquireSource pPhotoAcquireSource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireprogresscb-startitemdelete
    HRESULT StartItemDelete(uint nItemIndex, IPhotoAcquireItem pPhotoAcquireItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireprogresscb-updatedeletepercent
    HRESULT UpdateDeletePercent(uint nPercent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireprogresscb-enditemdelete
    HRESULT EndItemDelete(uint nItemIndex, IPhotoAcquireItem pPhotoAcquireItem, HRESULT hr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireprogresscb-enddelete
    HRESULT EndDelete(HRESULT hr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireprogresscb-endsession
    HRESULT EndSession(HRESULT hr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireprogresscb-getdeleteafteracquire
    HRESULT GetDeleteAfterAcquire(BOOL* pfDeleteAfterAcquire);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireprogresscb-erroradvise
    HRESULT ErrorAdvise(HRESULT hr, const(PWSTR) pszErrorMessage, ERROR_ADVISE_MESSAGE_TYPE nMessageType, 
                        ERROR_ADVISE_RESULT* pnErrorAdviseResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireprogresscb-getuserinput
    HRESULT GetUserInput(const(GUID)* riidType, IUnknown pUnknown, PROPVARIANT* pPropVarResult, 
                         const(PROPVARIANT)* pPropVarDefault);
}

@GUID("00f242d0-b206-4e7d-b4c1-4755bcbb9c9f")
interface IPhotoProgressActionCB : IUnknown
{
    HRESULT DoAction(HWND hWndParent);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nn-photoacquire-iphotoprogressdialog
@GUID("00f246f9-0750-4f08-9381-2cd8e906a4ae")
interface IPhotoProgressDialog : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoprogressdialog-create
    HRESULT Create(HWND hwndParent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoprogressdialog-getwindow
    HRESULT GetWindow(HWND* phwndProgressDialog);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoprogressdialog-destroy
    HRESULT Destroy();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoprogressdialog-settitle
    HRESULT SetTitle(const(PWSTR) pszTitle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoprogressdialog-showcheckbox
    HRESULT ShowCheckbox(PROGRESS_DIALOG_CHECKBOX_ID nCheckboxId, BOOL fShow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoprogressdialog-setcheckboxtext
    HRESULT SetCheckboxText(PROGRESS_DIALOG_CHECKBOX_ID nCheckboxId, const(PWSTR) pszCheckboxText);
    HRESULT SetCheckboxCheck(PROGRESS_DIALOG_CHECKBOX_ID nCheckboxId, BOOL fChecked);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoprogressdialog-setcheckboxtooltip
    HRESULT SetCheckboxTooltip(PROGRESS_DIALOG_CHECKBOX_ID nCheckboxId, const(PWSTR) pszCheckboxTooltipText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoprogressdialog-ischeckboxchecked
    HRESULT IsCheckboxChecked(PROGRESS_DIALOG_CHECKBOX_ID nCheckboxId, BOOL* pfChecked);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoprogressdialog-setcaption
    HRESULT SetCaption(const(PWSTR) pszTitle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoprogressdialog-setimage
    HRESULT SetImage(PROGRESS_DIALOG_IMAGE_TYPE nImageType, HICON hIcon, HBITMAP hBitmap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoprogressdialog-setpercentcomplete
    HRESULT SetPercentComplete(int nPercent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoprogressdialog-setprogresstext
    HRESULT SetProgressText(const(PWSTR) pszProgressText);
    HRESULT SetActionLinkCallback(IPhotoProgressActionCB pPhotoProgressActionCB);
    HRESULT SetActionLinkText(const(PWSTR) pszCaption);
    HRESULT ShowActionLink(BOOL fShow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoprogressdialog-iscancelled
    HRESULT IsCancelled(BOOL* pfCancelled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoprogressdialog-getuserinput
    HRESULT GetUserInput(const(GUID)* riidType, IUnknown pUnknown, PROPVARIANT* pPropVarResult, 
                         const(PROPVARIANT)* pPropVarDefault);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nn-photoacquire-iphotoacquiresource
@GUID("00f2c703-8613-4282-a53b-6ec59c5883ac")
interface IPhotoAcquireSource : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquiresource-getfriendlyname
    HRESULT GetFriendlyName(BSTR* pbstrFriendlyName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquiresource-getdeviceicons
    HRESULT GetDeviceIcons(uint nSize, HICON* phLargeIcon, HICON* phSmallIcon);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquiresource-initializeitemlist
    HRESULT InitializeItemList(BOOL fForceEnumeration, IPhotoAcquireProgressCB pPhotoAcquireProgressCB, 
                               uint* pnItemCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquiresource-getitemcount
    HRESULT GetItemCount(uint* pnItemCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquiresource-getitemat
    HRESULT GetItemAt(uint nIndex, IPhotoAcquireItem* ppPhotoAcquireItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquiresource-getphotoacquiresettings
    HRESULT GetPhotoAcquireSettings(IPhotoAcquireSettings* ppPhotoAcquireSettings);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquiresource-getdeviceid
    HRESULT GetDeviceId(BSTR* pbstrDeviceId);
    HRESULT BindToObject(const(GUID)* riid, void** ppv);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nn-photoacquire-iphotoacquire
@GUID("00f23353-e31b-4955-a8ad-ca5ebf31e2ce")
interface IPhotoAcquire : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquire-createphotosource
    HRESULT CreatePhotoSource(const(PWSTR) pszDevice, IPhotoAcquireSource* ppPhotoAcquireSource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquire-acquire
    HRESULT Acquire(IPhotoAcquireSource pPhotoAcquireSource, BOOL fShowProgress, HWND hWndParent, 
                    const(PWSTR) pszApplicationName, IPhotoAcquireProgressCB pPhotoAcquireProgressCB);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquire-enumresults
    HRESULT EnumResults(IEnumString* ppEnumFilePaths);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nn-photoacquire-iphotoacquiresettings
@GUID("00f2b868-dd67-487c-9553-049240767e91")
interface IPhotoAcquireSettings : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquiresettings-initializefromregistry
    HRESULT InitializeFromRegistry(const(PWSTR) pszRegistryKey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquiresettings-setflags
    HRESULT SetFlags(uint dwPhotoAcquireFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquiresettings-setoutputfilenametemplate
    HRESULT SetOutputFilenameTemplate(const(PWSTR) pszTemplate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquiresettings-setsequencepaddingwidth
    HRESULT SetSequencePaddingWidth(uint dwWidth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquiresettings-setsequencezeropadding
    HRESULT SetSequenceZeroPadding(BOOL fZeroPad);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquiresettings-setgrouptag
    HRESULT SetGroupTag(const(PWSTR) pszGroupTag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquiresettings-setacquisitiontime
    HRESULT SetAcquisitionTime(const(FILETIME)* pftAcquisitionTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquiresettings-getflags
    HRESULT GetFlags(uint* pdwPhotoAcquireFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquiresettings-getoutputfilenametemplate
    HRESULT GetOutputFilenameTemplate(BSTR* pbstrTemplate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquiresettings-getsequencepaddingwidth
    HRESULT GetSequencePaddingWidth(uint* pdwWidth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquiresettings-getsequencezeropadding
    HRESULT GetSequenceZeroPadding(BOOL* pfZeroPad);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquiresettings-getgrouptag
    HRESULT GetGroupTag(BSTR* pbstrGroupTag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquiresettings-getacquisitiontime
    HRESULT GetAcquisitionTime(FILETIME* pftAcquisitionTime);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nn-photoacquire-iphotoacquireoptionsdialog
@GUID("00f2b3ee-bf64-47ee-89f4-4dedd79643f2")
interface IPhotoAcquireOptionsDialog : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireoptionsdialog-initialize
    HRESULT Initialize(const(PWSTR) pszRegistryRoot);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireoptionsdialog-create
    HRESULT Create(HWND hWndParent, HWND* phWndDialog);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireoptionsdialog-destroy
    HRESULT Destroy();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireoptionsdialog-domodal
    HRESULT DoModal(HWND hWndParent, ptrdiff_t* ppnReturnCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireoptionsdialog-savedata
    HRESULT SaveData();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nn-photoacquire-iphotoacquiredeviceselectiondialog
@GUID("00f28837-55dd-4f37-aaf5-6855a9640467")
interface IPhotoAcquireDeviceSelectionDialog : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquiredeviceselectiondialog-settitle
    HRESULT SetTitle(const(PWSTR) pszTitle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquiredeviceselectiondialog-setsubmitbuttontext
    HRESULT SetSubmitButtonText(const(PWSTR) pszSubmitButtonText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquiredeviceselectiondialog-domodal
    HRESULT DoModal(HWND hWndParent, uint dwDeviceFlags, BSTR* pbstrDeviceId, 
                    DEVICE_SELECTION_DEVICE_TYPE* pnDeviceType);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nn-photoacquire-iphotoacquireplugin
@GUID("00f2dceb-ecb8-4f77-8e47-e7a987c83dd0")
interface IPhotoAcquirePlugin : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireplugin-initialize
    HRESULT Initialize(IPhotoAcquireSource pPhotoAcquireSource, IPhotoAcquireProgressCB pPhotoAcquireProgressCB);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireplugin-processitem
    HRESULT ProcessItem(uint dwAcquireStage, IPhotoAcquireItem pPhotoAcquireItem, IStream pOriginalItemStream, 
                        const(PWSTR) pszFinalFilename, IPropertyStore pPropertyStore);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireplugin-transfercomplete
    HRESULT TransferComplete(HRESULT hr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/photoacquire/nf-photoacquire-iphotoacquireplugin-displayconfiguredialog
    HRESULT DisplayConfigureDialog(HWND hWndParent);
}


// GUIDs

const GUID CLSID_PhotoAcquire                       = GUIDOF!PhotoAcquire;
const GUID CLSID_PhotoAcquireAutoPlayDropTarget     = GUIDOF!PhotoAcquireAutoPlayDropTarget;
const GUID CLSID_PhotoAcquireAutoPlayHWEventHandler = GUIDOF!PhotoAcquireAutoPlayHWEventHandler;
const GUID CLSID_PhotoAcquireDeviceSelectionDialog  = GUIDOF!PhotoAcquireDeviceSelectionDialog;
const GUID CLSID_PhotoAcquireOptionsDialog          = GUIDOF!PhotoAcquireOptionsDialog;
const GUID CLSID_PhotoProgressDialog                = GUIDOF!PhotoProgressDialog;

const GUID IID_IPhotoAcquire                      = GUIDOF!IPhotoAcquire;
const GUID IID_IPhotoAcquireDeviceSelectionDialog = GUIDOF!IPhotoAcquireDeviceSelectionDialog;
const GUID IID_IPhotoAcquireItem                  = GUIDOF!IPhotoAcquireItem;
const GUID IID_IPhotoAcquireOptionsDialog         = GUIDOF!IPhotoAcquireOptionsDialog;
const GUID IID_IPhotoAcquirePlugin                = GUIDOF!IPhotoAcquirePlugin;
const GUID IID_IPhotoAcquireProgressCB            = GUIDOF!IPhotoAcquireProgressCB;
const GUID IID_IPhotoAcquireSettings              = GUIDOF!IPhotoAcquireSettings;
const GUID IID_IPhotoAcquireSource                = GUIDOF!IPhotoAcquireSource;
const GUID IID_IPhotoProgressActionCB             = GUIDOF!IPhotoProgressActionCB;
const GUID IID_IPhotoProgressDialog               = GUIDOF!IPhotoProgressDialog;
const GUID IID_IUserInputString                   = GUIDOF!IUserInputString;
