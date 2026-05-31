// Written in the D programming language.

module windows.win32.system.settingsmanagementinfrastructure;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : BOOL, BSTR, HMODULE, HRESULT, PWSTR;
public import windows.win32.system.com : IStream, IUnknown;
public import windows.win32.system.variant : VARIANT;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/ne-wcmconfig-wcmtargetmode))], [])
enum WcmTargetMode : int
{
    OfflineMode = 0x00000001,
    OnlineMode  = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/ne-wcmconfig-wcmnamespaceenumerationflags))], [])
enum WcmNamespaceEnumerationFlags : int
{
    SharedEnumeration = 0x00000001,
    UserEnumeration   = 0x00000002,
    AllEnumeration    = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/ne-wcmconfig-wcmdatatype))], [])
enum WcmDataType : int
{
    dataTypeByte      = 0x00000001,
    dataTypeSByte     = 0x00000002,
    dataTypeUInt16    = 0x00000003,
    dataTypeInt16     = 0x00000004,
    dataTypeUInt32    = 0x00000005,
    dataTypeInt32     = 0x00000006,
    dataTypeUInt64    = 0x00000007,
    dataTypeInt64     = 0x00000008,
    dataTypeBoolean   = 0x0000000b,
    dataTypeString    = 0x0000000c,
    dataTypeFlagArray = 0x00008000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/ne-wcmconfig-wcmsettingtype))], [])
enum WcmSettingType : int
{
    settingTypeScalar  = 0x00000001,
    settingTypeComplex = 0x00000002,
    settingTypeList    = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/ne-wcmconfig-wcmrestrictionfacets))], [])
enum WcmRestrictionFacets : int
{
    restrictionFacetMaxLength    = 0x00000001,
    restrictionFacetEnumeration  = 0x00000002,
    restrictionFacetMaxInclusive = 0x00000004,
    restrictionFacetMinInclusive = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/ne-wcmconfig-wcmuserstatus))], [])
enum WcmUserStatus : int
{
    UnknownStatus    = 0x00000000,
    UserRegistered   = 0x00000001,
    UserUnregistered = 0x00000002,
    UserLoaded       = 0x00000003,
    UserUnloaded     = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/ne-wcmconfig-wcmnamespaceaccess))], [])
enum WcmNamespaceAccess : int
{
    ReadOnlyAccess  = 0x00000001,
    ReadWriteAccess = 0x00000002,
}

// Constants


enum : const(wchar)*
{
    WCM_SETTINGS_ID_NAME          = "name",
    WCM_SETTINGS_ID_VERSION       = "version",
    WCM_SETTINGS_ID_LANGUAGE      = "language",
    WCM_SETTINGS_ID_ARCHITECTURE  = "architecture",
    WCM_SETTINGS_ID_TOKEN         = "token",
    WCM_SETTINGS_ID_URI           = "uri",
    WCM_SETTINGS_ID_VERSION_SCOPE = "versionScope",
}

enum : uint
{
    WCM_SETTINGS_ID_FLAG_REFERENCE  = 0x00000000,
    WCM_SETTINGS_ID_FLAG_DEFINITION = 0x00000001,
}

enum uint LINK_STORE_TO_ENGINE_INSTANCE = 0x00000001;
enum uint LIMITED_VALIDATION_MODE = 0x00000001;
enum HRESULT WCM_E_INTERNALERROR = HRESULT(0x80220000);

enum : HRESULT
{
    WCM_E_STATENODENOTFOUND   = HRESULT(0x80220001),
    WCM_E_STATENODENOTALLOWED = HRESULT(0x80220002),
}

enum : HRESULT
{
    WCM_E_ATTRIBUTENOTFOUND   = HRESULT(0x80220003),
    WCM_E_ATTRIBUTENOTALLOWED = HRESULT(0x80220004),
}

enum : HRESULT
{
    WCM_E_INVALIDVALUE       = HRESULT(0x80220005),
    WCM_E_INVALIDVALUEFORMAT = HRESULT(0x80220006),
}

