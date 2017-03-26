{$MACRO ON}

{$DEFINE __midl} // we have good compiler, very good ... :)

{ NTDDI_VERSION }
{$define NTDDI_THRESHOLD:=$0A000000}
{$define NTDDI_WINBLUE:=$06030000}
{$DEFINE NTDDI_WIN8:=$06020000}
{$DEFINE NTDDI_WIN7:=$06010000}
{$DEFINE NTDDI_WS08:=$06000100}
{$DEFINE NTDDI_VISTASP1:=$06000100}
{$DEFINE NTDDI_VISTA:=$06000000}
{$DEFINE NTDDI_WS03SP2:=$05020200}
{$DEFINE NTDDI_WS03SP1:=$05020100}
{$DEFINE NTDDI_WS03:=$05020000}
{$DEFINE NTDDI_WINXPSP3:=$05010300}
{$DEFINE NTDDI_WINXPSP2:=$05010200}
{$DEFINE NTDDI_WINXPSP1:=$05010100}
{$DEFINE NTDDI_WINXP:=$05010000}
{$DEFINE NTDDI_WIN2K:=$05000000}
{$DEFINE NTDDI_WIN2KSP1:=$05000100}
{$DEFINE NTDDI_WIN2KSP2:=$05000200}
{$DEFINE NTDDI_WIN2KSP3:=$05000300}
{$DEFINE NTDDI_WIN2KSP4:=$05000400}

{ _WIN32_WINNT and WINVER }

{$DEFINE _WIN32_WINNT_WIN10 := $0A00}
{$DEFINE _WIN32_WINNT_WINTHRESHOLD := $0A00}
{$DEFINE _WIN32_WINNT_WINBLUE := $0602}
{$DEFINE _WIN32_WINNT_WIN8 := $0602}
{$DEFINE _WIN32_WINNT_WIN7 := $0601}
{$DEFINE _WIN32_WINNT_WS08 := $0600}
{$DEFINE _WIN32_WINNT_VISTA := $0600}
{$DEFINE _WIN32_WINNT_WS03 := $0502}
{$DEFINE _WIN32_WINNT_WINXP := $0501}

{ Internet Explorer }

{$DEFINE _WIN32_IE_IE100 := $0A00} // Internet Explorer 10.0
{$DEFINE _WIN32_IE_IE90 := $0900} // Internet Explorer 9.0
{$DEFINE _WIN32_IE_IE80 := $0800} //  Internet Explorer 8.0
{$DEFINE _WIN32_IE_IE70 := $0700} // Internet Explorer 7.0
{$DEFINE _WIN32_IE_IE60SP2:= $0603} //  Internet Explorer 6.0 SP2
{$DEFINE _WIN32_IE_IE60SP1 := $0601} // Internet Explorer 6.0 SP1
{$DEFINE _WIN32_IE_IE60 := $0600} //  Internet Explorer 6.0
{$DEFINE _WIN32_IE_IE55 := $0550} // Internet Explorer 5.5
{$DEFINE _WIN32_IE_IE501 := $0501} // Internet Explorer 5.01
{$DEFINE _WIN32_IE_IE50 := $0500} // Internet Explorer 5.0, 5.0a, 5.0b


{ winapifamily.h }

(*
 * When compiling C and C++ code using SDK header files, the development
 * environment can specify a target platform by #define-ing the
 * pre-processor symbol WINAPI_FAMILY to one of the following values.
 * Each FAMILY value denotes an application family for which a different
 * subset of the total set of header-file-defined APIs are available.
 * Setting the WINAPI_FAMILY value will effectively hide from the
 * editing and compilation environments the existence of APIs that
 * are not applicable to the family of applications targeting a
 * specific platform.
 *)

