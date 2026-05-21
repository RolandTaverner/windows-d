module climetadata.mdtable.value;

public import climetadata.mdtable.valuekind;

public struct Value(T, ValueKind K)
{
    public alias Kind = K;
    public alias Type = T;

    public this(in T value)
    {
        this.value = value;
    }

    public ValueKind kind() const
    {
        return Kind;
    }

    alias value this;

    const T value;
}

unittest
{
    Value!(uint, ValueKind.Integral) v = 1;

    assert(v == 1);
    assert(v.value == 1);
}
