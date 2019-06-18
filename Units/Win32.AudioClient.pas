unit Win32.AudioClient;

{ Header Version 10.0.17134 }

interface

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}

uses
    Classes, SysUtils,
    Win32.AudioSessionTypes, {Win32.MMReg,}
    Win32.WTypes;

const
    SEVERITY_SUCCESS = 0 shl 31;
    SEVERITY_ERROR = 1 shl 31;
    FACILITY_AUDCLNT = $889 shl 16;

    AUDIOCLOCK_CHARACTERISTIC_FIXED_FREQ = $00000001;

    AMBISONICS_PARAM_VERSION_1 = 1;

const
    //  {$if (WINAPI_FAMILY_PARTITION=WINAPI_PARTITION_APP)}

    AUDCLNT_E_NOT_INITIALIZED = SEVERITY_ERROR or FACILITY_AUDCLNT or ($001);
    AUDCLNT_E_ALREADY_INITIALIZED = SEVERITY_ERROR or FACILITY_AUDCLNT or ($002);
    AUDCLNT_E_WRONG_ENDPOINT_TYPE = SEVERITY_ERROR or FACILITY_AUDCLNT or ($003);
    AUDCLNT_E_DEVICE_INVALIDATED = SEVERITY_ERROR or FACILITY_AUDCLNT or ($004);
    AUDCLNT_E_NOT_STOPPED = SEVERITY_ERROR or FACILITY_AUDCLNT or ($005);
    AUDCLNT_E_BUFFER_TOO_LARGE = SEVERITY_ERROR or FACILITY_AUDCLNT or ($006);
    AUDCLNT_E_OUT_OF_ORDER = SEVERITY_ERROR or FACILITY_AUDCLNT or ($007);
    AUDCLNT_E_UNSUPPORTED_FORMAT = SEVERITY_ERROR or FACILITY_AUDCLNT or ($008);
    AUDCLNT_E_INVALID_SIZE = SEVERITY_ERROR or FACILITY_AUDCLNT or ($009);
    AUDCLNT_E_DEVICE_IN_USE = SEVERITY_ERROR or FACILITY_AUDCLNT or ($00a);
    AUDCLNT_E_BUFFER_OPERATION_PENDING = SEVERITY_ERROR or FACILITY_AUDCLNT or ($00b);
    AUDCLNT_E_THREAD_NOT_REGISTERED = SEVERITY_ERROR or FACILITY_AUDCLNT or ($00c);
    AUDCLNT_E_EXCLUSIVE_MODE_NOT_ALLOWED = SEVERITY_ERROR or FACILITY_AUDCLNT or ($00e);
    AUDCLNT_E_ENDPOINT_CREATE_FAILED = SEVERITY_ERROR or FACILITY_AUDCLNT or ($00f);
    AUDCLNT_E_SERVICE_NOT_RUNNING = SEVERITY_ERROR or FACILITY_AUDCLNT or ($010);
    AUDCLNT_E_EVENTHANDLE_NOT_EXPECTED = SEVERITY_ERROR or FACILITY_AUDCLNT or ($011);
    AUDCLNT_E_EXCLUSIVE_MODE_ONLY = SEVERITY_ERROR or FACILITY_AUDCLNT or ($012);
    AUDCLNT_E_BUFDURATION_PERIOD_NOT_EQUAL = SEVERITY_ERROR or FACILITY_AUDCLNT or ($013);
    AUDCLNT_E_EVENTHANDLE_NOT_SET = SEVERITY_ERROR or FACILITY_AUDCLNT or ($014);
    AUDCLNT_E_INCORRECT_BUFFER_SIZE = SEVERITY_ERROR or FACILITY_AUDCLNT or ($015);
    AUDCLNT_E_BUFFER_SIZE_ERROR = SEVERITY_ERROR or FACILITY_AUDCLNT or ($016);
    AUDCLNT_E_CPUUSAGE_EXCEEDED = SEVERITY_ERROR or FACILITY_AUDCLNT or ($017);
    AUDCLNT_E_BUFFER_ERROR = SEVERITY_ERROR or FACILITY_AUDCLNT or ($018);
    AUDCLNT_E_BUFFER_SIZE_NOT_ALIGNED = SEVERITY_ERROR or FACILITY_AUDCLNT or ($019);
    AUDCLNT_E_INVALID_DEVICE_PERIOD = SEVERITY_ERROR or FACILITY_AUDCLNT or ($020);
    AUDCLNT_E_INVALID_STREAM_FLAG = SEVERITY_ERROR or FACILITY_AUDCLNT or ($021);
    AUDCLNT_E_ENDPOINT_OFFLOAD_NOT_CAPABLE = SEVERITY_ERROR or FACILITY_AUDCLNT or ($022);
    AUDCLNT_E_OUT_OF_OFFLOAD_RESOURCES = SEVERITY_ERROR or FACILITY_AUDCLNT or ($023);
    AUDCLNT_E_OFFLOAD_MODE_ONLY = SEVERITY_ERROR or FACILITY_AUDCLNT or ($024);
    AUDCLNT_E_NONOFFLOAD_MODE_ONLY = SEVERITY_ERROR or FACILITY_AUDCLNT or ($025);
    AUDCLNT_E_RESOURCES_INVALIDATED = SEVERITY_ERROR or FACILITY_AUDCLNT or ($026);
    AUDCLNT_E_RAW_MODE_UNSUPPORTED = SEVERITY_ERROR or FACILITY_AUDCLNT or ($027);
    AUDCLNT_E_ENGINE_PERIODICITY_LOCKED = SEVERITY_ERROR or FACILITY_AUDCLNT or ($028);
    AUDCLNT_E_ENGINE_FORMAT_LOCKED = SEVERITY_ERROR or FACILITY_AUDCLNT or ($029);
    AUDCLNT_E_HEADTRACKING_ENABLED = SEVERITY_ERROR or FACILITY_AUDCLNT or ($030);
    AUDCLNT_E_HEADTRACKING_UNSUPPORTED = SEVERITY_ERROR or FACILITY_AUDCLNT or ($040);


    AUDCLNT_S_BUFFER_EMPTY = SEVERITY_SUCCESS or FACILITY_AUDCLNT or ($001);
    AUDCLNT_S_THREAD_ALREADY_REGISTERED = SEVERITY_SUCCESS or FACILITY_AUDCLNT or ($002);
    AUDCLNT_S_POSITION_STALLED = SEVERITY_SUCCESS or FACILITY_AUDCLNT or ($003);
