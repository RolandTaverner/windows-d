// Written in the D programming language.

module windows.win32.graphics.direct2d.direct2d;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, HRESULT, HWND, POINT, PSTR, PWSTR,
                                                    RECT;
public import windows.win32.graphics.direct3d.direct3d : D3D_FEATURE_LEVEL;
public import windows.win32.graphics.directwrite : DWRITE_GLYPH_IMAGE_FORMATS, DWRITE_GLYPH_RUN,
                                                   DWRITE_GLYPH_RUN_DESCRIPTION,
                                                   DWRITE_MEASURING_MODE,
                                                   DWRITE_PAINT_FEATURE_LEVEL,
                                                   IDWriteFontFace, IDWriteRenderingParams,
                                                   IDWriteTextFormat, IDWriteTextLayout;
public import windows.win32.graphics.dxgi.common : DXGI_COLOR_SPACE_TYPE, DXGI_FORMAT;
public import windows.win32.graphics.dxgi.dxgi : IDXGIDevice, IDXGISurface;
public import windows.win32.graphics.gdi : HDC;
public import windows.win32.graphics.imaging.imaging : IWICBitmap, IWICBitmapSource, IWICColorContext,
                                                       IWICImagingFactory;
public import windows.win32.storage.xps.printing : IPrintDocumentPackageTarget;
public import windows.win32.system.com.com : IStream, IUnknown;

extern(Windows) @nogc nothrow:


// Enums


