// Written in the D programming language.

module windows.win32.devices.devicequery;

public import windows.core;
public import windows.win32.devices.properties : DEVPROPCOMPKEY, DEVPROPERTY, DEVPROPSTORE,
                                                 DEVPROPTYPE;
public import windows.win32.foundation.foundation : DEVPROPKEY, HRESULT, PWSTR;

extern(Windows) @nogc nothrow:


// Enums


alias DEVPROP_OPERATOR = uint;
enum : uint
{
    DEVPROP_OPERATOR_MODIFIER_NOT                         = 0x00010000U,
    DEVPROP_OPERATOR_MODIFIER_IGNORE_CASE                 = 0x00020000U,
    DEVPROP_OPERATOR_NONE                                 = 0x00000000U,
    DEVPROP_OPERATOR_EXISTS                               = 0x00000001U,
    DEVPROP_OPERATOR_NOT_EXISTS                           = 0x00010001U,
    DEVPROP_OPERATOR_EQUALS                               = 0x00000002U,
    DEVPROP_OPERATOR_NOT_EQUALS                           = 0x00010002U,
    DEVPROP_OPERATOR_GREATER_THAN                         = 0x00000003U,
    DEVPROP_OPERATOR_LESS_THAN                            = 0x00000004U,
    DEVPROP_OPERATOR_GREATER_THAN_EQUALS                  = 0x00000005U,
    DEVPROP_OPERATOR_LESS_THAN_EQUALS                     = 0x00000006U,
    DEVPROP_OPERATOR_EQUALS_IGNORE_CASE                   = 0x00020002U,
    DEVPROP_OPERATOR_NOT_EQUALS_IGNORE_CASE               = 0x00030002U,
    DEVPROP_OPERATOR_BITWISE_AND                          = 0x00000007U,
    DEVPROP_OPERATOR_BITWISE_OR                           = 0x00000008U,
    DEVPROP_OPERATOR_BEGINS_WITH                          = 0x00000009U,
    DEVPROP_OPERATOR_ENDS_WITH                            = 0x0000000aU,
    DEVPROP_OPERATOR_CONTAINS                             = 0x0000000bU,
    DEVPROP_OPERATOR_BEGINS_WITH_IGNORE_CASE              = 0x00020009U,
    DEVPROP_OPERATOR_ENDS_WITH_IGNORE_CASE                = 0x0002000aU,
    DEVPROP_OPERATOR_CONTAINS_IGNORE_CASE                 = 0x0002000bU,
    DEVPROP_OPERATOR_LIST_CONTAINS                        = 0x00001000U,
    DEVPROP_OPERATOR_LIST_ELEMENT_BEGINS_WITH             = 0x00002000U,
    DEVPROP_OPERATOR_LIST_ELEMENT_ENDS_WITH               = 0x00003000U,
    DEVPROP_OPERATOR_LIST_ELEMENT_CONTAINS                = 0x00004000U,
    DEVPROP_OPERATOR_LIST_CONTAINS_IGNORE_CASE            = 0x00021000U,
    DEVPROP_OPERATOR_LIST_ELEMENT_BEGINS_WITH_IGNORE_CASE = 0x00022000U,
    DEVPROP_OPERATOR_LIST_ELEMENT_ENDS_WITH_IGNORE_CASE   = 0x00023000U,
    DEVPROP_OPERATOR_LIST_ELEMENT_CONTAINS_IGNORE_CASE    = 0x00024000U,
    DEVPROP_OPERATOR_AND_OPEN                             = 0x00100000U,
    DEVPROP_OPERATOR_AND_CLOSE                            = 0x00200000U,
    DEVPROP_OPERATOR_OR_OPEN                              = 0x00300000U,
    DEVPROP_OPERATOR_OR_CLOSE                             = 0x00400000U,
    DEVPROP_OPERATOR_NOT_OPEN                             = 0x00500000U,
    DEVPROP_OPERATOR_NOT_CLOSE                            = 0x00600000U,
    DEVPROP_OPERATOR_ARRAY_CONTAINS                       = 0x10000000U,
    DEVPROP_OPERATOR_MASK_EVAL                            = 0x00000fffU,
    DEVPROP_OPERATOR_MASK_LIST                            = 0x0000f000U,
    DEVPROP_OPERATOR_MASK_MODIFIER                        = 0x000f0000U,
    DEVPROP_OPERATOR_MASK_NOT_LOGICAL                     = 0xf00fffffU,
    DEVPROP_OPERATOR_MASK_LOGICAL                         = 0x0ff00000U,
    DEVPROP_OPERATOR_MASK_ARRAY                           = 0xf0000000U,
}

