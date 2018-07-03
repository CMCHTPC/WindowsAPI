unit Win32.WTypes;

{$mode delphi}

interface

uses
    Windows, Classes, SysUtils,
    Win32.WinNT,
    Win32.WTypesBase;

type
    TRemHGLOBAL = record
        fNullHGlobal: LONG;
        cbData: ULONG;
        Data: PByte;
    end;

    TRemHMETAFILEPICT = record
        mm: LONG;
        xExt: LONG;
        yExt: LONG;
        cbData: ULONG;
        Data: Pbyte;
    end;

    TRemHENHMETAFILE = record
        cbData: ULONG;
        Data: Pbyte;
    end;

    TRemHBITMAP = record
        cbData: ULONG;
        Data: Pbyte;
    end;

    TRemHPALETTE = record
        cbData: ULONG;
        Data: Pbyte;
    end;

    TRemHBRUSH = record
        cbData: ULONG;
        Data: Pbyte;
    end;


{$IF  NOT defined(_WIN32) AND NOT defined(_MPPC_)}
    // The following code is for Win16 only

    // not here ... :(


{$ENDIF}//!WIN32 && !MPPC


    TPALETTEENTRY = record
        peRed: byte;
        peGreen: byte;
        peBlue: byte;
        peFlags: byte;
    end;

    PPALETTEENTRY = ^TPALETTEENTRY;



    TLOGPALETTE = record
        palVersion: word;
        palNumEntries: word;
        palPalEntry: PPALETTEENTRY;
    end;
    PLOGPALETTE = ^TLOGPALETTE;


 {$IFNDEF  _WINDEF_}
    PCRECTL = ^TRECTL;

    TRECT = record
        left: LONG;
        top: LONG;
        right: LONG;
        bottom: LONG;
    end;
    PRECT = ^TRECT;
    PCRECT = ^TRECT;

{$ENDIF}//_WINDEF_

const
    ROTFLAGS_REGISTRATIONKEEPSALIVE = $1;
    ROTFLAGS_ALLOWANYCLIENT = $2;
    ROT_COMPARE_MAX = 2048;


type

    TDVASPECT = (
        DVASPECT_CONTENT = 1,
        DVASPECT_THUMBNAIL = 2,
        DVASPECT_ICON = 4,
        DVASPECT_DOCPRINT = 8
        );

    TSTGC = (
        STGC_DEFAULT = 0,
        STGC_OVERWRITE = 1,
        STGC_ONLYIFCURRENT = 2,
        STGC_DANGEROUSLYCOMMITMERELYTODISKCACHE = 4,
        STGC_CONSOLIDATE = 8
        );

    TSTGMOVE = (
        STGMOVE_MOVE = 0,
        STGMOVE_COPY = 1,
        STGMOVE_SHALLOWCOPY = 2
        );

    TSTATFLAG = (
        STATFLAG_DEFAULT = 0,
        STATFLAG_NONAME = 1,
        STATFLAG_NOOPEN = 2
        );


    HCONTEXT = Pointer;


    TLCID = DWORD;


    TLANGID = USHORT;


const
    WDT_INPROC_CALL = ($48746457);

    WDT_REMOTE_CALL = ($52746457);

    WDT_INPROC64_CALL = ($50746457);

type
    userCLIPFORMAT = record
        fContext: LONG;
        case integer of
            0: (dwValue: DWORD);
            1: (pwszName: Pwchar_t);
    end;
    wireCLIPFORMAT = ^userCLIPFORMAT;

    TCLIPFORMAT = word;



    TGDI_NONREMOTE = record
        fContext: LONG;
        case integer of
            0: (hInproc: LONG);
            1: (hRemote: PDWORD_BLOB);

    end;

    userHGLOBAL = record
        fContext: LONG;
        case integer of
            0: (hInproc: LONG);
            1: (hRemote: PFLAGGED_BYTE_BLOB);
            2: (hInproc64: __int64);

    end;
    wireHGLOBAL = ^userHGLOBAL;



    userHMETAFILE = record
        fContext: LONG;
        case integer of
            0: (hInproc: LONG);
            1: (hRemote: PBYTE_BLOB);
            2: (hInproc64: __int64);

    end;

    PuserHMETAFILE = ^userHMETAFILE;

    remoteMETAFILEPICT = record
        mm: LONG;
        xExt: LONG;
        yExt: LONG;
        hMF: PuserHMETAFILE;
    end;
    PremoteMETAFILEPICT = ^remoteMETAFILEPICT;

    userHMETAFILEPICT = record
        fContext: LONG;
        case integer of
            0: (hInproc: LONG);
            1: (hRemote: PremoteMETAFILEPICT);
            2: (hInproc64: __int64);

    end;

    userHENHMETAFILE = record
        fContext: LONG;
        case integer of
            0: (hInproc: LONG);
            1: (hRemote: PBYTE_BLOB);
            2: (hInproc64: __int64);

    end;

    userBITMAP = record
        bmType: LONG;
        bmWidth: LONG;
        bmHeight: LONG;
        bmWidthBytes: LONG;
        bmPlanes: word;
        bmBitsPixel: word;
        cbSize: ULONG;
        pBuffer: Pbyte;
    end;
    PuserBITMAP = ^userBITMAP;

    userHBITMAP = record
        fContext: LONG;
        case integer of
            0: (hInproc: LONG);
            1: (hRemote: PuserBITMAP);
            2: (hInproc64: __int64);

    end;

    userHPALETTE = record
        fContext: LONG;
        case integer of
            0: (hInproc: LONG);
            1: (hRemote: PLOGPALETTE);
            2: (hInproc64: __int64);

    end;

