// Written in the D programming language.

module windows.win32.system.remoteassistance;

public import windows.core;
public import windows.win32.foundation : BSTR, HRESULT;
public import windows.win32.system.com : IDispatch, IUnknown;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rendezvoussession/ne-rendezvoussession-rendezvous_session_state
alias RENDEZVOUS_SESSION_STATE = int;
enum : int
{
    RSS_UNKNOWN    = 0x00000000,
    RSS_READY      = 0x00000001,
    RSS_INVITATION = 0x00000002,
    RSS_ACCEPTED   = 0x00000003,
    RSS_CONNECTED  = 0x00000004,
    RSS_CANCELLED  = 0x00000005,
    RSS_DECLINED   = 0x00000006,
    RSS_TERMINATED = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rendezvoussession/ne-rendezvoussession-rendezvous_session_flags
alias RENDEZVOUS_SESSION_FLAGS = int;
enum : int
{
    RSF_NONE                 = 0x00000000,
    RSF_INVITER              = 0x00000001,
    RSF_INVITEE              = 0x00000002,
    RSF_ORIGINAL_INVITER     = 0x00000004,
    RSF_REMOTE_LEGACYSESSION = 0x00000008,
    RSF_REMOTE_WIN7SESSION   = 0x00000010,
}

// Constants


enum : uint
{
    DISPID_EVENT_ON_STATE_CHANGED = 0x00000005U,
    DISPID_EVENT_ON_TERMINATION   = 0x00000006U,
    DISPID_EVENT_ON_CONTEXT_DATA  = 0x00000007U,
    DISPID_EVENT_ON_SEND_ERROR    = 0x00000008U,
}

// Interfaces

@GUID("0b7e019a-b5de-47fa-8966-9082f82fb192")
struct RendezvousApplication;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rendezvoussession/nn-rendezvoussession-irendezvoussession
@GUID("9ba4b1dd-8b0c-48b7-9e7c-2f25857c8df5")
interface IRendezvousSession : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rendezvoussession/nf-rendezvoussession-irendezvoussession-get_state
    HRESULT get_State(RENDEZVOUS_SESSION_STATE* pSessionState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rendezvoussession/nf-rendezvoussession-irendezvoussession-get_remoteuser
    HRESULT get_RemoteUser(BSTR* bstrUserName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rendezvoussession/nf-rendezvoussession-irendezvoussession-get_flags
    HRESULT get_Flags(int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rendezvoussession/nf-rendezvoussession-irendezvoussession-sendcontextdata
    HRESULT SendContextData(BSTR bstrData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rendezvoussession/nf-rendezvoussession-irendezvoussession-terminate
    HRESULT Terminate(HRESULT hr, BSTR bstrAppData);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rendezvoussession/nn-rendezvoussession-drendezvoussessionevents
@GUID("3fa19cf8-64c4-4f53-ae60-635b3806eca6")
interface DRendezvousSessionEvents : IDispatch
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rendezvoussession/nn-rendezvoussession-irendezvousapplication
@GUID("4f4d070b-a275-49fb-b10d-8ec26387b50d")
interface IRendezvousApplication : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rendezvoussession/nf-rendezvoussession-irendezvousapplication-setrendezvoussession
    HRESULT SetRendezvousSession(IUnknown pRendezvousSession);
}


// GUIDs

const GUID CLSID_RendezvousApplication = GUIDOF!RendezvousApplication;

const GUID IID_DRendezvousSessionEvents = GUIDOF!DRendezvousSessionEvents;
const GUID IID_IRendezvousApplication   = GUIDOF!IRendezvousApplication;
const GUID IID_IRendezvousSession       = GUIDOF!IRendezvousSession;
