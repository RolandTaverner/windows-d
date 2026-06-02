// Written in the D programming language.

module windows.win32.devices.geolocation;

public import windows.core;
public import windows.win32.devices.sensors : LOCATION_DESIRED_ACCURACY;
public import windows.win32.foundation : BOOL, BSTR, CHAR, FILETIME, HRESULT, HWND,
                                         NTSTATUS, PROPERTYKEY, SYSTEMTIME;
public import windows.win32.system.com : IDispatch, IUnknown;
public import windows.win32.system.com.structuredstorage : PROPVARIANT;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/ne-locationapi-location_report_status
alias LOCATION_REPORT_STATUS = int;
enum : int
{
    REPORT_NOT_SUPPORTED = 0x00000000,
    REPORT_ERROR         = 0x00000001,
    REPORT_ACCESS_DENIED = 0x00000002,
    REPORT_INITIALIZING  = 0x00000003,
    REPORT_RUNNING       = 0x00000004,
}

alias GNSS_DRIVERCOMMAND_TYPE = int;
enum : int
{
    GNSS_SetLocationServiceEnabled   = 0x00000001,
    GNSS_SetLocationNIRequestAllowed = 0x00000002,
    GNSS_ForceSatelliteSystem        = 0x00000003,
    GNSS_ForceOperationMode          = 0x00000004,
    GNSS_ResetEngine                 = 0x00000009,
    GNSS_ClearAgnssData              = 0x0000000a,
    GNSS_SetSuplVersion              = 0x0000000c,
    GNSS_SetNMEALogging              = 0x0000000d,
    GNSS_SetUplServerAccessInterval  = 0x0000000e,
    GNSS_SetNiTimeoutInterval        = 0x0000000f,
    GNSS_ResetGeofencesTracking      = 0x00000010,
    GNSS_SetSuplVersion2             = 0x00000011,
    GNSS_CustomCommand               = 0x00000100,
}

alias GNSS_FIXSESSIONTYPE = int;
enum : int
{
    GNSS_FixSession_SingleShot         = 0x00000001,
    GNSS_FixSession_DistanceTracking   = 0x00000002,
    GNSS_FixSession_ContinuousTracking = 0x00000003,
    GNSS_FixSession_LKG                = 0x00000004,
}

alias GNSS_GEOREGIONTYPE = int;
enum : int
{
    GNSS_GeoRegion_Circle = 0x00000001,
}

alias GNSS_GEOFENCE_STATE = int;
enum : int
{
    GNSS_GeofenceState_Unknown = 0x00000000,
    GNSS_GeofenceState_Entered = 0x00000001,
    GNSS_GeofenceState_Exited  = 0x00000002,
}

alias GNSS_EVENT_TYPE = int;
enum : int
{
    GNSS_Event_FixAvailable            = 0x00000001,
    GNSS_Event_RequireAgnss            = 0x00000002,
    GNSS_Event_Error                   = 0x00000003,
    GNSS_Event_NiRequest               = 0x0000000c,
    GNSS_Event_NmeaData                = 0x0000000d,
    GNSS_Event_GeofenceAlertData       = 0x0000000e,
    GNSS_Event_GeofencesTrackingStatus = 0x0000000f,
    GNSS_Event_DriverRequest           = 0x00000010,
    GNSS_Event_BreadcrumbAlertEvent    = 0x00000011,
    GNSS_Event_FixAvailable_2          = 0x00000012,
    GNSS_Event_Custom                  = 0x00008000,
}

alias GNSS_AGNSS_REQUEST_TYPE = int;
enum : int
{
    GNSS_AGNSS_TimeInjection     = 0x00000001,
    GNSS_AGNSS_PositionInjection = 0x00000002,
    GNSS_AGNSS_BlobInjection     = 0x00000003,
}

alias GNSS_NI_PLANE_TYPE = int;
enum : int
{
    GNSS_NI_SUPL  = 0x00000001,
    GNSS_NI_CP    = 0x00000002,
    GNSS_NI_V2UPL = 0x00000003,
}

alias GNSS_NI_REQUEST_TYPE = int;
enum : int
{
    GNSS_NI_Request_SingleShot  = 0x00000001,
    GNSS_NI_Request_AreaTrigger = 0x00000002,
}

alias GNSS_NI_NOTIFICATION_TYPE = int;
enum : int
{
    GNSS_NI_NoNotifyNoVerify            = 0x00000001,
    GNSS_NI_NotifyOnly                  = 0x00000002,
    GNSS_NI_NotifyVerifyDefaultAllow    = 0x00000003,
    GNSS_NI_NotifyVerifyDefaultNotAllow = 0x00000004,
    GNSS_NI_PrivacyOverride             = 0x00000005,
}

