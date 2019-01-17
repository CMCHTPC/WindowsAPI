unit Win32.WTypesBase;

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}

interface

uses
    Windows, Classes, SysUtils,
    Win32.RPCNDR;

type

   {$IF  0}
    // byte  = BYTE;
    // unsigned short WORD ;
    // unsigned int UINT;
    // int INT;
    // long BOOL;
    // long LONG;
    // unsigned long DWORD;
    HANDLE = pointer;
    PWORD = ^word;
    PDWORD = ^DWORD;
    // char CHAR;
    PSTR = ^char;
    PCSTR = ^char;
    // wchar_t WCHAR;
    TCHAR = WCHAR;
    PWSTR = ^WCHAR;
    PTSTR = ^TCHAR;
    PCWSTR = ^WCHAR;
    PCTSTR = ^TCHAR;
    PHANDLE = ^HANDLE;
{$ENDIF}// 0



{$IF  defined(_WIN32) AND  NOT defined(OLE2ANSI)}
    OLECHAR = WCHAR;
    POLESTR = ^OLECHAR;
    PCOLESTR = ^OLECHAR;
{$ELSE}
    OLECHAR = char;
    POLESTR = PSTR;
    PCOLESTR = PCSTR;
{$ENDIF}




{$IFNDEF  _WINDEF_}
{$IFNDEF  _MINWINDEF_}
    PVOID = pointer;
{$ENDIF}//_MINWINDEF_
{$ENDIF}//_WINDEF_

type
    __int64 = int64;
    ULONG = DWORD;
    DWORDLONG = __int64;
    PDWORDLONG = ^DWORDLONG;
    LONGLONG = __int64;
    ULONGLONG = UINT64;
    PLONGLONG = ^LONGLONG;
    PULONGLONG = ^ULONGLONG;

{$IF  0}
    TLARGE_INTEGER = record
        QuadPart: LONGLONG;
    end;
    PLARGE_INTEGER = ^TLARGE_INTEGER;

    TULARGE_INTEGER = record
        QuadPart: ULONGLONG;
    end;

{$ENDIF}// 0

    TFILETIME = record
        dwLowDateTime: DWORD;
        dwHighDateTime: DWORD;
    end;

    PFILETIME = ^TFILETIME;


    TSYSTEMTIME = record
        wYear: word;
        wMonth: word;
        wDayOfWeek: word;
        wDay: word;
        wHour: word;
        wMinute: word;
        wSecond: word;
        wMilliseconds: word;
    end;

    PSYSTEMTIME = ^TSYSTEMTIME;


    TSECURITY_ATTRIBUTES = record
        nLength: DWORD;
        lpSecurityDescriptor: Pointer;
        bInheritHandle: longbool;
    end;
    PSECURITY_ATTRIBUTES = ^TSECURITY_ATTRIBUTES;


    TSECURITY_DESCRIPTOR_CONTROL = USHORT;
    PSECURITY_DESCRIPTOR_CONTROL = ^TSECURITY_DESCRIPTOR_CONTROL;
 //   PSID = pointer;

    TACL = record
        AclRevision: UCHAR;
        Sbz1: UCHAR;
        AclSize: USHORT;
        AceCount: USHORT;
        Sbz2: USHORT;
    end;

    PACL = ^TACL;


    TSECURITY_DESCRIPTOR = record
        Revision: UCHAR;
        Sbz1: UCHAR;
        Control: TSECURITY_DESCRIPTOR_CONTROL;
        Owner: PSID;
        Group: PSID;
        Sacl: PACL;
        Dacl: PACL;
    end;

    PISECURITY_DESCRIPTOR = ^TSECURITY_DESCRIPTOR;



    TCOAUTHIDENTITY = record
        User: PUSHORT;
        UserLength: ULONG;
        Domain: PUSHORT;
        DomainLength: ULONG;
        Password: PUSHORT;
        PasswordLength: ULONG;
        Flags: ULONG;
    end;

    PCOAUTHIDENTITY = ^TCOAUTHIDENTITY;

    TCOAUTHINFO = record
        dwAuthnSvc: DWORD;
        dwAuthzSvc: DWORD;
        pwszServerPrincName: LPWSTR;
        dwAuthnLevel: DWORD;
        dwImpersonationLevel: DWORD;
        pAuthIdentityData: PCOAUTHIDENTITY;
        dwCapabilities: DWORD;
    end;

    PCOAUTHINFO = ^TCOAUTHINFO;

    TSCODE = LONG;
    PSCODE = ^TSCODE;



