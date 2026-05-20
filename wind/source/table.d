module table;

import std.exception : enforce;
import std.format : format;
public import std.uuid : UUID;

import metadata : Metadata;
import compositeindex;
public import md;
import row : Row;

public struct Table(MD md)
{
    public const(Metadata)* db;
    private uint rowSize;
    public uint rowCount;
    private Column[6] columns;
    private const(ubyte)[] data;

    @disable this();

    this(const(Metadata)* db, uint rowCount, ref const(ubyte)[] data, ubyte a, ubyte b = 0, ubyte c = 0, ubyte d = 0, ubyte e = 0, ubyte f = 0)
    {
        assert(a);
        assert(a <= 8);
        assert(b <= 8);
        assert(c <= 8);
        assert(d <= 8);
        assert(e <= 8);
        assert(f <= 8);

        this.db = db;
        this.rowSize = a + b + c + d + e + f;
        this.rowCount = rowCount;

        columns[0] = Column(0, a);
        if (b)
            columns[1] = Column(a, b);
        if (c)
            columns[2] = Column(cast(ubyte)(a + b), c);
        if (d)
            columns[3] = Column(cast(ubyte)(a + b + c), d);
        if (e)
            columns[4] = Column(cast(ubyte)(a + b + c + d), e);
        if (f)
            columns[5] = Column(cast(ubyte)(a + b + c + d + e), f);

        this.data = data[0 .. rowCount * rowSize];
        data = data[rowCount * rowSize .. $];
    }

    public Row!md opIndex(uint index) const
    {
        return Row!md(&this, index);
    }

    public T getValue(T = uint)(uint row, uint column) const
    {
        enforce(row < rowCount, format("Invalid row (%d of %d)", row, rowCount));
        auto sz = columns[column].size;
        assert(sz == 1 || sz == 2 || sz == 4 || sz == 8);
        assert(sz <= T.sizeof);
        auto ptr = data.ptr + row * rowSize + columns[column].offset;
        switch (sz)
        {
        case 1:
            return cast(T)(*ptr);
        case 2:
            return cast(T)(*cast(const(ushort)*) ptr);
        case 4:
            return cast(T)(*cast(const(uint)*) ptr);
        default:
            return cast(T)(*cast(const(ulong)*) ptr);
        }
    }

    public CompositeIndex!T getCompositeIndex(T)(uint row, uint column) const
    {
        return CompositeIndex!T(getValue!uint(row, column));
    }

    public string getString(uint row, uint column) const
    {
        return db.getString(getValue!uint(row, column));
    }

    public const(ubyte)[] getBlob(uint row, uint column) const
    {
        return db.getBlob(getValue!uint(row, column));
    }

    public UUID getGUID(int row, uint column) const
    {
        return db.getGUID(getValue!uint(row, column));
    }

    public auto getList(MD target)(uint row, uint column) const
    {

        uint startIndex = getValue!uint(row, column);
        uint nextIndex;
        if (row < rowCount - 1)
            nextIndex = getValue!uint(row + 1, column);
        else
            nextIndex = 0;
        return db.getList!target(startIndex, nextIndex);
    }

    public auto items() const
    {
        return TableEnumerator!md(&this);
    }

}

private struct Column
{
    ubyte offset;
    ubyte size;
}

private struct TableEnumerator(MD md)
{

    const(Table!md)* table;
    uint index;

    @disable this();

    this(const(Table!md)* table)
    {
        this.table = table;
        static if (md == MD.typeDef)
            index = 2;
        else
            index = 1;
    }

    pragma(inline, true)
    bool empty()
    {
        return index > table.rowCount;
    }

    pragma(inline, true)
    void popFront()
    {
        ++index;
    }

    pragma(inline, true)
    auto front()
    {
        return Row!md(table, index);
    }
}
