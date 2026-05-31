// Written in the D programming language.

module windows.win32.networkmanagement.wifi;

public import windows.core;
public import system : Guid;
public import windows.win32.foundation : BOOL, BOOLEAN, DEVPROPKEY, HANDLE, HRESULT,
                                         HWND, PWSTR;
public import windows.win32.networkmanagement.ndis : NDIS_OBJECT_HEADER;
public import windows.win32.security.extensibleauthenticationprotocol : EAP_ATTRIBUTES, EAP_METHOD_TYPE;
public import windows.win32.system.com : IUnknown;
public import windows.win32.system.remotedesktop : WTSSESSION_NOTIFICATION;

extern(Windows) @nogc nothrow:


// Enums

alias WLAN_SET_EAPHOST_FLAGS = uint;
enum : uint
{
    WLAN_SET_EAPHOST_DATA_ALL_USERS = 0x00000001,
}
alias WLAN_CONNECTION_NOTIFICATION_FLAGS = uint;
enum : uint
{
    WLAN_CONNECTION_NOTIFICATION_ADHOC_NETWORK_FORMED = 0x00000001,
    WLAN_CONNECTION_NOTIFICATION_CONSOLE_USER_PROFILE = 0x00000004,
}
alias WLAN_NOTIFICATION_SOURCES = uint;
enum : uint
{
    WLAN_NOTIFICATION_SOURCE_NONE           = 0x00000000,
    WLAN_NOTIFICATION_SOURCE_ALL            = 0x0000ffff,
    WLAN_NOTIFICATION_SOURCE_ACM            = 0x00000008,
    WLAN_NOTIFICATION_SOURCE_MSM            = 0x00000010,
    WLAN_NOTIFICATION_SOURCE_SECURITY       = 0x00000020,
    WLAN_NOTIFICATION_SOURCE_IHV            = 0x00000040,
    WLAN_NOTIFICATION_SOURCE_HNWK           = 0x00000080,
    WLAN_NOTIFICATION_SOURCE_ONEX           = 0x00000004,
    WLAN_NOTIFICATION_SOURCE_DEVICE_SERVICE = 0x00000800,
}
alias DEVPROP_PCIROOTBUS_SECONDARYINTERFACE = uint;
enum : uint
{
    DevProp_PciRootBus_SecondaryInterface_PciConventional = 0x00000000,
    DevProp_PciRootBus_SecondaryInterface_PciXMode1       = 0x00000001,
    DevProp_PciRootBus_SecondaryInterface_PciXMode2       = 0x00000002,
    DevProp_PciRootBus_SecondaryInterface_PciExpress      = 0x00000003,
}
alias DEVPROP_PCIROOTBUS_CURRENTSPEEDANDMODE = uint;
enum : uint
{
    DevProp_PciRootBus_CurrentSpeedAndMode_Pci_Conventional_33Mhz = 0x00000000,
    DevProp_PciRootBus_CurrentSpeedAndMode_Pci_Conventional_66Mhz = 0x00000001,
    DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_Mode1_66Mhz      = 0x00000002,
    DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_Mode1_100Mhz     = 0x00000003,
    DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_Mode1_133Mhz     = 0x00000004,
    DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_Mode1_ECC_66Mhz  = 0x00000005,
    DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_Mode1_ECC_100Mhz = 0x00000006,
    DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_Mode1_ECC_133Mhz = 0x00000007,
    DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_266_Mode2_66Mhz  = 0x00000008,
    DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_266_Mode2_100Mhz = 0x00000009,
    DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_266_Mode2_133Mhz = 0x0000000a,
    DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_533_Mode2_66Mhz  = 0x0000000b,
    DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_533_Mode2_100Mhz = 0x0000000c,
    DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_533_Mode2_133Mhz = 0x0000000d,
}
alias DEVPROP_PCIROOTBUS_SUPPORTEDSPEEDSANDMODES = uint;
enum : uint
{
    DevProp_PciRootBus_SupportedSpeedsAndModes_Pci_Conventional_33Mhz = 0x00000001,
    DevProp_PciRootBus_SupportedSpeedsAndModes_Pci_Conventional_66Mhz = 0x00000002,
    DevProp_PciRootBus_SupportedSpeedsAndModes_Pci_X_66Mhz            = 0x00000004,
    DevProp_PciRootBus_SupportedSpeedsAndModes_Pci_X_133Mhz           = 0x00000008,
    DevProp_PciRootBus_SupportedSpeedsAndModes_Pci_X_266Mhz           = 0x00000010,
    DevProp_PciRootBus_SupportedSpeedsAndModes_Pci_X_533Mhz           = 0x00000020,
}
alias DEVPROP_PCIROOTBUS_BUSWIDTH = uint;
enum : uint
{
    DevProp_PciRootBus_BusWidth_32Bits = 0x00000000,
    DevProp_PciRootBus_BusWidth_64Bits = 0x00000001,
}
alias DEVPROP_PCIDEVICE_DEVICEBRIDGETYPE = uint;
enum : uint
{
    DevProp_PciDevice_DeviceType_PciConventional                         = 0x00000000,
    DevProp_PciDevice_DeviceType_PciX                                    = 0x00000001,
    DevProp_PciDevice_DeviceType_PciExpressEndpoint                      = 0x00000002,
    DevProp_PciDevice_DeviceType_PciExpressLegacyEndpoint                = 0x00000003,
    DevProp_PciDevice_DeviceType_PciExpressRootComplexIntegratedEndpoint = 0x00000004,
    DevProp_PciDevice_DeviceType_PciExpressTreatedAsPci                  = 0x00000005,
    DevProp_PciDevice_BridgeType_PciConventional                         = 0x00000006,
    DevProp_PciDevice_BridgeType_PciX                                    = 0x00000007,
    DevProp_PciDevice_BridgeType_PciExpressRootPort                      = 0x00000008,
    DevProp_PciDevice_BridgeType_PciExpressUpstreamSwitchPort            = 0x00000009,
    DevProp_PciDevice_BridgeType_PciExpressDownstreamSwitchPort          = 0x0000000a,
    DevProp_PciDevice_BridgeType_PciExpressToPciXBridge                  = 0x0000000b,
    DevProp_PciDevice_BridgeType_PciXToExpressBridge                     = 0x0000000c,
    DevProp_PciDevice_BridgeType_PciExpressTreatedAsPci                  = 0x0000000d,
    DevProp_PciDevice_BridgeType_PciExpressEventCollector                = 0x0000000e,
}
alias DEVPROP_PCIDEVICE_CURRENTSPEEDANDMODE = uint;
enum : uint
{
    DevProp_PciDevice_CurrentSpeedAndMode_Pci_Conventional_33MHz     = 0x00000000,
    DevProp_PciDevice_CurrentSpeedAndMode_Pci_Conventional_66MHz     = 0x00000001,
    DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode_Conventional_Pci = 0x00000000,
    DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode1_66Mhz           = 0x00000001,
    DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode1_100Mhz          = 0x00000002,
    DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode1_133MHZ          = 0x00000003,
    DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode1_ECC_66Mhz       = 0x00000005,
    DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode1_ECC_100Mhz      = 0x00000006,
    DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode1_ECC_133Mhz      = 0x00000007,
    DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode2_266_66MHz       = 0x00000009,
    DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode2_266_100MHz      = 0x0000000a,
    DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode2_266_133MHz      = 0x0000000b,
    DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode2_533_66MHz       = 0x0000000d,
    DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode2_533_100MHz      = 0x0000000e,
    DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode2_533_133MHz      = 0x0000000f,
}
alias DEVPROP_PCIEXPRESSDEVICE_PAYLOADORREQUESTSIZE = uint;
enum : uint
{
    DevProp_PciExpressDevice_PayloadOrRequestSize_128Bytes  = 0x00000000,
    DevProp_PciExpressDevice_PayloadOrRequestSize_256Bytes  = 0x00000001,
    DevProp_PciExpressDevice_PayloadOrRequestSize_512Bytes  = 0x00000002,
    DevProp_PciExpressDevice_PayloadOrRequestSize_1024Bytes = 0x00000003,
    DevProp_PciExpressDevice_PayloadOrRequestSize_2048Bytes = 0x00000004,
    DevProp_PciExpressDevice_PayloadOrRequestSize_4096Bytes = 0x00000005,
}
alias DEVPROP_PCIEXPRESSDEVICE_LINKSPEED = uint;
enum : uint
{
    DevProp_PciExpressDevice_LinkSpeed_TwoAndHalf_Gbps = 0x00000001,
    DevProp_PciExpressDevice_LinkSpeed_Five_Gbps       = 0x00000002,
}
alias DEVPROP_PCIEXPRESSDEVICE_LINKWIDTH = uint;
enum : uint
{
    DevProp_PciExpressDevice_LinkWidth_By_1  = 0x00000001,
    DevProp_PciExpressDevice_LinkWidth_By_2  = 0x00000002,
    DevProp_PciExpressDevice_LinkWidth_By_4  = 0x00000004,
    DevProp_PciExpressDevice_LinkWidth_By_8  = 0x00000008,
    DevProp_PciExpressDevice_LinkWidth_By_12 = 0x0000000c,
    DevProp_PciExpressDevice_LinkWidth_By_16 = 0x00000010,
    DevProp_PciExpressDevice_LinkWidth_By_32 = 0x00000020,
}
alias DEVPROP_PCIEXPRESSDEVICE_SPEC_VERSION = uint;
enum : uint
{
    DevProp_PciExpressDevice_Spec_Version_10 = 0x00000001,
    DevProp_PciExpressDevice_Spec_Version_11 = 0x00000002,
}
alias DEVPROP_PCIDEVICE_INTERRUPTTYPE = uint;
enum : uint
{
    DevProp_PciDevice_InterruptType_LineBased = 0x00000001,
    DevProp_PciDevice_InterruptType_Msi       = 0x00000002,
    DevProp_PciDevice_InterruptType_MsiX      = 0x00000004,
}
alias DEVPROP_PCIDEVICE_SRIOVSUPPORT = uint;
enum : uint
{
    DevProp_PciDevice_SriovSupport_Ok                 = 0x00000000,
    DevProp_PciDevice_SriovSupport_MissingAcs         = 0x00000001,
    DevProp_PciDevice_SriovSupport_MissingPfDriver    = 0x00000002,
    DevProp_PciDevice_SriovSupport_NoBusResource      = 0x00000003,
    DevProp_PciDevice_SriovSupport_DidntGetVfBarSpace = 0x00000004,
}
alias DEVPROP_PCIDEVICE_ACSSUPPORT = uint;
enum : uint
{
    DevProp_PciDevice_AcsSupport_Present   = 0x00000000,
    DevProp_PciDevice_AcsSupport_NotNeeded = 0x00000001,
    DevProp_PciDevice_AcsSupport_Missing   = 0x00000002,
}
alias DEVPROP_PCIDEVICE_ACSCOMPATIBLEUPHIERARCHY = uint;
enum : uint
{
    DevProp_PciDevice_AcsCompatibleUpHierarchy_NotSupported            = 0x00000000,
    DevProp_PciDevice_AcsCompatibleUpHierarchy_SingleFunctionSupported = 0x00000001,
    DevProp_PciDevice_AcsCompatibleUpHierarchy_NoP2PSupported          = 0x00000002,
    DevProp_PciDevice_AcsCompatibleUpHierarchy_Supported               = 0x00000003,
    DevProp_PciDevice_AcsCompatibleUpHierarchy_Enhanced                = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/NativeWiFi/dot11-bss-type))], [])
alias DOT11_BSS_TYPE = int;
enum : int
{
    dot11_BSS_type_infrastructure = 0x00000001,
    dot11_BSS_type_independent    = 0x00000002,
    dot11_BSS_type_any            = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/NativeWiFi/dot11-auth-algorithm))], [])
alias DOT11_AUTH_ALGORITHM = int;
enum : int
{
    DOT11_AUTH_ALGO_80211_OPEN       = 0x00000001,
    DOT11_AUTH_ALGO_80211_SHARED_KEY = 0x00000002,
    DOT11_AUTH_ALGO_WPA              = 0x00000003,
    DOT11_AUTH_ALGO_WPA_PSK          = 0x00000004,
    DOT11_AUTH_ALGO_WPA_NONE         = 0x00000005,
    DOT11_AUTH_ALGO_RSNA             = 0x00000006,
    DOT11_AUTH_ALGO_RSNA_PSK         = 0x00000007,
    DOT11_AUTH_ALGO_WPA3             = 0x00000008,
    DOT11_AUTH_ALGO_WPA3_ENT_192     = 0x00000008,
    DOT11_AUTH_ALGO_WPA3_SAE         = 0x00000009,
    DOT11_AUTH_ALGO_OWE              = 0x0000000a,
    DOT11_AUTH_ALGO_WPA3_ENT         = 0x0000000b,
    DOT11_AUTH_ALGO_IHV_START        = 0x80000000,
    DOT11_AUTH_ALGO_IHV_END          = 0xffffffff,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/NativeWiFi/dot11-cipher-algorithm))], [])
alias DOT11_CIPHER_ALGORITHM = int;
enum : int
{
    DOT11_CIPHER_ALGO_NONE          = 0x00000000,
    DOT11_CIPHER_ALGO_WEP40         = 0x00000001,
    DOT11_CIPHER_ALGO_TKIP          = 0x00000002,
    DOT11_CIPHER_ALGO_CCMP          = 0x00000004,
    DOT11_CIPHER_ALGO_WEP104        = 0x00000005,
    DOT11_CIPHER_ALGO_BIP           = 0x00000006,
    DOT11_CIPHER_ALGO_GCMP          = 0x00000008,
    DOT11_CIPHER_ALGO_GCMP_256      = 0x00000009,
    DOT11_CIPHER_ALGO_CCMP_256      = 0x0000000a,
    DOT11_CIPHER_ALGO_BIP_GMAC_128  = 0x0000000b,
    DOT11_CIPHER_ALGO_BIP_GMAC_256  = 0x0000000c,
    DOT11_CIPHER_ALGO_BIP_CMAC_256  = 0x0000000d,
    DOT11_CIPHER_ALGO_WPA_USE_GROUP = 0x00000100,
    DOT11_CIPHER_ALGO_RSN_USE_GROUP = 0x00000100,
    DOT11_CIPHER_ALGO_WEP           = 0x00000101,
    DOT11_CIPHER_ALGO_IHV_START     = 0x80000000,
    DOT11_CIPHER_ALGO_IHV_END       = 0xffffffff,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/NativeWiFi/dot11-phy-type))], [])
alias DOT11_PHY_TYPE = int;
enum : int
{
    dot11_phy_type_unknown    = 0x00000000,
    dot11_phy_type_any        = 0x00000000,
    dot11_phy_type_fhss       = 0x00000001,
    dot11_phy_type_dsss       = 0x00000002,
    dot11_phy_type_irbaseband = 0x00000003,
    dot11_phy_type_ofdm       = 0x00000004,
    dot11_phy_type_hrdsss     = 0x00000005,
    dot11_phy_type_erp        = 0x00000006,
    dot11_phy_type_ht         = 0x00000007,
    dot11_phy_type_vht        = 0x00000008,
    dot11_phy_type_dmg        = 0x00000009,
    dot11_phy_type_he         = 0x0000000a,
    dot11_phy_type_eht        = 0x0000000b,
    dot11_phy_type_IHV_start  = 0x80000000,
    dot11_phy_type_IHV_end    = 0xffffffff,
}
alias RSNA_AKM_SUITE = int;
enum : int
{
    rsna_akm_none                 = 0x00ac0f00,
    rsna_akm_1x                   = 0x01ac0f00,
    rsna_akm_psk                  = 0x02ac0f00,
    rsna_akm_ft_1x_sha256         = 0x03ac0f00,
    rsna_akm_ft_psk_sha256        = 0x04ac0f00,
    rsna_akm_1x_sha256            = 0x05ac0f00,
    rsna_akm_psk_sha256           = 0x06ac0f00,
    rsna_akm_tdls_sha256          = 0x07ac0f00,
    rsna_akm_sae_pmk256           = 0x08ac0f00,
    rsna_akm_ft_sae_pmk256        = 0x09ac0f00,
    rsna_akm_peerkey_sha256       = 0x0aac0f00,
    rsna_akm_1x_suite_b_sha256    = 0x0bac0f00,
    rsna_akm_1x_suite_b_sha384    = 0x0cac0f00,
    rsna_akm_ft_1x_sha384_cmp_256 = 0x0dac0f00,
    rsna_akm_fils_1x_sha256       = 0x0eac0f00,
    rsna_akm_fils_1x_sha384       = 0x0fac0f00,
    rsna_akm_ft_fils_1x_sha256    = 0x10ac0f00,
    rsna_akm_ft_fils_sha384       = 0x11ac0f00,
    rsna_akm_owe                  = 0x12ac0f00,
    rsna_akm_ft_psk_sha384        = 0x13ac0f00,
    rsna_akm_psk_sha384           = 0x14ac0f00,
    rsna_akm_ft_1x_sha384         = 0x16ac0f00,
    rsna_akm_1x_sha384            = 0x17ac0f00,
    rsna_akm_sae_pmk384           = 0x18ac0f00,
    rsna_akm_ft_sae_pmk384        = 0x19ac0f00,
    rsna_akm_max                  = 0x19ac0f00,
}
alias WPA_AKM_SUITE = int;
enum : int
{
    wpa_akm_none = 0x00f25000,
    wpa_akm_1x   = 0x01f25000,
    wpa_akm_psk  = 0x02f25000,
    wpa_akm_max  = 0x02f25000,
}
alias RSNA_CIPHER_SUITE = int;
enum : int
{
    rsna_cipher_group            = 0x00ac0f00,
    rsna_cipher_wep40            = 0x01ac0f00,
    rsna_cipher_tkip             = 0x02ac0f00,
    rsna_cipher_reserved         = 0x03ac0f00,
    rsna_cipher_ccmp_128         = 0x04ac0f00,
    rsna_cipher_wep104           = 0x05ac0f00,
    rsna_cipher_bip_cmac_128     = 0x06ac0f00,
    rsna_cipher_no_group_traffic = 0x07ac0f00,
    rsna_cipher_gcmp_128         = 0x08ac0f00,
    rsna_cipher_gcmp_256         = 0x09ac0f00,
    rsna_cipher_ccmp_256         = 0x0aac0f00,
    rsna_cipher_bip_gmac_128     = 0x0bac0f00,
    rsna_cipher_bip_gmac_256     = 0x0cac0f00,
    rsna_cipher_bip_cmac_256     = 0x0dac0f00,
    rsna_cipher_max              = 0x0dac0f00,
}
alias WPA_CIPHER_SUITE = int;
enum : int
{
    wpa_cipher_none         = 0x00f25000,
    wpa_cipher_wep40        = 0x01f25000,
    wpa_cipher_tkip         = 0x02f25000,
    wpa_cipher_ccmp_128     = 0x04f25000,
    wpa_cipher_wep104       = 0x05f25000,
    wpa_cipher_bip_cmac_128 = 0x06f25000,
    wpa_cipher_max          = 0x06f25000,
}
alias DOT11_OFFLOAD_TYPE = int;
enum : int
{
    dot11_offload_type_wep  = 0x00000001,
    dot11_offload_type_auth = 0x00000002,
}
alias DOT11_KEY_DIRECTION = int;
enum : int
{
    dot11_key_direction_both     = 0x00000001,
    dot11_key_direction_inbound  = 0x00000002,
    dot11_key_direction_outbound = 0x00000003,
}
alias DOT11_SCAN_TYPE = int;
enum : int
{
    dot11_scan_type_active  = 0x00000001,
    dot11_scan_type_passive = 0x00000002,
    dot11_scan_type_auto    = 0x00000003,
    dot11_scan_type_forced  = 0x80000000,
}
alias CH_DESCRIPTION_TYPE = int;
enum : int
{
    ch_description_type_logical          = 0x00000001,
    ch_description_type_center_frequency = 0x00000002,
    ch_description_type_phy_specific     = 0x00000003,
}
alias DOT11_UPDATE_IE_OP = int;
enum : int
{
    dot11_update_ie_op_create_replace = 0x00000001,
    dot11_update_ie_op_delete         = 0x00000002,
}
alias DOT11_RESET_TYPE = int;
enum : int
{
    dot11_reset_type_phy         = 0x00000001,
    dot11_reset_type_mac         = 0x00000002,
    dot11_reset_type_phy_and_mac = 0x00000003,
}
alias DOT11_POWER_MODE = int;
enum : int
{
    dot11_power_mode_unknown   = 0x00000000,
    dot11_power_mode_active    = 0x00000001,
    dot11_power_mode_powersave = 0x00000002,
}
alias DOT11_TEMP_TYPE = int;
enum : int
{
    dot11_temp_type_unknown = 0x00000000,
    dot11_temp_type_1       = 0x00000001,
    dot11_temp_type_2       = 0x00000002,
}
alias DOT11_DIVERSITY_SUPPORT = int;
enum : int
{
    dot11_diversity_support_unknown      = 0x00000000,
    dot11_diversity_support_fixedlist    = 0x00000001,
    dot11_diversity_support_notsupported = 0x00000002,
    dot11_diversity_support_dynamic      = 0x00000003,
}
alias DOT11_HOP_ALGO_ADOPTED = int;
enum : int
{
    dot11_hop_algo_current   = 0x00000000,
    dot11_hop_algo_hop_index = 0x00000001,
    dot11_hop_algo_hcc       = 0x00000002,
}
alias DOT11_AC_PARAM = int;
enum : int
{
    dot11_AC_param_BE  = 0x00000000,
    dot11_AC_param_BK  = 0x00000001,
    dot11_AC_param_VI  = 0x00000002,
    dot11_AC_param_VO  = 0x00000003,
    dot11_AC_param_max = 0x00000004,
}
alias DOT11_DIRECTION = int;
enum : int
{
    DOT11_DIR_INBOUND  = 0x00000001,
    DOT11_DIR_OUTBOUND = 0x00000002,
    DOT11_DIR_BOTH     = 0x00000003,
}
alias DOT11_ASSOCIATION_STATE = int;
enum : int
{
    dot11_assoc_state_zero           = 0x00000000,
    dot11_assoc_state_unauth_unassoc = 0x00000001,
    dot11_assoc_state_auth_unassoc   = 0x00000002,
    dot11_assoc_state_auth_assoc     = 0x00000003,
}
alias DOT11_DS_INFO = int;
enum : int
{
    DOT11_DS_CHANGED   = 0x00000000,
    DOT11_DS_UNCHANGED = 0x00000001,
    DOT11_DS_UNKNOWN   = 0x00000002,
}
alias DOT11_WPS_CONFIG_METHOD = int;
enum : int
{
    DOT11_WPS_CONFIG_METHOD_NULL          = 0x00000000,
    DOT11_WPS_CONFIG_METHOD_DISPLAY       = 0x00000008,
    DOT11_WPS_CONFIG_METHOD_NFC_TAG       = 0x00000020,
    DOT11_WPS_CONFIG_METHOD_NFC_INTERFACE = 0x00000040,
    DOT11_WPS_CONFIG_METHOD_PUSHBUTTON    = 0x00000080,
    DOT11_WPS_CONFIG_METHOD_KEYPAD        = 0x00000100,
    DOT11_WPS_CONFIG_METHOD_WFDS_DEFAULT  = 0x00001000,
}
alias DOT11_WPS_DEVICE_PASSWORD_ID = int;
enum : int
{
    DOT11_WPS_PASSWORD_ID_DEFAULT                 = 0x00000000,
    DOT11_WPS_PASSWORD_ID_USER_SPECIFIED          = 0x00000001,
    DOT11_WPS_PASSWORD_ID_MACHINE_SPECIFIED       = 0x00000002,
    DOT11_WPS_PASSWORD_ID_REKEY                   = 0x00000003,
    DOT11_WPS_PASSWORD_ID_PUSHBUTTON              = 0x00000004,
    DOT11_WPS_PASSWORD_ID_REGISTRAR_SPECIFIED     = 0x00000005,
    DOT11_WPS_PASSWORD_ID_NFC_CONNECTION_HANDOVER = 0x00000007,
    DOT11_WPS_PASSWORD_ID_WFD_SERVICES            = 0x00000008,
    DOT11_WPS_PASSWORD_ID_OOB_RANGE_MIN           = 0x00000010,
    DOT11_WPS_PASSWORD_ID_OOB_RANGE_MAX           = 0x0000ffff,
}
alias DOT11_ANQP_QUERY_RESULT = int;
enum : int
{
    dot11_ANQP_query_result_success                                        = 0x00000000,
    dot11_ANQP_query_result_failure                                        = 0x00000001,
    dot11_ANQP_query_result_timed_out                                      = 0x00000002,
    dot11_ANQP_query_result_resources                                      = 0x00000003,
    dot11_ANQP_query_result_advertisement_protocol_not_supported_on_remote = 0x00000004,
    dot11_ANQP_query_result_gas_protocol_failure                           = 0x00000005,
    dot11_ANQP_query_result_advertisement_server_not_responding            = 0x00000006,
    dot11_ANQP_query_result_access_issues                                  = 0x00000007,
}
alias DOT11_WFD_DISCOVER_TYPE = int;
enum : int
{
    dot11_wfd_discover_type_scan_only            = 0x00000001,
    dot11_wfd_discover_type_find_only            = 0x00000002,
    dot11_wfd_discover_type_auto                 = 0x00000003,
    dot11_wfd_discover_type_scan_social_channels = 0x00000004,
    dot11_wfd_discover_type_forced               = 0x80000000,
}
alias DOT11_WFD_SCAN_TYPE = int;
enum : int
{
    dot11_wfd_scan_type_active  = 0x00000001,
    dot11_wfd_scan_type_passive = 0x00000002,
    dot11_wfd_scan_type_auto    = 0x00000003,
}
alias DOT11_POWER_MODE_REASON = int;
enum : int
{
    dot11_power_mode_reason_no_change            = 0x00000000,
    dot11_power_mode_reason_noncompliant_AP      = 0x00000001,
    dot11_power_mode_reason_legacy_WFD_device    = 0x00000002,
    dot11_power_mode_reason_compliant_AP         = 0x00000003,
    dot11_power_mode_reason_compliant_WFD_device = 0x00000004,
    dot11_power_mode_reason_others               = 0x00000005,
}
alias DOT11_MANUFACTURING_TEST_TYPE = int;
enum : int
{
    dot11_manufacturing_test_unknown           = 0x00000000,
    dot11_manufacturing_test_self_start        = 0x00000001,
    dot11_manufacturing_test_self_query_result = 0x00000002,
    dot11_manufacturing_test_rx                = 0x00000003,
    dot11_manufacturing_test_tx                = 0x00000004,
    dot11_manufacturing_test_query_adc         = 0x00000005,
    dot11_manufacturing_test_set_data          = 0x00000006,
    dot11_manufacturing_test_query_data        = 0x00000007,
    dot11_manufacturing_test_sleep             = 0x00000008,
    dot11_manufacturing_test_awake             = 0x00000009,
    dot11_manufacturing_test_IHV_start         = 0x80000000,
    dot11_manufacturing_test_IHV_end           = 0xffffffff,
}
alias DOT11_MANUFACTURING_SELF_TEST_TYPE = int;
enum : int
{
    DOT11_MANUFACTURING_SELF_TEST_TYPE_INTERFACE      = 0x00000001,
    DOT11_MANUFACTURING_SELF_TEST_TYPE_RF_INTERFACE   = 0x00000002,
    DOT11_MANUFACTURING_SELF_TEST_TYPE_BT_COEXISTENCE = 0x00000003,
}
alias DOT11_BAND = int;
enum : int
{
    dot11_band_2p4g = 0x00000001,
    dot11_band_4p9g = 0x00000002,
    dot11_band_5g   = 0x00000003,
}
alias DOT11_MANUFACTURING_CALLBACK_TYPE = int;
enum : int
{
    dot11_manufacturing_callback_unknown            = 0x00000000,
    dot11_manufacturing_callback_self_test_complete = 0x00000001,
    dot11_manufacturing_callback_sleep_complete     = 0x00000002,
    dot11_manufacturing_callback_IHV_start          = 0x80000000,
    dot11_manufacturing_callback_IHV_end            = 0xffffffff,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ne-wlanapi-wlan_connection_mode))], [])
alias WLAN_CONNECTION_MODE = int;
enum : int
{
    wlan_connection_mode_profile            = 0x00000000,
    wlan_connection_mode_temporary_profile  = 0x00000001,
    wlan_connection_mode_discovery_secure   = 0x00000002,
    wlan_connection_mode_discovery_unsecure = 0x00000003,
    wlan_connection_mode_auto               = 0x00000004,
    wlan_connection_mode_invalid            = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ne-wlanapi-wlan_interface_state~r1))], [])
alias WLAN_INTERFACE_STATE = int;
enum : int
{
    wlan_interface_state_not_ready             = 0x00000000,
    wlan_interface_state_connected             = 0x00000001,
    wlan_interface_state_ad_hoc_network_formed = 0x00000002,
    wlan_interface_state_disconnecting         = 0x00000003,
    wlan_interface_state_disconnected          = 0x00000004,
    wlan_interface_state_associating           = 0x00000005,
    wlan_interface_state_discovering           = 0x00000006,
    wlan_interface_state_authenticating        = 0x00000007,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ne-wlanapi-wlan_adhoc_network_state~r1))], [])
alias WLAN_ADHOC_NETWORK_STATE = int;
enum : int
{
    wlan_adhoc_network_state_formed    = 0x00000000,
    wlan_adhoc_network_state_connected = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ne-wlanapi-dot11_radio_state~r1))], [])
alias DOT11_RADIO_STATE = int;
enum : int
{
    dot11_radio_state_unknown = 0x00000000,
    dot11_radio_state_on      = 0x00000001,
    dot11_radio_state_off     = 0x00000002,
}
alias WLAN_OPERATIONAL_STATE = int;
enum : int
{
    wlan_operational_state_unknown   = 0x00000000,
    wlan_operational_state_off       = 0x00000001,
    wlan_operational_state_on        = 0x00000002,
    wlan_operational_state_going_off = 0x00000003,
    wlan_operational_state_going_on  = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ne-wlanapi-wlan_interface_type))], [])
alias WLAN_INTERFACE_TYPE = int;
enum : int
{
    wlan_interface_type_emulated_802_11 = 0x00000000,
    wlan_interface_type_native_802_11   = 0x00000001,
    wlan_interface_type_invalid         = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ne-wlanapi-wlan_power_setting~r1))], [])
alias WLAN_POWER_SETTING = int;
enum : int
{
    wlan_power_setting_no_saving      = 0x00000000,
    wlan_power_setting_low_saving     = 0x00000001,
    wlan_power_setting_medium_saving  = 0x00000002,
    wlan_power_setting_maximum_saving = 0x00000003,
    wlan_power_setting_invalid        = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ne-wlanapi-wlan_notification_acm~r1))], [])