alias GNSS_DRIVER_REQUEST = int;
enum : int
{
    SUPL_CONFIG_DATA = 0x00000001,
}

alias GNSS_SUPL_CERT_ACTION = int;
enum : int
{
    GNSS_Supl_Cert_Inject = 0x00000001,
    GNSS_Supl_Cert_Delete = 0x00000002,
    GNSS_Supl_Cert_Purge  = 0x00000003,
}

alias GNSS_NI_USER_RESPONSE = int;
enum : int
{
    GNSS_Ni_UserResponseAccept  = 0x00000001,
    GNSS_Ni_UserResponseDeny    = 0x00000002,
    GNSS_Ni_UserResponseTimeout = 0x00000003,
}

// Constants


enum : uint
{
    GNSS_DRIVER_VERSION_1 = 0x00000001U,
    GNSS_DRIVER_VERSION_2 = 0x00000002U,
    GNSS_DRIVER_VERSION_3 = 0x00000003U,
    GNSS_DRIVER_VERSION_4 = 0x00000004U,
    GNSS_DRIVER_VERSION_5 = 0x00000005U,
    GNSS_DRIVER_VERSION_6 = 0x00000006U,
}

enum uint IOCTL_GNSS_SEND_PLATFORM_CAPABILITY = 0x00220004U;
enum uint IOCTL_GNSS_GET_DEVICE_CAPABILITY = 0x00220008U;

enum : uint
{
    IOCTL_GNSS_SEND_DRIVERCOMMAND = 0x0022000cU,
    IOCTL_GNSS_START_FIXSESSION   = 0x00220040U,
    IOCTL_GNSS_MODIFY_FIXSESSION  = 0x00220044U,
}

enum : uint
{
    IOCTL_GNSS_STOP_FIXSESSION                 = 0x00220048U,
    IOCTL_GNSS_GET_FIXDATA                     = 0x0022004cU,
    IOCTL_GNSS_INJECT_AGNSS                    = 0x00220080U,
    IOCTL_GNSS_LISTEN_AGNSS                    = 0x002200c0U,
    IOCTL_GNSS_LISTEN_ERROR                    = 0x002200c4U,
    IOCTL_GNSS_LISTEN_NI                       = 0x00220100U,
    IOCTL_GNSS_SET_SUPL_HSLP                   = 0x00220104U,
    IOCTL_GNSS_CONFIG_SUPL_CERT                = 0x00220108U,
    IOCTL_GNSS_RESPOND_NI                      = 0x0022010cU,
    IOCTL_GNSS_EXECUTE_CWTEST                  = 0x00220110U,
    IOCTL_GNSS_EXECUTE_SELFTEST                = 0x00220114U,
    IOCTL_GNSS_GET_CHIPSETINFO                 = 0x00220118U,
    IOCTL_GNSS_LISTEN_NMEA                     = 0x0022011cU,
    IOCTL_GNSS_SET_V2UPL_CONFIG                = 0x00220120U,
    IOCTL_GNSS_CREATE_GEOFENCE                 = 0x00220140U,
    IOCTL_GNSS_DELETE_GEOFENCE                 = 0x00220144U,
    IOCTL_GNSS_LISTEN_GEOFENCE_ALERT           = 0x00220148U,
    IOCTL_GNSS_LISTEN_GEOFENCES_TRACKINGSTATUS = 0x0022014cU,
    IOCTL_GNSS_LISTEN_DRIVER_REQUEST           = 0x00220180U,
}

enum : uint
{
    IOCTL_GNSS_START_BREADCRUMBING = 0x002201c0U,
    IOCTL_GNSS_STOP_BREADCRUMBING  = 0x002201c4U,
}

enum uint IOCTL_GNSS_LISTEN_BREADCRUMBING_ALERT = 0x002201c8U;
enum uint IOCTL_GNSS_POP_BREADCRUMBS = 0x002201ccU;

enum : uint
{
    GNSS_AGNSSFORMAT_XTRA1    = 0x00000001U,
    GNSS_AGNSSFORMAT_XTRA2    = 0x00000002U,
    GNSS_AGNSSFORMAT_LTO      = 0x00000004U,
    GNSS_AGNSSFORMAT_XTRA3    = 0x00000008U,
    GNSS_AGNSSFORMAT_XTRA3_1  = 0x00000010U,
    GNSS_AGNSSFORMAT_XTRA3_2  = 0x00000020U,
    GNSS_AGNSSFORMAT_XTRA_INT = 0x00000040U,
}

enum uint MAX_SERVER_URL_NAME = 0x00000104U;
enum uint MIN_GEOFENCES_REQUIRED = 0x00000064U;

enum : uint
{
    BREADCRUMBING_UNSUPPORTED = 0x00000000U,
    BREADCRUMBING_VERSION_1   = 0x00000001U,
}

