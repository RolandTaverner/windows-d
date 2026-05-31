// Written in the D programming language.

module windows.win32.devices.biometricframework;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOL, BOOLEAN, HANDLE, HRESULT, HWND,
                                                    POINT, PWSTR, RECT;
public import windows.win32.system.io : OVERLAPPED;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-setting-source-constants
alias WINBIO_SETTING_SOURCE = uint;
enum : uint
{
    WINBIO_SETTING_SOURCE_INVALID = 0x00000000U,
    WINBIO_SETTING_SOURCE_DEFAULT = 0x00000001U,
    WINBIO_SETTING_SOURCE_LOCAL   = 0x00000003U,
    WINBIO_SETTING_SOURCE_POLICY  = 0x00000002U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-component-constants
alias WINBIO_COMPONENT = uint;
enum : uint
{
    WINBIO_COMPONENT_SENSOR  = 0x00000001U,
    WINBIO_COMPONENT_ENGINE  = 0x00000002U,
    WINBIO_COMPONENT_STORAGE = 0x00000003U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-pool-constants
alias WINBIO_POOL = uint;
enum : uint
{
    WINBIO_POOL_SYSTEM  = 0x00000001U,
    WINBIO_POOL_PRIVATE = 0x00000002U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-anti-spoof-policy-action
alias WINBIO_ANTI_SPOOF_POLICY_ACTION = int;
enum : int
{
    WINBIO_ANTI_SPOOF_DISABLE = 0x00000000,
    WINBIO_ANTI_SPOOF_ENABLE  = 0x00000001,
    WINBIO_ANTI_SPOOF_REMOVE  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-policy-source
alias WINBIO_POLICY_SOURCE = int;
enum : int
{
    WINBIO_POLICY_UNKNOWN = 0x00000000,
    WINBIO_POLICY_DEFAULT = 0x00000001,
    WINBIO_POLICY_LOCAL   = 0x00000002,
    WINBIO_POLICY_ADMIN   = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-credential-type
alias WINBIO_CREDENTIAL_TYPE = int;
enum : int
{
    WINBIO_CREDENTIAL_PASSWORD = 0x00000001,
    WINBIO_CREDENTIAL_ALL      = 0xffffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-credential-format
alias WINBIO_CREDENTIAL_FORMAT = int;
enum : int
{
    WINBIO_PASSWORD_GENERIC   = 0x00000001,
    WINBIO_PASSWORD_PACKED    = 0x00000002,
    WINBIO_PASSWORD_PROTECTED = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-credential-state
alias WINBIO_CREDENTIAL_STATE = int;
enum : int
{
    WINBIO_CREDENTIAL_NOT_SET = 0x00000001,
    WINBIO_CREDENTIAL_SET     = 0x00000002,
}

alias WINBIO_ESS_STATE_FLAGS = int;
enum : int
{
    WINBIO_ESS_REQUIRES_TPM2                                 = 0x00000001,
    WINBIO_ESS_REQUIRES_VBS_CAPABLE                          = 0x00000002,
    WINBIO_ESS_REQUIRES_NON_VBS_WINDOWS_HELLO_ABSENCE        = 0x00000004,
    WINBIO_ESS_REQUIRES_VBS_WINDOWS_HELLO                    = 0x00000008,
    WINBIO_ESS_REQUIRES_VBS_RUNNING                          = 0x00000010,
    WINBIO_ESS_REQUIRES_VBS_ENCRYPTION_KEY                   = 0x00000020,
    WINBIO_ESS_REQUIRES_ENABLEMENT                           = 0x00000040,
    WINBIO_ESS_MANAGED_BY_POLICY                             = 0x00000080,
    WINBIO_ESS_REQUIRES_NON_VBS_BIOMETRIC_ENROLLMENT_ABSENCE = 0x00000100,
    WINBIO_ESS_REQUIRES_VBS_BIOMETRIC_ENROLLMENT             = 0x00000200,
    WINBIO_ESS_REQUIRES_FACE_SENSOR                          = 0x00000400,
    WINBIO_ESS_REQUIRES_FPR_SENSOR                           = 0x00000800,
    WINBIO_ESS_REQUIRES_ISOLATED_PROCESS                     = 0x00001000,
    WINBIO_ESS_BLOCKED_NON_ESS_FPR                           = 0x00002000,
    WINBIO_ESS_BLOCKED_NON_ESS_CAMERA                        = 0x00004000,
    WINBIO_ESS_SOURCE_DEFAULT                                = 0x00008000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbio/ne-winbio-winbio_async_notification_method
alias WINBIO_ASYNC_NOTIFICATION_METHOD = int;
enum : int
{
    WINBIO_ASYNC_NOTIFY_NONE          = 0x00000000,
    WINBIO_ASYNC_NOTIFY_CALLBACK      = 0x00000001,
    WINBIO_ASYNC_NOTIFY_MESSAGE       = 0x00000002,
    WINBIO_ASYNC_NOTIFY_MAXIMUM_VALUE = 0x00000003,
}

// Constants


enum uint WINBIO_MAX_STRING_LEN = 0x00000100U;

enum : uint
{
    WINBIO_SCP_VERSION_1           = 0x00000001U,
    WINBIO_SCP_RANDOM_SIZE_V1      = 0x00000020U,
    WINBIO_SCP_DIGEST_SIZE_V1      = 0x00000020U,
    WINBIO_SCP_CURVE_FIELD_SIZE_V1 = 0x00000020U,
}

enum : uint
{
    WINBIO_SCP_PUBLIC_KEY_SIZE_V1  = 0x00000041U,
    WINBIO_SCP_PRIVATE_KEY_SIZE_V1 = 0x00000020U,
}

enum uint WINBIO_SCP_SIGNATURE_SIZE_V1 = 0x00000040U;

enum : uint
{
    WINBIO_SCP_ENCRYPTION_BLOCK_SIZE_V1 = 0x00000010U,
    WINBIO_SCP_ENCRYPTION_KEY_SIZE_V1   = 0x00000020U,
}

enum : uint
{
    WINBIO_BIR_ALIGN_SIZE = 0x00000008U,
    WINBIO_BIR_ALGIN_SIZE = 0x00000008U,
}

enum : ushort
{
    WINBIO_DATA_FLAG_PRIVACY             = cast(ushort) 0x0002,
    WINBIO_DATA_FLAG_INTEGRITY           = cast(ushort) 0x0001,
    WINBIO_DATA_FLAG_SIGNED              = cast(ushort) 0x0004,
    WINBIO_DATA_FLAG_RAW                 = cast(ushort) 0x0020,
    WINBIO_DATA_FLAG_INTERMEDIATE        = cast(ushort) 0x0040,
    WINBIO_DATA_FLAG_PROCESSED           = cast(ushort) 0x0080,
    WINBIO_DATA_FLAG_OPTION_MASK_PRESENT = cast(ushort) 0x0008,
}

enum : ushort
{
    WINBIO_ANSI_381_PIXELS_PER_INCH                = cast(ushort) 0x0001,
    WINBIO_ANSI_381_PIXELS_PER_CM                  = cast(ushort) 0x0002,
    WINBIO_ANSI_381_IMG_UNCOMPRESSED               = cast(ushort) 0x0000,
    WINBIO_ANSI_381_IMG_BIT_PACKED                 = cast(ushort) 0x0001,
    WINBIO_ANSI_381_IMG_COMPRESSED_WSQ             = cast(ushort) 0x0002,
    WINBIO_ANSI_381_IMG_COMPRESSED_JPEG            = cast(ushort) 0x0003,
    WINBIO_ANSI_381_IMG_COMPRESSED_JPEG2000        = cast(ushort) 0x0004,
    WINBIO_ANSI_381_IMG_COMPRESSED_PNG             = cast(ushort) 0x0005,
    WINBIO_ANSI_381_IMP_TYPE_LIVE_SCAN_PLAIN       = cast(ushort) 0x0000,
    WINBIO_ANSI_381_IMP_TYPE_LIVE_SCAN_ROLLED      = cast(ushort) 0x0001,
    WINBIO_ANSI_381_IMP_TYPE_NONLIVE_SCAN_PLAIN    = cast(ushort) 0x0002,
    WINBIO_ANSI_381_IMP_TYPE_NONLIVE_SCAN_ROLLED   = cast(ushort) 0x0003,
    WINBIO_ANSI_381_IMP_TYPE_LATENT                = cast(ushort) 0x0007,
    WINBIO_ANSI_381_IMP_TYPE_SWIPE                 = cast(ushort) 0x0008,
    WINBIO_ANSI_381_IMP_TYPE_LIVE_SCAN_CONTACTLESS = cast(ushort) 0x0009,
}

enum : uint
{
    FACILITY_WINBIO = 0x00000009U,
    FACILITY_NONE   = 0x00000000U,
}

enum HRESULT WINBIO_E_UNSUPPORTED_FACTOR = HRESULT(0x80098001);

enum : HRESULT
{
    WINBIO_E_INVALID_UNIT    = HRESULT(0x80098002),
    WINBIO_E_UNKNOWN_ID      = HRESULT(0x80098003),
    WINBIO_E_CANCELED        = HRESULT(0x80098004),
    WINBIO_E_NO_MATCH        = HRESULT(0x80098005),
    WINBIO_E_CAPTURE_ABORTED = HRESULT(0x80098006),
}

enum HRESULT WINBIO_E_ENROLLMENT_IN_PROGRESS = HRESULT(0x80098007);

enum : HRESULT
{
    WINBIO_E_BAD_CAPTURE          = HRESULT(0x80098008),
    WINBIO_E_INVALID_CONTROL_CODE = HRESULT(0x80098009),
}

enum HRESULT WINBIO_E_DATA_COLLECTION_IN_PROGRESS = HRESULT(0x8009800b);

enum : HRESULT
{
    WINBIO_E_UNSUPPORTED_DATA_FORMAT = HRESULT(0x8009800c),
    WINBIO_E_UNSUPPORTED_DATA_TYPE   = HRESULT(0x8009800d),
    WINBIO_E_UNSUPPORTED_PURPOSE     = HRESULT(0x8009800e),
}

enum HRESULT WINBIO_E_INVALID_DEVICE_STATE = HRESULT(0x8009800f);

enum : HRESULT
{
    WINBIO_E_DEVICE_BUSY             = HRESULT(0x80098010),
    WINBIO_E_DATABASE_CANT_CREATE    = HRESULT(0x80098011),
    WINBIO_E_DATABASE_CANT_OPEN      = HRESULT(0x80098012),
    WINBIO_E_DATABASE_CANT_CLOSE     = HRESULT(0x80098013),
    WINBIO_E_DATABASE_CANT_ERASE     = HRESULT(0x80098014),
    WINBIO_E_DATABASE_CANT_FIND      = HRESULT(0x80098015),
    WINBIO_E_DATABASE_ALREADY_EXISTS = HRESULT(0x80098016),
    WINBIO_E_DATABASE_FULL           = HRESULT(0x80098018),
    WINBIO_E_DATABASE_LOCKED         = HRESULT(0x80098019),
    WINBIO_E_DATABASE_CORRUPTED      = HRESULT(0x8009801a),
    WINBIO_E_DATABASE_NO_SUCH_RECORD = HRESULT(0x8009801b),
}

enum HRESULT WINBIO_E_DUPLICATE_ENROLLMENT = HRESULT(0x8009801c);

enum : HRESULT
{
    WINBIO_E_DATABASE_READ_ERROR       = HRESULT(0x8009801d),
    WINBIO_E_DATABASE_WRITE_ERROR      = HRESULT(0x8009801e),
    WINBIO_E_DATABASE_NO_RESULTS       = HRESULT(0x8009801f),
    WINBIO_E_DATABASE_NO_MORE_RECORDS  = HRESULT(0x80098020),
    WINBIO_E_DATABASE_EOF              = HRESULT(0x80098021),
    WINBIO_E_DATABASE_BAD_INDEX_VECTOR = HRESULT(0x80098022),
}

enum : HRESULT
{
    WINBIO_E_INCORRECT_BSP         = HRESULT(0x80098024),
    WINBIO_E_INCORRECT_SENSOR_POOL = HRESULT(0x80098025),
}

enum HRESULT WINBIO_E_NO_CAPTURE_DATA = HRESULT(0x80098026);
enum HRESULT WINBIO_E_INVALID_SENSOR_MODE = HRESULT(0x80098027);
enum HRESULT WINBIO_E_LOCK_VIOLATION = HRESULT(0x8009802a);
enum HRESULT WINBIO_E_DUPLICATE_TEMPLATE = HRESULT(0x8009802b);
enum HRESULT WINBIO_E_INVALID_OPERATION = HRESULT(0x8009802c);

enum : HRESULT
{
    WINBIO_E_SESSION_BUSY            = HRESULT(0x8009802d),
    WINBIO_E_CRED_PROV_DISABLED      = HRESULT(0x80098030),
    WINBIO_E_CRED_PROV_NO_CREDENTIAL = HRESULT(0x80098031),
}

enum : HRESULT
{
    WINBIO_E_DISABLED              = HRESULT(0x80098032),
    WINBIO_E_CONFIGURATION_FAILURE = HRESULT(0x80098033),
}

enum HRESULT WINBIO_E_SENSOR_UNAVAILABLE = HRESULT(0x80098034);

enum : HRESULT
{
    WINBIO_E_SAS_ENABLED    = HRESULT(0x80098035),
    WINBIO_E_DEVICE_FAILURE = HRESULT(0x80098036),
}

enum HRESULT WINBIO_E_FAST_USER_SWITCH_DISABLED = HRESULT(0x80098037);
enum HRESULT WINBIO_E_NOT_ACTIVE_CONSOLE = HRESULT(0x80098038);
enum HRESULT WINBIO_E_EVENT_MONITOR_ACTIVE = HRESULT(0x80098039);

enum : HRESULT
{
    WINBIO_E_INVALID_PROPERTY_TYPE = HRESULT(0x8009803a),
    WINBIO_E_INVALID_PROPERTY_ID   = HRESULT(0x8009803b),
}

enum HRESULT WINBIO_E_UNSUPPORTED_PROPERTY = HRESULT(0x8009803c);
enum HRESULT WINBIO_E_ADAPTER_INTEGRITY_FAILURE = HRESULT(0x8009803d);
enum HRESULT WINBIO_E_INCORRECT_SESSION_TYPE = HRESULT(0x8009803e);
enum HRESULT WINBIO_E_SESSION_HANDLE_CLOSED = HRESULT(0x8009803f);
enum HRESULT WINBIO_E_DEADLOCK_DETECTED = HRESULT(0x80098040);
enum HRESULT WINBIO_E_NO_PREBOOT_IDENTITY = HRESULT(0x80098041);
enum HRESULT WINBIO_E_MAX_ERROR_COUNT_EXCEEDED = HRESULT(0x80098042);
enum HRESULT WINBIO_E_AUTO_LOGON_DISABLED = HRESULT(0x80098043);
enum HRESULT WINBIO_E_INVALID_TICKET = HRESULT(0x80098044);
enum HRESULT WINBIO_E_TICKET_QUOTA_EXCEEDED = HRESULT(0x80098045);
enum HRESULT WINBIO_E_DATA_PROTECTION_FAILURE = HRESULT(0x80098046);
enum HRESULT WINBIO_E_CRED_PROV_SECURITY_LOCKOUT = HRESULT(0x80098047);
enum HRESULT WINBIO_E_UNSUPPORTED_POOL_TYPE = HRESULT(0x80098048);
enum HRESULT WINBIO_E_SELECTION_REQUIRED = HRESULT(0x80098049);
enum HRESULT WINBIO_E_PRESENCE_MONITOR_ACTIVE = HRESULT(0x8009804a);

enum : HRESULT
{
    WINBIO_E_INVALID_SUBFACTOR                = HRESULT(0x8009804b),
    WINBIO_E_INVALID_CALIBRATION_FORMAT_ARRAY = HRESULT(0x8009804c),
}

enum HRESULT WINBIO_E_NO_SUPPORTED_CALIBRATION_FORMAT = HRESULT(0x8009804d);
enum HRESULT WINBIO_E_UNSUPPORTED_SENSOR_CALIBRATION_FORMAT = HRESULT(0x8009804e);

enum : HRESULT
{
    WINBIO_E_CALIBRATION_BUFFER_TOO_SMALL = HRESULT(0x8009804f),
    WINBIO_E_CALIBRATION_BUFFER_TOO_LARGE = HRESULT(0x80098050),
    WINBIO_E_CALIBRATION_BUFFER_INVALID   = HRESULT(0x80098051),
}

enum HRESULT WINBIO_E_INVALID_KEY_IDENTIFIER = HRESULT(0x80098052);

enum : HRESULT
{
    WINBIO_E_KEY_CREATION_FAILED             = HRESULT(0x80098053),
    WINBIO_E_KEY_IDENTIFIER_BUFFER_TOO_SMALL = HRESULT(0x80098054),
}

enum HRESULT WINBIO_E_PROPERTY_UNAVAILABLE = HRESULT(0x80098055);
enum HRESULT WINBIO_E_POLICY_PROTECTION_UNAVAILABLE = HRESULT(0x80098056);

enum : HRESULT
{
    WINBIO_E_INSECURE_SENSOR   = HRESULT(0x80098057),
    WINBIO_E_INVALID_BUFFER_ID = HRESULT(0x80098058),
    WINBIO_E_INVALID_BUFFER    = HRESULT(0x80098059),
}

enum HRESULT WINBIO_E_TRUSTLET_INTEGRITY_FAIL = HRESULT(0x8009805a);
enum HRESULT WINBIO_E_ENROLLMENT_CANCELED_BY_SUSPEND = HRESULT(0x8009805b);

enum : HRESULT
{
    WINBIO_I_MORE_DATA                   = HRESULT(0x00090001),
    WINBIO_I_EXTENDED_STATUS_INFORMATION = HRESULT(0x00090002),
}

enum GUID GUID_DEVINTERFACE_BIOMETRIC_READER = GUID("e2b5183a-99ea-4cc3-ad6b-80ca8d715b80");
enum uint IOCTL_BIOMETRIC_VENDOR = 0x00442000U;

enum : uint
{
    WINBIO_WBDI_MAJOR_VERSION = 0x00000001U,
    WINBIO_WBDI_MINOR_VERSION = 0x00000000U,
}

// Callbacks

alias PWINBIO_ASYNC_COMPLETION_CALLBACK = void function(WINBIO_ASYNC_RESULT* AsyncResult);
alias PWINBIO_VERIFY_CALLBACK = void function(void* VerifyCallbackContext, HRESULT OperationStatus, uint UnitId, 
                                              BOOLEAN Match, uint RejectDetail);
alias PWINBIO_IDENTIFY_CALLBACK = void function(void* IdentifyCallbackContext, HRESULT OperationStatus, 
                                                uint UnitId, WINBIO_IDENTITY* Identity, ubyte SubFactor, 
                                                uint RejectDetail);
alias PWINBIO_LOCATE_SENSOR_CALLBACK = void function(void* LocateCallbackContext, HRESULT OperationStatus, 
                                                     uint UnitId);
alias PWINBIO_ENROLL_CAPTURE_CALLBACK = void function(void* EnrollCallbackContext, HRESULT OperationStatus, 
                                                      uint RejectDetail);
alias PWINBIO_EVENT_CALLBACK = void function(void* EventCallbackContext, HRESULT OperationStatus, 
                                             WINBIO_EVENT* Event);
alias PWINBIO_CAPTURE_CALLBACK = void function(void* CaptureCallbackContext, HRESULT OperationStatus, uint UnitId, 
                                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/WINBIO_BIR* Sample, 
                                               size_t SampleSize, uint RejectDetail);
alias PIBIO_SENSOR_ATTACH_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_SENSOR_DETACH_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_SENSOR_CLEAR_CONTEXT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_SENSOR_QUERY_STATUS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint* Status);
alias PIBIO_SENSOR_RESET_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_SENSOR_SET_MODE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint Mode);
alias PIBIO_SENSOR_SET_INDICATOR_STATUS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint IndicatorStatus);
alias PIBIO_SENSOR_GET_INDICATOR_STATUS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint* IndicatorStatus);
alias PIBIO_SENSOR_START_CAPTURE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte Purpose, 
                                                       OVERLAPPED** Overlapped);
alias PIBIO_SENSOR_FINISH_CAPTURE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint* RejectDetail);
alias PIBIO_SENSOR_EXPORT_SENSOR_DATA_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_BIR** SampleBuffer, 
                                                            size_t* SampleSize);
alias PIBIO_SENSOR_CANCEL_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_SENSOR_PUSH_DATA_TO_ENGINE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte Purpose, ubyte Flags, 
                                                             uint* RejectDetail);
