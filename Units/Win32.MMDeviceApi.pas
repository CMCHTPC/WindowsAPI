unit Win32.MMDeviceApi;

interface

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

//{$I Win32.WinAPI.inc}

uses
    Classes, SysUtils,
    Windows,
    ActiveX,
    Win32.WTypes,
    Win32.PropSys;

// {$IF  WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP)}
// #define E_NOTFOUND HRESULT_FROM_WIN32(ERROR_NOT_FOUND)
// #define E_UNSUPPORTED_TYPE HRESULT_FROM_WIN32(ERROR_UNSUPPORTED_TYPE)
const
    DEVICE_STATE_ACTIVE = $00000001;
    DEVICE_STATE_DISABLED = $00000002;
    DEVICE_STATE_NOTPRESENT = $00000004;
    DEVICE_STATE_UNPLUGGED = $00000008;
    DEVICE_STATEMASK_ALL = $0000000f;

    ENDPOINT_SYSFX_ENABLED = $00000000;  // System Effects are enabled.
    ENDPOINT_SYSFX_DISABLED = $00000001;  // System Effects are disabled.


// {$ENDIF}

(*
#ifdef INITGUID
#define DEFINE_PROPERTYKEY(name, l, w1, w2, b1, b2, b3, b4, b5, b6, b7, b8, pid) EXTERN_C const PROPERTYKEY DECLSPEC_SELECTANY name = { { l, w1, w2, { b1, b2,  b3,  b4,  b5,  b6,  b7,  b8 } }, pid }
#else
#define DEFINE_PROPERTYKEY(name, l, w1, w2, b1, b2, b3, b4, b5, b6, b7, b8, pid) EXTERN_C const PROPERTYKEY name
{$ENDIF} // INITGUID
DEFINE_PROPERTYKEY(PKEY_AudioEndpoint_FormFactor : TGUID ='{1da5d803, $d492, $4edd, $8c, $23, $e0, $c0, $ff, $ee, $7f, $0e, 0); 
DEFINE_PROPERTYKEY(PKEY_AudioEndpoint_ControlPanelPageProvider: TGUID ='{1da5d803, $d492, $4edd, $8c, $23, $e0, $c0, $ff, $ee, $7f, $0e, 1); 
DEFINE_PROPERTYKEY(PKEY_AudioEndpoint_Association: TGUID ='{1da5d803, $d492, $4edd, $8c, $23, $e0, $c0, $ff, $ee, $7f, $0e, 2);
DEFINE_PROPERTYKEY(PKEY_AudioEndpoint_PhysicalSpeakers: TGUID ='{1da5d803, $d492, $4edd, $8c, $23, $e0, $c0, $ff, $ee, $7f, $0e, 3);
DEFINE_PROPERTYKEY(PKEY_AudioEndpoint_GUID: TGUID ='{1da5d803, $d492, $4edd, $8c, $23, $e0, $c0, $ff, $ee, $7f, $0e, 4);
DEFINE_PROPERTYKEY(PKEY_AudioEndpoint_Disable_SysFx: TGUID ='{1da5d803, $d492, $4edd, $8c, $23, $e0, $c0, $ff, $ee, $7f, $0e, 5);

DEFINE_PROPERTYKEY(PKEY_AudioEndpoint_FullRangeSpeakers: TGUID ='{1da5d803, $d492, $4edd, $8c, $23, $e0, $c0, $ff, $ee, $7f, $0e, 6);
DEFINE_PROPERTYKEY(PKEY_AudioEndpoint_Supports_EventDriven_Mode: TGUID ='{$1da5d803, $d492, $4edd, $8c, $23, $e0, $c0, $ff, $ee, $7f, $0e, 7);
DEFINE_PROPERTYKEY(PKEY_AudioEndpoint_JackSubType: TGUID ='{1da5d803, $d492, $4edd, $8c, $23, $e0, $c0, $ff, $ee, $7f, $0e, 8);
DEFINE_PROPERTYKEY(PKEY_AudioEndpoint_Default_VolumeInDb: TGUID ='{$1da5d803, $d492, $4edd, $8c, $23, $e0, $c0, $ff, $ee, $7f, $0e, 9);
DEFINE_PROPERTYKEY(PKEY_AudioEngine_DeviceFormat: TGUID ='{f19f064d, $82c, $4e27, $bc, $73, $68, $82, $a1, $bb, $8e, $4c, 0); 
DEFINE_PROPERTYKEY(PKEY_AudioEngine_OEMFormat: TGUID ='{e4870e26, $3cc5, $4cd2, $ba, $46, $ca, $a, $9a, $70, $ed, $4, 3); 
DEFINE_PROPERTYKEY(PKEY_AudioEndpointLogo_IconEffects: TGUID ='{$f1ab780d, $2010, $4ed3, $a3, $a6, $8b, $87, $f0, $f0, $c4, $76, 0);
DEFINE_PROPERTYKEY(PKEY_AudioEndpointLogo_IconPath: TGUID ='{f1ab780d, $2010, $4ed3, $a3, $a6, $8b, $87, $f0, $f0, $c4, $76, 1);
DEFINE_PROPERTYKEY(PKEY_AudioEndpointSettings_MenuText: TGUID ='{14242002, $0320, $4de4, $95, $55, $a7, $d8, $2b, $73, $c2, $86, 0);
DEFINE_PROPERTYKEY(PKEY_AudioEndpointSettings_LaunchContract: TGUID ='{14242002, $0320, $4de4, $95, $55, $a7, $d8, $2b, $73, $c2, $86, 1);

*)
type
   { PPROPERTYKEY = ^TPROPERTYKEY;

    TPROPERTYKEY = packed record
        fmtid: TGUID;
        pid: DWORD;
    end; }


    TDIRECTX_AUDIO_ACTIVATION_PARAMS = record
        cbDirectXAudioActivationParams: DWORD;
        guidAudioSession: TGUID;
        dwAudioStreamFlags: DWORD;
    end;

    PDIRECTX_AUDIO_ACTIVATION_PARAMS = ^TDIRECTX_AUDIO_ACTIVATION_PARAMS;

    TEDataFlow = (
        eRender = 0,
        eCapture = (eRender + 1),
        eAll = (eCapture + 1),
        EDataFlow_enum_count = (eAll + 1)
        );

    TERole = (
        eConsole = 0,
        eMultimedia = (eConsole + 1),
        eCommunications = (eMultimedia + 1),
        ERole_enum_count = (eCommunications + 1)
        );


    TEndpointFormFactor = (
        RemoteNetworkDevice = 0,
        Speakers = (RemoteNetworkDevice + 1),
        LineLevel = (Speakers + 1),
        Headphones = (LineLevel + 1),
        Microphone = (Headphones + 1),
        Headset = (Microphone + 1),
        Handset = (Headset + 1),
        UnknownDigitalPassthrough = (Handset + 1),
        SPDIF = (UnknownDigitalPassthrough + 1),
        DigitalAudioDisplayDevice = (SPDIF + 1),
        UnknownFormFactor = (DigitalAudioDisplayDevice + 1),
        EndpointFormFactor_enum_count = (UnknownFormFactor + 1)
        );

// #define HDMI     DigitalAudioDisplayDevice

// {$ENDIF} (* WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) *)

// {$IF  WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_APP)}

const
    CLSID_MMDeviceEnumerator: TGUID = '{BCDE0395-E52F-467C-8E3D-C4579291692E}';
    // ----------------------------------------------------------------------
    // Device Interface Classes
    // ----------------------------------------------------------------------


    DEVINTERFACE_AUDIO_RENDER: TGUID = '{E6327CAD-DCEC-4949-AE8A-991E976A79D2}';
    DEVINTERFACE_AUDIO_CAPTURE: TGUID = '{2EEF81BE-33FA-4800-9670-1CD474972C3F}';
    //{$IF  (NTDDI_VERSION > NTDDI_WINBLUE OR  (NTDDI_VERSION = NTDDI_WINBLUE && defined(WINBLUE_KBSPRING14)))}
    DEVINTERFACE_MIDI_OUTPUT: TGUID = '{6DC23320-AB33-4CE4-80D4-BBB3EBBF2814}';
    DEVINTERFACE_MIDI_INPUT: TGUID = '{504BE32C-CCF6-4D2C-B73F-6F8B3747E22B}';
    // {$ENDIF}
    // {$ENDIF} (* WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_APP) *)

    //{$IF  WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP)}

    IID_IMMNotificationClient: TGUID = '{7991EEC9-7E89-4D85-8390-6C703CEC60C0}';
    IID_IMMDevice: TGUID = '{D666063F-1587-4E43-81F1-B948E807363F}';
    IID_IMMDeviceCollection: TGUID = '{0BD7A1BE-7A1A-44DB-8397-CC5392387B5E}';
    IID_IMMEndpoint: TGUID = '{1BE09788-6894-4089-8586-9A2A6C265AC5}';
    IID_IMMDeviceEnumerator: TGUID = '{A95664D2-9614-4F35-A746-DE8DB63617E6}';
    IID_IMMDeviceActivator: TGUID = '{3B0D0EA4-D0A9-4B0E-935B-09516746FAC0}';
    IID_IActivateAudioInterfaceCompletionHandler: TGUID = '{41D949AB-9862-444A-80F6-C261334DA5EB}';
    IID_IActivateAudioInterfaceAsyncOperation: TGUID = '{72A22D78-CDE4-431D-B8CC-843A71199B6D}';

type
    LPCWSTR = PWideChar;
    LPWSTR = Pwidechar;

    IMMNotificationClient = interface(IUnknown)
        ['{7991EEC9-7E89-4D85-8390-6C703CEC60C0}']
        function OnDeviceStateChanged(pwstrDeviceId: LPCWSTR; dwNewState: DWORD): HResult; stdcall;
        function OnDeviceAdded(pwstrDeviceId: LPCWSTR): HResult; stdcall;
        function OnDeviceRemoved(pwstrDeviceId: LPCWSTR): HResult; stdcall;
        function OnDefaultDeviceChanged(flow: TEDataFlow; role: TERole; pwstrDefaultDeviceId: LPCWSTR): HResult; stdcall;
        function OnPropertyValueChanged(pwstrDeviceId: LPCWSTR; const key: TPROPERTYKEY): HResult; stdcall;
    end;




    IMMDevice = interface(IUnknown)
        ['{D666063F-1587-4E43-81F1-B948E807363F}']
        function Activate(const iid: TGUID; dwClsCtx: DWORD; pActivationParams: PPROPVARIANT; out ppInterface): HResult; stdcall;
        function OpenPropertyStore(stgmAccess: DWORD; out ppProperties: IPropertyStore): HResult; stdcall;
        function GetId(out ppstrId: LPWSTR): HResult; stdcall;
        function GetState(out pdwState: DWORD): HResult; stdcall;
    end;




    IMMDeviceCollection = interface(IUnknown)
        ['{0BD7A1BE-7A1A-44DB-8397-CC5392387B5E}']
        function GetCount(out pcDevices: UINT32): HResult; stdcall;
        function Item(nDevice: UINT32; out ppDevice: IMMDevice): HResult; stdcall;
    end;




    IMMEndpoint = interface(IUnknown)
        ['{1BE09788-6894-4089-8586-9A2A6C265AC5}']
        function GetDataFlow(out pDataFlow: TEDataFlow): HResult; stdcall;
    end;




    IMMDeviceEnumerator = interface(IUnknown)
        ['{A95664D2-9614-4F35-A746-DE8DB63617E6}']
        function EnumAudioEndpoints(dataFlow: TEDataFlow; dwStateMask: DWORD; out ppDevices: IMMDeviceCollection): HResult; stdcall;
        function GetDefaultAudioEndpoint(dataFlow: TEDataFlow; role: TERole; out ppEndpoint: IMMDevice): HResult; stdcall;
        function GetDevice(pwstrId: LPCWSTR; out ppDevice: IMMDevice): HResult; stdcall;
        function RegisterEndpointNotificationCallback(pClient: IMMNotificationClient): HResult; stdcall;
        function UnregisterEndpointNotificationCallback(pClient: IMMNotificationClient): HResult; stdcall;
    end;




    IMMDeviceActivator = interface(IUnknown)
        ['{3B0D0EA4-D0A9-4B0E-935B-09516746FAC0}']
        function Activate(const iid: TGUID; pDevice: IMMDevice; pActivationParams: PPROPVARIANT; out ppInterface): HResult; stdcall;
    end;



    (* IMMDeviceActivator is reserved for system use *)
    //{$ENDIF} (* WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) *)

    //{$IF  WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_APP)}



    IActivateAudioInterfaceAsyncOperation = interface;

    IActivateAudioInterfaceCompletionHandler = interface(IUnknown)
        ['{41D949AB-9862-444A-80F6-C261334DA5EB}']
        function ActivateCompleted(activateOperation: IActivateAudioInterfaceAsyncOperation): HResult; stdcall;
    end;




    IActivateAudioInterfaceAsyncOperation = interface(IUnknown)
        ['{72A22D78-CDE4-431D-B8CC-843A71199B6D}']
        function GetActivateResult(out activateResult: HRESULT; out activatedInterface): HResult; stdcall;
    end;




// ----------------------------------------------------------------------
// Function: ActivateAudioInterfaceAsync
// This function takes
// * a device interface instance identifier representing either
//     - an audio device interface instance (e.g., built-in speakers), or
//     - an device interface class (e.g., audio render devices)
// * a COM interface identifier
// * activation parameters specific to the interface being activated
// and asynchronously returns a pointer to the specified interface
// ----------------------------------------------------------------------
function ActivateAudioInterfaceAsync(deviceInterfacePath: LPCWSTR; const riid: TGUID; activationParams: PPROPVARIANT;
    completionHandler: IActivateAudioInterfaceCompletionHandler; out activationOperation: IActivateAudioInterfaceAsyncOperation): HResult;
    stdcall; external;
// {$ENDIF} (* WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_APP) *)

// {$IF  WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP)}
type
    TAudioExtensionParams = record
        AddPageParam: LPARAM;
        pEndpoint: IMMDevice;
        pPnpInterface: IMMDevice;
        pPnpDevnode: IMMDevice;
    end;


(*
 LIBID_MMDeviceAPILib: TGUID ='{2FDAAFA3-7523-4F66-9957-9D5E7FE698F6}';
  IMMDeviceEnumerator : TGUID ='{BCDE0395-E52F-467C-8E3D-C4579291692E}';
EXTERN_C const CLSID CLSID_MMDeviceEnumerator;
 *)



implementation

end.
