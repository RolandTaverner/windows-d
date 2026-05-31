// Written in the D programming language.

module windows.win32.system.winrt.metadata;

public import windows.core;
public import system : Guid;
public import windows.foundation.collections : IPropertySet;
public import windows.storage.streams : IPropertySetSerializer;
public import windows.win32.foundation : BOOL, HRESULT, PSTR, PWSTR;
public import windows.win32.system.com : IStream, ITypeInfo, IUnknown;
public import windows.win32.system.variant : VARIANT;
public import windows.win32.system.winrt : HSTRING;

extern(Windows) @nogc nothrow:


// Enums

alias COINITICOR = int;
enum : int
{
    COINITCOR_DEFAULT = 0x00000000,
}
alias COINITIEE = int;
enum : int
{
    COINITEE_DEFAULT = 0x00000000,
    COINITEE_DLL     = 0x00000001,
    COINITEE_MAIN    = 0x00000002,
}
alias COUNINITIEE = int;
enum : int
{
    COUNINITEE_DEFAULT = 0x00000000,
    COUNINITEE_DLL     = 0x00000001,
}
enum ReplacesGeneralNumericDefines : int
{
    IMAGE_DIRECTORY_ENTRY_COMHEADER = 0x0000000e,
}
enum CorTypeAttr : int
{
    tdVisibilityMask     = 0x00000007,
    tdNotPublic          = 0x00000000,
    tdPublic             = 0x00000001,
    tdNestedPublic       = 0x00000002,
    tdNestedPrivate      = 0x00000003,
    tdNestedFamily       = 0x00000004,
    tdNestedAssembly     = 0x00000005,
    tdNestedFamANDAssem  = 0x00000006,
    tdNestedFamORAssem   = 0x00000007,
    tdLayoutMask         = 0x00000018,
    tdAutoLayout         = 0x00000000,
    tdSequentialLayout   = 0x00000008,
    tdExplicitLayout     = 0x00000010,
    tdClassSemanticsMask = 0x00000020,
    tdClass              = 0x00000000,
    tdInterface          = 0x00000020,
    tdAbstract           = 0x00000080,
    tdSealed             = 0x00000100,
    tdSpecialName        = 0x00000400,
    tdImport             = 0x00001000,
    tdSerializable       = 0x00002000,
    tdWindowsRuntime     = 0x00004000,
    tdStringFormatMask   = 0x00030000,
    tdAnsiClass          = 0x00000000,
    tdUnicodeClass       = 0x00010000,
    tdAutoClass          = 0x00020000,
    tdCustomFormatClass  = 0x00030000,
    tdCustomFormatMask   = 0x00c00000,
    tdBeforeFieldInit    = 0x00100000,
    tdForwarder          = 0x00200000,
    tdReservedMask       = 0x00040800,
    tdRTSpecialName      = 0x00000800,
    tdHasSecurity        = 0x00040000,
}
enum CorMethodAttr : int
{
    mdMemberAccessMask      = 0x00000007,
    mdPrivateScope          = 0x00000000,
    mdPrivate               = 0x00000001,
    mdFamANDAssem           = 0x00000002,
    mdAssem                 = 0x00000003,
    mdFamily                = 0x00000004,
    mdFamORAssem            = 0x00000005,
    mdPublic                = 0x00000006,
    mdStatic                = 0x00000010,
    mdFinal                 = 0x00000020,
    mdVirtual               = 0x00000040,
    mdHideBySig             = 0x00000080,
    mdVtableLayoutMask      = 0x00000100,
    mdReuseSlot             = 0x00000000,
    mdNewSlot               = 0x00000100,
    mdCheckAccessOnOverride = 0x00000200,
    mdAbstract              = 0x00000400,
    mdSpecialName           = 0x00000800,
    mdPinvokeImpl           = 0x00002000,
    mdUnmanagedExport       = 0x00000008,
    mdReservedMask          = 0x0000d000,
    mdRTSpecialName         = 0x00001000,
    mdHasSecurity           = 0x00004000,
    mdRequireSecObject      = 0x00008000,
}
enum CorFieldAttr : int
{
    fdFieldAccessMask = 0x00000007,
    fdPrivateScope    = 0x00000000,
    fdPrivate         = 0x00000001,
    fdFamANDAssem     = 0x00000002,
    fdAssembly        = 0x00000003,
    fdFamily          = 0x00000004,
    fdFamORAssem      = 0x00000005,
    fdPublic          = 0x00000006,
    fdStatic          = 0x00000010,
    fdInitOnly        = 0x00000020,
    fdLiteral         = 0x00000040,
    fdNotSerialized   = 0x00000080,
    fdSpecialName     = 0x00000200,
    fdPinvokeImpl     = 0x00002000,
    fdReservedMask    = 0x00009500,
    fdRTSpecialName   = 0x00000400,
    fdHasFieldMarshal = 0x00001000,
    fdHasDefault      = 0x00008000,
    fdHasFieldRVA     = 0x00000100,
}
enum CorParamAttr : int
{
    pdIn              = 0x00000001,
    pdOut             = 0x00000002,
    pdOptional        = 0x00000010,
    pdReservedMask    = 0x0000f000,
    pdHasDefault      = 0x00001000,
    pdHasFieldMarshal = 0x00002000,
    pdUnused          = 0x0000cfe0,
}
enum CorPropertyAttr : int
{
    prSpecialName   = 0x00000200,
    prReservedMask  = 0x0000f400,
    prRTSpecialName = 0x00000400,
    prHasDefault    = 0x00001000,
    prUnused        = 0x0000e9ff,
}
enum CorEventAttr : int
{
    evSpecialName   = 0x00000200,
    evReservedMask  = 0x00000400,
    evRTSpecialName = 0x00000400,
}
enum CorMethodSemanticsAttr : int
{
    msSetter   = 0x00000001,
    msGetter   = 0x00000002,
    msOther    = 0x00000004,
    msAddOn    = 0x00000008,
    msRemoveOn = 0x00000010,
    msFire     = 0x00000020,
}
enum CorDeclSecurity : int
{
    dclActionMask        = 0x0000001f,
    dclActionNil         = 0x00000000,
    dclRequest           = 0x00000001,
    dclDemand            = 0x00000002,
    dclAssert            = 0x00000003,
    dclDeny              = 0x00000004,
    dclPermitOnly        = 0x00000005,
    dclLinktimeCheck     = 0x00000006,
    dclInheritanceCheck  = 0x00000007,
    dclRequestMinimum    = 0x00000008,
    dclRequestOptional   = 0x00000009,
    dclRequestRefuse     = 0x0000000a,
    dclPrejitGrant       = 0x0000000b,
    dclPrejitDenied      = 0x0000000c,
    dclNonCasDemand      = 0x0000000d,
    dclNonCasLinkDemand  = 0x0000000e,
    dclNonCasInheritance = 0x0000000f,
    dclMaximumValue      = 0x0000000f,
}
enum CorMethodImpl : int
{
    miCodeTypeMask        = 0x00000003,
    miIL                  = 0x00000000,
    miNative              = 0x00000001,
    miOPTIL               = 0x00000002,
    miRuntime             = 0x00000003,
    miManagedMask         = 0x00000004,
    miUnmanaged           = 0x00000004,
    miManaged             = 0x00000000,
    miForwardRef          = 0x00000010,
    miPreserveSig         = 0x00000080,
    miInternalCall        = 0x00001000,
    miSynchronized        = 0x00000020,
    miNoInlining          = 0x00000008,
    miAggressiveInlining  = 0x00000100,
    miNoOptimization      = 0x00000040,
    miSecurityMitigations = 0x00000400,
    miUserMask            = 0x000015fc,
    miMaxMethodImplVal    = 0x0000ffff,
}
enum CorPinvokeMap : int
{
    pmNoMangle                      = 0x00000001,
    pmCharSetMask                   = 0x00000006,
    pmCharSetNotSpec                = 0x00000000,
    pmCharSetAnsi                   = 0x00000002,
    pmCharSetUnicode                = 0x00000004,
    pmCharSetAuto                   = 0x00000006,
    pmBestFitUseAssem               = 0x00000000,
    pmBestFitEnabled                = 0x00000010,
    pmBestFitDisabled               = 0x00000020,
    pmBestFitMask                   = 0x00000030,
    pmThrowOnUnmappableCharUseAssem = 0x00000000,
    pmThrowOnUnmappableCharEnabled  = 0x00001000,
    pmThrowOnUnmappableCharDisabled = 0x00002000,
    pmThrowOnUnmappableCharMask     = 0x00003000,
    pmSupportsLastError             = 0x00000040,
    pmCallConvMask                  = 0x00000700,
    pmCallConvWinapi                = 0x00000100,
    pmCallConvCdecl                 = 0x00000200,
    pmCallConvStdcall               = 0x00000300,
    pmCallConvThiscall              = 0x00000400,
    pmCallConvFastcall              = 0x00000500,
    pmMaxValue                      = 0x0000ffff,
}
enum CorAssemblyFlags : int
{
    afPublicKey                  = 0x00000001,
    afPA_None                    = 0x00000000,
    afPA_MSIL                    = 0x00000010,
    afPA_x86                     = 0x00000020,
    afPA_IA64                    = 0x00000030,
    afPA_AMD64                   = 0x00000040,
    afPA_ARM                     = 0x00000050,
    afPA_NoPlatform              = 0x00000070,
    afPA_Specified               = 0x00000080,
    afPA_Mask                    = 0x00000070,
    afPA_FullMask                = 0x000000f0,
    afPA_Shift                   = 0x00000004,
    afEnableJITcompileTracking   = 0x00008000,
    afDisableJITcompileOptimizer = 0x00004000,
    afRetargetable               = 0x00000100,
    afContentType_Default        = 0x00000000,
    afContentType_WindowsRuntime = 0x00000200,
    afContentType_Mask           = 0x00000e00,
}
enum CorManifestResourceFlags : int
{
    mrVisibilityMask = 0x00000007,
    mrPublic         = 0x00000001,
    mrPrivate        = 0x00000002,
}
enum CorFileFlags : int
{
    ffContainsMetaData   = 0x00000000,
    ffContainsNoMetaData = 0x00000001,
}
enum CorPEKind : int
{
    peNot            = 0x00000000,
    peILonly         = 0x00000001,
    pe32BitRequired  = 0x00000002,
    pe32Plus         = 0x00000004,
    pe32Unmanaged    = 0x00000008,
    pe32BitPreferred = 0x00000010,
}
enum CorGenericParamAttr : int
{
    gpVarianceMask                   = 0x00000003,
    gpNonVariant                     = 0x00000000,
    gpCovariant                      = 0x00000001,
    gpContravariant                  = 0x00000002,
    gpSpecialConstraintMask          = 0x0000001c,
    gpNoSpecialConstraint            = 0x00000000,
    gpReferenceTypeConstraint        = 0x00000004,
    gpNotNullableValueTypeConstraint = 0x00000008,
    gpDefaultConstructorConstraint   = 0x00000010,
}
enum CorElementType : ubyte
{
    ELEMENT_TYPE_END         = 0x00,
    ELEMENT_TYPE_VOID        = 0x01,
    ELEMENT_TYPE_BOOLEAN     = 0x02,
    ELEMENT_TYPE_CHAR        = 0x03,
    ELEMENT_TYPE_I1          = 0x04,
    ELEMENT_TYPE_U1          = 0x05,
    ELEMENT_TYPE_I2          = 0x06,
    ELEMENT_TYPE_U2          = 0x07,
    ELEMENT_TYPE_I4          = 0x08,
    ELEMENT_TYPE_U4          = 0x09,
    ELEMENT_TYPE_I8          = 0x0a,
    ELEMENT_TYPE_U8          = 0x0b,
    ELEMENT_TYPE_R4          = 0x0c,
    ELEMENT_TYPE_R8          = 0x0d,
    ELEMENT_TYPE_STRING      = 0x0e,
    ELEMENT_TYPE_PTR         = 0x0f,
    ELEMENT_TYPE_BYREF       = 0x10,
    ELEMENT_TYPE_VALUETYPE   = 0x11,
    ELEMENT_TYPE_CLASS       = 0x12,
    ELEMENT_TYPE_VAR         = 0x13,
    ELEMENT_TYPE_ARRAY       = 0x14,
    ELEMENT_TYPE_GENERICINST = 0x15,
    ELEMENT_TYPE_TYPEDBYREF  = 0x16,
    ELEMENT_TYPE_I           = 0x18,
    ELEMENT_TYPE_U           = 0x19,
    ELEMENT_TYPE_FNPTR       = 0x1b,
    ELEMENT_TYPE_OBJECT      = 0x1c,
    ELEMENT_TYPE_SZARRAY     = 0x1d,
    ELEMENT_TYPE_MVAR        = 0x1e,
    ELEMENT_TYPE_CMOD_REQD   = 0x1f,
    ELEMENT_TYPE_CMOD_OPT    = 0x20,
    ELEMENT_TYPE_INTERNAL    = 0x21,
    ELEMENT_TYPE_MAX         = 0x22,
    ELEMENT_TYPE_MODIFIER    = 0x40,
    ELEMENT_TYPE_SENTINEL    = 0x41,
    ELEMENT_TYPE_PINNED      = 0x45,
}
enum CorSerializationType : int
{
    SERIALIZATION_TYPE_UNDEFINED     = 0x00000000,
    SERIALIZATION_TYPE_BOOLEAN       = 0x00000002,
    SERIALIZATION_TYPE_CHAR          = 0x00000003,
    SERIALIZATION_TYPE_I1            = 0x00000004,
    SERIALIZATION_TYPE_U1            = 0x00000005,
    SERIALIZATION_TYPE_I2            = 0x00000006,
    SERIALIZATION_TYPE_U2            = 0x00000007,
    SERIALIZATION_TYPE_I4            = 0x00000008,
    SERIALIZATION_TYPE_U4            = 0x00000009,
    SERIALIZATION_TYPE_I8            = 0x0000000a,
    SERIALIZATION_TYPE_U8            = 0x0000000b,
    SERIALIZATION_TYPE_R4            = 0x0000000c,
    SERIALIZATION_TYPE_R8            = 0x0000000d,
    SERIALIZATION_TYPE_STRING        = 0x0000000e,
    SERIALIZATION_TYPE_SZARRAY       = 0x0000001d,
    SERIALIZATION_TYPE_TYPE          = 0x00000050,
    SERIALIZATION_TYPE_TAGGED_OBJECT = 0x00000051,
    SERIALIZATION_TYPE_FIELD         = 0x00000053,
    SERIALIZATION_TYPE_PROPERTY      = 0x00000054,
    SERIALIZATION_TYPE_ENUM          = 0x00000055,
}
enum CorCallingConvention : int
{
    IMAGE_CEE_CS_CALLCONV_DEFAULT      = 0x00000000,
    IMAGE_CEE_CS_CALLCONV_VARARG       = 0x00000005,
    IMAGE_CEE_CS_CALLCONV_FIELD        = 0x00000006,
    IMAGE_CEE_CS_CALLCONV_LOCAL_SIG    = 0x00000007,
    IMAGE_CEE_CS_CALLCONV_PROPERTY     = 0x00000008,
    IMAGE_CEE_CS_CALLCONV_UNMGD        = 0x00000009,
    IMAGE_CEE_CS_CALLCONV_GENERICINST  = 0x0000000a,
    IMAGE_CEE_CS_CALLCONV_NATIVEVARARG = 0x0000000b,
    IMAGE_CEE_CS_CALLCONV_MAX          = 0x0000000c,
    IMAGE_CEE_CS_CALLCONV_MASK         = 0x0000000f,
    IMAGE_CEE_CS_CALLCONV_HASTHIS      = 0x00000020,
    IMAGE_CEE_CS_CALLCONV_EXPLICITTHIS = 0x00000040,
    IMAGE_CEE_CS_CALLCONV_GENERIC      = 0x00000010,
}
enum CorUnmanagedCallingConvention : int
{
    IMAGE_CEE_UNMANAGED_CALLCONV_C        = 0x00000001,
    IMAGE_CEE_UNMANAGED_CALLCONV_STDCALL  = 0x00000002,
    IMAGE_CEE_UNMANAGED_CALLCONV_THISCALL = 0x00000003,
    IMAGE_CEE_UNMANAGED_CALLCONV_FASTCALL = 0x00000004,
    IMAGE_CEE_CS_CALLCONV_C               = 0x00000001,
    IMAGE_CEE_CS_CALLCONV_STDCALL         = 0x00000002,
    IMAGE_CEE_CS_CALLCONV_THISCALL        = 0x00000003,
    IMAGE_CEE_CS_CALLCONV_FASTCALL        = 0x00000004,
}
enum CorArgType : int
{
    IMAGE_CEE_CS_END      = 0x00000000,
    IMAGE_CEE_CS_VOID     = 0x00000001,
    IMAGE_CEE_CS_I4       = 0x00000002,
    IMAGE_CEE_CS_I8       = 0x00000003,
    IMAGE_CEE_CS_R4       = 0x00000004,
    IMAGE_CEE_CS_R8       = 0x00000005,
    IMAGE_CEE_CS_PTR      = 0x00000006,
    IMAGE_CEE_CS_OBJECT   = 0x00000007,
    IMAGE_CEE_CS_STRUCT4  = 0x00000008,
    IMAGE_CEE_CS_STRUCT32 = 0x00000009,
    IMAGE_CEE_CS_BYVALUE  = 0x0000000a,
}
enum CorNativeType : int
{
    NATIVE_TYPE_END             = 0x00000000,
    NATIVE_TYPE_VOID            = 0x00000001,
    NATIVE_TYPE_BOOLEAN         = 0x00000002,
    NATIVE_TYPE_I1              = 0x00000003,
    NATIVE_TYPE_U1              = 0x00000004,
    NATIVE_TYPE_I2              = 0x00000005,
    NATIVE_TYPE_U2              = 0x00000006,
    NATIVE_TYPE_I4              = 0x00000007,
    NATIVE_TYPE_U4              = 0x00000008,
    NATIVE_TYPE_I8              = 0x00000009,
    NATIVE_TYPE_U8              = 0x0000000a,
    NATIVE_TYPE_R4              = 0x0000000b,
    NATIVE_TYPE_R8              = 0x0000000c,
    NATIVE_TYPE_SYSCHAR         = 0x0000000d,
    NATIVE_TYPE_VARIANT         = 0x0000000e,
    NATIVE_TYPE_CURRENCY        = 0x0000000f,
    NATIVE_TYPE_PTR             = 0x00000010,
    NATIVE_TYPE_DECIMAL         = 0x00000011,
    NATIVE_TYPE_DATE            = 0x00000012,
    NATIVE_TYPE_BSTR            = 0x00000013,
    NATIVE_TYPE_LPSTR           = 0x00000014,
    NATIVE_TYPE_LPWSTR          = 0x00000015,
    NATIVE_TYPE_LPTSTR          = 0x00000016,
    NATIVE_TYPE_FIXEDSYSSTRING  = 0x00000017,
    NATIVE_TYPE_OBJECTREF       = 0x00000018,
    NATIVE_TYPE_IUNKNOWN        = 0x00000019,
    NATIVE_TYPE_IDISPATCH       = 0x0000001a,
    NATIVE_TYPE_STRUCT          = 0x0000001b,
    NATIVE_TYPE_INTF            = 0x0000001c,
    NATIVE_TYPE_SAFEARRAY       = 0x0000001d,
    NATIVE_TYPE_FIXEDARRAY      = 0x0000001e,
    NATIVE_TYPE_INT             = 0x0000001f,
    NATIVE_TYPE_UINT            = 0x00000020,
    NATIVE_TYPE_NESTEDSTRUCT    = 0x00000021,
    NATIVE_TYPE_BYVALSTR        = 0x00000022,
    NATIVE_TYPE_ANSIBSTR        = 0x00000023,
    NATIVE_TYPE_TBSTR           = 0x00000024,
    NATIVE_TYPE_VARIANTBOOL     = 0x00000025,
    NATIVE_TYPE_FUNC            = 0x00000026,
    NATIVE_TYPE_ASANY           = 0x00000028,
    NATIVE_TYPE_ARRAY           = 0x0000002a,
    NATIVE_TYPE_LPSTRUCT        = 0x0000002b,
    NATIVE_TYPE_CUSTOMMARSHALER = 0x0000002c,
    NATIVE_TYPE_ERROR           = 0x0000002d,
    NATIVE_TYPE_IINSPECTABLE    = 0x0000002e,
    NATIVE_TYPE_HSTRING         = 0x0000002f,
    NATIVE_TYPE_LPUTF8STR       = 0x00000030,
    NATIVE_TYPE_MAX             = 0x00000050,
}
enum CorILMethodSect : int
{
    CorILMethod_Sect_Reserved   = 0x00000000,
    CorILMethod_Sect_EHTable    = 0x00000001,
    CorILMethod_Sect_OptILTable = 0x00000002,
    CorILMethod_Sect_KindMask   = 0x0000003f,
    CorILMethod_Sect_FatFormat  = 0x00000040,
    CorILMethod_Sect_MoreSects  = 0x00000080,
}
enum CorExceptionFlag : int
{
    COR_ILEXCEPTION_CLAUSE_NONE       = 0x00000000,
    COR_ILEXCEPTION_CLAUSE_OFFSETLEN  = 0x00000000,
    COR_ILEXCEPTION_CLAUSE_DEPRECATED = 0x00000000,
    COR_ILEXCEPTION_CLAUSE_FILTER     = 0x00000001,
    COR_ILEXCEPTION_CLAUSE_FINALLY    = 0x00000002,
    COR_ILEXCEPTION_CLAUSE_FAULT      = 0x00000004,
    COR_ILEXCEPTION_CLAUSE_DUPLICATED = 0x00000008,
}
enum CorILMethodFlags : int
{
    CorILMethod_InitLocals   = 0x00000010,
    CorILMethod_MoreSects    = 0x00000008,
    CorILMethod_CompressedIL = 0x00000040,
    CorILMethod_FormatShift  = 0x00000003,
    CorILMethod_FormatMask   = 0x00000007,
    CorILMethod_TinyFormat   = 0x00000002,
    CorILMethod_SmallFormat  = 0x00000000,
    CorILMethod_FatFormat    = 0x00000003,
    CorILMethod_TinyFormat1  = 0x00000006,
}
enum CorCheckDuplicatesFor : int
{
    MDDupAll                    = 0xffffffff,
    MDDupENC                    = 0xffffffff,
    MDNoDupChecks               = 0x00000000,
    MDDupTypeDef                = 0x00000001,
    MDDupInterfaceImpl          = 0x00000002,
    MDDupMethodDef              = 0x00000004,
    MDDupTypeRef                = 0x00000008,
    MDDupMemberRef              = 0x00000010,
    MDDupCustomAttribute        = 0x00000020,
    MDDupParamDef               = 0x00000040,
    MDDupPermission             = 0x00000080,
    MDDupProperty               = 0x00000100,
    MDDupEvent                  = 0x00000200,
    MDDupFieldDef               = 0x00000400,
    MDDupSignature              = 0x00000800,
    MDDupModuleRef              = 0x00001000,
    MDDupTypeSpec               = 0x00002000,
    MDDupImplMap                = 0x00004000,
    MDDupAssemblyRef            = 0x00008000,
    MDDupFile                   = 0x00010000,
    MDDupExportedType           = 0x00020000,
    MDDupManifestResource       = 0x00040000,
    MDDupGenericParam           = 0x00080000,
    MDDupMethodSpec             = 0x00100000,
    MDDupGenericParamConstraint = 0x00200000,
    MDDupAssembly               = 0x10000000,
    MDDupDefault                = 0x00102818,
}
enum CorRefToDefCheck : int
{
    MDRefToDefDefault = 0x00000003,
    MDRefToDefAll     = 0xffffffff,
    MDRefToDefNone    = 0x00000000,
    MDTypeRefToDef    = 0x00000001,
    MDMemberRefToDef  = 0x00000002,
}
enum CorNotificationForTokenMovement : int
{
    MDNotifyDefault         = 0x0000000f,
    MDNotifyAll             = 0xffffffff,
    MDNotifyNone            = 0x00000000,
    MDNotifyMethodDef       = 0x00000001,
    MDNotifyMemberRef       = 0x00000002,
    MDNotifyFieldDef        = 0x00000004,
    MDNotifyTypeRef         = 0x00000008,
    MDNotifyTypeDef         = 0x00000010,
    MDNotifyParamDef        = 0x00000020,
    MDNotifyInterfaceImpl   = 0x00000040,
    MDNotifyProperty        = 0x00000080,
    MDNotifyEvent           = 0x00000100,
    MDNotifySignature       = 0x00000200,
    MDNotifyTypeSpec        = 0x00000400,
    MDNotifyCustomAttribute = 0x00000800,
    MDNotifySecurityValue   = 0x00001000,
    MDNotifyPermission      = 0x00002000,
    MDNotifyModuleRef       = 0x00004000,
    MDNotifyNameSpace       = 0x00008000,
    MDNotifyAssemblyRef     = 0x01000000,
    MDNotifyFile            = 0x02000000,
    MDNotifyExportedType    = 0x04000000,
    MDNotifyResource        = 0x08000000,
}
alias CorSetENC = int;
enum : int
{
    MDSetENCOn          = 0x00000001,
    MDSetENCOff         = 0x00000002,
    MDUpdateENC         = 0x00000001,
    MDUpdateFull        = 0x00000002,
    MDUpdateExtension   = 0x00000003,
    MDUpdateIncremental = 0x00000004,
    MDUpdateDelta       = 0x00000005,
    MDUpdateMask        = 0x00000007,
}
enum CorErrorIfEmitOutOfOrder : int
{
    MDErrorOutOfOrderDefault = 0x00000000,
    MDErrorOutOfOrderNone    = 0x00000000,
    MDErrorOutOfOrderAll     = 0xffffffff,
    MDMethodOutOfOrder       = 0x00000001,
    MDFieldOutOfOrder        = 0x00000002,
    MDParamOutOfOrder        = 0x00000004,
    MDPropertyOutOfOrder     = 0x00000008,
    MDEventOutOfOrder        = 0x00000010,
}
enum CorImportOptions : int
{
    MDImportOptionDefault             = 0x00000000,
    MDImportOptionAll                 = 0xffffffff,
    MDImportOptionAllTypeDefs         = 0x00000001,
    MDImportOptionAllMethodDefs       = 0x00000002,
    MDImportOptionAllFieldDefs        = 0x00000004,
    MDImportOptionAllProperties       = 0x00000008,
    MDImportOptionAllEvents           = 0x00000010,
    MDImportOptionAllCustomAttributes = 0x00000020,
    MDImportOptionAllExportedTypes    = 0x00000040,
}
enum CorThreadSafetyOptions : int
{
    MDThreadSafetyDefault = 0x00000000,
    MDThreadSafetyOff     = 0x00000000,
    MDThreadSafetyOn      = 0x00000001,
}
enum CorLinkerOptions : int
{
    MDAssembly  = 0x00000000,
    MDNetModule = 0x00000001,
}
enum MergeFlags : int
{
    MergeFlagsNone     = 0x00000000,
    MergeManifest      = 0x00000001,
    DropMemberRefCAs   = 0x00000002,
    NoDupCheck         = 0x00000004,
    MergeExportedTypes = 0x00000008,
}
enum CorLocalRefPreservation : int
{
    MDPreserveLocalRefsNone  = 0x00000000,
    MDPreserveLocalTypeRef   = 0x00000001,
    MDPreserveLocalMemberRef = 0x00000002,
}
enum CorTokenType : int
{
    mdtModule                 = 0x00000000,
    mdtTypeRef                = 0x01000000,
    mdtTypeDef                = 0x02000000,
    mdtFieldDef               = 0x04000000,
    mdtMethodDef              = 0x06000000,
    mdtParamDef               = 0x08000000,
    mdtInterfaceImpl          = 0x09000000,
    mdtMemberRef              = 0x0a000000,
    mdtCustomAttribute        = 0x0c000000,
    mdtPermission             = 0x0e000000,
    mdtSignature              = 0x11000000,
    mdtEvent                  = 0x14000000,
    mdtProperty               = 0x17000000,
    mdtMethodImpl             = 0x19000000,
    mdtModuleRef              = 0x1a000000,
    mdtTypeSpec               = 0x1b000000,
    mdtAssembly               = 0x20000000,
    mdtAssemblyRef            = 0x23000000,
    mdtFile                   = 0x26000000,
    mdtExportedType           = 0x27000000,
    mdtManifestResource       = 0x28000000,
    mdtGenericParam           = 0x2a000000,
    mdtMethodSpec             = 0x2b000000,
    mdtGenericParamConstraint = 0x2c000000,
    mdtString                 = 0x70000000,
    mdtName                   = 0x71000000,
    mdtBaseType               = 0x72000000,
}
enum CorOpenFlags : int
{
    ofRead           = 0x00000000,
    ofWrite          = 0x00000001,
    ofReadWriteMask  = 0x00000001,
    ofCopyMemory     = 0x00000002,
    ofReadOnly       = 0x00000010,
    ofTakeOwnership  = 0x00000020,
    ofNoTypeLib      = 0x00000080,
    ofNoTransform    = 0x00001000,
    ofCheckIntegrity = 0x00000800,
    ofReserved1      = 0x00000100,
    ofReserved2      = 0x00000200,
    ofReserved3      = 0x00000400,
    ofReserved       = 0xffffe740,
}
enum CorFileMapping : int
{
    fmFlat            = 0x00000000,
    fmExecutableImage = 0x00000001,
}
enum CorAttributeTargets : int
{
    catAssembly         = 0x00000001,
    catModule           = 0x00000002,
    catClass            = 0x00000004,
    catStruct           = 0x00000008,
    catEnum             = 0x00000010,
    catConstructor      = 0x00000020,
    catMethod           = 0x00000040,
    catProperty         = 0x00000080,
    catField            = 0x00000100,
    catEvent            = 0x00000200,
    catInterface        = 0x00000400,
    catParameter        = 0x00000800,
    catDelegate         = 0x00001000,
    catGenericParameter = 0x00004000,
    catAll              = 0x00005fff,
    catClassMembers     = 0x000017fc,
}
enum CompilationRelaxationsEnum : int
{
    CompilationRelaxations_NoStringInterning = 0x00000008,
}
enum NGenHintEnum : int
{
    NGenDefault = 0x00000000,
    NGenEager   = 0x00000001,
    NGenLazy    = 0x00000002,
    NGenNever   = 0x00000003,
}
enum LoadHintEnum : int
{
    LoadDefault   = 0x00000000,
    LoadAlways    = 0x00000001,
    LoadSometimes = 0x00000002,
    LoadNever     = 0x00000003,
}
enum CorSaveSize : int
{
    cssAccurate            = 0x00000000,
    cssQuick               = 0x00000001,
    cssDiscardTransientCAs = 0x00000002,
}
enum NativeTypeArrayFlags : int
{
    ntaSizeParamIndexSpecified = 0x00000001,
    ntaReserved                = 0x0000fffe,
}
enum CorValidatorModuleType : int
{
    ValidatorModuleTypeInvalid = 0x00000000,
    ValidatorModuleTypeMin     = 0x00000001,
    ValidatorModuleTypePE      = 0x00000001,
    ValidatorModuleTypeObj     = 0x00000002,
    ValidatorModuleTypeEnc     = 0x00000003,
    ValidatorModuleTypeIncr    = 0x00000004,
    ValidatorModuleTypeMax     = 0x00000004,
}
enum CorRegFlags : int
{
    regNoCopy  = 0x00000001,
    regConfig  = 0x00000002,
    regHasRefs = 0x00000004,
}
enum CeeSectionAttr : long
{
    sdNone      = 0x0000000000000000,
    sdReadOnly  = 0x0000000040000040,
    sdReadWrite = 0x00000000c0000040,
    sdExecute   = 0x0000000060000020,
}
enum CeeSectionRelocType : int
{
    srRelocAbsolute       = 0x00000000,
    srRelocHighLow        = 0x00000003,
    srRelocHighAdj        = 0x00000004,
    srRelocMapToken       = 0x00000005,
    srRelocRelative       = 0x00000006,
    srRelocFilePos        = 0x00000007,
    srRelocCodeRelative   = 0x00000008,
    srRelocIA64Imm64      = 0x00000009,
    srRelocDir64          = 0x0000000a,
    srRelocIA64PcRel25    = 0x0000000b,
    srRelocIA64PcRel64    = 0x0000000c,
    srRelocAbsoluteTagged = 0x0000000d,
    srRelocSentinel       = 0x0000000e,
    srNoBaseReloc         = 0x00004000,
    srRelocPtr            = 0x00008000,
    srRelocAbsolutePtr    = 0x00008000,
    srRelocHighLowPtr     = 0x00008003,
    srRelocRelativePtr    = 0x00008006,
    srRelocIA64Imm64Ptr   = 0x00008009,
    srRelocDir64Ptr       = 0x0000800a,
}
enum CorNativeLinkType : int
{
    nltNone     = 0x00000001,
    nltAnsi     = 0x00000002,
    nltUnicode  = 0x00000003,
    nltAuto     = 0x00000004,
    nltOle      = 0x00000005,
    nltMaxValue = 0x00000007,
}
enum CorNativeLinkFlags : int
{
    nlfNone      = 0x00000000,
    nlfLastError = 0x00000001,
    nlfNoMangle  = 0x00000002,
    nlfMaxValue  = 0x00000003,
}

