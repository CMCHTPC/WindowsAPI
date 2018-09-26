(********************************************************************************
*                                                                               *
* synchapi.h -- ApiSet Contract for api-ms-win-core-synch-l1                    *
*                                                                               *
* Copyright (c) Microsoft Corporation. All rights reserved.                     *
*                                                                               *
********************************************************************************)
unit Win32.Synchapi;

{$IFDEF FPC}
{$MODE delphi}{$H+}
{$ENDIF}

{$MACRO ON}


// _WIN32_WINNT version constants

{$DEFINE _WIN32_WINNT_NT4:=$0400}
{$DEFINE _WIN32_WINNT_WIN2K    :=              $0500}
{$DEFINE _WIN32_WINNT_WINXP    :=              $0501}
{$DEFINE _WIN32_WINNT_WS03     :=              $0502}
{$DEFINE _WIN32_WINNT_WIN6     :=              $0600}
{$DEFINE _WIN32_WINNT_VISTA     :=             $0600}
{$DEFINE _WIN32_WINNT_WS08      :=             $0600}
{$DEFINE _WIN32_WINNT_LONGHORN  :=             $0600}
{$DEFINE _WIN32_WINNT_WIN7      :=             $0601}
{$DEFINE _WIN32_WINNT_WIN8      :=             $0602}
{$DEFINE _WIN32_WINNT_WINBLUE   :=             $0603}
{$DEFINE _WIN32_WINNT_WINTHRESHOLD :=          $0A00}(* ABRACADABRA_THRESHOLD*)
{$DEFINE _WIN32_WINNT_WIN10:=$0A00}(* ABRACADABRA_THRESHOLD*)

{$DEFINE _NT_TARGET_VERSION_WIN10_RS4:=$0A05}

{$DEFINE _WIN32_WINNT:=_WIN32_WINNT_WIN10}

interface




uses
    Windows, Classes, SysUtils,
    Win32.MinWinBase;

const

    KERNEL32_DLL = 'Kernel32.dll';

    // some definitions come form WinNT.h

    SYNCHRONIZATION_BARRIER_FLAGS_SPIN_ONLY = $01;
    SYNCHRONIZATION_BARRIER_FLAGS_BLOCK_ONLY = $02;
    SYNCHRONIZATION_BARRIER_FLAGS_NO_DELETE = $04;


    CREATE_MUTEX_INITIAL_OWNER = $00000001;
    CREATE_EVENT_MANUAL_RESET = $00000001;
    CREATE_EVENT_INITIAL_SET = $00000002;

    CREATE_WAITABLE_TIMER_MANUAL_RESET = $00000001;
{$IF (_WIN32_WINNT >= _NT_TARGET_VERSION_WIN10_RS4)}
    CREATE_WAITABLE_TIMER_HIGH_RESOLUTION = $00000002;
{$ENDIF}
    // Run once flags
    RTL_RUN_ONCE_CHECK_ONLY = $00000001;
    RTL_RUN_ONCE_ASYNC = $00000002;
    RTL_RUN_ONCE_INIT_FAILED = $00000004;


    // The context stored in the run once structure must leave the following number
    // of low order bits unused.


    RTL_RUN_ONCE_CTX_RESERVED_BITS = 2;
    RTL_CONDITION_VARIABLE_LOCKMODE_SHARED = $1;

type
    TRTL_RUN_ONCE = record
        Ptr: Pointer;
    end;
    PRTL_RUN_ONCE = ^TRTL_RUN_ONCE;

    TRTL_CONDITION_VARIABLE = record
        Ptr: Pointer;
    end;
    PRTL_CONDITION_VARIABLE = ^TRTL_CONDITION_VARIABLE;

    // Define one-time initialization primitive

    TINIT_ONCE = TRTL_RUN_ONCE;
    PINIT_ONCE = PRTL_RUN_ONCE;
    LPINIT_ONCE = PRTL_RUN_ONCE;

// Run once

