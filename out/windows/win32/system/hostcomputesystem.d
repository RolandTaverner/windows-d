// Written in the D programming language.

module windows.win32.system.hostcomputesystem;

public import windows.core;
public import windows.win32.foundation : HANDLE, HRESULT, PWSTR;
public import windows.win32.security : SECURITY_DESCRIPTOR;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HCS_OPERATION_TYPE))], [])
alias HCS_OPERATION_TYPE = int;
enum : int
{
    HcsOperationTypeNone                 = 0xffffffff,
    HcsOperationTypeEnumerate            = 0x00000000,
    HcsOperationTypeCreate               = 0x00000001,
    HcsOperationTypeStart                = 0x00000002,
    HcsOperationTypeShutdown             = 0x00000003,
    HcsOperationTypePause                = 0x00000004,
    HcsOperationTypeResume               = 0x00000005,
    HcsOperationTypeSave                 = 0x00000006,
    HcsOperationTypeTerminate            = 0x00000007,
    HcsOperationTypeModify               = 0x00000008,
    HcsOperationTypeGetProperties        = 0x00000009,
    HcsOperationTypeCreateProcess        = 0x0000000a,
    HcsOperationTypeSignalProcess        = 0x0000000b,
    HcsOperationTypeGetProcessInfo       = 0x0000000c,
    HcsOperationTypeGetProcessProperties = 0x0000000d,
    HcsOperationTypeModifyProcess        = 0x0000000e,
    HcsOperationTypeCrash                = 0x0000000f,
    HcsOperationTypeLiveMigration        = 0x00000013,
    HcsOperationTypeReserved1            = 0x00000010,
    HcsOperationTypeReserved2            = 0x00000011,
    HcsOperationTypeReserved3            = 0x00000012,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HCS_EVENT_TYPE))], [])
alias HCS_EVENT_TYPE = int;
enum : int
{
    HcsEventInvalid                           = 0x00000000,
    HcsEventSystemExited                      = 0x00000001,
    HcsEventSystemCrashInitiated              = 0x00000002,
    HcsEventSystemCrashReport                 = 0x00000003,
    HcsEventSystemRdpEnhancedModeStateChanged = 0x00000004,
    HcsEventSystemSiloJobCreated              = 0x00000005,
    HcsEventSystemGuestConnectionClosed       = 0x00000006,
    HcsEventProcessExited                     = 0x00010000,
    HcsEventOperationCallback                 = 0x01000000,
    HcsEventServiceDisconnect                 = 0x02000000,
    HcsEventGroupVmLifecycle                  = 0x80000002,
    HcsEventGroupLiveMigration                = 0x80000003,
    HcsEventGroupOperationInfo                = 0xc0000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HCS_EVENT_OPTIONS))], [])
alias HCS_EVENT_OPTIONS = int;
enum : int
{
    HcsEventOptionNone                      = 0x00000000,
    HcsEventOptionEnableOperationCallbacks  = 0x00000001,
    HcsEventOptionEnableVmLifecycle         = 0x00000002,
    HcsEventOptionEnableLiveMigrationEvents = 0x00000004,
}
alias HCS_OPERATION_OPTIONS = int;
enum : int
{
    HcsOperationOptionNone           = 0x00000000,
    HcsOperationOptionProgressUpdate = 0x00000001,
    HcsOperationOptionReserved1      = 0x00000002,
}
alias HCS_RESOURCE_TYPE = int;
enum : int
{
    HcsResourceTypeNone      = 0x00000000,
    HcsResourceTypeFile      = 0x00000001,
    HcsResourceTypeJob       = 0x00000002,
    HcsResourceTypeComObject = 0x00000003,
    HcsResourceTypeSocket    = 0x00000004,
}
alias HCS_NOTIFICATION_FLAGS = int;
enum : int
{
    HcsNotificationFlagSuccess = 0x00000000,
    HcsNotificationFlagFailure = 0x80000000,
}
alias HCS_NOTIFICATIONS = int;
enum : int
{
    HcsNotificationInvalid                           = 0x00000000,
    HcsNotificationSystemExited                      = 0x00000001,
    HcsNotificationSystemCreateCompleted             = 0x00000002,
    HcsNotificationSystemStartCompleted              = 0x00000003,
    HcsNotificationSystemPauseCompleted              = 0x00000004,
    HcsNotificationSystemResumeCompleted             = 0x00000005,
    HcsNotificationSystemCrashReport                 = 0x00000006,
    HcsNotificationSystemSiloJobCreated              = 0x00000007,
    HcsNotificationSystemSaveCompleted               = 0x00000008,
    HcsNotificationSystemRdpEnhancedModeStateChanged = 0x00000009,
    HcsNotificationSystemShutdownFailed              = 0x0000000a,
    HcsNotificationSystemShutdownCompleted           = 0x0000000a,
    HcsNotificationSystemGetPropertiesCompleted      = 0x0000000b,
    HcsNotificationSystemModifyCompleted             = 0x0000000c,
    HcsNotificationSystemCrashInitiated              = 0x0000000d,
    HcsNotificationSystemGuestConnectionClosed       = 0x0000000e,
    HcsNotificationSystemOperationCompletion         = 0x0000000f,
    HcsNotificationSystemPassThru                    = 0x00000010,
    HcsNotificationOperationProgressUpdate           = 0x00000100,
    HcsNotificationProcessExited                     = 0x00010000,
    HcsNotificationServiceDisconnect                 = 0x01000000,
    HcsNotificationFlagsReserved                     = 0xf0000000,
}
alias HCS_CREATE_OPTIONS = int;
enum : int
{
    HcsCreateOptions_1 = 0x00010000,
}