alias WLAN_NOTIFICATION_ACM = int;
enum : int
{
    wlan_notification_acm_start                      = 0x00000000,
    wlan_notification_acm_autoconf_enabled           = 0x00000001,
    wlan_notification_acm_autoconf_disabled          = 0x00000002,
    wlan_notification_acm_background_scan_enabled    = 0x00000003,
    wlan_notification_acm_background_scan_disabled   = 0x00000004,
    wlan_notification_acm_bss_type_change            = 0x00000005,
    wlan_notification_acm_power_setting_change       = 0x00000006,
    wlan_notification_acm_scan_complete              = 0x00000007,
    wlan_notification_acm_scan_fail                  = 0x00000008,
    wlan_notification_acm_connection_start           = 0x00000009,
    wlan_notification_acm_connection_complete        = 0x0000000a,
    wlan_notification_acm_connection_attempt_fail    = 0x0000000b,
    wlan_notification_acm_filter_list_change         = 0x0000000c,
    wlan_notification_acm_interface_arrival          = 0x0000000d,
    wlan_notification_acm_interface_removal          = 0x0000000e,
    wlan_notification_acm_profile_change             = 0x0000000f,
    wlan_notification_acm_profile_name_change        = 0x00000010,
    wlan_notification_acm_profiles_exhausted         = 0x00000011,
    wlan_notification_acm_network_not_available      = 0x00000012,
    wlan_notification_acm_network_available          = 0x00000013,
    wlan_notification_acm_disconnecting              = 0x00000014,
    wlan_notification_acm_disconnected               = 0x00000015,
    wlan_notification_acm_adhoc_network_state_change = 0x00000016,
    wlan_notification_acm_profile_unblocked          = 0x00000017,
    wlan_notification_acm_screen_power_change        = 0x00000018,
    wlan_notification_acm_profile_blocked            = 0x00000019,
    wlan_notification_acm_scan_list_refresh          = 0x0000001a,
    wlan_notification_acm_operational_state_change   = 0x0000001b,
    wlan_notification_acm_end                        = 0x0000001c,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ne-wlanapi-wlan_notification_msm~r1))], [])
alias WLAN_NOTIFICATION_MSM = int;
enum : int
{
    wlan_notification_msm_start                         = 0x00000000,
    wlan_notification_msm_associating                   = 0x00000001,
    wlan_notification_msm_associated                    = 0x00000002,
    wlan_notification_msm_authenticating                = 0x00000003,
    wlan_notification_msm_connected                     = 0x00000004,
    wlan_notification_msm_roaming_start                 = 0x00000005,
    wlan_notification_msm_roaming_end                   = 0x00000006,
    wlan_notification_msm_radio_state_change            = 0x00000007,
    wlan_notification_msm_signal_quality_change         = 0x00000008,
    wlan_notification_msm_disassociating                = 0x00000009,
    wlan_notification_msm_disconnected                  = 0x0000000a,
    wlan_notification_msm_peer_join                     = 0x0000000b,
    wlan_notification_msm_peer_leave                    = 0x0000000c,
    wlan_notification_msm_adapter_removal               = 0x0000000d,
    wlan_notification_msm_adapter_operation_mode_change = 0x0000000e,
    wlan_notification_msm_link_degraded                 = 0x0000000f,
    wlan_notification_msm_link_improved                 = 0x00000010,
    wlan_notification_msm_end                           = 0x00000011,
}
alias WLAN_NOTIFICATION_SECURITY = int;
enum : int
{
    wlan_notification_security_start = 0x00000000,
    wlan_notification_security_end   = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ne-wlanapi-wlan_opcode_value_type~r1))], [])
alias WLAN_OPCODE_VALUE_TYPE = int;
enum : int
{
    wlan_opcode_value_type_query_only          = 0x00000000,
    wlan_opcode_value_type_set_by_group_policy = 0x00000001,
    wlan_opcode_value_type_set_by_user         = 0x00000002,
    wlan_opcode_value_type_invalid             = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ne-wlanapi-wlan_intf_opcode~r1))], [])
alias WLAN_INTF_OPCODE = int;
enum : int
{
    wlan_intf_opcode_autoconf_start                             = 0x00000000,
    wlan_intf_opcode_autoconf_enabled                           = 0x00000001,
    wlan_intf_opcode_background_scan_enabled                    = 0x00000002,
    wlan_intf_opcode_media_streaming_mode                       = 0x00000003,
    wlan_intf_opcode_radio_state                                = 0x00000004,
    wlan_intf_opcode_bss_type                                   = 0x00000005,
    wlan_intf_opcode_interface_state                            = 0x00000006,
    wlan_intf_opcode_current_connection                         = 0x00000007,
    wlan_intf_opcode_channel_number                             = 0x00000008,
    wlan_intf_opcode_supported_infrastructure_auth_cipher_pairs = 0x00000009,
    wlan_intf_opcode_supported_adhoc_auth_cipher_pairs          = 0x0000000a,
    wlan_intf_opcode_supported_country_or_region_string_list    = 0x0000000b,
    wlan_intf_opcode_current_operation_mode                     = 0x0000000c,
    wlan_intf_opcode_supported_safe_mode                        = 0x0000000d,
    wlan_intf_opcode_certified_safe_mode                        = 0x0000000e,
    wlan_intf_opcode_hosted_network_capable                     = 0x0000000f,
    wlan_intf_opcode_management_frame_protection_capable        = 0x00000010,
    wlan_intf_opcode_secondary_sta_interfaces                   = 0x00000011,
    wlan_intf_opcode_secondary_sta_synchronized_connections     = 0x00000012,
    wlan_intf_opcode_realtime_connection_quality                = 0x00000013,
    wlan_intf_opcode_qos_info                                   = 0x00000014,
    wlan_intf_opcode_autoconf_end                               = 0x0fffffff,
    wlan_intf_opcode_msm_start                                  = 0x10000100,
    wlan_intf_opcode_statistics                                 = 0x10000101,
    wlan_intf_opcode_rssi                                       = 0x10000102,
    wlan_intf_opcode_msm_end                                    = 0x1fffffff,
    wlan_intf_opcode_security_start                             = 0x20010000,
    wlan_intf_opcode_security_end                               = 0x2fffffff,
    wlan_intf_opcode_ihv_start                                  = 0x30000000,
    wlan_intf_opcode_ihv_end                                    = 0x3fffffff,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ne-wlanapi-wlan_autoconf_opcode~r1))], [])
alias WLAN_AUTOCONF_OPCODE = int;
enum : int
{
    wlan_autoconf_opcode_start                                     = 0x00000000,
    wlan_autoconf_opcode_show_denied_networks                      = 0x00000001,
    wlan_autoconf_opcode_power_setting                             = 0x00000002,
    wlan_autoconf_opcode_only_use_gp_profiles_for_allowed_networks = 0x00000003,
    wlan_autoconf_opcode_allow_explicit_creds                      = 0x00000004,
    wlan_autoconf_opcode_block_period                              = 0x00000005,
    wlan_autoconf_opcode_allow_virtual_station_extensibility       = 0x00000006,
    wlan_autoconf_opcode_end                                       = 0x00000007,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ne-wlanapi-wlan_ihv_control_type~r1))], [])
alias WLAN_IHV_CONTROL_TYPE = int;
enum : int
{
    wlan_ihv_control_type_service = 0x00000000,
    wlan_ihv_control_type_driver  = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ne-wlanapi-wlan_filter_list_type))], [])
alias WLAN_FILTER_LIST_TYPE = int;
enum : int
{
    wlan_filter_list_type_gp_permit   = 0x00000000,
    wlan_filter_list_type_gp_deny     = 0x00000001,
    wlan_filter_list_type_user_permit = 0x00000002,
    wlan_filter_list_type_user_deny   = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ne-wlanapi-wlan_securable_object))], [])
alias WLAN_SECURABLE_OBJECT = int;
enum : int
{
    wlan_secure_permit_list                    = 0x00000000,
    wlan_secure_deny_list                      = 0x00000001,
    wlan_secure_ac_enabled                     = 0x00000002,
    wlan_secure_bc_scan_enabled                = 0x00000003,
    wlan_secure_bss_type                       = 0x00000004,
    wlan_secure_show_denied                    = 0x00000005,
    wlan_secure_interface_properties           = 0x00000006,
    wlan_secure_ihv_control                    = 0x00000007,
    wlan_secure_all_user_profiles_order        = 0x00000008,
    wlan_secure_add_new_all_user_profiles      = 0x00000009,
    wlan_secure_add_new_per_user_profiles      = 0x0000000a,
    wlan_secure_media_streaming_mode_enabled   = 0x0000000b,
    wlan_secure_current_operation_mode         = 0x0000000c,
    wlan_secure_get_plaintext_key              = 0x0000000d,
    wlan_secure_hosted_network_elevated_access = 0x0000000e,
    wlan_secure_virtual_station_extensibility  = 0x0000000f,
    wlan_secure_wfd_elevated_access            = 0x00000010,
    WLAN_SECURABLE_OBJECT_COUNT                = 0x00000011,
}
alias WFD_ROLE_TYPE = int;
enum : int
{
    WFD_ROLE_TYPE_NONE        = 0x00000000,
    WFD_ROLE_TYPE_DEVICE      = 0x00000001,
    WFD_ROLE_TYPE_GROUP_OWNER = 0x00000002,
    WFD_ROLE_TYPE_CLIENT      = 0x00000004,
    WFD_ROLE_TYPE_MAX         = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ne-wlanapi-wl_display_pages))], [])
alias WL_DISPLAY_PAGES = int;
enum : int
{
    WLConnectionPage = 0x00000000,
    WLSecurityPage   = 0x00000001,
    WLAdvPage        = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ne-wlanapi-wlan_hosted_network_state))], [])
alias WLAN_HOSTED_NETWORK_STATE = int;
enum : int
{
    wlan_hosted_network_unavailable = 0x00000000,
    wlan_hosted_network_idle        = 0x00000001,
    wlan_hosted_network_active      = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ne-wlanapi-wlan_hosted_network_reason))], [])
alias WLAN_HOSTED_NETWORK_REASON = int;
enum : int
{
    wlan_hosted_network_reason_success                              = 0x00000000,
    wlan_hosted_network_reason_unspecified                          = 0x00000001,
    wlan_hosted_network_reason_bad_parameters                       = 0x00000002,
    wlan_hosted_network_reason_service_shutting_down                = 0x00000003,
    wlan_hosted_network_reason_insufficient_resources               = 0x00000004,
    wlan_hosted_network_reason_elevation_required                   = 0x00000005,
    wlan_hosted_network_reason_read_only                            = 0x00000006,
    wlan_hosted_network_reason_persistence_failed                   = 0x00000007,
    wlan_hosted_network_reason_crypt_error                          = 0x00000008,
    wlan_hosted_network_reason_impersonation                        = 0x00000009,
    wlan_hosted_network_reason_stop_before_start                    = 0x0000000a,
    wlan_hosted_network_reason_interface_available                  = 0x0000000b,
    wlan_hosted_network_reason_interface_unavailable                = 0x0000000c,
    wlan_hosted_network_reason_miniport_stopped                     = 0x0000000d,
    wlan_hosted_network_reason_miniport_started                     = 0x0000000e,
    wlan_hosted_network_reason_incompatible_connection_started      = 0x0000000f,
    wlan_hosted_network_reason_incompatible_connection_stopped      = 0x00000010,
    wlan_hosted_network_reason_user_action                          = 0x00000011,
    wlan_hosted_network_reason_client_abort                         = 0x00000012,
    wlan_hosted_network_reason_ap_start_failed                      = 0x00000013,
    wlan_hosted_network_reason_peer_arrived                         = 0x00000014,
    wlan_hosted_network_reason_peer_departed                        = 0x00000015,
    wlan_hosted_network_reason_peer_timeout                         = 0x00000016,
    wlan_hosted_network_reason_gp_denied                            = 0x00000017,
    wlan_hosted_network_reason_service_unavailable                  = 0x00000018,
    wlan_hosted_network_reason_device_change                        = 0x00000019,
    wlan_hosted_network_reason_properties_change                    = 0x0000001a,
    wlan_hosted_network_reason_virtual_station_blocking_use         = 0x0000001b,
    wlan_hosted_network_reason_service_available_on_virtual_station = 0x0000001c,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ne-wlanapi-wlan_hosted_network_peer_auth_state))], [])
alias WLAN_HOSTED_NETWORK_PEER_AUTH_STATE = int;
enum : int
{
    wlan_hosted_network_peer_state_invalid       = 0x00000000,
    wlan_hosted_network_peer_state_authenticated = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ne-wlanapi-wlan_hosted_network_notification_code))], [])
alias WLAN_HOSTED_NETWORK_NOTIFICATION_CODE = int;
enum : int
{
    wlan_hosted_network_state_change       = 0x00001000,
    wlan_hosted_network_peer_state_change  = 0x00001001,
    wlan_hosted_network_radio_state_change = 0x00001002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ne-wlanapi-wlan_hosted_network_opcode))], [])
alias WLAN_HOSTED_NETWORK_OPCODE = int;
enum : int
{
    wlan_hosted_network_opcode_connection_settings = 0x00000000,
    wlan_hosted_network_opcode_security_settings   = 0x00000001,
    wlan_hosted_network_opcode_station_profile     = 0x00000002,
    wlan_hosted_network_opcode_enable              = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dot1x/ne-dot1x-onex_auth_identity))], [])
alias ONEX_AUTH_IDENTITY = int;
enum : int
{
    OneXAuthIdentityNone         = 0x00000000,
    OneXAuthIdentityMachine      = 0x00000001,
    OneXAuthIdentityUser         = 0x00000002,
    OneXAuthIdentityExplicitUser = 0x00000003,
    OneXAuthIdentityGuest        = 0x00000004,
    OneXAuthIdentityInvalid      = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dot1x/ne-dot1x-onex_auth_status))], [])
alias ONEX_AUTH_STATUS = int;
enum : int
{
    OneXAuthNotStarted           = 0x00000000,
    OneXAuthInProgress           = 0x00000001,
    OneXAuthNoAuthenticatorFound = 0x00000002,
    OneXAuthSuccess              = 0x00000003,
    OneXAuthFailure              = 0x00000004,
    OneXAuthInvalid              = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dot1x/ne-dot1x-onex_reason_code))], [])
alias ONEX_REASON_CODE = int;
enum : int
{
    ONEX_REASON_CODE_SUCCESS                       = 0x00000000,
    ONEX_REASON_START                              = 0x00050000,
    ONEX_UNABLE_TO_IDENTIFY_USER                   = 0x00050001,
    ONEX_IDENTITY_NOT_FOUND                        = 0x00050002,
    ONEX_UI_DISABLED                               = 0x00050003,
    ONEX_UI_FAILURE                                = 0x00050004,
    ONEX_EAP_FAILURE_RECEIVED                      = 0x00050005,
    ONEX_AUTHENTICATOR_NO_LONGER_PRESENT           = 0x00050006,
    ONEX_NO_RESPONSE_TO_IDENTITY                   = 0x00050007,
    ONEX_PROFILE_VERSION_NOT_SUPPORTED             = 0x00050008,
    ONEX_PROFILE_INVALID_LENGTH                    = 0x00050009,
    ONEX_PROFILE_DISALLOWED_EAP_TYPE               = 0x0005000a,
    ONEX_PROFILE_INVALID_EAP_TYPE_OR_FLAG          = 0x0005000b,
    ONEX_PROFILE_INVALID_ONEX_FLAGS                = 0x0005000c,
    ONEX_PROFILE_INVALID_TIMER_VALUE               = 0x0005000d,
    ONEX_PROFILE_INVALID_SUPPLICANT_MODE           = 0x0005000e,
    ONEX_PROFILE_INVALID_AUTH_MODE                 = 0x0005000f,
    ONEX_PROFILE_INVALID_EAP_CONNECTION_PROPERTIES = 0x00050010,
    ONEX_UI_CANCELLED                              = 0x00050011,
    ONEX_PROFILE_INVALID_EXPLICIT_CREDENTIALS      = 0x00050012,
    ONEX_PROFILE_EXPIRED_EXPLICIT_CREDENTIALS      = 0x00050013,
    ONEX_UI_NOT_PERMITTED                          = 0x00050014,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dot1x/ne-dot1x-onex_notification_type))], [])
alias ONEX_NOTIFICATION_TYPE = int;
enum : int
{
    OneXPublicNotificationBase        = 0x00000000,
    OneXNotificationTypeResultUpdate  = 0x00000001,
    OneXNotificationTypeAuthRestarted = 0x00000002,
    OneXNotificationTypeEventInvalid  = 0x00000003,
    OneXNumNotifications              = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dot1x/ne-dot1x-onex_auth_restart_reason))], [])
alias ONEX_AUTH_RESTART_REASON = int;
enum : int
{
    OneXRestartReasonPeerInitiated            = 0x00000000,
    OneXRestartReasonMsmInitiated             = 0x00000001,
    OneXRestartReasonOneXHeldStateTimeout     = 0x00000002,
    OneXRestartReasonOneXAuthTimeout          = 0x00000003,
    OneXRestartReasonOneXConfigurationChanged = 0x00000004,
    OneXRestartReasonOneXUserChanged          = 0x00000005,
    OneXRestartReasonQuarantineStateChanged   = 0x00000006,
    OneXRestartReasonAltCredsTrial            = 0x00000007,
    OneXRestartReasonInvalid                  = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dot1x/ne-dot1x-onex_eap_method_backend_support))], [])
alias ONEX_EAP_METHOD_BACKEND_SUPPORT = int;
enum : int
{
    OneXEapMethodBackendSupportUnknown = 0x00000000,
    OneXEapMethodBackendSupported      = 0x00000001,
    OneXEapMethodBackendUnsupported    = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/ne-adhoc-dot11_adhoc_cipher_algorithm))], [])
alias DOT11_ADHOC_CIPHER_ALGORITHM = int;
enum : int
{
    DOT11_ADHOC_CIPHER_ALGO_INVALID = 0xffffffff,
    DOT11_ADHOC_CIPHER_ALGO_NONE    = 0x00000000,
    DOT11_ADHOC_CIPHER_ALGO_CCMP    = 0x00000004,
    DOT11_ADHOC_CIPHER_ALGO_WEP     = 0x00000101,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/ne-adhoc-dot11_adhoc_auth_algorithm))], [])
alias DOT11_ADHOC_AUTH_ALGORITHM = int;
enum : int
{
    DOT11_ADHOC_AUTH_ALGO_INVALID    = 0xffffffff,
    DOT11_ADHOC_AUTH_ALGO_80211_OPEN = 0x00000001,
    DOT11_ADHOC_AUTH_ALGO_RSNA_PSK   = 0x00000007,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/ne-adhoc-dot11_adhoc_network_connection_status))], [])
alias DOT11_ADHOC_NETWORK_CONNECTION_STATUS = int;
enum : int
{
    DOT11_ADHOC_NETWORK_CONNECTION_STATUS_INVALID      = 0x00000000,
    DOT11_ADHOC_NETWORK_CONNECTION_STATUS_DISCONNECTED = 0x0000000b,
    DOT11_ADHOC_NETWORK_CONNECTION_STATUS_CONNECTING   = 0x0000000c,
    DOT11_ADHOC_NETWORK_CONNECTION_STATUS_CONNECTED    = 0x0000000d,
    DOT11_ADHOC_NETWORK_CONNECTION_STATUS_FORMED       = 0x0000000e,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/ne-adhoc-dot11_adhoc_connect_fail_reason))], [])
alias DOT11_ADHOC_CONNECT_FAIL_REASON = int;
enum : int
{
    DOT11_ADHOC_CONNECT_FAIL_DOMAIN_MISMATCH     = 0x00000000,
    DOT11_ADHOC_CONNECT_FAIL_PASSPHRASE_MISMATCH = 0x00000001,
    DOT11_ADHOC_CONNECT_FAIL_OTHER               = 0x00000002,
}
alias DOT11EXT_IHV_CONNECTION_PHASE = int;
enum : int
{
    connection_phase_any                = 0x00000000,
    connection_phase_initial_connection = 0x00000001,
    connection_phase_post_l3_connection = 0x00000002,
}
alias DOT11_MSONEX_RESULT = int;
enum : int
{
    DOT11_MSONEX_SUCCESS     = 0x00000000,
    DOT11_MSONEX_FAILURE     = 0x00000001,
    DOT11_MSONEX_IN_PROGRESS = 0x00000002,
}
alias DOT11EXT_IHV_INDICATION_TYPE = int;
enum : int
{
    IndicationTypeNicSpecificNotification = 0x00000000,
    IndicationTypePmkidCandidateList      = 0x00000001,
    IndicationTypeTkipMicFailure          = 0x00000002,
    IndicationTypePhyStateChange          = 0x00000003,
    IndicationTypeLinkQuality             = 0x00000004,
}

// Constants


enum : uint
{
    L2_REASON_CODE_DOT11_AC_BASE       = 0x00020000,
    L2_REASON_CODE_DOT11_MSM_BASE      = 0x00030000,
    L2_REASON_CODE_DOT11_SECURITY_BASE = 0x00040000,
    L2_REASON_CODE_ONEX_BASE           = 0x00050000,
    L2_REASON_CODE_DOT3_AC_BASE        = 0x00060000,
    L2_REASON_CODE_DOT3_MSM_BASE       = 0x00070000,
    L2_REASON_CODE_PROFILE_BASE        = 0x00080000,
    L2_REASON_CODE_IHV_BASE            = 0x00090000,
    L2_REASON_CODE_WIMAX_BASE          = 0x000a0000,
    L2_REASON_CODE_RESERVED_BASE       = 0x000b0000,
}

enum : uint
{
    WLAN_REASON_CODE_SUCCESS              = 0x00000000,
    WLAN_REASON_CODE_UNKNOWN              = 0x00010001,
    WLAN_REASON_CODE_RANGE_SIZE           = 0x00010000,
    WLAN_REASON_CODE_BASE                 = 0x00020000,
    WLAN_REASON_CODE_AC_BASE              = 0x00020000,
    WLAN_REASON_CODE_AC_CONNECT_BASE      = 0x00028000,
    WLAN_REASON_CODE_AC_END               = 0x0002ffff,
    WLAN_REASON_CODE_PROFILE_BASE         = 0x00080000,
    WLAN_REASON_CODE_PROFILE_CONNECT_BASE = 0x00088000,
    WLAN_REASON_CODE_PROFILE_END          = 0x0008ffff,
    WLAN_REASON_CODE_MSM_BASE             = 0x00030000,
    WLAN_REASON_CODE_MSM_CONNECT_BASE     = 0x00038000,
    WLAN_REASON_CODE_MSM_END              = 0x0003ffff,
    WLAN_REASON_CODE_MSMSEC_BASE          = 0x00040000,
    WLAN_REASON_CODE_MSMSEC_CONNECT_BASE  = 0x00048000,
    WLAN_REASON_CODE_MSMSEC_END           = 0x0004ffff,
    WLAN_REASON_CODE_RESERVED_BASE        = 0x000b0000,
    WLAN_REASON_CODE_RESERVED_END         = 0x000bffff,
}

enum uint L2_PROFILE_MAX_NAME_LENGTH = 0x00000100;

enum : uint
{
    L2_NOTIFICATION_SOURCE_NONE                = 0x00000000,
    L2_NOTIFICATION_SOURCE_DOT3_AUTO_CONFIG    = 0x00000001,
    L2_NOTIFICATION_SOURCE_SECURITY            = 0x00000002,
    L2_NOTIFICATION_SOURCE_ONEX                = 0x00000004,
    L2_NOTIFICATION_SOURCE_WLAN_ACM            = 0x00000008,
    L2_NOTIFICATION_SOURCE_WLAN_MSM            = 0x00000010,
    L2_NOTIFICATION_SOURCE_WLAN_SECURITY       = 0x00000020,
    L2_NOTIFICATION_SOURCE_WLAN_IHV            = 0x00000040,
    L2_NOTIFICATION_SOURCE_WLAN_HNWK           = 0x00000080,
    L2_NOTIFICATION_SOURCE_WCM                 = 0x00000100,
    L2_NOTIFICATION_SOURCE_WCM_CSP             = 0x00000200,
    L2_NOTIFICATION_SOURCE_WFD                 = 0x00000400,
    L2_NOTIFICATION_SOURCE_WLAN_DEVICE_SERVICE = 0x00000800,
    L2_NOTIFICATION_SOURCE_ALL                 = 0x0000ffff,
    L2_NOTIFICATION_CODE_PUBLIC_BEGIN          = 0x00000000,
    L2_NOTIFICATION_CODE_GROUP_SIZE            = 0x00001000,
}

enum : uint
{
    L2_REASON_CODE_GROUP_SIZE      = 0x00010000,
    L2_REASON_CODE_GEN_BASE        = 0x00010000,
    L2_REASON_CODE_SUCCESS         = 0x00000000,
    L2_REASON_CODE_UNKNOWN         = 0x00010001,
    L2_REASON_CODE_PROFILE_MISSING = 0x00000001,
}

enum uint DOT11_BSSID_LIST_REVISION_1 = 0x00000001;
enum uint DOT11_HESSID_LENGTH = 0x00000006;
enum uint RSNA_OUI_PREFIX = 0x00ac0f00;
enum uint WPA_OUI_PREFIX = 0x00f25000;
enum uint DOT11_RATE_SET_MAX_LENGTH = 0x0000007e;
enum uint DOT11_WFD_SERVICE_NAME_MAX_LENGTH = 0x000000ff;
enum uint DOT11_WFD_APS2_SERVICE_TYPE_MAX_LENGTH = 0x00000015;
enum uint DOT11_WFD_ASP2_INSTANCE_NAME_MAX_LENGTH = 0x0000003f;
enum uint DOT11_WFD_SERVICE_INFORMATION_MAX_LENGTH = 0x0000ffff;
enum uint DOT11_MAX_REQUESTED_SERVICE_INFORMATION_LENGTH = 0x000000ff;
enum uint DOT11_WFD_SESSION_INFO_MAX_LENGTH = 0x00000090;

enum : uint
{
    NDIS_PACKET_TYPE_802_11_DIRECTED_DATA      = 0x00000001,
    NDIS_PACKET_TYPE_802_11_BROADCAST_DATA     = 0x00000008,
    NDIS_PACKET_TYPE_802_11_MULTICAST_DATA     = 0x00000002,
    NDIS_PACKET_TYPE_802_11_ALL_MULTICAST_DATA = 0x00000004,
    NDIS_PACKET_TYPE_802_11_PROMISCUOUS_DATA   = 0x00000020,
}

enum uint DOT11_MAX_PDU_SIZE = 0x0000092a;
enum uint DOT11_MIN_PDU_SIZE = 0x00000100;

enum : uint
{
    DOT11_MAX_NUM_DEFAULT_KEY     = 0x00000004,
    DOT11_MAX_NUM_DEFAULT_KEY_MFP = 0x00000006,
}

enum : uint
{
    OID_DOT11_NDIS_START         = 0x0d010300,
    OID_DOT11_OFFLOAD_CAPABILITY = 0x0d010300,
}

enum : uint
{
    DOT11_HW_WEP_SUPPORTED_TX = 0x00000001,
    DOT11_HW_WEP_SUPPORTED_RX = 0x00000002,
}

enum uint DOT11_HW_FRAGMENTATION_SUPPORTED = 0x00000004;
enum uint DOT11_HW_DEFRAGMENTATION_SUPPORTED = 0x00000008;

enum : uint
{
    DOT11_HW_MSDU_AUTH_SUPPORTED_TX = 0x00000010,
    DOT11_HW_MSDU_AUTH_SUPPORTED_RX = 0x00000020,
}

enum : uint
{
    DOT11_CONF_ALGO_WEP_RC4 = 0x00000001,
    DOT11_CONF_ALGO_TKIP    = 0x00000002,
}

enum uint DOT11_AUTH_ALGO_MICHAEL = 0x00000001;
enum uint OID_DOT11_CURRENT_OFFLOAD_CAPABILITY = 0x0d010301;

enum : uint
{
    OID_DOT11_WEP_OFFLOAD         = 0x0d010302,
    OID_DOT11_WEP_UPLOAD          = 0x0d010303,
    OID_DOT11_DEFAULT_WEP_OFFLOAD = 0x0d010304,
    OID_DOT11_DEFAULT_WEP_UPLOAD  = 0x0d010305,
}

enum uint OID_DOT11_MPDU_MAX_LENGTH = 0x0d010306;
enum uint OID_DOT11_OPERATION_MODE_CAPABILITY = 0x0d010307;

enum : uint
{
    DOT11_OPERATION_MODE_UNKNOWN            = 0x00000000,
    DOT11_OPERATION_MODE_STATION            = 0x00000001,
    DOT11_OPERATION_MODE_AP                 = 0x00000002,
    DOT11_OPERATION_MODE_EXTENSIBLE_STATION = 0x00000004,
    DOT11_OPERATION_MODE_EXTENSIBLE_AP      = 0x00000008,
    DOT11_OPERATION_MODE_WFD_DEVICE         = 0x00000010,
    DOT11_OPERATION_MODE_WFD_GROUP_OWNER    = 0x00000020,
    DOT11_OPERATION_MODE_WFD_CLIENT         = 0x00000040,
    DOT11_OPERATION_MODE_MANUFACTURING      = 0x40000000,
    DOT11_OPERATION_MODE_NETWORK_MONITOR    = 0x80000000,
}

enum : uint
{
    OID_DOT11_CURRENT_OPERATION_MODE = 0x0d010308,
    OID_DOT11_CURRENT_PACKET_FILTER  = 0x0d010309,
}

enum : uint
{
    DOT11_PACKET_TYPE_DIRECTED_CTRL      = 0x00000001,
    DOT11_PACKET_TYPE_DIRECTED_MGMT      = 0x00000002,
    DOT11_PACKET_TYPE_DIRECTED_DATA      = 0x00000004,
    DOT11_PACKET_TYPE_MULTICAST_CTRL     = 0x00000008,
    DOT11_PACKET_TYPE_MULTICAST_MGMT     = 0x00000010,
    DOT11_PACKET_TYPE_MULTICAST_DATA     = 0x00000020,
    DOT11_PACKET_TYPE_BROADCAST_CTRL     = 0x00000040,
    DOT11_PACKET_TYPE_BROADCAST_MGMT     = 0x00000080,
    DOT11_PACKET_TYPE_BROADCAST_DATA     = 0x00000100,
    DOT11_PACKET_TYPE_PROMISCUOUS_CTRL   = 0x00000200,
    DOT11_PACKET_TYPE_PROMISCUOUS_MGMT   = 0x00000400,
    DOT11_PACKET_TYPE_PROMISCUOUS_DATA   = 0x00000800,
    DOT11_PACKET_TYPE_ALL_MULTICAST_CTRL = 0x00001000,
    DOT11_PACKET_TYPE_ALL_MULTICAST_MGMT = 0x00002000,
    DOT11_PACKET_TYPE_ALL_MULTICAST_DATA = 0x00004000,
}

enum : uint
{
    OID_DOT11_ATIM_WINDOW      = 0x0d01030a,
    OID_DOT11_SCAN_REQUEST     = 0x0d01030b,
    OID_DOT11_CURRENT_PHY_TYPE = 0x0d01030c,
}

enum uint DOT11_PHY_TYPE_LIST_REVISION_1 = 0x00000001;
enum uint OID_DOT11_JOIN_REQUEST = 0x0d01030d;

