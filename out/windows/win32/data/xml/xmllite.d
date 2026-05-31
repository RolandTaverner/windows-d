// Written in the D programming language.

module windows.win32.data.xml.xmllite;

public import windows.core;
public import system.system : Guid;
public import windows.win32.foundation.foundation : BOOL, HRESULT, PWSTR;
public import windows.win32.system.com.com : IMalloc, IUnknown;

extern(Windows) @nogc nothrow:


// Enums


enum XmlNodeType : int
{
    XmlNodeType_None                  = 0x00000000,
    XmlNodeType_Element               = 0x00000001,
    XmlNodeType_Attribute             = 0x00000002,
    XmlNodeType_Text                  = 0x00000003,
    XmlNodeType_CDATA                 = 0x00000004,
    XmlNodeType_ProcessingInstruction = 0x00000007,
    XmlNodeType_Comment               = 0x00000008,
    XmlNodeType_DocumentType          = 0x0000000a,
    XmlNodeType_Whitespace            = 0x0000000d,
    XmlNodeType_EndElement            = 0x0000000f,
    XmlNodeType_XmlDeclaration        = 0x00000011,
    _XmlNodeType_Last                 = 0x00000011,
}

enum XmlConformanceLevel : int
{
    XmlConformanceLevel_Auto     = 0x00000000,
    XmlConformanceLevel_Fragment = 0x00000001,
    XmlConformanceLevel_Document = 0x00000002,
    _XmlConformanceLevel_Last    = 0x00000002,
}

enum DtdProcessing : int
{
    DtdProcessing_Prohibit = 0x00000000,
    DtdProcessing_Parse    = 0x00000001,
    _DtdProcessing_Last    = 0x00000001,
}

enum XmlReadState : int
{
    XmlReadState_Initial     = 0x00000000,
    XmlReadState_Interactive = 0x00000001,
    XmlReadState_Error       = 0x00000002,
    XmlReadState_EndOfFile   = 0x00000003,
    XmlReadState_Closed      = 0x00000004,
}

enum XmlReaderProperty : int
{
    XmlReaderProperty_MultiLanguage      = 0x00000000,
    XmlReaderProperty_ConformanceLevel   = 0x00000001,
    XmlReaderProperty_RandomAccess       = 0x00000002,
    XmlReaderProperty_XmlResolver        = 0x00000003,
    XmlReaderProperty_DtdProcessing      = 0x00000004,
    XmlReaderProperty_ReadState          = 0x00000005,
    XmlReaderProperty_MaxElementDepth    = 0x00000006,
    XmlReaderProperty_MaxEntityExpansion = 0x00000007,
    _XmlReaderProperty_Last              = 0x00000007,
}

