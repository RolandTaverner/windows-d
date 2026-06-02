// Written in the D programming language.

module windows.win32.graphics.opengl;

public import windows.core;
public import windows.win32.foundation : BOOL, COLORREF, PROC, PSTR, PWSTR;
public import windows.win32.graphics.gdi : EMR, HDC, HENHMETAFILE;

extern(Windows) @nogc nothrow:


// Enums


alias PFD_PIXEL_TYPE = ubyte;
enum : ubyte
{
    PFD_TYPE_RGBA       = 0x00,
    PFD_TYPE_COLORINDEX = 0x01,
}

alias PFD_LAYER_TYPE = byte;
enum : byte
{
    PFD_UNDERLAY_PLANE = 0xff,
    PFD_MAIN_PLANE     = 0x00,
    PFD_OVERLAY_PLANE  = 0x01,
}

alias PFD_FLAGS = uint;
enum : uint
{
    PFD_DOUBLEBUFFER          = 0x00000001U,
    PFD_STEREO                = 0x00000002U,
    PFD_DRAW_TO_WINDOW        = 0x00000004U,
    PFD_DRAW_TO_BITMAP        = 0x00000008U,
    PFD_SUPPORT_GDI           = 0x00000010U,
    PFD_SUPPORT_OPENGL        = 0x00000020U,
    PFD_GENERIC_FORMAT        = 0x00000040U,
    PFD_NEED_PALETTE          = 0x00000080U,
    PFD_NEED_SYSTEM_PALETTE   = 0x00000100U,
    PFD_SWAP_EXCHANGE         = 0x00000200U,
    PFD_SWAP_COPY             = 0x00000400U,
    PFD_SWAP_LAYER_BUFFERS    = 0x00000800U,
    PFD_GENERIC_ACCELERATED   = 0x00001000U,
    PFD_SUPPORT_DIRECTDRAW    = 0x00002000U,
    PFD_DIRECT3D_ACCELERATED  = 0x00004000U,
    PFD_SUPPORT_COMPOSITION   = 0x00008000U,
    PFD_DEPTH_DONTCARE        = 0x20000000U,
    PFD_DOUBLEBUFFER_DONTCARE = 0x40000000U,
    PFD_STEREO_DONTCARE       = 0x80000000U,
}

// Constants


enum uint GL_VERSION_1_1 = 0x00000001U;
enum uint GL_ACCUM = 0x00000100U;

enum : uint
{
    GL_LOAD   = 0x00000101U,
    GL_RETURN = 0x00000102U,
}

enum : uint
{
    GL_MULT  = 0x00000103U,
    GL_ADD   = 0x00000104U,
    GL_NEVER = 0x00000200U,
}

enum : uint
{
    GL_LESS  = 0x00000201U,
    GL_EQUAL = 0x00000202U,
}

enum uint GL_LEQUAL = 0x00000203U;
enum uint GL_GREATER = 0x00000204U;
enum uint GL_NOTEQUAL = 0x00000205U;
enum uint GL_GEQUAL = 0x00000206U;
enum uint GL_ALWAYS = 0x00000207U;
enum uint GL_CURRENT_BIT = 0x00000001U;
enum uint GL_POINT_BIT = 0x00000002U;
enum uint GL_LINE_BIT = 0x00000004U;

enum : uint
{
    GL_POLYGON_BIT         = 0x00000008U,
    GL_POLYGON_STIPPLE_BIT = 0x00000010U,
}

enum uint GL_PIXEL_MODE_BIT = 0x00000020U;
enum uint GL_LIGHTING_BIT = 0x00000040U;
enum uint GL_FOG_BIT = 0x00000080U;
enum uint GL_DEPTH_BUFFER_BIT = 0x00000100U;
enum uint GL_ACCUM_BUFFER_BIT = 0x00000200U;
enum uint GL_STENCIL_BUFFER_BIT = 0x00000400U;
enum uint GL_VIEWPORT_BIT = 0x00000800U;
enum uint GL_TRANSFORM_BIT = 0x00001000U;
enum uint GL_ENABLE_BIT = 0x00002000U;
enum uint GL_COLOR_BUFFER_BIT = 0x00004000U;
enum uint GL_HINT_BIT = 0x00008000U;
enum uint GL_EVAL_BIT = 0x00010000U;
enum uint GL_LIST_BIT = 0x00020000U;
enum uint GL_TEXTURE_BIT = 0x00040000U;
enum uint GL_SCISSOR_BIT = 0x00080000U;
enum uint GL_ALL_ATTRIB_BITS = 0x000fffffU;
enum uint GL_POINTS = 0x00000000U;

enum : uint
{
    GL_LINES      = 0x00000001U,
    GL_LINE_LOOP  = 0x00000002U,
    GL_LINE_STRIP = 0x00000003U,
}

enum : uint
{
    GL_TRIANGLES      = 0x00000004U,
    GL_TRIANGLE_STRIP = 0x00000005U,
    GL_TRIANGLE_FAN   = 0x00000006U,
}

enum : uint
{
    GL_QUADS      = 0x00000007U,
    GL_QUAD_STRIP = 0x00000008U,
}

enum uint GL_POLYGON = 0x00000009U;

enum : uint
{
    GL_ZERO      = 0x00000000U,
    GL_ONE       = 0x00000001U,
    GL_SRC_COLOR = 0x00000300U,
}

enum uint GL_ONE_MINUS_SRC_COLOR = 0x00000301U;
enum uint GL_SRC_ALPHA = 0x00000302U;
enum uint GL_ONE_MINUS_SRC_ALPHA = 0x00000303U;
enum uint GL_DST_ALPHA = 0x00000304U;
enum uint GL_ONE_MINUS_DST_ALPHA = 0x00000305U;
enum uint GL_DST_COLOR = 0x00000306U;
enum uint GL_ONE_MINUS_DST_COLOR = 0x00000307U;
enum uint GL_SRC_ALPHA_SATURATE = 0x00000308U;

enum : uint
{
    GL_TRUE  = 0x00000001U,
    GL_FALSE = 0x00000000U,
}

enum : uint
{
    GL_CLIP_PLANE0 = 0x00003000U,
    GL_CLIP_PLANE1 = 0x00003001U,
    GL_CLIP_PLANE2 = 0x00003002U,
    GL_CLIP_PLANE3 = 0x00003003U,
    GL_CLIP_PLANE4 = 0x00003004U,
    GL_CLIP_PLANE5 = 0x00003005U,
}

enum : uint
{
    GL_BYTE          = 0x00001400U,
    GL_UNSIGNED_BYTE = 0x00001401U,
}

enum uint GL_SHORT = 0x00001402U;
enum uint GL_UNSIGNED_SHORT = 0x00001403U;

enum : uint
{
    GL_INT          = 0x00001404U,
    GL_UNSIGNED_INT = 0x00001405U,
}

enum uint GL_FLOAT = 0x00001406U;
enum uint GL_2_BYTES = 0x00001407U;
enum uint GL_3_BYTES = 0x00001408U;
enum uint GL_4_BYTES = 0x00001409U;
enum uint GL_DOUBLE = 0x0000140aU;

enum : uint
{
    GL_NONE        = 0x00000000U,
    GL_FRONT_LEFT  = 0x00000400U,
    GL_FRONT_RIGHT = 0x00000401U,
}

enum : uint
{
    GL_BACK_LEFT  = 0x00000402U,
    GL_BACK_RIGHT = 0x00000403U,
}

enum uint GL_FRONT = 0x00000404U;

enum : uint
{
    GL_BACK  = 0x00000405U,
    GL_LEFT  = 0x00000406U,
    GL_RIGHT = 0x00000407U,
}

enum uint GL_FRONT_AND_BACK = 0x00000408U;

enum : uint
{
    GL_AUX0     = 0x00000409U,
    GL_AUX1     = 0x0000040aU,
    GL_AUX2     = 0x0000040bU,
    GL_AUX3     = 0x0000040cU,
    GL_NO_ERROR = 0x00000000U,
}

enum : uint
{
    GL_INVALID_ENUM      = 0x00000500U,
    GL_INVALID_VALUE     = 0x00000501U,
    GL_INVALID_OPERATION = 0x00000502U,
}

enum : uint
{
    GL_STACK_OVERFLOW  = 0x00000503U,
    GL_STACK_UNDERFLOW = 0x00000504U,
}

enum uint GL_OUT_OF_MEMORY = 0x00000505U;

enum : uint
{
    GL_2D               = 0x00000600U,
    GL_3D               = 0x00000601U,
    GL_3D_COLOR         = 0x00000602U,
    GL_3D_COLOR_TEXTURE = 0x00000603U,
}

enum uint GL_4D_COLOR_TEXTURE = 0x00000604U;
enum uint GL_PASS_THROUGH_TOKEN = 0x00000700U;
enum uint GL_POINT_TOKEN = 0x00000701U;
enum uint GL_LINE_TOKEN = 0x00000702U;
enum uint GL_POLYGON_TOKEN = 0x00000703U;
enum uint GL_BITMAP_TOKEN = 0x00000704U;
enum uint GL_DRAW_PIXEL_TOKEN = 0x00000705U;
enum uint GL_COPY_PIXEL_TOKEN = 0x00000706U;
enum uint GL_LINE_RESET_TOKEN = 0x00000707U;

enum : uint
{
    GL_EXP   = 0x00000800U,
    GL_EXP2  = 0x00000801U,
    GL_CW    = 0x00000900U,
    GL_CCW   = 0x00000901U,
    GL_COEFF = 0x00000a00U,
}

enum uint GL_ORDER = 0x00000a01U;
enum uint GL_DOMAIN = 0x00000a02U;

enum : uint
{
    GL_CURRENT_COLOR                 = 0x00000b00U,
    GL_CURRENT_INDEX                 = 0x00000b01U,
    GL_CURRENT_NORMAL                = 0x00000b02U,
    GL_CURRENT_TEXTURE_COORDS        = 0x00000b03U,
    GL_CURRENT_RASTER_COLOR          = 0x00000b04U,
    GL_CURRENT_RASTER_INDEX          = 0x00000b05U,
    GL_CURRENT_RASTER_TEXTURE_COORDS = 0x00000b06U,
    GL_CURRENT_RASTER_POSITION       = 0x00000b07U,
    GL_CURRENT_RASTER_POSITION_VALID = 0x00000b08U,
    GL_CURRENT_RASTER_DISTANCE       = 0x00000b09U,
}

enum : uint
{
    GL_POINT_SMOOTH           = 0x00000b10U,
    GL_POINT_SIZE             = 0x00000b11U,
    GL_POINT_SIZE_RANGE       = 0x00000b12U,
    GL_POINT_SIZE_GRANULARITY = 0x00000b13U,
}

enum : uint
{
    GL_LINE_SMOOTH            = 0x00000b20U,
    GL_LINE_WIDTH             = 0x00000b21U,
    GL_LINE_WIDTH_RANGE       = 0x00000b22U,
    GL_LINE_WIDTH_GRANULARITY = 0x00000b23U,
}

enum : uint
{
    GL_LINE_STIPPLE         = 0x00000b24U,
    GL_LINE_STIPPLE_PATTERN = 0x00000b25U,
    GL_LINE_STIPPLE_REPEAT  = 0x00000b26U,
}

enum uint GL_LIST_MODE = 0x00000b30U;
enum uint GL_MAX_LIST_NESTING = 0x00000b31U;

enum : uint
{
    GL_LIST_BASE  = 0x00000b32U,
    GL_LIST_INDEX = 0x00000b33U,
}

enum : uint
{
    GL_POLYGON_MODE    = 0x00000b40U,
    GL_POLYGON_SMOOTH  = 0x00000b41U,
    GL_POLYGON_STIPPLE = 0x00000b42U,
}

enum uint GL_EDGE_FLAG = 0x00000b43U;

enum : uint
{
    GL_CULL_FACE      = 0x00000b44U,
    GL_CULL_FACE_MODE = 0x00000b45U,
}

enum uint GL_FRONT_FACE = 0x00000b46U;

enum : uint
{
    GL_LIGHTING                 = 0x00000b50U,
    GL_LIGHT_MODEL_LOCAL_VIEWER = 0x00000b51U,
    GL_LIGHT_MODEL_TWO_SIDE     = 0x00000b52U,
    GL_LIGHT_MODEL_AMBIENT      = 0x00000b53U,
}

enum uint GL_SHADE_MODEL = 0x00000b54U;

enum : uint
{
    GL_COLOR_MATERIAL_FACE      = 0x00000b55U,
    GL_COLOR_MATERIAL_PARAMETER = 0x00000b56U,
    GL_COLOR_MATERIAL           = 0x00000b57U,
}

enum : uint
{
    GL_FOG         = 0x00000b60U,
    GL_FOG_INDEX   = 0x00000b61U,
    GL_FOG_DENSITY = 0x00000b62U,
    GL_FOG_START   = 0x00000b63U,
    GL_FOG_END     = 0x00000b64U,
    GL_FOG_MODE    = 0x00000b65U,
    GL_FOG_COLOR   = 0x00000b66U,
}

