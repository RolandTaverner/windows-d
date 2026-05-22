module climetadata.mdcollection.entity;

public import std.uuid : UUID;

import climetadata.mdtable.heaps : Heaps;
import climetadata.mdtable.row : Row;
import climetadata.mdtable.type;
import climetadata.mdtable.value;
import climetadata.mdcollection.database : Database;

public struct Entity(MDTableType md)
{
    @disable this();

    public this(in Row!md row, const Database* db)
    {
        this.row = row;
        this.db = db;
    }

    static if (md == MDTableType.module_)
    {
        mixin moduleFieldGetters!();
    } 
    else static if (md == MDTableType.typeRef)
    {
        mixin typeRefFieldGetters!();
    }
    else static if (md == MDTableType.typeDef)
    {
        mixin typeDefFieldGetters!();
    }
    else static if (md == MDTableType.field)
    {
        mixin fieldFieldGetters!();
    }
    else static if (md == MDTableType.methodDef)
    {
        mixin methodDefFieldGetters!();
    }
    else static if (md == MDTableType.param)
    {
        mixin paramFieldGetters!();
    }
    else static if (md == MDTableType.interfaceImpl)
    {
        mixin interfaceImplFieldGetters!();
    }

private:
    const Row!md row;
    const Database* db;
}

private mixin template moduleFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.module_, "Unused");
    mixin DeclSimpleField!(MDTableType.module_, "Name");
    mixin DeclSimpleField!(MDTableType.module_, "Mvid");
    mixin DeclSimpleField!(MDTableType.module_, "EncId");
    mixin DeclSimpleField!(MDTableType.module_, "EncBaseId");
}

private mixin template typeRefFieldGetters()
{
    //mixin DeclColumn!(MDTableType.typeRef, 0, ushort, ValueKind.CodedIndex, "ResolutionScope");
    mixin DeclSimpleField!(MDTableType.typeRef, "TypeName");
    mixin DeclSimpleField!(MDTableType.typeRef, "TypeNamespace");
}

private mixin template typeDefFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.typeDef, "Flags");
    mixin DeclSimpleField!(MDTableType.typeDef, "TypeName");
    mixin DeclSimpleField!(MDTableType.typeDef, "TypeNamespace");
    // mixin DeclColumn!(MDTableType.typeDef, 3, uint, ValueKind.CodedIndex, "Extends");
    // mixin DeclIndexField!(MDTableType.typeDef, "FieldList", MDTableType.field);
    // mixin DeclIndexField!(MDTableType.typeDef, "MethodList", MDTableType.methodDef);
}

private mixin template fieldFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.field, "Flags");
    mixin DeclSimpleField!(MDTableType.field, "Name");
    mixin DeclSimpleField!(MDTableType.field, "Signature");
}

private mixin template methodDefFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.methodDef, "RVA");
    mixin DeclSimpleField!(MDTableType.methodDef, "ImplFlags");
    mixin DeclSimpleField!(MDTableType.methodDef, "Flags");
    mixin DeclSimpleField!(MDTableType.methodDef, "Name");
    mixin DeclSimpleField!(MDTableType.methodDef, "Signature");
    // mixin DeclColumn!(MDTableType.methodDef, 5, uint, ValueKind.Index, "ParamList");
}

private mixin template paramFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.param, "Flags");
    mixin DeclSimpleField!(MDTableType.param, "Sequence");
    mixin DeclSimpleField!(MDTableType.param, "Name");
}

private mixin template interfaceImplFieldGetters()
{
    mixin DeclIndexField!(MDTableType.interfaceImpl, "Class", MDTableType.typeDef);
    // mixin DeclColumn!(MDTableType.interfaceImpl, 1, uint, ValueKind.CodedIndex, "Interface");
}

