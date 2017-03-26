unit Win32.AccCtrl;

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

{+-------------------------------------------------------------------

 Microsoft Windows
 Copyright (C) Microsoft Corporation, 1993-1998.

 File:       accctrl.h

 Contents:   common includes for new style Win32 Access Control
             APIs


--------------------------------------------------------------------}

{ Header Definition: 10.0.14393.0 }

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}

interface

uses
    Classes, SysUtils,
    Windows,
    Win32.WinBase,
    Win32.WTypesBase;

{$IF DEFINED(WINAPI_PARTITION_DESKTOP)}
{$HINT we use Win32.AccCtrl }

function AccFree(hMem: HLOCAL): HLOCAL; stdcall;

type

    // Definition:
    // This enumerated type defines the objects supported by the get/set API within
    // this document.  See section 3.1, Object Types for a detailed definition of the
    // supported object types, and their name formats.

    TSE_OBJECT_TYPE = (
        SE_UNKNOWN_OBJECT_TYPE = 0,
        SE_FILE_OBJECT,
        SE_SERVICE,
        SE_PRINTER,
        SE_REGISTRY_KEY,
        SE_LMSHARE,
        SE_KERNEL_OBJECT,
        SE_WINDOW_OBJECT,
        SE_DS_OBJECT,
        SE_DS_OBJECT_ALL,
        SE_PROVIDER_DEFINED_OBJECT,
        SE_WMIGUID_OBJECT,
        SE_REGISTRY_WOW64_32KEY,
        SE_REGISTRY_WOW64_64KEY);


    // Definition: TRUSTEE_TYPE
    // This enumerated type specifies the type of trustee account for the trustee
    // returned by the API described in this document.
    // TRUSTEE_IS_UNKNOWN - The trustee is an unknown, but not necessarily invalid
    //                      type.  This field is not validated on input to the APIs
    //                      that take Trustees.
    // TRUSTEE_IS_USER      The trustee account is a user account.
    // TRUSTEE_IS_GROUP     The trustee account is a group account.


    TTRUSTEE_TYPE = (
        TRUSTEE_IS_UNKNOWN,
        TRUSTEE_IS_USER,
        TRUSTEE_IS_GROUP,
        TRUSTEE_IS_DOMAIN,
        TRUSTEE_IS_ALIAS,
        TRUSTEE_IS_WELL_KNOWN_GROUP,
        TRUSTEE_IS_DELETED,
        TRUSTEE_IS_INVALID,
        TRUSTEE_IS_COMPUTER);



    // Definition: TRUSTEE_FORM
    // This enumerated type specifies the form the trustee identifier is in for a
    // particular trustee.
    // TRUSTEE_IS_SID       The trustee is identified with a SID rather than with a name.
    // TRUSTEE_IS_NAME      The trustee is identified with a name.


    TTRUSTEE_FORM = (
        TRUSTEE_IS_SID,
        TRUSTEE_IS_NAME,
        TRUSTEE_BAD_FORM,
        TRUSTEE_IS_OBJECTS_AND_SID,
        TRUSTEE_IS_OBJECTS_AND_NAME);



    // Definition: MULTIPLE_TRUSTEE_OPERATION
    // If the trustee is a multiple trustee, this enumerated type specifies the type.
    // TRUSTEE_IS_IMPERSONATE       The trustee is an impersonate trustee and the multiple
    //                          trustee field in the trustee points to another trustee
    //                          that is a trustee for the server that will be doing the
    //                          impersonation.


    TMULTIPLE_TRUSTEE_OPERATION = (
        NO_MULTIPLE_TRUSTEE,
        TRUSTEE_IS_IMPERSONATE);



    TOBJECTS_AND_SID = record
        ObjectsPresent: DWORD;
        ObjectTypeGuid: TGUID;
        InheritedObjectTypeGuid: TGUID;
        pSid: PSID;
    end;
    POBJECTS_AND_SID = ^TOBJECTS_AND_SID;

    TOBJECTS_AND_NAME_A = record
        ObjectsPresent: DWORD;
        ObjectType: TSE_OBJECT_TYPE;
        ObjectTypeName: LPSTR;
        InheritedObjectTypeName: LPSTR;
        ptstrName: LPSTR;
    end;
    POBJECTS_AND_NAME_A = ^TOBJECTS_AND_NAME_A;

    TOBJECTS_AND_NAME_W = record
        ObjectsPresent: DWORD;
        ObjectType: TSE_OBJECT_TYPE;
        ObjectTypeName: LPWSTR;
        InheritedObjectTypeName: LPWSTR;
        ptstrName: LPWSTR;
    end;
    POBJECTS_AND_NAME_W = ^TOBJECTS_AND_NAME_W;


    // Definition: TRUSTEE
    // This structure is used to pass account information into and out of the system
    // using the API defined in this document.
    // PMultipleTrustee     - if NON-NULL, points to another trustee structure, as
    //                    defined by the multiple trustee operation field.
    // MultipleTrusteeOperation - Defines the multiple trustee operation/type.
    // TrusteeForm - defines if the trustee is defined by name or SID.
    // TrusteeType - defines if the trustee type is unknown, a user or a group.
    // PwcsName     - points to the trustee name or the trustee SID.



    PTRUSTEE_A = ^TTRUSTEE_A;

    TTRUSTEE_A = record
        pMultipleTrustee: PTRUSTEE_A;
        MultipleTrusteeOperation: TMULTIPLE_TRUSTEE_OPERATION;
        TrusteeForm: TTRUSTEE_FORM;
        TrusteeType: TTRUSTEE_TYPE;

        case integer of
            TRUSTEE_IS_NAME: (
                ptstrName: LPSTR);
            TRUSTEE_IS_SID: (
                pSid: PSID);
            TRUSTEE_IS_OBJECTS_AND_SID: (
                pObjectsAndSid: POBJECTS_AND_SID);
            TRUSTEE_IS_OBJECTS_AND_NAME: (
                pObjectsAndName: POBJECTS_AND_NAME_A);
    end;

    TRUSTEEA = TTRUSTEE_A;
    PTRUSTEEA = ^TRUSTEEA;

    PTRUSTEE_W = ^TTRUSTEE_W;

    TTRUSTEE_W = record
        pMultipleTrustee: PTRUSTEE_W;
        MultipleTrusteeOperation: TMULTIPLE_TRUSTEE_OPERATION;
        TrusteeForm: TTRUSTEE_FORM;
        TrusteeType: TTRUSTEE_TYPE;

        case integer of
            TRUSTEE_IS_NAME: (
                ptstrName: LPWSTR);
            TRUSTEE_IS_SID: (
                pSid: PSID);
            TRUSTEE_IS_OBJECTS_AND_SID: (
                pObjectsAndSid: POBJECTS_AND_SID);
            TRUSTEE_IS_OBJECTS_AND_NAME: (
                pObjectsAndName: POBJECTS_AND_NAME_W);
    end;

    TTRUSTEEW = TTRUSTEE_W;
    PTRUSTEEW = ^TTRUSTEEW;




    // Definition: ACCESS_MODE
    // This enumerated type specifies how permissions are (requested)/to be applied
    //  for the trustee by the access control entry.  On input this field can by any
    //  of the values, although it is not meaningful to mix access control and audit
    //  control entries.  On output this field will be either SET_ACCESS, DENY_ACCESS,
    // SET_AUDIT_SUCCESS, SET_AUDIT_FAILURE.
    // The following descriptions define how this type effects an explicit access
    // request to apply access permissions to an object.
    // GRANT_ACCESS - The trustee will have at least the requested permissions upon
    //                successful completion of the command. (If the trustee has
    //                additional permissions they will not be removed).
    // SET_ACCESS - The trustee will have exactly the requested permissions upon
    //              successful completion of the command.
    // DENY_ACCESS - The trustee will be denied the specified permissions.
    // REVOKE_ACCESS - Any explicit access rights the trustee has will be revoked.
    // SET_AUDIT_SUCCESS - The trustee will be audited for successful opens of the
    //                     object using the requested permissions.
    // SET_AUDIT_FAILURE - The trustee will be audited for failed opens of the object
    //                     using the requested permissions.


    TACCESS_MODE = (
        NOT_USED_ACCESS = 0,
        GRANT_ACCESS,
        SET_ACCESS,
        DENY_ACCESS,
        REVOKE_ACCESS,
        SET_AUDIT_SUCCESS,
        SET_AUDIT_FAILURE);