enum HRESULT WCM_E_TYPENOTSPECIFIED = HRESULT(0x80220007);
enum HRESULT WCM_E_INVALIDDATATYPE = HRESULT(0x80220008);
enum HRESULT WCM_E_NOTPOSITIONED = HRESULT(0x80220009);
enum HRESULT WCM_E_READONLYITEM = HRESULT(0x8022000a);
enum HRESULT WCM_E_INVALIDPATH = HRESULT(0x8022000b);
enum HRESULT WCM_E_WRONGESCAPESTRING = HRESULT(0x8022000c);

enum : HRESULT
{
    WCM_E_INVALIDVERSIONFORMAT  = HRESULT(0x8022000d),
    WCM_E_INVALIDLANGUAGEFORMAT = HRESULT(0x8022000e),
}

enum HRESULT WCM_E_KEYNOTCHANGEABLE = HRESULT(0x8022000f);
enum HRESULT WCM_E_EXPRESSIONNOTFOUND = HRESULT(0x80220010);
enum HRESULT WCM_E_SUBSTITUTIONNOTFOUND = HRESULT(0x80220011);
enum HRESULT WCM_E_USERALREADYREGISTERED = HRESULT(0x80220012);
enum HRESULT WCM_E_USERNOTFOUND = HRESULT(0x80220013);

enum : HRESULT
{
    WCM_E_NAMESPACENOTFOUND          = HRESULT(0x80220014),
    WCM_E_NAMESPACEALREADYREGISTERED = HRESULT(0x80220015),
}

enum HRESULT WCM_E_STORECORRUPTED = HRESULT(0x80220016);
enum HRESULT WCM_E_INVALIDEXPRESSIONSYNTAX = HRESULT(0x80220017);
enum HRESULT WCM_E_NOTIFICATIONNOTFOUND = HRESULT(0x80220018);
enum HRESULT WCM_E_CONFLICTINGASSERTION = HRESULT(0x80220019);
enum HRESULT WCM_E_ASSERTIONFAILED = HRESULT(0x8022001a);
enum HRESULT WCM_E_DUPLICATENAME = HRESULT(0x8022001b);

enum : HRESULT
{
    WCM_E_INVALIDKEY    = HRESULT(0x8022001c),
    WCM_E_INVALIDSTREAM = HRESULT(0x8022001d),
}

enum HRESULT WCM_E_HANDLERNOTFOUND = HRESULT(0x8022001e);
enum HRESULT WCM_E_INVALIDHANDLERSYNTAX = HRESULT(0x8022001f);
enum HRESULT WCM_E_VALIDATIONFAILED = HRESULT(0x80220020);
enum HRESULT WCM_E_RESTRICTIONFAILED = HRESULT(0x80220021);
enum HRESULT WCM_E_MANIFESTCOMPILATIONFAILED = HRESULT(0x80220022);
enum HRESULT WCM_E_CYCLICREFERENCE = HRESULT(0x80220023);
enum HRESULT WCM_E_MIXTYPEASSERTION = HRESULT(0x80220024);
enum HRESULT WCM_E_NOTSUPPORTEDFUNCTION = HRESULT(0x80220025);
enum HRESULT WCM_E_VALUETOOBIG = HRESULT(0x80220026);
enum HRESULT WCM_E_INVALIDATTRIBUTECOMBINATION = HRESULT(0x80220027);
enum HRESULT WCM_E_ABORTOPERATION = HRESULT(0x80220028);
enum HRESULT WCM_E_MISSINGCONFIGURATION = HRESULT(0x80220029);
enum HRESULT WCM_E_INVALIDPROCESSORFORMAT = HRESULT(0x8022002a);
enum HRESULT WCM_E_SOURCEMANEMPTYVALUE = HRESULT(0x8022002b);
enum HRESULT WCM_S_INTERNALERROR = HRESULT(0x00221000);
enum HRESULT WCM_S_ATTRIBUTENOTFOUND = HRESULT(0x00221001);
enum HRESULT WCM_S_LEGACYSETTINGWARNING = HRESULT(0x00221002);
enum HRESULT WCM_S_INVALIDATTRIBUTECOMBINATION = HRESULT(0x00221004);
enum HRESULT WCM_S_ATTRIBUTENOTALLOWED = HRESULT(0x00221005);
enum HRESULT WCM_S_NAMESPACENOTFOUND = HRESULT(0x00221006);
enum HRESULT WCM_E_UNKNOWNRESULT = HRESULT(0x80221003);

// Interfaces

