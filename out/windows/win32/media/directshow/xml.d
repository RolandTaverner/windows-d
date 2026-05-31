// Written in the D programming language.

module windows.win32.media.directshow.xml;

public import windows.core;
public import system : Guid;
public import windows.win32.data.xml.msxml : IXMLElement;
public import windows.win32.foundation : BSTR, HRESULT, PWSTR;
public import windows.win32.media.directshow : IGraphBuilder;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Constants


enum GUID CLSID_XMLGraphBuilder = GUID("1bb05961-5fbf-11d2-a521-44df07c10000");

// Interfaces

@GUID("1bb05960-5fbf-11d2-a521-44df07c10000")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/amxmlgraphbuilder/nn-amxmlgraphbuilder-ixmlgraphbuilder))], [])
interface IXMLGraphBuilder : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/amxmlgraphbuilder/nf-amxmlgraphbuilder-ixmlgraphbuilder-buildfromxml))], [])
    HRESULT BuildFromXML(IGraphBuilder pGraph, IXMLElement pxml);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/amxmlgraphbuilder/nf-amxmlgraphbuilder-ixmlgraphbuilder-savetoxml))], [])
    HRESULT SaveToXML(IGraphBuilder pGraph, BSTR* pbstrxml);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/amxmlgraphbuilder/nf-amxmlgraphbuilder-ixmlgraphbuilder-buildfromxmlfile))], [])
    HRESULT BuildFromXMLFile(IGraphBuilder pGraph, const(PWSTR) wszFileName, const(PWSTR) wszBaseURL);
}


// GUIDs


const GUID IID_IXMLGraphBuilder = GUIDOF!IXMLGraphBuilder;
