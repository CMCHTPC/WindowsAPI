unit Win32.BlueToothAPIs;

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
//////////////////////////////////////////////////////////////////////////////
//  Copyright 2002 - 2004, Microsoft Corporation
//////////////////////////////////////////////////////////////////////////////

{ Header Definition: 10.0.14393.0 }

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}

interface

uses
    Windows, Classes,
    Win32.BTHDef, Win32.BTHSDPDef;



{$IF  DEFINED(WINAPI_PARTITION_DESKTOP)}

const
    BTHProps_DLL = 'Bthprops.cpl';


const
    BLUETOOTH_MAX_NAME_SIZE = 248;
    BLUETOOTH_MAX_PASSKEY_SIZE = 16;
    BLUETOOTH_MAX_PASSKEY_BUFFER_SIZE = (BLUETOOTH_MAX_PASSKEY_SIZE + 1);
    BLUETOOTH_MAX_SERVICE_NAME_SIZE = 256;
    BLUETOOTH_DEVICE_NAME_SIZE = 256;

type
    PWSTR = ^WCHAR;


{$IF  (NTDDI_VERSION >= NTDDI_WINXPSP2)}

// ***************************************************************************
//  Bluetooth Address
// ***************************************************************************

type
    BTH_ADDR = ULONGLONG;

    TBLUETOOTH_ADDRESS = record
        case integer of
            0: (ullLong: TBTH_ADDR);
            //  easier to compare again BLUETOOTH_NULL_ADDRESS
            1: (rgBytes: array [0..5] of byte);   //  easier to format when broken out

    end;
    PBLUETOOTH_ADDRESS_STRUCT = ^TBLUETOOTH_ADDRESS_STRUCT;

    TBLUETOOTH_ADDRESS_STRUCT = TBLUETOOTH_ADDRESS;

const
    BLUETOOTH_NULL_ADDRESS: ULONGLONG = $0;


type
    TBLUETOOTH_LOCAL_SERVICE_INFO = record
        Enabled: boolean;
        //  If TRUE, the enable the services
        btAddr: TBLUETOOTH_ADDRESS;
        //  If service is to be advertised for a particular remote device
        szName: array [0.. BLUETOOTH_MAX_SERVICE_NAME_SIZE - 1] of WCHAR;
        //  SDP Service Name to be advertised.
        szDeviceString: array [0.. BLUETOOTH_DEVICE_NAME_SIZE - 1] of
        WCHAR; //  Local device name (if any) like COM4 or LPT1

    end;
    PBLUETOOTH_LOCAL_SERVICE_INFO_STRUCT = ^TBLUETOOTH_LOCAL_SERVICE_INFO_STRUCT;

    TBLUETOOTH_LOCAL_SERVICE_INFO_STRUCT = TBLUETOOTH_LOCAL_SERVICE_INFO;

    PBLUETOOTH_LOCAL_SERVICE_INFO = ^TBLUETOOTH_LOCAL_SERVICE_INFO;


    // ***************************************************************************
    //  Radio Enumeration
    //  Description:
    //      This group of APIs enumerates the installed Bluetooth radios.
    //  Sample Usage:
    //      HANDLE hRadio;
    //      BLUETOOTH_FIND_RADIO_PARAMS btfrp = { sizeof(btfrp) };
    //      HBLUETOOTH_RADIO_FIND hFind = BluetoothFindFirstRadio( &btfrp, &hRadio );
    //      if ( NULL != hFind )
    //      {
    //          do
    //          {
    //              //
    //              //  TODO: Do something with the radio handle.
    //              //
    //              CloseHandle( hRadio );
    //          } while( BluetoothFindNextRadio( hFind, &hRadio ) );
    //          BluetoothFindRadioClose( hFind );
    //      }
    // ***************************************************************************

    TBLUETOOTH_FIND_RADIO_PARAMS = record
        dwSize: DWORD;             //  IN  sizeof this structure

    end;
    PBLUETOOTH_FIND_RADIO_PARAMS = ^TBLUETOOTH_FIND_RADIO_PARAMS;

    THBLUETOOTH_RADIO_FIND = HANDLE;


//  Description:
//      Begins the enumeration of local Bluetooth radios.
//  Parameters:
//      pbtfrp
//          A pointer to a BLUETOOTH_FIND_RADIO_PARAMS structure. The dwSize
//          member of this structure must match the sizeof the of the structure.
//      phRadio
//          A pointer where the first radio HANDLE enumerated will be returned.
//  Return Values:
//      NULL
//          Error opening radios or no devices found. Use GetLastError() for
//          more info.
//          ERROR_INVALID_PARAMETER
//              pbtfrp parameter is NULL.
//          ERROR_REVISION_MISMATCH
//              The pbtfrp structure is not the right length.
//          ERROR_OUTOFMEMORY
//              Out of memory.
//          other Win32 errors.
//      any other
//          Success. The return handle is valid and phRadio points to a valid handle.


function BluetoothFindFirstRadio(const pbtfrp: TBLUETOOTH_FIND_RADIO_PARAMS; out phRadio: THANDLE): THBLUETOOTH_RADIO_FIND; stdcall; external BTHProps_DLL;


//  Description:
//      Finds the next installed Bluetooth radio.
//  Parameters:
//      hFind
//          The handle returned by BluetoothFindFirstRadio().
//      phRadio
//          A pointer where the next radio HANDLE enumerated will be returned.
//  Return Values:
//      TRUE
//          Next device succesfully found. pHandleOut points to valid handle.
//      FALSE
//          No device found. pHandleOut points to an invalid handle. Call
//          GetLastError() for more details.
//          ERROR_INVALID_HANDLE
//              The handle is NULL.
//          ERROR_NO_MORE_ITEMS
//              No more radios found.
//          ERROR_OUTOFMEMORY
//              Out of memory.
//          other Win32 errors


function BluetoothFindNextRadio(hFind: THBLUETOOTH_RADIO_FIND; out phRadio: THANDLE): boolean; stdcall; external BTHProps_DLL;


//  Description:
//      Closes the enumeration handle.
//  Parameters
//      hFind
//          The handle returned by BluetoothFindFirstRadio().
//  Return Values:
//      TRUE
//          Handle succesfully closed.
//      FALSE
//          Failure. Check GetLastError() for details.
//          ERROR_INVALID_HANDLE
//              The handle is NULL.

function BluetoothFindRadioClose(hFind: THBLUETOOTH_RADIO_FIND): boolean;
    stdcall; external BTHProps_DLL;

// ***************************************************************************
//  Radio Information
// ***************************************************************************
type
    TBLUETOOTH_RADIO_INFO = record
        dwSize: DWORD;
        // Size, in bytes, of this entire data structure
        address: TBLUETOOTH_ADDRESS;                  // Address of the local radio
        szName: array [0.. BLUETOOTH_MAX_NAME_SIZE - 1] of WCHAR;
        // Name of the local radio
        ulClassofDevice: ULONG;
        // Class of device for the local radio
        lmpSubversion: USHORT;
        // lmpSubversion, manufacturer specifc.
        manufacturer: USHORT;
        // Manufacturer of the radio, BTH_MFG_Xxx value.  For the most up to date
        // list, goto the Bluetooth specification website and get the Bluetooth
        // assigned numbers document.
    end;

    PBLUETOOTH_RADIO_INFO = ^TBLUETOOTH_RADIO_INFO;


//  Description:
//      Retrieves the information about the radio represented by the handle.
//  Parameters:
//      hRadio
//          Handle to a local radio retrieved through BluetoothFindFirstRadio()
//          et al or SetupDiEnumerateDeviceInterfaces()
//      pRadioInfo
//          Radio information to be filled in. The dwSize member must match the
//          size of the structure.
//  Return Values:
//      ERROR_SUCCESS
//          The information was retrieved successfully.
//      ERROR_INVALID_PARAMETER
//          pRadioInfo or hRadio is NULL.
//      ERROR_REVISION_MISMATCH
//          pRadioInfo->dwSize is invalid.
//      other Win32 error codes.



