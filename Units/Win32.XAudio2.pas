unit Win32.XAudio2;

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
 * File:    xaudio2.h
 * Content: Declarations for the XAudio2 game audio API.
 *
 *************************************************************************}



{ Header Definition: 10.0.14393.0 }

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}

interface

uses
    Windows, Classes,
    Win32.AudioSessionTypes;

{$IF (_WIN32_WINNT < _WIN32_WINNT_WIN8)}
    {$error This version of XAudio2 is available only in Windows 8 or later. Use the XAudio2 headers and libraries from the DirectX SDK with applications that target Windows 7 and earlier versions.}
{$ENDIF}// (_WIN32_WINNT < _WIN32_WINNT_WIN8)


{$IF  (DEFINED(WINAPI_PARTITION_APP) or DEFINED(WINAPI_PARTITION_TV_APP) or DEFINED(WINAPI_PARTITION_TV_TITLE))}

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


const
    M_PI = 3.14159265358979323846;

{*************************************************************************
 *
 * XAudio2 COM object class and interface IDs.
 *
 *************************************************************************}

{$IF (_WIN32_WINNT >= _WIN32_WINNT_WIN10)}
    // XAudio 2.9
    IID_IXAudio2: TGUID = '{2B02E3CF-2E0B-4ec3-BE45-1B2A3FE7210D}';
{$ELSE}
    // XAudio 2.8
    IID_IXAudio2: TGUID = '{60d8dac8-5aa1-4e8e-b597-2f5e2883d484}';
{$ENDIF}


// Ignore the rest of this header if only the GUID definitions were requested
//include <objbase.h>           // Windows COM declarations
//include <sal.h>               // Markers for documenting API semantics
//include <mmreg.h>             // Basic data types and constants for audio work
//include <audiosessiontypes.h> // For AUDIO_STREAM_CATEGORY

type
    TWAVEFORMATEX = record

        wFormatTag: word;        { format type }
        nChannels: word;         { number of channels (i.e. mono, stereo...) }
        nSamplesPerSec: DWORD;    { sample rate }
        nAvgBytesPerSec: DWORD;   { for buffer estimation }
        nBlockAlign: word;       { block size of data }
        wBitsPerSample: word;    { Number of bits per sample of mono data }
        cbSize: word;            { The count in bytes of the size of
                                    extra information (after cbSize) }
    end;

// All structures defined in this file use tight field packing
{$A1}
// pragma pack(push, 1)


{*************************************************************************
 *
 * XAudio2 constants, flags and error codes.
 *
 *************************************************************************}

// Numeric boundary values
const
    XAUDIO2_MAX_BUFFER_BYTES = $80000000;   // Maximum bytes allowed in a source buffer
    XAUDIO2_MAX_QUEUED_BUFFERS = 64;          // Maximum buffers allowed in a voice queue
    XAUDIO2_MAX_BUFFERS_SYSTEM = 2;            // Maximum buffers allowed for system threads (Xbox 360 only)
    XAUDIO2_MAX_AUDIO_CHANNELS = 64;           // Maximum channels in an audio stream
    XAUDIO2_MIN_SAMPLE_RATE = 1000;          // Minimum audio sample rate supported
    XAUDIO2_MAX_SAMPLE_RATE = 200000;        // Maximum audio sample rate supported
    XAUDIO2_MAX_VOLUME_LEVEL = 16777216.0;   // Maximum acceptable volume level (2^24)
    XAUDIO2_MIN_FREQ_RATIO = (1 / 1024.0);   // Minimum SetFrequencyRatio argument
    XAUDIO2_MAX_FREQ_RATIO = 1024.0;       // Maximum MaxFrequencyRatio argument
    XAUDIO2_DEFAULT_FREQ_RATIO = 2.0;          // Default MaxFrequencyRatio argument
    XAUDIO2_MAX_FILTER_ONEOVERQ = 1.5;          // Maximum XAUDIO2_FILTER_PARAMETERS.OneOverQ
    XAUDIO2_MAX_FILTER_FREQUENCY = 1.0;          // Maximum XAUDIO2_FILTER_PARAMETERS.Frequency
    XAUDIO2_MAX_LOOP_COUNT = 254;          // Maximum non-infinite XAUDIO2_BUFFER.LoopCount
    XAUDIO2_MAX_INSTANCES = 8;         // Maximum simultaneous XAudio2 objects on Xbox 360

    // For XMA voices on Xbox 360 there is an additional restriction on the MaxFrequencyRatio
    // argument and the voice's sample rate: the product of these numbers cannot exceed 600000
    // for one-channel voices or 300000 for voices with more than one channel.
    XAUDIO2_MAX_RATIO_TIMES_RATE_XMA_MONO = 600000;
    XAUDIO2_MAX_RATIO_TIMES_RATE_XMA_MULTICHANNEL = 300000;

    // Numeric values with special meanings
    XAUDIO2_COMMIT_NOW = 0;         // Used as an OperationSet argument
    XAUDIO2_COMMIT_ALL = 0;          // Used in IXAudio2::CommitChanges
    XAUDIO2_INVALID_OPSET = UINT32(-1);  // Not allowed for OperationSet arguments
    XAUDIO2_NO_LOOP_REGION = 0;       // Used in XAUDIO2_BUFFER.LoopCount
    XAUDIO2_LOOP_INFINITE = 255;        // Used in XAUDIO2_BUFFER.LoopCount
    XAUDIO2_DEFAULT_CHANNELS = 0;          // Used in CreateMasteringVoice
    XAUDIO2_DEFAULT_SAMPLERATE = 0;           // Used in CreateMasteringVoice

    // Flags
    XAUDIO2_DEBUG_ENGINE = $0001;    // Used in XAudio2Create
    XAUDIO2_VOICE_NOPITCH = $0002;    // Used in IXAudio2::CreateSourceVoice
    XAUDIO2_VOICE_NOSRC = $0004;    // Used in IXAudio2::CreateSourceVoice
    XAUDIO2_VOICE_USEFILTER = $0008;    // Used in IXAudio2::CreateSource/SubmixVoice
    XAUDIO2_PLAY_TAILS = $0020;    // Used in IXAudio2SourceVoice::Stop
    XAUDIO2_END_OF_STREAM = $0040;    // Used in XAUDIO2_BUFFER.Flags
    XAUDIO2_SEND_USEFILTER = $0080;    // Used in XAUDIO2_SEND_DESCRIPTOR.Flags
    XAUDIO2_VOICE_NOSAMPLESPLAYED = $0100;    // Used in IXAudio2SourceVoice::GetState
    XAUDIO2_STOP_ENGINE_WHEN_IDLE = $2000;
    // Used in XAudio2Create to force the engine to Stop when no source voices are Started, and Start when a voice is Started
    XAUDIO2_1024_QUANTUM = $8000;    // Used in XAudio2Create to specify nondefault processing quantum of 21.33 ms (1024 samples at 48KHz)
    XAUDIO2_NO_VIRTUAL_AUDIO_CLIENT = $10000;   // Used in CreateMasteringVoice to create a virtual audio client

    // Default parameters for the built-in filter
    //ToDo XAUDIO2_DEFAULT_FILTER_TYPE    = LowPassFilter;
    XAUDIO2_DEFAULT_FILTER_FREQUENCY = XAUDIO2_MAX_FILTER_FREQUENCY;
    XAUDIO2_DEFAULT_FILTER_ONEOVERQ = 1.0;

    // Internal XAudio2 constants
    // The audio frame quantum can be calculated by reducing the fraction:
    //     SamplesPerAudioFrame / SamplesPerSecond
    XAUDIO2_QUANTUM_NUMERATOR = 1;             // On Windows, XAudio2 processes audio
    XAUDIO2_QUANTUM_DENOMINATOR = 100;             //  in 10ms chunks (= 1/100 seconds)
    XAUDIO2_QUANTUM_MS = (1000.0 * XAUDIO2_QUANTUM_NUMERATOR / XAUDIO2_QUANTUM_DENOMINATOR);

    // XAudio2 error codes
    FACILITY_XAUDIO2 = $896;
    XAUDIO2_E_INVALID_CALL = $88960001;   // An API call or one of its arguments was illegal
    XAUDIO2_E_XMA_DECODER_ERROR = $88960002;   // The XMA hardware suffered an unrecoverable error
    XAUDIO2_E_XAPO_CREATION_FAILED = $88960003;   // XAudio2 failed to initialize an XAPO effect
    XAUDIO2_E_DEVICE_INVALIDATED = $88960004;   // An audio device became unusable (unplugged, etc)


