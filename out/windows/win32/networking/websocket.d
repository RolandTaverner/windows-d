// Written in the D programming language.

module windows.win32.networking.websocket;

public import windows.core;
public import windows.win32.foundation.foundation : HRESULT, PSTR;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/websocket/ne-websocket-web_socket_close_status
alias WEB_SOCKET_CLOSE_STATUS = int;
enum : int
{
    WEB_SOCKET_SUCCESS_CLOSE_STATUS                = 0x000003e8,
    WEB_SOCKET_ENDPOINT_UNAVAILABLE_CLOSE_STATUS   = 0x000003e9,
    WEB_SOCKET_PROTOCOL_ERROR_CLOSE_STATUS         = 0x000003ea,
    WEB_SOCKET_INVALID_DATA_TYPE_CLOSE_STATUS      = 0x000003eb,
    WEB_SOCKET_EMPTY_CLOSE_STATUS                  = 0x000003ed,
    WEB_SOCKET_ABORTED_CLOSE_STATUS                = 0x000003ee,
    WEB_SOCKET_INVALID_PAYLOAD_CLOSE_STATUS        = 0x000003ef,
    WEB_SOCKET_POLICY_VIOLATION_CLOSE_STATUS       = 0x000003f0,
    WEB_SOCKET_MESSAGE_TOO_BIG_CLOSE_STATUS        = 0x000003f1,
    WEB_SOCKET_UNSUPPORTED_EXTENSIONS_CLOSE_STATUS = 0x000003f2,
    WEB_SOCKET_SERVER_ERROR_CLOSE_STATUS           = 0x000003f3,
    WEB_SOCKET_SECURE_HANDSHAKE_ERROR_CLOSE_STATUS = 0x000003f7,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/websocket/ne-websocket-web_socket_property_type
alias WEB_SOCKET_PROPERTY_TYPE = int;
enum : int
{
    WEB_SOCKET_RECEIVE_BUFFER_SIZE_PROPERTY_TYPE       = 0x00000000,
    WEB_SOCKET_SEND_BUFFER_SIZE_PROPERTY_TYPE          = 0x00000001,
    WEB_SOCKET_DISABLE_MASKING_PROPERTY_TYPE           = 0x00000002,
    WEB_SOCKET_ALLOCATED_BUFFER_PROPERTY_TYPE          = 0x00000003,
    WEB_SOCKET_DISABLE_UTF8_VERIFICATION_PROPERTY_TYPE = 0x00000004,
    WEB_SOCKET_KEEPALIVE_INTERVAL_PROPERTY_TYPE        = 0x00000005,
    WEB_SOCKET_SUPPORTED_VERSIONS_PROPERTY_TYPE        = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/websocket/ne-websocket-web_socket_action_queue
alias WEB_SOCKET_ACTION_QUEUE = int;
enum : int
{
    WEB_SOCKET_SEND_ACTION_QUEUE    = 0x00000001,
    WEB_SOCKET_RECEIVE_ACTION_QUEUE = 0x00000002,
    WEB_SOCKET_ALL_ACTION_QUEUE     = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/websocket/ne-websocket-web_socket_buffer_type
alias WEB_SOCKET_BUFFER_TYPE = int;
enum : int
{
    WEB_SOCKET_UTF8_MESSAGE_BUFFER_TYPE     = 0x80000000,
    WEB_SOCKET_UTF8_FRAGMENT_BUFFER_TYPE    = 0x80000001,
    WEB_SOCKET_BINARY_MESSAGE_BUFFER_TYPE   = 0x80000002,
    WEB_SOCKET_BINARY_FRAGMENT_BUFFER_TYPE  = 0x80000003,
    WEB_SOCKET_CLOSE_BUFFER_TYPE            = 0x80000004,
    WEB_SOCKET_PING_PONG_BUFFER_TYPE        = 0x80000005,
    WEB_SOCKET_UNSOLICITED_PONG_BUFFER_TYPE = 0x80000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/websocket/ne-websocket-web_socket_action
alias WEB_SOCKET_ACTION = int;
enum : int
{
    WEB_SOCKET_NO_ACTION                        = 0x00000000,
    WEB_SOCKET_SEND_TO_NETWORK_ACTION           = 0x00000001,
    WEB_SOCKET_INDICATE_SEND_COMPLETE_ACTION    = 0x00000002,
    WEB_SOCKET_RECEIVE_FROM_NETWORK_ACTION      = 0x00000003,
    WEB_SOCKET_INDICATE_RECEIVE_COMPLETE_ACTION = 0x00000004,
}

// Constants


enum uint WEB_SOCKET_MAX_CLOSE_REASON_LENGTH = 0x0000007bU;

// Structs


@RAIIFree!WebSocketDeleteHandle
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct WEB_SOCKET_HANDLE
{
    void* Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/websocket/ns-websocket-web_socket_property
struct WEB_SOCKET_PROPERTY
{
    WEB_SOCKET_PROPERTY_TYPE Type;
    void* pvValue;
    uint  ulValueSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/websocket/ns-websocket-web_socket_http_header
struct WEB_SOCKET_HTTP_HEADER
{
    /*FIELD ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR pcName;
    uint ulNameLength;
    /*FIELD ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR pcValue;
    uint ulValueLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/websocket/ns-websocket-web_socket_buffer
union WEB_SOCKET_BUFFER
{
    struct Data
    {
        ubyte* pbBuffer;
        uint   ulBufferLength;
    }
    struct CloseStatus
    {
        ubyte* pbReason;
        uint   ulReasonLength;
        ushort usStatus;
    }
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("websocket.dll")
HRESULT WebSocketCreateClientHandle(const(WEB_SOCKET_PROPERTY)* pProperties, uint ulPropertyCount, 
                                    WEB_SOCKET_HANDLE* phWebSocket);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("websocket.dll")
HRESULT WebSocketBeginClientHandshake(WEB_SOCKET_HANDLE hWebSocket, const(PSTR)* pszSubprotocols, 
                                      uint ulSubprotocolCount, const(PSTR)* pszExtensions, uint ulExtensionCount, 
                                      const(WEB_SOCKET_HTTP_HEADER)* pInitialHeaders, uint ulInitialHeaderCount, 
                                      WEB_SOCKET_HTTP_HEADER** pAdditionalHeaders, uint* pulAdditionalHeaderCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("websocket.dll")
HRESULT WebSocketEndClientHandshake(WEB_SOCKET_HANDLE hWebSocket, const(WEB_SOCKET_HTTP_HEADER)* pResponseHeaders, 
                                    uint ulReponseHeaderCount, uint* pulSelectedExtensions, 
                                    uint* pulSelectedExtensionCount, uint* pulSelectedSubprotocol);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("websocket.dll")
HRESULT WebSocketCreateServerHandle(const(WEB_SOCKET_PROPERTY)* pProperties, uint ulPropertyCount, 
                                    WEB_SOCKET_HANDLE* phWebSocket);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("websocket.dll")
HRESULT WebSocketBeginServerHandshake(WEB_SOCKET_HANDLE hWebSocket, const(PSTR) pszSubprotocolSelected, 
                                      const(PSTR)* pszExtensionSelected, uint ulExtensionSelectedCount, 
                                      const(WEB_SOCKET_HTTP_HEADER)* pRequestHeaders, uint ulRequestHeaderCount, 
                                      WEB_SOCKET_HTTP_HEADER** pResponseHeaders, uint* pulResponseHeaderCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("websocket.dll")
HRESULT WebSocketEndServerHandshake(WEB_SOCKET_HANDLE hWebSocket);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("websocket.dll")
HRESULT WebSocketSend(WEB_SOCKET_HANDLE hWebSocket, WEB_SOCKET_BUFFER_TYPE BufferType, WEB_SOCKET_BUFFER* pBuffer, 
                      void* Context);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("websocket.dll")
HRESULT WebSocketReceive(WEB_SOCKET_HANDLE hWebSocket, WEB_SOCKET_BUFFER* pBuffer, void* pvContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("websocket.dll")
HRESULT WebSocketGetAction(WEB_SOCKET_HANDLE hWebSocket, WEB_SOCKET_ACTION_QUEUE eActionQueue, 
                           WEB_SOCKET_BUFFER* pDataBuffers, uint* pulDataBufferCount, WEB_SOCKET_ACTION* pAction, 
                           WEB_SOCKET_BUFFER_TYPE* pBufferType, void** pvApplicationContext, void** pvActionContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("websocket.dll")
void WebSocketCompleteAction(WEB_SOCKET_HANDLE hWebSocket, void* pvActionContext, uint ulBytesTransferred);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("websocket.dll")
void WebSocketAbortHandle(WEB_SOCKET_HANDLE hWebSocket);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("websocket.dll")
void WebSocketDeleteHandle(WEB_SOCKET_HANDLE hWebSocket);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("websocket.dll")
HRESULT WebSocketGetGlobalProperty(WEB_SOCKET_PROPERTY_TYPE eType, void* pvValue, uint* ulSize);


