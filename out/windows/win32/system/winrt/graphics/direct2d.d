// Written in the D programming language.

module windows.win32.system.winrt.graphics.direct2d;

public import windows.core;
public import system : Guid;
public import windows.foundation : IPropertyValue;
public import windows.graphics.effects : IGraphicsEffectSource;
public import windows.win32.foundation : HRESULT, PWSTR;
public import windows.win32.graphics.direct2d : ID2D1Factory, ID2D1Geometry;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.graphics.effects.interop/ne-windows-graphics-effects-interop-graphics_effect_property_mapping))], [])
alias GRAPHICS_EFFECT_PROPERTY_MAPPING = int;
enum : int
{
    GRAPHICS_EFFECT_PROPERTY_MAPPING_UNKNOWN                = 0x00000000,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_DIRECT                 = 0x00000001,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_VECTORX                = 0x00000002,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_VECTORY                = 0x00000003,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_VECTORZ                = 0x00000004,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_VECTORW                = 0x00000005,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_RECT_TO_VECTOR4        = 0x00000006,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_RADIANS_TO_DEGREES     = 0x00000007,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_COLORMATRIX_ALPHA_MODE = 0x00000008,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_COLOR_TO_VECTOR3       = 0x00000009,
    GRAPHICS_EFFECT_PROPERTY_MAPPING_COLOR_TO_VECTOR4       = 0x0000000a,
}

// Interfaces

@GUID("0657af73-53fd-47cf-84ff-c8492d2a80a3")
interface IGeometrySource2DInterop : IUnknown
{
    HRESULT GetGeometry(ID2D1Geometry* value);
    HRESULT TryGetGeometryUsingFactory(ID2D1Factory factory, ID2D1Geometry* value);
}


// GUIDs


const GUID IID_IGeometrySource2DInterop = GUIDOF!IGeometrySource2DInterop;