// Definition: Inheritance flags
// These bit masks are provided to allow simple application of inheritance in
// explicit access requests on containers.
// NO_INHERITANCE       The specific access permissions will only be applied to
//                  the container, and will not be inherited by objects created
//                  within the container.
// SUB_CONTAINERS_ONLY_INHERIT  The specific access permissions will be inherited
//                              and applied to sub containers created within the
//                              container, and will be applied to the container
//                              itself.
// SUB_OBJECTS_ONLY_INHERIT     The specific access permissions will only be inherited
//                              by objects created within the specific container.
//                              The access permissions will not be applied to the
//                              container itself.
// SUB_CONTAINERS_AND_OBJECTS_INHERIT   The specific access permissions will be
//                                      inherited by containers created within the
//                                      specific container, will be applied to
//                                      objects created within the container, but
//                                      will not be applied to the container itself.

const
    NO_INHERITANCE = $0;
    SUB_OBJECTS_ONLY_INHERIT = $1;
    SUB_CONTAINERS_ONLY_INHERIT = $2;
    SUB_CONTAINERS_AND_OBJECTS_INHERIT = $3;
    INHERIT_NO_PROPAGATE = $4;
    INHERIT_ONLY = $8;


    // Informational bit that is returned

    INHERITED_ACCESS_ENTRY = $10;


    // Informational bit that tells where a node was inherited from.  Valid only
    // for NT 5 APIs

    INHERITED_PARENT = $10000000;
    INHERITED_GRANDPARENT = $20000000;


