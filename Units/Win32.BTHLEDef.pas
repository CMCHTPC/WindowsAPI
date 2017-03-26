unit Win32.BTHLEDef;

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

Copyright (c) 2010      Microsoft Corporation

Module Name:

   BthLEDef.h

Abstract:

   Public Bluetooth Low Energy Definitions

Environment:

    User mode
  --}

{ Header Definition: 10.0.14393.0 }

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}

interface

uses
    Windows, Classes,
    Win32.BTHSDPDef;

const
    MAX_USHORT = 65535;

{$IF  DEFINED(WINAPI_PARTITION_DESKTOP)}

{$IF  NTDDI_VERSION >= NTDDI_WIN8}

const
    // Bluetooth LE device interface GUID
    GUID_BLUETOOTHLE_DEVICE_INTERFACE: TGUID = '{781aee18-7733-4ce4-add0-91f41c67b592}';
    // Bluetooth LE Service device interface GUID
    GUID_BLUETOOTH_GATT_SERVICE_DEVICE_INTERFACE: TGUID = '{6e3bb679-4372-40c8-9eaa-4509df260cd8}';
    BTH_LE_ATT_BLUETOOTH_BASE_GUID: TGUID = '{00000000-0000-1000-8000-00805F9B34FB}';

    ////////////////////////////////////////////////////////////////////////////////
    // GATT Constants
    ////////////////////////////////////////////////////////////////////////////////
    // Services UUIDs (Assigned numbers)
    BTH_LE_SERVICE_GAP = ($1800);
    BTH_LE_SERVICE_GATT = ($1801);

    // GATT attribute types (Assigned numbers)
    BTH_LE_GATT_ATTRIBUTE_TYPE_PRIMARY_SERVICE = ($2800);
    BTH_LE_GATT_ATTRIBUTE_TYPE_SECONDARY_SERVICE = ($2801);
    BTH_LE_GATT_ATTRIBUTE_TYPE_INCLUDE = ($2802);
    BTH_LE_GATT_ATTRIBUTE_TYPE_CHARACTERISTIC = ($2803);

    // GATT Characteristic Descriptors (Assigned numbers)
    BTH_LE_GATT_CHARACTERISTIC_DESCRIPTOR_EXTENDED_PROPERTIES = ($2900);
    BTH_LE_GATT_CHARACTERISTIC_DESCRIPTOR_USER_DESCRIPTION = ($2901);
    BTH_LE_GATT_CHARACTERISTIC_DESCRIPTOR_CLIENT_CONFIGURATION = ($2902);
    BTH_LE_GATT_CHARACTERISTIC_DESCRIPTOR_SERVER_CONFIGURATION = ($2903);
    BTH_LE_GATT_CHARACTERISTIC_DESCRIPTOR_FORMAT = ($2904);
    BTH_LE_GATT_CHARACTERISTIC_DESCRIPTOR_AGGREGATE_FORMAT = ($2905);

    // GATT Characteristic Types (Assigned numbers)
    BTH_LE_GATT_CHARACTERISTIC_TYPE_DEVICE_NAME = ($2A00);
    BTH_LE_GATT_CHARACTERISTIC_TYPE_APPEARANCE = ($2A01);
    BTH_LE_GATT_CHARACTERISTIC_TYPE_PERIPHERAL_PRIVACY_FLAG = ($2A02);
    BTH_LE_GATT_CHARACTERISTIC_TYPE_RECONNECTION_ADDRESS = ($2A03);
    BTH_LE_GATT_CHARACTERISTIC_TYPE_PERIPHERAL_PREFERED_CONNECTION_PARAMETER = ($2A04);
    BTH_LE_GATT_CHARACTERISTIC_TYPE_SERVICE_CHANGED = ($2A05);

    BTH_LE_GAP_APPEARANCE_CATEGORY_OFFSET = $6;
    BTH_LE_GAP_APPEARANCE_CATEGORY_MASK = $3ff;

    BTH_LE_GAP_APPEARANCE_SUB_CATEGORY_MASK = $3f;

