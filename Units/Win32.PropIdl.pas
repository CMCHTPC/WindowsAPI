unit Win32.PropIdl;

{$mode delphi}

interface

uses
    Classes, SysUtils, Windows, ActiveX;

{
type
    TPROPVARIANT = packed record

    end;
    PPROPVARIANT = ^TPROPVARIANT; }

function PropVariantClear(var pvar: TPROPVARIANT): HResult; stdcall; external 'Ole32.dll';

procedure PropVariantInit(var pvar: TPROPVARIANT); inline;

implementation



procedure PropVariantInit(var pvar: TPROPVARIANT); inline;
begin
    ZeroMemory(@pvar, sizeOf(TPROPVARIANT));
end;

end.
