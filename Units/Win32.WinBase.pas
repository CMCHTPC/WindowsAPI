unit Win32.WinBase;

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

 (************************************************************************
*                                                                       *
*   winbase.h -- This module defines the 32-Bit Windows Base APIs       *
*                                                                       *
*   Copyright (c) Microsoft Corp. All rights reserved.                  *
*                                                                       *
************************************************************************)

{ Header Definition: 10.0.17134.0 }

{$IFDEF FPC}
{$mode delphi}{$H+}
{$ENDIF}
{$MACRO ON}

{$I Win32.WinAPI.inc}


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
{$DEFINE _WIN32_WINNT_WIN10_RS1:=$0A00}
{$DEFINE _WIN32_WINNT_WIN10_RS4:=$0A00}


{$DEFINE _WIN32_WINNT:=_WIN32_WINNT_WIN10}

interface

uses
    Windows, Classes, SysUtils,
    Win32.WinNT;

const

    KERNEL32_DLL = 'Kernel32.dll';

    FILE_BEGIN = 0;
    FILE_CURRENT = 1;
    FILE_END = 2;


    WAIT_FAILED: DWORD = $FFFFFFFF;
    WAIT_OBJECT_0 = ((STATUS_WAIT_0) + 0);

    WAIT_ABANDONED = ((STATUS_ABANDONED_WAIT_0) + 0);
    WAIT_ABANDONED_0 = ((STATUS_ABANDONED_WAIT_0) + 0);

    WAIT_IO_COMPLETION = STATUS_USER_APC;

    // ToDo    SecureZeroMemory = RtlSecureZeroMemory;
    // ToDo    CaptureStackBackTrace = RtlCaptureStackBackTrace;




    // File creation flags must start at the high end since they
    // are combined with the attributes

    //  These are flags supported through CreateFile (W7) and CreateFile2 (W8 and beyond)
    FILE_FLAG_WRITE_THROUGH = $80000000;
    FILE_FLAG_OVERLAPPED = $40000000;
    FILE_FLAG_NO_BUFFERING = $20000000;
    FILE_FLAG_RANDOM_ACCESS = $10000000;
    FILE_FLAG_SEQUENTIAL_SCAN = $08000000;
    FILE_FLAG_DELETE_ON_CLOSE = $04000000;
    FILE_FLAG_BACKUP_SEMANTICS = $02000000;
    FILE_FLAG_POSIX_SEMANTICS = $01000000;
    FILE_FLAG_SESSION_AWARE = $00800000;
    FILE_FLAG_OPEN_REPARSE_POINT = $00200000;
    FILE_FLAG_OPEN_NO_RECALL = $00100000;
    FILE_FLAG_FIRST_PIPE_INSTANCE = $00080000;


{$IF  (_WIN32_WINNT >= _WIN32_WINNT_WIN8)}


    //  These are flags supported only through CreateFile2 (W8 and beyond)

    //  Due to the multiplexing of file creation flags, file attribute flags and
    //  security QoS flags into a single DWORD (dwFlagsAndAttributes) parameter for
    //  CreateFile, there is no way to add any more flags to CreateFile. Additional
    //  flags for the create operation must be added to CreateFile2 only


    FILE_FLAG_OPEN_REQUIRING_OPLOCK = $00040000;

{$ENDIF}



{$IF (_WIN32_WINNT >= $0400)}
    // Define possible return codes from the CopyFileEx callback routine
    PROGRESS_CONTINUE = 0;
    PROGRESS_CANCEL = 1;
    PROGRESS_STOP = 2;
    PROGRESS_QUIET = 3;

    // Define CopyFileEx callback routine state change values
    CALLBACK_CHUNK_FINISHED = $00000000;
    CALLBACK_STREAM_SWITCH = $00000001;

    // Define CopyFileEx option flags
    COPY_FILE_FAIL_IF_EXISTS = $00000001;
    COPY_FILE_RESTARTABLE = $00000002;
    COPY_FILE_OPEN_SOURCE_FOR_WRITE = $00000004;
    COPY_FILE_ALLOW_DECRYPTED_DESTINATION = $00000008;

    //  Gap for private copyfile flags
{$IF  (_WIN32_WINNT >= $0600)}
    COPY_FILE_COPY_SYMLINK = $00000800;
    COPY_FILE_NO_BUFFERING = $00001000;
{$ENDIF}


