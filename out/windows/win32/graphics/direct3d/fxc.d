// Written in the D programming language.

module windows.win32.graphics.direct3d.fxc;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : BOOL, HRESULT, PSTR, PWSTR;
public import windows.win32.graphics.direct3d : D3D_SHADER_MACRO, ID3DBlob, ID3DInclude;
public import windows.win32.graphics.direct3d10 : ID3D10Effect;
public import windows.win32.graphics.direct3d11 : ID3D11FunctionLinkingGraph, ID3D11Linker, ID3D11Module;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d3dcompiler/ne-d3dcompiler-d3dcompiler_strip_flags))], [])
alias D3DCOMPILER_STRIP_FLAGS = int;
enum : int
{
    D3DCOMPILER_STRIP_REFLECTION_DATA = 0x00000001,
    D3DCOMPILER_STRIP_DEBUG_INFO      = 0x00000002,
    D3DCOMPILER_STRIP_TEST_BLOBS      = 0x00000004,
    D3DCOMPILER_STRIP_PRIVATE_DATA    = 0x00000008,
    D3DCOMPILER_STRIP_ROOT_SIGNATURE  = 0x00000010,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d3dcompiler/ne-d3dcompiler-d3d_blob_part))], [])
alias D3D_BLOB_PART = int;
enum : int
{
    D3D_BLOB_INPUT_SIGNATURE_BLOB            = 0x00000000,
    D3D_BLOB_OUTPUT_SIGNATURE_BLOB           = 0x00000001,
    D3D_BLOB_INPUT_AND_OUTPUT_SIGNATURE_BLOB = 0x00000002,
    D3D_BLOB_PATCH_CONSTANT_SIGNATURE_BLOB   = 0x00000003,
    D3D_BLOB_ALL_SIGNATURE_BLOB              = 0x00000004,
    D3D_BLOB_DEBUG_INFO                      = 0x00000005,
    D3D_BLOB_LEGACY_SHADER                   = 0x00000006,
    D3D_BLOB_XNA_PREPASS_SHADER              = 0x00000007,
    D3D_BLOB_XNA_SHADER                      = 0x00000008,
    D3D_BLOB_PDB                             = 0x00000009,
    D3D_BLOB_PRIVATE_DATA                    = 0x0000000a,
    D3D_BLOB_ROOT_SIGNATURE                  = 0x0000000b,
    D3D_BLOB_DEBUG_NAME                      = 0x0000000c,
    D3D_BLOB_TEST_ALTERNATE_SHADER           = 0x00008000,
    D3D_BLOB_TEST_COMPILE_DETAILS            = 0x00008001,
    D3D_BLOB_TEST_COMPILE_PERF               = 0x00008002,
    D3D_BLOB_TEST_COMPILE_REPORT             = 0x00008003,
}

// Constants


enum : const(wchar)*
{
    D3DCOMPILER_DLL_W = "d3dcompiler_47.dll",
    D3DCOMPILER_DLL_A = "d3dcompiler_47.dll",
}

enum uint D3D_COMPILER_VERSION = 0x0000002f;

enum : uint
{
    D3DCOMPILE_DEBUG             = 0x00000001,
    D3DCOMPILE_SKIP_VALIDATION   = 0x00000002,
    D3DCOMPILE_SKIP_OPTIMIZATION = 0x00000004,
}

enum : uint
{
    D3DCOMPILE_PACK_MATRIX_ROW_MAJOR    = 0x00000008,
    D3DCOMPILE_PACK_MATRIX_COLUMN_MAJOR = 0x00000010,
}

enum uint D3DCOMPILE_PARTIAL_PRECISION = 0x00000020;

enum : uint
{
    D3DCOMPILE_FORCE_VS_SOFTWARE_NO_OPT = 0x00000040,
    D3DCOMPILE_FORCE_PS_SOFTWARE_NO_OPT = 0x00000080,
}

