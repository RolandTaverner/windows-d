module climetadata.mdcollection.entity;

public import std.uuid : UUID;

import climetadata.mdtable.heaps : Heaps;
import climetadata.mdtable.row : Row;
import climetadata.mdtable.table : emptyList, getNextRow, isLastRow;
import climetadata.mdtable.type;
import climetadata.mdtable.value;
import climetadata.mdcollection.collection : CollectionListEnumerator;
import climetadata.mdcollection.compositeindex;
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
    else static if (md == MDTableType.memberRef)
    {
        mixin memberRefFieldGetters!();
    }
    else static if (md == MDTableType.constant)
    {
        mixin constantFieldGetters!();
    }
    else static if (md == MDTableType.customAttribute)
    {
        mixin customAttributeFieldGetters!();
    }
    else static if (md == MDTableType.fieldMarshal)
    {
        mixin fieldMarshalFieldGetters!();
    }
    else static if (md == MDTableType.declSecurity)
    {
        mixin declSecurityFieldGetters!();
    }
    else static if (md == MDTableType.classLayout)
    {
        mixin classLayoutFieldGetters!();
    }
    else static if (md == MDTableType.fieldLayout)
    {
        mixin fieldLayoutFieldGetters!();
    }
    else static if (md == MDTableType.standAloneSig)
    {
        mixin standAloneSigFieldGetters!();
    }
    else static if (md == MDTableType.eventMap)
    {
        mixin eventMapFieldGetters!();
    }
    else static if (md == MDTableType.event)
    {
        mixin eventFieldGetters!();
    }
    else static if (md == MDTableType.propertyMap)
    {
        mixin propertyMapFieldGetters!();
    }
    else static if (md == MDTableType.property)
    {
        mixin propertyFieldGetters!();
    }
    else static if (md == MDTableType.methodSemantics)
    {
        mixin methodSemanticsFieldGetters!();
    }
    else static if (md == MDTableType.methodImpl)
    {
        mixin methodImplFieldGetters!();
    }
    else static if (md == MDTableType.moduleRef)
    {
        mixin moduleRefFieldGetters!();
    }
    else static if (md == MDTableType.typeSpec)
    {
        mixin typeSpecFieldGetters!();
    }
    else static if (md == MDTableType.implMap)
    {
        mixin implMapFieldGetters!();
    }
    else static if (md == MDTableType.fieldRVA)
    {
        mixin fieldRVAFieldGetters!();
    }
    else static if (md == MDTableType.assembly)
    {
        mixin assemblyFieldGetters!();
    }
    else static if (md == MDTableType.assemblyProcessor)
    {
        mixin assemblyProcessorFieldGetters!();
    }
    else static if (md == MDTableType.assemblyOS)
    {
        mixin assemblyOSFieldGetters!();
    }
    else static if (md == MDTableType.assemblyRef)
    {
        mixin assemblyRefFieldGetters!();
    }
    else static if (md == MDTableType.assemblyRefProcessor)
    {
        mixin assemblyRefProcessorFieldGetters!();
    }
    else static if (md == MDTableType.assemblyRefOS)
    {
        mixin assemblyRefOSFieldGetters!();
    }
    else static if (md == MDTableType.file)
    {
        mixin fileFieldGetters!();
    }
    else static if (md == MDTableType.exportedType)
    {
        mixin exportedTypeFieldGetters!();
    }
    else static if (md == MDTableType.manifestResource)
    {
        mixin manifestResourceFieldGetters!();
    }
    else static if (md == MDTableType.nestedClass)
    {
        mixin nestedClassFieldGetters!();
    }
    else static if (md == MDTableType.genericParam)
    {
        mixin genericParamFieldGetters!();
    }
    else static if (md == MDTableType.methodSpec)
    {
        mixin methodSpecFieldGetters!();
    }
    else static if (md == MDTableType.genericParamConstraint)
    {
        mixin genericParamConstraintFieldGetters!();
    }

    // public ref const(Row!md) getRow() const
    // {
    //     return row;
    // }

private:
    const Row!md row;
    const Database* db;
}

//=============================================================================
// module entity getters

private mixin template moduleFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.module_, "Unused");
    mixin DeclSimpleField!(MDTableType.module_, "Name");
    mixin DeclSimpleField!(MDTableType.module_, "Mvid");
    mixin DeclSimpleField!(MDTableType.module_, "EncId");
    mixin DeclSimpleField!(MDTableType.module_, "EncBaseId");
}