// Callbacks

alias HCS_OPERATION_COMPLETION = void function(HCS_OPERATION operation, void* context);
alias HCS_EVENT_CALLBACK = void function(HCS_EVENT* event, void* context);
alias HCS_NOTIFICATION_CALLBACK = void function(uint notificationType, void* context, HRESULT notificationStatus, 
                                                const(PWSTR) notificationData);

// Structs


@RAIIFree!HcsCloseOperation
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HCS_OPERATION
{
    void* Value;
}

@RAIIFree!HcsCloseComputeSystem
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HCS_SYSTEM
{
    void* Value;
}

@RAIIFree!HcsCloseProcess
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HCS_PROCESS
{
    void* Value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HCS_EVENT))], [])
struct HCS_EVENT
{
    HCS_EVENT_TYPE Type;
    const(PWSTR)   EventData;
    HCS_OPERATION  Operation;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HCS_PROCESS_INFORMATION))], [])
struct HCS_PROCESS_INFORMATION
{
    uint   ProcessId;
    uint   Reserved;
    HANDLE StdInput;
    HANDLE StdOutput;
    HANDLE StdError;
}

struct HCS_CREATE_OPTIONS_1
{
    HCS_CREATE_OPTIONS   Version;
    HANDLE               UserToken;
    SECURITY_DESCRIPTOR* SecurityDescriptor;
    HCS_EVENT_OPTIONS    CallbackOptions;
    void*                CallbackContext;
    HCS_EVENT_CALLBACK   Callback;
}

// Functions

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsEnumerateComputeSystems))], [])
@DllImport("computecore.dll")
HRESULT HcsEnumerateComputeSystems(const(PWSTR) query, HCS_OPERATION operation);

@DllImport("computecore.dll")
HRESULT HcsEnumerateComputeSystemsInNamespace(const(PWSTR) idNamespace, const(PWSTR) query, 
                                              HCS_OPERATION operation);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsCreateOperation))], [])
@DllImport("computecore.dll")
HCS_OPERATION HcsCreateOperation(const(void)* context, HCS_OPERATION_COMPLETION callback);

@DllImport("computecore.dll")
HCS_OPERATION HcsCreateOperationWithNotifications(HCS_OPERATION_OPTIONS eventTypes, const(void)* context, 
                                                  HCS_EVENT_CALLBACK callback);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsCloseOperation))], [])
@DllImport("computecore.dll")
void HcsCloseOperation(HCS_OPERATION operation);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsGetOperationContext))], [])
@DllImport("computecore.dll")
void* HcsGetOperationContext(HCS_OPERATION operation);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsSetOperationContext))], [])
@DllImport("computecore.dll")
HRESULT HcsSetOperationContext(HCS_OPERATION operation, const(void)* context);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsGetComputeSystemFromOperation))], [])
@DllImport("computecore.dll")
HCS_SYSTEM HcsGetComputeSystemFromOperation(HCS_OPERATION operation);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsGetProcessFromOperation))], [])
@DllImport("computecore.dll")
HCS_PROCESS HcsGetProcessFromOperation(HCS_OPERATION operation);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsGetOperationType))], [])
@DllImport("computecore.dll")
HCS_OPERATION_TYPE HcsGetOperationType(HCS_OPERATION operation);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsGetOperationId))], [])
@DllImport("computecore.dll")
ulong HcsGetOperationId(HCS_OPERATION operation);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsGetOperationResult))], [])
@DllImport("computecore.dll")
HRESULT HcsGetOperationResult(HCS_OPERATION operation, PWSTR* resultDocument);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsGetOperationResultAndProcessInfo))], [])
@DllImport("computecore.dll")
HRESULT HcsGetOperationResultAndProcessInfo(HCS_OPERATION operation, HCS_PROCESS_INFORMATION* processInformation, 
                                            PWSTR* resultDocument);