(* In Windows 10, WINAPI_PARTITIONs will be used to add additional
 * device specific APIs to a particular WINAPI_FAMILY.
 * For example, when writing Windows Universal apps, specifying
 * WINAPI_FAMILY_APP will hide phone APIs from compilation.
 * However, specifying WINAPI_PARTITION_PHONE_APP=1 additionally, will
 * unhide any API hidden behind the partition, to the compiler.

 * The following partitions are currently defined:
 * WINAPI_PARTITION_DESKTOP            // usable for Desktop Win32 apps (but not store apps)
 * WINAPI_PARTITION_APP                // usable for Windows Universal store apps
 * WINAPI_PARTITION_PC_APP             // specific to Desktop-only store apps
 * WINAPI_PARTITION_PHONE_APP          // specific to Phone-only store apps
 * WINAPI_PARTITION_SYSTEM             // specific to System applications

 * The following partitions are indirect partitions and defined in
 * winpackagefamily.h. These partitions are related to package based
 * partitions. For example, specifying WINAPI_PARTITION_SERVER=1 will light up
 * any API hidden behind the package based partitions that are bound to
 * WINAPI_PARTITION_SERVER, to the compiler.
 * WINAPI_PARTITION_SERVER             // specific to Server applications
*)

(*
 * The WINAPI_FAMILY values of 0 and 1 are reserved to ensure that
 * an error will occur if WINAPI_FAMILY is set to any
 * WINAPI_PARTITION value (which must be 0 or 1, see below).
 *)
{$define WINAPI_FAMILY_PC_APP:=2}             (* Windows Store Applications *)
{$define WINAPI_FAMILY_PHONE_APP:=3}          (* Windows Phone Applications *)
{$define WINAPI_FAMILY_SYSTEM:=4}             (* Windows Drivers and Tools *)
{$define WINAPI_FAMILY_SERVER:=5}             (* Windows Server Applications *)
{$define WINAPI_FAMILY_DESKTOP_APP:=100}      (* Windows Desktop Applications *)
(* The value of WINAPI_FAMILY_DESKTOP_APP may change in future SDKs. *)
(* Additional WINAPI_FAMILY values may be defined in future SDKs. *)

(*
 * For compatibility with Windows 8 header files, the following
 * synonym for WINAPI_FAMILY_PC_APP is temporarily #define'd.
 * Use of this symbol should be considered deprecated.
 *)
{$define WINAPI_FAMILY_APP:=WINAPI_FAMILY_PC_APP}

(*
 * If no WINAPI_FAMILY value is specified, then all APIs available to
 * Windows desktop applications are exposed.
 *)
{$IFNDEF WINAPI_FAMILY}
{$define WINAPI_FAMILY:=WINAPI_FAMILY_DESKTOP_APP}
{$ENDIF}

(*
 * API PARTITONs are part of an indirection mechanism for mapping between
 * individual APIs and the FAMILYs to which they apply.
 * Each PARTITION is a category or subset of named APIs.  PARTITIONs
 * are permitted to have overlapping membership -- some single API
 * might be part of more than one PARTITION.  PARTITIONS are each #define-ed
 * to be either 1 or 0 or depending on the platform at which the app is targeted.
 *)

