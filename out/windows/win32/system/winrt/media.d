// Written in the D programming language.

module windows.win32.system.winrt.media;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : BOOL, HRESULT;
public import windows.win32.media.mediafoundation : IMFDXGIDeviceManager, IMFSample, MFVideoArea;
public import windows.win32.system.winrt : IInspectable;

extern(Windows) @nogc nothrow:


// Constants


enum GUID CLSID_AudioFrameNativeFactory = GUID("16a0a3b9-9f65-4102-9367-2cda3a4f372a");
enum GUID CLSID_VideoFrameNativeFactory = GUID("d194386a-04e3-4814-8100-b2b0ae6d78c7");

// Interfaces

@GUID("20be1e2e-930f-4746-9335-3c332f255093")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.media.core.interop/nn-windows-media-core-interop-iaudioframenative))], [])
interface IAudioFrameNative : IInspectable
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/WinRT/iaudioframenative-getdata))], [])
    HRESULT GetData(const(GUID)* riid, void** ppv);
}

@GUID("26ba702b-314a-4620-aaf6-7a51aa58fa18")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.media.core.interop/nn-windows-media-core-interop-ivideoframenative))], [])
interface IVideoFrameNative : IInspectable
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/WinRT/ivideoframenative-getdata))], [])
    HRESULT GetData(const(GUID)* riid, void** ppv);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/WinRT/ivideoframenative-getdevice))], [])
    HRESULT GetDevice(const(GUID)* riid, void** ppv);
}

@GUID("7bd67cf8-bf7d-43e6-af8d-b170ee0c0110")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.media.core.interop/nn-windows-media-core-interop-iaudioframenativefactory))], [])
interface IAudioFrameNativeFactory : IInspectable
{
    HRESULT CreateFromMFSample(IMFSample data, BOOL forceReadOnly, const(GUID)* riid, void** ppv);
}

@GUID("69e3693e-8e1e-4e63-ac4c-7fdc21d9731d")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.media.core.interop/nn-windows-media-core-interop-ivideoframenativefactory))], [])
interface IVideoFrameNativeFactory : IInspectable
{
    HRESULT CreateFromMFSample(IMFSample data, const(GUID)* subtype, uint width, uint height, BOOL forceReadOnly, 
                               const(MFVideoArea)* minDisplayAperture, IMFDXGIDeviceManager device, 
                               const(GUID)* riid, void** ppv);
}


// GUIDs


const GUID IID_IAudioFrameNative        = GUIDOF!IAudioFrameNative;
const GUID IID_IAudioFrameNativeFactory = GUIDOF!IAudioFrameNativeFactory;
const GUID IID_IVideoFrameNative        = GUIDOF!IVideoFrameNative;
const GUID IID_IVideoFrameNativeFactory = GUIDOF!IVideoFrameNativeFactory;