alias PIBIO_SENSOR_CONTROL_UNIT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint ControlCode, 
                                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* SendBuffer, 
                                                      size_t SendBufferSize, 
                                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* ReceiveBuffer, 
                                                      size_t ReceiveBufferSize, size_t* ReceiveDataSize, 
                                                      uint* OperationStatus);
alias PIBIO_SENSOR_CONTROL_UNIT_PRIVILEGED_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint ControlCode, 
                                                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* SendBuffer, 
                                                                 size_t SendBufferSize, 
                                                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* ReceiveBuffer, 
                                                                 size_t ReceiveBufferSize, size_t* ReceiveDataSize, 
                                                                 uint* OperationStatus);
alias PIBIO_SENSOR_NOTIFY_POWER_CHANGE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint PowerEventType);
alias PIBIO_SENSOR_PIPELINE_INIT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_SENSOR_PIPELINE_CLEANUP_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_SENSOR_ACTIVATE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_SENSOR_DEACTIVATE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_SENSOR_QUERY_EXTENDED_INFO_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WINBIO_EXTENDED_SENSOR_INFO* SensorInfo, 
                                                             size_t SensorInfoSize);
alias PIBIO_SENSOR_QUERY_CALIBRATION_FORMATS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, GUID* FormatArray, 
                                                                   size_t FormatArraySize, size_t* FormatCount);
