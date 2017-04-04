unit Win32.BTHIOCtl;

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
{***************************************************************************

Copyright (c) 2000  Microsoft Corporation

Module Name:

    bthioctl.h

Abstract:

    defines the IOCTL codes for the kernel/user calls

Environment:

    Kernel & user mode

Revision History:

    4-4-00 : created by Husni Roukbi
    2-4-05 : split into public and private header files by SandySp

***************************************************************************}

{ Header Definition: 10.0.14393.0 }

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}

interface

uses
    Windows, Classes,
    Win32.BTHDef, Win32.BTHSDPDef;


{$IF DEFINED(WINAPI_PARTITION_DESKTOP)}

{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}

// IOCTL defines.

const
    BTH_IOCTL_BASE = 0;

    // From WiniOctl.h
    FILE_DEVICE_BLUETOOTH = $00000041;
    METHOD_BUFFERED = 0;
    METHOD_IN_DIRECT = 1;
    METHOD_OUT_DIRECT = 2;
    METHOD_NEITHER = 3;

    FILE_ANY_ACCESS = 0;
    FILE_SPECIAL_ACCESS = (FILE_ANY_ACCESS);
    FILE_READ_ACCESS = ($0001);   // file & pipe
    FILE_WRITE_ACCESS = ($0002);   // file & pipe


    // kernel-level (internal) IOCTLs
    IOCTL_INTERNAL_BTH_SUBMIT_BRB =
        ((FILE_DEVICE_BLUETOOTH shl 16) or ((BTH_IOCTL_BASE + $00) shl 14) or ((METHOD_NEITHER) shl 2) or (FILE_ANY_ACCESS));
    // Input:  none
    // Output:  BTH_ENUMERATOR_INFO

    IOCTL_INTERNAL_BTHENUM_GET_ENUMINFO =
        ((FILE_DEVICE_BLUETOOTH shl 16) or ((BTH_IOCTL_BASE + $01) shl 14) or ((METHOD_NEITHER) shl 2) or (FILE_ANY_ACCESS));
    // Input:  none
    // Output:  BTH_DEVICE_INFO
    IOCTL_INTERNAL_BTHENUM_GET_DEVINFO =
        ((FILE_DEVICE_BLUETOOTH shl 16) or ((BTH_IOCTL_BASE + $02) shl 14) or ((METHOD_NEITHER) shl 2) or (FILE_ANY_ACCESS));

    // IOCTLs

    // Input:  none
    // Output:  BTH_LOCAL_RADIO_INFO
    IOCTL_BTH_GET_LOCAL_INFO =
        ((FILE_DEVICE_BLUETOOTH shl 16) or ((BTH_IOCTL_BASE + $00) shl 14) or ((METHOD_BUFFERED) shl 2) or (FILE_ANY_ACCESS));

    // Input:  BTH_ADDR
    // Output:  BTH_RADIO_INFO
    IOCTL_BTH_GET_RADIO_INFO =
        ((FILE_DEVICE_BLUETOOTH shl 16) or ((BTH_IOCTL_BASE + $01) shl 14) or ((METHOD_BUFFERED) shl 2) or (FILE_ANY_ACCESS));


    // use this ioctl to get a list of cached discovered devices in the port driver.

    // Input: None
    // Output: BTH_DEVICE_INFO_LIST
    IOCTL_BTH_GET_DEVICE_INFO =
        ((FILE_DEVICE_BLUETOOTH shl 16) or ((BTH_IOCTL_BASE + $02) shl 14) or ((METHOD_BUFFERED) shl 2) or (FILE_ANY_ACCESS));


    // Input:  BTH_ADDR
    // Output:  none
    IOCTL_BTH_DISCONNECT_DEVICE =
        ((FILE_DEVICE_BLUETOOTH shl 16) or ((BTH_IOCTL_BASE + $03) shl 14) or ((METHOD_BUFFERED) shl 2) or (FILE_ANY_ACCESS));

