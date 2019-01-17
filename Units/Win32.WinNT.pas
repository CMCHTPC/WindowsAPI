unit Win32.WinNT;

{$mode delphi}

interface

uses
    Windows, Classes, SysUtils;

const
    // Zeile 8875


    // begin_wdm

    //  The following are masks for the predefined standard access types


    Delete = ($00010000);
    READ_CONTROL = ($00020000);
    WRITE_DAC = ($00040000);
    WRITE_OWNER = ($00080000);
    SYNCHRONIZE = ($00100000);

    STANDARD_RIGHTS_REQUIRED = ($000F0000);

    STANDARD_RIGHTS_READ = (READ_CONTROL);
    STANDARD_RIGHTS_WRITE = (READ_CONTROL);
    STANDARD_RIGHTS_EXECUTE = (READ_CONTROL);

    STANDARD_RIGHTS_ALL = ($001F0000);

    SPECIFIC_RIGHTS_ALL = ($0000FFFF);


    // AccessSystemAcl access type


    ACCESS_SYSTEM_SECURITY = ($01000000);


    // MaximumAllowed access type


    MAXIMUM_ALLOWED = ($02000000);


    //  These are the generic rights.


    GENERIC_READ = ($80000000);
    GENERIC_WRITE = ($40000000);
    GENERIC_EXECUTE = ($20000000);
    GENERIC_ALL = ($10000000);


    //  Define the generic mapping array.  This is used to denote the
    //  mapping of each generic access right to a specific access mask.

    // Zeile  12817

    // begin_access


    // Define access rights to files and directories



    // The FILE_READ_DATA and FILE_WRITE_DATA constants are also defined in
    // devioctl.h as FILE_READ_ACCESS and FILE_WRITE_ACCESS. The values for these
    // constants *MUST* always be in sync.
    // The values are redefined in devioctl.h because they must be available to
    // both DOS and NT.


    FILE_READ_DATA = ($0001);    // file & pipe
    FILE_LIST_DIRECTORY = ($0001);    // directory

    FILE_WRITE_DATA = ($0002);    // file & pipe
    FILE_ADD_FILE = ($0002);    // directory

    FILE_APPEND_DATA = ($0004);    // file
    FILE_ADD_SUBDIRECTORY = ($0004);    // directory
    FILE_CREATE_PIPE_INSTANCE = ($0004);    // named pipe


    FILE_READ_EA = ($0008);    // file & directory

    FILE_WRITE_EA = ($0010);   // file & directory

    FILE_EXECUTE = ($0020);    // file
    FILE_TRAVERSE = ($0020);    // directory

    FILE_DELETE_CHILD = ($0040);    // directory

    FILE_READ_ATTRIBUTES = ($0080);    // all

    FILE_WRITE_ATTRIBUTES = ($0100);   // all

    FILE_ALL_ACCESS = (STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE or $1FF);

    FILE_GENERIC_READ = (STANDARD_RIGHTS_READ or FILE_READ_DATA or FILE_READ_ATTRIBUTES or FILE_READ_EA or SYNCHRONIZE);


    FILE_GENERIC_WRITE = (STANDARD_RIGHTS_WRITE or FILE_WRITE_DATA or FILE_WRITE_ATTRIBUTES or FILE_WRITE_EA or
        FILE_APPEND_DATA or SYNCHRONIZE);


    FILE_GENERIC_EXECUTE = (STANDARD_RIGHTS_EXECUTE or FILE_READ_ATTRIBUTES or FILE_EXECUTE or SYNCHRONIZE);

    // end_access
    FILE_SHARE_READ = $00000001;
    FILE_SHARE_WRITE = $00000002;
    FILE_SHARE_DELETE = $00000004;
    FILE_ATTRIBUTE_READONLY = $00000001;
    FILE_ATTRIBUTE_HIDDEN = $00000002;
    FILE_ATTRIBUTE_SYSTEM = $00000004;
    FILE_ATTRIBUTE_DIRECTORY = $00000010;
    FILE_ATTRIBUTE_ARCHIVE = $00000020;
    FILE_ATTRIBUTE_DEVICE = $00000040;
    FILE_ATTRIBUTE_NORMAL = $00000080;
    FILE_ATTRIBUTE_TEMPORARY = $00000100;
    FILE_ATTRIBUTE_SPARSE_FILE = $00000200;
    FILE_ATTRIBUTE_REPARSE_POINT = $00000400;
    FILE_ATTRIBUTE_COMPRESSED = $00000800;
    FILE_ATTRIBUTE_OFFLINE = $00001000;
    FILE_ATTRIBUTE_NOT_CONTENT_INDEXED = $00002000;
    FILE_ATTRIBUTE_ENCRYPTED = $00004000;
    FILE_ATTRIBUTE_INTEGRITY_STREAM = $00008000;
    FILE_ATTRIBUTE_VIRTUAL = $00010000;
    FILE_ATTRIBUTE_NO_SCRUB_DATA = $00020000;
    FILE_ATTRIBUTE_EA = $00040000;
    FILE_ATTRIBUTE_PINNED = $00080000;
    FILE_ATTRIBUTE_UNPINNED = $00100000;
    FILE_ATTRIBUTE_RECALL_ON_OPEN = $00040000;
    FILE_ATTRIBUTE_RECALL_ON_DATA_ACCESS = $00400000;
    TREE_CONNECT_ATTRIBUTE_PRIVACY = $00004000;
    TREE_CONNECT_ATTRIBUTE_INTEGRITY = $00008000;
    TREE_CONNECT_ATTRIBUTE_GLOBAL = $00000004;
    FILE_ATTRIBUTE_STRICTLY_SEQUENTIAL = $20000000;
    FILE_NOTIFY_CHANGE_FILE_NAME = $00000001;
    FILE_NOTIFY_CHANGE_DIR_NAME = $00000002;
    FILE_NOTIFY_CHANGE_ATTRIBUTES = $00000004;
    FILE_NOTIFY_CHANGE_SIZE = $00000008;
    FILE_NOTIFY_CHANGE_LAST_WRITE = $00000010;
    FILE_NOTIFY_CHANGE_LAST_ACCESS = $00000020;
    FILE_NOTIFY_CHANGE_CREATION = $00000040;
    FILE_NOTIFY_CHANGE_SECURITY = $00000100;
    FILE_ACTION_ADDED = $00000001;
    FILE_ACTION_REMOVED = $00000002;
    FILE_ACTION_MODIFIED = $00000003;
    FILE_ACTION_RENAMED_OLD_NAME = $00000004;
    FILE_ACTION_RENAMED_NEW_NAME = $00000005;
    MAILSLOT_NO_MESSAGE: DWORD  = -1;
    MAILSLOT_WAIT_FOREVER: DWORD = -1;
    FILE_CASE_SENSITIVE_SEARCH = $00000001;
    FILE_CASE_PRESERVED_NAMES = $00000002;
    FILE_UNICODE_ON_DISK = $00000004;
    FILE_PERSISTENT_ACLS = $00000008;
    FILE_FILE_COMPRESSION = $00000010;
    FILE_VOLUME_QUOTAS = $00000020;
    FILE_SUPPORTS_SPARSE_FILES = $00000040;
    FILE_SUPPORTS_REPARSE_POINTS = $00000080;
    FILE_SUPPORTS_REMOTE_STORAGE = $00000100;
    FILE_RETURNS_CLEANUP_RESULT_INFO = $00000200;
    FILE_SUPPORTS_POSIX_UNLINK_RENAME = $00000400;




    FILE_VOLUME_IS_COMPRESSED = $00008000;
    FILE_SUPPORTS_OBJECT_IDS = $00010000;
    FILE_SUPPORTS_ENCRYPTION = $00020000;
    FILE_NAMED_STREAMS = $00040000;
    FILE_READ_ONLY_VOLUME = $00080000;
    FILE_SEQUENTIAL_WRITE_ONCE = $00100000;
    FILE_SUPPORTS_TRANSACTIONS = $00200000;
    FILE_SUPPORTS_HARD_LINKS = $00400000;
    FILE_SUPPORTS_EXTENDED_ATTRIBUTES = $00800000;
    FILE_SUPPORTS_OPEN_BY_FILE_ID = $01000000;
    FILE_SUPPORTS_USN_JOURNAL = $02000000;
    FILE_SUPPORTS_INTEGRITY_STREAMS = $04000000;
    FILE_SUPPORTS_BLOCK_REFCOUNTING = $08000000;
    FILE_SUPPORTS_SPARSE_VDL = $10000000;
    FILE_DAX_VOLUME = $20000000;
    FILE_SUPPORTS_GHOSTING = $40000000;

    FILE_INVALID_FILE_ID: LONGLONG = -1;

    ES_SYSTEM_REQUIRED: DWORD = $00000001;
    ES_DISPLAY_REQUIRED: DWORD = $00000002;
    ES_USER_PRESENT: DWORD = $00000004;
    ES_AWAYMODE_REQUIRED: DWORD = $00000040;
    ES_CONTINUOUS: DWORD = $80000000;