enum : uint
{
    DOT11_CAPABILITY_INFO_ESS         = 0x00000001,
    DOT11_CAPABILITY_INFO_IBSS        = 0x00000002,
    DOT11_CAPABILITY_INFO_CF_POLLABLE = 0x00000004,
    DOT11_CAPABILITY_INFO_CF_POLL_REQ = 0x00000008,
    DOT11_CAPABILITY_INFO_PRIVACY     = 0x00000010,
    DOT11_CAPABILITY_SHORT_PREAMBLE   = 0x00000020,
    DOT11_CAPABILITY_PBCC             = 0x00000040,
    DOT11_CAPABILITY_CHANNEL_AGILITY  = 0x00000080,
    DOT11_CAPABILITY_SHORT_SLOT_TIME  = 0x00000400,
    DOT11_CAPABILITY_DSSSOFDM         = 0x00002000,
}

enum : uint
{
    OID_DOT11_START_REQUEST   = 0x0d01030e,
    OID_DOT11_UPDATE_IE       = 0x0d01030f,
    OID_DOT11_RESET_REQUEST   = 0x0d010310,
    OID_DOT11_NIC_POWER_STATE = 0x0d010311,
}

enum uint OID_DOT11_OPTIONAL_CAPABILITY = 0x0d010312;
enum uint OID_DOT11_CURRENT_OPTIONAL_CAPABILITY = 0x0d010313;

enum : uint
{
    OID_DOT11_STATION_ID             = 0x0d010314,
    OID_DOT11_MEDIUM_OCCUPANCY_LIMIT = 0x0d010315,
}

enum : uint
{
    OID_DOT11_CF_POLLABLE      = 0x0d010316,
    OID_DOT11_CFP_PERIOD       = 0x0d010317,
    OID_DOT11_CFP_MAX_DURATION = 0x0d010318,
}

enum uint OID_DOT11_POWER_MGMT_MODE = 0x0d010319;

enum : uint
{
    DOT11_POWER_SAVE_LEVEL_MAX_PSP  = 0x00000001,
    DOT11_POWER_SAVE_LEVEL_FAST_PSP = 0x00000002,
}

enum uint OID_DOT11_OPERATIONAL_RATE_SET = 0x0d01031a;

enum : uint
{
    OID_DOT11_BEACON_PERIOD       = 0x0d01031b,
    OID_DOT11_DTIM_PERIOD         = 0x0d01031c,
    OID_DOT11_WEP_ICV_ERROR_COUNT = 0x0d01031d,
}

enum : uint
{
    OID_DOT11_MAC_ADDRESS       = 0x0d01031e,
    OID_DOT11_RTS_THRESHOLD     = 0x0d01031f,
    OID_DOT11_SHORT_RETRY_LIMIT = 0x0d010320,
}

enum uint OID_DOT11_LONG_RETRY_LIMIT = 0x0d010321;
enum uint OID_DOT11_FRAGMENTATION_THRESHOLD = 0x0d010322;
enum uint OID_DOT11_MAX_TRANSMIT_MSDU_LIFETIME = 0x0d010323;
enum uint OID_DOT11_MAX_RECEIVE_LIFETIME = 0x0d010324;

enum : uint
{
    OID_DOT11_COUNTERS_ENTRY      = 0x0d010325,
    OID_DOT11_SUPPORTED_PHY_TYPES = 0x0d010326,
}

enum uint OID_DOT11_CURRENT_REG_DOMAIN = 0x0d010327;

enum : uint
{
    DOT11_REG_DOMAIN_OTHER  = 0x00000000,
    DOT11_REG_DOMAIN_FCC    = 0x00000010,
    DOT11_REG_DOMAIN_DOC    = 0x00000020,
    DOT11_REG_DOMAIN_ETSI   = 0x00000030,
    DOT11_REG_DOMAIN_SPAIN  = 0x00000031,
    DOT11_REG_DOMAIN_FRANCE = 0x00000032,
    DOT11_REG_DOMAIN_MKK    = 0x00000040,
}

enum : uint
{
    OID_DOT11_TEMP_TYPE          = 0x0d010328,
    OID_DOT11_CURRENT_TX_ANTENNA = 0x0d010329,
}

enum uint OID_DOT11_DIVERSITY_SUPPORT = 0x0d01032a;
enum uint OID_DOT11_CURRENT_RX_ANTENNA = 0x0d01032b;
enum uint OID_DOT11_SUPPORTED_POWER_LEVELS = 0x0d01032c;
enum uint OID_DOT11_CURRENT_TX_POWER_LEVEL = 0x0d01032d;

enum : uint
{
    OID_DOT11_HOP_TIME               = 0x0d01032e,
    OID_DOT11_CURRENT_CHANNEL_NUMBER = 0x0d01032f,
}

enum : uint
{
    OID_DOT11_MAX_DWELL_TIME     = 0x0d010330,
    OID_DOT11_CURRENT_DWELL_TIME = 0x0d010331,
    OID_DOT11_CURRENT_SET        = 0x0d010332,
    OID_DOT11_CURRENT_PATTERN    = 0x0d010333,
    OID_DOT11_CURRENT_INDEX      = 0x0d010334,
    OID_DOT11_CURRENT_CHANNEL    = 0x0d010335,
    OID_DOT11_CCA_MODE_SUPPORTED = 0x0d010336,
}

enum : uint
{
    DOT11_CCA_MODE_ED_ONLY       = 0x00000001,
    DOT11_CCA_MODE_CS_ONLY       = 0x00000002,
    DOT11_CCA_MODE_ED_and_CS     = 0x00000004,
    DOT11_CCA_MODE_CS_WITH_TIMER = 0x00000008,
    DOT11_CCA_MODE_HRCS_AND_ED   = 0x00000010,
}

enum uint OID_DOT11_CURRENT_CCA_MODE = 0x0d010337;

enum : uint
{
    OID_DOT11_ED_THRESHOLD           = 0x0d010338,
    OID_DOT11_CCA_WATCHDOG_TIMER_MAX = 0x0d010339,
    OID_DOT11_CCA_WATCHDOG_COUNT_MAX = 0x0d01033a,
    OID_DOT11_CCA_WATCHDOG_TIMER_MIN = 0x0d01033b,
    OID_DOT11_CCA_WATCHDOG_COUNT_MIN = 0x0d01033c,
}

enum uint OID_DOT11_REG_DOMAINS_SUPPORT_VALUE = 0x0d01033d;

enum : uint
{
    OID_DOT11_SUPPORTED_TX_ANTENNA = 0x0d01033e,
    OID_DOT11_SUPPORTED_RX_ANTENNA = 0x0d01033f,
}

enum uint OID_DOT11_DIVERSITY_SELECTION_RX = 0x0d010340;
enum uint OID_DOT11_SUPPORTED_DATA_RATES_VALUE = 0x0d010341;

enum : uint
{
    MAX_NUM_SUPPORTED_RATES    = 0x00000008,
    MAX_NUM_SUPPORTED_RATES_V2 = 0x000000ff,
}

enum uint OID_DOT11_CURRENT_FREQUENCY = 0x0d010342;

enum : uint
{
    OID_DOT11_TI_THRESHOLD              = 0x0d010343,
    OID_DOT11_FREQUENCY_BANDS_SUPPORTED = 0x0d010344,
}

enum : uint
{
    DOT11_FREQUENCY_BANDS_LOWER  = 0x00000001,
    DOT11_FREQUENCY_BANDS_MIDDLE = 0x00000002,
    DOT11_FREQUENCY_BANDS_UPPER  = 0x00000004,
}

enum uint OID_DOT11_SHORT_PREAMBLE_OPTION_IMPLEMENTED = 0x0d010345;
enum uint OID_DOT11_PBCC_OPTION_IMPLEMENTED = 0x0d010346;

enum : uint
{
    OID_DOT11_CHANNEL_AGILITY_PRESENT = 0x0d010347,
    OID_DOT11_CHANNEL_AGILITY_ENABLED = 0x0d010348,
}

enum uint OID_DOT11_HR_CCA_MODE_SUPPORTED = 0x0d010349;

enum : uint
{
    DOT11_HR_CCA_MODE_ED_ONLY       = 0x00000001,
    DOT11_HR_CCA_MODE_CS_ONLY       = 0x00000002,
    DOT11_HR_CCA_MODE_CS_AND_ED     = 0x00000004,
    DOT11_HR_CCA_MODE_CS_WITH_TIMER = 0x00000008,
    DOT11_HR_CCA_MODE_HRCS_AND_ED   = 0x00000010,
}

enum : uint
{
    OID_DOT11_MULTI_DOMAIN_CAPABILITY_IMPLEMENTED = 0x0d01034a,
    OID_DOT11_MULTI_DOMAIN_CAPABILITY_ENABLED     = 0x0d01034b,
}

enum : uint
{
    OID_DOT11_COUNTRY_STRING          = 0x0d01034c,
    OID_DOT11_MULTI_DOMAIN_CAPABILITY = 0x0d01034d,
}

enum : uint
{
    OID_DOT11_EHCC_PRIME_RADIX                     = 0x0d01034e,
    OID_DOT11_EHCC_NUMBER_OF_CHANNELS_FAMILY_INDEX = 0x0d01034f,
}

enum : uint
{
    OID_DOT11_EHCC_CAPABILITY_IMPLEMENTED = 0x0d010350,
    OID_DOT11_EHCC_CAPABILITY_ENABLED     = 0x0d010351,
}

enum uint OID_DOT11_HOP_ALGORITHM_ADOPTED = 0x0d010352;
enum uint OID_DOT11_RANDOM_TABLE_FLAG = 0x0d010353;
enum uint OID_DOT11_NUMBER_OF_HOPPING_SETS = 0x0d010354;

enum : uint
{
    OID_DOT11_HOP_MODULUS     = 0x0d010355,
    OID_DOT11_HOP_OFFSET      = 0x0d010356,
    OID_DOT11_HOPPING_PATTERN = 0x0d010357,
}

enum uint OID_DOT11_RANDOM_TABLE_FIELD_NUMBER = 0x0d010358;

enum : uint
{
    OID_DOT11_WPA_TSC                = 0x0d010359,
    OID_DOT11_RSSI_RANGE             = 0x0d01035a,
    OID_DOT11_RF_USAGE               = 0x0d01035b,
    OID_DOT11_NIC_SPECIFIC_EXTENSION = 0x0d01035c,
}

enum uint OID_DOT11_AP_JOIN_REQUEST = 0x0d01035d;

enum : uint
{
    OID_DOT11_ERP_PBCC_OPTION_IMPLEMENTED = 0x0d01035e,
    OID_DOT11_ERP_PBCC_OPTION_ENABLED     = 0x0d01035f,
}

enum : uint
{
    OID_DOT11_DSSS_OFDM_OPTION_IMPLEMENTED = 0x0d010360,
    OID_DOT11_DSSS_OFDM_OPTION_ENABLED     = 0x0d010361,
}

enum : uint
{
    OID_DOT11_SHORT_SLOT_TIME_OPTION_IMPLEMENTED = 0x0d010362,
    OID_DOT11_SHORT_SLOT_TIME_OPTION_ENABLED     = 0x0d010363,
}

enum uint OID_DOT11_MAX_MAC_ADDRESS_STATES = 0x0d010364;
enum uint OID_DOT11_RECV_SENSITIVITY_LIST = 0x0d010365;

enum : uint
{
    OID_DOT11_WME_IMPLEMENTED         = 0x0d010366,
    OID_DOT11_WME_ENABLED             = 0x0d010367,
    OID_DOT11_WME_AC_PARAMETERS       = 0x0d010368,
    OID_DOT11_WME_UPDATE_IE           = 0x0d010369,
    OID_DOT11_QOS_TX_QUEUES_SUPPORTED = 0x0d01036a,
    OID_DOT11_QOS_TX_DURATION         = 0x0d01036b,
    OID_DOT11_QOS_TX_MEDIUM_TIME      = 0x0d01036c,
}

enum : uint
{
    OID_DOT11_SUPPORTED_OFDM_FREQUENCY_LIST = 0x0d01036d,
    OID_DOT11_SUPPORTED_DSSS_CHANNEL_LIST   = 0x0d01036e,
}

enum uint DOT11_BSS_ENTRY_BYTE_ARRAY_REVISION_1 = 0x00000001;

enum : uint
{
    DOT11_POWER_SAVING_NO_POWER_SAVING = 0x00000000,
    DOT11_POWER_SAVING_FAST_PSP        = 0x00000008,
    DOT11_POWER_SAVING_MAX_PSP         = 0x00000010,
    DOT11_POWER_SAVING_MAXIMUM_LEVEL   = 0x00000018,
}

enum uint DOT11_SSID_LIST_REVISION_1 = 0x00000001;
enum uint DOT11_MAC_ADDRESS_LIST_REVISION_1 = 0x00000001;
enum uint DOT11_PMKID_LIST_REVISION_1 = 0x00000001;
enum uint DOT11_STATISTICS_REVISION_1 = 0x00000001;

enum : uint
{
    DOT11_EXEMPT_NO_EXEMPTION                   = 0x00000000,
    DOT11_EXEMPT_ALWAYS                         = 0x00000001,
    DOT11_EXEMPT_ON_KEY_MAPPING_KEY_UNAVAILABLE = 0x00000002,
}

enum : uint
{
    DOT11_EXEMPT_UNICAST   = 0x00000001,
    DOT11_EXEMPT_MULTICAST = 0x00000002,
    DOT11_EXEMPT_BOTH      = 0x00000003,
}

enum uint DOT11_PRIVACY_EXEMPTION_LIST_REVISION_1 = 0x00000001;
enum uint DOT11_AUTH_ALGORITHM_LIST_REVISION_1 = 0x00000001;
enum uint DOT11_AUTH_CIPHER_PAIR_LIST_REVISION_1 = 0x00000001;
enum uint DOT11_CIPHER_ALGORITHM_LIST_REVISION_1 = 0x00000001;
enum uint DOT11_CIPHER_DEFAULT_KEY_VALUE_REVISION_1 = 0x00000001;
enum uint DOT11_CIPHER_KEY_MAPPING_KEY_VALUE_BYTE_ARRAY_REVISION_1 = 0x00000001;
enum uint DOT11_ASSOCIATION_INFO_LIST_REVISION_1 = 0x00000001;
enum uint DOT11_PHY_ID_LIST_REVISION_1 = 0x00000001;
enum uint DOT11_EXTSTA_CAPABILITY_REVISION_1 = 0x00000001;
enum uint DOT11_DATA_RATE_MAPPING_TABLE_REVISION_1 = 0x00000001;
enum uint DOT11_COUNTRY_OR_REGION_STRING_LIST_REVISION_1 = 0x00000001;
enum uint DOT11_PORT_STATE_NOTIFICATION_REVISION_1 = 0x00000001;
enum uint DOT11_IBSS_PARAMS_REVISION_1 = 0x00000001;
enum uint DOT11_QOS_PARAMS_REVISION_1 = 0x00000001;
enum uint DOT11_ASSOCIATION_PARAMS_REVISION_1 = 0x00000001;
enum uint DOT11_MAX_NUM_OF_FRAGMENTS = 0x00000010;

enum : uint
{
    DOT11_PRIORITY_CONTENTION      = 0x00000000,
    DOT11_PRIORITY_CONTENTION_FREE = 0x00000001,
}

enum : uint
{
    DOT11_SERVICE_CLASS_REORDERABLE_MULTICAST = 0x00000000,
    DOT11_SERVICE_CLASS_STRICTLY_ORDERED      = 0x00000001,
}

enum : uint
{
    DOT11_FLAGS_80211B_SHORT_PREAMBLE  = 0x00000001,
    DOT11_FLAGS_80211B_PBCC            = 0x00000002,
    DOT11_FLAGS_80211B_CHANNEL_AGILITY = 0x00000004,
}

enum : uint
{
    DOT11_FLAGS_PS_ON                       = 0x00000008,
    DOT11_FLAGS_80211G_DSSS_OFDM            = 0x00000010,
    DOT11_FLAGS_80211G_USE_PROTECTION       = 0x00000020,
    DOT11_FLAGS_80211G_NON_ERP_PRESENT      = 0x00000040,
    DOT11_FLAGS_80211G_BARKER_PREAMBLE_MODE = 0x00000080,
}

enum uint DOT11_WME_PACKET = 0x00000100;
enum uint DOT11_PHY_ATTRIBUTES_REVISION_1 = 0x00000001;

enum : uint
{
    DOT11_EXTSTA_ATTRIBUTES_SAFEMODE_OID_SUPPORTED = 0x00000001,
    DOT11_EXTSTA_ATTRIBUTES_SAFEMODE_CERTIFIED     = 0x00000002,
    DOT11_EXTSTA_ATTRIBUTES_SAFEMODE_RESERVED      = 0x0000000c,
    DOT11_EXTSTA_ATTRIBUTES_REVISION_1             = 0x00000001,
    DOT11_EXTSTA_ATTRIBUTES_REVISION_2             = 0x00000002,
    DOT11_EXTSTA_ATTRIBUTES_REVISION_3             = 0x00000003,
    DOT11_EXTSTA_ATTRIBUTES_REVISION_4             = 0x00000004,
}

enum uint DOT11_SEND_CONTEXT_REVISION_1 = 0x00000001;
enum uint DOT11_RECV_CONTEXT_REVISION_1 = 0x00000001;

enum : uint
{
    DOT11_STATUS_SUCCESS              = 0x00000001,
    DOT11_STATUS_RETRY_LIMIT_EXCEEDED = 0x00000002,
}

enum : uint
{
    DOT11_STATUS_UNSUPPORTED_PRIORITY      = 0x00000004,
    DOT11_STATUS_UNSUPPORTED_SERVICE_CLASS = 0x00000008,
}

enum : uint
{
    DOT11_STATUS_UNAVAILABLE_PRIORITY      = 0x00000010,
    DOT11_STATUS_UNAVAILABLE_SERVICE_CLASS = 0x00000020,
}

enum uint DOT11_STATUS_XMIT_MSDU_TIMER_EXPIRED = 0x00000040;

enum : uint
{
    DOT11_STATUS_UNAVAILABLE_BSS        = 0x00000080,
    DOT11_STATUS_EXCESSIVE_DATA_LENGTH  = 0x00000100,
    DOT11_STATUS_ENCRYPTION_FAILED      = 0x00000200,
    DOT11_STATUS_WEP_KEY_UNAVAILABLE    = 0x00000400,
    DOT11_STATUS_ICV_VERIFIED           = 0x00000800,
    DOT11_STATUS_PACKET_REASSEMBLED     = 0x00001000,
    DOT11_STATUS_PACKET_NOT_REASSEMBLED = 0x00002000,
}

enum uint DOT11_STATUS_GENERATE_AUTH_FAILED = 0x00004000;

enum : uint
{
    DOT11_STATUS_AUTH_NOT_VERIFIED       = 0x00008000,
    DOT11_STATUS_AUTH_VERIFIED           = 0x00010000,
    DOT11_STATUS_AUTH_FAILED             = 0x00020000,
    DOT11_STATUS_PS_LIFETIME_EXPIRED     = 0x00040000,
    DOT11_STATUS_RESET_CONFIRM           = 0x00000004,
    DOT11_STATUS_SCAN_CONFIRM            = 0x00000001,
    DOT11_STATUS_JOIN_CONFIRM            = 0x00000002,
    DOT11_STATUS_START_CONFIRM           = 0x00000003,
    DOT11_STATUS_AP_JOIN_CONFIRM         = 0x00000005,
    DOT11_STATUS_MPDU_MAX_LENGTH_CHANGED = 0x00000006,
}

enum uint DOT11_MPDU_MAX_LENGTH_INDICATION_REVISION_1 = 0x00000001;
enum uint DOT11_ASSOCIATION_START_PARAMETERS_REVISION_1 = 0x00000001;

enum : uint
{
    DOT11_ENCAP_RFC_1042 = 0x00000001,
    DOT11_ENCAP_802_1H   = 0x00000002,
}

enum : uint
{
    DOT11_ASSOC_STATUS_SUCCESS                         = 0x00000000,
    DOT11_ASSOCIATION_COMPLETION_PARAMETERS_REVISION_1 = 0x00000001,
    DOT11_ASSOCIATION_COMPLETION_PARAMETERS_REVISION_2 = 0x00000002,
}

enum : uint
{
    DOT11_CONNECTION_START_PARAMETERS_REVISION_1      = 0x00000001,
    DOT11_CONNECTION_STATUS_SUCCESS                   = 0x00000000,
    DOT11_CONNECTION_COMPLETION_PARAMETERS_REVISION_1 = 0x00000001,
}

enum uint DOT11_ROAMING_START_PARAMETERS_REVISION_1 = 0x00000001;
enum uint DOT11_ROAMING_COMPLETION_PARAMETERS_REVISION_1 = 0x00000001;
enum uint DOT11_DISASSOCIATION_PARAMETERS_REVISION_1 = 0x00000001;
enum uint DOT11_TKIPMIC_FAILURE_PARAMETERS_REVISION_1 = 0x00000001;
enum uint DOT11_PMKID_CANDIDATE_LIST_PARAMETERS_REVISION_1 = 0x00000001;
enum uint DOT11_PHY_STATE_PARAMETERS_REVISION_1 = 0x00000001;
enum uint DOT11_LINK_QUALITY_PARAMETERS_REVISION_1 = 0x00000001;
enum uint DOT11_EXTSTA_SEND_CONTEXT_REVISION_1 = 0x00000001;
enum uint DOT11_EXTSTA_RECV_CONTEXT_REVISION_1 = 0x00000001;
enum uint OID_DOT11_PRIVATE_OIDS_START = 0x0d010700;
enum uint OID_DOT11_CURRENT_ADDRESS = 0x0d010702;
enum uint OID_DOT11_PERMANENT_ADDRESS = 0x0d010703;

enum : uint
{
    OID_DOT11_MULTICAST_LIST    = 0x0d010704,
    OID_DOT11_MAXIMUM_LIST_SIZE = 0x0d010705,
}

enum uint DOT11_EXTAP_ATTRIBUTES_REVISION_1 = 0x00000001;

enum : uint
{
    DOT11_INCOMING_ASSOC_STARTED_PARAMETERS_REVISION_1          = 0x00000001,
    DOT11_INCOMING_ASSOC_REQUEST_RECEIVED_PARAMETERS_REVISION_1 = 0x00000001,
}

enum : uint
{
    DOT11_ASSOC_ERROR_SOURCE_OS     = 0x00000000,
    DOT11_ASSOC_ERROR_SOURCE_REMOTE = 0x00000001,
    DOT11_ASSOC_ERROR_SOURCE_OTHER  = 0x000000ff,
}

enum uint DOT11_INCOMING_ASSOC_COMPLETION_PARAMETERS_REVISION_1 = 0x00000001;
enum uint DOT11_STOP_AP_PARAMETERS_REVISION_1 = 0x00000001;

enum : uint
{
    DOT11_STOP_AP_REASON_FREQUENCY_NOT_AVAILABLE = 0x00000001,
    DOT11_STOP_AP_REASON_CHANNEL_NOT_AVAILABLE   = 0x00000002,
    DOT11_STOP_AP_REASON_AP_ACTIVE               = 0x00000003,
    DOT11_STOP_AP_REASON_IHV_START               = 0xff000000,
    DOT11_STOP_AP_REASON_IHV_END                 = 0xffffffff,
}

enum uint DOT11_PHY_FREQUENCY_ADOPTED_PARAMETERS_REVISION_1 = 0x00000001;

enum : uint
{
    DOT11_CAN_SUSTAIN_AP_PARAMETERS_REVISION_1 = 0x00000001,
    DOT11_CAN_SUSTAIN_AP_REASON_IHV_START      = 0xff000000,
    DOT11_CAN_SUSTAIN_AP_REASON_IHV_END        = 0xffffffff,
}

enum : uint
{
    DOT11_AVAILABLE_CHANNEL_LIST_REVISION_1   = 0x00000001,
    DOT11_AVAILABLE_FREQUENCY_LIST_REVISION_1 = 0x00000001,
}

enum uint DOT11_DISASSOCIATE_PEER_REQUEST_REVISION_1 = 0x00000001;

enum : uint
{
    DOT11_INCOMING_ASSOC_DECISION_REVISION_1 = 0x00000001,
    DOT11_INCOMING_ASSOC_DECISION_REVISION_2 = 0x00000002,
}

enum uint DOT11_ADDITIONAL_IE_REVISION_1 = 0x00000001;
enum uint DOT11_EXTAP_SEND_CONTEXT_REVISION_1 = 0x00000001;
enum uint DOT11_EXTAP_RECV_CONTEXT_REVISION_1 = 0x00000001;
enum uint DOT11_PEER_INFO_LIST_REVISION_1 = 0x00000001;

enum : uint
{
    DOT11_VWIFI_COMBINATION_REVISION_1 = 0x00000001,
    DOT11_VWIFI_COMBINATION_REVISION_2 = 0x00000002,
    DOT11_VWIFI_COMBINATION_REVISION_3 = 0x00000003,
}

enum uint DOT11_VWIFI_ATTRIBUTES_REVISION_1 = 0x00000001;
enum uint DOT11_MAC_PARAMETERS_REVISION_1 = 0x00000001;
enum uint DOT11_WFD_ATTRIBUTES_REVISION_1 = 0x00000001;

enum : uint
{
    DOT11_WFD_STATUS_SUCCESS                                 = 0x00000000,
    DOT11_WFD_STATUS_FAILED_INFORMATION_IS_UNAVAILABLE       = 0x00000001,
    DOT11_WFD_STATUS_FAILED_INCOMPATIBLE_PARAMETERS          = 0x00000002,
    DOT11_WFD_STATUS_FAILED_LIMIT_REACHED                    = 0x00000003,
    DOT11_WFD_STATUS_FAILED_INVALID_PARAMETERS               = 0x00000004,
    DOT11_WFD_STATUS_FAILED_UNABLE_TO_ACCOMODATE_REQUEST     = 0x00000005,
    DOT11_WFD_STATUS_FAILED_PREVIOUS_PROTOCOL_ERROR          = 0x00000006,
    DOT11_WFD_STATUS_FAILED_NO_COMMON_CHANNELS               = 0x00000007,
    DOT11_WFD_STATUS_FAILED_UNKNOWN_WFD_GROUP                = 0x00000008,
    DOT11_WFD_STATUS_FAILED_MATCHING_MAX_INTENT              = 0x00000009,
    DOT11_WFD_STATUS_FAILED_INCOMPATIBLE_PROVISIONING_METHOD = 0x0000000a,
    DOT11_WFD_STATUS_FAILED_REJECTED_BY_USER                 = 0x0000000b,
    DOT11_WFD_STATUS_SUCCESS_ACCEPTED_BY_USER                = 0x0000000c,
}

enum : uint
{
    DOT11_WFD_MINOR_REASON_SUCCESS                                          = 0x00000000,
    DOT11_WFD_MINOR_REASON_DISASSOCIATED_FROM_WLAN_CROSS_CONNECTION_POLICY  = 0x00000001,
    DOT11_WFD_MINOR_REASON_DISASSOCIATED_NOT_MANAGED_INFRASTRUCTURE_CAPABLE = 0x00000002,
    DOT11_WFD_MINOR_REASON_DISASSOCIATED_WFD_COEXISTENCE_POLICY             = 0x00000003,
    DOT11_WFD_MINOR_REASON_DISASSOCIATED_INFRASTRUCTURE_MANAGED_POLICY      = 0x00000004,
}

enum : uint
{
    DOT11_WPS_VERSION_1_0 = 0x00000001,
    DOT11_WPS_VERSION_2_0 = 0x00000002,
}

enum : uint
{
    DOT11_WFD_DEVICE_CAPABILITY_SERVICE_DISCOVERY          = 0x00000001,
    DOT11_WFD_DEVICE_CAPABILITY_P2P_CLIENT_DISCOVERABILITY = 0x00000002,
    DOT11_WFD_DEVICE_CAPABILITY_CONCURRENT_OPERATION       = 0x00000004,
    DOT11_WFD_DEVICE_CAPABILITY_P2P_INFRASTRUCTURE_MANAGED = 0x00000008,
    DOT11_WFD_DEVICE_CAPABILITY_P2P_DEVICE_LIMIT           = 0x00000010,
    DOT11_WFD_DEVICE_CAPABILITY_P2P_INVITATION_PROCEDURE   = 0x00000020,
    DOT11_WFD_DEVICE_CAPABILITY_RESERVED_6                 = 0x00000040,
    DOT11_WFD_DEVICE_CAPABILITY_RESERVED_7                 = 0x00000080,
}

enum : uint
{
    DOT11_WFD_GROUP_CAPABILITY_NONE                                      = 0x00000000,
    DOT11_WFD_GROUP_CAPABILITY_GROUP_OWNER                               = 0x00000001,
    DOT11_WFD_GROUP_CAPABILITY_PERSISTENT_GROUP                          = 0x00000002,
    DOT11_WFD_GROUP_CAPABILITY_GROUP_LIMIT_REACHED                       = 0x00000004,
    DOT11_WFD_GROUP_CAPABILITY_INTRABSS_DISTRIBUTION_SUPPORTED           = 0x00000008,
    DOT11_WFD_GROUP_CAPABILITY_CROSS_CONNECTION_SUPPORTED                = 0x00000010,
    DOT11_WFD_GROUP_CAPABILITY_PERSISTENT_RECONNECT_SUPPORTED            = 0x00000020,
    DOT11_WFD_GROUP_CAPABILITY_IN_GROUP_FORMATION                        = 0x00000040,
    DOT11_WFD_GROUP_CAPABILITY_RESERVED_7                                = 0x00000080,
    DOT11_WFD_GROUP_CAPABILITY_EAPOL_KEY_IP_ADDRESS_ALLOCATION_SUPPORTED = 0x00000080,
}

enum uint DOT11_WPS_DEVICE_NAME_MAX_LENGTH = 0x00000020;

enum : uint
{
    DOT11_WPS_MAX_PASSKEY_LENGTH      = 0x00000008,
    DOT11_WPS_MAX_MODEL_NAME_LENGTH   = 0x00000020,
    DOT11_WPS_MAX_MODEL_NUMBER_LENGTH = 0x00000020,
}

enum : uint
{
    WFDSVC_CONNECTION_CAPABILITY_NEW    = 0x00000001,
    WFDSVC_CONNECTION_CAPABILITY_CLIENT = 0x00000002,
    WFDSVC_CONNECTION_CAPABILITY_GO     = 0x00000004,
}

enum : uint
{
    DOT11_WFD_DISCOVER_COMPLETE_PARAMETERS_REVISION_1 = 0x00000001,
    DOT11_WFD_DISCOVER_COMPLETE_MAX_LIST_SIZE         = 0x00000080,
}

