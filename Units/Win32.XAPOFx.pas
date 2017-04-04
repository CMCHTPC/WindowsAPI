unit Win32.XAPOFx;

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
{-========================================================================-_
 |                                - XAPOFX -                                |
 |        Copyright (c) Microsoft Corporation.  All rights reserved.        |
 |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
 |PROJECT: XAPOFX                       MODEL:   Unmanaged User-mode        |
 |VERSION: 1.3                          EXCEPT:  No Exceptions              |
 |CLASS:   N / A                        MINREQ:  WinXP, Xbox360             |
 |BASE:    N / A                        DIALECT: MSC++ 14.00                |
 |>------------------------------------------------------------------------<|
 | DUTY: Cross-platform Audio Processing Objects                            |
 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
}



{ Header Definition: 10.0.14393.0 }

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}

interface

uses
    Windows, Classes;

{$IF (_WIN32_WINNT < _WIN32_WINNT_WIN8)}
{$error This version of XAudio2 is available only in Windows 8 or later. Use the XAudio2 headers and libraries from the DirectX SDK with applications that target Windows 7 and earlier versions.}
{$ENDIF}// (_WIN32_WINNT < _WIN32_WINNT_WIN8)

// Current name of the DLL shipped in the same SDK as this header.
// The name reflects the current version
{$IF (_WIN32_WINNT >= _WIN32_WINNT_WIN10)}
const
    XAudio2_DLL = 'xaudio2_9.dll';
    XAudio2D_DLL = 'xaudio2_9d.dll';
{$ELSE}
    XAudio2_DLL = 'xaudio2_8.dll';
    XAudio2D_DLL = 'xaudio2_8.dll';
{$ENDIF}

{$IF  (DEFINED(WINAPI_PARTITION_APP ) or DEFINED( WINAPI_PARTITION_TV_APP)  or DEFINED( WINAPI_PARTITION_TV_TITLE))}

//--------------<D-E-F-I-N-I-T-I-O-N-S>-------------------------------------//

const
    // FX class IDs
    CLSID_FXEQ: TGUID = '{F5E01117-D6C4-485A-A3F5-695196F3DBFA}';
    CLSID_FXMasteringLimiter: TGUID = '{C4137916-2BE1-46FD-8599-441536F49856}';
    CLSID_FXReverb: TGUID = '{7D9ACA56-CB68-4807-B632-B137352E8596}';
    CLSID_FXEcho: TGUID = '{5039D740-F736-449A-84D3-A56202557B87}';


//include <windows.h>
//include <objbase.h>
//include <single.h>       // single bounds


// EQ parameter bounds (inclusive), used with FXEQ:
const
    FXEQ_MIN_FRAMERATE = 22000;
    FXEQ_MAX_FRAMERATE = 48000;

    FXEQ_MIN_FREQUENCY_CENTER = 20.0;
    FXEQ_MAX_FREQUENCY_CENTER = 20000.0;
    FXEQ_DEFAULT_FREQUENCY_CENTER_0 = 100.0;   // band 0
    FXEQ_DEFAULT_FREQUENCY_CENTER_1 = 800.0;   // band 1
    FXEQ_DEFAULT_FREQUENCY_CENTER_2 = 2000.0;  // band 2
    FXEQ_DEFAULT_FREQUENCY_CENTER_3 = 10000.0; // band 3

    FXEQ_MIN_GAIN = 0.126; // -18dB
    FXEQ_MAX_GAIN = 7.94;  // +18dB
    FXEQ_DEFAULT_GAIN = 1.0;   // 0dB change, all bands

    FXEQ_MIN_BANDWIDTH = 0.1;
    FXEQ_MAX_BANDWIDTH = 2.0;
    FXEQ_DEFAULT_BANDWIDTH = 1.0; // all bands


    // Mastering limiter parameter bounds (inclusive), used with FXMasteringLimiter:
    FXMASTERINGLIMITER_MIN_RELEASE = 1;
    FXMASTERINGLIMITER_MAX_RELEASE = 20;
    FXMASTERINGLIMITER_DEFAULT_RELEASE = 6;

    FXMASTERINGLIMITER_MIN_LOUDNESS = 1;
    FXMASTERINGLIMITER_MAX_LOUDNESS = 1800;
    FXMASTERINGLIMITER_DEFAULT_LOUDNESS = 1000;


    // Reverb parameter bounds (inclusive), used with FXReverb:
    FXREVERB_MIN_DIFFUSION = 0.0;
    FXREVERB_MAX_DIFFUSION = 1.0;
    FXREVERB_DEFAULT_DIFFUSION = 0.9;

    FXREVERB_MIN_ROOMSIZE = 0.0001;
    FXREVERB_MAX_ROOMSIZE = 1.0;
    FXREVERB_DEFAULT_ROOMSIZE = 0.6;


    // Echo initialization data/parameter bounds (inclusive), used with FXEcho:
    FXECHO_MIN_WETDRYMIX = 0.0;
    FXECHO_MAX_WETDRYMIX = 1.0;
    FXECHO_DEFAULT_WETDRYMIX = 0.5;

    FXECHO_MIN_FEEDBACK = 0.0;
    FXECHO_MAX_FEEDBACK = 1.0;
    FXECHO_DEFAULT_FEEDBACK = 0.5;

    FXECHO_MIN_DELAY = 1.0;
    FXECHO_MAX_DELAY = 2000.0;
    FXECHO_DEFAULT_DELAY = 500.0;


