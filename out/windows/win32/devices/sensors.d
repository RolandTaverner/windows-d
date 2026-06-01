// Written in the D programming language.

module windows.win32.devices.sensors;

public import windows.core;
public import windows.win32.devices.portabledevices : IPortableDeviceKeyCollection, IPortableDeviceValues;
public import windows.win32.devices.properties : DEVPROPTYPE;
public import windows.win32.foundation.foundation : BOOL, BOOLEAN, BSTR, FILETIME, HRESULT,
                                                    HWND, NTSTATUS, PROPERTYKEY,
                                                    SYSTEMTIME, VARIANT_BOOL;
public import windows.win32.system.com.com : IUnknown;
public import windows.win32.system.com.structuredstorage : PROPVARIANT;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/ne-sensorsapi-sensorstate
enum SensorState : int
{
    SENSOR_STATE_MIN           = 0x00000000,
    SENSOR_STATE_READY         = 0x00000000,
    SENSOR_STATE_NOT_AVAILABLE = 0x00000001,
    SENSOR_STATE_NO_DATA       = 0x00000002,
    SENSOR_STATE_INITIALIZING  = 0x00000003,
    SENSOR_STATE_ACCESS_DENIED = 0x00000004,
    SENSOR_STATE_ERROR         = 0x00000005,
    SENSOR_STATE_MAX           = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/ne-sensorsapi-sensorconnectiontype
enum SensorConnectionType : int
{
    SENSOR_CONNECTION_TYPE_PC_INTEGRATED = 0x00000000,
    SENSOR_CONNECTION_TYPE_PC_ATTACHED   = 0x00000001,
    SENSOR_CONNECTION_TYPE_PC_EXTERNAL   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/ne-sensorsapi-location_desired_accuracy
alias LOCATION_DESIRED_ACCURACY = int;
enum : int
{
    LOCATION_DESIRED_ACCURACY_DEFAULT = 0x00000000,
    LOCATION_DESIRED_ACCURACY_HIGH    = 0x00000001,
}

alias LOCATION_POSITION_SOURCE = int;
enum : int
{
    LOCATION_POSITION_SOURCE_CELLULAR  = 0x00000000,
    LOCATION_POSITION_SOURCE_SATELLITE = 0x00000001,
    LOCATION_POSITION_SOURCE_WIFI      = 0x00000002,
    LOCATION_POSITION_SOURCE_IPADDRESS = 0x00000003,
    LOCATION_POSITION_SOURCE_UNKNOWN   = 0x00000004,
}

enum SimpleDeviceOrientation : int
{
    SIMPLE_DEVICE_ORIENTATION_NOT_ROTATED       = 0x00000000,
    SIMPLE_DEVICE_ORIENTATION_ROTATED_90        = 0x00000001,
    SIMPLE_DEVICE_ORIENTATION_ROTATED_180       = 0x00000002,
    SIMPLE_DEVICE_ORIENTATION_ROTATED_270       = 0x00000003,
    SIMPLE_DEVICE_ORIENTATION_ROTATED_FACE_UP   = 0x00000004,
    SIMPLE_DEVICE_ORIENTATION_ROTATED_FACE_DOWN = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/ne-sensorsapi-magnetometeraccuracy
enum MagnetometerAccuracy : int
{
    MAGNETOMETER_ACCURACY_UNKNOWN     = 0x00000000,
    MAGNETOMETER_ACCURACY_UNRELIABLE  = 0x00000001,
    MAGNETOMETER_ACCURACY_APPROXIMATE = 0x00000002,
    MAGNETOMETER_ACCURACY_HIGH        = 0x00000003,
}

alias ACTIVITY_STATE_COUNT = int;
enum : int
{
    ActivityStateCount = 0x00000008,
}

alias ACTIVITY_STATE = int;
enum : int
{
    ActivityState_Unknown     = 0x00000001,
    ActivityState_Stationary  = 0x00000002,
    ActivityState_Fidgeting   = 0x00000004,
    ActivityState_Walking     = 0x00000008,
    ActivityState_Running     = 0x00000010,
    ActivityState_InVehicle   = 0x00000020,
    ActivityState_Biking      = 0x00000040,
    ActivityState_Idle        = 0x00000080,
    ActivityState_Max         = 0x00000100,
    ActivityState_Force_Dword = 0xffffffff,
}

alias ELEVATION_CHANGE_MODE = int;
enum : int
{
    ElevationChangeMode_Unknown     = 0x00000000,
    ElevationChangeMode_Elevator    = 0x00000001,
    ElevationChangeMode_Stepping    = 0x00000002,
    ElevationChangeMode_Max         = 0x00000003,
    ElevationChangeMode_Force_Dword = 0xffffffff,
}

alias MAGNETOMETER_ACCURACY = int;
enum : int
{
    MagnetometerAccuracy_Unknown     = 0x00000000,
    MagnetometerAccuracy_Unreliable  = 0x00000001,
    MagnetometerAccuracy_Approximate = 0x00000002,
    MagnetometerAccuracy_High        = 0x00000003,
}

alias PEDOMETER_STEP_TYPE_COUNT = int;
enum : int
{
    PedometerStepTypeCount = 0x00000003,
}

alias PEDOMETER_STEP_TYPE = int;
enum : int
{
    PedometerStepType_Unknown     = 0x00000001,
    PedometerStepType_Walking     = 0x00000002,
    PedometerStepType_Running     = 0x00000004,
    PedometerStepType_Max         = 0x00000008,
    PedometerStepType_Force_Dword = 0xffffffff,
}

alias PROXIMITY_TYPE = int;
enum : int
{
    ProximityType_ObjectProximity = 0x00000000,
    ProximityType_HumanProximity  = 0x00000001,
    ProximityType_Force_Dword     = 0xffffffff,
}

alias HUMAN_PRESENCE_DETECTION_TYPE_COUNT = int;
enum : int
{
    HumanPresenceDetectionTypeCount = 0x00000004,
}

alias HUMAN_PRESENCE_DETECTION_TYPE = int;
enum : int
{
    HumanPresenceDetectionType_Undefined                 = 0x00000000,
    HumanPresenceDetectionType_VendorDefinedNonBiometric = 0x00000001,
    HumanPresenceDetectionType_VendorDefinedBiometric    = 0x00000002,
    HumanPresenceDetectionType_FacialBiometric           = 0x00000004,
    HumanPresenceDetectionType_AudioBiometric            = 0x00000008,
    HumanPresenceDetectionType_Force_Dword               = 0xffffffff,
}

alias PROXIMITY_SENSOR_CAPABILITIES = int;
enum : int
{
    Proximity_Sensor_Human_Presence_Capable         = 0x00000001,
    Proximity_Sensor_Human_Engagement_Capable       = 0x00000002,
    Proximity_Sensor_Human_Head_Azimuth_Capable     = 0x00000004,
    Proximity_Sensor_Human_Head_Altitude_Capable    = 0x00000008,
    Proximity_Sensor_Human_Head_Roll_Capable        = 0x00000010,
    Proximity_Sensor_Human_Head_Pitch_Capable       = 0x00000020,
    Proximity_Sensor_Human_Head_Yaw_Capable         = 0x00000040,
    Proximity_Sensor_Human_Identification_Capable   = 0x00000080,
    Proximity_Sensor_Multi_Person_Detection_Capable = 0x00000100,
    Proximity_Sensor_Supported_Capabilities         = 0x000001ff,
}

alias SIMPLE_DEVICE_ORIENTATION = int;
enum : int
{
    SimpleDeviceOrientation_NotRotated                        = 0x00000000,
    SimpleDeviceOrientation_Rotated90DegreesCounterclockwise  = 0x00000001,
    SimpleDeviceOrientation_Rotated180DegreesCounterclockwise = 0x00000002,
    SimpleDeviceOrientation_Rotated270DegreesCounterclockwise = 0x00000003,
    SimpleDeviceOrientation_Faceup                            = 0x00000004,
    SimpleDeviceOrientation_Facedown                          = 0x00000005,
}

alias SENSOR_STATE = int;
enum : int
{
    SensorState_Initializing = 0x00000000,
    SensorState_Idle         = 0x00000001,
    SensorState_Active       = 0x00000002,
    SensorState_Error        = 0x00000003,
}

alias SENSOR_CONNECTION_TYPES = int;
enum : int
{
    SensorConnectionType_Integrated = 0x00000000,
    SensorConnectionType_Attached   = 0x00000001,
    SensorConnectionType_External   = 0x00000002,
}

alias AXIS = int;
enum : int
{
    AXIS_X   = 0x00000000,
    AXIS_Y   = 0x00000001,
    AXIS_Z   = 0x00000002,
    AXIS_MAX = 0x00000003,
}

// Constants


enum GUID GUID_DEVINTERFACE_SENSOR = GUID("ba1bb692-9b7a-4833-9a1e-525ed134e7e2");

enum : GUID
{
    SENSOR_EVENT_STATE_CHANGED         = GUID("bfd96016-6bd7-4560-ad34-f2f6607e8f81"),
    SENSOR_EVENT_DATA_UPDATED          = GUID("2ed0f2a4-0087-41d3-87db-6773370b3c88"),
    SENSOR_EVENT_PROPERTY_CHANGED      = GUID("2358f099-84c9-4d3d-90df-c2421e2b2045"),
    SENSOR_EVENT_ACCELEROMETER_SHAKE   = GUID("825f5a94-0f48-4396-9ca0-6ecb5c99d915"),
    SENSOR_EVENT_PARAMETER_COMMON_GUID = GUID("64346e30-8728-4b34-bdf6-4f52442c5c28"),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1681157680, 34600, 19252, 189, 246, 79, 82, 68, 44, 92, 40}, 2))], [])*/PROPERTYKEY
{
    SENSOR_EVENT_PARAMETER_EVENT_ID = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1681157680, 34600, 19252, 189, 246, 79, 82, 68, 44, 92, 40}, 2))], [])*/PROPERTYKEY(GUID("64346E30-8728-4B34-BDF6-4F52442C5C28"), 2),
    SENSOR_EVENT_PARAMETER_STATE    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1681157680, 34600, 19252, 189, 246, 79, 82, 68, 44, 92, 40}, 2))], [])*/PROPERTYKEY(GUID("64346E30-8728-4B34-BDF6-4F52442C5C28"), 3),
}

