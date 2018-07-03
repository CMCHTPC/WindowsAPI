unit Win32.ObjectArray;

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


//+-------------------------------------------------------------------------

//  Microsoft Windows
//  Copyright (c) Microsoft Corporation. All rights reserved.

//--------------------------------------------------------------------------

{ Header Definition: 10.0.14393.0 }

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}

interface

uses
    Windows, Classes, SysUtils;

const
    IID_IObjectArray: TGUID = '{92CA9DCD-5622-4bba-A805-5E9F541BD8C9}';
    IID_IObjectCollection: TGUID = '{5632b1a4-e38a-400a-928a-d4cd63230295}';

//{$IF  DEFINED(WINAPI_PARTITION_DESKTOP)}

type

    IObjectArray = interface(IUnknown)
        ['{92CA9DCD-5622-4bba-A805-5E9F541BD8C9}']
        function GetCount(out pcObjects: UINT): HResult; stdcall;
        function GetAt(uiIndex: UINT; const riid: TGUID; out ppv): HResult; stdcall;
    end;


    IObjectCollection = interface(IObjectArray)
        ['{5632b1a4-e38a-400a-928a-d4cd63230295}']
        function AddObject(punk: IUnknown): HResult; stdcall;
        function AddFromArray(poaSource: IObjectArray): HResult; stdcall;
        function RemoveObjectAt(uiIndex: UINT): HResult; stdcall;
        function Clear(): HResult; stdcall;
    end;


//{$ENDIF}

implementation

end.







