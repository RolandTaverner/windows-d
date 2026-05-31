// Written in the D programming language.

module windows.win32.system.com.events;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : BOOL, BSTR, HRESULT;
public import windows.win32.system.com : IDispatch, IUnknown;
public import windows.win32.system.variant : VARIANT;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/ne-eventsys-eoc_changetype))], [])
alias EOC_ChangeType = int;
enum : int
{
    EOC_NewObject      = 0x00000000,
    EOC_ModifiedObject = 0x00000001,
    EOC_DeletedObject  = 0x00000002,
}

// Structs


//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/ns-eventsys-comeventsyschangeinfo))], [])
struct COMEVENTSYSCHANGEINFO
{
    uint           cbSize;
    EOC_ChangeType changeType;
    BSTR           objectId;
    BSTR           partitionId;
    BSTR           applicationId;
    GUID[10]       reserved;
}

// Interfaces

@GUID("4e14fba2-2e22-11d1-9964-00c04fbbb345")
struct CEventSystem;

@GUID("ab944620-79c6-11d1-88f9-0080c7d771bf")
struct CEventPublisher;

@GUID("cdbec9c0-7a68-11d1-88f9-0080c7d771bf")
struct CEventClass;

@GUID("7542e960-79c7-11d1-88f9-0080c7d771bf")
struct CEventSubscription;

@GUID("d0565000-9df4-11d1-a281-00c04fca0aa7")
struct EventObjectChange;

@GUID("bb07bacd-cd56-4e63-a8ff-cbf0355fb9f4")
struct EventObjectChange2;

@GUID("4e14fb9f-2e22-11d1-9964-00c04fbbb345")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-ieventsystem))], [])
interface IEventSystem : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsystem-query))], [])
    HRESULT Query(BSTR progID, BSTR queryCriteria, int* errorIndex, IUnknown* ppInterface);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsystem-store))], [])
    HRESULT Store(BSTR ProgID, IUnknown pInterface);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsystem-remove))], [])
    HRESULT Remove(BSTR progID, BSTR queryCriteria, int* errorIndex);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsystem-get_eventobjectchangeeventclassid))], [])
    HRESULT get_EventObjectChangeEventClassID(BSTR* pbstrEventClassID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsystem-querys))], [])
    HRESULT QueryS(BSTR progID, BSTR queryCriteria, IUnknown* ppInterface);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsystem-removes))], [])
    HRESULT RemoveS(BSTR progID, BSTR queryCriteria);
}

@GUID("e341516b-2e32-11d1-9964-00c04fbbb345")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-ieventpublisher))], [])
interface IEventPublisher : IDispatch
{
    HRESULT get_PublisherID(BSTR* pbstrPublisherID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventpublisher-put_publisherid))], [])
    HRESULT put_PublisherID(BSTR bstrPublisherID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventpublisher-get_publishername))], [])
    HRESULT get_PublisherName(BSTR* pbstrPublisherName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventpublisher-put_publishername))], [])
    HRESULT put_PublisherName(BSTR bstrPublisherName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventpublisher-get_publishertype))], [])
    HRESULT get_PublisherType(BSTR* pbstrPublisherType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventpublisher-put_publishertype))], [])
    HRESULT put_PublisherType(BSTR bstrPublisherType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventpublisher-get_ownersid))], [])
    HRESULT get_OwnerSID(BSTR* pbstrOwnerSID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventpublisher-put_ownersid))], [])
    HRESULT put_OwnerSID(BSTR bstrOwnerSID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventpublisher-get_description))], [])
    HRESULT get_Description(BSTR* pbstrDescription);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventpublisher-put_description))], [])
    HRESULT put_Description(BSTR bstrDescription);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventpublisher-getdefaultproperty))], [])
    HRESULT GetDefaultProperty(BSTR bstrPropertyName, VARIANT* propertyValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventpublisher-putdefaultproperty))], [])
    HRESULT PutDefaultProperty(BSTR bstrPropertyName, VARIANT* propertyValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventpublisher-removedefaultproperty))], [])
    HRESULT RemoveDefaultProperty(BSTR bstrPropertyName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventpublisher-getdefaultpropertycollection))], [])
    HRESULT GetDefaultPropertyCollection(IEventObjectCollection* collection);
}

