// Written in the D programming language.

module windows.win32.storage.enhancedstorage;

public import windows.core;
public import system.system : Guid;
public import windows.win32.devices.portabledevices : IPortableDevice;
public import windows.win32.foundation.foundation : BOOL, HRESULT, PROPERTYKEY, PWSTR;
public import windows.win32.system.com.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums


alias ACT_AUTHORIZATION_STATE_VALUE = int;
enum : int
{
    ACT_UNAUTHORIZED = 0x00000000,
    ACT_AUTHORIZED   = 0x00000001,
}

// Constants


enum GUID GUID_DEVINTERFACE_ENHANCED_STORAGE_SILO = GUID("3897f6a4-fd35-4bc8-a0b7-5dbba36adafa");
enum GUID WPD_CATEGORY_ENHANCED_STORAGE = GUID("91248166-b832-4ad4-baa4-7ca0b6b2798c");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 6))], [])*/PROPERTYKEY
{
    ENHANCED_STORAGE_COMMAND_SILO_IS_AUTHENTICATION_SILO                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 6))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 6),
    ENHANCED_STORAGE_COMMAND_SILO_GET_AUTHENTICATION_STATE                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 6))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 7),
    ENHANCED_STORAGE_COMMAND_SILO_ENUMERATE_SILOS                            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 6))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 11),
    ENHANCED_STORAGE_COMMAND_CERT_HOST_CERTIFICATE_AUTHENTICATION            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 6))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 101),
    ENHANCED_STORAGE_COMMAND_CERT_DEVICE_CERTIFICATE_AUTHENTICATION          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 6))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 102),
    ENHANCED_STORAGE_COMMAND_CERT_ADMIN_CERTIFICATE_AUTHENTICATION           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 6))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 103),
    ENHANCED_STORAGE_COMMAND_CERT_INITIALIZE_TO_MANUFACTURER_STATE           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 6))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 104),
    ENHANCED_STORAGE_COMMAND_CERT_GET_CERTIFICATE_COUNT                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 6))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 105),
    ENHANCED_STORAGE_COMMAND_CERT_GET_CERTIFICATE                            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 6))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 106),
    ENHANCED_STORAGE_COMMAND_CERT_SET_CERTIFICATE                            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 6))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 107),
    ENHANCED_STORAGE_COMMAND_CERT_CREATE_CERTIFICATE_REQUEST                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 6))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 108),
    ENHANCED_STORAGE_COMMAND_CERT_UNAUTHENTICATION                           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 6))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 110),
    ENHANCED_STORAGE_COMMAND_CERT_GET_SILO_CAPABILITY                        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 6))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 111),
    ENHANCED_STORAGE_COMMAND_CERT_GET_SILO_CAPABILITIES                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 6))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 112),
    ENHANCED_STORAGE_COMMAND_CERT_GET_ACT_FRIENDLY_NAME                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 6))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 113),
    ENHANCED_STORAGE_COMMAND_CERT_GET_SILO_GUID                              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 6))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 114),
    ENHANCED_STORAGE_COMMAND_PASSWORD_AUTHORIZE_ACT_ACCESS                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 6))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 203),
    ENHANCED_STORAGE_COMMAND_PASSWORD_UNAUTHORIZE_ACT_ACCESS                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 6))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 204),
    ENHANCED_STORAGE_COMMAND_PASSWORD_QUERY_INFORMATION                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 6))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 205),
    ENHANCED_STORAGE_COMMAND_PASSWORD_CONFIG_ADMINISTRATOR                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 6))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 206),
    ENHANCED_STORAGE_COMMAND_PASSWORD_CREATE_USER                            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 6))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 207),
    ENHANCED_STORAGE_COMMAND_PASSWORD_DELETE_USER                            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 6))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 208),
    ENHANCED_STORAGE_COMMAND_PASSWORD_CHANGE_PASSWORD                        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 6))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 209),
    ENHANCED_STORAGE_COMMAND_PASSWORD_INITIALIZE_USER_PASSWORD               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 6))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 210),
    ENHANCED_STORAGE_COMMAND_PASSWORD_START_INITIALIZE_TO_MANUFACTURER_STATE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 6))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 211),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 1006))], [])*/PROPERTYKEY ENHANCED_STORAGE_PROPERTY_AUTHENTICATION_STATE = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 1006))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 1006);

enum : uint
{
    ENHANCED_STORAGE_AUTHN_STATE_UNKNOWN                    = 0x00000000U,
    ENHANCED_STORAGE_AUTHN_STATE_NO_AUTHENTICATION_REQUIRED = 0x00000001U,
    ENHANCED_STORAGE_AUTHN_STATE_NOT_AUTHENTICATED          = 0x00000002U,
    ENHANCED_STORAGE_AUTHN_STATE_AUTHENTICATED              = 0x00000003U,
    ENHANCED_STORAGE_AUTHN_STATE_AUTHENTICATION_DENIED      = 0x80000001U,
    ENHANCED_STORAGE_AUTHN_STATE_DEVICE_ERROR               = 0x80000002U,
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 1009))], [])*/PROPERTYKEY
{
    ENHANCED_STORAGE_PROPERTY_IS_AUTHENTICATION_SILO      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 1009))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 1009),
    ENHANCED_STORAGE_PROPERTY_TEMPORARY_UNAUTHENTICATION  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 1009))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 1010),
    ENHANCED_STORAGE_PROPERTY_MAX_AUTH_FAILURES           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 1009))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 2001),
    ENHANCED_STORAGE_PROPERTY_PASSWORD                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 1009))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 2004),
    ENHANCED_STORAGE_PROPERTY_OLD_PASSWORD                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 1009))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 2005),
    ENHANCED_STORAGE_PROPERTY_PASSWORD_INDICATOR          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 1009))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 2006),
    ENHANCED_STORAGE_PROPERTY_NEW_PASSWORD_INDICATOR      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 1009))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 2007),
    ENHANCED_STORAGE_PROPERTY_NEW_PASSWORD                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 1009))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 2008),
    ENHANCED_STORAGE_PROPERTY_USER_HINT                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 1009))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 2009),
    ENHANCED_STORAGE_PROPERTY_USER_NAME                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 1009))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 2010),
    ENHANCED_STORAGE_PROPERTY_ADMIN_HINT                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 1009))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 2011),
    ENHANCED_STORAGE_PROPERTY_SILO_NAME                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 1009))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 2012),
    ENHANCED_STORAGE_PROPERTY_SILO_FRIENDLYNAME_SPECIFIED = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 1009))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 2013),
    ENHANCED_STORAGE_PROPERTY_PASSWORD_SILO_INFO          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 1009))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 2014),
    ENHANCED_STORAGE_PROPERTY_SECURITY_IDENTIFIER         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 1009))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 2015),
    ENHANCED_STORAGE_PROPERTY_QUERY_SILO_TYPE             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 1009))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 2016),
    ENHANCED_STORAGE_PROPERTY_QUERY_SILO_RESULTS          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 1009))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 2017),
    ENHANCED_STORAGE_PROPERTY_MAX_CERTIFICATE_COUNT       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 1009))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 3001),
    ENHANCED_STORAGE_PROPERTY_STORED_CERTIFICATE_COUNT    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 1009))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 3002),
    ENHANCED_STORAGE_PROPERTY_CERTIFICATE_INDEX           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 1009))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 3003),
    ENHANCED_STORAGE_PROPERTY_CERTIFICATE_TYPE            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 1009))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 3004),
}

enum : uint
{
    CERT_TYPE_EMPTY  = 0x00000000U,
    CERT_TYPE_ASCm   = 0x00000001U,
    CERT_TYPE_PCp    = 0x00000002U,
    CERT_TYPE_ASCh   = 0x00000003U,
    CERT_TYPE_HCh    = 0x00000004U,
    CERT_TYPE_SIGNER = 0x00000006U,
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 3005))], [])*/PROPERTYKEY ENHANCED_STORAGE_PROPERTY_VALIDATION_POLICY = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 3005))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 3005);

enum : uint
{
    CERT_VALIDATION_POLICY_RESERVED = 0x00000000U,
    CERT_VALIDATION_POLICY_NONE     = 0x00000001U,
    CERT_VALIDATION_POLICY_BASIC    = 0x00000002U,
    CERT_VALIDATION_POLICY_EXTENDED = 0x00000003U,
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 3006))], [])*/PROPERTYKEY
{
    ENHANCED_STORAGE_PROPERTY_NEXT_CERTIFICATE_INDEX         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 3006))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 3006),
    ENHANCED_STORAGE_PROPERTY_NEXT_CERTIFICATE_OF_TYPE_INDEX = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 3006))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 3007),
    ENHANCED_STORAGE_PROPERTY_CERTIFICATE_LENGTH             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 3006))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 3008),
    ENHANCED_STORAGE_PROPERTY_CERTIFICATE                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 3006))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 3009),
    ENHANCED_STORAGE_PROPERTY_CERTIFICATE_REQUEST            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 3006))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 3010),
    ENHANCED_STORAGE_PROPERTY_CERTIFICATE_CAPABILITY_TYPE    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 3006))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 3011),
    ENHANCED_STORAGE_PROPERTY_CERTIFICATE_SILO_CAPABILITY    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 3006))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 3012),
    ENHANCED_STORAGE_PROPERTY_CERTIFICATE_SILO_CAPABILITIES  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 3006))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 3013),
}

enum : uint
{
    CERT_CAPABILITY_HASH_ALG                    = 0x00000001U,
    CERT_CAPABILITY_ASYMMETRIC_KEY_CRYPTOGRAPHY = 0x00000002U,
}

enum : uint
{
    CERT_CAPABILITY_SIGNATURE_ALG       = 0x00000003U,
    CERT_CAPABILITY_CERTIFICATE_SUPPORT = 0x00000004U,
    CERT_CAPABILITY_OPTIONAL_FEATURES   = 0x00000005U,
}

enum uint CERT_MAX_CAPABILITY = 0x000000ffU;

enum : /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)*
{
    CERT_RSA_1024_OID          = "1.2.840.113549.1.1.1,1024",
    CERT_RSA_2048_OID          = "1.2.840.113549.1.1.1,2048",
    CERT_RSA_3072_OID          = "1.2.840.113549.1.1.1,3072",
    CERT_RSASSA_PSS_SHA1_OID   = "1.2.840.113549.1.1.10,1.3.14.3.2.26",
    CERT_RSASSA_PSS_SHA256_OID = "1.2.840.113549.1.1.10,2.16.840.1.101.3.4.2.1",
    CERT_RSASSA_PSS_SHA384_OID = "1.2.840.113549.1.1.10,2.16.840.1.101.3.4.2.2",
    CERT_RSASSA_PSS_SHA512_OID = "1.2.840.113549.1.1.10,2.16.840.1.101.3.4.2.3",
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 3014))], [])*/PROPERTYKEY
{
    ENHANCED_STORAGE_PROPERTY_CERTIFICATE_ACT_FRIENDLY_NAME = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 3014))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 3014),
    ENHANCED_STORAGE_PROPERTY_CERTIFICATE_SILO_GUID         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 3014))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 3015),
    ENHANCED_STORAGE_PROPERTY_SIGNER_CERTIFICATE_INDEX      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 3014))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 3016),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 4001))], [])*/PROPERTYKEY
{
    ENHANCED_STORAGE_CAPABILITY_HASH_ALGS                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 4001))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 4001),
    ENHANCED_STORAGE_CAPABILITY_ASYMMETRIC_KEY_CRYPTOGRAPHY   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 4001))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 4002),
    ENHANCED_STORAGE_CAPABILITY_SIGNING_ALGS                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 4001))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 4003),
    ENHANCED_STORAGE_CAPABILITY_RENDER_USER_DATA_UNUSABLE     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 4001))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 4004),
    ENHANCED_STORAGE_CAPABILITY_CERTIFICATE_EXTENSION_PARSING = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2435088742, 47154, 19156, 186, 164, 124, 160, 182, 178, 121, 140}, 4001))], [])*/PROPERTYKEY(GUID("91248166-B832-4AD4-BAA4-7CA0B6B2798C"), 4005),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3229303193, 57823, 17555, 177, 225, 222, 89, 70, 251, 88, 248}, 100))], [])*/PROPERTYKEY
{
    PKEY_Address_Country     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3229303193, 57823, 17555, 177, 225, 222, 89, 70, 251, 88, 248}, 100))], [])*/PROPERTYKEY(GUID("C07B4199-E1DF-4493-B1E1-DE5946FB58F8"), 100),
    PKEY_Address_CountryCode = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3229303193, 57823, 17555, 177, 225, 222, 89, 70, 251, 88, 248}, 100))], [])*/PROPERTYKEY(GUID("C07B4199-E1DF-4493-B1E1-DE5946FB58F8"), 101),
    PKEY_Address_Region      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3229303193, 57823, 17555, 177, 225, 222, 89, 70, 251, 88, 248}, 100))], [])*/PROPERTYKEY(GUID("C07B4199-E1DF-4493-B1E1-DE5946FB58F8"), 102),
    PKEY_Address_RegionCode  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3229303193, 57823, 17555, 177, 225, 222, 89, 70, 251, 88, 248}, 100))], [])*/PROPERTYKEY(GUID("C07B4199-E1DF-4493-B1E1-DE5946FB58F8"), 103),
    PKEY_Address_Town        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3229303193, 57823, 17555, 177, 225, 222, 89, 70, 251, 88, 248}, 100))], [])*/PROPERTYKEY(GUID("C07B4199-E1DF-4493-B1E1-DE5946FB58F8"), 104),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179216, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 7))], [])*/PROPERTYKEY PKEY_Audio_ChannelCount = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179216, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 7))], [])*/PROPERTYKEY(GUID("64440490-4C8B-11D1-8B70-080036B11A03"), 7);

enum : uint
{
    AUDIO_CHANNELCOUNT_MONO   = 0x00000001U,
    AUDIO_CHANNELCOUNT_STEREO = 0x00000002U,
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179216, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 10))], [])*/PROPERTYKEY
{
    PKEY_Audio_Compression       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179216, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 10))], [])*/PROPERTYKEY(GUID("64440490-4C8B-11D1-8B70-080036B11A03"), 10),
    PKEY_Audio_EncodingBitrate   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179216, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 10))], [])*/PROPERTYKEY(GUID("64440490-4C8B-11D1-8B70-080036B11A03"), 4),
    PKEY_Audio_Format            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179216, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 10))], [])*/PROPERTYKEY(GUID("64440490-4C8B-11D1-8B70-080036B11A03"), 2),
    PKEY_Audio_IsVariableBitRate = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179216, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 10))], [])*/PROPERTYKEY(GUID("E6822FEE-8C17-4D62-823C-8E9CFCBD1D5C"), 100),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({628745680, 4374, 16516, 189, 154, 155, 79, 124, 180, 223, 94}, 100))], [])*/PROPERTYKEY
{
    PKEY_Audio_PeakValue    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({628745680, 4374, 16516, 189, 154, 155, 79, 124, 180, 223, 94}, 100))], [])*/PROPERTYKEY(GUID("2579E5D0-1116-4084-BD9A-9B4F7CB4DF5E"), 100),
    PKEY_Audio_SampleRate   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({628745680, 4374, 16516, 189, 154, 155, 79, 124, 180, 223, 94}, 100))], [])*/PROPERTYKEY(GUID("64440490-4C8B-11D1-8B70-080036B11A03"), 5),
    PKEY_Audio_SampleSize   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({628745680, 4374, 16516, 189, 154, 155, 79, 124, 180, 223, 94}, 100))], [])*/PROPERTYKEY(GUID("64440490-4C8B-11D1-8B70-080036B11A03"), 6),
    PKEY_Audio_StreamName   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({628745680, 4374, 16516, 189, 154, 155, 79, 124, 180, 223, 94}, 100))], [])*/PROPERTYKEY(GUID("64440490-4C8B-11D1-8B70-080036B11A03"), 9),
    PKEY_Audio_StreamNumber = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({628745680, 4374, 16516, 189, 154, 155, 79, 124, 180, 223, 94}, 100))], [])*/PROPERTYKEY(GUID("64440490-4C8B-11D1-8B70-080036B11A03"), 8),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({691839834, 2474, 19922, 177, 128, 31, 226, 69, 114, 138, 82}, 100))], [])*/PROPERTYKEY
{
    PKEY_Calendar_Duration                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({691839834, 2474, 19922, 177, 128, 31, 226, 69, 114, 138, 82}, 100))], [])*/PROPERTYKEY(GUID("293CA35A-09AA-4DD2-B180-1FE245728A52"), 100),
    PKEY_Calendar_IsOnline                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({691839834, 2474, 19922, 177, 128, 31, 226, 69, 114, 138, 82}, 100))], [])*/PROPERTYKEY(GUID("BFEE9149-E3E2-49A7-A862-C05988145CEC"), 100),
    PKEY_Calendar_IsRecurring               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({691839834, 2474, 19922, 177, 128, 31, 226, 69, 114, 138, 82}, 100))], [])*/PROPERTYKEY(GUID("315B9C8D-80A9-4EF9-AE16-8E746DA51D70"), 100),
    PKEY_Calendar_Location                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({691839834, 2474, 19922, 177, 128, 31, 226, 69, 114, 138, 82}, 100))], [])*/PROPERTYKEY(GUID("F6272D18-CECC-40B1-B26A-3911717AA7BD"), 100),
    PKEY_Calendar_OptionalAttendeeAddresses = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({691839834, 2474, 19922, 177, 128, 31, 226, 69, 114, 138, 82}, 100))], [])*/PROPERTYKEY(GUID("D55BAE5A-3892-417A-A649-C6AC5AAAEAB3"), 100),
    PKEY_Calendar_OptionalAttendeeNames     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({691839834, 2474, 19922, 177, 128, 31, 226, 69, 114, 138, 82}, 100))], [])*/PROPERTYKEY(GUID("09429607-582D-437F-84C3-DE93A2B24C3C"), 100),
    PKEY_Calendar_OrganizerAddress          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({691839834, 2474, 19922, 177, 128, 31, 226, 69, 114, 138, 82}, 100))], [])*/PROPERTYKEY(GUID("744C8242-4DF5-456C-AB9E-014EFB9021E3"), 100),
    PKEY_Calendar_OrganizerName             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({691839834, 2474, 19922, 177, 128, 31, 226, 69, 114, 138, 82}, 100))], [])*/PROPERTYKEY(GUID("AAA660F9-9865-458E-B484-01BC7FE3973E"), 100),
    PKEY_Calendar_ReminderTime              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({691839834, 2474, 19922, 177, 128, 31, 226, 69, 114, 138, 82}, 100))], [])*/PROPERTYKEY(GUID("72FC5BA4-24F9-4011-9F3F-ADD27AFAD818"), 100),
    PKEY_Calendar_RequiredAttendeeAddresses = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({691839834, 2474, 19922, 177, 128, 31, 226, 69, 114, 138, 82}, 100))], [])*/PROPERTYKEY(GUID("0BA7D6C3-568D-4159-AB91-781A91FB71E5"), 100),
    PKEY_Calendar_RequiredAttendeeNames     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({691839834, 2474, 19922, 177, 128, 31, 226, 69, 114, 138, 82}, 100))], [])*/PROPERTYKEY(GUID("B33AF30B-F552-4584-936C-CB93E5CDA29F"), 100),
    PKEY_Calendar_Resources                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({691839834, 2474, 19922, 177, 128, 31, 226, 69, 114, 138, 82}, 100))], [])*/PROPERTYKEY(GUID("00F58A38-C54B-4C40-8696-97235980EAE1"), 100),
    PKEY_Calendar_ResponseStatus            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({691839834, 2474, 19922, 177, 128, 31, 226, 69, 114, 138, 82}, 100))], [])*/PROPERTYKEY(GUID("188C1F91-3C40-4132-9EC5-D8B03B72A8A2"), 100),
    PKEY_Calendar_ShowTimeAs                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({691839834, 2474, 19922, 177, 128, 31, 226, 69, 114, 138, 82}, 100))], [])*/PROPERTYKEY(GUID("5BF396D4-5EB2-466F-BDE9-2FB3F2361D6E"), 100),
    PKEY_Calendar_ShowTimeAsText            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({691839834, 2474, 19922, 177, 128, 31, 226, 69, 114, 138, 82}, 100))], [])*/PROPERTYKEY(GUID("53DA57CF-62C0-45C4-81DE-7610BCEFD7F5"), 100),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3823130700, 46984, 19034, 187, 32, 127, 90, 68, 201, 172, 221}, 9))], [])*/PROPERTYKEY
{
    PKEY_Communication_AccountName       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3823130700, 46984, 19034, 187, 32, 127, 90, 68, 201, 172, 221}, 9))], [])*/PROPERTYKEY(GUID("E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD"), 9),
    PKEY_Communication_DateItemExpires   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3823130700, 46984, 19034, 187, 32, 127, 90, 68, 201, 172, 221}, 9))], [])*/PROPERTYKEY(GUID("428040AC-A177-4C8A-9760-F6F761227F9A"), 100),
    PKEY_Communication_Direction         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3823130700, 46984, 19034, 187, 32, 127, 90, 68, 201, 172, 221}, 9))], [])*/PROPERTYKEY(GUID("8E531030-B960-4346-AE0D-66BC9A86FB94"), 100),
    PKEY_Communication_FollowupIconIndex = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3823130700, 46984, 19034, 187, 32, 127, 90, 68, 201, 172, 221}, 9))], [])*/PROPERTYKEY(GUID("83A6347E-6FE4-4F40-BA9C-C4865240D1F4"), 100),
    PKEY_Communication_HeaderItem        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3823130700, 46984, 19034, 187, 32, 127, 90, 68, 201, 172, 221}, 9))], [])*/PROPERTYKEY(GUID("C9C34F84-2241-4401-B607-BD20ED75AE7F"), 100),
    PKEY_Communication_PolicyTag         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3823130700, 46984, 19034, 187, 32, 127, 90, 68, 201, 172, 221}, 9))], [])*/PROPERTYKEY(GUID("EC0B4191-AB0B-4C66-90B6-C6637CDEBBAB"), 100),
    PKEY_Communication_SecurityFlags     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3823130700, 46984, 19034, 187, 32, 127, 90, 68, 201, 172, 221}, 9))], [])*/PROPERTYKEY(GUID("8619A4B6-9F4D-4429-8C0F-B996CA59E335"), 100),
    PKEY_Communication_Suffix            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3823130700, 46984, 19034, 187, 32, 127, 90, 68, 201, 172, 221}, 9))], [])*/PROPERTYKEY(GUID("807B653A-9E91-43EF-8F97-11CE04EE20C5"), 100),
    PKEY_Communication_TaskStatus        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3823130700, 46984, 19034, 187, 32, 127, 90, 68, 201, 172, 221}, 9))], [])*/PROPERTYKEY(GUID("BE1A72C6-9A1D-46B7-AFE7-AFAF8CEF4999"), 100),
    PKEY_Communication_TaskStatusText    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3823130700, 46984, 19034, 187, 32, 127, 90, 68, 201, 172, 221}, 9))], [])*/PROPERTYKEY(GUID("A6744477-C237-475B-A075-54F34498292A"), 100),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2601995061, 16639, 4562, 162, 126, 0, 192, 79, 195, 8, 113}, 7))], [])*/PROPERTYKEY PKEY_Computer_DecoratedFreeSpace = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2601995061, 16639, 4562, 162, 126, 0, 192, 79, 195, 8, 113}, 7))], [])*/PROPERTYKEY(GUID("9B174B35-40FF-11D2-A27E-00C04FC30871"), 7);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY
{
    PKEY_Contact_AccountPictureDynamicVideo       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("0B8BB018-2725-4B44-92BA-7933AEB2DDE7"), 2),
    PKEY_Contact_AccountPictureLarge              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("0B8BB018-2725-4B44-92BA-7933AEB2DDE7"), 3),
    PKEY_Contact_AccountPictureSmall              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("0B8BB018-2725-4B44-92BA-7933AEB2DDE7"), 4),
    PKEY_Contact_Anniversary                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("9AD5BADB-CEA7-4470-A03D-B84E51B9949E"), 100),
    PKEY_Contact_AssistantName                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("CD102C9C-5540-4A88-A6F6-64E4981C8CD1"), 100),
    PKEY_Contact_AssistantTelephone               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("9A93244D-A7AD-4FF8-9B99-45EE4CC09AF6"), 100),
    PKEY_Contact_Birthday                         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("176DC63C-2688-4E89-8143-A347800F25E9"), 47),
    PKEY_Contact_BusinessAddress                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("730FB6DD-CF7C-426B-A03F-BD166CC9EE24"), 100),
    PKEY_Contact_BusinessAddress1Country          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 119),
    PKEY_Contact_BusinessAddress1Locality         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 117),
    PKEY_Contact_BusinessAddress1PostalCode       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 120),
    PKEY_Contact_BusinessAddress1Region           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 118),
    PKEY_Contact_BusinessAddress1Street           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 116),
    PKEY_Contact_BusinessAddress2Country          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 124),
    PKEY_Contact_BusinessAddress2Locality         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 122),
    PKEY_Contact_BusinessAddress2PostalCode       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 125),
    PKEY_Contact_BusinessAddress2Region           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 123),
    PKEY_Contact_BusinessAddress2Street           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 121),
    PKEY_Contact_BusinessAddress3Country          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 129),
    PKEY_Contact_BusinessAddress3Locality         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 127),
    PKEY_Contact_BusinessAddress3PostalCode       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 130),
    PKEY_Contact_BusinessAddress3Region           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 128),
    PKEY_Contact_BusinessAddress3Street           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 126),
    PKEY_Contact_BusinessAddressCity              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("402B5934-EC5A-48C3-93E6-85E86A2D934E"), 100),
    PKEY_Contact_BusinessAddressCountry           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("B0B87314-FCF6-4FEB-8DFF-A50DA6AF561C"), 100),
    PKEY_Contact_BusinessAddressPostalCode        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("E1D4A09E-D758-4CD1-B6EC-34A8B5A73F80"), 100),
    PKEY_Contact_BusinessAddressPostOfficeBox     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("BC4E71CE-17F9-48D5-BEE9-021DF0EA5409"), 100),
    PKEY_Contact_BusinessAddressState             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("446F787F-10C4-41CB-A6C4-4D0343551597"), 100),
    PKEY_Contact_BusinessAddressStreet            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("DDD1460F-C0BF-4553-8CE4-10433C908FB0"), 100),
    PKEY_Contact_BusinessEmailAddresses           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("F271C659-7E5E-471F-BA25-7F77B286F836"), 100),
    PKEY_Contact_BusinessFaxNumber                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("91EFF6F3-2E27-42CA-933E-7C999FBE310B"), 100),
    PKEY_Contact_BusinessHomePage                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("56310920-2491-4919-99CE-EADB06FAFDB2"), 100),
    PKEY_Contact_BusinessTelephone                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("6A15E5A0-0A1E-4CD7-BB8C-D2F1B0C929BC"), 100),
    PKEY_Contact_CallbackTelephone                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("BF53D1C3-49E0-4F7F-8567-5A821D8AC542"), 100),
    PKEY_Contact_CarTelephone                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("8FDC6DEA-B929-412B-BA90-397A257465FE"), 100),
    PKEY_Contact_Children                         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("D4729704-8EF1-43EF-9024-2BD381187FD5"), 100),
    PKEY_Contact_CompanyMainTelephone             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("8589E481-6040-473D-B171-7FA89C2708ED"), 100),
    PKEY_Contact_ConnectedServiceDisplayName      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("39B77F4F-A104-4863-B395-2DB2AD8F7BC1"), 100),
    PKEY_Contact_ConnectedServiceIdentities       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("80F41EB8-AFC4-4208-AA5F-CCE21A627281"), 100),
    PKEY_Contact_ConnectedServiceName             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("B5C84C9E-5927-46B5-A3CC-933C21B78469"), 100),
    PKEY_Contact_ConnectedServiceSupportedActions = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({193703960, 10021, 19268, 146, 186, 121, 51, 174, 178, 221, 231}, 2))], [])*/PROPERTYKEY(GUID("A19FB7A9-024B-4371-A8BF-4D29C3E4E9C9"), 100),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2522923651, 64570, 18952, 160, 150, 238, 211, 170, 196, 109, 162}, 100))], [])*/PROPERTYKEY
{
    PKEY_Contact_DataSuppliers               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2522923651, 64570, 18952, 160, 150, 238, 211, 170, 196, 109, 162}, 100))], [])*/PROPERTYKEY(GUID("9660C283-FC3A-4A08-A096-EED3AAC46DA2"), 100),
    PKEY_Contact_Department                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2522923651, 64570, 18952, 160, 150, 238, 211, 170, 196, 109, 162}, 100))], [])*/PROPERTYKEY(GUID("FC9F7306-FF8F-4D49-9FB6-3FFE5C0951EC"), 100),
    PKEY_Contact_DisplayBusinessPhoneNumbers = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2522923651, 64570, 18952, 160, 150, 238, 211, 170, 196, 109, 162}, 100))], [])*/PROPERTYKEY(GUID("364028DA-D895-41FE-A584-302B1BB70A76"), 100),
    PKEY_Contact_DisplayHomePhoneNumbers     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2522923651, 64570, 18952, 160, 150, 238, 211, 170, 196, 109, 162}, 100))], [])*/PROPERTYKEY(GUID("5068BCDF-D697-4D85-8C53-1F1CDAB01763"), 100),
    PKEY_Contact_DisplayMobilePhoneNumbers   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2522923651, 64570, 18952, 160, 150, 238, 211, 170, 196, 109, 162}, 100))], [])*/PROPERTYKEY(GUID("9CB0C358-9D7A-46B1-B466-DCC6F1A3D93D"), 100),
    PKEY_Contact_DisplayOtherPhoneNumbers    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2522923651, 64570, 18952, 160, 150, 238, 211, 170, 196, 109, 162}, 100))], [])*/PROPERTYKEY(GUID("03089873-8EE8-4191-BD60-D31F72B7900B"), 100),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY
{
    PKEY_Contact_EmailAddress                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("F8FA7FA3-D12B-4785-8A4E-691A94F7A3E7"), 100),
    PKEY_Contact_EmailAddress2               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("38965063-EDC8-4268-8491-B7723172CF29"), 100),
    PKEY_Contact_EmailAddress3               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("644D37B4-E1B3-4BAD-B099-7E7C04966ACA"), 100),
    PKEY_Contact_EmailAddresses              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("84D8F337-981D-44B3-9615-C7596DBA17E3"), 100),
    PKEY_Contact_EmailName                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("CC6F4F24-6083-4BD4-8754-674D0DE87AB8"), 100),
    PKEY_Contact_FileAsName                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("F1A24AA7-9CA7-40F6-89EC-97DEF9FFE8DB"), 100),
    PKEY_Contact_FirstName                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("14977844-6B49-4AAD-A714-A4513BF60460"), 100),
    PKEY_Contact_FullName                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("635E9051-50A5-4BA2-B9DB-4ED056C77296"), 100),
    PKEY_Contact_Gender                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("3C8CEE58-D4F0-4CF9-B756-4E5D24447BCD"), 100),
    PKEY_Contact_GenderValue                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("3C8CEE58-D4F0-4CF9-B756-4E5D24447BCD"), 101),
    PKEY_Contact_Hobbies                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("5DC2253F-5E11-4ADF-9CFE-910DD01E3E70"), 100),
    PKEY_Contact_HomeAddress                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("98F98354-617A-46B8-8560-5B1B64BF1F89"), 100),
    PKEY_Contact_HomeAddress1Country         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 104),
    PKEY_Contact_HomeAddress1Locality        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 102),
    PKEY_Contact_HomeAddress1PostalCode      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 105),
    PKEY_Contact_HomeAddress1Region          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 103),
    PKEY_Contact_HomeAddress1Street          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 101),
    PKEY_Contact_HomeAddress2Country         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 109),
    PKEY_Contact_HomeAddress2Locality        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 107),
    PKEY_Contact_HomeAddress2PostalCode      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 110),
    PKEY_Contact_HomeAddress2Region          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 108),
    PKEY_Contact_HomeAddress2Street          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 106),
    PKEY_Contact_HomeAddress3Country         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 114),
    PKEY_Contact_HomeAddress3Locality        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 112),
    PKEY_Contact_HomeAddress3PostalCode      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 115),
    PKEY_Contact_HomeAddress3Region          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 113),
    PKEY_Contact_HomeAddress3Street          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 111),
    PKEY_Contact_HomeAddressCity             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("176DC63C-2688-4E89-8143-A347800F25E9"), 65),
    PKEY_Contact_HomeAddressCountry          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("08A65AA1-F4C9-43DD-9DDF-A33D8E7EAD85"), 100),
    PKEY_Contact_HomeAddressPostalCode       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("8AFCC170-8A46-4B53-9EEE-90BAE7151E62"), 100),
    PKEY_Contact_HomeAddressPostOfficeBox    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("7B9F6399-0A3F-4B12-89BD-4ADC51C918AF"), 100),
    PKEY_Contact_HomeAddressState            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("C89A23D0-7D6D-4EB8-87D4-776A82D493E5"), 100),
    PKEY_Contact_HomeAddressStreet           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("0ADEF160-DB3F-4308-9A21-06237B16FA2A"), 100),
    PKEY_Contact_HomeEmailAddresses          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("56C90E9D-9D46-4963-886F-2E1CD9A694EF"), 100),
    PKEY_Contact_HomeFaxNumber               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("660E04D6-81AB-4977-A09F-82313113AB26"), 100),
    PKEY_Contact_HomeTelephone               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("176DC63C-2688-4E89-8143-A347800F25E9"), 20),
    PKEY_Contact_IMAddress                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("D68DBD8A-3374-4B81-9972-3EC30682DB3D"), 100),
    PKEY_Contact_Initials                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("F3D8F40D-50CB-44A2-9718-40CB9119495D"), 100),
    PKEY_Contact_JA_CompanyNamePhonetic      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("897B3694-FE9E-43E6-8066-260F590C0100"), 2),
    PKEY_Contact_JA_FirstNamePhonetic        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("897B3694-FE9E-43E6-8066-260F590C0100"), 3),
    PKEY_Contact_JA_LastNamePhonetic         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("897B3694-FE9E-43E6-8066-260F590C0100"), 4),
    PKEY_Contact_JobInfo1CompanyAddress      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03"), 120),
    PKEY_Contact_JobInfo1CompanyName         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03"), 102),
    PKEY_Contact_JobInfo1Department          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03"), 106),
    PKEY_Contact_JobInfo1Manager             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03"), 105),
    PKEY_Contact_JobInfo1OfficeLocation      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03"), 104),
    PKEY_Contact_JobInfo1Title               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03"), 103),
    PKEY_Contact_JobInfo1YomiCompanyName     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03"), 101),
    PKEY_Contact_JobInfo2CompanyAddress      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03"), 121),
    PKEY_Contact_JobInfo2CompanyName         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03"), 108),
    PKEY_Contact_JobInfo2Department          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03"), 113),
    PKEY_Contact_JobInfo2Manager             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03"), 112),
    PKEY_Contact_JobInfo2OfficeLocation      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03"), 110),
    PKEY_Contact_JobInfo2Title               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03"), 109),
    PKEY_Contact_JobInfo2YomiCompanyName     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03"), 107),
    PKEY_Contact_JobInfo3CompanyAddress      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03"), 123),
    PKEY_Contact_JobInfo3CompanyName         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03"), 115),
    PKEY_Contact_JobInfo3Department          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03"), 119),
    PKEY_Contact_JobInfo3Manager             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03"), 118),
    PKEY_Contact_JobInfo3OfficeLocation      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03"), 117),
    PKEY_Contact_JobInfo3Title               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03"), 116),
    PKEY_Contact_JobInfo3YomiCompanyName     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03"), 114),
    PKEY_Contact_JobTitle                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("176DC63C-2688-4E89-8143-A347800F25E9"), 6),
    PKEY_Contact_Label                       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("97B0AD89-DF49-49CC-834E-660974FD755B"), 100),
    PKEY_Contact_LastName                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("8F367200-C270-457C-B1D4-E07C5BCD90C7"), 100),
    PKEY_Contact_MailingAddress              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("C0AC206A-827E-4650-95AE-77E2BB74FCC9"), 100),
    PKEY_Contact_MiddleName                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("176DC63C-2688-4E89-8143-A347800F25E9"), 71),
    PKEY_Contact_MobileTelephone             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("176DC63C-2688-4E89-8143-A347800F25E9"), 35),
    PKEY_Contact_NickName                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("176DC63C-2688-4E89-8143-A347800F25E9"), 74),
    PKEY_Contact_OfficeLocation              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("176DC63C-2688-4E89-8143-A347800F25E9"), 7),
    PKEY_Contact_OtherAddress                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("508161FA-313B-43D5-83A1-C1ACCF68622C"), 100),
    PKEY_Contact_OtherAddress1Country        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 134),
    PKEY_Contact_OtherAddress1Locality       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 132),
    PKEY_Contact_OtherAddress1PostalCode     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 135),
    PKEY_Contact_OtherAddress1Region         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 133),
    PKEY_Contact_OtherAddress1Street         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 131),
    PKEY_Contact_OtherAddress2Country        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 139),
    PKEY_Contact_OtherAddress2Locality       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 137),
    PKEY_Contact_OtherAddress2PostalCode     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 140),
    PKEY_Contact_OtherAddress2Region         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 138),
    PKEY_Contact_OtherAddress2Street         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 136),
    PKEY_Contact_OtherAddress3Country        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 144),
    PKEY_Contact_OtherAddress3Locality       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 142),
    PKEY_Contact_OtherAddress3PostalCode     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 145),
    PKEY_Contact_OtherAddress3Region         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 143),
    PKEY_Contact_OtherAddress3Street         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("A7B6F596-D678-4BC1-B05F-0203D27E8AA1"), 141),
    PKEY_Contact_OtherAddressCity            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("6E682923-7F7B-4F0C-A337-CFCA296687BF"), 100),
    PKEY_Contact_OtherAddressCountry         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("8F167568-0AAE-4322-8ED9-6055B7B0E398"), 100),
    PKEY_Contact_OtherAddressPostalCode      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("95C656C1-2ABF-4148-9ED3-9EC602E3B7CD"), 100),
    PKEY_Contact_OtherAddressPostOfficeBox   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("8B26EA41-058F-43F6-AECC-4035681CE977"), 100),
    PKEY_Contact_OtherAddressState           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("71B377D6-E570-425F-A170-809FAE73E54E"), 100),
    PKEY_Contact_OtherAddressStreet          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("FF962609-B7D6-4999-862D-95180D529AEA"), 100),
    PKEY_Contact_OtherEmailAddresses         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("11D6336B-38C4-4EC9-84D6-EB38D0B150AF"), 100),
    PKEY_Contact_PagerTelephone              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("D6304E01-F8F5-4F45-8B15-D024A6296789"), 100),
    PKEY_Contact_PersonalTitle               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("176DC63C-2688-4E89-8143-A347800F25E9"), 69),
    PKEY_Contact_PhoneNumbersCanonical       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("D042D2A1-927E-40B5-A503-6EDBD42A517E"), 100),
    PKEY_Contact_Prefix                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("176DC63C-2688-4E89-8143-A347800F25E9"), 75),
    PKEY_Contact_PrimaryAddressCity          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("C8EA94F0-A9E3-4969-A94B-9C62A95324E0"), 100),
    PKEY_Contact_PrimaryAddressCountry       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("E53D799D-0F3F-466E-B2FF-74634A3CB7A4"), 100),
    PKEY_Contact_PrimaryAddressPostalCode    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("18BBD425-ECFD-46EF-B612-7B4A6034EDA0"), 100),
    PKEY_Contact_PrimaryAddressPostOfficeBox = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("DE5EF3C7-46E1-484E-9999-62C5308394C1"), 100),
    PKEY_Contact_PrimaryAddressState         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("F1176DFE-7138-4640-8B4C-AE375DC70A6D"), 100),
    PKEY_Contact_PrimaryAddressStreet        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("63C25B20-96BE-488F-8788-C09C407AD812"), 100),
    PKEY_Contact_PrimaryEmailAddress         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("176DC63C-2688-4E89-8143-A347800F25E9"), 48),
    PKEY_Contact_PrimaryTelephone            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("176DC63C-2688-4E89-8143-A347800F25E9"), 25),
    PKEY_Contact_Profession                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("7268AF55-1CE4-4F6E-A41F-B6E4EF10E4A9"), 100),
    PKEY_Contact_SpouseName                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("9D2408B6-3167-422B-82B0-F583B7A7CFE3"), 100),
    PKEY_Contact_Suffix                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("176DC63C-2688-4E89-8143-A347800F25E9"), 73),
    PKEY_Contact_TelexNumber                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("C554493C-C1F7-40C1-A76C-EF8C0614003E"), 100),
    PKEY_Contact_TTYTDDTelephone             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("AAF16BAC-2B55-45E6-9F6D-415EB94910DF"), 100),
    PKEY_Contact_WebPage                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD"), 18),
    PKEY_Contact_Webpage2                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03"), 124),
    PKEY_Contact_Webpage3                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4177166243, 53547, 18309, 138, 78, 105, 26, 148, 247, 163, 231}, 100))], [])*/PROPERTYKEY(GUID("00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03"), 125),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1705609333, 15488, 16555, 171, 188, 239, 218, 247, 125, 190, 226}, 100))], [])*/PROPERTYKEY PKEY_AcquisitionID = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1705609333, 15488, 16555, 171, 188, 239, 218, 247, 125, 190, 226}, 100))], [])*/PROPERTYKEY(GUID("65A98875-3C80-40AB-ABBC-EFDAF77DBEE2"), 100);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3451896167, 13182, 16856, 175, 124, 140, 9, 32, 84, 41, 199}, 100))], [])*/PROPERTYKEY
{
    PKEY_ApplicationDefinedProperties = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3451896167, 13182, 16856, 175, 124, 140, 9, 32, 84, 41, 199}, 100))], [])*/PROPERTYKEY(GUID("CDBFC167-337E-41D8-AF7C-8C09205429C7"), 100),
    PKEY_ApplicationName              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3451896167, 13182, 16856, 175, 124, 140, 9, 32, 84, 41, 199}, 100))], [])*/PROPERTYKEY(GUID("F29F85E0-4FF9-1068-AB91-08002B27B3D9"), 18),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1345126059, 18411, 17820, 185, 96, 230, 216, 114, 143, 119, 1}, 102))], [])*/PROPERTYKEY PKEY_AppZoneIdentifier = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1345126059, 18411, 17820, 185, 96, 230, 216, 114, 143, 119, 1}, 102))], [])*/PROPERTYKEY(GUID("502CFEAB-47EB-459C-B960-E6D8728F7701"), 102);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4070540768, 20473, 4200, 171, 145, 8, 0, 43, 39, 179, 217}, 4))], [])*/PROPERTYKEY
{
    PKEY_Author                                          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4070540768, 20473, 4200, 171, 145, 8, 0, 43, 39, 179, 217}, 4))], [])*/PROPERTYKEY(GUID("F29F85E0-4FF9-1068-AB91-08002B27B3D9"), 4),
    PKEY_CachedFileUpdaterContentIdForConflictResolution = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4070540768, 20473, 4200, 171, 145, 8, 0, 43, 39, 179, 217}, 4))], [])*/PROPERTYKEY(GUID("FCEFF153-E839-4CF3-A9E7-EA22832094B8"), 114),
    PKEY_CachedFileUpdaterContentIdForStream             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4070540768, 20473, 4200, 171, 145, 8, 0, 43, 39, 179, 217}, 4))], [])*/PROPERTYKEY(GUID("FCEFF153-E839-4CF3-A9E7-EA22832094B8"), 113),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2601995061, 16639, 4562, 162, 126, 0, 192, 79, 195, 8, 113}, 3))], [])*/PROPERTYKEY
{
    PKEY_Capacity                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2601995061, 16639, 4562, 162, 126, 0, 192, 79, 195, 8, 113}, 3))], [])*/PROPERTYKEY(GUID("9B174B35-40FF-11D2-A27E-00C04FC30871"), 3),
    PKEY_Category                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2601995061, 16639, 4562, 162, 126, 0, 192, 79, 195, 8, 113}, 3))], [])*/PROPERTYKEY(GUID("D5CDD502-2E9C-101B-9397-08002B2CF9AE"), 2),
    PKEY_Comment                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2601995061, 16639, 4562, 162, 126, 0, 192, 79, 195, 8, 113}, 3))], [])*/PROPERTYKEY(GUID("F29F85E0-4FF9-1068-AB91-08002B27B3D9"), 6),
    PKEY_Company                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2601995061, 16639, 4562, 162, 126, 0, 192, 79, 195, 8, 113}, 3))], [])*/PROPERTYKEY(GUID("D5CDD502-2E9C-101B-9397-08002B2CF9AE"), 15),
    PKEY_ComputerName             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2601995061, 16639, 4562, 162, 126, 0, 192, 79, 195, 8, 113}, 3))], [])*/PROPERTYKEY(GUID("28636AA6-953D-11D2-B5D6-00C04FD918D0"), 5),
    PKEY_ContainedItems           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2601995061, 16639, 4562, 162, 126, 0, 192, 79, 195, 8, 113}, 3))], [])*/PROPERTYKEY(GUID("28636AA6-953D-11D2-B5D6-00C04FD918D0"), 29),
    PKEY_ContentId                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2601995061, 16639, 4562, 162, 126, 0, 192, 79, 195, 8, 113}, 3))], [])*/PROPERTYKEY(GUID("FCEFF153-E839-4CF3-A9E7-EA22832094B8"), 132),
    PKEY_ContentStatus            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2601995061, 16639, 4562, 162, 126, 0, 192, 79, 195, 8, 113}, 3))], [])*/PROPERTYKEY(GUID("D5CDD502-2E9C-101B-9397-08002B2CF9AE"), 27),
    PKEY_ContentType              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2601995061, 16639, 4562, 162, 126, 0, 192, 79, 195, 8, 113}, 3))], [])*/PROPERTYKEY(GUID("D5CDD502-2E9C-101B-9397-08002B2CF9AE"), 26),
    PKEY_ContentUri               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2601995061, 16639, 4562, 162, 126, 0, 192, 79, 195, 8, 113}, 3))], [])*/PROPERTYKEY(GUID("FCEFF153-E839-4CF3-A9E7-EA22832094B8"), 131),
    PKEY_Copyright                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2601995061, 16639, 4562, 162, 126, 0, 192, 79, 195, 8, 113}, 3))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 11),
    PKEY_CreatorAppId             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2601995061, 16639, 4562, 162, 126, 0, 192, 79, 195, 8, 113}, 3))], [])*/PROPERTYKEY(GUID("C2EA046E-033C-4E91-BD5B-D4942F6BBE49"), 2),
    PKEY_CreatorOpenWithUIOptions = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2601995061, 16639, 4562, 162, 126, 0, 192, 79, 195, 8, 113}, 3))], [])*/PROPERTYKEY(GUID("C2EA046E-033C-4E91-BD5B-D4942F6BBE49"), 3),
}

