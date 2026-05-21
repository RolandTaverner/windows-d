module metadata;

public import std.typecons : Nullable;
public import std.variant: Algebraic;
public import std.uuid : UUID;

import std.exception: enforce;
import std.format: format;
import std.algorithm: startsWith, endsWith;
import std.string: toStringz;

public import md;
public import table: Table;
public import row: Row;
public import rowtypes;
import bits;
public import attributes;
public import sig;
import compositeindex;
import reader;
import convert;
import listenumerator;


public struct Metadata
{
    @disable this();

    public this(string path)
    {
        fileMap = FileMap(path);
        enforce(fileMap.size() > ImageDosHeader.sizeof, "File is too small to be a PE format file");

        auto m = fileMap.memory();

        auto dos = asRef!ImageDosHeader(m);

        enforce(dos.e_signature == 0x5a4d, format("Invalid PE signature (0x%04X)", dos.e_signature));
        enforce(fileMap.size > dos.e_lfanew + ImageNTHeaders32.sizeof, "Invalid file size");

        auto pe = asRef!ImageNTHeaders32(m, dos.e_lfanew);
        enforce(pe.fileHeader.numberOfSections > 0 && pe.fileHeader.numberOfSections <= 100, 
                format("Invalid number of sections (%d)", pe.fileHeader.numberOfSections));

        const(ImageSectionHeader)[]sections;
        uint comVA;
        if (pe.optionalHeader.magic == 0x10b)
        {
            comVA = pe.optionalHeader.dataDirectory[14].virtualAddress;
            sections = asArray!(ImageSectionHeader)(m, dos.e_lfanew + ImageNTHeaders32.sizeof);
        }
        else
        {   
            auto pe2 = asRef!ImageNTHeaders32Plus(m, dos.e_lfanew);
            comVA = pe2.optionalHeader.dataDirectory[14].virtualAddress;
            sections = asArray!(ImageSectionHeader)(m, dos.e_lfanew + ImageNTHeaders32Plus.sizeof);
        }

        sections.length = pe.fileHeader.numberOfSections;

        ImageSectionHeader section;
        enforce(sectionFromRVA(sections, comVA, section), "CLI header is missing");

        auto offset = offsetFromRVA(section, comVA);
        auto cli = asRef!ImageCor20Header(m, offset);
        enforce(cli.cb == ImageCor20Header.sizeof, 
                format("Invalid CLI header size (%d bytes)", cli.cb));

        enforce(sectionFromRVA(sections, cli.metaData.virtualAddress, section), "CLI metadata is missing");

        offset = offsetFromRVA(section, cli.metaData.virtualAddress);
        enforce(asVal!uint(m, offset) == 0x424a5342u, 
                format("Invalid CLI metadata signature (0x%08X)", asVal!uint(m, offset)));

        auto vlen = asVal!uint(m, offset + 12);
        auto streamCount = asVal!ushort(m, offset + vlen + 18);
        auto view = m[offset + vlen + 20 .. $];

        for (size_t i; i < streamCount; ++i)
        {
            auto stream = asRef!StreamRange(view);
            auto name = asString(view, 8);

            if (name == "#Strings")            
                strings = m[offset + stream.offset .. offset + stream.offset + stream.size];
            else if (name == "#Blob")            
                blobs = m[offset + stream.offset .. offset + stream.offset + stream.size];
            else if (name == "#GUID")            
                guids = m[offset + stream.offset .. offset + stream.offset + stream.size];
            else if (name == "#~")            
                tables = m[offset + stream.offset .. offset + stream.offset + stream.size];
            else  
                enforce(name == "#US", "Unknown metadata stream (%s)", name);

            uint padding = 4 - name.length % 4;
            if (!padding)
                padding = 4;
            view = view[name.length + 8 + padding .. $];
        }        

        auto bits = asVal!ubyte(tables, 6);
        ubyte stringIndexSize = (bits & 0x01) == 0x01 ? 4 : 2;
        ubyte guidIndexSize = (bits & 0x02) == 0x02 ? 4 : 2;  
        ubyte blobIndexSize = (bits & 0x04) == 0x04 ? 4 : 2;

        ulong validBits = asVal!ulong(tables, 8);

        view = tables[24 .. $];

        uint[MD.unknown] rowCounts;

        for (ubyte i; i < 64; ++i)
        {
            auto md = getMDfromIndex(i);

            if ((validBits & 1UL) ==  1UL)
            {
                enforce(md != MD.unknown, format("Unknown metadata table (0x%02x)", i));
                rowCounts[md] = asVal!uint(view);
                view = view[4 .. $];

                debug
                {
                    import std.conv;
                    import std.stdio;

                    writeln(i, " ", md.to!string, " rows ", rowCounts[md]);
                }
            }
            validBits >>= 1;
        }

        auto typeDefOrRefIndexSize 
            = compositeIndexSize(rowCounts[MD.typeDef], rowCounts[MD.typeRef], rowCounts[MD.typeSpec]);
        auto hasConstantIndexSize 
            = compositeIndexSize(rowCounts[MD.field], rowCounts[MD.param], rowCounts[MD.property]);
        auto hasCustomAttributeIndexSize 
            = compositeIndexSize(rowCounts[MD.methodDef], rowCounts[MD.field], rowCounts[MD.typeRef], 
                                 rowCounts[MD.typeDef], rowCounts[MD.param], rowCounts[MD.interfaceImpl], 
                                 rowCounts[MD.memberRef], rowCounts[MD.module_], rowCounts[MD.property], 
                                 rowCounts[MD.event], rowCounts[MD.standAloneSig], rowCounts[MD.moduleRef], 
                                 rowCounts[MD.typeSpec], rowCounts[MD.assembly], rowCounts[MD.assemblyRef], 
                                 rowCounts[MD.file], rowCounts[MD.exportedType], rowCounts[MD.manifestResource],
                                 rowCounts[MD.genericParam], rowCounts[MD.genericParamConstraint], 
                                 rowCounts[MD.methodSpec]);
        auto hasFieldMarshalIndexSize 
            = compositeIndexSize(rowCounts[MD.field], rowCounts[MD.param]);
        auto hasDeclSecurityIndexSize 
            = compositeIndexSize(rowCounts[MD.typeDef], rowCounts[MD.methodDef], rowCounts[MD.assembly]);
        auto memberRefParentIndexSize 
            = compositeIndexSize(rowCounts[MD.typeDef], rowCounts[MD.typeRef], rowCounts[MD.moduleRef], 
                                 rowCounts[MD.methodDef], rowCounts[MD.typeSpec]);
        auto hasSemanticsIndexSize 
            = compositeIndexSize(rowCounts[MD.event], rowCounts[MD.property]);
        auto methodDefOrRefIndexSize 
            = compositeIndexSize(rowCounts[MD.methodDef], rowCounts[MD.memberRef]);
        auto memberForwardedIndexSize 
            = compositeIndexSize(rowCounts[MD.field], rowCounts[MD.methodDef]);
        auto implementationIndexSize 
            = compositeIndexSize(rowCounts[MD.file], rowCounts[MD.assemblyRef], rowCounts[MD.exportedType]);
        auto customAttributeTypeIndexSize 
            = compositeIndexSize(rowCounts[MD.methodDef], rowCounts[MD.memberRef], 0, 0, 0);
        auto resolutionScopeIndexSize 
            = compositeIndexSize(rowCounts[MD.module_], rowCounts[MD.moduleRef], 
                                 rowCounts[MD.assemblyRef],  rowCounts[MD.typeRef]);
        auto typeOrMethodDefIndexSize 
            = compositeIndexSize(rowCounts[MD.typeDef], rowCounts[MD.methodDef]);

        //typeRefTable = Table!(MD.module_)();

        moduleTable 
            = Table!(MD.module_)(&this, rowCounts[MD.module_], view, 2, stringIndexSize,
                                 guidIndexSize, guidIndexSize, guidIndexSize);
        typeRefTable 
            = Table!(MD.typeRef)(&this, rowCounts[MD.typeRef], view, 
                                 resolutionScopeIndexSize, stringIndexSize, stringIndexSize);
        typeDefTable 
            = Table!(MD.typeDef)(&this, rowCounts[MD.typeDef], view, 4, 
                                 stringIndexSize, stringIndexSize, typeDefOrRefIndexSize, 
                                 indexSize(rowCounts[MD.field]), indexSize(rowCounts[MD.methodDef]));
        fieldTable 
            = Table!(MD.field)(&this, rowCounts[MD.field], view, 2, stringIndexSize, blobIndexSize);
        methodDefTable 
            = Table!(MD.methodDef)(&this, rowCounts[MD.methodDef], view, 4, 2, 2, 
                                   stringIndexSize, blobIndexSize, indexSize(rowCounts[MD.param]));
        paramTable 
            = Table!(MD.param)(&this, rowCounts[MD.param], view, 2, 2, stringIndexSize);
        interfaceImplTable 
            = Table!(MD.interfaceImpl)(&this, rowCounts[MD.interfaceImpl], view, 
                                       indexSize(rowCounts[MD.typeDef]), typeDefOrRefIndexSize);
        memberRefTable 
            = Table!(MD.memberRef)(&this, rowCounts[MD.memberRef], view,
                                   memberRefParentIndexSize, stringIndexSize, blobIndexSize);
        constantTable 
            = Table!(MD.constant)(&this, rowCounts[MD.constant], view, 2, hasConstantIndexSize, blobIndexSize);    
        customAttributeTable 
            = Table!(MD.customAttribute)(&this, rowCounts[MD.customAttribute], view, 
                                         hasCustomAttributeIndexSize, customAttributeTypeIndexSize, blobIndexSize);
        fieldMarshalTable 
            = Table!(MD.fieldMarshal)(&this, rowCounts[MD.fieldMarshal], view, 
                                          hasFieldMarshalIndexSize, blobIndexSize);
        declSecurityTable 
            = Table!(MD.declSecurity)(&this, rowCounts[MD.declSecurity], view, 2,
                                      hasDeclSecurityIndexSize, blobIndexSize);
        classLayoutTable 
            = Table!(MD.classLayout)(&this, rowCounts[MD.classLayout], view, 2, 4, indexSize(rowCounts[MD.typeDef]));
        fieldLayoutTable 
            = Table!(MD.fieldLayout)(&this, rowCounts[MD.fieldLayout], view, 4, indexSize(rowCounts[MD.field]));
        standAloneSigTable 
            = Table!(MD.standAloneSig)(&this, rowCounts[MD.standAloneSig], view, blobIndexSize);
        eventMapTable 
            = Table!(MD.eventMap)(&this, rowCounts[MD.eventMap], view, 
                                  indexSize(rowCounts[MD.typeDef]), indexSize(rowCounts[MD.event]));
        eventTable 
            = Table!(MD.event)(&this, rowCounts[MD.event], view, 2, stringIndexSize, typeDefOrRefIndexSize);
        propertyMapTable 
            = Table!(MD.propertyMap)(&this, rowCounts[MD.propertyMap], view,
                                     indexSize(rowCounts[MD.typeDef]), indexSize(rowCounts[MD.property]));
        propertyTable 
            = Table!(MD.property)(&this, rowCounts[MD.property], view, 2, stringIndexSize, blobIndexSize);
        methodSemanticsTable 
            = Table!(MD.methodSemantics)(&this, rowCounts[MD.methodSemantics], view, 2,
                                         indexSize(rowCounts[MD.methodDef]), hasSemanticsIndexSize);
        methodImplTable 
            = Table!(MD.methodImpl)(&this, rowCounts[MD.methodImpl], view, 
                                   indexSize(rowCounts[MD.typeDef]), methodDefOrRefIndexSize, methodDefOrRefIndexSize);
        moduleRefTable 
            = Table!(MD.moduleRef)(&this, rowCounts[MD.moduleRef], view, stringIndexSize);
        typeSpecTable 
            = Table!(MD.typeSpec)(&this, rowCounts[MD.typeSpec], view, blobIndexSize);
        implMapTable 
            = Table!(MD.implMap)(&this, rowCounts[MD.implMap], view, 2,
                                 memberForwardedIndexSize, stringIndexSize, indexSize(rowCounts[MD.moduleRef]));
        fieldRVATable 
            = Table!(MD.fieldRVA)(&this, rowCounts[MD.fieldRVA], view, 4, indexSize(rowCounts[MD.field]));
        assemblyTable 
            = Table!(MD.assembly)(&this, rowCounts[MD.assembly], view, 4, 8, 4, 
                                  blobIndexSize, stringIndexSize, stringIndexSize);
        assemblyProcessorTable 
            = Table!(MD.assemblyProcessor)(&this, rowCounts[MD.assemblyProcessor], view, 4);
        assemblyOSTable 
            = Table!(MD.assemblyOS)(&this, rowCounts[MD.assemblyOS], view, 4, 4, 4);
        assemblyRefTable 
            = Table!(MD.assemblyRef)(&this, rowCounts[MD.assemblyRef], view, 8, 4, 
                                     blobIndexSize, stringIndexSize, stringIndexSize, blobIndexSize);
        assemblyRefProcessorTable 
            = Table!(MD.assemblyRefProcessor)(&this, rowCounts[MD.assemblyRefProcessor], view, 4,
                                              indexSize(rowCounts[MD.assemblyRef]));
        assemblyRefOSTable 
            = Table!(MD.assemblyRefOS)(&this, rowCounts[MD.assemblyRefOS], view, 4, 4, 4, 
                                       indexSize(rowCounts[MD.assemblyRef]));
        fileTable 
            = Table!(MD.file)(&this, rowCounts[MD.file], view, 4,  stringIndexSize, blobIndexSize);        
        exportedTypeTable 
            = Table!(MD.exportedType)(&this, rowCounts[MD.exportedType], view, 4, 4, stringIndexSize,
                                      stringIndexSize, implementationIndexSize);
        manifestResourceTable 
            = Table!(MD.manifestResource)(&this, rowCounts[MD.manifestResource], view, 4, 4, 
                                          stringIndexSize, implementationIndexSize);
        nestedClassTable 
            = Table!(MD.nestedClass)(&this, rowCounts[MD.nestedClass], view, 
                                     indexSize(rowCounts[MD.typeDef]), indexSize(rowCounts[MD.typeDef]));
        genericParamTable 
            = Table!(MD.genericParam)(&this, rowCounts[MD.genericParam], view, 2, 2,
                                          typeOrMethodDefIndexSize, stringIndexSize);
        methodSpecTable 
            = Table!(MD.methodSpec)(&this, rowCounts[MD.methodSpec], view, methodDefOrRefIndexSize, blobIndexSize);
        genericParamConstraintTable 
            = Table!(MD.genericParamConstraint)(&this, rowCounts[MD.genericParamConstraint], view, 
                                                    indexSize(rowCounts[MD.genericParam]), typeDefOrRefIndexSize);   
        

    }


