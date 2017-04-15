unit Win32.ShObjIdl_Core;

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

{ Header Definition: 10.0.14393.0 }

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}


interface

uses
    Windows, Classes, SysUtils,
    Win32.WTypes, Win32.PropIdl,
    Win32.SHTypes, Win32.ServProv,
    Win32.ObjIdl,
    Win32.OleIdl, Win32.PropSys;

const
    IID_IExecuteCommand: TGUID = '{7F9185B0-CB92-43c5-80A9-92277A4F7B54}';
    IID_IProfferService: TGUID = '{cb728b20-f786-11ce-92ad-00aa00a74cd0}';
    IID_IShellItem: TGUID = '{43826d1e-e718-42ee-bc55-a1e261c37bfe}';
    IID_IShellItem2: TGUID = '{7e9fb0d3-919f-4307-ab2e-9b1860310c93}';
    IID_IShellItemImageFactory: TGUID = '{bcc18b79-ba16-442f-80c4-8a59c30c463b}';
    IID_IShellLinkW: TGUID = '{000214F9-0000-0000-C000-000000000046}';
    IID_IQueryContinue: TGUID = '{7307055c-b24a-486b-9f25-163e597a28a9}';
    IID_IPackageExecutionStateChangeNotification: TGUID = '{1BB12A62-2AD8-432B-8CCF-0C2C52AFCD5B}';
    IID_IApplicationDesignModeSettings: TGUID = '{2A3DEE9A-E31D-46D6-8508-BCC597DB3557}';
    IID_IApplicationDesignModeSettings2: TGUID = '{490514E1-675A-4D6E-A58D-E54901B4CA2F}';
    IID_IInitializeWithWindow: TGUID = '{3E68D4BD-7135-4D10-8018-9FB6D9F33FA1}';

    SID_SProfferService: TGUID = '{cb728b20-f786-11ce-92ad-00aa00a74cd0}';      // nearest service that you can proffer to

    LIBID_ShellCoreObjects: TGUID = '{56f9f44f-f74c-4e38-99bc-9f3ebd3d696a}';
    CLSID_ShellItem: TGUID = '{9ac9fbe1-e0a2-4ad6-b4ee-e212013ea917}';
    CLSID_ApplicationDesignModeSettings: TGUID = '{958a6fb5-dcb2-4faf-aafd-7fb054ad1a3b}';


const
    SFGAO_CANCOPY = DROPEFFECT_COPY; // Objects can be copied    ($1)
    SFGAO_CANMOVE = DROPEFFECT_MOVE; // Objects can be moved     ($2)
    SFGAO_CANLINK = DROPEFFECT_LINK; // Objects can be linked    ($4)
    SFGAO_STORAGE = $00000008;     // supports BindToObject(IID_IStorage)
    SFGAO_CANRENAME = $00000010;     // Objects can be renamed
    SFGAO_CANDELETE = $00000020;     // Objects can be deleted
    SFGAO_HASPROPSHEET = $00000040;     // Objects have property sheets
    SFGAO_DROPTARGET = $00000100;     // Objects are drop target
    SFGAO_CAPABILITYMASK = $00000177;
    SFGAO_SYSTEM = $00001000;     // System object
    SFGAO_ENCRYPTED = $00002000;     // Object is encrypted (use alt color)
    SFGAO_ISSLOW = $00004000;     // 'Slow' object
    SFGAO_GHOSTED = $00008000;     // Ghosted icon
    SFGAO_LINK = $00010000;     // Shortcut (link)
    SFGAO_SHARE = $00020000;     // Shared
    SFGAO_READONLY = $00040000;     // Read-only
    SFGAO_HIDDEN = $00080000;     // Hidden object
    SFGAO_DISPLAYATTRMASK = $000FC000;
    SFGAO_FILESYSANCESTOR = $10000000;     // May contain children with SFGAO_FILESYSTEM
    SFGAO_FOLDER = $20000000;     // Support BindToObject(IID_IShellFolder)
    SFGAO_FILESYSTEM = $40000000;     // Is a win32 file system object (file/folder/root)
    SFGAO_HASSUBFOLDER = $80000000;     // May contain children with SFGAO_FOLDER (may be slow)
    SFGAO_CONTENTSMASK = $80000000;
    SFGAO_VALIDATE = $01000000;     // Invalidate cached information (may be slow)
    SFGAO_REMOVABLE = $02000000;     // Is this removeable media?
    SFGAO_COMPRESSED = $04000000;     // Object is compressed (use alt color)
    SFGAO_BROWSABLE = $08000000;     // Supports IShellFolder, but only implements CreateViewObject() (non-folder view)
    SFGAO_NONENUMERATED = $00100000;     // Is a non-enumerated object (should be hidden)
    SFGAO_NEWCONTENT = $00200000;     // Should show bold in explorer tree
    SFGAO_CANMONIKER = $00400000;     // Obsolete
    SFGAO_HASSTORAGE = $00400000;     // Obsolete
    SFGAO_STREAM = $00400000;     // Supports BindToObject(IID_IStream)
    SFGAO_STORAGEANCESTOR = $00800000;     // May contain children with SFGAO_STORAGE or SFGAO_STREAM
    SFGAO_STORAGECAPMASK = $70C50008;     // For determining storage capabilities, ie for open/save semantics
    SFGAO_PKEYSFGAOMASK = $81044000;