type
    TRemotableHandle = record
        fContext: LONG;
        case integer of
            0: (hInproc: LONG);
            1: (hRemote: LONG);

    end;

    wireHWND = ^TRemotableHandle;

    wireHMENU = ^TRemotableHandle;

    wireHACCEL = ^TRemotableHandle;

    wireHBRUSH = ^TRemotableHandle;

    wireHFONT = ^TRemotableHandle;

    wireHDC = ^TRemotableHandle;

    wireHICON = ^TRemotableHandle;

    wireHRGN = ^TRemotableHandle;

    wireHMONITOR = ^TRemotableHandle;


{$IF  0}
    HWND = pointer;
    HMENU = pointer;
    HACCEL = pointer;
    HBRUSH = pointer;
    HFONT = pointer;
    HDC = pointer;
    HICON = pointer;
    HRGN = pointer;
    HMONITOR = pointer;
    HCURSOR = HICON;
{$ENDIF}//0


type
    TTEXTMETRICW = record
        tmHeight: LONG;
        tmAscent: LONG;
        tmDescent: LONG;
        tmInternalLeading: LONG;
        tmExternalLeading: LONG;
        tmAveCharWidth: LONG;
        tmMaxCharWidth: LONG;
        tmWeight: LONG;
        tmOverhang: LONG;
        tmDigitizedAspectX: LONG;
        tmDigitizedAspectY: LONG;
        tmFirstChar: WCHAR;
        tmLastChar: WCHAR;
        tmDefaultChar: WCHAR;
        tmBreakChar: WCHAR;
        tmItalic: byte;
        tmUnderlined: byte;
        tmStruckOut: byte;
        tmPitchAndFamily: byte;
        tmCharSet: byte;
    end;
    PTEXTMETRICW = ^TTEXTMETRICW;

(*
{$IFNDEF  _WIN32}// The following code is for Win16 only
{$IFNDEF  WINAPI}// If not included with 3.1 headers...
    TMSG = record
        hwnd: HWND;
        message: UINT;
        wParam: WPARAM;
        lParam: LPARAM;
        time: DWORD;
        pt: TPOINT;
    end;

    PMSG = ^TMSG;
    NPMSG = ^TMSG;
    LPMSG = ^TMSG;


{$ENDIF}// _WIN32
{$ENDIF}// WINAPI
*)


    wireHBITMAP = ^userHBITMAP;
    wireHPALETTE = ^userHPALETTE;
    wireHENHMETAFILE = ^userHENHMETAFILE;
    wireHMETAFILE = ^userHMETAFILE;
    wireHMETAFILEPICT = ^userHMETAFILEPICT;

{$IF  0}
    HGLOBAL = pointer;
    HLOCAL = HGLOBAL;
    HBITMAP = pointer;
    HPALETTE = pointer;
    HENHMETAFILE = pointer;
    HMETAFILE = pointer;
{$ENDIF}//0
    HMETAFILEPICT = pointer;
    TDATE = double;
    TCY = record
        case integer of
            0: (Lo: ULONG;
                Hi: LONG;);
            1: (int64: LONGLONG;);
    end;
    PCY = ^TCY;