function BTH_LE_GAP_APPEARANCE_GET_CATEGORY(a: ULONG): ULONG;
procedure BTH_LE_GAP_APPEARANCE_SET_CATEGORY(var a, c: ULONG);
function BTH_LE_GAP_APPEARANCE_GET_SUB_CATEGORY(a: UCHAR): UCHAR;
procedure BTH_LE_GAP_APPEARANCE_SET_SUB_CATEGORY(var a, s: UCHAR);


const
    BTH_LE_GAP_APPEARANCE_CATEGORY_UNCATEGORIZED = $0000;
    BTH_LE_GAP_APPEARANCE_CATEGORY_PHONE = $0001;
    BTH_LE_GAP_APPEARANCE_CATEGORY_COMPUTER = $0002;
    BTH_LE_GAP_APPEARANCE_CATEGORY_WATCH = $0003;
    BTH_LE_GAP_APPEARANCE_CATEGORY_CLOCK = $0004;
    BTH_LE_GAP_APPEARANCE_CATEGORY_DISPLAY = $0005;
    BTH_LE_GAP_APPEARANCE_CATEGORY_REMOTE_CONTROL = $0006;
    BTH_LE_GAP_APPEARANCE_CATEGORY_EYE_GLASSES = $0007;
    BTH_LE_GAP_APPEARANCE_CATEGORY_TAG = $0008;
    BTH_LE_GAP_APPEARANCE_CATEGORY_KEYRING = $0009;
    BTH_LE_GAP_APPEARANCE_CATEGORY_MEDIA_PLAYER = $000a;
    BTH_LE_GAP_APPEARANCE_CATEGORY_BARCODE_SCANNER = $000b;
    BTH_LE_GAP_APPEARANCE_CATEGORY_THERMOMETER = $000c;
    BTH_LE_GAP_APPEARANCE_CATEGORY_HEART_RATE = $000d;
    BTH_LE_GAP_APPEARANCE_CATEGORY_BLOOD_PRESSURE = $000e;
    BTH_LE_GAP_APPEARANCE_CATEGORY_HID = $000f;
    BTH_LE_GAP_APPEARANCE_CATEGORY_GLUCOSE_METER = $0010;
    BTH_LE_GAP_APPEARANCE_CATEGORY_RUNNING_WALKING_SENSOR = $0011;
    BTH_LE_GAP_APPEARANCE_CATEGORY_CYCLING = $0012;

    BTH_LE_GAP_APPEARANCE_CATEGORY_PLUSE_OXIMETER = $0031;
    BTH_LE_GAP_APPEARANCE_CATEGORY_WEIGHT_SCALE = $0032;
    BTH_LE_GAP_APPEARANCE_CATEGORY_OUTDOOR_SPORTS_ACTIVITY = $0051;

    BTH_LE_GAP_APPEARANCE_SUBCATEGORY_GENERIC = $00;

    BTH_LE_GAP_APPEARANCE_WATCH_SUBCATEGORY_SPORTS_WATCH = $01;

    BTH_LE_GAP_APPEARANCE_THERMOMETER_SUBCATEGORY_EAR = $01;

    BTH_LE_GAP_APPEARANCE_HEART_RATE_SUBCATEGORY_HEART_RATE_BELT = $01;

    BTH_LE_GAP_APPEARANCE_BLOOD_PRESSURE_SUBCATEGORY_ARM = $01;
    BTH_LE_GAP_APPEARANCE_BLOOD_PRESSURE_SUBCATEGORY_WRIST = $02;

    BTH_LE_GAP_APPEARANCE_HID_SUBCATEGORY_KEYBOARD = $01;
    BTH_LE_GAP_APPEARANCE_HID_SUBCATEGORY_MOUSE = $02;
    BTH_LE_GAP_APPEARANCE_HID_SUBCATEGORY_JOYSTICK = $03;
    BTH_LE_GAP_APPEARANCE_HID_SUBCATEGORY_GAMEPAD = $04;
    BTH_LE_GAP_APPEARANCE_HID_SUBCATEGORY_DIGITIZER_TABLET = $05;
    BTH_LE_GAP_APPEARANCE_HID_SUBCATEGORY_CARD_READER = $06;
    BTH_LE_GAP_APPEARANCE_HID_SUBCATEGORY_DIGITAL_PEN = $07;
    BTH_LE_GAP_APPEARANCE_HID_SUBCATEGORY_BARCODE_SCANNER = $08;

    BTH_LE_GAP_APPEARANCE_RUNNING_WALKING_SENSOR_SUBCATEGORY_IN_SHOE = $01;
    BTH_LE_GAP_APPEARANCE_RUNNING_WALKING_SENSOR_SUBCATEGORY_ON_SHOE = $02;
    BTH_LE_GAP_APPEARANCE_RUNNING_WALKING_SENSOR_SUBCATEGORY_ON_HIP = $03;

    BTH_LE_GAP_APPEARANCE_CYCLING_SUBCATEGORY_CYCLING_COMPUTER = $01;
    BTH_LE_GAP_APPEARANCE_CYCLING_SUBCATEGORY_SPEED_SENSOR = $02;
    BTH_LE_GAP_APPEARANCE_CYCLING_SUBCATEGORY_CADENCE_SENSOR = $03;
    BTH_LE_GAP_APPEARANCE_CYCLING_SUBCATEGORY_POWER_SENSOR = $04;
    BTH_LE_GAP_APPEARANCE_CYCLING_SUBCATEGORY_SPEED_AND_CADENCE_SENSOR = $05;

    BTH_LE_GAP_APPEARANCE_PULSE_OXIMETER_SUBCATEGORY_FINGERTIP = $01;
    BTH_LE_GAP_APPEARANCE_PULSE_OXIMETER_SUBCATEGORY_WRIST_WORN = $02;

    BTH_LE_GAP_APPEARANCE_OUTDOOR_SPORTS_ACTIVITY_SUBCATEGORY_LOCATION_DISPLAY_DEVICE = $01;
    BTH_LE_GAP_APPEARANCE_OUTDOOR_SPORTS_ACTIVITY_SUBCATEGORY_LOCATION_NAVIGATION_DISPLAY_DEVICE = $02;
    BTH_LE_GAP_APPEARANCE_OUTDOOR_SPORTS_ACTIVITY_SUBCATEGORY_LOCATION_POD = $03;
    BTH_LE_GAP_APPEARANCE_OUTDOOR_SPORTS_ACTIVITY_SUBCATEGORY_LOCATION_NAVIGATION_POD = $04;


    // GATT Included Services Default Maximum Nested Depth
    BTH_LE_GATT_DEFAULT_MAX_INCLUDED_SERVICES_DEPTH = (3);

    ////////////////////////////////////////////////////////////////////////////////
    // ATT Constants
    ////////////////////////////////////////////////////////////////////////////////

    // Transation timeout
    BTH_LE_ATT_TRANSACTION_TIMEOUT = 30; // seconds

    // Maximum size of any attribute value
    BTH_LE_ATT_MAX_VALUE_SIZE = 512;

    // CID
    BTH_LE_ATT_CID = ($0004);

    // MTU
    BTHLEENUM_ATT_MTU_MIN = (23);
    BTHLEENUM_ATT_MTU_MAX = (MAX_USHORT);
    BTHLEENUM_ATT_MTU_DEFAULT = (BTHLEENUM_ATT_MTU_MIN);
    BTHLEENUM_ATT_MTU_INITIAL_NEGOTIATION = (525);

    ////////////////////////////////////////////////////////////////////////////////
    // ATT-specific Error Codes
    ////////////////////////////////////////////////////////////////////////////////

    BTH_LE_ERROR_INVALID_HANDLE = ($01);
    BTH_LE_ERROR_READ_NOT_PERMITTED = ($02);
    BTH_LE_ERROR_WRITE_NOT_PERMITTED = ($03);
    BTH_LE_ERROR_INVALID_PDU = ($04);
    BTH_LE_ERROR_INSUFFICIENT_AUTHENTICATION = ($05);
    BTH_LE_ERROR_REQUEST_NOT_SUPPORTED = ($06);
    BTH_LE_ERROR_INVALID_OFFSET = ($07);
    BTH_LE_ERROR_INSUFFICIENT_AUTHORIZATION = ($08);
    BTH_LE_ERROR_PREPARE_QUEUE_FULL = ($09);
    BTH_LE_ERROR_ATTRIBUTE_NOT_FOUND = ($0A);
    BTH_LE_ERROR_ATTRIBUTE_NOT_LONG = ($0B);
    BTH_LE_ERROR_INSUFFICIENT_ENCRYPTION_KEY_SIZE = ($0C);
    BTH_LE_ERROR_INVALID_ATTRIBUTE_VALUE_LENGTH = ($0D);
    BTH_LE_ERROR_UNLIKELY = ($0E);
    BTH_LE_ERROR_INSUFFICIENT_ENCRYPTION = ($0F);
    BTH_LE_ERROR_UNSUPPORTED_GROUP_TYPE = ($10);
    BTH_LE_ERROR_INSUFFICIENT_RESOURCES = ($11);
    BTH_LE_ERROR_UNKNOWN = ($1000);

    ////////////////////////////////////////////////////////////////////////////////
    // GATT Security and Other Flag-related Facilities
    ////////////////////////////////////////////////////////////////////////////////

    BLUETOOTH_GATT_FLAG_NONE = $00000000;
    BLUETOOTH_GATT_FLAG_CONNECTION_ENCRYPTED = $00000001;
    BLUETOOTH_GATT_FLAG_CONNECTION_AUTHENTICATED = $00000002;
    BLUETOOTH_GATT_FLAG_FORCE_READ_FROM_DEVICE = $00000004;
    BLUETOOTH_GATT_FLAG_FORCE_READ_FROM_CACHE = $00000008;
    BLUETOOTH_GATT_FLAG_SIGNED_WRITE = $00000010;
    BLUETOOTH_GATT_FLAG_WRITE_WITHOUT_RESPONSE = $00000020;
    BLUETOOTH_GATT_FLAG_RETURN_ALL = $00000040;

    BLUETOOTH_GATT_FLAG_VALID_MASK =
        (BLUETOOTH_GATT_FLAG_NONE or BLUETOOTH_GATT_FLAG_CONNECTION_ENCRYPTED or BLUETOOTH_GATT_FLAG_CONNECTION_AUTHENTICATED or
        BLUETOOTH_GATT_FLAG_FORCE_READ_FROM_DEVICE or BLUETOOTH_GATT_FLAG_FORCE_READ_FROM_CACHE or BLUETOOTH_GATT_FLAG_SIGNED_WRITE or
        BLUETOOTH_GATT_FLAG_WRITE_WITHOUT_RESPONSE or BLUETOOTH_GATT_FLAG_RETURN_ALL);