{$IF  ((NTDDI_VERSION > NTDDI_VISTASP1) or ((NTDDI_VERSION = NTDDI_VISTASP1) AND defined(VISTA_KB942567)))}
    // Input:   BTH_VENDOR_SPECIFIC_COMMAND
    // Output:  PVOID
    IOCTL_BTH_HCI_VENDOR_COMMAND =
        ((FILE_DEVICE_BLUETOOTH shl 16) or ((BTH_IOCTL_BASE + $14) shl 14) or ((METHOD_BUFFERED) shl 2) or (FILE_ANY_ACCESS));

{$ENDIF}// >= SP1+KB942567
    // Input:  BTH_SDP_CONNECT
    // Output:  BTH_SDP_CONNECT
    IOCTL_BTH_SDP_CONNECT =
        ((FILE_DEVICE_BLUETOOTH shl 16) or ((BTH_IOCTL_BASE + $80) shl 14) or ((METHOD_BUFFERED) shl 2) or (FILE_ANY_ACCESS));

    // Input:  HANDLE_SDP
    // Output:  none
    IOCTL_BTH_SDP_DISCONNECT =
        ((FILE_DEVICE_BLUETOOTH shl 16) or ((BTH_IOCTL_BASE + $81) shl 14) or ((METHOD_BUFFERED) shl 2) or (FILE_ANY_ACCESS));

    // Input:  BTH_SDP_SERVICE_SEARCH_REQUEST
    // Output:  ULONG * number of handles wanted
    IOCTL_BTH_SDP_SERVICE_SEARCH =
        ((FILE_DEVICE_BLUETOOTH shl 16) or ((BTH_IOCTL_BASE + $82) shl 14) or ((METHOD_BUFFERED) shl 2) or (FILE_ANY_ACCESS));

    // Input:  BTH_SDP_ATTRIBUTE_SEARCH_REQUEST
    // Output:  BTH_SDP_STREAM_RESPONSE or bigger
    IOCTL_BTH_SDP_ATTRIBUTE_SEARCH =
        ((FILE_DEVICE_BLUETOOTH shl 16) or ((BTH_IOCTL_BASE + $83) shl 14) or ((METHOD_BUFFERED) shl 2) or (FILE_ANY_ACCESS));

    // Input:  BTH_SDP_SERVICE_ATTRIBUTE_SEARCH_REQUEST
    // Output:  BTH_SDP_STREAM_RESPONSE or bigger
    IOCTL_BTH_SDP_SERVICE_ATTRIBUTE_SEARCH =
        ((FILE_DEVICE_BLUETOOTH shl 16) or ((BTH_IOCTL_BASE + $84) shl 14) or ((METHOD_BUFFERED) shl 2) or (FILE_ANY_ACCESS));

    // Input:  raw SDP stream (at least 2 bytes)
    // Ouptut: HANDLE_SDP
    IOCTL_BTH_SDP_SUBMIT_RECORD =
        ((FILE_DEVICE_BLUETOOTH shl 16) or ((BTH_IOCTL_BASE + $85) shl 14) or ((METHOD_BUFFERED) shl 2) or (FILE_ANY_ACCESS));

    // Input:  HANDLE_SDP
    // Output:  none
    IOCTL_BTH_SDP_REMOVE_RECORD =
        ((FILE_DEVICE_BLUETOOTH shl 16) or ((BTH_IOCTL_BASE + $86) shl 14) or ((METHOD_BUFFERED) shl 2) or (FILE_ANY_ACCESS));

    // Input:  BTH_SDP_RECORD + raw SDP record
    // Output:  HANDLE_SDP

    IOCTL_BTH_SDP_SUBMIT_RECORD_WITH_INFO =
        ((FILE_DEVICE_BLUETOOTH shl 16) or ((BTH_IOCTL_BASE + $87) shl 14) or ((METHOD_BUFFERED) shl 2) or (FILE_ANY_ACCESS));

{$IF  (NTDDI_VERSION >= NTDDI_WIN8)}
    // Input:  NONE
    // Output:  BTH_HOST_FEATURE_MASK

    IOCTL_BTH_GET_HOST_SUPPORTED_FEATURES =
        ((FILE_DEVICE_BLUETOOTH shl 16) or ((BTH_IOCTL_BASE + $88) shl 14) or ((METHOD_BUFFERED) shl 2) or (FILE_ANY_ACCESS));
{$ENDIF}// >= NTDDI_WIN8