enum : uint
{
    GL_DEPTH_RANGE       = 0x00000b70U,
    GL_DEPTH_TEST        = 0x00000b71U,
    GL_DEPTH_WRITEMASK   = 0x00000b72U,
    GL_DEPTH_CLEAR_VALUE = 0x00000b73U,
    GL_DEPTH_FUNC        = 0x00000b74U,
}

enum uint GL_ACCUM_CLEAR_VALUE = 0x00000b80U;

enum : uint
{
    GL_STENCIL_TEST            = 0x00000b90U,
    GL_STENCIL_CLEAR_VALUE     = 0x00000b91U,
    GL_STENCIL_FUNC            = 0x00000b92U,
    GL_STENCIL_VALUE_MASK      = 0x00000b93U,
    GL_STENCIL_FAIL            = 0x00000b94U,
    GL_STENCIL_PASS_DEPTH_FAIL = 0x00000b95U,
    GL_STENCIL_PASS_DEPTH_PASS = 0x00000b96U,
    GL_STENCIL_REF             = 0x00000b97U,
    GL_STENCIL_WRITEMASK       = 0x00000b98U,
}

enum uint GL_MATRIX_MODE = 0x00000ba0U;
enum uint GL_NORMALIZE = 0x00000ba1U;
enum uint GL_VIEWPORT = 0x00000ba2U;
enum uint GL_MODELVIEW_STACK_DEPTH = 0x00000ba3U;
enum uint GL_PROJECTION_STACK_DEPTH = 0x00000ba4U;
enum uint GL_TEXTURE_STACK_DEPTH = 0x00000ba5U;
enum uint GL_MODELVIEW_MATRIX = 0x00000ba6U;
enum uint GL_PROJECTION_MATRIX = 0x00000ba7U;
enum uint GL_TEXTURE_MATRIX = 0x00000ba8U;
enum uint GL_ATTRIB_STACK_DEPTH = 0x00000bb0U;
enum uint GL_CLIENT_ATTRIB_STACK_DEPTH = 0x00000bb1U;

enum : uint
{
    GL_ALPHA_TEST      = 0x00000bc0U,
    GL_ALPHA_TEST_FUNC = 0x00000bc1U,
    GL_ALPHA_TEST_REF  = 0x00000bc2U,
}

enum uint GL_DITHER = 0x00000bd0U;

enum : uint
{
    GL_BLEND_DST = 0x00000be0U,
    GL_BLEND_SRC = 0x00000be1U,
    GL_BLEND     = 0x00000be2U,
}

enum uint GL_LOGIC_OP_MODE = 0x00000bf0U;
enum uint GL_INDEX_LOGIC_OP = 0x00000bf1U;
enum uint GL_COLOR_LOGIC_OP = 0x00000bf2U;
enum uint GL_AUX_BUFFERS = 0x00000c00U;
enum uint GL_DRAW_BUFFER = 0x00000c01U;
enum uint GL_READ_BUFFER = 0x00000c02U;

enum : uint
{
    GL_SCISSOR_BOX  = 0x00000c10U,
    GL_SCISSOR_TEST = 0x00000c11U,
}

enum : uint
{
    GL_INDEX_CLEAR_VALUE = 0x00000c20U,
    GL_INDEX_WRITEMASK   = 0x00000c21U,
}

enum : uint
{
    GL_COLOR_CLEAR_VALUE = 0x00000c22U,
    GL_COLOR_WRITEMASK   = 0x00000c23U,
}

enum uint GL_INDEX_MODE = 0x00000c30U;
enum uint GL_RGBA_MODE = 0x00000c31U;
enum uint GL_DOUBLEBUFFER = 0x00000c32U;
enum uint GL_STEREO = 0x00000c33U;
enum uint GL_RENDER_MODE = 0x00000c40U;
enum uint GL_PERSPECTIVE_CORRECTION_HINT = 0x00000c50U;
enum uint GL_POINT_SMOOTH_HINT = 0x00000c51U;
enum uint GL_LINE_SMOOTH_HINT = 0x00000c52U;
enum uint GL_POLYGON_SMOOTH_HINT = 0x00000c53U;
enum uint GL_FOG_HINT = 0x00000c54U;

enum : uint
{
    GL_TEXTURE_GEN_S = 0x00000c60U,
    GL_TEXTURE_GEN_T = 0x00000c61U,
    GL_TEXTURE_GEN_R = 0x00000c62U,
    GL_TEXTURE_GEN_Q = 0x00000c63U,
}

enum : uint
{
    GL_PIXEL_MAP_I_TO_I      = 0x00000c70U,
    GL_PIXEL_MAP_S_TO_S      = 0x00000c71U,
    GL_PIXEL_MAP_I_TO_R      = 0x00000c72U,
    GL_PIXEL_MAP_I_TO_G      = 0x00000c73U,
    GL_PIXEL_MAP_I_TO_B      = 0x00000c74U,
    GL_PIXEL_MAP_I_TO_A      = 0x00000c75U,
    GL_PIXEL_MAP_R_TO_R      = 0x00000c76U,
    GL_PIXEL_MAP_G_TO_G      = 0x00000c77U,
    GL_PIXEL_MAP_B_TO_B      = 0x00000c78U,
    GL_PIXEL_MAP_A_TO_A      = 0x00000c79U,
    GL_PIXEL_MAP_I_TO_I_SIZE = 0x00000cb0U,
    GL_PIXEL_MAP_S_TO_S_SIZE = 0x00000cb1U,
    GL_PIXEL_MAP_I_TO_R_SIZE = 0x00000cb2U,
    GL_PIXEL_MAP_I_TO_G_SIZE = 0x00000cb3U,
    GL_PIXEL_MAP_I_TO_B_SIZE = 0x00000cb4U,
    GL_PIXEL_MAP_I_TO_A_SIZE = 0x00000cb5U,
    GL_PIXEL_MAP_R_TO_R_SIZE = 0x00000cb6U,
    GL_PIXEL_MAP_G_TO_G_SIZE = 0x00000cb7U,
    GL_PIXEL_MAP_B_TO_B_SIZE = 0x00000cb8U,
    GL_PIXEL_MAP_A_TO_A_SIZE = 0x00000cb9U,
}

enum : uint
{
    GL_UNPACK_SWAP_BYTES  = 0x00000cf0U,
    GL_UNPACK_LSB_FIRST   = 0x00000cf1U,
    GL_UNPACK_ROW_LENGTH  = 0x00000cf2U,
    GL_UNPACK_SKIP_ROWS   = 0x00000cf3U,
    GL_UNPACK_SKIP_PIXELS = 0x00000cf4U,
    GL_UNPACK_ALIGNMENT   = 0x00000cf5U,
}

enum : uint
{
    GL_PACK_SWAP_BYTES  = 0x00000d00U,
    GL_PACK_LSB_FIRST   = 0x00000d01U,
    GL_PACK_ROW_LENGTH  = 0x00000d02U,
    GL_PACK_SKIP_ROWS   = 0x00000d03U,
    GL_PACK_SKIP_PIXELS = 0x00000d04U,
    GL_PACK_ALIGNMENT   = 0x00000d05U,
}

enum : uint
{
    GL_MAP_COLOR   = 0x00000d10U,
    GL_MAP_STENCIL = 0x00000d11U,
}

enum : uint
{
    GL_INDEX_SHIFT  = 0x00000d12U,
    GL_INDEX_OFFSET = 0x00000d13U,
}

enum : uint
{
    GL_RED_SCALE = 0x00000d14U,
    GL_RED_BIAS  = 0x00000d15U,
}

enum : uint
{
    GL_ZOOM_X = 0x00000d16U,
    GL_ZOOM_Y = 0x00000d17U,
}

enum : uint
{
    GL_GREEN_SCALE = 0x00000d18U,
    GL_GREEN_BIAS  = 0x00000d19U,
}

enum : uint
{
    GL_BLUE_SCALE = 0x00000d1aU,
    GL_BLUE_BIAS  = 0x00000d1bU,
}

enum : uint
{
    GL_ALPHA_SCALE = 0x00000d1cU,
    GL_ALPHA_BIAS  = 0x00000d1dU,
}

enum : uint
{
    GL_DEPTH_SCALE = 0x00000d1eU,
    GL_DEPTH_BIAS  = 0x00000d1fU,
}

enum : uint
{
    GL_MAX_EVAL_ORDER  = 0x00000d30U,
    GL_MAX_LIGHTS      = 0x00000d31U,
    GL_MAX_CLIP_PLANES = 0x00000d32U,
}

enum uint GL_MAX_TEXTURE_SIZE = 0x00000d33U;
enum uint GL_MAX_PIXEL_MAP_TABLE = 0x00000d34U;
enum uint GL_MAX_ATTRIB_STACK_DEPTH = 0x00000d35U;
enum uint GL_MAX_MODELVIEW_STACK_DEPTH = 0x00000d36U;
enum uint GL_MAX_NAME_STACK_DEPTH = 0x00000d37U;
enum uint GL_MAX_PROJECTION_STACK_DEPTH = 0x00000d38U;
enum uint GL_MAX_TEXTURE_STACK_DEPTH = 0x00000d39U;
enum uint GL_MAX_VIEWPORT_DIMS = 0x00000d3aU;
enum uint GL_MAX_CLIENT_ATTRIB_STACK_DEPTH = 0x00000d3bU;
enum uint GL_SUBPIXEL_BITS = 0x00000d50U;
enum uint GL_INDEX_BITS = 0x00000d51U;
enum uint GL_RED_BITS = 0x00000d52U;
enum uint GL_GREEN_BITS = 0x00000d53U;
enum uint GL_BLUE_BITS = 0x00000d54U;
enum uint GL_ALPHA_BITS = 0x00000d55U;
enum uint GL_DEPTH_BITS = 0x00000d56U;
enum uint GL_STENCIL_BITS = 0x00000d57U;

enum : uint
{
    GL_ACCUM_RED_BITS   = 0x00000d58U,
    GL_ACCUM_GREEN_BITS = 0x00000d59U,
    GL_ACCUM_BLUE_BITS  = 0x00000d5aU,
    GL_ACCUM_ALPHA_BITS = 0x00000d5bU,
}

enum uint GL_NAME_STACK_DEPTH = 0x00000d70U;
enum uint GL_AUTO_NORMAL = 0x00000d80U;

enum : uint
{
    GL_MAP1_COLOR_4         = 0x00000d90U,
    GL_MAP1_INDEX           = 0x00000d91U,
    GL_MAP1_NORMAL          = 0x00000d92U,
    GL_MAP1_TEXTURE_COORD_1 = 0x00000d93U,
    GL_MAP1_TEXTURE_COORD_2 = 0x00000d94U,
    GL_MAP1_TEXTURE_COORD_3 = 0x00000d95U,
    GL_MAP1_TEXTURE_COORD_4 = 0x00000d96U,
}

enum : uint
{
    GL_MAP1_VERTEX_3 = 0x00000d97U,
    GL_MAP1_VERTEX_4 = 0x00000d98U,
}

enum : uint
{
    GL_MAP2_COLOR_4         = 0x00000db0U,
    GL_MAP2_INDEX           = 0x00000db1U,
    GL_MAP2_NORMAL          = 0x00000db2U,
    GL_MAP2_TEXTURE_COORD_1 = 0x00000db3U,
    GL_MAP2_TEXTURE_COORD_2 = 0x00000db4U,
    GL_MAP2_TEXTURE_COORD_3 = 0x00000db5U,
    GL_MAP2_TEXTURE_COORD_4 = 0x00000db6U,
}

enum : uint
{
    GL_MAP2_VERTEX_3 = 0x00000db7U,
    GL_MAP2_VERTEX_4 = 0x00000db8U,
}

enum : uint
{
    GL_MAP1_GRID_DOMAIN   = 0x00000dd0U,
    GL_MAP1_GRID_SEGMENTS = 0x00000dd1U,
}

enum : uint
{
    GL_MAP2_GRID_DOMAIN   = 0x00000dd2U,
    GL_MAP2_GRID_SEGMENTS = 0x00000dd3U,
}

enum : uint
{
    GL_TEXTURE_1D = 0x00000de0U,
    GL_TEXTURE_2D = 0x00000de1U,
}

enum : uint
{
    GL_FEEDBACK_BUFFER_POINTER = 0x00000df0U,
    GL_FEEDBACK_BUFFER_SIZE    = 0x00000df1U,
    GL_FEEDBACK_BUFFER_TYPE    = 0x00000df2U,
}

enum : uint
{
    GL_SELECTION_BUFFER_POINTER = 0x00000df3U,
    GL_SELECTION_BUFFER_SIZE    = 0x00000df4U,
}

enum : uint
{
    GL_TEXTURE_WIDTH           = 0x00001000U,
    GL_TEXTURE_HEIGHT          = 0x00001001U,
    GL_TEXTURE_INTERNAL_FORMAT = 0x00001003U,
    GL_TEXTURE_BORDER_COLOR    = 0x00001004U,
    GL_TEXTURE_BORDER          = 0x00001005U,
}