// Constants


enum uint INVALID_CONNECTION_ID = 0x00000000;
enum uint INVALID_TASK_ID = 0x00000000;
enum uint MAX_CONNECTION_NAME = 0x00000104;

enum : const(wchar)*
{
    MAIN_CLR_MODULE_NAME_W = "coreclr",
    MAIN_CLR_MODULE_NAME_A = "coreclr",
}

enum : const(wchar)*
{
    MSCOREE_SHIM_W = "mscoree.dll",
    MSCOREE_SHIM_A = "mscoree.dll",
}

enum : const(wchar)*
{
    COR_NATIVE_LINK_CUSTOM_VALUE      = "COMPLUS_NativeLink",
    COR_NATIVE_LINK_CUSTOM_VALUE_ANSI = "COMPLUS_NativeLink",
}

enum uint COR_NATIVE_LINK_CUSTOM_VALUE_CC = 0x00000012;

enum : const(wchar)*
{
    COR_BASE_SECURITY_ATTRIBUTE_CLASS      = "System.Security.Permissions.SecurityAttribute",
    COR_BASE_SECURITY_ATTRIBUTE_CLASS_ANSI = "System.Security.Permissions.SecurityAttribute",
}

enum : const(wchar)*
{
    COR_SUPPRESS_UNMANAGED_CODE_CHECK_ATTRIBUTE      = "System.Security.SuppressUnmanagedCodeSecurityAttribute",
    COR_SUPPRESS_UNMANAGED_CODE_CHECK_ATTRIBUTE_ANSI = "System.Security.SuppressUnmanagedCodeSecurityAttribute",
}

