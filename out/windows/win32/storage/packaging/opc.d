// Written in the D programming language.

module windows.win32.storage.packaging.opc;

public import windows.core;
public import windows.win32.foundation : BOOL, HRESULT, PWSTR;
public import windows.win32.security.cryptography : CERT_CONTEXT;
public import windows.win32.security : SECURITY_ATTRIBUTES;
public import windows.win32.system.com : IStream, IUnknown, IUri;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/ne-msopc-opc_uri_target_mode))], [])
alias OPC_URI_TARGET_MODE = int;
enum : int
{
    OPC_URI_TARGET_MODE_INTERNAL = 0x00000000,
    OPC_URI_TARGET_MODE_EXTERNAL = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/ne-msopc-opc_compression_options))], [])
alias OPC_COMPRESSION_OPTIONS = int;
enum : int
{
    OPC_COMPRESSION_NONE      = 0xffffffff,
    OPC_COMPRESSION_NORMAL    = 0x00000000,
    OPC_COMPRESSION_MAXIMUM   = 0x00000001,
    OPC_COMPRESSION_FAST      = 0x00000002,
    OPC_COMPRESSION_SUPERFAST = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/ne-msopc-opc_stream_io_mode))], [])
alias OPC_STREAM_IO_MODE = int;
enum : int
{
    OPC_STREAM_IO_READ  = 0x00000001,
    OPC_STREAM_IO_WRITE = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/ne-msopc-opc_read_flags))], [])
alias OPC_READ_FLAGS = int;
enum : int
{
    OPC_READ_DEFAULT     = 0x00000000,
    OPC_VALIDATE_ON_LOAD = 0x00000001,
    OPC_CACHE_ON_ACCESS  = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/ne-msopc-opc_write_flags))], [])
alias OPC_WRITE_FLAGS = int;
enum : int
{
    OPC_WRITE_DEFAULT     = 0x00000000,
    OPC_WRITE_FORCE_ZIP32 = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/ne-msopc-opc_signature_validation_result))], [])
alias OPC_SIGNATURE_VALIDATION_RESULT = int;
enum : int
{
    OPC_SIGNATURE_VALID   = 0x00000000,
    OPC_SIGNATURE_INVALID = 0xffffffff,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/ne-msopc-opc_canonicalization_method))], [])
alias OPC_CANONICALIZATION_METHOD = int;
enum : int
{
    OPC_CANONICALIZATION_NONE               = 0x00000000,
    OPC_CANONICALIZATION_C14N               = 0x00000001,
    OPC_CANONICALIZATION_C14N_WITH_COMMENTS = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/ne-msopc-opc_relationship_selector))], [])
alias OPC_RELATIONSHIP_SELECTOR = int;
enum : int
{
    OPC_RELATIONSHIP_SELECT_BY_ID   = 0x00000000,
    OPC_RELATIONSHIP_SELECT_BY_TYPE = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/ne-msopc-opc_relationships_signing_option))], [])
alias OPC_RELATIONSHIPS_SIGNING_OPTION = int;
enum : int
{
    OPC_RELATIONSHIP_SIGN_USING_SELECTORS = 0x00000000,
    OPC_RELATIONSHIP_SIGN_PART            = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/ne-msopc-opc_certificate_embedding_option))], [])
alias OPC_CERTIFICATE_EMBEDDING_OPTION = int;
enum : int
{
    OPC_CERTIFICATE_IN_CERTIFICATE_PART = 0x00000000,
    OPC_CERTIFICATE_IN_SIGNATURE_PART   = 0x00000001,
    OPC_CERTIFICATE_NOT_EMBEDDED        = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/ne-msopc-opc_signature_time_format))], [])
alias OPC_SIGNATURE_TIME_FORMAT = int;
enum : int
{
    OPC_SIGNATURE_TIME_FORMAT_MILLISECONDS = 0x00000000,
    OPC_SIGNATURE_TIME_FORMAT_SECONDS      = 0x00000001,
    OPC_SIGNATURE_TIME_FORMAT_MINUTES      = 0x00000002,
    OPC_SIGNATURE_TIME_FORMAT_DAYS         = 0x00000003,
    OPC_SIGNATURE_TIME_FORMAT_MONTHS       = 0x00000004,
    OPC_SIGNATURE_TIME_FORMAT_YEARS        = 0x00000005,
}

// Constants


enum HRESULT OPC_E_NONCONFORMING_URI = HRESULT(0x80510001);

enum : HRESULT
{
    OPC_E_RELATIVE_URI_REQUIRED     = HRESULT(0x80510002),
    OPC_E_RELATIONSHIP_URI_REQUIRED = HRESULT(0x80510003),
}

enum HRESULT OPC_E_PART_CANNOT_BE_DIRECTORY = HRESULT(0x80510004);
enum HRESULT OPC_E_UNEXPECTED_CONTENT_TYPE = HRESULT(0x80510005);
enum HRESULT OPC_E_INVALID_CONTENT_TYPE_XML = HRESULT(0x80510006);
enum HRESULT OPC_E_MISSING_CONTENT_TYPES = HRESULT(0x80510007);

enum : HRESULT
{
    OPC_E_NONCONFORMING_CONTENT_TYPES_XML = HRESULT(0x80510008),
    OPC_E_NONCONFORMING_RELS_XML          = HRESULT(0x80510009),
}

enum HRESULT OPC_E_INVALID_RELS_XML = HRESULT(0x8051000a);
enum HRESULT OPC_E_DUPLICATE_PART = HRESULT(0x8051000b);
enum HRESULT OPC_E_INVALID_OVERRIDE_PART_NAME = HRESULT(0x8051000c);
enum HRESULT OPC_E_DUPLICATE_OVERRIDE_PART = HRESULT(0x8051000d);
enum HRESULT OPC_E_INVALID_DEFAULT_EXTENSION = HRESULT(0x8051000e);
enum HRESULT OPC_E_DUPLICATE_DEFAULT_EXTENSION = HRESULT(0x8051000f);