@DllImport("computecore.dll")
HRESULT HcsAddResourceToOperation(HCS_OPERATION operation, HCS_RESOURCE_TYPE type, const(PWSTR) uri, HANDLE handle);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsGetProcessorCompatibilityFromSavedState))], [])
@DllImport("computecore.dll")
HRESULT HcsGetProcessorCompatibilityFromSavedState(const(PWSTR) RuntimeFileName, 
                                                   const(PWSTR)* ProcessorFeaturesString);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsWaitForOperationResult))], [])
@DllImport("computecore.dll")
HRESULT HcsWaitForOperationResult(HCS_OPERATION operation, uint timeoutMs, PWSTR* resultDocument);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsWaitForOperationResultAndProcessInfo))], [])
@DllImport("computecore.dll")
HRESULT HcsWaitForOperationResultAndProcessInfo(HCS_OPERATION operation, uint timeoutMs, 
                                                HCS_PROCESS_INFORMATION* processInformation, PWSTR* resultDocument);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsSetOperationCallback))], [])
@DllImport("computecore.dll")
HRESULT HcsSetOperationCallback(HCS_OPERATION operation, const(void)* context, HCS_OPERATION_COMPLETION callback);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsCancelOperation))], [])
@DllImport("computecore.dll")
HRESULT HcsCancelOperation(HCS_OPERATION operation);

@DllImport("computecore.dll")
HRESULT HcsGetOperationProperties(HCS_OPERATION operation, const(PWSTR) options, PWSTR* resultDocument);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/reference/HcsCreateComputeSystem))], [])
@DllImport("computecore.dll")
HRESULT HcsCreateComputeSystem(const(PWSTR) id, const(PWSTR) configuration, HCS_OPERATION operation, 
                               const(SECURITY_DESCRIPTOR)* securityDescriptor, HCS_SYSTEM* computeSystem);

@DllImport("computecore.dll")
HRESULT HcsCreateComputeSystemInNamespace(const(PWSTR) idNamespace, const(PWSTR) id, const(PWSTR) configuration, 
                                          HCS_OPERATION operation, const(HCS_CREATE_OPTIONS)* options, 
                                          HCS_SYSTEM* computeSystem);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/reference/HcsOpenComputeSystem))], [])
@DllImport("computecore.dll")
HRESULT HcsOpenComputeSystem(const(PWSTR) id, uint requestedAccess, HCS_SYSTEM* computeSystem);

@DllImport("computecore.dll")
HRESULT HcsOpenComputeSystemInNamespace(const(PWSTR) idNamespace, const(PWSTR) id, uint requestedAccess, 
                                        HCS_SYSTEM* computeSystem);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsCloseComputeSystem))], [])
@DllImport("computecore.dll")
void HcsCloseComputeSystem(HCS_SYSTEM computeSystem);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsStartComputeSystem))], [])
@DllImport("computecore.dll")
HRESULT HcsStartComputeSystem(HCS_SYSTEM computeSystem, HCS_OPERATION operation, const(PWSTR) options);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsShutDownComputeSystem))], [])
@DllImport("computecore.dll")
HRESULT HcsShutDownComputeSystem(HCS_SYSTEM computeSystem, HCS_OPERATION operation, const(PWSTR) options);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsTerminateComputeSystem))], [])
@DllImport("computecore.dll")
HRESULT HcsTerminateComputeSystem(HCS_SYSTEM computeSystem, HCS_OPERATION operation, const(PWSTR) options);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsCrashComputeSystem))], [])
@DllImport("computecore.dll")
HRESULT HcsCrashComputeSystem(HCS_SYSTEM computeSystem, HCS_OPERATION operation, const(PWSTR) options);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsPauseComputeSystem))], [])
@DllImport("computecore.dll")
HRESULT HcsPauseComputeSystem(HCS_SYSTEM computeSystem, HCS_OPERATION operation, const(PWSTR) options);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsResumeComputeSystem))], [])
@DllImport("computecore.dll")
HRESULT HcsResumeComputeSystem(HCS_SYSTEM computeSystem, HCS_OPERATION operation, const(PWSTR) options);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsSaveComputeSystem))], [])
@DllImport("computecore.dll")
HRESULT HcsSaveComputeSystem(HCS_SYSTEM computeSystem, HCS_OPERATION operation, const(PWSTR) options);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsGetComputeSystemProperties))], [])
@DllImport("computecore.dll")
HRESULT HcsGetComputeSystemProperties(HCS_SYSTEM computeSystem, HCS_OPERATION operation, 
                                      const(PWSTR) propertyQuery);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsModifyComputeSystem))], [])
