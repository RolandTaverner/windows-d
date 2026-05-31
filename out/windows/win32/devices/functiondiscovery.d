// Written in the D programming language.

module windows.win32.devices.functiondiscovery;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOL, HRESULT, PROPERTYKEY, PWSTR;
public import windows.win32.system.com.com : IServiceProvider, IUnknown, STGM;
public import windows.win32.system.com.structuredstorage : PROPVARIANT;
public import windows.win32.ui.shell.propertiessystem : IPropertyStore;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryconstraints/ne-functiondiscoveryconstraints-propertyconstraint
enum PropertyConstraint : int
{
    QC_EQUALS             = 0x00000000,
    QC_NOTEQUAL           = 0x00000001,
    QC_LESSTHAN           = 0x00000002,
    QC_LESSTHANOREQUAL    = 0x00000003,
    QC_GREATERTHAN        = 0x00000004,
    QC_GREATERTHANOREQUAL = 0x00000005,
    QC_STARTSWITH         = 0x00000006,
    QC_EXISTS             = 0x00000007,
    QC_DOESNOTEXIST       = 0x00000008,
    QC_CONTAINS           = 0x00000009,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/ne-functiondiscoveryapi-systemvisibilityflags
enum SystemVisibilityFlags : int
{
    SVF_SYSTEM = 0x00000000,
    SVF_USER   = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/ne-functiondiscoveryapi-queryupdateaction
enum QueryUpdateAction : int
{
    QUA_ADD    = 0x00000000,
    QUA_REMOVE = 0x00000001,
    QUA_CHANGE = 0x00000002,
}

enum QueryCategoryType : int
{
    QCT_PROVIDER = 0x00000000,
    QCT_LAYERED  = 0x00000001,
}

// Constants


enum : uint
{
    FD_EVENTID_PRIVATE         = 0x00000064U,
    FD_EVENTID                 = 0x000003e8U,
    FD_EVENTID_SEARCHCOMPLETE  = 0x000003e8U,
    FD_EVENTID_ASYNCTHREADEXIT = 0x000003e9U,
    FD_EVENTID_SEARCHSTART     = 0x000003eaU,
    FD_EVENTID_IPADDRESSCHANGE = 0x000003ebU,
    FD_EVENTID_QUERYREFRESH    = 0x000003ecU,
}

enum GUID SID_PnpProvider = GUID("8101368e-cabb-4426-acff-96c410812000");
enum GUID SID_UPnPActivator = GUID("0d0d66eb-cf74-4164-b52f-08344672dd46");
enum GUID SID_EnumInterface = GUID("40eab0b9-4d7f-4b53-a334-1581dd9041f4");
enum GUID SID_PNPXPropertyStore = GUID("a86530b1-542f-439f-b71c-b0756b13677a");

enum : GUID
{
    SID_PNPXAssociation       = GUID("cee8ccc9-4f6b-4469-a235-5a22869eef03"),
    SID_PNPXServiceCollection = GUID("439e80ee-a217-4712-9fa6-deabd9c2a727"),
}

enum GUID SID_FDPairingHandler = GUID("383b69fa-5486-49da-91f5-d63c24c8e9d0");
enum GUID SID_EnumDeviceFunction = GUID("13e0e9e2-c3fa-4e3c-906e-64502fa4dc95");
enum GUID SID_UnpairProvider = GUID("89a502fc-857b-4698-a0b7-027192002f9e");
enum GUID SID_DeviceDisplayStatusManager = GUID("f59aa553-8309-46ca-9736-1ac3c62d6031");
enum GUID SID_FunctionDiscoveryProviderRefresh = GUID("2b4cbdc9-31c4-40d4-a62d-772aa174ed52");
enum GUID SID_UninstallDeviceFunction = GUID("c920566e-5671-4496-8025-bf0b89bd44cd");
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({146850387, 41300, 18246, 144, 5, 130, 222, 83, 23, 20, 139}, 1))], [])*/PROPERTYKEY PKEY_FunctionInstance = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({146850387, 41300, 18246, 144, 5, 130, 222, 83, 23, 20, 139}, 1))], [])*/PROPERTYKEY(GUID("08C0C253-A154-4746-9005-82DE5317148B"), 1);
enum GUID FMTID_FD = GUID("904b03a2-471d-423c-a584-f3483238a146");

enum : uint
{
    FD_Visibility_Default = 0x00000000U,
    FD_Visibility_Hidden  = 0x00000001U,
}

enum : GUID
{
    FMTID_Device          = GUID("78c34fc8-104a-4aca-9ea4-524d52996e57"),
    FMTID_DeviceInterface = GUID("53808008-07bb-4661-bc3c-b5953e708560"),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 51))], [])*/PROPERTYKEY
{
    PKEY_DeviceDisplay_Address                          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 51))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 51),
    PKEY_DeviceDisplay_DiscoveryMethod                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 51))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 52),
    PKEY_DeviceDisplay_IsEncrypted                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 51))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 53),
    PKEY_DeviceDisplay_IsAuthenticated                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 51))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 54),
    PKEY_DeviceDisplay_IsConnected                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 51))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 55),
    PKEY_DeviceDisplay_IsPaired                         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 51))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 56),
    PKEY_DeviceDisplay_Icon                             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 51))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 57),
    PKEY_DeviceDisplay_Version                          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 51))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 65),
    PKEY_DeviceDisplay_Last_Seen                        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 51))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 66),
    PKEY_DeviceDisplay_Last_Connected                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 51))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 67),
    PKEY_DeviceDisplay_IsShowInDisconnectedState        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 51))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 68),
    PKEY_DeviceDisplay_IsLocalMachine                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 51))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 70),
    PKEY_DeviceDisplay_MetadataPath                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 51))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 71),
    PKEY_DeviceDisplay_IsMetadataSearchInProgress       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 51))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 72),
    PKEY_DeviceDisplay_MetadataChecksum                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 51))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 73),
    PKEY_DeviceDisplay_IsNotInterestingForDisplay       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 51))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 74),
    PKEY_DeviceDisplay_LaunchDeviceStageOnDeviceConnect = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 51))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 76),
    PKEY_DeviceDisplay_LaunchDeviceStageFromExplorer    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 51))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 77),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY
{
    PKEY_DeviceDisplay_BaselineExperienceId         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 78),
    PKEY_DeviceDisplay_IsDeviceUniquelyIdentifiable = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 79),
    PKEY_DeviceDisplay_AssociationArray             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 80),
    PKEY_DeviceDisplay_DeviceDescription1           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 81),
    PKEY_DeviceDisplay_DeviceDescription2           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 82),
    PKEY_DeviceDisplay_IsNotWorkingProperly         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 83),
    PKEY_DeviceDisplay_IsSharedDevice               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 84),
    PKEY_DeviceDisplay_IsNetworkDevice              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 85),
    PKEY_DeviceDisplay_IsDefaultDevice              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 86),
    PKEY_DeviceDisplay_MetadataCabinet              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 87),
    PKEY_DeviceDisplay_RequiresPairingElevation     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 88),
    PKEY_DeviceDisplay_ExperienceId                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 89),
    PKEY_DeviceDisplay_Category                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 90),
    PKEY_DeviceDisplay_Category_Desc_Singular       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 91),
    PKEY_DeviceDisplay_Category_Desc_Plural         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 92),
    PKEY_DeviceDisplay_Category_Icon                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 93),
    PKEY_DeviceDisplay_CategoryGroup_Desc           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 94),
    PKEY_DeviceDisplay_CategoryGroup_Icon           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 95),
    PKEY_DeviceDisplay_PrimaryCategory              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 97),
    PKEY_DeviceDisplay_UnpairUninstall              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 98),
    PKEY_DeviceDisplay_RequiresUninstallElevation   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 99),
    PKEY_DeviceDisplay_DeviceFunctionSubRank        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 100),
    PKEY_DeviceDisplay_AlwaysShowDeviceAsConnected  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 101),
    PKEY_DeviceDisplay_FriendlyName                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 12288),
    PKEY_DeviceDisplay_Manufacturer                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 8192),
    PKEY_DeviceDisplay_ModelName                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 8194),
    PKEY_DeviceDisplay_ModelNumber                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 8195),
    PKEY_DeviceDisplay_InstallInProgress            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 78))], [])*/PROPERTYKEY(GUID("83DA6326-97A6-4088-9453-A1923F573B29"), 9),
}

enum GUID FMTID_Pairing = GUID("8807cae6-7db6-4f10-8ee4-435eaa1392bc");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2282212070, 32182, 20240, 142, 228, 67, 94, 170, 19, 146, 188}, 1))], [])*/PROPERTYKEY
{
    PKEY_Pairing_ListItemText        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2282212070, 32182, 20240, 142, 228, 67, 94, 170, 19, 146, 188}, 1))], [])*/PROPERTYKEY(GUID("8807CAE6-7DB6-4F10-8EE4-435EAA1392BC"), 1),
    PKEY_Pairing_ListItemDescription = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2282212070, 32182, 20240, 142, 228, 67, 94, 170, 19, 146, 188}, 1))], [])*/PROPERTYKEY(GUID("8807CAE6-7DB6-4F10-8EE4-435EAA1392BC"), 2),
    PKEY_Pairing_ListItemIcon        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2282212070, 32182, 20240, 142, 228, 67, 94, 170, 19, 146, 188}, 1))], [])*/PROPERTYKEY(GUID("8807CAE6-7DB6-4F10-8EE4-435EAA1392BC"), 3),
    PKEY_Pairing_ListItemDefault     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2282212070, 32182, 20240, 142, 228, 67, 94, 170, 19, 146, 188}, 1))], [])*/PROPERTYKEY(GUID("8807CAE6-7DB6-4F10-8EE4-435EAA1392BC"), 4),
    PKEY_Pairing_IsWifiOnlyDevice    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2282212070, 32182, 20240, 142, 228, 67, 94, 170, 19, 146, 188}, 1))], [])*/PROPERTYKEY(GUID("8807CAE6-7DB6-4F10-8EE4-435EAA1392BC"), 16),
}