(*
 * The mapping between families and partitions is summarized here.
 * An X indicates that the given partition is active for the given
 * platform/family.
 *
 *                                +-------------------+---+
 *                                |      *Partition*  |   |
 *                                +---+---+---+---+---+---+
 *                                |   |   |   |   |   |   |
 *                                |   |   |   |   |   |   |
 *                                |   |   |   | P |   |   |
 *                                |   |   |   | H |   |   |
 *                                | D |   |   | O |   |   |
 *                                | E |   | P | N | S | S |
 *                                | S |   | C | E | Y | E |
 *                                | K |   | _ | _ | S | R |
 *                                | T | A | A | A | T | V |
 * +-------------------------+----+ O | P | P | P | E | E |
 * |     *Platform/Family*       \| P | P | P | P | M | R |
 * +------------------------------+---+---+---+---+---+---+
 * | WINAPI_FAMILY_DESKTOP_APP    | X | X | X |   |   |   |
 * +------------------------------+---+---+---+---+---+---+
 * |      WINAPI_FAMILY_PC_APP    |   | X | X |   |   |   |
 * +------------------------------+---+---+---+---+---+---+
 * |   WINAPI_FAMILY_PHONE_APP    |   | X |   | X |   |   |
 * +----------------------------- +---+---+---+---+---+---+
 * |      WINAPI_FAMILY_SYSTEM    |   |   |   |   | X |   |
 * +----------------------------- +---+---+---+---+---+---+
 * |      WINAPI_FAMILY_SERVER    |   |   |   |   | X | X |
 * +------------------------------+---+---+---+---+---+---+
 *
 * The table above is encoded in the following expressions,
 * each of which evaluates to 1 or 0.
 *
 * Whenever a new family is added, all of these expressions
 * need to be reconsidered.
 *)
{$IF ((WINAPI_FAMILY <> WINAPI_FAMILY_DESKTOP_APP) AND
      (WINAPI_FAMILY <> WINAPI_FAMILY_PC_APP) AND
      (WINAPI_FAMILY <> WINAPI_FAMILY_PHONE_APP) AND
      (WINAPI_FAMILY <> WINAPI_FAMILY_SYSTEM) AND
      (WINAPI_FAMILY <> WINAPI_FAMILY_SERVER))}
    {$ERROR Unknown WINAPI_FAMILY value. Was it defined in terms of a WINAPI_PARTITION_* value?}
{$ENDIF}

//{$IFNDEF WINAPI_PARTITION_DESKTOP}
    {$IF (WINAPI_FAMILY=WINAPI_FAMILY_DESKTOP_APP)}
        {$DEFINE WINAPI_PARTITION_DESKTOP}
        {$HINT Use WINAPI_PARTITION_DESKTOP for API Set}
    {$ENDIF}
//{$ENDIF}

{$IFNDEF WINAPI_PARTITION_APP}
   {$IF ((WINAPI_FAMILY = WINAPI_FAMILY_DESKTOP_APP) OR (WINAPI_FAMILY = WINAPI_FAMILY_PC_APP) OR (WINAPI_FAMILY = WINAPI_FAMILY_PHONE_APP))}
       {$DEFINE WINAPI_PARTITION_APP}
       {$HINT Use WINAPI_PARTITION_APP for API Set}
   {$ENDIF}
{$ENDIF}

{$IFNDEF WINAPI_PARTITION_PC_APP}
    {$IF ((WINAPI_FAMILY = WINAPI_FAMILY_DESKTOP_APP) OR (WINAPI_FAMILY = WINAPI_FAMILY_PC_APP))}
        {$DEFINE WINAPI_PARTITION_PC_APP}
        {$HINT Use WINAPI_PARTITION_PC_APP for API Set}
    {$ENDIF}
{$ENDIF}

{$IFNDEF WINAPI_PARTITION_PHONE_APP}
    {$IF (WINAPI_FAMILY = WINAPI_FAMILY_PHONE_APP)}
        {$DEFINE WINAPI_PARTITION_PHONE_APP}
        {$HINT Use WINAPI_PARTITION_PHONE_APP for API Set}
    {$ENDIF}
{$ENDIF}


(*
 * SYSTEM is the only partition defined here.
 * All other System based editions are defined as packages
 * on top of the System partition.
 * See winpackagefamily.h for packages level partitions
 *)
{$IFNDEF WINAPI_PARTITION_SYSTEM}
    {$IF ((WINAPI_FAMILY = WINAPI_FAMILY_SYSTEM) OR (WINAPI_FAMILY = WINAPI_FAMILY_SERVER))}
         {$DEFINE WINAPI_PARTITION_SYSTEM}
         {$HINT Use WINAPI_PARTITION_SYSTEM for API Set}
    {$ENDIF}
{$ENDIF}

(*
 * For compatibility with Windows Phone 8 header files, the following
 * synonym for WINAPI_PARTITION_PHONE_APP is temporarily #define'd.
 * Use of this symbol should be regarded as deprecated.
 *)
 {$DEFINE WINAPI_PARTITION_PHONE:=WINAPI_PARTITION_PHONE_APP}