//=============================================================================
// typeRef entity getters

private mixin template typeRefFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.typeRef, "TypeName");
    mixin DeclSimpleField!(MDTableType.typeRef, "TypeNamespace");
}

mixin DeclCodedIndexFieldGetter!(MDTableType.typeRef, "ResolutionScope", ResolutionScope);

//=============================================================================
// typeDef entity getters

private mixin template typeDefFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.typeDef, "Flags");
    mixin DeclSimpleField!(MDTableType.typeDef, "TypeName");
    mixin DeclSimpleField!(MDTableType.typeDef, "TypeNamespace");
    mixin DeclListIndexField!(MDTableType.typeDef, "FieldList", MDTableType.field);
    mixin DeclListIndexField!(MDTableType.typeDef, "MethodList", MDTableType.methodDef);
}

mixin DeclCodedIndexFieldGetter!(MDTableType.typeDef, "Extends", TypeDefOrRef);

//=============================================================================
// field entity getters

private mixin template fieldFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.field, "Flags");
    mixin DeclSimpleField!(MDTableType.field, "Name");
    mixin DeclSimpleField!(MDTableType.field, "Signature");
}

//=============================================================================
// methodDef entity getters

private mixin template methodDefFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.methodDef, "RVA");
    mixin DeclSimpleField!(MDTableType.methodDef, "ImplFlags");
    mixin DeclSimpleField!(MDTableType.methodDef, "Flags");
    mixin DeclSimpleField!(MDTableType.methodDef, "Name");
    mixin DeclSimpleField!(MDTableType.methodDef, "Signature");
    mixin DeclListIndexField!(MDTableType.methodDef, "ParamList", MDTableType.param);
}

//=============================================================================
// param entity getters

private mixin template paramFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.param, "Flags");
    mixin DeclSimpleField!(MDTableType.param, "Sequence");
    mixin DeclSimpleField!(MDTableType.param, "Name");
}

//=============================================================================
// interfaceImpl entity getters

private mixin template interfaceImplFieldGetters()
{
    mixin DeclIndexField!(MDTableType.interfaceImpl, "Class", MDTableType.typeDef);
}

mixin DeclCodedIndexFieldGetter!(MDTableType.interfaceImpl, "Interface", TypeDefOrRef);

//=============================================================================
// memberRef entity getters

private mixin template memberRefFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.memberRef, "Name");
    mixin DeclSimpleField!(MDTableType.memberRef, "Signature");
}

mixin DeclCodedIndexFieldGetter!(MDTableType.memberRef, "Class", MemberRefParent);

//=============================================================================
// constant entity getters

private mixin template constantFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.constant, "Type");
    mixin DeclSimpleField!(MDTableType.constant, "Value");
}

mixin DeclCodedIndexFieldGetter!(MDTableType.constant, "Parent", HasConstant);

//=============================================================================
// customAttribute entity getters

private mixin template customAttributeFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.customAttribute, "Value");
}

mixin DeclCodedIndexFieldGetter!(MDTableType.customAttribute, "Parent", HasCustomAttribute);
mixin DeclCodedIndexFieldGetter!(MDTableType.customAttribute, "Type", CustomAttributeType);

//=============================================================================
// fieldMarshal entity getters

private mixin template fieldMarshalFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.fieldMarshal, "NativeType");
}

mixin DeclCodedIndexFieldGetter!(MDTableType.fieldMarshal, "Parent", HasFieldMarshal);

//=============================================================================
// declSecurity entity getters

private mixin template declSecurityFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.declSecurity, "Action");
    mixin DeclSimpleField!(MDTableType.declSecurity, "PermissionSet");
}

mixin DeclCodedIndexFieldGetter!(MDTableType.declSecurity, "Parent", HasDeclSecurity);

//=============================================================================
// classLayout entity getters

private mixin template classLayoutFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.classLayout, "PackingSize");
    mixin DeclSimpleField!(MDTableType.classLayout, "ClassSize");
    mixin DeclIndexField!(MDTableType.classLayout, "Parent", MDTableType.typeDef);
}

//=============================================================================
// fieldLayout entity getters

private mixin template fieldLayoutFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.fieldLayout, "Offset");
    mixin DeclIndexField!(MDTableType.fieldLayout, "Field", MDTableType.field);
}

