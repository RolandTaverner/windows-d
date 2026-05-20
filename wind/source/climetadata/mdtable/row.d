module climetadata.mdtable.row;

import std.exception : enforce;

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

    static if (md == MDTableType.module_)
    {
        mixin moduleGetters!();
    } 
    else static if (md == MDTableType.typeRef)
    {
        mixin typeRefGetters!();
    }
    else static if (md == MDTableType.typeDef)
    {
        mixin typeDefGetters!();
    }
    else static if (md == MDTableType.field)
    {
        mixin fieldGetters!();
    }
    else static if (md == MDTableType.methodDef)
    {
        mixin methodDefGetters!();
    }

private:
    const(Table!md*) table;
    const uint rowID; // Row ID is 1-based
}

private mixin template moduleGetters()
{
    mixin DeclColumn!(MDTableType.module_, 0, ushort, ValueKind.Integral, "Unused");
    mixin DeclColumn!(MDTableType.module_, 1, uint, ValueKind.String, "Name");
    mixin DeclColumn!(MDTableType.module_, 2, uint, ValueKind.Guid, "Mvid");
    mixin DeclColumn!(MDTableType.module_, 3, uint, ValueKind.Guid, "EncId");
    mixin DeclColumn!(MDTableType.module_, 4, uint, ValueKind.Guid, "EncBaseId");
}

private mixin template typeRefGetters()
{
    mixin DeclColumn!(MDTableType.typeRef, 0, ushort, ValueKind.CodedIndex, "ResolutionScope");
    mixin DeclColumn!(MDTableType.typeRef, 1, uint, ValueKind.String, "TypeName");
    mixin DeclColumn!(MDTableType.typeRef, 2, uint, ValueKind.String, "TypeNamespace");
}

private mixin template typeDefGetters()
{
    mixin DeclColumn!(MDTableType.typeDef, 0, ushort, ValueKind.Integral, "Flags");
    mixin DeclColumn!(MDTableType.typeDef, 1, uint, ValueKind.String, "TypeName");
    mixin DeclColumn!(MDTableType.typeDef, 2, uint, ValueKind.String, "TypeNamespace");
    mixin DeclColumn!(MDTableType.typeDef, 3, uint, ValueKind.CodedIndex, "Extends");
    mixin DeclColumn!(MDTableType.typeDef, 4, uint, ValueKind.Index, "FieldList");
    mixin DeclColumn!(MDTableType.typeDef, 5, uint, ValueKind.Index, "MethodList");
}

private mixin template fieldGetters()
{
    mixin DeclColumn!(MDTableType.field, 0, ushort, ValueKind.Integral, "Flags");
    mixin DeclColumn!(MDTableType.field, 1, uint, ValueKind.String, "Name");
    mixin DeclColumn!(MDTableType.field, 2, uint, ValueKind.Blob, "Signature");
}

private mixin template methodDefGetters()
{
    mixin DeclColumn!(MDTableType.methodDef, 0, uint, ValueKind.Integral, "RVA");
    mixin DeclColumn!(MDTableType.methodDef, 1, ushort, ValueKind.Integral, "ImplFlags");
    mixin DeclColumn!(MDTableType.methodDef, 2, ushort, ValueKind.Integral, "Flags");
    mixin DeclColumn!(MDTableType.methodDef, 3, uint, ValueKind.String, "Name");
    mixin DeclColumn!(MDTableType.methodDef, 4, uint, ValueKind.Blob, "Signature");
    mixin DeclColumn!(MDTableType.methodDef, 5, uint, ValueKind.Index, "ParamList");
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