{*************************************************************************
 *
 * XAudio2 structures and enumerations.
 *
 *************************************************************************}

// Used in XAudio2Create, specifies which CPU(s) to use.
type
    TXAUDIO2_PROCESSOR = UINT32;

const
    Processor1 = $00000001;
    Processor2 = $00000002;
    Processor3 = $00000004;
    Processor4 = $00000008;
    Processor5 = $00000010;
    Processor6 = $00000020;
    Processor7 = $00000040;
    Processor8 = $00000080;
    Processor9 = $00000100;
    Processor10 = $00000200;
    Processor11 = $00000400;
    Processor12 = $00000800;
    Processor13 = $00001000;
    Processor14 = $00002000;
    Processor15 = $00004000;
    Processor16 = $00008000;
    Processor17 = $00010000;
    Processor18 = $00020000;
    Processor19 = $00040000;
    Processor20 = $00080000;
    Processor21 = $00100000;
    Processor22 = $00200000;
    Processor23 = $00400000;
    Processor24 = $00800000;
    Processor25 = $01000000;
    Processor26 = $02000000;
    Processor27 = $04000000;
    Processor28 = $08000000;
    Processor29 = $10000000;
    Processor30 = $20000000;
    Processor31 = $40000000;
    Processor32 = $80000000;
    XAUDIO2_ANY_PROCESSOR = $ffffffff;
    XAUDIO2_DEFAULT_PROCESSOR = Processor1;

// Values for the TraceMask and BreakMask bitmaps.  Only ERRORS and WARNINGS
// are valid in BreakMask.  WARNINGS implies ERRORS, DETAIL implies INFO, and
// FUNC_CALLS implies API_CALLS.  By default, TraceMask is ERRORS and WARNINGS
// and all the other settings are zero.
const
    XAUDIO2_LOG_ERRORS = $0001;   // For handled errors with serious effects.
    XAUDIO2_LOG_WARNINGS = $0002;   // For handled errors that may be recoverable.
    XAUDIO2_LOG_INFO = $0004;  // Informational chit-chat (e.g. state changes).
    XAUDIO2_LOG_DETAIL = $0008;   // More detailed chit-chat.
    XAUDIO2_LOG_API_CALLS = $0010;   // Public API function entries and exits.
    XAUDIO2_LOG_FUNC_CALLS = $0020;   // Internal function entries and exits.
    XAUDIO2_LOG_TIMING = $0040;   // Delays detected and other timing data.
    XAUDIO2_LOG_LOCKS = $0080;   // Usage of critical sections and mutexes.
    XAUDIO2_LOG_MEMORY = $0100;   // Memory heap usage information.
    XAUDIO2_LOG_STREAMING = $1000;   // Audio streaming information.