enum : HRESULT
{
    OPC_E_INVALID_RELATIONSHIP_ID     = HRESULT(0x80510010),
    OPC_E_INVALID_RELATIONSHIP_TYPE   = HRESULT(0x80510011),
    OPC_E_INVALID_RELATIONSHIP_TARGET = HRESULT(0x80510012),
}

enum HRESULT OPC_E_DUPLICATE_RELATIONSHIP = HRESULT(0x80510013);
enum HRESULT OPC_E_CONFLICTING_SETTINGS = HRESULT(0x80510014);
enum HRESULT OPC_E_DUPLICATE_PIECE = HRESULT(0x80510015);
enum HRESULT OPC_E_INVALID_PIECE = HRESULT(0x80510016);
enum HRESULT OPC_E_MISSING_PIECE = HRESULT(0x80510017);
enum HRESULT OPC_E_NO_SUCH_PART = HRESULT(0x80510018);
enum HRESULT OPC_E_DS_SIGNATURE_CORRUPT = HRESULT(0x80510019);
enum HRESULT OPC_E_DS_DIGEST_VALUE_ERROR = HRESULT(0x8051001a);
enum HRESULT OPC_E_DS_DUPLICATE_SIGNATURE_ORIGIN_RELATIONSHIP = HRESULT(0x8051001b);
enum HRESULT OPC_E_DS_INVALID_SIGNATURE_ORIGIN_RELATIONSHIP = HRESULT(0x8051001c);
enum HRESULT OPC_E_DS_INVALID_CERTIFICATE_RELATIONSHIP = HRESULT(0x8051001d);
enum HRESULT OPC_E_DS_EXTERNAL_SIGNATURE = HRESULT(0x8051001e);

enum : HRESULT
{
    OPC_E_DS_MISSING_SIGNATURE_ORIGIN_PART = HRESULT(0x8051001f),
    OPC_E_DS_MISSING_SIGNATURE_PART        = HRESULT(0x80510020),
}

enum HRESULT OPC_E_DS_INVALID_RELATIONSHIP_TRANSFORM_XML = HRESULT(0x80510021);

enum : HRESULT
{
    OPC_E_DS_INVALID_CANONICALIZATION_METHOD      = HRESULT(0x80510022),
    OPC_E_DS_INVALID_RELATIONSHIPS_SIGNING_OPTION = HRESULT(0x80510023),
}

enum HRESULT OPC_E_DS_INVALID_OPC_SIGNATURE_TIME_FORMAT = HRESULT(0x80510024);
enum HRESULT OPC_E_DS_PACKAGE_REFERENCE_URI_RESERVED = HRESULT(0x80510025);

enum : HRESULT
{
    OPC_E_DS_MISSING_SIGNATURE_PROPERTIES_ELEMENT = HRESULT(0x80510026),
    OPC_E_DS_MISSING_SIGNATURE_PROPERTY_ELEMENT   = HRESULT(0x80510027),
}

enum HRESULT OPC_E_DS_DUPLICATE_SIGNATURE_PROPERTY_ELEMENT = HRESULT(0x80510028);
enum HRESULT OPC_E_DS_MISSING_SIGNATURE_TIME_PROPERTY = HRESULT(0x80510029);

enum : HRESULT
{
    OPC_E_DS_INVALID_SIGNATURE_XML   = HRESULT(0x8051002a),
    OPC_E_DS_INVALID_SIGNATURE_COUNT = HRESULT(0x8051002b),
}

enum HRESULT OPC_E_DS_MISSING_SIGNATURE_ALGORITHM = HRESULT(0x8051002c);
enum HRESULT OPC_E_DS_DUPLICATE_PACKAGE_OBJECT_REFERENCES = HRESULT(0x8051002d);
enum HRESULT OPC_E_DS_MISSING_PACKAGE_OBJECT_REFERENCE = HRESULT(0x8051002e);
enum HRESULT OPC_E_DS_EXTERNAL_SIGNATURE_REFERENCE = HRESULT(0x8051002f);
enum HRESULT OPC_E_DS_REFERENCE_MISSING_CONTENT_TYPE = HRESULT(0x80510030);
enum HRESULT OPC_E_DS_MULTIPLE_RELATIONSHIP_TRANSFORMS = HRESULT(0x80510031);
enum HRESULT OPC_E_DS_MISSING_CANONICALIZATION_TRANSFORM = HRESULT(0x80510032);

enum : HRESULT
{
    OPC_E_MC_UNEXPECTED_ELEMENT       = HRESULT(0x80510033),
    OPC_E_MC_UNEXPECTED_REQUIRES_ATTR = HRESULT(0x80510034),
}

enum HRESULT OPC_E_MC_MISSING_REQUIRES_ATTR = HRESULT(0x80510035);
enum HRESULT OPC_E_MC_UNEXPECTED_ATTR = HRESULT(0x80510036);

enum : HRESULT
{
    OPC_E_MC_INVALID_PREFIX_LIST = HRESULT(0x80510037),
    OPC_E_MC_INVALID_QNAME_LIST  = HRESULT(0x80510038),
}

enum HRESULT OPC_E_MC_NESTED_ALTERNATE_CONTENT = HRESULT(0x80510039);
enum HRESULT OPC_E_MC_UNEXPECTED_CHOICE = HRESULT(0x8051003a);
enum HRESULT OPC_E_MC_MISSING_CHOICE = HRESULT(0x8051003b);
enum HRESULT OPC_E_MC_INVALID_ENUM_TYPE = HRESULT(0x8051003c);

enum : HRESULT
{
    OPC_E_MC_UNKNOWN_NAMESPACE = HRESULT(0x8051003e),
    OPC_E_MC_UNKNOWN_PREFIX    = HRESULT(0x8051003f),
}