enum : const(wchar)*
{
    COR_UNVER_CODE_ATTRIBUTE      = "System.Security.UnverifiableCodeAttribute",
    COR_UNVER_CODE_ATTRIBUTE_ANSI = "System.Security.UnverifiableCodeAttribute",
}

enum : const(wchar)*
{
    COR_REQUIRES_SECOBJ_ATTRIBUTE      = "System.Security.DynamicSecurityMethodAttribute",
    COR_REQUIRES_SECOBJ_ATTRIBUTE_ANSI = "System.Security.DynamicSecurityMethodAttribute",
}

enum : const(wchar)*
{
    COR_COMPILERSERVICE_DISCARDABLEATTRIBUTE      = "System.Runtime.CompilerServices.DiscardableAttribute",
    COR_COMPILERSERVICE_DISCARDABLEATTRIBUTE_ASNI = "System.Runtime.CompilerServices.DiscardableAttribute",
}

enum int COR_E_UNAUTHORIZEDACCESS = 0x80070005;

enum : int
{
    COR_E_ARGUMENT    = 0x80070057,
    COR_E_INVALIDCAST = 0x80004002,
}

enum int COR_E_OUTOFMEMORY = 0x8007000e;
enum int COR_E_NULLREFERENCE = 0x80004003;
enum HRESULT COR_E_AMBIGUOUSMATCH = HRESULT(0x8000211d);
enum HRESULT COR_E_TARGETPARAMCOUNT = HRESULT(0x8002000e);
enum HRESULT COR_E_DIVIDEBYZERO = HRESULT(0x80020012);
enum HRESULT COR_E_BADIMAGEFORMAT = HRESULT(0x8007000b);

enum : /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)*
{
    FRAMEWORK_REGISTRY_KEY   = "Software\\Microsoft\\.NETFramework",
    FRAMEWORK_REGISTRY_KEY_W = "Software\\Microsoft\\.NETFramework",
}

enum : /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)*
{
    USER_FRAMEWORK_REGISTRY_KEY   = "Software\\Microsoft\\.NETFramework64",
    USER_FRAMEWORK_REGISTRY_KEY_W = "Software\\Microsoft\\.NETFramework64",
}

enum : /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)*
{
    COR_CTOR_METHOD_NAME   = ".ctor",
    COR_CTOR_METHOD_NAME_W = ".ctor",
}

enum : /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)*
{
    COR_CCTOR_METHOD_NAME   = ".cctor",
    COR_CCTOR_METHOD_NAME_W = ".cctor",
}

enum : /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)*
{
    COR_ENUM_FIELD_NAME   = "value__",
    COR_ENUM_FIELD_NAME_W = "value__",
}

enum : /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)*
{
    COR_DELETED_NAME_A = "_Deleted",
    COR_DELETED_NAME_W = "_Deleted",
}

enum : /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)*
{
    COR_VTABLEGAP_NAME_A = "_VtblGap",
    COR_VTABLEGAP_NAME_W = "_VtblGap",
}

