// Written in the D programming language.

module windows.win32.graphics.direct3d10;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOL, HANDLE, HMODULE, HRESULT, PSTR,
                                                    RECT;
public import windows.win32.graphics.direct3d.direct3d : D3D_CBUFFER_TYPE, D3D_NAME, D3D_PRIMITIVE,
                                                         D3D_PRIMITIVE_TOPOLOGY,
                                                         D3D_REGISTER_COMPONENT_TYPE,
                                                         D3D_RESOURCE_RETURN_TYPE,
                                                         D3D_SHADER_INPUT_TYPE,
                                                         D3D_SHADER_MACRO,
                                                         D3D_SHADER_VARIABLE_CLASS,
                                                         D3D_SHADER_VARIABLE_TYPE,
                                                         D3D_SRV_DIMENSION, ID3DBlob,
                                                         ID3DInclude;
public import windows.win32.graphics.dxgi.common : DXGI_FORMAT, DXGI_SAMPLE_DESC;
public import windows.win32.graphics.dxgi.dxgi : DXGI_SWAP_CHAIN_DESC, IDXGIAdapter, IDXGISwapChain;
public import windows.win32.system.com.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_input_classification
alias D3D10_INPUT_CLASSIFICATION = int;
enum : int
{
    D3D10_INPUT_PER_VERTEX_DATA   = 0x00000000,
    D3D10_INPUT_PER_INSTANCE_DATA = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_fill_mode
alias D3D10_FILL_MODE = int;
enum : int
{
    D3D10_FILL_WIREFRAME = 0x00000002,
    D3D10_FILL_SOLID     = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_cull_mode
alias D3D10_CULL_MODE = int;
enum : int
{
    D3D10_CULL_NONE  = 0x00000001,
    D3D10_CULL_FRONT = 0x00000002,
    D3D10_CULL_BACK  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_resource_dimension
alias D3D10_RESOURCE_DIMENSION = int;
enum : int
{
    D3D10_RESOURCE_DIMENSION_UNKNOWN   = 0x00000000,
    D3D10_RESOURCE_DIMENSION_BUFFER    = 0x00000001,
    D3D10_RESOURCE_DIMENSION_TEXTURE1D = 0x00000002,
    D3D10_RESOURCE_DIMENSION_TEXTURE2D = 0x00000003,
    D3D10_RESOURCE_DIMENSION_TEXTURE3D = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_dsv_dimension
alias D3D10_DSV_DIMENSION = int;
enum : int
{
    D3D10_DSV_DIMENSION_UNKNOWN          = 0x00000000,
    D3D10_DSV_DIMENSION_TEXTURE1D        = 0x00000001,
    D3D10_DSV_DIMENSION_TEXTURE1DARRAY   = 0x00000002,
    D3D10_DSV_DIMENSION_TEXTURE2D        = 0x00000003,
    D3D10_DSV_DIMENSION_TEXTURE2DARRAY   = 0x00000004,
    D3D10_DSV_DIMENSION_TEXTURE2DMS      = 0x00000005,
    D3D10_DSV_DIMENSION_TEXTURE2DMSARRAY = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_rtv_dimension
alias D3D10_RTV_DIMENSION = int;
enum : int
{
    D3D10_RTV_DIMENSION_UNKNOWN          = 0x00000000,
    D3D10_RTV_DIMENSION_BUFFER           = 0x00000001,
    D3D10_RTV_DIMENSION_TEXTURE1D        = 0x00000002,
    D3D10_RTV_DIMENSION_TEXTURE1DARRAY   = 0x00000003,
    D3D10_RTV_DIMENSION_TEXTURE2D        = 0x00000004,
    D3D10_RTV_DIMENSION_TEXTURE2DARRAY   = 0x00000005,
    D3D10_RTV_DIMENSION_TEXTURE2DMS      = 0x00000006,
    D3D10_RTV_DIMENSION_TEXTURE2DMSARRAY = 0x00000007,
    D3D10_RTV_DIMENSION_TEXTURE3D        = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_usage
alias D3D10_USAGE = int;
enum : int
{
    D3D10_USAGE_DEFAULT   = 0x00000000,
    D3D10_USAGE_IMMUTABLE = 0x00000001,
    D3D10_USAGE_DYNAMIC   = 0x00000002,
    D3D10_USAGE_STAGING   = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_bind_flag
alias D3D10_BIND_FLAG = int;
enum : int
{
    D3D10_BIND_VERTEX_BUFFER   = 0x00000001,
    D3D10_BIND_INDEX_BUFFER    = 0x00000002,
    D3D10_BIND_CONSTANT_BUFFER = 0x00000004,
    D3D10_BIND_SHADER_RESOURCE = 0x00000008,
    D3D10_BIND_STREAM_OUTPUT   = 0x00000010,
    D3D10_BIND_RENDER_TARGET   = 0x00000020,
    D3D10_BIND_DEPTH_STENCIL   = 0x00000040,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_cpu_access_flag
alias D3D10_CPU_ACCESS_FLAG = int;
enum : int
{
    D3D10_CPU_ACCESS_WRITE = 0x00010000,
    D3D10_CPU_ACCESS_READ  = 0x00020000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_resource_misc_flag
alias D3D10_RESOURCE_MISC_FLAG = int;
enum : int
{
    D3D10_RESOURCE_MISC_GENERATE_MIPS     = 0x00000001,
    D3D10_RESOURCE_MISC_SHARED            = 0x00000002,
    D3D10_RESOURCE_MISC_TEXTURECUBE       = 0x00000004,
    D3D10_RESOURCE_MISC_SHARED_KEYEDMUTEX = 0x00000010,
    D3D10_RESOURCE_MISC_GDI_COMPATIBLE    = 0x00000020,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_map
alias D3D10_MAP = int;
enum : int
{
    D3D10_MAP_READ               = 0x00000001,
    D3D10_MAP_WRITE              = 0x00000002,
    D3D10_MAP_READ_WRITE         = 0x00000003,
    D3D10_MAP_WRITE_DISCARD      = 0x00000004,
    D3D10_MAP_WRITE_NO_OVERWRITE = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_map_flag
alias D3D10_MAP_FLAG = int;
enum : int
{
    D3D10_MAP_FLAG_DO_NOT_WAIT = 0x00100000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_raise_flag
alias D3D10_RAISE_FLAG = int;
enum : int
{
    D3D10_RAISE_FLAG_DRIVER_INTERNAL_ERROR = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_clear_flag
alias D3D10_CLEAR_FLAG = int;
enum : int
{
    D3D10_CLEAR_DEPTH   = 0x00000001,
    D3D10_CLEAR_STENCIL = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_comparison_func
alias D3D10_COMPARISON_FUNC = int;
enum : int
{
    D3D10_COMPARISON_NEVER         = 0x00000001,
    D3D10_COMPARISON_LESS          = 0x00000002,
    D3D10_COMPARISON_EQUAL         = 0x00000003,
    D3D10_COMPARISON_LESS_EQUAL    = 0x00000004,
    D3D10_COMPARISON_GREATER       = 0x00000005,
    D3D10_COMPARISON_NOT_EQUAL     = 0x00000006,
    D3D10_COMPARISON_GREATER_EQUAL = 0x00000007,
    D3D10_COMPARISON_ALWAYS        = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_depth_write_mask
alias D3D10_DEPTH_WRITE_MASK = int;
enum : int
{
    D3D10_DEPTH_WRITE_MASK_ZERO = 0x00000000,
    D3D10_DEPTH_WRITE_MASK_ALL  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_stencil_op
alias D3D10_STENCIL_OP = int;
enum : int
{
    D3D10_STENCIL_OP_KEEP     = 0x00000001,
    D3D10_STENCIL_OP_ZERO     = 0x00000002,
    D3D10_STENCIL_OP_REPLACE  = 0x00000003,
    D3D10_STENCIL_OP_INCR_SAT = 0x00000004,
    D3D10_STENCIL_OP_DECR_SAT = 0x00000005,
    D3D10_STENCIL_OP_INVERT   = 0x00000006,
    D3D10_STENCIL_OP_INCR     = 0x00000007,
    D3D10_STENCIL_OP_DECR     = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_blend
alias D3D10_BLEND = int;
enum : int
{
    D3D10_BLEND_ZERO             = 0x00000001,
    D3D10_BLEND_ONE              = 0x00000002,
    D3D10_BLEND_SRC_COLOR        = 0x00000003,
    D3D10_BLEND_INV_SRC_COLOR    = 0x00000004,
    D3D10_BLEND_SRC_ALPHA        = 0x00000005,
    D3D10_BLEND_INV_SRC_ALPHA    = 0x00000006,
    D3D10_BLEND_DEST_ALPHA       = 0x00000007,
    D3D10_BLEND_INV_DEST_ALPHA   = 0x00000008,
    D3D10_BLEND_DEST_COLOR       = 0x00000009,
    D3D10_BLEND_INV_DEST_COLOR   = 0x0000000a,
    D3D10_BLEND_SRC_ALPHA_SAT    = 0x0000000b,
    D3D10_BLEND_BLEND_FACTOR     = 0x0000000e,
    D3D10_BLEND_INV_BLEND_FACTOR = 0x0000000f,
    D3D10_BLEND_SRC1_COLOR       = 0x00000010,
    D3D10_BLEND_INV_SRC1_COLOR   = 0x00000011,
    D3D10_BLEND_SRC1_ALPHA       = 0x00000012,
    D3D10_BLEND_INV_SRC1_ALPHA   = 0x00000013,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_blend_op
alias D3D10_BLEND_OP = int;
enum : int
{
    D3D10_BLEND_OP_ADD          = 0x00000001,
    D3D10_BLEND_OP_SUBTRACT     = 0x00000002,
    D3D10_BLEND_OP_REV_SUBTRACT = 0x00000003,
    D3D10_BLEND_OP_MIN          = 0x00000004,
    D3D10_BLEND_OP_MAX          = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_color_write_enable
alias D3D10_COLOR_WRITE_ENABLE = int;
enum : int
{
    D3D10_COLOR_WRITE_ENABLE_RED   = 0x00000001,
    D3D10_COLOR_WRITE_ENABLE_GREEN = 0x00000002,
    D3D10_COLOR_WRITE_ENABLE_BLUE  = 0x00000004,
    D3D10_COLOR_WRITE_ENABLE_ALPHA = 0x00000008,
    D3D10_COLOR_WRITE_ENABLE_ALL   = 0x0000000f,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_texturecube_face
alias D3D10_TEXTURECUBE_FACE = int;
enum : int
{
    D3D10_TEXTURECUBE_FACE_POSITIVE_X = 0x00000000,
    D3D10_TEXTURECUBE_FACE_NEGATIVE_X = 0x00000001,
    D3D10_TEXTURECUBE_FACE_POSITIVE_Y = 0x00000002,
    D3D10_TEXTURECUBE_FACE_NEGATIVE_Y = 0x00000003,
    D3D10_TEXTURECUBE_FACE_POSITIVE_Z = 0x00000004,
    D3D10_TEXTURECUBE_FACE_NEGATIVE_Z = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_filter
alias D3D10_FILTER = int;
enum : int
{
    D3D10_FILTER_MIN_MAG_MIP_POINT                          = 0x00000000,
    D3D10_FILTER_MIN_MAG_POINT_MIP_LINEAR                   = 0x00000001,
    D3D10_FILTER_MIN_POINT_MAG_LINEAR_MIP_POINT             = 0x00000004,
    D3D10_FILTER_MIN_POINT_MAG_MIP_LINEAR                   = 0x00000005,
    D3D10_FILTER_MIN_LINEAR_MAG_MIP_POINT                   = 0x00000010,
    D3D10_FILTER_MIN_LINEAR_MAG_POINT_MIP_LINEAR            = 0x00000011,
    D3D10_FILTER_MIN_MAG_LINEAR_MIP_POINT                   = 0x00000014,
    D3D10_FILTER_MIN_MAG_MIP_LINEAR                         = 0x00000015,
    D3D10_FILTER_ANISOTROPIC                                = 0x00000055,
    D3D10_FILTER_COMPARISON_MIN_MAG_MIP_POINT               = 0x00000080,
    D3D10_FILTER_COMPARISON_MIN_MAG_POINT_MIP_LINEAR        = 0x00000081,
    D3D10_FILTER_COMPARISON_MIN_POINT_MAG_LINEAR_MIP_POINT  = 0x00000084,
    D3D10_FILTER_COMPARISON_MIN_POINT_MAG_MIP_LINEAR        = 0x00000085,
    D3D10_FILTER_COMPARISON_MIN_LINEAR_MAG_MIP_POINT        = 0x00000090,
    D3D10_FILTER_COMPARISON_MIN_LINEAR_MAG_POINT_MIP_LINEAR = 0x00000091,
    D3D10_FILTER_COMPARISON_MIN_MAG_LINEAR_MIP_POINT        = 0x00000094,
    D3D10_FILTER_COMPARISON_MIN_MAG_MIP_LINEAR              = 0x00000095,
    D3D10_FILTER_COMPARISON_ANISOTROPIC                     = 0x000000d5,
    D3D10_FILTER_TEXT_1BIT                                  = 0x80000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_filter_type
alias D3D10_FILTER_TYPE = int;
enum : int
{
    D3D10_FILTER_TYPE_POINT  = 0x00000000,
    D3D10_FILTER_TYPE_LINEAR = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_texture_address_mode
alias D3D10_TEXTURE_ADDRESS_MODE = int;
enum : int
{
    D3D10_TEXTURE_ADDRESS_WRAP        = 0x00000001,
    D3D10_TEXTURE_ADDRESS_MIRROR      = 0x00000002,
    D3D10_TEXTURE_ADDRESS_CLAMP       = 0x00000003,
    D3D10_TEXTURE_ADDRESS_BORDER      = 0x00000004,
    D3D10_TEXTURE_ADDRESS_MIRROR_ONCE = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_format_support
alias D3D10_FORMAT_SUPPORT = int;
enum : int
{
    D3D10_FORMAT_SUPPORT_BUFFER                   = 0x00000001,
    D3D10_FORMAT_SUPPORT_IA_VERTEX_BUFFER         = 0x00000002,
    D3D10_FORMAT_SUPPORT_IA_INDEX_BUFFER          = 0x00000004,
    D3D10_FORMAT_SUPPORT_SO_BUFFER                = 0x00000008,
    D3D10_FORMAT_SUPPORT_TEXTURE1D                = 0x00000010,
    D3D10_FORMAT_SUPPORT_TEXTURE2D                = 0x00000020,
    D3D10_FORMAT_SUPPORT_TEXTURE3D                = 0x00000040,
    D3D10_FORMAT_SUPPORT_TEXTURECUBE              = 0x00000080,
    D3D10_FORMAT_SUPPORT_SHADER_LOAD              = 0x00000100,
    D3D10_FORMAT_SUPPORT_SHADER_SAMPLE            = 0x00000200,
    D3D10_FORMAT_SUPPORT_SHADER_SAMPLE_COMPARISON = 0x00000400,
    D3D10_FORMAT_SUPPORT_SHADER_SAMPLE_MONO_TEXT  = 0x00000800,
    D3D10_FORMAT_SUPPORT_MIP                      = 0x00001000,
    D3D10_FORMAT_SUPPORT_MIP_AUTOGEN              = 0x00002000,
    D3D10_FORMAT_SUPPORT_RENDER_TARGET            = 0x00004000,
    D3D10_FORMAT_SUPPORT_BLENDABLE                = 0x00008000,
    D3D10_FORMAT_SUPPORT_DEPTH_STENCIL            = 0x00010000,
    D3D10_FORMAT_SUPPORT_CPU_LOCKABLE             = 0x00020000,
    D3D10_FORMAT_SUPPORT_MULTISAMPLE_RESOLVE      = 0x00040000,
    D3D10_FORMAT_SUPPORT_DISPLAY                  = 0x00080000,
    D3D10_FORMAT_SUPPORT_CAST_WITHIN_BIT_LAYOUT   = 0x00100000,
    D3D10_FORMAT_SUPPORT_MULTISAMPLE_RENDERTARGET = 0x00200000,
    D3D10_FORMAT_SUPPORT_MULTISAMPLE_LOAD         = 0x00400000,
    D3D10_FORMAT_SUPPORT_SHADER_GATHER            = 0x00800000,
    D3D10_FORMAT_SUPPORT_BACK_BUFFER_CAST         = 0x01000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_async_getdata_flag
alias D3D10_ASYNC_GETDATA_FLAG = int;
enum : int
{
    D3D10_ASYNC_GETDATA_DONOTFLUSH = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_query
alias D3D10_QUERY = int;
enum : int
{
    D3D10_QUERY_EVENT                 = 0x00000000,
    D3D10_QUERY_OCCLUSION             = 0x00000001,
    D3D10_QUERY_TIMESTAMP             = 0x00000002,
    D3D10_QUERY_TIMESTAMP_DISJOINT    = 0x00000003,
    D3D10_QUERY_PIPELINE_STATISTICS   = 0x00000004,
    D3D10_QUERY_OCCLUSION_PREDICATE   = 0x00000005,
    D3D10_QUERY_SO_STATISTICS         = 0x00000006,
    D3D10_QUERY_SO_OVERFLOW_PREDICATE = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_query_misc_flag
alias D3D10_QUERY_MISC_FLAG = int;
enum : int
{
    D3D10_QUERY_MISC_PREDICATEHINT = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_counter
alias D3D10_COUNTER = int;
enum : int
{
    D3D10_COUNTER_GPU_IDLE                              = 0x00000000,
    D3D10_COUNTER_VERTEX_PROCESSING                     = 0x00000001,
    D3D10_COUNTER_GEOMETRY_PROCESSING                   = 0x00000002,
    D3D10_COUNTER_PIXEL_PROCESSING                      = 0x00000003,
    D3D10_COUNTER_OTHER_GPU_PROCESSING                  = 0x00000004,
    D3D10_COUNTER_HOST_ADAPTER_BANDWIDTH_UTILIZATION    = 0x00000005,
    D3D10_COUNTER_LOCAL_VIDMEM_BANDWIDTH_UTILIZATION    = 0x00000006,
    D3D10_COUNTER_VERTEX_THROUGHPUT_UTILIZATION         = 0x00000007,
    D3D10_COUNTER_TRIANGLE_SETUP_THROUGHPUT_UTILIZATION = 0x00000008,
    D3D10_COUNTER_FILLRATE_THROUGHPUT_UTILIZATION       = 0x00000009,
    D3D10_COUNTER_VS_MEMORY_LIMITED                     = 0x0000000a,
    D3D10_COUNTER_VS_COMPUTATION_LIMITED                = 0x0000000b,
    D3D10_COUNTER_GS_MEMORY_LIMITED                     = 0x0000000c,
    D3D10_COUNTER_GS_COMPUTATION_LIMITED                = 0x0000000d,
    D3D10_COUNTER_PS_MEMORY_LIMITED                     = 0x0000000e,
    D3D10_COUNTER_PS_COMPUTATION_LIMITED                = 0x0000000f,
    D3D10_COUNTER_POST_TRANSFORM_CACHE_HIT_RATE         = 0x00000010,
    D3D10_COUNTER_TEXTURE_CACHE_HIT_RATE                = 0x00000011,
    D3D10_COUNTER_DEVICE_DEPENDENT_0                    = 0x40000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_counter_type
alias D3D10_COUNTER_TYPE = int;
enum : int
{
    D3D10_COUNTER_TYPE_FLOAT32 = 0x00000000,
    D3D10_COUNTER_TYPE_UINT16  = 0x00000001,
    D3D10_COUNTER_TYPE_UINT32  = 0x00000002,
    D3D10_COUNTER_TYPE_UINT64  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ne-d3d10-d3d10_create_device_flag
alias D3D10_CREATE_DEVICE_FLAG = int;
enum : int
{
    D3D10_CREATE_DEVICE_SINGLETHREADED                                = 0x00000001,
    D3D10_CREATE_DEVICE_DEBUG                                         = 0x00000002,
    D3D10_CREATE_DEVICE_SWITCH_TO_REF                                 = 0x00000004,
    D3D10_CREATE_DEVICE_PREVENT_INTERNAL_THREADING_OPTIMIZATIONS      = 0x00000008,
    D3D10_CREATE_DEVICE_ALLOW_NULL_FROM_MAP                           = 0x00000010,
    D3D10_CREATE_DEVICE_BGRA_SUPPORT                                  = 0x00000020,
    D3D10_CREATE_DEVICE_PREVENT_ALTERING_LAYER_SETTINGS_FROM_REGISTRY = 0x00000080,
    D3D10_CREATE_DEVICE_STRICT_VALIDATION                             = 0x00000200,
    D3D10_CREATE_DEVICE_DEBUGGABLE                                    = 0x00000400,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/ne-d3d10sdklayers-d3d10_message_category
alias D3D10_MESSAGE_CATEGORY = int;
enum : int
{
    D3D10_MESSAGE_CATEGORY_APPLICATION_DEFINED   = 0x00000000,
    D3D10_MESSAGE_CATEGORY_MISCELLANEOUS         = 0x00000001,
    D3D10_MESSAGE_CATEGORY_INITIALIZATION        = 0x00000002,
    D3D10_MESSAGE_CATEGORY_CLEANUP               = 0x00000003,
    D3D10_MESSAGE_CATEGORY_COMPILATION           = 0x00000004,
    D3D10_MESSAGE_CATEGORY_STATE_CREATION        = 0x00000005,
    D3D10_MESSAGE_CATEGORY_STATE_SETTING         = 0x00000006,
    D3D10_MESSAGE_CATEGORY_STATE_GETTING         = 0x00000007,
    D3D10_MESSAGE_CATEGORY_RESOURCE_MANIPULATION = 0x00000008,
    D3D10_MESSAGE_CATEGORY_EXECUTION             = 0x00000009,
    D3D10_MESSAGE_CATEGORY_SHADER                = 0x0000000a,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/ne-d3d10sdklayers-d3d10_message_severity
alias D3D10_MESSAGE_SEVERITY = int;
enum : int
{
    D3D10_MESSAGE_SEVERITY_CORRUPTION = 0x00000000,
    D3D10_MESSAGE_SEVERITY_ERROR      = 0x00000001,
    D3D10_MESSAGE_SEVERITY_WARNING    = 0x00000002,
    D3D10_MESSAGE_SEVERITY_INFO       = 0x00000003,
    D3D10_MESSAGE_SEVERITY_MESSAGE    = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/ne-d3d10sdklayers-d3d10_message_id
alias D3D10_MESSAGE_ID = int;
enum : int
{
    D3D10_MESSAGE_ID_UNKNOWN                                                                     = 0x00000000,
    D3D10_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_HAZARD                                            = 0x00000001,
    D3D10_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_HAZARD                                              = 0x00000002,
    D3D10_MESSAGE_ID_DEVICE_VSSETSHADERRESOURCES_HAZARD                                          = 0x00000003,
    D3D10_MESSAGE_ID_DEVICE_VSSETCONSTANTBUFFERS_HAZARD                                          = 0x00000004,
    D3D10_MESSAGE_ID_DEVICE_GSSETSHADERRESOURCES_HAZARD                                          = 0x00000005,
    D3D10_MESSAGE_ID_DEVICE_GSSETCONSTANTBUFFERS_HAZARD                                          = 0x00000006,
    D3D10_MESSAGE_ID_DEVICE_PSSETSHADERRESOURCES_HAZARD                                          = 0x00000007,
    D3D10_MESSAGE_ID_DEVICE_PSSETCONSTANTBUFFERS_HAZARD                                          = 0x00000008,
    D3D10_MESSAGE_ID_DEVICE_OMSETRENDERTARGETS_HAZARD                                            = 0x00000009,
    D3D10_MESSAGE_ID_DEVICE_SOSETTARGETS_HAZARD                                                  = 0x0000000a,
    D3D10_MESSAGE_ID_STRING_FROM_APPLICATION                                                     = 0x0000000b,
    D3D10_MESSAGE_ID_CORRUPTED_THIS                                                              = 0x0000000c,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER1                                                        = 0x0000000d,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER2                                                        = 0x0000000e,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER3                                                        = 0x0000000f,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER4                                                        = 0x00000010,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER5                                                        = 0x00000011,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER6                                                        = 0x00000012,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER7                                                        = 0x00000013,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER8                                                        = 0x00000014,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER9                                                        = 0x00000015,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER10                                                       = 0x00000016,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER11                                                       = 0x00000017,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER12                                                       = 0x00000018,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER13                                                       = 0x00000019,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER14                                                       = 0x0000001a,
    D3D10_MESSAGE_ID_CORRUPTED_PARAMETER15                                                       = 0x0000001b,
    D3D10_MESSAGE_ID_CORRUPTED_MULTITHREADING                                                    = 0x0000001c,
    D3D10_MESSAGE_ID_MESSAGE_REPORTING_OUTOFMEMORY                                               = 0x0000001d,
    D3D10_MESSAGE_ID_IASETINPUTLAYOUT_UNBINDDELETINGOBJECT                                       = 0x0000001e,
    D3D10_MESSAGE_ID_IASETVERTEXBUFFERS_UNBINDDELETINGOBJECT                                     = 0x0000001f,
    D3D10_MESSAGE_ID_IASETINDEXBUFFER_UNBINDDELETINGOBJECT                                       = 0x00000020,
    D3D10_MESSAGE_ID_VSSETSHADER_UNBINDDELETINGOBJECT                                            = 0x00000021,
    D3D10_MESSAGE_ID_VSSETSHADERRESOURCES_UNBINDDELETINGOBJECT                                   = 0x00000022,
    D3D10_MESSAGE_ID_VSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT                                   = 0x00000023,
    D3D10_MESSAGE_ID_VSSETSAMPLERS_UNBINDDELETINGOBJECT                                          = 0x00000024,
    D3D10_MESSAGE_ID_GSSETSHADER_UNBINDDELETINGOBJECT                                            = 0x00000025,
    D3D10_MESSAGE_ID_GSSETSHADERRESOURCES_UNBINDDELETINGOBJECT                                   = 0x00000026,
    D3D10_MESSAGE_ID_GSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT                                   = 0x00000027,
    D3D10_MESSAGE_ID_GSSETSAMPLERS_UNBINDDELETINGOBJECT                                          = 0x00000028,
    D3D10_MESSAGE_ID_SOSETTARGETS_UNBINDDELETINGOBJECT                                           = 0x00000029,
    D3D10_MESSAGE_ID_PSSETSHADER_UNBINDDELETINGOBJECT                                            = 0x0000002a,
    D3D10_MESSAGE_ID_PSSETSHADERRESOURCES_UNBINDDELETINGOBJECT                                   = 0x0000002b,
    D3D10_MESSAGE_ID_PSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT                                   = 0x0000002c,
    D3D10_MESSAGE_ID_PSSETSAMPLERS_UNBINDDELETINGOBJECT                                          = 0x0000002d,
    D3D10_MESSAGE_ID_RSSETSTATE_UNBINDDELETINGOBJECT                                             = 0x0000002e,
    D3D10_MESSAGE_ID_OMSETBLENDSTATE_UNBINDDELETINGOBJECT                                        = 0x0000002f,
    D3D10_MESSAGE_ID_OMSETDEPTHSTENCILSTATE_UNBINDDELETINGOBJECT                                 = 0x00000030,
    D3D10_MESSAGE_ID_OMSETRENDERTARGETS_UNBINDDELETINGOBJECT                                     = 0x00000031,
    D3D10_MESSAGE_ID_SETPREDICATION_UNBINDDELETINGOBJECT                                         = 0x00000032,
    D3D10_MESSAGE_ID_GETPRIVATEDATA_MOREDATA                                                     = 0x00000033,
    D3D10_MESSAGE_ID_SETPRIVATEDATA_INVALIDFREEDATA                                              = 0x00000034,
    D3D10_MESSAGE_ID_SETPRIVATEDATA_INVALIDIUNKNOWN                                              = 0x00000035,
    D3D10_MESSAGE_ID_SETPRIVATEDATA_INVALIDFLAGS                                                 = 0x00000036,
    D3D10_MESSAGE_ID_SETPRIVATEDATA_CHANGINGPARAMS                                               = 0x00000037,
    D3D10_MESSAGE_ID_SETPRIVATEDATA_OUTOFMEMORY                                                  = 0x00000038,
    D3D10_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDFORMAT                                             = 0x00000039,
    D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDSAMPLES                                                 = 0x0000003a,
    D3D10_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDUSAGE                                              = 0x0000003b,
    D3D10_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDBINDFLAGS                                          = 0x0000003c,
    D3D10_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDCPUACCESSFLAGS                                     = 0x0000003d,
    D3D10_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDMISCFLAGS                                          = 0x0000003e,
    D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDCPUACCESSFLAGS                                          = 0x0000003f,
    D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDBINDFLAGS                                               = 0x00000040,
    D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDINITIALDATA                                             = 0x00000041,
    D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDDIMENSIONS                                              = 0x00000042,
    D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDMIPLEVELS                                               = 0x00000043,
    D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDMISCFLAGS                                               = 0x00000044,
    D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDARG_RETURN                                              = 0x00000045,
    D3D10_MESSAGE_ID_CREATEBUFFER_OUTOFMEMORY_RETURN                                             = 0x00000046,
    D3D10_MESSAGE_ID_CREATEBUFFER_NULLDESC                                                       = 0x00000047,
    D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDCONSTANTBUFFERBINDINGS                                  = 0x00000048,
    D3D10_MESSAGE_ID_CREATEBUFFER_LARGEALLOCATION                                                = 0x00000049,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDFORMAT                                          = 0x0000004a,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_UNSUPPORTEDFORMAT                                           = 0x0000004b,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDSAMPLES                                              = 0x0000004c,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDUSAGE                                           = 0x0000004d,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDBINDFLAGS                                       = 0x0000004e,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDCPUACCESSFLAGS                                  = 0x0000004f,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDMISCFLAGS                                       = 0x00000050,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDCPUACCESSFLAGS                                       = 0x00000051,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDBINDFLAGS                                            = 0x00000052,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDINITIALDATA                                          = 0x00000053,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDDIMENSIONS                                           = 0x00000054,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDMIPLEVELS                                            = 0x00000055,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDMISCFLAGS                                            = 0x00000056,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDARG_RETURN                                           = 0x00000057,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_OUTOFMEMORY_RETURN                                          = 0x00000058,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_NULLDESC                                                    = 0x00000059,
    D3D10_MESSAGE_ID_CREATETEXTURE1D_LARGEALLOCATION                                             = 0x0000005a,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDFORMAT                                          = 0x0000005b,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_UNSUPPORTEDFORMAT                                           = 0x0000005c,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDSAMPLES                                              = 0x0000005d,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDUSAGE                                           = 0x0000005e,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDBINDFLAGS                                       = 0x0000005f,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDCPUACCESSFLAGS                                  = 0x00000060,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDMISCFLAGS                                       = 0x00000061,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDCPUACCESSFLAGS                                       = 0x00000062,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDBINDFLAGS                                            = 0x00000063,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDINITIALDATA                                          = 0x00000064,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDDIMENSIONS                                           = 0x00000065,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDMIPLEVELS                                            = 0x00000066,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDMISCFLAGS                                            = 0x00000067,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDARG_RETURN                                           = 0x00000068,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_OUTOFMEMORY_RETURN                                          = 0x00000069,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_NULLDESC                                                    = 0x0000006a,
    D3D10_MESSAGE_ID_CREATETEXTURE2D_LARGEALLOCATION                                             = 0x0000006b,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDFORMAT                                          = 0x0000006c,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_UNSUPPORTEDFORMAT                                           = 0x0000006d,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDSAMPLES                                              = 0x0000006e,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDUSAGE                                           = 0x0000006f,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDBINDFLAGS                                       = 0x00000070,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDCPUACCESSFLAGS                                  = 0x00000071,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDMISCFLAGS                                       = 0x00000072,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDCPUACCESSFLAGS                                       = 0x00000073,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDBINDFLAGS                                            = 0x00000074,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDINITIALDATA                                          = 0x00000075,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDDIMENSIONS                                           = 0x00000076,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDMIPLEVELS                                            = 0x00000077,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDMISCFLAGS                                            = 0x00000078,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDARG_RETURN                                           = 0x00000079,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_OUTOFMEMORY_RETURN                                          = 0x0000007a,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_NULLDESC                                                    = 0x0000007b,
    D3D10_MESSAGE_ID_CREATETEXTURE3D_LARGEALLOCATION                                             = 0x0000007c,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_UNRECOGNIZEDFORMAT                                 = 0x0000007d,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDDESC                                        = 0x0000007e,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDFORMAT                                      = 0x0000007f,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDDIMENSIONS                                  = 0x00000080,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDRESOURCE                                    = 0x00000081,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_TOOMANYOBJECTS                                     = 0x00000082,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDARG_RETURN                                  = 0x00000083,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_OUTOFMEMORY_RETURN                                 = 0x00000084,
    D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_UNRECOGNIZEDFORMAT                                   = 0x00000085,
    D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_UNSUPPORTEDFORMAT                                    = 0x00000086,
    D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDDESC                                          = 0x00000087,
    D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDFORMAT                                        = 0x00000088,
    D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDDIMENSIONS                                    = 0x00000089,
    D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDRESOURCE                                      = 0x0000008a,
    D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_TOOMANYOBJECTS                                       = 0x0000008b,
    D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDARG_RETURN                                    = 0x0000008c,
    D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_OUTOFMEMORY_RETURN                                   = 0x0000008d,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_UNRECOGNIZEDFORMAT                                   = 0x0000008e,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDDESC                                          = 0x0000008f,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDFORMAT                                        = 0x00000090,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDDIMENSIONS                                    = 0x00000091,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDRESOURCE                                      = 0x00000092,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_TOOMANYOBJECTS                                       = 0x00000093,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDARG_RETURN                                    = 0x00000094,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_OUTOFMEMORY_RETURN                                   = 0x00000095,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_OUTOFMEMORY                                               = 0x00000096,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_TOOMANYELEMENTS                                           = 0x00000097,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDFORMAT                                             = 0x00000098,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_INCOMPATIBLEFORMAT                                        = 0x00000099,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSLOT                                               = 0x0000009a,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDINPUTSLOTCLASS                                     = 0x0000009b,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_STEPRATESLOTCLASSMISMATCH                                 = 0x0000009c,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSLOTCLASSCHANGE                                    = 0x0000009d,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSTEPRATECHANGE                                     = 0x0000009e,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDALIGNMENT                                          = 0x0000009f,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_DUPLICATESEMANTIC                                         = 0x000000a0,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_UNPARSEABLEINPUTSIGNATURE                                 = 0x000000a1,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_NULLSEMANTIC                                              = 0x000000a2,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_MISSINGELEMENT                                            = 0x000000a3,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_NULLDESC                                                  = 0x000000a4,
    D3D10_MESSAGE_ID_CREATEVERTEXSHADER_OUTOFMEMORY                                              = 0x000000a5,
    D3D10_MESSAGE_ID_CREATEVERTEXSHADER_INVALIDSHADERBYTECODE                                    = 0x000000a6,
    D3D10_MESSAGE_ID_CREATEVERTEXSHADER_INVALIDSHADERTYPE                                        = 0x000000a7,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADER_OUTOFMEMORY                                            = 0x000000a8,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADER_INVALIDSHADERBYTECODE                                  = 0x000000a9,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADER_INVALIDSHADERTYPE                                      = 0x000000aa,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTOFMEMORY                            = 0x000000ab,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSHADERBYTECODE                  = 0x000000ac,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSHADERTYPE                      = 0x000000ad,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDNUMENTRIES                      = 0x000000ae,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTPUTSTREAMSTRIDEUNUSED               = 0x000000af,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UNEXPECTEDDECL                         = 0x000000b0,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_EXPECTEDDECL                           = 0x000000b1,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTPUTSLOT0EXPECTED                    = 0x000000b2,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDOUTPUTSLOT                      = 0x000000b3,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_ONLYONEELEMENTPERSLOT                  = 0x000000b4,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDCOMPONENTCOUNT                  = 0x000000b5,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSTARTCOMPONENTANDCOMPONENTCOUNT = 0x000000b6,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDGAPDEFINITION                   = 0x000000b7,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_REPEATEDOUTPUT                         = 0x000000b8,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDOUTPUTSTREAMSTRIDE              = 0x000000b9,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MISSINGSEMANTIC                        = 0x000000ba,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MASKMISMATCH                           = 0x000000bb,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_CANTHAVEONLYGAPS                       = 0x000000bc,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_DECLTOOCOMPLEX                         = 0x000000bd,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MISSINGOUTPUTSIGNATURE                 = 0x000000be,
    D3D10_MESSAGE_ID_CREATEPIXELSHADER_OUTOFMEMORY                                               = 0x000000bf,
    D3D10_MESSAGE_ID_CREATEPIXELSHADER_INVALIDSHADERBYTECODE                                     = 0x000000c0,
    D3D10_MESSAGE_ID_CREATEPIXELSHADER_INVALIDSHADERTYPE                                         = 0x000000c1,
    D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDFILLMODE                                       = 0x000000c2,
    D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDCULLMODE                                       = 0x000000c3,
    D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDDEPTHBIASCLAMP                                 = 0x000000c4,
    D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDSLOPESCALEDDEPTHBIAS                           = 0x000000c5,
    D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_TOOMANYOBJECTS                                        = 0x000000c6,
    D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_NULLDESC                                              = 0x000000c7,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDDEPTHWRITEMASK                               = 0x000000c8,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDDEPTHFUNC                                    = 0x000000c9,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILFAILOP                       = 0x000000ca,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILZFAILOP                      = 0x000000cb,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILPASSOP                       = 0x000000cc,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILFUNC                         = 0x000000cd,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILFAILOP                        = 0x000000ce,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILZFAILOP                       = 0x000000cf,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILPASSOP                        = 0x000000d0,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILFUNC                          = 0x000000d1,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_TOOMANYOBJECTS                                      = 0x000000d2,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_NULLDESC                                            = 0x000000d3,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_INVALIDSRCBLEND                                            = 0x000000d4,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_INVALIDDESTBLEND                                           = 0x000000d5,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_INVALIDBLENDOP                                             = 0x000000d6,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_INVALIDSRCBLENDALPHA                                       = 0x000000d7,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_INVALIDDESTBLENDALPHA                                      = 0x000000d8,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_INVALIDBLENDOPALPHA                                        = 0x000000d9,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_INVALIDRENDERTARGETWRITEMASK                               = 0x000000da,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_TOOMANYOBJECTS                                             = 0x000000db,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_NULLDESC                                                   = 0x000000dc,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDFILTER                                            = 0x000000dd,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDADDRESSU                                          = 0x000000de,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDADDRESSV                                          = 0x000000df,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDADDRESSW                                          = 0x000000e0,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMIPLODBIAS                                        = 0x000000e1,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMAXANISOTROPY                                     = 0x000000e2,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDCOMPARISONFUNC                                    = 0x000000e3,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMINLOD                                            = 0x000000e4,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMAXLOD                                            = 0x000000e5,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_TOOMANYOBJECTS                                           = 0x000000e6,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_NULLDESC                                                 = 0x000000e7,
    D3D10_MESSAGE_ID_CREATEQUERYORPREDICATE_INVALIDQUERY                                         = 0x000000e8,
    D3D10_MESSAGE_ID_CREATEQUERYORPREDICATE_INVALIDMISCFLAGS                                     = 0x000000e9,
    D3D10_MESSAGE_ID_CREATEQUERYORPREDICATE_UNEXPECTEDMISCFLAG                                   = 0x000000ea,
    D3D10_MESSAGE_ID_CREATEQUERYORPREDICATE_NULLDESC                                             = 0x000000eb,
    D3D10_MESSAGE_ID_DEVICE_IASETPRIMITIVETOPOLOGY_TOPOLOGY_UNRECOGNIZED                         = 0x000000ec,
    D3D10_MESSAGE_ID_DEVICE_IASETPRIMITIVETOPOLOGY_TOPOLOGY_UNDEFINED                            = 0x000000ed,
    D3D10_MESSAGE_ID_IASETVERTEXBUFFERS_INVALIDBUFFER                                            = 0x000000ee,
    D3D10_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_OFFSET_TOO_LARGE                                  = 0x000000ef,
    D3D10_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_BUFFERS_EMPTY                                     = 0x000000f0,
    D3D10_MESSAGE_ID_IASETINDEXBUFFER_INVALIDBUFFER                                              = 0x000000f1,
    D3D10_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_FORMAT_INVALID                                      = 0x000000f2,
    D3D10_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_OFFSET_TOO_LARGE                                    = 0x000000f3,
    D3D10_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_OFFSET_UNALIGNED                                    = 0x000000f4,
    D3D10_MESSAGE_ID_DEVICE_VSSETSHADERRESOURCES_VIEWS_EMPTY                                     = 0x000000f5,
    D3D10_MESSAGE_ID_VSSETCONSTANTBUFFERS_INVALIDBUFFER                                          = 0x000000f6,
    D3D10_MESSAGE_ID_DEVICE_VSSETCONSTANTBUFFERS_BUFFERS_EMPTY                                   = 0x000000f7,
    D3D10_MESSAGE_ID_DEVICE_VSSETSAMPLERS_SAMPLERS_EMPTY                                         = 0x000000f8,
    D3D10_MESSAGE_ID_DEVICE_GSSETSHADERRESOURCES_VIEWS_EMPTY                                     = 0x000000f9,
    D3D10_MESSAGE_ID_GSSETCONSTANTBUFFERS_INVALIDBUFFER                                          = 0x000000fa,
    D3D10_MESSAGE_ID_DEVICE_GSSETCONSTANTBUFFERS_BUFFERS_EMPTY                                   = 0x000000fb,
    D3D10_MESSAGE_ID_DEVICE_GSSETSAMPLERS_SAMPLERS_EMPTY                                         = 0x000000fc,
    D3D10_MESSAGE_ID_SOSETTARGETS_INVALIDBUFFER                                                  = 0x000000fd,
    D3D10_MESSAGE_ID_DEVICE_SOSETTARGETS_OFFSET_UNALIGNED                                        = 0x000000fe,
    D3D10_MESSAGE_ID_DEVICE_PSSETSHADERRESOURCES_VIEWS_EMPTY                                     = 0x000000ff,
    D3D10_MESSAGE_ID_PSSETCONSTANTBUFFERS_INVALIDBUFFER                                          = 0x00000100,
    D3D10_MESSAGE_ID_DEVICE_PSSETCONSTANTBUFFERS_BUFFERS_EMPTY                                   = 0x00000101,
    D3D10_MESSAGE_ID_DEVICE_PSSETSAMPLERS_SAMPLERS_EMPTY                                         = 0x00000102,
    D3D10_MESSAGE_ID_DEVICE_RSSETVIEWPORTS_INVALIDVIEWPORT                                       = 0x00000103,
    D3D10_MESSAGE_ID_DEVICE_RSSETSCISSORRECTS_INVALIDSCISSOR                                     = 0x00000104,
    D3D10_MESSAGE_ID_CLEARRENDERTARGETVIEW_DENORMFLUSH                                           = 0x00000105,
    D3D10_MESSAGE_ID_CLEARDEPTHSTENCILVIEW_DENORMFLUSH                                           = 0x00000106,
    D3D10_MESSAGE_ID_CLEARDEPTHSTENCILVIEW_INVALID                                               = 0x00000107,
    D3D10_MESSAGE_ID_DEVICE_IAGETVERTEXBUFFERS_BUFFERS_EMPTY                                     = 0x00000108,
    D3D10_MESSAGE_ID_DEVICE_VSGETSHADERRESOURCES_VIEWS_EMPTY                                     = 0x00000109,
    D3D10_MESSAGE_ID_DEVICE_VSGETCONSTANTBUFFERS_BUFFERS_EMPTY                                   = 0x0000010a,
    D3D10_MESSAGE_ID_DEVICE_VSGETSAMPLERS_SAMPLERS_EMPTY                                         = 0x0000010b,
    D3D10_MESSAGE_ID_DEVICE_GSGETSHADERRESOURCES_VIEWS_EMPTY                                     = 0x0000010c,
    D3D10_MESSAGE_ID_DEVICE_GSGETCONSTANTBUFFERS_BUFFERS_EMPTY                                   = 0x0000010d,
    D3D10_MESSAGE_ID_DEVICE_GSGETSAMPLERS_SAMPLERS_EMPTY                                         = 0x0000010e,
    D3D10_MESSAGE_ID_DEVICE_SOGETTARGETS_BUFFERS_EMPTY                                           = 0x0000010f,
    D3D10_MESSAGE_ID_DEVICE_PSGETSHADERRESOURCES_VIEWS_EMPTY                                     = 0x00000110,
    D3D10_MESSAGE_ID_DEVICE_PSGETCONSTANTBUFFERS_BUFFERS_EMPTY                                   = 0x00000111,
    D3D10_MESSAGE_ID_DEVICE_PSGETSAMPLERS_SAMPLERS_EMPTY                                         = 0x00000112,
    D3D10_MESSAGE_ID_DEVICE_RSGETVIEWPORTS_VIEWPORTS_EMPTY                                       = 0x00000113,
    D3D10_MESSAGE_ID_DEVICE_RSGETSCISSORRECTS_RECTS_EMPTY                                        = 0x00000114,
    D3D10_MESSAGE_ID_DEVICE_GENERATEMIPS_RESOURCE_INVALID                                        = 0x00000115,
    D3D10_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDDESTINATIONSUBRESOURCE                         = 0x00000116,
    D3D10_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCESUBRESOURCE                              = 0x00000117,
    D3D10_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCEBOX                                      = 0x00000118,
    D3D10_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCE                                         = 0x00000119,
    D3D10_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDDESTINATIONSTATE                               = 0x0000011a,
    D3D10_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCESTATE                                    = 0x0000011b,
    D3D10_MESSAGE_ID_COPYRESOURCE_INVALIDSOURCE                                                  = 0x0000011c,
    D3D10_MESSAGE_ID_COPYRESOURCE_INVALIDDESTINATIONSTATE                                        = 0x0000011d,
    D3D10_MESSAGE_ID_COPYRESOURCE_INVALIDSOURCESTATE                                             = 0x0000011e,
    D3D10_MESSAGE_ID_UPDATESUBRESOURCE_INVALIDDESTINATIONSUBRESOURCE                             = 0x0000011f,
    D3D10_MESSAGE_ID_UPDATESUBRESOURCE_INVALIDDESTINATIONBOX                                     = 0x00000120,
    D3D10_MESSAGE_ID_UPDATESUBRESOURCE_INVALIDDESTINATIONSTATE                                   = 0x00000121,
    D3D10_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_DESTINATION_INVALID                               = 0x00000122,
    D3D10_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_DESTINATION_SUBRESOURCE_INVALID                   = 0x00000123,
    D3D10_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_SOURCE_INVALID                                    = 0x00000124,
    D3D10_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_SOURCE_SUBRESOURCE_INVALID                        = 0x00000125,
    D3D10_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_FORMAT_INVALID                                    = 0x00000126,
    D3D10_MESSAGE_ID_BUFFER_MAP_INVALIDMAPTYPE                                                   = 0x00000127,
    D3D10_MESSAGE_ID_BUFFER_MAP_INVALIDFLAGS                                                     = 0x00000128,
    D3D10_MESSAGE_ID_BUFFER_MAP_ALREADYMAPPED                                                    = 0x00000129,
    D3D10_MESSAGE_ID_BUFFER_MAP_DEVICEREMOVED_RETURN                                             = 0x0000012a,
    D3D10_MESSAGE_ID_BUFFER_UNMAP_NOTMAPPED                                                      = 0x0000012b,
    D3D10_MESSAGE_ID_TEXTURE1D_MAP_INVALIDMAPTYPE                                                = 0x0000012c,
    D3D10_MESSAGE_ID_TEXTURE1D_MAP_INVALIDSUBRESOURCE                                            = 0x0000012d,
    D3D10_MESSAGE_ID_TEXTURE1D_MAP_INVALIDFLAGS                                                  = 0x0000012e,
    D3D10_MESSAGE_ID_TEXTURE1D_MAP_ALREADYMAPPED                                                 = 0x0000012f,
    D3D10_MESSAGE_ID_TEXTURE1D_MAP_DEVICEREMOVED_RETURN                                          = 0x00000130,
    D3D10_MESSAGE_ID_TEXTURE1D_UNMAP_INVALIDSUBRESOURCE                                          = 0x00000131,
    D3D10_MESSAGE_ID_TEXTURE1D_UNMAP_NOTMAPPED                                                   = 0x00000132,
    D3D10_MESSAGE_ID_TEXTURE2D_MAP_INVALIDMAPTYPE                                                = 0x00000133,
    D3D10_MESSAGE_ID_TEXTURE2D_MAP_INVALIDSUBRESOURCE                                            = 0x00000134,
    D3D10_MESSAGE_ID_TEXTURE2D_MAP_INVALIDFLAGS                                                  = 0x00000135,
    D3D10_MESSAGE_ID_TEXTURE2D_MAP_ALREADYMAPPED                                                 = 0x00000136,
    D3D10_MESSAGE_ID_TEXTURE2D_MAP_DEVICEREMOVED_RETURN                                          = 0x00000137,
    D3D10_MESSAGE_ID_TEXTURE2D_UNMAP_INVALIDSUBRESOURCE                                          = 0x00000138,
    D3D10_MESSAGE_ID_TEXTURE2D_UNMAP_NOTMAPPED                                                   = 0x00000139,
    D3D10_MESSAGE_ID_TEXTURE3D_MAP_INVALIDMAPTYPE                                                = 0x0000013a,
    D3D10_MESSAGE_ID_TEXTURE3D_MAP_INVALIDSUBRESOURCE                                            = 0x0000013b,
    D3D10_MESSAGE_ID_TEXTURE3D_MAP_INVALIDFLAGS                                                  = 0x0000013c,
    D3D10_MESSAGE_ID_TEXTURE3D_MAP_ALREADYMAPPED                                                 = 0x0000013d,
    D3D10_MESSAGE_ID_TEXTURE3D_MAP_DEVICEREMOVED_RETURN                                          = 0x0000013e,
    D3D10_MESSAGE_ID_TEXTURE3D_UNMAP_INVALIDSUBRESOURCE                                          = 0x0000013f,
    D3D10_MESSAGE_ID_TEXTURE3D_UNMAP_NOTMAPPED                                                   = 0x00000140,
    D3D10_MESSAGE_ID_CHECKFORMATSUPPORT_FORMAT_DEPRECATED                                        = 0x00000141,
    D3D10_MESSAGE_ID_CHECKMULTISAMPLEQUALITYLEVELS_FORMAT_DEPRECATED                             = 0x00000142,
    D3D10_MESSAGE_ID_SETEXCEPTIONMODE_UNRECOGNIZEDFLAGS                                          = 0x00000143,
    D3D10_MESSAGE_ID_SETEXCEPTIONMODE_INVALIDARG_RETURN                                          = 0x00000144,
    D3D10_MESSAGE_ID_SETEXCEPTIONMODE_DEVICEREMOVED_RETURN                                       = 0x00000145,
    D3D10_MESSAGE_ID_REF_SIMULATING_INFINITELY_FAST_HARDWARE                                     = 0x00000146,
    D3D10_MESSAGE_ID_REF_THREADING_MODE                                                          = 0x00000147,
    D3D10_MESSAGE_ID_REF_UMDRIVER_EXCEPTION                                                      = 0x00000148,
    D3D10_MESSAGE_ID_REF_KMDRIVER_EXCEPTION                                                      = 0x00000149,
    D3D10_MESSAGE_ID_REF_HARDWARE_EXCEPTION                                                      = 0x0000014a,
    D3D10_MESSAGE_ID_REF_ACCESSING_INDEXABLE_TEMP_OUT_OF_RANGE                                   = 0x0000014b,
    D3D10_MESSAGE_ID_REF_PROBLEM_PARSING_SHADER                                                  = 0x0000014c,
    D3D10_MESSAGE_ID_REF_OUT_OF_MEMORY                                                           = 0x0000014d,
    D3D10_MESSAGE_ID_REF_INFO                                                                    = 0x0000014e,
    D3D10_MESSAGE_ID_DEVICE_DRAW_VERTEXPOS_OVERFLOW                                              = 0x0000014f,
    D3D10_MESSAGE_ID_DEVICE_DRAWINDEXED_INDEXPOS_OVERFLOW                                        = 0x00000150,
    D3D10_MESSAGE_ID_DEVICE_DRAWINSTANCED_VERTEXPOS_OVERFLOW                                     = 0x00000151,
    D3D10_MESSAGE_ID_DEVICE_DRAWINSTANCED_INSTANCEPOS_OVERFLOW                                   = 0x00000152,
    D3D10_MESSAGE_ID_DEVICE_DRAWINDEXEDINSTANCED_INSTANCEPOS_OVERFLOW                            = 0x00000153,
    D3D10_MESSAGE_ID_DEVICE_DRAWINDEXEDINSTANCED_INDEXPOS_OVERFLOW                               = 0x00000154,
    D3D10_MESSAGE_ID_DEVICE_DRAW_VERTEX_SHADER_NOT_SET                                           = 0x00000155,
    D3D10_MESSAGE_ID_DEVICE_SHADER_LINKAGE_SEMANTICNAME_NOT_FOUND                                = 0x00000156,
    D3D10_MESSAGE_ID_DEVICE_SHADER_LINKAGE_REGISTERINDEX                                         = 0x00000157,
    D3D10_MESSAGE_ID_DEVICE_SHADER_LINKAGE_COMPONENTTYPE                                         = 0x00000158,
    D3D10_MESSAGE_ID_DEVICE_SHADER_LINKAGE_REGISTERMASK                                          = 0x00000159,
    D3D10_MESSAGE_ID_DEVICE_SHADER_LINKAGE_SYSTEMVALUE                                           = 0x0000015a,
    D3D10_MESSAGE_ID_DEVICE_SHADER_LINKAGE_NEVERWRITTEN_ALWAYSREADS                              = 0x0000015b,
    D3D10_MESSAGE_ID_DEVICE_DRAW_VERTEX_BUFFER_NOT_SET                                           = 0x0000015c,
    D3D10_MESSAGE_ID_DEVICE_DRAW_INPUTLAYOUT_NOT_SET                                             = 0x0000015d,
    D3D10_MESSAGE_ID_DEVICE_DRAW_CONSTANT_BUFFER_NOT_SET                                         = 0x0000015e,
    D3D10_MESSAGE_ID_DEVICE_DRAW_CONSTANT_BUFFER_TOO_SMALL                                       = 0x0000015f,
    D3D10_MESSAGE_ID_DEVICE_DRAW_SAMPLER_NOT_SET                                                 = 0x00000160,
    D3D10_MESSAGE_ID_DEVICE_DRAW_SHADERRESOURCEVIEW_NOT_SET                                      = 0x00000161,
    D3D10_MESSAGE_ID_DEVICE_DRAW_VIEW_DIMENSION_MISMATCH                                         = 0x00000162,
    D3D10_MESSAGE_ID_DEVICE_DRAW_VERTEX_BUFFER_STRIDE_TOO_SMALL                                  = 0x00000163,
    D3D10_MESSAGE_ID_DEVICE_DRAW_VERTEX_BUFFER_TOO_SMALL                                         = 0x00000164,
    D3D10_MESSAGE_ID_DEVICE_DRAW_INDEX_BUFFER_NOT_SET                                            = 0x00000165,
    D3D10_MESSAGE_ID_DEVICE_DRAW_INDEX_BUFFER_FORMAT_INVALID                                     = 0x00000166,
    D3D10_MESSAGE_ID_DEVICE_DRAW_INDEX_BUFFER_TOO_SMALL                                          = 0x00000167,
    D3D10_MESSAGE_ID_DEVICE_DRAW_GS_INPUT_PRIMITIVE_MISMATCH                                     = 0x00000168,
    D3D10_MESSAGE_ID_DEVICE_DRAW_RESOURCE_RETURN_TYPE_MISMATCH                                   = 0x00000169,
    D3D10_MESSAGE_ID_DEVICE_DRAW_POSITION_NOT_PRESENT                                            = 0x0000016a,
    D3D10_MESSAGE_ID_DEVICE_DRAW_OUTPUT_STREAM_NOT_SET                                           = 0x0000016b,
    D3D10_MESSAGE_ID_DEVICE_DRAW_BOUND_RESOURCE_MAPPED                                           = 0x0000016c,
    D3D10_MESSAGE_ID_DEVICE_DRAW_INVALID_PRIMITIVETOPOLOGY                                       = 0x0000016d,
    D3D10_MESSAGE_ID_DEVICE_DRAW_VERTEX_OFFSET_UNALIGNED                                         = 0x0000016e,
    D3D10_MESSAGE_ID_DEVICE_DRAW_VERTEX_STRIDE_UNALIGNED                                         = 0x0000016f,
    D3D10_MESSAGE_ID_DEVICE_DRAW_INDEX_OFFSET_UNALIGNED                                          = 0x00000170,
    D3D10_MESSAGE_ID_DEVICE_DRAW_OUTPUT_STREAM_OFFSET_UNALIGNED                                  = 0x00000171,
    D3D10_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_LD_UNSUPPORTED                                  = 0x00000172,
    D3D10_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_SAMPLE_UNSUPPORTED                              = 0x00000173,
    D3D10_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_SAMPLE_C_UNSUPPORTED                            = 0x00000174,
    D3D10_MESSAGE_ID_DEVICE_DRAW_RESOURCE_MULTISAMPLE_UNSUPPORTED                                = 0x00000175,
    D3D10_MESSAGE_ID_DEVICE_DRAW_SO_TARGETS_BOUND_WITHOUT_SOURCE                                 = 0x00000176,
    D3D10_MESSAGE_ID_DEVICE_DRAW_SO_STRIDE_LARGER_THAN_BUFFER                                    = 0x00000177,
    D3D10_MESSAGE_ID_DEVICE_DRAW_OM_RENDER_TARGET_DOES_NOT_SUPPORT_BLENDING                      = 0x00000178,
    D3D10_MESSAGE_ID_DEVICE_DRAW_OM_DUAL_SOURCE_BLENDING_CAN_ONLY_HAVE_RENDER_TARGET_0           = 0x00000179,
    D3D10_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_AT_FAULT                                             = 0x0000017a,
    D3D10_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_POSSIBLY_AT_FAULT                                    = 0x0000017b,
    D3D10_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_NOT_AT_FAULT                                         = 0x0000017c,
    D3D10_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE_INVALIDARG_RETURN                               = 0x0000017d,
    D3D10_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE_OUTOFMEMORY_RETURN                              = 0x0000017e,
    D3D10_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE_BADINTERFACE_RETURN                             = 0x0000017f,
    D3D10_MESSAGE_ID_DEVICE_DRAW_VIEWPORT_NOT_SET                                                = 0x00000180,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_TRAILING_DIGIT_IN_SEMANTIC                                = 0x00000181,
    D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_TRAILING_DIGIT_IN_SEMANTIC             = 0x00000182,
    D3D10_MESSAGE_ID_DEVICE_RSSETVIEWPORTS_DENORMFLUSH                                           = 0x00000183,
    D3D10_MESSAGE_ID_OMSETRENDERTARGETS_INVALIDVIEW                                              = 0x00000184,
    D3D10_MESSAGE_ID_DEVICE_SETTEXTFILTERSIZE_INVALIDDIMENSIONS                                  = 0x00000185,
    D3D10_MESSAGE_ID_DEVICE_DRAW_SAMPLER_MISMATCH                                                = 0x00000186,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_TYPE_MISMATCH                                             = 0x00000187,
    D3D10_MESSAGE_ID_BLENDSTATE_GETDESC_LEGACY                                                   = 0x00000188,
    D3D10_MESSAGE_ID_SHADERRESOURCEVIEW_GETDESC_LEGACY                                           = 0x00000189,
    D3D10_MESSAGE_ID_CREATEQUERY_OUTOFMEMORY_RETURN                                              = 0x0000018a,
    D3D10_MESSAGE_ID_CREATEPREDICATE_OUTOFMEMORY_RETURN                                          = 0x0000018b,
    D3D10_MESSAGE_ID_CREATECOUNTER_OUTOFRANGE_COUNTER                                            = 0x0000018c,
    D3D10_MESSAGE_ID_CREATECOUNTER_SIMULTANEOUS_ACTIVE_COUNTERS_EXHAUSTED                        = 0x0000018d,
    D3D10_MESSAGE_ID_CREATECOUNTER_UNSUPPORTED_WELLKNOWN_COUNTER                                 = 0x0000018e,
    D3D10_MESSAGE_ID_CREATECOUNTER_OUTOFMEMORY_RETURN                                            = 0x0000018f,
    D3D10_MESSAGE_ID_CREATECOUNTER_NONEXCLUSIVE_RETURN                                           = 0x00000190,
    D3D10_MESSAGE_ID_CREATECOUNTER_NULLDESC                                                      = 0x00000191,
    D3D10_MESSAGE_ID_CHECKCOUNTER_OUTOFRANGE_COUNTER                                             = 0x00000192,
    D3D10_MESSAGE_ID_CHECKCOUNTER_UNSUPPORTED_WELLKNOWN_COUNTER                                  = 0x00000193,
    D3D10_MESSAGE_ID_SETPREDICATION_INVALID_PREDICATE_STATE                                      = 0x00000194,
    D3D10_MESSAGE_ID_QUERY_BEGIN_UNSUPPORTED                                                     = 0x00000195,
    D3D10_MESSAGE_ID_PREDICATE_BEGIN_DURING_PREDICATION                                          = 0x00000196,
    D3D10_MESSAGE_ID_QUERY_BEGIN_DUPLICATE                                                       = 0x00000197,
    D3D10_MESSAGE_ID_QUERY_BEGIN_ABANDONING_PREVIOUS_RESULTS                                     = 0x00000198,
    D3D10_MESSAGE_ID_PREDICATE_END_DURING_PREDICATION                                            = 0x00000199,
    D3D10_MESSAGE_ID_QUERY_END_ABANDONING_PREVIOUS_RESULTS                                       = 0x0000019a,
    D3D10_MESSAGE_ID_QUERY_END_WITHOUT_BEGIN                                                     = 0x0000019b,
    D3D10_MESSAGE_ID_QUERY_GETDATA_INVALID_DATASIZE                                              = 0x0000019c,
    D3D10_MESSAGE_ID_QUERY_GETDATA_INVALID_FLAGS                                                 = 0x0000019d,
    D3D10_MESSAGE_ID_QUERY_GETDATA_INVALID_CALL                                                  = 0x0000019e,
    D3D10_MESSAGE_ID_DEVICE_DRAW_PS_OUTPUT_TYPE_MISMATCH                                         = 0x0000019f,
    D3D10_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_GATHER_UNSUPPORTED                              = 0x000001a0,
    D3D10_MESSAGE_ID_DEVICE_DRAW_INVALID_USE_OF_CENTER_MULTISAMPLE_PATTERN                       = 0x000001a1,
    D3D10_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_STRIDE_TOO_LARGE                                  = 0x000001a2,
    D3D10_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_INVALIDRANGE                                      = 0x000001a3,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_EMPTY_LAYOUT                                              = 0x000001a4,
    D3D10_MESSAGE_ID_DEVICE_DRAW_RESOURCE_SAMPLE_COUNT_MISMATCH                                  = 0x000001a5,
    D3D10_MESSAGE_ID_LIVE_OBJECT_SUMMARY                                                         = 0x000001a6,
    D3D10_MESSAGE_ID_LIVE_BUFFER                                                                 = 0x000001a7,
    D3D10_MESSAGE_ID_LIVE_TEXTURE1D                                                              = 0x000001a8,
    D3D10_MESSAGE_ID_LIVE_TEXTURE2D                                                              = 0x000001a9,
    D3D10_MESSAGE_ID_LIVE_TEXTURE3D                                                              = 0x000001aa,
    D3D10_MESSAGE_ID_LIVE_SHADERRESOURCEVIEW                                                     = 0x000001ab,
    D3D10_MESSAGE_ID_LIVE_RENDERTARGETVIEW                                                       = 0x000001ac,
    D3D10_MESSAGE_ID_LIVE_DEPTHSTENCILVIEW                                                       = 0x000001ad,
    D3D10_MESSAGE_ID_LIVE_VERTEXSHADER                                                           = 0x000001ae,
    D3D10_MESSAGE_ID_LIVE_GEOMETRYSHADER                                                         = 0x000001af,
    D3D10_MESSAGE_ID_LIVE_PIXELSHADER                                                            = 0x000001b0,
    D3D10_MESSAGE_ID_LIVE_INPUTLAYOUT                                                            = 0x000001b1,
    D3D10_MESSAGE_ID_LIVE_SAMPLER                                                                = 0x000001b2,
    D3D10_MESSAGE_ID_LIVE_BLENDSTATE                                                             = 0x000001b3,
    D3D10_MESSAGE_ID_LIVE_DEPTHSTENCILSTATE                                                      = 0x000001b4,
    D3D10_MESSAGE_ID_LIVE_RASTERIZERSTATE                                                        = 0x000001b5,
    D3D10_MESSAGE_ID_LIVE_QUERY                                                                  = 0x000001b6,
    D3D10_MESSAGE_ID_LIVE_PREDICATE                                                              = 0x000001b7,
    D3D10_MESSAGE_ID_LIVE_COUNTER                                                                = 0x000001b8,
    D3D10_MESSAGE_ID_LIVE_DEVICE                                                                 = 0x000001b9,
    D3D10_MESSAGE_ID_LIVE_SWAPCHAIN                                                              = 0x000001ba,
    D3D10_MESSAGE_ID_D3D10_MESSAGES_END                                                          = 0x000001bb,
    D3D10_MESSAGE_ID_D3D10L9_MESSAGES_START                                                      = 0x00100000,
    D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_STENCIL_NO_TWO_SIDED                                = 0x00100001,
    D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_DepthBiasClamp_NOT_SUPPORTED                          = 0x00100002,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_NO_COMPARISON_SUPPORT                                    = 0x00100003,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_EXCESSIVE_ANISOTROPY                                     = 0x00100004,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_BORDER_OUT_OF_RANGE                                      = 0x00100005,
    D3D10_MESSAGE_ID_VSSETSAMPLERS_NOT_SUPPORTED                                                 = 0x00100006,
    D3D10_MESSAGE_ID_VSSETSAMPLERS_TOO_MANY_SAMPLERS                                             = 0x00100007,
    D3D10_MESSAGE_ID_PSSETSAMPLERS_TOO_MANY_SAMPLERS                                             = 0x00100008,
    D3D10_MESSAGE_ID_CREATERESOURCE_NO_ARRAYS                                                    = 0x00100009,
    D3D10_MESSAGE_ID_CREATERESOURCE_NO_VB_AND_IB_BIND                                            = 0x0010000a,
    D3D10_MESSAGE_ID_CREATERESOURCE_NO_TEXTURE_1D                                                = 0x0010000b,
    D3D10_MESSAGE_ID_CREATERESOURCE_DIMENSION_OUT_OF_RANGE                                       = 0x0010000c,
    D3D10_MESSAGE_ID_CREATERESOURCE_NOT_BINDABLE_AS_SHADER_RESOURCE                              = 0x0010000d,
    D3D10_MESSAGE_ID_OMSETRENDERTARGETS_TOO_MANY_RENDER_TARGETS                                  = 0x0010000e,
    D3D10_MESSAGE_ID_OMSETRENDERTARGETS_NO_DIFFERING_BIT_DEPTHS                                  = 0x0010000f,
    D3D10_MESSAGE_ID_IASETVERTEXBUFFERS_BAD_BUFFER_INDEX                                         = 0x00100010,
    D3D10_MESSAGE_ID_DEVICE_RSSETVIEWPORTS_TOO_MANY_VIEWPORTS                                    = 0x00100011,
    D3D10_MESSAGE_ID_DEVICE_IASETPRIMITIVETOPOLOGY_ADJACENCY_UNSUPPORTED                         = 0x00100012,
    D3D10_MESSAGE_ID_DEVICE_RSSETSCISSORRECTS_TOO_MANY_SCISSORS                                  = 0x00100013,
    D3D10_MESSAGE_ID_COPYRESOURCE_ONLY_TEXTURE_2D_WITHIN_GPU_MEMORY                              = 0x00100014,
    D3D10_MESSAGE_ID_COPYRESOURCE_NO_TEXTURE_3D_READBACK                                         = 0x00100015,
    D3D10_MESSAGE_ID_COPYRESOURCE_NO_TEXTURE_ONLY_READBACK                                       = 0x00100016,
    D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_UNSUPPORTED_FORMAT                                        = 0x00100017,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_NO_ALPHA_TO_COVERAGE                                       = 0x00100018,
    D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_DepthClipEnable_MUST_BE_TRUE                          = 0x00100019,
    D3D10_MESSAGE_ID_DRAWINDEXED_STARTINDEXLOCATION_MUST_BE_POSITIVE                             = 0x0010001a,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_MUST_USE_LOWEST_LOD                                = 0x0010001b,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_MINLOD_MUST_NOT_BE_FRACTIONAL                            = 0x0010001c,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_MAXLOD_MUST_BE_FLT_MAX                                   = 0x0010001d,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_FIRSTARRAYSLICE_MUST_BE_ZERO                       = 0x0010001e,
    D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_CUBES_MUST_HAVE_6_SIDES                            = 0x0010001f,
    D3D10_MESSAGE_ID_CREATERESOURCE_NOT_BINDABLE_AS_RENDER_TARGET                                = 0x00100020,
    D3D10_MESSAGE_ID_CREATERESOURCE_NO_DWORD_INDEX_BUFFER                                        = 0x00100021,
    D3D10_MESSAGE_ID_CREATERESOURCE_MSAA_PRECLUDES_SHADER_RESOURCE                               = 0x00100022,
    D3D10_MESSAGE_ID_CREATERESOURCE_PRESENTATION_PRECLUDES_SHADER_RESOURCE                       = 0x00100023,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_NO_INDEPENDENT_BLEND_ENABLE                                = 0x00100024,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_NO_INDEPENDENT_WRITE_MASKS                                 = 0x00100025,
    D3D10_MESSAGE_ID_CREATERESOURCE_NO_STREAM_OUT                                                = 0x00100026,
    D3D10_MESSAGE_ID_CREATERESOURCE_ONLY_VB_IB_FOR_BUFFERS                                       = 0x00100027,
    D3D10_MESSAGE_ID_CREATERESOURCE_NO_AUTOGEN_FOR_VOLUMES                                       = 0x00100028,
    D3D10_MESSAGE_ID_CREATERESOURCE_DXGI_FORMAT_R8G8B8A8_CANNOT_BE_SHARED                        = 0x00100029,
    D3D10_MESSAGE_ID_VSSHADERRESOURCES_NOT_SUPPORTED                                             = 0x0010002a,
    D3D10_MESSAGE_ID_GEOMETRY_SHADER_NOT_SUPPORTED                                               = 0x0010002b,
    D3D10_MESSAGE_ID_STREAM_OUT_NOT_SUPPORTED                                                    = 0x0010002c,
    D3D10_MESSAGE_ID_TEXT_FILTER_NOT_SUPPORTED                                                   = 0x0010002d,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_NO_SEPARATE_ALPHA_BLEND                                    = 0x0010002e,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_NO_MRT_BLEND                                               = 0x0010002f,
    D3D10_MESSAGE_ID_CREATEBLENDSTATE_OPERATION_NOT_SUPPORTED                                    = 0x00100030,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_NO_MIRRORONCE                                            = 0x00100031,
    D3D10_MESSAGE_ID_DRAWINSTANCED_NOT_SUPPORTED                                                 = 0x00100032,
    D3D10_MESSAGE_ID_DRAWINDEXEDINSTANCED_NOT_SUPPORTED_BELOW_9_3                                = 0x00100033,
    D3D10_MESSAGE_ID_DRAWINDEXED_POINTLIST_UNSUPPORTED                                           = 0x00100034,
    D3D10_MESSAGE_ID_SETBLENDSTATE_SAMPLE_MASK_CANNOT_BE_ZERO                                    = 0x00100035,
    D3D10_MESSAGE_ID_CREATERESOURCE_DIMENSION_EXCEEDS_FEATURE_LEVEL_DEFINITION                   = 0x00100036,
    D3D10_MESSAGE_ID_CREATERESOURCE_ONLY_SINGLE_MIP_LEVEL_DEPTH_STENCIL_SUPPORTED                = 0x00100037,
    D3D10_MESSAGE_ID_DEVICE_RSSETSCISSORRECTS_NEGATIVESCISSOR                                    = 0x00100038,
    D3D10_MESSAGE_ID_SLOT_ZERO_MUST_BE_D3D10_INPUT_PER_VERTEX_DATA                               = 0x00100039,
    D3D10_MESSAGE_ID_CREATERESOURCE_NON_POW_2_MIPMAP                                             = 0x0010003a,
    D3D10_MESSAGE_ID_CREATESAMPLERSTATE_BORDER_NOT_SUPPORTED                                     = 0x0010003b,
    D3D10_MESSAGE_ID_OMSETRENDERTARGETS_NO_SRGB_MRT                                              = 0x0010003c,
    D3D10_MESSAGE_ID_COPYRESOURCE_NO_3D_MISMATCHED_UPDATES                                       = 0x0010003d,
    D3D10_MESSAGE_ID_D3D10L9_MESSAGES_END                                                        = 0x0010003e,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10misc/ne-d3d10misc-d3d10_driver_type
alias D3D10_DRIVER_TYPE = int;
enum : int
{
    D3D10_DRIVER_TYPE_HARDWARE  = 0x00000000,
    D3D10_DRIVER_TYPE_REFERENCE = 0x00000001,
    D3D10_DRIVER_TYPE_NULL      = 0x00000002,
    D3D10_DRIVER_TYPE_SOFTWARE  = 0x00000003,
    D3D10_DRIVER_TYPE_WARP      = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/ne-d3d10effect-d3d10_device_state_types
alias D3D10_DEVICE_STATE_TYPES = int;
enum : int
{
    D3D10_DST_SO_BUFFERS             = 0x00000001,
    D3D10_DST_OM_RENDER_TARGETS      = 0x00000002,
    D3D10_DST_OM_DEPTH_STENCIL_STATE = 0x00000003,
    D3D10_DST_OM_BLEND_STATE         = 0x00000004,
    D3D10_DST_VS                     = 0x00000005,
    D3D10_DST_VS_SAMPLERS            = 0x00000006,
    D3D10_DST_VS_SHADER_RESOURCES    = 0x00000007,
    D3D10_DST_VS_CONSTANT_BUFFERS    = 0x00000008,
    D3D10_DST_GS                     = 0x00000009,
    D3D10_DST_GS_SAMPLERS            = 0x0000000a,
    D3D10_DST_GS_SHADER_RESOURCES    = 0x0000000b,
    D3D10_DST_GS_CONSTANT_BUFFERS    = 0x0000000c,
    D3D10_DST_PS                     = 0x0000000d,
    D3D10_DST_PS_SAMPLERS            = 0x0000000e,
    D3D10_DST_PS_SHADER_RESOURCES    = 0x0000000f,
    D3D10_DST_PS_CONSTANT_BUFFERS    = 0x00000010,
    D3D10_DST_IA_VERTEX_BUFFERS      = 0x00000011,
    D3D10_DST_IA_INDEX_BUFFER        = 0x00000012,
    D3D10_DST_IA_INPUT_LAYOUT        = 0x00000013,
    D3D10_DST_IA_PRIMITIVE_TOPOLOGY  = 0x00000014,
    D3D10_DST_RS_VIEWPORTS           = 0x00000015,
    D3D10_DST_RS_SCISSOR_RECTS       = 0x00000016,
    D3D10_DST_RS_RASTERIZER_STATE    = 0x00000017,
    D3D10_DST_PREDICATION            = 0x00000018,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1/ne-d3d10_1-d3d10_feature_level1
alias D3D10_FEATURE_LEVEL1 = int;
enum : int
{
    D3D10_FEATURE_LEVEL_10_0 = 0x0000a000,
    D3D10_FEATURE_LEVEL_10_1 = 0x0000a100,
    D3D10_FEATURE_LEVEL_9_1  = 0x00009100,
    D3D10_FEATURE_LEVEL_9_2  = 0x00009200,
    D3D10_FEATURE_LEVEL_9_3  = 0x00009300,
}

alias D3D10_STANDARD_MULTISAMPLE_QUALITY_LEVELS = int;
enum : int
{
    D3D10_STANDARD_MULTISAMPLE_PATTERN = 0xffffffff,
    D3D10_CENTER_MULTISAMPLE_PATTERN   = 0xfffffffe,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1shader/ne-d3d10_1shader-d3d10_shader_debug_regtype
alias D3D10_SHADER_DEBUG_REGTYPE = int;
enum : int
{
    D3D10_SHADER_DEBUG_REG_INPUT              = 0x00000000,
    D3D10_SHADER_DEBUG_REG_OUTPUT             = 0x00000001,
    D3D10_SHADER_DEBUG_REG_CBUFFER            = 0x00000002,
    D3D10_SHADER_DEBUG_REG_TBUFFER            = 0x00000003,
    D3D10_SHADER_DEBUG_REG_TEMP               = 0x00000004,
    D3D10_SHADER_DEBUG_REG_TEMPARRAY          = 0x00000005,
    D3D10_SHADER_DEBUG_REG_TEXTURE            = 0x00000006,
    D3D10_SHADER_DEBUG_REG_SAMPLER            = 0x00000007,
    D3D10_SHADER_DEBUG_REG_IMMEDIATECBUFFER   = 0x00000008,
    D3D10_SHADER_DEBUG_REG_LITERAL            = 0x00000009,
    D3D10_SHADER_DEBUG_REG_UNUSED             = 0x0000000a,
    D3D11_SHADER_DEBUG_REG_INTERFACE_POINTERS = 0x0000000b,
    D3D11_SHADER_DEBUG_REG_UAV                = 0x0000000c,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1shader/ne-d3d10_1shader-d3d10_shader_debug_scopetype
alias D3D10_SHADER_DEBUG_SCOPETYPE = int;
enum : int
{
    D3D10_SHADER_DEBUG_SCOPE_GLOBAL      = 0x00000000,
    D3D10_SHADER_DEBUG_SCOPE_BLOCK       = 0x00000001,
    D3D10_SHADER_DEBUG_SCOPE_FORLOOP     = 0x00000002,
    D3D10_SHADER_DEBUG_SCOPE_STRUCT      = 0x00000003,
    D3D10_SHADER_DEBUG_SCOPE_FUNC_PARAMS = 0x00000004,
    D3D10_SHADER_DEBUG_SCOPE_STATEBLOCK  = 0x00000005,
    D3D10_SHADER_DEBUG_SCOPE_NAMESPACE   = 0x00000006,
    D3D10_SHADER_DEBUG_SCOPE_ANNOTATION  = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1shader/ne-d3d10_1shader-d3d10_shader_debug_vartype
alias D3D10_SHADER_DEBUG_VARTYPE = int;
enum : int
{
    D3D10_SHADER_DEBUG_VAR_VARIABLE = 0x00000000,
    D3D10_SHADER_DEBUG_VAR_FUNCTION = 0x00000001,
}

// Constants


enum uint D3D10_16BIT_INDEX_STRIP_CUT_VALUE = 0x0000ffffU;
enum uint D3D10_32BIT_INDEX_STRIP_CUT_VALUE = 0xffffffffU;
enum uint D3D10_8BIT_INDEX_STRIP_CUT_VALUE = 0x000000ffU;
enum uint D3D10_ARRAY_AXIS_ADDRESS_RANGE_BIT_COUNT = 0x00000009U;

enum : uint
{
    D3D10_CLIP_OR_CULL_DISTANCE_COUNT         = 0x00000008U,
    D3D10_CLIP_OR_CULL_DISTANCE_ELEMENT_COUNT = 0x00000002U,
}

enum : uint
{
    D3D10_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT          = 0x0000000eU,
    D3D10_COMMONSHADER_CONSTANT_BUFFER_COMPONENTS              = 0x00000004U,
    D3D10_COMMONSHADER_CONSTANT_BUFFER_COMPONENT_BIT_COUNT     = 0x00000020U,
    D3D10_COMMONSHADER_CONSTANT_BUFFER_HW_SLOT_COUNT           = 0x0000000fU,
    D3D10_COMMONSHADER_CONSTANT_BUFFER_REGISTER_COMPONENTS     = 0x00000004U,
    D3D10_COMMONSHADER_CONSTANT_BUFFER_REGISTER_COUNT          = 0x0000000fU,
    D3D10_COMMONSHADER_CONSTANT_BUFFER_REGISTER_READS_PER_INST = 0x00000001U,
    D3D10_COMMONSHADER_CONSTANT_BUFFER_REGISTER_READ_PORTS     = 0x00000001U,
}

enum : uint
{
    D3D10_COMMONSHADER_FLOWCONTROL_NESTING_LIMIT                         = 0x00000040U,
    D3D10_COMMONSHADER_IMMEDIATE_CONSTANT_BUFFER_REGISTER_COMPONENTS     = 0x00000004U,
    D3D10_COMMONSHADER_IMMEDIATE_CONSTANT_BUFFER_REGISTER_COUNT          = 0x00000001U,
    D3D10_COMMONSHADER_IMMEDIATE_CONSTANT_BUFFER_REGISTER_READS_PER_INST = 0x00000001U,
    D3D10_COMMONSHADER_IMMEDIATE_CONSTANT_BUFFER_REGISTER_READ_PORTS     = 0x00000001U,
    D3D10_COMMONSHADER_IMMEDIATE_VALUE_COMPONENT_BIT_COUNT               = 0x00000020U,
}

enum : uint
{
    D3D10_COMMONSHADER_INPUT_RESOURCE_REGISTER_COMPONENTS     = 0x00000001U,
    D3D10_COMMONSHADER_INPUT_RESOURCE_REGISTER_COUNT          = 0x00000080U,
    D3D10_COMMONSHADER_INPUT_RESOURCE_REGISTER_READS_PER_INST = 0x00000001U,
    D3D10_COMMONSHADER_INPUT_RESOURCE_REGISTER_READ_PORTS     = 0x00000001U,
    D3D10_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT              = 0x00000080U,
    D3D10_COMMONSHADER_SAMPLER_REGISTER_COMPONENTS            = 0x00000001U,
    D3D10_COMMONSHADER_SAMPLER_REGISTER_COUNT                 = 0x00000010U,
    D3D10_COMMONSHADER_SAMPLER_REGISTER_READS_PER_INST        = 0x00000001U,
    D3D10_COMMONSHADER_SAMPLER_REGISTER_READ_PORTS            = 0x00000001U,
    D3D10_COMMONSHADER_SAMPLER_SLOT_COUNT                     = 0x00000010U,
    D3D10_COMMONSHADER_SUBROUTINE_NESTING_LIMIT               = 0x00000020U,
    D3D10_COMMONSHADER_TEMP_REGISTER_COMPONENTS               = 0x00000004U,
    D3D10_COMMONSHADER_TEMP_REGISTER_COMPONENT_BIT_COUNT      = 0x00000020U,
    D3D10_COMMONSHADER_TEMP_REGISTER_COUNT                    = 0x00001000U,
    D3D10_COMMONSHADER_TEMP_REGISTER_READS_PER_INST           = 0x00000003U,
    D3D10_COMMONSHADER_TEMP_REGISTER_READ_PORTS               = 0x00000003U,
    D3D10_COMMONSHADER_TEXCOORD_RANGE_REDUCTION_MAX           = 0x0000000aU,
}

enum : int
{
    D3D10_COMMONSHADER_TEXCOORD_RANGE_REDUCTION_MIN = 0xfffffff6,
    D3D10_COMMONSHADER_TEXEL_OFFSET_MAX_NEGATIVE    = 0xfffffff8,
}

enum uint D3D10_COMMONSHADER_TEXEL_OFFSET_MAX_POSITIVE = 0x00000007U;

enum : float
{
    D3D10_DEFAULT_BLEND_FACTOR_ALPHA     = 0x1p+0,
    D3D10_DEFAULT_BLEND_FACTOR_BLUE      = 0x1p+0,
    D3D10_DEFAULT_BLEND_FACTOR_GREEN     = 0x1p+0,
    D3D10_DEFAULT_BLEND_FACTOR_RED       = 0x1p+0,
    D3D10_DEFAULT_BORDER_COLOR_COMPONENT = 0x0p+0,
}

enum uint D3D10_DEFAULT_DEPTH_BIAS = 0x00000000U;

enum : float
{
    D3D10_DEFAULT_DEPTH_BIAS_CLAMP = 0x0p+0,
    D3D10_DEFAULT_MAX_ANISOTROPY   = 0x1p+4,
    D3D10_DEFAULT_MIP_LOD_BIAS     = 0x0p+0,
}

enum uint D3D10_DEFAULT_RENDER_TARGET_ARRAY_INDEX = 0x00000000U;

enum : uint
{
    D3D10_DEFAULT_SAMPLE_MASK    = 0xffffffffU,
    D3D10_DEFAULT_SCISSOR_ENDX   = 0x00000000U,
    D3D10_DEFAULT_SCISSOR_ENDY   = 0x00000000U,
    D3D10_DEFAULT_SCISSOR_STARTX = 0x00000000U,
    D3D10_DEFAULT_SCISSOR_STARTY = 0x00000000U,
}

enum float D3D10_DEFAULT_SLOPE_SCALED_DEPTH_BIAS = 0x0p+0;

enum : uint
{
    D3D10_DEFAULT_STENCIL_READ_MASK              = 0x000000ffU,
    D3D10_DEFAULT_STENCIL_REFERENCE              = 0x00000000U,
    D3D10_DEFAULT_STENCIL_WRITE_MASK             = 0x000000ffU,
    D3D10_DEFAULT_VIEWPORT_AND_SCISSORRECT_INDEX = 0x00000000U,
    D3D10_DEFAULT_VIEWPORT_HEIGHT                = 0x00000000U,
}

enum : float
{
    D3D10_DEFAULT_VIEWPORT_MAX_DEPTH = 0x0p+0,
    D3D10_DEFAULT_VIEWPORT_MIN_DEPTH = 0x0p+0,
}

enum : uint
{
    D3D10_DEFAULT_VIEWPORT_TOPLEFTX = 0x00000000U,
    D3D10_DEFAULT_VIEWPORT_TOPLEFTY = 0x00000000U,
    D3D10_DEFAULT_VIEWPORT_WIDTH    = 0x00000000U,
}

enum double D3D10_FLOAT16_FUSED_TOLERANCE_IN_ULP = 0x1.3333333333333p-1;

enum : float
{
    D3D10_FLOAT32_MAX                         = 0x1.fffffep+127,
    D3D10_FLOAT32_TO_INTEGER_TOLERANCE_IN_ULP = 0x1.333334p-1,
}

enum : float
{
    D3D10_FLOAT_TO_SRGB_EXPONENT_DENOMINATOR = 0x1.333334p+1,
    D3D10_FLOAT_TO_SRGB_EXPONENT_NUMERATOR   = 0x1p+0,
    D3D10_FLOAT_TO_SRGB_OFFSET               = 0x1.c28f5cp-5,
    D3D10_FLOAT_TO_SRGB_SCALE_1              = 0x1.9d70a4p+3,
    D3D10_FLOAT_TO_SRGB_SCALE_2              = 0x1.0e147ap+0,
    D3D10_FLOAT_TO_SRGB_THRESHOLD            = 0x1.9a5c38p-9,
}

enum : float
{
    D3D10_FTOI_INSTRUCTION_MAX_INPUT = 0x1p+31,
    D3D10_FTOI_INSTRUCTION_MIN_INPUT = -0x1p+31,
}

enum : float
{
    D3D10_FTOU_INSTRUCTION_MAX_INPUT = 0x1p+32,
    D3D10_FTOU_INSTRUCTION_MIN_INPUT = 0x0p+0,
}

enum : uint
{
    D3D10_GS_INPUT_PRIM_CONST_REGISTER_COMPONENTS          = 0x00000001U,
    D3D10_GS_INPUT_PRIM_CONST_REGISTER_COMPONENT_BIT_COUNT = 0x00000020U,
    D3D10_GS_INPUT_PRIM_CONST_REGISTER_COUNT               = 0x00000001U,
    D3D10_GS_INPUT_PRIM_CONST_REGISTER_READS_PER_INST      = 0x00000002U,
    D3D10_GS_INPUT_PRIM_CONST_REGISTER_READ_PORTS          = 0x00000001U,
}

enum : uint
{
    D3D10_GS_INPUT_REGISTER_COMPONENTS          = 0x00000004U,
    D3D10_GS_INPUT_REGISTER_COMPONENT_BIT_COUNT = 0x00000020U,
    D3D10_GS_INPUT_REGISTER_COUNT               = 0x00000010U,
    D3D10_GS_INPUT_REGISTER_READS_PER_INST      = 0x00000002U,
    D3D10_GS_INPUT_REGISTER_READ_PORTS          = 0x00000001U,
    D3D10_GS_INPUT_REGISTER_VERTICES            = 0x00000006U,
}

enum : uint
{
    D3D10_GS_OUTPUT_ELEMENTS                     = 0x00000020U,
    D3D10_GS_OUTPUT_REGISTER_COMPONENTS          = 0x00000004U,
    D3D10_GS_OUTPUT_REGISTER_COMPONENT_BIT_COUNT = 0x00000020U,
    D3D10_GS_OUTPUT_REGISTER_COUNT               = 0x00000020U,
}

enum uint D3D10_IA_DEFAULT_INDEX_BUFFER_OFFSET_IN_BYTES = 0x00000000U;

enum : uint
{
    D3D10_IA_DEFAULT_PRIMITIVE_TOPOLOGY            = 0x00000000U,
    D3D10_IA_DEFAULT_VERTEX_BUFFER_OFFSET_IN_BYTES = 0x00000000U,
}

enum uint D3D10_IA_INDEX_INPUT_RESOURCE_SLOT_COUNT = 0x00000001U;
enum uint D3D10_IA_INSTANCE_ID_BIT_COUNT = 0x00000020U;
enum uint D3D10_IA_INTEGER_ARITHMETIC_BIT_COUNT = 0x00000020U;
enum uint D3D10_IA_PRIMITIVE_ID_BIT_COUNT = 0x00000020U;

enum : uint
{
    D3D10_IA_VERTEX_ID_BIT_COUNT                        = 0x00000020U,
    D3D10_IA_VERTEX_INPUT_RESOURCE_SLOT_COUNT           = 0x00000010U,
    D3D10_IA_VERTEX_INPUT_STRUCTURE_ELEMENTS_COMPONENTS = 0x00000040U,
    D3D10_IA_VERTEX_INPUT_STRUCTURE_ELEMENT_COUNT       = 0x00000010U,
}

enum : uint
{
    D3D10_INTEGER_DIVIDE_BY_ZERO_QUOTIENT  = 0xffffffffU,
    D3D10_INTEGER_DIVIDE_BY_ZERO_REMAINDER = 0xffffffffU,
}

enum float D3D10_LINEAR_GAMMA = 0x1p+0;
enum float D3D10_MAX_BORDER_COLOR_COMPONENT = 0x1p+0;
enum float D3D10_MAX_DEPTH = 0x1p+0;

enum : uint
{
    D3D10_MAX_MAXANISOTROPY            = 0x00000010U,
    D3D10_MAX_MULTISAMPLE_SAMPLE_COUNT = 0x00000020U,
}

enum float D3D10_MAX_POSITION_VALUE = 0x1.a36e2ep+114;
enum uint D3D10_MAX_TEXTURE_DIMENSION_2_TO_EXP = 0x00000011U;
enum float D3D10_MIN_BORDER_COLOR_COMPONENT = 0x0p+0;
enum float D3D10_MIN_DEPTH = 0x0p+0;
enum uint D3D10_MIN_MAXANISOTROPY = 0x00000000U;

enum : float
{
    D3D10_MIP_LOD_BIAS_MAX = 0x1.ffae14p+3,
    D3D10_MIP_LOD_BIAS_MIN = -0x1p+4,
}

enum : uint
{
    D3D10_MIP_LOD_FRACTIONAL_BIT_COUNT = 0x00000006U,
    D3D10_MIP_LOD_RANGE_BIT_COUNT      = 0x00000008U,
}

enum float D3D10_MULTISAMPLE_ANTIALIAS_LINE_WIDTH = 0x1.666666p+0;
enum uint D3D10_NONSAMPLE_FETCH_OUT_OF_RANGE_ACCESS_RESULT = 0x00000000U;
enum uint D3D10_PIXEL_ADDRESS_RANGE_BIT_COUNT = 0x0000000dU;
enum uint D3D10_PRE_SCISSOR_PIXEL_ADDRESS_RANGE_BIT_COUNT = 0x0000000fU;

enum : uint
{
    D3D10_PS_FRONTFACING_DEFAULT_VALUE = 0xffffffffU,
    D3D10_PS_FRONTFACING_FALSE_VALUE   = 0x00000000U,
    D3D10_PS_FRONTFACING_TRUE_VALUE    = 0xffffffffU,
}

enum : uint
{
    D3D10_PS_INPUT_REGISTER_COMPONENTS          = 0x00000004U,
    D3D10_PS_INPUT_REGISTER_COMPONENT_BIT_COUNT = 0x00000020U,
    D3D10_PS_INPUT_REGISTER_COUNT               = 0x00000020U,
    D3D10_PS_INPUT_REGISTER_READS_PER_INST      = 0x00000002U,
    D3D10_PS_INPUT_REGISTER_READ_PORTS          = 0x00000001U,
}

enum float D3D10_PS_LEGACY_PIXEL_CENTER_FRACTIONAL_COMPONENT = 0x0p+0;

enum : uint
{
    D3D10_PS_OUTPUT_DEPTH_REGISTER_COMPONENTS          = 0x00000001U,
    D3D10_PS_OUTPUT_DEPTH_REGISTER_COMPONENT_BIT_COUNT = 0x00000020U,
    D3D10_PS_OUTPUT_DEPTH_REGISTER_COUNT               = 0x00000001U,
    D3D10_PS_OUTPUT_REGISTER_COMPONENTS                = 0x00000004U,
    D3D10_PS_OUTPUT_REGISTER_COMPONENT_BIT_COUNT       = 0x00000020U,
    D3D10_PS_OUTPUT_REGISTER_COUNT                     = 0x00000008U,
}

enum float D3D10_PS_PIXEL_CENTER_FRACTIONAL_COMPONENT = 0x1p-1;
enum uint D3D10_REQ_BLEND_OBJECT_COUNT_PER_CONTEXT = 0x00001000U;
enum uint D3D10_REQ_BUFFER_RESOURCE_TEXEL_COUNT_2_TO_EXP = 0x0000001bU;
enum uint D3D10_REQ_CONSTANT_BUFFER_ELEMENT_COUNT = 0x00001000U;
enum uint D3D10_REQ_DEPTH_STENCIL_OBJECT_COUNT_PER_CONTEXT = 0x00001000U;
enum uint D3D10_REQ_DRAWINDEXED_INDEX_COUNT_2_TO_EXP = 0x00000020U;
enum uint D3D10_REQ_DRAW_VERTEX_COUNT_2_TO_EXP = 0x00000020U;
enum uint D3D10_REQ_FILTERING_HW_ADDRESSABLE_RESOURCE_DIMENSION = 0x00002000U;
enum uint D3D10_REQ_GS_INVOCATION_32BIT_OUTPUT_COMPONENT_LIMIT = 0x00000400U;
enum uint D3D10_REQ_IMMEDIATE_CONSTANT_BUFFER_ELEMENT_COUNT = 0x00001000U;

enum : uint
{
    D3D10_REQ_MAXANISOTROPY                         = 0x00000010U,
    D3D10_REQ_MIP_LEVELS                            = 0x0000000eU,
    D3D10_REQ_MULTI_ELEMENT_STRUCTURE_SIZE_IN_BYTES = 0x00000800U,
}

enum uint D3D10_REQ_RASTERIZER_OBJECT_COUNT_PER_CONTEXT = 0x00001000U;
enum uint D3D10_REQ_RENDER_TO_BUFFER_WINDOW_WIDTH = 0x00002000U;

enum : uint
{
    D3D10_REQ_RESOURCE_SIZE_IN_MEGABYTES               = 0x00000080U,
    D3D10_REQ_RESOURCE_VIEW_COUNT_PER_CONTEXT_2_TO_EXP = 0x00000014U,
}

enum uint D3D10_REQ_SAMPLER_OBJECT_COUNT_PER_CONTEXT = 0x00001000U;

enum : uint
{
    D3D10_REQ_TEXTURE1D_ARRAY_AXIS_DIMENSION = 0x00000200U,
    D3D10_REQ_TEXTURE1D_U_DIMENSION          = 0x00002000U,
    D3D10_REQ_TEXTURE2D_ARRAY_AXIS_DIMENSION = 0x00000200U,
    D3D10_REQ_TEXTURE2D_U_OR_V_DIMENSION     = 0x00002000U,
    D3D10_REQ_TEXTURE3D_U_V_OR_W_DIMENSION   = 0x00000800U,
    D3D10_REQ_TEXTURECUBE_DIMENSION          = 0x00002000U,
}

enum uint D3D10_RESINFO_INSTRUCTION_MISSING_COMPONENT_RETVAL = 0x00000000U;

enum : uint
{
    D3D10_SHADER_MAJOR_VERSION = 0x00000004U,
    D3D10_SHADER_MINOR_VERSION = 0x00000000U,
}

enum : uint
{
    D3D10_SHIFT_INSTRUCTION_PAD_VALUE             = 0x00000000U,
    D3D10_SHIFT_INSTRUCTION_SHIFT_VALUE_BIT_COUNT = 0x00000005U,
}

enum uint D3D10_SIMULTANEOUS_RENDER_TARGET_COUNT = 0x00000008U;

enum : uint
{
    D3D10_SO_BUFFER_MAX_STRIDE_IN_BYTES       = 0x00000800U,
    D3D10_SO_BUFFER_MAX_WRITE_WINDOW_IN_BYTES = 0x00000100U,
}

enum uint D3D10_SO_BUFFER_SLOT_COUNT = 0x00000004U;
enum uint D3D10_SO_DDI_REGISTER_INDEX_DENOTING_GAP = 0xffffffffU;
enum uint D3D10_SO_MULTIPLE_BUFFER_ELEMENTS_PER_BUFFER = 0x00000001U;
enum uint D3D10_SO_SINGLE_BUFFER_COMPONENT_LIMIT = 0x00000040U;

enum : float
{
    D3D10_SRGB_GAMMA                     = 0x1.19999ap+1,
    D3D10_SRGB_TO_FLOAT_DENOMINATOR_1    = 0x1.9d70a4p+3,
    D3D10_SRGB_TO_FLOAT_DENOMINATOR_2    = 0x1.0e147ap+0,
    D3D10_SRGB_TO_FLOAT_EXPONENT         = 0x1.333334p+1,
    D3D10_SRGB_TO_FLOAT_OFFSET           = 0x1.c28f5cp-5,
    D3D10_SRGB_TO_FLOAT_THRESHOLD        = 0x1.4b5dccp-5,
    D3D10_SRGB_TO_FLOAT_TOLERANCE_IN_ULP = 0x1p-1,
}

enum : uint
{
    D3D10_STANDARD_COMPONENT_BIT_COUNT         = 0x00000020U,
    D3D10_STANDARD_COMPONENT_BIT_COUNT_DOUBLED = 0x00000040U,
}

enum uint D3D10_STANDARD_MAXIMUM_ELEMENT_ALIGNMENT_BYTE_MULTIPLE = 0x00000004U;

enum : uint
{
    D3D10_STANDARD_PIXEL_COMPONENT_COUNT        = 0x00000080U,
    D3D10_STANDARD_PIXEL_ELEMENT_COUNT          = 0x00000020U,
    D3D10_STANDARD_VECTOR_SIZE                  = 0x00000004U,
    D3D10_STANDARD_VERTEX_ELEMENT_COUNT         = 0x00000010U,
    D3D10_STANDARD_VERTEX_TOTAL_COMPONENT_COUNT = 0x00000040U,
}

enum uint D3D10_SUBPIXEL_FRACTIONAL_BIT_COUNT = 0x00000008U;
enum uint D3D10_SUBTEXEL_FRACTIONAL_BIT_COUNT = 0x00000006U;
enum uint D3D10_TEXEL_ADDRESS_RANGE_BIT_COUNT = 0x00000012U;
enum uint D3D10_UNBOUND_MEMORY_ACCESS_RESULT = 0x00000000U;

enum : uint
{
    D3D10_VIEWPORT_AND_SCISSORRECT_MAX_INDEX                 = 0x0000000fU,
    D3D10_VIEWPORT_AND_SCISSORRECT_OBJECT_COUNT_PER_PIPELINE = 0x00000010U,
}

enum uint D3D10_VIEWPORT_BOUNDS_MAX = 0x00003fffU;
enum int D3D10_VIEWPORT_BOUNDS_MIN = 0xffffc000;

enum : uint
{
    D3D10_VS_INPUT_REGISTER_COMPONENTS          = 0x00000004U,
    D3D10_VS_INPUT_REGISTER_COMPONENT_BIT_COUNT = 0x00000020U,
    D3D10_VS_INPUT_REGISTER_COUNT               = 0x00000010U,
    D3D10_VS_INPUT_REGISTER_READS_PER_INST      = 0x00000002U,
    D3D10_VS_INPUT_REGISTER_READ_PORTS          = 0x00000001U,
}

enum : uint
{
    D3D10_VS_OUTPUT_REGISTER_COMPONENTS          = 0x00000004U,
    D3D10_VS_OUTPUT_REGISTER_COMPONENT_BIT_COUNT = 0x00000020U,
    D3D10_VS_OUTPUT_REGISTER_COUNT               = 0x00000010U,
}

enum uint D3D10_WHQL_CONTEXT_COUNT_FOR_RESOURCE_LIMIT = 0x0000000aU;
enum uint D3D10_WHQL_DRAWINDEXED_INDEX_COUNT_2_TO_EXP = 0x00000019U;
enum uint D3D10_WHQL_DRAW_VERTEX_COUNT_2_TO_EXP = 0x00000019U;
enum uint D3D_MAJOR_VERSION = 0x0000000aU;
enum uint D3D_MINOR_VERSION = 0x00000000U;

enum : uint
{
    D3D_SPEC_DATE_DAY   = 0x00000008U,
    D3D_SPEC_DATE_MONTH = 0x00000008U,
    D3D_SPEC_DATE_YEAR  = 0x000007d6U,
}

enum double D3D_SPEC_VERSION = 0x1.0ccd20afa2f06p+0;

enum : uint
{
    D3D10_1_IA_VERTEX_INPUT_STRUCTURE_ELEMENT_COUNT = 0x00000010U,
    D3D10_1_IA_VERTEX_INPUT_RESOURCE_SLOT_COUNT     = 0x00000010U,
}

enum uint _FACD3D10 = 0x00000879U;
enum uint D3D10_APPEND_ALIGNED_ELEMENT = 0xffffffffU;
enum uint D3D10_FILTER_TYPE_MASK = 0x00000003U;
enum uint D3D10_MIN_FILTER_SHIFT = 0x00000004U;
enum uint D3D10_MAG_FILTER_SHIFT = 0x00000002U;
enum uint D3D10_MIP_FILTER_SHIFT = 0x00000000U;
enum uint D3D10_COMPARISON_FILTERING_BIT = 0x00000080U;
enum uint D3D10_ANISOTROPIC_FILTERING_BIT = 0x00000040U;
enum uint D3D10_TEXT_1BIT_BIT = 0x80000000U;
enum uint D3D10_SDK_VERSION = 0x0000001dU;
enum uint D3D10_1_DEFAULT_SAMPLE_MASK = 0xffffffffU;
enum double D3D10_1_FLOAT16_FUSED_TOLERANCE_IN_ULP = 0x1.3333333333333p-1;
enum float D3D10_1_FLOAT32_TO_INTEGER_TOLERANCE_IN_ULP = 0x1.333334p-1;
enum uint D3D10_1_GS_INPUT_REGISTER_COUNT = 0x00000020U;
enum uint D3D10_1_IA_VERTEX_INPUT_STRUCTURE_ELEMENTS_COMPONENTS = 0x00000080U;

enum : uint
{
    D3D10_1_PS_OUTPUT_MASK_REGISTER_COMPONENTS          = 0x00000001U,
    D3D10_1_PS_OUTPUT_MASK_REGISTER_COMPONENT_BIT_COUNT = 0x00000020U,
    D3D10_1_PS_OUTPUT_MASK_REGISTER_COUNT               = 0x00000001U,
}

enum : uint
{
    D3D10_1_SHADER_MAJOR_VERSION = 0x00000004U,
    D3D10_1_SHADER_MINOR_VERSION = 0x00000001U,
}

enum : uint
{
    D3D10_1_SO_BUFFER_MAX_STRIDE_IN_BYTES       = 0x00000800U,
    D3D10_1_SO_BUFFER_MAX_WRITE_WINDOW_IN_BYTES = 0x00000100U,
    D3D10_1_SO_BUFFER_SLOT_COUNT                = 0x00000004U,
}

enum uint D3D10_1_SO_MULTIPLE_BUFFER_ELEMENTS_PER_BUFFER = 0x00000001U;
enum uint D3D10_1_SO_SINGLE_BUFFER_COMPONENT_LIMIT = 0x00000040U;
enum uint D3D10_1_STANDARD_VERTEX_ELEMENT_COUNT = 0x00000020U;
enum uint D3D10_1_SUBPIXEL_FRACTIONAL_BIT_COUNT = 0x00000008U;
enum uint D3D10_1_VS_INPUT_REGISTER_COUNT = 0x00000020U;
enum uint D3D10_1_VS_OUTPUT_REGISTER_COUNT = 0x00000020U;
enum uint D3D10_SDK_LAYERS_VERSION = 0x0000000bU;

enum : uint
{
    D3D10_DEBUG_FEATURE_FLUSH_PER_RENDER_OP   = 0x00000001U,
    D3D10_DEBUG_FEATURE_FINISH_PER_RENDER_OP  = 0x00000002U,
    D3D10_DEBUG_FEATURE_PRESENT_PER_RENDER_OP = 0x00000004U,
}

enum GUID DXGI_DEBUG_D3D10 = GUID("243b4c52-3606-4d3a-99d7-a7e7b33ed706");
enum const(wchar)* D3D10_REGKEY_PATH = "Software\\Microsoft\\Direct3D";
enum const(wchar)* D3D10_MUTE_DEBUG_OUTPUT = "MuteDebugOutput";
enum const(wchar)* D3D10_ENABLE_BREAK_ON_MESSAGE = "EnableBreakOnMessage";
enum const(wchar)* D3D10_INFOQUEUE_STORAGE_FILTER_OVERRIDE = "InfoQueueStorageFilterOverride";

enum : const(wchar)*
{
    D3D10_MUTE_CATEGORY   = "Mute_CATEGORY_%s",
    D3D10_MUTE_SEVERITY   = "Mute_SEVERITY_%s",
    D3D10_MUTE_ID_STRING  = "Mute_ID_%s",
    D3D10_MUTE_ID_DECIMAL = "Mute_ID_%d",
}

enum const(wchar)* D3D10_UNMUTE_SEVERITY_INFO = "Unmute_SEVERITY_INFO";

enum : const(wchar)*
{
    D3D10_BREAKON_CATEGORY   = "BreakOn_CATEGORY_%s",
    D3D10_BREAKON_SEVERITY   = "BreakOn_SEVERITY_%s",
    D3D10_BREAKON_ID_STRING  = "BreakOn_ID_%s",
    D3D10_BREAKON_ID_DECIMAL = "BreakOn_ID_%d",
}

enum : const(wchar)*
{
    D3D10_APPSIZE_STRING = "Size",
    D3D10_APPNAME_STRING = "Name",
}

enum uint D3D10_INFO_QUEUE_DEFAULT_MESSAGE_COUNT_LIMIT = 0x00000400U;

enum : uint
{
    D3D10_SHADER_DEBUG                    = 0x00000001U,
    D3D10_SHADER_SKIP_VALIDATION          = 0x00000002U,
    D3D10_SHADER_SKIP_OPTIMIZATION        = 0x00000004U,
    D3D10_SHADER_PACK_MATRIX_ROW_MAJOR    = 0x00000008U,
    D3D10_SHADER_PACK_MATRIX_COLUMN_MAJOR = 0x00000010U,
    D3D10_SHADER_PARTIAL_PRECISION        = 0x00000020U,
    D3D10_SHADER_FORCE_VS_SOFTWARE_NO_OPT = 0x00000040U,
    D3D10_SHADER_FORCE_PS_SOFTWARE_NO_OPT = 0x00000080U,
}

enum : uint
{
    D3D10_SHADER_NO_PRESHADER                   = 0x00000100U,
    D3D10_SHADER_AVOID_FLOW_CONTROL             = 0x00000200U,
    D3D10_SHADER_PREFER_FLOW_CONTROL            = 0x00000400U,
    D3D10_SHADER_ENABLE_STRICTNESS              = 0x00000800U,
    D3D10_SHADER_ENABLE_BACKWARDS_COMPATIBILITY = 0x00001000U,
}

enum : uint
{
    D3D10_SHADER_IEEE_STRICTNESS     = 0x00002000U,
    D3D10_SHADER_WARNINGS_ARE_ERRORS = 0x00040000U,
    D3D10_SHADER_RESOURCES_MAY_ALIAS = 0x00080000U,
}

enum uint D3D10_ENABLE_UNBOUNDED_DESCRIPTOR_TABLES = 0x00100000U;
enum uint D3D10_ALL_RESOURCES_BOUND = 0x00200000U;

enum : uint
{
    D3D10_SHADER_DEBUG_NAME_FOR_SOURCE = 0x00400000U,
    D3D10_SHADER_DEBUG_NAME_FOR_BINARY = 0x00800000U,
}

enum : uint
{
    D3D10_SHADER_OPTIMIZATION_LEVEL0                = 0x00004000U,
    D3D10_SHADER_OPTIMIZATION_LEVEL1                = 0x00000000U,
    D3D10_SHADER_OPTIMIZATION_LEVEL3                = 0x00008000U,
    D3D10_SHADER_FLAGS2_FORCE_ROOT_SIGNATURE_LATEST = 0x00000000U,
    D3D10_SHADER_FLAGS2_FORCE_ROOT_SIGNATURE_1_0    = 0x00000010U,
    D3D10_SHADER_FLAGS2_FORCE_ROOT_SIGNATURE_1_1    = 0x00000020U,
}

enum : uint
{
    D3D10_EFFECT_COMPILE_CHILD_EFFECT   = 0x00000001U,
    D3D10_EFFECT_COMPILE_ALLOW_SLOW_OPS = 0x00000002U,
}

enum : uint
{
    D3D10_EFFECT_SINGLE_THREADED              = 0x00000008U,
    D3D10_EFFECT_VARIABLE_POOLED              = 0x00000001U,
    D3D10_EFFECT_VARIABLE_ANNOTATION          = 0x00000002U,
    D3D10_EFFECT_VARIABLE_EXPLICIT_BIND_POINT = 0x00000004U,
}

enum GUID GUID_DeviceType = GUID("d722fb4d-7a68-437a-b20c-5804ee2494a6");

// Callbacks

alias PFN_D3D10_CREATE_DEVICE1 = HRESULT function(IDXGIAdapter param0, D3D10_DRIVER_TYPE param1, HMODULE param2, 
                                                  uint param3, D3D10_FEATURE_LEVEL1 param4, uint param5, 
                                                  ID3D10Device1* param6);
alias PFN_D3D10_CREATE_DEVICE_AND_SWAP_CHAIN1 = HRESULT function(IDXGIAdapter param0, D3D10_DRIVER_TYPE param1, 
                                                                 HMODULE param2, uint param3, 
                                                                 D3D10_FEATURE_LEVEL1 param4, uint param5, 
                                                                 DXGI_SWAP_CHAIN_DESC* param6, 
                                                                 IDXGISwapChain* param7, ID3D10Device1* param8);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_input_element_desc
struct D3D10_INPUT_ELEMENT_DESC
{
    const(PSTR) SemanticName;
    uint        SemanticIndex;
    DXGI_FORMAT Format;
    uint        InputSlot;
    uint        AlignedByteOffset;
    D3D10_INPUT_CLASSIFICATION InputSlotClass;
    uint        InstanceDataStepRate;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_so_declaration_entry
struct D3D10_SO_DECLARATION_ENTRY
{
    const(PSTR) SemanticName;
    uint        SemanticIndex;
    ubyte       StartComponent;
    ubyte       ComponentCount;
    ubyte       OutputSlot;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_viewport
struct D3D10_VIEWPORT
{
    int   TopLeftX;
    int   TopLeftY;
    uint  Width;
    uint  Height;
    float MinDepth;
    float MaxDepth;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_box
struct D3D10_BOX
{
    uint left;
    uint top;
    uint front;
    uint right;
    uint bottom;
    uint back;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_depth_stencilop_desc
struct D3D10_DEPTH_STENCILOP_DESC
{
    D3D10_STENCIL_OP StencilFailOp;
    D3D10_STENCIL_OP StencilDepthFailOp;
    D3D10_STENCIL_OP StencilPassOp;
    D3D10_COMPARISON_FUNC StencilFunc;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_depth_stencil_desc
struct D3D10_DEPTH_STENCIL_DESC
{
    BOOL  DepthEnable;
    D3D10_DEPTH_WRITE_MASK DepthWriteMask;
    D3D10_COMPARISON_FUNC DepthFunc;
    BOOL  StencilEnable;
    ubyte StencilReadMask;
    ubyte StencilWriteMask;
    D3D10_DEPTH_STENCILOP_DESC FrontFace;
    D3D10_DEPTH_STENCILOP_DESC BackFace;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_blend_desc
struct D3D10_BLEND_DESC
{
    BOOL           AlphaToCoverageEnable;
    BOOL[8]        BlendEnable;
    D3D10_BLEND    SrcBlend;
    D3D10_BLEND    DestBlend;
    D3D10_BLEND_OP BlendOp;
    D3D10_BLEND    SrcBlendAlpha;
    D3D10_BLEND    DestBlendAlpha;
    D3D10_BLEND_OP BlendOpAlpha;
    ubyte[8]       RenderTargetWriteMask;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_rasterizer_desc
struct D3D10_RASTERIZER_DESC
{
    D3D10_FILL_MODE FillMode;
    D3D10_CULL_MODE CullMode;
    BOOL            FrontCounterClockwise;
    int             DepthBias;
    float           DepthBiasClamp;
    float           SlopeScaledDepthBias;
    BOOL            DepthClipEnable;
    BOOL            ScissorEnable;
    BOOL            MultisampleEnable;
    BOOL            AntialiasedLineEnable;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_subresource_data
struct D3D10_SUBRESOURCE_DATA
{
    const(void)* pSysMem;
    uint         SysMemPitch;
    uint         SysMemSlicePitch;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_buffer_desc
struct D3D10_BUFFER_DESC
{
    uint        ByteWidth;
    D3D10_USAGE Usage;
    uint        BindFlags;
    uint        CPUAccessFlags;
    uint        MiscFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_texture1d_desc
struct D3D10_TEXTURE1D_DESC
{
    uint        Width;
    uint        MipLevels;
    uint        ArraySize;
    DXGI_FORMAT Format;
    D3D10_USAGE Usage;
    uint        BindFlags;
    uint        CPUAccessFlags;
    uint        MiscFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_texture2d_desc
struct D3D10_TEXTURE2D_DESC
{
    uint             Width;
    uint             Height;
    uint             MipLevels;
    uint             ArraySize;
    DXGI_FORMAT      Format;
    DXGI_SAMPLE_DESC SampleDesc;
    D3D10_USAGE      Usage;
    uint             BindFlags;
    uint             CPUAccessFlags;
    uint             MiscFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_mapped_texture2d
struct D3D10_MAPPED_TEXTURE2D
{
    void* pData;
    uint  RowPitch;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_texture3d_desc
struct D3D10_TEXTURE3D_DESC
{
    uint        Width;
    uint        Height;
    uint        Depth;
    uint        MipLevels;
    DXGI_FORMAT Format;
    D3D10_USAGE Usage;
    uint        BindFlags;
    uint        CPUAccessFlags;
    uint        MiscFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_mapped_texture3d
struct D3D10_MAPPED_TEXTURE3D
{
    void* pData;
    uint  RowPitch;
    uint  DepthPitch;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_buffer_srv
struct D3D10_BUFFER_SRV
{
    union
    {
        uint FirstElement;
        uint ElementOffset;
    }
    union
    {
        uint NumElements;
        uint ElementWidth;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_tex1d_srv
struct D3D10_TEX1D_SRV
{
    uint MostDetailedMip;
    uint MipLevels;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_tex1d_array_srv
struct D3D10_TEX1D_ARRAY_SRV
{
    uint MostDetailedMip;
    uint MipLevels;
    uint FirstArraySlice;
    uint ArraySize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_tex2d_srv
struct D3D10_TEX2D_SRV
{
    uint MostDetailedMip;
    uint MipLevels;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_tex2d_array_srv
struct D3D10_TEX2D_ARRAY_SRV
{
    uint MostDetailedMip;
    uint MipLevels;
    uint FirstArraySlice;
    uint ArraySize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_tex3d_srv
struct D3D10_TEX3D_SRV
{
    uint MostDetailedMip;
    uint MipLevels;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_texcube_srv
struct D3D10_TEXCUBE_SRV
{
    uint MostDetailedMip;
    uint MipLevels;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_tex2dms_srv
struct D3D10_TEX2DMS_SRV
{
    uint UnusedField_NothingToDefine;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_tex2dms_array_srv
struct D3D10_TEX2DMS_ARRAY_SRV
{
    uint FirstArraySlice;
    uint ArraySize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_shader_resource_view_desc
struct D3D10_SHADER_RESOURCE_VIEW_DESC
{
    DXGI_FORMAT       Format;
    D3D_SRV_DIMENSION ViewDimension;
    union
    {
        D3D10_BUFFER_SRV  Buffer;
        D3D10_TEX1D_SRV   Texture1D;
        D3D10_TEX1D_ARRAY_SRV Texture1DArray;
        D3D10_TEX2D_SRV   Texture2D;
        D3D10_TEX2D_ARRAY_SRV Texture2DArray;
        D3D10_TEX2DMS_SRV Texture2DMS;
        D3D10_TEX2DMS_ARRAY_SRV Texture2DMSArray;
        D3D10_TEX3D_SRV   Texture3D;
        D3D10_TEXCUBE_SRV TextureCube;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_buffer_rtv
struct D3D10_BUFFER_RTV
{
    union
    {
        uint FirstElement;
        uint ElementOffset;
    }
    union
    {
        uint NumElements;
        uint ElementWidth;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_tex1d_rtv
struct D3D10_TEX1D_RTV
{
    uint MipSlice;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_tex1d_array_rtv
struct D3D10_TEX1D_ARRAY_RTV
{
    uint MipSlice;
    uint FirstArraySlice;
    uint ArraySize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_tex2d_rtv
struct D3D10_TEX2D_RTV
{
    uint MipSlice;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_tex2dms_rtv
struct D3D10_TEX2DMS_RTV
{
    uint UnusedField_NothingToDefine;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_tex2d_array_rtv
struct D3D10_TEX2D_ARRAY_RTV
{
    uint MipSlice;
    uint FirstArraySlice;
    uint ArraySize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_tex2dms_array_rtv
struct D3D10_TEX2DMS_ARRAY_RTV
{
    uint FirstArraySlice;
    uint ArraySize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_tex3d_rtv
struct D3D10_TEX3D_RTV
{
    uint MipSlice;
    uint FirstWSlice;
    uint WSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_render_target_view_desc
struct D3D10_RENDER_TARGET_VIEW_DESC
{
    DXGI_FORMAT         Format;
    D3D10_RTV_DIMENSION ViewDimension;
    union
    {
        D3D10_BUFFER_RTV  Buffer;
        D3D10_TEX1D_RTV   Texture1D;
        D3D10_TEX1D_ARRAY_RTV Texture1DArray;
        D3D10_TEX2D_RTV   Texture2D;
        D3D10_TEX2D_ARRAY_RTV Texture2DArray;
        D3D10_TEX2DMS_RTV Texture2DMS;
        D3D10_TEX2DMS_ARRAY_RTV Texture2DMSArray;
        D3D10_TEX3D_RTV   Texture3D;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_tex1d_dsv
struct D3D10_TEX1D_DSV
{
    uint MipSlice;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_tex1d_array_dsv
struct D3D10_TEX1D_ARRAY_DSV
{
    uint MipSlice;
    uint FirstArraySlice;
    uint ArraySize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_tex2d_dsv
struct D3D10_TEX2D_DSV
{
    uint MipSlice;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_tex2d_array_dsv
struct D3D10_TEX2D_ARRAY_DSV
{
    uint MipSlice;
    uint FirstArraySlice;
    uint ArraySize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_tex2dms_dsv
struct D3D10_TEX2DMS_DSV
{
    uint UnusedField_NothingToDefine;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_tex2dms_array_dsv
struct D3D10_TEX2DMS_ARRAY_DSV
{
    uint FirstArraySlice;
    uint ArraySize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_depth_stencil_view_desc
struct D3D10_DEPTH_STENCIL_VIEW_DESC
{
    DXGI_FORMAT         Format;
    D3D10_DSV_DIMENSION ViewDimension;
    union
    {
        D3D10_TEX1D_DSV   Texture1D;
        D3D10_TEX1D_ARRAY_DSV Texture1DArray;
        D3D10_TEX2D_DSV   Texture2D;
        D3D10_TEX2D_ARRAY_DSV Texture2DArray;
        D3D10_TEX2DMS_DSV Texture2DMS;
        D3D10_TEX2DMS_ARRAY_DSV Texture2DMSArray;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_sampler_desc
struct D3D10_SAMPLER_DESC
{
    D3D10_FILTER Filter;
    D3D10_TEXTURE_ADDRESS_MODE AddressU;
    D3D10_TEXTURE_ADDRESS_MODE AddressV;
    D3D10_TEXTURE_ADDRESS_MODE AddressW;
    float        MipLODBias;
    uint         MaxAnisotropy;
    D3D10_COMPARISON_FUNC ComparisonFunc;
    float[4]     BorderColor;
    float        MinLOD;
    float        MaxLOD;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_query_desc
struct D3D10_QUERY_DESC
{
    D3D10_QUERY Query;
    uint        MiscFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_query_data_timestamp_disjoint
struct D3D10_QUERY_DATA_TIMESTAMP_DISJOINT
{
    ulong Frequency;
    BOOL  Disjoint;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_query_data_pipeline_statistics
struct D3D10_QUERY_DATA_PIPELINE_STATISTICS
{
    ulong IAVertices;
    ulong IAPrimitives;
    ulong VSInvocations;
    ulong GSInvocations;
    ulong GSPrimitives;
    ulong CInvocations;
    ulong CPrimitives;
    ulong PSInvocations;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_query_data_so_statistics
struct D3D10_QUERY_DATA_SO_STATISTICS
{
    ulong NumPrimitivesWritten;
    ulong PrimitivesStorageNeeded;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_counter_desc
struct D3D10_COUNTER_DESC
{
    D3D10_COUNTER Counter;
    uint          MiscFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/ns-d3d10-d3d10_counter_info
struct D3D10_COUNTER_INFO
{
    D3D10_COUNTER LastDeviceDependentCounter;
    uint          NumSimultaneousCounters;
    ubyte         NumDetectableParallelUnits;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/ns-d3d10sdklayers-d3d10_message
struct D3D10_MESSAGE
{
    D3D10_MESSAGE_CATEGORY Category;
    D3D10_MESSAGE_SEVERITY Severity;
    D3D10_MESSAGE_ID ID;
    const(ubyte)*    pDescription;
    size_t           DescriptionByteLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/ns-d3d10sdklayers-d3d10_info_queue_filter_desc
struct D3D10_INFO_QUEUE_FILTER_DESC
{
    uint              NumCategories;
    D3D10_MESSAGE_CATEGORY* pCategoryList;
    uint              NumSeverities;
    D3D10_MESSAGE_SEVERITY* pSeverityList;
    uint              NumIDs;
    D3D10_MESSAGE_ID* pIDList;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/ns-d3d10sdklayers-d3d10_info_queue_filter
struct D3D10_INFO_QUEUE_FILTER
{
    D3D10_INFO_QUEUE_FILTER_DESC AllowList;
    D3D10_INFO_QUEUE_FILTER_DESC DenyList;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/ns-d3d10shader-d3d10_shader_desc
struct D3D10_SHADER_DESC
{
    uint        Version;
    const(PSTR) Creator;
    uint        Flags;
    uint        ConstantBuffers;
    uint        BoundResources;
    uint        InputParameters;
    uint        OutputParameters;
    uint        InstructionCount;
    uint        TempRegisterCount;
    uint        TempArrayCount;
    uint        DefCount;
    uint        DclCount;
    uint        TextureNormalInstructions;
    uint        TextureLoadInstructions;
    uint        TextureCompInstructions;
    uint        TextureBiasInstructions;
    uint        TextureGradientInstructions;
    uint        FloatInstructionCount;
    uint        IntInstructionCount;
    uint        UintInstructionCount;
    uint        StaticFlowControlCount;
    uint        DynamicFlowControlCount;
    uint        MacroInstructionCount;
    uint        ArrayInstructionCount;
    uint        CutInstructionCount;
    uint        EmitInstructionCount;
    D3D_PRIMITIVE_TOPOLOGY GSOutputTopology;
    uint        GSMaxOutputVertexCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/ns-d3d10shader-d3d10_shader_buffer_desc
struct D3D10_SHADER_BUFFER_DESC
{
    const(PSTR)      Name;
    D3D_CBUFFER_TYPE Type;
    uint             Variables;
    uint             Size;
    uint             uFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/ns-d3d10shader-d3d10_shader_variable_desc
struct D3D10_SHADER_VARIABLE_DESC
{
    const(PSTR) Name;
    uint        StartOffset;
    uint        Size;
    uint        uFlags;
    void*       DefaultValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/ns-d3d10shader-d3d10_shader_type_desc
struct D3D10_SHADER_TYPE_DESC
{
    D3D_SHADER_VARIABLE_CLASS Class;
    D3D_SHADER_VARIABLE_TYPE Type;
    uint Rows;
    uint Columns;
    uint Elements;
    uint Members;
    uint Offset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/ns-d3d10shader-d3d10_shader_input_bind_desc
struct D3D10_SHADER_INPUT_BIND_DESC
{
    const(PSTR)       Name;
    D3D_SHADER_INPUT_TYPE Type;
    uint              BindPoint;
    uint              BindCount;
    uint              uFlags;
    D3D_RESOURCE_RETURN_TYPE ReturnType;
    D3D_SRV_DIMENSION Dimension;
    uint              NumSamples;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/ns-d3d10shader-d3d10_signature_parameter_desc
struct D3D10_SIGNATURE_PARAMETER_DESC
{
    const(PSTR) SemanticName;
    uint        SemanticIndex;
    uint        Register;
    D3D_NAME    SystemValueType;
    D3D_REGISTER_COMPONENT_TYPE ComponentType;
    ubyte       Mask;
    ubyte       ReadWriteMask;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/ns-d3d10effect-d3d10_state_block_mask
struct D3D10_STATE_BLOCK_MASK
{
    ubyte     VS;
    ubyte[2]  VSSamplers;
    ubyte[16] VSShaderResources;
    ubyte[2]  VSConstantBuffers;
    ubyte     GS;
    ubyte[2]  GSSamplers;
    ubyte[16] GSShaderResources;
    ubyte[2]  GSConstantBuffers;
    ubyte     PS;
    ubyte[2]  PSSamplers;
    ubyte[16] PSShaderResources;
    ubyte[2]  PSConstantBuffers;
    ubyte[2]  IAVertexBuffers;
    ubyte     IAIndexBuffer;
    ubyte     IAInputLayout;
    ubyte     IAPrimitiveTopology;
    ubyte     OMRenderTargets;
    ubyte     OMDepthStencilState;
    ubyte     OMBlendState;
    ubyte     RSViewports;
    ubyte     RSScissorRects;
    ubyte     RSRasterizerState;
    ubyte     SOBuffers;
    ubyte     Predication;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/ns-d3d10effect-d3d10_effect_type_desc
struct D3D10_EFFECT_TYPE_DESC
{
    const(PSTR) TypeName;
    D3D_SHADER_VARIABLE_CLASS Class;
    D3D_SHADER_VARIABLE_TYPE Type;
    uint        Elements;
    uint        Members;
    uint        Rows;
    uint        Columns;
    uint        PackedSize;
    uint        UnpackedSize;
    uint        Stride;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/ns-d3d10effect-d3d10_effect_variable_desc
struct D3D10_EFFECT_VARIABLE_DESC
{
    const(PSTR) Name;
    const(PSTR) Semantic;
    uint        Flags;
    uint        Annotations;
    uint        BufferOffset;
    uint        ExplicitBindPoint;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/ns-d3d10effect-d3d10_effect_shader_desc
struct D3D10_EFFECT_SHADER_DESC
{
    const(ubyte)* pInputSignature;
    BOOL          IsInline;
    const(ubyte)* pBytecode;
    uint          BytecodeLength;
    const(PSTR)   SODecl;
    uint          NumInputSignatureEntries;
    uint          NumOutputSignatureEntries;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/ns-d3d10effect-d3d10_pass_desc
struct D3D10_PASS_DESC
{
    const(PSTR) Name;
    uint        Annotations;
    ubyte*      pIAInputSignature;
    size_t      IAInputSignatureSize;
    uint        StencilRef;
    uint        SampleMask;
    float[4]    BlendFactor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/ns-d3d10effect-d3d10_pass_shader_desc
struct D3D10_PASS_SHADER_DESC
{
    ID3D10EffectShaderVariable pShaderVariable;
    uint ShaderIndex;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/ns-d3d10effect-d3d10_technique_desc
struct D3D10_TECHNIQUE_DESC
{
    const(PSTR) Name;
    uint        Passes;
    uint        Annotations;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/ns-d3d10effect-d3d10_effect_desc
struct D3D10_EFFECT_DESC
{
    BOOL IsChildEffect;
    uint ConstantBuffers;
    uint SharedConstantBuffers;
    uint GlobalVariables;
    uint SharedGlobalVariables;
    uint Techniques;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1/ns-d3d10_1-d3d10_render_target_blend_desc1
struct D3D10_RENDER_TARGET_BLEND_DESC1
{
    BOOL           BlendEnable;
    D3D10_BLEND    SrcBlend;
    D3D10_BLEND    DestBlend;
    D3D10_BLEND_OP BlendOp;
    D3D10_BLEND    SrcBlendAlpha;
    D3D10_BLEND    DestBlendAlpha;
    D3D10_BLEND_OP BlendOpAlpha;
    ubyte          RenderTargetWriteMask;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1/ns-d3d10_1-d3d10_blend_desc1
struct D3D10_BLEND_DESC1
{
    BOOL AlphaToCoverageEnable;
    BOOL IndependentBlendEnable;
    D3D10_RENDER_TARGET_BLEND_DESC1[8] RenderTarget;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1/ns-d3d10_1-d3d10_texcube_array_srv1
struct D3D10_TEXCUBE_ARRAY_SRV1
{
    uint MostDetailedMip;
    uint MipLevels;
    uint First2DArrayFace;
    uint NumCubes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1/ns-d3d10_1-d3d10_shader_resource_view_desc1
struct D3D10_SHADER_RESOURCE_VIEW_DESC1
{
    DXGI_FORMAT       Format;
    D3D_SRV_DIMENSION ViewDimension;
    union
    {
        D3D10_BUFFER_SRV  Buffer;
        D3D10_TEX1D_SRV   Texture1D;
        D3D10_TEX1D_ARRAY_SRV Texture1DArray;
        D3D10_TEX2D_SRV   Texture2D;
        D3D10_TEX2D_ARRAY_SRV Texture2DArray;
        D3D10_TEX2DMS_SRV Texture2DMS;
        D3D10_TEX2DMS_ARRAY_SRV Texture2DMSArray;
        D3D10_TEX3D_SRV   Texture3D;
        D3D10_TEXCUBE_SRV TextureCube;
        D3D10_TEXCUBE_ARRAY_SRV1 TextureCubeArray;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1shader/ns-d3d10_1shader-d3d10_shader_debug_token_info
struct D3D10_SHADER_DEBUG_TOKEN_INFO
{
    uint File;
    uint Line;
    uint Column;
    uint TokenLength;
    uint TokenId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1shader/ns-d3d10_1shader-d3d10_shader_debug_var_info
struct D3D10_SHADER_DEBUG_VAR_INFO
{
    uint TokenId;
    D3D_SHADER_VARIABLE_TYPE Type;
    uint Register;
    uint Component;
    uint ScopeVar;
    uint ScopeVarOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1shader/ns-d3d10_1shader-d3d10_shader_debug_input_info
struct D3D10_SHADER_DEBUG_INPUT_INFO
{
    uint Var;
    D3D10_SHADER_DEBUG_REGTYPE InitialRegisterSet;
    uint InitialBank;
    uint InitialRegister;
    uint InitialComponent;
    uint InitialValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1shader/ns-d3d10_1shader-d3d10_shader_debug_scopevar_info
struct D3D10_SHADER_DEBUG_SCOPEVAR_INFO
{
    uint TokenId;
    D3D10_SHADER_DEBUG_VARTYPE VarType;
    D3D_SHADER_VARIABLE_CLASS Class;
    uint Rows;
    uint Columns;
    uint StructMemberScope;
    uint uArrayIndices;
    uint ArrayElements;
    uint ArrayStrides;
    uint uVariables;
    uint uFirstVariable;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1shader/ns-d3d10_1shader-d3d10_shader_debug_scope_info
struct D3D10_SHADER_DEBUG_SCOPE_INFO
{
    D3D10_SHADER_DEBUG_SCOPETYPE ScopeType;
    uint Name;
    uint uNameLen;
    uint uVariables;
    uint VariableData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1shader/ns-d3d10_1shader-d3d10_shader_debug_outputvar
struct D3D10_SHADER_DEBUG_OUTPUTVAR
{
    uint  Var;
    uint  uValueMin;
    uint  uValueMax;
    int   iValueMin;
    int   iValueMax;
    float fValueMin;
    float fValueMax;
    BOOL  bNaNPossible;
    BOOL  bInfPossible;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1shader/ns-d3d10_1shader-d3d10_shader_debug_outputreg_info
struct D3D10_SHADER_DEBUG_OUTPUTREG_INFO
{
    D3D10_SHADER_DEBUG_REGTYPE OutputRegisterSet;
    uint    OutputReg;
    uint    TempArrayReg;
    uint[4] OutputComponents;
    D3D10_SHADER_DEBUG_OUTPUTVAR[4] OutputVars;
    uint    IndexReg;
    uint    IndexComp;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1shader/ns-d3d10_1shader-d3d10_shader_debug_inst_info
struct D3D10_SHADER_DEBUG_INST_INFO
{
    uint Id;
    uint Opcode;
    uint uOutputs;
    D3D10_SHADER_DEBUG_OUTPUTREG_INFO[2] pOutputs;
    uint TokenId;
    uint NestingLevel;
    uint Scopes;
    uint ScopeInfo;
    uint AccessedVars;
    uint AccessedVarsInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1shader/ns-d3d10_1shader-d3d10_shader_debug_file_info
struct D3D10_SHADER_DEBUG_FILE_INFO
{
    uint FileName;
    uint FileNameLen;
    uint FileData;
    uint FileLen;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1shader/ns-d3d10_1shader-d3d10_shader_debug_info
struct D3D10_SHADER_DEBUG_INFO
{
    uint Size;
    uint Creator;
    uint EntrypointName;
    uint ShaderTarget;
    uint CompileFlags;
    uint Files;
    uint FileInfo;
    uint Instructions;
    uint InstructionInfo;
    uint Variables;
    uint VariableInfo;
    uint InputVariables;
    uint InputVariableInfo;
    uint Tokens;
    uint TokenInfo;
    uint Scopes;
    uint ScopeInfo;
    uint ScopeVariables;
    uint ScopeVariableInfo;
    uint UintOffset;
    uint StringOffset;
}

// Functions

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10misc/nf-d3d10misc-d3d10createdevice
@DllImport("d3d10.dll")
HRESULT D3D10CreateDevice(IDXGIAdapter pAdapter, D3D10_DRIVER_TYPE DriverType, HMODULE Software, uint Flags, 
                          uint SDKVersion, ID3D10Device* ppDevice);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10misc/nf-d3d10misc-d3d10createdeviceandswapchain
@DllImport("d3d10.dll")
HRESULT D3D10CreateDeviceAndSwapChain(IDXGIAdapter pAdapter, D3D10_DRIVER_TYPE DriverType, HMODULE Software, 
                                      uint Flags, uint SDKVersion, DXGI_SWAP_CHAIN_DESC* pSwapChainDesc, 
                                      IDXGISwapChain* ppSwapChain, ID3D10Device* ppDevice);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10misc/nf-d3d10misc-d3d10createblob
@DllImport("d3d10.dll")
HRESULT D3D10CreateBlob(size_t NumBytes, ID3DBlob* ppBuffer);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nf-d3d10shader-d3d10compileshader
@DllImport("d3d10.dll")
HRESULT D3D10CompileShader(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(PSTR) pSrcData, 
                           size_t SrcDataSize, const(PSTR) pFileName, const(D3D_SHADER_MACRO)* pDefines, 
                           ID3DInclude pInclude, const(PSTR) pFunctionName, const(PSTR) pProfile, uint Flags, 
                           ID3DBlob* ppShader, ID3DBlob* ppErrorMsgs);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nf-d3d10shader-d3d10disassembleshader
@DllImport("d3d10.dll")
HRESULT D3D10DisassembleShader(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pShader, 
                               size_t BytecodeLength, BOOL EnableColorCode, const(PSTR) pComments, 
                               ID3DBlob* ppDisassembly);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nf-d3d10shader-d3d10getpixelshaderprofile
@DllImport("d3d10.dll")
PSTR D3D10GetPixelShaderProfile(ID3D10Device pDevice);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nf-d3d10shader-d3d10getvertexshaderprofile
@DllImport("d3d10.dll")
PSTR D3D10GetVertexShaderProfile(ID3D10Device pDevice);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nf-d3d10shader-d3d10getgeometryshaderprofile
@DllImport("d3d10.dll")
PSTR D3D10GetGeometryShaderProfile(ID3D10Device pDevice);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nf-d3d10shader-d3d10reflectshader
@DllImport("d3d10.dll")
HRESULT D3D10ReflectShader(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pShaderBytecode, 
                           size_t BytecodeLength, ID3D10ShaderReflection* ppReflector);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nf-d3d10shader-d3d10preprocessshader
@DllImport("d3d10.dll")
HRESULT D3D10PreprocessShader(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(PSTR) pSrcData, 
                              size_t SrcDataSize, const(PSTR) pFileName, const(D3D_SHADER_MACRO)* pDefines, 
                              ID3DInclude pInclude, ID3DBlob* ppShaderText, ID3DBlob* ppErrorMsgs);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nf-d3d10shader-d3d10getinputsignatureblob
@DllImport("d3d10.dll")
HRESULT D3D10GetInputSignatureBlob(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pShaderBytecode, 
                                   size_t BytecodeLength, ID3DBlob* ppSignatureBlob);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nf-d3d10shader-d3d10getoutputsignatureblob
@DllImport("d3d10.dll")
HRESULT D3D10GetOutputSignatureBlob(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pShaderBytecode, 
                                    size_t BytecodeLength, ID3DBlob* ppSignatureBlob);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nf-d3d10shader-d3d10getinputandoutputsignatureblob
@DllImport("d3d10.dll")
HRESULT D3D10GetInputAndOutputSignatureBlob(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pShaderBytecode, 
                                            size_t BytecodeLength, ID3DBlob* ppSignatureBlob);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nf-d3d10shader-d3d10getshaderdebuginfo
@DllImport("d3d10.dll")
HRESULT D3D10GetShaderDebugInfo(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pShaderBytecode, 
                                size_t BytecodeLength, ID3DBlob* ppDebugInfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-d3d10stateblockmaskunion
@DllImport("d3d10.dll")
HRESULT D3D10StateBlockMaskUnion(D3D10_STATE_BLOCK_MASK* pA, D3D10_STATE_BLOCK_MASK* pB, 
                                 D3D10_STATE_BLOCK_MASK* pResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-d3d10stateblockmaskintersect
@DllImport("d3d10.dll")
HRESULT D3D10StateBlockMaskIntersect(D3D10_STATE_BLOCK_MASK* pA, D3D10_STATE_BLOCK_MASK* pB, 
                                     D3D10_STATE_BLOCK_MASK* pResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-d3d10stateblockmaskdifference
@DllImport("d3d10.dll")
HRESULT D3D10StateBlockMaskDifference(D3D10_STATE_BLOCK_MASK* pA, D3D10_STATE_BLOCK_MASK* pB, 
                                      D3D10_STATE_BLOCK_MASK* pResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-d3d10stateblockmaskenablecapture
@DllImport("d3d10.dll")
HRESULT D3D10StateBlockMaskEnableCapture(D3D10_STATE_BLOCK_MASK* pMask, D3D10_DEVICE_STATE_TYPES StateType, 
                                         uint RangeStart, uint RangeLength);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-d3d10stateblockmaskdisablecapture
@DllImport("d3d10.dll")
HRESULT D3D10StateBlockMaskDisableCapture(D3D10_STATE_BLOCK_MASK* pMask, D3D10_DEVICE_STATE_TYPES StateType, 
                                          uint RangeStart, uint RangeLength);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-d3d10stateblockmaskenableall
@DllImport("d3d10.dll")
HRESULT D3D10StateBlockMaskEnableAll(D3D10_STATE_BLOCK_MASK* pMask);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-d3d10stateblockmaskdisableall
@DllImport("d3d10.dll")
HRESULT D3D10StateBlockMaskDisableAll(D3D10_STATE_BLOCK_MASK* pMask);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-d3d10stateblockmaskgetsetting
@DllImport("d3d10.dll")
BOOL D3D10StateBlockMaskGetSetting(D3D10_STATE_BLOCK_MASK* pMask, D3D10_DEVICE_STATE_TYPES StateType, uint Entry);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-d3d10createstateblock
@DllImport("d3d10.dll")
HRESULT D3D10CreateStateBlock(ID3D10Device pDevice, D3D10_STATE_BLOCK_MASK* pStateBlockMask, 
                              ID3D10StateBlock* ppStateBlock);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-d3d10compileeffectfrommemory
@DllImport("d3d10.dll")
HRESULT D3D10CompileEffectFromMemory(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pData, 
                                     size_t DataLength, const(PSTR) pSrcFileName, const(D3D_SHADER_MACRO)* pDefines, 
                                     ID3DInclude pInclude, uint HLSLFlags, uint FXFlags, ID3DBlob* ppCompiledEffect, 
                                     ID3DBlob* ppErrors);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-d3d10createeffectfrommemory
@DllImport("d3d10.dll")
HRESULT D3D10CreateEffectFromMemory(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pData, 
                                    size_t DataLength, uint FXFlags, ID3D10Device pDevice, 
                                    ID3D10EffectPool pEffectPool, ID3D10Effect* ppEffect);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-d3d10createeffectpoolfrommemory
@DllImport("d3d10.dll")
HRESULT D3D10CreateEffectPoolFromMemory(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pData, 
                                        size_t DataLength, uint FXFlags, ID3D10Device pDevice, 
                                        ID3D10EffectPool* ppEffectPool);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-d3d10disassembleeffect
@DllImport("d3d10.dll")
HRESULT D3D10DisassembleEffect(ID3D10Effect pEffect, BOOL EnableColorCode, ID3DBlob* ppDisassembly);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1/nf-d3d10_1-d3d10createdevice1
@DllImport("d3d10_1.dll")
HRESULT D3D10CreateDevice1(IDXGIAdapter pAdapter, D3D10_DRIVER_TYPE DriverType, HMODULE Software, uint Flags, 
                           D3D10_FEATURE_LEVEL1 HardwareLevel, uint SDKVersion, ID3D10Device1* ppDevice);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1/nf-d3d10_1-d3d10createdeviceandswapchain1
@DllImport("d3d10_1.dll")
HRESULT D3D10CreateDeviceAndSwapChain1(IDXGIAdapter pAdapter, D3D10_DRIVER_TYPE DriverType, HMODULE Software, 
                                       uint Flags, D3D10_FEATURE_LEVEL1 HardwareLevel, uint SDKVersion, 
                                       DXGI_SWAP_CHAIN_DESC* pSwapChainDesc, IDXGISwapChain* ppSwapChain, 
                                       ID3D10Device1* ppDevice);


// Interfaces

@GUID("9b7e4c00-342c-4106-a19f-4f2704f689f0")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nn-d3d10-id3d10devicechild
interface ID3D10DeviceChild : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10devicechild-getdevice
    void    GetDevice(ID3D10Device* ppDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10devicechild-getprivatedata
    HRESULT GetPrivateData(const(GUID)* guid, uint* pDataSize, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10devicechild-setprivatedata
    HRESULT SetPrivateData(const(GUID)* guid, uint DataSize, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10devicechild-setprivatedatainterface
    HRESULT SetPrivateDataInterface(const(GUID)* guid, const(IUnknown) pData);
}

@GUID("2b4b1cc8-a4ad-41f8-8322-ca86fc3ec675")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nn-d3d10-id3d10depthstencilstate
interface ID3D10DepthStencilState : ID3D10DeviceChild
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10depthstencilstate-getdesc
    void GetDesc(D3D10_DEPTH_STENCIL_DESC* pDesc);
}

@GUID("edad8d19-8a35-4d6d-8566-2ea276cde161")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nn-d3d10-id3d10blendstate
interface ID3D10BlendState : ID3D10DeviceChild
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10blendstate-getdesc
    void GetDesc(D3D10_BLEND_DESC* pDesc);
}

@GUID("a2a07292-89af-4345-be2e-c53d9fbb6e9f")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nn-d3d10-id3d10rasterizerstate
interface ID3D10RasterizerState : ID3D10DeviceChild
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10rasterizerstate-getdesc
    void GetDesc(D3D10_RASTERIZER_DESC* pDesc);
}

@GUID("9b7e4c01-342c-4106-a19f-4f2704f689f0")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nn-d3d10-id3d10resource
interface ID3D10Resource : ID3D10DeviceChild
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10resource-gettype
    void GetType(D3D10_RESOURCE_DIMENSION* rType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10resource-setevictionpriority
    void SetEvictionPriority(uint EvictionPriority);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10resource-getevictionpriority
    uint GetEvictionPriority();
}

@GUID("9b7e4c02-342c-4106-a19f-4f2704f689f0")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nn-d3d10-id3d10buffer
interface ID3D10Buffer : ID3D10Resource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10buffer-map
    HRESULT Map(D3D10_MAP MapType, uint MapFlags, void** ppData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10buffer-unmap
    void    Unmap();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10buffer-getdesc
    void    GetDesc(D3D10_BUFFER_DESC* pDesc);
}

@GUID("9b7e4c03-342c-4106-a19f-4f2704f689f0")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nn-d3d10-id3d10texture1d
interface ID3D10Texture1D : ID3D10Resource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10texture1d-map
    HRESULT Map(uint Subresource, D3D10_MAP MapType, uint MapFlags, void** ppData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10texture1d-unmap
    void    Unmap(uint Subresource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10texture1d-getdesc
    void    GetDesc(D3D10_TEXTURE1D_DESC* pDesc);
}

@GUID("9b7e4c04-342c-4106-a19f-4f2704f689f0")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nn-d3d10-id3d10texture2d
interface ID3D10Texture2D : ID3D10Resource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10texture2d-map
    HRESULT Map(uint Subresource, D3D10_MAP MapType, uint MapFlags, D3D10_MAPPED_TEXTURE2D* pMappedTex2D);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10texture2d-unmap
    void    Unmap(uint Subresource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10texture2d-getdesc
    void    GetDesc(D3D10_TEXTURE2D_DESC* pDesc);
}

@GUID("9b7e4c05-342c-4106-a19f-4f2704f689f0")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nn-d3d10-id3d10texture3d
interface ID3D10Texture3D : ID3D10Resource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10texture3d-map
    HRESULT Map(uint Subresource, D3D10_MAP MapType, uint MapFlags, D3D10_MAPPED_TEXTURE3D* pMappedTex3D);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10texture3d-unmap
    void    Unmap(uint Subresource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10texture3d-getdesc
    void    GetDesc(D3D10_TEXTURE3D_DESC* pDesc);
}

@GUID("c902b03f-60a7-49ba-9936-2a3ab37a7e33")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nn-d3d10-id3d10view
interface ID3D10View : ID3D10DeviceChild
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10view-getresource
    void GetResource(ID3D10Resource* ppResource);
}

@GUID("9b7e4c07-342c-4106-a19f-4f2704f689f0")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nn-d3d10-id3d10shaderresourceview
interface ID3D10ShaderResourceView : ID3D10View
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10shaderresourceview-getdesc
    void GetDesc(D3D10_SHADER_RESOURCE_VIEW_DESC* pDesc);
}

@GUID("9b7e4c08-342c-4106-a19f-4f2704f689f0")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nn-d3d10-id3d10rendertargetview
interface ID3D10RenderTargetView : ID3D10View
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10rendertargetview-getdesc
    void GetDesc(D3D10_RENDER_TARGET_VIEW_DESC* pDesc);
}

@GUID("9b7e4c09-342c-4106-a19f-4f2704f689f0")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nn-d3d10-id3d10depthstencilview
interface ID3D10DepthStencilView : ID3D10View
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10depthstencilview-getdesc
    void GetDesc(D3D10_DEPTH_STENCIL_VIEW_DESC* pDesc);
}

@GUID("9b7e4c0a-342c-4106-a19f-4f2704f689f0")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nn-d3d10-id3d10vertexshader
interface ID3D10VertexShader : ID3D10DeviceChild
{
}

@GUID("6316be88-54cd-4040-ab44-20461bc81f68")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nn-d3d10-id3d10geometryshader
interface ID3D10GeometryShader : ID3D10DeviceChild
{
}

@GUID("4968b601-9d00-4cde-8346-8e7f675819b6")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nn-d3d10-id3d10pixelshader
interface ID3D10PixelShader : ID3D10DeviceChild
{
}

@GUID("9b7e4c0b-342c-4106-a19f-4f2704f689f0")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nn-d3d10-id3d10inputlayout
interface ID3D10InputLayout : ID3D10DeviceChild
{
}

@GUID("9b7e4c0c-342c-4106-a19f-4f2704f689f0")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nn-d3d10-id3d10samplerstate
interface ID3D10SamplerState : ID3D10DeviceChild
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10samplerstate-getdesc
    void GetDesc(D3D10_SAMPLER_DESC* pDesc);
}

@GUID("9b7e4c0d-342c-4106-a19f-4f2704f689f0")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nn-d3d10-id3d10asynchronous
interface ID3D10Asynchronous : ID3D10DeviceChild
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10asynchronous-begin
    void    Begin();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10asynchronous-end
    void    End();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10asynchronous-getdata
    HRESULT GetData(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pData, 
                    uint DataSize, uint GetDataFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10asynchronous-getdatasize
    uint    GetDataSize();
}

@GUID("9b7e4c0e-342c-4106-a19f-4f2704f689f0")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nn-d3d10-id3d10query
interface ID3D10Query : ID3D10Asynchronous
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10query-getdesc
    void GetDesc(D3D10_QUERY_DESC* pDesc);
}

@GUID("9b7e4c10-342c-4106-a19f-4f2704f689f0")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nn-d3d10-id3d10predicate
interface ID3D10Predicate : ID3D10Query
{
}

@GUID("9b7e4c11-342c-4106-a19f-4f2704f689f0")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nn-d3d10-id3d10counter
interface ID3D10Counter : ID3D10Asynchronous
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10counter-getdesc
    void GetDesc(D3D10_COUNTER_DESC* pDesc);
}

@GUID("9b7e4c0f-342c-4106-a19f-4f2704f689f0")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nn-d3d10-id3d10device
interface ID3D10Device : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-vssetconstantbuffers
    void    VSSetConstantBuffers(uint StartSlot, uint NumBuffers, ID3D10Buffer* ppConstantBuffers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-pssetshaderresources
    void    PSSetShaderResources(uint StartSlot, uint NumViews, ID3D10ShaderResourceView* ppShaderResourceViews);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-pssetshader
    void    PSSetShader(ID3D10PixelShader pPixelShader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-pssetsamplers
    void    PSSetSamplers(uint StartSlot, uint NumSamplers, ID3D10SamplerState* ppSamplers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-vssetshader
    void    VSSetShader(ID3D10VertexShader pVertexShader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-drawindexed
    void    DrawIndexed(uint IndexCount, uint StartIndexLocation, int BaseVertexLocation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-draw
    void    Draw(uint VertexCount, uint StartVertexLocation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-pssetconstantbuffers
    void    PSSetConstantBuffers(uint StartSlot, uint NumBuffers, ID3D10Buffer* ppConstantBuffers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-iasetinputlayout
    void    IASetInputLayout(ID3D10InputLayout pInputLayout);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-iasetvertexbuffers
    void    IASetVertexBuffers(uint StartSlot, uint NumBuffers, ID3D10Buffer* ppVertexBuffers, 
                               const(uint)* pStrides, const(uint)* pOffsets);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-iasetindexbuffer
    void    IASetIndexBuffer(ID3D10Buffer pIndexBuffer, DXGI_FORMAT Format, uint Offset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-drawindexedinstanced
    void    DrawIndexedInstanced(uint IndexCountPerInstance, uint InstanceCount, uint StartIndexLocation, 
                                 int BaseVertexLocation, uint StartInstanceLocation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-drawinstanced
    void    DrawInstanced(uint VertexCountPerInstance, uint InstanceCount, uint StartVertexLocation, 
                          uint StartInstanceLocation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-gssetconstantbuffers
    void    GSSetConstantBuffers(uint StartSlot, uint NumBuffers, ID3D10Buffer* ppConstantBuffers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-gssetshader
    void    GSSetShader(ID3D10GeometryShader pShader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-iasetprimitivetopology
    void    IASetPrimitiveTopology(D3D_PRIMITIVE_TOPOLOGY Topology);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-vssetshaderresources
    void    VSSetShaderResources(uint StartSlot, uint NumViews, ID3D10ShaderResourceView* ppShaderResourceViews);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-vssetsamplers
    void    VSSetSamplers(uint StartSlot, uint NumSamplers, ID3D10SamplerState* ppSamplers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-setpredication
    void    SetPredication(ID3D10Predicate pPredicate, BOOL PredicateValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-gssetshaderresources
    void    GSSetShaderResources(uint StartSlot, uint NumViews, ID3D10ShaderResourceView* ppShaderResourceViews);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-gssetsamplers
    void    GSSetSamplers(uint StartSlot, uint NumSamplers, ID3D10SamplerState* ppSamplers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-omsetrendertargets
    void    OMSetRenderTargets(uint NumViews, ID3D10RenderTargetView* ppRenderTargetViews, 
                               ID3D10DepthStencilView pDepthStencilView);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-omsetblendstate
    void    OMSetBlendState(ID3D10BlendState pBlendState, const(float)* BlendFactor, uint SampleMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-omsetdepthstencilstate
    void    OMSetDepthStencilState(ID3D10DepthStencilState pDepthStencilState, uint StencilRef);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-sosettargets
    void    SOSetTargets(uint NumBuffers, ID3D10Buffer* ppSOTargets, const(uint)* pOffsets);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-drawauto
    void    DrawAuto();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-rssetstate
    void    RSSetState(ID3D10RasterizerState pRasterizerState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-rssetviewports
    void    RSSetViewports(uint NumViewports, const(D3D10_VIEWPORT)* pViewports);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-rssetscissorrects
    void    RSSetScissorRects(uint NumRects, const(RECT)* pRects);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-copysubresourceregion
    void    CopySubresourceRegion(ID3D10Resource pDstResource, uint DstSubresource, uint DstX, uint DstY, 
                                  uint DstZ, ID3D10Resource pSrcResource, uint SrcSubresource, 
                                  const(D3D10_BOX)* pSrcBox);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-copyresource
    void    CopyResource(ID3D10Resource pDstResource, ID3D10Resource pSrcResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-updatesubresource
    void    UpdateSubresource(ID3D10Resource pDstResource, uint DstSubresource, const(D3D10_BOX)* pDstBox, 
                              const(void)* pSrcData, uint SrcRowPitch, uint SrcDepthPitch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-clearrendertargetview
    void    ClearRenderTargetView(ID3D10RenderTargetView pRenderTargetView, const(float)* ColorRGBA);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-cleardepthstencilview
    void    ClearDepthStencilView(ID3D10DepthStencilView pDepthStencilView, uint ClearFlags, float Depth, 
                                  ubyte Stencil);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-generatemips
    void    GenerateMips(ID3D10ShaderResourceView pShaderResourceView);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-resolvesubresource
    void    ResolveSubresource(ID3D10Resource pDstResource, uint DstSubresource, ID3D10Resource pSrcResource, 
                               uint SrcSubresource, DXGI_FORMAT Format);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-vsgetconstantbuffers
    void    VSGetConstantBuffers(uint StartSlot, uint NumBuffers, ID3D10Buffer* ppConstantBuffers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-psgetshaderresources
    void    PSGetShaderResources(uint StartSlot, uint NumViews, ID3D10ShaderResourceView* ppShaderResourceViews);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-psgetshader
    void    PSGetShader(ID3D10PixelShader* ppPixelShader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-psgetsamplers
    void    PSGetSamplers(uint StartSlot, uint NumSamplers, ID3D10SamplerState* ppSamplers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-vsgetshader
    void    VSGetShader(ID3D10VertexShader* ppVertexShader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-psgetconstantbuffers
    void    PSGetConstantBuffers(uint StartSlot, uint NumBuffers, ID3D10Buffer* ppConstantBuffers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-iagetinputlayout
    void    IAGetInputLayout(ID3D10InputLayout* ppInputLayout);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-iagetvertexbuffers
    void    IAGetVertexBuffers(uint StartSlot, uint NumBuffers, ID3D10Buffer* ppVertexBuffers, uint* pStrides, 
                               uint* pOffsets);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-iagetindexbuffer
    void    IAGetIndexBuffer(ID3D10Buffer* pIndexBuffer, DXGI_FORMAT* Format, uint* Offset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-gsgetconstantbuffers
    void    GSGetConstantBuffers(uint StartSlot, uint NumBuffers, ID3D10Buffer* ppConstantBuffers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-gsgetshader
    void    GSGetShader(ID3D10GeometryShader* ppGeometryShader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-iagetprimitivetopology
    void    IAGetPrimitiveTopology(D3D_PRIMITIVE_TOPOLOGY* pTopology);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-vsgetshaderresources
    void    VSGetShaderResources(uint StartSlot, uint NumViews, ID3D10ShaderResourceView* ppShaderResourceViews);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-vsgetsamplers
    void    VSGetSamplers(uint StartSlot, uint NumSamplers, ID3D10SamplerState* ppSamplers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-getpredication
    void    GetPredication(ID3D10Predicate* ppPredicate, BOOL* pPredicateValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-gsgetshaderresources
    void    GSGetShaderResources(uint StartSlot, uint NumViews, ID3D10ShaderResourceView* ppShaderResourceViews);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-gsgetsamplers
    void    GSGetSamplers(uint StartSlot, uint NumSamplers, ID3D10SamplerState* ppSamplers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-omgetrendertargets
    void    OMGetRenderTargets(uint NumViews, ID3D10RenderTargetView* ppRenderTargetViews, 
                               ID3D10DepthStencilView* ppDepthStencilView);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-omgetblendstate
    void    OMGetBlendState(ID3D10BlendState* ppBlendState, float* BlendFactor, uint* pSampleMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-omgetdepthstencilstate
    void    OMGetDepthStencilState(ID3D10DepthStencilState* ppDepthStencilState, uint* pStencilRef);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-sogettargets
    void    SOGetTargets(uint NumBuffers, ID3D10Buffer* ppSOTargets, uint* pOffsets);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-rsgetstate
    void    RSGetState(ID3D10RasterizerState* ppRasterizerState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-rsgetviewports
    void    RSGetViewports(uint* NumViewports, D3D10_VIEWPORT* pViewports);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-rsgetscissorrects
    void    RSGetScissorRects(uint* NumRects, RECT* pRects);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-getdeviceremovedreason
    HRESULT GetDeviceRemovedReason();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-setexceptionmode
    HRESULT SetExceptionMode(uint RaiseFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-getexceptionmode
    uint    GetExceptionMode();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-getprivatedata
    HRESULT GetPrivateData(const(GUID)* guid, uint* pDataSize, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-setprivatedata
    HRESULT SetPrivateData(const(GUID)* guid, uint DataSize, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-setprivatedatainterface
    HRESULT SetPrivateDataInterface(const(GUID)* guid, const(IUnknown) pData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-clearstate
    void    ClearState();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-flush
    void    Flush();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-createbuffer
    HRESULT CreateBuffer(const(D3D10_BUFFER_DESC)* pDesc, const(D3D10_SUBRESOURCE_DATA)* pInitialData, 
                         ID3D10Buffer* ppBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-createtexture1d
    HRESULT CreateTexture1D(const(D3D10_TEXTURE1D_DESC)* pDesc, const(D3D10_SUBRESOURCE_DATA)* pInitialData, 
                            ID3D10Texture1D* ppTexture1D);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-createtexture2d
    HRESULT CreateTexture2D(const(D3D10_TEXTURE2D_DESC)* pDesc, const(D3D10_SUBRESOURCE_DATA)* pInitialData, 
                            ID3D10Texture2D* ppTexture2D);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-createtexture3d
    HRESULT CreateTexture3D(const(D3D10_TEXTURE3D_DESC)* pDesc, const(D3D10_SUBRESOURCE_DATA)* pInitialData, 
                            ID3D10Texture3D* ppTexture3D);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-createshaderresourceview
    HRESULT CreateShaderResourceView(ID3D10Resource pResource, const(D3D10_SHADER_RESOURCE_VIEW_DESC)* pDesc, 
                                     ID3D10ShaderResourceView* ppSRView);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-createrendertargetview
    HRESULT CreateRenderTargetView(ID3D10Resource pResource, const(D3D10_RENDER_TARGET_VIEW_DESC)* pDesc, 
                                   ID3D10RenderTargetView* ppRTView);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-createdepthstencilview
    HRESULT CreateDepthStencilView(ID3D10Resource pResource, const(D3D10_DEPTH_STENCIL_VIEW_DESC)* pDesc, 
                                   ID3D10DepthStencilView* ppDepthStencilView);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-createinputlayout
    HRESULT CreateInputLayout(const(D3D10_INPUT_ELEMENT_DESC)* pInputElementDescs, uint NumElements, 
                              const(void)* pShaderBytecodeWithInputSignature, size_t BytecodeLength, 
                              ID3D10InputLayout* ppInputLayout);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-createvertexshader
    HRESULT CreateVertexShader(const(void)* pShaderBytecode, size_t BytecodeLength, 
                               ID3D10VertexShader* ppVertexShader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-creategeometryshader
    HRESULT CreateGeometryShader(const(void)* pShaderBytecode, size_t BytecodeLength, 
                                 ID3D10GeometryShader* ppGeometryShader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-creategeometryshaderwithstreamoutput
    HRESULT CreateGeometryShaderWithStreamOutput(const(void)* pShaderBytecode, size_t BytecodeLength, 
                                                 const(D3D10_SO_DECLARATION_ENTRY)* pSODeclaration, uint NumEntries, 
                                                 uint OutputStreamStride, ID3D10GeometryShader* ppGeometryShader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-createpixelshader
    HRESULT CreatePixelShader(const(void)* pShaderBytecode, size_t BytecodeLength, 
                              ID3D10PixelShader* ppPixelShader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-createblendstate
    HRESULT CreateBlendState(const(D3D10_BLEND_DESC)* pBlendStateDesc, ID3D10BlendState* ppBlendState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-createdepthstencilstate
    HRESULT CreateDepthStencilState(const(D3D10_DEPTH_STENCIL_DESC)* pDepthStencilDesc, 
                                    ID3D10DepthStencilState* ppDepthStencilState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-createrasterizerstate
    HRESULT CreateRasterizerState(const(D3D10_RASTERIZER_DESC)* pRasterizerDesc, 
                                  ID3D10RasterizerState* ppRasterizerState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-createsamplerstate
    HRESULT CreateSamplerState(const(D3D10_SAMPLER_DESC)* pSamplerDesc, ID3D10SamplerState* ppSamplerState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-createquery
    HRESULT CreateQuery(const(D3D10_QUERY_DESC)* pQueryDesc, ID3D10Query* ppQuery);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-createpredicate
    HRESULT CreatePredicate(const(D3D10_QUERY_DESC)* pPredicateDesc, ID3D10Predicate* ppPredicate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-createcounter
    HRESULT CreateCounter(const(D3D10_COUNTER_DESC)* pCounterDesc, ID3D10Counter* ppCounter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-checkformatsupport
    HRESULT CheckFormatSupport(DXGI_FORMAT Format, uint* pFormatSupport);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-checkmultisamplequalitylevels
    HRESULT CheckMultisampleQualityLevels(DXGI_FORMAT Format, uint SampleCount, uint* pNumQualityLevels);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-checkcounterinfo
    void    CheckCounterInfo(D3D10_COUNTER_INFO* pCounterInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-checkcounter
    HRESULT CheckCounter(const(D3D10_COUNTER_DESC)* pDesc, D3D10_COUNTER_TYPE* pType, uint* pActiveCounters, 
                         PSTR szName, uint* pNameLength, PSTR szUnits, uint* pUnitsLength, PSTR szDescription, 
                         uint* pDescriptionLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-getcreationflags
    uint    GetCreationFlags();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-opensharedresource
    HRESULT OpenSharedResource(HANDLE hResource, const(GUID)* ReturnedInterface, void** ppResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-settextfiltersize
    void    SetTextFilterSize(uint Width, uint Height);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10device-gettextfiltersize
    void    GetTextFilterSize(uint* pWidth, uint* pHeight);
}

@GUID("9b7e4e00-342c-4106-a19f-4f2704f689f0")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nn-d3d10-id3d10multithread
interface ID3D10Multithread : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10multithread-enter
    void Enter();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10multithread-leave
    void Leave();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10multithread-setmultithreadprotected
    BOOL SetMultithreadProtected(BOOL bMTProtect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10/nf-d3d10-id3d10multithread-getmultithreadprotected
    BOOL GetMultithreadProtected();
}

@GUID("9b7e4e01-342c-4106-a19f-4f2704f689f0")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nn-d3d10sdklayers-id3d10debug
interface ID3D10Debug : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10debug-setfeaturemask
    HRESULT SetFeatureMask(uint Mask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10debug-getfeaturemask
    uint    GetFeatureMask();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10debug-setpresentperrenderopdelay
    HRESULT SetPresentPerRenderOpDelay(uint Milliseconds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10debug-getpresentperrenderopdelay
    uint    GetPresentPerRenderOpDelay();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10debug-setswapchain
    HRESULT SetSwapChain(IDXGISwapChain pSwapChain);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10debug-getswapchain
    HRESULT GetSwapChain(IDXGISwapChain* ppSwapChain);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10debug-validate
    HRESULT Validate();
}

@GUID("9b7e4e02-342c-4106-a19f-4f2704f689f0")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nn-d3d10sdklayers-id3d10switchtoref
interface ID3D10SwitchToRef : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10switchtoref-setuseref
    BOOL SetUseRef(BOOL UseRef);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10switchtoref-getuseref
    BOOL GetUseRef();
}

@GUID("1b940b17-2642-4d1f-ab1f-b99bad0c395f")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nn-d3d10sdklayers-id3d10infoqueue
interface ID3D10InfoQueue : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-setmessagecountlimit
    HRESULT SetMessageCountLimit(ulong MessageCountLimit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-clearstoredmessages
    void    ClearStoredMessages();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-getmessage
    HRESULT GetMessage(ulong MessageIndex, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/D3D10_MESSAGE* pMessage, 
                       size_t* pMessageByteLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-getnummessagesallowedbystoragefilter
    ulong   GetNumMessagesAllowedByStorageFilter();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-getnummessagesdeniedbystoragefilter
    ulong   GetNumMessagesDeniedByStorageFilter();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-getnumstoredmessages
    ulong   GetNumStoredMessages();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-getnumstoredmessagesallowedbyretrievalfilter
    ulong   GetNumStoredMessagesAllowedByRetrievalFilter();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-getnummessagesdiscardedbymessagecountlimit
    ulong   GetNumMessagesDiscardedByMessageCountLimit();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-getmessagecountlimit
    ulong   GetMessageCountLimit();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-addstoragefilterentries
    HRESULT AddStorageFilterEntries(D3D10_INFO_QUEUE_FILTER* pFilter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-getstoragefilter
    HRESULT GetStorageFilter(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/D3D10_INFO_QUEUE_FILTER* pFilter, 
                             size_t* pFilterByteLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-clearstoragefilter
    void    ClearStorageFilter();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-pushemptystoragefilter
    HRESULT PushEmptyStorageFilter();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-pushcopyofstoragefilter
    HRESULT PushCopyOfStorageFilter();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-pushstoragefilter
    HRESULT PushStorageFilter(D3D10_INFO_QUEUE_FILTER* pFilter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-popstoragefilter
    void    PopStorageFilter();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-getstoragefilterstacksize
    uint    GetStorageFilterStackSize();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-addretrievalfilterentries
    HRESULT AddRetrievalFilterEntries(D3D10_INFO_QUEUE_FILTER* pFilter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-getretrievalfilter
    HRESULT GetRetrievalFilter(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/D3D10_INFO_QUEUE_FILTER* pFilter, 
                               size_t* pFilterByteLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-clearretrievalfilter
    void    ClearRetrievalFilter();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-pushemptyretrievalfilter
    HRESULT PushEmptyRetrievalFilter();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-pushcopyofretrievalfilter
    HRESULT PushCopyOfRetrievalFilter();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-pushretrievalfilter
    HRESULT PushRetrievalFilter(D3D10_INFO_QUEUE_FILTER* pFilter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-popretrievalfilter
    void    PopRetrievalFilter();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-getretrievalfilterstacksize
    uint    GetRetrievalFilterStackSize();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-addmessage
    HRESULT AddMessage(D3D10_MESSAGE_CATEGORY Category, D3D10_MESSAGE_SEVERITY Severity, D3D10_MESSAGE_ID ID, 
                       const(PSTR) pDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-addapplicationmessage
    HRESULT AddApplicationMessage(D3D10_MESSAGE_SEVERITY Severity, const(PSTR) pDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-setbreakoncategory
    HRESULT SetBreakOnCategory(D3D10_MESSAGE_CATEGORY Category, BOOL bEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-setbreakonseverity
    HRESULT SetBreakOnSeverity(D3D10_MESSAGE_SEVERITY Severity, BOOL bEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-setbreakonid
    HRESULT SetBreakOnID(D3D10_MESSAGE_ID ID, BOOL bEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-getbreakoncategory
    BOOL    GetBreakOnCategory(D3D10_MESSAGE_CATEGORY Category);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-getbreakonseverity
    BOOL    GetBreakOnSeverity(D3D10_MESSAGE_SEVERITY Severity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-getbreakonid
    BOOL    GetBreakOnID(D3D10_MESSAGE_ID ID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-setmutedebugoutput
    void    SetMuteDebugOutput(BOOL bMute);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10sdklayers/nf-d3d10sdklayers-id3d10infoqueue-getmutedebugoutput
    BOOL    GetMuteDebugOutput();
}

@GUID("c530ad7d-9b16-4395-a979-ba2ecff83add")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nn-d3d10shader-id3d10shaderreflectiontype
interface ID3D10ShaderReflectionType
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nf-d3d10shader-id3d10shaderreflectiontype-getdesc
    HRESULT GetDesc(D3D10_SHADER_TYPE_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nf-d3d10shader-id3d10shaderreflectiontype-getmembertypebyindex
    ID3D10ShaderReflectionType GetMemberTypeByIndex(uint Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nf-d3d10shader-id3d10shaderreflectiontype-getmembertypebyname
    ID3D10ShaderReflectionType GetMemberTypeByName(const(PSTR) Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nf-d3d10shader-id3d10shaderreflectiontype-getmembertypename
    PSTR    GetMemberTypeName(uint Index);
}

@GUID("1bf63c95-2650-405d-99c1-3636bd1da0a1")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nn-d3d10shader-id3d10shaderreflectionvariable
interface ID3D10ShaderReflectionVariable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nf-d3d10shader-id3d10shaderreflectionvariable-getdesc
    HRESULT GetDesc(D3D10_SHADER_VARIABLE_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nf-d3d10shader-id3d10shaderreflectionvariable-gettype
    ID3D10ShaderReflectionType GetType();
}

@GUID("66c66a94-dddd-4b62-a66a-f0da33c2b4d0")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nn-d3d10shader-id3d10shaderreflectionconstantbuffer
interface ID3D10ShaderReflectionConstantBuffer
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nf-d3d10shader-id3d10shaderreflectionconstantbuffer-getdesc
    HRESULT GetDesc(D3D10_SHADER_BUFFER_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nf-d3d10shader-id3d10shaderreflectionconstantbuffer-getvariablebyindex
    ID3D10ShaderReflectionVariable GetVariableByIndex(uint Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nf-d3d10shader-id3d10shaderreflectionconstantbuffer-getvariablebyname
    ID3D10ShaderReflectionVariable GetVariableByName(const(PSTR) Name);
}

@GUID("d40e20b6-f8f7-42ad-ab20-4baf8f15dfaa")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nn-d3d10shader-id3d10shaderreflection
interface ID3D10ShaderReflection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nf-d3d10shader-id3d10shaderreflection-getdesc
    HRESULT GetDesc(D3D10_SHADER_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nf-d3d10shader-id3d10shaderreflection-getconstantbufferbyindex
    ID3D10ShaderReflectionConstantBuffer GetConstantBufferByIndex(uint Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nf-d3d10shader-id3d10shaderreflection-getconstantbufferbyname
    ID3D10ShaderReflectionConstantBuffer GetConstantBufferByName(const(PSTR) Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nf-d3d10shader-id3d10shaderreflection-getresourcebindingdesc
    HRESULT GetResourceBindingDesc(uint ResourceIndex, D3D10_SHADER_INPUT_BIND_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nf-d3d10shader-id3d10shaderreflection-getinputparameterdesc
    HRESULT GetInputParameterDesc(uint ParameterIndex, D3D10_SIGNATURE_PARAMETER_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10shader/nf-d3d10shader-id3d10shaderreflection-getoutputparameterdesc
    HRESULT GetOutputParameterDesc(uint ParameterIndex, D3D10_SIGNATURE_PARAMETER_DESC* pDesc);
}

@GUID("0803425a-57f5-4dd6-9465-a87570834a08")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nn-d3d10effect-id3d10stateblock
interface ID3D10StateBlock : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10stateblock-capture
    HRESULT Capture();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10stateblock-apply
    HRESULT Apply();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10stateblock-releasealldeviceobjects
    HRESULT ReleaseAllDeviceObjects();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10stateblock-getdevice
    HRESULT GetDevice(ID3D10Device* ppDevice);
}

@GUID("4e9e1ddc-cd9d-4772-a837-00180b9b88fd")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nn-d3d10effect-id3d10effecttype
interface ID3D10EffectType
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effecttype-isvalid
    BOOL    IsValid();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effecttype-getdesc
    HRESULT GetDesc(D3D10_EFFECT_TYPE_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effecttype-getmembertypebyindex
    ID3D10EffectType GetMemberTypeByIndex(uint Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effecttype-getmembertypebyname
    ID3D10EffectType GetMemberTypeByName(const(PSTR) Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effecttype-getmembertypebysemantic
    ID3D10EffectType GetMemberTypeBySemantic(const(PSTR) Semantic);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effecttype-getmembername
    PSTR    GetMemberName(uint Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effecttype-getmembersemantic
    PSTR    GetMemberSemantic(uint Index);
}

@GUID("ae897105-00e6-45bf-bb8e-281dd6db8e1b")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nn-d3d10effect-id3d10effectvariable
interface ID3D10EffectVariable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvariable-isvalid
    BOOL    IsValid();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvariable-gettype
    ID3D10EffectType GetType();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvariable-getdesc
    HRESULT GetDesc(D3D10_EFFECT_VARIABLE_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvariable-getannotationbyindex
    ID3D10EffectVariable GetAnnotationByIndex(uint Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvariable-getannotationbyname
    ID3D10EffectVariable GetAnnotationByName(const(PSTR) Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvariable-getmemberbyindex
    ID3D10EffectVariable GetMemberByIndex(uint Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvariable-getmemberbyname
    ID3D10EffectVariable GetMemberByName(const(PSTR) Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvariable-getmemberbysemantic
    ID3D10EffectVariable GetMemberBySemantic(const(PSTR) Semantic);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvariable-getelement
    ID3D10EffectVariable GetElement(uint Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvariable-getparentconstantbuffer
    ID3D10EffectConstantBuffer GetParentConstantBuffer();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvariable-asscalar
    ID3D10EffectScalarVariable AsScalar();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvariable-asvector
    ID3D10EffectVectorVariable AsVector();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvariable-asmatrix
    ID3D10EffectMatrixVariable AsMatrix();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvariable-asstring
    ID3D10EffectStringVariable AsString();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvariable-asshaderresource
    ID3D10EffectShaderResourceVariable AsShaderResource();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvariable-asrendertargetview
    ID3D10EffectRenderTargetViewVariable AsRenderTargetView();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvariable-asdepthstencilview
    ID3D10EffectDepthStencilViewVariable AsDepthStencilView();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvariable-asconstantbuffer
    ID3D10EffectConstantBuffer AsConstantBuffer();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvariable-asshader
    ID3D10EffectShaderVariable AsShader();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvariable-asblend
    ID3D10EffectBlendVariable AsBlend();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvariable-asdepthstencil
    ID3D10EffectDepthStencilVariable AsDepthStencil();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvariable-asrasterizer
    ID3D10EffectRasterizerVariable AsRasterizer();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvariable-assampler
    ID3D10EffectSamplerVariable AsSampler();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvariable-setrawvalue
    HRESULT SetRawValue(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pData, 
                        uint Offset, uint ByteCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvariable-getrawvalue
    HRESULT GetRawValue(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pData, 
                        uint Offset, uint ByteCount);
}

@GUID("00e48f7b-d2c8-49e8-a86c-022dee53431f")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nn-d3d10effect-id3d10effectscalarvariable
interface ID3D10EffectScalarVariable : ID3D10EffectVariable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectscalarvariable-setfloat
    HRESULT SetFloat(float Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectscalarvariable-getfloat
    HRESULT GetFloat(float* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectscalarvariable-setfloatarray
    HRESULT SetFloatArray(float* pData, uint Offset, uint Count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectscalarvariable-getfloatarray
    HRESULT GetFloatArray(float* pData, uint Offset, uint Count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectscalarvariable-setint
    HRESULT SetInt(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectscalarvariable-getint
    HRESULT GetInt(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectscalarvariable-setintarray
    HRESULT SetIntArray(int* pData, uint Offset, uint Count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectscalarvariable-getintarray
    HRESULT GetIntArray(int* pData, uint Offset, uint Count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectscalarvariable-setbool
    HRESULT SetBool(BOOL Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectscalarvariable-getbool
    HRESULT GetBool(BOOL* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectscalarvariable-setboolarray
    HRESULT SetBoolArray(BOOL* pData, uint Offset, uint Count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectscalarvariable-getboolarray
    HRESULT GetBoolArray(BOOL* pData, uint Offset, uint Count);
}

@GUID("62b98c44-1f82-4c67-bcd0-72cf8f217e81")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nn-d3d10effect-id3d10effectvectorvariable
interface ID3D10EffectVectorVariable : ID3D10EffectVariable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvectorvariable-setboolvector
    HRESULT SetBoolVector(BOOL* pData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvectorvariable-setintvector
    HRESULT SetIntVector(int* pData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvectorvariable-setfloatvector
    HRESULT SetFloatVector(float* pData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvectorvariable-getboolvector
    HRESULT GetBoolVector(BOOL* pData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvectorvariable-getintvector
    HRESULT GetIntVector(int* pData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvectorvariable-getfloatvector
    HRESULT GetFloatVector(float* pData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvectorvariable-setboolvectorarray
    HRESULT SetBoolVectorArray(BOOL* pData, uint Offset, uint Count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvectorvariable-setintvectorarray
    HRESULT SetIntVectorArray(int* pData, uint Offset, uint Count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvectorvariable-setfloatvectorarray
    HRESULT SetFloatVectorArray(float* pData, uint Offset, uint Count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvectorvariable-getboolvectorarray
    HRESULT GetBoolVectorArray(BOOL* pData, uint Offset, uint Count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvectorvariable-getintvectorarray
    HRESULT GetIntVectorArray(int* pData, uint Offset, uint Count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectvectorvariable-getfloatvectorarray
    HRESULT GetFloatVectorArray(float* pData, uint Offset, uint Count);
}

@GUID("50666c24-b82f-4eed-a172-5b6e7e8522e0")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nn-d3d10effect-id3d10effectmatrixvariable
interface ID3D10EffectMatrixVariable : ID3D10EffectVariable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectmatrixvariable-setmatrix
    HRESULT SetMatrix(float* pData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectmatrixvariable-getmatrix
    HRESULT GetMatrix(float* pData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectmatrixvariable-setmatrixarray
    HRESULT SetMatrixArray(float* pData, uint Offset, uint Count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectmatrixvariable-getmatrixarray
    HRESULT GetMatrixArray(float* pData, uint Offset, uint Count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectmatrixvariable-setmatrixtranspose
    HRESULT SetMatrixTranspose(float* pData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectmatrixvariable-getmatrixtranspose
    HRESULT GetMatrixTranspose(float* pData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectmatrixvariable-setmatrixtransposearray
    HRESULT SetMatrixTransposeArray(float* pData, uint Offset, uint Count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectmatrixvariable-getmatrixtransposearray
    HRESULT GetMatrixTransposeArray(float* pData, uint Offset, uint Count);
}

@GUID("71417501-8df9-4e0a-a78a-255f9756baff")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nn-d3d10effect-id3d10effectstringvariable
interface ID3D10EffectStringVariable : ID3D10EffectVariable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectstringvariable-getstring
    HRESULT GetString(const(PSTR)* ppString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectstringvariable-getstringarray
    HRESULT GetStringArray(const(PSTR)* ppStrings, uint Offset, uint Count);
}

@GUID("c0a7157b-d872-4b1d-8073-efc2acd4b1fc")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nn-d3d10effect-id3d10effectshaderresourcevariable
interface ID3D10EffectShaderResourceVariable : ID3D10EffectVariable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectshaderresourcevariable-setresource
    HRESULT SetResource(ID3D10ShaderResourceView pResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectshaderresourcevariable-getresource
    HRESULT GetResource(ID3D10ShaderResourceView* ppResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectshaderresourcevariable-setresourcearray
    HRESULT SetResourceArray(ID3D10ShaderResourceView* ppResources, uint Offset, uint Count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectshaderresourcevariable-getresourcearray
    HRESULT GetResourceArray(ID3D10ShaderResourceView* ppResources, uint Offset, uint Count);
}

@GUID("28ca0cc3-c2c9-40bb-b57f-67b737122b17")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nn-d3d10effect-id3d10effectrendertargetviewvariable
interface ID3D10EffectRenderTargetViewVariable : ID3D10EffectVariable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectrendertargetviewvariable-setrendertarget
    HRESULT SetRenderTarget(ID3D10RenderTargetView pResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectrendertargetviewvariable-getrendertarget
    HRESULT GetRenderTarget(ID3D10RenderTargetView* ppResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectrendertargetviewvariable-setrendertargetarray
    HRESULT SetRenderTargetArray(ID3D10RenderTargetView* ppResources, uint Offset, uint Count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectrendertargetviewvariable-getrendertargetarray
    HRESULT GetRenderTargetArray(ID3D10RenderTargetView* ppResources, uint Offset, uint Count);
}

@GUID("3e02c918-cc79-4985-b622-2d92ad701623")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nn-d3d10effect-id3d10effectdepthstencilviewvariable
interface ID3D10EffectDepthStencilViewVariable : ID3D10EffectVariable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectdepthstencilviewvariable-setdepthstencil
    HRESULT SetDepthStencil(ID3D10DepthStencilView pResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectdepthstencilviewvariable-getdepthstencil
    HRESULT GetDepthStencil(ID3D10DepthStencilView* ppResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectdepthstencilviewvariable-setdepthstencilarray
    HRESULT SetDepthStencilArray(ID3D10DepthStencilView* ppResources, uint Offset, uint Count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectdepthstencilviewvariable-getdepthstencilarray
    HRESULT GetDepthStencilArray(ID3D10DepthStencilView* ppResources, uint Offset, uint Count);
}

@GUID("56648f4d-cc8b-4444-a5ad-b5a3d76e91b3")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nn-d3d10effect-id3d10effectconstantbuffer
interface ID3D10EffectConstantBuffer : ID3D10EffectVariable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectconstantbuffer-setconstantbuffer
    HRESULT SetConstantBuffer(ID3D10Buffer pConstantBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectconstantbuffer-getconstantbuffer
    HRESULT GetConstantBuffer(ID3D10Buffer* ppConstantBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectconstantbuffer-settexturebuffer
    HRESULT SetTextureBuffer(ID3D10ShaderResourceView pTextureBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectconstantbuffer-gettexturebuffer
    HRESULT GetTextureBuffer(ID3D10ShaderResourceView* ppTextureBuffer);
}

@GUID("80849279-c799-4797-8c33-0407a07d9e06")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nn-d3d10effect-id3d10effectshadervariable
interface ID3D10EffectShaderVariable : ID3D10EffectVariable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectshadervariable-getshaderdesc
    HRESULT GetShaderDesc(uint ShaderIndex, D3D10_EFFECT_SHADER_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectshadervariable-getvertexshader
    HRESULT GetVertexShader(uint ShaderIndex, ID3D10VertexShader* ppVS);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectshadervariable-getgeometryshader
    HRESULT GetGeometryShader(uint ShaderIndex, ID3D10GeometryShader* ppGS);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectshadervariable-getpixelshader
    HRESULT GetPixelShader(uint ShaderIndex, ID3D10PixelShader* ppPS);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectshadervariable-getinputsignatureelementdesc
    HRESULT GetInputSignatureElementDesc(uint ShaderIndex, uint Element, D3D10_SIGNATURE_PARAMETER_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectshadervariable-getoutputsignatureelementdesc
    HRESULT GetOutputSignatureElementDesc(uint ShaderIndex, uint Element, D3D10_SIGNATURE_PARAMETER_DESC* pDesc);
}

@GUID("1fcd2294-df6d-4eae-86b3-0e9160cfb07b")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nn-d3d10effect-id3d10effectblendvariable
interface ID3D10EffectBlendVariable : ID3D10EffectVariable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectblendvariable-getblendstate
    HRESULT GetBlendState(uint Index, ID3D10BlendState* ppBlendState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectblendvariable-getbackingstore
    HRESULT GetBackingStore(uint Index, D3D10_BLEND_DESC* pBlendDesc);
}

@GUID("af482368-330a-46a5-9a5c-01c71af24c8d")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nn-d3d10effect-id3d10effectdepthstencilvariable
interface ID3D10EffectDepthStencilVariable : ID3D10EffectVariable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectdepthstencilvariable-getdepthstencilstate
    HRESULT GetDepthStencilState(uint Index, ID3D10DepthStencilState* ppDepthStencilState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectdepthstencilvariable-getbackingstore
    HRESULT GetBackingStore(uint Index, D3D10_DEPTH_STENCIL_DESC* pDepthStencilDesc);
}

@GUID("21af9f0e-4d94-4ea9-9785-2cb76b8c0b34")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nn-d3d10effect-id3d10effectrasterizervariable
interface ID3D10EffectRasterizerVariable : ID3D10EffectVariable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectrasterizervariable-getrasterizerstate
    HRESULT GetRasterizerState(uint Index, ID3D10RasterizerState* ppRasterizerState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectrasterizervariable-getbackingstore
    HRESULT GetBackingStore(uint Index, D3D10_RASTERIZER_DESC* pRasterizerDesc);
}

@GUID("6530d5c7-07e9-4271-a418-e7ce4bd1e480")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nn-d3d10effect-id3d10effectsamplervariable
interface ID3D10EffectSamplerVariable : ID3D10EffectVariable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectsamplervariable-getsampler
    HRESULT GetSampler(uint Index, ID3D10SamplerState* ppSampler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectsamplervariable-getbackingstore
    HRESULT GetBackingStore(uint Index, D3D10_SAMPLER_DESC* pSamplerDesc);
}

@GUID("5cfbeb89-1a06-46e0-b282-e3f9bfa36a54")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nn-d3d10effect-id3d10effectpass
interface ID3D10EffectPass
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectpass-isvalid
    BOOL    IsValid();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectpass-getdesc
    HRESULT GetDesc(D3D10_PASS_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectpass-getvertexshaderdesc
    HRESULT GetVertexShaderDesc(D3D10_PASS_SHADER_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectpass-getgeometryshaderdesc
    HRESULT GetGeometryShaderDesc(D3D10_PASS_SHADER_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectpass-getpixelshaderdesc
    HRESULT GetPixelShaderDesc(D3D10_PASS_SHADER_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectpass-getannotationbyindex
    ID3D10EffectVariable GetAnnotationByIndex(uint Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectpass-getannotationbyname
    ID3D10EffectVariable GetAnnotationByName(const(PSTR) Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectpass-apply
    HRESULT Apply(uint Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectpass-computestateblockmask
    HRESULT ComputeStateBlockMask(D3D10_STATE_BLOCK_MASK* pStateBlockMask);
}

@GUID("db122ce8-d1c9-4292-b237-24ed3de8b175")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nn-d3d10effect-id3d10effecttechnique
interface ID3D10EffectTechnique
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effecttechnique-isvalid
    BOOL    IsValid();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effecttechnique-getdesc
    HRESULT GetDesc(D3D10_TECHNIQUE_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effecttechnique-getannotationbyindex
    ID3D10EffectVariable GetAnnotationByIndex(uint Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effecttechnique-getannotationbyname
    ID3D10EffectVariable GetAnnotationByName(const(PSTR) Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effecttechnique-getpassbyindex
    ID3D10EffectPass GetPassByIndex(uint Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effecttechnique-getpassbyname
    ID3D10EffectPass GetPassByName(const(PSTR) Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effecttechnique-computestateblockmask
    HRESULT ComputeStateBlockMask(D3D10_STATE_BLOCK_MASK* pStateBlockMask);
}

@GUID("51b0ca8b-ec0b-4519-870d-8ee1cb5017c7")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nn-d3d10effect-id3d10effect
interface ID3D10Effect : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effect-isvalid
    BOOL    IsValid();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effect-ispool
    BOOL    IsPool();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effect-getdevice
    HRESULT GetDevice(ID3D10Device* ppDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effect-getdesc
    HRESULT GetDesc(D3D10_EFFECT_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effect-getconstantbufferbyindex
    ID3D10EffectConstantBuffer GetConstantBufferByIndex(uint Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effect-getconstantbufferbyname
    ID3D10EffectConstantBuffer GetConstantBufferByName(const(PSTR) Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effect-getvariablebyindex
    ID3D10EffectVariable GetVariableByIndex(uint Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effect-getvariablebyname
    ID3D10EffectVariable GetVariableByName(const(PSTR) Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effect-getvariablebysemantic
    ID3D10EffectVariable GetVariableBySemantic(const(PSTR) Semantic);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effect-gettechniquebyindex
    ID3D10EffectTechnique GetTechniqueByIndex(uint Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effect-gettechniquebyname
    ID3D10EffectTechnique GetTechniqueByName(const(PSTR) Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effect-optimize
    HRESULT Optimize();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effect-isoptimized
    BOOL    IsOptimized();
}

@GUID("9537ab04-3250-412e-8213-fcd2f8677933")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nn-d3d10effect-id3d10effectpool
interface ID3D10EffectPool : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10effect/nf-d3d10effect-id3d10effectpool-aseffect
    ID3D10Effect AsEffect();
}

@GUID("edad8d99-8a35-4d6d-8566-2ea276cde161")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1/nn-d3d10_1-id3d10blendstate1
interface ID3D10BlendState1 : ID3D10BlendState
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1/nf-d3d10_1-id3d10blendstate1-getdesc1
    void GetDesc1(D3D10_BLEND_DESC1* pDesc);
}

@GUID("9b7e4c87-342c-4106-a19f-4f2704f689f0")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1/nn-d3d10_1-id3d10shaderresourceview1
interface ID3D10ShaderResourceView1 : ID3D10ShaderResourceView
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1/nf-d3d10_1-id3d10shaderresourceview1-getdesc1
    void GetDesc1(D3D10_SHADER_RESOURCE_VIEW_DESC1* pDesc);
}

@GUID("9b7e4c8f-342c-4106-a19f-4f2704f689f0")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1/nn-d3d10_1-id3d10device1
interface ID3D10Device1 : ID3D10Device
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1/nf-d3d10_1-id3d10device1-createshaderresourceview1
    HRESULT CreateShaderResourceView1(ID3D10Resource pResource, const(D3D10_SHADER_RESOURCE_VIEW_DESC1)* pDesc, 
                                      ID3D10ShaderResourceView1* ppSRView);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1/nf-d3d10_1-id3d10device1-createblendstate1
    HRESULT CreateBlendState1(const(D3D10_BLEND_DESC1)* pBlendStateDesc, ID3D10BlendState1* ppBlendState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1/nf-d3d10_1-id3d10device1-getfeaturelevel
    D3D10_FEATURE_LEVEL1 GetFeatureLevel();
}

@GUID("c3457783-a846-47ce-9520-cea6f66e7447")
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1shader/nn-d3d10_1shader-id3d10shaderreflection1
interface ID3D10ShaderReflection1 : IUnknown
{
    HRESULT GetDesc(D3D10_SHADER_DESC* pDesc);
    ID3D10ShaderReflectionConstantBuffer GetConstantBufferByIndex(uint Index);
    ID3D10ShaderReflectionConstantBuffer GetConstantBufferByName(const(PSTR) Name);
    HRESULT GetResourceBindingDesc(uint ResourceIndex, D3D10_SHADER_INPUT_BIND_DESC* pDesc);
    HRESULT GetInputParameterDesc(uint ParameterIndex, D3D10_SIGNATURE_PARAMETER_DESC* pDesc);
    HRESULT GetOutputParameterDesc(uint ParameterIndex, D3D10_SIGNATURE_PARAMETER_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1shader/nf-d3d10_1shader-id3d10shaderreflection1-getvariablebyname
    ID3D10ShaderReflectionVariable GetVariableByName(const(PSTR) Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1shader/nf-d3d10_1shader-id3d10shaderreflection1-getresourcebindingdescbyname
    HRESULT GetResourceBindingDescByName(const(PSTR) Name, D3D10_SHADER_INPUT_BIND_DESC* pDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1shader/nf-d3d10_1shader-id3d10shaderreflection1-getmovinstructioncount
    HRESULT GetMovInstructionCount(uint* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1shader/nf-d3d10_1shader-id3d10shaderreflection1-getmovcinstructioncount
    HRESULT GetMovcInstructionCount(uint* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1shader/nf-d3d10_1shader-id3d10shaderreflection1-getconversioninstructioncount
    HRESULT GetConversionInstructionCount(uint* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1shader/nf-d3d10_1shader-id3d10shaderreflection1-getbitwiseinstructioncount
    HRESULT GetBitwiseInstructionCount(uint* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1shader/nf-d3d10_1shader-id3d10shaderreflection1-getgsinputprimitive
    HRESULT GetGSInputPrimitive(D3D_PRIMITIVE* pPrim);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1shader/nf-d3d10_1shader-id3d10shaderreflection1-islevel9shader
    HRESULT IsLevel9Shader(BOOL* pbLevel9Shader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d3d10_1shader/nf-d3d10_1shader-id3d10shaderreflection1-issamplefrequencyshader
    HRESULT IsSampleFrequencyShader(BOOL* pbSampleFrequency);
}


// GUIDs


const GUID IID_ID3D10Asynchronous                   = GUIDOF!ID3D10Asynchronous;
const GUID IID_ID3D10BlendState                     = GUIDOF!ID3D10BlendState;
const GUID IID_ID3D10BlendState1                    = GUIDOF!ID3D10BlendState1;
const GUID IID_ID3D10Buffer                         = GUIDOF!ID3D10Buffer;
const GUID IID_ID3D10Counter                        = GUIDOF!ID3D10Counter;
const GUID IID_ID3D10Debug                          = GUIDOF!ID3D10Debug;
const GUID IID_ID3D10DepthStencilState              = GUIDOF!ID3D10DepthStencilState;
const GUID IID_ID3D10DepthStencilView               = GUIDOF!ID3D10DepthStencilView;
const GUID IID_ID3D10Device                         = GUIDOF!ID3D10Device;
const GUID IID_ID3D10Device1                        = GUIDOF!ID3D10Device1;
const GUID IID_ID3D10DeviceChild                    = GUIDOF!ID3D10DeviceChild;
const GUID IID_ID3D10Effect                         = GUIDOF!ID3D10Effect;
const GUID IID_ID3D10EffectBlendVariable            = GUIDOF!ID3D10EffectBlendVariable;
const GUID IID_ID3D10EffectConstantBuffer           = GUIDOF!ID3D10EffectConstantBuffer;
const GUID IID_ID3D10EffectDepthStencilVariable     = GUIDOF!ID3D10EffectDepthStencilVariable;
const GUID IID_ID3D10EffectDepthStencilViewVariable = GUIDOF!ID3D10EffectDepthStencilViewVariable;
const GUID IID_ID3D10EffectMatrixVariable           = GUIDOF!ID3D10EffectMatrixVariable;
const GUID IID_ID3D10EffectPass                     = GUIDOF!ID3D10EffectPass;
const GUID IID_ID3D10EffectPool                     = GUIDOF!ID3D10EffectPool;
const GUID IID_ID3D10EffectRasterizerVariable       = GUIDOF!ID3D10EffectRasterizerVariable;
const GUID IID_ID3D10EffectRenderTargetViewVariable = GUIDOF!ID3D10EffectRenderTargetViewVariable;
const GUID IID_ID3D10EffectSamplerVariable          = GUIDOF!ID3D10EffectSamplerVariable;
const GUID IID_ID3D10EffectScalarVariable           = GUIDOF!ID3D10EffectScalarVariable;
const GUID IID_ID3D10EffectShaderResourceVariable   = GUIDOF!ID3D10EffectShaderResourceVariable;
const GUID IID_ID3D10EffectShaderVariable           = GUIDOF!ID3D10EffectShaderVariable;
const GUID IID_ID3D10EffectStringVariable           = GUIDOF!ID3D10EffectStringVariable;
const GUID IID_ID3D10EffectTechnique                = GUIDOF!ID3D10EffectTechnique;
const GUID IID_ID3D10EffectType                     = GUIDOF!ID3D10EffectType;
const GUID IID_ID3D10EffectVariable                 = GUIDOF!ID3D10EffectVariable;
const GUID IID_ID3D10EffectVectorVariable           = GUIDOF!ID3D10EffectVectorVariable;
const GUID IID_ID3D10GeometryShader                 = GUIDOF!ID3D10GeometryShader;
const GUID IID_ID3D10InfoQueue                      = GUIDOF!ID3D10InfoQueue;
const GUID IID_ID3D10InputLayout                    = GUIDOF!ID3D10InputLayout;
const GUID IID_ID3D10Multithread                    = GUIDOF!ID3D10Multithread;
const GUID IID_ID3D10PixelShader                    = GUIDOF!ID3D10PixelShader;
const GUID IID_ID3D10Predicate                      = GUIDOF!ID3D10Predicate;
const GUID IID_ID3D10Query                          = GUIDOF!ID3D10Query;
const GUID IID_ID3D10RasterizerState                = GUIDOF!ID3D10RasterizerState;
const GUID IID_ID3D10RenderTargetView               = GUIDOF!ID3D10RenderTargetView;
const GUID IID_ID3D10Resource                       = GUIDOF!ID3D10Resource;
const GUID IID_ID3D10SamplerState                   = GUIDOF!ID3D10SamplerState;
const GUID IID_ID3D10ShaderReflection               = GUIDOF!ID3D10ShaderReflection;
const GUID IID_ID3D10ShaderReflection1              = GUIDOF!ID3D10ShaderReflection1;
const GUID IID_ID3D10ShaderReflectionConstantBuffer = GUIDOF!ID3D10ShaderReflectionConstantBuffer;
const GUID IID_ID3D10ShaderReflectionType           = GUIDOF!ID3D10ShaderReflectionType;
const GUID IID_ID3D10ShaderReflectionVariable       = GUIDOF!ID3D10ShaderReflectionVariable;
const GUID IID_ID3D10ShaderResourceView             = GUIDOF!ID3D10ShaderResourceView;
const GUID IID_ID3D10ShaderResourceView1            = GUIDOF!ID3D10ShaderResourceView1;
const GUID IID_ID3D10StateBlock                     = GUIDOF!ID3D10StateBlock;
const GUID IID_ID3D10SwitchToRef                    = GUIDOF!ID3D10SwitchToRef;
const GUID IID_ID3D10Texture1D                      = GUIDOF!ID3D10Texture1D;
const GUID IID_ID3D10Texture2D                      = GUIDOF!ID3D10Texture2D;
const GUID IID_ID3D10Texture3D                      = GUIDOF!ID3D10Texture3D;
const GUID IID_ID3D10VertexShader                   = GUIDOF!ID3D10VertexShader;
const GUID IID_ID3D10View                           = GUIDOF!ID3D10View;