@DllImport("computecore.dll")
HRESULT HcsModifyComputeSystem(HCS_SYSTEM computeSystem, HCS_OPERATION operation, const(PWSTR) configuration, 
                               HANDLE identity);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsWaitForComputeSystemExit))], [])
@DllImport("computecore.dll")
HRESULT HcsWaitForComputeSystemExit(HCS_SYSTEM computeSystem, uint timeoutMs, PWSTR* result);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsSetComputeSystemCallback))], [])
@DllImport("computecore.dll")
HRESULT HcsSetComputeSystemCallback(HCS_SYSTEM computeSystem, HCS_EVENT_OPTIONS callbackOptions, 
                                    const(void)* context, HCS_EVENT_CALLBACK callback);

@DllImport("computecore.dll")
HRESULT HcsInitializeLiveMigrationOnSource(HCS_SYSTEM computeSystem, HCS_OPERATION operation, const(PWSTR) options);

@DllImport("computecore.dll")
HRESULT HcsStartLiveMigrationOnSource(HCS_SYSTEM computeSystem, HCS_OPERATION operation, const(PWSTR) options);

@DllImport("computecore.dll")
HRESULT HcsStartLiveMigrationTransfer(HCS_SYSTEM computeSystem, HCS_OPERATION operation, const(PWSTR) options);

@DllImport("computecore.dll")
HRESULT HcsFinalizeLiveMigration(HCS_SYSTEM computeSystem, HCS_OPERATION operation, const(PWSTR) options);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsCreateProcess))], [])
@DllImport("computecore.dll")
HRESULT HcsCreateProcess(HCS_SYSTEM computeSystem, const(PWSTR) processParameters, HCS_OPERATION operation, 
                         const(SECURITY_DESCRIPTOR)* securityDescriptor, HCS_PROCESS* process);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsOpenProcess))], [])
@DllImport("computecore.dll")
HRESULT HcsOpenProcess(HCS_SYSTEM computeSystem, uint processId, uint requestedAccess, HCS_PROCESS* process);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsCloseProcess))], [])
@DllImport("computecore.dll")
void HcsCloseProcess(HCS_PROCESS process);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsTerminateProcess))], [])
@DllImport("computecore.dll")
HRESULT HcsTerminateProcess(HCS_PROCESS process, HCS_OPERATION operation, const(PWSTR) options);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsSignalProcess))], [])
@DllImport("computecore.dll")
HRESULT HcsSignalProcess(HCS_PROCESS process, HCS_OPERATION operation, const(PWSTR) options);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsGetProcessInfo))], [])
@DllImport("computecore.dll")
HRESULT HcsGetProcessInfo(HCS_PROCESS process, HCS_OPERATION operation);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsGetProcessProperties))], [])
@DllImport("computecore.dll")
HRESULT HcsGetProcessProperties(HCS_PROCESS process, HCS_OPERATION operation, const(PWSTR) propertyQuery);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsModifyProcess))], [])
@DllImport("computecore.dll")
HRESULT HcsModifyProcess(HCS_PROCESS process, HCS_OPERATION operation, const(PWSTR) settings);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsSetProcessCallback))], [])
@DllImport("computecore.dll")
HRESULT HcsSetProcessCallback(HCS_PROCESS process, HCS_EVENT_OPTIONS callbackOptions, void* context, 
                              HCS_EVENT_CALLBACK callback);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsWaitForProcessExit))], [])
