module attributes;

public import attributeprops;


public struct TypeAttributes
{
    @disable this();
    this(uint bits)
    {
        _bits = bits;
    }

    public TypeVisibility visibility() const
    {
        return cast(TypeVisibility)(_bits & 0x7);
    }

    public TypeLayout layout() const
    {
        return cast(TypeLayout)(_bits & 0x18);
    }

    public TypeSemantics semantics() const
    {
        return cast(TypeSemantics)(_bits & 0x60);
    }

    public bool isAbstract() const
    {
        return (_bits & 0x80) == 0x80;
    }

    public bool isSealed() const
    {
        return (_bits & 0x100) == 0x100;
    }

    public bool hasSpecialName() const
    {
        return (_bits & 0x400) == 0x400;
    }

    public bool isImport() const
    {
        return (_bits & 0x1000) == 0x1000;
    }

    public bool isSerializable() const
    {
        return (_bits & 0x2000) == 0x2000;
    }

    public StringFormat format() const
    {
        return cast(StringFormat)(_bits & 0x30000);
    }

    public bool beforeFieldInit() const
    {
        return (_bits & 0x100000) == 0x100000;
    }

    public bool hasRuntimeSpecialName() const
    {
        return (_bits & 0x800) == 0x800;
    }

    public bool hasSecurity() const
    {
        return (_bits & 0x40000) == 0x40000;
    }

    public bool isTypeForwarder() const
    {
        return (_bits & 0x200000) == 0x200000;
    }

    public bool isWindowsRuntime() const
    {
        return (_bits & 0x4000) == 0x4000;
    }

private:
    private uint _bits;
}


public struct FieldAttributes
{
    @disable this();
    this(ushort bits)
    {
        _bits = bits;
    }

    public MemberAccess access() const
    {
        return cast(MemberAccess)(_bits & 0x7);
    }

    public bool isStatic() const
    {
        return (_bits & 0x10) == 0x10;
    }

    public bool isInitOnly() const
    {
        return (_bits & 0x20) == 0x20;
    }

    public bool isLiteral() const
    {
        return (_bits & 0x40) == 0x40;
    }

    public bool dontSerialize() const
    {
        return (_bits & 0x80) == 0x80;
    }

    public bool hasSpecialName() const
    {
        return (_bits & 0x200) == 0x200;
    }

    public bool pInvokeImplemented() const
    {
        return (_bits & 0x2000) == 0x2000;
    }

    public bool hasRuntimeSpecialName() const
    {
        return (_bits & 0x400) == 0x400;
    }

    public bool hasFieldMarshal() const
    {
        return (_bits & 0x1000) == 0x1000;
    }

    public bool hasDefault() const
    {
        return (_bits & 0x8000) == 0x8000;
    }

    public bool hasFieldRVA() const
    {
        return (_bits & 0x100) == 0x100;
    }


private:
    ushort _bits;
}


public struct MethodAttributes
{
    @disable this();
    this(ushort impl, ushort attr)
    {
        _impl = impl;
        _attr = attr;
    }

    public CodeType codeType() const
    {
        return cast(CodeType)(_impl & 0x03);
    }

    public bool isManaged() const
    {
        return (_impl & 0x04) != 0x04;
    }

    public bool isForwardReference() const
    {
        return (_impl & 0x10) == 0x10;
    }

    public bool preserveSignature() const
    {
        return (_impl & 0x80) == 0x80;
    }

    public bool isInternalCall() const
    {
        return (_impl & 0x1000) == 0x1000;
    }

    public bool isSynchronized() const
    {
        return (_impl & 0x20) == 0x20;
    }

    public bool dontInline() const
    {
        return (_impl & 0x8) == 0x8;
    }

    public MemberAccess access() const
    {
        return cast(MemberAccess)(_attr & 0x7);
    } 

    public bool isStatic() const
    {
        return (_attr & 0x10) == 0x10;
    }

    public bool isFinal() const
    {
        return (_attr & 0x20) == 0x20;
    }

    public bool isVirtual() const
    {
        return (_attr & 0x40) == 0x40;
    }

    public bool hideBySig() const
    {
        return (_attr & 0x80) == 0x80;
    }

    public bool reuseSlot() const
    {
        return (_attr & 0x100) != 0x100;
    }

    public bool overrideAccess() const
    {
        return (_attr & 0x200) == 0x200;
    }

    public bool isAbstract() const
    {
        return (_attr & 0x400) == 0x400;
    }

    public bool hasSpecialName() const
    {
        return (_attr & 0x800) == 0x800;
    }

    public bool pInvoke() const
    {
        return (_attr & 0x2000) == 0x2000;
    }