enum uint GL_DONT_CARE = 0x00001100U;
enum uint GL_FASTEST = 0x00001101U;
enum uint GL_NICEST = 0x00001102U;

enum : uint
{
    GL_LIGHT0 = 0x00004000U,
    GL_LIGHT1 = 0x00004001U,
    GL_LIGHT2 = 0x00004002U,
    GL_LIGHT3 = 0x00004003U,
    GL_LIGHT4 = 0x00004004U,
    GL_LIGHT5 = 0x00004005U,
    GL_LIGHT6 = 0x00004006U,
    GL_LIGHT7 = 0x00004007U,
}

enum uint GL_AMBIENT = 0x00001200U;
enum uint GL_DIFFUSE = 0x00001201U;
enum uint GL_SPECULAR = 0x00001202U;
enum uint GL_POSITION = 0x00001203U;

enum : uint
{
    GL_SPOT_DIRECTION = 0x00001204U,
    GL_SPOT_EXPONENT  = 0x00001205U,
    GL_SPOT_CUTOFF    = 0x00001206U,
}

enum uint GL_CONSTANT_ATTENUATION = 0x00001207U;
enum uint GL_LINEAR_ATTENUATION = 0x00001208U;
enum uint GL_QUADRATIC_ATTENUATION = 0x00001209U;

enum : uint
{
    GL_COMPILE             = 0x00001300U,
    GL_COMPILE_AND_EXECUTE = 0x00001301U,
}

enum uint GL_CLEAR = 0x00001500U;

enum : uint
{
    GL_AND         = 0x00001501U,
    GL_AND_REVERSE = 0x00001502U,
}

enum : uint
{
    GL_COPY         = 0x00001503U,
    GL_AND_INVERTED = 0x00001504U,
}

enum : uint
{
    GL_NOOP  = 0x00001505U,
    GL_XOR   = 0x00001506U,
    GL_OR    = 0x00001507U,
    GL_NOR   = 0x00001508U,
    GL_EQUIV = 0x00001509U,
}

enum uint GL_INVERT = 0x0000150aU;
enum uint GL_OR_REVERSE = 0x0000150bU;
enum uint GL_COPY_INVERTED = 0x0000150cU;
enum uint GL_OR_INVERTED = 0x0000150dU;

enum : uint
{
    GL_NAND     = 0x0000150eU,
    GL_SET      = 0x0000150fU,
    GL_EMISSION = 0x00001600U,
}

enum uint GL_SHININESS = 0x00001601U;
enum uint GL_AMBIENT_AND_DIFFUSE = 0x00001602U;
enum uint GL_COLOR_INDEXES = 0x00001603U;
enum uint GL_MODELVIEW = 0x00001700U;
enum uint GL_PROJECTION = 0x00001701U;
enum uint GL_TEXTURE = 0x00001702U;
enum uint GL_COLOR = 0x00001800U;
enum uint GL_DEPTH = 0x00001801U;
enum uint GL_STENCIL = 0x00001802U;
enum uint GL_COLOR_INDEX = 0x00001900U;
enum uint GL_STENCIL_INDEX = 0x00001901U;
enum uint GL_DEPTH_COMPONENT = 0x00001902U;

enum : uint
{
    GL_RED   = 0x00001903U,
    GL_GREEN = 0x00001904U,
}

enum : uint
{
    GL_BLUE  = 0x00001905U,
    GL_ALPHA = 0x00001906U,
}

enum : uint
{
    GL_RGB             = 0x00001907U,
    GL_RGBA            = 0x00001908U,
    GL_LUMINANCE       = 0x00001909U,
    GL_LUMINANCE_ALPHA = 0x0000190aU,
}

enum uint GL_BITMAP = 0x00001a00U;
enum uint GL_POINT = 0x00001b00U;

enum : uint
{
    GL_LINE   = 0x00001b01U,
    GL_FILL   = 0x00001b02U,
    GL_RENDER = 0x00001c00U,
}

enum uint GL_FEEDBACK = 0x00001c01U;
enum uint GL_SELECT = 0x00001c02U;

enum : uint
{
    GL_FLAT   = 0x00001d00U,
    GL_SMOOTH = 0x00001d01U,
}

enum : uint
{
    GL_KEEP    = 0x00001e00U,
    GL_REPLACE = 0x00001e01U,
}

enum : uint
{
    GL_INCR   = 0x00001e02U,
    GL_DECR   = 0x00001e03U,
    GL_VENDOR = 0x00001f00U,
}

enum uint GL_RENDERER = 0x00001f01U;
enum uint GL_VERSION = 0x00001f02U;
enum uint GL_EXTENSIONS = 0x00001f03U;

enum : uint
{
    GL_S        = 0x00002000U,
    GL_T        = 0x00002001U,
    GL_R        = 0x00002002U,
    GL_Q        = 0x00002003U,
    GL_MODULATE = 0x00002100U,
}

enum uint GL_DECAL = 0x00002101U;

enum : uint
{
    GL_TEXTURE_ENV_MODE  = 0x00002200U,
    GL_TEXTURE_ENV_COLOR = 0x00002201U,
    GL_TEXTURE_ENV       = 0x00002300U,
}

enum uint GL_EYE_LINEAR = 0x00002400U;
enum uint GL_OBJECT_LINEAR = 0x00002401U;
enum uint GL_SPHERE_MAP = 0x00002402U;
enum uint GL_TEXTURE_GEN_MODE = 0x00002500U;
enum uint GL_OBJECT_PLANE = 0x00002501U;
enum uint GL_EYE_PLANE = 0x00002502U;
enum uint GL_NEAREST = 0x00002600U;
enum uint GL_LINEAR = 0x00002601U;
enum uint GL_NEAREST_MIPMAP_NEAREST = 0x00002700U;
enum uint GL_LINEAR_MIPMAP_NEAREST = 0x00002701U;
enum uint GL_NEAREST_MIPMAP_LINEAR = 0x00002702U;
enum uint GL_LINEAR_MIPMAP_LINEAR = 0x00002703U;

enum : uint
{
    GL_TEXTURE_MAG_FILTER = 0x00002800U,
    GL_TEXTURE_MIN_FILTER = 0x00002801U,
    GL_TEXTURE_WRAP_S     = 0x00002802U,
    GL_TEXTURE_WRAP_T     = 0x00002803U,
}

enum uint GL_CLAMP = 0x00002900U;
enum uint GL_REPEAT = 0x00002901U;
enum uint GL_CLIENT_PIXEL_STORE_BIT = 0x00000001U;
enum uint GL_CLIENT_VERTEX_ARRAY_BIT = 0x00000002U;
enum uint GL_CLIENT_ALL_ATTRIB_BITS = 0xffffffffU;

enum : uint
{
    GL_POLYGON_OFFSET_FACTOR = 0x00008038U,
    GL_POLYGON_OFFSET_UNITS  = 0x00002a00U,
    GL_POLYGON_OFFSET_POINT  = 0x00002a01U,
    GL_POLYGON_OFFSET_LINE   = 0x00002a02U,
    GL_POLYGON_OFFSET_FILL   = 0x00008037U,
}

enum : uint
{
    GL_ALPHA4  = 0x0000803bU,
    GL_ALPHA8  = 0x0000803cU,
    GL_ALPHA12 = 0x0000803dU,
    GL_ALPHA16 = 0x0000803eU,
}

enum : uint
{
    GL_LUMINANCE4          = 0x0000803fU,
    GL_LUMINANCE8          = 0x00008040U,
    GL_LUMINANCE12         = 0x00008041U,
    GL_LUMINANCE16         = 0x00008042U,
    GL_LUMINANCE4_ALPHA4   = 0x00008043U,
    GL_LUMINANCE6_ALPHA2   = 0x00008044U,
    GL_LUMINANCE8_ALPHA8   = 0x00008045U,
    GL_LUMINANCE12_ALPHA4  = 0x00008046U,
    GL_LUMINANCE12_ALPHA12 = 0x00008047U,
    GL_LUMINANCE16_ALPHA16 = 0x00008048U,
}

enum : uint
{
    GL_INTENSITY   = 0x00008049U,
    GL_INTENSITY4  = 0x0000804aU,
    GL_INTENSITY8  = 0x0000804bU,
    GL_INTENSITY12 = 0x0000804cU,
    GL_INTENSITY16 = 0x0000804dU,
}

enum uint GL_R3_G3_B2 = 0x00002a10U;

enum : uint
{
    GL_RGB4     = 0x0000804fU,
    GL_RGB5     = 0x00008050U,
    GL_RGB8     = 0x00008051U,
    GL_RGB10    = 0x00008052U,
    GL_RGB12    = 0x00008053U,
    GL_RGB16    = 0x00008054U,
    GL_RGBA2    = 0x00008055U,
    GL_RGBA4    = 0x00008056U,
    GL_RGB5_A1  = 0x00008057U,
    GL_RGBA8    = 0x00008058U,
    GL_RGB10_A2 = 0x00008059U,
    GL_RGBA12   = 0x0000805aU,
    GL_RGBA16   = 0x0000805bU,
}

enum : uint
{
    GL_TEXTURE_RED_SIZE       = 0x0000805cU,
    GL_TEXTURE_GREEN_SIZE     = 0x0000805dU,
    GL_TEXTURE_BLUE_SIZE      = 0x0000805eU,
    GL_TEXTURE_ALPHA_SIZE     = 0x0000805fU,
    GL_TEXTURE_LUMINANCE_SIZE = 0x00008060U,
    GL_TEXTURE_INTENSITY_SIZE = 0x00008061U,
}

enum : uint
{
    GL_PROXY_TEXTURE_1D = 0x00008063U,
    GL_PROXY_TEXTURE_2D = 0x00008064U,
}

enum : uint
{
    GL_TEXTURE_PRIORITY   = 0x00008066U,
    GL_TEXTURE_RESIDENT   = 0x00008067U,
    GL_TEXTURE_BINDING_1D = 0x00008068U,
    GL_TEXTURE_BINDING_2D = 0x00008069U,
}

enum uint GL_VERTEX_ARRAY = 0x00008074U;
enum uint GL_NORMAL_ARRAY = 0x00008075U;
enum uint GL_COLOR_ARRAY = 0x00008076U;
enum uint GL_INDEX_ARRAY = 0x00008077U;
enum uint GL_TEXTURE_COORD_ARRAY = 0x00008078U;
enum uint GL_EDGE_FLAG_ARRAY = 0x00008079U;

enum : uint
{
    GL_VERTEX_ARRAY_SIZE   = 0x0000807aU,
    GL_VERTEX_ARRAY_TYPE   = 0x0000807bU,
    GL_VERTEX_ARRAY_STRIDE = 0x0000807cU,
}

enum : uint
{
    GL_NORMAL_ARRAY_TYPE   = 0x0000807eU,
    GL_NORMAL_ARRAY_STRIDE = 0x0000807fU,
}

enum : uint
{
    GL_COLOR_ARRAY_SIZE   = 0x00008081U,
    GL_COLOR_ARRAY_TYPE   = 0x00008082U,
    GL_COLOR_ARRAY_STRIDE = 0x00008083U,
}

enum : uint
{
    GL_INDEX_ARRAY_TYPE   = 0x00008085U,
    GL_INDEX_ARRAY_STRIDE = 0x00008086U,
}

enum : uint
{
    GL_TEXTURE_COORD_ARRAY_SIZE   = 0x00008088U,
    GL_TEXTURE_COORD_ARRAY_TYPE   = 0x00008089U,
    GL_TEXTURE_COORD_ARRAY_STRIDE = 0x0000808aU,
}

enum uint GL_EDGE_FLAG_ARRAY_STRIDE = 0x0000808cU;
enum uint GL_VERTEX_ARRAY_POINTER = 0x0000808eU;
enum uint GL_NORMAL_ARRAY_POINTER = 0x0000808fU;
enum uint GL_COLOR_ARRAY_POINTER = 0x00008090U;
enum uint GL_INDEX_ARRAY_POINTER = 0x00008091U;
enum uint GL_TEXTURE_COORD_ARRAY_POINTER = 0x00008092U;
enum uint GL_EDGE_FLAG_ARRAY_POINTER = 0x00008093U;

enum : uint
{
    GL_V2F      = 0x00002a20U,
    GL_V3F      = 0x00002a21U,
    GL_C4UB_V2F = 0x00002a22U,
    GL_C4UB_V3F = 0x00002a23U,
}

enum uint GL_C3F_V3F = 0x00002a24U;
enum uint GL_N3F_V3F = 0x00002a25U;
enum uint GL_C4F_N3F_V3F = 0x00002a26U;
enum uint GL_T2F_V3F = 0x00002a27U;
enum uint GL_T4F_V4F = 0x00002a28U;

enum : uint
{
    GL_T2F_C4UB_V3F    = 0x00002a29U,
    GL_T2F_C3F_V3F     = 0x00002a2aU,
    GL_T2F_N3F_V3F     = 0x00002a2bU,
    GL_T2F_C4F_N3F_V3F = 0x00002a2cU,
}