enum HRESULT OPC_E_MC_INVALID_ATTRIBUTES_ON_IGNORABLE_ELEMENT = HRESULT(0x80510040);
enum HRESULT OPC_E_MC_INVALID_XMLNS_ATTRIBUTE = HRESULT(0x80510041);
enum HRESULT OPC_E_INVALID_XML_ENCODING = HRESULT(0x80510042);
enum HRESULT OPC_E_DS_SIGNATURE_REFERENCE_MISSING_URI = HRESULT(0x80510043);
enum HRESULT OPC_E_INVALID_CONTENT_TYPE = HRESULT(0x80510044);

enum : HRESULT
{
    OPC_E_DS_SIGNATURE_PROPERTY_MISSING_TARGET = HRESULT(0x80510045),
    OPC_E_DS_SIGNATURE_METHOD_NOT_SET          = HRESULT(0x80510046),
}

enum HRESULT OPC_E_DS_DEFAULT_DIGEST_METHOD_NOT_SET = HRESULT(0x80510047);
enum HRESULT OPC_E_NO_SUCH_RELATIONSHIP = HRESULT(0x80510048);
enum HRESULT OPC_E_MC_MULTIPLE_FALLBACK_ELEMENTS = HRESULT(0x80510049);

enum : HRESULT
{
    OPC_E_MC_INCONSISTENT_PROCESS_CONTENT     = HRESULT(0x8051004a),
    OPC_E_MC_INCONSISTENT_PRESERVE_ATTRIBUTES = HRESULT(0x8051004b),
    OPC_E_MC_INCONSISTENT_PRESERVE_ELEMENTS   = HRESULT(0x8051004c),
}

enum HRESULT OPC_E_INVALID_RELATIONSHIP_TARGET_MODE = HRESULT(0x8051004d);
enum HRESULT OPC_E_COULD_NOT_RECOVER = HRESULT(0x8051004e);
enum HRESULT OPC_E_UNSUPPORTED_PACKAGE = HRESULT(0x8051004f);

enum : HRESULT
{
    OPC_E_ENUM_COLLECTION_CHANGED   = HRESULT(0x80510050),
    OPC_E_ENUM_CANNOT_MOVE_NEXT     = HRESULT(0x80510051),
    OPC_E_ENUM_CANNOT_MOVE_PREVIOUS = HRESULT(0x80510052),
}

enum HRESULT OPC_E_ENUM_INVALID_POSITION = HRESULT(0x80510053);
enum HRESULT OPC_E_DS_SIGNATURE_ORIGIN_EXISTS = HRESULT(0x80510054);
enum HRESULT OPC_E_DS_UNSIGNED_PACKAGE = HRESULT(0x80510055);
enum HRESULT OPC_E_DS_MISSING_CERTIFICATE_PART = HRESULT(0x80510056);
enum HRESULT OPC_E_NO_SUCH_SETTINGS = HRESULT(0x80510057);
enum HRESULT OPC_E_ZIP_INCORRECT_DATA_SIZE = HRESULT(0x80511001);

enum : HRESULT
{
    OPC_E_ZIP_CORRUPTED_ARCHIVE  = HRESULT(0x80511002),
    OPC_E_ZIP_COMPRESSION_FAILED = HRESULT(0x80511003),
}

enum HRESULT OPC_E_ZIP_DECOMPRESSION_FAILED = HRESULT(0x80511004);

enum : HRESULT
{
    OPC_E_ZIP_INCONSISTENT_FILEITEM  = HRESULT(0x80511005),
    OPC_E_ZIP_INCONSISTENT_DIRECTORY = HRESULT(0x80511006),
}

enum HRESULT OPC_E_ZIP_MISSING_DATA_DESCRIPTOR = HRESULT(0x80511007);
enum HRESULT OPC_E_ZIP_UNSUPPORTEDARCHIVE = HRESULT(0x80511008);
enum HRESULT OPC_E_ZIP_CENTRAL_DIRECTORY_TOO_LARGE = HRESULT(0x80511009);

enum : HRESULT
{
    OPC_E_ZIP_NAME_TOO_LARGE    = HRESULT(0x8051100a),
    OPC_E_ZIP_DUPLICATE_NAME    = HRESULT(0x8051100b),
    OPC_E_ZIP_COMMENT_TOO_LARGE = HRESULT(0x8051100c),
}

enum HRESULT OPC_E_ZIP_EXTRA_FIELDS_TOO_LARGE = HRESULT(0x8051100d);
enum HRESULT OPC_E_ZIP_FILE_HEADER_TOO_LARGE = HRESULT(0x8051100e);
enum HRESULT OPC_E_ZIP_MISSING_END_OF_CENTRAL_DIRECTORY = HRESULT(0x8051100f);
enum HRESULT OPC_E_ZIP_REQUIRES_64_BIT = HRESULT(0x80511010);

// Interfaces

@GUID("6b2d6ba0-9f3e-4f27-920b-313cc426a39e")
struct OpcFactory;

@GUID("bc9c1b9b-d62c-49eb-aef0-3b4e0b28ebed")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcuri))], [])
interface IOpcUri : IUri
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcuri-getrelationshipsparturi))], [])
    HRESULT GetRelationshipsPartUri(IOpcPartUri* relationshipPartUri);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcuri-getrelativeuri))], [])
    HRESULT GetRelativeUri(IOpcPartUri targetPartUri, IUri* relativeUri);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcuri-combineparturi))], [])
    HRESULT CombinePartUri(IUri relativeUri, IOpcPartUri* combinedUri);
}

@GUID("7d3babe7-88b2-46ba-85cb-4203cb016c87")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcparturi))], [])
interface IOpcPartUri : IOpcUri
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcparturi-compareparturi))], [])
    HRESULT ComparePartUri(IOpcPartUri partUri, int* comparisonResult);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcparturi-getsourceuri))], [])
    HRESULT GetSourceUri(IOpcUri* sourceUri);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcparturi-isrelationshipsparturi))], [])
    HRESULT IsRelationshipsPartUri(BOOL* isRelationshipUri);
}

