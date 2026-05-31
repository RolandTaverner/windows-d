// Written in the D programming language.

module windows.win32.system.updateassessment;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, FILETIME, HRESULT, PWSTR;
public import windows.win32.system.com.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/SysInfo/updateimpactlevel
enum UpdateImpactLevel : int
{
    UpdateImpactLevel_None   = 0x00000000,
    UpdateImpactLevel_Low    = 0x00000001,
    UpdateImpactLevel_Medium = 0x00000002,
    UpdateImpactLevel_High   = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SysInfo/updateassessmentstatus
enum UpdateAssessmentStatus : int
{
    UpdateAssessmentStatus_Latest                   = 0x00000000,
    UpdateAssessmentStatus_NotLatestSoftRestriction = 0x00000001,
    UpdateAssessmentStatus_NotLatestHardRestriction = 0x00000002,
    UpdateAssessmentStatus_NotLatestEndOfSupport    = 0x00000003,
    UpdateAssessmentStatus_NotLatestServicingTrain  = 0x00000004,
    UpdateAssessmentStatus_NotLatestDeferredFeature = 0x00000005,
    UpdateAssessmentStatus_NotLatestDeferredQuality = 0x00000006,
    UpdateAssessmentStatus_NotLatestPausedFeature   = 0x00000007,
    UpdateAssessmentStatus_NotLatestPausedQuality   = 0x00000008,
    UpdateAssessmentStatus_NotLatestManaged         = 0x00000009,
    UpdateAssessmentStatus_NotLatestUnknown         = 0x0000000a,
    UpdateAssessmentStatus_NotLatestTargetedVersion = 0x0000000b,
}

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/waasapitypes/ns-waasapitypes-updateassessment
struct UpdateAssessment
{
    UpdateAssessmentStatus status;
    UpdateImpactLevel impact;
    uint              daysOutOfDate;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/waasapitypes/ns-waasapitypes-osupdateassessment
struct OSUpdateAssessment
{
    BOOL             isEndOfSupport;
    UpdateAssessment assessmentForCurrent;
    UpdateAssessment assessmentForUpToDate;
    UpdateAssessmentStatus securityStatus;
    FILETIME         assessmentTime;
    FILETIME         releaseInfoTime;
    PWSTR            currentOSBuild;
    FILETIME         currentOSReleaseTime;
    PWSTR            upToDateOSBuild;
    FILETIME         upToDateOSReleaseTime;
}

struct CloudCampaignAssessment
{
    PWSTR name;
    PWSTR tool;
}

// Interfaces

@GUID("098ef871-fa9f-46af-8958-c083515d7c9c")
struct WaaSAssessor;

@GUID("2347bbef-1a3b-45a4-902d-3e09c269b45e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/waasapi/nn-waasapi-iwaasassessor
interface IWaaSAssessor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/waasapi/nf-waasapi-iwaasassessor-getosupdateassessment
    HRESULT GetOSUpdateAssessment(OSUpdateAssessment* result);
}


// GUIDs

const GUID CLSID_WaaSAssessor = GUIDOF!WaaSAssessor;

const GUID IID_IWaaSAssessor = GUIDOF!IWaaSAssessor;
