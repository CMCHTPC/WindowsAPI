unit Win32.SDKDDKVer;

(*

Copyright (c) Microsoft Corporation. All rights reserved.

Module Name:

    sdkddkver.h

Abstract:

    Master include file for versioning windows SDK/DDK.

*)


{$mode delphi}

interface

uses
    Windows, Classes, SysUtils;



// _WIN32_WINNT version constants

{$DEFINE  _WIN32_WINNT_NT4              :=      $0400}
{$DEFINE  _WIN32_WINNT_WIN2K            :=      $0500}
{$DEFINE  _WIN32_WINNT_WINXP            :=      $0501}
{$DEFINE  _WIN32_WINNT_WS03              :=     $0502}
{$DEFINE  _WIN32_WINNT_WIN6              :=     $0600}
{$DEFINE  _WIN32_WINNT_VISTA             :=     $0600}
{$DEFINE  _WIN32_WINNT_WS08              :=     $0600}
{$DEFINE  _WIN32_WINNT_LONGHORN          :=     $0600}
{$DEFINE  _WIN32_WINNT_WIN7              :=     $0601}
{$DEFINE  _WIN32_WINNT_WIN8              :=     $0602}
{$DEFINE  _WIN32_WINNT_WINBLUE           :=     $0603}
{$DEFINE  _WIN32_WINNT_WINTHRESHOLD      :=     $0A00}
{$DEFINE  _WIN32_WINNT_WIN10              :=    $0A00}


// _WIN32_IE_ version constants

{$DEFINE  _WIN32_IE_IE20              :=        $0200}
{$DEFINE  _WIN32_IE_IE30              :=        $0300}
{$DEFINE  _WIN32_IE_IE302              :=       $0302}
{$DEFINE  _WIN32_IE_IE40               :=       $0400}
{$DEFINE  _WIN32_IE_IE401               :=      $0401}
{$DEFINE  _WIN32_IE_IE50                 :=     $0500}
{$DEFINE  _WIN32_IE_IE501                 :=    $0501}
{$DEFINE  _WIN32_IE_IE55                   :=   $0550}
{$DEFINE  _WIN32_IE_IE60         :=             $0600}
{$DEFINE  _WIN32_IE_IE60SP1       :=            $0601}
{$DEFINE  _WIN32_IE_IE60SP2        :=           $0603}
{$DEFINE  _WIN32_IE_IE70            :=          $0700}
{$DEFINE  _WIN32_IE_IE80             :=         $0800}
{$DEFINE  _WIN32_IE_IE90              :=        $0900}
{$DEFINE  _WIN32_IE_IE100              :=       $0A00}
{$DEFINE  _WIN32_IE_IE110               :=      $0A00}(* ABRACADABRA_THRESHOLD *)


// IE <-> OS version mapping

// NT4 supports IE versions 2.0 -> 6.0 SP1
{$DEFINE  _WIN32_IE_NT4             :=          _WIN32_IE_IE20}
{$DEFINE  _WIN32_IE_NT4SP1            :=        _WIN32_IE_IE20}
{$DEFINE  _WIN32_IE_NT4SP2              :=      _WIN32_IE_IE20}
{$DEFINE  _WIN32_IE_NT4SP3                :=    _WIN32_IE_IE302}
{$DEFINE  _WIN32_IE_NT4SP4                  :=  _WIN32_IE_IE401}
{$DEFINE  _WIN32_IE_NT4SP5                    :=_WIN32_IE_IE401}
{$DEFINE  _WIN32_IE_NT4SP6              :=      _WIN32_IE_IE50}
// Win98 supports IE versions 4.01 -> 6.0 SP1
{$DEFINE  _WIN32_IE_WIN98                 :=    _WIN32_IE_IE401}
// Win98SE supports IE versions 5.0 -> 6.0 SP1
{$DEFINE  _WIN32_IE_WIN98SE                 :=  _WIN32_IE_IE50}
// WinME supports IE versions 5.5 -> 6.0 SP1
{$DEFINE  _WIN32_IE_WINME                     :=_WIN32_IE_IE55}
// Win2k supports IE versions 5.01 -> 6.0 SP1
{$DEFINE  _WIN32_IE_WIN2K                 :=    _WIN32_IE_IE501}
{$DEFINE  _WIN32_IE_WIN2KSP1        :=          _WIN32_IE_IE501}
{$DEFINE  _WIN32_IE_WIN2KSP2         :=         _WIN32_IE_IE501}
{$DEFINE  _WIN32_IE_WIN2KSP3          :=        _WIN32_IE_IE501}
{$DEFINE  _WIN32_IE_WIN2KSP4           :=       _WIN32_IE_IE501}
{$DEFINE  _WIN32_IE_XP                  :=      _WIN32_IE_IE60}
{$DEFINE  _WIN32_IE_XPSP1                :=     _WIN32_IE_IE60SP1}
{$DEFINE  _WIN32_IE_XPSP2                 :=    _WIN32_IE_IE60SP2}
{$DEFINE  _WIN32_IE_WS03                 :=     $0602}
{$DEFINE  _WIN32_IE_WS03SP1               :=    _WIN32_IE_IE60SP2}
{$DEFINE  _WIN32_IE_WIN6                   :=   _WIN32_IE_IE70}
{$DEFINE  _WIN32_IE_LONGHORN                :=  _WIN32_IE_IE70}
{$DEFINE  _WIN32_IE_WIN7       :=               _WIN32_IE_IE80}
{$DEFINE  _WIN32_IE_WIN8         :=             _WIN32_IE_IE100}
{$DEFINE  _WIN32_IE_WINBLUE        :=           _WIN32_IE_IE100}
{$DEFINE  _WIN32_IE_WINTHRESHOLD     :=         _WIN32_IE_IE110}(* ABRACADABRA_THRESHOLD *)
{$DEFINE  _WIN32_IE_WIN10              :=       _WIN32_IE_IE110}(* ABRACADABRA_THRESHOLD *)