enum : const(wchar)*
{
    DEVICEDISPLAY_DISCOVERYMETHOD_BLUETOOTH    = "Bluetooth",
    DEVICEDISPLAY_DISCOVERYMETHOD_BLUETOOTH_LE = "Bluetooth Low Energy",
    DEVICEDISPLAY_DISCOVERYMETHOD_NETBIOS      = "NetBIOS",
    DEVICEDISPLAY_DISCOVERYMETHOD_AD_PRINTER   = "Published Printer",
    DEVICEDISPLAY_DISCOVERYMETHOD_PNP          = "PnP",
    DEVICEDISPLAY_DISCOVERYMETHOD_UPNP         = "UPnP",
    DEVICEDISPLAY_DISCOVERYMETHOD_WSD          = "WSD",
    DEVICEDISPLAY_DISCOVERYMETHOD_WUSB         = "WUSB",
    DEVICEDISPLAY_DISCOVERYMETHOD_WFD          = "WiFiDirect",
    DEVICEDISPLAY_DISCOVERYMETHOD_ASP_INFRA    = "AspInfra",
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3941498653, 27187, 17617, 148, 65, 95, 70, 222, 242, 49, 152}, 9))], [])*/PROPERTYKEY PKEY_Device_BIOSVersion = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3941498653, 27187, 17617, 148, 65, 95, 70, 222, 242, 49, 152}, 9))], [])*/PROPERTYKEY(GUID("EAEE7F1D-6A33-44D1-9441-5F46DEF23198"), 9);

enum : GUID
{
    FMTID_WSD  = GUID("92506491-ff95-4724-a05a-5b81885a7c92"),
    FMTID_PNPX = GUID("656a3bb3-ecc0-43fd-8477-4ae0404a96cd"),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 4096))], [])*/PROPERTYKEY
{
    PKEY_PNPX_GlobalIdentity  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 4096))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 4096),
    PKEY_PNPX_Types           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 4096))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 4097),
    PKEY_PNPX_Scopes          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 4096))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 4098),
    PKEY_PNPX_XAddrs          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 4096))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 4099),
    PKEY_PNPX_MetadataVersion = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 4096))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 4100),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 4101))], [])*/PROPERTYKEY
{
    PKEY_PNPX_ID              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 4101))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 4101),
    PKEY_PNPX_RemoteAddress   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 4101))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 4102),
    PKEY_PNPX_RootProxy       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 4101))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 4103),
    PKEY_PNPX_ManufacturerUrl = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 4101))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 8193),
    PKEY_PNPX_ModelUrl        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 4101))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 8196),
    PKEY_PNPX_Upc             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 4101))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 8197),
    PKEY_PNPX_PresentationUrl = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 4101))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 8198),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 12289))], [])*/PROPERTYKEY PKEY_PNPX_FirmwareVersion = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 12289))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 12289);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 12290))], [])*/PROPERTYKEY
{
    PKEY_PNPX_SerialNumber     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 12290))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 12290),
    PKEY_PNPX_DeviceCategory   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 12290))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 12292),
    PKEY_PNPX_SecureChannel    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 12290))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 28673),
    PKEY_PNPX_CompactSignature = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 12290))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 28674),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 28675))], [])*/PROPERTYKEY PKEY_PNPX_DeviceCertHash = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 28675))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 28675);

enum : const(wchar)*
{
    PNPX_DEVICECATEGORY_COMPUTER               = "Computers",
    PNPX_DEVICECATEGORY_INPUTDEVICE            = "Input",
    PNPX_DEVICECATEGORY_PRINTER                = "Printers",
    PNPX_DEVICECATEGORY_SCANNER                = "Scanners",
    PNPX_DEVICECATEGORY_FAX                    = "FAX",
    PNPX_DEVICECATEGORY_MFP                    = "MFP",
    PNPX_DEVICECATEGORY_CAMERA                 = "Cameras",
    PNPX_DEVICECATEGORY_STORAGE                = "Storage",
    PNPX_DEVICECATEGORY_NETWORK_INFRASTRUCTURE = "NetworkInfrastructure",
    PNPX_DEVICECATEGORY_DISPLAYS               = "Displays",
    PNPX_DEVICECATEGORY_MULTIMEDIA_DEVICE      = "MediaDevices",
    PNPX_DEVICECATEGORY_GAMING_DEVICE          = "Gaming",
    PNPX_DEVICECATEGORY_TELEPHONE              = "Phones",
    PNPX_DEVICECATEGORY_HOME_AUTOMATION_SYSTEM = "HomeAutomation",
    PNPX_DEVICECATEGORY_HOME_SECURITY_SYSTEM   = "HomeSecurity",
    PNPX_DEVICECATEGORY_OTHER                  = "Other",
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 12293))], [])*/PROPERTYKEY PKEY_PNPX_DeviceCategory_Desc = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 12293))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 12293);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 12304))], [])*/PROPERTYKEY PKEY_PNPX_Category_Desc_NonPlural = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 12304))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 12304);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 12294))], [])*/PROPERTYKEY PKEY_PNPX_PhysicalAddress = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 12294))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 12294);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 12295))], [])*/PROPERTYKEY
{
    PKEY_PNPX_NetworkInterfaceLuid = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 12295))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 12295),
    PKEY_PNPX_NetworkInterfaceGuid = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 12295))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 12296),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 12297))], [])*/PROPERTYKEY
{
    PKEY_PNPX_IpAddress          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 12297))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 12297),
    PKEY_PNPX_ServiceAddress     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 12297))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 16384),
    PKEY_PNPX_ServiceId          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 12297))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 16385),
    PKEY_PNPX_ServiceTypes       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 12297))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 16386),
    PKEY_PNPX_ServiceControlUrl  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 12297))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 16388),
    PKEY_PNPX_ServiceDescUrl     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 12297))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 16389),
    PKEY_PNPX_ServiceEventSubUrl = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 12297))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 16390),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 20480))], [])*/PROPERTYKEY
{
    PKEY_PNPX_DomainName = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 20480))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 20480),
    PKEY_PNPX_ShareName  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 20480))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 20482),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 24576))], [])*/PROPERTYKEY PKEY_SSDP_AltLocationInfo = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 24576))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 24576);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 24577))], [])*/PROPERTYKEY
{
    PKEY_SSDP_DevLifeTime      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 24577))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 24577),
    PKEY_SSDP_NetworkInterface = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 24577))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 24578),
}

enum GUID FMTID_PNPXDynamicProperty = GUID("4fc5077e-b686-44be-93e3-86cafe368ccd");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1338312574, 46726, 17598, 147, 227, 134, 202, 254, 54, 140, 205}, 1))], [])*/PROPERTYKEY
{
    PKEY_PNPX_Installable     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1338312574, 46726, 17598, 147, 227, 134, 202, 254, 54, 140, 205}, 1))], [])*/PROPERTYKEY(GUID("4FC5077E-B686-44BE-93E3-86CAFE368CCD"), 1),
    PKEY_PNPX_Associated      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1338312574, 46726, 17598, 147, 227, 134, 202, 254, 54, 140, 205}, 1))], [])*/PROPERTYKEY(GUID("4FC5077E-B686-44BE-93E3-86CAFE368CCD"), 2),
    PKEY_PNPX_CompatibleTypes = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1338312574, 46726, 17598, 147, 227, 134, 202, 254, 54, 140, 205}, 1))], [])*/PROPERTYKEY(GUID("4FC5077E-B686-44BE-93E3-86CAFE368CCD"), 3),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1338312574, 46726, 17598, 147, 227, 134, 202, 254, 54, 140, 205}, 4))], [])*/PROPERTYKEY PKEY_PNPX_InstallState = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1338312574, 46726, 17598, 147, 227, 134, 202, 254, 54, 140, 205}, 4))], [])*/PROPERTYKEY(GUID("4FC5077E-B686-44BE-93E3-86CAFE368CCD"), 4);