enum : uint
{
    CREATOROPENWITHUIOPTION_HIDDEN  = 0x00000000U,
    CREATOROPENWITHUIOPTION_VISIBLE = 0x00000001U,
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({511812600, 41743, 16967, 185, 238, 29, 3, 104, 169, 66, 92}, 2))], [])*/PROPERTYKEY PKEY_DataObjectFormat = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({511812600, 41743, 16967, 185, 238, 29, 3, 104, 169, 66, 92}, 2))], [])*/PROPERTYKEY(GUID("1E81A3F8-A30F-4247-B9EE-1D0368A9425C"), 2);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 16))], [])*/PROPERTYKEY
{
    PKEY_DateAccessed  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 16))], [])*/PROPERTYKEY(GUID("B725F130-47EF-101A-A5F1-02608C9EEBAC"), 16),
    PKEY_DateAcquired  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 16))], [])*/PROPERTYKEY(GUID("2CBAA8F5-D81F-47CA-B17A-F8D822300131"), 100),
    PKEY_DateArchived  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 16))], [])*/PROPERTYKEY(GUID("43F8D7B7-A444-4F87-9383-52271C9B915C"), 100),
    PKEY_DateCompleted = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 16))], [])*/PROPERTYKEY(GUID("72FAB781-ACDA-43E5-B155-B2434F85E678"), 100),
    PKEY_DateCreated   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 16))], [])*/PROPERTYKEY(GUID("B725F130-47EF-101A-A5F1-02608C9EEBAC"), 15),
    PKEY_DateImported  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 16))], [])*/PROPERTYKEY(GUID("14B81DA1-0135-4D31-96D9-6CBFC9671A99"), 18258),
    PKEY_DateModified  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 16))], [])*/PROPERTYKEY(GUID("B725F130-47EF-101A-A5F1-02608C9EEBAC"), 14),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1568061055, 39741, 17595, 182, 174, 37, 218, 79, 99, 138, 103}, 10))], [])*/PROPERTYKEY PKEY_DefaultSaveLocationDisplay = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1568061055, 39741, 17595, 182, 174, 37, 218, 79, 99, 138, 103}, 10))], [])*/PROPERTYKEY(GUID("5D76B67F-9B3D-44BB-B6AE-25DA4F638A67"), 10);

enum : uint
{
    ISDEFAULTSAVE_NONE     = 0x00000000U,
    ISDEFAULTSAVE_OWNER    = 0x00000001U,
    ISDEFAULTSAVE_NONOWNER = 0x00000002U,
    ISDEFAULTSAVE_BOTH     = 0x00000003U,
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1065644725, 57519, 19890, 128, 113, 197, 63, 231, 106, 231, 206}, 100))], [])*/PROPERTYKEY
{
    PKEY_DueDate           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1065644725, 57519, 19890, 128, 113, 197, 63, 231, 106, 231, 206}, 100))], [])*/PROPERTYKEY(GUID("3F8472B5-E0AF-4DB2-8071-C53FE76AE7CE"), 100),
    PKEY_EndDate           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1065644725, 57519, 19890, 128, 113, 197, 63, 231, 106, 231, 206}, 100))], [])*/PROPERTYKEY(GUID("C75FAA05-96FD-49E7-9CB4-9F601082D553"), 100),
    PKEY_ExpandoProperties = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1065644725, 57519, 19890, 128, 113, 197, 63, 231, 106, 231, 206}, 100))], [])*/PROPERTYKEY(GUID("6FA20DE6-D11C-4D9D-A154-64317628C12D"), 100),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 18))], [])*/PROPERTYKEY
{
    PKEY_FileAllocationSize            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 18))], [])*/PROPERTYKEY(GUID("B725F130-47EF-101A-A5F1-02608C9EEBAC"), 18),
    PKEY_FileAttributes                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 18))], [])*/PROPERTYKEY(GUID("B725F130-47EF-101A-A5F1-02608C9EEBAC"), 13),
    PKEY_FileCount                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 18))], [])*/PROPERTYKEY(GUID("28636AA6-953D-11D2-B5D6-00C04FD918D0"), 12),
    PKEY_FileDescription               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 18))], [])*/PROPERTYKEY(GUID("0CEF7D53-FA64-11D1-A203-0000F81FEDEE"), 3),
    PKEY_FileExtension                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 18))], [])*/PROPERTYKEY(GUID("E4F10A3C-49E6-405D-8288-A23BD4EEAA6C"), 100),
    PKEY_FileFRN                       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 18))], [])*/PROPERTYKEY(GUID("B725F130-47EF-101A-A5F1-02608C9EEBAC"), 21),
    PKEY_FileName                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 18))], [])*/PROPERTYKEY(GUID("41CF5AE0-F75A-4806-BD87-59C7D9248EB9"), 100),
    PKEY_FileOfflineAvailabilityStatus = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 18))], [])*/PROPERTYKEY(GUID("FCEFF153-E839-4CF3-A9E7-EA22832094B8"), 100),
}

enum : uint
{
    FILEOFFLINEAVAILABILITYSTATUS_NOTAVAILABLEOFFLINE = 0x00000000U,
    FILEOFFLINEAVAILABILITYSTATUS_PARTIAL             = 0x00000001U,
    FILEOFFLINEAVAILABILITYSTATUS_COMPLETE            = 0x00000002U,
    FILEOFFLINEAVAILABILITYSTATUS_COMPLETE_PINNED     = 0x00000003U,
    FILEOFFLINEAVAILABILITYSTATUS_EXCLUDED            = 0x00000004U,
    FILEOFFLINEAVAILABILITYSTATUS_FOLDER_EMPTY        = 0x00000005U,
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2601995060, 16639, 4562, 162, 126, 0, 192, 79, 195, 8, 113}, 4))], [])*/PROPERTYKEY
{
    PKEY_FileOwner             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2601995060, 16639, 4562, 162, 126, 0, 192, 79, 195, 8, 113}, 4))], [])*/PROPERTYKEY(GUID("9B174B34-40FF-11D2-A27E-00C04FC30871"), 4),
    PKEY_FilePlaceholderStatus = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2601995060, 16639, 4562, 162, 126, 0, 192, 79, 195, 8, 113}, 4))], [])*/PROPERTYKEY(GUID("B2F9B9D6-FEC4-4DD5-94D7-8957488C807B"), 2),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({217021779, 64100, 4561, 162, 3, 0, 0, 248, 31, 237, 238}, 4))], [])*/PROPERTYKEY
{
    PKEY_FileVersion   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({217021779, 64100, 4561, 162, 3, 0, 0, 248, 31, 237, 238}, 4))], [])*/PROPERTYKEY(GUID("0CEF7D53-FA64-11D1-A203-0000F81FEDEE"), 4),
    PKEY_FindData      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({217021779, 64100, 4561, 162, 3, 0, 0, 248, 31, 237, 238}, 4))], [])*/PROPERTYKEY(GUID("28636AA6-953D-11D2-B5D6-00C04FD918D0"), 0),
    PKEY_FlagColor     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({217021779, 64100, 4561, 162, 3, 0, 0, 248, 31, 237, 238}, 4))], [])*/PROPERTYKEY(GUID("67DF94DE-0CA7-4D6F-B792-053A3E4F03CF"), 100),
    PKEY_FlagColorText = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({217021779, 64100, 4561, 162, 3, 0, 0, 248, 31, 237, 238}, 4))], [])*/PROPERTYKEY(GUID("45EAE747-8E2A-40AE-8CBF-CA52ABA6152A"), 100),
    PKEY_FlagStatus    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({217021779, 64100, 4561, 162, 3, 0, 0, 248, 31, 237, 238}, 4))], [])*/PROPERTYKEY(GUID("E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD"), 12),
}

enum : int
{
    FLAGSTATUS_NOTFLAGGED = 0x00000000,
    FLAGSTATUS_COMPLETED  = 0x00000001,
    FLAGSTATUS_FOLLOWUP   = 0x00000002,
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3696557358, 6301, 18545, 170, 1, 8, 194, 245, 122, 74, 188}, 100))], [])*/PROPERTYKEY PKEY_FlagStatusText = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3696557358, 6301, 18545, 170, 1, 8, 194, 245, 122, 74, 188}, 100))], [])*/PROPERTYKEY(GUID("DC54FD2E-189D-4871-AA01-08C2F57A4ABC"), 100);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4243583315, 59449, 19699, 169, 231, 234, 34, 131, 32, 148, 184}, 101))], [])*/PROPERTYKEY
{
    PKEY_FolderKind        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4243583315, 59449, 19699, 169, 231, 234, 34, 131, 32, 148, 184}, 101))], [])*/PROPERTYKEY(GUID("FCEFF153-E839-4CF3-A9E7-EA22832094B8"), 101),
    PKEY_FolderNameDisplay = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4243583315, 59449, 19699, 169, 231, 234, 34, 131, 32, 148, 184}, 101))], [])*/PROPERTYKEY(GUID("B725F130-47EF-101A-A5F1-02608C9EEBAC"), 25),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2601995061, 16639, 4562, 162, 126, 0, 192, 79, 195, 8, 113}, 2))], [])*/PROPERTYKEY
{
    PKEY_FreeSpace = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2601995061, 16639, 4562, 162, 126, 0, 192, 79, 195, 8, 113}, 2))], [])*/PROPERTYKEY(GUID("9B174B35-40FF-11D2-A27E-00C04FC30871"), 2),
    PKEY_FullText  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2601995061, 16639, 4562, 162, 126, 0, 192, 79, 195, 8, 113}, 2))], [])*/PROPERTYKEY(GUID("1E3EE840-BC2B-476C-8237-2ACD1A839B22"), 6),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4070540768, 20473, 4200, 171, 145, 8, 0, 43, 39, 179, 217}, 24))], [])*/PROPERTYKEY PKEY_HighKeywords = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4070540768, 20473, 4200, 171, 145, 8, 0, 43, 39, 179, 217}, 24))], [])*/PROPERTYKEY(GUID("F29F85E0-4FF9-1068-AB91-08002B27B3D9"), 24);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2725202684, 29510, 17049, 190, 71, 235, 26, 230, 19, 19, 159}, 100))], [])*/PROPERTYKEY
{
    PKEY_Identity                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2725202684, 29510, 17049, 190, 71, 235, 26, 230, 19, 19, 159}, 100))], [])*/PROPERTYKEY(GUID("A26F4AFC-7346-4299-BE47-EB1AE613139F"), 100),
    PKEY_Identity_Blob                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2725202684, 29510, 17049, 190, 71, 235, 26, 230, 19, 19, 159}, 100))], [])*/PROPERTYKEY(GUID("8C3B93A4-BAED-1A83-9A32-102EE313F6EB"), 100),
    PKEY_Identity_DisplayName         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2725202684, 29510, 17049, 190, 71, 235, 26, 230, 19, 19, 159}, 100))], [])*/PROPERTYKEY(GUID("7D683FC9-D155-45A8-BB1F-89D19BCB792F"), 100),
    PKEY_Identity_InternetSid         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2725202684, 29510, 17049, 190, 71, 235, 26, 230, 19, 19, 159}, 100))], [])*/PROPERTYKEY(GUID("6D6D5D49-265D-4688-9F4E-1FDD33E7CC83"), 100),
    PKEY_Identity_IsMeIdentity        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2725202684, 29510, 17049, 190, 71, 235, 26, 230, 19, 19, 159}, 100))], [])*/PROPERTYKEY(GUID("A4108708-09DF-4377-9DFC-6D99986D5A67"), 100),
    PKEY_Identity_KeyProviderContext  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2725202684, 29510, 17049, 190, 71, 235, 26, 230, 19, 19, 159}, 100))], [])*/PROPERTYKEY(GUID("A26F4AFC-7346-4299-BE47-EB1AE613139F"), 17),
    PKEY_Identity_KeyProviderName     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2725202684, 29510, 17049, 190, 71, 235, 26, 230, 19, 19, 159}, 100))], [])*/PROPERTYKEY(GUID("A26F4AFC-7346-4299-BE47-EB1AE613139F"), 16),
    PKEY_Identity_LogonStatusString   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2725202684, 29510, 17049, 190, 71, 235, 26, 230, 19, 19, 159}, 100))], [])*/PROPERTYKEY(GUID("F18DEDF3-337F-42C0-9E03-CEE08708A8C3"), 100),
    PKEY_Identity_PrimaryEmailAddress = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2725202684, 29510, 17049, 190, 71, 235, 26, 230, 19, 19, 159}, 100))], [])*/PROPERTYKEY(GUID("FCC16823-BAED-4F24-9B32-A0982117F7FA"), 100),
    PKEY_Identity_PrimarySid          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2725202684, 29510, 17049, 190, 71, 235, 26, 230, 19, 19, 159}, 100))], [])*/PROPERTYKEY(GUID("2B1B801E-C0C1-4987-9EC5-72FA89814787"), 100),
    PKEY_Identity_ProviderData        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2725202684, 29510, 17049, 190, 71, 235, 26, 230, 19, 19, 159}, 100))], [])*/PROPERTYKEY(GUID("A8A74B92-361B-4E9A-B722-7C4A7330A312"), 100),
    PKEY_Identity_ProviderID          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2725202684, 29510, 17049, 190, 71, 235, 26, 230, 19, 19, 159}, 100))], [])*/PROPERTYKEY(GUID("74A7DE49-FA11-4D3D-A006-DB7E08675916"), 100),
    PKEY_Identity_QualifiedUserName   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2725202684, 29510, 17049, 190, 71, 235, 26, 230, 19, 19, 159}, 100))], [])*/PROPERTYKEY(GUID("DA520E51-F4E9-4739-AC82-02E0A95C9030"), 100),
    PKEY_Identity_UniqueID            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2725202684, 29510, 17049, 190, 71, 235, 26, 230, 19, 19, 159}, 100))], [])*/PROPERTYKEY(GUID("E55FC3B0-2B60-4220-918E-B21E8BF16016"), 100),
    PKEY_Identity_UserName            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2725202684, 29510, 17049, 190, 71, 235, 26, 230, 19, 19, 159}, 100))], [])*/PROPERTYKEY(GUID("C4322503-78CA-49C6-9ACC-A68E2AFD7B6B"), 100),
    PKEY_IdentityProvider_Name        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2725202684, 29510, 17049, 190, 71, 235, 26, 230, 19, 19, 159}, 100))], [])*/PROPERTYKEY(GUID("B96EFF7B-35CA-4A35-8607-29E3A54C46EA"), 100),
    PKEY_IdentityProvider_Picture     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2725202684, 29510, 17049, 190, 71, 235, 26, 230, 19, 19, 159}, 100))], [])*/PROPERTYKEY(GUID("2425166F-5642-4864-992F-98FD98F294C3"), 100),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3614772960, 50852, 18668, 181, 62, 184, 123, 82, 230, 208, 115}, 100))], [])*/PROPERTYKEY PKEY_ImageParsingName = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3614772960, 50852, 18668, 181, 62, 184, 123, 82, 230, 208, 115}, 100))], [])*/PROPERTYKEY(GUID("D7750EE0-C6A4-48EC-B53E-B87B52E6D073"), 100);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3823130700, 46984, 19034, 187, 32, 127, 90, 68, 201, 172, 221}, 11))], [])*/PROPERTYKEY PKEY_Importance = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3823130700, 46984, 19034, 187, 32, 127, 90, 68, 201, 172, 221}, 11))], [])*/PROPERTYKEY(GUID("E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD"), 11);

enum : int
{
    IMPORTANCE_LOW_MIN    = 0x00000000,
    IMPORTANCE_LOW_SET    = 0x00000001,
    IMPORTANCE_LOW_MAX    = 0x00000001,
    IMPORTANCE_NORMAL_MIN = 0x00000002,
    IMPORTANCE_NORMAL_SET = 0x00000003,
    IMPORTANCE_NORMAL_MAX = 0x00000004,
    IMPORTANCE_HIGH_MIN   = 0x00000005,
    IMPORTANCE_HIGH_SET   = 0x00000005,
    IMPORTANCE_HIGH_MAX   = 0x00000005,
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2746390417, 30483, 19997, 187, 64, 23, 219, 133, 240, 24, 49}, 100))], [])*/PROPERTYKEY PKEY_ImportanceText = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2746390417, 30483, 19997, 187, 64, 23, 219, 133, 240, 24, 49}, 100))], [])*/PROPERTYKEY(GUID("A3B29791-7713-4E1D-BB40-17DB85F01831"), 100);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4064232028, 29089, 20392, 146, 47, 103, 142, 164, 166, 4, 8}, 100))], [])*/PROPERTYKEY
{
    PKEY_IsAttachment                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4064232028, 29089, 20392, 146, 47, 103, 142, 164, 166, 4, 8}, 100))], [])*/PROPERTYKEY(GUID("F23F425C-71A1-4FA8-922F-678EA4A60408"), 100),
    PKEY_IsDefaultNonOwnerSaveLocation = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4064232028, 29089, 20392, 146, 47, 103, 142, 164, 166, 4, 8}, 100))], [])*/PROPERTYKEY(GUID("5D76B67F-9B3D-44BB-B6AE-25DA4F638A67"), 5),
    PKEY_IsDefaultSaveLocation         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4064232028, 29089, 20392, 146, 47, 103, 142, 164, 166, 4, 8}, 100))], [])*/PROPERTYKEY(GUID("5D76B67F-9B3D-44BB-B6AE-25DA4F638A67"), 3),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1557815240, 13294, 20467, 144, 148, 174, 123, 216, 134, 140, 77}, 100))], [])*/PROPERTYKEY
{
    PKEY_IsDeleted         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1557815240, 13294, 20467, 144, 148, 174, 123, 216, 134, 140, 77}, 100))], [])*/PROPERTYKEY(GUID("5CDA5FC8-33EE-4FF3-9094-AE7BD8868C4D"), 100),
    PKEY_IsEncrypted       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1557815240, 13294, 20467, 144, 148, 174, 123, 216, 134, 140, 77}, 100))], [])*/PROPERTYKEY(GUID("90E5E14E-648B-4826-B2AA-ACAF790E3513"), 10),
    PKEY_IsFlagged         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1557815240, 13294, 20467, 144, 148, 174, 123, 216, 134, 140, 77}, 100))], [])*/PROPERTYKEY(GUID("5DA84765-E3FF-4278-86B0-A27967FBDD03"), 100),
    PKEY_IsFlaggedComplete = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1557815240, 13294, 20467, 144, 148, 174, 123, 216, 134, 140, 77}, 100))], [])*/PROPERTYKEY(GUID("A6F360D2-55F9-48DE-B909-620E090A647C"), 100),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({879528913, 11882, 19525, 137, 164, 97, 183, 142, 142, 112, 15}, 100))], [])*/PROPERTYKEY
{
    PKEY_IsIncomplete        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({879528913, 11882, 19525, 137, 164, 97, 183, 142, 142, 112, 15}, 100))], [])*/PROPERTYKEY(GUID("346C8BD1-2E6A-4C45-89A4-61B78E8E700F"), 100),
    PKEY_IsLocationSupported = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({879528913, 11882, 19525, 137, 164, 97, 183, 142, 142, 112, 15}, 100))], [])*/PROPERTYKEY(GUID("5D76B67F-9B3D-44BB-B6AE-25DA4F638A67"), 8),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1568061055, 39741, 17595, 182, 174, 37, 218, 79, 99, 138, 103}, 2))], [])*/PROPERTYKEY PKEY_IsPinnedToNameSpaceTree = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1568061055, 39741, 17595, 182, 174, 37, 218, 79, 99, 138, 103}, 2))], [])*/PROPERTYKEY(GUID("5D76B67F-9B3D-44BB-B6AE-25DA4F638A67"), 2);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3823130700, 46984, 19034, 187, 32, 127, 90, 68, 201, 172, 221}, 10))], [])*/PROPERTYKEY
{
    PKEY_IsRead                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3823130700, 46984, 19034, 187, 32, 127, 90, 68, 201, 172, 221}, 10))], [])*/PROPERTYKEY(GUID("E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD"), 10),
    PKEY_IsSearchOnlyItem            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3823130700, 46984, 19034, 187, 32, 127, 90, 68, 201, 172, 221}, 10))], [])*/PROPERTYKEY(GUID("5D76B67F-9B3D-44BB-B6AE-25DA4F638A67"), 4),
    PKEY_IsSendToTarget              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3823130700, 46984, 19034, 187, 32, 127, 90, 68, 201, 172, 221}, 10))], [])*/PROPERTYKEY(GUID("28636AA6-953D-11D2-B5D6-00C04FD918D0"), 33),
    PKEY_IsShared                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3823130700, 46984, 19034, 187, 32, 127, 90, 68, 201, 172, 221}, 10))], [])*/PROPERTYKEY(GUID("EF884C5B-2BFE-41BB-AAE5-76EEDF4F9902"), 100),
    PKEY_ItemAuthors                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3823130700, 46984, 19034, 187, 32, 127, 90, 68, 201, 172, 221}, 10))], [])*/PROPERTYKEY(GUID("D0A04F0A-462A-48A4-BB2F-3706E88DBD7D"), 100),
    PKEY_ItemClassType               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3823130700, 46984, 19034, 187, 32, 127, 90, 68, 201, 172, 221}, 10))], [])*/PROPERTYKEY(GUID("048658AD-2DB8-41A4-BBB6-AC1EF1207EB1"), 100),
    PKEY_ItemDate                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3823130700, 46984, 19034, 187, 32, 127, 90, 68, 201, 172, 221}, 10))], [])*/PROPERTYKEY(GUID("F7DB74B4-4287-4103-AFBA-F1B13DCD75CF"), 100),
    PKEY_ItemFolderNameDisplay       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3823130700, 46984, 19034, 187, 32, 127, 90, 68, 201, 172, 221}, 10))], [])*/PROPERTYKEY(GUID("B725F130-47EF-101A-A5F1-02608C9EEBAC"), 2),
    PKEY_ItemFolderPathDisplay       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3823130700, 46984, 19034, 187, 32, 127, 90, 68, 201, 172, 221}, 10))], [])*/PROPERTYKEY(GUID("E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD"), 6),
    PKEY_ItemFolderPathDisplayNarrow = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3823130700, 46984, 19034, 187, 32, 127, 90, 68, 201, 172, 221}, 10))], [])*/PROPERTYKEY(GUID("DABD30ED-0043-4789-A7F8-D013A4736622"), 100),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1804443764, 15196, 17340, 136, 111, 10, 44, 220, 224, 11, 111}, 100))], [])*/PROPERTYKEY
{
    PKEY_ItemName                        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1804443764, 15196, 17340, 136, 111, 10, 44, 220, 224, 11, 111}, 100))], [])*/PROPERTYKEY(GUID("6B8DA074-3B5C-43BC-886F-0A2CDCE00B6F"), 100),
    PKEY_ItemNameDisplay                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1804443764, 15196, 17340, 136, 111, 10, 44, 220, 224, 11, 111}, 100))], [])*/PROPERTYKEY(GUID("B725F130-47EF-101A-A5F1-02608C9EEBAC"), 10),
    PKEY_ItemNameDisplayWithoutExtension = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1804443764, 15196, 17340, 136, 111, 10, 44, 220, 224, 11, 111}, 100))], [])*/PROPERTYKEY(GUID("B725F130-47EF-101A-A5F1-02608C9EEBAC"), 24),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3610329073, 42874, 16412, 140, 153, 61, 189, 214, 138, 221, 54}, 100))], [])*/PROPERTYKEY
{
    PKEY_ItemNamePrefix       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3610329073, 42874, 16412, 140, 153, 61, 189, 214, 138, 221, 54}, 100))], [])*/PROPERTYKEY(GUID("D7313FF1-A77A-401C-8C99-3DBDD68ADD36"), 100),
    PKEY_ItemNameSortOverride = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3610329073, 42874, 16412, 140, 153, 61, 189, 214, 138, 221, 54}, 100))], [])*/PROPERTYKEY(GUID("B725F130-47EF-101A-A5F1-02608C9EEBAC"), 23),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3570444822, 39240, 16804, 170, 133, 217, 127, 249, 100, 105, 147}, 100))], [])*/PROPERTYKEY
{
    PKEY_ItemParticipants      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3570444822, 39240, 16804, 170, 133, 217, 127, 249, 100, 105, 147}, 100))], [])*/PROPERTYKEY(GUID("D4D0AA16-9948-41A4-AA85-D97FF9646993"), 100),
    PKEY_ItemPathDisplay       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3570444822, 39240, 16804, 170, 133, 217, 127, 249, 100, 105, 147}, 100))], [])*/PROPERTYKEY(GUID("E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD"), 7),
    PKEY_ItemPathDisplayNarrow = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3570444822, 39240, 16804, 170, 133, 217, 127, 249, 100, 105, 147}, 100))], [])*/PROPERTYKEY(GUID("28636AA6-953D-11D2-B5D6-00C04FD918D0"), 8),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({677604006, 38205, 4562, 181, 214, 0, 192, 79, 217, 24, 208}, 37))], [])*/PROPERTYKEY
{
    PKEY_ItemSubType  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({677604006, 38205, 4562, 181, 214, 0, 192, 79, 217, 24, 208}, 37))], [])*/PROPERTYKEY(GUID("28636AA6-953D-11D2-B5D6-00C04FD918D0"), 37),
    PKEY_ItemType     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({677604006, 38205, 4562, 181, 214, 0, 192, 79, 217, 24, 208}, 37))], [])*/PROPERTYKEY(GUID("28636AA6-953D-11D2-B5D6-00C04FD918D0"), 11),
    PKEY_ItemTypeText = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({677604006, 38205, 4562, 181, 214, 0, 192, 79, 217, 24, 208}, 37))], [])*/PROPERTYKEY(GUID("B725F130-47EF-101A-A5F1-02608C9EEBAC"), 4),
    PKEY_ItemUrl      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({677604006, 38205, 4562, 181, 214, 0, 192, 79, 217, 24, 208}, 37))], [])*/PROPERTYKEY(GUID("49691C90-7E17-101A-A91C-08002B2ECDA9"), 9),
    PKEY_Keywords     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({677604006, 38205, 4562, 181, 214, 0, 192, 79, 217, 24, 208}, 37))], [])*/PROPERTYKEY(GUID("F29F85E0-4FF9-1068-AB91-08002B27B3D9"), 5),
    PKEY_Kind         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({677604006, 38205, 4562, 181, 214, 0, 192, 79, 217, 24, 208}, 37))], [])*/PROPERTYKEY(GUID("1E3EE840-BC2B-476C-8237-2ACD1A839B22"), 3),
}

