module climetadata.mdcollection.database;

import climetadata.mdtable.heaps : Heaps;
import climetadata.mdtable.tables : Tables;

struct Database
{
    @disable this();

    public this(const Tables* tables, const Heaps* heaps)
    {
        this.tables = tables;
        this.heaps = heaps;
    }

private:
    const Tables* tables;
    const Heaps* heaps;
}