@GUID("42195949-3b79-4fc8-89c6-fc7fb979ee70")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcpackage))], [])
interface IOpcPackage : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcpackage-getpartset))], [])
    HRESULT GetPartSet(IOpcPartSet* partSet);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcpackage-getrelationshipset))], [])
    HRESULT GetRelationshipSet(IOpcRelationshipSet* relationshipSet);
}

@GUID("42195949-3b79-4fc8-89c6-fc7fb979ee71")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcpart))], [])
interface IOpcPart : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcpart-getrelationshipset))], [])
    HRESULT GetRelationshipSet(IOpcRelationshipSet* relationshipSet);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcpart-getcontentstream))], [])
    HRESULT GetContentStream(IStream* stream);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcpart-getname))], [])
    HRESULT GetName(IOpcPartUri* name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcpart-getcontenttype))], [])
    HRESULT GetContentType(PWSTR* contentType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcpart-getcompressionoptions))], [])
    HRESULT GetCompressionOptions(OPC_COMPRESSION_OPTIONS* compressionOptions);
}

@GUID("42195949-3b79-4fc8-89c6-fc7fb979ee72")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcrelationship))], [])
interface IOpcRelationship : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcrelationship-getid))], [])
    HRESULT GetId(PWSTR* relationshipIdentifier);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcrelationship-getrelationshiptype))], [])
    HRESULT GetRelationshipType(PWSTR* relationshipType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcrelationship-getsourceuri))], [])
    HRESULT GetSourceUri(IOpcUri* sourceUri);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcrelationship-gettargeturi))], [])
    HRESULT GetTargetUri(IUri* targetUri);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcrelationship-gettargetmode))], [])
    HRESULT GetTargetMode(OPC_URI_TARGET_MODE* targetMode);
}

@GUID("42195949-3b79-4fc8-89c6-fc7fb979ee73")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcpartset))], [])
interface IOpcPartSet : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcpartset-getpart))], [])
    HRESULT GetPart(IOpcPartUri name, IOpcPart* part);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcpartset-createpart))], [])
    HRESULT CreatePart(IOpcPartUri name, const(PWSTR) contentType, OPC_COMPRESSION_OPTIONS compressionOptions, 
                       IOpcPart* part);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcpartset-deletepart))], [])
    HRESULT DeletePart(IOpcPartUri name);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcpartset-partexists))], [])
    HRESULT PartExists(IOpcPartUri name, BOOL* partExists);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcpartset-getenumerator))], [])
    HRESULT GetEnumerator(IOpcPartEnumerator* partEnumerator);
}

@GUID("42195949-3b79-4fc8-89c6-fc7fb979ee74")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcrelationshipset))], [])
interface IOpcRelationshipSet : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcrelationshipset-getrelationship))], [])
    HRESULT GetRelationship(const(PWSTR) relationshipIdentifier, IOpcRelationship* relationship);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcrelationshipset-createrelationship))], [])
    HRESULT CreateRelationship(const(PWSTR) relationshipIdentifier, const(PWSTR) relationshipType, IUri targetUri, 
                               OPC_URI_TARGET_MODE targetMode, IOpcRelationship* relationship);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcrelationshipset-deleterelationship))], [])
    HRESULT DeleteRelationship(const(PWSTR) relationshipIdentifier);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcrelationshipset-relationshipexists))], [])
    HRESULT RelationshipExists(const(PWSTR) relationshipIdentifier, BOOL* relationshipExists);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcrelationshipset-getenumerator))], [])
    HRESULT GetEnumerator(IOpcRelationshipEnumerator* relationshipEnumerator);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcrelationshipset-getenumeratorfortype))], [])
    HRESULT GetEnumeratorForType(const(PWSTR) relationshipType, IOpcRelationshipEnumerator* relationshipEnumerator);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcrelationshipset-getrelationshipscontentstream))], [])
    HRESULT GetRelationshipsContentStream(IStream* contents);
}

@GUID("42195949-3b79-4fc8-89c6-fc7fb979ee75")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcpartenumerator))], [])
interface IOpcPartEnumerator : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcpartenumerator-movenext))], [])
    HRESULT MoveNext(BOOL* hasNext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcpartenumerator-moveprevious))], [])
    HRESULT MovePrevious(BOOL* hasPrevious);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcpartenumerator-getcurrent))], [])
    HRESULT GetCurrent(IOpcPart* part);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcpartenumerator-clone))], [])
    HRESULT Clone(IOpcPartEnumerator* copy);
}

@GUID("42195949-3b79-4fc8-89c6-fc7fb979ee76")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcrelationshipenumerator))], [])
interface IOpcRelationshipEnumerator : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcrelationshipenumerator-movenext))], [])
    HRESULT MoveNext(BOOL* hasNext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcrelationshipenumerator-moveprevious))], [])
    HRESULT MovePrevious(BOOL* hasPrevious);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcrelationshipenumerator-getcurrent))], [])
    HRESULT GetCurrent(IOpcRelationship* relationship);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcrelationshipenumerator-clone))], [])
    HRESULT Clone(IOpcRelationshipEnumerator* copy);
}

@GUID("e24231ca-59f4-484e-b64b-36eeda36072c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcsignaturepartreference))], [])
interface IOpcSignaturePartReference : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturepartreference-getpartname))], [])
    HRESULT GetPartName(IOpcPartUri* partName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturepartreference-getcontenttype))], [])
    HRESULT GetContentType(PWSTR* contentType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturepartreference-getdigestmethod))], [])
    HRESULT GetDigestMethod(PWSTR* digestMethod);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturepartreference-getdigestvalue))], [])
    HRESULT GetDigestValue(ubyte** digestValue, uint* count);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturepartreference-gettransformmethod))], [])
    HRESULT GetTransformMethod(OPC_CANONICALIZATION_METHOD* transformMethod);
}