enum : const(wchar)*
{
    KIND_CALENDAR      = "calendar",
    KIND_COMMUNICATION = "communication",
}

enum : const(wchar)*
{
    KIND_CONTACT  = "contact",
    KIND_DOCUMENT = "document",
}

enum : const(wchar)*
{
    KIND_EMAIL          = "email",
    KIND_FEED           = "feed",
    KIND_FOLDER         = "folder",
    KIND_GAME           = "game",
    KIND_INSTANTMESSAGE = "instantmessage",
}

enum : const(wchar)*
{
    KIND_JOURNAL    = "journal",
    KIND_LINK       = "link",
    KIND_MOVIE      = "movie",
    KIND_MUSIC      = "music",
    KIND_NOTE       = "note",
    KIND_PICTURE    = "picture",
    KIND_PLAYLIST   = "playlist",
    KIND_PROGRAM    = "program",
    KIND_RECORDEDTV = "recordedtv",
}

enum const(wchar)* KIND_SEARCHFOLDER = "searchfolder";

enum : const(wchar)*
{
    KIND_TASK       = "task",
    KIND_VIDEO      = "video",
    KIND_WEBHISTORY = "webhistory",
}

enum const(wchar)* KIND_UNKNOWN = "unknown";
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4031508373, 50565, 16791, 162, 183, 223, 70, 253, 201, 238, 109}, 100))], [])*/PROPERTYKEY PKEY_KindText = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4031508373, 50565, 16791, 162, 183, 223, 70, 253, 201, 238, 109}, 100))], [])*/PROPERTYKEY(GUID("F04BEF95-C585-4197-A2B7-DF46FDC9EE6D"), 100);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 28))], [])*/PROPERTYKEY
{
    PKEY_Language                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 28))], [])*/PROPERTYKEY(GUID("D5CDD502-2E9C-101B-9397-08002B2CF9AE"), 28),
    PKEY_LastSyncError               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 28))], [])*/PROPERTYKEY(GUID("FCEFF153-E839-4CF3-A9E7-EA22832094B8"), 107),
    PKEY_LastSyncWarning             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 28))], [])*/PROPERTYKEY(GUID("FCEFF153-E839-4CF3-A9E7-EA22832094B8"), 128),
    PKEY_LastWriterPackageFamilyName = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 28))], [])*/PROPERTYKEY(GUID("502CFEAB-47EB-459C-B960-E6D8728F7701"), 101),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4070540768, 20473, 4200, 171, 145, 8, 0, 43, 39, 179, 217}, 25))], [])*/PROPERTYKEY PKEY_LowKeywords = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4070540768, 20473, 4200, 171, 145, 8, 0, 43, 39, 179, 217}, 25))], [])*/PROPERTYKEY(GUID("F29F85E0-4FF9-1068-AB91-08002B27B3D9"), 25);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4070540768, 20473, 4200, 171, 145, 8, 0, 43, 39, 179, 217}, 26))], [])*/PROPERTYKEY PKEY_MediumKeywords = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4070540768, 20473, 4200, 171, 145, 8, 0, 43, 39, 179, 217}, 26))], [])*/PROPERTYKEY(GUID("F29F85E0-4FF9-1068-AB91-08002B27B3D9"), 26);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4260905840, 794, 19165, 158, 145, 13, 119, 95, 28, 102, 5}, 100))], [])*/PROPERTYKEY PKEY_MileageInformation = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4260905840, 794, 19165, 158, 145, 13, 119, 95, 28, 102, 5}, 100))], [])*/PROPERTYKEY(GUID("FDF84370-031A-4ADD-9E91-0D775F1C6605"), 100);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({191095632, 40140, 4560, 188, 219, 0, 128, 95, 204, 206, 4}, 5))], [])*/PROPERTYKEY PKEY_MIMEType = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({191095632, 40140, 4560, 188, 219, 0, 128, 95, 204, 206, 4}, 5))], [])*/PROPERTYKEY(GUID("0B63E350-9CCC-11D0-BCDB-00805FCCCE04"), 5);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 0))], [])*/PROPERTYKEY
{
    PKEY_Null                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 0))], [])*/PROPERTYKEY(GUID("00000000-0000-0000-0000-000000000000"), 0),
    PKEY_OfflineAvailability = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 0))], [])*/PROPERTYKEY(GUID("A94688B6-7D9F-4570-A648-E3DFC0AB2B3F"), 100),
}

enum : uint
{
    OFFLINEAVAILABILITY_NOT_AVAILABLE    = 0x00000000U,
    OFFLINEAVAILABILITY_AVAILABLE        = 0x00000001U,
    OFFLINEAVAILABILITY_ALWAYS_AVAILABLE = 0x00000002U,
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1831110799, 18200, 19418, 175, 237, 234, 15, 180, 56, 108, 216}, 100))], [])*/PROPERTYKEY PKEY_OfflineStatus = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1831110799, 18200, 19418, 175, 237, 234, 15, 180, 56, 108, 216}, 100))], [])*/PROPERTYKEY(GUID("6D24888F-4718-4BDA-AFED-EA0FB4386CD8"), 100);

enum : uint
{
    OFFLINESTATUS_ONLINE                        = 0x00000000U,
    OFFLINESTATUS_OFFLINE                       = 0x00000001U,
    OFFLINESTATUS_OFFLINE_FORCED                = 0x00000002U,
    OFFLINESTATUS_OFFLINE_SLOW                  = 0x00000003U,
    OFFLINESTATUS_OFFLINE_ERROR                 = 0x00000004U,
    OFFLINESTATUS_OFFLINE_ITEM_VERSION_CONFLICT = 0x00000005U,
    OFFLINESTATUS_OFFLINE_SUSPENDED             = 0x00000006U,
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({217021779, 64100, 4561, 162, 3, 0, 0, 248, 31, 237, 238}, 6))], [])*/PROPERTYKEY PKEY_OriginalFileName = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({217021779, 64100, 4561, 162, 3, 0, 0, 248, 31, 237, 238}, 6))], [])*/PROPERTYKEY(GUID("0CEF7D53-FA64-11D1-A203-0000F81FEDEE"), 6);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1568061055, 39741, 17595, 182, 174, 37, 218, 79, 99, 138, 103}, 6))], [])*/PROPERTYKEY PKEY_OwnerSID = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1568061055, 39741, 17595, 182, 174, 37, 218, 79, 99, 138, 103}, 6))], [])*/PROPERTYKEY(GUID("5D76B67F-9B3D-44BB-B6AE-25DA4F638A67"), 6);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 21))], [])*/PROPERTYKEY
{
    PKEY_ParentalRating              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 21))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 21),
    PKEY_ParentalRatingReason        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 21))], [])*/PROPERTYKEY(GUID("10984E0A-F9F2-4321-B7EF-BAF195AF4319"), 100),
    PKEY_ParentalRatingsOrganization = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 21))], [])*/PROPERTYKEY(GUID("A7FE0840-1344-46F0-8D37-52ED712A4BF9"), 100),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3753484365, 13871, 19619, 179, 11, 2, 84, 177, 123, 91, 132}, 100))], [])*/PROPERTYKEY
{
    PKEY_ParsingBindContext = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3753484365, 13871, 19619, 179, 11, 2, 84, 177, 123, 91, 132}, 100))], [])*/PROPERTYKEY(GUID("DFB9A04D-362F-4CA3-B30B-0254B17B5B84"), 100),
    PKEY_ParsingName        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3753484365, 13871, 19619, 179, 11, 2, 84, 177, 123, 91, 132}, 100))], [])*/PROPERTYKEY(GUID("28636AA6-953D-11D2-B5D6-00C04FD918D0"), 24),
    PKEY_ParsingPath        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3753484365, 13871, 19619, 179, 11, 2, 84, 177, 123, 91, 132}, 100))], [])*/PROPERTYKEY(GUID("28636AA6-953D-11D2-B5D6-00C04FD918D0"), 30),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({677604006, 38205, 4562, 181, 214, 0, 192, 79, 217, 24, 208}, 9))], [])*/PROPERTYKEY
{
    PKEY_PerceivedType = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({677604006, 38205, 4562, 181, 214, 0, 192, 79, 217, 24, 208}, 9))], [])*/PROPERTYKEY(GUID("28636AA6-953D-11D2-B5D6-00C04FD918D0"), 9),
    PKEY_PercentFull   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({677604006, 38205, 4562, 181, 214, 0, 192, 79, 217, 24, 208}, 9))], [])*/PROPERTYKEY(GUID("9B174B35-40FF-11D2-A27E-00C04FC30871"), 5),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2619330420, 11671, 16826, 180, 174, 203, 46, 54, 97, 166, 228}, 5))], [])*/PROPERTYKEY
{
    PKEY_Priority       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2619330420, 11671, 16826, 180, 174, 203, 46, 54, 97, 166, 228}, 5))], [])*/PROPERTYKEY(GUID("9C1FCF74-2D97-41BA-B4AE-CB2E3661A6E4"), 5),
    PKEY_PriorityText   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2619330420, 11671, 16826, 180, 174, 203, 46, 54, 97, 166, 228}, 5))], [])*/PROPERTYKEY(GUID("D98BE98B-B86B-4095-BF52-9D23B2E0A752"), 100),
    PKEY_Project        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2619330420, 11671, 16826, 180, 174, 203, 46, 54, 97, 166, 228}, 5))], [])*/PROPERTYKEY(GUID("39A7F922-477C-48DE-8BC8-B28441E342E3"), 100),
    PKEY_ProviderItemID = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2619330420, 11671, 16826, 180, 174, 203, 46, 54, 97, 166, 228}, 5))], [])*/PROPERTYKEY(GUID("F21D9941-81F0-471A-ADEE-4E74B49217ED"), 100),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 9))], [])*/PROPERTYKEY PKEY_Rating = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 9))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 9);

enum : uint
{
    RATING_ONE_STAR_MIN = 0x00000001U,
    RATING_ONE_STAR_SET = 0x00000001U,
    RATING_ONE_STAR_MAX = 0x0000000cU,
}

enum : uint
{
    RATING_TWO_STARS_MIN = 0x0000000dU,
    RATING_TWO_STARS_SET = 0x00000019U,
    RATING_TWO_STARS_MAX = 0x00000025U,
}

enum : uint
{
    RATING_THREE_STARS_MIN = 0x00000026U,
    RATING_THREE_STARS_SET = 0x00000032U,
    RATING_THREE_STARS_MAX = 0x0000003eU,
}

enum : uint
{
    RATING_FOUR_STARS_MIN = 0x0000003fU,
    RATING_FOUR_STARS_SET = 0x0000004bU,
    RATING_FOUR_STARS_MAX = 0x00000057U,
}

enum : uint
{
    RATING_FIVE_STARS_MIN = 0x00000058U,
    RATING_FIVE_STARS_SET = 0x00000063U,
    RATING_FIVE_STARS_MAX = 0x00000063U,
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2417589415, 64911, 20108, 157, 163, 181, 126, 30, 96, 146, 149}, 100))], [])*/PROPERTYKEY PKEY_RatingText = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2417589415, 64911, 20108, 157, 163, 181, 126, 30, 96, 146, 149}, 100))], [])*/PROPERTYKEY(GUID("90197CA7-FD8F-4E8C-9DA3-B57E1E609295"), 100);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4243583315, 59449, 19699, 169, 231, 234, 34, 131, 32, 148, 184}, 115))], [])*/PROPERTYKEY PKEY_RemoteConflictingFile = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4243583315, 59449, 19699, 169, 231, 234, 34, 131, 32, 148, 184}, 115))], [])*/PROPERTYKEY(GUID("FCEFF153-E839-4CF3-A9E7-EA22832094B8"), 115);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({953430912, 54296, 18480, 132, 213, 70, 147, 90, 129, 197, 198}, 32))], [])*/PROPERTYKEY PKEY_Security_AllowedEnterpriseDataProtectionIdentities = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({953430912, 54296, 18480, 132, 213, 70, 147, 90, 129, 197, 198}, 32))], [])*/PROPERTYKEY(GUID("38D43380-D418-4830-84D5-46935A81C5C6"), 32);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1599799146, 14309, 18304, 151, 234, 128, 199, 86, 92, 245, 53}, 34))], [])*/PROPERTYKEY
{
    PKEY_Security_EncryptionOwners        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1599799146, 14309, 18304, 151, 234, 128, 199, 86, 92, 245, 53}, 34))], [])*/PROPERTYKEY(GUID("5F5AFF6A-37E5-4780-97EA-80C7565CF535"), 34),
    PKEY_Security_EncryptionOwnersDisplay = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1599799146, 14309, 18304, 151, 234, 128, 199, 86, 92, 245, 53}, 34))], [])*/PROPERTYKEY(GUID("DE621B8F-E125-43A3-A32D-5665446D632A"), 25),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4174640812, 18548, 17099, 190, 89, 171, 69, 75, 48, 113, 106}, 100))], [])*/PROPERTYKEY
{
    PKEY_Sensitivity     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4174640812, 18548, 17099, 190, 89, 171, 69, 75, 48, 113, 106}, 100))], [])*/PROPERTYKEY(GUID("F8D3F6AC-4874-42CB-BE59-AB454B30716A"), 100),
    PKEY_SensitivityText = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4174640812, 18548, 17099, 190, 89, 171, 69, 75, 48, 113, 106}, 100))], [])*/PROPERTYKEY(GUID("D0C7F054-3F72-4725-8527-129A577CB269"), 100),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({677604006, 38205, 4562, 181, 214, 0, 192, 79, 217, 24, 208}, 25))], [])*/PROPERTYKEY PKEY_SFGAOFlags = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({677604006, 38205, 4562, 181, 214, 0, 192, 79, 217, 24, 208}, 25))], [])*/PROPERTYKEY(GUID("28636AA6-953D-11D2-B5D6-00C04FD918D0"), 25);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4018687067, 11262, 16827, 170, 229, 118, 238, 223, 79, 153, 2}, 200))], [])*/PROPERTYKEY
{
    PKEY_SharedWith      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4018687067, 11262, 16827, 170, 229, 118, 238, 223, 79, 153, 2}, 200))], [])*/PROPERTYKEY(GUID("EF884C5B-2BFE-41BB-AAE5-76EEDF4F9902"), 200),
    PKEY_ShareUserRating = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4018687067, 11262, 16827, 170, 229, 118, 238, 223, 79, 153, 2}, 200))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 12),
    PKEY_SharingStatus   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4018687067, 11262, 16827, 170, 229, 118, 238, 223, 79, 153, 2}, 200))], [])*/PROPERTYKEY(GUID("EF884C5B-2BFE-41BB-AAE5-76EEDF4F9902"), 300),
}

enum : uint
{
    SHARINGSTATUS_NOTSHARED = 0x00000000U,
    SHARINGSTATUS_SHARED    = 0x00000001U,
    SHARINGSTATUS_PRIVATE   = 0x00000002U,
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3728024972, 50837, 19644, 185, 130, 56, 176, 173, 36, 206, 208}, 2))], [])*/PROPERTYKEY PKEY_Shell_OmitFromView = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3728024972, 50837, 19644, 185, 130, 56, 176, 173, 36, 206, 208}, 2))], [])*/PROPERTYKEY(GUID("DE35258C-C695-4CBC-B982-38B0AD24CED0"), 2);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2694776910, 44353, 18591, 128, 118, 170, 91, 227, 8, 43, 202}, 100))], [])*/PROPERTYKEY
{
    PKEY_SimpleRating            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2694776910, 44353, 18591, 128, 118, 170, 91, 227, 8, 43, 202}, 100))], [])*/PROPERTYKEY(GUID("A09F084E-AD41-489F-8076-AA5BE3082BCA"), 100),
    PKEY_Size                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2694776910, 44353, 18591, 128, 118, 170, 91, 227, 8, 43, 202}, 100))], [])*/PROPERTYKEY(GUID("B725F130-47EF-101A-A5F1-02608C9EEBAC"), 12),
    PKEY_SoftwareUsed            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2694776910, 44353, 18591, 128, 118, 170, 91, 227, 8, 43, 202}, 100))], [])*/PROPERTYKEY(GUID("14B81DA1-0135-4D31-96D9-6CBFC9671A99"), 305),
    PKEY_SourceItem              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2694776910, 44353, 18591, 128, 118, 170, 91, 227, 8, 43, 202}, 100))], [])*/PROPERTYKEY(GUID("668CDFA5-7A1B-4323-AE4B-E527393A1D81"), 100),
    PKEY_SourcePackageFamilyName = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2694776910, 44353, 18591, 128, 118, 170, 91, 227, 8, 43, 202}, 100))], [])*/PROPERTYKEY(GUID("FFAE9DB7-1C8D-43FF-818C-84403AA3732D"), 100),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1224568520, 35346, 19679, 160, 62, 78, 197, 165, 17, 237, 222}, 100))], [])*/PROPERTYKEY
{
    PKEY_StartDate                               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1224568520, 35346, 19679, 160, 62, 78, 197, 165, 17, 237, 222}, 100))], [])*/PROPERTYKEY(GUID("48FD6EC8-8A12-4CDF-A03E-4EC5A511EDDE"), 100),
    PKEY_Status                                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1224568520, 35346, 19679, 160, 62, 78, 197, 165, 17, 237, 222}, 100))], [])*/PROPERTYKEY(GUID("000214A1-0000-0000-C000-000000000046"), 9),
    PKEY_StorageProviderCallerVersionInformation = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1224568520, 35346, 19679, 160, 62, 78, 197, 165, 17, 237, 222}, 100))], [])*/PROPERTYKEY(GUID("B2F9B9D6-FEC4-4DD5-94D7-8957488C807B"), 7),
    PKEY_StorageProviderCustomPrimaryIcon        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1224568520, 35346, 19679, 160, 62, 78, 197, 165, 17, 237, 222}, 100))], [])*/PROPERTYKEY(GUID("B2F9B9D6-FEC4-4DD5-94D7-8957488C807B"), 12),
}

enum uint STORAGEPROVIDERCUSTOM_ICON_PHONE = 0x00000000U;

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4243583315, 59449, 19699, 169, 231, 234, 34, 131, 32, 148, 184}, 109))], [])*/PROPERTYKEY
{
    PKEY_StorageProviderError                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4243583315, 59449, 19699, 169, 231, 234, 34, 131, 32, 148, 184}, 109))], [])*/PROPERTYKEY(GUID("FCEFF153-E839-4CF3-A9E7-EA22832094B8"), 109),
    PKEY_StorageProviderFileChecksum         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4243583315, 59449, 19699, 169, 231, 234, 34, 131, 32, 148, 184}, 109))], [])*/PROPERTYKEY(GUID("B2F9B9D6-FEC4-4DD5-94D7-8957488C807B"), 5),
    PKEY_StorageProviderFileCreatedBy        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4243583315, 59449, 19699, 169, 231, 234, 34, 131, 32, 148, 184}, 109))], [])*/PROPERTYKEY(GUID("B2F9B9D6-FEC4-4DD5-94D7-8957488C807B"), 10),
    PKEY_StorageProviderFileDateShared       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4243583315, 59449, 19699, 169, 231, 234, 34, 131, 32, 148, 184}, 109))], [])*/PROPERTYKEY(GUID("B2F9B9D6-FEC4-4DD5-94D7-8957488C807B"), 14),
    PKEY_StorageProviderFileFlags            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4243583315, 59449, 19699, 169, 231, 234, 34, 131, 32, 148, 184}, 109))], [])*/PROPERTYKEY(GUID("B2F9B9D6-FEC4-4DD5-94D7-8957488C807B"), 8),
    PKEY_StorageProviderFileHasConflict      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4243583315, 59449, 19699, 169, 231, 234, 34, 131, 32, 148, 184}, 109))], [])*/PROPERTYKEY(GUID("B2F9B9D6-FEC4-4DD5-94D7-8957488C807B"), 9),
    PKEY_StorageProviderFileIdentifier       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4243583315, 59449, 19699, 169, 231, 234, 34, 131, 32, 148, 184}, 109))], [])*/PROPERTYKEY(GUID("B2F9B9D6-FEC4-4DD5-94D7-8957488C807B"), 3),
    PKEY_StorageProviderFileModifiedBy       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4243583315, 59449, 19699, 169, 231, 234, 34, 131, 32, 148, 184}, 109))], [])*/PROPERTYKEY(GUID("B2F9B9D6-FEC4-4DD5-94D7-8957488C807B"), 11),
    PKEY_StorageProviderFileRemoteLocation   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4243583315, 59449, 19699, 169, 231, 234, 34, 131, 32, 148, 184}, 109))], [])*/PROPERTYKEY(GUID("B2F9B9D6-FEC4-4DD5-94D7-8957488C807B"), 16),
    PKEY_StorageProviderFileRemoteUri        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4243583315, 59449, 19699, 169, 231, 234, 34, 131, 32, 148, 184}, 109))], [])*/PROPERTYKEY(GUID("FCEFF153-E839-4CF3-A9E7-EA22832094B8"), 112),
    PKEY_StorageProviderFileSharedBy         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4243583315, 59449, 19699, 169, 231, 234, 34, 131, 32, 148, 184}, 109))], [])*/PROPERTYKEY(GUID("B2F9B9D6-FEC4-4DD5-94D7-8957488C807B"), 15),
    PKEY_StorageProviderFileVersion          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4243583315, 59449, 19699, 169, 231, 234, 34, 131, 32, 148, 184}, 109))], [])*/PROPERTYKEY(GUID("B2F9B9D6-FEC4-4DD5-94D7-8957488C807B"), 4),
    PKEY_StorageProviderFileVersionWaterline = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4243583315, 59449, 19699, 169, 231, 234, 34, 131, 32, 148, 184}, 109))], [])*/PROPERTYKEY(GUID("B2F9B9D6-FEC4-4DD5-94D7-8957488C807B"), 6),
    PKEY_StorageProviderFullyQualifiedId     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4243583315, 59449, 19699, 169, 231, 234, 34, 131, 32, 148, 184}, 109))], [])*/PROPERTYKEY(GUID("FCEFF153-E839-4CF3-A9E7-EA22832094B8"), 119),
    PKEY_StorageProviderId                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4243583315, 59449, 19699, 169, 231, 234, 34, 131, 32, 148, 184}, 109))], [])*/PROPERTYKEY(GUID("FCEFF153-E839-4CF3-A9E7-EA22832094B8"), 108),
    PKEY_StorageProviderShareStatuses        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4243583315, 59449, 19699, 169, 231, 234, 34, 131, 32, 148, 184}, 109))], [])*/PROPERTYKEY(GUID("FCEFF153-E839-4CF3-A9E7-EA22832094B8"), 111),
}

enum : const(wchar)*
{
    STORAGE_PROVIDER_SHARE_STATUS_PRIVATE = "Private",
    STORAGE_PROVIDER_SHARE_STATUS_SHARED  = "Shared",
    STORAGE_PROVIDER_SHARE_STATUS_PUBLIC  = "Public",
    STORAGE_PROVIDER_SHARE_STATUS_GROUP   = "Group",
    STORAGE_PROVIDER_SHARE_STATUS_OWNER   = "Owner",
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4243583315, 59449, 19699, 169, 231, 234, 34, 131, 32, 148, 184}, 117))], [])*/PROPERTYKEY PKEY_StorageProviderSharingStatus = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4243583315, 59449, 19699, 169, 231, 234, 34, 131, 32, 148, 184}, 117))], [])*/PROPERTYKEY(GUID("FCEFF153-E839-4CF3-A9E7-EA22832094B8"), 117);

enum : uint
{
    STORAGE_PROVIDER_SHARINGSTATUS_NOTSHARED      = 0x00000000U,
    STORAGE_PROVIDER_SHARINGSTATUS_SHARED         = 0x00000001U,
    STORAGE_PROVIDER_SHARINGSTATUS_PRIVATE        = 0x00000002U,
    STORAGE_PROVIDER_SHARINGSTATUS_PUBLIC         = 0x00000003U,
    STORAGE_PROVIDER_SHARINGSTATUS_SHARED_OWNED   = 0x00000004U,
    STORAGE_PROVIDER_SHARINGSTATUS_SHARED_COOWNED = 0x00000005U,
    STORAGE_PROVIDER_SHARINGSTATUS_PUBLIC_OWNED   = 0x00000006U,
    STORAGE_PROVIDER_SHARINGSTATUS_PUBLIC_COOWNED = 0x00000007U,
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4243583315, 59449, 19699, 169, 231, 234, 34, 131, 32, 148, 184}, 110))], [])*/PROPERTYKEY
{
    PKEY_StorageProviderStatus          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4243583315, 59449, 19699, 169, 231, 234, 34, 131, 32, 148, 184}, 110))], [])*/PROPERTYKEY(GUID("FCEFF153-E839-4CF3-A9E7-EA22832094B8"), 110),
    PKEY_StorageProviderUserAccountKind = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4243583315, 59449, 19699, 169, 231, 234, 34, 131, 32, 148, 184}, 110))], [])*/PROPERTYKEY(GUID("B2F9B9D6-FEC4-4DD5-94D7-8957488C807B"), 17),
}

enum : uint
{
    STORAGEPROVIDERUSERACCOUNTKIND_UNKNOWN  = 0x00000000U,
    STORAGEPROVIDERUSERACCOUNTKIND_CONSUMER = 0x00000001U,
    STORAGEPROVIDERUSERACCOUNTKIND_BUSINESS = 0x00000002U,
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3002710486, 65220, 19925, 148, 215, 137, 87, 72, 140, 128, 123}, 13))], [])*/PROPERTYKEY PKEY_StorageProviderUserId = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3002710486, 65220, 19925, 148, 215, 137, 87, 72, 140, 128, 123}, 13))], [])*/PROPERTYKEY(GUID("B2F9B9D6-FEC4-4DD5-94D7-8957488C807B"), 13);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4070540768, 20473, 4200, 171, 145, 8, 0, 43, 39, 179, 217}, 3))], [])*/PROPERTYKEY
{
    PKEY_Subject            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4070540768, 20473, 4200, 171, 145, 8, 0, 43, 39, 179, 217}, 3))], [])*/PROPERTYKEY(GUID("F29F85E0-4FF9-1068-AB91-08002B27B3D9"), 3),
    PKEY_SyncTransferStatus = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4070540768, 20473, 4200, 171, 145, 8, 0, 43, 39, 179, 217}, 3))], [])*/PROPERTYKEY(GUID("FCEFF153-E839-4CF3-A9E7-EA22832094B8"), 103),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4070540768, 20473, 4200, 171, 145, 8, 0, 43, 39, 179, 217}, 17))], [])*/PROPERTYKEY
{
    PKEY_Thumbnail        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4070540768, 20473, 4200, 171, 145, 8, 0, 43, 39, 179, 217}, 17))], [])*/PROPERTYKEY(GUID("F29F85E0-4FF9-1068-AB91-08002B27B3D9"), 17),
    PKEY_ThumbnailCacheId = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4070540768, 20473, 4200, 171, 145, 8, 0, 43, 39, 179, 217}, 17))], [])*/PROPERTYKEY(GUID("446D16B1-8DAD-4870-A748-402EA43D788C"), 100),
    PKEY_ThumbnailStream  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4070540768, 20473, 4200, 171, 145, 8, 0, 43, 39, 179, 217}, 17))], [])*/PROPERTYKEY(GUID("F29F85E0-4FF9-1068-AB91-08002B27B3D9"), 27),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4070540768, 20473, 4200, 171, 145, 8, 0, 43, 39, 179, 217}, 2))], [])*/PROPERTYKEY
{
    PKEY_Title             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4070540768, 20473, 4200, 171, 145, 8, 0, 43, 39, 179, 217}, 2))], [])*/PROPERTYKEY(GUID("F29F85E0-4FF9-1068-AB91-08002B27B3D9"), 2),
    PKEY_TitleSortOverride = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4070540768, 20473, 4200, 171, 145, 8, 0, 43, 39, 179, 217}, 2))], [])*/PROPERTYKEY(GUID("F0F7984D-222E-4AD2-82AB-1DD8EA40E57E"), 300),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({677604006, 38205, 4562, 181, 214, 0, 192, 79, 217, 24, 208}, 14))], [])*/PROPERTYKEY PKEY_TotalFileSize = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({677604006, 38205, 4562, 181, 214, 0, 192, 79, 217, 24, 208}, 14))], [])*/PROPERTYKEY(GUID("28636AA6-953D-11D2-B5D6-00C04FD918D0"), 14);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({217021779, 64100, 4561, 162, 3, 0, 0, 248, 31, 237, 238}, 9))], [])*/PROPERTYKEY
{
    PKEY_Trademarks       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({217021779, 64100, 4561, 162, 3, 0, 0, 248, 31, 237, 238}, 9))], [])*/PROPERTYKEY(GUID("0CEF7D53-FA64-11D1-A203-0000F81FEDEE"), 9),
    PKEY_TransferOrder    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({217021779, 64100, 4561, 162, 3, 0, 0, 248, 31, 237, 238}, 9))], [])*/PROPERTYKEY(GUID("FCEFF153-E839-4CF3-A9E7-EA22832094B8"), 106),
    PKEY_TransferPosition = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({217021779, 64100, 4561, 162, 3, 0, 0, 248, 31, 237, 238}, 9))], [])*/PROPERTYKEY(GUID("FCEFF153-E839-4CF3-A9E7-EA22832094B8"), 104),
    PKEY_TransferSize     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({217021779, 64100, 4561, 162, 3, 0, 0, 248, 31, 237, 238}, 9))], [])*/PROPERTYKEY(GUID("FCEFF153-E839-4CF3-A9E7-EA22832094B8"), 105),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1147999921, 36269, 18544, 167, 72, 64, 46, 164, 61, 120, 140}, 104))], [])*/PROPERTYKEY PKEY_VolumeId = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1147999921, 36269, 18544, 167, 72, 64, 46, 164, 61, 120, 140}, 104))], [])*/PROPERTYKEY(GUID("446D16B1-8DAD-4870-A748-402EA43D788C"), 104);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1345126059, 18411, 17820, 185, 96, 230, 216, 114, 143, 119, 1}, 100))], [])*/PROPERTYKEY PKEY_ZoneIdentifier = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1345126059, 18411, 17820, 185, 96, 230, 216, 114, 143, 119, 1}, 100))], [])*/PROPERTYKEY(GUID("502CFEAB-47EB-459C-B960-E6D8728F7701"), 100);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY
{
    PKEY_Device_PrinterURL                             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("0B48F35A-BE6E-4F17-B108-3C4073D1669A"), 15),
    PKEY_DeviceInterface_Bluetooth_DeviceAddress       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("2BD67D8B-8BEB-48D5-87E0-6CDA3428040A"), 1),
    PKEY_DeviceInterface_Bluetooth_Flags               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("2BD67D8B-8BEB-48D5-87E0-6CDA3428040A"), 3),
    PKEY_DeviceInterface_Bluetooth_LastConnectedTime   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("2BD67D8B-8BEB-48D5-87E0-6CDA3428040A"), 11),
    PKEY_DeviceInterface_Bluetooth_Manufacturer        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("2BD67D8B-8BEB-48D5-87E0-6CDA3428040A"), 4),
    PKEY_DeviceInterface_Bluetooth_ModelNumber         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("2BD67D8B-8BEB-48D5-87E0-6CDA3428040A"), 5),
    PKEY_DeviceInterface_Bluetooth_ProductId           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("2BD67D8B-8BEB-48D5-87E0-6CDA3428040A"), 8),
    PKEY_DeviceInterface_Bluetooth_ProductVersion      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("2BD67D8B-8BEB-48D5-87E0-6CDA3428040A"), 9),
    PKEY_DeviceInterface_Bluetooth_ServiceGuid         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("2BD67D8B-8BEB-48D5-87E0-6CDA3428040A"), 2),
    PKEY_DeviceInterface_Bluetooth_VendorId            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("2BD67D8B-8BEB-48D5-87E0-6CDA3428040A"), 7),
    PKEY_DeviceInterface_Bluetooth_VendorIdSource      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("2BD67D8B-8BEB-48D5-87E0-6CDA3428040A"), 6),
    PKEY_DeviceInterface_Hid_IsReadOnly                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("CBF38310-4A17-4310-A1EB-247F0B67593B"), 4),
    PKEY_DeviceInterface_Hid_ProductId                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("CBF38310-4A17-4310-A1EB-247F0B67593B"), 6),
    PKEY_DeviceInterface_Hid_UsageId                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("CBF38310-4A17-4310-A1EB-247F0B67593B"), 3),
    PKEY_DeviceInterface_Hid_UsagePage                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("CBF38310-4A17-4310-A1EB-247F0B67593B"), 2),
    PKEY_DeviceInterface_Hid_VendorId                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("CBF38310-4A17-4310-A1EB-247F0B67593B"), 5),
    PKEY_DeviceInterface_Hid_VersionNumber             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("CBF38310-4A17-4310-A1EB-247F0B67593B"), 7),
    PKEY_DeviceInterface_PrinterDriverDirectory        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("847C66DE-B8D6-4AF9-ABC3-6F4F926BC039"), 14),
    PKEY_DeviceInterface_PrinterDriverName             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("AFC47170-14F5-498C-8F30-B0D19BE449C6"), 11),
    PKEY_DeviceInterface_PrinterEnumerationFlag        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("A00742A1-CD8C-4B37-95AB-70755587767A"), 3),
    PKEY_DeviceInterface_PrinterName                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("0A7B84EF-0C27-463F-84EF-06C5070001BE"), 10),
    PKEY_DeviceInterface_PrinterPortName               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("EEC7B761-6F94-41B1-949F-C729720DD13C"), 12),
    PKEY_DeviceInterface_Proximity_SupportsNfc         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("FB3842CD-9E2A-4F83-8FCC-4B0761139AE9"), 2),
    PKEY_DeviceInterface_Serial_PortName               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("4C6BF15C-4C03-4AAC-91F5-64C0F852BCF4"), 4),
    PKEY_DeviceInterface_Serial_UsbProductId           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("4C6BF15C-4C03-4AAC-91F5-64C0F852BCF4"), 3),
    PKEY_DeviceInterface_Serial_UsbVendorId            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("4C6BF15C-4C03-4AAC-91F5-64C0F852BCF4"), 2),
    PKEY_DeviceInterface_WinUsb_DeviceInterfaceClasses = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("95E127B5-79CC-4E83-9C9E-8422187B3E0E"), 7),
    PKEY_DeviceInterface_WinUsb_UsbClass               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("95E127B5-79CC-4E83-9C9E-8422187B3E0E"), 4),
    PKEY_DeviceInterface_WinUsb_UsbProductId           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("95E127B5-79CC-4E83-9C9E-8422187B3E0E"), 3),
    PKEY_DeviceInterface_WinUsb_UsbProtocol            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("95E127B5-79CC-4E83-9C9E-8422187B3E0E"), 6),
    PKEY_DeviceInterface_WinUsb_UsbSubClass            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("95E127B5-79CC-4E83-9C9E-8422187B3E0E"), 5),
    PKEY_DeviceInterface_WinUsb_UsbVendorId            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({189330266, 48750, 20247, 177, 8, 60, 64, 115, 209, 102, 154}, 15))], [])*/PROPERTYKEY(GUID("95E127B5-79CC-4E83-9C9E-8422187B3E0E"), 2),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 8))], [])*/PROPERTYKEY
{
    PKEY_Devices_Aep_AepId                                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 8))], [])*/PROPERTYKEY(GUID("3B2CE006-5E61-4FDE-BAB8-9B8AAC9B26DF"), 8),
    PKEY_Devices_Aep_Bluetooth_Cod_Major                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 8))], [])*/PROPERTYKEY(GUID("5FBD34CD-561A-412E-BA98-478A6B0FEF1D"), 2),
    PKEY_Devices_Aep_Bluetooth_Cod_Minor                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 8))], [])*/PROPERTYKEY(GUID("5FBD34CD-561A-412E-BA98-478A6B0FEF1D"), 3),
    PKEY_Devices_Aep_Bluetooth_Cod_Services_Audio            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 8))], [])*/PROPERTYKEY(GUID("5FBD34CD-561A-412E-BA98-478A6B0FEF1D"), 10),
    PKEY_Devices_Aep_Bluetooth_Cod_Services_Capturing        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 8))], [])*/PROPERTYKEY(GUID("5FBD34CD-561A-412E-BA98-478A6B0FEF1D"), 8),
    PKEY_Devices_Aep_Bluetooth_Cod_Services_Information      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 8))], [])*/PROPERTYKEY(GUID("5FBD34CD-561A-412E-BA98-478A6B0FEF1D"), 12),
    PKEY_Devices_Aep_Bluetooth_Cod_Services_LimitedDiscovery = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 8))], [])*/PROPERTYKEY(GUID("5FBD34CD-561A-412E-BA98-478A6B0FEF1D"), 4),
    PKEY_Devices_Aep_Bluetooth_Cod_Services_Networking       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 8))], [])*/PROPERTYKEY(GUID("5FBD34CD-561A-412E-BA98-478A6B0FEF1D"), 6),
    PKEY_Devices_Aep_Bluetooth_Cod_Services_ObjectXfer       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 8))], [])*/PROPERTYKEY(GUID("5FBD34CD-561A-412E-BA98-478A6B0FEF1D"), 9),
    PKEY_Devices_Aep_Bluetooth_Cod_Services_Positioning      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 8))], [])*/PROPERTYKEY(GUID("5FBD34CD-561A-412E-BA98-478A6B0FEF1D"), 5),
    PKEY_Devices_Aep_Bluetooth_Cod_Services_Rendering        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 8))], [])*/PROPERTYKEY(GUID("5FBD34CD-561A-412E-BA98-478A6B0FEF1D"), 7),
    PKEY_Devices_Aep_Bluetooth_Cod_Services_Telephony        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 8))], [])*/PROPERTYKEY(GUID("5FBD34CD-561A-412E-BA98-478A6B0FEF1D"), 11),
    PKEY_Devices_Aep_Bluetooth_LastSeenTime                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 8))], [])*/PROPERTYKEY(GUID("2BD67D8B-8BEB-48D5-87E0-6CDA3428040A"), 12),
    PKEY_Devices_Aep_Bluetooth_Le_AddressType                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 8))], [])*/PROPERTYKEY(GUID("995EF0B0-7EB3-4A8B-B9CE-068BB3F4AF69"), 4),
}