enum GUID SENSOR_ERROR_PARAMETER_COMMON_GUID = GUID("77112bcd-fce1-4f43-b8b8-a88256adb4b3");
enum GUID SENSOR_PROPERTY_COMMON_GUID = GUID("7f8383ec-d3ec-495c-a8cf-b8bbe85c2920");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2139325420, 54252, 18780, 168, 207, 184, 187, 232, 92, 41, 32}, 2))], [])*/PROPERTYKEY
{
    SENSOR_PROPERTY_TYPE                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2139325420, 54252, 18780, 168, 207, 184, 187, 232, 92, 41, 32}, 2))], [])*/PROPERTYKEY(GUID("7F8383EC-D3EC-495C-A8CF-B8BBE85C2920"), 2),
    SENSOR_PROPERTY_STATE                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2139325420, 54252, 18780, 168, 207, 184, 187, 232, 92, 41, 32}, 2))], [])*/PROPERTYKEY(GUID("7F8383EC-D3EC-495C-A8CF-B8BBE85C2920"), 3),
    SENSOR_PROPERTY_PERSISTENT_UNIQUE_ID      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2139325420, 54252, 18780, 168, 207, 184, 187, 232, 92, 41, 32}, 2))], [])*/PROPERTYKEY(GUID("7F8383EC-D3EC-495C-A8CF-B8BBE85C2920"), 5),
    SENSOR_PROPERTY_MANUFACTURER              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2139325420, 54252, 18780, 168, 207, 184, 187, 232, 92, 41, 32}, 2))], [])*/PROPERTYKEY(GUID("7F8383EC-D3EC-495C-A8CF-B8BBE85C2920"), 6),
    SENSOR_PROPERTY_MODEL                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2139325420, 54252, 18780, 168, 207, 184, 187, 232, 92, 41, 32}, 2))], [])*/PROPERTYKEY(GUID("7F8383EC-D3EC-495C-A8CF-B8BBE85C2920"), 7),
    SENSOR_PROPERTY_SERIAL_NUMBER             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2139325420, 54252, 18780, 168, 207, 184, 187, 232, 92, 41, 32}, 2))], [])*/PROPERTYKEY(GUID("7F8383EC-D3EC-495C-A8CF-B8BBE85C2920"), 8),
    SENSOR_PROPERTY_FRIENDLY_NAME             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2139325420, 54252, 18780, 168, 207, 184, 187, 232, 92, 41, 32}, 2))], [])*/PROPERTYKEY(GUID("7F8383EC-D3EC-495C-A8CF-B8BBE85C2920"), 9),
    SENSOR_PROPERTY_DESCRIPTION               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2139325420, 54252, 18780, 168, 207, 184, 187, 232, 92, 41, 32}, 2))], [])*/PROPERTYKEY(GUID("7F8383EC-D3EC-495C-A8CF-B8BBE85C2920"), 10),
    SENSOR_PROPERTY_CONNECTION_TYPE           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2139325420, 54252, 18780, 168, 207, 184, 187, 232, 92, 41, 32}, 2))], [])*/PROPERTYKEY(GUID("7F8383EC-D3EC-495C-A8CF-B8BBE85C2920"), 11),
    SENSOR_PROPERTY_MIN_REPORT_INTERVAL       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2139325420, 54252, 18780, 168, 207, 184, 187, 232, 92, 41, 32}, 2))], [])*/PROPERTYKEY(GUID("7F8383EC-D3EC-495C-A8CF-B8BBE85C2920"), 12),
    SENSOR_PROPERTY_CURRENT_REPORT_INTERVAL   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2139325420, 54252, 18780, 168, 207, 184, 187, 232, 92, 41, 32}, 2))], [])*/PROPERTYKEY(GUID("7F8383EC-D3EC-495C-A8CF-B8BBE85C2920"), 13),
    SENSOR_PROPERTY_CHANGE_SENSITIVITY        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2139325420, 54252, 18780, 168, 207, 184, 187, 232, 92, 41, 32}, 2))], [])*/PROPERTYKEY(GUID("7F8383EC-D3EC-495C-A8CF-B8BBE85C2920"), 14),
    SENSOR_PROPERTY_DEVICE_PATH               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2139325420, 54252, 18780, 168, 207, 184, 187, 232, 92, 41, 32}, 2))], [])*/PROPERTYKEY(GUID("7F8383EC-D3EC-495C-A8CF-B8BBE85C2920"), 15),
    SENSOR_PROPERTY_LIGHT_RESPONSE_CURVE      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2139325420, 54252, 18780, 168, 207, 184, 187, 232, 92, 41, 32}, 2))], [])*/PROPERTYKEY(GUID("7F8383EC-D3EC-495C-A8CF-B8BBE85C2920"), 16),
    SENSOR_PROPERTY_ACCURACY                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2139325420, 54252, 18780, 168, 207, 184, 187, 232, 92, 41, 32}, 2))], [])*/PROPERTYKEY(GUID("7F8383EC-D3EC-495C-A8CF-B8BBE85C2920"), 17),
    SENSOR_PROPERTY_RESOLUTION                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2139325420, 54252, 18780, 168, 207, 184, 187, 232, 92, 41, 32}, 2))], [])*/PROPERTYKEY(GUID("7F8383EC-D3EC-495C-A8CF-B8BBE85C2920"), 18),
    SENSOR_PROPERTY_LOCATION_DESIRED_ACCURACY = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2139325420, 54252, 18780, 168, 207, 184, 187, 232, 92, 41, 32}, 2))], [])*/PROPERTYKEY(GUID("7F8383EC-D3EC-495C-A8CF-B8BBE85C2920"), 19),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2139325420, 54252, 18780, 168, 207, 184, 187, 232, 92, 41, 32}, 20))], [])*/PROPERTYKEY
{
    SENSOR_PROPERTY_RANGE_MINIMUM        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2139325420, 54252, 18780, 168, 207, 184, 187, 232, 92, 41, 32}, 20))], [])*/PROPERTYKEY(GUID("7F8383EC-D3EC-495C-A8CF-B8BBE85C2920"), 20),
    SENSOR_PROPERTY_RANGE_MAXIMUM        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2139325420, 54252, 18780, 168, 207, 184, 187, 232, 92, 41, 32}, 20))], [])*/PROPERTYKEY(GUID("7F8383EC-D3EC-495C-A8CF-B8BBE85C2920"), 21),
    SENSOR_PROPERTY_HID_USAGE            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2139325420, 54252, 18780, 168, 207, 184, 187, 232, 92, 41, 32}, 20))], [])*/PROPERTYKEY(GUID("7F8383EC-D3EC-495C-A8CF-B8BBE85C2920"), 22),
    SENSOR_PROPERTY_RADIO_STATE          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2139325420, 54252, 18780, 168, 207, 184, 187, 232, 92, 41, 32}, 20))], [])*/PROPERTYKEY(GUID("7F8383EC-D3EC-495C-A8CF-B8BBE85C2920"), 23),
    SENSOR_PROPERTY_RADIO_STATE_PREVIOUS = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2139325420, 54252, 18780, 168, 207, 184, 187, 232, 92, 41, 32}, 20))], [])*/PROPERTYKEY(GUID("7F8383EC-D3EC-495C-A8CF-B8BBE85C2920"), 24),
}

enum : GUID
{
    SENSOR_CATEGORY_ALL           = GUID("c317c286-c468-4288-9975-d4c4587c442c"),
    SENSOR_CATEGORY_LOCATION      = GUID("bfa794e4-f964-4fdb-90f6-51056bfe4b44"),
    SENSOR_CATEGORY_ENVIRONMENTAL = GUID("323439aa-7f66-492b-ba0c-73e9aa0a65d5"),
    SENSOR_CATEGORY_MOTION        = GUID("cd09daf1-3b2e-4c3d-b598-b5e5ff93fd46"),
    SENSOR_CATEGORY_ORIENTATION   = GUID("9e6c04b6-96fe-4954-b726-68682a473f69"),
    SENSOR_CATEGORY_MECHANICAL    = GUID("8d131d68-8ef7-4656-80b5-cccbd93791c5"),
    SENSOR_CATEGORY_ELECTRICAL    = GUID("fb73fcd8-fc4a-483c-ac58-27b691c6beff"),
    SENSOR_CATEGORY_BIOMETRIC     = GUID("ca19690f-a2c7-477d-a99e-99ec6e2b5648"),
    SENSOR_CATEGORY_LIGHT         = GUID("17a665c0-9063-4216-b202-5c7a255e18ce"),
    SENSOR_CATEGORY_SCANNER       = GUID("b000e77e-f5b5-420f-815d-0270a726f270"),
    SENSOR_CATEGORY_OTHER         = GUID("2c90e7a9-f4c9-4fa2-af37-56d471fe5a3d"),
    SENSOR_CATEGORY_UNSUPPORTED   = GUID("2beae7fa-19b0-48c5-a1f6-b5480dc206b0"),
}

enum : GUID
{
    SENSOR_TYPE_LOCATION_GPS            = GUID("ed4ca589-327a-4ff9-a560-91da4b48275e"),
    SENSOR_TYPE_LOCATION_STATIC         = GUID("095f8184-0fa9-4445-8e6e-b70f320b6b4c"),
    SENSOR_TYPE_LOCATION_LOOKUP         = GUID("3b2eae4a-72ce-436d-96d2-3c5b8570e987"),
    SENSOR_TYPE_LOCATION_TRIANGULATION  = GUID("691c341a-5406-4fe1-942f-2246cbeb39e0"),
    SENSOR_TYPE_LOCATION_OTHER          = GUID("9b2d0566-0368-4f71-b88d-533f132031de"),
    SENSOR_TYPE_LOCATION_BROADCAST      = GUID("d26988cf-5162-4039-bb17-4c58b698e44a"),
    SENSOR_TYPE_LOCATION_DEAD_RECKONING = GUID("1a37d538-f28b-42da-9fce-a9d0a2a6d829"),
}

