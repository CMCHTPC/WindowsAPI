unit Win32.AudioMediaType;


interface

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}

uses
    Classes, SysUtils,
    Win32.AudioSessionTypes;

const
    IID_IAudioMediaType: TGUID = '{4E997F73-B71F-4798-873B-ED7DFCF15B4D}';

const
    AUDIOMEDIATYPE_EQUAL_FORMAT_TYPES = $00000002;
    AUDIOMEDIATYPE_EQUAL_FORMAT_DATA = $00000004;
    AUDIOMEDIATYPE_EQUAL_FORMAT_USER_DATA = $00000008;


type

    // {$if WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP)}

    TUNCOMPRESSEDAUDIOFORMAT = record
        guidFormatType: TGUID;
        dwSamplesPerFrame: DWORD;
        dwBytesPerSampleContainer: DWORD;
        dwValidBitsPerSample: DWORD;
        fFramesPerSecond: single;
        dwChannelMask: DWORD;
    end;



    IAudioMediaType = interface(IUnknown)
        ['{4E997F73-B71F-4798-873B-ED7DFCF15B4D}']
        function IsCompressedFormat(out pfCompressed: boolean): HResult; stdcall;
        function IsEqual(pIAudioType: IAudioMediaType; out pdwFlags: DWORD): HResult; stdcall;
        function GetAudioFormat(): TWAVEFORMATEX; stdcall;
        function GetUncompressedAudioFormat(out pUncompressedAudioFormat: TUNCOMPRESSEDAUDIOFORMAT): HResult; stdcall;
    end;




// CreateAudioMediaType

function CreateAudioMediaType(const pAudioFormat: TWAVEFORMATEX; cbAudioFormatSize: UINT32; ppIAudioMediaType: IAudioMediaType): HResult;
    stdcall; external;

// CreateAudioMediaTypeFromUncompressedAudioFormat

function CreateAudioMediaTypeFromUncompressedAudioFormat(const pUncompressedAudioFormat: TUNCOMPRESSEDAUDIOFORMAT;
    ppIAudioMediaType: IAudioMediaType): HResult; stdcall; external;

// {$endif} { WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) }

implementation

end.












