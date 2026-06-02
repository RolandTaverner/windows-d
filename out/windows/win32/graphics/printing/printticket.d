// Written in the D programming language.

module windows.win32.graphics.printing.printticket;

public import windows.core;
public import windows.win32.foundation : BSTR, HRESULT, PWSTR;
public import windows.win32.graphics.gdi : DEVMODEA;
public import windows.win32.system.com : IStream;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/prntvpt/ne-prntvpt-edefaultdevmodetype
enum EDefaultDevmodeType : int
{
    kUserDefaultDevmode    = 0x00000000,
    kPrinterDefaultDevmode = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/prntvpt/ne-prntvpt-eprintticketscope
enum EPrintTicketScope : int
{
    kPTPageScope     = 0x00000000,
    kPTDocumentScope = 0x00000001,
    kPTJobScope      = 0x00000002,
}

// Constants


enum uint PRINTTICKET_ISTREAM_APIS = 0x00000001U;
enum uint S_PT_NO_CONFLICT = 0x00040001U;
enum uint S_PT_CONFLICT_RESOLVED = 0x00040002U;
enum uint E_PRINTTICKET_FORMAT = 0x80040003U;
enum uint E_PRINTCAPABILITIES_FORMAT = 0x80040004U;
enum uint E_DELTA_PRINTTICKET_FORMAT = 0x80040005U;
enum uint E_PRINTDEVICECAPABILITIES_FORMAT = 0x80040006U;

// Structs


@RAIIFree!PTCloseProvider
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HPTPROVIDER
{
    void* Value;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("prntvpt.dll")
HRESULT PTQuerySchemaVersionSupport(const(PWSTR) pszPrinterName, uint* pMaxVersion);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("prntvpt.dll")
HRESULT PTOpenProvider(const(PWSTR) pszPrinterName, uint dwVersion, HPTPROVIDER* phProvider);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("prntvpt.dll")
HRESULT PTOpenProviderEx(const(PWSTR) pszPrinterName, uint dwMaxVersion, uint dwPrefVersion, 
                         HPTPROVIDER* phProvider, uint* pUsedVersion);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("prntvpt.dll")
HRESULT PTCloseProvider(HPTPROVIDER hProvider);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("prntvpt.dll")
HRESULT PTReleaseMemory(void* pBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("prntvpt.dll")
HRESULT PTGetPrintCapabilities(HPTPROVIDER hProvider, IStream pPrintTicket, IStream pCapabilities, 
                               BSTR* pbstrErrorMessage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
@DllImport("prntvpt.dll")
HRESULT PTGetPrintDeviceCapabilities(HPTPROVIDER hProvider, IStream pPrintTicket, IStream pDeviceCapabilities, 
                                     BSTR* pbstrErrorMessage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
@DllImport("prntvpt.dll")
HRESULT PTGetPrintDeviceResources(HPTPROVIDER hProvider, const(PWSTR) pszLocaleName, IStream pPrintTicket, 
                                  IStream pDeviceResources, BSTR* pbstrErrorMessage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("prntvpt.dll")
HRESULT PTMergeAndValidatePrintTicket(HPTPROVIDER hProvider, IStream pBaseTicket, IStream pDeltaTicket, 
                                      EPrintTicketScope scope_, IStream pResultTicket, BSTR* pbstrErrorMessage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("prntvpt.dll")
HRESULT PTConvertPrintTicketToDevMode(HPTPROVIDER hProvider, IStream pPrintTicket, 
                                      EDefaultDevmodeType baseDevmodeType, EPrintTicketScope scope_, 
                                      uint* pcbDevmode, DEVMODEA** ppDevmode, BSTR* pbstrErrorMessage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("prntvpt.dll")
HRESULT PTConvertDevModeToPrintTicket(HPTPROVIDER hProvider, uint cbDevmode, DEVMODEA* pDevmode, 
                                      EPrintTicketScope scope_, IStream pPrintTicket);


