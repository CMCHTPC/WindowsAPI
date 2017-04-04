unit Win32.WS2BTH;
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

Copyright (c) 2000  Microsoft Corporation

Module Name:

        ws2bth.h

Abstract:

        Winsock 2 Bluetooth Annex definitions.

Notes:

        Change BT_* to BTH_*

--}

{ Header Definition: 10.0.14393.0 }

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}

interface

uses
    Windows, Classes,
    Win32.BTHDef, Win32.BthLEDef,
    Win32.BTHSDPDef;

{$IF  DEFINED(WINAPI_PARTITION_DESKTOP)}


{$IF  (NTDDI_VERSION >= NTDDI_WINXPSP2)}

//include <pshpack1.h>
{$A1}

const
    BT_PORT_ANY = ULONG(-1);
    BT_PORT_MIN = $1;
    BT_PORT_MAX = $ffff;
    BT_PORT_DYN_FIRST = $1001;

    // These three definitions are duplicated in winsock2.h to reserve ordinals
    AF_BTH = 32;
    PF_BTH = AF_BTH;
    NS_BTH = 16;

type
    TSOCKADDR_BTH = record
        addressFamily: USHORT;  // Always AF_BTH
        btAddr: TBTH_ADDR;         // Bluetooth device address
        serviceClassId: TGUID; // [OPTIONAL] system will query SDP for port
        port: ULONG;           // RFCOMM channel or L2CAP PSM
    end;
    PSOCKADDR_BTH = ^TSOCKADDR_BTH;


const
    SVCID_BTH_PROVIDER: TGUID = '{06aa63e0-7d60-41ff-afb2-3ee6d2d9392d}';
    BTH_ADDR_STRING_SIZE = 12;  // max size from WSAAddressToString

    // Bluetooth protocol #s are assigned according to the Bluetooth
    // Assigned Numbers portion of the Bluetooth Specification

    BTHPROTO_RFCOMM = $0003;
    BTHPROTO_L2CAP = $0100;

    SOL_RFCOMM = BTHPROTO_RFCOMM;
    SOL_L2CAP = BTHPROTO_L2CAP;
    SOL_SDP = $0101;


    // SOCKET OPTIONS

    SO_BTH_AUTHENTICATE = $80000001;  // optlen=sizeof(ULONG), optval = &(ULONG)TRUE/FALSE
    SO_BTH_ENCRYPT = $00000002; // optlen=sizeof(ULONG), optval = &(ULONG)TRUE/FALSE
    SO_BTH_MTU = $80000007; // optlen=sizeof(ULONG), optval = &mtu
    SO_BTH_MTU_MAX = $80000008; // optlen=sizeof(ULONG), optval = &max. mtu
    SO_BTH_MTU_MIN = $8000000a; // optlen=sizeof(ULONG), optval = &min. mtu


    // Socket option parameters

    // 3-DH5 => payload of 1021 => L2cap payload of 1017 => RFComm payload of 1011
    RFCOMM_MAX_MTU = $000003F3; // L2CAP MTU (1017) - RFCOMM header size (6)
    RFCOMM_MIN_MTU = $00000017;  // RFCOMM spec sec 5.3 table 5.1


    // NAME SERVICE PROVIDER DEFINITIONS
    // For calling WSASetService
    // and WSALookupServiceBegin, WSALookupServiceNext, WSALookupServiceEnd
    // with Bluetooth-specific extensions

    BTH_SDP_VERSION = 1;


// [OPTIONAL] passed in BLOB member of WSAQUERYSET
// QUERYSET and its lpBlob member are copied & converted
// to unicode in the system for non-unicode applications.
// However, nothing is copied back upon return.  In
// order for the system to return data such as pRecordHandle,
// it much have an extra level of indirection from lpBlob

type
    TBTH_SET_SERVICE = record
        // This version number will change when/if the binary format of
        // SDP records change, affecting the format of pRecord.
        // Set to BTH_SDP_VERSION by client, and returned by system
        pSdpVersion: PULONG;
        // Handle to SDP record.  When BTH_SET_SERVICE structure is later
        // passed to WSASetService RNRSERVICE_DELETE, this handle identifies the
        // record to delete.
        pRecordHandle: PHANDLE;
        // COD_SERVICE_* bit(s) associated with this SDP record, which will be
        // advertised when the local radio is found during device inquiry.
        // When the last SDP record associated with a bit is deleted, that
        // service bit is no longer reported in repsonse to inquiries
        fCodService: ULONG;    // COD_SERVICE_* bits
        Reserved: array [0..4] of ULONG;    // Reserved by system.  Must be zero.
        ulRecordLength: ULONG; // length of pRecord which follows
        pRecord: PUCHAR;     // SDP record as defined by bluetooth spec
    end;
    PBTH_SET_SERVICE = ^TBTH_SET_SERVICE;


// Default device inquiry duration in seconds
// The application thread will be blocked in WSALookupServiceBegin
// for the duration of the device inquiry, so this value needs to
// be balanced against the chance that a device that is actually
// present might not being found by Bluetooth in this time
// Paging improvements post-1.1 will cause devices to be
// found generally uniformly in the 0-6 sec timeperiod