// Attributes that are masked out for PKEY_SFGAOFlags because they are considered to cause slow calculations or lack context (SFGAO_VALIDATE | SFGAO_ISSLOW | SFGAO_HASSUBFOLDER and others)


type

    TSFGAOF = ULONG;

    TSIGDN = (
        SIGDN_NORMALDISPLAY = 0,
        SIGDN_PARENTRELATIVEPARSING = Int32($80018001),
        SIGDN_DESKTOPABSOLUTEPARSING = Int32($80028000),
        SIGDN_PARENTRELATIVEEDITING = Int32($80031001),
        SIGDN_DESKTOPABSOLUTEEDITING = Int32($8004c000),
        SIGDN_FILESYSPATH = Int32($80058000),
        SIGDN_URL = Int32($80068000),
        SIGDN_PARENTRELATIVEFORADDRESSBAR = Int32($8007c001),
        SIGDN_PARENTRELATIVE = Int32($80080001),
        SIGDN_PARENTRELATIVEFORUI = Int32($80094001)
        );

    TSICHINTF = (
        SICHINT_DISPLAY = 0,
        SICHINT_ALLFIELDS = Int32($80000000),
        SICHINT_CANONICAL = $10000000,
        SICHINT_TEST_FILESYSPATH_IF_NOT_EQUAL = $20000000
        );



    TSIIGBF = (
        SIIGBF_RESIZETOFIT = 0,
        SIIGBF_BIGGERSIZEOK = $1,
        SIIGBF_MEMORYONLY = $2,
        SIIGBF_ICONONLY = $4,
        SIIGBF_THUMBNAILONLY = $8,
        SIIGBF_INCACHEONLY = $10,
        SIIGBF_CROPTOSQUARE = $20,
        SIIGBF_WIDETHUMBNAILS = $40,
        SIIGBF_ICONBACKGROUND = $80,
        SIIGBF_SCALEUP = $100
        );

    {$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
    TSHARE_ROLE = (
        SHARE_ROLE_INVALID = -1,
        SHARE_ROLE_READER = 0,
        SHARE_ROLE_CONTRIBUTOR = 1,
        SHARE_ROLE_CO_OWNER = 2,
        SHARE_ROLE_OWNER = 3,
        SHARE_ROLE_CUSTOM = 4,
        SHARE_ROLE_MIXED = 5
        );

    TDEF_SHARE_ID = (
        DEFSHAREID_USERS = 1,
        DEFSHAREID_PUBLIC = 2
        );

    {$ENDIF}// NTDDI_VISTA

    {$IF  (NTDDI_VERSION >= NTDDI_WIN8)}
    TPACKAGE_EXECUTION_STATE = (
        PES_UNKNOWN = 0,
        PES_RUNNING = 1,
        PES_SUSPENDING = 2,
        PES_SUSPENDED = 3,
        PES_TERMINATED = 4
        );

    TAPPLICATION_VIEW_STATE = (
        AVS_FULLSCREEN_LANDSCAPE = 0,
        AVS_FILLED = (AVS_FULLSCREEN_LANDSCAPE + 1),
        AVS_SNAPPED = (AVS_FILLED + 1),
        AVS_FULLSCREEN_PORTRAIT = (AVS_SNAPPED + 1)
        );

    TEDGE_GESTURE_KIND = (
        EGK_TOUCH = 0,
        EGK_KEYBOARD = (EGK_TOUCH + 1),
        EGK_MOUSE = (EGK_KEYBOARD + 1)
        );

    TNATIVE_DISPLAY_ORIENTATION = (
        NDO_LANDSCAPE = 0,
        NDO_PORTRAIT = (NDO_LANDSCAPE + 1)
        );

    TAPPLICATION_VIEW_ORIENTATION = (
        AVO_LANDSCAPE = 0,
        AVO_PORTRAIT = (AVO_LANDSCAPE + 1)
        );

    TADJACENT_DISPLAY_EDGES = (
        ADE_NONE = 0,
        ADE_LEFT = $1,
        ADE_RIGHT = $2
        );


    TAPPLICATION_VIEW_SIZE_PREFERENCE = (
        AVSP_DEFAULT = 0,
        AVSP_USE_LESS = 1,
        AVSP_USE_HALF = 2,
        AVSP_USE_MORE = 3,
        AVSP_USE_MINIMUM = 4,
        AVSP_USE_NONE = 5
        );
    {$ENDIF}// NTDDI_WIN8

    {$IF  (NTDDI_VERSION >= NTDDI_WINBLUE)}
    TAPPLICATION_VIEW_MIN_WIDTH = (
        AVMW_DEFAULT = 0,
        AVMW_320 = 1,
        AVMW_500 = 2
        );
    {$ENDIF}// (NTDDI_VERSION >= NTDDI_WINBLUE)


{$IF  (NTDDI_VERSION >= NTDDI_WINBLUE)}
    TFLYOUT_PLACEMENT = (
        FP_DEFAULT = 0,
        FP_ABOVE = (FP_DEFAULT + 1),
        FP_BELOW = (FP_ABOVE + 1),
        FP_LEFT = (FP_BELOW + 1),
        FP_RIGHT = (FP_LEFT + 1)
        );

{$ENDIF}// NTDDI_WINBLUE


    IExecuteCommand = interface;
    IProfferService = interface;
    IShellItem = interface;
    IShellItem2 = interface;
    IShellItemImageFactory = interface;
    IShellLinkW = interface;
    IQueryContinue = interface;
    {$IF  (NTDDI_VERSION >= NTDDI_WIN8)}
    IPackageExecutionStateChangeNotification = interface;
    IApplicationDesignModeSettings = interface;
    {$ENDIF}// NTDDI_WIN8
    {$IF  (NTDDI_VERSION >= NTDDI_WINBLUE)}
    IApplicationDesignModeSettings2 = interface;
    {$ENDIF}
    IInitializeWithWindow = interface;


    IExecuteCommand = interface(IUnknown)
        ['{7F9185B0-CB92-43c5-80A9-92277A4F7B54}']
        function SetKeyState(grfKeyState: DWORD): HResult; stdcall;
        function SetParameters(pszParameters: LPCWSTR): HResult; stdcall;
        function SetPosition(pt: TPOINT): HResult; stdcall;
        function SetShowWindow(nShow: int32): HResult; stdcall;
        function SetNoShowUI(fNoShowUI: boolean): HResult; stdcall;
        function SetDirectory(pszDirectory: LPCWSTR): HResult; stdcall;
        function Execute(): HResult; stdcall;
    end;

    IProfferService = interface(IUnknown)
        ['{cb728b20-f786-11ce-92ad-00aa00a74cd0}']
        function ProfferService(const guidService: TGUID; psp: IServiceProvider; out pdwCookie: DWORD): HResult; stdcall;
        function RevokeService(dwCookie: DWORD): HResult; stdcall;
    end;

    IShellItem = interface(IUnknown)
        ['{43826d1e-e718-42ee-bc55-a1e261c37bfe}']
        function BindToHandler(pbc: IBindCtx; const bhid: TGUID; const riid: TGUID; out ppv): HResult; stdcall;
        function GetParent(out ppsi: IShellItem): HResult; stdcall;
        function GetDisplayName(sigdnName: TSIGDN; out ppszName: LPWSTR): HResult; stdcall;
        function GetAttributes(sfgaoMask: TSFGAOF; out psfgaoAttribs: TSFGAOF): HResult; stdcall;
        function Compare(psi: IShellItem; hint: TSICHINTF; out piOrder: int32): HResult; stdcall;
    end;
    PIShellItem = ^IShellItem;

    IShellItem2 = interface(IShellItem)
        ['{7e9fb0d3-919f-4307-ab2e-9b1860310c93}']
        function GetPropertyStore(flags: TGETPROPERTYSTOREFLAGS; const riid: TGUID; out ppv): HResult; stdcall;
        function GetPropertyStoreWithCreateObject(flags: TGETPROPERTYSTOREFLAGS; punkCreateObject: IUnknown;
            const riid: TGUID; out ppv): HResult; stdcall;
        function GetPropertyStoreForKeys(rgKeys: PPROPERTYKEY; cKeys: UINT; flags: TGETPROPERTYSTOREFLAGS;
            const riid: TGUID; out ppv): HResult; stdcall;
        function GetPropertyDescriptionList(keyType: REFPROPERTYKEY; const riid: TGUID; out ppv): HResult; stdcall;
        function Update(pbc: IBindCtx): HResult; stdcall;
        function GetProperty(key: REFPROPERTYKEY; out ppropvar: TPROPVARIANT): HResult; stdcall;
        function GetCLSID(key: REFPROPERTYKEY; out pclsid: CLSID): HResult; stdcall;
        function GetFileTime(key: REFPROPERTYKEY; out pft: FILETIME): HResult; stdcall;
        function GetInt32(key: REFPROPERTYKEY; out pi: int32): HResult; stdcall;
        function GetString(key: REFPROPERTYKEY; out ppsz: LPWSTR): HResult; stdcall;
        function GetUInt32(key: REFPROPERTYKEY; out pui: ULONG): HResult; stdcall;
        function GetUInt64(key: REFPROPERTYKEY; out pull: ULONGLONG): HResult; stdcall;
        function GetBool(key: REFPROPERTYKEY; out pf: boolean): HResult; stdcall;
    end;


    IShellItemImageFactory = interface(IUnknown)
        ['{bcc18b79-ba16-442f-80c4-8a59c30c463b}']
        function GetImage(size: TSIZE; flags: TSIIGBF; out phbm: HBITMAP): HResult; stdcall;
    end;

    IShellLinkW = interface(IUnknown)
        ['{000214F9-0000-0000-C000-000000000046}']
        function GetPath(out pszFile: LPWSTR; cch: int32; var pfd: TWIN32_FIND_DATAW; fFlags: DWORD): HResult; stdcall;
        function GetIDList(out ppidl: PIDLIST_ABSOLUTE): HResult; stdcall;
        function SetIDList(pidl: PCIDLIST_ABSOLUTE): HResult; stdcall;
        function GetDescription(out pszName: LPWSTR; cch: int32): HResult; stdcall;
        function SetDescription(pszName: LPCWSTR): HResult; stdcall;
        function GetWorkingDirectory(out pszDir: LPWSTR; cch: int32): HResult; stdcall;
        function SetWorkingDirectory(pszDir: LPCWSTR): HResult; stdcall;
        function GetArguments(out pszArgs: LPWSTR; cch: int32): HResult; stdcall;
        function SetArguments(pszArgs: LPCWSTR): HResult; stdcall;
        function GetHotkey(out pwHotkey: word): HResult; stdcall;
        function SetHotkey(wHotkey: word): HResult; stdcall;
        function GetShowCmd(out piShowCmd: int32): HResult; stdcall;
        function SetShowCmd(iShowCmd: int32): HResult; stdcall;
        function GetIconLocation(out pszIconPath: LPWSTR; cch: int32; out piIcon: int32): HResult; stdcall;
        function SetIconLocation(pszIconPath: LPCWSTR; iIcon: int32): HResult; stdcall;
        function SetRelativePath(pszPathRel: LPCWSTR; dwReserved: DWORD): HResult; stdcall;
        function Resolve(hwnd: HWND; fFlags: DWORD): HResult; stdcall;
        function SetPath(pszFile: LPCWSTR): HResult; stdcall;
    end;


    IQueryContinue = interface(IUnknown)
        ['{7307055c-b24a-486b-9f25-163e597a28a9}']
        function QueryContinue(): HResult; stdcall;
    end;


    {$IF  (NTDDI_VERSION >= NTDDI_WIN8)}
    IPackageExecutionStateChangeNotification = interface(IUnknown)
        ['{1BB12A62-2AD8-432B-8CCF-0C2C52AFCD5B}']
        function OnStateChanged(pszPackageFullName: LPCWSTR; pesNewState: TPACKAGE_EXECUTION_STATE): HResult; stdcall;
    end;


    IApplicationDesignModeSettings = interface(IUnknown)
        ['{2A3DEE9A-E31D-46D6-8508-BCC597DB3557}']
        function SetNativeDisplaySize(nativeDisplaySizePixels: TSIZE): HResult; stdcall;
        function SetScaleFactor(scaleFactor: TDEVICE_SCALE_FACTOR): HResult; stdcall;
        function SetApplicationViewState(viewState: TAPPLICATION_VIEW_STATE): HResult; stdcall;
        function ComputeApplicationSize(out applicationSizePixels: TSIZE): HResult; stdcall;
        function IsApplicationViewStateSupported(viewState: TAPPLICATION_VIEW_STATE; nativeDisplaySizePixels: TSIZE;
            scaleFactor: TDEVICE_SCALE_FACTOR; out supported: boolean): HResult; stdcall;
        function TriggerEdgeGesture(edgeGestureKind: TEDGE_GESTURE_KIND): HResult; stdcall;
    end;

    {$ENDIF}// NTDDI_WIN8


    {$IF  (NTDDI_VERSION >= NTDDI_WINBLUE)}

    IApplicationDesignModeSettings2 = interface(IApplicationDesignModeSettings)
        ['{490514E1-675A-4D6E-A58D-E54901B4CA2F}']
        function SetNativeDisplayOrientation(nativeDisplayOrientation: TNATIVE_DISPLAY_ORIENTATION): HResult; stdcall;
        function SetApplicationViewOrientation(viewOrientation: TAPPLICATION_VIEW_ORIENTATION): HResult; stdcall;
        function SetAdjacentDisplayEdges(adjacentDisplayEdges: TADJACENT_DISPLAY_EDGES): HResult; stdcall;
        function SetIsOnLockScreen(isOnLockScreen: boolean): HResult; stdcall;
        function SetApplicationViewMinWidth(viewMinWidth: TAPPLICATION_VIEW_MIN_WIDTH): HResult; stdcall;
        function GetApplicationSizeBounds(out minApplicationSizePixels: TSIZE; out maxApplicationSizePixels: TSIZE): HResult; stdcall;
        function GetApplicationViewOrientation(applicationSizePixels: TSIZE;
            out viewOrientation: TAPPLICATION_VIEW_ORIENTATION): HResult; stdcall;
    end;

    {$ENDIF}// (NTDDI_VERSION >= NTDDI_WINBLUE)

    IInitializeWithWindow = interface(IUnknown)
        ['{3E68D4BD-7135-4D10-8018-9FB6D9F33FA1}']
        function Initialize(hwnd: HWND): HResult; stdcall;
    end;


implementation

end.












































































