//--------------<D-A-T-A---T-Y-P-E-S>---------------------------------------//
//pragma pack(push, 1) // set packing alignment to ensure consistency across arbitrary build environments
    {$A1}


// EQ parameters (4 bands), used with IXAPOParameters::SetParameters:
// The EQ supports only FLOAT32 audio foramts.
// The framerate must be within [22000, 48000] Hz.
type
    TFXEQ_PARAMETERS = record
        FrequencyCenter0: single; // center frequency in Hz, band 0
        Gain0: single;            // boost/cut
        Bandwidth0: single;       // bandwidth, region of EQ is center frequency +/- bandwidth/2
        FrequencyCenter1: single; // band 1
        Gain1: single;
        Bandwidth1: single;
        FrequencyCenter2: single; // band 2
        Gain2: single;
        Bandwidth2: single;
        FrequencyCenter3: single; // band 3
        Gain3: single;
        Bandwidth3: single;
    end;
    PFXEQ_PARAMETERS = ^TFXEQ_PARAMETERS;


    // Mastering limiter parameters, used with IXAPOParameters::SetParameters:
    // The mastering limiter supports only FLOAT32 audio formats.
    TFXMASTERINGLIMITER_PARAMETERS = record
        Release: UINT32;  // release time (tuning factor with no specific units)
        Loudness: UINT32; // loudness target (threshold)
    end;
    PFXMASTERINGLIMITER_PARAMETERS = ^TFXMASTERINGLIMITER_PARAMETERS;


    // Reverb parameters, used with IXAPOParameters::SetParameters:
    // The reverb supports only FLOAT32 audio formats with the following
    // channel configurations:
    //     Input: Mono   Output: Mono
    //     Input: Stereo Output: Stereo
    TFXREVERB_PARAMETERS = record
        Diffusion: single; // diffusion
        RoomSize: single;  // room size
    end;
    PFXREVERB_PARAMETERS = ^TFXREVERB_PARAMETERS;


    // Echo initialization data, used with CreateFX:
    // Use of this structure is optional, the default MaxDelay is FXECHO_DEFAULT_DELAY.
    TFXECHO_INITDATA = record
        MaxDelay: single;  // maximum delay (all channels) in milliseconds, must be within [FXECHO_MIN_DELAY, FXECHO_MAX_DELAY]
    end;
    PFXECHO_INITDATA = ^TFXECHO_INITDATA;

    // Echo parameters, used with IXAPOParameters::SetParameters:
    // The echo supports only FLOAT32 audio formats.
    TFXECHO_PARAMETERS = record
        WetDryMix: single; // ratio of wet (processed) signal to dry (original) signal
        Feedback: single;  // amount of output fed back into input
        Delay: single;     // delay (all channels) in milliseconds, must be within [FXECHO_MIN_DELAY, FXECHO_PARAMETERS.MaxDelay]
    end;
    PFXECHO_PARAMETERS = ^TFXECHO_PARAMETERS;



//--------------<F-U-N-C-T-I-O-N-S>-----------------------------------------//
// creates instance of requested XAPO, use Release to free instance
//  pInitData        - [in] effect-specific initialization parameters, may be NULL if InitDataByteSize == 0
//  InitDataByteSize - [in] size of pInitData in bytes, may be 0 if pInitData is NULL
function CreateFX(const clsid: TGUID; out pEffect: IUnknown; pInitData: PByte = nil; InitDataByteSize: UINT32 = 0): HResult; stdcall; external XAudio2_DLL;


//pragma pack(pop) // revert packing alignment
    {$A4}

{$ENDIF}{ WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_APP | WINAPI_PARTITION_TV_APP | WINAPI_PARTITION_TV_TITLE) }

implementation

end.