enum : uint
{
    D3DCOMPILE_NO_PRESHADER       = 0x00000100,
    D3DCOMPILE_AVOID_FLOW_CONTROL = 0x00000200,
}

enum uint D3DCOMPILE_PREFER_FLOW_CONTROL = 0x00000400;

enum : uint
{
    D3DCOMPILE_ENABLE_STRICTNESS              = 0x00000800,
    D3DCOMPILE_ENABLE_BACKWARDS_COMPATIBILITY = 0x00001000,
}

enum : uint
{
    D3DCOMPILE_IEEE_STRICTNESS     = 0x00002000,
    D3DCOMPILE_OPTIMIZATION_LEVEL0 = 0x00004000,
    D3DCOMPILE_OPTIMIZATION_LEVEL1 = 0x00000000,
    D3DCOMPILE_OPTIMIZATION_LEVEL3 = 0x00008000,
}

enum : uint
{
    D3DCOMPILE_RESERVED16          = 0x00010000,
    D3DCOMPILE_RESERVED17          = 0x00020000,
    D3DCOMPILE_WARNINGS_ARE_ERRORS = 0x00040000,
}

enum uint D3DCOMPILE_RESOURCES_MAY_ALIAS = 0x00080000;
enum uint D3DCOMPILE_ENABLE_UNBOUNDED_DESCRIPTOR_TABLES = 0x00100000;
enum uint D3DCOMPILE_ALL_RESOURCES_BOUND = 0x00200000;

enum : uint
{
    D3DCOMPILE_DEBUG_NAME_FOR_SOURCE = 0x00400000,
    D3DCOMPILE_DEBUG_NAME_FOR_BINARY = 0x00800000,
}

enum : uint
{
    D3DCOMPILE_EFFECT_CHILD_EFFECT   = 0x00000001,
    D3DCOMPILE_EFFECT_ALLOW_SLOW_OPS = 0x00000002,
}

enum : uint
{
    D3DCOMPILE_FLAGS2_FORCE_ROOT_SIGNATURE_LATEST = 0x00000000,
    D3DCOMPILE_FLAGS2_FORCE_ROOT_SIGNATURE_1_0    = 0x00000010,
    D3DCOMPILE_FLAGS2_FORCE_ROOT_SIGNATURE_1_1    = 0x00000020,
}

enum : uint
{
    D3DCOMPILE_SECDATA_MERGE_UAV_SLOTS         = 0x00000001,
    D3DCOMPILE_SECDATA_PRESERVE_TEMPLATE_SLOTS = 0x00000002,
    D3DCOMPILE_SECDATA_REQUIRE_TEMPLATE_MATCH  = 0x00000004,
}

enum : uint
{
    D3D_DISASM_ENABLE_COLOR_CODE            = 0x00000001,
    D3D_DISASM_ENABLE_DEFAULT_VALUE_PRINTS  = 0x00000002,
    D3D_DISASM_ENABLE_INSTRUCTION_NUMBERING = 0x00000004,
    D3D_DISASM_ENABLE_INSTRUCTION_CYCLE     = 0x00000008,
}

enum uint D3D_DISASM_DISABLE_DEBUG_INFO = 0x00000010;
enum uint D3D_DISASM_ENABLE_INSTRUCTION_OFFSET = 0x00000020;

enum : uint
{
    D3D_DISASM_INSTRUCTION_ONLY   = 0x00000040,
    D3D_DISASM_PRINT_HEX_LITERALS = 0x00000080,
}

enum uint D3D_GET_INST_OFFSETS_INCLUDE_NON_EXECUTABLE = 0x00000001;
enum uint D3D_COMPRESS_SHADER_KEEP_ALL_PARTS = 0x00000001;

// Callbacks

alias pD3DCompile = HRESULT function(const(void)* pSrcData, size_t SrcDataSize, const(PSTR) pFileName, 
                                     const(D3D_SHADER_MACRO)* pDefines, ID3DInclude pInclude, 
                                     const(PSTR) pEntrypoint, const(PSTR) pTarget, uint Flags1, uint Flags2, 
                                     ID3DBlob* ppCode, ID3DBlob* ppErrorMsgs);