// NTDDI version constants

{$DEFINE  NTDDI_WIN2K                :=          $05000000}
{$DEFINE  NTDDI_WIN2KSP1            :=           $05000100}
{$DEFINE  NTDDI_WIN2KSP2              :=         $05000200}
{$DEFINE  NTDDI_WIN2KSP3                :=       $05000300}
{$DEFINE  NTDDI_WIN2KSP4                  :=     $05000400}

{$DEFINE  NTDDI_WINXP     :=                     $05010000}
{$DEFINE  NTDDI_WINXPSP1     :=                  $05010100}
{$DEFINE  NTDDI_WINXPSP2        :=               $05010200}
{$DEFINE  NTDDI_WINXPSP3           :=            $05010300}
{$DEFINE  NTDDI_WINXPSP4              :=         $05010400}

{$DEFINE  NTDDI_WS03    :=                       $05020000}
{$DEFINE  NTDDI_WS03SP1 :=                      $05020100}
{$DEFINE  NTDDI_WS03SP2   :=                    $05020200}
{$DEFINE  NTDDI_WS03SP3     :=                  $05020300}
{$DEFINE  NTDDI_WS03SP4       :=                $05020400}

{$DEFINE  NTDDI_WIN6            :=              $06000000}
{$DEFINE  NTDDI_WIN6SP1           :=            $06000100}
{$DEFINE  NTDDI_WIN6SP2             :=          $06000200}
{$DEFINE  NTDDI_WIN6SP3               :=        $06000300}
{$DEFINE  NTDDI_WIN6SP4                 :=      $06000400}

{$DEFINE  NTDDI_VISTA                     :=    NTDDI_WIN6}
{$DEFINE  NTDDI_VISTASP1:=                      NTDDI_WIN6SP1}
{$DEFINE  NTDDI_VISTASP2:=                      NTDDI_WIN6SP2}
{$DEFINE  NTDDI_VISTASP3:=                      NTDDI_WIN6SP3}
{$DEFINE  NTDDI_VISTASP4:=                      NTDDI_WIN6SP4}

{$DEFINE  NTDDI_LONGHORN:=  NTDDI_VISTA}

{$DEFINE  NTDDI_WS08:=                          NTDDI_WIN6SP1}
{$DEFINE  NTDDI_WS08SP2:=                       NTDDI_WIN6SP2}
{$DEFINE  NTDDI_WS08SP3:=                       NTDDI_WIN6SP3}
{$DEFINE  NTDDI_WS08SP4:=                       NTDDI_WIN6SP4}

{$DEFINE  NTDDI_WIN7:=                          $06010000}
{$DEFINE  NTDDI_WIN8:=                          $06020000}
{$DEFINE  NTDDI_WINBLUE:=                       $06030000}
{$DEFINE  NTDDI_WINTHRESHOLD:=                  $0A000000 }(* ABRACADABRA_THRESHOLD *)
{$DEFINE  NTDDI_WIN10:=                         $0A000000  }(* ABRACADABRA_THRESHOLD *)
{$DEFINE  NTDDI_WIN10_TH2:=                     $0A000001}(* ABRACADABRA_WIN10_TH2 *)
{$DEFINE  NTDDI_WIN10_RS1:=                     $0A000002}(* ABRACADABRA_WIN10_RS1 *)
{$DEFINE  NTDDI_WIN10_RS2:=                     $0A000003}(* ABRACADABRA_WIN10_RS2 *)
{$DEFINE  NTDDI_WIN10_RS3:=                     $0A000004}(* ABRACADABRA_WIN10_RS3 *)
{$DEFINE  NTDDI_WIN10_RS4:=                    $0A000005}(* ABRACADABRA_WIN10_RS4 *)
{$DEFINE  NTDDI_WIN10_RS5:=                     $0A000006}(* ABRACADABRA_WIN10_RS5 *)

{$DEFINE  WDK_NTDDI_VERSION:=                   NTDDI_WIN10_RS5}(* ABRACADABRA_WIN10_RS5 *)



// masks for version macros

{$DEFINE  OSVERSION_MASK:=      $FFFF0000}
{$DEFINE  SPVERSION_MASK:=      $0000FF00}
{$DEFINE  SUBVERSION_MASK:=     $000000FF}



{$IFNDEF _WIN32_WINNT AND NOT DEFINED(_CHICAGO_)}
{$DEFINE   _WIN32_WINNT  := $0A00}
{$ENDIF}

implementation

end.
