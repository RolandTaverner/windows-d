// Written in the D programming language.

module windows.win32.system.mapi;

public import windows.core;
public import windows.win32.foundation : PSTR, PWSTR;

extern(Windows) @nogc nothrow:


// Constants


enum : uint
{
    MAPI_OLE        = 0x00000001,
    MAPI_OLE_STATIC = 0x00000002,
}

enum : uint
{
    MAPI_ORIG              = 0x00000000,
    MAPI_TO                = 0x00000001,
    MAPI_CC                = 0x00000002,
    MAPI_BCC               = 0x00000003,
    MAPI_UNREAD            = 0x00000001,
    MAPI_RECEIPT_REQUESTED = 0x00000002,
}

enum : uint
{
    MAPI_SENT     = 0x00000004,
    MAPI_LOGON_UI = 0x00000001,
}

enum uint MAPI_PASSWORD_UI = 0x00020000;
enum uint MAPI_NEW_SESSION = 0x00000002;
enum uint MAPI_FORCE_DOWNLOAD = 0x00001000;
enum uint MAPI_EXTENDED = 0x00000020;

enum : uint
{
    MAPI_DIALOG        = 0x00000008,
    MAPI_FORCE_UNICODE = 0x00040000,
}

enum uint MAPI_UNREAD_ONLY = 0x00000020;
enum uint MAPI_GUARANTEE_FIFO = 0x00000100;
enum uint MAPI_LONG_MSGID = 0x00004000;

enum : uint
{
    MAPI_PEEK            = 0x00000080,
    MAPI_SUPPRESS_ATTACH = 0x00000800,
}

enum uint MAPI_ENVELOPE_ONLY = 0x00000040;
enum uint MAPI_BODY_AS_FILE = 0x00000200;
enum uint MAPI_AB_NOMODIFY = 0x00000400;
enum uint SUCCESS_SUCCESS = 0x00000000;
enum uint MAPI_USER_ABORT = 0x00000001;

enum : uint
{
    MAPI_E_USER_ABORT    = 0x00000001,
    MAPI_E_FAILURE       = 0x00000002,
    MAPI_E_LOGON_FAILURE = 0x00000003,
    MAPI_E_LOGIN_FAILURE = 0x00000003,
}

enum : uint
{
    MAPI_E_DISK_FULL           = 0x00000004,
    MAPI_E_INSUFFICIENT_MEMORY = 0x00000005,
}

enum uint MAPI_E_ACCESS_DENIED = 0x00000006;

enum : uint
{
    MAPI_E_TOO_MANY_SESSIONS   = 0x00000008,
    MAPI_E_TOO_MANY_FILES      = 0x00000009,
    MAPI_E_TOO_MANY_RECIPIENTS = 0x0000000a,
}

enum : uint
{
    MAPI_E_ATTACHMENT_NOT_FOUND     = 0x0000000b,
    MAPI_E_ATTACHMENT_OPEN_FAILURE  = 0x0000000c,
    MAPI_E_ATTACHMENT_WRITE_FAILURE = 0x0000000d,
}

enum uint MAPI_E_UNKNOWN_RECIPIENT = 0x0000000e;
enum uint MAPI_E_BAD_RECIPTYPE = 0x0000000f;
enum uint MAPI_E_NO_MESSAGES = 0x00000010;
enum uint MAPI_E_INVALID_MESSAGE = 0x00000011;
enum uint MAPI_E_TEXT_TOO_LARGE = 0x00000012;
enum uint MAPI_E_INVALID_SESSION = 0x00000013;
enum uint MAPI_E_TYPE_NOT_SUPPORTED = 0x00000014;

enum : uint
{
    MAPI_E_AMBIGUOUS_RECIPIENT = 0x00000015,
    MAPI_E_AMBIG_RECIP         = 0x00000015,
}

enum uint MAPI_E_MESSAGE_IN_USE = 0x00000016;
enum uint MAPI_E_NETWORK_FAILURE = 0x00000017;

enum : uint
{
    MAPI_E_INVALID_EDITFIELDS = 0x00000018,
    MAPI_E_INVALID_RECIPS     = 0x00000019,
}

enum uint MAPI_E_NOT_SUPPORTED = 0x0000001a;
enum uint MAPI_E_UNICODE_NOT_SUPPORTED = 0x0000001b;
enum uint MAPI_E_ATTACHMENT_TOO_LARGE = 0x0000001c;

// Callbacks

alias LPMAPILOGON = uint function(size_t ulUIParam, PSTR lpszProfileName, PSTR lpszPassword, uint flFlags, 
                                  uint ulReserved, size_t* lplhSession);
alias LPMAPILOGOFF = uint function(size_t lhSession, size_t ulUIParam, uint flFlags, uint ulReserved);
//DELEGATE ATTR: AnsiAttribute : CustomAttributeSig([], [])
alias LPMAPISENDMAIL = uint function(size_t lhSession, size_t ulUIParam, MapiMessage* lpMessage, uint flFlags, 
                                     uint ulReserved);