//{$endif} { WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_APP) }


const
    IID_IAudioClient: TGUID = '{1CB9AD4C-DBFA-4c32-B178-C2F568A703B2}';
    IID_IAudioClient2: TGUID = '{726778CD-F60A-4eda-82DE-E47610CD78AA}';
    IID_IAudioClient3: TGUID = '{7ED4EE07-8E67-4CD4-8C1A-2B7A5987AD42}';
    IID_IAudioRenderClient: TGUID = '{F294ACFC-3146-4483-A7BF-ADDCA7C260E2}';
    IID_IAudioCaptureClient: TGUID = '{C8ADBD64-E71E-48a0-A4DE-185C395CD317}';
    IID_IAudioClock: TGUID = '{CD63314F-3FBA-4a1b-812C-EF96358728E7}';
    IID_IAudioClock2: TGUID = '{6f49ff73-6727-49ac-a008-d98cf5e70048}';
    IID_IAudioClockAdjustment: TGUID = '{f6e4c0a0-46d9-4fb8-be21-57a3ef2b626c}';
    IID_ISimpleAudioVolume: TGUID = '{87CE5498-68D6-44E5-9215-6DA47EF883D8}';
    IID_IAudioStreamVolume: TGUID = '{93014887-242D-4068-8A15-CF5E93B90FE3}';
    IID_IAudioAmbisonicsControl: TGUID = '{28724C91-DF35-4856-9F76-D6A26413F3DF}';
    IID_IChannelAudioVolume: TGUID = '{1C158861-B533-4B30-B1CF-E853E51C59B8}';


{ Forward Declarations }