type

    IXAudio2Voice = class;
    IXAudio2EngineCallback = class;
    IXAudio2SourceVoice = class;
    IXAudio2SubmixVoice = class;
    IXAudio2VoiceCallback = class;
    IXAudio2MasteringVoice = class;

    // Returned by IXAudio2Voice::GetVoiceDetails
    TXAUDIO2_VOICE_DETAILS = record
        CreationFlags: UINT32;               // Flags the voice was created with.
        ActiveFlags: UINT32;                 // Flags currently active.
        InputChannels: UINT32;               // Channels in the voice's input audio.
        InputSampleRate: UINT32;             // Sample rate of the voice's input audio.
    end;
    PXAUDIO2_VOICE_DETAILS = ^TXAUDIO2_VOICE_DETAILS;

    // Used in XAUDIO2_VOICE_SENDS below
    TXAUDIO2_SEND_DESCRIPTOR = record
        Flags: UINT32;                       // Either 0 or XAUDIO2_SEND_USEFILTER.
        pOutputVoice: IXAudio2Voice;        // This send's destination voice.
    end;
    PXAUDIO2_SEND_DESCRIPTOR = ^TXAUDIO2_SEND_DESCRIPTOR;

    // Used in the voice creation functions and in IXAudio2Voice::SetOutputVoices
    TXAUDIO2_VOICE_SENDS = record
        SendCount: UINT32;                   // Number of sends from this voice.
        pSends: PXAUDIO2_SEND_DESCRIPTOR;    // Array of SendCount send descriptors.
    end;
    PXAUDIO2_VOICE_SENDS = ^TXAUDIO2_VOICE_SENDS;

    // Used in XAUDIO2_EFFECT_CHAIN below
    TXAUDIO2_EFFECT_DESCRIPTOR = record
        pEffect: IUnknown;                  // Pointer to the effect object's IUnknown interface.
        InitialState: boolean;                  // TRUE if the effect should begin in the enabled state.
        OutputChannels: UINT32;              // How many output channels the effect should produce.
    end;
    PXAUDIO2_EFFECT_DESCRIPTOR = ^TXAUDIO2_EFFECT_DESCRIPTOR;

    // Used in the voice creation functions and in IXAudio2Voice::SetEffectChain
    TXAUDIO2_EFFECT_CHAIN = record
        EffectCount: UINT32;                 // Number of effects in this voice's effect chain.
        pEffectDescriptors: PXAUDIO2_EFFECT_DESCRIPTOR; // Array of effect descriptors.
    end;
    PXAUDIO2_EFFECT_CHAIN = ^TXAUDIO2_EFFECT_CHAIN;

    // Used in XAUDIO2_FILTER_PARAMETERS below
    TXAUDIO2_FILTER_TYPE = (
        LowPassFilter,                      // Attenuates frequencies above the cutoff frequency (state-variable filter).
        BandPassFilter,                     // Attenuates frequencies outside a given range      (state-variable filter).
        HighPassFilter,                     // Attenuates frequencies below the cutoff frequency (state-variable filter).
        NotchFilter,                        // Attenuates frequencies inside a given range       (state-variable filter).
        LowPassOnePoleFilter,               // Attenuates frequencies above the cutoff frequency (one-pole filter, XAUDIO2_FILTER_PARAMETERS.OneOverQ has no effect)
        HighPassOnePoleFilter               // Attenuates frequencies below the cutoff frequency (one-pole filter, XAUDIO2_FILTER_PARAMETERS.OneOverQ has no effect)
        );
    PXAUDIO2_FILTER_TYPE = ^TXAUDIO2_FILTER_TYPE;

    // Used in IXAudio2Voice::Set/GetFilterParameters and Set/GetOutputFilterParameters
    TXAUDIO2_FILTER_PARAMETERS = record
        FilterType: TXAUDIO2_FILTER_TYPE;           // Filter type.
        Frequency: single;                    // Filter coefficient.
        //  must be >= 0 and <= XAUDIO2_MAX_FILTER_FREQUENCY
        //  See XAudio2CutoffFrequencyToRadians() for state-variable filter types and
        //  XAudio2CutoffFrequencyToOnePoleCoefficient() for one-pole filter types.
        OneOverQ: single;                     // Reciprocal of the filter's quality factor Q;
        //  must be > 0 and <= XAUDIO2_MAX_FILTER_ONEOVERQ.
        //  Has no effect for one-pole filters.
    end;
    PXAUDIO2_FILTER_PARAMETERS = ^TXAUDIO2_FILTER_PARAMETERS;

    // Used in IXAudio2SourceVoice::SubmitSourceBuffer
    TXAUDIO2_BUFFER = record
        Flags: UINT32;                       // Either 0 or XAUDIO2_END_OF_STREAM.
        AudioBytes: UINT32;                  // Size of the audio data buffer in bytes.
        pAudioData: PBYTE;             // Pointer to the audio data buffer.
        PlayBegin: UINT32;                   // First sample in this buffer to be played.
        PlayLength: UINT32;                  // Length of the region to be played in samples,
        //  or 0 to play the whole buffer.
        LoopBegin: UINT32;                   // First sample of the region to be looped.
        LoopLength: UINT32;                  // Length of the desired loop region in samples,
        //  or 0 to loop the entire buffer.
        LoopCount: UINT32;                   // Number of times to repeat the loop region,
        //  or XAUDIO2_LOOP_INFINITE to loop forever.
        pContext: Pointer;                     // Context value to be passed back in callbacks.
    end;
    PXAUDIO2_BUFFER = ^TXAUDIO2_BUFFER;

    // Used in IXAudio2SourceVoice::SubmitSourceBuffer when submitting XWMA data.
    // NOTE: If an XWMA sound is submitted in more than one buffer, each buffer's
    // pDecodedPacketCumulativeBytes[PacketCount-1] value must be subtracted from
    // all the entries in the next buffer's pDecodedPacketCumulativeBytes array.
    // And whether a sound is submitted in more than one buffer or not, the final
    // buffer of the sound should use the XAUDIO2_END_OF_STREAM flag, or else the
    // client must call IXAudio2SourceVoice::Discontinuity after submitting it.
    TXAUDIO2_BUFFER_WMA = record
        pDecodedPacketCumulativeBytes: PUINT32; // Decoded packet's cumulative size array.
        //  Each element is the number of bytes accumulated
        //  when the corresponding XWMA packet is decoded in
        //  order.  The array must have PacketCount elements.
        PacketCount: UINT32;                          // Number of XWMA packets submitted. Must be >= 1 and
        //  divide evenly into XAUDIO2_BUFFER.AudioBytes.
    end;
    PXAUDIO2_BUFFER_WMA = ^TXAUDIO2_BUFFER_WMA;

    // Returned by IXAudio2SourceVoice::GetState
    TXAUDIO2_VOICE_STATE = record
        pCurrentBufferContext: pointer;        // The pContext value provided in the XAUDIO2_BUFFER
        //  that is currently being processed, or nil if
        //  there are no buffers in the queue.
        BuffersQueued: UINT32;               // Number of buffers currently queued on the voice
        //  (including the one that is being processed).
        SamplesPlayed: UINT64;               // Total number of samples produced by the voice since
        //  it began processing the current audio stream.
        //  If XAUDIO2_VOICE_NOSAMPLESPLAYED is specified
        //  in the call to IXAudio2SourceVoice::GetState,
        //  this member will not be calculated, saving CPU.
    end;
    PXAUDIO2_VOICE_STATE = ^TXAUDIO2_VOICE_STATE;

    // Returned by IXAudio2::GetPerformanceData
    TXAUDIO2_PERFORMANCE_DATA = record
        // CPU usage information
        AudioCyclesSinceLastQuery: UINT64;   // CPU cycles spent on audio processing since the
        //  last call to StartEngine or GetPerformanceData.
        TotalCyclesSinceLastQuery: UINT64;   // Total CPU cycles elapsed since the last call
        //  (only counts the CPU XAudio2 is running on).
        MinimumCyclesPerQuantum: UINT32;     // Fewest CPU cycles spent processing any one
        //  audio quantum since the last call.
        MaximumCyclesPerQuantum: UINT32;     // Most CPU cycles spent processing any one
        //  audio quantum since the last call.

        // Memory usage information
        MemoryUsageInBytes: UINT32;          // Total heap space currently in use.

        // Audio latency and glitching information
        CurrentLatencyInSamples: UINT32;     // Minimum delay from when a sample is read from a
        //  source buffer to when it reaches the speakers.
        GlitchesSinceEngineStarted: UINT32;  // Audio dropouts since the engine was started.

        // Data about XAudio2's current workload
        ActiveSourceVoiceCount: UINT32;      // Source voices currently playing.
        TotalSourceVoiceCount: UINT32;       // Source voices currently existing.
        ActiveSubmixVoiceCount: UINT32;      // Submix voices currently playing/existing.

        ActiveResamplerCount: UINT32;        // Resample xAPOs currently active.
        ActiveMatrixMixCount: UINT32;        // MatrixMix xAPOs currently active.

        // Usage of the hardware XMA decoder (Xbox 360 only)
        ActiveXmaSourceVoices: UINT32;       // Number of source voices decoding XMA data.
        ActiveXmaStreams: UINT32;            // A voice can use more than one XMA stream.
    end;
    PXAUDIO2_PERFORMANCE_DATA = ^TXAUDIO2_PERFORMANCE_DATA;

    // Used in IXAudio2::SetDebugConfiguration
    TXAUDIO2_DEBUG_CONFIGURATION = record
        TraceMask: UINT32;                   // Bitmap of enabled debug message types.
        BreakMask: UINT32;                   // Message types that will break into the debugger.
        LogThreadID: boolean;                   // Whether to log the thread ID with each message.
        LogFileline: boolean;                   // Whether to log the source file and line number.
        LogFunctionName: boolean;               // Whether to log the function name.
        LogTiming: boolean;                     // Whether to log message timestamps.
    end;
    PXAUDIO2_DEBUG_CONFIGURATION = ^TXAUDIO2_DEBUG_CONFIGURATION;




