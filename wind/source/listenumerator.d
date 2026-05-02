module listenumerator;

import metadata: Metadata;
public import md;

struct ListEnumerator(MD md)
{
    uint nextIndex;
    uint currentIndex;
    const(Metadata)* db;

    @disable this();
    this(const(Metadata)* db, uint startIndex, uint nextIndex)
    {
        this.db = db;        
        if (nextIndex == 0)
            nextIndex = db.getTable!md.rowCount + 1;
        this.nextIndex = nextIndex;
        currentIndex = startIndex;
    }

    pragma(inline, true);
    bool empty()
    {
        return currentIndex >= nextIndex;
    }

    pragma(inline, true);
    void popFront()
    {
        ++currentIndex;
    }

    pragma(inline, true);
    auto front()
    {
        return db.getTable!md[currentIndex];
    }


}
