// Written in the D programming language.

module windows.win32.system.mapi;

public import windows.core;
public import windows.win32.foundation : PSTR, PWSTR;

extern(Windows) @nogc nothrow:


// Constants


enum : uint
{
    MAPI_OLE        = 0x00000001U,
    MAPI_OLE_STATIC = 0x00000002U,
}

enum : uint
{
    MAPI_ORIG              = 0x00000000U,
    MAPI_TO                = 0x00000001U,
    MAPI_CC                = 0x00000002U,
    MAPI_BCC               = 0x00000003U,
    MAPI_UNREAD            = 0x00000001U,
    MAPI_RECEIPT_REQUESTED = 0x00000002U,
}

enum : uint
{
    MAPI_SENT     = 0x00000004U,
    MAPI_LOGON_UI = 0x00000001U,
}

enum uint MAPI_PASSWORD_UI = 0x00020000U;
enum uint MAPI_NEW_SESSION = 0x00000002U;
enum uint MAPI_FORCE_DOWNLOAD = 0x00001000U;
enum uint MAPI_EXTENDED = 0x00000020U;

enum : uint
{
    MAPI_DIALOG        = 0x00000008U,
    MAPI_FORCE_UNICODE = 0x00040000U,
}

enum uint MAPI_UNREAD_ONLY = 0x00000020U;
enum uint MAPI_GUARANTEE_FIFO = 0x00000100U;
enum uint MAPI_LONG_MSGID = 0x00004000U;

enum : uint
{
    MAPI_PEEK            = 0x00000080U,
    MAPI_SUPPRESS_ATTACH = 0x00000800U,
}

enum uint MAPI_ENVELOPE_ONLY = 0x00000040U;
enum uint MAPI_BODY_AS_FILE = 0x00000200U;
enum uint MAPI_AB_NOMODIFY = 0x00000400U;
enum uint SUCCESS_SUCCESS = 0x00000000U;
enum uint MAPI_USER_ABORT = 0x00000001U;

enum : uint
{
    MAPI_E_USER_ABORT    = 0x00000001U,
    MAPI_E_FAILURE       = 0x00000002U,
    MAPI_E_LOGON_FAILURE = 0x00000003U,
    MAPI_E_LOGIN_FAILURE = 0x00000003U,
}

enum : uint
{
    MAPI_E_DISK_FULL           = 0x00000004U,
    MAPI_E_INSUFFICIENT_MEMORY = 0x00000005U,
}

enum uint MAPI_E_ACCESS_DENIED = 0x00000006U;

enum : uint
{
    MAPI_E_TOO_MANY_SESSIONS   = 0x00000008U,
    MAPI_E_TOO_MANY_FILES      = 0x00000009U,
    MAPI_E_TOO_MANY_RECIPIENTS = 0x0000000aU,
}

enum : uint
{
    MAPI_E_ATTACHMENT_NOT_FOUND     = 0x0000000bU,
    MAPI_E_ATTACHMENT_OPEN_FAILURE  = 0x0000000cU,
    MAPI_E_ATTACHMENT_WRITE_FAILURE = 0x0000000dU,
}

enum uint MAPI_E_UNKNOWN_RECIPIENT = 0x0000000eU;
enum uint MAPI_E_BAD_RECIPTYPE = 0x0000000fU;
enum uint MAPI_E_NO_MESSAGES = 0x00000010U;
enum uint MAPI_E_INVALID_MESSAGE = 0x00000011U;
enum uint MAPI_E_TEXT_TOO_LARGE = 0x00000012U;
enum uint MAPI_E_INVALID_SESSION = 0x00000013U;
enum uint MAPI_E_TYPE_NOT_SUPPORTED = 0x00000014U;

enum : uint
{
    MAPI_E_AMBIGUOUS_RECIPIENT = 0x00000015U,
    MAPI_E_AMBIG_RECIP         = 0x00000015U,
}

enum uint MAPI_E_MESSAGE_IN_USE = 0x00000016U;
enum uint MAPI_E_NETWORK_FAILURE = 0x00000017U;

enum : uint
{
    MAPI_E_INVALID_EDITFIELDS = 0x00000018U,
    MAPI_E_INVALID_RECIPS     = 0x00000019U,
}

enum uint MAPI_E_NOT_SUPPORTED = 0x0000001aU;
enum uint MAPI_E_UNICODE_NOT_SUPPORTED = 0x0000001bU;
enum uint MAPI_E_ATTACHMENT_TOO_LARGE = 0x0000001cU;

// Callbacks

alias LPMAPILOGON = uint function(size_t ulUIParam, PSTR lpszProfileName, PSTR lpszPassword, uint flFlags, 
                                  uint ulReserved, size_t* lplhSession);
alias LPMAPILOGOFF = uint function(size_t lhSession, size_t ulUIParam, uint flFlags, uint ulReserved);
alias LPMAPISENDMAIL = uint function(size_t lhSession, size_t ulUIParam, MapiMessage* lpMessage, uint flFlags, 
                                     uint ulReserved);
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


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mapi/ns-mapi-mapifiledesc
struct MapiFileDesc
{
    uint  ulReserved;
    uint  flFlags;
    uint  nPosition;
    PSTR  lpszPathName;
    PSTR  lpszFileName;
    void* lpFileType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mapi/ns-mapi-mapifiledescw
struct MapiFileDescW
{
    uint  ulReserved;
    uint  flFlags;
    uint  nPosition;
    PWSTR lpszPathName;
    PWSTR lpszFileName;
    void* lpFileType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mapi/ns-mapi-mapifiletagext
struct MapiFileTagExt
{
    uint   ulReserved;
    uint   cbTag;
    ubyte* lpTag;
    uint   cbEncoding;
    ubyte* lpEncoding;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mapi/ns-mapi-mapirecipdesc
struct MapiRecipDesc
{
    uint  ulReserved;
    uint  ulRecipClass;
    PSTR  lpszName;
    PSTR  lpszAddress;
    uint  ulEIDSize;
    void* lpEntryID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mapi/ns-mapi-mapirecipdescw
struct MapiRecipDescW
{
    uint  ulReserved;
    uint  ulRecipClass;
    PWSTR lpszName;
    PWSTR lpszAddress;
    uint  ulEIDSize;
    void* lpEntryID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mapi/ns-mapi-mapimessage
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mapi/ns-mapi-mapimessagew
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

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/mapifreebuffer
@DllImport("MAPI32.dll")
uint MAPIFreeBuffer(void* pv);


