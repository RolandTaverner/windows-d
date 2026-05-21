module climetadata.mdcollection.entity;

public import std.uuid : UUID;

import climetadata.mdtable.heaps : Heaps;
import climetadata.mdtable.row : Row;
public import climetadata.mdtable.type;
import climetadata.mdtable.value;

public struct Entity(MDTableType md)
{
    @disable this();

    public this(in Row!md row, const Heaps* heaps)
    {
        this.row = row;
        this.heaps = heaps;
    }

    static if (md == MDTableType.module_)
    {
        mixin moduleFieldGetters!();
    } 

private:
    const Row!md row;
    const Heaps* heaps;
}

private mixin template moduleFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.module_, "Unused");
    mixin DeclSimpleField!(MDTableType.module_, "Name");
    mixin DeclSimpleField!(MDTableType.module_, "Mvid");
    mixin DeclSimpleField!(MDTableType.module_, "EncId");
    mixin DeclSimpleField!(MDTableType.module_, "EncBaseId");
}

// Declares member function (field value getter)
// GetFieldValueType!(ValueType!(T, K)) get##Name() const { ... }
private mixin template DeclSimpleField(alias md, string Name)
{
    enum injectFieldGetter = ()
    {
        immutable tableType = "MDTableType." ~ md.stringof;

        immutable string columnValueType = "Row!(" ~ tableType ~ ")." ~ Name ~ "ValueType";
        immutable string columnValueTypeAlias = Name ~ "ColumnValueType";

        immutable string extractorType = "FieldValueExtractor!(" ~ columnValueType ~ ")";
        immutable string extractorTypeAlias = Name ~ "FieldValueExtractorType";

        string decl = "";
        decl ~= "public alias " ~ columnValueTypeAlias ~ " = " ~ columnValueType ~ ";\n";
        decl ~= "public alias " ~ extractorTypeAlias ~ " = " ~ extractorType ~ ";\n";
        
        decl ~= "public GetFieldValueType!(" ~ columnValueTypeAlias ~ ") get" ~ Name ~ "() const\n";
        decl ~= "{ return " ~ extractorTypeAlias ~ "(heaps).getValue(row.get" ~ Name ~ "());" ~ " }\n";

        return decl;
    };

    mixin(injectFieldGetter());
}

unittest
{
    alias ModuleEntity = Entity!(MDTableType.module_);

    static assert(is(GetFieldValueType!(ModuleEntity.UnusedColumnValueType) == ushort));
    static assert(is(GetFieldValueType!(ModuleEntity.NameColumnValueType) == string));
    static assert(is(GetFieldValueType!(ModuleEntity.MvidColumnValueType) == UUID));
    static assert(is(GetFieldValueType!(ModuleEntity.EncIdColumnValueType) == UUID));
    static assert(is(GetFieldValueType!(ModuleEntity.EncBaseIdColumnValueType) == UUID));
}

// value is Value<T, K>
struct FieldValueExtractor(value)
{
    public alias ReturnValueType = GetFieldValueType!(value);
    
    public this(const (Heaps*) heaps)
    {
        this.heaps = heaps;
    }
    
    ReturnValueType getValue(in value v) const
    {
        static if (value.Kind == ValueKind.Integral)
        {
            return v;
        }
        else static if (value.Kind == ValueKind.Guid)
        {
            return heaps.getGuid(v);
        }
        else static if (value.Kind == ValueKind.String)
        {
            return heaps.getString(v);
        }
        else static if (value.Kind == ValueKind.Blob)
        {
            return heaps.getBlob(v);
        }
        else
        {
            static assert(false, "invalid value kind");
        }
    }

    private:
        const (Heaps*) heaps;
}

unittest
{
    Heaps heaps = Heaps([], [], []);

    alias TestIntegralExtractor = FieldValueExtractor!(Value!(ushort, ValueKind.Integral));
    TestIntegralExtractor te = TestIntegralExtractor(&heaps);

    auto integralVal = te.getValue(Value!(ushort, ValueKind.Integral)(42));
    assert(integralVal == 42);
}

unittest
{
    const(ubyte)[] stringsHeap = ['q', 0]; // one null-terminated string "q" at offset 0

    Heaps heaps = Heaps(stringsHeap, [], []);

    alias TestStringExtractor = FieldValueExtractor!(Value!(uint, ValueKind.String));
    TestStringExtractor te = TestStringExtractor(&heaps);

    auto stringVal = te.getValue(Value!(uint, ValueKind.String)(0));
    assert(stringVal == "q");
}

// value is Value<T, K>
template GetFieldValueType(value) 
{
    static if (value.Kind == ValueKind.Integral)
    {
        alias GetFieldValueType = value.Type;
    } 
    else static if (value.Kind == ValueKind.Guid)
    {
        alias GetFieldValueType = UUID;
    }
    else static if (value.Kind == ValueKind.String)
    {
        alias GetFieldValueType = string;
    }
    else static if (value.Kind == ValueKind.Blob)
    {
        alias GetFieldValueType = const(ubyte)[];
    }
    else
    {
        alias GetFieldValueType = void;
    }
}

unittest
{
    alias Val1 = Value!(ushort, ValueKind.Integral);
    static assert(is(GetFieldValueType!(Val1) == ushort));

    alias Val2 = Value!(uint, ValueKind.String);
    static assert(is(GetFieldValueType!(Val2) == string));

    alias Val3 = Value!(uint, ValueKind.Guid);
    static assert(is(GetFieldValueType!(Val3) == UUID));

    alias Val4 = Value!(uint, ValueKind.Blob);
    static assert(is(GetFieldValueType!(Val4) == const(ubyte)[]));
}