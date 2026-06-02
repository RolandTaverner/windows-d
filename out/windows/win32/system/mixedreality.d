// Written in the D programming language.

module windows.win32.system.mixedreality;

public import windows.core;

extern(Windows) @nogc nothrow:


// Constants


enum GUID PERCEPTIONFIELD_StateStream_TimeStamps = GUID("aa886119-f32f-49bf-92ca-f9ddf784d297");

// Structs


struct PERCEPTION_PAYLOAD_FIELD
{
    GUID FieldId;
    uint OffsetInBytes;
    uint SizeInBytes;
}

struct PERCEPTION_STATE_STREAM_TIMESTAMPS
{
    long InputTimestampInQpcCounts;
    long AvailableTimestampInQpcCounts;
}

