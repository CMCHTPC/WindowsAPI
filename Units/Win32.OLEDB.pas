unit Win32.OleDB;

{$mode delphi}

interface

uses
    Windows, Classes, SysUtils;

type
    TINHERITED_FROMA = record
        GenerationGap: LONG;
        AncestorName: LPSTR;
    end;


    PINHERITED_FROMA = ^TINHERITED_FROMA;

    TINHERITED_FROMW = record
        GenerationGap: LONG;
        AncestorName: LPWSTR;
    end;

    PINHERITED_FROMW = ^TINHERITED_FROMW;

implementation

end.


