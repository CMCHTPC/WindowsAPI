(*
 This module contains the multimedia class scheduler APIs and any public data
 structures needed to call these APIs.
*)
unit Win32.AVRT;
{ Header Version 10.0.17134 }

{$mode delphiunicode}{$H+}

interface

uses
    Classes, SysUtils, Windows;

const
    Avrt_dll = 'Avrt.dll';


type

    // AvRt Priorities
    TAVRT_PRIORITY = (
        AVRT_PRIORITY_VERYLOW = -2,
        AVRT_PRIORITY_LOW,
        AVRT_PRIORITY_NORMAL,
        AVRT_PRIORITY_HIGH,
        AVRT_PRIORITY_CRITICAL);

    PAVRT_PRIORITY = ^TAVRT_PRIORITY;


//  Infinite timeout for a thread order group.


const
    THREAD_ORDER_GROUP_INFINITE_TIMEOUT = int64(-1);


// Define API decoration for direct importing of DLL references.


function AvSetMmThreadCharacteristicsA(TaskName: LPCSTR; var TaskIndex: DWORD): HANDLE; stdcall; external Avrt_dll;

function AvSetMmThreadCharacteristicsW(TaskName: LPCWSTR; var TaskIndex: DWORD): HANDLE; stdcall; external Avrt_dll;

function AvSetMmMaxThreadCharacteristicsA(FirstTask: LPCSTR; SecondTask: LPCSTR; var TaskIndex: DWORD): HANDLE;
    stdcall; external Avrt_dll;

function AvSetMmMaxThreadCharacteristicsW(FirstTask: LPCWSTR; SecondTask: LPCWSTR; var TaskIndex: DWORD): HANDLE;
    stdcall; external Avrt_dll;

function AvRevertMmThreadCharacteristics(AvrtHandle: HANDLE): boolean; stdcall; external Avrt_dll;

function AvSetMmThreadPriority(AvrtHandle: HANDLE; Priority: TAVRT_PRIORITY): boolean; stdcall; external Avrt_dll;

function AvRtCreateThreadOrderingGroup(out Context: HANDLE; Period: PLARGE_INTEGER; var ThreadOrderingGuid: TGUID;
    Timeout: PLARGE_INTEGER): boolean; stdcall; external Avrt_dll;

function AvRtCreateThreadOrderingGroupExA(out Context: HANDLE; Period: PLARGE_INTEGER; var ThreadOrderingGuid: TGUID;
    Timeout: PLARGE_INTEGER; TaskName: LPCSTR): boolean; stdcall; external Avrt_dll;

function AvRtCreateThreadOrderingGroupExW(out Context: HANDLE; Period: PLARGE_INTEGER; var ThreadOrderingGuid: TGUID;
    Timeout: PLARGE_INTEGER; TaskName: LPCWSTR): boolean; stdcall; external Avrt_dll;

function AvRtJoinThreadOrderingGroup(out Context: HANDLE; const ThreadOrderingGuid: TGUID; Before: boolean): boolean;
    stdcall; external Avrt_dll;

function AvRtWaitOnThreadOrderingGroup(Context: HANDLE): boolean; stdcall; external Avrt_dll;

function AvRtLeaveThreadOrderingGroup(Context: HANDLE): boolean; stdcall; external Avrt_dll;

function AvRtDeleteThreadOrderingGroup(Context: HANDLE): boolean; stdcall; external Avrt_dll;

function AvQuerySystemResponsiveness(AvrtHandle: HANDLE; out SystemResponsivenessValue: ULONG): boolean; stdcall; external Avrt_dll;

implementation

end.