enum uint DOT11_GO_NEGOTIATION_REQUEST_SEND_COMPLETE_PARAMETERS_REVISION_1 = 0x00000001;
enum uint DOT11_RECEIVED_GO_NEGOTIATION_REQUEST_PARAMETERS_REVISION_1 = 0x00000001;
enum uint DOT11_GO_NEGOTIATION_RESPONSE_SEND_COMPLETE_PARAMETERS_REVISION_1 = 0x00000001;
enum uint DOT11_RECEIVED_GO_NEGOTIATION_RESPONSE_PARAMETERS_REVISION_1 = 0x00000001;
enum uint DOT11_GO_NEGOTIATION_CONFIRMATION_SEND_COMPLETE_PARAMETERS_REVISION_1 = 0x00000001;
enum uint DOT11_RECEIVED_GO_NEGOTIATION_CONFIRMATION_PARAMETERS_REVISION_1 = 0x00000001;
enum uint DOT11_INVITATION_REQUEST_SEND_COMPLETE_PARAMETERS_REVISION_1 = 0x00000001;
enum uint DOT11_RECEIVED_INVITATION_REQUEST_PARAMETERS_REVISION_1 = 0x00000001;
enum uint DOT11_INVITATION_RESPONSE_SEND_COMPLETE_PARAMETERS_REVISION_1 = 0x00000001;
enum uint DOT11_RECEIVED_INVITATION_RESPONSE_PARAMETERS_REVISION_1 = 0x00000001;
enum uint DOT11_PROVISION_DISCOVERY_REQUEST_SEND_COMPLETE_PARAMETERS_REVISION_1 = 0x00000001;
enum uint DOT11_RECEIVED_PROVISION_DISCOVERY_REQUEST_PARAMETERS_REVISION_1 = 0x00000001;
enum uint DOT11_PROVISION_DISCOVERY_RESPONSE_SEND_COMPLETE_PARAMETERS_REVISION_1 = 0x00000001;
enum uint DOT11_RECEIVED_PROVISION_DISCOVERY_RESPONSE_PARAMETERS_REVISION_1 = 0x00000001;
enum uint DOT11_ANQP_QUERY_COMPLETE_PARAMETERS_REVISION_1 = 0x00000001;
enum uint DOT11_WFD_DEVICE_CAPABILITY_CONFIG_REVISION_1 = 0x00000001;

enum : uint
{
    DOT11_WFD_GROUP_OWNER_CAPABILITY_CONFIG_REVISION_1 = 0x00000001,
    DOT11_WFD_GROUP_OWNER_CAPABILITY_CONFIG_REVISION_2 = 0x00000002,
}

enum uint DOT11_WFD_DEVICE_INFO_REVISION_1 = 0x00000001;
enum uint DOT11_WFD_SECONDARY_DEVICE_TYPE_LIST_REVISION_1 = 0x00000001;

enum : uint
{
    DISCOVERY_FILTER_BITMASK_DEVICE = 0x00000001,
    DISCOVERY_FILTER_BITMASK_GO     = 0x00000002,
    DISCOVERY_FILTER_BITMASK_ANY    = 0x0000000f,
}

enum uint DOT11_WFD_DISCOVER_REQUEST_REVISION_1 = 0x00000001;
enum uint DOT11_DEVICE_ENTRY_BYTE_ARRAY_REVISION_1 = 0x00000001;

enum : uint
{
    DOT11_WFD_DEVICE_NOT_DISCOVERABLE  = 0x00000000,
    DOT11_WFD_DEVICE_AUTO_AVAILABILITY = 0x00000010,
    DOT11_WFD_DEVICE_HIGH_AVAILABILITY = 0x00000018,
}

enum uint DOT11_WFD_ADDITIONAL_IE_REVISION_1 = 0x00000001;

enum : uint
{
    DOT11_SEND_GO_NEGOTIATION_REQUEST_PARAMETERS_REVISION_1      = 0x00000001,
    DOT11_SEND_GO_NEGOTIATION_RESPONSE_PARAMETERS_REVISION_1     = 0x00000001,
    DOT11_SEND_GO_NEGOTIATION_CONFIRMATION_PARAMETERS_REVISION_1 = 0x00000001,
}

enum : uint
{
    DOT11_SEND_INVITATION_REQUEST_PARAMETERS_REVISION_1  = 0x00000001,
    DOT11_SEND_INVITATION_RESPONSE_PARAMETERS_REVISION_1 = 0x00000001,
}

enum : uint
{
    DOT11_SEND_PROVISION_DISCOVERY_REQUEST_PARAMETERS_REVISION_1  = 0x00000001,
    DOT11_SEND_PROVISION_DISCOVERY_RESPONSE_PARAMETERS_REVISION_1 = 0x00000001,
}

enum uint DOT11_WFD_DEVICE_LISTEN_CHANNEL_REVISION_1 = 0x00000001;
enum uint DOT11_WFD_GROUP_START_PARAMETERS_REVISION_1 = 0x00000001;
enum uint DOT11_WFD_GROUP_JOIN_PARAMETERS_REVISION_1 = 0x00000001;
enum uint DOT11_POWER_MGMT_AUTO_MODE_ENABLED_REVISION_1 = 0x00000001;
enum uint DOT11_POWER_MGMT_MODE_STATUS_INFO_REVISION_1 = 0x00000001;
enum uint DOT11_MAX_CHANNEL_HINTS = 0x00000004;
enum uint DOT11_INVALID_CHANNEL_NUMBER = 0x00000000;

enum : uint
{
    DOT11_NLO_FLAG_STOP_NLO_INDICATION   = 0x00000001,
    DOT11_NLO_FLAG_SCAN_ON_AOAC_PLATFORM = 0x00000002,
    DOT11_NLO_FLAG_SCAN_AT_SYSTEM_RESUME = 0x00000004,
}

enum : uint
{
    DOT11_OFFLOAD_NETWORK_LIST_REVISION_1              = 0x00000001,
    DOT11_OFFLOAD_NETWORK_STATUS_PARAMETERS_REVISION_1 = 0x00000001,
}

enum : uint
{
    DOT11_MANUFACTURING_TEST_REVISION_1     = 0x00000001,
    DOT11_MANUFACTURING_CALLBACK_REVISION_1 = 0x00000001,
}

enum uint DOT11_SSID_MAX_LENGTH = 0x00000020;

enum : uint
{
    DOT11_OI_MAX_LENGTH = 0x00000005,
    DOT11_OI_MIN_LENGTH = 0x00000003,
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3625450536, 31038, 19358, 153, 112, 70, 157, 139, 230, 48, 115}, 1))], [])*/DEVPROPKEY
{
    DEVPKEY_PciRootBus_SecondaryInterface               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3625450536, 31038, 19358, 153, 112, 70, 157, 139, 230, 48, 115}, 1))], [])*/DEVPROPKEY(GUID("D817FC28-793E-4B9E-9970-469D8BE63073"), 1),
    DEVPKEY_PciRootBus_CurrentSpeedAndMode              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3625450536, 31038, 19358, 153, 112, 70, 157, 139, 230, 48, 115}, 1))], [])*/DEVPROPKEY(GUID("D817FC28-793E-4B9E-9970-469D8BE63073"), 2),
    DEVPKEY_PciRootBus_SupportedSpeedsAndModes          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3625450536, 31038, 19358, 153, 112, 70, 157, 139, 230, 48, 115}, 1))], [])*/DEVPROPKEY(GUID("D817FC28-793E-4B9E-9970-469D8BE63073"), 3),
    DEVPKEY_PciRootBus_DeviceIDMessagingCapable         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3625450536, 31038, 19358, 153, 112, 70, 157, 139, 230, 48, 115}, 1))], [])*/DEVPROPKEY(GUID("D817FC28-793E-4B9E-9970-469D8BE63073"), 4),
    DEVPKEY_PciRootBus_SecondaryBusWidth                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3625450536, 31038, 19358, 153, 112, 70, 157, 139, 230, 48, 115}, 1))], [])*/DEVPROPKEY(GUID("D817FC28-793E-4B9E-9970-469D8BE63073"), 5),
    DEVPKEY_PciRootBus_ExtendedConfigAvailable          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3625450536, 31038, 19358, 153, 112, 70, 157, 139, 230, 48, 115}, 1))], [])*/DEVPROPKEY(GUID("D817FC28-793E-4B9E-9970-469D8BE63073"), 6),
    DEVPKEY_PciRootBus_ExtendedPCIConfigOpRegionSupport = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3625450536, 31038, 19358, 153, 112, 70, 157, 139, 230, 48, 115}, 1))], [])*/DEVPROPKEY(GUID("D817FC28-793E-4B9E-9970-469D8BE63073"), 7),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3625450536, 31038, 19358, 153, 112, 70, 157, 139, 230, 48, 115}, 8))], [])*/DEVPROPKEY
{
    DEVPKEY_PciRootBus_ASPMSupport                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3625450536, 31038, 19358, 153, 112, 70, 157, 139, 230, 48, 115}, 8))], [])*/DEVPROPKEY(GUID("D817FC28-793E-4B9E-9970-469D8BE63073"), 8),
    DEVPKEY_PciRootBus_ClockPowerManagementSupport    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3625450536, 31038, 19358, 153, 112, 70, 157, 139, 230, 48, 115}, 8))], [])*/DEVPROPKEY(GUID("D817FC28-793E-4B9E-9970-469D8BE63073"), 9),
    DEVPKEY_PciRootBus_PCISegmentGroupsSupport        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3625450536, 31038, 19358, 153, 112, 70, 157, 139, 230, 48, 115}, 8))], [])*/DEVPROPKEY(GUID("D817FC28-793E-4B9E-9970-469D8BE63073"), 10),
    DEVPKEY_PciRootBus_MSISupport                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3625450536, 31038, 19358, 153, 112, 70, 157, 139, 230, 48, 115}, 8))], [])*/DEVPROPKEY(GUID("D817FC28-793E-4B9E-9970-469D8BE63073"), 11),
    DEVPKEY_PciRootBus_PCIExpressNativeHotPlugControl = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3625450536, 31038, 19358, 153, 112, 70, 157, 139, 230, 48, 115}, 8))], [])*/DEVPROPKEY(GUID("D817FC28-793E-4B9E-9970-469D8BE63073"), 12),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3625450536, 31038, 19358, 153, 112, 70, 157, 139, 230, 48, 115}, 13))], [])*/DEVPROPKEY
{
    DEVPKEY_PciRootBus_SHPCNativeHotPlugControl    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3625450536, 31038, 19358, 153, 112, 70, 157, 139, 230, 48, 115}, 13))], [])*/DEVPROPKEY(GUID("D817FC28-793E-4B9E-9970-469D8BE63073"), 13),
    DEVPKEY_PciRootBus_PCIExpressNativePMEControl  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3625450536, 31038, 19358, 153, 112, 70, 157, 139, 230, 48, 115}, 13))], [])*/DEVPROPKEY(GUID("D817FC28-793E-4B9E-9970-469D8BE63073"), 14),
    DEVPKEY_PciRootBus_PCIExpressAERControl        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3625450536, 31038, 19358, 153, 112, 70, 157, 139, 230, 48, 115}, 13))], [])*/DEVPROPKEY(GUID("D817FC28-793E-4B9E-9970-469D8BE63073"), 15),
    DEVPKEY_PciRootBus_PCIExpressCapabilityControl = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3625450536, 31038, 19358, 153, 112, 70, 157, 139, 230, 48, 115}, 13))], [])*/DEVPROPKEY(GUID("D817FC28-793E-4B9E-9970-469D8BE63073"), 16),
    DEVPKEY_PciRootBus_NativePciExpressControl     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3625450536, 31038, 19358, 153, 112, 70, 157, 139, 230, 48, 115}, 13))], [])*/DEVPROPKEY(GUID("D817FC28-793E-4B9E-9970-469D8BE63073"), 17),
    DEVPKEY_PciRootBus_SystemMsiSupport            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({3625450536, 31038, 19358, 153, 112, 70, 157, 139, 230, 48, 115}, 13))], [])*/DEVPROPKEY(GUID("D817FC28-793E-4B9E-9970-469D8BE63073"), 18),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 1))], [])*/DEVPROPKEY
{
    DEVPKEY_PciDevice_DeviceType                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 1))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 1),
    DEVPKEY_PciDevice_CurrentSpeedAndMode          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 1))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 2),
    DEVPKEY_PciDevice_BaseClass                    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 1))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 3),
    DEVPKEY_PciDevice_SubClass                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 1))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 4),
    DEVPKEY_PciDevice_ProgIf                       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 1))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 5),
    DEVPKEY_PciDevice_CurrentPayloadSize           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 1))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 6),
    DEVPKEY_PciDevice_MaxPayloadSize               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 1))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 7),
    DEVPKEY_PciDevice_MaxReadRequestSize           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 1))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 8),
    DEVPKEY_PciDevice_CurrentLinkSpeed             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 1))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 9),
    DEVPKEY_PciDevice_CurrentLinkWidth             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 1))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 10),
    DEVPKEY_PciDevice_MaxLinkSpeed                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 1))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 11),
    DEVPKEY_PciDevice_MaxLinkWidth                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 1))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 12),
    DEVPKEY_PciDevice_ExpressSpecVersion           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 1))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 13),
    DEVPKEY_PciDevice_InterruptSupport             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 1))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 14),
    DEVPKEY_PciDevice_InterruptMessageMaximum      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 1))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 15),
    DEVPKEY_PciDevice_BarTypes                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 1))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 16),
    DEVPKEY_PciDevice_AERCapabilityPresent         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 1))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 17),
    DEVPKEY_PciDevice_FirmwareErrorHandling        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 1))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 18),
    DEVPKEY_PciDevice_Uncorrectable_Error_Mask     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 1))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 19),
    DEVPKEY_PciDevice_Uncorrectable_Error_Severity = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 1))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 20),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 21))], [])*/DEVPROPKEY
{
    DEVPKEY_PciDevice_Correctable_Error_Mask       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 21))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 21),
    DEVPKEY_PciDevice_ECRC_Errors                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 21))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 22),
    DEVPKEY_PciDevice_Error_Reporting              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 21))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 23),
    DEVPKEY_PciDevice_RootError_Reporting          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 21))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 24),
    DEVPKEY_PciDevice_S0WakeupSupported            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 21))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 25),
    DEVPKEY_PciDevice_SriovSupport                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 21))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 26),
    DEVPKEY_PciDevice_Label_Id                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 21))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 27),
    DEVPKEY_PciDevice_Label_String                 = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 21))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 28),
    DEVPKEY_PciDevice_AcsSupport                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 21))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 29),
    DEVPKEY_PciDevice_AriSupport                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 21))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 30),
    DEVPKEY_PciDevice_AcsCompatibleUpHierarchy     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 21))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 31),
    DEVPKEY_PciDevice_AcsCapabilityRegister        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 21))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 32),
    DEVPKEY_PciDevice_AtsSupport                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 21))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 33),
    DEVPKEY_PciDevice_RequiresReservedMemoryRegion = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 21))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 34),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 35))], [])*/DEVPROPKEY
{
    DEVPKEY_PciDevice_AtomicsSupported               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 35))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 35),
    DEVPKEY_PciDevice_SupportedLinkSubState          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 35))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 36),
    DEVPKEY_PciDevice_OnPostPath                     = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 35))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 37),
    DEVPKEY_PciDevice_D3ColdSupport                  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 35))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 38),
    DEVPKEY_PciDevice_VirtualChannelControlRegisters = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 35))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 39),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 40))], [])*/DEVPROPKEY
{
    DEVPKEY_PciDevice_SerialNumber                   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 40))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 40),
    DEVPKEY_PciDevice_UsbDvsecPortType               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 40))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 41),
    DEVPKEY_PciDevice_UsbDvsecPortSpecificAttributes = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 40))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 42),
    DEVPKEY_PciDevice_UsbComponentRelation           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 40))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 43),
    DEVPKEY_PciDevice_UsbHostRouterName              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 40))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 44),
    DEVPKEY_PciDevice_ParentSerialNumber             = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 40))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 45),
    DEVPKEY_PciDevice_SupportsDmwrOnEntireDeviceTree = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 40))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 46),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 47))], [])*/DEVPROPKEY DEVPKEY_PciDevice_IsTunneledDevice = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({984755761, 33380, 19278, 154, 245, 168, 210, 216, 227, 62, 98}, 47))], [])*/DEVPROPKEY(GUID("3AB22E31-8264-4B4E-9AF5-A8D2D8E33E62"), 47);

enum : uint
{
    WLAN_API_VERSION_1_0 = 0x00000001,
    WLAN_API_VERSION_2_0 = 0x00000002,
    WLAN_API_VERSION     = 0x00000002,
}

enum uint WLAN_MAX_NAME_LENGTH = 0x00000100;

enum : uint
{
    WLAN_PROFILE_GROUP_POLICY                  = 0x00000001,
    WLAN_PROFILE_USER                          = 0x00000002,
    WLAN_PROFILE_GET_PLAINTEXT_KEY             = 0x00000004,
    WLAN_PROFILE_CONNECTION_MODE_SET_BY_CLIENT = 0x00010000,
    WLAN_PROFILE_CONNECTION_MODE_AUTO          = 0x00020000,
}

enum : uint
{
    DOT11_PSD_IE_MAX_DATA_SIZE    = 0x000000f0,
    DOT11_PSD_IE_MAX_ENTRY_NUMBER = 0x00000005,
}

enum : uint
{
    WLAN_REASON_CODE_NETWORK_NOT_COMPATIBLE     = 0x00020001,
    WLAN_REASON_CODE_PROFILE_NOT_COMPATIBLE     = 0x00020002,
    WLAN_REASON_CODE_NO_AUTO_CONNECTION         = 0x00028001,
    WLAN_REASON_CODE_NOT_VISIBLE                = 0x00028002,
    WLAN_REASON_CODE_GP_DENIED                  = 0x00028003,
    WLAN_REASON_CODE_USER_DENIED                = 0x00028004,
    WLAN_REASON_CODE_BSS_TYPE_NOT_ALLOWED       = 0x00028005,
    WLAN_REASON_CODE_IN_FAILED_LIST             = 0x00028006,
    WLAN_REASON_CODE_IN_BLOCKED_LIST            = 0x00028007,
    WLAN_REASON_CODE_SSID_LIST_TOO_LONG         = 0x00028008,
    WLAN_REASON_CODE_CONNECT_CALL_FAIL          = 0x00028009,
    WLAN_REASON_CODE_SCAN_CALL_FAIL             = 0x0002800a,
    WLAN_REASON_CODE_NETWORK_NOT_AVAILABLE      = 0x0002800b,
    WLAN_REASON_CODE_PROFILE_CHANGED_OR_DELETED = 0x0002800c,
}

enum : uint
{
    WLAN_REASON_CODE_KEY_MISMATCH                      = 0x0002800d,
    WLAN_REASON_CODE_USER_NOT_RESPOND                  = 0x0002800e,
    WLAN_REASON_CODE_AP_PROFILE_NOT_ALLOWED_FOR_CLIENT = 0x0002800f,
    WLAN_REASON_CODE_AP_PROFILE_NOT_ALLOWED            = 0x00028010,
    WLAN_REASON_CODE_HOTSPOT2_PROFILE_DENIED           = 0x00028011,
    WLAN_REASON_CODE_INVALID_PROFILE_SCHEMA            = 0x00080001,
    WLAN_REASON_CODE_PROFILE_MISSING                   = 0x00080002,
    WLAN_REASON_CODE_INVALID_PROFILE_NAME              = 0x00080003,
    WLAN_REASON_CODE_INVALID_PROFILE_TYPE              = 0x00080004,
    WLAN_REASON_CODE_INVALID_PHY_TYPE                  = 0x00080005,
    WLAN_REASON_CODE_MSM_SECURITY_MISSING              = 0x00080006,
    WLAN_REASON_CODE_IHV_SECURITY_NOT_SUPPORTED        = 0x00080007,
    WLAN_REASON_CODE_IHV_OUI_MISMATCH                  = 0x00080008,
    WLAN_REASON_CODE_IHV_OUI_MISSING                   = 0x00080009,
    WLAN_REASON_CODE_IHV_SETTINGS_MISSING              = 0x0008000a,
    WLAN_REASON_CODE_CONFLICT_SECURITY                 = 0x0008000b,
    WLAN_REASON_CODE_SECURITY_MISSING                  = 0x0008000c,
    WLAN_REASON_CODE_INVALID_BSS_TYPE                  = 0x0008000d,
    WLAN_REASON_CODE_INVALID_ADHOC_CONNECTION_MODE     = 0x0008000e,
}

enum uint WLAN_REASON_CODE_NON_BROADCAST_SET_FOR_ADHOC = 0x0008000f;

enum : uint
{
    WLAN_REASON_CODE_AUTO_SWITCH_SET_FOR_ADHOC             = 0x00080010,
    WLAN_REASON_CODE_AUTO_SWITCH_SET_FOR_MANUAL_CONNECTION = 0x00080011,
}

enum : uint
{
    WLAN_REASON_CODE_IHV_SECURITY_ONEX_MISSING      = 0x00080012,
    WLAN_REASON_CODE_PROFILE_SSID_INVALID           = 0x00080013,
    WLAN_REASON_CODE_TOO_MANY_SSID                  = 0x00080014,
    WLAN_REASON_CODE_IHV_CONNECTIVITY_NOT_SUPPORTED = 0x00080015,
}

enum uint WLAN_REASON_CODE_BAD_MAX_NUMBER_OF_CLIENTS_FOR_AP = 0x00080016;

enum : uint
{
    WLAN_REASON_CODE_INVALID_CHANNEL              = 0x00080017,
    WLAN_REASON_CODE_OPERATION_MODE_NOT_SUPPORTED = 0x00080018,
}

enum : uint
{
    WLAN_REASON_CODE_AUTO_AP_PROFILE_NOT_ALLOWED = 0x00080019,
    WLAN_REASON_CODE_AUTO_CONNECTION_NOT_ALLOWED = 0x0008001a,
}

enum uint WLAN_REASON_CODE_HOTSPOT2_PROFILE_NOT_ALLOWED = 0x0008001b;

enum : uint
{
    WLAN_REASON_CODE_UNSUPPORTED_SECURITY_SET_BY_OS = 0x00030001,
    WLAN_REASON_CODE_UNSUPPORTED_SECURITY_SET       = 0x00030002,
    WLAN_REASON_CODE_BSS_TYPE_UNMATCH               = 0x00030003,
    WLAN_REASON_CODE_PHY_TYPE_UNMATCH               = 0x00030004,
    WLAN_REASON_CODE_DATARATE_UNMATCH               = 0x00030005,
    WLAN_REASON_CODE_USER_CANCELLED                 = 0x00038001,
    WLAN_REASON_CODE_ASSOCIATION_FAILURE            = 0x00038002,
    WLAN_REASON_CODE_ASSOCIATION_TIMEOUT            = 0x00038003,
    WLAN_REASON_CODE_PRE_SECURITY_FAILURE           = 0x00038004,
    WLAN_REASON_CODE_START_SECURITY_FAILURE         = 0x00038005,
    WLAN_REASON_CODE_SECURITY_FAILURE               = 0x00038006,
    WLAN_REASON_CODE_SECURITY_TIMEOUT               = 0x00038007,
    WLAN_REASON_CODE_ROAMING_FAILURE                = 0x00038008,
    WLAN_REASON_CODE_ROAMING_SECURITY_FAILURE       = 0x00038009,
    WLAN_REASON_CODE_ADHOC_SECURITY_FAILURE         = 0x0003800a,
    WLAN_REASON_CODE_DRIVER_DISCONNECTED            = 0x0003800b,
    WLAN_REASON_CODE_DRIVER_OPERATION_FAILURE       = 0x0003800c,
    WLAN_REASON_CODE_IHV_NOT_AVAILABLE              = 0x0003800d,
    WLAN_REASON_CODE_IHV_NOT_RESPONDING             = 0x0003800e,
    WLAN_REASON_CODE_DISCONNECT_TIMEOUT             = 0x0003800f,
    WLAN_REASON_CODE_INTERNAL_FAILURE               = 0x00038010,
    WLAN_REASON_CODE_UI_REQUEST_TIMEOUT             = 0x00038011,
    WLAN_REASON_CODE_TOO_MANY_SECURITY_ATTEMPTS     = 0x00038012,
}

enum : uint
{
    WLAN_REASON_CODE_AP_STARTING_FAILURE                           = 0x00038013,
    WLAN_REASON_CODE_NO_VISIBLE_AP                                 = 0x00038014,
    WLAN_REASON_CODE_MSMSEC_MIN                                    = 0x00040000,
    WLAN_REASON_CODE_MSMSEC_PROFILE_INVALID_KEY_INDEX              = 0x00040001,
    WLAN_REASON_CODE_MSMSEC_PROFILE_PSK_PRESENT                    = 0x00040002,
    WLAN_REASON_CODE_MSMSEC_PROFILE_KEY_LENGTH                     = 0x00040003,
    WLAN_REASON_CODE_MSMSEC_PROFILE_PSK_LENGTH                     = 0x00040004,
    WLAN_REASON_CODE_MSMSEC_PROFILE_NO_AUTH_CIPHER_SPECIFIED       = 0x00040005,
    WLAN_REASON_CODE_MSMSEC_PROFILE_TOO_MANY_AUTH_CIPHER_SPECIFIED = 0x00040006,
    WLAN_REASON_CODE_MSMSEC_PROFILE_DUPLICATE_AUTH_CIPHER          = 0x00040007,
    WLAN_REASON_CODE_MSMSEC_PROFILE_RAWDATA_INVALID                = 0x00040008,
    WLAN_REASON_CODE_MSMSEC_PROFILE_INVALID_AUTH_CIPHER            = 0x00040009,
    WLAN_REASON_CODE_MSMSEC_PROFILE_ONEX_DISABLED                  = 0x0004000a,
    WLAN_REASON_CODE_MSMSEC_PROFILE_ONEX_ENABLED                   = 0x0004000b,
    WLAN_REASON_CODE_MSMSEC_PROFILE_INVALID_PMKCACHE_MODE          = 0x0004000c,
    WLAN_REASON_CODE_MSMSEC_PROFILE_INVALID_PMKCACHE_SIZE          = 0x0004000d,
    WLAN_REASON_CODE_MSMSEC_PROFILE_INVALID_PMKCACHE_TTL           = 0x0004000e,
    WLAN_REASON_CODE_MSMSEC_PROFILE_INVALID_PREAUTH_MODE           = 0x0004000f,
    WLAN_REASON_CODE_MSMSEC_PROFILE_INVALID_PREAUTH_THROTTLE       = 0x00040010,
    WLAN_REASON_CODE_MSMSEC_PROFILE_PREAUTH_ONLY_ENABLED           = 0x00040011,
    WLAN_REASON_CODE_MSMSEC_CAPABILITY_NETWORK                     = 0x00040012,
    WLAN_REASON_CODE_MSMSEC_CAPABILITY_NIC                         = 0x00040013,
    WLAN_REASON_CODE_MSMSEC_CAPABILITY_PROFILE                     = 0x00040014,
    WLAN_REASON_CODE_MSMSEC_CAPABILITY_DISCOVERY                   = 0x00040015,
    WLAN_REASON_CODE_MSMSEC_PROFILE_PASSPHRASE_CHAR                = 0x00040016,
    WLAN_REASON_CODE_MSMSEC_PROFILE_KEYMATERIAL_CHAR               = 0x00040017,
    WLAN_REASON_CODE_MSMSEC_PROFILE_WRONG_KEYTYPE                  = 0x00040018,
    WLAN_REASON_CODE_MSMSEC_MIXED_CELL                             = 0x00040019,
    WLAN_REASON_CODE_MSMSEC_PROFILE_AUTH_TIMERS_INVALID            = 0x0004001a,
    WLAN_REASON_CODE_MSMSEC_PROFILE_INVALID_GKEY_INTV              = 0x0004001b,
    WLAN_REASON_CODE_MSMSEC_TRANSITION_NETWORK                     = 0x0004001c,
    WLAN_REASON_CODE_MSMSEC_PROFILE_KEY_UNMAPPED_CHAR              = 0x0004001d,
    WLAN_REASON_CODE_MSMSEC_CAPABILITY_PROFILE_AUTH                = 0x0004001e,
    WLAN_REASON_CODE_MSMSEC_CAPABILITY_PROFILE_CIPHER              = 0x0004001f,
    WLAN_REASON_CODE_MSMSEC_PROFILE_SAFE_MODE                      = 0x00040020,
    WLAN_REASON_CODE_MSMSEC_CAPABILITY_PROFILE_SAFE_MODE_NIC       = 0x00040021,
    WLAN_REASON_CODE_MSMSEC_CAPABILITY_PROFILE_SAFE_MODE_NW        = 0x00040022,
    WLAN_REASON_CODE_MSMSEC_PROFILE_UNSUPPORTED_AUTH               = 0x00040023,
    WLAN_REASON_CODE_MSMSEC_PROFILE_UNSUPPORTED_CIPHER             = 0x00040024,
    WLAN_REASON_CODE_MSMSEC_CAPABILITY_MFP_NW_NIC                  = 0x00040025,
    WLAN_REASON_CODE_MSMSEC_UI_REQUEST_FAILURE                     = 0x00048001,
    WLAN_REASON_CODE_MSMSEC_AUTH_START_TIMEOUT                     = 0x00048002,
    WLAN_REASON_CODE_MSMSEC_AUTH_SUCCESS_TIMEOUT                   = 0x00048003,
    WLAN_REASON_CODE_MSMSEC_KEY_START_TIMEOUT                      = 0x00048004,
    WLAN_REASON_CODE_MSMSEC_KEY_SUCCESS_TIMEOUT                    = 0x00048005,
    WLAN_REASON_CODE_MSMSEC_M3_MISSING_KEY_DATA                    = 0x00048006,
    WLAN_REASON_CODE_MSMSEC_M3_MISSING_IE                          = 0x00048007,
    WLAN_REASON_CODE_MSMSEC_M3_MISSING_GRP_KEY                     = 0x00048008,
    WLAN_REASON_CODE_MSMSEC_PR_IE_MATCHING                         = 0x00048009,
    WLAN_REASON_CODE_MSMSEC_SEC_IE_MATCHING                        = 0x0004800a,
    WLAN_REASON_CODE_MSMSEC_NO_PAIRWISE_KEY                        = 0x0004800b,
    WLAN_REASON_CODE_MSMSEC_G1_MISSING_KEY_DATA                    = 0x0004800c,
    WLAN_REASON_CODE_MSMSEC_G1_MISSING_GRP_KEY                     = 0x0004800d,
    WLAN_REASON_CODE_MSMSEC_PEER_INDICATED_INSECURE                = 0x0004800e,
    WLAN_REASON_CODE_MSMSEC_NO_AUTHENTICATOR                       = 0x0004800f,
    WLAN_REASON_CODE_MSMSEC_NIC_FAILURE                            = 0x00048010,
    WLAN_REASON_CODE_MSMSEC_CANCELLED                              = 0x00048011,
    WLAN_REASON_CODE_MSMSEC_KEY_FORMAT                             = 0x00048012,
    WLAN_REASON_CODE_MSMSEC_DOWNGRADE_DETECTED                     = 0x00048013,
    WLAN_REASON_CODE_MSMSEC_PSK_MISMATCH_SUSPECTED                 = 0x00048014,
    WLAN_REASON_CODE_MSMSEC_FORCED_FAILURE                         = 0x00048015,
    WLAN_REASON_CODE_MSMSEC_M3_TOO_MANY_RSNIE                      = 0x00048016,
    WLAN_REASON_CODE_MSMSEC_M2_MISSING_KEY_DATA                    = 0x00048017,
    WLAN_REASON_CODE_MSMSEC_M2_MISSING_IE                          = 0x00048018,
    WLAN_REASON_CODE_MSMSEC_AUTH_WCN_COMPLETED                     = 0x00048019,
    WLAN_REASON_CODE_MSMSEC_M3_MISSING_MGMT_GRP_KEY                = 0x0004801a,
    WLAN_REASON_CODE_MSMSEC_G1_MISSING_MGMT_GRP_KEY                = 0x0004801b,
    WLAN_REASON_CODE_MSMSEC_MAX                                    = 0x0004ffff,
}