enum : const(wchar)*
{
    INTEROP_DISPID_TYPE_W        = "System.Runtime.InteropServices.DispIdAttribute",
    INTEROP_DISPID_TYPE          = "System.Runtime.InteropServices.DispIdAttribute",
    INTEROP_INTERFACETYPE_TYPE_W = "System.Runtime.InteropServices.InterfaceTypeAttribute",
    INTEROP_INTERFACETYPE_TYPE   = "System.Runtime.InteropServices.InterfaceTypeAttribute",
}

enum : const(wchar)*
{
    INTEROP_CLASSINTERFACE_TYPE_W = "System.Runtime.InteropServices.ClassInterfaceAttribute",
    INTEROP_CLASSINTERFACE_TYPE   = "System.Runtime.InteropServices.ClassInterfaceAttribute",
}

enum : const(wchar)*
{
    INTEROP_COMVISIBLE_TYPE_W          = "System.Runtime.InteropServices.ComVisibleAttribute",
    INTEROP_COMVISIBLE_TYPE            = "System.Runtime.InteropServices.ComVisibleAttribute",
    INTEROP_COMREGISTERFUNCTION_TYPE_W = "System.Runtime.InteropServices.ComRegisterFunctionAttribute",
    INTEROP_COMREGISTERFUNCTION_TYPE   = "System.Runtime.InteropServices.ComRegisterFunctionAttribute",
}

enum : const(wchar)*
{
    INTEROP_COMUNREGISTERFUNCTION_TYPE_W = "System.Runtime.InteropServices.ComUnregisterFunctionAttribute",
    INTEROP_COMUNREGISTERFUNCTION_TYPE   = "System.Runtime.InteropServices.ComUnregisterFunctionAttribute",
}

enum : const(wchar)*
{
    INTEROP_IMPORTEDFROMTYPELIB_TYPE_W = "System.Runtime.InteropServices.ImportedFromTypeLibAttribute",
    INTEROP_IMPORTEDFROMTYPELIB_TYPE   = "System.Runtime.InteropServices.ImportedFromTypeLibAttribute",
}

enum : const(wchar)*
{
    INTEROP_PRIMARYINTEROPASSEMBLY_TYPE_W = "System.Runtime.InteropServices.PrimaryInteropAssemblyAttribute",
    INTEROP_PRIMARYINTEROPASSEMBLY_TYPE   = "System.Runtime.InteropServices.PrimaryInteropAssemblyAttribute",
}

enum : const(wchar)*
{
    INTEROP_IDISPATCHIMPL_TYPE_W = "System.Runtime.InteropServices.IDispatchImplAttribute",
    INTEROP_IDISPATCHIMPL_TYPE   = "System.Runtime.InteropServices.IDispatchImplAttribute",
}

enum : const(wchar)*
{
    INTEROP_COMSOURCEINTERFACES_TYPE_W = "System.Runtime.InteropServices.ComSourceInterfacesAttribute",
    INTEROP_COMSOURCEINTERFACES_TYPE   = "System.Runtime.InteropServices.ComSourceInterfacesAttribute",
}

enum : const(wchar)*
{
    INTEROP_COMDEFAULTINTERFACE_TYPE_W = "System.Runtime.InteropServices.ComDefaultInterfaceAttribute",
    INTEROP_COMDEFAULTINTERFACE_TYPE   = "System.Runtime.InteropServices.ComDefaultInterfaceAttribute",
}

enum : const(wchar)*
{
    INTEROP_COMCONVERSIONLOSS_TYPE_W = "System.Runtime.InteropServices.ComConversionLossAttribute",
    INTEROP_COMCONVERSIONLOSS_TYPE   = "System.Runtime.InteropServices.ComConversionLossAttribute",
}

enum : const(wchar)*
{
    INTEROP_BESTFITMAPPING_TYPE_W = "System.Runtime.InteropServices.BestFitMappingAttribute",
    INTEROP_BESTFITMAPPING_TYPE   = "System.Runtime.InteropServices.BestFitMappingAttribute",
}

enum : const(wchar)*
{
    INTEROP_TYPELIBTYPE_TYPE_W = "System.Runtime.InteropServices.TypeLibTypeAttribute",
    INTEROP_TYPELIBTYPE_TYPE   = "System.Runtime.InteropServices.TypeLibTypeAttribute",
    INTEROP_TYPELIBFUNC_TYPE_W = "System.Runtime.InteropServices.TypeLibFuncAttribute",
    INTEROP_TYPELIBFUNC_TYPE   = "System.Runtime.InteropServices.TypeLibFuncAttribute",
    INTEROP_TYPELIBVAR_TYPE_W  = "System.Runtime.InteropServices.TypeLibVarAttribute",
    INTEROP_TYPELIBVAR_TYPE    = "System.Runtime.InteropServices.TypeLibVarAttribute",
}

enum : const(wchar)*
{
    INTEROP_MARSHALAS_TYPE_W = "System.Runtime.InteropServices.MarshalAsAttribute",
    INTEROP_MARSHALAS_TYPE   = "System.Runtime.InteropServices.MarshalAsAttribute",
}

enum : const(wchar)*
{
    INTEROP_COMIMPORT_TYPE_W = "System.Runtime.InteropServices.ComImportAttribute",
    INTEROP_COMIMPORT_TYPE   = "System.Runtime.InteropServices.ComImportAttribute",
}

enum : const(wchar)*
{
    INTEROP_GUID_TYPE_W          = "System.Runtime.InteropServices.GuidAttribute",
    INTEROP_GUID_TYPE            = "System.Runtime.InteropServices.GuidAttribute",
    INTEROP_DEFAULTMEMBER_TYPE_W = "System.Reflection.DefaultMemberAttribute",
    INTEROP_DEFAULTMEMBER_TYPE   = "System.Reflection.DefaultMemberAttribute",
}

enum : const(wchar)*
{
    INTEROP_COMEMULATE_TYPE_W = "System.Runtime.InteropServices.ComEmulateAttribute",
    INTEROP_COMEMULATE_TYPE   = "System.Runtime.InteropServices.ComEmulateAttribute",
}

enum : const(wchar)*
{
    INTEROP_PRESERVESIG_TYPE_W = "System.Runtime.InteropServices.PreserveSigAttribure",
    INTEROP_PRESERVESIG_TYPE   = "System.Runtime.InteropServices.PreserveSigAttribure",
}

enum : const(wchar)*
{
    INTEROP_IN_TYPE_W           = "System.Runtime.InteropServices.InAttribute",
    INTEROP_IN_TYPE             = "System.Runtime.InteropServices.InAttribute",
    INTEROP_OUT_TYPE_W          = "System.Runtime.InteropServices.OutAttribute",
    INTEROP_OUT_TYPE            = "System.Runtime.InteropServices.OutAttribute",
    INTEROP_COMALIASNAME_TYPE_W = "System.Runtime.InteropServices.ComAliasNameAttribute",
    INTEROP_COMALIASNAME_TYPE   = "System.Runtime.InteropServices.ComAliasNameAttribute",
}

enum : const(wchar)*
{
    INTEROP_PARAMARRAY_TYPE_W = "System.ParamArrayAttribute",
    INTEROP_PARAMARRAY_TYPE   = "System.ParamArrayAttribute",
}

enum : const(wchar)*
{
    INTEROP_LCIDCONVERSION_TYPE_W = "System.Runtime.InteropServices.LCIDConversionAttribute",
    INTEROP_LCIDCONVERSION_TYPE   = "System.Runtime.InteropServices.LCIDConversionAttribute",
}

enum : const(wchar)*
{
    INTEROP_COMSUBSTITUTABLEINTERFACE_TYPE_W = "System.Runtime.InteropServices.ComSubstitutableInterfaceAttribute",
    INTEROP_COMSUBSTITUTABLEINTERFACE_TYPE   = "System.Runtime.InteropServices.ComSubstitutableInterfaceAttribute",
}

enum : const(wchar)*
{
    INTEROP_DECIMALVALUE_TYPE_W = "System.Runtime.CompilerServices.DecimalConstantAttribute",
    INTEROP_DECIMALVALUE_TYPE   = "System.Runtime.CompilerServices.DecimalConstantAttribute",
}

enum : const(wchar)*
{
    INTEROP_DATETIMEVALUE_TYPE_W = "System.Runtime.CompilerServices.DateTimeConstantAttribute",
    INTEROP_DATETIMEVALUE_TYPE   = "System.Runtime.CompilerServices.DateTimeConstantAttribute",
}

enum : const(wchar)*
{
    INTEROP_IUNKNOWNVALUE_TYPE_W = "System.Runtime.CompilerServices.IUnknownConstantAttribute",
    INTEROP_IUNKNOWNVALUE_TYPE   = "System.Runtime.CompilerServices.IUnknownConstantAttribute",
}

enum : const(wchar)*
{
    INTEROP_IDISPATCHVALUE_TYPE_W = "System.Runtime.CompilerServices.IDispatchConstantAttribute",
    INTEROP_IDISPATCHVALUE_TYPE   = "System.Runtime.CompilerServices.IDispatchConstantAttribute",
}

enum : const(wchar)*
{
    INTEROP_AUTOPROXY_TYPE_W = "System.Runtime.InteropServices.AutomationProxyAttribute",
    INTEROP_AUTOPROXY_TYPE   = "System.Runtime.InteropServices.AutomationProxyAttribute",
}

enum : const(wchar)*
{
    INTEROP_TYPELIBIMPORTCLASS_TYPE_W = "System.Runtime.InteropServices.TypeLibImportClassAttribute",
    INTEROP_TYPELIBIMPORTCLASS_TYPE   = "System.Runtime.InteropServices.TypeLibImportClassAttribute",
    INTEROP_TYPELIBVERSION_TYPE_W     = "System.Runtime.InteropServices.TypeLibVersionAttribute",
    INTEROP_TYPELIBVERSION_TYPE       = "System.Runtime.InteropServices.TypeLibVersionAttribute",
}

enum : const(wchar)*
{
    INTEROP_COMCOMPATIBLEVERSION_TYPE_W = "System.Runtime.InteropServices.ComCompatibleVersionAttribute",
    INTEROP_COMCOMPATIBLEVERSION_TYPE   = "System.Runtime.InteropServices.ComCompatibleVersionAttribute",
}

enum : const(wchar)*
{
    INTEROP_COMEVENTINTERFACE_TYPE_W = "System.Runtime.InteropServices.ComEventInterfaceAttribute",
    INTEROP_COMEVENTINTERFACE_TYPE   = "System.Runtime.InteropServices.ComEventInterfaceAttribute",
}

enum : const(wchar)*
{
    INTEROP_COCLASS_TYPE_W = "System.Runtime.InteropServices.CoClassAttribute",
    INTEROP_COCLASS_TYPE   = "System.Runtime.InteropServices.CoClassAttribute",
}

enum : const(wchar)*
{
    INTEROP_SERIALIZABLE_TYPE_W = "System.SerializableAttribute",
    INTEROP_SERIALIZABLE_TYPE   = "System.SerializableAttribute",
}

enum : const(wchar)*
{
    INTEROP_SETWIN32CONTEXTINIDISPATCHATTRIBUTE_TYPE_W = "System.Runtime.InteropServices.SetWin32ContextInIDispatchAttribute",
    INTEROP_SETWIN32CONTEXTINIDISPATCHATTRIBUTE_TYPE   = "System.Runtime.InteropServices.SetWin32ContextInIDispatchAttribute",
}

enum : const(wchar)*
{
    FORWARD_INTEROP_STUB_METHOD_TYPE_W = "System.Runtime.InteropServices.ManagedToNativeComInteropStubAttribute",
    FORWARD_INTEROP_STUB_METHOD_TYPE   = "System.Runtime.InteropServices.ManagedToNativeComInteropStubAttribute",
}

enum : const(wchar)*
{
    FRIEND_ASSEMBLY_TYPE_W = "System.Runtime.CompilerServices.InternalsVisibleToAttribute",
    FRIEND_ASSEMBLY_TYPE   = "System.Runtime.CompilerServices.InternalsVisibleToAttribute",
}

enum : const(wchar)*
{
    FRIEND_ACCESS_ALLOWED_ATTRIBUTE_TYPE_W = "System.Runtime.CompilerServices.FriendAccessAllowedAttribute",
    FRIEND_ACCESS_ALLOWED_ATTRIBUTE_TYPE   = "System.Runtime.CompilerServices.FriendAccessAllowedAttribute",
}

enum : const(wchar)*
{
    SUBJECT_ASSEMBLY_TYPE_W = "System.Runtime.CompilerServices.IgnoresAccessChecksToAttribute",
    SUBJECT_ASSEMBLY_TYPE   = "System.Runtime.CompilerServices.IgnoresAccessChecksToAttribute",
}

enum : const(wchar)*
{
    DISABLED_PRIVATE_REFLECTION_TYPE_W = "System.Runtime.CompilerServices.DisablePrivateReflectionAttribute",
    DISABLED_PRIVATE_REFLECTION_TYPE   = "System.Runtime.CompilerServices.DisablePrivateReflectionAttribute",
}

