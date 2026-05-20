module climetadata.mdtable.value;

public import climetadata.mdtable.valuekind;

public struct Value(T, ValueKind K)
{
    public this(in T value)
    {
        this.value = value;
    }

    alias value this;

    alias Kind = K;
    alias Type = T;

    const T value;
}

unittest
{
    Value!(uint, ValueKind.Integral) v = 1;

    assert(v == 1);
    assert(v.value == 1);
}