@GUID("fb2b72a0-7a68-11d1-88f9-0080c7d771bf")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-ieventclass))], [])
interface IEventClass : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass-get_eventclassid))], [])
    HRESULT get_EventClassID(BSTR* pbstrEventClassID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass-put_eventclassid))], [])
    HRESULT put_EventClassID(BSTR bstrEventClassID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass-get_eventclassname))], [])
    HRESULT get_EventClassName(BSTR* pbstrEventClassName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass-put_eventclassname))], [])
    HRESULT put_EventClassName(BSTR bstrEventClassName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass-get_ownersid))], [])
    HRESULT get_OwnerSID(BSTR* pbstrOwnerSID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass-put_ownersid))], [])
    HRESULT put_OwnerSID(BSTR bstrOwnerSID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass-get_firinginterfaceid))], [])
    HRESULT get_FiringInterfaceID(BSTR* pbstrFiringInterfaceID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass-put_firinginterfaceid))], [])
    HRESULT put_FiringInterfaceID(BSTR bstrFiringInterfaceID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass-get_description))], [])
    HRESULT get_Description(BSTR* pbstrDescription);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass-put_description))], [])
    HRESULT put_Description(BSTR bstrDescription);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass-get_customconfigclsid))], [])
    HRESULT get_CustomConfigCLSID(BSTR* pbstrCustomConfigCLSID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass-put_customconfigclsid))], [])
    HRESULT put_CustomConfigCLSID(BSTR bstrCustomConfigCLSID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass-get_typelib))], [])
    HRESULT get_TypeLib(BSTR* pbstrTypeLib);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass-put_typelib))], [])
    HRESULT put_TypeLib(BSTR bstrTypeLib);
}

@GUID("fb2b72a1-7a68-11d1-88f9-0080c7d771bf")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-ieventclass2))], [])
interface IEventClass2 : IEventClass
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass2-get_publisherid))], [])
    HRESULT get_PublisherID(BSTR* pbstrPublisherID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass2-put_publisherid))], [])
    HRESULT put_PublisherID(BSTR bstrPublisherID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass2-get_multiinterfacepublisherfilterclsid))], [])
    HRESULT get_MultiInterfacePublisherFilterCLSID(BSTR* pbstrPubFilCLSID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass2-put_multiinterfacepublisherfilterclsid))], [])
    HRESULT put_MultiInterfacePublisherFilterCLSID(BSTR bstrPubFilCLSID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass2-get_allowinprocactivation))], [])
    HRESULT get_AllowInprocActivation(BOOL* pfAllowInprocActivation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass2-put_allowinprocactivation))], [])
    HRESULT put_AllowInprocActivation(BOOL fAllowInprocActivation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass2-get_fireinparallel))], [])
    HRESULT get_FireInParallel(BOOL* pfFireInParallel);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass2-put_fireinparallel))], [])
    HRESULT put_FireInParallel(BOOL fFireInParallel);
}

