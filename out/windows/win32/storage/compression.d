// Written in the D programming language.

module windows.win32.storage.compression;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL;

extern(Windows) @nogc nothrow:


// Enums


alias COMPRESS_ALGORITHM = uint;
enum : uint
{
    COMPRESS_ALGORITHM_MSZIP       = 0x00000002U,
    COMPRESS_ALGORITHM_XPRESS      = 0x00000003U,
    COMPRESS_ALGORITHM_XPRESS_HUFF = 0x00000004U,
    COMPRESS_ALGORITHM_LZMS        = 0x00000005U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/compressapi/ne-compressapi-compress_information_class
alias COMPRESS_INFORMATION_CLASS = int;
enum : int
{
    COMPRESS_INFORMATION_CLASS_INVALID    = 0x00000000,
    COMPRESS_INFORMATION_CLASS_BLOCK_SIZE = 0x00000001,
    COMPRESS_INFORMATION_CLASS_LEVEL      = 0x00000002,
}

// Constants


enum : uint
{
    COMPRESS_ALGORITHM_INVALID = 0x00000000U,
    COMPRESS_ALGORITHM_NULL    = 0x00000001U,
    COMPRESS_ALGORITHM_MAX     = 0x00000006U,
    COMPRESS_RAW               = 0x20000000U,
}

// Callbacks

alias PFN_COMPRESS_ALLOCATE = void* function(void* UserContext, size_t Size);
alias PFN_COMPRESS_FREE = void function(void* UserContext, void* Memory);

// Structs


@RAIIFree!CloseCompressor
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct COMPRESSOR_HANDLE
{
    void* Value;
}

@RAIIFree!CloseDecompressor
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct DECOMPRESSOR_HANDLE
{
    void* Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/compressapi/ns-compressapi-compress_allocation_routines
struct COMPRESS_ALLOCATION_ROUTINES
{
    PFN_COMPRESS_ALLOCATE Allocate;
    PFN_COMPRESS_FREE Free;
    void*             UserContext;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("Cabinet.dll")
BOOL CreateCompressor(COMPRESS_ALGORITHM Algorithm, COMPRESS_ALLOCATION_ROUTINES* AllocationRoutines, 
                      COMPRESSOR_HANDLE* CompressorHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("Cabinet.dll")
BOOL SetCompressorInformation(COMPRESSOR_HANDLE CompressorHandle, 
                              COMPRESS_INFORMATION_CLASS CompressInformationClass, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(void)* CompressInformation, 
                              size_t CompressInformationSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("Cabinet.dll")
BOOL QueryCompressorInformation(COMPRESSOR_HANDLE CompressorHandle, 
                                COMPRESS_INFORMATION_CLASS CompressInformationClass, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* CompressInformation, 
                                size_t CompressInformationSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("Cabinet.dll")
BOOL Compress(COMPRESSOR_HANDLE CompressorHandle, 
              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* UncompressedData, 
              size_t UncompressedDataSize, 
              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* CompressedBuffer, 
              size_t CompressedBufferSize, size_t* CompressedDataSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("Cabinet.dll")
BOOL ResetCompressor(COMPRESSOR_HANDLE CompressorHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("Cabinet.dll")
BOOL CloseCompressor(COMPRESSOR_HANDLE CompressorHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("Cabinet.dll")
BOOL CreateDecompressor(COMPRESS_ALGORITHM Algorithm, COMPRESS_ALLOCATION_ROUTINES* AllocationRoutines, 
                        DECOMPRESSOR_HANDLE* DecompressorHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("Cabinet.dll")
BOOL SetDecompressorInformation(DECOMPRESSOR_HANDLE DecompressorHandle, 
                                COMPRESS_INFORMATION_CLASS CompressInformationClass, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(void)* CompressInformation, 
                                size_t CompressInformationSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("Cabinet.dll")
BOOL QueryDecompressorInformation(DECOMPRESSOR_HANDLE DecompressorHandle, 
                                  COMPRESS_INFORMATION_CLASS CompressInformationClass, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* CompressInformation, 
                                  size_t CompressInformationSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("Cabinet.dll")
BOOL Decompress(DECOMPRESSOR_HANDLE DecompressorHandle, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* CompressedData, 
                size_t CompressedDataSize, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* UncompressedBuffer, 
                size_t UncompressedBufferSize, size_t* UncompressedDataSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("Cabinet.dll")
BOOL ResetDecompressor(DECOMPRESSOR_HANDLE DecompressorHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("Cabinet.dll")
BOOL CloseDecompressor(DECOMPRESSOR_HANDLE DecompressorHandle);