alias PIBIO_SENSOR_SET_CALIBRATION_FORMAT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, GUID* Format);
alias PIBIO_SENSOR_ACCEPT_CALIBRATION_DATA_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* CalibrationBuffer, 
                                                                 size_t CalibrationBufferSize);
alias PIBIO_SENSOR_ASYNC_IMPORT_RAW_BUFFER_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* RawBufferAddress, 
                                                                 size_t RawBufferSize, ubyte** ResultBufferAddress, 
                                                                 size_t* ResultBufferSize);
alias PIBIO_SENSOR_ASYNC_IMPORT_SECURE_BUFFER_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                    GUID SecureBufferIdentifier, 
                                                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* MetadataBufferAddress, 
                                                                    size_t MetadataBufferSize, 
                                                                    ubyte** ResultBufferAddress, 
                                                                    size_t* ResultBufferSize);
alias PIBIO_SENSOR_QUERY_PRIVATE_SENSOR_TYPE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* TypeInfoBufferAddress, 
                                                                   size_t TypeInfoBufferSize, 
                                                                   size_t* TypeInfoDataSize);
alias PIBIO_SENSOR_CONNECT_SECURE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                        const(WINBIO_SECURE_CONNECTION_PARAMS)* ConnectionParams, 
                                                        WINBIO_SECURE_CONNECTION_DATA** ConnectionData);
alias PIBIO_SENSOR_START_CAPTURE_EX_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte Purpose, 
                                                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(ubyte)* Nonce, 
                                                          size_t NonceSize, ubyte Flags, OVERLAPPED** Overlapped);
alias PIBIO_SENSOR_START_NOTIFY_WAKE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, OVERLAPPED** Overlapped);
alias PIBIO_SENSOR_FINISH_NOTIFY_WAKE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint* Reason);
alias PWINBIO_QUERY_SENSOR_INTERFACE_FN = HRESULT function(WINBIO_SENSOR_INTERFACE** SensorInterface);
alias PIBIO_ENGINE_ATTACH_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_DETACH_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_CLEAR_CONTEXT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_QUERY_PREFERRED_FORMAT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                WINBIO_REGISTERED_FORMAT* StandardFormat, 
                                                                GUID* VendorFormat);
alias PIBIO_ENGINE_QUERY_INDEX_VECTOR_SIZE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                 size_t* IndexElementCount);
alias PIBIO_ENGINE_QUERY_HASH_ALGORITHMS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, size_t* AlgorithmCount, 
                                                               size_t* AlgorithmBufferSize, ubyte** AlgorithmBuffer);
alias PIBIO_ENGINE_SET_HASH_ALGORITHM_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, size_t AlgorithmBufferSize, 
                                                            ubyte* AlgorithmBuffer);
alias PIBIO_ENGINE_QUERY_SAMPLE_HINT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, size_t* SampleHint);
alias PIBIO_ENGINE_ACCEPT_SAMPLE_DATA_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WINBIO_BIR* SampleBuffer, 
                                                            size_t SampleSize, ubyte Purpose, uint* RejectDetail);
alias PIBIO_ENGINE_EXPORT_ENGINE_DATA_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte Flags, 
                                                            WINBIO_BIR** SampleBuffer, size_t* SampleSize);
alias PIBIO_ENGINE_VERIFY_FEATURE_SET_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, 
                                                            ubyte SubFactor, BOOLEAN* Match, ubyte** PayloadBlob, 
                                                            size_t* PayloadBlobSize, ubyte** HashValue, 
                                                            size_t* HashSize, uint* RejectDetail);
alias PIBIO_ENGINE_IDENTIFY_FEATURE_SET_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, 
                                                              ubyte* SubFactor, ubyte** PayloadBlob, 
                                                              size_t* PayloadBlobSize, ubyte** HashValue, 
                                                              size_t* HashSize, uint* RejectDetail);
alias PIBIO_ENGINE_CREATE_ENROLLMENT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_UPDATE_ENROLLMENT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint* RejectDetail);
alias PIBIO_ENGINE_GET_ENROLLMENT_STATUS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint* RejectDetail);
alias PIBIO_ENGINE_GET_ENROLLMENT_HASH_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte** HashValue, 
                                                             size_t* HashSize);
alias PIBIO_ENGINE_CHECK_FOR_DUPLICATE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, 
                                                             ubyte* SubFactor, BOOLEAN* Duplicate);
alias PIBIO_ENGINE_COMMIT_ENROLLMENT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, 
                                                           ubyte SubFactor, 
                                                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* PayloadBlob, 
                                                           size_t PayloadBlobSize);
alias PIBIO_ENGINE_DISCARD_ENROLLMENT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_CONTROL_UNIT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint ControlCode, 
                                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* SendBuffer, 
                                                      size_t SendBufferSize, 
                                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* ReceiveBuffer, 
                                                      size_t ReceiveBufferSize, size_t* ReceiveDataSize, 
                                                      uint* OperationStatus);
alias PIBIO_ENGINE_CONTROL_UNIT_PRIVILEGED_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint ControlCode, 
                                                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* SendBuffer, 
                                                                 size_t SendBufferSize, 
                                                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* ReceiveBuffer, 
                                                                 size_t ReceiveBufferSize, size_t* ReceiveDataSize, 
                                                                 uint* OperationStatus);
alias PIBIO_ENGINE_NOTIFY_POWER_CHANGE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint PowerEventType);
alias PIBIO_ENGINE_RESERVED_1_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity);
alias PIBIO_ENGINE_PIPELINE_INIT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_PIPELINE_CLEANUP_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_ACTIVATE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_DEACTIVATE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_QUERY_EXTENDED_INFO_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WINBIO_EXTENDED_ENGINE_INFO* EngineInfo, 
                                                             size_t EngineInfoSize);
alias PIBIO_ENGINE_IDENTIFY_ALL_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, size_t* PresenceCount, 
                                                      WINBIO_PRESENCE** PresenceArray);
alias PIBIO_ENGINE_SET_ENROLLMENT_SELECTOR_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, ulong SelectorValue);
alias PIBIO_ENGINE_SET_ENROLLMENT_PARAMETERS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                   WINBIO_EXTENDED_ENROLLMENT_PARAMETERS* Parameters);
alias PIBIO_ENGINE_QUERY_EXTENDED_ENROLLMENT_STATUS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WINBIO_EXTENDED_ENROLLMENT_STATUS* EnrollmentStatus, 
                                                                          size_t EnrollmentStatusSize);
alias PIBIO_ENGINE_REFRESH_CACHE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_SELECT_CALIBRATION_FORMAT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, GUID* FormatArray, 
                                                                   size_t FormatCount, GUID* SelectedFormat, 
                                                                   size_t* MaxBufferSize);
alias PIBIO_ENGINE_QUERY_CALIBRATION_DATA_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                BOOLEAN* DiscardAndRepeatCapture, 
                                                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* CalibrationBuffer, 
                                                                size_t* CalibrationBufferSize, size_t MaxBufferSize);
alias PIBIO_ENGINE_SET_ACCOUNT_POLICY_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                            WINBIO_ACCOUNT_POLICY* PolicyItemArray, 
                                                            size_t PolicyItemCount);
alias PIBIO_ENGINE_CREATE_KEY_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, const(ubyte)* Key, size_t KeySize, 
                                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* KeyIdentifier, 
                                                    size_t KeyIdentifierSize, size_t* ResultSize);
