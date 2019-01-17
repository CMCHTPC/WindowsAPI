(********************************************************************************
*                                                                               *
* sysinfoapi.h -- ApiSet Contract for api-ms-win-core-sysinfo-l1                *
*                                                                               *
* Copyright (c) Microsoft Corporation. All rights reserved.                     *
*                                                                               *
********************************************************************************)
unit Win32.SysInfoAPI;

{$mode delphi}

interface

uses
    Windows, Classes, SysUtils,
    Win32.WinNT;

const
    KERNEL32_DLL = 'kernel32.dll';

const
    SCEX2_ALT_NETBIOS_NAME =  $00000001;


function GetVersionExA(var lpVersionInformation: TOSVERSIONINFOA): BOOL; stdcall; external KERNEL32_DLL; overload;
function GetVersionExW(var lpVersionInformation: TOSVERSIONINFOW): BOOL; stdcall; external KERNEL32_DLL; overload;
function GetVersionExA(var lpVersionInformation: TOSVERSIONINFOEXA): BOOL; stdcall; external KERNEL32_DLL; overload;
function GetVersionExW(var lpVersionInformation: TOSVERSIONINFOEXW): BOOL; stdcall; external KERNEL32_DLL; overload;

implementation

end.








