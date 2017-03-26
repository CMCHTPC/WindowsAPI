unit Win32.AuthZ;

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

{++

Copyright (c) 2000 Microsoft Corporation

Module Name:

    authz.h

Abstract:

    This module contains the authorization framework APIs and any public data
    structures needed to call these APIs.

Revision History:

    Created - March 2000

--}


{ Header Definition: 10.0.14393.0 }

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}

interface

uses
    Windows, Classes, SysUtils;


{$IF (DEFINED(WINAPI_PARTITION_DESKTOP) or DEFINED(WINAPI_PARTITION_SYSTEM))}
// Flags which may be used at the time of client context creation using a sid.

const
    AUTHZ_SKIP_TOKEN_GROUPS = $2;
    AUTHZ_REQUIRE_S4U_LOGON = $4;
    AUTHZ_COMPUTE_PRIVILEGES = $8;

type
    TAUTHZ_ACCESS_CHECK_RESULTS_HANDLE = Handle;
    TAUTHZ_CLIENT_CONTEXT_HANDLE = Handle;
    TAUTHZ_RESOURCE_MANAGER_HANDLE = Handle;
    TAUTHZ_AUDIT_EVENT_HANDLE = Handle;
    TAUTHZ_AUDIT_EVENT_TYPE_HANDLE = Handle;
    TAUTHZ_SECURITY_EVENT_PROVIDER_HANDLE = Handle;

{$IF (_WIN32_WINNT >= _WIN32_WINNT_WIN8)}
    TAUTHZ_CAP_CHANGE_SUBSCRIPTION_HANDLE = Handle;
{$ENDIF}// (_WIN32_WINNT >= _WIN32_WINNT_WIN8)


    PAUTHZ_ACCESS_CHECK_RESULTS_HANDLE = ^TAUTHZ_ACCESS_CHECK_RESULTS_HANDLE;
    PAUTHZ_CLIENT_CONTEXT_HANDLE = ^TAUTHZ_CLIENT_CONTEXT_HANDLE;
    PAUTHZ_RESOURCE_MANAGER_HANDLE = ^TAUTHZ_RESOURCE_MANAGER_HANDLE;
    PAUTHZ_AUDIT_EVENT_HANDLE = ^TAUTHZ_AUDIT_EVENT_HANDLE;
    PAUTHZ_AUDIT_EVENT_TYPE_HANDLE = ^TAUTHZ_AUDIT_EVENT_TYPE_HANDLE;
    PAUTHZ_SECURITY_EVENT_PROVIDER_HANDLE = ^TAUTHZ_SECURITY_EVENT_PROVIDER_HANDLE;

{$IF (_WIN32_WINNT >= _WIN32_WINNT_WIN8)}
    PAUTHZ_CAP_CHANGE_SUBSCRIPTION_HANDLE = ^TAUTHZ_CAP_CHANGE_SUBSCRIPTION_HANDLE;
{$ENDIF}// (_WIN32_WINNT >= _WIN32_WINNT_WIN8)


    PAUTHZ_SID_OPERATION = pointer;
    PAUTHZ_SECURITY_ATTRIBUTES_INFORMATION = pointer;
    PAUTHZ_SECURITY_ATTRIBUTE_OPERATION = pointer;
    LPSECURITYINFO = pointer;

{$ENDIF}{ WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP | WINAPI_PARTITION_SYSTEM) }

implementation

end.

