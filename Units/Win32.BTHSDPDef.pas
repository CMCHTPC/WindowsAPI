unit Win32.BTHSDPDef;

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
//    Copyright (C) Microsoft.  All rights reserved.

{ Header Definition: 10.0.14393.0 }

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}

interface

uses
    Windows, Classes;

{$IF  DEFINED(WINAPI_PARTITION_DESKTOP)}

{$IF  (NTDDI_VERSION >= NTDDI_WINXPSP2)}
type
    TSDP_LARGE_INTEGER_16 = record
        LowPart: ULONGLONG;
        HighPart: LONGLONG;
    end;
    PSDP_LARGE_INTEGER_16 = ^TSDP_LARGE_INTEGER_16;


    TSDP_ULARGE_INTEGER_16 = record
        LowPart: ULONGLONG;
        HighPart: ULONGLONG;
    end;
    PSDP_ULARGE_INTEGER_16 = ^TSDP_ULARGE_INTEGER_16;


    TNodeContainerType = (
        NodeContainerTypeSequence,
        NodeContainerTypeAlternative);


type
    TSDP_ERROR = USHORT;
    PSDP_ERROR = ^TSDP_ERROR;

    TSDP_TYPE = (
        SDP_TYPE_NIL = $00,
        SDP_TYPE_UINT = $01,
        SDP_TYPE_INT = $02,
        SDP_TYPE_UUID = $03,
        SDP_TYPE_STRING = $04,
        SDP_TYPE_BOOLEAN = $05,
        SDP_TYPE_SEQUENCE = $06,
        SDP_TYPE_ALTERNATIVE = $07,
        SDP_TYPE_URL = $08,
        SDP_TYPE_CONTAINER = $20);
    //  9 - 31 are reserved


    // allow for a little easier type checking / sizing for integers and UUIDs
    // ((SDP_ST_XXX & $F0) >> 4) == SDP_TYPE_XXX
    // size of the data (in bytes) is encoded as ((SDP_ST_XXX & $F0) >> 8)
    TSDP_SPECIFICTYPE = (
        SDP_ST_NONE = $0000,

        SDP_ST_UINT8 = $0010,
        SDP_ST_UINT16 = $0110,
        SDP_ST_UINT32 = $0210,
        SDP_ST_UINT64 = $0310,
        SDP_ST_UINT128 = $0410,

        SDP_ST_INT8 = $0020,
        SDP_ST_INT16 = $0120,
        SDP_ST_INT32 = $0220,
        SDP_ST_INT64 = $0320,
        SDP_ST_INT128 = $0420,

        SDP_ST_UUID16 = $0130,
        SDP_ST_UUID32 = $0220,
        SDP_ST_UUID128 = $0430);


    TSdpAttributeRange = record
        minAttribute: USHORT;
        maxAttribute: USHORT;
    end;
    PSdpAttributeRange = ^TSdpAttributeRange;


type
    TSdpQueryUuidUnion = record
        case integer of
            0: (uuid128: TGUID);
            1: (uuid32: ULONG);
            2: (uuid16: USHORT);
    end;
    PSdpQueryUuidUnion = ^TSdpQueryUuidUnion;

    TSdpQueryUuid = record
        u: TSdpQueryUuidUnion;
        uuidType: USHORT;
    end;
    PSdpQueryUuid = ^TSdpQueryUuid;

{$ENDIF}// (NTDDI_VERSION >= NTDDI_WINXPSP2)

{$ENDIF}{ WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) }


implementation

end.