@GUID("57babac6-9d4a-4e50-8b86-e5d4051eae7c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcsignaturerelationshipreference))], [])
interface IOpcSignatureRelationshipReference : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturerelationshipreference-getsourceuri))], [])
    HRESULT GetSourceUri(IOpcUri* sourceUri);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturerelationshipreference-getdigestmethod))], [])
    HRESULT GetDigestMethod(PWSTR* digestMethod);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturerelationshipreference-getdigestvalue))], [])
    HRESULT GetDigestValue(ubyte** digestValue, uint* count);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturerelationshipreference-gettransformmethod))], [])
    HRESULT GetTransformMethod(OPC_CANONICALIZATION_METHOD* transformMethod);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturerelationshipreference-getrelationshipsigningoption))], [])
    HRESULT GetRelationshipSigningOption(OPC_RELATIONSHIPS_SIGNING_OPTION* relationshipSigningOption);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturerelationshipreference-getrelationshipselectorenumerator))], [])
    HRESULT GetRelationshipSelectorEnumerator(IOpcRelationshipSelectorEnumerator* selectorEnumerator);
}

@GUID("f8f26c7f-b28f-4899-84c8-5d5639ede75f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcrelationshipselector))], [])
interface IOpcRelationshipSelector : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcrelationshipselector-getselectortype))], [])
    HRESULT GetSelectorType(OPC_RELATIONSHIP_SELECTOR* selector);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcrelationshipselector-getselectioncriterion))], [])
    HRESULT GetSelectionCriterion(PWSTR* selectionCriterion);
}

@GUID("1b47005e-3011-4edc-be6f-0f65e5ab0342")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcsignaturereference))], [])
interface IOpcSignatureReference : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturereference-getid))], [])
    HRESULT GetId(PWSTR* referenceId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturereference-geturi))], [])
    HRESULT GetUri(IUri* referenceUri);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturereference-gettype))], [])
    HRESULT GetType(PWSTR* type);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturereference-gettransformmethod))], [])
    HRESULT GetTransformMethod(OPC_CANONICALIZATION_METHOD* transformMethod);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturereference-getdigestmethod))], [])
    HRESULT GetDigestMethod(PWSTR* digestMethod);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturereference-getdigestvalue))], [])
    HRESULT GetDigestValue(ubyte** digestValue, uint* count);
}

@GUID("5d77a19e-62c1-44e7-becd-45da5ae51a56")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcsignaturecustomobject))], [])
interface IOpcSignatureCustomObject : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturecustomobject-getxml))], [])
    HRESULT GetXml(ubyte** xmlMarkup, uint* count);
}

@GUID("52ab21dd-1cd0-4949-bc80-0c1232d00cb4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcdigitalsignature))], [])
interface IOpcDigitalSignature : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcdigitalsignature-getnamespaces))], [])
    HRESULT GetNamespaces(PWSTR** prefixes, PWSTR** namespaces, uint* count);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcdigitalsignature-getsignatureid))], [])
    HRESULT GetSignatureId(PWSTR* signatureId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcdigitalsignature-getsignaturepartname))], [])
    HRESULT GetSignaturePartName(IOpcPartUri* signaturePartName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcdigitalsignature-getsignaturemethod))], [])
    HRESULT GetSignatureMethod(PWSTR* signatureMethod);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcdigitalsignature-getcanonicalizationmethod))], [])
    HRESULT GetCanonicalizationMethod(OPC_CANONICALIZATION_METHOD* canonicalizationMethod);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcdigitalsignature-getsignaturevalue))], [])
    HRESULT GetSignatureValue(ubyte** signatureValue, uint* count);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcdigitalsignature-getsignaturepartreferenceenumerator))], [])
    HRESULT GetSignaturePartReferenceEnumerator(IOpcSignaturePartReferenceEnumerator* partReferenceEnumerator);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcdigitalsignature-getsignaturerelationshipreferenceenumerator))], [])
    HRESULT GetSignatureRelationshipReferenceEnumerator(IOpcSignatureRelationshipReferenceEnumerator* relationshipReferenceEnumerator);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcdigitalsignature-getsigningtime))], [])
    HRESULT GetSigningTime(PWSTR* signingTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcdigitalsignature-gettimeformat))], [])
    HRESULT GetTimeFormat(OPC_SIGNATURE_TIME_FORMAT* timeFormat);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcdigitalsignature-getpackageobjectreference))], [])
    HRESULT GetPackageObjectReference(IOpcSignatureReference* packageObjectReference);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcdigitalsignature-getcertificateenumerator))], [])
    HRESULT GetCertificateEnumerator(IOpcCertificateEnumerator* certificateEnumerator);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcdigitalsignature-getcustomreferenceenumerator))], [])
    HRESULT GetCustomReferenceEnumerator(IOpcSignatureReferenceEnumerator* customReferenceEnumerator);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcdigitalsignature-getcustomobjectenumerator))], [])
    HRESULT GetCustomObjectEnumerator(IOpcSignatureCustomObjectEnumerator* customObjectEnumerator);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcdigitalsignature-getsignaturexml))], [])
    HRESULT GetSignatureXml(ubyte** signatureXml, uint* count);
}

