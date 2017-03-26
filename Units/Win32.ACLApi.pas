unit Win32.AclAPI;

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

{++ BUILD Version: 0001    // Increment this if a change has global effects

Copyright (c) 1993-1999:       ; Microsoft Corporation

Module Name:

    aclapi.h

Abstract:

    Public
    Structure/constant definitions and typedefines for the Win32 Access
    Control APIs

--}

{ Header Definition: 10.0.14393.0 }

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}

interface

uses
    Classes, SysUtils,
    Windows,
    Win32.AccCtrl;

const

    dll_advapi = 'Advapi32.dll';


type
    TACCESS_MASK = DWORD; (* from WinNT.h *)
    PACCESS_MASK = ^TACCESS_MASK;
    TSECURITY_INFORMATION = DWORD;
    PSECURITY_INFORMATION = ^TSECURITY_INFORMATION;

    PSECURITY_DESCRIPTOR = pointer;

{$IF (DEFINED(WINAPI_PARTITION_DESKTOP) or DEFINED(WINAPI_PARTITION_SYSTEM))}
type

    // Progress Function:
    // Caller of tree operation implements this Progress function, then
    // passes its function pointer to tree operation.
    // Tree operation invokes Progress function to provide progress and error
    // information to the caller during the potentially long execution
    // of the tree operation.  Tree operation provides the name of the object
    // last processed and the error status of the operation on that object.
    // Tree operation also passes the current InvokeSetting value.
    // Caller may change the InvokeSetting value, for example, from "Always"
    // to "Only On Error."


    FN_PROGRESS = procedure(pObjectName: LPWSTR;
        // name of object just processed
        Status: DWORD;         // status of operation on object
        var pInvokeSetting: TPROG_INVOKE_SETTING; // Never, always,
        Args: Pointer;           // Caller specific data
        SecuritySet: boolean     // Whether security was set
        );


function SetEntriesInAclA(cCountOfExplicitEntries: ULONG; pListOfExplicitEntries: PEXPLICIT_ACCESS_A; OldAcl: PACL; out NewAcl: PACL): DWORD;
    stdcall; external dll_advapi;

function SetEntriesInAclW(cCountOfExplicitEntries: ULONG; pListOfExplicitEntries: PEXPLICIT_ACCESS_W; OldAcl: PACL; out NewAcl: PACL): DWORD;
    stdcall; external dll_advapi;



function GetExplicitEntriesFromAclA(pacl: PACL; out pcCountOfExplicitEntries: ULONG; out pListOfExplicitEntries: PEXPLICIT_ACCESS_A): DWORD;
    stdcall; external dll_advapi;


function GetExplicitEntriesFromAclW(pacl: PACL; out pcCountOfExplicitEntries: ULONG; out pListOfExplicitEntries: PEXPLICIT_ACCESS_W): DWORD;
    stdcall; external dll_advapi;


{$ENDIF}{ WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP | WINAPI_PARTITION_SYSTEM) }

{$IF DEFINED(WINAPI_PARTITION_DESKTOP)}

function GetEffectiveRightsFromAclA(pacl: PACL; const pTrustee: TTRUSTEE_A; out pAccessRights: TACCESS_MASK): DWORD; stdcall; external dll_advapi;

function GetEffectiveRightsFromAclW(pacl: PACL; const pTrustee: TTRUSTEE_W; out pAccessRights: TACCESS_MASK): DWORD; stdcall; external dll_advapi;

function GetAuditedPermissionsFromAclA(pacl: PACL; const pTrustee: TTRUSTEE_A; out pSuccessfulAuditedRights: TACCESS_MASK;
    out pFailedAuditRights: TACCESS_MASK): DWORD; stdcall; external dll_advapi;


function GetAuditedPermissionsFromAclW(pacl: PACL; const pTrustee: TTRUSTEE_W; out pSuccessfulAuditedRights: TACCESS_MASK;
    out pFailedAuditRights: TACCESS_MASK): DWORD; stdcall; external dll_advapi;


{$ENDIF}{ WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) }


{$IF (DEFINED(WINAPI_PARTITION_DESKTOP) or DEFINED(WINAPI_PARTITION_SYSTEM))}
function GetNamedSecurityInfoA(pObjectName: LPCSTR; ObjectType: TSE_OBJECT_TYPE; SecurityInfo: TSECURITY_INFORMATION;
    out ppsidOwner: TSID; out ppsidGroup: TSID; out ppDacl: TACL; out ppSacl: TACL; out ppSecurityDescriptor: PSECURITY_DESCRIPTOR): DWORD;
    stdcall; external dll_advapi;