//include <PSHPACK1.H>
{$A1}
type
    TBTH_DEVICE_INFO_LIST = record
        // [IN/OUT] minimum of 1 device required
        numOfDevices: ULONG;
        // Open ended array of devices;
        deviceList: PBTH_DEVICE_INFO;
    end;
    PBTH_DEVICE_INFO_LIST = ^TBTH_DEVICE_INFO_LIST;

    TBTH_RADIO_INFO = record
        // Supported LMP features of the radio.  Use LMP_XXX() to extract
        // the desired bits.
        lmpSupportedFeatures: ULONGLONG;
        // Manufacturer ID (possibly BTH_MFG_XXX)
        mfg: USHORT;
        // LMP subversion
        lmpSubversion: USHORT;
        // LMP version
        lmpVersion: UCHAR;
    end;
    PBTH_RADIO_INFO = ^TBTH_RADIO_INFO;

    TBTH_LOCAL_RADIO_INFO = record
        // Local BTH_ADDR, class of defice, and radio name
        localInfo: TBTH_DEVICE_INFO;
        // Combo of LOCAL_RADIO_XXX values
        flags: ULONG;
        // HCI revision, see core spec
        hciRevision: USHORT;
        // HCI version, see core spec
        hciVersion: UCHAR;
        // More information about the local radio (LMP, MFG)
        radioInfo: TBTH_RADIO_INFO;
    end;
    PBTH_LOCAL_RADIO_INFO = ^TBTH_LOCAL_RADIO_INFO;

const
    SDP_CONNECT_CACHE = $00000001;
    SDP_CONNECT_ALLOW_PIN = $00000002;


    SDP_REQUEST_TO_DEFAULT = 0;
    SDP_REQUEST_TO_MIN = 10;
    SDP_REQUEST_TO_MAX = 45;

    SERVICE_OPTION_DO_NOT_PUBLISH = $00000002;
    SERVICE_OPTION_NO_PUBLIC_BROWSE = $00000004;
    SERVICE_OPTION_DO_NOT_PUBLISH_EIR = $00000008;

    SERVICE_SECURITY_USE_DEFAULTS = $00000000;
    SERVICE_SECURITY_NONE = $00000001;
    SERVICE_SECURITY_AUTHORIZE = $00000002;
    SERVICE_SECURITY_AUTHENTICATE = $00000004;
    SERVICE_SECURITY_ENCRYPT_REQUIRED = $00000010;
    SERVICE_SECURITY_ENCRYPT_OPTIONAL = $00000020;
    SERVICE_SECURITY_DISABLED = $10000000;
    SERVICE_SECURITY_NO_ASK = $20000000;


    // Do not attempt to validate that the stream can be parsed

    SDP_SEARCH_NO_PARSE_CHECK = $00000001;

    // Do not check the format of the results.  This includes suppression of both
    // the check for a record patten (SEQ of UINT16 + value) and the validation
    // of each universal attribute's accordance to the spec.

    SDP_SEARCH_NO_FORMAT_CHECK = $00000002;

type
    THANDLE_SDP = ULONGLONG;
    PHANDLE_SDP = ^THANDLE_SDP;

    THANDLE_SDP_TYPE = THANDLE_SDP;
// ToDo     HANDLE_SDP_FIELD_NAME = hConnection;
const
    HANDLE_SDP_NULL = THANDLE_SDP($0);

const
    HANDLE_SDP_LOCAL = THANDLE_SDP(-2);

