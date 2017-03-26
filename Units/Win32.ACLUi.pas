unit Win32.AclUI;

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

{+--------------------------------------------------------------------------

 Microsoft Windows
 Copyright (c) Microsoft Corporation. All rights reserved.

 File:       aclui.h

 Contents:   Definitions and prototypes for the ACLUI.DLL

---------------------------------------------------------------------------}

{ Header Definition: 10.0.14393.0 }

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}

interface

uses
    Windows, Classes, SysUtils,
    Win32.WTypesBase,
    Win32.WinNT,
    Win32.AccCtrl,Win32.AuthZ,
    Win32.AclAPI, Win32.ObjIdl;

const

    dll_aclui = 'Aclui.dll';

const
    IID_ISecurityInformation: TGUID = '{965FC360-16FF-11d0-91CB-00AA00BBB723}';
    IID_ISecurityInformation2: TGUID = '{c3ccfdb4-6f88-11d2-a3ce-00c04fb1782a}';
    IID_IEffectivePermission: TGUID = '{3853DC76-9F35-407c-88A1-D19344365FBC}';
    IID_ISecurityObjectTypeInfo: TGUID = '{FC3066EB-79EF-444b-9111-D18A75EBF2FA}';
    IID_ISecurityInformation3: TGUID = '{E2CDC9CC-31BD-4f8f-8C8B-B641AF516A1A}';
    IID_ISecurityInformation4: TGUID = '{EA961070-CD14-4621-ACE4-F63C03E583E4}';
    IID_IEffectivePermission2: TGUID = '{941FABCA-DD47-4FCA-90BB-B0E10255F20D}';



type
    HINSTANCE = handle; // Todo


{$IF  DEFINED(WINAPI_PARTITION_DESKTOP)}


// ISecurityInformation interface

//  Methods:

//     GetObjectInformation - Allows UI to determine type of object being
//       edited.  Also allows determining if object is a container.

//     GetSecurity - Allows retrieving of ACLs from the original object
//                       NOTE: ACLUI will LocalFree the security descriptor
//                       returned by GetSecurity.
//     SetSecurity - Allows setting of the ACLs on the original object

//     GetAccessRights - For retrieving the list of rights allowed
//              on this object.

//     MapGeneric - For mapping generic rights to standard & specific rights

//     GetInheritTypes - For retrieving the list of possible sub-object types
//              for a container.

//     PropertySheetCallback - A method which is called back during the various
//              security UI property pages so that specialized work can be
//              done.  Similar to PropSheetPageProc.  If uMsg == PSPCB_CREATE,
//              then any error return value other than E_NOTIMPL will abort
//              the creation of that page.  The type of page being created or
//              destroyed is indicated by the uPage parameter.


type
    TSI_OBJECT_INFO = record
        dwFlags: DWORD;
        hInstance: HINSTANCE;          // resources (e.g. strings) reside here
        pszServerName: LPWSTR;      // must be present
        pszObjectName: LPWSTR;      // must be present
        pszPageTitle: LPWSTR;       // only valid if SI_PAGE_TITLE is set
        guidObjectType: TGUID;     // only valid if SI_OBJECT_GUID is set
    end;
    PSI_OBJECT_INFO = ^TSI_OBJECT_INFO;