@GUID("4a6b0e15-2e38-11d1-9965-00c04fbbb345")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-ieventsubscription))], [])
interface IEventSubscription : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-get_subscriptionid))], [])
    HRESULT get_SubscriptionID(BSTR* pbstrSubscriptionID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-put_subscriptionid))], [])
    HRESULT put_SubscriptionID(BSTR bstrSubscriptionID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-get_subscriptionname))], [])
    HRESULT get_SubscriptionName(BSTR* pbstrSubscriptionName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-put_subscriptionname))], [])
    HRESULT put_SubscriptionName(BSTR bstrSubscriptionName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-get_publisherid))], [])
    HRESULT get_PublisherID(BSTR* pbstrPublisherID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-put_publisherid))], [])
    HRESULT put_PublisherID(BSTR bstrPublisherID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-get_eventclassid))], [])
    HRESULT get_EventClassID(BSTR* pbstrEventClassID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-put_eventclassid))], [])
    HRESULT put_EventClassID(BSTR bstrEventClassID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-get_methodname))], [])
    HRESULT get_MethodName(BSTR* pbstrMethodName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-put_methodname))], [])
    HRESULT put_MethodName(BSTR bstrMethodName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-get_subscriberclsid))], [])
    HRESULT get_SubscriberCLSID(BSTR* pbstrSubscriberCLSID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-put_subscriberclsid))], [])
    HRESULT put_SubscriberCLSID(BSTR bstrSubscriberCLSID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-get_subscriberinterface))], [])
    HRESULT get_SubscriberInterface(IUnknown* ppSubscriberInterface);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-put_subscriberinterface))], [])
    HRESULT put_SubscriberInterface(IUnknown pSubscriberInterface);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-get_peruser))], [])
    HRESULT get_PerUser(BOOL* pfPerUser);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-put_peruser))], [])
    HRESULT put_PerUser(BOOL fPerUser);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-get_ownersid))], [])
    HRESULT get_OwnerSID(BSTR* pbstrOwnerSID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-put_ownersid))], [])
    HRESULT put_OwnerSID(BSTR bstrOwnerSID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-get_enabled))], [])
    HRESULT get_Enabled(BOOL* pfEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-put_enabled))], [])
    HRESULT put_Enabled(BOOL fEnabled);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-get_description))], [])
    HRESULT get_Description(BSTR* pbstrDescription);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-put_description))], [])
    HRESULT put_Description(BSTR bstrDescription);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-get_machinename))], [])
    HRESULT get_MachineName(BSTR* pbstrMachineName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-put_machinename))], [])
    HRESULT put_MachineName(BSTR bstrMachineName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-getpublisherproperty))], [])
    HRESULT GetPublisherProperty(BSTR bstrPropertyName, VARIANT* propertyValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-putpublisherproperty))], [])
    HRESULT PutPublisherProperty(BSTR bstrPropertyName, VARIANT* propertyValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-removepublisherproperty))], [])
    HRESULT RemovePublisherProperty(BSTR bstrPropertyName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-getpublisherpropertycollection))], [])
    HRESULT GetPublisherPropertyCollection(IEventObjectCollection* collection);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-getsubscriberproperty))], [])
    HRESULT GetSubscriberProperty(BSTR bstrPropertyName, VARIANT* propertyValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-putsubscriberproperty))], [])
    HRESULT PutSubscriberProperty(BSTR bstrPropertyName, VARIANT* propertyValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-removesubscriberproperty))], [])
    HRESULT RemoveSubscriberProperty(BSTR bstrPropertyName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-getsubscriberpropertycollection))], [])
    HRESULT GetSubscriberPropertyCollection(IEventObjectCollection* collection);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-get_interfaceid))], [])
    HRESULT get_InterfaceID(BSTR* pbstrInterfaceID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-put_interfaceid))], [])
    HRESULT put_InterfaceID(BSTR bstrInterfaceID);
}

@GUID("e0498c93-4efe-11d1-9971-00c04fbbb345")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-ifiringcontrol))], [])
interface IFiringControl : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ifiringcontrol-firesubscription))], [])
    HRESULT FireSubscription(IEventSubscription subscription);
}

@GUID("465e5cc0-7b26-11d1-88fb-0080c7d771bf")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-ipublisherfilter))], [])
interface IPublisherFilter : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ipublisherfilter-initialize))], [])
    HRESULT Initialize(BSTR methodName, IDispatch dispUserDefined);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ipublisherfilter-preparetofire))], [])
    HRESULT PrepareToFire(BSTR methodName, IFiringControl firingControl);
}