//=============================================================================
// standAloneSig entity getters

private mixin template standAloneSigFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.standAloneSig, "Signature");
}

//=============================================================================
// eventMap entity getters

private mixin template eventMapFieldGetters()
{
    mixin DeclIndexField!(MDTableType.eventMap, "Parent", MDTableType.typeDef);
    mixin DeclIndexField!(MDTableType.eventMap, "EventList", MDTableType.event);
}

//=============================================================================
// event entity getters

private mixin template eventFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.event, "EventFlags");
    mixin DeclSimpleField!(MDTableType.event, "Name");
}

mixin DeclCodedIndexFieldGetter!(MDTableType.event, "EventType", TypeDefOrRef);

//=============================================================================
// propertyMap entity getters

private mixin template propertyMapFieldGetters()
{
    mixin DeclIndexField!(MDTableType.propertyMap, "Parent", MDTableType.typeDef);
    mixin DeclIndexField!(MDTableType.propertyMap, "PropertyList", MDTableType.property);
}

//=============================================================================
// property entity getters

private mixin template propertyFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.property, "Flags");
    mixin DeclSimpleField!(MDTableType.property, "Name");
    mixin DeclSimpleField!(MDTableType.property, "Type");
}

//=============================================================================
// methodSemantics entity getters

private mixin template methodSemanticsFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.methodSemantics, "Semantics");
    mixin DeclIndexField!(MDTableType.methodSemantics, "Method", MDTableType.methodDef);
}

mixin DeclCodedIndexFieldGetter!(MDTableType.methodSemantics, "Association", HasSemantics);

//=============================================================================
// methodImpl entity getters

private mixin template methodImplFieldGetters()
{
    mixin DeclIndexField!(MDTableType.methodImpl, "Class", MDTableType.typeDef);
}

mixin DeclCodedIndexFieldGetter!(MDTableType.methodImpl, "MethodBody", MethodDefOrRef);
mixin DeclCodedIndexFieldGetter!(MDTableType.methodImpl, "MethodDeclaration", MethodDefOrRef);

//=============================================================================
// moduleRef entity getters

private mixin template moduleRefFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.moduleRef, "Name");
}

//=============================================================================
// typeSpec entity getters

private mixin template typeSpecFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.typeSpec, "Signature");
}

//=============================================================================
// implMap entity getters

private mixin template implMapFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.implMap, "MappingFlags");
    mixin DeclSimpleField!(MDTableType.implMap, "ImportName");
    mixin DeclIndexField!(MDTableType.implMap, "ImportScope", MDTableType.moduleRef);
}

mixin DeclCodedIndexFieldGetter!(MDTableType.implMap, "MemberForwarded", MemberForwarded);

//=============================================================================
// fieldRVA entity getters

private mixin template fieldRVAFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.fieldRVA, "RVA");
    mixin DeclIndexField!(MDTableType.fieldRVA, "Field", MDTableType.field);
}

//=============================================================================
// assembly entity getters

private mixin template assemblyFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.assembly, "HashAlgId");
    mixin DeclSimpleField!(MDTableType.assembly, "Version");
    mixin DeclSimpleField!(MDTableType.assembly, "Flags");
    mixin DeclSimpleField!(MDTableType.assembly, "PublicKey");
    mixin DeclSimpleField!(MDTableType.assembly, "Name");
    mixin DeclSimpleField!(MDTableType.assembly, "Culture");
}

//=============================================================================
// assemblyProcessor entity getters

private mixin template assemblyProcessorFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.assemblyProcessor, "Processor");
}

//=============================================================================
// assemblyOS entity getters

private mixin template assemblyOSFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.assemblyOS, "OSPlatformID");
    mixin DeclSimpleField!(MDTableType.assemblyOS, "OSMajorVersion");
    mixin DeclSimpleField!(MDTableType.assemblyOS, "OSMinorVersion");
}

//=============================================================================
// assemblyRef entity getters

private mixin template assemblyRefFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.assemblyRef, "Version");
    mixin DeclSimpleField!(MDTableType.assemblyRef, "Flags");
    mixin DeclSimpleField!(MDTableType.assemblyRef, "PublicKeyOrToken");
    mixin DeclSimpleField!(MDTableType.assemblyRef, "Name");
    mixin DeclSimpleField!(MDTableType.assemblyRef, "Culture");
    mixin DeclSimpleField!(MDTableType.assemblyRef, "HashValue");
}