enum : const(wchar)*
{
    DEFAULTDOMAIN_STA_TYPE_W                = "System.STAThreadAttribute",
    DEFAULTDOMAIN_STA_TYPE                  = "System.STAThreadAttribute",
    DEFAULTDOMAIN_MTA_TYPE_W                = "System.MTAThreadAttribute",
    DEFAULTDOMAIN_MTA_TYPE                  = "System.MTAThreadAttribute",
    DEFAULTDOMAIN_LOADEROPTIMIZATION_TYPE_W = "System.LoaderOptimizationAttribute",
    DEFAULTDOMAIN_LOADEROPTIMIZATION_TYPE   = "System.LoaderOptimizationAttribute",
}

enum : const(wchar)*
{
    NONVERSIONABLE_TYPE_W = "System.Runtime.Versioning.NonVersionableAttribute",
    NONVERSIONABLE_TYPE   = "System.Runtime.Versioning.NonVersionableAttribute",
}

enum : const(wchar)*
{
    COMPILATIONRELAXATIONS_TYPE_W = "System.Runtime.CompilerServices.CompilationRelaxationsAttribute",
    COMPILATIONRELAXATIONS_TYPE   = "System.Runtime.CompilerServices.CompilationRelaxationsAttribute",
}

enum : const(wchar)*
{
    RUNTIMECOMPATIBILITY_TYPE_W = "System.Runtime.CompilerServices.RuntimeCompatibilityAttribute",
    RUNTIMECOMPATIBILITY_TYPE   = "System.Runtime.CompilerServices.RuntimeCompatibilityAttribute",
}

enum : const(wchar)*
{
    DEFAULTDEPENDENCY_TYPE_W = "System.Runtime.CompilerServices.DefaultDependencyAttribute",
    DEFAULTDEPENDENCY_TYPE   = "System.Runtime.CompilerServices.DefaultDependencyAttribute",
}

enum : const(wchar)*
{
    DEPENDENCY_TYPE_W = "System.Runtime.CompilerServices.DependencyAttribute",
    DEPENDENCY_TYPE   = "System.Runtime.CompilerServices.DependencyAttribute",
}

enum : const(wchar)*
{
    TARGET_FRAMEWORK_TYPE_W = "System.Runtime.Versioning.TargetFrameworkAttribute",
    TARGET_FRAMEWORK_TYPE   = "System.Runtime.Versioning.TargetFrameworkAttribute",
}

enum : const(wchar)*
{
    ASSEMBLY_METADATA_TYPE_W = "System.Reflection.AssemblyMetadataAttribute",
    ASSEMBLY_METADATA_TYPE   = "System.Reflection.AssemblyMetadataAttribute",
}

enum : /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)*
{
    CMOD_CALLCONV_NAMESPACE_OLD = "System.Runtime.InteropServices",
    CMOD_CALLCONV_NAMESPACE     = "System.Runtime.CompilerServices",
    CMOD_CALLCONV_NAME_CDECL    = "CallConvCdecl",
    CMOD_CALLCONV_NAME_STDCALL  = "CallConvStdcall",
    CMOD_CALLCONV_NAME_THISCALL = "CallConvThiscall",
    CMOD_CALLCONV_NAME_FASTCALL = "CallConvFastcall",
}

enum GUID LIBID_ComPlusRuntime = GUID("bed7f4ea-1a96-11d2-8f08-00a0c9a6186d");
enum GUID GUID_ExportedFromComPlus = GUID("90883f05-3d28-11d2-8f17-00a0c9a6186d");
enum GUID GUID_ManagedName = GUID("0f21f359-ab84-41e8-9a78-36d110e6d2f9");
enum GUID GUID_Function2Getter = GUID("54fc8f55-38de-4703-9c4e-250351302b1c");
enum GUID CLSID_CorMetaDataDispenserRuntime = GUID("1ec2de53-75cc-11d2-9775-00a0c9b4d50c");
enum GUID GUID_DispIdOverride = GUID("cd2bc5c9-f452-4326-b714-f9c539d4da58");
enum GUID GUID_ForceIEnumerable = GUID("b64784eb-d8d4-4d9b-9acd-0e30806426f7");

enum : GUID
{
    GUID_PropGetCA = GUID("2941ff83-88d8-4f73-b6a9-bdf8712d000d"),
    GUID_PropPutCA = GUID("29533527-3683-4364-abc0-db1add822fa2"),
}

enum : GUID
{
    CLSID_CLR_v1_MetaData = GUID("005023ca-72b1-11d3-9fc4-00c04f79a0a3"),
    CLSID_CLR_v2_MetaData = GUID("efea471a-44fd-4862-9292-0c58d46e1f3a"),
}

enum GUID MetaDataCheckDuplicatesFor = GUID("30fe7be8-d7d9-11d2-9f80-00c04f79a0a3");
enum GUID MetaDataRefToDefCheck = GUID("de3856f8-d7d9-11d2-9f80-00c04f79a0a3");
enum GUID MetaDataNotificationForTokenMovement = GUID("e5d71a4c-d7da-11d2-9f80-00c04f79a0a3");

enum : GUID
{
    MetaDataSetUpdate    = GUID("2eee315c-d7db-11d2-9f80-00c04f79a0a3"),
    MetaDataImportOption = GUID("79700f36-4aac-11d3-84c3-009027868cb1"),
}

enum GUID MetaDataThreadSafetyOptions = GUID("f7559806-f266-42ea-8c63-0adb45e8b234");
enum GUID MetaDataErrorIfEmitOutOfOrder = GUID("1547872d-dc03-11d2-9420-0000f8083460");
enum GUID MetaDataGenerateTCEAdapters = GUID("dcc9de90-4151-11d3-88d6-00902754c43a");
enum GUID MetaDataTypeLibImportNamespace = GUID("f17ff889-5a63-11d3-9ff2-00c04ff7431a");
enum GUID MetaDataLinkerOptions = GUID("47e099b6-ae7c-4797-8317-b48aa645b8f9");
enum GUID MetaDataRuntimeVersion = GUID("47e099b7-ae7c-4797-8317-b48aa645b8f9");
enum GUID MetaDataMergerOptions = GUID("132d3a6e-b35d-464e-951a-42efb9fb6601");
enum GUID MetaDataPreserveLocalRefs = GUID("a55c0354-e91b-468b-8648-7cc31035d533");

enum : int
{
    DESCR_GROUP_METHODDEF  = 0x00000000,
    DESCR_GROUP_METHODIMPL = 0x00000001,
}

enum : GUID
{
    CLSID_Cor                     = GUID("bee00010-ee77-11d0-a015-00c04fbbb884"),
    CLSID_CorMetaDataDispenser    = GUID("e5cb7a31-7512-11d2-89ce-0080c792e5d8"),
    CLSID_CorMetaDataDispenserReg = GUID("435755ff-7397-11d2-9771-00a0c9b4d50c"),
    CLSID_CorMetaDataReg          = GUID("87f3a1f5-7397-11d2-9771-00a0c9b4d50c"),
}

enum : int
{
    SIGN_MASK_ONEBYTE  = 0xffffffc0,
    SIGN_MASK_TWOBYTE  = 0xffffe000,
    SIGN_MASK_FOURBYTE = 0xf0000000,
}

// Structs


@RAIIFree!RoFreeParameterizedTypeExtra
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct ROPARAMIIDHANDLE
{
    void* Value;
}

//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(6))], [])
struct IMAGE_COR_ILMETHOD_SECT_EH_CLAUSE_SMALL
{
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(TryOffset)), FixedArgSig(ElementSig(16)), FixedArgSig(ElementSig(16))], [])*/uint _bitfield1;
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(HandlerLength)), FixedArgSig(ElementSig(24)), FixedArgSig(ElementSig(8))], [])*/uint _bitfield2;
    _Anonymous_e__Union Anonymous;
}

struct IMAGE_COR_ILMETHOD_SECT_SMALL
{
    ubyte Kind;
    ubyte DataSize;
}

struct IMAGE_COR_ILMETHOD_SECT_FAT
{
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(DataSize)), FixedArgSig(ElementSig(8)), FixedArgSig(ElementSig(24))], [])*/uint _bitfield139;
}

struct IMAGE_COR_ILMETHOD_SECT_EH_CLAUSE_FAT
{
    CorExceptionFlag    Flags;
    uint                TryOffset;
    uint                TryLength;
    uint                HandlerOffset;
    uint                HandlerLength;
    _Anonymous_e__Union Anonymous;
}

struct IMAGE_COR_ILMETHOD_SECT_EH_FAT
{
    IMAGE_COR_ILMETHOD_SECT_FAT SectFat;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/IMAGE_COR_ILMETHOD_SECT_EH_CLAUSE_FAT[1] Clauses;
}

//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(1))], [])
struct IMAGE_COR_ILMETHOD_SECT_EH_CLAUSE_SMALL
{
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(TryOffset)), FixedArgSig(ElementSig(16)), FixedArgSig(ElementSig(16))], [])*/int _bitfield1;
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(HandlerLength)), FixedArgSig(ElementSig(24)), FixedArgSig(ElementSig(8))], [])*/uint _bitfield2;
    _Anonymous_e__Union Anonymous;
}

struct IMAGE_COR_ILMETHOD_SECT_EH_SMALL
{
    IMAGE_COR_ILMETHOD_SECT_SMALL SectSmall;
    ushort Reserved;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/IMAGE_COR_ILMETHOD_SECT_EH_CLAUSE_SMALL[1] Clauses;
}

union IMAGE_COR_ILMETHOD_SECT_EH
{
    IMAGE_COR_ILMETHOD_SECT_EH_SMALL Small;
    IMAGE_COR_ILMETHOD_SECT_EH_FAT Fat;
}

struct IMAGE_COR_ILMETHOD_TINY
{
    ubyte Flags_CodeSize;
}

struct IMAGE_COR_ILMETHOD_FAT
{
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(MaxStack)), FixedArgSig(ElementSig(16)), FixedArgSig(ElementSig(16))], [])*/uint _bitfield140;
    uint CodeSize;
    uint LocalVarSigTok;
}

union IMAGE_COR_ILMETHOD
{
    IMAGE_COR_ILMETHOD_TINY Tiny;
    IMAGE_COR_ILMETHOD_FAT Fat;
}

struct IMAGE_COR_VTABLEFIXUP
{
    uint   RVA;
    ushort Count;
    ushort Type;
}

struct COR_FIELD_OFFSET
{
    uint ridOfField;
    uint ulOffset;
}

struct COR_SECATTR
{
    uint         tkCtor;
    const(void)* pCustomAttribute;
    uint         cbCustomAttribute;
}

struct OSINFO
{
    uint dwOSPlatformId;
    uint dwOSMajorVersion;
    uint dwOSMinorVersion;
}

struct ASSEMBLYMETADATA
{
    ushort  usMajorVersion;
    ushort  usMinorVersion;
    ushort  usBuildNumber;
    ushort  usRevisionNumber;
    PWSTR   szLocale;
    uint    cbLocale;
    uint*   rProcessor;
    uint    ulProcessor;
    OSINFO* rOS;
    uint    ulOS;
}

struct CVStruct
{
    short Major;
    short Minor;
    short Sub;
    short Build;
}

union CeeSectionRelocExtra
{
    ushort highAdj;
}

