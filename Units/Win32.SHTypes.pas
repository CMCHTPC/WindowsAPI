unit Win32.SHTypes;
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


//+-------------------------------------------------------------------------
//
//  Microsoft Windows
//  Copyright (c) Microsoft Corporation. All rights reserved.
//
//--------------------------------------------------------------------------

{ Header Definition: 10.0.14393.0 }

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}


interface

uses
    Windows, Classes, SysUtils,
    Win32.WTypes;

type

    //===========================================================================

    // Object identifiers in the explorer's name space (ItemID and IDList)

    //  All the items that the user can browse with the explorer (such as files,
    // directories, servers, work-groups, etc.) has an identifier which is unique
    // among items within the parent folder. Those identifiers are called item
    // IDs (SHITEMID). Since all its parent folders have their own item IDs,
    // any items can be uniquely identified by a list of item IDs, which is called
    // an ID list (ITEMIDLIST).

    //  ID lists are almost always allocated by the task allocator (see some
    // description below as well as OLE 2.0 SDK) and may be passed across
    // some of shell interfaces (such as IShellFolder). Each item ID in an ID list
    // is only meaningful to its parent folder (which has generated it), and all
    // the clients must treat it as an opaque binary data except the first two
    // bytes, which indicates the size of the item ID.

    //  When a shell extension -- which implements the IShellFolder interace --
    // generates an item ID, it may put any information in it, not only the data
    // with that it needs to identifies the item, but also some additional
    // information, which would help implementing some other functions efficiently.
    // For example, the shell's IShellFolder implementation of file system items
    // stores the primary (long) name of a file or a directory as the item
    // identifier, but it also stores its alternative (short) name, size and date
    // etc.

    //  When an ID list is passed to one of shell APIs (such as SHGetPathFromIDList),
    // it is always an absolute path -- relative from the root of the name space,
    // which is the desktop folder. When an ID list is passed to one of IShellFolder
    // member function, it is always a relative path from the folder (unless it
    // is explicitly specified).

    //===========================================================================

    // SHITEMID -- Item ID  (mkid)
    //     USHORT      cb;             // Size of the ID (including cb itself)
    //     BYTE        abID[];         // The item ID (variable length)


    //include <pshpack1.h>
{$A1}

    TSHITEMID = record
        cb: USHORT;
        abID: PByte;
    end;

    //include <poppack.h>
{$A4}


    LPSHITEMID = ^TSHITEMID;

    LPCSHITEMID = ^TSHITEMID;


    // ITEMIDLIST -- List if item IDs (combined with 0-terminator)

    //include <pshpack1.h>
{$A1}
    TITEMIDLIST = record
        mkid: TSHITEMID;
    end;

    TITEMIDLIST_RELATIVE = TITEMIDLIST;

    TITEMID_CHILD = TITEMIDLIST;

    TITEMIDLIST_ABSOLUTE = TITEMIDLIST;


    // include <poppack.h>
{$A4}
TBYTE_BLOB = word; // Todo !!!

    wirePIDL = ^TBYTE_BLOB;

    LPITEMIDLIST = ^ITEMIDLIST;

    LPCITEMIDLIST = ^TITEMIDLIST;


    PIDLIST_ABSOLUTE = LPITEMIDLIST;
    PCIDLIST_ABSOLUTE = LPCITEMIDLIST;
    PCUIDLIST_ABSOLUTE = LPCITEMIDLIST;
    PIDLIST_RELATIVE = LPITEMIDLIST;
    PCIDLIST_RELATIVE = LPCITEMIDLIST;
    PUIDLIST_RELATIVE = LPITEMIDLIST;
    PCUIDLIST_RELATIVE = LPCITEMIDLIST;
    PITEMID_CHILD = LPITEMIDLIST;
    PCITEMID_CHILD = LPCITEMIDLIST;
    PUITEMID_CHILD = LPITEMIDLIST;
    PCUITEMID_CHILD = LPCITEMIDLIST;
    PCUITEMID_CHILD_ARRAY = LPCITEMIDLIST;
    PCUIDLIST_RELATIVE_ARRAY = LPCITEMIDLIST;
    PCIDLIST_ABSOLUTE_ARRAY = LPCITEMIDLIST;
    PCUIDLIST_ABSOLUTE_ARRAY = LPCITEMIDLIST;



    TWIN32_FIND_DATAA = record
        dwFileAttributes: DWORD;
        ftCreationTime: TFILETIME;
        ftLastAccessTime: TFILETIME;
        ftLastWriteTime: TFILETIME;
        nFileSizeHigh: DWORD;
        nFileSizeLow: DWORD;
        dwReserved0: DWORD;
        dwReserved1: DWORD;
        cFileName: array [0.. 259] of char;
        cAlternateFileName: array [0.. 13] of char;
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
        cFileName: array [0.. 259] of WCHAR;
        cAlternateFileName: array [0.. 13] of WCHAR;
    end;



    PWIN32_FIND_DATAW = ^TWIN32_FIND_DATAW;



    //-------------------------------------------------------------------------

    // struct STRRET

    // structure for returning strings from IShellFolder member functions

    //-------------------------------------------------------------------------

    //  uType indicate which union member to use
    //    STRRET_WSTR    Use STRRET.pOleStr     must be freed by caller of GetDisplayNameOf
    //    STRRET_OFFSET  Use STRRET.uOffset     Offset into SHITEMID for ANSI string
    //    STRRET_CSTR    Use STRRET.cStr        ANSI Buffer

    TSTRRET_TYPE = (
        STRRET_WSTR = 0,
        STRRET_OFFSET = $1,
        STRRET_CSTR = $2
        );


    //include <pshpack8.h>
{$A8}
    TSTRRET = record
        uType: UINT;

        case integer of
            0: (pOleStr: LPWSTR);
            1: (uOffset: UINT);
            2: (cStr: array [0.. 259] of char);
    end;

    // include <poppack.h>
{$A4}

    PSTRRET = ^TSTRRET;

    //-------------------------------------------------------------------------

    // struct SHELLDETAILS

    // structure for returning strings from IShellDetails

    //-------------------------------------------------------------------------

    //  fmt;            // LVCFMT_* value (header only)
    //  cxChar;         // Number of 'average' characters (header only)
    //  str;            // String information

    //include <pshpack1.h>
{$A1}
    TSHELLDETAILS = record
        fmt: int32;
        cxChar: int32;
        str: TSTRRET;
    end;

    PSHELLDETAILS = ^TSHELLDETAILS;

    //include <poppack.h>
{$A4}

