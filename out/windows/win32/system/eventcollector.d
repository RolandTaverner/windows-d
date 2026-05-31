// Written in the D programming language.

module windows.win32.system.eventcollector;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, PWSTR;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/evcoll/ne-evcoll-ec_subscription_property_id
alias EC_SUBSCRIPTION_PROPERTY_ID = int;
enum : int
{
    EcSubscriptionEnabled                      = 0x00000000,
    EcSubscriptionEventSources                 = 0x00000001,
    EcSubscriptionEventSourceAddress           = 0x00000002,
    EcSubscriptionEventSourceEnabled           = 0x00000003,
    EcSubscriptionEventSourceUserName          = 0x00000004,
    EcSubscriptionEventSourcePassword          = 0x00000005,
    EcSubscriptionDescription                  = 0x00000006,
    EcSubscriptionURI                          = 0x00000007,
    EcSubscriptionConfigurationMode            = 0x00000008,
    EcSubscriptionExpires                      = 0x00000009,
    EcSubscriptionQuery                        = 0x0000000a,
    EcSubscriptionTransportName                = 0x0000000b,
    EcSubscriptionTransportPort                = 0x0000000c,
    EcSubscriptionDeliveryMode                 = 0x0000000d,
    EcSubscriptionDeliveryMaxItems             = 0x0000000e,
    EcSubscriptionDeliveryMaxLatencyTime       = 0x0000000f,
    EcSubscriptionHeartbeatInterval            = 0x00000010,
    EcSubscriptionLocale                       = 0x00000011,
    EcSubscriptionContentFormat                = 0x00000012,
    EcSubscriptionLogFile                      = 0x00000013,
    EcSubscriptionPublisherName                = 0x00000014,
    EcSubscriptionCredentialsType              = 0x00000015,
    EcSubscriptionCommonUserName               = 0x00000016,
    EcSubscriptionCommonPassword               = 0x00000017,
    EcSubscriptionHostName                     = 0x00000018,
    EcSubscriptionReadExistingEvents           = 0x00000019,
    EcSubscriptionDialect                      = 0x0000001a,
    EcSubscriptionType                         = 0x0000001b,
    EcSubscriptionAllowedIssuerCAs             = 0x0000001c,
    EcSubscriptionAllowedSubjects              = 0x0000001d,
    EcSubscriptionDeniedSubjects               = 0x0000001e,
    EcSubscriptionAllowedSourceDomainComputers = 0x0000001f,
    EcSubscriptionPropertyIdEND                = 0x00000020,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/evcoll/ne-evcoll-ec_subscription_credentials_type
alias EC_SUBSCRIPTION_CREDENTIALS_TYPE = int;
enum : int
{
    EcSubscriptionCredDefault      = 0x00000000,
    EcSubscriptionCredNegotiate    = 0x00000001,
    EcSubscriptionCredDigest       = 0x00000002,
    EcSubscriptionCredBasic        = 0x00000003,
    EcSubscriptionCredLocalMachine = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/evcoll/ne-evcoll-ec_subscription_type
alias EC_SUBSCRIPTION_TYPE = int;
enum : int
{
    EcSubscriptionTypeSourceInitiated    = 0x00000000,
    EcSubscriptionTypeCollectorInitiated = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/evcoll/ne-evcoll-ec_subscription_runtime_status_info_id
alias EC_SUBSCRIPTION_RUNTIME_STATUS_INFO_ID = int;
enum : int
{
    EcSubscriptionRunTimeStatusActive            = 0x00000000,
    EcSubscriptionRunTimeStatusLastError         = 0x00000001,
    EcSubscriptionRunTimeStatusLastErrorMessage  = 0x00000002,
    EcSubscriptionRunTimeStatusLastErrorTime     = 0x00000003,
    EcSubscriptionRunTimeStatusNextRetryTime     = 0x00000004,
    EcSubscriptionRunTimeStatusEventSources      = 0x00000005,
    EcSubscriptionRunTimeStatusLastHeartbeatTime = 0x00000006,
    EcSubscriptionRunTimeStatusInfoIdEND         = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/evcoll/ne-evcoll-ec_variant_type
alias EC_VARIANT_TYPE = int;
enum : int
{
    EcVarTypeNull                  = 0x00000000,
    EcVarTypeBoolean               = 0x00000001,
    EcVarTypeUInt32                = 0x00000002,
    EcVarTypeDateTime              = 0x00000003,
    EcVarTypeString                = 0x00000004,
    EcVarObjectArrayPropertyHandle = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/evcoll/ne-evcoll-ec_subscription_configuration_mode
alias EC_SUBSCRIPTION_CONFIGURATION_MODE = int;
enum : int
{
    EcConfigurationModeNormal       = 0x00000000,
    EcConfigurationModeCustom       = 0x00000001,
    EcConfigurationModeMinLatency   = 0x00000002,
    EcConfigurationModeMinBandwidth = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/evcoll/ne-evcoll-ec_subscription_delivery_mode
alias EC_SUBSCRIPTION_DELIVERY_MODE = int;
enum : int
{
    EcDeliveryModePull = 0x00000001,
    EcDeliveryModePush = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/evcoll/ne-evcoll-ec_subscription_content_format
alias EC_SUBSCRIPTION_CONTENT_FORMAT = int;
enum : int
{
    EcContentFormatEvents       = 0x00000001,
    EcContentFormatRenderedText = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/evcoll/ne-evcoll-ec_subscription_runtime_status_active_status
alias EC_SUBSCRIPTION_RUNTIME_STATUS_ACTIVE_STATUS = int;
enum : int
{
    EcRuntimeStatusActiveStatusDisabled = 0x00000001,
    EcRuntimeStatusActiveStatusActive   = 0x00000002,
    EcRuntimeStatusActiveStatusInactive = 0x00000003,
    EcRuntimeStatusActiveStatusTrying   = 0x00000004,
}

// Constants


enum : uint
{
    EC_VARIANT_TYPE_MASK  = 0x0000007fU,
    EC_VARIANT_TYPE_ARRAY = 0x00000080U,
}

enum uint EC_READ_ACCESS = 0x00000001U;
enum uint EC_WRITE_ACCESS = 0x00000002U;
enum uint EC_OPEN_ALWAYS = 0x00000000U;
enum uint EC_CREATE_NEW = 0x00000001U;
enum uint EC_OPEN_EXISTING = 0x00000002U;

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/evcoll/ns-evcoll-ec_variant
struct EC_VARIANT
{
    union
    {
        BOOL         BooleanVal;
        uint         UInt32Val;
        ulong        DateTimeVal;
        const(PWSTR) StringVal;
        ubyte*       BinaryVal;
        BOOL*        BooleanArr;
        int*         Int32Arr;
        PWSTR*       StringArr;
        ptrdiff_t    PropertyHandleVal;
    }
    uint Count;
    uint Type;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WecApi.dll")
ptrdiff_t EcOpenSubscriptionEnum(uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WecApi.dll")
BOOL EcEnumNextSubscription(ptrdiff_t SubscriptionEnum, uint SubscriptionNameBufferSize, 
                            PWSTR SubscriptionNameBuffer, uint* SubscriptionNameBufferUsed);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WecApi.dll")
ptrdiff_t EcOpenSubscription(const(PWSTR) SubscriptionName, uint AccessMask, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WecApi.dll")
BOOL EcSetSubscriptionProperty(ptrdiff_t Subscription, EC_SUBSCRIPTION_PROPERTY_ID PropertyId, uint Flags, 
                               EC_VARIANT* PropertyValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WecApi.dll")
BOOL EcGetSubscriptionProperty(ptrdiff_t Subscription, EC_SUBSCRIPTION_PROPERTY_ID PropertyId, uint Flags, 
                               uint PropertyValueBufferSize, EC_VARIANT* PropertyValueBuffer, 
                               uint* PropertyValueBufferUsed);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WecApi.dll")
BOOL EcSaveSubscription(ptrdiff_t Subscription, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WecApi.dll")
BOOL EcDeleteSubscription(const(PWSTR) SubscriptionName, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WecApi.dll")
BOOL EcGetObjectArraySize(ptrdiff_t ObjectArray, uint* ObjectArraySize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WecApi.dll")
BOOL EcSetObjectArrayProperty(ptrdiff_t ObjectArray, EC_SUBSCRIPTION_PROPERTY_ID PropertyId, uint ArrayIndex, 
                              uint Flags, EC_VARIANT* PropertyValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WecApi.dll")
BOOL EcGetObjectArrayProperty(ptrdiff_t ObjectArray, EC_SUBSCRIPTION_PROPERTY_ID PropertyId, uint ArrayIndex, 
                              uint Flags, uint PropertyValueBufferSize, EC_VARIANT* PropertyValueBuffer, 
                              uint* PropertyValueBufferUsed);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WecApi.dll")
BOOL EcInsertObjectArrayElement(ptrdiff_t ObjectArray, uint ArrayIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WecApi.dll")
BOOL EcRemoveObjectArrayElement(ptrdiff_t ObjectArray, uint ArrayIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WecApi.dll")
BOOL EcGetSubscriptionRunTimeStatus(const(PWSTR) SubscriptionName, 
                                    EC_SUBSCRIPTION_RUNTIME_STATUS_INFO_ID StatusInfoId, 
                                    const(PWSTR) EventSourceName, uint Flags, uint StatusValueBufferSize, 
                                    EC_VARIANT* StatusValueBuffer, uint* StatusValueBufferUsed);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WecApi.dll")
BOOL EcRetrySubscription(const(PWSTR) SubscriptionName, const(PWSTR) EventSourceName, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WecApi.dll")
BOOL EcClose(ptrdiff_t Object);


