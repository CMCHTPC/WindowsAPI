unit Win32.XAudio2Fx;

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
{*************************************************************************
 *
 * Copyright (c) Microsoft Corporation.  All rights reserved.
 *
 * File:    xaudio2fx.h
 * Content: Declarations for the audio effects included with XAudio2.
 *
 *************************************************************************}


{ Header Definition: 10.0.14393.0 }

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}

interface

{$IF (_WIN32_WINNT < _WIN32_WINNT_WIN8)}
{$error This version of XAudio2 is available only in Windows 8 or later. Use the XAudio2 headers and libraries from the DirectX SDK with applications that target Windows 7 and earlier versions.}
{$ENDIF}// (_WIN32_WINNT < _WIN32_WINNT_WIN8)




{$IF  (DEFINED(WINAPI_PARTITION_APP) OR DEFINED( WINAPI_PARTITION_TV_APP) or DEFINED( WINAPI_PARTITION_TV_TITLE))}

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

// XAudio 2.8
const
    IID_AudioVolumeMeter: TGUID = '{4FC3B166-972A-40CF-BC37-7DB03DB2FBA3}';
    IID_AudioReverb: TGUID = '{C2633B16-471B-4498-B8C5-4F0959E2EC09}';

// All structures defined in this file should use tight packing
{$A1}
//pragma pack(push, 1)


{*************************************************************************
 *
 * Effect creation functions.
 *
 * On Xbox the application can link with the debug library to use the debug
 * functionality.
 *
 *************************************************************************}


function CreateAudioVolumeMeter(out ppApo: IUnknown): HResult; stdcall; external XAudio2_DLL;
function CreateAudioReverb(out ppApo: IUnknown): HResult; stdcall; external XAudio2_DLL;

function XAudio2CreateVolumeMeter(out ppApo: IUnknown; Flags: UINT32 = 0): HRESULT;
function XAudio2CreateReverb(out ppApo: IUnknown; Flags: UINT32 = 0): HRESULT;




{*************************************************************************
 *
 * Volume meter parameters.
 * The volume meter supports single32 audio formats and must be used in-place.
 *
 *************************************************************************}

type
    // XAUDIO2FX_VOLUMEMETER_LEVELS: Receives results from GetEffectParameters().
    // The user is responsible for allocating pPeakLevels, pRMSLevels, and
    // initializing ChannelCount accordingly.
    // The volume meter does not support SetEffectParameters().
    TXAUDIO2FX_VOLUMEMETER_LEVELS = record
        pPeakLevels: PSingle;  // Peak levels table: receives maximum absolute level for each channel
        // over a processing pass; may be NULL if pRMSLevls != NULL,
        // otherwise must have at least ChannelCount elements.
        pRMSLevels: PSingle;   // Root mean square levels table: receives RMS level for each channel
        // over a processing pass; may be NULL if pPeakLevels != NULL,
        // otherwise must have at least ChannelCount elements.
        ChannelCount: UINT32; // Number of channels being processed by the volume meter APO
    end;
    PXAUDIO2FX_VOLUMEMETER_LEVELS = ^TXAUDIO2FX_VOLUMEMETER_LEVELS;



{*************************************************************************
 *
 * Reverb parameters.
 * The reverb supports only single32 audio with the following channel
 * configurations:
 *     Input: Mono   Output: Mono
 *     Input: Mono   Output: 5.1
 *     Input: Stereo Output: Stereo
 *     Input: Stereo Output: 5.1
 * The framerate must be within [20000, 48000] Hz.
 *
 * When using mono input, delay filters associated with the right channel
 * are not executed.  In this case, parameters such as PositionRight and
 * PositionMatrixRight have no effect.  This also means the reverb uses
 * less CPU when hosted in a mono submix.
 *
 *************************************************************************}

const
    XAUDIO2FX_REVERB_MIN_FRAMERATE = 20000;
    XAUDIO2FX_REVERB_MAX_FRAMERATE = 48000;

// XAUDIO2FX_REVERB_PARAMETERS: Native parameter set for the reverb effect