enum : uint
{
    WLAN_AVAILABLE_NETWORK_CONNECTED                          = 0x00000001,
    WLAN_AVAILABLE_NETWORK_HAS_PROFILE                        = 0x00000002,
    WLAN_AVAILABLE_NETWORK_CONSOLE_USER_PROFILE               = 0x00000004,
    WLAN_AVAILABLE_NETWORK_INTERWORKING_SUPPORTED             = 0x00000008,
    WLAN_AVAILABLE_NETWORK_HOTSPOT2_ENABLED                   = 0x00000010,
    WLAN_AVAILABLE_NETWORK_ANQP_SUPPORTED                     = 0x00000020,
    WLAN_AVAILABLE_NETWORK_HOTSPOT2_DOMAIN                    = 0x00000040,
    WLAN_AVAILABLE_NETWORK_HOTSPOT2_ROAMING                   = 0x00000080,
    WLAN_AVAILABLE_NETWORK_AUTO_CONNECT_FAILED                = 0x00000100,
    WLAN_AVAILABLE_NETWORK_INCLUDE_ALL_ADHOC_PROFILES         = 0x00000001,
    WLAN_AVAILABLE_NETWORK_INCLUDE_ALL_MANUAL_HIDDEN_PROFILES = 0x00000002,
}

enum : uint
{
    WLAN_MAX_PHY_TYPE_NUMBER = 0x00000008,
    WLAN_MAX_PHY_INDEX       = 0x00000040,
}

enum : uint
{
    WLAN_CONNECTION_HIDDEN_NETWORK                                 = 0x00000001,
    WLAN_CONNECTION_ADHOC_JOIN_ONLY                                = 0x00000002,
    WLAN_CONNECTION_IGNORE_PRIVACY_BIT                             = 0x00000004,
    WLAN_CONNECTION_EAPOL_PASSTHROUGH                              = 0x00000008,
    WLAN_CONNECTION_PERSIST_DISCOVERY_PROFILE                      = 0x00000010,
    WLAN_CONNECTION_PERSIST_DISCOVERY_PROFILE_CONNECTION_MODE_AUTO = 0x00000020,
    WLAN_CONNECTION_PERSIST_DISCOVERY_PROFILE_OVERWRITE_EXISTING   = 0x00000040,
}

enum : uint
{
    WFD_API_VERSION_1_0 = 0x00000001,
    WFD_API_VERSION     = 0x00000001,
}

enum : uint
{
    WLAN_UI_API_VERSION         = 0x00000001,
    WLAN_UI_API_INITIAL_VERSION = 0x00000001,
}

enum GUID GUID_DEVINTERFACE_WIFIDIRECT_DEVICE = GUID("439b20af-8955-405b-99f0-a62af0c68d43");
enum GUID GUID_AEPSERVICE_WIFIDIRECT_DEVICE = GUID("cc29827c-9caf-4928-99a9-18f7c2381389");
enum GUID GUID_DEVINTERFACE_ASP_INFRA_DEVICE = GUID("ff823995-7a72-4c80-8757-c67ee13d1a49");

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 1))], [])*/DEVPROPKEY
{
    DEVPKEY_WiFiDirect_DeviceAddress          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 1))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 1),
    DEVPKEY_WiFiDirect_InterfaceAddress       = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 1))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 2),
    DEVPKEY_WiFiDirect_InterfaceGuid          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 1))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 3),
    DEVPKEY_WiFiDirect_GroupId                = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 1))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 4),
    DEVPKEY_WiFiDirect_IsConnected            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 1))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 5),
    DEVPKEY_WiFiDirect_IsVisible              = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 1))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 6),
    DEVPKEY_WiFiDirect_IsLegacyDevice         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 1))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 7),
    DEVPKEY_WiFiDirect_MiracastVersion        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 1))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 8),
    DEVPKEY_WiFiDirect_IsMiracastLCPSupported = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 1))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 9),
    DEVPKEY_WiFiDirect_Services               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 1))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 10),
    DEVPKEY_WiFiDirect_SupportedChannelList   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 1))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 11),
    DEVPKEY_WiFiDirect_InformationElements    = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 1))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 12),
    DEVPKEY_WiFiDirect_DeviceAddressCopy      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 1))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 13),
    DEVPKEY_WiFiDirect_IsRecentlyAssociated   = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 1))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 14),
    DEVPKEY_WiFiDirect_Service_Aeps           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 1))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 15),
    DEVPKEY_WiFiDirect_NoMiracastAutoProject  = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 1))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 16),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 17))], [])*/DEVPROPKEY
{
    DEVPKEY_InfraCast_Supported               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 17))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 17),
    DEVPKEY_InfraCast_StreamSecuritySupported = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 17))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 18),
    DEVPKEY_InfraCast_AccessPointBssid        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 17))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 19),
    DEVPKEY_InfraCast_SinkHostName            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 17))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 20),
    DEVPKEY_InfraCast_ChallengeAep            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 17))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 21),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 22))], [])*/DEVPROPKEY DEVPKEY_WiFiDirect_IsDMGCapable = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 22))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 22);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 23))], [])*/DEVPROPKEY DEVPKEY_InfraCast_DevnodeAep = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 23))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 23);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 24))], [])*/DEVPROPKEY DEVPKEY_WiFiDirect_FoundWsbService = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 24))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 24);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 25))], [])*/DEVPROPKEY
{
    DEVPKEY_InfraCast_HostName_ResolutionMode = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 25))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 25),
    DEVPKEY_InfraCast_SinkIpAddress           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 25))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 26),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 27))], [])*/DEVPROPKEY
{
    DEVPKEY_WiFiDirect_TransientAssociation = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 27))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 27),
    DEVPKEY_WiFiDirect_LinkQuality          = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 27))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 28),
}

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 29))], [])*/DEVPROPKEY
{
    DEVPKEY_InfraCast_PinSupported                         = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 29))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 29),
    DEVPKEY_InfraCast_RtspTcpConnectionParametersSupported = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 29))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 30),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 31))], [])*/DEVPROPKEY DEVPKEY_WiFiDirect_Miracast_SessionMgmtControlPort = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 31))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 31);
enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 32))], [])*/DEVPROPKEY DEVPKEY_WiFiDirect_RtspTcpConnectionParametersSupported = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({352752477, 58343, 17679, 134, 55, 130, 35, 62, 190, 95, 110}, 32))], [])*/DEVPROPKEY(GUID("1506935D-E3E7-450F-8637-82233EBE5F6E"), 32);

enum : /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({833845059, 31838, 16389, 147, 230, 233, 83, 249, 43, 130, 233}, 2))], [])*/DEVPROPKEY
{
    DEVPKEY_WiFiDirectServices_ServiceAddress            = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({833845059, 31838, 16389, 147, 230, 233, 83, 249, 43, 130, 233}, 2))], [])*/DEVPROPKEY(GUID("31B37743-7C5E-4005-93E6-E953F92B82E9"), 2),
    DEVPKEY_WiFiDirectServices_ServiceName               = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({833845059, 31838, 16389, 147, 230, 233, 83, 249, 43, 130, 233}, 2))], [])*/DEVPROPKEY(GUID("31B37743-7C5E-4005-93E6-E953F92B82E9"), 3),
    DEVPKEY_WiFiDirectServices_ServiceInformation        = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({833845059, 31838, 16389, 147, 230, 233, 83, 249, 43, 130, 233}, 2))], [])*/DEVPROPKEY(GUID("31B37743-7C5E-4005-93E6-E953F92B82E9"), 4),
    DEVPKEY_WiFiDirectServices_AdvertisementId           = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({833845059, 31838, 16389, 147, 230, 233, 83, 249, 43, 130, 233}, 2))], [])*/DEVPROPKEY(GUID("31B37743-7C5E-4005-93E6-E953F92B82E9"), 5),
    DEVPKEY_WiFiDirectServices_ServiceConfigMethods      = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({833845059, 31838, 16389, 147, 230, 233, 83, 249, 43, 130, 233}, 2))], [])*/DEVPROPKEY(GUID("31B37743-7C5E-4005-93E6-E953F92B82E9"), 6),
    DEVPKEY_WiFiDirectServices_RequestServiceInformation = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({833845059, 31838, 16389, 147, 230, 233, 83, 249, 43, 130, 233}, 2))], [])*/DEVPROPKEY(GUID("31B37743-7C5E-4005-93E6-E953F92B82E9"), 7),
}

enum /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4010895339, 52220, 17217, 165, 104, 167, 201, 26, 104, 152, 44}, 2))], [])*/DEVPROPKEY DEVPKEY_WiFi_InterfaceGuid = /*FIELD ATTR: ConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig({4010895339, 52220, 17217, 165, 104, 167, 201, 26, 104, 152, 44}, 2))], [])*/DEVPROPKEY(GUID("EF1167EB-CBFC-4341-A568-A7C91A68982C"), 2);
enum uint DOT11EXT_PSK_MAX_LENGTH = 0x00000040;
enum uint WDIAG_IHV_WLAN_ID_FLAG_SECURITY_ENABLED = 0x00000001;
enum /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)* IHV_VERSION_FUNCTION_NAME = "Dot11ExtIhvGetVersionInfo";

enum : /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)*
{
    IHV_INIT_FUNCTION_NAME    = "Dot11ExtIhvInitService",
    IHV_INIT_VS_FUNCTION_NAME = "Dot11ExtIhvInitVirtualStation",
}

enum uint MS_MAX_PROFILE_NAME_LENGTH = 0x00000100;

enum : uint
{
    MS_PROFILE_GROUP_POLICY = 0x00000001,
    MS_PROFILE_USER         = 0x00000002,
}

// Callbacks

alias WLAN_NOTIFICATION_CALLBACK = void function(L2_NOTIFICATION_DATA* param0, void* param1);
alias WFD_OPEN_SESSION_COMPLETE_CALLBACK = void function(HANDLE hSessionHandle, void* pvContext, 
                                                         GUID guidSessionInterface, uint dwError, uint dwReasonCode);
alias DOT11EXT_ALLOCATE_BUFFER = uint function(uint dwByteCount, void** ppvBuffer);
alias DOT11EXT_FREE_BUFFER = void function(void* pvMemory);
alias DOT11EXT_SET_PROFILE_CUSTOM_USER_DATA = uint function(HANDLE hDot11SvcHandle, HANDLE hConnectSession, 
                                                            uint dwSessionID, uint dwDataSize, 
                                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvData);
alias DOT11EXT_GET_PROFILE_CUSTOM_USER_DATA = uint function(HANDLE hDot11SvcHandle, HANDLE hConnectSession, 
                                                            uint dwSessionID, uint* pdwDataSize, void** ppvData);
alias DOT11EXT_SET_CURRENT_PROFILE = uint function(HANDLE hDot11SvcHandle, HANDLE hConnectSession, 
                                                   DOT11EXT_IHV_CONNECTIVITY_PROFILE* pIhvConnProfile, 
                                                   DOT11EXT_IHV_SECURITY_PROFILE* pIhvSecProfile);
alias DOT11EXT_SEND_UI_REQUEST = uint function(HANDLE hDot11SvcHandle, DOT11EXT_IHV_UI_REQUEST* pIhvUIRequest);
alias DOT11EXT_PRE_ASSOCIATE_COMPLETION = uint function(HANDLE hDot11SvcHandle, HANDLE hConnectSession, 
                                                        uint dwReasonCode, uint dwWin32Error);
alias DOT11EXT_POST_ASSOCIATE_COMPLETION = uint function(HANDLE hDot11SvcHandle, HANDLE hSecuritySessionID, 
                                                         ubyte** pPeer, uint dwReasonCode, uint dwWin32Error);
alias DOT11EXT_SEND_NOTIFICATION = uint function(HANDLE hDot11SvcHandle, L2_NOTIFICATION_DATA* pNotificationData);
alias DOT11EXT_SEND_PACKET = uint function(HANDLE hDot11SvcHandle, uint uPacketLen, 
                                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pvPacket, 
                                           HANDLE hSendCompletion);
alias DOT11EXT_SET_ETHERTYPE_HANDLING = uint function(HANDLE hDot11SvcHandle, uint uMaxBackLog, 
                                                      uint uNumOfExemption, DOT11_PRIVACY_EXEMPTION* pExemption, 
                                                      uint uNumOfRegistration, ushort* pusRegistration);
alias DOT11EXT_SET_AUTH_ALGORITHM = uint function(HANDLE hDot11SvcHandle, uint dwAuthAlgo);
alias DOT11EXT_SET_UNICAST_CIPHER_ALGORITHM = uint function(HANDLE hDot11SvcHandle, uint dwUnicastCipherAlgo);
alias DOT11EXT_SET_MULTICAST_CIPHER_ALGORITHM = uint function(HANDLE hDot11SvcHandle, uint dwMulticastCipherAlgo);
alias DOT11EXT_SET_DEFAULT_KEY = uint function(HANDLE hDot11SvcHandle, DOT11_CIPHER_DEFAULT_KEY_VALUE* pKey, 
                                               DOT11_DIRECTION dot11Direction);
alias DOT11EXT_SET_KEY_MAPPING_KEY = uint function(HANDLE hDot11SvcHandle, 
                                                   DOT11_CIPHER_KEY_MAPPING_KEY_VALUE* pKey);
alias DOT11EXT_SET_DEFAULT_KEY_ID = uint function(HANDLE hDot11SvcHandle, uint uDefaultKeyId);
alias DOT11EXT_SET_EXCLUDE_UNENCRYPTED = uint function(HANDLE hDot11SvcHandle, BOOL bExcludeUnencrypted);
alias DOT11EXT_NIC_SPECIFIC_EXTENSION = uint function(HANDLE hDot11SvcHandle, uint dwInBufferSize, 
                                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pvInBuffer, 
                                                      uint* pdwOutBufferSize, 
                                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvOutBuffer);
alias DOT11EXT_ONEX_START = uint function(HANDLE hDot11SvcHandle, EAP_ATTRIBUTES* pEapAttributes);
alias DOT11EXT_ONEX_STOP = uint function(HANDLE hDot11SvcHandle);
alias DOT11EXT_PROCESS_ONEX_PACKET = uint function(HANDLE hDot11SvcHandle, uint dwInPacketSize, 
                                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pvInPacket);
alias DOT11EXT_REQUEST_VIRTUAL_STATION = uint function(HANDLE hDot11PrimaryHandle, 
                                                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);
alias DOT11EXT_RELEASE_VIRTUAL_STATION = uint function(HANDLE hDot11PrimaryHandle, 
                                                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);
alias DOT11EXT_QUERY_VIRTUAL_STATION_PROPERTIES = uint function(HANDLE hDot11SvcHandle, BOOL* pbIsVirtualStation, 
                                                                GUID* pgPrimary, 
                                                                /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);
alias DOT11EXT_SET_VIRTUAL_STATION_AP_PROPERTIES = uint function(HANDLE hDot11SvcHandle, HANDLE hConnectSession, 
                                                                 uint dwNumProperties, 
                                                                 DOT11EXT_VIRTUAL_STATION_AP_PROPERTY* pProperties, 
                                                                 /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);
alias DOT11EXTIHV_GET_VERSION_INFO = uint function(DOT11_IHV_VERSION_INFO* pDot11IHVVersionInfo);
alias DOT11EXTIHV_INIT_SERVICE = uint function(uint dwVerNumUsed, DOT11EXT_APIS* pDot11ExtAPI, 
                                               /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved, 
                                               DOT11EXT_IHV_HANDLERS* pDot11IHVHandlers);
alias DOT11EXTIHV_INIT_VIRTUAL_STATION = uint function(DOT11EXT_VIRTUAL_STATION_APIS* pDot11ExtVSAPI, 
                                                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);
alias DOT11EXTIHV_DEINIT_SERVICE = void function();
alias DOT11EXTIHV_INIT_ADAPTER = uint function(DOT11_ADAPTER* pDot11Adapter, HANDLE hDot11SvcHandle, 
                                               HANDLE* phIhvExtAdapter);
alias DOT11EXTIHV_DEINIT_ADAPTER = void function(HANDLE hIhvExtAdapter);
alias DOT11EXTIHV_PERFORM_PRE_ASSOCIATE = uint function(HANDLE hIhvExtAdapter, HANDLE hConnectSession, 
                                                        DOT11EXT_IHV_PROFILE_PARAMS* pIhvProfileParams, 
                                                        DOT11EXT_IHV_CONNECTIVITY_PROFILE* pIhvConnProfile, 
                                                        DOT11EXT_IHV_SECURITY_PROFILE* pIhvSecProfile, 
                                                        DOT11_BSS_LIST* pConnectableBssid, uint* pdwReasonCode);
alias DOT11EXTIHV_ADAPTER_RESET = uint function(HANDLE hIhvExtAdapter);
alias DOT11EXTIHV_PERFORM_POST_ASSOCIATE = uint function(HANDLE hIhvExtAdapter, HANDLE hSecuritySessionID, 
                                                         DOT11_PORT_STATE* pPortState, uint uDot11AssocParamsBytes, 
                                                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/DOT11_ASSOCIATION_COMPLETION_PARAMETERS* pDot11AssocParams);
alias DOT11EXTIHV_STOP_POST_ASSOCIATE = uint function(HANDLE hIhvExtAdapter, ubyte** pPeer, uint dot11AssocStatus);
alias DOT11EXTIHV_VALIDATE_PROFILE = uint function(HANDLE hIhvExtAdapter, 
                                                   DOT11EXT_IHV_PROFILE_PARAMS* pIhvProfileParams, 
                                                   DOT11EXT_IHV_CONNECTIVITY_PROFILE* pIhvConnProfile, 
                                                   DOT11EXT_IHV_SECURITY_PROFILE* pIhvSecProfile, 
                                                   uint* pdwReasonCode);
alias DOT11EXTIHV_PERFORM_CAPABILITY_MATCH = uint function(HANDLE hIhvExtAdapter, 
                                                           DOT11EXT_IHV_PROFILE_PARAMS* pIhvProfileParams, 
                                                           DOT11EXT_IHV_CONNECTIVITY_PROFILE* pIhvConnProfile, 
                                                           DOT11EXT_IHV_SECURITY_PROFILE* pIhvSecProfile, 
                                                           DOT11_BSS_LIST* pConnectableBssid, uint* pdwReasonCode);
alias DOT11EXTIHV_CREATE_DISCOVERY_PROFILES = uint function(HANDLE hIhvExtAdapter, BOOL bInsecure, 
                                                            DOT11EXT_IHV_PROFILE_PARAMS* pIhvProfileParams, 
                                                            DOT11_BSS_LIST* pConnectableBssid, 
                                                            DOT11EXT_IHV_DISCOVERY_PROFILE_LIST* pIhvDiscoveryProfileList, 
                                                            uint* pdwReasonCode);
alias DOT11EXTIHV_PROCESS_SESSION_CHANGE = uint function(uint uEventType, 
                                                         WTSSESSION_NOTIFICATION* pSessionNotification);
alias DOT11EXTIHV_RECEIVE_INDICATION = uint function(HANDLE hIhvExtAdapter, 
                                                     DOT11EXT_IHV_INDICATION_TYPE indicationType, uint uBufferLength, 
                                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pvBuffer);
alias DOT11EXTIHV_RECEIVE_PACKET = uint function(HANDLE hIhvExtAdapter, uint dwInBufferSize, 
                                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pvInBuffer);
alias DOT11EXTIHV_SEND_PACKET_COMPLETION = uint function(HANDLE hSendCompletion);
alias DOT11EXTIHV_IS_UI_REQUEST_PENDING = uint function(GUID guidUIRequest, BOOL* pbIsRequestPending);
alias DOT11EXTIHV_PROCESS_UI_RESPONSE = uint function(GUID guidUIRequest, uint dwByteCount, 
                                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pvResponseBuffer);
alias DOT11EXTIHV_QUERY_UI_REQUEST = uint function(HANDLE hIhvExtAdapter, 
                                                   DOT11EXT_IHV_CONNECTION_PHASE connectionPhase, 
                                                   DOT11EXT_IHV_UI_REQUEST** ppIhvUIRequest);
alias DOT11EXTIHV_ONEX_INDICATE_RESULT = uint function(HANDLE hIhvExtAdapter, DOT11_MSONEX_RESULT msOneXResult, 
                                                       DOT11_MSONEX_RESULT_PARAMS* pDot11MsOneXResultParams);
alias DOT11EXTIHV_CONTROL = uint function(HANDLE hIhvExtAdapter, uint dwInBufferSize, 
                                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* pInBuffer, 
                                          uint dwOutBufferSize, 
                                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pOutBuffer, 
                                          uint* pdwBytesReturned);

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/NativeWiFi/dot11-ssid))], [])
struct DOT11_SSID
{
    uint      uSSIDLength;
    ubyte[32] ucSSID;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/NativeWiFi/dot11-auth-cipher-pair))], [])
struct DOT11_AUTH_CIPHER_PAIR
{
    DOT11_AUTH_ALGORITHM AuthAlgoId;
    DOT11_CIPHER_ALGORITHM CipherAlgoId;
}

struct DOT11_OI
{
    ushort   OILength;
    ubyte[5] OI;
}

struct DOT11_ACCESSNETWORKOPTIONS
{
    ubyte AccessNetworkType;
    ubyte Internet;
    ubyte ASRA;
    ubyte ESR;
    ubyte UESA;
}

struct DOT11_VENUEINFO
{
    ubyte VenueGroup;
    ubyte VenueType;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/NativeWiFi/dot11-bssid-list))], [])
struct DOT11_BSSID_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[6] BSSIDs;
}

struct RSNA_AKM_CIPHER_PAIR
{
    RSNA_AKM_SUITE    akm;
    RSNA_CIPHER_SUITE cipher;
}

struct DOT11_RATE_SET
{
    uint       uRateSetLength;
    ubyte[126] ucRateSet;
}

struct DOT11_AKM_CIPHER_PAIR
{
    RSNA_AKM_SUITE    akm;
    RSNA_CIPHER_SUITE cipher;
}

struct DOT11_WFD_SESSION_INFO
{
    ushort     uSessionInfoLength;
    ubyte[144] ucSessionInfo;
}

struct DOT11_OFFLOAD_CAPABILITY
{
    uint uReserved;
    uint uFlags;
    uint uSupportedWEPAlgorithms;
    uint uNumOfReplayWindows;
    uint uMaxWEPKeyMappingLength;
    uint uSupportedAuthAlgorithms;
    uint uMaxAuthKeyMappingLength;
}

struct DOT11_CURRENT_OFFLOAD_CAPABILITY
{
    uint uReserved;
    uint uFlags;
}

struct DOT11_IV48_COUNTER
{
    uint   uIV32Counter;
    ushort usIV16Counter;
}

struct DOT11_WEP_OFFLOAD
{
    uint               uReserved;
    HANDLE             hOffloadContext;
    HANDLE             hOffload;
    DOT11_OFFLOAD_TYPE dot11OffloadType;
    uint               dwAlgorithm;
    BOOLEAN            bRowIsOutbound;
    BOOLEAN            bUseDefault;
    uint               uFlags;
    ubyte[6]           ucMacAddress;
    uint               uNumOfRWsOnPeer;
    uint               uNumOfRWsOnMe;
    DOT11_IV48_COUNTER[16] dot11IV48Counters;
    ushort[16]         usDot11RWBitMaps;
    ushort             usKeyLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] ucKey;
}

struct DOT11_WEP_UPLOAD
{
    uint               uReserved;
    DOT11_OFFLOAD_TYPE dot11OffloadType;
    HANDLE             hOffload;
    uint               uNumOfRWsUsed;
    DOT11_IV48_COUNTER[16] dot11IV48Counters;
    ushort[16]         usDot11RWBitMaps;
}

struct DOT11_DEFAULT_WEP_OFFLOAD
{
    uint                uReserved;
    HANDLE              hOffloadContext;
    HANDLE              hOffload;
    uint                dwIndex;
    DOT11_OFFLOAD_TYPE  dot11OffloadType;
    uint                dwAlgorithm;
    uint                uFlags;
    DOT11_KEY_DIRECTION dot11KeyDirection;
    ubyte[6]            ucMacAddress;
    uint                uNumOfRWsOnMe;
    DOT11_IV48_COUNTER[16] dot11IV48Counters;
    ushort[16]          usDot11RWBitMaps;
    ushort              usKeyLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] ucKey;
}

struct DOT11_DEFAULT_WEP_UPLOAD
{
    uint               uReserved;
    DOT11_OFFLOAD_TYPE dot11OffloadType;
    HANDLE             hOffload;
    uint               uNumOfRWsUsed;
    DOT11_IV48_COUNTER[16] dot11IV48Counters;
    ushort[16]         usDot11RWBitMaps;
}

struct DOT11_OPERATION_MODE_CAPABILITY
{
    uint uReserved;
    uint uMajorVersion;
    uint uMinorVersion;
    uint uNumOfTXBuffers;
    uint uNumOfRXBuffers;
    uint uOpModeCapability;
}

struct DOT11_CURRENT_OPERATION_MODE
{
    uint uReserved;
    uint uCurrentOpMode;
}

struct DOT11_SCAN_REQUEST
{
    DOT11_BSS_TYPE  dot11BSSType;
    ubyte[6]        dot11BSSID;
    DOT11_SSID      dot11SSID;
    DOT11_SCAN_TYPE dot11ScanType;
    BOOLEAN         bRestrictedScan;
    BOOLEAN         bUseRequestIE;
    uint            uRequestIDsOffset;
    uint            uNumOfRequestIDs;
    uint            uPhyTypesOffset;
    uint            uNumOfPhyTypes;
    uint            uIEsOffset;
    uint            uIEsLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] ucBuffer;
}

struct DOT11_PHY_TYPE_INFO
{
    DOT11_PHY_TYPE      dot11PhyType;
    BOOLEAN             bUseParameters;
    uint                uProbeDelay;
    uint                uMinChannelTime;
    uint                uMaxChannelTime;
    CH_DESCRIPTION_TYPE ChDescriptionType;
    uint                uChannelListSize;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] ucChannelListBuffer;
}

struct DOT11_SCAN_REQUEST_V2
{
    DOT11_BSS_TYPE  dot11BSSType;
    ubyte[6]        dot11BSSID;
    DOT11_SCAN_TYPE dot11ScanType;
    BOOLEAN         bRestrictedScan;
    uint            udot11SSIDsOffset;
    uint            uNumOfdot11SSIDs;
    BOOLEAN         bUseRequestIE;
    uint            uRequestIDsOffset;
    uint            uNumOfRequestIDs;
    uint            uPhyTypeInfosOffset;
    uint            uNumOfPhyTypeInfos;
    uint            uIEsOffset;
    uint            uIEsLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] ucBuffer;
}

struct DOT11_PHY_TYPE_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DOT11_PHY_TYPE[1] dot11PhyType;
}

struct DOT11_BSS_DESCRIPTION
{
    uint           uReserved;
    ubyte[6]       dot11BSSID;
    DOT11_BSS_TYPE dot11BSSType;
    ushort         usBeaconPeriod;
    ulong          ullTimestamp;
    ushort         usCapabilityInformation;
    uint           uBufferLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] ucBuffer;
}

struct DOT11_JOIN_REQUEST
{
    uint           uJoinFailureTimeout;
    DOT11_RATE_SET OperationalRateSet;
    uint           uChCenterFrequency;
    DOT11_BSS_DESCRIPTION dot11BSSDescription;
}

struct DOT11_START_REQUEST
{
    uint           uStartFailureTimeout;
    DOT11_RATE_SET OperationalRateSet;
    uint           uChCenterFrequency;
    DOT11_BSS_DESCRIPTION dot11BSSDescription;
}

struct DOT11_UPDATE_IE
{
    DOT11_UPDATE_IE_OP dot11UpdateIEOp;
    uint               uBufferLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] ucBuffer;
}

struct DOT11_RESET_REQUEST
{
    DOT11_RESET_TYPE dot11ResetType;
    ubyte[6]         dot11MacAddress;
    BOOLEAN          bSetDefaultMIB;
}

struct DOT11_OPTIONAL_CAPABILITY
{
    uint    uReserved;
    BOOLEAN bDot11PCF;
    BOOLEAN bDot11PCFMPDUTransferToPC;
    BOOLEAN bStrictlyOrderedServiceClass;
}

struct DOT11_CURRENT_OPTIONAL_CAPABILITY
{
    uint    uReserved;
    BOOLEAN bDot11CFPollable;
    BOOLEAN bDot11PCF;
    BOOLEAN bDot11PCFMPDUTransferToPC;
    BOOLEAN bStrictlyOrderedServiceClass;
}

struct DOT11_POWER_MGMT_MODE
{
    DOT11_POWER_MODE dot11PowerMode;
    uint             uPowerSaveLevel;
    ushort           usListenInterval;
    ushort           usAID;
    BOOLEAN          bReceiveDTIMs;
}

struct DOT11_COUNTERS_ENTRY
{
    uint uTransmittedFragmentCount;
    uint uMulticastTransmittedFrameCount;
    uint uFailedCount;
    uint uRetryCount;
    uint uMultipleRetryCount;
    uint uFrameDuplicateCount;
    uint uRTSSuccessCount;
    uint uRTSFailureCount;
    uint uACKFailureCount;
    uint uReceivedFragmentCount;
    uint uMulticastReceivedFrameCount;
    uint uFCSErrorCount;
    uint uTransmittedFrameCount;
}

struct DOT11_SUPPORTED_PHY_TYPES
{
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DOT11_PHY_TYPE[1] dot11PHYType;
}

struct DOT11_SUPPORTED_POWER_LEVELS
{
    uint    uNumOfSupportedPowerLevels;
    uint[8] uTxPowerLevelValues;
}

struct DOT11_REG_DOMAIN_VALUE
{
    uint uRegDomainsSupportIndex;
    uint uRegDomainsSupportValue;
}

struct DOT11_REG_DOMAINS_SUPPORT_VALUE
{
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DOT11_REG_DOMAIN_VALUE[1] dot11RegDomainValue;
}

struct DOT11_SUPPORTED_ANTENNA
{
    uint    uAntennaListIndex;
    BOOLEAN bSupportedAntenna;
}

struct DOT11_SUPPORTED_ANTENNA_LIST
{
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DOT11_SUPPORTED_ANTENNA[1] dot11SupportedAntenna;
}

struct DOT11_DIVERSITY_SELECTION_RX
{
    uint    uAntennaListIndex;
    BOOLEAN bDiversitySelectionRX;
}

