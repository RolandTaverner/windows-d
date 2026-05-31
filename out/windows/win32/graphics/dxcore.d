// Written in the D programming language.

module windows.win32.graphics.dxcore;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : HRESULT, LUID, PWSTR;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/ne-dxcore_interface-dxcoreadapterproperty))], [])
enum DXCoreAdapterProperty : uint
{
    InstanceLuid                  = 0x00000000,
    DriverVersion                 = 0x00000001,
    DriverDescription             = 0x00000002,
    HardwareID                    = 0x00000003,
    KmdModelVersion               = 0x00000004,
    ComputePreemptionGranularity  = 0x00000005,
    GraphicsPreemptionGranularity = 0x00000006,
    DedicatedAdapterMemory        = 0x00000007,
    DedicatedSystemMemory         = 0x00000008,
    SharedSystemMemory            = 0x00000009,
    AcgCompatible                 = 0x0000000a,
    IsHardware                    = 0x0000000b,
    IsIntegrated                  = 0x0000000c,
    IsDetachable                  = 0x0000000d,
    HardwareIDParts               = 0x0000000e,
    PhysicalAdapterCount          = 0x0000000f,
    AdapterEngineCount            = 0x00000010,
    AdapterEngineName             = 0x00000011,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/ne-dxcore_interface-dxcoreadapterstate))], [])
enum DXCoreAdapterState : uint
{
    IsDriverUpdateInProgress                      = 0x00000000,
    AdapterMemoryBudget                           = 0x00000001,
    AdapterMemoryUsageBytes                       = 0x00000002,
    AdapterMemoryUsageByProcessBytes              = 0x00000003,
    AdapterEngineRunningTimeMicroseconds          = 0x00000004,
    AdapterEngineRunningTimeByProcessMicroseconds = 0x00000005,
    AdapterTemperatureCelsius                     = 0x00000006,
    AdapterInUseProcessCount                      = 0x00000007,
    AdapterInUseProcessSet                        = 0x00000008,
    AdapterEngineFrequencyHertz                   = 0x00000009,
    AdapterMemoryFrequencyHertz                   = 0x0000000a,
}
//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/ne-dxcore_interface-dxcoresegmentgroup))], [])
enum DXCoreSegmentGroup : uint
{
    Local    = 0x00000000,
    NonLocal = 0x00000001,
}
//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/ne-dxcore_interface-dxcorenotificationtype))], [])
enum DXCoreNotificationType : uint
{
    AdapterListStale                         = 0x00000000,
    AdapterNoLongerValid                     = 0x00000001,
    AdapterBudgetChange                      = 0x00000002,
    AdapterHardwareContentProtectionTeardown = 0x00000003,
}
//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/ne-dxcore_interface-dxcoreadapterpreference))], [])
enum DXCoreAdapterPreference : uint
{
    Hardware        = 0x00000000,
    MinimumPower    = 0x00000001,
    HighPerformance = 0x00000002,
}
//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])
enum DXCoreWorkload : uint
{
    Graphics        = 0x00000000,
    Compute         = 0x00000001,
    Media           = 0x00000002,
    MachineLearning = 0x00000003,
}
//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])
enum DXCoreRuntimeFilterFlags : uint
{
    None    = 0x00000000,
    D3D11   = 0x00000001,
    D3D12   = 0x00000002,
}
//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])
enum DXCoreHardwareTypeFilterFlags : uint
{
    None               = 0x00000000,
    GPU                = 0x00000001,
    ComputeAccelerator = 0x00000002,
    NPU                = 0x00000004,
    MediaAccelerator   = 0x00000008,
}
//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])
enum DXCoreMemoryType : uint
{
    Dedicated = 0x00000000,
    Shared    = 0x00000001,
}

// Constants


enum uint _FACDXCORE = 0x00000880;

enum : GUID
{
    DXCORE_ADAPTER_ATTRIBUTE_D3D11_GRAPHICS      = GUID("8c47866b-7583-450d-f0f0-6bada895af4b"),
    DXCORE_ADAPTER_ATTRIBUTE_D3D12_GRAPHICS      = GUID("0c9ece4d-2f6e-4f01-8c96-e89e331b47b1"),
    DXCORE_ADAPTER_ATTRIBUTE_D3D12_CORE_COMPUTE  = GUID("248e2800-a793-4724-abaa-23a6de1be090"),
    DXCORE_ADAPTER_ATTRIBUTE_D3D12_GENERIC_ML    = GUID("b71b0d41-1088-422f-a27c-0250b7d3a988"),
    DXCORE_ADAPTER_ATTRIBUTE_D3D12_GENERIC_MEDIA = GUID("8eb2c848-82f6-4b49-aa87-aecfcf0174c6"),
}

