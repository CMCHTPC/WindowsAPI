unit Win32.AudioEndPoints;

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}

interface

uses
    Classes, SysUtils;

const
    ENDPOINT_FORMAT_RESET_MIX_ONLY = $00000001;


    IID_IAudioEndpointFormatControl: TGUID = '{784CFD40-9F89-456E-A1A6-873B006A664E}';


type

    IAudioEndpointFormatControl = interface(IUnknown)
        ['{784CFD40-9F89-456E-A1A6-873B006A664E}']
        function ResetToDefault(ResetFlags: DWORD): HResult; stdcall;
    end;

implementation

end.










