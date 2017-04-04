unit Win32.X3DAudio;

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
                                - X3DAUDIO -
         Copyright (c) Microsoft Corporation.  All rights reserved.
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 PROJECT: X3DAudio                     MODEL:   Unmanaged User-mode
 VERSION: 1.7                          EXCEPT:  No Exceptions
 CLASS:   N / A                        MINREQ:  WinXP, Xbox360
 BASE:    N / A                        DIALECT: MSC++ 14.00
 >------------------------------------------------------------------------<
  DUTY: Cross-platform stand-alone 3D audio math library
 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
  NOTES:
    1.  Definition of terms:
            LFE: Low Frequency Effect -- always omnidirectional.
            LPF: Low Pass Filter, divided into two classifications:
                 Direct -- Applied to the direct signal path,
                           used for obstruction/occlusion effects.
                 Reverb -- Applied to the reverb signal path,
                           used for occlusion effects only.

    2.  Volume level is expressed as a linear amplitude scaler:
        1.0f represents no attenuation applied to the original signal,
        0.5f denotes an attenuation of 6dB, and 0.0f results in silence.
        Amplification (volume > 1.0f) is also allowed, and is not clamped.

        LPF values range from 1.0f representing all frequencies pass through,
        to 0.0f which results in silence as all frequencies are filtered out.

    3.  X3DAudio uses a left-handed Cartesian coordinate system with values
        on the x-axis increasing from left to right, on the y-axis from
        bottom to top, and on the z-axis from near to far.
        Azimuths are measured clockwise from a given reference direction.

        Distance measurement is with respect to user-defined world units.
        Applications may provide coordinates using any system of measure
        as all non-normalized calculations are scale invariant, with such
        operations natively occurring in user-defined world unit space.
        Metric constants are supplied only as a convenience.
        Distance is calculated using the Euclidean norm formula.

    4.  Only real values are permissible with functions using 32-bit
        float parameters -- NAN and infinite values are not accepted.
        All computation occurs in 32-bit precision mode.                    }


{ Header Definition: 10.0.14393.0 }

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}


interface

uses
    Windows, Classes,
    Win32.DirectXMath;

{$if(_WIN32_WINNT < _WIN32_WINNT_WIN8)}
{$error This version of XAudio2 is available only in Windows 8 or later. Use the XAudio2 headers and libraries from the DirectX SDK with applications that target Windows 7 and earlier versions.}
{$endif}// (_WIN32_WINNT < _WIN32_WINNT_WIN8)


{$if (DEFINED(WINAPI_PARTITION_APP) or DEFINED(WINAPI_PARTITION_TV_APP) or DEFINED(WINAPI_PARTITION_TV_TITLE))}

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

//--------------<D-E-F-I-N-I-T-I-O-N-S>-------------------------------------//

// speaker geometry configuration flags, specifies assignment of channels to speaker positions, defined as per WAVEFORMATEXTENSIBLE.dwChannelMask


