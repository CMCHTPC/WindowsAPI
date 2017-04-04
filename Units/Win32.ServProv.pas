unit Win32.ServProv;

//=--------------------------------------------------------------------------=
// ServProv.h
//=--------------------------------------------------------------------------=
// (C) Copyright Microsoft Corporation.  All Rights Reserved.

// THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF
// ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO
// THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
// PARTICULAR PURPOSE.
//=--------------------------------------------------------------------------=

{$mode delphi}

interface

uses
    Classes, SysUtils;

const
    IID_IServiceProvider: TGUID = '{6d5140c1-7436-11ce-8034-00aa006009fa}';

type
    IServiceProvider = interface(IUnknown)
        ['{6d5140c1-7436-11ce-8034-00aa006009fa}']
        function QueryService(const guidService: TGUID; const riid: TGUID; out ppvObject): HResult; stdcall;
    end;

implementation

end.







