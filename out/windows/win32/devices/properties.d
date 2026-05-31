// Written in the D programming language.

module windows.win32.devices.properties;

public import windows.core;
public import windows.win32.foundation.foundation : DEVPROPKEY, PWSTR;

extern(Windows) @nogc nothrow:


// Enums


alias DEVPROPTYPE = uint;
enum : uint
{
    DEVPROP_TYPEMOD_ARRAY                   = 0x00001000U,
    DEVPROP_TYPEMOD_LIST                    = 0x00002000U,
    DEVPROP_TYPE_EMPTY                      = 0x00000000U,
    DEVPROP_TYPE_NULL                       = 0x00000001U,
    DEVPROP_TYPE_SBYTE                      = 0x00000002U,
    DEVPROP_TYPE_BYTE                       = 0x00000003U,
    DEVPROP_TYPE_INT16                      = 0x00000004U,
    DEVPROP_TYPE_UINT16                     = 0x00000005U,
    DEVPROP_TYPE_INT32                      = 0x00000006U,
    DEVPROP_TYPE_UINT32                     = 0x00000007U,
    DEVPROP_TYPE_INT64                      = 0x00000008U,
    DEVPROP_TYPE_UINT64                     = 0x00000009U,
    DEVPROP_TYPE_FLOAT                      = 0x0000000aU,
    DEVPROP_TYPE_DOUBLE                     = 0x0000000bU,
    DEVPROP_TYPE_DECIMAL                    = 0x0000000cU,
    DEVPROP_TYPE_GUID                       = 0x0000000dU,
    DEVPROP_TYPE_CURRENCY                   = 0x0000000eU,
    DEVPROP_TYPE_DATE                       = 0x0000000fU,
    DEVPROP_TYPE_FILETIME                   = 0x00000010U,
    DEVPROP_TYPE_BOOLEAN                    = 0x00000011U,
    DEVPROP_TYPE_STRING                     = 0x00000012U,
    DEVPROP_TYPE_STRING_LIST                = 0x00002012U,
    DEVPROP_TYPE_SECURITY_DESCRIPTOR        = 0x00000013U,
    DEVPROP_TYPE_SECURITY_DESCRIPTOR_STRING = 0x00000014U,
    DEVPROP_TYPE_DEVPROPKEY                 = 0x00000015U,
    DEVPROP_TYPE_DEVPROPTYPE                = 0x00000016U,
    DEVPROP_TYPE_BINARY                     = 0x00001003U,
    DEVPROP_TYPE_ERROR                      = 0x00000017U,
    DEVPROP_TYPE_NTSTATUS                   = 0x00000018U,
    DEVPROP_TYPE_STRING_INDIRECT            = 0x00000019U,
}

alias DEVPROPSTORE = int;
enum : int
{
    DEVPROP_STORE_SYSTEM = 0x00000000,
    DEVPROP_STORE_USER   = 0x00000001,
}

// Constants