function BluetoothGetRadioInfo(hRadio: THANDLE; var pRadioInfo: TBLUETOOTH_RADIO_INFO): DWORD; stdcall; external BTHProps_DLL;

// ***************************************************************************
//  Device Information Stuctures
// ***************************************************************************
type
    TBLUETOOTH_DEVICE_INFO = record
        dwSize: DWORD;
        //  size, in bytes, of this structure - must be the sizeof(BLUETOOTH_DEVICE_INFO)
        Address: TBLUETOOTH_ADDRESS;                  //  Bluetooth address
        ulClassofDevice: ULONG;                    //  Bluetooth "Class of Device"
        fConnected: boolean;                         //  Device connected/in use
        fRemembered: boolean;                        //  Device remembered
        fAuthenticated: boolean;
        //  Device authenticated/paired/bonded
        stLastSeen: TSYSTEMTIME;                     //  Last time the device was seen
        stLastUsed: TSYSTEMTIME;
        //  Last time the device was used for other than RNR, inquiry, or SDP
        szName: array [0.. BLUETOOTH_MAX_NAME_SIZE - 1] of WCHAR;  //  Name of the device
    end;
    PBLUETOOTH_DEVICE_INFO_STRUCT = ^TBLUETOOTH_DEVICE_INFO_STRUCT;

    TBLUETOOTH_DEVICE_INFO_STRUCT = TBLUETOOTH_DEVICE_INFO;

    PBLUETOOTH_DEVICE_INFO = ^TBLUETOOTH_DEVICE_INFO;

    // Support added after KB942567

{$IF ((NTDDI_VERSION > NTDDI_VISTASP1) OR
    ((NTDDI_VERSION = NTDDI_VISTASP1) AND defined(VISTA_KB942567)))}

    TBLUETOOTH_AUTHENTICATION_METHOD = (
        BLUETOOTH_AUTHENTICATION_METHOD_LEGACY = $1,
        BLUETOOTH_AUTHENTICATION_METHOD_OOB,
        BLUETOOTH_AUTHENTICATION_METHOD_NUMERIC_COMPARISON,
        BLUETOOTH_AUTHENTICATION_METHOD_PASSKEY_NOTIFICATION,
        BLUETOOTH_AUTHENTICATION_METHOD_PASSKEY);
    PBLUETOOTH_AUTHENTICATION_METHOD = ^TBLUETOOTH_AUTHENTICATION_METHOD;

    TBLUETOOTH_IO_CAPABILITY = (
        BLUETOOTH_IO_CAPABILITY_DISPLAYONLY = $00,
        BLUETOOTH_IO_CAPABILITY_DISPLAYYESNO = $01,
        BLUETOOTH_IO_CAPABILITY_KEYBOARDONLY = $02,
        BLUETOOTH_IO_CAPABILITY_NOINPUTNOOUTPUT = $03,
        BLUETOOTH_IO_CAPABILITY_UNDEFINED = $ff);

    TBLUETOOTH_AUTHENTICATION_REQUIREMENTS = (
        BLUETOOTH_MITM_ProtectionNotRequired = 0,
        BLUETOOTH_MITM_ProtectionRequired = $1,
        BLUETOOTH_MITM_ProtectionNotRequiredBonding = $2,
        BLUETOOTH_MITM_ProtectionRequiredBonding = $3,
        BLUETOOTH_MITM_ProtectionNotRequiredGeneralBonding = $4,
        BLUETOOTH_MITM_ProtectionRequiredGeneralBonding = $5,
        BLUETOOTH_MITM_ProtectionNotDefined = $ff);


    TBLUETOOTH_AUTHENTICATION_CALLBACK_PARAMS = record
        deviceInfo: TBLUETOOTH_DEVICE_INFO;
        authenticationMethod: TBLUETOOTH_AUTHENTICATION_METHOD;
        ioCapability: TBLUETOOTH_IO_CAPABILITY;
        authenticationRequirements: TBLUETOOTH_AUTHENTICATION_REQUIREMENTS;
        case integer of
            0: (Numeric_Value: ULONG);
            1: (Passkey: ULONG);
    end;
    PBLUETOOTH_AUTHENTICATION_CALLBACK_PARAMS = ^TBLUETOOTH_AUTHENTICATION_CALLBACK_PARAMS;

{$ENDIF}// >= SP1+KB942567

    // ***************************************************************************
    //  Device Enumeration
    //  Description:
    //      Enumerates the Bluetooth devices. The types of returned device depends
    //      on the flags set in the BLUETOOTH_DEVICE_SEARCH_PARAMS (see structure
    //      definition for details).
    //  Sample Usage:
    //      HBLUETOOTH_DEVICE_FIND hFind;
    //      BLUETOOTH_DEVICE_SEARCH_PARAMS btsp = { sizeof(btsp) };
    //      BLUETOOTH_DEVICE_INFO btdi = { sizeof(btdi) };
    //      btsp.fReturnAuthenticated = TRUE;
    //      btsp.fReturnRemembered    = TRUE;
    //      hFind = BluetoothFindFirstDevice( &btsp, &btdi );
    //      if ( NULL != hFind )
    //      {
    //          do
    //          {
    //              //
    //              //  TODO:   Do something useful with the device info.
    //              //
    //          } while( BluetoothFindNextDevice( hFind, &btdi ) );
    //          BluetoothFindDeviceClose( hFind );
    //      }
    // ***************************************************************************

    TBLUETOOTH_DEVICE_SEARCH_PARAMS = record
        dwSize: DWORD;                 //  IN  sizeof this structure
        fReturnAuthenticated: boolean;   //  IN  return authenticated devices
        fReturnRemembered: boolean;      //  IN  return remembered devices
        fReturnUnknown: boolean;         //  IN  return unknown devices
        fReturnConnected: boolean;       //  IN  return connected devices
        fIssueInquiry: boolean;          //  IN  issue a new inquiry
        cTimeoutMultiplier: UCHAR;     //  IN  timeout for the inquiry
        hRadio: THANDLE;
        //  IN  handle to radio to enumerate - NULL == all radios will be searched
    end;
    PBLUETOOTH_DEVICE_SEARCH_PARAMS = ^TBLUETOOTH_DEVICE_SEARCH_PARAMS;

    THBLUETOOTH_DEVICE_FIND = THANDLE;

//  Description:
//      Begins the enumeration of Bluetooth devices.
//  Parameters:
//      pbtsp
//          A pointer to a BLUETOOTH_DEVICE_SEARCH_PARAMS structure. This
//          structure contains the flags and inputs used to conduct the search.
//          See BLUETOOTH_DEVICE_SEARCH_PARAMS for details.
//      pbtdi
//          A pointer to a BLUETOOTH_DEVICE_INFO structure to return information
//          about the first Bluetooth device found. Note that the dwSize member
//          of the structure must be the sizeof(BLUETOOTH_DEVICE_INFO) before
//          calling because the APIs hast to know the size of the buffer being
//          past in. The dwSize member must also match the exact
//          sizeof(BLUETOOTH_DEVICE_INFO) or the call will fail.
//  Return Values:
//      NULL
//          Error opening radios or not devices found. Use GetLastError for more info.
//          ERROR_INVALID_PARAMETER
//              pbtsp parameter or pbtdi parameter is NULL.
//          ERROR_REVISION_MISMATCH
//              The pbtfrp structure is not the right length.
//          other Win32 errors
//      any other value
//          Success. The return handle is valid and pbtdi points to valid data.


function BluetoothFindFirstDevice(const pbtsp: TBLUETOOTH_DEVICE_SEARCH_PARAMS; var pbtdi: TBLUETOOTH_DEVICE_INFO): THBLUETOOTH_DEVICE_FIND; stdcall;
    external BTHProps_DLL;