{$IF  (_WIN32_IE >= _WIN32_IE_IE60SP2)}
type
    TPERCEIVED = (
        PERCEIVED_TYPE_FIRST = -3,
        PERCEIVED_TYPE_CUSTOM = -3,
        PERCEIVED_TYPE_UNSPECIFIED = -2,
        PERCEIVED_TYPE_FOLDER = -1,
        PERCEIVED_TYPE_UNKNOWN = 0,
        PERCEIVED_TYPE_TEXT = 1,
        PERCEIVED_TYPE_IMAGE = 2,
        PERCEIVED_TYPE_AUDIO = 3,
        PERCEIVED_TYPE_VIDEO = 4,
        PERCEIVED_TYPE_COMPRESSED = 5,
        PERCEIVED_TYPE_DOCUMENT = 6,
        PERCEIVED_TYPE_SYSTEM = 7,
        PERCEIVED_TYPE_APPLICATION = 8,
        PERCEIVED_TYPE_GAMEMEDIA = 9,
        PERCEIVED_TYPE_CONTACTS = 10,
        PERCEIVED_TYPE_LAST = 10
        );

const
    PERCEIVEDFLAG_UNDEFINED = $0000;
    PERCEIVEDFLAG_SOFTCODED = $0001;
    PERCEIVEDFLAG_HARDCODED = $0002;
    PERCEIVEDFLAG_NATIVESUPPORT = $0004;
    PERCEIVEDFLAG_GDIPLUS = $0010;
    PERCEIVEDFLAG_WMSDK = $0020;
    PERCEIVEDFLAG_ZIPFOLDER = $0040;

type
    TPERCEIVEDFLAG = DWORD;

{$ENDIF}// _WIN32_IE_IE60SP2