enum XmlError : int
{
    MX_E_MX                     = 0xc00cee00,
    MX_E_INPUTEND               = 0xc00cee01,
    MX_E_ENCODING               = 0xc00cee02,
    MX_E_ENCODINGSWITCH         = 0xc00cee03,
    MX_E_ENCODINGSIGNATURE      = 0xc00cee04,
    WC_E_WC                     = 0xc00cee20,
    WC_E_WHITESPACE             = 0xc00cee21,
    WC_E_SEMICOLON              = 0xc00cee22,
    WC_E_GREATERTHAN            = 0xc00cee23,
    WC_E_QUOTE                  = 0xc00cee24,
    WC_E_EQUAL                  = 0xc00cee25,
    WC_E_LESSTHAN               = 0xc00cee26,
    WC_E_HEXDIGIT               = 0xc00cee27,
    WC_E_DIGIT                  = 0xc00cee28,
    WC_E_LEFTBRACKET            = 0xc00cee29,
    WC_E_LEFTPAREN              = 0xc00cee2a,
    WC_E_XMLCHARACTER           = 0xc00cee2b,
    WC_E_NAMECHARACTER          = 0xc00cee2c,
    WC_E_SYNTAX                 = 0xc00cee2d,
    WC_E_CDSECT                 = 0xc00cee2e,
    WC_E_COMMENT                = 0xc00cee2f,
    WC_E_CONDSECT               = 0xc00cee30,
    WC_E_DECLATTLIST            = 0xc00cee31,
    WC_E_DECLDOCTYPE            = 0xc00cee32,
    WC_E_DECLELEMENT            = 0xc00cee33,
    WC_E_DECLENTITY             = 0xc00cee34,
    WC_E_DECLNOTATION           = 0xc00cee35,
    WC_E_NDATA                  = 0xc00cee36,
    WC_E_PUBLIC                 = 0xc00cee37,
    WC_E_SYSTEM                 = 0xc00cee38,
    WC_E_NAME                   = 0xc00cee39,
    WC_E_ROOTELEMENT            = 0xc00cee3a,
    WC_E_ELEMENTMATCH           = 0xc00cee3b,
    WC_E_UNIQUEATTRIBUTE        = 0xc00cee3c,
    WC_E_TEXTXMLDECL            = 0xc00cee3d,
    WC_E_LEADINGXML             = 0xc00cee3e,
    WC_E_TEXTDECL               = 0xc00cee3f,
    WC_E_XMLDECL                = 0xc00cee40,
    WC_E_ENCNAME                = 0xc00cee41,
    WC_E_PUBLICID               = 0xc00cee42,
    WC_E_PESINTERNALSUBSET      = 0xc00cee43,
    WC_E_PESBETWEENDECLS        = 0xc00cee44,
    WC_E_NORECURSION            = 0xc00cee45,
    WC_E_ENTITYCONTENT          = 0xc00cee46,
    WC_E_UNDECLAREDENTITY       = 0xc00cee47,
    WC_E_PARSEDENTITY           = 0xc00cee48,
    WC_E_NOEXTERNALENTITYREF    = 0xc00cee49,
    WC_E_PI                     = 0xc00cee4a,
    WC_E_SYSTEMID               = 0xc00cee4b,
    WC_E_QUESTIONMARK           = 0xc00cee4c,
    WC_E_CDSECTEND              = 0xc00cee4d,
    WC_E_MOREDATA               = 0xc00cee4e,
    WC_E_DTDPROHIBITED          = 0xc00cee4f,
    WC_E_INVALIDXMLSPACE        = 0xc00cee50,
    NC_E_NC                     = 0xc00cee60,
    NC_E_QNAMECHARACTER         = 0xc00cee61,
    NC_E_QNAMECOLON             = 0xc00cee62,
    NC_E_NAMECOLON              = 0xc00cee63,
    NC_E_DECLAREDPREFIX         = 0xc00cee64,
    NC_E_UNDECLAREDPREFIX       = 0xc00cee65,
    NC_E_EMPTYURI               = 0xc00cee66,
    NC_E_XMLPREFIXRESERVED      = 0xc00cee67,
    NC_E_XMLNSPREFIXRESERVED    = 0xc00cee68,
    NC_E_XMLURIRESERVED         = 0xc00cee69,
    NC_E_XMLNSURIRESERVED       = 0xc00cee6a,
    SC_E_SC                     = 0xc00cee80,
    SC_E_MAXELEMENTDEPTH        = 0xc00cee81,
    SC_E_MAXENTITYEXPANSION     = 0xc00cee82,
    WR_E_WR                     = 0xc00cef00,
    WR_E_NONWHITESPACE          = 0xc00cef01,
    WR_E_NSPREFIXDECLARED       = 0xc00cef02,
    WR_E_NSPREFIXWITHEMPTYNSURI = 0xc00cef03,
    WR_E_DUPLICATEATTRIBUTE     = 0xc00cef04,
    WR_E_XMLNSPREFIXDECLARATION = 0xc00cef05,
    WR_E_XMLPREFIXDECLARATION   = 0xc00cef06,
    WR_E_XMLURIDECLARATION      = 0xc00cef07,
    WR_E_XMLNSURIDECLARATION    = 0xc00cef08,
    WR_E_NAMESPACEUNDECLARED    = 0xc00cef09,
    WR_E_INVALIDXMLSPACE        = 0xc00cef0a,
    WR_E_INVALIDACTION          = 0xc00cef0b,
    WR_E_INVALIDSURROGATEPAIR   = 0xc00cef0c,
    XML_E_INVALID_DECIMAL       = 0xc00ce01d,
    XML_E_INVALID_HEXIDECIMAL   = 0xc00ce01e,
    XML_E_INVALID_UNICODE       = 0xc00ce01f,
    XML_E_INVALIDENCODING       = 0xc00ce06e,
}

enum XmlStandalone : int
{
    XmlStandalone_Omit  = 0x00000000,
    XmlStandalone_Yes   = 0x00000001,
    XmlStandalone_No    = 0x00000002,
    _XmlStandalone_Last = 0x00000002,
}

enum XmlWriterProperty : int
{
    XmlWriterProperty_MultiLanguage       = 0x00000000,
    XmlWriterProperty_Indent              = 0x00000001,
    XmlWriterProperty_ByteOrderMark       = 0x00000002,
    XmlWriterProperty_OmitXmlDeclaration  = 0x00000003,
    XmlWriterProperty_ConformanceLevel    = 0x00000004,
    XmlWriterProperty_CompactEmptyElement = 0x00000005,
    _XmlWriterProperty_Last               = 0x00000005,
}

// Functions

