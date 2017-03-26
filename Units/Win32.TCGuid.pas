unit Win32.TCGuid;

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

Copyright (c) Microsoft Corporation. All rights reserved.

Module Name:

    tcguid.h

Abstract:

    This module contains QoS guid definitions for use by the
    Traffic Control users.

--}


{ Header Definition: 10.0.14393.0 }

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}


interface

uses
    Windows, Classes, SysUtils;

{$IF  DEFINED(WINAPI_PARTITION_DESKTOP)}

const
    //    Remaining Bandwidth guid
    GUID_QOS_REMAINING_BANDWIDTH: TGUID = '{c4c51720-40ec-11d1-2c91-00aa00574915}';
    //    Best Effort Bandwidth guid
    GUID_QOS_BESTEFFORT_BANDWIDTH: TGUID = '{ed885290-40ec-11d1-2c91-00aa00574915}';
    //    Latency guid
    GUID_QOS_LATENCY: TGUID = '{fc408ef0-40ec-11d1-2c91-00aa00574915}';
    //    Flow Count guid
    GUID_QOS_FLOW_COUNT: TGUID = '{1147f880-40ed-11d1-2c91-00aa00574915}';
    //    Non Best Effort Limit guid
    GUID_QOS_NON_BESTEFFORT_LIMIT: TGUID = '{185c44e0-40ed-11d1-2c91-00aa00574915}';
    //    Maximum Outstanding Sends guid
    GUID_QOS_MAX_OUTSTANDING_SENDS: TGUID = '{161ffa86-6120-11d1-2c91-00aa00574915}';
    // Packet scheduler statistics
    GUID_QOS_STATISTICS_BUFFER: TGUID = '{bb2c0980-e900-11d1-b07e-0080c71382bf}';
    // Packet Scheduler Flow Mode
    GUID_QOS_FLOW_MODE: TGUID = '{5c82290a-515a-11d2-8e58-00c04fc9bfcb}';
    // ISSLOW Flow
    GUID_QOS_ISSLOW_FLOW: TGUID = '{abf273a4-ee07-11d2-be1b-00a0c99ee63b}';
    // Timer Resolution
    GUID_QOS_TIMER_RESOLUTION: TGUID = '{ba10cc88-f13e-11d2-be1b-00a0c99ee63b}';
    // The conforming IP Precedence value for this flow.
    GUID_QOS_FLOW_IP_CONFORMING: TGUID = '{07f99a8b-fcd2-11d2-be1e-00a0c99ee63b}';
    // The non-conforming IP Precedence value for this flow.
    GUID_QOS_FLOW_IP_NONCONFORMING: TGUID = '{087a5987-fcd2-11d2-be1e-00a0c99ee63b}';
    // The conforming 802.1p value for this flow.
    GUID_QOS_FLOW_8021P_CONFORMING: TGUID = '{08c1e013-fcd2-11d2-be1e-00a0c99ee63b}';
    // The non-conforming 802.1p value for this flow.
    GUID_QOS_FLOW_8021P_NONCONFORMING: TGUID = '{09023f91-fcd2-11d2-be1e-00a0c99ee63b}';
    // This will enable the Averaging statistics in Packet scheduler. (eg: Avg. number of packets in shaper)
    GUID_QOS_ENABLE_AVG_STATS: TGUID = '{bafb6d11-27c4-4801-a46f-ef8080c188c8}';

    GUID_QOS_ENABLE_WINDOW_ADJUSTMENT: TGUID = '{aa966725-d3e9-4c55-b335-2a00279a1e64}';
// This will enable Window size adjustment for TCP connections on a slow link-running ICS

{$ENDIF}{ WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) }


implementation

end.
