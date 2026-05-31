// Written in the D programming language.

module windows.win32.devices.serialcommunication;

public import windows.core;
public import windows.win32.foundation.foundation : BOOL, BOOLEAN, DEVPROPKEY;

extern(Windows) @nogc nothrow:


// Enums


alias SERENUM_PORTION = int;
enum : int
{
    SerenumFirstHalf  = 0x00000000,
    SerenumSecondHalf = 0x00000001,
    SerenumWhole      = 0x00000002,
}

// Constants


enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1282142556, 19459, 19116, 145, 245, 100, 192, 248, 82, 188, 244}, 2))], [])*/DEVPROPKEY
{
    DEVPKEY_DeviceInterface_Serial_UsbVendorId  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1282142556, 19459, 19116, 145, 245, 100, 192, 248, 82, 188, 244}, 2))], [])*/DEVPROPKEY(GUID("4C6BF15C-4C03-4AAC-91F5-64C0F852BCF4"), 2),
    DEVPKEY_DeviceInterface_Serial_UsbProductId = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1282142556, 19459, 19116, 145, 245, 100, 192, 248, 82, 188, 244}, 2))], [])*/DEVPROPKEY(GUID("4C6BF15C-4C03-4AAC-91F5-64C0F852BCF4"), 3),
    DEVPKEY_DeviceInterface_Serial_PortName     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1282142556, 19459, 19116, 145, 245, 100, 192, 248, 82, 188, 244}, 2))], [])*/DEVPROPKEY(GUID("4C6BF15C-4C03-4AAC-91F5-64C0F852BCF4"), 4),
}

enum : uint
{
    IOCTL_SERIAL_SET_BAUD_RATE               = 0x001b0004U,
    IOCTL_SERIAL_SET_QUEUE_SIZE              = 0x001b0008U,
    IOCTL_SERIAL_SET_LINE_CONTROL            = 0x001b000cU,
    IOCTL_SERIAL_SET_BREAK_ON                = 0x001b0010U,
    IOCTL_SERIAL_SET_BREAK_OFF               = 0x001b0014U,
    IOCTL_SERIAL_IMMEDIATE_CHAR              = 0x001b0018U,
    IOCTL_SERIAL_SET_TIMEOUTS                = 0x001b001cU,
    IOCTL_SERIAL_GET_TIMEOUTS                = 0x001b0020U,
    IOCTL_SERIAL_SET_DTR                     = 0x001b0024U,
    IOCTL_SERIAL_CLR_DTR                     = 0x001b0028U,
    IOCTL_SERIAL_RESET_DEVICE                = 0x001b002cU,
    IOCTL_SERIAL_SET_RTS                     = 0x001b0030U,
    IOCTL_SERIAL_CLR_RTS                     = 0x001b0034U,
    IOCTL_SERIAL_SET_XOFF                    = 0x001b0038U,
    IOCTL_SERIAL_SET_XON                     = 0x001b003cU,
    IOCTL_SERIAL_GET_WAIT_MASK               = 0x001b0040U,
    IOCTL_SERIAL_SET_WAIT_MASK               = 0x001b0044U,
    IOCTL_SERIAL_WAIT_ON_MASK                = 0x001b0048U,
    IOCTL_SERIAL_PURGE                       = 0x001b004cU,
    IOCTL_SERIAL_GET_BAUD_RATE               = 0x001b0050U,
    IOCTL_SERIAL_GET_LINE_CONTROL            = 0x001b0054U,
    IOCTL_SERIAL_GET_CHARS                   = 0x001b0058U,
    IOCTL_SERIAL_SET_CHARS                   = 0x001b005cU,
    IOCTL_SERIAL_GET_HANDFLOW                = 0x001b0060U,
    IOCTL_SERIAL_SET_HANDFLOW                = 0x001b0064U,
    IOCTL_SERIAL_GET_MODEMSTATUS             = 0x001b0068U,
    IOCTL_SERIAL_GET_COMMSTATUS              = 0x001b006cU,
    IOCTL_SERIAL_XOFF_COUNTER                = 0x001b0070U,
    IOCTL_SERIAL_GET_PROPERTIES              = 0x001b0074U,
    IOCTL_SERIAL_GET_DTRRTS                  = 0x001b0078U,
    IOCTL_SERIAL_CONFIG_SIZE                 = 0x001b0080U,
    IOCTL_SERIAL_GET_COMMCONFIG              = 0x001b0084U,
    IOCTL_SERIAL_SET_COMMCONFIG              = 0x001b0088U,
    IOCTL_SERIAL_GET_STATS                   = 0x001b008cU,
    IOCTL_SERIAL_CLEAR_STATS                 = 0x001b0090U,
    IOCTL_SERIAL_GET_MODEM_CONTROL           = 0x001b0094U,
    IOCTL_SERIAL_SET_MODEM_CONTROL           = 0x001b0098U,
    IOCTL_SERIAL_SET_FIFO_CONTROL            = 0x001b009cU,
    IOCTL_SERIAL_APPLY_DEFAULT_CONFIGURATION = 0x001b00a0U,
}

