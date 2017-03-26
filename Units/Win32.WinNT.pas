unit Win32.WinNT;

{$mode delphi}

interface

uses
    Classes, SysUtils;

type
    TOBJECT_TYPE_LIST = record
        Level: word;
        Sbz: word;
        ObjectType: PGUID;
    end;
    POBJECT_TYPE_LIST = ^TOBJECT_TYPE_LIST;

implementation

end.