alias DEV_OBJECT_TYPE = int;
enum : int
{
    DevObjectTypeUnknown                = 0x00000000,
    DevObjectTypeDeviceInterface        = 0x00000001,
    DevObjectTypeDeviceContainer        = 0x00000002,
    DevObjectTypeDevice                 = 0x00000003,
    DevObjectTypeDeviceInterfaceClass   = 0x00000004,
    DevObjectTypeAEP                    = 0x00000005,
    DevObjectTypeAEPContainer           = 0x00000006,
    DevObjectTypeDeviceInstallerClass   = 0x00000007,
    DevObjectTypeDeviceInterfaceDisplay = 0x00000008,
    DevObjectTypeDeviceContainerDisplay = 0x00000009,
    DevObjectTypeAEPService             = 0x0000000a,
    DevObjectTypeDevicePanel            = 0x0000000b,
    DevObjectTypeAEPProtocol            = 0x0000000c,
}

alias DEV_QUERY_FLAGS = int;
enum : int
{
    DevQueryFlagNone          = 0x00000000,
    DevQueryFlagUpdateResults = 0x00000001,
    DevQueryFlagAllProperties = 0x00000002,
    DevQueryFlagLocalize      = 0x00000004,
    DevQueryFlagAsyncClose    = 0x00000008,
}

alias DEV_QUERY_STATE = int;
enum : int
{
    DevQueryStateInitialized   = 0x00000000,
    DevQueryStateEnumCompleted = 0x00000001,
    DevQueryStateAborted       = 0x00000002,
    DevQueryStateClosed        = 0x00000003,
}

alias DEV_QUERY_RESULT_ACTION = int;
enum : int
{
    DevQueryResultStateChange = 0x00000000,
    DevQueryResultAdd         = 0x00000001,
    DevQueryResultUpdate      = 0x00000002,
    DevQueryResultRemove      = 0x00000003,
}

// Callbacks

alias PDEV_QUERY_RESULT_CALLBACK = void function(HDEVQUERY hDevQuery, void* pContext, 
                                                 const(DEV_QUERY_RESULT_ACTION_DATA)* pActionData);

// Structs


struct HDEVQUERY
{
    void* Value;
}

struct DEVPROP_FILTER_EXPRESSION
{
    DEVPROP_OPERATOR Operator;
    DEVPROPERTY      Property;
}

struct DEV_OBJECT
{
    DEV_OBJECT_TYPE     ObjectType;
    const(PWSTR)        pszObjectId;
    uint                cPropertyCount;
    const(DEVPROPERTY)* pProperties;
}

struct DEV_QUERY_RESULT_ACTION_DATA
{
    DEV_QUERY_RESULT_ACTION Action;
    union Data
    {
        DEV_QUERY_STATE State;
        DEV_OBJECT      DeviceObject;
    }
}

struct DEV_QUERY_PARAMETER
{
    DEVPROPKEY  Key;
    DEVPROPTYPE Type;
    uint        BufferSize;
    void*       Buffer;
}

// Functions

@DllImport("api-ms-win-devices-query-l1-1-0.dll")
HRESULT DevCreateObjectQuery(DEV_OBJECT_TYPE ObjectType, uint QueryFlags, uint cRequestedProperties, 
                             const(DEVPROPCOMPKEY)* pRequestedProperties, uint cFilterExpressionCount, 
                             const(DEVPROP_FILTER_EXPRESSION)* pFilter, PDEV_QUERY_RESULT_CALLBACK pCallback, 
                             void* pContext, HDEVQUERY* phDevQuery);

@DllImport("api-ms-win-devices-query-l1-1-1.dll")
HRESULT DevCreateObjectQueryEx(DEV_OBJECT_TYPE ObjectType, uint QueryFlags, uint cRequestedProperties, 
                               const(DEVPROPCOMPKEY)* pRequestedProperties, uint cFilterExpressionCount, 
                               const(DEVPROP_FILTER_EXPRESSION)* pFilter, uint cExtendedParameterCount, 
                               const(DEV_QUERY_PARAMETER)* pExtendedParameters, PDEV_QUERY_RESULT_CALLBACK pCallback, 
                               void* pContext, HDEVQUERY* phDevQuery);

@DllImport("api-ms-win-devices-query-l1-1-0.dll")
HRESULT DevCreateObjectQueryFromId(DEV_OBJECT_TYPE ObjectType, const(PWSTR) pszObjectId, uint QueryFlags, 
                                   uint cRequestedProperties, const(DEVPROPCOMPKEY)* pRequestedProperties, 
                                   uint cFilterExpressionCount, const(DEVPROP_FILTER_EXPRESSION)* pFilter, 
                                   PDEV_QUERY_RESULT_CALLBACK pCallback, void* pContext, HDEVQUERY* phDevQuery);