struct COR_NATIVE_LINK
{
align (1):
    ubyte m_linkType;
    ubyte m_flags;
    uint  m_entryPoint;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("RoMetadata.dll")
HRESULT MetaDataGetDispenser(const(GUID)* rclsid, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-ro-typeresolution-l1-1-0.dll")
HRESULT RoGetMetaDataFile(const(HSTRING) name, IMetaDataDispenserEx metaDataDispenser, HSTRING* metaDataFilePath, 
                          IMetaDataImport2* metaDataImport, uint* typeDefToken);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-ro-typeresolution-l1-1-0.dll")
HRESULT RoParseTypeName(HSTRING typeName, uint* partsCount, HSTRING** typeNameParts);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-ro-typeresolution-l1-1-0.dll")
HRESULT RoResolveNamespace(const(HSTRING) name, const(HSTRING) windowsMetaDataDir, 
                           const(uint) packageGraphDirsCount, const(HSTRING)* packageGraphDirs, 
                           uint* metaDataFilePathsCount, HSTRING** metaDataFilePaths, uint* subNamespacesCount, 
                           HSTRING** subNamespaces);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("api-ms-win-ro-typeresolution-l1-1-1.dll")
HRESULT RoIsApiContractPresent(const(PWSTR) name, ushort majorVersion, ushort minorVersion, BOOL* present);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("api-ms-win-ro-typeresolution-l1-1-1.dll")
HRESULT RoIsApiContractMajorVersionPresent(const(PWSTR) name, ushort majorVersion, BOOL* present);

@DllImport("api-ms-win-ro-typeresolution-l1-1-1.dll")
HRESULT RoCreateNonAgilePropertySet(IPropertySet* ppPropertySet);

@DllImport("api-ms-win-ro-typeresolution-l1-1-1.dll")
HRESULT RoCreatePropertySetSerializer(IPropertySetSerializer* ppPropertySetSerializer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-roparameterizediid-l1-1-0.dll")
HRESULT RoGetParameterizedTypeInstanceIID(uint nameElementCount, const(PWSTR)* nameElements, 
                                          const(IRoMetaDataLocator) metaDataLocator, GUID* iid, 
                                          ROPARAMIIDHANDLE* pExtra);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-roparameterizediid-l1-1-0.dll")
void RoFreeParameterizedTypeExtra(ROPARAMIIDHANDLE extra);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-winrt-roparameterizediid-l1-1-0.dll")
PSTR RoParameterizedTypeExtraGetTypeSignature(ROPARAMIIDHANDLE extra);


// Interfaces

@GUID("b81ff171-20f3-11d2-8dcc-00a0c9b09c19")
interface IMetaDataError : IUnknown
{
    HRESULT OnError(HRESULT hrError, uint token);
}

@GUID("06a3ea8b-0225-11d1-bf72-00c04fc31e12")
interface IMapToken : IUnknown
{
    HRESULT Map(uint tkImp, uint tkEmit);
}

@GUID("809c652e-7396-11d2-9771-00a0c9b4d50c")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nn-rometadataapi-imetadatadispenser))], [])
interface IMetaDataDispenser : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatadispenser-definescope))], [])
    HRESULT DefineScope(const(GUID)* rclsid, uint dwCreateFlags, const(GUID)* riid, IUnknown* ppIUnk);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatadispenser-openscope))], [])
    HRESULT OpenScope(const(PWSTR) szScope, uint dwOpenFlags, const(GUID)* riid, IUnknown* ppIUnk);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatadispenser-openscopeonmemory))], [])
    HRESULT OpenScopeOnMemory(const(void)* pData, uint cbData, uint dwOpenFlags, const(GUID)* riid, 
                              IUnknown* ppIUnk);
}

@GUID("ba3fee4c-ecb9-4e41-83b7-183fa41cd859")
interface IMetaDataEmit : IUnknown
{
    HRESULT SetModuleProps(const(PWSTR) szName);
    HRESULT Save(const(PWSTR) szFile, uint dwSaveFlags);
    HRESULT SaveToStream(IStream pIStream, uint dwSaveFlags);
    HRESULT GetSaveSize(CorSaveSize fSave, uint* pdwSaveSize);
    HRESULT DefineTypeDef(const(PWSTR) szTypeDef, uint dwTypeDefFlags, uint tkExtends, uint* rtkImplements, 
                          uint* ptd);
    HRESULT DefineNestedType(const(PWSTR) szTypeDef, uint dwTypeDefFlags, uint tkExtends, uint* rtkImplements, 
                             uint tdEncloser, uint* ptd);
    HRESULT SetHandler(IUnknown pUnk);
    HRESULT DefineMethod(uint td, const(PWSTR) szName, uint dwMethodFlags, ubyte* pvSigBlob, uint cbSigBlob, 
                         uint ulCodeRVA, uint dwImplFlags, uint* pmd);
    HRESULT DefineMethodImpl(uint td, uint tkBody, uint tkDecl);
    HRESULT DefineTypeRefByName(uint tkResolutionScope, const(PWSTR) szName, uint* ptr);
    HRESULT DefineImportType(IMetaDataAssemblyImport pAssemImport, const(void)* pbHashValue, uint cbHashValue, 
                             IMetaDataImport pImport, uint tdImport, IMetaDataAssemblyEmit pAssemEmit, uint* ptr);
    HRESULT DefineMemberRef(uint tkImport, const(PWSTR) szName, ubyte* pvSigBlob, uint cbSigBlob, uint* pmr);
    HRESULT DefineImportMember(IMetaDataAssemblyImport pAssemImport, const(void)* pbHashValue, uint cbHashValue, 
                               IMetaDataImport pImport, uint mbMember, IMetaDataAssemblyEmit pAssemEmit, 
                               uint tkParent, uint* pmr);
    HRESULT DefineEvent(uint td, const(PWSTR) szEvent, uint dwEventFlags, uint tkEventType, uint mdAddOn, 
                        uint mdRemoveOn, uint mdFire, uint* rmdOtherMethods, uint* pmdEvent);
    HRESULT SetClassLayout(uint td, uint dwPackSize, COR_FIELD_OFFSET* rFieldOffsets, uint ulClassSize);
    HRESULT DeleteClassLayout(uint td);
    HRESULT SetFieldMarshal(uint tk, ubyte* pvNativeType, uint cbNativeType);
    HRESULT DeleteFieldMarshal(uint tk);
    HRESULT DefinePermissionSet(uint tk, uint dwAction, const(void)* pvPermission, uint cbPermission, uint* ppm);
    HRESULT SetRVA(uint md, uint ulRVA);
    HRESULT GetTokenFromSig(ubyte* pvSig, uint cbSig, uint* pmsig);
    HRESULT DefineModuleRef(const(PWSTR) szName, uint* pmur);
    HRESULT SetParent(uint mr, uint tk);
    HRESULT GetTokenFromTypeSpec(ubyte* pvSig, uint cbSig, uint* ptypespec);
    HRESULT SaveToMemory(void* pbData, uint cbData);
    HRESULT DefineUserString(const(PWSTR) szString, uint cchString, uint* pstk);
    HRESULT DeleteToken(uint tkObj);
    HRESULT SetMethodProps(uint md, uint dwMethodFlags, uint ulCodeRVA, uint dwImplFlags);
    HRESULT SetTypeDefProps(uint td, uint dwTypeDefFlags, uint tkExtends, uint* rtkImplements);
    HRESULT SetEventProps(uint ev, uint dwEventFlags, uint tkEventType, uint mdAddOn, uint mdRemoveOn, uint mdFire, 
                          uint* rmdOtherMethods);
    HRESULT SetPermissionSetProps(uint tk, uint dwAction, const(void)* pvPermission, uint cbPermission, uint* ppm);
    HRESULT DefinePinvokeMap(uint tk, uint dwMappingFlags, const(PWSTR) szImportName, uint mrImportDLL);
    HRESULT SetPinvokeMap(uint tk, uint dwMappingFlags, const(PWSTR) szImportName, uint mrImportDLL);
    HRESULT DeletePinvokeMap(uint tk);
    HRESULT DefineCustomAttribute(uint tkOwner, uint tkCtor, const(void)* pCustomAttribute, uint cbCustomAttribute, 
                                  uint* pcv);
    HRESULT SetCustomAttributeValue(uint pcv, const(void)* pCustomAttribute, uint cbCustomAttribute);
    HRESULT DefineField(uint td, const(PWSTR) szName, uint dwFieldFlags, ubyte* pvSigBlob, uint cbSigBlob, 
                        uint dwCPlusTypeFlag, const(void)* pValue, uint cchValue, uint* pmd);
    HRESULT DefineProperty(uint td, const(PWSTR) szProperty, uint dwPropFlags, ubyte* pvSig, uint cbSig, 
                           uint dwCPlusTypeFlag, const(void)* pValue, uint cchValue, uint mdSetter, uint mdGetter, 
                           uint* rmdOtherMethods, uint* pmdProp);
    HRESULT DefineParam(uint md, uint ulParamSeq, const(PWSTR) szName, uint dwParamFlags, uint dwCPlusTypeFlag, 
                        const(void)* pValue, uint cchValue, uint* ppd);
    HRESULT SetFieldProps(uint fd, uint dwFieldFlags, uint dwCPlusTypeFlag, const(void)* pValue, uint cchValue);
    HRESULT SetPropertyProps(uint pr, uint dwPropFlags, uint dwCPlusTypeFlag, const(void)* pValue, uint cchValue, 
                             uint mdSetter, uint mdGetter, uint* rmdOtherMethods);
    HRESULT SetParamProps(uint pd, const(PWSTR) szName, uint dwParamFlags, uint dwCPlusTypeFlag, 
                          const(void)* pValue, uint cchValue);
    HRESULT DefineSecurityAttributeSet(uint tkObj, COR_SECATTR* rSecAttrs, uint cSecAttrs, uint* pulErrorAttr);
    HRESULT ApplyEditAndContinue(IUnknown pImport);
    HRESULT TranslateSigWithScope(IMetaDataAssemblyImport pAssemImport, const(void)* pbHashValue, uint cbHashValue, 
                                  IMetaDataImport import_, ubyte* pbSigBlob, uint cbSigBlob, 
                                  IMetaDataAssemblyEmit pAssemEmit, IMetaDataEmit emit, ubyte* pvTranslatedSig, 
                                  uint cbTranslatedSigMax, uint* pcbTranslatedSig);
    HRESULT SetMethodImplFlags(uint md, uint dwImplFlags);
    HRESULT SetFieldRVA(uint fd, uint ulRVA);
    HRESULT Merge(IMetaDataImport pImport, IMapToken pHostMapToken, IUnknown pHandler);
    HRESULT MergeEnd();
}

@GUID("f5dd9950-f693-42e6-830e-7b833e8146a9")
interface IMetaDataEmit2 : IMetaDataEmit
{
    HRESULT DefineMethodSpec(uint tkParent, ubyte* pvSigBlob, uint cbSigBlob, uint* pmi);
    HRESULT GetDeltaSaveSize(CorSaveSize fSave, uint* pdwSaveSize);
    HRESULT SaveDelta(const(PWSTR) szFile, uint dwSaveFlags);
    HRESULT SaveDeltaToStream(IStream pIStream, uint dwSaveFlags);
    HRESULT SaveDeltaToMemory(void* pbData, uint cbData);
    HRESULT DefineGenericParam(uint tk, uint ulParamSeq, uint dwParamFlags, const(PWSTR) szname, uint reserved, 
                               uint* rtkConstraints, uint* pgp);
    HRESULT SetGenericParamProps(uint gp, uint dwParamFlags, const(PWSTR) szName, uint reserved, 
                                 uint* rtkConstraints);
    HRESULT ResetENCLog();
}

