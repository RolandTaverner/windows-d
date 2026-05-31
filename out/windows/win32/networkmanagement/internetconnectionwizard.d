// Written in the D programming language.

module windows.win32.networkmanagement.internetconnectionwizard;

public import windows.core;
public import windows.win32.foundation : PSTR;

extern(Windows) @nogc nothrow:


// Constants


enum /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)* ICW_REGPATHSETTINGS = "Software\\Microsoft\\Internet Connection Wizard";
enum /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)* ICW_REGKEYCOMPLETED = "Completed";

enum : uint
{
    ICW_MAX_ACCTNAME   = 0x00000100,
    ICW_MAX_PASSWORD   = 0x00000100,
    ICW_MAX_LOGONNAME  = 0x00000100,
    ICW_MAX_SERVERNAME = 0x00000040,
    ICW_MAX_RASNAME    = 0x00000100,
    ICW_MAX_EMAILNAME  = 0x00000040,
    ICW_MAX_EMAILADDR  = 0x00000080,
}

enum uint ICW_CHECKSTATUS = 0x00000001;

enum : uint
{
    ICW_LAUNCHFULL   = 0x00000100,
    ICW_LAUNCHMANUAL = 0x00000200,
}

enum uint ICW_USE_SHELLNEXT = 0x00000400;

enum : uint
{
    ICW_FULL_SMARTSTART = 0x00000800,
    ICW_FULLPRESENT     = 0x00000001,
}

enum uint ICW_MANUALPRESENT = 0x00000002;
enum uint ICW_ALREADYRUN = 0x00000004;

enum : uint
{
    ICW_LAUNCHEDFULL   = 0x00000100,
    ICW_LAUNCHEDMANUAL = 0x00000200,
}

enum uint ICW_USEDEFAULTS = 0x00000001;

// Callbacks

alias PFNCHECKCONNECTIONWIZARD = uint function(uint param0, uint* param1);
alias PFNSETSHELLNEXT = uint function(PSTR param0);