enum : uint
{
    BLUETOOTH_ADDRESS_TYPE_PUBLIC = 0x00000000U,
    BLUETOOTH_ADDRESS_TYPE_RANDOM = 0x00000001U,
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2573136048, 32435, 19083, 185, 206, 6, 139, 179, 244, 175, 105}, 1))], [])*/PROPERTYKEY
{
    PKEY_Devices_Aep_Bluetooth_Le_Appearance             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2573136048, 32435, 19083, 185, 206, 6, 139, 179, 244, 175, 105}, 1))], [])*/PROPERTYKEY(GUID("995EF0B0-7EB3-4A8B-B9CE-068BB3F4AF69"), 1),
    PKEY_Devices_Aep_Bluetooth_Le_Appearance_Category    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2573136048, 32435, 19083, 185, 206, 6, 139, 179, 244, 175, 105}, 1))], [])*/PROPERTYKEY(GUID("995EF0B0-7EB3-4A8B-B9CE-068BB3F4AF69"), 5),
    PKEY_Devices_Aep_Bluetooth_Le_Appearance_Subcategory = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2573136048, 32435, 19083, 185, 206, 6, 139, 179, 244, 175, 105}, 1))], [])*/PROPERTYKEY(GUID("995EF0B0-7EB3-4A8B-B9CE-068BB3F4AF69"), 6),
    PKEY_Devices_Aep_Bluetooth_Le_IsCallControlClient    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2573136048, 32435, 19083, 185, 206, 6, 139, 179, 244, 175, 105}, 1))], [])*/PROPERTYKEY(GUID("995EF0B0-7EB3-4A8B-B9CE-068BB3F4AF69"), 12),
    PKEY_Devices_Aep_Bluetooth_Le_IsConnectable          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2573136048, 32435, 19083, 185, 206, 6, 139, 179, 244, 175, 105}, 1))], [])*/PROPERTYKEY(GUID("995EF0B0-7EB3-4A8B-B9CE-068BB3F4AF69"), 8),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3888380713, 51879, 20295, 140, 139, 190, 89, 179, 48, 212, 197}, 3))], [])*/PROPERTYKEY
{
    PKEY_Devices_Aep_CanPair                        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3888380713, 51879, 20295, 140, 139, 190, 89, 179, 48, 212, 197}, 3))], [])*/PROPERTYKEY(GUID("E7C3FB29-CAA7-4F47-8C8B-BE59B330D4C5"), 3),
    PKEY_Devices_Aep_Category                       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3888380713, 51879, 20295, 140, 139, 190, 89, 179, 48, 212, 197}, 3))], [])*/PROPERTYKEY(GUID("A35996AB-11CF-4935-8B61-A6761081ECDF"), 17),
    PKEY_Devices_Aep_ContainerId                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3888380713, 51879, 20295, 140, 139, 190, 89, 179, 48, 212, 197}, 3))], [])*/PROPERTYKEY(GUID("E7C3FB29-CAA7-4F47-8C8B-BE59B330D4C5"), 2),
    PKEY_Devices_Aep_DeviceAddress                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3888380713, 51879, 20295, 140, 139, 190, 89, 179, 48, 212, 197}, 3))], [])*/PROPERTYKEY(GUID("A35996AB-11CF-4935-8B61-A6761081ECDF"), 12),
    PKEY_Devices_Aep_IsConnected                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3888380713, 51879, 20295, 140, 139, 190, 89, 179, 48, 212, 197}, 3))], [])*/PROPERTYKEY(GUID("A35996AB-11CF-4935-8B61-A6761081ECDF"), 7),
    PKEY_Devices_Aep_IsPaired                       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3888380713, 51879, 20295, 140, 139, 190, 89, 179, 48, 212, 197}, 3))], [])*/PROPERTYKEY(GUID("A35996AB-11CF-4935-8B61-A6761081ECDF"), 16),
    PKEY_Devices_Aep_IsPresent                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3888380713, 51879, 20295, 140, 139, 190, 89, 179, 48, 212, 197}, 3))], [])*/PROPERTYKEY(GUID("A35996AB-11CF-4935-8B61-A6761081ECDF"), 9),
    PKEY_Devices_Aep_Manufacturer                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3888380713, 51879, 20295, 140, 139, 190, 89, 179, 48, 212, 197}, 3))], [])*/PROPERTYKEY(GUID("A35996AB-11CF-4935-8B61-A6761081ECDF"), 5),
    PKEY_Devices_Aep_ModelId                        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3888380713, 51879, 20295, 140, 139, 190, 89, 179, 48, 212, 197}, 3))], [])*/PROPERTYKEY(GUID("A35996AB-11CF-4935-8B61-A6761081ECDF"), 4),
    PKEY_Devices_Aep_ModelName                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3888380713, 51879, 20295, 140, 139, 190, 89, 179, 48, 212, 197}, 3))], [])*/PROPERTYKEY(GUID("A35996AB-11CF-4935-8B61-A6761081ECDF"), 3),
    PKEY_Devices_Aep_PointOfService_ConnectionTypes = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3888380713, 51879, 20295, 140, 139, 190, 89, 179, 48, 212, 197}, 3))], [])*/PROPERTYKEY(GUID("D4BF61B3-442E-4ADA-882D-FA7B70C832D9"), 6),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 5))], [])*/PROPERTYKEY
{
    PKEY_Devices_Aep_ProtocolId                                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 5))], [])*/PROPERTYKEY(GUID("3B2CE006-5E61-4FDE-BAB8-9B8AAC9B26DF"), 5),
    PKEY_Devices_Aep_SignalStrength                              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 5))], [])*/PROPERTYKEY(GUID("A35996AB-11CF-4935-8B61-A6761081ECDF"), 6),
    PKEY_Devices_AepContainer_CanPair                            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 5))], [])*/PROPERTYKEY(GUID("0BBA1EDE-7566-4F47-90EC-25FC567CED2A"), 3),
    PKEY_Devices_AepContainer_Categories                         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 5))], [])*/PROPERTYKEY(GUID("0BBA1EDE-7566-4F47-90EC-25FC567CED2A"), 9),
    PKEY_Devices_AepContainer_Children                           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 5))], [])*/PROPERTYKEY(GUID("0BBA1EDE-7566-4F47-90EC-25FC567CED2A"), 2),
    PKEY_Devices_AepContainer_ContainerId                        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 5))], [])*/PROPERTYKEY(GUID("0BBA1EDE-7566-4F47-90EC-25FC567CED2A"), 12),
    PKEY_Devices_AepContainer_DialProtocol_InstalledApplications = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 5))], [])*/PROPERTYKEY(GUID("6AF55D45-38DB-4495-ACB0-D4728A3B8314"), 6),
    PKEY_Devices_AepContainer_IsPaired                           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 5))], [])*/PROPERTYKEY(GUID("0BBA1EDE-7566-4F47-90EC-25FC567CED2A"), 4),
    PKEY_Devices_AepContainer_IsPresent                          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 5))], [])*/PROPERTYKEY(GUID("0BBA1EDE-7566-4F47-90EC-25FC567CED2A"), 11),
    PKEY_Devices_AepContainer_Manufacturer                       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 5))], [])*/PROPERTYKEY(GUID("0BBA1EDE-7566-4F47-90EC-25FC567CED2A"), 6),
    PKEY_Devices_AepContainer_ModelIds                           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 5))], [])*/PROPERTYKEY(GUID("0BBA1EDE-7566-4F47-90EC-25FC567CED2A"), 8),
    PKEY_Devices_AepContainer_ModelName                          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 5))], [])*/PROPERTYKEY(GUID("0BBA1EDE-7566-4F47-90EC-25FC567CED2A"), 7),
    PKEY_Devices_AepContainer_ProtocolIds                        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 5))], [])*/PROPERTYKEY(GUID("0BBA1EDE-7566-4F47-90EC-25FC567CED2A"), 13),
    PKEY_Devices_AepContainer_SupportedUriSchemes                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 5))], [])*/PROPERTYKEY(GUID("6AF55D45-38DB-4495-ACB0-D4728A3B8314"), 5),
    PKEY_Devices_AepContainer_SupportsAudio                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 5))], [])*/PROPERTYKEY(GUID("6AF55D45-38DB-4495-ACB0-D4728A3B8314"), 2),
    PKEY_Devices_AepContainer_SupportsCapturing                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 5))], [])*/PROPERTYKEY(GUID("6AF55D45-38DB-4495-ACB0-D4728A3B8314"), 11),
    PKEY_Devices_AepContainer_SupportsImages                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 5))], [])*/PROPERTYKEY(GUID("6AF55D45-38DB-4495-ACB0-D4728A3B8314"), 4),
    PKEY_Devices_AepContainer_SupportsInformation                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 5))], [])*/PROPERTYKEY(GUID("6AF55D45-38DB-4495-ACB0-D4728A3B8314"), 14),
    PKEY_Devices_AepContainer_SupportsLimitedDiscovery           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 5))], [])*/PROPERTYKEY(GUID("6AF55D45-38DB-4495-ACB0-D4728A3B8314"), 7),
    PKEY_Devices_AepContainer_SupportsNetworking                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 5))], [])*/PROPERTYKEY(GUID("6AF55D45-38DB-4495-ACB0-D4728A3B8314"), 9),
    PKEY_Devices_AepContainer_SupportsObjectTransfer             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 5))], [])*/PROPERTYKEY(GUID("6AF55D45-38DB-4495-ACB0-D4728A3B8314"), 12),
    PKEY_Devices_AepContainer_SupportsPositioning                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 5))], [])*/PROPERTYKEY(GUID("6AF55D45-38DB-4495-ACB0-D4728A3B8314"), 8),
    PKEY_Devices_AepContainer_SupportsRendering                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 5))], [])*/PROPERTYKEY(GUID("6AF55D45-38DB-4495-ACB0-D4728A3B8314"), 10),
    PKEY_Devices_AepContainer_SupportsTelephony                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 5))], [])*/PROPERTYKEY(GUID("6AF55D45-38DB-4495-ACB0-D4728A3B8314"), 13),
    PKEY_Devices_AepContainer_SupportsVideo                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 5))], [])*/PROPERTYKEY(GUID("6AF55D45-38DB-4495-ACB0-D4728A3B8314"), 3),
    PKEY_Devices_AepService_AepId                                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 5))], [])*/PROPERTYKEY(GUID("C9C141A9-1B4C-4F17-A9D1-F298538CADB8"), 6),
    PKEY_Devices_AepService_Bluetooth_CacheMode                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({992796678, 24161, 20446, 186, 184, 155, 138, 172, 155, 38, 223}, 5))], [])*/PROPERTYKEY(GUID("9744311E-7951-4B2E-B6F0-ECB293CAC119"), 5),
}

enum : uint
{
    BLUETOOTH_CACHE_MODE_CACHED    = 0x00000000U,
    BLUETOOTH_CACHED_MODE_UNCACHED = 0x00000001U,
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2744756935, 49765, 18254, 176, 115, 255, 206, 87, 114, 23, 22}, 2))], [])*/PROPERTYKEY
{
    PKEY_Devices_AepService_Bluetooth_ServiceGuid              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2744756935, 49765, 18254, 176, 115, 255, 206, 87, 114, 23, 22}, 2))], [])*/PROPERTYKEY(GUID("A399AAC7-C265-474E-B073-FFCE57721716"), 2),
    PKEY_Devices_AepService_Bluetooth_TargetDevice             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2744756935, 49765, 18254, 176, 115, 255, 206, 87, 114, 23, 22}, 2))], [])*/PROPERTYKEY(GUID("9744311E-7951-4B2E-B6F0-ECB293CAC119"), 6),
    PKEY_Devices_AepService_ContainerId                        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2744756935, 49765, 18254, 176, 115, 255, 206, 87, 114, 23, 22}, 2))], [])*/PROPERTYKEY(GUID("71724756-3E74-4432-9B59-E7B2F668A593"), 4),
    PKEY_Devices_AepService_FriendlyName                       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2744756935, 49765, 18254, 176, 115, 255, 206, 87, 114, 23, 22}, 2))], [])*/PROPERTYKEY(GUID("71724756-3E74-4432-9B59-E7B2F668A593"), 2),
    PKEY_Devices_AepService_IoT_ServiceInterfaces              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2744756935, 49765, 18254, 176, 115, 255, 206, 87, 114, 23, 22}, 2))], [])*/PROPERTYKEY(GUID("79D94E82-4D79-45AA-821A-74858B4E4CA6"), 2),
    PKEY_Devices_AepService_ParentAepIsPaired                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2744756935, 49765, 18254, 176, 115, 255, 206, 87, 114, 23, 22}, 2))], [])*/PROPERTYKEY(GUID("C9C141A9-1B4C-4F17-A9D1-F298538CADB8"), 7),
    PKEY_Devices_AepService_ProtocolId                         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2744756935, 49765, 18254, 176, 115, 255, 206, 87, 114, 23, 22}, 2))], [])*/PROPERTYKEY(GUID("C9C141A9-1B4C-4F17-A9D1-F298538CADB8"), 5),
    PKEY_Devices_AepService_ServiceClassId                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2744756935, 49765, 18254, 176, 115, 255, 206, 87, 114, 23, 22}, 2))], [])*/PROPERTYKEY(GUID("71724756-3E74-4432-9B59-E7B2F668A593"), 3),
    PKEY_Devices_AepService_ServiceId                          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2744756935, 49765, 18254, 176, 115, 255, 206, 87, 114, 23, 22}, 2))], [])*/PROPERTYKEY(GUID("C9C141A9-1B4C-4F17-A9D1-F298538CADB8"), 2),
    PKEY_Devices_AppPackageFamilyName                          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2744756935, 49765, 18254, 176, 115, 255, 206, 87, 114, 23, 22}, 2))], [])*/PROPERTYKEY(GUID("51236583-0C4A-4FE8-B81F-166AEC13F510"), 100),
    PKEY_Devices_AudioDevice_Microphone_EqCoefficientsDb       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2744756935, 49765, 18254, 176, 115, 255, 206, 87, 114, 23, 22}, 2))], [])*/PROPERTYKEY(GUID("8943B373-388C-4395-B557-BC6DBAFFAFDB"), 7),
    PKEY_Devices_AudioDevice_Microphone_IsFarField             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2744756935, 49765, 18254, 176, 115, 255, 206, 87, 114, 23, 22}, 2))], [])*/PROPERTYKEY(GUID("8943B373-388C-4395-B557-BC6DBAFFAFDB"), 6),
    PKEY_Devices_AudioDevice_Microphone_SensitivityInDbfs      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2744756935, 49765, 18254, 176, 115, 255, 206, 87, 114, 23, 22}, 2))], [])*/PROPERTYKEY(GUID("8943B373-388C-4395-B557-BC6DBAFFAFDB"), 3),
    PKEY_Devices_AudioDevice_Microphone_SensitivityInDbfs2     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2744756935, 49765, 18254, 176, 115, 255, 206, 87, 114, 23, 22}, 2))], [])*/PROPERTYKEY(GUID("8943B373-388C-4395-B557-BC6DBAFFAFDB"), 5),
    PKEY_Devices_AudioDevice_Microphone_SignalToNoiseRatioInDb = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2744756935, 49765, 18254, 176, 115, 255, 206, 87, 114, 23, 22}, 2))], [])*/PROPERTYKEY(GUID("8943B373-388C-4395-B557-BC6DBAFFAFDB"), 4),
    PKEY_Devices_AudioDevice_RawProcessingSupported            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2744756935, 49765, 18254, 176, 115, 255, 206, 87, 114, 23, 22}, 2))], [])*/PROPERTYKEY(GUID("8943B373-388C-4395-B557-BC6DBAFFAFDB"), 2),
    PKEY_Devices_AudioDevice_SpeechProcessingSupported         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2744756935, 49765, 18254, 176, 115, 255, 206, 87, 114, 23, 22}, 2))], [])*/PROPERTYKEY(GUID("FB1DE864-E06D-47F4-82A6-8A0AEF44493C"), 2),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1238179702, 22054, 19223, 164, 232, 24, 180, 170, 26, 34, 19}, 10))], [])*/PROPERTYKEY
{
    PKEY_Devices_BatteryLife             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1238179702, 22054, 19223, 164, 232, 24, 180, 170, 26, 34, 19}, 10))], [])*/PROPERTYKEY(GUID("49CD1F76-5626-4B17-A4E8-18B4AA1A2213"), 10),
    PKEY_Devices_BatteryPlusCharging     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1238179702, 22054, 19223, 164, 232, 24, 180, 170, 26, 34, 19}, 10))], [])*/PROPERTYKEY(GUID("49CD1F76-5626-4B17-A4E8-18B4AA1A2213"), 22),
    PKEY_Devices_BatteryPlusChargingText = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1238179702, 22054, 19223, 164, 232, 24, 180, 170, 26, 34, 19}, 10))], [])*/PROPERTYKEY(GUID("49CD1F76-5626-4B17-A4E8-18B4AA1A2213"), 23),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 91))], [])*/PROPERTYKEY
{
    PKEY_Devices_Category                           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 91))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 91),
    PKEY_Devices_CategoryGroup                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 91))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 94),
    PKEY_Devices_CategoryIds                        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 91))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 90),
    PKEY_Devices_CategoryPlural                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 91))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 92),
    PKEY_Devices_ChallengeAep                       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 91))], [])*/PROPERTYKEY(GUID("0774315E-B714-48EC-8DE8-8125C077AC11"), 2),
    PKEY_Devices_ChargingState                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 91))], [])*/PROPERTYKEY(GUID("49CD1F76-5626-4B17-A4E8-18B4AA1A2213"), 11),
    PKEY_Devices_Children                           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 91))], [])*/PROPERTYKEY(GUID("4340A6C5-93FA-4706-972C-7B648008A5A7"), 9),
    PKEY_Devices_ClassGuid                          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 91))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 10),
    PKEY_Devices_CompatibleIds                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 91))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 4),
    PKEY_Devices_Connected                          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 91))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 55),
    PKEY_Devices_ContainerId                        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 91))], [])*/PROPERTYKEY(GUID("8C7ED206-3F8A-4827-B3AB-AE9E1FAEFC6C"), 2),
    PKEY_Devices_DefaultTooltip                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 91))], [])*/PROPERTYKEY(GUID("880F70A2-6082-47AC-8AAB-A739D1A300C3"), 153),
    PKEY_Devices_DeviceCapabilities                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 91))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 17),
    PKEY_Devices_DeviceCharacteristics              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 91))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 29),
    PKEY_Devices_DeviceDescription1                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 91))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 81),
    PKEY_Devices_DeviceDescription2                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 91))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 82),
    PKEY_Devices_DeviceHasProblem                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 91))], [])*/PROPERTYKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 6),
    PKEY_Devices_DeviceInstanceId                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 91))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 256),
    PKEY_Devices_DeviceManufacturer                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 91))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 13),
    PKEY_Devices_DevObjectType                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 91))], [])*/PROPERTYKEY(GUID("13673F42-A3D6-49F6-B4DA-AE46E0C5237C"), 2),
    PKEY_Devices_DialProtocol_InstalledApplications = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 91))], [])*/PROPERTYKEY(GUID("6845CC72-1B71-48C3-AF86-B09171A19B14"), 3),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 52))], [])*/PROPERTYKEY
{
    PKEY_Devices_DiscoveryMethod         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 52))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 52),
    PKEY_Devices_Dnssd_Domain            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 52))], [])*/PROPERTYKEY(GUID("BF79C0AB-BB74-4CEE-B070-470B5AE202EA"), 3),
    PKEY_Devices_Dnssd_FullName          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 52))], [])*/PROPERTYKEY(GUID("BF79C0AB-BB74-4CEE-B070-470B5AE202EA"), 5),
    PKEY_Devices_Dnssd_HostName          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 52))], [])*/PROPERTYKEY(GUID("BF79C0AB-BB74-4CEE-B070-470B5AE202EA"), 7),
    PKEY_Devices_Dnssd_InstanceName      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 52))], [])*/PROPERTYKEY(GUID("BF79C0AB-BB74-4CEE-B070-470B5AE202EA"), 4),
    PKEY_Devices_Dnssd_NetworkAdapterId  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 52))], [])*/PROPERTYKEY(GUID("BF79C0AB-BB74-4CEE-B070-470B5AE202EA"), 11),
    PKEY_Devices_Dnssd_PortNumber        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 52))], [])*/PROPERTYKEY(GUID("BF79C0AB-BB74-4CEE-B070-470B5AE202EA"), 12),
    PKEY_Devices_Dnssd_Priority          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 52))], [])*/PROPERTYKEY(GUID("BF79C0AB-BB74-4CEE-B070-470B5AE202EA"), 9),
    PKEY_Devices_Dnssd_ServiceName       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 52))], [])*/PROPERTYKEY(GUID("BF79C0AB-BB74-4CEE-B070-470B5AE202EA"), 2),
    PKEY_Devices_Dnssd_TextAttributes    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 52))], [])*/PROPERTYKEY(GUID("BF79C0AB-BB74-4CEE-B070-470B5AE202EA"), 6),
    PKEY_Devices_Dnssd_Ttl               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 52))], [])*/PROPERTYKEY(GUID("BF79C0AB-BB74-4CEE-B070-470B5AE202EA"), 10),
    PKEY_Devices_Dnssd_Weight            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 52))], [])*/PROPERTYKEY(GUID("BF79C0AB-BB74-4CEE-B070-470B5AE202EA"), 8),
    PKEY_Devices_FriendlyName            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 52))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 12288),
    PKEY_Devices_FunctionPaths           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 52))], [])*/PROPERTYKEY(GUID("D08DD4C0-3A9E-462E-8290-7B636B2576B9"), 3),
    PKEY_Devices_GlyphIcon               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 52))], [])*/PROPERTYKEY(GUID("51236583-0C4A-4FE8-B81F-166AEC13F510"), 123),
    PKEY_Devices_HardwareIds             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 52))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 3),
    PKEY_Devices_Icon                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 52))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 57),
    PKEY_Devices_InLocalMachineContainer = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 52))], [])*/PROPERTYKEY(GUID("8C7ED206-3F8A-4827-B3AB-AE9E1FAEFC6C"), 4),
    PKEY_Devices_InterfaceClassGuid      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 52))], [])*/PROPERTYKEY(GUID("026E516E-B814-414B-83CD-856D6FEF4822"), 4),
    PKEY_Devices_InterfaceEnabled        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 52))], [])*/PROPERTYKEY(GUID("026E516E-B814-414B-83CD-856D6FEF4822"), 3),
    PKEY_Devices_InterfacePaths          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 52))], [])*/PROPERTYKEY(GUID("D08DD4C0-3A9E-462E-8290-7B636B2576B9"), 2),
    PKEY_Devices_IpAddress               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 52))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 12297),
    PKEY_Devices_IsDefault               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 52))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 86),
    PKEY_Devices_IsNetworkConnected      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 52))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 85),
    PKEY_Devices_IsShared                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 52))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 84),
    PKEY_Devices_IsSoftwareInstalling    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 52))], [])*/PROPERTYKEY(GUID("83DA6326-97A6-4088-9453-A1923F573B29"), 9),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 77))], [])*/PROPERTYKEY PKEY_Devices_LaunchDeviceStageFromExplorer = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 77))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 77);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 70))], [])*/PROPERTYKEY
{
    PKEY_Devices_LocalMachine                       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 70))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 70),
    PKEY_Devices_LocationPaths                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 70))], [])*/PROPERTYKEY(GUID("A45C254E-DF1C-4EFD-8020-67D146A850E0"), 37),
    PKEY_Devices_Manufacturer                       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 70))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 8192),
    PKEY_Devices_MetadataPath                       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 70))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 71),
    PKEY_Devices_MicrophoneArray_Geometry           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 70))], [])*/PROPERTYKEY(GUID("A1829EA2-27EB-459E-935D-B2FAD7B07762"), 2),
    PKEY_Devices_MissedCalls                        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 70))], [])*/PROPERTYKEY(GUID("49CD1F76-5626-4B17-A4E8-18B4AA1A2213"), 5),
    PKEY_Devices_ModelId                            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 70))], [])*/PROPERTYKEY(GUID("80D81EA6-7473-4B0C-8216-EFC11A2C4C8B"), 2),
    PKEY_Devices_ModelName                          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 70))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 8194),
    PKEY_Devices_ModelNumber                        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 70))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 8195),
    PKEY_Devices_NetworkedTooltip                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 70))], [])*/PROPERTYKEY(GUID("880F70A2-6082-47AC-8AAB-A739D1A300C3"), 152),
    PKEY_Devices_NetworkName                        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 70))], [])*/PROPERTYKEY(GUID("49CD1F76-5626-4B17-A4E8-18B4AA1A2213"), 7),
    PKEY_Devices_NetworkType                        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 70))], [])*/PROPERTYKEY(GUID("49CD1F76-5626-4B17-A4E8-18B4AA1A2213"), 8),
    PKEY_Devices_NewPictures                        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 70))], [])*/PROPERTYKEY(GUID("49CD1F76-5626-4B17-A4E8-18B4AA1A2213"), 4),
    PKEY_Devices_Notification                       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 70))], [])*/PROPERTYKEY(GUID("06704B0C-E830-4C81-9178-91E4E95A80A0"), 3),
    PKEY_Devices_Notifications_LowBattery           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 70))], [])*/PROPERTYKEY(GUID("C4C07F2B-8524-4E66-AE3A-A6235F103BEB"), 2),
    PKEY_Devices_Notifications_MissedCall           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 70))], [])*/PROPERTYKEY(GUID("6614EF48-4EFE-4424-9EDA-C79F404EDF3E"), 2),
    PKEY_Devices_Notifications_NewMessage           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 70))], [])*/PROPERTYKEY(GUID("2BE9260A-2012-4742-A555-F41B638B7DCB"), 2),
    PKEY_Devices_Notifications_NewVoicemail         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 70))], [])*/PROPERTYKEY(GUID("59569556-0A08-4212-95B9-FAE2AD6413DB"), 2),
    PKEY_Devices_Notifications_StorageFull          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 70))], [])*/PROPERTYKEY(GUID("A0E00EE1-F0C7-4D41-B8E7-26A7BD8D38B0"), 2),
    PKEY_Devices_Notifications_StorageFullLinkText  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 70))], [])*/PROPERTYKEY(GUID("A0E00EE1-F0C7-4D41-B8E7-26A7BD8D38B0"), 3),
    PKEY_Devices_NotificationStore                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 70))], [])*/PROPERTYKEY(GUID("06704B0C-E830-4C81-9178-91E4E95A80A0"), 2),
    PKEY_Devices_NotWorkingProperly                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 70))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 83),
    PKEY_Devices_Paired                             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 70))], [])*/PROPERTYKEY(GUID("78C34FC8-104A-4ACA-9EA4-524D52996E57"), 56),
    PKEY_Devices_Panel_PanelGroup                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 70))], [])*/PROPERTYKEY(GUID("8DBC9C86-97A9-4BFF-9BC6-BFE95D3E6DAD"), 3),
    PKEY_Devices_Panel_PanelId                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 70))], [])*/PROPERTYKEY(GUID("8DBC9C86-97A9-4BFF-9BC6-BFE95D3E6DAD"), 2),
    PKEY_Devices_Parent                             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 70))], [])*/PROPERTYKEY(GUID("4340A6C5-93FA-4706-972C-7B648008A5A7"), 8),
    PKEY_Devices_PhoneLineTransportDevice_Connected = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2026065864, 4170, 19146, 158, 164, 82, 77, 82, 153, 110, 87}, 70))], [])*/PROPERTYKEY(GUID("AECF2FE8-1D00-4FEE-8A6D-A70D719B772B"), 2),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 9))], [])*/PROPERTYKEY PKEY_Devices_PhysicalDeviceLocation = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1410045054, 35648, 17852, 168, 162, 106, 11, 137, 76, 189, 162}, 9))], [])*/PROPERTYKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 9);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({909368921, 26661, 17281, 164, 155, 159, 107, 161, 58, 20, 113}, 5))], [])*/PROPERTYKEY
{
    PKEY_Devices_PlaybackPositionPercent = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({909368921, 26661, 17281, 164, 155, 159, 107, 161, 58, 20, 113}, 5))], [])*/PROPERTYKEY(GUID("3633DE59-6825-4381-A49B-9F6BA13A1471"), 5),
    PKEY_Devices_PlaybackState           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({909368921, 26661, 17281, 164, 155, 159, 107, 161, 58, 20, 113}, 5))], [])*/PROPERTYKEY(GUID("3633DE59-6825-4381-A49B-9F6BA13A1471"), 2),
}

