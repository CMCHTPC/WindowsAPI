unit Win32.ShellAPI;

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

{****************************************************************************\
*                                                                             *
* shellapi.h -  SHELL.DLL functions, types, and definitions                   *
*                                                                             *
* Copyright (c) Microsoft Corporation. All rights reserved.                   *
*                                                                             *
\****************************************************************************}

{ Header Definition: 10.0.14393.0 }

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}


interface

uses
    Windows, Classes, SysUtils,
    Win32.NTDef, Win32.ProcessThreadsAPI;

const
    shell32_dll = 'Shell32.dll';




{$IFNDEF WIN64}
{$A1}
{$ENDIF}

{$IF DEFINED(WINAPI_PARTITION_DESKTOP)}

type
    HDROP = Handle;
    HINSTANCE = Handle;

function DragQueryFileA(hDrop: HDROP; iFile: UINT; out lpszFile: LPSTR; cch: UINT): UINT; stdcall; external shell32_dll;
function DragQueryFileW(hDrop: HDROP; iFile: UINT; out lpszFile: LPWSTR; cch: UINT): UINT; stdcall; external shell32_dll;

function DragQueryPoint(hDrop: HDROP; out ppt: POINT): boolean; stdcall; external shell32_dll;
procedure DragFinish(hDrop: HDROP); stdcall; external shell32_dll;
procedure DragAcceptFiles(hWnd: HWND; fAccept: boolean); stdcall; external shell32_dll;

function ShellExecuteA(hwnd: HWND; lpOperation: LPCSTR; lpFile: LPCSTR; lpParameters: LPCSTR; lpDirectory: LPCSTR;
    nShowCmd: INT32): HINSTANCE; stdcall; external shell32_dll;
function ShellExecuteW(hwnd: HWND; lpOperation: LPCWSTR; lpFile: LPCWSTR; lpParameters: LPCWSTR; lpDirectory: LPCWSTR;
    nShowCmd: int32): HINSTANCE; stdcall; external shell32_dll;

function FindExecutableA(lpFile: LPCSTR; lpDirectory: LPCSTR; out lpResult: LPSTR): HINSTANCE; stdcall; external shell32_dll;
function FindExecutableW(lpFile: LPCWSTR; lpDirectory: LPCWSTR; out lpResult: LPWSTR): HINSTANCE; stdcall; external shell32_dll;

function CommandLineToArgvW(lpCmdLine: LPCWSTR; out pNumArgs: int32): LPWSTR; stdcall; external shell32_dll;

function ShellAboutA(hWnd: HWND; szApp: LPCSTR; szOtherStuff: LPCSTR; hIcon: HICON): INT32; stdcall; external shell32_dll;
function ShellAboutW(hWnd: HWND; szApp: LPCWSTR; szOtherStuff: LPCWSTR; hIcon: HICON): INT32; stdcall; external shell32_dll;

function DuplicateIcon(hInst: HINSTANCE; hIcon: HICON): HICON; stdcall; external shell32_dll;
// Retrieves a handle to an indexed icon found in a file or an icon found in an associated executable file.
function ExtractAssociatedIconA(hInst: HINSTANCE; var pszIconPath: LPSTR; var piIcon: word): HICON; stdcall; external shell32_dll;
function ExtractAssociatedIconW(hInst: HINSTANCE; var pszIconPath: LPWSTR; var piIcon: word): HICON; stdcall; external shell32_dll;

function ExtractAssociatedIconExA(hInst: HINSTANCE; var pszIconPath: LPSTR; var piIconIndex: word; var piIconId: word): HICON;
    stdcall; external shell32_dll;
function ExtractAssociatedIconExW(hInst: HINSTANCE; var pszIconPath: LPWSTR; var piIconIndex: word; var piIconId: word): HICON;
    stdcall; external shell32_dll;

function ExtractIconA(hInst: HINSTANCE; pszExeFileName: LPCSTR; nIconIndex: UINT): HICON; stdcall; external shell32_dll;
function ExtractIconW(hInst: HINSTANCE; pszExeFileName: LPCWSTR; nIconIndex: UINT): HICON; stdcall; external shell32_dll;

type

{$IF (WINVER >= $0400)}
    TDRAGINFOA = record
        uSize: UINT;                 { init with sizeof(TDRAGINFO) }
        pt: POINT;
        fNC: boolean;
        lpFileList: PAnsiChar;
        grfKeyState: DWORD;
    end;
    PDRAGINFOA = ^TDRAGINFOA;

    TDRAGINFOW = record
        uSize: UINT;                 { init with sizeof(TDRAGINFO) }
        pt: POINT;
        fNC: boolean;
        lpFileList: PZZWSTR;
        grfKeyState: DWORD;
    end;
    PDRAGINFOW = ^TDRAGINFOW;

////
//// AppBar stuff
////
const
    ABM_NEW = $00000000;
    ABM_REMOVE = $00000001;
    ABM_QUERYPOS = $00000002;
    ABM_SETPOS = $00000003;
    ABM_GETSTATE = $00000004;
    ABM_GETTASKBARPOS = $00000005;
    ABM_ACTIVATE = $00000006; // lParam == TRUE/FALSE means activate/deactivate
    ABM_GETAUTOHIDEBAR = $00000007;
    ABM_SETAUTOHIDEBAR = $00000008;  // this can fail at any time.  MUST check the result
    // lParam = TRUE/FALSE  Set/Unset
    // uEdge = what edge
    ABM_WINDOWPOSCHANGED = $0000009;
    {$IF (NTDDI_VERSION >= NTDDI_WINXP)}
    ABM_SETSTATE = $0000000a;
    {$ENDIF}// (NTDDI_VERSION >= NTDDI_WINXP)
    {$IF (NTDDI_VERSION >= NTDDI_WIN8)}
    ABM_GETAUTOHIDEBAREX = $0000000b; // multimon aware autohide bars
    ABM_SETAUTOHIDEBAREX = $0000000c;
    {$ENDIF}
    // these are put in the wparam of callback messages
    ABN_STATECHANGE = $0000000;
    ABN_POSCHANGED = $0000001;
    ABN_FULLSCREENAPP = $0000002;
    ABN_WINDOWARRANGE = $0000003; // lParam == TRUE means hide

    // flags for get state
    ABS_AUTOHIDE = $0000001;
    ABS_ALWAYSONTOP = $0000002;

    ABE_LEFT = 0;
    ABE_TOP = 1;
    ABE_RIGHT = 2;
    ABE_BOTTOM = 3;

type
    TAPPBARDATA = record
        cbSize: DWORD;
        hWnd: HWND;
        uCallbackMessage: UINT;
        uEdge: UINT;
        rc: RECT;
        lParam: LPARAM; // message specific
    end;
    PAPPBARDATA = ^TAPPBARDATA;


function SHAppBarMessage(dwMessage: DWORD; var pData: TAPPBARDATA): UINT_PTR; stdcall; external Shell32_dll;

////
////  EndAppBar
////

function DoEnvironmentSubstA(var pszSrc: LPSTR; cchSrc: UINT): DWORD; stdcall; external Shell32_dll;
function DoEnvironmentSubstW(var pszSrc: LPWSTR; cchSrc: UINT): DWORD; stdcall; external Shell32_dll;

function EIRESID(x: integer): integer;

function ExtractIconExA(lpszFile: LPCSTR; nIconIndex: int32; out phiconLarge: PHICON; out phiconSmall: PHICON; nIcons: UINT32): UINT32;
    stdcall; external Shell32_dll;
function ExtractIconExW(lpszFile: LPCWSTR; nIconIndex: int32; out phiconLarge: PHICON; out phiconSmall: PHICON; nIcons: UINT32): UINT32;
    stdcall; external Shell32_dll;


