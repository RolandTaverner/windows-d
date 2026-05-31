// Written in the D programming language.

module windows.win32.system.windowssync;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOL, HANDLE, HRESULT, HWND, PROPERTYKEY,
                                                    PWSTR;
public import windows.win32.system.com.com : IUnknown;
public import windows.win32.ui.shell.propertiessystem : IPropertyStore;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/ne-winsync-sync_provider_role
alias SYNC_PROVIDER_ROLE = int;
enum : int
{
    SPR_SOURCE      = 0x00000000,
    SPR_DESTINATION = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/ne-winsync-conflict_resolution_policy
alias CONFLICT_RESOLUTION_POLICY = int;
enum : int
{
    CRP_NONE                      = 0x00000000,
    CRP_DESTINATION_PROVIDER_WINS = 0x00000001,
    CRP_SOURCE_PROVIDER_WINS      = 0x00000002,
    CRP_LAST                      = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/ne-winsync-sync_progress_stage
alias SYNC_PROGRESS_STAGE = int;
enum : int
{
    SPS_CHANGE_DETECTION   = 0x00000000,
    SPS_CHANGE_ENUMERATION = 0x00000001,
    SPS_CHANGE_APPLICATION = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/ne-winsync-sync_full_enumeration_action
alias SYNC_FULL_ENUMERATION_ACTION = int;
enum : int
{
    SFEA_FULL_ENUMERATION = 0x00000000,
    SFEA_PARTIAL_SYNC     = 0x00000001,
    SFEA_ABORT            = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/ne-winsync-sync_resolve_action
alias SYNC_RESOLVE_ACTION = int;
enum : int
{
    SRA_DEFER                       = 0x00000000,
    SRA_ACCEPT_DESTINATION_PROVIDER = 0x00000001,
    SRA_ACCEPT_SOURCE_PROVIDER      = 0x00000002,
    SRA_MERGE                       = 0x00000003,
    SRA_TRANSFER_AND_DEFER          = 0x00000004,
    SRA_LAST                        = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/ne-winsync-sync_statistics
alias SYNC_STATISTICS = int;
enum : int
{
    SYNC_STATISTICS_RANGE_COUNT = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/ne-winsync-sync_serialization_version
alias SYNC_SERIALIZATION_VERSION = int;
enum : int
{
    SYNC_SERIALIZATION_VERSION_V1 = 0x00000001,
    SYNC_SERIALIZATION_VERSION_V2 = 0x00000004,
    SYNC_SERIALIZATION_VERSION_V3 = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/ne-winsync-filtering_type
alias FILTERING_TYPE = int;
enum : int
{
    FT_CURRENT_ITEMS_ONLY                             = 0x00000000,
    FT_CURRENT_ITEMS_AND_VERSIONS_FOR_MOVED_OUT_ITEMS = 0x00000001,
}

alias SYNC_CONSTRAINT_RESOLVE_ACTION = int;
enum : int
{
    SCRA_DEFER                       = 0x00000000,
    SCRA_ACCEPT_DESTINATION_PROVIDER = 0x00000001,
    SCRA_ACCEPT_SOURCE_PROVIDER      = 0x00000002,
    SCRA_TRANSFER_AND_DEFER          = 0x00000003,
    SCRA_MERGE                       = 0x00000004,
    SCRA_RENAME_SOURCE               = 0x00000005,
    SCRA_RENAME_DESTINATION          = 0x00000006,
}

alias CONSTRAINT_CONFLICT_REASON = int;
enum : int
{
    CCR_OTHER     = 0x00000000,
    CCR_COLLISION = 0x00000001,
    CCR_NOPARENT  = 0x00000002,
    CCR_IDENTITY  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/ne-winsync-knowledge_cookie_comparison_result
alias KNOWLEDGE_COOKIE_COMPARISON_RESULT = int;
enum : int
{
    KCCR_COOKIE_KNOWLEDGE_EQUAL          = 0x00000000,
    KCCR_COOKIE_KNOWLEDGE_CONTAINED      = 0x00000001,
    KCCR_COOKIE_KNOWLEDGE_CONTAINS       = 0x00000002,
    KCCR_COOKIE_KNOWLEDGE_NOT_COMPARABLE = 0x00000003,
}

alias FILTER_COMBINATION_TYPE = int;
enum : int
{
    FCT_INTERSECTION = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/ne-syncregistration-sync_registration_event
alias SYNC_REGISTRATION_EVENT = int;
enum : int
{
    SRE_PROVIDER_ADDED         = 0x00000000,
    SRE_PROVIDER_REMOVED       = 0x00000001,
    SRE_PROVIDER_UPDATED       = 0x00000002,
    SRE_PROVIDER_STATE_CHANGED = 0x00000003,
    SRE_CONFIGUI_ADDED         = 0x00000004,
    SRE_CONFIGUI_REMOVED       = 0x00000005,
    SRE_CONFIGUI_UPDATED       = 0x00000006,
}

// Constants


enum : uint
{
    SYNC_VERSION_FLAG_FROM_FEED = 0x00000001U,
    SYNC_VERSION_FLAG_HAS_BY    = 0x00000002U,
}

enum uint SYNC_SERIALIZE_REPLICA_KEY_MAP = 0x00000001U;

enum : uint
{
    SYNC_FILTER_INFO_FLAG_ITEM_LIST        = 0x00000001U,
    SYNC_FILTER_INFO_FLAG_CHANGE_UNIT_LIST = 0x00000002U,
    SYNC_FILTER_INFO_FLAG_CUSTOM           = 0x00000004U,
    SYNC_FILTER_INFO_COMBINED              = 0x00000008U,
}

enum : uint
{
    SYNC_CHANGE_FLAG_DELETED        = 0x00000001U,
    SYNC_CHANGE_FLAG_DOES_NOT_EXIST = 0x00000002U,
    SYNC_CHANGE_FLAG_GHOST          = 0x00000004U,
}

enum uint SCC_DEFAULT = 0x00000000U;
enum uint SCC_CAN_CREATE_WITHOUT_UI = 0x00000001U;
enum uint SCC_CAN_MODIFY_WITHOUT_UI = 0x00000002U;
enum uint SCC_CREATE_NOT_SUPPORTED = 0x00000004U;
enum uint SCC_MODIFY_NOT_SUPPORTED = 0x00000008U;
enum uint SPC_DEFAULT = 0x00000000U;

enum : uint
{
    SYNC_PROVIDER_STATE_ENABLED                  = 0x00000001U,
    SYNC_PROVIDER_STATE_DIRTY                    = 0x00000002U,
    SYNC_PROVIDER_CONFIGURATION_VERSION          = 0x00000001U,
    SYNC_PROVIDER_CONFIGUI_CONFIGURATION_VERSION = 0x00000001U,
}

enum uint SYNC_32_BIT_SUPPORTED = 0x00000001U;
enum uint SYNC_64_BIT_SUPPORTED = 0x00000002U;

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2216140385, 24822, 19484, 136, 237, 241, 197, 49, 179, 43, 218}, 2))], [])*/PROPERTYKEY
{
    PKEY_PROVIDER_INSTANCEID             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2216140385, 24822, 19484, 136, 237, 241, 197, 49, 179, 43, 218}, 2))], [])*/PROPERTYKEY(GUID("84179E61-60F6-4C1C-88ED-F1C531B32BDA"), 2),
    PKEY_PROVIDER_CLSID                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2216140385, 24822, 19484, 136, 237, 241, 197, 49, 179, 43, 218}, 2))], [])*/PROPERTYKEY(GUID("84179E61-60F6-4C1C-88ED-F1C531B32BDA"), 3),
    PKEY_PROVIDER_CONFIGUI               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2216140385, 24822, 19484, 136, 237, 241, 197, 49, 179, 43, 218}, 2))], [])*/PROPERTYKEY(GUID("84179E61-60F6-4C1C-88ED-F1C531B32BDA"), 4),
    PKEY_PROVIDER_CONTENTTYPE            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2216140385, 24822, 19484, 136, 237, 241, 197, 49, 179, 43, 218}, 2))], [])*/PROPERTYKEY(GUID("84179E61-60F6-4C1C-88ED-F1C531B32BDA"), 5),
    PKEY_PROVIDER_CAPABILITIES           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2216140385, 24822, 19484, 136, 237, 241, 197, 49, 179, 43, 218}, 2))], [])*/PROPERTYKEY(GUID("84179E61-60F6-4C1C-88ED-F1C531B32BDA"), 6),
    PKEY_PROVIDER_SUPPORTED_ARCHITECTURE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2216140385, 24822, 19484, 136, 237, 241, 197, 49, 179, 43, 218}, 2))], [])*/PROPERTYKEY(GUID("84179E61-60F6-4C1C-88ED-F1C531B32BDA"), 7),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2216140385, 24822, 19484, 136, 237, 241, 197, 49, 179, 43, 218}, 8))], [])*/PROPERTYKEY
{
    PKEY_PROVIDER_NAME        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2216140385, 24822, 19484, 136, 237, 241, 197, 49, 179, 43, 218}, 8))], [])*/PROPERTYKEY(GUID("84179E61-60F6-4C1C-88ED-F1C531B32BDA"), 8),
    PKEY_PROVIDER_DESCRIPTION = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2216140385, 24822, 19484, 136, 237, 241, 197, 49, 179, 43, 218}, 8))], [])*/PROPERTYKEY(GUID("84179E61-60F6-4C1C-88ED-F1C531B32BDA"), 9),
    PKEY_PROVIDER_TOOLTIPS    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2216140385, 24822, 19484, 136, 237, 241, 197, 49, 179, 43, 218}, 8))], [])*/PROPERTYKEY(GUID("84179E61-60F6-4C1C-88ED-F1C531B32BDA"), 10),
    PKEY_PROVIDER_ICON        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2216140385, 24822, 19484, 136, 237, 241, 197, 49, 179, 43, 218}, 8))], [])*/PROPERTYKEY(GUID("84179E61-60F6-4C1C-88ED-F1C531B32BDA"), 11),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1430988010, 59619, 17850, 147, 82, 223, 181, 97, 225, 113, 228}, 2))], [])*/PROPERTYKEY
{
    PKEY_CONFIGUI_INSTANCEID             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1430988010, 59619, 17850, 147, 82, 223, 181, 97, 225, 113, 228}, 2))], [])*/PROPERTYKEY(GUID("554B24EA-E8E3-45BA-9352-DFB561E171E4"), 2),
    PKEY_CONFIGUI_CLSID                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1430988010, 59619, 17850, 147, 82, 223, 181, 97, 225, 113, 228}, 2))], [])*/PROPERTYKEY(GUID("554B24EA-E8E3-45BA-9352-DFB561E171E4"), 3),
    PKEY_CONFIGUI_CONTENTTYPE            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1430988010, 59619, 17850, 147, 82, 223, 181, 97, 225, 113, 228}, 2))], [])*/PROPERTYKEY(GUID("554B24EA-E8E3-45BA-9352-DFB561E171E4"), 4),
    PKEY_CONFIGUI_CAPABILITIES           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1430988010, 59619, 17850, 147, 82, 223, 181, 97, 225, 113, 228}, 2))], [])*/PROPERTYKEY(GUID("554B24EA-E8E3-45BA-9352-DFB561E171E4"), 5),
    PKEY_CONFIGUI_SUPPORTED_ARCHITECTURE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1430988010, 59619, 17850, 147, 82, 223, 181, 97, 225, 113, 228}, 2))], [])*/PROPERTYKEY(GUID("554B24EA-E8E3-45BA-9352-DFB561E171E4"), 6),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1430988010, 59619, 17850, 147, 82, 223, 181, 97, 225, 113, 228}, 7))], [])*/PROPERTYKEY
{
    PKEY_CONFIGUI_IS_GLOBAL     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1430988010, 59619, 17850, 147, 82, 223, 181, 97, 225, 113, 228}, 7))], [])*/PROPERTYKEY(GUID("554B24EA-E8E3-45BA-9352-DFB561E171E4"), 7),
    PKEY_CONFIGUI_NAME          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1430988010, 59619, 17850, 147, 82, 223, 181, 97, 225, 113, 228}, 7))], [])*/PROPERTYKEY(GUID("554B24EA-E8E3-45BA-9352-DFB561E171E4"), 8),
    PKEY_CONFIGUI_DESCRIPTION   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1430988010, 59619, 17850, 147, 82, 223, 181, 97, 225, 113, 228}, 7))], [])*/PROPERTYKEY(GUID("554B24EA-E8E3-45BA-9352-DFB561E171E4"), 9),
    PKEY_CONFIGUI_TOOLTIPS      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1430988010, 59619, 17850, 147, 82, 223, 181, 97, 225, 113, 228}, 7))], [])*/PROPERTYKEY(GUID("554B24EA-E8E3-45BA-9352-DFB561E171E4"), 10),
    PKEY_CONFIGUI_ICON          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1430988010, 59619, 17850, 147, 82, 223, 181, 97, 225, 113, 228}, 7))], [])*/PROPERTYKEY(GUID("554B24EA-E8E3-45BA-9352-DFB561E171E4"), 11),
    PKEY_CONFIGUI_MENUITEM_NOUI = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1430988010, 59619, 17850, 147, 82, 223, 181, 97, 225, 113, 228}, 7))], [])*/PROPERTYKEY(GUID("554B24EA-E8E3-45BA-9352-DFB561E171E4"), 12),
    PKEY_CONFIGUI_MENUITEM      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1430988010, 59619, 17850, 147, 82, 223, 181, 97, 225, 113, 228}, 7))], [])*/PROPERTYKEY(GUID("554B24EA-E8E3-45BA-9352-DFB561E171E4"), 13),
}

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/ns-winsync-id_parameter_pair
struct ID_PARAMETER_PAIR
{
    BOOL   fIsVariable;
    ushort cbIdSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/ns-winsync-id_parameters
struct ID_PARAMETERS
{
    uint              dwSize;
    ID_PARAMETER_PAIR replicaId;
    ID_PARAMETER_PAIR itemId;
    ID_PARAMETER_PAIR changeUnitId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/ns-winsync-sync_session_statistics
struct SYNC_SESSION_STATISTICS
{
    uint dwChangesApplied;
    uint dwChangesFailed;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/ns-winsync-sync_version
struct SYNC_VERSION
{
    uint  dwLastUpdatingReplicaKey;
    ulong ullTickCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/ns-winsync-sync_range
struct SYNC_RANGE
{
    ubyte* pbClosedLowerBound;
    ubyte* pbClosedUpperBound;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/ns-winsync-sync_time
struct SYNC_TIME
{
    uint dwDate;
    uint dwTime;
}

struct SYNC_FILTER_CHANGE
{
    BOOL         fMoveIn;
    SYNC_VERSION moveVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/ns-syncregistration-syncproviderconfiguration
struct SyncProviderConfiguration
{
    uint dwVersion;
    GUID guidInstanceId;
    GUID clsidProvider;
    GUID guidConfigUIInstanceId;
    GUID guidContentType;
    uint dwCapabilities;
    uint dwSupportedArchitecture;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/ns-syncregistration-syncproviderconfiguiconfiguration
struct SyncProviderConfigUIConfiguration
{
    uint dwVersion;
    GUID guidInstanceId;
    GUID clsidConfigUI;
    GUID guidContentType;
    uint dwCapabilities;
    uint dwSupportedArchitecture;
    BOOL fIsGlobal;
}

// Interfaces

@GUID("f82b4ef1-93a9-4dde-8015-f7950a1a6e31")
struct SyncProviderRegistration;

@GUID("e71c4250-adf8-4a07-8fae-5669596909c1")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-iclockvectorelement
interface IClockVectorElement : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-iclockvectorelement-getreplicakey
    HRESULT GetReplicaKey(uint* pdwReplicaKey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-iclockvectorelement-gettickcount
    HRESULT GetTickCount(ulong* pullTickCount);
}

@GUID("a40b46d2-e97b-4156-b6da-991f501b0f05")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-ifeedclockvectorelement
interface IFeedClockVectorElement : IClockVectorElement
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ifeedclockvectorelement-getsynctime
    HRESULT GetSyncTime(SYNC_TIME* pSyncTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ifeedclockvectorelement-getflags
    HRESULT GetFlags(ubyte* pbFlags);
}

@GUID("14b2274a-8698-4cc6-9333-f89bd1d47bc4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-iclockvector
interface IClockVector : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-iclockvector-getclockvectorelements
    HRESULT GetClockVectorElements(const(GUID)* riid, void** ppiEnumClockVector);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-iclockvector-getclockvectorelementcount
    HRESULT GetClockVectorElementCount(uint* pdwCount);
}

@GUID("8d1d98d1-9fb8-4ec9-a553-54dd924e0f67")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-ifeedclockvector
interface IFeedClockVector : IClockVector
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ifeedclockvector-getupdatecount
    HRESULT GetUpdateCount(uint* pdwUpdateCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ifeedclockvector-isnoconflictsspecified
    HRESULT IsNoConflictsSpecified(BOOL* pfIsNoConflictsSpecified);
}

@GUID("525844db-2837-4799-9e80-81a66e02220c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-ienumclockvector
interface IEnumClockVector : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ienumclockvector-next
    HRESULT Next(uint cClockVectorElements, IClockVectorElement* ppiClockVectorElements, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ienumclockvector-skip
    HRESULT Skip(uint cSyncVersions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ienumclockvector-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ienumclockvector-clone
    HRESULT Clone(IEnumClockVector* ppiEnum);
}

@GUID("550f763d-146a-48f6-abeb-6c88c7f70514")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-ienumfeedclockvector
interface IEnumFeedClockVector : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ienumfeedclockvector-next
    HRESULT Next(uint cClockVectorElements, IFeedClockVectorElement* ppiClockVectorElements, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ienumfeedclockvector-skip
    HRESULT Skip(uint cSyncVersions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ienumfeedclockvector-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ienumfeedclockvector-clone
    HRESULT Clone(IEnumFeedClockVector* ppiEnum);
}

@GUID("613b2ab5-b304-47d9-9c31-ce6c54401a15")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-icorefragment
interface ICoreFragment : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-icorefragment-nextcolumn
    HRESULT NextColumn(ubyte* pChangeUnitId, uint* pChangeUnitIdSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-icorefragment-nextrange
    HRESULT NextRange(ubyte* pItemId, uint* pItemIdSize, IClockVector* piClockVector);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-icorefragment-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-icorefragment-getcolumncount
    HRESULT GetColumnCount(uint* pColumnCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-icorefragment-getrangecount
    HRESULT GetRangeCount(uint* pRangeCount);
}

@GUID("f7fcc5fd-ae26-4679-ba16-96aac583c134")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-icorefragmentinspector
interface ICoreFragmentInspector : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-icorefragmentinspector-nextcorefragments
    HRESULT NextCoreFragments(uint requestedCount, ICoreFragment* ppiCoreFragments, uint* pFetchedCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-icorefragmentinspector-reset
    HRESULT Reset();
}

@GUID("75ae8777-6848-49f7-956c-a3a92f5096e8")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-irangeexception
interface IRangeException : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-irangeexception-getclosedrangestart
    HRESULT GetClosedRangeStart(ubyte* pbClosedRangeStart, uint* pcbIdSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-irangeexception-getclosedrangeend
    HRESULT GetClosedRangeEnd(ubyte* pbClosedRangeEnd, uint* pcbIdSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-irangeexception-getclockvector
    HRESULT GetClockVector(const(GUID)* riid, void** ppUnk);
}

@GUID("0944439f-ddb1-4176-b703-046ff22a2386")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-ienumrangeexceptions
interface IEnumRangeExceptions : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ienumrangeexceptions-next
    HRESULT Next(uint cExceptions, IRangeException* ppRangeException, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ienumrangeexceptions-skip
    HRESULT Skip(uint cExceptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ienumrangeexceptions-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ienumrangeexceptions-clone
    HRESULT Clone(IEnumRangeExceptions* ppEnum);
}

@GUID("892fb9b0-7c55-4a18-9316-fdf449569b64")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-isingleitemexception
interface ISingleItemException : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isingleitemexception-getitemid
    HRESULT GetItemId(ubyte* pbItemId, uint* pcbIdSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isingleitemexception-getclockvector
    HRESULT GetClockVector(const(GUID)* riid, void** ppUnk);
}

@GUID("e563381c-1b4d-4c66-9796-c86faccdcd40")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-ienumsingleitemexceptions
interface IEnumSingleItemExceptions : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ienumsingleitemexceptions-next
    HRESULT Next(uint cExceptions, ISingleItemException* ppSingleItemException, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ienumsingleitemexceptions-skip
    HRESULT Skip(uint cExceptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ienumsingleitemexceptions-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ienumsingleitemexceptions-clone
    HRESULT Clone(IEnumSingleItemExceptions* ppEnum);
}

@GUID("0cd7ee7c-fec0-4021-99ee-f0e5348f2a5f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-ichangeunitexception
interface IChangeUnitException : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ichangeunitexception-getitemid
    HRESULT GetItemId(ubyte* pbItemId, uint* pcbIdSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ichangeunitexception-getchangeunitid
    HRESULT GetChangeUnitId(ubyte* pbChangeUnitId, uint* pcbIdSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ichangeunitexception-getclockvector
    HRESULT GetClockVector(const(GUID)* riid, void** ppUnk);
}

@GUID("3074e802-9319-4420-be21-1022e2e21da8")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-ienumchangeunitexceptions
interface IEnumChangeUnitExceptions : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ienumchangeunitexceptions-next
    HRESULT Next(uint cExceptions, IChangeUnitException* ppChangeUnitException, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ienumchangeunitexceptions-skip
    HRESULT Skip(uint cExceptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ienumchangeunitexceptions-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ienumchangeunitexceptions-clone
    HRESULT Clone(IEnumChangeUnitExceptions* ppEnum);
}

@GUID("2209f4fc-fd10-4ff0-84a8-f0a1982e440e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-ireplicakeymap
interface IReplicaKeyMap : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ireplicakeymap-lookupreplicakey
    HRESULT LookupReplicaKey(const(ubyte)* pbReplicaId, uint* pdwReplicaKey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ireplicakeymap-lookupreplicaid
    HRESULT LookupReplicaId(uint dwReplicaKey, ubyte* pbReplicaId, uint* pcbIdSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ireplicakeymap-serialize
    HRESULT Serialize(ubyte* pbReplicaKeyMap, uint* pcbReplicaKeyMap);
}

@GUID("ded10970-ec85-4115-b52c-4405845642a5")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-iconstructreplicakeymap
interface IConstructReplicaKeyMap : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-iconstructreplicakeymap-findoraddreplica
    HRESULT FindOrAddReplica(const(ubyte)* pbReplicaId, uint* pdwReplicaKey);
}

@GUID("615bbb53-c945-4203-bf4b-2cb65919a0aa")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-isyncknowledge
interface ISyncKnowledge : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge-getownerreplicaid
    HRESULT GetOwnerReplicaId(ubyte* pbReplicaId, uint* pcbIdSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge-serialize
    HRESULT Serialize(BOOL fSerializeReplicaKeyMap, ubyte* pbKnowledge, uint* pcbKnowledge);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge-setlocaltickcount
    HRESULT SetLocalTickCount(ulong ullTickCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge-containschange
    HRESULT ContainsChange(const(ubyte)* pbVersionOwnerReplicaId, const(ubyte)* pgidItemId, 
                           const(SYNC_VERSION)* pSyncVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge-containschangeunit
    HRESULT ContainsChangeUnit(const(ubyte)* pbVersionOwnerReplicaId, const(ubyte)* pbItemId, 
                               const(ubyte)* pbChangeUnitId, const(SYNC_VERSION)* pSyncVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge-getscopevector
    HRESULT GetScopeVector(const(GUID)* riid, void** ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge-getreplicakeymap
    HRESULT GetReplicaKeyMap(IReplicaKeyMap* ppReplicaKeyMap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge-clone
    HRESULT Clone(ISyncKnowledge* ppClonedKnowledge);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge-convertversion
    HRESULT ConvertVersion(ISyncKnowledge pKnowledgeIn, const(ubyte)* pbCurrentOwnerId, 
                           const(SYNC_VERSION)* pVersionIn, ubyte* pbNewOwnerId, uint* pcbIdSize, 
                           SYNC_VERSION* pVersionOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge-mapremotetolocal
    HRESULT MapRemoteToLocal(ISyncKnowledge pRemoteKnowledge, ISyncKnowledge* ppMappedKnowledge);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge-union
    HRESULT Union(ISyncKnowledge pKnowledge);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge-projectontoitem
    HRESULT ProjectOntoItem(const(ubyte)* pbItemId, ISyncKnowledge* ppKnowledgeOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge-projectontochangeunit
    HRESULT ProjectOntoChangeUnit(const(ubyte)* pbItemId, const(ubyte)* pbChangeUnitId, 
                                  ISyncKnowledge* ppKnowledgeOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge-projectontorange
    HRESULT ProjectOntoRange(const(SYNC_RANGE)* psrngSyncRange, ISyncKnowledge* ppKnowledgeOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge-excludeitem
    HRESULT ExcludeItem(const(ubyte)* pbItemId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge-excludechangeunit
    HRESULT ExcludeChangeUnit(const(ubyte)* pbItemId, const(ubyte)* pbChangeUnitId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge-containsknowledge
    HRESULT ContainsKnowledge(ISyncKnowledge pKnowledge);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge-findmintickcountforreplica
    HRESULT FindMinTickCountForReplica(const(ubyte)* pbReplicaId, ulong* pullReplicaTickCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge-getrangeexceptions
    HRESULT GetRangeExceptions(const(GUID)* riid, void** ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge-getsingleitemexceptions
    HRESULT GetSingleItemExceptions(const(GUID)* riid, void** ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge-getchangeunitexceptions
    HRESULT GetChangeUnitExceptions(const(GUID)* riid, void** ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge-findclockvectorforitem
    HRESULT FindClockVectorForItem(const(ubyte)* pbItemId, const(GUID)* riid, void** ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge-findclockvectorforchangeunit
    HRESULT FindClockVectorForChangeUnit(const(ubyte)* pbItemId, const(ubyte)* pbChangeUnitId, const(GUID)* riid, 
                                         void** ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge-getversion
    HRESULT GetVersion(uint* pdwVersion);
}

@GUID("456e0f96-6036-452b-9f9d-bcc4b4a85db2")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-iforgottenknowledge
interface IForgottenKnowledge : ISyncKnowledge
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-iforgottenknowledge-forgettoversion
    HRESULT ForgetToVersion(ISyncKnowledge pKnowledge, const(SYNC_VERSION)* pVersion);
}

@GUID("ed0addc0-3b4b-46a1-9a45-45661d2114c8")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-isyncknowledge2
interface ISyncKnowledge2 : ISyncKnowledge
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge2-getidparameters
    HRESULT GetIdParameters(ID_PARAMETERS* pIdParameters);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge2-projectontocolumnset
    HRESULT ProjectOntoColumnSet(const(ubyte)** ppColumns, uint count, ISyncKnowledge2* ppiKnowledgeOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge2-serializewithoptions
    HRESULT SerializeWithOptions(SYNC_SERIALIZATION_VERSION targetFormatVersion, uint dwFlags, ubyte* pbBuffer, 
                                 uint* pdwSerializedSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge2-getlowestuncontainedid
    HRESULT GetLowestUncontainedId(ISyncKnowledge2 piSyncKnowledge, ubyte* pbItemId, uint* pcbItemIdSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge2-getinspector
    HRESULT GetInspector(const(GUID)* riid, void** ppiInspector);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge2-getminimumsupportedversion
    HRESULT GetMinimumSupportedVersion(SYNC_SERIALIZATION_VERSION* pVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge2-getstatistics
    HRESULT GetStatistics(SYNC_STATISTICS which, uint* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge2-containsknowledgeforitem
    HRESULT ContainsKnowledgeForItem(ISyncKnowledge pKnowledge, const(ubyte)* pbItemId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge2-containsknowledgeforchangeunit
    HRESULT ContainsKnowledgeForChangeUnit(ISyncKnowledge pKnowledge, const(ubyte)* pbItemId, 
                                           const(ubyte)* pbChangeUnitId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge2-projectontoknowledgewithprerequisite
    HRESULT ProjectOntoKnowledgeWithPrerequisite(ISyncKnowledge pPrerequisiteKnowledge, 
                                                 ISyncKnowledge pTemplateKnowledge, 
                                                 ISyncKnowledge* ppProjectedKnowledge);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge2-complement
    HRESULT Complement(ISyncKnowledge pSyncKnowledge, ISyncKnowledge* ppComplementedKnowledge);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge2-intersectswithknowledge
    HRESULT IntersectsWithKnowledge(ISyncKnowledge pSyncKnowledge);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge2-getknowledgecookie
    HRESULT GetKnowledgeCookie(IUnknown* ppKnowledgeCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncknowledge2-comparetoknowledgecookie
    HRESULT CompareToKnowledgeCookie(IUnknown pKnowledgeCookie, KNOWLEDGE_COOKIE_COMPARISON_RESULT* pResult);
}

@GUID("b37c4a0a-4b7d-4c2d-9711-3b00d119b1c8")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-irecoverableerrordata
interface IRecoverableErrorData : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-irecoverableerrordata-initialize
    HRESULT Initialize(const(PWSTR) pcszItemDisplayName, const(PWSTR) pcszErrorDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-irecoverableerrordata-getitemdisplayname
    HRESULT GetItemDisplayName(PWSTR pszItemDisplayName, uint* pcchItemDisplayName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-irecoverableerrordata-geterrordescription
    HRESULT GetErrorDescription(PWSTR pszErrorDescription, uint* pcchErrorDescription);
}

@GUID("0f5625e8-0a7b-45ee-9637-1ce13645909e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-irecoverableerror
interface IRecoverableError : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-irecoverableerror-getstage
    HRESULT GetStage(SYNC_PROGRESS_STAGE* pStage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-irecoverableerror-getprovider
    HRESULT GetProvider(SYNC_PROVIDER_ROLE* pProviderRole);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-irecoverableerror-getchangewithrecoverableerror
    HRESULT GetChangeWithRecoverableError(ISyncChange* ppChangeWithRecoverableError);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-irecoverableerror-getrecoverableerrordataforchange
    HRESULT GetRecoverableErrorDataForChange(HRESULT* phrError, IRecoverableErrorData* ppErrorData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-irecoverableerror-getrecoverableerrordataforchangeunit
    HRESULT GetRecoverableErrorDataForChangeUnit(ISyncChangeUnit pChangeUnit, HRESULT* phrError, 
                                                 IRecoverableErrorData* ppErrorData);
}

@GUID("014ebf97-9f20-4f7a-bdd4-25979c77c002")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-ichangeconflict
interface IChangeConflict : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ichangeconflict-getdestinationproviderconflictingchange
    HRESULT GetDestinationProviderConflictingChange(ISyncChange* ppConflictingChange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ichangeconflict-getsourceproviderconflictingchange
    HRESULT GetSourceProviderConflictingChange(ISyncChange* ppConflictingChange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ichangeconflict-getdestinationproviderconflictingdata
    HRESULT GetDestinationProviderConflictingData(IUnknown* ppConflictingData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ichangeconflict-getsourceproviderconflictingdata
    HRESULT GetSourceProviderConflictingData(IUnknown* ppConflictingData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ichangeconflict-getresolveactionforchange
    HRESULT GetResolveActionForChange(SYNC_RESOLVE_ACTION* pResolveAction);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ichangeconflict-setresolveactionforchange
    HRESULT SetResolveActionForChange(SYNC_RESOLVE_ACTION resolveAction);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ichangeconflict-getresolveactionforchangeunit
    HRESULT GetResolveActionForChangeUnit(ISyncChangeUnit pChangeUnit, SYNC_RESOLVE_ACTION* pResolveAction);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ichangeconflict-setresolveactionforchangeunit
    HRESULT SetResolveActionForChangeUnit(ISyncChangeUnit pChangeUnit, SYNC_RESOLVE_ACTION resolveAction);
}

@GUID("00d2302e-1cf8-4835-b85f-b7ca4f799e0a")
interface IConstraintConflict : IUnknown
{
    HRESULT GetDestinationProviderConflictingChange(ISyncChange* ppConflictingChange);
    HRESULT GetSourceProviderConflictingChange(ISyncChange* ppConflictingChange);
    HRESULT GetDestinationProviderOriginalChange(ISyncChange* ppOriginalChange);
    HRESULT GetDestinationProviderConflictingData(IUnknown* ppConflictingData);
    HRESULT GetSourceProviderConflictingData(IUnknown* ppConflictingData);
    HRESULT GetDestinationProviderOriginalData(IUnknown* ppOriginalData);
    HRESULT GetConstraintResolveActionForChange(SYNC_CONSTRAINT_RESOLVE_ACTION* pConstraintResolveAction);
    HRESULT SetConstraintResolveActionForChange(SYNC_CONSTRAINT_RESOLVE_ACTION constraintResolveAction);
    HRESULT GetConstraintResolveActionForChangeUnit(ISyncChangeUnit pChangeUnit, 
                                                    SYNC_CONSTRAINT_RESOLVE_ACTION* pConstraintResolveAction);
    HRESULT SetConstraintResolveActionForChangeUnit(ISyncChangeUnit pChangeUnit, 
                                                    SYNC_CONSTRAINT_RESOLVE_ACTION constraintResolveAction);
    HRESULT GetConstraintConflictReason(CONSTRAINT_CONFLICT_REASON* pConstraintConflictReason);
    HRESULT IsTemporary();
}

@GUID("0599797f-5ed9-485c-ae36-0c5d1bf2e7a5")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-isynccallback
interface ISyncCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isynccallback-onprogress
    HRESULT OnProgress(SYNC_PROVIDER_ROLE provider, SYNC_PROGRESS_STAGE syncStage, uint dwCompletedWork, 
                       uint dwTotalWork);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isynccallback-onchange
    HRESULT OnChange(ISyncChange pSyncChange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isynccallback-onconflict
    HRESULT OnConflict(IChangeConflict pConflict);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isynccallback-onfullenumerationneeded
    HRESULT OnFullEnumerationNeeded(SYNC_FULL_ENUMERATION_ACTION* pFullEnumerationAction);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isynccallback-onrecoverableerror
    HRESULT OnRecoverableError(IRecoverableError pRecoverableError);
}

@GUID("47ce84af-7442-4ead-8630-12015e030ad7")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-isynccallback2
interface ISyncCallback2 : ISyncCallback
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isynccallback2-onchangeapplied
    HRESULT OnChangeApplied(uint dwChangesApplied, uint dwChangesFailed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isynccallback2-onchangefailed
    HRESULT OnChangeFailed(uint dwChangesApplied, uint dwChangesFailed);
}

@GUID("8af3843e-75b3-438c-bb51-6f020d70d3cb")
interface ISyncConstraintCallback : IUnknown
{
    HRESULT OnConstraintConflict(IConstraintConflict pConflict);
}

@GUID("8f657056-2bce-4a17-8c68-c7bb7898b56f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-isyncprovider
interface ISyncProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncprovider-getidparameters
    HRESULT GetIdParameters(ID_PARAMETERS* pIdParameters);
}

@GUID("b8a940fe-9f01-483b-9434-c37d361225d9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-isyncsessionstate
interface ISyncSessionState : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncsessionstate-iscanceled
    HRESULT IsCanceled(BOOL* pfIsCanceled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncsessionstate-getinfoforchangeapplication
    HRESULT GetInfoForChangeApplication(ubyte* pbChangeApplierInfo, uint* pcbChangeApplierInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncsessionstate-loadinfofromchangeapplication
    HRESULT LoadInfoFromChangeApplication(const(ubyte)* pbChangeApplierInfo, uint cbChangeApplierInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncsessionstate-getforgottenknowledgerecoveryrangestart
    HRESULT GetForgottenKnowledgeRecoveryRangeStart(ubyte* pbRangeStart, uint* pcbRangeStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncsessionstate-getforgottenknowledgerecoveryrangeend
    HRESULT GetForgottenKnowledgeRecoveryRangeEnd(ubyte* pbRangeEnd, uint* pcbRangeEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncsessionstate-setforgottenknowledgerecoveryrange
    HRESULT SetForgottenKnowledgeRecoveryRange(const(SYNC_RANGE)* pRange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncsessionstate-onprogress
    HRESULT OnProgress(SYNC_PROVIDER_ROLE provider, SYNC_PROGRESS_STAGE syncStage, uint dwCompletedWork, 
                       uint dwTotalWork);
}

@GUID("326c6810-790a-409b-b741-6999388761eb")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-isyncsessionextendederrorinfo
interface ISyncSessionExtendedErrorInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncsessionextendederrorinfo-getsyncproviderwitherror
    HRESULT GetSyncProviderWithError(ISyncProvider* ppProviderWithError);
}

@GUID("9e37cfa3-9e38-4c61-9ca3-ffe810b45ca2")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-isyncsessionstate2
interface ISyncSessionState2 : ISyncSessionState
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncsessionstate2-setproviderwitherror
    HRESULT SetProviderWithError(BOOL fSelf);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncsessionstate2-getsessionerrorstatus
    HRESULT GetSessionErrorStatus(HRESULT* phrSessionError);
}

@GUID("794eaaf8-3f2e-47e6-9728-17e6fcf94cb7")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-isyncfilterinfo
interface ISyncFilterInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncfilterinfo-serialize
    HRESULT Serialize(ubyte* pbBuffer, uint* pcbBuffer);
}

@GUID("19b394ba-e3d0-468c-934d-321968b2ab34")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-isyncfilterinfo2
interface ISyncFilterInfo2 : ISyncFilterInfo
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncfilterinfo2-getflags
    HRESULT GetFlags(uint* pdwFlags);
}

@GUID("f2837671-0bdf-43fa-b502-232375fb50c2")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-ichangeunitlistfilterinfo
interface IChangeUnitListFilterInfo : ISyncFilterInfo
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ichangeunitlistfilterinfo-initialize
    HRESULT Initialize(const(ubyte)** ppbChangeUnitIds, uint dwChangeUnitCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ichangeunitlistfilterinfo-getchangeunitidcount
    HRESULT GetChangeUnitIdCount(uint* pdwChangeUnitIdCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ichangeunitlistfilterinfo-getchangeunitid
    HRESULT GetChangeUnitId(uint dwChangeUnitIdIndex, ubyte* pbChangeUnitId, uint* pcbIdSize);
}

@GUID("087a3f15-0fcb-44c1-9639-53c14e2b5506")
interface ISyncFilter : IUnknown
{
    HRESULT IsIdentical(ISyncFilter pSyncFilter);
    HRESULT Serialize(ubyte* pbSyncFilter, uint* pcbSyncFilter);
}

@GUID("b45b7a72-e5c7-46be-9c82-77b8b15dab8a")
interface ISyncFilterDeserializer : IUnknown
{
    HRESULT DeserializeSyncFilter(const(ubyte)* pbSyncFilter, uint dwCbSyncFilter, ISyncFilter* ppISyncFilter);
}

@GUID("1d335dff-6f88-4e4d-91a8-a3f351cfd473")
interface ICustomFilterInfo : ISyncFilterInfo
{
    HRESULT GetSyncFilter(ISyncFilter* pISyncFilter);
}

@GUID("11f9de71-2818-4779-b2ac-42d450565f45")
interface ICombinedFilterInfo : ISyncFilterInfo
{
    HRESULT GetFilterCount(uint* pdwFilterCount);
    HRESULT GetFilterInfo(uint dwFilterIndex, ISyncFilterInfo* ppIFilterInfo);
    HRESULT GetFilterCombinationType(FILTER_COMBINATION_TYPE* pFilterCombinationType);
}

@GUID("5f86be4a-5e78-4e32-ac1c-c24fd223ef85")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-ienumsyncchanges
interface IEnumSyncChanges : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ienumsyncchanges-next
    HRESULT Next(uint cChanges, ISyncChange* ppChange, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ienumsyncchanges-skip
    HRESULT Skip(uint cChanges);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ienumsyncchanges-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ienumsyncchanges-clone
    HRESULT Clone(IEnumSyncChanges* ppEnum);
}

@GUID("56f14771-8677-484f-a170-e386e418a676")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-isyncchangebuilder
interface ISyncChangeBuilder : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangebuilder-addchangeunitmetadata
    HRESULT AddChangeUnitMetadata(const(ubyte)* pbChangeUnitId, const(SYNC_VERSION)* pChangeUnitVersion);
}

@GUID("295024a0-70da-4c58-883c-ce2afb308d0b")
interface IFilterTrackingSyncChangeBuilder : IUnknown
{
    HRESULT AddFilterChange(uint dwFilterKey, const(SYNC_FILTER_CHANGE)* pFilterChange);
    HRESULT SetAllChangeUnitsPresentFlag();
}

@GUID("52f6e694-6a71-4494-a184-a8311bf5d227")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-isyncchangebatchbase
interface ISyncChangeBatchBase : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangebatchbase-getchangeenumerator
    HRESULT GetChangeEnumerator(IEnumSyncChanges* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangebatchbase-getislastbatch
    HRESULT GetIsLastBatch(BOOL* pfLastBatch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangebatchbase-getworkestimateforbatch
    HRESULT GetWorkEstimateForBatch(uint* pdwWorkForBatch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangebatchbase-getremainingworkestimateforsession
    HRESULT GetRemainingWorkEstimateForSession(uint* pdwRemainingWorkForSession);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangebatchbase-beginorderedgroup
    HRESULT BeginOrderedGroup(const(ubyte)* pbLowerBound);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangebatchbase-endorderedgroup
    HRESULT EndOrderedGroup(const(ubyte)* pbUpperBound, ISyncKnowledge pMadeWithKnowledge);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangebatchbase-additemmetadatatogroup
    HRESULT AddItemMetadataToGroup(const(ubyte)* pbOwnerReplicaId, const(ubyte)* pbItemId, 
                                   const(SYNC_VERSION)* pChangeVersion, const(SYNC_VERSION)* pCreationVersion, 
                                   uint dwFlags, uint dwWorkForChange, ISyncChangeBuilder* ppChangeBuilder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangebatchbase-getlearnedknowledge
    HRESULT GetLearnedKnowledge(ISyncKnowledge* ppLearnedKnowledge);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangebatchbase-getprerequisiteknowledge
    HRESULT GetPrerequisiteKnowledge(ISyncKnowledge* ppPrerequisteKnowledge);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangebatchbase-getsourceforgottenknowledge
    HRESULT GetSourceForgottenKnowledge(IForgottenKnowledge* ppSourceForgottenKnowledge);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangebatchbase-setlastbatch
    HRESULT SetLastBatch();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangebatchbase-setworkestimateforbatch
    HRESULT SetWorkEstimateForBatch(uint dwWorkForBatch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangebatchbase-setremainingworkestimateforsession
    HRESULT SetRemainingWorkEstimateForSession(uint dwRemainingWorkForSession);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangebatchbase-serialize
    HRESULT Serialize(ubyte* pbChangeBatch, uint* pcbChangeBatch);
}

@GUID("70c64dee-380f-4c2e-8f70-31c55bd5f9b3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-isyncchangebatch
interface ISyncChangeBatch : ISyncChangeBatchBase
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangebatch-beginunorderedgroup
    HRESULT BeginUnorderedGroup();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangebatch-endunorderedgroup
    HRESULT EndUnorderedGroup(ISyncKnowledge pMadeWithKnowledge, BOOL fAllChangesForKnowledge);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangebatch-addloggedconflict
    HRESULT AddLoggedConflict(const(ubyte)* pbOwnerReplicaId, const(ubyte)* pbItemId, 
                              const(SYNC_VERSION)* pChangeVersion, const(SYNC_VERSION)* pCreationVersion, 
                              uint dwFlags, uint dwWorkForChange, ISyncKnowledge pConflictKnowledge, 
                              ISyncChangeBuilder* ppChangeBuilder);
}

@GUID("ef64197d-4f44-4ea2-b355-4524713e3bed")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-isyncfullenumerationchangebatch
interface ISyncFullEnumerationChangeBatch : ISyncChangeBatchBase
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncfullenumerationchangebatch-getlearnedknowledgeafterrecoverycomplete
    HRESULT GetLearnedKnowledgeAfterRecoveryComplete(ISyncKnowledge* ppLearnedKnowledgeAfterRecoveryComplete);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncfullenumerationchangebatch-getclosedlowerbounditemid
    HRESULT GetClosedLowerBoundItemId(ubyte* pbClosedLowerBoundItemId, uint* pcbIdSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncfullenumerationchangebatch-getclosedupperbounditemid
    HRESULT GetClosedUpperBoundItemId(ubyte* pbClosedUpperBoundItemId, uint* pcbIdSize);
}

@GUID("097f13be-5b92-4048-b3f2-7b42a2515e07")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-isyncchangebatchwithprerequisite
interface ISyncChangeBatchWithPrerequisite : ISyncChangeBatchBase
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangebatchwithprerequisite-setprerequisiteknowledge
    HRESULT SetPrerequisiteKnowledge(ISyncKnowledge pPrerequisiteKnowledge);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangebatchwithprerequisite-getlearnedknowledgewithprerequisite
    HRESULT GetLearnedKnowledgeWithPrerequisite(ISyncKnowledge pDestinationKnowledge, 
                                                ISyncKnowledge* ppLearnedWithPrerequisiteKnowledge);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangebatchwithprerequisite-getlearnedforgottenknowledge
    HRESULT GetLearnedForgottenKnowledge(IForgottenKnowledge* ppLearnedForgottenKnowledge);
}

@GUID("6fdb596a-d755-4584-bd0c-c0c23a548fbf")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-isyncchangebatchbase2
interface ISyncChangeBatchBase2 : ISyncChangeBatchBase
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangebatchbase2-serializewithoptions
    HRESULT SerializeWithOptions(SYNC_SERIALIZATION_VERSION targetFormatVersion, uint dwFlags, ubyte* pbBuffer, 
                                 uint* pdwSerializedSize);
}

@GUID("0f1a4995-cbc8-421d-b550-5d0bebf3e9a5")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-isyncchangebatchadvanced
interface ISyncChangeBatchAdvanced : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangebatchadvanced-getfilterinfo
    HRESULT GetFilterInfo(ISyncFilterInfo* ppFilterInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangebatchadvanced-convertfullenumerationchangebatchtoregularchangebatch
    HRESULT ConvertFullEnumerationChangeBatchToRegularChangeBatch(ISyncChangeBatch* ppChangeBatch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangebatchadvanced-getupperbounditemid
    HRESULT GetUpperBoundItemId(ubyte* pbItemId, uint* pcbIdSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangebatchadvanced-getbatchlevelknowledgeshouldbeapplied
    HRESULT GetBatchLevelKnowledgeShouldBeApplied(BOOL* pfBatchKnowledgeShouldBeApplied);
}

@GUID("225f4a33-f5ee-4cc7-b039-67a262b4b2ac")
interface ISyncChangeBatch2 : ISyncChangeBatch
{
    HRESULT AddMergeTombstoneMetadataToGroup(const(ubyte)* pbOwnerReplicaId, const(ubyte)* pbWinnerItemId, 
                                             const(ubyte)* pbItemId, const(SYNC_VERSION)* pChangeVersion, 
                                             const(SYNC_VERSION)* pCreationVersion, uint dwWorkForChange, 
                                             ISyncChangeBuilder* ppChangeBuilder);
    HRESULT AddMergeTombstoneLoggedConflict(const(ubyte)* pbOwnerReplicaId, const(ubyte)* pbWinnerItemId, 
                                            const(ubyte)* pbItemId, const(SYNC_VERSION)* pChangeVersion, 
                                            const(SYNC_VERSION)* pCreationVersion, uint dwWorkForChange, 
                                            ISyncKnowledge pConflictKnowledge, ISyncChangeBuilder* ppChangeBuilder);
}

@GUID("e06449f4-a205-4b65-9724-01b22101eec1")
interface ISyncFullEnumerationChangeBatch2 : ISyncFullEnumerationChangeBatch
{
    HRESULT AddMergeTombstoneMetadataToGroup(const(ubyte)* pbOwnerReplicaId, const(ubyte)* pbWinnerItemId, 
                                             const(ubyte)* pbItemId, const(SYNC_VERSION)* pChangeVersion, 
                                             const(SYNC_VERSION)* pCreationVersion, uint dwWorkForChange, 
                                             ISyncChangeBuilder* ppChangeBuilder);
}

@GUID("43434a49-8da4-47f2-8172-ad7b8b024978")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-iknowledgesyncprovider
interface IKnowledgeSyncProvider : ISyncProvider
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-iknowledgesyncprovider-beginsession
    HRESULT BeginSession(SYNC_PROVIDER_ROLE role, ISyncSessionState pSessionState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-iknowledgesyncprovider-getsyncbatchparameters
    HRESULT GetSyncBatchParameters(ISyncKnowledge* ppSyncKnowledge, uint* pdwRequestedBatchSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-iknowledgesyncprovider-getchangebatch
    HRESULT GetChangeBatch(uint dwBatchSize, ISyncKnowledge pSyncKnowledge, ISyncChangeBatch* ppSyncChangeBatch, 
                           IUnknown* ppUnkDataRetriever);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-iknowledgesyncprovider-getfullenumerationchangebatch
    HRESULT GetFullEnumerationChangeBatch(uint dwBatchSize, const(ubyte)* pbLowerEnumerationBound, 
                                          ISyncKnowledge pSyncKnowledge, 
                                          ISyncFullEnumerationChangeBatch* ppSyncChangeBatch, 
                                          IUnknown* ppUnkDataRetriever);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-iknowledgesyncprovider-processchangebatch
    HRESULT ProcessChangeBatch(CONFLICT_RESOLUTION_POLICY resolutionPolicy, ISyncChangeBatch pSourceChangeBatch, 
                               IUnknown pUnkDataRetriever, ISyncCallback pCallback, 
                               SYNC_SESSION_STATISTICS* pSyncSessionStatistics);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-iknowledgesyncprovider-processfullenumerationchangebatch
    HRESULT ProcessFullEnumerationChangeBatch(CONFLICT_RESOLUTION_POLICY resolutionPolicy, 
                                              ISyncFullEnumerationChangeBatch pSourceChangeBatch, 
                                              IUnknown pUnkDataRetriever, ISyncCallback pCallback, 
                                              SYNC_SESSION_STATISTICS* pSyncSessionStatistics);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-iknowledgesyncprovider-endsession
    HRESULT EndSession(ISyncSessionState pSessionState);
}

@GUID("60edd8ca-7341-4bb7-95ce-fab6394b51cb")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-isyncchangeunit
interface ISyncChangeUnit : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangeunit-getitemchange
    HRESULT GetItemChange(ISyncChange* ppSyncChange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangeunit-getchangeunitid
    HRESULT GetChangeUnitId(ubyte* pbChangeUnitId, uint* pcbIdSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangeunit-getchangeunitversion
    HRESULT GetChangeUnitVersion(const(ubyte)* pbCurrentReplicaId, SYNC_VERSION* pVersion);
}

@GUID("346b35f1-8703-4c6d-ab1a-4dbca2cff97f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-ienumsyncchangeunits
interface IEnumSyncChangeUnits : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ienumsyncchangeunits-next
    HRESULT Next(uint cChanges, ISyncChangeUnit* ppChangeUnit, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ienumsyncchangeunits-skip
    HRESULT Skip(uint cChanges);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ienumsyncchangeunits-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ienumsyncchangeunits-clone
    HRESULT Clone(IEnumSyncChangeUnits* ppEnum);
}

@GUID("a1952beb-0f6b-4711-b136-01da85b968a6")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-isyncchange
interface ISyncChange : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchange-getownerreplicaid
    HRESULT GetOwnerReplicaId(ubyte* pbReplicaId, uint* pcbIdSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchange-getrootitemid
    HRESULT GetRootItemId(ubyte* pbRootItemId, uint* pcbIdSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchange-getchangeversion
    HRESULT GetChangeVersion(const(ubyte)* pbCurrentReplicaId, SYNC_VERSION* pVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchange-getcreationversion
    HRESULT GetCreationVersion(const(ubyte)* pbCurrentReplicaId, SYNC_VERSION* pVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchange-getflags
    HRESULT GetFlags(uint* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchange-getworkestimate
    HRESULT GetWorkEstimate(uint* pdwWork);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchange-getchangeunits
    HRESULT GetChangeUnits(IEnumSyncChangeUnits* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchange-getmadewithknowledge
    HRESULT GetMadeWithKnowledge(ISyncKnowledge* ppMadeWithKnowledge);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchange-getlearnedknowledge
    HRESULT GetLearnedKnowledge(ISyncKnowledge* ppLearnedKnowledge);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchange-setworkestimate
    HRESULT SetWorkEstimate(uint dwWork);
}

@GUID("9e38382f-1589-48c3-92e4-05ecdcb4f3f7")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-isyncchangewithprerequisite
interface ISyncChangeWithPrerequisite : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangewithprerequisite-getprerequisiteknowledge
    HRESULT GetPrerequisiteKnowledge(ISyncKnowledge* ppPrerequisiteKnowledge);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncchangewithprerequisite-getlearnedknowledgewithprerequisite
    HRESULT GetLearnedKnowledgeWithPrerequisite(ISyncKnowledge pDestinationKnowledge, 
                                                ISyncKnowledge* ppLearnedKnowledgeWithPrerequisite);
}

@GUID("9785e0bd-bdff-40c4-98c5-b34b2f1991b3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-isyncfullenumerationchange
interface ISyncFullEnumerationChange : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncfullenumerationchange-getlearnedknowledgeafterrecoverycomplete
    HRESULT GetLearnedKnowledgeAfterRecoveryComplete(ISyncKnowledge* ppLearnedKnowledge);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isyncfullenumerationchange-getlearnedforgottenknowledge
    HRESULT GetLearnedForgottenKnowledge(IForgottenKnowledge* ppLearnedForgottenKnowledge);
}

@GUID("6ec62597-0903-484c-ad61-36d6e938f47b")
interface ISyncMergeTombstoneChange : IUnknown
{
    HRESULT GetWinnerItemId(ubyte* pbWinnerItemId, uint* pcbIdSize);
}

@GUID("43aa3f61-4b2e-4b60-83df-b110d3e148f1")
interface IEnumItemIds : IUnknown
{
    HRESULT Next(ubyte* pbItemId, uint* pcbItemIdSize);
}

@GUID("ca169652-07c6-4708-a3da-6e4eba8d2297")
interface IFilterKeyMap : IUnknown
{
    HRESULT GetCount(uint* pdwCount);
    HRESULT AddFilter(ISyncFilter pISyncFilter, uint* pdwFilterKey);
    HRESULT GetFilter(uint dwFilterKey, ISyncFilter* ppISyncFilter);
    HRESULT Serialize(ubyte* pbFilterKeyMap, uint* pcbFilterKeyMap);
}

@GUID("bfe1ef00-e87d-42fd-a4e9-242d70414aef")
interface ISyncChangeWithFilterKeyMap : IUnknown
{
    HRESULT GetFilterCount(uint* pdwFilterCount);
    HRESULT GetFilterChange(uint dwFilterKey, SYNC_FILTER_CHANGE* pFilterChange);
    HRESULT GetAllChangeUnitsPresentFlag(BOOL* pfAllChangeUnitsPresent);
    HRESULT GetFilterForgottenKnowledge(uint dwFilterKey, ISyncKnowledge* ppIFilterForgottenKnowledge);
    HRESULT GetFilteredReplicaLearnedKnowledge(ISyncKnowledge pDestinationKnowledge, IEnumItemIds pNewMoveins, 
                                               ISyncKnowledge* ppLearnedKnowledge);
    HRESULT GetLearnedFilterForgottenKnowledge(ISyncKnowledge pDestinationKnowledge, IEnumItemIds pNewMoveins, 
                                               uint dwFilterKey, ISyncKnowledge* ppLearnedFilterForgottenKnowledge);
    HRESULT GetFilteredReplicaLearnedForgottenKnowledge(ISyncKnowledge pDestinationKnowledge, 
                                                        IEnumItemIds pNewMoveins, 
                                                        ISyncKnowledge* ppLearnedForgottenKnowledge);
    HRESULT GetFilteredReplicaLearnedForgottenKnowledgeAfterRecoveryComplete(ISyncKnowledge pDestinationKnowledge, 
                                                                             IEnumItemIds pNewMoveins, 
                                                                             ISyncKnowledge* ppLearnedForgottenKnowledge);
    HRESULT GetLearnedFilterForgottenKnowledgeAfterRecoveryComplete(ISyncKnowledge pDestinationKnowledge, 
                                                                    IEnumItemIds pNewMoveins, uint dwFilterKey, 
                                                                    ISyncKnowledge* ppLearnedFilterForgottenKnowledge);
}

@GUID("de247002-566d-459a-a6ed-a5aab3459fb7")
interface ISyncChangeBatchWithFilterKeyMap : IUnknown
{
    HRESULT GetFilterKeyMap(IFilterKeyMap* ppIFilterKeyMap);
    HRESULT SetFilterKeyMap(IFilterKeyMap pIFilterKeyMap);
    HRESULT SetFilterForgottenKnowledge(uint dwFilterKey, ISyncKnowledge pFilterForgottenKnowledge);
    HRESULT GetFilteredReplicaLearnedKnowledge(ISyncKnowledge pDestinationKnowledge, IEnumItemIds pNewMoveins, 
                                               ISyncKnowledge* ppLearnedForgottenKnowledge);
    HRESULT GetLearnedFilterForgottenKnowledge(ISyncKnowledge pDestinationKnowledge, IEnumItemIds pNewMoveins, 
                                               uint dwFilterKey, ISyncKnowledge* ppLearnedFilterForgottenKnowledge);
    HRESULT GetFilteredReplicaLearnedForgottenKnowledge(ISyncKnowledge pDestinationKnowledge, 
                                                        IEnumItemIds pNewMoveins, 
                                                        ISyncKnowledge* ppLearnedForgottenKnowledge);
    HRESULT GetFilteredReplicaLearnedForgottenKnowledgeAfterRecoveryComplete(ISyncKnowledge pDestinationKnowledge, 
                                                                             IEnumItemIds pNewMoveins, 
                                                                             ISyncKnowledge* ppLearnedForgottenKnowledge);
    HRESULT GetLearnedFilterForgottenKnowledgeAfterRecoveryComplete(ISyncKnowledge pDestinationKnowledge, 
                                                                    IEnumItemIds pNewMoveins, uint dwFilterKey, 
                                                                    ISyncKnowledge* ppLearnedFilterForgottenKnowledge);
}

@GUID("71b4863b-f969-4676-bbc3-3d9fdc3fb2c7")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-idataretrievercallback
interface IDataRetrieverCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-idataretrievercallback-loadchangedatacomplete
    HRESULT LoadChangeDataComplete(IUnknown pUnkData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-idataretrievercallback-loadchangedataerror
    HRESULT LoadChangeDataError(HRESULT hrError);
}

@GUID("44a4aaca-ec39-46d5-b5c9-d633c0ee67e2")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-iloadchangecontext
interface ILoadChangeContext : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-iloadchangecontext-getsyncchange
    HRESULT GetSyncChange(ISyncChange* ppSyncChange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-iloadchangecontext-setrecoverableerroronchange
    HRESULT SetRecoverableErrorOnChange(HRESULT hrError, IRecoverableErrorData pErrorData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-iloadchangecontext-setrecoverableerroronchangeunit
    HRESULT SetRecoverableErrorOnChangeUnit(HRESULT hrError, ISyncChangeUnit pChangeUnit, 
                                            IRecoverableErrorData pErrorData);
}

@GUID("9b22f2a9-a4cd-4648-9d8e-3a510d4da04b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-isynchronousdataretriever
interface ISynchronousDataRetriever : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isynchronousdataretriever-getidparameters
    HRESULT GetIdParameters(ID_PARAMETERS* pIdParameters);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isynchronousdataretriever-loadchangedata
    HRESULT LoadChangeData(ILoadChangeContext pLoadChangeContext, IUnknown* ppUnkData);
}

@GUID("9fc7e470-61ea-4a88-9be4-df56a27cfef2")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-iasynchronousdataretriever
interface IAsynchronousDataRetriever : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-iasynchronousdataretriever-getidparameters
    HRESULT GetIdParameters(ID_PARAMETERS* pIdParameters);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-iasynchronousdataretriever-registercallback
    HRESULT RegisterCallback(IDataRetrieverCallback pDataRetrieverCallback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-iasynchronousdataretriever-revokecallback
    HRESULT RevokeCallback(IDataRetrieverCallback pDataRetrieverCallback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-iasynchronousdataretriever-loadchangedata
    HRESULT LoadChangeData(ILoadChangeContext pLoadChangeContext);
}

@GUID("82df8873-6360-463a-a8a1-ede5e1a1594d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-ifilterrequestcallback
interface IFilterRequestCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-ifilterrequestcallback-requestfilter
    HRESULT RequestFilter(IUnknown pFilter, FILTERING_TYPE filteringType);
}

@GUID("2e020184-6d18-46a7-a32a-da4aeb06696c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-irequestfilteredsync
interface IRequestFilteredSync : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-irequestfilteredsync-specifyfilter
    HRESULT SpecifyFilter(IFilterRequestCallback pCallback);
}

@GUID("3d128ded-d555-4e0d-bf4b-fb213a8a9302")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-isupportfilteredsync
interface ISupportFilteredSync : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isupportfilteredsync-addfilter
    HRESULT AddFilter(IUnknown pFilter, FILTERING_TYPE filteringType);
}

@GUID("713ca7bb-c858-4674-b4b6-1122436587a9")
interface IFilterTrackingRequestCallback : IUnknown
{
    HRESULT RequestTrackedFilter(ISyncFilter pFilter);
}

@GUID("743383c0-fc4e-45ba-ad81-d9d84c7a24f8")
interface IFilterTrackingProvider : IUnknown
{
    HRESULT SpecifyTrackedFilters(IFilterTrackingRequestCallback pCallback);
    HRESULT AddTrackedFilter(ISyncFilter pFilter);
}

@GUID("eadf816f-d0bd-43ca-8f40-5acdc6c06f7a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-isupportlastwritetime
interface ISupportLastWriteTime : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isupportlastwritetime-getitemchangetime
    HRESULT GetItemChangeTime(const(ubyte)* pbItemId, ulong* pullTimestamp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-isupportlastwritetime-getchangeunitchangetime
    HRESULT GetChangeUnitChangeTime(const(ubyte)* pbItemId, const(ubyte)* pbChangeUnitId, ulong* pullTimestamp);
}

@GUID("809b7276-98cf-4957-93a5-0ebdd3dddffd")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nn-winsync-iproviderconverter
interface IProviderConverter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsync/nf-winsync-iproviderconverter-initialize
    HRESULT Initialize(ISyncProvider pISyncProvider);
}

@GUID("435d4861-68d5-44aa-a0f9-72a0b00ef9cf")
interface ISyncDataConverter : IUnknown
{
    HRESULT ConvertDataRetrieverFromProviderFormat(IUnknown pUnkDataRetrieverIn, IEnumSyncChanges pEnumSyncChanges, 
                                                   IUnknown* ppUnkDataOut);
    HRESULT ConvertDataRetrieverToProviderFormat(IUnknown pUnkDataRetrieverIn, IEnumSyncChanges pEnumSyncChanges, 
                                                 IUnknown* ppUnkDataOut);
    HRESULT ConvertDataFromProviderFormat(ILoadChangeContext pDataContext, IUnknown pUnkDataIn, 
                                          IUnknown* ppUnkDataOut);
    HRESULT ConvertDataToProviderFormat(ILoadChangeContext pDataContext, IUnknown pUnkDataOut, 
                                        IUnknown* ppUnkDataout);
}

@GUID("cb45953b-7624-47bc-a472-eb8cac6b222e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nn-syncregistration-isyncproviderregistration
interface ISyncProviderRegistration : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-isyncproviderregistration-createsyncproviderconfiguiregistrationinstance
    HRESULT CreateSyncProviderConfigUIRegistrationInstance(const(SyncProviderConfigUIConfiguration)* pConfigUIConfig, 
                                                           ISyncProviderConfigUIInfo* ppConfigUIInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-isyncproviderregistration-unregistersyncproviderconfigui
    HRESULT UnregisterSyncProviderConfigUI(const(GUID)* pguidInstanceId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-isyncproviderregistration-enumeratesyncproviderconfiguis
    HRESULT EnumerateSyncProviderConfigUIs(const(GUID)* pguidContentType, uint dwSupportedArchitecture, 
                                           IEnumSyncProviderConfigUIInfos* ppEnumSyncProviderConfigUIInfos);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-isyncproviderregistration-createsyncproviderregistrationinstance
    HRESULT CreateSyncProviderRegistrationInstance(const(SyncProviderConfiguration)* pProviderConfiguration, 
                                                   ISyncProviderInfo* ppProviderInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-isyncproviderregistration-unregistersyncprovider
    HRESULT UnregisterSyncProvider(const(GUID)* pguidInstanceId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-isyncproviderregistration-getsyncproviderconfiguiinfoforprovider
    HRESULT GetSyncProviderConfigUIInfoforProvider(const(GUID)* pguidProviderInstanceId, 
                                                   ISyncProviderConfigUIInfo* ppProviderConfigUIInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-isyncproviderregistration-enumeratesyncproviders
    HRESULT EnumerateSyncProviders(const(GUID)* pguidContentType, uint dwStateFlagsToFilterMask, 
                                   uint dwStateFlagsToFilter, const(GUID)* refProviderClsId, 
                                   uint dwSupportedArchitecture, IEnumSyncProviderInfos* ppEnumSyncProviderInfos);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-isyncproviderregistration-getsyncproviderinfo
    HRESULT GetSyncProviderInfo(const(GUID)* pguidInstanceId, ISyncProviderInfo* ppProviderInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-isyncproviderregistration-getsyncproviderfrominstanceid
    HRESULT GetSyncProviderFromInstanceId(const(GUID)* pguidInstanceId, uint dwClsContext, 
                                          IRegisteredSyncProvider* ppSyncProvider);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-isyncproviderregistration-getsyncproviderconfiguiinfo
    HRESULT GetSyncProviderConfigUIInfo(const(GUID)* pguidInstanceId, ISyncProviderConfigUIInfo* ppConfigUIInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-isyncproviderregistration-getsyncproviderconfiguifrominstanceid
    HRESULT GetSyncProviderConfigUIFromInstanceId(const(GUID)* pguidInstanceId, uint dwClsContext, 
                                                  ISyncProviderConfigUI* ppConfigUI);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-isyncproviderregistration-getsyncproviderstate
    HRESULT GetSyncProviderState(const(GUID)* pguidInstanceId, uint* pdwStateFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-isyncproviderregistration-setsyncproviderstate
    HRESULT SetSyncProviderState(const(GUID)* pguidInstanceId, uint dwStateFlagsMask, uint dwStateFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-isyncproviderregistration-registerforevent
    HRESULT RegisterForEvent(HANDLE* phEvent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-isyncproviderregistration-revokeevent
    HRESULT RevokeEvent(HANDLE hEvent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-isyncproviderregistration-getchange
    HRESULT GetChange(HANDLE hEvent, ISyncRegistrationChange* ppChange);
}

@GUID("f6be2602-17c6-4658-a2d7-68ed3330f641")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nn-syncregistration-ienumsyncproviderconfiguiinfos
interface IEnumSyncProviderConfigUIInfos : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-ienumsyncproviderconfiguiinfos-next
    HRESULT Next(uint cFactories, ISyncProviderConfigUIInfo* ppSyncProviderConfigUIInfo, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-ienumsyncproviderconfiguiinfos-skip
    HRESULT Skip(uint cFactories);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-ienumsyncproviderconfiguiinfos-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-ienumsyncproviderconfiguiinfos-clone
    HRESULT Clone(IEnumSyncProviderConfigUIInfos* ppEnum);
}

@GUID("a04ba850-5eb1-460d-a973-393fcb608a11")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nn-syncregistration-ienumsyncproviderinfos
interface IEnumSyncProviderInfos : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-ienumsyncproviderinfos-next
    HRESULT Next(uint cInstances, ISyncProviderInfo* ppSyncProviderInfo, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-ienumsyncproviderinfos-skip
    HRESULT Skip(uint cInstances);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-ienumsyncproviderinfos-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-ienumsyncproviderinfos-clone
    HRESULT Clone(IEnumSyncProviderInfos* ppEnum);
}

@GUID("1ee135de-88a4-4504-b0d0-f7920d7e5ba6")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nn-syncregistration-isyncproviderinfo
interface ISyncProviderInfo : IPropertyStore
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-isyncproviderinfo-getsyncprovider
    HRESULT GetSyncProvider(uint dwClsContext, IRegisteredSyncProvider* ppSyncProvider);
}

@GUID("214141ae-33d7-4d8d-8e37-f227e880ce50")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nn-syncregistration-isyncproviderconfiguiinfo
interface ISyncProviderConfigUIInfo : IPropertyStore
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-isyncproviderconfiguiinfo-getsyncproviderconfigui
    HRESULT GetSyncProviderConfigUI(uint dwClsContext, ISyncProviderConfigUI* ppSyncProviderConfigUI);
}

@GUID("7b0705f6-cbcd-4071-ab05-3bdc364d4a0c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nn-syncregistration-isyncproviderconfigui
interface ISyncProviderConfigUI : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-isyncproviderconfigui-init
    HRESULT Init(const(GUID)* pguidInstanceId, const(GUID)* pguidContentType, 
                 IPropertyStore pConfigurationProperties);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-isyncproviderconfigui-getregisteredproperties
    HRESULT GetRegisteredProperties(IPropertyStore* ppConfigUIProperties);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-isyncproviderconfigui-createandregisternewsyncprovider
    HRESULT CreateAndRegisterNewSyncProvider(HWND hwndParent, IUnknown pUnkContext, 
                                             ISyncProviderInfo* ppProviderInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-isyncproviderconfigui-modifysyncprovider
    HRESULT ModifySyncProvider(HWND hwndParent, IUnknown pUnkContext, ISyncProviderInfo pProviderInfo);
}

@GUID("913bcf76-47c1-40b5-a896-5e8a9c414c14")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nn-syncregistration-iregisteredsyncprovider
interface IRegisteredSyncProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-iregisteredsyncprovider-init
    HRESULT Init(const(GUID)* pguidInstanceId, const(GUID)* pguidContentType, IPropertyStore pContextPropertyStore);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-iregisteredsyncprovider-getinstanceid
    HRESULT GetInstanceId(GUID* pguidInstanceId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-iregisteredsyncprovider-reset
    HRESULT Reset();
}

@GUID("eea0d9ae-6b29-43b4-9e70-e3ae33bb2c3b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nn-syncregistration-isyncregistrationchange
interface ISyncRegistrationChange : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-isyncregistrationchange-getevent
    HRESULT GetEvent(SYNC_REGISTRATION_EVENT* psreEvent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncregistration/nf-syncregistration-isyncregistrationchange-getinstanceid
    HRESULT GetInstanceId(GUID* pguidInstanceId);
}


// GUIDs

const GUID CLSID_SyncProviderRegistration = GUIDOF!SyncProviderRegistration;

const GUID IID_IAsynchronousDataRetriever       = GUIDOF!IAsynchronousDataRetriever;
const GUID IID_IChangeConflict                  = GUIDOF!IChangeConflict;
const GUID IID_IChangeUnitException             = GUIDOF!IChangeUnitException;
const GUID IID_IChangeUnitListFilterInfo        = GUIDOF!IChangeUnitListFilterInfo;
const GUID IID_IClockVector                     = GUIDOF!IClockVector;
const GUID IID_IClockVectorElement              = GUIDOF!IClockVectorElement;
const GUID IID_ICombinedFilterInfo              = GUIDOF!ICombinedFilterInfo;
const GUID IID_IConstraintConflict              = GUIDOF!IConstraintConflict;
const GUID IID_IConstructReplicaKeyMap          = GUIDOF!IConstructReplicaKeyMap;
const GUID IID_ICoreFragment                    = GUIDOF!ICoreFragment;
const GUID IID_ICoreFragmentInspector           = GUIDOF!ICoreFragmentInspector;
const GUID IID_ICustomFilterInfo                = GUIDOF!ICustomFilterInfo;
const GUID IID_IDataRetrieverCallback           = GUIDOF!IDataRetrieverCallback;
const GUID IID_IEnumChangeUnitExceptions        = GUIDOF!IEnumChangeUnitExceptions;
const GUID IID_IEnumClockVector                 = GUIDOF!IEnumClockVector;
const GUID IID_IEnumFeedClockVector             = GUIDOF!IEnumFeedClockVector;
const GUID IID_IEnumItemIds                     = GUIDOF!IEnumItemIds;
const GUID IID_IEnumRangeExceptions             = GUIDOF!IEnumRangeExceptions;
const GUID IID_IEnumSingleItemExceptions        = GUIDOF!IEnumSingleItemExceptions;
const GUID IID_IEnumSyncChangeUnits             = GUIDOF!IEnumSyncChangeUnits;
const GUID IID_IEnumSyncChanges                 = GUIDOF!IEnumSyncChanges;
const GUID IID_IEnumSyncProviderConfigUIInfos   = GUIDOF!IEnumSyncProviderConfigUIInfos;
const GUID IID_IEnumSyncProviderInfos           = GUIDOF!IEnumSyncProviderInfos;
const GUID IID_IFeedClockVector                 = GUIDOF!IFeedClockVector;
const GUID IID_IFeedClockVectorElement          = GUIDOF!IFeedClockVectorElement;
const GUID IID_IFilterKeyMap                    = GUIDOF!IFilterKeyMap;
const GUID IID_IFilterRequestCallback           = GUIDOF!IFilterRequestCallback;
const GUID IID_IFilterTrackingProvider          = GUIDOF!IFilterTrackingProvider;
const GUID IID_IFilterTrackingRequestCallback   = GUIDOF!IFilterTrackingRequestCallback;
const GUID IID_IFilterTrackingSyncChangeBuilder = GUIDOF!IFilterTrackingSyncChangeBuilder;
const GUID IID_IForgottenKnowledge              = GUIDOF!IForgottenKnowledge;
const GUID IID_IKnowledgeSyncProvider           = GUIDOF!IKnowledgeSyncProvider;
const GUID IID_ILoadChangeContext               = GUIDOF!ILoadChangeContext;
const GUID IID_IProviderConverter               = GUIDOF!IProviderConverter;
const GUID IID_IRangeException                  = GUIDOF!IRangeException;
const GUID IID_IRecoverableError                = GUIDOF!IRecoverableError;
const GUID IID_IRecoverableErrorData            = GUIDOF!IRecoverableErrorData;
const GUID IID_IRegisteredSyncProvider          = GUIDOF!IRegisteredSyncProvider;
const GUID IID_IReplicaKeyMap                   = GUIDOF!IReplicaKeyMap;
const GUID IID_IRequestFilteredSync             = GUIDOF!IRequestFilteredSync;
const GUID IID_ISingleItemException             = GUIDOF!ISingleItemException;
const GUID IID_ISupportFilteredSync             = GUIDOF!ISupportFilteredSync;
const GUID IID_ISupportLastWriteTime            = GUIDOF!ISupportLastWriteTime;
const GUID IID_ISyncCallback                    = GUIDOF!ISyncCallback;
const GUID IID_ISyncCallback2                   = GUIDOF!ISyncCallback2;
const GUID IID_ISyncChange                      = GUIDOF!ISyncChange;
const GUID IID_ISyncChangeBatch                 = GUIDOF!ISyncChangeBatch;
const GUID IID_ISyncChangeBatch2                = GUIDOF!ISyncChangeBatch2;
const GUID IID_ISyncChangeBatchAdvanced         = GUIDOF!ISyncChangeBatchAdvanced;
const GUID IID_ISyncChangeBatchBase             = GUIDOF!ISyncChangeBatchBase;
const GUID IID_ISyncChangeBatchBase2            = GUIDOF!ISyncChangeBatchBase2;
const GUID IID_ISyncChangeBatchWithFilterKeyMap = GUIDOF!ISyncChangeBatchWithFilterKeyMap;
const GUID IID_ISyncChangeBatchWithPrerequisite = GUIDOF!ISyncChangeBatchWithPrerequisite;
const GUID IID_ISyncChangeBuilder               = GUIDOF!ISyncChangeBuilder;
const GUID IID_ISyncChangeUnit                  = GUIDOF!ISyncChangeUnit;
const GUID IID_ISyncChangeWithFilterKeyMap      = GUIDOF!ISyncChangeWithFilterKeyMap;
const GUID IID_ISyncChangeWithPrerequisite      = GUIDOF!ISyncChangeWithPrerequisite;
const GUID IID_ISyncConstraintCallback          = GUIDOF!ISyncConstraintCallback;
const GUID IID_ISyncDataConverter               = GUIDOF!ISyncDataConverter;
const GUID IID_ISyncFilter                      = GUIDOF!ISyncFilter;
const GUID IID_ISyncFilterDeserializer          = GUIDOF!ISyncFilterDeserializer;
const GUID IID_ISyncFilterInfo                  = GUIDOF!ISyncFilterInfo;
const GUID IID_ISyncFilterInfo2                 = GUIDOF!ISyncFilterInfo2;
const GUID IID_ISyncFullEnumerationChange       = GUIDOF!ISyncFullEnumerationChange;
const GUID IID_ISyncFullEnumerationChangeBatch  = GUIDOF!ISyncFullEnumerationChangeBatch;
const GUID IID_ISyncFullEnumerationChangeBatch2 = GUIDOF!ISyncFullEnumerationChangeBatch2;
const GUID IID_ISyncKnowledge                   = GUIDOF!ISyncKnowledge;
const GUID IID_ISyncKnowledge2                  = GUIDOF!ISyncKnowledge2;
const GUID IID_ISyncMergeTombstoneChange        = GUIDOF!ISyncMergeTombstoneChange;
const GUID IID_ISyncProvider                    = GUIDOF!ISyncProvider;
const GUID IID_ISyncProviderConfigUI            = GUIDOF!ISyncProviderConfigUI;
const GUID IID_ISyncProviderConfigUIInfo        = GUIDOF!ISyncProviderConfigUIInfo;
const GUID IID_ISyncProviderInfo                = GUIDOF!ISyncProviderInfo;
const GUID IID_ISyncProviderRegistration        = GUIDOF!ISyncProviderRegistration;
const GUID IID_ISyncRegistrationChange          = GUIDOF!ISyncRegistrationChange;
const GUID IID_ISyncSessionExtendedErrorInfo    = GUIDOF!ISyncSessionExtendedErrorInfo;
const GUID IID_ISyncSessionState                = GUIDOF!ISyncSessionState;
const GUID IID_ISyncSessionState2               = GUIDOF!ISyncSessionState2;
const GUID IID_ISynchronousDataRetriever        = GUIDOF!ISynchronousDataRetriever;