{$IF  0}{ _tagDEC_DEFINED }
    { The following isn't the real definition of Decimal type, }
    { but it is what RPC knows how to remote }
    TDECIMAL = record
        wReserved: USHORT;
        scale: byte;
        sign: byte;
        Hi32: ULONG;
        Lo64: ULONGLONG;
    end;
{$ELSE}{ _tagDEC_DEFINED }
    { real definition that makes the C++ compiler happy }
    TDECIMAL = record
        wReserved: USHORT;
        case integer of
            0: (
                scale: byte;
                sign: byte;
                Hi32: ULONG;
                case integer of
                    0: (
                    Lo32: ULONG;
                    Mid32: ULONG;
                    );
                    1: (Lo64: ULONGLONG);
            );
            1: (signscale: USHORT);
    end;


const
    DECIMAL_NEG = byte($80);

procedure DECIMAL_SETZERO(var Dec: TDECIMAL);

{$ENDIF}{ _tagDEC_DEFINED }
type
    PDECIMAL = ^TDECIMAL;


    wireBSTR = ^TFLAGGED_WORD_BLOB;

    BSTR = ^OLECHAR;

    PBSTR = ^BSTR;



    { 0 == FALSE, -1 == TRUE }
    VARIANT_BOOL = short;
    _VARIANT_BOOL = VARIANT_BOOL;
    PVARIANT_BOOL = ^VARIANT_BOOL;

    { The BSTRBLOB structure is used by some implementations }
    { of the IPropertyStorage interface when marshaling BSTRs }
    { on systems which don't support BSTR marshaling. }

    TBSTRBLOB = record
        cbSize: ULONG;
        pData: PBYTE;
    end;
    PBSTRBLOB = ^TBSTRBLOB;


const
    VARIANT_TRUE = VARIANT_BOOL(-1);
    VARIANT_FALSE = VARIANT_BOOL(0);

type
    TCLIPDATA = record
        cbSize: ULONG;
        ulClipFmt: LONG;
        pClipData: PBYTE;
    end;

// Macro to calculate the size of the above pClipData
function CBPCLIPDATA(clipdata: TCLIPDATA): LONG;


type
    VARTYPE = USHORT;

{
 * VARENUM usage key,
 *
 * * [V] - may appear in a VARIANT
 * * [T] - may appear in a TYPEDESC
 * * [P] - may appear in an OLE property set
 * * [S] - may appear in a Safe Array
 *
 *
 *  VT_EMPTY            [V]   [P]     nothing
 *  VT_NULL             [V]   [P]     SQL style Null
 *  VT_I2               [V][T][P][S]  2 byte signed int
 *  VT_I4               [V][T][P][S]  4 byte signed int
 *  VT_R4               [V][T][P][S]  4 byte real
 *  VT_R8               [V][T][P][S]  8 byte real
 *  VT_CY               [V][T][P][S]  currency
 *  VT_DATE             [V][T][P][S]  date
 *  VT_BSTR             [V][T][P][S]  OLE Automation string
 *  VT_DISPATCH         [V][T]   [S]  IDispatch *
 *  VT_ERROR            [V][T][P][S]  SCODE
 *  VT_BOOL             [V][T][P][S]  True=-1, False=0
 *  VT_VARIANT          [V][T][P][S]  VARIANT *
 *  VT_UNKNOWN          [V][T]   [S]  IUnknown *
 *  VT_DECIMAL          [V][T]   [S]  16 byte fixed point
 *  VT_RECORD           [V]   [P][S]  user defined type
 *  VT_I1               [V][T][P][s]  signed char
 *  VT_UI1              [V][T][P][S]  unsigned char
 *  VT_UI2              [V][T][P][S]  unsigned short
 *  VT_UI4              [V][T][P][S]  ULONG
 *  VT_I8                  [T][P]     signed 64-bit int
 *  VT_UI8                 [T][P]     unsigned 64-bit int
 *  VT_INT              [V][T][P][S]  signed machine int
 *  VT_UINT             [V][T]   [S]  unsigned machine int
 *  VT_INT_PTR             [T]        signed machine register size width
 *  VT_UINT_PTR            [T]        unsigned machine register size width
 *  VT_VOID                [T]        C style void
 *  VT_HRESULT             [T]        Standard return type
 *  VT_PTR                 [T]        pointer type
 *  VT_SAFEARRAY           [T]        (use VT_ARRAY in VARIANT)
 *  VT_CARRAY              [T]        C style array
 *  VT_USERDEFINED         [T]        user defined type
 *  VT_LPSTR               [T][P]     null terminated string
 *  VT_LPWSTR              [T][P]     wide null terminated string
 *  VT_FILETIME               [P]     FILETIME
 *  VT_BLOB                   [P]     Length prefixed bytes
 *  VT_STREAM                 [P]     Name of the stream follows
 *  VT_STORAGE                [P]     Name of the storage follows
 *  VT_STREAMED_OBJECT        [P]     Stream contains an object
 *  VT_STORED_OBJECT          [P]     Storage contains an object
 *  VT_VERSIONED_STREAM       [P]     Stream with a GUID version
 *  VT_BLOB_OBJECT            [P]     Blob contains an object
 *  VT_CF                     [P]     Clipboard format
 *  VT_CLSID                  [P]     A Class ID
 *  VT_VECTOR                 [P]     simple counted array
 *  VT_ARRAY            [V]           SAFEARRAY*
 *  VT_BYREF            [V]           void* for local use
 *  VT_BSTR_BLOB                      Reserved for system use
}

    TVARENUM = (
        VT_EMPTY = 0,
        VT_NULL = 1,
        VT_I2 = 2,
        VT_I4 = 3,
        VT_R4 = 4,
        VT_R8 = 5,
        VT_CY = 6,
        VT_DATE = 7,
        VT_BSTR = 8,
        VT_DISPATCH = 9,
        VT_ERROR = 10,
        VT_BOOL = 11,
        VT_VARIANT = 12,
        VT_UNKNOWN = 13,
        VT_DECIMAL = 14,
        VT_I1 = 16,
        VT_UI1 = 17,
        VT_UI2 = 18,
        VT_UI4 = 19,
        VT_I8 = 20,
        VT_UI8 = 21,
        VT_INT = 22,
        VT_UINT = 23,
        VT_VOID = 24,
        VT_HRESULT = 25,
        VT_PTR = 26,
        VT_SAFEARRAY = 27,
        VT_CARRAY = 28,
        VT_USERDEFINED = 29,
        VT_LPSTR = 30,
        VT_LPWSTR = 31,
        VT_RECORD = 36,
        VT_INT_PTR = 37,
        VT_UINT_PTR = 38,
        VT_FILETIME = 64,
        VT_BLOB = 65,
        VT_STREAM = 66,
        VT_STORAGE = 67,
        VT_STREAMED_OBJECT = 68,
        VT_STORED_OBJECT = 69,
        VT_BLOB_OBJECT = 70,
        VT_CF = 71,
        VT_CLSID = 72,
        VT_VERSIONED_STREAM = 73,
        VT_BSTR_BLOB = $fff,
        VT_VECTOR = $1000,
        VT_ARRAY = $2000,
        VT_BYREF = $4000,
        VT_RESERVED = $8000,
        VT_ILLEGAL = $ffff,
        VT_ILLEGALMASKED = $fff,
        VT_TYPEMASK = $fff
        );


    PROPID = ULONG;


    TPROPERTYKEY = record
        fmtid: TGUID;
        pid: DWORD;
    end;
    PPROPERTYKEY = ^TPROPERTYKEY;

    TCSPLATFORM = record
        dwPlatformId: DWORD;
        dwVersionHi: DWORD;
        dwVersionLo: DWORD;
        dwProcessorArch: DWORD;
    end;


    TQUERYCONTEXT = record
        dwContext: DWORD;
        _Platform: TCSPLATFORM;
        Locale: TLCID;
        dwVersionHi: DWORD;
        dwVersionLo: DWORD;
    end;



    TTYSPEC = (
        TYSPEC_CLSID = 0,
        TYSPEC_FILEEXT = (TYSPEC_CLSID + 1),
        TYSPEC_MIMETYPE = (TYSPEC_FILEEXT + 1),
        TYSPEC_FILENAME = (TYSPEC_MIMETYPE + 1),
        TYSPEC_PROGID = (TYSPEC_FILENAME + 1),
        TYSPEC_PACKAGENAME = (TYSPEC_PROGID + 1),
        TYSPEC_OBJECTID = (TYSPEC_PACKAGENAME + 1)
        );



    uCLSSPEC = record
        tyspec: DWORD;
        case integer of
            0: (clsid: CLSID);
            1: (pFileExt: POLESTR);
            2: (pMimeType: POLESTR);
            3: (pProgId: POLESTR);
            4: (pFileName: POLESTR);
            5: (
                pPackageName: POLESTR;
                PolicyId: TGUID;
            );
            6: (
                ObjectId: TGUID;
                {PolicyId: TGUID; }
            );
    end;


implementation



procedure DECIMAL_SETZERO(var Dec: TDECIMAL);
begin
    Dec.Lo64 := 0;
    Dec.Hi32 := 0;
    Dec.signscale := 0;
end;



function CBPCLIPDATA(clipdata: TCLIPDATA): LONG;
begin
    Result := clipdata.cbSize - sizeof(clipdata.ulClipFmt);
end;

end.