type

    // Definition: EXPLICIT_ACCESS
    // This structure is used to pass access control entry information into and out
    // of the system using the API defined in this document.
    // grfAccessPermissions - This contains the access permissions to assign for the
    //                     trustee.  It is in the form of an NT access mask.
    // grfAccessMode - This field defines how the permissions are to be applied for
    //                 the trustee.
    // grfInheritance - For containers, this field defines how the access control
    //                  entry is/(is requested) to be inherited on
    //                  objects/sub-containers created within the container.
    // Trustee - This field contains the definition of the trustee account the
    //           explicit access applies to.



    TEXPLICIT_ACCESS_A = record
        grfAccessPermissions: DWORD;
        grfAccessMode: TACCESS_MODE;
        grfInheritance: DWORD;
        Trustee: TTRUSTEE_A;
    end;
    PEXPLICIT_ACCESS_A = ^TEXPLICIT_ACCESS_A;
    TEXPLICIT_ACCESSA = TEXPLICIT_ACCESS_A;
    PEXPLICIT_ACCESSA = ^TEXPLICIT_ACCESSA;

    TEXPLICIT_ACCESS_W = record
        grfAccessPermissions: DWORD;
        grfAccessMode: TACCESS_MODE;
        grfInheritance: DWORD;
        Trustee: TTRUSTEE_W;
    end;
    PEXPLICIT_ACCESS_W = ^TEXPLICIT_ACCESS_W;
    TEXPLICIT_ACCESSW = TEXPLICIT_ACCESS_W;
    PEXPLICIT_ACCESSW = ^TEXPLICIT_ACCESSW;


//----------------------------------------------------------------------------

//                                  NT5 APIs

//----------------------------------------------------------------------------


// Default provider

const
    ACCCTRL_DEFAULT_PROVIDERA: PChar = 'Windows NT Access Provider';
    ACCCTRL_DEFAULT_PROVIDERW: PWChar = 'Windows NT Access Provider';

