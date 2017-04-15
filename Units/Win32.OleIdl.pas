unit Win32.OleIdl;

{$mode delphi}

interface

uses
    Windows, Classes, SysUtils;

const
    MK_ALT = $20;

    DROPEFFECT_NONE = 0;

    DROPEFFECT_COPY = 1;

    DROPEFFECT_MOVE = 2;

    DROPEFFECT_LINK = 4;

    DROPEFFECT_SCROLL = $80000000;

type
    IOleWindow = interface(IUnknown)
        ['{00000114-0000-0000-C000-000000000046}']
    end;

    TOleMenuGroupWidths = record
        Width: array [0.. 5] of LONG;
    end;
    POLEMENUGROUPWIDTHS = ^TOleMenuGroupWidths;

    HOLEMENU = HGLOBAL;

implementation

end.