struct DOT11_DIVERSITY_SELECTION_RX_LIST
{
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DOT11_DIVERSITY_SELECTION_RX[1] dot11DiversitySelectionRx;
}

struct DOT11_SUPPORTED_DATA_RATES_VALUE
{
    ubyte[8] ucSupportedTxDataRatesValue;
    ubyte[8] ucSupportedRxDataRatesValue;
}

struct DOT11_SUPPORTED_DATA_RATES_VALUE_V2
{
    ubyte[255] ucSupportedTxDataRatesValue;
    ubyte[255] ucSupportedRxDataRatesValue;
}

struct DOT11_MULTI_DOMAIN_CAPABILITY_ENTRY
{
    uint uMultiDomainCapabilityIndex;
    uint uFirstChannelNumber;
    uint uNumberOfChannels;
    int  lMaximumTransmitPowerLevel;
}

struct DOT11_MD_CAPABILITY_ENTRY_LIST
{
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DOT11_MULTI_DOMAIN_CAPABILITY_ENTRY[1] dot11MDCapabilityEntry;
}

struct DOT11_HOPPING_PATTERN_ENTRY
{
    uint uHoppingPatternIndex;
    uint uRandomTableFieldNumber;
}

struct DOT11_HOPPING_PATTERN_ENTRY_LIST
{
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DOT11_HOPPING_PATTERN_ENTRY[1] dot11HoppingPatternEntry;
}

struct DOT11_WPA_TSC
{
    uint               uReserved;
    DOT11_OFFLOAD_TYPE dot11OffloadType;
    HANDLE             hOffload;
    DOT11_IV48_COUNTER dot11IV48Counter;
}

struct DOT11_RSSI_RANGE
{
    DOT11_PHY_TYPE dot11PhyType;
    uint           uRSSIMin;
    uint           uRSSIMax;
}

struct DOT11_NIC_SPECIFIC_EXTENSION
{
    uint uBufferLength;
    uint uTotalBufferLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] ucBuffer;
}

struct DOT11_AP_JOIN_REQUEST
{
    uint           uJoinFailureTimeout;
    DOT11_RATE_SET OperationalRateSet;
    uint           uChCenterFrequency;
    DOT11_BSS_DESCRIPTION dot11BSSDescription;
}

struct DOT11_RECV_SENSITIVITY
{
    ubyte ucDataRate;
    int   lRSSIMin;
    int   lRSSIMax;
}

struct DOT11_RECV_SENSITIVITY_LIST
{
    _Anonymous_e__Union Anonymous;
    uint                uNumOfEntries;
    uint                uTotalNumOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DOT11_RECV_SENSITIVITY[1] dot11RecvSensitivity;
}

struct DOT11_WME_AC_PARAMETERS
{
    ubyte  ucAccessCategoryIndex;
    ubyte  ucAIFSN;
    ubyte  ucECWmin;
    ubyte  ucECWmax;
    ushort usTXOPLimit;
}

struct DOT11_WME_AC_PARAMETERS_LIST
{
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DOT11_WME_AC_PARAMETERS[1] dot11WMEACParameters;
}

struct DOT11_WME_UPDATE_IE
{
    uint uParamElemMinBeaconIntervals;
    uint uWMEInfoElemOffset;
    uint uWMEInfoElemLength;
    uint uWMEParamElemOffset;
    uint uWMEParamElemLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] ucBuffer;
}

struct DOT11_QOS_TX_DURATION
{
    uint uNominalMSDUSize;
    uint uMinPHYRate;
    uint uDuration;
}

struct DOT11_QOS_TX_MEDIUM_TIME
{
    ubyte[6] dot11PeerAddress;
    ubyte    ucQoSPriority;
    uint     uMediumTimeAdmited;
}

struct DOT11_SUPPORTED_OFDM_FREQUENCY
{
    uint uCenterFrequency;
}

struct DOT11_SUPPORTED_OFDM_FREQUENCY_LIST
{
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DOT11_SUPPORTED_OFDM_FREQUENCY[1] dot11SupportedOFDMFrequency;
}

struct DOT11_SUPPORTED_DSSS_CHANNEL
{
    uint uChannel;
}

struct DOT11_SUPPORTED_DSSS_CHANNEL_LIST
{
    uint uNumOfEntries;
    uint uTotalNumOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DOT11_SUPPORTED_DSSS_CHANNEL[1] dot11SupportedDSSSChannel;
}

struct DOT11_BYTE_ARRAY
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfBytes;
    uint               uTotalNumOfBytes;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] ucBuffer;
}

union DOT11_BSS_ENTRY_PHY_SPECIFIC_INFO
{
    uint            uChCenterFrequency;
    _FHSS_e__Struct FHSS;
}

struct DOT11_BSS_ENTRY
{
    uint           uPhyId;
    DOT11_BSS_ENTRY_PHY_SPECIFIC_INFO PhySpecificInfo;
    ubyte[6]       dot11BSSID;
    DOT11_BSS_TYPE dot11BSSType;
    int            lRSSI;
    uint           uLinkQuality;
    BOOLEAN        bInRegDomain;
    ushort         usBeaconPeriod;
    ulong          ullTimestamp;
    ulong          ullHostTimestamp;
    ushort         usCapabilityInformation;
    uint           uBufferLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] ucBuffer;
}

struct DOT11_SSID_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DOT11_SSID[1] SSIDs;
}

struct DOT11_MAC_ADDRESS_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[6] MacAddrs;
}

struct DOT11_PMKID_ENTRY
{
    ubyte[6]  BSSID;
    ubyte[16] PMKID;
    uint      uFlags;
}

struct DOT11_PMKID_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DOT11_PMKID_ENTRY[1] PMKIDs;
}

struct DOT11_PHY_FRAME_STATISTICS
{
    ulong ullTransmittedFrameCount;
    ulong ullMulticastTransmittedFrameCount;
    ulong ullFailedCount;
    ulong ullRetryCount;
    ulong ullMultipleRetryCount;
    ulong ullMaxTXLifetimeExceededCount;
    ulong ullTransmittedFragmentCount;
    ulong ullRTSSuccessCount;
    ulong ullRTSFailureCount;
    ulong ullACKFailureCount;
    ulong ullReceivedFrameCount;
    ulong ullMulticastReceivedFrameCount;
    ulong ullPromiscuousReceivedFrameCount;
    ulong ullMaxRXLifetimeExceededCount;
    ulong ullFrameDuplicateCount;
    ulong ullReceivedFragmentCount;
    ulong ullPromiscuousReceivedFragmentCount;
    ulong ullFCSErrorCount;
}

struct DOT11_MAC_FRAME_STATISTICS
{
    ulong ullTransmittedFrameCount;
    ulong ullReceivedFrameCount;
    ulong ullTransmittedFailureFrameCount;
    ulong ullReceivedFailureFrameCount;
    ulong ullWEPExcludedCount;
    ulong ullTKIPLocalMICFailures;
    ulong ullTKIPReplays;
    ulong ullTKIPICVErrorCount;
    ulong ullCCMPReplays;
    ulong ullCCMPDecryptErrors;
    ulong ullWEPUndecryptableCount;
    ulong ullWEPICVErrorCount;
    ulong ullDecryptSuccessCount;
    ulong ullDecryptFailureCount;
}

struct DOT11_STATISTICS
{
    NDIS_OBJECT_HEADER Header;
    ulong              ullFourWayHandshakeFailures;
    ulong              ullTKIPCounterMeasuresInvoked;
    ulong              ullReserved;
    DOT11_MAC_FRAME_STATISTICS MacUcastCounters;
    DOT11_MAC_FRAME_STATISTICS MacMcastCounters;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DOT11_PHY_FRAME_STATISTICS[1] PhyCounters;
}

struct DOT11_PRIVACY_EXEMPTION
{
    ushort usEtherType;
    ushort usExemptionActionType;
    ushort usExemptionPacketType;
}

struct DOT11_PRIVACY_EXEMPTION_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DOT11_PRIVACY_EXEMPTION[1] PrivacyExemptionEntries;
}

struct DOT11_AUTH_ALGORITHM_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DOT11_AUTH_ALGORITHM[1] AlgorithmIds;
}

struct DOT11_AUTH_CIPHER_PAIR_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DOT11_AUTH_CIPHER_PAIR[1] AuthCipherPairs;
}

struct DOT11_CIPHER_ALGORITHM_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DOT11_CIPHER_ALGORITHM[1] AlgorithmIds;
}

struct DOT11_CIPHER_DEFAULT_KEY_VALUE
{
    NDIS_OBJECT_HEADER Header;
    uint               uKeyIndex;
    DOT11_CIPHER_ALGORITHM AlgorithmId;
    ubyte[6]           MacAddr;
    BOOLEAN            bDelete;
    BOOLEAN            bStatic;
    ushort             usKeyLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] ucKey;
}

struct DOT11_KEY_ALGO_TKIP_MIC
{
    ubyte[6] ucIV48Counter;
    uint     ulTKIPKeyLength;
    uint     ulMICKeyLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] ucTKIPMICKeys;
}

struct DOT11_KEY_ALGO_CCMP
{
    ubyte[6] ucIV48Counter;
    uint     ulCCMPKeyLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] ucCCMPKey;
}

struct DOT11_KEY_ALGO_GCMP
{
    ubyte[6] ucIV48Counter;
    uint     ulGCMPKeyLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] ucGCMPKey;
}

struct DOT11_KEY_ALGO_GCMP_256
{
    ubyte[6] ucIV48Counter;
    uint     ulGCMP256KeyLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] ucGCMP256Key;
}

struct DOT11_KEY_ALGO_BIP
{
    ubyte[6] ucIPN;
    uint     ulBIPKeyLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] ucBIPKey;
}

struct DOT11_KEY_ALGO_BIP_GMAC_256
{
    ubyte[6] ucIPN;
    uint     ulBIPGmac256KeyLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] ucBIPGmac256Key;
}

struct DOT11_CIPHER_KEY_MAPPING_KEY_VALUE
{
    ubyte[6]        PeerMacAddr;
    DOT11_CIPHER_ALGORITHM AlgorithmId;
    DOT11_DIRECTION Direction;
    BOOLEAN         bDelete;
    BOOLEAN         bStatic;
    ushort          usKeyLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] ucKey;
}

struct DOT11_ASSOCIATION_INFO_EX
{
    ubyte[6]         PeerMacAddress;
    ubyte[6]         BSSID;
    ushort           usCapabilityInformation;
    ushort           usListenInterval;
    ubyte[255]       ucPeerSupportedRates;
    ushort           usAssociationID;
    DOT11_ASSOCIATION_STATE dot11AssociationState;
    DOT11_POWER_MODE dot11PowerMode;
    long             liAssociationUpTime;
    ulong            ullNumOfTxPacketSuccesses;
    ulong            ullNumOfTxPacketFailures;
    ulong            ullNumOfRxPacketSuccesses;
    ulong            ullNumOfRxPacketFailures;
}

struct DOT11_ASSOCIATION_INFO_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DOT11_ASSOCIATION_INFO_EX[1] dot11AssocInfo;
}

struct DOT11_PHY_ID_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/uint[1] dot11PhyId;
}

struct DOT11_EXTSTA_CAPABILITY
{
    NDIS_OBJECT_HEADER Header;
    uint               uScanSSIDListSize;
    uint               uDesiredBSSIDListSize;
    uint               uDesiredSSIDListSize;
    uint               uExcludedMacAddressListSize;
    uint               uPrivacyExemptionListSize;
    uint               uKeyMappingTableSize;
    uint               uDefaultKeyTableSize;
    uint               uWEPKeyValueMaxLength;
    uint               uPMKIDCacheSize;
    uint               uMaxNumPerSTADefaultKeyTables;
}

struct DOT11_DATA_RATE_MAPPING_ENTRY
{
    ubyte  ucDataRateIndex;
    ubyte  ucDataRateFlag;
    ushort usDataRateValue;
}

struct DOT11_DATA_RATE_MAPPING_TABLE
{
    NDIS_OBJECT_HEADER Header;
    uint               uDataRateMappingLength;
    DOT11_DATA_RATE_MAPPING_ENTRY[126] DataRateMappingEntries;
}

struct DOT11_COUNTRY_OR_REGION_STRING_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[3] CountryOrRegionStrings;
}

struct DOT11_PORT_STATE_NOTIFICATION
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerMac;
    BOOLEAN            bOpen;
}

struct DOT11_IBSS_PARAMS
{
    NDIS_OBJECT_HEADER Header;
    BOOLEAN            bJoinOnly;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_QOS_PARAMS
{
    NDIS_OBJECT_HEADER Header;
    ubyte              ucEnabledQoSProtocolFlags;
}

struct DOT11_ASSOCIATION_PARAMS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           BSSID;
    uint               uAssocRequestIEsOffset;
    uint               uAssocRequestIEsLength;
}

struct DOT11_FRAGMENT_DESCRIPTOR
{
    uint uOffset;
    uint uLength;
}

struct DOT11_PER_MSDU_COUNTERS
{
    uint uTransmittedFragmentCount;
    uint uRetryCount;
    uint uRTSSuccessCount;
    uint uRTSFailureCount;
    uint uACKFailureCount;
}

struct DOT11_HRDSSS_PHY_ATTRIBUTES
{
    BOOLEAN bShortPreambleOptionImplemented;
    BOOLEAN bPBCCOptionImplemented;
    BOOLEAN bChannelAgilityPresent;
    uint    uHRCCAModeSupported;
}

struct DOT11_OFDM_PHY_ATTRIBUTES
{
    uint uFrequencyBandsSupported;
}

struct DOT11_ERP_PHY_ATTRIBUTES
{
    DOT11_HRDSSS_PHY_ATTRIBUTES HRDSSSAttributes;
    BOOLEAN bERPPBCCOptionImplemented;
    BOOLEAN bDSSSOFDMOptionImplemented;
    BOOLEAN bShortSlotTimeOptionImplemented;
}

struct DOT11_PHY_ATTRIBUTES
{
    NDIS_OBJECT_HEADER Header;
    DOT11_PHY_TYPE     PhyType;
    BOOLEAN            bHardwarePhyState;
    BOOLEAN            bSoftwarePhyState;
    BOOLEAN            bCFPollable;
    uint               uMPDUMaxLength;
    DOT11_TEMP_TYPE    TempType;
    DOT11_DIVERSITY_SUPPORT DiversitySupport;
    _PhySpecificAttributes_e__Union PhySpecificAttributes;
    uint               uNumberSupportedPowerLevels;
    uint[8]            TxPowerLevels;
    uint               uNumDataRateMappingEntries;
    DOT11_DATA_RATE_MAPPING_ENTRY[126] DataRateMappingEntries;
    DOT11_SUPPORTED_DATA_RATES_VALUE_V2 SupportedDataRatesValue;
}

struct DOT11_EXTSTA_ATTRIBUTES
{
    NDIS_OBJECT_HEADER Header;
    uint               uScanSSIDListSize;
    uint               uDesiredBSSIDListSize;
    uint               uDesiredSSIDListSize;
    uint               uExcludedMacAddressListSize;
    uint               uPrivacyExemptionListSize;
    uint               uKeyMappingTableSize;
    uint               uDefaultKeyTableSize;
    uint               uWEPKeyValueMaxLength;
    uint               uPMKIDCacheSize;
    uint               uMaxNumPerSTADefaultKeyTables;
    BOOLEAN            bStrictlyOrderedServiceClassImplemented;
    ubyte              ucSupportedQoSProtocolFlags;
    BOOLEAN            bSafeModeImplemented;
    uint               uNumSupportedCountryOrRegionStrings;
    ubyte*             pSupportedCountryOrRegionStrings;
    uint               uInfraNumSupportedUcastAlgoPairs;
    DOT11_AUTH_CIPHER_PAIR* pInfraSupportedUcastAlgoPairs;
    uint               uInfraNumSupportedMcastAlgoPairs;
    DOT11_AUTH_CIPHER_PAIR* pInfraSupportedMcastAlgoPairs;
    uint               uAdhocNumSupportedUcastAlgoPairs;
    DOT11_AUTH_CIPHER_PAIR* pAdhocSupportedUcastAlgoPairs;
    uint               uAdhocNumSupportedMcastAlgoPairs;
    DOT11_AUTH_CIPHER_PAIR* pAdhocSupportedMcastAlgoPairs;
    BOOLEAN            bAutoPowerSaveMode;
    uint               uMaxNetworkOffloadListSize;
    BOOLEAN            bMFPCapable;
    uint               uInfraNumSupportedMcastMgmtAlgoPairs;
    DOT11_AUTH_CIPHER_PAIR* pInfraSupportedMcastMgmtAlgoPairs;
    BOOLEAN            bNeighborReportSupported;
    BOOLEAN            bAPChannelReportSupported;
    BOOLEAN            bActionFramesSupported;
    BOOLEAN            bANQPQueryOffloadSupported;
    BOOLEAN            bHESSIDConnectionSupported;
}

struct DOT11_RECV_EXTENSION_INFO
{
    uint               uVersion;
    void*              pvReserved;
    DOT11_PHY_TYPE     dot11PhyType;
    uint               uChCenterFrequency;
    int                lRSSI;
    int                lRSSIMin;
    int                lRSSIMax;
    uint               uRSSI;
    ubyte              ucPriority;
    ubyte              ucDataRate;
    ubyte[6]           ucPeerMacAddress;
    uint               dwExtendedStatus;
    HANDLE             hWEPOffloadContext;
    HANDLE             hAuthOffloadContext;
    ushort             usWEPAppliedMask;
    ushort             usWPAMSDUPriority;
    DOT11_IV48_COUNTER dot11LowestIV48Counter;
    ushort             usDot11LeftRWBitMap;
    DOT11_IV48_COUNTER dot11HighestIV48Counter;
    ushort             usDot11RightRWBitMap;
    ushort             usNumberOfMPDUsReceived;
    ushort             usNumberOfFragments;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/void[1]* pNdisPackets;
}

struct DOT11_RECV_EXTENSION_INFO_V2
{
    uint               uVersion;
    void*              pvReserved;
    DOT11_PHY_TYPE     dot11PhyType;
    uint               uChCenterFrequency;
    int                lRSSI;
    uint               uRSSI;
    ubyte              ucPriority;
    ubyte              ucDataRate;
    ubyte[6]           ucPeerMacAddress;
    uint               dwExtendedStatus;
    HANDLE             hWEPOffloadContext;
    HANDLE             hAuthOffloadContext;
    ushort             usWEPAppliedMask;
    ushort             usWPAMSDUPriority;
    DOT11_IV48_COUNTER dot11LowestIV48Counter;
    ushort             usDot11LeftRWBitMap;
    DOT11_IV48_COUNTER dot11HighestIV48Counter;
    ushort             usDot11RightRWBitMap;
    ushort             usNumberOfMPDUsReceived;
    ushort             usNumberOfFragments;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/void[1]* pNdisPackets;
}

struct DOT11_STATUS_INDICATION
{
    uint uStatusType;
    int  ndisStatus;
}

struct DOT11_MPDU_MAX_LENGTH_INDICATION
{
    NDIS_OBJECT_HEADER Header;
    uint               uPhyId;
    uint               uMPDUMaxLength;
}

struct DOT11_ASSOCIATION_START_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           MacAddr;
    DOT11_SSID         SSID;
    uint               uIHVDataOffset;
    uint               uIHVDataSize;
}

struct DOT11_ENCAP_ENTRY
{
    ushort usEtherType;
    ushort usEncapType;
}

struct DOT11_ASSOCIATION_COMPLETION_PARAMETERS
{
    NDIS_OBJECT_HEADER   Header;
    ubyte[6]             MacAddr;
    uint                 uStatus;
    BOOLEAN              bReAssocReq;
    BOOLEAN              bReAssocResp;
    uint                 uAssocReqOffset;
    uint                 uAssocReqSize;
    uint                 uAssocRespOffset;
    uint                 uAssocRespSize;
    uint                 uBeaconOffset;
    uint                 uBeaconSize;
    uint                 uIHVDataOffset;
    uint                 uIHVDataSize;
    DOT11_AUTH_ALGORITHM AuthAlgo;
    DOT11_CIPHER_ALGORITHM UnicastCipher;
    DOT11_CIPHER_ALGORITHM MulticastCipher;
    uint                 uActivePhyListOffset;
    uint                 uActivePhyListSize;
    BOOLEAN              bFourAddressSupported;
    BOOLEAN              bPortAuthorized;
    ubyte                ucActiveQoSProtocol;
    DOT11_DS_INFO        DSInfo;
    uint                 uEncapTableOffset;
    uint                 uEncapTableSize;
    DOT11_CIPHER_ALGORITHM MulticastMgmtCipher;
    uint                 uAssocComebackTime;
}

struct DOT11_CONNECTION_START_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    DOT11_BSS_TYPE     BSSType;
    ubyte[6]           AdhocBSSID;
    DOT11_SSID         AdhocSSID;
}

struct DOT11_CONNECTION_COMPLETION_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint               uStatus;
}

struct DOT11_ROAMING_START_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           AdhocBSSID;
    DOT11_SSID         AdhocSSID;
    uint               uRoamingReason;
}

struct DOT11_ROAMING_COMPLETION_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint               uStatus;
}

struct DOT11_DISASSOCIATION_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           MacAddr;
    uint               uReason;
    uint               uIHVDataOffset;
    uint               uIHVDataSize;
}

struct DOT11_TKIPMIC_FAILURE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    BOOLEAN            bDefaultKeyFailure;
    uint               uKeyIndex;
    ubyte[6]           PeerMac;
}

struct DOT11_PMKID_CANDIDATE_LIST_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint               uCandidateListSize;
    uint               uCandidateListOffset;
}

struct DOT11_BSSID_CANDIDATE
{
    ubyte[6] BSSID;
    uint     uFlags;
}

struct DOT11_PHY_STATE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint               uPhyId;
    BOOLEAN            bHardwarePhyState;
    BOOLEAN            bSoftwarePhyState;
}

struct DOT11_LINK_QUALITY_ENTRY
{
    ubyte[6] PeerMacAddr;
    ubyte    ucLinkQuality;
}

struct DOT11_LINK_QUALITY_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint               uLinkQualityListSize;
    uint               uLinkQualityListOffset;
}

struct DOT11_EXTSTA_SEND_CONTEXT
{
    NDIS_OBJECT_HEADER Header;
    ushort             usExemptionActionType;
    uint               uPhyId;
    uint               uDelayedSleepValue;
    void*              pvMediaSpecificInfo;
    uint               uSendFlags;
}

struct DOT11_EXTSTA_RECV_CONTEXT
{
    NDIS_OBJECT_HEADER Header;
    uint               uReceiveFlags;
    uint               uPhyId;
    uint               uChCenterFrequency;
    ushort             usNumberOfMPDUsReceived;
    int                lRSSI;
    ubyte              ucDataRate;
    uint               uSizeMediaSpecificInfo;
    void*              pvMediaSpecificInfo;
    ulong              ullTimestamp;
}

struct DOT11_EXTAP_ATTRIBUTES
{
    NDIS_OBJECT_HEADER Header;
    uint               uScanSSIDListSize;
    uint               uDesiredSSIDListSize;
    uint               uPrivacyExemptionListSize;
    uint               uAssociationTableSize;
    uint               uDefaultKeyTableSize;
    uint               uWEPKeyValueMaxLength;
    BOOLEAN            bStrictlyOrderedServiceClassImplemented;
    uint               uNumSupportedCountryOrRegionStrings;
    ubyte*             pSupportedCountryOrRegionStrings;
    uint               uInfraNumSupportedUcastAlgoPairs;
    DOT11_AUTH_CIPHER_PAIR* pInfraSupportedUcastAlgoPairs;
    uint               uInfraNumSupportedMcastAlgoPairs;
    DOT11_AUTH_CIPHER_PAIR* pInfraSupportedMcastAlgoPairs;
}

struct DOT11_INCOMING_ASSOC_STARTED_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerMacAddr;
}

struct DOT11_INCOMING_ASSOC_REQUEST_RECEIVED_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerMacAddr;
    BOOLEAN            bReAssocReq;
    uint               uAssocReqOffset;
    uint               uAssocReqSize;
}

struct DOT11_INCOMING_ASSOC_COMPLETION_PARAMETERS
{
    NDIS_OBJECT_HEADER   Header;
    ubyte[6]             PeerMacAddr;
    uint                 uStatus;
    ubyte                ucErrorSource;
    BOOLEAN              bReAssocReq;
    BOOLEAN              bReAssocResp;
    uint                 uAssocReqOffset;
    uint                 uAssocReqSize;
    uint                 uAssocRespOffset;
    uint                 uAssocRespSize;
    DOT11_AUTH_ALGORITHM AuthAlgo;
    DOT11_CIPHER_ALGORITHM UnicastCipher;
    DOT11_CIPHER_ALGORITHM MulticastCipher;
    uint                 uActivePhyListOffset;
    uint                 uActivePhyListSize;
    uint                 uBeaconOffset;
    uint                 uBeaconSize;
}

struct DOT11_STOP_AP_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint               ulReason;
}

struct DOT11_PHY_FREQUENCY_ADOPTED_PARAMETERS
{
    NDIS_OBJECT_HEADER  Header;
    uint                ulPhyId;
    _Anonymous_e__Union Anonymous;
}

struct DOT11_CAN_SUSTAIN_AP_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint               ulReason;
}

struct DOT11_AVAILABLE_CHANNEL_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/uint[1] uChannelNumber;
}

struct DOT11_AVAILABLE_FREQUENCY_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/uint[1] uFrequencyValue;
}

struct DOT11_DISASSOCIATE_PEER_REQUEST
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerMacAddr;
    ushort             usReason;
}

struct DOT11_INCOMING_ASSOC_DECISION
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerMacAddr;
    BOOLEAN            bAccept;
    ushort             usReasonCode;
    uint               uAssocResponseIEsOffset;
    uint               uAssocResponseIEsLength;
}

struct DOT11_INCOMING_ASSOC_DECISION_V2
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerMacAddr;
    BOOLEAN            bAccept;
    ushort             usReasonCode;
    uint               uAssocResponseIEsOffset;
    uint               uAssocResponseIEsLength;
    ubyte              WFDStatus;
}

struct DOT11_ADDITIONAL_IE
{
    NDIS_OBJECT_HEADER Header;
    uint               uBeaconIEsOffset;
    uint               uBeaconIEsLength;
    uint               uResponseIEsOffset;
    uint               uResponseIEsLength;
}

struct DOT11_PEER_STATISTICS
{
    ulong ullDecryptSuccessCount;
    ulong ullDecryptFailureCount;
    ulong ullTxPacketSuccessCount;
    ulong ullTxPacketFailureCount;
    ulong ullRxPacketSuccessCount;
    ulong ullRxPacketFailureCount;
}

struct DOT11_PEER_INFO
{
    ubyte[6]             MacAddress;
    ushort               usCapabilityInformation;
    DOT11_AUTH_ALGORITHM AuthAlgo;
    DOT11_CIPHER_ALGORITHM UnicastCipherAlgo;
    DOT11_CIPHER_ALGORITHM MulticastCipherAlgo;
    BOOLEAN              bWpsEnabled;
    ushort               usListenInterval;
    ubyte[255]           ucSupportedRates;
    ushort               usAssociationID;
    DOT11_ASSOCIATION_STATE AssociationState;
    DOT11_POWER_MODE     PowerMode;
    long                 liAssociationUpTime;
    DOT11_PEER_STATISTICS Statistics;
}

struct DOT11_PEER_INFO_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DOT11_PEER_INFO[1] PeerInfo;
}

struct DOT11_VWIFI_COMBINATION
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumInfrastructure;
    uint               uNumAdhoc;
    uint               uNumSoftAP;
}

struct DOT11_VWIFI_COMBINATION_V2
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumInfrastructure;
    uint               uNumAdhoc;
    uint               uNumSoftAP;
    uint               uNumVirtualStation;
}

struct DOT11_VWIFI_COMBINATION_V3
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumInfrastructure;
    uint               uNumAdhoc;
    uint               uNumSoftAP;
    uint               uNumVirtualStation;
    uint               uNumWFDGroup;
}

struct DOT11_VWIFI_ATTRIBUTES
{
    NDIS_OBJECT_HEADER Header;
    uint               uTotalNumOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DOT11_VWIFI_COMBINATION[1] Combinations;
}

struct DOT11_MAC_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint               uOpmodeMask;
}

struct DOT11_MAC_INFO
{
    uint     uReserved;
    uint     uNdisPortNumber;
    ubyte[6] MacAddr;
}

struct DOT11_WFD_ATTRIBUTES
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumConcurrentGORole;
    uint               uNumConcurrentClientRole;
    uint               WPSVersionsSupported;
    BOOLEAN            bServiceDiscoverySupported;
    BOOLEAN            bClientDiscoverabilitySupported;
    BOOLEAN            bInfrastructureManagementSupported;
    uint               uMaxSecondaryDeviceTypeListSize;
    ubyte[6]           DeviceAddress;
    uint               uInterfaceAddressListCount;
    ubyte*             pInterfaceAddressList;
    uint               uNumSupportedCountryOrRegionStrings;
    ubyte*             pSupportedCountryOrRegionStrings;
    uint               uDiscoveryFilterListSize;
    uint               uGORoleClientTableSize;
}

struct DOT11_WFD_DEVICE_TYPE
{
    ushort   CategoryID;
    ushort   SubCategoryID;
    ubyte[4] OUI;
}

struct DOT11_WPS_DEVICE_NAME
{
    uint      uDeviceNameLength;
    ubyte[32] ucDeviceName;
}

struct DOT11_WFD_CONFIGURATION_TIMEOUT
{
    ubyte GOTimeout;
    ubyte ClientTimeout;
}

struct DOT11_WFD_GROUP_ID
{
    ubyte[6]   DeviceAddress;
    DOT11_SSID SSID;
}

struct DOT11_WFD_GO_INTENT
{
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Intent)), FixedArgSig(ElementSig(1)), FixedArgSig(ElementSig(7))], [])*/ubyte _bitfield58;
}

struct DOT11_WFD_CHANNEL
{
    ubyte[3] CountryRegionString;
    ubyte    OperatingClass;
    ubyte    ChannelNumber;
}

struct WFDSVC_CONNECTION_CAPABILITY
{
    BOOLEAN bNew;
    BOOLEAN bClient;
    BOOLEAN bGO;
}

struct DOT11_WFD_SERVICE_HASH_LIST
{
    ushort ServiceHashCount;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[6] ServiceHash;
}

struct DOT11_WFD_ADVERTISEMENT_ID
{
    uint     AdvertisementID;
    ubyte[6] ServiceAddress;
}

struct DOT11_WFD_SESSION_ID
{
    uint     SessionID;
    ubyte[6] SessionAddress;
}

struct DOT11_WFD_ADVERTISED_SERVICE_DESCRIPTOR
{
    uint       AdvertisementID;
    ushort     ConfigMethods;
    ubyte      ServiceNameLength;
    ubyte[255] ServiceName;
}

struct DOT11_WFD_ADVERTISED_SERVICE_LIST
{
    ushort ServiceCount;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DOT11_WFD_ADVERTISED_SERVICE_DESCRIPTOR[1] AdvertisedService;
}