const
    // Shell File Operations
    FO_MOVE = $0001;
    FO_COPY = $0002;
    FO_DELETE = $0003;
    FO_RENAME = $0004;

    // SHFILEOPSTRUCT.fFlags and IFileOperation::SetOperationFlags() flag values

    FOF_MULTIDESTFILES = $0001;
    FOF_CONFIRMMOUSE = $0002;
    FOF_SILENT = $0004;  // don't display progress UI (confirm prompts may be displayed still)
    FOF_RENAMEONCOLLISION = $0008;  // automatically rename the source files to avoid the collisions
    FOF_NOCONFIRMATION = $0010;  // don't display confirmation UI, assume "yes" for cases that can be bypassed, "no" for those that can not
    FOF_WANTMAPPINGHANDLE = $0020;  // Fill in SHFILEOPSTRUCT.hNameMappings
    // Must be freed using SHFreeNameMappings
    FOF_ALLOWUNDO = $0040;  // enable undo including Recycle behavior for IFileOperation::Delete()
    FOF_FILESONLY = $0080;  // only operate on the files (non folders), both files and folders are assumed without this
    FOF_SIMPLEPROGRESS = $0100;  // means don't show names of files
    FOF_NOCONFIRMMKDIR = $0200;  // don't dispplay confirmatino UI before making any needed directories, assume "Yes" in these cases
    FOF_NOERRORUI = $0400;  // don't put up error UI, other UI may be displayed, progress, confirmations
    FOF_NOCOPYSECURITYATTRIBS = $0800;  // dont copy file security attributes (ACLs)
    FOF_NORECURSION = $1000;  // don't recurse into directories for operations that would recurse
    FOF_NO_CONNECTED_ELEMENTS = $2000;  // don't operate on connected elements ("xxx_files" folders that go with .htm files)
    FOF_WANTNUKEWARNING = $4000;
    // during delete operation, warn if object is being permanently destroyed instead of recycling (partially overrides FOF_NOCONFIRMATION)
    {$IF  (NTDDI_VERSION >= NTDDI_WINXP)}
    FOF_NORECURSEREPARSE = $8000;
    // deprecated; the operations engine always does the right thing on FolderLink objects (symlinks, reparse points, folder shortcuts)
    {$ENDIF}// (NTDDI_VERSION >= NTDDI_WINXP)
    FOF_NO_UI = (FOF_SILENT or FOF_NOCONFIRMATION or FOF_NOERRORUI or FOF_NOCONFIRMMKDIR); // don't display any UI at all

type
    FILEOP_FLAGS = word;

const
    PO_DELETE = $0013;  // printer is being deleted
    PO_RENAME = $0014;  // printer is being renamed
    PO_PORTCHANGE = $0020;  // port this printer connected to is being changed
    // if this id is set, the strings received by
    // the copyhook are a doubly-null terminated
    // list of strings.  The first is the printer
    // name and the second is the printer port.
    PO_REN_PORT = $0034;  // PO_RENAME and PO_PORTCHANGE at same time.

// no POF_ flags currently defined

type
    PRINTEROP_FLAGS = word;

    // implicit parameters are:
    //      if pFrom or pTo are unqualified names the current directories are
    //      taken from the global current drive/directory settings managed
    //      by Get/SetCurrentDrive/Directory

    //      the global confirmation settings

    TSHFILEOPSTRUCTA = record
        hwnd: HWND;
        wFunc: UINT32;
        pFrom: PCZZSTR;
        pTo: PCZZSTR;
        fFlags: FILEOP_FLAGS;
        fAnyOperationsAborted: boolean;
        hNameMappings: Pointer;
        lpszProgressTitle: PCSTR; // only used if FOF_SIMPLEPROGRESS
    end;
    PSHFILEOPSTRUCTA = ^TSHFILEOPSTRUCTA;

    TSHFILEOPSTRUCTW = record
        hwnd: HWND;
        wFunc: UINT32;
        pFrom: PCZZWSTR;
        pTo: PCZZWSTR;
        fFlags: FILEOP_FLAGS;
        fAnyOperationsAborted: boolean;
        hNameMappings: pointer;
        lpszProgressTitle: PCWSTR; // only used if FOF_SIMPLEPROGRESS
    end;
    PSHFILEOPSTRUCTW = ^TSHFILEOPSTRUCTW;


function SHFileOperationA(var lpFileOp: TSHFILEOPSTRUCTA): INT32; stdcall; external Shell32_DLL;
function SHFileOperationW(var lpFileOp: TSHFILEOPSTRUCTW): INT32; stdcall; external Shell32_DLL;

procedure SHFreeNameMappings(hNameMappings: HANDLE); stdcall; external Shell32_DLL;

type
    TSHNAMEMAPPINGA = record
        pszOldPath: LPSTR;
        pszNewPath: LPSTR;
        cchOldPath: int32;
        cchNewPath: int32;
    end;
    PSHNAMEMAPPINGA = ^TSHNAMEMAPPINGA;

    TSHNAMEMAPPINGW = record

        pszOldPath: LPWSTR;
        pszNewPath: LPWSTR;
        cchOldPath: int32;
        cchNewPath: int32;
    end;
    PSHNAMEMAPPINGW = ^TSHNAMEMAPPINGW;



////
//// End Shell File Operations
////

////
////  Begin ShellExecuteEx and family
////

{ ShellExecute() and ShellExecuteEx() error codes }

{ regular WinExec() codes }
const
    SE_ERR_FNF = 2;       // file not found
    SE_ERR_PNF = 3;       // path not found
    SE_ERR_ACCESSDENIED = 5;       // access denied
    SE_ERR_OOM = 8;       // out of memory
    SE_ERR_DLLNOTFOUND = 32;

{$ENDIF}{ WINVER >= $0400 }




const
    { error values for ShellExecute() beyond the regular WinExec() codes }
    SE_ERR_SHARE = 26;
    SE_ERR_ASSOCINCOMPLETE = 27;
    SE_ERR_DDETIMEOUT = 28;
    SE_ERR_DDEFAIL = 29;
    SE_ERR_DDEBUSY = 30;
    SE_ERR_NOASSOC = 31;