@GUID("465e5cc1-7b26-11d1-88fb-0080c7d771bf")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-imultiinterfacepublisherfilter))], [])
interface IMultiInterfacePublisherFilter : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-imultiinterfacepublisherfilter-initialize))], [])
    HRESULT Initialize(IMultiInterfaceEventControl pEIC);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-imultiinterfacepublisherfilter-preparetofire))], [])
    HRESULT PrepareToFire(const(GUID)* iid, BSTR methodName, IFiringControl firingControl);
}

@GUID("f4a07d70-2e25-11d1-9964-00c04fbbb345")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-ieventobjectchange))], [])
interface IEventObjectChange : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventobjectchange-changedsubscription))], [])
    HRESULT ChangedSubscription(EOC_ChangeType changeType, BSTR bstrSubscriptionID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventobjectchange-changedeventclass))], [])
    HRESULT ChangedEventClass(EOC_ChangeType changeType, BSTR bstrEventClassID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventobjectchange-changedpublisher))], [])
    HRESULT ChangedPublisher(EOC_ChangeType changeType, BSTR bstrPublisherID);
}

@GUID("7701a9c3-bd68-438f-83e0-67bf4f53a422")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-ieventobjectchange2))], [])
interface IEventObjectChange2 : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventobjectchange2-changedsubscription))], [])
    HRESULT ChangedSubscription(COMEVENTSYSCHANGEINFO* pInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventobjectchange2-changedeventclass))], [])
    HRESULT ChangedEventClass(COMEVENTSYSCHANGEINFO* pInfo);
}

@GUID("f4a07d63-2e25-11d1-9964-00c04fbbb345")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-ienumeventobject))], [])
interface IEnumEventObject : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ienumeventobject-clone))], [])
    HRESULT Clone(IEnumEventObject* ppInterface);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ienumeventobject-next))], [])
    HRESULT Next(uint cReqElem, IUnknown* ppInterface, uint* cRetElem);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ienumeventobject-skip))], [])
    HRESULT Skip(uint cSkipElem);
}

@GUID("f89ac270-d4eb-11d1-b682-00805fc79216")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-ieventobjectcollection))], [])
interface IEventObjectCollection : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventobjectcollection-get__newenum))], [])
    HRESULT get__NewEnum(IUnknown* ppUnkEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventobjectcollection-get_item))], [])
    HRESULT get_Item(BSTR objectID, VARIANT* pItem);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventobjectcollection-get_newenum))], [])
    HRESULT get_NewEnum(IEnumEventObject* ppEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventobjectcollection-get_count))], [])
    HRESULT get_Count(int* pCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventobjectcollection-add))], [])
    HRESULT Add(VARIANT* item, BSTR objectID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventobjectcollection-remove))], [])
    HRESULT Remove(BSTR objectID);
}

@GUID("da538ee2-f4de-11d1-b6bb-00805fc79216")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-ieventproperty))], [])
interface IEventProperty : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventproperty-get_name))], [])
    HRESULT get_Name(BSTR* propertyName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventproperty-put_name))], [])
    HRESULT put_Name(BSTR propertyName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventproperty-get_value))], [])
    HRESULT get_Value(VARIANT* propertyValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventproperty-put_value))], [])
    HRESULT put_Value(VARIANT* propertyValue);
}

@GUID("0343e2f4-86f6-11d1-b760-00c04fb926af")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-ieventcontrol))], [])
interface IEventControl : IDispatch
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventcontrol-setpublisherfilter))], [])
    HRESULT SetPublisherFilter(BSTR methodName, IPublisherFilter pPublisherFilter);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventcontrol-get_allowinprocactivation))], [])
    HRESULT get_AllowInprocActivation(BOOL* pfAllowInprocActivation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventcontrol-put_allowinprocactivation))], [])
    HRESULT put_AllowInprocActivation(BOOL fAllowInprocActivation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventcontrol-getsubscriptions))], [])
    HRESULT GetSubscriptions(BSTR methodName, BSTR optionalCriteria, int* optionalErrorIndex, 
                             IEventObjectCollection* ppCollection);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventcontrol-setdefaultquery))], [])
    HRESULT SetDefaultQuery(BSTR methodName, BSTR criteria, int* errorIndex);
}

