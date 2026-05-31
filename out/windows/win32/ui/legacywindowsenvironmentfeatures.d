// Written in the D programming language.

module windows.win32.ui.legacywindowsenvironmentfeatures;

public import windows.core;
public import windows.win32.foundation : HRESULT, HWND, PWSTR;
public import windows.win32.system.com : IMoniker, IUnknown;
public import windows.win32.system.com.structuredstorage : IStorage;
public import windows.win32.system.ole : IOleObject;
public import windows.win32.system.registry : HKEY;

extern(Windows) @nogc nothrow:


// Enums

alias EMPTY_VOLUME_CACHE_FLAGS = uint;
enum : uint
{
    EVCF_HASSETTINGS          = 0x00000001,
    EVCF_ENABLEBYDEFAULT      = 0x00000002,
    EVCF_REMOVEFROMLIST       = 0x00000004,
    EVCF_ENABLEBYDEFAULT_AUTO = 0x00000008,
    EVCF_DONTSHOWIFZERO       = 0x00000010,
    EVCF_SETTINGSMODE         = 0x00000020,
    EVCF_OUTOFDISKSPACE       = 0x00000040,
    EVCF_USERCONSENTOBTAINED  = 0x00000080,
    EVCF_SYSTEMAUTORUN        = 0x00000100,
}
alias RECONCILEF = int;
enum : int
{
    RECONCILEF_MAYBOTHERUSER        = 0x00000001,
    RECONCILEF_FEEDBACKWINDOWVALID  = 0x00000002,
    RECONCILEF_NORESIDUESOK         = 0x00000004,
    RECONCILEF_OMITSELFRESIDUE      = 0x00000008,
    RECONCILEF_RESUMERECONCILIATION = 0x00000010,
    RECONCILEF_YOUMAYDOTHEUPDATES   = 0x00000020,
    RECONCILEF_ONLYYOUWERECHANGED   = 0x00000040,
    ALL_RECONCILE_FLAGS             = 0x0000007f,
}

// Constants


enum uint EVCCBF_LASTNOTIFICATION = 0x00000001;
enum uint STATEBITS_FLAT = 0x00000001;
enum HRESULT REC_S_IDIDTHEUPDATES = HRESULT(0x00041000);

enum : HRESULT
{
    REC_S_NOTCOMPLETE             = HRESULT(0x00041001),
    REC_S_NOTCOMPLETEBUTPROPAGATE = HRESULT(0x00041002),
}

enum : HRESULT
{
    REC_E_ABORTED    = HRESULT(0x80041000),
    REC_E_NOCALLBACK = HRESULT(0x80041001),
    REC_E_NORESIDUES = HRESULT(0x80041002),
}

enum HRESULT REC_E_TOODIFFERENT = HRESULT(0x80041003);
enum HRESULT REC_E_INEEDTODOTHEUPDATES = HRESULT(0x80041004);

// Interfaces

@GUID("6e793361-73c6-11d0-8469-00aa00442901")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/emptyvc/nn-emptyvc-iemptyvolumecachecallback))], [])
interface IEmptyVolumeCacheCallBack : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/emptyvc/nf-emptyvc-iemptyvolumecachecallback-scanprogress))], [])
    HRESULT ScanProgress(ulong dwlSpaceUsed, uint dwFlags, const(PWSTR) pcwszStatus);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/emptyvc/nf-emptyvc-iemptyvolumecachecallback-purgeprogress))], [])
    HRESULT PurgeProgress(ulong dwlSpaceFreed, ulong dwlSpaceToFree, uint dwFlags, const(PWSTR) pcwszStatus);
}

@GUID("8fce5227-04da-11d1-a004-00805f8abe06")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/emptyvc/nn-emptyvc-iemptyvolumecache))], [])
interface IEmptyVolumeCache : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/emptyvc/nf-emptyvc-iemptyvolumecache-initialize))], [])
    HRESULT Initialize(HKEY hkRegKey, const(PWSTR) pcwszVolume, PWSTR* ppwszDisplayName, PWSTR* ppwszDescription, 
                       EMPTY_VOLUME_CACHE_FLAGS* pdwFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/emptyvc/nf-emptyvc-iemptyvolumecache-getspaceused))], [])
    HRESULT GetSpaceUsed(ulong* pdwlSpaceUsed, IEmptyVolumeCacheCallBack picb);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/emptyvc/nf-emptyvc-iemptyvolumecache-purge))], [])
    HRESULT Purge(ulong dwlSpaceToFree, IEmptyVolumeCacheCallBack picb);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/emptyvc/nf-emptyvc-iemptyvolumecache-showproperties))], [])
    HRESULT ShowProperties(HWND hwnd);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/emptyvc/nf-emptyvc-iemptyvolumecache-deactivate))], [])
    HRESULT Deactivate(EMPTY_VOLUME_CACHE_FLAGS* pdwFlags);
}

