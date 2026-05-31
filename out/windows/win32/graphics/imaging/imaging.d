// Written in the D programming language.

module windows.win32.graphics.imaging.imaging;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOL, GENERIC_ACCESS_RIGHTS, HANDLE,
                                                    HRESULT, PWSTR;
public import windows.win32.graphics.direct2d.common : D2D1_PIXEL_FORMAT;
public import windows.win32.graphics.dxgi.common : DXGI_FORMAT, DXGI_JPEG_AC_HUFFMAN_TABLE,
                                                   DXGI_JPEG_DC_HUFFMAN_TABLE,
                                                   DXGI_JPEG_QUANTIZATION_TABLE;
public import windows.win32.graphics.gdi : HBITMAP, HPALETTE;
public import windows.win32.system.com.com : IEnumString, IEnumUnknown, IPersistStream,
                                             IStream, IUnknown;
public import windows.win32.system.com.structuredstorage : IPropertyBag2, PROPBAG2, PROPVARIANT;
public import windows.win32.ui.windowsandmessaging : HICON;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wiccolorcontexttype
enum WICColorContextType : int
{
    WICColorContextUninitialized  = 0x00000000,
    WICColorContextProfile        = 0x00000001,
    WICColorContextExifColorSpace = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicbitmapcreatecacheoption
enum WICBitmapCreateCacheOption : int
{
    WICBitmapNoCache       = 0x00000000,
    WICBitmapCacheOnDemand = 0x00000001,
    WICBitmapCacheOnLoad   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicdecodeoptions
enum WICDecodeOptions : int
{
    WICDecodeMetadataCacheOnDemand = 0x00000000,
    WICDecodeMetadataCacheOnLoad   = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicbitmapencodercacheoption
enum WICBitmapEncoderCacheOption : int
{
    WICBitmapEncoderCacheInMemory = 0x00000000,
    WICBitmapEncoderCacheTempFile = 0x00000001,
    WICBitmapEncoderNoCache       = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wiccomponenttype
enum WICComponentType : int
{
    WICDecoder              = 0x00000001,
    WICEncoder              = 0x00000002,
    WICPixelFormatConverter = 0x00000004,
    WICMetadataReader       = 0x00000008,
    WICMetadataWriter       = 0x00000010,
    WICPixelFormat          = 0x00000020,
    WICAllComponents        = 0x0000003f,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wiccomponentenumerateoptions
enum WICComponentEnumerateOptions : int
{
    WICComponentEnumerateDefault     = 0x00000000,
    WICComponentEnumerateRefresh     = 0x00000001,
    WICComponentEnumerateDisabled    = 0x80000000,
    WICComponentEnumerateUnsigned    = 0x40000000,
    WICComponentEnumerateBuiltInOnly = 0x20000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicbitmapinterpolationmode
enum WICBitmapInterpolationMode : int
{
    WICBitmapInterpolationModeNearestNeighbor  = 0x00000000,
    WICBitmapInterpolationModeLinear           = 0x00000001,
    WICBitmapInterpolationModeCubic            = 0x00000002,
    WICBitmapInterpolationModeFant             = 0x00000003,
    WICBitmapInterpolationModeHighQualityCubic = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicbitmappalettetype
enum WICBitmapPaletteType : int
{
    WICBitmapPaletteTypeCustom           = 0x00000000,
    WICBitmapPaletteTypeMedianCut        = 0x00000001,
    WICBitmapPaletteTypeFixedBW          = 0x00000002,
    WICBitmapPaletteTypeFixedHalftone8   = 0x00000003,
    WICBitmapPaletteTypeFixedHalftone27  = 0x00000004,
    WICBitmapPaletteTypeFixedHalftone64  = 0x00000005,
    WICBitmapPaletteTypeFixedHalftone125 = 0x00000006,
    WICBitmapPaletteTypeFixedHalftone216 = 0x00000007,
    WICBitmapPaletteTypeFixedWebPalette  = 0x00000007,
    WICBitmapPaletteTypeFixedHalftone252 = 0x00000008,
    WICBitmapPaletteTypeFixedHalftone256 = 0x00000009,
    WICBitmapPaletteTypeFixedGray4       = 0x0000000a,
    WICBitmapPaletteTypeFixedGray16      = 0x0000000b,
    WICBitmapPaletteTypeFixedGray256     = 0x0000000c,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicbitmapdithertype
enum WICBitmapDitherType : int
{
    WICBitmapDitherTypeNone           = 0x00000000,
    WICBitmapDitherTypeSolid          = 0x00000000,
    WICBitmapDitherTypeOrdered4x4     = 0x00000001,
    WICBitmapDitherTypeOrdered8x8     = 0x00000002,
    WICBitmapDitherTypeOrdered16x16   = 0x00000003,
    WICBitmapDitherTypeSpiral4x4      = 0x00000004,
    WICBitmapDitherTypeSpiral8x8      = 0x00000005,
    WICBitmapDitherTypeDualSpiral4x4  = 0x00000006,
    WICBitmapDitherTypeDualSpiral8x8  = 0x00000007,
    WICBitmapDitherTypeErrorDiffusion = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicbitmapalphachanneloption
enum WICBitmapAlphaChannelOption : int
{
    WICBitmapUseAlpha              = 0x00000000,
    WICBitmapUsePremultipliedAlpha = 0x00000001,
    WICBitmapIgnoreAlpha           = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicbitmaptransformoptions
enum WICBitmapTransformOptions : int
{
    WICBitmapTransformRotate0        = 0x00000000,
    WICBitmapTransformRotate90       = 0x00000001,
    WICBitmapTransformRotate180      = 0x00000002,
    WICBitmapTransformRotate270      = 0x00000003,
    WICBitmapTransformFlipHorizontal = 0x00000008,
    WICBitmapTransformFlipVertical   = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicbitmaplockflags
enum WICBitmapLockFlags : int
{
    WICBitmapLockRead  = 0x00000001,
    WICBitmapLockWrite = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicbitmapdecodercapabilities
enum WICBitmapDecoderCapabilities : int
{
    WICBitmapDecoderCapabilitySameEncoder          = 0x00000001,
    WICBitmapDecoderCapabilityCanDecodeAllImages   = 0x00000002,
    WICBitmapDecoderCapabilityCanDecodeSomeImages  = 0x00000004,
    WICBitmapDecoderCapabilityCanEnumerateMetadata = 0x00000008,
    WICBitmapDecoderCapabilityCanDecodeThumbnail   = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicprogressoperation
enum WICProgressOperation : int
{
    WICProgressOperationCopyPixels  = 0x00000001,
    WICProgressOperationWritePixels = 0x00000002,
    WICProgressOperationAll         = 0x0000ffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicprogressnotification
enum WICProgressNotification : int
{
    WICProgressNotificationBegin    = 0x00010000,
    WICProgressNotificationEnd      = 0x00020000,
    WICProgressNotificationFrequent = 0x00040000,
    WICProgressNotificationAll      = 0xffff0000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wiccomponentsigning
enum WICComponentSigning : int
{
    WICComponentSigned   = 0x00000001,
    WICComponentUnsigned = 0x00000002,
    WICComponentSafe     = 0x00000004,
    WICComponentDisabled = 0x80000000,
}

enum WICBitmapToneMappingMode : int
{
    WICBitmapToneMappingMode_None    = 0x00000000,
    WICBitmapToneMappingMode_Default = 0x00000001,
    WICBitmapToneMappingMode_D2D     = 0x00000002,
    WICBitmapToneMappingMode_GainMap = 0x00000003,
}

enum WICBitmapChainType : int
{
    WICBitmapChainType_Alternate = 0x00000001,
    WICBitmapChainType_Layer     = 0x00000002,
    WICBitmapChainType_Preview   = 0x00000003,
    WICBitmapChainType_Thumbnail = 0x00000004,
    WICBitmapChainType_AlphaMap  = 0x00000005,
    WICBitmapChainType_DepthMap  = 0x00000006,
    WICBitmapChainType_GainMap   = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicgiflogicalscreendescriptorproperties
enum WICGifLogicalScreenDescriptorProperties : int
{
    WICGifLogicalScreenSignature                      = 0x00000001,
    WICGifLogicalScreenDescriptorWidth                = 0x00000002,
    WICGifLogicalScreenDescriptorHeight               = 0x00000003,
    WICGifLogicalScreenDescriptorGlobalColorTableFlag = 0x00000004,
    WICGifLogicalScreenDescriptorColorResolution      = 0x00000005,
    WICGifLogicalScreenDescriptorSortFlag             = 0x00000006,
    WICGifLogicalScreenDescriptorGlobalColorTableSize = 0x00000007,
    WICGifLogicalScreenDescriptorBackgroundColorIndex = 0x00000008,
    WICGifLogicalScreenDescriptorPixelAspectRatio     = 0x00000009,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicgifimagedescriptorproperties
enum WICGifImageDescriptorProperties : int
{
    WICGifImageDescriptorLeft                = 0x00000001,
    WICGifImageDescriptorTop                 = 0x00000002,
    WICGifImageDescriptorWidth               = 0x00000003,
    WICGifImageDescriptorHeight              = 0x00000004,
    WICGifImageDescriptorLocalColorTableFlag = 0x00000005,
    WICGifImageDescriptorInterlaceFlag       = 0x00000006,
    WICGifImageDescriptorSortFlag            = 0x00000007,
    WICGifImageDescriptorLocalColorTableSize = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicgifgraphiccontrolextensionproperties
enum WICGifGraphicControlExtensionProperties : int
{
    WICGifGraphicControlExtensionDisposal              = 0x00000001,
    WICGifGraphicControlExtensionUserInputFlag         = 0x00000002,
    WICGifGraphicControlExtensionTransparencyFlag      = 0x00000003,
    WICGifGraphicControlExtensionDelay                 = 0x00000004,
    WICGifGraphicControlExtensionTransparentColorIndex = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicgifapplicationextensionproperties
enum WICGifApplicationExtensionProperties : int
{
    WICGifApplicationExtensionApplication = 0x00000001,
    WICGifApplicationExtensionData        = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicgifcommentextensionproperties
enum WICGifCommentExtensionProperties : int
{
    WICGifCommentExtensionText = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicjpegcommentproperties
enum WICJpegCommentProperties : int
{
    WICJpegCommentText = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicjpegluminanceproperties
enum WICJpegLuminanceProperties : int
{
    WICJpegLuminanceTable = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicjpegchrominanceproperties
enum WICJpegChrominanceProperties : int
{
    WICJpegChrominanceTable = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wic8bimiptcproperties
enum WIC8BIMIptcProperties : int
{
    WIC8BIMIptcPString      = 0x00000000,
    WIC8BIMIptcEmbeddedIPTC = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wic8bimresolutioninfoproperties
enum WIC8BIMResolutionInfoProperties : int
{
    WIC8BIMResolutionInfoPString         = 0x00000001,
    WIC8BIMResolutionInfoHResolution     = 0x00000002,
    WIC8BIMResolutionInfoHResolutionUnit = 0x00000003,
    WIC8BIMResolutionInfoWidthUnit       = 0x00000004,
    WIC8BIMResolutionInfoVResolution     = 0x00000005,
    WIC8BIMResolutionInfoVResolutionUnit = 0x00000006,
    WIC8BIMResolutionInfoHeightUnit      = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wic8bimiptcdigestproperties
enum WIC8BIMIptcDigestProperties : int
{
    WIC8BIMIptcDigestPString    = 0x00000001,
    WIC8BIMIptcDigestIptcDigest = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicpnggamaproperties
enum WICPngGamaProperties : int
{
    WICPngGamaGamma = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicpngbkgdproperties
enum WICPngBkgdProperties : int
{
    WICPngBkgdBackgroundColor = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicpngitxtproperties
enum WICPngItxtProperties : int
{
    WICPngItxtKeyword           = 0x00000001,
    WICPngItxtCompressionFlag   = 0x00000002,
    WICPngItxtLanguageTag       = 0x00000003,
    WICPngItxtTranslatedKeyword = 0x00000004,
    WICPngItxtText              = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicpngchrmproperties
enum WICPngChrmProperties : int
{
    WICPngChrmWhitePointX = 0x00000001,
    WICPngChrmWhitePointY = 0x00000002,
    WICPngChrmRedX        = 0x00000003,
    WICPngChrmRedY        = 0x00000004,
    WICPngChrmGreenX      = 0x00000005,
    WICPngChrmGreenY      = 0x00000006,
    WICPngChrmBlueX       = 0x00000007,
    WICPngChrmBlueY       = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicpnghistproperties
enum WICPngHistProperties : int
{
    WICPngHistFrequencies = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicpngiccpproperties
enum WICPngIccpProperties : int
{
    WICPngIccpProfileName = 0x00000001,
    WICPngIccpProfileData = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicpngsrgbproperties
enum WICPngSrgbProperties : int
{
    WICPngSrgbRenderingIntent = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicpngtimeproperties
enum WICPngTimeProperties : int
{
    WICPngTimeYear   = 0x00000001,
    WICPngTimeMonth  = 0x00000002,
    WICPngTimeDay    = 0x00000003,
    WICPngTimeHour   = 0x00000004,
    WICPngTimeMinute = 0x00000005,
    WICPngTimeSecond = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicheifproperties
enum WICHeifProperties : int
{
    WICHeifOrientation                = 0x00000001,
    WICHeifLayeredImageCanvasColor    = 0x00000002,
    WICHeifLayeredImageLayerPositions = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicheifhdrproperties
enum WICHeifHdrProperties : int
{
    WICHeifHdrMaximumLuminanceLevel                 = 0x00000001,
    WICHeifHdrMaximumFrameAverageLuminanceLevel     = 0x00000002,
    WICHeifHdrMinimumMasteringDisplayLuminanceLevel = 0x00000003,
    WICHeifHdrMaximumMasteringDisplayLuminanceLevel = 0x00000004,
    WICHeifHdrCustomVideoPrimaries                  = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicwebpanimproperties
enum WICWebpAnimProperties : int
{
    WICWebpAnimLoopCount = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicwebpanmfproperties
enum WICWebpAnmfProperties : int
{
    WICWebpAnmfFrameDuration = 0x00000001,
}

enum WICJpegXLAnimProperties : int
{
    WICJpegXLAnimLoopCount                      = 0x00000001,
    WICJpegXLAnimFrameTicksPerSecondNumerator   = 0x00000002,
    WICJpegXLAnimFrameTicksPerSecondDenominator = 0x00000003,
}

enum WICJpegXLAnimFrameProperties : int
{
    WICJpegXLAnimFrameDurationInTicks = 0x00000001,
    WICJpegXLAnimFrameName            = 0x00000002,
}

enum WICGainMapProperties : int
{
    WICGainMapMetadata = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicsectionaccesslevel
enum WICSectionAccessLevel : int
{
    WICSectionAccessLevelRead      = 0x00000001,
    WICSectionAccessLevelReadWrite = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicpixelformatnumericrepresentation
enum WICPixelFormatNumericRepresentation : int
{
    WICPixelFormatNumericRepresentationUnspecified     = 0x00000000,
    WICPixelFormatNumericRepresentationIndexed         = 0x00000001,
    WICPixelFormatNumericRepresentationUnsignedInteger = 0x00000002,
    WICPixelFormatNumericRepresentationSignedInteger   = 0x00000003,
    WICPixelFormatNumericRepresentationFixed           = 0x00000004,
    WICPixelFormatNumericRepresentationFloat           = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicplanaroptions
enum WICPlanarOptions : int
{
    WICPlanarOptionsDefault             = 0x00000000,
    WICPlanarOptionsPreserveSubsampling = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicjpegindexingoptions
enum WICJpegIndexingOptions : int
{
    WICJpegIndexingOptionsGenerateOnDemand = 0x00000000,
    WICJpegIndexingOptionsGenerateOnLoad   = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicjpegtransfermatrix
enum WICJpegTransferMatrix : int
{
    WICJpegTransferMatrixIdentity = 0x00000000,
    WICJpegTransferMatrixBT601    = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicjpegscantype
enum WICJpegScanType : int
{
    WICJpegScanTypeInterleaved      = 0x00000000,
    WICJpegScanTypePlanarComponents = 0x00000001,
    WICJpegScanTypeProgressive      = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wictiffcompressionoption
enum WICTiffCompressionOption : int
{
    WICTiffCompressionDontCare         = 0x00000000,
    WICTiffCompressionNone             = 0x00000001,
    WICTiffCompressionCCITT3           = 0x00000002,
    WICTiffCompressionCCITT4           = 0x00000003,
    WICTiffCompressionLZW              = 0x00000004,
    WICTiffCompressionRLE              = 0x00000005,
    WICTiffCompressionZIP              = 0x00000006,
    WICTiffCompressionLZWHDifferencing = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicjpegycrcbsubsamplingoption
enum WICJpegYCrCbSubsamplingOption : int
{
    WICJpegYCrCbSubsamplingDefault = 0x00000000,
    WICJpegYCrCbSubsampling420     = 0x00000001,
    WICJpegYCrCbSubsampling422     = 0x00000002,
    WICJpegYCrCbSubsampling444     = 0x00000003,
    WICJpegYCrCbSubsampling440     = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicpngfilteroption
enum WICPngFilterOption : int
{
    WICPngFilterUnspecified = 0x00000000,
    WICPngFilterNone        = 0x00000001,
    WICPngFilterSub         = 0x00000002,
    WICPngFilterUp          = 0x00000003,
    WICPngFilterAverage     = 0x00000004,
    WICPngFilterPaeth       = 0x00000005,
    WICPngFilterAdaptive    = 0x00000006,
}

enum WICHeifCompressionOption : int
{
    WICHeifCompressionDontCare = 0x00000000,
    WICHeifCompressionNone     = 0x00000001,
    WICHeifCompressionHEVC     = 0x00000002,
    WICHeifCompressionAV1      = 0x00000003,
    WICHeifCompressionJpegXL   = 0x00000004,
    WICHeifCompressionBrotli   = 0x00000005,
    WICHeifCompressionDeflate  = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicnamedwhitepoint
enum WICNamedWhitePoint : int
{
    WICWhitePointDefault          = 0x00000001,
    WICWhitePointDaylight         = 0x00000002,
    WICWhitePointCloudy           = 0x00000004,
    WICWhitePointShade            = 0x00000008,
    WICWhitePointTungsten         = 0x00000010,
    WICWhitePointFluorescent      = 0x00000020,
    WICWhitePointFlash            = 0x00000040,
    WICWhitePointUnderwater       = 0x00000080,
    WICWhitePointCustom           = 0x00000100,
    WICWhitePointAutoWhiteBalance = 0x00000200,
    WICWhitePointAsShot           = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicrawcapabilities
enum WICRawCapabilities : int
{
    WICRawCapabilityNotSupported   = 0x00000000,
    WICRawCapabilityGetSupported   = 0x00000001,
    WICRawCapabilityFullySupported = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicrawrotationcapabilities
enum WICRawRotationCapabilities : int
{
    WICRawRotationCapabilityNotSupported           = 0x00000000,
    WICRawRotationCapabilityGetSupported           = 0x00000001,
    WICRawRotationCapabilityNinetyDegreesSupported = 0x00000002,
    WICRawRotationCapabilityFullySupported         = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicrawparameterset
enum WICRawParameterSet : int
{
    WICAsShotParameterSet       = 0x00000001,
    WICUserAdjustedParameterSet = 0x00000002,
    WICAutoAdjustedParameterSet = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicrawrendermode
enum WICRawRenderMode : int
{
    WICRawRenderModeDraft       = 0x00000001,
    WICRawRenderModeNormal      = 0x00000002,
    WICRawRenderModeBestQuality = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicddsdimension
enum WICDdsDimension : int
{
    WICDdsTexture1D   = 0x00000000,
    WICDdsTexture2D   = 0x00000001,
    WICDdsTexture3D   = 0x00000002,
    WICDdsTextureCube = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicddsalphamode
enum WICDdsAlphaMode : int
{
    WICDdsAlphaModeUnknown       = 0x00000000,
    WICDdsAlphaModeStraight      = 0x00000001,
    WICDdsAlphaModePremultiplied = 0x00000002,
    WICDdsAlphaModeOpaque        = 0x00000003,
    WICDdsAlphaModeCustom        = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/ne-wincodecsdk-wicmetadatacreationoptions
enum WICMetadataCreationOptions : int
{
    WICMetadataCreationDefault      = 0x00000000,
    WICMetadataCreationAllowUnknown = 0x00000000,
    WICMetadataCreationFailUnknown  = 0x00010000,
    WICMetadataCreationMask         = 0xffff0000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/ne-wincodecsdk-wicpersistoptions
enum WICPersistOptions : int
{
    WICPersistOptionDefault       = 0x00000000,
    WICPersistOptionLittleEndian  = 0x00000000,
    WICPersistOptionBigEndian     = 0x00000001,
    WICPersistOptionStrictFormat  = 0x00000002,
    WICPersistOptionNoCacheStream = 0x00000004,
    WICPersistOptionPreferUTF8    = 0x00000008,
    WICPersistOptionMask          = 0x0000ffff,
}

// Constants


enum : uint
{
    WINCODEC_SDK_VERSION1 = 0x00000236U,
    WINCODEC_SDK_VERSION2 = 0x00000237U,
}

enum : GUID
{
    CLSID_WICImagingFactory  = GUID("cacaf262-9370-4615-a13b-9f5539da4c0a"),
    CLSID_WICImagingFactory1 = GUID("cacaf262-9370-4615-a13b-9f5539da4c0a"),
    CLSID_WICImagingFactory2 = GUID("317d06e8-5f24-433d-bdf7-79ce68d8abc2"),
}

enum uint WINCODEC_SDK_VERSION = 0x00000237U;

enum : GUID
{
    GUID_VendorMicrosoft        = GUID("f0e749ca-edef-4589-a73a-ee0e626a2a2b"),
    GUID_VendorMicrosoftBuiltIn = GUID("257a30fd-06b6-462b-aea4-63f70b86e533"),
}

enum : GUID
{
    CLSID_WICPngDecoder               = GUID("389ea17b-5078-4cde-b6ef-25c15175c751"),
    CLSID_WICPngDecoder1              = GUID("389ea17b-5078-4cde-b6ef-25c15175c751"),
    CLSID_WICPngDecoder2              = GUID("e018945b-aa86-4008-9bd4-6777a1e40c11"),
    CLSID_WICBmpDecoder               = GUID("6b462062-7cbf-400d-9fdb-813dd10f2778"),
    CLSID_WICIcoDecoder               = GUID("c61bfcdf-2e0f-4aad-a8d7-e06bafebcdfe"),
    CLSID_WICJpegDecoder              = GUID("9456a480-e88b-43ea-9e73-0b2d9b71b1ca"),
    CLSID_WICGifDecoder               = GUID("381dda3c-9ce9-4834-a23e-1f98f8fc52be"),
    CLSID_WICTiffDecoder              = GUID("b54e85d9-fe23-499f-8b88-6acea713752b"),
    CLSID_WICWmpDecoder               = GUID("a26cec36-234c-4950-ae16-e34aace71d0d"),
    CLSID_WICDdsDecoder               = GUID("9053699f-a341-429d-9e90-ee437cf80c73"),
    CLSID_WICBmpEncoder               = GUID("69be8bb4-d66d-47c8-865a-ed1589433782"),
    CLSID_WICPngEncoder               = GUID("27949969-876a-41d7-9447-568f6a35a4dc"),
    CLSID_WICJpegEncoder              = GUID("1a34f5c1-4a5a-46dc-b644-1f4567e7a676"),
    CLSID_WICGifEncoder               = GUID("114f5598-0b22-40a0-86a1-c83ea495adbd"),
    CLSID_WICTiffEncoder              = GUID("0131be10-2001-4c5f-a9b0-cc88fab64ce8"),
    CLSID_WICWmpEncoder               = GUID("ac4ce3cb-e1c1-44cd-8215-5a1665509ec2"),
    CLSID_WICDdsEncoder               = GUID("a61dde94-66ce-4ac1-881b-71680588895e"),
    CLSID_WICAdngDecoder              = GUID("981d9411-909e-42a7-8f5d-a747ff052edb"),
    CLSID_WICJpegQualcommPhoneEncoder = GUID("68ed5c62-f534-4979-b2b3-686a12b2b34c"),
}

enum : GUID
{
    CLSID_WICHeifDecoder   = GUID("e9a4a80a-44fe-4de4-8971-7150b10a5199"),
    CLSID_WICHeifEncoder   = GUID("0dbecec1-9eb3-4860-9c6f-ddbe86634575"),
    CLSID_WICWebpDecoder   = GUID("7693e886-51c9-4070-8419-9f70738ec8fa"),
    CLSID_WICRAWDecoder    = GUID("41945702-8302-44a6-9445-ac98e8afa086"),
    CLSID_WICJpegXLDecoder = GUID("fc6ceece-aef5-4a23-96ec-5984ffb486d9"),
    CLSID_WICJpegXLEncoder = GUID("0e4ecd3b-1ba6-4636-8198-56c73040964a"),
}

enum : GUID
{
    GUID_ContainerFormatBmp    = GUID("0af1d87e-fcfe-4188-bdeb-a7906471cbe3"),
    GUID_ContainerFormatPng    = GUID("1b7cfaf4-713f-473c-bbcd-6137425faeaf"),
    GUID_ContainerFormatIco    = GUID("a3a860c4-338f-4c17-919a-fba4b5628f21"),
    GUID_ContainerFormatJpeg   = GUID("19e4a5aa-5662-4fc5-a0c0-1758028e1057"),
    GUID_ContainerFormatTiff   = GUID("163bcc30-e2e9-4f0b-961d-a3e9fdb788a3"),
    GUID_ContainerFormatGif    = GUID("1f8a5601-7d4d-4cbd-9c82-1bc8d4eeb9a5"),
    GUID_ContainerFormatWmp    = GUID("57a37caa-367a-4540-916b-f183c5093a4b"),
    GUID_ContainerFormatDds    = GUID("9967cb95-2e85-4ac8-8ca2-83d7ccd425c9"),
    GUID_ContainerFormatAdng   = GUID("f3ff6d0d-38c0-41c4-b1fe-1f3824f17b84"),
    GUID_ContainerFormatHeif   = GUID("e1e62521-6787-405b-a339-500715b5763f"),
    GUID_ContainerFormatWebp   = GUID("e094b0e2-67f2-45b3-b0ea-115337ca7cf3"),
    GUID_ContainerFormatRaw    = GUID("fe99ce60-f19c-433c-a3ae-00acefa9ca21"),
    GUID_ContainerFormatJpegXL = GUID("fec14e3f-427a-4736-aae6-27ed84f69322"),
}

enum GUID CLSID_WICImagingCategories = GUID("fae3d380-fea4-4623-8c75-c6b61110b681");

enum : GUID
{
    CATID_WICBitmapDecoders = GUID("7ed96837-96f0-4812-b211-f13c24117ed3"),
    CATID_WICBitmapEncoders = GUID("ac757296-3522-4e11-9862-c17be5a1767e"),
}

enum : GUID
{
    CATID_WICPixelFormats     = GUID("2b46e70f-cda7-473e-89f6-dc9630a2390b"),
    CATID_WICFormatConverters = GUID("7835eae8-bf14-49d1-93ce-533a407b2248"),
}

enum : GUID
{
    CATID_WICMetadataReader = GUID("05af94d8-7174-4cd2-be4a-4124b80ee4b8"),
    CATID_WICMetadataWriter = GUID("abe3b9a4-257d-4b97-bd1a-294af496222e"),
}

enum GUID CLSID_WICDefaultFormatConverter = GUID("1a3f11dc-b514-4b17-8c5f-2154513852f1");

enum : GUID
{
    CLSID_WICFormatConverterHighColor = GUID("ac75d454-9f37-48f8-b972-4e19bc856011"),
    CLSID_WICFormatConverterNChannel  = GUID("c17cabb2-d4a3-47d7-a557-339b2efbd4f1"),
    CLSID_WICFormatConverterWMPhoto   = GUID("9cb5172b-d600-46ba-ab77-77bb7e3a00d9"),
}

enum GUID CLSID_WICPlanarFormatConverter = GUID("184132b8-32f8-4784-9131-dd7224b23438");

enum : uint
{
    WIC_JPEG_MAX_COMPONENT_COUNT = 0x00000004U,
    WIC_JPEG_MAX_TABLE_INDEX     = 0x00000003U,
}

enum : uint
{
    WIC_JPEG_SAMPLE_FACTORS_ONE       = 0x00000011U,
    WIC_JPEG_SAMPLE_FACTORS_THREE_420 = 0x00111122U,
    WIC_JPEG_SAMPLE_FACTORS_THREE_422 = 0x00111121U,
    WIC_JPEG_SAMPLE_FACTORS_THREE_440 = 0x00111112U,
    WIC_JPEG_SAMPLE_FACTORS_THREE_444 = 0x00111111U,
}

enum : uint
{
    WIC_JPEG_QUANTIZATION_BASELINE_ONE   = 0x00000000U,
    WIC_JPEG_QUANTIZATION_BASELINE_THREE = 0x00010100U,
}

enum : uint
{
    WIC_JPEG_HUFFMAN_BASELINE_ONE   = 0x00000000U,
    WIC_JPEG_HUFFMAN_BASELINE_THREE = 0x00111100U,
}

enum : GUID
{
    GUID_WICPixelFormatDontCare                        = GUID("6fddc324-4e03-4bfe-b185-3d77768dc900"),
    GUID_WICPixelFormat1bppIndexed                     = GUID("6fddc324-4e03-4bfe-b185-3d77768dc901"),
    GUID_WICPixelFormat2bppIndexed                     = GUID("6fddc324-4e03-4bfe-b185-3d77768dc902"),
    GUID_WICPixelFormat4bppIndexed                     = GUID("6fddc324-4e03-4bfe-b185-3d77768dc903"),
    GUID_WICPixelFormat8bppIndexed                     = GUID("6fddc324-4e03-4bfe-b185-3d77768dc904"),
    GUID_WICPixelFormatBlackWhite                      = GUID("6fddc324-4e03-4bfe-b185-3d77768dc905"),
    GUID_WICPixelFormat2bppGray                        = GUID("6fddc324-4e03-4bfe-b185-3d77768dc906"),
    GUID_WICPixelFormat4bppGray                        = GUID("6fddc324-4e03-4bfe-b185-3d77768dc907"),
    GUID_WICPixelFormat8bppGray                        = GUID("6fddc324-4e03-4bfe-b185-3d77768dc908"),
    GUID_WICPixelFormat8bppAlpha                       = GUID("e6cd0116-eeba-4161-aa85-27dd9fb3a895"),
    GUID_WICPixelFormat8bppDepth                       = GUID("4c9c9f45-1d89-4e31-9bc7-69343a0dca69"),
    GUID_WICPixelFormat8bppGain                        = GUID("a884022a-af13-4c16-b746-619bf618b878"),
    GUID_WICPixelFormat24bppRGBGain                    = GUID("a5022b24-7109-443b-9948-25b6ed8f39fd"),
    GUID_WICPixelFormat32bppBGRGain                    = GUID("837d6738-208a-43e0-8995-79ab74407402"),
    GUID_WICPixelFormat16bppBGR555                     = GUID("6fddc324-4e03-4bfe-b185-3d77768dc909"),
    GUID_WICPixelFormat16bppBGR565                     = GUID("6fddc324-4e03-4bfe-b185-3d77768dc90a"),
    GUID_WICPixelFormat16bppBGRA5551                   = GUID("05ec7c2b-f1e6-4961-ad46-e1cc810a87d2"),
    GUID_WICPixelFormat16bppGray                       = GUID("6fddc324-4e03-4bfe-b185-3d77768dc90b"),
    GUID_WICPixelFormat24bppBGR                        = GUID("6fddc324-4e03-4bfe-b185-3d77768dc90c"),
    GUID_WICPixelFormat24bppRGB                        = GUID("6fddc324-4e03-4bfe-b185-3d77768dc90d"),
    GUID_WICPixelFormat32bppBGR                        = GUID("6fddc324-4e03-4bfe-b185-3d77768dc90e"),
    GUID_WICPixelFormat32bppBGRA                       = GUID("6fddc324-4e03-4bfe-b185-3d77768dc90f"),
    GUID_WICPixelFormat32bppPBGRA                      = GUID("6fddc324-4e03-4bfe-b185-3d77768dc910"),
    GUID_WICPixelFormat32bppGrayFloat                  = GUID("6fddc324-4e03-4bfe-b185-3d77768dc911"),
    GUID_WICPixelFormat32bppRGB                        = GUID("d98c6b95-3efe-47d6-bb25-eb1748ab0cf1"),
    GUID_WICPixelFormat32bppRGBA                       = GUID("f5c7ad2d-6a8d-43dd-a7a8-a29935261ae9"),
    GUID_WICPixelFormat32bppPRGBA                      = GUID("3cc4a650-a527-4d37-a916-3142c7ebedba"),
    GUID_WICPixelFormat48bppRGB                        = GUID("6fddc324-4e03-4bfe-b185-3d77768dc915"),
    GUID_WICPixelFormat48bppBGR                        = GUID("e605a384-b468-46ce-bb2e-36f180e64313"),
    GUID_WICPixelFormat64bppRGB                        = GUID("a1182111-186d-4d42-bc6a-9c8303a8dff9"),
    GUID_WICPixelFormat64bppRGBA                       = GUID("6fddc324-4e03-4bfe-b185-3d77768dc916"),
    GUID_WICPixelFormat64bppBGRA                       = GUID("1562ff7c-d352-46f9-979e-42976b792246"),
    GUID_WICPixelFormat64bppPRGBA                      = GUID("6fddc324-4e03-4bfe-b185-3d77768dc917"),
    GUID_WICPixelFormat64bppPBGRA                      = GUID("8c518e8e-a4ec-468b-ae70-c9a35a9c5530"),
    GUID_WICPixelFormat16bppGrayFixedPoint             = GUID("6fddc324-4e03-4bfe-b185-3d77768dc913"),
    GUID_WICPixelFormat32bppBGR101010                  = GUID("6fddc324-4e03-4bfe-b185-3d77768dc914"),
    GUID_WICPixelFormat48bppRGBFixedPoint              = GUID("6fddc324-4e03-4bfe-b185-3d77768dc912"),
    GUID_WICPixelFormat48bppBGRFixedPoint              = GUID("49ca140e-cab6-493b-9ddf-60187c37532a"),
    GUID_WICPixelFormat96bppRGBFixedPoint              = GUID("6fddc324-4e03-4bfe-b185-3d77768dc918"),
    GUID_WICPixelFormat96bppRGBFloat                   = GUID("e3fed78f-e8db-4acf-84c1-e97f6136b327"),
    GUID_WICPixelFormat128bppRGBAFloat                 = GUID("6fddc324-4e03-4bfe-b185-3d77768dc919"),
    GUID_WICPixelFormat128bppPRGBAFloat                = GUID("6fddc324-4e03-4bfe-b185-3d77768dc91a"),
    GUID_WICPixelFormat128bppRGBFloat                  = GUID("6fddc324-4e03-4bfe-b185-3d77768dc91b"),
    GUID_WICPixelFormat32bppCMYK                       = GUID("6fddc324-4e03-4bfe-b185-3d77768dc91c"),
    GUID_WICPixelFormat64bppRGBAFixedPoint             = GUID("6fddc324-4e03-4bfe-b185-3d77768dc91d"),
    GUID_WICPixelFormat64bppBGRAFixedPoint             = GUID("356de33c-54d2-4a23-bb04-9b7bf9b1d42d"),
    GUID_WICPixelFormat64bppRGBFixedPoint              = GUID("6fddc324-4e03-4bfe-b185-3d77768dc940"),
    GUID_WICPixelFormat128bppRGBAFixedPoint            = GUID("6fddc324-4e03-4bfe-b185-3d77768dc91e"),
    GUID_WICPixelFormat128bppRGBFixedPoint             = GUID("6fddc324-4e03-4bfe-b185-3d77768dc941"),
    GUID_WICPixelFormat64bppRGBAHalf                   = GUID("6fddc324-4e03-4bfe-b185-3d77768dc93a"),
    GUID_WICPixelFormat64bppPRGBAHalf                  = GUID("58ad26c2-c623-4d9d-b320-387e49f8c442"),
    GUID_WICPixelFormat64bppRGBHalf                    = GUID("6fddc324-4e03-4bfe-b185-3d77768dc942"),
    GUID_WICPixelFormat48bppRGBHalf                    = GUID("6fddc324-4e03-4bfe-b185-3d77768dc93b"),
    GUID_WICPixelFormat32bppRGBE                       = GUID("6fddc324-4e03-4bfe-b185-3d77768dc93d"),
    GUID_WICPixelFormat16bppGrayHalf                   = GUID("6fddc324-4e03-4bfe-b185-3d77768dc93e"),
    GUID_WICPixelFormat32bppGrayFixedPoint             = GUID("6fddc324-4e03-4bfe-b185-3d77768dc93f"),
    GUID_WICPixelFormat32bppRGBA1010102                = GUID("25238d72-fcf9-4522-b514-5578e5ad55e0"),
    GUID_WICPixelFormat32bppRGBA1010102XR              = GUID("00de6b9a-c101-434b-b502-d0165ee1122c"),
    GUID_WICPixelFormat32bppR10G10B10A2                = GUID("604e1bb5-8a3c-4b65-b11c-bc0b8dd75b7f"),
    GUID_WICPixelFormat32bppR10G10B10A2HDR10           = GUID("9c215c5d-1acc-4f0e-a4bc-70fb3ae8fd28"),
    GUID_WICPixelFormat64bppCMYK                       = GUID("6fddc324-4e03-4bfe-b185-3d77768dc91f"),
    GUID_WICPixelFormat24bpp3Channels                  = GUID("6fddc324-4e03-4bfe-b185-3d77768dc920"),
    GUID_WICPixelFormat32bpp4Channels                  = GUID("6fddc324-4e03-4bfe-b185-3d77768dc921"),
    GUID_WICPixelFormat40bpp5Channels                  = GUID("6fddc324-4e03-4bfe-b185-3d77768dc922"),
    GUID_WICPixelFormat48bpp6Channels                  = GUID("6fddc324-4e03-4bfe-b185-3d77768dc923"),
    GUID_WICPixelFormat56bpp7Channels                  = GUID("6fddc324-4e03-4bfe-b185-3d77768dc924"),
    GUID_WICPixelFormat64bpp8Channels                  = GUID("6fddc324-4e03-4bfe-b185-3d77768dc925"),
    GUID_WICPixelFormat48bpp3Channels                  = GUID("6fddc324-4e03-4bfe-b185-3d77768dc926"),
    GUID_WICPixelFormat64bpp4Channels                  = GUID("6fddc324-4e03-4bfe-b185-3d77768dc927"),
    GUID_WICPixelFormat80bpp5Channels                  = GUID("6fddc324-4e03-4bfe-b185-3d77768dc928"),
    GUID_WICPixelFormat96bpp6Channels                  = GUID("6fddc324-4e03-4bfe-b185-3d77768dc929"),
    GUID_WICPixelFormat112bpp7Channels                 = GUID("6fddc324-4e03-4bfe-b185-3d77768dc92a"),
    GUID_WICPixelFormat128bpp8Channels                 = GUID("6fddc324-4e03-4bfe-b185-3d77768dc92b"),
    GUID_WICPixelFormat40bppCMYKAlpha                  = GUID("6fddc324-4e03-4bfe-b185-3d77768dc92c"),
    GUID_WICPixelFormat80bppCMYKAlpha                  = GUID("6fddc324-4e03-4bfe-b185-3d77768dc92d"),
    GUID_WICPixelFormat32bpp3ChannelsAlpha             = GUID("6fddc324-4e03-4bfe-b185-3d77768dc92e"),
    GUID_WICPixelFormat40bpp4ChannelsAlpha             = GUID("6fddc324-4e03-4bfe-b185-3d77768dc92f"),
    GUID_WICPixelFormat48bpp5ChannelsAlpha             = GUID("6fddc324-4e03-4bfe-b185-3d77768dc930"),
    GUID_WICPixelFormat56bpp6ChannelsAlpha             = GUID("6fddc324-4e03-4bfe-b185-3d77768dc931"),
    GUID_WICPixelFormat64bpp7ChannelsAlpha             = GUID("6fddc324-4e03-4bfe-b185-3d77768dc932"),
    GUID_WICPixelFormat72bpp8ChannelsAlpha             = GUID("6fddc324-4e03-4bfe-b185-3d77768dc933"),
    GUID_WICPixelFormat64bpp3ChannelsAlpha             = GUID("6fddc324-4e03-4bfe-b185-3d77768dc934"),
    GUID_WICPixelFormat80bpp4ChannelsAlpha             = GUID("6fddc324-4e03-4bfe-b185-3d77768dc935"),
    GUID_WICPixelFormat96bpp5ChannelsAlpha             = GUID("6fddc324-4e03-4bfe-b185-3d77768dc936"),
    GUID_WICPixelFormat112bpp6ChannelsAlpha            = GUID("6fddc324-4e03-4bfe-b185-3d77768dc937"),
    GUID_WICPixelFormat128bpp7ChannelsAlpha            = GUID("6fddc324-4e03-4bfe-b185-3d77768dc938"),
    GUID_WICPixelFormat144bpp8ChannelsAlpha            = GUID("6fddc324-4e03-4bfe-b185-3d77768dc939"),
    GUID_WICPixelFormat8bppY                           = GUID("91b4db54-2df9-42f0-b449-2909bb3df88e"),
    GUID_WICPixelFormat8bppCb                          = GUID("1339f224-6bfe-4c3e-9302-e4f3a6d0ca2a"),
    GUID_WICPixelFormat8bppCr                          = GUID("b8145053-2116-49f0-8835-ed844b205c51"),
    GUID_WICPixelFormat16bppCbCr                       = GUID("ff95ba6e-11e0-4263-bb45-01721f3460a4"),
    GUID_WICPixelFormat16bppYQuantizedDctCoefficients  = GUID("a355f433-48e8-4a42-84d8-e2aa26ca80a4"),
    GUID_WICPixelFormat16bppCbQuantizedDctCoefficients = GUID("d2c4ff61-56a5-49c2-8b5c-4c1925964837"),
    GUID_WICPixelFormat16bppCrQuantizedDctCoefficients = GUID("2fe354f0-1680-42d8-9231-e73c0565bfc1"),
}

enum uint FACILITY_WINCODEC_ERR = 0x00000898U;
enum uint WINCODEC_ERR_BASE = 0x00002000U;

enum : int
{
    WINCODEC_ERR_GENERIC_ERROR    = 0x80004005,
    WINCODEC_ERR_INVALIDPARAMETER = 0x80070057,
    WINCODEC_ERR_OUTOFMEMORY      = 0x8007000e,
    WINCODEC_ERR_NOTIMPLEMENTED   = 0x80004001,
    WINCODEC_ERR_ABORTED          = 0x80004004,
    WINCODEC_ERR_ACCESSDENIED     = 0x80070005,
}

enum : uint
{
    WICRawChangeNotification_ExposureCompensation    = 0x00000001U,
    WICRawChangeNotification_NamedWhitePoint         = 0x00000002U,
    WICRawChangeNotification_KelvinWhitePoint        = 0x00000004U,
    WICRawChangeNotification_RGBWhitePoint           = 0x00000008U,
    WICRawChangeNotification_Contrast                = 0x00000010U,
    WICRawChangeNotification_Gamma                   = 0x00000020U,
    WICRawChangeNotification_Sharpness               = 0x00000040U,
    WICRawChangeNotification_Saturation              = 0x00000080U,
    WICRawChangeNotification_Tint                    = 0x00000100U,
    WICRawChangeNotification_NoiseReduction          = 0x00000200U,
    WICRawChangeNotification_DestinationColorContext = 0x00000400U,
    WICRawChangeNotification_ToneCurve               = 0x00000800U,
    WICRawChangeNotification_Rotation                = 0x00001000U,
    WICRawChangeNotification_RenderMode              = 0x00002000U,
}

enum : GUID
{
    GUID_MetadataFormatUnknown            = GUID("a45e592f-9078-4a7c-adb5-4edc4fd61b1f"),
    GUID_MetadataFormatIfd                = GUID("537396c6-2d8a-4bb6-9bf8-2f0a8e2a3adf"),
    GUID_MetadataFormatSubIfd             = GUID("58a2e128-2db9-4e57-bb14-5177891ed331"),
    GUID_MetadataFormatExif               = GUID("1c3c4f9d-b84a-467d-9493-36cfbd59ea57"),
    GUID_MetadataFormatGps                = GUID("7134ab8a-9351-44ad-af62-448db6b502ec"),
    GUID_MetadataFormatInterop            = GUID("ed686f8e-681f-4c8b-bd41-a8addbf6b3fc"),
    GUID_MetadataFormatApp0               = GUID("79007028-268d-45d6-a3c2-354e6a504bc9"),
    GUID_MetadataFormatApp1               = GUID("8fd3dfc3-f951-492b-817f-69c2e6d9a5b0"),
    GUID_MetadataFormatApp13              = GUID("326556a2-f502-4354-9cc0-8e3f48eaf6b5"),
    GUID_MetadataFormatIPTC               = GUID("4fab0914-e129-4087-a1d1-bc812d45a7b5"),
    GUID_MetadataFormatIRB                = GUID("16100d66-8570-4bb9-b92d-fda4b23ece67"),
    GUID_MetadataFormat8BIMIPTC           = GUID("0010568c-0852-4e6a-b191-5c33ac5b0430"),
    GUID_MetadataFormat8BIMResolutionInfo = GUID("739f305d-81db-43cb-ac5e-55013ef9f003"),
    GUID_MetadataFormat8BIMIPTCDigest     = GUID("1ca32285-9ccd-4786-8bd8-79539db6a006"),
    GUID_MetadataFormatXMP                = GUID("bb5acc38-f216-4cec-a6c5-5f6e739763a9"),
    GUID_MetadataFormatThumbnail          = GUID("243dcee9-8703-40ee-8ef0-22a600b8058c"),
    GUID_MetadataFormatChunktEXt          = GUID("568d8936-c0a9-4923-905d-df2b38238fbc"),
    GUID_MetadataFormatXMPStruct          = GUID("22383cf1-ed17-4e2e-af17-d85b8f6b30d0"),
    GUID_MetadataFormatXMPBag             = GUID("833cca5f-dcb7-4516-806f-6596ab26dce4"),
    GUID_MetadataFormatXMPSeq             = GUID("63e8df02-eb6c-456c-a224-b25e794fd648"),
    GUID_MetadataFormatXMPAlt             = GUID("7b08a675-91aa-481b-a798-4da94908613b"),
    GUID_MetadataFormatLSD                = GUID("e256031e-6299-4929-b98d-5ac884afba92"),
    GUID_MetadataFormatIMD                = GUID("bd2bb086-4d52-48dd-9677-db483e85ae8f"),
    GUID_MetadataFormatGCE                = GUID("2a25cad8-deeb-4c69-a788-0ec2266dcafd"),
    GUID_MetadataFormatAPE                = GUID("2e043dc2-c967-4e05-875e-618bf67e85c3"),
    GUID_MetadataFormatJpegChrominance    = GUID("f73d0dcf-cec6-4f85-9b0e-1c3956b1bef7"),
    GUID_MetadataFormatJpegLuminance      = GUID("86908007-edfc-4860-8d4b-4ee6e83e6058"),
    GUID_MetadataFormatJpegComment        = GUID("220e5f33-afd3-474e-9d31-7d4fe730f557"),
    GUID_MetadataFormatGifComment         = GUID("c4b6e0e0-cfb4-4ad3-ab33-9aad2355a34a"),
    GUID_MetadataFormatChunkgAMA          = GUID("f00935a5-1d5d-4cd1-81b2-9324d7eca781"),
    GUID_MetadataFormatChunkbKGD          = GUID("e14d3571-6b47-4dea-b60a-87ce0a78dfb7"),
    GUID_MetadataFormatChunkiTXt          = GUID("c2bec729-0b68-4b77-aa0e-6295a6ac1814"),
    GUID_MetadataFormatChunkcHRM          = GUID("9db3655b-2842-44b3-8067-12e9b375556a"),
    GUID_MetadataFormatChunkhIST          = GUID("c59a82da-db74-48a4-bd6a-b69c4931ef95"),
    GUID_MetadataFormatChunkiCCP          = GUID("eb4349ab-b685-450f-91b5-e802e892536c"),
    GUID_MetadataFormatChunksRGB          = GUID("c115fd36-cc6f-4e3f-8363-524b87c6b0d9"),
    GUID_MetadataFormatChunktIME          = GUID("6b00ae2d-e24b-460a-98b6-878bd03072fd"),
    GUID_MetadataFormatDds                = GUID("4a064603-8c33-4e60-9c29-136231702d08"),
    GUID_MetadataFormatHeif               = GUID("817ef3e1-1288-45f4-a852-260d9e7cce83"),
    GUID_MetadataFormatHeifHDR            = GUID("568b8d8a-1e65-438c-8968-d60e1012beb9"),
    GUID_MetadataFormatWebpANIM           = GUID("6dc4fda6-78e6-4102-ae35-bcfa1edcc78b"),
    GUID_MetadataFormatWebpANMF           = GUID("43c105ee-b93b-4abb-b003-a08c0d870471"),
    GUID_MetadataFormatJpegXLAnim         = GUID("501c2e24-7a7d-42b2-93c7-b4f45bcc92f7"),
    GUID_MetadataFormatJpegXLAnimFrame    = GUID("958ecc2c-36cb-4af9-9ea8-0b74baccfd3e"),
    GUID_MetadataFormatGainMap            = GUID("568d3138-c446-4ec2-a7a8-59abb16d21e3"),
}

enum : GUID
{
    CLSID_WICUnknownMetadataReader = GUID("699745c2-5066-4b82-a8e3-d40478dbec8c"),
    CLSID_WICUnknownMetadataWriter = GUID("a09cca86-27ba-4f39-9053-121fa4dc08fc"),
}

enum : GUID
{
    CLSID_WICApp0MetadataWriter  = GUID("f3c633a2-46c8-498e-8fbb-cc6f721bbcde"),
    CLSID_WICApp0MetadataReader  = GUID("43324b33-a78f-480f-9111-9638aaccc832"),
    CLSID_WICApp1MetadataWriter  = GUID("ee366069-1832-420f-b381-0479ad066f19"),
    CLSID_WICApp1MetadataReader  = GUID("dde33513-774e-4bcd-ae79-02f4adfe62fc"),
    CLSID_WICApp13MetadataWriter = GUID("7b19a919-a9d6-49e5-bd45-02c34e4e4cd5"),
    CLSID_WICApp13MetadataReader = GUID("aa7e3c50-864c-4604-bc04-8b0b76e637f6"),
}

enum : GUID
{
    CLSID_WICIfdMetadataReader = GUID("8f914656-9d0a-4eb2-9019-0bf96d8a9ee6"),
    CLSID_WICIfdMetadataWriter = GUID("b1ebfc28-c9bd-47a2-8d33-b948769777a7"),
}

enum : GUID
{
    CLSID_WICSubIfdMetadataReader = GUID("50d42f09-ecd1-4b41-b65d-da1fdaa75663"),
    CLSID_WICSubIfdMetadataWriter = GUID("8ade5386-8e9b-4f4c-acf2-f0008706b238"),
}

enum : GUID
{
    CLSID_WICExifMetadataReader = GUID("d9403860-297f-4a49-bf9b-77898150a442"),
    CLSID_WICExifMetadataWriter = GUID("c9a14cda-c339-460b-9078-d4debcfabe91"),
}

enum : GUID
{
    CLSID_WICGpsMetadataReader = GUID("3697790b-223b-484e-9925-c4869218f17a"),
    CLSID_WICGpsMetadataWriter = GUID("cb8c13e4-62b5-4c96-a48b-6ba6ace39c76"),
}

enum : GUID
{
    CLSID_WICInteropMetadataReader = GUID("b5c8b898-0074-459f-b700-860d4651ea14"),
    CLSID_WICInteropMetadataWriter = GUID("122ec645-cd7e-44d8-b186-2c8c20c3b50f"),
}

enum : GUID
{
    CLSID_WICThumbnailMetadataReader = GUID("fb012959-f4f6-44d7-9d09-daa087a9db57"),
    CLSID_WICThumbnailMetadataWriter = GUID("d049b20c-5dd0-44fe-b0b3-8f92c8e6d080"),
}

enum : GUID
{
    CLSID_WICIPTCMetadataReader = GUID("03012959-f4f6-44d7-9d09-daa087a9db57"),
    CLSID_WICIPTCMetadataWriter = GUID("1249b20c-5dd0-44fe-b0b3-8f92c8e6d080"),
}

enum : GUID
{
    CLSID_WICIRBMetadataReader = GUID("d4dcd3d7-b4c2-47d9-a6bf-b89ba396a4a3"),
    CLSID_WICIRBMetadataWriter = GUID("5c5c1935-0235-4434-80bc-251bc1ec39c6"),
}

enum : GUID
{
    CLSID_WIC8BIMIPTCMetadataReader           = GUID("0010668c-0801-4da6-a4a4-826522b6d28f"),
    CLSID_WIC8BIMIPTCMetadataWriter           = GUID("00108226-ee41-44a2-9e9c-4be4d5b1d2cd"),
    CLSID_WIC8BIMResolutionInfoMetadataReader = GUID("5805137a-e348-4f7c-b3cc-6db9965a0599"),
    CLSID_WIC8BIMResolutionInfoMetadataWriter = GUID("4ff2fe0e-e74a-4b71-98c4-ab7dc16707ba"),
}

enum : GUID
{
    CLSID_WIC8BIMIPTCDigestMetadataReader = GUID("02805f1e-d5aa-415b-82c5-61c033a988a6"),
    CLSID_WIC8BIMIPTCDigestMetadataWriter = GUID("2db5e62b-0d67-495f-8f9d-c2f0188647ac"),
}

enum : GUID
{
    CLSID_WICPngTextMetadataReader = GUID("4b59afcc-b8c3-408a-b670-89e5fab6fda7"),
    CLSID_WICPngTextMetadataWriter = GUID("b5ebafb9-253e-4a72-a744-0762d2685683"),
}

enum : GUID
{
    CLSID_WICXMPMetadataReader       = GUID("72b624df-ae11-4948-a65c-351eb0829419"),
    CLSID_WICXMPMetadataWriter       = GUID("1765e14e-1bd4-462e-b6b1-590bf1262ac6"),
    CLSID_WICXMPStructMetadataReader = GUID("01b90d9a-8209-47f7-9c52-e1244bf50ced"),
    CLSID_WICXMPStructMetadataWriter = GUID("22c21f93-7ddb-411c-9b17-c5b7bd064abc"),
}

enum : GUID
{
    CLSID_WICXMPBagMetadataReader = GUID("e7e79a30-4f2c-4fab-8d00-394f2d6bbebe"),
    CLSID_WICXMPBagMetadataWriter = GUID("ed822c8c-d6be-4301-a631-0e1416bad28f"),
    CLSID_WICXMPSeqMetadataReader = GUID("7f12e753-fc71-43d7-a51d-92f35977abb5"),
    CLSID_WICXMPSeqMetadataWriter = GUID("6d68d1de-d432-4b0f-923a-091183a9bda7"),
    CLSID_WICXMPAltMetadataReader = GUID("aa94dcc2-b8b0-4898-b835-000aabd74393"),
    CLSID_WICXMPAltMetadataWriter = GUID("076c2a6c-f78f-4c46-a723-3583e70876ea"),
}

enum : GUID
{
    CLSID_WICLSDMetadataReader = GUID("41070793-59e4-479a-a1f7-954adc2ef5fc"),
    CLSID_WICLSDMetadataWriter = GUID("73c037e7-e5d9-4954-876a-6da81d6e5768"),
}

enum : GUID
{
    CLSID_WICGCEMetadataReader = GUID("b92e345d-f52d-41f3-b562-081bc772e3b9"),
    CLSID_WICGCEMetadataWriter = GUID("af95dc76-16b2-47f4-b3ea-3c31796693e7"),
}

enum : GUID
{
    CLSID_WICIMDMetadataReader = GUID("7447a267-0015-42c8-a8f1-fb3b94c68361"),
    CLSID_WICIMDMetadataWriter = GUID("8c89071f-452e-4e95-9682-9d1024627172"),
}

enum : GUID
{
    CLSID_WICAPEMetadataReader = GUID("1767b93a-b021-44ea-920f-863c11f4f768"),
    CLSID_WICAPEMetadataWriter = GUID("bd6edfca-2890-482f-b233-8d7339a1cf8d"),
}

enum : GUID
{
    CLSID_WICJpegChrominanceMetadataReader = GUID("50b1904b-f28f-4574-93f4-0bade82c69e9"),
    CLSID_WICJpegChrominanceMetadataWriter = GUID("3ff566f0-6e6b-49d4-96e6-b78886692c62"),
}

enum : GUID
{
    CLSID_WICJpegLuminanceMetadataReader = GUID("356f2f88-05a6-4728-b9a4-1bfbce04d838"),
    CLSID_WICJpegLuminanceMetadataWriter = GUID("1d583abc-8a0e-4657-9982-a380ca58fb4b"),
}

enum : GUID
{
    CLSID_WICJpegCommentMetadataReader = GUID("9f66347c-60c4-4c4d-ab58-d2358685f607"),
    CLSID_WICJpegCommentMetadataWriter = GUID("e573236f-55b1-4eda-81ea-9f65db0290d3"),
}

enum : GUID
{
    CLSID_WICGifCommentMetadataReader = GUID("32557d3b-69dc-4f95-836e-f5972b2f6159"),
    CLSID_WICGifCommentMetadataWriter = GUID("a02797fc-c4ae-418c-af95-e637c7ead2a1"),
}

enum : GUID
{
    CLSID_WICPngGamaMetadataReader = GUID("3692ca39-e082-4350-9e1f-3704cb083cd5"),
    CLSID_WICPngGamaMetadataWriter = GUID("ff036d13-5d4b-46dd-b10f-106693d9fe4f"),
}

enum : GUID
{
    CLSID_WICPngBkgdMetadataReader = GUID("0ce7a4a6-03e8-4a60-9d15-282ef32ee7da"),
    CLSID_WICPngBkgdMetadataWriter = GUID("68e3f2fd-31ae-4441-bb6a-fd7047525f90"),
}

enum : GUID
{
    CLSID_WICPngItxtMetadataReader = GUID("aabfb2fa-3e1e-4a8f-8977-5556fb94ea23"),
    CLSID_WICPngItxtMetadataWriter = GUID("31879719-e751-4df8-981d-68dff67704ed"),
}

enum : GUID
{
    CLSID_WICPngChrmMetadataReader = GUID("f90b5f36-367b-402a-9dd1-bc0fd59d8f62"),
    CLSID_WICPngChrmMetadataWriter = GUID("e23ce3eb-5608-4e83-bcef-27b1987e51d7"),
}

enum : GUID
{
    CLSID_WICPngHistMetadataReader = GUID("877a0bb7-a313-4491-87b5-2e6d0594f520"),
    CLSID_WICPngHistMetadataWriter = GUID("8a03e749-672e-446e-bf1f-2c11d233b6ff"),
}

enum : GUID
{
    CLSID_WICPngIccpMetadataReader = GUID("f5d3e63b-cb0f-4628-a478-6d8244be36b1"),
    CLSID_WICPngIccpMetadataWriter = GUID("16671e5f-0ce6-4cc4-9768-e89fe5018ade"),
}

enum : GUID
{
    CLSID_WICPngSrgbMetadataReader = GUID("fb40360c-547e-4956-a3b9-d4418859ba66"),
    CLSID_WICPngSrgbMetadataWriter = GUID("a6ee35c6-87ec-47df-9f22-1d5aad840c82"),
}

enum : GUID
{
    CLSID_WICPngTimeMetadataReader = GUID("d94edf02-efe5-4f0d-85c8-f5a68b3000b1"),
    CLSID_WICPngTimeMetadataWriter = GUID("1ab78400-b5a3-4d91-8ace-33fcd1499be6"),
}

enum : GUID
{
    CLSID_WICDdsMetadataReader = GUID("276c88ca-7533-4a86-b676-66b36080d484"),
    CLSID_WICDdsMetadataWriter = GUID("fd688bbd-31ed-4db7-a723-934927d38367"),
}

enum : GUID
{
    CLSID_WICHeifMetadataReader    = GUID("acddfc3f-85ec-41bc-bdef-1bc262e4db05"),
    CLSID_WICHeifMetadataWriter    = GUID("3ae45e79-40bc-4401-ace5-dd3cb16e6afe"),
    CLSID_WICHeifHDRMetadataReader = GUID("2438de3d-94d9-4be8-84a8-4de95a575e75"),
    CLSID_WICHeifHDRMetadataWriter = GUID("b83135a2-8e7e-485e-a533-f93621dd93c8"),
}

enum : GUID
{
    CLSID_WICWebpAnimMetadataReader = GUID("076f9911-a348-465c-a807-a252f3f2d3de"),
    CLSID_WICWebpAnmfMetadataReader = GUID("85a10b03-c9f6-439f-be5e-c0fbef67807c"),
}

enum : GUID
{
    CLSID_WICJpegXLAnimMetadataReader      = GUID("bf8b6eb0-37e2-4ed8-8289-be9ae31d9f03"),
    CLSID_WICJpegXLAnimMetadataWriter      = GUID("39d01345-432b-44e6-afd6-f606d20a5571"),
    CLSID_WICJpegXLAnimFrameMetadataReader = GUID("9cdf50a8-8770-4fe6-aef2-d06e2c01744f"),
    CLSID_WICJpegXLAnimFrameMetadataWriter = GUID("d1ce58a8-06e0-4b6f-8fc1-577560bd5ad9"),
}

enum : GUID
{
    CLSID_WICGainMapMetadataReader = GUID("3ac32daf-27b9-4af5-b0ab-d1189dcf34b3"),
    CLSID_WICGainMapMetadataWriter = GUID("6f845268-a92e-4a02-b002-a67c362800b2"),
}

// Callbacks

alias PFNProgressNotification = HRESULT function(void* pvData, uint uFrameNum, WICProgressOperation operation, 
                                                 double dblProgress);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ns-wincodec-wicrect
struct WICRect
{
    int X;
    int Y;
    int Width;
    int Height;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ns-wincodec-wicbitmappattern
struct WICBitmapPattern
{
    ulong  Position;
    uint   Length;
    ubyte* Pattern;
    ubyte* Mask;
    BOOL   EndOfStream;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ns-wincodec-wicimageparameters
struct WICImageParameters
{
    D2D1_PIXEL_FORMAT PixelFormat;
    float             DpiX;
    float             DpiY;
    float             Top;
    float             Left;
    uint              PixelWidth;
    uint              PixelHeight;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ns-wincodec-wicbitmapplanedescription
struct WICBitmapPlaneDescription
{
    GUID Format;
    uint Width;
    uint Height;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ns-wincodec-wicbitmapplane
struct WICBitmapPlane
{
    GUID   Format;
    ubyte* pbBuffer;
    uint   cbStride;
    uint   cbBufferSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ns-wincodec-wicjpegframeheader
struct WICJpegFrameHeader
{
    uint            Width;
    uint            Height;
    WICJpegTransferMatrix TransferMatrix;
    WICJpegScanType ScanType;
    uint            cComponents;
    uint            ComponentIdentifiers;
    uint            SampleFactors;
    uint            QuantizationTableIndices;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ns-wincodec-wicjpegscanheader
struct WICJpegScanHeader
{
    uint  cComponents;
    uint  RestartInterval;
    uint  ComponentSelectors;
    uint  HuffmanTableIndices;
    ubyte StartSpectralSelection;
    ubyte EndSpectralSelection;
    ubyte SuccessiveApproximationHigh;
    ubyte SuccessiveApproximationLow;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ns-wincodec-wicrawcapabilitiesinfo
struct WICRawCapabilitiesInfo
{
    uint               cbSize;
    uint               CodecMajorVersion;
    uint               CodecMinorVersion;
    WICRawCapabilities ExposureCompensationSupport;
    WICRawCapabilities ContrastSupport;
    WICRawCapabilities RGBWhitePointSupport;
    WICRawCapabilities NamedWhitePointSupport;
    uint               NamedWhitePointSupportMask;
    WICRawCapabilities KelvinWhitePointSupport;
    WICRawCapabilities GammaSupport;
    WICRawCapabilities TintSupport;
    WICRawCapabilities SaturationSupport;
    WICRawCapabilities SharpnessSupport;
    WICRawCapabilities NoiseReductionSupport;
    WICRawCapabilities DestinationColorProfileSupport;
    WICRawCapabilities ToneCurveSupport;
    WICRawRotationCapabilities RotationSupport;
    WICRawCapabilities RenderModeSupport;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ns-wincodec-wicrawtonecurvepoint
struct WICRawToneCurvePoint
{
    double Input;
    double Output;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ns-wincodec-wicrawtonecurve
struct WICRawToneCurve
{
    uint cPoints;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/WICRawToneCurvePoint[1] aPoints;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ns-wincodec-wicddsparameters
struct WICDdsParameters
{
    uint            Width;
    uint            Height;
    uint            Depth;
    uint            MipLevels;
    uint            ArraySize;
    DXGI_FORMAT     DxgiFormat;
    WICDdsDimension Dimension;
    WICDdsAlphaMode AlphaMode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/ns-wincodec-wicddsformatinfo
struct WICDdsFormatInfo
{
    DXGI_FORMAT DxgiFormat;
    uint        BytesPerBlock;
    uint        BlockWidth;
    uint        BlockHeight;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/ns-wincodecsdk-wicmetadatapattern
struct WICMetadataPattern
{
    ulong  Position;
    uint   Length;
    ubyte* Pattern;
    ubyte* Mask;
    ulong  DataOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/ns-wincodecsdk-wicmetadataheader
struct WICMetadataHeader
{
    ulong  Position;
    uint   Length;
    ubyte* Header;
    ulong  DataOffset;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WindowsCodecs.dll")
HRESULT WICConvertBitmapSource(GUID* dstFormat, IWICBitmapSource pISrc, IWICBitmapSource* ppIDst);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WindowsCodecs.dll")
HRESULT WICCreateBitmapFromSection(uint width, uint height, GUID* pixelFormat, HANDLE hSection, uint stride, 
                                   uint offset, IWICBitmap* ppIBitmap);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("WindowsCodecs.dll")
HRESULT WICCreateBitmapFromSectionEx(uint width, uint height, GUID* pixelFormat, HANDLE hSection, uint stride, 
                                     uint offset, WICSectionAccessLevel desiredAccessLevel, IWICBitmap* ppIBitmap);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WindowsCodecs.dll")
HRESULT WICMapGuidToShortName(const(GUID)* guid, uint cchName, PWSTR wzName, uint* pcchActual);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WindowsCodecs.dll")
HRESULT WICMapShortNameToGuid(const(PWSTR) wzName, GUID* pguid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WindowsCodecs.dll")
HRESULT WICMapSchemaToName(const(GUID)* guidMetadataFormat, PWSTR pwzSchema, uint cchName, PWSTR wzName, 
                           uint* pcchActual);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WindowsCodecs.dll")
HRESULT WICMatchMetadataContent(const(GUID)* guidContainerFormat, const(GUID)* pguidVendor, IStream pIStream, 
                                GUID* pguidMetadataFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WindowsCodecs.dll")
HRESULT WICSerializeMetadataContent(const(GUID)* guidContainerFormat, IWICMetadataWriter pIWriter, 
                                    uint dwPersistOptions, IStream pIStream);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WindowsCodecs.dll")
HRESULT WICGetMetadataContentSize(const(GUID)* guidContainerFormat, IWICMetadataWriter pIWriter, ulong* pcbSize);


// Interfaces

@GUID("00000040-a8f2-4877-ba0a-fd2b6645fb94")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicpalette
interface IWICPalette : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpalette-initializepredefined
    HRESULT InitializePredefined(WICBitmapPaletteType ePaletteType, BOOL fAddTransparentColor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpalette-initializecustom
    HRESULT InitializeCustom(uint* pColors, uint cCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpalette-initializefrombitmap
    HRESULT InitializeFromBitmap(IWICBitmapSource pISurface, uint cCount, BOOL fAddTransparentColor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpalette-initializefrompalette
    HRESULT InitializeFromPalette(IWICPalette pIPalette);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpalette-gettype
    HRESULT GetType(WICBitmapPaletteType* pePaletteType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpalette-getcolorcount
    HRESULT GetColorCount(uint* pcCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpalette-getcolors
    HRESULT GetColors(uint cCount, uint* pColors, uint* pcActualColors);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpalette-isblackwhite
    HRESULT IsBlackWhite(BOOL* pfIsBlackWhite);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpalette-isgrayscale
    HRESULT IsGrayscale(BOOL* pfIsGrayscale);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpalette-hasalpha
    HRESULT HasAlpha(BOOL* pfHasAlpha);
}

@GUID("00000120-a8f2-4877-ba0a-fd2b6645fb94")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmapsource
interface IWICBitmapSource : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapsource-getsize
    HRESULT GetSize(uint* puiWidth, uint* puiHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapsource-getpixelformat
    HRESULT GetPixelFormat(GUID* pPixelFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapsource-getresolution
    HRESULT GetResolution(double* pDpiX, double* pDpiY);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapsource-copypalette
    HRESULT CopyPalette(IWICPalette pIPalette);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapsource-copypixels
    HRESULT CopyPixels(const(WICRect)* prc, uint cbStride, uint cbBufferSize, ubyte* pbBuffer);
}

@GUID("00000301-a8f2-4877-ba0a-fd2b6645fb94")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicformatconverter
interface IWICFormatConverter : IWICBitmapSource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicformatconverter-initialize
    HRESULT Initialize(IWICBitmapSource pISource, GUID* dstFormat, WICBitmapDitherType dither, 
                       IWICPalette pIPalette, double alphaThresholdPercent, WICBitmapPaletteType paletteTranslate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicformatconverter-canconvert
    HRESULT CanConvert(GUID* srcPixelFormat, GUID* dstPixelFormat, BOOL* pfCanConvert);
}

@GUID("bebee9cb-83b0-4dcc-8132-b0aaa55eac96")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicplanarformatconverter
interface IWICPlanarFormatConverter : IWICBitmapSource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicplanarformatconverter-initialize
    HRESULT Initialize(IWICBitmapSource* ppPlanes, uint cPlanes, GUID* dstFormat, WICBitmapDitherType dither, 
                       IWICPalette pIPalette, double alphaThresholdPercent, WICBitmapPaletteType paletteTranslate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicplanarformatconverter-canconvert
    HRESULT CanConvert(const(GUID)* pSrcPixelFormats, uint cSrcPlanes, GUID* dstPixelFormat, BOOL* pfCanConvert);
}

@GUID("00000302-a8f2-4877-ba0a-fd2b6645fb94")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmapscaler
interface IWICBitmapScaler : IWICBitmapSource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapscaler-initialize
    HRESULT Initialize(IWICBitmapSource pISource, uint uiWidth, uint uiHeight, WICBitmapInterpolationMode mode);
}

@GUID("e4fbcf03-223d-4e81-9333-d635556dd1b5")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmapclipper
interface IWICBitmapClipper : IWICBitmapSource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapclipper-initialize
    HRESULT Initialize(IWICBitmapSource pISource, const(WICRect)* prc);
}

@GUID("5009834f-2d6a-41ce-9e1b-17c5aff7a782")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmapfliprotator
interface IWICBitmapFlipRotator : IWICBitmapSource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapfliprotator-initialize
    HRESULT Initialize(IWICBitmapSource pISource, WICBitmapTransformOptions options);
}

@GUID("44728ded-1edf-4fe9-b50b-c89a264c9439")
interface IWICBitmapToneMapper : IWICBitmapSource
{
    HRESULT InitializeForHdrTarget(IWICBitmapSource pISource, GUID* guidDstFormat, float fLuminanceInNits, 
                                   float fWhiteLevelInNits, WICBitmapToneMappingMode mode);
    HRESULT InitializeForSdrTarget(IWICBitmapSource pISource, GUID* guidDstFormat, WICBitmapToneMappingMode mode);
}

@GUID("00000123-a8f2-4877-ba0a-fd2b6645fb94")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmaplock
interface IWICBitmapLock : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmaplock-getsize
    HRESULT GetSize(uint* puiWidth, uint* puiHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmaplock-getstride
    HRESULT GetStride(uint* pcbStride);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmaplock-getdatapointer
    HRESULT GetDataPointer(uint* pcbBufferSize, ubyte** ppbData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmaplock-getpixelformat
    HRESULT GetPixelFormat(GUID* pPixelFormat);
}

@GUID("00000121-a8f2-4877-ba0a-fd2b6645fb94")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmap
interface IWICBitmap : IWICBitmapSource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmap-lock
    HRESULT Lock(const(WICRect)* prcLock, uint flags, IWICBitmapLock* ppILock);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmap-setpalette
    HRESULT SetPalette(IWICPalette pIPalette);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmap-setresolution
    HRESULT SetResolution(double dpiX, double dpiY);
}

@GUID("3c613a02-34b2-44ea-9a7c-45aea9c6fd6d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwiccolorcontext
interface IWICColorContext : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccolorcontext-initializefromfilename
    HRESULT InitializeFromFilename(const(PWSTR) wzFilename);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccolorcontext-initializefrommemory
    HRESULT InitializeFromMemory(const(ubyte)* pbBuffer, uint cbBufferSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccolorcontext-initializefromexifcolorspace
    HRESULT InitializeFromExifColorSpace(uint value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccolorcontext-gettype
    HRESULT GetType(WICColorContextType* pType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccolorcontext-getprofilebytes
    HRESULT GetProfileBytes(uint cbBuffer, ubyte* pbBuffer, uint* pcbActual);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccolorcontext-getexifcolorspace
    HRESULT GetExifColorSpace(uint* pValue);
}

@GUID("b66f034f-d0e2-40ab-b436-6de39e321a94")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwiccolortransform
interface IWICColorTransform : IWICBitmapSource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccolortransform-initialize
    HRESULT Initialize(IWICBitmapSource pIBitmapSource, IWICColorContext pIContextSource, 
                       IWICColorContext pIContextDest, GUID* pixelFmtDest);
}

@GUID("b84e2c09-78c9-4ac4-8bd3-524ae1663a2f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicfastmetadataencoder
interface IWICFastMetadataEncoder : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicfastmetadataencoder-commit
    HRESULT Commit();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicfastmetadataencoder-getmetadataquerywriter
    HRESULT GetMetadataQueryWriter(IWICMetadataQueryWriter* ppIMetadataQueryWriter);
}

@GUID("135ff860-22b7-4ddf-b0f6-218f4f299a43")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicstream
interface IWICStream : IStream
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicstream-initializefromistream
    HRESULT InitializeFromIStream(IStream pIStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicstream-initializefromfilename
    HRESULT InitializeFromFilename(const(PWSTR) wzFileName, uint dwDesiredAccess);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicstream-initializefrommemory
    HRESULT InitializeFromMemory(ubyte* pbBuffer, uint cbBufferSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicstream-initializefromistreamregion
    HRESULT InitializeFromIStreamRegion(IStream pIStream, ulong ulOffset, ulong ulMaxSize);
}

@GUID("dc2bb46d-3f07-481e-8625-220c4aedbb33")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicenummetadataitem
interface IWICEnumMetadataItem : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicenummetadataitem-next
    HRESULT Next(uint celt, PROPVARIANT* rgeltSchema, PROPVARIANT* rgeltId, PROPVARIANT* rgeltValue, 
                 uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicenummetadataitem-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicenummetadataitem-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicenummetadataitem-clone
    HRESULT Clone(IWICEnumMetadataItem* ppIEnumMetadataItem);
}

@GUID("30989668-e1c9-4597-b395-458eedb808df")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicmetadataqueryreader
interface IWICMetadataQueryReader : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicmetadataqueryreader-getcontainerformat
    HRESULT GetContainerFormat(GUID* pguidContainerFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicmetadataqueryreader-getlocation
    HRESULT GetLocation(uint cchMaxLength, PWSTR wzNamespace, uint* pcchActualLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicmetadataqueryreader-getmetadatabyname
    HRESULT GetMetadataByName(const(PWSTR) wzName, PROPVARIANT* pvarValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicmetadataqueryreader-getenumerator
    HRESULT GetEnumerator(IEnumString* ppIEnumString);
}

@GUID("a721791a-0def-4d06-bd91-2118bf1db10b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicmetadataquerywriter
interface IWICMetadataQueryWriter : IWICMetadataQueryReader
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicmetadataquerywriter-setmetadatabyname
    HRESULT SetMetadataByName(const(PWSTR) wzName, const(PROPVARIANT)* pvarValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicmetadataquerywriter-removemetadatabyname
    HRESULT RemoveMetadataByName(const(PWSTR) wzName);
}

@GUID("00000103-a8f2-4877-ba0a-fd2b6645fb94")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmapencoder
interface IWICBitmapEncoder : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapencoder-initialize
    HRESULT Initialize(IStream pIStream, WICBitmapEncoderCacheOption cacheOption);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapencoder-getcontainerformat
    HRESULT GetContainerFormat(GUID* pguidContainerFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapencoder-getencoderinfo
    HRESULT GetEncoderInfo(IWICBitmapEncoderInfo* ppIEncoderInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapencoder-setcolorcontexts
    HRESULT SetColorContexts(uint cCount, IWICColorContext* ppIColorContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapencoder-setpalette
    HRESULT SetPalette(IWICPalette pIPalette);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapencoder-setthumbnail
    HRESULT SetThumbnail(IWICBitmapSource pIThumbnail);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapencoder-setpreview
    HRESULT SetPreview(IWICBitmapSource pIPreview);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapencoder-createnewframe
    HRESULT CreateNewFrame(IWICBitmapFrameEncode* ppIFrameEncode, IPropertyBag2* ppIEncoderOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapencoder-commit
    HRESULT Commit();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapencoder-getmetadataquerywriter
    HRESULT GetMetadataQueryWriter(IWICMetadataQueryWriter* ppIMetadataQueryWriter);
}

@GUID("00000105-a8f2-4877-ba0a-fd2b6645fb94")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmapframeencode
interface IWICBitmapFrameEncode : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapframeencode-initialize
    HRESULT Initialize(IPropertyBag2 pIEncoderOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapframeencode-setsize
    HRESULT SetSize(uint uiWidth, uint uiHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapframeencode-setresolution
    HRESULT SetResolution(double dpiX, double dpiY);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapframeencode-setpixelformat
    HRESULT SetPixelFormat(GUID* pPixelFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapframeencode-setcolorcontexts
    HRESULT SetColorContexts(uint cCount, IWICColorContext* ppIColorContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapframeencode-setpalette
    HRESULT SetPalette(IWICPalette pIPalette);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapframeencode-setthumbnail
    HRESULT SetThumbnail(IWICBitmapSource pIThumbnail);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapframeencode-writepixels
    HRESULT WritePixels(uint lineCount, uint cbStride, uint cbBufferSize, ubyte* pbPixels);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapframeencode-writesource
    HRESULT WriteSource(IWICBitmapSource pIBitmapSource, WICRect* prc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapframeencode-commit
    HRESULT Commit();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapframeencode-getmetadataquerywriter
    HRESULT GetMetadataQueryWriter(IWICMetadataQueryWriter* ppIMetadataQueryWriter);
}

@GUID("f928b7b8-2221-40c1-b72e-7e82f1974d1a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicplanarbitmapframeencode
interface IWICPlanarBitmapFrameEncode : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicplanarbitmapframeencode-writepixels
    HRESULT WritePixels(uint lineCount, WICBitmapPlane* pPlanes, uint cPlanes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicplanarbitmapframeencode-writesource
    HRESULT WriteSource(IWICBitmapSource* ppPlanes, uint cPlanes, WICRect* prcSource);
}

@GUID("9edde9e7-8dee-47ea-99df-e6faf2ed44bf")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmapdecoder
interface IWICBitmapDecoder : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapdecoder-querycapability
    HRESULT QueryCapability(IStream pIStream, uint* pdwCapability);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapdecoder-initialize
    HRESULT Initialize(IStream pIStream, WICDecodeOptions cacheOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapdecoder-getcontainerformat
    HRESULT GetContainerFormat(GUID* pguidContainerFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapdecoder-getdecoderinfo
    HRESULT GetDecoderInfo(IWICBitmapDecoderInfo* ppIDecoderInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapdecoder-copypalette
    HRESULT CopyPalette(IWICPalette pIPalette);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapdecoder-getmetadataqueryreader
    HRESULT GetMetadataQueryReader(IWICMetadataQueryReader* ppIMetadataQueryReader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapdecoder-getpreview
    HRESULT GetPreview(IWICBitmapSource* ppIBitmapSource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapdecoder-getcolorcontexts
    HRESULT GetColorContexts(uint cCount, IWICColorContext* ppIColorContexts, uint* pcActualCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapdecoder-getthumbnail
    HRESULT GetThumbnail(IWICBitmapSource* ppIThumbnail);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapdecoder-getframecount
    HRESULT GetFrameCount(uint* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapdecoder-getframe
    HRESULT GetFrame(uint index, IWICBitmapFrameDecode* ppIBitmapFrame);
}

@GUID("3b16811b-6a43-4ec9-b713-3d5a0c13b940")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmapsourcetransform
interface IWICBitmapSourceTransform : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapsourcetransform-copypixels
    HRESULT CopyPixels(const(WICRect)* prc, uint uiWidth, uint uiHeight, GUID* pguidDstFormat, 
                       WICBitmapTransformOptions dstTransform, uint nStride, uint cbBufferSize, ubyte* pbBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapsourcetransform-getclosestsize
    HRESULT GetClosestSize(uint* puiWidth, uint* puiHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapsourcetransform-getclosestpixelformat
    HRESULT GetClosestPixelFormat(GUID* pguidDstFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapsourcetransform-doessupporttransform
    HRESULT DoesSupportTransform(WICBitmapTransformOptions dstTransform, BOOL* pfIsSupported);
}

@GUID("c3373fdf-6d39-4e5f-8e79-bf40c0b7ed77")
interface IWICBitmapSourceTransform2 : IWICBitmapSourceTransform
{
    HRESULT GetColorContextsForPixelFormat(GUID* pPixelFormat, uint cCount, IWICColorContext* ppIColorContexts, 
                                           uint* pcActualCount);
}

@GUID("3aff9cce-be95-4303-b927-e7d16ff4a613")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicplanarbitmapsourcetransform
interface IWICPlanarBitmapSourceTransform : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicplanarbitmapsourcetransform-doessupporttransform
    HRESULT DoesSupportTransform(uint* puiWidth, uint* puiHeight, WICBitmapTransformOptions dstTransform, 
                                 WICPlanarOptions dstPlanarOptions, const(GUID)* pguidDstFormats, 
                                 WICBitmapPlaneDescription* pPlaneDescriptions, uint cPlanes, BOOL* pfIsSupported);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicplanarbitmapsourcetransform-copypixels
    HRESULT CopyPixels(const(WICRect)* prcSource, uint uiWidth, uint uiHeight, 
                       WICBitmapTransformOptions dstTransform, WICPlanarOptions dstPlanarOptions, 
                       const(WICBitmapPlane)* pDstPlanes, uint cPlanes);
}

@GUID("3b16811b-6a43-4ec9-a813-3d930c13b940")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmapframedecode
interface IWICBitmapFrameDecode : IWICBitmapSource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapframedecode-getmetadataqueryreader
    HRESULT GetMetadataQueryReader(IWICMetadataQueryReader* ppIMetadataQueryReader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapframedecode-getcolorcontexts
    HRESULT GetColorContexts(uint cCount, IWICColorContext* ppIColorContexts, uint* pcActualCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapframedecode-getthumbnail
    HRESULT GetThumbnail(IWICBitmapSource* ppIThumbnail);
}

@GUID("0c599495-a120-4222-9130-a8c29410bd0b")
interface IWICBitmapFrameChainReader : IUnknown
{
    HRESULT GetChainedFrameCount(WICBitmapChainType chainType, uint* pCount);
    HRESULT GetChainedFrame(WICBitmapChainType chainType, uint index, IWICBitmapFrameDecode* ppIBitmapFrame);
}

@GUID("40d9ea28-4768-47b3-8c12-558a48e98e38")
interface IWICBitmapFrameChainWriter : IUnknown
{
    HRESULT AppendFrameToChain(WICBitmapChainType chainType, IWICBitmapFrameEncode* ppIFrameEncode, 
                               IPropertyBag2* ppIEncoderOptions);
    HRESULT DoesSupportChainType(WICBitmapChainType chainType, BOOL* pfIsSupported);
}

@GUID("daac296f-7aa5-4dbf-8d15-225c5976f891")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicprogressivelevelcontrol
interface IWICProgressiveLevelControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicprogressivelevelcontrol-getlevelcount
    HRESULT GetLevelCount(uint* pcLevels);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicprogressivelevelcontrol-getcurrentlevel
    HRESULT GetCurrentLevel(uint* pnLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicprogressivelevelcontrol-setcurrentlevel
    HRESULT SetCurrentLevel(uint nLevel);
}

@GUID("de9d91d2-70b4-4f41-836c-25fcd39626d3")
interface IWICDisplayAdaptationControl : IUnknown
{
    HRESULT DoesSupportChangingMaxLuminance(GUID* pguidDstFormat, BOOL* pfIsSupported);
    HRESULT SetDisplayMaxLuminance(float fLuminanceInNits);
    HRESULT GetDisplayMaxLuminance(float* pfLuminanceInNits);
}

@GUID("d7508d29-3ab7-447e-a676-4d80d7de726b")
interface IWICDisplayAdaptationControl2 : IWICDisplayAdaptationControl
{
    HRESULT SetSdrWhiteLevel(float fWhiteLevelInNits);
    HRESULT GetSdrWhiteLevel(float* pfWhiteLevelInNits);
    HRESULT SetToneMappingMode(WICBitmapToneMappingMode mode);
    HRESULT GetToneMappingMode(WICBitmapToneMappingMode* mode);
    HRESULT DoesSupportToneMappingMode(WICBitmapToneMappingMode mode, BOOL* pfIsSupported);
}

@GUID("caf65cc4-8ebe-4718-a21f-8dbf40bb7e25")
interface IWICD3DTextureSource : IUnknown
{
    HRESULT GetTexture(IUnknown pD3DDevice, IPropertyBag2 pID3DTextureOptions, const(GUID)* riid, void** ppTexture);
    HRESULT GetTransformedTexture(const(WICRect)* prc, uint uiWidth, uint uiHeight, const(GUID)* pguidDstFormat, 
                                  WICBitmapTransformOptions dstTransform, IUnknown pD3DDevice, 
                                  IPropertyBag2 pID3DTextureOptions, const(GUID)* riid, void** ppTexture);
    HRESULT DoesSupportD3DDeviceType(const(GUID)* riid, BOOL* pfIsSupported);
    HRESULT GetD3DTextureOptions(IPropertyBag2* ppID3DTextureOptions);
}

@GUID("4776f9cd-9517-45fa-bf24-e89c5ec5c60c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicprogresscallback
interface IWICProgressCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicprogresscallback-notify
    HRESULT Notify(uint uFrameNum, WICProgressOperation operation, double dblProgress);
}

@GUID("64c1024e-c3cf-4462-8078-88c2b11c46d9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmapcodecprogressnotification
interface IWICBitmapCodecProgressNotification : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapcodecprogressnotification-registerprogressnotification
    HRESULT RegisterProgressNotification(PFNProgressNotification pfnProgressNotification, void* pvData, 
                                         uint dwProgressFlags);
}

@GUID("23bc3f0a-698b-4357-886b-f24d50671334")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwiccomponentinfo
interface IWICComponentInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccomponentinfo-getcomponenttype
    HRESULT GetComponentType(WICComponentType* pType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccomponentinfo-getclsid
    HRESULT GetCLSID(GUID* pclsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccomponentinfo-getsigningstatus
    HRESULT GetSigningStatus(uint* pStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccomponentinfo-getauthor
    HRESULT GetAuthor(uint cchAuthor, PWSTR wzAuthor, uint* pcchActual);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccomponentinfo-getvendorguid
    HRESULT GetVendorGUID(GUID* pguidVendor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccomponentinfo-getversion
    HRESULT GetVersion(uint cchVersion, PWSTR wzVersion, uint* pcchActual);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccomponentinfo-getspecversion
    HRESULT GetSpecVersion(uint cchSpecVersion, PWSTR wzSpecVersion, uint* pcchActual);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccomponentinfo-getfriendlyname
    HRESULT GetFriendlyName(uint cchFriendlyName, PWSTR wzFriendlyName, uint* pcchActual);
}

@GUID("9f34fb65-13f4-4f15-bc57-3726b5e53d9f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicformatconverterinfo
interface IWICFormatConverterInfo : IWICComponentInfo
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicformatconverterinfo-getpixelformats
    HRESULT GetPixelFormats(uint cFormats, GUID* pPixelFormatGUIDs, uint* pcActual);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicformatconverterinfo-createinstance
    HRESULT CreateInstance(IWICFormatConverter* ppIConverter);
}

@GUID("e87a44c4-b76e-4c47-8b09-298eb12a2714")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmapcodecinfo
interface IWICBitmapCodecInfo : IWICComponentInfo
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapcodecinfo-getcontainerformat
    HRESULT GetContainerFormat(GUID* pguidContainerFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapcodecinfo-getpixelformats
    HRESULT GetPixelFormats(uint cFormats, GUID* pguidPixelFormats, uint* pcActual);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapcodecinfo-getcolormanagementversion
    HRESULT GetColorManagementVersion(uint cchColorManagementVersion, PWSTR wzColorManagementVersion, 
                                      uint* pcchActual);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapcodecinfo-getdevicemanufacturer
    HRESULT GetDeviceManufacturer(uint cchDeviceManufacturer, PWSTR wzDeviceManufacturer, uint* pcchActual);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapcodecinfo-getdevicemodels
    HRESULT GetDeviceModels(uint cchDeviceModels, PWSTR wzDeviceModels, uint* pcchActual);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapcodecinfo-getmimetypes
    HRESULT GetMimeTypes(uint cchMimeTypes, PWSTR wzMimeTypes, uint* pcchActual);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapcodecinfo-getfileextensions
    HRESULT GetFileExtensions(uint cchFileExtensions, PWSTR wzFileExtensions, uint* pcchActual);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapcodecinfo-doessupportanimation
    HRESULT DoesSupportAnimation(BOOL* pfSupportAnimation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapcodecinfo-doessupportchromakey
    HRESULT DoesSupportChromakey(BOOL* pfSupportChromakey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapcodecinfo-doessupportlossless
    HRESULT DoesSupportLossless(BOOL* pfSupportLossless);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapcodecinfo-doessupportmultiframe
    HRESULT DoesSupportMultiframe(BOOL* pfSupportMultiframe);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapcodecinfo-matchesmimetype
    HRESULT MatchesMimeType(const(PWSTR) wzMimeType, BOOL* pfMatches);
}

@GUID("94c9b4ee-a09f-4f92-8a1e-4a9bce7e76fb")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmapencoderinfo
interface IWICBitmapEncoderInfo : IWICBitmapCodecInfo
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapencoderinfo-createinstance
    HRESULT CreateInstance(IWICBitmapEncoder* ppIBitmapEncoder);
}

@GUID("d8cd007f-d08f-4191-9bfc-236ea7f0e4b5")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmapdecoderinfo
interface IWICBitmapDecoderInfo : IWICBitmapCodecInfo
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapdecoderinfo-getpatterns
    HRESULT GetPatterns(uint cbSizePatterns, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/WICBitmapPattern* pPatterns, 
                        uint* pcPatterns, uint* pcbPatternsActual);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapdecoderinfo-matchespattern
    HRESULT MatchesPattern(IStream pIStream, BOOL* pfMatches);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapdecoderinfo-createinstance
    HRESULT CreateInstance(IWICBitmapDecoder* ppIBitmapDecoder);
}

@GUID("e8eda601-3d48-431a-ab44-69059be88bbe")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicpixelformatinfo
interface IWICPixelFormatInfo : IWICComponentInfo
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpixelformatinfo-getformatguid
    HRESULT GetFormatGUID(GUID* pFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpixelformatinfo-getcolorcontext
    HRESULT GetColorContext(IWICColorContext* ppIColorContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpixelformatinfo-getbitsperpixel
    HRESULT GetBitsPerPixel(uint* puiBitsPerPixel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpixelformatinfo-getchannelcount
    HRESULT GetChannelCount(uint* puiChannelCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpixelformatinfo-getchannelmask
    HRESULT GetChannelMask(uint uiChannelIndex, uint cbMaskBuffer, ubyte* pbMaskBuffer, uint* pcbActual);
}

@GUID("a9db33a2-af5f-43c7-b679-74f5984b5aa4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicpixelformatinfo2
interface IWICPixelFormatInfo2 : IWICPixelFormatInfo
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpixelformatinfo2-supportstransparency
    HRESULT SupportsTransparency(BOOL* pfSupportsTransparency);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpixelformatinfo2-getnumericrepresentation
    HRESULT GetNumericRepresentation(WICPixelFormatNumericRepresentation* pNumericRepresentation);
}

@GUID("ec5ec8a9-c395-4314-9c77-54d7a935ff70")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicimagingfactory
interface IWICImagingFactory : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createdecoderfromfilename
    HRESULT CreateDecoderFromFilename(const(PWSTR) wzFilename, const(GUID)* pguidVendor, 
                                      GENERIC_ACCESS_RIGHTS dwDesiredAccess, WICDecodeOptions metadataOptions, 
                                      IWICBitmapDecoder* ppIDecoder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createdecoderfromstream
    HRESULT CreateDecoderFromStream(IStream pIStream, const(GUID)* pguidVendor, WICDecodeOptions metadataOptions, 
                                    IWICBitmapDecoder* ppIDecoder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createdecoderfromfilehandle
    HRESULT CreateDecoderFromFileHandle(size_t hFile, const(GUID)* pguidVendor, WICDecodeOptions metadataOptions, 
                                        IWICBitmapDecoder* ppIDecoder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createcomponentinfo
    HRESULT CreateComponentInfo(const(GUID)* clsidComponent, IWICComponentInfo* ppIInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createdecoder
    HRESULT CreateDecoder(const(GUID)* guidContainerFormat, const(GUID)* pguidVendor, 
                          IWICBitmapDecoder* ppIDecoder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createencoder
    HRESULT CreateEncoder(const(GUID)* guidContainerFormat, const(GUID)* pguidVendor, 
                          IWICBitmapEncoder* ppIEncoder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createpalette
    HRESULT CreatePalette(IWICPalette* ppIPalette);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createformatconverter
    HRESULT CreateFormatConverter(IWICFormatConverter* ppIFormatConverter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createbitmapscaler
    HRESULT CreateBitmapScaler(IWICBitmapScaler* ppIBitmapScaler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createbitmapclipper
    HRESULT CreateBitmapClipper(IWICBitmapClipper* ppIBitmapClipper);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createbitmapfliprotator
    HRESULT CreateBitmapFlipRotator(IWICBitmapFlipRotator* ppIBitmapFlipRotator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createstream
    HRESULT CreateStream(IWICStream* ppIWICStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createcolorcontext
    HRESULT CreateColorContext(IWICColorContext* ppIWICColorContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createcolortransformer
    HRESULT CreateColorTransformer(IWICColorTransform* ppIWICColorTransform);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createbitmap
    HRESULT CreateBitmap(uint uiWidth, uint uiHeight, GUID* pixelFormat, WICBitmapCreateCacheOption option, 
                         IWICBitmap* ppIBitmap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createbitmapfromsource
    HRESULT CreateBitmapFromSource(IWICBitmapSource pIBitmapSource, WICBitmapCreateCacheOption option, 
                                   IWICBitmap* ppIBitmap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createbitmapfromsourcerect
    HRESULT CreateBitmapFromSourceRect(IWICBitmapSource pIBitmapSource, uint x, uint y, uint width, uint height, 
                                       IWICBitmap* ppIBitmap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createbitmapfrommemory
    HRESULT CreateBitmapFromMemory(uint uiWidth, uint uiHeight, GUID* pixelFormat, uint cbStride, 
                                   uint cbBufferSize, ubyte* pbBuffer, IWICBitmap* ppIBitmap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createbitmapfromhbitmap
    HRESULT CreateBitmapFromHBITMAP(HBITMAP hBitmap, HPALETTE hPalette, WICBitmapAlphaChannelOption options, 
                                    IWICBitmap* ppIBitmap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createbitmapfromhicon
    HRESULT CreateBitmapFromHICON(HICON hIcon, IWICBitmap* ppIBitmap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createcomponentenumerator
    HRESULT CreateComponentEnumerator(uint componentTypes, uint options, IEnumUnknown* ppIEnumUnknown);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createfastmetadataencoderfromdecoder
    HRESULT CreateFastMetadataEncoderFromDecoder(IWICBitmapDecoder pIDecoder, 
                                                 IWICFastMetadataEncoder* ppIFastEncoder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createfastmetadataencoderfromframedecode
    HRESULT CreateFastMetadataEncoderFromFrameDecode(IWICBitmapFrameDecode pIFrameDecoder, 
                                                     IWICFastMetadataEncoder* ppIFastEncoder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createquerywriter
    HRESULT CreateQueryWriter(const(GUID)* guidMetadataFormat, const(GUID)* pguidVendor, 
                              IWICMetadataQueryWriter* ppIQueryWriter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createquerywriterfromreader
    HRESULT CreateQueryWriterFromReader(IWICMetadataQueryReader pIQueryReader, const(GUID)* pguidVendor, 
                                        IWICMetadataQueryWriter* ppIQueryWriter);
}

@GUID("95c75a6e-3e8c-4ec2-85a8-aebcc551e59b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicdeveloprawnotificationcallback
interface IWICDevelopRawNotificationCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdeveloprawnotificationcallback-notify
    HRESULT Notify(uint NotificationMask);
}

@GUID("fbec5e44-f7be-4b65-b7f8-c0c81fef026d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicdevelopraw
interface IWICDevelopRaw : IWICBitmapFrameDecode
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-queryrawcapabilitiesinfo
    HRESULT QueryRawCapabilitiesInfo(WICRawCapabilitiesInfo* pInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-loadparameterset
    HRESULT LoadParameterSet(WICRawParameterSet ParameterSet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-getcurrentparameterset
    HRESULT GetCurrentParameterSet(IPropertyBag2* ppCurrentParameterSet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-setexposurecompensation
    HRESULT SetExposureCompensation(double ev);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-getexposurecompensation
    HRESULT GetExposureCompensation(double* pEV);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-setwhitepointrgb
    HRESULT SetWhitePointRGB(uint Red, uint Green, uint Blue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-getwhitepointrgb
    HRESULT GetWhitePointRGB(uint* pRed, uint* pGreen, uint* pBlue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-setnamedwhitepoint
    HRESULT SetNamedWhitePoint(WICNamedWhitePoint WhitePoint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-getnamedwhitepoint
    HRESULT GetNamedWhitePoint(WICNamedWhitePoint* pWhitePoint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-setwhitepointkelvin
    HRESULT SetWhitePointKelvin(uint WhitePointKelvin);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-getwhitepointkelvin
    HRESULT GetWhitePointKelvin(uint* pWhitePointKelvin);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-getkelvinrangeinfo
    HRESULT GetKelvinRangeInfo(uint* pMinKelvinTemp, uint* pMaxKelvinTemp, uint* pKelvinTempStepValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-setcontrast
    HRESULT SetContrast(double Contrast);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-getcontrast
    HRESULT GetContrast(double* pContrast);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-setgamma
    HRESULT SetGamma(double Gamma);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-getgamma
    HRESULT GetGamma(double* pGamma);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-setsharpness
    HRESULT SetSharpness(double Sharpness);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-getsharpness
    HRESULT GetSharpness(double* pSharpness);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-setsaturation
    HRESULT SetSaturation(double Saturation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-getsaturation
    HRESULT GetSaturation(double* pSaturation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-settint
    HRESULT SetTint(double Tint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-gettint
    HRESULT GetTint(double* pTint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-setnoisereduction
    HRESULT SetNoiseReduction(double NoiseReduction);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-getnoisereduction
    HRESULT GetNoiseReduction(double* pNoiseReduction);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-setdestinationcolorcontext
    HRESULT SetDestinationColorContext(IWICColorContext pColorContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-settonecurve
    HRESULT SetToneCurve(uint cbToneCurveSize, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/const(WICRawToneCurve)* pToneCurve);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-gettonecurve
    HRESULT GetToneCurve(uint cbToneCurveBufferSize, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/WICRawToneCurve* pToneCurve, 
                         uint* pcbActualToneCurveBufferSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-setrotation
    HRESULT SetRotation(double Rotation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-getrotation
    HRESULT GetRotation(double* pRotation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-setrendermode
    HRESULT SetRenderMode(WICRawRenderMode RenderMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-getrendermode
    HRESULT GetRenderMode(WICRawRenderMode* pRenderMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-setnotificationcallback
    HRESULT SetNotificationCallback(IWICDevelopRawNotificationCallback pCallback);
}

@GUID("409cd537-8532-40cb-9774-e2feb2df4e9c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicddsdecoder
interface IWICDdsDecoder : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicddsdecoder-getparameters
    HRESULT GetParameters(WICDdsParameters* pParameters);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicddsdecoder-getframe
    HRESULT GetFrame(uint arrayIndex, uint mipLevel, uint sliceIndex, IWICBitmapFrameDecode* ppIBitmapFrame);
}

@GUID("5cacdb4c-407e-41b3-b936-d0f010cd6732")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicddsencoder
interface IWICDdsEncoder : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicddsencoder-setparameters
    HRESULT SetParameters(WICDdsParameters* pParameters);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicddsencoder-getparameters
    HRESULT GetParameters(WICDdsParameters* pParameters);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicddsencoder-createnewframe
    HRESULT CreateNewFrame(IWICBitmapFrameEncode* ppIFrameEncode, uint* pArrayIndex, uint* pMipLevel, 
                           uint* pSliceIndex);
}

@GUID("3d4c0c61-18a4-41e4-bd80-481a4fc9f464")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicddsframedecode
interface IWICDdsFrameDecode : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicddsframedecode-getsizeinblocks
    HRESULT GetSizeInBlocks(uint* pWidthInBlocks, uint* pHeightInBlocks);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicddsframedecode-getformatinfo
    HRESULT GetFormatInfo(WICDdsFormatInfo* pFormatInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicddsframedecode-copyblocks
    HRESULT CopyBlocks(const(WICRect)* prcBoundsInBlocks, uint cbStride, uint cbBufferSize, ubyte* pbBuffer);
}

@GUID("8939f66e-c46a-4c21-a9d1-98b327ce1679")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicjpegframedecode
interface IWICJpegFrameDecode : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicjpegframedecode-doessupportindexing
    HRESULT DoesSupportIndexing(BOOL* pfIndexingSupported);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicjpegframedecode-setindexing
    HRESULT SetIndexing(WICJpegIndexingOptions options, uint horizontalIntervalSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicjpegframedecode-clearindexing
    HRESULT ClearIndexing();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicjpegframedecode-getachuffmantable
    HRESULT GetAcHuffmanTable(uint scanIndex, uint tableIndex, DXGI_JPEG_AC_HUFFMAN_TABLE* pAcHuffmanTable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicjpegframedecode-getdchuffmantable
    HRESULT GetDcHuffmanTable(uint scanIndex, uint tableIndex, DXGI_JPEG_DC_HUFFMAN_TABLE* pDcHuffmanTable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicjpegframedecode-getquantizationtable
    HRESULT GetQuantizationTable(uint scanIndex, uint tableIndex, DXGI_JPEG_QUANTIZATION_TABLE* pQuantizationTable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicjpegframedecode-getframeheader
    HRESULT GetFrameHeader(WICJpegFrameHeader* pFrameHeader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicjpegframedecode-getscanheader
    HRESULT GetScanHeader(uint scanIndex, WICJpegScanHeader* pScanHeader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicjpegframedecode-copyscan
    HRESULT CopyScan(uint scanIndex, uint scanOffset, uint cbScanData, ubyte* pbScanData, uint* pcbScanDataActual);
    HRESULT CopyMinimalStream(uint streamOffset, uint cbStreamData, ubyte* pbStreamData, uint* pcbStreamDataActual);
}

@GUID("2f0c601f-d2c6-468c-abfa-49495d983ed1")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicjpegframeencode
interface IWICJpegFrameEncode : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicjpegframeencode-getachuffmantable
    HRESULT GetAcHuffmanTable(uint scanIndex, uint tableIndex, DXGI_JPEG_AC_HUFFMAN_TABLE* pAcHuffmanTable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicjpegframeencode-getdchuffmantable
    HRESULT GetDcHuffmanTable(uint scanIndex, uint tableIndex, DXGI_JPEG_DC_HUFFMAN_TABLE* pDcHuffmanTable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicjpegframeencode-getquantizationtable
    HRESULT GetQuantizationTable(uint scanIndex, uint tableIndex, DXGI_JPEG_QUANTIZATION_TABLE* pQuantizationTable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicjpegframeencode-writescan
    HRESULT WriteScan(uint cbScanData, const(ubyte)* pbScanData);
}

@GUID("feaa2a8d-b3f3-43e4-b25c-d1de990a1ae1")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nn-wincodecsdk-iwicmetadatablockreader
interface IWICMetadataBlockReader : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatablockreader-getcontainerformat
    HRESULT GetContainerFormat(GUID* pguidContainerFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatablockreader-getcount
    HRESULT GetCount(uint* pcCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatablockreader-getreaderbyindex
    HRESULT GetReaderByIndex(uint nIndex, IWICMetadataReader* ppIMetadataReader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatablockreader-getenumerator
    HRESULT GetEnumerator(IEnumUnknown* ppIEnumMetadata);
}

@GUID("08fb9676-b444-41e8-8dbe-6a53a542bff1")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nn-wincodecsdk-iwicmetadatablockwriter
interface IWICMetadataBlockWriter : IWICMetadataBlockReader
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatablockwriter-initializefromblockreader
    HRESULT InitializeFromBlockReader(IWICMetadataBlockReader pIMDBlockReader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatablockwriter-getwriterbyindex
    HRESULT GetWriterByIndex(uint nIndex, IWICMetadataWriter* ppIMetadataWriter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatablockwriter-addwriter
    HRESULT AddWriter(IWICMetadataWriter pIMetadataWriter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatablockwriter-setwriterbyindex
    HRESULT SetWriterByIndex(uint nIndex, IWICMetadataWriter pIMetadataWriter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatablockwriter-removewriterbyindex
    HRESULT RemoveWriterByIndex(uint nIndex);
}

@GUID("9204fe99-d8fc-4fd5-a001-9536b067a899")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nn-wincodecsdk-iwicmetadatareader
interface IWICMetadataReader : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatareader-getmetadataformat
    HRESULT GetMetadataFormat(GUID* pguidMetadataFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatareader-getmetadatahandlerinfo
    HRESULT GetMetadataHandlerInfo(IWICMetadataHandlerInfo* ppIHandler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatareader-getcount
    HRESULT GetCount(uint* pcCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatareader-getvaluebyindex
    HRESULT GetValueByIndex(uint nIndex, PROPVARIANT* pvarSchema, PROPVARIANT* pvarId, PROPVARIANT* pvarValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatareader-getvalue
    HRESULT GetValue(const(PROPVARIANT)* pvarSchema, const(PROPVARIANT)* pvarId, PROPVARIANT* pvarValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatareader-getenumerator
    HRESULT GetEnumerator(IWICEnumMetadataItem* ppIEnumMetadata);
}

@GUID("f7836e16-3be0-470b-86bb-160d0aecd7de")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nn-wincodecsdk-iwicmetadatawriter
interface IWICMetadataWriter : IWICMetadataReader
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatawriter-setvalue
    HRESULT SetValue(const(PROPVARIANT)* pvarSchema, const(PROPVARIANT)* pvarId, const(PROPVARIANT)* pvarValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatawriter-setvaluebyindex
    HRESULT SetValueByIndex(uint nIndex, const(PROPVARIANT)* pvarSchema, const(PROPVARIANT)* pvarId, 
                            const(PROPVARIANT)* pvarValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatawriter-removevalue
    HRESULT RemoveValue(const(PROPVARIANT)* pvarSchema, const(PROPVARIANT)* pvarId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatawriter-removevaluebyindex
    HRESULT RemoveValueByIndex(uint nIndex);
}

@GUID("449494bc-b468-4927-96d7-ba90d31ab505")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nn-wincodecsdk-iwicstreamprovider
interface IWICStreamProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicstreamprovider-getstream
    HRESULT GetStream(IStream* ppIStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicstreamprovider-getpersistoptions
    HRESULT GetPersistOptions(uint* pdwPersistOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicstreamprovider-getpreferredvendorguid
    HRESULT GetPreferredVendorGUID(GUID* pguidPreferredVendor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicstreamprovider-refreshstream
    HRESULT RefreshStream();
}

@GUID("00675040-6908-45f8-86a3-49c7dfd6d9ad")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nn-wincodecsdk-iwicpersiststream
interface IWICPersistStream : IPersistStream
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicpersiststream-loadex
    HRESULT LoadEx(IStream pIStream, const(GUID)* pguidPreferredVendor, uint dwPersistOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicpersiststream-saveex
    HRESULT SaveEx(IStream pIStream, uint dwPersistOptions, BOOL fClearDirty);
}

@GUID("aba958bf-c672-44d1-8d61-ce6df2e682c2")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nn-wincodecsdk-iwicmetadatahandlerinfo
interface IWICMetadataHandlerInfo : IWICComponentInfo
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatahandlerinfo-getmetadataformat
    HRESULT GetMetadataFormat(GUID* pguidMetadataFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatahandlerinfo-getcontainerformats
    HRESULT GetContainerFormats(uint cContainerFormats, GUID* pguidContainerFormats, uint* pcchActual);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatahandlerinfo-getdevicemanufacturer
    HRESULT GetDeviceManufacturer(uint cchDeviceManufacturer, PWSTR wzDeviceManufacturer, uint* pcchActual);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatahandlerinfo-getdevicemodels
    HRESULT GetDeviceModels(uint cchDeviceModels, PWSTR wzDeviceModels, uint* pcchActual);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatahandlerinfo-doesrequirefullstream
    HRESULT DoesRequireFullStream(BOOL* pfRequiresFullStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatahandlerinfo-doessupportpadding
    HRESULT DoesSupportPadding(BOOL* pfSupportsPadding);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatahandlerinfo-doesrequirefixedsize
    HRESULT DoesRequireFixedSize(BOOL* pfFixedSize);
}

@GUID("eebf1f5b-07c1-4447-a3ab-22acaf78a804")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nn-wincodecsdk-iwicmetadatareaderinfo
interface IWICMetadataReaderInfo : IWICMetadataHandlerInfo
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatareaderinfo-getpatterns
    HRESULT GetPatterns(const(GUID)* guidContainerFormat, uint cbSize, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/WICMetadataPattern* pPattern, 
                        uint* pcCount, uint* pcbActual);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatareaderinfo-matchespattern
    HRESULT MatchesPattern(const(GUID)* guidContainerFormat, IStream pIStream, BOOL* pfMatches);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatareaderinfo-createinstance
    HRESULT CreateInstance(IWICMetadataReader* ppIReader);
}

@GUID("b22e3fba-3925-4323-b5c1-9ebfc430f236")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nn-wincodecsdk-iwicmetadatawriterinfo
interface IWICMetadataWriterInfo : IWICMetadataHandlerInfo
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatawriterinfo-getheader
    HRESULT GetHeader(const(GUID)* guidContainerFormat, uint cbSize, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/WICMetadataHeader* pHeader, 
                      uint* pcbActual);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatawriterinfo-createinstance
    HRESULT CreateInstance(IWICMetadataWriter* ppIWriter);
}

@GUID("412d0c3a-9650-44fa-af5b-dd2a06c8e8fb")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nn-wincodecsdk-iwiccomponentfactory
interface IWICComponentFactory : IWICImagingFactory
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwiccomponentfactory-createmetadatareader
    HRESULT CreateMetadataReader(const(GUID)* guidMetadataFormat, const(GUID)* pguidVendor, uint dwOptions, 
                                 IStream pIStream, IWICMetadataReader* ppIReader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwiccomponentfactory-createmetadatareaderfromcontainer
    HRESULT CreateMetadataReaderFromContainer(const(GUID)* guidContainerFormat, const(GUID)* pguidVendor, 
                                              uint dwOptions, IStream pIStream, IWICMetadataReader* ppIReader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwiccomponentfactory-createmetadatawriter
    HRESULT CreateMetadataWriter(const(GUID)* guidMetadataFormat, const(GUID)* pguidVendor, uint dwMetadataOptions, 
                                 IWICMetadataWriter* ppIWriter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwiccomponentfactory-createmetadatawriterfromreader
    HRESULT CreateMetadataWriterFromReader(IWICMetadataReader pIReader, const(GUID)* pguidVendor, 
                                           IWICMetadataWriter* ppIWriter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwiccomponentfactory-createqueryreaderfromblockreader
    HRESULT CreateQueryReaderFromBlockReader(IWICMetadataBlockReader pIBlockReader, 
                                             IWICMetadataQueryReader* ppIQueryReader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwiccomponentfactory-createquerywriterfromblockwriter
    HRESULT CreateQueryWriterFromBlockWriter(IWICMetadataBlockWriter pIBlockWriter, 
                                             IWICMetadataQueryWriter* ppIQueryWriter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwiccomponentfactory-createencoderpropertybag
    HRESULT CreateEncoderPropertyBag(PROPBAG2* ppropOptions, uint cCount, IPropertyBag2* ppIPropertyBag);
}


// GUIDs


const GUID IID_IWICBitmap                          = GUIDOF!IWICBitmap;
const GUID IID_IWICBitmapClipper                   = GUIDOF!IWICBitmapClipper;
const GUID IID_IWICBitmapCodecInfo                 = GUIDOF!IWICBitmapCodecInfo;
const GUID IID_IWICBitmapCodecProgressNotification = GUIDOF!IWICBitmapCodecProgressNotification;
const GUID IID_IWICBitmapDecoder                   = GUIDOF!IWICBitmapDecoder;
const GUID IID_IWICBitmapDecoderInfo               = GUIDOF!IWICBitmapDecoderInfo;
const GUID IID_IWICBitmapEncoder                   = GUIDOF!IWICBitmapEncoder;
const GUID IID_IWICBitmapEncoderInfo               = GUIDOF!IWICBitmapEncoderInfo;
const GUID IID_IWICBitmapFlipRotator               = GUIDOF!IWICBitmapFlipRotator;
const GUID IID_IWICBitmapFrameChainReader          = GUIDOF!IWICBitmapFrameChainReader;
const GUID IID_IWICBitmapFrameChainWriter          = GUIDOF!IWICBitmapFrameChainWriter;
const GUID IID_IWICBitmapFrameDecode               = GUIDOF!IWICBitmapFrameDecode;
const GUID IID_IWICBitmapFrameEncode               = GUIDOF!IWICBitmapFrameEncode;
const GUID IID_IWICBitmapLock                      = GUIDOF!IWICBitmapLock;
const GUID IID_IWICBitmapScaler                    = GUIDOF!IWICBitmapScaler;
const GUID IID_IWICBitmapSource                    = GUIDOF!IWICBitmapSource;
const GUID IID_IWICBitmapSourceTransform           = GUIDOF!IWICBitmapSourceTransform;
const GUID IID_IWICBitmapSourceTransform2          = GUIDOF!IWICBitmapSourceTransform2;
const GUID IID_IWICBitmapToneMapper                = GUIDOF!IWICBitmapToneMapper;
const GUID IID_IWICColorContext                    = GUIDOF!IWICColorContext;
const GUID IID_IWICColorTransform                  = GUIDOF!IWICColorTransform;
const GUID IID_IWICComponentFactory                = GUIDOF!IWICComponentFactory;
const GUID IID_IWICComponentInfo                   = GUIDOF!IWICComponentInfo;
const GUID IID_IWICD3DTextureSource                = GUIDOF!IWICD3DTextureSource;
const GUID IID_IWICDdsDecoder                      = GUIDOF!IWICDdsDecoder;
const GUID IID_IWICDdsEncoder                      = GUIDOF!IWICDdsEncoder;
const GUID IID_IWICDdsFrameDecode                  = GUIDOF!IWICDdsFrameDecode;
const GUID IID_IWICDevelopRaw                      = GUIDOF!IWICDevelopRaw;
const GUID IID_IWICDevelopRawNotificationCallback  = GUIDOF!IWICDevelopRawNotificationCallback;
const GUID IID_IWICDisplayAdaptationControl        = GUIDOF!IWICDisplayAdaptationControl;
const GUID IID_IWICDisplayAdaptationControl2       = GUIDOF!IWICDisplayAdaptationControl2;
const GUID IID_IWICEnumMetadataItem                = GUIDOF!IWICEnumMetadataItem;
const GUID IID_IWICFastMetadataEncoder             = GUIDOF!IWICFastMetadataEncoder;
const GUID IID_IWICFormatConverter                 = GUIDOF!IWICFormatConverter;
const GUID IID_IWICFormatConverterInfo             = GUIDOF!IWICFormatConverterInfo;
const GUID IID_IWICImagingFactory                  = GUIDOF!IWICImagingFactory;
const GUID IID_IWICJpegFrameDecode                 = GUIDOF!IWICJpegFrameDecode;
const GUID IID_IWICJpegFrameEncode                 = GUIDOF!IWICJpegFrameEncode;
const GUID IID_IWICMetadataBlockReader             = GUIDOF!IWICMetadataBlockReader;
const GUID IID_IWICMetadataBlockWriter             = GUIDOF!IWICMetadataBlockWriter;
const GUID IID_IWICMetadataHandlerInfo             = GUIDOF!IWICMetadataHandlerInfo;
const GUID IID_IWICMetadataQueryReader             = GUIDOF!IWICMetadataQueryReader;
const GUID IID_IWICMetadataQueryWriter             = GUIDOF!IWICMetadataQueryWriter;
const GUID IID_IWICMetadataReader                  = GUIDOF!IWICMetadataReader;
const GUID IID_IWICMetadataReaderInfo              = GUIDOF!IWICMetadataReaderInfo;
const GUID IID_IWICMetadataWriter                  = GUIDOF!IWICMetadataWriter;
const GUID IID_IWICMetadataWriterInfo              = GUIDOF!IWICMetadataWriterInfo;
const GUID IID_IWICPalette                         = GUIDOF!IWICPalette;
const GUID IID_IWICPersistStream                   = GUIDOF!IWICPersistStream;
const GUID IID_IWICPixelFormatInfo                 = GUIDOF!IWICPixelFormatInfo;
const GUID IID_IWICPixelFormatInfo2                = GUIDOF!IWICPixelFormatInfo2;
const GUID IID_IWICPlanarBitmapFrameEncode         = GUIDOF!IWICPlanarBitmapFrameEncode;
const GUID IID_IWICPlanarBitmapSourceTransform     = GUIDOF!IWICPlanarBitmapSourceTransform;
const GUID IID_IWICPlanarFormatConverter           = GUIDOF!IWICPlanarFormatConverter;
const GUID IID_IWICProgressCallback                = GUIDOF!IWICProgressCallback;
const GUID IID_IWICProgressiveLevelControl         = GUIDOF!IWICProgressiveLevelControl;
const GUID IID_IWICStream                          = GUIDOF!IWICStream;
const GUID IID_IWICStreamProvider                  = GUIDOF!IWICStreamProvider;