    private const(ubyte)[] strings;
    private const(ubyte)[] blobs;
    private const(ubyte)[] guids;
    private const(ubyte)[] tables;
    private FileMap fileMap;

    public Table!(MD.module_)                moduleTable;
    public Table!(MD.typeRef)                typeRefTable;
    public Table!(MD.typeDef)                typeDefTable;
    public Table!(MD.field)                  fieldTable;
    public Table!(MD.methodDef)              methodDefTable;
    public Table!(MD.param)                  paramTable;
    public Table!(MD.interfaceImpl)          interfaceImplTable;
    public Table!(MD.memberRef)              memberRefTable;
    public Table!(MD.constant)               constantTable;
    public Table!(MD.customAttribute)        customAttributeTable;
    public Table!(MD.fieldMarshal)           fieldMarshalTable;
    public Table!(MD.declSecurity)           declSecurityTable;
    public Table!(MD.classLayout)            classLayoutTable;
    public Table!(MD.fieldLayout)            fieldLayoutTable;
    public Table!(MD.standAloneSig)          standAloneSigTable;
    public Table!(MD.eventMap)               eventMapTable;
    public Table!(MD.event)                  eventTable;
    public Table!(MD.propertyMap)            propertyMapTable;
    public Table!(MD.property)               propertyTable;
    public Table!(MD.methodSemantics)        methodSemanticsTable;
    public Table!(MD.methodImpl)             methodImplTable;
    public Table!(MD.moduleRef)              moduleRefTable;
    public Table!(MD.typeSpec)               typeSpecTable;
    public Table!(MD.implMap)                implMapTable;
    public Table!(MD.fieldRVA)               fieldRVATable;
    public Table!(MD.assembly)               assemblyTable;
    public Table!(MD.assemblyProcessor)      assemblyProcessorTable;
    public Table!(MD.assemblyOS)             assemblyOSTable;
    public Table!(MD.assemblyRef)            assemblyRefTable;
    public Table!(MD.assemblyRefProcessor)   assemblyRefProcessorTable;
    public Table!(MD.assemblyRefOS)          assemblyRefOSTable;
    public Table!(MD.file)                   fileTable;
    public Table!(MD.exportedType)           exportedTypeTable;
    public Table!(MD.manifestResource)       manifestResourceTable;
    public Table!(MD.nestedClass)            nestedClassTable;
    public Table!(MD.genericParam)           genericParamTable;
    public Table!(MD.methodSpec)             methodSpecTable;
    public Table!(MD.genericParamConstraint) genericParamConstraintTable;