{*************************************************************************
 *
 * IXAudio2: Top-level XAudio2 COM interface.
 *
 *************************************************************************}


    IXAudio2 = interface(IUnknown)
{$IF (_WIN32_WINNT >= _WIN32_WINNT_WIN10)}
        // XAudio 2.9
        ['{2B02E3CF-2E0B-4ec3-BE45-1B2A3FE7210D}']
{$ELSE}
        // XAudio 2.8
        ['{60d8dac8-5aa1-4e8e-b597-2f5e2883d484}']
{$ENDIF}

        // NAME: IXAudio2::RegisterForCallbacks
        // DESCRIPTION: Adds a new client to receive XAudio2's engine callbacks.

        // ARGUMENTS:
        //  pCallback - Callback interface to be called during each processing pass.

        function RegisterForCallbacks(pCallback: IXAudio2EngineCallback): HResult; stdcall;

        // NAME: IXAudio2::UnregisterForCallbacks
        // DESCRIPTION: Removes an existing receiver of XAudio2 engine callbacks.

        // ARGUMENTS:
        //  pCallback - Previously registered callback interface to be removed.

        procedure UnregisterForCallbacks(pCallback: IXAudio2EngineCallback); stdcall;

        // NAME: IXAudio2::CreateSourceVoice
        // DESCRIPTION: Creates and configures a source voice.

        // ARGUMENTS:
        //  ppSourceVoice - Returns the new object's IXAudio2SourceVoice interface.
        //  pSourceFormat - Format of the audio that will be fed to the voice.
        //  Flags - XAUDIO2_VOICE flags specifying the source voice's behavior.
        //  MaxFrequencyRatio - Maximum SetFrequencyRatio argument to be allowed.
        //  pCallback - Optional pointer to a client-provided callback interface.
        //  pSendList - Optional list of voices this voice should send audio to.
        //  pEffectChain - Optional list of effects to apply to the audio data.

        function CreateSourceVoice(out ppSourceVoice: IXAudio2SourceVoice; const pSourceFormat: TWAVEFORMATEX;
            Flags: UINT32 = 0; MaxFrequencyRatio: single = XAUDIO2_DEFAULT_FREQ_RATIO; pCallback: IXAudio2VoiceCallback = nil;
            pSendList: PXAUDIO2_VOICE_SENDS = nil; pEffectChain: PXAUDIO2_EFFECT_CHAIN = nil): HResult; stdcall;

        // NAME: IXAudio2::CreateSubmixVoice
        // DESCRIPTION: Creates and configures a submix voice.

        // ARGUMENTS:
        //  ppSubmixVoice - Returns the new object's IXAudio2SubmixVoice interface.
        //  InputChannels - Number of channels in this voice's input audio data.
        //  InputSampleRate - Sample rate of this voice's input audio data.
        //  Flags - XAUDIO2_VOICE flags specifying the submix voice's behavior.
        //  ProcessingStage - Arbitrary number that determines the processing order.
        //  pSendList - Optional list of voices this voice should send audio to.
        //  pEffectChain - Optional list of effects to apply to the audio data.

        function CreateSubmixVoice(out ppSubmixVoice: IXAudio2SubmixVoice; InputChannels: UINT32; InputSampleRate: UINT32;
            Flags: UINT32 = 0; ProcessingStage: UINT32 = 0; pSendList: PXAUDIO2_VOICE_SENDS = nil;
            pEffectChain: PXAUDIO2_EFFECT_CHAIN = nil): HResult; stdcall;


        // NAME: IXAudio2::CreateMasteringVoice
        // DESCRIPTION: Creates and configures a mastering voice.

        // ARGUMENTS:
        //  ppMasteringVoice - Returns the new object's IXAudio2MasteringVoice interface.
        //  InputChannels - Number of channels in this voice's input audio data.
        //  InputSampleRate - Sample rate of this voice's input audio data.
        //  Flags - XAUDIO2_VOICE flags specifying the mastering voice's behavior.
        //  szDeviceId - Identifier of the device to receive the output audio.
        //  pEffectChain - Optional list of effects to apply to the audio data.
        //  StreamCategory - The audio stream category to use for this mastering voice

        function CreateMasteringVoice(out ppMasteringVoice: IXAudio2MasteringVoice; InputChannels: UINT32 = XAUDIO2_DEFAULT_CHANNELS;
            InputSampleRate: UINT32 = XAUDIO2_DEFAULT_SAMPLERATE; Flags: UINT32 = 0; szDeviceId: LPCWSTR = nil;
            pEffectChain: PXAUDIO2_EFFECT_CHAIN = nil; StreamCategory: TAUDIO_STREAM_CATEGORY = AudioCategory_GameEffects): HResult; stdcall;

        // NAME: IXAudio2::StartEngine
        // DESCRIPTION: Creates and starts the audio processing thread.

        function StartEngine(): HResult; stdcall;

        // NAME: IXAudio2::StopEngine
        // DESCRIPTION: Stops and destroys the audio processing thread.

        procedure StopEngine(); stdcall;

        // NAME: IXAudio2::CommitChanges
        // DESCRIPTION: Atomically applies a set of operations previously tagged
        //              with a given identifier.

        // ARGUMENTS:
        //  OperationSet - Identifier of the set of operations to be applied.

        function CommitChanges(OperationSet: UINT32): HResult; stdcall;

        // NAME: IXAudio2::GetPerformanceData
        // DESCRIPTION: Returns current resource usage details: memory, CPU, etc.

        // ARGUMENTS:
        //  pPerfData - Returns the performance data structure.

        procedure GetPerformanceData(out pPerfData: TXAUDIO2_PERFORMANCE_DATA); stdcall;

        // NAME: IXAudio2::SetDebugConfiguration
        // DESCRIPTION: Configures XAudio2's debug output (in debug builds only).

        // ARGUMENTS:
        //  pDebugConfiguration - Structure describing the debug output behavior.
        //  pReserved - Optional parameter; must be nil.

        procedure SetDebugConfiguration(const pDebugConfiguration: TXAUDIO2_DEBUG_CONFIGURATION; pReserved: pointer = nil); stdcall;
    end;