@GUID("9f7d7bb5-20b3-11da-81a5-0030f1642e3c")
struct SettingsEngine;

@GUID("9f7d7bb7-20b3-11da-81a5-0030f1642e3c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nn-wcmconfig-iitemenumerator))], [])
interface IItemEnumerator : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-iitemenumerator-current))], [])
    HRESULT Current(VARIANT* Item);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-iitemenumerator-movenext))], [])
    HRESULT MoveNext(BOOL* ItemValid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-iitemenumerator-reset))], [])
    HRESULT Reset();
}

@GUID("9f7d7bb6-20b3-11da-81a5-0030f1642e3c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nn-wcmconfig-isettingsidentity))], [])
interface ISettingsIdentity : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsidentity-getattribute))], [])
    HRESULT GetAttribute(void* Reserved, const(PWSTR) Name, BSTR* Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsidentity-setattribute))], [])
    HRESULT SetAttribute(void* Reserved, const(PWSTR) Name, const(PWSTR) Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsidentity-getflags))], [])
    HRESULT GetFlags(uint* Flags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsidentity-setflags))], [])
    HRESULT SetFlags(uint Flags);
}

@GUID("9f7d7bb8-20b3-11da-81a5-0030f1642e3c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nn-wcmconfig-itargetinfo))], [])
interface ITargetInfo : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-itargetinfo-gettargetmode))], [])
    HRESULT GetTargetMode(WcmTargetMode* TargetMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-itargetinfo-settargetmode))], [])
    HRESULT SetTargetMode(WcmTargetMode TargetMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-itargetinfo-gettemporarystorelocation))], [])
    HRESULT GetTemporaryStoreLocation(BSTR* TemporaryStoreLocation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-itargetinfo-settemporarystorelocation))], [])
    HRESULT SetTemporaryStoreLocation(const(PWSTR) TemporaryStoreLocation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-itargetinfo-gettargetid))], [])
    HRESULT GetTargetID(BSTR* TargetID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-itargetinfo-settargetid))], [])
    HRESULT SetTargetID(GUID TargetID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-itargetinfo-gettargetprocessorarchitecture))], [])
    HRESULT GetTargetProcessorArchitecture(BSTR* ProcessorArchitecture);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-itargetinfo-settargetprocessorarchitecture))], [])
    HRESULT SetTargetProcessorArchitecture(const(PWSTR) ProcessorArchitecture);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-itargetinfo-getproperty))], [])
    HRESULT GetProperty(BOOL Offline, const(PWSTR) Property, BSTR* Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-itargetinfo-setproperty))], [])
    HRESULT SetProperty(BOOL Offline, const(PWSTR) Property, const(PWSTR) Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-itargetinfo-getenumerator))], [])
    HRESULT GetEnumerator(IItemEnumerator* Enumerator);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-itargetinfo-expandtarget))], [])
    HRESULT ExpandTarget(BOOL Offline, const(PWSTR) Location, BSTR* ExpandedLocation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-itargetinfo-expandtargetpath))], [])
    HRESULT ExpandTargetPath(BOOL Offline, const(PWSTR) Location, BSTR* ExpandedLocation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-itargetinfo-setmodulepath))], [])
    HRESULT SetModulePath(const(PWSTR) Module, const(PWSTR) Path);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-itargetinfo-loadmodule))], [])
    HRESULT LoadModule(const(PWSTR) Module, HMODULE* ModuleHandle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-itargetinfo-setwow64context))], [])
    HRESULT SetWow64Context(const(PWSTR) InstallerModule, ubyte* Wow64Context);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-itargetinfo-translatewow64))], [])
    HRESULT TranslateWow64(const(PWSTR) ClientArchitecture, const(PWSTR) Value, BSTR* TranslatedValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-itargetinfo-setschemahivelocation))], [])
    HRESULT SetSchemaHiveLocation(const(PWSTR) pwzHiveDir);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-itargetinfo-getschemahivelocation))], [])
    HRESULT GetSchemaHiveLocation(BSTR* pHiveLocation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-itargetinfo-setschemahivemountname))], [])
    HRESULT SetSchemaHiveMountName(const(PWSTR) pwzMountName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-itargetinfo-getschemahivemountname))], [])
    HRESULT GetSchemaHiveMountName(BSTR* pMountName);
}

