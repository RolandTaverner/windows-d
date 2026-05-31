// Written in the D programming language.

module windows.win32.devices.nfp;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : DEVPROPKEY;

extern(Windows) @nogc nothrow:


// Constants


enum GUID GUID_DEVINTERFACE_NFP = GUID("fb3842cd-9e2a-4f83-8fcc-4b0761139ae9");
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4214768333, 40490, 20355, 143, 204, 75, 7, 97, 19, 154, 233}, 2))], [])*/DEVPROPKEY DEVPKEY_NFP_Capabilities = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4214768333, 40490, 20355, 143, 204, 75, 7, 97, 19, 154, 233}, 2))], [])*/DEVPROPKEY(GUID("FB3842CD-9E2A-4F83-8FCC-4B0761139AE9"), 2);
enum uint IOCTL_NFP_GET_NEXT_SUBSCRIBED_MESSAGE = 0x00510040;

enum : uint
{
    IOCTL_NFP_SET_PAYLOAD                  = 0x00510044,
    IOCTL_NFP_GET_NEXT_TRANSMITTED_MESSAGE = 0x00510048,
}

enum : uint
{
    IOCTL_NFP_DISABLE                   = 0x0051004c,
    IOCTL_NFP_ENABLE                    = 0x00510050,
    IOCTL_NFP_GET_MAX_MESSAGE_BYTES     = 0x00510080,
    IOCTL_NFP_GET_KILO_BYTES_PER_SECOND = 0x00510084,
}

// Structs


struct SUBSCRIBED_MESSAGE
{
    uint cbPayloadHint;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] payload;
}

