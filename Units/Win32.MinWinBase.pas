(************************************************************************
*                                                                       *
*   minwinbase.h -- This module defines the 32-Bit Windows Base APIs    *
*                                                                       *
*   Copyright (c) Microsoft Corp. All rights reserved.                  *
*                                                                       *
************************************************************************)
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
{$DEFINE _WIN32_WINNT_WIN10_RS1:=$0A00}(* ABRACADABRA_THRESHOLD*)
{$DEFINE _WIN32_WINNT_WIN10_RS4:=$0A00}(* ABRACADABRA_THRESHOLD*)

{$DEFINE _WIN32_WINNT:=_WIN32_WINNT_WIN10}

interface

uses
    Windows, Classes, SysUtils,
    Win32.NTStatus;

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

    (* compatibility macros *)
    STILL_ACTIVE = STATUS_PENDING;
    EXCEPTION_ACCESS_VIOLATION = STATUS_ACCESS_VIOLATION;
    EXCEPTION_DATATYPE_MISALIGNMENT = STATUS_DATATYPE_MISALIGNMENT;
    EXCEPTION_BREAKPOINT = STATUS_BREAKPOINT;
    EXCEPTION_SINGLE_STEP = STATUS_SINGLE_STEP;
    EXCEPTION_ARRAY_BOUNDS_EXCEEDED = STATUS_ARRAY_BOUNDS_EXCEEDED;
    EXCEPTION_FLT_DENORMAL_OPERAND = STATUS_FLOAT_DENORMAL_OPERAND;
    EXCEPTION_FLT_DIVIDE_BY_ZERO = STATUS_FLOAT_DIVIDE_BY_ZERO;
    EXCEPTION_FLT_INEXACT_RESULT = STATUS_FLOAT_INEXACT_RESULT;
    EXCEPTION_FLT_INVALID_OPERATION = STATUS_FLOAT_INVALID_OPERATION;
    EXCEPTION_FLT_OVERFLOW = STATUS_FLOAT_OVERFLOW;
    EXCEPTION_FLT_STACK_CHECK = STATUS_FLOAT_STACK_CHECK;
    EXCEPTION_FLT_UNDERFLOW = STATUS_FLOAT_UNDERFLOW;
    EXCEPTION_INT_DIVIDE_BY_ZERO = STATUS_INTEGER_DIVIDE_BY_ZERO;
    EXCEPTION_INT_OVERFLOW = STATUS_INTEGER_OVERFLOW;
    EXCEPTION_PRIV_INSTRUCTION = STATUS_PRIVILEGED_INSTRUCTION;
    EXCEPTION_IN_PAGE_ERROR = STATUS_IN_PAGE_ERROR;
    EXCEPTION_ILLEGAL_INSTRUCTION = STATUS_ILLEGAL_INSTRUCTION;
    EXCEPTION_NONCONTINUABLE_EXCEPTION = STATUS_NONCONTINUABLE_EXCEPTION;
    EXCEPTION_STACK_OVERFLOW = STATUS_STACK_OVERFLOW;
    EXCEPTION_INVALID_DISPOSITION = STATUS_INVALID_DISPOSITION;
    EXCEPTION_GUARD_PAGE = STATUS_GUARD_PAGE_VIOLATION;
    EXCEPTION_INVALID_HANDLE = STATUS_INVALID_HANDLE;
    EXCEPTION_POSSIBLE_DEADLOCK = STATUS_POSSIBLE_DEADLOCK;
    CONTROL_C_EXIT = STATUS_CONTROL_C_EXIT;