@GUID("7dac8207-d3ae-4c75-9b67-92801a497d44")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nn-rometadataapi-imetadataimport))], [])
interface IMetaDataImport : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-closeenum))], [])
    void    CloseEnum(void* hEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-countenum))], [])
    HRESULT CountEnum(void* hEnum, uint* pulCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-resetenum))], [])
    HRESULT ResetEnum(void* hEnum, uint ulPos);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-enumtypedefs))], [])
    HRESULT EnumTypeDefs(void** phEnum, uint* rTypeDefs, uint cMax, uint* pcTypeDefs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-enuminterfaceimpls))], [])
    HRESULT EnumInterfaceImpls(void** phEnum, uint td, uint* rImpls, uint cMax, uint* pcImpls);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-enumtyperefs))], [])
    HRESULT EnumTypeRefs(void** phEnum, uint* rTypeRefs, uint cMax, uint* pcTypeRefs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-findtypedefbyname))], [])
    HRESULT FindTypeDefByName(const(PWSTR) szTypeDef, uint tkEnclosingClass, uint* ptd);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-getscopeprops))], [])
    HRESULT GetScopeProps(PWSTR szName, uint cchName, uint* pchName, GUID* pmvid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-getmodulefromscope))], [])
    HRESULT GetModuleFromScope(uint* pmd);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-gettypedefprops))], [])
    HRESULT GetTypeDefProps(uint td, PWSTR szTypeDef, uint cchTypeDef, uint* pchTypeDef, uint* pdwTypeDefFlags, 
                            uint* ptkExtends);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-getinterfaceimplprops))], [])
    HRESULT GetInterfaceImplProps(uint iiImpl, uint* pClass, uint* ptkIface);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-gettyperefprops))], [])
    HRESULT GetTypeRefProps(uint tr, uint* ptkResolutionScope, PWSTR szName, uint cchName, uint* pchName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-resolvetyperef))], [])
    HRESULT ResolveTypeRef(uint tr, const(GUID)* riid, IUnknown* ppIScope, uint* ptd);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-enummembers))], [])
    HRESULT EnumMembers(void** phEnum, uint cl, uint* rMembers, uint cMax, uint* pcTokens);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-enummemberswithname))], [])
    HRESULT EnumMembersWithName(void** phEnum, uint cl, const(PWSTR) szName, uint* rMembers, uint cMax, 
                                uint* pcTokens);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-enummethods))], [])
    HRESULT EnumMethods(void** phEnum, uint cl, uint* rMethods, uint cMax, uint* pcTokens);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-enummethodswithname))], [])
    HRESULT EnumMethodsWithName(void** phEnum, uint cl, const(PWSTR) szName, uint* rMethods, uint cMax, 
                                uint* pcTokens);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-enumfields))], [])
    HRESULT EnumFields(void** phEnum, uint cl, uint* rFields, uint cMax, uint* pcTokens);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-enumfieldswithname))], [])
    HRESULT EnumFieldsWithName(void** phEnum, uint cl, const(PWSTR) szName, uint* rFields, uint cMax, 
                               uint* pcTokens);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-enumparams))], [])
    HRESULT EnumParams(void** phEnum, uint mb, uint* rParams, uint cMax, uint* pcTokens);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-enummemberrefs))], [])
    HRESULT EnumMemberRefs(void** phEnum, uint tkParent, uint* rMemberRefs, uint cMax, uint* pcTokens);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-enummethodimpls))], [])
    HRESULT EnumMethodImpls(void** phEnum, uint td, uint* rMethodBody, uint* rMethodDecl, uint cMax, 
                            uint* pcTokens);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-enumpermissionsets))], [])
    HRESULT EnumPermissionSets(void** phEnum, uint tk, uint dwActions, uint* rPermission, uint cMax, 
                               uint* pcTokens);
    HRESULT FindMember(uint td, const(PWSTR) szName, ubyte* pvSigBlob, uint cbSigBlob, uint* pmb);
    HRESULT FindMethod(uint td, const(PWSTR) szName, ubyte* pvSigBlob, uint cbSigBlob, uint* pmb);
    HRESULT FindField(uint td, const(PWSTR) szName, ubyte* pvSigBlob, uint cbSigBlob, uint* pmb);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-findmemberref))], [])
    HRESULT FindMemberRef(uint td, const(PWSTR) szName, ubyte* pvSigBlob, uint cbSigBlob, uint* pmr);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-getmethodprops))], [])
    HRESULT GetMethodProps(uint mb, uint* pClass, PWSTR szMethod, uint cchMethod, uint* pchMethod, uint* pdwAttr, 
                           ubyte** ppvSigBlob, uint* pcbSigBlob, uint* pulCodeRVA, uint* pdwImplFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-getmemberrefprops))], [])
    HRESULT GetMemberRefProps(uint mr, uint* ptk, PWSTR szMember, uint cchMember, uint* pchMember, 
                              ubyte** ppvSigBlob, uint* pbSig);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-enumproperties))], [])
    HRESULT EnumProperties(void** phEnum, uint td, uint* rProperties, uint cMax, uint* pcProperties);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-enumevents))], [])
    HRESULT EnumEvents(void** phEnum, uint td, uint* rEvents, uint cMax, uint* pcEvents);
    HRESULT GetEventProps(uint ev, uint* pClass, const(PWSTR) szEvent, uint cchEvent, uint* pchEvent, 
                          uint* pdwEventFlags, uint* ptkEventType, uint* pmdAddOn, uint* pmdRemoveOn, uint* pmdFire, 
                          uint* rmdOtherMethod, uint cMax, uint* pcOtherMethod);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-enummethodsemantics))], [])
    HRESULT EnumMethodSemantics(void** phEnum, uint mb, uint* rEventProp, uint cMax, uint* pcEventProp);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-getmethodsemantics))], [])
    HRESULT GetMethodSemantics(uint mb, uint tkEventProp, uint* pdwSemanticsFlags);
    HRESULT GetClassLayout(uint td, uint* pdwPackSize, COR_FIELD_OFFSET* rFieldOffset, uint cMax, 
                           uint* pcFieldOffset, uint* pulClassSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-getfieldmarshal))], [])
    HRESULT GetFieldMarshal(uint tk, ubyte** ppvNativeType, uint* pcbNativeType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-getrva))], [])
    HRESULT GetRVA(uint tk, uint* pulCodeRVA, uint* pdwImplFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-getpermissionsetprops))], [])
    HRESULT GetPermissionSetProps(uint pm, uint* pdwAction, const(void)** ppvPermission, uint* pcbPermission);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-getsigfromtoken))], [])
    HRESULT GetSigFromToken(uint mdSig, ubyte** ppvSig, uint* pcbSig);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-getmodulerefprops))], [])
    HRESULT GetModuleRefProps(uint mur, PWSTR szName, uint cchName, uint* pchName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-enummodulerefs))], [])
    HRESULT EnumModuleRefs(void** phEnum, uint* rModuleRefs, uint cmax, uint* pcModuleRefs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-gettypespecfromtoken))], [])
    HRESULT GetTypeSpecFromToken(uint typespec, ubyte** ppvSig, uint* pcbSig);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-getnamefromtoken))], [])
    HRESULT GetNameFromToken(uint tk, byte** pszUtf8NamePtr);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-enumunresolvedmethods))], [])
    HRESULT EnumUnresolvedMethods(void** phEnum, uint* rMethods, uint cMax, uint* pcTokens);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-getuserstring))], [])
    HRESULT GetUserString(uint stk, PWSTR szString, uint cchString, uint* pchString);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-getpinvokemap))], [])
    HRESULT GetPinvokeMap(uint tk, uint* pdwMappingFlags, PWSTR szImportName, uint cchImportName, 
                          uint* pchImportName, uint* pmrImportDLL);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-enumsignatures))], [])
    HRESULT EnumSignatures(void** phEnum, uint* rSignatures, uint cmax, uint* pcSignatures);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-enumtypespecs))], [])
    HRESULT EnumTypeSpecs(void** phEnum, uint* rTypeSpecs, uint cmax, uint* pcTypeSpecs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-enumuserstrings))], [])
    HRESULT EnumUserStrings(void** phEnum, uint* rStrings, uint cmax, uint* pcStrings);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-getparamformethodindex))], [])
    HRESULT GetParamForMethodIndex(uint md, uint ulParamSeq, uint* ppd);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-enumcustomattributes))], [])
    HRESULT EnumCustomAttributes(void** phEnum, uint tk, uint tkType, uint* rCustomAttributes, uint cMax, 
                                 uint* pcCustomAttributes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-getcustomattributeprops))], [])
    HRESULT GetCustomAttributeProps(uint cv, uint* ptkObj, uint* ptkType, const(void)** ppBlob, uint* pcbSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-findtyperef))], [])
    HRESULT FindTypeRef(uint tkResolutionScope, const(PWSTR) szName, uint* ptr);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-getmemberprops))], [])
    HRESULT GetMemberProps(uint mb, uint* pClass, PWSTR szMember, uint cchMember, uint* pchMember, uint* pdwAttr, 
                           ubyte** ppvSigBlob, uint* pcbSigBlob, uint* pulCodeRVA, uint* pdwImplFlags, 
                           uint* pdwCPlusTypeFlag, void** ppValue, uint* pcchValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-getfieldprops))], [])
    HRESULT GetFieldProps(uint mb, uint* pClass, PWSTR szField, uint cchField, uint* pchField, uint* pdwAttr, 
                          ubyte** ppvSigBlob, uint* pcbSigBlob, uint* pdwCPlusTypeFlag, void** ppValue, 
                          uint* pcchValue);
    HRESULT GetPropertyProps(uint prop, uint* pClass, const(PWSTR) szProperty, uint cchProperty, uint* pchProperty, 
                             uint* pdwPropFlags, ubyte** ppvSig, uint* pbSig, uint* pdwCPlusTypeFlag, 
                             void** ppDefaultValue, uint* pcchDefaultValue, uint* pmdSetter, uint* pmdGetter, 
                             uint* rmdOtherMethod, uint cMax, uint* pcOtherMethod);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-getparamprops))], [])
    HRESULT GetParamProps(uint tk, uint* pmd, uint* pulSequence, PWSTR szName, uint cchName, uint* pchName, 
                          uint* pdwAttr, uint* pdwCPlusTypeFlag, void** ppValue, uint* pcchValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-getcustomattributebyname))], [])
    HRESULT GetCustomAttributeByName(uint tkObj, const(PWSTR) szName, const(void)** ppData, uint* pcbData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-isvalidtoken))], [])
    BOOL    IsValidToken(uint tk);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-getnestedclassprops))], [])
    HRESULT GetNestedClassProps(uint tdNestedClass, uint* ptdEnclosingClass);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-getnativecallconvfromsig))], [])
    HRESULT GetNativeCallConvFromSig(const(void)* pvSig, uint cbSig, uint* pCallConv);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport-isglobal))], [])
    HRESULT IsGlobal(uint pd, int* pbGlobal);
}

@GUID("fce5efa0-8bba-4f8e-a036-8f2022b08466")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nn-rometadataapi-imetadataimport2))], [])
interface IMetaDataImport2 : IMetaDataImport
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport2-enumgenericparams))], [])
    HRESULT EnumGenericParams(void** phEnum, uint tk, uint* rGenericParams, uint cMax, uint* pcGenericParams);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport2-getgenericparamprops))], [])
    HRESULT GetGenericParamProps(uint gp, uint* pulParamSeq, uint* pdwParamFlags, uint* ptOwner, uint* reserved, 
                                 PWSTR wzname, uint cchName, uint* pchName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport2-getmethodspecprops))], [])
    HRESULT GetMethodSpecProps(uint mi, uint* tkParent, ubyte** ppvSigBlob, uint* pcbSigBlob);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport2-enumgenericparamconstraints))], [])
    HRESULT EnumGenericParamConstraints(void** phEnum, uint tk, uint* rGenericParamConstraints, uint cMax, 
                                        uint* pcGenericParamConstraints);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport2-getgenericparamconstraintprops))], [])
    HRESULT GetGenericParamConstraintProps(uint gpc, uint* ptGenericParam, uint* ptkConstraintType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport2-getpekind))], [])
    HRESULT GetPEKind(uint* pdwPEKind, uint* pdwMAchine);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport2-getversionstring))], [])
    HRESULT GetVersionString(PWSTR pwzBuf, uint ccBufSize, uint* pccBufSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataimport2-enummethodspecs))], [])
    HRESULT EnumMethodSpecs(void** phEnum, uint tk, uint* rMethodSpecs, uint cMax, uint* pcMethodSpecs);
}

@GUID("d0e80dd1-12d4-11d3-b39d-00c04ff81795")
interface IMetaDataFilter : IUnknown
{
    HRESULT UnmarkAll();
    HRESULT MarkToken(uint tk);
    HRESULT IsTokenMarked(uint tk, BOOL* pIsMarked);
}

@GUID("d0e80dd3-12d4-11d3-b39d-00c04ff81795")
interface IHostFilter : IUnknown
{
    HRESULT MarkToken(uint tk);
}

@GUID("211ef15b-5317-4438-b196-dec87b887693")
interface IMetaDataAssemblyEmit : IUnknown
{
    HRESULT DefineAssembly(const(void)* pbPublicKey, uint cbPublicKey, uint ulHashAlgId, const(PWSTR) szName, 
                           const(ASSEMBLYMETADATA)* pMetaData, uint dwAssemblyFlags, uint* pma);
    HRESULT DefineAssemblyRef(const(void)* pbPublicKeyOrToken, uint cbPublicKeyOrToken, const(PWSTR) szName, 
                              const(ASSEMBLYMETADATA)* pMetaData, const(void)* pbHashValue, uint cbHashValue, 
                              uint dwAssemblyRefFlags, uint* pmdar);
    HRESULT DefineFile(const(PWSTR) szName, const(void)* pbHashValue, uint cbHashValue, uint dwFileFlags, 
                       uint* pmdf);
    HRESULT DefineExportedType(const(PWSTR) szName, uint tkImplementation, uint tkTypeDef, 
                               uint dwExportedTypeFlags, uint* pmdct);
    HRESULT DefineManifestResource(const(PWSTR) szName, uint tkImplementation, uint dwOffset, uint dwResourceFlags, 
                                   uint* pmdmr);
    HRESULT SetAssemblyProps(uint pma, const(void)* pbPublicKey, uint cbPublicKey, uint ulHashAlgId, 
                             const(PWSTR) szName, const(ASSEMBLYMETADATA)* pMetaData, uint dwAssemblyFlags);
    HRESULT SetAssemblyRefProps(uint ar, const(void)* pbPublicKeyOrToken, uint cbPublicKeyOrToken, 
                                const(PWSTR) szName, const(ASSEMBLYMETADATA)* pMetaData, const(void)* pbHashValue, 
                                uint cbHashValue, uint dwAssemblyRefFlags);
    HRESULT SetFileProps(uint file, const(void)* pbHashValue, uint cbHashValue, uint dwFileFlags);
    HRESULT SetExportedTypeProps(uint ct, uint tkImplementation, uint tkTypeDef, uint dwExportedTypeFlags);
    HRESULT SetManifestResourceProps(uint mr, uint tkImplementation, uint dwOffset, uint dwResourceFlags);
}