//  Description:
//      Finds the next Bluetooth device in the enumeration.
//  Parameters:
//      hFind
//          The handle returned from BluetoothFindFirstDevice().
//      pbtdi
//          A pointer to a BLUETOOTH_DEVICE_INFO structure to return information
//          about the first Bluetooth device found. Note that the dwSize member
//          of the structure must be the sizeof(BLUETOOTH_DEVICE_INFO) before
//          calling because the APIs hast to know the size of the buffer being
//          past in. The dwSize member must also match the exact
//          sizeof(BLUETOOTH_DEVICE_INFO) or the call will fail.
//  Return Values:
//      TRUE
//          Next device succesfully found. pHandleOut points to valid handle.
//      FALSE
//          No device found. pHandleOut points to an invalid handle. Call
//          GetLastError() for more details.
//          ERROR_INVALID_HANDLE
//              The handle is NULL.
//          ERROR_NO_MORE_ITEMS
//              No more radios found.
//          ERROR_OUTOFMEMORY
//              Out of memory.
//          other Win32 errors



function BluetoothFindNextDevice(hFind: THBLUETOOTH_DEVICE_FIND; var pbtdi: TBLUETOOTH_DEVICE_INFO): boolean; stdcall; external BTHProps_DLL;


//  Description:
//      Closes the enumeration handle.
//  Parameters:
//      hFind
//          The handle returned from BluetoothFindFirstDevice().
//  Return Values:
//      TRUE
//          Handle succesfully closed.
//      FALSE
//          Failure. Check GetLastError() for details.
//          ERROR_INVALID_HANDLE
//              The handle is NULL.


function BluetoothFindDeviceClose(hFind: THBLUETOOTH_DEVICE_FIND): boolean;
    stdcall; external BTHProps_DLL;


//  Description:
//      Retrieves information about a remote device.
//      Fill in the dwSize and the Address members of the pbtdi structure
//      being passed in. On success, the rest of the members will be filled
//      out with the information that the system knows.
//  Parameters:
//      hRadio
//          Handle to a local radio retrieved through BluetoothFindFirstRadio()
//          et al or SetupDiEnumerateDeviceInterfaces()
//      pbtdi
//          A pointer to a BLUETOOTH_DEVICE_INFO structure to return information
//          about the first Bluetooth device found. The dwSize member of the
//          structure must be the sizeof the structure in bytes. The Address
//          member must be filled out with the Bluetooth address of the remote
//          device.
//  Return Values:
//      ERROR_SUCCESS
//          Success. Information returned.
//      ERROR_REVISION_MISMATCH
//          The size of the BLUETOOTH_DEVICE_INFO isn't compatible. Check
//          the dwSize member of the BLUETOOTH_DEVICE_INFO structure you
//          passed in.
//      ERROR_NOT_FOUND
//          The radio is not known by the system or the Address field of
//          the BLUETOOTH_DEVICE_INFO structure is all zeros.
//      ERROR_INVALID_PARAMETER
//          pbtdi is NULL.
//      other error codes



function BluetoothGetDeviceInfo(hRadio: THANDLE; var pbtdi: TBLUETOOTH_DEVICE_INFO): DWORD; stdcall; external BTHProps_DLL;


//  Description:
//      Updates the computer local cache about the device.
//  Parameters:
//      pbtdi
//          A pointer to the BLUETOOTH_DEVICE_INFO structure to be updated.
//          The following members must be valid:
//              dwSize
//                  Must match the size of the structure.
//              Address
//                  Must be a previously found radio address.
//              szName
//                  New name to be stored.
//  Return Values:
//      ERROR_SUCCESS
//          The device information was updated successfully.
//      ERROR_INVALID_PARAMETER
//          pbtdi is NULL.
//      ERROR_REVISION_MISMATCH
//          pbtdi->dwSize is invalid.
//      other Win32 error codes.



function BluetoothUpdateDeviceRecord(const pbtdi: TBLUETOOTH_DEVICE_INFO): DWORD;
    stdcall; external BTHProps_DLL;


//  Description:
//      Delete the authentication (aka "bond") between the computer and the
//      device. Also purges any cached information about the device.
//  Return Values:
//      ERROR_SUCCESS
//          The device was removed successfully.
//      ERROR_NOT_FOUND
//          The device was not found. If no Bluetooth radio is installed,
//          the devices could not be enumerated or removed.


function BluetoothRemoveDevice(const pAddress: TBLUETOOTH_ADDRESS): DWORD;
    stdcall; external BTHProps_DLL;

{$IFNDEF CPUARM }
// ***************************************************************************
//  Device Picker Dialog
//  Description:
//      Invokes a common dialog for selecting Bluetooth devices. The list
//      of devices displayed to the user is determined by the flags and
//      settings the caller specifies in the BLUETOOTH_SELECT_DEVICE_PARAMS
//      (see structure definition for more details).
//      If BluetoothSelectDevices() returns TRUE, the caller must call
//      BluetoothSelectDevicesFree() or memory will be leaked within the
//      process.
//  Sample Usage:
//      BLUETOOTH_SELECT_DEVICE_PARAMS btsdp = { sizeof(btsdp) };
//      btsdp.hwndParent = hDlg;
//      btsdp.fShowUnknown = TRUE;
//      btsdp.fAddNewDeviceWizard = TRUE;
//      boolean b = BluetoothSelectDevices( &btsdp );
//      if ( b )
//      {
//          BLUETOOTH_DEVICE_INFO * pbtdi = btsdp.pDevices;
//          for ( ULONG cDevice = 0; cDevice < btsdp.cNumDevices; cDevice ++ )
//          {
//              if ( pbtdi->fAuthenticated || pbtdi->fRemembered )
//              {
//                  //
//                  //  TODO:   Do something usefull with the device info
//                  //
//              }
//              pbtdi = (BLUETOOTH_DEVICE_INFO *) ((LPBYTE)pbtdi + pbtdi->dwSize);
//          }
//          BluetoothSelectDevicesFree( &btsdp );
//      }
// ***************************************************************************

type
    TBLUETOOTH_COD_PAIRS = record
        ulCODMask: ULONG;                          //  ClassOfDevice mask to compare
        pcszDescription: LPCWSTR;                    //  Descriptive string of mask

    end;
    PBLUETOOTH_COD_PAIRS = ^TBLUETOOTH_COD_PAIRS;

    PFN_DEVICE_CALLBACK = function(pvParam: pointer; pDevice: PBLUETOOTH_DEVICE_INFO): boolean; stdcall;

    TBLUETOOTH_SELECT_DEVICE_PARAMS = record
        dwSize: DWORD;                             //  IN  sizeof this structure
        cNumOfClasses: ULONG;
        //  IN  Number in prgClassOfDevice - if ZERO search for all devices
        prgClassOfDevices: PBLUETOOTH_COD_PAIRS;    //  IN  Array of CODs to find.
        pszInfo: LPWSTR;
        //  IN  If not NULL, sets the "information" text
        hwndParent: HWND;
        //  IN  parent window - NULL == no parent
        fForceAuthentication: boolean;
        //  IN  If TRUE, authenication will be forced before returning
        fShowAuthenticated: boolean;
        //  IN  If TRUE, authenticated devices will be shown in the picker
        fShowRemembered: boolean;
        //  IN  If TRUE, remembered devices will be shown in the picker
        fShowUnknown: boolean;
        //  IN  If TRUE, unknown devices that are not authenticated or "remember" will be shown.
        fAddNewDeviceWizard: boolean;
        //  IN  If TRUE, invokes the add new device wizard.
        fSkipServicesPage: boolean;
        //  IN  If TRUE, skips the "Services" page in the wizard.
        pfnDeviceCallback: PFN_DEVICE_CALLBACK;
        //  IN  If non-NULL, a callback that will be called for each device. If the
        //      the callback returns TRUE, the item will be added. If the callback is
        //      is FALSE, the item will not be shown.
        pvParam: Pointer;
        //  IN  Parameter to be passed to pfnDeviceCallback as the pvParam.
        cNumDevices: DWORD;
        //  IN  number calles wants - ZERO == no limit.
        //  OUT the number of devices returned.
        pDevices: PBLUETOOTH_DEVICE_INFO;
        //  OUT pointer to an array for BLUETOOTH_DEVICE_INFOs.
        //      call BluetoothSelectDevicesFree() to free
    end;
    PBLUETOOTH_SELECT_DEVICE_PARAMS = ^TBLUETOOTH_SELECT_DEVICE_PARAMS;