type
    TXAUDIO2FX_REVERB_PARAMETERS = record
        // ratio of wet (processed) signal to dry (original) signal
        WetDryMix: single;            // [0, 100] (percentage)

        // Delay times
        ReflectionsDelay: UINT32;    // [0, 300] in ms
        ReverbDelay: byte;           // [0, 85] in ms
        RearDelay: byte;             // 7.1: [0, 20] in ms, all other: [0, 5] in ms
{$IF (_WIN32_WINNT >= _WIN32_WINNT_WIN10)}
        SideDelay: byte;             // 7.1: [0, 5] in ms, all other: not used, but still validated
{$ENDIF}


        // Indexed parameters
        PositionLeft: byte;          // [0, 30] no units
        PositionRight: byte;         // [0, 30] no units, ignored when configured to mono
        PositionMatrixLeft: byte;    // [0, 30] no units
        PositionMatrixRight: byte;   // [0, 30] no units, ignored when configured to mono
        EarlyDiffusion: byte;        // [0, 15] no units
        LateDiffusion: byte;         // [0, 15] no units
        LowEQGain: byte;             // [0, 12] no units
        LowEQCutoff: byte;           // [0, 9] no units
        HighEQGain: byte;            // [0, 8] no units
        HighEQCutoff: byte;          // [0, 14] no units

        // Direct parameters
        RoomFilterFreq: single;       // [20, 20000] in Hz
        RoomFilterMain: single;       // [-100, 0] in dB
        RoomFilterHF: single;         // [-100, 0] in dB
        ReflectionsGain: single;      // [-100, 20] in dB
        ReverbGain: single;           // [-100, 20] in dB
        DecayTime: single;            // [0.1, inf] in seconds
        Density: single;              // [0, 100] (percentage)
        RoomSize: single;             // [1, 100] in feet

        // component control
        DisableLateField: boolean;      // TRUE to disable late field reflections
    end;
    PXAUDIO2FX_REVERB_PARAMETERS = ^TXAUDIO2FX_REVERB_PARAMETERS;