const
    SPEAKER_FRONT_LEFT = $00000001;
    SPEAKER_FRONT_RIGHT = $00000002;
    SPEAKER_FRONT_CENTER = $00000004;
    SPEAKER_LOW_FREQUENCY = $00000008;
    SPEAKER_BACK_LEFT = $00000010;
    SPEAKER_BACK_RIGHT = $00000020;
    SPEAKER_FRONT_LEFT_OF_CENTER = $00000040;
    SPEAKER_FRONT_RIGHT_OF_CENTER = $00000080;
    SPEAKER_BACK_CENTER = $00000100;
    SPEAKER_SIDE_LEFT = $00000200;
    SPEAKER_SIDE_RIGHT = $00000400;
    SPEAKER_TOP_CENTER = $00000800;
    SPEAKER_TOP_FRONT_LEFT = $00001000;
    SPEAKER_TOP_FRONT_CENTER = $00002000;
    SPEAKER_TOP_FRONT_RIGHT = $00004000;
    SPEAKER_TOP_BACK_LEFT = $00008000;
    SPEAKER_TOP_BACK_CENTER = $00010000;
    SPEAKER_TOP_BACK_RIGHT = $00020000;
    SPEAKER_RESERVED = $7FFC0000;// bit mask locations reserved for future use
    SPEAKER_ALL = $80000000; // used to specify that any possible permutation of speaker configurations


    // standard speaker geometry configurations, used with X3DAudioInitialize

    SPEAKER_MONO = SPEAKER_FRONT_CENTER;
    SPEAKER_STEREO = (SPEAKER_FRONT_LEFT or SPEAKER_FRONT_RIGHT);
    SPEAKER_2POINT1 = (SPEAKER_FRONT_LEFT or SPEAKER_FRONT_RIGHT or SPEAKER_LOW_FREQUENCY);
    SPEAKER_SURROUND = (SPEAKER_FRONT_LEFT or SPEAKER_FRONT_RIGHT or SPEAKER_FRONT_CENTER or SPEAKER_BACK_CENTER);
    SPEAKER_QUAD = (SPEAKER_FRONT_LEFT or SPEAKER_FRONT_RIGHT or SPEAKER_BACK_LEFT or SPEAKER_BACK_RIGHT);
    SPEAKER_4POINT1 = (SPEAKER_FRONT_LEFT or SPEAKER_FRONT_RIGHT or SPEAKER_LOW_FREQUENCY or SPEAKER_BACK_LEFT or SPEAKER_BACK_RIGHT);
    SPEAKER_5POINT1 = (SPEAKER_FRONT_LEFT or SPEAKER_FRONT_RIGHT or SPEAKER_FRONT_CENTER or SPEAKER_LOW_FREQUENCY or
        SPEAKER_BACK_LEFT or SPEAKER_BACK_RIGHT);
    SPEAKER_7POINT1 = (SPEAKER_FRONT_LEFT or SPEAKER_FRONT_RIGHT or SPEAKER_FRONT_CENTER or SPEAKER_LOW_FREQUENCY or
        SPEAKER_BACK_LEFT or SPEAKER_BACK_RIGHT or SPEAKER_FRONT_LEFT_OF_CENTER or SPEAKER_FRONT_RIGHT_OF_CENTER);
    SPEAKER_5POINT1_SURROUND = (SPEAKER_FRONT_LEFT or SPEAKER_FRONT_RIGHT or SPEAKER_FRONT_CENTER or SPEAKER_LOW_FREQUENCY or
        SPEAKER_SIDE_LEFT or SPEAKER_SIDE_RIGHT);
    SPEAKER_7POINT1_SURROUND = (SPEAKER_FRONT_LEFT or SPEAKER_FRONT_RIGHT or SPEAKER_FRONT_CENTER or SPEAKER_LOW_FREQUENCY or
        SPEAKER_BACK_LEFT or SPEAKER_BACK_RIGHT or SPEAKER_SIDE_LEFT or SPEAKER_SIDE_RIGHT);


    // size of instance handle in bytes
    X3DAUDIO_HANDLE_BYTESIZE = 20;

    // float math constants
    X3DAUDIO_PI = 3.141592654;
    X3DAUDIO_2PI = 6.283185307;

    // speed of sound in meters per second for dry air at approximately 20C, used with X3DAudioInitialize
    X3DAUDIO_SPEED_OF_SOUND = 343.5;

    // calculation control flags, used with X3DAudioCalculate
    X3DAUDIO_CALCULATE_MATRIX = $00000001; // enable matrix coefficient table calculation
    X3DAUDIO_CALCULATE_DELAY = $00000002; // enable delay time array calculation (stereo final mix only)
    X3DAUDIO_CALCULATE_LPF_DIRECT = $00000004; // enable LPF direct-path coefficient calculation
    X3DAUDIO_CALCULATE_LPF_REVERB = $00000008; // enable LPF reverb-path coefficient calculation
    X3DAUDIO_CALCULATE_REVERB = $00000010; // enable reverb send level calculation
    X3DAUDIO_CALCULATE_DOPPLER = $00000020; // enable doppler shift factor calculation
    X3DAUDIO_CALCULATE_EMITTER_ANGLE = $00000040; // enable emitter-to-listener interior angle calculation

    X3DAUDIO_CALCULATE_ZEROCENTER = $00010000;
    // do not position to front center speaker, signal positioned to remaining speakers instead, front center destination channel will be zero in returned matrix coefficient table, valid only for matrix calculations with final mix formats that have a front center channel
    X3DAUDIO_CALCULATE_REDIRECT_TO_LFE = $00020000;
// apply equal mix of all source channels to LFE destination channel, valid only for matrix calculations with sources that have no LFE channel and final mix formats that have an LFE channel


//--------------<D-A-T-A---T-Y-P-E-S>---------------------------------------//
//pragma pack(push, 1) // set packing alignment to ensure consistency across arbitrary build environments
{$A1}