//  Description:
//      (See header above)
//  Return Values:
//      TRUE
//          User selected a device. pbtsdp->pDevices points to valid data.
//          Caller should check the fAuthenticated && fRemembered flags to
//          determine which devices we successfuly authenticated or valid
//          selections by the user.
//          Use BluetoothSelectDevicesFree() to free the nessecary data
//          such as pDevices only if this function returns TRUE.
//      FALSE
//          No valid data returned. Call GetLastError() for possible details
//          of the failure. If GLE() is:
//          ERROR_CANCELLED
//              The user cancelled  the request.
//          ERROR_INVALID_PARAMETER
//              The pbtsdp is NULL.
//          ERROR_REVISION_MISMATCH
//              The structure passed in as pbtsdp is of an unknown size.
//          other WIN32 errors



function BluetoothSelectDevices(var pbtsdp: TBLUETOOTH_SELECT_DEVICE_PARAMS): boolean;
    stdcall;
    external BTHProps_DLL;


//  Description:
//      This function should only be called if BluetoothSelectDevices() returns
//      TRUE. This function will free any memory and resource returned by the
//      BluetoothSelectDevices() in the BLUETOOTH_SELECT_DEVICE_PARAMS
//      structure.
//  Return Values:
//      TRUE
//          Success.
//      FALSE
//          Nothing to free.


function BluetoothSelectDevicesFree(var pbtsdp: TBLUETOOTH_SELECT_DEVICE_PARAMS): boolean; stdcall;
    external BTHProps_DLL;

{$ENDIF}//!defined(_ARM_)

// ***************************************************************************
//  Device Property Sheet
// ***************************************************************************
//  Description:
//      Invokes the CPLs device info property sheet.
//  Parameters:
//      hwndParent
//          HWND to parent the property sheet.
//      pbtdi
//          A pointer to a BLUETOOTH_DEVICE_INFO structure of the device
//          to be displayed.
//  Return Values:
//      TRUE
//          The property page was successfully displayed.
//      FALSE
//          Failure. The property page was not displayed. Check GetLastError
//          for more details.


function BluetoothDisplayDeviceProperties(hwndParent: HWND; var pbtdi: TBLUETOOTH_DEVICE_INFO): boolean; stdcall; external BTHProps_DLL;


// ***************************************************************************
//  Radio Authentication
// ***************************************************************************
//  Description:
//      Sends an authentication request to a remote device.
//      There are two modes of operation. "Wizard mode" and "Blind mode."
//      "Wizard mode" is invoked when the pszPasskey is NULL. This will cause
//      the "Bluetooth Connection Wizard" to be invoked. The user will be
//      prompted to enter a passkey during the wizard after which the
//      authentication request will be sent. The user will see the success
//      or failure of the authentication attempt. The user will also be
//      given the oppurtunity to try to fix a failed authentication.
//      "Blind mode" is invoked when the pszPasskey is non-NULL. This will
//      cause the computer to send a authentication request to the remote
//      device. No UI is ever displayed. The Bluetooth status code will be
//      mapped to a Win32 Error code.
//  Parameters:
//      hwndParent
//          The window to parent the authentication wizard. If NULL, the
//          wizard will be parented off the desktop.
//      hRadio
//          A valid local radio handle or NULL. If NULL, then all radios will
//          be tired. If any of the radios succeed, then the call will
//          succeed.
//      pbtdi
//          BLUETOOTH_DEVICE_INFO record of the device to be authenticated.
//      pszPasskey
//          PIN to be used to authenticate the device.  If NULL, then UI is
//          displayed and the user steps through the authentication process.
//          If not NULL, no UI is shown.  The passkey is NOT NULL terminated.
//      ulPasskeyLength
//          Length of szPassKey in bytes. The length must be less than or
//          equal to BLUETOOTH_MAX_PASSKEY_SIZE * sizeof(WCHAR).
//  Return Values:
//      ERROR_SUCCESS
//          Success.
//      ERROR_CANCELLED
//          User aborted the operation.
//      ERROR_INVALID_PARAMETER
//          The device structure in pbtdi is invalid.
//      ERROR_NO_MORE_ITEMS
//          The device in pbtdi is already been marked as authenticated.
//      other WIN32 error
//          Failure. Return value is the error code.
//      For "Blind mode," here is the current mapping of Bluetooth status
//      code to Win32 error codes:
//          { BTH_ERROR_SUCCESS,                ERROR_SUCCESS },
//          { BTH_ERROR_NO_CONNECTION,          ERROR_DEVICE_NOT_CONNECTED },
//          { BTH_ERROR_PAGE_TIMEOUT,           WAIT_TIMEOUT },
//          { BTH_ERROR_HARDWARE_FAILURE,       ERROR_GEN_FAILURE },
//          { BTH_ERROR_AUTHENTICATION_FAILURE, ERROR_NOT_AUTHENTICATED },
//          { BTH_ERROR_MEMORY_FULL,            ERROR_NOT_ENOUGH_MEMORY },
//          { BTH_ERROR_CONNECTION_TIMEOUT,     WAIT_TIMEOUT },
//          { BTH_ERROR_LMP_RESPONSE_TIMEOUT,   WAIT_TIMEOUT },
//          { BTH_ERROR_MAX_NUMBER_OF_CONNECTIONS, ERROR_REQ_NOT_ACCEP },
//          { BTH_ERROR_PAIRING_NOT_ALLOWED,    ERROR_ACCESS_DENIED },
//          { BTH_ERROR_UNSPECIFIED_ERROR,      ERROR_NOT_READY },
//          { BTH_ERROR_LOCAL_HOST_TERMINATED_CONNECTION, ERROR_VC_DISCONNECTED },

function BluetoothAuthenticateDevice(hwndParent: HWND; hRadio: THANDLE; var pbtbi: TBLUETOOTH_DEVICE_INFO; pszPasskey: PWSTR;
    ulPasskeyLength: ULONG): DWORD; stdcall; external BTHProps_DLL;



// Support added after KB942567

{$IF  ((NTDDI_VERSION > NTDDI_VISTASP1) OR ((NTDDI_VERSION = NTDDI_VISTASP1) AND defined(VISTA_KB942567)))}

// Replaces previous API
// #pragma deprecated("BluetoothAuthenticateDevice")
// Common header for all PIN related structures

type
    TBLUETOOTH_PIN_INFO = record
        pin: array [0..BTH_MAX_PIN_SIZE - 1] of UCHAR;
        pinLength: UCHAR;
    end;
    PBLUETOOTH_PIN_INFO = ^TBLUETOOTH_PIN_INFO;

    TBLUETOOTH_OOB_DATA_INFO = record
        C: array [0..15] of UCHAR;
        R: array [0..15] of UCHAR;
    end;
    PBLUETOOTH_OOB_DATA_INFO = ^TBLUETOOTH_OOB_DATA_INFO;

    TBLUETOOTH_NUMERIC_COMPARISON_INFO = record
        NumericValue: ULONG;
    end;
    PBLUETOOTH_NUMERIC_COMPARISON_INFO = ^TBLUETOOTH_NUMERIC_COMPARISON_INFO;

    TBLUETOOTH_PASSKEY_INFO = record
        passkey: ULONG;
    end;
    PBLUETOOTH_PASSKEY_INFO = ^TBLUETOOTH_PASSKEY_INFO;