type

    /// Access rights

    TACCESS_RIGHTS = ULONG;
    PACCESS_RIGHTS = ^TACCESS_RIGHTS;


    // Inheritance flags

    TINHERIT_FLAGS = ULONG;
    PINHERIT_FLAGS = ^TINHERIT_FLAGS;



    // Access / Audit structures

    TACTRL_ACCESS_ENTRYA = record
        Trustee: TTRUSTEE_A;
        fAccessFlags: ULONG;
        Access: TACCESS_RIGHTS;
        ProvSpecificAccess: TACCESS_RIGHTS;
        Inheritance: TINHERIT_FLAGS;
        lpInheritProperty: LPSTR;
    end;
    PACTRL_ACCESS_ENTRYA = ^TACTRL_ACCESS_ENTRYA;

    // Access / Audit structures

    TACTRL_ACCESS_ENTRYW = record
        Trustee: TTRUSTEE_W;
        fAccessFlags: ULONG;
        Access: TACCESS_RIGHTS;
        ProvSpecificAccess: TACCESS_RIGHTS;
        Inheritance: TINHERIT_FLAGS;
        lpInheritProperty: LPWSTR;
    end;
    PACTRL_ACCESS_ENTRYW = ^TACTRL_ACCESS_ENTRYW;




    TACTRL_ACCESS_ENTRY_LISTA = record
        cEntries: ULONG;
        pAccessList: PACTRL_ACCESS_ENTRYA;
    end;

    PACTRL_ACCESS_ENTRY_LISTA = ^TACTRL_ACCESS_ENTRY_LISTA;

    TACTRL_ACCESS_ENTRY_LISTW = record
        cEntries: ULONG;
        pAccessList: PACTRL_ACCESS_ENTRYW;
    end;
    PACTRL_ACCESS_ENTRY_LISTW = ^TACTRL_ACCESS_ENTRY_LISTW;


    TACTRL_PROPERTY_ENTRYA = record
        lpProperty: LPSTR;
        pAccessEntryList: PACTRL_ACCESS_ENTRY_LISTA;
        fListFlags: ULONG;
    end;
    PACTRL_PROPERTY_ENTRYA = ^TACTRL_PROPERTY_ENTRYA;

    TACTRL_PROPERTY_ENTRYW = record
        lpProperty: LPWSTR;
        pAccessEntryList: PACTRL_ACCESS_ENTRY_LISTW;
        fListFlags: ULONG;
    end;
    PACTRL_PROPERTY_ENTRYW = ^TACTRL_PROPERTY_ENTRYW;


    TACTRL_ALISTA = record
        cEntries: ULONG;
        pPropertyAccessList: PACTRL_PROPERTY_ENTRYA;
    end;
    PACTRL_ALISTA = ^TACTRL_ALISTA;
    TACTRL_ACCESSA = TACTRL_ALISTA;
    PACTRL_ACCESSA = ^TACTRL_ACCESSA;
    TACTRL_AUDITA = TACTRL_ACCESSA;
    PACTRL_AUDITA = ^TACTRL_AUDITA;

    TACTRL_ALISTW = record
        cEntries: ULONG;
        pPropertyAccessList: PACTRL_PROPERTY_ENTRYW;
    end;
    PACTRL_ALISTW = ^TACTRL_ALISTW;
    TACTRL_ACCESSW = TACTRL_ALISTW;
    PACTRL_ACCESSW = ^TACTRL_ACCESSW;
    TACTRL_AUDITW = TACTRL_ACCESSW;
    PACTRL_AUDITW = ^TACTRL_AUDITW;


// TRUSTEE_ACCESS flags

const
    TRUSTEE_ACCESS_ALLOWED = $00000001;
    TRUSTEE_ACCESS_READ = $00000002;
    TRUSTEE_ACCESS_WRITE = $00000004;

    TRUSTEE_ACCESS_EXPLICIT = $00000001;
    TRUSTEE_ACCESS_READ_WRITE = (TRUSTEE_ACCESS_READ or TRUSTEE_ACCESS_WRITE);

    TRUSTEE_ACCESS_ALL = $FFFFFFFF;

type
    TTRUSTEE_ACCESSA = record
        lpProperty: LPSTR;
        Access: TACCESS_RIGHTS;
        fAccessFlags: ULONG;
        fReturnedAccess: ULONG;
    end;
    PTRUSTEE_ACCESSA = ^TTRUSTEE_ACCESSA;

    TTRUSTEE_ACCESSW = record
        lpProperty: LPWSTR;
        Access: TACCESS_RIGHTS;
        fAccessFlags: ULONG;
        fReturnedAccess: ULONG;
    end;
    PTRUSTEE_ACCESSW = ^TTRUSTEE_ACCESSW;



