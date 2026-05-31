// Written in the D programming language.

module windows.win32.system.com.ui;

public import windows.core;
public import windows.win32.foundation.foundation : HRESULT;
public import windows.win32.graphics.gdi : HBITMAP, HDC;
public import windows.win32.system.com.com : IUnknown;
public import windows.win32.system.com.structuredstorage : IStorage;
public import windows.win32.ui.windowsandmessaging : HICON;

extern(Windows) @nogc nothrow:


// Interfaces

@GUID("969dc708-5c76-11d1-8d86-0000f804b057")
interface IThumbnailExtractor : IUnknown
{
    HRESULT ExtractThumbnail(IStorage pStg, uint ulLength, uint ulHeight, uint* pulOutputLength, 
                             uint* pulOutputHeight, HBITMAP* phOutputBitmap);
    HRESULT OnFileUpdated(IStorage pStg);
}

@GUID("947990de-cc28-11d2-a0f7-00805f858fb1")
interface IDummyHICONIncluder : IUnknown
{
    HRESULT Dummy(HICON h1, HDC h2);
}


// GUIDs


const GUID IID_IDummyHICONIncluder = GUIDOF!IDummyHICONIncluder;
const GUID IID_IThumbnailExtractor = GUIDOF!IThumbnailExtractor;
