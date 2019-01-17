(********************************************************************************
*                                                                               *
* FileApi.h -- ApiSet Contract for api-ms-win-core-file-l1                      *
*                                                                               *
* Copyright (c) Microsoft Corporation. All rights reserved.                     *
*                                                                               *
********************************************************************************)
unit Win32.FileAPI;

{$mode delphi}

{$I Win32.WinAPI.inc}

interface

uses
    Windows, Classes, SysUtils,
    Win32.MinWinBase;

const
    KERNEL32_DLL = 'Kernel32.dll';


    // Constants
    CREATE_NEW = 1;
    CREATE_ALWAYS = 2;
    OPEN_EXISTING = 3;
    OPEN_ALWAYS = 4;
    TRUNCATE_EXISTING = 5;

    INVALID_FILE_SIZE: DWORD = $FFFFFFFF;
    INVALID_SET_FILE_POINTER: DWORD = -1;
    INVALID_FILE_ATTRIBUTES: DWORD = -1;




function CompareFileTime(const lpFileTime1: TFILETIME; const lpFileTime2: TFILETIME): LONG;
    stdcall; external KERNEL32_DLL;
function CreateDirectoryA(lpPathName: LPCSTR; lpSecurityAttributes: TSECURITY_ATTRIBUTES): boolean;
    stdcall; external KERNEL32_DLL;
function CreateDirectoryW(lpPathName: LPCWSTR; lpSecurityAttributes: TSECURITY_ATTRIBUTES): boolean;
    stdcall; external KERNEL32_DLL;
function CreateFileA(lpFileName: LPCSTR; dwDesiredAccess: DWORD; dwShareMode: DWORD; lpSecurityAttributes: TSECURITY_ATTRIBUTES;
    dwCreationDisposition: DWORD; dwFlagsAndAttributes: DWORD; hTemplateFile: THANDLE): THANDLE; stdcall; external KERNEL32_DLL;
function CreateFileW(lpFileName: LPCWSTR; dwDesiredAccess: DWORD; dwShareMode: DWORD; lpSecurityAttributes: TSECURITY_ATTRIBUTES;
    dwCreationDisposition: DWORD; dwFlagsAndAttributes: DWORD; hTemplateFile: THANDLE): THANDLE; stdcall; external KERNEL32_DLL;
function DefineDosDeviceW(dwFlags: DWORD; lpDeviceName: LPCWSTR; lpTargetPath: LPCWSTR): boolean;
    stdcall; external KERNEL32_DLL;
function DeleteFileA(lpFileName: LPCSTR): boolean; stdcall; external KERNEL32_DLL;
function DeleteFileW(lpFileName: LPCWSTR): boolean; stdcall; external KERNEL32_DLL;
function DeleteVolumeMountPointW(lpszVolumeMountPoint: LPCWSTR): boolean; stdcall; external KERNEL32_DLL;
function FileTimeToLocalFileTime(const lpFileTime: TFILETIME; out lpLocalFileTime: TFILETIME): boolean;
    stdcall; external KERNEL32_DLL;
function FindClose(var hFindFile: THANDLE): boolean; stdcall; external KERNEL32_DLL;
function FindCloseChangeNotification(hChangeHandle: THANDLE): boolean; stdcall; external KERNEL32_DLL;
function FindFirstChangeNotificationA(lpPathName: LPCSTR; bWatchSubtree: boolean; dwNotifyFilter: DWORD): THANDLE; stdcall; external KERNEL32_DLL;
function FindFirstChangeNotificationW(lpPathName: LPCWSTR; bWatchSubtree: boolean; dwNotifyFilter: DWORD): THANDLE;
    stdcall; external KERNEL32_DLL;
function FindFirstFileA(lpFileName: LPCSTR; out lpFindFileData: TWIN32_FIND_DATAA): THANDLE;
    stdcall; external KERNEL32_DLL;



{$IF (_WIN32_WINNT >= $0600)}

function SetFileInformationByHandle(hFile: THANDLE; FileInformationClass: TFILE_INFO_BY_HANDLE_CLASS;
    lpFileInformation {dwBufferSize}: pointer; dwBufferSize: DWORD): boolean; stdcall; external KERNEL32_DLL;

{$ENDIF}

implementation

end.