@GUID("02b7e3ba-4db3-11d2-b2d9-00c04f8eec8c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/emptyvc/nn-emptyvc-iemptyvolumecache2))], [])
interface IEmptyVolumeCache2 : IEmptyVolumeCache
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/emptyvc/nf-emptyvc-iemptyvolumecache2-initializeex))], [])
    HRESULT InitializeEx(HKEY hkRegKey, const(PWSTR) pcwszVolume, const(PWSTR) pcwszKeyName, 
                         PWSTR* ppwszDisplayName, PWSTR* ppwszDescription, PWSTR* ppwszBtnText, 
                         EMPTY_VOLUME_CACHE_FLAGS* pdwFlags);
}

@GUID("99180161-da16-101a-935c-444553540000")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/lwef/ireconcileinitiator))], [])
interface IReconcileInitiator : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/reconcil/nf-reconcil-ireconcileinitiator-setabortcallback))], [])
    HRESULT SetAbortCallback(IUnknown punkForAbort);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/reconcil/nf-reconcil-ireconcileinitiator-setprogressfeedback))], [])
    HRESULT SetProgressFeedback(uint ulProgress, uint ulProgressMax);
}

@GUID("99180162-da16-101a-935c-444553540000")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/reconcil/nn-reconcil-ireconcilableobject))], [])
interface IReconcilableObject : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/reconcil/nf-reconcil-ireconcilableobject-reconcile))], [])
    HRESULT Reconcile(IReconcileInitiator pInitiator, uint dwFlags, HWND hwndOwner, HWND hwndProgressFeedback, 
                      uint ulcInput, IMoniker* rgpmkOtherInput, int* plOutIndex, IStorage pstgNewResidues, 
                      /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/reconcil/nf-reconcil-ireconcilableobject-getprogressfeedbackmaxestimate))], [])
    HRESULT GetProgressFeedbackMaxEstimate(uint* pulProgressMax);
}

@GUID("99180164-da16-101a-935c-444553540000")
interface IBriefcaseInitiator : IUnknown
{
    HRESULT IsMonikerInBriefcase(IMoniker pmk);
}

@GUID("52502ee0-ec80-11d0-89ab-00c04fc2972d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shlobj/nn-shlobj-iactivedesktopp))], [])
interface IActiveDesktopP : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-iactivedesktopp-setsafemode))], [])
    HRESULT SetSafeMode(uint dwFlags);
    HRESULT EnsureUpdateHTML();
    HRESULT SetScheme(const(PWSTR) pwszSchemeName, uint dwFlags);
    HRESULT GetScheme(PWSTR pwszSchemeName, uint* pdwcchBuffer, uint dwFlags);
}

@GUID("b22754e2-4574-11d1-9888-006097deacf9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shlobj/nn-shlobj-iadesktopp2))], [])
interface IADesktopP2 : IUnknown
{
    HRESULT ReReadWallpaper();
    HRESULT GetADObjectFlags(uint* pdwFlags, uint dwMask);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-iadesktopp2-updatealldesktopsubscriptions))], [])
    HRESULT UpdateAllDesktopSubscriptions();
    HRESULT MakeDynamicChanges(IOleObject pOleObj);
}


// GUIDs


const GUID IID_IADesktopP2               = GUIDOF!IADesktopP2;
const GUID IID_IActiveDesktopP           = GUIDOF!IActiveDesktopP;
const GUID IID_IBriefcaseInitiator       = GUIDOF!IBriefcaseInitiator;
const GUID IID_IEmptyVolumeCache         = GUIDOF!IEmptyVolumeCache;
const GUID IID_IEmptyVolumeCache2        = GUIDOF!IEmptyVolumeCache2;
const GUID IID_IEmptyVolumeCacheCallBack = GUIDOF!IEmptyVolumeCacheCallBack;
const GUID IID_IReconcilableObject       = GUIDOF!IReconcilableObject;
const GUID IID_IReconcileInitiator       = GUIDOF!IReconcileInitiator;