enum : GUID
{
    DXCORE_HARDWARE_TYPE_ATTRIBUTE_GPU                 = GUID("b69eb219-3ded-4464-979f-a00bd4687006"),
    DXCORE_HARDWARE_TYPE_ATTRIBUTE_COMPUTE_ACCELERATOR = GUID("e0b195da-58ef-4a22-90f1-1f28169cab8d"),
    DXCORE_HARDWARE_TYPE_ATTRIBUTE_NPU                 = GUID("d46140c4-add7-451b-9e56-06fe8c3b58ed"),
    DXCORE_HARDWARE_TYPE_ATTRIBUTE_MEDIA_ACCELERATOR   = GUID("66bdb96a-050b-44c7-a4fd-d144ce0ab443"),
}

// Callbacks

alias PFN_DXCORE_NOTIFICATION_CALLBACK = void function(DXCoreNotificationType notificationType, IUnknown object, 
                                                       void* context);

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/ns-dxcore_interface-dxcorehardwareid))], [])
struct DXCoreHardwareID
{
    uint vendorID;
    uint deviceID;
    uint subSysID;
    uint revision;
}

struct DXCoreHardwareIDParts
{
    uint vendorID;
    uint deviceID;
    uint subSystemID;
    uint subVendorID;
    uint revisionID;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/ns-dxcore_interface-dxcoreadaptermemorybudgetnodesegmentgroup))], [])
struct DXCoreAdapterMemoryBudgetNodeSegmentGroup
{
    uint               nodeIndex;
    DXCoreSegmentGroup segmentGroup;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/ns-dxcore_interface-dxcoreadaptermemorybudget))], [])
struct DXCoreAdapterMemoryBudget
{
    ulong budget;
    ulong currentUsage;
    ulong availableForReservation;
    ulong currentReservation;
}

struct DXCoreAdapterEngineIndex
{
    uint physicalAdapterIndex;
    uint engineIndex;
}

struct DXCoreEngineQueryInput
{
    DXCoreAdapterEngineIndex adapterEngineIndex;
    uint processId;
}

struct DXCoreEngineQueryOutput
{
    ulong runningTime;
    ubyte processQuerySucceeded;
}

struct DXCoreMemoryUsage
{
    ulong committed;
    ulong resident;
}

struct DXCoreMemoryQueryInput
{
    uint             physicalAdapterIndex;
    DXCoreMemoryType memoryType;
}

struct DXCoreProcessMemoryQueryInput
{
    uint             physicalAdapterIndex;
    DXCoreMemoryType memoryType;
    uint             processId;
}

struct DXCoreProcessMemoryQueryOutput
{
    DXCoreMemoryUsage memoryUsage;
    ubyte             processQuerySucceeded;
}

struct DXCoreAdapterProcessSetQueryInput
{
    uint  arraySize;
    uint* processIds;
}

struct DXCoreAdapterProcessSetQueryOutput
{
    uint processesWritten;
    uint processesTotal;
}

struct DXCoreEngineNamePropertyInput
{
    DXCoreAdapterEngineIndex adapterEngineIndex;
    uint  engineNameLength;
    PWSTR engineName;
}

struct DXCoreEngineNamePropertyOutput
{
    uint engineNameLength;
}

struct DXCoreFrequencyQueryOutput
{
    ulong frequency;
    ulong maxFrequency;
    ulong maxOverclockedFrequency;
}

// Functions

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/dxcore/dxcore/nf-dxcore-dxcorecreateadapterfactory))], [])
@DllImport("DXCORE.dll")
HRESULT DXCoreCreateAdapterFactory(const(GUID)* riid, void** ppvFactory);


// Interfaces

@GUID("f0db4c7f-fe5a-42a2-bd62-f2a6cf6fc83e")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/nn-dxcore_interface-idxcoreadapter))], [])
interface IDXCoreAdapter : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/nf-dxcore_interface-idxcoreadapter-isvalid))], [])
    bool    IsValid();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/nf-dxcore_interface-idxcoreadapter-isattributesupported))], [])
    bool    IsAttributeSupported(const(GUID)* attributeGUID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/nf-dxcore_interface-idxcoreadapter-ispropertysupported))], [])
    bool    IsPropertySupported(DXCoreAdapterProperty property);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/nf-dxcore_interface-idxcoreadapter-getproperty))], [])
    HRESULT GetProperty(DXCoreAdapterProperty property, size_t bufferSize, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* propertyData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/nf-dxcore_interface-idxcoreadapter-getpropertysize))], [])
    HRESULT GetPropertySize(DXCoreAdapterProperty property, size_t* bufferSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/nf-dxcore_interface-idxcoreadapter-isquerystatesupported))], [])
    bool    IsQueryStateSupported(DXCoreAdapterState property);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/nf-dxcore_interface-idxcoreadapter-querystate))], [])
    HRESULT QueryState(DXCoreAdapterState state, size_t inputStateDetailsSize, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* inputStateDetails, 
                       size_t outputBufferSize, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* outputBuffer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/nf-dxcore_interface-idxcoreadapter-issetstatesupported))], [])
    bool    IsSetStateSupported(DXCoreAdapterState property);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/nf-dxcore_interface-idxcoreadapter-setstate))], [])
    HRESULT SetState(DXCoreAdapterState state, size_t inputStateDetailsSize, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* inputStateDetails, 
                     size_t inputDataSize, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(void)* inputData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/nf-dxcore_interface-idxcoreadapter-getfactory))], [])
    HRESULT GetFactory(const(GUID)* riid, void** ppvFactory);
}