//=============================================================================
// assemblyRefProcessor entity getters

private mixin template assemblyRefProcessorFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.assemblyRefProcessor, "Processor");
    mixin DeclIndexField!(MDTableType.assemblyRefProcessor, "AssemblyRef", MDTableType.assemblyRef);
}

//=============================================================================
// assemblyRefOS entity getters

private mixin template assemblyRefOSFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.assemblyRefOS, "OSPlatformId");
    mixin DeclSimpleField!(MDTableType.assemblyRefOS, "OSMajorVersion");
    mixin DeclSimpleField!(MDTableType.assemblyRefOS, "OSMinorVersion");
    mixin DeclIndexField!(MDTableType.assemblyRefOS, "AssemblyRef", MDTableType.assemblyRef);
}

//=============================================================================
// file entity getters

private mixin template fileFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.file, "Flags");
    mixin DeclSimpleField!(MDTableType.file, "Name");
    mixin DeclSimpleField!(MDTableType.file, "HashValue");
}

//=============================================================================
// exportedType entity getters

private mixin template exportedTypeFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.exportedType, "Flags");
    mixin DeclSimpleField!(MDTableType.exportedType, "TypeDefId");
    mixin DeclSimpleField!(MDTableType.exportedType, "TypeName");
    mixin DeclSimpleField!(MDTableType.exportedType, "TypeNamespace");
}

mixin DeclCodedIndexFieldGetter!(MDTableType.exportedType, "Implementation", Implementation);

//=============================================================================
// manifestResource entity getters

private mixin template manifestResourceFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.manifestResource, "Offset");
    mixin DeclSimpleField!(MDTableType.manifestResource, "Flags");
    mixin DeclSimpleField!(MDTableType.manifestResource, "Name");
}

mixin DeclCodedIndexFieldGetter!(MDTableType.manifestResource, "Implementation", Implementation);

//=============================================================================
// nestedClass entity getters

private mixin template nestedClassFieldGetters()
{
    mixin DeclIndexField!(MDTableType.nestedClass, "NestedClass", MDTableType.typeDef);
    mixin DeclIndexField!(MDTableType.nestedClass, "EnclosingClass", MDTableType.typeDef);
}

//=============================================================================
// genericParam entity getters

private mixin template genericParamFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.genericParam, "Number");
    mixin DeclSimpleField!(MDTableType.genericParam, "Flags");
    mixin DeclSimpleField!(MDTableType.genericParam, "Name");
}

mixin DeclCodedIndexFieldGetter!(MDTableType.genericParam, "Owner", TypeOrMethodDef);

//=============================================================================
// methodSpec entity getters

private mixin template methodSpecFieldGetters()
{
    mixin DeclSimpleField!(MDTableType.methodSpec, "Instantiation");
}

mixin DeclCodedIndexFieldGetter!(MDTableType.methodSpec, "Method", MethodDefOrRef);

//=============================================================================
// genericParamConstraint entity getters

private mixin template genericParamConstraintFieldGetters()
{
    mixin DeclIndexField!(MDTableType.genericParamConstraint, "Owner", MDTableType.genericParam);
}

mixin DeclCodedIndexFieldGetter!(MDTableType.genericParamConstraint, "Constraint", TypeDefOrRef);