type

    LONGLONG = int64;

    TREFERENCE_TIME = LONGLONG;

    TWAVEFORMATEX = record
        wFormatTag: word;        (* format type *)
        nChannels: word;         (* number of channels (i.e. mono, stereo...) *)
        nSamplesPerSec: DWORD;    (* sample rate *)
        nAvgBytesPerSec: DWORD;   (* for buffer estimation *)
        nBlockAlign: word;       (* block size of data *)
        wBitsPerSample: word;    (* Number of bits per sample of mono data *)
        cbSize: word;            (* The count in bytes of the size of
                                    extra information (after cbSize) *)
    end;
    PWAVEFORMATEX = ^TWAVEFORMATEX;


    TWAVEFORMATEXTENSIBLE = record
        wFormatTag: word;
        nChannels: word;
        nSamplesPerSec: DWORD;
        nAvgBytesPerSec: DWORD;
        nBlockAlign: word;
        wBitsPerSample: word;
        cbSize: word;
        wValidBitsPerSample: word;
        dwChannelMask: DWORD;
        SubFormat: TGUID;
    end;
    PWAVEFORMATEXTENSIBLE = ^TWAVEFORMATEXTENSIBLE;

  (*
#include <winapifamily.h>
#if 0
typedef { [hidden][restricted] } LONGLONG REFERENCE_TIME;

#else
#ifndef _SkipIksIncludes_
 _IKsControl_
#include <ks.h>
#include <ksmedia.h>

*)
    // {$if (WINAPI_FAMILY_PARTITION=WINAPI_PARTITION_APP)}

    TAUDCLNT_BUFFERFLAGS = (
        AUDCLNT_BUFFERFLAGS_DATA_DISCONTINUITY = $1,
        AUDCLNT_BUFFERFLAGS_SILENT = $2,
        AUDCLNT_BUFFERFLAGS_TIMESTAMP_ERROR = $4
        );

    TAUDCLNT_STREAMOPTIONS = (
        AUDCLNT_STREAMOPTIONS_NONE = 0,
        AUDCLNT_STREAMOPTIONS_RAW = $1,
        AUDCLNT_STREAMOPTIONS_MATCH_FORMAT = $2,
        AUDCLNT_STREAMOPTIONS_AMBISONICS = $4
        );


{$if (NTDDI_VERSION < NTDDI_WINBLUE) }
    TAudioClientProperties = record
        cbSize: UINT32;
        bIsOffload: boolean;
        eCategory: TAUDIO_STREAM_CATEGORY;
    end;
{$ELSE}
    TAudioClientProperties = record
        cbSize: UINT32;
        bIsOffload: boolean;
        eCategory: TAUDIO_STREAM_CATEGORY;
        Options: TAUDCLNT_STREAMOPTIONS;
    end;