type
    HRESULT = LONG;

    TOBJECTID = record
        Lineage: TGUID;
        Uniquifier: ULONG;
    end;


{$IF  0}
    TREFGUID = ^TGUID;
    TREFIID = ^TIID;
    TREFCLSID = ^TCLSID;
{$ENDIF}// 0

    TMEMCTX = (
        MEMCTX_TASK = 1,
        MEMCTX_SHARED = 2,
        MEMCTX_MACSYSTEM = 3,
        MEMCTX_UNKNOWN = -1,
        MEMCTX_SAME = -2
        );


const
    ROTREGFLAGS_ALLOWANYCLIENT = $1;

    APPIDREGFLAGS_ACTIVATE_IUSERVER_INDESKTOP = $1;
    APPIDREGFLAGS_SECURE_SERVER_PROCESS_SD_AND_BIND = $2;
    APPIDREGFLAGS_ISSUE_ACTIVATION_RPC_AT_IDENTIFY = $4;
    APPIDREGFLAGS_IUSERVER_UNMODIFIED_LOGON_TOKEN = $8;
    APPIDREGFLAGS_IUSERVER_SELF_SID_IN_LAUNCH_PERMISSION = $10;
    APPIDREGFLAGS_IUSERVER_ACTIVATE_IN_CLIENT_SESSION_ONLY = $20;
    APPIDREGFLAGS_RESERVED1 = $40;
    APPIDREGFLAGS_RESERVED2 = $80;
    APPIDREGFLAGS_RESERVED3 = $100;
    APPIDREGFLAGS_RESERVED4 = $200;
    APPIDREGFLAGS_RESERVED5 = $400;
    APPIDREGFLAGS_RESERVED6 = $800;

    DCOMSCM_ACTIVATION_USE_ALL_AUTHNSERVICES = $1;
    DCOMSCM_ACTIVATION_DISALLOW_UNSECURE_CALL = $2;
    DCOMSCM_RESOLVE_USE_ALL_AUTHNSERVICES = $4;
    DCOMSCM_RESOLVE_DISALLOW_UNSECURE_CALL = $8;
    DCOMSCM_PING_USE_MID_AUTHNSERVICE = $10;
    DCOMSCM_PING_DISALLOW_UNSECURE_CALL = $20;

type
    TCLSCTX = (
        CLSCTX_INPROC_SERVER = $1,
        CLSCTX_INPROC_HANDLER = $2,
        CLSCTX_LOCAL_SERVER = $4,
        CLSCTX_INPROC_SERVER16 = $8,
        CLSCTX_REMOTE_SERVER = $10,
        CLSCTX_INPROC_HANDLER16 = $20,
        CLSCTX_RESERVED1 = $40,
        CLSCTX_RESERVED2 = $80,
        CLSCTX_RESERVED3 = $100,
        CLSCTX_RESERVED4 = $200,
        CLSCTX_NO_CODE_DOWNLOAD = $400,
        CLSCTX_RESERVED5 = $800,
        CLSCTX_NO_CUSTOM_MARSHAL = $1000,
        CLSCTX_ENABLE_CODE_DOWNLOAD = $2000,
        CLSCTX_NO_FAILURE_LOG = $4000,
        CLSCTX_DISABLE_AAA = $8000,
        CLSCTX_ENABLE_AAA = $10000,
        CLSCTX_FROM_DEFAULT_CONTEXT = $20000,
        CLSCTX_ACTIVATE_32_BIT_SERVER = $40000,
        CLSCTX_ACTIVATE_64_BIT_SERVER = $80000,
        CLSCTX_ENABLE_CLOAKING = $100000,
        CLSCTX_APPCONTAINER = $400000,
        CLSCTX_ACTIVATE_AAA_AS_IU = $800000,
        CLSCTX_PS_DLL = int32($80000000)
        );

const
    CLSCTX_VALID_MASK =
        (ord(CLSCTX_INPROC_SERVER) or ord(CLSCTX_INPROC_HANDLER) or ord(CLSCTX_LOCAL_SERVER) or ord(CLSCTX_INPROC_SERVER16) or
        ord(CLSCTX_REMOTE_SERVER) or ord(CLSCTX_NO_CODE_DOWNLOAD) or ord(CLSCTX_NO_CUSTOM_MARSHAL) or ord(CLSCTX_ENABLE_CODE_DOWNLOAD) or
        ord(CLSCTX_NO_FAILURE_LOG) or ord(CLSCTX_DISABLE_AAA) or ord(CLSCTX_ENABLE_AAA) or ord(CLSCTX_FROM_DEFAULT_CONTEXT) or
        ord(CLSCTX_ACTIVATE_32_BIT_SERVER) or ord(CLSCTX_ACTIVATE_64_BIT_SERVER) or ord(CLSCTX_ENABLE_CLOAKING) or ord(CLSCTX_APPCONTAINER) or
        ord(CLSCTX_ACTIVATE_AAA_AS_IU) or ord(CLSCTX_PS_DLL));