    public template getTable(MD md)
    {
        static if (md == MD.module_) alias getTable =                      moduleTable;
        else static if (md == MD.typeRef) alias getTable =                 typeRefTable;
        else static if (md == MD.typeDef) alias getTable =                 typeDefTable;
        else static if (md == MD.field) alias getTable =                   fieldTable;
        else static if (md == MD.methodDef) alias getTable =               methodDefTable;
        else static if (md == MD.param) alias getTable =                   paramTable;
        else static if (md == MD.interfaceImpl) alias getTable =           interfaceImplTable;
        else static if (md == MD.memberRef) alias getTable =               memberRefTable;
        else static if (md == MD.constant) alias getTable =                constantTable;
        else static if (md == MD.customAttribute) alias getTable =         customAttributeTable;
        else static if (md == MD.fieldMarshal) alias getTable =            fieldMarshalTable;
        else static if (md == MD.declSecurity) alias getTable =            declSecurityTable;
        else static if (md == MD.classLayout) alias getTable =             classLayoutTable;
        else static if (md == MD.fieldLayout) alias getTable =             fieldLayoutTable;
        else static if (md == MD.standAloneSig) alias getTable =           standAloneSigTable;
        else static if (md == MD.eventMap) alias getTable =                eventMapTable;
        else static if (md == MD.event) alias getTable =                   eventTable;
        else static if (md == MD.propertyMap) alias getTable =             propertyMapTable;
        else static if (md == MD.property) alias getTable =                propertyTable;
        else static if (md == MD.methodSemantics) alias getTable =         methodSemanticsTable;
        else static if (md == MD.methodImpl) alias getTable =              methodImplTable;
        else static if (md == MD.moduleRef) alias getTable =               moduleRefTable;
        else static if (md == MD.typeSpec) alias getTable =                typeSpecTable;
        else static if (md == MD.implMap) alias getTable =                 implMapTable;
        else static if (md == MD.fieldRVA) alias getTable =                fieldRVATable;
        else static if (md == MD.assembly) alias getTable =                assemblyTable;
        else static if (md == MD.assemblyProcessor) alias getTable =       assemblyProcessorTable;
        else static if (md == MD.assemblyOS) alias getTable =              assemblyOSTable;
        else static if (md == MD.assemblyRef) alias getTable =             assemblyRefTable;
        else static if (md == MD.assemblyRefProcessor) alias getTable =    assemblyRefProcessorTable;
        else static if (md == MD.assemblyRefOS) alias getTable =           assemblyRefOSTable;
        else static if (md == MD.file) alias getTable =                    fileTable;
        else static if (md == MD.exportedType) alias getTable =            exportedTypeTable;
        else static if (md == MD.manifestResource) alias getTable =        manifestResourceTable;
        else static if (md == MD.nestedClass) alias getTable =             nestedClassTable;
        else static if (md == MD.genericParam) alias getTable =            genericParamTable;
        else static if (md == MD.methodSpec) alias getTable =              methodSpecTable;
        else static if (md == MD.genericParamConstraint) alias getTable =  genericParamConstraintTable;
        else static assert(false, "Unsupported table");
    }