{$IF  (_WIN32_WINNT >= _WIN32_WINNT_WIN8)}
    //  CopyFile2 flags
    COPY_FILE_REQUEST_SECURITY_PRIVILEGES = $00002000;
    COPY_FILE_RESUME_FROM_PAUSE = $00004000;
    COPY_FILE_NO_OFFLOAD = $00040000;
{$ENDIF}

{$IF  (_WIN32_WINNT >= _WIN32_WINNT_WIN10)}
    COPY_FILE_IGNORE_EDP_BLOCK = $00400000;
    COPY_FILE_IGNORE_SOURCE_ENCRYPTION = $00800000;

{$ENDIF}

{$ENDIF}(* _WIN32_WINNT >= $0400 *)




{$IF  (_WIN32_WINNT >= $0500)}
    // Define ReplaceFile option flags
    REPLACEFILE_WRITE_THROUGH = $00000001;
    REPLACEFILE_IGNORE_MERGE_ERRORS = $00000002;
{$IF  (_WIN32_WINNT >= $0600)}
    REPLACEFILE_IGNORE_ACL_ERRORS = $00000004;
{$ENDIF}

{$ENDIF}// {$IF  (_WIN32_WINNT >= $0500)


    // Define the NamedPipe definitions

    // Define the dwOpenMode values for CreateNamedPipe
    PIPE_ACCESS_INBOUND = $00000001;
    PIPE_ACCESS_OUTBOUND = $00000002;
    PIPE_ACCESS_DUPLEX = $00000003;

    // Define the Named Pipe End flags for GetNamedPipeInfo
    PIPE_CLIENT_END = $00000000;
    PIPE_SERVER_END = $00000001;

    // Define the dwPipeMode values for CreateNamedPipe
    PIPE_WAIT = $00000000;
    PIPE_NOWAIT = $00000001;
    PIPE_READMODE_BYTE = $00000000;
    PIPE_READMODE_MESSAGE = $00000002;
    PIPE_TYPE_BYTE = $00000000;
    PIPE_TYPE_MESSAGE = $00000004;
    PIPE_ACCEPT_REMOTE_CLIENTS = $00000000;
    PIPE_REJECT_REMOTE_CLIENTS = $00000008;

    // Define the well known values for CreateNamedPipe nMaxInstances
    PIPE_UNLIMITED_INSTANCES = 255;


    // Define the Security Quality of Service bits to be passed
    // into CreateFile
    SECURITY_ANONYMOUS = (Ord(SecurityAnonymous) shl 16);
    SECURITY_IDENTIFICATION = (Ord(SecurityIdentification) shl 16);
    SECURITY_IMPERSONATION = (Ord(SecurityImpersonation) shl 16);
    SECURITY_DELEGATION = (Ord(SecurityDelegation) shl 16);

    SECURITY_CONTEXT_TRACKING = $00040000;
    SECURITY_EFFECTIVE_ONLY = $00080000;

    SECURITY_SQOS_PRESENT = $00100000;
    SECURITY_VALID_SQOS_FLAGS = $001F0000;


    // FailFast Exception Flags
    FAIL_FAST_GENERATE_EXCEPTION_ADDRESS = $1;
    FAIL_FAST_NO_HARD_ERROR_DLG = $2;


    // Serial provider type.
    SP_SERIALCOMM: DWORD = $00000001;


    // Provider SubTypes
    PST_UNSPECIFIED: DWORD = $00000000;
    PST_RS232: DWORD = $00000001;
    PST_PARALLELPORT: DWORD = $00000002;
    PST_RS422: DWORD = $00000003;
    PST_RS423: DWORD = $00000004;
    PST_RS449: DWORD = $00000005;
    PST_MODEM: DWORD = $00000006;
    PST_FAX: DWORD = $00000021;
    PST_SCANNER: DWORD = $00000022;
    PST_NETWORK_BRIDGE: DWORD = $00000100;
    PST_LAT: DWORD = $00000101;
    PST_TCPIP_TELNET: DWORD = $00000102;
    PST_X25: DWORD = $00000103;

    // Provider capabilities flags.
    PCF_DTRDSR: DWORD = $0001;
    PCF_RTSCTS: DWORD = $0002;
    PCF_RLSD: DWORD = $0004;
    PCF_PARITY_CHECK: DWORD = $0008;
    PCF_XONXOFF: DWORD = $0010;
    PCF_SETXCHAR: DWORD = $0020;
    PCF_TOTALTIMEOUTS: DWORD = $0040;
    PCF_INTTIMEOUTS: DWORD = $0080;
    PCF_SPECIALCHARS: DWORD = $0100;
    PCF_16BITMODE: DWORD = $0200;

    // Comm provider settable parameters.
    SP_PARITY: DWORD = $0001;
    SP_BAUD: DWORD = $0002;
    SP_DATABITS: DWORD = $0004;
    SP_STOPBITS: DWORD = $0008;
    SP_HANDSHAKING: DWORD = $0010;
    SP_PARITY_CHECK: DWORD = $0020;
    SP_RLSD: DWORD = $0040;

    // Settable baud rates in the provider.
    BAUD_075: DWORD = $00000001;
    BAUD_110: DWORD = $00000002;
    BAUD_134_5: DWORD = $00000004;
    BAUD_150: DWORD = $00000008;
    BAUD_300: DWORD = $00000010;
    BAUD_600: DWORD = $00000020;
    BAUD_1200: DWORD = $00000040;
    BAUD_1800: DWORD = $00000080;
    BAUD_2400: DWORD = $00000100;
    BAUD_4800: DWORD = $00000200;
    BAUD_7200: DWORD = $00000400;
    BAUD_9600: DWORD = $00000800;
    BAUD_14400: DWORD = $00001000;
    BAUD_19200: DWORD = $00002000;
    BAUD_38400: DWORD = $00004000;
    BAUD_56K: DWORD = $00008000;
    BAUD_128K: DWORD = $00010000;
    BAUD_115200: DWORD = $00020000;
    BAUD_57600: DWORD = $00040000;
    BAUD_USER: DWORD = $10000000;

    // Settable Data Bits
    DATABITS_5: word = $0001;
    DATABITS_6: word = $0002;
    DATABITS_7: word = $0004;
    DATABITS_8: word = $0008;
    DATABITS_16: word = $0010;
    DATABITS_16X: word = $0020;

    // Settable Stop and Parity bits.
    STOPBITS_10: word = $0001;
    STOPBITS_15: word = $0002;
    STOPBITS_20: word = $0004;
    PARITY_NONE: word = $0100;
    PARITY_ODD: word = $0200;
    PARITY_EVEN: word = $0400;
    PARITY_MARK: word = $0800;
    PARITY_SPACE: word = $1000;


    // Set dwProvSpec1 to COMMPROP_INITIALIZED to indicate that wPacketLength
    // is valid before a call to GetCommProperties().
    COMMPROP_INITIALIZED: DWORD = $E73CF52E;

    // DTR Control Flow Values.
    DTR_CONTROL_DISABLE = $00;
    DTR_CONTROL_ENABLE = $01;
    DTR_CONTROL_HANDSHAKE = $02;

    // RTS Control Flow Values
    RTS_CONTROL_DISABLE = $00;
    RTS_CONTROL_ENABLE = $01;
    RTS_CONTROL_HANDSHAKE = $02;
    RTS_CONTROL_TOGGLE = $03;

    (* Global Memory Flags *)
    GMEM_FIXED = $0000;
    GMEM_MOVEABLE = $0002;
    GMEM_NOCOMPACT = $0010;
    GMEM_NODISCARD = $0020;
    GMEM_ZEROINIT = $0040;
    GMEM_MODIFY = $0080;
    GMEM_DISCARDABLE = $0100;
    GMEM_NOT_BANKED = $1000;
    GMEM_SHARE = $2000;
    GMEM_DDESHARE = $2000;
    GMEM_NOTIFY = $4000;
    GMEM_LOWER = GMEM_NOT_BANKED;
    GMEM_VALID_FLAGS = $7F72;
    GMEM_INVALID_HANDLE = $8000;

    GHND = GMEM_MOVEABLE or GMEM_ZEROINIT;
    GPTR = GMEM_FIXED or GMEM_ZEROINIT;


    (* Flags returned by GlobalFlags (in addition to GMEM_DISCARDABLE) *)
    GMEM_DISCARDED = $4000;
    GMEM_LOCKCOUNT = $00FF;



    // Process dwCreationFlag values
    DEBUG_PROCESS = $00000001;
    DEBUG_ONLY_THIS_PROCESS = $00000002;
    CREATE_SUSPENDED = $00000004;
    DETACHED_PROCESS = $00000008;

    CREATE_NEW_CONSOLE = $00000010;
    NORMAL_PRIORITY_CLASS = $00000020;
    IDLE_PRIORITY_CLASS = $00000040;
    HIGH_PRIORITY_CLASS = $00000080;

    REALTIME_PRIORITY_CLASS = $00000100;
    CREATE_NEW_PROCESS_GROUP = $00000200;
    CREATE_UNICODE_ENVIRONMENT = $00000400;
    CREATE_SEPARATE_WOW_VDM = $00000800;

    CREATE_SHARED_WOW_VDM = $00001000;
    CREATE_FORCEDOS = $00002000;
    BELOW_NORMAL_PRIORITY_CLASS = $00004000;
    ABOVE_NORMAL_PRIORITY_CLASS = $00008000;

    INHERIT_PARENT_AFFINITY = $00010000;
    INHERIT_CALLER_PRIORITY = $00020000;    // Deprecated
    CREATE_PROTECTED_PROCESS = $00040000;
    EXTENDED_STARTUPINFO_PRESENT = $00080000;

    PROCESS_MODE_BACKGROUND_BEGIN = $00100000;
    PROCESS_MODE_BACKGROUND_END = $00200000;
    CREATE_SECURE_PROCESS = $00400000;

    CREATE_BREAKAWAY_FROM_JOB = $01000000;
    CREATE_PRESERVE_CODE_AUTHZ_LEVEL = $02000000;
    CREATE_DEFAULT_ERROR_MODE = $04000000;
    CREATE_NO_WINDOW = $08000000;

    PROFILE_USER = $10000000;
    PROFILE_KERNEL = $20000000;
    PROFILE_SERVER = $40000000;
    CREATE_IGNORE_SYSTEM_DEFAULT = $80000000;


    // Thread dwCreationFlag values
    // CREATE_SUSPENDED                  $00000004
    STACK_SIZE_PARAM_IS_A_RESERVATION = $00010000;    // Threads only

    // Priority flags


    // from WinNT.h
    THREAD_DYNAMIC_CODE_ALLOW = 1;    // Opt-out of dynamic code generation.

    THREAD_BASE_PRIORITY_LOWRT = 15;  // value that gets a thread to LowRealtime-1
    THREAD_BASE_PRIORITY_MAX = 2;  // maximum thread base priority boost
    THREAD_BASE_PRIORITY_MIN = (-2);  // minimum thread base priority boost
    THREAD_BASE_PRIORITY_IDLE = (-15); // value that gets a thread to idle


    THREAD_PRIORITY_LOWEST = THREAD_BASE_PRIORITY_MIN;
    THREAD_PRIORITY_BELOW_NORMAL = (THREAD_PRIORITY_LOWEST + 1);
    THREAD_PRIORITY_NORMAL = 0;
    THREAD_PRIORITY_HIGHEST = THREAD_BASE_PRIORITY_MAX;
    THREAD_PRIORITY_ABOVE_NORMAL = (THREAD_PRIORITY_HIGHEST - 1);
    THREAD_PRIORITY_ERROR_RETURN = (MAXLONG);

    THREAD_PRIORITY_TIME_CRITICAL = THREAD_BASE_PRIORITY_LOWRT;
    THREAD_PRIORITY_IDLE = THREAD_BASE_PRIORITY_IDLE;

    THREAD_MODE_BACKGROUND_BEGIN = $00010000;
    THREAD_MODE_BACKGROUND_END = $00020000;


    // GetFinalPathNameByHandle
    VOLUME_NAME_DOS = $0;      //default
    VOLUME_NAME_GUID = $1;
    VOLUME_NAME_NT = $2;
    VOLUME_NAME_NONE = $4;

    FILE_NAME_NORMALIZED = $0; //default
    FILE_NAME_OPENED = $8;


    DRIVE_UNKNOWN = 0;
    DRIVE_NO_ROOT_DIR = 1;
    DRIVE_REMOVABLE = 2;
    DRIVE_FIXED = 3;
    DRIVE_REMOTE = 4;
    DRIVE_CDROM = 5;
    DRIVE_RAMDISK = 6;



    FILE_TYPE_UNKNOWN = $0000;
    FILE_TYPE_DISK = $0001;
    FILE_TYPE_CHAR = $0002;
    FILE_TYPE_PIPE = $0003;
    FILE_TYPE_REMOTE = $8000;


    STD_INPUT_HANDLE: DWORD = -10;
    STD_OUTPUT_HANDLE: DWORD = -11;
    STD_ERROR_HANDLE: DWORD = -12;

    NOPARITY = 0;
    ODDPARITY = 1;
    EVENPARITY = 2;
    MARKPARITY = 3;
    SPACEPARITY = 4;

    ONESTOPBIT = 0;
    ONE5STOPBITS = 1;
    TWOSTOPBITS = 2;

    IGNORE = 0;      // Ignore signal
    INFINITE = $FFFFFFFF; // Infinite timeout


    // Baud rates at which the communication device operates
    CBR_110 = 110;
    CBR_300 = 300;
    CBR_600 = 600;
    CBR_1200 = 1200;
    CBR_2400 = 2400;
    CBR_4800 = 4800;
    CBR_9600 = 9600;
    CBR_14400 = 14400;
    CBR_19200 = 19200;
    CBR_38400 = 38400;
    CBR_56000 = 56000;
    CBR_57600 = 57600;
    CBR_115200 = 115200;
    CBR_128000 = 128000;
    CBR_256000 = 256000;


    // Error Flags
    CE_RXOVER = $0001;  // Receive Queue overflow
    CE_OVERRUN = $0002;  // Receive Overrun Error
    CE_RXPARITY = $0004;  // Receive Parity Error
    CE_FRAME = $0008;  // Receive Framing error
    CE_BREAK = $0010;  // Break Detected
    CE_TXFULL = $0100;  // TX Queue is full
    CE_PTO = $0200;  // LPTx Timeout
    CE_IOE = $0400;  // LPTx I/O Error
    CE_DNS = $0800;  // LPTx Device not selected
    CE_OOP = $1000;  // LPTx Out-Of-Paper
    CE_MODE = $8000;  // Requested mode unsupported

    IE_BADID = -1;    // Invalid or unsupported id
    IE_OPEN = -2;    // Device Already Open
    IE_NOPEN = -3;    // Device Not Open
    IE_MEMORY = -4;    // Unable to allocate queues
    IE_DEFAULT = -5;    // Error in default parameters
    IE_HARDWARE = -10;   // Hardware Not Present
    IE_BYTESIZE = -11;   // Illegal Byte Size
    IE_BAUDRATE = -12;   // Unsupported BaudRate


    // Events
    EV_RXCHAR = $0001;  // Any Character received
    EV_RXFLAG = $0002;  // Received certain character
    EV_TXEMPTY = $0004;  // Transmitt Queue Empty
    EV_CTS = $0008;  // CTS changed state
    EV_DSR = $0010;  // DSR changed state
    EV_RLSD = $0020;  // RLSD changed state
    EV_BREAK = $0040;  // BREAK received
    EV_ERR = $0080;  // Line status error occurred
    EV_RING = $0100;  // Ring signal detected
    EV_PERR = $0200;  // Printer error occured
    EV_RX80FULL = $0400;  // Receive buffer is 80 percent full
    EV_EVENT1 = $0800;  // Provider specific event 1
    EV_EVENT2 = $1000;  // Provider specific event 2


    // Escape Functions
    SETXOFF = 1;       // Simulate XOFF received
    SETXON = 2;       // Simulate XON received
    SETRTS = 3;       // Set RTS high
    CLRRTS = 4;       // Set RTS low
    SETDTR = 5;       // Set DTR high
    CLRDTR = 6;       // Set DTR low
    RESETDEV = 7;       // Reset device if possible
    SETBREAK = 8;       // Set the device break line.
    CLRBREAK = 9;       // Clear the device break line.


    // PURGE function flags.
    PURGE_TXABORT = $0001;  // Kill the pending/current writes to the comm port.
    PURGE_RXABORT = $0002;  // Kill the pending/current reads to the comm port.
    PURGE_TXCLEAR = $0004;  // Kill the transmit queue if there.
    PURGE_RXCLEAR = $0008;  // Kill the typeahead buffer if there.

    LPTx = $80;    // Set if ID is for LPT device


    // Modem Status Flags
    MS_CTS_ON: DWORD = $0010;
    MS_DSR_ON: DWORD = $0020;
    MS_RING_ON: DWORD = $0040;
    MS_RLSD_ON: DWORD = $0080;


    // WaitSoundState() Constants
    S_QUEUEEMPTY = 0;
    S_THRESHOLD = 1;
    S_ALLTHRESHOLD = 2;


    // Accent Modes


    S_NORMAL = 0;
    S_LEGATO = 1;
    S_STACCATO = 2;


    // SetSoundNoise() Sources
    S_PERIOD512 = 0;     // Freq = N/512 high pitch, less coarse hiss
    S_PERIOD1024 = 1;     // Freq = N/1024
    S_PERIOD2048 = 2;     // Freq = N/2048 low pitch, more coarse hiss
    S_PERIODVOICE = 3;     // Source is frequency from voice channel (3)
    S_WHITE512 = 4;     // Freq = N/512 high pitch, less coarse hiss
    S_WHITE1024 = 5;     // Freq = N/1024
    S_WHITE2048 = 6;     // Freq = N/2048 low pitch, more coarse hiss
    S_WHITEVOICE = 7;     // Source is frequency from voice channel (3)

    S_SERDVNA = -1;  // Device not available
    S_SEROFM = -2;  // Out of memory
    S_SERMACT = -3;  // Music active
    S_SERQFUL = -4;  // Queue full
    S_SERBDNT = -5;  // Invalid note
    S_SERDLN = -6;  // Invalid note length
    S_SERDCC = -7;  // Invalid note count
    S_SERDTP = -8;  // Invalid tempo
    S_SERDVL = -9;  // Invalid volume
    S_SERDMD = -10; // Invalid mode
    S_SERDSH = -11; // Invalid shape
    S_SERDPT = -12; // Invalid pitch
    S_SERDFQ = -13; // Invalid frequency
    S_SERDDR = -14; // Invalid duration
    S_SERDSR = -15; // Invalid source
    S_SERDST = -16; // Invalid state

    NMPWAIT_WAIT_FOREVER = $ffffffff;
    NMPWAIT_NOWAIT = $00000001;
    NMPWAIT_USE_DEFAULT_WAIT = $00000000;

    FS_CASE_IS_PRESERVED = FILE_CASE_PRESERVED_NAMES;
    FS_CASE_SENSITIVE = FILE_CASE_SENSITIVE_SEARCH;
    FS_UNICODE_STORED_ON_DISK = FILE_UNICODE_ON_DISK;
    FS_PERSISTENT_ACLS = FILE_PERSISTENT_ACLS;
    FS_VOL_IS_COMPRESSED = FILE_VOLUME_IS_COMPRESSED;
    FS_FILE_COMPRESSION = FILE_FILE_COMPRESSION;
    FS_FILE_ENCRYPTION = FILE_SUPPORTS_ENCRYPTION;

    OF_READ = $00000000;
    OF_WRITE = $00000001;
    OF_READWRITE = $00000002;
    OF_SHARE_COMPAT = $00000000;
    OF_SHARE_EXCLUSIVE = $00000010;
    OF_SHARE_DENY_WRITE = $00000020;
    OF_SHARE_DENY_READ = $00000030;
    OF_SHARE_DENY_NONE = $00000040;
    OF_PARSE = $00000100;
    OF_DELETE = $00000200;
    OF_VERIFY = $00000400;
    OF_CANCEL = $00000800;
    OF_CREATE = $00001000;
    OF_PROMPT = $00002000;
    OF_EXIST = $00004000;
    OF_REOPEN = $00008000;

    OFS_MAXPATHNAME = 128;

    MAXINTATOM = $C000;

    // GetBinaryType return values.
    SCS_32BIT_BINARY = 0;
    SCS_DOS_BINARY = 1;
    SCS_WOW_BINARY = 2;
    SCS_PIF_BINARY = 3;
    SCS_POSIX_BINARY = 4;
    SCS_OS216_BINARY = 5;
    SCS_64BIT_BINARY = 6;