{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
    TCOMDLG_FILTERSPEC = record
        pszName: LPCWSTR;
        pszSpec: LPCWSTR;
    end;

    PCOMDLG_FILTERSPEC = ^TCOMDLG_FILTERSPEC;

{$ENDIF}// NTDDI_VISTA

    TKNOWNFOLDERID = TGUID;
    PKNOWNFOLDERID = ^TKNOWNFOLDERID;

    REFKNOWNFOLDERID = ^TKNOWNFOLDERID;


    TKF_REDIRECT_FLAGS = DWORD;
    TFOLDERTYPEID = TGUID;

    REFFOLDERTYPEID = ^TFOLDERTYPEID;

    TTASKOWNERID = TGUID;

    REFTASKOWNERID = ^TTASKOWNERID;

    TELEMENTID = TGUID;

    REFELEMENTID = ^TELEMENTID;


    TLOGFONTA = record
        lfHeight: LONG;
        lfWidth: LONG;
        lfEscapement: LONG;
        lfOrientation: LONG;
        lfWeight: LONG;
        lfItalic: byte;
        lfUnderline: byte;
        lfStrikeOut: byte;
        lfCharSet: byte;
        lfOutPrecision: byte;
        lfClipPrecision: byte;
        lfQuality: byte;
        lfPitchAndFamily: byte;
        lfFaceName: array [0.. 31] of char;
    end;


    TLOGFONTW = record
        lfHeight: LONG;
        lfWidth: LONG;
        lfEscapement: LONG;
        lfOrientation: LONG;
        lfWeight: LONG;
        lfItalic: byte;
        lfUnderline: byte;
        lfStrikeOut: byte;
        lfCharSet: byte;
        lfOutPrecision: byte;
        lfClipPrecision: byte;
        lfQuality: byte;
        lfPitchAndFamily: byte;
        lfFaceName: array[0.. 31] of WCHAR;
    end;

    TLOGFONT = TLOGFONTW;

    TSHCOLSTATE = (
        SHCOLSTATE_DEFAULT = 0,
        SHCOLSTATE_TYPE_STR = $1,
        SHCOLSTATE_TYPE_INT = $2,
        SHCOLSTATE_TYPE_DATE = $3,
        SHCOLSTATE_TYPEMASK = $f,
        SHCOLSTATE_ONBYDEFAULT = $10,
        SHCOLSTATE_SLOW = $20,
        SHCOLSTATE_EXTENDED = $40,
        SHCOLSTATE_SECONDARYUI = $80,
        SHCOLSTATE_HIDDEN = $100,
        SHCOLSTATE_PREFER_VARCMP = $200,
        SHCOLSTATE_PREFER_FMTCMP = $400,
        SHCOLSTATE_NOSORTBYFOLDERNESS = $800,
        SHCOLSTATE_VIEWONLY = $10000,
        SHCOLSTATE_BATCHREAD = $20000,
        SHCOLSTATE_NO_GROUPBY = $40000,
        SHCOLSTATE_FIXED_WIDTH = $1000,
        SHCOLSTATE_NODPISCALE = $2000,
        SHCOLSTATE_FIXED_RATIO = $4000,
        SHCOLSTATE_DISPLAYMASK = $f000
        );

    TSHCOLSTATEF = DWORD;

    TSHCOLUMNID = TPROPERTYKEY;

    LPCSHCOLUMNID = ^TSHCOLUMNID;

    TDEVICE_SCALE_FACTOR = (
        DEVICE_SCALE_FACTOR_INVALID = 0,
        SCALE_100_PERCENT = 100,
        SCALE_120_PERCENT = 120,
        SCALE_125_PERCENT = 125,
        SCALE_140_PERCENT = 140,
        SCALE_150_PERCENT = 150,
        SCALE_160_PERCENT = 160,
        SCALE_175_PERCENT = 175,
        SCALE_180_PERCENT = 180,
        SCALE_200_PERCENT = 200,
        SCALE_225_PERCENT = 225,
        SCALE_250_PERCENT = 250,
        SCALE_300_PERCENT = 300,
        SCALE_350_PERCENT = 350,
        SCALE_400_PERCENT = 400,
        SCALE_450_PERCENT = 450,
        SCALE_500_PERCENT = 500
        );



implementation

end.