// SI_OBJECT_INFO flags
const
    SI_EDIT_PERMS = $00000000; // always implied
    SI_EDIT_OWNER = $00000001;
    SI_EDIT_AUDITS = $00000002;
    SI_CONTAINER = $00000004;
    SI_READONLY = $00000008;
    SI_ADVANCED = $00000010;
    SI_RESET = $00000020; //equals to SI_RESET_DACLor SI_RESET_SACLor SI_RESET_OWNER
    SI_OWNER_READONLY = $00000040;
    SI_EDIT_PROPERTIES = $00000080;
    SI_OWNER_RECURSE = $00000100;
    SI_NO_ACL_PROTECT = $00000200;
    SI_NO_TREE_APPLY = $00000400;
    SI_PAGE_TITLE = $00000800;
    SI_SERVER_IS_DC = $00001000;
    SI_RESET_DACL_TREE = $00004000;
    SI_RESET_SACL_TREE = $00008000;
    SI_OBJECT_GUID = $00010000;
    SI_EDIT_EFFECTIVE = $00020000;
    SI_RESET_DACL = $00040000;
    SI_RESET_SACL = $00080000;
    SI_RESET_OWNER = $00100000;
    SI_NO_ADDITIONAL_PERMISSION = $00200000;
{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
    SI_VIEW_ONLY = $00400000;
    SI_PERMS_ELEVATION_REQUIRED = $01000000;
    SI_AUDITS_ELEVATION_REQUIRED = $02000000;
    SI_OWNER_ELEVATION_REQUIRED = $04000000;

{$IF  (NTDDI_VERSION >= NTDDI_WIN8)}
    SI_SCOPE_ELEVATION_REQUIRED = $08000000;
{$endif}// NTDDI_VERSION >= NTDDI_WIN8

{$endif}// (NTDDI_VERSION >= NTDDI_VISTA)
    SI_MAY_WRITE = $10000000; //not sure if user can write permission

{$IF  (NTDDI_VERSION >= NTDDI_WIN8)}
    SI_ENABLE_EDIT_ATTRIBUTE_CONDITION = $20000000;
    SI_ENABLE_CENTRAL_POLICY = $40000000;
    SI_DISABLE_DENY_ACE = $80000000;
{$endif}// NTDDI_VERSION >= NTDDI_WIN8

    SI_EDIT_ALL = (SI_EDIT_PERMS or SI_EDIT_OWNER or SI_EDIT_AUDITS);


type
    TSI_ACCESS = record
        pguid: PGUID;
        mask: ACCESS_MASK;
        pszName: LPCWSTR;            // may be resource ID
        dwFlags: DWORD;
    end;
    PSI_ACCESS = ^TSI_ACCESS;

// SI_ACCESS flags
const
    SI_ACCESS_SPECIFIC = $00010000;
    SI_ACCESS_GENERAL = $00020000;
    SI_ACCESS_CONTAINER = $00040000; // general access, container-only
    SI_ACCESS_PROPERTY = $00080000;
// ACE inheritance flags (CONTAINER_INHERIT_ACE, etc.) may also be set.
// They will be used as the inheritance when an access is turned on.

type
    TSI_INHERIT_TYPE = record
        pguid: PGUID;
        dwFlags: ULONG;
        pszName: LPCWSTR;            // may be resource ID
    end;
    PSI_INHERIT_TYPE = ^TSI_INHERIT_TYPE;

    // SI_INHERIT_TYPE flags are a combination of INHERIT_ONLY_ACE,
    // CONTAINER_INHERIT_ACE, and OBJECT_INHERIT_ACE.

    // For EditSecurityEx/2, the argument actually takes a UINT
    // The bottom half is SI_PAGE_TYPE, so the enum value for this
    // should never be greater than $0000ffff
    TSI_PAGE_TYPE = (
        SI_PAGE_PERM = 0,
        SI_PAGE_ADVPERM,
        SI_PAGE_AUDIT,
        SI_PAGE_OWNER,
        SI_PAGE_EFFECTIVE,
{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
        SI_PAGE_TAKEOWNERSHIP,
{$endif}// (NTDDI_VERSION >= NTDDI_VISTA)
{$IF  (NTDDI_VERSION >= NTDDI_WIN8)}
        SI_PAGE_SHARE
{$endif}
        );

    // Page types used by the new advanced ACL UI

    TSI_PAGE_ACTIVATED = (
        SI_SHOW_DEFAULT = 0,
        SI_SHOW_PERM_ACTIVATED,
        SI_SHOW_AUDIT_ACTIVATED,
        SI_SHOW_OWNER_ACTIVATED,
        SI_SHOW_EFFECTIVE_ACTIVATED,
        SI_SHOW_SHARE_ACTIVATED,
        SI_SHOW_CENTRAL_POLICY_ACTIVATED);

function GET_PAGE_TYPE(X: uint): UINT;
function GET_ACTIVATION_TYPE(Y: UINT): UINT;
function COMBINE_PAGE_ACTIVATION(X, Y: UINT): UINT;

const
    DOBJ_RES_CONT = $00000001;
    DOBJ_RES_ROOT = $00000002;
    DOBJ_VOL_NTACLS = $00000004;     // NTFS or OFS
    DOBJ_COND_NTACLS = $00000008;     // Conditional aces supported.
    DOBJ_RIBBON_LAUNCH = $00000010;     // Invoked from explorer ribbon.


    // Message to PropertySheetPageCallback (in addition to
    // PSPCB_CREATE and PSPCB_RELEASE)
    PSPCB_SI_INITDIALOG = (WM_USER + 1);



type
    ISecurityInformation = interface(IUnknown)
        ['{965FC360-16FF-11d0-91CB-00AA00BBB723}']
        function GetObjectInformation(out pObjectInfo: TSI_OBJECT_INFO): HResult; stdcall;
        function GetSecurity(RequestedInformation: TSECURITY_INFORMATION; out ppSecurityDescriptor: PSECURITY_DESCRIPTOR;
            fDefault: boolean): HResult; stdcall;
        function SetSecurity(SecurityInformation: TSECURITY_INFORMATION; pSecurityDescriptor: PSECURITY_DESCRIPTOR): HResult;
            stdcall;
        function GetAccessRights(const pguidObjectType: TGUID; dwFlags: DWORD; // SI_EDIT_AUDITS, SI_EDIT_PROPERTIES
            out ppAccess: PSI_ACCESS; out pcAccesses: ULONG; out piDefaultAccess: ULONG): HResult; stdcall;
        function MapGeneric(const pguidObjectType: TGUID; pAceFlags: PUCHAR; const pMask: TACCESS_MASK): HResult; stdcall;
        function GetInheritTypes(out ppInheritTypes: PSI_INHERIT_TYPE; out pcInheritTypes: ULONG): HResult; stdcall;
        function PropertySheetPageCallback(hwnd: HWND; uMsg: UINT; uPage: TSI_PAGE_TYPE): HResult; stdcall;
    end;

    PISecurityInformation = ^ISecurityInformation;

    ISecurityInformation2 = interface(IUnknown)
        ['{c3ccfdb4-6f88-11d2-a3ce-00c04fb1782a}']
        function IsDaclCanonical(pDacl: PACL): boolean; stdcall;
        function LookupSids(cSids: ULONG; rgpSids: PSID; out ppdo: IDataObject): HResult; stdcall;
    end;

    PISecurityInformation2 = ^ISecurityInformation2;



// HGLOBAL containing SID_INFO_LIST returned by ISecurityInformation2::LookupSids
const
    CFSTR_ACLUI_SID_INFO_LIST: WideString = 'CFSTR_ACLUI_SID_INFO_LIST';

type
    // Data structures corresponding to CFSTR_ACLUI_SID_INFO_LIST
    TSID_INFO = record
        pSid: PSID;
        pwzCommonName: PWSTR;
        pwzClass: PWSTR;       // Used for selecting icon, e.g. "User" or "Group"
        pwzUPN: PWSTR;         // Optional, may be NULL
    end;
    PSID_INFO = ^TSID_INFO;

    TSID_INFO_LIST = record
        cItems: ULONG;
        aSidInfo: array [0..ANYSIZE_ARRAY - 1] of TSID_INFO;
    end;
    PSID_INFO_LIST = ^TSID_INFO_LIST;


    IEffectivePermission = interface(IUnknown)
        ['{3853DC76-9F35-407c-88A1-D19344365FBC}']
        function GetEffectivePermission(const pguidObjectType: TGUID; pUserSid: PSID; pszServerName: LPCWSTR;
            pSD: PSECURITY_DESCRIPTOR; out ppObjectTypeList: POBJECT_TYPE_LIST; out pcObjectTypeListLength: ULONG;
            out ppGrantedAccessList: PACCESS_MASK; out pcGrantedAccessListLength: ULONG): HResult; stdcall;
    end;

    PIEffectivePermission = ^IEffectivePermission;

    ISecurityObjectTypeInfo = interface(IUnknown)
        ['{FC3066EB-79EF-444b-9111-D18A75EBF2FA}']
        function GetInheritSource(si: TSECURITY_INFORMATION; pACL: PACL; out ppInheritArray: PINHERITED_FROM): HResult; stdcall;
    end;

    PISecurityObjectTypeInfo = ^ISecurityObjectTypeInfo;

    {$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
    // Support for separation or read-only ACL viewer and elevated ACL editor

    ISecurityInformation3 = interface(IUnknown)
        ['{E2CDC9CC-31BD-4f8f-8C8B-B641AF516A1A}']
        function GetFullResourceName(out ppszResourceName: LPWSTR): HResult; stdcall;
        function OpenElevatedEditor(hWnd: HWND; uPage: TSI_PAGE_TYPE): HResult; stdcall;
    end;

    PISecurityInformation3 = ^ISecurityInformation3;

    {$endif}// (NTDDI_VERSION >= NTDDI_VISTA)

{$IF  (NTDDI_VERSION >= NTDDI_WIN8)}
    TSECURITY_OBJECT = record
        pwszName: PWSTR;
        pData: PByte;
        cbData: DWORD;
        pData2: PByte;
        cbData2: DWORD;
        Id: DWORD;
        fWellKnown: boolean;
    end;
    PSECURITY_OBJECT = ^TSECURITY_OBJECT;

const
    SECURITY_OBJECT_ID_OBJECT_SD = 1;
    SECURITY_OBJECT_ID_SHARE = 2;
    SECURITY_OBJECT_ID_CENTRAL_POLICY = 3;
    SECURITY_OBJECT_ID_CENTRAL_ACCESS_RULE = 4;

type
    TEFFPERM_RESULT_LIST = record
        fEvaluated: boolean;
        cObjectTypeListLength: ULONG;
        pObjectTypeList: POBJECT_TYPE_LIST;
        pGrantedAccessList: PACCESS_MASK;
    end;
    PEFFPERM_RESULT_LIST = ^TEFFPERM_RESULT_LIST;


    ISecurityInformation4 = interface(IUnknown)
        ['{EA961070-CD14-4621-ACE4-F63C03E583E4}']
        function GetSecondarySecurity(out pSecurityObjects: PSECURITY_OBJECT; out pSecurityObjectCount: ULONG): HResult;
            stdcall;
    end;

    PISecurityInformation4 = ^ISecurityInformation4;



    IEffectivePermission2 = interface(IUnknown)
        ['{941FABCA-DD47-4FCA-90BB-B0E10255F20D}']
        function ComputeEffectivePermissionWithSecondarySecurity(pSid: PSID; pDeviceSid: PSID; pszServerName: PCWSTR;
            var pSecurityObjects: PSECURITY_OBJECT; dwSecurityObjectCount: DWORD; pUserGroups: PTOKEN_GROUPS;
            pAuthzUserGroupsOperations: PAUTHZ_SID_OPERATION; pDeviceGroups: PTOKEN_GROUPS; pAuthzDeviceGroupsOperations: PAUTHZ_SID_OPERATION;
            pAuthzUserClaims: PAUTHZ_SECURITY_ATTRIBUTES_INFORMATION; pAuthzUserClaimsOperations: PAUTHZ_SECURITY_ATTRIBUTE_OPERATION;
            pAuthzDeviceClaims: PAUTHZ_SECURITY_ATTRIBUTES_INFORMATION; pAuthzDeviceClaimsOperations: PAUTHZ_SECURITY_ATTRIBUTE_OPERATION;
            var pEffpermResultLists: PEFFPERM_RESULT_LIST): HRESULT; stdcall;
    end;

    PIEffectivePermission2 = ^IEffectivePermission2;

{$endif}// (NTDDI_VERSION >= NTDDI_WIN8)

function CreateSecurityPage(psi: LPSECURITYINFO): HPROPSHEETPAGE; stdcall; external dll_aclui;
function EditSecurity(hwndOwner: HWND; psi: LPSECURITYINFO): boolean; stdcall; external dll_aclui;

{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
function EditSecurityAdvanced(hwndOwner: HWND; psi: LPSECURITYINFO; uSIPage: TSI_PAGE_TYPE): HRESULT; stdcall; external dll_aclui;
{$endif}// (NTDDI_VERSION >= NTDDI_VISTA)




{$endif}{ DEFINED(WINAPI_PARTITION_DESKTOP) }

implementation

function GET_PAGE_TYPE(X: uint): UINT;
begin
    Result := (X and $0000ffff);
end;

function GET_ACTIVATION_TYPE(Y: UINT): UINT;
begin
    Result := ((Y shr 16) and $0000ffff);
end;

function COMBINE_PAGE_ACTIVATION(X, Y: UINT): UINT;
begin
    Result := ((Y shl 16) or X);
end;

end.




