// Maximum, minimum and default values for the parameters above
const
    XAUDIO2FX_REVERB_MIN_WET_DRY_MIX = 0.0;
    XAUDIO2FX_REVERB_MIN_REFLECTIONS_DELAY = 0;
    XAUDIO2FX_REVERB_MIN_REVERB_DELAY = 0;
    XAUDIO2FX_REVERB_MIN_REAR_DELAY = 0;
    XAUDIO2FX_REVERB_MIN_7POINT1_SIDE_DELAY = 0;
    XAUDIO2FX_REVERB_MIN_7POINT1_REAR_DELAY = 0;
    XAUDIO2FX_REVERB_MIN_POSITION = 0;
    XAUDIO2FX_REVERB_MIN_DIFFUSION = 0;
    XAUDIO2FX_REVERB_MIN_LOW_EQ_GAIN = 0;
    XAUDIO2FX_REVERB_MIN_LOW_EQ_CUTOFF = 0;
    XAUDIO2FX_REVERB_MIN_HIGH_EQ_GAIN = 0;
    XAUDIO2FX_REVERB_MIN_HIGH_EQ_CUTOFF = 0;
    XAUDIO2FX_REVERB_MIN_ROOM_FILTER_FREQ = 20.0;
    XAUDIO2FX_REVERB_MIN_ROOM_FILTER_MAIN = -100.0;
    XAUDIO2FX_REVERB_MIN_ROOM_FILTER_HF = -100.0;
    XAUDIO2FX_REVERB_MIN_REFLECTIONS_GAIN = -100.0;
    XAUDIO2FX_REVERB_MIN_REVERB_GAIN = -100.0;
    XAUDIO2FX_REVERB_MIN_DECAY_TIME = 0.1;
    XAUDIO2FX_REVERB_MIN_DENSITY = 0.0;
    XAUDIO2FX_REVERB_MIN_ROOM_SIZE = 0.0;

    XAUDIO2FX_REVERB_MAX_WET_DRY_MIX = 100.0;
    XAUDIO2FX_REVERB_MAX_REFLECTIONS_DELAY = 300;
    XAUDIO2FX_REVERB_MAX_REVERB_DELAY = 85;
    XAUDIO2FX_REVERB_MAX_REAR_DELAY = 5;
    XAUDIO2FX_REVERB_MAX_7POINT1_SIDE_DELAY = 5;
    XAUDIO2FX_REVERB_MAX_7POINT1_REAR_DELAY = 20;
    XAUDIO2FX_REVERB_MAX_POSITION = 30;
    XAUDIO2FX_REVERB_MAX_DIFFUSION = 15;
    XAUDIO2FX_REVERB_MAX_LOW_EQ_GAIN = 12;
    XAUDIO2FX_REVERB_MAX_LOW_EQ_CUTOFF = 9;
    XAUDIO2FX_REVERB_MAX_HIGH_EQ_GAIN = 8;
    XAUDIO2FX_REVERB_MAX_HIGH_EQ_CUTOFF = 14;
    XAUDIO2FX_REVERB_MAX_ROOM_FILTER_FREQ = 20000.0;
    XAUDIO2FX_REVERB_MAX_ROOM_FILTER_MAIN = 0.0;
    XAUDIO2FX_REVERB_MAX_ROOM_FILTER_HF = 0.0;
    XAUDIO2FX_REVERB_MAX_REFLECTIONS_GAIN = 20.0;
    XAUDIO2FX_REVERB_MAX_REVERB_GAIN = 20.0;
    XAUDIO2FX_REVERB_MAX_DENSITY = 100.0;
    XAUDIO2FX_REVERB_MAX_ROOM_SIZE = 100.0;

    XAUDIO2FX_REVERB_DEFAULT_WET_DRY_MIX = 100.0;
    XAUDIO2FX_REVERB_DEFAULT_REFLECTIONS_DELAY = 5;
    XAUDIO2FX_REVERB_DEFAULT_REVERB_DELAY = 5;
    XAUDIO2FX_REVERB_DEFAULT_REAR_DELAY = 5;
    XAUDIO2FX_REVERB_DEFAULT_7POINT1_SIDE_DELAY = 5;
    XAUDIO2FX_REVERB_DEFAULT_7POINT1_REAR_DELAY = 20;
    XAUDIO2FX_REVERB_DEFAULT_POSITION = 6;
    XAUDIO2FX_REVERB_DEFAULT_POSITION_MATRIX = 27;
    XAUDIO2FX_REVERB_DEFAULT_EARLY_DIFFUSION = 8;
    XAUDIO2FX_REVERB_DEFAULT_LATE_DIFFUSION = 8;
    XAUDIO2FX_REVERB_DEFAULT_LOW_EQ_GAIN = 8;
    XAUDIO2FX_REVERB_DEFAULT_LOW_EQ_CUTOFF = 4;
    XAUDIO2FX_REVERB_DEFAULT_HIGH_EQ_GAIN = 8;
    XAUDIO2FX_REVERB_DEFAULT_HIGH_EQ_CUTOFF = 4;
    XAUDIO2FX_REVERB_DEFAULT_ROOM_FILTER_FREQ = 5000.0;
    XAUDIO2FX_REVERB_DEFAULT_ROOM_FILTER_MAIN = 0.0;
    XAUDIO2FX_REVERB_DEFAULT_ROOM_FILTER_HF = 0.0;
    XAUDIO2FX_REVERB_DEFAULT_REFLECTIONS_GAIN = 0.0;
    XAUDIO2FX_REVERB_DEFAULT_REVERB_GAIN = 0.0;
    XAUDIO2FX_REVERB_DEFAULT_DECAY_TIME = 1.0;
    XAUDIO2FX_REVERB_DEFAULT_DENSITY = 100.0;
    XAUDIO2FX_REVERB_DEFAULT_ROOM_SIZE = 100.0;
    XAUDIO2FX_REVERB_DEFAULT_DISABLE_LATE_FIELD = False;