@DllImport("api-ms-win-devices-query-l1-1-1.dll")
HRESULT DevCreateObjectQueryFromIdEx(DEV_OBJECT_TYPE ObjectType, const(PWSTR) pszObjectId, uint QueryFlags, 
                                     uint cRequestedProperties, const(DEVPROPCOMPKEY)* pRequestedProperties, 
                                     uint cFilterExpressionCount, const(DEVPROP_FILTER_EXPRESSION)* pFilter, 
                                     uint cExtendedParameterCount, const(DEV_QUERY_PARAMETER)* pExtendedParameters, 
                                     PDEV_QUERY_RESULT_CALLBACK pCallback, void* pContext, HDEVQUERY* phDevQuery);

@DllImport("api-ms-win-devices-query-l1-1-0.dll")
HRESULT DevCreateObjectQueryFromIds(DEV_OBJECT_TYPE ObjectType, 
                                    /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/const(PWSTR) pszzObjectIds, 
                                    uint QueryFlags, uint cRequestedProperties, 
                                    const(DEVPROPCOMPKEY)* pRequestedProperties, uint cFilterExpressionCount, 
                                    const(DEVPROP_FILTER_EXPRESSION)* pFilter, PDEV_QUERY_RESULT_CALLBACK pCallback, 
                                    void* pContext, HDEVQUERY* phDevQuery);

@DllImport("api-ms-win-devices-query-l1-1-1.dll")
HRESULT DevCreateObjectQueryFromIdsEx(DEV_OBJECT_TYPE ObjectType, 
                                      /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/const(PWSTR) pszzObjectIds, 
                                      uint QueryFlags, uint cRequestedProperties, 
                                      const(DEVPROPCOMPKEY)* pRequestedProperties, uint cFilterExpressionCount, 
                                      const(DEVPROP_FILTER_EXPRESSION)* pFilter, uint cExtendedParameterCount, 
                                      const(DEV_QUERY_PARAMETER)* pExtendedParameters, 
                                      PDEV_QUERY_RESULT_CALLBACK pCallback, void* pContext, HDEVQUERY* phDevQuery);

@DllImport("api-ms-win-devices-query-l1-1-0.dll")
void DevCloseObjectQuery(HDEVQUERY hDevQuery);

@DllImport("api-ms-win-devices-query-l1-1-0.dll")
HRESULT DevGetObjects(DEV_OBJECT_TYPE ObjectType, uint QueryFlags, uint cRequestedProperties, 
                      const(DEVPROPCOMPKEY)* pRequestedProperties, uint cFilterExpressionCount, 
                      const(DEVPROP_FILTER_EXPRESSION)* pFilter, uint* pcObjectCount, const(DEV_OBJECT)** ppObjects);

@DllImport("api-ms-win-devices-query-l1-1-1.dll")
HRESULT DevGetObjectsEx(DEV_OBJECT_TYPE ObjectType, uint QueryFlags, uint cRequestedProperties, 
                        const(DEVPROPCOMPKEY)* pRequestedProperties, uint cFilterExpressionCount, 
                        const(DEVPROP_FILTER_EXPRESSION)* pFilter, uint cExtendedParameterCount, 
                        const(DEV_QUERY_PARAMETER)* pExtendedParameters, uint* pcObjectCount, 
                        const(DEV_OBJECT)** ppObjects);

@DllImport("api-ms-win-devices-query-l1-1-0.dll")
void DevFreeObjects(uint cObjectCount, const(DEV_OBJECT)* pObjects);

@DllImport("api-ms-win-devices-query-l1-1-0.dll")
HRESULT DevGetObjectProperties(DEV_OBJECT_TYPE ObjectType, const(PWSTR) pszObjectId, uint QueryFlags, 
                               uint cRequestedProperties, const(DEVPROPCOMPKEY)* pRequestedProperties, 
                               uint* pcPropertyCount, const(DEVPROPERTY)** ppProperties);

@DllImport("api-ms-win-devices-query-l1-1-1.dll")
HRESULT DevGetObjectPropertiesEx(DEV_OBJECT_TYPE ObjectType, const(PWSTR) pszObjectId, uint QueryFlags, 
                                 uint cRequestedProperties, const(DEVPROPCOMPKEY)* pRequestedProperties, 
                                 uint cExtendedParameterCount, const(DEV_QUERY_PARAMETER)* pExtendedParameters, 
                                 uint* pcPropertyCount, const(DEVPROPERTY)** ppProperties);

@DllImport("api-ms-win-devices-query-l1-1-0.dll")
void DevFreeObjectProperties(uint cPropertyCount, const(DEVPROPERTY)* pProperties);

@DllImport("api-ms-win-devices-query-l1-1-0.dll")
DEVPROPERTY* DevFindProperty(const(DEVPROPKEY)* pKey, DEVPROPSTORE Store, const(PWSTR) pszLocaleName, 
                             uint cProperties, const(DEVPROPERTY)* pProperties);