alias D2D1_INTERPOLATION_MODE_DEFINITION = int;
enum : int
{
    D2D1_INTERPOLATION_MODE_DEFINITION_NEAREST_NEIGHBOR    = 0x00000000,
    D2D1_INTERPOLATION_MODE_DEFINITION_LINEAR              = 0x00000001,
    D2D1_INTERPOLATION_MODE_DEFINITION_CUBIC               = 0x00000002,
    D2D1_INTERPOLATION_MODE_DEFINITION_MULTI_SAMPLE_LINEAR = 0x00000003,
    D2D1_INTERPOLATION_MODE_DEFINITION_ANISOTROPIC         = 0x00000004,
    D2D1_INTERPOLATION_MODE_DEFINITION_HIGH_QUALITY_CUBIC  = 0x00000005,
    D2D1_INTERPOLATION_MODE_DEFINITION_FANT                = 0x00000006,
    D2D1_INTERPOLATION_MODE_DEFINITION_MIPMAP_LINEAR       = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_gamma
alias D2D1_GAMMA = int;
enum : int
{
    D2D1_GAMMA_2_2 = 0x00000000,
    D2D1_GAMMA_1_0 = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_opacity_mask_content
alias D2D1_OPACITY_MASK_CONTENT = int;
enum : int
{
    D2D1_OPACITY_MASK_CONTENT_GRAPHICS            = 0x00000000,
    D2D1_OPACITY_MASK_CONTENT_TEXT_NATURAL        = 0x00000001,
    D2D1_OPACITY_MASK_CONTENT_TEXT_GDI_COMPATIBLE = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_extend_mode
alias D2D1_EXTEND_MODE = int;
enum : int
{
    D2D1_EXTEND_MODE_CLAMP  = 0x00000000,
    D2D1_EXTEND_MODE_WRAP   = 0x00000001,
    D2D1_EXTEND_MODE_MIRROR = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_antialias_mode
alias D2D1_ANTIALIAS_MODE = int;
enum : int
{
    D2D1_ANTIALIAS_MODE_PER_PRIMITIVE = 0x00000000,
    D2D1_ANTIALIAS_MODE_ALIASED       = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_text_antialias_mode
alias D2D1_TEXT_ANTIALIAS_MODE = int;
enum : int
{
    D2D1_TEXT_ANTIALIAS_MODE_DEFAULT   = 0x00000000,
    D2D1_TEXT_ANTIALIAS_MODE_CLEARTYPE = 0x00000001,
    D2D1_TEXT_ANTIALIAS_MODE_GRAYSCALE = 0x00000002,
    D2D1_TEXT_ANTIALIAS_MODE_ALIASED   = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_bitmap_interpolation_mode
alias D2D1_BITMAP_INTERPOLATION_MODE = int;
enum : int
{
    D2D1_BITMAP_INTERPOLATION_MODE_NEAREST_NEIGHBOR = 0x00000000,
    D2D1_BITMAP_INTERPOLATION_MODE_LINEAR           = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_draw_text_options
alias D2D1_DRAW_TEXT_OPTIONS = int;
enum : int
{
    D2D1_DRAW_TEXT_OPTIONS_NO_SNAP                       = 0x00000001,
    D2D1_DRAW_TEXT_OPTIONS_CLIP                          = 0x00000002,
    D2D1_DRAW_TEXT_OPTIONS_ENABLE_COLOR_FONT             = 0x00000004,
    D2D1_DRAW_TEXT_OPTIONS_DISABLE_COLOR_BITMAP_SNAPPING = 0x00000008,
    D2D1_DRAW_TEXT_OPTIONS_NONE                          = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_arc_size
alias D2D1_ARC_SIZE = int;
enum : int
{
    D2D1_ARC_SIZE_SMALL = 0x00000000,
    D2D1_ARC_SIZE_LARGE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_cap_style
alias D2D1_CAP_STYLE = int;
enum : int
{
    D2D1_CAP_STYLE_FLAT     = 0x00000000,
    D2D1_CAP_STYLE_SQUARE   = 0x00000001,
    D2D1_CAP_STYLE_ROUND    = 0x00000002,
    D2D1_CAP_STYLE_TRIANGLE = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_dash_style
alias D2D1_DASH_STYLE = int;
enum : int
{
    D2D1_DASH_STYLE_SOLID        = 0x00000000,
    D2D1_DASH_STYLE_DASH         = 0x00000001,
    D2D1_DASH_STYLE_DOT          = 0x00000002,
    D2D1_DASH_STYLE_DASH_DOT     = 0x00000003,
    D2D1_DASH_STYLE_DASH_DOT_DOT = 0x00000004,
    D2D1_DASH_STYLE_CUSTOM       = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_line_join
alias D2D1_LINE_JOIN = int;
enum : int
{
    D2D1_LINE_JOIN_MITER          = 0x00000000,
    D2D1_LINE_JOIN_BEVEL          = 0x00000001,
    D2D1_LINE_JOIN_ROUND          = 0x00000002,
    D2D1_LINE_JOIN_MITER_OR_BEVEL = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_combine_mode
alias D2D1_COMBINE_MODE = int;
enum : int
{
    D2D1_COMBINE_MODE_UNION     = 0x00000000,
    D2D1_COMBINE_MODE_INTERSECT = 0x00000001,
    D2D1_COMBINE_MODE_XOR       = 0x00000002,
    D2D1_COMBINE_MODE_EXCLUDE   = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_geometry_relation
alias D2D1_GEOMETRY_RELATION = int;
enum : int
{
    D2D1_GEOMETRY_RELATION_UNKNOWN      = 0x00000000,
    D2D1_GEOMETRY_RELATION_DISJOINT     = 0x00000001,
    D2D1_GEOMETRY_RELATION_IS_CONTAINED = 0x00000002,
    D2D1_GEOMETRY_RELATION_CONTAINS     = 0x00000003,
    D2D1_GEOMETRY_RELATION_OVERLAP      = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_geometry_simplification_option
alias D2D1_GEOMETRY_SIMPLIFICATION_OPTION = int;
enum : int
{
    D2D1_GEOMETRY_SIMPLIFICATION_OPTION_CUBICS_AND_LINES = 0x00000000,
    D2D1_GEOMETRY_SIMPLIFICATION_OPTION_LINES            = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_sweep_direction
alias D2D1_SWEEP_DIRECTION = int;
enum : int
{
    D2D1_SWEEP_DIRECTION_COUNTER_CLOCKWISE = 0x00000000,
    D2D1_SWEEP_DIRECTION_CLOCKWISE         = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_layer_options
alias D2D1_LAYER_OPTIONS = int;
enum : int
{
    D2D1_LAYER_OPTIONS_NONE                     = 0x00000000,
    D2D1_LAYER_OPTIONS_INITIALIZE_FOR_CLEARTYPE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_window_state
alias D2D1_WINDOW_STATE = int;
enum : int
{
    D2D1_WINDOW_STATE_NONE     = 0x00000000,
    D2D1_WINDOW_STATE_OCCLUDED = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_render_target_type
alias D2D1_RENDER_TARGET_TYPE = int;
enum : int
{
    D2D1_RENDER_TARGET_TYPE_DEFAULT  = 0x00000000,
    D2D1_RENDER_TARGET_TYPE_SOFTWARE = 0x00000001,
    D2D1_RENDER_TARGET_TYPE_HARDWARE = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_feature_level
alias D2D1_FEATURE_LEVEL = int;
enum : int
{
    D2D1_FEATURE_LEVEL_DEFAULT = 0x00000000,
    D2D1_FEATURE_LEVEL_9       = 0x00009100,
    D2D1_FEATURE_LEVEL_10      = 0x0000a000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_render_target_usage
alias D2D1_RENDER_TARGET_USAGE = int;
enum : int
{
    D2D1_RENDER_TARGET_USAGE_NONE                  = 0x00000000,
    D2D1_RENDER_TARGET_USAGE_FORCE_BITMAP_REMOTING = 0x00000001,
    D2D1_RENDER_TARGET_USAGE_GDI_COMPATIBLE        = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_present_options
alias D2D1_PRESENT_OPTIONS = int;
enum : int
{
    D2D1_PRESENT_OPTIONS_NONE            = 0x00000000,
    D2D1_PRESENT_OPTIONS_RETAIN_CONTENTS = 0x00000001,
    D2D1_PRESENT_OPTIONS_IMMEDIATELY     = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_compatible_render_target_options
alias D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS = int;
enum : int
{
    D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS_NONE           = 0x00000000,
    D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS_GDI_COMPATIBLE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_dc_initialize_mode
alias D2D1_DC_INITIALIZE_MODE = int;
enum : int
{
    D2D1_DC_INITIALIZE_MODE_COPY  = 0x00000000,
    D2D1_DC_INITIALIZE_MODE_CLEAR = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_debug_level
alias D2D1_DEBUG_LEVEL = int;
enum : int
{
    D2D1_DEBUG_LEVEL_NONE        = 0x00000000,
    D2D1_DEBUG_LEVEL_ERROR       = 0x00000001,
    D2D1_DEBUG_LEVEL_WARNING     = 0x00000002,
    D2D1_DEBUG_LEVEL_INFORMATION = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_factory_type
alias D2D1_FACTORY_TYPE = int;
enum : int
{
    D2D1_FACTORY_TYPE_SINGLE_THREADED = 0x00000000,
    D2D1_FACTORY_TYPE_MULTI_THREADED  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_channel_selector
alias D2D1_CHANNEL_SELECTOR = int;
enum : int
{
    D2D1_CHANNEL_SELECTOR_R = 0x00000000,
    D2D1_CHANNEL_SELECTOR_G = 0x00000001,
    D2D1_CHANNEL_SELECTOR_B = 0x00000002,
    D2D1_CHANNEL_SELECTOR_A = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_bitmapsource_orientation
alias D2D1_BITMAPSOURCE_ORIENTATION = int;
enum : int
{
    D2D1_BITMAPSOURCE_ORIENTATION_DEFAULT                             = 0x00000001,
    D2D1_BITMAPSOURCE_ORIENTATION_FLIP_HORIZONTAL                     = 0x00000002,
    D2D1_BITMAPSOURCE_ORIENTATION_ROTATE_CLOCKWISE180                 = 0x00000003,
    D2D1_BITMAPSOURCE_ORIENTATION_ROTATE_CLOCKWISE180_FLIP_HORIZONTAL = 0x00000004,
    D2D1_BITMAPSOURCE_ORIENTATION_ROTATE_CLOCKWISE270_FLIP_HORIZONTAL = 0x00000005,
    D2D1_BITMAPSOURCE_ORIENTATION_ROTATE_CLOCKWISE90                  = 0x00000006,
    D2D1_BITMAPSOURCE_ORIENTATION_ROTATE_CLOCKWISE90_FLIP_HORIZONTAL  = 0x00000007,
    D2D1_BITMAPSOURCE_ORIENTATION_ROTATE_CLOCKWISE270                 = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_gaussianblur_prop
alias D2D1_GAUSSIANBLUR_PROP = int;
enum : int
{
    D2D1_GAUSSIANBLUR_PROP_STANDARD_DEVIATION = 0x00000000,
    D2D1_GAUSSIANBLUR_PROP_OPTIMIZATION       = 0x00000001,
    D2D1_GAUSSIANBLUR_PROP_BORDER_MODE        = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_gaussianblur_optimization
alias D2D1_GAUSSIANBLUR_OPTIMIZATION = int;
enum : int
{
    D2D1_GAUSSIANBLUR_OPTIMIZATION_SPEED    = 0x00000000,
    D2D1_GAUSSIANBLUR_OPTIMIZATION_BALANCED = 0x00000001,
    D2D1_GAUSSIANBLUR_OPTIMIZATION_QUALITY  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_directionalblur_prop
alias D2D1_DIRECTIONALBLUR_PROP = int;
enum : int
{
    D2D1_DIRECTIONALBLUR_PROP_STANDARD_DEVIATION = 0x00000000,
    D2D1_DIRECTIONALBLUR_PROP_ANGLE              = 0x00000001,
    D2D1_DIRECTIONALBLUR_PROP_OPTIMIZATION       = 0x00000002,
    D2D1_DIRECTIONALBLUR_PROP_BORDER_MODE        = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_directionalblur_optimization
alias D2D1_DIRECTIONALBLUR_OPTIMIZATION = int;
enum : int
{
    D2D1_DIRECTIONALBLUR_OPTIMIZATION_SPEED    = 0x00000000,
    D2D1_DIRECTIONALBLUR_OPTIMIZATION_BALANCED = 0x00000001,
    D2D1_DIRECTIONALBLUR_OPTIMIZATION_QUALITY  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_shadow_prop
alias D2D1_SHADOW_PROP = int;
enum : int
{
    D2D1_SHADOW_PROP_BLUR_STANDARD_DEVIATION = 0x00000000,
    D2D1_SHADOW_PROP_COLOR                   = 0x00000001,
    D2D1_SHADOW_PROP_OPTIMIZATION            = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_shadow_optimization
alias D2D1_SHADOW_OPTIMIZATION = int;
enum : int
{
    D2D1_SHADOW_OPTIMIZATION_SPEED    = 0x00000000,
    D2D1_SHADOW_OPTIMIZATION_BALANCED = 0x00000001,
    D2D1_SHADOW_OPTIMIZATION_QUALITY  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_blend_prop
alias D2D1_BLEND_PROP = int;
enum : int
{
    D2D1_BLEND_PROP_MODE = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_saturation_prop
alias D2D1_SATURATION_PROP = int;
enum : int
{
    D2D1_SATURATION_PROP_SATURATION = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_huerotation_prop
alias D2D1_HUEROTATION_PROP = int;
enum : int
{
    D2D1_HUEROTATION_PROP_ANGLE = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_colormatrix_prop
alias D2D1_COLORMATRIX_PROP = int;
enum : int
{
    D2D1_COLORMATRIX_PROP_COLOR_MATRIX = 0x00000000,
    D2D1_COLORMATRIX_PROP_ALPHA_MODE   = 0x00000001,
    D2D1_COLORMATRIX_PROP_CLAMP_OUTPUT = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_bitmapsource_prop
alias D2D1_BITMAPSOURCE_PROP = int;
enum : int
{
    D2D1_BITMAPSOURCE_PROP_WIC_BITMAP_SOURCE     = 0x00000000,
    D2D1_BITMAPSOURCE_PROP_SCALE                 = 0x00000001,
    D2D1_BITMAPSOURCE_PROP_INTERPOLATION_MODE    = 0x00000002,
    D2D1_BITMAPSOURCE_PROP_ENABLE_DPI_CORRECTION = 0x00000003,
    D2D1_BITMAPSOURCE_PROP_ALPHA_MODE            = 0x00000004,
    D2D1_BITMAPSOURCE_PROP_ORIENTATION           = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_bitmapsource_interpolation_mode
alias D2D1_BITMAPSOURCE_INTERPOLATION_MODE = int;
enum : int
{
    D2D1_BITMAPSOURCE_INTERPOLATION_MODE_NEAREST_NEIGHBOR = 0x00000000,
    D2D1_BITMAPSOURCE_INTERPOLATION_MODE_LINEAR           = 0x00000001,
    D2D1_BITMAPSOURCE_INTERPOLATION_MODE_CUBIC            = 0x00000002,
    D2D1_BITMAPSOURCE_INTERPOLATION_MODE_FANT             = 0x00000006,
    D2D1_BITMAPSOURCE_INTERPOLATION_MODE_MIPMAP_LINEAR    = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_bitmapsource_alpha_mode
alias D2D1_BITMAPSOURCE_ALPHA_MODE = int;
enum : int
{
    D2D1_BITMAPSOURCE_ALPHA_MODE_PREMULTIPLIED = 0x00000001,
    D2D1_BITMAPSOURCE_ALPHA_MODE_STRAIGHT      = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_composite_prop
alias D2D1_COMPOSITE_PROP = int;
enum : int
{
    D2D1_COMPOSITE_PROP_MODE = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_3dtransform_prop
alias D2D1_3DTRANSFORM_PROP = int;
enum : int
{
    D2D1_3DTRANSFORM_PROP_INTERPOLATION_MODE = 0x00000000,
    D2D1_3DTRANSFORM_PROP_BORDER_MODE        = 0x00000001,
    D2D1_3DTRANSFORM_PROP_TRANSFORM_MATRIX   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_3dtransform_interpolation_mode
alias D2D1_3DTRANSFORM_INTERPOLATION_MODE = int;
enum : int
{
    D2D1_3DTRANSFORM_INTERPOLATION_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    D2D1_3DTRANSFORM_INTERPOLATION_MODE_LINEAR              = 0x00000001,
    D2D1_3DTRANSFORM_INTERPOLATION_MODE_CUBIC               = 0x00000002,
    D2D1_3DTRANSFORM_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    D2D1_3DTRANSFORM_INTERPOLATION_MODE_ANISOTROPIC         = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_3dperspectivetransform_prop
alias D2D1_3DPERSPECTIVETRANSFORM_PROP = int;
enum : int
{
    D2D1_3DPERSPECTIVETRANSFORM_PROP_INTERPOLATION_MODE = 0x00000000,
    D2D1_3DPERSPECTIVETRANSFORM_PROP_BORDER_MODE        = 0x00000001,
    D2D1_3DPERSPECTIVETRANSFORM_PROP_DEPTH              = 0x00000002,
    D2D1_3DPERSPECTIVETRANSFORM_PROP_PERSPECTIVE_ORIGIN = 0x00000003,
    D2D1_3DPERSPECTIVETRANSFORM_PROP_LOCAL_OFFSET       = 0x00000004,
    D2D1_3DPERSPECTIVETRANSFORM_PROP_GLOBAL_OFFSET      = 0x00000005,
    D2D1_3DPERSPECTIVETRANSFORM_PROP_ROTATION_ORIGIN    = 0x00000006,
    D2D1_3DPERSPECTIVETRANSFORM_PROP_ROTATION           = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_3dperspectivetransform_interpolation_mode
alias D2D1_3DPERSPECTIVETRANSFORM_INTERPOLATION_MODE = int;
enum : int
{
    D2D1_3DPERSPECTIVETRANSFORM_INTERPOLATION_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    D2D1_3DPERSPECTIVETRANSFORM_INTERPOLATION_MODE_LINEAR              = 0x00000001,
    D2D1_3DPERSPECTIVETRANSFORM_INTERPOLATION_MODE_CUBIC               = 0x00000002,
    D2D1_3DPERSPECTIVETRANSFORM_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    D2D1_3DPERSPECTIVETRANSFORM_INTERPOLATION_MODE_ANISOTROPIC         = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_2daffinetransform_prop
alias D2D1_2DAFFINETRANSFORM_PROP = int;
enum : int
{
    D2D1_2DAFFINETRANSFORM_PROP_INTERPOLATION_MODE = 0x00000000,
    D2D1_2DAFFINETRANSFORM_PROP_BORDER_MODE        = 0x00000001,
    D2D1_2DAFFINETRANSFORM_PROP_TRANSFORM_MATRIX   = 0x00000002,
    D2D1_2DAFFINETRANSFORM_PROP_SHARPNESS          = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_dpicompensation_prop
alias D2D1_DPICOMPENSATION_PROP = int;
enum : int
{
    D2D1_DPICOMPENSATION_PROP_INTERPOLATION_MODE = 0x00000000,
    D2D1_DPICOMPENSATION_PROP_BORDER_MODE        = 0x00000001,
    D2D1_DPICOMPENSATION_PROP_INPUT_DPI          = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_dpicompensation_interpolation_mode
alias D2D1_DPICOMPENSATION_INTERPOLATION_MODE = int;
enum : int
{
    D2D1_DPICOMPENSATION_INTERPOLATION_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    D2D1_DPICOMPENSATION_INTERPOLATION_MODE_LINEAR              = 0x00000001,
    D2D1_DPICOMPENSATION_INTERPOLATION_MODE_CUBIC               = 0x00000002,
    D2D1_DPICOMPENSATION_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    D2D1_DPICOMPENSATION_INTERPOLATION_MODE_ANISOTROPIC         = 0x00000004,
    D2D1_DPICOMPENSATION_INTERPOLATION_MODE_HIGH_QUALITY_CUBIC  = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_scale_prop
alias D2D1_SCALE_PROP = int;
enum : int
{
    D2D1_SCALE_PROP_SCALE              = 0x00000000,
    D2D1_SCALE_PROP_CENTER_POINT       = 0x00000001,
    D2D1_SCALE_PROP_INTERPOLATION_MODE = 0x00000002,
    D2D1_SCALE_PROP_BORDER_MODE        = 0x00000003,
    D2D1_SCALE_PROP_SHARPNESS          = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_scale_interpolation_mode
alias D2D1_SCALE_INTERPOLATION_MODE = int;
enum : int
{
    D2D1_SCALE_INTERPOLATION_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    D2D1_SCALE_INTERPOLATION_MODE_LINEAR              = 0x00000001,
    D2D1_SCALE_INTERPOLATION_MODE_CUBIC               = 0x00000002,
    D2D1_SCALE_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    D2D1_SCALE_INTERPOLATION_MODE_ANISOTROPIC         = 0x00000004,
    D2D1_SCALE_INTERPOLATION_MODE_HIGH_QUALITY_CUBIC  = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_turbulence_prop
alias D2D1_TURBULENCE_PROP = int;
enum : int
{
    D2D1_TURBULENCE_PROP_OFFSET         = 0x00000000,
    D2D1_TURBULENCE_PROP_SIZE           = 0x00000001,
    D2D1_TURBULENCE_PROP_BASE_FREQUENCY = 0x00000002,
    D2D1_TURBULENCE_PROP_NUM_OCTAVES    = 0x00000003,
    D2D1_TURBULENCE_PROP_SEED           = 0x00000004,
    D2D1_TURBULENCE_PROP_NOISE          = 0x00000005,
    D2D1_TURBULENCE_PROP_STITCHABLE     = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_displacementmap_prop
alias D2D1_DISPLACEMENTMAP_PROP = int;
enum : int
{
    D2D1_DISPLACEMENTMAP_PROP_SCALE            = 0x00000000,
    D2D1_DISPLACEMENTMAP_PROP_X_CHANNEL_SELECT = 0x00000001,
    D2D1_DISPLACEMENTMAP_PROP_Y_CHANNEL_SELECT = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_colormanagement_prop
alias D2D1_COLORMANAGEMENT_PROP = int;
enum : int
{
    D2D1_COLORMANAGEMENT_PROP_SOURCE_COLOR_CONTEXT         = 0x00000000,
    D2D1_COLORMANAGEMENT_PROP_SOURCE_RENDERING_INTENT      = 0x00000001,
    D2D1_COLORMANAGEMENT_PROP_DESTINATION_COLOR_CONTEXT    = 0x00000002,
    D2D1_COLORMANAGEMENT_PROP_DESTINATION_RENDERING_INTENT = 0x00000003,
    D2D1_COLORMANAGEMENT_PROP_ALPHA_MODE                   = 0x00000004,
    D2D1_COLORMANAGEMENT_PROP_QUALITY                      = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_colormanagement_alpha_mode
alias D2D1_COLORMANAGEMENT_ALPHA_MODE = int;
enum : int
{
    D2D1_COLORMANAGEMENT_ALPHA_MODE_PREMULTIPLIED = 0x00000001,
    D2D1_COLORMANAGEMENT_ALPHA_MODE_STRAIGHT      = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_colormanagement_quality
alias D2D1_COLORMANAGEMENT_QUALITY = int;
enum : int
{
    D2D1_COLORMANAGEMENT_QUALITY_PROOF  = 0x00000000,
    D2D1_COLORMANAGEMENT_QUALITY_NORMAL = 0x00000001,
    D2D1_COLORMANAGEMENT_QUALITY_BEST   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_colormanagement_rendering_intent
alias D2D1_COLORMANAGEMENT_RENDERING_INTENT = int;
enum : int
{
    D2D1_COLORMANAGEMENT_RENDERING_INTENT_PERCEPTUAL            = 0x00000000,
    D2D1_COLORMANAGEMENT_RENDERING_INTENT_RELATIVE_COLORIMETRIC = 0x00000001,
    D2D1_COLORMANAGEMENT_RENDERING_INTENT_SATURATION            = 0x00000002,
    D2D1_COLORMANAGEMENT_RENDERING_INTENT_ABSOLUTE_COLORIMETRIC = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_histogram_prop
alias D2D1_HISTOGRAM_PROP = int;
enum : int
{
    D2D1_HISTOGRAM_PROP_NUM_BINS         = 0x00000000,
    D2D1_HISTOGRAM_PROP_CHANNEL_SELECT   = 0x00000001,
    D2D1_HISTOGRAM_PROP_HISTOGRAM_OUTPUT = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_pointspecular_prop
alias D2D1_POINTSPECULAR_PROP = int;
enum : int
{
    D2D1_POINTSPECULAR_PROP_LIGHT_POSITION     = 0x00000000,
    D2D1_POINTSPECULAR_PROP_SPECULAR_EXPONENT  = 0x00000001,
    D2D1_POINTSPECULAR_PROP_SPECULAR_CONSTANT  = 0x00000002,
    D2D1_POINTSPECULAR_PROP_SURFACE_SCALE      = 0x00000003,
    D2D1_POINTSPECULAR_PROP_COLOR              = 0x00000004,
    D2D1_POINTSPECULAR_PROP_KERNEL_UNIT_LENGTH = 0x00000005,
    D2D1_POINTSPECULAR_PROP_SCALE_MODE         = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_pointspecular_scale_mode
alias D2D1_POINTSPECULAR_SCALE_MODE = int;
enum : int
{
    D2D1_POINTSPECULAR_SCALE_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    D2D1_POINTSPECULAR_SCALE_MODE_LINEAR              = 0x00000001,
    D2D1_POINTSPECULAR_SCALE_MODE_CUBIC               = 0x00000002,
    D2D1_POINTSPECULAR_SCALE_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    D2D1_POINTSPECULAR_SCALE_MODE_ANISOTROPIC         = 0x00000004,
    D2D1_POINTSPECULAR_SCALE_MODE_HIGH_QUALITY_CUBIC  = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_spotspecular_prop
alias D2D1_SPOTSPECULAR_PROP = int;
enum : int
{
    D2D1_SPOTSPECULAR_PROP_LIGHT_POSITION      = 0x00000000,
    D2D1_SPOTSPECULAR_PROP_POINTS_AT           = 0x00000001,
    D2D1_SPOTSPECULAR_PROP_FOCUS               = 0x00000002,
    D2D1_SPOTSPECULAR_PROP_LIMITING_CONE_ANGLE = 0x00000003,
    D2D1_SPOTSPECULAR_PROP_SPECULAR_EXPONENT   = 0x00000004,
    D2D1_SPOTSPECULAR_PROP_SPECULAR_CONSTANT   = 0x00000005,
    D2D1_SPOTSPECULAR_PROP_SURFACE_SCALE       = 0x00000006,
    D2D1_SPOTSPECULAR_PROP_COLOR               = 0x00000007,
    D2D1_SPOTSPECULAR_PROP_KERNEL_UNIT_LENGTH  = 0x00000008,
    D2D1_SPOTSPECULAR_PROP_SCALE_MODE          = 0x00000009,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_spotspecular_scale_mode
alias D2D1_SPOTSPECULAR_SCALE_MODE = int;
enum : int
{
    D2D1_SPOTSPECULAR_SCALE_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    D2D1_SPOTSPECULAR_SCALE_MODE_LINEAR              = 0x00000001,
    D2D1_SPOTSPECULAR_SCALE_MODE_CUBIC               = 0x00000002,
    D2D1_SPOTSPECULAR_SCALE_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    D2D1_SPOTSPECULAR_SCALE_MODE_ANISOTROPIC         = 0x00000004,
    D2D1_SPOTSPECULAR_SCALE_MODE_HIGH_QUALITY_CUBIC  = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_distantspecular_prop
alias D2D1_DISTANTSPECULAR_PROP = int;
enum : int
{
    D2D1_DISTANTSPECULAR_PROP_AZIMUTH            = 0x00000000,
    D2D1_DISTANTSPECULAR_PROP_ELEVATION          = 0x00000001,
    D2D1_DISTANTSPECULAR_PROP_SPECULAR_EXPONENT  = 0x00000002,
    D2D1_DISTANTSPECULAR_PROP_SPECULAR_CONSTANT  = 0x00000003,
    D2D1_DISTANTSPECULAR_PROP_SURFACE_SCALE      = 0x00000004,
    D2D1_DISTANTSPECULAR_PROP_COLOR              = 0x00000005,
    D2D1_DISTANTSPECULAR_PROP_KERNEL_UNIT_LENGTH = 0x00000006,
    D2D1_DISTANTSPECULAR_PROP_SCALE_MODE         = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_distantspecular_scale_mode
alias D2D1_DISTANTSPECULAR_SCALE_MODE = int;
enum : int
{
    D2D1_DISTANTSPECULAR_SCALE_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    D2D1_DISTANTSPECULAR_SCALE_MODE_LINEAR              = 0x00000001,
    D2D1_DISTANTSPECULAR_SCALE_MODE_CUBIC               = 0x00000002,
    D2D1_DISTANTSPECULAR_SCALE_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    D2D1_DISTANTSPECULAR_SCALE_MODE_ANISOTROPIC         = 0x00000004,
    D2D1_DISTANTSPECULAR_SCALE_MODE_HIGH_QUALITY_CUBIC  = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_pointdiffuse_prop
alias D2D1_POINTDIFFUSE_PROP = int;
enum : int
{
    D2D1_POINTDIFFUSE_PROP_LIGHT_POSITION     = 0x00000000,
    D2D1_POINTDIFFUSE_PROP_DIFFUSE_CONSTANT   = 0x00000001,
    D2D1_POINTDIFFUSE_PROP_SURFACE_SCALE      = 0x00000002,
    D2D1_POINTDIFFUSE_PROP_COLOR              = 0x00000003,
    D2D1_POINTDIFFUSE_PROP_KERNEL_UNIT_LENGTH = 0x00000004,
    D2D1_POINTDIFFUSE_PROP_SCALE_MODE         = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_pointdiffuse_scale_mode
alias D2D1_POINTDIFFUSE_SCALE_MODE = int;
enum : int
{
    D2D1_POINTDIFFUSE_SCALE_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    D2D1_POINTDIFFUSE_SCALE_MODE_LINEAR              = 0x00000001,
    D2D1_POINTDIFFUSE_SCALE_MODE_CUBIC               = 0x00000002,
    D2D1_POINTDIFFUSE_SCALE_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    D2D1_POINTDIFFUSE_SCALE_MODE_ANISOTROPIC         = 0x00000004,
    D2D1_POINTDIFFUSE_SCALE_MODE_HIGH_QUALITY_CUBIC  = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_spotdiffuse_prop
alias D2D1_SPOTDIFFUSE_PROP = int;
enum : int
{
    D2D1_SPOTDIFFUSE_PROP_LIGHT_POSITION      = 0x00000000,
    D2D1_SPOTDIFFUSE_PROP_POINTS_AT           = 0x00000001,
    D2D1_SPOTDIFFUSE_PROP_FOCUS               = 0x00000002,
    D2D1_SPOTDIFFUSE_PROP_LIMITING_CONE_ANGLE = 0x00000003,
    D2D1_SPOTDIFFUSE_PROP_DIFFUSE_CONSTANT    = 0x00000004,
    D2D1_SPOTDIFFUSE_PROP_SURFACE_SCALE       = 0x00000005,
    D2D1_SPOTDIFFUSE_PROP_COLOR               = 0x00000006,
    D2D1_SPOTDIFFUSE_PROP_KERNEL_UNIT_LENGTH  = 0x00000007,
    D2D1_SPOTDIFFUSE_PROP_SCALE_MODE          = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_spotdiffuse_scale_mode
alias D2D1_SPOTDIFFUSE_SCALE_MODE = int;
enum : int
{
    D2D1_SPOTDIFFUSE_SCALE_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    D2D1_SPOTDIFFUSE_SCALE_MODE_LINEAR              = 0x00000001,
    D2D1_SPOTDIFFUSE_SCALE_MODE_CUBIC               = 0x00000002,
    D2D1_SPOTDIFFUSE_SCALE_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    D2D1_SPOTDIFFUSE_SCALE_MODE_ANISOTROPIC         = 0x00000004,
    D2D1_SPOTDIFFUSE_SCALE_MODE_HIGH_QUALITY_CUBIC  = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_distantdiffuse_prop
alias D2D1_DISTANTDIFFUSE_PROP = int;
enum : int
{
    D2D1_DISTANTDIFFUSE_PROP_AZIMUTH            = 0x00000000,
    D2D1_DISTANTDIFFUSE_PROP_ELEVATION          = 0x00000001,
    D2D1_DISTANTDIFFUSE_PROP_DIFFUSE_CONSTANT   = 0x00000002,
    D2D1_DISTANTDIFFUSE_PROP_SURFACE_SCALE      = 0x00000003,
    D2D1_DISTANTDIFFUSE_PROP_COLOR              = 0x00000004,
    D2D1_DISTANTDIFFUSE_PROP_KERNEL_UNIT_LENGTH = 0x00000005,
    D2D1_DISTANTDIFFUSE_PROP_SCALE_MODE         = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_distantdiffuse_scale_mode
alias D2D1_DISTANTDIFFUSE_SCALE_MODE = int;
enum : int
{
    D2D1_DISTANTDIFFUSE_SCALE_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    D2D1_DISTANTDIFFUSE_SCALE_MODE_LINEAR              = 0x00000001,
    D2D1_DISTANTDIFFUSE_SCALE_MODE_CUBIC               = 0x00000002,
    D2D1_DISTANTDIFFUSE_SCALE_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    D2D1_DISTANTDIFFUSE_SCALE_MODE_ANISOTROPIC         = 0x00000004,
    D2D1_DISTANTDIFFUSE_SCALE_MODE_HIGH_QUALITY_CUBIC  = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_flood_prop
alias D2D1_FLOOD_PROP = int;
enum : int
{
    D2D1_FLOOD_PROP_COLOR = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_lineartransfer_prop
alias D2D1_LINEARTRANSFER_PROP = int;
enum : int
{
    D2D1_LINEARTRANSFER_PROP_RED_Y_INTERCEPT   = 0x00000000,
    D2D1_LINEARTRANSFER_PROP_RED_SLOPE         = 0x00000001,
    D2D1_LINEARTRANSFER_PROP_RED_DISABLE       = 0x00000002,
    D2D1_LINEARTRANSFER_PROP_GREEN_Y_INTERCEPT = 0x00000003,
    D2D1_LINEARTRANSFER_PROP_GREEN_SLOPE       = 0x00000004,
    D2D1_LINEARTRANSFER_PROP_GREEN_DISABLE     = 0x00000005,
    D2D1_LINEARTRANSFER_PROP_BLUE_Y_INTERCEPT  = 0x00000006,
    D2D1_LINEARTRANSFER_PROP_BLUE_SLOPE        = 0x00000007,
    D2D1_LINEARTRANSFER_PROP_BLUE_DISABLE      = 0x00000008,
    D2D1_LINEARTRANSFER_PROP_ALPHA_Y_INTERCEPT = 0x00000009,
    D2D1_LINEARTRANSFER_PROP_ALPHA_SLOPE       = 0x0000000a,
    D2D1_LINEARTRANSFER_PROP_ALPHA_DISABLE     = 0x0000000b,
    D2D1_LINEARTRANSFER_PROP_CLAMP_OUTPUT      = 0x0000000c,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_gammatransfer_prop
alias D2D1_GAMMATRANSFER_PROP = int;
enum : int
{
    D2D1_GAMMATRANSFER_PROP_RED_AMPLITUDE   = 0x00000000,
    D2D1_GAMMATRANSFER_PROP_RED_EXPONENT    = 0x00000001,
    D2D1_GAMMATRANSFER_PROP_RED_OFFSET      = 0x00000002,
    D2D1_GAMMATRANSFER_PROP_RED_DISABLE     = 0x00000003,
    D2D1_GAMMATRANSFER_PROP_GREEN_AMPLITUDE = 0x00000004,
    D2D1_GAMMATRANSFER_PROP_GREEN_EXPONENT  = 0x00000005,
    D2D1_GAMMATRANSFER_PROP_GREEN_OFFSET    = 0x00000006,
    D2D1_GAMMATRANSFER_PROP_GREEN_DISABLE   = 0x00000007,
    D2D1_GAMMATRANSFER_PROP_BLUE_AMPLITUDE  = 0x00000008,
    D2D1_GAMMATRANSFER_PROP_BLUE_EXPONENT   = 0x00000009,
    D2D1_GAMMATRANSFER_PROP_BLUE_OFFSET     = 0x0000000a,
    D2D1_GAMMATRANSFER_PROP_BLUE_DISABLE    = 0x0000000b,
    D2D1_GAMMATRANSFER_PROP_ALPHA_AMPLITUDE = 0x0000000c,
    D2D1_GAMMATRANSFER_PROP_ALPHA_EXPONENT  = 0x0000000d,
    D2D1_GAMMATRANSFER_PROP_ALPHA_OFFSET    = 0x0000000e,
    D2D1_GAMMATRANSFER_PROP_ALPHA_DISABLE   = 0x0000000f,
    D2D1_GAMMATRANSFER_PROP_CLAMP_OUTPUT    = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_tabletransfer_prop
alias D2D1_TABLETRANSFER_PROP = int;
enum : int
{
    D2D1_TABLETRANSFER_PROP_RED_TABLE     = 0x00000000,
    D2D1_TABLETRANSFER_PROP_RED_DISABLE   = 0x00000001,
    D2D1_TABLETRANSFER_PROP_GREEN_TABLE   = 0x00000002,
    D2D1_TABLETRANSFER_PROP_GREEN_DISABLE = 0x00000003,
    D2D1_TABLETRANSFER_PROP_BLUE_TABLE    = 0x00000004,
    D2D1_TABLETRANSFER_PROP_BLUE_DISABLE  = 0x00000005,
    D2D1_TABLETRANSFER_PROP_ALPHA_TABLE   = 0x00000006,
    D2D1_TABLETRANSFER_PROP_ALPHA_DISABLE = 0x00000007,
    D2D1_TABLETRANSFER_PROP_CLAMP_OUTPUT  = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_discretetransfer_prop
alias D2D1_DISCRETETRANSFER_PROP = int;
enum : int
{
    D2D1_DISCRETETRANSFER_PROP_RED_TABLE     = 0x00000000,
    D2D1_DISCRETETRANSFER_PROP_RED_DISABLE   = 0x00000001,
    D2D1_DISCRETETRANSFER_PROP_GREEN_TABLE   = 0x00000002,
    D2D1_DISCRETETRANSFER_PROP_GREEN_DISABLE = 0x00000003,
    D2D1_DISCRETETRANSFER_PROP_BLUE_TABLE    = 0x00000004,
    D2D1_DISCRETETRANSFER_PROP_BLUE_DISABLE  = 0x00000005,
    D2D1_DISCRETETRANSFER_PROP_ALPHA_TABLE   = 0x00000006,
    D2D1_DISCRETETRANSFER_PROP_ALPHA_DISABLE = 0x00000007,
    D2D1_DISCRETETRANSFER_PROP_CLAMP_OUTPUT  = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_convolvematrix_prop
alias D2D1_CONVOLVEMATRIX_PROP = int;
enum : int
{
    D2D1_CONVOLVEMATRIX_PROP_KERNEL_UNIT_LENGTH = 0x00000000,
    D2D1_CONVOLVEMATRIX_PROP_SCALE_MODE         = 0x00000001,
    D2D1_CONVOLVEMATRIX_PROP_KERNEL_SIZE_X      = 0x00000002,
    D2D1_CONVOLVEMATRIX_PROP_KERNEL_SIZE_Y      = 0x00000003,
    D2D1_CONVOLVEMATRIX_PROP_KERNEL_MATRIX      = 0x00000004,
    D2D1_CONVOLVEMATRIX_PROP_DIVISOR            = 0x00000005,
    D2D1_CONVOLVEMATRIX_PROP_BIAS               = 0x00000006,
    D2D1_CONVOLVEMATRIX_PROP_KERNEL_OFFSET      = 0x00000007,
    D2D1_CONVOLVEMATRIX_PROP_PRESERVE_ALPHA     = 0x00000008,
    D2D1_CONVOLVEMATRIX_PROP_BORDER_MODE        = 0x00000009,
    D2D1_CONVOLVEMATRIX_PROP_CLAMP_OUTPUT       = 0x0000000a,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_convolvematrix_scale_mode
alias D2D1_CONVOLVEMATRIX_SCALE_MODE = int;
enum : int
{
    D2D1_CONVOLVEMATRIX_SCALE_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    D2D1_CONVOLVEMATRIX_SCALE_MODE_LINEAR              = 0x00000001,
    D2D1_CONVOLVEMATRIX_SCALE_MODE_CUBIC               = 0x00000002,
    D2D1_CONVOLVEMATRIX_SCALE_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    D2D1_CONVOLVEMATRIX_SCALE_MODE_ANISOTROPIC         = 0x00000004,
    D2D1_CONVOLVEMATRIX_SCALE_MODE_HIGH_QUALITY_CUBIC  = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_brightness_prop
alias D2D1_BRIGHTNESS_PROP = int;
enum : int
{
    D2D1_BRIGHTNESS_PROP_WHITE_POINT = 0x00000000,
    D2D1_BRIGHTNESS_PROP_BLACK_POINT = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_arithmeticcomposite_prop
alias D2D1_ARITHMETICCOMPOSITE_PROP = int;
enum : int
{
    D2D1_ARITHMETICCOMPOSITE_PROP_COEFFICIENTS = 0x00000000,
    D2D1_ARITHMETICCOMPOSITE_PROP_CLAMP_OUTPUT = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_crop_prop
alias D2D1_CROP_PROP = int;
enum : int
{
    D2D1_CROP_PROP_RECT        = 0x00000000,
    D2D1_CROP_PROP_BORDER_MODE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_border_prop
alias D2D1_BORDER_PROP = int;
enum : int
{
    D2D1_BORDER_PROP_EDGE_MODE_X = 0x00000000,
    D2D1_BORDER_PROP_EDGE_MODE_Y = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_border_edge_mode
alias D2D1_BORDER_EDGE_MODE = int;
enum : int
{
    D2D1_BORDER_EDGE_MODE_CLAMP  = 0x00000000,
    D2D1_BORDER_EDGE_MODE_WRAP   = 0x00000001,
    D2D1_BORDER_EDGE_MODE_MIRROR = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_morphology_prop
alias D2D1_MORPHOLOGY_PROP = int;
enum : int
{
    D2D1_MORPHOLOGY_PROP_MODE   = 0x00000000,
    D2D1_MORPHOLOGY_PROP_WIDTH  = 0x00000001,
    D2D1_MORPHOLOGY_PROP_HEIGHT = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_morphology_mode
alias D2D1_MORPHOLOGY_MODE = int;
enum : int
{
    D2D1_MORPHOLOGY_MODE_ERODE  = 0x00000000,
    D2D1_MORPHOLOGY_MODE_DILATE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_tile_prop
alias D2D1_TILE_PROP = int;
enum : int
{
    D2D1_TILE_PROP_RECT = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_atlas_prop
alias D2D1_ATLAS_PROP = int;
enum : int
{
    D2D1_ATLAS_PROP_INPUT_RECT         = 0x00000000,
    D2D1_ATLAS_PROP_INPUT_PADDING_RECT = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_opacitymetadata_prop
alias D2D1_OPACITYMETADATA_PROP = int;
enum : int
{
    D2D1_OPACITYMETADATA_PROP_INPUT_OPAQUE_RECT = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/ne-d2d1_1-d2d1_property_type
alias D2D1_PROPERTY_TYPE = int;
enum : int
{
    D2D1_PROPERTY_TYPE_UNKNOWN       = 0x00000000,
    D2D1_PROPERTY_TYPE_STRING        = 0x00000001,
    D2D1_PROPERTY_TYPE_BOOL          = 0x00000002,
    D2D1_PROPERTY_TYPE_UINT32        = 0x00000003,
    D2D1_PROPERTY_TYPE_INT32         = 0x00000004,
    D2D1_PROPERTY_TYPE_FLOAT         = 0x00000005,
    D2D1_PROPERTY_TYPE_VECTOR2       = 0x00000006,
    D2D1_PROPERTY_TYPE_VECTOR3       = 0x00000007,
    D2D1_PROPERTY_TYPE_VECTOR4       = 0x00000008,
    D2D1_PROPERTY_TYPE_BLOB          = 0x00000009,
    D2D1_PROPERTY_TYPE_IUNKNOWN      = 0x0000000a,
    D2D1_PROPERTY_TYPE_ENUM          = 0x0000000b,
    D2D1_PROPERTY_TYPE_ARRAY         = 0x0000000c,
    D2D1_PROPERTY_TYPE_CLSID         = 0x0000000d,
    D2D1_PROPERTY_TYPE_MATRIX_3X2    = 0x0000000e,
    D2D1_PROPERTY_TYPE_MATRIX_4X3    = 0x0000000f,
    D2D1_PROPERTY_TYPE_MATRIX_4X4    = 0x00000010,
    D2D1_PROPERTY_TYPE_MATRIX_5X4    = 0x00000011,
    D2D1_PROPERTY_TYPE_COLOR_CONTEXT = 0x00000012,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/ne-d2d1_1-d2d1_property
alias D2D1_PROPERTY = int;
enum : int
{
    D2D1_PROPERTY_CLSID       = 0x80000000,
    D2D1_PROPERTY_DISPLAYNAME = 0x80000001,
    D2D1_PROPERTY_AUTHOR      = 0x80000002,
    D2D1_PROPERTY_CATEGORY    = 0x80000003,
    D2D1_PROPERTY_DESCRIPTION = 0x80000004,
    D2D1_PROPERTY_INPUTS      = 0x80000005,
    D2D1_PROPERTY_CACHED      = 0x80000006,
    D2D1_PROPERTY_PRECISION   = 0x80000007,
    D2D1_PROPERTY_MIN_INPUTS  = 0x80000008,
    D2D1_PROPERTY_MAX_INPUTS  = 0x80000009,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/ne-d2d1_1-d2d1_subproperty
alias D2D1_SUBPROPERTY = int;
enum : int
{
    D2D1_SUBPROPERTY_DISPLAYNAME = 0x80000000,
    D2D1_SUBPROPERTY_ISREADONLY  = 0x80000001,
    D2D1_SUBPROPERTY_MIN         = 0x80000002,
    D2D1_SUBPROPERTY_MAX         = 0x80000003,
    D2D1_SUBPROPERTY_DEFAULT     = 0x80000004,
    D2D1_SUBPROPERTY_FIELDS      = 0x80000005,
    D2D1_SUBPROPERTY_INDEX       = 0x80000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/ne-d2d1_1-d2d1_bitmap_options
alias D2D1_BITMAP_OPTIONS = int;
enum : int
{
    D2D1_BITMAP_OPTIONS_NONE           = 0x00000000,
    D2D1_BITMAP_OPTIONS_TARGET         = 0x00000001,
    D2D1_BITMAP_OPTIONS_CANNOT_DRAW    = 0x00000002,
    D2D1_BITMAP_OPTIONS_CPU_READ       = 0x00000004,
    D2D1_BITMAP_OPTIONS_GDI_COMPATIBLE = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/ne-d2d1_1-d2d1_buffer_precision
alias D2D1_BUFFER_PRECISION = int;
enum : int
{
    D2D1_BUFFER_PRECISION_UNKNOWN         = 0x00000000,
    D2D1_BUFFER_PRECISION_8BPC_UNORM      = 0x00000001,
    D2D1_BUFFER_PRECISION_8BPC_UNORM_SRGB = 0x00000002,
    D2D1_BUFFER_PRECISION_16BPC_UNORM     = 0x00000003,
    D2D1_BUFFER_PRECISION_16BPC_FLOAT     = 0x00000004,
    D2D1_BUFFER_PRECISION_32BPC_FLOAT     = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/ne-d2d1_1-d2d1_map_options
alias D2D1_MAP_OPTIONS = int;
enum : int
{
    D2D1_MAP_OPTIONS_NONE    = 0x00000000,
    D2D1_MAP_OPTIONS_READ    = 0x00000001,
    D2D1_MAP_OPTIONS_WRITE   = 0x00000002,
    D2D1_MAP_OPTIONS_DISCARD = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/ne-d2d1_1-d2d1_interpolation_mode
alias D2D1_INTERPOLATION_MODE = int;
enum : int
{
    D2D1_INTERPOLATION_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    D2D1_INTERPOLATION_MODE_LINEAR              = 0x00000001,
    D2D1_INTERPOLATION_MODE_CUBIC               = 0x00000002,
    D2D1_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    D2D1_INTERPOLATION_MODE_ANISOTROPIC         = 0x00000004,
    D2D1_INTERPOLATION_MODE_HIGH_QUALITY_CUBIC  = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/ne-d2d1_1-d2d1_unit_mode
alias D2D1_UNIT_MODE = int;
enum : int
{
    D2D1_UNIT_MODE_DIPS   = 0x00000000,
    D2D1_UNIT_MODE_PIXELS = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/ne-d2d1_1-d2d1_color_space
alias D2D1_COLOR_SPACE = int;
enum : int
{
    D2D1_COLOR_SPACE_CUSTOM = 0x00000000,
    D2D1_COLOR_SPACE_SRGB   = 0x00000001,
    D2D1_COLOR_SPACE_SCRGB  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/ne-d2d1_1-d2d1_device_context_options
alias D2D1_DEVICE_CONTEXT_OPTIONS = int;
enum : int
{
    D2D1_DEVICE_CONTEXT_OPTIONS_NONE                               = 0x00000000,
    D2D1_DEVICE_CONTEXT_OPTIONS_ENABLE_MULTITHREADED_OPTIMIZATIONS = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/ne-d2d1_1-d2d1_stroke_transform_type
alias D2D1_STROKE_TRANSFORM_TYPE = int;
enum : int
{
    D2D1_STROKE_TRANSFORM_TYPE_NORMAL   = 0x00000000,
    D2D1_STROKE_TRANSFORM_TYPE_FIXED    = 0x00000001,
    D2D1_STROKE_TRANSFORM_TYPE_HAIRLINE = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/ne-d2d1_1-d2d1_primitive_blend
alias D2D1_PRIMITIVE_BLEND = int;
enum : int
{
    D2D1_PRIMITIVE_BLEND_SOURCE_OVER = 0x00000000,
    D2D1_PRIMITIVE_BLEND_COPY        = 0x00000001,
    D2D1_PRIMITIVE_BLEND_MIN         = 0x00000002,
    D2D1_PRIMITIVE_BLEND_ADD         = 0x00000003,
    D2D1_PRIMITIVE_BLEND_MAX         = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/ne-d2d1_1-d2d1_threading_mode
alias D2D1_THREADING_MODE = int;
enum : int
{
    D2D1_THREADING_MODE_SINGLE_THREADED = 0x00000000,
    D2D1_THREADING_MODE_MULTI_THREADED  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/ne-d2d1_1-d2d1_color_interpolation_mode
alias D2D1_COLOR_INTERPOLATION_MODE = int;
enum : int
{
    D2D1_COLOR_INTERPOLATION_MODE_STRAIGHT      = 0x00000000,
    D2D1_COLOR_INTERPOLATION_MODE_PREMULTIPLIED = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/ne-d2d1_1-d2d1_layer_options1
alias D2D1_LAYER_OPTIONS1 = int;
enum : int
{
    D2D1_LAYER_OPTIONS1_NONE                       = 0x00000000,
    D2D1_LAYER_OPTIONS1_INITIALIZE_FROM_BACKGROUND = 0x00000001,
    D2D1_LAYER_OPTIONS1_IGNORE_ALPHA               = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/ne-d2d1_1-d2d1_print_font_subset_mode
alias D2D1_PRINT_FONT_SUBSET_MODE = int;
enum : int
{
    D2D1_PRINT_FONT_SUBSET_MODE_DEFAULT  = 0x00000000,
    D2D1_PRINT_FONT_SUBSET_MODE_EACHPAGE = 0x00000001,
    D2D1_PRINT_FONT_SUBSET_MODE_NONE     = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/ne-d2d1effectauthor-d2d1_change_type
alias D2D1_CHANGE_TYPE = int;
enum : int
{
    D2D1_CHANGE_TYPE_NONE       = 0x00000000,
    D2D1_CHANGE_TYPE_PROPERTIES = 0x00000001,
    D2D1_CHANGE_TYPE_CONTEXT    = 0x00000002,
    D2D1_CHANGE_TYPE_GRAPH      = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/ne-d2d1effectauthor-d2d1_pixel_options
alias D2D1_PIXEL_OPTIONS = int;
enum : int
{
    D2D1_PIXEL_OPTIONS_NONE             = 0x00000000,
    D2D1_PIXEL_OPTIONS_TRIVIAL_SAMPLING = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/ne-d2d1effectauthor-d2d1_vertex_options
alias D2D1_VERTEX_OPTIONS = int;
enum : int
{
    D2D1_VERTEX_OPTIONS_NONE              = 0x00000000,
    D2D1_VERTEX_OPTIONS_DO_NOT_CLEAR      = 0x00000001,
    D2D1_VERTEX_OPTIONS_USE_DEPTH_BUFFER  = 0x00000002,
    D2D1_VERTEX_OPTIONS_ASSUME_NO_OVERLAP = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/ne-d2d1effectauthor-d2d1_vertex_usage
alias D2D1_VERTEX_USAGE = int;
enum : int
{
    D2D1_VERTEX_USAGE_STATIC  = 0x00000000,
    D2D1_VERTEX_USAGE_DYNAMIC = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/ne-d2d1effectauthor-d2d1_blend_operation
alias D2D1_BLEND_OPERATION = int;
enum : int
{
    D2D1_BLEND_OPERATION_ADD          = 0x00000001,
    D2D1_BLEND_OPERATION_SUBTRACT     = 0x00000002,
    D2D1_BLEND_OPERATION_REV_SUBTRACT = 0x00000003,
    D2D1_BLEND_OPERATION_MIN          = 0x00000004,
    D2D1_BLEND_OPERATION_MAX          = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/ne-d2d1effectauthor-d2d1_blend
alias D2D1_BLEND = int;
enum : int
{
    D2D1_BLEND_ZERO             = 0x00000001,
    D2D1_BLEND_ONE              = 0x00000002,
    D2D1_BLEND_SRC_COLOR        = 0x00000003,
    D2D1_BLEND_INV_SRC_COLOR    = 0x00000004,
    D2D1_BLEND_SRC_ALPHA        = 0x00000005,
    D2D1_BLEND_INV_SRC_ALPHA    = 0x00000006,
    D2D1_BLEND_DEST_ALPHA       = 0x00000007,
    D2D1_BLEND_INV_DEST_ALPHA   = 0x00000008,
    D2D1_BLEND_DEST_COLOR       = 0x00000009,
    D2D1_BLEND_INV_DEST_COLOR   = 0x0000000a,
    D2D1_BLEND_SRC_ALPHA_SAT    = 0x0000000b,
    D2D1_BLEND_BLEND_FACTOR     = 0x0000000e,
    D2D1_BLEND_INV_BLEND_FACTOR = 0x0000000f,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/ne-d2d1effectauthor-d2d1_channel_depth
alias D2D1_CHANNEL_DEPTH = int;
enum : int
{
    D2D1_CHANNEL_DEPTH_DEFAULT = 0x00000000,
    D2D1_CHANNEL_DEPTH_1       = 0x00000001,
    D2D1_CHANNEL_DEPTH_4       = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/ne-d2d1effectauthor-d2d1_filter
alias D2D1_FILTER = int;
enum : int
{
    D2D1_FILTER_MIN_MAG_MIP_POINT               = 0x00000000,
    D2D1_FILTER_MIN_MAG_POINT_MIP_LINEAR        = 0x00000001,
    D2D1_FILTER_MIN_POINT_MAG_LINEAR_MIP_POINT  = 0x00000004,
    D2D1_FILTER_MIN_POINT_MAG_MIP_LINEAR        = 0x00000005,
    D2D1_FILTER_MIN_LINEAR_MAG_MIP_POINT        = 0x00000010,
    D2D1_FILTER_MIN_LINEAR_MAG_POINT_MIP_LINEAR = 0x00000011,
    D2D1_FILTER_MIN_MAG_LINEAR_MIP_POINT        = 0x00000014,
    D2D1_FILTER_MIN_MAG_MIP_LINEAR              = 0x00000015,
    D2D1_FILTER_ANISOTROPIC                     = 0x00000055,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/ne-d2d1effectauthor-d2d1_feature
alias D2D1_FEATURE = int;
enum : int
{
    D2D1_FEATURE_DOUBLES                  = 0x00000000,
    D2D1_FEATURE_D3D10_X_HARDWARE_OPTIONS = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects_1/ne-d2d1effects_1-d2d1_ycbcr_prop
alias D2D1_YCBCR_PROP = int;
enum : int
{
    D2D1_YCBCR_PROP_CHROMA_SUBSAMPLING = 0x00000000,
    D2D1_YCBCR_PROP_TRANSFORM_MATRIX   = 0x00000001,
    D2D1_YCBCR_PROP_INTERPOLATION_MODE = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects_1/ne-d2d1effects_1-d2d1_ycbcr_chroma_subsampling
alias D2D1_YCBCR_CHROMA_SUBSAMPLING = int;
enum : int
{
    D2D1_YCBCR_CHROMA_SUBSAMPLING_AUTO = 0x00000000,
    D2D1_YCBCR_CHROMA_SUBSAMPLING_420  = 0x00000001,
    D2D1_YCBCR_CHROMA_SUBSAMPLING_422  = 0x00000002,
    D2D1_YCBCR_CHROMA_SUBSAMPLING_444  = 0x00000003,
    D2D1_YCBCR_CHROMA_SUBSAMPLING_440  = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects_1/ne-d2d1effects_1-d2d1_ycbcr_interpolation_mode
alias D2D1_YCBCR_INTERPOLATION_MODE = int;
enum : int
{
    D2D1_YCBCR_INTERPOLATION_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    D2D1_YCBCR_INTERPOLATION_MODE_LINEAR              = 0x00000001,
    D2D1_YCBCR_INTERPOLATION_MODE_CUBIC               = 0x00000002,
    D2D1_YCBCR_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    D2D1_YCBCR_INTERPOLATION_MODE_ANISOTROPIC         = 0x00000004,
    D2D1_YCBCR_INTERPOLATION_MODE_HIGH_QUALITY_CUBIC  = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects_2/ne-d2d1effects_2-d2d1_contrast_prop
alias D2D1_CONTRAST_PROP = int;
enum : int
{
    D2D1_CONTRAST_PROP_CONTRAST    = 0x00000000,
    D2D1_CONTRAST_PROP_CLAMP_INPUT = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects_2/ne-d2d1effects_2-d2d1_rgbtohue_prop
alias D2D1_RGBTOHUE_PROP = int;
enum : int
{
    D2D1_RGBTOHUE_PROP_OUTPUT_COLOR_SPACE = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects_2/ne-d2d1effects_2-d2d1_rgbtohue_output_color_space
alias D2D1_RGBTOHUE_OUTPUT_COLOR_SPACE = int;
enum : int
{
    D2D1_RGBTOHUE_OUTPUT_COLOR_SPACE_HUE_SATURATION_VALUE     = 0x00000000,
    D2D1_RGBTOHUE_OUTPUT_COLOR_SPACE_HUE_SATURATION_LIGHTNESS = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects_2/ne-d2d1effects_2-d2d1_huetorgb_prop
alias D2D1_HUETORGB_PROP = int;
enum : int
{
    D2D1_HUETORGB_PROP_INPUT_COLOR_SPACE = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects_2/ne-d2d1effects_2-d2d1_huetorgb_input_color_space
alias D2D1_HUETORGB_INPUT_COLOR_SPACE = int;
enum : int
{
    D2D1_HUETORGB_INPUT_COLOR_SPACE_HUE_SATURATION_VALUE     = 0x00000000,
    D2D1_HUETORGB_INPUT_COLOR_SPACE_HUE_SATURATION_LIGHTNESS = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects_2/ne-d2d1effects_2-d2d1_chromakey_prop
alias D2D1_CHROMAKEY_PROP = int;
enum : int
{
    D2D1_CHROMAKEY_PROP_COLOR        = 0x00000000,
    D2D1_CHROMAKEY_PROP_TOLERANCE    = 0x00000001,
    D2D1_CHROMAKEY_PROP_INVERT_ALPHA = 0x00000002,
    D2D1_CHROMAKEY_PROP_FEATHER      = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects_2/ne-d2d1effects_2-d2d1_emboss_prop
alias D2D1_EMBOSS_PROP = int;
enum : int
{
    D2D1_EMBOSS_PROP_HEIGHT    = 0x00000000,
    D2D1_EMBOSS_PROP_DIRECTION = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects_2/ne-d2d1effects_2-d2d1_exposure_prop
alias D2D1_EXPOSURE_PROP = int;
enum : int
{
    D2D1_EXPOSURE_PROP_EXPOSURE_VALUE = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects_2/ne-d2d1effects_2-d2d1_posterize_prop
alias D2D1_POSTERIZE_PROP = int;
enum : int
{
    D2D1_POSTERIZE_PROP_RED_VALUE_COUNT   = 0x00000000,
    D2D1_POSTERIZE_PROP_GREEN_VALUE_COUNT = 0x00000001,
    D2D1_POSTERIZE_PROP_BLUE_VALUE_COUNT  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects_2/ne-d2d1effects_2-d2d1_sepia_prop
alias D2D1_SEPIA_PROP = int;
enum : int
{
    D2D1_SEPIA_PROP_INTENSITY  = 0x00000000,
    D2D1_SEPIA_PROP_ALPHA_MODE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects_2/ne-d2d1effects_2-d2d1_sharpen_prop
alias D2D1_SHARPEN_PROP = int;
enum : int
{
    D2D1_SHARPEN_PROP_SHARPNESS = 0x00000000,
    D2D1_SHARPEN_PROP_THRESHOLD = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects_2/ne-d2d1effects_2-d2d1_straighten_prop
alias D2D1_STRAIGHTEN_PROP = int;
enum : int
{
    D2D1_STRAIGHTEN_PROP_ANGLE         = 0x00000000,
    D2D1_STRAIGHTEN_PROP_MAINTAIN_SIZE = 0x00000001,
    D2D1_STRAIGHTEN_PROP_SCALE_MODE    = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects_2/ne-d2d1effects_2-d2d1_straighten_scale_mode
alias D2D1_STRAIGHTEN_SCALE_MODE = int;
enum : int
{
    D2D1_STRAIGHTEN_SCALE_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    D2D1_STRAIGHTEN_SCALE_MODE_LINEAR              = 0x00000001,
    D2D1_STRAIGHTEN_SCALE_MODE_CUBIC               = 0x00000002,
    D2D1_STRAIGHTEN_SCALE_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    D2D1_STRAIGHTEN_SCALE_MODE_ANISOTROPIC         = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects_2/ne-d2d1effects_2-d2d1_temperatureandtint_prop
alias D2D1_TEMPERATUREANDTINT_PROP = int;
enum : int
{
    D2D1_TEMPERATUREANDTINT_PROP_TEMPERATURE = 0x00000000,
    D2D1_TEMPERATUREANDTINT_PROP_TINT        = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects_2/ne-d2d1effects_2-d2d1_vignette_prop
alias D2D1_VIGNETTE_PROP = int;
enum : int
{
    D2D1_VIGNETTE_PROP_COLOR           = 0x00000000,
    D2D1_VIGNETTE_PROP_TRANSITION_SIZE = 0x00000001,
    D2D1_VIGNETTE_PROP_STRENGTH        = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects_2/ne-d2d1effects_2-d2d1_edgedetection_prop
alias D2D1_EDGEDETECTION_PROP = int;
enum : int
{
    D2D1_EDGEDETECTION_PROP_STRENGTH      = 0x00000000,
    D2D1_EDGEDETECTION_PROP_BLUR_RADIUS   = 0x00000001,
    D2D1_EDGEDETECTION_PROP_MODE          = 0x00000002,
    D2D1_EDGEDETECTION_PROP_OVERLAY_EDGES = 0x00000003,
    D2D1_EDGEDETECTION_PROP_ALPHA_MODE    = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects_2/ne-d2d1effects_2-d2d1_edgedetection_mode
alias D2D1_EDGEDETECTION_MODE = int;
enum : int
{
    D2D1_EDGEDETECTION_MODE_SOBEL   = 0x00000000,
    D2D1_EDGEDETECTION_MODE_PREWITT = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects_2/ne-d2d1effects_2-d2d1_highlightsandshadows_prop
alias D2D1_HIGHLIGHTSANDSHADOWS_PROP = int;
enum : int
{
    D2D1_HIGHLIGHTSANDSHADOWS_PROP_HIGHLIGHTS       = 0x00000000,
    D2D1_HIGHLIGHTSANDSHADOWS_PROP_SHADOWS          = 0x00000001,
    D2D1_HIGHLIGHTSANDSHADOWS_PROP_CLARITY          = 0x00000002,
    D2D1_HIGHLIGHTSANDSHADOWS_PROP_INPUT_GAMMA      = 0x00000003,
    D2D1_HIGHLIGHTSANDSHADOWS_PROP_MASK_BLUR_RADIUS = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects_2/ne-d2d1effects_2-d2d1_highlightsandshadows_input_gamma
alias D2D1_HIGHLIGHTSANDSHADOWS_INPUT_GAMMA = int;
enum : int
{
    D2D1_HIGHLIGHTSANDSHADOWS_INPUT_GAMMA_LINEAR = 0x00000000,
    D2D1_HIGHLIGHTSANDSHADOWS_INPUT_GAMMA_SRGB   = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects_2/ne-d2d1effects_2-d2d1_lookuptable3d_prop
alias D2D1_LOOKUPTABLE3D_PROP = int;
enum : int
{
    D2D1_LOOKUPTABLE3D_PROP_LUT        = 0x00000000,
    D2D1_LOOKUPTABLE3D_PROP_ALPHA_MODE = 0x00000001,
}

alias D2D1_OPACITY_PROP = int;
enum : int
{
    D2D1_OPACITY_PROP_OPACITY = 0x00000000,
}

alias D2D1_CROSSFADE_PROP = int;
enum : int
{
    D2D1_CROSSFADE_PROP_WEIGHT = 0x00000000,
}

alias D2D1_TINT_PROP = int;
enum : int
{
    D2D1_TINT_PROP_COLOR        = 0x00000000,
    D2D1_TINT_PROP_CLAMP_OUTPUT = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects_2/ne-d2d1effects_2-d2d1_whiteleveladjustment_prop
alias D2D1_WHITELEVELADJUSTMENT_PROP = int;
enum : int
{
    D2D1_WHITELEVELADJUSTMENT_PROP_INPUT_WHITE_LEVEL  = 0x00000000,
    D2D1_WHITELEVELADJUSTMENT_PROP_OUTPUT_WHITE_LEVEL = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects_2/ne-d2d1effects_2-d2d1_hdrtonemap_prop
alias D2D1_HDRTONEMAP_PROP = int;
enum : int
{
    D2D1_HDRTONEMAP_PROP_INPUT_MAX_LUMINANCE  = 0x00000000,
    D2D1_HDRTONEMAP_PROP_OUTPUT_MAX_LUMINANCE = 0x00000001,
    D2D1_HDRTONEMAP_PROP_DISPLAY_MODE         = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effects_2/ne-d2d1effects_2-d2d1_hdrtonemap_display_mode
alias D2D1_HDRTONEMAP_DISPLAY_MODE = int;
enum : int
{
    D2D1_HDRTONEMAP_DISPLAY_MODE_SDR = 0x00000000,
    D2D1_HDRTONEMAP_DISPLAY_MODE_HDR = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_2/ne-d2d1_2-d2d1_rendering_priority
alias D2D1_RENDERING_PRIORITY = int;
enum : int
{
    D2D1_RENDERING_PRIORITY_NORMAL = 0x00000000,
    D2D1_RENDERING_PRIORITY_LOW    = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/ne-d2d1svg-d2d1_svg_paint_type
alias D2D1_SVG_PAINT_TYPE = int;
enum : int
{
    D2D1_SVG_PAINT_TYPE_NONE              = 0x00000000,
    D2D1_SVG_PAINT_TYPE_COLOR             = 0x00000001,
    D2D1_SVG_PAINT_TYPE_CURRENT_COLOR     = 0x00000002,
    D2D1_SVG_PAINT_TYPE_URI               = 0x00000003,
    D2D1_SVG_PAINT_TYPE_URI_NONE          = 0x00000004,
    D2D1_SVG_PAINT_TYPE_URI_COLOR         = 0x00000005,
    D2D1_SVG_PAINT_TYPE_URI_CURRENT_COLOR = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/ne-d2d1svg-d2d1_svg_length_units
alias D2D1_SVG_LENGTH_UNITS = int;
enum : int
{
    D2D1_SVG_LENGTH_UNITS_NUMBER     = 0x00000000,
    D2D1_SVG_LENGTH_UNITS_PERCENTAGE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/ne-d2d1svg-d2d1_svg_display
alias D2D1_SVG_DISPLAY = int;
enum : int
{
    D2D1_SVG_DISPLAY_INLINE = 0x00000000,
    D2D1_SVG_DISPLAY_NONE   = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/ne-d2d1svg-d2d1_svg_visibility
alias D2D1_SVG_VISIBILITY = int;
enum : int
{
    D2D1_SVG_VISIBILITY_VISIBLE = 0x00000000,
    D2D1_SVG_VISIBILITY_HIDDEN  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/ne-d2d1svg-d2d1_svg_overflow
alias D2D1_SVG_OVERFLOW = int;
enum : int
{
    D2D1_SVG_OVERFLOW_VISIBLE = 0x00000000,
    D2D1_SVG_OVERFLOW_HIDDEN  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/ne-d2d1svg-d2d1_svg_line_cap
alias D2D1_SVG_LINE_CAP = int;
enum : int
{
    D2D1_SVG_LINE_CAP_BUTT   = 0x00000000,
    D2D1_SVG_LINE_CAP_SQUARE = 0x00000001,
    D2D1_SVG_LINE_CAP_ROUND  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/ne-d2d1svg-d2d1_svg_line_join
alias D2D1_SVG_LINE_JOIN = int;
enum : int
{
    D2D1_SVG_LINE_JOIN_BEVEL = 0x00000001,
    D2D1_SVG_LINE_JOIN_MITER = 0x00000003,
    D2D1_SVG_LINE_JOIN_ROUND = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/ne-d2d1svg-d2d1_svg_aspect_align
alias D2D1_SVG_ASPECT_ALIGN = int;
enum : int
{
    D2D1_SVG_ASPECT_ALIGN_NONE        = 0x00000000,
    D2D1_SVG_ASPECT_ALIGN_X_MIN_Y_MIN = 0x00000001,
    D2D1_SVG_ASPECT_ALIGN_X_MID_Y_MIN = 0x00000002,
    D2D1_SVG_ASPECT_ALIGN_X_MAX_Y_MIN = 0x00000003,
    D2D1_SVG_ASPECT_ALIGN_X_MIN_Y_MID = 0x00000004,
    D2D1_SVG_ASPECT_ALIGN_X_MID_Y_MID = 0x00000005,
    D2D1_SVG_ASPECT_ALIGN_X_MAX_Y_MID = 0x00000006,
    D2D1_SVG_ASPECT_ALIGN_X_MIN_Y_MAX = 0x00000007,
    D2D1_SVG_ASPECT_ALIGN_X_MID_Y_MAX = 0x00000008,
    D2D1_SVG_ASPECT_ALIGN_X_MAX_Y_MAX = 0x00000009,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/ne-d2d1svg-d2d1_svg_aspect_scaling
alias D2D1_SVG_ASPECT_SCALING = int;
enum : int
{
    D2D1_SVG_ASPECT_SCALING_MEET  = 0x00000000,
    D2D1_SVG_ASPECT_SCALING_SLICE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/ne-d2d1svg-d2d1_svg_path_command
alias D2D1_SVG_PATH_COMMAND = int;
enum : int
{
    D2D1_SVG_PATH_COMMAND_CLOSE_PATH                = 0x00000000,
    D2D1_SVG_PATH_COMMAND_MOVE_ABSOLUTE             = 0x00000001,
    D2D1_SVG_PATH_COMMAND_MOVE_RELATIVE             = 0x00000002,
    D2D1_SVG_PATH_COMMAND_LINE_ABSOLUTE             = 0x00000003,
    D2D1_SVG_PATH_COMMAND_LINE_RELATIVE             = 0x00000004,
    D2D1_SVG_PATH_COMMAND_CUBIC_ABSOLUTE            = 0x00000005,
    D2D1_SVG_PATH_COMMAND_CUBIC_RELATIVE            = 0x00000006,
    D2D1_SVG_PATH_COMMAND_QUADRADIC_ABSOLUTE        = 0x00000007,
    D2D1_SVG_PATH_COMMAND_QUADRADIC_RELATIVE        = 0x00000008,
    D2D1_SVG_PATH_COMMAND_ARC_ABSOLUTE              = 0x00000009,
    D2D1_SVG_PATH_COMMAND_ARC_RELATIVE              = 0x0000000a,
    D2D1_SVG_PATH_COMMAND_HORIZONTAL_ABSOLUTE       = 0x0000000b,
    D2D1_SVG_PATH_COMMAND_HORIZONTAL_RELATIVE       = 0x0000000c,
    D2D1_SVG_PATH_COMMAND_VERTICAL_ABSOLUTE         = 0x0000000d,
    D2D1_SVG_PATH_COMMAND_VERTICAL_RELATIVE         = 0x0000000e,
    D2D1_SVG_PATH_COMMAND_CUBIC_SMOOTH_ABSOLUTE     = 0x0000000f,
    D2D1_SVG_PATH_COMMAND_CUBIC_SMOOTH_RELATIVE     = 0x00000010,
    D2D1_SVG_PATH_COMMAND_QUADRADIC_SMOOTH_ABSOLUTE = 0x00000011,
    D2D1_SVG_PATH_COMMAND_QUADRADIC_SMOOTH_RELATIVE = 0x00000012,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/ne-d2d1svg-d2d1_svg_unit_type
alias D2D1_SVG_UNIT_TYPE = int;
enum : int
{
    D2D1_SVG_UNIT_TYPE_USER_SPACE_ON_USE   = 0x00000000,
    D2D1_SVG_UNIT_TYPE_OBJECT_BOUNDING_BOX = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/ne-d2d1svg-d2d1_svg_attribute_string_type
alias D2D1_SVG_ATTRIBUTE_STRING_TYPE = int;
enum : int
{
    D2D1_SVG_ATTRIBUTE_STRING_TYPE_SVG = 0x00000000,
    D2D1_SVG_ATTRIBUTE_STRING_TYPE_ID  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/ne-d2d1svg-d2d1_svg_attribute_pod_type
alias D2D1_SVG_ATTRIBUTE_POD_TYPE = int;
enum : int
{
    D2D1_SVG_ATTRIBUTE_POD_TYPE_FLOAT                 = 0x00000000,
    D2D1_SVG_ATTRIBUTE_POD_TYPE_COLOR                 = 0x00000001,
    D2D1_SVG_ATTRIBUTE_POD_TYPE_FILL_MODE             = 0x00000002,
    D2D1_SVG_ATTRIBUTE_POD_TYPE_DISPLAY               = 0x00000003,
    D2D1_SVG_ATTRIBUTE_POD_TYPE_OVERFLOW              = 0x00000004,
    D2D1_SVG_ATTRIBUTE_POD_TYPE_LINE_CAP              = 0x00000005,
    D2D1_SVG_ATTRIBUTE_POD_TYPE_LINE_JOIN             = 0x00000006,
    D2D1_SVG_ATTRIBUTE_POD_TYPE_VISIBILITY            = 0x00000007,
    D2D1_SVG_ATTRIBUTE_POD_TYPE_MATRIX                = 0x00000008,
    D2D1_SVG_ATTRIBUTE_POD_TYPE_UNIT_TYPE             = 0x00000009,
    D2D1_SVG_ATTRIBUTE_POD_TYPE_EXTEND_MODE           = 0x0000000a,
    D2D1_SVG_ATTRIBUTE_POD_TYPE_PRESERVE_ASPECT_RATIO = 0x0000000b,
    D2D1_SVG_ATTRIBUTE_POD_TYPE_VIEWBOX               = 0x0000000c,
    D2D1_SVG_ATTRIBUTE_POD_TYPE_LENGTH                = 0x0000000d,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/ne-d2d1_3-d2d1_ink_nib_shape
alias D2D1_INK_NIB_SHAPE = int;
enum : int
{
    D2D1_INK_NIB_SHAPE_ROUND  = 0x00000000,
    D2D1_INK_NIB_SHAPE_SQUARE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/ne-d2d1_3-d2d1_orientation
alias D2D1_ORIENTATION = int;
enum : int
{
    D2D1_ORIENTATION_DEFAULT                             = 0x00000001,
    D2D1_ORIENTATION_FLIP_HORIZONTAL                     = 0x00000002,
    D2D1_ORIENTATION_ROTATE_CLOCKWISE180                 = 0x00000003,
    D2D1_ORIENTATION_ROTATE_CLOCKWISE180_FLIP_HORIZONTAL = 0x00000004,
    D2D1_ORIENTATION_ROTATE_CLOCKWISE90_FLIP_HORIZONTAL  = 0x00000005,
    D2D1_ORIENTATION_ROTATE_CLOCKWISE270                 = 0x00000006,
    D2D1_ORIENTATION_ROTATE_CLOCKWISE270_FLIP_HORIZONTAL = 0x00000007,
    D2D1_ORIENTATION_ROTATE_CLOCKWISE90                  = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/ne-d2d1_3-d2d1_image_source_loading_options
alias D2D1_IMAGE_SOURCE_LOADING_OPTIONS = int;
enum : int
{
    D2D1_IMAGE_SOURCE_LOADING_OPTIONS_NONE            = 0x00000000,
    D2D1_IMAGE_SOURCE_LOADING_OPTIONS_RELEASE_SOURCE  = 0x00000001,
    D2D1_IMAGE_SOURCE_LOADING_OPTIONS_CACHE_ON_DEMAND = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/ne-d2d1_3-d2d1_image_source_from_dxgi_options
alias D2D1_IMAGE_SOURCE_FROM_DXGI_OPTIONS = int;
enum : int
{
    D2D1_IMAGE_SOURCE_FROM_DXGI_OPTIONS_NONE                           = 0x00000000,
    D2D1_IMAGE_SOURCE_FROM_DXGI_OPTIONS_LOW_QUALITY_PRIMARY_CONVERSION = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/ne-d2d1_3-d2d1_transformed_image_source_options
alias D2D1_TRANSFORMED_IMAGE_SOURCE_OPTIONS = int;
enum : int
{
    D2D1_TRANSFORMED_IMAGE_SOURCE_OPTIONS_NONE              = 0x00000000,
    D2D1_TRANSFORMED_IMAGE_SOURCE_OPTIONS_DISABLE_DPI_SCALE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/ne-d2d1_3-d2d1_patch_edge_mode
alias D2D1_PATCH_EDGE_MODE = int;
enum : int
{
    D2D1_PATCH_EDGE_MODE_ALIASED          = 0x00000000,
    D2D1_PATCH_EDGE_MODE_ANTIALIASED      = 0x00000001,
    D2D1_PATCH_EDGE_MODE_ALIASED_INFLATED = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/ne-d2d1_3-d2d1_sprite_options
alias D2D1_SPRITE_OPTIONS = int;
enum : int
{
    D2D1_SPRITE_OPTIONS_NONE                      = 0x00000000,
    D2D1_SPRITE_OPTIONS_CLAMP_TO_SOURCE_RECTANGLE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/ne-d2d1_3-d2d1_color_bitmap_glyph_snap_option
alias D2D1_COLOR_BITMAP_GLYPH_SNAP_OPTION = int;
enum : int
{
    D2D1_COLOR_BITMAP_GLYPH_SNAP_OPTION_DEFAULT = 0x00000000,
    D2D1_COLOR_BITMAP_GLYPH_SNAP_OPTION_DISABLE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/ne-d2d1_3-d2d1_gamma1
alias D2D1_GAMMA1 = int;
enum : int
{
    D2D1_GAMMA1_G22   = 0x00000000,
    D2D1_GAMMA1_G10   = 0x00000001,
    D2D1_GAMMA1_G2084 = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/ne-d2d1_3-d2d1_color_context_type
alias D2D1_COLOR_CONTEXT_TYPE = int;
enum : int
{
    D2D1_COLOR_CONTEXT_TYPE_ICC    = 0x00000000,
    D2D1_COLOR_CONTEXT_TYPE_SIMPLE = 0x00000001,
    D2D1_COLOR_CONTEXT_TYPE_DXGI   = 0x00000002,
}

// Constants


enum float D2D1_DEFAULT_FLATTENING_TOLERANCE = 0x1p-2;
enum GUID CLSID_D2D12DAffineTransform = GUID("6aa97485-6354-4cfc-908c-e4a74f62c96c");
enum GUID CLSID_D2D13DPerspectiveTransform = GUID("c2844d0b-3d86-46e7-85ba-526c9240f3fb");

enum : GUID
{
    CLSID_D2D13DTransform         = GUID("e8467b04-ec61-4b8a-b5de-d4d73debea5a"),
    CLSID_D2D1ArithmeticComposite = GUID("fc151437-049a-4784-a24a-f1c4daf20987"),
}

enum : GUID
{
    CLSID_D2D1Atlas            = GUID("913e2be4-fdcf-4fe2-a5f0-2454f14ff408"),
    CLSID_D2D1BitmapSource     = GUID("5fb6c24d-c6dd-4231-9404-50f4d5c3252d"),
    CLSID_D2D1Blend            = GUID("81c5b77b-13f8-4cdd-ad20-c890547ac65d"),
    CLSID_D2D1Border           = GUID("2a2d49c0-4acf-43c7-8c6a-7c4a27874d27"),
    CLSID_D2D1Brightness       = GUID("8cea8d1e-77b0-4986-b3b9-2f0c0eae7887"),
    CLSID_D2D1ColorManagement  = GUID("1a28524c-fdd6-4aa4-ae8f-837eb8267b37"),
    CLSID_D2D1ColorMatrix      = GUID("921f03d6-641c-47df-852d-b4bb6153ae11"),
    CLSID_D2D1Composite        = GUID("48fc9f51-f6ac-48f1-8b58-3b28ac46f76d"),
    CLSID_D2D1ConvolveMatrix   = GUID("407f8c08-5533-4331-a341-23cc3877843e"),
    CLSID_D2D1Crop             = GUID("e23f7110-0e9a-4324-af47-6a2c0c46f35b"),
    CLSID_D2D1DirectionalBlur  = GUID("174319a6-58e9-49b2-bb63-caf2c811a3db"),
    CLSID_D2D1DiscreteTransfer = GUID("90866fcd-488e-454b-af06-e5041b66c36c"),
    CLSID_D2D1DisplacementMap  = GUID("edc48364-0417-4111-9450-43845fa9f890"),
    CLSID_D2D1DistantDiffuse   = GUID("3e7efd62-a32d-46d4-a83c-5278889ac954"),
    CLSID_D2D1DistantSpecular  = GUID("428c1ee5-77b8-4450-8ab5-72219c21abda"),
    CLSID_D2D1DpiCompensation  = GUID("6c26c5c7-34e0-46fc-9cfd-e5823706e228"),
}

enum : GUID
{
    CLSID_D2D1Flood            = GUID("61c23c20-ae69-4d8e-94cf-50078df638f2"),
    CLSID_D2D1GammaTransfer    = GUID("409444c4-c419-41a0-b0c1-8cd0c0a18e42"),
    CLSID_D2D1GaussianBlur     = GUID("1feb6d69-2fe6-4ac9-8c58-1d7f93e7a6a5"),
    CLSID_D2D1Scale            = GUID("9daf9369-3846-4d0e-a44e-0c607934a5d7"),
    CLSID_D2D1Histogram        = GUID("881db7d0-f7ee-4d4d-a6d2-4697acc66ee8"),
    CLSID_D2D1HueRotation      = GUID("0f4458ec-4b32-491b-9e85-bd73f44d3eb6"),
    CLSID_D2D1LinearTransfer   = GUID("ad47c8fd-63ef-4acc-9b51-67979c036c06"),
    CLSID_D2D1LuminanceToAlpha = GUID("41251ab7-0beb-46f8-9da7-59e93fcce5de"),
}

enum : GUID
{
    CLSID_D2D1Morphology      = GUID("eae6c40d-626a-4c2d-bfcb-391001abe202"),
    CLSID_D2D1OpacityMetadata = GUID("6c53006a-4450-4199-aa5b-ad1656fece5e"),
}

enum : GUID
{
    CLSID_D2D1PointDiffuse    = GUID("b9e303c3-c08c-4f91-8b7b-38656bc48c20"),
    CLSID_D2D1PointSpecular   = GUID("09c3ca26-3ae2-4f09-9ebc-ed3865d53f22"),
    CLSID_D2D1Premultiply     = GUID("06eab419-deed-4018-80d2-3e1d471adeb2"),
    CLSID_D2D1Saturation      = GUID("5cb2d9cf-327d-459f-a0ce-40c0b2086bf7"),
    CLSID_D2D1Shadow          = GUID("c67ea361-1863-4e69-89db-695d3e9a5b6b"),
    CLSID_D2D1SpotDiffuse     = GUID("818a1105-7932-44f4-aa86-08ae7b2f2c93"),
    CLSID_D2D1SpotSpecular    = GUID("edae421e-7654-4a37-9db8-71acc1beb3c1"),
    CLSID_D2D1TableTransfer   = GUID("5bf818c3-5e43-48cb-b631-868396d6a1d4"),
    CLSID_D2D1Tile            = GUID("b0784138-3b76-4bc5-b13b-0fa2ad02659f"),
    CLSID_D2D1Turbulence      = GUID("cf2bb6ae-889a-4ad7-ba29-a2fd732c9fc9"),
    CLSID_D2D1UnPremultiply   = GUID("fb9ac489-ad8d-41ed-9999-bb6347d110f7"),
    CLSID_D2D1YCbCr           = GUID("99503cc1-66c7-45c9-a875-8ad8a7914401"),
    CLSID_D2D1Contrast        = GUID("b648a78a-0ed5-4f80-a94a-8e825aca6b77"),
    CLSID_D2D1RgbToHue        = GUID("23f3e5ec-91e8-4d3d-ad0a-afadc1004aa1"),
    CLSID_D2D1HueToRgb        = GUID("7b78a6bd-0141-4def-8a52-6356ee0cbdd5"),
    CLSID_D2D1ChromaKey       = GUID("74c01f5b-2a0d-408c-88e2-c7a3c7197742"),
    CLSID_D2D1Emboss          = GUID("b1c5eb2b-0348-43f0-8107-4957cacba2ae"),
    CLSID_D2D1Exposure        = GUID("b56c8cfa-f634-41ee-bee0-ffa617106004"),
    CLSID_D2D1Grayscale       = GUID("36dde0eb-3725-42e0-836d-52fb20aee644"),
    CLSID_D2D1Invert          = GUID("e0c3784d-cb39-4e84-b6fd-6b72f0810263"),
    CLSID_D2D1Posterize       = GUID("2188945e-33a3-4366-b7bc-086bd02d0884"),
    CLSID_D2D1Sepia           = GUID("3a1af410-5f1d-4dbe-84df-915da79b7153"),
    CLSID_D2D1Sharpen         = GUID("c9b887cb-c5ff-4dc5-9779-273dcf417c7d"),
    CLSID_D2D1Straighten      = GUID("4da47b12-79a3-4fb0-8237-bbc3b2a4de08"),
    CLSID_D2D1TemperatureTint = GUID("89176087-8af9-4a08-aeb1-895f38db1766"),
}

enum : GUID
{
    CLSID_D2D1Vignette          = GUID("c00c40be-5e67-4ca3-95b4-f4b02c115135"),
    CLSID_D2D1EdgeDetection     = GUID("eff583ca-cb07-4aa9-ac5d-2cc44c76460f"),
    CLSID_D2D1HighlightsShadows = GUID("cadc8384-323f-4c7e-a361-2e2b24df6ee4"),
}

enum : GUID
{
    CLSID_D2D1LookupTable3D = GUID("349e0eda-0088-4a79-9ca3-c7e300202020"),
    CLSID_D2D1Opacity       = GUID("811d79a4-de28-4454-8094-c64685f8bd4c"),
    CLSID_D2D1AlphaMask     = GUID("c80ecff0-3fd5-4f05-8328-c5d1724b4f0a"),
    CLSID_D2D1CrossFade     = GUID("12f575e8-4db1-485f-9a84-03a07dd3829f"),
    CLSID_D2D1Tint          = GUID("36312b17-f7dd-4014-915d-ffca768cf211"),
}

enum float D2D1_SCENE_REFERRED_SDR_WHITE_LEVEL = 0x1.4p+6;
enum GUID CLSID_D2D1WhiteLevelAdjustment = GUID("44a1cadb-6cdd-4818-8ff4-26c1cfe95bdb");
enum GUID CLSID_D2D1HdrToneMap = GUID("7b0b748d-4610-4486-a90c-999d9a2e2b11");
enum uint D2D1_APPEND_ALIGNED_ELEMENT = 0xffffffffU;
enum uint FACILITY_D2D = 0x00000899U;

// Callbacks

alias PD2D1_EFFECT_FACTORY = HRESULT function(IUnknown* effectImpl);
alias PD2D1_PROPERTY_SET_FUNCTION = HRESULT function(IUnknown effect, const(ubyte)* data, uint dataSize);
alias PD2D1_PROPERTY_GET_FUNCTION = HRESULT function(const(IUnknown) effect, ubyte* data, uint dataSize, 
                                                     uint* actualSize);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ns-d2d1-d2d1_bitmap_properties
struct D2D1_BITMAP_PROPERTIES
{
    D2D1_PIXEL_FORMAT pixelFormat;
    float             dpiX;
    float             dpiY;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ns-d2d1-d2d1_brush_properties
struct D2D1_BRUSH_PROPERTIES
{
    float            opacity;
    D2D_MATRIX_3X2_F transform;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ns-d2d1-d2d1_bitmap_brush_properties
struct D2D1_BITMAP_BRUSH_PROPERTIES
{
    D2D1_EXTEND_MODE extendModeX;
    D2D1_EXTEND_MODE extendModeY;
    D2D1_BITMAP_INTERPOLATION_MODE interpolationMode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ns-d2d1-d2d1_linear_gradient_brush_properties
struct D2D1_LINEAR_GRADIENT_BRUSH_PROPERTIES
{
    D2D_POINT_2F startPoint;
    D2D_POINT_2F endPoint;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ns-d2d1-d2d1_radial_gradient_brush_properties
struct D2D1_RADIAL_GRADIENT_BRUSH_PROPERTIES
{
    D2D_POINT_2F center;
    D2D_POINT_2F gradientOriginOffset;
    float        radiusX;
    float        radiusY;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ns-d2d1-d2d1_triangle
struct D2D1_TRIANGLE
{
    D2D_POINT_2F point1;
    D2D_POINT_2F point2;
    D2D_POINT_2F point3;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ns-d2d1-d2d1_arc_segment
struct D2D1_ARC_SEGMENT
{
    D2D_POINT_2F         point;
    D2D_SIZE_F           size;
    float                rotationAngle;
    D2D1_SWEEP_DIRECTION sweepDirection;
    D2D1_ARC_SIZE        arcSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ns-d2d1-d2d1_quadratic_bezier_segment
struct D2D1_QUADRATIC_BEZIER_SEGMENT
{
    D2D_POINT_2F point1;
    D2D_POINT_2F point2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ns-d2d1-d2d1_ellipse
struct D2D1_ELLIPSE
{
    D2D_POINT_2F point;
    float        radiusX;
    float        radiusY;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ns-d2d1-d2d1_rounded_rect
struct D2D1_ROUNDED_RECT
{
    D2D_RECT_F rect;
    float      radiusX;
    float      radiusY;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ns-d2d1-d2d1_stroke_style_properties
struct D2D1_STROKE_STYLE_PROPERTIES
{
    D2D1_CAP_STYLE  startCap;
    D2D1_CAP_STYLE  endCap;
    D2D1_CAP_STYLE  dashCap;
    D2D1_LINE_JOIN  lineJoin;
    float           miterLimit;
    D2D1_DASH_STYLE dashStyle;
    float           dashOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ns-d2d1-d2d1_layer_parameters
struct D2D1_LAYER_PARAMETERS
{
    D2D_RECT_F          contentBounds;
    ID2D1Geometry       geometricMask;
    D2D1_ANTIALIAS_MODE maskAntialiasMode;
    D2D_MATRIX_3X2_F    maskTransform;
    float               opacity;
    ID2D1Brush          opacityBrush;
    D2D1_LAYER_OPTIONS  layerOptions;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ns-d2d1-d2d1_render_target_properties
struct D2D1_RENDER_TARGET_PROPERTIES
{
    D2D1_RENDER_TARGET_TYPE type;
    D2D1_PIXEL_FORMAT  pixelFormat;
    float              dpiX;
    float              dpiY;
    D2D1_RENDER_TARGET_USAGE usage;
    D2D1_FEATURE_LEVEL minLevel;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ns-d2d1-d2d1_hwnd_render_target_properties
struct D2D1_HWND_RENDER_TARGET_PROPERTIES
{
    HWND                 hwnd;
    D2D_SIZE_U           pixelSize;
    D2D1_PRESENT_OPTIONS presentOptions;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ns-d2d1-d2d1_drawing_state_description
struct D2D1_DRAWING_STATE_DESCRIPTION
{
    D2D1_ANTIALIAS_MODE antialiasMode;
    D2D1_TEXT_ANTIALIAS_MODE textAntialiasMode;
    ulong               tag1;
    ulong               tag2;
    D2D_MATRIX_3X2_F    transform;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/ns-d2d1-d2d1_factory_options
struct D2D1_FACTORY_OPTIONS
{
    D2D1_DEBUG_LEVEL debugLevel;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/ns-d2d1_1-d2d1_bitmap_properties1
struct D2D1_BITMAP_PROPERTIES1
{
    D2D1_PIXEL_FORMAT   pixelFormat;
    float               dpiX;
    float               dpiY;
    D2D1_BITMAP_OPTIONS bitmapOptions;
    ID2D1ColorContext   colorContext;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/ns-d2d1_1-d2d1_mapped_rect
struct D2D1_MAPPED_RECT
{
    uint   pitch;
    ubyte* bits;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/ns-d2d1_1-d2d1_rendering_controls
struct D2D1_RENDERING_CONTROLS
{
    D2D1_BUFFER_PRECISION bufferPrecision;
    D2D_SIZE_U tileSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/ns-d2d1_1-d2d1_effect_input_description
struct D2D1_EFFECT_INPUT_DESCRIPTION
{
    ID2D1Effect effect;
    uint        inputIndex;
    D2D_RECT_F  inputRectangle;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/ns-d2d1_1-d2d1_point_description
struct D2D1_POINT_DESCRIPTION
{
    D2D_POINT_2F point;
    D2D_POINT_2F unitTangentVector;
    uint         endSegment;
    uint         endFigure;
    float        lengthToEndSegment;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/ns-d2d1_1-d2d1_image_brush_properties
struct D2D1_IMAGE_BRUSH_PROPERTIES
{
    D2D_RECT_F       sourceRectangle;
    D2D1_EXTEND_MODE extendModeX;
    D2D1_EXTEND_MODE extendModeY;
    D2D1_INTERPOLATION_MODE interpolationMode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/ns-d2d1_1-d2d1_bitmap_brush_properties1
struct D2D1_BITMAP_BRUSH_PROPERTIES1
{
    D2D1_EXTEND_MODE extendModeX;
    D2D1_EXTEND_MODE extendModeY;
    D2D1_INTERPOLATION_MODE interpolationMode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/ns-d2d1_1-d2d1_stroke_style_properties1
struct D2D1_STROKE_STYLE_PROPERTIES1
{
    D2D1_CAP_STYLE  startCap;
    D2D1_CAP_STYLE  endCap;
    D2D1_CAP_STYLE  dashCap;
    D2D1_LINE_JOIN  lineJoin;
    float           miterLimit;
    D2D1_DASH_STYLE dashStyle;
    float           dashOffset;
    D2D1_STROKE_TRANSFORM_TYPE transformType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/ns-d2d1_1-d2d1_layer_parameters1
struct D2D1_LAYER_PARAMETERS1
{
    D2D_RECT_F          contentBounds;
    ID2D1Geometry       geometricMask;
    D2D1_ANTIALIAS_MODE maskAntialiasMode;
    D2D_MATRIX_3X2_F    maskTransform;
    float               opacity;
    ID2D1Brush          opacityBrush;
    D2D1_LAYER_OPTIONS1 layerOptions;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/ns-d2d1_1-d2d1_drawing_state_description1
struct D2D1_DRAWING_STATE_DESCRIPTION1
{
    D2D1_ANTIALIAS_MODE  antialiasMode;
    D2D1_TEXT_ANTIALIAS_MODE textAntialiasMode;
    ulong                tag1;
    ulong                tag2;
    D2D_MATRIX_3X2_F     transform;
    D2D1_PRIMITIVE_BLEND primitiveBlend;
    D2D1_UNIT_MODE       unitMode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/ns-d2d1_1-d2d1_print_control_properties
struct D2D1_PRINT_CONTROL_PROPERTIES
{
    D2D1_PRINT_FONT_SUBSET_MODE fontSubset;
    float            rasterDPI;
    D2D1_COLOR_SPACE colorSpace;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/ns-d2d1_1-d2d1_creation_properties
struct D2D1_CREATION_PROPERTIES
{
    D2D1_THREADING_MODE threadingMode;
    D2D1_DEBUG_LEVEL    debugLevel;
    D2D1_DEVICE_CONTEXT_OPTIONS options;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/ns-d2d1effectauthor-d2d1_property_binding
struct D2D1_PROPERTY_BINDING
{
    const(PWSTR) propertyName;
    PD2D1_PROPERTY_SET_FUNCTION setFunction;
    PD2D1_PROPERTY_GET_FUNCTION getFunction;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/ns-d2d1effectauthor-d2d1_resource_texture_properties
struct D2D1_RESOURCE_TEXTURE_PROPERTIES
{
    const(uint)*       extents;
    uint               dimensions;
    D2D1_BUFFER_PRECISION bufferPrecision;
    D2D1_CHANNEL_DEPTH channelDepth;
    D2D1_FILTER        filter;
    const(D2D1_EXTEND_MODE)* extendModes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/ns-d2d1effectauthor-d2d1_input_element_desc
struct D2D1_INPUT_ELEMENT_DESC
{
    const(PSTR) semanticName;
    uint        semanticIndex;
    DXGI_FORMAT format;
    uint        inputSlot;
    uint        alignedByteOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/ns-d2d1effectauthor-d2d1_vertex_buffer_properties
struct D2D1_VERTEX_BUFFER_PROPERTIES
{
    uint              inputCount;
    D2D1_VERTEX_USAGE usage;
    const(ubyte)*     data;
    uint              byteWidth;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/ns-d2d1effectauthor-d2d1_custom_vertex_buffer_properties
struct D2D1_CUSTOM_VERTEX_BUFFER_PROPERTIES
{
    const(ubyte)* shaderBufferWithInputSignature;
    uint          shaderBufferSize;
    const(D2D1_INPUT_ELEMENT_DESC)* inputElements;
    uint          elementCount;
    uint          stride;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/ns-d2d1effectauthor-d2d1_vertex_range
struct D2D1_VERTEX_RANGE
{
    uint startVertex;
    uint vertexCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/ns-d2d1effectauthor-d2d1_blend_description
struct D2D1_BLEND_DESCRIPTION
{
    D2D1_BLEND           sourceBlend;
    D2D1_BLEND           destinationBlend;
    D2D1_BLEND_OPERATION blendOperation;
    D2D1_BLEND           sourceBlendAlpha;
    D2D1_BLEND           destinationBlendAlpha;
    D2D1_BLEND_OPERATION blendOperationAlpha;
    float[4]             blendFactor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/ns-d2d1effectauthor-d2d1_input_description
struct D2D1_INPUT_DESCRIPTION
{
    D2D1_FILTER filter;
    uint        levelOfDetailCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/ns-d2d1effectauthor-d2d1_feature_data_doubles
struct D2D1_FEATURE_DATA_DOUBLES
{
    BOOL doublePrecisionFloatShaderOps;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/ns-d2d1effectauthor-d2d1_feature_data_d3d10_x_hardware_options
struct D2D1_FEATURE_DATA_D3D10_X_HARDWARE_OPTIONS
{
    BOOL computeShaders_Plus_RawAndStructuredBuffers_Via_Shader_4_x;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/ns-d2d1svg-d2d1_svg_length
struct D2D1_SVG_LENGTH
{
    float value;
    D2D1_SVG_LENGTH_UNITS units;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/ns-d2d1svg-d2d1_svg_preserve_aspect_ratio
struct D2D1_SVG_PRESERVE_ASPECT_RATIO
{
    BOOL defer;
    D2D1_SVG_ASPECT_ALIGN align_;
    D2D1_SVG_ASPECT_SCALING meetOrSlice;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/ns-d2d1svg-d2d1_svg_viewbox
struct D2D1_SVG_VIEWBOX
{
    float x;
    float y;
    float width;
    float height;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/ns-d2d1_3-d2d1_transformed_image_source_properties
struct D2D1_TRANSFORMED_IMAGE_SOURCE_PROPERTIES
{
    D2D1_ORIENTATION orientation;
    float            scaleX;
    float            scaleY;
    D2D1_INTERPOLATION_MODE interpolationMode;
    D2D1_TRANSFORMED_IMAGE_SOURCE_OPTIONS options;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/ns-d2d1_3-d2d1_ink_point
struct D2D1_INK_POINT
{
    float x;
    float y;
    float radius;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/ns-d2d1_3-d2d1_ink_bezier_segment
struct D2D1_INK_BEZIER_SEGMENT
{
    D2D1_INK_POINT point1;
    D2D1_INK_POINT point2;
    D2D1_INK_POINT point3;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/ns-d2d1_3-d2d1_ink_style_properties
struct D2D1_INK_STYLE_PROPERTIES
{
    D2D1_INK_NIB_SHAPE nibShape;
    D2D_MATRIX_3X2_F   nibTransform;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/ns-d2d1_3-d2d1_gradient_mesh_patch
struct D2D1_GRADIENT_MESH_PATCH
{
    D2D_POINT_2F         point00;
    D2D_POINT_2F         point01;
    D2D_POINT_2F         point02;
    D2D_POINT_2F         point03;
    D2D_POINT_2F         point10;
    D2D_POINT_2F         point11;
    D2D_POINT_2F         point12;
    D2D_POINT_2F         point13;
    D2D_POINT_2F         point20;
    D2D_POINT_2F         point21;
    D2D_POINT_2F         point22;
    D2D_POINT_2F         point23;
    D2D_POINT_2F         point30;
    D2D_POINT_2F         point31;
    D2D_POINT_2F         point32;
    D2D_POINT_2F         point33;
    D2D1_COLOR_F         color00;
    D2D1_COLOR_F         color03;
    D2D1_COLOR_F         color30;
    D2D1_COLOR_F         color33;
    D2D1_PATCH_EDGE_MODE topEdgeMode;
    D2D1_PATCH_EDGE_MODE leftEdgeMode;
    D2D1_PATCH_EDGE_MODE bottomEdgeMode;
    D2D1_PATCH_EDGE_MODE rightEdgeMode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/ns-d2d1_3-d2d1_simple_color_profile
struct D2D1_SIMPLE_COLOR_PROFILE
{
    D2D_POINT_2F redPrimary;
    D2D_POINT_2F greenPrimary;
    D2D_POINT_2F bluePrimary;
    D2D_POINT_2F whitePointXZ;
    D2D1_GAMMA1  gamma;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("d2d1.dll")
HRESULT D2D1CreateFactory(D2D1_FACTORY_TYPE factoryType, const(GUID)* riid, 
                          const(D2D1_FACTORY_OPTIONS)* pFactoryOptions, void** ppIFactory);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("d2d1.dll")
void D2D1MakeRotateMatrix(float angle, D2D_POINT_2F center, D2D_MATRIX_3X2_F* matrix);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("d2d1.dll")
void D2D1MakeSkewMatrix(float angleX, float angleY, D2D_POINT_2F center, D2D_MATRIX_3X2_F* matrix);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("d2d1.dll")
BOOL D2D1IsMatrixInvertible(const(D2D_MATRIX_3X2_F)* matrix);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("d2d1.dll")
BOOL D2D1InvertMatrix(D2D_MATRIX_3X2_F* matrix);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("d2d1.dll")
HRESULT D2D1CreateDevice(IDXGIDevice dxgiDevice, const(D2D1_CREATION_PROPERTIES)* creationProperties, 
                         ID2D1Device* d2dDevice);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("d2d1.dll")
HRESULT D2D1CreateDeviceContext(IDXGISurface dxgiSurface, const(D2D1_CREATION_PROPERTIES)* creationProperties, 
                                ID2D1DeviceContext* d2dDeviceContext);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-d2d1convertcolorspace
@DllImport("d2d1.dll")
D2D1_COLOR_F D2D1ConvertColorSpace(D2D1_COLOR_SPACE sourceColorSpace, D2D1_COLOR_SPACE destinationColorSpace, 
                                   const(D2D1_COLOR_F)* color);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-d2d1sincos
@DllImport("d2d1.dll")
void D2D1SinCos(float angle, float* s, float* c);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-d2d1tan
@DllImport("d2d1.dll")
float D2D1Tan(float angle);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-d2d1vec3length
@DllImport("d2d1.dll")
float D2D1Vec3Length(float x, float y, float z);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("d2d1.dll")
float D2D1ComputeMaximumScaleFactor(const(D2D_MATRIX_3X2_F)* matrix);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("d2d1.dll")
void D2D1GetGradientMeshInteriorPointsFromCoonsPatch(const(D2D_POINT_2F)* pPoint0, const(D2D_POINT_2F)* pPoint1, 
                                                     const(D2D_POINT_2F)* pPoint2, const(D2D_POINT_2F)* pPoint3, 
                                                     const(D2D_POINT_2F)* pPoint4, const(D2D_POINT_2F)* pPoint5, 
                                                     const(D2D_POINT_2F)* pPoint6, const(D2D_POINT_2F)* pPoint7, 
                                                     const(D2D_POINT_2F)* pPoint8, const(D2D_POINT_2F)* pPoint9, 
                                                     const(D2D_POINT_2F)* pPoint10, const(D2D_POINT_2F)* pPoint11, 
                                                     D2D_POINT_2F* pTensorPoint11, D2D_POINT_2F* pTensorPoint12, 
                                                     D2D_POINT_2F* pTensorPoint21, D2D_POINT_2F* pTensorPoint22);


// Interfaces

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1resource
@GUID("2cd90691-12e2-11dc-9fed-001143a055f9")
interface ID2D1Resource : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1resource-getfactory
    void GetFactory(ID2D1Factory* factory);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1image
@GUID("65019f75-8da2-497c-b32c-dfa34e48ede6")
interface ID2D1Image : ID2D1Resource
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1bitmap
@GUID("a2296057-ea42-4099-983b-539fb6505426")
interface ID2D1Bitmap : ID2D1Image
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1bitmap-getsize
    D2D_SIZE_F GetSize();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1bitmap-getpixelsize
    D2D_SIZE_U GetPixelSize();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1bitmap-getpixelformat
    D2D1_PIXEL_FORMAT GetPixelFormat();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1bitmap-getdpi
    void    GetDpi(float* dpiX, float* dpiY);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1bitmap-copyfrombitmap
    HRESULT CopyFromBitmap(const(D2D_POINT_2U)* destPoint, ID2D1Bitmap bitmap, const(D2D_RECT_U)* srcRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1bitmap-copyfromrendertarget
    HRESULT CopyFromRenderTarget(const(D2D_POINT_2U)* destPoint, ID2D1RenderTarget renderTarget, 
                                 const(D2D_RECT_U)* srcRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1bitmap-copyfrommemory
    HRESULT CopyFromMemory(const(D2D_RECT_U)* dstRect, const(void)* srcData, uint pitch);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1gradientstopcollection
@GUID("2cd906a7-12e2-11dc-9fed-001143a055f9")
interface ID2D1GradientStopCollection : ID2D1Resource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1gradientstopcollection-getgradientstopcount
    uint GetGradientStopCount();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1gradientstopcollection-getgradientstops
    void GetGradientStops(D2D1_GRADIENT_STOP* gradientStops, uint gradientStopsCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1gradientstopcollection-getcolorinterpolationgamma
    D2D1_GAMMA GetColorInterpolationGamma();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1gradientstopcollection-getextendmode
    D2D1_EXTEND_MODE GetExtendMode();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1brush
@GUID("2cd906a8-12e2-11dc-9fed-001143a055f9")
interface ID2D1Brush : ID2D1Resource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1brush-setopacity
    void  SetOpacity(float opacity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1brush-settransform
    void  SetTransform(const(D2D_MATRIX_3X2_F)* transform);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1brush-getopacity
    float GetOpacity();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1brush-gettransform
    void  GetTransform(D2D_MATRIX_3X2_F* transform);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1bitmapbrush
@GUID("2cd906aa-12e2-11dc-9fed-001143a055f9")
interface ID2D1BitmapBrush : ID2D1Brush
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1bitmapbrush-setextendmodex
    void SetExtendModeX(D2D1_EXTEND_MODE extendModeX);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1bitmapbrush-setextendmodey
    void SetExtendModeY(D2D1_EXTEND_MODE extendModeY);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1bitmapbrush-setinterpolationmode
    void SetInterpolationMode(D2D1_BITMAP_INTERPOLATION_MODE interpolationMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1bitmapbrush-setbitmap
    void SetBitmap(ID2D1Bitmap bitmap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1bitmapbrush-getextendmodex
    D2D1_EXTEND_MODE GetExtendModeX();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1bitmapbrush-getextendmodey
    D2D1_EXTEND_MODE GetExtendModeY();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1bitmapbrush-getinterpolationmode
    D2D1_BITMAP_INTERPOLATION_MODE GetInterpolationMode();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1bitmapbrush-getbitmap
    void GetBitmap(ID2D1Bitmap* bitmap);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1solidcolorbrush
@GUID("2cd906a9-12e2-11dc-9fed-001143a055f9")
interface ID2D1SolidColorBrush : ID2D1Brush
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1solidcolorbrush-setcolor
    void SetColor(const(D2D1_COLOR_F)* color);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1solidcolorbrush-getcolor
    D2D1_COLOR_F GetColor();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1lineargradientbrush
@GUID("2cd906ab-12e2-11dc-9fed-001143a055f9")
interface ID2D1LinearGradientBrush : ID2D1Brush
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1lineargradientbrush-setstartpoint
    void SetStartPoint(D2D_POINT_2F startPoint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1lineargradientbrush-setendpoint
    void SetEndPoint(D2D_POINT_2F endPoint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1lineargradientbrush-getstartpoint
    D2D_POINT_2F GetStartPoint();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1lineargradientbrush-getendpoint
    D2D_POINT_2F GetEndPoint();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1lineargradientbrush-getgradientstopcollection
    void GetGradientStopCollection(ID2D1GradientStopCollection* gradientStopCollection);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1radialgradientbrush
@GUID("2cd906ac-12e2-11dc-9fed-001143a055f9")
interface ID2D1RadialGradientBrush : ID2D1Brush
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1radialgradientbrush-setcenter
    void  SetCenter(D2D_POINT_2F center);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1radialgradientbrush-setgradientoriginoffset
    void  SetGradientOriginOffset(D2D_POINT_2F gradientOriginOffset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1radialgradientbrush-setradiusx
    void  SetRadiusX(float radiusX);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1radialgradientbrush-setradiusy
    void  SetRadiusY(float radiusY);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1radialgradientbrush-getcenter
    D2D_POINT_2F GetCenter();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1radialgradientbrush-getgradientoriginoffset
    D2D_POINT_2F GetGradientOriginOffset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1radialgradientbrush-getradiusx
    float GetRadiusX();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1radialgradientbrush-getradiusy
    float GetRadiusY();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1radialgradientbrush-getgradientstopcollection
    void  GetGradientStopCollection(ID2D1GradientStopCollection* gradientStopCollection);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1strokestyle
@GUID("2cd9069d-12e2-11dc-9fed-001143a055f9")
interface ID2D1StrokeStyle : ID2D1Resource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1strokestyle-getstartcap
    D2D1_CAP_STYLE GetStartCap();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1strokestyle-getendcap
    D2D1_CAP_STYLE GetEndCap();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1strokestyle-getdashcap
    D2D1_CAP_STYLE GetDashCap();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1strokestyle-getmiterlimit
    float GetMiterLimit();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1strokestyle-getlinejoin
    D2D1_LINE_JOIN GetLineJoin();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1strokestyle-getdashoffset
    float GetDashOffset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1strokestyle-getdashstyle
    D2D1_DASH_STYLE GetDashStyle();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1strokestyle-getdashescount
    uint  GetDashesCount();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1strokestyle-getdashes
    void  GetDashes(float* dashes, uint dashesCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1geometry
@GUID("2cd906a1-12e2-11dc-9fed-001143a055f9")
interface ID2D1Geometry : ID2D1Resource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1geometry-getbounds
    HRESULT GetBounds(const(D2D_MATRIX_3X2_F)* worldTransform, D2D_RECT_F* bounds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1geometry-getwidenedbounds
    HRESULT GetWidenedBounds(float strokeWidth, ID2D1StrokeStyle strokeStyle, 
                             const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, D2D_RECT_F* bounds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1geometry-strokecontainspoint
    HRESULT StrokeContainsPoint(D2D_POINT_2F point, float strokeWidth, ID2D1StrokeStyle strokeStyle, 
                                const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, BOOL* contains);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1geometry-fillcontainspoint
    HRESULT FillContainsPoint(D2D_POINT_2F point, const(D2D_MATRIX_3X2_F)* worldTransform, 
                              float flatteningTolerance, BOOL* contains);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1geometry-comparewithgeometry
    HRESULT CompareWithGeometry(ID2D1Geometry inputGeometry, const(D2D_MATRIX_3X2_F)* inputGeometryTransform, 
                                float flatteningTolerance, D2D1_GEOMETRY_RELATION* relation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1geometry-simplify
    HRESULT Simplify(D2D1_GEOMETRY_SIMPLIFICATION_OPTION simplificationOption, 
                     const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, 
                     ID2D1SimplifiedGeometrySink geometrySink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1geometry-tessellate
    HRESULT Tessellate(const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, 
                       ID2D1TessellationSink tessellationSink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1geometry-combinewithgeometry
    HRESULT CombineWithGeometry(ID2D1Geometry inputGeometry, D2D1_COMBINE_MODE combineMode, 
                                const(D2D_MATRIX_3X2_F)* inputGeometryTransform, float flatteningTolerance, 
                                ID2D1SimplifiedGeometrySink geometrySink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1geometry-outline
    HRESULT Outline(const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, 
                    ID2D1SimplifiedGeometrySink geometrySink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1geometry-computearea
    HRESULT ComputeArea(const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, float* area);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1geometry-computelength
    HRESULT ComputeLength(const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, float* length);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1geometry-computepointatlength
    HRESULT ComputePointAtLength(float length, const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, 
                                 D2D_POINT_2F* point, D2D_POINT_2F* unitTangentVector);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1geometry-widen
    HRESULT Widen(float strokeWidth, ID2D1StrokeStyle strokeStyle, const(D2D_MATRIX_3X2_F)* worldTransform, 
                  float flatteningTolerance, ID2D1SimplifiedGeometrySink geometrySink);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1rectanglegeometry
@GUID("2cd906a2-12e2-11dc-9fed-001143a055f9")
interface ID2D1RectangleGeometry : ID2D1Geometry
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rectanglegeometry-getrect
    void GetRect(D2D_RECT_F* rect);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1roundedrectanglegeometry
@GUID("2cd906a3-12e2-11dc-9fed-001143a055f9")
interface ID2D1RoundedRectangleGeometry : ID2D1Geometry
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1roundedrectanglegeometry-getroundedrect
    void GetRoundedRect(D2D1_ROUNDED_RECT* roundedRect);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1ellipsegeometry
@GUID("2cd906a4-12e2-11dc-9fed-001143a055f9")
interface ID2D1EllipseGeometry : ID2D1Geometry
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1ellipsegeometry-getellipse
    void GetEllipse(D2D1_ELLIPSE* ellipse);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1geometrygroup
@GUID("2cd906a6-12e2-11dc-9fed-001143a055f9")
interface ID2D1GeometryGroup : ID2D1Geometry
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1geometrygroup-getfillmode
    D2D1_FILL_MODE GetFillMode();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1geometrygroup-getsourcegeometrycount
    uint GetSourceGeometryCount();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1geometrygroup-getsourcegeometries
    void GetSourceGeometries(ID2D1Geometry* geometries, uint geometriesCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1transformedgeometry
@GUID("2cd906bb-12e2-11dc-9fed-001143a055f9")
interface ID2D1TransformedGeometry : ID2D1Geometry
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1transformedgeometry-getsourcegeometry
    void GetSourceGeometry(ID2D1Geometry* sourceGeometry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1transformedgeometry-gettransform
    void GetTransform(D2D_MATRIX_3X2_F* transform);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1geometrysink
@GUID("2cd9069f-12e2-11dc-9fed-001143a055f9")
interface ID2D1GeometrySink : ID2D1SimplifiedGeometrySink
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1geometrysink-addline
    void AddLine(D2D_POINT_2F point);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1geometrysink-addbezier
    void AddBezier(const(D2D1_BEZIER_SEGMENT)* bezier);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1geometrysink-addquadraticbezier
    void AddQuadraticBezier(const(D2D1_QUADRATIC_BEZIER_SEGMENT)* bezier);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1geometrysink-addquadraticbeziers
    void AddQuadraticBeziers(const(D2D1_QUADRATIC_BEZIER_SEGMENT)* beziers, uint beziersCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1geometrysink-addarc
    void AddArc(const(D2D1_ARC_SEGMENT)* arc);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1tessellationsink
@GUID("2cd906c1-12e2-11dc-9fed-001143a055f9")
interface ID2D1TessellationSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1tessellationsink-addtriangles
    void    AddTriangles(const(D2D1_TRIANGLE)* triangles, uint trianglesCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1tessellationsink-close
    HRESULT Close();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1pathgeometry
@GUID("2cd906a5-12e2-11dc-9fed-001143a055f9")
interface ID2D1PathGeometry : ID2D1Geometry
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1pathgeometry-open
    HRESULT Open(ID2D1GeometrySink* geometrySink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1pathgeometry-stream
    HRESULT Stream(ID2D1GeometrySink geometrySink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1pathgeometry-getsegmentcount
    HRESULT GetSegmentCount(uint* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1pathgeometry-getfigurecount
    HRESULT GetFigureCount(uint* count);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1mesh
@GUID("2cd906c2-12e2-11dc-9fed-001143a055f9")
interface ID2D1Mesh : ID2D1Resource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1mesh-open
    HRESULT Open(ID2D1TessellationSink* tessellationSink);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1layer
@GUID("2cd9069b-12e2-11dc-9fed-001143a055f9")
interface ID2D1Layer : ID2D1Resource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1layer-getsize
    D2D_SIZE_F GetSize();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1drawingstateblock
@GUID("28506e39-ebf6-46a1-bb47-fd85565ab957")
interface ID2D1DrawingStateBlock : ID2D1Resource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1drawingstateblock-getdescription
    void GetDescription(D2D1_DRAWING_STATE_DESCRIPTION* stateDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1drawingstateblock-setdescription
    void SetDescription(const(D2D1_DRAWING_STATE_DESCRIPTION)* stateDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1drawingstateblock-settextrenderingparams
    void SetTextRenderingParams(IDWriteRenderingParams textRenderingParams);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1drawingstateblock-gettextrenderingparams
    void GetTextRenderingParams(IDWriteRenderingParams* textRenderingParams);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1rendertarget
@GUID("2cd90694-12e2-11dc-9fed-001143a055f9")
interface ID2D1RenderTarget : ID2D1Resource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1rendertarget-createbitmap
    HRESULT CreateBitmap(D2D_SIZE_U size, const(void)* srcData, uint pitch, 
                         const(D2D1_BITMAP_PROPERTIES)* bitmapProperties, ID2D1Bitmap* bitmap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1rendertarget-createbitmapfromwicbitmap
    HRESULT CreateBitmapFromWicBitmap(IWICBitmapSource wicBitmapSource, 
                                      const(D2D1_BITMAP_PROPERTIES)* bitmapProperties, ID2D1Bitmap* bitmap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-createsharedbitmap
    HRESULT CreateSharedBitmap(const(GUID)* riid, void* data, const(D2D1_BITMAP_PROPERTIES)* bitmapProperties, 
                               ID2D1Bitmap* bitmap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1rendertarget-createbitmapbrush
    HRESULT CreateBitmapBrush(ID2D1Bitmap bitmap, const(D2D1_BITMAP_BRUSH_PROPERTIES)* bitmapBrushProperties, 
                              const(D2D1_BRUSH_PROPERTIES)* brushProperties, ID2D1BitmapBrush* bitmapBrush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1rendertarget-createsolidcolorbrush
    HRESULT CreateSolidColorBrush(const(D2D1_COLOR_F)* color, const(D2D1_BRUSH_PROPERTIES)* brushProperties, 
                                  ID2D1SolidColorBrush* solidColorBrush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1rendertarget-creategradientstopcollection
    HRESULT CreateGradientStopCollection(const(D2D1_GRADIENT_STOP)* gradientStops, uint gradientStopsCount, 
                                         D2D1_GAMMA colorInterpolationGamma, D2D1_EXTEND_MODE extendMode, 
                                         ID2D1GradientStopCollection* gradientStopCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1rendertarget-createlineargradientbrush
    HRESULT CreateLinearGradientBrush(const(D2D1_LINEAR_GRADIENT_BRUSH_PROPERTIES)* linearGradientBrushProperties, 
                                      const(D2D1_BRUSH_PROPERTIES)* brushProperties, 
                                      ID2D1GradientStopCollection gradientStopCollection, 
                                      ID2D1LinearGradientBrush* linearGradientBrush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1rendertarget-createradialgradientbrush
    HRESULT CreateRadialGradientBrush(const(D2D1_RADIAL_GRADIENT_BRUSH_PROPERTIES)* radialGradientBrushProperties, 
                                      const(D2D1_BRUSH_PROPERTIES)* brushProperties, 
                                      ID2D1GradientStopCollection gradientStopCollection, 
                                      ID2D1RadialGradientBrush* radialGradientBrush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1rendertarget-createcompatiblerendertarget
    HRESULT CreateCompatibleRenderTarget(const(D2D_SIZE_F)* desiredSize, const(D2D_SIZE_U)* desiredPixelSize, 
                                         const(D2D1_PIXEL_FORMAT)* desiredFormat, 
                                         D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS options, 
                                         ID2D1BitmapRenderTarget* bitmapRenderTarget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1rendertarget-createlayer
    HRESULT CreateLayer(const(D2D_SIZE_F)* size, ID2D1Layer* layer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-createmesh
    HRESULT CreateMesh(ID2D1Mesh* mesh);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-drawline
    void    DrawLine(D2D_POINT_2F point0, D2D_POINT_2F point1, ID2D1Brush brush, float strokeWidth, 
                     ID2D1StrokeStyle strokeStyle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1rendertarget-drawrectangle
    void    DrawRectangle(const(D2D_RECT_F)* rect, ID2D1Brush brush, float strokeWidth, 
                          ID2D1StrokeStyle strokeStyle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1rendertarget-fillrectangle
    void    FillRectangle(const(D2D_RECT_F)* rect, ID2D1Brush brush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1rendertarget-drawroundedrectangle
    void    DrawRoundedRectangle(const(D2D1_ROUNDED_RECT)* roundedRect, ID2D1Brush brush, float strokeWidth, 
                                 ID2D1StrokeStyle strokeStyle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1rendertarget-fillroundedrectangle
    void    FillRoundedRectangle(const(D2D1_ROUNDED_RECT)* roundedRect, ID2D1Brush brush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1rendertarget-drawellipse
    void    DrawEllipse(const(D2D1_ELLIPSE)* ellipse, ID2D1Brush brush, float strokeWidth, 
                        ID2D1StrokeStyle strokeStyle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1rendertarget-fillellipse
    void    FillEllipse(const(D2D1_ELLIPSE)* ellipse, ID2D1Brush brush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-drawgeometry
    void    DrawGeometry(ID2D1Geometry geometry, ID2D1Brush brush, float strokeWidth, ID2D1StrokeStyle strokeStyle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-fillgeometry
    void    FillGeometry(ID2D1Geometry geometry, ID2D1Brush brush, ID2D1Brush opacityBrush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-fillmesh
    void    FillMesh(ID2D1Mesh mesh, ID2D1Brush brush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1rendertarget-fillopacitymask
    void    FillOpacityMask(ID2D1Bitmap opacityMask, ID2D1Brush brush, D2D1_OPACITY_MASK_CONTENT content, 
                            const(D2D_RECT_F)* destinationRectangle, const(D2D_RECT_F)* sourceRectangle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1rendertarget-drawbitmap
    void    DrawBitmap(ID2D1Bitmap bitmap, const(D2D_RECT_F)* destinationRectangle, float opacity, 
                       D2D1_BITMAP_INTERPOLATION_MODE interpolationMode, const(D2D_RECT_F)* sourceRectangle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1rendertarget-drawtext
    void    DrawText(const(PWSTR) string, uint stringLength, IDWriteTextFormat textFormat, 
                     const(D2D_RECT_F)* layoutRect, ID2D1Brush defaultFillBrush, D2D1_DRAW_TEXT_OPTIONS options, 
                     DWRITE_MEASURING_MODE measuringMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-drawtextlayout
    void    DrawTextLayout(D2D_POINT_2F origin, IDWriteTextLayout textLayout, ID2D1Brush defaultFillBrush, 
                           D2D1_DRAW_TEXT_OPTIONS options);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-drawglyphrun
    void    DrawGlyphRun(D2D_POINT_2F baselineOrigin, const(DWRITE_GLYPH_RUN)* glyphRun, 
                         ID2D1Brush foregroundBrush, DWRITE_MEASURING_MODE measuringMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1rendertarget-settransform
    void    SetTransform(const(D2D_MATRIX_3X2_F)* transform);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-gettransform
    void    GetTransform(D2D_MATRIX_3X2_F* transform);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-setantialiasmode
    void    SetAntialiasMode(D2D1_ANTIALIAS_MODE antialiasMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-getantialiasmode
    D2D1_ANTIALIAS_MODE GetAntialiasMode();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-settextantialiasmode
    void    SetTextAntialiasMode(D2D1_TEXT_ANTIALIAS_MODE textAntialiasMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-gettextantialiasmode
    D2D1_TEXT_ANTIALIAS_MODE GetTextAntialiasMode();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-settextrenderingparams
    void    SetTextRenderingParams(IDWriteRenderingParams textRenderingParams);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-gettextrenderingparams
    void    GetTextRenderingParams(IDWriteRenderingParams* textRenderingParams);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-settags
    void    SetTags(ulong tag1, ulong tag2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-gettags
    void    GetTags(ulong* tag1, ulong* tag2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-pushlayer(constd2d1_layer_parameters_id2d1layer)
    void    PushLayer(const(D2D1_LAYER_PARAMETERS)* layerParameters, ID2D1Layer layer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-poplayer
    void    PopLayer();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-flush
    HRESULT Flush(ulong* tag1, ulong* tag2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-savedrawingstate
    void    SaveDrawingState(ID2D1DrawingStateBlock drawingStateBlock);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-restoredrawingstate
    void    RestoreDrawingState(ID2D1DrawingStateBlock drawingStateBlock);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1rendertarget-pushaxisalignedclip
    void    PushAxisAlignedClip(const(D2D_RECT_F)* clipRect, D2D1_ANTIALIAS_MODE antialiasMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-popaxisalignedclip
    void    PopAxisAlignedClip();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1rendertarget-clear
    void    Clear(const(D2D1_COLOR_F)* clearColor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-begindraw
    void    BeginDraw();
//METH ATTR: CanReturnErrorsAsSuccessAttribute : CustomAttributeSig([], [])
    HRESULT EndDraw(ulong* tag1, ulong* tag2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-getpixelformat
    D2D1_PIXEL_FORMAT GetPixelFormat();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-setdpi
    void    SetDpi(float dpiX, float dpiY);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-getdpi
    void    GetDpi(float* dpiX, float* dpiY);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-getsize
    D2D_SIZE_F GetSize();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-getpixelsize
    D2D_SIZE_U GetPixelSize();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-getmaximumbitmapsize
    uint    GetMaximumBitmapSize();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1rendertarget-issupported(constd2d1_render_target_properties_)
    BOOL    IsSupported(const(D2D1_RENDER_TARGET_PROPERTIES)* renderTargetProperties);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1bitmaprendertarget
@GUID("2cd90695-12e2-11dc-9fed-001143a055f9")
interface ID2D1BitmapRenderTarget : ID2D1RenderTarget
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1bitmaprendertarget-getbitmap
    HRESULT GetBitmap(ID2D1Bitmap* bitmap);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1hwndrendertarget
@GUID("2cd90698-12e2-11dc-9fed-001143a055f9")
interface ID2D1HwndRenderTarget : ID2D1RenderTarget
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1hwndrendertarget-checkwindowstate
    D2D1_WINDOW_STATE CheckWindowState();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1hwndrendertarget-resize
    HRESULT Resize(const(D2D_SIZE_U)* pixelSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1hwndrendertarget-gethwnd
    HWND    GetHwnd();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1gdiinteroprendertarget
@GUID("e0db51c3-6f77-4bae-b3d5-e47509b35838")
interface ID2D1GdiInteropRenderTarget : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1gdiinteroprendertarget-getdc
    HRESULT GetDC(D2D1_DC_INITIALIZE_MODE mode, HDC* hdc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1gdiinteroprendertarget-releasedc
    HRESULT ReleaseDC(const(RECT)* update);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1dcrendertarget
@GUID("1c51bc64-de61-46fd-9899-63a5d8f03950")
interface ID2D1DCRenderTarget : ID2D1RenderTarget
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1dcrendertarget-binddc
    HRESULT BindDC(const(HDC) hDC, const(RECT)* pSubRect);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1factory
@GUID("06152247-6f50-465a-9245-118bfd3b6007")
interface ID2D1Factory : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1factory-reloadsystemmetrics
    HRESULT ReloadSystemMetrics();
    deprecated("Deprecated. Use DisplayInformation::LogicalDpi for Windows Store Apps or GetDpiForWindow for desktop apps.") 
    void    GetDesktopDpi(float* dpiX, float* dpiY);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1factory-createrectanglegeometry
    HRESULT CreateRectangleGeometry(const(D2D_RECT_F)* rectangle, ID2D1RectangleGeometry* rectangleGeometry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1factory-createroundedrectanglegeometry
    HRESULT CreateRoundedRectangleGeometry(const(D2D1_ROUNDED_RECT)* roundedRectangle, 
                                           ID2D1RoundedRectangleGeometry* roundedRectangleGeometry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1factory-createellipsegeometry
    HRESULT CreateEllipseGeometry(const(D2D1_ELLIPSE)* ellipse, ID2D1EllipseGeometry* ellipseGeometry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1factory-creategeometrygroup
    HRESULT CreateGeometryGroup(D2D1_FILL_MODE fillMode, ID2D1Geometry* geometries, uint geometriesCount, 
                                ID2D1GeometryGroup* geometryGroup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1factory-createtransformedgeometry
    HRESULT CreateTransformedGeometry(ID2D1Geometry sourceGeometry, const(D2D_MATRIX_3X2_F)* transform, 
                                      ID2D1TransformedGeometry* transformedGeometry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1factory-createpathgeometry
    HRESULT CreatePathGeometry(ID2D1PathGeometry* pathGeometry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1factory-createstrokestyle
    HRESULT CreateStrokeStyle(const(D2D1_STROKE_STYLE_PROPERTIES)* strokeStyleProperties, const(float)* dashes, 
                              uint dashesCount, ID2D1StrokeStyle* strokeStyle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1factory-createdrawingstateblock
    HRESULT CreateDrawingStateBlock(const(D2D1_DRAWING_STATE_DESCRIPTION)* drawingStateDescription, 
                                    IDWriteRenderingParams textRenderingParams, 
                                    ID2D1DrawingStateBlock* drawingStateBlock);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1factory-createwicbitmaprendertarget
    HRESULT CreateWicBitmapRenderTarget(IWICBitmap target, 
                                        const(D2D1_RENDER_TARGET_PROPERTIES)* renderTargetProperties, 
                                        ID2D1RenderTarget* renderTarget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1factory-createhwndrendertarget
    HRESULT CreateHwndRenderTarget(const(D2D1_RENDER_TARGET_PROPERTIES)* renderTargetProperties, 
                                   const(D2D1_HWND_RENDER_TARGET_PROPERTIES)* hwndRenderTargetProperties, 
                                   ID2D1HwndRenderTarget* hwndRenderTarget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1factory-createdxgisurfacerendertarget(idxgisurface_constd2d1_render_target_properties__id2d1rendertarget)
    HRESULT CreateDxgiSurfaceRenderTarget(IDXGISurface dxgiSurface, 
                                          const(D2D1_RENDER_TARGET_PROPERTIES)* renderTargetProperties, 
                                          ID2D1RenderTarget* renderTarget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1factory-createdcrendertarget
    HRESULT CreateDCRenderTarget(const(D2D1_RENDER_TARGET_PROPERTIES)* renderTargetProperties, 
                                 ID2D1DCRenderTarget* dcRenderTarget);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nn-d2d1_1-id2d1gdimetafilesink
@GUID("82237326-8111-4f7c-bcf4-b5c1175564fe")
interface ID2D1GdiMetafileSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1gdimetafilesink-processrecord
    HRESULT ProcessRecord(uint recordType, const(void)* recordData, uint recordDataSize);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nn-d2d1_1-id2d1gdimetafile
@GUID("2f543dc3-cfc1-4211-864f-cfd91c6f3395")
interface ID2D1GdiMetafile : ID2D1Resource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1gdimetafile-stream
    HRESULT Stream(ID2D1GdiMetafileSink sink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1gdimetafile-getbounds
    HRESULT GetBounds(D2D_RECT_F* bounds);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nn-d2d1_1-id2d1commandsink
@GUID("54d7898a-a061-40a7-bec7-e465bcba2c4f")
interface ID2D1CommandSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1commandsink-begindraw
    HRESULT BeginDraw();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1commandsink-enddraw
    HRESULT EndDraw();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1commandsink-setantialiasmode
    HRESULT SetAntialiasMode(D2D1_ANTIALIAS_MODE antialiasMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1commandsink-settags
    HRESULT SetTags(ulong tag1, ulong tag2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1commandsink-settextantialiasmode
    HRESULT SetTextAntialiasMode(D2D1_TEXT_ANTIALIAS_MODE textAntialiasMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1commandsink-settextrenderingparams
    HRESULT SetTextRenderingParams(IDWriteRenderingParams textRenderingParams);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1commandsink-settransform
    HRESULT SetTransform(const(D2D_MATRIX_3X2_F)* transform);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1commandsink-setprimitiveblend
    HRESULT SetPrimitiveBlend(D2D1_PRIMITIVE_BLEND primitiveBlend);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1commandsink-setunitmode
    HRESULT SetUnitMode(D2D1_UNIT_MODE unitMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1commandsink-clear
    HRESULT Clear(const(D2D1_COLOR_F)* color);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1commandsink-drawglyphrun
    HRESULT DrawGlyphRun(D2D_POINT_2F baselineOrigin, const(DWRITE_GLYPH_RUN)* glyphRun, 
                         const(DWRITE_GLYPH_RUN_DESCRIPTION)* glyphRunDescription, ID2D1Brush foregroundBrush, 
                         DWRITE_MEASURING_MODE measuringMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1commandsink-drawline
    HRESULT DrawLine(D2D_POINT_2F point0, D2D_POINT_2F point1, ID2D1Brush brush, float strokeWidth, 
                     ID2D1StrokeStyle strokeStyle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1commandsink-drawgeometry
    HRESULT DrawGeometry(ID2D1Geometry geometry, ID2D1Brush brush, float strokeWidth, ID2D1StrokeStyle strokeStyle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1commandsink-drawrectangle
    HRESULT DrawRectangle(const(D2D_RECT_F)* rect, ID2D1Brush brush, float strokeWidth, 
                          ID2D1StrokeStyle strokeStyle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1commandsink-drawbitmap
    HRESULT DrawBitmap(ID2D1Bitmap bitmap, const(D2D_RECT_F)* destinationRectangle, float opacity, 
                       D2D1_INTERPOLATION_MODE interpolationMode, const(D2D_RECT_F)* sourceRectangle, 
                       const(D2D_MATRIX_4X4_F)* perspectiveTransform);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1commandsink-drawimage
    HRESULT DrawImage(ID2D1Image image, const(D2D_POINT_2F)* targetOffset, const(D2D_RECT_F)* imageRectangle, 
                      D2D1_INTERPOLATION_MODE interpolationMode, D2D1_COMPOSITE_MODE compositeMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1commandsink-drawgdimetafile
    HRESULT DrawGdiMetafile(ID2D1GdiMetafile gdiMetafile, const(D2D_POINT_2F)* targetOffset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1commandsink-fillmesh
    HRESULT FillMesh(ID2D1Mesh mesh, ID2D1Brush brush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1commandsink-fillopacitymask
    HRESULT FillOpacityMask(ID2D1Bitmap opacityMask, ID2D1Brush brush, const(D2D_RECT_F)* destinationRectangle, 
                            const(D2D_RECT_F)* sourceRectangle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1commandsink-fillgeometry
    HRESULT FillGeometry(ID2D1Geometry geometry, ID2D1Brush brush, ID2D1Brush opacityBrush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1commandsink-fillrectangle
    HRESULT FillRectangle(const(D2D_RECT_F)* rect, ID2D1Brush brush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1commandsink-pushaxisalignedclip
    HRESULT PushAxisAlignedClip(const(D2D_RECT_F)* clipRect, D2D1_ANTIALIAS_MODE antialiasMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1commandsink-pushlayer
    HRESULT PushLayer(const(D2D1_LAYER_PARAMETERS1)* layerParameters1, ID2D1Layer layer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1commandsink-popaxisalignedclip
    HRESULT PopAxisAlignedClip();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1commandsink-poplayer
    HRESULT PopLayer();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nn-d2d1_1-id2d1commandlist
@GUID("b4f34a19-2383-4d76-94f6-ec343657c3dc")
interface ID2D1CommandList : ID2D1Image
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1commandlist-stream
    HRESULT Stream(ID2D1CommandSink sink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1commandlist-close
    HRESULT Close();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nn-d2d1_1-id2d1printcontrol
@GUID("2c1d867d-c290-41c8-ae7e-34a98702e9a5")
interface ID2D1PrintControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1printcontrol-addpage
    HRESULT AddPage(ID2D1CommandList commandList, D2D_SIZE_F pageSize, IStream pagePrintTicketStream, ulong* tag1, 
                    ulong* tag2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1printcontrol-close
    HRESULT Close();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nn-d2d1_1-id2d1imagebrush
@GUID("fe9e984d-3f95-407c-b5db-cb94d4e8f87c")
interface ID2D1ImageBrush : ID2D1Brush
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1imagebrush-setimage
    void SetImage(ID2D1Image image);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1imagebrush-setextendmodex
    void SetExtendModeX(D2D1_EXTEND_MODE extendModeX);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1imagebrush-setextendmodey
    void SetExtendModeY(D2D1_EXTEND_MODE extendModeY);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1imagebrush-setinterpolationmode
    void SetInterpolationMode(D2D1_INTERPOLATION_MODE interpolationMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1imagebrush-setsourcerectangle
    void SetSourceRectangle(const(D2D_RECT_F)* sourceRectangle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1imagebrush-getimage
    void GetImage(ID2D1Image* image);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1imagebrush-getextendmodex
    D2D1_EXTEND_MODE GetExtendModeX();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1imagebrush-getextendmodey
    D2D1_EXTEND_MODE GetExtendModeY();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1imagebrush-getinterpolationmode
    D2D1_INTERPOLATION_MODE GetInterpolationMode();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1imagebrush-getsourcerectangle
    void GetSourceRectangle(D2D_RECT_F* sourceRectangle);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nn-d2d1_1-id2d1bitmapbrush1
@GUID("41343a53-e41a-49a2-91cd-21793bbb62e5")
interface ID2D1BitmapBrush1 : ID2D1BitmapBrush
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1bitmapbrush1-setinterpolationmode1
    void SetInterpolationMode1(D2D1_INTERPOLATION_MODE interpolationMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1bitmapbrush1-getinterpolationmode1
    D2D1_INTERPOLATION_MODE GetInterpolationMode1();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nn-d2d1_1-id2d1strokestyle1
@GUID("10a72a66-e91c-43f4-993f-ddf4b82b0b4a")
interface ID2D1StrokeStyle1 : ID2D1StrokeStyle
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1strokestyle1-getstroketransformtype
    D2D1_STROKE_TRANSFORM_TYPE GetStrokeTransformType();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nn-d2d1_1-id2d1pathgeometry1
@GUID("62baa2d2-ab54-41b7-b872-787e0106a421")
interface ID2D1PathGeometry1 : ID2D1PathGeometry
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1pathgeometry1-computepointandsegmentatlength(float_uint32_constd2d1_matrix_3x2_f__float_d2d1_point_description)
    HRESULT ComputePointAndSegmentAtLength(float length, uint startSegment, 
                                           const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, 
                                           D2D1_POINT_DESCRIPTION* pointDescription);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nn-d2d1_1-id2d1properties
@GUID("483473d7-cd46-4f9d-9d3a-3112aa80159d")
interface ID2D1Properties : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1properties-getpropertycount
    uint    GetPropertyCount();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1properties-getpropertyname(uint32_pwstr_uint32)
    HRESULT GetPropertyName(uint index, PWSTR name, uint nameCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1properties-getpropertynamelength(u)
    uint    GetPropertyNameLength(uint index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1properties-gettype(uint32)
    D2D1_PROPERTY_TYPE GetType(uint index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1properties-getpropertyindex
    uint    GetPropertyIndex(const(PWSTR) name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1properties-setvaluebyname(pcwstr_constbyte_uint32)
    HRESULT SetValueByName(const(PWSTR) name, D2D1_PROPERTY_TYPE type, const(ubyte)* data, uint dataSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1properties-setvalue(u_constbyte_uint32)
    HRESULT SetValue(uint index, D2D1_PROPERTY_TYPE type, const(ubyte)* data, uint dataSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1properties-getvaluebyname(pcwstr)
    HRESULT GetValueByName(const(PWSTR) name, D2D1_PROPERTY_TYPE type, ubyte* data, uint dataSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1properties-getvalue(u_t)
    HRESULT GetValue(uint index, D2D1_PROPERTY_TYPE type, ubyte* data, uint dataSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1properties-getvaluesize(u)
    uint    GetValueSize(uint index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1properties-getsubproperties(uint32_id2d1properties)
    HRESULT GetSubProperties(uint index, ID2D1Properties* subProperties);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nn-d2d1_1-id2d1effect
@GUID("28211a43-7d89-476f-8181-2d6159b220ad")
interface ID2D1Effect : ID2D1Properties
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1effect-setinput
    void    SetInput(uint index, ID2D1Image input, BOOL invalidate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1effect-setinputcount
    HRESULT SetInputCount(uint inputCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1effect-getinput
    void    GetInput(uint index, ID2D1Image* input);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1effect-getinputcount
    uint    GetInputCount();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1effect-getoutput
    void    GetOutput(ID2D1Image* outputImage);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nn-d2d1_1-id2d1bitmap1
@GUID("a898a84c-3873-4588-b08b-ebbf978df041")
interface ID2D1Bitmap1 : ID2D1Bitmap
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1bitmap1-getcolorcontext
    void    GetColorContext(ID2D1ColorContext* colorContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1bitmap1-getoptions
    D2D1_BITMAP_OPTIONS GetOptions();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1bitmap1-getsurface
    HRESULT GetSurface(IDXGISurface* dxgiSurface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1bitmap1-map
    HRESULT Map(D2D1_MAP_OPTIONS options, D2D1_MAPPED_RECT* mappedRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1bitmap1-unmap
    HRESULT Unmap();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nn-d2d1_1-id2d1colorcontext
@GUID("1c4820bb-5771-4518-a581-2fe4dd0ec657")
interface ID2D1ColorContext : ID2D1Resource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1colorcontext-getcolorspace
    D2D1_COLOR_SPACE GetColorSpace();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1colorcontext-getprofilesize
    uint    GetProfileSize();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1colorcontext-getprofile
    HRESULT GetProfile(ubyte* profile, uint profileSize);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nn-d2d1_1-id2d1gradientstopcollection1
@GUID("ae1572f4-5dd0-4777-998b-9279472ae63b")
interface ID2D1GradientStopCollection1 : ID2D1GradientStopCollection
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1gradientstopcollection1-getgradientstops1
    void GetGradientStops1(D2D1_GRADIENT_STOP* gradientStops, uint gradientStopsCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1gradientstopcollection1-getpreinterpolationspace
    D2D1_COLOR_SPACE GetPreInterpolationSpace();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1gradientstopcollection1-getpostinterpolationspace
    D2D1_COLOR_SPACE GetPostInterpolationSpace();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1gradientstopcollection1-getbufferprecision
    D2D1_BUFFER_PRECISION GetBufferPrecision();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1gradientstopcollection1-getcolorinterpolationmode
    D2D1_COLOR_INTERPOLATION_MODE GetColorInterpolationMode();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nn-d2d1_1-id2d1drawingstateblock1
@GUID("689f1f85-c72e-4e33-8f19-85754efd5ace")
interface ID2D1DrawingStateBlock1 : ID2D1DrawingStateBlock
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1drawingstateblock1-getdescription
    void GetDescription(D2D1_DRAWING_STATE_DESCRIPTION1* stateDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1drawingstateblock1-setdescription
    void SetDescription(const(D2D1_DRAWING_STATE_DESCRIPTION1)* stateDescription);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nn-d2d1_1-id2d1devicecontext
@GUID("e8f7fe7a-191c-466d-ad95-975678bda998")
interface ID2D1DeviceContext : ID2D1RenderTarget
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-createbitmap(d2d1_size_u_constvoid_uint32_constd2d1_bitmap_properties1_id2d1bitmap1)
    HRESULT CreateBitmap(D2D_SIZE_U size, const(void)* sourceData, uint pitch, 
                         const(D2D1_BITMAP_PROPERTIES1)* bitmapProperties, ID2D1Bitmap1* bitmap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-createbitmapfromwicbitmap(iwicbitmapsource_id2d1bitmap1)
    HRESULT CreateBitmapFromWicBitmap(IWICBitmapSource wicBitmapSource, 
                                      const(D2D1_BITMAP_PROPERTIES1)* bitmapProperties, ID2D1Bitmap1* bitmap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-createcolorcontext
    HRESULT CreateColorContext(D2D1_COLOR_SPACE space, const(ubyte)* profile, uint profileSize, 
                               ID2D1ColorContext* colorContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-createcolorcontextfromfilename
    HRESULT CreateColorContextFromFilename(const(PWSTR) filename, ID2D1ColorContext* colorContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-createcolorcontextfromwiccolorcontext
    HRESULT CreateColorContextFromWicColorContext(IWICColorContext wicColorContext, 
                                                  ID2D1ColorContext* colorContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-createbitmapfromdxgisurface(idxgisurface_constd2d1_bitmap_properties1_id2d1bitmap1)
    HRESULT CreateBitmapFromDxgiSurface(IDXGISurface surface, const(D2D1_BITMAP_PROPERTIES1)* bitmapProperties, 
                                        ID2D1Bitmap1* bitmap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-createeffect
    HRESULT CreateEffect(const(GUID)* effectId, ID2D1Effect* effect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-creategradientstopcollection
    HRESULT CreateGradientStopCollection(const(D2D1_GRADIENT_STOP)* straightAlphaGradientStops, 
                                         uint straightAlphaGradientStopsCount, 
                                         D2D1_COLOR_SPACE preInterpolationSpace, 
                                         D2D1_COLOR_SPACE postInterpolationSpace, 
                                         D2D1_BUFFER_PRECISION bufferPrecision, D2D1_EXTEND_MODE extendMode, 
                                         D2D1_COLOR_INTERPOLATION_MODE colorInterpolationMode, 
                                         ID2D1GradientStopCollection1* gradientStopCollection1);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-createimagebrush(id2d1image_constd2d1_image_brush_properties__id2d1imagebrush)
    HRESULT CreateImageBrush(ID2D1Image image, const(D2D1_IMAGE_BRUSH_PROPERTIES)* imageBrushProperties, 
                             const(D2D1_BRUSH_PROPERTIES)* brushProperties, ID2D1ImageBrush* imageBrush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-createbitmapbrush(id2d1bitmap_constd2d1_bitmap_brush_properties1__constd2d1_brush_properties__id2d1bitmapbrush1)
    HRESULT CreateBitmapBrush(ID2D1Bitmap bitmap, const(D2D1_BITMAP_BRUSH_PROPERTIES1)* bitmapBrushProperties, 
                              const(D2D1_BRUSH_PROPERTIES)* brushProperties, ID2D1BitmapBrush1* bitmapBrush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-createcommandlist
    HRESULT CreateCommandList(ID2D1CommandList* commandList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-isdxgiformatsupported
    BOOL    IsDxgiFormatSupported(DXGI_FORMAT format);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-isbufferprecisionsupported
    BOOL    IsBufferPrecisionSupported(D2D1_BUFFER_PRECISION bufferPrecision);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-getimagelocalbounds
    HRESULT GetImageLocalBounds(ID2D1Image image, D2D_RECT_F* localBounds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-getimageworldbounds
    HRESULT GetImageWorldBounds(ID2D1Image image, D2D_RECT_F* worldBounds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-getglyphrunworldbounds
    HRESULT GetGlyphRunWorldBounds(D2D_POINT_2F baselineOrigin, const(DWRITE_GLYPH_RUN)* glyphRun, 
                                   DWRITE_MEASURING_MODE measuringMode, D2D_RECT_F* bounds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-getdevice
    void    GetDevice(ID2D1Device* device);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-settarget
    void    SetTarget(ID2D1Image image);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-gettarget
    void    GetTarget(ID2D1Image* image);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-setrenderingcontrols(constd2d1_rendering_controls_)
    void    SetRenderingControls(const(D2D1_RENDERING_CONTROLS)* renderingControls);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-getrenderingcontrols
    void    GetRenderingControls(D2D1_RENDERING_CONTROLS* renderingControls);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-setprimitiveblend
    void    SetPrimitiveBlend(D2D1_PRIMITIVE_BLEND primitiveBlend);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-getprimitiveblend
    D2D1_PRIMITIVE_BLEND GetPrimitiveBlend();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-setunitmode
    void    SetUnitMode(D2D1_UNIT_MODE unitMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-getunitmode
    D2D1_UNIT_MODE GetUnitMode();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-drawglyphrun
    void    DrawGlyphRun(D2D_POINT_2F baselineOrigin, const(DWRITE_GLYPH_RUN)* glyphRun, 
                         const(DWRITE_GLYPH_RUN_DESCRIPTION)* glyphRunDescription, ID2D1Brush foregroundBrush, 
                         DWRITE_MEASURING_MODE measuringMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-drawimage(id2d1image_constd2d1_point_2f_constd2d1_rect_f_d2d1_interpolation_mode_d2d1_composite_mode)
    void    DrawImage(ID2D1Image image, const(D2D_POINT_2F)* targetOffset, const(D2D_RECT_F)* imageRectangle, 
                      D2D1_INTERPOLATION_MODE interpolationMode, D2D1_COMPOSITE_MODE compositeMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-drawgdimetafile(id2d1gdimetafile_constd2d1_point_2f)
    void    DrawGdiMetafile(ID2D1GdiMetafile gdiMetafile, const(D2D_POINT_2F)* targetOffset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-drawbitmap(id2d1bitmap_constd2d1_rect_f_float_d2d1_interpolation_mode_constd2d1_rect_f_constd2d1_matrix_4x4_f)
    void    DrawBitmap(ID2D1Bitmap bitmap, const(D2D_RECT_F)* destinationRectangle, float opacity, 
                       D2D1_INTERPOLATION_MODE interpolationMode, const(D2D_RECT_F)* sourceRectangle, 
                       const(D2D_MATRIX_4X4_F)* perspectiveTransform);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-pushlayer(constd2d1_layer_parameters1__id2d1layer)
    void    PushLayer(const(D2D1_LAYER_PARAMETERS1)* layerParameters, ID2D1Layer layer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-invalidateeffectinputrectangle
    HRESULT InvalidateEffectInputRectangle(ID2D1Effect effect, uint input, const(D2D_RECT_F)* inputRectangle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-geteffectinvalidrectanglecount
    HRESULT GetEffectInvalidRectangleCount(ID2D1Effect effect, uint* rectangleCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-geteffectinvalidrectangles
    HRESULT GetEffectInvalidRectangles(ID2D1Effect effect, D2D_RECT_F* rectangles, uint rectanglesCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-geteffectrequiredinputrectangles
    HRESULT GetEffectRequiredInputRectangles(ID2D1Effect renderEffect, const(D2D_RECT_F)* renderImageRectangle, 
                                             const(D2D1_EFFECT_INPUT_DESCRIPTION)* inputDescriptions, 
                                             D2D_RECT_F* requiredInputRects, uint inputCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1devicecontext-fillopacitymask(id2d1bitmap_id2d1brush_constd2d1_rect_f__constd2d1_rect_f)
    void    FillOpacityMask(ID2D1Bitmap opacityMask, ID2D1Brush brush, const(D2D_RECT_F)* destinationRectangle, 
                            const(D2D_RECT_F)* sourceRectangle);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nn-d2d1_1-id2d1device
@GUID("47dd575d-ac05-4cdd-8049-9b02cd16f44c")
interface ID2D1Device : ID2D1Resource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1device-createdevicecontext
    HRESULT CreateDeviceContext(D2D1_DEVICE_CONTEXT_OPTIONS options, ID2D1DeviceContext* deviceContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1device-createprintcontrol
    HRESULT CreatePrintControl(IWICImagingFactory wicFactory, IPrintDocumentPackageTarget documentTarget, 
                               const(D2D1_PRINT_CONTROL_PROPERTIES)* printControlProperties, 
                               ID2D1PrintControl* printControl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1device-setmaximumtexturememory
    void    SetMaximumTextureMemory(ulong maximumInBytes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1device-getmaximumtexturememory
    ulong   GetMaximumTextureMemory();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1device-clearresources
    void    ClearResources(uint millisecondsSinceUse);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nn-d2d1_1-id2d1factory1
@GUID("bb12d362-daee-4b9a-aa1d-14ba401cfa1f")
interface ID2D1Factory1 : ID2D1Factory
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1factory1-createdevice
    HRESULT CreateDevice(IDXGIDevice dxgiDevice, ID2D1Device* d2dDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1factory1-createstrokestyle(constd2d1_stroke_style_properties1_constfloat_uint32_id2d1strokestyle1)
    HRESULT CreateStrokeStyle(const(D2D1_STROKE_STYLE_PROPERTIES1)* strokeStyleProperties, const(float)* dashes, 
                              uint dashesCount, ID2D1StrokeStyle1* strokeStyle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1factory1-createpathgeometry
    HRESULT CreatePathGeometry(ID2D1PathGeometry1* pathGeometry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1factory1-createdrawingstateblock(constd2d1_drawing_state_description1_idwriterenderingparams_id2d1drawingstateblock1)
    HRESULT CreateDrawingStateBlock(const(D2D1_DRAWING_STATE_DESCRIPTION1)* drawingStateDescription, 
                                    IDWriteRenderingParams textRenderingParams, 
                                    ID2D1DrawingStateBlock1* drawingStateBlock);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1factory1-creategdimetafile
    HRESULT CreateGdiMetafile(IStream metafileStream, ID2D1GdiMetafile* metafile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1factory1-registereffectfromstream
    HRESULT RegisterEffectFromStream(const(GUID)* classId, IStream propertyXml, 
                                     const(D2D1_PROPERTY_BINDING)* bindings, uint bindingsCount, 
                                     const(PD2D1_EFFECT_FACTORY) effectFactory);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1factory1-registereffectfromstring
    HRESULT RegisterEffectFromString(const(GUID)* classId, const(PWSTR) propertyXml, 
                                     const(D2D1_PROPERTY_BINDING)* bindings, uint bindingsCount, 
                                     const(PD2D1_EFFECT_FACTORY) effectFactory);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1factory1-unregistereffect
    HRESULT UnregisterEffect(const(GUID)* classId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1factory1-getregisteredeffects
    HRESULT GetRegisteredEffects(GUID* effects, uint effectsCount, uint* effectsReturned, uint* effectsRegistered);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1factory1-geteffectproperties
    HRESULT GetEffectProperties(const(GUID)* effectId, ID2D1Properties* properties);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nn-d2d1_1-id2d1multithread
@GUID("31e6e7bc-e0ff-4d46-8c64-a0a8c41c15d3")
interface ID2D1Multithread : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1multithread-getmultithreadprotected
    BOOL GetMultithreadProtected();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1multithread-enter
    void Enter();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_1/nf-d2d1_1-id2d1multithread-leave
    void Leave();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nn-d2d1effectauthor-id2d1vertexbuffer
@GUID("9b8b1336-00a5-4668-92b7-ced5d8bf9b7b")
interface ID2D1VertexBuffer : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1vertexbuffer-map
    HRESULT Map(ubyte** data, uint bufferSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1vertexbuffer-unmap
    HRESULT Unmap();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nn-d2d1effectauthor-id2d1resourcetexture
@GUID("688d15c3-02b0-438d-b13a-d1b44c32c39a")
interface ID2D1ResourceTexture : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1resourcetexture-update
    HRESULT Update(const(uint)* minimumExtents, const(uint)* maximimumExtents, const(uint)* strides, 
                   uint dimensions, const(ubyte)* data, uint dataCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nn-d2d1effectauthor-id2d1renderinfo
@GUID("519ae1bd-d19a-420d-b849-364f594776b7")
interface ID2D1RenderInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1renderinfo-setinputdescription
    HRESULT SetInputDescription(uint inputIndex, D2D1_INPUT_DESCRIPTION inputDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1renderinfo-setoutputbuffer
    HRESULT SetOutputBuffer(D2D1_BUFFER_PRECISION bufferPrecision, D2D1_CHANNEL_DEPTH channelDepth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1renderinfo-setcached
    void    SetCached(BOOL isCached);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1renderinfo-setinstructioncounthint
    void    SetInstructionCountHint(uint instructionCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nn-d2d1effectauthor-id2d1drawinfo
@GUID("693ce632-7f2f-45de-93fe-18d88b37aa21")
interface ID2D1DrawInfo : ID2D1RenderInfo
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1drawinfo-setpixelshaderconstantbuffer
    HRESULT SetPixelShaderConstantBuffer(const(ubyte)* buffer, uint bufferCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1drawinfo-setresourcetexture
    HRESULT SetResourceTexture(uint textureIndex, ID2D1ResourceTexture resourceTexture);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1drawinfo-setvertexshaderconstantbuffer
    HRESULT SetVertexShaderConstantBuffer(const(ubyte)* buffer, uint bufferCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1drawinfo-setpixelshader
    HRESULT SetPixelShader(const(GUID)* shaderId, D2D1_PIXEL_OPTIONS pixelOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1drawinfo-setvertexprocessing
    HRESULT SetVertexProcessing(ID2D1VertexBuffer vertexBuffer, D2D1_VERTEX_OPTIONS vertexOptions, 
                                const(D2D1_BLEND_DESCRIPTION)* blendDescription, 
                                const(D2D1_VERTEX_RANGE)* vertexRange, const(GUID)* vertexShader);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nn-d2d1effectauthor-id2d1computeinfo
@GUID("5598b14b-9fd7-48b7-9bdb-8f0964eb38bc")
interface ID2D1ComputeInfo : ID2D1RenderInfo
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1computeinfo-setcomputeshaderconstantbuffer
    HRESULT SetComputeShaderConstantBuffer(const(ubyte)* buffer, uint bufferCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1computeinfo-setcomputeshader
    HRESULT SetComputeShader(const(GUID)* shaderId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1computeinfo-setresourcetexture
    HRESULT SetResourceTexture(uint textureIndex, ID2D1ResourceTexture resourceTexture);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nn-d2d1effectauthor-id2d1transformnode
@GUID("b2efe1e7-729f-4102-949f-505fa21bf666")
interface ID2D1TransformNode : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1transformnode-getinputcount
    uint GetInputCount();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nn-d2d1effectauthor-id2d1transformgraph
@GUID("13d29038-c3e6-4034-9081-13b53a417992")
interface ID2D1TransformGraph : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1transformgraph-getinputcount
    uint    GetInputCount();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1transformgraph-setsingletransformnode
    HRESULT SetSingleTransformNode(ID2D1TransformNode node);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1transformgraph-addnode
    HRESULT AddNode(ID2D1TransformNode node);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1transformgraph-removenode
    HRESULT RemoveNode(ID2D1TransformNode node);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1transformgraph-setoutputnode
    HRESULT SetOutputNode(ID2D1TransformNode node);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1transformgraph-connectnode
    HRESULT ConnectNode(ID2D1TransformNode fromNode, ID2D1TransformNode toNode, uint toNodeInputIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1transformgraph-connecttoeffectinput
    HRESULT ConnectToEffectInput(uint toEffectInputIndex, ID2D1TransformNode node, uint toNodeInputIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1transformgraph-clear
    void    Clear();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1transformgraph-setpassthroughgraph
    HRESULT SetPassthroughGraph(uint effectInputIndex);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nn-d2d1effectauthor-id2d1transform
@GUID("ef1a287d-342a-4f76-8fdb-da0d6ea9f92b")
interface ID2D1Transform : ID2D1TransformNode
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1transform-mapoutputrecttoinputrects
    HRESULT MapOutputRectToInputRects(const(RECT)* outputRect, RECT* inputRects, uint inputRectsCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1transform-mapinputrectstooutputrect
    HRESULT MapInputRectsToOutputRect(const(RECT)* inputRects, const(RECT)* inputOpaqueSubRects, 
                                      uint inputRectCount, RECT* outputRect, RECT* outputOpaqueSubRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1transform-mapinvalidrect
    HRESULT MapInvalidRect(uint inputIndex, RECT invalidInputRect, RECT* invalidOutputRect);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nn-d2d1effectauthor-id2d1drawtransform
@GUID("36bfdcb6-9739-435d-a30d-a653beff6a6f")
interface ID2D1DrawTransform : ID2D1Transform
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1drawtransform-setdrawinfo
    HRESULT SetDrawInfo(ID2D1DrawInfo drawInfo);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nn-d2d1effectauthor-id2d1computetransform
@GUID("0d85573c-01e3-4f7d-bfd9-0d60608bf3c3")
interface ID2D1ComputeTransform : ID2D1Transform
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1computetransform-setcomputeinfo
    HRESULT SetComputeInfo(ID2D1ComputeInfo computeInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1computetransform-calculatethreadgroups
    HRESULT CalculateThreadgroups(const(RECT)* outputRect, uint* dimensionX, uint* dimensionY, uint* dimensionZ);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nn-d2d1effectauthor-id2d1analysistransform
@GUID("0359dc30-95e6-4568-9055-27720d130e93")
interface ID2D1AnalysisTransform : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1analysistransform-processanalysisresults
    HRESULT ProcessAnalysisResults(const(ubyte)* analysisData, uint analysisDataCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nn-d2d1effectauthor-id2d1sourcetransform
@GUID("db1800dd-0c34-4cf9-be90-31cc0a5653e1")
interface ID2D1SourceTransform : ID2D1Transform
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1sourcetransform-setrenderinfo
    HRESULT SetRenderInfo(ID2D1RenderInfo renderInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1sourcetransform-draw
    HRESULT Draw(ID2D1Bitmap1 target, const(RECT)* drawRect, D2D_POINT_2U targetOrigin);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nn-d2d1effectauthor-id2d1concretetransform
@GUID("1a799d8a-69f7-4e4c-9fed-437ccc6684cc")
interface ID2D1ConcreteTransform : ID2D1TransformNode
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1concretetransform-setoutputbuffer
    HRESULT SetOutputBuffer(D2D1_BUFFER_PRECISION bufferPrecision, D2D1_CHANNEL_DEPTH channelDepth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1concretetransform-setcached
    void    SetCached(BOOL isCached);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nn-d2d1effectauthor-id2d1blendtransform
@GUID("63ac0b32-ba44-450f-8806-7f4ca1ff2f1b")
interface ID2D1BlendTransform : ID2D1ConcreteTransform
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1blendtransform-setdescription
    void SetDescription(const(D2D1_BLEND_DESCRIPTION)* description);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1blendtransform-getdescription
    void GetDescription(D2D1_BLEND_DESCRIPTION* description);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nn-d2d1effectauthor-id2d1bordertransform
@GUID("4998735c-3a19-473c-9781-656847e3a347")
interface ID2D1BorderTransform : ID2D1ConcreteTransform
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1bordertransform-setextendmodex
    void SetExtendModeX(D2D1_EXTEND_MODE extendMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1bordertransform-setextendmodey
    void SetExtendModeY(D2D1_EXTEND_MODE extendMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1bordertransform-getextendmodex
    D2D1_EXTEND_MODE GetExtendModeX();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1bordertransform-getextendmodey
    D2D1_EXTEND_MODE GetExtendModeY();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nn-d2d1effectauthor-id2d1offsettransform
@GUID("3fe6adea-7643-4f53-bd14-a0ce63f24042")
interface ID2D1OffsetTransform : ID2D1TransformNode
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1offsettransform-setoffset
    void  SetOffset(POINT offset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1offsettransform-getoffset
    POINT GetOffset();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nn-d2d1effectauthor-id2d1boundsadjustmenttransform
@GUID("90f732e2-5092-4606-a819-8651970baccd")
interface ID2D1BoundsAdjustmentTransform : ID2D1TransformNode
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1boundsadjustmenttransform-setoutputbounds
    void SetOutputBounds(const(RECT)* outputBounds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1boundsadjustmenttransform-getoutputbounds
    void GetOutputBounds(RECT* outputBounds);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nn-d2d1effectauthor-id2d1effectimpl
@GUID("a248fd3f-3e6c-4e63-9f03-7f68ecc91db9")
interface ID2D1EffectImpl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1effectimpl-initialize
    HRESULT Initialize(ID2D1EffectContext effectContext, ID2D1TransformGraph transformGraph);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1effectimpl-prepareforrender
    HRESULT PrepareForRender(D2D1_CHANGE_TYPE changeType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1effectimpl-setgraph
    HRESULT SetGraph(ID2D1TransformGraph transformGraph);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nn-d2d1effectauthor-id2d1effectcontext
@GUID("3d9f916b-27dc-4ad7-b4f1-64945340f563")
interface ID2D1EffectContext : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1effectcontext-getdpi
    void    GetDpi(float* dpiX, float* dpiY);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1effectcontext-createeffect
    HRESULT CreateEffect(const(GUID)* effectId, ID2D1Effect* effect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1effectcontext-getmaximumsupportedfeaturelevel
    HRESULT GetMaximumSupportedFeatureLevel(const(D3D_FEATURE_LEVEL)* featureLevels, uint featureLevelsCount, 
                                            D3D_FEATURE_LEVEL* maximumSupportedFeatureLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1effectcontext-createtransformnodefromeffect
    HRESULT CreateTransformNodeFromEffect(ID2D1Effect effect, ID2D1TransformNode* transformNode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1effectcontext-createblendtransform
    HRESULT CreateBlendTransform(uint numInputs, const(D2D1_BLEND_DESCRIPTION)* blendDescription, 
                                 ID2D1BlendTransform* transform);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1effectcontext-createbordertransform
    HRESULT CreateBorderTransform(D2D1_EXTEND_MODE extendModeX, D2D1_EXTEND_MODE extendModeY, 
                                  ID2D1BorderTransform* transform);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1effectcontext-createoffsettransform
    HRESULT CreateOffsetTransform(POINT offset, ID2D1OffsetTransform* transform);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1effectcontext-createboundsadjustmenttransform
    HRESULT CreateBoundsAdjustmentTransform(const(RECT)* outputRectangle, 
                                            ID2D1BoundsAdjustmentTransform* transform);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1effectcontext-loadpixelshader
    HRESULT LoadPixelShader(const(GUID)* shaderId, const(ubyte)* shaderBuffer, uint shaderBufferCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1effectcontext-loadvertexshader
    HRESULT LoadVertexShader(const(GUID)* resourceId, const(ubyte)* shaderBuffer, uint shaderBufferCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1effectcontext-loadcomputeshader
    HRESULT LoadComputeShader(const(GUID)* resourceId, const(ubyte)* shaderBuffer, uint shaderBufferCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1effectcontext-isshaderloaded
    BOOL    IsShaderLoaded(const(GUID)* shaderId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1effectcontext-createresourcetexture
    HRESULT CreateResourceTexture(const(GUID)* resourceId, 
                                  const(D2D1_RESOURCE_TEXTURE_PROPERTIES)* resourceTextureProperties, 
                                  const(ubyte)* data, const(uint)* strides, uint dataSize, 
                                  ID2D1ResourceTexture* resourceTexture);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1effectcontext-findresourcetexture
    HRESULT FindResourceTexture(const(GUID)* resourceId, ID2D1ResourceTexture* resourceTexture);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1effectcontext-createvertexbuffer
    HRESULT CreateVertexBuffer(const(D2D1_VERTEX_BUFFER_PROPERTIES)* vertexBufferProperties, 
                               const(GUID)* resourceId, 
                               const(D2D1_CUSTOM_VERTEX_BUFFER_PROPERTIES)* customVertexBufferProperties, 
                               ID2D1VertexBuffer* buffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1effectcontext-findvertexbuffer
    HRESULT FindVertexBuffer(const(GUID)* resourceId, ID2D1VertexBuffer* buffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1effectcontext-createcolorcontext
    HRESULT CreateColorContext(D2D1_COLOR_SPACE space, const(ubyte)* profile, uint profileSize, 
                               ID2D1ColorContext* colorContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1effectcontext-createcolorcontextfromfilename
    HRESULT CreateColorContextFromFilename(const(PWSTR) filename, ID2D1ColorContext* colorContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1effectcontext-createcolorcontextfromwiccolorcontext
    HRESULT CreateColorContextFromWicColorContext(IWICColorContext wicColorContext, 
                                                  ID2D1ColorContext* colorContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1effectcontext-checkfeaturesupport
    HRESULT CheckFeatureSupport(D2D1_FEATURE feature, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* featureSupportData, 
                                uint featureSupportDataSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor/nf-d2d1effectauthor-id2d1effectcontext-isbufferprecisionsupported
    BOOL    IsBufferPrecisionSupported(D2D1_BUFFER_PRECISION bufferPrecision);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_2/nn-d2d1_2-id2d1geometryrealization
@GUID("a16907d7-bc02-4801-99e8-8cf7f485f774")
interface ID2D1GeometryRealization : ID2D1Resource
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_2/nn-d2d1_2-id2d1devicecontext1
@GUID("d37f57e4-6908-459f-a199-e72f24f79987")
interface ID2D1DeviceContext1 : ID2D1DeviceContext
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_2/nf-d2d1_2-id2d1devicecontext1-createfilledgeometryrealization
    HRESULT CreateFilledGeometryRealization(ID2D1Geometry geometry, float flatteningTolerance, 
                                            ID2D1GeometryRealization* geometryRealization);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_2/nf-d2d1_2-id2d1devicecontext1-createstrokedgeometryrealization
    HRESULT CreateStrokedGeometryRealization(ID2D1Geometry geometry, float flatteningTolerance, float strokeWidth, 
                                             ID2D1StrokeStyle strokeStyle, 
                                             ID2D1GeometryRealization* geometryRealization);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_2/nf-d2d1_2-id2d1devicecontext1-drawgeometryrealization
    void    DrawGeometryRealization(ID2D1GeometryRealization geometryRealization, ID2D1Brush brush);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_2/nn-d2d1_2-id2d1device1
@GUID("d21768e1-23a4-4823-a14b-7c3eba85d658")
interface ID2D1Device1 : ID2D1Device
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_2/nf-d2d1_2-id2d1device1-getrenderingpriority
    D2D1_RENDERING_PRIORITY GetRenderingPriority();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_2/nf-d2d1_2-id2d1device1-setrenderingpriority
    void    SetRenderingPriority(D2D1_RENDERING_PRIORITY renderingPriority);
    HRESULT CreateDeviceContext(D2D1_DEVICE_CONTEXT_OPTIONS options, ID2D1DeviceContext1* deviceContext1);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_2/nn-d2d1_2-id2d1factory2
@GUID("94f81a73-9212-4376-9c58-b16a3a0d3992")
interface ID2D1Factory2 : ID2D1Factory1
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_2/nf-d2d1_2-id2d1factory2-createdevice
    HRESULT CreateDevice(IDXGIDevice dxgiDevice, ID2D1Device1* d2dDevice1);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_2/nn-d2d1_2-id2d1commandsink1
@GUID("9eb767fd-4269-4467-b8c2-eb30cb305743")
interface ID2D1CommandSink1 : ID2D1CommandSink
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_2/nf-d2d1_2-id2d1commandsink1-setprimitiveblend1
    HRESULT SetPrimitiveBlend1(D2D1_PRIMITIVE_BLEND primitiveBlend);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nn-d2d1svg-id2d1svgattribute
@GUID("c9cdb0dd-f8c9-4e70-b7c2-301c80292c5e")
interface ID2D1SvgAttribute : ID2D1Resource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgattribute-getelement
    void    GetElement(ID2D1SvgElement* element);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgattribute-clone
    HRESULT Clone(ID2D1SvgAttribute* attribute);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nn-d2d1svg-id2d1svgpaint
@GUID("d59bab0a-68a2-455b-a5dc-9eb2854e2490")
interface ID2D1SvgPaint : ID2D1SvgAttribute
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgpaint-setpainttype
    HRESULT SetPaintType(D2D1_SVG_PAINT_TYPE paintType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgpaint-getpainttype
    D2D1_SVG_PAINT_TYPE GetPaintType();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1svgpaint-setcolor-overload
    HRESULT SetColor(const(D2D1_COLOR_F)* color);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgpaint-getcolor
    void    GetColor(D2D1_COLOR_F* color);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgpaint-setid
    HRESULT SetId(const(PWSTR) id);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgpaint-getid
    HRESULT GetId(PWSTR id, uint idCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgpaint-getidlength
    uint    GetIdLength();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nn-d2d1svg-id2d1svgstrokedasharray
@GUID("f1c0ca52-92a3-4f00-b4ce-f35691efd9d9")
interface ID2D1SvgStrokeDashArray : ID2D1SvgAttribute
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgstrokedasharray-removedashesatend
    HRESULT RemoveDashesAtEnd(uint dashesCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1svgstrokedasharray-updatedashes-overload
    HRESULT UpdateDashes(const(D2D1_SVG_LENGTH)* dashes, uint dashesCount, uint startIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1svgstrokedasharray-updatedashes-overload
    HRESULT UpdateDashes(const(float)* dashes, uint dashesCount, uint startIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1svgstrokedasharray-getdashes-overload
    HRESULT GetDashes(D2D1_SVG_LENGTH* dashes, uint dashesCount, uint startIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1svgstrokedasharray-getdashes-overload
    HRESULT GetDashes(float* dashes, uint dashesCount, uint startIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgstrokedasharray-getdashescount
    uint    GetDashesCount();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nn-d2d1svg-id2d1svgpointcollection
@GUID("9dbe4c0d-3572-4dd9-9825-5530813bb712")
interface ID2D1SvgPointCollection : ID2D1SvgAttribute
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgpointcollection-removepointsatend
    HRESULT RemovePointsAtEnd(uint pointsCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgpointcollection-updatepoints
    HRESULT UpdatePoints(const(D2D_POINT_2F)* points, uint pointsCount, uint startIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgpointcollection-getpoints
    HRESULT GetPoints(D2D_POINT_2F* points, uint pointsCount, uint startIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgpointcollection-getpointscount
    uint    GetPointsCount();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nn-d2d1svg-id2d1svgpathdata
@GUID("c095e4f4-bb98-43d6-9745-4d1b84ec9888")
interface ID2D1SvgPathData : ID2D1SvgAttribute
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgpathdata-removesegmentdataatend
    HRESULT RemoveSegmentDataAtEnd(uint dataCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgpathdata-updatesegmentdata
    HRESULT UpdateSegmentData(const(float)* data, uint dataCount, uint startIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgpathdata-getsegmentdata
    HRESULT GetSegmentData(float* data, uint dataCount, uint startIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgpathdata-getsegmentdatacount
    uint    GetSegmentDataCount();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgpathdata-removecommandsatend
    HRESULT RemoveCommandsAtEnd(uint commandsCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgpathdata-updatecommands
    HRESULT UpdateCommands(const(D2D1_SVG_PATH_COMMAND)* commands, uint commandsCount, uint startIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgpathdata-getcommands
    HRESULT GetCommands(D2D1_SVG_PATH_COMMAND* commands, uint commandsCount, uint startIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgpathdata-getcommandscount
    uint    GetCommandsCount();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgpathdata-createpathgeometry
    HRESULT CreatePathGeometry(D2D1_FILL_MODE fillMode, ID2D1PathGeometry1* pathGeometry);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nn-d2d1svg-id2d1svgelement
@GUID("ac7b67a6-183e-49c1-a823-0ebe40b0db29")
interface ID2D1SvgElement : ID2D1Resource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgelement-getdocument
    void    GetDocument(ID2D1SvgDocument* document);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgelement-gettagname
    HRESULT GetTagName(PWSTR name, uint nameCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgelement-gettagnamelength
    uint    GetTagNameLength();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgelement-istextcontent
    BOOL    IsTextContent();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgelement-getparent
    void    GetParent(ID2D1SvgElement* parent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgelement-haschildren
    BOOL    HasChildren();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgelement-getfirstchild
    void    GetFirstChild(ID2D1SvgElement* child);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgelement-getlastchild
    void    GetLastChild(ID2D1SvgElement* child);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgelement-getpreviouschild
    HRESULT GetPreviousChild(ID2D1SvgElement referenceChild, ID2D1SvgElement* previousChild);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgelement-getnextchild
    HRESULT GetNextChild(ID2D1SvgElement referenceChild, ID2D1SvgElement* nextChild);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgelement-insertchildbefore
    HRESULT InsertChildBefore(ID2D1SvgElement newChild, ID2D1SvgElement referenceChild);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgelement-appendchild
    HRESULT AppendChild(ID2D1SvgElement newChild);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgelement-replacechild
    HRESULT ReplaceChild(ID2D1SvgElement newChild, ID2D1SvgElement oldChild);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgelement-removechild
    HRESULT RemoveChild(ID2D1SvgElement oldChild);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgelement-createchild
    HRESULT CreateChild(const(PWSTR) tagName, ID2D1SvgElement* newChild);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgelement-isattributespecified
    BOOL    IsAttributeSpecified(const(PWSTR) name, BOOL* inherited);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgelement-getspecifiedattributecount
    uint    GetSpecifiedAttributeCount();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgelement-getspecifiedattributename
    HRESULT GetSpecifiedAttributeName(uint index, PWSTR name, uint nameCount, BOOL* inherited);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgelement-getspecifiedattributenamelength
    HRESULT GetSpecifiedAttributeNameLength(uint index, uint* nameLength, BOOL* inherited);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgelement-removeattribute
    HRESULT RemoveAttribute(const(PWSTR) name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgelement-settextvalue
    HRESULT SetTextValue(const(PWSTR) name, uint nameCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgelement-gettextvalue
    HRESULT GetTextValue(PWSTR name, uint nameCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgelement-gettextvaluelength
    uint    GetTextValueLength();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1svgelement-setattributevalue-overload
    HRESULT SetAttributeValue(const(PWSTR) name, ID2D1SvgAttribute value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1svgelement-setattributevalue-overload
    HRESULT SetAttributeValue(const(PWSTR) name, D2D1_SVG_ATTRIBUTE_POD_TYPE type, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(void)* value, 
                              uint valueSizeInBytes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1svgelement-setattributevalue-overload
    HRESULT SetAttributeValue(const(PWSTR) name, D2D1_SVG_ATTRIBUTE_STRING_TYPE type, const(PWSTR) value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1svgelement-getattributevalue-overload
    HRESULT GetAttributeValue(const(PWSTR) name, const(GUID)* riid, void** value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1svgelement-getattributevalue-overload
    HRESULT GetAttributeValue(const(PWSTR) name, D2D1_SVG_ATTRIBUTE_POD_TYPE type, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* value, 
                              uint valueSizeInBytes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1svgelement-getattributevalue-overload
    HRESULT GetAttributeValue(const(PWSTR) name, D2D1_SVG_ATTRIBUTE_STRING_TYPE type, PWSTR value, uint valueCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgelement-getattributevaluelength
    HRESULT GetAttributeValueLength(const(PWSTR) name, D2D1_SVG_ATTRIBUTE_STRING_TYPE type, uint* valueLength);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nn-d2d1svg-id2d1svgdocument
@GUID("86b88e4d-afa4-4d7b-88e4-68a51c4a0aec")
interface ID2D1SvgDocument : ID2D1Resource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgdocument-setviewportsize
    HRESULT SetViewportSize(D2D_SIZE_F viewportSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgdocument-getviewportsize
    D2D_SIZE_F GetViewportSize();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgdocument-setroot
    HRESULT SetRoot(ID2D1SvgElement root);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgdocument-getroot
    void    GetRoot(ID2D1SvgElement* root);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgdocument-findelementbyid
    HRESULT FindElementById(const(PWSTR) id, ID2D1SvgElement* svgElement);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgdocument-serialize
    HRESULT Serialize(IStream outputXmlStream, ID2D1SvgElement subtree);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgdocument-deserialize
    HRESULT Deserialize(IStream inputXmlStream, ID2D1SvgElement* subtree);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Direct2D/id2d1svgdocument-createpaint-overload
    HRESULT CreatePaint(D2D1_SVG_PAINT_TYPE paintType, const(D2D1_COLOR_F)* color, const(PWSTR) id, 
                        ID2D1SvgPaint* paint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgdocument-createstrokedasharray
    HRESULT CreateStrokeDashArray(const(D2D1_SVG_LENGTH)* dashes, uint dashesCount, 
                                  ID2D1SvgStrokeDashArray* strokeDashArray);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgdocument-createpointcollection
    HRESULT CreatePointCollection(const(D2D_POINT_2F)* points, uint pointsCount, 
                                  ID2D1SvgPointCollection* pointCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1svg/nf-d2d1svg-id2d1svgdocument-createpathdata
    HRESULT CreatePathData(const(float)* segmentData, uint segmentDataCount, 
                           const(D2D1_SVG_PATH_COMMAND)* commands, uint commandsCount, ID2D1SvgPathData* pathData);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1inkstyle
@GUID("bae8b344-23fc-4071-8cb5-d05d6f073848")
interface ID2D1InkStyle : ID2D1Resource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1inkstyle-setnibtransform(constd2d1_matrix_3x2_f_)
    void SetNibTransform(const(D2D_MATRIX_3X2_F)* transform);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1inkstyle-getnibtransform
    void GetNibTransform(D2D_MATRIX_3X2_F* transform);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1inkstyle-setnibshape
    void SetNibShape(D2D1_INK_NIB_SHAPE nibShape);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1inkstyle-getnibshape
    D2D1_INK_NIB_SHAPE GetNibShape();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1ink
@GUID("b499923b-7029-478f-a8b3-432c7c5f5312")
interface ID2D1Ink : ID2D1Resource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1ink-setstartpoint(constd2d1_ink_point)
    void    SetStartPoint(const(D2D1_INK_POINT)* startPoint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1ink-getstartpoint
    D2D1_INK_POINT GetStartPoint();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1ink-addsegments
    HRESULT AddSegments(const(D2D1_INK_BEZIER_SEGMENT)* segments, uint segmentsCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1ink-removesegmentsatend
    HRESULT RemoveSegmentsAtEnd(uint segmentsCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1ink-setsegments
    HRESULT SetSegments(uint startSegment, const(D2D1_INK_BEZIER_SEGMENT)* segments, uint segmentsCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1ink-setsegmentatend(constd2d1_ink_bezier_segment)
    HRESULT SetSegmentAtEnd(const(D2D1_INK_BEZIER_SEGMENT)* segment);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1ink-getsegmentcount
    uint    GetSegmentCount();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1ink-getsegments
    HRESULT GetSegments(uint startSegment, D2D1_INK_BEZIER_SEGMENT* segments, uint segmentsCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1ink-streamasgeometry(id2d1inkstyle_constd2d1_matrix_3x2_f__float_id2d1simplifiedgeometrysink)
    HRESULT StreamAsGeometry(ID2D1InkStyle inkStyle, const(D2D_MATRIX_3X2_F)* worldTransform, 
                             float flatteningTolerance, ID2D1SimplifiedGeometrySink geometrySink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1ink-getbounds
    HRESULT GetBounds(ID2D1InkStyle inkStyle, const(D2D_MATRIX_3X2_F)* worldTransform, D2D_RECT_F* bounds);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1gradientmesh
@GUID("f292e401-c050-4cde-83d7-04962d3b23c2")
interface ID2D1GradientMesh : ID2D1Resource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1gradientmesh-getpatchcount
    uint    GetPatchCount();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1gradientmesh-getpatches
    HRESULT GetPatches(uint startIndex, D2D1_GRADIENT_MESH_PATCH* patches, uint patchesCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1imagesource
@GUID("c9b664e5-74a1-4378-9ac2-eefc37a3f4d8")
interface ID2D1ImageSource : ID2D1Image
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1imagesource-offerresources
    HRESULT OfferResources();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1imagesource-tryreclaimresources
    HRESULT TryReclaimResources(BOOL* resourcesDiscarded);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1imagesourcefromwic
@GUID("77395441-1c8f-4555-8683-f50dab0fe792")
interface ID2D1ImageSourceFromWic : ID2D1ImageSource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1imagesourcefromwic-ensurecached(constd2d1_rect_u_)
    HRESULT EnsureCached(const(D2D_RECT_U)* rectangleToFill);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1imagesourcefromwic-trimcache(constd2d1_rect_u)
    HRESULT TrimCache(const(D2D_RECT_U)* rectangleToPreserve);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1imagesourcefromwic-getsource
    void    GetSource(IWICBitmapSource* wicBitmapSource);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1transformedimagesource
@GUID("7f1f79e5-2796-416c-8f55-700f911445e5")
interface ID2D1TransformedImageSource : ID2D1Image
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1transformedimagesource-getsource
    void GetSource(ID2D1ImageSource* imageSource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1transformedimagesource-getproperties
    void GetProperties(D2D1_TRANSFORMED_IMAGE_SOURCE_PROPERTIES* properties);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1lookuptable3d
@GUID("53dd9855-a3b0-4d5b-82e1-26e25c5e5797")
interface ID2D1LookupTable3D : ID2D1Resource
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1devicecontext2
@GUID("394ea6a3-0c34-4321-950b-6ca20f0be6c7")
interface ID2D1DeviceContext2 : ID2D1DeviceContext1
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1devicecontext2-createink(constd2d1_ink_point__id2d1ink)
    HRESULT CreateInk(const(D2D1_INK_POINT)* startPoint, ID2D1Ink* ink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1devicecontext2-createinkstyle(constd2d1_ink_style_properties_id2d1inkstyle)
    HRESULT CreateInkStyle(const(D2D1_INK_STYLE_PROPERTIES)* inkStyleProperties, ID2D1InkStyle* inkStyle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1devicecontext2-creategradientmesh
    HRESULT CreateGradientMesh(const(D2D1_GRADIENT_MESH_PATCH)* patches, uint patchesCount, 
                               ID2D1GradientMesh* gradientMesh);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1devicecontext2-createimagesourcefromwic(iwicbitmapsource_d2d1_image_source_loading_options_id2d1imagesourcefromwic)
    HRESULT CreateImageSourceFromWic(IWICBitmapSource wicBitmapSource, 
                                     D2D1_IMAGE_SOURCE_LOADING_OPTIONS loadingOptions, D2D1_ALPHA_MODE alphaMode, 
                                     ID2D1ImageSourceFromWic* imageSource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1devicecontext2-createlookuptable3d
    HRESULT CreateLookupTable3D(D2D1_BUFFER_PRECISION precision, const(uint)* extents, const(ubyte)* data, 
                                uint dataCount, const(uint)* strides, ID2D1LookupTable3D* lookupTable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1devicecontext2-createimagesourcefromdxgi
    HRESULT CreateImageSourceFromDxgi(IDXGISurface* surfaces, uint surfaceCount, DXGI_COLOR_SPACE_TYPE colorSpace, 
                                      D2D1_IMAGE_SOURCE_FROM_DXGI_OPTIONS options, ID2D1ImageSource* imageSource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1devicecontext2-getgradientmeshworldbounds
    HRESULT GetGradientMeshWorldBounds(ID2D1GradientMesh gradientMesh, D2D_RECT_F* pBounds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1devicecontext2-drawink
    void    DrawInk(ID2D1Ink ink, ID2D1Brush brush, ID2D1InkStyle inkStyle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1devicecontext2-drawgradientmesh
    void    DrawGradientMesh(ID2D1GradientMesh gradientMesh);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1devicecontext2-drawgdimetafile(id2d1gdimetafile_constd2d1_rect_f__constd2d1_rect_f_)
    void    DrawGdiMetafile(ID2D1GdiMetafile gdiMetafile, const(D2D_RECT_F)* destinationRectangle, 
                            const(D2D_RECT_F)* sourceRectangle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1devicecontext2-createtransformedimagesource
    HRESULT CreateTransformedImageSource(ID2D1ImageSource imageSource, 
                                         const(D2D1_TRANSFORMED_IMAGE_SOURCE_PROPERTIES)* properties, 
                                         ID2D1TransformedImageSource* transformedImageSource);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1device2
@GUID("a44472e1-8dfb-4e60-8492-6e2861c9ca8b")
interface ID2D1Device2 : ID2D1Device1
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1device2-createdevicecontext
    HRESULT CreateDeviceContext(D2D1_DEVICE_CONTEXT_OPTIONS options, ID2D1DeviceContext2* deviceContext2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1device2-flushdevicecontexts
    void    FlushDeviceContexts(ID2D1Bitmap bitmap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1device2-getdxgidevice
    HRESULT GetDxgiDevice(IDXGIDevice* dxgiDevice);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1factory3
@GUID("0869759f-4f00-413f-b03e-2bda45404d0f")
interface ID2D1Factory3 : ID2D1Factory2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1factory3-createdevice
    HRESULT CreateDevice(IDXGIDevice dxgiDevice, ID2D1Device2* d2dDevice2);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1commandsink2
@GUID("3bab440e-417e-47df-a2e2-bc0be6a00916")
interface ID2D1CommandSink2 : ID2D1CommandSink1
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1commandsink2-drawink
    HRESULT DrawInk(ID2D1Ink ink, ID2D1Brush brush, ID2D1InkStyle inkStyle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1commandsink2-drawgradientmesh
    HRESULT DrawGradientMesh(ID2D1GradientMesh gradientMesh);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1commandsink2-drawgdimetafile
    HRESULT DrawGdiMetafile(ID2D1GdiMetafile gdiMetafile, const(D2D_RECT_F)* destinationRectangle, 
                            const(D2D_RECT_F)* sourceRectangle);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1gdimetafile1
@GUID("2e69f9e8-dd3f-4bf9-95ba-c04f49d788df")
interface ID2D1GdiMetafile1 : ID2D1GdiMetafile
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1gdimetafile1-getdpi
    HRESULT GetDpi(float* dpiX, float* dpiY);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1gdimetafile1-getsourcebounds
    HRESULT GetSourceBounds(D2D_RECT_F* bounds);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1gdimetafilesink1
@GUID("fd0ecb6b-91e6-411e-8655-395e760f91b4")
interface ID2D1GdiMetafileSink1 : ID2D1GdiMetafileSink
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1gdimetafilesink1-processrecord
    HRESULT ProcessRecord(uint recordType, const(void)* recordData, uint recordDataSize, uint flags);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1spritebatch
@GUID("4dc583bf-3a10-438a-8722-e9765224f1f1")
interface ID2D1SpriteBatch : ID2D1Resource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1spritebatch-addsprites
    HRESULT AddSprites(uint spriteCount, const(D2D_RECT_F)* destinationRectangles, 
                       const(D2D_RECT_U)* sourceRectangles, const(D2D1_COLOR_F)* colors, 
                       const(D2D_MATRIX_3X2_F)* transforms, uint destinationRectanglesStride, 
                       uint sourceRectanglesStride, uint colorsStride, uint transformsStride);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1spritebatch-setsprites
    HRESULT SetSprites(uint startIndex, uint spriteCount, const(D2D_RECT_F)* destinationRectangles, 
                       const(D2D_RECT_U)* sourceRectangles, const(D2D1_COLOR_F)* colors, 
                       const(D2D_MATRIX_3X2_F)* transforms, uint destinationRectanglesStride, 
                       uint sourceRectanglesStride, uint colorsStride, uint transformsStride);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1spritebatch-getsprites
    HRESULT GetSprites(uint startIndex, uint spriteCount, D2D_RECT_F* destinationRectangles, 
                       D2D_RECT_U* sourceRectangles, D2D1_COLOR_F* colors, D2D_MATRIX_3X2_F* transforms);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1spritebatch-getspritecount
    uint    GetSpriteCount();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1spritebatch-clear
    void    Clear();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1devicecontext3
@GUID("235a7496-8351-414c-bcd4-6672ab2d8e00")
interface ID2D1DeviceContext3 : ID2D1DeviceContext2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1devicecontext3-createspritebatch
    HRESULT CreateSpriteBatch(ID2D1SpriteBatch* spriteBatch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1devicecontext3-drawspritebatch(id2d1spritebatch_id2d1bitmap_d2d1_bitmap_interpolation_mode_d2d1_sprite_options)
    void    DrawSpriteBatch(ID2D1SpriteBatch spriteBatch, uint startIndex, uint spriteCount, ID2D1Bitmap bitmap, 
                            D2D1_BITMAP_INTERPOLATION_MODE interpolationMode, D2D1_SPRITE_OPTIONS spriteOptions);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1device3
@GUID("852f2087-802c-4037-ab60-ff2e7ee6fc01")
interface ID2D1Device3 : ID2D1Device2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1device3-createdevicecontext
    HRESULT CreateDeviceContext(D2D1_DEVICE_CONTEXT_OPTIONS options, ID2D1DeviceContext3* deviceContext3);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1factory4
@GUID("bd4ec2d2-0662-4bee-ba8e-6f29f032e096")
interface ID2D1Factory4 : ID2D1Factory3
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1factory4-createdevice
    HRESULT CreateDevice(IDXGIDevice dxgiDevice, ID2D1Device3* d2dDevice3);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1commandsink3
@GUID("18079135-4cf3-4868-bc8e-06067e6d242d")
interface ID2D1CommandSink3 : ID2D1CommandSink2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1commandsink3-drawspritebatch
    HRESULT DrawSpriteBatch(ID2D1SpriteBatch spriteBatch, uint startIndex, uint spriteCount, ID2D1Bitmap bitmap, 
                            D2D1_BITMAP_INTERPOLATION_MODE interpolationMode, D2D1_SPRITE_OPTIONS spriteOptions);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1svgglyphstyle
@GUID("af671749-d241-4db8-8e41-dcc2e5c1a438")
interface ID2D1SvgGlyphStyle : ID2D1Resource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1svgglyphstyle-setfill
    HRESULT SetFill(ID2D1Brush brush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1svgglyphstyle-getfill
    void    GetFill(ID2D1Brush* brush);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1svgglyphstyle-setstroke
    HRESULT SetStroke(ID2D1Brush brush, float strokeWidth, const(float)* dashes, uint dashesCount, 
                      float dashOffset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1svgglyphstyle-getstrokedashescount
    uint    GetStrokeDashesCount();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1svgglyphstyle-getstroke
    void    GetStroke(ID2D1Brush* brush, float* strokeWidth, float* dashes, uint dashesCount, float* dashOffset);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1devicecontext4
@GUID("8c427831-3d90-4476-b647-c4fae349e4db")
interface ID2D1DeviceContext4 : ID2D1DeviceContext3
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1devicecontext4-createsvgglyphstyle
    HRESULT CreateSvgGlyphStyle(ID2D1SvgGlyphStyle* svgGlyphStyle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1devicecontext4-drawtext(constwchar_uint32_idwritetextformat_constd2d1_rect_f_id2d1brush_id2d1svgglyphstyle_uint32_d2d1_draw_text_options_dwrite_measuring_mode)
    void    DrawText(const(PWSTR) string, uint stringLength, IDWriteTextFormat textFormat, 
                     const(D2D_RECT_F)* layoutRect, ID2D1Brush defaultFillBrush, ID2D1SvgGlyphStyle svgGlyphStyle, 
                     uint colorPaletteIndex, D2D1_DRAW_TEXT_OPTIONS options, DWRITE_MEASURING_MODE measuringMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1devicecontext4-drawtextlayout
    void    DrawTextLayout(D2D_POINT_2F origin, IDWriteTextLayout textLayout, ID2D1Brush defaultFillBrush, 
                           ID2D1SvgGlyphStyle svgGlyphStyle, uint colorPaletteIndex, D2D1_DRAW_TEXT_OPTIONS options);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1devicecontext4-drawcolorbitmapglyphrun
    void    DrawColorBitmapGlyphRun(DWRITE_GLYPH_IMAGE_FORMATS glyphImageFormat, D2D_POINT_2F baselineOrigin, 
                                    const(DWRITE_GLYPH_RUN)* glyphRun, DWRITE_MEASURING_MODE measuringMode, 
                                    D2D1_COLOR_BITMAP_GLYPH_SNAP_OPTION bitmapSnapOption);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1devicecontext4-drawsvgglyphrun
    void    DrawSvgGlyphRun(D2D_POINT_2F baselineOrigin, const(DWRITE_GLYPH_RUN)* glyphRun, 
                            ID2D1Brush defaultFillBrush, ID2D1SvgGlyphStyle svgGlyphStyle, uint colorPaletteIndex, 
                            DWRITE_MEASURING_MODE measuringMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1devicecontext4-getcolorbitmapglyphimage
    HRESULT GetColorBitmapGlyphImage(DWRITE_GLYPH_IMAGE_FORMATS glyphImageFormat, D2D_POINT_2F glyphOrigin, 
                                     IDWriteFontFace fontFace, float fontEmSize, ushort glyphIndex, BOOL isSideways, 
                                     const(D2D_MATRIX_3X2_F)* worldTransform, float dpiX, float dpiY, 
                                     D2D_MATRIX_3X2_F* glyphTransform, ID2D1Image* glyphImage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1devicecontext4-getsvgglyphimage
    HRESULT GetSvgGlyphImage(D2D_POINT_2F glyphOrigin, IDWriteFontFace fontFace, float fontEmSize, 
                             ushort glyphIndex, BOOL isSideways, const(D2D_MATRIX_3X2_F)* worldTransform, 
                             ID2D1Brush defaultFillBrush, ID2D1SvgGlyphStyle svgGlyphStyle, uint colorPaletteIndex, 
                             D2D_MATRIX_3X2_F* glyphTransform, ID2D1CommandList* glyphImage);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1device4
@GUID("d7bdb159-5683-4a46-bc9c-72dc720b858b")
interface ID2D1Device4 : ID2D1Device3
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1device4-createdevicecontext
    HRESULT CreateDeviceContext(D2D1_DEVICE_CONTEXT_OPTIONS options, ID2D1DeviceContext4* deviceContext4);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1device4-setmaximumcolorglyphcachememory
    void    SetMaximumColorGlyphCacheMemory(ulong maximumInBytes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1device4-getmaximumcolorglyphcachememory
    ulong   GetMaximumColorGlyphCacheMemory();
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1factory5
@GUID("c4349994-838e-4b0f-8cab-44997d9eeacc")
interface ID2D1Factory5 : ID2D1Factory4
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1factory5-createdevice
    HRESULT CreateDevice(IDXGIDevice dxgiDevice, ID2D1Device4* d2dDevice4);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1commandsink4
@GUID("c78a6519-40d6-4218-b2de-beeeb744bb3e")
interface ID2D1CommandSink4 : ID2D1CommandSink3
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1commandsink4-setprimitiveblend2
    HRESULT SetPrimitiveBlend2(D2D1_PRIMITIVE_BLEND primitiveBlend);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1colorcontext1
@GUID("1ab42875-c57f-4be9-bd85-9cd78d6f55ee")
interface ID2D1ColorContext1 : ID2D1ColorContext
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1colorcontext1-getcolorcontexttype
    D2D1_COLOR_CONTEXT_TYPE GetColorContextType();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1colorcontext1-getdxgicolorspace
    DXGI_COLOR_SPACE_TYPE GetDXGIColorSpace();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1colorcontext1-getsimplecolorprofile
    HRESULT GetSimpleColorProfile(D2D1_SIMPLE_COLOR_PROFILE* simpleProfile);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1devicecontext5
@GUID("7836d248-68cc-4df6-b9e8-de991bf62eb7")
interface ID2D1DeviceContext5 : ID2D1DeviceContext4
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1devicecontext5-createsvgdocument
    HRESULT CreateSvgDocument(IStream inputXmlStream, D2D_SIZE_F viewportSize, ID2D1SvgDocument* svgDocument);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1devicecontext5-drawsvgdocument
    void    DrawSvgDocument(ID2D1SvgDocument svgDocument);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1devicecontext5-createcolorcontextfromdxgicolorspace
    HRESULT CreateColorContextFromDxgiColorSpace(DXGI_COLOR_SPACE_TYPE colorSpace, 
                                                 ID2D1ColorContext1* colorContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1devicecontext5-createcolorcontextfromsimplecolorprofile(constd2d1_simple_color_profile__id2d1colorcontext1)
    HRESULT CreateColorContextFromSimpleColorProfile(const(D2D1_SIMPLE_COLOR_PROFILE)* simpleProfile, 
                                                     ID2D1ColorContext1* colorContext);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1device5
@GUID("d55ba0a4-6405-4694-aef5-08ee1a4358b4")
interface ID2D1Device5 : ID2D1Device4
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1device5-createdevicecontext
    HRESULT CreateDeviceContext(D2D1_DEVICE_CONTEXT_OPTIONS options, ID2D1DeviceContext5* deviceContext5);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1factory6
@GUID("f9976f46-f642-44c1-97ca-da32ea2a2635")
interface ID2D1Factory6 : ID2D1Factory5
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1factory6-createdevice
    HRESULT CreateDevice(IDXGIDevice dxgiDevice, ID2D1Device5* d2dDevice5);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1commandsink5
@GUID("7047dd26-b1e7-44a7-959a-8349e2144fa8")
interface ID2D1CommandSink5 : ID2D1CommandSink4
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1commandsink5-blendimage
    HRESULT BlendImage(ID2D1Image image, D2D1_BLEND_MODE blendMode, const(D2D_POINT_2F)* targetOffset, 
                       const(D2D_RECT_F)* imageRectangle, D2D1_INTERPOLATION_MODE interpolationMode);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1devicecontext6
@GUID("985f7e37-4ed0-4a19-98a3-15b0edfde306")
interface ID2D1DeviceContext6 : ID2D1DeviceContext5
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1devicecontext6-blendimage
    void BlendImage(ID2D1Image image, D2D1_BLEND_MODE blendMode, const(D2D_POINT_2F)* targetOffset, 
                    const(D2D_RECT_F)* imageRectangle, D2D1_INTERPOLATION_MODE interpolationMode);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1device6
@GUID("7bfef914-2d75-4bad-be87-e18ddb077b6d")
interface ID2D1Device6 : ID2D1Device5
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1device6-createdevicecontext
    HRESULT CreateDeviceContext(D2D1_DEVICE_CONTEXT_OPTIONS options, ID2D1DeviceContext6* deviceContext6);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nn-d2d1_3-id2d1factory7
@GUID("bdc2bdd3-b96c-4de6-bdf7-99d4745454de")
interface ID2D1Factory7 : ID2D1Factory6
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1_3/nf-d2d1_3-id2d1factory7-createdevice
    HRESULT CreateDevice(IDXGIDevice dxgiDevice, ID2D1Device6* d2dDevice6);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("ec891cf7-9b69-4851-9def-4e0915771e62")
interface ID2D1DeviceContext7 : ID2D1DeviceContext6
{
    DWRITE_PAINT_FEATURE_LEVEL GetPaintFeatureLevel();
    void DrawPaintGlyphRun(D2D_POINT_2F baselineOrigin, const(DWRITE_GLYPH_RUN)* glyphRun, 
                           ID2D1Brush defaultFillBrush, uint colorPaletteIndex, DWRITE_MEASURING_MODE measuringMode);
    void DrawGlyphRunWithColorSupport(D2D_POINT_2F baselineOrigin, const(DWRITE_GLYPH_RUN)* glyphRun, 
                                      const(DWRITE_GLYPH_RUN_DESCRIPTION)* glyphRunDescription, 
                                      ID2D1Brush foregroundBrush, ID2D1SvgGlyphStyle svgGlyphStyle, 
                                      uint colorPaletteIndex, DWRITE_MEASURING_MODE measuringMode, 
                                      D2D1_COLOR_BITMAP_GLYPH_SNAP_OPTION bitmapSnapOption);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("f07c8968-dd4e-4ba6-9cbd-eb6d3752dcbb")
interface ID2D1Device7 : ID2D1Device6
{
    HRESULT CreateDeviceContext(D2D1_DEVICE_CONTEXT_OPTIONS options, ID2D1DeviceContext7* deviceContext);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("677c9311-f36d-4b1f-ae86-86d1223ffd3a")
interface ID2D1Factory8 : ID2D1Factory7
{
    HRESULT CreateDevice(IDXGIDevice dxgiDevice, ID2D1Device7* d2dDevice6);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor_1/nn-d2d1effectauthor_1-id2d1effectcontext1
@GUID("84ab595a-fc81-4546-bacd-e8ef4d8abe7a")
interface ID2D1EffectContext1 : ID2D1EffectContext
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/d2d1effectauthor_1/nf-d2d1effectauthor_1-id2d1effectcontext1-createlookuptable3d
    HRESULT CreateLookupTable3D(D2D1_BUFFER_PRECISION precision, const(uint)* extents, const(ubyte)* data, 
                                uint dataCount, const(uint)* strides, ID2D1LookupTable3D* lookupTable);
}

//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
@GUID("577ad2a0-9fc7-4dda-8b18-dab810140052")
interface ID2D1EffectContext2 : ID2D1EffectContext1
{
    HRESULT CreateColorContextFromDxgiColorSpace(DXGI_COLOR_SPACE_TYPE colorSpace, 
                                                 ID2D1ColorContext1* colorContext);
    HRESULT CreateColorContextFromSimpleColorProfile(const(D2D1_SIMPLE_COLOR_PROFILE)* simpleProfile, 
                                                     ID2D1ColorContext1* colorContext);
}


// GUIDs


const GUID IID_ID2D1AnalysisTransform         = GUIDOF!ID2D1AnalysisTransform;
const GUID IID_ID2D1Bitmap                    = GUIDOF!ID2D1Bitmap;
const GUID IID_ID2D1Bitmap1                   = GUIDOF!ID2D1Bitmap1;
const GUID IID_ID2D1BitmapBrush               = GUIDOF!ID2D1BitmapBrush;
const GUID IID_ID2D1BitmapBrush1              = GUIDOF!ID2D1BitmapBrush1;
const GUID IID_ID2D1BitmapRenderTarget        = GUIDOF!ID2D1BitmapRenderTarget;
const GUID IID_ID2D1BlendTransform            = GUIDOF!ID2D1BlendTransform;
const GUID IID_ID2D1BorderTransform           = GUIDOF!ID2D1BorderTransform;
const GUID IID_ID2D1BoundsAdjustmentTransform = GUIDOF!ID2D1BoundsAdjustmentTransform;
const GUID IID_ID2D1Brush                     = GUIDOF!ID2D1Brush;
const GUID IID_ID2D1ColorContext              = GUIDOF!ID2D1ColorContext;
const GUID IID_ID2D1ColorContext1             = GUIDOF!ID2D1ColorContext1;
const GUID IID_ID2D1CommandList               = GUIDOF!ID2D1CommandList;
const GUID IID_ID2D1CommandSink               = GUIDOF!ID2D1CommandSink;
const GUID IID_ID2D1CommandSink1              = GUIDOF!ID2D1CommandSink1;
const GUID IID_ID2D1CommandSink2              = GUIDOF!ID2D1CommandSink2;
const GUID IID_ID2D1CommandSink3              = GUIDOF!ID2D1CommandSink3;
const GUID IID_ID2D1CommandSink4              = GUIDOF!ID2D1CommandSink4;
const GUID IID_ID2D1CommandSink5              = GUIDOF!ID2D1CommandSink5;
const GUID IID_ID2D1ComputeInfo               = GUIDOF!ID2D1ComputeInfo;
const GUID IID_ID2D1ComputeTransform          = GUIDOF!ID2D1ComputeTransform;
const GUID IID_ID2D1ConcreteTransform         = GUIDOF!ID2D1ConcreteTransform;
const GUID IID_ID2D1DCRenderTarget            = GUIDOF!ID2D1DCRenderTarget;
const GUID IID_ID2D1Device                    = GUIDOF!ID2D1Device;
const GUID IID_ID2D1Device1                   = GUIDOF!ID2D1Device1;
const GUID IID_ID2D1Device2                   = GUIDOF!ID2D1Device2;
const GUID IID_ID2D1Device3                   = GUIDOF!ID2D1Device3;
const GUID IID_ID2D1Device4                   = GUIDOF!ID2D1Device4;
const GUID IID_ID2D1Device5                   = GUIDOF!ID2D1Device5;
const GUID IID_ID2D1Device6                   = GUIDOF!ID2D1Device6;
const GUID IID_ID2D1Device7                   = GUIDOF!ID2D1Device7;
const GUID IID_ID2D1DeviceContext             = GUIDOF!ID2D1DeviceContext;
const GUID IID_ID2D1DeviceContext1            = GUIDOF!ID2D1DeviceContext1;
const GUID IID_ID2D1DeviceContext2            = GUIDOF!ID2D1DeviceContext2;
const GUID IID_ID2D1DeviceContext3            = GUIDOF!ID2D1DeviceContext3;
const GUID IID_ID2D1DeviceContext4            = GUIDOF!ID2D1DeviceContext4;
const GUID IID_ID2D1DeviceContext5            = GUIDOF!ID2D1DeviceContext5;
const GUID IID_ID2D1DeviceContext6            = GUIDOF!ID2D1DeviceContext6;
const GUID IID_ID2D1DeviceContext7            = GUIDOF!ID2D1DeviceContext7;
const GUID IID_ID2D1DrawInfo                  = GUIDOF!ID2D1DrawInfo;
const GUID IID_ID2D1DrawTransform             = GUIDOF!ID2D1DrawTransform;
const GUID IID_ID2D1DrawingStateBlock         = GUIDOF!ID2D1DrawingStateBlock;
const GUID IID_ID2D1DrawingStateBlock1        = GUIDOF!ID2D1DrawingStateBlock1;
const GUID IID_ID2D1Effect                    = GUIDOF!ID2D1Effect;
const GUID IID_ID2D1EffectContext             = GUIDOF!ID2D1EffectContext;
const GUID IID_ID2D1EffectContext1            = GUIDOF!ID2D1EffectContext1;
const GUID IID_ID2D1EffectContext2            = GUIDOF!ID2D1EffectContext2;
const GUID IID_ID2D1EffectImpl                = GUIDOF!ID2D1EffectImpl;
const GUID IID_ID2D1EllipseGeometry           = GUIDOF!ID2D1EllipseGeometry;
const GUID IID_ID2D1Factory                   = GUIDOF!ID2D1Factory;
const GUID IID_ID2D1Factory1                  = GUIDOF!ID2D1Factory1;
const GUID IID_ID2D1Factory2                  = GUIDOF!ID2D1Factory2;
const GUID IID_ID2D1Factory3                  = GUIDOF!ID2D1Factory3;
const GUID IID_ID2D1Factory4                  = GUIDOF!ID2D1Factory4;
const GUID IID_ID2D1Factory5                  = GUIDOF!ID2D1Factory5;
const GUID IID_ID2D1Factory6                  = GUIDOF!ID2D1Factory6;
const GUID IID_ID2D1Factory7                  = GUIDOF!ID2D1Factory7;
const GUID IID_ID2D1Factory8                  = GUIDOF!ID2D1Factory8;
const GUID IID_ID2D1GdiInteropRenderTarget    = GUIDOF!ID2D1GdiInteropRenderTarget;
const GUID IID_ID2D1GdiMetafile               = GUIDOF!ID2D1GdiMetafile;
const GUID IID_ID2D1GdiMetafile1              = GUIDOF!ID2D1GdiMetafile1;
const GUID IID_ID2D1GdiMetafileSink           = GUIDOF!ID2D1GdiMetafileSink;
const GUID IID_ID2D1GdiMetafileSink1          = GUIDOF!ID2D1GdiMetafileSink1;
const GUID IID_ID2D1Geometry                  = GUIDOF!ID2D1Geometry;
const GUID IID_ID2D1GeometryGroup             = GUIDOF!ID2D1GeometryGroup;
const GUID IID_ID2D1GeometryRealization       = GUIDOF!ID2D1GeometryRealization;
const GUID IID_ID2D1GeometrySink              = GUIDOF!ID2D1GeometrySink;
const GUID IID_ID2D1GradientMesh              = GUIDOF!ID2D1GradientMesh;
const GUID IID_ID2D1GradientStopCollection    = GUIDOF!ID2D1GradientStopCollection;
const GUID IID_ID2D1GradientStopCollection1   = GUIDOF!ID2D1GradientStopCollection1;
const GUID IID_ID2D1HwndRenderTarget          = GUIDOF!ID2D1HwndRenderTarget;
const GUID IID_ID2D1Image                     = GUIDOF!ID2D1Image;
const GUID IID_ID2D1ImageBrush                = GUIDOF!ID2D1ImageBrush;
const GUID IID_ID2D1ImageSource               = GUIDOF!ID2D1ImageSource;
const GUID IID_ID2D1ImageSourceFromWic        = GUIDOF!ID2D1ImageSourceFromWic;
const GUID IID_ID2D1Ink                       = GUIDOF!ID2D1Ink;
const GUID IID_ID2D1InkStyle                  = GUIDOF!ID2D1InkStyle;
const GUID IID_ID2D1Layer                     = GUIDOF!ID2D1Layer;
const GUID IID_ID2D1LinearGradientBrush       = GUIDOF!ID2D1LinearGradientBrush;
const GUID IID_ID2D1LookupTable3D             = GUIDOF!ID2D1LookupTable3D;
const GUID IID_ID2D1Mesh                      = GUIDOF!ID2D1Mesh;
const GUID IID_ID2D1Multithread               = GUIDOF!ID2D1Multithread;
const GUID IID_ID2D1OffsetTransform           = GUIDOF!ID2D1OffsetTransform;
const GUID IID_ID2D1PathGeometry              = GUIDOF!ID2D1PathGeometry;
const GUID IID_ID2D1PathGeometry1             = GUIDOF!ID2D1PathGeometry1;
const GUID IID_ID2D1PrintControl              = GUIDOF!ID2D1PrintControl;
const GUID IID_ID2D1Properties                = GUIDOF!ID2D1Properties;
const GUID IID_ID2D1RadialGradientBrush       = GUIDOF!ID2D1RadialGradientBrush;
const GUID IID_ID2D1RectangleGeometry         = GUIDOF!ID2D1RectangleGeometry;
const GUID IID_ID2D1RenderInfo                = GUIDOF!ID2D1RenderInfo;
const GUID IID_ID2D1RenderTarget              = GUIDOF!ID2D1RenderTarget;
const GUID IID_ID2D1Resource                  = GUIDOF!ID2D1Resource;
const GUID IID_ID2D1ResourceTexture           = GUIDOF!ID2D1ResourceTexture;
const GUID IID_ID2D1RoundedRectangleGeometry  = GUIDOF!ID2D1RoundedRectangleGeometry;
const GUID IID_ID2D1SolidColorBrush           = GUIDOF!ID2D1SolidColorBrush;
const GUID IID_ID2D1SourceTransform           = GUIDOF!ID2D1SourceTransform;
const GUID IID_ID2D1SpriteBatch               = GUIDOF!ID2D1SpriteBatch;
const GUID IID_ID2D1StrokeStyle               = GUIDOF!ID2D1StrokeStyle;
const GUID IID_ID2D1StrokeStyle1              = GUIDOF!ID2D1StrokeStyle1;
const GUID IID_ID2D1SvgAttribute              = GUIDOF!ID2D1SvgAttribute;
const GUID IID_ID2D1SvgDocument               = GUIDOF!ID2D1SvgDocument;
const GUID IID_ID2D1SvgElement                = GUIDOF!ID2D1SvgElement;
const GUID IID_ID2D1SvgGlyphStyle             = GUIDOF!ID2D1SvgGlyphStyle;
const GUID IID_ID2D1SvgPaint                  = GUIDOF!ID2D1SvgPaint;
const GUID IID_ID2D1SvgPathData               = GUIDOF!ID2D1SvgPathData;
const GUID IID_ID2D1SvgPointCollection        = GUIDOF!ID2D1SvgPointCollection;
const GUID IID_ID2D1SvgStrokeDashArray        = GUIDOF!ID2D1SvgStrokeDashArray;
const GUID IID_ID2D1TessellationSink          = GUIDOF!ID2D1TessellationSink;
const GUID IID_ID2D1Transform                 = GUIDOF!ID2D1Transform;
const GUID IID_ID2D1TransformGraph            = GUIDOF!ID2D1TransformGraph;
const GUID IID_ID2D1TransformNode             = GUIDOF!ID2D1TransformNode;
const GUID IID_ID2D1TransformedGeometry       = GUIDOF!ID2D1TransformedGeometry;
const GUID IID_ID2D1TransformedImageSource    = GUIDOF!ID2D1TransformedImageSource;
const GUID IID_ID2D1VertexBuffer              = GUIDOF!ID2D1VertexBuffer;