@GUID("50d2d6a5-7aeb-46c0-b241-43ab0e9b407e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcsigningoptions))], [])
interface IOpcSigningOptions : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsigningoptions-getsignatureid))], [])
    HRESULT GetSignatureId(PWSTR* signatureId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsigningoptions-setsignatureid))], [])
    HRESULT SetSignatureId(const(PWSTR) signatureId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsigningoptions-getsignaturemethod))], [])
    HRESULT GetSignatureMethod(PWSTR* signatureMethod);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsigningoptions-setsignaturemethod))], [])
    HRESULT SetSignatureMethod(const(PWSTR) signatureMethod);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsigningoptions-getdefaultdigestmethod))], [])
    HRESULT GetDefaultDigestMethod(PWSTR* digestMethod);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsigningoptions-setdefaultdigestmethod))], [])
    HRESULT SetDefaultDigestMethod(const(PWSTR) digestMethod);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsigningoptions-getcertificateembeddingoption))], [])
    HRESULT GetCertificateEmbeddingOption(OPC_CERTIFICATE_EMBEDDING_OPTION* embeddingOption);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsigningoptions-setcertificateembeddingoption))], [])
    HRESULT SetCertificateEmbeddingOption(OPC_CERTIFICATE_EMBEDDING_OPTION embeddingOption);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsigningoptions-gettimeformat))], [])
    HRESULT GetTimeFormat(OPC_SIGNATURE_TIME_FORMAT* timeFormat);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsigningoptions-settimeformat))], [])
    HRESULT SetTimeFormat(OPC_SIGNATURE_TIME_FORMAT timeFormat);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsigningoptions-getsignaturepartreferenceset))], [])
    HRESULT GetSignaturePartReferenceSet(IOpcSignaturePartReferenceSet* partReferenceSet);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsigningoptions-getsignaturerelationshipreferenceset))], [])
    HRESULT GetSignatureRelationshipReferenceSet(IOpcSignatureRelationshipReferenceSet* relationshipReferenceSet);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsigningoptions-getcustomobjectset))], [])
    HRESULT GetCustomObjectSet(IOpcSignatureCustomObjectSet* customObjectSet);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsigningoptions-getcustomreferenceset))], [])
    HRESULT GetCustomReferenceSet(IOpcSignatureReferenceSet* customReferenceSet);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsigningoptions-getcertificateset))], [])
    HRESULT GetCertificateSet(IOpcCertificateSet* certificateSet);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsigningoptions-getsignaturepartname))], [])
    HRESULT GetSignaturePartName(IOpcPartUri* signaturePartName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsigningoptions-setsignaturepartname))], [])
    HRESULT SetSignaturePartName(IOpcPartUri signaturePartName);
}

@GUID("d5e62a0b-696d-462f-94df-72e33cef2659")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcdigitalsignaturemanager))], [])
interface IOpcDigitalSignatureManager : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcdigitalsignaturemanager-getsignatureoriginpartname))], [])
    HRESULT GetSignatureOriginPartName(IOpcPartUri* signatureOriginPartName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcdigitalsignaturemanager-setsignatureoriginpartname))], [])
    HRESULT SetSignatureOriginPartName(IOpcPartUri signatureOriginPartName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcdigitalsignaturemanager-getsignatureenumerator))], [])
    HRESULT GetSignatureEnumerator(IOpcDigitalSignatureEnumerator* signatureEnumerator);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcdigitalsignaturemanager-removesignature))], [])
    HRESULT RemoveSignature(IOpcPartUri signaturePartName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcdigitalsignaturemanager-createsigningoptions))], [])
    HRESULT CreateSigningOptions(IOpcSigningOptions* signingOptions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcdigitalsignaturemanager-validate))], [])
    HRESULT Validate(IOpcDigitalSignature signature, const(CERT_CONTEXT)* certificate, 
                     OPC_SIGNATURE_VALIDATION_RESULT* validationResult);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcdigitalsignaturemanager-sign))], [])
    HRESULT Sign(const(CERT_CONTEXT)* certificate, IOpcSigningOptions signingOptions, 
                 IOpcDigitalSignature* digitalSignature);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcdigitalsignaturemanager-replacesignaturexml))], [])
    HRESULT ReplaceSignatureXml(IOpcPartUri signaturePartName, const(ubyte)* newSignatureXml, uint count, 
                                IOpcDigitalSignature* digitalSignature);
}

@GUID("80eb1561-8c77-49cf-8266-459b356ee99a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcsignaturepartreferenceenumerator))], [])
interface IOpcSignaturePartReferenceEnumerator : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturepartreferenceenumerator-movenext))], [])
    HRESULT MoveNext(BOOL* hasNext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturepartreferenceenumerator-moveprevious))], [])
    HRESULT MovePrevious(BOOL* hasPrevious);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturepartreferenceenumerator-getcurrent))], [])
    HRESULT GetCurrent(IOpcSignaturePartReference* partReference);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturepartreferenceenumerator-clone))], [])
    HRESULT Clone(IOpcSignaturePartReferenceEnumerator* copy);
}

@GUID("773ba3e4-f021-48e4-aa04-9816db5d3495")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcsignaturerelationshipreferenceenumerator))], [])
interface IOpcSignatureRelationshipReferenceEnumerator : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturerelationshipreferenceenumerator-movenext))], [])
    HRESULT MoveNext(BOOL* hasNext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturerelationshipreferenceenumerator-moveprevious))], [])
    HRESULT MovePrevious(BOOL* hasPrevious);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturerelationshipreferenceenumerator-getcurrent))], [])
    HRESULT GetCurrent(IOpcSignatureRelationshipReference* relationshipReference);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturerelationshipreferenceenumerator-clone))], [])
    HRESULT Clone(IOpcSignatureRelationshipReferenceEnumerator* copy);
}

@GUID("5e50a181-a91b-48ac-88d2-bca3d8f8c0b1")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcrelationshipselectorenumerator))], [])
interface IOpcRelationshipSelectorEnumerator : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcrelationshipselectorenumerator-movenext))], [])
    HRESULT MoveNext(BOOL* hasNext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcrelationshipselectorenumerator-moveprevious))], [])
    HRESULT MovePrevious(BOOL* hasPrevious);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcrelationshipselectorenumerator-getcurrent))], [])
    HRESULT GetCurrent(IOpcRelationshipSelector* relationshipSelector);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcrelationshipselectorenumerator-clone))], [])
    HRESULT Clone(IOpcRelationshipSelectorEnumerator* copy);
}