enum : uint
{
    PLAYBACKSTATE_UNKNOWN         = 0x00000000U,
    PLAYBACKSTATE_STOPPED         = 0x00000001U,
    PLAYBACKSTATE_PLAYING         = 0x00000002U,
    PLAYBACKSTATE_TRANSITIONING   = 0x00000003U,
    PLAYBACKSTATE_PAUSED          = 0x00000004U,
    PLAYBACKSTATE_RECORDINGPAUSED = 0x00000005U,
    PLAYBACKSTATE_RECORDING       = 0x00000006U,
    PLAYBACKSTATE_NOMEDIA         = 0x00000007U,
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({909368921, 26661, 17281, 164, 155, 159, 107, 161, 58, 20, 113}, 3))], [])*/PROPERTYKEY
{
    PKEY_Devices_PlaybackTitle           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({909368921, 26661, 17281, 164, 155, 159, 107, 161, 58, 20, 113}, 3))], [])*/PROPERTYKEY(GUID("3633DE59-6825-4381-A49B-9F6BA13A1471"), 3),
    PKEY_Devices_Present                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({909368921, 26661, 17281, 164, 155, 159, 107, 161, 58, 20, 113}, 3))], [])*/PROPERTYKEY(GUID("540B947E-8B40-45BC-A8A2-6A0B894CBDA2"), 5),
    PKEY_Devices_PresentationUrl         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({909368921, 26661, 17281, 164, 155, 159, 107, 161, 58, 20, 113}, 3))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 8198),
    PKEY_Devices_PrimaryCategory         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({909368921, 26661, 17281, 164, 155, 159, 107, 161, 58, 20, 113}, 3))], [])*/PROPERTYKEY(GUID("D08DD4C0-3A9E-462E-8290-7B636B2576B9"), 10),
    PKEY_Devices_RemainingDuration       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({909368921, 26661, 17281, 164, 155, 159, 107, 161, 58, 20, 113}, 3))], [])*/PROPERTYKEY(GUID("3633DE59-6825-4381-A49B-9F6BA13A1471"), 4),
    PKEY_Devices_RestrictedInterface     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({909368921, 26661, 17281, 164, 155, 159, 107, 161, 58, 20, 113}, 3))], [])*/PROPERTYKEY(GUID("026E516E-B814-414B-83CD-856D6FEF4822"), 6),
    PKEY_Devices_Roaming                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({909368921, 26661, 17281, 164, 155, 159, 107, 161, 58, 20, 113}, 3))], [])*/PROPERTYKEY(GUID("49CD1F76-5626-4B17-A4E8-18B4AA1A2213"), 9),
    PKEY_Devices_SafeRemovalRequired     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({909368921, 26661, 17281, 164, 155, 159, 107, 161, 58, 20, 113}, 3))], [])*/PROPERTYKEY(GUID("AFD97640-86A3-4210-B67C-289C41AABE55"), 2),
    PKEY_Devices_SchematicName           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({909368921, 26661, 17281, 164, 155, 159, 107, 161, 58, 20, 113}, 3))], [])*/PROPERTYKEY(GUID("026E516E-B814-414B-83CD-856D6FEF4822"), 9),
    PKEY_Devices_ServiceAddress          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({909368921, 26661, 17281, 164, 155, 159, 107, 161, 58, 20, 113}, 3))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 16384),
    PKEY_Devices_ServiceId               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({909368921, 26661, 17281, 164, 155, 159, 107, 161, 58, 20, 113}, 3))], [])*/PROPERTYKEY(GUID("656A3BB3-ECC0-43FD-8477-4AE0404A96CD"), 16385),
    PKEY_Devices_SharedTooltip           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({909368921, 26661, 17281, 164, 155, 159, 107, 161, 58, 20, 113}, 3))], [])*/PROPERTYKEY(GUID("880F70A2-6082-47AC-8AAB-A739D1A300C3"), 151),
    PKEY_Devices_SignalStrength          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({909368921, 26661, 17281, 164, 155, 159, 107, 161, 58, 20, 113}, 3))], [])*/PROPERTYKEY(GUID("49CD1F76-5626-4B17-A4E8-18B4AA1A2213"), 2),
    PKEY_Devices_SmartCards_ReaderKind   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({909368921, 26661, 17281, 164, 155, 159, 107, 161, 58, 20, 113}, 3))], [])*/PROPERTYKEY(GUID("D6B5B883-18BD-4B4D-B2EC-9E38AFFEDA82"), 2),
    PKEY_Devices_Status                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({909368921, 26661, 17281, 164, 155, 159, 107, 161, 58, 20, 113}, 3))], [])*/PROPERTYKEY(GUID("D08DD4C0-3A9E-462E-8290-7B636B2576B9"), 259),
    PKEY_Devices_Status1                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({909368921, 26661, 17281, 164, 155, 159, 107, 161, 58, 20, 113}, 3))], [])*/PROPERTYKEY(GUID("D08DD4C0-3A9E-462E-8290-7B636B2576B9"), 257),
    PKEY_Devices_Status2                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({909368921, 26661, 17281, 164, 155, 159, 107, 161, 58, 20, 113}, 3))], [])*/PROPERTYKEY(GUID("D08DD4C0-3A9E-462E-8290-7B636B2576B9"), 258),
    PKEY_Devices_StorageCapacity         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({909368921, 26661, 17281, 164, 155, 159, 107, 161, 58, 20, 113}, 3))], [])*/PROPERTYKEY(GUID("49CD1F76-5626-4B17-A4E8-18B4AA1A2213"), 12),
    PKEY_Devices_StorageFreeSpace        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({909368921, 26661, 17281, 164, 155, 159, 107, 161, 58, 20, 113}, 3))], [])*/PROPERTYKEY(GUID("49CD1F76-5626-4B17-A4E8-18B4AA1A2213"), 13),
    PKEY_Devices_StorageFreeSpacePercent = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({909368921, 26661, 17281, 164, 155, 159, 107, 161, 58, 20, 113}, 3))], [])*/PROPERTYKEY(GUID("49CD1F76-5626-4B17-A4E8-18B4AA1A2213"), 14),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1238179702, 22054, 19223, 164, 232, 24, 180, 170, 26, 34, 19}, 3))], [])*/PROPERTYKEY
{
    PKEY_Devices_TextMessages                                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1238179702, 22054, 19223, 164, 232, 24, 180, 170, 26, 34, 19}, 3))], [])*/PROPERTYKEY(GUID("49CD1F76-5626-4B17-A4E8-18B4AA1A2213"), 3),
    PKEY_Devices_Voicemail                                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1238179702, 22054, 19223, 164, 232, 24, 180, 170, 26, 34, 19}, 3))], [])*/PROPERTYKEY(GUID("49CD1F76-5626-4B17-A4E8-18B4AA1A2213"), 6),
    PKEY_Devices_WiaDeviceType                                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1238179702, 22054, 19223, 164, 232, 24, 180, 170, 26, 34, 19}, 3))], [])*/PROPERTYKEY(GUID("6BDD1FC6-810F-11D0-BEC7-08002BE2092F"), 2),
    PKEY_Devices_WiFi_InterfaceGuid                           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1238179702, 22054, 19223, 164, 232, 24, 180, 170, 26, 34, 19}, 3))], [])*/PROPERTYKEY(GUID("EF1167EB-CBFC-4341-A568-A7C91A68982C"), 2),
    PKEY_Devices_WiFiDirect_DeviceAddress                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1238179702, 22054, 19223, 164, 232, 24, 180, 170, 26, 34, 19}, 3))], [])*/PROPERTYKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 13),
    PKEY_Devices_WiFiDirect_GroupId                           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1238179702, 22054, 19223, 164, 232, 24, 180, 170, 26, 34, 19}, 3))], [])*/PROPERTYKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 4),
    PKEY_Devices_WiFiDirect_InformationElements               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1238179702, 22054, 19223, 164, 232, 24, 180, 170, 26, 34, 19}, 3))], [])*/PROPERTYKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 12),
    PKEY_Devices_WiFiDirect_InterfaceAddress                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1238179702, 22054, 19223, 164, 232, 24, 180, 170, 26, 34, 19}, 3))], [])*/PROPERTYKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 2),
    PKEY_Devices_WiFiDirect_InterfaceGuid                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1238179702, 22054, 19223, 164, 232, 24, 180, 170, 26, 34, 19}, 3))], [])*/PROPERTYKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 3),
    PKEY_Devices_WiFiDirect_IsConnected                       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1238179702, 22054, 19223, 164, 232, 24, 180, 170, 26, 34, 19}, 3))], [])*/PROPERTYKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 5),
    PKEY_Devices_WiFiDirect_IsLegacyDevice                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1238179702, 22054, 19223, 164, 232, 24, 180, 170, 26, 34, 19}, 3))], [])*/PROPERTYKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 7),
    PKEY_Devices_WiFiDirect_IsMiracastLcpSupported            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1238179702, 22054, 19223, 164, 232, 24, 180, 170, 26, 34, 19}, 3))], [])*/PROPERTYKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 9),
    PKEY_Devices_WiFiDirect_IsVisible                         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1238179702, 22054, 19223, 164, 232, 24, 180, 170, 26, 34, 19}, 3))], [])*/PROPERTYKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 6),
    PKEY_Devices_WiFiDirect_MiracastVersion                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1238179702, 22054, 19223, 164, 232, 24, 180, 170, 26, 34, 19}, 3))], [])*/PROPERTYKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 8),
    PKEY_Devices_WiFiDirect_Services                          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1238179702, 22054, 19223, 164, 232, 24, 180, 170, 26, 34, 19}, 3))], [])*/PROPERTYKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 10),
    PKEY_Devices_WiFiDirect_SupportedChannelList              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1238179702, 22054, 19223, 164, 232, 24, 180, 170, 26, 34, 19}, 3))], [])*/PROPERTYKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 11),
    PKEY_Devices_WiFiDirectServices_AdvertisementId           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1238179702, 22054, 19223, 164, 232, 24, 180, 170, 26, 34, 19}, 3))], [])*/PROPERTYKEY(GUID("31B37743-7C5E-4005-93E6-E953F92B82E9"), 5),
    PKEY_Devices_WiFiDirectServices_RequestServiceInformation = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1238179702, 22054, 19223, 164, 232, 24, 180, 170, 26, 34, 19}, 3))], [])*/PROPERTYKEY(GUID("31B37743-7C5E-4005-93E6-E953F92B82E9"), 7),
    PKEY_Devices_WiFiDirectServices_ServiceAddress            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1238179702, 22054, 19223, 164, 232, 24, 180, 170, 26, 34, 19}, 3))], [])*/PROPERTYKEY(GUID("31B37743-7C5E-4005-93E6-E953F92B82E9"), 2),
    PKEY_Devices_WiFiDirectServices_ServiceConfigMethods      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1238179702, 22054, 19223, 164, 232, 24, 180, 170, 26, 34, 19}, 3))], [])*/PROPERTYKEY(GUID("31B37743-7C5E-4005-93E6-E953F92B82E9"), 6),
    PKEY_Devices_WiFiDirectServices_ServiceInformation        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1238179702, 22054, 19223, 164, 232, 24, 180, 170, 26, 34, 19}, 3))], [])*/PROPERTYKEY(GUID("31B37743-7C5E-4005-93E6-E953F92B82E9"), 4),
    PKEY_Devices_WiFiDirectServices_ServiceName               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1238179702, 22054, 19223, 164, 232, 24, 180, 170, 26, 34, 19}, 3))], [])*/PROPERTYKEY(GUID("31B37743-7C5E-4005-93E6-E953F92B82E9"), 3),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3082081820, 23140, 16775, 165, 46, 177, 83, 159, 53, 144, 153}, 2))], [])*/PROPERTYKEY
{
    PKEY_Devices_WinPhone8CameraFlags = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3082081820, 23140, 16775, 165, 46, 177, 83, 159, 53, 144, 153}, 2))], [])*/PROPERTYKEY(GUID("B7B4D61C-5A64-4187-A52E-B1539F359099"), 2),
    PKEY_Devices_Wwan_InterfaceGuid   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3082081820, 23140, 16775, 165, 46, 177, 83, 159, 53, 144, 153}, 2))], [])*/PROPERTYKEY(GUID("FF1167EB-CBFC-4341-A568-A7C91A68982C"), 2),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1293860584, 2051, 18292, 152, 66, 183, 125, 181, 2, 101, 233}, 2))], [])*/PROPERTYKEY
{
    PKEY_Storage_Portable       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1293860584, 2051, 18292, 152, 66, 183, 125, 181, 2, 101, 233}, 2))], [])*/PROPERTYKEY(GUID("4D1EBEE8-0803-4774-9842-B77DB50265E9"), 2),
    PKEY_Storage_RemovableMedia = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1293860584, 2051, 18292, 152, 66, 183, 125, 181, 2, 101, 233}, 2))], [])*/PROPERTYKEY(GUID("4D1EBEE8-0803-4774-9842-B77DB50265E9"), 3),
    PKEY_Storage_SystemCritical = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1293860584, 2051, 18292, 152, 66, 183, 125, 181, 2, 101, 233}, 2))], [])*/PROPERTYKEY(GUID("4D1EBEE8-0803-4774-9842-B77DB50265E9"), 4),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 4))], [])*/PROPERTYKEY
{
    PKEY_Document_ByteCount           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 4))], [])*/PROPERTYKEY(GUID("D5CDD502-2E9C-101B-9397-08002B2CF9AE"), 4),
    PKEY_Document_CharacterCount      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 4))], [])*/PROPERTYKEY(GUID("F29F85E0-4FF9-1068-AB91-08002B27B3D9"), 16),
    PKEY_Document_ClientID            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 4))], [])*/PROPERTYKEY(GUID("276D7BB0-5B34-4FB0-AA4B-158ED12A1809"), 100),
    PKEY_Document_Contributor         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 4))], [])*/PROPERTYKEY(GUID("F334115E-DA1B-4509-9B3D-119504DC7ABB"), 100),
    PKEY_Document_DateCreated         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 4))], [])*/PROPERTYKEY(GUID("F29F85E0-4FF9-1068-AB91-08002B27B3D9"), 12),
    PKEY_Document_DatePrinted         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 4))], [])*/PROPERTYKEY(GUID("F29F85E0-4FF9-1068-AB91-08002B27B3D9"), 11),
    PKEY_Document_DateSaved           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 4))], [])*/PROPERTYKEY(GUID("F29F85E0-4FF9-1068-AB91-08002B27B3D9"), 13),
    PKEY_Document_Division            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 4))], [])*/PROPERTYKEY(GUID("1E005EE6-BF27-428B-B01C-79676ACD2870"), 100),
    PKEY_Document_DocumentID          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 4))], [])*/PROPERTYKEY(GUID("E08805C8-E395-40DF-80D2-54F0D6C43154"), 100),
    PKEY_Document_HiddenSlideCount    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 4))], [])*/PROPERTYKEY(GUID("D5CDD502-2E9C-101B-9397-08002B2CF9AE"), 9),
    PKEY_Document_LastAuthor          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 4))], [])*/PROPERTYKEY(GUID("F29F85E0-4FF9-1068-AB91-08002B27B3D9"), 8),
    PKEY_Document_LineCount           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 4))], [])*/PROPERTYKEY(GUID("D5CDD502-2E9C-101B-9397-08002B2CF9AE"), 5),
    PKEY_Document_Manager             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 4))], [])*/PROPERTYKEY(GUID("D5CDD502-2E9C-101B-9397-08002B2CF9AE"), 14),
    PKEY_Document_MultimediaClipCount = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 4))], [])*/PROPERTYKEY(GUID("D5CDD502-2E9C-101B-9397-08002B2CF9AE"), 10),
    PKEY_Document_NoteCount           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 4))], [])*/PROPERTYKEY(GUID("D5CDD502-2E9C-101B-9397-08002B2CF9AE"), 8),
    PKEY_Document_PageCount           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 4))], [])*/PROPERTYKEY(GUID("F29F85E0-4FF9-1068-AB91-08002B27B3D9"), 14),
    PKEY_Document_ParagraphCount      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 4))], [])*/PROPERTYKEY(GUID("D5CDD502-2E9C-101B-9397-08002B2CF9AE"), 6),
    PKEY_Document_PresentationFormat  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 4))], [])*/PROPERTYKEY(GUID("D5CDD502-2E9C-101B-9397-08002B2CF9AE"), 3),
    PKEY_Document_RevisionNumber      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 4))], [])*/PROPERTYKEY(GUID("F29F85E0-4FF9-1068-AB91-08002B27B3D9"), 9),
    PKEY_Document_Security            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 4))], [])*/PROPERTYKEY(GUID("F29F85E0-4FF9-1068-AB91-08002B27B3D9"), 19),
    PKEY_Document_SlideCount          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 4))], [])*/PROPERTYKEY(GUID("D5CDD502-2E9C-101B-9397-08002B2CF9AE"), 7),
    PKEY_Document_Template            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 4))], [])*/PROPERTYKEY(GUID("F29F85E0-4FF9-1068-AB91-08002B27B3D9"), 7),
    PKEY_Document_TotalEditingTime    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 4))], [])*/PROPERTYKEY(GUID("F29F85E0-4FF9-1068-AB91-08002B27B3D9"), 10),
    PKEY_Document_Version             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 4))], [])*/PROPERTYKEY(GUID("D5CDD502-2E9C-101B-9397-08002B2CF9AE"), 29),
    PKEY_Document_WordCount           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3587036418, 11932, 4123, 147, 151, 8, 0, 43, 44, 249, 174}, 4))], [])*/PROPERTYKEY(GUID("F29F85E0-4FF9-1068-AB91-08002B27B3D9"), 15),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2930514404, 35246, 17672, 185, 183, 187, 134, 122, 190, 226, 237}, 6))], [])*/PROPERTYKEY
{
    PKEY_DRM_DatePlayExpires = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2930514404, 35246, 17672, 185, 183, 187, 134, 122, 190, 226, 237}, 6))], [])*/PROPERTYKEY(GUID("AEAC19E4-89AE-4508-B9B7-BB867ABEE2ED"), 6),
    PKEY_DRM_DatePlayStarts  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2930514404, 35246, 17672, 185, 183, 187, 134, 122, 190, 226, 237}, 6))], [])*/PROPERTYKEY(GUID("AEAC19E4-89AE-4508-B9B7-BB867ABEE2ED"), 5),
    PKEY_DRM_Description     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2930514404, 35246, 17672, 185, 183, 187, 134, 122, 190, 226, 237}, 6))], [])*/PROPERTYKEY(GUID("AEAC19E4-89AE-4508-B9B7-BB867ABEE2ED"), 3),
    PKEY_DRM_IsDisabled      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2930514404, 35246, 17672, 185, 183, 187, 134, 122, 190, 226, 237}, 6))], [])*/PROPERTYKEY(GUID("AEAC19E4-89AE-4508-B9B7-BB867ABEE2ED"), 7),
    PKEY_DRM_IsProtected     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2930514404, 35246, 17672, 185, 183, 187, 134, 122, 190, 226, 237}, 6))], [])*/PROPERTYKEY(GUID("AEAC19E4-89AE-4508-B9B7-BB867ABEE2ED"), 2),
    PKEY_DRM_PlayCount       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2930514404, 35246, 17672, 185, 183, 187, 134, 122, 190, 226, 237}, 6))], [])*/PROPERTYKEY(GUID("AEAC19E4-89AE-4508-B9B7-BB867ABEE2ED"), 4),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2189351759, 23411, 17575, 137, 29, 253, 255, 171, 234, 53, 202}, 100))], [])*/PROPERTYKEY
{
    PKEY_GPS_Altitude            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2189351759, 23411, 17575, 137, 29, 253, 255, 171, 234, 53, 202}, 100))], [])*/PROPERTYKEY(GUID("827EDB4F-5B73-44A7-891D-FDFFABEA35CA"), 100),
    PKEY_GPS_AltitudeDenominator = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2189351759, 23411, 17575, 137, 29, 253, 255, 171, 234, 53, 202}, 100))], [])*/PROPERTYKEY(GUID("78342DCB-E358-4145-AE9A-6BFE4E0F9F51"), 100),
    PKEY_GPS_AltitudeNumerator   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2189351759, 23411, 17575, 137, 29, 253, 255, 171, 234, 53, 202}, 100))], [])*/PROPERTYKEY(GUID("2DAD1EB7-816D-40D3-9EC3-C9773BE2AADE"), 100),
    PKEY_GPS_AltitudeRef         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2189351759, 23411, 17575, 137, 29, 253, 255, 171, 234, 53, 202}, 100))], [])*/PROPERTYKEY(GUID("46AC629D-75EA-4515-867F-6DC4321C5844"), 100),
    PKEY_GPS_AreaInformation     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2189351759, 23411, 17575, 137, 29, 253, 255, 171, 234, 53, 202}, 100))], [])*/PROPERTYKEY(GUID("972E333E-AC7E-49F1-8ADF-A70D07A9BCAB"), 100),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({906151954, 3899, 17904, 133, 173, 96, 52, 104, 214, 148, 35}, 100))], [])*/PROPERTYKEY
{
    PKEY_GPS_Date                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({906151954, 3899, 17904, 133, 173, 96, 52, 104, 214, 148, 35}, 100))], [])*/PROPERTYKEY(GUID("3602C812-0F3B-45F0-85AD-603468D69423"), 100),
    PKEY_GPS_DestBearing              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({906151954, 3899, 17904, 133, 173, 96, 52, 104, 214, 148, 35}, 100))], [])*/PROPERTYKEY(GUID("C66D4B3C-E888-47CC-B99F-9DCA3EE34DEA"), 100),
    PKEY_GPS_DestBearingDenominator   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({906151954, 3899, 17904, 133, 173, 96, 52, 104, 214, 148, 35}, 100))], [])*/PROPERTYKEY(GUID("7ABCF4F8-7C3F-4988-AC91-8D2C2E97ECA5"), 100),
    PKEY_GPS_DestBearingNumerator     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({906151954, 3899, 17904, 133, 173, 96, 52, 104, 214, 148, 35}, 100))], [])*/PROPERTYKEY(GUID("BA3B1DA9-86EE-4B5D-A2A4-A271A429F0CF"), 100),
    PKEY_GPS_DestBearingRef           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({906151954, 3899, 17904, 133, 173, 96, 52, 104, 214, 148, 35}, 100))], [])*/PROPERTYKEY(GUID("9AB84393-2A0F-4B75-BB22-7279786977CB"), 100),
    PKEY_GPS_DestDistance             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({906151954, 3899, 17904, 133, 173, 96, 52, 104, 214, 148, 35}, 100))], [])*/PROPERTYKEY(GUID("A93EAE04-6804-4F24-AC81-09B266452118"), 100),
    PKEY_GPS_DestDistanceDenominator  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({906151954, 3899, 17904, 133, 173, 96, 52, 104, 214, 148, 35}, 100))], [])*/PROPERTYKEY(GUID("9BC2C99B-AC71-4127-9D1C-2596D0D7DCB7"), 100),
    PKEY_GPS_DestDistanceNumerator    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({906151954, 3899, 17904, 133, 173, 96, 52, 104, 214, 148, 35}, 100))], [])*/PROPERTYKEY(GUID("2BDA47DA-08C6-4FE1-80BC-A72FC517C5D0"), 100),
    PKEY_GPS_DestDistanceRef          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({906151954, 3899, 17904, 133, 173, 96, 52, 104, 214, 148, 35}, 100))], [])*/PROPERTYKEY(GUID("ED4DF2D3-8695-450B-856F-F5C1C53ACB66"), 100),
    PKEY_GPS_DestLatitude             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({906151954, 3899, 17904, 133, 173, 96, 52, 104, 214, 148, 35}, 100))], [])*/PROPERTYKEY(GUID("9D1D7CC5-5C39-451C-86B3-928E2D18CC47"), 100),
    PKEY_GPS_DestLatitudeDenominator  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({906151954, 3899, 17904, 133, 173, 96, 52, 104, 214, 148, 35}, 100))], [])*/PROPERTYKEY(GUID("3A372292-7FCA-49A7-99D5-E47BB2D4E7AB"), 100),
    PKEY_GPS_DestLatitudeNumerator    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({906151954, 3899, 17904, 133, 173, 96, 52, 104, 214, 148, 35}, 100))], [])*/PROPERTYKEY(GUID("ECF4B6F6-D5A6-433C-BB92-4076650FC890"), 100),
    PKEY_GPS_DestLatitudeRef          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({906151954, 3899, 17904, 133, 173, 96, 52, 104, 214, 148, 35}, 100))], [])*/PROPERTYKEY(GUID("CEA820B9-CE61-4885-A128-005D9087C192"), 100),
    PKEY_GPS_DestLongitude            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({906151954, 3899, 17904, 133, 173, 96, 52, 104, 214, 148, 35}, 100))], [])*/PROPERTYKEY(GUID("47A96261-CB4C-4807-8AD3-40B9D9DBC6BC"), 100),
    PKEY_GPS_DestLongitudeDenominator = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({906151954, 3899, 17904, 133, 173, 96, 52, 104, 214, 148, 35}, 100))], [])*/PROPERTYKEY(GUID("425D69E5-48AD-4900-8D80-6EB6B8D0AC86"), 100),
    PKEY_GPS_DestLongitudeNumerator   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({906151954, 3899, 17904, 133, 173, 96, 52, 104, 214, 148, 35}, 100))], [])*/PROPERTYKEY(GUID("A3250282-FB6D-48D5-9A89-DBCACE75CCCF"), 100),
    PKEY_GPS_DestLongitudeRef         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({906151954, 3899, 17904, 133, 173, 96, 52, 104, 214, 148, 35}, 100))], [])*/PROPERTYKEY(GUID("182C1EA6-7C1C-4083-AB4B-AC6C9F4ED128"), 100),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2868178469, 48443, 19927, 191, 196, 71, 247, 123, 176, 15, 109}, 100))], [])*/PROPERTYKEY
{
    PKEY_GPS_Differential            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2868178469, 48443, 19927, 191, 196, 71, 247, 123, 176, 15, 109}, 100))], [])*/PROPERTYKEY(GUID("AAF4EE25-BD3B-4DD7-BFC4-47F77BB00F6D"), 100),
    PKEY_GPS_DOP                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2868178469, 48443, 19927, 191, 196, 71, 247, 123, 176, 15, 109}, 100))], [])*/PROPERTYKEY(GUID("0CF8FB02-1837-42F1-A697-A7017AA289B9"), 100),
    PKEY_GPS_DOPDenominator          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2868178469, 48443, 19927, 191, 196, 71, 247, 123, 176, 15, 109}, 100))], [])*/PROPERTYKEY(GUID("A0BE94C5-50BA-487B-BD35-0654BE8881ED"), 100),
    PKEY_GPS_DOPNumerator            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2868178469, 48443, 19927, 191, 196, 71, 247, 123, 176, 15, 109}, 100))], [])*/PROPERTYKEY(GUID("47166B16-364F-4AA0-9F31-E2AB3DF449C3"), 100),
    PKEY_GPS_ImgDirection            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2868178469, 48443, 19927, 191, 196, 71, 247, 123, 176, 15, 109}, 100))], [])*/PROPERTYKEY(GUID("16473C91-D017-4ED9-BA4D-B6BAA55DBCF8"), 100),
    PKEY_GPS_ImgDirectionDenominator = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2868178469, 48443, 19927, 191, 196, 71, 247, 123, 176, 15, 109}, 100))], [])*/PROPERTYKEY(GUID("10B24595-41A2-4E20-93C2-5761C1395F32"), 100),
    PKEY_GPS_ImgDirectionNumerator   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2868178469, 48443, 19927, 191, 196, 71, 247, 123, 176, 15, 109}, 100))], [])*/PROPERTYKEY(GUID("DC5877C7-225F-45F7-BAC7-E81334B6130A"), 100),
    PKEY_GPS_ImgDirectionRef         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2868178469, 48443, 19927, 191, 196, 71, 247, 123, 176, 15, 109}, 100))], [])*/PROPERTYKEY(GUID("A4AAA5B7-1AD0-445F-811A-0F8F6E67F6B5"), 100),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2267533311, 18536, 20166, 173, 91, 129, 185, 133, 33, 209, 171}, 100))], [])*/PROPERTYKEY
{
    PKEY_GPS_Latitude             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2267533311, 18536, 20166, 173, 91, 129, 185, 133, 33, 209, 171}, 100))], [])*/PROPERTYKEY(GUID("8727CFFF-4868-4EC6-AD5B-81B98521D1AB"), 100),
    PKEY_GPS_LatitudeDecimal      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2267533311, 18536, 20166, 173, 91, 129, 185, 133, 33, 209, 171}, 100))], [])*/PROPERTYKEY(GUID("0F55CDE2-4F49-450D-92C1-DCD16301B1B7"), 100),
    PKEY_GPS_LatitudeDenominator  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2267533311, 18536, 20166, 173, 91, 129, 185, 133, 33, 209, 171}, 100))], [])*/PROPERTYKEY(GUID("16E634EE-2BFF-497B-BD8A-4341AD39EEB9"), 100),
    PKEY_GPS_LatitudeNumerator    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2267533311, 18536, 20166, 173, 91, 129, 185, 133, 33, 209, 171}, 100))], [])*/PROPERTYKEY(GUID("7DDAAAD1-CCC8-41AE-B750-B2CB8031AEA2"), 100),
    PKEY_GPS_LatitudeRef          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2267533311, 18536, 20166, 173, 91, 129, 185, 133, 33, 209, 171}, 100))], [])*/PROPERTYKEY(GUID("029C0252-5B86-46C7-ACA0-2769FFC8E3D4"), 100),
    PKEY_GPS_Longitude            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2267533311, 18536, 20166, 173, 91, 129, 185, 133, 33, 209, 171}, 100))], [])*/PROPERTYKEY(GUID("C4C4DBB2-B593-466B-BBDA-D03D27D5E43A"), 100),
    PKEY_GPS_LongitudeDecimal     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2267533311, 18536, 20166, 173, 91, 129, 185, 133, 33, 209, 171}, 100))], [])*/PROPERTYKEY(GUID("4679C1B5-844D-4590-BAF5-F322231F1B81"), 100),
    PKEY_GPS_LongitudeDenominator = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2267533311, 18536, 20166, 173, 91, 129, 185, 133, 33, 209, 171}, 100))], [])*/PROPERTYKEY(GUID("BE6E176C-4534-4D2C-ACE5-31DEDAC1606B"), 100),
    PKEY_GPS_LongitudeNumerator   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2267533311, 18536, 20166, 173, 91, 129, 185, 133, 33, 209, 171}, 100))], [])*/PROPERTYKEY(GUID("02B0F689-A914-4E45-821D-1DDA452ED2C4"), 100),
    PKEY_GPS_LongitudeRef         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2267533311, 18536, 20166, 173, 91, 129, 185, 133, 33, 209, 171}, 100))], [])*/PROPERTYKEY(GUID("33DCF22B-28D5-464C-8035-1EE9EFD25278"), 100),
    PKEY_GPS_MapDatum             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2267533311, 18536, 20166, 173, 91, 129, 185, 133, 33, 209, 171}, 100))], [])*/PROPERTYKEY(GUID("2CA2DAE6-EDDC-407D-BEF1-773942ABFA95"), 100),
    PKEY_GPS_MeasureMode          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2267533311, 18536, 20166, 173, 91, 129, 185, 133, 33, 209, 171}, 100))], [])*/PROPERTYKEY(GUID("A015ED5D-AAEA-4D58-8A86-3C586920EA0B"), 100),
    PKEY_GPS_ProcessingMethod     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2267533311, 18536, 20166, 173, 91, 129, 185, 133, 33, 209, 171}, 100))], [])*/PROPERTYKEY(GUID("59D49E61-840F-4AA9-A939-E2099B7F6399"), 100),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1182721397, 7973, 17751, 173, 78, 184, 181, 139, 13, 156, 21}, 100))], [])*/PROPERTYKEY
{
    PKEY_GPS_Satellites       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1182721397, 7973, 17751, 173, 78, 184, 181, 139, 13, 156, 21}, 100))], [])*/PROPERTYKEY(GUID("467EE575-1F25-4557-AD4E-B8B58B0D9C15"), 100),
    PKEY_GPS_Speed            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1182721397, 7973, 17751, 173, 78, 184, 181, 139, 13, 156, 21}, 100))], [])*/PROPERTYKEY(GUID("DA5D0862-6E76-4E1B-BABD-70021BD25494"), 100),
    PKEY_GPS_SpeedDenominator = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1182721397, 7973, 17751, 173, 78, 184, 181, 139, 13, 156, 21}, 100))], [])*/PROPERTYKEY(GUID("7D122D5A-AE5E-4335-8841-D71E7CE72F53"), 100),
    PKEY_GPS_SpeedNumerator   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1182721397, 7973, 17751, 173, 78, 184, 181, 139, 13, 156, 21}, 100))], [])*/PROPERTYKEY(GUID("ACC9CE3D-C213-4942-8B48-6D0820F21C6D"), 100),
    PKEY_GPS_SpeedRef         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1182721397, 7973, 17751, 173, 78, 184, 181, 139, 13, 156, 21}, 100))], [])*/PROPERTYKEY(GUID("ECF7F4C9-544F-4D6D-9D98-8AD79ADAF453"), 100),
    PKEY_GPS_Status           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1182721397, 7973, 17751, 173, 78, 184, 181, 139, 13, 156, 21}, 100))], [])*/PROPERTYKEY(GUID("125491F4-818F-46B2-91B5-D537753617B2"), 100),
    PKEY_GPS_Track            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1182721397, 7973, 17751, 173, 78, 184, 181, 139, 13, 156, 21}, 100))], [])*/PROPERTYKEY(GUID("76C09943-7C33-49E3-9E7E-CDBA872CFADA"), 100),
    PKEY_GPS_TrackDenominator = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1182721397, 7973, 17751, 173, 78, 184, 181, 139, 13, 156, 21}, 100))], [])*/PROPERTYKEY(GUID("C8D1920C-01F6-40C0-AC86-2F3A4AD00770"), 100),
    PKEY_GPS_TrackNumerator   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1182721397, 7973, 17751, 173, 78, 184, 181, 139, 13, 156, 21}, 100))], [])*/PROPERTYKEY(GUID("702926F4-44A6-43E1-AE71-45627116893B"), 100),
    PKEY_GPS_TrackRef         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1182721397, 7973, 17751, 173, 78, 184, 181, 139, 13, 156, 21}, 100))], [])*/PROPERTYKEY(GUID("35DBE6FE-44C3-4400-AAAE-D2C799C407E8"), 100),
    PKEY_GPS_VersionID        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1182721397, 7973, 17751, 173, 78, 184, 181, 139, 13, 156, 21}, 100))], [])*/PROPERTYKEY(GUID("22704DA4-C6B2-4A99-8E56-F16DF8C92599"), 100),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1556031367, 18639, 16904, 185, 14, 238, 94, 93, 66, 2, 148}, 7))], [])*/PROPERTYKEY PKEY_History_VisitCount = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1556031367, 18639, 16904, 185, 14, 238, 94, 93, 66, 2, 148}, 7))], [])*/PROPERTYKEY(GUID("5CBF2787-48CF-4208-B90E-EE5E5D420294"), 7);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179215, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 7))], [])*/PROPERTYKEY
{
    PKEY_Image_BitDepth                          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179215, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 7))], [])*/PROPERTYKEY(GUID("6444048F-4C8B-11D1-8B70-080036B11A03"), 7),
    PKEY_Image_ColorSpace                        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179215, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 7))], [])*/PROPERTYKEY(GUID("14B81DA1-0135-4D31-96D9-6CBFC9671A99"), 40961),
    PKEY_Image_CompressedBitsPerPixel            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179215, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 7))], [])*/PROPERTYKEY(GUID("364B6FA9-37AB-482A-BE2B-AE02F60D4318"), 100),
    PKEY_Image_CompressedBitsPerPixelDenominator = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179215, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 7))], [])*/PROPERTYKEY(GUID("1F8844E1-24AD-4508-9DFD-5326A415CE02"), 100),
    PKEY_Image_CompressedBitsPerPixelNumerator   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179215, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 7))], [])*/PROPERTYKEY(GUID("D21A7148-D32C-4624-8900-277210F79C0F"), 100),
    PKEY_Image_Compression                       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179215, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 7))], [])*/PROPERTYKEY(GUID("14B81DA1-0135-4D31-96D9-6CBFC9671A99"), 259),
    PKEY_Image_CompressionText                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179215, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 7))], [])*/PROPERTYKEY(GUID("3F08E66F-2F44-4BB9-A682-AC35D2562322"), 100),
    PKEY_Image_Dimensions                        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179215, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 7))], [])*/PROPERTYKEY(GUID("6444048F-4C8B-11D1-8B70-080036B11A03"), 13),
    PKEY_Image_HorizontalResolution              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179215, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 7))], [])*/PROPERTYKEY(GUID("6444048F-4C8B-11D1-8B70-080036B11A03"), 5),
    PKEY_Image_HorizontalSize                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179215, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 7))], [])*/PROPERTYKEY(GUID("6444048F-4C8B-11D1-8B70-080036B11A03"), 3),
    PKEY_Image_ImageID                           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179215, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 7))], [])*/PROPERTYKEY(GUID("10DABE05-32AA-4C29-BF1A-63E2D220587F"), 100),
    PKEY_Image_ResolutionUnit                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179215, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 7))], [])*/PROPERTYKEY(GUID("19B51FA6-1F92-4A5C-AB48-7DF0ABD67444"), 100),
    PKEY_Image_VerticalResolution                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179215, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 7))], [])*/PROPERTYKEY(GUID("6444048F-4C8B-11D1-8B70-080036B11A03"), 6),
    PKEY_Image_VerticalSize                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179215, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 7))], [])*/PROPERTYKEY(GUID("6444048F-4C8B-11D1-8B70-080036B11A03"), 4),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3735537708, 7561, 19046, 148, 39, 164, 227, 222, 186, 188, 177}, 100))], [])*/PROPERTYKEY
{
    PKEY_Journal_Contacts  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3735537708, 7561, 19046, 148, 39, 164, 227, 222, 186, 188, 177}, 100))], [])*/PROPERTYKEY(GUID("DEA7C82C-1D89-4A66-9427-A4E3DEBABCB1"), 100),
    PKEY_Journal_EntryType = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3735537708, 7561, 19046, 148, 39, 164, 227, 222, 186, 188, 177}, 100))], [])*/PROPERTYKEY(GUID("95BEB1FC-326D-4644-B396-CD3ED90E6DDF"), 100),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3381938721, 41990, 18686, 130, 37, 174, 199, 226, 76, 33, 27}, 500))], [])*/PROPERTYKEY PKEY_LayoutPattern_ContentViewModeForBrowse = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3381938721, 41990, 18686, 130, 37, 174, 199, 226, 76, 33, 27}, 500))], [])*/PROPERTYKEY(GUID("C9944A21-A406-48FE-8225-AEC7E24C211B"), 500);

enum : const(wchar)*
{
    LAYOUTPATTERN_CVMFB_ALPHA = "alpha",
    LAYOUTPATTERN_CVMFB_BETA  = "beta",
    LAYOUTPATTERN_CVMFB_GAMMA = "gamma",
    LAYOUTPATTERN_CVMFB_DELTA = "delta",
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3381938721, 41990, 18686, 130, 37, 174, 199, 226, 76, 33, 27}, 501))], [])*/PROPERTYKEY PKEY_LayoutPattern_ContentViewModeForSearch = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3381938721, 41990, 18686, 130, 37, 174, 199, 226, 76, 33, 27}, 501))], [])*/PROPERTYKEY(GUID("C9944A21-A406-48FE-8225-AEC7E24C211B"), 501);

enum : const(wchar)*
{
    LAYOUTPATTERN_CVMFS_ALPHA = "alpha",
    LAYOUTPATTERN_CVMFS_BETA  = "beta",
    LAYOUTPATTERN_CVMFS_GAMMA = "gamma",
    LAYOUTPATTERN_CVMFS_DELTA = "delta",
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({484497084, 21356, 17920, 176, 221, 126, 12, 102, 179, 80, 213}, 8))], [])*/PROPERTYKEY
{
    PKEY_History_SelectionCount    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({484497084, 21356, 17920, 176, 221, 126, 12, 102, 179, 80, 213}, 8))], [])*/PROPERTYKEY(GUID("1CE0D6BC-536C-4600-B0DD-7E0C66B350D5"), 8),
    PKEY_History_TargetUrlHostName = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({484497084, 21356, 17920, 176, 221, 126, 12, 102, 179, 80, 213}, 8))], [])*/PROPERTYKEY(GUID("1CE0D6BC-536C-4600-B0DD-7E0C66B350D5"), 9),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1131357799, 5346, 20459, 179, 10, 20, 108, 83, 181, 182, 116}, 100))], [])*/PROPERTYKEY
{
    PKEY_Link_Arguments       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1131357799, 5346, 20459, 179, 10, 20, 108, 83, 181, 182, 116}, 100))], [])*/PROPERTYKEY(GUID("436F2667-14E2-4FEB-B30A-146C53B5B674"), 100),
    PKEY_Link_Comment         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1131357799, 5346, 20459, 179, 10, 20, 108, 83, 181, 182, 116}, 100))], [])*/PROPERTYKEY(GUID("B9B4B3FC-2B51-4A42-B5D8-324146AFCF25"), 5),
    PKEY_Link_DateVisited     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1131357799, 5346, 20459, 179, 10, 20, 108, 83, 181, 182, 116}, 100))], [])*/PROPERTYKEY(GUID("5CBF2787-48CF-4208-B90E-EE5E5D420294"), 23),
    PKEY_Link_Description     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1131357799, 5346, 20459, 179, 10, 20, 108, 83, 181, 182, 116}, 100))], [])*/PROPERTYKEY(GUID("5CBF2787-48CF-4208-B90E-EE5E5D420294"), 21),
    PKEY_Link_FeedItemLocalId = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1131357799, 5346, 20459, 179, 10, 20, 108, 83, 181, 182, 116}, 100))], [])*/PROPERTYKEY(GUID("8A2F99F9-3C37-465D-A8D7-69777A246D0C"), 2),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3115627516, 11089, 19010, 181, 216, 50, 65, 70, 175, 207, 37}, 3))], [])*/PROPERTYKEY PKEY_Link_Status = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3115627516, 11089, 19010, 181, 216, 50, 65, 70, 175, 207, 37}, 3))], [])*/PROPERTYKEY(GUID("B9B4B3FC-2B51-4A42-B5D8-324146AFCF25"), 3);