enum uint IOCTL_SERIAL_SET_INTERVAL_TIMER_RESOLUTION = 0x001b00a4U;

enum : uint
{
    IOCTL_SERIAL_INTERNAL_DO_WAIT_WAKE     = 0x001b0004U,
    IOCTL_SERIAL_INTERNAL_CANCEL_WAIT_WAKE = 0x001b0008U,
    IOCTL_SERIAL_INTERNAL_BASIC_SETTINGS   = 0x001b000cU,
    IOCTL_SERIAL_INTERNAL_RESTORE_SETTINGS = 0x001b0010U,
}

enum : uint
{
    SERIAL_EV_RXCHAR     = 0x00000001U,
    SERIAL_EV_RXFLAG     = 0x00000002U,
    SERIAL_EV_TXEMPTY    = 0x00000004U,
    SERIAL_EV_CTS        = 0x00000008U,
    SERIAL_EV_DSR        = 0x00000010U,
    SERIAL_EV_RLSD       = 0x00000020U,
    SERIAL_EV_BREAK      = 0x00000040U,
    SERIAL_EV_ERR        = 0x00000080U,
    SERIAL_EV_RING       = 0x00000100U,
    SERIAL_EV_PERR       = 0x00000200U,
    SERIAL_EV_RX80FULL   = 0x00000400U,
    SERIAL_EV_EVENT1     = 0x00000800U,
    SERIAL_EV_EVENT2     = 0x00001000U,
    SERIAL_PURGE_TXABORT = 0x00000001U,
    SERIAL_PURGE_RXABORT = 0x00000002U,
    SERIAL_PURGE_TXCLEAR = 0x00000004U,
    SERIAL_PURGE_RXCLEAR = 0x00000008U,
}

enum : uint
{
    STOP_BIT_1    = 0x00000000U,
    STOP_BITS_1_5 = 0x00000001U,
    STOP_BITS_2   = 0x00000002U,
}

enum uint NO_PARITY = 0x00000000U;
enum uint ODD_PARITY = 0x00000001U;
enum uint EVEN_PARITY = 0x00000002U;
enum uint MARK_PARITY = 0x00000003U;
enum uint SPACE_PARITY = 0x00000004U;

enum : ushort
{
    SERIAL_LSRMST_ESCAPE     = cast(ushort) 0x0000,
    SERIAL_LSRMST_LSR_DATA   = cast(ushort) 0x0001,
    SERIAL_LSRMST_LSR_NODATA = cast(ushort) 0x0002,
    SERIAL_LSRMST_MST        = cast(ushort) 0x0003,
}

enum uint IOCTL_INTERNAL_SERENUM_REMOVE_SELF = 0x00370207U;
enum uint COMDB_MIN_PORTS_ARBITRATED = 0x00000100U;
enum uint COMDB_MAX_PORTS_ARBITRATED = 0x00001000U;

enum : uint
{
    CDB_REPORT_BITS  = 0x00000000U,
    CDB_REPORT_BYTES = 0x00000001U,
}

// Callbacks

alias PSERENUM_READPORT = ubyte function(void* SerPortAddress);
alias PSERENUM_WRITEPORT = void function(void* SerPortAddress, ubyte Value);

// Structs


@RAIIFree!ComDBClose
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HCOMDB
{
    void* Value;
}

struct SERIALPERF_STATS
{
    uint ReceivedCount;
    uint TransmittedCount;
    uint FrameErrorCount;
    uint SerialOverrunErrorCount;
    uint BufferOverrunErrorCount;
    uint ParityErrorCount;
}