alias pD3DPreprocess = HRESULT function(const(void)* pSrcData, size_t SrcDataSize, const(PSTR) pFileName, 
                                        const(D3D_SHADER_MACRO)* pDefines, ID3DInclude pInclude, 
                                        ID3DBlob* ppCodeText, ID3DBlob* ppErrorMsgs);
alias pD3DDisassemble = HRESULT function(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pSrcData, 
                                         size_t SrcDataSize, uint Flags, const(PSTR) szComments, 
                                         ID3DBlob* ppDisassembly);

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d3dcompiler/ns-d3dcompiler-d3d_shader_data))], [])
struct D3D_SHADER_DATA
{
    const(void)* pBytecode;
    size_t       BytecodeLength;
}

// Functions

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d3dcompiler/nf-d3dcompiler-d3dreadfiletoblob))], [])
@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DReadFileToBlob(const(PWSTR) pFileName, ID3DBlob* ppContents);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d3dcompiler/nf-d3dcompiler-d3dwriteblobtofile))], [])
@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DWriteBlobToFile(ID3DBlob pBlob, const(PWSTR) pFileName, BOOL bOverwrite);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d3dcompiler/nf-d3dcompiler-d3dcompile))], [])
@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DCompile(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pSrcData, 
                   size_t SrcDataSize, const(PSTR) pSourceName, const(D3D_SHADER_MACRO)* pDefines, 
                   ID3DInclude pInclude, const(PSTR) pEntrypoint, const(PSTR) pTarget, uint Flags1, uint Flags2, 
                   ID3DBlob* ppCode, ID3DBlob* ppErrorMsgs);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d3dcompiler/nf-d3dcompiler-d3dcompile2))], [])
@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DCompile2(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pSrcData, 
                    size_t SrcDataSize, const(PSTR) pSourceName, const(D3D_SHADER_MACRO)* pDefines, 
                    ID3DInclude pInclude, const(PSTR) pEntrypoint, const(PSTR) pTarget, uint Flags1, uint Flags2, 
                    uint SecondaryDataFlags, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(11)))])*/const(void)* pSecondaryData, 
                    size_t SecondaryDataSize, ID3DBlob* ppCode, ID3DBlob* ppErrorMsgs);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d3dcompiler/nf-d3dcompiler-d3dcompilefromfile))], [])
@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DCompileFromFile(const(PWSTR) pFileName, const(D3D_SHADER_MACRO)* pDefines, ID3DInclude pInclude, 
                           const(PSTR) pEntrypoint, const(PSTR) pTarget, uint Flags1, uint Flags2, ID3DBlob* ppCode, 
                           ID3DBlob* ppErrorMsgs);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d3dcompiler/nf-d3dcompiler-d3dpreprocess))], [])
@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DPreprocess(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pSrcData, 
                      size_t SrcDataSize, const(PSTR) pSourceName, const(D3D_SHADER_MACRO)* pDefines, 
                      ID3DInclude pInclude, ID3DBlob* ppCodeText, ID3DBlob* ppErrorMsgs);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d3dcompiler/nf-d3dcompiler-d3dgetdebuginfo))], [])
@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DGetDebugInfo(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pSrcData, 
                        size_t SrcDataSize, ID3DBlob* ppDebugInfo);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d3dcompiler/nf-d3dcompiler-d3dreflect))], [])
@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DReflect(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pSrcData, 
                   size_t SrcDataSize, const(GUID)* pInterface, void** ppReflector);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d3dcompiler/nf-d3dcompiler-d3dreflectlibrary))], [])
@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DReflectLibrary(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pSrcData, 
                          size_t SrcDataSize, const(GUID)* riid, void** ppReflector);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d3dcompiler/nf-d3dcompiler-d3ddisassemble))], [])
