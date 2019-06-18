unit Win32.AudioPolicy;

interface

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

//{$I Win32.WinAPI.inc}

uses
    Classes, SysUtils,
    Windows,
    Win32.AudioSessionTypes, Win32.AudioClient;

const
    IID_IAudioSessionEvents: TGUID = '{24918ACC-64B3-37C1-8CA9-74A66E9957A8}';
    IID_IAudioSessionControl: TGUID = '{F4B1A599-7266-4319-A8CA-E70ACB11E8CD}';
    IID_IAudioSessionControl2: TGUID = '{bfb7ff88-7239-4fc9-8fa2-07c950be9c6d}';
    IID_IAudioSessionManager: TGUID = '{BFA971F1-4D5E-40BB-935E-967039BFBEE4}';
    IID_IAudioVolumeDuckNotification: TGUID = '{C3B284D4-6D39-4359-B3CF-B56DDB3BB39C}';

    IID_IAudioSessionNotification: TGUID = '{641DD20B-4D41-49CC-ABA3-174B9477BB08}';
    IID_IAudioSessionEnumerator: TGUID = '{E2F5BB11-0570-40CA-ACDD-3AA01277DEE8}';
    IID_IAudioSessionManager2: TGUID = '{77AA99A0-1BD6-484F-8BC7-2C654C9A9B6F}';


// {$IF  WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_APP)}
type
    TAudioSessionDisconnectReason = (
        DisconnectReasonDeviceRemoval = 0,
        DisconnectReasonServerShutdown = (DisconnectReasonDeviceRemoval + 1),
        DisconnectReasonFormatChanged = (DisconnectReasonServerShutdown + 1),
        DisconnectReasonSessionLogoff = (DisconnectReasonFormatChanged + 1),
        DisconnectReasonSessionDisconnected = (DisconnectReasonSessionLogoff + 1),
        DisconnectReasonExclusiveModeOverride = (DisconnectReasonSessionDisconnected + 1)
        );




    LPCWSTR = PWideChar;



    IAudioSessionEvents = interface(IUnknown)
        ['{24918ACC-64B3-37C1-8CA9-74A66E9957A8}']
        function OnDisplayNameChanged(NewDisplayName: LPCWSTR; const EventContext: TGUID): HResult; stdcall;
        function OnIconPathChanged(NewIconPath: LPCWSTR; const EventContext: TGUID): HResult; stdcall;
        function OnSimpleVolumeChanged(NewVolume: single; NewMute: boolean; const EventContext: TGUID): HResult; stdcall;
        function OnChannelVolumeChanged(ChannelCount: DWORD; NewChannelVolumeArray: Psingle; ChangedChannel: DWORD;
            const EventContext: TGUID): HResult; stdcall;
        function OnGroupingParamChanged(const NewGroupingParam: TGUID; const EventContext: TGUID): HResult; stdcall;
        function OnStateChanged(NewState: TAudioSessionState): HResult; stdcall;
        function OnSessionDisconnected(DisconnectReason: TAudioSessionDisconnectReason): HResult; stdcall;
    end;

    //{$ENDIF}{ WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_APP) }

    //{$IF  WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_APP)}

    IAudioSessionControl = interface(IUnknown)
        ['{F4B1A599-7266-4319-A8CA-E70ACB11E8CD}']
        function GetState(out pRetVal: TAudioSessionState): HResult; stdcall;
        function GetDisplayName(out pRetVal: LPWSTR): HResult; stdcall;
        function SetDisplayName(Value: LPCWSTR; const EventContext: TGUID): HResult; stdcall;
        function GetIconPath(out pRetVal: LPWSTR): HResult; stdcall;
        function SetIconPath(Value: LPCWSTR; const EventContext: TGUID): HResult; stdcall;
        function GetGroupingParam(out pRetVal: TGUID): HResult; stdcall;
        function SetGroupingParam(const _Override: TGUID; const EventContext: TGUID): HResult; stdcall;
        function RegisterAudioSessionNotification(NewNotifications: IAudioSessionEvents): HResult; stdcall;
        function UnregisterAudioSessionNotification(NewNotifications: IAudioSessionEvents): HResult; stdcall;
    end;



    // {$ENDIF}{ WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_APP) }


    // {$IF  WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP)}



    IAudioSessionControl2 = interface(IAudioSessionControl)
        ['{bfb7ff88-7239-4fc9-8fa2-07c950be9c6d}']
        function GetSessionIdentifier(out pRetVal: LPWSTR): HResult; stdcall;
        function GetSessionInstanceIdentifier(out pRetVal: LPWSTR): HResult; stdcall;
        function GetProcessId(out pRetVal: DWORD): HResult; stdcall;
        function IsSystemSoundsSession(): HResult; stdcall;
        function SetDuckingPreference(optOut: boolean): HResult; stdcall;
    end;




    IAudioSessionManager = interface(IUnknown)
        ['{BFA971F1-4D5E-40BB-935E-967039BFBEE4}']
        function GetAudioSessionControl(const AudioSessionGuid: TGUID; StreamFlags: DWORD;
            out SessionControl: IAudioSessionControl): HResult; stdcall;
        function GetSimpleAudioVolume(const AudioSessionGuid: TGUID; StreamFlags: DWORD;
            out AudioVolume: ISimpleAudioVolume): HResult; stdcall;
    end;



    IAudioVolumeDuckNotification = interface(IUnknown)
        ['{C3B284D4-6D39-4359-B3CF-B56DDB3BB39C}']
        function OnVolumeDuckNotification(sessionID: LPCWSTR; countCommunicationSessions: UINT32): HResult; stdcall;
        function OnVolumeUnduckNotification(sessionID: LPCWSTR): HResult; stdcall;
    end;


    IAudioSessionNotification = interface(IUnknown)
        ['{641DD20B-4D41-49CC-ABA3-174B9477BB08}']
        function OnSessionCreated(NewSession: IAudioSessionControl): HResult; stdcall;
    end;




    IAudioSessionEnumerator = interface(IUnknown)
        ['{E2F5BB11-0570-40CA-ACDD-3AA01277DEE8}']
        function GetCount(out SessionCount: integer): HResult; stdcall;
        function GetSession(SessionCount: integer; out Session: IAudioSessionControl): HResult; stdcall;
    end;




    IAudioSessionManager2 = interface(IAudioSessionManager)
        ['{77AA99A0-1BD6-484F-8BC7-2C654C9A9B6F}']
        function GetSessionEnumerator(out SessionEnum: IAudioSessionEnumerator): HResult; stdcall;
        function RegisterSessionNotification(SessionNotification: IAudioSessionNotification): HResult; stdcall;
        function UnregisterSessionNotification(SessionNotification: IAudioSessionNotification): HResult; stdcall;
        function RegisterDuckNotification(sessionID: LPCWSTR; duckNotification: IAudioVolumeDuckNotification): HResult; stdcall;
        function UnregisterDuckNotification(duckNotification: IAudioVolumeDuckNotification): HResult; stdcall;
    end;



implementation

end.