enum : GUID
{
    SENSOR_TYPE_ENVIRONMENTAL_TEMPERATURE          = GUID("04fd0ec4-d5da-45fa-95a9-5db38ee19306"),
    SENSOR_TYPE_ENVIRONMENTAL_ATMOSPHERIC_PRESSURE = GUID("0e903829-ff8a-4a93-97df-3dcbde402288"),
    SENSOR_TYPE_ENVIRONMENTAL_HUMIDITY             = GUID("5c72bf67-bd7e-4257-990b-98a3ba3b400a"),
    SENSOR_TYPE_ENVIRONMENTAL_WIND_SPEED           = GUID("dd50607b-a45f-42cd-8efd-ec61761c4226"),
    SENSOR_TYPE_ENVIRONMENTAL_WIND_DIRECTION       = GUID("9ef57a35-9306-434d-af09-37fa5a9c00bd"),
}

enum : GUID
{
    SENSOR_TYPE_ACCELEROMETER_1D                     = GUID("c04d2387-7340-4cc2-991e-3b18cb8ef2f4"),
    SENSOR_TYPE_ACCELEROMETER_2D                     = GUID("b2c517a8-f6b5-4ba6-a423-5df560b4cc07"),
    SENSOR_TYPE_ACCELEROMETER_3D                     = GUID("c2fb0f5f-e2d2-4c78-bcd0-352a9582819d"),
    SENSOR_TYPE_MOTION_DETECTOR                      = GUID("5c7c1a12-30a5-43b9-a4b2-cf09ec5b7be8"),
    SENSOR_TYPE_GYROMETER_1D                         = GUID("fa088734-f552-4584-8324-edfaf649652c"),
    SENSOR_TYPE_GYROMETER_2D                         = GUID("31ef4f83-919b-48bf-8de0-5d7a9d240556"),
    SENSOR_TYPE_GYROMETER_3D                         = GUID("09485f5a-759e-42c2-bd4b-a349b75c8643"),
    SENSOR_TYPE_SPEEDOMETER                          = GUID("6bd73c1f-0bb4-4310-81b2-dfc18a52bf94"),
    SENSOR_TYPE_COMPASS_1D                           = GUID("a415f6c5-cb50-49d0-8e62-a8270bd7a26c"),
    SENSOR_TYPE_COMPASS_2D                           = GUID("15655cc0-997a-4d30-84db-57caba3648bb"),
    SENSOR_TYPE_COMPASS_3D                           = GUID("76b5ce0d-17dd-414d-93a1-e127f40bdf6e"),
    SENSOR_TYPE_INCLINOMETER_1D                      = GUID("b96f98c5-7a75-4ba7-94e9-ac868c966dd8"),
    SENSOR_TYPE_INCLINOMETER_2D                      = GUID("ab140f6d-83eb-4264-b70b-b16a5b256a01"),
    SENSOR_TYPE_INCLINOMETER_3D                      = GUID("b84919fb-ea85-4976-8444-6f6f5c6d31db"),
    SENSOR_TYPE_DISTANCE_1D                          = GUID("5f14ab2f-1407-4306-a93f-b1dbabe4f9c0"),
    SENSOR_TYPE_DISTANCE_2D                          = GUID("5cf9a46c-a9a2-4e55-b6a1-a04aafa95a92"),
    SENSOR_TYPE_DISTANCE_3D                          = GUID("a20cae31-0e25-4772-9fe5-96608a1354b2"),
    SENSOR_TYPE_AGGREGATED_QUADRANT_ORIENTATION      = GUID("9f81f1af-c4ab-4307-9904-c828bfb90829"),
    SENSOR_TYPE_AGGREGATED_DEVICE_ORIENTATION        = GUID("cdb5d8f7-3cfd-41c8-8542-cce622cf5d6e"),
    SENSOR_TYPE_AGGREGATED_SIMPLE_DEVICE_ORIENTATION = GUID("86a19291-0482-402c-bf4c-addac52b1c39"),
}

enum : GUID
{
    SENSOR_TYPE_VOLTAGE              = GUID("c5484637-4fb7-4953-98b8-a56d8aa1fb1e"),
    SENSOR_TYPE_CURRENT              = GUID("5adc9fce-15a0-4bbe-a1ad-2d38a9ae831c"),
    SENSOR_TYPE_CAPACITANCE          = GUID("ca2ffb1c-2317-49c0-a0b4-b63ce63461a0"),
    SENSOR_TYPE_RESISTANCE           = GUID("9993d2c8-c157-4a52-a7b5-195c76037231"),
    SENSOR_TYPE_INDUCTANCE           = GUID("dc1d933f-c435-4c7d-a2fe-607192a524d3"),
    SENSOR_TYPE_ELECTRICAL_POWER     = GUID("212f10f5-14ab-4376-9a43-a7794098c2fe"),
    SENSOR_TYPE_POTENTIOMETER        = GUID("2b3681a9-cadc-45aa-a6ff-54957c8bb440"),
    SENSOR_TYPE_FREQUENCY            = GUID("8cd2cbb6-73e6-4640-a709-72ae8fb60d7f"),
    SENSOR_TYPE_BOOLEAN_SWITCH       = GUID("9c7e371f-1041-460b-8d5c-71e4752e350c"),
    SENSOR_TYPE_MULTIVALUE_SWITCH    = GUID("b3ee4d76-37a4-4402-b25e-99c60a775fa1"),
    SENSOR_TYPE_FORCE                = GUID("c2ab2b02-1a1c-4778-a81b-954a1788cc75"),
    SENSOR_TYPE_SCALE                = GUID("c06dd92c-7feb-438e-9bf6-82207fff5bb8"),
    SENSOR_TYPE_PRESSURE             = GUID("26d31f34-6352-41cf-b793-ea0713d53d77"),
    SENSOR_TYPE_STRAIN               = GUID("c6d1ec0e-6803-4361-ad3d-85bcc58c6d29"),
    SENSOR_TYPE_BOOLEAN_SWITCH_ARRAY = GUID("545c8ba5-b143-4545-868f-ca7fd986b4f6"),
}

enum : GUID
{
    SENSOR_TYPE_HUMAN_PRESENCE  = GUID("c138c12b-ad52-451c-9375-87f518ff10c6"),
    SENSOR_TYPE_HUMAN_PROXIMITY = GUID("5220dae9-3179-4430-9f90-06266d2a34de"),
    SENSOR_TYPE_TOUCH           = GUID("17db3018-06c4-4f7d-81af-9274b7599c27"),
    SENSOR_TYPE_AMBIENT_LIGHT   = GUID("97f115c8-599a-4153-8894-d2d12899918a"),
    SENSOR_TYPE_RFID_SCANNER    = GUID("44328ef5-02dd-4e8d-ad5d-9249832b2eca"),
    SENSOR_TYPE_BARCODE_SCANNER = GUID("990b3d8f-85bb-45ff-914d-998c04f372df"),
    SENSOR_TYPE_CUSTOM          = GUID("e83af229-8640-4d18-a213-e22675ebb2c3"),
    SENSOR_TYPE_UNKNOWN         = GUID("10ba83e3-ef4f-41ed-9885-a87d6435a8e1"),
}