{$IF (WINVER >= $0400)}
    // Note CLASSKEY overrides CLASSNAME
    SEE_MASK_DEFAULT = $00000000;
    SEE_MASK_CLASSNAME = $00000001;   // SHELLEXECUTEINFO.lpClass is valid
    SEE_MASK_CLASSKEY = $00000003;   // SHELLEXECUTEINFO.hkeyClass is valid
    // Note SEE_MASK_INVOKEIDLIST($C) implies SEE_MASK_IDLIST($04)
    SEE_MASK_IDLIST = $00000004;   // SHELLEXECUTEINFO.lpIDList is valid
    SEE_MASK_INVOKEIDLIST = $0000000c;   // enable IContextMenu based verbs
    {$IF (NTDDI_VERSION < NTDDI_VISTA)}
    SEE_MASK_ICON = $00000010;   // not used
    {$ENDIF}// (NTDDI_VERSION < NTDDI_VISTA)
    SEE_MASK_HOTKEY = $00000020;   // SHELLEXECUTEINFO.dwHotKey is valid
    SEE_MASK_NOCLOSEPROCESS = $00000040;   // SHELLEXECUTEINFO.hProcess
    SEE_MASK_CONNECTNETDRV = $00000080;   // enables re-connecting disconnected network drives
    SEE_MASK_NOASYNC = $00000100;
    // block on the call until the invoke has completed, use for callers that exit after calling ShellExecuteEx()
    SEE_MASK_FLAG_DDEWAIT = SEE_MASK_NOASYNC; // Use SEE_MASK_NOASYNC instead of SEE_MASK_FLAG_DDEWAIT as it more accuratly describes the behavior
    SEE_MASK_DOENVSUBST = $00000200;   // indicates that SHELLEXECUTEINFO.lpFile contains env vars that should be expanded
    SEE_MASK_FLAG_NO_UI = $00000400;   // disable UI including error messages
    SEE_MASK_UNICODE = $00004000;
    SEE_MASK_NO_CONSOLE = $00008000;
    SEE_MASK_ASYNCOK = $00100000;
    {$IF (NTDDI_VERSION >= NTDDI_WIN2K)}
    SEE_MASK_HMONITOR = $00200000;   // SHELLEXECUTEINFO.hMonitor
    {$ENDIF}// (NTDDI_VERSION >= NTDDI_WIN2K)
    {$IF (NTDDI_VERSION >= NTDDI_WINXPSP1)}
    SEE_MASK_NOZONECHECKS = $00800000;
    {$ENDIF}// (NTDDI_VERSION >= NTDDI_WINXPSP1)
    {$IF (NTDDI_VERSION >= NTDDI_WIN2K)}
    SEE_MASK_NOQUERYCLASSSTORE = $01000000;
    SEE_MASK_WAITFORINPUTIDLE = $02000000;
    {$ENDIF}// (NTDDI_VERSION >= NTDDI_WIN2K)
    {$IF  (NTDDI_VERSION >= NTDDI_WINXP)}
    SEE_MASK_FLAG_LOG_USAGE = $04000000;
    {$ENDIF}// (NTDDI_VERSION >= NTDDI_WINXP)

    {$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
    // When SEE_MASK_FLAG_HINST_IS_SITE is specified SHELLEXECUTEINFO.hInstApp is used as an
    // _In_ parameter and specifies a IUnknown* to be used as a site pointer. The site pointer
    // is used to provide services to shell execute, the handler binding process and the verb handlers
    // once they are invoked.
    SEE_MASK_FLAG_HINST_IS_SITE = $08000000;
    {$ENDIF}// (NTDDI_VERSION >= NTDDI_VISTA)


// For compilers that don't support nameless unions


type
    TSHELLEXECUTEINFOA = record
        cbSize: DWORD;               // in, required, sizeof of this structure
        fMask: ULONG;                // in, SEE_MASK_XXX values
        hwnd: HWND;                  // in, optional
        lpVerb: LPCSTR;            // in, optional when unspecified the default verb is choosen
        lpFile: LPCSTR;            // in, either this value or lpIDList must be specified
        lpParameters: LPCSTR;      // in, optional
        lpDirectory: LPCSTR;       // in, optional
        nShow: int32;                  // in, required
        hInstApp: HINSTANCE;         // out when SEE_MASK_NOCLOSEPROCESS is specified
        lpIDList: Pointer;
        // in, valid when SEE_MASK_IDLIST is specified, PCIDLIST_ABSOLUTE, for use with SEE_MASK_IDLIST & SEE_MASK_INVOKEIDLIST
        lpClass: LPCSTR;           // in, valid when SEE_MASK_CLASSNAME is specified
        hkeyClass: HKEY;             // in, valid when SEE_MASK_CLASSKEY is specified
        dwHotKey: DWORD;             // in, valid when SEE_MASK_HOTKEY is specified
        case integer of
            0: (
                hIcon: HANDLE;          // not used
                hProcess: HANDLE;);            // out, valid when SEE_MASK_NOCLOSEPROCESS specified
            {$IF  (NTDDI_VERSION >= NTDDI_WIN2K)}
            1: (hMonitor: HANDLE;)       // in, valid when SEE_MASK_HMONITOR specified
            {$ENDIF}// (NTDDI_VERSION >= NTDDI_WIN2K)
    end;


    PSHELLEXECUTEINFOA = ^TSHELLEXECUTEINFOA;


    TSHELLEXECUTEINFOW = record
        cbSize: DWORD;               // in, required, sizeof of this structure
        fMask: ULONG;                // in, SEE_MASK_XXX values
        hwnd: HWND;                  // in, optional
        lpVerb: LPCWSTR;            // in, optional when unspecified the default verb is choosen
        lpFile: LPCWSTR;            // in, either this value or lpIDList must be specified
        lpParameters: LPCWSTR;      // in, optional
        lpDirectory: LPCWSTR;       // in, optional
        nShow: int32;                  // in, required
        hInstApp: HINSTANCE;         // out when SEE_MASK_NOCLOSEPROCESS is specified
        lpIDList: Pointer;
        // in, valid when SEE_MASK_IDLIST is specified, PCIDLIST_ABSOLUTE, for use with SEE_MASK_IDLIST & SEE_MASK_INVOKEIDLIST
        lpClass: LPCWSTR;           // in, valid when SEE_MASK_CLASSNAME is specified
        hkeyClass: HKEY;             // in, valid when SEE_MASK_CLASSKEY is specified
        dwHotKey: DWORD;             // in, valid when SEE_MASK_HOTKEY is specified
        case integer of
            0: (hIcon: HANDLE;        // not used
                hProcess: HANDLE;);    // out, valid when SEE_MASK_NOCLOSEPROCESS specified
            {$IF  (NTDDI_VERSION >= NTDDI_WIN2K)}
            1: (hMonitor: HANDLE;        // in, valid when SEE_MASK_HMONITOR specified
            );
            {$ENDIF}// (NTDDI_VERSION >= NTDDI_WIN2K)
    end;
    PSHELLEXECUTEINFOW = ^TSHELLEXECUTEINFOW;


function ShellExecuteExA(var pExecInfo: TSHELLEXECUTEINFOA): boolean; stdcall; external Shell32_DLL;
function ShellExecuteExW(var pExecInfo: TSHELLEXECUTEINFOW): boolean; stdcall; external Shell32_DLL;

type
    {$IF  (NTDDI_VERSION >= NTDDI_WIN2K)}
    // deprecated, no longer implemented
    TSHCREATEPROCESSINFOW = record
        cbSize: DWORD;
        fMask: ULONG;
        hwnd: HWND;
        pszFile: LPCWSTR;
        pszParameters: LPCWSTR;
        pszCurrentDirectory: LPCWSTR;
        hUserToken: HANDLE;
        lpProcessAttributes: PSECURITY_ATTRIBUTES;
        lpThreadAttributes: PSECURITY_ATTRIBUTES;
        bInheritHandles: boolean;
        dwCreationFlags: DWORD;
        lpStartupInfo: PSTARTUPINFOW;
        lpProcessInformation: PPROCESS_INFORMATION;
    end;
    PSHCREATEPROCESSINFOW = ^TSHCREATEPROCESSINFOW;

function SHCreateProcessAsUserW(var pscpi: TSHCREATEPROCESSINFOW): boolean; stdcall; external Shell32_DLL;
    {$ENDIF}// (NTDDI_VERSION >= NTDDI_WIN2K)

    {$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
function SHEvaluateSystemCommandTemplate(pszCmdTemplate: PCWSTR; out ppszApplication: PWSTR; out ppszCommandLine: PWSTR;
    out ppszParameters: PWSTR): HResult; stdcall; external;


type
    TASSOCCLASS = (                               //  which other members are used
        ASSOCCLASS_SHELL_KEY = 0,   //  hkeyClass
        ASSOCCLASS_PROGID_KEY,      //  hkeyClass
        ASSOCCLASS_PROGID_STR,      //  pszClass (HKCR\pszClass)
        ASSOCCLASS_CLSID_KEY,       //  hkeyClass
        ASSOCCLASS_CLSID_STR,       //  pszClass (HKCR\CLSID\pszClass)
        ASSOCCLASS_APP_KEY,         //  hkeyClass
        ASSOCCLASS_APP_STR,         //  pszClass (HKCR\Applications\PathFindFileName(pszClass))
        ASSOCCLASS_SYSTEM_STR,      //  pszClass
        ASSOCCLASS_FOLDER,          //  none
        ASSOCCLASS_STAR,            //  none
        {$IF  (NTDDI_VERSION >= NTDDI_WIN8)}
        ASSOCCLASS_FIXED_PROGID_STR,//  pszClass (HKCR\pszClass), do not apply mapping of pszClass based on user defaults
        ASSOCCLASS_PROTOCOL_STR    //  pszClass is a protocol, apply mapping of pszClass based on user defaults
        {$ENDIF}
        );

    TASSOCIATIONELEMENT = record
        ac: TASSOCCLASS;              // required
        hkClass: HKEY;               // may be NULL
        pszClass: PCWSTR;            // may be NULL
    end;

    PASSOCIATIONELEMENT = ^TASSOCIATIONELEMENT;

// the object returned from this API implements IQueryAssociations

function AssocCreateForClasses(const rgClasses: PASSOCIATIONELEMENT; cClasses: ULONG; const riid: TGUID; out ppv): HResult;
    stdcall; external Shell32_DLL;

    {$ENDIF}// (NTDDI_VERSION >= NTDDI_VISTA)

////
////  End ShellExecuteEx and family
////

    {$IF  (NTDDI_VERSION >= NTDDI_WIN2K)}

// RecycleBin


type
    // struct for query recycle bin info
    TSHQUERYRBINFO = record
        cbSize: DWORD;
        {$IFNDEF DARWIN OR defined(_MAC_INT_64)}
        i64Size: int64;
        i64NumItems: int64;
        {$ELSE}
        i64Size: DWORDLONG;
        i64NumItems: DWORDLONG;
        {$ENDIF}
    end;
    PSHQUERYRBINFO = ^TSHQUERYRBINFO;


// flags for SHEmptyRecycleBin

const
    SHERB_NOCONFIRMATION = $00000001;
    SHERB_NOPROGRESSUI = $00000002;
    SHERB_NOSOUND = $00000004;


function SHQueryRecycleBinA(pszRootPath: LPCSTR; var pSHQueryRBInfo: TSHQUERYRBINFO): HResult; stdcall; external Shell32_DLL;
function SHQueryRecycleBinW(pszRootPath: LPCWSTR; var pSHQueryRBInfo: TSHQUERYRBINFO): HResult; stdcall; external Shell32_DLL;

function SHEmptyRecycleBinA(hwnd: HWND; pszRootPath: LPCSTR; dwFlags: DWORD): HResult; stdcall; external Shell32_DLL;
function SHEmptyRecycleBinW(hwnd: HWND; pszRootPath: LPCWSTR; dwFlags: DWORD): HResult; stdcall; external Shell32_DLL;


    {$ENDIF}// (NTDDI_VERSION >= NTDDI_WIN2K)


////
//// Taskbar notification definitions
////


    {$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
type
    TQUERY_USER_NOTIFICATION_STATE = (
        QUNS_NOT_PRESENT = 1,
        // The user is not present.  Heuristic check for modes like: screen saver, locked machine, non-active FUS session
        QUNS_BUSY = 2,    // The user is busy.  Heuristic check for modes like: full-screen app
        QUNS_RUNNING_D3D_FULL_SCREEN = 3,    // full-screen (exlusive-mode) D3D app
        QUNS_PRESENTATION_MODE = 4,    // Windows presentation mode (laptop feature) is turned on
        QUNS_ACCEPTS_NOTIFICATIONS = 5,    // notifications can be freely sent
        {$IF  (NTDDI_VERSION >= NTDDI_WIN7)}
        QUNS_QUIET_TIME = 6,    // We are in OOBE quiet period
        {$ENDIF}
        {$IF  (NTDDI_VERSION >= NTDDI_WIN8)}
        QUNS_APP = 7    // App-mode application
        {$ENDIF}
        );

function SHQueryUserNotificationState(out pquns: TQUERY_USER_NOTIFICATION_STATE): HResult; stdcall; external Shell32_DLL;
    {$ENDIF}// (NTDDI_VERSION >= NTDDI_VISTA)

    {$IF  (NTDDI_VERSION >= NTDDI_WIN7)}
// This api retrieves an IPropertyStore that stores the window's properties.
function SHGetPropertyStoreForWindow(hwnd: HWND; const riid: TGUID; out ppv): HResult; stdcall; external Shell32_DLL;
    {$ENDIF}


type
    TNOTIFYICONDATAA = record
        cbSize: DWORD;
        hWnd: HWND;
        uID: UINT32;
        uFlags: UINT32;
        uCallbackMessage: UINT32;
        hIcon: HICON;
        {$IF  (NTDDI_VERSION < NTDDI_WIN2K)}
        szTip: array [0..63] of char;
        {$ENDIF}
        {$IF  (NTDDI_VERSION >= NTDDI_WIN2K)}
        szTip: array [0..127] of char;
        dwState: DWORD;
        dwStateMask: DWORD;
        szInfo: array [0..255] of char;
        {  uTimeout: UINT32; }
        uVersion: UINT32;  // used with NIM_SETVERSION, values 0, 3 and 4, uTimeout (deprecated as of Windows Vista).
        szInfoTitle: array [0..63] of char;
        dwInfoFlags: DWORD;
        {$ENDIF}
        {$IF  (NTDDI_VERSION >= NTDDI_WINXP)}
        guidItem: TGUID;
        {$ENDIF}
        {$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
        hBalloonIcon: HICON;
        {$ENDIF}
    end;
    PNOTIFYICONDATAA = ^TNOTIFYICONDATAA;

    TNOTIFYICONDATAW = record
        cbSize: DWORD;
        hWnd: HWND;
        uID: UINT32;
        uFlags: UINT32;
        uCallbackMessage: UINT;
        hIcon: HICON;
        {$IF  (NTDDI_VERSION < NTDDI_WIN2K)}
        szTip: array [0..63] of WCHAR;
        {$ENDIF}
        {$IF  (NTDDI_VERSION >= NTDDI_WIN2K)}
        szTip: array [0..127] of WCHAR;
        dwState: DWORD;
        dwStateMask: DWORD;
        szInfo: array [0..255] of WCHAR;
        uVersion: UINT32;  // used with NIM_SETVERSION, values 0, 3 and 4
        szInfoTitle: array [0..63] of WCHAR;
        dwInfoFlags: DWORD;
        {$ENDIF}
        {$IF  (NTDDI_VERSION >= NTDDI_WINXP)}
        guidItem: TGUID;
        {$ENDIF}
        {$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
        hBalloonIcon: HICON;
        {$ENDIF}
    end;
    PNOTIFYICONDATAW = ^TNOTIFYICONDATAW;

{

#define NOTIFYICONDATAA_V1_SIZE     FIELD_OFFSET(NOTIFYICONDATAA, szTip[64])
#define NOTIFYICONDATAW_V1_SIZE     FIELD_OFFSET(NOTIFYICONDATAW, szTip[64])


#define NOTIFYICONDATAA_V2_SIZE     FIELD_OFFSET(NOTIFYICONDATAA, guidItem)
#define NOTIFYICONDATAW_V2_SIZE     FIELD_OFFSET(NOTIFYICONDATAW, guidItem)


#define NOTIFYICONDATAA_V3_SIZE     FIELD_OFFSET(NOTIFYICONDATAA, hBalloonIcon)
#define NOTIFYICONDATAW_V3_SIZE     FIELD_OFFSET(NOTIFYICONDATAW, hBalloonIcon)
}


const
    NIN_SELECT = (WM_USER + 0);
    NINF_KEY = $1;
    NIN_KEYSELECT = (NIN_SELECT or NINF_KEY);

    NIN_BALLOONSHOW = (WM_USER + 2);
    NIN_BALLOONHIDE = (WM_USER + 3);
    NIN_BALLOONTIMEOUT = (WM_USER + 4);
    NIN_BALLOONUSERCLICK = (WM_USER + 5);
    {$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
    NIN_POPUPOPEN = (WM_USER + 6);
    NIN_POPUPCLOSE = (WM_USER + 7);
    {$ENDIF}// (NTDDI_VERSION >= NTDDI_VISTA)
    {$IF  (NTDDI_VERSION >= NTDDI_WIN7)}
    {$ENDIF}// (NTDDI_VERSION >= NTDDI_WIN7)


    NIM_ADD = $00000000;
    NIM_MODIFY = $00000001;
    NIM_DELETE = $00000002;
    NIM_SETFOCUS = $00000003;
    NIM_SETVERSION = $00000004;


    // set NOTIFYICONDATA.uVersion with 0, 3 or 4
    // please read the documentation on the behavior difference that the different versions imply
    NOTIFYICON_VERSION = 3;
    {$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
    NOTIFYICON_VERSION_4 = 4;
    {$ENDIF}// (NTDDI_VERSION >= NTDDI_VISTA)

    NIF_MESSAGE = $00000001;
    NIF_ICON = $00000002;
    NIF_TIP = $00000004;
    NIF_STATE = $00000008;
    NIF_INFO = $00000010;
    {$IF (_WIN32_IE >= $600)}
    NIF_GUID = $00000020;
    {$ENDIF}
    {$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
    NIF_REALTIME = $00000040;
    NIF_SHOWTIP = $00000080;
    {$ENDIF}// (NTDDI_VERSION >= NTDDI_VISTA)

    NIS_HIDDEN = $00000001;
    NIS_SHAREDICON = $00000002;

    // says this is the source of a shared icon

    // Notify Icon Infotip flags
    NIIF_NONE = $00000000;
    // icon flags are mutually exclusive
    // and take only the lowest 2 bits
    NIIF_INFO = $00000001;
    NIIF_WARNING = $00000002;
    NIIF_ERROR = $00000003;
    {$IF  (NTDDI_VERSION >= NTDDI_WINXPSP2)}// also available in NTDDI_WS03SP1
    NIIF_USER = $00000004;
    {$ENDIF}// (NTDDI_VERSION >= NTDDI_WINXPSP2)
    NIIF_ICON_MASK = $0000000F;
    NIIF_NOSOUND = $00000010;

    {$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
    NIIF_LARGE_ICON = $00000020;
    {$ENDIF}// (NTDDI_VERSION >= NTDDI_VISTA)

    {$IF  (NTDDI_VERSION >= NTDDI_WIN7)}
    NIIF_RESPECT_QUIET_TIME = $00000080;
    {$ENDIF}// (NTDDI_VERSION >= NTDDI_WIN7)


type
    TNOTIFYICONIDENTIFIER = record
        cbSize: DWORD;
        hWnd: HWND;
        uID: UINT32;
        guidItem: TGUID;
    end;
    PNOTIFYICONIDENTIFIER = ^TNOTIFYICONIDENTIFIER;


function Shell_NotifyIconA(dwMessage: DWORD; lpData: PNOTIFYICONDATAA): boolean; stdcall; external Shell32_DLL;
function Shell_NotifyIconW(dwMessage: DWORD; lpData: PNOTIFYICONDATAW): boolean; stdcall; external Shell32_DLL;



    {$IF  (NTDDI_VERSION >= NTDDI_WIN7)}
function Shell_NotifyIconGetRect(const identifier: TNOTIFYICONIDENTIFIER; out iconLocation: TRECT): HResult; stdcall; external Shell32_DLL;
    {$ENDIF}// (NTDDI_VERSION >= NTDDI_WIN7)

////
//// End Taskbar Notification Icons
////

////
//// Begin SHGetFileInfo
////

{
 * The SHGetFileInfo API provides an easy way to get attributes
 * for a file given a pathname.
 *
 *   PARAMETERS
 *
 *     pszPath              file name to get info about
 *     dwFileAttributes     file attribs, only used with SHGFI_USEFILEATTRIBUTES
 *     psfi                 place to return file info
 *     cbFileInfo           size of structure
 *     uFlags               flags
 *
 *   RETURN
 *     TRUE if things worked
 }

type
    TSHFILEINFOA = record
        hIcon: HICON;                      // out: icon
        iIcon: int32;                      // out: icon index
        dwAttributes: DWORD;               // out: SFGAO_ flags
        szDisplayName: array [0..MAX_PATH - 1] of char;    // out: display name (or path)
        szTypeName: array [0..79] of char;             // out: type name
    end;
    PSHFILEINFOA = ^TSHFILEINFOA;

    TSHFILEINFOW = record
        hIcon: HICON;                      // out: icon
        iIcon: int32;                      // out: icon index
        dwAttributes: DWORD;               // out: SFGAO_ flags
        szDisplayName: array [0..MAX_PATH - 1] of WCHAR;    // out: display name (or path)
        szTypeName: array [0..79] of WCHAR;             // out: type name
    end;
    PSHFILEINFOW = ^TSHFILEINFOW;



// NOTE: This is also in shlwapi.h.  Please keep in synch.

const
    SHGFI_ICON = $000000100;     // get icon
    SHGFI_DISPLAYNAME = $000000200;     // get display name
    SHGFI_TYPENAME = $000000400;    // get type name
    SHGFI_ATTRIBUTES = $000000800;     // get attributes
    SHGFI_ICONLOCATION = $000001000;     // get icon location
    SHGFI_EXETYPE = $000002000;     // return exe type
    SHGFI_SYSICONINDEX = $000004000;     // get system icon index
    SHGFI_LINKOVERLAY = $000008000;     // put a link overlay on icon
    SHGFI_SELECTED = $000010000;     // show icon in selected state
    {$IF  (NTDDI_VERSION >= NTDDI_WIN2K)}
    SHGFI_ATTR_SPECIFIED = $000020000;     // get only specified attributes
    {$ENDIF}// (NTDDI_VERSION >= NTDDI_WIN2K)
    SHGFI_LARGEICON = $000000000;     // get large icon
    SHGFI_SMALLICON = $000000001;     // get small icon
    SHGFI_OPENICON = $000000002;     // get open icon
    SHGFI_SHELLICONSIZE = $000000004;     // get shell size icon
    SHGFI_PIDL = $000000008;     // pszPath is a pidl
    SHGFI_USEFILEATTRIBUTES = $000000010;     // use passed dwFileAttribute

    SHGFI_ADDOVERLAYS = $000000020;     // apply the appropriate overlays
    SHGFI_OVERLAYINDEX = $000000040;     // Get the index of the overlay
// in the upper 8 bits of the iIcon

function SHGetFileInfoA(pszPath: LPCSTR; dwFileAttributes: DWORD; var psfi: TSHFILEINFOA; cbFileInfo: UINT; uFlags: UINT): DWORD;
    stdcall; external Shell32_DLL;
function SHGetFileInfoW(pszPath: LPCWSTR; dwFileAttributes: DWORD; var psfi: TSHFILEINFOW; cbFileInfo: UINT; uFlags: UINT): DWORD;
    stdcall; external Shell32_DLL;


    {$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
type
    TSHSTOCKICONINFO = record
        cbSize: DWORD;
        hIcon: HICON;
        iSysImageIndex: int32;
        iIcon: int32;
        szPath: array [0..MAX_PATH - 1] of WCHAR;
    end;

const
    SHGSI_ICONLOCATION = 0; // you always get the icon location
    SHGSI_ICON = SHGFI_ICON;
    SHGSI_SYSICONINDEX = SHGFI_SYSICONINDEX;
    SHGSI_LINKOVERLAY = SHGFI_LINKOVERLAY;
    SHGSI_SELECTED = SHGFI_SELECTED;
    SHGSI_LARGEICON = SHGFI_LARGEICON;
    SHGSI_SMALLICON = SHGFI_SMALLICON;
    SHGSI_SHELLICONSIZE = SHGFI_SHELLICONSIZE;

//  Shell icons

type
    TSHSTOCKICONID = (SIID_DOCNOASSOC = 0,          // document (blank page), no associated program
        SIID_DOCASSOC = 1,            // document with an associated program
        SIID_APPLICATION = 2,         // generic application with no custom icon
        SIID_FOLDER = 3,              // folder (closed)
        SIID_FOLDEROPEN = 4,          // folder (open)
        SIID_DRIVE525 = 5,            // 5.25" floppy disk drive
        SIID_DRIVE35 = 6,             // 3.5" floppy disk drive
        SIID_DRIVEREMOVE = 7,         // removable drive
        SIID_DRIVEFIXED = 8,          // fixed (hard disk) drive
        SIID_DRIVENET = 9,            // network drive
        SIID_DRIVENETDISABLED = 10,   // disconnected network drive
        SIID_DRIVECD = 11,            // CD drive
        SIID_DRIVERAM = 12,           // RAM disk drive
        SIID_WORLD = 13,              // entire network
        SIID_SERVER = 15,             // a computer on the network
        SIID_PRINTER = 16,            // printer
        SIID_MYNETWORK = 17,          // My network places
        SIID_FIND = 22,               // Find
        SIID_HELP = 23,               // Help
        SIID_SHARE = 28,              // overlay for shared items
        SIID_LINK = 29,               // overlay for shortcuts to items
        SIID_SLOWFILE = 30,           // overlay for slow items
        SIID_RECYCLER = 31,           // empty recycle bin
        SIID_RECYCLERFULL = 32,       // full recycle bin
        SIID_MEDIACDAUDIO = 40,       // Audio CD Media
        SIID_LOCK = 47,               // Security lock
        SIID_AUTOLIST = 49,           // AutoList
        SIID_PRINTERNET = 50,         // Network printer
        SIID_SERVERSHARE = 51,        // Server share
        SIID_PRINTERFAX = 52,         // Fax printer
        SIID_PRINTERFAXNET = 53,      // Networked Fax Printer
        SIID_PRINTERFILE = 54,        // Print to File
        SIID_STACK = 55,              // Stack
        SIID_MEDIASVCD = 56,          // SVCD Media
        SIID_STUFFEDFOLDER = 57,      // Folder containing other items
        SIID_DRIVEUNKNOWN = 58,       // Unknown drive
        SIID_DRIVEDVD = 59,           // DVD Drive
        SIID_MEDIADVD = 60,           // DVD Media
        SIID_MEDIADVDRAM = 61,        // DVD-RAM Media
        SIID_MEDIADVDRW = 62,         // DVD-RW Media
        SIID_MEDIADVDR = 63,          // DVD-R Media
        SIID_MEDIADVDROM = 64,        // DVD-ROM Media
        SIID_MEDIACDAUDIOPLUS = 65,   // CD+ (Enhanced CD) Media
        SIID_MEDIACDRW = 66,          // CD-RW Media
        SIID_MEDIACDR = 67,           // CD-R Media
        SIID_MEDIACDBURN = 68,        // Burning CD
        SIID_MEDIABLANKCD = 69,       // Blank CD Media
        SIID_MEDIACDROM = 70,         // CD-ROM Media
        SIID_AUDIOFILES = 71,         // Audio files
        SIID_IMAGEFILES = 72,         // Image files
        SIID_VIDEOFILES = 73,         // Video files
        SIID_MIXEDFILES = 74,         // Mixed files
        SIID_FOLDERBACK = 75,         // Folder back
        SIID_FOLDERFRONT = 76,        // Folder front
        SIID_SHIELD = 77,             // Security shield. Use for UAC prompts only.
        SIID_WARNING = 78,            // Warning
        SIID_INFO = 79,               // Informational
        SIID_ERROR = 80,              // Error
        SIID_KEY = 81,                // Key / Secure
        SIID_SOFTWARE = 82,           // Software
        SIID_RENAME = 83,             // Rename
        SIID_DELETE = 84,             // Delete
        SIID_MEDIAAUDIODVD = 85,      // Audio DVD Media
        SIID_MEDIAMOVIEDVD = 86,      // Movie DVD Media
        SIID_MEDIAENHANCEDCD = 87,    // Enhanced CD Media
        SIID_MEDIAENHANCEDDVD = 88,   // Enhanced DVD Media
        SIID_MEDIAHDDVD = 89,         // HD-DVD Media
        SIID_MEDIABLURAY = 90,        // BluRay Media
        SIID_MEDIAVCD = 91,           // VCD Media
        SIID_MEDIADVDPLUSR = 92,      // DVD+R Media
        SIID_MEDIADVDPLUSRW = 93,     // DVD+RW Media
        SIID_DESKTOPPC = 94,          // desktop computer
        SIID_MOBILEPC = 95,           // mobile computer (laptop/notebook)
        SIID_USERS = 96,              // users
        SIID_MEDIASMARTMEDIA = 97,    // Smart Media
        SIID_MEDIACOMPACTFLASH = 98,  // Compact Flash
        SIID_DEVICECELLPHONE = 99,    // Cell phone
        SIID_DEVICECAMERA = 100,      // Camera
        SIID_DEVICEVIDEOCAMERA = 101, // Video camera
        SIID_DEVICEAUDIOPLAYER = 102, // Audio player
        SIID_NETWORKCONNECT = 103,    // Connect to network
        SIID_INTERNET = 104,          // Internet
        SIID_ZIPFILE = 105,           // ZIP file
        SIID_SETTINGS = 106,          // Settings
        // 107-131 are internal Vista RTM icons
        // 132-159 for SP1 icons
        SIID_DRIVEHDDVD = 132,        // HDDVD Drive (all types)
        SIID_DRIVEBD = 133,           // BluRay Drive (all types)
        SIID_MEDIAHDDVDROM = 134,     // HDDVD-ROM Media
        SIID_MEDIAHDDVDR = 135,       // HDDVD-R Media
        SIID_MEDIAHDDVDRAM = 136,     // HDDVD-RAM Media
        SIID_MEDIABDROM = 137,        // BluRay ROM Media
        SIID_MEDIABDR = 138,          // BluRay R Media
        SIID_MEDIABDRE = 139,         // BluRay RE Media (Rewriable and RAM)
        SIID_CLUSTEREDDRIVE = 140,    // Clustered disk
        // 160+ are for Windows 7 icons
        SIID_MAX_ICONS = 181); // SHSTOCKICONID;

const
    SIID_INVALID = (Ord(SIID_MAX_ICONS) - 1);

function SHGetStockIconInfo(siid: TSHSTOCKICONID; uFlags: UINT; var psii: TSHSTOCKICONINFO): HResult; stdcall; external Shell32_DLL;

    {$ENDIF}// (NTDDI_VERSION >= NTDDI_VISTA)


    {$IF  (NTDDI_VERSION >= NTDDI_WIN2K)}
function SHGetDiskFreeSpaceExA(pszDirectoryName: LPCSTR; out pulFreeBytesAvailableToCaller: ULARGE_INTEGER;
    out pulTotalNumberOfBytes: ULARGE_INTEGER; out pulTotalNumberOfFreeBytes: ULARGE_INTEGER): boolean; stdcall; external Shell32_DLL;
function SHGetDiskFreeSpaceExW(pszDirectoryName: LPCWSTR; out pulFreeBytesAvailableToCaller: ULARGE_INTEGER;
    out pulTotalNumberOfBytes: ULARGE_INTEGER; out pulTotalNumberOfFreeBytes: ULARGE_INTEGER): boolean; stdcall; external Shell32_DLL;


function SHGetNewLinkInfoA(pszLinkTo: LPCSTR; pszDir: LPCSTR; out pszName: LPSTR; out pfMustCopy: boolean; uFlags: UINT): boolean;
    stdcall; external Shell32_DLL;

function SHGetNewLinkInfoW(pszLinkTo: LPCWSTR; pszDir: LPCWSTR; out pszName: LPWSTR; out pfMustCopy: boolean; uFlags: UINT): boolean;
    stdcall; external Shell32_DLL;


const
    SHGNLI_PIDL = $000000001;    // pszLinkTo is a pidl
    SHGNLI_PREFIXNAME = $000000002;     // Make name "Shortcut to xxx"
    SHGNLI_NOUNIQUE = $000000004;     // don't do the unique name generation
    SHGNLI_NOLNK = $000000008;     // don't add ".lnk" extension
    {$IF (_WIN32_IE >= _WIN32_IE_IE60)}
    SHGNLI_NOLOCNAME = $000000010;     // use non localized (parsing) name from the target
    {$ENDIF}
    {$IF  (NTDDI_VERSION >= NTDDI_WIN7)}
    SHGNLI_USEURLEXT = $000000020;     // use ".url" extension instead of ".lnk"
    {$ENDIF}
    {$ENDIF}// (NTDDI_VERSION >= NTDDI_WIN2K)


    {$IF  (NTDDI_VERSION >= NTDDI_WIN2K)}
const
    PRINTACTION_OPEN = 0;     // pszBuf1:<PrinterName>
    PRINTACTION_PROPERTIES = 1;      // pszBuf1:<PrinterName>, pszBuf2:optional <PageName>
    PRINTACTION_NETINSTALL = 2;       // pszBuf1:<NetPrinterName>
    PRINTACTION_NETINSTALLLINK = 3;       // pszBuf1:<NetPrinterName>, pszBuf2:<path to store link>
    PRINTACTION_TESTPAGE = 4;       // pszBuf1:<PrinterName>
    PRINTACTION_OPENNETPRN = 5;       // pszBuf1:<NetPrinterName>
    PRINTACTION_DOCUMENTDEFAULTS = 6;     // pszBuf1:<PrinterName>
    PRINTACTION_SERVERPROPERTIES = 7;     // pszBuf1:<Server> or <NetPrinterName>

// deprecated, instead invoke verbs on printers/netprinters using IContextMenu or ShellExecute()

function SHInvokePrinterCommandA(hwnd: HWND; uAction: UINT; lpBuf1: LPCSTR; lpBuf2: LPCSTR; fModal: boolean): boolean;
    stdcall; external Shell32_DLL;
function SHInvokePrinterCommandW(hwnd: HWND; uAction: UINT; lpBuf1: LPCWSTR; lpBuf2: LPCWSTR; fModal: boolean): boolean;
    stdcall; external Shell32_DLL;

    {$ENDIF}// (NTDDI_VERSION >= NTDDI_WIN2K)


    {$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
type
    TOPEN_PRINTER_PROPS_INFOA = record
        dwSize: DWORD;
        pszSheetName: LPSTR;
        uSheetIndex: UINT;
        dwFlags: DWORD;
        bModal: boolean;
    end;
    POPEN_PRINTER_PROPS_INFOA = ^TOPEN_PRINTER_PROPS_INFOA;

    TOPEN_PRINTER_PROPS_INFOW = record
        dwSize: DWORD;
        pszSheetName: LPWSTR;
        uSheetIndex: UINT;
        dwFlags: DWORD;
        bModal: boolean;
    end;
    POPEN_PRINTER_PROPS_INFOW = ^TOPEN_PRINTER_PROPS_INFOW;

const
    PRINT_PROP_FORCE_NAME = $01;

    {$ENDIF}// (NTDDI_VERSION >= NTDDI_WIN2K)

{$ENDIF}{ WINVER >= $0400 }

{$IF  (NTDDI_VERSION >= NTDDI_WIN2K)}


// The SHLoadNonloadedIconOverlayIdentifiers API causes the shell's
// icon overlay manager to load any registered icon overlay
// identifers that are not currently loaded.  This is useful if an
// overlay identifier did not load at shell startup but is needed
// and can be loaded at a later time.  Identifiers already loaded
// are not affected.  Overlay identifiers implement the
// IShellIconOverlayIdentifier interface.

// Returns:
//      S_OK

function SHLoadNonloadedIconOverlayIdentifiers(): HResult; stdcall; external Shell32_DLL;


// The SHIsFileAvailableOffline API determines whether a file
// or folder is available for offline use.

// Parameters:
//     pwszPath             file name to get info about
//     pdwStatus            (optional) OFFLINE_STATUS_* flags returned here

// Returns:
//     S_OK                 File/directory is available offline, unless
//                            OFFLINE_STATUS_INCOMPLETE is returned.
//     E_INVALIDARG         Path is invalid, or not a net path
//     E_FAIL               File/directory is not available offline

// Notes:
//     OFFLINE_STATUS_INCOMPLETE is never returned for directories.
//     Both OFFLINE_STATUS_LOCAL and OFFLINE_STATUS_REMOTE may be returned,
//     indicating "open in both places." This is common when the server is online.

function SHIsFileAvailableOffline(pwszPath: PCWSTR; out pdwStatus: DWORD): HResult; stdcall; external Shell32_DLL;

const
    OFFLINE_STATUS_LOCAL = $0001; // If open, it's open locally
    OFFLINE_STATUS_REMOTE = $0002;  // If open, it's open remotely
    OFFLINE_STATUS_INCOMPLETE = $0004;  // The local copy is currently imcomplete.
// The file will not be available offline
// until it has been synchronized.

{$ENDIF}

{$IF  (NTDDI_VERSION >= NTDDI_WINXP)}
//  sets the specified path to use the string resource
//  as the UI instead of the file system name
function SHSetLocalizedName(pszPath: PCWSTR; pszResModule: PCWSTR; idsRes: int32): HResult; stdcall; external Shell32_DLL;
{$ENDIF}// (NTDDI_VERSION >= NTDDI_WINXP)
{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
//  sets the specified path to use the string resource
//  as the UI instead of the file system name
function SHRemoveLocalizedName(pszPath: PCWSTR): HResult; stdcall; external Shell32_DLL;
//  gets the string resource for the specified path
function SHGetLocalizedName(pszPath: PCWSTR; out pszResModule: PWSTR; cch: UINT; out pidsRes: int32): HResult; stdcall; external Shell32_DLL;
{$ENDIF}// (NTDDI_VERSION >= NTDDI_VISTA)


//====== ShellMessageBox ================================================

// If lpcTitle is NULL, the title is taken from hWnd
// If lpcText is NULL, this is assumed to be an Out Of Memory message
// If the selector of lpcTitle or lpcText is NULL, the offset should be a
//     string resource ID
// The variable arguments must all be 32-bit values (even if fewer bits
//     are actually used)
// lpcText (or whatever string resource it causes to be loaded) should
//     be a formatting string similar to wsprintf except that only the
//     following formats are available:
//         %%              formats to a single '%'
//         %nn%s           the nn-th arg is a string which is inserted
//         %nn%ld          the nn-th arg is a DWORD, and formatted decimal
//         %nn%lx          the nn-th arg is a DWORD, and formatted hex
//     note that lengths are allowed on the %s, %ld, and %lx, just
//                         like wsprintf




function ShellMessageBoxA(hAppInst: HINSTANCE; hWnd: HWND; lpcText: LPCSTR; lpcTitle: LPCSTR; fuStyle: UINT): int32;
    cdecl; external Shell32_DLL;
function ShellMessageBoxW(hAppInst: HINSTANCE; hWnd: HWND; lpcText: LPCWSTR; lpcTitle: LPCWSTR; fuStyle: UINT): int32;
    cdecl; external Shell32_DLL;


{$IF  (NTDDI_VERSION >= NTDDI_WIN2K)}
function IsLFNDriveA(pszPath: LPCSTR): boolean; stdcall; external Shell32_DLL;
function IsLFNDriveW(pszPath: LPCWSTR): boolean; stdcall; external Shell32_DLL;
{$ENDIF}// (NTDDI_VERSION >= NTDDI_WIN2K)


{$IF (_WIN32_IE >= $0600)}
function SHEnumerateUnreadMailAccountsA(hKeyUser: HKEY; dwIndex: DWORD; out pszMailAddress: LPSTR; cchMailAddress: int32): HResult;
    stdcall; external Shell32_DLL;
function SHEnumerateUnreadMailAccountsW(hKeyUser: HKEY; dwIndex: DWORD; out pszMailAddress: LPWSTR; cchMailAddress: int32): HResult;
    stdcall; external Shell32_DLL;

function SHGetUnreadMailCountA(hKeyUser: HKEY; pszMailAddress: LPCSTR; out pdwCount: DWORD; out pFileTime: TFILETIME;
    out pszShellExecuteCommand: LPSTR; cchShellExecuteCommand: int32): HResult; stdcall; external Shell32_DLL;
function SHGetUnreadMailCountW(hKeyUser: HKEY; pszMailAddress: LPCWSTR; out pdwCount: DWORD; out pFileTime: TFILETIME;
    out pszShellExecuteCommand: LPWSTR; cchShellExecuteCommand: int32): HResult; stdcall; external Shell32_DLL;

function SHSetUnreadMailCountA(pszMailAddress: LPCSTR; dwCount: DWORD; pszShellExecuteCommand: LPCSTR): HResult; stdcall; external Shell32_DLL;
function SHSetUnreadMailCountW(pszMailAddress: LPCWSTR; dwCount: DWORD; pszShellExecuteCommand: LPCWSTR): HResult; stdcall; external Shell32_DLL;
{$ENDIF}{  _WIN32_IE >= $0600     }



{$IF  (_WIN32_IE >= $0601)}
function SHTestTokenMembership(hToken: HANDLE; ulRID: ULONG): boolean; stdcall; external;
{$ENDIF}// (_WIN32_IE >= $0601)

{$IF          _WIN32_IE >= $0600}
    {$IF  (NTDDI_VERSION >= NTDDI_WINXP)}
function SHGetImageList(iImageList: int32; const riid: TGUID; out ppvObj): HResult; stdcall; external Shell32_DLL;
    {$ENDIF}// (NTDDI_VERSION >= NTDDI_WINXP)

const
    {$IF  (NTDDI_VERSION >= NTDDI_WINXP)}
    SHIL_LARGE = 0;   // normally 32x32
    SHIL_SMALL = 1;   // normally 16x16
    SHIL_EXTRALARGE = 2;
    SHIL_SYSSMALL = 3;  // like SHIL_SMALL, but tracks system small icon metric correctly
    {$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
    SHIL_JUMBO = 4;  // normally 256x256
    SHIL_LAST = SHIL_JUMBO;
    {$ELSE}
    SHIL_LAST = SHIL_SYSSMALL;
    {$ENDIF}// (NTDDI_VERSION >= NTDDI_VISTA)
    {$ENDIF}// (NTDDI_VERSION >= NTDDI_WINXP)

// Function call types for ntshrui folder sharing helpers
type
    PFNCANSHAREFOLDERW = function(pszPath: PCWSTR): HResult; stdcall;
    PFNSHOWSHAREFOLDERUIW = function(hwndParent: HWND; pszPath: PCWSTR): HResult; stdcall;

{$ENDIF}{  _WIN32_IE >= $0600     }

{$ENDIF} { WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) }

{$IFNDEF _WIN64}
{$A4}
{$ENDIF}

{$IF DEFINED (WINAPI_PARTITION_DESKTOP)}

{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
// API for new Network Address Control

// Instantiation
const
    WC_NETADDRESS: WideString = 'msctls_netaddress';

function InitNetworkAddressControl(): boolean; stdcall; external Shell32_DLL;

// Address Control Messages

// NCM_GETADDRESS returns the type of address that is present in the
// control (based on TBD Net Address flags).  If the input string has
// not been validated using this message will force the validation of
// the input string.  The WPARAM is a BOOL to determine to show the
// balloon tip.  The LPARAM is a pointer to the structure to fill in
// with the address type and address string.
const
    NCM_GETADDRESS = (WM_USER + 1);




    { ToDo
    type
    TNC_ADDRESS = record
        pAddrInfo: PNET_ADDRESS_INFO_; // defined in iphlpapi.h
        PortNumber: USHORT;
        PrefixLength: byte;
    end;
    PNC_ADDRESS = ^TNC_ADDRESS;  }

// NCM_SETALLOWTYPE sets the type of addresses that the control will allow.
// The address flags are defined in iphlpapi.h
const
    NCM_SETALLOWTYPE = (WM_USER + 2);
    // NCM_GETALLOWTYPE returns the currently allowed type mask.
    NCM_GETALLOWTYPE = (WM_USER + 3);
    // NCM_DISPLAYERRORTIP displays the error balloon tip with the correct
    // error string (based on the last failure from the NCM_GETADDRESS call
    NCM_DISPLAYERRORTIP = (WM_USER + 4);

function NetAddr_GetAddress(hwnd: Hwnd; pv: LParam): HResult;
function NetAddr_SetAllowType(hwnd: Hwnd; addrMask: WPARAM): HResult;
function NetAddr_GetAllowType(hwnd: Hwnd): DWORD;
function NetAddr_DisplayErrorTip(hwnd: Hwnd): HResult;
{$ENDIF}// (NTDDI_VERSION >= NTDDI_VISTA)

{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
// Returns the type of media (CD, DVD, Blank, etc) that is in the drive.
// dwMediaContent is set to a combination of ARCONTENT flags.
function SHGetDriveMedia(pszDrive: PCWSTR; out pdwMediaContent: DWORD): HResult; stdcall; external;
{$ENDIF}// (NTDDI_VERSION >= NTDDI_VISTA)

// Windows Parental Controls (WPC) query apis
{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
{$ENDIF}// (NTDDI_VERSION >= NTDDI_VISTA)



implementation



function EIRESID(x: integer): integer;
begin
    Result := -x;
end;


{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
function NetAddr_GetAddress(hwnd: Hwnd; pv: LParam): HResult;
begin
    Result := SNDMSG(hwnd, NCM_GETADDRESS, 0, pv);
end;



function NetAddr_SetAllowType(hwnd: Hwnd; addrMask: WPARAM): HResult;
begin
    Result := SNDMSG(hwnd, NCM_SETALLOWTYPE, addrMask, 0);
end;



function NetAddr_GetAllowType(hwnd: Hwnd): DWORD;
begin
    Result := SNDMSG(hwnd, NCM_GETALLOWTYPE, 0, 0);
end;



function NetAddr_DisplayErrorTip(hwnd: Hwnd): HResult;
begin
    Result := SNDMSG(hwnd, NCM_DISPLAYERRORTIP, 0, 0);
end;
{$ENDIF}// (NTDDI_VERSION >= NTDDI_VISTA)

{$ENDIF} { WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) }

end.