alias PIBIO_ENGINE_IDENTIFY_FEATURE_SET_SECURE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                     const(ubyte)* Nonce, size_t NonceSize, 
                                                                     const(ubyte)* KeyIdentifier, 
                                                                     size_t KeyIdentifierSize, 
                                                                     WINBIO_IDENTITY* Identity, ubyte* SubFactor, 
                                                                     uint* RejectDetail, ubyte** Authorization, 
                                                                     size_t* AuthorizationSize);
alias PIBIO_ENGINE_ACCEPT_PRIVATE_SENSOR_TYPE_INFO_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                         const(ubyte)* TypeInfoBufferAddress, 
                                                                         size_t TypeInfoBufferSize);
alias PIBIO_ENGINE_CREATE_ENROLLMENT_AUTHENTICATED_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte** Nonce, 
                                                                         size_t* NonceSize);
alias PIBIO_ENGINE_IDENTIFY_FEATURE_SET_AUTHENTICATED_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(ubyte)* Nonce, 
                                                                            size_t NonceSize, 
                                                                            WINBIO_IDENTITY* Identity, 
                                                                            ubyte* SubFactor, uint* RejectDetail, 
                                                                            ubyte** Authentication, 
                                                                            size_t* AuthenticationSize);
alias PWINBIO_QUERY_ENGINE_INTERFACE_FN = HRESULT function(WINBIO_ENGINE_INTERFACE** EngineInterface);
alias PIBIO_STORAGE_ATTACH_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_DETACH_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_CLEAR_CONTEXT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_CREATE_DATABASE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, GUID* DatabaseId, uint Factor, 
                                                          GUID* Format, const(PWSTR) FilePath, 
                                                          const(PWSTR) ConnectString, size_t IndexElementCount, 
                                                          size_t InitialSize);
alias PIBIO_STORAGE_ERASE_DATABASE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, GUID* DatabaseId, 
                                                         const(PWSTR) FilePath, const(PWSTR) ConnectString);
alias PIBIO_STORAGE_OPEN_DATABASE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, GUID* DatabaseId, 
                                                        const(PWSTR) FilePath, const(PWSTR) ConnectString);
alias PIBIO_STORAGE_CLOSE_DATABASE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_GET_DATA_FORMAT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, GUID* Format, 
                                                          WINBIO_VERSION* Version);
alias PIBIO_STORAGE_GET_DATABASE_SIZE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                            size_t* AvailableRecordCount, size_t* TotalRecordCount);
alias PIBIO_STORAGE_ADD_RECORD_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                     WINBIO_STORAGE_RECORD* RecordContents);
alias PIBIO_STORAGE_DELETE_RECORD_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, 
                                                        ubyte SubFactor);
alias PIBIO_STORAGE_QUERY_BY_SUBJECT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, 
                                                           ubyte SubFactor);
alias PIBIO_STORAGE_QUERY_BY_CONTENT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte SubFactor, 
                                                           uint* IndexVector, size_t IndexElementCount);
alias PIBIO_STORAGE_GET_RECORD_COUNT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, size_t* RecordCount);
alias PIBIO_STORAGE_FIRST_RECORD_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_NEXT_RECORD_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_GET_CURRENT_RECORD_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                             WINBIO_STORAGE_RECORD* RecordContents);
alias PIBIO_STORAGE_CONTROL_UNIT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint ControlCode, 
                                                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* SendBuffer, 
                                                       size_t SendBufferSize, 
                                                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* ReceiveBuffer, 
                                                       size_t ReceiveBufferSize, size_t* ReceiveDataSize, 
                                                       uint* OperationStatus);
alias PIBIO_STORAGE_CONTROL_UNIT_PRIVILEGED_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint ControlCode, 
                                                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* SendBuffer, 
                                                                  size_t SendBufferSize, 
                                                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* ReceiveBuffer, 
                                                                  size_t ReceiveBufferSize, size_t* ReceiveDataSize, 
                                                                  uint* OperationStatus);
alias PIBIO_STORAGE_NOTIFY_POWER_CHANGE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint PowerEventType);
alias PIBIO_STORAGE_PIPELINE_INIT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_PIPELINE_CLEANUP_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_ACTIVATE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_DEACTIVATE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_QUERY_EXTENDED_INFO_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WINBIO_EXTENDED_STORAGE_INFO* StorageInfo, 
                                                              size_t StorageInfoSize);
alias PIBIO_STORAGE_NOTIFY_DATABASE_CHANGE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, BOOLEAN RecordsAdded);
alias PIBIO_STORAGE_RESERVED_1_FN = HRESULT function(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/WINBIO_PIPELINE* Pipeline, 
                                                     /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/WINBIO_IDENTITY* Identity, 
                                                     /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/ulong* Reserved1, 
                                                     /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/ulong* Reserved2);
alias PIBIO_STORAGE_RESERVED_2_FN = HRESULT function(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/WINBIO_PIPELINE* Pipeline, 
                                                     /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/WINBIO_IDENTITY* Identity);
alias PIBIO_STORAGE_UPDATE_RECORD_BEGIN_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, 
                                                              ubyte SubFactor, WINBIO_STORAGE_RECORD* RecordContents);
alias PIBIO_STORAGE_UPDATE_RECORD_COMMIT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                               WINBIO_STORAGE_RECORD* RecordContents);
alias PWINBIO_QUERY_STORAGE_INTERFACE_FN = HRESULT function(WINBIO_STORAGE_INTERFACE** StorageInterface);
alias PIBIO_FRAMEWORK_SET_UNIT_STATUS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WINBIO_EXTENDED_UNIT_STATUS* ExtendedStatus, 
                                                            size_t ExtendedStatusSize);
alias PIBIO_FRAMEWORK_VSM_CACHE_CLEAR_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_FRAMEWORK_VSM_CACHE_IMPORT_BEGIN_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                   size_t RequiredCapacity, size_t* MaxBufferSize);
alias PIBIO_FRAMEWORK_VSM_CACHE_IMPORT_NEXT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* BufferAddress, 
                                                                  size_t BufferSize);
alias PIBIO_FRAMEWORK_VSM_CACHE_IMPORT_END_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_FRAMEWORK_VSM_CACHE_EXPORT_BEGIN_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                   size_t* RequiredCapacity, size_t* MaxBufferSize);
alias PIBIO_FRAMEWORK_VSM_CACHE_EXPORT_NEXT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* BufferAddress, 
                                                                  size_t BufferSize, size_t* ReturnedDataSize);
alias PIBIO_FRAMEWORK_VSM_CACHE_EXPORT_END_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_FRAMEWORK_VSM_STORAGE_RESERVED_1_FN = HRESULT function(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/WINBIO_PIPELINE* Pipeline, 
                                                                   size_t Reserved1, 
                                                                   /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/size_t* Reserved2);
alias PIBIO_FRAMEWORK_VSM_STORAGE_RESERVED_2_FN = HRESULT function(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/WINBIO_PIPELINE* Pipeline, 
                                                                   /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/ubyte* Reserved1, 
                                                                   size_t Reserved2);
alias PIBIO_FRAMEWORK_VSM_STORAGE_RESERVED_3_FN = HRESULT function(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/WINBIO_PIPELINE* Pipeline);
alias PIBIO_FRAMEWORK_ALLOCATE_MEMORY_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, size_t AllocationSize, 
                                                            void** Address);
alias PIBIO_FRAMEWORK_FREE_MEMORY_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, void* Address);
alias PIBIO_FRAMEWORK_GET_PROPERTY_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint PropertyType, 
                                                         uint PropertyId, WINBIO_IDENTITY* Identity, ubyte SubFactor, 
                                                         void** PropertyBuffer, size_t* PropertyBufferSize);
alias PIBIO_FRAMEWORK_LOCK_AND_VALIDATE_SECURE_BUFFER_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                            GUID SecureBufferIdentifier, 
                                                                            void** SecureBufferAddress, 
                                                                            size_t* SecureBufferSize);
alias PIBIO_FRAMEWORK_RELEASE_SECURE_BUFFER_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                  GUID SecureBufferIdentifier);
alias PIBIO_FRAMEWORK_VSM_QUERY_AUTHORIZED_ENROLLMENTS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                             WINBIO_IDENTITY* Identity, 
                                                                             size_t* SecureIdentityCount, 
                                                                             WINBIO_IDENTITY** SecureIdentities);
alias PIBIO_FRAMEWORK_VSM_DECRYPT_SAMPLE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(ubyte)* Authentication, 
                                                               size_t AuthenticationSize, 
                                                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(ubyte)* Iv, 
                                                               size_t IvSize, 
                                                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* EncryptedData, 
                                                               size_t EncryptedDataSize);

// Structs


struct WINIBIO_SENSOR_CONTEXT
{
    ptrdiff_t Value;
}

struct WINIBIO_ENGINE_CONTEXT
{
    ptrdiff_t Value;
}