(*
 * Header files use the WINAPI_FAMILY_PARTITION macro to assign one or
 * more declarations to some group of partitions.  The macro chooses
 * whether the preprocessor will emit or omit a sequence of declarations
 * bracketed by an #if/{$ENDIF} pair.  All header file references to the
 * WINAPI_PARTITION_* values should be in the form of occurrences of
 * WINAPI_FAMILY_PARTITION(...).
 *
 * For example, the following usage of WINAPI_FAMILY_PARTITION identifies
 * a sequence of declarations that are part of both the Windows Desktop
 * Partition and the Windows-Phone-Specific Store Partition:
 *
 *     #if WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP | WINAPI_PARTITION_PHONE_APP)
 *     ...
 *     {$ENDIF} // WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP | WINAPI_PARTITION_PHONE_APP)
 *
 * The comment on the closing {$ENDIF} allow tools as well as people to find the
 * matching #ifdef properly.
 *
 * Usages of WINAPI_FAMILY_PARTITION may be combined, when the partitition definitions are
 * related.  In particular one might use declarations like
 *
 *     #if WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_APP) && !WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP)
 *
 * or
 *
 *     #if WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_APP) && !WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_PHONE_APP)
 *
 * Direct references to WINAPI_PARTITION_ values (eg #if !WINAPI_FAMILY_PARTITION_...)
 * should not be used.
 *)


//{$DEFINE WINAPI_FAMILY_PARTITION(Partitions):=Partitions}

(*
 * Macro used to #define or typedef a symbol used for selective deprecation
 * of individual methods of a COM interfaces that are otherwise available
 * for a given set of partitions.
 *)


// {$DEFINE  _WINAPI_DEPRECATED_DECLARATION  __declspec(deprecated("This API cannot be used in the context of the caller's application type."))}

(*
 * For compatibility with Windows 8 header files, the following
 * symbol is temporarily conditionally #define'd.  Additional symbols
 * like this should be not defined in winapifamily.h, but rather should be
 * introduced locally to the header files of the component that needs them.
 *)

(* ToDo
{$IF (WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_APP) AND NOT WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP)}
{$DEFINE APP_DEPRECATED_HRESULT :=   HRESULT _WINAPI_DEPRECATED_DECLARATION }
{$ENDIF} // WINAPIFAMILY_PARTITION(WINAPI_PARTITION_APP) && !WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP)
*)

{ winpackagefamily.h }
{$IFNDEF WINAPI_PARTITION_SERVER}
    {$IF (WINAPI_FAMILY = WINAPI_FAMILY_SERVER)}
        {$DEFINE WINAPI_PARTITION_SERVER}
        {$HINT Use WINAPI_PARTITION_SERVER for API Set}
    {$ENDIF}
{$ENDIF}

(*
 * PARTITIONS based on packages are each #undef'ed below, and then will be #define-ed
 * to be either 1 or 0 or depending on the active WINAPI_FAMILY.
 *)
{$UNDEF WINAPI_PARTITION_PKG_WINTRUST}
{$UNDEF WINAPI_PARTITION_PKG_WEBSERVICES}
{$UNDEF WINAPI_PARTITION_PKG_EVENTLOGSERVICE}
{$UNDEF WINAPI_PARTITION_PKG_VHD}
{$UNDEF WINAPI_PARTITION_PKG_PERFCOUNTER}
{$UNDEF WINAPI_PARTITION_PKG_SECURESTARTUP}
{$UNDEF WINAPI_PARTITION_PKG_REMOTEFS}
{$UNDEF WINAPI_PARTITION_PKG_BOOTABLESKU}
{$UNDEF WINAPI_PARTITION_PKG_CMDTOOLS}
{$UNDEF WINAPI_PARTITION_PKG_DISM}
{$UNDEF WINAPI_PARTITION_PKG_CORESETUP}
{$UNDEF WINAPI_PARTITION_PKG_APPRUNTIME}
{$UNDEF WINAPI_PARTITION_PKG_ESENT}
{$UNDEF WINAPI_PARTITION_PKG_WINMGMT}
{$UNDEF WINAPI_PARTITION_PKG_WNV}
{$UNDEF WINAPI_PARTITION_PKG_CLUSTER}
{$UNDEF WINAPI_PARTITION_PKG_VSS}
{$UNDEF WINAPI_PARTITION_PKG_TRAFFIC}
{$UNDEF WINAPI_PARTITION_PKG_ISCSI}
{$UNDEF WINAPI_PARTITION_PKG_STORAGE}
{$UNDEF WINAPI_PARTITION_PKG_MPSSVC}
{$UNDEF WINAPI_PARTITION_PKG_APPXDEPLOYMENT}
{$UNDEF WINAPI_PARTITION_PKG_WER}