@GUID("9f7d7bb9-20b3-11da-81a5-0030f1642e3c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nn-wcmconfig-isettingsengine))], [])
interface ISettingsEngine : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsengine-getnamespaces))], [])
    HRESULT GetNamespaces(WcmNamespaceEnumerationFlags Flags, void* Reserved, IItemEnumerator* Namespaces);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsengine-getnamespace))], [])
    HRESULT GetNamespace(ISettingsIdentity SettingsID, WcmNamespaceAccess Access, void* Reserved, 
                         ISettingsNamespace* NamespaceItem);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsengine-geterrordescription))], [])
    HRESULT GetErrorDescription(int HResult, BSTR* Message);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsengine-createsettingsidentity))], [])
    HRESULT CreateSettingsIdentity(ISettingsIdentity* SettingsID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsengine-getstorestatus))], [])
    HRESULT GetStoreStatus(void* Reserved, WcmUserStatus* Status);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsengine-loadstore))], [])
    HRESULT LoadStore(uint Flags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsengine-unloadstore))], [])
    HRESULT UnloadStore(void* Reserved);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsengine-registernamespace))], [])
    HRESULT RegisterNamespace(ISettingsIdentity SettingsID, IStream Stream, BOOL PushSettings, VARIANT* Results);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsengine-unregisternamespace))], [])
    HRESULT UnregisterNamespace(ISettingsIdentity SettingsID, BOOL RemoveSettings);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsengine-createtargetinfo))], [])
    HRESULT CreateTargetInfo(ITargetInfo* Target);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsengine-gettargetinfo))], [])
    HRESULT GetTargetInfo(ITargetInfo* Target);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsengine-settargetinfo))], [])
    HRESULT SetTargetInfo(ITargetInfo Target);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsengine-createsettingscontext))], [])
    HRESULT CreateSettingsContext(uint Flags, void* Reserved, ISettingsContext* SettingsContext);
    HRESULT SetSettingsContext(ISettingsContext SettingsContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsengine-applysettingscontext))], [])
    HRESULT ApplySettingsContext(ISettingsContext SettingsContext, PWSTR** pppwzIdentities, size_t* pcIdentities);
    HRESULT GetSettingsContext(ISettingsContext* SettingsContext);
}

@GUID("9f7d7bbb-20b3-11da-81a5-0030f1642e3c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nn-wcmconfig-isettingsitem))], [])
interface ISettingsItem : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsitem-getname))], [])
    HRESULT GetName(BSTR* Name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsitem-getvalue))], [])
    HRESULT GetValue(VARIANT* Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsitem-setvalue))], [])
    HRESULT SetValue(const(VARIANT)* Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsitem-getsettingtype))], [])
    HRESULT GetSettingType(WcmSettingType* Type);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsitem-getdatatype))], [])
    HRESULT GetDataType(WcmDataType* Type);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsitem-getvalueraw))], [])
    HRESULT GetValueRaw(ubyte** Data, uint* DataSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsitem-setvalueraw))], [])
    HRESULT SetValueRaw(int DataType, const(ubyte)* Data, uint DataSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsitem-haschild))], [])
    HRESULT HasChild(BOOL* ItemHasChild);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsitem-children))], [])
    HRESULT Children(IItemEnumerator* Children);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsitem-getchild))], [])
    HRESULT GetChild(const(PWSTR) Name, ISettingsItem* Child);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsitem-getsettingbypath))], [])
    HRESULT GetSettingByPath(const(PWSTR) Path, ISettingsItem* Setting);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsitem-createsettingbypath))], [])
    HRESULT CreateSettingByPath(const(PWSTR) Path, ISettingsItem* Setting);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsitem-removesettingbypath))], [])
    HRESULT RemoveSettingByPath(const(PWSTR) Path);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsitem-getlistkeyinformation))], [])
    HRESULT GetListKeyInformation(BSTR* KeyName, WcmDataType* DataType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsitem-createlistelement))], [])
    HRESULT CreateListElement(const(VARIANT)* KeyData, ISettingsItem* Child);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsitem-removelistelement))], [])
    HRESULT RemoveListElement(const(PWSTR) ElementName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsitem-attributes))], [])
    HRESULT Attributes(IItemEnumerator* Attributes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsitem-getattribute))], [])
    HRESULT GetAttribute(const(PWSTR) Name, VARIANT* Value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsitem-getpath))], [])
    HRESULT GetPath(BSTR* Path);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsitem-getrestrictionfacets))], [])
    HRESULT GetRestrictionFacets(WcmRestrictionFacets* RestrictionFacets);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsitem-getrestriction))], [])
    HRESULT GetRestriction(WcmRestrictionFacets RestrictionFacet, VARIANT* FacetData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsitem-getkeyvalue))], [])
    HRESULT GetKeyValue(VARIANT* Value);
}