type
    TBTH_SDP_CONNECT = record
        // Address of the remote SDP server.  Cannot be the local radio.
        bthAddress: TBTH_ADDR;
        // Combination of SDP_CONNECT_XXX flags
        fSdpConnect: ULONG;
        // When the connect request returns, this will specify the handle to the
        // SDP connection to the remote server
        HANDLE_SDP_FIELD_NAME: THANDLE_SDP_TYPE;
        // Timeout, in seconds, for the requests on ths SDP channel.  If the request
        // times out, the SDP connection represented by the HANDLE_SDP must be
        // closed.  The values for this field are bound by SDP_REQUEST_TO_MIN and
        // SDP_REQUEST_MAX.  If SDP_REQUEST_TO_DEFAULT is specified, the timeout is
        // 30 seconds.
        requestTimeout: UCHAR;
    end;
    PBTH_SDP_CONNECT = ^TBTH_SDP_CONNECT;

    TBTH_SDP_DISCONNECT = record
        // hConnection returned by BTH_SDP_CONNECT
        HANDLE_SDP_FIELD_NAME: THANDLE_SDP_TYPE;
    end;
    PBTH_SDP_DISCONNECT = ^TBTH_SDP_DISCONNECT;


    TBTH_SDP_RECORD = record
        // Combination of SERVICE_SECURITY_XXX flags
        fSecurity: ULONG;
        // Combination of SERVICE_OPTION_XXX flags
        fOptions: ULONG;
        // combo of COD_SERVICE_XXX flags
        fCodService: ULONG;
        // The length of the record array, in bytes.
        recordLength: ULONG;
        // The SDP record in its raw format
        RawRecord: PUCHAR;
    end;
    PBTH_SDP_RECORD = ^TBTH_SDP_RECORD;

    TBTH_SDP_SERVICE_SEARCH_REQUEST = record
        // Handle returned by the connect request or HANDLE_SDP_LOCAL
        HANDLE_SDP_FIELD_NAME: THANDLE_SDP_TYPE;
        // Array of UUIDs.  Each entry can be either a 2 byte, 4 byte or 16 byte
        // UUID. SDP spec mandates that a request can have a maximum of 12 UUIDs.
        uuids: array [0..MAX_UUIDS_IN_QUERY - 1] of TSdpQueryUuid;
    end;
    PBTH_SDP_SERVICE_SEARCH_REQUEST = ^TBTH_SDP_SERVICE_SEARCH_REQUEST;

    TBTH_SDP_ATTRIBUTE_SEARCH_REQUEST = record
        // Handle returned by the connect request or HANDLE_SDP_LOCAL
        HANDLE_SDP_FIELD_NAME: THANDLE_SDP_TYPE;
        // Combo of SDP_SEARCH_Xxx flags
        searchFlags: ULONG;
        // Record handle returned by the remote SDP server, most likely from a
        // previous BTH_SDP_SERVICE_SEARCH_RESPONSE.
        recordHandle: ULONG;
        // Array of attributes to query for.  Each SdpAttributeRange entry can
        // specify either a single attribute or a range.  To specify a single
        // attribute, minAttribute should be equal to maxAttribute.   The array must
        // be in sorted order, starting with the smallest attribute.  Furthermore,
        // if a range is specified, the minAttribute must be <= maxAttribute.
        range: PSdpAttributeRange;
    end;
    PBTH_SDP_ATTRIBUTE_SEARCH_REQUEST = ^TBTH_SDP_ATTRIBUTE_SEARCH_REQUEST;

    TBTH_SDP_SERVICE_ATTRIBUTE_SEARCH_REQUEST = record
        // Handle returned by the connect request or HANDLE_SDP_LOCAL
        HANDLE_SDP_FIELD_NAME: THANDLE_SDP_TYPE;
        // Combo of SDP_SEARCH_Xxx flags
        searchFlags: ULONG;
        // See comments in BTH_SDP_SERVICE_SEARCH_REQUEST
        uuids: array [0..MAX_UUIDS_IN_QUERY - 1] of TSdpQueryUuid;
        // See comments in BTH_SDP_ATTRIBUTE_SEARCH_REQUEST
        range: PSdpAttributeRange;
    end;
    PBTH_SDP_SERVICE_ATTRIBUTE_SEARCH_REQUEST = ^TBTH_SDP_SERVICE_ATTRIBUTE_SEARCH_REQUEST;

    TBTH_SDP_STREAM_RESPONSE = record
        // The required buffer size (not including the first 2 ULONG_PTRs of this
        // data structure) needed to contain the response.
        // If the buffer passed was large enough to contain the entire response,
        // requiredSize will be equal to responseSize.  Otherwise, the caller should
        // resubmit the request with a buffer size equal to
        // sizeof(BTH_SDP_STREAM_RESPONSE) + requiredSize - 1.  (The -1 is because
        // the size of this data structure already includes one byte of the
        // response.)
        // A response cannot exceed 4GB in size.
        requiredSize: ULONG;
        // The number of bytes copied into the response array of this data
        // structure.  If there is not enough room for the entire response, the
        // response will be partially copied into the response array.
        responseSize: ULONG;
        // The raw SDP response from the search.
        response: PUCHAR;
    end;
    PBTH_SDP_STREAM_RESPONSE = ^TBTH_SDP_STREAM_RESPONSE;