    public string getString(uint offset) const
    {
        return asString(strings, offset);
    }

    public const(ubyte)[] getBlob(uint offset) const
    {
        auto blob = blobs[offset .. $];
        auto size = readCompressed(blob);
        return blob[0 .. size];
    }

    public UUID getGUID(uint index) const
    {        
        if (!index)
            return UUID.init;
        --index;
        return asRef!UUID(guids[index * UUID.sizeof .. index * UUID.sizeof + UUID.sizeof]);
    }

    public auto getRange(MD md)(uint sourceIndex, ubyte targetColumn) const
    {
        return RangeEnumerator!md(&this, sourceIndex, targetColumn);
    }

    public auto getAll(MD md)(uint sourceIndex, ubyte targetColumn) const
    {
        return RandomEnumerator!md(&this, sourceIndex, targetColumn);
    }

    public auto getRange(MD md, T)(CompositeIndex!T sourceIndex, ubyte targetColumn) const
    {
        return CompositeRangeEnumerator!(md, T)(&this, sourceIndex, targetColumn);
    }

    public auto findFirstRequired(MD md)(uint sourceIndex, ubyte targetColumn) const
    {
        auto r = findFirst!md(sourceIndex, targetColumn);
        enforce(!r.isNull, format("Missing %s reference (%d)", md.stringof, sourceIndex));
        return r.get;
    }