{*************************************************************************
 *
 * IXAudio2Voice: Base voice management interface.
 *
 *************************************************************************}


    IXAudio2Voice = class // Cannot use 'interface'
    { NAME: IXAudio2Voice::GetVoiceDetails
    // DESCRIPTION: Returns the basic characteristics of this voice.
    //
    // ARGUMENTS:
    //  pVoiceDetails - Returns the voice's details.
    }
        procedure GetVoiceDetails(var pVoiceDetails: TXAUDIO2_VOICE_DETAILS); virtual; stdcall; abstract;

    { NAME: IXAudio2Voice::SetOutputVoices
    // DESCRIPTION: Replaces the set of submix/mastering voices that receive
    //              this voice's output.
    //
    // ARGUMENTS:
    //  pSendList - Optional list of voices this voice should send audio to.
    }
        function SetOutputVoices(pSendList: PXAUDIO2_VOICE_SENDS): HResult; virtual; stdcall; abstract;
    { NAME: IXAudio2Voice::SetEffectChain
    // DESCRIPTION: Replaces this voice's current effect chain with a new one.
    //
    // ARGUMENTS:
    //  pEffectChain - Structure describing the new effect chain to be used.
    }
        function SetEffectChain(const pEffectChain: TXAUDIO2_EFFECT_CHAIN): HResult; virtual; stdcall; abstract;
    { NAME: IXAudio2Voice::EnableEffect
    // DESCRIPTION: Enables an effect in this voice's effect chain.
    //
    // ARGUMENTS:
    //  EffectIndex - Index of an effect within this voice's effect chain.
    //  OperationSet - Used to identify this call as part of a deferred batch.
    }
        function EnableEffect(EffectIndex: UINT32; OperationSet: UINT32 = XAUDIO2_COMMIT_NOW): HResult; virtual; stdcall; abstract;
    { NAME: IXAudio2Voice::DisableEffect
    // DESCRIPTION: Disables an effect in this voice's effect chain.
    //
    // ARGUMENTS:
    //  EffectIndex - Index of an effect within this voice's effect chain.
    //  OperationSet - Used to identify this call as part of a deferred batch.
    }
        function DisableEffect(EffectIndex: UINT32; OperationSet: UINT32 = XAUDIO2_COMMIT_NOW): HResult; virtual; stdcall; abstract;
    { NAME: IXAudio2Voice::GetEffectState
    // DESCRIPTION: Returns the running state of an effect.
    //
    // ARGUMENTS:
    //  EffectIndex - Index of an effect within this voice's effect chain.
    //  pEnabled - Returns the enabled/disabled state of the given effect.
    }
        procedure GetEffectState(EffectIndex: UINT32; out pEnabled: boolean); virtual; stdcall; abstract;
    { NAME: IXAudio2Voice::SetEffectParameters
    // DESCRIPTION: Sets effect-specific parameters.
    //
    // REMARKS: Unlike IXAPOParameters::SetParameters, this method may
    //          be called from any thread.  XAudio2 implements
    //          appropriate synchronization to copy the parameters to the
    //          realtime audio processing thread.
    //
    // ARGUMENTS:
    //  EffectIndex - Index of an effect within this voice's effect chain.
    //  pParameters - Pointer to an effect-specific parameters block.
    //  ParametersByteSize - Size of the pParameters array  in bytes.
    //  OperationSet - Used to identify this call as part of a deferred batch.
    }
        function SetEffectParameters(EffectIndex: UINT32; pParameters: PByte; ParametersByteSize: UINT32;
            OperationSet: UINT32 = XAUDIO2_COMMIT_NOW): HResult;
            virtual; stdcall; abstract;
    { NAME: IXAudio2Voice::GetEffectParameters
    // DESCRIPTION: Obtains the current effect-specific parameters.
    //
    // ARGUMENTS:
    //  EffectIndex - Index of an effect within this voice's effect chain.
    //  pParameters - Returns the current values of the effect-specific parameters.
    //  ParametersByteSize - Size of the pParameters array in bytes.
    }
        function GetEffectParameters(EffectIndex: UINT32; out pParameters: PByte; ParametersByteSize: UINT32): HResult; virtual; stdcall; abstract;
    { NAME: IXAudio2Voice::SetFilterParameters
    // DESCRIPTION: Sets this voice's filter parameters.
    //
    // ARGUMENTS:
    //  pParameters - Pointer to the filter's parameter structure.
    //  OperationSet - Used to identify this call as part of a deferred batch.
    }
        function SetFilterParameters(const pParameters: TXAUDIO2_FILTER_PARAMETERS; OperationSet: UINT32 = XAUDIO2_COMMIT_NOW): HResult;
            virtual; stdcall; abstract;
    { NAME: IXAudio2Voice::GetFilterParameters
    // DESCRIPTION: Returns this voice's current filter parameters.
    //
    // ARGUMENTS:
    //  pParameters - Returns the filter parameters.
    }
        procedure GetFilterParameters(out pParameters: TXAUDIO2_FILTER_PARAMETERS); virtual; stdcall; abstract;
    { NAME: IXAudio2Voice::SetOutputFilterParameters
    // DESCRIPTION: Sets the filter parameters on one of this voice's sends.
    //
    // ARGUMENTS:
    //  pDestinationVoice - Destination voice of the send whose filter parameters will be set.
    //  pParameters - Pointer to the filter's parameter structure.
    //  OperationSet - Used to identify this call as part of a deferred batch.
    }
        function SetOutputFilterParameters(pDestinationVoice: IXAudio2Voice; const pParameters: TXAUDIO2_FILTER_PARAMETERS;
            OperationSet: UINT32 = XAUDIO2_COMMIT_NOW): HResult; virtual; stdcall; abstract;

    { NAME: IXAudio2Voice::GetOutputFilterParameters
    // DESCRIPTION: Returns the filter parameters from one of this voice's sends.
    //
    // ARGUMENTS:
    //  pDestinationVoice - Destination voice of the send whose filter parameters will be read.
    //  pParameters - Returns the filter parameters.
    }
        procedure GetOutputFilterParameters(pDestinationVoice: IXAudio2Voice; out pParameters: TXAUDIO2_FILTER_PARAMETERS);
            virtual; stdcall; abstract;

    { NAME: IXAudio2Voice::SetVolume
    // DESCRIPTION: Sets this voice's overall volume level.
    //
    // ARGUMENTS:
    //  Volume - New overall volume level to be used, as an amplitude factor.
    //  OperationSet - Used to identify this call as part of a deferred batch.
    }
        function SetVolume(Volume: single; OperationSet: UINT32 = XAUDIO2_COMMIT_NOW): HResult; virtual; stdcall; abstract;

    { NAME: IXAudio2Voice::GetVolume
    // DESCRIPTION: Obtains this voice's current overall volume level.
    //
    // ARGUMENTS:
    //  pVolume: Returns the voice's current overall volume level.
    }
        procedure GetVolume(out pVolume: single); virtual; stdcall; abstract;

    { NAME: IXAudio2Voice::SetChannelVolumes
    // DESCRIPTION: Sets this voice's per-channel volume levels.
    //
    // ARGUMENTS:
    //  Channels - Used to confirm the voice's channel count.
    //  pVolumes - Array of per-channel volume levels to be used.
    //  OperationSet - Used to identify this call as part of a deferred batch.
    }
        function SetChannelVolumes(Channels: UINT32; pVolumes: PSingle; OperationSet: UINT32 = XAUDIO2_COMMIT_NOW): HResult;
            virtual; stdcall; abstract;

    { NAME: IXAudio2Voice::GetChannelVolumes
    // DESCRIPTION: Returns this voice's current per-channel volume levels.
    //
    // ARGUMENTS:
    //  Channels - Used to confirm the voice's channel count.
    //  pVolumes - Returns an array of the current per-channel volume levels.
    }
        procedure GetChannelVolumes(Channels: UINT32; out pVolumes: PSingle); virtual; stdcall; abstract;
    { NAME: IXAudio2Voice::SetOutputMatrix
    // DESCRIPTION: Sets the volume levels used to mix from each channel of this
    //              voice's output audio to each channel of a given destination
    //              voice's input audio.
    //
    // ARGUMENTS:
    //  pDestinationVoice - The destination voice whose mix matrix to change.
    //  SourceChannels - Used to confirm this voice's output channel count
    //   (the number of channels produced by the last effect in the chain).
    //  DestinationChannels - Confirms the destination voice's input channels.
    //  pLevelMatrix - Array of [SourceChannels * DestinationChannels] send
    //   levels.  The level used to send from source channel S to destination
    //   channel D should be in pLevelMatrix[S + SourceChannels * D].
    //  OperationSet - Used to identify this call as part of a deferred batch.
    }
        function SetOutputMatrix(pDestinationVoice: IXAudio2Voice; SourceChannels: UINT32; DestinationChannels: UINT32;
            pLevelMatrix: PSingle; OperationSet: UINT32 = XAUDIO2_COMMIT_NOW): HResult; virtual; stdcall; abstract;

    { NAME: IXAudio2Voice::GetOutputMatrix
    // DESCRIPTION: Obtains the volume levels used to send each channel of this
    //              voice's output audio to each channel of a given destination
    //              voice's input audio.
    //
    // ARGUMENTS:
    //  pDestinationVoice - The destination voice whose mix matrix to obtain.
    //  SourceChannels - Used to confirm this voice's output channel count
    //   (the number of channels produced by the last effect in the chain).
    //  DestinationChannels - Confirms the destination voice's input channels.
    //  pLevelMatrix - Array of send levels, as above.
    }
        procedure GetOutputMatrix(pDestinationVoice: IXAudio2Voice; SourceChannels: UINT32; DestinationChannels: UINT32;
            out pLevelMatrix: PSingle); virtual; stdcall; abstract;

    { NAME: IXAudio2Voice::DestroyVoice
    // DESCRIPTION: Destroys this voice, stopping it if necessary and removing
    //              it from the XAudio2 graph.
    }
        procedure DestroyVoice(); virtual; stdcall; abstract;
    end;