//  Description:
//      Sends an authentication request to a remote device.
//      There are two modes of operation. "Wizard mode" and "Blind mode."
//      "Wizard mode" is invoked when the pbtOobData is NULL. This will cause
//      the "Bluetooth Connection Wizard" to be invoked. The user will be
//      prompted to respond to the device authentication during the wizard
//      after which the authentication request will be sent. The user will see the success
//      or failure of the authentication attempt. The user will also be
//      given the oppurtunity to try to fix a failed authentication.
//      "Blind mode" is invoked when the pbtOobData is non-NULL. This will
//      cause the computer to send a authentication request to the remote
//      device. No UI is ever displayed. The Bluetooth status code will be
//      mapped to a Win32 Error code.
//  Parameters:
//      hwndParent
//          The window to parent the authentication wizard. If NULL, the
//          wizard will be parented off the desktop.
//      hRadio
//          A valid local radio handle or NULL. If NULL, then all radios will
//          be tired. If any of the radios succeed, then the call will
//          succeed.
//      pbtdi
//          BLUETOOTH_DEVICE_INFO record of the device to be authenticated.
//      pbtOobData
//          Out of band data to be used to authenticate the device.  If NULL, then UI is
//          displayed and the user steps through the authentication process.
//          If not NULL, no UI is shown.
//      authenticationRequirement
//          The Authentication Requirement of the caller.  MITMProtection*
//  Return Values:
//      ERROR_SUCCESS
//          Success.
//      ERROR_CANCELLED
//          User aborted the operation.
//      ERROR_INVALID_PARAMETER
//          The device structure in pbtdi is invalid.
//      ERROR_NO_MORE_ITEMS
//          The device in pbtdi is already been marked as authenticated.
//      other WIN32 error
//          Failure. Return value is the error code.
//      For "Blind mode," here is the current mapping of Bluetooth status
//      code to Win32 error codes:
//          { BTH_ERROR_SUCCESS,                ERROR_SUCCESS },
//          { BTH_ERROR_NO_CONNECTION,          ERROR_DEVICE_NOT_CONNECTED },
//          { BTH_ERROR_PAGE_TIMEOUT,           WAIT_TIMEOUT },
//          { BTH_ERROR_HARDWARE_FAILURE,       ERROR_GEN_FAILURE },
//          { BTH_ERROR_AUTHENTICATION_FAILURE, ERROR_NOT_AUTHENTICATED },
//          { BTH_ERROR_MEMORY_FULL,            ERROR_NOT_ENOUGH_MEMORY },
//          { BTH_ERROR_CONNECTION_TIMEOUT,     WAIT_TIMEOUT },
//          { BTH_ERROR_LMP_RESPONSE_TIMEOUT,   WAIT_TIMEOUT },
//          { BTH_ERROR_MAX_NUMBER_OF_CONNECTIONS, ERROR_REQ_NOT_ACCEP },
//          { BTH_ERROR_PAIRING_NOT_ALLOWED,    ERROR_ACCESS_DENIED },
//          { BTH_ERROR_UNSPECIFIED_ERROR,      ERROR_NOT_READY },
//          { BTH_ERROR_LOCAL_HOST_TERMINATED_CONNECTION, ERROR_VC_DISCONNECTED },



function BluetoothAuthenticateDeviceEx(hwndParentIn: HWND; hRadioIn: THANDLE; var pbtdiInout: TBLUETOOTH_DEVICE_INFO;
    pbtOobData: PBLUETOOTH_OOB_DATA_INFO; authenticationRequirement: TAUTHENTICATION_REQUIREMENTS): DWORD; stdcall;
    external BTHProps_DLL;

{$ENDIF}// >= SP1+KB942567

//  Description:
//      Allows the caller to prompt for multiple devices to be authenticated
//      within a single instance of the "Bluetooth Connection Wizard."
//  Parameters:
//      hwndParent
//          The window to parent the authentication wizard. If NULL, the
//          wizard will be parented off the desktop.
//      hRadio
//          A valid local radio handle or NULL. If NULL, then all radios will
//          be tired. If any of the radios succeed, then the call will
//          succeed.
//      cDevices
//          Number of devices in the rgbtdi array.
//      rgbtdi
//          An array BLUETOOTH_DEVICE_INFO records of the devices to be
//          authenticated.
//  Return Values:
//      ERROR_SUCCESS
//          Success. Check the fAuthenticate flag on each of the devices.
//      ERROR_CANCELLED
//          User aborted the operation. Check the fAuthenticate flags on
//          each device to determine if any of the devices were authenticated
//          before the user cancelled the operation.
//      ERROR_INVALID_PARAMETER
//          One of the items in the array of devices is invalid.
//      ERROR_NO_MORE_ITEMS
//          All the devices in the array of devices are already been marked as
//          being authenticated.
//      other WIN32 error
//          Failure. Return value is the error code.



function BluetoothAuthenticateMultipleDevices(hwndParent: HWND; hRadio: THANDLE; cDevices: DWORD; var rgbtdi: PBLUETOOTH_DEVICE_INFO): DWORD;
    stdcall; external BTHProps_DLL;


// Deprecated after Vista SP1 and KB942567

{$IF  ((NTDDI_VERSION > NTDDI_VISTASP1) OR ((NTDDI_VERSION = NTDDI_VISTASP1) AND defined(VISTA_KB942567)))}

//pragma deprecated("BluetoothAuthenticateMultipleDevices")

{$ENDIF}// >= SP1+KB942567


// ***************************************************************************
//  Bluetooth Services
// ***************************************************************************

const
    BLUETOOTH_SERVICE_DISABLE = $00;
    BLUETOOTH_SERVICE_ENABLE = $01;
    BLUETOOTH_SERVICE_MASK = (BLUETOOTH_SERVICE_DISABLE or BLUETOOTH_SERVICE_ENABLE);


//  Description:
//      Enables/disables the services for a particular device.
//      The system maintains a mapping of service guids to supported drivers for
//      Bluetooth-enabled devices. Enabling a service installs the corresponding
//      device driver. Disabling a service removes the corresponding device driver.
//      If a non-supported service is enabled, a driver will not be installed.
//  Parameters
//      hRadio
//          Handle of the local Bluetooth radio device.
//      pbtdi
//          Pointer to a BLUETOOTH_DEVICE_INFO record.
//      pGuidService
//          The service GUID on the remote device.
//      dwServiceFlags
//          Flags to adjust the service.
//              BLUETOOTH_SERVICE_DISABLE   -   disable the service
//              BLUETOOTH_SERVICE_ENABLE    -   enables the service
//  Return Values:
//      ERROR_SUCCESS
//          The call was successful.
//      ERROR_INVALID_PARAMETER
//          dwServiceFlags are invalid.
//      ERROR_SERVICE_DOES_NOT_EXIST
//          The GUID in pGuidService is not supported.
//      other WIN32 error
//          The call failed.



function BluetoothSetServiceState(hRadio: THANDLE; const pbtdi: TBLUETOOTH_DEVICE_INFO; const pGuidService: TGUID; dwServiceFlags: DWORD): DWORD;
    stdcall; external BTHProps_DLL;


//  Description:
//      Enumerates the services guids enabled on a particular device. If hRadio
//      is NULL, all device will be searched for the device and all the services
//      enabled will be returned.
//  Parameters:
//      hRadio
//          Handle of the local Bluetooth radio device. If NULL, it will search
//          all the radios for the address in the pbtdi.
//      pbtdi
//          Pointer to a BLUETOOTH_DEVICE_INFO record.
//      pcService
//          On input, the number of records pointed to by pGuidServices.
//          On output, the number of valid records return in pGuidServices.
//      pGuidServices
//          Pointer to memory that is at least *pcService in length.
//  Return Values:
//      ERROR_SUCCESS
//          The call succeeded. pGuidServices is valid.
//      ERROR_MORE_DATA
//          The call succeeded. pGuidService contains an incomplete list of
//          enabled service GUIDs.
//      other WIN32 errors
//          The call failed.


function BluetoothEnumerateInstalledServices(hRadio: THANDLE; const pbtdi: TBLUETOOTH_DEVICE_INFO; var pcServiceInout: DWORD;
    out pGuidServices: PGUID): DWORD; stdcall; external BTHProps_DLL;


