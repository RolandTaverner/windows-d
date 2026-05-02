module climetadata.mdtable.heaps;

public import std.uuid : UUID;

private import climetadata.utils.memcast;
private import climetadata.utils.readcompressed;

struct StringsHeap
{
    @disable this();

    public this(const(ubyte)[] heap)
    {
        stringsHeap = heap;
    }

    public string get(uint offset) const
    {
        return asString(stringsHeap, offset);
    }  

    private const(ubyte)[] stringsHeap;
}

struct GuidsHeap
{
    @disable this();

    public this(const(ubyte)[] heap)
    {
        guidsHeap = heap;
    }

    UUID get(uint rowID) const
    {
        if (!rowID)
            return UUID.init;

        auto index = rowID - 1;
        return asRef!UUID(guidsHeap[index * UUID.sizeof .. index * UUID.sizeof + UUID.sizeof]);
    }

    private const(ubyte)[] guidsHeap;
}

struct BlobsHeap
{
    @disable this();

    public this(const(ubyte)[] heap)
    {
        blobsHeap = heap;
    }

    const(ubyte)[] get(uint offset) const
    {
        auto blob = blobsHeap[offset .. $];
        auto size = readCompressed(blob);
        return blob[0 .. size];
    }

    private const(ubyte)[] blobsHeap;
}