type

    TSECURITY_ATTRIBUTES = record
        nLength: DWORD;
        lpSecurityDescriptor: LPVOID;
        bInheritHandle: longbool;
    end;
    PSECURITY_ATTRIBUTES = ^TSECURITY_ATTRIBUTES;

    TOVERLAPPED = record
        Internal: ULONG_PTR;
        InternalHigh: ULONG_PTR;
        case integer of
            0: (Offset: DWORD;
                OffsetHigh: DWORD;
                hEvent: THANDLE;);
            1: (_Pointer: PVOID;);
    end;
    POVERLAPPED = ^TOVERLAPPED;

    TOVERLAPPED_ENTRY = record
        lpCompletionKey: ULONG_PTR;
        lpOverlapped: POVERLAPPED;
        Internal: ULONG_PTR;
        dwNumberOfBytesTransferred: DWORD;
    end;
    POVERLAPPED_ENTRY = ^TOVERLAPPED_ENTRY;


    //  File System time stamps are represented with the following structure:



    TFILETIME = record
        dwLowDateTime: DWORD;
        dwHighDateTime: DWORD;
    end;
    PFILETIME = ^TFILETIME;



    // System time is represented with the following structure:


    TSYSTEMTIME = record
        wYear: word;
        wMonth: word;
        wDayOfWeek: word;
        wDay: word;
        wHour: word;
        wMinute: word;
        wSecond: word;
        wMilliseconds: word;
    end;
    PSYSTEMTIME = ^TSYSTEMTIME;


    TWIN32_FIND_DATAA = record
        dwFileAttributes: DWORD;
        ftCreationTime: TFILETIME;
        ftLastAccessTime: TFILETIME;
        ftLastWriteTime: TFILETIME;
        nFileSizeHigh: DWORD;
        nFileSizeLow: DWORD;
        dwReserved0: DWORD;
        dwReserved1: DWORD;
        cFileName: array [0.. MAX_PATH - 1] of char;
        cAlternateFileName: array[0..13] of char;
{$IFDEF _MAC}
        dwFileType: DWORD;
        dwCreatorType: DWORD;
        wFinderFlags: word;
{$ENDIF}

    end;
    PWIN32_FIND_DATAA = ^TWIN32_FIND_DATAA;


    TWIN32_FIND_DATAW = record
        dwFileAttributes: DWORD;
        ftCreationTime: TFILETIME;
        ftLastAccessTime: TFILETIME;
        ftLastWriteTime: TFILETIME;
        nFileSizeHigh: DWORD;
        nFileSizeLow: DWORD;
        dwReserved0: DWORD;
        dwReserved1: DWORD;
        cFileName: array[0.. MAX_PATH - 1] of WCHAR;
        cAlternateFileName: array [0.. 13] of WCHAR;
{$IFDEF _MAC}
        dwFileType: DWORD;
        dwCreatorType: DWORD;
        wFinderFlags: word;
{$endif}
    end;
    PWIN32_FIND_DATAW = ^TWIN32_FIND_DATAW;



{$IF (_WIN32_WINNT >= $0400)}
    TFINDEX_INFO_LEVELS = (
        FindExInfoStandard,
        FindExInfoBasic,
        FindExInfoMaxInfoLevel);



    TFINDEX_SEARCH_OPS = (
        FindExSearchNameMatch,
        FindExSearchLimitToDirectories,
        FindExSearchLimitToDevices,
        FindExSearchMaxSearchOp);
{$endif}(* _WIN32_WINNT >= $0400 *)

{$IF (_WIN32_WINNT >= $0400)}
{$IF  (NTDDI_VERSION >= NTDDI_WIN10_RS3)}
    TREAD_DIRECTORY_NOTIFY_INFORMATION_CLASS = (
        ReadDirectoryNotifyInformation = 1,
        ReadDirectoryNotifyExtendedInformation // 2
        );
    PREAD_DIRECTORY_NOTIFY_INFORMATION_CLASS = ^TREAD_DIRECTORY_NOTIFY_INFORMATION_CLASS;
{$endif}
{$endif}(* _WIN32_WINNT >= $0400 *)

    TGET_FILEEX_INFO_LEVELS = (
        GetFileExInfoStandard,
        GetFileExMaxInfoLevel);

