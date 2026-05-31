// Written in the D programming language.

module windows.win32.system.memory.nonvolatile;

public import windows.core;

extern(Windows) @nogc nothrow:


// Structs


struct NV_MEMORY_RANGE
{
    void*  BaseAddress;
    size_t Length;
}

// Functions


version(X86_64)
{
    @DllImport("ntdll.dll")
uint RtlGetNonVolatileToken(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* NvBuffer, 
                                size_t Size, void** NvToken);
}

version(AArch64)
{
    @DllImport("ntdll.dll")
uint RtlGetNonVolatileToken(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* NvBuffer, 
                                size_t Size, void** NvToken);
}

version(X86_64)
{
    @DllImport("ntdll.dll")
uint RtlFreeNonVolatileToken(void* NvToken);
}

version(AArch64)
{
    @DllImport("ntdll.dll")
uint RtlFreeNonVolatileToken(void* NvToken);
}

version(X86_64)
{
    @DllImport("ntdll.dll")
uint RtlFlushNonVolatileMemory(void* NvToken, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* NvBuffer, 
                                   size_t Size, uint Flags);
}

version(AArch64)
{
    @DllImport("ntdll.dll")
uint RtlFlushNonVolatileMemory(void* NvToken, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* NvBuffer, 
                                   size_t Size, uint Flags);
}

version(X86_64)
{
    @DllImport("ntdll.dll")
uint RtlDrainNonVolatileFlush(void* NvToken);
}

version(AArch64)
{
    @DllImport("ntdll.dll")
uint RtlDrainNonVolatileFlush(void* NvToken);
}

version(X86_64)
{
    @DllImport("ntdll.dll")
uint RtlWriteNonVolatileMemory(void* NvToken, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* NvDestination, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(void)* Source, 
                                   size_t Size, uint Flags);
}

version(AArch64)
{
    @DllImport("ntdll.dll")
uint RtlWriteNonVolatileMemory(void* NvToken, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* NvDestination, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(void)* Source, 
                                   size_t Size, uint Flags);
}

version(X86_64)
{
    @DllImport("ntdll.dll")
uint RtlFillNonVolatileMemory(void* NvToken, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* NvDestination, 
                                  size_t Size, const(ubyte) Value, uint Flags);
}

version(AArch64)
{
    @DllImport("ntdll.dll")
uint RtlFillNonVolatileMemory(void* NvToken, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* NvDestination, 
                                  size_t Size, const(ubyte) Value, uint Flags);
}

version(X86_64)
{
    @DllImport("ntdll.dll")
uint RtlFlushNonVolatileMemoryRanges(void* NvToken, NV_MEMORY_RANGE* NvRanges, size_t NumRanges, uint Flags);
}

version(AArch64)
{
    @DllImport("ntdll.dll")
uint RtlFlushNonVolatileMemoryRanges(void* NvToken, NV_MEMORY_RANGE* NvRanges, size_t NumRanges, uint Flags);
}