const

    // Generic permission values

    ACTRL_RESERVED = $00000000;
    ACTRL_PERM_1 = $00000001;
    ACTRL_PERM_2 = $00000002;
    ACTRL_PERM_3 = $00000004;
    ACTRL_PERM_4 = $00000008;
    ACTRL_PERM_5 = $00000010;
    ACTRL_PERM_6 = $00000020;
    ACTRL_PERM_7 = $00000040;
    ACTRL_PERM_8 = $00000080;
    ACTRL_PERM_9 = $00000100;
    ACTRL_PERM_10 = $00000200;
    ACTRL_PERM_11 = $00000400;
    ACTRL_PERM_12 = $00000800;
    ACTRL_PERM_13 = $00001000;
    ACTRL_PERM_14 = $00002000;
    ACTRL_PERM_15 = $00004000;
    ACTRL_PERM_16 = $00008000;
    ACTRL_PERM_17 = $00010000;
    ACTRL_PERM_18 = $00020000;
    ACTRL_PERM_19 = $00040000;
    ACTRL_PERM_20 = $00080000;


    // Access permissions

    ACTRL_ACCESS_ALLOWED = $00000001;
    ACTRL_ACCESS_DENIED = $00000002;
    ACTRL_AUDIT_SUCCESS = $00000004;
    ACTRL_AUDIT_FAILURE = $00000008;


    // Property list flags

    ACTRL_ACCESS_PROTECTED = $00000001;


    // Standard and object rights

    ACTRL_SYSTEM_ACCESS = $04000000;
    ACTRL_DELETE = $08000000;
    ACTRL_READ_CONTROL = $10000000;
    ACTRL_CHANGE_ACCESS = $20000000;
    ACTRL_CHANGE_OWNER = $40000000;
    ACTRL_SYNCHRONIZE = $80000000;
    ACTRL_STD_RIGHTS_ALL = $f8000000;
    ACTRL_STD_RIGHT_REQUIRED = (ACTRL_STD_RIGHTS_ALL and not (ACTRL_SYNCHRONIZE));