// XAUDIO2FX_REVERB_I3DL2_PARAMETERS: Parameter set compliant with the I3DL2 standard
type
    TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = record
        // ratio of wet (processed) signal to dry (original) signal
        WetDryMix: single;            // [0, 100] (percentage)

        // Standard I3DL2 parameters
        Room: INT32;                 // [-10000, 0] in mB (hundredths of decibels)
        RoomHF: INT32;               // [-10000, 0] in mB (hundredths of decibels)
        RoomRolloffFactor: single;    // [0.0, 10.0]
        DecayTime: single;            // [0.1, 20.0] in seconds
        DecayHFRatio: single;         // [0.1, 2.0]
        Reflections: INT32;          // [-10000, 1000] in mB (hundredths of decibels)
        ReflectionsDelay: single;     // [0.0, 0.3] in seconds
        Reverb: INT32;               // [-10000, 2000] in mB (hundredths of decibels)
        ReverbDelay: single;          // [0.0, 0.1] in seconds
        Diffusion: single;            // [0.0, 100.0] (percentage)
        Density: single;              // [0.0, 100.0] (percentage)
        HFReference: single;          // [20.0, 20000.0] in Hz
    end;
    PXAUDIO2FX_REVERB_I3DL2_PARAMETERS = ^TXAUDIO2FX_REVERB_I3DL2_PARAMETERS;


// ReverbConvertI3DL2ToNative: Utility function to map from I3DL2 to native parameters

procedure ReverbConvertI3DL2ToNative(const pI3DL2: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS; out pNative: TXAUDIO2FX_REVERB_PARAMETERS
{$IF (_WIN32_WINNT >= _WIN32_WINNT_WIN10)}   ; sevenDotOneReverb: boolean = True
{$ENDIF}
    );



{*************************************************************************
 *
 * Standard I3DL2 reverb presets (100% wet).
 *
 *************************************************************************}