struct WINIBIO_STORAGE_CONTEXT
{
    ptrdiff_t Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-version
struct WINBIO_VERSION
{
    uint MajorVersion;
    uint MinorVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-identity
struct WINBIO_IDENTITY
{
    uint Type;
    union Value
    {
        uint      Null;
        uint      Wildcard;
        GUID      TemplateGuid;
        struct AccountSid
        {
            uint      Size;
            ubyte[68] Data;
        }
        ubyte[32] SecureId;
    }
}

struct WINBIO_SECURE_CONNECTION_PARAMS
{
    uint   PayloadSize;
    ushort Version;
    ushort Flags;
}

struct WINBIO_SECURE_CONNECTION_DATA
{
    uint   Size;
    ushort Version;
    ushort Flags;
    uint   ModelCertificateSize;
    uint   IntermediateCA1Size;
    uint   IntermediateCA2Size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-bir-data
struct WINBIO_BIR_DATA
{
    uint Size;
    uint Offset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-bir
struct WINBIO_BIR
{
    WINBIO_BIR_DATA HeaderBlock;
    WINBIO_BIR_DATA StandardDataBlock;
    WINBIO_BIR_DATA VendorDataBlock;
    WINBIO_BIR_DATA SignatureBlock;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-registered-format
struct WINBIO_REGISTERED_FORMAT
{
    ushort Owner;
    ushort Type;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-bir-header
struct WINBIO_BIR_HEADER
{
    ushort ValidFields;
    ubyte  HeaderVersion;
    ubyte  PatronHeaderVersion;
    ubyte  DataFlags;
    uint   Type;
    ubyte  Subtype;
    ubyte  Purpose;
    byte   DataQuality;
    long   CreationDate;
    struct ValidityPeriod
    {
        long BeginDate;
        long EndDate;
    }
    WINBIO_REGISTERED_FORMAT BiometricDataFormat;
    WINBIO_REGISTERED_FORMAT ProductId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-bdb-ansi-381-header
struct WINBIO_BDB_ANSI_381_HEADER
{
    ulong  RecordLength;
    uint   FormatIdentifier;
    uint   VersionNumber;
    WINBIO_REGISTERED_FORMAT ProductId;
    ushort CaptureDeviceId;
    ushort ImageAcquisitionLevel;
    ushort HorizontalScanResolution;
    ushort VerticalScanResolution;
    ushort HorizontalImageResolution;
    ushort VerticalImageResolution;
    ubyte  ElementCount;
    ubyte  ScaleUnits;
    ubyte  PixelDepth;
    ubyte  ImageCompressionAlg;
    ushort Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-bdb-ansi-381-record
struct WINBIO_BDB_ANSI_381_RECORD
{
    uint   BlockLength;
    ushort HorizontalLineLength;
    ushort VerticalLineLength;
    ubyte  Position;
    ubyte  CountOfViews;
    ubyte  ViewNumber;
    ubyte  ImageQuality;
    ubyte  ImpressionType;
    ubyte  Reserved;
}

struct WINBIO_SECURE_BUFFER_HEADER_V1
{
    uint  Type;
    uint  Size;
    uint  Flags;
    ulong ValidationTag;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-event-constants
struct WINBIO_EVENT
{
    uint Type;
    union Parameters
    {
        struct Unclaimed
        {
            uint UnitId;
            uint RejectDetail;
        }
        struct UnclaimedIdentify
        {
            uint            UnitId;
            WINBIO_IDENTITY Identity;
            ubyte           SubFactor;
            uint            RejectDetail;
        }
        struct Error
        {
            HRESULT ErrorCode;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-presence-properties
union WINBIO_PRESENCE_PROPERTIES
{
    struct FacialFeatures
    {
        RECT BoundingBox;
        int  Distance;
        struct OpaqueEngineData
        {
            GUID     AdapterId;
            uint[78] Data;
        }
    }
    struct Iris
    {
        RECT  EyeBoundingBox_1;
        RECT  EyeBoundingBox_2;
        POINT PupilCenter_1;
        POINT PupilCenter_2;
        int   Distance;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-presence
struct WINBIO_PRESENCE
{
    uint            Factor;
    ubyte           SubFactor;
    HRESULT         Status;
    uint            RejectDetail;
    WINBIO_IDENTITY Identity;
    ulong           TrackingId;
    ulong           Ticket;
    WINBIO_PRESENCE_PROPERTIES Properties;
    struct Authorization
    {
        uint      Size;
        ubyte[32] Data;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-bsp-schema
struct WINBIO_BSP_SCHEMA
{
    uint           BiometricFactor;
    GUID           BspId;
    ushort[256]    Description;
    ushort[256]    Vendor;
    WINBIO_VERSION Version;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-unit-schema
struct WINBIO_UNIT_SCHEMA
{
    uint           UnitId;
    uint           PoolType;
    uint           BiometricFactor;
    uint           SensorSubType;
    uint           Capabilities;
    ushort[256]    DeviceInstanceId;
    ushort[256]    Description;
    ushort[256]    Manufacturer;
    ushort[256]    Model;
    ushort[256]    SerialNumber;
    WINBIO_VERSION FirmwareVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-storage-schema
struct WINBIO_STORAGE_SCHEMA
{
    uint        BiometricFactor;
    GUID        DatabaseId;
    GUID        DataFormat;
    uint        Attributes;
    ushort[256] FilePath;
    ushort[256] ConnectionString;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-extended-sensor-info
struct WINBIO_EXTENDED_SENSOR_INFO
{
    uint GenericSensorCapabilities;
    uint Factor;
    union Specific
    {
        uint Null;
        struct FacialFeatures
        {
            RECT  FrameSize;
            POINT FrameOffset;
            uint  MandatoryOrientation;
            struct HardwareInfo
            {
                wchar[260] ColorSensorId;
                wchar[260] InfraredSensorId;
                uint       InfraredSensorRotationAngle;
            }
        }
        struct Fingerprint
        {
            uint Reserved;
        }
        struct Iris
        {
            RECT  FrameSize;
            POINT FrameOffset;
            uint  MandatoryOrientation;
        }
        struct Voice
        {
            uint Reserved;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-extended-engine-info
struct WINBIO_EXTENDED_ENGINE_INFO
{
    uint GenericEngineCapabilities;
    uint Factor;
    union Specific
    {
        uint Null;
        struct FacialFeatures
        {
            uint Capabilities;
            struct EnrollmentRequirements
            {
                uint Null;
            }
        }
        struct Fingerprint
        {
            uint Capabilities;
            struct EnrollmentRequirements
            {
                uint GeneralSamples;
                uint Center;
                uint TopEdge;
                uint BottomEdge;
                uint LeftEdge;
                uint RightEdge;
            }
        }
        struct Iris
        {
            uint Capabilities;
            struct EnrollmentRequirements
            {
                uint Null;
            }
        }
        struct Voice
        {
            uint Capabilities;
            struct EnrollmentRequirements
            {
                uint Null;
            }
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-extended-storage-info
struct WINBIO_EXTENDED_STORAGE_INFO
{
    uint GenericStorageCapabilities;
    uint Factor;
    union Specific
    {
        uint Null;
        struct FacialFeatures
        {
            uint Capabilities;
        }
        struct Fingerprint
        {
            uint Capabilities;
        }
        struct Iris
        {
            uint Capabilities;
        }
        struct Voice
        {
            uint Capabilities;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-extended-enrollment-status
struct WINBIO_EXTENDED_ENROLLMENT_STATUS
{
    HRESULT TemplateStatus;
    uint    RejectDetail;
    uint    PercentComplete;
    uint    Factor;
    ubyte   SubFactor;
    union Specific
    {
        uint Null;
        struct FacialFeatures
        {
            RECT BoundingBox;
            int  Distance;
            struct OpaqueEngineData
            {
                GUID     AdapterId;
                uint[78] Data;
            }
        }
        struct Fingerprint
        {
            uint GeneralSamples;
            uint Center;
            uint TopEdge;
            uint BottomEdge;
            uint LeftEdge;
            uint RightEdge;
        }
        struct Iris
        {
            RECT   EyeBoundingBox_1;
            RECT   EyeBoundingBox_2;
            POINT  PupilCenter_1;
            POINT  PupilCenter_2;
            int    Distance;
            uint   GridPointCompletionPercent;
            ushort GridPointIndex;
            struct Point3D
            {
                double X;
                double Y;
                double Z;
            }
            BOOL   StopCaptureAndShowCriticalFeedback;
        }
        struct Voice
        {
            uint Reserved;
        }
    }
}

struct WINBIO_EXTENDED_UNIT_STATUS
{
    uint Availability;
    uint ReasonCode;
}

struct WINBIO_FP_BU_STATE
{
    BOOL    SensorAttached;
    HRESULT CreationResult;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-anti-spoof-policy
struct WINBIO_ANTI_SPOOF_POLICY
{
    WINBIO_ANTI_SPOOF_POLICY_ACTION Action;
    WINBIO_POLICY_SOURCE Source;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-extended-enrollment-parameters
struct WINBIO_EXTENDED_ENROLLMENT_PARAMETERS
{
    size_t Size;
    ubyte  SubFactor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecBioMet/winbio-account-policy
struct WINBIO_ACCOUNT_POLICY
{
    WINBIO_IDENTITY Identity;
    WINBIO_ANTI_SPOOF_POLICY_ACTION AntiSpoofBehavior;
}

struct WINBIO_PROTECTION_POLICY
{
    uint            Version;
    WINBIO_IDENTITY Identity;
    GUID            DatabaseId;
    ulong           UserState;
    size_t          PolicySize;
    ubyte[128]      Policy;
}

struct WINBIO_GESTURE_METADATA
{
    size_t Size;
    uint   BiometricType;
    uint   MatchType;
    uint   ProtectionType;
}

struct WINBIO_CONNECTED_SENSOR
{
    uint biometricType;
    BOOL isEnhancedSignInSecurityCapable;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbio/ns-winbio-winbio_async_result
struct WINBIO_ASYNC_RESULT
{
    uint    SessionHandle;
    uint    Operation;
    ulong   SequenceNumber;
    long    TimeStamp;
    HRESULT ApiStatus;
    uint    UnitId;
    void*   UserData;
    union Parameters
    {
        struct Verify
        {
            BOOLEAN Match;
            uint    RejectDetail;
        }
        struct Identify
        {
            WINBIO_IDENTITY Identity;
            ubyte           SubFactor;
            uint            RejectDetail;
        }
        struct EnrollBegin
        {
            ubyte SubFactor;
        }
        struct EnrollCapture
        {
            uint RejectDetail;
        }
        struct EnrollCommit
        {
            WINBIO_IDENTITY Identity;
            BOOLEAN         IsNewTemplate;
        }
        struct EnumEnrollments
        {
            WINBIO_IDENTITY Identity;
            size_t          SubFactorCount;
            ubyte*          SubFactorArray;
        }
        struct CaptureSample
        {
            WINBIO_BIR* Sample;
            size_t      SampleSize;
            uint        RejectDetail;
        }
        struct DeleteTemplate
        {
            WINBIO_IDENTITY Identity;
            ubyte           SubFactor;
        }
        struct GetProperty
        {
            uint            PropertyType;
            uint            PropertyId;
            WINBIO_IDENTITY Identity;
            ubyte           SubFactor;
            size_t          PropertyBufferSize;
            void*           PropertyBuffer;
        }
        struct SetProperty
        {
            uint            PropertyType;
            uint            PropertyId;
            WINBIO_IDENTITY Identity;
            ubyte           SubFactor;
            size_t          PropertyBufferSize;
            void*           PropertyBuffer;
        }
        struct GetEvent
        {
            WINBIO_EVENT Event;
        }
        struct ControlUnit
        {
            WINBIO_COMPONENT Component;
            uint             ControlCode;
            uint             OperationStatus;
            ubyte*           SendBuffer;
            size_t           SendBufferSize;
            ubyte*           ReceiveBuffer;
            size_t           ReceiveBufferSize;
            size_t           ReceiveDataSize;
        }
        struct EnumServiceProviders
        {
            size_t             BspCount;
            WINBIO_BSP_SCHEMA* BspSchemaArray;
        }
        struct EnumBiometricUnits
        {
            size_t              UnitCount;
            WINBIO_UNIT_SCHEMA* UnitSchemaArray;
        }
        struct EnumDatabases
        {
            size_t StorageCount;
            WINBIO_STORAGE_SCHEMA* StorageSchemaArray;
        }
        struct VerifyAndReleaseTicket
        {
            BOOLEAN Match;
            uint    RejectDetail;
            ulong   Ticket;
        }
        struct IdentifyAndReleaseTicket
        {
            WINBIO_IDENTITY Identity;
            ubyte           SubFactor;
            uint            RejectDetail;
            ulong           Ticket;
        }
        struct EnrollSelect
        {
            ulong SelectorValue;
        }
        struct MonitorPresence
        {
            uint             ChangeType;
            size_t           PresenceCount;
            WINBIO_PRESENCE* PresenceArray;
        }
        struct GetProtectionPolicy
        {
            WINBIO_IDENTITY Identity;
            WINBIO_PROTECTION_POLICY Policy;
        }
        struct NotifyUnitStatusChange
        {
            WINBIO_EXTENDED_UNIT_STATUS ExtendedStatus;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbio_adapter/ns-winbio_adapter-winbio_storage_record
struct WINBIO_STORAGE_RECORD
{
    WINBIO_IDENTITY* Identity;
    ubyte            SubFactor;
    uint*            IndexVector;
    size_t           IndexElementCount;
    ubyte*           TemplateBlob;
    size_t           TemplateBlobSize;
    ubyte*           PayloadBlob;
    size_t           PayloadBlobSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbio_adapter/ns-winbio_adapter-winbio_pipeline
struct WINBIO_PIPELINE
{
    HANDLE SensorHandle;
    HANDLE EngineHandle;
    HANDLE StorageHandle;
    WINBIO_SENSOR_INTERFACE* SensorInterface;
    WINBIO_ENGINE_INTERFACE* EngineInterface;
    WINBIO_STORAGE_INTERFACE* StorageInterface;
    WINIBIO_SENSOR_CONTEXT* SensorContext;
    WINIBIO_ENGINE_CONTEXT* EngineContext;
    WINIBIO_STORAGE_CONTEXT* StorageContext;
    WINBIO_FRAMEWORK_INTERFACE* FrameworkInterface;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbio_adapter/ns-winbio_adapter-winbio_adapter_interface_version
struct WINBIO_ADAPTER_INTERFACE_VERSION
{
    ushort MajorVersion;
    ushort MinorVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbio_adapter/ns-winbio_adapter-winbio_sensor_interface
struct WINBIO_SENSOR_INTERFACE
{
    WINBIO_ADAPTER_INTERFACE_VERSION Version;
    uint   Type;
    size_t Size;
    GUID   AdapterId;
    PIBIO_SENSOR_ATTACH_FN Attach;
    PIBIO_SENSOR_DETACH_FN Detach;
    PIBIO_SENSOR_CLEAR_CONTEXT_FN ClearContext;
    PIBIO_SENSOR_QUERY_STATUS_FN QueryStatus;
    PIBIO_SENSOR_RESET_FN Reset;
    PIBIO_SENSOR_SET_MODE_FN SetMode;
    PIBIO_SENSOR_SET_INDICATOR_STATUS_FN SetIndicatorStatus;
    PIBIO_SENSOR_GET_INDICATOR_STATUS_FN GetIndicatorStatus;
    PIBIO_SENSOR_START_CAPTURE_FN StartCapture;
    PIBIO_SENSOR_FINISH_CAPTURE_FN FinishCapture;
    PIBIO_SENSOR_EXPORT_SENSOR_DATA_FN ExportSensorData;
    PIBIO_SENSOR_CANCEL_FN Cancel;
    PIBIO_SENSOR_PUSH_DATA_TO_ENGINE_FN PushDataToEngine;
    PIBIO_SENSOR_CONTROL_UNIT_FN ControlUnit;
    PIBIO_SENSOR_CONTROL_UNIT_PRIVILEGED_FN ControlUnitPrivileged;
    PIBIO_SENSOR_NOTIFY_POWER_CHANGE_FN NotifyPowerChange;
    PIBIO_SENSOR_PIPELINE_INIT_FN PipelineInit;
    PIBIO_SENSOR_PIPELINE_CLEANUP_FN PipelineCleanup;
    PIBIO_SENSOR_ACTIVATE_FN Activate;
    PIBIO_SENSOR_DEACTIVATE_FN Deactivate;
    PIBIO_SENSOR_QUERY_EXTENDED_INFO_FN QueryExtendedInfo;
    PIBIO_SENSOR_QUERY_CALIBRATION_FORMATS_FN QueryCalibrationFormats;
    PIBIO_SENSOR_SET_CALIBRATION_FORMAT_FN SetCalibrationFormat;
    PIBIO_SENSOR_ACCEPT_CALIBRATION_DATA_FN AcceptCalibrationData;
    PIBIO_SENSOR_ASYNC_IMPORT_RAW_BUFFER_FN AsyncImportRawBuffer;
    PIBIO_SENSOR_ASYNC_IMPORT_SECURE_BUFFER_FN AsyncImportSecureBuffer;
    PIBIO_SENSOR_QUERY_PRIVATE_SENSOR_TYPE_FN QueryPrivateSensorType;
    PIBIO_SENSOR_CONNECT_SECURE_FN ConnectSecure;
    PIBIO_SENSOR_START_CAPTURE_EX_FN StartCaptureEx;
    PIBIO_SENSOR_START_NOTIFY_WAKE_FN StartNotifyWake;
    PIBIO_SENSOR_FINISH_NOTIFY_WAKE_FN FinishNotifyWake;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbio_adapter/ns-winbio_adapter-winbio_engine_interface
struct WINBIO_ENGINE_INTERFACE
{
    WINBIO_ADAPTER_INTERFACE_VERSION Version;
    uint   Type;
    size_t Size;
    GUID   AdapterId;
    PIBIO_ENGINE_ATTACH_FN Attach;
    PIBIO_ENGINE_DETACH_FN Detach;
    PIBIO_ENGINE_CLEAR_CONTEXT_FN ClearContext;
    PIBIO_ENGINE_QUERY_PREFERRED_FORMAT_FN QueryPreferredFormat;
    PIBIO_ENGINE_QUERY_INDEX_VECTOR_SIZE_FN QueryIndexVectorSize;
    PIBIO_ENGINE_QUERY_HASH_ALGORITHMS_FN QueryHashAlgorithms;
    PIBIO_ENGINE_SET_HASH_ALGORITHM_FN SetHashAlgorithm;
    PIBIO_ENGINE_QUERY_SAMPLE_HINT_FN QuerySampleHint;
    PIBIO_ENGINE_ACCEPT_SAMPLE_DATA_FN AcceptSampleData;
    PIBIO_ENGINE_EXPORT_ENGINE_DATA_FN ExportEngineData;
    PIBIO_ENGINE_VERIFY_FEATURE_SET_FN VerifyFeatureSet;
    PIBIO_ENGINE_IDENTIFY_FEATURE_SET_FN IdentifyFeatureSet;
    PIBIO_ENGINE_CREATE_ENROLLMENT_FN CreateEnrollment;
    PIBIO_ENGINE_UPDATE_ENROLLMENT_FN UpdateEnrollment;
    PIBIO_ENGINE_GET_ENROLLMENT_STATUS_FN GetEnrollmentStatus;
    PIBIO_ENGINE_GET_ENROLLMENT_HASH_FN GetEnrollmentHash;
    PIBIO_ENGINE_CHECK_FOR_DUPLICATE_FN CheckForDuplicate;
    PIBIO_ENGINE_COMMIT_ENROLLMENT_FN CommitEnrollment;
    PIBIO_ENGINE_DISCARD_ENROLLMENT_FN DiscardEnrollment;
    PIBIO_ENGINE_CONTROL_UNIT_FN ControlUnit;
    PIBIO_ENGINE_CONTROL_UNIT_PRIVILEGED_FN ControlUnitPrivileged;
    PIBIO_ENGINE_NOTIFY_POWER_CHANGE_FN NotifyPowerChange;
    PIBIO_ENGINE_RESERVED_1_FN Reserved_1;
    PIBIO_ENGINE_PIPELINE_INIT_FN PipelineInit;
    PIBIO_ENGINE_PIPELINE_CLEANUP_FN PipelineCleanup;
    PIBIO_ENGINE_ACTIVATE_FN Activate;
    PIBIO_ENGINE_DEACTIVATE_FN Deactivate;
    PIBIO_ENGINE_QUERY_EXTENDED_INFO_FN QueryExtendedInfo;
    PIBIO_ENGINE_IDENTIFY_ALL_FN IdentifyAll;
    PIBIO_ENGINE_SET_ENROLLMENT_SELECTOR_FN SetEnrollmentSelector;
    PIBIO_ENGINE_SET_ENROLLMENT_PARAMETERS_FN SetEnrollmentParameters;
    PIBIO_ENGINE_QUERY_EXTENDED_ENROLLMENT_STATUS_FN QueryExtendedEnrollmentStatus;
    PIBIO_ENGINE_REFRESH_CACHE_FN RefreshCache;
    PIBIO_ENGINE_SELECT_CALIBRATION_FORMAT_FN SelectCalibrationFormat;
    PIBIO_ENGINE_QUERY_CALIBRATION_DATA_FN QueryCalibrationData;
    PIBIO_ENGINE_SET_ACCOUNT_POLICY_FN SetAccountPolicy;
    PIBIO_ENGINE_CREATE_KEY_FN CreateKey;
    PIBIO_ENGINE_IDENTIFY_FEATURE_SET_SECURE_FN IdentifyFeatureSetSecure;
    PIBIO_ENGINE_ACCEPT_PRIVATE_SENSOR_TYPE_INFO_FN AcceptPrivateSensorTypeInfo;
    PIBIO_ENGINE_CREATE_ENROLLMENT_AUTHENTICATED_FN CreateEnrollmentAuthenticated;
    PIBIO_ENGINE_IDENTIFY_FEATURE_SET_AUTHENTICATED_FN IdentifyFeatureSetAuthenticated;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbio_adapter/ns-winbio_adapter-winbio_storage_interface
struct WINBIO_STORAGE_INTERFACE
{
    WINBIO_ADAPTER_INTERFACE_VERSION Version;
    uint   Type;
    size_t Size;
    GUID   AdapterId;
    PIBIO_STORAGE_ATTACH_FN Attach;
    PIBIO_STORAGE_DETACH_FN Detach;
    PIBIO_STORAGE_CLEAR_CONTEXT_FN ClearContext;
    PIBIO_STORAGE_CREATE_DATABASE_FN CreateDatabase;
    PIBIO_STORAGE_ERASE_DATABASE_FN EraseDatabase;
    PIBIO_STORAGE_OPEN_DATABASE_FN OpenDatabase;
    PIBIO_STORAGE_CLOSE_DATABASE_FN CloseDatabase;
    PIBIO_STORAGE_GET_DATA_FORMAT_FN GetDataFormat;
    PIBIO_STORAGE_GET_DATABASE_SIZE_FN GetDatabaseSize;
    PIBIO_STORAGE_ADD_RECORD_FN AddRecord;
    PIBIO_STORAGE_DELETE_RECORD_FN DeleteRecord;
    PIBIO_STORAGE_QUERY_BY_SUBJECT_FN QueryBySubject;
    PIBIO_STORAGE_QUERY_BY_CONTENT_FN QueryByContent;
    PIBIO_STORAGE_GET_RECORD_COUNT_FN GetRecordCount;
    PIBIO_STORAGE_FIRST_RECORD_FN FirstRecord;
    PIBIO_STORAGE_NEXT_RECORD_FN NextRecord;
    PIBIO_STORAGE_GET_CURRENT_RECORD_FN GetCurrentRecord;
    PIBIO_STORAGE_CONTROL_UNIT_FN ControlUnit;
    PIBIO_STORAGE_CONTROL_UNIT_PRIVILEGED_FN ControlUnitPrivileged;
    PIBIO_STORAGE_NOTIFY_POWER_CHANGE_FN NotifyPowerChange;
    PIBIO_STORAGE_PIPELINE_INIT_FN PipelineInit;
    PIBIO_STORAGE_PIPELINE_CLEANUP_FN PipelineCleanup;
    PIBIO_STORAGE_ACTIVATE_FN Activate;
    PIBIO_STORAGE_DEACTIVATE_FN Deactivate;
    PIBIO_STORAGE_QUERY_EXTENDED_INFO_FN QueryExtendedInfo;
    PIBIO_STORAGE_NOTIFY_DATABASE_CHANGE_FN NotifyDatabaseChange;
    PIBIO_STORAGE_RESERVED_1_FN Reserved1;
    PIBIO_STORAGE_RESERVED_2_FN Reserved2;
    PIBIO_STORAGE_UPDATE_RECORD_BEGIN_FN UpdateRecordBegin;
    PIBIO_STORAGE_UPDATE_RECORD_COMMIT_FN UpdateRecordCommit;
}

struct WINBIO_FRAMEWORK_INTERFACE
{
    WINBIO_ADAPTER_INTERFACE_VERSION Version;
    uint   Type;
    size_t Size;
    GUID   AdapterId;
    PIBIO_FRAMEWORK_SET_UNIT_STATUS_FN SetUnitStatus;
    PIBIO_STORAGE_ATTACH_FN VsmStorageAttach;
    PIBIO_STORAGE_DETACH_FN VsmStorageDetach;
    PIBIO_STORAGE_CLEAR_CONTEXT_FN VsmStorageClearContext;
    PIBIO_STORAGE_CREATE_DATABASE_FN VsmStorageCreateDatabase;
    PIBIO_STORAGE_OPEN_DATABASE_FN VsmStorageOpenDatabase;
    PIBIO_STORAGE_CLOSE_DATABASE_FN VsmStorageCloseDatabase;
    PIBIO_STORAGE_DELETE_RECORD_FN VsmStorageDeleteRecord;
    PIBIO_STORAGE_NOTIFY_POWER_CHANGE_FN VsmStorageNotifyPowerChange;
    PIBIO_STORAGE_PIPELINE_INIT_FN VsmStoragePipelineInit;
    PIBIO_STORAGE_PIPELINE_CLEANUP_FN VsmStoragePipelineCleanup;
    PIBIO_STORAGE_ACTIVATE_FN VsmStorageActivate;
    PIBIO_STORAGE_DEACTIVATE_FN VsmStorageDeactivate;
    PIBIO_STORAGE_QUERY_EXTENDED_INFO_FN VsmStorageQueryExtendedInfo;
    PIBIO_FRAMEWORK_VSM_CACHE_CLEAR_FN VsmStorageCacheClear;
    PIBIO_FRAMEWORK_VSM_CACHE_IMPORT_BEGIN_FN VsmStorageCacheImportBegin;
    PIBIO_FRAMEWORK_VSM_CACHE_IMPORT_NEXT_FN VsmStorageCacheImportNext;
    PIBIO_FRAMEWORK_VSM_CACHE_IMPORT_END_FN VsmStorageCacheImportEnd;
    PIBIO_FRAMEWORK_VSM_CACHE_EXPORT_BEGIN_FN VsmStorageCacheExportBegin;
    PIBIO_FRAMEWORK_VSM_CACHE_EXPORT_NEXT_FN VsmStorageCacheExportNext;
    PIBIO_FRAMEWORK_VSM_CACHE_EXPORT_END_FN VsmStorageCacheExportEnd;
    PIBIO_SENSOR_ATTACH_FN VsmSensorAttach;
    PIBIO_SENSOR_DETACH_FN VsmSensorDetach;
    PIBIO_SENSOR_CLEAR_CONTEXT_FN VsmSensorClearContext;
    PIBIO_SENSOR_PUSH_DATA_TO_ENGINE_FN VsmSensorPushDataToEngine;
    PIBIO_SENSOR_NOTIFY_POWER_CHANGE_FN VsmSensorNotifyPowerChange;
    PIBIO_SENSOR_PIPELINE_INIT_FN VsmSensorPipelineInit;
    PIBIO_SENSOR_PIPELINE_CLEANUP_FN VsmSensorPipelineCleanup;
    PIBIO_SENSOR_ACTIVATE_FN VsmSensorActivate;
    PIBIO_SENSOR_DEACTIVATE_FN VsmSensorDeactivate;
    PIBIO_SENSOR_ASYNC_IMPORT_RAW_BUFFER_FN VsmSensorAsyncImportRawBuffer;
    PIBIO_SENSOR_ASYNC_IMPORT_SECURE_BUFFER_FN VsmSensorAsyncImportSecureBuffer;
    PIBIO_FRAMEWORK_VSM_STORAGE_RESERVED_1_FN Reserved1;
    PIBIO_FRAMEWORK_VSM_STORAGE_RESERVED_2_FN Reserved2;
    PIBIO_FRAMEWORK_VSM_STORAGE_RESERVED_3_FN Reserved3;
    PIBIO_STORAGE_RESERVED_1_FN Reserved4;
    PIBIO_STORAGE_RESERVED_2_FN Reserved5;
    PIBIO_FRAMEWORK_ALLOCATE_MEMORY_FN AllocateMemory;
    PIBIO_FRAMEWORK_FREE_MEMORY_FN FreeMemory;
    PIBIO_FRAMEWORK_GET_PROPERTY_FN GetProperty;
    PIBIO_FRAMEWORK_LOCK_AND_VALIDATE_SECURE_BUFFER_FN LockAndValidateSecureBuffer;
    PIBIO_FRAMEWORK_RELEASE_SECURE_BUFFER_FN ReleaseSecureBuffer;
    PIBIO_FRAMEWORK_VSM_QUERY_AUTHORIZED_ENROLLMENTS_FN QueryAuthorizedEnrollments;
    PIBIO_FRAMEWORK_VSM_DECRYPT_SAMPLE_FN DecryptSample;
}

struct WINBIO_SENSOR_ATTRIBUTES
{
    uint           PayloadSize;
    HRESULT        WinBioHresult;
    WINBIO_VERSION WinBioVersion;
    uint           SensorType;
    uint           SensorSubType;
    uint           Capabilities;
    ushort[256]    ManufacturerName;
    ushort[256]    ModelName;
    ushort[256]    SerialNumber;
    WINBIO_VERSION FirmwareVersion;
    uint           SupportedFormatEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/WINBIO_REGISTERED_FORMAT[1] SupportedFormat;
}

struct WINBIO_DATA
{
    uint Size;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] Data;
}

struct WINBIO_UPDATE_FIRMWARE
{
    uint        PayloadSize;
    WINBIO_DATA FirmwareData;
}

struct WINBIO_CALIBRATION_INFO
{
    uint        PayloadSize;
    HRESULT     WinBioHresult;
    WINBIO_DATA CalibrationData;
}

struct WINBIO_DIAGNOSTICS
{
    uint        PayloadSize;
    HRESULT     WinBioHresult;
    uint        SensorStatus;
    WINBIO_DATA VendorDiagnostics;
}

struct WINBIO_BLANK_PAYLOAD
{
    uint    PayloadSize;
    HRESULT WinBioHresult;
}

struct WINBIO_CAPTURE_PARAMETERS
{
    uint  PayloadSize;
    ubyte Purpose;
    WINBIO_REGISTERED_FORMAT Format;
    GUID  VendorFormat;
    ubyte Flags;
}

struct WINBIO_CAPTURE_DATA
{
    uint        PayloadSize;
    HRESULT     WinBioHresult;
    uint        SensorStatus;
    uint        RejectDetail;
    WINBIO_DATA CaptureData;
}

struct WINBIO_SUPPORTED_ALGORITHMS
{
    uint        PayloadSize;
    HRESULT     WinBioHresult;
    uint        NumberOfAlgorithms;
    WINBIO_DATA AlgorithmData;
}

struct WINBIO_GET_INDICATOR
{
    uint    PayloadSize;
    HRESULT WinBioHresult;
    uint    IndicatorStatus;
}

struct WINBIO_SET_INDICATOR
{
    uint PayloadSize;
    uint IndicatorStatus;
}

struct WINBIO_PRIVATE_SENSOR_TYPE_INFO
{
    uint        PayloadSize;
    HRESULT     WinBioHresult;
    WINBIO_DATA PrivateSensorTypeInfo;
}

struct WINBIO_ENCRYPTED_CAPTURE_PARAMS
{
    uint  PayloadSize;
    ubyte Purpose;
    WINBIO_REGISTERED_FORMAT Format;
    GUID  VendorFormat;
    ubyte Flags;
    uint  NonceSize;
}

struct WINBIO_NOTIFY_WAKE
{
    uint    PayloadSize;
    HRESULT WinBioHresult;
    uint    Reason;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioEnumServiceProviders(uint Factor, WINBIO_BSP_SCHEMA** BspSchemaArray, size_t* BspCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioEnumBiometricUnits(uint Factor, WINBIO_UNIT_SCHEMA** UnitSchemaArray, size_t* UnitCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioEnumDatabases(uint Factor, WINBIO_STORAGE_SCHEMA** StorageSchemaArray, size_t* StorageCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("winbio.dll")
HRESULT WinBioAsyncOpenFramework(WINBIO_ASYNC_NOTIFICATION_METHOD NotificationMethod, HWND TargetWindow, 
                                 uint MessageCode, PWINBIO_ASYNC_COMPLETION_CALLBACK CallbackRoutine, void* UserData, 
                                 BOOL AsynchronousOpen, uint* FrameworkHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("winbio.dll")
HRESULT WinBioCloseFramework(uint FrameworkHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("winbio.dll")
HRESULT WinBioAsyncEnumServiceProviders(uint FrameworkHandle, uint Factor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("winbio.dll")
HRESULT WinBioAsyncEnumBiometricUnits(uint FrameworkHandle, uint Factor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("winbio.dll")
HRESULT WinBioAsyncEnumDatabases(uint FrameworkHandle, uint Factor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("winbio.dll")
HRESULT WinBioAsyncMonitorFrameworkChanges(uint FrameworkHandle, uint ChangeTypes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioOpenSession(uint Factor, WINBIO_POOL PoolType, uint Flags, uint* UnitArray, size_t UnitCount, 
                          GUID* DatabaseId, uint* SessionHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("winbio.dll")
HRESULT WinBioAsyncOpenSession(uint Factor, WINBIO_POOL PoolType, uint Flags, uint* UnitArray, size_t UnitCount, 
                               GUID* DatabaseId, WINBIO_ASYNC_NOTIFICATION_METHOD NotificationMethod, 
                               HWND TargetWindow, uint MessageCode, 
                               PWINBIO_ASYNC_COMPLETION_CALLBACK CallbackRoutine, void* UserData, 
                               BOOL AsynchronousOpen, uint* SessionHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioCloseSession(uint SessionHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioVerify(uint SessionHandle, WINBIO_IDENTITY* Identity, ubyte SubFactor, uint* UnitId, ubyte* Match, 
                     uint* RejectDetail);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioVerifyWithCallback(uint SessionHandle, WINBIO_IDENTITY* Identity, ubyte SubFactor, 
                                 PWINBIO_VERIFY_CALLBACK VerifyCallback, void* VerifyCallbackContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioIdentify(uint SessionHandle, uint* UnitId, WINBIO_IDENTITY* Identity, ubyte* SubFactor, 
                       uint* RejectDetail);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioIdentifyWithCallback(uint SessionHandle, PWINBIO_IDENTIFY_CALLBACK IdentifyCallback, 
                                   void* IdentifyCallbackContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioWait(uint SessionHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioCancel(uint SessionHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioLocateSensor(uint SessionHandle, uint* UnitId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioLocateSensorWithCallback(uint SessionHandle, PWINBIO_LOCATE_SENSOR_CALLBACK LocateCallback, 
                                       void* LocateCallbackContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioEnrollBegin(uint SessionHandle, ubyte SubFactor, uint UnitId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("winbio.dll")
HRESULT WinBioEnrollSelect(uint SessionHandle, ulong SelectorValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioEnrollCapture(uint SessionHandle, uint* RejectDetail);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioEnrollCaptureWithCallback(uint SessionHandle, PWINBIO_ENROLL_CAPTURE_CALLBACK EnrollCallback, 
                                        void* EnrollCallbackContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioEnrollCommit(uint SessionHandle, WINBIO_IDENTITY* Identity, ubyte* IsNewTemplate);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioEnrollDiscard(uint SessionHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioEnumEnrollments(uint SessionHandle, uint UnitId, WINBIO_IDENTITY* Identity, ubyte** SubFactorArray, 
                              size_t* SubFactorCount);

@DllImport("winbio.dll")
HRESULT WinBioImproveBegin(uint SessionHandle, uint UnitId);

@DllImport("winbio.dll")
HRESULT WinBioImproveEnd(uint SessionHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioRegisterEventMonitor(uint SessionHandle, uint EventMask, PWINBIO_EVENT_CALLBACK EventCallback, 
                                   void* EventCallbackContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioUnregisterEventMonitor(uint SessionHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("winbio.dll")
HRESULT WinBioMonitorPresence(uint SessionHandle, uint UnitId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioCaptureSample(uint SessionHandle, ubyte Purpose, ubyte Flags, uint* UnitId, WINBIO_BIR** Sample, 
                            size_t* SampleSize, uint* RejectDetail);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioCaptureSampleWithCallback(uint SessionHandle, ubyte Purpose, ubyte Flags, 
                                        PWINBIO_CAPTURE_CALLBACK CaptureCallback, void* CaptureCallbackContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioDeleteTemplate(uint SessionHandle, uint UnitId, WINBIO_IDENTITY* Identity, ubyte SubFactor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioLockUnit(uint SessionHandle, uint UnitId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioUnlockUnit(uint SessionHandle, uint UnitId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioControlUnit(uint SessionHandle, uint UnitId, WINBIO_COMPONENT Component, uint ControlCode, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* SendBuffer, 
                          size_t SendBufferSize, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/ubyte* ReceiveBuffer, 
                          size_t ReceiveBufferSize, size_t* ReceiveDataSize, uint* OperationStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioControlUnitPrivileged(uint SessionHandle, uint UnitId, WINBIO_COMPONENT Component, uint ControlCode, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* SendBuffer, 
                                    size_t SendBufferSize, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/ubyte* ReceiveBuffer, 
                                    size_t ReceiveBufferSize, size_t* ReceiveDataSize, uint* OperationStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioGetProperty(uint SessionHandle, uint PropertyType, uint PropertyId, uint UnitId, 
                          WINBIO_IDENTITY* Identity, ubyte SubFactor, void** PropertyBuffer, 
                          size_t* PropertyBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("winbio.dll")
HRESULT WinBioSetProperty(uint SessionHandle, uint PropertyType, uint PropertyId, uint UnitId, 
                          WINBIO_IDENTITY* Identity, ubyte SubFactor, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/void* PropertyBuffer, 
                          size_t PropertyBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioFree(void* Address);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioSetCredential(WINBIO_CREDENTIAL_TYPE Type, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* Credential, 
                            size_t CredentialSize, WINBIO_CREDENTIAL_FORMAT Format);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioRemoveCredential(WINBIO_IDENTITY Identity, WINBIO_CREDENTIAL_TYPE Type);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioRemoveAllCredentials();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioRemoveAllDomainCredentials();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioGetCredentialState(WINBIO_IDENTITY Identity, WINBIO_CREDENTIAL_TYPE Type, 
                                 WINBIO_CREDENTIAL_STATE* CredentialState);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioLogonIdentifiedUser(uint SessionHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("winbio.dll")
HRESULT WinBioGetEnrolledFactors(WINBIO_IDENTITY* AccountOwner, uint* EnrolledFactors);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
void WinBioGetEnabledSetting(ubyte* Value, WINBIO_SETTING_SOURCE* Source);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
void WinBioGetLogonSetting(ubyte* Value, WINBIO_SETTING_SOURCE* Source);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
void WinBioGetDomainLogonSetting(ubyte* Value, WINBIO_SETTING_SOURCE* Source);

@DllImport("winbio.dll")
HRESULT WinBioIsESSCapable(ubyte* Value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioAcquireFocus();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("winbio.dll")
HRESULT WinBioReleaseFocus();