private mixin template DeclListIndexField(alias md, string Name, alias mdTarget)
{
    enum injectFieldGetter = ()
    {
        immutable tableType = "MDTableType." ~ md.stringof;
        immutable string columnValueType = "Row!(" ~ tableType ~ ")." ~ Name ~ "ValueType";
        immutable string columnValueTypeAlias = Name ~ "ColumnValueType";

        immutable targetTableType = "MDTableType." ~ mdTarget.stringof;

        immutable string extractorType = "IndexFieldValueExtractor!(" ~ columnValueType ~ ", " ~ targetTableType ~ ")";
        immutable string extractorTypeAlias = Name ~ "FieldValueExtractorType";

        string decl = "";
        decl ~= "public alias " ~ columnValueTypeAlias ~ " = " ~ columnValueType ~ ";\n";
        decl ~= "public alias " ~ extractorTypeAlias ~ " = " ~ extractorType ~ ";\n";
        
        decl ~= "public auto get" ~ Name ~ "() const\n";
        decl ~= "{ return " ~ extractorTypeAlias ~ "(db).getValue(row.get" ~ Name ~ "());" ~ " }\n";

        return decl;
    };

    mixin(injectFieldGetter());
}


// Declares member function (index field value getter)
// const(Entity!mdTarget) get##Name() const { ... }
private mixin template DeclIndexField(alias md, string Name, alias mdTarget)
{
    enum injectFieldGetter = ()
    {
        immutable tableType = "MDTableType." ~ md.stringof;
        immutable string columnValueType = "Row!(" ~ tableType ~ ")." ~ Name ~ "ValueType";
        immutable string columnValueTypeAlias = Name ~ "ColumnValueType";

        immutable targetTableType = "MDTableType." ~ mdTarget.stringof;

        immutable string extractorType = "IndexFieldValueExtractor!(" ~ columnValueType ~ ", " ~ targetTableType ~ ")";
        immutable string extractorTypeAlias = Name ~ "FieldValueExtractorType";

        string decl = "";
        decl ~= "public alias " ~ columnValueTypeAlias ~ " = " ~ columnValueType ~ ";\n";
        decl ~= "public alias " ~ extractorTypeAlias ~ " = " ~ extractorType ~ ";\n";
        
        decl ~= "public auto get" ~ Name ~ "() const\n";
        decl ~= "{ return " ~ extractorTypeAlias ~ "(db).getValue(row.get" ~ Name ~ "());" ~ " }\n";

        return decl;
    };

    mixin(injectFieldGetter());
}

unittest
{
    alias InterfaceImplEntity = Entity!(MDTableType.interfaceImpl);

    static assert(is(InterfaceImplEntity.ClassFieldValueExtractorType == IndexFieldValueExtractor!(Value!(uint, ValueKind.Index), MDTableType.typeDef)));
}

// value is Value<T, K>
struct IndexFieldValueExtractor(value, MDTableType mdTarget) if (value.Kind == ValueKind.Index)
{
    public alias ReturnValueType = const(Entity!mdTarget);
    
    public this(const Database* db)
    {
        this.db = db;
    }
    
    ReturnValueType getValue(in value v) const
    {
        return db.getCollection!(mdTarget)[v];
    }

    private:
        const Database* db;
}

// Declares member function (field value getter)
// GetFieldValueType!(ValueType!(T, K)) get##Name() const { ... }
//
// Example for string field 'Name' at module table:
//
// public alias NameColumnValueType = Row!(MDTableType.module_).NameValueType;
// public alias NameFieldValueExtractorType = FieldValueExtractor!NameColumnValueType);
// public auto getName() const // returns string because Row!(MDTableType.module_).NameValueType is Value(MDTableType.module_, ValueKind.String)
// {
//     return NameFieldValueExtractorType(db.heaps()).getValue(row.getName());
// }
private mixin template DeclSimpleField(alias md, string Name)
{
    enum injectFieldGetter = ()
    {
        immutable tableType = "MDTableType." ~ md.stringof;

        immutable string columnValueType = "Row!(" ~ tableType ~ ")." ~ Name ~ "ValueType";
        immutable string columnValueTypeAlias = Name ~ "ColumnValueType";

        immutable string extractorType = "FieldValueExtractor!(" ~ columnValueTypeAlias ~ ")";
        immutable string extractorTypeAlias = Name ~ "FieldValueExtractorType";

        string decl = "";
        decl ~= "public alias " ~ columnValueTypeAlias ~ " = " ~ columnValueType ~ ";\n";
        decl ~= "public alias " ~ extractorTypeAlias ~ " = " ~ extractorType ~ ";\n";
        
        decl ~= "public auto get" ~ Name ~ "() const\n";
        decl ~= "{ return " ~ extractorTypeAlias ~ "(db.heaps()).getValue(row.get" ~ Name ~ "());" ~ " }\n";

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