// primitive types
type
    FLOAT32 = single; // 32-bit IEEE float
    PFLOAT32 = ^FLOAT32;

    TX3DAUDIO_VECTOR = TXMFLOAT3; // float 3D vector

    // instance handle of precalculated constants
    TX3DAUDIO_HANDLE = array [0..X3DAUDIO_HANDLE_BYTESIZE - 1] of byte;


    // Distance curve point:
    // Defines a DSP setting at a given normalized distance.
    TX3DAUDIO_DISTANCE_CURVE_POINT = record
        Distance: FLOAT32;   // normalized distance, must be within [0.0f, 1.0f]
        DSPSetting: FLOAT32; // DSP setting
    end;
    PX3DAUDIO_DISTANCE_CURVE_POINT = ^TX3DAUDIO_DISTANCE_CURVE_POINT;

    // Distance curve:
    // A piecewise curve made up of linear segments used to
    // define DSP behaviour with respect to normalized distance.

    // Note that curve point distances are normalized within [0.0f, 1.0f].
    // X3DAUDIO_EMITTER.CurveDistanceScaler must be used to scale the
    // normalized distances to user-defined world units.
    // For distances beyond CurveDistanceScaler * 1.0f,
    // pPoints[PointCount-1].DSPSetting is used as the DSP setting.

    // All distance curve spans must be such that:
    //      pPoints[k-1].DSPSetting + ((pPoints[k].DSPSetting-pPoints[k-1].DSPSetting) / (pPoints[k].Distance-pPoints[k-1].Distance)) * (pPoints[k].Distance-pPoints[k-1].Distance) != NAN or infinite values
    // For all points in the distance curve where 1 <= k < PointCount.
    TX3DAUDIO_DISTANCE_CURVE = record
        pPoints: PX3DAUDIO_DISTANCE_CURVE_POINT;
        // distance curve point array, must have at least PointCount elements with no duplicates and be sorted in ascending order with respect to Distance
        PointCount: UINT32;
        // number of distance curve points, must be >= 2 as all distance curves must have at least two endpoints, defining DSP settings at 0.0f and 1.0f normalized distance
    end;
    PX3DAUDIO_DISTANCE_CURVE = ^TX3DAUDIO_DISTANCE_CURVE;

const
    X3DAudioDefault_LinearCurvePoints: array[0..1] of TX3DAUDIO_DISTANCE_CURVE_POINT = ((Distance: 0.0; DSPSetting: 1.0), (Distance: 1.0; DSPSetting: 0.0));
    X3DAudioDefault_LinearCurve: TX3DAUDIO_DISTANCE_CURVE = (pPoints: @X3DAudioDefault_LinearCurvePoints[0]; PointCount: 2);

// Cone:
// Specifies directionality for a listener or single-channel emitter by
// modifying DSP behaviour with respect to its front orientation.
// This is modeled using two sound cones: an inner cone and an outer cone.
// On/within the inner cone, DSP settings are scaled by the inner values.
// On/beyond the outer cone, DSP settings are scaled by the outer values.
// If on both the cones, DSP settings are scaled by the inner values only.
// Between the two cones, the scaler is linearly interpolated between the
// inner and outer values.  Set both cone angles to 0 or X3DAUDIO_2PI for
// omnidirectionality using only the outer or inner values respectively.
type
    TX3DAUDIO_CONE = record
        InnerAngle: FLOAT32; // inner cone angle in radians, must be within [0.0f, X3DAUDIO_2PI]
        OuterAngle: FLOAT32; // outer cone angle in radians, must be within [InnerAngle, X3DAUDIO_2PI]

        InnerVolume: FLOAT32; // volume level scaler on/within inner cone, used only for matrix calculations, must be within [0.0f, 2.0f] when used
        OuterVolume: FLOAT32; // volume level scaler on/beyond outer cone, used only for matrix calculations, must be within [0.0f, 2.0f] when used
        InnerLPF: FLOAT32;
        // LPF (both direct and reverb paths) coefficient subtrahend on/within inner cone, used only for LPF (both direct and reverb paths) calculations, must be within [0.0f, 1.0f] when used
        OuterLPF: FLOAT32;
        // LPF (both direct and reverb paths) coefficient subtrahend on/beyond outer cone, used only for LPF (both direct and reverb paths) calculations, must be within [0.0f, 1.0f] when used
        InnerReverb: FLOAT32; // reverb send level scaler on/within inner cone, used only for reverb calculations, must be within [0.0f, 2.0f] when used
        OuterReverb: FLOAT32; // reverb send level scaler on/beyond outer cone, used only for reverb calculations, must be within [0.0f, 2.0f] when used
    end;
    PX3DAUDIO_CONE = ^TX3DAUDIO_CONE;

const
    X3DAudioDefault_DirectionalCone: TX3DAUDIO_CONE = (InnerAngle: X3DAUDIO_PI / 2; OuterAngle: X3DAUDIO_PI; InnerVolume: 1.0;
        OuterVolume: 0.708; InnerLPF: 0.0;
        OuterLPF: 0.25; InnerReverb: 0.708; OuterReverb: 1.0);