@GUID("ee62470b-e94b-424e-9b7c-2f00c9249f93")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nn-rometadataapi-imetadataassemblyimport))], [])
interface IMetaDataAssemblyImport : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataassemblyimport-getassemblyprops))], [])
    HRESULT GetAssemblyProps(uint mda, const(void)** ppbPublicKey, uint* pcbPublicKey, uint* pulHashAlgId, 
                             PWSTR szName, uint cchName, uint* pchName, ASSEMBLYMETADATA* pMetaData, 
                             uint* pdwAssemblyFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataassemblyimport-getassemblyrefprops))], [])
    HRESULT GetAssemblyRefProps(uint mdar, const(void)** ppbPublicKeyOrToken, uint* pcbPublicKeyOrToken, 
                                PWSTR szName, uint cchName, uint* pchName, ASSEMBLYMETADATA* pMetaData, 
                                const(void)** ppbHashValue, uint* pcbHashValue, uint* pdwAssemblyRefFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataassemblyimport-getfileprops))], [])
    HRESULT GetFileProps(uint mdf, PWSTR szName, uint cchName, uint* pchName, const(void)** ppbHashValue, 
                         uint* pcbHashValue, uint* pdwFileFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataassemblyimport-getexportedtypeprops))], [])
    HRESULT GetExportedTypeProps(uint mdct, PWSTR szName, uint cchName, uint* pchName, uint* ptkImplementation, 
                                 uint* ptkTypeDef, uint* pdwExportedTypeFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataassemblyimport-getmanifestresourceprops))], [])
    HRESULT GetManifestResourceProps(uint mdmr, PWSTR szName, uint cchName, uint* pchName, uint* ptkImplementation, 
                                     uint* pdwOffset, uint* pdwResourceFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataassemblyimport-enumassemblyrefs))], [])
    HRESULT EnumAssemblyRefs(void** phEnum, uint* rAssemblyRefs, uint cMax, uint* pcTokens);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataassemblyimport-enumfiles))], [])
    HRESULT EnumFiles(void** phEnum, uint* rFiles, uint cMax, uint* pcTokens);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataassemblyimport-enumexportedtypes))], [])
    HRESULT EnumExportedTypes(void** phEnum, uint* rExportedTypes, uint cMax, uint* pcTokens);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataassemblyimport-enummanifestresources))], [])
    HRESULT EnumManifestResources(void** phEnum, uint* rManifestResources, uint cMax, uint* pcTokens);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataassemblyimport-getassemblyfromscope))], [])
    HRESULT GetAssemblyFromScope(uint* ptkAssembly);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataassemblyimport-findexportedtypebyname))], [])
    HRESULT FindExportedTypeByName(const(PWSTR) szName, uint mdtExportedType, uint* ptkExportedType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataassemblyimport-findmanifestresourcebyname))], [])
    HRESULT FindManifestResourceByName(const(PWSTR) szName, uint* ptkManifestResource);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataassemblyimport-closeenum))], [])
    void    CloseEnum(void* hEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadataassemblyimport-findassembliesbyname))], [])
    HRESULT FindAssembliesByName(const(PWSTR) szAppBase, const(PWSTR) szPrivateBin, const(PWSTR) szAssemblyName, 
                                 IUnknown* ppIUnk, uint cMax, uint* pcAssemblies);
}

@GUID("4709c9c6-81ff-11d3-9fc7-00c04f79a0a3")
interface IMetaDataValidate : IUnknown
{
    HRESULT ValidatorInit(uint dwModuleType, IUnknown pUnk);
    HRESULT ValidateMetaData();
}

@GUID("31bcfce2-dafb-11d2-9f81-00c04f79a0a3")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nn-rometadataapi-imetadatadispenserex))], [])
interface IMetaDataDispenserEx : IMetaDataDispenser
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatadispenserex-setoption))], [])
    HRESULT SetOption(const(GUID)* optionid, const(VARIANT)* value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatadispenserex-getoption))], [])
    HRESULT GetOption(const(GUID)* optionid, VARIANT* pvalue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatadispenserex-openscopeonitypeinfo))], [])
    HRESULT OpenScopeOnITypeInfo(ITypeInfo pITI, uint dwOpenFlags, const(GUID)* riid, IUnknown* ppIUnk);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatadispenserex-getcorsystemdirectory))], [])
    HRESULT GetCORSystemDirectory(PWSTR szBuffer, uint cchBuffer, uint* pchBuffer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatadispenserex-findassembly))], [])
    HRESULT FindAssembly(const(PWSTR) szAppBase, const(PWSTR) szPrivateBin, const(PWSTR) szGlobalBin, 
                         const(PWSTR) szAssemblyName, const(PWSTR) szName, uint cchName, uint* pcName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatadispenserex-findassemblymodule))], [])
    HRESULT FindAssemblyModule(const(PWSTR) szAppBase, const(PWSTR) szPrivateBin, const(PWSTR) szGlobalBin, 
                               const(PWSTR) szAssemblyName, const(PWSTR) szModuleName, PWSTR szName, uint cchName, 
                               uint* pcName);
}

@GUID("7ed1bdff-8e36-11d2-9c56-00a0c9b7cc45")
interface ICeeGen : IUnknown
{
    HRESULT EmitString(PWSTR lpString, uint* RVA);
    HRESULT GetString(uint RVA, PWSTR* lpString);
    HRESULT AllocateMethodBuffer(uint cchBuffer, ubyte** lpBuffer, uint* RVA);
    HRESULT GetMethodBuffer(uint RVA, ubyte** lpBuffer);
    HRESULT GetIMapTokenIface(IUnknown* pIMapToken);
    HRESULT GenerateCeeFile();
    HRESULT GetIlSection(void** section);
    HRESULT GetStringSection(void** section);
    HRESULT AddSectionReloc(void* section, uint offset, void* relativeTo, CeeSectionRelocType relocType);
    HRESULT GetSectionCreate(const(PSTR) name, uint flags, void** section);
    HRESULT GetSectionDataLen(void* section, uint* dataLen);
    HRESULT GetSectionBlock(void* section, uint len, uint align_, void** ppBytes);
    HRESULT TruncateSection(void* section, uint len);
    HRESULT GenerateCeeMemoryImage(void** ppImage);
    HRESULT ComputePointer(void* section, uint RVA, ubyte** lpBuffer);
}

@GUID("d8f579ab-402d-4b8e-82d9-5d63b1065c68")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nn-rometadataapi-imetadatatables))], [])
interface IMetaDataTables : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatatables-getstringheapsize))], [])
    HRESULT GetStringHeapSize(uint* pcbStrings);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatatables-getblobheapsize))], [])
    HRESULT GetBlobHeapSize(uint* pcbBlobs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatatables-getguidheapsize))], [])
    HRESULT GetGuidHeapSize(uint* pcbGuids);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatatables-getuserstringheapsize))], [])
    HRESULT GetUserStringHeapSize(uint* pcbBlobs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatatables-getnumtables))], [])
    HRESULT GetNumTables(uint* pcTables);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatatables-gettableindex))], [])
    HRESULT GetTableIndex(uint token, uint* pixTbl);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatatables-gettableinfo))], [])
    HRESULT GetTableInfo(uint ixTbl, uint* pcbRow, uint* pcRows, uint* pcCols, uint* piKey, const(byte)** ppName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatatables-getcolumninfo))], [])
    HRESULT GetColumnInfo(uint ixTbl, uint ixCol, uint* poCol, uint* pcbCol, uint* pType, const(byte)** ppName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatatables-getcodedtokeninfo))], [])
    HRESULT GetCodedTokenInfo(uint ixCdTkn, uint* pcTokens, uint** ppTokens, const(byte)** ppName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatatables-getrow))], [])
    HRESULT GetRow(uint ixTbl, uint rid, void** ppRow);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatatables-getcolumn))], [])
    HRESULT GetColumn(uint ixTbl, uint ixCol, uint rid, uint* pVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatatables-getstring))], [])
    HRESULT GetString(uint ixString, const(byte)** ppString);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatatables-getblob))], [])
    HRESULT GetBlob(uint ixBlob, uint* pcbData, const(void)** ppData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatatables-getguid))], [])
    HRESULT GetGuid(uint ixGuid, const(GUID)** ppGUID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatatables-getuserstring))], [])
    HRESULT GetUserString(uint ixUserString, uint* pcbData, const(void)** ppData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatatables-getnextstring))], [])
    HRESULT GetNextString(uint ixString, uint* pNext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatatables-getnextblob))], [])
    HRESULT GetNextBlob(uint ixBlob, uint* pNext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatatables-getnextguid))], [])
    HRESULT GetNextGuid(uint ixGuid, uint* pNext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatatables-getnextuserstring))], [])
    HRESULT GetNextUserString(uint ixUserString, uint* pNext);
}

@GUID("badb5f70-58da-43a9-a1c6-d74819f19b15")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nn-rometadataapi-imetadatatables2))], [])
interface IMetaDataTables2 : IMetaDataTables
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatatables2-getmetadatastorage))], [])
    HRESULT GetMetaDataStorage(const(void)** ppvMd, uint* pcbMd);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/rometadataapi/nf-rometadataapi-imetadatatables2-getmetadatastreaminfo))], [])
    HRESULT GetMetaDataStreamInfo(uint ix, const(byte)** ppchName, const(void)** ppv, uint* pcb);
}

@GUID("7998ea64-7f95-48b8-86fc-17caf48bf5cb")
interface IMetaDataInfo : IUnknown
{
    HRESULT GetFileMapping(const(void)** ppvData, ulong* pcbData, uint* pdwMappingType);
}

@GUID("969ea0c5-964e-411b-a807-b0f3c2dfcbd4")
interface IMetaDataWinMDImport : IUnknown
{
    HRESULT GetUntransformedTypeRefProps(uint tr, uint* ptkResolutionScope, PWSTR szName, uint cchName, 
                                         uint* pchName);
}

//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/roparameterizediid/ns-roparameterizediid-irosimplemetadatabuilder))], [])
interface IRoSimpleMetaDataBuilder
{
    HRESULT SetWinRtInterface(GUID iid);
    HRESULT SetDelegate(GUID iid);
    HRESULT SetInterfaceGroupSimpleDefault(const(PWSTR) name, const(PWSTR) defaultInterfaceName, 
                                           const(GUID)* defaultInterfaceIID);
    HRESULT SetInterfaceGroupParameterizedDefault(const(PWSTR) name, uint elementCount, 
                                                  const(PWSTR)* defaultInterfaceNameElements);
    HRESULT SetRuntimeClassSimpleDefault(const(PWSTR) name, const(PWSTR) defaultInterfaceName, 
                                         const(GUID)* defaultInterfaceIID);
    HRESULT SetRuntimeClassParameterizedDefault(const(PWSTR) name, uint elementCount, 
                                                const(PWSTR)* defaultInterfaceNameElements);
    HRESULT SetStruct(const(PWSTR) name, uint numFields, const(PWSTR)* fieldTypeNames);
    HRESULT SetEnum(const(PWSTR) name, const(PWSTR) baseType);
    HRESULT SetParameterizedInterface(GUID piid, uint numArgs);
    HRESULT SetParameterizedDelegate(GUID piid, uint numArgs);
}

//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/roparameterizediid/ns-roparameterizediid-irometadatalocator))], [])
interface IRoMetaDataLocator
{
    HRESULT Locate(const(PWSTR) nameElement, IRoSimpleMetaDataBuilder metaDataDestination);
}


// GUIDs


const GUID IID_ICeeGen                 = GUIDOF!ICeeGen;
const GUID IID_IHostFilter             = GUIDOF!IHostFilter;
const GUID IID_IMapToken               = GUIDOF!IMapToken;
const GUID IID_IMetaDataAssemblyEmit   = GUIDOF!IMetaDataAssemblyEmit;
const GUID IID_IMetaDataAssemblyImport = GUIDOF!IMetaDataAssemblyImport;
const GUID IID_IMetaDataDispenser      = GUIDOF!IMetaDataDispenser;
const GUID IID_IMetaDataDispenserEx    = GUIDOF!IMetaDataDispenserEx;
const GUID IID_IMetaDataEmit           = GUIDOF!IMetaDataEmit;
const GUID IID_IMetaDataEmit2          = GUIDOF!IMetaDataEmit2;
const GUID IID_IMetaDataError          = GUIDOF!IMetaDataError;
const GUID IID_IMetaDataFilter         = GUIDOF!IMetaDataFilter;
const GUID IID_IMetaDataImport         = GUIDOF!IMetaDataImport;
const GUID IID_IMetaDataImport2        = GUIDOF!IMetaDataImport2;
const GUID IID_IMetaDataInfo           = GUIDOF!IMetaDataInfo;
const GUID IID_IMetaDataTables         = GUIDOF!IMetaDataTables;
const GUID IID_IMetaDataTables2        = GUIDOF!IMetaDataTables2;
const GUID IID_IMetaDataValidate       = GUIDOF!IMetaDataValidate;
const GUID IID_IMetaDataWinMDImport    = GUIDOF!IMetaDataWinMDImport;