type
    NWPSTR = ^WCHAR;
    LPWSTR = ^WCHAR;
    PWSTR = ^WCHAR;

    TACCESS_MASK = DWORD;
    PACCESS_MASK = ^TACCESS_MASK;

    TATOM = WORD;

    // ToDo
     wchar_t = WCHAR; // ushort; // is in rpcndr
     Pwchar_t = ^wchar_t;

    TOBJECT_TYPE_LIST = record
        Level: word;
        Sbz: word;
        ObjectType: PGUID;
    end;
    POBJECT_TYPE_LIST = ^TOBJECT_TYPE_LIST;


    TOSVERSIONINFOEXA = record
        dwOSVersionInfoSize: DWORD;
        dwMajorVersion: DWORD;
        dwMinorVersion: DWORD;
        dwBuildNumber: DWORD;
        dwPlatformId: DWORD;
        szCSDVersion: array[0.. 127] of char;     // Maintenance string for PSS usage
        wServicePackMajor: word;
        wServicePackMinor: word;
        wSuiteMask: word;
        wProductType: byte;
        wReserved: byte;
    end;
    POSVERSIONINFOEXA = ^TOSVERSIONINFOEXA;

    TOSVERSIONINFOEXW = record
        dwOSVersionInfoSize: DWORD;
        dwMajorVersion: DWORD;
        dwMinorVersion: DWORD;
        dwBuildNumber: DWORD;
        dwPlatformId: DWORD;
        szCSDVersion: array[0.. 127] of WCHAR;     // Maintenance string for PSS usage
        wServicePackMajor: word;
        wServicePackMinor: word;
        wSuiteMask: word;
        wProductType: byte;
        wReserved: byte;
    end;
    POSVERSIONINFOEXW = ^TOSVERSIONINFOEXW;
    TRTL_OSVERSIONINFOEXW = TOSVERSIONINFOEXW;
    PRTL_OSVERSIONINFOEXW = ^TRTL_OSVERSIONINFOEXW;


    TEXECUTION_STATE = DWORD;
    PEXECUTION_STATE = ^TEXECUTION_STATE;



    // Exception record definition.


    TEXCEPTION_RECORD = record
        ExceptionCode: DWORD;
        ExceptionFlags: DWORD;
        ExceptionRecord: PEXCEPTION_RECORD;
        ExceptionAddress: pointer;
        NumberParameters: DWORD;
        ExceptionInformation: array [0..EXCEPTION_MAXIMUM_PARAMETERS - 1] of ULONG_PTR;
    end;


    PEXCEPTION_RECORD = ^TEXCEPTION_RECORD;

    TEXCEPTION_RECORD32 = record
        ExceptionCode: DWORD;
        ExceptionFlags: DWORD;
        ExceptionRecord: DWORD;
        ExceptionAddress: DWORD;
        NumberParameters: DWORD;
        ExceptionInformation: array [0..EXCEPTION_MAXIMUM_PARAMETERS - 1] of DWORD;
    end;
    PEXCEPTION_RECORD32 = ^EXCEPTION_RECORD32;

    TEXCEPTION_RECORD64 = record
        ExceptionCode: DWORD;
        ExceptionFlags: DWORD;
        ExceptionRecord: DWORD64;
        ExceptionAddress: DWORD64;
        NumberParameters: DWORD;
        __unusedAlignment: DWORD;
        ExceptionInformation: array [0..EXCEPTION_MAXIMUM_PARAMETERS - 1] of DWORD64;
    end;
    PEXCEPTION_RECORD64 = ^TEXCEPTION_RECORD64;


implementation

end.

