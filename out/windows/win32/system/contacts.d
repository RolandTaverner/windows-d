// Written in the D programming language.

module windows.win32.system.contacts;

public import windows.core;
public import windows.win32.foundation : BOOL, FILETIME, HRESULT, PWSTR;
public import windows.win32.system.com : IStream, IUnknown;

extern(Windows) @nogc nothrow:


// Enums


alias CONTACT_AGGREGATION_CREATE_OR_OPEN_OPTIONS = int;
enum : int
{
    CA_CREATE_LOCAL    = 0x00000000,
    CA_CREATE_EXTERNAL = 0x00000001,
}

alias CONTACT_AGGREGATION_COLLECTION_OPTIONS = int;
enum : int
{
    CACO_DEFAULT          = 0x00000000,
    CACO_INCLUDE_EXTERNAL = 0x00000001,
    CACO_EXTERNAL_ONLY    = 0x00000002,
}

// Constants


enum uint CGD_DEFAULT = 0x00000000U;
enum uint CGD_UNKNOWN_PROPERTY = 0x00000000U;
enum uint CGD_STRING_PROPERTY = 0x00000001U;
enum uint CGD_DATE_PROPERTY = 0x00000002U;
enum uint CGD_BINARY_PROPERTY = 0x00000004U;
enum uint CGD_ARRAY_NODE = 0x00000008U;
enum GUID CLSID_ContactAggregationManager = GUID("96c8ad95-c199-44de-b34e-ac33c442df39");

enum : const(wchar)*
{
    CONTACTPROP_PUB_NOTES                        = "Notes",
    CONTACTPROP_PUB_MAILER                       = "Mailer",
    CONTACTPROP_PUB_PROGID                       = "ProgID",
    CONTACTPROP_PUB_GENDER                       = "Gender",
    CONTACTPROP_PUB_GENDER_UNSPECIFIED           = "Unspecified",
    CONTACTPROP_PUB_GENDER_MALE                  = "Male",
    CONTACTPROP_PUB_GENDER_FEMALE                = "Female",
    CONTACTPROP_PUB_CREATIONDATE                 = "CreationDate",
    CONTACTPROP_PUB_L1_CONTACTIDCOLLECTION       = "ContactIDCollection",
    CONTACTPROP_PUB_L2_CONTACTID                 = "/ContactID",
    CONTACTPROP_PUB_L3_VALUE                     = "/Value",
    CONTACTPROP_PUB_L1_NAMECOLLECTION            = "NameCollection",
    CONTACTPROP_PUB_L2_NAME                      = "/Name",
    CONTACTPROP_PUB_L3_FORMATTEDNAME             = "/FormattedName",
    CONTACTPROP_PUB_L3_PHONETIC                  = "/Phonetic",
    CONTACTPROP_PUB_L3_PREFIX                    = "/Prefix",
    CONTACTPROP_PUB_L3_TITLE                     = "/Title",
    CONTACTPROP_PUB_L3_GIVENNAME                 = "/GivenName",
    CONTACTPROP_PUB_L3_FAMILYNAME                = "/FamilyName",
    CONTACTPROP_PUB_L3_MIDDLENAME                = "/MiddleName",
    CONTACTPROP_PUB_L3_GENERATION                = "/Generation",
    CONTACTPROP_PUB_L3_SUFFIX                    = "/Suffix",
    CONTACTPROP_PUB_L3_NICKNAME                  = "/NickName",
    CONTACTPROP_PUB_L1_POSITIONCOLLECTION        = "PositionCollection",
    CONTACTPROP_PUB_L2_POSITION                  = "/Position",
    CONTACTPROP_PUB_L3_ORGANIZATION              = "/Organization",
    CONTACTPROP_PUB_L3_COMPANY                   = "/Company",
    CONTACTPROP_PUB_L3_DEPARTMENT                = "/Department",
    CONTACTPROP_PUB_L3_OFFICE                    = "/Office",
    CONTACTPROP_PUB_L3_JOB_TITLE                 = "/JobTitle",
    CONTACTPROP_PUB_L3_PROFESSION                = "/Profession",
    CONTACTPROP_PUB_L3_ROLE                      = "/Role",
    CONTACTPROP_PUB_L1_PERSONCOLLECTION          = "PersonCollection",
    CONTACTPROP_PUB_L2_PERSON                    = "/Person",
    CONTACTPROP_PUB_L3_PERSONID                  = "/PersonID",
    CONTACTPROP_PUB_L1_DATECOLLECTION            = "DateCollection",
    CONTACTPROP_PUB_L2_DATE                      = "/Date",
    CONTACTPROP_PUB_L1_EMAILADDRESSCOLLECTION    = "EmailAddressCollection",
    CONTACTPROP_PUB_L2_EMAILADDRESS              = "/EmailAddress",
    CONTACTPROP_PUB_L3_ADDRESS                   = "/Address",
    CONTACTPROP_PUB_L3_TYPE                      = "/Type",
    CONTACTPROP_PUB_L1_CERTIFICATECOLLECTION     = "CertificateCollection",
    CONTACTPROP_PUB_L2_CERTIFICATE               = "/Certificate",
    CONTACTPROP_PUB_L3_THUMBPRINT                = "/ThumbPrint",
    CONTACTPROP_PUB_L1_PHONENUMBERCOLLECTION     = "PhoneNumberCollection",
    CONTACTPROP_PUB_L2_PHONENUMBER               = "/PhoneNumber",
    CONTACTPROP_PUB_L3_NUMBER                    = "/Number",
    CONTACTPROP_PUB_L3_ALTERNATE                 = "/Alternate",
    CONTACTPROP_PUB_L1_PHYSICALADDRESSCOLLECTION = "PhysicalAddressCollection",
}