function GetNamedSecurityInfoW(pObjectName: LPCWSTR; ObjectType: TSE_OBJECT_TYPE; SecurityInfo: TSECURITY_INFORMATION;
    out ppsidOwner: TSID; out ppsidGroup: TSID; out ppDacl: TACL; out ppSacl: TACL; out ppSecurityDescriptor: PSECURITY_DESCRIPTOR): DWORD;
    stdcall; external dll_advapi;


function GetSecurityInfo(handle: HANDLE; ObjectType: TSE_OBJECT_TYPE; SecurityInfo: TSECURITY_INFORMATION; out ppsidOwner: PSID;
    out ppsidGroup: PSID; out ppDacl: TACL; out ppSacl: TACL; out ppSecurityDescriptor: PSECURITY_DESCRIPTOR): DWORD; stdcall; external dll_advapi;


function SetNamedSecurityInfoA(pObjectName: LPSTR; ObjectType: TSE_OBJECT_TYPE; SecurityInfo: TSECURITY_INFORMATION;
    psidOwner: PSID; psidGroup: PSID; pDacl: PACL; pSacl: PACL): DWORD; stdcall; external dll_advapi;


function SetNamedSecurityInfoW(pObjectName: LPWSTR; ObjectType: TSE_OBJECT_TYPE; SecurityInfo: TSECURITY_INFORMATION;
    psidOwner: PSID; psidGroup: PSID; pDacl: PACL; pSacl: PACL): DWORD; stdcall; external dll_advapi;


function SetSecurityInfo(handle: HANDLE; ObjectType: TSE_OBJECT_TYPE; SecurityInfo: TSECURITY_INFORMATION; psidOwner: PSID;
    psidGroup: PSID; pDacl: PACL; pSacl: PACL): DWORD; stdcall; external dll_advapi;

{$ENDIF}{ WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP | WINAPI_PARTITION_SYSTEM) }

{$IF  DEFINED(WINAPI_PARTITION_DESKTOP)}
function GetInheritanceSourceA(pObjectName: LPSTR; ObjectType: TSE_OBJECT_TYPE; SecurityInfo: TSECURITY_INFORMATION;
    Container: boolean; pObjectClassGuids: PGUID; GuidCount: DWORD; pAcl: PACL; pfnArray: PFN_OBJECT_MGR_FUNCTS;
    pGenericMapping: PGENERIC_MAPPING; out pInheritArray: PINHERITED_FROMA): DWORD; stdcall; external dll_advapi;


function GetInheritanceSourceW(pObjectName: LPWSTR; ObjectType: TSE_OBJECT_TYPE; SecurityInfo: TSECURITY_INFORMATION;
    Container: boolean; pObjectClassGuids: PGUID; GuidCount: DWORD; pAcl: PACL; pfnArray: PFN_OBJECT_MGR_FUNCTS;
    pGenericMapping: PGENERIC_MAPPING; out pInheritArray: PINHERITED_FROMW): DWORD; stdcall; external dll_advapi;


function FreeInheritedFromArray(pInheritArray: PINHERITED_FROMW; AceCnt: USHORT; pfnArray: PFN_OBJECT_MGR_FUNCTS): DWORD; stdcall; external dll_advapi;


function TreeResetNamedSecurityInfoA(pObjectName: LPSTR; ObjectType: TSE_OBJECT_TYPE; SecurityInfo: TSECURITY_INFORMATION;
    pOwner: PSID; pGroup: PSID; pDacl: PACL; pSacl: PACL; KeepExplicit: boolean; fnProgress: FN_PROGRESS;
    ProgressInvokeSetting: TPROG_INVOKE_SETTING; Args: pointer): DWORD; stdcall; external dll_advapi;


function TreeResetNamedSecurityInfoW(pObjectName: LPWSTR; ObjectType: TSE_OBJECT_TYPE; SecurityInfo: TSECURITY_INFORMATION;
    pOwner: PSID; pGroup: PSID; pDacl: PACL; pSacl: PACL; KeepExplicit: boolean; fnProgress: FN_PROGRESS;
    ProgressInvokeSetting: TPROG_INVOKE_SETTING; Args: pointer): DWORD; stdcall; external dll_advapi;