{*************************************************************************
 *
 * IXAudio2SourceVoice: Source voice management interface.
 *
 *************************************************************************}

    IXAudio2SourceVoice = class(IXAudio2Voice) // Cannot use 'interface'
        // NAME: IXAudio2SourceVoice::Start
        // DESCRIPTION: Makes this voice start consuming and processing audio.

        // ARGUMENTS:
        //  Flags - Flags controlling how the voice should be started.
        //  OperationSet - Used to identify this call as part of a deferred batch.

        function Start(Flags: UINT32 = 0; OperationSet: UINT32 = XAUDIO2_COMMIT_NOW): HResult; virtual; stdcall; abstract;

        // NAME: IXAudio2SourceVoice::Stop
        // DESCRIPTION: Makes this voice stop consuming audio.

        // ARGUMENTS:
        //  Flags - Flags controlling how the voice should be stopped.
        //  OperationSet - Used to identify this call as part of a deferred batch.

        function Stop(Flags: UINT32 = 0; OperationSet: UINT32 = XAUDIO2_COMMIT_NOW): HResult; virtual; stdcall; abstract;

        // NAME: IXAudio2SourceVoice::SubmitSourceBuffer
        // DESCRIPTION: Adds a new audio buffer to this voice's input queue.

        // ARGUMENTS:
        //  pBuffer - Pointer to the buffer structure to be queued.
        //  pBufferWMA - Additional structure used only when submitting XWMA data.

        function SubmitSourceBuffer(pBuffer: PXAUDIO2_BUFFER; pBufferWMA: PXAUDIO2_BUFFER_WMA = nil): HResult; virtual; stdcall; abstract;

        // NAME: IXAudio2SourceVoice::FlushSourceBuffers
        // DESCRIPTION: Removes all pending audio buffers from this voice's queue.

        function FlushSourceBuffers(): HResult; virtual; stdcall; abstract;

        // NAME: IXAudio2SourceVoice::Discontinuity
        // DESCRIPTION: Notifies the voice of an intentional break in the stream of
        //              audio buffers (e.g. the end of a sound; to prevent XAudio2
        //              from interpreting an empty buffer queue as a glitch.

        function Discontinuity(): HResult; virtual; stdcall; abstract;

        // NAME: IXAudio2SourceVoice::ExitLoop
        // DESCRIPTION: Breaks out of the current loop when its end is reached.

        // ARGUMENTS:
        //  OperationSet - Used to identify this call as part of a deferred batch.

        function ExitLoop(OperationSet: UINT32 = XAUDIO2_COMMIT_NOW): HResult; virtual; stdcall; abstract;

        // NAME: IXAudio2SourceVoice::GetState
        // DESCRIPTION: Returns the number of buffers currently queued on this voice,
        //              the pContext value associated with the currently processing
        //              buffer (if any; and other voice state information.

        // ARGUMENTS:
        //  pVoiceState - Returns the state information.
        //  Flags - Flags controlling what voice state is returned.

        procedure GetState(out pVoiceState: TXAUDIO2_VOICE_STATE; Flags: UINT32 = 0); virtual; stdcall; abstract;

        // NAME: IXAudio2SourceVoice::SetFrequencyRatio
        // DESCRIPTION: Sets this voice's frequency adjustment, i.e. its pitch.

        // ARGUMENTS:
        //  Ratio - Frequency change, expressed as source frequency / target frequency.
        //  OperationSet - Used to identify this call as part of a deferred batch.

        function SetFrequencyRatio(Ratio: single; OperationSet: UINT32 = XAUDIO2_COMMIT_NOW): HResult;
            virtual; stdcall; abstract;

        // NAME: IXAudio2SourceVoice::GetFrequencyRatio
        // DESCRIPTION: Returns this voice's current frequency adjustment ratio.

        // ARGUMENTS:
        //  pRatio - Returns the frequency adjustment.

        procedure GetFrequencyRatio(out pRatio: single); virtual; stdcall; abstract;

        // NAME: IXAudio2SourceVoice::SetSourceSampleRate
        // DESCRIPTION: Reconfigures this voice to treat its source data as being
        //              at a different sample rate than the original one specified
        //              in CreateSourceVoice's pSourceFormat argument.

        // ARGUMENTS:
        //  UINT32 - The intended sample rate of further submitted source data.

        function SetSourceSampleRate(NewSourceSampleRate: UINT32): HResult; virtual; stdcall; abstract;
    end;