enum : const(wchar)*
{
    CONTACTPROP_PUB_L2_PHYSICALADDRESS     = "/PhysicalAddress",
    CONTACTPROP_PUB_L3_ADDRESSLABEL        = "/AddressLabel",
    CONTACTPROP_PUB_L3_STREET              = "/Street",
    CONTACTPROP_PUB_L3_LOCALITY            = "/Locality",
    CONTACTPROP_PUB_L3_REGION              = "/Region",
    CONTACTPROP_PUB_L3_POSTALCODE          = "/PostalCode",
    CONTACTPROP_PUB_L3_COUNTRY             = "/Country",
    CONTACTPROP_PUB_L3_POBOX               = "/POBox",
    CONTACTPROP_PUB_L3_EXTENDEDADDRESS     = "/ExtendedAddress",
    CONTACTPROP_PUB_L1_IMADDRESSCOLLECTION = "IMAddressCollection",
    CONTACTPROP_PUB_L2_IMADDRESSENTRY      = "/IMAddress",
    CONTACTPROP_PUB_L3_PROTOCOL            = "/Protocol",
    CONTACTPROP_PUB_L1_URLCOLLECTION       = "UrlCollection",
    CONTACTPROP_PUB_L2_URL                 = "/Url",
    CONTACTPROP_PUB_L1_PHOTOCOLLECTION     = "PhotoCollection",
    CONTACTPROP_PUB_L2_PHOTO               = "/Photo",
    CONTACTPROP_PUB_L3_URL                 = "/Url",
}