const
    SDP_DEFAULT_INQUIRY_SECONDS = 6;
    SDP_MAX_INQUIRY_SECONDS = 60;
    // Default maximum number of devices to search for
    SDP_DEFAULT_INQUIRY_MAX_RESPONSES = 255;
    SDP_SERVICE_SEARCH_REQUEST = 1;
    SDP_SERVICE_ATTRIBUTE_REQUEST = 2;
    SDP_SERVICE_SEARCH_ATTRIBUTE_REQUEST = 3;


// [OPTIONAL] input restrictions on device inquiry
// Passed in BLOB of LUP_CONTAINERS (device) search

type
    TBTH_QUERY_DEVICE = record
        LAP: ULONG;                    // reserved: must be 0 (GIAC inquiry only)
        length: UCHAR;                 // requested length of inquiry (seconds)
    end;
    PBTH_QUERY_DEVICE = ^TBTH_QUERY_DEVICE;


    // [OPTIONAL] Restrictions on searching for a particular service
    // Passed in BLOB of !LUP_CONTAINERS (service) search

    TBTH_QUERY_SERVICE = record
        AType: ULONG;           // one of SDP_SERVICE_*
        serviceHandle: ULONG;
        uuids: array [0..MAX_UUIDS_IN_QUERY - 1] of TSdpQueryUuid;
        numRange: ULONG;
        pRange: PSdpAttributeRange;
    end;
    PBTH_QUERY_SERVICE = ^TBTH_QUERY_SERVICE;


// BTHNS_RESULT_*

// Bluetooth specific flags returned from WSALookupServiceNext
// in WSAQUERYSET.dwOutputFlags in response to device inquiry

// Local device is paired with remote device

const
    BTHNS_RESULT_DEVICE_CONNECTED = $00010000;
    BTHNS_RESULT_DEVICE_REMEMBERED = $00020000;
    BTHNS_RESULT_DEVICE_AUTHENTICATED = $00040000;


// SOCKET IOCTLs


const
    IOC_OUT = $40000000;      { copy out parameters }
    IOC_IN = $80000000;      {  copy in parameters }
    IOC_INOUT = (IOC_IN or IOC_OUT);
    IOC_VENDOR = $18000000;

    SIO_RFCOMM_SEND_COMMAND = (IOC_INOUT or (IOC_VENDOR) or (101));
    SIO_RFCOMM_WAIT_COMMAND = (IOC_INOUT or (IOC_VENDOR) or (102));


    // These IOCTLs are for test/validation/conformance and may only be
    // present in debug/checked builds of the system

    SIO_BTH_PING = (IOC_INOUT or (IOC_VENDOR) or (8));
    SIO_BTH_INFO = (IOC_INOUT or (IOC_VENDOR) or (9));
    SIO_RFCOMM_SESSION_FLOW_OFF = (IOC_INOUT or (IOC_VENDOR) or (103));
    SIO_RFCOMM_TEST = (IOC_INOUT or (IOC_VENDOR) or (104));
    SIO_RFCOMM_USECFC = (IOC_INOUT or (IOC_VENDOR) or (105));
{      RESERVED                          (IOC_INOUT or (IOC_VENDOR) or (106));}

// SOCKET IOCTL DEFINITIONS

const
    // ToDo        MSC_EA_BIT  =    EA_BIT;
    MSC_FC_BIT = (1 shl 1);      // Flow control, clear if we can receive
    MSC_RTC_BIT = (1 shl 2);      // Ready to communicate, set when ready
    MSC_RTR_BIT = (1 shl 3);      // Ready to receive, set when ready
    MSC_RESERVED = ((1 shl 4) or (1 shl 5));// Reserved by spec, must be 0
    MSC_IC_BIT = (1 shl 6);      // Incoming call
    MSC_DV_BIT = (1 shl 7);      // Data valid
    MSC_BREAK_BIT = (1 shl 1);      // Set if sending break

procedure MSC_SET_BREAK_LENGTH(var b: uint; l: UINT);

// Structure definition from Bluetooth RFCOMM spec, TS 07.10 5.4.6.3.7

type
    TRFCOMM_MSC_DATA = record
        Signals: UCHAR;
        Break: UCHAR;
    end;
    PRFCOMM_MSC_DATA = ^TRFCOMM_MSC_DATA;


// Structure definition from Bluetooth RFCOMM spec, TS 07.10 5.4.6.3.10

const
    RLS_ERROR = $01;
    RLS_OVERRUN = $02;
    RLS_PARITY = $04;
    RLS_FRAMING = $08;

type
    TRFCOMM_RLS_DATA = record
        LineStatus: UCHAR;
    end;
    PRFCOMM_RLS_DATA = ^TRFCOMM_RLS_DATA;

// Structure definition from Bluetooth RFCOMM spec, TS 07.10 5.4.6.3.9