@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DDisassemble(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pSrcData, 
                       size_t SrcDataSize, uint Flags, const(PSTR) szComments, ID3DBlob* ppDisassembly);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d3dcompiler/nf-d3dcompiler-d3ddisassembleregion))], [])
@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DDisassembleRegion(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pSrcData, 
                             size_t SrcDataSize, uint Flags, const(PSTR) szComments, size_t StartByteOffset, 
                             size_t NumInsts, size_t* pFinishByteOffset, ID3DBlob* ppDisassembly);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d3dcompiler/nf-d3dcompiler-d3dcreatelinker))], [])
@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DCreateLinker(ID3D11Linker* ppLinker);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d3dcompiler/nf-d3dcompiler-d3dloadmodule))], [])
@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DLoadModule(const(void)* pSrcData, size_t cbSrcDataSize, ID3D11Module* ppModule);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d3dcompiler/nf-d3dcompiler-d3dcreatefunctionlinkinggraph))], [])
@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DCreateFunctionLinkingGraph(uint uFlags, ID3D11FunctionLinkingGraph* ppFunctionLinkingGraph);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d3dcompiler/nf-d3dcompiler-d3dgettraceinstructionoffsets))], [])
@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DGetTraceInstructionOffsets(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pSrcData, 
                                      size_t SrcDataSize, uint Flags, size_t StartInstIndex, size_t NumInsts, 
                                      size_t* pOffsets, size_t* pTotalInsts);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d3dcompiler/nf-d3dcompiler-d3dgetinputsignatureblob))], [])
@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DGetInputSignatureBlob(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pSrcData, 
                                 size_t SrcDataSize, ID3DBlob* ppSignatureBlob);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d3dcompiler/nf-d3dcompiler-d3dgetoutputsignatureblob))], [])
@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DGetOutputSignatureBlob(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pSrcData, 
                                  size_t SrcDataSize, ID3DBlob* ppSignatureBlob);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d3dcompiler/nf-d3dcompiler-d3dgetinputandoutputsignatureblob))], [])
@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DGetInputAndOutputSignatureBlob(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pSrcData, 
                                          size_t SrcDataSize, ID3DBlob* ppSignatureBlob);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d3dcompiler/nf-d3dcompiler-d3dstripshader))], [])
@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DStripShader(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pShaderBytecode, 
                       size_t BytecodeLength, uint uStripFlags, ID3DBlob* ppStrippedBlob);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d3dcompiler/nf-d3dcompiler-d3dgetblobpart))], [])
@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DGetBlobPart(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pSrcData, 
                       size_t SrcDataSize, D3D_BLOB_PART Part, uint Flags, ID3DBlob* ppPart);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d3dcompiler/nf-d3dcompiler-d3dsetblobpart))], [])
@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DSetBlobPart(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pSrcData, 
                       size_t SrcDataSize, D3D_BLOB_PART Part, uint Flags, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/const(void)* pPart, 
                       size_t PartSize, ID3DBlob* ppNewShader);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d3dcompiler/nf-d3dcompiler-d3dcreateblob))], [])
@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DCreateBlob(size_t Size, ID3DBlob* ppBlob);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d3dcompiler/nf-d3dcompiler-d3dcompressshaders))], [])
@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DCompressShaders(uint uNumShaders, D3D_SHADER_DATA* pShaderData, uint uFlags, ID3DBlob* ppCompressedData);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d3dcompiler/nf-d3dcompiler-d3ddecompressshaders))], [])
@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DDecompressShaders(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pSrcData, 
                             size_t SrcDataSize, uint uNumShaders, uint uStartIndex, uint* pIndices, uint uFlags, 
                             ID3DBlob* ppShaders, uint* pTotalShaders);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d3dcompiler/nf-d3dcompiler-d3ddisassemble10effect))], [])
@DllImport("D3DCOMPILER_47.dll")
HRESULT D3DDisassemble10Effect(ID3D10Effect pEffect, uint Flags, ID3DBlob* ppDisassembly);