enum uint MIN_BREADCRUMBS_SUPPORTED = 0x00000078U;

enum : uint
{
    GNSS_SATELLITE_ANY     = 0x00000000U,
    GNSS_SATELLITE_GPS     = 0x00000001U,
    GNSS_SATELLITE_GLONASS = 0x00000002U,
    GNSS_SATELLITE_BEIDOU  = 0x00000004U,
    GNSS_SATELLITE_GALILEO = 0x00000008U,
}

enum : uint
{
    GNSS_OPERMODE_ANY    = 0x00000000U,
    GNSS_OPERMODE_MSA    = 0x00000001U,
    GNSS_OPERMODE_MSB    = 0x00000002U,
    GNSS_OPERMODE_MSS    = 0x00000004U,
    GNSS_OPERMODE_CELLID = 0x00000008U,
    GNSS_OPERMODE_AFLT   = 0x00000010U,
    GNSS_OPERMODE_OTDOA  = 0x00000020U,
}

enum : uint
{
    GNSS_NMEALOGGING_NONE = 0x00000000U,
    GNSS_NMEALOGGING_ALL  = 0x000000ffU,
}

enum : uint
{
    GNSS_FIXDETAIL_BASIC     = 0x00000001U,
    GNSS_FIXDETAIL_ACCURACY  = 0x00000002U,
    GNSS_FIXDETAIL_SATELLITE = 0x00000004U,
}

enum uint GNSS_MAXSATELLITE = 0x00000040U;

enum : uint
{
    GNSS_GEOFENCESUPPORT_SUPPORTED = 0x00000001U,
    GNSS_GEOFENCESUPPORT_CIRCLE    = 0x00000002U,
}

enum uint LOCATION_API_VERSION = 0x00000001U;
enum GUID GUID_DEVINTERFACE_GNSS = GUID("3336e5e4-018a-4669-84c5-bd05f3bd368b");

// Structs


struct GNSS_SUPL_VERSION
{
    uint MajorVersion;
    uint MinorVersion;
}

struct GNSS_SUPL_VERSION_2
{
    uint MajorVersion;
    uint MinorVersion;
    uint ServiceIndicator;
}

struct GNSS_DEVICE_CAPABILITY
{
    uint              Size;
    uint              Version;
    BOOL              SupportMultipleFixSessions;
    BOOL              SupportMultipleAppSessions;
    BOOL              RequireAGnssInjection;
    uint              AgnssFormatSupported;
    uint              AgnssFormatPreferred;
    BOOL              SupportDistanceTracking;
    BOOL              SupportContinuousTracking;
    uint              Reserved1;
    BOOL              Reserved2;
    BOOL              Reserved3;
    BOOL              Reserved4;
    BOOL              Reserved5;
    uint              GeofencingSupport;
    BOOL              Reserved6;
    BOOL              Reserved7;
    BOOL              SupportCpLocation;
    BOOL              SupportUplV2;
    BOOL              SupportSuplV1;
    BOOL              SupportSuplV2;
    GNSS_SUPL_VERSION SupportedSuplVersion;
    uint              MaxGeofencesSupported;
    BOOL              SupportMultipleSuplRootCert;
    uint              GnssBreadCrumbPayloadVersion;
    uint              MaxGnssBreadCrumbFixes;
    ubyte[496]        Unused;
}

struct GNSS_PLATFORM_CAPABILITY
{
    uint       Size;
    uint       Version;
    BOOL       SupportAgnssInjection;
    uint       AgnssFormatSupported;
    ubyte[516] Unused;
}

struct GNSS_DRIVERCOMMAND_PARAM
{
    uint       Size;
    uint       Version;
    GNSS_DRIVERCOMMAND_TYPE CommandType;
    uint       Reserved;
    uint       CommandDataSize;
    ubyte[512] Unused;
    ubyte[1]   CommandData; // Flexible array
}

struct GNSS_SINGLESHOT_PARAM
{
    uint Size;
    uint Version;
    uint ResponseTime;
}

struct GNSS_DISTANCETRACKING_PARAM
{
    uint Size;
    uint Version;
    uint MovementThreshold;
}

struct GNSS_CONTINUOUSTRACKING_PARAM
{
    uint Size;
    uint Version;
    uint PreferredInterval;
}

struct GNSS_LKGFIX_PARAM
{
    uint Size;
    uint Version;
}

struct GNSS_FIXSESSION_PARAM
{
    uint                Size;
    uint                Version;
    uint                FixSessionID;
    GNSS_FIXSESSIONTYPE SessionType;
    uint                HorizontalAccuracy;
    uint                HorizontalConfidence;
    uint[9]             Reserved;
    uint                FixLevelOfDetails;
    union
    {
        GNSS_SINGLESHOT_PARAM SingleShotParam;
        GNSS_DISTANCETRACKING_PARAM DistanceParam;
        GNSS_CONTINUOUSTRACKING_PARAM ContinuousParam;
        GNSS_LKGFIX_PARAM LkgFixParam;
        ubyte[268]        UnusedParam;
    }
    ubyte[256]          Unused;
}

