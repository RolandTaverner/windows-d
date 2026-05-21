module climetadata.mdcollection.collection;

public import climetadata.mdtable.type;
import climetadata.mdtable.table : Table;
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

    // private const(Table!md*) getTable(MDTableType md)() const
    // {
    //     return db.getTable!(md)();
    // }

    // rowID is 1-based
    public Entity!md opIndex(uint rowID) const
    {
        return Entity!md((*table)[rowID], db);
    }

private:
    const Table!md* table;
    const Database* db;
}