    public auto findFirstRequired(MD md, T)(CompositeIndex!T sourceIndex, ubyte targetColumn) const
    {
        auto r = findFirst!(md, T)(sourceIndex, targetColumn);
        enforce(!r.isNull, format("Missing %s reference (%d)", md.stringof, sourceIndex.index));
        return r.get;
    }

    public auto findFirst(MD md)(uint sourceIndex, ubyte targetColumn) const
    {
        alias NullableResult = Nullable!(Row!md);
        uint targetRow;
        while (targetRow < getTable!md.rowCount)
        {
            if (getTable!md.getValue!uint(targetRow, targetColumn) == sourceIndex)
                return NullableResult(getTable!md[targetRow + 1]);
            ++targetRow;
        }
        return NullableResult.init;
    }

    public auto findFirst(MD md, T)(CompositeIndex!T sourceIndex, ubyte targetColumn) const
    {
        alias NullableResult = Nullable!(Row!md);
        uint targetRow;
        while (targetRow < getTable!md.rowCount)
        {
            if (getTable!md.getCompositeIndex!T(targetRow, targetColumn).codedIndex == sourceIndex.codedIndex)
                return NullableResult(getTable!md[targetRow + 1]);
            ++targetRow;
        }
        return NullableResult.init;
    }

    public auto getList(MD md)(uint startIndex, uint nextIndex) const
    {
        assert(startIndex);
        return ListEnumerator!md(&this, startIndex, nextIndex);
    }

    public Nullable!TypeDef findByName(string typeName) const
    {
        foreach(r; typeDefTable.items)
        {
            auto name = r.name;
            auto namespace = r.namespace;
            if (typeName.length == name.length + namespace.length + 1 && typeName.startsWith(r.namespace) && typeName.endsWith(r.name))
                return Nullable!TypeDef(r);
        }
        return (Nullable!TypeDef).init;
     }

    public Nullable!TypeDef findByName(string ns, string nm) const
    {
        foreach(r; typeDefTable.items)
        {
            auto name = r.name;
            auto namespace = r.namespace;
            if (ns == namespace && nm == name)
                return Nullable!TypeDef(r);
        }
        return (Nullable!TypeDef).init;
    }
    
}



private struct RangeEnumerator(MD md)
{
    const(Metadata)* db;
    uint sourceIndex;
    uint targetRow;
    uint targetColumn;    