@GUID("9f7d7bba-20b3-11da-81a5-0030f1642e3c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nn-wcmconfig-isettingsnamespace))], [])
interface ISettingsNamespace : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsnamespace-getidentity))], [])
    HRESULT GetIdentity(ISettingsIdentity* SettingsID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsnamespace-settings))], [])
    HRESULT Settings(IItemEnumerator* Settings);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsnamespace-save))], [])
    HRESULT Save(BOOL PushSettings, ISettingsResult* Result);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsnamespace-getsettingbypath))], [])
    HRESULT GetSettingByPath(const(PWSTR) Path, ISettingsItem* Setting);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsnamespace-createsettingbypath))], [])
    HRESULT CreateSettingByPath(const(PWSTR) Path, ISettingsItem* Setting);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsnamespace-removesettingbypath))], [])
    HRESULT RemoveSettingByPath(const(PWSTR) Path);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsnamespace-getattribute))], [])
    HRESULT GetAttribute(const(PWSTR) Name, VARIANT* Value);
}

@GUID("9f7d7bbc-20b3-11da-81a5-0030f1642e3c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nn-wcmconfig-isettingsresult))], [])
interface ISettingsResult : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsresult-getdescription))], [])
    HRESULT GetDescription(BSTR* description);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsresult-geterrorcode))], [])
    HRESULT GetErrorCode(HRESULT* hrOut);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsresult-getcontextdescription))], [])
    HRESULT GetContextDescription(BSTR* description);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsresult-getline))], [])
    HRESULT GetLine(uint* dwLine);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsresult-getcolumn))], [])
    HRESULT GetColumn(uint* dwColumn);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingsresult-getsource))], [])
    HRESULT GetSource(BSTR* file);
}

@GUID("9f7d7bbd-20b3-11da-81a5-0030f1642e3c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nn-wcmconfig-isettingscontext))], [])
interface ISettingsContext : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingscontext-serialize))], [])
    HRESULT Serialize(IStream pStream, ITargetInfo pTarget);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingscontext-deserialize))], [])
    HRESULT Deserialize(IStream pStream, ITargetInfo pTarget, ISettingsResult** pppResults, size_t* pcResultCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingscontext-setuserdata))], [])
    HRESULT SetUserData(void* pUserData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingscontext-getuserdata))], [])
    HRESULT GetUserData(void** pUserData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingscontext-getnamespaces))], [])
    HRESULT GetNamespaces(IItemEnumerator* ppNamespaceIds);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingscontext-getstoredsettings))], [])
    HRESULT GetStoredSettings(ISettingsIdentity pIdentity, IItemEnumerator* ppAddedSettings, 
                              IItemEnumerator* ppModifiedSettings, IItemEnumerator* ppDeletedSettings);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wcmconfig/nf-wcmconfig-isettingscontext-revertsetting))], [])
    HRESULT RevertSetting(ISettingsIdentity pIdentity, const(PWSTR) pwzSetting);
}


// GUIDs

const GUID CLSID_SettingsEngine = GUIDOF!SettingsEngine;

const GUID IID_IItemEnumerator    = GUIDOF!IItemEnumerator;
const GUID IID_ISettingsContext   = GUIDOF!ISettingsContext;
const GUID IID_ISettingsEngine    = GUIDOF!ISettingsEngine;
const GUID IID_ISettingsIdentity  = GUIDOF!ISettingsIdentity;
const GUID IID_ISettingsItem      = GUIDOF!ISettingsItem;
const GUID IID_ISettingsNamespace = GUIDOF!ISettingsNamespace;
const GUID IID_ISettingsResult    = GUIDOF!ISettingsResult;
const GUID IID_ITargetInfo        = GUIDOF!ITargetInfo;