enum GUID SENSOR_DATA_TYPE_COMMON_GUID = GUID("db5e0cf2-cf1f-4c18-b46c-d86011d62150");
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3680374002, 53023, 19480, 180, 108, 216, 96, 17, 214, 33, 80}, 2))], [])*/PROPERTYKEY SENSOR_DATA_TYPE_TIMESTAMP = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3680374002, 53023, 19480, 180, 108, 216, 96, 17, 214, 33, 80}, 2))], [])*/PROPERTYKEY(GUID("DB5E0CF2-CF1F-4C18-B46C-D86011D62150"), 2);
enum GUID SENSOR_DATA_TYPE_LOCATION_GUID = GUID("055c74d8-ca6f-47d6-95c6-1ed3637a0ff4");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 2))], [])*/PROPERTYKEY
{
    SENSOR_DATA_TYPE_LATITUDE_DEGREES               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 2))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 2),
    SENSOR_DATA_TYPE_LONGITUDE_DEGREES              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 2))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 3),
    SENSOR_DATA_TYPE_ALTITUDE_SEALEVEL_METERS       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 2))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 4),
    SENSOR_DATA_TYPE_ALTITUDE_ELLIPSOID_METERS      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 2))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 5),
    SENSOR_DATA_TYPE_SPEED_KNOTS                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 2))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 6),
    SENSOR_DATA_TYPE_TRUE_HEADING_DEGREES           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 2))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 7),
    SENSOR_DATA_TYPE_MAGNETIC_HEADING_DEGREES       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 2))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 8),
    SENSOR_DATA_TYPE_MAGNETIC_VARIATION             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 2))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 9),
    SENSOR_DATA_TYPE_FIX_QUALITY                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 2))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 10),
    SENSOR_DATA_TYPE_FIX_TYPE                       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 2))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 11),
    SENSOR_DATA_TYPE_POSITION_DILUTION_OF_PRECISION = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 2))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 12),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 13))], [])*/PROPERTYKEY SENSOR_DATA_TYPE_HORIZONAL_DILUTION_OF_PRECISION = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 13))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 13);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 14))], [])*/PROPERTYKEY SENSOR_DATA_TYPE_VERTICAL_DILUTION_OF_PRECISION = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 14))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 14);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 15))], [])*/PROPERTYKEY
{
    SENSOR_DATA_TYPE_SATELLITES_USED_COUNT        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 15))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 15),
    SENSOR_DATA_TYPE_SATELLITES_USED_PRNS         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 15))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 16),
    SENSOR_DATA_TYPE_SATELLITES_IN_VIEW           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 15))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 17),
    SENSOR_DATA_TYPE_SATELLITES_IN_VIEW_PRNS      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 15))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 18),
    SENSOR_DATA_TYPE_SATELLITES_IN_VIEW_ELEVATION = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 15))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 19),
    SENSOR_DATA_TYPE_SATELLITES_IN_VIEW_AZIMUTH   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 15))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 20),
    SENSOR_DATA_TYPE_SATELLITES_IN_VIEW_STN_RATIO = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 15))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 21),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 22))], [])*/PROPERTYKEY
{
    SENSOR_DATA_TYPE_ERROR_RADIUS_METERS             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 22))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 22),
    SENSOR_DATA_TYPE_ADDRESS1                        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 22))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 23),
    SENSOR_DATA_TYPE_ADDRESS2                        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 22))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 24),
    SENSOR_DATA_TYPE_CITY                            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 22))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 25),
    SENSOR_DATA_TYPE_STATE_PROVINCE                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 22))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 26),
    SENSOR_DATA_TYPE_POSTALCODE                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 22))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 27),
    SENSOR_DATA_TYPE_COUNTRY_REGION                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 22))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 28),
    SENSOR_DATA_TYPE_ALTITUDE_ELLIPSOID_ERROR_METERS = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 22))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 29),
    SENSOR_DATA_TYPE_ALTITUDE_SEALEVEL_ERROR_METERS  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 22))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 30),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 31))], [])*/PROPERTYKEY
{
    SENSOR_DATA_TYPE_GPS_SELECTION_MODE               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 31))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 31),
    SENSOR_DATA_TYPE_GPS_OPERATION_MODE               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 31))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 32),
    SENSOR_DATA_TYPE_GPS_STATUS                       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 31))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 33),
    SENSOR_DATA_TYPE_GEOIDAL_SEPARATION               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 31))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 34),
    SENSOR_DATA_TYPE_DGPS_DATA_AGE                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 31))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 35),
    SENSOR_DATA_TYPE_ALTITUDE_ANTENNA_SEALEVEL_METERS = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 31))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 36),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 37))], [])*/PROPERTYKEY SENSOR_DATA_TYPE_DIFFERENTIAL_REFERENCE_STATION_ID = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 37))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 37);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 38))], [])*/PROPERTYKEY
{
    SENSOR_DATA_TYPE_NMEA_SENTENCE                           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 38))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 38),
    SENSOR_DATA_TYPE_SATELLITES_IN_VIEW_ID                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 38))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 39),
    SENSOR_DATA_TYPE_LOCATION_SOURCE                         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 38))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 40),
    SENSOR_DATA_TYPE_SATELLITES_USED_PRNS_AND_CONSTELLATIONS = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({89945304, 51823, 18390, 149, 198, 30, 211, 99, 122, 15, 244}, 38))], [])*/PROPERTYKEY(GUID("055C74D8-CA6F-47D6-95C6-1ED3637A0FF4"), 41),
}

enum GUID SENSOR_DATA_TYPE_ENVIRONMENTAL_GUID = GUID("8b0aa2f1-2d57-42ee-8cc0-4d27622b46c4");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2332730097, 11607, 17134, 140, 192, 77, 39, 98, 43, 70, 196}, 2))], [])*/PROPERTYKEY
{
    SENSOR_DATA_TYPE_TEMPERATURE_CELSIUS                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2332730097, 11607, 17134, 140, 192, 77, 39, 98, 43, 70, 196}, 2))], [])*/PROPERTYKEY(GUID("8B0AA2F1-2D57-42EE-8CC0-4D27622B46C4"), 2),
    SENSOR_DATA_TYPE_RELATIVE_HUMIDITY_PERCENT            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2332730097, 11607, 17134, 140, 192, 77, 39, 98, 43, 70, 196}, 2))], [])*/PROPERTYKEY(GUID("8B0AA2F1-2D57-42EE-8CC0-4D27622B46C4"), 3),
    SENSOR_DATA_TYPE_ATMOSPHERIC_PRESSURE_BAR             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2332730097, 11607, 17134, 140, 192, 77, 39, 98, 43, 70, 196}, 2))], [])*/PROPERTYKEY(GUID("8B0AA2F1-2D57-42EE-8CC0-4D27622B46C4"), 4),
    SENSOR_DATA_TYPE_WIND_DIRECTION_DEGREES_ANTICLOCKWISE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2332730097, 11607, 17134, 140, 192, 77, 39, 98, 43, 70, 196}, 2))], [])*/PROPERTYKEY(GUID("8B0AA2F1-2D57-42EE-8CC0-4D27622B46C4"), 5),
    SENSOR_DATA_TYPE_WIND_SPEED_METERS_PER_SECOND         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2332730097, 11607, 17134, 140, 192, 77, 39, 98, 43, 70, 196}, 2))], [])*/PROPERTYKEY(GUID("8B0AA2F1-2D57-42EE-8CC0-4D27622B46C4"), 6),
}

enum GUID SENSOR_DATA_TYPE_MOTION_GUID = GUID("3f8a69a2-07c5-4e48-a965-cd797aab56d5");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1066035618, 1989, 20040, 169, 101, 205, 121, 122, 171, 86, 213}, 2))], [])*/PROPERTYKEY
{
    SENSOR_DATA_TYPE_ACCELERATION_X_G                                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1066035618, 1989, 20040, 169, 101, 205, 121, 122, 171, 86, 213}, 2))], [])*/PROPERTYKEY(GUID("3F8A69A2-07C5-4E48-A965-CD797AAB56D5"), 2),
    SENSOR_DATA_TYPE_ACCELERATION_Y_G                                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1066035618, 1989, 20040, 169, 101, 205, 121, 122, 171, 86, 213}, 2))], [])*/PROPERTYKEY(GUID("3F8A69A2-07C5-4E48-A965-CD797AAB56D5"), 3),
    SENSOR_DATA_TYPE_ACCELERATION_Z_G                                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1066035618, 1989, 20040, 169, 101, 205, 121, 122, 171, 86, 213}, 2))], [])*/PROPERTYKEY(GUID("3F8A69A2-07C5-4E48-A965-CD797AAB56D5"), 4),
    SENSOR_DATA_TYPE_ANGULAR_ACCELERATION_X_DEGREES_PER_SECOND_SQUARED = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1066035618, 1989, 20040, 169, 101, 205, 121, 122, 171, 86, 213}, 2))], [])*/PROPERTYKEY(GUID("3F8A69A2-07C5-4E48-A965-CD797AAB56D5"), 5),
    SENSOR_DATA_TYPE_ANGULAR_ACCELERATION_Y_DEGREES_PER_SECOND_SQUARED = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1066035618, 1989, 20040, 169, 101, 205, 121, 122, 171, 86, 213}, 2))], [])*/PROPERTYKEY(GUID("3F8A69A2-07C5-4E48-A965-CD797AAB56D5"), 6),
    SENSOR_DATA_TYPE_ANGULAR_ACCELERATION_Z_DEGREES_PER_SECOND_SQUARED = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1066035618, 1989, 20040, 169, 101, 205, 121, 122, 171, 86, 213}, 2))], [])*/PROPERTYKEY(GUID("3F8A69A2-07C5-4E48-A965-CD797AAB56D5"), 7),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1066035618, 1989, 20040, 169, 101, 205, 121, 122, 171, 86, 213}, 8))], [])*/PROPERTYKEY
{
    SENSOR_DATA_TYPE_SPEED_METERS_PER_SECOND               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1066035618, 1989, 20040, 169, 101, 205, 121, 122, 171, 86, 213}, 8))], [])*/PROPERTYKEY(GUID("3F8A69A2-07C5-4E48-A965-CD797AAB56D5"), 8),
    SENSOR_DATA_TYPE_MOTION_STATE                          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1066035618, 1989, 20040, 169, 101, 205, 121, 122, 171, 86, 213}, 8))], [])*/PROPERTYKEY(GUID("3F8A69A2-07C5-4E48-A965-CD797AAB56D5"), 9),
    SENSOR_DATA_TYPE_ANGULAR_VELOCITY_X_DEGREES_PER_SECOND = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1066035618, 1989, 20040, 169, 101, 205, 121, 122, 171, 86, 213}, 8))], [])*/PROPERTYKEY(GUID("3F8A69A2-07C5-4E48-A965-CD797AAB56D5"), 10),
    SENSOR_DATA_TYPE_ANGULAR_VELOCITY_Y_DEGREES_PER_SECOND = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1066035618, 1989, 20040, 169, 101, 205, 121, 122, 171, 86, 213}, 8))], [])*/PROPERTYKEY(GUID("3F8A69A2-07C5-4E48-A965-CD797AAB56D5"), 11),
    SENSOR_DATA_TYPE_ANGULAR_VELOCITY_Z_DEGREES_PER_SECOND = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1066035618, 1989, 20040, 169, 101, 205, 121, 122, 171, 86, 213}, 8))], [])*/PROPERTYKEY(GUID("3F8A69A2-07C5-4E48-A965-CD797AAB56D5"), 12),
}