struct GNSS_STOPFIXSESSION_PARAM
{
    uint       Size;
    uint       Version;
    uint       FixSessionID;
    ubyte[512] Unused;
}

struct GNSS_FIXDATA_BASIC
{
    uint   Size;
    uint   Version;
    double Latitude;
    double Longitude;
    double Altitude;
    double Speed;
    double Heading;
}

struct GNSS_FIXDATA_BASIC_2
{
    uint   Size;
    uint   Version;
    double Latitude;
    double Longitude;
    double Altitude;
    double Speed;
    double Heading;
    double AltitudeEllipsoid;
}

struct GNSS_FIXDATA_ACCURACY
{
    uint  Size;
    uint  Version;
    uint  HorizontalAccuracy;
    uint  HorizontalErrorMajorAxis;
    uint  HorizontalErrorMinorAxis;
    uint  HorizontalErrorAngle;
    uint  HeadingAccuracy;
    uint  AltitudeAccuracy;
    uint  SpeedAccuracy;
    uint  HorizontalConfidence;
    uint  HeadingConfidence;
    uint  AltitudeConfidence;
    uint  SpeedConfidence;
    float PositionDilutionOfPrecision;
    float HorizontalDilutionOfPrecision;
    float VerticalDilutionOfPrecision;
}

struct GNSS_FIXDATA_ACCURACY_2
{
    uint   Size;
    uint   Version;
    double HorizontalAccuracy;
    double HorizontalErrorMajorAxis;
    double HorizontalErrorMinorAxis;
    double HorizontalErrorAngle;
    double HeadingAccuracy;
    double AltitudeAccuracy;
    double SpeedAccuracy;
    uint   HorizontalConfidence;
    uint   HeadingConfidence;
    uint   AltitudeConfidence;
    uint   SpeedConfidence;
    double PositionDilutionOfPrecision;
    double HorizontalDilutionOfPrecision;
    double VerticalDilutionOfPrecision;
    double GeometricDilutionOfPrecision;
    double TimeDilutionOfPrecision;
}

struct GNSS_SATELLITEINFO
{
    uint   SatelliteId;
    BOOL   UsedInPositiong;
    double Elevation;
    double Azimuth;
    double SignalToNoiseRatio;
}

struct GNSS_FIXDATA_SATELLITE
{
    uint Size;
    uint Version;
    uint SatelliteCount;
    GNSS_SATELLITEINFO[64] SatelliteArray;
}

struct GNSS_FIXDATA
{
    uint               Size;
    uint               Version;
    uint               FixSessionID;
    FILETIME           FixTimeStamp;
    BOOL               IsFinalFix;
    NTSTATUS           FixStatus;
    uint               FixLevelOfDetails;
    GNSS_FIXDATA_BASIC BasicData;
    GNSS_FIXDATA_ACCURACY AccuracyData;
    GNSS_FIXDATA_SATELLITE SatelliteData;
}

struct GNSS_FIXDATA_2
{
    uint                 Size;
    uint                 Version;
    uint                 FixSessionID;
    FILETIME             FixTimeStamp;
    BOOL                 IsFinalFix;
    NTSTATUS             FixStatus;
    uint                 FixLevelOfDetails;
    GNSS_FIXDATA_BASIC_2 BasicData;
    GNSS_FIXDATA_ACCURACY_2 AccuracyData;
    GNSS_FIXDATA_SATELLITE SatelliteData;
}

struct GNSS_BREADCRUMBING_PARAM
{
    uint       Size;
    uint       Version;
    uint       MaximumHorizontalUncertainty;
    uint       MinDistanceBetweenFixes;
    uint       MaximumErrorTimeoutMs;
    ubyte[512] Unused;
}

struct GNSS_BREADCRUMBING_ALERT_DATA
{
    uint       Size;
    uint       Version;
    ubyte[512] Unused;
}

struct GNSS_BREADCRUMB_V1
{
    FILETIME FixTimeStamp;
    double   Latitude;
    double   Longitude;
    uint     HorizontalAccuracy;
    ushort   Speed;
    ushort   SpeedAccuracy;
    short    Altitude;
    ushort   AltitudeAccuracy;
    short    Heading;
    ubyte    HeadingAccuracy;
    ubyte    FixSuccess;
}

struct GNSS_BREADCRUMB_LIST
{
    uint Size;
    uint Version;
    uint NumCrumbs;
    union
    {
        GNSS_BREADCRUMB_V1[50] v1;
    }
}