    @disable this();

    this(const(Metadata)* db, uint sourceIndex, uint targetColumn)
    {
        this.db = db;
        this.sourceIndex = sourceIndex;
        this.targetColumn = targetColumn;
        targetRow = 0;
        while (targetRow < db.getTable!md.rowCount)
        {
            auto targetIndex = db.getTable!md.getValue!uint(targetRow, targetColumn);
            if (targetIndex == sourceIndex)
                break;
            ++targetRow;
        }
    }

    pragma(inline, true)
        bool empty() const
        {        
            return targetRow >= db.getTable!md.rowCount 
                || db.getTable!md.getValue!uint(targetRow, targetColumn) != sourceIndex;
        }

    pragma(inline, true)
        void popFront()
        {
            ++targetRow;       
        }

    pragma(inline, true)
        auto front()
        {
            return db.getTable!md[targetRow + 1];        
        }
}

private struct CompositeRangeEnumerator(MD md, T)
{
    const(Metadata)* db;
    CompositeIndex!T sourceIndex;
    uint targetRow;
    uint targetColumn;    


    @disable this();

    this(const(Metadata)* db, CompositeIndex!T sourceIndex, uint targetColumn)
    {
        this.db = db;
        this.sourceIndex = sourceIndex;
        this.targetColumn = targetColumn;
        targetRow = 0;
        while (targetRow < db.getTable!md.rowCount)
        {
            auto targetIndex = db.getTable!md.getCompositeIndex!T(targetRow, targetColumn);
            if (targetIndex.codedIndex == sourceIndex.codedIndex)
                break;
            ++targetRow;
        }
    }

    pragma(inline, true)
        bool empty() const
        {
            return targetRow >= db.getTable!md.rowCount 
                || db.getTable!md.getCompositeIndex!T(targetRow, targetColumn).codedIndex != sourceIndex.codedIndex;
        }

    pragma(inline, true)
        void popFront()
        {
            ++targetRow;       
        }

    pragma(inline, true)
        auto front()
        {
            return db.getTable!md[targetRow + 1];        
        }
}

private struct RandomEnumerator(MD md)
{
    const(Metadata)* db;
    uint sourceIndex;
    uint targetRow;
    uint targetColumn;    


    @disable this();

    this(const(Metadata)* db, uint sourceIndex, uint targetColumn)
    {
        this.db = db;
        this.sourceIndex = sourceIndex;
        this.targetColumn = targetColumn;
        targetRow = 0;
        while (targetRow < db.getTable!md.rowCount)
        {
            auto targetIndex = db.getTable!md.getValue!uint(targetRow, targetColumn);
            if (targetIndex == sourceIndex)
                break;
            ++targetRow;
        }
    }

    pragma(inline, true)
        bool empty() const
        {        
            return targetRow >= db.getTable!md.rowCount;
        }

    pragma(inline, true)
        void popFront()
        {
            ++targetRow; 
            while (targetRow < db.getTable!md.rowCount)
            {
                auto targetIndex = db.getTable!md.getValue!uint(targetRow, targetColumn);
                if (targetIndex == sourceIndex)
                    break;
                ++targetRow;
            }
        }

    pragma(inline, true)
        auto front()
        {
            return db.getTable!md[targetRow + 1];        
        }
}

private bool sectionFromRVA(const(ImageSectionHeader)[] sections, uint rva, ref ImageSectionHeader section)
{
    for (size_t i; i < sections.length; ++i)
    {
        if (sections[i].virtualAddress <= rva && sections[i].virtualAddress + sections[i].virtualSize > rva)
        {
            section = sections[i];
            return true;
        }
    }
    return false;    
}

private uint offsetFromRVA(ref const ImageSectionHeader section, uint rva)
{
    return rva - section.virtualAddress + section.pointerToRawData;
}

private struct StreamRange
{
    uint offset;
    uint size;
}

private MD getMDfromIndex(ubyte index)
{
    switch (index)
    {
        case 0x00: return MD.module_;
        case 0x01: return MD.typeRef;
        case 0x02: return MD.typeDef;
        case 0x04: return MD.field;
        case 0x06: return MD.methodDef;
        case 0x08: return MD.param;
        case 0x09: return MD.interfaceImpl;
        case 0x0a: return MD.memberRef;
        case 0x0b: return MD.constant;
        case 0x0c: return MD.customAttribute;
        case 0x0d: return MD.fieldMarshal;
        case 0x0e: return MD.declSecurity;
        case 0x0f: return MD.classLayout;
        case 0x10: return MD.fieldLayout;
        case 0x11: return MD.standAloneSig;
        case 0x12: return MD.eventMap;
        case 0x14: return MD.event;
        case 0x15: return MD.propertyMap;
        case 0x17: return MD.property;
        case 0x18: return MD.methodSemantics;
        case 0x19: return MD.methodImpl;
        case 0x1a: return MD.moduleRef;
        case 0x1b: return MD.typeSpec;
        case 0x1c: return MD.implMap;
        case 0x1d: return MD.fieldRVA;
        case 0x20: return MD.assembly;
        case 0x21: return MD.assemblyProcessor;
        case 0x22: return MD.assemblyOS;
        case 0x23: return MD.assemblyRef;
        case 0x24: return MD.assemblyRefProcessor;
        case 0x25: return MD.assemblyRefOS;
        case 0x26: return MD.file;
        case 0x27: return MD.exportedType;
        case 0x28: return MD.manifestResource;
        case 0x29: return MD.nestedClass;
        case 0x2a: return MD.genericParam;
        case 0x2b: return MD.methodSpec;
        case 0x2c: return MD.genericParamConstraint;
        default: return MD.unknown;
    }
}