@GUID("0343e2f5-86f6-11d1-b760-00c04fb926af")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-imultiinterfaceeventcontrol))], [])
interface IMultiInterfaceEventControl : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-imultiinterfaceeventcontrol-setmultiinterfacepublisherfilter))], [])
    HRESULT SetMultiInterfacePublisherFilter(IMultiInterfacePublisherFilter classFilter);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-imultiinterfaceeventcontrol-getsubscriptions))], [])
    HRESULT GetSubscriptions(const(GUID)* eventIID, BSTR bstrMethodName, BSTR optionalCriteria, 
                             int* optionalErrorIndex, IEventObjectCollection* ppCollection);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-imultiinterfaceeventcontrol-setdefaultquery))], [])
    HRESULT SetDefaultQuery(const(GUID)* eventIID, BSTR bstrMethodName, BSTR bstrCriteria, int* errorIndex);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-imultiinterfaceeventcontrol-get_allowinprocactivation))], [])
    HRESULT get_AllowInprocActivation(BOOL* pfAllowInprocActivation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-imultiinterfaceeventcontrol-put_allowinprocactivation))], [])
    HRESULT put_AllowInprocActivation(BOOL fAllowInprocActivation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-imultiinterfaceeventcontrol-get_fireinparallel))], [])
    HRESULT get_FireInParallel(BOOL* pfFireInParallel);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-imultiinterfaceeventcontrol-put_fireinparallel))], [])
    HRESULT put_FireInParallel(BOOL fFireInParallel);
}

@GUID("784121f1-62a6-4b89-855f-d65f296de83a")
interface IDontSupportEventSubscription : IUnknown
{
}


// GUIDs

const GUID CLSID_CEventClass        = GUIDOF!CEventClass;
const GUID CLSID_CEventPublisher    = GUIDOF!CEventPublisher;
const GUID CLSID_CEventSubscription = GUIDOF!CEventSubscription;
const GUID CLSID_CEventSystem       = GUIDOF!CEventSystem;
const GUID CLSID_EventObjectChange  = GUIDOF!EventObjectChange;
const GUID CLSID_EventObjectChange2 = GUIDOF!EventObjectChange2;

const GUID IID_IDontSupportEventSubscription  = GUIDOF!IDontSupportEventSubscription;
const GUID IID_IEnumEventObject               = GUIDOF!IEnumEventObject;
const GUID IID_IEventClass                    = GUIDOF!IEventClass;
const GUID IID_IEventClass2                   = GUIDOF!IEventClass2;
const GUID IID_IEventControl                  = GUIDOF!IEventControl;
const GUID IID_IEventObjectChange             = GUIDOF!IEventObjectChange;
const GUID IID_IEventObjectChange2            = GUIDOF!IEventObjectChange2;
const GUID IID_IEventObjectCollection         = GUIDOF!IEventObjectCollection;
const GUID IID_IEventProperty                 = GUIDOF!IEventProperty;
const GUID IID_IEventPublisher                = GUIDOF!IEventPublisher;
const GUID IID_IEventSubscription             = GUIDOF!IEventSubscription;
const GUID IID_IEventSystem                   = GUIDOF!IEventSystem;
const GUID IID_IFiringControl                 = GUIDOF!IFiringControl;
const GUID IID_IMultiInterfaceEventControl    = GUIDOF!IMultiInterfaceEventControl;
const GUID IID_IMultiInterfacePublisherFilter = GUIDOF!IMultiInterfacePublisherFilter;
const GUID IID_IPublisherFilter               = GUIDOF!IPublisherFilter;