{*************************************************************************
 *
 * IXAudio2SubmixVoice: Submixing voice management interface.
 *
 *************************************************************************}


    IXAudio2SubmixVoice = class(IXAudio2Voice) // Cannot use 'interface'
        // There are currently no methods specific to submix voices.
    end;


{*************************************************************************
 *
 * IXAudio2MasteringVoice: Mastering voice management interface.
 *
 *************************************************************************}


    IXAudio2MasteringVoice = class(IXAudio2Voice) // Cannot use 'interface'
        // NAME: IXAudio2MasteringVoice::GetChannelMask
        // DESCRIPTION: Returns the channel mask for this voice

        // ARGUMENTS:
        //  pChannelMask - returns the channel mask for this voice.  This corresponds
        //                 to the dwChannelMask member of WAVEFORMATEXTENSIBLE.

        function GetChannelMask(Out pChannelmask: DWORD): HResult; virtual; stdcall; abstract;
    end;


{*************************************************************************
 *
 * IXAudio2EngineCallback: Client notification interface for engine events.
 *
 * REMARKS: Contains methods to notify the client when certain events happen
 *          in the XAudio2 engine.  This interface should be implemented by
 *          the client.  XAudio2 will call these methods via the interface
 *          pointer provided by the client when it calls
 *          IXAudio2::RegisterForCallbacks.
 *
 *************************************************************************}


    IXAudio2EngineCallback = class // Cannot use 'interface'
        // Called by XAudio2 just before an audio processing pass begins.
        procedure OnProcessingPassStart(); virtual; stdcall; abstract;

        // Called just after an audio processing pass ends.
        procedure OnProcessingPassEnd(); virtual; stdcall; abstract;

        // Called in the event of a critical system error which requires XAudio2
        // to be closed down and restarted.  The error code is given in Error.
        procedure OnCriticalError(Error: HRESULT); virtual; stdcall; abstract;
    end;