const
    RPN_BAUD_2400 = 0;
    RPN_BAUD_4800 = 1;
    RPN_BAUD_7200 = 2;
    RPN_BAUD_9600 = 3;
    RPN_BAUD_19200 = 4;
    RPN_BAUD_38400 = 5;
    RPN_BAUD_57600 = 6;
    RPN_BAUD_115200 = 7;
    RPN_BAUD_230400 = 8;

    RPN_DATA_5 = $0;
    RPN_DATA_6 = $1;
    RPN_DATA_7 = $2;
    RPN_DATA_8 = $3;

    RPN_STOP_1 = $0;
    RPN_STOP_1_5 = $4;

    RPN_PARITY_NONE = $00;
    RPN_PARITY_ODD = $08;
    RPN_PARITY_EVEN = $18;
    RPN_PARITY_MARK = $28;
    RPN_PARITY_SPACE = $38;


    RPN_FLOW_X_OUT = $02;
    RPN_FLOW_RTR_IN = $04;
    RPN_FLOW_RTR_OUT = $08;
    RPN_FLOW_RTC_IN = $10;
    RPN_FLOW_RTC_OUT = $20;


    RPN_FLOW_X_IN = $01;

    RPN_PARAM_BAUD = $01;
    RPN_PARAM_DATA = $02;
    RPN_PARAM_STOP = $04;
    RPN_PARAM_PARITY = $08;
    RPN_PARAM_P_TYPE = $10;
    RPN_PARAM_XON = $20;
    RPN_PARAM_XOFF = $40;


    RPN_PARAM_X_IN = $01;
    RPN_PARAM_X_OUT = $02;
    RPN_PARAM_RTR_IN = $04;
    RPN_PARAM_RTR_OUT = $08;
    RPN_PARAM_RTC_IN = $10;
    RPN_PARAM_RTC_OUT = $20;


type
    TRFCOMM_RPN_DATA = record
        Baud: UCHAR;
        Data: UCHAR;
        FlowControl: UCHAR;
        XonChar: UCHAR;
        XoffChar: UCHAR;
        ParameterMask1: UCHAR;
        ParameterMask2: UCHAR;
    end;
    PRFCOMM_RPN_DATA = ^TRFCOMM_RPN_DATA;

const
    RFCOMM_CMD_NONE = 0;
    RFCOMM_CMD_MSC = 1;
    RFCOMM_CMD_RLS = 2;
    RFCOMM_CMD_RPN = 3;
    RFCOMM_CMD_RPN_REQUEST = 4;
    RFCOMM_CMD_RPN_RESPONSE = 5;
{      RESERVED_CMD              =  6 }

type
    TRFCOMM_COMMAND = record
        CmdType: ULONG;          // one of RFCOMM_CMD_*
        case integer of
            0: (MSC: TRFCOMM_MSC_DATA);
            1: (RLS: TRFCOMM_RLS_DATA);
            2: (RPN: TRFCOMM_RPN_DATA);
    end;
    PRFCOMM_COMMAND = ^TRFCOMM_COMMAND;


    // These structures are for test/validation/conformance and may only be
    // present in debug/checked builds of the system

    TBTH_PING_REQ = record
        btAddr: TBTH_ADDR;
        dataLen: UCHAR;
        Data: array [0..MAX_L2CAP_PING_DATA_LENGTH - 1] of UCHAR;
    end;
    PBTH_PING_REQ = ^TBTH_PING_REQ;

    TBTH_PING_RSP = record
        dataLen: UCHAR;
        Data: array [0..MAX_L2CAP_PING_DATA_LENGTH - 1] of UCHAR;
    end;
    PBTH_PING_RSP = ^TBTH_PING_RSP;

    TBTH_INFO_REQ = record
        btAddr: TBTH_ADDR;
        infoType: USHORT;
    end;
    PBTH_INFO_REQ = ^TBTH_INFO_REQ;

    TBTH_INFO_RSP = record
        Result: USHORT;
        dataLen: UCHAR;
        case integer of
            0: (connectionlessMTU: USHORT);
            1: (Data: array [0..MAX_L2CAP_INFO_DATA_LENGTH - 1] of UCHAR);
    end;
    PBTH_INFO_RSP = ^TBTH_INFO_RSP;


    // WinCE compatible struct names

    TBTHNS_SETBLOB = TBTH_SET_SERVICE;
    PBTHNS_SETBLOB = ^TBTHNS_SETBLOB;
    TBTHNS_INQUIRYBLOB = TBTH_QUERY_DEVICE;
    PBTHNS_INQUIRYBLOB = ^TBTHNS_INQUIRYBLOB;
    TBTHNS_RESTRICTIONBLOB = TBTH_QUERY_SERVICE;
    PBTHNS_RESTRICTIONBLOB = ^TBTHNS_RESTRICTIONBLOB;

//include <poppack.h>
{$A4}

{$ENDIF}// (NTDDI_VERSION >= NTDDI_WINXPSP2)

{$ENDIF}{ WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) }


implementation

procedure MSC_SET_BREAK_LENGTH(var b: uint; l: UINT);
begin
    b := (b and $3) or ((l and $f) shl 4);
end;

end.
