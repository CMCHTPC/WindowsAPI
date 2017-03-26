unit Win32.CAPI;

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

//+---------------------------------------------------------------------------

//  Microsoft Windows
//  Copyright (C) Microsoft Corporation.  All Rights Reserved.

//  File:       capi.h

//----------------------------------------------------------------------------

{ Header Definition: 10.0.14393.0 }

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}

interface

uses
    Windows, Classes, SysUtils;

{$IF DEFINED (WINAPI_PARTITION_DESKTOP)}

{$IFNDEF JAVA_TRUST_PROVIDER}
{$DEFINE JAVA_TRUST_PROVIDER}
type
    TJAVA_TRUST = record
        cbSize: DWORD;                   // Size of structure
        flag: DWORD;                     // Reserved
        fAllActiveXPermissions: boolean;
        // ActiveX explicitly asked for all (must have been signed)
        fAllPermissions: boolean;          // Java permissions, explicit ask for all
        dwEncodingType: DWORD;           // Encoding type
        pbJavaPermissions: PBYTE;        // Encoded java permission blob
        cbJavaPermissions: DWORD;
        pbSigner: PBYTE;                 // Encoded signer.
        cbSigner: DWORD;
        pwszZone: LPCWSTR;                 // Zone index (copied from action data)
        guidZone: TGUID;                 // Not used currently
        hVerify: HRESULT;                  // Authenticode policy return
    end;
    PJAVA_TRUST = ^TJAVA_TRUST;


{$ENDIF}// !defined(JAVA_TRUST_PROVIDER)

{$ENDIF}(* WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) *)

implementation

end.