type
    TMSHLFLAGS = (
        MSHLFLAGS_NORMAL = 0,
        MSHLFLAGS_TABLESTRONG = 1,
        MSHLFLAGS_TABLEWEAK = 2,
        MSHLFLAGS_NOPING = 4,
        MSHLFLAGS_RESERVED1 = 8,
        MSHLFLAGS_RESERVED2 = 16,
        MSHLFLAGS_RESERVED3 = 32,
        MSHLFLAGS_RESERVED4 = 64
        );

    TMSHCTX = (
        MSHCTX_LOCAL = 0,
        MSHCTX_NOSHAREDMEM = 1,
        MSHCTX_DIFFERENTMACHINE = 2,
        MSHCTX_INPROC = 3,
        MSHCTX_CROSSCTX = 4
        );

    TBYTE_BLOB = record
        clSize: ULONG;
        abData: Pbyte;
    end;
    UP_BYTE_BLOB = ^TBYTE_BLOB;
    PBYTE_BLOB = ^TBYTE_BLOB;



    TWORD_BLOB = record
        clSize: ULONG;
        asData: PUSHORT;
    end;
    UP_WORD_BLOB = ^TWORD_BLOB;


    TDWORD_BLOB = record
        clSize: ULONG;
        alData: PULONG;
    end;
    UP_DWORD_BLOB = ^TDWORD_BLOB;
    PDWORD_BLOB = ^TDWORD_BLOB;


    TFLAGGED_BYTE_BLOB = record
        fFlags: ULONG;
        clSize: ULONG;
        abData: PByte;
    end;

    UP_FLAGGED_BYTE_BLOB = ^TFLAGGED_BYTE_BLOB;
    PFLAGGED_BYTE_BLOB = ^TFLAGGED_BYTE_BLOB;



    TFLAGGED_WORD_BLOB = record
        fFlags: ULONG;
        clSize: ULONG;
        asData: PUSHORT;
    end;

    UP_FLAGGED_WORD_BLOB = ^TFLAGGED_WORD_BLOB;


    TBYTE_SIZEDARR = record
        clSize: ULONG;
        pData: Pbyte;
    end;

    TSHORT_SIZEDARR = record
        clSize: ULONG;
        pData: PUSHORT;
    end;
    TWORD_SIZEDARR = TSHORT_SIZEDARR;

    TLONG_SIZEDARR = record
        clSize: ULONG;
        pData: PULONG;
    end;
    TDWORD_SIZEDARR = TLONG_SIZEDARR;

    THYPER_SIZEDARR = record
        clSize: ULONG;
        pData: Phyper;
    end;



    TBLOB = record
        cbSize: ULONG;
        pBlobData: PBYTE;
    end;
    PBLOB = ^TBLOB;


    TSID_IDENTIFIER_AUTHORITY = record
        Value: array [0..5] of UCHAR;
    end;

    PSID_IDENTIFIER_AUTHORITY = ^TSID_IDENTIFIER_AUTHORITY;


    TSID = record
        Revision: byte;
        SubAuthorityCount: byte;
        IdentifierAuthority: TSID_IDENTIFIER_AUTHORITY;
        SubAuthority: PULONG;
    end;

    PSID = ^TSID;


    TSID_AND_ATTRIBUTES = record
        Sid: PSID;
        Attributes: DWORD;
    end;
    PSID_AND_ATTRIBUTES = ^TSID_AND_ATTRIBUTES;




    { old }
(*
    PChar = ^char;
    pWChar = ^WChar;
    LPSTR = ^char;
    LPWSTR = ^WChar;

    PSID = pointer;

    PWSTR = ^WChar;

    Pwchar_t = PWchar;  // ???

    PDWORD_BLOB = PByte; // ???
    PFLAGGED_BYTE_BLOB = PByte; // ???

    __int64 = int64;         // ???

    PBYTE_BLOB = PByte;     // ???

    FLAGGED_WORD_BLOB = byte;

    OLECHAR = char;
    POLESTR = PChar;   *)

implementation

end.

