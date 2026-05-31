// Written in the D programming language.

module windows.win32.system.com.marshal;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BSTR, HGLOBAL, HRESULT, HWND;
public import windows.win32.graphics.gdi : HBITMAP, HDC, HPALETTE;
public import windows.win32.system.com.com : CO_MARSHALING_CONTEXT_ATTRIBUTES, IStream, IUnknown,
                                             SAFEARRAY, STGMEDIUM;
public import windows.win32.ui.windowsandmessaging : HACCEL, HICON, HMENU;

extern(Windows) @nogc nothrow:


// Enums


alias STDMSHLFLAGS = int;
enum : int
{
    SMEXF_SERVER  = 0x00000001,
    SMEXF_HANDLER = 0x00000002,
}

// Functions

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-bstr_usersize
@DllImport("OLEAUT32.dll")
uint BSTR_UserSize(uint* param0, uint param1, BSTR* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-bstr_usermarshal
@DllImport("OLEAUT32.dll")
ubyte* BSTR_UserMarshal(uint* param0, ubyte* param1, BSTR* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-bstr_userunmarshal
@DllImport("OLEAUT32.dll")
ubyte* BSTR_UserUnmarshal(uint* param0, ubyte* param1, BSTR* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-bstr_userfree
@DllImport("OLEAUT32.dll")
void BSTR_UserFree(uint* param0, BSTR* param1);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hwnd_usersize
@DllImport("OLE32.dll")
uint HWND_UserSize(uint* param0, uint param1, HWND* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hwnd_usermarshal
@DllImport("OLE32.dll")
ubyte* HWND_UserMarshal(uint* param0, ubyte* param1, HWND* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hwnd_userunmarshal
@DllImport("OLE32.dll")
ubyte* HWND_UserUnmarshal(uint* param0, ubyte* param1, HWND* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hwnd_userfree
@DllImport("OLE32.dll")
void HWND_UserFree(uint* param0, HWND* param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("OLEAUT32.dll")
uint BSTR_UserSize64(uint* param0, uint param1, BSTR* param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("OLEAUT32.dll")
ubyte* BSTR_UserMarshal64(uint* param0, ubyte* param1, BSTR* param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("OLEAUT32.dll")
ubyte* BSTR_UserUnmarshal64(uint* param0, ubyte* param1, BSTR* param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("OLEAUT32.dll")
void BSTR_UserFree64(uint* param0, BSTR* param1);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hwnd_usersize64
@DllImport("OLE32.dll")
uint HWND_UserSize64(uint* param0, uint param1, HWND* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hwnd_usermarshal64
@DllImport("OLE32.dll")
ubyte* HWND_UserMarshal64(uint* param0, ubyte* param1, HWND* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hwnd_userunmarshal64
@DllImport("OLE32.dll")
ubyte* HWND_UserUnmarshal64(uint* param0, ubyte* param1, HWND* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hwnd_userfree64
@DllImport("OLE32.dll")
void HWND_UserFree64(uint* param0, HWND* param1);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-clipformat_usersize
@DllImport("OLE32.dll")
uint CLIPFORMAT_UserSize(uint* param0, uint param1, ushort* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-clipformat_usermarshal
@DllImport("OLE32.dll")
ubyte* CLIPFORMAT_UserMarshal(uint* param0, ubyte* param1, ushort* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-clipformat_userunmarshal
@DllImport("OLE32.dll")
ubyte* CLIPFORMAT_UserUnmarshal(uint* param0, ubyte* param1, ushort* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-clipformat_userfree
@DllImport("OLE32.dll")
void CLIPFORMAT_UserFree(uint* param0, ushort* param1);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-hbitmap_usersize
@DllImport("OLE32.dll")
uint HBITMAP_UserSize(uint* param0, uint param1, HBITMAP* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-hbitmap_usermarshal
@DllImport("OLE32.dll")
ubyte* HBITMAP_UserMarshal(uint* param0, ubyte* param1, HBITMAP* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-hbitmap_userunmarshal
@DllImport("OLE32.dll")
ubyte* HBITMAP_UserUnmarshal(uint* param0, ubyte* param1, HBITMAP* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-hbitmap_userfree
@DllImport("OLE32.dll")
void HBITMAP_UserFree(uint* param0, HBITMAP* param1);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hdc_usersize
@DllImport("OLE32.dll")
uint HDC_UserSize(uint* param0, uint param1, HDC* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hdc_usermarshal
@DllImport("OLE32.dll")
ubyte* HDC_UserMarshal(uint* param0, ubyte* param1, HDC* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hdc_userunmarshal
@DllImport("OLE32.dll")
ubyte* HDC_UserUnmarshal(uint* param0, ubyte* param1, HDC* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hdc_userfree
@DllImport("OLE32.dll")
void HDC_UserFree(uint* param0, HDC* param1);

@DllImport("OLE32.dll")
uint HICON_UserSize(uint* param0, uint param1, HICON* param2);

@DllImport("OLE32.dll")
ubyte* HICON_UserMarshal(uint* param0, ubyte* param1, HICON* param2);

@DllImport("OLE32.dll")
ubyte* HICON_UserUnmarshal(uint* param0, ubyte* param1, HICON* param2);

@DllImport("OLE32.dll")
void HICON_UserFree(uint* param0, HICON* param1);

@DllImport("ole32.dll")
uint SNB_UserSize(uint* param0, uint param1, ushort*** param2);

@DllImport("ole32.dll")
ubyte* SNB_UserMarshal(uint* param0, ubyte* param1, ushort*** param2);

@DllImport("ole32.dll")
ubyte* SNB_UserUnmarshal(uint* param0, ubyte* param1, ushort*** param2);

@DllImport("ole32.dll")
void SNB_UserFree(uint* param0, ushort*** param1);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-stgmedium_usersize
@DllImport("OLE32.dll")
uint STGMEDIUM_UserSize(uint* param0, uint param1, STGMEDIUM* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-stgmedium_usermarshal
@DllImport("OLE32.dll")
ubyte* STGMEDIUM_UserMarshal(uint* param0, ubyte* param1, STGMEDIUM* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-stgmedium_userunmarshal
@DllImport("OLE32.dll")
ubyte* STGMEDIUM_UserUnmarshal(uint* param0, ubyte* param1, STGMEDIUM* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-stgmedium_userfree
@DllImport("OLE32.dll")
void STGMEDIUM_UserFree(uint* param0, STGMEDIUM* param1);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-clipformat_usersize64
@DllImport("OLE32.dll")
uint CLIPFORMAT_UserSize64(uint* param0, uint param1, ushort* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-clipformat_usermarshal64
@DllImport("OLE32.dll")
ubyte* CLIPFORMAT_UserMarshal64(uint* param0, ubyte* param1, ushort* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-clipformat_userunmarshal64
@DllImport("OLE32.dll")
ubyte* CLIPFORMAT_UserUnmarshal64(uint* param0, ubyte* param1, ushort* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-clipformat_userfree64
@DllImport("OLE32.dll")
void CLIPFORMAT_UserFree64(uint* param0, ushort* param1);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-hbitmap_usersize64
@DllImport("OLE32.dll")
uint HBITMAP_UserSize64(uint* param0, uint param1, HBITMAP* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-hbitmap_usermarshal64
@DllImport("OLE32.dll")
ubyte* HBITMAP_UserMarshal64(uint* param0, ubyte* param1, HBITMAP* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-hbitmap_userunmarshal64
@DllImport("OLE32.dll")
ubyte* HBITMAP_UserUnmarshal64(uint* param0, ubyte* param1, HBITMAP* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-hbitmap_userfree64
@DllImport("OLE32.dll")
void HBITMAP_UserFree64(uint* param0, HBITMAP* param1);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hdc_usersize64
@DllImport("OLE32.dll")
uint HDC_UserSize64(uint* param0, uint param1, HDC* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hdc_usermarshal64
@DllImport("OLE32.dll")
ubyte* HDC_UserMarshal64(uint* param0, ubyte* param1, HDC* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hdc_userunmarshal64
@DllImport("OLE32.dll")
ubyte* HDC_UserUnmarshal64(uint* param0, ubyte* param1, HDC* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hdc_userfree64
@DllImport("OLE32.dll")
void HDC_UserFree64(uint* param0, HDC* param1);

@DllImport("OLE32.dll")
uint HICON_UserSize64(uint* param0, uint param1, HICON* param2);

@DllImport("OLE32.dll")
ubyte* HICON_UserMarshal64(uint* param0, ubyte* param1, HICON* param2);

@DllImport("OLE32.dll")
ubyte* HICON_UserUnmarshal64(uint* param0, ubyte* param1, HICON* param2);

@DllImport("OLE32.dll")
void HICON_UserFree64(uint* param0, HICON* param1);

@DllImport("ole32.dll")
uint SNB_UserSize64(uint* param0, uint param1, ushort*** param2);

@DllImport("ole32.dll")
ubyte* SNB_UserMarshal64(uint* param0, ubyte* param1, ushort*** param2);

@DllImport("ole32.dll")
ubyte* SNB_UserUnmarshal64(uint* param0, ubyte* param1, ushort*** param2);

@DllImport("ole32.dll")
void SNB_UserFree64(uint* param0, ushort*** param1);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-stgmedium_usersize64
@DllImport("OLE32.dll")
uint STGMEDIUM_UserSize64(uint* param0, uint param1, STGMEDIUM* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-stgmedium_usermarshal64
@DllImport("OLE32.dll")
ubyte* STGMEDIUM_UserMarshal64(uint* param0, ubyte* param1, STGMEDIUM* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-stgmedium_userunmarshal64
@DllImport("OLE32.dll")
ubyte* STGMEDIUM_UserUnmarshal64(uint* param0, ubyte* param1, STGMEDIUM* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-stgmedium_userfree64
@DllImport("OLE32.dll")
void STGMEDIUM_UserFree64(uint* param0, STGMEDIUM* param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT CoGetMarshalSizeMax(uint* pulSize, const(GUID)* riid, IUnknown pUnk, uint dwDestContext, 
                            void* pvDestContext, uint mshlflags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT CoMarshalInterface(IStream pStm, const(GUID)* riid, IUnknown pUnk, uint dwDestContext, void* pvDestContext, 
                           uint mshlflags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT CoUnmarshalInterface(IStream pStm, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT CoMarshalHresult(IStream pstm, HRESULT hresult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT CoUnmarshalHresult(IStream pstm, HRESULT* phresult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT CoReleaseMarshalData(IStream pStm);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT CoGetStandardMarshal(const(GUID)* riid, IUnknown pUnk, uint dwDestContext, void* pvDestContext, 
                             uint mshlflags, IMarshal* ppMarshal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT CoGetStdMarshalEx(IUnknown pUnkOuter, uint smexflags, IUnknown* ppUnkInner);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT CoMarshalInterThreadInterfaceInStream(const(GUID)* riid, IUnknown pUnk, IStream* ppStm);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-lpsafearray_usersize
@DllImport("OLEAUT32.dll")
uint LPSAFEARRAY_UserSize(uint* param0, uint param1, SAFEARRAY** param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-lpsafearray_usermarshal
@DllImport("OLEAUT32.dll")
ubyte* LPSAFEARRAY_UserMarshal(uint* param0, ubyte* param1, SAFEARRAY** param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-lpsafearray_userunmarshal
@DllImport("OLEAUT32.dll")
ubyte* LPSAFEARRAY_UserUnmarshal(uint* param0, ubyte* param1, SAFEARRAY** param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-lpsafearray_userfree
@DllImport("OLEAUT32.dll")
void LPSAFEARRAY_UserFree(uint* param0, SAFEARRAY** param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("OLEAUT32.dll")
uint LPSAFEARRAY_UserSize64(uint* param0, uint param1, SAFEARRAY** param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("OLEAUT32.dll")
ubyte* LPSAFEARRAY_UserMarshal64(uint* param0, ubyte* param1, SAFEARRAY** param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("OLEAUT32.dll")
ubyte* LPSAFEARRAY_UserUnmarshal64(uint* param0, ubyte* param1, SAFEARRAY** param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("OLEAUT32.dll")
void LPSAFEARRAY_UserFree64(uint* param0, SAFEARRAY** param1);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-haccel_usersize
@DllImport("OLE32.dll")
uint HACCEL_UserSize(uint* param0, uint param1, HACCEL* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-haccel_usermarshal
@DllImport("OLE32.dll")
ubyte* HACCEL_UserMarshal(uint* param0, ubyte* param1, HACCEL* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-haccel_userunmarshal
@DllImport("OLE32.dll")
ubyte* HACCEL_UserUnmarshal(uint* param0, ubyte* param1, HACCEL* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-haccel_userfree
@DllImport("OLE32.dll")
void HACCEL_UserFree(uint* param0, HACCEL* param1);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hglobal_usersize
@DllImport("OLE32.dll")
uint HGLOBAL_UserSize(uint* param0, uint param1, HGLOBAL* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hglobal_usermarshal
@DllImport("OLE32.dll")
ubyte* HGLOBAL_UserMarshal(uint* param0, ubyte* param1, HGLOBAL* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hglobal_userunmarshal
@DllImport("OLE32.dll")
ubyte* HGLOBAL_UserUnmarshal(uint* param0, ubyte* param1, HGLOBAL* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hglobal_userfree
@DllImport("OLE32.dll")
void HGLOBAL_UserFree(uint* param0, HGLOBAL* param1);

@DllImport("OLE32.dll")
uint HMENU_UserSize(uint* param0, uint param1, HMENU* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hmenu_usermarshal
@DllImport("OLE32.dll")
ubyte* HMENU_UserMarshal(uint* param0, ubyte* param1, HMENU* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hmenu_userunmarshal
@DllImport("OLE32.dll")
ubyte* HMENU_UserUnmarshal(uint* param0, ubyte* param1, HMENU* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hmenu_userfree
@DllImport("OLE32.dll")
void HMENU_UserFree(uint* param0, HMENU* param1);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-haccel_usersize64
@DllImport("OLE32.dll")
uint HACCEL_UserSize64(uint* param0, uint param1, HACCEL* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-haccel_usermarshal64
@DllImport("OLE32.dll")
ubyte* HACCEL_UserMarshal64(uint* param0, ubyte* param1, HACCEL* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-haccel_userunmarshal64
@DllImport("OLE32.dll")
ubyte* HACCEL_UserUnmarshal64(uint* param0, ubyte* param1, HACCEL* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-haccel_userfree64
@DllImport("OLE32.dll")
void HACCEL_UserFree64(uint* param0, HACCEL* param1);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hglobal_usersize64
@DllImport("OLE32.dll")
uint HGLOBAL_UserSize64(uint* param0, uint param1, HGLOBAL* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hglobal_usermarshal64
@DllImport("OLE32.dll")
ubyte* HGLOBAL_UserMarshal64(uint* param0, ubyte* param1, HGLOBAL* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hglobal_userunmarshal64
@DllImport("OLE32.dll")
ubyte* HGLOBAL_UserUnmarshal64(uint* param0, ubyte* param1, HGLOBAL* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hglobal_userfree64
@DllImport("OLE32.dll")
void HGLOBAL_UserFree64(uint* param0, HGLOBAL* param1);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hmenu_usersize64
@DllImport("OLE32.dll")
uint HMENU_UserSize64(uint* param0, uint param1, HMENU* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hmenu_usermarshal64
@DllImport("OLE32.dll")
ubyte* HMENU_UserMarshal64(uint* param0, ubyte* param1, HMENU* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hmenu_userunmarshal64
@DllImport("OLE32.dll")
ubyte* HMENU_UserUnmarshal64(uint* param0, ubyte* param1, HMENU* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-hmenu_userfree64
@DllImport("OLE32.dll")
void HMENU_UserFree64(uint* param0, HMENU* param1);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-hpalette_usersize
@DllImport("OLE32.dll")
uint HPALETTE_UserSize(uint* param0, uint param1, HPALETTE* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-hpalette_usermarshal
@DllImport("OLE32.dll")
ubyte* HPALETTE_UserMarshal(uint* param0, ubyte* param1, HPALETTE* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-hpalette_userunmarshal
@DllImport("OLE32.dll")
ubyte* HPALETTE_UserUnmarshal(uint* param0, ubyte* param1, HPALETTE* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-hpalette_userfree
@DllImport("OLE32.dll")
void HPALETTE_UserFree(uint* param0, HPALETTE* param1);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-hpalette_usersize64
@DllImport("OLE32.dll")
uint HPALETTE_UserSize64(uint* param0, uint param1, HPALETTE* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-hpalette_usermarshal64
@DllImport("OLE32.dll")
ubyte* HPALETTE_UserMarshal64(uint* param0, ubyte* param1, HPALETTE* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-hpalette_userunmarshal64
@DllImport("OLE32.dll")
ubyte* HPALETTE_UserUnmarshal64(uint* param0, ubyte* param1, HPALETTE* param2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-hpalette_userfree64
@DllImport("OLE32.dll")
void HPALETTE_UserFree64(uint* param0, HPALETTE* param1);


// Interfaces

@GUID("00000003-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-imarshal
interface IMarshal : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imarshal-getunmarshalclass
    HRESULT GetUnmarshalClass(const(GUID)* riid, void* pv, uint dwDestContext, 
                              /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvDestContext, 
                              uint mshlflags, GUID* pCid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imarshal-getmarshalsizemax
    HRESULT GetMarshalSizeMax(const(GUID)* riid, void* pv, uint dwDestContext, 
                              /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvDestContext, 
                              uint mshlflags, uint* pSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-imarshal-marshalinterface
    HRESULT MarshalInterface(IStream pStm, const(GUID)* riid, void* pv, uint dwDestContext, 
                             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvDestContext, 
                             uint mshlflags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-imarshal-unmarshalinterface
    HRESULT UnmarshalInterface(IStream pStm, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-imarshal-releasemarshaldata
    HRESULT ReleaseMarshalData(IStream pStm);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-imarshal-disconnectobject
    HRESULT DisconnectObject(uint dwReserved);
}

@GUID("000001cf-0000-0000-c000-000000000046")
interface IMarshal2 : IMarshal
{
}

@GUID("d8f2f5e6-6102-4863-9f26-389a4676efde")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-imarshalingstream
interface IMarshalingStream : IStream
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-imarshalingstream-getmarshalingcontextattribute
    HRESULT GetMarshalingContextAttribute(CO_MARSHALING_CONTEXT_ATTRIBUTES attribute, size_t* pAttributeValue);
}


// GUIDs


const GUID IID_IMarshal          = GUIDOF!IMarshal;
const GUID IID_IMarshal2         = GUIDOF!IMarshal2;
const GUID IID_IMarshalingStream = GUIDOF!IMarshalingStream;