struct DOT11_WFD_DISCOVER_COMPLETE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    int                Status;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    uint               uListOffset;
    uint               uListLength;
}

struct DOT11_GO_NEGOTIATION_REQUEST_SEND_COMPLETE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerDeviceAddress;
    ubyte              DialogToken;
    int                Status;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_RECEIVED_GO_NEGOTIATION_REQUEST_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerDeviceAddress;
    ubyte              DialogToken;
    void*              RequestContext;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_GO_NEGOTIATION_RESPONSE_SEND_COMPLETE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerDeviceAddress;
    ubyte              DialogToken;
    int                Status;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_RECEIVED_GO_NEGOTIATION_RESPONSE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerDeviceAddress;
    ubyte              DialogToken;
    void*              ResponseContext;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_GO_NEGOTIATION_CONFIRMATION_SEND_COMPLETE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerDeviceAddress;
    ubyte              DialogToken;
    int                Status;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_RECEIVED_GO_NEGOTIATION_CONFIRMATION_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerDeviceAddress;
    ubyte              DialogToken;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_INVITATION_REQUEST_SEND_COMPLETE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerDeviceAddress;
    ubyte[6]           ReceiverAddress;
    ubyte              DialogToken;
    int                Status;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_RECEIVED_INVITATION_REQUEST_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           TransmitterDeviceAddress;
    ubyte[6]           BSSID;
    ubyte              DialogToken;
    void*              RequestContext;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_INVITATION_RESPONSE_SEND_COMPLETE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           ReceiverDeviceAddress;
    ubyte              DialogToken;
    int                Status;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_RECEIVED_INVITATION_RESPONSE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           TransmitterDeviceAddress;
    ubyte[6]           BSSID;
    ubyte              DialogToken;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_PROVISION_DISCOVERY_REQUEST_SEND_COMPLETE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerDeviceAddress;
    ubyte[6]           ReceiverAddress;
    ubyte              DialogToken;
    int                Status;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_RECEIVED_PROVISION_DISCOVERY_REQUEST_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           TransmitterDeviceAddress;
    ubyte[6]           BSSID;
    ubyte              DialogToken;
    void*              RequestContext;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_PROVISION_DISCOVERY_RESPONSE_SEND_COMPLETE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           ReceiverDeviceAddress;
    ubyte              DialogToken;
    int                Status;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_RECEIVED_PROVISION_DISCOVERY_RESPONSE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           TransmitterDeviceAddress;
    ubyte[6]           BSSID;
    ubyte              DialogToken;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_ANQP_QUERY_COMPLETE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    DOT11_ANQP_QUERY_RESULT Status;
    HANDLE             hContext;
    uint               uResponseLength;
}

struct DOT11_WFD_DEVICE_CAPABILITY_CONFIG
{
    NDIS_OBJECT_HEADER Header;
    BOOLEAN            bServiceDiscoveryEnabled;
    BOOLEAN            bClientDiscoverabilityEnabled;
    BOOLEAN            bConcurrentOperationSupported;
    BOOLEAN            bInfrastructureManagementEnabled;
    BOOLEAN            bDeviceLimitReached;
    BOOLEAN            bInvitationProcedureEnabled;
    uint               WPSVersionsEnabled;
}

struct DOT11_WFD_GROUP_OWNER_CAPABILITY_CONFIG
{
    NDIS_OBJECT_HEADER Header;
    BOOLEAN            bPersistentGroupEnabled;
    BOOLEAN            bIntraBSSDistributionSupported;
    BOOLEAN            bCrossConnectionSupported;
    BOOLEAN            bPersistentReconnectSupported;
    BOOLEAN            bGroupFormationEnabled;
    uint               uMaximumGroupLimit;
}

struct DOT11_WFD_GROUP_OWNER_CAPABILITY_CONFIG_V2
{
    NDIS_OBJECT_HEADER Header;
    BOOLEAN            bPersistentGroupEnabled;
    BOOLEAN            bIntraBSSDistributionSupported;
    BOOLEAN            bCrossConnectionSupported;
    BOOLEAN            bPersistentReconnectSupported;
    BOOLEAN            bGroupFormationEnabled;
    uint               uMaximumGroupLimit;
    BOOLEAN            bEapolKeyIpAddressAllocationSupported;
}

struct DOT11_WFD_DEVICE_INFO
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           DeviceAddress;
    ushort             ConfigMethods;
    DOT11_WFD_DEVICE_TYPE PrimaryDeviceType;
    DOT11_WPS_DEVICE_NAME DeviceName;
}

struct DOT11_WFD_SECONDARY_DEVICE_TYPE_LIST
{
    NDIS_OBJECT_HEADER Header;
    uint               uNumOfEntries;
    uint               uTotalNumOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DOT11_WFD_DEVICE_TYPE[1] SecondaryDeviceTypes;
}

struct DOT11_WFD_DISCOVER_DEVICE_FILTER
{
    ubyte[6]   DeviceID;
    ubyte      ucBitmask;
    DOT11_SSID GroupSSID;
}

struct DOT11_WFD_DISCOVER_REQUEST
{
    NDIS_OBJECT_HEADER  Header;
    DOT11_WFD_DISCOVER_TYPE DiscoverType;
    DOT11_WFD_SCAN_TYPE ScanType;
    uint                uDiscoverTimeout;
    uint                uDeviceFilterListOffset;
    uint                uNumDeviceFilters;
    uint                uIEsOffset;
    uint                uIEsLength;
    BOOLEAN             bForceScanLegacyNetworks;
}

struct DOT11_WFD_DEVICE_ENTRY
{
    uint           uPhyId;
    DOT11_BSS_ENTRY_PHY_SPECIFIC_INFO PhySpecificInfo;
    ubyte[6]       dot11BSSID;
    DOT11_BSS_TYPE dot11BSSType;
    ubyte[6]       TransmitterAddress;
    int            lRSSI;
    uint           uLinkQuality;
    ushort         usBeaconPeriod;
    ulong          ullTimestamp;
    ulong          ullBeaconHostTimestamp;
    ulong          ullProbeResponseHostTimestamp;
    ushort         usCapabilityInformation;
    uint           uBeaconIEsOffset;
    uint           uBeaconIEsLength;
    uint           uProbeResponseIEsOffset;
    uint           uProbeResponseIEsLength;
}

struct DOT11_WFD_ADDITIONAL_IE
{
    NDIS_OBJECT_HEADER Header;
    uint               uBeaconIEsOffset;
    uint               uBeaconIEsLength;
    uint               uProbeResponseIEsOffset;
    uint               uProbeResponseIEsLength;
    uint               uDefaultRequestIEsOffset;
    uint               uDefaultRequestIEsLength;
}

struct DOT11_SEND_GO_NEGOTIATION_REQUEST_PARAMETERS
{
    NDIS_OBJECT_HEADER  Header;
    ubyte[6]            PeerDeviceAddress;
    ubyte               DialogToken;
    uint                uSendTimeout;
    DOT11_WFD_GO_INTENT GroupOwnerIntent;
    DOT11_WFD_CONFIGURATION_TIMEOUT MinimumConfigTimeout;
    ubyte[6]            IntendedInterfaceAddress;
    ubyte               GroupCapability;
    uint                uIEsOffset;
    uint                uIEsLength;
}

struct DOT11_SEND_GO_NEGOTIATION_RESPONSE_PARAMETERS
{
    NDIS_OBJECT_HEADER  Header;
    ubyte[6]            PeerDeviceAddress;
    ubyte               DialogToken;
    void*               RequestContext;
    uint                uSendTimeout;
    ubyte               Status;
    DOT11_WFD_GO_INTENT GroupOwnerIntent;
    DOT11_WFD_CONFIGURATION_TIMEOUT MinimumConfigTimeout;
    ubyte[6]            IntendedInterfaceAddress;
    ubyte               GroupCapability;
    DOT11_WFD_GROUP_ID  GroupID;
    BOOLEAN             bUseGroupID;
    uint                uIEsOffset;
    uint                uIEsLength;
}

struct DOT11_SEND_GO_NEGOTIATION_CONFIRMATION_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           PeerDeviceAddress;
    ubyte              DialogToken;
    void*              ResponseContext;
    uint               uSendTimeout;
    ubyte              Status;
    ubyte              GroupCapability;
    DOT11_WFD_GROUP_ID GroupID;
    BOOLEAN            bUseGroupID;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_WFD_INVITATION_FLAGS
{
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Reserved)), FixedArgSig(ElementSig(1)), FixedArgSig(ElementSig(7))], [])*/ubyte _bitfield59;
}

struct DOT11_SEND_INVITATION_REQUEST_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte              DialogToken;
    ubyte[6]           PeerDeviceAddress;
    uint               uSendTimeout;
    DOT11_WFD_CONFIGURATION_TIMEOUT MinimumConfigTimeout;
    DOT11_WFD_INVITATION_FLAGS InvitationFlags;
    ubyte[6]           GroupBSSID;
    BOOLEAN            bUseGroupBSSID;
    DOT11_WFD_CHANNEL  OperatingChannel;
    BOOLEAN            bUseSpecifiedOperatingChannel;
    DOT11_WFD_GROUP_ID GroupID;
    BOOLEAN            bLocalGO;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_SEND_INVITATION_RESPONSE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           ReceiverDeviceAddress;
    ubyte              DialogToken;
    void*              RequestContext;
    uint               uSendTimeout;
    ubyte              Status;
    DOT11_WFD_CONFIGURATION_TIMEOUT MinimumConfigTimeout;
    ubyte[6]           GroupBSSID;
    BOOLEAN            bUseGroupBSSID;
    DOT11_WFD_CHANNEL  OperatingChannel;
    BOOLEAN            bUseSpecifiedOperatingChannel;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_SEND_PROVISION_DISCOVERY_REQUEST_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte              DialogToken;
    ubyte[6]           PeerDeviceAddress;
    uint               uSendTimeout;
    ubyte              GroupCapability;
    DOT11_WFD_GROUP_ID GroupID;
    BOOLEAN            bUseGroupID;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_SEND_PROVISION_DISCOVERY_RESPONSE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte[6]           ReceiverDeviceAddress;
    ubyte              DialogToken;
    void*              RequestContext;
    uint               uSendTimeout;
    uint               uIEsOffset;
    uint               uIEsLength;
}

struct DOT11_WFD_DEVICE_LISTEN_CHANNEL
{
    NDIS_OBJECT_HEADER Header;
    ubyte              ChannelNumber;
}

struct DOT11_WFD_GROUP_START_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    DOT11_WFD_CHANNEL  AdvertisedOperatingChannel;
}

struct DOT11_WFD_GROUP_JOIN_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    DOT11_WFD_CHANNEL  GOOperatingChannel;
    uint               GOConfigTime;
    BOOLEAN            bInGroupFormation;
    BOOLEAN            bWaitForWPSReady;
}

struct DOT11_POWER_MGMT_AUTO_MODE_ENABLED_INFO
{
    NDIS_OBJECT_HEADER Header;
    BOOLEAN            bEnabled;
}

struct DOT11_POWER_MGMT_MODE_STATUS_INFO
{
    NDIS_OBJECT_HEADER Header;
    DOT11_POWER_MODE   PowerSaveMode;
    uint               uPowerSaveLevel;
    DOT11_POWER_MODE_REASON Reason;
}

struct DOT11_CHANNEL_HINT
{
    DOT11_PHY_TYPE Dot11PhyType;
    uint           uChannelNumber;
}

struct DOT11_OFFLOAD_NETWORK
{
    DOT11_SSID           Ssid;
    DOT11_CIPHER_ALGORITHM UnicastCipher;
    DOT11_AUTH_ALGORITHM AuthAlgo;
    DOT11_CHANNEL_HINT[4] Dot11ChannelHints;
}

struct DOT11_OFFLOAD_NETWORK_LIST_INFO
{
    NDIS_OBJECT_HEADER Header;
    uint               ulFlags;
    uint               FastScanPeriod;
    uint               FastScanIterations;
    uint               SlowScanPeriod;
    uint               uNumOfEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DOT11_OFFLOAD_NETWORK[1] offloadNetworkList;
}

struct DOT11_OFFLOAD_NETWORK_STATUS_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    int                Status;
}

struct DOT11_MANUFACTURING_TEST
{
    DOT11_MANUFACTURING_TEST_TYPE dot11ManufacturingTestType;
    uint uBufferLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] ucBuffer;
}

struct DOT11_MANUFACTURING_SELF_TEST_SET_PARAMS
{
    DOT11_MANUFACTURING_SELF_TEST_TYPE SelfTestType;
    uint  uTestID;
    uint  uPinBitMask;
    void* pvContext;
    uint  uBufferLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] ucBufferIn;
}

struct DOT11_MANUFACTURING_SELF_TEST_QUERY_RESULTS
{
    DOT11_MANUFACTURING_SELF_TEST_TYPE SelfTestType;
    uint    uTestID;
    BOOLEAN bResult;
    uint    uPinFailedBitMask;
    void*   pvContext;
    uint    uBytesWrittenOut;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] ucBufferOut;
}

struct DOT11_MANUFACTURING_FUNCTIONAL_TEST_RX
{
    BOOLEAN    bEnabled;
    DOT11_BAND Dot11Band;
    uint       uChannel;
    int        PowerLevel;
}

struct DOT11_MANUFACTURING_FUNCTIONAL_TEST_TX
{
    BOOLEAN    bEnable;
    BOOLEAN    bOpenLoop;
    DOT11_BAND Dot11Band;
    uint       uChannel;
    uint       uSetPowerLevel;
    int        ADCPowerLevel;
}

struct DOT11_MANUFACTURING_FUNCTIONAL_TEST_QUERY_ADC
{
    DOT11_BAND Dot11Band;
    uint       uChannel;
    int        ADCPowerLevel;
}

struct DOT11_MANUFACTURING_TEST_SET_DATA
{
    uint uKey;
    uint uOffset;
    uint uBufferLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] ucBufferIn;
}

struct DOT11_MANUFACTURING_TEST_QUERY_DATA
{
    uint uKey;
    uint uOffset;
    uint uBufferLength;
    uint uBytesRead;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] ucBufferOut;
}

struct DOT11_MANUFACTURING_TEST_SLEEP
{
    uint  uSleepTime;
    void* pvContext;
}

struct DOT11_MANUFACTURING_CALLBACK_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    DOT11_MANUFACTURING_CALLBACK_TYPE dot11ManufacturingCallbackType;
    uint               uStatus;
    void*              pvContext;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/l2cmn/ns-l2cmn-l2_notification_data))], [])
struct L2_NOTIFICATION_DATA
{
    WLAN_NOTIFICATION_SOURCES NotificationSource;
    uint  NotificationCode;
    GUID  InterfaceGuid;
    uint  dwDataSize;
    void* pData;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_profile_info))], [])
struct WLAN_PROFILE_INFO
{
    wchar[256] strProfileName;
    uint       dwFlags;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-dot11_network))], [])
struct DOT11_NETWORK
{
    DOT11_SSID     dot11Ssid;
    DOT11_BSS_TYPE dot11BssType;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_raw_data))], [])
struct WLAN_RAW_DATA
{
    uint dwDataSize;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] DataBlob;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_raw_data_list))], [])
struct WLAN_RAW_DATA_LIST
{
    uint dwTotalSize;
    uint dwNumberOfItems;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/_Anonymous_e__Struct[1] DataList;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_rate_set))], [])
struct WLAN_RATE_SET
{
    uint        uRateSetLength;
    ushort[126] usRateSet;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_available_network))], [])
struct WLAN_AVAILABLE_NETWORK
{
    wchar[256]           strProfileName;
    DOT11_SSID           dot11Ssid;
    DOT11_BSS_TYPE       dot11BssType;
    uint                 uNumberOfBssids;
    BOOL                 bNetworkConnectable;
    uint                 wlanNotConnectableReason;
    uint                 uNumberOfPhyTypes;
    DOT11_PHY_TYPE[8]    dot11PhyTypes;
    BOOL                 bMorePhyTypes;
    uint                 wlanSignalQuality;
    BOOL                 bSecurityEnabled;
    DOT11_AUTH_ALGORITHM dot11DefaultAuthAlgorithm;
    DOT11_CIPHER_ALGORITHM dot11DefaultCipherAlgorithm;
    uint                 dwFlags;
    uint                 dwReserved;
}

struct WLAN_AVAILABLE_NETWORK_V2
{
    wchar[256]           strProfileName;
    DOT11_SSID           dot11Ssid;
    DOT11_BSS_TYPE       dot11BssType;
    uint                 uNumberOfBssids;
    BOOL                 bNetworkConnectable;
    uint                 wlanNotConnectableReason;
    uint                 uNumberOfPhyTypes;
    DOT11_PHY_TYPE[8]    dot11PhyTypes;
    BOOL                 bMorePhyTypes;
    uint                 wlanSignalQuality;
    BOOL                 bSecurityEnabled;
    DOT11_AUTH_ALGORITHM dot11DefaultAuthAlgorithm;
    DOT11_CIPHER_ALGORITHM dot11DefaultCipherAlgorithm;
    uint                 dwFlags;
    DOT11_ACCESSNETWORKOPTIONS AccessNetworkOptions;
    ubyte[6]             dot11HESSID;
    DOT11_VENUEINFO      VenueInfo;
    uint                 dwReserved;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_bss_entry))], [])
struct WLAN_BSS_ENTRY
{
    DOT11_SSID     dot11Ssid;
    uint           uPhyId;
    ubyte[6]       dot11Bssid;
    DOT11_BSS_TYPE dot11BssType;
    DOT11_PHY_TYPE dot11BssPhyType;
    int            lRssi;
    uint           uLinkQuality;
    BOOLEAN        bInRegDomain;
    ushort         usBeaconPeriod;
    ulong          ullTimestamp;
    ulong          ullHostTimestamp;
    ushort         usCapabilityInformation;
    uint           ulChCenterFrequency;
    WLAN_RATE_SET  wlanRateSet;
    uint           ulIeOffset;
    uint           ulIeSize;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_bss_list))], [])
struct WLAN_BSS_LIST
{
    uint dwTotalSize;
    uint dwNumberOfItems;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/WLAN_BSS_ENTRY[1] wlanBssEntries;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_interface_info))], [])
struct WLAN_INTERFACE_INFO
{
    GUID                 InterfaceGuid;
    wchar[256]           strInterfaceDescription;
    WLAN_INTERFACE_STATE isState;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_association_attributes))], [])
struct WLAN_ASSOCIATION_ATTRIBUTES
{
    DOT11_SSID     dot11Ssid;
    DOT11_BSS_TYPE dot11BssType;
    ubyte[6]       dot11Bssid;
    DOT11_PHY_TYPE dot11PhyType;
    uint           uDot11PhyIndex;
    uint           wlanSignalQuality;
    uint           ulRxRate;
    uint           ulTxRate;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_security_attributes))], [])
struct WLAN_SECURITY_ATTRIBUTES
{
    BOOL                 bSecurityEnabled;
    BOOL                 bOneXEnabled;
    DOT11_AUTH_ALGORITHM dot11AuthAlgorithm;
    DOT11_CIPHER_ALGORITHM dot11CipherAlgorithm;
}

struct WLAN_QOS_CAPABILITIES
{
    BOOL bMSCSSupported;
    BOOL bDSCPToUPMappingSupported;
    BOOL bSCSSupported;
    BOOL bDSCPPolicySupported;
}

struct WLAN_CONNECTION_QOS_INFO
{
    WLAN_QOS_CAPABILITIES peerCapabilities;
    BOOL bMSCSConfigured;
    BOOL bDSCPToUPMappingConfigured;
    uint ulNumConfiguredSCSStreams;
    uint ulNumConfiguredDSCPPolicies;
}

struct WLAN_QOS_INFO
{
    WLAN_QOS_CAPABILITIES interfaceCapabilities;
    BOOL bConnected;
    WLAN_CONNECTION_QOS_INFO connectionQoSInfo;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_connection_attributes))], [])
struct WLAN_CONNECTION_ATTRIBUTES
{
    WLAN_INTERFACE_STATE isState;
    WLAN_CONNECTION_MODE wlanConnectionMode;
    wchar[256]           strProfileName;
    WLAN_ASSOCIATION_ATTRIBUTES wlanAssociationAttributes;
    WLAN_SECURITY_ATTRIBUTES wlanSecurityAttributes;
}

struct WLAN_REALTIME_CONNECTION_QUALITY_LINK_INFO
{
    ubyte         ucLinkID;
    uint          ulChannelCenterFrequencyMhz;
    uint          ulBandwidth;
    int           lRssi;
    WLAN_RATE_SET wlanRateSet;
}

struct WLAN_REALTIME_CONNECTION_QUALITY
{
    DOT11_PHY_TYPE dot11PhyType;
    uint           ulLinkQuality;
    uint           ulRxRate;
    uint           ulTxRate;
    BOOL           bIsMLOConnection;
    uint           ulNumLinks;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/WLAN_REALTIME_CONNECTION_QUALITY_LINK_INFO[1] linksInfo;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_phy_radio_state))], [])
struct WLAN_PHY_RADIO_STATE
{
    uint              dwPhyIndex;
    DOT11_RADIO_STATE dot11SoftwareRadioState;
    DOT11_RADIO_STATE dot11HardwareRadioState;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_radio_state))], [])
struct WLAN_RADIO_STATE
{
    uint dwNumberOfPhys;
    WLAN_PHY_RADIO_STATE[64] PhyRadioState;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_interface_capability))], [])
struct WLAN_INTERFACE_CAPABILITY
{
    WLAN_INTERFACE_TYPE interfaceType;
    BOOL                bDot11DSupported;
    uint                dwMaxDesiredSsidListSize;
    uint                dwMaxDesiredBssidListSize;
    uint                dwNumberOfSupportedPhys;
    DOT11_PHY_TYPE[64]  dot11PhyTypes;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_auth_cipher_pair_list))], [])
struct WLAN_AUTH_CIPHER_PAIR_LIST
{
    uint dwNumberOfItems;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DOT11_AUTH_CIPHER_PAIR[1] pAuthCipherPairList;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_country_or_region_string_list))], [])
struct WLAN_COUNTRY_OR_REGION_STRING_LIST
{
    uint dwNumberOfItems;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[3] pCountryOrRegionStringList;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_profile_info_list))], [])
struct WLAN_PROFILE_INFO_LIST
{
    uint dwNumberOfItems;
    uint dwIndex;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/WLAN_PROFILE_INFO[1] ProfileInfo;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_available_network_list))], [])
struct WLAN_AVAILABLE_NETWORK_LIST
{
    uint dwNumberOfItems;
    uint dwIndex;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/WLAN_AVAILABLE_NETWORK[1] Network;
}

struct WLAN_AVAILABLE_NETWORK_LIST_V2
{
    uint dwNumberOfItems;
    uint dwIndex;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/WLAN_AVAILABLE_NETWORK_V2[1] Network;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_interface_info_list))], [])
struct WLAN_INTERFACE_INFO_LIST
{
    uint dwNumberOfItems;
    uint dwIndex;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/WLAN_INTERFACE_INFO[1] InterfaceInfo;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-dot11_network_list))], [])
struct DOT11_NETWORK_LIST
{
    uint dwNumberOfItems;
    uint dwIndex;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DOT11_NETWORK[1] Network;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_connection_parameters))], [])
struct WLAN_CONNECTION_PARAMETERS
{
    WLAN_CONNECTION_MODE wlanConnectionMode;
    const(PWSTR)         strProfile;
    DOT11_SSID*          pDot11Ssid;
    DOT11_BSSID_LIST*    pDesiredBssidList;
    DOT11_BSS_TYPE       dot11BssType;
    uint                 dwFlags;
}

struct WLAN_CONNECTION_PARAMETERS_V2
{
    WLAN_CONNECTION_MODE wlanConnectionMode;
    const(PWSTR)         strProfile;
    DOT11_SSID*          pDot11Ssid;
    ubyte*               pDot11Hessid;
    DOT11_BSSID_LIST*    pDesiredBssidList;
    DOT11_BSS_TYPE       dot11BssType;
    uint                 dwFlags;
    DOT11_ACCESSNETWORKOPTIONS* pDot11AccessNetworkOptions;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_msm_notification_data))], [])
struct WLAN_MSM_NOTIFICATION_DATA
{
    WLAN_CONNECTION_MODE wlanConnectionMode;
    wchar[256]           strProfileName;
    DOT11_SSID           dot11Ssid;
    DOT11_BSS_TYPE       dot11BssType;
    ubyte[6]             dot11MacAddr;
    BOOL                 bSecurityEnabled;
    BOOL                 bFirstPeer;
    BOOL                 bLastPeer;
    uint                 wlanReasonCode;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_connection_notification_data))], [])
struct WLAN_CONNECTION_NOTIFICATION_DATA
{
    WLAN_CONNECTION_MODE wlanConnectionMode;
    wchar[256]           strProfileName;
    DOT11_SSID           dot11Ssid;
    DOT11_BSS_TYPE       dot11BssType;
    BOOL                 bSecurityEnabled;
    uint                 wlanReasonCode;
    WLAN_CONNECTION_NOTIFICATION_FLAGS dwFlags;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/wchar[1] strProfileXml;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_device_service_notification_data))], [])
struct WLAN_DEVICE_SERVICE_NOTIFICATION_DATA
{
    GUID DeviceService;
    uint dwOpCode;
    uint dwDataSize;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] DataBlob;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_phy_frame_statistics))], [])
struct WLAN_PHY_FRAME_STATISTICS
{
    ulong ullTransmittedFrameCount;
    ulong ullMulticastTransmittedFrameCount;
    ulong ullFailedCount;
    ulong ullRetryCount;
    ulong ullMultipleRetryCount;
    ulong ullMaxTXLifetimeExceededCount;
    ulong ullTransmittedFragmentCount;
    ulong ullRTSSuccessCount;
    ulong ullRTSFailureCount;
    ulong ullACKFailureCount;
    ulong ullReceivedFrameCount;
    ulong ullMulticastReceivedFrameCount;
    ulong ullPromiscuousReceivedFrameCount;
    ulong ullMaxRXLifetimeExceededCount;
    ulong ullFrameDuplicateCount;
    ulong ullReceivedFragmentCount;
    ulong ullPromiscuousReceivedFragmentCount;
    ulong ullFCSErrorCount;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_mac_frame_statistics))], [])
struct WLAN_MAC_FRAME_STATISTICS
{
    ulong ullTransmittedFrameCount;
    ulong ullReceivedFrameCount;
    ulong ullWEPExcludedCount;
    ulong ullTKIPLocalMICFailures;
    ulong ullTKIPReplays;
    ulong ullTKIPICVErrorCount;
    ulong ullCCMPReplays;
    ulong ullCCMPDecryptErrors;
    ulong ullWEPUndecryptableCount;
    ulong ullWEPICVErrorCount;
    ulong ullDecryptSuccessCount;
    ulong ullDecryptFailureCount;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_statistics))], [])
struct WLAN_STATISTICS
{
    ulong ullFourWayHandshakeFailures;
    ulong ullTKIPCounterMeasuresInvoked;
    ulong ullReserved;
    WLAN_MAC_FRAME_STATISTICS MacUcastCounters;
    WLAN_MAC_FRAME_STATISTICS MacMcastCounters;
    uint  dwNumberOfPhys;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/WLAN_PHY_FRAME_STATISTICS[1] PhyCounters;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_device_service_guid_list))], [])
struct WLAN_DEVICE_SERVICE_GUID_LIST
{
    uint dwNumberOfItems;
    uint dwIndex;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/GUID[1] DeviceService;
}

struct WFD_GROUP_ID
{
    ubyte[6]   DeviceAddress;
    DOT11_SSID GroupSSID;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_hosted_network_peer_state))], [])
struct WLAN_HOSTED_NETWORK_PEER_STATE
{
    ubyte[6] PeerMacAddress;
    WLAN_HOSTED_NETWORK_PEER_AUTH_STATE PeerAuthState;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_hosted_network_radio_state))], [])
struct WLAN_HOSTED_NETWORK_RADIO_STATE
{
    DOT11_RADIO_STATE dot11SoftwareRadioState;
    DOT11_RADIO_STATE dot11HardwareRadioState;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_hosted_network_state_change))], [])
struct WLAN_HOSTED_NETWORK_STATE_CHANGE
{
    WLAN_HOSTED_NETWORK_STATE OldState;
    WLAN_HOSTED_NETWORK_STATE NewState;
    WLAN_HOSTED_NETWORK_REASON StateChangeReason;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_hosted_network_data_peer_state_change))], [])
struct WLAN_HOSTED_NETWORK_DATA_PEER_STATE_CHANGE
{
    WLAN_HOSTED_NETWORK_PEER_STATE OldState;
    WLAN_HOSTED_NETWORK_PEER_STATE NewState;
    WLAN_HOSTED_NETWORK_REASON PeerStateChangeReason;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_hosted_network_connection_settings))], [])
struct WLAN_HOSTED_NETWORK_CONNECTION_SETTINGS
{
    DOT11_SSID hostedNetworkSSID;
    uint       dwMaxNumberOfPeers;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_hosted_network_security_settings))], [])
struct WLAN_HOSTED_NETWORK_SECURITY_SETTINGS
{
    DOT11_AUTH_ALGORITHM dot11AuthAlgo;
    DOT11_CIPHER_ALGORITHM dot11CipherAlgo;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/ns-wlanapi-wlan_hosted_network_status))], [])
struct WLAN_HOSTED_NETWORK_STATUS
{
    WLAN_HOSTED_NETWORK_STATE HostedNetworkState;
    GUID           IPDeviceID;
    ubyte[6]       wlanHostedNetworkBSSID;
    DOT11_PHY_TYPE dot11PhyType;
    uint           ulChannelFrequency;
    uint           dwNumberOfPeers;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/WLAN_HOSTED_NETWORK_PEER_STATE[1] PeerList;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dot1x/ns-dot1x-onex_variable_blob))], [])
struct ONEX_VARIABLE_BLOB
{
    uint dwSize;
    uint dwOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dot1x/ns-dot1x-onex_auth_params))], [])
struct ONEX_AUTH_PARAMS
{
    BOOL               fUpdatePending;
    ONEX_VARIABLE_BLOB oneXConnProfile;
    ONEX_AUTH_IDENTITY authIdentity;
    uint               dwQuarantineState;
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(fDomain)), FixedArgSig(ElementSig(5)), FixedArgSig(ElementSig(1))], [])*/uint _bitfield60;
    uint               dwSessionId;
    HANDLE             hUserToken;
    ONEX_VARIABLE_BLOB OneXUserProfile;
    ONEX_VARIABLE_BLOB Identity;
    ONEX_VARIABLE_BLOB UserName;
    ONEX_VARIABLE_BLOB Domain;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dot1x/ns-dot1x-onex_eap_error))], [])
struct ONEX_EAP_ERROR
{
    uint               dwWinError;
    EAP_METHOD_TYPE    type;
    uint               dwReasonCode;
    GUID               rootCauseGuid;
    GUID               repairGuid;
    GUID               helpLinkGuid;
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(fRepairString)), FixedArgSig(ElementSig(1)), FixedArgSig(ElementSig(1))], [])*/uint _bitfield61;
    ONEX_VARIABLE_BLOB RootCauseString;
    ONEX_VARIABLE_BLOB RepairString;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dot1x/ns-dot1x-onex_status))], [])