enum : const(wchar)*
{
    CONTACTLABEL_PUB_PREFERRED     = "Preferred",
    CONTACTLABEL_PUB_PERSONAL      = "Personal",
    CONTACTLABEL_PUB_BUSINESS      = "Business",
    CONTACTLABEL_PUB_OTHER         = "Other",
    CONTACTLABEL_PUB_VOICE         = "Voice",
    CONTACTLABEL_PUB_MOBILE        = "Mobile",
    CONTACTLABEL_PUB_PCS           = "PCS",
    CONTACTLABEL_PUB_CELLULAR      = "Cellular",
    CONTACTLABEL_PUB_CAR           = "Car",
    CONTACTLABEL_PUB_PAGER         = "Pager",
    CONTACTLABEL_PUB_TTY           = "TTY",
    CONTACTLABEL_PUB_FAX           = "Fax",
    CONTACTLABEL_PUB_VIDEO         = "Video",
    CONTACTLABEL_PUB_MODEM         = "Modem",
    CONTACTLABEL_PUB_BBS           = "BBS",
    CONTACTLABEL_PUB_ISDN          = "ISDN",
    CONTACTLABEL_PUB_AGENT         = "Agent",
    CONTACTLABEL_PUB_DOMESTIC      = "Domestic",
    CONTACTLABEL_PUB_INTERNATIONAL = "International",
    CONTACTLABEL_PUB_POSTAL        = "Postal",
    CONTACTLABEL_PUB_PARCEL        = "Parcel",
    CONTACTLABEL_PUB_USERTILE      = "UserTile",
    CONTACTLABEL_PUB_LOGO          = "Logo",
    CONTACTLABEL_WAB_SPOUSE        = "wab:Spouse",
    CONTACTLABEL_WAB_CHILD         = "wab:Child",
    CONTACTLABEL_WAB_MANAGER       = "wab:Manager",
    CONTACTLABEL_WAB_ASSISTANT     = "wab:Assistant",
    CONTACTLABEL_WAB_BIRTHDAY      = "wab:Birthday",
    CONTACTLABEL_WAB_ANNIVERSARY   = "wab:Anniversary",
    CONTACTLABEL_WAB_SOCIALNETWORK = "wab:SocialNetwork",
    CONTACTLABEL_WAB_SCHOOL        = "wab:School",
    CONTACTLABEL_WAB_WISHLIST      = "wab:WishList",
}

// Structs


struct CONTACT_AGGREGATION_BLOB
{
    uint   dwCount;
    ubyte* lpb;
}

// Interfaces

// Microsoft documentation: https://learn.microsoft.com/windows/win32/wpd_sdk/contact-properties
@GUID("61b68808-8eee-4fd1-acb8-3d804c8db056")
struct Contact;