    public bool hasRuntimeSpecialName() const
    {
        return (_attr & 0x1000) == 0x1000;
    }

    public bool hasSecurity() const
    {
        return (_attr & 0x4000) == 0x4000;
    }

    public bool requiresSecurity() const
    {
        return (_attr & 0x8000) == 0x8000;
    }
    private ushort _impl;
    private ushort _attr;
}


public struct ParamAttributes
{
    @disable this();
    this(ushort bits)
    {
        _bits = bits;
    }

    public MemberAccess access() const
    {
        return cast(MemberAccess)(_bits & 0x7);
    }

    public bool isIn() const
    {
        return (_bits & 0x01) == 0x01;
    }

    public bool isOut() const
    {
        return (_bits & 0x02) == 0x02;
    }

    public bool isOptional() const
    {
        return (_bits & 0x10) == 0x10;
    }

    public bool hasDefault() const
    {
        return (_bits & 0x1000) == 0x1000;
    }

    public bool hasFieldMarshal() const
    {
        return (_bits & 0x2000) == 0x2000;
    }
private:
    ushort _bits;
}


public struct EventAttributes
{
    @disable this();
    this(ushort bits)
    {
        _bits = bits;
    }

    public bool hasSpecialName() const
    {
        return (_bits & 0x0200) == 0x0200;
    }

    public bool hasRuntimeSpecialName() const
    {
        return (_bits & 0x0400) == 0x0400;
    }

private:
    ushort _bits;
}


public struct PropertyAttributes
{
    @disable this();
    this(ushort bits)
    {
        _bits = bits;
    }

    public bool hasSpecialName() const
    {
        return (_bits & 0x0200) == 0x0200;
    }

    public bool hasRuntimeSpecialName() const
    {
        return (_bits & 0x0400) == 0x0400;
    }

    public bool hasDefault() const
    {
        return (_bits & 0x1000) == 0x1000;
    }

private:
    ushort _bits;
}


public struct SemanticsAttributes
{
    @disable this();
    this(ushort bits)
    {
        _bits = bits;
    }

    public bool isSetter() const
    {
        return (_bits & 0x0001) == 0x0001;
    }

    public bool isGetter() const
    {
        return (_bits & 0x0002) == 0x0002;
    }

    public bool isOther() const
    {
        return (_bits & 0x0004) == 0x0004;
    }

    public bool isAddOn() const
    {
        return (_bits & 0x0008) == 0x0008;
    }

    public bool isRemoveOn() const
    {
        return (_bits & 0x0010) == 0x0010;
    }

    public bool isFire() const
    {
        return (_bits & 0x0020) == 0x0020;
    }

private:
    ushort _bits;
}


public struct PInvokeAttributes
{
    @disable this();
    this(ushort bits)
    {
        _bits = bits;
    }

    public PInvokeStringFormat stringFormat() const
    {
        return cast(PInvokeStringFormat)(_bits & 0x6);
    }

    public BestFit bestFit() const
    {
        return cast(BestFit)(_bits & 0x30);
    }

    public ThrowOnInvalidChar throwOnInvalidChar() const
    {
        return cast(ThrowOnInvalidChar)(_bits & 0x3000);
    }

    public CallConv callConvention() const
    {
        return cast(CallConv)(_bits & 0x0700);
    }

    public bool dontMangle() const
    {
        return (_bits & 0x0001) == 0x0001;
    }

    public bool supportsLastError() const
    {
        return (_bits & 0x0040) == 0x0040;
    }
private:
    ushort _bits;
}


public struct AssemblyAttributes
{
    @disable this();
    this(uint bits)
    {
        _bits = bits;
    }

    public AssemblyArch architecture() const
    {
        return cast(AssemblyArch)(_bits & 0x70);
    }

    public bool hasPublicKey() const
    {
        return (_bits & 0x0001) == 0x0001;
    }

    public bool disableTracking() const
    {
        return (_bits & 0x8000) == 0x8000;
    }

    public bool disapleOptimization() const
    {
        return (_bits & 0x4000) == 0x4000;
    }

    public bool isRetargetable() const
    {
        return (_bits & 0x100) == 0x100;
    }

    public bool windowsRuntime() const
    {
        return (_bits & 0x200) == 0x200;
    }

private:
    uint _bits;
}


public struct GenericAttributes
{
    @disable this();
    this(ushort bits)
    {
        _bits = bits;
    }

    public Variance variance() const
    {
        return cast(Variance)(_bits & 0x03);
    }

    public Constraint constraint() const
    {
        return cast(Constraint)(_bits & 0x1c);
    }    

private:
    ushort _bits;
}