enum : uint
{
    PNPX_INSTALLSTATE_NOTINSTALLED = 0x00000000U,
    PNPX_INSTALLSTATE_INSTALLED    = 0x00000001U,
    PNPX_INSTALLSTATE_INSTALLING   = 0x00000002U,
    PNPX_INSTALLSTATE_FAILED       = 0x00000003U,
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 28672))], [])*/PROPERTYKEY
{
    PKEY_PNPX_Removable       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 28672))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 28672),
    PKEY_PNPX_IPBusEnumerated = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1701460915, 60608, 17405, 132, 119, 74, 224, 64, 74, 150, 205}, 28672))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 28688),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3736970298, 14259, 17283, 145, 231, 68, 152, 218, 41, 149, 171}, 1))], [])*/PROPERTYKEY
{
    PKEY_WNET_Scope       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3736970298, 14259, 17283, 145, 231, 68, 152, 218, 41, 149, 171}, 1))], [])*/PROPERTYKEY(GUID("DEBDA43A-37B3-4383-91E7-4498DA2995AB"), 1),
    PKEY_WNET_Type        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3736970298, 14259, 17283, 145, 231, 68, 152, 218, 41, 149, 171}, 1))], [])*/PROPERTYKEY(GUID("DEBDA43A-37B3-4383-91E7-4498DA2995AB"), 2),
    PKEY_WNET_DisplayType = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3736970298, 14259, 17283, 145, 231, 68, 152, 218, 41, 149, 171}, 1))], [])*/PROPERTYKEY(GUID("DEBDA43A-37B3-4383-91E7-4498DA2995AB"), 3),
    PKEY_WNET_Usage       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3736970298, 14259, 17283, 145, 231, 68, 152, 218, 41, 149, 171}, 1))], [])*/PROPERTYKEY(GUID("DEBDA43A-37B3-4383-91E7-4498DA2995AB"), 4),
    PKEY_WNET_LocalName   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3736970298, 14259, 17283, 145, 231, 68, 152, 218, 41, 149, 171}, 1))], [])*/PROPERTYKEY(GUID("DEBDA43A-37B3-4383-91E7-4498DA2995AB"), 5),
    PKEY_WNET_RemoteName  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3736970298, 14259, 17283, 145, 231, 68, 152, 218, 41, 149, 171}, 1))], [])*/PROPERTYKEY(GUID("DEBDA43A-37B3-4383-91E7-4498DA2995AB"), 6),
    PKEY_WNET_Comment     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3736970298, 14259, 17283, 145, 231, 68, 152, 218, 41, 149, 171}, 1))], [])*/PROPERTYKEY(GUID("DEBDA43A-37B3-4383-91E7-4498DA2995AB"), 7),
    PKEY_WNET_Provider    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3736970298, 14259, 17283, 145, 231, 68, 152, 218, 41, 149, 171}, 1))], [])*/PROPERTYKEY(GUID("DEBDA43A-37B3-4383-91E7-4498DA2995AB"), 8),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2283342720, 18052, 4570, 162, 106, 0, 2, 179, 152, 142, 129}, 1))], [])*/PROPERTYKEY
{
    PKEY_WCN_Version          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2283342720, 18052, 4570, 162, 106, 0, 2, 179, 152, 142, 129}, 1))], [])*/PROPERTYKEY(GUID("88190B80-4684-11DA-A26A-0002B3988E81"), 1),
    PKEY_WCN_RequestType      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2283342720, 18052, 4570, 162, 106, 0, 2, 179, 152, 142, 129}, 1))], [])*/PROPERTYKEY(GUID("88190B81-4684-11DA-A26A-0002B3988E81"), 2),
    PKEY_WCN_AuthType         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2283342720, 18052, 4570, 162, 106, 0, 2, 179, 152, 142, 129}, 1))], [])*/PROPERTYKEY(GUID("88190B82-4684-11DA-A26A-0002B3988E81"), 3),
    PKEY_WCN_EncryptType      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2283342720, 18052, 4570, 162, 106, 0, 2, 179, 152, 142, 129}, 1))], [])*/PROPERTYKEY(GUID("88190B83-4684-11DA-A26A-0002B3988E81"), 4),
    PKEY_WCN_ConnType         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2283342720, 18052, 4570, 162, 106, 0, 2, 179, 152, 142, 129}, 1))], [])*/PROPERTYKEY(GUID("88190B84-4684-11DA-A26A-0002B3988E81"), 5),
    PKEY_WCN_ConfigMethods    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2283342720, 18052, 4570, 162, 106, 0, 2, 179, 152, 142, 129}, 1))], [])*/PROPERTYKEY(GUID("88190B85-4684-11DA-A26A-0002B3988E81"), 6),
    PKEY_WCN_RfBand           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2283342720, 18052, 4570, 162, 106, 0, 2, 179, 152, 142, 129}, 1))], [])*/PROPERTYKEY(GUID("88190B87-4684-11DA-A26A-0002B3988E81"), 8),
    PKEY_WCN_AssocState       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2283342720, 18052, 4570, 162, 106, 0, 2, 179, 152, 142, 129}, 1))], [])*/PROPERTYKEY(GUID("88190B88-4684-11DA-A26A-0002B3988E81"), 9),
    PKEY_WCN_ConfigError      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2283342720, 18052, 4570, 162, 106, 0, 2, 179, 152, 142, 129}, 1))], [])*/PROPERTYKEY(GUID("88190B89-4684-11DA-A26A-0002B3988E81"), 10),
    PKEY_WCN_ConfigState      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2283342720, 18052, 4570, 162, 106, 0, 2, 179, 152, 142, 129}, 1))], [])*/PROPERTYKEY(GUID("88190B89-4684-11DA-A26A-0002B3988E81"), 11),
    PKEY_WCN_DevicePasswordId = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2283342720, 18052, 4570, 162, 106, 0, 2, 179, 152, 142, 129}, 1))], [])*/PROPERTYKEY(GUID("88190B89-4684-11DA-A26A-0002B3988E81"), 12),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2283342729, 18052, 4570, 162, 106, 0, 2, 179, 152, 142, 129}, 13))], [])*/PROPERTYKEY
{
    PKEY_WCN_OSVersion       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2283342729, 18052, 4570, 162, 106, 0, 2, 179, 152, 142, 129}, 13))], [])*/PROPERTYKEY(GUID("88190B89-4684-11DA-A26A-0002B3988E81"), 13),
    PKEY_WCN_VendorExtension = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2283342729, 18052, 4570, 162, 106, 0, 2, 179, 152, 142, 129}, 13))], [])*/PROPERTYKEY(GUID("88190B8A-4684-11DA-A26A-0002B3988E81"), 14),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2283342731, 18052, 4570, 162, 106, 0, 2, 179, 152, 142, 129}, 15))], [])*/PROPERTYKEY PKEY_WCN_RegistrarType = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2283342731, 18052, 4570, 162, 106, 0, 2, 179, 152, 142, 129}, 15))], [])*/PROPERTYKEY(GUID("88190B8B-4684-11DA-A26A-0002B3988E81"), 15);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1588543218, 57546, 17816, 191, 6, 113, 237, 29, 157, 217, 83}, 4097))], [])*/PROPERTYKEY
{
    PKEY_Hardware_Devinst          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1588543218, 57546, 17816, 191, 6, 113, 237, 29, 157, 217, 83}, 4097))], [])*/PROPERTYKEY(GUID("5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953"), 4097),
    PKEY_Hardware_DisplayAttribute = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1588543218, 57546, 17816, 191, 6, 113, 237, 29, 157, 217, 83}, 4097))], [])*/PROPERTYKEY(GUID("5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953"), 5),
    PKEY_Hardware_DriverDate       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1588543218, 57546, 17816, 191, 6, 113, 237, 29, 157, 217, 83}, 4097))], [])*/PROPERTYKEY(GUID("5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953"), 11),
    PKEY_Hardware_DriverProvider   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1588543218, 57546, 17816, 191, 6, 113, 237, 29, 157, 217, 83}, 4097))], [])*/PROPERTYKEY(GUID("5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953"), 10),
    PKEY_Hardware_DriverVersion    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1588543218, 57546, 17816, 191, 6, 113, 237, 29, 157, 217, 83}, 4097))], [])*/PROPERTYKEY(GUID("5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953"), 9),
    PKEY_Hardware_Function         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1588543218, 57546, 17816, 191, 6, 113, 237, 29, 157, 217, 83}, 4097))], [])*/PROPERTYKEY(GUID("5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953"), 4099),
    PKEY_Hardware_Icon             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1588543218, 57546, 17816, 191, 6, 113, 237, 29, 157, 217, 83}, 4097))], [])*/PROPERTYKEY(GUID("5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953"), 3),
    PKEY_Hardware_Image            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1588543218, 57546, 17816, 191, 6, 113, 237, 29, 157, 217, 83}, 4097))], [])*/PROPERTYKEY(GUID("5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953"), 4098),
    PKEY_Hardware_Manufacturer     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1588543218, 57546, 17816, 191, 6, 113, 237, 29, 157, 217, 83}, 4097))], [])*/PROPERTYKEY(GUID("5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953"), 6),
    PKEY_Hardware_Model            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1588543218, 57546, 17816, 191, 6, 113, 237, 29, 157, 217, 83}, 4097))], [])*/PROPERTYKEY(GUID("5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953"), 7),
    PKEY_Hardware_Name             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1588543218, 57546, 17816, 191, 6, 113, 237, 29, 157, 217, 83}, 4097))], [])*/PROPERTYKEY(GUID("5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953"), 2),
    PKEY_Hardware_SerialNumber     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1588543218, 57546, 17816, 191, 6, 113, 237, 29, 157, 217, 83}, 4097))], [])*/PROPERTYKEY(GUID("5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953"), 8),
    PKEY_Hardware_ShellAttributes  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1588543218, 57546, 17816, 191, 6, 113, 237, 29, 157, 217, 83}, 4097))], [])*/PROPERTYKEY(GUID("5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953"), 4100),
    PKEY_Hardware_Status           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1588543218, 57546, 17816, 191, 6, 113, 237, 29, 157, 217, 83}, 4097))], [])*/PROPERTYKEY(GUID("5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953"), 4096),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY
{
    PKEY_NAME                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY(GUID("B725F130-47EF-101A-A5F1-02608C9EEBAC"), 10),
    PKEY_Device_DeviceDesc         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 2),
    PKEY_Device_HardwareIds        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 3),
    PKEY_Device_CompatibleIds      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 4),
    PKEY_Device_Service            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 6),
    PKEY_Device_Class              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 9),
    PKEY_Device_ClassGuid          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 10),
    PKEY_Device_Driver             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 11),
    PKEY_Device_ConfigFlags        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 12),
    PKEY_Device_Manufacturer       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 13),
    PKEY_Device_FriendlyName       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 14),
    PKEY_Device_LocationInfo       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 15),
    PKEY_Device_PDOName            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 16),
    PKEY_Device_Capabilities       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 17),
    PKEY_Device_UINumber           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 18),
    PKEY_Device_UpperFilters       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 19),
    PKEY_Device_LowerFilters       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 20),
    PKEY_Device_BusTypeGuid        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 21),
    PKEY_Device_LegacyBusType      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 22),
    PKEY_Device_BusNumber          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 23),
    PKEY_Device_EnumeratorName     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 24),
    PKEY_Device_Security           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 25),
    PKEY_Device_SecuritySDS        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 26),
    PKEY_Device_DevType            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 27),
    PKEY_Device_Exclusive          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 28),
    PKEY_Device_Characteristics    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 29),
    PKEY_Device_Address            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 30),
    PKEY_Device_UINumberDescFormat = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 31),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2757502286, 57116, 20221, 128, 32, 103, 209, 70, 168, 80, 224}, 32))], [])*/PROPERTYKEY
{
    PKEY_Device_PowerData             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2757502286, 57116, 20221, 128, 32, 103, 209, 70, 168, 80, 224}, 32))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 32),
    PKEY_Device_RemovalPolicy         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2757502286, 57116, 20221, 128, 32, 103, 209, 70, 168, 80, 224}, 32))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 33),
    PKEY_Device_RemovalPolicyDefault  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2757502286, 57116, 20221, 128, 32, 103, 209, 70, 168, 80, 224}, 32))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 34),
    PKEY_Device_RemovalPolicyOverride = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2757502286, 57116, 20221, 128, 32, 103, 209, 70, 168, 80, 224}, 32))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 35),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2757502286, 57116, 20221, 128, 32, 103, 209, 70, 168, 80, 224}, 36))], [])*/PROPERTYKEY
{
    PKEY_Device_InstallState       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2757502286, 57116, 20221, 128, 32, 103, 209, 70, 168, 80, 224}, 36))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 36),
    PKEY_Device_LocationPaths      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2757502286, 57116, 20221, 128, 32, 103, 209, 70, 168, 80, 224}, 36))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 37),
    PKEY_Device_BaseContainerId    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2757502286, 57116, 20221, 128, 32, 103, 209, 70, 168, 80, 224}, 36))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 38),
    PKEY_Device_DevNodeStatus      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2757502286, 57116, 20221, 128, 32, 103, 209, 70, 168, 80, 224}, 36))], [])*/PROPERTYKEY(GUID("4340A6C5-93FA-4706-972C-7B648008A5A7"), 2),
    PKEY_Device_ProblemCode        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2757502286, 57116, 20221, 128, 32, 103, 209, 70, 168, 80, 224}, 36))], [])*/PROPERTYKEY(GUID("4340A6C5-93FA-4706-972C-7B648008A5A7"), 3),
    PKEY_Device_EjectionRelations  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2757502286, 57116, 20221, 128, 32, 103, 209, 70, 168, 80, 224}, 36))], [])*/PROPERTYKEY(GUID("4340A6C5-93FA-4706-972C-7B648008A5A7"), 4),
    PKEY_Device_RemovalRelations   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2757502286, 57116, 20221, 128, 32, 103, 209, 70, 168, 80, 224}, 36))], [])*/PROPERTYKEY(GUID("4340A6C5-93FA-4706-972C-7B648008A5A7"), 5),
    PKEY_Device_PowerRelations     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2757502286, 57116, 20221, 128, 32, 103, 209, 70, 168, 80, 224}, 36))], [])*/PROPERTYKEY(GUID("4340A6C5-93FA-4706-972C-7B648008A5A7"), 6),
    PKEY_Device_BusRelations       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2757502286, 57116, 20221, 128, 32, 103, 209, 70, 168, 80, 224}, 36))], [])*/PROPERTYKEY(GUID("4340A6C5-93FA-4706-972C-7B648008A5A7"), 7),
    PKEY_Device_Parent             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2757502286, 57116, 20221, 128, 32, 103, 209, 70, 168, 80, 224}, 36))], [])*/PROPERTYKEY(GUID("4340A6C5-93FA-4706-972C-7B648008A5A7"), 8),
    PKEY_Device_Children           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2757502286, 57116, 20221, 128, 32, 103, 209, 70, 168, 80, 224}, 36))], [])*/PROPERTYKEY(GUID("4340A6C5-93FA-4706-972C-7B648008A5A7"), 9),
    PKEY_Device_Siblings           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2757502286, 57116, 20221, 128, 32, 103, 209, 70, 168, 80, 224}, 36))], [])*/PROPERTYKEY(GUID("4340A6C5-93FA-4706-972C-7B648008A5A7"), 10),
    PKEY_Device_TransportRelations = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2757502286, 57116, 20221, 128, 32, 103, 209, 70, 168, 80, 224}, 36))], [])*/PROPERTYKEY(GUID("4340A6C5-93FA-4706-972C-7B648008A5A7"), 11),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2152296704, 35955, 18617, 170, 217, 206, 56, 126, 25, 197, 110}, 2))], [])*/PROPERTYKEY
{
    PKEY_Device_Reported               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2152296704, 35955, 18617, 170, 217, 206, 56, 126, 25, 197, 110}, 2))], [])*/PROPERTYKEY(GUID("80497100-8C73-48B9-AAD9-CE387E19C56E"), 2),
    PKEY_Device_Legacy                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2152296704, 35955, 18617, 170, 217, 206, 56, 126, 25, 197, 110}, 2))], [])*/PROPERTYKEY(GUID("80497100-8C73-48B9-AAD9-CE387E19C56E"), 3),
    PKEY_Device_InstanceId             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2152296704, 35955, 18617, 170, 217, 206, 56, 126, 25, 197, 110}, 2))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 256),
    PKEY_Device_ContainerId            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2152296704, 35955, 18617, 170, 217, 206, 56, 126, 25, 197, 110}, 2))], [])*/PROPERTYKEY(GUID("8C7ED206-3F8A-4827-B3AB-AE9E1FAEFC6C"), 2),
    PKEY_Device_ModelId                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2152296704, 35955, 18617, 170, 217, 206, 56, 126, 25, 197, 110}, 2))], [])*/PROPERTYKEY(GUID("80D81EA6-7473-4B0C-8216-EFC11A2C4C8B"), 2),
    PKEY_Device_FriendlyNameAttributes = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2152296704, 35955, 18617, 170, 217, 206, 56, 126, 25, 197, 110}, 2))], [])*/PROPERTYKEY(GUID("80D81EA6-7473-4B0C-8216-EFC11A2C4C8B"), 3),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2161647270, 29811, 19212, 130, 22, 239, 193, 26, 44, 76, 139}, 4))], [])*/PROPERTYKEY PKEY_Device_ManufacturerAttributes = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2161647270, 29811, 19212, 130, 22, 239, 193, 26, 44, 76, 139}, 4))], [])*/PROPERTYKEY(GUID("80D81EA6-7473-4B0C-8216-EFC11A2C4C8B"), 4);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2161647270, 29811, 19212, 130, 22, 239, 193, 26, 44, 76, 139}, 5))], [])*/PROPERTYKEY PKEY_Device_PresenceNotForDevice = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2161647270, 29811, 19212, 130, 22, 239, 193, 26, 44, 76, 139}, 5))], [])*/PROPERTYKEY(GUID("80D81EA6-7473-4B0C-8216-EFC11A2C4C8B"), 5);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2161647270, 29811, 19212, 130, 22, 239, 193, 26, 44, 76, 139}, 6))], [])*/PROPERTYKEY
{
    PKEY_Device_SignalStrength              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2161647270, 29811, 19212, 130, 22, 239, 193, 26, 44, 76, 139}, 6))], [])*/PROPERTYKEY(GUID("80D81EA6-7473-4B0C-8216-EFC11A2C4C8B"), 6),
    PKEY_Device_IsAssociateableByUserAction = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2161647270, 29811, 19212, 130, 22, 239, 193, 26, 44, 76, 139}, 6))], [])*/PROPERTYKEY(GUID("80D81EA6-7473-4B0C-8216-EFC11A2C4C8B"), 7),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 1))], [])*/PROPERTYKEY PKEY_Numa_Proximity_Domain = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 1))], [])*/PROPERTYKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 1);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 2))], [])*/PROPERTYKEY PKEY_Device_DHP_Rebalance_Policy = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 2))], [])*/PROPERTYKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 2);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 3))], [])*/PROPERTYKEY
{
    PKEY_Device_Numa_Node             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 3))], [])*/PROPERTYKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 3),
    PKEY_Device_BusReportedDeviceDesc = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 3))], [])*/PROPERTYKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 4),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2212127526, 38822, 16520, 148, 83, 161, 146, 63, 87, 59, 41}, 9))], [])*/PROPERTYKEY
{
    PKEY_Device_InstallInProgress   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2212127526, 38822, 16520, 148, 83, 161, 146, 63, 87, 59, 41}, 9))], [])*/PROPERTYKEY(GUID("83DA6326-97A6-4088-9453-A1923F573B29"), 9),
    PKEY_Device_DriverDate          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2212127526, 38822, 16520, 148, 83, 161, 146, 63, 87, 59, 41}, 9))], [])*/PROPERTYKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 2),
    PKEY_Device_DriverVersion       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2212127526, 38822, 16520, 148, 83, 161, 146, 63, 87, 59, 41}, 9))], [])*/PROPERTYKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 3),
    PKEY_Device_DriverDesc          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2212127526, 38822, 16520, 148, 83, 161, 146, 63, 87, 59, 41}, 9))], [])*/PROPERTYKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 4),
    PKEY_Device_DriverInfPath       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2212127526, 38822, 16520, 148, 83, 161, 146, 63, 87, 59, 41}, 9))], [])*/PROPERTYKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 5),
    PKEY_Device_DriverInfSection    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2212127526, 38822, 16520, 148, 83, 161, 146, 63, 87, 59, 41}, 9))], [])*/PROPERTYKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 6),
    PKEY_Device_DriverInfSectionExt = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2212127526, 38822, 16520, 148, 83, 161, 146, 63, 87, 59, 41}, 9))], [])*/PROPERTYKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 7),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2830656989, 11837, 16532, 173, 151, 229, 147, 167, 12, 117, 214}, 8))], [])*/PROPERTYKEY
{
    PKEY_Device_MatchingDeviceId       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2830656989, 11837, 16532, 173, 151, 229, 147, 167, 12, 117, 214}, 8))], [])*/PROPERTYKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 8),
    PKEY_Device_DriverProvider         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2830656989, 11837, 16532, 173, 151, 229, 147, 167, 12, 117, 214}, 8))], [])*/PROPERTYKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 9),
    PKEY_Device_DriverPropPageProvider = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2830656989, 11837, 16532, 173, 151, 229, 147, 167, 12, 117, 214}, 8))], [])*/PROPERTYKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 10),
    PKEY_Device_DriverCoInstallers     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2830656989, 11837, 16532, 173, 151, 229, 147, 167, 12, 117, 214}, 8))], [])*/PROPERTYKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 11),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2830656989, 11837, 16532, 173, 151, 229, 147, 167, 12, 117, 214}, 12))], [])*/PROPERTYKEY
{
    PKEY_Device_ResourcePickerTags       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2830656989, 11837, 16532, 173, 151, 229, 147, 167, 12, 117, 214}, 12))], [])*/PROPERTYKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 12),
    PKEY_Device_ResourcePickerExceptions = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2830656989, 11837, 16532, 173, 151, 229, 147, 167, 12, 117, 214}, 12))], [])*/PROPERTYKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 13),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2830656989, 11837, 16532, 173, 151, 229, 147, 167, 12, 117, 214}, 14))], [])*/PROPERTYKEY
{
    PKEY_Device_DriverRank             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2830656989, 11837, 16532, 173, 151, 229, 147, 167, 12, 117, 214}, 14))], [])*/PROPERTYKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 14),
    PKEY_Device_DriverLogoLevel        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2830656989, 11837, 16532, 173, 151, 229, 147, 167, 12, 117, 214}, 14))], [])*/PROPERTYKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 15),
    PKEY_Device_NoConnectSound         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2830656989, 11837, 16532, 173, 151, 229, 147, 167, 12, 117, 214}, 14))], [])*/PROPERTYKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 17),
    PKEY_Device_GenericDriverInstalled = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2830656989, 11837, 16532, 173, 151, 229, 147, 167, 12, 117, 214}, 14))], [])*/PROPERTYKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 18),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2830656989, 11837, 16532, 173, 151, 229, 147, 167, 12, 117, 214}, 19))], [])*/PROPERTYKEY PKEY_Device_AdditionalSoftwareRequested = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2830656989, 11837, 16532, 173, 151, 229, 147, 167, 12, 117, 214}, 19))], [])*/PROPERTYKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 19);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2950264384, 34467, 16912, 182, 124, 40, 156, 65, 170, 190, 85}, 2))], [])*/PROPERTYKEY
{
    PKEY_Device_SafeRemovalRequired         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2950264384, 34467, 16912, 182, 124, 40, 156, 65, 170, 190, 85}, 2))], [])*/PROPERTYKEY(GUID("AFD97640-86A3-4210-B67C-289C41AABE55"), 2),
    PKEY_Device_SafeRemovalRequiredOverride = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2950264384, 34467, 16912, 182, 124, 40, 156, 65, 170, 190, 85}, 2))], [])*/PROPERTYKEY(GUID("AFD97640-86A3-4210-B67C-289C41AABE55"), 3),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3480468305, 15039, 17570, 133, 224, 154, 61, 199, 161, 33, 50}, 2))], [])*/PROPERTYKEY
{
    PKEY_DrvPkg_Model               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3480468305, 15039, 17570, 133, 224, 154, 61, 199, 161, 33, 50}, 2))], [])*/PROPERTYKEY(GUID("CF73BB51-3ABF-44A2-85E0-9A3DC7A12132"), 2),
    PKEY_DrvPkg_VendorWebSite       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3480468305, 15039, 17570, 133, 224, 154, 61, 199, 161, 33, 50}, 2))], [])*/PROPERTYKEY(GUID("CF73BB51-3ABF-44A2-85E0-9A3DC7A12132"), 3),
    PKEY_DrvPkg_DetailedDescription = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3480468305, 15039, 17570, 133, 224, 154, 61, 199, 161, 33, 50}, 2))], [])*/PROPERTYKEY(GUID("CF73BB51-3ABF-44A2-85E0-9A3DC7A12132"), 4),
    PKEY_DrvPkg_DocumentationLink   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3480468305, 15039, 17570, 133, 224, 154, 61, 199, 161, 33, 50}, 2))], [])*/PROPERTYKEY(GUID("CF73BB51-3ABF-44A2-85E0-9A3DC7A12132"), 5),
    PKEY_DrvPkg_Icon                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3480468305, 15039, 17570, 133, 224, 154, 61, 199, 161, 33, 50}, 2))], [])*/PROPERTYKEY(GUID("CF73BB51-3ABF-44A2-85E0-9A3DC7A12132"), 6),
    PKEY_DrvPkg_BrandingIcon        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3480468305, 15039, 17570, 133, 224, 154, 61, 199, 161, 33, 50}, 2))], [])*/PROPERTYKEY(GUID("CF73BB51-3ABF-44A2-85E0-9A3DC7A12132"), 7),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/PROPERTYKEY
{
    PKEY_DeviceClass_UpperFilters      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/PROPERTYKEY(GUID("4321918B-F69E-470D-A5DE-4D88C75AD24B"), 19),
    PKEY_DeviceClass_LowerFilters      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/PROPERTYKEY(GUID("4321918B-F69E-470D-A5DE-4D88C75AD24B"), 20),
    PKEY_DeviceClass_Security          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/PROPERTYKEY(GUID("4321918B-F69E-470D-A5DE-4D88C75AD24B"), 25),
    PKEY_DeviceClass_SecuritySDS       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/PROPERTYKEY(GUID("4321918B-F69E-470D-A5DE-4D88C75AD24B"), 26),
    PKEY_DeviceClass_DevType           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/PROPERTYKEY(GUID("4321918B-F69E-470D-A5DE-4D88C75AD24B"), 27),
    PKEY_DeviceClass_Exclusive         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/PROPERTYKEY(GUID("4321918B-F69E-470D-A5DE-4D88C75AD24B"), 28),
    PKEY_DeviceClass_Characteristics   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/PROPERTYKEY(GUID("4321918B-F69E-470D-A5DE-4D88C75AD24B"), 29),
    PKEY_DeviceClass_Name              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/PROPERTYKEY(GUID("259ABFFC-50A7-47CE-AF08-68C9A7D73366"), 2),
    PKEY_DeviceClass_ClassName         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/PROPERTYKEY(GUID("259ABFFC-50A7-47CE-AF08-68C9A7D73366"), 3),
    PKEY_DeviceClass_Icon              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/PROPERTYKEY(GUID("259ABFFC-50A7-47CE-AF08-68C9A7D73366"), 4),
    PKEY_DeviceClass_ClassInstaller    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/PROPERTYKEY(GUID("259ABFFC-50A7-47CE-AF08-68C9A7D73366"), 5),
    PKEY_DeviceClass_PropPageProvider  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/PROPERTYKEY(GUID("259ABFFC-50A7-47CE-AF08-68C9A7D73366"), 6),
    PKEY_DeviceClass_NoInstallClass    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/PROPERTYKEY(GUID("259ABFFC-50A7-47CE-AF08-68C9A7D73366"), 7),
    PKEY_DeviceClass_NoDisplayClass    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/PROPERTYKEY(GUID("259ABFFC-50A7-47CE-AF08-68C9A7D73366"), 8),
    PKEY_DeviceClass_SilentInstall     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/PROPERTYKEY(GUID("259ABFFC-50A7-47CE-AF08-68C9A7D73366"), 9),
    PKEY_DeviceClass_NoUseClass        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/PROPERTYKEY(GUID("259ABFFC-50A7-47CE-AF08-68C9A7D73366"), 10),
    PKEY_DeviceClass_DefaultService    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/PROPERTYKEY(GUID("259ABFFC-50A7-47CE-AF08-68C9A7D73366"), 11),
    PKEY_DeviceClass_IconPath          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/PROPERTYKEY(GUID("259ABFFC-50A7-47CE-AF08-68C9A7D73366"), 12),
    PKEY_DeviceClass_ClassCoInstallers = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/PROPERTYKEY(GUID("713D1703-A2E2-49F5-9214-56472EF3DA5C"), 2),
}

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-deviceinterface-friendlyname))], [])*/PROPERTYKEY
{
    PKEY_DeviceInterface_FriendlyName          = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-deviceinterface-friendlyname))], [])*/PROPERTYKEY(GUID("026E516E-B814-414B-83CD-856D6FEF4822"), 2),
    PKEY_DeviceInterface_Enabled               = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-deviceinterface-friendlyname))], [])*/PROPERTYKEY(GUID("026E516E-B814-414B-83CD-856D6FEF4822"), 3),
    PKEY_DeviceInterface_ClassGuid             = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-deviceinterface-friendlyname))], [])*/PROPERTYKEY(GUID("026E516E-B814-414B-83CD-856D6FEF4822"), 4),
    PKEY_DeviceInterfaceClass_DefaultInterface = /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/CoreAudio/pkey-deviceinterface-friendlyname))], [])*/PROPERTYKEY(GUID("14C83A99-0B3F-44B7-BE4C-A178D3990564"), 2),
}