(* PARTITIONS for feature packages. Each package might be active for one or more editions *)
{$DEFINE WINAPI_PARTITION_PKG_WINTRUST:=(WINAPI_PARTITION_SERVER = 1)}
{$DEFINE WINAPI_PARTITION_PKG_WEBSERVICES:=(WINAPI_PARTITION_SERVER = 1)}
{$DEFINE WINAPI_PARTITION_PKG_EVENTLOGSERVICE:=(WINAPI_PARTITION_SERVER = 1)}
{$DEFINE WINAPI_PARTITION_PKG_VHD:=(WINAPI_PARTITION_SERVER = 1)}
{$DEFINE WINAPI_PARTITION_PKG_PERFCOUNTER:=(WINAPI_PARTITION_SERVER = 1)}
{$DEFINE WINAPI_PARTITION_PKG_SECURESTARTUP:=(WINAPI_PARTITION_SERVER = 1)}
{$DEFINE WINAPI_PARTITION_PKG_REMOTEFS:=(WINAPI_PARTITION_SERVER = 1)}
{$DEFINE WINAPI_PARTITION_PKG_BOOTABLESKU:=(WINAPI_PARTITION_SERVER = 1)}
{$DEFINE WINAPI_PARTITION_PKG_CMDTOOLS:=(WINAPI_PARTITION_SERVER = 1)}
{$DEFINE WINAPI_PARTITION_PKG_DISM:=(WINAPI_PARTITION_SERVER = 1)}
{$DEFINE WINAPI_PARTITION_PKG_CORESETUP:=(WINAPI_PARTITION_SERVER = 1)}
{$DEFINE WINAPI_PARTITION_PKG_APPRUNTIME:=(WINAPI_PARTITION_SERVER = 1)}
{$DEFINE WINAPI_PARTITION_PKG_ESENT:=(WINAPI_PARTITION_SERVER = 1)}
{$DEFINE WINAPI_PARTITION_PKG_WINMGMT:=(WINAPI_PARTITION_SERVER = 1)}
{$DEFINE WINAPI_PARTITION_PKG_WNV:=(WINAPI_PARTITION_SERVER = 1)}
{$DEFINE WINAPI_PARTITION_PKG_CLUSTER:=(WINAPI_PARTITION_SERVER = 1)}
{$DEFINE WINAPI_PARTITION_PKG_VSS:=(WINAPI_PARTITION_SERVER = 1)}
{$DEFINE WINAPI_PARTITION_PKG_TRAFFIC:=(WINAPI_PARTITION_SERVER = 1)}
{$DEFINE WINAPI_PARTITION_PKG_ISCSI:=(WINAPI_PARTITION_SERVER = 1)}
{$DEFINE WINAPI_PARTITION_PKG_STORAGE:=(WINAPI_PARTITION_SERVER = 1)}
{$DEFINE WINAPI_PARTITION_PKG_MPSSVC:=(WINAPI_PARTITION_SERVER = 1)}
{$DEFINE WINAPI_PARTITION_PKG_APPXDEPLOYMENT:=(WINAPI_PARTITION_SERVER = 1)}
{$DEFINE WINAPI_PARTITION_PKG_WER:=(WINAPI_PARTITION_SERVER = 1)}

{$define WINVER:=_WIN32_WINNT_WIN10}
{$define NTDDI_VERSION:=NTDDI_THRESHOLD}
{$define _WIN32_IE := _WIN32_IE_IE100}
{$define _WIN32_WINNT:=_WIN32_WINNT_WIN10}