const
    XAUDIO2FX_I3DL2_PRESET_DEFAULT: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -10000;
        RoomHF: 0; RoomRolloffFactor: 0.0; DecayTime: 1.00; DecayHFRatio: 0.50; Reflections: -10000; ReflectionsDelay: 0.020;
        Reverb: -10000; ReverbDelay: 0.040; Diffusion: 100.0; Density: 100.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_GENERIC: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: -100; RoomRolloffFactor: 0.0; DecayTime: 1.49; DecayHFRatio: 0.83; Reflections: -2602; ReflectionsDelay: 0.007;
        Reverb: 200; ReverbDelay: 0.011; Diffusion: 100.0; Density: 100.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_PADDEDCELL: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: -6000; RoomRolloffFactor: 0.0; DecayTime: 0.17; DecayHFRatio: 0.10; Reflections: -1204; ReflectionsDelay: 0.001;
        Reverb: 207; ReverbDelay: 0.002; Diffusion: 100.0; Density: 100.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_ROOM: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: -454; RoomRolloffFactor: 0.0; DecayTime: 0.40; DecayHFRatio: 0.83; Reflections: -1646; ReflectionsDelay: 0.002;
        Reverb: 53; ReverbDelay: 0.003; Diffusion: 100.0; Density: 100.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_BATHROOM: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: -1200; RoomRolloffFactor: 0.0; DecayTime: 1.49; DecayHFRatio: 0.54; Reflections: -370; ReflectionsDelay: 0.007;
        Reverb: 1030; ReverbDelay: 0.011; Diffusion: 100.0; Density: 60.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_LIVINGROOM: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: -6000; RoomRolloffFactor: 0.0; DecayTime: 0.50; DecayHFRatio: 0.10; Reflections: -1376; ReflectionsDelay: 0.003;
        Reverb: -1104; ReverbDelay: 0.004; Diffusion: 100.0; Density: 100.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_STONEROOM: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: -300; RoomRolloffFactor: 0.0; DecayTime: 2.31; DecayHFRatio: 0.64; Reflections: -711; ReflectionsDelay: 0.012;
        Reverb: 83; ReverbDelay: 0.017; Diffusion: 100.0; Density: 100.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_AUDITORIUM: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: -476; RoomRolloffFactor: 0.0; DecayTime: 4.32; DecayHFRatio: 0.59; Reflections: -789; ReflectionsDelay: 0.020;
        Reverb: -289; ReverbDelay: 0.030; Diffusion: 100.0; Density: 100.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_CONCERTHALL: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: -500; RoomRolloffFactor: 0.0; DecayTime: 3.92; DecayHFRatio: 0.70; Reflections: -1230; ReflectionsDelay: 0.020;
        Reverb: -2; ReverbDelay: 0.029; Diffusion: 100.0; Density: 100.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_CAVE: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: 0; RoomRolloffFactor: 0.0; DecayTime: 2.91; DecayHFRatio: 1.30; Reflections: -602; ReflectionsDelay: 0.015;
        Reverb: -302; ReverbDelay: 0.022; Diffusion: 100.0; Density: 100.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_ARENA: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: -698; RoomRolloffFactor: 0.0; DecayTime: 7.24; DecayHFRatio: 0.33; Reflections: -1166; ReflectionsDelay: 0.020;
        Reverb: 16; ReverbDelay: 0.030; Diffusion: 100.0; Density: 100.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_HANGAR: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: -1000; RoomRolloffFactor: 0.0; DecayTime: 10.05; DecayHFRatio: 0.23; Reflections: -602; ReflectionsDelay: 0.020;
        Reverb: 198; ReverbDelay: 0.030; Diffusion: 100.0; Density: 100.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_CARPETEDHALLWAY: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: -4000; RoomRolloffFactor: 0.0; DecayTime: 0.30; DecayHFRatio: 0.10; Reflections: -1831; ReflectionsDelay: 0.002;
        Reverb: -1630; ReverbDelay: 0.030; Diffusion: 100.0; Density: 100.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_HALLWAY: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: -300; RoomRolloffFactor: 0.0; DecayTime: 1.49; DecayHFRatio: 0.59; Reflections: -1219; ReflectionsDelay: 0.007;
        Reverb: 441; ReverbDelay: 0.011; Diffusion: 100.0; Density: 100.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_STONECORRIDOR: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: -237; RoomRolloffFactor: 0.0; DecayTime: 2.70; DecayHFRatio: 0.79; Reflections: -1214; ReflectionsDelay: 0.013;
        Reverb: 395; ReverbDelay: 0.020; Diffusion: 100.0; Density: 100.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_ALLEY: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: -270; RoomRolloffFactor: 0.0; DecayTime: 1.49; DecayHFRatio: 0.86; Reflections: -1204; ReflectionsDelay: 0.007;
        Reverb: -4; ReverbDelay: 0.011; Diffusion: 100.0; Density: 100.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_FOREST: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: -3300; RoomRolloffFactor: 0.0; DecayTime: 1.49; DecayHFRatio: 0.54; Reflections: -2560; ReflectionsDelay: 0.162;
        Reverb: -613; ReverbDelay: 0.088; Diffusion: 79.0; Density: 100.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_CITY: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: -800; RoomRolloffFactor: 0.0; DecayTime: 1.49; DecayHFRatio: 0.67; Reflections: -2273; ReflectionsDelay: 0.007;
        Reverb: -2217; ReverbDelay: 0.011; Diffusion: 50.0; Density: 100.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_MOUNTAINS: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: -2500; RoomRolloffFactor: 0.0; DecayTime: 1.49; DecayHFRatio: 0.21; Reflections: -2780; ReflectionsDelay: 0.300;
        Reverb: -2014; ReverbDelay: 0.100; Diffusion: 27.0; Density: 100.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_QUARRY: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: -1000; RoomRolloffFactor: 0.0; DecayTime: 1.49; DecayHFRatio: 0.83; Reflections: -10000; ReflectionsDelay: 0.061;
        Reverb: 500; ReverbDelay: 0.025; Diffusion: 100.0; Density: 100.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_PLAIN: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: -2000; RoomRolloffFactor: 0.0; DecayTime: 1.49; DecayHFRatio: 0.50; Reflections: -2466; ReflectionsDelay: 0.179;
        Reverb: -2514; ReverbDelay: 0.100; Diffusion: 21.0; Density: 100.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_PARKINGLOT: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: 0; RoomRolloffFactor: 0.0; DecayTime: 1.65; DecayHFRatio: 1.50; Reflections: -1363; ReflectionsDelay: 0.008;
        Reverb: -1153; ReverbDelay: 0.012; Diffusion: 100.0; Density: 100.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_SEWERPIPE: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: -1000; RoomRolloffFactor: 0.0; DecayTime: 2.81; DecayHFRatio: 0.14; Reflections: 429; ReflectionsDelay: 0.014;
        Reverb: 648; ReverbDelay: 0.021; Diffusion: 80.0; Density: 60.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_UNDERWATER: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: -4000; RoomRolloffFactor: 0.0; DecayTime: 1.49; DecayHFRatio: 0.10; Reflections: -449; ReflectionsDelay: 0.007;
        Reverb: 1700; ReverbDelay: 0.011; Diffusion: 100.0; Density: 100.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_SMALLROOM: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: -600; RoomRolloffFactor: 0.0; DecayTime: 1.10; DecayHFRatio: 0.83; Reflections: -400; ReflectionsDelay: 0.005;
        Reverb: 500; ReverbDelay: 0.010; Diffusion: 100.0; Density: 100.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_MEDIUMROOM: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: -600; RoomRolloffFactor: 0.0; DecayTime: 1.30; DecayHFRatio: 0.83; Reflections: -1000; ReflectionsDelay: 0.010;
        Reverb: -200; ReverbDelay: 0.020; Diffusion: 100.0; Density: 100.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_LARGEROOM: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: -600; RoomRolloffFactor: 0.0; DecayTime: 1.50; DecayHFRatio: 0.83; Reflections: -1600; ReflectionsDelay: 0.020;
        Reverb: -1000; ReverbDelay: 0.040; Diffusion: 100.0; Density: 100.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_MEDIUMHALL: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: -600; RoomRolloffFactor: 0.0; DecayTime: 1.80; DecayHFRatio: 0.70; Reflections: -1300; ReflectionsDelay: 0.015;
        Reverb: -800; ReverbDelay: 0.030; Diffusion: 100.0; Density: 100.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_LARGEHALL: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: -600; RoomRolloffFactor: 0.0; DecayTime: 1.80; DecayHFRatio: 0.70; Reflections: -2000; ReflectionsDelay: 0.030;
        Reverb: -1400; ReverbDelay: 0.060; Diffusion: 100.0; Density: 100.0; HFReference: 5000.0);
    XAUDIO2FX_I3DL2_PRESET_PLATE: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS = (WetDryMix: 100; Room: -1000;
        RoomHF: -200; RoomRolloffFactor: 0.0; DecayTime: 1.30; DecayHFRatio: 0.90; Reflections: 0; ReflectionsDelay: 0.002;
        Reverb: 0; ReverbDelay: 0.010; Diffusion: 100.0; Density: 75.0; HFReference: 5000.0);


