unit Win32.ProcessThreadsAPI;

{$mode delphiunicode}{$H+}

interface

uses
  Windows,Classes, SysUtils;


type

    TPROCESS_INFORMATION = record
     hProcess:HANDLE;
     hThread:HANDLE;
     dwProcessId:DWORD;
     dwThreadId:DWORD;
end;
    PPROCESS_INFORMATION=^TPROCESS_INFORMATION;

implementation

end.

