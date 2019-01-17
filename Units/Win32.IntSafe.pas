(******************************************************************
*                                                                 *
*  intsafe.h -- This module defines helper functions to prevent   *
*               integer overflow bugs.                            *
*                                                                 *
*  Copyright (c) Microsoft Corp.  All rights reserved.            *
*                                                                 *
******************************************************************)
unit Win32.IntSafe;

{$mode delphi}
{$MACRO ON}

interface

uses
    Windows, Classes, SysUtils;

const
    S_OK: HRESULT = 0;
    INTSAFE_E_ARITHMETIC_OVERFLOW: HRESULT = $80070216;  // $216 = 534 = ERROR_ARITHMETIC_OVERFLOW

    ULONG_MAX = $ffffffff;

    ULONG_ERROR = $ffffffff;

function SUCCEEDED(hr: HResult): boolean;
function FAILED(hr: HResult): boolean;




// DWORD multiplication



// ULONG multiplication
function ULongMult(ulMultiplicand: ULONG; ulMultiplier: ULONG; out pulResult: ULONG): HRESULT;
function DWordMult(ulMultiplicand: ULONG; ulMultiplier: ULONG; out pulResult: ULONG): HRESULT;

// UInt32x32To64 macro
function UInt32x32To64(a: ULONG; b: ULONG): ULONGLONG;

// ULONGLONG -> ULONG conversion
function ULongLongToULong(ullOperand: ULONGLONG; out pulResult: ULONG): HRESULT;




implementation



function SUCCEEDED(hr: HResult): boolean;
begin
    Result := (hr >= 0);
end;



function FAILED(hr: HResult): boolean;
begin
    Result := (hr < 0);
end;


// ULONG multiplication

function ULongMult(ulMultiplicand: ULONG; ulMultiplier: ULONG; out pulResult: ULONG): HRESULT; inline;
var
    ull64Result: ULONGLONG;
begin
    ull64Result := UInt32x32To64(ulMultiplicand, ulMultiplier);

    Result := ULongLongToULong(ull64Result, pulResult);
end;



function DWordMult(ulMultiplicand: ULONG; ulMultiplier: ULONG; out pulResult: ULONG): HRESULT; inline;
begin
    Result := ULongMult(ulMultiplicand, ulMultiplier, pulResult);
end;



// UInt32x32To64 macro
function UInt32x32To64(a: ULONG; b: ULONG): ULONGLONG; inline;
begin
    Result := a * b;
end;


// ULONGLONG -> ULONG conversion
function ULongLongToULong(ullOperand: ULONGLONG; out pulResult: ULONG): HRESULT; inline;
begin
    if (ullOperand <= ULONG_MAX) then
    begin
        pulResult := ULONG(ullOperand);
        Result := S_OK;
    end
    else
    begin
        pulResult := ULONG_ERROR;
        Result := INTSAFE_E_ARITHMETIC_OVERFLOW;
    end;
end;




end.