@GUID("7165c8ab-af88-42bd-86fd-5310b4285a02")
struct ContactManager;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nn-icontact-icontactmanager
@GUID("ad553d98-deb1-474a-8e17-fc0c2075b738")
interface IContactManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactmanager-initialize
    HRESULT Initialize(const(PWSTR) pszAppName, const(PWSTR) pszAppVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactmanager-load
    HRESULT Load(const(PWSTR) pszContactID, IContact* ppContact);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactmanager-mergecontactids
    HRESULT MergeContactIDs(const(PWSTR) pszNewContactID, const(PWSTR) pszOldContactID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactmanager-getmecontact
    HRESULT GetMeContact(IContact* ppMeContact);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactmanager-setmecontact
    HRESULT SetMeContact(IContact pMeContact);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactmanager-getcontactcollection
    HRESULT GetContactCollection(IContactCollection* ppContactCollection);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nn-icontact-icontactcollection
@GUID("b6afa338-d779-11d9-8bde-f66bad1e3f3a")
interface IContactCollection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactcollection-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactcollection-next
    HRESULT Next();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactcollection-getcurrent
    HRESULT GetCurrent(IContact* ppContact);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nn-icontact-icontactproperties
@GUID("70dd27dd-5cbd-46e8-bef0-23b6b346288f")
interface IContactProperties : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactproperties-getstring
    HRESULT GetString(const(PWSTR) pszPropertyName, uint dwFlags, PWSTR pszValue, uint cchValue, 
                      uint* pdwcchPropertyValueRequired);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactproperties-getdate
    HRESULT GetDate(const(PWSTR) pszPropertyName, uint dwFlags, FILETIME* pftDateTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactproperties-getbinary
    HRESULT GetBinary(const(PWSTR) pszPropertyName, uint dwFlags, PWSTR pszContentType, uint cchContentType, 
                      uint* pdwcchContentTypeRequired, IStream* ppStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactproperties-getlabels
    HRESULT GetLabels(const(PWSTR) pszArrayElementName, uint dwFlags, PWSTR pszLabels, uint cchLabels, 
                      uint* pdwcchLabelsRequired);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactproperties-setstring
    HRESULT SetString(const(PWSTR) pszPropertyName, uint dwFlags, const(PWSTR) pszValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactproperties-setdate
    HRESULT SetDate(const(PWSTR) pszPropertyName, uint dwFlags, FILETIME ftDateTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactproperties-setbinary
    HRESULT SetBinary(const(PWSTR) pszPropertyName, uint dwFlags, const(PWSTR) pszContentType, IStream pStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactproperties-setlabels
    HRESULT SetLabels(const(PWSTR) pszArrayElementName, uint dwFlags, uint dwLabelCount, const(PWSTR)* ppszLabels);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactproperties-createarraynode
    HRESULT CreateArrayNode(const(PWSTR) pszArrayName, uint dwFlags, BOOL fAppend, PWSTR pszNewArrayElementName, 
                            uint cchNewArrayElementName, uint* pdwcchNewArrayElementNameRequired);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactproperties-deleteproperty
    HRESULT DeleteProperty(const(PWSTR) pszPropertyName, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactproperties-deletearraynode
    HRESULT DeleteArrayNode(const(PWSTR) pszArrayElementName, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactproperties-deletelabels
    HRESULT DeleteLabels(const(PWSTR) pszArrayElementName, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactproperties-getpropertycollection
    HRESULT GetPropertyCollection(IContactPropertyCollection* ppPropertyCollection, uint dwFlags, 
                                  const(PWSTR) pszMultiValueName, uint dwLabelCount, const(PWSTR)* ppszLabels, 
                                  BOOL fAnyLabelMatches);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nn-icontact-icontact
@GUID("f941b671-bda7-4f77-884a-f46462f226a7")
interface IContact : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontact-getcontactid
    HRESULT GetContactID(PWSTR pszContactID, uint cchContactID, uint* pdwcchContactIDRequired);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontact-getpath
    HRESULT GetPath(PWSTR pszPath, uint cchPath, uint* pdwcchPathRequired);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontact-commitchanges
    HRESULT CommitChanges(uint dwCommitFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nn-icontact-icontactpropertycollection
@GUID("ffd3adf8-fa64-4328-b1b6-2e0db509cb3c")
interface IContactPropertyCollection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactpropertycollection-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactpropertycollection-next
    HRESULT Next();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactpropertycollection-getpropertyname
    HRESULT GetPropertyName(PWSTR pszPropertyName, uint cchPropertyName, uint* pdwcchPropertyNameRequired);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactpropertycollection-getpropertytype
    HRESULT GetPropertyType(uint* pdwType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactpropertycollection-getpropertyversion
    HRESULT GetPropertyVersion(uint* pdwVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactpropertycollection-getpropertymodificationdate
    HRESULT GetPropertyModificationDate(FILETIME* pftModificationDate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/icontact/nf-icontact-icontactpropertycollection-getpropertyarrayelementid
    HRESULT GetPropertyArrayElementID(PWSTR pszArrayElementID, uint cchArrayElementID, 
                                      uint* pdwcchArrayElementIDRequired);
}

@GUID("1d865989-4b1f-4b60-8f34-c2ad468b2b50")
interface IContactAggregationManager : IUnknown
{
    HRESULT GetVersionInfo(int* plMajorVersion, int* plMinorVersion);
    HRESULT CreateOrOpenGroup(const(PWSTR) pGroupName, CONTACT_AGGREGATION_CREATE_OR_OPEN_OPTIONS options, 
                              BOOL* pCreatedGroup, IContactAggregationGroup* ppGroup);
    HRESULT CreateExternalContact(IContactAggregationContact* ppItem);
    HRESULT CreateServerPerson(IContactAggregationServerPerson* ppServerPerson);
    HRESULT CreateServerContactLink(IContactAggregationLink* ppServerContactLink);
    HRESULT Flush();
    HRESULT OpenAggregateContact(const(PWSTR) pItemId, IContactAggregationAggregate* ppItem);
    HRESULT OpenContact(const(PWSTR) pItemId, IContactAggregationContact* ppItem);
    HRESULT OpenServerContactLink(const(PWSTR) pItemId, IContactAggregationLink* ppItem);
    HRESULT OpenServerPerson(const(PWSTR) pItemId, IContactAggregationServerPerson* ppItem);
    HRESULT get_Contacts(CONTACT_AGGREGATION_COLLECTION_OPTIONS options, 
                         IContactAggregationContactCollection* ppItems);
    HRESULT get_AggregateContacts(CONTACT_AGGREGATION_COLLECTION_OPTIONS options, 
                                  IContactAggregationAggregateCollection* ppAggregates);
    HRESULT get_Groups(CONTACT_AGGREGATION_COLLECTION_OPTIONS options, 
                       IContactAggregationGroupCollection* ppGroups);
    HRESULT get_ServerPersons(IContactAggregationServerPersonCollection* ppServerPersonCollection);
    HRESULT get_ServerContactLinks(const(PWSTR) pPersonItemId, 
                                   IContactAggregationLinkCollection* ppServerContactLinkCollection);
}

@GUID("1eb22e86-4c86-41f0-9f9f-c251e9fda6c3")
interface IContactAggregationContact : IUnknown
{
    HRESULT Delete();
    HRESULT Save();
    HRESULT MoveToAggregate(const(PWSTR) pAggregateId);
    HRESULT Unlink();
    HRESULT get_AccountId(PWSTR* ppAccountId);
    HRESULT put_AccountId(const(PWSTR) pAccountId);
    HRESULT get_AggregateId(PWSTR* ppAggregateId);
    HRESULT get_Id(PWSTR* ppItemId);
    HRESULT get_IsMe(BOOL* pIsMe);
    HRESULT get_IsExternal(BOOL* pIsExternal);
    HRESULT get_NetworkSourceId(uint* pNetworkSourceId);
    HRESULT put_NetworkSourceId(uint networkSourceId);
    HRESULT get_NetworkSourceIdString(PWSTR* ppNetworkSourceId);
    HRESULT put_NetworkSourceIdString(const(PWSTR) pNetworkSourceId);
    HRESULT get_RemoteObjectId(CONTACT_AGGREGATION_BLOB** ppRemoteObjectId);
    HRESULT put_RemoteObjectId(const(CONTACT_AGGREGATION_BLOB)* pRemoteObjectId);
    HRESULT get_SyncIdentityHash(CONTACT_AGGREGATION_BLOB** ppSyncIdentityHash);
    HRESULT put_SyncIdentityHash(const(CONTACT_AGGREGATION_BLOB)* pSyncIdentityHash);
}

@GUID("826e66fa-81de-43ca-a6fb-8c785cd996c6")
interface IContactAggregationContactCollection : IUnknown
{
    HRESULT FindFirst(IContactAggregationContact* ppItem);
    HRESULT FindNext(IContactAggregationContact* ppItem);
    HRESULT FindFirstByIdentityHash(const(PWSTR) pSourceType, const(PWSTR) pAccountId, 
                                    const(CONTACT_AGGREGATION_BLOB)* pIdentityHash, 
                                    IContactAggregationContact* ppItem);
    HRESULT get_Count(int* pCount);
    HRESULT FindFirstByRemoteId(const(PWSTR) pSourceType, const(PWSTR) pAccountId, 
                                const(CONTACT_AGGREGATION_BLOB)* pRemoteObjectId, IContactAggregationContact* ppItem);
}

@GUID("7ed1c814-cd30-43c8-9b8d-2e489e53d54b")
interface IContactAggregationAggregate : IUnknown
{
    HRESULT Save();
    HRESULT GetComponentItems(IContactAggregationContactCollection* pComponentItems);
    HRESULT Link(const(PWSTR) pAggregateId);
    HRESULT get_Groups(CONTACT_AGGREGATION_COLLECTION_OPTIONS options, 
                       IContactAggregationGroupCollection* ppGroups);
    HRESULT get_AntiLink(PWSTR* ppAntiLink);
    HRESULT put_AntiLink(const(PWSTR) pAntiLink);
    HRESULT get_FavoriteOrder(uint* pFavoriteOrder);
    HRESULT put_FavoriteOrder(uint favoriteOrder);
    HRESULT get_Id(PWSTR* ppItemId);
}

@GUID("2359f3a6-3a68-40af-98db-0f9eb143c3bb")
interface IContactAggregationAggregateCollection : IUnknown
{
    HRESULT FindFirst(IContactAggregationAggregate* ppAggregate);
    HRESULT FindFirstByAntiLinkId(const(PWSTR) pAntiLinkId, IContactAggregationAggregate* ppAggregate);
    HRESULT FindNext(IContactAggregationAggregate* ppAggregate);
    HRESULT get_Count(int* pCount);
}

@GUID("c93c545f-1284-499b-96af-07372af473e0")
interface IContactAggregationGroup : IUnknown
{
    HRESULT Delete();
    HRESULT Save();
    HRESULT Add(const(PWSTR) pAggregateId);
    HRESULT Remove(const(PWSTR) pAggregateId);
    HRESULT get_Members(IContactAggregationAggregateCollection* ppAggregateContactCollection);
    HRESULT get_GlobalObjectId(GUID* pGlobalObjectId);
    HRESULT put_GlobalObjectId(const(GUID)* pGlobalObjectId);
    HRESULT get_Id(PWSTR* ppItemId);
    HRESULT get_Name(PWSTR* ppName);
    HRESULT put_Name(const(PWSTR) pName);
}

@GUID("20a19a9c-d2f3-4b83-9143-beffd2cc226d")
interface IContactAggregationGroupCollection : IUnknown
{
    HRESULT FindFirst(IContactAggregationGroup* ppGroup);
    HRESULT FindFirstByGlobalObjectId(const(GUID)* pGlobalObjectId, IContactAggregationGroup* ppGroup);
    HRESULT FindNext(IContactAggregationGroup* ppGroup);
    HRESULT get_Count(uint* pCount);
}

@GUID("b6813323-a183-4654-8627-79b30de3a0ec")
interface IContactAggregationLink : IUnknown
{
    HRESULT Delete();
    HRESULT Save();
    HRESULT get_AccountId(PWSTR* ppAccountId);
    HRESULT put_AccountId(const(PWSTR) pAccountId);
    HRESULT get_Id(PWSTR* ppItemId);
    HRESULT get_IsLinkResolved(BOOL* pIsLinkResolved);
    HRESULT put_IsLinkResolved(BOOL isLinkResolved);
    HRESULT get_NetworkSourceIdString(PWSTR* ppNetworkSourceId);
    HRESULT put_NetworkSourceIdString(const(PWSTR) pNetworkSourceId);
    HRESULT get_RemoteObjectId(CONTACT_AGGREGATION_BLOB** ppRemoteObjectId);
    HRESULT put_RemoteObjectId(const(CONTACT_AGGREGATION_BLOB)* pRemoteObjectId);
    HRESULT get_ServerPerson(PWSTR* ppServerPersonId);
    HRESULT put_ServerPerson(const(PWSTR) pServerPersonId);
    HRESULT get_ServerPersonBaseline(PWSTR* ppServerPersonId);
    HRESULT put_ServerPersonBaseline(const(PWSTR) pServerPersonId);
    HRESULT get_SyncIdentityHash(CONTACT_AGGREGATION_BLOB** ppSyncIdentityHash);
    HRESULT put_SyncIdentityHash(const(CONTACT_AGGREGATION_BLOB)* pSyncIdentityHash);
}

@GUID("f8bc0e93-fb55-4f28-b9fa-b1c274153292")
interface IContactAggregationLinkCollection : IUnknown
{
    HRESULT FindFirst(IContactAggregationLink* ppServerContactLink);
    HRESULT FindFirstByRemoteId(const(PWSTR) pSourceType, const(PWSTR) pAccountId, 
                                const(CONTACT_AGGREGATION_BLOB)* pRemoteId, 
                                IContactAggregationLink* ppServerContactLink);
    HRESULT FindNext(IContactAggregationLink* ppServerContactLink);
    HRESULT get_Count(uint* pCount);
}

@GUID("7fdc3d4b-1b82-4334-85c5-25184ee5a5f2")
interface IContactAggregationServerPerson : IUnknown
{
    HRESULT Delete();
    HRESULT Save();
    HRESULT get_AggregateId(PWSTR* ppAggregateId);
    HRESULT put_AggregateId(const(PWSTR) pAggregateId);
    HRESULT get_AntiLink(PWSTR* ppAntiLink);
    HRESULT put_AntiLink(const(PWSTR) pAntiLink);
    HRESULT get_AntiLinkBaseline(PWSTR* ppAntiLink);
    HRESULT put_AntiLinkBaseline(const(PWSTR) pAntiLink);
    HRESULT get_FavoriteOrder(uint* pFavoriteOrder);
    HRESULT put_FavoriteOrder(uint favoriteOrder);
    HRESULT get_FavoriteOrderBaseline(uint* pFavoriteOrder);
    HRESULT put_FavoriteOrderBaseline(uint favoriteOrder);
    HRESULT get_Groups(CONTACT_AGGREGATION_BLOB** pGroups);
    HRESULT put_Groups(const(CONTACT_AGGREGATION_BLOB)* pGroups);
    HRESULT get_GroupsBaseline(CONTACT_AGGREGATION_BLOB** ppGroups);
    HRESULT put_GroupsBaseline(const(CONTACT_AGGREGATION_BLOB)* pGroups);
    HRESULT get_Id(PWSTR* ppId);
    HRESULT get_IsTombstone(BOOL* pIsTombstone);
    HRESULT put_IsTombstone(BOOL isTombstone);
    HRESULT get_LinkedAggregateId(PWSTR* ppLinkedAggregateId);
    HRESULT put_LinkedAggregateId(const(PWSTR) pLinkedAggregateId);
    HRESULT get_ObjectId(PWSTR* ppObjectId);
    HRESULT put_ObjectId(const(PWSTR) pObjectId);
}

@GUID("4f730a4a-6604-47b6-a987-669ecf1e5751")
interface IContactAggregationServerPersonCollection : IUnknown
{
    HRESULT FindFirst(IContactAggregationServerPerson* ppServerPerson);
    HRESULT FindFirstByServerId(const(PWSTR) pServerId, IContactAggregationServerPerson* ppServerPerson);
    HRESULT FindFirstByAggregateId(const(PWSTR) pAggregateId, IContactAggregationServerPerson* ppServerPerson);
    HRESULT FindFirstByLinkedAggregateId(const(PWSTR) pAggregateId, 
                                         IContactAggregationServerPerson* ppServerPerson);
    HRESULT FindNext(IContactAggregationServerPerson* ppServerPerson);
    HRESULT get_Count(uint* pCount);
}


// GUIDs

const GUID CLSID_Contact        = GUIDOF!Contact;
const GUID CLSID_ContactManager = GUIDOF!ContactManager;

const GUID IID_IContact                                  = GUIDOF!IContact;
const GUID IID_IContactAggregationAggregate              = GUIDOF!IContactAggregationAggregate;
const GUID IID_IContactAggregationAggregateCollection    = GUIDOF!IContactAggregationAggregateCollection;
const GUID IID_IContactAggregationContact                = GUIDOF!IContactAggregationContact;
const GUID IID_IContactAggregationContactCollection      = GUIDOF!IContactAggregationContactCollection;
const GUID IID_IContactAggregationGroup                  = GUIDOF!IContactAggregationGroup;
const GUID IID_IContactAggregationGroupCollection        = GUIDOF!IContactAggregationGroupCollection;
const GUID IID_IContactAggregationLink                   = GUIDOF!IContactAggregationLink;
const GUID IID_IContactAggregationLinkCollection         = GUIDOF!IContactAggregationLinkCollection;
const GUID IID_IContactAggregationManager                = GUIDOF!IContactAggregationManager;
const GUID IID_IContactAggregationServerPerson           = GUIDOF!IContactAggregationServerPerson;
const GUID IID_IContactAggregationServerPersonCollection = GUIDOF!IContactAggregationServerPersonCollection;
const GUID IID_IContactCollection                        = GUIDOF!IContactCollection;
const GUID IID_IContactManager                           = GUIDOF!IContactManager;
const GUID IID_IContactProperties                        = GUIDOF!IContactProperties;
const GUID IID_IContactPropertyCollection                = GUIDOF!IContactPropertyCollection;