function IS_BLUETOOTH_GATT_FLAG_VALID(f: USHORT): boolean;



////////////////////////////////////////////////////////////////////////////////
// GATT Structures
////////////////////////////////////////////////////////////////////////////////

type
    TBLUETOOTH_GATT_EVENT_HANDLE = HANDLE;

    TBTH_LE_UUID = record
        IsShortUuid: boolean;
        case integer of
            0: (ShortUuid: USHORT);
            1: (LongUuid: TGUID);
    end;
    PBTH_LE_UUID = ^TBTH_LE_UUID;

    TBTH_LE_GATT_SERVICE = record
        ServiceUuid: TBTH_LE_UUID;
        AttributeHandle: USHORT;
    end;
    PBTH_LE_GATT_SERVICE = ^TBTH_LE_GATT_SERVICE;

    TBTH_LE_GATT_DESCRIPTOR_TYPE = (
        CharacteristicExtendedProperties,
        CharacteristicUserDescription,
        ClientCharacteristicConfiguration,
        ServerCharacteristicConfiguration,
        CharacteristicFormat,
        CharacteristicAggregateFormat,
        CustomDescriptor);
    PBTH_LE_GATT_DESCRIPTOR_TYPE = ^TBTH_LE_GATT_DESCRIPTOR_TYPE;

    TBTH_LE_GATT_CHARACTERISTIC = record
        ServiceHandle: USHORT;
        CharacteristicUuid: TBTH_LE_UUID;
        AttributeHandle: USHORT;
        CharacteristicValueHandle: USHORT;
        IsBroadcastable: boolean;
        IsReadable: boolean;
        IsWritable: boolean;
        IsWritableWithoutResponse: boolean;
        IsSignedWritable: boolean;
        IsNotifiable: boolean;
        IsIndicatable: boolean;
        HasExtendedProperties: boolean;
    end;
    PBTH_LE_GATT_CHARACTERISTIC = ^TBTH_LE_GATT_CHARACTERISTIC;

    TBTH_LE_GATT_CHARACTERISTIC_VALUE = record
        DataSize: ULONG;
        Data: PUCHAR;
    end;
    PBTH_LE_GATT_CHARACTERISTIC_VALUE = ^TBTH_LE_GATT_CHARACTERISTIC_VALUE;

    TBTH_LE_GATT_DESCRIPTOR = record
        ServiceHandle: USHORT;
        CharacteristicHandle: USHORT;
        DescriptorType: TBTH_LE_GATT_DESCRIPTOR_TYPE;
        DescriptorUuid: TBTH_LE_UUID;
        AttributeHandle: USHORT;
    end;
    PBTH_LE_GATT_DESCRIPTOR = ^TBTH_LE_GATT_DESCRIPTOR;

    TCharacteristicExtendedProperties = record
        IsReliableWriteEnabled: boolean;
        IsAuxiliariesWritable: boolean;
    end;

    TClientCharacteristicConfiguration = record
        IsSubscribeToNotification: boolean;
        IsSubscribeToIndication: boolean;
    end;

    TServerCharacteristicConfiguration = record
        IsBroadcast: boolean;
    end;

    TCharacteristicFormat = record
        Format: UCHAR;
        Exponent: UCHAR;
        AUnit: TBTH_LE_UUID;
        NameSpace: UCHAR;
        Description: TBTH_LE_UUID;
    end;


    TBTH_LE_GATT_DESCRIPTOR_VALUE = record
        DescriptorType: TBTH_LE_GATT_DESCRIPTOR_TYPE;
        DescriptorUuid: TBTH_LE_UUID;
        case integer of
            0: (CharacteristicFormat: TCharacteristicFormat;
                DataSize: ULONG;
                Data: PUCHAR;);
            1: (CharacteristicExtendedProperties: TCharacteristicExtendedProperties);
            2: (ClientCharacteristicConfiguration: TClientCharacteristicConfiguration);
            3: (ServerCharacteristicConfiguration: TServerCharacteristicConfiguration);
    end;

    PBTH_LE_GATT_DESCRIPTOR_VALUE = ^TBTH_LE_GATT_DESCRIPTOR_VALUE;

    TBTH_LE_GATT_EVENT_TYPE = (
        CharacteristicValueChangedEvent);
    PBTH_LE_GATT_EVENT_TYPE = ^TBTH_LE_GATT_EVENT_TYPE;