struct ONEX_STATUS
{
    ONEX_AUTH_STATUS authStatus;
    uint             dwReason;
    uint             dwError;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dot1x/ns-dot1x-onex_result_update_data))], [])
struct ONEX_RESULT_UPDATE_DATA
{
    ONEX_STATUS        oneXStatus;
    ONEX_EAP_METHOD_BACKEND_SUPPORT BackendSupport;
    BOOL               fBackendEngaged;
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(fEapError)), FixedArgSig(ElementSig(1)), FixedArgSig(ElementSig(1))], [])*/uint _bitfield62;
    ONEX_VARIABLE_BLOB authParams;
    ONEX_VARIABLE_BLOB eapError;
}

struct ONEX_USER_INFO
{
    ONEX_AUTH_IDENTITY authIdentity;
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(fDomainName)), FixedArgSig(ElementSig(1)), FixedArgSig(ElementSig(1))], [])*/uint _bitfield63;
    ONEX_VARIABLE_BLOB UserName;
    ONEX_VARIABLE_BLOB DomainName;
}

struct DOT11_ADAPTER
{
    GUID  gAdapterId;
    PWSTR pszDescription;
    DOT11_CURRENT_OPERATION_MODE Dot11CurrentOpMode;
}

struct DOT11_BSS_LIST
{
    uint   uNumOfBytes;
    ubyte* pucBuffer;
}

struct DOT11_PORT_STATE
{
    ubyte[6] PeerMacAddress;
    uint     uSessionId;
    BOOL     bPortControlled;
    BOOL     bPortAuthorized;
}

struct DOT11_SECURITY_PACKET_HEADER
{
align (1):
    ubyte[6] PeerMac;
    ushort   usEtherType;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] Data;
}

struct DOT11_MSSECURITY_SETTINGS
{
    DOT11_AUTH_ALGORITHM dot11AuthAlgorithm;
    DOT11_CIPHER_ALGORITHM dot11CipherAlgorithm;
    BOOL                 fOneXEnabled;
    EAP_METHOD_TYPE      eapMethodType;
    uint                 dwEapConnectionDataLen;
    ubyte*               pEapConnectionData;
}

struct DOT11EXT_IHV_SSID_LIST
{
    uint ulCount;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DOT11_SSID[1] SSIDs;
}

struct DOT11EXT_IHV_PROFILE_PARAMS
{
    DOT11EXT_IHV_SSID_LIST* pSsidList;
    DOT11_BSS_TYPE BssType;
    DOT11_MSSECURITY_SETTINGS* pMSSecuritySettings;
}

struct DOT11EXT_IHV_PARAMS
{
    DOT11EXT_IHV_PROFILE_PARAMS dot11ExtIhvProfileParams;
    wchar[256] wstrProfileName;
    uint       dwProfileTypeFlags;
    GUID       interfaceGuid;
}

struct DOT11_IHV_VERSION_INFO
{
    uint dwVerMin;
    uint dwVerMax;
}

struct DOT11EXT_IHV_UI_REQUEST
{
    uint   dwSessionId;
    GUID   guidUIRequest;
    GUID   UIPageClsid;
    uint   dwByteCount;
    ubyte* pvUIRequest;
}

struct DOT11_EAP_RESULT
{
    uint            dwFailureReasonCode;
    EAP_ATTRIBUTES* pAttribArray;
}

struct DOT11_MSONEX_RESULT_PARAMS
{
    ONEX_AUTH_STATUS  Dot11OnexAuthStatus;
    ONEX_REASON_CODE  Dot11OneXReasonCode;
    ubyte*            pbMPPESendKey;
    uint              dwMPPESendKeyLen;
    ubyte*            pbMPPERecvKey;
    uint              dwMPPERecvKeyLen;
    DOT11_EAP_RESULT* pDot11EapResult;
}

struct DOT11EXT_IHV_CONNECTIVITY_PROFILE
{
    PWSTR pszXmlFragmentIhvConnectivity;
}

struct DOT11EXT_IHV_SECURITY_PROFILE
{
    PWSTR pszXmlFragmentIhvSecurity;
    BOOL  bUseMSOnex;
}

struct DOT11EXT_IHV_DISCOVERY_PROFILE
{
    DOT11EXT_IHV_CONNECTIVITY_PROFILE IhvConnectivityProfile;
    DOT11EXT_IHV_SECURITY_PROFILE IhvSecurityProfile;
}

struct DOT11EXT_IHV_DISCOVERY_PROFILE_LIST
{
    uint dwCount;
    DOT11EXT_IHV_DISCOVERY_PROFILE* pIhvDiscoveryProfiles;
}

struct DOT11EXT_VIRTUAL_STATION_AP_PROPERTY
{
    DOT11_SSID           dot11SSID;
    DOT11_AUTH_ALGORITHM dot11AuthAlgo;
    DOT11_CIPHER_ALGORITHM dot11CipherAlgo;
    BOOL                 bIsPassPhrase;
    uint                 dwKeyLength;
    ubyte[64]            ucKeyData;
}

struct WDIAG_IHV_WLAN_ID
{
    wchar[256]     strProfileName;
    DOT11_SSID     Ssid;
    DOT11_BSS_TYPE BssType;
    uint           dwFlags;
    uint           dwReasonCode;
}

struct DOT11EXT_APIS
{
    DOT11EXT_ALLOCATE_BUFFER Dot11ExtAllocateBuffer;
    DOT11EXT_FREE_BUFFER Dot11ExtFreeBuffer;
    DOT11EXT_SET_PROFILE_CUSTOM_USER_DATA Dot11ExtSetProfileCustomUserData;
    DOT11EXT_GET_PROFILE_CUSTOM_USER_DATA Dot11ExtGetProfileCustomUserData;
    DOT11EXT_SET_CURRENT_PROFILE Dot11ExtSetCurrentProfile;
    DOT11EXT_SEND_UI_REQUEST Dot11ExtSendUIRequest;
    DOT11EXT_PRE_ASSOCIATE_COMPLETION Dot11ExtPreAssociateCompletion;
    DOT11EXT_POST_ASSOCIATE_COMPLETION Dot11ExtPostAssociateCompletion;
    DOT11EXT_SEND_NOTIFICATION Dot11ExtSendNotification;
    DOT11EXT_SEND_PACKET Dot11ExtSendPacket;
    DOT11EXT_SET_ETHERTYPE_HANDLING Dot11ExtSetEtherTypeHandling;
    DOT11EXT_SET_AUTH_ALGORITHM Dot11ExtSetAuthAlgorithm;
    DOT11EXT_SET_UNICAST_CIPHER_ALGORITHM Dot11ExtSetUnicastCipherAlgorithm;
    DOT11EXT_SET_MULTICAST_CIPHER_ALGORITHM Dot11ExtSetMulticastCipherAlgorithm;
    DOT11EXT_SET_DEFAULT_KEY Dot11ExtSetDefaultKey;
    DOT11EXT_SET_KEY_MAPPING_KEY Dot11ExtSetKeyMappingKey;
    DOT11EXT_SET_DEFAULT_KEY_ID Dot11ExtSetDefaultKeyId;
    DOT11EXT_NIC_SPECIFIC_EXTENSION Dot11ExtNicSpecificExtension;
    DOT11EXT_SET_EXCLUDE_UNENCRYPTED Dot11ExtSetExcludeUnencrypted;
    DOT11EXT_ONEX_START  Dot11ExtStartOneX;
    DOT11EXT_ONEX_STOP   Dot11ExtStopOneX;
    DOT11EXT_PROCESS_ONEX_PACKET Dot11ExtProcessSecurityPacket;
}

struct DOT11EXT_IHV_HANDLERS
{
    DOT11EXTIHV_DEINIT_SERVICE Dot11ExtIhvDeinitService;
    DOT11EXTIHV_INIT_ADAPTER Dot11ExtIhvInitAdapter;
    DOT11EXTIHV_DEINIT_ADAPTER Dot11ExtIhvDeinitAdapter;
    DOT11EXTIHV_PERFORM_PRE_ASSOCIATE Dot11ExtIhvPerformPreAssociate;
    DOT11EXTIHV_ADAPTER_RESET Dot11ExtIhvAdapterReset;
    DOT11EXTIHV_PERFORM_POST_ASSOCIATE Dot11ExtIhvPerformPostAssociate;
    DOT11EXTIHV_STOP_POST_ASSOCIATE Dot11ExtIhvStopPostAssociate;
    DOT11EXTIHV_VALIDATE_PROFILE Dot11ExtIhvValidateProfile;
    DOT11EXTIHV_PERFORM_CAPABILITY_MATCH Dot11ExtIhvPerformCapabilityMatch;
    DOT11EXTIHV_CREATE_DISCOVERY_PROFILES Dot11ExtIhvCreateDiscoveryProfiles;
    DOT11EXTIHV_PROCESS_SESSION_CHANGE Dot11ExtIhvProcessSessionChange;
    DOT11EXTIHV_RECEIVE_INDICATION Dot11ExtIhvReceiveIndication;
    DOT11EXTIHV_RECEIVE_PACKET Dot11ExtIhvReceivePacket;
    DOT11EXTIHV_SEND_PACKET_COMPLETION Dot11ExtIhvSendPacketCompletion;
    DOT11EXTIHV_IS_UI_REQUEST_PENDING Dot11ExtIhvIsUIRequestPending;
    DOT11EXTIHV_PROCESS_UI_RESPONSE Dot11ExtIhvProcessUIResponse;
    DOT11EXTIHV_QUERY_UI_REQUEST Dot11ExtIhvQueryUIRequest;
    DOT11EXTIHV_ONEX_INDICATE_RESULT Dot11ExtIhvOnexIndicateResult;
    DOT11EXTIHV_CONTROL Dot11ExtIhvControl;
}

struct DOT11EXT_VIRTUAL_STATION_APIS
{
    DOT11EXT_REQUEST_VIRTUAL_STATION Dot11ExtRequestVirtualStation;
    DOT11EXT_RELEASE_VIRTUAL_STATION Dot11ExtReleaseVirtualStation;
    DOT11EXT_QUERY_VIRTUAL_STATION_PROPERTIES Dot11ExtQueryVirtualStationProperties;
    DOT11EXT_SET_VIRTUAL_STATION_AP_PROPERTIES Dot11ExtSetVirtualStationAPProperties;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanOpenHandle(uint dwClientVersion, 
                    /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved, 
                    uint* pdwNegotiatedVersion, 
                    /*PARAM ATTR: RAIIFreeAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WlanCloseHandle))], [])*/HANDLE* phClientHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanCloseHandle(HANDLE hClientHandle, 
                     /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanEnumInterfaces(HANDLE hClientHandle, 
                        /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved, 
                        WLAN_INTERFACE_INFO_LIST** ppInterfaceList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanSetAutoConfigParameter(HANDLE hClientHandle, WLAN_AUTOCONF_OPCODE OpCode, uint dwDataSize, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* pData, 
                                /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanQueryAutoConfigParameter(HANDLE hClientHandle, WLAN_AUTOCONF_OPCODE OpCode, 
                                  /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved, 
                                  uint* pdwDataSize, void** ppData, WLAN_OPCODE_VALUE_TYPE* pWlanOpcodeValueType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanGetInterfaceCapability(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, 
                                /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved, 
                                WLAN_INTERFACE_CAPABILITY** ppCapability);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanSetInterface(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, WLAN_INTF_OPCODE OpCode, uint dwDataSize, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(void)* pData, 
                      /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanQueryInterface(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, WLAN_INTF_OPCODE OpCode, 
                        /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved, 
                        uint* pdwDataSize, void** ppData, WLAN_OPCODE_VALUE_TYPE* pWlanOpcodeValueType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanIhvControl(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, WLAN_IHV_CONTROL_TYPE Type, 
                    uint dwInBufferSize, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pInBuffer, 
                    uint dwOutBufferSize, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pOutBuffer, 
                    uint* pdwBytesReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanScan(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(DOT11_SSID)* pDot11Ssid, 
              const(WLAN_RAW_DATA)* pIeData, 
              /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanGetAvailableNetworkList(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, uint dwFlags, 
                                 /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved, 
                                 WLAN_AVAILABLE_NETWORK_LIST** ppAvailableNetworkList);

@DllImport("wlanapi.dll")
uint WlanGetAvailableNetworkList2(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, uint dwFlags, 
                                  /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved, 
                                  WLAN_AVAILABLE_NETWORK_LIST_V2** ppAvailableNetworkList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanGetNetworkBssList(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(DOT11_SSID)* pDot11Ssid, 
                           DOT11_BSS_TYPE dot11BssType, BOOL bSecurityEnabled, 
                           /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved, 
                           WLAN_BSS_LIST** ppWlanBssList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanConnect(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, 
                 const(WLAN_CONNECTION_PARAMETERS)* pConnectionParameters, 
                 /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved);

@DllImport("wlanapi.dll")
uint WlanConnect2(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, 
                  const(WLAN_CONNECTION_PARAMETERS_V2)* pConnectionParameters, 
                  /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanDisconnect(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, 
                    /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanRegisterNotification(HANDLE hClientHandle, WLAN_NOTIFICATION_SOURCES dwNotifSource, BOOL bIgnoreDuplicate, 
                              WLAN_NOTIFICATION_CALLBACK funcCallback, void* pCallbackContext, 
                              /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved, 
                              uint* pdwPrevNotifSource);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanGetProfile(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(PWSTR) strProfileName, 
                    /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved, 
                    PWSTR* pstrProfileXml, uint* pdwFlags, uint* pdwGrantedAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanSetProfileEapUserData(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(PWSTR) strProfileName, 
                               EAP_METHOD_TYPE eapType, WLAN_SET_EAPHOST_FLAGS dwFlags, uint dwEapUserDataSize, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/const(ubyte)* pbEapUserData, 
                               /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanSetProfileEapXmlUserData(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(PWSTR) strProfileName, 
                                  WLAN_SET_EAPHOST_FLAGS dwFlags, const(PWSTR) strEapXmlUserData, 
                                  /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanSetProfile(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, uint dwFlags, const(PWSTR) strProfileXml, 
                    const(PWSTR) strAllUserProfileSecurity, BOOL bOverwrite, 
                    /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved, 
                    uint* pdwReasonCode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanDeleteProfile(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(PWSTR) strProfileName, 
                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanRenameProfile(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(PWSTR) strOldProfileName, 
                       const(PWSTR) strNewProfileName, 
                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanGetProfileList(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, 
                        /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved, 
                        WLAN_PROFILE_INFO_LIST** ppProfileList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanSetProfileList(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, uint dwItems, 
                        const(PWSTR)* strProfileNames, 
                        /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanSetProfilePosition(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(PWSTR) strProfileName, 
                            uint dwPosition, 
                            /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanSetProfileCustomUserData(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(PWSTR) strProfileName, 
                                  uint dwDataSize, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(ubyte)* pData, 
                                  /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanGetProfileCustomUserData(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(PWSTR) strProfileName, 
                                  /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved, 
                                  uint* pdwDataSize, ubyte** ppData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanSetFilterList(HANDLE hClientHandle, WLAN_FILTER_LIST_TYPE wlanFilterListType, 
                       const(DOT11_NETWORK_LIST)* pNetworkList, 
                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanGetFilterList(HANDLE hClientHandle, WLAN_FILTER_LIST_TYPE wlanFilterListType, 
                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved, 
                       DOT11_NETWORK_LIST** ppNetworkList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanSetPsdIEDataList(HANDLE hClientHandle, const(PWSTR) strFormat, const(WLAN_RAW_DATA_LIST)* pPsdIEDataList, 
                          /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanSaveTemporaryProfile(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, const(PWSTR) strProfileName, 
                              const(PWSTR) strAllUserProfileSecurity, uint dwFlags, BOOL bOverWrite, 
                              /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/nf-wlanapi-wlandeviceservicecommand))], [])
@DllImport("wlanapi.dll")
uint WlanDeviceServiceCommand(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, GUID* pDeviceServiceGuid, 
                              uint dwOpCode, uint dwInBufferSize, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pInBuffer, 
                              uint dwOutBufferSize, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* pOutBuffer, 
                              uint* pdwBytesReturned);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/nf-wlanapi-wlangetsupporteddeviceservices))], [])
@DllImport("wlanapi.dll")
uint WlanGetSupportedDeviceServices(HANDLE hClientHandle, const(GUID)* pInterfaceGuid, 
                                    WLAN_DEVICE_SERVICE_GUID_LIST** ppDevSvcGuidList);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wlanapi/nf-wlanapi-wlanregisterdeviceservicenotification))], [])
@DllImport("wlanapi.dll")
uint WlanRegisterDeviceServiceNotification(HANDLE hClientHandle, 
                                           const(WLAN_DEVICE_SERVICE_GUID_LIST)* pDevSvcGuidList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanExtractPsdIEDataList(HANDLE hClientHandle, uint dwIeDataSize, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(ubyte)* pRawIeData, 
                              const(PWSTR) strFormat, 
                              /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved, 
                              WLAN_RAW_DATA_LIST** ppPsdIEDataList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanReasonCodeToString(uint dwReasonCode, uint dwBufferSize, 
                            /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR pStringBuffer, 
                            /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
void* WlanAllocateMemory(uint dwMemorySize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
void WlanFreeMemory(void* pMemory);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanSetSecuritySettings(HANDLE hClientHandle, WLAN_SECURABLE_OBJECT SecurableObject, 
                             const(PWSTR) strModifiedSDDL);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanapi.dll")
uint WlanGetSecuritySettings(HANDLE hClientHandle, WLAN_SECURABLE_OBJECT SecurableObject, 
                             WLAN_OPCODE_VALUE_TYPE* pValueType, PWSTR* pstrCurrentSDDL, uint* pdwGrantedAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("wlanui.dll")
uint WlanUIEditProfile(uint dwClientVersion, const(PWSTR) wstrProfileName, GUID* pInterfaceGuid, HWND hWnd, 
                       WL_DISPLAY_PAGES wlStartPage, 
                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved, 
                       uint* pWlanReasonCode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("wlanapi.dll")
uint WlanHostedNetworkStartUsing(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_REASON* pFailReason, 
                                 /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("wlanapi.dll")
uint WlanHostedNetworkStopUsing(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_REASON* pFailReason, 
                                /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("wlanapi.dll")
uint WlanHostedNetworkForceStart(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_REASON* pFailReason, 
                                 /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("wlanapi.dll")
uint WlanHostedNetworkForceStop(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_REASON* pFailReason, 
                                /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("wlanapi.dll")
uint WlanHostedNetworkQueryProperty(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_OPCODE OpCode, uint* pdwDataSize, 
                                    void** ppvData, WLAN_OPCODE_VALUE_TYPE* pWlanOpcodeValueType, 
                                    /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("wlanapi.dll")
uint WlanHostedNetworkSetProperty(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_OPCODE OpCode, uint dwDataSize, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pvData, 
                                  WLAN_HOSTED_NETWORK_REASON* pFailReason, 
                                  /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("wlanapi.dll")
uint WlanHostedNetworkInitSettings(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_REASON* pFailReason, 
                                   /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("wlanapi.dll")
uint WlanHostedNetworkRefreshSecuritySettings(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_REASON* pFailReason, 
                                              /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("wlanapi.dll")
uint WlanHostedNetworkQueryStatus(HANDLE hClientHandle, WLAN_HOSTED_NETWORK_STATUS** ppWlanHostedNetworkStatus, 
                                  /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("wlanapi.dll")
uint WlanHostedNetworkSetSecondaryKey(HANDLE hClientHandle, uint dwKeyLength, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* pucKeyData, 
                                      BOOL bIsPassPhrase, BOOL bPersistent, WLAN_HOSTED_NETWORK_REASON* pFailReason, 
                                      /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("wlanapi.dll")
uint WlanHostedNetworkQuerySecondaryKey(HANDLE hClientHandle, uint* pdwKeyLength, ubyte** ppucKeyData, 
                                        BOOL* pbIsPassPhrase, BOOL* pbPersistent, 
                                        WLAN_HOSTED_NETWORK_REASON* pFailReason, 
                                        /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("wlanapi.dll")
uint WlanRegisterVirtualStationNotification(HANDLE hClientHandle, BOOL bRegister, 
                                            /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("wlanapi.dll")
uint WFDOpenHandle(uint dwClientVersion, uint* pdwNegotiatedVersion, HANDLE* phClientHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("wlanapi.dll")
uint WFDCloseHandle(HANDLE hClientHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("wlanapi.dll")
uint WFDStartOpenSession(HANDLE hClientHandle, ubyte** pDeviceAddress, void* pvContext, 
                         WFD_OPEN_SESSION_COMPLETE_CALLBACK pfnCallback, HANDLE* phSessionHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("wlanapi.dll")
uint WFDCancelOpenSession(HANDLE hSessionHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("wlanapi.dll")
uint WFDOpenLegacySession(HANDLE hClientHandle, ubyte** pLegacyMacAddress, HANDLE* phSessionHandle, 
                          GUID* pGuidSessionInterface);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("wlanapi.dll")
uint WFDCloseSession(HANDLE hSessionHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("wlanapi.dll")
uint WFDUpdateDeviceVisibility(ubyte** pDeviceAddress);


// Interfaces

@GUID("dd06a84f-83bd-4d01-8ab9-2389fea0869e")
struct Dot11AdHocManager;

@GUID("8f10cc26-cf0d-42a0-acbe-e2de7007384d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nn-adhoc-idot11adhocmanager))], [])
interface IDot11AdHocManager : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocmanager-createnetwork))], [])
    HRESULT CreateNetwork(const(PWSTR) Name, const(PWSTR) Password, int GeographicalId, 
                          IDot11AdHocInterface pInterface, IDot11AdHocSecuritySettings pSecurity, GUID* pContextGuid, 
                          IDot11AdHocNetwork* pIAdHoc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocmanager-commitcreatednetwork))], [])
    HRESULT CommitCreatedNetwork(IDot11AdHocNetwork pIAdHoc, BOOLEAN fSaveProfile, 
                                 BOOLEAN fMakeSavedProfileUserSpecific);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocmanager-getienumdot11adhocnetworks))], [])
    HRESULT GetIEnumDot11AdHocNetworks(GUID* pContextGuid, IEnumDot11AdHocNetworks* ppEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocmanager-getienumdot11adhocinterfaces))], [])
    HRESULT GetIEnumDot11AdHocInterfaces(IEnumDot11AdHocInterfaces* ppEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocmanager-getnetwork))], [])
    HRESULT GetNetwork(GUID* NetworkSignature, IDot11AdHocNetwork* pNetwork);
}

@GUID("8f10cc27-cf0d-42a0-acbe-e2de7007384d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nn-adhoc-idot11adhocmanagernotificationsink))], [])
interface IDot11AdHocManagerNotificationSink : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocmanagernotificationsink-onnetworkadd))], [])
    HRESULT OnNetworkAdd(IDot11AdHocNetwork pIAdHocNetwork);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocmanagernotificationsink-onnetworkremove))], [])
    HRESULT OnNetworkRemove(GUID* Signature);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocmanagernotificationsink-oninterfaceadd))], [])
    HRESULT OnInterfaceAdd(IDot11AdHocInterface pIAdHocInterface);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocmanagernotificationsink-oninterfaceremove))], [])
    HRESULT OnInterfaceRemove(GUID* Signature);
}

@GUID("8f10cc28-cf0d-42a0-acbe-e2de7007384d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nn-adhoc-ienumdot11adhocnetworks))], [])
interface IEnumDot11AdHocNetworks : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-ienumdot11adhocnetworks-next))], [])
    HRESULT Next(uint cElt, IDot11AdHocNetwork* rgElt, uint* pcEltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-ienumdot11adhocnetworks-skip))], [])
    HRESULT Skip(uint cElt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-ienumdot11adhocnetworks-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-ienumdot11adhocnetworks-clone))], [])
    HRESULT Clone(IEnumDot11AdHocNetworks* ppEnum);
}

@GUID("8f10cc29-cf0d-42a0-acbe-e2de7007384d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nn-adhoc-idot11adhocnetwork))], [])
interface IDot11AdHocNetwork : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocnetwork-getstatus))], [])
    HRESULT GetStatus(DOT11_ADHOC_NETWORK_CONNECTION_STATUS* eStatus);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocnetwork-getssid))], [])
    HRESULT GetSSID(PWSTR* ppszwSSID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocnetwork-hasprofile))], [])
    HRESULT HasProfile(ubyte* pf11d);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocnetwork-getprofilename))], [])
    HRESULT GetProfileName(PWSTR* ppszwProfileName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocnetwork-deleteprofile))], [])
    HRESULT DeleteProfile();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocnetwork-getsignalquality))], [])
    HRESULT GetSignalQuality(uint* puStrengthValue, uint* puStrengthMax);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocnetwork-getsecuritysetting))], [])
    HRESULT GetSecuritySetting(IDot11AdHocSecuritySettings* pAdHocSecuritySetting);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocnetwork-getcontextguid))], [])
    HRESULT GetContextGuid(GUID* pContextGuid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocnetwork-getsignature))], [])
    HRESULT GetSignature(GUID* pSignature);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocnetwork-getinterface))], [])
    HRESULT GetInterface(IDot11AdHocInterface* pAdHocInterface);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocnetwork-connect))], [])
    HRESULT Connect(const(PWSTR) Passphrase, int GeographicalId, BOOLEAN fSaveProfile, 
                    BOOLEAN fMakeSavedProfileUserSpecific);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocnetwork-disconnect))], [])
    HRESULT Disconnect();
}

@GUID("8f10cc2a-cf0d-42a0-acbe-e2de7007384d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nn-adhoc-idot11adhocnetworknotificationsink))], [])
interface IDot11AdHocNetworkNotificationSink : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocnetworknotificationsink-onstatuschange))], [])
    HRESULT OnStatusChange(DOT11_ADHOC_NETWORK_CONNECTION_STATUS eStatus);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocnetworknotificationsink-onconnectfail))], [])
    HRESULT OnConnectFail(DOT11_ADHOC_CONNECT_FAIL_REASON eFailReason);
}

@GUID("8f10cc2b-cf0d-42a0-acbe-e2de7007384d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nn-adhoc-idot11adhocinterface))], [])
interface IDot11AdHocInterface : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocinterface-getdevicesignature))], [])
    HRESULT GetDeviceSignature(GUID* pSignature);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocinterface-getfriendlyname))], [])
    HRESULT GetFriendlyName(PWSTR* ppszName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocinterface-isdot11d))], [])
    HRESULT IsDot11d(ubyte* pf11d);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocinterface-isadhoccapable))], [])
    HRESULT IsAdHocCapable(ubyte* pfAdHocCapable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocinterface-isradioon))], [])
    HRESULT IsRadioOn(ubyte* pfIsRadioOn);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocinterface-getactivenetwork))], [])
    HRESULT GetActiveNetwork(IDot11AdHocNetwork* ppNetwork);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocinterface-getienumsecuritysettings))], [])
    HRESULT GetIEnumSecuritySettings(IEnumDot11AdHocSecuritySettings* ppEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocinterface-getienumdot11adhocnetworks))], [])
    HRESULT GetIEnumDot11AdHocNetworks(GUID* pFilterGuid, IEnumDot11AdHocNetworks* ppEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocinterface-getstatus))], [])
    HRESULT GetStatus(DOT11_ADHOC_NETWORK_CONNECTION_STATUS* pState);
}

@GUID("8f10cc2c-cf0d-42a0-acbe-e2de7007384d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nn-adhoc-ienumdot11adhocinterfaces))], [])
interface IEnumDot11AdHocInterfaces : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-ienumdot11adhocinterfaces-next))], [])
    HRESULT Next(uint cElt, IDot11AdHocInterface* rgElt, uint* pcEltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-ienumdot11adhocinterfaces-skip))], [])
    HRESULT Skip(uint cElt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-ienumdot11adhocinterfaces-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-ienumdot11adhocinterfaces-clone))], [])
    HRESULT Clone(IEnumDot11AdHocInterfaces* ppEnum);
}

@GUID("8f10cc2d-cf0d-42a0-acbe-e2de7007384d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nn-adhoc-ienumdot11adhocsecuritysettings))], [])
interface IEnumDot11AdHocSecuritySettings : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-ienumdot11adhocsecuritysettings-next))], [])
    HRESULT Next(uint cElt, IDot11AdHocSecuritySettings* rgElt, uint* pcEltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-ienumdot11adhocsecuritysettings-skip))], [])
    HRESULT Skip(uint cElt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-ienumdot11adhocsecuritysettings-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-ienumdot11adhocsecuritysettings-clone))], [])
    HRESULT Clone(IEnumDot11AdHocSecuritySettings* ppEnum);
}

@GUID("8f10cc2e-cf0d-42a0-acbe-e2de7007384d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nn-adhoc-idot11adhocsecuritysettings))], [])
interface IDot11AdHocSecuritySettings : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocsecuritysettings-getdot11authalgorithm))], [])
    HRESULT GetDot11AuthAlgorithm(DOT11_ADHOC_AUTH_ALGORITHM* pAuth);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocsecuritysettings-getdot11cipheralgorithm))], [])
    HRESULT GetDot11CipherAlgorithm(DOT11_ADHOC_CIPHER_ALGORITHM* pCipher);
}

@GUID("8f10cc2f-cf0d-42a0-acbe-e2de7007384d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nn-adhoc-idot11adhocinterfacenotificationsink))], [])
interface IDot11AdHocInterfaceNotificationSink : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/adhoc/nf-adhoc-idot11adhocinterfacenotificationsink-onconnectionstatuschange))], [])
    HRESULT OnConnectionStatusChange(DOT11_ADHOC_NETWORK_CONNECTION_STATUS eStatus);
}


// GUIDs

const GUID CLSID_Dot11AdHocManager = GUIDOF!Dot11AdHocManager;

const GUID IID_IDot11AdHocInterface                 = GUIDOF!IDot11AdHocInterface;
const GUID IID_IDot11AdHocInterfaceNotificationSink = GUIDOF!IDot11AdHocInterfaceNotificationSink;
const GUID IID_IDot11AdHocManager                   = GUIDOF!IDot11AdHocManager;
const GUID IID_IDot11AdHocManagerNotificationSink   = GUIDOF!IDot11AdHocManagerNotificationSink;
const GUID IID_IDot11AdHocNetwork                   = GUIDOF!IDot11AdHocNetwork;
const GUID IID_IDot11AdHocNetworkNotificationSink   = GUIDOF!IDot11AdHocNetworkNotificationSink;
const GUID IID_IDot11AdHocSecuritySettings          = GUIDOF!IDot11AdHocSecuritySettings;
const GUID IID_IEnumDot11AdHocInterfaces            = GUIDOF!IEnumDot11AdHocInterfaces;
const GUID IID_IEnumDot11AdHocNetworks              = GUIDOF!IEnumDot11AdHocNetworks;
const GUID IID_IEnumDot11AdHocSecuritySettings      = GUIDOF!IEnumDot11AdHocSecuritySettings;