enum GUID SENSOR_DATA_TYPE_ORIENTATION_GUID = GUID("1637d8a2-4248-4275-865d-558de84aedfd");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({372758690, 16968, 17013, 134, 93, 85, 141, 232, 74, 237, 253}, 2))], [])*/PROPERTYKEY
{
    SENSOR_DATA_TYPE_TILT_X_DEGREES             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({372758690, 16968, 17013, 134, 93, 85, 141, 232, 74, 237, 253}, 2))], [])*/PROPERTYKEY(GUID("1637D8A2-4248-4275-865D-558DE84AEDFD"), 2),
    SENSOR_DATA_TYPE_TILT_Y_DEGREES             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({372758690, 16968, 17013, 134, 93, 85, 141, 232, 74, 237, 253}, 2))], [])*/PROPERTYKEY(GUID("1637D8A2-4248-4275-865D-558DE84AEDFD"), 3),
    SENSOR_DATA_TYPE_TILT_Z_DEGREES             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({372758690, 16968, 17013, 134, 93, 85, 141, 232, 74, 237, 253}, 2))], [])*/PROPERTYKEY(GUID("1637D8A2-4248-4275-865D-558DE84AEDFD"), 4),
    SENSOR_DATA_TYPE_MAGNETIC_HEADING_X_DEGREES = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({372758690, 16968, 17013, 134, 93, 85, 141, 232, 74, 237, 253}, 2))], [])*/PROPERTYKEY(GUID("1637D8A2-4248-4275-865D-558DE84AEDFD"), 5),
    SENSOR_DATA_TYPE_MAGNETIC_HEADING_Y_DEGREES = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({372758690, 16968, 17013, 134, 93, 85, 141, 232, 74, 237, 253}, 2))], [])*/PROPERTYKEY(GUID("1637D8A2-4248-4275-865D-558DE84AEDFD"), 6),
    SENSOR_DATA_TYPE_MAGNETIC_HEADING_Z_DEGREES = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({372758690, 16968, 17013, 134, 93, 85, 141, 232, 74, 237, 253}, 2))], [])*/PROPERTYKEY(GUID("1637D8A2-4248-4275-865D-558DE84AEDFD"), 7),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({372758690, 16968, 17013, 134, 93, 85, 141, 232, 74, 237, 253}, 8))], [])*/PROPERTYKEY
{
    SENSOR_DATA_TYPE_DISTANCE_X_METERS                                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({372758690, 16968, 17013, 134, 93, 85, 141, 232, 74, 237, 253}, 8))], [])*/PROPERTYKEY(GUID("1637D8A2-4248-4275-865D-558DE84AEDFD"), 8),
    SENSOR_DATA_TYPE_DISTANCE_Y_METERS                                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({372758690, 16968, 17013, 134, 93, 85, 141, 232, 74, 237, 253}, 8))], [])*/PROPERTYKEY(GUID("1637D8A2-4248-4275-865D-558DE84AEDFD"), 9),
    SENSOR_DATA_TYPE_DISTANCE_Z_METERS                                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({372758690, 16968, 17013, 134, 93, 85, 141, 232, 74, 237, 253}, 8))], [])*/PROPERTYKEY(GUID("1637D8A2-4248-4275-865D-558DE84AEDFD"), 10),
    SENSOR_DATA_TYPE_MAGNETIC_HEADING_COMPENSATED_MAGNETIC_NORTH_DEGREES = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({372758690, 16968, 17013, 134, 93, 85, 141, 232, 74, 237, 253}, 8))], [])*/PROPERTYKEY(GUID("1637D8A2-4248-4275-865D-558DE84AEDFD"), 11),
    SENSOR_DATA_TYPE_MAGNETIC_HEADING_COMPENSATED_TRUE_NORTH_DEGREES     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({372758690, 16968, 17013, 134, 93, 85, 141, 232, 74, 237, 253}, 8))], [])*/PROPERTYKEY(GUID("1637D8A2-4248-4275-865D-558DE84AEDFD"), 12),
    SENSOR_DATA_TYPE_MAGNETIC_HEADING_MAGNETIC_NORTH_DEGREES             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({372758690, 16968, 17013, 134, 93, 85, 141, 232, 74, 237, 253}, 8))], [])*/PROPERTYKEY(GUID("1637D8A2-4248-4275-865D-558DE84AEDFD"), 13),
    SENSOR_DATA_TYPE_MAGNETIC_HEADING_TRUE_NORTH_DEGREES                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({372758690, 16968, 17013, 134, 93, 85, 141, 232, 74, 237, 253}, 8))], [])*/PROPERTYKEY(GUID("1637D8A2-4248-4275-865D-558DE84AEDFD"), 14),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({372758690, 16968, 17013, 134, 93, 85, 141, 232, 74, 237, 253}, 15))], [])*/PROPERTYKEY
{
    SENSOR_DATA_TYPE_QUADRANT_ANGLE_DEGREES               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({372758690, 16968, 17013, 134, 93, 85, 141, 232, 74, 237, 253}, 15))], [])*/PROPERTYKEY(GUID("1637D8A2-4248-4275-865D-558DE84AEDFD"), 15),
    SENSOR_DATA_TYPE_ROTATION_MATRIX                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({372758690, 16968, 17013, 134, 93, 85, 141, 232, 74, 237, 253}, 15))], [])*/PROPERTYKEY(GUID("1637D8A2-4248-4275-865D-558DE84AEDFD"), 16),
    SENSOR_DATA_TYPE_QUATERNION                           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({372758690, 16968, 17013, 134, 93, 85, 141, 232, 74, 237, 253}, 15))], [])*/PROPERTYKEY(GUID("1637D8A2-4248-4275-865D-558DE84AEDFD"), 17),
    SENSOR_DATA_TYPE_SIMPLE_DEVICE_ORIENTATION            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({372758690, 16968, 17013, 134, 93, 85, 141, 232, 74, 237, 253}, 15))], [])*/PROPERTYKEY(GUID("1637D8A2-4248-4275-865D-558DE84AEDFD"), 18),
    SENSOR_DATA_TYPE_MAGNETIC_FIELD_STRENGTH_X_MILLIGAUSS = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({372758690, 16968, 17013, 134, 93, 85, 141, 232, 74, 237, 253}, 15))], [])*/PROPERTYKEY(GUID("1637D8A2-4248-4275-865D-558DE84AEDFD"), 19),
    SENSOR_DATA_TYPE_MAGNETIC_FIELD_STRENGTH_Y_MILLIGAUSS = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({372758690, 16968, 17013, 134, 93, 85, 141, 232, 74, 237, 253}, 15))], [])*/PROPERTYKEY(GUID("1637D8A2-4248-4275-865D-558DE84AEDFD"), 20),
    SENSOR_DATA_TYPE_MAGNETIC_FIELD_STRENGTH_Z_MILLIGAUSS = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({372758690, 16968, 17013, 134, 93, 85, 141, 232, 74, 237, 253}, 15))], [])*/PROPERTYKEY(GUID("1637D8A2-4248-4275-865D-558DE84AEDFD"), 21),
    SENSOR_DATA_TYPE_MAGNETOMETER_ACCURACY                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({372758690, 16968, 17013, 134, 93, 85, 141, 232, 74, 237, 253}, 15))], [])*/PROPERTYKEY(GUID("1637D8A2-4248-4275-865D-558DE84AEDFD"), 22),
}

enum GUID SENSOR_DATA_TYPE_GUID_MECHANICAL_GUID = GUID("38564a7c-f2f2-49bb-9b2b-ba60f66a58df");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({945179260, 62194, 18875, 155, 43, 186, 96, 246, 106, 88, 223}, 2))], [])*/PROPERTYKEY
{
    SENSOR_DATA_TYPE_BOOLEAN_SWITCH_STATE        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({945179260, 62194, 18875, 155, 43, 186, 96, 246, 106, 88, 223}, 2))], [])*/PROPERTYKEY(GUID("38564A7C-F2F2-49BB-9B2B-BA60F66A58DF"), 2),
    SENSOR_DATA_TYPE_MULTIVALUE_SWITCH_STATE     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({945179260, 62194, 18875, 155, 43, 186, 96, 246, 106, 88, 223}, 2))], [])*/PROPERTYKEY(GUID("38564A7C-F2F2-49BB-9B2B-BA60F66A58DF"), 3),
    SENSOR_DATA_TYPE_FORCE_NEWTONS               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({945179260, 62194, 18875, 155, 43, 186, 96, 246, 106, 88, 223}, 2))], [])*/PROPERTYKEY(GUID("38564A7C-F2F2-49BB-9B2B-BA60F66A58DF"), 4),
    SENSOR_DATA_TYPE_ABSOLUTE_PRESSURE_PASCAL    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({945179260, 62194, 18875, 155, 43, 186, 96, 246, 106, 88, 223}, 2))], [])*/PROPERTYKEY(GUID("38564A7C-F2F2-49BB-9B2B-BA60F66A58DF"), 5),
    SENSOR_DATA_TYPE_GAUGE_PRESSURE_PASCAL       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({945179260, 62194, 18875, 155, 43, 186, 96, 246, 106, 88, 223}, 2))], [])*/PROPERTYKEY(GUID("38564A7C-F2F2-49BB-9B2B-BA60F66A58DF"), 6),
    SENSOR_DATA_TYPE_STRAIN                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({945179260, 62194, 18875, 155, 43, 186, 96, 246, 106, 88, 223}, 2))], [])*/PROPERTYKEY(GUID("38564A7C-F2F2-49BB-9B2B-BA60F66A58DF"), 7),
    SENSOR_DATA_TYPE_WEIGHT_KILOGRAMS            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({945179260, 62194, 18875, 155, 43, 186, 96, 246, 106, 88, 223}, 2))], [])*/PROPERTYKEY(GUID("38564A7C-F2F2-49BB-9B2B-BA60F66A58DF"), 8),
    SENSOR_DATA_TYPE_BOOLEAN_SWITCH_ARRAY_STATES = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({945179260, 62194, 18875, 155, 43, 186, 96, 246, 106, 88, 223}, 2))], [])*/PROPERTYKEY(GUID("38564A7C-F2F2-49BB-9B2B-BA60F66A58DF"), 10),
}