//  Description:
//      Change the discovery state of the local radio(s).
//      If hRadio is NULL, all the radios will be set.
//      Use BluetoothIsDiscoverable() to determine the radios current state.
//      The system ensures that a discoverable system is connectable, thus
//      the radio must allow incoming connections (see
//      BluetoothEnableIncomingConnections) prior to making a radio
//      discoverable. Failure to do so will result in this call failing
//      (returns FALSE).
//  Parameters:
//      hRadio
//          If not NULL, changes the state of a specific radio.
//          If NULL, the API will interate through all the radios.
//      fEnabled
//          If FALSE, discovery will be disabled.
//  Return Values
//      TRUE
//          State was successfully changed. If the caller specified NULL for
//          hRadio, at least of the radios accepted the state change.
//      FALSE
//          State was not changed. If the caller specified NULL for hRadio, all
//          of the radios did not accept the state change.

function BluetoothEnableDiscovery(hRadio: THANDLE; fEnabled: boolean): boolean;
    stdcall; external BTHProps_DLL;

//  Description:
//      Determines if the Bluetooth radios are discoverable. If there are
//      multiple radios, the first one to say it is discoverable will cause
//      this function to return TRUE.
//  Parameters:
//      hRadio
//          Handle of the radio to check. If NULL, it will check all local
//          radios.
//  Return Values:
//      TRUE
//          A least one radio is discoverable.
//      FALSE
//          No radios are discoverable.



function BluetoothIsDiscoverable(hRadio: THANDLE): boolean;
    stdcall; external BTHProps_DLL;

//  Description:
//      Enables/disables the state of a radio to accept incoming connections.
//      If hRadio is NULL, all the radios will be set.
//      Use BluetoothIsConnectable() to determine the radios current state.
//      The system enforces that a radio that is not connectable is not
//      discoverable too. The radio must be made non-discoverable (see
//      BluetoothEnableDiscovery) prior to making a radio non-connectionable.
//      Failure to do so will result in this call failing (returns FALSE).
//  Parameters:
//      hRadio
//          If not NULL, changes the state of a specific radio.
//          If NULL, the API will interate through all the radios.
//      fEnabled
//          If FALSE, incoming connection will be disabled.
//  Return Values
//      TRUE
//          State was successfully changed. If the caller specified NULL for
//          hRadio, at least of the radios accepted the state change.
//      FALSE
//          State was not changed. If the caller specified NULL for hRadio, all
//          of the radios did not accept the state change.

function BluetoothEnableIncomingConnections(hRadio: THANDLE; fEnabled: boolean): boolean; stdcall; external BTHProps_DLL;


//  Description:
//      Determines if the Bluetooth radios are connectable. If there are
//      multiple radios, the first one to say it is connectable will cause
//      this function to return TRUE.
//  Parameters:
//      hRadio
//          Handle of the radio to check. If NULL, it will check all local
//          radios.
//  Return Values:
//      TRUE
//          A least one radio is allowing incoming connections.
//      FALSE
//          No radios are allowing incoming connections.

function BluetoothIsConnectable(hRadio: THANDLE): boolean;
    stdcall; external BTHProps_DLL;

// ***************************************************************************
//  Authentication Registration
// ***************************************************************************

type
    THBLUETOOTH_AUTHENTICATION_REGISTRATION = THANDLE;

    PFN_AUTHENTICATION_CALLBACK = function(pvParam: pointer; pDevice: PBLUETOOTH_DEVICE_INFO): boolean; stdcall;

//  Description:
//      Registers a callback function to be called when a particular device
//      requests authentication. The request is sent to the last application
//      that requested authentication for a particular device.
//  Parameters:
//      pbtdi
//          A pointer to a BLUETOOTH_DEVICE_INFO structure. The Bluetooth
//          address will be used for comparision.
//      phRegHandle
//          A pointer to where the registration HANDLE value will be
//          stored. Call BluetoothUnregisterAuthentication() to close
//          the handle.
//      pfnCallback
//          The function that will be called when the authentication event
//          occurs. This function should match PFN_AUTHENTICATION_CALLBACK's
//          prototype.
//      pvParam
//          Optional parameter to be passed through to the callback function.
//          This can be anything the application was to define.
//  Return Values:
//      ERROR_SUCCESS
//          Success. A valid registration handle was returned.
//      ERROR_OUTOFMEMORY
//          Out of memory.
//      other Win32 error.
//          Failure. The registration handle is invalid.


function BluetoothRegisterForAuthentication(const pbtdi: TBLUETOOTH_DEVICE_INFO; out phRegHandle: THBLUETOOTH_AUTHENTICATION_REGISTRATION;
    pfnCallback: PFN_AUTHENTICATION_CALLBACK; pvParam: pointer): DWORD; stdcall;
    external BTHProps_DLL;


// Support added in KB942567

{$IF  ((NTDDI_VERSION > NTDDI_VISTASP1) or  ((NTDDI_VERSION = NTDDI_VISTASP1) AND defined(VISTA_KB942567)))}

// Replaces previous API
//pragma deprecated("BluetoothRegisterForAuthentication")
type
    PFN_AUTHENTICATION_CALLBACK_EX = function(pvParam: pointer; pAuthCallbackParams: PBLUETOOTH_AUTHENTICATION_CALLBACK_PARAMS): boolean;
        stdcall;

//  Description:
//      Registers a callback function to be called when a particular device
//      requests authentication. The request is sent to the last application
//      that requested authentication for a particular device.
//  Parameters:
//      pbtdi
//          A pointer to a BLUETOOTH_DEVICE_INFO structure. The Bluetooth
//          address will be used for comparision.
//      phRegHandle
//          A pointer to where the registration HANDLE value will be
//          stored. Call BluetoothUnregisterAuthentication() to close
//          the handle.
//      pfnCallback
//          The function that will be called when the authentication event
//          occurs. This function should match PFN_AUTHENTICATION_CALLBACK_EX's
//          prototype.
//      pvParam
//          Optional parameter to be passed through to the callback function.
//          This can be anything the application was to define.
//  Return Values:
//      ERROR_SUCCESS
//          Success. A valid registration handle was returned.
//      ERROR_OUTOFMEMORY
//          Out of memory.
//      other Win32 error.
//          Failure. The registration handle is invalid.


function BluetoothRegisterForAuthenticationEx(const pbtdiIn: TBLUETOOTH_DEVICE_INFO; out phRegHandleOut: THBLUETOOTH_AUTHENTICATION_REGISTRATION;
    pfnCallbackIn: PFN_AUTHENTICATION_CALLBACK_EX; pvParam: pointer): DWORD;
    stdcall; external BTHProps_DLL;

{$ENDIF}// >= SP1+KB942567

//  Description:
//      Unregisters an authentication callback and closes the handle. See
//      BluetoothRegisterForAuthentication() for more information about
//      authentication registration.
//  Parameters:
//      hRegHandle
//          Handle returned by BluetoothRegisterForAuthentication().
//  Return Value:
//      TRUE
//          The handle was successfully closed.
//      FALSE
//          The handle was not successfully closed. Check GetLastError for
//          more details.
//          ERROR_INVALID_HANDLE
//              The handle is NULL.
//          other Win32 errors.

function BluetoothUnregisterAuthentication(hRegHandle: THBLUETOOTH_AUTHENTICATION_REGISTRATION): boolean;
    stdcall; external BTHProps_DLL;


//  Description:
//      This function should be called after receiving an authentication request
//      to send the passkey response.
//  Parameters:
//      hRadio
//          Optional handle to the local radio. If NULL, the function will try
//          each radio until one succeeds.
//      pbtdi
//          A pointer to a BLUETOOTH_DEVICE_INFO structure describing the device
//          being authenticated. This can be the same structure passed to the
//          callback function.
//      pszPasskey
//          A pointer to UNICODE zero-terminated string of the passkey response
//          that should be sent back to the authenticating device.
//  Return Values:
//      ERROR_SUCESS
//          The device accepted the passkey response. The device is authenticated.
//      ERROR_CANCELED
//          The device denied the passkey reponse. This also will returned if there
//          is a communications problem with the local radio.
//      E_FAIL
//          The device returned a failure code during authentication.
//      other Win32 error codes