{$IF  defined(_WIN64)}
    SCS_THIS_PLATFORM_BINARY = SCS_64BIT_BINARY;
{$ELSE}
    SCS_THIS_PLATFORM_BINARY = SCS_32BIT_BINARY;
{$ENDIF}

{$IF  (_WIN32_WINNT >= $0600)}
    PROCESS_DEP_ENABLE = $00000001;
    PROCESS_DEP_DISABLE_ATL_THUNK_EMULATION = $00000002;
{$ENDIF}

    // Zeile 7677

{$IF (_WIN32_WINNT >= _WIN32_WINNT_WIN10_RS1)}
    FILE_DISPOSITION_FLAG_DO_NOT_DELETE = $00000000;
    FILE_DISPOSITION_FLAG_DELETE = $00000001;
    FILE_DISPOSITION_FLAG_POSIX_SEMANTICS = $00000002;
    FILE_DISPOSITION_FLAG_FORCE_IMAGE_SECTION_CHECK = $00000004;
    FILE_DISPOSITION_FLAG_ON_CLOSE = $00000008;
{$ENDIF}

type
    TCOMMPROP = record
        wPacketLength: word;
        wPacketVersion: word;
        dwServiceMask: DWORD;
        dwReserved1: DWORD;
        dwMaxTxQueue: DWORD;
        dwMaxRxQueue: DWORD;
        dwMaxBaud: DWORD;
        dwProvSubType: DWORD;
        dwProvCapabilities: DWORD;
        dwSettableParams: DWORD;
        dwSettableBaud: DWORD;
        wSettableData: word;
        wSettableStopParity: word;
        dwCurrentTxQueue: DWORD;
        dwCurrentRxQueue: DWORD;
        dwProvSpec1: DWORD;
        dwProvSpec2: DWORD;
        wcProvChar: PWideChar;
    end;
    PCOMMPROP = ^TCOMMPROP;



    TMEMORYSTATUS = record
        dwLength: DWORD;
        dwMemoryLoad: DWORD;
        dwTotalPhys: SIZE_T;
        dwAvailPhys: SIZE_T;
        dwTotalPageFile: SIZE_T;
        dwAvailPageFile: SIZE_T;
        dwTotalVirtual: SIZE_T;
        dwAvailVirtual: SIZE_T;
    end;
    PMEMORYSTATUS = ^TMEMORYSTATUS;




    // JIT Debugging Info. This structure is defined to have constant size in
    // both the emulated and native environment.
    TJIT_DEBUG_INFO = record
        dwSize: DWORD;
        dwProcessorArchitecture: DWORD;
        dwThreadID: DWORD;
        dwReserved0: DWORD;
        lpExceptionAddress: ULONG64;
        lpExceptionRecord: ULONG64;
        lpContextRecord: ULONG64;
    end;
    PJIT_DEBUG_INFO = ^TJIT_DEBUG_INFO;

    TJIT_DEBUG_INFO32 = TJIT_DEBUG_INFO;
    PJIT_DEBUG_INFO32 = ^TJIT_DEBUG_INFO32;

    TJIT_DEBUG_INFO64 = TJIT_DEBUG_INFO;

    TOFSTRUCT = record
        cBytes: byte;
        fFixedDisk: byte;
        nErrCode: word;
        Reserved1: word;
        Reserved2: word;
        szPathName: array [0..OFS_MAXPATHNAME - 1] of AnsiCHAR;
    end;
    POFSTRUCT = ^TOFSTRUCT;

    HLOCAL = Handle; // ToDo: from MinWinDef.h