@DllImport("computecore.dll")
HRESULT HcsWaitForProcessExit(HCS_PROCESS computeSystem, uint timeoutMs, PWSTR* result);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsGetServiceProperties))], [])
@DllImport("computecore.dll")
HRESULT HcsGetServiceProperties(const(PWSTR) propertyQuery, PWSTR* result);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsModifyServiceSettings))], [])
@DllImport("computecore.dll")
HRESULT HcsModifyServiceSettings(const(PWSTR) settings, PWSTR* result);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsSubmitWerReport))], [])
@DllImport("computecore.dll")
HRESULT HcsSubmitWerReport(const(PWSTR) settings);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsCreateEmptyGuestStateFile))], [])
@DllImport("computecore.dll")
HRESULT HcsCreateEmptyGuestStateFile(const(PWSTR) guestStateFilePath);

@DllImport("computecore.dll")
HRESULT HcsCreateEmptyRuntimeStateFile(const(PWSTR) runtimeStateFilePath);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsGrantVmAccess))], [])
@DllImport("computecore.dll")
HRESULT HcsGrantVmAccess(const(PWSTR) vmId, const(PWSTR) filePath);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsRevokeVmAccess))], [])
@DllImport("computecore.dll")
HRESULT HcsRevokeVmAccess(const(PWSTR) vmId, const(PWSTR) filePath);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsGrantVmGroupAccess))], [])
@DllImport("computecore.dll")
HRESULT HcsGrantVmGroupAccess(const(PWSTR) filePath);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsRevokeVmGroupAccess))], [])
@DllImport("computecore.dll")
HRESULT HcsRevokeVmGroupAccess(const(PWSTR) filePath);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsImportLayer))], [])
@DllImport("computestorage.dll")
HRESULT HcsImportLayer(const(PWSTR) layerPath, const(PWSTR) sourceFolderPath, const(PWSTR) layerData);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsExportLayer))], [])
@DllImport("computestorage.dll")
HRESULT HcsExportLayer(const(PWSTR) layerPath, const(PWSTR) exportFolderPath, const(PWSTR) layerData, 
                       const(PWSTR) options);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsExportLegacyWritableLayer))], [])
@DllImport("computestorage.dll")
HRESULT HcsExportLegacyWritableLayer(const(PWSTR) writableLayerMountPath, const(PWSTR) writableLayerFolderPath, 
                                     const(PWSTR) exportFolderPath, const(PWSTR) layerData);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsDestroyLayer))], [])
@DllImport("computestorage.dll")
HRESULT HcsDestroyLayer(const(PWSTR) layerPath);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsSetupBaseOSLayer))], [])
@DllImport("computestorage.dll")
HRESULT HcsSetupBaseOSLayer(const(PWSTR) layerPath, HANDLE vhdHandle, const(PWSTR) options);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsInitializeWritableLayer))], [])
@DllImport("computestorage.dll")
HRESULT HcsInitializeWritableLayer(const(PWSTR) writableLayerPath, const(PWSTR) layerData, const(PWSTR) options);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsInitializeLegacyWritableLayer))], [])
@DllImport("computestorage.dll")
HRESULT HcsInitializeLegacyWritableLayer(const(PWSTR) writableLayerMountPath, const(PWSTR) writableLayerFolderPath, 
                                         const(PWSTR) layerData, const(PWSTR) options);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsAttachLayerStorageFilter))], [])
@DllImport("computestorage.dll")
HRESULT HcsAttachLayerStorageFilter(const(PWSTR) layerPath, const(PWSTR) layerData);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsDetachLayerStorageFilter))], [])
@DllImport("computestorage.dll")
HRESULT HcsDetachLayerStorageFilter(const(PWSTR) layerPath);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsFormatWritableLayerVhd))], [])
@DllImport("computestorage.dll")
HRESULT HcsFormatWritableLayerVhd(HANDLE vhdHandle);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsGetLayerVhdMountPath))], [])
@DllImport("computestorage.dll")
HRESULT HcsGetLayerVhdMountPath(HANDLE vhdHandle, PWSTR* mountPath);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/virtualization/api/hcs/Reference/HcsSetupBaseOSVolume))], [])
@DllImport("computestorage.dll")
HRESULT HcsSetupBaseOSVolume(const(PWSTR) layerPath, const(PWSTR) volumePath, const(PWSTR) options);

@DllImport("computestorage.dll")
HRESULT HcsAttachOverlayFilter(const(PWSTR) VolumeMountPoint, const(PWSTR) LayerData);

@DllImport("computestorage.dll")
HRESULT HcsDetachOverlayFilter(const(PWSTR) VolumeMountPoint, const(PWSTR) LayerData);