struct GNSS_GEOREGION_CIRCLE
{
    double Latitude;
    double Longitude;
    double RadiusInMeters;
}

struct GNSS_GEOREGION
{
    uint               Size;
    uint               Version;
    GNSS_GEOREGIONTYPE GeoRegionType;
    union
    {
        GNSS_GEOREGION_CIRCLE Circle;
        ubyte[512] Unused;
    }
}

struct GNSS_GEOFENCE_CREATE_PARAM
{
    uint                Size;
    uint                Version;
    uint                AlertTypes;
    GNSS_GEOFENCE_STATE InitialState;
    GNSS_GEOREGION      Boundary;
    ubyte[512]          Unused;
}

struct GNSS_GEOFENCE_CREATE_RESPONSE
{
    uint       Size;
    uint       Version;
    NTSTATUS   CreationStatus;
    uint       GeofenceID;
    ubyte[512] Unused;
}

struct GNSS_GEOFENCE_DELETE_PARAM
{
    uint       Size;
    uint       Version;
    uint       GeofenceID;
    ubyte[512] Unused;
}

struct GNSS_GEOFENCE_ALERT_DATA
{
    uint                Size;
    uint                Version;
    uint                GeofenceID;
    GNSS_GEOFENCE_STATE GeofenceState;
    GNSS_FIXDATA_BASIC  FixBasicData;
    GNSS_FIXDATA_ACCURACY FixAccuracyData;
    ubyte[512]          Unused;
}

struct GNSS_GEOFENCES_TRACKINGSTATUS_DATA
{
    uint       Size;
    uint       Version;
    NTSTATUS   Status;
    FILETIME   StatusTimeStamp;
    ubyte[512] Unused;
}

struct GNSS_ERRORINFO
{
    uint       Size;
    uint       Version;
    uint       ErrorCode;
    BOOL       IsRecoverable;
    wchar[256] ErrorDescription;
    ubyte[512] Unused;
}

struct GNSS_NMEA_DATA
{
    uint      Size;
    uint      Version;
    CHAR[256] NmeaSentences;
}

struct GNSS_AGNSS_REQUEST_PARAM
{
    uint Size;
    uint Version;
    GNSS_AGNSS_REQUEST_TYPE RequestType;
    uint BlobFormat;
}

struct GNSS_SUPL_NI_INFO
{
    uint       Size;
    uint       Version;
    wchar[260] RequestorId;
    wchar[260] ClientName;
    CHAR[260]  SuplNiUrl;
}

struct GNSS_CP_NI_INFO
{
    uint       Size;
    uint       Version;
    wchar[260] RequestorId;
    wchar[260] NotificationText;
}

struct GNSS_V2UPL_NI_INFO
{
    uint       Size;
    uint       Version;
    wchar[260] RequestorId;
}

struct GNSS_NI_REQUEST_PARAM
{
    uint                 Size;
    uint                 Version;
    uint                 RequestId;
    GNSS_NI_REQUEST_TYPE RequestType;
    GNSS_NI_NOTIFICATION_TYPE NotificationType;
    GNSS_NI_PLANE_TYPE   RequestPlaneType;
    union
    {
        GNSS_SUPL_NI_INFO  SuplNiInfo;
        GNSS_CP_NI_INFO    CpNiInfo;
        GNSS_V2UPL_NI_INFO V2UplNiInfo;
    }
    uint                 ResponseTimeInSec;
    BOOL                 EmergencyLocation;
}

struct GNSS_DRIVER_REQUEST_DATA
{
    uint                Size;
    uint                Version;
    GNSS_DRIVER_REQUEST Request;
    uint                RequestFlag;
}

struct GNSS_EVENT
{
    uint            Size;
    uint            Version;
    GNSS_EVENT_TYPE EventType;
    uint            EventDataSize;
    ubyte[512]      Unused;
    union
    {
        GNSS_FIXDATA   FixData;
        GNSS_AGNSS_REQUEST_PARAM AgnssRequest;
        GNSS_NI_REQUEST_PARAM NiRequest;
        GNSS_ERRORINFO ErrorInformation;
        GNSS_NMEA_DATA NmeaData;
        GNSS_GEOFENCE_ALERT_DATA GeofenceAlertData;
        GNSS_BREADCRUMBING_ALERT_DATA BreadcrumbAlertData;
        GNSS_GEOFENCES_TRACKINGSTATUS_DATA GeofencesTrackingStatus;
        GNSS_DRIVER_REQUEST_DATA DriverRequestData;
        ubyte[1]       CustomData; // Flexible array
    }
}