@GUID("cfa59a45-28b1-4868-969e-fa8097fdc12a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcsignaturereferenceenumerator))], [])
interface IOpcSignatureReferenceEnumerator : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturereferenceenumerator-movenext))], [])
    HRESULT MoveNext(BOOL* hasNext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturereferenceenumerator-moveprevious))], [])
    HRESULT MovePrevious(BOOL* hasPrevious);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturereferenceenumerator-getcurrent))], [])
    HRESULT GetCurrent(IOpcSignatureReference* reference);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturereferenceenumerator-clone))], [])
    HRESULT Clone(IOpcSignatureReferenceEnumerator* copy);
}

@GUID("5ee4fe1d-e1b0-4683-8079-7ea0fcf80b4c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcsignaturecustomobjectenumerator))], [])
interface IOpcSignatureCustomObjectEnumerator : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturecustomobjectenumerator-movenext))], [])
    HRESULT MoveNext(BOOL* hasNext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturecustomobjectenumerator-moveprevious))], [])
    HRESULT MovePrevious(BOOL* hasPrevious);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturecustomobjectenumerator-getcurrent))], [])
    HRESULT GetCurrent(IOpcSignatureCustomObject* customObject);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturecustomobjectenumerator-clone))], [])
    HRESULT Clone(IOpcSignatureCustomObjectEnumerator* copy);
}

@GUID("85131937-8f24-421f-b439-59ab24d140b8")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopccertificateenumerator))], [])
interface IOpcCertificateEnumerator : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopccertificateenumerator-movenext))], [])
    HRESULT MoveNext(BOOL* hasNext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopccertificateenumerator-moveprevious))], [])
    HRESULT MovePrevious(BOOL* hasPrevious);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopccertificateenumerator-getcurrent))], [])
    HRESULT GetCurrent(const(CERT_CONTEXT)** certificate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopccertificateenumerator-clone))], [])
    HRESULT Clone(IOpcCertificateEnumerator* copy);
}

@GUID("967b6882-0ba3-4358-b9e7-b64c75063c5e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcdigitalsignatureenumerator))], [])
interface IOpcDigitalSignatureEnumerator : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcdigitalsignatureenumerator-movenext))], [])
    HRESULT MoveNext(BOOL* hasNext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcdigitalsignatureenumerator-moveprevious))], [])
    HRESULT MovePrevious(BOOL* hasPrevious);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcdigitalsignatureenumerator-getcurrent))], [])
    HRESULT GetCurrent(IOpcDigitalSignature* digitalSignature);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcdigitalsignatureenumerator-clone))], [])
    HRESULT Clone(IOpcDigitalSignatureEnumerator* copy);
}

@GUID("6c9fe28c-ecd9-4b22-9d36-7fdde670fec0")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcsignaturepartreferenceset))], [])
interface IOpcSignaturePartReferenceSet : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturepartreferenceset-create))], [])
    HRESULT Create(IOpcPartUri partUri, const(PWSTR) digestMethod, OPC_CANONICALIZATION_METHOD transformMethod, 
                   IOpcSignaturePartReference* partReference);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturepartreferenceset-delete))], [])
    HRESULT Delete(IOpcSignaturePartReference partReference);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturepartreferenceset-getenumerator))], [])
    HRESULT GetEnumerator(IOpcSignaturePartReferenceEnumerator* partReferenceEnumerator);
}

@GUID("9f863ca5-3631-404c-828d-807e0715069b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcsignaturerelationshipreferenceset))], [])
interface IOpcSignatureRelationshipReferenceSet : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturerelationshipreferenceset-create))], [])
    HRESULT Create(IOpcUri sourceUri, const(PWSTR) digestMethod, 
                   OPC_RELATIONSHIPS_SIGNING_OPTION relationshipSigningOption, 
                   IOpcRelationshipSelectorSet selectorSet, OPC_CANONICALIZATION_METHOD transformMethod, 
                   IOpcSignatureRelationshipReference* relationshipReference);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturerelationshipreferenceset-createrelationshipselectorset))], [])
    HRESULT CreateRelationshipSelectorSet(IOpcRelationshipSelectorSet* selectorSet);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturerelationshipreferenceset-delete))], [])
    HRESULT Delete(IOpcSignatureRelationshipReference relationshipReference);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturerelationshipreferenceset-getenumerator))], [])
    HRESULT GetEnumerator(IOpcSignatureRelationshipReferenceEnumerator* relationshipReferenceEnumerator);
}

@GUID("6e34c269-a4d3-47c0-b5c4-87ff2b3b6136")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcrelationshipselectorset))], [])
interface IOpcRelationshipSelectorSet : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcrelationshipselectorset-create))], [])
    HRESULT Create(OPC_RELATIONSHIP_SELECTOR selector, const(PWSTR) selectionCriterion, 
                   IOpcRelationshipSelector* relationshipSelector);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcrelationshipselectorset-delete))], [])
    HRESULT Delete(IOpcRelationshipSelector relationshipSelector);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcrelationshipselectorset-getenumerator))], [])
    HRESULT GetEnumerator(IOpcRelationshipSelectorEnumerator* relationshipSelectorEnumerator);
}

@GUID("f3b02d31-ab12-42dd-9e2f-2b16761c3c1e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcsignaturereferenceset))], [])
interface IOpcSignatureReferenceSet : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturereferenceset-create))], [])
    HRESULT Create(IUri referenceUri, const(PWSTR) referenceId, const(PWSTR) type, const(PWSTR) digestMethod, 
                   OPC_CANONICALIZATION_METHOD transformMethod, IOpcSignatureReference* reference);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturereferenceset-delete))], [])
    HRESULT Delete(IOpcSignatureReference reference);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturereferenceset-getenumerator))], [])
    HRESULT GetEnumerator(IOpcSignatureReferenceEnumerator* referenceEnumerator);
}