enum GUID SENSOR_DATA_TYPE_BIOMETRIC_GUID = GUID("2299288a-6d9e-4b0b-b7ec-3528f89e40af");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({580462730, 28062, 19211, 183, 236, 53, 40, 248, 158, 64, 175}, 2))], [])*/PROPERTYKEY
{
    SENSOR_DATA_TYPE_HUMAN_PRESENCE         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({580462730, 28062, 19211, 183, 236, 53, 40, 248, 158, 64, 175}, 2))], [])*/PROPERTYKEY(GUID("2299288A-6D9E-4B0B-B7EC-3528F89E40AF"), 2),
    SENSOR_DATA_TYPE_HUMAN_PROXIMITY_METERS = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({580462730, 28062, 19211, 183, 236, 53, 40, 248, 158, 64, 175}, 2))], [])*/PROPERTYKEY(GUID("2299288A-6D9E-4B0B-B7EC-3528F89E40AF"), 3),
    SENSOR_DATA_TYPE_TOUCH_STATE            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({580462730, 28062, 19211, 183, 236, 53, 40, 248, 158, 64, 175}, 2))], [])*/PROPERTYKEY(GUID("2299288A-6D9E-4B0B-B7EC-3528F89E40AF"), 4),
}

enum GUID SENSOR_DATA_TYPE_LIGHT_GUID = GUID("e4c77ce2-dcb7-46e9-8439-4fec548833a6");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3838278882, 56503, 18153, 132, 57, 79, 236, 84, 136, 51, 166}, 2))], [])*/PROPERTYKEY
{
    SENSOR_DATA_TYPE_LIGHT_LEVEL_LUX          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3838278882, 56503, 18153, 132, 57, 79, 236, 84, 136, 51, 166}, 2))], [])*/PROPERTYKEY(GUID("E4C77CE2-DCB7-46E9-8439-4FEC548833A6"), 2),
    SENSOR_DATA_TYPE_LIGHT_TEMPERATURE_KELVIN = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3838278882, 56503, 18153, 132, 57, 79, 236, 84, 136, 51, 166}, 2))], [])*/PROPERTYKEY(GUID("E4C77CE2-DCB7-46E9-8439-4FEC548833A6"), 3),
    SENSOR_DATA_TYPE_LIGHT_CHROMACITY         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3838278882, 56503, 18153, 132, 57, 79, 236, 84, 136, 51, 166}, 2))], [])*/PROPERTYKEY(GUID("E4C77CE2-DCB7-46E9-8439-4FEC548833A6"), 4),
}

enum GUID SENSOR_DATA_TYPE_SCANNER_GUID = GUID("d7a59a3c-3421-44ab-8d3a-9de8ab6c4cae");
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3617954364, 13345, 17579, 141, 58, 157, 232, 171, 108, 76, 174}, 2))], [])*/PROPERTYKEY SENSOR_DATA_TYPE_RFID_TAG_40_BIT = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3617954364, 13345, 17579, 141, 58, 157, 232, 171, 108, 76, 174}, 2))], [])*/PROPERTYKEY(GUID("D7A59A3C-3421-44AB-8D3A-9DE8AB6C4CAE"), 2);
enum GUID SENSOR_DATA_TYPE_ELECTRICAL_GUID = GUID("bbb246d1-e242-4780-a2d3-cded84f35842");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3149022929, 57922, 18304, 162, 211, 205, 237, 132, 243, 88, 66}, 2))], [])*/PROPERTYKEY
{
    SENSOR_DATA_TYPE_VOLTAGE_VOLTS               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3149022929, 57922, 18304, 162, 211, 205, 237, 132, 243, 88, 66}, 2))], [])*/PROPERTYKEY(GUID("BBB246D1-E242-4780-A2D3-CDED84F35842"), 2),
    SENSOR_DATA_TYPE_CURRENT_AMPS                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3149022929, 57922, 18304, 162, 211, 205, 237, 132, 243, 88, 66}, 2))], [])*/PROPERTYKEY(GUID("BBB246D1-E242-4780-A2D3-CDED84F35842"), 3),
    SENSOR_DATA_TYPE_CAPACITANCE_FARAD           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3149022929, 57922, 18304, 162, 211, 205, 237, 132, 243, 88, 66}, 2))], [])*/PROPERTYKEY(GUID("BBB246D1-E242-4780-A2D3-CDED84F35842"), 4),
    SENSOR_DATA_TYPE_RESISTANCE_OHMS             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3149022929, 57922, 18304, 162, 211, 205, 237, 132, 243, 88, 66}, 2))], [])*/PROPERTYKEY(GUID("BBB246D1-E242-4780-A2D3-CDED84F35842"), 5),
    SENSOR_DATA_TYPE_INDUCTANCE_HENRY            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3149022929, 57922, 18304, 162, 211, 205, 237, 132, 243, 88, 66}, 2))], [])*/PROPERTYKEY(GUID("BBB246D1-E242-4780-A2D3-CDED84F35842"), 6),
    SENSOR_DATA_TYPE_ELECTRICAL_POWER_WATTS      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3149022929, 57922, 18304, 162, 211, 205, 237, 132, 243, 88, 66}, 2))], [])*/PROPERTYKEY(GUID("BBB246D1-E242-4780-A2D3-CDED84F35842"), 7),
    SENSOR_DATA_TYPE_ELECTRICAL_PERCENT_OF_RANGE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3149022929, 57922, 18304, 162, 211, 205, 237, 132, 243, 88, 66}, 2))], [])*/PROPERTYKEY(GUID("BBB246D1-E242-4780-A2D3-CDED84F35842"), 8),
    SENSOR_DATA_TYPE_ELECTRICAL_FREQUENCY_HERTZ  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3149022929, 57922, 18304, 162, 211, 205, 237, 132, 243, 88, 66}, 2))], [])*/PROPERTYKEY(GUID("BBB246D1-E242-4780-A2D3-CDED84F35842"), 9),
}

enum GUID SENSOR_DATA_TYPE_CUSTOM_GUID = GUID("b14c764f-07cf-41e8-9d82-ebe3d0776a6f");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY
{
    SENSOR_DATA_TYPE_CUSTOM_USAGE         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 5),
    SENSOR_DATA_TYPE_CUSTOM_BOOLEAN_ARRAY = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 6),
    SENSOR_DATA_TYPE_CUSTOM_VALUE1        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 7),
    SENSOR_DATA_TYPE_CUSTOM_VALUE2        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 8),
    SENSOR_DATA_TYPE_CUSTOM_VALUE3        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 9),
    SENSOR_DATA_TYPE_CUSTOM_VALUE4        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 10),
    SENSOR_DATA_TYPE_CUSTOM_VALUE5        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 11),
    SENSOR_DATA_TYPE_CUSTOM_VALUE6        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 12),
    SENSOR_DATA_TYPE_CUSTOM_VALUE7        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 13),
    SENSOR_DATA_TYPE_CUSTOM_VALUE8        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 14),
    SENSOR_DATA_TYPE_CUSTOM_VALUE9        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 15),
    SENSOR_DATA_TYPE_CUSTOM_VALUE10       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 16),
    SENSOR_DATA_TYPE_CUSTOM_VALUE11       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 17),
    SENSOR_DATA_TYPE_CUSTOM_VALUE12       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 18),
    SENSOR_DATA_TYPE_CUSTOM_VALUE13       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 19),
    SENSOR_DATA_TYPE_CUSTOM_VALUE14       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 20),
    SENSOR_DATA_TYPE_CUSTOM_VALUE15       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 21),
    SENSOR_DATA_TYPE_CUSTOM_VALUE16       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 22),
    SENSOR_DATA_TYPE_CUSTOM_VALUE17       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 23),
    SENSOR_DATA_TYPE_CUSTOM_VALUE18       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 24),
    SENSOR_DATA_TYPE_CUSTOM_VALUE19       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 25),
    SENSOR_DATA_TYPE_CUSTOM_VALUE20       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 26),
    SENSOR_DATA_TYPE_CUSTOM_VALUE21       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 27),
    SENSOR_DATA_TYPE_CUSTOM_VALUE22       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 28),
    SENSOR_DATA_TYPE_CUSTOM_VALUE23       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 29),
    SENSOR_DATA_TYPE_CUSTOM_VALUE24       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 30),
    SENSOR_DATA_TYPE_CUSTOM_VALUE25       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 31),
    SENSOR_DATA_TYPE_CUSTOM_VALUE26       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 32),
    SENSOR_DATA_TYPE_CUSTOM_VALUE27       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 33),
    SENSOR_DATA_TYPE_CUSTOM_VALUE28       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2974578255, 1999, 16872, 157, 130, 235, 227, 208, 119, 106, 111}, 5))], [])*/PROPERTYKEY(GUID("B14C764F-07CF-41E8-9D82-EBE3D0776A6F"), 34),
}

enum GUID SENSOR_PROPERTY_TEST_GUID = GUID("e1e962f4-6e65-45f7-9c36-d487b7b1bd34");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3790168820, 28261, 17911, 156, 54, 212, 135, 183, 177, 189, 52}, 2))], [])*/PROPERTYKEY
{
    SENSOR_PROPERTY_CLEAR_ASSISTANCE_DATA = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3790168820, 28261, 17911, 156, 54, 212, 135, 183, 177, 189, 52}, 2))], [])*/PROPERTYKEY(GUID("E1E962F4-6E65-45F7-9C36-D487B7B1BD34"), 2),
    SENSOR_PROPERTY_TURN_ON_OFF_NMEA      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3790168820, 28261, 17911, 156, 54, 212, 135, 183, 177, 189, 52}, 2))], [])*/PROPERTYKEY(GUID("E1E962F4-6E65-45F7-9C36-D487B7B1BD34"), 3),
}

enum uint GNSS_CLEAR_ALL_ASSISTANCE_DATA = 0x00000001U;