enum uint FD_LONGHORN = 0x00000001U;
enum const(wchar)* FD_SUBKEY = "SOFTWARE\\Microsoft\\Function Discovery\\";

enum : const(wchar)*
{
    FCTN_CATEGORY_PNP                       = "Provider\\Microsoft.Base.PnP",
    FCTN_CATEGORY_REGISTRY                  = "Provider\\Microsoft.Base.Registry",
    FCTN_CATEGORY_SSDP                      = "Provider\\Microsoft.Networking.SSDP",
    FCTN_CATEGORY_WSDISCOVERY               = "Provider\\Microsoft.Networking.WSD",
    FCTN_CATEGORY_NETBIOS                   = "Provider\\Microsoft.Networking.Netbios",
    FCTN_CATEGORY_WCN                       = "Provider\\Microsoft.Networking.WCN",
    FCTN_CATEGORY_PUBLICATION               = "Provider\\Microsoft.Base.Publication",
    FCTN_CATEGORY_PNPXASSOCIATION           = "Provider\\Microsoft.PnPX.Association",
    FCTN_CATEGORY_BT                        = "Provider\\Microsoft.Devices.Bluetooth",
    FCTN_CATEGORY_WUSB                      = "Provider\\Microsoft.Devices.WirelessUSB",
    FCTN_CATEGORY_DEVICEDISPLAYOBJECTS      = "Provider\\Microsoft.Base.DeviceDisplayObjects",
    FCTN_CATEGORY_DEVQUERYOBJECTS           = "Provider\\Microsoft.Base.DevQueryObjects",
    FCTN_CATEGORY_NETWORKDEVICES            = "Layered\\Microsoft.Networking.Devices",
    FCTN_CATEGORY_DEVICES                   = "Layered\\Microsoft.Base.Devices",
    FCTN_CATEGORY_DEVICEFUNCTIONENUMERATORS = "Layered\\Microsoft.Devices.FunctionEnumerators",
    FCTN_CATEGORY_DEVICEPAIRING             = "Layered\\Microsoft.Base.DevicePairing",
}

