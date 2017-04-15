unit Win32.PropSys;

{$mode delphi}

interface

uses
    Classes, SysUtils,
    Win32.WTypes;

type

    REFPROPERTYKEY = PPROPERTYKEY;

    TGETPROPERTYSTOREFLAGS = (
        // If no flags are specified (GPS_DEFAULT), a read-only property store is returned that includes properties for the file or item.
        // In the case that the shell item is a file, the property store contains:
        //     1. properties about the file from the file system
        //     2. properties from the file itself provided by the file's property handler, unless that file is offline,
        //         see GPS_OPENSLOWITEM
        //     3. if requested by the file's property handler and supported by the file system, properties stored in the
        //     alternate property store.

        // Non-file shell items should return a similar read-only store

        // Specifying other GPS_ flags modifies the store that is returned
        GPS_DEFAULT = $00000000,
        GPS_HANDLERPROPERTIESONLY = $00000001,   // only include properties directly from the file's property handler
        GPS_READWRITE = $00000002,   // Writable stores will only include handler properties
        GPS_TEMPORARY = $00000004,   // A read/write store that only holds properties for the lifetime of the IShellItem object
        GPS_FASTPROPERTIESONLY = $00000008,
        // do not include any properties from the file's property handler (because the file's property handler will hit the disk)
        GPS_OPENSLOWITEM = $00000010,
        // include properties from a file's property handler, even if it means retrieving the file from offline storage.
        GPS_DELAYCREATION = $00000020,
        // delay the creation of the file's property handler until those properties are read, written, or enumerated
        GPS_BESTEFFORT = $00000040,
        // For readonly stores, succeed and return all available properties, even if one or more sources of properties fails. Not valid with GPS_READWRITE.
        GPS_NO_OPLOCK = $00000080,   // some data sources protect the read property store with an oplock, this disables that
        GPS_PREFERQUERYPROPERTIES = $00000100,   // For file system WDS results, only retrieve properties from the indexer
        GPS_EXTRINSICPROPERTIES = $00000200,   // include properties from the file's secondary stream
        GPS_EXTRINSICPROPERTIESONLY = $00000400,   // only include properties from the file's secondary stream
        GPS_MASK_VALID = $000007FF);


    IPropertyChangeArray = interface(IUnknown)
        ['{380f5cad-1b5e-42f2-805d-637fd392d31e}']
    end;

    IPropertyStore = interface(IUnknown)
        ['{886d8eeb-8cf2-4446-8d02-cdba1dbdcf99}']
    end;


    IPropertyDescriptionList = interface(IUnknown)
        ['{1f9fc1d0-c39b-4b26-817f-011967d3440e}']
    end;

implementation

end.