const
    RTL_RUN_ONCE_INIT: TRTL_RUN_ONCE = (Ptr: nil);  // Static initializer
    INIT_ONCE_STATIC_INIT: TRTL_RUN_ONCE = (Ptr: nil);

    RTL_CONDITION_VARIABLE_INIT: TRTL_CONDITION_VARIABLE = (Ptr: nil);

    // Run once flags
    INIT_ONCE_CHECK_ONLY = RTL_RUN_ONCE_CHECK_ONLY;
    INIT_ONCE_ASYNC = RTL_RUN_ONCE_ASYNC;
    INIT_ONCE_INIT_FAILED = RTL_RUN_ONCE_INIT_FAILED;


    // The context stored in the run once structure must leave the following number
    // of low order bits unused.
    INIT_ONCE_CTX_RESERVED_BITS = RTL_RUN_ONCE_CTX_RESERVED_BITS;

    // Mutant Specific Access Rights
    MUTANT_QUERY_STATE = $0001;
    MUTANT_ALL_ACCESS = (STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE or MUTANT_QUERY_STATE);

    SEMAPHORE_MODIFY_STATE = $0002;
    SEMAPHORE_ALL_ACCESS = (STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE or $3);

    // Timer Specific Access Rights.

    TIMER_QUERY_STATE = $0001;
    TIMER_MODIFY_STATE = $0002;
    TIMER_ALL_ACCESS = (STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE or TIMER_QUERY_STATE or TIMER_MODIFY_STATE);

    // begin_nthal
    TIME_ZONE_ID_UNKNOWN = 0;
    TIME_ZONE_ID_STANDARD = 1;
    TIME_ZONE_ID_DAYLIGHT = 2;

// end_nthal


// Define the slim R/W lock.


type
    TRTL_SRWLOCK = record
        Ptr: pointer;
    end;
    PRTL_SRWLOCK = ^TRTL_SRWLOCK;

    TSRWLOCK = TRTL_SRWLOCK;

    // Define condition variable
    TCONDITION_VARIABLE = TRTL_CONDITION_VARIABLE;
    PCONDITION_VARIABLE = ^TCONDITION_VARIABLE;

    TRTL_BARRIER = record
        Reserved1: DWORD;
        Reserved2: DWORD;
        Reserved3: array [0..1] of ULONG_PTR;
        Reserved4: DWORD;
        Reserved5: DWORD;
    end;
    PRTL_BARRIER = ^TRTL_BARRIER;

    TSYNCHRONIZATION_BARRIER = TRTL_BARRIER;
    PSYNCHRONIZATION_BARRIER = PRTL_BARRIER;

    PINIT_ONCE_FN = function(var InitOnce: TINIT_ONCE; var Parameter: pointer; out Context: pointer): boolean;

    PTIMERAPCROUTINE =
        procedure(lpArgToCompletionRoutine: pointer; dwTimerLowValue: DWORD; dwTimerHighValue: DWORD); stdcall;

const
    RTL_SRWLOCK_INIT: TRTL_SRWLOCK = (Ptr: nil);
    SRWLOCK_INIT: TRTL_SRWLOCK = (Ptr: nil);

    CONDITION_VARIABLE_INIT: TRTL_CONDITION_VARIABLE = (Ptr: nil);      // Static initializer for the condition variable

    // Flags for condition variables

    CONDITION_VARIABLE_LOCKMODE_SHARED = RTL_CONDITION_VARIABLE_LOCKMODE_SHARED;

    // Synchronization APIs

    MUTEX_MODIFY_STATE = MUTANT_QUERY_STATE;
    MUTEX_ALL_ACCESS = MUTANT_ALL_ACCESS;

{$IF (_WIN32_WINNT >= $0600)}
procedure InitializeSRWLock(out SRWLock: TSRWLOCK); stdcall; external KERNEL32_DLL;
procedure ReleaseSRWLockExclusive(var SRWLock: TSRWLOCK); stdcall; external KERNEL32_DLL;
procedure ReleaseSRWLockShared(var SRWLock: TSRWLOCK); stdcall; external KERNEL32_DLL;
procedure AcquireSRWLockExclusive(var SRWLock: TSRWLOCK); stdcall; external KERNEL32_DLL;
procedure AcquireSRWLockShared(var SRWLock: TSRWLOCK); stdcall; external KERNEL32_DLL;
function TryAcquireSRWLockExclusive(var SRWLock: TSRWLOCK): boolean; stdcall; external KERNEL32_DLL;
function TryAcquireSRWLockShared(var SRWLock: TSRWLOCK): boolean; stdcall; external KERNEL32_DLL;
  {$ENDIF}// (_WIN32_WINNT >= $0600)