enum : int
{
    LINK_STATUS_RESOLVED = 0x00000001,
    LINK_STATUS_BROKEN   = 0x00000002,
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2055042804, 46640, 19415, 149, 255, 55, 204, 81, 169, 117, 201}, 2))], [])*/PROPERTYKEY
{
    PKEY_Link_TargetExtension   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2055042804, 46640, 19415, 149, 255, 55, 204, 81, 169, 117, 201}, 2))], [])*/PROPERTYKEY(GUID("7A7D76F4-B630-4BD7-95FF-37CC51A975C9"), 2),
    PKEY_Link_TargetParsingPath = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2055042804, 46640, 19415, 149, 255, 55, 204, 81, 169, 117, 201}, 2))], [])*/PROPERTYKEY(GUID("B9B4B3FC-2B51-4A42-B5D8-324146AFCF25"), 2),
    PKEY_Link_TargetSFGAOFlags  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2055042804, 46640, 19415, 149, 255, 55, 204, 81, 169, 117, 201}, 2))], [])*/PROPERTYKEY(GUID("B9B4B3FC-2B51-4A42-B5D8-324146AFCF25"), 8),
    PKEY_Link_TargetUrlHostName = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2055042804, 46640, 19415, 149, 255, 55, 204, 81, 169, 117, 201}, 2))], [])*/PROPERTYKEY(GUID("8A2F99F9-3C37-465D-A8D7-69777A246D0C"), 5),
    PKEY_Link_TargetUrlPath     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2055042804, 46640, 19415, 149, 255, 55, 204, 81, 169, 117, 201}, 2))], [])*/PROPERTYKEY(GUID("8A2F99F9-3C37-465D-A8D7-69777A246D0C"), 6),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 32))], [])*/PROPERTYKEY
{
    PKEY_Media_AuthorUrl                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 32))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 32),
    PKEY_Media_AverageLevel              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 32))], [])*/PROPERTYKEY(GUID("09EDD5B6-B301-43C5-9990-D00302EFFD46"), 100),
    PKEY_Media_ClassPrimaryID            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 32))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 13),
    PKEY_Media_ClassSecondaryID          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 32))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 14),
    PKEY_Media_CollectionGroupID         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 32))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 24),
    PKEY_Media_CollectionID              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 32))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 25),
    PKEY_Media_ContentDistributor        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 32))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 18),
    PKEY_Media_ContentID                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 32))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 26),
    PKEY_Media_CreatorApplication        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 32))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 27),
    PKEY_Media_CreatorApplicationVersion = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 32))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 28),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({776692749, 20505, 18136, 136, 129, 85, 65, 76, 197, 202, 160}, 100))], [])*/PROPERTYKEY
{
    PKEY_Media_DateEncoded             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({776692749, 20505, 18136, 136, 129, 85, 65, 76, 197, 202, 160}, 100))], [])*/PROPERTYKEY(GUID("2E4B640D-5019-46D8-8881-55414CC5CAA0"), 100),
    PKEY_Media_DateReleased            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({776692749, 20505, 18136, 136, 129, 85, 65, 76, 197, 202, 160}, 100))], [])*/PROPERTYKEY(GUID("DE41CC29-6971-4290-B472-F59F2E2F31E2"), 100),
    PKEY_Media_DlnaProfileID           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({776692749, 20505, 18136, 136, 129, 85, 65, 76, 197, 202, 160}, 100))], [])*/PROPERTYKEY(GUID("CFA31B45-525D-4998-BB44-3F7D81542FA4"), 100),
    PKEY_Media_Duration                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({776692749, 20505, 18136, 136, 129, 85, 65, 76, 197, 202, 160}, 100))], [])*/PROPERTYKEY(GUID("64440490-4C8B-11D1-8B70-080036B11A03"), 3),
    PKEY_Media_DVDID                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({776692749, 20505, 18136, 136, 129, 85, 65, 76, 197, 202, 160}, 100))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 15),
    PKEY_Media_EncodedBy               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({776692749, 20505, 18136, 136, 129, 85, 65, 76, 197, 202, 160}, 100))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 36),
    PKEY_Media_EncodingSettings        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({776692749, 20505, 18136, 136, 129, 85, 65, 76, 197, 202, 160}, 100))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 37),
    PKEY_Media_EpisodeNumber           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({776692749, 20505, 18136, 136, 129, 85, 65, 76, 197, 202, 160}, 100))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 100),
    PKEY_Media_FrameCount              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({776692749, 20505, 18136, 136, 129, 85, 65, 76, 197, 202, 160}, 100))], [])*/PROPERTYKEY(GUID("6444048F-4C8B-11D1-8B70-080036B11A03"), 12),
    PKEY_Media_MCDI                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({776692749, 20505, 18136, 136, 129, 85, 65, 76, 197, 202, 160}, 100))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 16),
    PKEY_Media_MetadataContentProvider = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({776692749, 20505, 18136, 136, 129, 85, 65, 76, 197, 202, 160}, 100))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 17),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 22))], [])*/PROPERTYKEY
{
    PKEY_Media_Producer              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 22))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 22),
    PKEY_Media_PromotionUrl          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 22))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 33),
    PKEY_Media_ProtectionType        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 22))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 38),
    PKEY_Media_ProviderRating        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 22))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 39),
    PKEY_Media_ProviderStyle         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 22))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 40),
    PKEY_Media_Publisher             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 22))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 30),
    PKEY_Media_SeasonNumber          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 22))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 101),
    PKEY_Media_SeriesName            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 22))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 42),
    PKEY_Media_SubscriptionContentId = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 22))], [])*/PROPERTYKEY(GUID("9AEBAE7A-9644-487D-A92C-657585ED751A"), 100),
    PKEY_Media_SubTitle              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 22))], [])*/PROPERTYKEY(GUID("56A3372E-CE9C-11D2-9F0E-006097C686F6"), 38),
    PKEY_Media_ThumbnailLargePath    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 22))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 47),
    PKEY_Media_ThumbnailLargeUri     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 22))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 48),
    PKEY_Media_ThumbnailSmallPath    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 22))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 49),
    PKEY_Media_ThumbnailSmallUri     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 22))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 50),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 35))], [])*/PROPERTYKEY PKEY_Media_UniqueFileIdentifier = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 35))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 35);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY
{
    PKEY_Media_UserNoAutoInfo       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 41),
    PKEY_Media_UserWebUrl           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 34),
    PKEY_Media_Writer               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 23),
    PKEY_Media_Year                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("56A3372E-CE9C-11D2-9F0E-006097C686F6"), 5),
    PKEY_Message_AttachmentContents = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("3143BF7C-80A8-4854-8880-E2E40189BDD0"), 100),
    PKEY_Message_AttachmentNames    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD"), 21),
    PKEY_Message_BccAddress         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD"), 2),
    PKEY_Message_BccName            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD"), 3),
    PKEY_Message_CcAddress          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD"), 4),
    PKEY_Message_CcName             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD"), 5),
    PKEY_Message_ConversationID     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("DC8F80BD-AF1E-4289-85B6-3DFC1B493992"), 100),
    PKEY_Message_ConversationIndex  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("DC8F80BD-AF1E-4289-85B6-3DFC1B493992"), 101),
    PKEY_Message_DateReceived       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD"), 20),
    PKEY_Message_DateSent           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD"), 19),
    PKEY_Message_Flags              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("A82D9EE7-CA67-4312-965E-226BCEA85023"), 100),
    PKEY_Message_FromAddress        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD"), 13),
    PKEY_Message_FromName           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD"), 14),
    PKEY_Message_HasAttachments     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("9C1FCF74-2D97-41BA-B4AE-CB2E3661A6E4"), 8),
    PKEY_Message_IsFwdOrReply       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("9A9BC088-4F6D-469E-9919-E705412040F9"), 100),
    PKEY_Message_MessageClass       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("CD9ED458-08CE-418F-A70E-F912C7BB9C5C"), 103),
    PKEY_Message_Participants       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("1A9BA605-8E7C-4D11-AD7D-A50ADA18BA1B"), 2),
    PKEY_Message_ProofInProgress    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("9098F33C-9A7D-48A8-8DE5-2E1227A64E91"), 100),
    PKEY_Message_SenderAddress      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("0BE1C8E7-1981-4676-AE14-FDD78F05A6E7"), 100),
    PKEY_Message_SenderName         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("0DA41CFA-D224-4A18-AE2F-596158DB4B3A"), 100),
    PKEY_Message_Store              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD"), 15),
    PKEY_Message_ToAddress          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD"), 16),
    PKEY_Message_ToDoFlags          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("1F856A9F-6900-4ABA-9505-2D5F1B4D66CB"), 100),
    PKEY_Message_ToDoTitle          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("BCCC8A3C-8CEF-42E5-9B1C-C69079398BC7"), 100),
    PKEY_Message_ToName             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179218, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 41))], [])*/PROPERTYKEY(GUID("E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD"), 17),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1334138494, 65520, 19957, 177, 217, 152, 179, 20, 255, 7, 41}, 14))], [])*/PROPERTYKEY
{
    PKEY_MsGraph_ActivityType                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1334138494, 65520, 19957, 177, 217, 152, 179, 20, 255, 7, 41}, 14))], [])*/PROPERTYKEY(GUID("4F85567E-FFF0-4DF5-B1D9-98B314FF0729"), 14),
    PKEY_MsGraph_CompositeId                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1334138494, 65520, 19957, 177, 217, 152, 179, 20, 255, 7, 41}, 14))], [])*/PROPERTYKEY(GUID("4F85567E-FFF0-4DF5-B1D9-98B314FF0729"), 2),
    PKEY_MsGraph_DateLastShared                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1334138494, 65520, 19957, 177, 217, 152, 179, 20, 255, 7, 41}, 14))], [])*/PROPERTYKEY(GUID("4F85567E-FFF0-4DF5-B1D9-98B314FF0729"), 9),
    PKEY_MsGraph_DriveId                         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1334138494, 65520, 19957, 177, 217, 152, 179, 20, 255, 7, 41}, 14))], [])*/PROPERTYKEY(GUID("4F85567E-FFF0-4DF5-B1D9-98B314FF0729"), 3),
    PKEY_MsGraph_GraphFileType                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1334138494, 65520, 19957, 177, 217, 152, 179, 20, 255, 7, 41}, 14))], [])*/PROPERTYKEY(GUID("4F85567E-FFF0-4DF5-B1D9-98B314FF0729"), 16),
    PKEY_MsGraph_IconUrl                         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1334138494, 65520, 19957, 177, 217, 152, 179, 20, 255, 7, 41}, 14))], [])*/PROPERTYKEY(GUID("4F85567E-FFF0-4DF5-B1D9-98B314FF0729"), 15),
    PKEY_MsGraph_ItemId                          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1334138494, 65520, 19957, 177, 217, 152, 179, 20, 255, 7, 41}, 14))], [])*/PROPERTYKEY(GUID("4F85567E-FFF0-4DF5-B1D9-98B314FF0729"), 4),
    PKEY_MsGraph_PrimaryActivityActorDisplayName = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1334138494, 65520, 19957, 177, 217, 152, 179, 20, 255, 7, 41}, 14))], [])*/PROPERTYKEY(GUID("4F85567E-FFF0-4DF5-B1D9-98B314FF0729"), 13),
    PKEY_MsGraph_PrimaryActivityActorUpn         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1334138494, 65520, 19957, 177, 217, 152, 179, 20, 255, 7, 41}, 14))], [])*/PROPERTYKEY(GUID("4F85567E-FFF0-4DF5-B1D9-98B314FF0729"), 12),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1334138494, 65520, 19957, 177, 217, 152, 179, 20, 255, 7, 41}, 8))], [])*/PROPERTYKEY
{
    PKEY_MsGraph_RecommendationReason         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1334138494, 65520, 19957, 177, 217, 152, 179, 20, 255, 7, 41}, 8))], [])*/PROPERTYKEY(GUID("4F85567E-FFF0-4DF5-B1D9-98B314FF0729"), 8),
    PKEY_MsGraph_RecommendationReferenceId    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1334138494, 65520, 19957, 177, 217, 152, 179, 20, 255, 7, 41}, 8))], [])*/PROPERTYKEY(GUID("4F85567E-FFF0-4DF5-B1D9-98B314FF0729"), 5),
    PKEY_MsGraph_RecommendationResultSourceId = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1334138494, 65520, 19957, 177, 217, 152, 179, 20, 255, 7, 41}, 8))], [])*/PROPERTYKEY(GUID("4F85567E-FFF0-4DF5-B1D9-98B314FF0729"), 7),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1334138494, 65520, 19957, 177, 217, 152, 179, 20, 255, 7, 41}, 11))], [])*/PROPERTYKEY
{
    PKEY_MsGraph_SharedByEmail = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1334138494, 65520, 19957, 177, 217, 152, 179, 20, 255, 7, 41}, 11))], [])*/PROPERTYKEY(GUID("4F85567E-FFF0-4DF5-B1D9-98B314FF0729"), 11),
    PKEY_MsGraph_SharedByName  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1334138494, 65520, 19957, 177, 217, 152, 179, 20, 255, 7, 41}, 11))], [])*/PROPERTYKEY(GUID("4F85567E-FFF0-4DF5-B1D9-98B314FF0729"), 10),
    PKEY_MsGraph_WebAccountId  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1334138494, 65520, 19957, 177, 217, 152, 179, 20, 255, 7, 41}, 11))], [])*/PROPERTYKEY(GUID("4F85567E-FFF0-4DF5-B1D9-98B314FF0729"), 6),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1453537070, 52892, 4562, 159, 14, 0, 96, 151, 198, 134, 246}, 13))], [])*/PROPERTYKEY
{
    PKEY_Music_AlbumArtist             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1453537070, 52892, 4562, 159, 14, 0, 96, 151, 198, 134, 246}, 13))], [])*/PROPERTYKEY(GUID("56A3372E-CE9C-11D2-9F0E-006097C686F6"), 13),
    PKEY_Music_AlbumArtistSortOverride = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1453537070, 52892, 4562, 159, 14, 0, 96, 151, 198, 134, 246}, 13))], [])*/PROPERTYKEY(GUID("F1FDB4AF-F78C-466C-BB05-56E92DB0B8EC"), 103),
    PKEY_Music_AlbumID                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1453537070, 52892, 4562, 159, 14, 0, 96, 151, 198, 134, 246}, 13))], [])*/PROPERTYKEY(GUID("56A3372E-CE9C-11D2-9F0E-006097C686F6"), 100),
    PKEY_Music_AlbumTitle              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1453537070, 52892, 4562, 159, 14, 0, 96, 151, 198, 134, 246}, 13))], [])*/PROPERTYKEY(GUID("56A3372E-CE9C-11D2-9F0E-006097C686F6"), 4),
    PKEY_Music_AlbumTitleSortOverride  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1453537070, 52892, 4562, 159, 14, 0, 96, 151, 198, 134, 246}, 13))], [])*/PROPERTYKEY(GUID("13EB7FFC-EC89-4346-B19D-CCC6F1784223"), 101),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1453537070, 52892, 4562, 159, 14, 0, 96, 151, 198, 134, 246}, 2))], [])*/PROPERTYKEY
{
    PKEY_Music_Artist             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1453537070, 52892, 4562, 159, 14, 0, 96, 151, 198, 134, 246}, 2))], [])*/PROPERTYKEY(GUID("56A3372E-CE9C-11D2-9F0E-006097C686F6"), 2),
    PKEY_Music_ArtistSortOverride = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1453537070, 52892, 4562, 159, 14, 0, 96, 151, 198, 134, 246}, 2))], [])*/PROPERTYKEY(GUID("DEEB2DB5-0696-4CE0-94FE-A01F77A45FB5"), 102),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1453537070, 52892, 4562, 159, 14, 0, 96, 151, 198, 134, 246}, 35))], [])*/PROPERTYKEY
{
    PKEY_Music_BeatsPerMinute          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1453537070, 52892, 4562, 159, 14, 0, 96, 151, 198, 134, 246}, 35))], [])*/PROPERTYKEY(GUID("56A3372E-CE9C-11D2-9F0E-006097C686F6"), 35),
    PKEY_Music_Composer                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1453537070, 52892, 4562, 159, 14, 0, 96, 151, 198, 134, 246}, 35))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 19),
    PKEY_Music_ComposerSortOverride    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1453537070, 52892, 4562, 159, 14, 0, 96, 151, 198, 134, 246}, 35))], [])*/PROPERTYKEY(GUID("00BC20A3-BD48-4085-872C-A88D77F5097E"), 105),
    PKEY_Music_Conductor               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1453537070, 52892, 4562, 159, 14, 0, 96, 151, 198, 134, 246}, 35))], [])*/PROPERTYKEY(GUID("56A3372E-CE9C-11D2-9F0E-006097C686F6"), 36),
    PKEY_Music_ContentGroupDescription = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1453537070, 52892, 4562, 159, 14, 0, 96, 151, 198, 134, 246}, 35))], [])*/PROPERTYKEY(GUID("56A3372E-CE9C-11D2-9F0E-006097C686F6"), 33),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1795060791, 39885, 18887, 128, 254, 74, 92, 101, 250, 88, 116}, 104))], [])*/PROPERTYKEY
{
    PKEY_Music_DiscNumber         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1795060791, 39885, 18887, 128, 254, 74, 92, 101, 250, 88, 116}, 104))], [])*/PROPERTYKEY(GUID("6AFE7437-9BCD-49C7-80FE-4A5C65FA5874"), 104),
    PKEY_Music_DisplayArtist      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1795060791, 39885, 18887, 128, 254, 74, 92, 101, 250, 88, 116}, 104))], [])*/PROPERTYKEY(GUID("FD122953-FA93-4EF7-92C3-04C946B2F7C8"), 100),
    PKEY_Music_Genre              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1795060791, 39885, 18887, 128, 254, 74, 92, 101, 250, 88, 116}, 104))], [])*/PROPERTYKEY(GUID("56A3372E-CE9C-11D2-9F0E-006097C686F6"), 11),
    PKEY_Music_InitialKey         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1795060791, 39885, 18887, 128, 254, 74, 92, 101, 250, 88, 116}, 104))], [])*/PROPERTYKEY(GUID("56A3372E-CE9C-11D2-9F0E-006097C686F6"), 34),
    PKEY_Music_IsCompilation      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1795060791, 39885, 18887, 128, 254, 74, 92, 101, 250, 88, 116}, 104))], [])*/PROPERTYKEY(GUID("C449D5CB-9EA4-4809-82E8-AF9D59DED6D1"), 100),
    PKEY_Music_Lyrics             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1795060791, 39885, 18887, 128, 254, 74, 92, 101, 250, 88, 116}, 104))], [])*/PROPERTYKEY(GUID("56A3372E-CE9C-11D2-9F0E-006097C686F6"), 12),
    PKEY_Music_Mood               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1795060791, 39885, 18887, 128, 254, 74, 92, 101, 250, 88, 116}, 104))], [])*/PROPERTYKEY(GUID("56A3372E-CE9C-11D2-9F0E-006097C686F6"), 39),
    PKEY_Music_PartOfSet          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1795060791, 39885, 18887, 128, 254, 74, 92, 101, 250, 88, 116}, 104))], [])*/PROPERTYKEY(GUID("56A3372E-CE9C-11D2-9F0E-006097C686F6"), 37),
    PKEY_Music_Period             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1795060791, 39885, 18887, 128, 254, 74, 92, 101, 250, 88, 116}, 104))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 31),
    PKEY_Music_SynchronizedLyrics = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1795060791, 39885, 18887, 128, 254, 74, 92, 101, 250, 88, 116}, 104))], [])*/PROPERTYKEY(GUID("6B223B6A-162E-4AA9-B39F-05D678FC6D77"), 100),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1453537070, 52892, 4562, 159, 14, 0, 96, 151, 198, 134, 246}, 7))], [])*/PROPERTYKEY PKEY_Music_TrackNumber = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1453537070, 52892, 4562, 159, 14, 0, 96, 151, 198, 134, 246}, 7))], [])*/PROPERTYKEY(GUID("56A3372E-CE9C-11D2-9F0E-006097C686F6"), 7);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1198967546, 48356, 19633, 162, 62, 38, 94, 118, 216, 235, 17}, 100))], [])*/PROPERTYKEY
{
    PKEY_Note_Color     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1198967546, 48356, 19633, 162, 62, 38, 94, 118, 216, 235, 17}, 100))], [])*/PROPERTYKEY(GUID("4776CAFA-BCE4-4CB1-A23E-265E76D8EB11"), 100),
    PKEY_Note_ColorText = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1198967546, 48356, 19633, 162, 62, 38, 94, 118, 216, 235, 17}, 100))], [])*/PROPERTYKEY(GUID("46B4E8DE-CDB2-440D-885C-1658EB65B914"), 100),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 37378))], [])*/PROPERTYKEY
{
    PKEY_Photo_Aperture            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 37378))], [])*/PROPERTYKEY(GUID("14B81DA1-0135-4D31-96D9-6CBFC9671A99"), 37378),
    PKEY_Photo_ApertureDenominator = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 37378))], [])*/PROPERTYKEY(GUID("E1A9A38B-6685-46BD-875E-570DC7AD7320"), 100),
    PKEY_Photo_ApertureNumerator   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 37378))], [])*/PROPERTYKEY(GUID("0337ECEC-39FB-4581-A0BD-4C4CC51E9914"), 100),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({443554806, 18316, 17249, 131, 171, 55, 1, 187, 5, 60, 88}, 100))], [])*/PROPERTYKEY
{
    PKEY_Photo_Brightness            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({443554806, 18316, 17249, 131, 171, 55, 1, 187, 5, 60, 88}, 100))], [])*/PROPERTYKEY(GUID("1A701BF6-478C-4361-83AB-3701BB053C58"), 100),
    PKEY_Photo_BrightnessDenominator = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({443554806, 18316, 17249, 131, 171, 55, 1, 187, 5, 60, 88}, 100))], [])*/PROPERTYKEY(GUID("6EBE6946-2321-440A-90F0-C043EFD32476"), 100),
    PKEY_Photo_BrightnessNumerator   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({443554806, 18316, 17249, 131, 171, 55, 1, 187, 5, 60, 88}, 100))], [])*/PROPERTYKEY(GUID("9E7D118F-B314-45A0-8CFB-D654B917C9E9"), 100),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 271))], [])*/PROPERTYKEY
{
    PKEY_Photo_CameraManufacturer = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 271))], [])*/PROPERTYKEY(GUID("14B81DA1-0135-4D31-96D9-6CBFC9671A99"), 271),
    PKEY_Photo_CameraModel        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 271))], [])*/PROPERTYKEY(GUID("14B81DA1-0135-4D31-96D9-6CBFC9671A99"), 272),
    PKEY_Photo_CameraSerialNumber = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 271))], [])*/PROPERTYKEY(GUID("14B81DA1-0135-4D31-96D9-6CBFC9671A99"), 273),
    PKEY_Photo_Contrast           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 271))], [])*/PROPERTYKEY(GUID("2A785BA9-8D23-4DED-82E6-60A350C86A10"), 100),
}

enum : uint
{
    PHOTO_CONTRAST_NORMAL = 0x00000000U,
    PHOTO_CONTRAST_SOFT   = 0x00000001U,
    PHOTO_CONTRAST_HARD   = 0x00000002U,
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1507715570, 21075, 16618, 154, 139, 71, 158, 150, 198, 36, 154}, 100))], [])*/PROPERTYKEY
{
    PKEY_Photo_ContrastText           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1507715570, 21075, 16618, 154, 139, 71, 158, 150, 198, 36, 154}, 100))], [])*/PROPERTYKEY(GUID("59DDE9F2-5253-40EA-9A8B-479E96C6249A"), 100),
    PKEY_Photo_DateTaken              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1507715570, 21075, 16618, 154, 139, 71, 158, 150, 198, 36, 154}, 100))], [])*/PROPERTYKEY(GUID("14B81DA1-0135-4D31-96D9-6CBFC9671A99"), 36867),
    PKEY_Photo_DigitalZoom            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1507715570, 21075, 16618, 154, 139, 71, 158, 150, 198, 36, 154}, 100))], [])*/PROPERTYKEY(GUID("F85BF840-A925-4BC2-B0C4-8E36B598679E"), 100),
    PKEY_Photo_DigitalZoomDenominator = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1507715570, 21075, 16618, 154, 139, 71, 158, 150, 198, 36, 154}, 100))], [])*/PROPERTYKEY(GUID("745BAF0E-E5C1-4CFB-8A1B-D031A0A52393"), 100),
    PKEY_Photo_DigitalZoomNumerator   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1507715570, 21075, 16618, 154, 139, 71, 158, 150, 198, 36, 154}, 100))], [])*/PROPERTYKEY(GUID("16CBB924-6500-473B-A5BE-F1599BCBE413"), 100),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 18248))], [])*/PROPERTYKEY
{
    PKEY_Photo_Event                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 18248))], [])*/PROPERTYKEY(GUID("14B81DA1-0135-4D31-96D9-6CBFC9671A99"), 18248),
    PKEY_Photo_EXIFVersion              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 18248))], [])*/PROPERTYKEY(GUID("D35F743A-EB2E-47F2-A286-844132CB1427"), 100),
    PKEY_Photo_ExposureBias             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 18248))], [])*/PROPERTYKEY(GUID("14B81DA1-0135-4D31-96D9-6CBFC9671A99"), 37380),
    PKEY_Photo_ExposureBiasDenominator  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 18248))], [])*/PROPERTYKEY(GUID("AB205E50-04B7-461C-A18C-2F233836E627"), 100),
    PKEY_Photo_ExposureBiasNumerator    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 18248))], [])*/PROPERTYKEY(GUID("738BF284-1D87-420B-92CF-5834BF6EF9ED"), 100),
    PKEY_Photo_ExposureIndex            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 18248))], [])*/PROPERTYKEY(GUID("967B5AF8-995A-46ED-9E11-35B3C5B9782D"), 100),
    PKEY_Photo_ExposureIndexDenominator = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 18248))], [])*/PROPERTYKEY(GUID("93112F89-C28B-492F-8A9D-4BE2062CEE8A"), 100),
    PKEY_Photo_ExposureIndexNumerator   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 18248))], [])*/PROPERTYKEY(GUID("CDEDCF30-8919-44DF-8F4C-4EB2FFDB8D89"), 100),
    PKEY_Photo_ExposureProgram          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 18248))], [])*/PROPERTYKEY(GUID("14B81DA1-0135-4D31-96D9-6CBFC9671A99"), 34850),
}

enum : uint
{
    PHOTO_EXPOSUREPROGRAM_UNKNOWN   = 0x00000000U,
    PHOTO_EXPOSUREPROGRAM_MANUAL    = 0x00000001U,
    PHOTO_EXPOSUREPROGRAM_NORMAL    = 0x00000002U,
    PHOTO_EXPOSUREPROGRAM_APERTURE  = 0x00000003U,
    PHOTO_EXPOSUREPROGRAM_SHUTTER   = 0x00000004U,
    PHOTO_EXPOSUREPROGRAM_CREATIVE  = 0x00000005U,
    PHOTO_EXPOSUREPROGRAM_ACTION    = 0x00000006U,
    PHOTO_EXPOSUREPROGRAM_PORTRAIT  = 0x00000007U,
    PHOTO_EXPOSUREPROGRAM_LANDSCAPE = 0x00000008U,
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4274426039, 24368, 17990, 174, 71, 76, 170, 251, 168, 132, 163}, 100))], [])*/PROPERTYKEY
{
    PKEY_Photo_ExposureProgramText     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4274426039, 24368, 17990, 174, 71, 76, 170, 251, 168, 132, 163}, 100))], [])*/PROPERTYKEY(GUID("FEC690B7-5F30-4646-AE47-4CAAFBA884A3"), 100),
    PKEY_Photo_ExposureTime            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4274426039, 24368, 17990, 174, 71, 76, 170, 251, 168, 132, 163}, 100))], [])*/PROPERTYKEY(GUID("14B81DA1-0135-4D31-96D9-6CBFC9671A99"), 33434),
    PKEY_Photo_ExposureTimeDenominator = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4274426039, 24368, 17990, 174, 71, 76, 170, 251, 168, 132, 163}, 100))], [])*/PROPERTYKEY(GUID("55E98597-AD16-42E0-B624-21599A199838"), 100),
    PKEY_Photo_ExposureTimeNumerator   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4274426039, 24368, 17990, 174, 71, 76, 170, 251, 168, 132, 163}, 100))], [])*/PROPERTYKEY(GUID("257E44E2-9031-4323-AC38-85C552871B2E"), 100),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 37385))], [])*/PROPERTYKEY PKEY_Photo_Flash = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 37385))], [])*/PROPERTYKEY(GUID("14B81DA1-0135-4D31-96D9-6CBFC9671A99"), 37385);

enum : uint
{
    PHOTO_FLASH_NONE                           = 0x00000000U,
    PHOTO_FLASH_FLASH                          = 0x00000001U,
    PHOTO_FLASH_WITHOUTSTROBE                  = 0x00000005U,
    PHOTO_FLASH_WITHSTROBE                     = 0x00000007U,
    PHOTO_FLASH_FLASH_COMPULSORY               = 0x00000009U,
    PHOTO_FLASH_FLASH_COMPULSORY_NORETURNLIGHT = 0x0000000dU,
    PHOTO_FLASH_FLASH_COMPULSORY_RETURNLIGHT   = 0x0000000fU,
}

enum : uint
{
    PHOTO_FLASH_NONE_COMPULSORY          = 0x00000010U,
    PHOTO_FLASH_NONE_AUTO                = 0x00000018U,
    PHOTO_FLASH_FLASH_AUTO               = 0x00000019U,
    PHOTO_FLASH_FLASH_AUTO_NORETURNLIGHT = 0x0000001dU,
    PHOTO_FLASH_FLASH_AUTO_RETURNLIGHT   = 0x0000001fU,
}

enum : uint
{
    PHOTO_FLASH_NOFUNCTION                            = 0x00000020U,
    PHOTO_FLASH_FLASH_REDEYE                          = 0x00000041U,
    PHOTO_FLASH_FLASH_REDEYE_NORETURNLIGHT            = 0x00000045U,
    PHOTO_FLASH_FLASH_REDEYE_RETURNLIGHT              = 0x00000047U,
    PHOTO_FLASH_FLASH_COMPULSORY_REDEYE               = 0x00000049U,
    PHOTO_FLASH_FLASH_COMPULSORY_REDEYE_NORETURNLIGHT = 0x0000004dU,
    PHOTO_FLASH_FLASH_COMPULSORY_REDEYE_RETURNLIGHT   = 0x0000004fU,
}

enum : uint
{
    PHOTO_FLASH_FLASH_AUTO_REDEYE               = 0x00000059U,
    PHOTO_FLASH_FLASH_AUTO_REDEYE_NORETURNLIGHT = 0x0000005dU,
    PHOTO_FLASH_FLASH_AUTO_REDEYE_RETURNLIGHT   = 0x0000005fU,
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 41483))], [])*/PROPERTYKEY
{
    PKEY_Photo_FlashEnergy                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 41483))], [])*/PROPERTYKEY(GUID("14B81DA1-0135-4D31-96D9-6CBFC9671A99"), 41483),
    PKEY_Photo_FlashEnergyDenominator           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 41483))], [])*/PROPERTYKEY(GUID("D7B61C70-6323-49CD-A5FC-C84277162C97"), 100),
    PKEY_Photo_FlashEnergyNumerator             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 41483))], [])*/PROPERTYKEY(GUID("FCAD3D3D-0858-400F-AAA3-2F66CCE2A6BC"), 100),
    PKEY_Photo_FlashManufacturer                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 41483))], [])*/PROPERTYKEY(GUID("AABAF6C9-E0C5-4719-8585-57B103E584FE"), 100),
    PKEY_Photo_FlashModel                       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 41483))], [])*/PROPERTYKEY(GUID("FE83BB35-4D1A-42E2-916B-06F3E1AF719E"), 100),
    PKEY_Photo_FlashText                        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 41483))], [])*/PROPERTYKEY(GUID("6B8B68F6-200B-47EA-8D25-D8050F57339F"), 100),
    PKEY_Photo_FNumber                          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 41483))], [])*/PROPERTYKEY(GUID("14B81DA1-0135-4D31-96D9-6CBFC9671A99"), 33437),
    PKEY_Photo_FNumberDenominator               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 41483))], [])*/PROPERTYKEY(GUID("E92A2496-223B-4463-A4E3-30EABBA79D80"), 100),
    PKEY_Photo_FNumberNumerator                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 41483))], [])*/PROPERTYKEY(GUID("1B97738A-FDFC-462F-9D93-1957E08BE90C"), 100),
    PKEY_Photo_FocalLength                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 41483))], [])*/PROPERTYKEY(GUID("14B81DA1-0135-4D31-96D9-6CBFC9671A99"), 37386),
    PKEY_Photo_FocalLengthDenominator           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 41483))], [])*/PROPERTYKEY(GUID("305BC615-DCA1-44A5-9FD4-10C0BA79412E"), 100),
    PKEY_Photo_FocalLengthInFilm                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 41483))], [])*/PROPERTYKEY(GUID("A0E74609-B84D-4F49-B860-462BD9971F98"), 100),
    PKEY_Photo_FocalLengthNumerator             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 41483))], [])*/PROPERTYKEY(GUID("776B6B3B-1E3D-4B0C-9A0E-8FBAF2A8492A"), 100),
    PKEY_Photo_FocalPlaneXResolution            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 41483))], [])*/PROPERTYKEY(GUID("CFC08D97-C6F7-4484-89DD-EBEF4356FE76"), 100),
    PKEY_Photo_FocalPlaneXResolutionDenominator = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 41483))], [])*/PROPERTYKEY(GUID("0933F3F5-4786-4F46-A8E8-D64DD37FA521"), 100),
    PKEY_Photo_FocalPlaneXResolutionNumerator   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 41483))], [])*/PROPERTYKEY(GUID("DCCB10AF-B4E2-4B88-95F9-031B4D5AB490"), 100),
    PKEY_Photo_FocalPlaneYResolution            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 41483))], [])*/PROPERTYKEY(GUID("4FFFE4D0-914F-4AC4-8D6F-C9C61DE169B1"), 100),
    PKEY_Photo_FocalPlaneYResolutionDenominator = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 41483))], [])*/PROPERTYKEY(GUID("1D6179A6-A876-4031-B013-3347B2B64DC8"), 100),
    PKEY_Photo_FocalPlaneYResolutionNumerator   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 41483))], [])*/PROPERTYKEY(GUID("A2E541C5-4440-4BA8-867E-75CFC06828CD"), 100),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4197468041, 199, 19840, 144, 74, 30, 77, 204, 114, 101, 170}, 100))], [])*/PROPERTYKEY PKEY_Photo_GainControl = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4197468041, 199, 19840, 144, 74, 30, 77, 204, 114, 101, 170}, 100))], [])*/PROPERTYKEY(GUID("FA304789-00C7-4D80-904A-1E4DCC7265AA"), 100);