// Callback function signature for Bluetooth GATT events.

type
    PFNBLUETOOTH_GATT_EVENT_CALLBACK = procedure(EventType: TBTH_LE_GATT_EVENT_TYPE; EventOutParameter: pointer; Context: pointer); stdcall;

    // Structure associated with a CharacteristicValueChanged Event

    TBLUETOOTH_GATT_VALUE_CHANGED_EVENT_REGISTRATION = record
        NumCharacteristics: USHORT;
        Characteristics: PBTH_LE_GATT_CHARACTERISTIC;
    end;
    PBLUETOOTH_GATT_VALUE_CHANGED_EVENT_REGISTRATION = ^TBLUETOOTH_GATT_VALUE_CHANGED_EVENT_REGISTRATION;

    TBLUETOOTH_GATT_VALUE_CHANGED_EVENT = record
        ChangedAttributeHandle: USHORT;
        CharacteristicValueDataSize: size_t;
        CharacteristicValue: PBTH_LE_GATT_CHARACTERISTIC_VALUE;
    end;
    PBLUETOOTH_GATT_VALUE_CHANGED_EVENT = ^TBLUETOOTH_GATT_VALUE_CHANGED_EVENT;


    TBTH_LE_GATT_RELIABLE_WRITE_CONTEXT = ULONG64;
    PBTH_LE_GATT_RELIABLE_WRITE_CONTEXT = ^TBTH_LE_GATT_RELIABLE_WRITE_CONTEXT;