enum uint GL_T4F_C4F_N3F_V4F = 0x00002a2dU;
enum uint GL_EXT_vertex_array = 0x00000001U;

enum : uint
{
    GL_EXT_bgra             = 0x00000001U,
    GL_EXT_paletted_texture = 0x00000001U,
}

enum : uint
{
    GL_WIN_swap_hint           = 0x00000001U,
    GL_WIN_draw_range_elements = 0x00000001U,
}

enum uint GL_VERTEX_ARRAY_EXT = 0x00008074U;
enum uint GL_NORMAL_ARRAY_EXT = 0x00008075U;
enum uint GL_COLOR_ARRAY_EXT = 0x00008076U;
enum uint GL_INDEX_ARRAY_EXT = 0x00008077U;
enum uint GL_TEXTURE_COORD_ARRAY_EXT = 0x00008078U;
enum uint GL_EDGE_FLAG_ARRAY_EXT = 0x00008079U;

enum : uint
{
    GL_VERTEX_ARRAY_SIZE_EXT   = 0x0000807aU,
    GL_VERTEX_ARRAY_TYPE_EXT   = 0x0000807bU,
    GL_VERTEX_ARRAY_STRIDE_EXT = 0x0000807cU,
    GL_VERTEX_ARRAY_COUNT_EXT  = 0x0000807dU,
}

enum : uint
{
    GL_NORMAL_ARRAY_TYPE_EXT   = 0x0000807eU,
    GL_NORMAL_ARRAY_STRIDE_EXT = 0x0000807fU,
    GL_NORMAL_ARRAY_COUNT_EXT  = 0x00008080U,
}

enum : uint
{
    GL_COLOR_ARRAY_SIZE_EXT   = 0x00008081U,
    GL_COLOR_ARRAY_TYPE_EXT   = 0x00008082U,
    GL_COLOR_ARRAY_STRIDE_EXT = 0x00008083U,
    GL_COLOR_ARRAY_COUNT_EXT  = 0x00008084U,
}

enum : uint
{
    GL_INDEX_ARRAY_TYPE_EXT   = 0x00008085U,
    GL_INDEX_ARRAY_STRIDE_EXT = 0x00008086U,
    GL_INDEX_ARRAY_COUNT_EXT  = 0x00008087U,
}

enum : uint
{
    GL_TEXTURE_COORD_ARRAY_SIZE_EXT   = 0x00008088U,
    GL_TEXTURE_COORD_ARRAY_TYPE_EXT   = 0x00008089U,
    GL_TEXTURE_COORD_ARRAY_STRIDE_EXT = 0x0000808aU,
    GL_TEXTURE_COORD_ARRAY_COUNT_EXT  = 0x0000808bU,
}

enum : uint
{
    GL_EDGE_FLAG_ARRAY_STRIDE_EXT = 0x0000808cU,
    GL_EDGE_FLAG_ARRAY_COUNT_EXT  = 0x0000808dU,
}

enum uint GL_VERTEX_ARRAY_POINTER_EXT = 0x0000808eU;
enum uint GL_NORMAL_ARRAY_POINTER_EXT = 0x0000808fU;
enum uint GL_COLOR_ARRAY_POINTER_EXT = 0x00008090U;
enum uint GL_INDEX_ARRAY_POINTER_EXT = 0x00008091U;
enum uint GL_TEXTURE_COORD_ARRAY_POINTER_EXT = 0x00008092U;
enum uint GL_EDGE_FLAG_ARRAY_POINTER_EXT = 0x00008093U;
enum uint GL_DOUBLE_EXT = 0x0000140aU;

enum : uint
{
    GL_BGR_EXT  = 0x000080e0U,
    GL_BGRA_EXT = 0x000080e1U,
}

enum : uint
{
    GL_COLOR_TABLE_FORMAT_EXT         = 0x000080d8U,
    GL_COLOR_TABLE_WIDTH_EXT          = 0x000080d9U,
    GL_COLOR_TABLE_RED_SIZE_EXT       = 0x000080daU,
    GL_COLOR_TABLE_GREEN_SIZE_EXT     = 0x000080dbU,
    GL_COLOR_TABLE_BLUE_SIZE_EXT      = 0x000080dcU,
    GL_COLOR_TABLE_ALPHA_SIZE_EXT     = 0x000080ddU,
    GL_COLOR_TABLE_LUMINANCE_SIZE_EXT = 0x000080deU,
    GL_COLOR_TABLE_INTENSITY_SIZE_EXT = 0x000080dfU,
}

enum : uint
{
    GL_COLOR_INDEX1_EXT  = 0x000080e2U,
    GL_COLOR_INDEX2_EXT  = 0x000080e3U,
    GL_COLOR_INDEX4_EXT  = 0x000080e4U,
    GL_COLOR_INDEX8_EXT  = 0x000080e5U,
    GL_COLOR_INDEX12_EXT = 0x000080e6U,
    GL_COLOR_INDEX16_EXT = 0x000080e7U,
}

enum : uint
{
    GL_MAX_ELEMENTS_VERTICES_WIN = 0x000080e8U,
    GL_MAX_ELEMENTS_INDICES_WIN  = 0x000080e9U,
}

enum : uint
{
    GL_PHONG_WIN      = 0x000080eaU,
    GL_PHONG_HINT_WIN = 0x000080ebU,
}

enum uint GL_FOG_SPECULAR_TEXTURE_WIN = 0x000080ecU;
enum uint GL_LOGIC_OP = 0x00000bf1U;
enum uint GL_TEXTURE_COMPONENTS = 0x00001003U;

enum : uint
{
    GLU_VERSION_1_1 = 0x00000001U,
    GLU_VERSION_1_2 = 0x00000001U,
}

enum : uint
{
    GLU_INVALID_ENUM  = 0x00018a24U,
    GLU_INVALID_VALUE = 0x00018a25U,
}

enum uint GLU_OUT_OF_MEMORY = 0x00018a26U;
enum uint GLU_INCOMPATIBLE_GL_VERSION = 0x00018a27U;
enum uint GLU_VERSION = 0x000189c0U;
enum uint GLU_EXTENSIONS = 0x000189c1U;

enum : uint
{
    GLU_TRUE   = 0x00000001U,
    GLU_FALSE  = 0x00000000U,
    GLU_SMOOTH = 0x000186a0U,
}

enum : uint
{
    GLU_FLAT       = 0x000186a1U,
    GLU_NONE       = 0x000186a2U,
    GLU_POINT      = 0x000186aaU,
    GLU_LINE       = 0x000186abU,
    GLU_FILL       = 0x000186acU,
    GLU_SILHOUETTE = 0x000186adU,
}

enum uint GLU_OUTSIDE = 0x000186b4U;
enum uint GLU_INSIDE = 0x000186b5U;

enum : uint
{
    GLU_TESS_WINDING_RULE        = 0x0001872cU,
    GLU_TESS_BOUNDARY_ONLY       = 0x0001872dU,
    GLU_TESS_TOLERANCE           = 0x0001872eU,
    GLU_TESS_WINDING_ODD         = 0x00018722U,
    GLU_TESS_WINDING_NONZERO     = 0x00018723U,
    GLU_TESS_WINDING_POSITIVE    = 0x00018724U,
    GLU_TESS_WINDING_NEGATIVE    = 0x00018725U,
    GLU_TESS_WINDING_ABS_GEQ_TWO = 0x00018726U,
}

enum : uint
{
    GLU_TESS_BEGIN          = 0x00018704U,
    GLU_TESS_VERTEX         = 0x00018705U,
    GLU_TESS_END            = 0x00018706U,
    GLU_TESS_ERROR          = 0x00018707U,
    GLU_TESS_EDGE_FLAG      = 0x00018708U,
    GLU_TESS_COMBINE        = 0x00018709U,
    GLU_TESS_BEGIN_DATA     = 0x0001870aU,
    GLU_TESS_VERTEX_DATA    = 0x0001870bU,
    GLU_TESS_END_DATA       = 0x0001870cU,
    GLU_TESS_ERROR_DATA     = 0x0001870dU,
    GLU_TESS_EDGE_FLAG_DATA = 0x0001870eU,
}

enum : uint
{
    GLU_TESS_COMBINE_DATA          = 0x0001870fU,
    GLU_TESS_ERROR1                = 0x00018737U,
    GLU_TESS_ERROR2                = 0x00018738U,
    GLU_TESS_ERROR3                = 0x00018739U,
    GLU_TESS_ERROR4                = 0x0001873aU,
    GLU_TESS_ERROR5                = 0x0001873bU,
    GLU_TESS_ERROR6                = 0x0001873cU,
    GLU_TESS_ERROR7                = 0x0001873dU,
    GLU_TESS_ERROR8                = 0x0001873eU,
    GLU_TESS_MISSING_BEGIN_POLYGON = 0x00018737U,
    GLU_TESS_MISSING_BEGIN_CONTOUR = 0x00018738U,
    GLU_TESS_MISSING_END_POLYGON   = 0x00018739U,
    GLU_TESS_MISSING_END_CONTOUR   = 0x0001873aU,
}

enum uint GLU_TESS_COORD_TOO_LARGE = 0x0001873bU;
enum uint GLU_TESS_NEED_COMBINE_CALLBACK = 0x0001873cU;
enum uint GLU_AUTO_LOAD_MATRIX = 0x00018768U;
enum uint GLU_CULLING = 0x00018769U;
enum uint GLU_SAMPLING_TOLERANCE = 0x0001876bU;
enum uint GLU_DISPLAY_MODE = 0x0001876cU;
enum uint GLU_PARAMETRIC_TOLERANCE = 0x0001876aU;
enum uint GLU_SAMPLING_METHOD = 0x0001876dU;
enum uint GLU_U_STEP = 0x0001876eU;
enum uint GLU_V_STEP = 0x0001876fU;
enum uint GLU_PATH_LENGTH = 0x00018777U;
enum uint GLU_PARAMETRIC_ERROR = 0x00018778U;
enum uint GLU_DOMAIN_DISTANCE = 0x00018779U;

enum : uint
{
    GLU_MAP1_TRIM_2 = 0x00018772U,
    GLU_MAP1_TRIM_3 = 0x00018773U,
}

enum : uint
{
    GLU_OUTLINE_POLYGON = 0x00018790U,
    GLU_OUTLINE_PATCH   = 0x00018791U,
}

enum : uint
{
    GLU_NURBS_ERROR1  = 0x0001879bU,
    GLU_NURBS_ERROR2  = 0x0001879cU,
    GLU_NURBS_ERROR3  = 0x0001879dU,
    GLU_NURBS_ERROR4  = 0x0001879eU,
    GLU_NURBS_ERROR5  = 0x0001879fU,
    GLU_NURBS_ERROR6  = 0x000187a0U,
    GLU_NURBS_ERROR7  = 0x000187a1U,
    GLU_NURBS_ERROR8  = 0x000187a2U,
    GLU_NURBS_ERROR9  = 0x000187a3U,
    GLU_NURBS_ERROR10 = 0x000187a4U,
    GLU_NURBS_ERROR11 = 0x000187a5U,
    GLU_NURBS_ERROR12 = 0x000187a6U,
    GLU_NURBS_ERROR13 = 0x000187a7U,
    GLU_NURBS_ERROR14 = 0x000187a8U,
    GLU_NURBS_ERROR15 = 0x000187a9U,
    GLU_NURBS_ERROR16 = 0x000187aaU,
    GLU_NURBS_ERROR17 = 0x000187abU,
    GLU_NURBS_ERROR18 = 0x000187acU,
    GLU_NURBS_ERROR19 = 0x000187adU,
    GLU_NURBS_ERROR20 = 0x000187aeU,
    GLU_NURBS_ERROR21 = 0x000187afU,
    GLU_NURBS_ERROR22 = 0x000187b0U,
    GLU_NURBS_ERROR23 = 0x000187b1U,
    GLU_NURBS_ERROR24 = 0x000187b2U,
    GLU_NURBS_ERROR25 = 0x000187b3U,
    GLU_NURBS_ERROR26 = 0x000187b4U,
    GLU_NURBS_ERROR27 = 0x000187b5U,
    GLU_NURBS_ERROR28 = 0x000187b6U,
    GLU_NURBS_ERROR29 = 0x000187b7U,
    GLU_NURBS_ERROR30 = 0x000187b8U,
    GLU_NURBS_ERROR31 = 0x000187b9U,
    GLU_NURBS_ERROR32 = 0x000187baU,
    GLU_NURBS_ERROR33 = 0x000187bbU,
    GLU_NURBS_ERROR34 = 0x000187bcU,
    GLU_NURBS_ERROR35 = 0x000187bdU,
    GLU_NURBS_ERROR36 = 0x000187beU,
    GLU_NURBS_ERROR37 = 0x000187bfU,
}

enum : uint
{
    GLU_CW       = 0x00018718U,
    GLU_CCW      = 0x00018719U,
    GLU_INTERIOR = 0x0001871aU,
}