enum : DEVPROP_BOOLEAN
{
    DEVPROP_TRUE  = DEVPROP_BOOLEAN(0xff),
    DEVPROP_FALSE = DEVPROP_BOOLEAN(0x00),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1129173647, 40565, 17674, 154, 185, 255, 97, 230, 24, 186, 208}, 2))], [])*/DEVPROPKEY DEVPKEY_DeviceInterface_Autoplay_Silent = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1129173647, 40565, 17674, 154, 185, 255, 97, 230, 24, 186, 208}, 2))], [])*/DEVPROPKEY(GUID("434DD28F-9E75-450A-9AB9-FF61E618BAD0"), 2);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY
{
    DEVPKEY_NAME                           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("B725F130-47EF-101A-A5F1-02608C9EEBAC"), 10),
    DEVPKEY_Device_DeviceDesc              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 2),
    DEVPKEY_Device_HardwareIds             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 3),
    DEVPKEY_Device_CompatibleIds           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 4),
    DEVPKEY_Device_Service                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 6),
    DEVPKEY_Device_Class                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 9),
    DEVPKEY_Device_ClassGuid               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 10),
    DEVPKEY_Device_Driver                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 11),
    DEVPKEY_Device_ConfigFlags             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 12),
    DEVPKEY_Device_Manufacturer            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 13),
    DEVPKEY_Device_FriendlyName            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 14),
    DEVPKEY_Device_LocationInfo            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 15),
    DEVPKEY_Device_PDOName                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 16),
    DEVPKEY_Device_Capabilities            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 17),
    DEVPKEY_Device_UINumber                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 18),
    DEVPKEY_Device_UpperFilters            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 19),
    DEVPKEY_Device_LowerFilters            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 20),
    DEVPKEY_Device_BusTypeGuid             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 21),
    DEVPKEY_Device_LegacyBusType           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 22),
    DEVPKEY_Device_BusNumber               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 23),
    DEVPKEY_Device_EnumeratorName          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 24),
    DEVPKEY_Device_Security                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 25),
    DEVPKEY_Device_SecuritySDS             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 26),
    DEVPKEY_Device_DevType                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 27),
    DEVPKEY_Device_Exclusive               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 28),
    DEVPKEY_Device_Characteristics         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 29),
    DEVPKEY_Device_Address                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 30),
    DEVPKEY_Device_UINumberDescFormat      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 31),
    DEVPKEY_Device_PowerData               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 32),
    DEVPKEY_Device_RemovalPolicy           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 33),
    DEVPKEY_Device_RemovalPolicyDefault    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 34),
    DEVPKEY_Device_RemovalPolicyOverride   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 35),
    DEVPKEY_Device_InstallState            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 36),
    DEVPKEY_Device_LocationPaths           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 37),
    DEVPKEY_Device_BaseContainerId         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 38),
    DEVPKEY_Device_InstanceId              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 256),
    DEVPKEY_Device_DevNodeStatus           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("4340A6C5-93FA-4706-972C-7B648008A5A7"), 2),
    DEVPKEY_Device_ProblemCode             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("4340A6C5-93FA-4706-972C-7B648008A5A7"), 3),
    DEVPKEY_Device_EjectionRelations       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("4340A6C5-93FA-4706-972C-7B648008A5A7"), 4),
    DEVPKEY_Device_RemovalRelations        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("4340A6C5-93FA-4706-972C-7B648008A5A7"), 5),
    DEVPKEY_Device_PowerRelations          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("4340A6C5-93FA-4706-972C-7B648008A5A7"), 6),
    DEVPKEY_Device_BusRelations            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("4340A6C5-93FA-4706-972C-7B648008A5A7"), 7),
    DEVPKEY_Device_Parent                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("4340A6C5-93FA-4706-972C-7B648008A5A7"), 8),
    DEVPKEY_Device_Children                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("4340A6C5-93FA-4706-972C-7B648008A5A7"), 9),
    DEVPKEY_Device_Siblings                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("4340A6C5-93FA-4706-972C-7B648008A5A7"), 10),
    DEVPKEY_Device_TransportRelations      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("4340A6C5-93FA-4706-972C-7B648008A5A7"), 11),
    DEVPKEY_Device_ProblemStatus           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("4340A6C5-93FA-4706-972C-7B648008A5A7"), 12),
    DEVPKEY_Device_Reported                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("80497100-8C73-48B9-AAD9-CE387E19C56E"), 2),
    DEVPKEY_Device_Legacy                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("80497100-8C73-48B9-AAD9-CE387E19C56E"), 3),
    DEVPKEY_Device_ContainerId             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("8C7ED206-3F8A-4827-B3AB-AE9E1FAEFC6C"), 2),
    DEVPKEY_Device_InLocalMachineContainer = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 10))], [])*/DEVPROPKEY(GUID("8C7ED206-3F8A-4827-B3AB-AE9E1FAEFC6C"), 4),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2097348836, 20407, 18749, 138, 149, 101, 111, 0, 230, 162, 113}, 2))], [])*/DEVPROPKEY
{
    DEVPKEY_Device_ContainerModelName          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2097348836, 20407, 18749, 138, 149, 101, 111, 0, 230, 162, 113}, 2))], [])*/DEVPROPKEY(GUID("7D0300E4-4FB7-493D-8A95-656F00E6A271"), 2),
    DEVPKEY_Device_ContainerManufacturer       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2097348836, 20407, 18749, 138, 149, 101, 111, 0, 230, 162, 113}, 2))], [])*/DEVPROPKEY(GUID("7D0300E4-4FB7-493D-8A95-656F00E6A271"), 3),
    DEVPKEY_Device_ContainerCategories         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2097348836, 20407, 18749, 138, 149, 101, 111, 0, 230, 162, 113}, 2))], [])*/DEVPROPKEY(GUID("7D0300E4-4FB7-493D-8A95-656F00E6A271"), 4),
    DEVPKEY_Device_ContainerIcon               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2097348836, 20407, 18749, 138, 149, 101, 111, 0, 230, 162, 113}, 2))], [])*/DEVPROPKEY(GUID("7D0300E4-4FB7-493D-8A95-656F00E6A271"), 5),
    DEVPKEY_Device_Model                       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2097348836, 20407, 18749, 138, 149, 101, 111, 0, 230, 162, 113}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 39),
    DEVPKEY_Device_ModelId                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2097348836, 20407, 18749, 138, 149, 101, 111, 0, 230, 162, 113}, 2))], [])*/DEVPROPKEY(GUID("80D81EA6-7473-4B0C-8216-EFC11A2C4C8B"), 2),
    DEVPKEY_Device_FriendlyNameAttributes      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2097348836, 20407, 18749, 138, 149, 101, 111, 0, 230, 162, 113}, 2))], [])*/DEVPROPKEY(GUID("80D81EA6-7473-4B0C-8216-EFC11A2C4C8B"), 3),
    DEVPKEY_Device_ManufacturerAttributes      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2097348836, 20407, 18749, 138, 149, 101, 111, 0, 230, 162, 113}, 2))], [])*/DEVPROPKEY(GUID("80D81EA6-7473-4B0C-8216-EFC11A2C4C8B"), 4),
    DEVPKEY_Device_PresenceNotForDevice        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2097348836, 20407, 18749, 138, 149, 101, 111, 0, 230, 162, 113}, 2))], [])*/DEVPROPKEY(GUID("80D81EA6-7473-4B0C-8216-EFC11A2C4C8B"), 5),
    DEVPKEY_Device_SignalStrength              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2097348836, 20407, 18749, 138, 149, 101, 111, 0, 230, 162, 113}, 2))], [])*/DEVPROPKEY(GUID("80D81EA6-7473-4B0C-8216-EFC11A2C4C8B"), 6),
    DEVPKEY_Device_IsAssociateableByUserAction = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2097348836, 20407, 18749, 138, 149, 101, 111, 0, 230, 162, 113}, 2))], [])*/DEVPROPKEY(GUID("80D81EA6-7473-4B0C-8216-EFC11A2C4C8B"), 7),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2161647270, 29811, 19212, 130, 22, 239, 193, 26, 44, 76, 139}, 8))], [])*/DEVPROPKEY
{
    DEVPKEY_Device_ShowInUninstallUI        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2161647270, 29811, 19212, 130, 22, 239, 193, 26, 44, 76, 139}, 8))], [])*/DEVPROPKEY(GUID("80D81EA6-7473-4B0C-8216-EFC11A2C4C8B"), 8),
    DEVPKEY_Device_CompanionApps            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2161647270, 29811, 19212, 130, 22, 239, 193, 26, 44, 76, 139}, 8))], [])*/DEVPROPKEY(GUID("6A742654-D0B2-4420-A523-E068352AC1DF"), 2),
    DEVPKEY_Device_PrimaryCompanionApp      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2161647270, 29811, 19212, 130, 22, 239, 193, 26, 44, 76, 139}, 8))], [])*/DEVPROPKEY(GUID("6A742654-D0B2-4420-A523-E068352AC1DF"), 3),
    DEVPKEY_Device_Numa_Proximity_Domain    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2161647270, 29811, 19212, 130, 22, 239, 193, 26, 44, 76, 139}, 8))], [])*/DEVPROPKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 1),
    DEVPKEY_Device_DHP_Rebalance_Policy     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2161647270, 29811, 19212, 130, 22, 239, 193, 26, 44, 76, 139}, 8))], [])*/DEVPROPKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 2),
    DEVPKEY_Device_Numa_Node                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2161647270, 29811, 19212, 130, 22, 239, 193, 26, 44, 76, 139}, 8))], [])*/DEVPROPKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 3),
    DEVPKEY_Device_BusReportedDeviceDesc    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2161647270, 29811, 19212, 130, 22, 239, 193, 26, 44, 76, 139}, 8))], [])*/DEVPROPKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 4),
    DEVPKEY_Device_IsPresent                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2161647270, 29811, 19212, 130, 22, 239, 193, 26, 44, 76, 139}, 8))], [])*/DEVPROPKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 5),
    DEVPKEY_Device_HasProblem               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2161647270, 29811, 19212, 130, 22, 239, 193, 26, 44, 76, 139}, 8))], [])*/DEVPROPKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 6),
    DEVPKEY_Device_ConfigurationId          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2161647270, 29811, 19212, 130, 22, 239, 193, 26, 44, 76, 139}, 8))], [])*/DEVPROPKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 7),
    DEVPKEY_Device_ReportedDeviceIdsHash    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2161647270, 29811, 19212, 130, 22, 239, 193, 26, 44, 76, 139}, 8))], [])*/DEVPROPKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 8),
    DEVPKEY_Device_PhysicalDeviceLocation   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2161647270, 29811, 19212, 130, 22, 239, 193, 26, 44, 76, 139}, 8))], [])*/DEVPROPKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 9),
    DEVPKEY_Device_BiosDeviceName           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2161647270, 29811, 19212, 130, 22, 239, 193, 26, 44, 76, 139}, 8))], [])*/DEVPROPKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 10),
    DEVPKEY_Device_DriverProblemDesc        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2161647270, 29811, 19212, 130, 22, 239, 193, 26, 44, 76, 139}, 8))], [])*/DEVPROPKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 11),
    DEVPKEY_Device_DebuggerSafe             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2161647270, 29811, 19212, 130, 22, 239, 193, 26, 44, 76, 139}, 8))], [])*/DEVPROPKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 12),
    DEVPKEY_Device_PostInstallInProgress    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2161647270, 29811, 19212, 130, 22, 239, 193, 26, 44, 76, 139}, 8))], [])*/DEVPROPKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 13),
    DEVPKEY_Device_Stack                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2161647270, 29811, 19212, 130, 22, 239, 193, 26, 44, 76, 139}, 8))], [])*/DEVPROPKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 14),
    DEVPKEY_Device_ExtendedConfigurationIds = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2161647270, 29811, 19212, 130, 22, 239, 193, 26, 44, 76, 139}, 8))], [])*/DEVPROPKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 15),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY
{
    DEVPKEY_Device_IsRebootRequired         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 16),
    DEVPKEY_Device_FirmwareDate             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 17),
    DEVPKEY_Device_FirmwareVersion          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 18),
    DEVPKEY_Device_FirmwareRevision         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 19),
    DEVPKEY_Device_DependencyProviders      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 20),
    DEVPKEY_Device_DependencyDependents     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 21),
    DEVPKEY_Device_SoftRestartSupported     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 22),
    DEVPKEY_Device_ExtendedAddress          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 23),
    DEVPKEY_Device_AssignedToGuest          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 24),
    DEVPKEY_Device_CreatorProcessId         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 25),
    DEVPKEY_Device_FirmwareVendor           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 26),
    DEVPKEY_Device_SessionId                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY(GUID("83DA6326-97A6-4088-9453-A1923F573B29"), 6),
    DEVPKEY_Device_InstallDate              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY(GUID("83DA6326-97A6-4088-9453-A1923F573B29"), 100),
    DEVPKEY_Device_FirstInstallDate         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY(GUID("83DA6326-97A6-4088-9453-A1923F573B29"), 101),
    DEVPKEY_Device_LastArrivalDate          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY(GUID("83DA6326-97A6-4088-9453-A1923F573B29"), 102),
    DEVPKEY_Device_LastRemovalDate          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY(GUID("83DA6326-97A6-4088-9453-A1923F573B29"), 103),
    DEVPKEY_Device_DriverDate               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 2),
    DEVPKEY_Device_DriverVersion            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 3),
    DEVPKEY_Device_DriverDesc               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 4),
    DEVPKEY_Device_DriverInfPath            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 5),
    DEVPKEY_Device_DriverInfSection         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 6),
    DEVPKEY_Device_DriverInfSectionExt      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 7),
    DEVPKEY_Device_MatchingDeviceId         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 8),
    DEVPKEY_Device_DriverProvider           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 9),
    DEVPKEY_Device_DriverPropPageProvider   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 10),
    DEVPKEY_Device_DriverCoInstallers       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 11),
    DEVPKEY_Device_ResourcePickerTags       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 12),
    DEVPKEY_Device_ResourcePickerExceptions = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 16))], [])*/DEVPROPKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 13),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2830656989, 11837, 16532, 173, 151, 229, 147, 167, 12, 117, 214}, 14))], [])*/DEVPROPKEY
{
    DEVPKEY_Device_DriverRank                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2830656989, 11837, 16532, 173, 151, 229, 147, 167, 12, 117, 214}, 14))], [])*/DEVPROPKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 14),
    DEVPKEY_Device_DriverLogoLevel             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2830656989, 11837, 16532, 173, 151, 229, 147, 167, 12, 117, 214}, 14))], [])*/DEVPROPKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 15),
    DEVPKEY_Device_NoConnectSound              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2830656989, 11837, 16532, 173, 151, 229, 147, 167, 12, 117, 214}, 14))], [])*/DEVPROPKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 17),
    DEVPKEY_Device_GenericDriverInstalled      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2830656989, 11837, 16532, 173, 151, 229, 147, 167, 12, 117, 214}, 14))], [])*/DEVPROPKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 18),
    DEVPKEY_Device_AdditionalSoftwareRequested = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2830656989, 11837, 16532, 173, 151, 229, 147, 167, 12, 117, 214}, 14))], [])*/DEVPROPKEY(GUID("A8B865DD-2E3D-4094-AD97-E593A70C75D6"), 19),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2950264384, 34467, 16912, 182, 124, 40, 156, 65, 170, 190, 85}, 2))], [])*/DEVPROPKEY
{
    DEVPKEY_Device_SafeRemovalRequired         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2950264384, 34467, 16912, 182, 124, 40, 156, 65, 170, 190, 85}, 2))], [])*/DEVPROPKEY(GUID("AFD97640-86A3-4210-B67C-289C41AABE55"), 2),
    DEVPKEY_Device_SafeRemovalRequiredOverride = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2950264384, 34467, 16912, 182, 124, 40, 156, 65, 170, 190, 85}, 2))], [])*/DEVPROPKEY(GUID("AFD97640-86A3-4210-B67C-289C41AABE55"), 3),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3480468305, 15039, 17570, 133, 224, 154, 61, 199, 161, 33, 50}, 2))], [])*/DEVPROPKEY
{
    DEVPKEY_DrvPkg_Model               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3480468305, 15039, 17570, 133, 224, 154, 61, 199, 161, 33, 50}, 2))], [])*/DEVPROPKEY(GUID("CF73BB51-3ABF-44A2-85E0-9A3DC7A12132"), 2),
    DEVPKEY_DrvPkg_VendorWebSite       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3480468305, 15039, 17570, 133, 224, 154, 61, 199, 161, 33, 50}, 2))], [])*/DEVPROPKEY(GUID("CF73BB51-3ABF-44A2-85E0-9A3DC7A12132"), 3),
    DEVPKEY_DrvPkg_DetailedDescription = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3480468305, 15039, 17570, 133, 224, 154, 61, 199, 161, 33, 50}, 2))], [])*/DEVPROPKEY(GUID("CF73BB51-3ABF-44A2-85E0-9A3DC7A12132"), 4),
    DEVPKEY_DrvPkg_DocumentationLink   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3480468305, 15039, 17570, 133, 224, 154, 61, 199, 161, 33, 50}, 2))], [])*/DEVPROPKEY(GUID("CF73BB51-3ABF-44A2-85E0-9A3DC7A12132"), 5),
    DEVPKEY_DrvPkg_Icon                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3480468305, 15039, 17570, 133, 224, 154, 61, 199, 161, 33, 50}, 2))], [])*/DEVPROPKEY(GUID("CF73BB51-3ABF-44A2-85E0-9A3DC7A12132"), 6),
    DEVPKEY_DrvPkg_BrandingIcon        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3480468305, 15039, 17570, 133, 224, 154, 61, 199, 161, 33, 50}, 2))], [])*/DEVPROPKEY(GUID("CF73BB51-3ABF-44A2-85E0-9A3DC7A12132"), 7),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/DEVPROPKEY
{
    DEVPKEY_DeviceClass_UpperFilters       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/DEVPROPKEY(GUID("4321918B-F69E-470D-A5DE-4D88C75AD24B"), 19),
    DEVPKEY_DeviceClass_LowerFilters       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/DEVPROPKEY(GUID("4321918B-F69E-470D-A5DE-4D88C75AD24B"), 20),
    DEVPKEY_DeviceClass_Security           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/DEVPROPKEY(GUID("4321918B-F69E-470D-A5DE-4D88C75AD24B"), 25),
    DEVPKEY_DeviceClass_SecuritySDS        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/DEVPROPKEY(GUID("4321918B-F69E-470D-A5DE-4D88C75AD24B"), 26),
    DEVPKEY_DeviceClass_DevType            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/DEVPROPKEY(GUID("4321918B-F69E-470D-A5DE-4D88C75AD24B"), 27),
    DEVPKEY_DeviceClass_Exclusive          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/DEVPROPKEY(GUID("4321918B-F69E-470D-A5DE-4D88C75AD24B"), 28),
    DEVPKEY_DeviceClass_Characteristics    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/DEVPROPKEY(GUID("4321918B-F69E-470D-A5DE-4D88C75AD24B"), 29),
    DEVPKEY_DeviceClass_Name               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/DEVPROPKEY(GUID("259ABFFC-50A7-47CE-AF08-68C9A7D73366"), 2),
    DEVPKEY_DeviceClass_ClassName          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/DEVPROPKEY(GUID("259ABFFC-50A7-47CE-AF08-68C9A7D73366"), 3),
    DEVPKEY_DeviceClass_Icon               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/DEVPROPKEY(GUID("259ABFFC-50A7-47CE-AF08-68C9A7D73366"), 4),
    DEVPKEY_DeviceClass_ClassInstaller     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/DEVPROPKEY(GUID("259ABFFC-50A7-47CE-AF08-68C9A7D73366"), 5),
    DEVPKEY_DeviceClass_PropPageProvider   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/DEVPROPKEY(GUID("259ABFFC-50A7-47CE-AF08-68C9A7D73366"), 6),
    DEVPKEY_DeviceClass_NoInstallClass     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/DEVPROPKEY(GUID("259ABFFC-50A7-47CE-AF08-68C9A7D73366"), 7),
    DEVPKEY_DeviceClass_NoDisplayClass     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/DEVPROPKEY(GUID("259ABFFC-50A7-47CE-AF08-68C9A7D73366"), 8),
    DEVPKEY_DeviceClass_SilentInstall      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/DEVPROPKEY(GUID("259ABFFC-50A7-47CE-AF08-68C9A7D73366"), 9),
    DEVPKEY_DeviceClass_NoUseClass         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/DEVPROPKEY(GUID("259ABFFC-50A7-47CE-AF08-68C9A7D73366"), 10),
    DEVPKEY_DeviceClass_DefaultService     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/DEVPROPKEY(GUID("259ABFFC-50A7-47CE-AF08-68C9A7D73366"), 11),
    DEVPKEY_DeviceClass_IconPath           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/DEVPROPKEY(GUID("259ABFFC-50A7-47CE-AF08-68C9A7D73366"), 12),
    DEVPKEY_DeviceClass_DHPRebalanceOptOut = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/DEVPROPKEY(GUID("D14D3EF3-66CF-4BA2-9D38-0DDB37AB4701"), 2),
    DEVPKEY_DeviceClass_ClassCoInstallers  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1126273419, 63134, 18189, 165, 222, 77, 136, 199, 90, 210, 75}, 19))], [])*/DEVPROPKEY(GUID("713D1703-A2E2-49F5-9214-56472EF3DA5C"), 2),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY
{
    DEVPKEY_DeviceInterface_FriendlyName                       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("026E516E-B814-414B-83CD-856D6FEF4822"), 2),
    DEVPKEY_DeviceInterface_Enabled                            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("026E516E-B814-414B-83CD-856D6FEF4822"), 3),
    DEVPKEY_DeviceInterface_ClassGuid                          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("026E516E-B814-414B-83CD-856D6FEF4822"), 4),
    DEVPKEY_DeviceInterface_ReferenceString                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("026E516E-B814-414B-83CD-856D6FEF4822"), 5),
    DEVPKEY_DeviceInterface_Restricted                         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("026E516E-B814-414B-83CD-856D6FEF4822"), 6),
    DEVPKEY_DeviceInterface_UnrestrictedAppCapabilities        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("026E516E-B814-414B-83CD-856D6FEF4822"), 8),
    DEVPKEY_DeviceInterface_SchematicName                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("026E516E-B814-414B-83CD-856D6FEF4822"), 9),
    DEVPKEY_DeviceInterfaceClass_DefaultInterface              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("14C83A99-0B3F-44B7-BE4C-A178D3990564"), 2),
    DEVPKEY_DeviceInterfaceClass_Name                          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("14C83A99-0B3F-44B7-BE4C-A178D3990564"), 3),
    DEVPKEY_DeviceContainer_Address                            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 51),
    DEVPKEY_DeviceContainer_DiscoveryMethod                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 52),
    DEVPKEY_DeviceContainer_IsEncrypted                        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 53),
    DEVPKEY_DeviceContainer_IsAuthenticated                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 54),
    DEVPKEY_DeviceContainer_IsConnected                        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 55),
    DEVPKEY_DeviceContainer_IsPaired                           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 56),
    DEVPKEY_DeviceContainer_Icon                               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 57),
    DEVPKEY_DeviceContainer_Version                            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 65),
    DEVPKEY_DeviceContainer_Last_Seen                          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 66),
    DEVPKEY_DeviceContainer_Last_Connected                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 67),
    DEVPKEY_DeviceContainer_IsShowInDisconnectedState          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 68),
    DEVPKEY_DeviceContainer_IsLocalMachine                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 70),
    DEVPKEY_DeviceContainer_MetadataPath                       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 71),
    DEVPKEY_DeviceContainer_IsMetadataSearchInProgress         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 72),
    DEVPKEY_DeviceContainer_MetadataChecksum                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 73),
    DEVPKEY_DeviceContainer_IsNotInterestingForDisplay         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 74),
    DEVPKEY_DeviceContainer_LaunchDeviceStageOnDeviceConnect   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 76),
    DEVPKEY_DeviceContainer_LaunchDeviceStageFromExplorer      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 77),
    DEVPKEY_DeviceContainer_BaselineExperienceId               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 78),
    DEVPKEY_DeviceContainer_IsDeviceUniquelyIdentifiable       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 79),
    DEVPKEY_DeviceContainer_AssociationArray                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 80),
    DEVPKEY_DeviceContainer_DeviceDescription1                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 81),
    DEVPKEY_DeviceContainer_DeviceDescription2                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 82),
    DEVPKEY_DeviceContainer_HasProblem                         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 83),
    DEVPKEY_DeviceContainer_IsSharedDevice                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 84),
    DEVPKEY_DeviceContainer_IsNetworkDevice                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 85),
    DEVPKEY_DeviceContainer_IsDefaultDevice                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 86),
    DEVPKEY_DeviceContainer_MetadataCabinet                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 87),
    DEVPKEY_DeviceContainer_RequiresPairingElevation           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 88),
    DEVPKEY_DeviceContainer_ExperienceId                       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 89),
    DEVPKEY_DeviceContainer_Category                           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 90),
    DEVPKEY_DeviceContainer_Category_Desc_Singular             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 91),
    DEVPKEY_DeviceContainer_Category_Desc_Plural               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 92),
    DEVPKEY_DeviceContainer_Category_Icon                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 93),
    DEVPKEY_DeviceContainer_CategoryGroup_Desc                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 94),
    DEVPKEY_DeviceContainer_CategoryGroup_Icon                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 95),
    DEVPKEY_DeviceContainer_PrimaryCategory                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 97),
    DEVPKEY_DeviceContainer_UnpairUninstall                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 98),
    DEVPKEY_DeviceContainer_RequiresUninstallElevation         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 99),
    DEVPKEY_DeviceContainer_DeviceFunctionSubRank              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 100),
    DEVPKEY_DeviceContainer_AlwaysShowDeviceAsConnected        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 101),
    DEVPKEY_DeviceContainer_ConfigFlags                        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 105),
    DEVPKEY_DeviceContainer_PrivilegedPackageFamilyNames       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 106),
    DEVPKEY_DeviceContainer_CustomPrivilegedPackageFamilyNames = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 107),
    DEVPKEY_DeviceContainer_IsRebootRequired                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 108),
    DEVPKEY_DeviceContainer_FriendlyName                       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 12288),
    DEVPKEY_DeviceContainer_Manufacturer                       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 8192),
    DEVPKEY_DeviceContainer_ModelName                          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 8194),
    DEVPKEY_DeviceContainer_ModelNumber                        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 8195),
    DEVPKEY_DeviceContainer_InstallInProgress                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({40784238, 47124, 16715, 131, 205, 133, 109, 111, 239, 72, 34}, 2))], [])*/DEVPROPKEY(GUID("83DA6326-97A6-4088-9453-A1923F573B29"), 9),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({325533506, 41942, 18934, 180, 218, 174, 70, 224, 197, 35, 124}, 2))], [])*/DEVPROPKEY DEVPKEY_DevQuery_ObjectType = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({325533506, 41942, 18934, 180, 218, 174, 70, 224, 197, 35, 124}, 2))], [])*/DEVPROPKEY(GUID("13673F42-A3D6-49F6-B4DA-AE46E0C5237C"), 2);

enum : uint
{
    MAX_DEVPROP_TYPE    = 0x00000019U,
    MAX_DEVPROP_TYPEMOD = 0x00002000U,
}

enum : uint
{
    DEVPROP_MASK_TYPE    = 0x00000fffU,
    DEVPROP_MASK_TYPEMOD = 0x0000f000U,
}

enum uint DEVPROPID_FIRST_USABLE = 0x00000002U;

// Structs


struct DEVPROP_BOOLEAN
{
    ubyte Value;
}

struct DEVPROPCOMPKEY
{
    DEVPROPKEY   Key;
    DEVPROPSTORE Store;
    const(PWSTR) LocaleName;
}

struct DEVPROPERTY
{
    DEVPROPCOMPKEY CompKey;
    DEVPROPTYPE    Type;
    uint           BufferSize;
    void*          Buffer;
}