private ubyte bitsNeeded(R...)(R rowCounts)
{
    static if (R.length == 1)
    {
        auto rc = rowCounts[0];
        if (!rc)
            return 0;
        ubyte r = 1;
        --rc;
        while (rc >>= 1)
            ++r;
        return r;
    }
    else 
    {
        auto t1 = bitsNeeded(rowCounts[0]);
        auto t2 = bitsNeeded(rowCounts[1 .. $]);
        return t1 > t2 ? t1 : t2;
    }
}

private ubyte compositeIndexSize(R...)(R rowCounts)
{
    return (bitsNeeded(rowCounts) + bitsNeeded(R.length) <= 16) ? 2 : 4;
}


private ubyte indexSize(uint rowCount)
{
    return rowCount <= 0xffff ? 2 : 4;
}


version(Windows)
{
    private import core.sys.windows.winbase;
    private import core.sys.windows.winnt;
    private import std.utf;
}
else version(Posix)
{
    private import core.sys.posix.fcntl;
    private import core.sys.posix.sys.mman;
    private import core.sys.posix.sys.stat;
    private import core.sys.posix.unistd;
}

import std.exception;
private import std.format;

struct FileMap
{
private:
    version(Windows)
    {
        HANDLE fileHandle = INVALID_HANDLE_VALUE;
        HANDLE mapHandle = INVALID_HANDLE_VALUE;
    } 
    else version(Posix)
    {
        int fileDescriptor = -1;
    }

    const(ubyte)* m_memory;
    size_t m_size;

public:   
    this(string fileName)
    {
        version(Windows)
        {   
            fileHandle = CreateFileW(toUTF16z(fileName), GENERIC_READ, FILE_SHARE_READ, null, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, null);
            if (fileHandle == INVALID_HANDLE_VALUE)
            {
                auto err = GetLastError();
            }
            enforce(fileHandle != INVALID_HANDLE_VALUE, format("Cannot open file '%s'", fileName));
            LARGE_INTEGER sz;
            GetFileSizeEx(fileHandle, &sz);
            m_size = cast(size_t)(sz.QuadPart);
            if (m_size > 0)
            {
                mapHandle = CreateFileMappingW(fileHandle, null, PAGE_READONLY, 0, 0, null);
                enforce(mapHandle != INVALID_HANDLE_VALUE, format("Cannot map file '%s' into memory", fileName));
                m_memory = cast(ubyte*)MapViewOfFileEx(mapHandle, FILE_MAP_READ, 0, 0, 0, null);
                enforce(m_memory, "Cannot read file ''%s'");
            }
        }
        else version(Posix)
        {
            fileDescriptor = .open(fileName.ptr, O_RDONLY, 0);
            enforce(fileHandle != -1, format("Cannot open file '%s'", fileName));
            stat_t stat;
            enforce(fstat(fd, &stat) >= 0, format("Cannot obtain file size for '%s'", fileName));
            m_size = cast(size_t)(stat.st_size);
            if (m_size > 0)
            {
                m_memory = mmap(null, size, PROT_READ, MAP_PRIVATE | MAP_POPULATE, fileDescriptor, 0);
                enforce(m_memory != MAP_FAILED, "Cannot read file ''%s'");
            }
        }
    }

    ~this()
    {
        version(Windows)
        {
            if (m_memory)
            {
                UnmapViewOfFile(m_memory);
                m_memory = null;
            }
            if (mapHandle != INVALID_HANDLE_VALUE)
            {
                CloseHandle(mapHandle);
                mapHandle = INVALID_HANDLE_VALUE;
            }
            if (fileHandle != INVALID_HANDLE_VALUE)
            {
                CloseHandle(fileHandle);
                fileHandle = INVALID_HANDLE_VALUE;
            }
        } 
        else version(Posix)
        {
            if (m_memory)
                munmap(memory, size);
            if (fileDescriptor != -1)
                .close(fileDescriptor);
        }
    }

    const(ubyte)[] memory() const
    {
        return m_memory[0 .. m_size];
    }

    size_t size() const
    {
        return cast(size_t)m_size;
    }
}

