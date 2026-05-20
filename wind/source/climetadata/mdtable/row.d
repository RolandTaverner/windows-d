module climetadata.mdtable.row;

private import std.exception : enforce;

import climetadata.mdtable.value;
import climetadata.mdtable.table : Table;
import climetadata.mdtable.type;

public struct Row(MDTableType md)
{
    @disable this();

    // Attention: rowID is 1-based
    public this(in const(Table!md*) table, uint rowID)
    {
        assert(table != null);

        this.table = table;
        this.rowID = rowID;
    }

private:
    const(Table!md*) table;
    const uint rowID; // Row ID is 1-based
}

// Declares member function (column value getter)
// ValueType!(T, K) get##Name(uint rowID) const { ... }
private mixin template DeclColumn(alias md, uint column, alias T, alias K, string Name)
{
    alias fieldSpec = FieldSpec!(T, K, Name);

    enum injectGetter = ()
    {
        immutable string valueType = "Value!(" ~ fieldSpec.Type.stringof ~ ", " ~ " " ~ fieldSpec.Kind.stringof ~ ")";
        immutable string valueTypeAlias = fieldSpec.Name ~ "ValueType";
        immutable tableType = "MDTableType." ~ md.stringof;
        immutable string extractorType = "ColumnValueExtractor!(" ~ valueType ~ ", " ~ tableType ~ ", " ~ column.stringof ~ ")";
        immutable string extractorTypeAlias = fieldSpec.Name ~ "ExtractorType";

        string decl = "";
        decl ~= "alias " ~ valueTypeAlias ~ " = " ~ valueType ~ ";\n";
        decl ~= "alias " ~ extractorTypeAlias ~ " = " ~ extractorType ~ ";\n";
        
        decl ~= valueTypeAlias ~ " get" ~ fieldSpec.Name ~ "(uint rowID) const\n";
        decl ~= "{ return " ~ extractorTypeAlias ~ "().getValue(table, rowID);" ~ " }\n";

        return decl;
    };

    mixin(injectGetter());
}


unittest
{
    import climetadata.mdtable.table : ColumnKindSize;

    const(ubyte)[] tablesView = [1, 0, 0, 0, 2, 0, 0, 0];
    auto testTable = Table!(MDTableType.unknown)(tablesView, 1,
        [
            ColumnKindSize(ValueKind.Integral, 4),
            ColumnKindSize(ValueKind.Integral, 4),
        ]);

    struct Test
    {
        Table!(MDTableType.unknown)* table;

        mixin DeclColumn!(MDTableType.unknown, 0, uint, ValueKind.Integral, "Id");
        mixin DeclColumn!(MDTableType.unknown, 1, uint, ValueKind.Integral, "Name");
    };

    const Test t = Test(&testTable);
    
    assert(t.getId(1) == 1);
    assert(t.getName(1) == 2);
}

struct ColumnValueExtractor(alias VT, MDTableType md, uint column)
{
    public VT getValue(const(Table!md*) table, uint rowID) const
    {
        enforce(rowID != 0, "rowID can't be 0 (it is 1-based)");

        return VT(table.getValue!(VT.Type)(rowID - 1, column));
    }
};

unittest
{
    alias TestExtractor = ColumnValueExtractor!(Value!(uint, ValueKind.Integral), MDTableType.unknown, 0);
    TestExtractor e;
}

private template FieldSpec(T, ValueKind k, string s)
{
    alias Type = T;
    alias Kind = k;
    alias Name = s;
}
