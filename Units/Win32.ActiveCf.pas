unit Win32.ActiveCf;

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

//------------------------------------------------------------------------------
// File: ActiveCf.h

// Desc: Contains the data formats for the transfer of VfW4 filters via the
//       clipboard.

// Copyright (c) 1992 - 2001, Microsoft Corporation.  All rights reserved.
//------------------------------------------------------------------------------



{ Header Definition: 10.0.14393.0 }

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}

interface

uses
    Windows, Classes, SysUtils;


{$IF DEFINED(WINAPI_PARTITION_DESKTOP)}

const
    CFSTR_VFW_FILTERLIST: ansistring = 'Video for Windows 4 Filters';

type
    TVFW_FILTERLIST = record
        cFilters: UINT;                     // number of CLSIDs in aClsId
        aClsId: PCLSID;                    // ClsId of each filter
    end;

    tagVFW_FILTERLIST = TVFW_FILTERLIST;
    PVFW_FILTERLIST = ^TVFW_FILTERLIST;

{$ENDIF}{ WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) }


implementation

end.