// Undo the #pragma pack(push, 1) at the top of this file
{$A4}
//pragma pack(pop)



{$ENDIF}{ WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_APP | WINAPI_PARTITION_TV_APP | WINAPI_PARTITION_TV_TITLE) }

implementation

uses
    Math;

function XAudio2CreateVolumeMeter(out ppApo: IUnknown; Flags: UINT32 = 0): HRESULT; inline;
begin
    Result := CreateAudioVolumeMeter(ppApo);
end;

function XAudio2CreateReverb(out ppApo: IUnknown; Flags: UINT32 = 0): HRESULT; inline;
begin
    Result := CreateAudioReverb(ppApo);
end;

procedure ReverbConvertI3DL2ToNative(const pI3DL2: TXAUDIO2FX_REVERB_I3DL2_PARAMETERS; out pNative: TXAUDIO2FX_REVERB_PARAMETERS
{$IF (_WIN32_WINNT >= _WIN32_WINNT_WIN10)}    ; sevenDotOneReverb: boolean = True
{$ENDIF}
    ); inline;
var
    reflectionsDelay: single;
    reverbDelay: single;
    index: INT32;
begin

    // RoomRolloffFactor is ignored

    // These parameters have no equivalent in I3DL2
{$IF (_WIN32_WINNT >= _WIN32_WINNT_WIN10)}
    if (sevenDotOneReverb) then
    begin
        pNative.RearDelay := XAUDIO2FX_REVERB_DEFAULT_7POINT1_REAR_DELAY; // 20
    end
    else
    begin
        pNative.RearDelay := XAUDIO2FX_REVERB_DEFAULT_REAR_DELAY; // 5
    end;
    pNative.SideDelay := XAUDIO2FX_REVERB_DEFAULT_7POINT1_SIDE_DELAY; // 5
{$ELSE}
    pNative.RearDelay := XAUDIO2FX_REVERB_DEFAULT_REAR_DELAY; // 5
{$ENDIF}
    pNative.PositionLeft := XAUDIO2FX_REVERB_DEFAULT_POSITION; // 6
    pNative.PositionRight := XAUDIO2FX_REVERB_DEFAULT_POSITION; // 6
    pNative.PositionMatrixLeft := XAUDIO2FX_REVERB_DEFAULT_POSITION_MATRIX; // 27
    pNative.PositionMatrixRight := XAUDIO2FX_REVERB_DEFAULT_POSITION_MATRIX; // 27
    pNative.RoomSize := XAUDIO2FX_REVERB_DEFAULT_ROOM_SIZE; // 100
    pNative.LowEQCutoff := 4;
    pNative.HighEQCutoff := 6;

    // The rest of the I3DL2 parameters map to the native property set
    pNative.RoomFilterMain := pI3DL2.Room / 100.0;
    ;
    pNative.RoomFilterHF := pI3DL2.RoomHF / 100.0;
    ;

    if (pI3DL2.DecayHFRatio >= 1.0) then
    begin
        index := trunc(-4.0 * log10(pI3DL2.DecayHFRatio));
        if (index < -8) then
            index := -8;
        if (trunc(index) < 0) then
            pNative.LowEQGain := index + 8
        else
            pNative.LowEQGain := 8;
        pNative.HighEQGain := 8;
        pNative.DecayTime := pI3DL2.DecayTime * pI3DL2.DecayHFRatio;
    end
    else
    begin
        index := trunc(4.0 * log10(pI3DL2.DecayHFRatio));
        if (index < -8) then
            index := -8;
        pNative.LowEQGain := 8;
        if (trunc(index) < 0) then
            pNative.HighEQGain := index + 8
        else
            pNative.HighEQGain := 8;
        pNative.DecayTime := pI3DL2.DecayTime;
    end;

    reflectionsDelay := pI3DL2.ReflectionsDelay * 1000.0;
    ;
    if (reflectionsDelay >= XAUDIO2FX_REVERB_MAX_REFLECTIONS_DELAY) then // 300
    begin
        reflectionsDelay := (XAUDIO2FX_REVERB_MAX_REFLECTIONS_DELAY - 1);
    end
    else if (reflectionsDelay <= 1) then
    begin
        reflectionsDelay := 1;
    end;
    pNative.ReflectionsDelay := trunc(reflectionsDelay);

    reverbDelay := pI3DL2.ReverbDelay * 1000.0;
    ;
    if (reverbDelay >= XAUDIO2FX_REVERB_MAX_REVERB_DELAY) then // 85
    begin
        reverbDelay := (XAUDIO2FX_REVERB_MAX_REVERB_DELAY - 1);
    end;
    pNative.ReverbDelay := trunc(reverbDelay);

    pNative.ReflectionsGain := pI3DL2.Reflections / 100.0;
    pNative.ReverbGain := pI3DL2.Reverb / 100.0;
    pNative.EarlyDiffusion := trunc(15.0 * pI3DL2.Diffusion / 100.0);
    pNative.LateDiffusion := pNative.EarlyDiffusion;
    pNative.Density := pI3DL2.Density;
    pNative.RoomFilterFreq := pI3DL2.HFReference;

    pNative.WetDryMix := pI3DL2.WetDryMix;
    pNative.DisableLateField := False;
end;


end.
