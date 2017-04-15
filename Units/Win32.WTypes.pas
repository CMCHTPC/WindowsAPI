unit Win32.WTypes;

{$mode delphi}

interface

uses
    Windows, Classes, SysUtils;

type

    TPROPERTYKEY = record
        fmtid: TGUID;
        pid: DWORD;
    end;
    PPROPERTYKEY = ^TPROPERTYKEY;

    PWSTR = PWCHAR; // ???
    BSTR = PWCHAR; // ???

    TFMTID = TGUID;

    PCGUID  = ^TGUID;

implementation

end.