@DllImport("XmlLite.dll")
HRESULT CreateXmlReader(const(GUID)* riid, void** ppvObject, IMalloc pMalloc);

@DllImport("XmlLite.dll")
HRESULT CreateXmlReaderInputWithEncodingCodePage(IUnknown pInputStream, IMalloc pMalloc, uint nEncodingCodePage, 
                                                 BOOL fEncodingHint, const(PWSTR) pwszBaseUri, IUnknown* ppInput);

@DllImport("XmlLite.dll")
HRESULT CreateXmlReaderInputWithEncodingName(IUnknown pInputStream, IMalloc pMalloc, const(PWSTR) pwszEncodingName, 
                                             BOOL fEncodingHint, const(PWSTR) pwszBaseUri, IUnknown* ppInput);

@DllImport("XmlLite.dll")
HRESULT CreateXmlWriter(const(GUID)* riid, void** ppvObject, IMalloc pMalloc);

@DllImport("XmlLite.dll")
HRESULT CreateXmlWriterOutputWithEncodingCodePage(IUnknown pOutputStream, IMalloc pMalloc, uint nEncodingCodePage, 
                                                  IUnknown* ppOutput);

@DllImport("XmlLite.dll")
HRESULT CreateXmlWriterOutputWithEncodingName(IUnknown pOutputStream, IMalloc pMalloc, 
                                              const(PWSTR) pwszEncodingName, IUnknown* ppOutput);


// Interfaces

@GUID("7279fc81-709d-4095-b63d-69fe4b0d9030")
interface IXmlReader : IUnknown
{
    HRESULT SetInput(IUnknown pInput);
    HRESULT GetProperty(uint nProperty, ptrdiff_t* ppValue);
    HRESULT SetProperty(uint nProperty, ptrdiff_t pValue);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Read(XmlNodeType* pNodeType);
    HRESULT GetNodeType(XmlNodeType* pNodeType);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT MoveToFirstAttribute();
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT MoveToNextAttribute();
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT MoveToAttributeByName(const(PWSTR) pwszLocalName, const(PWSTR) pwszNamespaceUri);
    HRESULT MoveToElement();
    HRESULT GetQualifiedName(const(PWSTR)* ppwszQualifiedName, uint* pcwchQualifiedName);
    HRESULT GetNamespaceUri(const(PWSTR)* ppwszNamespaceUri, uint* pcwchNamespaceUri);
    HRESULT GetLocalName(const(PWSTR)* ppwszLocalName, uint* pcwchLocalName);
    HRESULT GetPrefix(const(PWSTR)* ppwszPrefix, uint* pcwchPrefix);
    HRESULT GetValue(const(PWSTR)* ppwszValue, uint* pcwchValue);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT ReadValueChunk(PWSTR pwchBuffer, uint cwchChunkSize, uint* pcwchRead);
    HRESULT GetBaseUri(const(PWSTR)* ppwszBaseUri, uint* pcwchBaseUri);
    BOOL    IsDefault();
    BOOL    IsEmptyElement();
    HRESULT GetLineNumber(uint* pnLineNumber);
    HRESULT GetLinePosition(uint* pnLinePosition);
    HRESULT GetAttributeCount(uint* pnAttributeCount);
    HRESULT GetDepth(uint* pnDepth);
    BOOL    IsEOF();
}

@GUID("7279fc82-709d-4095-b63d-69fe4b0d9030")
interface IXmlResolver : IUnknown
{
    HRESULT ResolveUri(const(PWSTR) pwszBaseUri, const(PWSTR) pwszPublicIdentifier, 
                       const(PWSTR) pwszSystemIdentifier, IUnknown* ppResolvedInput);
}