struct GNSS_EVENT_2
{
    uint            Size;
    uint            Version;
    GNSS_EVENT_TYPE EventType;
    uint            EventDataSize;
    ubyte[512]      Unused;
    union
    {
        GNSS_FIXDATA   FixData;
        GNSS_FIXDATA_2 FixData2;
        GNSS_AGNSS_REQUEST_PARAM AgnssRequest;
        GNSS_NI_REQUEST_PARAM NiRequest;
        GNSS_ERRORINFO ErrorInformation;
        GNSS_NMEA_DATA NmeaData;
        GNSS_GEOFENCE_ALERT_DATA GeofenceAlertData;
        GNSS_BREADCRUMBING_ALERT_DATA BreadcrumbAlertData;
        GNSS_GEOFENCES_TRACKINGSTATUS_DATA GeofencesTrackingStatus;
        GNSS_DRIVER_REQUEST_DATA DriverRequestData;
        ubyte[1]       CustomData; // Flexible array
    }
}

struct GNSS_AGNSS_INJECTTIME
{
    uint     Size;
    uint     Version;
    FILETIME UtcTime;
    uint     TimeUncertainty;
}

struct GNSS_AGNSS_INJECTPOSITION
{
    uint               Size;
    uint               Version;
    uint               Age;
    GNSS_FIXDATA_BASIC BasicData;
    GNSS_FIXDATA_ACCURACY AccuracyData;
}

struct GNSS_AGNSS_INJECTBLOB
{
    uint     Size;
    uint     Version;
    uint     BlobOui;
    uint     BlobVersion;
    uint     AgnssFormat;
    uint     BlobSize;
    ubyte[1] BlobData; // Flexible array
}

struct GNSS_AGNSS_INJECT
{
    uint       Size;
    uint       Version;
    GNSS_AGNSS_REQUEST_TYPE InjectionType;
    NTSTATUS   InjectionStatus;
    uint       InjectionDataSize;
    ubyte[512] Unused;
    union
    {
        GNSS_AGNSS_INJECTTIME Time;
        GNSS_AGNSS_INJECTPOSITION Position;
        GNSS_AGNSS_INJECTBLOB BlobData;
    }
}

struct GNSS_SUPL_HSLP_CONFIG
{
    uint       Size;
    uint       Version;
    CHAR[260]  SuplHslp;
    CHAR[260]  SuplHslpFromImsi;
    uint       Reserved;
    ubyte[512] Unused;
}

struct GNSS_SUPL_CERT_CONFIG
{
    uint       Size;
    uint       Version;
    GNSS_SUPL_CERT_ACTION CertAction;
    CHAR[260]  SuplCertName;
    uint       CertSize;
    ubyte[512] Unused;
    ubyte[1]   CertData; // Flexible array
}

struct GNSS_V2UPL_CONFIG
{
    uint       Size;
    uint       Version;
    CHAR[260]  MPC;
    CHAR[260]  PDE;
    ubyte      ApplicationTypeIndicator_MR;
    ubyte[512] Unused;
}

struct GNSS_NI_RESPONSE
{
    uint Size;
    uint Version;
    uint RequestId;
    GNSS_NI_USER_RESPONSE UserResponse;
}

struct GNSS_CWTESTDATA
{
    uint       Size;
    uint       Version;
    NTSTATUS   TestResultStatus;
    double     SignalToNoiseRatio;
    double     Frequency;
    ubyte[512] Unused;
}

struct GNSS_SELFTESTCONFIG
{
    uint       Size;
    uint       Version;
    uint       TestType;
    ubyte[512] Unused;
    uint       InBufLen;
    ubyte[1]   InBuffer; // Flexible array
}

struct GNSS_SELFTESTRESULT
{
    uint       Size;
    uint       Version;
    NTSTATUS   TestResultStatus;
    uint       Result;
    uint       PinFailedBitMask;
    ubyte[512] Unused;
    uint       OutBufLen;
    ubyte[1]   OutBuffer; // Flexible array
}

struct GNSS_CHIPSETINFO
{
    uint       Size;
    uint       Version;
    wchar[25]  ManufacturerID;
    wchar[25]  HardwareID;
    wchar[20]  FirmwareVersion;
    ubyte[512] Unused;
}

// Interfaces

// Microsoft documentation: https://learn.microsoft.com/windows/win32/WMP/location-attribute
@GUID("e5b8e079-ee6d-4e33-a438-c87f2e959254")
struct Location;

@GUID("8b7fbfe0-5cd7-494a-af8c-283a65707506")
struct DefaultLocation;

@GUID("ed81c073-1f84-4ca8-a161-183c776bc651")
struct LatLongReport;

@GUID("d39e7bdd-7d05-46b8-8721-80cf035f57d7")
struct CivicAddressReport;

@GUID("9dcc3cc8-8609-4863-bad4-03601f4c65e8")
struct LatLongReportFactory;

@GUID("2a11f42c-3e81-4ad4-9cbe-45579d89671a")
struct CivicAddressReportFactory;