{$ifndef _DS_CONTROL_BITS_DEFINED_}
 {$define _DS_CONTROL_BITS_DEFINED_}
    ACTRL_DS_OPEN = ACTRL_RESERVED;
    ACTRL_DS_CREATE_CHILD = ACTRL_PERM_1;
    ACTRL_DS_DELETE_CHILD = ACTRL_PERM_2;
    ACTRL_DS_LIST = ACTRL_PERM_3;
    ACTRL_DS_SELF = ACTRL_PERM_4;
    ACTRL_DS_READ_PROP = ACTRL_PERM_5;
    ACTRL_DS_WRITE_PROP = ACTRL_PERM_6;
    ACTRL_DS_DELETE_TREE = ACTRL_PERM_7;
    ACTRL_DS_LIST_OBJECT = ACTRL_PERM_8;
    ACTRL_DS_CONTROL_ACCESS = ACTRL_PERM_9;
{$ENDIF}

    ACTRL_FILE_READ = ACTRL_PERM_1;
    ACTRL_FILE_WRITE = ACTRL_PERM_2;
    ACTRL_FILE_APPEND = ACTRL_PERM_3;
    ACTRL_FILE_READ_PROP = ACTRL_PERM_4;
    ACTRL_FILE_WRITE_PROP = ACTRL_PERM_5;
    ACTRL_FILE_EXECUTE = ACTRL_PERM_6;
    ACTRL_FILE_READ_ATTRIB = ACTRL_PERM_8;
    ACTRL_FILE_WRITE_ATTRIB = ACTRL_PERM_9;
    ACTRL_FILE_CREATE_PIPE = ACTRL_PERM_10;
    ACTRL_DIR_LIST = ACTRL_PERM_1;
    ACTRL_DIR_CREATE_OBJECT = ACTRL_PERM_2;
    ACTRL_DIR_CREATE_CHILD = ACTRL_PERM_3;
    ACTRL_DIR_DELETE_CHILD = ACTRL_PERM_7;
    ACTRL_DIR_TRAVERSE = ACTRL_PERM_6;
    ACTRL_KERNEL_TERMINATE = ACTRL_PERM_1;
    ACTRL_KERNEL_THREAD = ACTRL_PERM_2;
    ACTRL_KERNEL_VM = ACTRL_PERM_3;
    ACTRL_KERNEL_VM_READ = ACTRL_PERM_4;
    ACTRL_KERNEL_VM_WRITE = ACTRL_PERM_5;
    ACTRL_KERNEL_DUP_HANDLE = ACTRL_PERM_6;
    ACTRL_KERNEL_PROCESS = ACTRL_PERM_7;
    ACTRL_KERNEL_SET_INFO = ACTRL_PERM_8;
    ACTRL_KERNEL_GET_INFO = ACTRL_PERM_9;
    ACTRL_KERNEL_CONTROL = ACTRL_PERM_10;
    ACTRL_KERNEL_ALERT = ACTRL_PERM_11;
    ACTRL_KERNEL_GET_CONTEXT = ACTRL_PERM_12;
    ACTRL_KERNEL_SET_CONTEXT = ACTRL_PERM_13;
    ACTRL_KERNEL_TOKEN = ACTRL_PERM_14;
    ACTRL_KERNEL_IMPERSONATE = ACTRL_PERM_15;
    ACTRL_KERNEL_DIMPERSONATE = ACTRL_PERM_16;
    ACTRL_PRINT_SADMIN = ACTRL_PERM_1;
    ACTRL_PRINT_SLIST = ACTRL_PERM_2;
    ACTRL_PRINT_PADMIN = ACTRL_PERM_3;
    ACTRL_PRINT_PUSE = ACTRL_PERM_4;
    ACTRL_PRINT_JADMIN = ACTRL_PERM_5;
    ACTRL_SVC_GET_INFO = ACTRL_PERM_1;
    ACTRL_SVC_SET_INFO = ACTRL_PERM_2;
    ACTRL_SVC_STATUS = ACTRL_PERM_3;
    ACTRL_SVC_LIST = ACTRL_PERM_4;
    ACTRL_SVC_START = ACTRL_PERM_5;
    ACTRL_SVC_STOP = ACTRL_PERM_6;
    ACTRL_SVC_PAUSE = ACTRL_PERM_7;
    ACTRL_SVC_INTERROGATE = ACTRL_PERM_8;
    ACTRL_SVC_UCONTROL = ACTRL_PERM_9;
    ACTRL_REG_QUERY = ACTRL_PERM_1;
    ACTRL_REG_SET = ACTRL_PERM_2;
    ACTRL_REG_CREATE_CHILD = ACTRL_PERM_3;
    ACTRL_REG_LIST = ACTRL_PERM_4;
    ACTRL_REG_NOTIFY = ACTRL_PERM_5;
    ACTRL_REG_LINK = ACTRL_PERM_6;
    ACTRL_WIN_CLIPBRD = ACTRL_PERM_1;
    ACTRL_WIN_GLOBAL_ATOMS = ACTRL_PERM_2;
    ACTRL_WIN_CREATE = ACTRL_PERM_3;
    ACTRL_WIN_LIST_DESK = ACTRL_PERM_4;
    ACTRL_WIN_LIST = ACTRL_PERM_5;
    ACTRL_WIN_READ_ATTRIBS = ACTRL_PERM_6;
    ACTRL_WIN_WRITE_ATTRIBS = ACTRL_PERM_7;
    ACTRL_WIN_SCREEN = ACTRL_PERM_8;
    ACTRL_WIN_EXIT = ACTRL_PERM_9;