struct ImageDosHeader
{
    ushort      e_signature;
    ushort      e_cblp;
    ushort      e_cp;
    ushort      e_crlc;
    ushort      e_cparhdr;
    ushort      e_minalloc;
    ushort      e_maxalloc;
    ushort      e_ss;
    ushort      e_sp;
    ushort      e_csum;
    ushort      e_ip;
    ushort      e_cs;
    ushort      e_lfarlc;
    ushort      e_ovno;
    ushort[4]   e_res;
    ushort      e_oemid;
    ushort      e_oeminfo;
    ushort[10]  e_res2;
    int         e_lfanew;
}

struct ImageFileHeader
{
    ushort  machine;
    ushort  numberOfSections;
    uint    timeDateStamp;
    uint    pointerToSymbolTable;
    uint    numberOfSymbols;
    ushort  sizeOfOptionalHeader;
    ushort  characteristics;
}

struct ImageDataDirectory
{
    uint virtualAddress;
    uint size;
}

struct ImageOptionalHeader32
{
    ushort                  magic;
    ubyte                   majorLinkerVersion;
    ubyte                   minorLinkerVersion;
    uint                    sizeOfCode;
    uint                    sizeOfInitializedData;
    uint                    sizeOfUninitializedData;
    uint                    addressOfEntryPoint;
    uint                    baseOfCode;
    uint                    baseOfData;
    uint                    imageBase;
    uint                    sectionAlignment;
    uint                    fileAlignment;
    ushort                  majorOperatingSystemVersion;
    ushort                  minorOperatingSystemVersion;
    ushort                  majorImageVersion;
    ushort                  minorImageVersion;
    ushort                  majorSubsystemVersion;
    ushort                  minorSubsystemVersion;
    uint                    win32VersionValue;
    uint                    sizeOfImage;
    uint                    sizeOfHeaders;
    uint                    checkSum;
    ushort                  subsystem;
    ushort                  dllCharacteristics;
    uint                    sizeOfStackReserve;
    uint                    sizeOfStackCommit;
    uint                    sizeOfHeapReserve;
    uint                    sizeOfHeapCommit;
    uint                    loaderFlags;
    uint                    numberOfRvaAndSizes;
    ImageDataDirectory[16]  dataDirectory;
}

struct ImageNTHeaders32
{
    uint                    signature;
    ImageFileHeader         fileHeader;
    ImageOptionalHeader32   optionalHeader;
}

struct ImageOptionalHeader32Plus
{
    ushort                  magic;
    ubyte                   majorLinkerVersion;
    ubyte                   minorLinkerVersion;
    uint                    sizeOfCode;
    uint                    sizeOfInitializedData;
    uint                    sizeOfUninitializedData;
    uint                    addressOfEntryPoint;
    uint                    baseOfCode;
    ulong                   imageBase;
    uint                    sectionAlignment;
    uint                    fileAlignment;
    ushort                  majorOperatingSystemVersion;
    ushort                  minorOperatingSystemVersion;
    ushort                  majorImageVersion;
    ushort                  minorImageVersion;
    ushort                  majorSubsystemVersion;
    ushort                  minorSubsystemVersion;
    uint                    win32VersionValue;
    uint                    sizeOfImage;
    uint                    sizeOfHeaders;
    uint                    checkSum;
    ushort                  subsystem;
    ushort                  dllCharacteristics;
    ulong                   sizeOfStackReserve;
    ulong                   sizeOfStackCommit;
    ulong                   sizeOfHeapReserve;
    ulong                   sizeOfHeapCommit;
    uint                    loaderFlags;
    uint                    numberOfRvaAndSizes;
    ImageDataDirectory[16]  dataDirectory;
}

struct ImageNTHeaders32Plus
{
    uint                        signature;
    ImageFileHeader             fileHeader;
    ImageOptionalHeader32Plus   optionalHeader;
}

struct ImageSectionHeader 
{
    ubyte[8]    name;
    union
    {
        uint    physicalAddress;
        uint    virtualSize;
    }
    uint        virtualAddress;
    uint        sizeOfRawData;
    uint        pointerToRawData;
    uint        pointerToRelocations;
    uint        pointerToLinenumbers;
    ushort      numberOfRelocations;
    ushort      numberOfLinenumbers;
    uint        characteristics;
}

struct ImageCor20Header
{
    uint                cb;
    ushort              majorRuntimeVersion;
    ushort              minorRuntimeVersion;
    ImageDataDirectory  metaData;
    uint                flags;
    union
    {
        uint            entryPointToken;
        uint            entryPointRVA;
    }
    ImageDataDirectory  resources;
    ImageDataDirectory  strongNameSignature;
    ImageDataDirectory  codeManagerTable;
    ImageDataDirectory  vTableFixups;
    ImageDataDirectory  exportAddressTableJumps;
    ImageDataDirectory  managedNativeHeader;
}