enum : GUID
{
    GUID_SensorCategory_All              = GUID("c317c286-c468-4288-9975-d4c4587c442c"),
    GUID_SensorCategory_Biometric        = GUID("ca19690f-a2c7-477d-a99e-99ec6e2b5648"),
    GUID_SensorCategory_Electrical       = GUID("fb73fcd8-fc4a-483c-ac58-27b691c6beff"),
    GUID_SensorCategory_Environmental    = GUID("323439aa-7f66-492b-ba0c-73e9aa0a65d5"),
    GUID_SensorCategory_Light            = GUID("17a665c0-9063-4216-b202-5c7a255e18ce"),
    GUID_SensorCategory_Location         = GUID("bfa794e4-f964-4fdb-90f6-51056bfe4b44"),
    GUID_SensorCategory_Mechanical       = GUID("8d131d68-8ef7-4656-80b5-cccbd93791c5"),
    GUID_SensorCategory_Motion           = GUID("cd09daf1-3b2e-4c3d-b598-b5e5ff93fd46"),
    GUID_SensorCategory_Orientation      = GUID("9e6c04b6-96fe-4954-b726-68682a473f69"),
    GUID_SensorCategory_Other            = GUID("2c90e7a9-f4c9-4fa2-af37-56d471fe5a3d"),
    GUID_SensorCategory_PersonalActivity = GUID("f1609081-1e12-412b-a14d-cbb0e95bd2e5"),
    GUID_SensorCategory_Scanner          = GUID("b000e77e-f5b5-420f-815d-0270a726f270"),
    GUID_SensorCategory_Unsupported      = GUID("2beae7fa-19b0-48c5-a1f6-b5480dc206b0"),
}

enum : GUID
{
    GUID_SensorType_Accelerometer3D         = GUID("c2fb0f5f-e2d2-4c78-bcd0-352a9582819d"),
    GUID_SensorType_ActivityDetection       = GUID("9d9e0118-1807-4f2e-96e4-2ce57142e196"),
    GUID_SensorType_AmbientLight            = GUID("97f115c8-599a-4153-8894-d2d12899918a"),
    GUID_SensorType_Barometer               = GUID("0e903829-ff8a-4a93-97df-3dcbde402288"),
    GUID_SensorType_Custom                  = GUID("e83af229-8640-4d18-a213-e22675ebb2c3"),
    GUID_SensorType_FloorElevation          = GUID("ade4987f-7ac4-4dfa-9722-0a027181c747"),
    GUID_SensorType_GeomagneticOrientation  = GUID("e77195f8-2d1f-4823-971b-1c4467556c9d"),
    GUID_SensorType_GravityVector           = GUID("03b52c73-bb76-463f-9524-38de76eb700b"),
    GUID_SensorType_Gyrometer3D             = GUID("09485f5a-759e-42c2-bd4b-a349b75c8643"),
    GUID_SensorType_Humidity                = GUID("5c72bf67-bd7e-4257-990b-98a3ba3b400a"),
    GUID_SensorType_LinearAccelerometer     = GUID("038b0283-97b4-41c8-bc24-5ff1aa48fec7"),
    GUID_SensorType_Magnetometer3D          = GUID("55e5effb-15c7-40df-8698-a84b7c863c53"),
    GUID_SensorType_Orientation             = GUID("cdb5d8f7-3cfd-41c8-8542-cce622cf5d6e"),
    GUID_SensorType_Pedometer               = GUID("b19f89af-e3eb-444b-8dea-202575a71599"),
    GUID_SensorType_Proximity               = GUID("5220dae9-3179-4430-9f90-06266d2a34de"),
    GUID_SensorType_RelativeOrientation     = GUID("40993b51-4706-44dc-98d5-c920c037ffab"),
    GUID_SensorType_SimpleDeviceOrientation = GUID("86a19291-0482-402c-bf4c-addac52b1c39"),
    GUID_SensorType_Temperature             = GUID("04fd0ec4-d5da-45fa-95a9-5db38ee19306"),
    GUID_SensorType_HingeAngle              = GUID("82358065-f4c4-4da1-b272-13c23332a207"),
}

enum uint SENSOR_PROPERTY_LIST_HEADER_SIZE = 0x00000008U;

// Structs


struct SENSOR_VALUE_PAIR
{
    PROPERTYKEY Key;
    PROPVARIANT Value;
}

struct SENSOR_COLLECTION_LIST
{
    uint AllocatedSizeInBytes;
    uint Count;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/SENSOR_VALUE_PAIR[1] List;
}

struct SENSOR_PROPERTY_LIST
{
    uint AllocatedSizeInBytes;
    uint Count;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/PROPERTYKEY[1] List;
}

struct VEC3D
{
    float X;
    float Y;
    float Z;
}

struct MATRIX3X3
{
    union
    {
        struct
        {
            float A11;
            float A12;
            float A13;
            float A21;
            float A22;
            float A23;
            float A31;
            float A32;
            float A33;
        }
        struct
        {
            VEC3D V1;
            VEC3D V2;
            VEC3D V3;
        }
        float[9] M;
    }
}

struct QUATERNION
{
    float X;
    float Y;
    float Z;
    float W;
}

// Functions

@DllImport("SensorsUtilsV2.dll")
NTSTATUS GetPerformanceTime(uint* TimeMs);

@DllImport("SensorsUtilsV2.dll")
HRESULT InitPropVariantFromFloat(float fltVal, PROPVARIANT* ppropvar);

@DllImport("SensorsUtilsV2.dll")
NTSTATUS PropKeyFindKeyGetPropVariant(const(SENSOR_COLLECTION_LIST)* pList, const(PROPERTYKEY)* pKey, 
                                      BOOLEAN TypeCheck, PROPVARIANT* pValue);

@DllImport("SensorsUtilsV2.dll")
NTSTATUS PropKeyFindKeySetPropVariant(SENSOR_COLLECTION_LIST* pList, const(PROPERTYKEY)* pKey, BOOLEAN TypeCheck, 
                                      PROPVARIANT* pValue);

@DllImport("SensorsUtilsV2.dll")
NTSTATUS PropKeyFindKeyGetFileTime(const(SENSOR_COLLECTION_LIST)* pList, const(PROPERTYKEY)* pKey, 
                                   FILETIME* pRetValue);

@DllImport("SensorsUtilsV2.dll")
NTSTATUS PropKeyFindKeyGetGuid(const(SENSOR_COLLECTION_LIST)* pList, const(PROPERTYKEY)* pKey, GUID* pRetValue);

@DllImport("SensorsUtilsV2.dll")
NTSTATUS PropKeyFindKeyGetBool(const(SENSOR_COLLECTION_LIST)* pList, const(PROPERTYKEY)* pKey, BOOL* pRetValue);

@DllImport("SensorsUtilsV2.dll")
NTSTATUS PropKeyFindKeyGetUlong(const(SENSOR_COLLECTION_LIST)* pList, const(PROPERTYKEY)* pKey, uint* pRetValue);

@DllImport("SensorsUtilsV2.dll")
NTSTATUS PropKeyFindKeyGetUshort(const(SENSOR_COLLECTION_LIST)* pList, const(PROPERTYKEY)* pKey, ushort* pRetValue);

@DllImport("SensorsUtilsV2.dll")
NTSTATUS PropKeyFindKeyGetFloat(const(SENSOR_COLLECTION_LIST)* pList, const(PROPERTYKEY)* pKey, float* pRetValue);

@DllImport("SensorsUtilsV2.dll")
NTSTATUS PropKeyFindKeyGetDouble(const(SENSOR_COLLECTION_LIST)* pList, const(PROPERTYKEY)* pKey, double* pRetValue);

@DllImport("SensorsUtilsV2.dll")
NTSTATUS PropKeyFindKeyGetInt32(const(SENSOR_COLLECTION_LIST)* pList, const(PROPERTYKEY)* pKey, int* pRetValue);

@DllImport("SensorsUtilsV2.dll")
NTSTATUS PropKeyFindKeyGetInt64(const(SENSOR_COLLECTION_LIST)* pList, const(PROPERTYKEY)* pKey, long* pRetValue);

@DllImport("SensorsUtilsV2.dll")
NTSTATUS PropKeyFindKeyGetNthUlong(const(SENSOR_COLLECTION_LIST)* pList, const(PROPERTYKEY)* pKey, 
                                   const(uint) Occurrence, uint* pRetValue);

@DllImport("SensorsUtilsV2.dll")
NTSTATUS PropKeyFindKeyGetNthUshort(const(SENSOR_COLLECTION_LIST)* pList, const(PROPERTYKEY)* pKey, 
                                    const(uint) Occurrence, ushort* pRetValue);

@DllImport("SensorsUtilsV2.dll")
NTSTATUS PropKeyFindKeyGetNthInt64(const(SENSOR_COLLECTION_LIST)* pList, const(PROPERTYKEY)* pKey, 
                                   const(uint) Occurrence, long* pRetValue);

@DllImport("SensorsUtilsV2.dll")
BOOLEAN IsKeyPresentInPropertyList(SENSOR_PROPERTY_LIST* pList, const(PROPERTYKEY)* pKey);

@DllImport("SensorsUtilsV2.dll")
BOOLEAN IsKeyPresentInCollectionList(SENSOR_COLLECTION_LIST* pList, const(PROPERTYKEY)* pKey);

@DllImport("SensorsUtilsV2.dll")
BOOLEAN IsCollectionListSame(const(SENSOR_COLLECTION_LIST)* ListA, const(SENSOR_COLLECTION_LIST)* ListB);

@DllImport("SensorsUtilsV2.dll")
NTSTATUS PropVariantGetInformation(const(PROPVARIANT)* PropVariantValue, uint* PropVariantOffset, 
                                   uint* PropVariantSize, void** PropVariantPointer, DEVPROPTYPE* RemappedType);

@DllImport("SensorsUtilsV2.dll")
NTSTATUS PropertiesListCopy(SENSOR_PROPERTY_LIST* Target, const(SENSOR_PROPERTY_LIST)* Source);

@DllImport("SensorsUtilsV2.dll")
uint PropertiesListGetFillableCount(uint BufferSizeBytes);