{*************************************************************************
 *
 * IXAudio2VoiceCallback: Client notification interface for voice events.
 *
 * REMARKS: Contains methods to notify the client when certain events happen
 *          in an XAudio2 voice.  This interface should be implemented by the
 *          client.  XAudio2 will call these methods via an interface pointer
 *          provided by the client in the IXAudio2::CreateSourceVoice call.
 *
 *************************************************************************}


    IXAudio2VoiceCallback = class // Cannot use 'interface'
        // Called just before this voice's processing pass begins.
        procedure OnVoiceProcessingPassStart(BytesRequired: UINT32); virtual; stdcall; abstract;

        // Called just after this voice's processing pass ends.
        procedure OnVoiceProcessingPassEnd(); virtual; stdcall; abstract;

        // Called when this voice has just finished playing a buffer stream
        // (as marked with the XAUDIO2_END_OF_STREAM flag on the last buffer).
        procedure OnStreamEnd(); virtual; stdcall; abstract;

        // Called when this voice is about to start processing a new buffer.
        procedure OnBufferStart(pBufferContext: pointer); virtual; stdcall; abstract;

        // Called when this voice has just finished processing a buffer.
        // The buffer can now be reused or destroyed.
        procedure OnBufferEnd(pBufferContext: pointer); virtual; stdcall; abstract;

        // Called when this voice has just reached the end position of a loop.
        procedure OnLoopEnd(pBufferContext: pointer); virtual; stdcall; abstract;

        // Called in the event of a critical error during voice processing,
        // such as a failing xAPO or an error from the hardware XMA decoder.
        // The voice may have to be destroyed and re-created to recover from
        // the error.  The callback arguments report which buffer was being
        // processed when the error occurred, and its HRESULT code.
        procedure OnVoiceError(pBufferContext: Pointer; Error: HRESULT); virtual; stdcall; abstract;
    end;




{*************************************************************************
 *
 * XAudio2Create: Top-level function that creates an XAudio2 instance.
 *
 * ARGUMENTS:
 *
 *  Flags - Flags specifying the XAudio2 object's behavior.
 *
 *  XAudio2Processor - An XAUDIO2_PROCESSOR value that specifies the
 *          hardware threads (Xbox) or processors (Windows) that XAudio2
 *          will use.  Note that XAudio2 supports concurrent processing on
 *          multiple threads, using any combination of XAUDIO2_PROCESSOR
 *          flags.  The values are platform-specific; platform-independent
 *          code can use XAUDIO2_DEFAULT_PROCESSOR to use the default on
 *          each platform.
 *
 *************************************************************************}


function XAudio2Create(out ppXAudio2: IXAudio2; Flags: UINT32 = 0; XAudio2Processor: TXAUDIO2_PROCESSOR = XAUDIO2_DEFAULT_PROCESSOR): HResult;
    stdcall; external XAudio2_DLL;
// Undo the #pragma pack(push, 1) directive at the top of this file
{$A4}

{$ENDIF}
implementation

{*************************************************************************
 *
 * Macros to make it easier to use the XAudio2 COM interfaces in C code.
 *
 *************************************************************************}


{*************************************************************************
 *
 * Utility functions used to convert from pitch in semitones and volume
 * in decibels to the frequency and amplitude ratio units used by XAudio2.
 * These are only defined if the client #defines XAUDIO2_HELPER_FUNCTIONS
 * prior to #including xaudio2.h.
 *
 *************************************************************************}


uses
    Math; // For powf, log10f, sinf and asinf

// Calculate the argument to SetVolume from a decibel value
function XAudio2DecibelsToAmplitudeRatio(Decibels: single): single; inline;
begin
    Result := power(10.0, Decibels / 20.0);
end;

// Recover a volume in decibels from an amplitude factor
function XAudio2AmplitudeRatioToDecibels(Volume: single): single; inline;
begin
    if (Volume = 0) then
    begin
        Result := -3.402823466e+38; // Smallest single value (-FLT_MAX)
    end
    else
    begin
        Result := 20.0 * log10(Volume);
    end;
end;

// Calculate the argument to SetFrequencyRatio from a semitone value
function XAudio2SemitonesToFrequencyRatio(Semitones: single): single; inline;
begin
    // FrequencyRatio = 2 ^ Octaves
    //                = 2 ^ (Semitones / 12)
    Result := power(2.0, Semitones / 12.0);
end;

// Recover a pitch in semitones from a frequency ratio
function XAudio2FrequencyRatioToSemitones(FrequencyRatio: single): single; inline;
begin
    // Semitones = 12 * log2(FrequencyRatio)
    //           = 12 * log2(10) * log10(FrequencyRatio)
    Result := 39.86313713864835 * log10(FrequencyRatio);
end;

// Convert from filter cutoff frequencies expressed in Hertz to the radian
// frequency values used in XAUDIO2_FILTER_PARAMETERS.Frequency, state-variable
// filter types only.  Use XAudio2CutoffFrequencyToOnePoleCoefficient() for one-pole filter types.
// Note that the highest CutoffFrequency supported is SampleRate/6.
// Higher values of CutoffFrequency will return XAUDIO2_MAX_FILTER_FREQUENCY.
function XAudio2CutoffFrequencyToRadians(CutoffFrequency: single; SampleRate: UINT32): single; inline;
begin
    if (trunc(CutoffFrequency * 6.0) >= SampleRate) then
    begin
        Result := XAUDIO2_MAX_FILTER_FREQUENCY;
    end
    else
    begin
        Result := 2.0 * sin(M_PI * CutoffFrequency / SampleRate);
    end;
end;

// Convert from radian frequencies back to absolute frequencies in Hertz
function XAudio2RadiansToCutoffFrequency(Radians: single; SampleRate: single): single; inline;
begin
    Result := SampleRate * arcsin(Radians / 2.0) / M_PI;
end;

// Convert from filter cutoff frequencies expressed in Hertz to the filter
// coefficients used with XAUDIO2_FILTER_PARAMETERS.Frequency,
// LowPassOnePoleFilter and HighPassOnePoleFilter filter types only.
// Use XAudio2CutoffFrequencyToRadians() for state-variable filter types.
function XAudio2CutoffFrequencyToOnePoleCoefficient(CutoffFrequency: single; SampleRate: UINT32): single; inline;
begin
    if (trunc(CutoffFrequency) >= SampleRate) then
    begin
        Result := XAUDIO2_MAX_FILTER_FREQUENCY;
    end
    else
    begin
        Result := (1.0 - power(1.0 - 2.0 * CutoffFrequency / SampleRate, 2.0));
    end;
end;



end.


