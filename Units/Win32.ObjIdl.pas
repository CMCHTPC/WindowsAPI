unit Win32.ObjIdl;

{$mode delphi}

interface

uses
    Windows, Classes, SysUtils;

type



    // ToDo

    IDataObject = interface(IUnknown)
        ['{0000010e-0000-0000-C000-000000000046}']
    end;

    IBindCtx = interface(IUnknown)
        ['{0000000e-0000-0000-C000-000000000046}']
    end;



    IPersist = interface(IUnknown)
        ['{0000010c-0000-0000-C000-000000000046}']
        function GetClassID(out pClassID: CLSID): HResult; stdcall;
    end;

    IStorage = interface(IUnknown)
        ['{0000000b-0000-0000-C000-000000000046}']
    end;


    IMalloc = interface(IUnknown)
        ['{00000002-0000-0000-C000-000000000046}']
    end;

implementation

end.


