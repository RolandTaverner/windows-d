// Written in the D programming language.

module windows.win32.devices.nfp;

public import windows.core;
public import windows.win32.foundation : DEVPROPKEY;

extern(Windows) @nogc nothrow:


// Constants


enum GUID GUID_DEVINTERFACE_NFP = GUID("fb3842cd-9e2a-4f83-8fcc-4b0761139ae9");
enum DEVPROPKEY DEVPKEY_NFP_Capabilities = DEVPROPKEY(GUID("FB3842CD-9E2A-4F83-8FCC-4B0761139AE9"), 2);
enum uint IOCTL_NFP_GET_NEXT_SUBSCRIBED_MESSAGE = 0x00510040U;

enum : uint
{
    IOCTL_NFP_SET_PAYLOAD                  = 0x00510044U,
    IOCTL_NFP_GET_NEXT_TRANSMITTED_MESSAGE = 0x00510048U,
}

enum : uint
{
    IOCTL_NFP_DISABLE                   = 0x0051004cU,
    IOCTL_NFP_ENABLE                    = 0x00510050U,
    IOCTL_NFP_GET_MAX_MESSAGE_BYTES     = 0x00510080U,
    IOCTL_NFP_GET_KILO_BYTES_PER_SECOND = 0x00510084U,
}

// Structs


struct SUBSCRIBED_MESSAGE
{
    uint     cbPayloadHint;
    ubyte[1] payload; // Flexible array
}

