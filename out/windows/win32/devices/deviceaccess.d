// Written in the D programming language.

module windows.win32.devices.deviceaccess;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : HRESULT, PWSTR;
public import windows.win32.system.com.com : IUnknown;

extern(Windows) @nogc nothrow:


// Constants


enum int ED_BASE = 0x00001000;

enum : uint
{
    DEV_PORT_SIM  = 0x00000001U,
    DEV_PORT_COM1 = 0x00000002U,
    DEV_PORT_COM2 = 0x00000003U,
    DEV_PORT_COM3 = 0x00000004U,
    DEV_PORT_COM4 = 0x00000005U,
    DEV_PORT_DIAQ = 0x00000006U,
    DEV_PORT_ARTI = 0x00000007U,
    DEV_PORT_1394 = 0x00000008U,
    DEV_PORT_USB  = 0x00000009U,
    DEV_PORT_MIN  = 0x00000001U,
    DEV_PORT_MAX  = 0x00000009U,
}

enum : uint
{
    ED_TOP    = 0x00000001U,
    ED_MIDDLE = 0x00000002U,
}

enum uint ED_BOTTOM = 0x00000004U;

enum : uint
{
    ED_LEFT   = 0x00000100U,
    ED_CENTER = 0x00000200U,
}

enum uint ED_RIGHT = 0x00000400U;
enum uint ED_AUDIO_ALL = 0x10000000U;

enum : int
{
    ED_AUDIO_1  = 0x00000001,
    ED_AUDIO_2  = 0x00000002,
    ED_AUDIO_3  = 0x00000004,
    ED_AUDIO_4  = 0x00000008,
    ED_AUDIO_5  = 0x00000010,
    ED_AUDIO_6  = 0x00000020,
    ED_AUDIO_7  = 0x00000040,
    ED_AUDIO_8  = 0x00000080,
    ED_AUDIO_9  = 0x00000100,
    ED_AUDIO_10 = 0x00000200,
    ED_AUDIO_11 = 0x00000400,
    ED_AUDIO_12 = 0x00000800,
    ED_AUDIO_13 = 0x00001000,
    ED_AUDIO_14 = 0x00002000,
    ED_AUDIO_15 = 0x00004000,
    ED_AUDIO_16 = 0x00008000,
    ED_AUDIO_17 = 0x00010000,
    ED_AUDIO_18 = 0x00020000,
    ED_AUDIO_19 = 0x00040000,
    ED_AUDIO_20 = 0x00080000,
    ED_AUDIO_21 = 0x00100000,
    ED_AUDIO_22 = 0x00200000,
    ED_AUDIO_23 = 0x00400000,
    ED_AUDIO_24 = 0x00800000,
}

enum int ED_VIDEO = 0x02000000;
enum GUID CLSID_DeviceIoControl = GUID("12d3e372-874b-457d-9fdf-73977778686c");

// Functions

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deviceaccess/nf-deviceaccess-createdeviceaccessinstance
@DllImport("deviceaccess.dll")
HRESULT CreateDeviceAccessInstance(const(PWSTR) deviceInterfacePath, uint desiredAccess, 
                                   ICreateDeviceAccessAsync* createAsync);


// Interfaces

@GUID("999bad24-9acd-45bb-8669-2a2fc0288b04")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deviceaccess/nn-deviceaccess-idevicerequestcompletioncallback
interface IDeviceRequestCompletionCallback : IUnknown
{
    HRESULT Invoke(HRESULT requestResult, uint bytesReturned);
}

@GUID("9eefe161-23ab-4f18-9b49-991b586ae970")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deviceaccess/nn-deviceaccess-ideviceiocontrol
interface IDeviceIoControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deviceaccess/nf-deviceaccess-ideviceiocontrol-deviceiocontrolsync
    HRESULT DeviceIoControlSync(uint ioControlCode, ubyte* inputBuffer, uint inputBufferSize, ubyte* outputBuffer, 
                                uint outputBufferSize, uint* bytesReturned);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deviceaccess/nf-deviceaccess-ideviceiocontrol-deviceiocontrolasync
    HRESULT DeviceIoControlAsync(uint ioControlCode, ubyte* inputBuffer, uint inputBufferSize, ubyte* outputBuffer, 
                                 uint outputBufferSize, IDeviceRequestCompletionCallback requestCompletionCallback, 
                                 size_t* cancelContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deviceaccess/nf-deviceaccess-ideviceiocontrol-canceloperation
    HRESULT CancelOperation(size_t cancelContext);
}

@GUID("3474628f-683d-42d2-abcb-db018c6503bc")
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deviceaccess/nn-deviceaccess-icreatedeviceaccessasync
interface ICreateDeviceAccessAsync : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deviceaccess/nf-deviceaccess-icreatedeviceaccessasync-cancel
    HRESULT Cancel();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deviceaccess/nf-deviceaccess-icreatedeviceaccessasync-wait
    HRESULT Wait(uint timeout);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deviceaccess/nf-deviceaccess-icreatedeviceaccessasync-close
    HRESULT Close();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/deviceaccess/nf-deviceaccess-icreatedeviceaccessasync-getresult
    HRESULT GetResult(const(GUID)* riid, void** deviceAccess);
}


// GUIDs


const GUID IID_ICreateDeviceAccessAsync         = GUIDOF!ICreateDeviceAccessAsync;
const GUID IID_IDeviceIoControl                 = GUIDOF!IDeviceIoControl;
const GUID IID_IDeviceRequestCompletionCallback = GUIDOF!IDeviceRequestCompletionCallback;
