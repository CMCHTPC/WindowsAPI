(*===========================================================================

Copyright (c) Microsoft Corporation. All rights reserved.

File: shlobj.h

===========================================================================*)
unit Win32.ShlObj;

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}

interface

uses
  Classes, SysUtils;

const
    //--------------------------------------------------------------------------
    // control IDs known to the view
    //--------------------------------------------------------------------------

    FCIDM_TOOLBAR = (FCIDM_BROWSERFIRST + 0);
    FCIDM_STATUS = (FCIDM_BROWSERFIRST + 1);


    // The resource id of the offline cursor
    // This cursor is avaialble in shdocvw.dll
    IDC_OFFLINE_HAND = 103;
{$IF  (_WIN32_IE >= _WIN32_IE_IE70)}
    IDC_PANTOOL_HAND_OPEN = 104;
    IDC_PANTOOL_HAND_CLOSED = 105;
{$ENDIF}


    // SBCMDID_GETPANE - not necessarily in order
    PANE_NONE = -1;
    PANE_ZONE = 1;
    PANE_OFFLINE = 2;
    PANE_PRINTER = 3;
    PANE_SSL = 4;
    PANE_NAVIGATION = 5;
    PANE_PROGRESS = 6;
{$IF  (_WIN32_IE >= _WIN32_IE_IE60)}
    PANE_PRIVACY = 7;
{$ENDIF}

    // flags for RemoveToolbar
    DWFRF_NORMAL = $0000;
    DWFRF_DELETECONFIGDATA = $0001;


    // flags for AddToolbar
    DWFAF_HIDDEN = $0001;  // add hidden
    DWFAF_GROUP1 = $0002;  // insert at end of group 1
    DWFAF_GROUP2 = $0004;  // insert at end of group 2
    DWFAF_AUTOHIDE = $0010;  // The toolbar will be subject to AutoHide in Full Screen mode

    // flags used to determine the capabilities of the storage for the images
    SHIMSTCAPFLAG_LOCKABLE = $0001;      // does the store require/support locking
    SHIMSTCAPFLAG_PURGEABLE = $0002;     // does the store require dead items purging externally ?


    ////  IShellFolderBand

    // Field mask
    ISFB_MASK_STATE = $00000001; // TRUE if dwStateMask and dwState is valid
    ISFB_MASK_BKCOLOR = $00000002; // TRUE if crBkgnd field is valid
    ISFB_MASK_VIEWMODE = $00000004; // TRUE if wViewMode field is valid
    ISFB_MASK_SHELLFOLDER = $00000008;
    ISFB_MASK_IDLIST = $00000010;
    ISFB_MASK_COLORS = $00000020;// TRUE if crXXXX fields are valid (except bkgnd)

    ISFB_STATE_DEFAULT = $00000000;
    ISFB_STATE_DEBOSSED = $00000001;
    ISFB_STATE_ALLOWRENAME = $00000002;
    ISFB_STATE_NOSHOWTEXT = $00000004; // TRUE if _fNoShowText
    ISFB_STATE_CHANNELBAR = $00000010;// TRUE if we want NavigateTarget support
    ISFB_STATE_QLINKSMODE = $00000020; // TRUE if we want to turn off drag & drop onto content items
    ISFB_STATE_FULLOPEN = $00000040; // TRUE if band should maximize when opened
    ISFB_STATE_NONAMESORT = $00000080; // TRUE if band should _not_ sort icons by name
    ISFB_STATE_BTNMINSIZE = $00000100; // TRUE if band should report min thickness of button

    ISFBVIEWMODE_SMALLICONS = $0001;
    ISFBVIEWMODE_LARGEICONS = $0002;
{$IF  (_WIN32_IE < _WIN32_IE_IE70)}
    ISFBVIEWMODE_LOGOS = $0003;
{$ENDIF}

    DBC_GS_IDEAL = 0; // get the ideal size
    DBC_GS_SIZEDOWN = 1;  // clip the height of a rect to a multiple of the rebar's integral size


    DBC_HIDE = 0; // Band is hidden (being destroyed)
    DBC_SHOW = 1;// Band is visible
    DBC_SHOWOBSCURE = 2; // Band is completely obscured


    DBCID_EMPTY = 0;        // bandsite is empty
    DBCID_ONDRAG = 1;       // (down)DragMoveEnter/Leave vaIn:I4:eDrag
    DBCID_CLSIDOFBAR = 2;   // clsid of bar inside
    DBCID_RESIZE = 3;       // resize from keyboard
    DBCID_GETBAR = 4;       // returns vaOut:VT_UNKNOWN of hosting dockbar (IDeskBar)




    // Flags for SetSafeMode
    SSM_CLEAR = $0000;
    SSM_SET = $0001;
    SSM_REFRESH = $0002;
    SSM_UPDATE = $0004;

    // Flags for Set/GetScheme
    SCHEME_DISPLAY = $0001;
    SCHEME_EDIT = $0002;
    SCHEME_LOCAL = $0004;
    SCHEME_GLOBAL = $0008;
    SCHEME_REFRESH = $0010;
    SCHEME_UPDATE = $0020;
    SCHEME_DONOTUSE = $0040; // used to be SCHEME_ENUMERATE; no longer supported
    SCHEME_CREATE = $0080;


implementation

end.