// Listener:
// Defines a point of 3D audio reception.

// The cone is directed by the listener's front orientation.
type
    TX3DAUDIO_LISTENER = record
        OrientFront: TX3DAUDIO_VECTOR;
        // orientation of front direction, used only for matrix and delay calculations or listeners with cones for matrix, LPF (both direct and reverb paths), and reverb calculations, must be normalized when used
        OrientTop: TX3DAUDIO_VECTOR;
        // orientation of top direction, used only for matrix and delay calculations, must be orthonormal with OrientFront when used

        Position: TX3DAUDIO_VECTOR; // position in user-defined world units, does not affect Velocity
        Velocity: TX3DAUDIO_VECTOR; // velocity vector in user-defined world units/second, used only for doppler calculations, does not affect Position

        pCone: PX3DAUDIO_CONE; // sound cone, used only for matrix, LPF (both direct and reverb paths), and reverb calculations, NULL specifies omnidirectionality
    end;
    PX3DAUDIO_LISTENER = ^TX3DAUDIO_LISTENER;

    // Emitter:
    // Defines a 3D audio source, divided into two classifications:

    // Single-point -- For use with single-channel sounds.
    //                 Positioned at the emitter base, i.e. the channel radius
    //                 and azimuth are ignored if the number of channels == 1.

    //                 May be omnidirectional or directional using a cone.
    //                 The cone originates from the emitter base position,
    //                 and is directed by the emitter's front orientation.

    // Multi-point  -- For use with multi-channel sounds.
    //                 Each non-LFE channel is positioned using an
    //                 azimuth along the channel radius with respect to the
    //                 front orientation vector in the plane orthogonal to the
    //                 top orientation vector.  An azimuth of X3DAUDIO_2PI
    //                 specifies a channel is an LFE.  Such channels are
    //                 positioned at the emitter base and are calculated
    //                 with respect to pLFECurve only, never pVolumeCurve.

    //                 Multi-point emitters are always omnidirectional,
    //                 i.e. the cone is ignored if the number of channels > 1.

    // Note that many properties are shared among all channel points,
    // locking certain behaviour with respect to the emitter base position.
    // For example, doppler shift is always calculated with respect to the
    // emitter base position and so is constant for all its channel points.
    // Distance curve calculations are also with respect to the emitter base
    // position, with the curves being calculated independently of each other.
    // For instance, volume and LFE calculations do not affect one another.
    TX3DAUDIO_EMITTER = record
        pCone: PX3DAUDIO_CONE;
        // sound cone, used only with single-channel emitters for matrix, LPF (both direct and reverb paths), and reverb calculations, NULL specifies omnidirectionality
        OrientFront: TX3DAUDIO_VECTOR;
        // orientation of front direction, used only for emitter angle calculations or with multi-channel emitters for matrix calculations or single-channel emitters with cones for matrix, LPF (both direct and reverb paths), and reverb calculations, must be normalized when used
        OrientTop: TX3DAUDIO_VECTOR;
        // orientation of top direction, used only with multi-channel emitters for matrix calculations, must be orthonormal with OrientFront when used

        Position: TX3DAUDIO_VECTOR; // position in user-defined world units, does not affect Velocity
        Velocity: TX3DAUDIO_VECTOR; // velocity vector in user-defined world units/second, used only for doppler calculations, does not affect Position

        InnerRadius: FLOAT32;      // inner radius, must be within [0.0f, FLT_MAX]
        InnerRadiusAngle: FLOAT32; // inner radius angle, must be within [0.0f, X3DAUDIO_PI/4.0)

        ChannelCount: UINT32;       // number of sound channels, must be > 0
        ChannelRadius: FLOAT32;     // channel radius, used only with multi-channel emitters for matrix calculations, must be >= 0.0f when used
        pChannelAzimuths: PFLOAT32;
        // channel azimuth array, used only with multi-channel emitters for matrix calculations, contains positions of each channel expressed in radians along the channel radius with respect to the front orientation vector in the plane orthogonal to the top orientation vector, or X3DAUDIO_2PI to specify an LFE channel, must have at least ChannelCount elements, all within [0.0f, X3DAUDIO_2PI] when used

        pVolumeCurve: PX3DAUDIO_DISTANCE_CURVE;
        // volume level distance curve, used only for matrix calculations, NULL specifies a default curve that conforms to the inverse square law, calculated in user-defined world units with distances <= CurveDistanceScaler clamped to no attenuation
        pLFECurve: PX3DAUDIO_DISTANCE_CURVE;
        // LFE level distance curve, used only for matrix calculations, NULL specifies a default curve that conforms to the inverse square law, calculated in user-defined world units with distances <= CurveDistanceScaler clamped to no attenuation
        pLPFDirectCurve: PX3DAUDIO_DISTANCE_CURVE;
        // LPF direct-path coefficient distance curve, used only for LPF direct-path calculations, NULL specifies the default curve: [0.0f,1.0f], [1.0f,0.75f]
        pLPFReverbCurve: PX3DAUDIO_DISTANCE_CURVE;
        // LPF reverb-path coefficient distance curve, used only for LPF reverb-path calculations, NULL specifies the default curve: [0.0f,0.75f], [1.0f,0.75f]
        pReverbCurve: PX3DAUDIO_DISTANCE_CURVE;
        // reverb send level distance curve, used only for reverb calculations, NULL specifies the default curve: [0.0f,1.0f], [1.0f,0.0f]

        CurveDistanceScaler: FLOAT32;
        // curve distance scaler, used to scale normalized distance curves to user-defined world units and/or exaggerate their effect, used only for matrix, LPF (both direct and reverb paths), and reverb calculations, must be within [FLT_MIN, FLT_MAX] when used
        DopplerScaler: FLOAT32;
        // doppler shift scaler, used to exaggerate doppler shift effect, used only for doppler calculations, must be within [0.0f, FLT_MAX] when used
    end;
    PX3DAUDIO_EMITTER = ^TX3DAUDIO_EMITTER;


    // DSP settings:
    // Receives results from a call to X3DAudioCalculate to be sent
    // to the low-level audio rendering API for 3D signal processing.

    // The user is responsible for allocating the matrix coefficient table,
    // delay time array, and initializing the channel counts when used.
    TX3DAUDIO_DSP_SETTINGS = record
        pMatrixCoefficients: PFLOAT32;
        // [inout] matrix coefficient table, receives an array representing the volume level used to send from source channel S to destination channel D, stored as pMatrixCoefficients[SrcChannelCount * D + S], must have at least SrcChannelCount*DstChannelCount elements
        pDelayTimes: PFLOAT32;
        // [inout] delay time array, receives delays for each destination channel in milliseconds, must have at least DstChannelCount elements (stereo final mix only)
        SrcChannelCount: UINT32;       // [in] number of source channels, must equal number of channels in respective emitter
        DstChannelCount: UINT32;       // [in] number of destination channels, must equal number of channels of the final mix

        LPFDirectCoefficient: FLOAT32; // [out] LPF direct-path coefficient
        LPFReverbCoefficient: FLOAT32; // [out] LPF reverb-path coefficient
        ReverbLevel: FLOAT32; // [out] reverb send level
        DopplerFactor: FLOAT32;
        // [out] doppler shift factor, scales resampler ratio for doppler shift effect, where the effective frequency = DopplerFactor * original frequency
        EmitterToListenerAngle: FLOAT32; // [out] emitter-to-listener interior angle, expressed in radians with respect to the emitter's front orientation

        EmitterToListenerDistance: FLOAT32; // [out] distance in user-defined world units from the emitter base to listener position, always calculated
        EmitterVelocityComponent: FLOAT32;
        // [out] component of emitter velocity vector projected onto emitter->listener vector in user-defined world units/second, calculated only for doppler
        ListenerVelocityComponent: FLOAT32;
        // [out] component of listener velocity vector projected onto emitter->listener vector in user-defined world units/second, calculated only for doppler
    end;
    PX3DAUDIO_DSP_SETTINGS = ^TX3DAUDIO_DSP_SETTINGS;



//--------------<F-U-N-C-T-I-O-N-S>-----------------------------------------//
// initializes instance handle
function X3DAudioInitialize(SpeakerChannelMask: UINT32; SpeedOfSound: FLOAT32; out Instance: TX3DAUDIO_HANDLE): HResult; external XAudio2_DLL;

// calculates DSP settings with respect to 3D parameters
procedure X3DAudioCalculate(const Instance: TX3DAUDIO_HANDLE; const pListener: TX3DAUDIO_LISTENER; const pEmitter: TX3DAUDIO_EMITTER;
    Flags: UINT32; var pDSPSettings: TX3DAUDIO_DSP_SETTINGS); stdcall; external XAudio2_DLL;


//pragma pack(pop) // revert packing alignment
{$A4}

{$endif}{ WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_APP or WINAPI_PARTITION_TV_APP or WINAPI_PARTITION_TV_TITLE) }


implementation

end.