// Declares free function (coded index field value getter)
// CodedIndexValueType!CodedIndexType get##Name() const { ... }
// bool null##Name() const { ... }
private mixin template DeclCodedIndexFieldGetter(alias md, string Name, CodedIndexType)
{
    enum injectCodedIndexFieldGetter = ()
    {
        immutable string tableType = "MDTableType." ~ md.stringof;
        immutable string entityType = "Entity!(" ~ tableType ~ ")";

        immutable string columnValueType = "Row!(" ~ tableType ~ ")." ~ Name ~ "ValueType";
        immutable string columnValueTypeAlias = Name ~ "ColumnValueType";

        immutable string codedIndexValueType = "CodedIndexValueType!(" ~ CodedIndexType.stringof ~ ")";

        string decl = "";

        decl ~= "public bool null" ~ Name ~ "(in " ~ entityType ~ " entity)\n";
        decl ~= "{\n";
        decl ~= "  const auto columnValue = entity.row.get" ~ Name ~ "();\n";
        decl ~= "  const auto codedIndex = CompositeIndex!(" ~ CodedIndexType.stringof ~ ")(columnValue);\n";
        decl ~= "  return codedIndex.index() == 0;\n";
        decl ~= "}\n";

        // decl ~= extractorTypeAlias ~ " e;\n";

        decl ~= "public " ~ codedIndexValueType ~ " get" ~ Name ~ "(in " ~ entityType ~ " entity)\n";
        decl ~= "{\n";
        decl ~= "  alias " ~ columnValueTypeAlias ~ " = " ~ columnValueType ~ ";\n";
        decl ~= "  static assert(" ~ columnValueTypeAlias ~ ".Kind == ValueKind.CodedIndex);\n";
        // decl ~= "  alias " ~ codedIndexValueTypeAlias ~ " = " ~ codedIndexValueType ~ ";\n";
        // decl ~= "  alias " ~ extractorTypeAlias ~ " = " ~ extractorType ~ ";\n";
        decl ~= "  const auto columnValue = entity.row.get" ~ Name ~ "();\n";
        decl ~= "  const auto codedIndex = CompositeIndex!(" ~ CodedIndexType.stringof ~ ")(columnValue);\n";
        decl ~= "  return getCodedIndexValue!(" ~ CodedIndexType.stringof ~ ")(entity.db, codedIndex);\n";
        decl ~= "}\n";

        return decl;
    };

    mixin(injectCodedIndexFieldGetter());
}

struct CodedIndexFieldValueExtractor(CodedIndexType)
{
    alias ValueType = CodedIndexValueType!(CodedIndexType);

    public this(const Database* db)
    {
        this.db = db;
    }
    
    public ValueType getValue(in CompositeIndex!(CodedIndexType) codedIndex) const
    {
        return getCodedIndexValue!(CodedIndexType)(db, codedIndex);
    }

    private const Database* db;    
}

// Declares member function (list index field value getter)
// CollectionListEnumerator!mdTarget get##Name() const { ... }
// bool null##Name() const { ... }
private mixin template DeclListIndexField(alias md, string Name, alias mdTarget)
{
    enum injectFieldGetter = ()
    {
        immutable string tableType = "MDTableType." ~ md.stringof;
        immutable string columnValueType = "Row!(" ~ tableType ~ ")." ~ Name ~ "ValueType";
        immutable string columnValueTypeAlias = Name ~ "ColumnValueType";

        immutable string targetTableType = "MDTableType." ~ mdTarget.stringof;

        string decl = "";
        decl ~= "public alias " ~ columnValueTypeAlias ~ " = " ~ columnValueType ~ ";\n";
        decl ~= "static assert(" ~ columnValueTypeAlias ~ ".Kind == ValueKind.Index);\n";

        decl ~= "public bool null" ~ Name ~ "() const\n";
        decl ~= "{\n";
        decl ~= "  const auto columnValue = row.get" ~ Name ~ "();\n";
        decl ~= "  return columnValue == 0 || columnValue > db.getTable!(" ~ targetTableType ~ ")().rowCount;\n";
        decl ~= "}\n";

        decl ~= "public auto get" ~ Name ~ "() const\n";
        decl ~= "{\n";
        decl ~= "  auto isNull = null" ~ Name ~ "();\n";
        decl ~= "  if (isNull) return CollectionListEnumerator!(" ~ targetTableType ~ ")(emptyList(" ~ "db.getTable!(" ~ targetTableType ~ ")()" ~ "), db);\n";
        decl ~= "  auto columnValue = row.get" ~ Name ~ "();\n";
        decl ~= "  auto isLast = isLastRow(row);\n";
        decl ~= "  if (isLast) return db.getCollection!(" ~ targetTableType ~ ").list(columnValue, 0);\n";
        decl ~= "  auto nextRow = getNextRow(row);\n";
        decl ~= "  auto nextColumnValue = nextRow.get" ~ Name ~ "();\n";
        decl ~= "  return db.getCollection!(" ~ targetTableType ~ ").list(columnValue, nextColumnValue);\n";
        decl ~= "}\n";

        return decl;
    };

    mixin(injectFieldGetter());
}