function IsBthLEUuidMatch(uuid1: TBTH_LE_UUID; uuid2: TBTH_LE_UUID): boolean;

{$ENDIF}//NTDDI_WIN8


{$ENDIF}{ WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) }

implementation

function BTH_LE_GAP_APPEARANCE_GET_CATEGORY(a: ULONG): ULONG;
begin
    Result := ((a shr BTH_LE_GAP_APPEARANCE_CATEGORY_OFFSET) and BTH_LE_GAP_APPEARANCE_CATEGORY_MASK);
end;

procedure BTH_LE_GAP_APPEARANCE_SET_CATEGORY(var a, c: ULONG);
begin
    a := ((a and not BTH_LE_GAP_APPEARANCE_CATEGORY_MASK) or (c shl BTH_LE_GAP_APPEARANCE_CATEGORY_OFFSET));
end;

function BTH_LE_GAP_APPEARANCE_GET_SUB_CATEGORY(a: UCHAR): UCHAR;
begin
    Result := (a and BTH_LE_GAP_APPEARANCE_SUB_CATEGORY_MASK);
end;

procedure BTH_LE_GAP_APPEARANCE_SET_SUB_CATEGORY(var a, s: UCHAR);
begin
    a := ((a and not BTH_LE_GAP_APPEARANCE_SUB_CATEGORY_MASK) or s);
