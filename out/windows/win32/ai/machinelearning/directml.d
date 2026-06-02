// Written in the D programming language.

module windows.win32.ai.machinelearning.directml;

public import windows.core;
public import windows.win32.foundation : BOOL, HRESULT, PSTR, PWSTR;
public import windows.win32.graphics.direct3d12 : D3D12_CPU_DESCRIPTOR_HANDLE, D3D12_GPU_DESCRIPTOR_HANDLE,
                                                  ID3D12CommandList, ID3D12Device,
                                                  ID3D12Resource;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ne-directml-dml_tensor_data_type
alias DML_TENSOR_DATA_TYPE = int;
enum : int
{
    DML_TENSOR_DATA_TYPE_UNKNOWN = 0x00000000,
    DML_TENSOR_DATA_TYPE_FLOAT32 = 0x00000001,
    DML_TENSOR_DATA_TYPE_FLOAT16 = 0x00000002,
    DML_TENSOR_DATA_TYPE_UINT32  = 0x00000003,
    DML_TENSOR_DATA_TYPE_UINT16  = 0x00000004,
    DML_TENSOR_DATA_TYPE_UINT8   = 0x00000005,
    DML_TENSOR_DATA_TYPE_INT32   = 0x00000006,
    DML_TENSOR_DATA_TYPE_INT16   = 0x00000007,
    DML_TENSOR_DATA_TYPE_INT8    = 0x00000008,
    DML_TENSOR_DATA_TYPE_FLOAT64 = 0x00000009,
    DML_TENSOR_DATA_TYPE_UINT64  = 0x0000000a,
    DML_TENSOR_DATA_TYPE_INT64   = 0x0000000b,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ne-directml-dml_tensor_type
alias DML_TENSOR_TYPE = int;
enum : int
{
    DML_TENSOR_TYPE_INVALID = 0x00000000,
    DML_TENSOR_TYPE_BUFFER  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ne-directml-dml_tensor_flags
alias DML_TENSOR_FLAGS = int;
enum : int
{
    DML_TENSOR_FLAG_NONE         = 0x00000000,
    DML_TENSOR_FLAG_OWNED_BY_DML = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ne-directml-dml_operator_type
alias DML_OPERATOR_TYPE = int;
enum : int
{
    DML_OPERATOR_INVALID                                    = 0x00000000,
    DML_OPERATOR_ELEMENT_WISE_IDENTITY                      = 0x00000001,
    DML_OPERATOR_ELEMENT_WISE_ABS                           = 0x00000002,
    DML_OPERATOR_ELEMENT_WISE_ACOS                          = 0x00000003,
    DML_OPERATOR_ELEMENT_WISE_ADD                           = 0x00000004,
    DML_OPERATOR_ELEMENT_WISE_ASIN                          = 0x00000005,
    DML_OPERATOR_ELEMENT_WISE_ATAN                          = 0x00000006,
    DML_OPERATOR_ELEMENT_WISE_CEIL                          = 0x00000007,
    DML_OPERATOR_ELEMENT_WISE_CLIP                          = 0x00000008,
    DML_OPERATOR_ELEMENT_WISE_COS                           = 0x00000009,
    DML_OPERATOR_ELEMENT_WISE_DIVIDE                        = 0x0000000a,
    DML_OPERATOR_ELEMENT_WISE_EXP                           = 0x0000000b,
    DML_OPERATOR_ELEMENT_WISE_FLOOR                         = 0x0000000c,
    DML_OPERATOR_ELEMENT_WISE_LOG                           = 0x0000000d,
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_AND                   = 0x0000000e,
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_EQUALS                = 0x0000000f,
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_GREATER_THAN          = 0x00000010,
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_LESS_THAN             = 0x00000011,
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_NOT                   = 0x00000012,
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_OR                    = 0x00000013,
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_XOR                   = 0x00000014,
    DML_OPERATOR_ELEMENT_WISE_MAX                           = 0x00000015,
    DML_OPERATOR_ELEMENT_WISE_MEAN                          = 0x00000016,
    DML_OPERATOR_ELEMENT_WISE_MIN                           = 0x00000017,
    DML_OPERATOR_ELEMENT_WISE_MULTIPLY                      = 0x00000018,
    DML_OPERATOR_ELEMENT_WISE_POW                           = 0x00000019,
    DML_OPERATOR_ELEMENT_WISE_CONSTANT_POW                  = 0x0000001a,
    DML_OPERATOR_ELEMENT_WISE_RECIP                         = 0x0000001b,
    DML_OPERATOR_ELEMENT_WISE_SIN                           = 0x0000001c,
    DML_OPERATOR_ELEMENT_WISE_SQRT                          = 0x0000001d,
    DML_OPERATOR_ELEMENT_WISE_SUBTRACT                      = 0x0000001e,
    DML_OPERATOR_ELEMENT_WISE_TAN                           = 0x0000001f,
    DML_OPERATOR_ELEMENT_WISE_THRESHOLD                     = 0x00000020,
    DML_OPERATOR_ELEMENT_WISE_QUANTIZE_LINEAR               = 0x00000021,
    DML_OPERATOR_ELEMENT_WISE_DEQUANTIZE_LINEAR             = 0x00000022,
    DML_OPERATOR_ACTIVATION_ELU                             = 0x00000023,
    DML_OPERATOR_ACTIVATION_HARDMAX                         = 0x00000024,
    DML_OPERATOR_ACTIVATION_HARD_SIGMOID                    = 0x00000025,
    DML_OPERATOR_ACTIVATION_IDENTITY                        = 0x00000026,
    DML_OPERATOR_ACTIVATION_LEAKY_RELU                      = 0x00000027,
    DML_OPERATOR_ACTIVATION_LINEAR                          = 0x00000028,
    DML_OPERATOR_ACTIVATION_LOG_SOFTMAX                     = 0x00000029,
    DML_OPERATOR_ACTIVATION_PARAMETERIZED_RELU              = 0x0000002a,
    DML_OPERATOR_ACTIVATION_PARAMETRIC_SOFTPLUS             = 0x0000002b,
    DML_OPERATOR_ACTIVATION_RELU                            = 0x0000002c,
    DML_OPERATOR_ACTIVATION_SCALED_ELU                      = 0x0000002d,
    DML_OPERATOR_ACTIVATION_SCALED_TANH                     = 0x0000002e,
    DML_OPERATOR_ACTIVATION_SIGMOID                         = 0x0000002f,
    DML_OPERATOR_ACTIVATION_SOFTMAX                         = 0x00000030,
    DML_OPERATOR_ACTIVATION_SOFTPLUS                        = 0x00000031,
    DML_OPERATOR_ACTIVATION_SOFTSIGN                        = 0x00000032,
    DML_OPERATOR_ACTIVATION_TANH                            = 0x00000033,
    DML_OPERATOR_ACTIVATION_THRESHOLDED_RELU                = 0x00000034,
    DML_OPERATOR_CONVOLUTION                                = 0x00000035,
    DML_OPERATOR_GEMM                                       = 0x00000036,
    DML_OPERATOR_REDUCE                                     = 0x00000037,
    DML_OPERATOR_AVERAGE_POOLING                            = 0x00000038,
    DML_OPERATOR_LP_POOLING                                 = 0x00000039,
    DML_OPERATOR_MAX_POOLING                                = 0x0000003a,
    DML_OPERATOR_ROI_POOLING                                = 0x0000003b,
    DML_OPERATOR_SLICE                                      = 0x0000003c,
    DML_OPERATOR_CAST                                       = 0x0000003d,
    DML_OPERATOR_SPLIT                                      = 0x0000003e,
    DML_OPERATOR_JOIN                                       = 0x0000003f,
    DML_OPERATOR_PADDING                                    = 0x00000040,
    DML_OPERATOR_VALUE_SCALE_2D                             = 0x00000041,
    DML_OPERATOR_UPSAMPLE_2D                                = 0x00000042,
    DML_OPERATOR_GATHER                                     = 0x00000043,
    DML_OPERATOR_SPACE_TO_DEPTH                             = 0x00000044,
    DML_OPERATOR_DEPTH_TO_SPACE                             = 0x00000045,
    DML_OPERATOR_TILE                                       = 0x00000046,
    DML_OPERATOR_TOP_K                                      = 0x00000047,
    DML_OPERATOR_BATCH_NORMALIZATION                        = 0x00000048,
    DML_OPERATOR_MEAN_VARIANCE_NORMALIZATION                = 0x00000049,
    DML_OPERATOR_LOCAL_RESPONSE_NORMALIZATION               = 0x0000004a,
    DML_OPERATOR_LP_NORMALIZATION                           = 0x0000004b,
    DML_OPERATOR_RNN                                        = 0x0000004c,
    DML_OPERATOR_LSTM                                       = 0x0000004d,
    DML_OPERATOR_GRU                                        = 0x0000004e,
    DML_OPERATOR_ELEMENT_WISE_SIGN                          = 0x0000004f,
    DML_OPERATOR_ELEMENT_WISE_IS_NAN                        = 0x00000050,
    DML_OPERATOR_ELEMENT_WISE_ERF                           = 0x00000051,
    DML_OPERATOR_ELEMENT_WISE_SINH                          = 0x00000052,
    DML_OPERATOR_ELEMENT_WISE_COSH                          = 0x00000053,
    DML_OPERATOR_ELEMENT_WISE_TANH                          = 0x00000054,
    DML_OPERATOR_ELEMENT_WISE_ASINH                         = 0x00000055,
    DML_OPERATOR_ELEMENT_WISE_ACOSH                         = 0x00000056,
    DML_OPERATOR_ELEMENT_WISE_ATANH                         = 0x00000057,
    DML_OPERATOR_ELEMENT_WISE_IF                            = 0x00000058,
    DML_OPERATOR_ELEMENT_WISE_ADD1                          = 0x00000059,
    DML_OPERATOR_ACTIVATION_SHRINK                          = 0x0000005a,
    DML_OPERATOR_MAX_POOLING1                               = 0x0000005b,
    DML_OPERATOR_MAX_UNPOOLING                              = 0x0000005c,
    DML_OPERATOR_DIAGONAL_MATRIX                            = 0x0000005d,
    DML_OPERATOR_SCATTER_ELEMENTS                           = 0x0000005e,
    DML_OPERATOR_SCATTER                                    = 0x0000005e,
    DML_OPERATOR_ONE_HOT                                    = 0x0000005f,
    DML_OPERATOR_RESAMPLE                                   = 0x00000060,
    DML_OPERATOR_ELEMENT_WISE_BIT_SHIFT_LEFT                = 0x00000061,
    DML_OPERATOR_ELEMENT_WISE_BIT_SHIFT_RIGHT               = 0x00000062,
    DML_OPERATOR_ELEMENT_WISE_ROUND                         = 0x00000063,
    DML_OPERATOR_ELEMENT_WISE_IS_INFINITY                   = 0x00000064,
    DML_OPERATOR_ELEMENT_WISE_MODULUS_TRUNCATE              = 0x00000065,
    DML_OPERATOR_ELEMENT_WISE_MODULUS_FLOOR                 = 0x00000066,
    DML_OPERATOR_FILL_VALUE_CONSTANT                        = 0x00000067,
    DML_OPERATOR_FILL_VALUE_SEQUENCE                        = 0x00000068,
    DML_OPERATOR_CUMULATIVE_SUMMATION                       = 0x00000069,
    DML_OPERATOR_REVERSE_SUBSEQUENCES                       = 0x0000006a,
    DML_OPERATOR_GATHER_ELEMENTS                            = 0x0000006b,
    DML_OPERATOR_GATHER_ND                                  = 0x0000006c,
    DML_OPERATOR_SCATTER_ND                                 = 0x0000006d,
    DML_OPERATOR_MAX_POOLING2                               = 0x0000006e,
    DML_OPERATOR_SLICE1                                     = 0x0000006f,
    DML_OPERATOR_TOP_K1                                     = 0x00000070,
    DML_OPERATOR_DEPTH_TO_SPACE1                            = 0x00000071,
    DML_OPERATOR_SPACE_TO_DEPTH1                            = 0x00000072,
    DML_OPERATOR_MEAN_VARIANCE_NORMALIZATION1               = 0x00000073,
    DML_OPERATOR_RESAMPLE1                                  = 0x00000074,
    DML_OPERATOR_MATRIX_MULTIPLY_INTEGER                    = 0x00000075,
    DML_OPERATOR_QUANTIZED_LINEAR_MATRIX_MULTIPLY           = 0x00000076,
    DML_OPERATOR_CONVOLUTION_INTEGER                        = 0x00000077,
    DML_OPERATOR_QUANTIZED_LINEAR_CONVOLUTION               = 0x00000078,
    DML_OPERATOR_ELEMENT_WISE_BIT_AND                       = 0x00000079,
    DML_OPERATOR_ELEMENT_WISE_BIT_OR                        = 0x0000007a,
    DML_OPERATOR_ELEMENT_WISE_BIT_XOR                       = 0x0000007b,
    DML_OPERATOR_ELEMENT_WISE_BIT_NOT                       = 0x0000007c,
    DML_OPERATOR_ELEMENT_WISE_BIT_COUNT                     = 0x0000007d,
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_GREATER_THAN_OR_EQUAL = 0x0000007e,
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_LESS_THAN_OR_EQUAL    = 0x0000007f,
    DML_OPERATOR_ACTIVATION_CELU                            = 0x00000080,
    DML_OPERATOR_ACTIVATION_RELU_GRAD                       = 0x00000081,
    DML_OPERATOR_AVERAGE_POOLING_GRAD                       = 0x00000082,
    DML_OPERATOR_MAX_POOLING_GRAD                           = 0x00000083,
    DML_OPERATOR_RANDOM_GENERATOR                           = 0x00000084,
    DML_OPERATOR_NONZERO_COORDINATES                        = 0x00000085,
    DML_OPERATOR_RESAMPLE_GRAD                              = 0x00000086,
    DML_OPERATOR_SLICE_GRAD                                 = 0x00000087,
    DML_OPERATOR_ADAM_OPTIMIZER                             = 0x00000088,
    DML_OPERATOR_ARGMIN                                     = 0x00000089,
    DML_OPERATOR_ARGMAX                                     = 0x0000008a,
    DML_OPERATOR_ROI_ALIGN                                  = 0x0000008b,
    DML_OPERATOR_GATHER_ND1                                 = 0x0000008c,
    DML_OPERATOR_ELEMENT_WISE_ATAN_YX                       = 0x0000008d,
    DML_OPERATOR_ELEMENT_WISE_CLIP_GRAD                     = 0x0000008e,
    DML_OPERATOR_ELEMENT_WISE_DIFFERENCE_SQUARE             = 0x0000008f,
    DML_OPERATOR_LOCAL_RESPONSE_NORMALIZATION_GRAD          = 0x00000090,
    DML_OPERATOR_CUMULATIVE_PRODUCT                         = 0x00000091,
    DML_OPERATOR_BATCH_NORMALIZATION_GRAD                   = 0x00000092,
    DML_OPERATOR_ELEMENT_WISE_QUANTIZED_LINEAR_ADD          = 0x00000093,
    DML_OPERATOR_DYNAMIC_QUANTIZE_LINEAR                    = 0x00000094,
    DML_OPERATOR_ROI_ALIGN1                                 = 0x00000095,
    DML_OPERATOR_ROI_ALIGN_GRAD                             = 0x00000096,
    DML_OPERATOR_BATCH_NORMALIZATION_TRAINING               = 0x00000097,
    DML_OPERATOR_BATCH_NORMALIZATION_TRAINING_GRAD          = 0x00000098,
    DML_OPERATOR_ELEMENT_WISE_CLIP1                         = 0x00000099,
    DML_OPERATOR_ELEMENT_WISE_CLIP_GRAD1                    = 0x0000009a,
    DML_OPERATOR_PADDING1                                   = 0x0000009b,
    DML_OPERATOR_ELEMENT_WISE_NEGATE                        = 0x0000009c,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ne-directml-dml_reduce_function
alias DML_REDUCE_FUNCTION = int;
enum : int
{
    DML_REDUCE_FUNCTION_ARGMAX      = 0x00000000,
    DML_REDUCE_FUNCTION_ARGMIN      = 0x00000001,
    DML_REDUCE_FUNCTION_AVERAGE     = 0x00000002,
    DML_REDUCE_FUNCTION_L1          = 0x00000003,
    DML_REDUCE_FUNCTION_L2          = 0x00000004,
    DML_REDUCE_FUNCTION_LOG_SUM     = 0x00000005,
    DML_REDUCE_FUNCTION_LOG_SUM_EXP = 0x00000006,
    DML_REDUCE_FUNCTION_MAX         = 0x00000007,
    DML_REDUCE_FUNCTION_MIN         = 0x00000008,
    DML_REDUCE_FUNCTION_MULTIPLY    = 0x00000009,
    DML_REDUCE_FUNCTION_SUM         = 0x0000000a,
    DML_REDUCE_FUNCTION_SUM_SQUARE  = 0x0000000b,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ne-directml-dml_matrix_transform
alias DML_MATRIX_TRANSFORM = int;
enum : int
{
    DML_MATRIX_TRANSFORM_NONE      = 0x00000000,
    DML_MATRIX_TRANSFORM_TRANSPOSE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ne-directml-dml_convolution_mode
alias DML_CONVOLUTION_MODE = int;
enum : int
{
    DML_CONVOLUTION_MODE_CONVOLUTION       = 0x00000000,
    DML_CONVOLUTION_MODE_CROSS_CORRELATION = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ne-directml-dml_convolution_direction
alias DML_CONVOLUTION_DIRECTION = int;
enum : int
{
    DML_CONVOLUTION_DIRECTION_FORWARD  = 0x00000000,
    DML_CONVOLUTION_DIRECTION_BACKWARD = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ne-directml-dml_padding_mode
alias DML_PADDING_MODE = int;
enum : int
{
    DML_PADDING_MODE_CONSTANT   = 0x00000000,
    DML_PADDING_MODE_EDGE       = 0x00000001,
    DML_PADDING_MODE_REFLECTION = 0x00000002,
    DML_PADDING_MODE_SYMMETRIC  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ne-directml-dml_interpolation_mode
alias DML_INTERPOLATION_MODE = int;
enum : int
{
    DML_INTERPOLATION_MODE_NEAREST_NEIGHBOR = 0x00000000,
    DML_INTERPOLATION_MODE_LINEAR           = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ne-directml-dml_recurrent_network_direction
alias DML_RECURRENT_NETWORK_DIRECTION = int;
enum : int
{
    DML_RECURRENT_NETWORK_DIRECTION_FORWARD       = 0x00000000,
    DML_RECURRENT_NETWORK_DIRECTION_BACKWARD      = 0x00000001,
    DML_RECURRENT_NETWORK_DIRECTION_BIDIRECTIONAL = 0x00000002,
}

alias DML_ROUNDING_MODE = int;
enum : int
{
    DML_ROUNDING_MODE_HALVES_TO_NEAREST_EVEN = 0x00000000,
    DML_ROUNDING_MODE_TOWARD_ZERO            = 0x00000001,
    DML_ROUNDING_MODE_TOWARD_INFINITY        = 0x00000002,
}

alias DML_IS_INFINITY_MODE = int;
enum : int
{
    DML_IS_INFINITY_MODE_EITHER   = 0x00000000,
    DML_IS_INFINITY_MODE_POSITIVE = 0x00000001,
    DML_IS_INFINITY_MODE_NEGATIVE = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ne-directml-dml_axis_direction
alias DML_AXIS_DIRECTION = int;
enum : int
{
    DML_AXIS_DIRECTION_INCREASING = 0x00000000,
    DML_AXIS_DIRECTION_DECREASING = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ne-directml-dml_depth_space_order
alias DML_DEPTH_SPACE_ORDER = int;
enum : int
{
    DML_DEPTH_SPACE_ORDER_DEPTH_COLUMN_ROW = 0x00000000,
    DML_DEPTH_SPACE_ORDER_COLUMN_ROW_DEPTH = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ne-directml-dml_random_generator_type
alias DML_RANDOM_GENERATOR_TYPE = int;
enum : int
{
    DML_RANDOM_GENERATOR_TYPE_PHILOX_4X32_10 = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ne-directml-dml_feature_level
alias DML_FEATURE_LEVEL = int;
enum : int
{
    DML_FEATURE_LEVEL_1_0 = 0x00001000,
    DML_FEATURE_LEVEL_2_0 = 0x00002000,
    DML_FEATURE_LEVEL_2_1 = 0x00002100,
    DML_FEATURE_LEVEL_3_0 = 0x00003000,
    DML_FEATURE_LEVEL_3_1 = 0x00003100,
    DML_FEATURE_LEVEL_4_0 = 0x00004000,
    DML_FEATURE_LEVEL_4_1 = 0x00004100,
    DML_FEATURE_LEVEL_5_0 = 0x00005000,
    DML_FEATURE_LEVEL_5_1 = 0x00005100,
    DML_FEATURE_LEVEL_5_2 = 0x00005200,
    DML_FEATURE_LEVEL_6_0 = 0x00006000,
    DML_FEATURE_LEVEL_6_1 = 0x00006100,
    DML_FEATURE_LEVEL_6_2 = 0x00006200,
    DML_FEATURE_LEVEL_6_3 = 0x00006300,
    DML_FEATURE_LEVEL_6_4 = 0x00006400,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ne-directml-dml_feature
alias DML_FEATURE = int;
enum : int
{
    DML_FEATURE_TENSOR_DATA_TYPE_SUPPORT = 0x00000000,
    DML_FEATURE_FEATURE_LEVELS           = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ne-directml-dml_execution_flags
alias DML_EXECUTION_FLAGS = int;
enum : int
{
    DML_EXECUTION_FLAG_NONE                             = 0x00000000,
    DML_EXECUTION_FLAG_ALLOW_HALF_PRECISION_COMPUTATION = 0x00000001,
    DML_EXECUTION_FLAG_DISABLE_META_COMMANDS            = 0x00000002,
    DML_EXECUTION_FLAG_DESCRIPTORS_VOLATILE             = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ne-directml-dml_create_device_flags
alias DML_CREATE_DEVICE_FLAGS = int;
enum : int
{
    DML_CREATE_DEVICE_FLAG_NONE  = 0x00000000,
    DML_CREATE_DEVICE_FLAG_DEBUG = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ne-directml-dml_binding_type
alias DML_BINDING_TYPE = int;
enum : int
{
    DML_BINDING_TYPE_NONE         = 0x00000000,
    DML_BINDING_TYPE_BUFFER       = 0x00000001,
    DML_BINDING_TYPE_BUFFER_ARRAY = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ne-directml-dml_graph_edge_type
alias DML_GRAPH_EDGE_TYPE = int;
enum : int
{
    DML_GRAPH_EDGE_TYPE_INVALID      = 0x00000000,
    DML_GRAPH_EDGE_TYPE_INPUT        = 0x00000001,
    DML_GRAPH_EDGE_TYPE_OUTPUT       = 0x00000002,
    DML_GRAPH_EDGE_TYPE_INTERMEDIATE = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ne-directml-dml_graph_node_type
alias DML_GRAPH_NODE_TYPE = int;
enum : int
{
    DML_GRAPH_NODE_TYPE_INVALID  = 0x00000000,
    DML_GRAPH_NODE_TYPE_OPERATOR = 0x00000001,
}

// Constants


enum uint DML_TARGET_VERSION = 0x00006400U;

enum : uint
{
    DML_TENSOR_DIMENSION_COUNT_MAX  = 0x00000005U,
    DML_TENSOR_DIMENSION_COUNT_MAX1 = 0x00000008U,
}

enum uint DML_TEMPORARY_BUFFER_ALIGNMENT = 0x00000100U;
enum uint DML_PERSISTENT_BUFFER_ALIGNMENT = 0x00000100U;
enum uint DML_MINIMUM_BUFFER_TENSOR_ALIGNMENT = 0x00000010U;

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_buffer_tensor_desc
struct DML_BUFFER_TENSOR_DESC
{
    DML_TENSOR_DATA_TYPE DataType;
    DML_TENSOR_FLAGS     Flags;
    uint                 DimensionCount;
    const(uint)*         Sizes;
    const(uint)*         Strides;
    ulong                TotalTensorSizeInBytes;
    uint                 GuaranteedBaseOffsetAlignment;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_tensor_desc
struct DML_TENSOR_DESC
{
    DML_TENSOR_TYPE Type;
    const(void)*    Desc;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_scale_bias
struct DML_SCALE_BIAS
{
    float Scale;
    float Bias;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_size_2d
struct DML_SIZE_2D
{
    uint Width;
    uint Height;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_scalar_union
union DML_SCALAR_UNION
{
    ubyte[8] Bytes;
    byte     Int8;
    ubyte    UInt8;
    short    Int16;
    ushort   UInt16;
    int      Int32;
    uint     UInt32;
    long     Int64;
    ulong    UInt64;
    float    Float32;
    double   Float64;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_operator_desc
struct DML_OPERATOR_DESC
{
    DML_OPERATOR_TYPE Type;
    const(void)*      Desc;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_identity_operator_desc
struct DML_ELEMENT_WISE_IDENTITY_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_abs_operator_desc
struct DML_ELEMENT_WISE_ABS_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_acos_operator_desc
struct DML_ELEMENT_WISE_ACOS_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_add_operator_desc
struct DML_ELEMENT_WISE_ADD_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_add1_operator_desc
struct DML_ELEMENT_WISE_ADD1_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_OPERATOR_DESC)* FusedActivation;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_asin_operator_desc
struct DML_ELEMENT_WISE_ASIN_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_atan_operator_desc
struct DML_ELEMENT_WISE_ATAN_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_ceil_operator_desc
struct DML_ELEMENT_WISE_CEIL_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_clip_operator_desc
struct DML_ELEMENT_WISE_CLIP_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
    float Min;
    float Max;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_cos_operator_desc
struct DML_ELEMENT_WISE_COS_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_divide_operator_desc
struct DML_ELEMENT_WISE_DIVIDE_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_exp_operator_desc
struct DML_ELEMENT_WISE_EXP_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_floor_operator_desc
struct DML_ELEMENT_WISE_FLOOR_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_log_operator_desc
struct DML_ELEMENT_WISE_LOG_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_logical_and_operator_desc
struct DML_ELEMENT_WISE_LOGICAL_AND_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_logical_equals_operator_desc
struct DML_ELEMENT_WISE_LOGICAL_EQUALS_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_logical_greater_than_operator_desc
struct DML_ELEMENT_WISE_LOGICAL_GREATER_THAN_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_logical_less_than_operator_desc
struct DML_ELEMENT_WISE_LOGICAL_LESS_THAN_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_logical_not_operator_desc
struct DML_ELEMENT_WISE_LOGICAL_NOT_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_logical_or_operator_desc
struct DML_ELEMENT_WISE_LOGICAL_OR_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_logical_xor_operator_desc
struct DML_ELEMENT_WISE_LOGICAL_XOR_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_max_operator_desc
struct DML_ELEMENT_WISE_MAX_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_mean_operator_desc
struct DML_ELEMENT_WISE_MEAN_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_min_operator_desc
struct DML_ELEMENT_WISE_MIN_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_multiply_operator_desc
struct DML_ELEMENT_WISE_MULTIPLY_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_pow_operator_desc
struct DML_ELEMENT_WISE_POW_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* ExponentTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_constant_pow_operator_desc
struct DML_ELEMENT_WISE_CONSTANT_POW_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
    float Exponent;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_recip_operator_desc
struct DML_ELEMENT_WISE_RECIP_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_sin_operator_desc
struct DML_ELEMENT_WISE_SIN_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_sqrt_operator_desc
struct DML_ELEMENT_WISE_SQRT_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_subtract_operator_desc
struct DML_ELEMENT_WISE_SUBTRACT_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_tan_operator_desc
struct DML_ELEMENT_WISE_TAN_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_threshold_operator_desc
struct DML_ELEMENT_WISE_THRESHOLD_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
    float Min;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_quantize_linear_operator_desc
struct DML_ELEMENT_WISE_QUANTIZE_LINEAR_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* ScaleTensor;
    const(DML_TENSOR_DESC)* ZeroPointTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_dequantize_linear_operator_desc
struct DML_ELEMENT_WISE_DEQUANTIZE_LINEAR_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* ScaleTensor;
    const(DML_TENSOR_DESC)* ZeroPointTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_activation_elu_operator_desc
struct DML_ACTIVATION_ELU_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    float Alpha;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_activation_hardmax_operator_desc
struct DML_ACTIVATION_HARDMAX_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_activation_hard_sigmoid_operator_desc
struct DML_ACTIVATION_HARD_SIGMOID_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    float Alpha;
    float Beta;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_activation_identity_operator_desc
struct DML_ACTIVATION_IDENTITY_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_activation_leaky_relu_operator_desc
struct DML_ACTIVATION_LEAKY_RELU_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    float Alpha;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_activation_linear_operator_desc
struct DML_ACTIVATION_LINEAR_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    float Alpha;
    float Beta;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_activation_log_softmax_operator_desc
struct DML_ACTIVATION_LOG_SOFTMAX_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_activation_parameterized_relu_operator_desc
struct DML_ACTIVATION_PARAMETERIZED_RELU_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* SlopeTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_activation_parametric_softplus_operator_desc
struct DML_ACTIVATION_PARAMETRIC_SOFTPLUS_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    float Alpha;
    float Beta;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_activation_relu_operator_desc
struct DML_ACTIVATION_RELU_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_activation_scaled_elu_operator_desc
struct DML_ACTIVATION_SCALED_ELU_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    float Alpha;
    float Gamma;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_activation_scaled_tanh_operator_desc
struct DML_ACTIVATION_SCALED_TANH_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    float Alpha;
    float Beta;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_activation_sigmoid_operator_desc
struct DML_ACTIVATION_SIGMOID_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_activation_softmax_operator_desc
struct DML_ACTIVATION_SOFTMAX_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_activation_softplus_operator_desc
struct DML_ACTIVATION_SOFTPLUS_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    float Steepness;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_activation_softsign_operator_desc
struct DML_ACTIVATION_SOFTSIGN_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_activation_tanh_operator_desc
struct DML_ACTIVATION_TANH_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_activation_thresholded_relu_operator_desc
struct DML_ACTIVATION_THRESHOLDED_RELU_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    float Alpha;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_convolution_operator_desc
struct DML_CONVOLUTION_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* FilterTensor;
    const(DML_TENSOR_DESC)* BiasTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    DML_CONVOLUTION_MODE Mode;
    DML_CONVOLUTION_DIRECTION Direction;
    uint                 DimensionCount;
    const(uint)*         Strides;
    const(uint)*         Dilations;
    const(uint)*         StartPadding;
    const(uint)*         EndPadding;
    const(uint)*         OutputPadding;
    uint                 GroupCount;
    const(DML_OPERATOR_DESC)* FusedActivation;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_gemm_operator_desc
struct DML_GEMM_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* CTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    DML_MATRIX_TRANSFORM TransA;
    DML_MATRIX_TRANSFORM TransB;
    float                Alpha;
    float                Beta;
    const(DML_OPERATOR_DESC)* FusedActivation;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_reduce_operator_desc
struct DML_REDUCE_OPERATOR_DESC
{
    DML_REDUCE_FUNCTION Function;
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint                AxisCount;
    const(uint)*        Axes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_average_pooling_operator_desc
struct DML_AVERAGE_POOLING_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint         DimensionCount;
    const(uint)* Strides;
    const(uint)* WindowSize;
    const(uint)* StartPadding;
    const(uint)* EndPadding;
    BOOL         IncludePadding;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_lp_pooling_operator_desc
struct DML_LP_POOLING_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint         DimensionCount;
    const(uint)* Strides;
    const(uint)* WindowSize;
    const(uint)* StartPadding;
    const(uint)* EndPadding;
    uint         P;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_max_pooling_operator_desc
struct DML_MAX_POOLING_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint         DimensionCount;
    const(uint)* Strides;
    const(uint)* WindowSize;
    const(uint)* StartPadding;
    const(uint)* EndPadding;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_roi_pooling_operator_desc
struct DML_ROI_POOLING_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* ROITensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    float       SpatialScale;
    DML_SIZE_2D PooledSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_slice_operator_desc
struct DML_SLICE_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint         DimensionCount;
    const(uint)* Offsets;
    const(uint)* Sizes;
    const(uint)* Strides;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_cast_operator_desc
struct DML_CAST_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_split_operator_desc
struct DML_SPLIT_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    uint OutputCount;
    const(DML_TENSOR_DESC)* OutputTensors;
    uint Axis;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_join_operator_desc
struct DML_JOIN_OPERATOR_DESC
{
    uint InputCount;
    const(DML_TENSOR_DESC)* InputTensors;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint Axis;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_padding_operator_desc
struct DML_PADDING_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    DML_PADDING_MODE PaddingMode;
    float            PaddingValue;
    uint             DimensionCount;
    const(uint)*     StartPadding;
    const(uint)*     EndPadding;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_value_scale_2d_operator_desc
struct DML_VALUE_SCALE_2D_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    float         Scale;
    uint          ChannelCount;
    const(float)* Bias;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_upsample_2d_operator_desc
struct DML_UPSAMPLE_2D_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    DML_SIZE_2D ScaleSize;
    DML_INTERPOLATION_MODE InterpolationMode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_gather_operator_desc
struct DML_GATHER_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* IndicesTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint Axis;
    uint IndexDimensions;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_space_to_depth_operator_desc
struct DML_SPACE_TO_DEPTH_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint BlockSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_depth_to_space_operator_desc
struct DML_DEPTH_TO_SPACE_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint BlockSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_tile_operator_desc
struct DML_TILE_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint         RepeatsCount;
    const(uint)* Repeats;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_top_k_operator_desc
struct DML_TOP_K_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputValueTensor;
    const(DML_TENSOR_DESC)* OutputIndexTensor;
    uint Axis;
    uint K;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_batch_normalization_operator_desc
struct DML_BATCH_NORMALIZATION_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* MeanTensor;
    const(DML_TENSOR_DESC)* VarianceTensor;
    const(DML_TENSOR_DESC)* ScaleTensor;
    const(DML_TENSOR_DESC)* BiasTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    BOOL  Spatial;
    float Epsilon;
    const(DML_OPERATOR_DESC)* FusedActivation;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_mean_variance_normalization_operator_desc
struct DML_MEAN_VARIANCE_NORMALIZATION_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* ScaleTensor;
    const(DML_TENSOR_DESC)* BiasTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    BOOL  CrossChannel;
    BOOL  NormalizeVariance;
    float Epsilon;
    const(DML_OPERATOR_DESC)* FusedActivation;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_local_response_normalization_operator_desc
struct DML_LOCAL_RESPONSE_NORMALIZATION_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    BOOL  CrossChannel;
    uint  LocalSize;
    float Alpha;
    float Beta;
    float Bias;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_lp_normalization_operator_desc
struct DML_LP_NORMALIZATION_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint  Axis;
    float Epsilon;
    uint  P;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_rnn_operator_desc
struct DML_RNN_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* WeightTensor;
    const(DML_TENSOR_DESC)* RecurrenceTensor;
    const(DML_TENSOR_DESC)* BiasTensor;
    const(DML_TENSOR_DESC)* HiddenInitTensor;
    const(DML_TENSOR_DESC)* SequenceLengthsTensor;
    const(DML_TENSOR_DESC)* OutputSequenceTensor;
    const(DML_TENSOR_DESC)* OutputSingleTensor;
    uint ActivationDescCount;
    const(DML_OPERATOR_DESC)* ActivationDescs;
    DML_RECURRENT_NETWORK_DIRECTION Direction;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_lstm_operator_desc
struct DML_LSTM_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* WeightTensor;
    const(DML_TENSOR_DESC)* RecurrenceTensor;
    const(DML_TENSOR_DESC)* BiasTensor;
    const(DML_TENSOR_DESC)* HiddenInitTensor;
    const(DML_TENSOR_DESC)* CellMemInitTensor;
    const(DML_TENSOR_DESC)* SequenceLengthsTensor;
    const(DML_TENSOR_DESC)* PeepholeTensor;
    const(DML_TENSOR_DESC)* OutputSequenceTensor;
    const(DML_TENSOR_DESC)* OutputSingleTensor;
    const(DML_TENSOR_DESC)* OutputCellSingleTensor;
    uint  ActivationDescCount;
    const(DML_OPERATOR_DESC)* ActivationDescs;
    DML_RECURRENT_NETWORK_DIRECTION Direction;
    float ClipThreshold;
    BOOL  UseClipThreshold;
    BOOL  CoupleInputForget;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_gru_operator_desc
struct DML_GRU_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* WeightTensor;
    const(DML_TENSOR_DESC)* RecurrenceTensor;
    const(DML_TENSOR_DESC)* BiasTensor;
    const(DML_TENSOR_DESC)* HiddenInitTensor;
    const(DML_TENSOR_DESC)* SequenceLengthsTensor;
    const(DML_TENSOR_DESC)* OutputSequenceTensor;
    const(DML_TENSOR_DESC)* OutputSingleTensor;
    uint ActivationDescCount;
    const(DML_OPERATOR_DESC)* ActivationDescs;
    DML_RECURRENT_NETWORK_DIRECTION Direction;
    BOOL LinearBeforeReset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_sign_operator_desc
struct DML_ELEMENT_WISE_SIGN_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_is_nan_operator_desc
struct DML_ELEMENT_WISE_IS_NAN_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_erf_operator_desc
struct DML_ELEMENT_WISE_ERF_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_sinh_operator_desc
struct DML_ELEMENT_WISE_SINH_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_cosh_operator_desc
struct DML_ELEMENT_WISE_COSH_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_tanh_operator_desc
struct DML_ELEMENT_WISE_TANH_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_asinh_operator_desc
struct DML_ELEMENT_WISE_ASINH_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_acosh_operator_desc
struct DML_ELEMENT_WISE_ACOSH_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_atanh_operator_desc
struct DML_ELEMENT_WISE_ATANH_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_if_operator_desc
struct DML_ELEMENT_WISE_IF_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ConditionTensor;
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_activation_shrink_operator_desc
struct DML_ACTIVATION_SHRINK_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    float Bias;
    float Threshold;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_max_pooling1_operator_desc
struct DML_MAX_POOLING1_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_TENSOR_DESC)* OutputIndicesTensor;
    uint         DimensionCount;
    const(uint)* Strides;
    const(uint)* WindowSize;
    const(uint)* StartPadding;
    const(uint)* EndPadding;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_max_unpooling_operator_desc
struct DML_MAX_UNPOOLING_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* IndicesTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_diagonal_matrix_operator_desc
struct DML_DIAGONAL_MATRIX_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* OutputTensor;
    int   Offset;
    float Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_scatter_operator_desc
struct DML_SCATTER_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* IndicesTensor;
    const(DML_TENSOR_DESC)* UpdatesTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint Axis;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_one_hot_operator_desc
struct DML_ONE_HOT_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* IndicesTensor;
    const(DML_TENSOR_DESC)* ValuesTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint Axis;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_resample_operator_desc
struct DML_RESAMPLE_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    DML_INTERPOLATION_MODE InterpolationMode;
    uint          ScaleCount;
    const(float)* Scales;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_bit_shift_left_operator_desc
struct DML_ELEMENT_WISE_BIT_SHIFT_LEFT_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_bit_shift_right_operator_desc
struct DML_ELEMENT_WISE_BIT_SHIFT_RIGHT_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_round_operator_desc
struct DML_ELEMENT_WISE_ROUND_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    DML_ROUNDING_MODE RoundingMode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_is_infinity_operator_desc
struct DML_ELEMENT_WISE_IS_INFINITY_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    DML_IS_INFINITY_MODE InfinityMode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_modulus_truncate_operator_desc
struct DML_ELEMENT_WISE_MODULUS_TRUNCATE_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_modulus_floor_operator_desc
struct DML_ELEMENT_WISE_MODULUS_FLOOR_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_fill_value_constant_operator_desc
struct DML_FILL_VALUE_CONSTANT_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* OutputTensor;
    DML_TENSOR_DATA_TYPE ValueDataType;
    DML_SCALAR_UNION     Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_fill_value_sequence_operator_desc
struct DML_FILL_VALUE_SEQUENCE_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* OutputTensor;
    DML_TENSOR_DATA_TYPE ValueDataType;
    DML_SCALAR_UNION     ValueStart;
    DML_SCALAR_UNION     ValueDelta;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_cumulative_summation_operator_desc
struct DML_CUMULATIVE_SUMMATION_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint               Axis;
    DML_AXIS_DIRECTION AxisDirection;
    BOOL               HasExclusiveSum;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_reverse_subsequences_desc
struct DML_REVERSE_SUBSEQUENCES_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* SequenceLengthsTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint Axis;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_gather_elements_operator_desc
struct DML_GATHER_ELEMENTS_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* IndicesTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint Axis;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_gather_nd_operator_desc
struct DML_GATHER_ND_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* IndicesTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint InputDimensionCount;
    uint IndicesDimensionCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_scatter_nd_operator_desc
struct DML_SCATTER_ND_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* IndicesTensor;
    const(DML_TENSOR_DESC)* UpdatesTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint InputDimensionCount;
    uint IndicesDimensionCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_max_pooling2_operator_desc
struct DML_MAX_POOLING2_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_TENSOR_DESC)* OutputIndicesTensor;
    uint         DimensionCount;
    const(uint)* Strides;
    const(uint)* WindowSize;
    const(uint)* StartPadding;
    const(uint)* EndPadding;
    const(uint)* Dilations;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_slice1_operator_desc
struct DML_SLICE1_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint         DimensionCount;
    const(uint)* InputWindowOffsets;
    const(uint)* InputWindowSizes;
    const(int)*  InputWindowStrides;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_top_k1_operator_desc
struct DML_TOP_K1_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputValueTensor;
    const(DML_TENSOR_DESC)* OutputIndexTensor;
    uint               Axis;
    uint               K;
    DML_AXIS_DIRECTION AxisDirection;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_depth_to_space1_operator_desc
struct DML_DEPTH_TO_SPACE1_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint BlockSize;
    DML_DEPTH_SPACE_ORDER Order;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_space_to_depth1_operator_desc
struct DML_SPACE_TO_DEPTH1_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint BlockSize;
    DML_DEPTH_SPACE_ORDER Order;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_mean_variance_normalization1_operator_desc
struct DML_MEAN_VARIANCE_NORMALIZATION1_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* ScaleTensor;
    const(DML_TENSOR_DESC)* BiasTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint         AxisCount;
    const(uint)* Axes;
    BOOL         NormalizeVariance;
    float        Epsilon;
    const(DML_OPERATOR_DESC)* FusedActivation;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_resample1_operator_desc
struct DML_RESAMPLE1_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    DML_INTERPOLATION_MODE InterpolationMode;
    uint          DimensionCount;
    const(float)* Scales;
    const(float)* InputPixelOffsets;
    const(float)* OutputPixelOffsets;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_matrix_multiply_integer_operator_desc
struct DML_MATRIX_MULTIPLY_INTEGER_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* AZeroPointTensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* BZeroPointTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_quantized_linear_matrix_multiply_operator_desc
struct DML_QUANTIZED_LINEAR_MATRIX_MULTIPLY_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* AScaleTensor;
    const(DML_TENSOR_DESC)* AZeroPointTensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* BScaleTensor;
    const(DML_TENSOR_DESC)* BZeroPointTensor;
    const(DML_TENSOR_DESC)* OutputScaleTensor;
    const(DML_TENSOR_DESC)* OutputZeroPointTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_CONVOLUTION_INTEGER_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* InputZeroPointTensor;
    const(DML_TENSOR_DESC)* FilterTensor;
    const(DML_TENSOR_DESC)* FilterZeroPointTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint         DimensionCount;
    const(uint)* Strides;
    const(uint)* Dilations;
    const(uint)* StartPadding;
    const(uint)* EndPadding;
    uint         GroupCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_quantized_linear_convolution_operator_desc
struct DML_QUANTIZED_LINEAR_CONVOLUTION_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* InputScaleTensor;
    const(DML_TENSOR_DESC)* InputZeroPointTensor;
    const(DML_TENSOR_DESC)* FilterTensor;
    const(DML_TENSOR_DESC)* FilterScaleTensor;
    const(DML_TENSOR_DESC)* FilterZeroPointTensor;
    const(DML_TENSOR_DESC)* BiasTensor;
    const(DML_TENSOR_DESC)* OutputScaleTensor;
    const(DML_TENSOR_DESC)* OutputZeroPointTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint         DimensionCount;
    const(uint)* Strides;
    const(uint)* Dilations;
    const(uint)* StartPadding;
    const(uint)* EndPadding;
    uint         GroupCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_bit_and_operator_desc
struct DML_ELEMENT_WISE_BIT_AND_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_bit_or_operator_desc
struct DML_ELEMENT_WISE_BIT_OR_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_bit_xor_operator_desc
struct DML_ELEMENT_WISE_BIT_XOR_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_bit_not_operator_desc
struct DML_ELEMENT_WISE_BIT_NOT_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_bit_count_operator_desc
struct DML_ELEMENT_WISE_BIT_COUNT_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_logical_greater_than_or_equal_operator_desc
struct DML_ELEMENT_WISE_LOGICAL_GREATER_THAN_OR_EQUAL_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_logical_less_than_or_equal_operator_desc
struct DML_ELEMENT_WISE_LOGICAL_LESS_THAN_OR_EQUAL_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_activation_celu_operator_desc
struct DML_ACTIVATION_CELU_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    float Alpha;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_activation_relu_grad_operator_desc
struct DML_ACTIVATION_RELU_GRAD_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* InputGradientTensor;
    const(DML_TENSOR_DESC)* OutputGradientTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_average_pooling_grad_operator_desc
struct DML_AVERAGE_POOLING_GRAD_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputGradientTensor;
    const(DML_TENSOR_DESC)* OutputGradientTensor;
    uint         DimensionCount;
    const(uint)* Strides;
    const(uint)* WindowSize;
    const(uint)* StartPadding;
    const(uint)* EndPadding;
    BOOL         IncludePadding;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_max_pooling_grad_operator_desc
struct DML_MAX_POOLING_GRAD_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* InputGradientTensor;
    const(DML_TENSOR_DESC)* OutputGradientTensor;
    uint         DimensionCount;
    const(uint)* Strides;
    const(uint)* WindowSize;
    const(uint)* StartPadding;
    const(uint)* EndPadding;
    const(uint)* Dilations;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_random_generator_operator_desc
struct DML_RANDOM_GENERATOR_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputStateTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_TENSOR_DESC)* OutputStateTensor;
    DML_RANDOM_GENERATOR_TYPE Type;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_nonzero_coordinates_operator_desc
struct DML_NONZERO_COORDINATES_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputCountTensor;
    const(DML_TENSOR_DESC)* OutputCoordinatesTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_resample_grad_operator_desc
struct DML_RESAMPLE_GRAD_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputGradientTensor;
    const(DML_TENSOR_DESC)* OutputGradientTensor;
    DML_INTERPOLATION_MODE InterpolationMode;
    uint          DimensionCount;
    const(float)* Scales;
    const(float)* InputPixelOffsets;
    const(float)* OutputPixelOffsets;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_slice_grad_operator_desc
struct DML_SLICE_GRAD_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputGradientTensor;
    const(DML_TENSOR_DESC)* OutputGradientTensor;
    uint         DimensionCount;
    const(uint)* InputWindowOffsets;
    const(uint)* InputWindowSizes;
    const(int)*  InputWindowStrides;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_adam_optimizer_operator_desc
struct DML_ADAM_OPTIMIZER_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputParametersTensor;
    const(DML_TENSOR_DESC)* InputFirstMomentTensor;
    const(DML_TENSOR_DESC)* InputSecondMomentTensor;
    const(DML_TENSOR_DESC)* GradientTensor;
    const(DML_TENSOR_DESC)* TrainingStepTensor;
    const(DML_TENSOR_DESC)* OutputParametersTensor;
    const(DML_TENSOR_DESC)* OutputFirstMomentTensor;
    const(DML_TENSOR_DESC)* OutputSecondMomentTensor;
    float LearningRate;
    float Beta1;
    float Beta2;
    float Epsilon;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_argmin_operator_desc
struct DML_ARGMIN_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint               AxisCount;
    const(uint)*       Axes;
    DML_AXIS_DIRECTION AxisDirection;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_argmax_operator_desc
struct DML_ARGMAX_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint               AxisCount;
    const(uint)*       Axes;
    DML_AXIS_DIRECTION AxisDirection;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_roi_align_operator_desc
struct DML_ROI_ALIGN_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* ROITensor;
    const(DML_TENSOR_DESC)* BatchIndicesTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    DML_REDUCE_FUNCTION ReductionFunction;
    DML_INTERPOLATION_MODE InterpolationMode;
    float               SpatialScaleX;
    float               SpatialScaleY;
    float               OutOfBoundsInputValue;
    uint                MinimumSamplesPerOutput;
    uint                MaximumSamplesPerOutput;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_gather_nd1_operator_desc
struct DML_GATHER_ND1_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* IndicesTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint InputDimensionCount;
    uint IndicesDimensionCount;
    uint BatchDimensionCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_atan_yx_operator_desc
struct DML_ELEMENT_WISE_ATAN_YX_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_clip_grad_operator_desc
struct DML_ELEMENT_WISE_CLIP_GRAD_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* InputGradientTensor;
    const(DML_TENSOR_DESC)* OutputGradientTensor;
    float Min;
    float Max;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_difference_square_operator_desc
struct DML_ELEMENT_WISE_DIFFERENCE_SQUARE_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_local_response_normalization_grad_operator_desc
struct DML_LOCAL_RESPONSE_NORMALIZATION_GRAD_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* InputGradientTensor;
    const(DML_TENSOR_DESC)* OutputGradientTensor;
    BOOL  CrossChannel;
    uint  LocalSize;
    float Alpha;
    float Beta;
    float Bias;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_cumulative_product_operator_desc
struct DML_CUMULATIVE_PRODUCT_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint               Axis;
    DML_AXIS_DIRECTION AxisDirection;
    BOOL               HasExclusiveProduct;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_batch_normalization_grad_operator_desc
struct DML_BATCH_NORMALIZATION_GRAD_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* InputGradientTensor;
    const(DML_TENSOR_DESC)* MeanTensor;
    const(DML_TENSOR_DESC)* VarianceTensor;
    const(DML_TENSOR_DESC)* ScaleTensor;
    const(DML_TENSOR_DESC)* OutputGradientTensor;
    const(DML_TENSOR_DESC)* OutputScaleGradientTensor;
    const(DML_TENSOR_DESC)* OutputBiasGradientTensor;
    float Epsilon;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_quantized_linear_add_operator_desc
struct DML_ELEMENT_WISE_QUANTIZED_LINEAR_ADD_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* AScaleTensor;
    const(DML_TENSOR_DESC)* AZeroPointTensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* BScaleTensor;
    const(DML_TENSOR_DESC)* BZeroPointTensor;
    const(DML_TENSOR_DESC)* OutputScaleTensor;
    const(DML_TENSOR_DESC)* OutputZeroPointTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_dynamic_quantize_linear_operator_desc
struct DML_DYNAMIC_QUANTIZE_LINEAR_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_TENSOR_DESC)* OutputScaleTensor;
    const(DML_TENSOR_DESC)* OutputZeroPointTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_roi_align1_operator_desc
struct DML_ROI_ALIGN1_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* ROITensor;
    const(DML_TENSOR_DESC)* BatchIndicesTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    DML_REDUCE_FUNCTION ReductionFunction;
    DML_INTERPOLATION_MODE InterpolationMode;
    float               SpatialScaleX;
    float               SpatialScaleY;
    float               InputPixelOffset;
    float               OutputPixelOffset;
    float               OutOfBoundsInputValue;
    uint                MinimumSamplesPerOutput;
    uint                MaximumSamplesPerOutput;
    BOOL                AlignRegionsToCorners;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_roi_align_grad_operator_desc
struct DML_ROI_ALIGN_GRAD_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* InputGradientTensor;
    const(DML_TENSOR_DESC)* ROITensor;
    const(DML_TENSOR_DESC)* BatchIndicesTensor;
    const(DML_TENSOR_DESC)* OutputGradientTensor;
    const(DML_TENSOR_DESC)* OutputROIGradientTensor;
    DML_REDUCE_FUNCTION ReductionFunction;
    DML_INTERPOLATION_MODE InterpolationMode;
    float               SpatialScaleX;
    float               SpatialScaleY;
    float               InputPixelOffset;
    float               OutputPixelOffset;
    uint                MinimumSamplesPerOutput;
    uint                MaximumSamplesPerOutput;
    BOOL                AlignRegionsToCorners;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_batch_normalization_training_operator_desc
struct DML_BATCH_NORMALIZATION_TRAINING_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* ScaleTensor;
    const(DML_TENSOR_DESC)* BiasTensor;
    const(DML_TENSOR_DESC)* FusedAddTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_TENSOR_DESC)* OutputMeanTensor;
    const(DML_TENSOR_DESC)* OutputVarianceTensor;
    float Epsilon;
    const(DML_OPERATOR_DESC)* FusedActivation;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_batch_normalization_training_grad_operator_desc
struct DML_BATCH_NORMALIZATION_TRAINING_GRAD_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* InputGradientTensor;
    const(DML_TENSOR_DESC)* MeanTensor;
    const(DML_TENSOR_DESC)* VarianceTensor;
    const(DML_TENSOR_DESC)* ScaleTensor;
    const(DML_TENSOR_DESC)* OutputGradientTensor;
    const(DML_TENSOR_DESC)* OutputScaleGradientTensor;
    const(DML_TENSOR_DESC)* OutputBiasGradientTensor;
    float Epsilon;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_clip1_operator_desc
struct DML_ELEMENT_WISE_CLIP1_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
    DML_TENSOR_DATA_TYPE MinMaxDataType;
    DML_SCALAR_UNION     Min;
    DML_SCALAR_UNION     Max;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_clip_grad1_operator_desc
struct DML_ELEMENT_WISE_CLIP_GRAD1_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* InputGradientTensor;
    const(DML_TENSOR_DESC)* OutputGradientTensor;
    DML_TENSOR_DATA_TYPE MinMaxDataType;
    DML_SCALAR_UNION     Min;
    DML_SCALAR_UNION     Max;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_padding1_operator_desc
struct DML_PADDING1_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    DML_PADDING_MODE     PaddingMode;
    DML_TENSOR_DATA_TYPE PaddingValueDataType;
    DML_SCALAR_UNION     PaddingValue;
    uint                 DimensionCount;
    const(uint)*         StartPadding;
    const(uint)*         EndPadding;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_element_wise_negate_operator_desc
struct DML_ELEMENT_WISE_NEGATE_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_feature_query_tensor_data_type_support
struct DML_FEATURE_QUERY_TENSOR_DATA_TYPE_SUPPORT
{
    DML_TENSOR_DATA_TYPE DataType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_feature_data_tensor_data_type_support
struct DML_FEATURE_DATA_TENSOR_DATA_TYPE_SUPPORT
{
    BOOL IsSupported;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_feature_query_feature_levels
struct DML_FEATURE_QUERY_FEATURE_LEVELS
{
    uint RequestedFeatureLevelCount;
    const(DML_FEATURE_LEVEL)* RequestedFeatureLevels;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_feature_data_feature_levels
struct DML_FEATURE_DATA_FEATURE_LEVELS
{
    DML_FEATURE_LEVEL MaxSupportedFeatureLevel;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_binding_table_desc
struct DML_BINDING_TABLE_DESC
{
    IDMLDispatchable Dispatchable;
    D3D12_CPU_DESCRIPTOR_HANDLE CPUDescriptorHandle;
    D3D12_GPU_DESCRIPTOR_HANDLE GPUDescriptorHandle;
    uint             SizeInDescriptors;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_binding_properties
struct DML_BINDING_PROPERTIES
{
    uint  RequiredDescriptorCount;
    ulong TemporaryResourceSize;
    ulong PersistentResourceSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_binding_desc
struct DML_BINDING_DESC
{
    DML_BINDING_TYPE Type;
    const(void)*     Desc;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_buffer_binding
struct DML_BUFFER_BINDING
{
    ID3D12Resource Buffer;
    ulong          Offset;
    ulong          SizeInBytes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_buffer_array_binding
struct DML_BUFFER_ARRAY_BINDING
{
    uint BindingCount;
    const(DML_BUFFER_BINDING)* Bindings;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_graph_edge_desc
struct DML_GRAPH_EDGE_DESC
{
    DML_GRAPH_EDGE_TYPE Type;
    const(void)*        Desc;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_input_graph_edge_desc
struct DML_INPUT_GRAPH_EDGE_DESC
{
    uint        GraphInputIndex;
    uint        ToNodeIndex;
    uint        ToNodeInputIndex;
    const(PSTR) Name;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_output_graph_edge_desc
struct DML_OUTPUT_GRAPH_EDGE_DESC
{
    uint        FromNodeIndex;
    uint        FromNodeOutputIndex;
    uint        GraphOutputIndex;
    const(PSTR) Name;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_intermediate_graph_edge_desc
struct DML_INTERMEDIATE_GRAPH_EDGE_DESC
{
    uint        FromNodeIndex;
    uint        FromNodeOutputIndex;
    uint        ToNodeIndex;
    uint        ToNodeInputIndex;
    const(PSTR) Name;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_graph_node_desc
struct DML_GRAPH_NODE_DESC
{
    DML_GRAPH_NODE_TYPE Type;
    const(void)*        Desc;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_operator_graph_node_desc
struct DML_OPERATOR_GRAPH_NODE_DESC
{
    IDMLOperator Operator;
    const(PSTR)  Name;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/ns-directml-dml_graph_desc
struct DML_GRAPH_DESC
{
    uint InputCount;
    uint OutputCount;
    uint NodeCount;
    const(DML_GRAPH_NODE_DESC)* Nodes;
    uint InputEdgeCount;
    const(DML_GRAPH_EDGE_DESC)* InputEdges;
    uint OutputEdgeCount;
    const(DML_GRAPH_EDGE_DESC)* OutputEdges;
    uint IntermediateEdgeCount;
    const(DML_GRAPH_EDGE_DESC)* IntermediateEdges;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("DirectML.dll")
HRESULT DMLCreateDevice(ID3D12Device d3d12Device, DML_CREATE_DEVICE_FLAGS flags, const(GUID)* riid, void** ppv);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nf-directml-dmlcreatedevice1
@DllImport("DirectML.dll")
HRESULT DMLCreateDevice1(ID3D12Device d3d12Device, DML_CREATE_DEVICE_FLAGS flags, 
                         DML_FEATURE_LEVEL minimumFeatureLevel, const(GUID)* riid, void** ppv);


// Interfaces

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nn-directml-idmlobject
@GUID("c8263aac-9e0c-4a2d-9b8e-007521a3317c")
interface IDMLObject : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nf-directml-idmlobject-getprivatedata
    HRESULT GetPrivateData(const(GUID)* guid, uint* dataSize, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* data);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nf-directml-idmlobject-setprivatedata
    HRESULT SetPrivateData(const(GUID)* guid, uint dataSize, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* data);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nf-directml-idmlobject-setprivatedatainterface
    HRESULT SetPrivateDataInterface(const(GUID)* guid, IUnknown data);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nf-directml-idmlobject-setname
    HRESULT SetName(const(PWSTR) name);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nn-directml-idmldevice
@GUID("6dbd6437-96fd-423f-a98c-ae5e7c2a573f")
interface IDMLDevice : IDMLObject
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nf-directml-idmldevice-checkfeaturesupport
    HRESULT CheckFeatureSupport(DML_FEATURE feature, uint featureQueryDataSize, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* featureQueryData, 
                                uint featureSupportDataSize, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* featureSupportData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nf-directml-idmldevice-createoperator
    HRESULT CreateOperator(const(DML_OPERATOR_DESC)* desc, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nf-directml-idmldevice-compileoperator
    HRESULT CompileOperator(IDMLOperator op, DML_EXECUTION_FLAGS flags, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nf-directml-idmldevice-createoperatorinitializer
    HRESULT CreateOperatorInitializer(uint operatorCount, IDMLCompiledOperator* operators, const(GUID)* riid, 
                                      void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nf-directml-idmldevice-createcommandrecorder
    HRESULT CreateCommandRecorder(const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nf-directml-idmldevice-createbindingtable
    HRESULT CreateBindingTable(const(DML_BINDING_TABLE_DESC)* desc, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nf-directml-idmldevice-evict
    HRESULT Evict(uint count, IDMLPageable* ppObjects);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nf-directml-idmldevice-makeresident
    HRESULT MakeResident(uint count, IDMLPageable* ppObjects);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nf-directml-idmldevice-getdeviceremovedreason
    HRESULT GetDeviceRemovedReason();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nf-directml-idmldevice-getparentdevice
    HRESULT GetParentDevice(const(GUID)* riid, void** ppv);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nn-directml-idmldevicechild
@GUID("27e83142-8165-49e3-974e-2fd66e4cb69d")
interface IDMLDeviceChild : IDMLObject
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nf-directml-idmldevicechild-getdevice
    HRESULT GetDevice(const(GUID)* riid, void** ppv);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nn-directml-idmlpageable
@GUID("b1ab0825-4542-4a4b-8617-6dde6e8f6201")
interface IDMLPageable : IDMLDeviceChild
{
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nn-directml-idmloperator
@GUID("26caae7a-3081-4633-9581-226fbe57695d")
interface IDMLOperator : IDMLDeviceChild
{
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nn-directml-idmldispatchable
@GUID("dcb821a8-1039-441e-9f1c-b1759c2f3cec")
interface IDMLDispatchable : IDMLPageable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nf-directml-idmldispatchable-getbindingproperties
    DML_BINDING_PROPERTIES GetBindingProperties();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nn-directml-idmlcompiledoperator
@GUID("6b15e56a-bf5c-4902-92d8-da3a650afea4")
interface IDMLCompiledOperator : IDMLDispatchable
{
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nn-directml-idmloperatorinitializer
@GUID("427c1113-435c-469c-8676-4d5dd072f813")
interface IDMLOperatorInitializer : IDMLDispatchable
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nf-directml-idmloperatorinitializer-reset
    HRESULT Reset(uint operatorCount, IDMLCompiledOperator* operators);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nn-directml-idmlbindingtable
@GUID("29c687dc-de74-4e3b-ab00-1168f2fc3cfc")
interface IDMLBindingTable : IDMLDeviceChild
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nf-directml-idmlbindingtable-bindinputs
    void    BindInputs(uint bindingCount, const(DML_BINDING_DESC)* bindings);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nf-directml-idmlbindingtable-bindoutputs
    void    BindOutputs(uint bindingCount, const(DML_BINDING_DESC)* bindings);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nf-directml-idmlbindingtable-bindtemporaryresource
    void    BindTemporaryResource(const(DML_BINDING_DESC)* binding);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nf-directml-idmlbindingtable-bindpersistentresource
    void    BindPersistentResource(const(DML_BINDING_DESC)* binding);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nf-directml-idmlbindingtable-reset
    HRESULT Reset(const(DML_BINDING_TABLE_DESC)* desc);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nn-directml-idmlcommandrecorder
@GUID("e6857a76-2e3e-4fdd-bff4-5d2ba10fb453")
interface IDMLCommandRecorder : IDMLDeviceChild
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nf-directml-idmlcommandrecorder-recorddispatch
    void RecordDispatch(ID3D12CommandList commandList, IDMLDispatchable dispatchable, IDMLBindingTable bindings);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nn-directml-idmldebugdevice
@GUID("7d6f3ac9-394a-4ac3-92a7-390cc57a8217")
interface IDMLDebugDevice : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nf-directml-idmldebugdevice-setmutedebugoutput
    void SetMuteDebugOutput(BOOL mute);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nn-directml-idmldevice1
@GUID("a0884f9a-d2be-4355-aa5d-5901281ad1d2")
interface IDMLDevice1 : IDMLDevice
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/directml/nf-directml-idmldevice1-compilegraph
    HRESULT CompileGraph(const(DML_GRAPH_DESC)* desc, DML_EXECUTION_FLAGS flags, const(GUID)* riid, void** ppv);
}


// GUIDs


const GUID IID_IDMLBindingTable        = GUIDOF!IDMLBindingTable;
const GUID IID_IDMLCommandRecorder     = GUIDOF!IDMLCommandRecorder;
const GUID IID_IDMLCompiledOperator    = GUIDOF!IDMLCompiledOperator;
const GUID IID_IDMLDebugDevice         = GUIDOF!IDMLDebugDevice;
const GUID IID_IDMLDevice              = GUIDOF!IDMLDevice;
const GUID IID_IDMLDevice1             = GUIDOF!IDMLDevice1;
const GUID IID_IDMLDeviceChild         = GUIDOF!IDMLDeviceChild;
const GUID IID_IDMLDispatchable        = GUIDOF!IDMLDispatchable;
const GUID IID_IDMLObject              = GUIDOF!IDMLObject;
const GUID IID_IDMLOperator            = GUIDOF!IDMLOperator;
const GUID IID_IDMLOperatorInitializer = GUIDOF!IDMLOperatorInitializer;
const GUID IID_IDMLPageable            = GUIDOF!IDMLPageable;