enum const(wchar)* FCTN_SUBCAT_DEVICES_WSDPRINTERS = "WSDPrinters";

enum : const(wchar)*
{
    FCTN_SUBCAT_NETWORKDEVICES_SSDP = "SSDP",
    FCTN_SUBCAT_NETWORKDEVICES_WSD  = "WSD",
}

enum : const(wchar)*
{
    FCTN_SUBCAT_REG_PUBLICATION = "Publication",
    FCTN_SUBCAT_REG_DIRECTED    = "Directed",
}

enum : uint
{
    MAX_FDCONSTRAINTNAME_LENGTH  = 0x00000064U,
    MAX_FDCONSTRAINTVALUE_LENGTH = 0x000003e8U,
}

enum : const(wchar)*
{
    FD_QUERYCONSTRAINT_PROVIDERINSTANCEID = "ProviderInstanceID",
    FD_QUERYCONSTRAINT_SUBCATEGORY        = "Subcategory",
    FD_QUERYCONSTRAINT_RECURSESUBCATEGORY = "RecurseSubcategory",
    FD_QUERYCONSTRAINT_VISIBILITY         = "Visibility",
    FD_QUERYCONSTRAINT_COMCLSCONTEXT      = "COMClsContext",
    FD_QUERYCONSTRAINT_ROUTINGSCOPE       = "RoutingScope",
}