function BluetoothSendAuthenticationResponse(hRadio: THANDLE; const pbtdi: TBLUETOOTH_DEVICE_INFO; pszPasskey: LPCWSTR): DWORD; stdcall;
    external BTHProps_DLL;

// Support added in KB942567

{$IF  ((NTDDI_VERSION > NTDDI_VISTASP1) OR ((NTDDI_VERSION = NTDDI_VISTASP1) AND defined(VISTA_KB942567)))}

// Replaces previous API
//pragma deprecated("BluetoothSendAuthenticationResponse")

// Structure used when responding to BTH_REMOTE_AUTHENTICATE_REQUEST event

type
    TBLUETOOTH_AUTHENTICATE_RESPONSE = record
        bthAddressRemote: TBLUETOOTH_ADDRESS;
        authMethod: TBLUETOOTH_AUTHENTICATION_METHOD;

        case integer of
            0: (pinInfo: TBLUETOOTH_PIN_INFO;
                negativeResponse: UCHAR;);
            1: (oobInfo: TBLUETOOTH_OOB_DATA_INFO);
            2: (numericCompInfo: TBLUETOOTH_NUMERIC_COMPARISON_INFO);
            3: (passkeyInfo: TBLUETOOTH_PASSKEY_INFO);
    end;
    PBLUETOOTH_AUTHENTICATE_RESPONSE = ^TBLUETOOTH_AUTHENTICATE_RESPONSE;

//  Description:
//      This function should be called after receiving an authentication request
//      to send the authentication response. (Bluetooth 2.1 and above)
//  Parameters:
//      hRadio
//          Optional handle to the local radio. If NULL, the function will try
//          each radio until one succeeds.
//      pbtdi
//          A pointer to a BLUETOOTH_DEVICE_INFO structure describing the device
//          being authenticated. This can be the same structure passed to the
//          callback function.
//      pauthResponse
//          A pointer to a BTH_AUTHENTICATION_RESPONSE structure.
//  Return Values:
//      ERROR_SUCESS
//          The device accepted the passkey response. The device is authenticated.
//      ERROR_CANCELED
//          The device denied the passkey reponse. This also will returned if there
//          is a communications problem with the local radio.
//      E_FAIL
//          The device returned a failure code during authentication.
//      other Win32 error codes


function BluetoothSendAuthenticationResponseEx(hRadioIn: THANDLE; pauthResponse: PBLUETOOTH_AUTHENTICATE_RESPONSE): DWORD; stdcall;
    external BTHProps_DLL;

{$ENDIF}// >= SP1+KB942567

// ***************************************************************************
//  SDP Parsing Functions
// ***************************************************************************
type
    TSDP_ELEMENT_DATA_STRING = record
        // raw string buffer, may not be encoded as ANSI, use
        // BluetoothSdpGetString to convert the value if it is described
        // by the base language attribute ID list
        Value: PBYTE;
        // raw length of the string, may not be NULL terminuated
        length: ULONG;
    end;

    TSDP_ELEMENT_DATA_URL = record
        Value: PBYTE;
        length: ULONG;
    end;

    TSDP_ELEMENT_DATA_SEQUENCE = record
        // raw sequence, starts at sequence element header
        Value: PBYTE;
        // raw sequence length
        length: ULONG;
    end;

    TSDP_ELEMENT_DATA_ALTERNATIVE = record
        // raw alternative, starts at alternative element header
        Value: PBYTE;
        // raw alternative length
        length: ULONG;
    end;

    TSDP_ELEMENT_DATA = record
        // Enumeration of SDP element types.  Generic element types will have a
        // specificType value other then SDP_ST_NONE.  The generic types are:
        // o SDP_TYPE_UINT
        // o SDP_TYPE_INT
        // o SDP_TYPE_UUID
        AType: TSDP_TYPE;
        // Specific types for the generic SDP element types.
        specificType: TSDP_SPECIFICTYPE;
            // Union of all possible data types.  type and specificType will indicate
            // which field is valid.  For types which do not have a valid specificType,
            // specific type will be SDP_ST_NONE.
        case integer of
            // type == SDP_TYPE_INT
            0: (int128: TSDP_LARGE_INTEGER_16);        // specificType == SDP_ST_INT128
            1: (int64: LONGLONG);                     // specificType == SDP_ST_INT64
            2: (int32: LONG);                         // specificType == SDP_ST_INT32
            3: (int16: SHORT);                        // specificType == SDP_ST_INT16
            4: (int8: char);                          // specificType == SDP_ST_INT8
            // type == SDP_TYPE_UINT
            5: (uint128: TSDP_ULARGE_INTEGER_16);      // specificType == SDP_ST_UINT128
            6: (uint64: ULONGLONG);                   // specificType == SDP_ST_UINT64
            7: (uint32: ULONG);                       // specificType == SDP_ST_UINT32
            8: (uint16: USHORT);                      // specificType == SDP_ST_UINT16
            9: (uint8: UCHAR);                        // specificType == SDP_ST_UINT8
            // type == SDP_TYPE_BOOLEAN
            10: (booleanVal: UCHAR);
            // type == SDP_TYPE_UUID
            11: (uuid128: TGUID);                       // specificType == SDP_ST_UUID128
            12: (uuid32: ULONG);                       // specificType == SDP_ST_UUID32
            13: (uuid16: USHORT);                      // specificType == SDP_ST_UUID32
            // type == SDP_TYPE_STRING
            14: (AString: TSDP_ELEMENT_DATA_STRING);
            // type == SDP_TYPE_URL
            15: (url: TSDP_ELEMENT_DATA_URL);
            // type == SDP_TYPE_SEQUENCE
            16: (sequence: TSDP_ELEMENT_DATA_SEQUENCE);
            // type == SDP_TYPE_ALTERNATIVE
            17: (alternative: TSDP_ELEMENT_DATA_ALTERNATIVE);
    end;
    PSDP_ELEMENT_DATA = ^TSDP_ELEMENT_DATA;

// Description:
//      Retrieves and parses the element found at pSdpStream
// Parameters:
//      IN pSdpStream
//          pointer to valid SDP stream
//      IN cbSdpStreamLength
//          length of pSdpStream in bytes
//      OUT pData
//          pointer to be filled in with the data of the SDP element at the
//          beginning of pSdpStream
// Return Values:
//      ERROR_INVALID_PARAMETER
//          one of required parameters is NULL or the pSdpStream is invalid
//      ERROR_SUCCESS
//          the sdp element was parsed correctly


function BluetoothSdpGetElementData(pSdpStream: PBYTE; cbSdpStreamLength: ULONG; out pData: TSDP_ELEMENT_DATA): DWORD; stdcall;
    external BTHProps_DLL;

type
    THBLUETOOTH_CONTAINER_ELEMENT = THANDLE;

// Description:
//      Iterates over a container stream, returning each elemetn contained with
//      in the container element at the beginning of pContainerStream
// Parameters:
//      IN pContainerStream
//          pointer to valid SDP stream whose first element is either a sequence
//          or alternative
//      IN cbContainerlength
//          length in bytes of pContainerStream
//      IN OUT pElement
//          Value used to keep track of location within the stream.  The first
//          time this function is called for a particular container, *pElement
//          should equal NULL.  Upon subsequent calls, the value should be
//          unmodified.
//      OUT pData
//          pointer to be filled in with the data of the SDP element at the
//          current element of pContainerStream
//  Return Values:
//      ERROR_SUCCESS
//          The call succeeded, pData contains the data
//      ERROR_NO_MORE_ITEMS
//          There are no more items in the list, the caller should cease calling
//          BluetoothSdpGetContainerElementData for this container.
//      ERROR_INVALID_PARAMETER
//          A required pointer is NULL or the container is not a valid SDP
//          stream
// Usage example:
// HBLUETOOTH_CONTAINER_ELEMENT element;
// SDP_ELEMENT_DATA data;
// ULONG result;
// element = NULL;
// while (TRUE) {
//      result = BluetoothSdpGetContainerElementData(
//          pContainer, ulContainerLength, &element, &data);
//      if (result == ERROR_NO_MORE_ITEMS) {
//          // We are done
//          break;
//      }
//      else if (result != ERROR_SUCCESS) {
//          // error
//      }
//      // do something with data ...
// }


