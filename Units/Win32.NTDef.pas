unit Win32.NTDef;

{$mode delphiunicode}{$H+}

interface

uses
    Windows, Classes, SysUtils;

type
    PZZWSTR = PWideChar;
    PCZZWSTR = PWideChar;

    PCZZSTR = PAnsiChar;


    PHICON = ^HICON;

    // sind woanders definiert, aber momentan zur vereinfachung

    PWSTR = ^WCHAR;

    TSECURITY_ATTRIBUTES = record
     nLength:DWORD;
     lpSecurityDescriptor:Pointer;
     bInheritHandle:BOOLean;
    end;

PSECURITY_ATTRIBUTES = ^TSECURITY_ATTRIBUTES;

implementation

end.