enum : double
{
    PHOTO_GAINCONTROL_NONE         = 0x0p+0,
    PHOTO_GAINCONTROL_LOWGAINUP    = 0x1p+0,
    PHOTO_GAINCONTROL_HIGHGAINUP   = 0x1p+1,
    PHOTO_GAINCONTROL_LOWGAINDOWN  = 0x1.8p+1,
    PHOTO_GAINCONTROL_HIGHGAINDOWN = 0x1p+2,
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1116098045, 40356, 20343, 189, 237, 74, 173, 123, 37, 103, 53}, 100))], [])*/PROPERTYKEY
{
    PKEY_Photo_GainControlDenominator = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1116098045, 40356, 20343, 189, 237, 74, 173, 123, 37, 103, 53}, 100))], [])*/PROPERTYKEY(GUID("42864DFD-9DA4-4F77-BDED-4AAD7B256735"), 100),
    PKEY_Photo_GainControlNumerator   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1116098045, 40356, 20343, 189, 237, 74, 173, 123, 37, 103, 53}, 100))], [])*/PROPERTYKEY(GUID("8E8ECF7C-B7B8-4EB8-A63F-0EE715C96F9E"), 100),
    PKEY_Photo_GainControlText        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1116098045, 40356, 20343, 189, 237, 74, 173, 123, 37, 103, 53}, 100))], [])*/PROPERTYKEY(GUID("C06238B2-0BF9-4279-A723-25856715CB9D"), 100),
    PKEY_Photo_ISOSpeed               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1116098045, 40356, 20343, 189, 237, 74, 173, 123, 37, 103, 53}, 100))], [])*/PROPERTYKEY(GUID("14B81DA1-0135-4D31-96D9-6CBFC9671A99"), 34855),
    PKEY_Photo_LensManufacturer       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1116098045, 40356, 20343, 189, 237, 74, 173, 123, 37, 103, 53}, 100))], [])*/PROPERTYKEY(GUID("E6DDCAF7-29C5-4F0A-9A68-D19412EC7090"), 100),
    PKEY_Photo_LensModel              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1116098045, 40356, 20343, 189, 237, 74, 173, 123, 37, 103, 53}, 100))], [])*/PROPERTYKEY(GUID("E1277516-2B5F-4869-89B1-2E585BD38B7A"), 100),
    PKEY_Photo_LightSource            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1116098045, 40356, 20343, 189, 237, 74, 173, 123, 37, 103, 53}, 100))], [])*/PROPERTYKEY(GUID("14B81DA1-0135-4D31-96D9-6CBFC9671A99"), 37384),
}

enum : uint
{
    PHOTO_LIGHTSOURCE_UNKNOWN     = 0x00000000U,
    PHOTO_LIGHTSOURCE_DAYLIGHT    = 0x00000001U,
    PHOTO_LIGHTSOURCE_FLUORESCENT = 0x00000002U,
    PHOTO_LIGHTSOURCE_TUNGSTEN    = 0x00000003U,
    PHOTO_LIGHTSOURCE_STANDARD_A  = 0x00000011U,
    PHOTO_LIGHTSOURCE_STANDARD_B  = 0x00000012U,
    PHOTO_LIGHTSOURCE_STANDARD_C  = 0x00000013U,
    PHOTO_LIGHTSOURCE_D55         = 0x00000014U,
    PHOTO_LIGHTSOURCE_D65         = 0x00000015U,
    PHOTO_LIGHTSOURCE_D75         = 0x00000016U,
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4197462867, 46681, 16466, 133, 233, 188, 172, 121, 84, 155, 132}, 100))], [])*/PROPERTYKEY
{
    PKEY_Photo_MakerNote              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4197462867, 46681, 16466, 133, 233, 188, 172, 121, 84, 155, 132}, 100))], [])*/PROPERTYKEY(GUID("FA303353-B659-4052-85E9-BCAC79549B84"), 100),
    PKEY_Photo_MakerNoteOffset        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4197462867, 46681, 16466, 133, 233, 188, 172, 121, 84, 155, 132}, 100))], [])*/PROPERTYKEY(GUID("813F4124-34E6-4D17-AB3E-6B1F3C2247A1"), 100),
    PKEY_Photo_MaxAperture            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4197462867, 46681, 16466, 133, 233, 188, 172, 121, 84, 155, 132}, 100))], [])*/PROPERTYKEY(GUID("08F6D7C2-E3F2-44FC-AF1E-5AA5C81A2D3E"), 100),
    PKEY_Photo_MaxApertureDenominator = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4197462867, 46681, 16466, 133, 233, 188, 172, 121, 84, 155, 132}, 100))], [])*/PROPERTYKEY(GUID("C77724D4-601F-46C5-9B89-C53F93BCEB77"), 100),
    PKEY_Photo_MaxApertureNumerator   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4197462867, 46681, 16466, 133, 233, 188, 172, 121, 84, 155, 132}, 100))], [])*/PROPERTYKEY(GUID("C107E191-A459-44C5-9AE6-B952AD4B906D"), 100),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 37383))], [])*/PROPERTYKEY
{
    PKEY_Photo_MeteringMode                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 37383))], [])*/PROPERTYKEY(GUID("14B81DA1-0135-4D31-96D9-6CBFC9671A99"), 37383),
    PKEY_Photo_MeteringModeText              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 37383))], [])*/PROPERTYKEY(GUID("F628FD8C-7BA8-465A-A65B-C5AA79263A9E"), 100),
    PKEY_Photo_Orientation                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 37383))], [])*/PROPERTYKEY(GUID("14B81DA1-0135-4D31-96D9-6CBFC9671A99"), 274),
    PKEY_Photo_OrientationText               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 37383))], [])*/PROPERTYKEY(GUID("A9EA193C-C511-498A-A06B-58E2776DCC28"), 100),
    PKEY_Photo_PeopleNames                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 37383))], [])*/PROPERTYKEY(GUID("E8309B6E-084C-49B4-B1FC-90A80331B638"), 100),
    PKEY_Photo_PhotometricInterpretation     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 37383))], [])*/PROPERTYKEY(GUID("341796F1-1DF9-4B1C-A564-91BDEFA43877"), 100),
    PKEY_Photo_PhotometricInterpretationText = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 37383))], [])*/PROPERTYKEY(GUID("821437D6-9EAB-4765-A589-3B1CBBD22A61"), 100),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1830911853, 16234, 18469, 180, 112, 95, 3, 202, 47, 190, 155}, 100))], [])*/PROPERTYKEY PKEY_Photo_ProgramMode = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1830911853, 16234, 18469, 180, 112, 95, 3, 202, 47, 190, 155}, 100))], [])*/PROPERTYKEY(GUID("6D217F6D-3F6A-4825-B470-5F03CA2FBE9B"), 100);

enum : uint
{
    PHOTO_PROGRAMMODE_NOTDEFINED = 0x00000000U,
    PHOTO_PROGRAMMODE_MANUAL     = 0x00000001U,
    PHOTO_PROGRAMMODE_NORMAL     = 0x00000002U,
    PHOTO_PROGRAMMODE_APERTURE   = 0x00000003U,
    PHOTO_PROGRAMMODE_SHUTTER    = 0x00000004U,
    PHOTO_PROGRAMMODE_CREATIVE   = 0x00000005U,
    PHOTO_PROGRAMMODE_ACTION     = 0x00000006U,
    PHOTO_PROGRAMMODE_PORTRAIT   = 0x00000007U,
    PHOTO_PROGRAMMODE_LANDSCAPE  = 0x00000008U,
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2145626663, 9800, 17139, 137, 176, 69, 78, 92, 177, 80, 195}, 100))], [])*/PROPERTYKEY
{
    PKEY_Photo_ProgramModeText  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2145626663, 9800, 17139, 137, 176, 69, 78, 92, 177, 80, 195}, 100))], [])*/PROPERTYKEY(GUID("7FE3AA27-2648-42F3-89B0-454E5CB150C3"), 100),
    PKEY_Photo_RelatedSoundFile = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2145626663, 9800, 17139, 137, 176, 69, 78, 92, 177, 80, 195}, 100))], [])*/PROPERTYKEY(GUID("318A6B45-087F-4DC2-B8CC-05359551FC9E"), 100),
    PKEY_Photo_Saturation       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2145626663, 9800, 17139, 137, 176, 69, 78, 92, 177, 80, 195}, 100))], [])*/PROPERTYKEY(GUID("49237325-A95A-4F67-B211-816B2D45D2E0"), 100),
}

enum : uint
{
    PHOTO_SATURATION_NORMAL = 0x00000000U,
    PHOTO_SATURATION_LOW    = 0x00000001U,
    PHOTO_SATURATION_HIGH   = 0x00000002U,
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1632078856, 46592, 19076, 187, 228, 233, 156, 69, 240, 160, 114}, 100))], [])*/PROPERTYKEY
{
    PKEY_Photo_SaturationText = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1632078856, 46592, 19076, 187, 228, 233, 156, 69, 240, 160, 114}, 100))], [])*/PROPERTYKEY(GUID("61478C08-B600-4A84-BBE4-E99C45F0A072"), 100),
    PKEY_Photo_Sharpness      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1632078856, 46592, 19076, 187, 228, 233, 156, 69, 240, 160, 114}, 100))], [])*/PROPERTYKEY(GUID("FC6976DB-8349-4970-AE97-B3C5316A08F0"), 100),
}

enum : uint
{
    PHOTO_SHARPNESS_NORMAL = 0x00000000U,
    PHOTO_SHARPNESS_SOFT   = 0x00000001U,
    PHOTO_SHARPNESS_HARD   = 0x00000002U,
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1374437191, 56656, 16925, 135, 105, 51, 79, 80, 66, 75, 30}, 100))], [])*/PROPERTYKEY
{
    PKEY_Photo_SharpnessText           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1374437191, 56656, 16925, 135, 105, 51, 79, 80, 66, 75, 30}, 100))], [])*/PROPERTYKEY(GUID("51EC3F47-DD50-421D-8769-334F50424B1E"), 100),
    PKEY_Photo_ShutterSpeed            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1374437191, 56656, 16925, 135, 105, 51, 79, 80, 66, 75, 30}, 100))], [])*/PROPERTYKEY(GUID("14B81DA1-0135-4D31-96D9-6CBFC9671A99"), 37377),
    PKEY_Photo_ShutterSpeedDenominator = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1374437191, 56656, 16925, 135, 105, 51, 79, 80, 66, 75, 30}, 100))], [])*/PROPERTYKEY(GUID("E13D8975-81C7-4948-AE3F-37CAE11E8FF7"), 100),
    PKEY_Photo_ShutterSpeedNumerator   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1374437191, 56656, 16925, 135, 105, 51, 79, 80, 66, 75, 30}, 100))], [])*/PROPERTYKEY(GUID("16EA4042-D6F4-4BCA-8349-7C78D30FB333"), 100),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 37382))], [])*/PROPERTYKEY
{
    PKEY_Photo_SubjectDistance            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 37382))], [])*/PROPERTYKEY(GUID("14B81DA1-0135-4D31-96D9-6CBFC9671A99"), 37382),
    PKEY_Photo_SubjectDistanceDenominator = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 37382))], [])*/PROPERTYKEY(GUID("0C840A88-B043-466D-9766-D4B26DA3FA77"), 100),
    PKEY_Photo_SubjectDistanceNumerator   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({347610529, 309, 19761, 150, 217, 108, 191, 201, 103, 26, 153}, 37382))], [])*/PROPERTYKEY(GUID("8AF4961C-F526-43E5-AA81-DB768219178D"), 100),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3088249181, 49880, 19391, 186, 205, 121, 116, 67, 70, 17, 63}, 100))], [])*/PROPERTYKEY
{
    PKEY_Photo_TagViewAggregate  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3088249181, 49880, 19391, 186, 205, 121, 116, 67, 70, 17, 63}, 100))], [])*/PROPERTYKEY(GUID("B812F15D-C2D8-4BBF-BACD-79744346113F"), 100),
    PKEY_Photo_TranscodedForSync = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3088249181, 49880, 19391, 186, 205, 121, 116, 67, 70, 17, 63}, 100))], [])*/PROPERTYKEY(GUID("9A8EBB75-6458-4E82-BACB-35C0095B03BB"), 100),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3996990858, 21377, 19706, 177, 59, 170, 246, 107, 95, 78, 201}, 100))], [])*/PROPERTYKEY PKEY_Photo_WhiteBalance = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3996990858, 21377, 19706, 177, 59, 170, 246, 107, 95, 78, 201}, 100))], [])*/PROPERTYKEY(GUID("EE3D3D8A-5381-4CFA-B13B-AAF66B5F4EC9"), 100);

enum : uint
{
    PHOTO_WHITEBALANCE_AUTO   = 0x00000000U,
    PHOTO_WHITEBALANCE_MANUAL = 0x00000001U,
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1664530782, 51111, 17005, 134, 253, 122, 227, 211, 156, 132, 180}, 100))], [])*/PROPERTYKEY PKEY_Photo_WhiteBalanceText = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1664530782, 51111, 17005, 134, 253, 122, 227, 211, 156, 132, 180}, 100))], [])*/PROPERTYKEY(GUID("6336B95E-C7A7-426D-86FD-7AE3D39C84B4"), 100);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2416590907, 2427, 19349, 138, 226, 7, 31, 218, 238, 177, 24}, 100))], [])*/PROPERTYKEY
{
    PKEY_PropGroup_Advanced      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2416590907, 2427, 19349, 138, 226, 7, 31, 218, 238, 177, 24}, 100))], [])*/PROPERTYKEY(GUID("900A403B-097B-4B95-8AE2-071FDAEEB118"), 100),
    PKEY_PropGroup_Audio         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2416590907, 2427, 19349, 138, 226, 7, 31, 218, 238, 177, 24}, 100))], [])*/PROPERTYKEY(GUID("2804D469-788F-48AA-8570-71B9C187E138"), 100),
    PKEY_PropGroup_Calendar      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2416590907, 2427, 19349, 138, 226, 7, 31, 218, 238, 177, 24}, 100))], [])*/PROPERTYKEY(GUID("9973D2B5-BFD8-438A-BA94-5349B293181A"), 100),
    PKEY_PropGroup_Camera        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2416590907, 2427, 19349, 138, 226, 7, 31, 218, 238, 177, 24}, 100))], [])*/PROPERTYKEY(GUID("DE00DE32-547E-4981-AD4B-542F2E9007D8"), 100),
    PKEY_PropGroup_Contact       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2416590907, 2427, 19349, 138, 226, 7, 31, 218, 238, 177, 24}, 100))], [])*/PROPERTYKEY(GUID("DF975FD3-250A-4004-858F-34E29A3E37AA"), 100),
    PKEY_PropGroup_Content       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2416590907, 2427, 19349, 138, 226, 7, 31, 218, 238, 177, 24}, 100))], [])*/PROPERTYKEY(GUID("D0DAB0BA-368A-4050-A882-6C010FD19A4F"), 100),
    PKEY_PropGroup_Description   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2416590907, 2427, 19349, 138, 226, 7, 31, 218, 238, 177, 24}, 100))], [])*/PROPERTYKEY(GUID("8969B275-9475-4E00-A887-FF93B8B41E44"), 100),
    PKEY_PropGroup_FileSystem    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2416590907, 2427, 19349, 138, 226, 7, 31, 218, 238, 177, 24}, 100))], [])*/PROPERTYKEY(GUID("E3A7D2C1-80FC-4B40-8F34-30EA111BDC2E"), 100),
    PKEY_PropGroup_General       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2416590907, 2427, 19349, 138, 226, 7, 31, 218, 238, 177, 24}, 100))], [])*/PROPERTYKEY(GUID("CC301630-B192-4C22-B372-9F4C6D338E07"), 100),
    PKEY_PropGroup_GPS           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2416590907, 2427, 19349, 138, 226, 7, 31, 218, 238, 177, 24}, 100))], [])*/PROPERTYKEY(GUID("F3713ADA-90E3-4E11-AAE5-FDC17685B9BE"), 100),
    PKEY_PropGroup_Image         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2416590907, 2427, 19349, 138, 226, 7, 31, 218, 238, 177, 24}, 100))], [])*/PROPERTYKEY(GUID("E3690A87-0FA8-4A2A-9A9F-FCE8827055AC"), 100),
    PKEY_PropGroup_Media         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2416590907, 2427, 19349, 138, 226, 7, 31, 218, 238, 177, 24}, 100))], [])*/PROPERTYKEY(GUID("61872CF7-6B5E-4B4B-AC2D-59DA84459248"), 100),
    PKEY_PropGroup_MediaAdvanced = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2416590907, 2427, 19349, 138, 226, 7, 31, 218, 238, 177, 24}, 100))], [])*/PROPERTYKEY(GUID("8859A284-DE7E-4642-99BA-D431D044B1EC"), 100),
    PKEY_PropGroup_Message       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2416590907, 2427, 19349, 138, 226, 7, 31, 218, 238, 177, 24}, 100))], [])*/PROPERTYKEY(GUID("7FD7259D-16B4-4135-9F97-7C96ECD2FA9E"), 100),
    PKEY_PropGroup_Music         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2416590907, 2427, 19349, 138, 226, 7, 31, 218, 238, 177, 24}, 100))], [])*/PROPERTYKEY(GUID("68DD6094-7216-40F1-A029-43FE7127043F"), 100),
    PKEY_PropGroup_Origin        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2416590907, 2427, 19349, 138, 226, 7, 31, 218, 238, 177, 24}, 100))], [])*/PROPERTYKEY(GUID("2598D2FB-5569-4367-95DF-5CD3A177E1A5"), 100),
    PKEY_PropGroup_PhotoAdvanced = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2416590907, 2427, 19349, 138, 226, 7, 31, 218, 238, 177, 24}, 100))], [])*/PROPERTYKEY(GUID("0CB2BF5A-9EE7-4A86-8222-F01E07FDADAF"), 100),
    PKEY_PropGroup_RecordedTV    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2416590907, 2427, 19349, 138, 226, 7, 31, 218, 238, 177, 24}, 100))], [])*/PROPERTYKEY(GUID("E7B33238-6584-4170-A5C0-AC25EFD9DA56"), 100),
    PKEY_PropGroup_Video         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2416590907, 2427, 19349, 138, 226, 7, 31, 218, 238, 177, 24}, 100))], [])*/PROPERTYKEY(GUID("BEBE0920-7671-4C54-A3EB-49FDDFC191EE"), 100),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3381938721, 41990, 18686, 130, 37, 174, 199, 226, 76, 33, 27}, 17))], [])*/PROPERTYKEY PKEY_InfoTipText = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3381938721, 41990, 18686, 130, 37, 174, 199, 226, 76, 33, 27}, 17))], [])*/PROPERTYKEY(GUID("C9944A21-A406-48FE-8225-AEC7E24C211B"), 17);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3381938721, 41990, 18686, 130, 37, 174, 199, 226, 76, 33, 27}, 11))], [])*/PROPERTYKEY
{
    PKEY_PropList_ConflictPrompt           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3381938721, 41990, 18686, 130, 37, 174, 199, 226, 76, 33, 27}, 11))], [])*/PROPERTYKEY(GUID("C9944A21-A406-48FE-8225-AEC7E24C211B"), 11),
    PKEY_PropList_ContentViewModeForBrowse = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3381938721, 41990, 18686, 130, 37, 174, 199, 226, 76, 33, 27}, 11))], [])*/PROPERTYKEY(GUID("C9944A21-A406-48FE-8225-AEC7E24C211B"), 13),
    PKEY_PropList_ContentViewModeForSearch = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3381938721, 41990, 18686, 130, 37, 174, 199, 226, 76, 33, 27}, 11))], [])*/PROPERTYKEY(GUID("C9944A21-A406-48FE-8225-AEC7E24C211B"), 14),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3381938721, 41990, 18686, 130, 37, 174, 199, 226, 76, 33, 27}, 9))], [])*/PROPERTYKEY
{
    PKEY_PropList_ExtendedTileInfo    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3381938721, 41990, 18686, 130, 37, 174, 199, 226, 76, 33, 27}, 9))], [])*/PROPERTYKEY(GUID("C9944A21-A406-48FE-8225-AEC7E24C211B"), 9),
    PKEY_PropList_FileOperationPrompt = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3381938721, 41990, 18686, 130, 37, 174, 199, 226, 76, 33, 27}, 9))], [])*/PROPERTYKEY(GUID("C9944A21-A406-48FE-8225-AEC7E24C211B"), 10),
    PKEY_PropList_FullDetails         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3381938721, 41990, 18686, 130, 37, 174, 199, 226, 76, 33, 27}, 9))], [])*/PROPERTYKEY(GUID("C9944A21-A406-48FE-8225-AEC7E24C211B"), 2),
    PKEY_PropList_InfoTip             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3381938721, 41990, 18686, 130, 37, 174, 199, 226, 76, 33, 27}, 9))], [])*/PROPERTYKEY(GUID("C9944A21-A406-48FE-8225-AEC7E24C211B"), 4),
    PKEY_PropList_NonPersonal         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3381938721, 41990, 18686, 130, 37, 174, 199, 226, 76, 33, 27}, 9))], [])*/PROPERTYKEY(GUID("49D1091F-082E-493F-B23F-D2308AA9668C"), 100),
    PKEY_PropList_PreviewDetails      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3381938721, 41990, 18686, 130, 37, 174, 199, 226, 76, 33, 27}, 9))], [])*/PROPERTYKEY(GUID("C9944A21-A406-48FE-8225-AEC7E24C211B"), 8),
    PKEY_PropList_PreviewTitle        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3381938721, 41990, 18686, 130, 37, 174, 199, 226, 76, 33, 27}, 9))], [])*/PROPERTYKEY(GUID("C9944A21-A406-48FE-8225-AEC7E24C211B"), 6),
    PKEY_PropList_QuickTip            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3381938721, 41990, 18686, 130, 37, 174, 199, 226, 76, 33, 27}, 9))], [])*/PROPERTYKEY(GUID("C9944A21-A406-48FE-8225-AEC7E24C211B"), 5),
    PKEY_PropList_TileInfo            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3381938721, 41990, 18686, 130, 37, 174, 199, 226, 76, 33, 27}, 9))], [])*/PROPERTYKEY(GUID("C9944A21-A406-48FE-8225-AEC7E24C211B"), 3),
    PKEY_PropList_XPDetailsPanel      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3381938721, 41990, 18686, 130, 37, 174, 199, 226, 76, 33, 27}, 9))], [])*/PROPERTYKEY(GUID("F2275480-F782-4291-BD94-F13693513AEC"), 0),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1836355042, 36152, 19651, 172, 96, 240, 9, 176, 87, 197, 87}, 7))], [])*/PROPERTYKEY
{
    PKEY_RecordedTV_ChannelNumber               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1836355042, 36152, 19651, 172, 96, 240, 9, 176, 87, 197, 87}, 7))], [])*/PROPERTYKEY(GUID("6D748DE2-8D38-4CC3-AC60-F009B057C557"), 7),
    PKEY_RecordedTV_Credits                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1836355042, 36152, 19651, 172, 96, 240, 9, 176, 87, 197, 87}, 7))], [])*/PROPERTYKEY(GUID("6D748DE2-8D38-4CC3-AC60-F009B057C557"), 4),
    PKEY_RecordedTV_DateContentExpires          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1836355042, 36152, 19651, 172, 96, 240, 9, 176, 87, 197, 87}, 7))], [])*/PROPERTYKEY(GUID("6D748DE2-8D38-4CC3-AC60-F009B057C557"), 15),
    PKEY_RecordedTV_EpisodeName                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1836355042, 36152, 19651, 172, 96, 240, 9, 176, 87, 197, 87}, 7))], [])*/PROPERTYKEY(GUID("6D748DE2-8D38-4CC3-AC60-F009B057C557"), 2),
    PKEY_RecordedTV_IsATSCContent               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1836355042, 36152, 19651, 172, 96, 240, 9, 176, 87, 197, 87}, 7))], [])*/PROPERTYKEY(GUID("6D748DE2-8D38-4CC3-AC60-F009B057C557"), 16),
    PKEY_RecordedTV_IsClosedCaptioningAvailable = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1836355042, 36152, 19651, 172, 96, 240, 9, 176, 87, 197, 87}, 7))], [])*/PROPERTYKEY(GUID("6D748DE2-8D38-4CC3-AC60-F009B057C557"), 12),
    PKEY_RecordedTV_IsDTVContent                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1836355042, 36152, 19651, 172, 96, 240, 9, 176, 87, 197, 87}, 7))], [])*/PROPERTYKEY(GUID("6D748DE2-8D38-4CC3-AC60-F009B057C557"), 17),
    PKEY_RecordedTV_IsHDContent                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1836355042, 36152, 19651, 172, 96, 240, 9, 176, 87, 197, 87}, 7))], [])*/PROPERTYKEY(GUID("6D748DE2-8D38-4CC3-AC60-F009B057C557"), 18),
    PKEY_RecordedTV_IsRepeatBroadcast           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1836355042, 36152, 19651, 172, 96, 240, 9, 176, 87, 197, 87}, 7))], [])*/PROPERTYKEY(GUID("6D748DE2-8D38-4CC3-AC60-F009B057C557"), 13),
    PKEY_RecordedTV_IsSAP                       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1836355042, 36152, 19651, 172, 96, 240, 9, 176, 87, 197, 87}, 7))], [])*/PROPERTYKEY(GUID("6D748DE2-8D38-4CC3-AC60-F009B057C557"), 14),
    PKEY_RecordedTV_NetworkAffiliation          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1836355042, 36152, 19651, 172, 96, 240, 9, 176, 87, 197, 87}, 7))], [])*/PROPERTYKEY(GUID("2C53C813-FB63-4E22-A1AB-0B331CA1E273"), 100),
    PKEY_RecordedTV_OriginalBroadcastDate       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1836355042, 36152, 19651, 172, 96, 240, 9, 176, 87, 197, 87}, 7))], [])*/PROPERTYKEY(GUID("4684FE97-8765-4842-9C13-F006447B178C"), 100),
    PKEY_RecordedTV_ProgramDescription          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1836355042, 36152, 19651, 172, 96, 240, 9, 176, 87, 197, 87}, 7))], [])*/PROPERTYKEY(GUID("6D748DE2-8D38-4CC3-AC60-F009B057C557"), 3),
    PKEY_RecordedTV_RecordingTime               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1836355042, 36152, 19651, 172, 96, 240, 9, 176, 87, 197, 87}, 7))], [])*/PROPERTYKEY(GUID("A5477F61-7A82-4ECA-9DDE-98B69B2479B3"), 100),
    PKEY_RecordedTV_StationCallSign             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1836355042, 36152, 19651, 172, 96, 240, 9, 176, 87, 197, 87}, 7))], [])*/PROPERTYKEY(GUID("6D748DE2-8D38-4CC3-AC60-F009B057C557"), 5),
    PKEY_RecordedTV_StationName                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1836355042, 36152, 19651, 172, 96, 240, 9, 176, 87, 197, 87}, 7))], [])*/PROPERTYKEY(GUID("1B5439E7-EBA1-4AF8-BDD7-7AF1D4549493"), 100),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1657985451, 35684, 18829, 184, 101, 64, 45, 71, 150, 248, 101}, 3))], [])*/PROPERTYKEY PKEY_LocationEmptyString = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1657985451, 35684, 18829, 184, 101, 64, 45, 71, 150, 248, 101}, 3))], [])*/PROPERTYKEY(GUID("62D2D9AB-8B64-498D-B865-402D4796F865"), 3);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 31))], [])*/PROPERTYKEY
{
    PKEY_Search_AutoCategory       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 31))], [])*/PROPERTYKEY(GUID("B725F130-47EF-101A-A5F1-02608C9EEBAC"), 31),
    PKEY_Search_AutoSummary        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 31))], [])*/PROPERTYKEY(GUID("560C36C0-503A-11CF-BAA1-00004C752A9A"), 2),
    PKEY_Search_ContainerHash      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 31))], [])*/PROPERTYKEY(GUID("BCEEE283-35DF-4D53-826A-F36A3EEFC6BE"), 100),
    PKEY_Search_Contents           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 31))], [])*/PROPERTYKEY(GUID("B725F130-47EF-101A-A5F1-02608C9EEBAC"), 19),
    PKEY_Search_EntryID            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 31))], [])*/PROPERTYKEY(GUID("49691C90-7E17-101A-A91C-08002B2ECDA9"), 5),
    PKEY_Search_ExtendedProperties = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3072717104, 18415, 4122, 165, 241, 2, 96, 140, 158, 235, 172}, 31))], [])*/PROPERTYKEY(GUID("7B03B546-FA4F-4A52-A2FE-03D5311E5865"), 100),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({191095632, 40140, 4560, 188, 219, 0, 128, 95, 204, 206, 4}, 8))], [])*/PROPERTYKEY
{
    PKEY_Search_GatherTime        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({191095632, 40140, 4560, 188, 219, 0, 128, 95, 204, 206, 4}, 8))], [])*/PROPERTYKEY(GUID("0B63E350-9CCC-11D0-BCDB-00805FCCCE04"), 8),
    PKEY_Search_HitCount          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({191095632, 40140, 4560, 188, 219, 0, 128, 95, 204, 206, 4}, 8))], [])*/PROPERTYKEY(GUID("49691C90-7E17-101A-A91C-08002B2ECDA9"), 4),
    PKEY_Search_IsClosedDirectory = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({191095632, 40140, 4560, 188, 219, 0, 128, 95, 204, 206, 4}, 8))], [])*/PROPERTYKEY(GUID("0B63E343-9CCC-11D0-BCDB-00805FCCCE04"), 23),
    PKEY_Search_IsFullyContained  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({191095632, 40140, 4560, 188, 219, 0, 128, 95, 204, 206, 4}, 8))], [])*/PROPERTYKEY(GUID("0B63E343-9CCC-11D0-BCDB-00805FCCCE04"), 24),
    PKEY_Search_MatchKind         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({191095632, 40140, 4560, 188, 219, 0, 128, 95, 204, 206, 4}, 8))], [])*/PROPERTYKEY(GUID("49691C90-7E17-101A-A91C-08002B2ECDA9"), 29),
}

enum : int
{
    MATCH_KIND_LEXICAL  = 0x00000001,
    MATCH_KIND_SEMANTIC = 0x00000002,
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1231625360, 32279, 4122, 169, 28, 8, 0, 43, 46, 205, 169}, 30))], [])*/PROPERTYKEY
{
    PKEY_Search_MatchTags                       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1231625360, 32279, 4122, 169, 28, 8, 0, 43, 46, 205, 169}, 30))], [])*/PROPERTYKEY(GUID("49691C90-7E17-101A-A91C-08002B2ECDA9"), 30),
    PKEY_Search_OcrContent                      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1231625360, 32279, 4122, 169, 28, 8, 0, 43, 46, 205, 169}, 30))], [])*/PROPERTYKEY(GUID("B725F130-47EF-101A-A5F1-02608C9EEBAC"), 28),
    PKEY_Search_QueryFocusedSummary             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1231625360, 32279, 4122, 169, 28, 8, 0, 43, 46, 205, 169}, 30))], [])*/PROPERTYKEY(GUID("560C36C0-503A-11CF-BAA1-00004C752A9A"), 3),
    PKEY_Search_QueryFocusedSummaryWithFallback = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1231625360, 32279, 4122, 169, 28, 8, 0, 43, 46, 205, 169}, 30))], [])*/PROPERTYKEY(GUID("560C36C0-503A-11CF-BAA1-00004C752A9A"), 4),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1231625360, 32279, 4122, 169, 28, 8, 0, 43, 46, 205, 169}, 21))], [])*/PROPERTYKEY
{
    PKEY_Search_QueryPropertyHits              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1231625360, 32279, 4122, 169, 28, 8, 0, 43, 46, 205, 169}, 21))], [])*/PROPERTYKEY(GUID("49691C90-7E17-101A-A91C-08002B2ECDA9"), 21),
    PKEY_Search_Rank                           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1231625360, 32279, 4122, 169, 28, 8, 0, 43, 46, 205, 169}, 21))], [])*/PROPERTYKEY(GUID("49691C90-7E17-101A-A91C-08002B2ECDA9"), 3),
    PKEY_Search_Store                          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1231625360, 32279, 4122, 169, 28, 8, 0, 43, 46, 205, 169}, 21))], [])*/PROPERTYKEY(GUID("A06992B3-8CAF-4ED7-A547-B259E32AC9FC"), 100),
    PKEY_Search_UrlToIndex                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1231625360, 32279, 4122, 169, 28, 8, 0, 43, 46, 205, 169}, 21))], [])*/PROPERTYKEY(GUID("0B63E343-9CCC-11D0-BCDB-00805FCCCE04"), 2),
    PKEY_Search_UrlToIndexWithModificationTime = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1231625360, 32279, 4122, 169, 28, 8, 0, 43, 46, 205, 169}, 21))], [])*/PROPERTYKEY(GUID("0B63E343-9CCC-11D0-BCDB-00805FCCCE04"), 12),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({208908609, 14806, 18003, 166, 131, 202, 178, 145, 234, 249, 91}, 6))], [])*/PROPERTYKEY
{
    PKEY_Supplemental_Album      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({208908609, 14806, 18003, 166, 131, 202, 178, 145, 234, 249, 91}, 6))], [])*/PROPERTYKEY(GUID("0C73B141-39D6-4653-A683-CAB291EAF95B"), 6),
    PKEY_Supplemental_AlbumID    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({208908609, 14806, 18003, 166, 131, 202, 178, 145, 234, 249, 91}, 6))], [])*/PROPERTYKEY(GUID("0C73B141-39D6-4653-A683-CAB291EAF95B"), 2),
    PKEY_Supplemental_Location   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({208908609, 14806, 18003, 166, 131, 202, 178, 145, 234, 249, 91}, 6))], [])*/PROPERTYKEY(GUID("0C73B141-39D6-4653-A683-CAB291EAF95B"), 5),
    PKEY_Supplemental_Person     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({208908609, 14806, 18003, 166, 131, 202, 178, 145, 234, 249, 91}, 6))], [])*/PROPERTYKEY(GUID("0C73B141-39D6-4653-A683-CAB291EAF95B"), 7),
    PKEY_Supplemental_ResourceId = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({208908609, 14806, 18003, 166, 131, 202, 178, 145, 234, 249, 91}, 6))], [])*/PROPERTYKEY(GUID("0C73B141-39D6-4653-A683-CAB291EAF95B"), 3),
    PKEY_Supplemental_Tag        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({208908609, 14806, 18003, 166, 131, 202, 178, 145, 234, 249, 91}, 6))], [])*/PROPERTYKEY(GUID("0C73B141-39D6-4653-A683-CAB291EAF95B"), 4),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({818474740, 43058, 16866, 171, 50, 227, 195, 202, 40, 253, 41}, 23))], [])*/PROPERTYKEY
{
    PKEY_ActivityDate = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({818474740, 43058, 16866, 171, 50, 227, 195, 202, 40, 253, 41}, 23))], [])*/PROPERTYKEY(GUID("30C8EEF4-A832-41E2-AB32-E3C3CA28FD29"), 23),
    PKEY_ActivityIcon = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({818474740, 43058, 16866, 171, 50, 227, 195, 202, 40, 253, 41}, 23))], [])*/PROPERTYKEY(GUID("30C8EEF4-A832-41E2-AB32-E3C3CA28FD29"), 24),
    PKEY_ActivityInfo = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({818474740, 43058, 16866, 171, 50, 227, 195, 202, 40, 253, 41}, 23))], [])*/PROPERTYKEY(GUID("30C8EEF4-A832-41E2-AB32-E3C3CA28FD29"), 17),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({677604006, 38205, 4562, 181, 214, 0, 192, 79, 217, 24, 208}, 2))], [])*/PROPERTYKEY PKEY_DescriptionID = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({677604006, 38205, 4562, 181, 214, 0, 192, 79, 217, 24, 208}, 2))], [])*/PROPERTYKEY(GUID("28636AA6-953D-11D2-B5D6-00C04FD918D0"), 2);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({818474740, 43058, 16866, 171, 50, 227, 195, 202, 40, 253, 41}, 2))], [])*/PROPERTYKEY PKEY_Home_Grouping = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({818474740, 43058, 16866, 171, 50, 227, 195, 202, 40, 253, 41}, 2))], [])*/PROPERTYKEY(GUID("30C8EEF4-A832-41E2-AB32-E3C3CA28FD29"), 2);

