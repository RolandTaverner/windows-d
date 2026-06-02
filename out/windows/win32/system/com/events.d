// Written in the D programming language.

module windows.win32.system.com.events;

public import windows.core;
public import windows.win32.foundation : BOOL, BSTR, HRESULT;
public import windows.win32.system.com : IDispatch, IUnknown;
public import windows.win32.system.variant : VARIANT;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/ne-eventsys-eoc_changetype
alias EOC_ChangeType = int;
enum : int
{
    EOC_NewObject      = 0x00000000,
    EOC_ModifiedObject = 0x00000001,
    EOC_DeletedObject  = 0x00000002,
}

// Structs


//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/ns-eventsys-comeventsyschangeinfo
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

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-ieventsystem
@GUID("4e14fb9f-2e22-11d1-9964-00c04fbbb345")
interface IEventSystem : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsystem-query
    HRESULT Query(BSTR progID, BSTR queryCriteria, int* errorIndex, IUnknown* ppInterface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsystem-store
    HRESULT Store(BSTR ProgID, IUnknown pInterface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsystem-remove
    HRESULT Remove(BSTR progID, BSTR queryCriteria, int* errorIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsystem-get_eventobjectchangeeventclassid
    HRESULT get_EventObjectChangeEventClassID(BSTR* pbstrEventClassID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsystem-querys
    HRESULT QueryS(BSTR progID, BSTR queryCriteria, IUnknown* ppInterface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsystem-removes
    HRESULT RemoveS(BSTR progID, BSTR queryCriteria);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-ieventpublisher
@GUID("e341516b-2e32-11d1-9964-00c04fbbb345")
interface IEventPublisher : IDispatch
{
    HRESULT get_PublisherID(BSTR* pbstrPublisherID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventpublisher-put_publisherid
    HRESULT put_PublisherID(BSTR bstrPublisherID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventpublisher-get_publishername
    HRESULT get_PublisherName(BSTR* pbstrPublisherName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventpublisher-put_publishername
    HRESULT put_PublisherName(BSTR bstrPublisherName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventpublisher-get_publishertype
    HRESULT get_PublisherType(BSTR* pbstrPublisherType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventpublisher-put_publishertype
    HRESULT put_PublisherType(BSTR bstrPublisherType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventpublisher-get_ownersid
    HRESULT get_OwnerSID(BSTR* pbstrOwnerSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventpublisher-put_ownersid
    HRESULT put_OwnerSID(BSTR bstrOwnerSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventpublisher-get_description
    HRESULT get_Description(BSTR* pbstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventpublisher-put_description
    HRESULT put_Description(BSTR bstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventpublisher-getdefaultproperty
    HRESULT GetDefaultProperty(BSTR bstrPropertyName, VARIANT* propertyValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventpublisher-putdefaultproperty
    HRESULT PutDefaultProperty(BSTR bstrPropertyName, VARIANT* propertyValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventpublisher-removedefaultproperty
    HRESULT RemoveDefaultProperty(BSTR bstrPropertyName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventpublisher-getdefaultpropertycollection
    HRESULT GetDefaultPropertyCollection(IEventObjectCollection* collection);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-ieventclass
@GUID("fb2b72a0-7a68-11d1-88f9-0080c7d771bf")
interface IEventClass : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass-get_eventclassid
    HRESULT get_EventClassID(BSTR* pbstrEventClassID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass-put_eventclassid
    HRESULT put_EventClassID(BSTR bstrEventClassID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass-get_eventclassname
    HRESULT get_EventClassName(BSTR* pbstrEventClassName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass-put_eventclassname
    HRESULT put_EventClassName(BSTR bstrEventClassName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass-get_ownersid
    HRESULT get_OwnerSID(BSTR* pbstrOwnerSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass-put_ownersid
    HRESULT put_OwnerSID(BSTR bstrOwnerSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass-get_firinginterfaceid
    HRESULT get_FiringInterfaceID(BSTR* pbstrFiringInterfaceID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass-put_firinginterfaceid
    HRESULT put_FiringInterfaceID(BSTR bstrFiringInterfaceID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass-get_description
    HRESULT get_Description(BSTR* pbstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass-put_description
    HRESULT put_Description(BSTR bstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass-get_customconfigclsid
    HRESULT get_CustomConfigCLSID(BSTR* pbstrCustomConfigCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass-put_customconfigclsid
    HRESULT put_CustomConfigCLSID(BSTR bstrCustomConfigCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass-get_typelib
    HRESULT get_TypeLib(BSTR* pbstrTypeLib);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass-put_typelib
    HRESULT put_TypeLib(BSTR bstrTypeLib);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-ieventclass2
@GUID("fb2b72a1-7a68-11d1-88f9-0080c7d771bf")
interface IEventClass2 : IEventClass
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass2-get_publisherid
    HRESULT get_PublisherID(BSTR* pbstrPublisherID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass2-put_publisherid
    HRESULT put_PublisherID(BSTR bstrPublisherID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass2-get_multiinterfacepublisherfilterclsid
    HRESULT get_MultiInterfacePublisherFilterCLSID(BSTR* pbstrPubFilCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass2-put_multiinterfacepublisherfilterclsid
    HRESULT put_MultiInterfacePublisherFilterCLSID(BSTR bstrPubFilCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass2-get_allowinprocactivation
    HRESULT get_AllowInprocActivation(BOOL* pfAllowInprocActivation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass2-put_allowinprocactivation
    HRESULT put_AllowInprocActivation(BOOL fAllowInprocActivation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass2-get_fireinparallel
    HRESULT get_FireInParallel(BOOL* pfFireInParallel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventclass2-put_fireinparallel
    HRESULT put_FireInParallel(BOOL fFireInParallel);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-ieventsubscription
@GUID("4a6b0e15-2e38-11d1-9965-00c04fbbb345")
interface IEventSubscription : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-get_subscriptionid
    HRESULT get_SubscriptionID(BSTR* pbstrSubscriptionID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-put_subscriptionid
    HRESULT put_SubscriptionID(BSTR bstrSubscriptionID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-get_subscriptionname
    HRESULT get_SubscriptionName(BSTR* pbstrSubscriptionName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-put_subscriptionname
    HRESULT put_SubscriptionName(BSTR bstrSubscriptionName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-get_publisherid
    HRESULT get_PublisherID(BSTR* pbstrPublisherID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-put_publisherid
    HRESULT put_PublisherID(BSTR bstrPublisherID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-get_eventclassid
    HRESULT get_EventClassID(BSTR* pbstrEventClassID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-put_eventclassid
    HRESULT put_EventClassID(BSTR bstrEventClassID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-get_methodname
    HRESULT get_MethodName(BSTR* pbstrMethodName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-put_methodname
    HRESULT put_MethodName(BSTR bstrMethodName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-get_subscriberclsid
    HRESULT get_SubscriberCLSID(BSTR* pbstrSubscriberCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-put_subscriberclsid
    HRESULT put_SubscriberCLSID(BSTR bstrSubscriberCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-get_subscriberinterface
    HRESULT get_SubscriberInterface(IUnknown* ppSubscriberInterface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-put_subscriberinterface
    HRESULT put_SubscriberInterface(IUnknown pSubscriberInterface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-get_peruser
    HRESULT get_PerUser(BOOL* pfPerUser);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-put_peruser
    HRESULT put_PerUser(BOOL fPerUser);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-get_ownersid
    HRESULT get_OwnerSID(BSTR* pbstrOwnerSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-put_ownersid
    HRESULT put_OwnerSID(BSTR bstrOwnerSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-get_enabled
    HRESULT get_Enabled(BOOL* pfEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-put_enabled
    HRESULT put_Enabled(BOOL fEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-get_description
    HRESULT get_Description(BSTR* pbstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-put_description
    HRESULT put_Description(BSTR bstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-get_machinename
    HRESULT get_MachineName(BSTR* pbstrMachineName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-put_machinename
    HRESULT put_MachineName(BSTR bstrMachineName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-getpublisherproperty
    HRESULT GetPublisherProperty(BSTR bstrPropertyName, VARIANT* propertyValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-putpublisherproperty
    HRESULT PutPublisherProperty(BSTR bstrPropertyName, VARIANT* propertyValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-removepublisherproperty
    HRESULT RemovePublisherProperty(BSTR bstrPropertyName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-getpublisherpropertycollection
    HRESULT GetPublisherPropertyCollection(IEventObjectCollection* collection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-getsubscriberproperty
    HRESULT GetSubscriberProperty(BSTR bstrPropertyName, VARIANT* propertyValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-putsubscriberproperty
    HRESULT PutSubscriberProperty(BSTR bstrPropertyName, VARIANT* propertyValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-removesubscriberproperty
    HRESULT RemoveSubscriberProperty(BSTR bstrPropertyName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-getsubscriberpropertycollection
    HRESULT GetSubscriberPropertyCollection(IEventObjectCollection* collection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-get_interfaceid
    HRESULT get_InterfaceID(BSTR* pbstrInterfaceID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventsubscription-put_interfaceid
    HRESULT put_InterfaceID(BSTR bstrInterfaceID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-ifiringcontrol
@GUID("e0498c93-4efe-11d1-9971-00c04fbbb345")
interface IFiringControl : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ifiringcontrol-firesubscription
    HRESULT FireSubscription(IEventSubscription subscription);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-ipublisherfilter
@GUID("465e5cc0-7b26-11d1-88fb-0080c7d771bf")
interface IPublisherFilter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ipublisherfilter-initialize
    HRESULT Initialize(BSTR methodName, IDispatch dispUserDefined);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ipublisherfilter-preparetofire
    HRESULT PrepareToFire(BSTR methodName, IFiringControl firingControl);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-imultiinterfacepublisherfilter
@GUID("465e5cc1-7b26-11d1-88fb-0080c7d771bf")
interface IMultiInterfacePublisherFilter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-imultiinterfacepublisherfilter-initialize
    HRESULT Initialize(IMultiInterfaceEventControl pEIC);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-imultiinterfacepublisherfilter-preparetofire
    HRESULT PrepareToFire(const(GUID)* iid, BSTR methodName, IFiringControl firingControl);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-ieventobjectchange
@GUID("f4a07d70-2e25-11d1-9964-00c04fbbb345")
interface IEventObjectChange : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventobjectchange-changedsubscription
    HRESULT ChangedSubscription(EOC_ChangeType changeType, BSTR bstrSubscriptionID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventobjectchange-changedeventclass
    HRESULT ChangedEventClass(EOC_ChangeType changeType, BSTR bstrEventClassID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventobjectchange-changedpublisher
    HRESULT ChangedPublisher(EOC_ChangeType changeType, BSTR bstrPublisherID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-ieventobjectchange2
@GUID("7701a9c3-bd68-438f-83e0-67bf4f53a422")
interface IEventObjectChange2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventobjectchange2-changedsubscription
    HRESULT ChangedSubscription(COMEVENTSYSCHANGEINFO* pInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventobjectchange2-changedeventclass
    HRESULT ChangedEventClass(COMEVENTSYSCHANGEINFO* pInfo);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-ienumeventobject
@GUID("f4a07d63-2e25-11d1-9964-00c04fbbb345")
interface IEnumEventObject : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ienumeventobject-clone
    HRESULT Clone(IEnumEventObject* ppInterface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ienumeventobject-next
    HRESULT Next(uint cReqElem, IUnknown* ppInterface, uint* cRetElem);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ienumeventobject-skip
    HRESULT Skip(uint cSkipElem);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-ieventobjectcollection
@GUID("f89ac270-d4eb-11d1-b682-00805fc79216")
interface IEventObjectCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventobjectcollection-get__newenum
    HRESULT get__NewEnum(IUnknown* ppUnkEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventobjectcollection-get_item
    HRESULT get_Item(BSTR objectID, VARIANT* pItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventobjectcollection-get_newenum
    HRESULT get_NewEnum(IEnumEventObject* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventobjectcollection-get_count
    HRESULT get_Count(int* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventobjectcollection-add
    HRESULT Add(VARIANT* item, BSTR objectID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventobjectcollection-remove
    HRESULT Remove(BSTR objectID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-ieventproperty
@GUID("da538ee2-f4de-11d1-b6bb-00805fc79216")
interface IEventProperty : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventproperty-get_name
    HRESULT get_Name(BSTR* propertyName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventproperty-put_name
    HRESULT put_Name(BSTR propertyName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventproperty-get_value
    HRESULT get_Value(VARIANT* propertyValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventproperty-put_value
    HRESULT put_Value(VARIANT* propertyValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-ieventcontrol
@GUID("0343e2f4-86f6-11d1-b760-00c04fb926af")
interface IEventControl : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventcontrol-setpublisherfilter
    HRESULT SetPublisherFilter(BSTR methodName, IPublisherFilter pPublisherFilter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventcontrol-get_allowinprocactivation
    HRESULT get_AllowInprocActivation(BOOL* pfAllowInprocActivation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventcontrol-put_allowinprocactivation
    HRESULT put_AllowInprocActivation(BOOL fAllowInprocActivation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventcontrol-getsubscriptions
    HRESULT GetSubscriptions(BSTR methodName, BSTR optionalCriteria, int* optionalErrorIndex, 
                             IEventObjectCollection* ppCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-ieventcontrol-setdefaultquery
    HRESULT SetDefaultQuery(BSTR methodName, BSTR criteria, int* errorIndex);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nn-eventsys-imultiinterfaceeventcontrol
@GUID("0343e2f5-86f6-11d1-b760-00c04fb926af")
interface IMultiInterfaceEventControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-imultiinterfaceeventcontrol-setmultiinterfacepublisherfilter
    HRESULT SetMultiInterfacePublisherFilter(IMultiInterfacePublisherFilter classFilter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-imultiinterfaceeventcontrol-getsubscriptions
    HRESULT GetSubscriptions(const(GUID)* eventIID, BSTR bstrMethodName, BSTR optionalCriteria, 
                             int* optionalErrorIndex, IEventObjectCollection* ppCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-imultiinterfaceeventcontrol-setdefaultquery
    HRESULT SetDefaultQuery(const(GUID)* eventIID, BSTR bstrMethodName, BSTR bstrCriteria, int* errorIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-imultiinterfaceeventcontrol-get_allowinprocactivation
    HRESULT get_AllowInprocActivation(BOOL* pfAllowInprocActivation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-imultiinterfaceeventcontrol-put_allowinprocactivation
    HRESULT put_AllowInprocActivation(BOOL fAllowInprocActivation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-imultiinterfaceeventcontrol-get_fireinparallel
    HRESULT get_FireInParallel(BOOL* pfFireInParallel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/eventsys/nf-eventsys-imultiinterfaceeventcontrol-put_fireinparallel
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