{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
function TreeSetNamedSecurityInfoA(pObjectName: LPSTR; ObjectType: TSE_OBJECT_TYPE; SecurityInfo: TSECURITY_INFORMATION;
    pOwner: PSID; pGroup: PSID; pDacl: PACL; pSacl: PACL; dwAction: DWORD; fnProgress: FN_PROGRESS; ProgressInvokeSetting: TPROG_INVOKE_SETTING;
    Args: pointer): DWORD; stdcall; external dll_advapi;


function TreeSetNamedSecurityInfoW(pObjectName: LPWSTR; ObjectType: TSE_OBJECT_TYPE; SecurityInfo: TSECURITY_INFORMATION;
    pOwner: PSID; pGroup: PSID; pDacl: PACL; pSacl: PACL; dwAction: DWORD; fnProgress: FN_PROGRESS; ProgressInvokeSetting: TPROG_INVOKE_SETTING;
    Args: pointer): DWORD; stdcall; external dll_advapi;

{$ENDIF}// (NTDDI_VERSION >= NTDDI_VISTA)




//----------------------------------------------------------------------------
// The following API are provided for trusted servers to use to
// implement access control on their own objects.
//----------------------------------------------------------------------------



function BuildSecurityDescriptorA(pOwner: PTRUSTEE_A; pGroup: PTRUSTEE_A; cCountOfAccessEntries: ULONG;
    pListOfAccessEntries: PEXPLICIT_ACCESS_A; cCountOfAuditEntries: ULONG; pListOfAuditEntries: PEXPLICIT_ACCESS_A;
    pOldSD: PSECURITY_DESCRIPTOR; out pSizeNewSD: ULONG; out pNewSD: PSECURITY_DESCRIPTOR): DWORD; stdcall; external dll_advapi;


function BuildSecurityDescriptorW(pOwner: PTRUSTEE_W; pGroup: PTRUSTEE_W; cCountOfAccessEntries: ULONG;
    pListOfAccessEntries: PEXPLICIT_ACCESS_W; cCountOfAuditEntries: ULONG; pListOfAuditEntries: PEXPLICIT_ACCESS_W;
    pOldSD: PSECURITY_DESCRIPTOR; out pSizeNewSD: ULONG; out pNewSD: PSECURITY_DESCRIPTOR): DWORD; stdcall; external dll_advapi;




function LookupSecurityDescriptorPartsA(out ppOwner: PTRUSTEE_A; out ppGroup: PTRUSTEE_A; out pcCountOfAccessEntries: ULONG;
    out ppListOfAccessEntries: PEXPLICIT_ACCESS_A; out pcCountOfAuditEntries: ULONG; out ppListOfAuditEntries: PEXPLICIT_ACCESS_A;
    pSD: PSECURITY_DESCRIPTOR): DWORD; stdcall; external dll_advapi;


function LookupSecurityDescriptorPartsW(out ppOwner: PTRUSTEE_W; out ppGroup: PTRUSTEE_W; out pcCountOfAccessEntries: ULONG;
    out ppListOfAccessEntries: PEXPLICIT_ACCESS_W; out pcCountOfAuditEntries: ULONG; out ppListOfAuditEntries: PEXPLICIT_ACCESS_W;
    pSD: PSECURITY_DESCRIPTOR): DWORD; stdcall; external dll_advapi;



//----------------------------------------------------------------------------
// The following helper API are provided for building
// access control structures.
//----------------------------------------------------------------------------


procedure BuildExplicitAccessWithNameA(var pExplicitAccess: TEXPLICIT_ACCESS_A; pTrusteeName: LPSTR; AccessPermissions: DWORD;
    AccessMode: TACCESS_MODE; Inheritance: DWORD); stdcall; external dll_advapi;

procedure BuildExplicitAccessWithNameW(var pExplicitAccess: TEXPLICIT_ACCESS_W; pTrusteeName: LPWSTR; AccessPermissions: DWORD;
    AccessMode: TACCESS_MODE; Inheritance: DWORD); stdcall; external dll_advapi;

procedure BuildImpersonateExplicitAccessWithNameA(var pExplicitAccess: TEXPLICIT_ACCESS_A; pTrusteeName: LPSTR;
    const pTrustee: TTRUSTEE_A; AccessPermissions: DWORD; AccessMode: TACCESS_MODE; Inheritance: DWORD); stdcall; external dll_advapi;

procedure BuildImpersonateExplicitAccessWithNameW(var pExplicitAccess: TEXPLICIT_ACCESS_W; pTrusteeName: LPWSTR;
    const pTrustee: TTRUSTEE_W; AccessPermissions: DWORD; AccessMode: TACCESS_MODE; Inheritance: DWORD); stdcall; external dll_advapi;

procedure BuildTrusteeWithNameA(var pTrustee: TTRUSTEE_A; pName: LPSTR); stdcall; external dll_advapi;

procedure BuildTrusteeWithNameW(var pTrustee: TTRUSTEE_W; pName: LPWSTR); stdcall; external dll_advapi;

procedure BuildImpersonateTrusteeA(var pTrustee: TTRUSTEE_A; const pImpersonateTrustee: TTRUSTEE_A); stdcall; external dll_advapi;

procedure BuildImpersonateTrusteeW(var pTrustee: TTRUSTEE_W; const pImpersonateTrustee: TTRUSTEE_W); stdcall; external dll_advapi;

procedure BuildTrusteeWithSidA(var pTrustee: TTRUSTEE_A; pSid: PSID); stdcall; external dll_advapi;

procedure BuildTrusteeWithSidW(var pTrustee: TTRUSTEE_W; pSid: PSID); stdcall; external dll_advapi;


procedure BuildTrusteeWithObjectsAndSidA(var pTrustee: TTRUSTEE_A; const pObjSid: TOBJECTS_AND_SID; const pObjectGuid: TGUID;
    const pInheritedObjectGuid: TGUID; pSid: PSID); stdcall; external dll_advapi;

procedure BuildTrusteeWithObjectsAndSidW(var pTrustee: TTRUSTEE_W; const pObjSid: TOBJECTS_AND_SID; const pObjectGuid: TGUID;
    const pInheritedObjectGuid: TGUID; pSid: PSID); stdcall;
    external dll_advapi;

procedure BuildTrusteeWithObjectsAndNameA(var pTrustee: TTRUSTEE_A; const pObjName: TOBJECTS_AND_NAME_A; ObjectType: SE_OBJECT_TYPE;
    ObjectTypeName: LPSTR; InheritedObjectTypeName: LPSTR; Name: LPSTR); stdcall; external dll_advapi;

procedure BuildTrusteeWithObjectsAndNameW(var pTrustee: TTRUSTEE_W; const pObjName: TOBJECTS_AND_NAME_W; ObjectType: TSE_OBJECT_TYPE;
    ObjectTypeName: LPWSTR; InheritedObjectTypeName: LPWSTR; Name: LPWSTR); stdcall; external dll_advapi;

function GetTrusteeNameA(const pTrustee: TTRUSTEE_A): LPSTR; stdcall; external dll_advapi;

function GetTrusteeNameW(const pTrustee: TTRUSTEE_W): LPWSTR; stdcall; external dll_advapi;

function GetTrusteeTypeA(const pTrustee: TTRUSTEE_A): TTRUSTEE_TYPE; stdcall; external dll_advapi;

function GetTrusteeTypeW(const pTrustee: TTRUSTEE_W): TTRUSTEE_TYPE; stdcall; external dll_advapi;

function GetTrusteeFormA(const pTrustee: TTRUSTEE_A): TTRUSTEE_FORM; stdcall; external dll_advapi;

function GetTrusteeFormW(const pTrustee: TTRUSTEE_W): TTRUSTEE_FORM; stdcall; external dll_advapi;

function GetMultipleTrusteeOperationA(const pTrustee: TTRUSTEE_A): TMULTIPLE_TRUSTEE_OPERATION; stdcall; external dll_advapi;

function GetMultipleTrusteeOperationW(const pTrustee: TTRUSTEE_W): TMULTIPLE_TRUSTEE_OPERATION; stdcall; external dll_advapi;

function GetMultipleTrusteeA(const pTrustee: TTRUSTEE_A): TTRUSTEE_A; stdcall; external dll_advapi;

function GetMultipleTrusteeW(const pTrustee: TTRUSTEE_W): TTRUSTEE_W; stdcall; external dll_advapi;


{$ENDIF}{ WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) }

implementation

end.