enum uint GLU_EXTERIOR = 0x0001871bU;
enum uint GLU_UNKNOWN = 0x0001871cU;

enum : uint
{
    GLU_BEGIN  = 0x00018704U,
    GLU_VERTEX = 0x00018705U,
}

enum : uint
{
    GLU_END       = 0x00018706U,
    GLU_ERROR     = 0x00018707U,
    GLU_EDGE_FLAG = 0x00018708U,
}

// Callbacks

alias PFNGLARRAYELEMENTEXTPROC = void function(int i);
alias PFNGLDRAWARRAYSEXTPROC = void function(uint mode, int first, int count);
alias PFNGLVERTEXPOINTEREXTPROC = void function(int size, uint type, int stride, int count, const(void)* pointer);
alias PFNGLNORMALPOINTEREXTPROC = void function(uint type, int stride, int count, const(void)* pointer);
alias PFNGLCOLORPOINTEREXTPROC = void function(int size, uint type, int stride, int count, const(void)* pointer);
alias PFNGLINDEXPOINTEREXTPROC = void function(uint type, int stride, int count, const(void)* pointer);
alias PFNGLTEXCOORDPOINTEREXTPROC = void function(int size, uint type, int stride, int count, const(void)* pointer);
alias PFNGLEDGEFLAGPOINTEREXTPROC = void function(int stride, int count, const(ubyte)* pointer);
alias PFNGLGETPOINTERVEXTPROC = void function(uint pname, void** params);
alias PFNGLARRAYELEMENTARRAYEXTPROC = void function(uint mode, int count, const(void)* pi);
alias PFNGLDRAWRANGEELEMENTSWINPROC = void function(uint mode, uint start, uint end, int count, uint type, 
                                                    const(void)* indices);
alias PFNGLADDSWAPHINTRECTWINPROC = void function(int x, int y, int width, int height);
alias PFNGLCOLORTABLEEXTPROC = void function(uint target, uint internalFormat, int width, uint format, uint type, 
                                             const(void)* data);
alias PFNGLCOLORSUBTABLEEXTPROC = void function(uint target, int start, int count, uint format, uint type, 
                                                const(void)* data);
alias PFNGLGETCOLORTABLEEXTPROC = void function(uint target, uint format, uint type, void* data);
alias PFNGLGETCOLORTABLEPARAMETERIVEXTPROC = void function(uint target, uint pname, int* params);
alias PFNGLGETCOLORTABLEPARAMETERFVEXTPROC = void function(uint target, uint pname, float* params);
alias GLUquadricErrorProc = void function(uint param0);
alias GLUtessBeginProc = void function(uint param0);
alias GLUtessEdgeFlagProc = void function(ubyte param0);
alias GLUtessVertexProc = void function(void* param0);
alias GLUtessEndProc = void function();
alias GLUtessErrorProc = void function(uint param0);
alias GLUtessCombineProc = void function(double* param0, void** param1, float* param2, void** param3);
alias GLUtessBeginDataProc = void function(uint param0, void* param1);
alias GLUtessEdgeFlagDataProc = void function(ubyte param0, void* param1);
alias GLUtessVertexDataProc = void function(void* param0, void* param1);
alias GLUtessEndDataProc = void function(void* param0);
alias GLUtessErrorDataProc = void function(uint param0, void* param1);
alias GLUtessCombineDataProc = void function(double* param0, void** param1, float* param2, void** param3, 
                                             void* param4);
alias GLUnurbsErrorProc = void function(uint param0);

// Structs


@RAIIFree!wglDeleteContext
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HGLRC
{
    void* Value;
}

struct GLUnurbs
{
    ptrdiff_t Value;
}

struct GLUquadric
{
    ptrdiff_t Value;
}