end;

function IS_BLUETOOTH_GATT_FLAG_VALID(f: USHORT): boolean;
begin
    Result := (0 = (f and not BLUETOOTH_GATT_FLAG_VALID_MASK));
end;


function IsBthLEUuidMatch(uuid1: TBTH_LE_UUID; uuid2: TBTH_LE_UUID): boolean; inline;
{++
Routine Description:
    Determines if the two UUIDs match each other.  If both of the are
    short UUIDs, or if they are both long UUIDs, they will be compared
    directly.  Otherwise, the short UUID will be converted to a long UUID
    using the Bluetooth BASE UUID, and then compared against the long one.
Arguments:
    uuid1 - left comparand
    uuid2 - right comparand
Return Value:
    TRUE if the values are equal, FALSE otherwise
  --}
var
    tempLongUuid: TBTH_LE_UUID;
begin
    tempLongUuid.IsShortUuid := False;
    tempLongUuid.LongUuid := BTH_LE_ATT_BLUETOOTH_BASE_GUID;
    Result := False;

    if (uuid1.IsShortUuid and uuid2.IsShortUuid) then
    begin
        Result := (uuid1.ShortUuid = uuid2.ShortUuid);
    end
    else if (not uuid1.IsShortUuid and not uuid2.IsShortUuid) then
    begin
        Result := (0 = CompareByte(uuid1.LongUuid, uuid2.LongUuid, sizeof(TGUID)));
    end
    else if (uuid1.IsShortUuid) then
    begin
        tempLongUuid.LongUuid.Data1 := tempLongUuid.LongUuid.Data1 + uuid1.ShortUuid;
        Result := (0 = CompareByte(tempLongUuid, uuid2.LongUuid, sizeof(TGUID)));
    end
    else if (uuid2.IsShortUuid) then
    begin
        tempLongUuid.LongUuid.Data1 := tempLongUuid.LongUuid.Data1 + uuid2.ShortUuid;
        Result := (0 = CompareByte(uuid1.LongUuid, tempLongUuid.LongUuid, sizeof(TGUID)));
    end;
end;

end.
