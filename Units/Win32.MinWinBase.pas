unit Win32.MinWinBase;

{$mode delphi}


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

{$DEFINE _WIN32_WINNT:=_WIN32_WINNT_WIN10}

interface

uses
    Windows, Classes, SysUtils;

const

{$IF (_WIN32_WINNT >= $0400)}
    FIND_FIRST_EX_CASE_SENSITIVE = $00000001;
    FIND_FIRST_EX_LARGE_FETCH = $00000002;
{$IF  (NTDDI_VERSION >= NTDDI_WIN10_RS4)}
    FIND_FIRST_EX_ON_DISK_ENTRIES_ONLY = $00000004;
{$endif}

    LOCKFILE_FAIL_IMMEDIATELY = $00000001;
    LOCKFILE_EXCLUSIVE_LOCK = $00000002;

    PROCESS_HEAP_REGION = $0001;
    PROCESS_HEAP_UNCOMMITTED_RANGE = $0002;
    PROCESS_HEAP_ENTRY_BUSY = $0004;
    PROCESS_HEAP_SEG_ALLOC = $0008;
    PROCESS_HEAP_ENTRY_MOVEABLE = $0010;
    PROCESS_HEAP_ENTRY_DDESHARE = $0020;


    // Debug APIs

    EXCEPTION_DEBUG_EVENT = 1;
    CREATE_THREAD_DEBUG_EVENT = 2;
    CREATE_PROCESS_DEBUG_EVENT = 3;
    EXIT_THREAD_DEBUG_EVENT = 4;
    EXIT_PROCESS_DEBUG_EVENT = 5;
    LOAD_DLL_DEBUG_EVENT = 6;
    UNLOAD_DLL_DEBUG_EVENT = 7;
    OUTPUT_DEBUG_STRING_EVENT = 8;
    RIP_EVENT = 9;

    (* Local Memory Flags *)
    LMEM_FIXED = $0000;
    LMEM_MOVEABLE = $0002;
    LMEM_NOCOMPACT = $0010;
    LMEM_NODISCARD = $0020;
    LMEM_ZEROINIT = $0040;
    LMEM_MODIFY = $0080;
    LMEM_DISCARDABLE = $0F00;
    LMEM_VALID_FLAGS = $0F72;
    LMEM_INVALID_HANDLE = $8000;

    LHND = (LMEM_MOVEABLE or LMEM_ZEROINIT);
    LPTR = (LMEM_FIXED or LMEM_ZEROINIT);

    NONZEROLHND = (LMEM_MOVEABLE);
    NONZEROLPTR = (LMEM_FIXED);

    (* Flags returned by LocalFlags (in addition to LMEM_DISCARDABLE) *)
    LMEM_DISCARDED = $4000;
    LMEM_LOCKCOUNT = $00FF;


    // NUMA values


    NUMA_NO_PREFERRED_NODE: DWORD = -1;
{$endif}(* _WIN32_WINNT >= $0400 *)

type

    TREASON_CONTEXT_Detailed = record
        LocalizedReasonModule: HMODULE;
        LocalizedReasonId: ULONG;
        ReasonStringCount: ULONG;
        ReasonStrings: PLPWSTR;
    end;

    TREASON_CONTEXT_Reason = record
        case integer of
            0: (Detailed: TREASON_CONTEXT_Detailed);
            1: (SimpleReasonString: LPWSTR);
    end;

    TREASON_CONTEXT = record
        Version: ULONG;
        Flags: DWORD;
        Reason: TREASON_CONTEXT_Reason;
    end;
    PREASON_CONTEXT = ^TREASON_CONTEXT;

implementation

end.