@GUID("7279fc88-709d-4095-b63d-69fe4b0d9030")
interface IXmlWriter : IUnknown
{
    HRESULT SetOutput(IUnknown pOutput);
    HRESULT GetProperty(uint nProperty, ptrdiff_t* ppValue);
    HRESULT SetProperty(uint nProperty, ptrdiff_t pValue);
    HRESULT WriteAttributes(IXmlReader pReader, BOOL fWriteDefaultAttributes);
    HRESULT WriteAttributeString(const(PWSTR) pwszPrefix, const(PWSTR) pwszLocalName, 
                                 const(PWSTR) pwszNamespaceUri, const(PWSTR) pwszValue);
    HRESULT WriteCData(const(PWSTR) pwszText);
    HRESULT WriteCharEntity(wchar wch);
    HRESULT WriteChars(const(PWSTR) pwch, uint cwch);
    HRESULT WriteComment(const(PWSTR) pwszComment);
    HRESULT WriteDocType(const(PWSTR) pwszName, const(PWSTR) pwszPublicId, const(PWSTR) pwszSystemId, 
                         const(PWSTR) pwszSubset);
    HRESULT WriteElementString(const(PWSTR) pwszPrefix, const(PWSTR) pwszLocalName, const(PWSTR) pwszNamespaceUri, 
                               const(PWSTR) pwszValue);
    HRESULT WriteEndDocument();
    HRESULT WriteEndElement();
    HRESULT WriteEntityRef(const(PWSTR) pwszName);
    HRESULT WriteFullEndElement();
    HRESULT WriteName(const(PWSTR) pwszName);
    HRESULT WriteNmToken(const(PWSTR) pwszNmToken);
    HRESULT WriteNode(IXmlReader pReader, BOOL fWriteDefaultAttributes);
    HRESULT WriteNodeShallow(IXmlReader pReader, BOOL fWriteDefaultAttributes);
    HRESULT WriteProcessingInstruction(const(PWSTR) pwszName, const(PWSTR) pwszText);
    HRESULT WriteQualifiedName(const(PWSTR) pwszLocalName, const(PWSTR) pwszNamespaceUri);
    HRESULT WriteRaw(const(PWSTR) pwszData);
    HRESULT WriteRawChars(const(PWSTR) pwch, uint cwch);
    HRESULT WriteStartDocument(XmlStandalone standalone);
    HRESULT WriteStartElement(const(PWSTR) pwszPrefix, const(PWSTR) pwszLocalName, const(PWSTR) pwszNamespaceUri);
    HRESULT WriteString(const(PWSTR) pwszText);
    HRESULT WriteSurrogateCharEntity(wchar wchLow, wchar wchHigh);
    HRESULT WriteWhitespace(const(PWSTR) pwszWhitespace);
    HRESULT Flush();
}

@GUID("862494c6-1310-4aad-b3cd-2dbeebf670d3")
interface IXmlWriterLite : IUnknown
{
    HRESULT SetOutput(IUnknown pOutput);
    HRESULT GetProperty(uint nProperty, ptrdiff_t* ppValue);
    HRESULT SetProperty(uint nProperty, ptrdiff_t pValue);
    HRESULT WriteAttributes(IXmlReader pReader, BOOL fWriteDefaultAttributes);
    HRESULT WriteAttributeString(const(PWSTR) pwszQName, uint cwszQName, const(PWSTR) pwszValue, uint cwszValue);
    HRESULT WriteCData(const(PWSTR) pwszText);
    HRESULT WriteCharEntity(wchar wch);
    HRESULT WriteChars(const(PWSTR) pwch, uint cwch);
    HRESULT WriteComment(const(PWSTR) pwszComment);
    HRESULT WriteDocType(const(PWSTR) pwszName, const(PWSTR) pwszPublicId, const(PWSTR) pwszSystemId, 
                         const(PWSTR) pwszSubset);
    HRESULT WriteElementString(const(PWSTR) pwszQName, uint cwszQName, const(PWSTR) pwszValue);
    HRESULT WriteEndDocument();
    HRESULT WriteEndElement(const(PWSTR) pwszQName, uint cwszQName);
    HRESULT WriteEntityRef(const(PWSTR) pwszName);
    HRESULT WriteFullEndElement(const(PWSTR) pwszQName, uint cwszQName);
    HRESULT WriteName(const(PWSTR) pwszName);
    HRESULT WriteNmToken(const(PWSTR) pwszNmToken);
    HRESULT WriteNode(IXmlReader pReader, BOOL fWriteDefaultAttributes);
    HRESULT WriteNodeShallow(IXmlReader pReader, BOOL fWriteDefaultAttributes);
    HRESULT WriteProcessingInstruction(const(PWSTR) pwszName, const(PWSTR) pwszText);
    HRESULT WriteRaw(const(PWSTR) pwszData);
    HRESULT WriteRawChars(const(PWSTR) pwch, uint cwch);
    HRESULT WriteStartDocument(XmlStandalone standalone);
    HRESULT WriteStartElement(const(PWSTR) pwszQName, uint cwszQName);
    HRESULT WriteString(const(PWSTR) pwszText);
    HRESULT WriteSurrogateCharEntity(wchar wchLow, wchar wchHigh);
    HRESULT WriteWhitespace(const(PWSTR) pwszWhitespace);
    HRESULT Flush();
}


// GUIDs


const GUID IID_IXmlReader     = GUIDOF!IXmlReader;
const GUID IID_IXmlResolver   = GUIDOF!IXmlResolver;
const GUID IID_IXmlWriter     = GUIDOF!IXmlWriter;
const GUID IID_IXmlWriterLite = GUIDOF!IXmlWriterLite;