{$ENDIF}


    IAudioClient = interface(IUnknown)
        ['{1CB9AD4C-DBFA-4c32-B178-C2F568A703B2}']
        function Initialize(ShareMode: TAUDCLNT_SHAREMODE; StreamFlags: DWORD; hnsBufferDuration: TREFERENCE_TIME;
            hnsPeriodicity: TREFERENCE_TIME; const pFormat: TWAVEFORMATEX; const AudioSessionGuid: TGUID): HResult; stdcall;
        function GetBufferSize(out pNumBufferFrames: UINT32): HResult; stdcall;
        function GetStreamLatency(out phnsLatency: TREFERENCE_TIME): HResult; stdcall;
        function GetCurrentPadding(out pNumPaddingFrames: UINT32): HResult; stdcall;
        function IsFormatSupported(ShareMode: TAUDCLNT_SHAREMODE; const pFormat: TWAVEFORMATEX;
           { var} ppClosestMatch: pointer{PWAVEFORMATEX}): HResult; stdcall;
        function GetMixFormat(var ppDeviceFormat: PWAVEFORMATEX): HResult; stdcall;
        function GetDevicePeriod(out phnsDefaultDevicePeriod: TREFERENCE_TIME; out phnsMinimumDevicePeriod: TREFERENCE_TIME): HResult;
            stdcall;
        function Start(): HResult; stdcall;
        function Stop(): HResult; stdcall;
        function Reset(): HResult; stdcall;
        function SetEventHandle(eventHandle: THANDLE): HResult; stdcall;
        function GetService(const riid: TGUID; out ppv): HResult; stdcall;
    end;



    IAudioClient2 = interface(IAudioClient)
        ['{726778CD-F60A-4eda-82DE-E47610CD78AA}']
        function IsOffloadCapable(Category: TAUDIO_STREAM_CATEGORY; out pbOffloadCapable: boolean): HResult; stdcall;
        function SetClientProperties(const pProperties: TAudioClientProperties): HResult; stdcall;
        function GetBufferSizeLimits(const pFormat: TWAVEFORMATEX; bEventDriven: boolean; out phnsMinBufferDuration: TREFERENCE_TIME;
            out phnsMaxBufferDuration: TREFERENCE_TIME): HResult; stdcall;
    end;



    // AudioClient3ActivationParams is an optional activation parameter for IAudioClient3

    // IAudioClient3 implementations log various things via ETW tracing
    // including a "context" identifier

    // In situations where there are multiple active audio clients,
    // the "tracing context" identifier can ease correlation of which audio client instance belongs to which application context

    // Sample app code:
    // PROPVARIANT var;
    // PropVariantInit(&var);
    // auto p = reinterpret_cast<AudioClient3ActivationParams *>CoTaskMemAlloc(sizeof(AudioClient3ActivationParams));
    // if (nullptr == p) { ... }
    // p->tracingContextId = { app-specific context identifier */;
    // var.vt = VT_BLOB;
    // var.blob.cbSize = sizeof(*p);
    // var.blob.pBlobData = reinterpret_cast<BYTE *>(p);
    // hr = ActivateAudioInterfaceAsync(device, __uuidof(IAudioClient3), &var, ...);
    // ...
    // PropVariantClear(&var);
    TAudioClient3ActivationParams = record
        tracingContextId: TGUID;
    end;



    IAudioClient3 = interface(IAudioClient2)
        ['{7ED4EE07-8E67-4CD4-8C1A-2B7A5987AD42}']
        function GetSharedModeEnginePeriod(const pFormat: TWAVEFORMATEX; out pDefaultPeriodInFrames: UINT32;
            out pFundamentalPeriodInFrames: UINT32; out pMinPeriodInFrames: UINT32; out pMaxPeriodInFrames: UINT32): HResult; stdcall;
        function GetCurrentSharedModeEnginePeriod(out ppFormat: TWAVEFORMATEX; out pCurrentPeriodInFrames: UINT32): HResult; stdcall;
        function InitializeSharedAudioStream(StreamFlags: DWORD; PeriodInFrames: UINT32; const pFormat: TWAVEFORMATEX;
            const AudioSessionGuid: TGUID): HResult; stdcall;
    end;


    IAudioRenderClient = interface(IUnknown)
        ['{F294ACFC-3146-4483-A7BF-ADDCA7C260E2}']
        function GetBuffer(NumFramesRequested: UINT32; out ppData: PBYTE): HResult; stdcall;
        function ReleaseBuffer(NumFramesWritten: UINT32; dwFlags: DWORD): HResult; stdcall;
    end;




    IAudioCaptureClient = interface(IUnknown)
        ['{C8ADBD64-E71E-48a0-A4DE-185C395CD317}']
        function GetBuffer(out ppData: PBYTE; out pNumFramesToRead: UINT32; out pdwFlags: DWORD;
            out pu64DevicePosition: UINT64; out pu64QPCPosition: UINT64): HResult; stdcall;
        function ReleaseBuffer(NumFramesRead: UINT32): HResult; stdcall;
        function GetNextPacketSize(out pNumFramesInNextPacket: UINT32): HResult; stdcall;
    end;




    IAudioClock = interface(IUnknown)
        ['{CD63314F-3FBA-4a1b-812C-EF96358728E7}']
        function GetFrequency(out pu64Frequency: UINT64): HResult; stdcall;
        function GetPosition(out pu64Position: UINT64; out pu64QPCPosition: UINT64): HResult; stdcall;
        function GetCharacteristics(out pdwCharacteristics: DWORD): HResult; stdcall;
    end;




    IAudioClock2 = interface(IUnknown)
        ['{6f49ff73-6727-49ac-a008-d98cf5e70048}']
        function GetDevicePosition(out DevicePosition: UINT64; out QPCPosition: UINT64): HResult; stdcall;
    end;




    IAudioClockAdjustment = interface(IUnknown)
        ['{f6e4c0a0-46d9-4fb8-be21-57a3ef2b626c}']
        function SetSampleRate(flSampleRate: single): HResult; stdcall;
    end;




    ISimpleAudioVolume = interface(IUnknown)
        ['{87CE5498-68D6-44E5-9215-6DA47EF883D8}']
        function SetMasterVolume(fLevel: single; const EventContext: TGUID): HResult; stdcall;
        function GetMasterVolume(out pfLevel: single): HResult; stdcall;
        function SetMute(const bMute: boolean; const EventContext: TGUID): HResult; stdcall;
        function GetMute(out pbMute: boolean): HResult; stdcall;
    end;




    IAudioStreamVolume = interface(IUnknown)
        ['{93014887-242D-4068-8A15-CF5E93B90FE3}']
        function GetChannelCount(out pdwCount: UINT32): HResult; stdcall;
        function SetChannelVolume(dwIndex: UINT32; const fLevel: single): HResult; stdcall;
        function GetChannelVolume(dwIndex: UINT32; out pfLevel: single): HResult; stdcall;
        function SetAllVolumes(dwCount: UINT32; const pfVolumes: PSingle): HResult; stdcall;
        function GetAllVolumes(dwCount: UINT32; out pfVolumes: Psingle): HResult; stdcall;
    end;



    //{$endif}{ WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_APP) }

    //{$if (WINAPI_FAMILY_PARTITION=WINAPI_PARTITION_DESKTOP)}



    TAMBISONICS_TYPE = (
        AMBISONICS_TYPE_FULL3D = 0
        );

    TAMBISONICS_CHANNEL_ORDERING = (
        AMBISONICS_CHANNEL_ORDERING_ACN = 0
        );

    TAMBISONICS_NORMALIZATION = (
        AMBISONICS_NORMALIZATION_SN3D = 0,
        AMBISONICS_NORMALIZATION_N3D = (AMBISONICS_NORMALIZATION_SN3D + 1)
        );


    // The AMBISONICS_PARAMS initialization structure should be completely filled out
    // and then passed into the SetData API of IAmbisonicsControl Service on IAudioClient
    // unsigned int(32) size of AMBISONICS_PARAMS
    // unsigned int(32)  version of AMBISONICS_PARAMS struct
    // unsigned int(32) ambisonics_type is the enumeration of ambisonics types
    // unsigned int(32) ambisonics_channel_ordering is the enumeration of ambisonics channel ordering
    // unsigned int(32) ambisonics_normalization is the enumeration of ambisonics normaliztion
    // unsigned int(32) ambisonics_order
    // unsigned int(32) ambisonics_num_channels
    // unsigned int(32) ambisonics_channel_map is a sequence of 32-bit unsigned integers that maps audio channels in a given audio track to ambisonic components,
    // given the defined ambisonics_channel_ordering. The sequence of channel_map values should match the channel sequence within the given audio track.
    TAMBISONICS_PARAMS = record
        u32Size: UINT32;
        u32Version: UINT32;
        u32Type: TAMBISONICS_TYPE;
        u32ChannelOrdering: TAMBISONICS_CHANNEL_ORDERING;
        u32Normalization: TAMBISONICS_NORMALIZATION;
        u32Order: UINT32;
        u32NumChannels: UINT32;
        pu32ChannelMap: PUINT32;
    end;
    PAMBISONICS_PARAMS = ^TAMBISONICS_PARAMS;



    IAudioAmbisonicsControl = interface(IUnknown)
        ['{28724C91-DF35-4856-9F76-D6A26413F3DF}']
        function SetData(const pAmbisonicsParams: PAMBISONICS_PARAMS; cbAmbisonicsParams: UINT32): HResult; stdcall;
        function SetHeadTracking(bEnableHeadTracking: boolean): HResult; stdcall;
        function GetHeadTracking(out pbEnableHeadTracking: boolean): HResult; stdcall;
        function SetRotation(X: single; Y: single; Z: single; W: single): HResult; stdcall;
    end;


    IChannelAudioVolume = interface(IUnknown)
        ['{1C158861-B533-4B30-B1CF-E853E51C59B8}']
        function GetChannelCount(out pdwCount: UINT32): HResult; stdcall;
        function SetChannelVolume(dwIndex: UINT32; const fLevel: single; const EventContext: TGUID): HResult; stdcall;
        function GetChannelVolume(dwIndex: UINT32; out pfLevel: single): HResult; stdcall;
        function SetAllVolumes(dwCount: UINT32; const pfVolumes: Psingle; const EventContext: TGUID): HResult; stdcall;
        function GetAllVolumes(dwCount: UINT32; out pfVolumes: Psingle): HResult; stdcall;
    end;




//{$endif}{ WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) }


implementation

end.
