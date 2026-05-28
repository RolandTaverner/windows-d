module climetadata.mdcollection.attributeprops;

// sig
enum UnmanagedType
{
    bool_ = 2,
    i1 = 3,
    u1 = 4,
    i2 = 5,
    u2 = 6,
    I4 = 7,
    u4 = 8,
    i8 = 9,
    u8 = 10,
    r4 = 11,
    r8 = 12,
    currency = 15,
    bStr = 19,
    lpStr = 20,
    lpwStr = 21,
    lptStr = 22,
    byValTStr = 23,
    iUnknown = 25,
    iDispatch = 26,
    struct_ = 27,
    interface_ = 28,
    safeArray = 29,
    byValArray = 30,
    sysInt = 31,
    sysUInt = 32,
    vbByRefStr = 34,
    ansiBStr = 35,
    tBStr = 36,
    variantBool = 37,
    functionPtr = 38,
    asAny = 40,
    lpArray = 42,
    lpStruct = 43,
    customMarshaler = 44,
    error = 45,
    iInspectable = 46,
    hString = 47,
    lpUTF8Str = 48,
}

enum MemberAccess : ushort
{
    CompilerControlled = 0x0000,
    Private = 0x0001,
    FamAndAssem = 0x0002,
    Assembly = 0x0003,
    Family = 0x0004,
    FamOrAssem = 0x0005,
    Public = 0x0006,
}

enum TypeVisibility
{
    NotPublic = 0x00000000,
    Public = 0x00000001,
    NestedPublic = 0x00000002,
    NestedPrivate = 0x00000003,
    NestedFamily = 0x00000004,
    NestedAssembly = 0x00000005,
    NestedFamANDAssem = 0x00000006,
    NestedFamORAssem = 0x00000007,
}

enum ManifestVisibility : uint
{
    none = 0x0000,
    public_ = 0x0001,
    private_ = 0x0002,
}

enum TypeLayout
{
    autoLayout = 0x00000000,
    sequentialLayout = 0x00000008,
    explicitLayout = 0x00000010,
}

enum TypeSemantics
{
    class_ = 0x00000000,
    interface_ = 0x00000020,
}

enum StringFormat
{
    AnsiClass = 0x00000000,
    UnicodeClass = 0x00010000,
    AutoClass = 0x00020000,
    CustomFormatClass = 0x00030000,
    CustomFormatMask = 0x00C00000,
}

enum PInvokeStringFormat : ushort
{
    notSpecified = 0x0000,
    ansi = 0x0002,
    unicode = 0x0004,
    auto_ = 0x0006,
}

enum BestFit : ushort
{
    useAssembly = 0x0000,
    enabled = 0x0010,
    disabled = 0x0020,
}

enum ThrowOnInvalidChar : ushort
{
    useAssembly = 0x0000,
    enabled = 0x1000,
    disabled = 0x2000,
}

enum CallConv : ushort
{
    winapi = 0x0100,
    cdecl = 0x0200,
    stdcall = 0x0300,
    thiscall = 0x0400,
    fastcall = 0x0500,
}

enum CodeType : ushort
{
    IL = 0x0000,
    Native = 0x0001,
    OPTIL = 0x0002,
    Runtime = 0x0003,
}

enum Managed : ushort
{
    Unmanaged = 0x0004,
    Managed = 0x0000,
}

enum TableLayout : ushort
{
    ReuseSlot = 0x0000,
    NewSlot = 0x0100,
}

enum GenericParamVariance : ushort
{
    None = 0x0000,
    Covariant = 0x0001,
    ContraVariant = 0x0002,
}

enum GenericParamSpecialConstraint : ushort
{
    ReferenceTypeConstraint = 0x0004,
    NotNullableValueTypeConstraint = 0x0008,
    DefaultConstructorConstraint = 0x0010,
}

enum ConstantType : ushort
{
    boolean = 0x02,
    char_ = 0x03,
    int8 = 0x04,
    uint8 = 0x05,
    int16 = 0x06,
    uint16 = 0x07,
    int32 = 0x08,
    uint32 = 0x09,
    int64 = 0x0a,
    uint64 = 0x0b,
    float32 = 0x0c,
    float64 = 0x0d,
    string = 0x0e,
    class_ = 0x12
}

enum AssemblyHashAlgorithm
{
    None = 0x0000,
    Reserved_MD5 = 0x8003,
    SHA1 = 0x8004,
}

enum AssemblyArch : uint
{
    none = 0x0000,
    msil = 0x0010,
    x86 = 0x0020,
    ia64 = 0x0030,
    amd64 = 0x0040,
}

enum SecurityAction : ushort
{
    demand = 0x0002,
    assert_ = 0x0003,
    deny = 0x0004,
    permitOnly = 0x0005,
    linkDemand = 0x0006,
    inheritanceDemand = 0x0007,
    requestMinimum = 0x0008,
    requestOptional = 0x0009,
    requestRefuse = 0x0010,
}

struct AssemblyVersion
{
    ushort majorVersion;
    ushort minorVersion;
    ushort buildNumber;
    ushort revisionNumber;
}

enum Variance : ushort
{
    nonVariant = 0x0000,
    coVariant = 0x0001,
    contraVariant = 0x0002,
}

enum Constraint : ushort
{
    special = 0x0000,
    reference = 0x0004,
    notNullable = 0x0008,
    defaultConstructor = 0x0010
}

// sig
enum ElementType : ubyte
{
    end = 0x00,
    void_ = 0x01,
    boolean = 0x02,
    char_ = 0x03,
    i1 = 0x04,
    u1 = 0x05,
    i2 = 0x06,
    u2 = 0x07,
    i4 = 0x08,
    u4 = 0x09,
    i8 = 0x0a,
    u8 = 0x0b,
    r4 = 0x0c,
    r8 = 0x0d,
    string = 0x0e,
    ptr = 0x0f,
    byRef = 0x10,
    valueType = 0x11,
    class_ = 0x12,
    var = 0x13,
    array = 0x14,
    genericInst = 0x15,
    typedByRef = 0x16,
    i = 0x18,
    u = 0x19,
    fnPtr = 0x1b,
    object = 0x1c,
    szArray = 0x1d,
    mVar = 0x1e,
    cModReqd = 0x1f,
    cModOpt = 0x20,
    internal = 0x21,
    modifier = 0x40,
    sentinel = 0x41,
    pinned = 0x45,
    type = 0x50,
    taggedObject = 0x51,
    field = 0x53,
    property = 0x54,
    enum_ = 0x55,
}

enum CallingConvention : ubyte
{
    default_ = 0x00,
    varArg = 0x05,
    field = 0x06,
    localSig = 0x07,
    property = 0x08,
    genericInst = 0x10,
    mask = 0x0f,
    hasThis = 0x20,
    explicitThis = 0x40,
    generic = 0x10,
}

enum NativeType : ubyte
{
    boolean = 0x02,
    i1 = 0x03,
    u1 = 0x04,
    i2 = 0x05,
    u2 = 0x06,
    i4 = 0x07,
    u4 = 0x08,
    i8 = 0x09,
    u8 = 0x0a,
    r4 = 0x0b,
    r8 = 0x0c,
    lpstr = 0x14,
    lpwstr = 0x15,
    i = 0x1f,
    u = 0x20,
    func = 0x26,
    array = 0x2a,
    max_ = 0xff,
}