{$IF  ((NTDDI_VERSION > NTDDI_VISTASP1) or  ((NTDDI_VERSION = NTDDI_VISTASP1) AND defined(VISTA_KB942567)))}
    // Vendor specific HCI command header
    TBTH_COMMAND_HEADER = record
        // Opcode for the command
        OpCode: USHORT;
        // Payload of the command excluding the header.
        // TotalParameterLength = TotalCommandLength - sizeof(BTH_COMMAND_HEADER)
        TotalParameterLength: UCHAR;
    end;
    PBTH_COMMAND_HEADER = ^TBTH_COMMAND_HEADER;

    // Vendor Specific Command structure
    TBTH_VENDOR_SPECIFIC_COMMAND = record
        // Manufacturer ID
        ManufacturerId: ULONG;
        // LMP version. Command is send to radio only if the radios
        // LMP version is greater than this value.
        LmpVersion: UCHAR;
        // Should all the patterns match or just one. If MatchAnySinglePattern == TRUE
        // then if a single pattern matches the command, we decide that we have a match.
        MatchAnySinglePattern: boolean;
        // HCI Command Header
        HciHeader: TBTH_COMMAND_HEADER;
        // Data for the above command including patterns
        Data: PUCHAR;
    end;
    PBTH_VENDOR_SPECIFIC_COMMAND = ^TBTH_VENDOR_SPECIFIC_COMMAND;


    // Structure of patterns
    TBTH_VENDOR_PATTERN = record
        // Pattern Offset in the event structure excluding EVENT header
        Offset: UCHAR;
        // Size of the Pattern
        Size: UCHAR;
        // Pattern
        Pattern: PUCHAR;
    end;
    PBTH_VENDOR_PATTERN = ^TBTH_VENDOR_PATTERN;

    //The buffer associated with GUID_BLUETOOTH_HCI_VENDOR_EVENT
    TBTH_VENDOR_EVENT_INFO = record
        //Local radio address with which the event is associated.
        BthAddress: TBTH_ADDR;
        //Size of the event buffer including Event header
        EventSize: ULONG;
        //Information associated with the event
        EventInfo: PUCHAR;
    end;
    PBTH_VENDOR_EVENT_INFO = ^TBTH_VENDOR_EVENT_INFO;

{$ENDIF}// >= SP1+KB942567

{$IF  (NTDDI_VERSION >= NTDDI_WIN8)}


// Host supported features

const
    BTH_HOST_FEATURE_ENHANCED_RETRANSMISSION_MODE = $0000000000000001;
    BTH_HOST_FEATURE_STREAMING_MODE = $0000000000000002;
    BTH_HOST_FEATURE_LOW_ENERGY = $0000000000000004;
    BTH_HOST_FEATURE_SCO_HCI = $0000000000000008;
    BTH_HOST_FEATURE_SCO_HCIBYPASS = $0000000000000010;

type
    TBTH_HOST_FEATURE_MASK = record
        // Mask of supported features.
        Mask: ULONGLONG;
        // Reserved for future use.
        Reserved1: ULONGLONG;
        Reserved2: ULONGLONG;
    end;
    PBTH_HOST_FEATURE_MASK = ^TBTH_HOST_FEATURE_MASK;

{$ENDIF}//NTDDI_WIN8

//include <POPPACK.H>
{$A4}

{$ENDIF}// (NTDDI_VERSION >= NTDDI_VISTA)


{$ENDIF}{ WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) }

implementation

end.