enum : uint
{
    HOMEGROUPING_UNSPECIFIED     = 0x00000000U,
    HOMEGROUPING_FREQUENT        = 0x00000001U,
    HOMEGROUPING_PINNED          = 0x00000002U,
    HOMEGROUPING_RECENT          = 0x00000003U,
    HOMEGROUPING_RECOMMENDATIONS = 0x00000004U,
    HOMEGROUPING_SHARED          = 0x00000005U,
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({818474740, 43058, 16866, 171, 50, 227, 195, 202, 40, 253, 41}, 4))], [])*/PROPERTYKEY
{
    PKEY_Home_IsPinned              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({818474740, 43058, 16866, 171, 50, 227, 195, 202, 40, 253, 41}, 4))], [])*/PROPERTYKEY(GUID("30C8EEF4-A832-41E2-AB32-E3C3CA28FD29"), 4),
    PKEY_Home_ItemFolderPathDisplay = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({818474740, 43058, 16866, 171, 50, 227, 195, 202, 40, 253, 41}, 4))], [])*/PROPERTYKEY(GUID("30C8EEF4-A832-41E2-AB32-E3C3CA28FD29"), 6),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({818474740, 43058, 16866, 171, 50, 227, 195, 202, 40, 253, 41}, 22))], [])*/PROPERTYKEY
{
    PKEY_Home_RecommendationActivityDate   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({818474740, 43058, 16866, 171, 50, 227, 195, 202, 40, 253, 41}, 22))], [])*/PROPERTYKEY(GUID("30C8EEF4-A832-41E2-AB32-E3C3CA28FD29"), 22),
    PKEY_Home_RecommendationProviderSource = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({818474740, 43058, 16866, 171, 50, 227, 195, 202, 40, 253, 41}, 22))], [])*/PROPERTYKEY(GUID("5CA9B1CB-C69F-404B-ABC6-FD336793A6A7"), 22),
    PKEY_Home_RecommendationReasonIcon     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({818474740, 43058, 16866, 171, 50, 227, 195, 202, 40, 253, 41}, 22))], [])*/PROPERTYKEY(GUID("30C8EEF4-A832-41E2-AB32-E3C3CA28FD29"), 21),
    PKEY_Home_Recommended                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({818474740, 43058, 16866, 171, 50, 227, 195, 202, 40, 253, 41}, 22))], [])*/PROPERTYKEY(GUID("30C8EEF4-A832-41E2-AB32-E3C3CA28FD29"), 20),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({217021779, 64100, 4561, 162, 3, 0, 0, 248, 31, 237, 238}, 5))], [])*/PROPERTYKEY PKEY_InternalName = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({217021779, 64100, 4561, 162, 3, 0, 0, 248, 31, 237, 238}, 5))], [])*/PROPERTYKEY(GUID("0CEF7D53-FA64-11D1-A203-0000F81FEDEE"), 5);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2424739527, 36743, 17650, 128, 237, 168, 193, 198, 137, 69, 117}, 2))], [])*/PROPERTYKEY PKEY_LibraryLocationsCount = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2424739527, 36743, 17650, 128, 237, 168, 193, 198, 137, 69, 117}, 2))], [])*/PROPERTYKEY(GUID("908696C7-8F87-44F2-80ED-A8C1C6894575"), 2);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3600031873, 54587, 17469, 173, 71, 94, 5, 157, 156, 210, 122}, 3))], [])*/PROPERTYKEY
{
    PKEY_Link_TargetSFGAOFlagsStrings = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3600031873, 54587, 17469, 173, 71, 94, 5, 157, 156, 210, 122}, 3))], [])*/PROPERTYKEY(GUID("D6942081-D53B-443D-AD47-5E059D9CD27A"), 3),
    PKEY_Link_TargetUrl               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3600031873, 54587, 17469, 173, 71, 94, 5, 157, 156, 210, 122}, 3))], [])*/PROPERTYKEY(GUID("5CBF2787-48CF-4208-B90E-EE5E5D420294"), 2),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({677604006, 38205, 4562, 181, 214, 0, 192, 79, 217, 24, 208}, 6))], [])*/PROPERTYKEY PKEY_NamespaceCLSID = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({677604006, 38205, 4562, 181, 214, 0, 192, 79, 217, 24, 208}, 6))], [])*/PROPERTYKEY(GUID("28636AA6-953D-11D2-B5D6-00C04FD918D0"), 6);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({946154442, 17193, 20084, 134, 249, 57, 207, 41, 52, 94, 234}, 2))], [])*/PROPERTYKEY PKEY_Shell_CopilotKeyProviderFastPathMessage = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({946154442, 17193, 20084, 134, 249, 57, 207, 41, 52, 94, 234}, 2))], [])*/PROPERTYKEY(GUID("38652BCA-4329-4E74-86F9-39CF29345EEA"), 2);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3600031873, 54587, 17469, 173, 71, 94, 5, 157, 156, 210, 122}, 2))], [])*/PROPERTYKEY PKEY_Shell_SFGAOFlagsStrings = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3600031873, 54587, 17469, 173, 71, 94, 5, 157, 156, 210, 122}, 2))], [])*/PROPERTYKEY(GUID("D6942081-D53B-443D-AD47-5E059D9CD27A"), 2);

enum : const(wchar)*
{
    SFGAOSTR_FILESYS     = "filesys",
    SFGAOSTR_FILEANC     = "fileanc",
    SFGAOSTR_STORAGEANC  = "storageanc",
    SFGAOSTR_STREAM      = "stream",
    SFGAOSTR_LINK        = "link",
    SFGAOSTR_HIDDEN      = "hidden",
    SFGAOSTR_SUPERHIDDEN = "superhidden",
    SFGAOSTR_FOLDER      = "folder",
    SFGAOSTR_NONENUM     = "nonenum",
    SFGAOSTR_BROWSABLE   = "browsable",
    SFGAOSTR_SYSTEM      = "system",
    SFGAOSTR_PLACEHOLDER = "placeholder",
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({651962492, 28221, 19411, 178, 176, 106, 38, 186, 46, 52, 109}, 3))], [])*/PROPERTYKEY
{
    PKEY_StatusBarSelectedItemCount = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({651962492, 28221, 19411, 178, 176, 106, 38, 186, 46, 52, 109}, 3))], [])*/PROPERTYKEY(GUID("26DC287C-6E3D-4BD3-B2B0-6A26BA2E346D"), 3),
    PKEY_StatusBarViewItemCount     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({651962492, 28221, 19411, 178, 176, 106, 38, 186, 46, 52, 109}, 3))], [])*/PROPERTYKEY(GUID("26DC287C-6E3D-4BD3-B2B0-6A26BA2E346D"), 2),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3883831519, 25201, 20315, 131, 79, 45, 209, 242, 69, 221, 164}, 3))], [])*/PROPERTYKEY PKEY_StorageProviderState = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3883831519, 25201, 20315, 131, 79, 45, 209, 242, 69, 221, 164}, 3))], [])*/PROPERTYKEY(GUID("E77E90DF-6271-4F5B-834F-2DD1F245DDA4"), 3);

enum : uint
{
    STORAGEPROVIDERSTATE_NONE                = 0x00000000U,
    STORAGEPROVIDERSTATE_SPARSE              = 0x00000001U,
    STORAGEPROVIDERSTATE_IN_SYNC             = 0x00000002U,
    STORAGEPROVIDERSTATE_PINNED              = 0x00000003U,
    STORAGEPROVIDERSTATE_PENDING_UPLOAD      = 0x00000004U,
    STORAGEPROVIDERSTATE_PENDING_DOWNLOAD    = 0x00000005U,
    STORAGEPROVIDERSTATE_TRANSFERRING        = 0x00000006U,
    STORAGEPROVIDERSTATE_ERROR               = 0x00000007U,
    STORAGEPROVIDERSTATE_WARNING             = 0x00000008U,
    STORAGEPROVIDERSTATE_EXCLUDED            = 0x00000009U,
    STORAGEPROVIDERSTATE_PENDING_UNSPECIFIED = 0x0000000aU,
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3883831519, 25201, 20315, 131, 79, 45, 209, 242, 69, 221, 164}, 4))], [])*/PROPERTYKEY PKEY_StorageProviderTransferProgress = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3883831519, 25201, 20315, 131, 79, 45, 209, 242, 69, 221, 164}, 4))], [])*/PROPERTYKEY(GUID("E77E90DF-6271-4F5B-834F-2DD1F245DDA4"), 4);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({818474740, 43058, 16866, 171, 50, 227, 195, 202, 40, 253, 41}, 7))], [])*/PROPERTYKEY PKEY_WebAccountID = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({818474740, 43058, 16866, 171, 50, 227, 195, 202, 40, 253, 41}, 7))], [])*/PROPERTYKEY(GUID("30C8EEF4-A832-41E2-AB32-E3C3CA28FD29"), 7);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2672568405, 40825, 19257, 168, 208, 225, 212, 45, 225, 213, 243}, 8))], [])*/PROPERTYKEY PKEY_AppUserModel_ExcludeFromShowInNewInstall = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2672568405, 40825, 19257, 168, 208, 225, 212, 45, 225, 213, 243}, 8))], [])*/PROPERTYKEY(GUID("9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3"), 8);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2672568405, 40825, 19257, 168, 208, 225, 212, 45, 225, 213, 243}, 5))], [])*/PROPERTYKEY
{
    PKEY_AppUserModel_ID                          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2672568405, 40825, 19257, 168, 208, 225, 212, 45, 225, 213, 243}, 5))], [])*/PROPERTYKEY(GUID("9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3"), 5),
    PKEY_AppUserModel_IsDestListSeparator         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2672568405, 40825, 19257, 168, 208, 225, 212, 45, 225, 213, 243}, 5))], [])*/PROPERTYKEY(GUID("9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3"), 6),
    PKEY_AppUserModel_IsDualMode                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2672568405, 40825, 19257, 168, 208, 225, 212, 45, 225, 213, 243}, 5))], [])*/PROPERTYKEY(GUID("9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3"), 11),
    PKEY_AppUserModel_PreventPinning              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2672568405, 40825, 19257, 168, 208, 225, 212, 45, 225, 213, 243}, 5))], [])*/PROPERTYKEY(GUID("9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3"), 9),
    PKEY_AppUserModel_RelaunchCommand             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2672568405, 40825, 19257, 168, 208, 225, 212, 45, 225, 213, 243}, 5))], [])*/PROPERTYKEY(GUID("9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3"), 2),
    PKEY_AppUserModel_RelaunchDisplayNameResource = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2672568405, 40825, 19257, 168, 208, 225, 212, 45, 225, 213, 243}, 5))], [])*/PROPERTYKEY(GUID("9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3"), 4),
    PKEY_AppUserModel_RelaunchIconResource        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2672568405, 40825, 19257, 168, 208, 225, 212, 45, 225, 213, 243}, 5))], [])*/PROPERTYKEY(GUID("9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3"), 3),
    PKEY_AppUserModel_SettingsCommand             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2672568405, 40825, 19257, 168, 208, 225, 212, 45, 225, 213, 243}, 5))], [])*/PROPERTYKEY(GUID("9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3"), 38),
    PKEY_AppUserModel_StartPinOption              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2672568405, 40825, 19257, 168, 208, 225, 212, 45, 225, 213, 243}, 5))], [])*/PROPERTYKEY(GUID("9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3"), 12),
}

enum : uint
{
    APPUSERMODEL_STARTPINOPTION_DEFAULT        = 0x00000000U,
    APPUSERMODEL_STARTPINOPTION_NOPINONINSTALL = 0x00000001U,
    APPUSERMODEL_STARTPINOPTION_USERPINNED     = 0x00000002U,
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2672568405, 40825, 19257, 168, 208, 225, 212, 45, 225, 213, 243}, 26))], [])*/PROPERTYKEY
{
    PKEY_AppUserModel_ToastActivatorCLSID            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2672568405, 40825, 19257, 168, 208, 225, 212, 45, 225, 213, 243}, 26))], [])*/PROPERTYKEY(GUID("9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3"), 26),
    PKEY_AppUserModel_UninstallCommand               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2672568405, 40825, 19257, 168, 208, 225, 212, 45, 225, 213, 243}, 26))], [])*/PROPERTYKEY(GUID("9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3"), 37),
    PKEY_AppUserModel_VisualElementsManifestHintPath = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2672568405, 40825, 19257, 168, 208, 225, 212, 45, 225, 213, 243}, 26))], [])*/PROPERTYKEY(GUID("9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3"), 31),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({852375730, 11418, 16817, 155, 197, 179, 120, 67, 148, 170, 68}, 2))], [])*/PROPERTYKEY PKEY_EdgeGesture_DisableTouchWhenFullscreen = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({852375730, 11418, 16817, 155, 197, 179, 120, 67, 148, 170, 68}, 2))], [])*/PROPERTYKEY(GUID("32CE38B2-2C9A-41B1-9BC5-B3784394AA44"), 2);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2216578960, 65369, 19734, 137, 71, 232, 27, 191, 250, 179, 109}, 16))], [])*/PROPERTYKEY
{
    PKEY_Software_DateLastUsed = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2216578960, 65369, 19734, 137, 71, 232, 27, 191, 250, 179, 109}, 16))], [])*/PROPERTYKEY(GUID("841E4F90-FF59-4D16-8947-E81BBFFAB36D"), 16),
    PKEY_Software_ProductName  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2216578960, 65369, 19734, 137, 71, 232, 27, 191, 250, 179, 109}, 16))], [])*/PROPERTYKEY(GUID("0CEF7D53-FA64-11D1-A203-0000F81FEDEE"), 7),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2077578046, 44821, 17627, 184, 200, 189, 102, 36, 225, 208, 50}, 13))], [])*/PROPERTYKEY
{
    PKEY_Sync_Comments               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2077578046, 44821, 17627, 184, 200, 189, 102, 36, 225, 208, 50}, 13))], [])*/PROPERTYKEY(GUID("7BD5533E-AF15-44DB-B8C8-BD6624E1D032"), 13),
    PKEY_Sync_ConflictDescription    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2077578046, 44821, 17627, 184, 200, 189, 102, 36, 225, 208, 50}, 13))], [])*/PROPERTYKEY(GUID("CE50C159-2FB8-41FD-BE68-D3E042E274BC"), 4),
    PKEY_Sync_ConflictFirstLocation  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2077578046, 44821, 17627, 184, 200, 189, 102, 36, 225, 208, 50}, 13))], [])*/PROPERTYKEY(GUID("CE50C159-2FB8-41FD-BE68-D3E042E274BC"), 6),
    PKEY_Sync_ConflictSecondLocation = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2077578046, 44821, 17627, 184, 200, 189, 102, 36, 225, 208, 50}, 13))], [])*/PROPERTYKEY(GUID("CE50C159-2FB8-41FD-BE68-D3E042E274BC"), 7),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2077578046, 44821, 17627, 184, 200, 189, 102, 36, 225, 208, 50}, 2))], [])*/PROPERTYKEY
{
    PKEY_Sync_HandlerCollectionID = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2077578046, 44821, 17627, 184, 200, 189, 102, 36, 225, 208, 50}, 2))], [])*/PROPERTYKEY(GUID("7BD5533E-AF15-44DB-B8C8-BD6624E1D032"), 2),
    PKEY_Sync_HandlerID           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2077578046, 44821, 17627, 184, 200, 189, 102, 36, 225, 208, 50}, 2))], [])*/PROPERTYKEY(GUID("7BD5533E-AF15-44DB-B8C8-BD6624E1D032"), 3),
    PKEY_Sync_HandlerName         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2077578046, 44821, 17627, 184, 200, 189, 102, 36, 225, 208, 50}, 2))], [])*/PROPERTYKEY(GUID("CE50C159-2FB8-41FD-BE68-D3E042E274BC"), 2),
    PKEY_Sync_HandlerType         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2077578046, 44821, 17627, 184, 200, 189, 102, 36, 225, 208, 50}, 2))], [])*/PROPERTYKEY(GUID("7BD5533E-AF15-44DB-B8C8-BD6624E1D032"), 8),
}

enum : uint
{
    SYNC_HANDLERTYPE_OTHER       = 0x00000000U,
    SYNC_HANDLERTYPE_PROGRAMS    = 0x00000001U,
    SYNC_HANDLERTYPE_DEVICES     = 0x00000002U,
    SYNC_HANDLERTYPE_FOLDERS     = 0x00000003U,
    SYNC_HANDLERTYPE_WEBSERVICES = 0x00000004U,
    SYNC_HANDLERTYPE_COMPUTERS   = 0x00000005U,
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2077578046, 44821, 17627, 184, 200, 189, 102, 36, 225, 208, 50}, 9))], [])*/PROPERTYKEY PKEY_Sync_HandlerTypeLabel = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2077578046, 44821, 17627, 184, 200, 189, 102, 36, 225, 208, 50}, 9))], [])*/PROPERTYKEY(GUID("7BD5533E-AF15-44DB-B8C8-BD6624E1D032"), 9);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2077578046, 44821, 17627, 184, 200, 189, 102, 36, 225, 208, 50}, 6))], [])*/PROPERTYKEY
{
    PKEY_Sync_ItemID             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2077578046, 44821, 17627, 184, 200, 189, 102, 36, 225, 208, 50}, 6))], [])*/PROPERTYKEY(GUID("7BD5533E-AF15-44DB-B8C8-BD6624E1D032"), 6),
    PKEY_Sync_ItemName           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2077578046, 44821, 17627, 184, 200, 189, 102, 36, 225, 208, 50}, 6))], [])*/PROPERTYKEY(GUID("CE50C159-2FB8-41FD-BE68-D3E042E274BC"), 3),
    PKEY_Sync_ProgressPercentage = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2077578046, 44821, 17627, 184, 200, 189, 102, 36, 225, 208, 50}, 6))], [])*/PROPERTYKEY(GUID("7BD5533E-AF15-44DB-B8C8-BD6624E1D032"), 23),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2077578046, 44821, 17627, 184, 200, 189, 102, 36, 225, 208, 50}, 24))], [])*/PROPERTYKEY PKEY_Sync_State = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2077578046, 44821, 17627, 184, 200, 189, 102, 36, 225, 208, 50}, 24))], [])*/PROPERTYKEY(GUID("7BD5533E-AF15-44DB-B8C8-BD6624E1D032"), 24);

enum : uint
{
    SYNC_STATE_NOTSETUP   = 0x00000000U,
    SYNC_STATE_SYNCNOTRUN = 0x00000001U,
    SYNC_STATE_IDLE       = 0x00000002U,
    SYNC_STATE_ERROR      = 0x00000003U,
    SYNC_STATE_PENDING    = 0x00000004U,
    SYNC_STATE_SYNCING    = 0x00000005U,
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2077578046, 44821, 17627, 184, 200, 189, 102, 36, 225, 208, 50}, 10))], [])*/PROPERTYKEY PKEY_Sync_Status = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2077578046, 44821, 17627, 184, 200, 189, 102, 36, 225, 208, 50}, 10))], [])*/PROPERTYKEY(GUID("7BD5533E-AF15-44DB-B8C8-BD6624E1D032"), 10);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3548205766, 9756, 17155, 130, 179, 8, 185, 38, 172, 111, 18}, 100))], [])*/PROPERTYKEY PKEY_Task_BillingInformation = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3548205766, 9756, 17155, 130, 179, 8, 185, 38, 172, 111, 18}, 100))], [])*/PROPERTYKEY(GUID("D37D52C6-261C-4303-82B3-08B926AC6F12"), 100);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({139299338, 59093, 16606, 191, 31, 200, 130, 14, 124, 135, 124}, 100))], [])*/PROPERTYKEY PKEY_Task_CompletionStatus = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({139299338, 59093, 16606, 191, 31, 200, 130, 14, 124, 135, 124}, 100))], [])*/PROPERTYKEY(GUID("084D8A0A-E6D5-40DE-BF1F-C8820E7C877C"), 100);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({147311711, 24818, 17556, 173, 117, 85, 227, 224, 181, 173, 208}, 100))], [])*/PROPERTYKEY PKEY_Task_Owner = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({147311711, 24818, 17556, 173, 117, 85, 227, 224, 181, 173, 208}, 100))], [])*/PROPERTYKEY(GUID("08C7CC5F-60F2-4494-AD75-55E3E0B5ADD0"), 100);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179217, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 10))], [])*/PROPERTYKEY
{
    PKEY_Video_Compression           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179217, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 10))], [])*/PROPERTYKEY(GUID("64440491-4C8B-11D1-8B70-080036B11A03"), 10),
    PKEY_Video_Director              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179217, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 10))], [])*/PROPERTYKEY(GUID("64440492-4C8B-11D1-8B70-080036B11A03"), 20),
    PKEY_Video_EncodingBitrate       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179217, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 10))], [])*/PROPERTYKEY(GUID("64440491-4C8B-11D1-8B70-080036B11A03"), 8),
    PKEY_Video_FourCC                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179217, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 10))], [])*/PROPERTYKEY(GUID("64440491-4C8B-11D1-8B70-080036B11A03"), 44),
    PKEY_Video_FrameHeight           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179217, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 10))], [])*/PROPERTYKEY(GUID("64440491-4C8B-11D1-8B70-080036B11A03"), 4),
    PKEY_Video_FrameRate             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179217, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 10))], [])*/PROPERTYKEY(GUID("64440491-4C8B-11D1-8B70-080036B11A03"), 6),
    PKEY_Video_FrameWidth            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179217, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 10))], [])*/PROPERTYKEY(GUID("64440491-4C8B-11D1-8B70-080036B11A03"), 3),
    PKEY_Video_HorizontalAspectRatio = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179217, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 10))], [])*/PROPERTYKEY(GUID("64440491-4C8B-11D1-8B70-080036B11A03"), 42),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179217, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 100))], [])*/PROPERTYKEY
{
    PKEY_Video_IsSpherical       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179217, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 100))], [])*/PROPERTYKEY(GUID("64440491-4C8B-11D1-8B70-080036B11A03"), 100),
    PKEY_Video_IsStereo          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179217, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 100))], [])*/PROPERTYKEY(GUID("64440491-4C8B-11D1-8B70-080036B11A03"), 98),
    PKEY_Video_Orientation       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179217, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 100))], [])*/PROPERTYKEY(GUID("64440491-4C8B-11D1-8B70-080036B11A03"), 99),
    PKEY_Video_SampleSize        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179217, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 100))], [])*/PROPERTYKEY(GUID("64440491-4C8B-11D1-8B70-080036B11A03"), 9),
    PKEY_Video_StreamName        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179217, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 100))], [])*/PROPERTYKEY(GUID("64440491-4C8B-11D1-8B70-080036B11A03"), 2),
    PKEY_Video_StreamNumber      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179217, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 100))], [])*/PROPERTYKEY(GUID("64440491-4C8B-11D1-8B70-080036B11A03"), 11),
    PKEY_Video_TotalBitrate      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179217, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 100))], [])*/PROPERTYKEY(GUID("64440491-4C8B-11D1-8B70-080036B11A03"), 43),
    PKEY_Video_TranscodedForSync = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179217, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 100))], [])*/PROPERTYKEY(GUID("64440491-4C8B-11D1-8B70-080036B11A03"), 46),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179217, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 45))], [])*/PROPERTYKEY PKEY_Video_VerticalAspectRatio = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({1682179217, 19595, 4561, 139, 112, 8, 0, 54, 177, 26, 3}, 45))], [])*/PROPERTYKEY(GUID("64440491-4C8B-11D1-8B70-080036B11A03"), 45);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2601995061, 16639, 4562, 162, 126, 0, 192, 79, 195, 8, 113}, 4))], [])*/PROPERTYKEY
{
    PKEY_Volume_FileSystem    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2601995061, 16639, 4562, 162, 126, 0, 192, 79, 195, 8, 113}, 4))], [])*/PROPERTYKEY(GUID("9B174B35-40FF-11D2-A27E-00C04FC30871"), 4),
    PKEY_Volume_IsMappedDrive = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2601995061, 16639, 4562, 162, 126, 0, 192, 79, 195, 8, 113}, 4))], [])*/PROPERTYKEY(GUID("149C0B69-2C2D-48FC-808F-D318D78C4636"), 2),
    PKEY_Volume_IsRoot        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({2601995061, 16639, 4562, 162, 126, 0, 192, 79, 195, 8, 113}, 4))], [])*/PROPERTYKEY(GUID("9B174B35-40FF-11D2-A27E-00C04FC30871"), 10),
}

enum : uint
{
    ACT_AUTHORIZE_ON_RESUME         = 0x00000001U,
    ACT_AUTHORIZE_ON_SESSION_UNLOCK = 0x00000002U,
}

enum : uint
{
    ACT_UNAUTHORIZE_ON_SUSPEND      = 0x00000001U,
    ACT_UNAUTHORIZE_ON_SESSION_LOCK = 0x00000002U,
}

enum : uint
{
    ES_RESERVED_COM_ERROR_START = 0x00000000U,
    ES_RESERVED_COM_ERROR_END   = 0x000001ffU,
}

enum : uint
{
    ES_GENERAL_ERROR_START = 0x00000200U,
    ES_GENERAL_ERROR_END   = 0x000003ffU,
}

enum : uint
{
    ES_AUTHN_ERROR_START = 0x00000400U,
    ES_AUTHN_ERROR_END   = 0x000004ffU,
}

enum : uint
{
    ES_RESERVED_SILO_ERROR_START = 0x00000500U,
    ES_RESERVED_SILO_ERROR_END   = 0x00000fffU,
}

enum : uint
{
    ES_PW_SILO_ERROR_START = 0x00001100U,
    ES_PW_SILO_ERROR_END   = 0x000011ffU,
}

enum : uint
{
    ES_RESERVED_SILO_SPECIFIC_ERROR_START = 0x00001200U,
    ES_RESERVED_SILO_SPECIFIC_ERROR_END   = 0x0000bfffU,
}

enum : uint
{
    ES_VENDOR_ERROR_START = 0x0000c000U,
    ES_VENDOR_ERROR_END   = 0x0000ffffU,
}

enum uint FACILITY_ENHANCED_STORAGE = 0x00000004U;
enum uint ES_E_INVALID_RESPONSE = 0xc0040200U;
enum uint ES_E_UNPROVISIONED_HARDWARE = 0xc0040204U;
enum uint ES_E_UNSUPPORTED_HARDWARE = 0xc0040205U;
enum uint ES_E_INCOMPLETE_COMMAND = 0xc0040206U;
enum uint ES_E_BAD_SEQUENCE = 0xc0040207U;
enum uint ES_E_NO_PROBE = 0xc0040208U;

enum : uint
{
    ES_E_INVALID_SILO       = 0xc0040209U,
    ES_E_INVALID_CAPABILITY = 0xc004020aU,
}

enum : uint
{
    ES_E_GROUP_POLICY_FORBIDDEN_USE       = 0xc004020bU,
    ES_E_GROUP_POLICY_FORBIDDEN_OPERATION = 0xc004020cU,
}

enum : uint
{
    ES_E_INVALID_PARAM_COMBINATION = 0xc004020dU,
    ES_E_INVALID_PARAM_LENGTH      = 0xc004020eU,
}

enum uint ES_E_INCONSISTENT_PARAM_LENGTH = 0xc004020fU;
enum uint ES_E_NO_AUTHENTICATION_REQUIRED = 0xc0040400U;
enum uint ES_E_INVALID_FIELD_IDENTIFIER = 0xc0041100U;

enum : uint
{
    ES_E_CHALLENGE_MISMATCH      = 0xc0041101U,
    ES_E_CHALLENGE_SIZE_MISMATCH = 0xc0041102U,
}

enum uint ES_E_FRIENDLY_NAME_TOO_LONG = 0xc0041103U;
enum uint ES_E_SILO_NAME_TOO_LONG = 0xc0041104U;

enum : uint
{
    ES_E_PASSWORD_TOO_LONG      = 0xc0041105U,
    ES_E_PASSWORD_HINT_TOO_LONG = 0xc0041106U,
}

enum uint ES_E_OTHER_SECURITY_PROTOCOL_ACTIVE = 0xc0041107U;
enum uint ES_E_DEVICE_DIGEST_MISSING = 0xc0041108U;
enum uint ES_E_NOT_AUTHORIZED_UNEXPECTED = 0xc0041109U;
enum uint ES_E_AUTHORIZED_UNEXPECTED = 0xc004110aU;
enum uint ES_E_PROVISIONED_UNEXPECTED = 0xc004110bU;
enum uint ES_E_UNKNOWN_DIGEST_ALGORITHM = 0xc004110cU;

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ehstorextensions/ns-ehstorextensions-enhanced_storage_password_silo_information
struct ENHANCED_STORAGE_PASSWORD_SILO_INFORMATION
{
    ubyte  CurrentAdminFailures;
    ubyte  CurrentUserFailures;
    uint   TotalUserAuthenticationCount;
    uint   TotalAdminAuthenticationCount;
    BOOL   FipsCompliant;
    BOOL   SecurityIDAvailable;
    BOOL   InitializeInProgress;
    BOOL   ITMSArmed;
    BOOL   ITMSArmable;
    BOOL   UserCreated;
    BOOL   ResetOnPORDefault;
    BOOL   ResetOnPORCurrent;
    ubyte  MaxAdminFailures;
    ubyte  MaxUserFailures;
    uint   TimeToCompleteInitialization;
    uint   TimeRemainingToCompleteInitialization;
    uint   MinTimeToAuthenticate;
    ubyte  MaxAdminPasswordSize;
    ubyte  MinAdminPasswordSize;
    ubyte  MaxAdminHintSize;
    ubyte  MaxUserPasswordSize;
    ubyte  MinUserPasswordSize;
    ubyte  MaxUserHintSize;
    ubyte  MaxUserNameSize;
    ubyte  MaxSiloNameSize;
    ushort MaxChallengeSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ehstorapi/ns-ehstorapi-act_authorization_state
struct ACT_AUTHORIZATION_STATE
{
    uint ulState;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ehstorapi/ns-ehstorapi-silo_info
struct SILO_INFO
{
    uint  ulSTID;
    ubyte SpecificationMajor;
    ubyte SpecificationMinor;
    ubyte ImplementationMajor;
    ubyte ImplementationMinor;
    ubyte type;
    ubyte capabilities;
}

// Interfaces

@GUID("fe841493-835c-4fa3-b6cc-b4b2d4719848")
struct EnumEnhancedStorageACT;

@GUID("af076a15-2ece-4ad4-bb21-29f040e176d8")
struct EnhancedStorageACT;

@GUID("cb25220c-76c7-4fee-842b-f3383cd022bc")
struct EnhancedStorageSilo;

@GUID("886d29dd-b506-466b-9fbf-b44ff383fb3f")
struct EnhancedStorageSiloAction;

@GUID("09b224bd-1335-4631-a7ff-cfd3a92646d7")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ehstorapi/nn-ehstorapi-ienumenhancedstorageact
interface IEnumEnhancedStorageACT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ehstorapi/nf-ehstorapi-ienumenhancedstorageact-getacts
    HRESULT GetACTs(IEnhancedStorageACT** pppIEnhancedStorageACTs, uint* pcEnhancedStorageACTs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ehstorapi/nf-ehstorapi-ienumenhancedstorageact-getmatchingact
    HRESULT GetMatchingACT(const(PWSTR) szVolume, IEnhancedStorageACT* ppIEnhancedStorageACT);
}

@GUID("6e7781f4-e0f2-4239-b976-a01abab52930")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ehstorapi/nn-ehstorapi-ienhancedstorageact
interface IEnhancedStorageACT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ehstorapi/nf-ehstorapi-ienhancedstorageact-authorize
    HRESULT Authorize(uint hwndParent, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ehstorapi/nf-ehstorapi-ienhancedstorageact-unauthorize
    HRESULT Unauthorize();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ehstorapi/nf-ehstorapi-ienhancedstorageact-getauthorizationstate
    HRESULT GetAuthorizationState(ACT_AUTHORIZATION_STATE* pState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ehstorapi/nf-ehstorapi-ienhancedstorageact-getmatchingvolume
    HRESULT GetMatchingVolume(PWSTR* ppwszVolume);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ehstorapi/nf-ehstorapi-ienhancedstorageact-getuniqueidentity
    HRESULT GetUniqueIdentity(PWSTR* ppwszIdentity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ehstorapi/nf-ehstorapi-ienhancedstorageact-getsilos
    HRESULT GetSilos(IEnhancedStorageSilo** pppIEnhancedStorageSilos, uint* pcEnhancedStorageSilos);
}

@GUID("4da57d2e-8eb3-41f6-a07e-98b52b88242b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ehstorapi/nn-ehstorapi-ienhancedstorageact2
interface IEnhancedStorageACT2 : IEnhancedStorageACT
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ehstorapi/nf-ehstorapi-ienhancedstorageact2-getdevicename
    HRESULT GetDeviceName(PWSTR* ppwszDeviceName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ehstorapi/nf-ehstorapi-ienhancedstorageact2-isdeviceremovable
    HRESULT IsDeviceRemovable(BOOL* pIsDeviceRemovable);
}

@GUID("022150a1-113d-11df-bb61-001aa01bbc58")
interface IEnhancedStorageACT3 : IEnhancedStorageACT2
{
    HRESULT UnauthorizeEx(uint dwFlags);
    HRESULT IsQueueFrozen(BOOL* pIsQueueFrozen);
    HRESULT GetShellExtSupport(BOOL* pShellExtSupport);
}

@GUID("5aef78c6-2242-4703-bf49-44b29357a359")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ehstorapi/nn-ehstorapi-ienhancedstoragesilo
interface IEnhancedStorageSilo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ehstorapi/nf-ehstorapi-ienhancedstoragesilo-getinfo
    HRESULT GetInfo(SILO_INFO* pSiloInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ehstorapi/nf-ehstorapi-ienhancedstoragesilo-getactions
    HRESULT GetActions(IEnhancedStorageSiloAction** pppIEnhancedStorageSiloActions, 
                       uint* pcEnhancedStorageSiloActions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ehstorapi/nf-ehstorapi-ienhancedstoragesilo-sendcommand
    HRESULT SendCommand(ubyte Command, ubyte* pbCommandBuffer, uint cbCommandBuffer, ubyte* pbResponseBuffer, 
                        uint* pcbResponseBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ehstorapi/nf-ehstorapi-ienhancedstoragesilo-getportabledevice
    HRESULT GetPortableDevice(IPortableDevice* ppIPortableDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ehstorapi/nf-ehstorapi-ienhancedstoragesilo-getdevicepath
    HRESULT GetDevicePath(PWSTR* ppwszSiloDevicePath);
}

@GUID("b6f7f311-206f-4ff8-9c4b-27efee77a86f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ehstorapi/nn-ehstorapi-ienhancedstoragesiloaction
interface IEnhancedStorageSiloAction : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ehstorapi/nf-ehstorapi-ienhancedstoragesiloaction-getname
    HRESULT GetName(PWSTR* ppwszActionName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ehstorapi/nf-ehstorapi-ienhancedstoragesiloaction-getdescription
    HRESULT GetDescription(PWSTR* ppwszActionDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ehstorapi/nf-ehstorapi-ienhancedstoragesiloaction-invoke
    HRESULT Invoke();
}


// GUIDs

const GUID CLSID_EnhancedStorageACT        = GUIDOF!EnhancedStorageACT;
const GUID CLSID_EnhancedStorageSilo       = GUIDOF!EnhancedStorageSilo;
const GUID CLSID_EnhancedStorageSiloAction = GUIDOF!EnhancedStorageSiloAction;
const GUID CLSID_EnumEnhancedStorageACT    = GUIDOF!EnumEnhancedStorageACT;

const GUID IID_IEnhancedStorageACT        = GUIDOF!IEnhancedStorageACT;
const GUID IID_IEnhancedStorageACT2       = GUIDOF!IEnhancedStorageACT2;
const GUID IID_IEnhancedStorageACT3       = GUIDOF!IEnhancedStorageACT3;
const GUID IID_IEnhancedStorageSilo       = GUIDOF!IEnhancedStorageSilo;
const GUID IID_IEnhancedStorageSiloAction = GUIDOF!IEnhancedStorageSiloAction;
const GUID IID_IEnumEnhancedStorageACT    = GUIDOF!IEnumEnhancedStorageACT;