@GUID("a0783366-cfa3-43be-9d79-55b2da97c63c")
interface IDXCoreAdapter1 : IDXCoreAdapter
{
    HRESULT GetPropertyWithInput(DXCoreAdapterProperty property, size_t inputPropertyDetailsSize, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* inputPropertyDetails, 
                                 size_t outputBufferSize, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* outputBuffer);
}

@GUID("526c7776-40e9-459b-b711-f32ad76dfc28")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/nn-dxcore_interface-idxcoreadapterlist))], [])
interface IDXCoreAdapterList : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/nf-dxcore_interface-idxcoreadapterlist-getadapter))], [])
    HRESULT GetAdapter(uint index, const(GUID)* riid, void** ppvAdapter);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/nf-dxcore_interface-idxcoreadapterlist-getadaptercount))], [])
    uint    GetAdapterCount();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/nf-dxcore_interface-idxcoreadapterlist-isstale))], [])
    bool    IsStale();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/nf-dxcore_interface-idxcoreadapterlist-getfactory))], [])
    HRESULT GetFactory(const(GUID)* riid, void** ppvFactory);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/nf-dxcore_interface-idxcoreadapterlist-sort))], [])
    HRESULT Sort(uint numPreferences, const(DXCoreAdapterPreference)* preferences);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/nf-dxcore_interface-idxcoreadapterlist-isadapterpreferencesupported))], [])
    bool    IsAdapterPreferenceSupported(DXCoreAdapterPreference preference);
}

@GUID("78ee5945-c36e-4b13-a669-005dd11c0f06")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/nn-dxcore_interface-idxcoreadapterfactory))], [])
interface IDXCoreAdapterFactory : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/nf-dxcore_interface-idxcoreadapterfactory-createadapterlist))], [])
    HRESULT CreateAdapterList(uint numAttributes, const(GUID)* filterAttributes, const(GUID)* riid, 
                              void** ppvAdapterList);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/nf-dxcore_interface-idxcoreadapterfactory-getadapterbyluid))], [])
    HRESULT GetAdapterByLuid(const(LUID)* adapterLUID, const(GUID)* riid, void** ppvAdapter);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/nf-dxcore_interface-idxcoreadapterfactory-isnotificationtypesupported))], [])
    bool    IsNotificationTypeSupported(DXCoreNotificationType notificationType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/nf-dxcore_interface-idxcoreadapterfactory-registereventnotification))], [])
    HRESULT RegisterEventNotification(IUnknown dxCoreObject, DXCoreNotificationType notificationType, 
                                      PFN_DXCORE_NOTIFICATION_CALLBACK callbackFunction, void* callbackContext, 
                                      uint* eventCookie);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxcore_interface/nf-dxcore_interface-idxcoreadapterfactory-unregistereventnotification))], [])
    HRESULT UnregisterEventNotification(uint eventCookie);
}

@GUID("d5682e19-6d21-401c-827a-9a51a4ea35d7")
interface IDXCoreAdapterFactory1 : IDXCoreAdapterFactory
{
    HRESULT CreateAdapterListByWorkload(DXCoreWorkload workload, DXCoreRuntimeFilterFlags runtimeFilter, 
                                        DXCoreHardwareTypeFilterFlags hardwareTypeFilter, const(GUID)* riid, 
                                        void** ppvAdapterList);
}


// GUIDs


const GUID IID_IDXCoreAdapter         = GUIDOF!IDXCoreAdapter;
const GUID IID_IDXCoreAdapter1        = GUIDOF!IDXCoreAdapter1;
const GUID IID_IDXCoreAdapterFactory  = GUIDOF!IDXCoreAdapterFactory;
const GUID IID_IDXCoreAdapterFactory1 = GUIDOF!IDXCoreAdapterFactory1;
const GUID IID_IDXCoreAdapterList     = GUIDOF!IDXCoreAdapterList;