{$IF  (_WIN32_WINNT < $0600)}
procedure InitializeCriticalSection(out lpCriticalSection: LPCRITICAL_SECTION); stdcall; external KERNEL32_DLL;
  {$ELSE}
procedure InitializeCriticalSection(out lpCriticalSection: LPCRITICAL_SECTION); stdcall; external KERNEL32_DLL;
  {$ENDIF}// (_WIN32_WINNT < $0600)


procedure EnterCriticalSection(var lpCriticalSection: LPCRITICAL_SECTION); stdcall; external KERNEL32_DLL;
procedure LeaveCriticalSection(var lpCriticalSection: LPCRITICAL_SECTION); stdcall; external KERNEL32_DLL;
function InitializeCriticalSectionAndSpinCount(out lpCriticalSection: LPCRITICAL_SECTION; dwSpinCount: DWORD): boolean;
    stdcall; external KERNEL32_DLL;

{$IF  (_WIN32_WINNT >= $0600)}
function InitializeCriticalSectionEx(out lpCriticalSection: LPCRITICAL_SECTION; dwSpinCount: DWORD; Flags: DWORD): boolean;
    stdcall; external KERNEL32_DLL;
  {$ENDIF}// (_WIN32_WINNT >= $0600)

function SetCriticalSectionSpinCount(var lpCriticalSection: LPCRITICAL_SECTION; dwSpinCount: DWORD): DWORD; stdcall; external KERNEL32_DLL;

{$IF  (_WIN32_WINNT >= $0400)}
function TryEnterCriticalSection(var lpCriticalSection: LPCRITICAL_SECTION): boolean; stdcall; external KERNEL32_DLL;
   {$ENDIF}(* _WIN32_WINNT >= $0400 *)

procedure DeleteCriticalSection(var lpCriticalSection: LPCRITICAL_SECTION); stdcall; external KERNEL32_DLL;

{$IF  (_WIN32_WINNT >= $0600)}
procedure InitOnceInitialize(out InitOnce: PINIT_ONCE); stdcall; external KERNEL32_DLL;
function InitOnceExecuteOnce(var InitOnce: TINIT_ONCE; InitFn: PINIT_ONCE_FN; {var} Parameter: pointer; out Context: pointer): boolean;
    stdcall; external KERNEL32_DLL;
function InitOnceBeginInitialize(var lpInitOnce: LPINIT_ONCE; dwFlags: DWORD; out fPending: boolean; out lpContext: pointer): boolean;
    stdcall; external KERNEL32_DLL;
function InitOnceComplete(var lpInitOnce: LPINIT_ONCE; dwFlags: DWORD; lpContext: LPVOID): boolean; stdcall; external KERNEL32_DLL;
{$ENDIF}// (_WIN32_WINNT >= $0600)

{$IF  (_WIN32_WINNT >= $0600)}
procedure InitializeConditionVariable(out ConditionVariable: TCONDITION_VARIABLE); stdcall; external KERNEL32_DLL;
procedure WakeConditionVariable(var ConditionVariable: TCONDITION_VARIABLE); stdcall; external KERNEL32_DLL;
procedure WakeAllConditionVariable(var ConditionVariable: TCONDITION_VARIABLE); stdcall; external KERNEL32_DLL;
function SleepConditionVariableCS(var ConditionVariable: PCONDITION_VARIABLE; var CriticalSection: PCRITICAL_SECTION;
    dwMilliseconds: DWORD): boolean; stdcall; external KERNEL32_DLL;
function SleepConditionVariableSRW(var ConditionVariable: TCONDITION_VARIABLE; var SRWLock: TSRWLOCK; dwMilliseconds: DWORD;
    Flags: ULONG): boolean; stdcall; external KERNEL32_DLL;
 {$ENDIF}// (_WIN32_WINNT >= $0600)