enum : const(wchar)*
{
    FD_CONSTRAINTVALUE_TRUE                        = "TRUE",
    FD_CONSTRAINTVALUE_FALSE                       = "FALSE",
    FD_CONSTRAINTVALUE_RECURSESUBCATEGORY_TRUE     = "TRUE",
    FD_CONSTRAINTVALUE_VISIBILITY_DEFAULT          = "0",
    FD_CONSTRAINTVALUE_VISIBILITY_ALL              = "1",
    FD_CONSTRAINTVALUE_COMCLSCONTEXT_INPROC_SERVER = "1",
    FD_CONSTRAINTVALUE_COMCLSCONTEXT_LOCAL_SERVER  = "4",
    FD_CONSTRAINTVALUE_PAIRED                      = "Paired",
    FD_CONSTRAINTVALUE_UNPAIRED                    = "UnPaired",
    FD_CONSTRAINTVALUE_ALL                         = "All",
    FD_CONSTRAINTVALUE_ROUTINGSCOPE_ALL            = "All",
    FD_CONSTRAINTVALUE_ROUTINGSCOPE_DIRECT         = "Direct",
}

enum : const(wchar)*
{
    FD_QUERYCONSTRAINT_PAIRING_STATE   = "PairingState",
    FD_QUERYCONSTRAINT_INQUIRY_TIMEOUT = "InquiryModeTimeout",
}

enum : const(wchar)*
{
    PROVIDERPNP_QUERYCONSTRAINT_INTERFACECLASS    = "InterfaceClass",
    PROVIDERPNP_QUERYCONSTRAINT_NOTPRESENT        = "NotPresent",
    PROVIDERPNP_QUERYCONSTRAINT_NOTIFICATIONSONLY = "NotifyOnly",
}

enum : const(wchar)*
{
    PNP_CONSTRAINTVALUE_NOTPRESENT        = "TRUE",
    PNP_CONSTRAINTVALUE_NOTIFICATIONSONLY = "TRUE",
}

enum : const(wchar)*
{
    PROVIDERSSDP_QUERYCONSTRAINT_TYPE              = "Type",
    PROVIDERSSDP_QUERYCONSTRAINT_CUSTOMXMLPROPERTY = "CustomXmlProperty",
}

enum : const(wchar)*
{
    SSDP_CONSTRAINTVALUE_TYPE_ALL           = "ssdp:all",
    SSDP_CONSTRAINTVALUE_TYPE_ROOT          = "upnp:rootdevice",
    SSDP_CONSTRAINTVALUE_TYPE_DEVICE_PREFIX = "urn:schemas-upnp-org:device:",
    SSDP_CONSTRAINTVALUE_TYPE_SVC_PREFIX    = "urn:schemas-upnp-org:service:",
}

enum : const(wchar)*
{
    PROVIDERWSD_QUERYCONSTRAINT_DIRECTEDADDRESS              = "RemoteAddress",
    PROVIDERWSD_QUERYCONSTRAINT_TYPE                         = "Type",
    PROVIDERWSD_QUERYCONSTRAINT_SCOPE                        = "Scope",
    PROVIDERWSD_QUERYCONSTRAINT_SECURITY_REQUIREMENTS        = "SecurityRequirements",
    PROVIDERWSD_QUERYCONSTRAINT_SSL_CERT_FOR_CLIENT_AUTH     = "SSLClientAuthCert",
    PROVIDERWSD_QUERYCONSTRAINT_SSL_CERTHASH_FOR_SERVER_AUTH = "SSLServerAuthCertHash",
}

enum : const(wchar)*
{
    WSD_CONSTRAINTVALUE_REQUIRE_SECURECHANNEL                      = "1",
    WSD_CONSTRAINTVALUE_REQUIRE_SECURECHANNEL_AND_COMPACTSIGNATURE = "2",
}

enum const(wchar)* WSD_CONSTRAINTVALUE_NO_TRUST_VERIFICATION = "3";

enum : const(wchar)*
{
    PROVIDERWNET_QUERYCONSTRAINT_TYPE         = "Type",
    PROVIDERWNET_QUERYCONSTRAINT_PROPERTIES   = "Properties",
    PROVIDERWNET_QUERYCONSTRAINT_RESOURCETYPE = "ResourceType",
}

enum : const(wchar)*
{
    WNET_CONSTRAINTVALUE_TYPE_ALL                   = "All",
    WNET_CONSTRAINTVALUE_TYPE_SERVER                = "Server",
    WNET_CONSTRAINTVALUE_TYPE_DOMAIN                = "Domain",
    WNET_CONSTRAINTVALUE_PROPERTIES_ALL             = "All",
    WNET_CONSTRAINTVALUE_PROPERTIES_LIMITED         = "Limited",
    WNET_CONSTRAINTVALUE_RESOURCETYPE_DISK          = "Disk",
    WNET_CONSTRAINTVALUE_RESOURCETYPE_PRINTER       = "Printer",
    WNET_CONSTRAINTVALUE_RESOURCETYPE_DISKORPRINTER = "DiskOrPrinter",
}

enum const(wchar)* ONLINE_PROVIDER_DEVICES_QUERYCONSTRAINT_OWNERNAME = "OwnerName";

enum : const(wchar)*
{
    PROVIDERDDO_QUERYCONSTRAINT_DEVICEFUNCTIONDISPLAYOBJECTS = "DeviceFunctionDisplayObjects",
    PROVIDERDDO_QUERYCONSTRAINT_ONLYCONNECTEDDEVICES         = "OnlyConnectedDevices",
    PROVIDERDDO_QUERYCONSTRAINT_DEVICEINTERFACES             = "DeviceInterfaces",
}

enum : HRESULT
{
    E_FDPAIRING_NOCONNECTION       = HRESULT(0x8fd00001),
    E_FDPAIRING_HWFAILURE          = HRESULT(0x8fd00002),
    E_FDPAIRING_AUTHFAILURE        = HRESULT(0x8fd00003),
    E_FDPAIRING_CONNECTTIMEOUT     = HRESULT(0x8fd00004),
    E_FDPAIRING_TOOMANYCONNECTIONS = HRESULT(0x8fd00005),
}

enum : HRESULT
{
    E_FDPAIRING_AUTHNOTALLOWED = HRESULT(0x8fd00006),
    E_FDPAIRING_IPBUSDISABLED  = HRESULT(0x8fd00007),
    E_FDPAIRING_NOPROFILES     = HRESULT(0x8fd00008),
}

// Interfaces

@GUID("cee8ccc9-4f6b-4469-a235-5a22869eef03")
struct PNPXAssociation;

@GUID("b8a27942-ade7-4085-aa6e-4fadc7ada1ef")
struct PNPXPairingHandler;

@GUID("c72be2ec-8e90-452c-b29a-ab8ff1c071fc")
struct FunctionDiscovery;