@GUID("8f792ac5-7947-4e11-bc3d-2659ff046ae1")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcsignaturecustomobjectset))], [])
interface IOpcSignatureCustomObjectSet : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturecustomobjectset-create))], [])
    HRESULT Create(const(ubyte)* xmlMarkup, uint count, IOpcSignatureCustomObject* customObject);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturecustomobjectset-delete))], [])
    HRESULT Delete(IOpcSignatureCustomObject customObject);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcsignaturecustomobjectset-getenumerator))], [])
    HRESULT GetEnumerator(IOpcSignatureCustomObjectEnumerator* customObjectEnumerator);
}

@GUID("56ea4325-8e2d-4167-b1a4-e486d24c8fa7")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopccertificateset))], [])
interface IOpcCertificateSet : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopccertificateset-add))], [])
    HRESULT Add(const(CERT_CONTEXT)* certificate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopccertificateset-remove))], [])
    HRESULT Remove(const(CERT_CONTEXT)* certificate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopccertificateset-getenumerator))], [])
    HRESULT GetEnumerator(IOpcCertificateEnumerator* certificateEnumerator);
}

@GUID("6d0b4446-cd73-4ab3-94f4-8ccdf6116154")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nn-msopc-iopcfactory))], [])
interface IOpcFactory : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcfactory-createpackagerooturi))], [])
    HRESULT CreatePackageRootUri(IOpcUri* rootUri);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcfactory-createparturi))], [])
    HRESULT CreatePartUri(const(PWSTR) pwzUri, IOpcPartUri* partUri);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcfactory-createstreamonfile))], [])
    HRESULT CreateStreamOnFile(const(PWSTR) filename, OPC_STREAM_IO_MODE ioMode, 
                               SECURITY_ATTRIBUTES* securityAttributes, uint dwFlagsAndAttributes, IStream* stream);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcfactory-createpackage))], [])
    HRESULT CreatePackage(IOpcPackage* package_);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcfactory-readpackagefromstream))], [])
    HRESULT ReadPackageFromStream(IStream stream, OPC_READ_FLAGS flags, IOpcPackage* package_);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcfactory-writepackagetostream))], [])
    HRESULT WritePackageToStream(IOpcPackage package_, OPC_WRITE_FLAGS flags, IStream stream);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/msopc/nf-msopc-iopcfactory-createdigitalsignaturemanager))], [])
    HRESULT CreateDigitalSignatureManager(IOpcPackage package_, IOpcDigitalSignatureManager* signatureManager);
}


// GUIDs

const GUID CLSID_OpcFactory = GUIDOF!OpcFactory;

const GUID IID_IOpcCertificateEnumerator                    = GUIDOF!IOpcCertificateEnumerator;
const GUID IID_IOpcCertificateSet                           = GUIDOF!IOpcCertificateSet;
const GUID IID_IOpcDigitalSignature                         = GUIDOF!IOpcDigitalSignature;
const GUID IID_IOpcDigitalSignatureEnumerator               = GUIDOF!IOpcDigitalSignatureEnumerator;
const GUID IID_IOpcDigitalSignatureManager                  = GUIDOF!IOpcDigitalSignatureManager;
const GUID IID_IOpcFactory                                  = GUIDOF!IOpcFactory;
const GUID IID_IOpcPackage                                  = GUIDOF!IOpcPackage;
const GUID IID_IOpcPart                                     = GUIDOF!IOpcPart;
const GUID IID_IOpcPartEnumerator                           = GUIDOF!IOpcPartEnumerator;
const GUID IID_IOpcPartSet                                  = GUIDOF!IOpcPartSet;
const GUID IID_IOpcPartUri                                  = GUIDOF!IOpcPartUri;
const GUID IID_IOpcRelationship                             = GUIDOF!IOpcRelationship;
const GUID IID_IOpcRelationshipEnumerator                   = GUIDOF!IOpcRelationshipEnumerator;
const GUID IID_IOpcRelationshipSelector                     = GUIDOF!IOpcRelationshipSelector;
const GUID IID_IOpcRelationshipSelectorEnumerator           = GUIDOF!IOpcRelationshipSelectorEnumerator;
const GUID IID_IOpcRelationshipSelectorSet                  = GUIDOF!IOpcRelationshipSelectorSet;
const GUID IID_IOpcRelationshipSet                          = GUIDOF!IOpcRelationshipSet;
const GUID IID_IOpcSignatureCustomObject                    = GUIDOF!IOpcSignatureCustomObject;
const GUID IID_IOpcSignatureCustomObjectEnumerator          = GUIDOF!IOpcSignatureCustomObjectEnumerator;
const GUID IID_IOpcSignatureCustomObjectSet                 = GUIDOF!IOpcSignatureCustomObjectSet;
const GUID IID_IOpcSignaturePartReference                   = GUIDOF!IOpcSignaturePartReference;
const GUID IID_IOpcSignaturePartReferenceEnumerator         = GUIDOF!IOpcSignaturePartReferenceEnumerator;
const GUID IID_IOpcSignaturePartReferenceSet                = GUIDOF!IOpcSignaturePartReferenceSet;
const GUID IID_IOpcSignatureReference                       = GUIDOF!IOpcSignatureReference;
const GUID IID_IOpcSignatureReferenceEnumerator             = GUIDOF!IOpcSignatureReferenceEnumerator;
const GUID IID_IOpcSignatureReferenceSet                    = GUIDOF!IOpcSignatureReferenceSet;
const GUID IID_IOpcSignatureRelationshipReference           = GUIDOF!IOpcSignatureRelationshipReference;
const GUID IID_IOpcSignatureRelationshipReferenceEnumerator = GUIDOF!IOpcSignatureRelationshipReferenceEnumerator;
const GUID IID_IOpcSignatureRelationshipReferenceSet        = GUIDOF!IOpcSignatureRelationshipReferenceSet;
const GUID IID_IOpcSigningOptions                           = GUIDOF!IOpcSigningOptions;
const GUID IID_IOpcUri                                      = GUIDOF!IOpcUri;