struct SERIALCONFIG
{
    uint   Size;
    ushort Version;
    uint   SubType;
    uint   ProvOffset;
    uint   ProviderSize;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/wchar[1] ProviderData;
}

struct SERIAL_LINE_CONTROL
{
    ubyte StopBits;
    ubyte Parity;
    ubyte WordLength;
}

struct SERIAL_TIMEOUTS
{
    uint ReadIntervalTimeout;
    uint ReadTotalTimeoutMultiplier;
    uint ReadTotalTimeoutConstant;
    uint WriteTotalTimeoutMultiplier;
    uint WriteTotalTimeoutConstant;
}

struct SERIAL_QUEUE_SIZE
{
    uint InSize;
    uint OutSize;
}

struct SERIAL_BAUD_RATE
{
    uint BaudRate;
}

struct SERIAL_CHARS
{
    ubyte EofChar;
    ubyte ErrorChar;
    ubyte BreakChar;
    ubyte EventChar;
    ubyte XonChar;
    ubyte XoffChar;
}

struct SERIAL_HANDFLOW
{
    uint ControlHandShake;
    uint FlowReplace;
    int  XonLimit;
    int  XoffLimit;
}

struct SERIAL_BASIC_SETTINGS
{
    SERIAL_TIMEOUTS Timeouts;
    SERIAL_HANDFLOW HandFlow;
    uint            RxFifo;
    uint            TxFifo;
}

struct SERIAL_STATUS
{
    uint    Errors;
    uint    HoldReasons;
    uint    AmountInInQueue;
    uint    AmountInOutQueue;
    BOOLEAN EofReceived;
    BOOLEAN WaitForImmediate;
}

struct SERIAL_XOFF_COUNTER
{
    uint  Timeout;
    int   Counter;
    ubyte XoffChar;
}

struct SERIAL_COMMPROP
{
    ushort PacketLength;
    ushort PacketVersion;
    uint   ServiceMask;
    uint   Reserved1;
    uint   MaxTxQueue;
    uint   MaxRxQueue;
    uint   MaxBaud;
    uint   ProvSubType;
    uint   ProvCapabilities;
    uint   SettableParams;
    uint   SettableBaud;
    ushort SettableData;
    ushort SettableStopParity;
    uint   CurrentTxQueue;
    uint   CurrentRxQueue;
    uint   ProvSpec1;
    uint   ProvSpec2;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/wchar[1] ProvChar;
}

struct SERENUM_PORT_DESC
{
    uint  Size;
    void* PortHandle;
    long  PortAddress;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ushort[1] Reserved;
}

struct SERENUM_PORT_PARAMETERS
{
    uint               Size;
    PSERENUM_READPORT  ReadAccessor;
    PSERENUM_WRITEPORT WriteAccessor;
    void*              SerPortAddress;
    void*              HardwareHandle;
    SERENUM_PORTION    Portion;
    ushort             NumberAxis;
    ushort[3]          Reserved;
}

// Functions

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msports/nf-msports-comdbopen
@DllImport("MSPORTS.dll")
int ComDBOpen(HCOMDB* PHComDB);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msports/nf-msports-comdbclose
@DllImport("MSPORTS.dll")
int ComDBClose(HCOMDB HComDB);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msports/nf-msports-comdbgetcurrentportusage
@DllImport("MSPORTS.dll")
int ComDBGetCurrentPortUsage(HCOMDB HComDB, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* Buffer, 
                             uint BufferSize, uint ReportType, uint* MaxPortsReported);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msports/nf-msports-comdbclaimnextfreeport
@DllImport("MSPORTS.dll")
int ComDBClaimNextFreePort(HCOMDB HComDB, uint* ComNumber);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msports/nf-msports-comdbclaimport
@DllImport("MSPORTS.dll")
int ComDBClaimPort(HCOMDB HComDB, uint ComNumber, BOOL ForceClaim, BOOL* Forced);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msports/nf-msports-comdbreleaseport
@DllImport("MSPORTS.dll")
int ComDBReleasePort(HCOMDB HComDB, uint ComNumber);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msports/nf-msports-comdbresizedatabase
@DllImport("MSPORTS.dll")
int ComDBResizeDatabase(HCOMDB HComDB, uint NewSize);