//DELEGATE ATTR: UnicodeAttribute : CustomAttributeSig([], [])
alias LPMAPISENDMAILW = uint function(size_t lhSession, size_t ulUIParam, MapiMessageW* lpMessage, uint flFlags, 
                                      uint ulReserved);
alias LPMAPISENDDOCUMENTS = uint function(size_t ulUIParam, PSTR lpszDelimChar, PSTR lpszFilePaths, 
                                          PSTR lpszFileNames, uint ulReserved);
alias LPMAPIFINDNEXT = uint function(size_t lhSession, size_t ulUIParam, PSTR lpszMessageType, 
                                     PSTR lpszSeedMessageID, uint flFlags, uint ulReserved, PSTR lpszMessageID);
alias LPMAPIREADMAIL = uint function(size_t lhSession, size_t ulUIParam, PSTR lpszMessageID, uint flFlags, 
                                     uint ulReserved, MapiMessage** lppMessage);
alias LPMAPISAVEMAIL = uint function(size_t lhSession, size_t ulUIParam, MapiMessage* lpMessage, uint flFlags, 
                                     uint ulReserved, PSTR lpszMessageID);
alias LPMAPIDELETEMAIL = uint function(size_t lhSession, size_t ulUIParam, PSTR lpszMessageID, uint flFlags, 
                                       uint ulReserved);
alias LPMAPIFREEBUFFER = uint function(void* pv);
alias LPMAPIADDRESS = uint function(size_t lhSession, size_t ulUIParam, PSTR lpszCaption, uint nEditFields, 
                                    PSTR lpszLabels, uint nRecips, MapiRecipDesc* lpRecips, uint flFlags, 
                                    uint ulReserved, uint* lpnNewRecips, MapiRecipDesc** lppNewRecips);
alias LPMAPIDETAILS = uint function(size_t lhSession, size_t ulUIParam, MapiRecipDesc* lpRecip, uint flFlags, 
                                    uint ulReserved);
alias LPMAPIRESOLVENAME = uint function(size_t lhSession, size_t ulUIParam, PSTR lpszName, uint flFlags, 
                                        uint ulReserved, MapiRecipDesc** lppRecip);

// Structs


//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mapi/ns-mapi-mapifiledesc))], [])
struct MapiFileDesc
{
    uint  ulReserved;
    uint  flFlags;
    uint  nPosition;
    PSTR  lpszPathName;
    PSTR  lpszFileName;
    void* lpFileType;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mapi/ns-mapi-mapifiledescw))], [])
struct MapiFileDescW
{
    uint  ulReserved;
    uint  flFlags;
    uint  nPosition;
    PWSTR lpszPathName;
    PWSTR lpszFileName;
    void* lpFileType;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mapi/ns-mapi-mapifiletagext))], [])
struct MapiFileTagExt
{
    uint   ulReserved;
    uint   cbTag;
    ubyte* lpTag;
    uint   cbEncoding;
    ubyte* lpEncoding;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mapi/ns-mapi-mapirecipdesc))], [])
struct MapiRecipDesc
{
    uint  ulReserved;
    uint  ulRecipClass;
    PSTR  lpszName;
    PSTR  lpszAddress;
    uint  ulEIDSize;
    void* lpEntryID;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mapi/ns-mapi-mapirecipdescw))], [])
struct MapiRecipDescW
{
    uint  ulReserved;
    uint  ulRecipClass;
    PWSTR lpszName;
    PWSTR lpszAddress;
    uint  ulEIDSize;
    void* lpEntryID;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mapi/ns-mapi-mapimessage))], [])
struct MapiMessage
{
    uint           ulReserved;
    PSTR           lpszSubject;
    PSTR           lpszNoteText;
    PSTR           lpszMessageType;
    PSTR           lpszDateReceived;
    PSTR           lpszConversationID;
    uint           flFlags;
    MapiRecipDesc* lpOriginator;
    uint           nRecipCount;
    MapiRecipDesc* lpRecips;
    uint           nFileCount;
    MapiFileDesc*  lpFiles;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mapi/ns-mapi-mapimessagew))], [])
struct MapiMessageW
{
    uint            ulReserved;
    PWSTR           lpszSubject;
    PWSTR           lpszNoteText;
    PWSTR           lpszMessageType;
    PWSTR           lpszDateReceived;
    PWSTR           lpszConversationID;
    uint            flFlags;
    MapiRecipDescW* lpOriginator;
    uint            nRecipCount;
    MapiRecipDescW* lpRecips;
    uint            nFileCount;
    MapiFileDescW*  lpFiles;
}

// Functions

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/office/client-developer/outlook/mapi/mapifreebuffer))], [])
@DllImport("MAPI32.dll")
uint MAPIFreeBuffer(void* pv);


