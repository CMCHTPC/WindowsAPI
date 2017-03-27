unit Win32.AudioSessionTypes;

{ **************************************************************************
  Copyright (C) 2017 CMC Development Team

  CMC is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 2 of the License, or
  (at your option) any later version.

  CMC is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with CMC. If not, see <http://www.gnu.org/licenses/>.
  ************************************************************************** }

// AudioSessionTypes.h -- Copyright Microsoft Corporation, All Rights Reserved.

// Description: Type definitions used by the audio session manager RPC/COM interfaces


{ Header Definition: 10.0.14393.0 }

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}

interface

uses
    Windows, Classes;

{$IF  DEFINED(WINAPI_PARTITION_APP)}

//-------------------------------------------------------------------------
// Description: AudioClient stream flags

// Can be a combination of AUDCLNT_STREAMFLAGS and AUDCLNT_SYSFXFLAGS:

// AUDCLNT_STREAMFLAGS (this group of flags uses the high word,
// w/exception of high-bit which is reserved, $7FFF0000):


//     AUDCLNT_STREAMFLAGS_CROSSPROCESS -             Audio policy control for this stream will be shared with
//                                                    with other process sessions that use the same audio session
//                                                    GUID.

//     AUDCLNT_STREAMFLAGS_LOOPBACK -                 Initializes a renderer endpoint for a loopback audio application.
//                                                    In this mode, a capture stream will be opened on the specified
//                                                    renderer endpoint. Shared mode and a renderer endpoint is required.
//                                                    Otherwise the IAudioClient::Initialize call will fail. If the
//                                                    initialize is successful, a capture stream will be available
//                                                    from the IAudioClient object.

//     AUDCLNT_STREAMFLAGS_EVENTCALLBACK -            An exclusive mode client will supply an event handle that will be
//                                                    signaled when an IRP completes (or a waveRT buffer completes) telling
//                                                    it to fill the next buffer

//     AUDCLNT_STREAMFLAGS_NOPERSIST -                Session state will not be persisted

//     AUDCLNT_STREAMFLAGS_RATEADJUST -               The sample rate of the stream is adjusted to a rate specified by an application.

//     AUDCLNT_STREAMFLAGS_SRC_DEFAULT_QUALITY -      When used with AUDCLNT_STREAMFLAGS_AUTOCONVERTPCM, a sample rate
//                                                    converter with better quality than the default conversion but with a
//                                                    higher performance cost is used. This should be used if the audio is
//                                                    ultimately intended to be heard by humans as opposed to other
//                                                    scenarios such as pumping silence or populating a meter.

//     AUDCLNT_STREAMFLAGS_AUTOCONVERTPCM -           A channel matrixer and a sample rate converter are inserted as necessary
//                                                    to convert between the uncompressed format supplied to
//                                                    IAudioClient::Initialize and the audio engine mix format.

//     AUDCLNT_STREAMFLAGS_KEYWORDDETECTOR -          Initializes a capture endpoint for keyword detector streaming.

//     AUDCLNT_SESSIONFLAGS_EXPIREWHENUNOWNED -       Session expires when there are no streams and no owning
//                                                    session controls.

//     AUDCLNT_SESSIONFLAGS_DISPLAY_HIDE -            Don't show volume control in the Volume Mixer.

//     AUDCLNT_SESSIONFLAGS_DISPLAY_HIDEWHENEXPIRED - Don't show volume control in the Volume Mixer after the
//                                                    session expires.

// AUDCLNT_SYSFXFLAGS (these flags use low word $0000FFFF):

//     none defined currently

const
    AUDCLNT_STREAMFLAGS_CROSSPROCESS = $00010000;
    AUDCLNT_STREAMFLAGS_LOOPBACK = $00020000;
    AUDCLNT_STREAMFLAGS_EVENTCALLBACK = $00040000;
    AUDCLNT_STREAMFLAGS_NOPERSIST = $00080000;
    AUDCLNT_STREAMFLAGS_RATEADJUST = $00100000;
    AUDCLNT_STREAMFLAGS_SRC_DEFAULT_QUALITY = $08000000;
    AUDCLNT_STREAMFLAGS_AUTOCONVERTPCM = $80000000;
    AUDCLNT_SESSIONFLAGS_EXPIREWHENUNOWNED = $10000000;
    AUDCLNT_SESSIONFLAGS_DISPLAY_HIDE = $20000000;
    AUDCLNT_SESSIONFLAGS_DISPLAY_HIDEWHENEXPIRED = $40000000;

//-------------------------------------------------------------------------
// Description: AudioClient share mode

//     AUDCLNT_SHAREMODE_SHARED -    The device will be opened in shared mode and use the
//                                   WAS format.
//     AUDCLNT_SHAREMODE_EXCLUSIVE - The device will be opened in exclusive mode and use the
//                                   application specified format.

type
    TAUDCLNT_SHAREMODE = (
        AUDCLNT_SHAREMODE_SHARED,
        AUDCLNT_SHAREMODE_EXCLUSIVE);
    PAUDCLNT_SHAREMODE = ^TAUDCLNT_SHAREMODE;

    //-------------------------------------------------------------------------
    // Description: Audio stream categories

    // ForegroundOnlyMedia     - (deprecated for Win10) Music, Streaming audio
    // BackgroundCapableMedia  - (deprecated for Win10) Video with audio
    // Communications          - VOIP, chat, phone call
    // Alerts                  - Alarm, Ring tones
    // SoundEffects            - Sound effects, clicks, dings
    // GameEffects             - Game sound effects
    // GameMedia               - Background audio for games
    // GameChat                - In game player chat
    // Speech                  - Speech recognition
    // Media                   - Music, Streaming audio
    // Movie                   - Video with audio
    // Other                   - All other streams (default)

    TAUDIO_STREAM_CATEGORY = (
        AudioCategory_Other = 0,
        AudioCategory_ForegroundOnlyMedia = 1,
{$IF  (NTDDI_VERSION < NTDDI_THRESHOLD)}
        AudioCategory_BackgroundCapableMedia = 2,
{$ENDIF}
        AudioCategory_Communications = 3,
        AudioCategory_Alerts = 4,
        AudioCategory_SoundEffects = 5,
        AudioCategory_GameEffects = 6,
        AudioCategory_GameMedia = 7,
        AudioCategory_GameChat = 8,
        AudioCategory_Speech = 9,
        AudioCategory_Movie = 10,
        AudioCategory_Media = 11);
    PAUDIO_STREAM_CATEGORY = ^TAudioSessionState;




    //-------------------------------------------------------------------------
    // Description: AudioSession State.

    //      AudioSessionStateInactive - The session has no active audio streams.
    //      AudioSessionStateActive - The session has active audio streams.
    //      AudioSessionStateExpired - The session is dormant.
    TAudioSessionState = (
        AudioSessionStateInactive = 0,
        AudioSessionStateActive = 1,
        AudioSessionStateExpired = 2);
    PAudioSessionState = ^TAudioSessionState;

{$ENDIF}

implementation

end.