@GUID("7a7c3277-8f84-4636-95b2-ebb5507ff77e")
struct DispLatLongReport;

@GUID("4c596aec-8544-4082-ba9f-eb0a7d8e65c6")
struct DispCivicAddressReport;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nn-locationapi-ilocationreport
@GUID("c8b7f7ee-75d0-4db9-b62d-7a0f369ca456")
interface ILocationReport : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-ilocationreport-getsensorid
    HRESULT GetSensorID(GUID* pSensorID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-ilocationreport-gettimestamp
    HRESULT GetTimestamp(SYSTEMTIME* pCreationTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-ilocationreport-getvalue
    HRESULT GetValue(const(PROPERTYKEY)* pKey, PROPVARIANT* pValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nn-locationapi-ilatlongreport
@GUID("7fed806d-0ef8-4f07-80ac-36a0beae3134")
interface ILatLongReport : ILocationReport
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-ilatlongreport-getlatitude
    HRESULT GetLatitude(double* pLatitude);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-ilatlongreport-getlongitude
    HRESULT GetLongitude(double* pLongitude);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-ilatlongreport-geterrorradius
    HRESULT GetErrorRadius(double* pErrorRadius);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-ilatlongreport-getaltitude
    HRESULT GetAltitude(double* pAltitude);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-ilatlongreport-getaltitudeerror
    HRESULT GetAltitudeError(double* pAltitudeError);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nn-locationapi-icivicaddressreport
@GUID("c0b19f70-4adf-445d-87f2-cad8fd711792")
interface ICivicAddressReport : ILocationReport
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-icivicaddressreport-getaddressline1
    HRESULT GetAddressLine1(BSTR* pbstrAddress1);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-icivicaddressreport-getaddressline2
    HRESULT GetAddressLine2(BSTR* pbstrAddress2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-icivicaddressreport-getcity
    HRESULT GetCity(BSTR* pbstrCity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-icivicaddressreport-getstateprovince
    HRESULT GetStateProvince(BSTR* pbstrStateProvince);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-icivicaddressreport-getpostalcode
    HRESULT GetPostalCode(BSTR* pbstrPostalCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-icivicaddressreport-getcountryregion
    HRESULT GetCountryRegion(BSTR* pbstrCountryRegion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-icivicaddressreport-getdetaillevel
    HRESULT GetDetailLevel(uint* pDetailLevel);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nn-locationapi-ilocation
@GUID("ab2ece69-56d9-4f28-b525-de1b0ee44237")
interface ILocation : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-ilocation-registerforreport
    HRESULT RegisterForReport(ILocationEvents pEvents, const(GUID)* reportType, uint dwRequestedReportInterval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-ilocation-unregisterforreport
    HRESULT UnregisterForReport(const(GUID)* reportType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-ilocation-getreport
    HRESULT GetReport(const(GUID)* reportType, ILocationReport* ppLocationReport);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-ilocation-getreportstatus
    HRESULT GetReportStatus(const(GUID)* reportType, LOCATION_REPORT_STATUS* pStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-ilocation-getreportinterval
    HRESULT GetReportInterval(const(GUID)* reportType, uint* pMilliseconds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-ilocation-setreportinterval
    HRESULT SetReportInterval(const(GUID)* reportType, uint millisecondsRequested);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-ilocation-getdesiredaccuracy
    HRESULT GetDesiredAccuracy(const(GUID)* reportType, LOCATION_DESIRED_ACCURACY* pDesiredAccuracy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-ilocation-setdesiredaccuracy
    HRESULT SetDesiredAccuracy(const(GUID)* reportType, LOCATION_DESIRED_ACCURACY desiredAccuracy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-ilocation-requestpermissions
    HRESULT RequestPermissions(HWND hParent, GUID* pReportTypes, uint count, BOOL fModal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nn-locationapi-ilocationpower
@GUID("193e7729-ab6b-4b12-8617-7596e1bb191c")
interface ILocationPower : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-ilocationpower-connect
    HRESULT Connect();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-ilocationpower-disconnect
    HRESULT Disconnect();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nn-locationapi-idefaultlocation
@GUID("a65af77e-969a-4a2e-8aca-33bb7cbb1235")
interface IDefaultLocation : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-idefaultlocation-setreport
    HRESULT SetReport(const(GUID)* reportType, ILocationReport pLocationReport);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-idefaultlocation-getreport
    HRESULT GetReport(const(GUID)* reportType, ILocationReport* ppLocationReport);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nn-locationapi-ilocationevents
@GUID("cae02bbf-798b-4508-a207-35a7906dc73d")
interface ILocationEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-ilocationevents-onlocationchanged
    HRESULT OnLocationChanged(const(GUID)* reportType, ILocationReport pLocationReport);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/locationapi/nf-locationapi-ilocationevents-onstatuschanged
    HRESULT OnStatusChanged(const(GUID)* reportType, LOCATION_REPORT_STATUS newStatus);
}

@GUID("8ae32723-389b-4a11-9957-5bdd48fc9617")
interface IDispLatLongReport : IDispatch
{
    HRESULT get_Latitude(double* pVal);
    HRESULT get_Longitude(double* pVal);
    HRESULT get_ErrorRadius(double* pVal);
    HRESULT get_Altitude(double* pVal);
    HRESULT get_AltitudeError(double* pVal);
    HRESULT get_Timestamp(double* pVal);
}

@GUID("16ff1a34-9e30-42c3-b44d-e22513b5767a")
interface IDispCivicAddressReport : IDispatch
{
    HRESULT get_AddressLine1(BSTR* pAddress1);
    HRESULT get_AddressLine2(BSTR* pAddress2);
    HRESULT get_City(BSTR* pCity);
    HRESULT get_StateProvince(BSTR* pStateProvince);
    HRESULT get_PostalCode(BSTR* pPostalCode);
    HRESULT get_CountryRegion(BSTR* pCountryRegion);
    HRESULT get_DetailLevel(uint* pDetailLevel);
    HRESULT get_Timestamp(double* pVal);
}

@GUID("2daec322-90b2-47e4-bb08-0da841935a6b")
interface ILocationReportFactory : IDispatch
{
    HRESULT ListenForReports(uint requestedReportInterval);
    HRESULT StopListeningForReports();
    HRESULT get_Status(uint* pVal);
    HRESULT get_ReportInterval(uint* pMilliseconds);
    HRESULT put_ReportInterval(uint millisecondsRequested);
    HRESULT get_DesiredAccuracy(uint* pDesiredAccuracy);
    HRESULT put_DesiredAccuracy(uint desiredAccuracy);
    HRESULT RequestPermissions(uint* hWnd);
}

@GUID("3f0804cb-b114-447d-83dd-390174ebb082")
interface ILatLongReportFactory : ILocationReportFactory
{
    HRESULT get_LatLongReport(IDispLatLongReport* pVal);
}

@GUID("bf773b93-c64f-4bee-beb2-67c0b8df66e0")
interface ICivicAddressReportFactory : ILocationReportFactory
{
    HRESULT get_CivicAddressReport(IDispCivicAddressReport* pVal);
}

@GUID("16ee6cb7-ab3c-424b-849f-269be551fcbc")
interface _ILatLongReportFactoryEvents : IDispatch
{
}

@GUID("c96039ff-72ec-4617-89bd-84d88bedc722")
interface _ICivicAddressReportFactoryEvents : IDispatch
{
}


// GUIDs

const GUID CLSID_CivicAddressReport        = GUIDOF!CivicAddressReport;
const GUID CLSID_CivicAddressReportFactory = GUIDOF!CivicAddressReportFactory;
const GUID CLSID_DefaultLocation           = GUIDOF!DefaultLocation;
const GUID CLSID_DispCivicAddressReport    = GUIDOF!DispCivicAddressReport;
const GUID CLSID_DispLatLongReport         = GUIDOF!DispLatLongReport;
const GUID CLSID_LatLongReport             = GUIDOF!LatLongReport;
const GUID CLSID_LatLongReportFactory      = GUIDOF!LatLongReportFactory;
const GUID CLSID_Location                  = GUIDOF!Location;

const GUID IID_ICivicAddressReport               = GUIDOF!ICivicAddressReport;
const GUID IID_ICivicAddressReportFactory        = GUIDOF!ICivicAddressReportFactory;
const GUID IID_IDefaultLocation                  = GUIDOF!IDefaultLocation;
const GUID IID_IDispCivicAddressReport           = GUIDOF!IDispCivicAddressReport;
const GUID IID_IDispLatLongReport                = GUIDOF!IDispLatLongReport;
const GUID IID_ILatLongReport                    = GUIDOF!ILatLongReport;
const GUID IID_ILatLongReportFactory             = GUIDOF!ILatLongReportFactory;
const GUID IID_ILocation                         = GUIDOF!ILocation;
const GUID IID_ILocationEvents                   = GUIDOF!ILocationEvents;
const GUID IID_ILocationPower                    = GUIDOF!ILocationPower;
const GUID IID_ILocationReport                   = GUIDOF!ILocationReport;
const GUID IID_ILocationReportFactory            = GUIDOF!ILocationReportFactory;
const GUID IID__ICivicAddressReportFactoryEvents = GUIDOF!_ICivicAddressReportFactoryEvents;
const GUID IID__ILatLongReportFactoryEvents      = GUIDOF!_ILatLongReportFactoryEvents;