{$IF (_WIN32_WINNT >= _WIN32_WINNT_LONGHORN)}
    TFILE_INFO_BY_HANDLE_CLASS = (
        FileBasicInfo,
        FileStandardInfo,
        FileNameInfo,
        FileRenameInfo,
        FileDispositionInfo,
        FileAllocationInfo,
        FileEndOfFileInfo,
        FileStreamInfo,
        FileCompressionInfo,
        FileAttributeTagInfo,
        FileIdBothDirectoryInfo,
        FileIdBothDirectoryRestartInfo,
        FileIoPriorityHintInfo,
        FileRemoteProtocolInfo,
        FileFullDirectoryInfo,
        FileFullDirectoryRestartInfo,
{$if (_WIN32_WINNT >= _WIN32_WINNT_WIN8)}
        FileStorageInfo,
        FileAlignmentInfo,
        FileIdInfo,
        FileIdExtdDirectoryInfo,
        FileIdExtdDirectoryRestartInfo,
{$ENDIF}
{$if (_WIN32_WINNT >= _WIN32_WINNT_WIN10_RS1) }
        FileDispositionInfoEx,
        FileRenameInfoEx,
    {$ENDIF}
        MaximumFileInfoByHandleClass);
    PFILE_INFO_BY_HANDLE_CLASS = ^TFILE_INFO_BY_HANDLE_CLASS;
{$ENDIF}

    POVERLAPPED_COMPLETION_ROUTINE = procedure(dwErrorCode: DWORD; dwNumberOfBytesTransfered: DWORD; var lpOverlapped: TOVERLAPPED); stdcall;



    TPROCESS_HEAP_ENTRY_Block = record
        hMem: THANDLE;
        dwReserved: array [0..2] of DWORD;
    end;

    TPROCESS_HEAP_ENTRY_Region = record
        dwCommittedSize: DWORD;
        dwUnCommittedSize: DWORD;
        lpFirstBlock: pointer;
        lpLastBlock: pointer;
    end;

    TPROCESS_HEAP_ENTRY = record
        lpData: pointer;
        cbData: DWORD;
        cbOverhead: byte;
        iRegionIndex: byte;
        wFlags: word;
        case integer of
            0: (Block: TPROCESS_HEAP_ENTRY_Block);
            1: (Region: TPROCESS_HEAP_ENTRY_Region);
    end;
    PPROCESS_HEAP_ENTRY = ^TPROCESS_HEAP_ENTRY;

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

    PTHREAD_START_ROUTINE = function(lpThreadParameter: pointer): DWORD; stdcall;



    PENCLAVE_ROUTINE = function(lpThreadParameter: pointer): pointer; stdcall;


    TEXCEPTION_DEBUG_INFO = record
        ExceptionRecord: TEXCEPTION_RECORD;
        dwFirstChance: DWORD;
    end;
    PEXCEPTION_DEBUG_INFO = ^TEXCEPTION_DEBUG_INFO;

    TCREATE_THREAD_DEBUG_INFO = record
        hThread: THANDLE;
        lpThreadLocalBase: pointer;
        lpStartAddress: PTHREAD_START_ROUTINE;
    end;
    PCREATE_THREAD_DEBUG_INFO = ^TCREATE_THREAD_DEBUG_INFO;

    TCREATE_PROCESS_DEBUG_INFO = record
        hFile: THANDLE;
        hProcess: THANDLE;
        hThread: THANDLE;
        lpBaseOfImage: pointer;
        dwDebugInfoFileOffset: DWORD;
        nDebugInfoSize: DWORD;
        lpThreadLocalBase: pointer;
        lpStartAddress: PTHREAD_START_ROUTINE;
        lpImageName: pointer;
        fUnicode: word;
    end;
    PCREATE_PROCESS_DEBUG_INFO = ^TCREATE_PROCESS_DEBUG_INFO;

    TEXIT_THREAD_DEBUG_INFO = record
        dwExitCode: DWORD;
    end;
    PEXIT_THREAD_DEBUG_INFO = ^TEXIT_THREAD_DEBUG_INFO;

    TEXIT_PROCESS_DEBUG_INFO = record
        dwExitCode: DWORD;
    end;
    PEXIT_PROCESS_DEBUG_INFO = ^TEXIT_PROCESS_DEBUG_INFO;

    TLOAD_DLL_DEBUG_INFO = record
        hFile: THANDLE;
        lpBaseOfDll: pointer;
        dwDebugInfoFileOffset: DWORD;
        nDebugInfoSize: DWORD;
        lpImageName: pointer;
        fUnicode: word;
    end;
    PLOAD_DLL_DEBUG_INFO = ^TLOAD_DLL_DEBUG_INFO;

    TUNLOAD_DLL_DEBUG_INFO = record
        lpBaseOfDll: pointer;
    end;
    PUNLOAD_DLL_DEBUG_INFO = ^TUNLOAD_DLL_DEBUG_INFO;

    TOUTPUT_DEBUG_STRING_INFO = record
        lpDebugStringData: LPSTR;
        fUnicode: word;
        nDebugStringLength: word;
    end;
    POUTPUT_DEBUG_STRING_INFO = ^TOUTPUT_DEBUG_STRING_INFO;

    TRIP_INFO = record
        dwError: DWORD;
        dwType: DWORD;
    end;
    PRIP_INFO = ^TRIP_INFO;


    TDEBUG_EVENT = record
        dwDebugEventCode: DWORD;
        dwProcessId: DWORD;
        dwThreadId: DWORD;
        case integer of
            0: (Exception: TEXCEPTION_DEBUG_INFO);
            1: (CreateThread: TCREATE_THREAD_DEBUG_INFO);
            2: (CreateProcessInfo: TCREATE_PROCESS_DEBUG_INFO);
            3: (ExitThread: TEXIT_THREAD_DEBUG_INFO);
            4: (ExitProcess: TEXIT_PROCESS_DEBUG_INFO);
            5: (LoadDll: TLOAD_DLL_DEBUG_INFO);
            6: (UnloadDll: TUNLOAD_DLL_DEBUG_INFO);
            7: (DebugString: TOUTPUT_DEBUG_STRING_INFO);
            8: (RipInfo: TRIP_INFO);
    end;
    PDEBUG_EVENT = ^TDEBUG_EVENT;

    function LocalDiscard( hMem:HLOCAL ):HLOCAL; stdcall;

implementation

function LocalDiscard(hMem: HLOCAL): HLOCAL; stdcall;  inline;
begin
    result:=LocalReAlloc(hMem,0, LMEM_MOVEABLE);
end;



end.