function SetEvent(hEvent: THANDLE): boolean; stdcall; external KERNEL32_DLL;
function ResetEvent(hEvent: THANDLE): boolean; stdcall; external KERNEL32_DLL;
function ReleaseSemaphore(hSemaphore: THANDLE; lReleaseCount: LONG; out lpPreviousCount: LONG): boolean; stdcall; external KERNEL32_DLL;
function ReleaseMutex(hMutex: THANDLE): boolean; stdcall; external KERNEL32_DLL;
function WaitForSingleObject(hHandle: THANDLE; dwMilliseconds: DWORD): DWORD; stdcall; external KERNEL32_DLL;
function SleepEx(dwMilliseconds: DWORD; bAlertable: boolean): DWORD; stdcall; external KERNEL32_DLL;
function WaitForSingleObjectEx(hHandle: THANDLE; dwMilliseconds: DWORD; bAlertable: boolean): DWORD; stdcall; external KERNEL32_DLL;
function WaitForMultipleObjectsEx(nCount: DWORD; const lpHandles: PHANDLE {nCount}; bWaitAll: boolean; dwMilliseconds: DWORD;
    bAlertable: boolean): DWORD; stdcall; external KERNEL32_DLL;

// Synchronization APIs
function CreateMutexA(lpMutexAttributes: LPSECURITY_ATTRIBUTES; bInitialOwner: boolean; lpName: LPCSTR): THANDLE; stdcall;
    external KERNEL32_DLL;
function CreateMutexW(lpMutexAttributes: LPSECURITY_ATTRIBUTES; bInitialOwner: boolean; lpName: LPCWSTR): THANDLE; stdcall;
    external KERNEL32_DLL;
function OpenMutexW(dwDesiredAccess: DWORD; bInheritHandle: boolean; lpName: LPCWSTR): THANDLE; stdcall; external KERNEL32_DLL;
function CreateEventA(lpEventAttributes: LPSECURITY_ATTRIBUTES; bManualReset: boolean; bInitialState: boolean; lpName: LPCSTR): THANDLE;
    stdcall; external KERNEL32_DLL;
function CreateEventW(lpEventAttributes: LPSECURITY_ATTRIBUTES; bManualReset: boolean; bInitialState: boolean; lpName: LPCWSTR): THANDLE;
    stdcall; external KERNEL32_DLL;
function OpenEventA(dwDesiredAccess: DWORD; bInheritHandle: boolean; lpName: LPCSTR): THANDLE; stdcall; external KERNEL32_DLL;
function OpenEventW(dwDesiredAccess: DWORD; bInheritHandle: boolean; lpName: LPCWSTR): THANDLE; stdcall; external KERNEL32_DLL;
function OpenSemaphoreW(dwDesiredAccess: DWORD; bInheritHandle: boolean; lpName: LPCWSTR): THANDLE; stdcall; external KERNEL32_DLL;

{$IF  (_WIN32_WINNT >= $0400) OR (_WIN32_WINDOWS > $0400)}
function OpenWaitableTimerW(dwDesiredAccess: DWORD; bInheritHandle: boolean; lpTimerName: LPCWSTR): THANDLE; stdcall;
    external KERNEL32_DLL;

 {$IF (_WIN32_WINNT >= _WIN32_WINNT_WIN7)}
function SetWaitableTimerEx(hTimer: THANDLE; const lpDueTime: LARGE_INTEGER; lPeriod: LONG; pfnCompletionRoutine: PTIMERAPCROUTINE;
    lpArgToCompletionRoutine: LPVOID; WakeContext: PREASON_CONTEXT; TolerableDelay: ULONG): boolean; stdcall; external KERNEL32_DLL;
{$ENDIF}// (_WIN32_WINNT >= _WIN32_WINNT_WIN7)

function SetWaitableTimer(hTimer: THANDLE; const lpDueTime: LARGE_INTEGER; lPeriod: LONG; pfnCompletionRoutine: PTIMERAPCROUTINE;
    lpArgToCompletionRoutine: LPVOID; fResume: boolean): boolean; stdcall; external KERNEL32_DLL;