// Declares member function (index field value getter)
// const(Entity!mdTarget) get##Name() const { ... }
// bool null##Name() const { ... }
private mixin template DeclIndexField(alias md, string Name, alias mdTarget)
{
    enum injectFieldGetter = ()
    {
        immutable string tableType = "MDTableType." ~ md.stringof;
        immutable string columnValueType = "Row!(" ~ tableType ~ ")." ~ Name ~ "ValueType";
        immutable string columnValueTypeAlias = Name ~ "ColumnValueType";

        immutable string targetTableType = "MDTableType." ~ mdTarget.stringof;

        immutable string extractorType = "IndexFieldValueExtractor!(" ~ columnValueType ~ ", " ~ targetTableType ~ ")";
        immutable string extractorTypeAlias = Name ~ "FieldValueExtractorType";

        string decl = "";
        decl ~= "public alias " ~ columnValueTypeAlias ~ " = " ~ columnValueType ~ ";\n";
        decl ~= "static assert(" ~ columnValueTypeAlias ~ ".Kind == ValueKind.Index);\n";
        decl ~= "public alias " ~ extractorTypeAlias ~ " = " ~ extractorType ~ ";\n";

        decl ~= "public auto get" ~ Name ~ "() const\n";
        decl ~= "{ return " ~ extractorTypeAlias ~ "(db).getValue(row.get" ~ Name ~ "());" ~ " }\n";

        decl ~= "public bool null" ~ Name ~ "() const\n";
        decl ~= "{\n";
        decl ~= "  const auto columnValue = row.get" ~ Name ~ "();\n";
        decl ~= "  return columnValue == 0 || columnValue > db.getTable!(" ~ targetTableType ~ ")().rowCount;\n";
        decl ~= "}\n";

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
// GetSimpleFieldValueType!(ValueType!(T, K)) get##Name() const { ... }
//
// Example for string field 'Name' at 'module_' table:
//
// public alias NameColumnValueType = Row!(MDTableType.module_).NameValueType; // == Value!(MDTableType.module_, ValueKind.String)
// public alias NameFieldValueExtractorType = FieldValueExtractor!(NameColumnValueType);
// public auto getName() const // returns string because Row!(MDTableType.module_).NameValueType is Value(MDTableType.module_, ValueKind.String)
// {
//     return NameFieldValueExtractorType(db.heaps()).getValue(row.getName());
// }
private mixin template DeclSimpleField(alias md, string Name)
{
    enum injectFieldGetter = ()
    {
        immutable string tableType = "MDTableType." ~ md.stringof;

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

    static assert(is(GetSimpleFieldValueType!(ModuleEntity.UnusedColumnValueType) == ushort));
    static assert(is(GetSimpleFieldValueType!(ModuleEntity.NameColumnValueType) == string));
    static assert(is(GetSimpleFieldValueType!(ModuleEntity.MvidColumnValueType) == UUID));
    static assert(is(GetSimpleFieldValueType!(ModuleEntity.EncIdColumnValueType) == UUID));
    static assert(is(GetSimpleFieldValueType!(ModuleEntity.EncBaseIdColumnValueType) == UUID));
}

// value is Value<T, K>
struct FieldValueExtractor(value)
{
    public alias ReturnValueType = GetSimpleFieldValueType!(value);
    
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
template GetSimpleFieldValueType(value)
{
    static if (value.Kind == ValueKind.Integral)
    {
        alias GetSimpleFieldValueType = value.Type;
    } 
    else static if (value.Kind == ValueKind.Guid)
    {
        alias GetSimpleFieldValueType = UUID;
    }
    else static if (value.Kind == ValueKind.String)
    {
        alias GetSimpleFieldValueType = string;
    }
    else static if (value.Kind == ValueKind.Blob)
    {
        alias GetSimpleFieldValueType = const(ubyte)[];
    }
    else
    {
        alias GetSimpleFieldValueType = void;
    }
}

unittest
{
    alias Val1 = Value!(ushort, ValueKind.Integral);
    static assert(is(GetSimpleFieldValueType!(Val1) == ushort));

    alias Val2 = Value!(uint, ValueKind.String);
    static assert(is(GetSimpleFieldValueType!(Val2) == string));

    alias Val3 = Value!(uint, ValueKind.Guid);
    static assert(is(GetSimpleFieldValueType!(Val3) == UUID));

    alias Val4 = Value!(uint, ValueKind.Blob);
    static assert(is(GetSimpleFieldValueType!(Val4) == const(ubyte)[]));
}