// Written in the D programming language.

module windows.win32.networking.deliveryoptimization;

public import windows.core;
public import windows.win32.foundation.foundation : HRESULT, PWSTR;
public import windows.win32.system.com.com : IEnumUnknown, IUnknown;
public import windows.win32.system.variant : VARIANT;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deliveryoptimization/ne-deliveryoptimization-dodownloadstate
enum DODownloadState : int
{
    DODownloadState_Created      = 0x00000000,
    DODownloadState_Transferring = 0x00000001,
    DODownloadState_Transferred  = 0x00000002,
    DODownloadState_Finalized    = 0x00000003,
    DODownloadState_Aborted      = 0x00000004,
    DODownloadState_Paused       = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deliveryoptimization/ne-deliveryoptimization-dodownloadcostpolicy
enum DODownloadCostPolicy : int
{
    DODownloadCostPolicy_Always       = 0x00000000,
    DODownloadCostPolicy_Unrestricted = 0x00000001,
    DODownloadCostPolicy_Standard     = 0x00000002,
    DODownloadCostPolicy_NoRoaming    = 0x00000003,
    DODownloadCostPolicy_NoSurcharge  = 0x00000004,
    DODownloadCostPolicy_NoCellular   = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deliveryoptimization/ne-deliveryoptimization-dodownloadproperty
enum DODownloadProperty : int
{
    DODownloadProperty_Id                                 = 0x00000000,
    DODownloadProperty_Uri                                = 0x00000001,
    DODownloadProperty_ContentId                          = 0x00000002,
    DODownloadProperty_DisplayName                        = 0x00000003,
    DODownloadProperty_LocalPath                          = 0x00000004,
    DODownloadProperty_HttpCustomHeaders                  = 0x00000005,
    DODownloadProperty_CostPolicy                         = 0x00000006,
    DODownloadProperty_SecurityFlags                      = 0x00000007,
    DODownloadProperty_CallbackFreqPercent                = 0x00000008,
    DODownloadProperty_CallbackFreqSeconds                = 0x00000009,
    DODownloadProperty_NoProgressTimeoutSeconds           = 0x0000000a,
    DODownloadProperty_ForegroundPriority                 = 0x0000000b,
    DODownloadProperty_BlockingMode                       = 0x0000000c,
    DODownloadProperty_CallbackInterface                  = 0x0000000d,
    DODownloadProperty_StreamInterface                    = 0x0000000e,
    DODownloadProperty_SecurityContext                    = 0x0000000f,
    DODownloadProperty_NetworkToken                       = 0x00000010,
    DODownloadProperty_CorrelationVector                  = 0x00000011,
    DODownloadProperty_DecryptionInfo                     = 0x00000012,
    DODownloadProperty_IntegrityCheckInfo                 = 0x00000013,
    DODownloadProperty_IntegrityCheckMandatory            = 0x00000014,
    DODownloadProperty_TotalSizeBytes                     = 0x00000015,
    DODownloadProperty_DisallowOnCellular                 = 0x00000016,
    DODownloadProperty_HttpCustomAuthHeaders              = 0x00000017,
    DODownloadProperty_HttpAllowSecureToNonSecureRedirect = 0x00000018,
    DODownloadProperty_NonVolatile                        = 0x00000019,
    DODownloadProperty_HttpRedirectionTarget              = 0x0000001a,
    DODownloadProperty_HttpResponseHeaders                = 0x0000001b,
    DODownloadProperty_HttpServerIPAddress                = 0x0000001c,
    DODownloadProperty_HttpStatusCode                     = 0x0000001d,
}

// Constants


enum : const(wchar)*
{
    DecryptionInfo_KeyData              = "KeyData",
    DecryptionInfo_EncryptionBufferSize = "EncryptionBufferSize",
    DecryptionInfo_AlgorithmName        = "AlgorithmName",
    DecryptionInfo_ChainingMode         = "ChainingMode",
}

enum : const(wchar)*
{
    IntegrityCheckInfo_PiecesHashFileUrl             = "PiecesHashFileUrl",
    IntegrityCheckInfo_PiecesHashFileDigest          = "PiecesHashFileDigest",
    IntegrityCheckInfo_PiecesHashFileDigestAlgorithm = "PiecesHashFileDigestAlgorithm",
}

enum const(wchar)* IntegrityCheckInfo_HashOfHashes = "HashOfHashes";

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deliveryoptimization/ns-deliveryoptimization-do_download_range
struct DO_DOWNLOAD_RANGE
{
    ulong Offset;
    ulong Length;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deliveryoptimization/ns-deliveryoptimization-do_download_ranges_info
struct DO_DOWNLOAD_RANGES_INFO
{
    uint RangeCount;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DO_DOWNLOAD_RANGE[1] Ranges;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deliveryoptimization/ns-deliveryoptimization-do_download_status
struct DO_DOWNLOAD_STATUS
{
    ulong           BytesTotal;
    ulong           BytesTransferred;
    DODownloadState State;
    HRESULT         Error;
    HRESULT         ExtendedError;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deliveryoptimization/ns-deliveryoptimization-do_download_enum_category
struct DO_DOWNLOAD_ENUM_CATEGORY
{
    DODownloadProperty Property;
    const(PWSTR)       Value;
}

// Interfaces

@GUID("5b99fa76-721c-423c-adac-56d03c8a8007")
struct DeliveryOptimization;

@GUID("fbbd7fc0-c147-4727-a38d-827ef071ee77")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deliveryoptimization/nn-deliveryoptimization-idodownload
interface IDODownload : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deliveryoptimization/nf-deliveryoptimization-idodownload-start
    HRESULT Start(const(DO_DOWNLOAD_RANGES_INFO)* ranges);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deliveryoptimization/nf-deliveryoptimization-idodownload-pause
    HRESULT Pause();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deliveryoptimization/nf-deliveryoptimization-idodownload-abort
    HRESULT Abort();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deliveryoptimization/nf-deliveryoptimization-idodownload-finalize
    HRESULT Finalize();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deliveryoptimization/nf-deliveryoptimization-idodownload-getstatus
    HRESULT GetStatus(DO_DOWNLOAD_STATUS* status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deliveryoptimization/nf-deliveryoptimization-idodownload-getproperty
    HRESULT GetProperty(DODownloadProperty propId, VARIANT* propVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deliveryoptimization/nf-deliveryoptimization-idodownload-setproperty
    HRESULT SetProperty(DODownloadProperty propId, const(VARIANT)* propVal);
}

@GUID("d166e8e3-a90e-4392-8e87-05e996d3747d")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deliveryoptimization/nn-deliveryoptimization-idodownloadstatuscallback
interface IDODownloadStatusCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deliveryoptimization/nf-deliveryoptimization-idodownloadstatuscallback-onstatuschange
    HRESULT OnStatusChange(IDODownload download, const(DO_DOWNLOAD_STATUS)* status);
}

@GUID("400e2d4a-1431-4c1a-a748-39ca472cfdb1")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deliveryoptimization/nn-deliveryoptimization-idomanager
interface IDOManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deliveryoptimization/nf-deliveryoptimization-idomanager-createdownload
    HRESULT CreateDownload(IDODownload* download);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deliveryoptimization/nf-deliveryoptimization-idomanager-enumdownloads
    HRESULT EnumDownloads(const(DO_DOWNLOAD_ENUM_CATEGORY)* category, IEnumUnknown* ppEnum);
}


// GUIDs

const GUID CLSID_DeliveryOptimization = GUIDOF!DeliveryOptimization;

const GUID IID_IDODownload               = GUIDOF!IDODownload;
const GUID IID_IDODownloadStatusCallback = GUIDOF!IDODownloadStatusCallback;
const GUID IID_IDOManager                = GUIDOF!IDOManager;