function CancelWaitableTimer(hTimer: THANDLE): boolean; stdcall; external KERNEL32_DLL;

{$IF  (_WIN32_WINNT >= $0600)}
function CreateMutexExA(lpMutexAttributes: LPSECURITY_ATTRIBUTES; lpName: LPCSTR; dwFlags: DWORD; dwDesiredAccess: DWORD): THANDLE;
    stdcall; external KERNEL32_DLL;
function CreateMutexExW(lpMutexAttributes: LPSECURITY_ATTRIBUTES; lpName: LPCWSTR; dwFlags: DWORD; dwDesiredAccess: DWORD): THANDLE;
    stdcall; external KERNEL32_DLL;
function CreateEventExA(lpEventAttributes: LPSECURITY_ATTRIBUTES; lpName: LPCSTR; dwFlags: DWORD; dwDesiredAccess: DWORD): THANDLE;
    stdcall; external KERNEL32_DLL;
function CreateEventExW(lpEventAttributes: LPSECURITY_ATTRIBUTES; lpName: LPCWSTR; dwFlags: DWORD; dwDesiredAccess: DWORD): THANDLE;
    stdcall; external KERNEL32_DLL;
function CreateSemaphoreExW(lpSemaphoreAttributes: LPSECURITY_ATTRIBUTES; lInitialCount: LONG; lMaximumCount: LONG;
    lpName: LPCWSTR; dwFlags: DWORD; dwDesiredAccess: DWORD): THANDLE; stdcall; external KERNEL32_DLL;
function CreateWaitableTimerExW(lpTimerAttributes: LPSECURITY_ATTRIBUTES; lpTimerName: LPCWSTR; dwFlags: DWORD;
    dwDesiredAccess: DWORD): THANDLE; stdcall; external KERNEL32_DLL;
{$ENDIF}// (_WIN32_WINNT >= $0600)

{$ENDIF}// (_WIN32_WINNT >= $0400) || (_WIN32_WINDOWS > $0400)

function EnterSynchronizationBarrier(var lpBarrier: TSYNCHRONIZATION_BARRIER; dwFlags: DWORD): boolean; stdcall; external KERNEL32_DLL;
function InitializeSynchronizationBarrier(out lpBarrier: TSYNCHRONIZATION_BARRIER; lTotalThreads: LONG; lSpinCount: LONG): boolean;
    stdcall; external KERNEL32_DLL;
function DeleteSynchronizationBarrier(var lpBarrier: TSYNCHRONIZATION_BARRIER): boolean; stdcall; external KERNEL32_DLL;
procedure Sleep(dwMilliseconds: DWORD); stdcall; external KERNEL32_DLL;
function WaitOnAddress(Address: pointer {PByte: AddressSize}; CompareAddress: pointer; AddressSize: SIZE_T; dwMilliseconds: DWORD): boolean;
    stdcall; external KERNEL32_DLL;
procedure WakeByAddressSingle(Address: pointer); stdcall; external KERNEL32_DLL;
procedure WakeByAddressAll(Address: pointer); stdcall; external KERNEL32_DLL;
function SignalObjectAndWait(hObjectToSignal: THANDLE; hObjectToWaitOn: THANDLE; dwMilliseconds: DWORD; bAlertable: boolean): DWORD;
    stdcall; external KERNEL32_DLL;
function WaitForMultipleObjects(nCount: DWORD; const lpHandles: PHANDLE {nCount}; bWaitAll: boolean; dwMilliseconds: DWORD): DWORD;
    stdcall; external KERNEL32_DLL;
function CreateSemaphoreW(lpSemaphoreAttributes: LPSECURITY_ATTRIBUTES; lInitialCount: LONG; lMaximumCount: LONG;
    lpName: LPCWSTR): THANDLE; stdcall; external KERNEL32_DLL;
function CreateWaitableTimerW(lpTimerAttributes: LPSECURITY_ATTRIBUTES; bManualReset: boolean; lpTimerName: LPCWSTR): THANDLE;
    stdcall; external KERNEL32_DLL;

implementation

end.