@GUID("e4796550-df61-448b-9193-13fc1341b163")
struct PropertyStore;

@GUID("ba818ce5-b55f-443f-ad39-2fe89be6191f")
struct FunctionInstanceCollection;

@GUID("edd36029-d753-4862-aa5b-5bccad2a4d29")
struct PropertyStoreCollection;

@GUID("5f6c1ba8-5330-422e-a368-572b244d3f87")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nn-functiondiscoveryapi-ifunctiondiscoverynotification
interface IFunctionDiscoveryNotification : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nf-functiondiscoveryapi-ifunctiondiscoverynotification-onupdate
    HRESULT OnUpdate(QueryUpdateAction enumQueryUpdateAction, ulong fdqcQueryContext, 
                     IFunctionInstance pIFunctionInstance);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nf-functiondiscoveryapi-ifunctiondiscoverynotification-onerror
    HRESULT OnError(HRESULT hr, ulong fdqcQueryContext, const(PWSTR) pszProvider);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nf-functiondiscoveryapi-ifunctiondiscoverynotification-onevent
    HRESULT OnEvent(uint dwEventID, ulong fdqcQueryContext, const(PWSTR) pszProvider);
}

@GUID("4df99b70-e148-4432-b004-4c9eeb535a5e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nn-functiondiscoveryapi-ifunctiondiscovery
interface IFunctionDiscovery : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nf-functiondiscoveryapi-ifunctiondiscovery-getinstancecollection
    HRESULT GetInstanceCollection(const(PWSTR) pszCategory, const(PWSTR) pszSubCategory, 
                                  BOOL fIncludeAllSubCategories, 
                                  IFunctionInstanceCollection* ppIFunctionInstanceCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nf-functiondiscoveryapi-ifunctiondiscovery-getinstance
    HRESULT GetInstance(const(PWSTR) pszFunctionInstanceIdentity, IFunctionInstance* ppIFunctionInstance);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nf-functiondiscoveryapi-ifunctiondiscovery-createinstancecollectionquery
    HRESULT CreateInstanceCollectionQuery(const(PWSTR) pszCategory, const(PWSTR) pszSubCategory, 
                                          BOOL fIncludeAllSubCategories, 
                                          IFunctionDiscoveryNotification pIFunctionDiscoveryNotification, 
                                          ulong* pfdqcQueryContext, 
                                          IFunctionInstanceCollectionQuery* ppIFunctionInstanceCollectionQuery);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nf-functiondiscoveryapi-ifunctiondiscovery-createinstancequery
    HRESULT CreateInstanceQuery(const(PWSTR) pszFunctionInstanceIdentity, 
                                IFunctionDiscoveryNotification pIFunctionDiscoveryNotification, 
                                ulong* pfdqcQueryContext, IFunctionInstanceQuery* ppIFunctionInstanceQuery);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nf-functiondiscoveryapi-ifunctiondiscovery-addinstance
    HRESULT AddInstance(SystemVisibilityFlags enumSystemVisibility, const(PWSTR) pszCategory, 
                        const(PWSTR) pszSubCategory, const(PWSTR) pszCategoryIdentity, 
                        IFunctionInstance* ppIFunctionInstance);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nf-functiondiscoveryapi-ifunctiondiscovery-removeinstance
    HRESULT RemoveInstance(SystemVisibilityFlags enumSystemVisibility, const(PWSTR) pszCategory, 
                           const(PWSTR) pszSubCategory, const(PWSTR) pszCategoryIdentity);
}

@GUID("33591c10-0bed-4f02-b0ab-1530d5533ee9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nn-functiondiscoveryapi-ifunctioninstance
interface IFunctionInstance : IServiceProvider
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nf-functiondiscoveryapi-ifunctioninstance-getid
    HRESULT GetID(ushort** ppszCoMemIdentity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nf-functiondiscoveryapi-ifunctioninstance-getproviderinstanceid
    HRESULT GetProviderInstanceID(ushort** ppszCoMemProviderInstanceIdentity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nf-functiondiscoveryapi-ifunctioninstance-openpropertystore
    HRESULT OpenPropertyStore(STGM dwStgAccess, IPropertyStore* ppIPropertyStore);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nf-functiondiscoveryapi-ifunctioninstance-getcategory
    HRESULT GetCategory(ushort** ppszCoMemCategory, ushort** ppszCoMemSubCategory);
}

@GUID("f0a3d895-855c-42a2-948d-2f97d450ecb1")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nn-functiondiscoveryapi-ifunctioninstancecollection
interface IFunctionInstanceCollection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nf-functiondiscoveryapi-ifunctioninstancecollection-getcount
    HRESULT GetCount(uint* pdwCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nf-functiondiscoveryapi-ifunctioninstancecollection-get
    HRESULT Get(const(PWSTR) pszInstanceIdentity, uint* pdwIndex, IFunctionInstance* ppIFunctionInstance);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nf-functiondiscoveryapi-ifunctioninstancecollection-item
    HRESULT Item(uint dwIndex, IFunctionInstance* ppIFunctionInstance);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nf-functiondiscoveryapi-ifunctioninstancecollection-add
    HRESULT Add(IFunctionInstance pIFunctionInstance);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nf-functiondiscoveryapi-ifunctioninstancecollection-remove
    HRESULT Remove(uint dwIndex, IFunctionInstance* ppIFunctionInstance);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nf-functiondiscoveryapi-ifunctioninstancecollection-delete
    HRESULT Delete(uint dwIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nf-functiondiscoveryapi-ifunctioninstancecollection-deleteall
    HRESULT DeleteAll();
}

@GUID("d14d9c30-12d2-42d8-bce4-c60c2bb226fa")
interface IPropertyStoreCollection : IUnknown
{
    HRESULT GetCount(uint* pdwCount);
    HRESULT Get(const(PWSTR) pszInstanceIdentity, uint* pdwIndex, IPropertyStore* ppIPropertyStore);
    HRESULT Item(uint dwIndex, IPropertyStore* ppIPropertyStore);
    HRESULT Add(IPropertyStore pIPropertyStore);
    HRESULT Remove(uint dwIndex, IPropertyStore* pIPropertyStore);
    HRESULT Delete(uint dwIndex);
    HRESULT DeleteAll();
}

@GUID("6242bc6b-90ec-4b37-bb46-e229fd84ed95")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nn-functiondiscoveryapi-ifunctioninstancequery
interface IFunctionInstanceQuery : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nf-functiondiscoveryapi-ifunctioninstancequery-execute
    HRESULT Execute(IFunctionInstance* ppIFunctionInstance);
}

@GUID("57cc6fd2-c09a-4289-bb72-25f04142058e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nn-functiondiscoveryapi-ifunctioninstancecollectionquery
interface IFunctionInstanceCollectionQuery : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nf-functiondiscoveryapi-ifunctioninstancecollectionquery-addqueryconstraint
    HRESULT AddQueryConstraint(const(PWSTR) pszConstraintName, const(PWSTR) pszConstraintValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nf-functiondiscoveryapi-ifunctioninstancecollectionquery-addpropertyconstraint
    HRESULT AddPropertyConstraint(const(PROPERTYKEY)* Key, const(PROPVARIANT)* pv, 
                                  PropertyConstraint enumPropertyConstraint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryapi/nf-functiondiscoveryapi-ifunctioninstancecollectionquery-execute
    HRESULT Execute(IFunctionInstanceCollection* ppIFunctionInstanceCollection);
}

@GUID("dcde394f-1478-4813-a402-f6fb10657222")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nn-functiondiscoveryprovider-ifunctiondiscoveryprovider
interface IFunctionDiscoveryProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-ifunctiondiscoveryprovider-initialize
    HRESULT Initialize(IFunctionDiscoveryProviderFactory pIFunctionDiscoveryProviderFactory, 
                       IFunctionDiscoveryNotification pIFunctionDiscoveryNotification, uint lcidUserDefault, 
                       uint* pdwStgAccessCapabilities);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-ifunctiondiscoveryprovider-query
    HRESULT Query(IFunctionDiscoveryProviderQuery pIFunctionDiscoveryProviderQuery, 
                  IFunctionInstanceCollection* ppIFunctionInstanceCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-ifunctiondiscoveryprovider-endquery
    HRESULT EndQuery();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-ifunctiondiscoveryprovider-instancepropertystorevalidateaccess
    HRESULT InstancePropertyStoreValidateAccess(IFunctionInstance pIFunctionInstance, 
                                                ptrdiff_t iProviderInstanceContext, const(uint) dwStgAccess);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-ifunctiondiscoveryprovider-instancepropertystoreopen
    HRESULT InstancePropertyStoreOpen(IFunctionInstance pIFunctionInstance, ptrdiff_t iProviderInstanceContext, 
                                      const(uint) dwStgAccess, IPropertyStore* ppIPropertyStore);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-ifunctiondiscoveryprovider-instancepropertystoreflush
    HRESULT InstancePropertyStoreFlush(IFunctionInstance pIFunctionInstance, ptrdiff_t iProviderInstanceContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-ifunctiondiscoveryprovider-instancequeryservice
    HRESULT InstanceQueryService(IFunctionInstance pIFunctionInstance, ptrdiff_t iProviderInstanceContext, 
                                 const(GUID)* guidService, const(GUID)* riid, IUnknown* ppIUnknown);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-ifunctiondiscoveryprovider-instancereleased
    HRESULT InstanceReleased(IFunctionInstance pIFunctionInstance, ptrdiff_t iProviderInstanceContext);
}

@GUID("cf986ea6-3b5f-4c5f-b88a-2f8b20ceef17")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nn-functiondiscoveryprovider-iproviderproperties
interface IProviderProperties : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-iproviderproperties-getcount
    HRESULT GetCount(IFunctionInstance pIFunctionInstance, ptrdiff_t iProviderInstanceContext, uint* pdwCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-iproviderproperties-getat
    HRESULT GetAt(IFunctionInstance pIFunctionInstance, ptrdiff_t iProviderInstanceContext, uint dwIndex, 
                  PROPERTYKEY* pKey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-iproviderproperties-getvalue
    HRESULT GetValue(IFunctionInstance pIFunctionInstance, ptrdiff_t iProviderInstanceContext, 
                     const(PROPERTYKEY)* Key, PROPVARIANT* ppropVar);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-iproviderproperties-setvalue
    HRESULT SetValue(IFunctionInstance pIFunctionInstance, ptrdiff_t iProviderInstanceContext, 
                     const(PROPERTYKEY)* Key, const(PROPVARIANT)* ppropVar);
}

@GUID("cd1b9a04-206c-4a05-a0c8-1635a21a2b7c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nn-functiondiscoveryprovider-iproviderpublishing
interface IProviderPublishing : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-iproviderpublishing-createinstance
    HRESULT CreateInstance(SystemVisibilityFlags enumVisibilityFlags, const(PWSTR) pszSubCategory, 
                           const(PWSTR) pszProviderInstanceIdentity, IFunctionInstance* ppIFunctionInstance);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-iproviderpublishing-removeinstance
    HRESULT RemoveInstance(SystemVisibilityFlags enumVisibilityFlags, const(PWSTR) pszSubCategory, 
                           const(PWSTR) pszProviderInstanceIdentity);
}

@GUID("86443ff0-1ad5-4e68-a45a-40c2c329de3b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nn-functiondiscoveryprovider-ifunctiondiscoveryproviderfactory
interface IFunctionDiscoveryProviderFactory : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-ifunctiondiscoveryproviderfactory-createpropertystore
    HRESULT CreatePropertyStore(IPropertyStore* ppIPropertyStore);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-ifunctiondiscoveryproviderfactory-createinstance
    HRESULT CreateInstance(const(PWSTR) pszSubCategory, const(PWSTR) pszProviderInstanceIdentity, 
                           ptrdiff_t iProviderInstanceContext, IPropertyStore pIPropertyStore, 
                           IFunctionDiscoveryProvider pIFunctionDiscoveryProvider, 
                           IFunctionInstance* ppIFunctionInstance);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-ifunctiondiscoveryproviderfactory-createfunctioninstancecollection
    HRESULT CreateFunctionInstanceCollection(IFunctionInstanceCollection* ppIFunctionInstanceCollection);
}

@GUID("6876ea98-baec-46db-bc20-75a76e267a3a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nn-functiondiscoveryprovider-ifunctiondiscoveryproviderquery
interface IFunctionDiscoveryProviderQuery : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-ifunctiondiscoveryproviderquery-isinstancequery
    HRESULT IsInstanceQuery(BOOL* pisInstanceQuery, ushort** ppszConstraintValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-ifunctiondiscoveryproviderquery-issubcategoryquery
    HRESULT IsSubcategoryQuery(BOOL* pisSubcategoryQuery, ushort** ppszConstraintValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-ifunctiondiscoveryproviderquery-getqueryconstraints
    HRESULT GetQueryConstraints(IProviderQueryConstraintCollection* ppIProviderQueryConstraints);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-ifunctiondiscoveryproviderquery-getpropertyconstraints
    HRESULT GetPropertyConstraints(IProviderPropertyConstraintCollection* ppIProviderPropertyConstraints);
}

@GUID("9c243e11-3261-4bcd-b922-84a873d460ae")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nn-functiondiscoveryprovider-iproviderqueryconstraintcollection
interface IProviderQueryConstraintCollection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-iproviderqueryconstraintcollection-getcount
    HRESULT GetCount(uint* pdwCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-iproviderqueryconstraintcollection-get
    HRESULT Get(const(PWSTR) pszConstraintName, ushort** ppszConstraintValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-iproviderqueryconstraintcollection-item
    HRESULT Item(uint dwIndex, ushort** ppszConstraintName, ushort** ppszConstraintValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-iproviderqueryconstraintcollection-next
    HRESULT Next(ushort** ppszConstraintName, ushort** ppszConstraintValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-iproviderqueryconstraintcollection-skip
    HRESULT Skip();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-iproviderqueryconstraintcollection-reset
    HRESULT Reset();
}

@GUID("f4fae42f-5778-4a13-8540-b5fd8c1398dd")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nn-functiondiscoveryprovider-iproviderpropertyconstraintcollection
interface IProviderPropertyConstraintCollection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-iproviderpropertyconstraintcollection-getcount
    HRESULT GetCount(uint* pdwCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-iproviderpropertyconstraintcollection-get
    HRESULT Get(const(PROPERTYKEY)* Key, PROPVARIANT* pPropVar, uint* pdwPropertyConstraint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-iproviderpropertyconstraintcollection-item
    HRESULT Item(uint dwIndex, PROPERTYKEY* pKey, PROPVARIANT* pPropVar, uint* pdwPropertyConstraint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-iproviderpropertyconstraintcollection-next
    HRESULT Next(PROPERTYKEY* pKey, PROPVARIANT* pPropVar, uint* pdwPropertyConstraint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-iproviderpropertyconstraintcollection-skip
    HRESULT Skip();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-iproviderpropertyconstraintcollection-reset
    HRESULT Reset();
}

@GUID("4c81ed02-1b04-43f2-a451-69966cbcd1c2")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nn-functiondiscoveryprovider-ifunctiondiscoveryserviceprovider
interface IFunctionDiscoveryServiceProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/functiondiscoveryprovider/nf-functiondiscoveryprovider-ifunctiondiscoveryserviceprovider-initialize
    HRESULT Initialize(IFunctionInstance pIFunctionInstance, const(GUID)* riid, void** ppv);
}

@GUID("0bd7e521-4da6-42d5-81ba-1981b6b94075")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pnpxassoc/nn-pnpxassoc-ipnpxassociation
interface IPNPXAssociation : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pnpxassoc/nf-pnpxassoc-ipnpxassociation-associate
    HRESULT Associate(const(PWSTR) pszSubcategory);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pnpxassoc/nf-pnpxassoc-ipnpxassociation-unassociate
    HRESULT Unassociate(const(PWSTR) pszSubcategory);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pnpxassoc/nf-pnpxassoc-ipnpxassociation-delete
    HRESULT Delete(const(PWSTR) pszSubcategory);
}

@GUID("eed366d0-35b8-4fc5-8d20-7e5bd31f6ded")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pnpxassoc/nn-pnpxassoc-ipnpxdeviceassociation
interface IPNPXDeviceAssociation : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pnpxassoc/nf-pnpxassoc-ipnpxdeviceassociation-associate
    HRESULT Associate(const(PWSTR) pszSubCategory, IFunctionDiscoveryNotification pIFunctionDiscoveryNotification);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pnpxassoc/nf-pnpxassoc-ipnpxdeviceassociation-unassociate
    HRESULT Unassociate(const(PWSTR) pszSubCategory, 
                        IFunctionDiscoveryNotification pIFunctionDiscoveryNotification);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pnpxassoc/nf-pnpxassoc-ipnpxdeviceassociation-delete
    HRESULT Delete(const(PWSTR) pszSubcategory, IFunctionDiscoveryNotification pIFunctionDiscoveryNotification);
}


// GUIDs

const GUID CLSID_FunctionDiscovery          = GUIDOF!FunctionDiscovery;
const GUID CLSID_FunctionInstanceCollection = GUIDOF!FunctionInstanceCollection;
const GUID CLSID_PNPXAssociation            = GUIDOF!PNPXAssociation;
const GUID CLSID_PNPXPairingHandler         = GUIDOF!PNPXPairingHandler;
const GUID CLSID_PropertyStore              = GUIDOF!PropertyStore;
const GUID CLSID_PropertyStoreCollection    = GUIDOF!PropertyStoreCollection;

const GUID IID_IFunctionDiscovery                    = GUIDOF!IFunctionDiscovery;
const GUID IID_IFunctionDiscoveryNotification        = GUIDOF!IFunctionDiscoveryNotification;
const GUID IID_IFunctionDiscoveryProvider            = GUIDOF!IFunctionDiscoveryProvider;
const GUID IID_IFunctionDiscoveryProviderFactory     = GUIDOF!IFunctionDiscoveryProviderFactory;
const GUID IID_IFunctionDiscoveryProviderQuery       = GUIDOF!IFunctionDiscoveryProviderQuery;
const GUID IID_IFunctionDiscoveryServiceProvider     = GUIDOF!IFunctionDiscoveryServiceProvider;
const GUID IID_IFunctionInstance                     = GUIDOF!IFunctionInstance;
const GUID IID_IFunctionInstanceCollection           = GUIDOF!IFunctionInstanceCollection;
const GUID IID_IFunctionInstanceCollectionQuery      = GUIDOF!IFunctionInstanceCollectionQuery;
const GUID IID_IFunctionInstanceQuery                = GUIDOF!IFunctionInstanceQuery;
const GUID IID_IPNPXAssociation                      = GUIDOF!IPNPXAssociation;
const GUID IID_IPNPXDeviceAssociation                = GUIDOF!IPNPXDeviceAssociation;
const GUID IID_IPropertyStoreCollection              = GUIDOF!IPropertyStoreCollection;
const GUID IID_IProviderProperties                   = GUIDOF!IProviderProperties;
const GUID IID_IProviderPropertyConstraintCollection = GUIDOF!IProviderPropertyConstraintCollection;
const GUID IID_IProviderPublishing                   = GUIDOF!IProviderPublishing;
const GUID IID_IProviderQueryConstraintCollection    = GUIDOF!IProviderQueryConstraintCollection;