type

    TACTRL_OVERLAPPED = record
        case integer of
            0: (Provider: pointer;
                Reserved2: ULONG;
                hEvent: HANDLE;);
            1: (Reserved1: ULONG);
    end;
    PACTRL_OVERLAPPED = ^TACTRL_OVERLAPPED;



    TACTRL_ACCESS_INFOA = record
        fAccessPermission: ULONG;
        lpAccessPermissionName: LPSTR;
    end;
    PACTRL_ACCESS_INFOA = ^TACTRL_ACCESS_INFOA;

    TACTRL_ACCESS_INFOW = record
        fAccessPermission: ULONG;
        lpAccessPermissionName: LPWSTR;
    end;
    PACTRL_ACCESS_INFOW = ^TACTRL_ACCESS_INFOW;


    TACTRL_CONTROL_INFOA = record
        lpControlId: LPSTR;
        lpControlName: LPSTR;
    end;
    PACTRL_CONTROL_INFOA = ^TACTRL_CONTROL_INFOA;

    TACTRL_CONTROL_INFOW = record
        lpControlId: LPWSTR;
        lpControlName: LPWSTR;
    end;
    PACTRL_CONTROL_INFOW = ^TACTRL_CONTROL_INFOW;


const
    ACTRL_ACCESS_NO_OPTIONS = $00000000;
    ACTRL_ACCESS_SUPPORTS_OBJECT_ENTRIES = $00000001;

{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
    TREE_SEC_INFO_SET = $00000001;
    TREE_SEC_INFO_RESET = $00000002;
    TREE_SEC_INFO_RESET_KEEP_EXPLICIT = $00000003;
{$ENDIF}// (NTDDI_VERSION >= NTDDI_VISTA)

type
    TPROG_INVOKE_SETTING = (
        ProgressInvokeNever = 1,    // Never invoke the progress function
        ProgressInvokeEveryObject,  // Invoke for each object
        ProgressInvokeOnError,      // Invoke only for each error case
        ProgressCancelOperation,    // Stop propagation and return
        ProgressRetryOperation     // Retry operation on subtree
{$IF  (NTDDI_VERSION >= NTDDI_VISTA)}
        , ProgressInvokePrePostError // Invoke Pre, Post, Error
{$ENDIF}// (NTDDI_VERSION >= NTDDI_VISTA)
        );

    TPROGRESS_INVOKE_SETTING = TPROG_INVOKE_SETTING;
    PPROG_INVOKE_SETTING = ^TPROG_INVOKE_SETTING;


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


(*
typedef VOID (*FN_PROGRESS) (
    IN LPWSTR                   pObjectName,    // name of object just processed
    IN DWORD                    Status,         // status of operation on object
    IN OUT PPROG_INVOKE_SETTING pInvokeSetting, // Never, always,
    IN PVOID                    Args,           // Caller specific data
    IN BOOL                     SecuritySet     // Whether security was set
    );
*)


    // New Object Type function pointers.  TBD.
    // To support additional object resource managers generically, the
    // resource manager must provide it's own functions for operations
    // like:
    // GetAncestorAcl(IN ObjName, IN GenerationGap, IN DaclOrSacl?, ...)
    // GetAncestorName(...)
    // FreeNameStructure(...)


    TFN_OBJECT_MGR_FUNCTS = record
        Placeholder: ULONG;
    end;

    PFN_OBJECT_MGR_FUNCTS = ^TFN_OBJECT_MGR_FUNCTS;


    // Name of ancestor and number of generations between
    // ancestor and inheriting object.

    // GenerationGap:
    //     Name of ancestor from which ACE was inherited.
    //     NULL for explicit ACE.

    // AncestorName:
    //     Number of levels (or generations) between the object and the ancestor.
    //     Parent, gap=1.
    //     Grandparent, gap=2.
    //     Set to 0 for explicit ACE on object.


    TINHERITED_FROMA = record
        GenerationGap: LONG;
        AncestorName: LPSTR;
    end;

    PINHERITED_FROMA = ^TINHERITED_FROMA;

    TINHERITED_FROMW = record
        GenerationGap: LONG;
        AncestorName: LPWSTR;
    end;

    PINHERITED_FROMW = ^TINHERITED_FROMW;
    PINHERITED_FROM = pointer;

{$ENDIF}{ WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) }

implementation


function AccFree(hMem: HLOCAL): HLOCAL; stdcall; inline;
begin
    Result := LocalFree(hMem);
end;

end.




