module climetadata.mdcollection.collection;

public import climetadata.mdtable.type;
import climetadata.mdtable.table : Table, TableListEnumerator;
import climetadata.mdcollection.database : Database;
import climetadata.mdcollection.entity : Entity;

struct Collection(MDTableType md)
{
    @disable this();

    public this(const Database* db)
    {
        this.table = db.getTable!(md);
        this.db = db;
    }

    // rowID is 1-based
    public Entity!md opIndex(uint rowID) const
    {
        return Entity!md((*table)[rowID], db);
    }

    public const(Table!md*) getTable() const
    {
        return table;
    }

    public CollectionListEnumerator!md items() const
    {
        return CollectionListEnumerator!md(table.items(), db);
    }

    public CollectionListEnumerator!md list(uint startRowID, uint endRowID) const
    {
        assert(startRowID);
        return CollectionListEnumerator!md(table.list(startRowID, endRowID), db);
    }

private:
    const Table!md* table;
    const Database* db;
}

// Wraps TableListEnumerator
public struct CollectionListEnumerator(MDTableType md)
{
    @disable this();
    
    public this(const TableListEnumerator!md tableEnumerator, const Database* db)
    {
        this.tableEnumerator = tableEnumerator;
        this.db = db;
    }

    pragma(inline, true);
    public bool empty() const
    {
        return tableEnumerator.empty();
    }

    pragma(inline, true);
    public void popFront()
    {
        tableEnumerator.popFront();
    }

    pragma(inline, true);
    public Entity!md front() const
    {
        return Entity!md(tableEnumerator.front(), db);
    }
    
private:
    TableListEnumerator!md tableEnumerator;
    const Database* db;
}
