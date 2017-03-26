unit Win32.ADODef;

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
// File:        ADODEF.H

// Contents:    ADO version definition.


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


// Change the version numbers below when there are any updates in the version of the type libraries,
// which should be changed after some updates to the type libraries

const
    // TYPELIB MAJOR VERSIONS

    ADO_MAJOR = 6;
    ADOR_MAJOR = 6;
    ADOX_MAJOR = 6;
    ADOMD_MAJOR = 6;
    JRO_MAJOR = 2;

    // TYPELIB MINOR VERSION
    ADO_MINOR = 1;
    ADOR_MINOR = 0;
    ADOX_MINOR = 0;
    ADOMD_MINOR = 0;
    JRO_MINOR = 6;

    ADO_VERSION: ansistring = chr(ADO_MAJOR) + '.' + chr(ADO_MINOR);
    ADOR_VERSION: ansistring = chr(ADOR_MAJOR) + '.' + chr(ADOR_MINOR);
    ADOX_VERSION: ansistring = chr(ADOX_MAJOR) + '.' + chr(ADOX_MINOR);
    ADOMD_VERSION: ansistring = chr(ADOMD_MAJOR) + '.' + chr(ADOMD_MINOR);
    JRO_VERSION: ansistring = chr(JRO_MAJOR) + '.' + chr(JRO_MINOR);

    ADO_LIBRARYNAME: ansistring = 'Microsoft ActiveX Data Objects 6.1 Library';
    ADOR_LIBRARYNAME: ansistring = 'Microsoft ActiveX Data Objects Recordset 6.0 Library';
    ADOX_LIBRARYNAME: ansistring = 'Microsoft ADO Ext. 6.0 for DDL and Security';
    ADOMD_LIBRARYNAME: ansistring = 'Microsoft ActiveX Data Objects (Multi-dimensional) 6.0 Library';
    JRO_LIBRARYNAME: ansistring = 'Microsoft Jet and Replication Objects 2.6 Library';

    ADOMD_TYPELIB_UUID: TGUID = '{22813728-8BD3-11D0-B4EF-00A0C9138CA4}';
    JRO_TYPELIB_UUID: TGUID = '{AC3B8B4C-B6CA-11d1-9F31-00C04FC29D52}';


implementation

end.

