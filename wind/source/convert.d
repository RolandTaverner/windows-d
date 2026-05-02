module convert;


string asString(const(ubyte)[] mem, size_t offset = 0)
{
    size_t zero = 0;
    auto p = mem.ptr + offset;
    while (p[zero])
        ++zero;
    return (cast(immutable(char)*)(p))[0 .. zero];
}

const(T)[] asArray(T)(const(ubyte)[] mem, size_t offset = 0)
{
    return (cast(const(T)*)(mem.ptr + offset))[0 .. mem.length / T.sizeof];
}

ref const(T) asRef(T)(const(ubyte)[] mem, size_t offset = 0)
{
    return *cast(const(T)*)mem.ptr[offset .. offset + T.sizeof];
}

T asVal(T)(const(ubyte)[] mem, size_t offset = 0)
{
    return *cast(T*)mem.ptr[offset .. offset + T.sizeof];
}