struct GLUtesselator
{
    ptrdiff_t Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-pixelformatdescriptor
struct PIXELFORMATDESCRIPTOR
{
    ushort         nSize;
    ushort         nVersion;
    PFD_FLAGS      dwFlags;
    PFD_PIXEL_TYPE iPixelType;
    ubyte          cColorBits;
    ubyte          cRedBits;
    ubyte          cRedShift;
    ubyte          cGreenBits;
    ubyte          cGreenShift;
    ubyte          cBlueBits;
    ubyte          cBlueShift;
    ubyte          cAlphaBits;
    ubyte          cAlphaShift;
    ubyte          cAccumBits;
    ubyte          cAccumRedBits;
    ubyte          cAccumGreenBits;
    ubyte          cAccumBlueBits;
    ubyte          cAccumAlphaBits;
    ubyte          cDepthBits;
    ubyte          cStencilBits;
    ubyte          cAuxBuffers;
    ubyte          iLayerType;
    ubyte          bReserved;
    uint           dwLayerMask;
    uint           dwVisibleMask;
    uint           dwDamageMask;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrpixelformat
struct EMRPIXELFORMAT
{
    EMR emr;
    PIXELFORMATDESCRIPTOR pfd;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-pointfloat
struct POINTFLOAT
{
    float x;
    float y;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-glyphmetricsfloat
struct GLYPHMETRICSFLOAT
{
    float      gmfBlackBoxX;
    float      gmfBlackBoxY;
    POINTFLOAT gmfptGlyphOrigin;
    float      gmfCellIncX;
    float      gmfCellIncY;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-layerplanedescriptor
struct LAYERPLANEDESCRIPTOR
{
    ushort   nSize;
    ushort   nVersion;
    uint     dwFlags;
    ubyte    iPixelType;
    ubyte    cColorBits;
    ubyte    cRedBits;
    ubyte    cRedShift;
    ubyte    cGreenBits;
    ubyte    cGreenShift;
    ubyte    cBlueBits;
    ubyte    cBlueShift;
    ubyte    cAlphaBits;
    ubyte    cAlphaShift;
    ubyte    cAccumBits;
    ubyte    cAccumRedBits;
    ubyte    cAccumGreenBits;
    ubyte    cAccumBlueBits;
    ubyte    cAccumAlphaBits;
    ubyte    cDepthBits;
    ubyte    cStencilBits;
    ubyte    cAuxBuffers;
    ubyte    iLayerPlane;
    ubyte    bReserved;
    COLORREF crTransparent;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
int ChoosePixelFormat(HDC hdc, const(PIXELFORMATDESCRIPTOR)* ppfd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
int DescribePixelFormat(HDC hdc, int iPixelFormat, uint nBytes, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PIXELFORMATDESCRIPTOR* ppfd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
int GetPixelFormat(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
BOOL SetPixelFormat(HDC hdc, int format, const(PIXELFORMATDESCRIPTOR)* ppfd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
uint GetEnhMetaFilePixelFormat(HENHMETAFILE hemf, uint cbBuffer, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/PIXELFORMATDESCRIPTOR* ppfd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OPENGL32.dll")
BOOL wglCopyContext(HGLRC param0, HGLRC param1, uint param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OPENGL32.dll")
HGLRC wglCreateContext(HDC param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OPENGL32.dll")
HGLRC wglCreateLayerContext(HDC param0, int param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OPENGL32.dll")
BOOL wglDeleteContext(HGLRC param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OPENGL32.dll")
HGLRC wglGetCurrentContext();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OPENGL32.dll")
HDC wglGetCurrentDC();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OPENGL32.dll")
PROC wglGetProcAddress(const(PSTR) param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OPENGL32.dll")
BOOL wglMakeCurrent(HDC param0, HGLRC param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OPENGL32.dll")
BOOL wglShareLists(HGLRC param0, HGLRC param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OPENGL32.dll")
BOOL wglUseFontBitmapsA(HDC param0, uint param1, uint param2, uint param3);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OPENGL32.dll")
BOOL wglUseFontBitmapsW(HDC param0, uint param1, uint param2, uint param3);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
BOOL SwapBuffers(HDC param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OPENGL32.dll")
BOOL wglUseFontOutlinesA(HDC param0, uint param1, uint param2, uint param3, float param4, float param5, int param6, 
                         GLYPHMETRICSFLOAT* param7);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OPENGL32.dll")
BOOL wglUseFontOutlinesW(HDC param0, uint param1, uint param2, uint param3, float param4, float param5, int param6, 
                         GLYPHMETRICSFLOAT* param7);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OPENGL32.dll")
BOOL wglDescribeLayerPlane(HDC param0, int param1, int param2, uint param3, LAYERPLANEDESCRIPTOR* param4);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OPENGL32.dll")
int wglSetLayerPaletteEntries(HDC param0, int param1, int param2, int param3, const(COLORREF)* param4);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OPENGL32.dll")
int wglGetLayerPaletteEntries(HDC param0, int param1, int param2, int param3, COLORREF* param4);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OPENGL32.dll")
BOOL wglRealizeLayerPalette(HDC param0, int param1, BOOL param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OPENGL32.dll")
BOOL wglSwapLayerBuffers(HDC param0, uint param1);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glaccum
@DllImport("OPENGL32.dll")
void glAccum(uint op, float value);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glalphafunc
@DllImport("OPENGL32.dll")
void glAlphaFunc(uint func, float ref_);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glaretexturesresident
@DllImport("OPENGL32.dll")
ubyte glAreTexturesResident(int n, const(uint)* textures, ubyte* residences);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glarrayelement
@DllImport("OPENGL32.dll")
void glArrayElement(int i);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glbegin
@DllImport("OPENGL32.dll")
void glBegin(uint mode);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glbindtexture
@DllImport("OPENGL32.dll")
void glBindTexture(uint target, uint texture);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glbitmap
@DllImport("OPENGL32.dll")
void glBitmap(int width, int height, float xorig, float yorig, float xmove, float ymove, const(ubyte)* bitmap);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glblendfunc
@DllImport("OPENGL32.dll")
void glBlendFunc(uint sfactor, uint dfactor);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcalllist
@DllImport("OPENGL32.dll")
void glCallList(uint list);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcalllists
@DllImport("OPENGL32.dll")
void glCallLists(int n, uint type, const(void)* lists);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glclear
@DllImport("OPENGL32.dll")
void glClear(uint mask);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glclearaccum
@DllImport("OPENGL32.dll")
void glClearAccum(float red, float green, float blue, float alpha);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glclearcolor
@DllImport("OPENGL32.dll")
void glClearColor(float red, float green, float blue, float alpha);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcleardepth
@DllImport("OPENGL32.dll")
void glClearDepth(double depth);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glclearindex
@DllImport("OPENGL32.dll")
void glClearIndex(float c);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glclearstencil
@DllImport("OPENGL32.dll")
void glClearStencil(int s);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glclipplane
@DllImport("OPENGL32.dll")
void glClipPlane(uint plane, const(double)* equation);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor3b
@DllImport("OPENGL32.dll")
void glColor3b(byte red, byte green, byte blue);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor3bv
@DllImport("OPENGL32.dll")
void glColor3bv(const(byte)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor3d
@DllImport("OPENGL32.dll")
void glColor3d(double red, double green, double blue);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor3dv
@DllImport("OPENGL32.dll")
void glColor3dv(const(double)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor3f
@DllImport("OPENGL32.dll")
void glColor3f(float red, float green, float blue);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor3fv
@DllImport("OPENGL32.dll")
void glColor3fv(const(float)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor3i
@DllImport("OPENGL32.dll")
void glColor3i(int red, int green, int blue);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor3iv
@DllImport("OPENGL32.dll")
void glColor3iv(const(int)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor3s
@DllImport("OPENGL32.dll")
void glColor3s(short red, short green, short blue);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor3sv
@DllImport("OPENGL32.dll")
void glColor3sv(const(short)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor3ub
@DllImport("OPENGL32.dll")
void glColor3ub(ubyte red, ubyte green, ubyte blue);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor3ubv
@DllImport("OPENGL32.dll")
void glColor3ubv(const(ubyte)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor3ui
@DllImport("OPENGL32.dll")
void glColor3ui(uint red, uint green, uint blue);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor3uiv
@DllImport("OPENGL32.dll")
void glColor3uiv(const(uint)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor3us
@DllImport("OPENGL32.dll")
void glColor3us(ushort red, ushort green, ushort blue);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor3usv
@DllImport("OPENGL32.dll")
void glColor3usv(const(ushort)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor4b
@DllImport("OPENGL32.dll")
void glColor4b(byte red, byte green, byte blue, byte alpha);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor4bv
@DllImport("OPENGL32.dll")
void glColor4bv(const(byte)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor4d
@DllImport("OPENGL32.dll")
void glColor4d(double red, double green, double blue, double alpha);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor4dv
@DllImport("OPENGL32.dll")
void glColor4dv(const(double)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor4f
@DllImport("OPENGL32.dll")
void glColor4f(float red, float green, float blue, float alpha);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor4fv
@DllImport("OPENGL32.dll")
void glColor4fv(const(float)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor4i
@DllImport("OPENGL32.dll")
void glColor4i(int red, int green, int blue, int alpha);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor4iv
@DllImport("OPENGL32.dll")
void glColor4iv(const(int)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor4s
@DllImport("OPENGL32.dll")
void glColor4s(short red, short green, short blue, short alpha);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor4sv
@DllImport("OPENGL32.dll")
void glColor4sv(const(short)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor4ub
@DllImport("OPENGL32.dll")
void glColor4ub(ubyte red, ubyte green, ubyte blue, ubyte alpha);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor4ubv
@DllImport("OPENGL32.dll")
void glColor4ubv(const(ubyte)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor4ui
@DllImport("OPENGL32.dll")
void glColor4ui(uint red, uint green, uint blue, uint alpha);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor4uiv
@DllImport("OPENGL32.dll")
void glColor4uiv(const(uint)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor4us
@DllImport("OPENGL32.dll")
void glColor4us(ushort red, ushort green, ushort blue, ushort alpha);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolor4usv
@DllImport("OPENGL32.dll")
void glColor4usv(const(ushort)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolormask
@DllImport("OPENGL32.dll")
void glColorMask(ubyte red, ubyte green, ubyte blue, ubyte alpha);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolormaterial
@DllImport("OPENGL32.dll")
void glColorMaterial(uint face, uint mode);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcolorpointer
@DllImport("OPENGL32.dll")
void glColorPointer(int size, uint type, int stride, const(void)* pointer);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcopypixels
@DllImport("OPENGL32.dll")
void glCopyPixels(int x, int y, int width, int height, uint type);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcopyteximage1d
@DllImport("OPENGL32.dll")
void glCopyTexImage1D(uint target, int level, uint internalFormat, int x, int y, int width, int border);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcopyteximage2d
@DllImport("OPENGL32.dll")
void glCopyTexImage2D(uint target, int level, uint internalFormat, int x, int y, int width, int height, int border);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcopytexsubimage1d
@DllImport("OPENGL32.dll")
void glCopyTexSubImage1D(uint target, int level, int xoffset, int x, int y, int width);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcopytexsubimage2d
@DllImport("OPENGL32.dll")
void glCopyTexSubImage2D(uint target, int level, int xoffset, int yoffset, int x, int y, int width, int height);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glcullface
@DllImport("OPENGL32.dll")
void glCullFace(uint mode);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gldeletelists
@DllImport("OPENGL32.dll")
void glDeleteLists(uint list, int range);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gldeletetextures
@DllImport("OPENGL32.dll")
void glDeleteTextures(int n, const(uint)* textures);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gldepthfunc
@DllImport("OPENGL32.dll")
void glDepthFunc(uint func);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gldepthmask
@DllImport("OPENGL32.dll")
void glDepthMask(ubyte flag);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gldepthrange
@DllImport("OPENGL32.dll")
void glDepthRange(double zNear, double zFar);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gldisable
@DllImport("OPENGL32.dll")
void glDisable(uint cap);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gldisableclientstate
@DllImport("OPENGL32.dll")
void glDisableClientState(uint array);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gldrawarrays
@DllImport("OPENGL32.dll")
void glDrawArrays(uint mode, int first, int count);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gldrawbuffer
@DllImport("OPENGL32.dll")
void glDrawBuffer(uint mode);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gldrawelements
@DllImport("OPENGL32.dll")
void glDrawElements(uint mode, int count, uint type, const(void)* indices);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gldrawpixels
@DllImport("OPENGL32.dll")
void glDrawPixels(int width, int height, uint format, uint type, const(void)* pixels);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gledgeflag
@DllImport("OPENGL32.dll")
void glEdgeFlag(ubyte flag);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gledgeflagpointer
@DllImport("OPENGL32.dll")
void glEdgeFlagPointer(int stride, const(void)* pointer);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gledgeflagv
@DllImport("OPENGL32.dll")
void glEdgeFlagv(const(ubyte)* flag);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glenable
@DllImport("OPENGL32.dll")
void glEnable(uint cap);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glenableclientstate
@DllImport("OPENGL32.dll")
void glEnableClientState(uint array);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glend
@DllImport("OPENGL32.dll")
void glEnd();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glendlist
@DllImport("OPENGL32.dll")
void glEndList();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glevalcoord1d
@DllImport("OPENGL32.dll")
void glEvalCoord1d(double u);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glevalcoord1dv
@DllImport("OPENGL32.dll")
void glEvalCoord1dv(const(double)* u);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glevalcoord1f
@DllImport("OPENGL32.dll")
void glEvalCoord1f(float u);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glevalcoord1fv
@DllImport("OPENGL32.dll")
void glEvalCoord1fv(const(float)* u);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glevalcoord2d
@DllImport("OPENGL32.dll")
void glEvalCoord2d(double u, double v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glevalcoord2dv
@DllImport("OPENGL32.dll")
void glEvalCoord2dv(const(double)* u);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glevalcoord2f
@DllImport("OPENGL32.dll")
void glEvalCoord2f(float u, float v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glevalcoord2fv
@DllImport("OPENGL32.dll")
void glEvalCoord2fv(const(float)* u);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glevalmesh1
@DllImport("OPENGL32.dll")
void glEvalMesh1(uint mode, int i1, int i2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glevalmesh2
@DllImport("OPENGL32.dll")
void glEvalMesh2(uint mode, int i1, int i2, int j1, int j2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glevalpoint1
@DllImport("OPENGL32.dll")
void glEvalPoint1(int i);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glevalpoint2
@DllImport("OPENGL32.dll")
void glEvalPoint2(int i, int j);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glfeedbackbuffer
@DllImport("OPENGL32.dll")
void glFeedbackBuffer(int size, uint type, float* buffer);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glfinish
@DllImport("OPENGL32.dll")
void glFinish();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glflush
@DllImport("OPENGL32.dll")
void glFlush();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glfogf
@DllImport("OPENGL32.dll")
void glFogf(uint pname, float param1);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glfogfv
@DllImport("OPENGL32.dll")
void glFogfv(uint pname, const(float)* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glfogi
@DllImport("OPENGL32.dll")
void glFogi(uint pname, int param1);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glfogiv
@DllImport("OPENGL32.dll")
void glFogiv(uint pname, const(int)* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glfrontface
@DllImport("OPENGL32.dll")
void glFrontFace(uint mode);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glfrustum
@DllImport("OPENGL32.dll")
void glFrustum(double left, double right, double bottom, double top, double zNear, double zFar);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgenlists
@DllImport("OPENGL32.dll")
uint glGenLists(int range);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgentextures
@DllImport("OPENGL32.dll")
void glGenTextures(int n, uint* textures);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgetbooleanv
@DllImport("OPENGL32.dll")
void glGetBooleanv(uint pname, ubyte* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgetclipplane
@DllImport("OPENGL32.dll")
void glGetClipPlane(uint plane, double* equation);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgetdoublev
@DllImport("OPENGL32.dll")
void glGetDoublev(uint pname, double* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgeterror
@DllImport("OPENGL32.dll")
uint glGetError();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgetfloatv
@DllImport("OPENGL32.dll")
void glGetFloatv(uint pname, float* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgetintegerv
@DllImport("OPENGL32.dll")
void glGetIntegerv(uint pname, int* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgetlightfv
@DllImport("OPENGL32.dll")
void glGetLightfv(uint light, uint pname, float* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgetlightiv
@DllImport("OPENGL32.dll")
void glGetLightiv(uint light, uint pname, int* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgetmapdv
@DllImport("OPENGL32.dll")
void glGetMapdv(uint target, uint query, double* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgetmapfv
@DllImport("OPENGL32.dll")
void glGetMapfv(uint target, uint query, float* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgetmapiv
@DllImport("OPENGL32.dll")
void glGetMapiv(uint target, uint query, int* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgetmaterialfv
@DllImport("OPENGL32.dll")
void glGetMaterialfv(uint face, uint pname, float* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgetmaterialiv
@DllImport("OPENGL32.dll")
void glGetMaterialiv(uint face, uint pname, int* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgetpixelmapfv
@DllImport("OPENGL32.dll")
void glGetPixelMapfv(uint map, float* values);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgetpixelmapuiv
@DllImport("OPENGL32.dll")
void glGetPixelMapuiv(uint map, uint* values);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgetpixelmapusv
@DllImport("OPENGL32.dll")
void glGetPixelMapusv(uint map, ushort* values);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgetpointerv
@DllImport("OPENGL32.dll")
void glGetPointerv(uint pname, void** params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgetpolygonstipple
@DllImport("OPENGL32.dll")
void glGetPolygonStipple(ubyte* mask);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgetstring
@DllImport("OPENGL32.dll")
ubyte* glGetString(uint name);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgettexenvfv
@DllImport("OPENGL32.dll")
void glGetTexEnvfv(uint target, uint pname, float* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgettexenviv
@DllImport("OPENGL32.dll")
void glGetTexEnviv(uint target, uint pname, int* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgettexgendv
@DllImport("OPENGL32.dll")
void glGetTexGendv(uint coord, uint pname, double* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgettexgenfv
@DllImport("OPENGL32.dll")
void glGetTexGenfv(uint coord, uint pname, float* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgettexgeniv
@DllImport("OPENGL32.dll")
void glGetTexGeniv(uint coord, uint pname, int* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgetteximage
@DllImport("OPENGL32.dll")
void glGetTexImage(uint target, int level, uint format, uint type, void* pixels);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgettexlevelparameterfv
@DllImport("OPENGL32.dll")
void glGetTexLevelParameterfv(uint target, int level, uint pname, float* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgettexlevelparameteriv
@DllImport("OPENGL32.dll")
void glGetTexLevelParameteriv(uint target, int level, uint pname, int* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgettexparameterfv
@DllImport("OPENGL32.dll")
void glGetTexParameterfv(uint target, uint pname, float* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glgettexparameteriv
@DllImport("OPENGL32.dll")
void glGetTexParameteriv(uint target, uint pname, int* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glhint
@DllImport("OPENGL32.dll")
void glHint(uint target, uint mode);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glindexmask
@DllImport("OPENGL32.dll")
void glIndexMask(uint mask);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glindexpointer
@DllImport("OPENGL32.dll")
void glIndexPointer(uint type, int stride, const(void)* pointer);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glindexd
@DllImport("OPENGL32.dll")
void glIndexd(double c);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glindexdv
@DllImport("OPENGL32.dll")
void glIndexdv(const(double)* c);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glindexf
@DllImport("OPENGL32.dll")
void glIndexf(float c);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glindexfv
@DllImport("OPENGL32.dll")
void glIndexfv(const(float)* c);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glindexi
@DllImport("OPENGL32.dll")
void glIndexi(int c);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glindexiv
@DllImport("OPENGL32.dll")
void glIndexiv(const(int)* c);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glindexs
@DllImport("OPENGL32.dll")
void glIndexs(short c);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glindexsv
@DllImport("OPENGL32.dll")
void glIndexsv(const(short)* c);

@DllImport("OPENGL32.dll")
void glIndexub(ubyte c);

@DllImport("OPENGL32.dll")
void glIndexubv(const(ubyte)* c);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glinitnames
@DllImport("OPENGL32.dll")
void glInitNames();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glinterleavedarrays
@DllImport("OPENGL32.dll")
void glInterleavedArrays(uint format, int stride, const(void)* pointer);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glisenabled
@DllImport("OPENGL32.dll")
ubyte glIsEnabled(uint cap);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glislist
@DllImport("OPENGL32.dll")
ubyte glIsList(uint list);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glistexture
@DllImport("OPENGL32.dll")
ubyte glIsTexture(uint texture);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gllightmodelf
@DllImport("OPENGL32.dll")
void glLightModelf(uint pname, float param1);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gllightmodelfv
@DllImport("OPENGL32.dll")
void glLightModelfv(uint pname, const(float)* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gllightmodeli
@DllImport("OPENGL32.dll")
void glLightModeli(uint pname, int param1);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gllightmodeliv
@DllImport("OPENGL32.dll")
void glLightModeliv(uint pname, const(int)* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gllightf
@DllImport("OPENGL32.dll")
void glLightf(uint light, uint pname, float param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gllightfv
@DllImport("OPENGL32.dll")
void glLightfv(uint light, uint pname, const(float)* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gllighti
@DllImport("OPENGL32.dll")
void glLighti(uint light, uint pname, int param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gllightiv
@DllImport("OPENGL32.dll")
void glLightiv(uint light, uint pname, const(int)* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gllinestipple
@DllImport("OPENGL32.dll")
void glLineStipple(int factor, ushort pattern);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gllinewidth
@DllImport("OPENGL32.dll")
void glLineWidth(float width);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gllistbase
@DllImport("OPENGL32.dll")
void glListBase(uint base);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glloadidentity
@DllImport("OPENGL32.dll")
void glLoadIdentity();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glloadmatrixd
@DllImport("OPENGL32.dll")
void glLoadMatrixd(const(double)* m);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glloadmatrixf
@DllImport("OPENGL32.dll")
void glLoadMatrixf(const(float)* m);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glloadname
@DllImport("OPENGL32.dll")
void glLoadName(uint name);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gllogicop
@DllImport("OPENGL32.dll")
void glLogicOp(uint opcode);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glmap1d
@DllImport("OPENGL32.dll")
void glMap1d(uint target, double u1, double u2, int stride, int order, const(double)* points);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glmap1f
@DllImport("OPENGL32.dll")
void glMap1f(uint target, float u1, float u2, int stride, int order, const(float)* points);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glmap2d
@DllImport("OPENGL32.dll")
void glMap2d(uint target, double u1, double u2, int ustride, int uorder, double v1, double v2, int vstride, 
             int vorder, const(double)* points);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glmap2f
@DllImport("OPENGL32.dll")
void glMap2f(uint target, float u1, float u2, int ustride, int uorder, float v1, float v2, int vstride, int vorder, 
             const(float)* points);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glmapgrid1d
@DllImport("OPENGL32.dll")
void glMapGrid1d(int un, double u1, double u2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glmapgrid1f
@DllImport("OPENGL32.dll")
void glMapGrid1f(int un, float u1, float u2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glmapgrid2d
@DllImport("OPENGL32.dll")
void glMapGrid2d(int un, double u1, double u2, int vn, double v1, double v2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glmapgrid2f
@DllImport("OPENGL32.dll")
void glMapGrid2f(int un, float u1, float u2, int vn, float v1, float v2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glmaterialf
@DllImport("OPENGL32.dll")
void glMaterialf(uint face, uint pname, float param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glmaterialfv
@DllImport("OPENGL32.dll")
void glMaterialfv(uint face, uint pname, const(float)* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glmateriali
@DllImport("OPENGL32.dll")
void glMateriali(uint face, uint pname, int param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glmaterialiv
@DllImport("OPENGL32.dll")
void glMaterialiv(uint face, uint pname, const(int)* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glmatrixmode
@DllImport("OPENGL32.dll")
void glMatrixMode(uint mode);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glmultmatrixd
@DllImport("OPENGL32.dll")
void glMultMatrixd(const(double)* m);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glmultmatrixf
@DllImport("OPENGL32.dll")
void glMultMatrixf(const(float)* m);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glnewlist
@DllImport("OPENGL32.dll")
void glNewList(uint list, uint mode);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glnormal3b
@DllImport("OPENGL32.dll")
void glNormal3b(byte nx, byte ny, byte nz);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glnormal3bv
@DllImport("OPENGL32.dll")
void glNormal3bv(const(byte)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glnormal3d
@DllImport("OPENGL32.dll")
void glNormal3d(double nx, double ny, double nz);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glnormal3dv
@DllImport("OPENGL32.dll")
void glNormal3dv(const(double)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glnormal3f
@DllImport("OPENGL32.dll")
void glNormal3f(float nx, float ny, float nz);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glnormal3fv
@DllImport("OPENGL32.dll")
void glNormal3fv(const(float)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glnormal3i
@DllImport("OPENGL32.dll")
void glNormal3i(int nx, int ny, int nz);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glnormal3iv
@DllImport("OPENGL32.dll")
void glNormal3iv(const(int)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glnormal3s
@DllImport("OPENGL32.dll")
void glNormal3s(short nx, short ny, short nz);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glnormal3sv
@DllImport("OPENGL32.dll")
void glNormal3sv(const(short)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glnormalpointer
@DllImport("OPENGL32.dll")
void glNormalPointer(uint type, int stride, const(void)* pointer);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glortho
@DllImport("OPENGL32.dll")
void glOrtho(double left, double right, double bottom, double top, double zNear, double zFar);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glpassthrough
@DllImport("OPENGL32.dll")
void glPassThrough(float token);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glpixelmapfv
@DllImport("OPENGL32.dll")
void glPixelMapfv(uint map, int mapsize, const(float)* values);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glpixelmapuiv
@DllImport("OPENGL32.dll")
void glPixelMapuiv(uint map, int mapsize, const(uint)* values);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glpixelmapusv
@DllImport("OPENGL32.dll")
void glPixelMapusv(uint map, int mapsize, const(ushort)* values);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glpixelstoref
@DllImport("OPENGL32.dll")
void glPixelStoref(uint pname, float param1);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glpixelstorei
@DllImport("OPENGL32.dll")
void glPixelStorei(uint pname, int param1);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glpixeltransferf
@DllImport("OPENGL32.dll")
void glPixelTransferf(uint pname, float param1);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glpixeltransferi
@DllImport("OPENGL32.dll")
void glPixelTransferi(uint pname, int param1);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glpixelzoom
@DllImport("OPENGL32.dll")
void glPixelZoom(float xfactor, float yfactor);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glpointsize
@DllImport("OPENGL32.dll")
void glPointSize(float size);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glpolygonmode
@DllImport("OPENGL32.dll")
void glPolygonMode(uint face, uint mode);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glpolygonoffset
@DllImport("OPENGL32.dll")
void glPolygonOffset(float factor, float units);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glpolygonstipple
@DllImport("OPENGL32.dll")
void glPolygonStipple(const(ubyte)* mask);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glpopattrib
@DllImport("OPENGL32.dll")
void glPopAttrib();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glpopclientattrib
@DllImport("OPENGL32.dll")
void glPopClientAttrib();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glpopmatrix
@DllImport("OPENGL32.dll")
void glPopMatrix();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glpopname
@DllImport("OPENGL32.dll")
void glPopName();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glprioritizetextures
@DllImport("OPENGL32.dll")
void glPrioritizeTextures(int n, const(uint)* textures, const(float)* priorities);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glpushattrib
@DllImport("OPENGL32.dll")
void glPushAttrib(uint mask);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glpushclientattrib
@DllImport("OPENGL32.dll")
void glPushClientAttrib(uint mask);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glpushmatrix
@DllImport("OPENGL32.dll")
void glPushMatrix();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glpushname
@DllImport("OPENGL32.dll")
void glPushName(uint name);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrasterpos2d
@DllImport("OPENGL32.dll")
void glRasterPos2d(double x, double y);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrasterpos2dv
@DllImport("OPENGL32.dll")
void glRasterPos2dv(const(double)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrasterpos2f
@DllImport("OPENGL32.dll")
void glRasterPos2f(float x, float y);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrasterpos2fv
@DllImport("OPENGL32.dll")
void glRasterPos2fv(const(float)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrasterpos2i
@DllImport("OPENGL32.dll")
void glRasterPos2i(int x, int y);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrasterpos2iv
@DllImport("OPENGL32.dll")
void glRasterPos2iv(const(int)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrasterpos2s
@DllImport("OPENGL32.dll")
void glRasterPos2s(short x, short y);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrasterpos2sv
@DllImport("OPENGL32.dll")
void glRasterPos2sv(const(short)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrasterpos3d
@DllImport("OPENGL32.dll")
void glRasterPos3d(double x, double y, double z);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrasterpos3dv
@DllImport("OPENGL32.dll")
void glRasterPos3dv(const(double)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrasterpos3f
@DllImport("OPENGL32.dll")
void glRasterPos3f(float x, float y, float z);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrasterpos3fv
@DllImport("OPENGL32.dll")
void glRasterPos3fv(const(float)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrasterpos3i
@DllImport("OPENGL32.dll")
void glRasterPos3i(int x, int y, int z);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrasterpos3iv
@DllImport("OPENGL32.dll")
void glRasterPos3iv(const(int)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrasterpos3s
@DllImport("OPENGL32.dll")
void glRasterPos3s(short x, short y, short z);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrasterpos3sv
@DllImport("OPENGL32.dll")
void glRasterPos3sv(const(short)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrasterpos4d
@DllImport("OPENGL32.dll")
void glRasterPos4d(double x, double y, double z, double w);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrasterpos4dv
@DllImport("OPENGL32.dll")
void glRasterPos4dv(const(double)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrasterpos4f
@DllImport("OPENGL32.dll")
void glRasterPos4f(float x, float y, float z, float w);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrasterpos4fv
@DllImport("OPENGL32.dll")
void glRasterPos4fv(const(float)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrasterpos4i
@DllImport("OPENGL32.dll")
void glRasterPos4i(int x, int y, int z, int w);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrasterpos4iv
@DllImport("OPENGL32.dll")
void glRasterPos4iv(const(int)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrasterpos4s
@DllImport("OPENGL32.dll")
void glRasterPos4s(short x, short y, short z, short w);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrasterpos4sv
@DllImport("OPENGL32.dll")
void glRasterPos4sv(const(short)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glreadbuffer
@DllImport("OPENGL32.dll")
void glReadBuffer(uint mode);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glreadpixels
@DllImport("OPENGL32.dll")
void glReadPixels(int x, int y, int width, int height, uint format, uint type, void* pixels);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrectd
@DllImport("OPENGL32.dll")
void glRectd(double x1, double y1, double x2, double y2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrectdv
@DllImport("OPENGL32.dll")
void glRectdv(const(double)* v1, const(double)* v2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrectf
@DllImport("OPENGL32.dll")
void glRectf(float x1, float y1, float x2, float y2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrectfv
@DllImport("OPENGL32.dll")
void glRectfv(const(float)* v1, const(float)* v2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrecti
@DllImport("OPENGL32.dll")
void glRecti(int x1, int y1, int x2, int y2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrectiv
@DllImport("OPENGL32.dll")
void glRectiv(const(int)* v1, const(int)* v2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrects
@DllImport("OPENGL32.dll")
void glRects(short x1, short y1, short x2, short y2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrectsv
@DllImport("OPENGL32.dll")
void glRectsv(const(short)* v1, const(short)* v2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrendermode
@DllImport("OPENGL32.dll")
int glRenderMode(uint mode);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrotated
@DllImport("OPENGL32.dll")
void glRotated(double angle, double x, double y, double z);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glrotatef
@DllImport("OPENGL32.dll")
void glRotatef(float angle, float x, float y, float z);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glscaled
@DllImport("OPENGL32.dll")
void glScaled(double x, double y, double z);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glscalef
@DllImport("OPENGL32.dll")
void glScalef(float x, float y, float z);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glscissor
@DllImport("OPENGL32.dll")
void glScissor(int x, int y, int width, int height);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glselectbuffer
@DllImport("OPENGL32.dll")
void glSelectBuffer(int size, uint* buffer);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glshademodel
@DllImport("OPENGL32.dll")
void glShadeModel(uint mode);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glstencilfunc
@DllImport("OPENGL32.dll")
void glStencilFunc(uint func, int ref_, uint mask);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glstencilmask
@DllImport("OPENGL32.dll")
void glStencilMask(uint mask);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glstencilop
@DllImport("OPENGL32.dll")
void glStencilOp(uint fail, uint zfail, uint zpass);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord1d
@DllImport("OPENGL32.dll")
void glTexCoord1d(double s);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord1dv
@DllImport("OPENGL32.dll")
void glTexCoord1dv(const(double)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord1f
@DllImport("OPENGL32.dll")
void glTexCoord1f(float s);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord1fv
@DllImport("OPENGL32.dll")
void glTexCoord1fv(const(float)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord1i
@DllImport("OPENGL32.dll")
void glTexCoord1i(int s);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord1iv
@DllImport("OPENGL32.dll")
void glTexCoord1iv(const(int)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord1s
@DllImport("OPENGL32.dll")
void glTexCoord1s(short s);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord1sv
@DllImport("OPENGL32.dll")
void glTexCoord1sv(const(short)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord2d
@DllImport("OPENGL32.dll")
void glTexCoord2d(double s, double t);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord2dv
@DllImport("OPENGL32.dll")
void glTexCoord2dv(const(double)* v);

@DllImport("OPENGL32.dll")
void glTexCoord2f(float s, float t);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord2fv
@DllImport("OPENGL32.dll")
void glTexCoord2fv(const(float)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord2i
@DllImport("OPENGL32.dll")
void glTexCoord2i(int s, int t);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord2iv
@DllImport("OPENGL32.dll")
void glTexCoord2iv(const(int)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord2s
@DllImport("OPENGL32.dll")
void glTexCoord2s(short s, short t);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord2sv
@DllImport("OPENGL32.dll")
void glTexCoord2sv(const(short)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord3d
@DllImport("OPENGL32.dll")
void glTexCoord3d(double s, double t, double r);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord3dv
@DllImport("OPENGL32.dll")
void glTexCoord3dv(const(double)* v);

@DllImport("OPENGL32.dll")
void glTexCoord3f(float s, float t, float r);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord3fv
@DllImport("OPENGL32.dll")
void glTexCoord3fv(const(float)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord3i
@DllImport("OPENGL32.dll")
void glTexCoord3i(int s, int t, int r);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord3iv
@DllImport("OPENGL32.dll")
void glTexCoord3iv(const(int)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord3s
@DllImport("OPENGL32.dll")
void glTexCoord3s(short s, short t, short r);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord3sv
@DllImport("OPENGL32.dll")
void glTexCoord3sv(const(short)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord4d
@DllImport("OPENGL32.dll")
void glTexCoord4d(double s, double t, double r, double q);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord4dv
@DllImport("OPENGL32.dll")
void glTexCoord4dv(const(double)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord4f
@DllImport("OPENGL32.dll")
void glTexCoord4f(float s, float t, float r, float q);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord4fv
@DllImport("OPENGL32.dll")
void glTexCoord4fv(const(float)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord4i
@DllImport("OPENGL32.dll")
void glTexCoord4i(int s, int t, int r, int q);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord4iv
@DllImport("OPENGL32.dll")
void glTexCoord4iv(const(int)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord4s
@DllImport("OPENGL32.dll")
void glTexCoord4s(short s, short t, short r, short q);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoord4sv
@DllImport("OPENGL32.dll")
void glTexCoord4sv(const(short)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexcoordpointer
@DllImport("OPENGL32.dll")
void glTexCoordPointer(int size, uint type, int stride, const(void)* pointer);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexenvf
@DllImport("OPENGL32.dll")
void glTexEnvf(uint target, uint pname, float param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexenvfv
@DllImport("OPENGL32.dll")
void glTexEnvfv(uint target, uint pname, const(float)* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexenvi
@DllImport("OPENGL32.dll")
void glTexEnvi(uint target, uint pname, int param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexenviv
@DllImport("OPENGL32.dll")
void glTexEnviv(uint target, uint pname, const(int)* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexgend
@DllImport("OPENGL32.dll")
void glTexGend(uint coord, uint pname, double param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexgendv
@DllImport("OPENGL32.dll")
void glTexGendv(uint coord, uint pname, const(double)* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexgenf
@DllImport("OPENGL32.dll")
void glTexGenf(uint coord, uint pname, float param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexgenfv
@DllImport("OPENGL32.dll")
void glTexGenfv(uint coord, uint pname, const(float)* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexgeni
@DllImport("OPENGL32.dll")
void glTexGeni(uint coord, uint pname, int param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexgeniv
@DllImport("OPENGL32.dll")
void glTexGeniv(uint coord, uint pname, const(int)* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glteximage1d
@DllImport("OPENGL32.dll")
void glTexImage1D(uint target, int level, int internalformat, int width, int border, uint format, uint type, 
                  const(void)* pixels);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glteximage2d
@DllImport("OPENGL32.dll")
void glTexImage2D(uint target, int level, int internalformat, int width, int height, int border, uint format, 
                  uint type, const(void)* pixels);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexparameterf
@DllImport("OPENGL32.dll")
void glTexParameterf(uint target, uint pname, float param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexparameterfv
@DllImport("OPENGL32.dll")
void glTexParameterfv(uint target, uint pname, const(float)* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexparameteri
@DllImport("OPENGL32.dll")
void glTexParameteri(uint target, uint pname, int param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexparameteriv
@DllImport("OPENGL32.dll")
void glTexParameteriv(uint target, uint pname, const(int)* params);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexsubimage1d
@DllImport("OPENGL32.dll")
void glTexSubImage1D(uint target, int level, int xoffset, int width, uint format, uint type, const(void)* pixels);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltexsubimage2d
@DllImport("OPENGL32.dll")
void glTexSubImage2D(uint target, int level, int xoffset, int yoffset, int width, int height, uint format, 
                     uint type, const(void)* pixels);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltranslated
@DllImport("OPENGL32.dll")
void glTranslated(double x, double y, double z);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gltranslatef
@DllImport("OPENGL32.dll")
void glTranslatef(float x, float y, float z);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glvertex2d
@DllImport("OPENGL32.dll")
void glVertex2d(double x, double y);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glvertex2dv
@DllImport("OPENGL32.dll")
void glVertex2dv(const(double)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glvertex2f
@DllImport("OPENGL32.dll")
void glVertex2f(float x, float y);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glvertex2fv
@DllImport("OPENGL32.dll")
void glVertex2fv(const(float)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glvertex2i
@DllImport("OPENGL32.dll")
void glVertex2i(int x, int y);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glvertex2iv
@DllImport("OPENGL32.dll")
void glVertex2iv(const(int)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glvertex2s
@DllImport("OPENGL32.dll")
void glVertex2s(short x, short y);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glvertex2sv
@DllImport("OPENGL32.dll")
void glVertex2sv(const(short)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glvertex3d
@DllImport("OPENGL32.dll")
void glVertex3d(double x, double y, double z);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glvertex3dv
@DllImport("OPENGL32.dll")
void glVertex3dv(const(double)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glvertex3f
@DllImport("OPENGL32.dll")
void glVertex3f(float x, float y, float z);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glvertex3fv
@DllImport("OPENGL32.dll")
void glVertex3fv(const(float)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glvertex3i
@DllImport("OPENGL32.dll")
void glVertex3i(int x, int y, int z);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glvertex3iv
@DllImport("OPENGL32.dll")
void glVertex3iv(const(int)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glvertex3s
@DllImport("OPENGL32.dll")
void glVertex3s(short x, short y, short z);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glvertex3sv
@DllImport("OPENGL32.dll")
void glVertex3sv(const(short)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glvertex4d
@DllImport("OPENGL32.dll")
void glVertex4d(double x, double y, double z, double w);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glvertex4dv
@DllImport("OPENGL32.dll")
void glVertex4dv(const(double)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glvertex4f
@DllImport("OPENGL32.dll")
void glVertex4f(float x, float y, float z, float w);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glvertex4fv
@DllImport("OPENGL32.dll")
void glVertex4fv(const(float)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glvertex4i
@DllImport("OPENGL32.dll")
void glVertex4i(int x, int y, int z, int w);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glvertex4iv
@DllImport("OPENGL32.dll")
void glVertex4iv(const(int)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glvertex4s
@DllImport("OPENGL32.dll")
void glVertex4s(short x, short y, short z, short w);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glvertex4sv
@DllImport("OPENGL32.dll")
void glVertex4sv(const(short)* v);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glvertexpointer
@DllImport("OPENGL32.dll")
void glVertexPointer(int size, uint type, int stride, const(void)* pointer);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glviewport
@DllImport("OPENGL32.dll")
void glViewport(int x, int y, int width, int height);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gluerrorstring
@DllImport("GLU32.dll")
ubyte* gluErrorString(uint errCode);

@DllImport("GLU32.dll")
PWSTR gluErrorUnicodeStringEXT(uint errCode);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glugetstring
@DllImport("GLU32.dll")
ubyte* gluGetString(uint name);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gluortho2d
@DllImport("GLU32.dll")
void gluOrtho2D(double left, double right, double bottom, double top);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gluperspective
@DllImport("GLU32.dll")
void gluPerspective(double fovy, double aspect, double zNear, double zFar);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glupickmatrix
@DllImport("GLU32.dll")
void gluPickMatrix(double x, double y, double width, double height, int* viewport);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glulookat
@DllImport("GLU32.dll")
void gluLookAt(double eyex, double eyey, double eyez, double centerx, double centery, double centerz, double upx, 
               double upy, double upz);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gluproject
@DllImport("GLU32.dll")
int gluProject(double objx, double objy, double objz, const(double)* modelMatrix, const(double)* projMatrix, 
               const(int)* viewport, double* winx, double* winy, double* winz);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gluunproject
@DllImport("GLU32.dll")
int gluUnProject(double winx, double winy, double winz, const(double)* modelMatrix, const(double)* projMatrix, 
                 const(int)* viewport, double* objx, double* objy, double* objz);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gluscaleimage
@DllImport("GLU32.dll")
int gluScaleImage(uint format, int widthin, int heightin, uint typein, const(void)* datain, int widthout, 
                  int heightout, uint typeout, void* dataout);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glubuild1dmipmaps
@DllImport("GLU32.dll")
int gluBuild1DMipmaps(uint target, int components, int width, uint format, uint type, const(void)* data);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glubuild2dmipmaps
@DllImport("GLU32.dll")
int gluBuild2DMipmaps(uint target, int components, int width, int height, uint format, uint type, 
                      const(void)* data);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glunewquadric
@DllImport("GLU32.dll")
GLUquadric* gluNewQuadric();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gludeletequadric
@DllImport("GLU32.dll")
void gluDeleteQuadric(GLUquadric* state);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gluquadricnormals
@DllImport("GLU32.dll")
void gluQuadricNormals(GLUquadric* quadObject, uint normals);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gluquadrictexture
@DllImport("GLU32.dll")
void gluQuadricTexture(GLUquadric* quadObject, ubyte textureCoords);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gluquadricorientation
@DllImport("GLU32.dll")
void gluQuadricOrientation(GLUquadric* quadObject, uint orientation);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gluquadricdrawstyle
@DllImport("GLU32.dll")
void gluQuadricDrawStyle(GLUquadric* quadObject, uint drawStyle);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glucylinder
@DllImport("GLU32.dll")
void gluCylinder(GLUquadric* qobj, double baseRadius, double topRadius, double height, int slices, int stacks);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gludisk
@DllImport("GLU32.dll")
void gluDisk(GLUquadric* qobj, double innerRadius, double outerRadius, int slices, int loops);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glupartialdisk
@DllImport("GLU32.dll")
void gluPartialDisk(GLUquadric* qobj, double innerRadius, double outerRadius, int slices, int loops, 
                    double startAngle, double sweepAngle);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glusphere
@DllImport("GLU32.dll")
void gluSphere(GLUquadric* qobj, double radius, int slices, int stacks);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gluquadric
@DllImport("GLU32.dll")
void gluQuadricCallback(GLUquadric* qobj, uint which, ptrdiff_t fn);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glunewtess
@DllImport("GLU32.dll")
GLUtesselator* gluNewTess();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gludeletetess
@DllImport("GLU32.dll")
void gluDeleteTess(GLUtesselator* tess);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glutessbeginpolygon
@DllImport("GLU32.dll")
void gluTessBeginPolygon(GLUtesselator* tess, void* polygon_data);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glutessbegincontour
@DllImport("GLU32.dll")
void gluTessBeginContour(GLUtesselator* tess);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glutessvertex
@DllImport("GLU32.dll")
void gluTessVertex(GLUtesselator* tess, double* coords, void* data);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glutessendcontour
@DllImport("GLU32.dll")
void gluTessEndContour(GLUtesselator* tess);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glutessendpolygon
@DllImport("GLU32.dll")
void gluTessEndPolygon(GLUtesselator* tess);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glutessproperty
@DllImport("GLU32.dll")
void gluTessProperty(GLUtesselator* tess, uint which, double value);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glutessnormal
@DllImport("GLU32.dll")
void gluTessNormal(GLUtesselator* tess, double x, double y, double z);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glutess
@DllImport("GLU32.dll")
void gluTessCallback(GLUtesselator* tess, uint which, ptrdiff_t fn);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glugettessproperty
@DllImport("GLU32.dll")
void gluGetTessProperty(GLUtesselator* tess, uint which, double* value);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glunewnurbsrenderer
@DllImport("GLU32.dll")
GLUnurbs* gluNewNurbsRenderer();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gludeletenurbsrenderer
@DllImport("GLU32.dll")
void gluDeleteNurbsRenderer(GLUnurbs* nobj);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glubeginsurface
@DllImport("GLU32.dll")
void gluBeginSurface(GLUnurbs* nobj);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glubegincurve
@DllImport("GLU32.dll")
void gluBeginCurve(GLUnurbs* nobj);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gluendcurve
@DllImport("GLU32.dll")
void gluEndCurve(GLUnurbs* nobj);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gluendsurface
@DllImport("GLU32.dll")
void gluEndSurface(GLUnurbs* nobj);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glubegintrim
@DllImport("GLU32.dll")
void gluBeginTrim(GLUnurbs* nobj);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gluendtrim
@DllImport("GLU32.dll")
void gluEndTrim(GLUnurbs* nobj);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glupwlcurve
@DllImport("GLU32.dll")
void gluPwlCurve(GLUnurbs* nobj, int count, float* array, int stride, uint type);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glunurbscurve
@DllImport("GLU32.dll")
void gluNurbsCurve(GLUnurbs* nobj, int nknots, float* knot, int stride, float* ctlarray, int order, uint type);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glunurbssurface
@DllImport("GLU32.dll")
void gluNurbsSurface(GLUnurbs* nobj, int sknot_count, float* sknot, int tknot_count, float* tknot, int s_stride, 
                     int t_stride, float* ctlarray, int sorder, int torder, uint type);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gluloadsamplingmatrices
@DllImport("GLU32.dll")
void gluLoadSamplingMatrices(GLUnurbs* nobj, const(float)* modelMatrix, const(float)* projMatrix, 
                             const(int)* viewport);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glunurbsproperty
@DllImport("GLU32.dll")
void gluNurbsProperty(GLUnurbs* nobj, uint property, float value);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glugetnurbsproperty
@DllImport("GLU32.dll")
void gluGetNurbsProperty(GLUnurbs* nobj, uint property, float* value);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glunurbs
@DllImport("GLU32.dll")
void gluNurbsCallback(GLUnurbs* nobj, uint which, ptrdiff_t fn);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glubeginpolygon
@DllImport("GLU32.dll")
void gluBeginPolygon(GLUtesselator* tess);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/glunextcontour
@DllImport("GLU32.dll")
void gluNextContour(GLUtesselator* tess, uint type);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/OpenGL/gluendpolygon
@DllImport("GLU32.dll")
void gluEndPolygon(GLUtesselator* tess);