//{$IF (DEFINED(WINAPI_PARTITION_APP) or DEFINED(WINAPI_PARTITION_SYSTEM))}


    TFILE_DISPOSITION_INFO = record
        DeleteFile: boolean;
    end;
    PFILE_DISPOSITION_INFO = ^TFILE_DISPOSITION_INFO;

{$IF (_WIN32_WINNT >= _WIN32_WINNT_WIN10_RS1)}

    TFILE_DISPOSITION_INFO_EX = record
        Flags: DWORD;
    end;
    PFILE_DISPOSITION_INFO_EX = ^TFILE_DISPOSITION_INFO_EX;

{$ENDIF}

function LocalFree(hMem: HLOCAL): HLOCAL; stdcall; external KERNEL32_DLL;

function VerifyVersionInfoA(var lpVersionInformation: TOSVERSIONINFOEXA; dwTypeMask: DWORD; dwlConditionMask: DWORDLONG): boolean;
    stdcall; external KERNEL32_DLL;

function VerifyVersionInfoW(var lpVersionInformation: TOSVERSIONINFOEXW; dwTypeMask: DWORD; dwlConditionMask: DWORDLONG): boolean;
    stdcall; external KERNEL32_DLL;

function SetThreadExecutionState(esFlags: TEXECUTION_STATE): TEXECUTION_STATE; stdcall; external KERNEL32_DLL;

//{$ENDIF}{ WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_APP | WINAPI_PARTITION_SYSTEM) }

implementation

end.


