unit Win32.ADC;

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

//-----------------------------------------------------------------------------

// File:        adc.h

// Contents:    Adc external constants and GUIDS

// Comments:

//-----------------------------------------------------------------------------



{ Header Definition: 10.0.14393.0 }

{$IFDEF FPC}
{$mode delphiunicode}{$H+}
{$ENDIF}

{$I Win32.WinAPI.inc}

interface

uses
    Windows, Classes, SysUtils;



{$IF DEFINED(WINAPI_PARTITION_DESKTOP)}

const
    CLSID_FoxRowset: TGUID = '{3ff292b6-b204-11cf-8d23-00aa005ffe58}';
    DBPROPSET_ADC: TGUID = '{b68e3cc1-6deb-11d0-8df6-00aa005ffe58}';
    IID_IAsyncAllowed: TGUID = '{f5f2893a-ba9e-11d0-abb9-00c04fc29f8f}';
    IID_IRowsetADCExtensions: TGUID = '{F17324c4-68E0-11D0-AD45-00C04FC29863}';
    IID_IUpdateInfo: TGUID = '{a0385420-62b8-11d1-9a06-00a0c903aa45}';
    IID_IRowsetSynchronize: TGUID = '{1be41e60-807a-11d1-9a14-00a0c903aa45}';
    IID_IRowsetProperties: TGUID = '{1e837070-bcfc-11d1-9a2c-00a0c903aa45}';

type


    TADCPROPENUM = (
        DBPROP_ADC_ASYNCHFETCHSIZE = 3,
        DBPROP_ADC_BATCHSIZE = 4,
        DBPROP_ADC_UPDATECRITERIA = 5,
        // dropping support for the UPDATEOPERTION property, but should not reuse the number
        //      DBPROP_ADC_UPDATEOPERATION = 6,
        DBPROP_ADC_ASYNCHPREFETCHSIZE = 7,
        DBPROP_ADC_ASYNCHTHREADPRIORITY = 8,
        DBPROP_ADC_CACHECHILDROWS = 9,
        DBPROP_ADC_MAINTAINCHANGESTATUS = 10,
        DBPROP_ADC_AUTORECALC = 11,
        DBPROP_ADC_UNIQUETABLE = 13,
        DBPROP_ADC_UNIQUESCHEMA = 14,
        DBPROP_ADC_UNIQUECATALOG = 15,
        DBPROP_ADC_CUSTOMRESYNCH = 16,
        DBPROP_ADC_CEVER = 17,
        DBPROP_ADC_RESHAPENAME = 18,
        DBPROP_ADC_UPDATERESYNC = 19,
        // removing SaveMode, but we should not reuse the number
        //      DBPROP_ADC_SAVEMODE = 20,
        DBPROP_ADC_BACKINGSTORE = 21,
        DBPROP_ADC_RELEASESHAPEONDISCONNECT = 22
        );


    // these enums are defined in both adc.h and adoint.h
    // do not re define them here if adoint.h has already been included
{$IFNDEF _COMMON_ADC_AND_ADO_PROPS_}
{$DEFINE _COMMON_ADC_AND_ADO_PROPS_}

    TADCPROP_UPDATECRITERIA_ENUM = (adCriteriaKey = 0,
        adCriteriaAllCols = 1,
        adCriteriaUpdCols = 2,
        adCriteriaTimeStamp = 3
        );

    TADCPROP_ASYNCTHREADPRIORITY_ENUM = (adPriorityLowest = 1,
        adPriorityBelowNormal = 2,
        adPriorityNormal = 3,
        adPriorityAboveNormal = 4,
        adPriorityHighest = 5
        );

    TADCPROP_UPDATERESYNC_ENUM = (adResyncNone = 0,
        adResyncAutoIncrement = $1,
        adResyncConflicts = $2,
        adResyncUpdates = $4,
        adResyncInserts = $8,
        adResyncAll = $0F
        );

    TADCPROP_AUTORECALC_ENUM = (
        adRecalcUpFront = 0,
        adRecalcAlways = 1
        );

{$ENDIF}// _COMMON_ADC_AND_ADO_PROPS_

    TFOXROWSETPROPENUM = (
        DBPROP_FOXTABLENAME = $eeff);


{$endif}{ WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) }


implementation

end.

