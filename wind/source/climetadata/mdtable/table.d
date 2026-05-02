module climetadata.mdtable.table;

import std.typecons : Tuple;

public import climetadata.mdtable.type;

public alias ColumnKindSize = Tuple!(ValueKind, "kind", ubyte, "size");

public struct Table
{
    @disable this();

    public this(MDTableType mdType, ref const(ubyte)[] tablesHeap, uint rowCount, ColumnKindSize[] colKS)
    {
        assert(colKS.length >= 1);
        assert(colKS.length <= 6);
        assert(colKS[0].size != 0);

        this.mdType = mdType;

        uint rowSize = 0;
        foreach (c; colKS)
        {
            assert(c.size <= 8);
            rowSize += c.size;
        }

        this.rowCount = rowCount;
        this.rowSize = rowSize;

        this.data = tablesHeap[0 .. rowCount * rowSize];
        tablesHeap = tablesHeap[rowCount * rowSize .. $];

        const(ColumnDesc)[] columnDescs = [];
        ushort offset = 0;
        foreach (c; colKS)
        {
            columnDescs ~= ColumnDesc(offset, c.size, c.kind);
            offset += c.size;
        }

        this.columns = columnDescs;
    }

    public const MDTableType mdType;
    public const uint rowSize;
    public const uint rowCount;
    public const(ColumnDesc[]) columns;
    private const(ubyte)[] data;
}

unittest
{
    const(ubyte)[] mockTablesHeap = [0, 1, 2, 3, 4, 5];
    auto testTable = Table(MDTableType.unknown, mockTablesHeap, 1,
        [
            ColumnKindSize(ValueKind.Unused, 2),
            ColumnKindSize(ValueKind.String, 4),
        ]);

    assert(testTable.columns.length == 2);

    assert(testTable.columns[0].offset == 0);
    assert(testTable.columns[0].size == 2);
    assert(testTable.columns[0].kind == ValueKind.Unused);

    assert(testTable.columns[1].offset == 2);
    assert(testTable.columns[1].size == 4);
    assert(testTable.columns[1].kind == ValueKind.String);
}

public struct ColumnDesc
{
    @disable this();

    public this(in ushort offset, in ushort size, in ValueKind kind)
    {
        this.offset = offset;
        this.size = size;
        this.kind = kind;
    }

    const ushort offset; // bytes
    const ushort size; // bytes
    const ValueKind kind;
}

public enum ValueKind
{
    Unused,
    Integral, // Integer number
    Guid, // Index in Guids heap
    String, // offset in Strings heap
    Blob, // offset in Blobs heap
    Index, // Index in some table
    CodedIndex // Coded index in some table
}