@DllImport("SensorsUtilsV2.dll")
uint CollectionsListGetMarshalledSize(const(SENSOR_COLLECTION_LIST)* Collection);

@DllImport("SensorsUtilsV2.dll")
NTSTATUS CollectionsListCopyAndMarshall(SENSOR_COLLECTION_LIST* Target, const(SENSOR_COLLECTION_LIST)* Source);

@DllImport("SensorsUtilsV2.dll")
NTSTATUS CollectionsListMarshall(SENSOR_COLLECTION_LIST* Target);

@DllImport("SensorsUtilsV2.dll")
uint CollectionsListGetMarshalledSizeWithoutSerialization(const(SENSOR_COLLECTION_LIST)* Collection);

@DllImport("SensorsUtilsV2.dll")
NTSTATUS CollectionsListUpdateMarshalledPointer(SENSOR_COLLECTION_LIST* Collection);

@DllImport("SensorsUtilsV2.dll")
NTSTATUS SerializationBufferAllocate(uint SizeInBytes, ubyte** pBuffer);

@DllImport("SensorsUtilsV2.dll")
void SerializationBufferFree(ubyte* Buffer);

@DllImport("SensorsUtilsV2.dll")
uint CollectionsListGetSerializedSize(const(SENSOR_COLLECTION_LIST)* Collection);

@DllImport("SensorsUtilsV2.dll")
NTSTATUS CollectionsListSerializeToBuffer(const(SENSOR_COLLECTION_LIST)* SourceCollection, 
                                          uint TargetBufferSizeInBytes, 
                                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* TargetBuffer);

@DllImport("SensorsUtilsV2.dll")
NTSTATUS CollectionsListAllocateBufferAndSerialize(const(SENSOR_COLLECTION_LIST)* SourceCollection, 
                                                   uint* pTargetBufferSizeInBytes, ubyte** pTargetBuffer);

@DllImport("SensorsUtilsV2.dll")
NTSTATUS CollectionsListDeserializeFromBuffer(uint SourceBufferSizeInBytes, 
                                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/const(ubyte)* SourceBuffer, 
                                              SENSOR_COLLECTION_LIST* TargetCollection);

@DllImport("SensorsUtilsV2.dll")
NTSTATUS SensorCollectionGetAt(uint Index, SENSOR_COLLECTION_LIST* pSensorsList, PROPERTYKEY* pKey, 
                               PROPVARIANT* pValue);

@DllImport("SensorsUtilsV2.dll")
uint CollectionsListGetFillableCount(uint BufferSizeBytes);

@DllImport("SensorsUtilsV2.dll")
BOOLEAN EvaluateActivityThresholds(SENSOR_COLLECTION_LIST* newSample, SENSOR_COLLECTION_LIST* oldSample, 
                                   SENSOR_COLLECTION_LIST* thresholds);

@DllImport("SensorsUtilsV2.dll")
NTSTATUS CollectionsListSortSubscribedActivitiesByConfidence(SENSOR_COLLECTION_LIST* thresholds, 
                                                             SENSOR_COLLECTION_LIST* pCollection);

@DllImport("SensorsUtilsV2.dll")
HRESULT InitPropVariantFromCLSIDArray(GUID* members, uint size, PROPVARIANT* ppropvar);

@DllImport("SensorsUtilsV2.dll")
BOOLEAN IsSensorSubscribed(SENSOR_COLLECTION_LIST* subscriptionList, GUID currentType);

@DllImport("SensorsUtilsV2.dll")
BOOLEAN IsGUIDPresentInList(const(GUID)* guidArray, const(uint) arrayLength, const(GUID)* guidElem);


// Interfaces

@GUID("77a1c827-fcd2-4689-8915-9d613cc5fa3e")
struct SensorManager;

@GUID("79c43adb-a429-469f-aa39-2f2b74b75937")
struct SensorCollection;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/medfound/sensor-profile-guids
@GUID("e97ced00-523a-4133-bf6f-d3a2dae7f6ba")
struct Sensor;

@GUID("4ea9d6ef-694b-4218-8816-ccda8da74bba")
struct SensorDataReport;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nn-sensorsapi-isensormanager
@GUID("bd77db67-45a8-42dc-8d00-6dcf15f8377a")
interface ISensorManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensormanager-getsensorsbycategory
    HRESULT GetSensorsByCategory(GUID* sensorCategory, ISensorCollection* ppSensorsFound);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensormanager-getsensorsbytype
    HRESULT GetSensorsByType(GUID* sensorType, ISensorCollection* ppSensorsFound);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensormanager-getsensorbyid
    HRESULT GetSensorByID(GUID* sensorID, ISensor* ppSensor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensormanager-seteventsink
    HRESULT SetEventSink(ISensorManagerEvents pEvents);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensormanager-requestpermissions
    HRESULT RequestPermissions(HWND hParent, ISensorCollection pSensors, BOOL fModal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nn-sensorsapi-ilocationpermissions
@GUID("d5fb0a7f-e74e-44f5-8e02-4806863a274f")
interface ILocationPermissions : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-ilocationpermissions-getgloballocationpermission
    HRESULT GetGlobalLocationPermission(BOOL* pfEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-ilocationpermissions-checklocationcapability
    HRESULT CheckLocationCapability(uint dwClientThreadId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nn-sensorsapi-isensorcollection
@GUID("23571e11-e545-4dd8-a337-b89bf44b10df")
interface ISensorCollection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensorcollection-getat
    HRESULT GetAt(uint ulIndex, ISensor* ppSensor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensorcollection-getcount
    HRESULT GetCount(uint* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensorcollection-add
    HRESULT Add(ISensor pSensor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensorcollection-remove
    HRESULT Remove(ISensor pSensor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensorcollection-removebyid
    HRESULT RemoveByID(GUID* sensorID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensorcollection-clear
    HRESULT Clear();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nn-sensorsapi-isensor
@GUID("5fa08f80-2657-458e-af75-46f73fa6ac5c")
interface ISensor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensor-getid
    HRESULT GetID(GUID* pID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensor-getcategory
    HRESULT GetCategory(GUID* pSensorCategory);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensor-gettype
    HRESULT GetType(GUID* pSensorType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensor-getfriendlyname
    HRESULT GetFriendlyName(BSTR* pFriendlyName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensor-getproperty
    HRESULT GetProperty(const(PROPERTYKEY)* key, PROPVARIANT* pProperty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensor-getproperties
    HRESULT GetProperties(IPortableDeviceKeyCollection pKeys, IPortableDeviceValues* ppProperties);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensor-getsupporteddatafields
    HRESULT GetSupportedDataFields(IPortableDeviceKeyCollection* ppDataFields);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensor-setproperties
    HRESULT SetProperties(IPortableDeviceValues pProperties, IPortableDeviceValues* ppResults);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensor-supportsdatafield
    HRESULT SupportsDataField(const(PROPERTYKEY)* key, VARIANT_BOOL* pIsSupported);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensor-getstate
    HRESULT GetState(SensorState* pState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensor-getdata
    HRESULT GetData(ISensorDataReport* ppDataReport);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensor-supportsevent
    HRESULT SupportsEvent(const(GUID)* eventGuid, VARIANT_BOOL* pIsSupported);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensor-geteventinterest
    HRESULT GetEventInterest(GUID** ppValues, uint* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensor-seteventinterest
    HRESULT SetEventInterest(GUID* pValues, uint count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensor-seteventsink
    HRESULT SetEventSink(ISensorEvents pEvents);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nn-sensorsapi-isensordatareport
@GUID("0ab9df9b-c4b5-4796-8898-0470706a2e1d")
interface ISensorDataReport : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensordatareport-gettimestamp
    HRESULT GetTimestamp(SYSTEMTIME* pTimeStamp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensordatareport-getsensorvalue
    HRESULT GetSensorValue(const(PROPERTYKEY)* pKey, PROPVARIANT* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensordatareport-getsensorvalues
    HRESULT GetSensorValues(IPortableDeviceKeyCollection pKeys, IPortableDeviceValues* ppValues);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nn-sensorsapi-isensormanagerevents
@GUID("9b3b0b86-266a-4aad-b21f-fde5501001b7")
interface ISensorManagerEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensormanagerevents-onsensorenter
    HRESULT OnSensorEnter(ISensor pSensor, SensorState state);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nn-sensorsapi-isensorevents
@GUID("5d8dcc91-4641-47e7-b7c3-b74f48a6c391")
interface ISensorEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensorevents-onstatechanged
    HRESULT OnStateChanged(ISensor pSensor, SensorState state);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensorevents-ondataupdated
    HRESULT OnDataUpdated(ISensor pSensor, ISensorDataReport pNewData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensorevents-onevent
    HRESULT OnEvent(ISensor pSensor, const(GUID)* eventID, IPortableDeviceValues pEventData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sensorsapi/nf-sensorsapi-isensorevents-onleave
    HRESULT OnLeave(GUID* ID);
}


// GUIDs

const GUID CLSID_Sensor           = GUIDOF!Sensor;
const GUID CLSID_SensorCollection = GUIDOF!SensorCollection;
const GUID CLSID_SensorDataReport = GUIDOF!SensorDataReport;
const GUID CLSID_SensorManager    = GUIDOF!SensorManager;

const GUID IID_ILocationPermissions = GUIDOF!ILocationPermissions;
const GUID IID_ISensor              = GUIDOF!ISensor;
const GUID IID_ISensorCollection    = GUIDOF!ISensorCollection;
const GUID IID_ISensorDataReport    = GUIDOF!ISensorDataReport;
const GUID IID_ISensorEvents        = GUIDOF!ISensorEvents;
const GUID IID_ISensorManager       = GUIDOF!ISensorManager;
const GUID IID_ISensorManagerEvents = GUIDOF!ISensorManagerEvents;