function BluetoothSdpGetContainerElementData(pContainerStream: PBYTE; cbContainerLength: ULONG; var pElement: THBLUETOOTH_CONTAINER_ELEMENT;
    out pData: TSDP_ELEMENT_DATA): DWORD; stdcall; external BTHProps_DLL;

// Description:
//      Retrieves the attribute value for the given attribute ID.  pRecordStream
//      must be an SDP stream that is formatted as an SDP record, a SEQUENCE
//      containing UINT16 + element pairs.
// Parameters:
//      IN pRecordStream
//          pointer to a valid SDP stream which is formatted as a singl SDP
//          record
//      IN cbRecordlnegh
//          length of pRecordStream in bytes
//      IN usAttributeId
//          the attribute ID to search for.  see bthdef.h for SDP_ATTRIB_Xxx
//          values.
//      OUT pAttributeData
//          pointer that will contain the attribute ID's value
// Return Values:
//      ERRROR_SUCCESS
//          Call succeeded, pAttributeData contains the attribute value
//      ERROR_INVALID_PARAMETER
//          One of the required pointers was NULL, pRecordStream was not a valid
//          SDP stream, or pRecordStream was not a properly formatted SDP record
//      ERROR_FILE_NOT_FOUND
//          usAttributeId was not found in the record
// Usage:
// ULONG result;
// SDP_DATA_ELEMENT data;
// result = BluetoothSdpGetAttributeValue(
//      pRecordStream, cbRecordLength, SDP_ATTRIB_RECORD_HANDLE, &data);
// if (result == ERROR_SUCCESS) {
//      printf("record handle is $%x\n", data.data.uint32);
// }

function BluetoothSdpGetAttributeValue(pRecordStream: PBYTE; cbRecordLength: ULONG; usAttributeId: USHORT; out pAttributeData: TSDP_ELEMENT_DATA): DWORD;
    stdcall; external BTHProps_DLL;


// These three fields correspond one to one with the triplets defined in the
// SDP specification for the language base attribute ID list.

type
    TSDP_STRING_TYPE_DATA = record
        // How the string is encoded according to ISO 639:1988 (E/F): "Code
        // for the representation of names of languages".
        encoding: USHORT;
        // MIBE number from IANA database
        mibeNum: USHORT;
        // The base attribute where the string is to be found in the record
        attributeId: USHORT;
    end;
    PSDP_STRING_TYPE_DATA = ^TSDP_STRING_TYPE_DATA;

// Description:
//      Converts a raw string embedded in the SDP record into a UNICODE string
// Parameters:
//      IN pRecordStream
//          a valid SDP stream which is formatted as an SDP record
//      IN cbRecordLength
//          length of pRecordStream in bytes
//      IN pStringData
//          if NULL, then the calling thread's locale will be used to search
//          for a matching string in the SDP record.  If not NUL, the mibeNum
//          and attributeId will be used to find the string to convert.
//      IN usStringOffset
//          the SDP string type offset to convert.  usStringOffset is added to
//          the base attribute id of the string.   SDP specification defined
//          offsets are: STRING_NAME_OFFSET, STRING_DESCRIPTION_OFFSET, and
//          STRING_PROVIDER_NAME_OFFSET (found in bthdef.h).
//      OUT pszString
//          if NULL, pcchStringLength will be filled in with the required number
//          of characters (not bytes) to retrieve the converted string.
//      IN OUT pcchStringLength
//          Upon input, if pszString is not NULL, will contain the length of
//          pszString in characters.  Upon output, it will contain either the
//          number of required characters including NULL if an error is returned
//          or the number of characters written to pszString (including NULL).
//  Return Values:
//      ERROR_SUCCES
//          Call was successful and pszString contains the converted string
//      ERROR_MORE_DATA
//          pszString was NULL or too small to contain the converted string,
//          pccxhStringLength contains the required length in characters
//      ERROR_INVALID_DATA
//          Could not perform the conversion
//      ERROR_NO_SYSTEM_RESOURCES
//          Could not allocate memory internally to perform the conversion
//      ERROR_INVALID_PARAMETER
//          One of the rquired pointers was NULL, pRecordStream was not a valid
//          SDP stream, pRecordStream was not a properly formatted record, or
//          the desired attribute + offset was not a string.
//      Other HRESULTs returned by COM


function BluetoothSdpGetString(pRecordStream: PBYTE; cbRecordLength: ULONG; const pStringData: TSDP_STRING_TYPE_DATA;
    usStringOffset: USHORT; out pszString: PWSTR; var pcchStringLength: PULONG): DWORD; stdcall;
    external BTHProps_DLL;

// ***************************************************************************
//  Raw Attribute  Enumeration
// ***************************************************************************

type
    PFN_BLUETOOTH_ENUM_ATTRIBUTES_CALLBACK = function(uAttribId: ULONG; pValueStream: PBYTE; cbStreamSize: ULONG; pvParam: pointer): boolean;
        stdcall;


//  Description:
//      Enumerates through the SDP record stream calling the Callback function
//      for each attribute in the record. If the Callback function returns
//      FALSE, the enumeration is stopped.
//  Return Values:
//      TRUE
//          Success! Something was enumerated.
//      FALSE
//          Failure. GetLastError() could be one of the following:
//          ERROR_INVALID_PARAMETER
//              pSDPStream or pfnCallback is NULL.
//          ERROR_INVALID_DATA
//              The SDP stream is corrupt.
//          other Win32 errors.


function BluetoothSdpEnumAttributes(pSDPStream: PBYTE; cbStreamSize: ULONG; pfnCallback: PFN_BLUETOOTH_ENUM_ATTRIBUTES_CALLBACK; pvParam: pointer): boolean;
    stdcall; external BTHProps_DLL;

function BluetoothEnumAttributes(pSDPStream: PBYTE; cbStreamSize: ULONG; pfnCallback: PFN_BLUETOOTH_ENUM_ATTRIBUTES_CALLBACK; pvParam: pointer): boolean;
    stdcall;
    external BTHProps_DLL Name 'BluetoothSdpEnumAttributes';

{$ENDIF}// (NTDDI_VERSION >= NTDDI_WINXPSP2)

{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}

// The following APIs are only available on Vista or later

function BluetoothSetLocalServiceInfo(hRadioIn: THANDLE; const pClassGuid: TGUID; ulInstance: ULONG;
    const pServiceInfoIn: TBLUETOOTH_LOCAL_SERVICE_INFO): DWORD; stdcall;
    external BTHProps_DLL;

{$ENDIF}// (NTDDI_VERSION >= NTDDI_VISTA)

// Support added in KB942567

{$IF  ((NTDDI_VERSION > NTDDI_VISTASP1) OR ((NTDDI_VERSION = NTDDI_VISTASP1) AND defined(VISTA_KB942567)))}

// IsBluetoothVersionAvailable
// Description:
//      Indicate if the installed Bluetooth binary set supports
//      the requested version
// Return Values:
//      TRUE if the installed bluetooth binaries support the given
//      Major & Minor versions
// Note this function is only exported in version 2.1 and later.

function BluetoothIsVersionAvailable(MajorVersion: UCHAR; MinorVersion: UCHAR): boolean; stdcall; external BTHProps_DLL;

{$ENDIF}// >= SP1+KB942567

{$ENDIF}{ function _FAMILY_PARTITION(function _PARTITION_DESKTOP) }


implementation

end.
