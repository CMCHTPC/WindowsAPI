unit Win32.OAIdl;

{$mode delphi}

interface

uses
    Windows, Classes, SysUtils,
    Win32.WTypesBase,
    Win32.WTypes;

type
    PCOLESTR = PWidechar; // ToDo weil stimmt net
    POLESTR = PWidechar; // ToDo weil stimmt net
    BSTR = PWidechar;    // ToDo weil stimmt net
    PBSTR = PWidechar; // ToDo weil stimmt net

    TLCID = LCID;
    PIUnknown = ^IUnknown;
    PwireBSTR = PWidechar;  // ToDo weil stimmt net
    PIDispatch = ^IDispatch;

const

    IID_ICreateTypeInfo: TGUID = '{00020405-0000-0000-C000-000000000046}';
    IID_ICreateTypeInfo2: TGUID = '{0002040E-0000-0000-C000-000000000046}';
    IID_ICreateTypeLib: TGUID = '{00020406-0000-0000-C000-000000000046}';
    IID_ICreateTypeLib2: TGUID = '{0002040F-0000-0000-C000-000000000046}';
    IID_IDispatch: TGUID = '{00020400-0000-0000-C000-000000000046}';
    IID_IEnumVARIANT: TGUID = '{00020404-0000-0000-C000-000000000046}';
    IID_ITypeComp: TGUID = '{00020403-0000-0000-C000-000000000046}';
    IID_ITypeInfo: TGUID = '{00020401-0000-0000-C000-000000000046}';
    IID_ITypeInfo2: TGUID = '{00020412-0000-0000-C000-000000000046}';
    IID_ITypeLib: TGUID = '{00020402-0000-0000-C000-000000000046}';
    IID_ITypeLib2: TGUID = '{00020411-0000-0000-C000-000000000046}';
    IID_ITypeChangeEvents: TGUID = '{00020410-0000-0000-C000-000000000046}';
    IID_IErrorInfo: TGUID = '{1CF2B120-547D-101B-8E65-08002B2BD119}';
    IID_ICreateErrorInfo: TGUID = '{22F03340-547D-101B-8E65-08002B2BD119}';
    IID_ISupportErrorInfo: TGUID = '{DF0B3D60-548F-101B-8E65-08002B2BD119}';
    IID_ITypeFactory: TGUID = '{0000002E-0000-0000-C000-000000000046}';
    IID_ITypeMarshal: TGUID = '{0000002D-0000-0000-C000-000000000046}';
    IID_IRecordInfo: TGUID = '{0000002F-0000-0000-C000-000000000046}';
    IID_IErrorLog: TGUID = '{3127CA40-446E-11CE-8135-00AA004BB851}';
    IID_IPropertyBag: TGUID = '{55272A00-42CB-11CE-8135-00AA004BB851}';


const
    FADF_AUTO = ($1);
    FADF_STATIC = ($2);
    FADF_EMBEDDED = ($4);
    FADF_FIXEDSIZE = ($10);
    FADF_RECORD = ($20);
    FADF_HAVEIID = ($40);
    FADF_HAVEVARTYPE = ($80);
    FADF_BSTR = ($100);
    FADF_UNKNOWN = ($200);
    FADF_DISPATCH = ($400);
    FADF_VARIANT = ($800);
    FADF_RESERVED = ($f008);

const
    PARAMFLAG_NONE = (0);
    PARAMFLAG_FIN = ($1);
    PARAMFLAG_FOUT = ($2);
    PARAMFLAG_FLCID = ($4);
    PARAMFLAG_FRETVAL = ($8);
    PARAMFLAG_FOPT = ($10);
    PARAMFLAG_FHASDEFAULT = ($20);
    PARAMFLAG_FHASCUSTDATA = ($40);

const
    IDLFLAG_NONE = (PARAMFLAG_NONE);
    IDLFLAG_FIN = (PARAMFLAG_FIN);
    IDLFLAG_FOUT = (PARAMFLAG_FOUT);
    IDLFLAG_FLCID = (PARAMFLAG_FLCID);
    IDLFLAG_FRETVAL = (PARAMFLAG_FRETVAL);

type

    TCURRENCY = TCY;

    TSAFEARRAYBOUND = record
        cElements: ULONG;
        lLbound: LONG;
    end;
    PSAFEARRAYBOUND = ^TSAFEARRAYBOUND;


    { the following is what MIDL knows how to remote }
    PwireVARIANT = ^_wireVARIANT;

    PwireBRECORD = ^_wireBRECORD;

    _wireSAFEARR_BSTR = record
        Size: ULONG;
        aBstr: PwireBSTR;
    end;

    SAFEARR_BSTR = _wireSAFEARR_BSTR;

    _wireSAFEARR_UNKNOWN = record
        Size: ULONG;
        apUnknown: PIUnknown;
    end;
    SAFEARR_UNKNOWN = _wireSAFEARR_UNKNOWN;

    _wireSAFEARR_DISPATCH = record
        Size: ULONG;
        apDispatch: PIDispatch;
    end;
    SAFEARR_DISPATCH = _wireSAFEARR_DISPATCH;

    _wireSAFEARR_VARIANT = record
        Size: ULONG;
        aVariant: PwireVARIANT;
    end;
    SAFEARR_VARIANT = ^_wireSAFEARR_VARIANT;

    _wireSAFEARR_BRECORD = record
        Size: ULONG;
        aRecord: PwireBRECORD;
    end;

    SAFEARR_BRECORD = _wireSAFEARR_BRECORD;

    _wireSAFEARR_HAVEIID = record
        Size: ULONG;
        apUnknown: PIUnknown;
        iid: TIID;
    end;
    SAFEARR_HAVEIID = _wireSAFEARR_HAVEIID;

    TSF_TYPE = (
        SF_ERROR = Ord(VT_ERROR),
        SF_I1 = Ord(VT_I1),
        SF_I2 = Ord(VT_I2),
        SF_I4 = Ord(VT_I4),
        SF_I8 = Ord(VT_I8),
        SF_BSTR = Ord(VT_BSTR),
        SF_UNKNOWN = Ord(VT_UNKNOWN),
        SF_DISPATCH = Ord(VT_DISPATCH),
        SF_VARIANT = Ord(VT_VARIANT),
        SF_RECORD = Ord(VT_RECORD),
        SF_HAVEIID = (Ord(VT_UNKNOWN) or Ord(VT_RESERVED))
        );


    _wireSAFEARRAY_UNION = record
        sfType: ULONG;
        case integer of
            0: (BstrStr: SAFEARR_BSTR);
            1: (UnknownStr: SAFEARR_UNKNOWN);
            2: (DispatchStr: SAFEARR_DISPATCH);
            3: (VariantStr: SAFEARR_VARIANT);
            4: (RecordStr: SAFEARR_BRECORD);
            5: (HaveIidStr: SAFEARR_HAVEIID);
            6: (ByteStr: TBYTE_SIZEDARR);
            7: (WordStr: TWORD_SIZEDARR);
            8: (LongStr: TDWORD_SIZEDARR);
            9: (HyperStr: THYPER_SIZEDARR);

    end;
    SAFEARRAYUNION = _wireSAFEARRAY_UNION;


    wireSAFEARRAY = record
        cDims: USHORT;
        fFeatures: USHORT;
        cbElements: ULONG;
        cLocks: ULONG;
        uArrayStructs: SAFEARRAYUNION;
        rgsabound: PSAFEARRAYBOUND;
    end;
    _wirePSAFEARRAY = ^wireSAFEARRAY;



    TSAFEARRAY = record
        cDims: USHORT;
        fFeatures: USHORT;
        cbElements: ULONG;
        cLocks: ULONG;
        pvData: pointer;
        rgsabound: PSAFEARRAYBOUND;
    end;
    PSAFEARRAY = ^TSAFEARRAY;



 { VARIANT STRUCTURE
 *
 *  VARTYPE vt;
 *  WORD wReserved1;
 *  WORD wReserved2;
 *  WORD wReserved3;
 *  union {
 *    LONGLONG       VT_I8
 *    LONG           VT_I4
 *    BYTE           VT_UI1
 *    SHORT          VT_I2
 *    FLOAT          VT_R4
 *    DOUBLE         VT_R8
 *    VARIANT_BOOL   VT_BOOL
 *    SCODE          VT_ERROR
 *    CY             VT_CY
 *    DATE           VT_DATE
 *    BSTR           VT_BSTR
 *    IUnknown *     VT_UNKNOWN
 *    IDispatch *    VT_DISPATCH
 *    SAFEARRAY *    VT_ARRAY
 *    BYTE *         VT_BYREF|VT_UI1
 *    SHORT *        VT_BYREF|VT_I2
 *    LONG *         VT_BYREF|VT_I4
 *    LONGLONG *     VT_BYREF|VT_I8
 *    FLOAT *        VT_BYREF|VT_R4
 *    DOUBLE *       VT_BYREF|VT_R8
 *    VARIANT_BOOL * VT_BYREF|VT_BOOL
 *    SCODE *        VT_BYREF|VT_ERROR
 *    CY *           VT_BYREF|VT_CY
 *    DATE *         VT_BYREF|VT_DATE
 *    BSTR *         VT_BYREF|VT_BSTR
 *    IUnknown **    VT_BYREF|VT_UNKNOWN
 *    IDispatch **   VT_BYREF|VT_DISPATCH
 *    SAFEARRAY **   VT_BYREF|VT_ARRAY
 *    VARIANT *      VT_BYREF|VT_VARIANT
 *    pointer           VT_BYREF (Generic ByRef)
 *    CHAR           VT_I1
 *    USHORT         VT_UI2
 *    ULONG          VT_UI4
 *    ULONGLONG      VT_UI8
 *    INT            VT_INT
 *    UINT           VT_UINT
 *    DECIMAL *      VT_BYREF|VT_DECIMAL
 *    CHAR *         VT_BYREF|VT_I1
 *    USHORT *       VT_BYREF|VT_UI2
 *    ULONG *        VT_BYREF|VT_UI4
 *    ULONGLONG *    VT_BYREF|VT_UI8
 *    INT *          VT_BYREF|VT_INT
 *    UINT *         VT_BYREF|VT_UINT
 *
 }
    TVARIANT = record
        case integer of
            0: (
                vt: TVARTYPE;
                wReserved1: word;
                wReserved2: word;
                wReserved3: word;
                case integer of
                    0: (llVal: LONGLONG);
                    1: (lVal: LONG);
                    2: (bVal: byte);
                    3: (iVal: SHORT);
                    4: (fltVal: single);
                    5: (dblVal: double);
                    6: (boolVal: VARIANT_BOOL);
                    7: (boolean: _VARIANT_BOOL);
                    8: (scode: TSCODE);
                    9: (cyVal: TCY);
                    10: (date: TDATE);
                    11: (bstrVal: BSTR);
                    12: (punkVal: pointer {IUnknown});
                    13: (pdispVal: pointer{IDispatch});
                    14: (parray: PSAFEARRAY);
                    15: (pbVal: PBYTE);
                    16: (piVal: PSHORT);
                    17: (plVal: PLONG);
                    18: (pllVal: PLONGLONG);
                    19: (pfltVal: PSingle);
                    20: (pdblVal: PDOUBLE);
                    21: (pboolVal: PVARIANT_BOOL);
                    22: (pbool: PVARIANT_BOOL);
                    23: (pscode: PSCODE);
                    24: (pcyVal: PCY);
                    25: (pdate: PDATE);
                    26: (pbstrVal: PBSTR);
                    27: (ppunkVal: PIUnknown);
                    28: (ppdispVal: PIDispatch);
                    29: (pparray: PSAFEARRAY);
                    30: (pvarVal: PVARIANT);
                    31: (byref: pointer);
                    32: (cVal: char);
                    33: (uiVal: USHORT);
                    34: (ulVal: ULONG);
                    35: (ullVal: ULONGLONG);
                    36: (intVal: INT32);
                    37: (uintVal: UINT);
                    38: (pdecVal: PDECIMAL);
                    39: (pcVal: PChar);
                    40: (puiVal: PUSHORT);
                    41: (pulVal: PULONG);
                    42: (pullVal: PULONGLONG);
                    43: (pintVal: PINT32);
                    44: (puintVal: PUINT);
                    45: (
                    pvRecord: pointer;
                    pRecInfo: IRecordInfo;
                    );
            );
            1: (decVal: TDECIMAL);
    end;

    PVARIANT = ^TVariant;
    VARIANTARG = TVariant;
    PVARIANTARG = ^TVariant;

    REFVARIANT = ^TVariant;

    { the following is what MIDL knows how to remote }
    _wireBRECORD = record
        fFlags: ULONG;
        clSize: ULONG;
        pRecInfo: IRecordInfo;
        pRecord: PByte;
    end;

    _wireVARIANT = record
        clSize: DWORD;
        rpcReserved: DWORD;
        vt: USHORT;
        wReserved1: USHORT;
        wReserved2: USHORT;
        wReserved3: USHORT;
        case integer of
            0: (llVal: LONGLONG);
            1: (lVal: LONG);
            2: (bVal: byte);
            3: (iVal: SHORT);
            4: (fltVal: single);
            5: (dblVal: double);
            6: (boolVal: VARIANT_BOOL);
            7: (scode: TSCODE);
            8: (cyVal: TCY);
            9: (date: TDATE);
            10: (bstrVal: wireBSTR);
            11: (punkVal: IUnknown);
            12: (pdispVal: IDispatch);
            13: (parray: wirePSAFEARRAY);
            14: (brecVal: wireBRECORD);
            15: (pbVal: PBYTE);
            16: (piVal: PSHORT);
            17: (plVal: PLONG);
            18: (pllVal: PLONGLONG);
            19: (pfltVal: PSingle);
            20: (pdblVal: PDOUBLE);
            21: (pboolVal: PVARIANT_BOOL);
            22: (pscode: PSCODE);
            23: (pcyVal: PCY);
            24: (pdate: PDATE);
            25: (pbstrVal: PwireBSTR);
            26: (ppunkVal: PIUnknown);
            27: (ppdispVal: PIDispatch);
            28: (pparray: PwirePSAFEARRAY);
            29: (pvarVal: PwireVARIANT);
            30: (cVal: char);
            31: (uiVal: USHORT);
            32: (ulVal: ULONG);
            33: (ullVal: ULONGLONG);
            34: (intVal: INT32);
            35: (uintVal: UINT);
            36: (decVal: TDECIMAL);
            37: (pdecVal: PDECIMAL);
            38: (pcVal: PChar);
            39: (puiVal: PUSHORT);
            40: (pulVal: PULONG);
            41: (pullVal: PULONGLONG);
            42: (pintVal: PINT32);
            43: (puintVal: PUINT);

    end;

    TDISPID = LONG;

    TMEMBERID = TDISPID;


    HREFTYPE = DWORD;

    TTYPEKIND = (
        TKIND_ENUM = 0,
        TKIND_RECORD = (TKIND_ENUM + 1),
        TKIND_MODULE = (TKIND_RECORD + 1),
        TKIND_INTERFACE = (TKIND_MODULE + 1),
        TKIND_DISPATCH = (TKIND_INTERFACE + 1),
        TKIND_COCLASS = (TKIND_DISPATCH + 1),
        TKIND_ALIAS = (TKIND_COCLASS + 1),
        TKIND_UNION = (TKIND_ALIAS + 1),
        TKIND_MAX = (TKIND_UNION + 1)
        );

    TTYPEDESC = record
        case integer of
            0: (lptdesc: PTYPEDESC;
                vt: TVARTYPE;);
            1: (lpadesc: PARRAYDESC);
            2: (hreftype: THREFTYPE);


    end;
    PTYPEDESC = ^TTYPEDESC;

    TARRAYDESC = record
        tdescElem: TTYPEDESC;
        cDims: USHORT;
        rgbounds: PSAFEARRAYBOUND;
    end;
    PARRAYDESC = ^TARRAYDESC;

    TPARAMDESCEX = record
        cBytes: ULONG;
        varDefaultValue: TVARIANTARG;
    end;
    PPARAMDESCEX = ^TPARAMDESCEX;



    TPARAMDESC = record
        pparamdescex: PPARAMDESCEX;
        wParamFlags: USHORT;
    end;
    PPARAMDESC = ^TPARAMDESC;






    TIDLDESC = record
        dwReserved: ULONG_PTR;
        wIDLFlags: USHORT;
    end;
    PIDLDESC = ^TIDLDESC;




    TELEMDESC = record
        tdesc: TTYPEDESC;             { the type of the element }
        case integer of
            0: (idldesc: TIDLDESC);        { info for remoting the element }
            1: (paramdesc: TPARAMDESC);    { info about the parameter }
    end;
    PELEMDESC = ^TELEMDESC;


    TTYPEATTR = record
        guid: TGUID;
        lcid: TLCID;
        dwReserved: DWORD;
        memidConstructor: TMEMBERID;
        memidDestructor: TMEMBERID;
        lpstrSchema: POLESTR;
        cbSizeInstance: ULONG;
        typekind: TTYPEKIND;
        cFuncs: word;
        cVars: word;
        cImplTypes: word;
        cbSizeVft: word;
        cbAlignment: word;
        wTypeFlags: word;
        wMajorVerNum: word;
        wMinorVerNum: word;
        tdescAlias: TTYPEDESC;
        idldescType: TIDLDESC;
    end;
    PTYPEATTR = ^TTYPEATTR;


    TDISPPARAMS = record
        rgvarg: PVARIANTARG;
        rgdispidNamedArgs: PDISPID;
        cArgs: UINT;
        cNamedArgs: UINT;
    end;
    PDISPPARAMS = ^TDISPPARAMS;

    TEXCEPINFO = record
        wCode: word;
        wReserved: word;
        bstrSource: BSTR;
        bstrDescription: BSTR;
        bstrHelpFile: BSTR;
        dwHelpContext: DWORD;
        pvReserved: ULONG_PTR;
        pfnDeferredFillIn: ULONG_PTR; // HRESULT (__stdcall *pfnDeferredFillIn)(struct tagEXCEPINFO *);
        scode: TSCODE;
    end;
    PEXCEPINFO = ^TEXCEPINFO;


    TCALLCONV = (
        CC_FASTCALL = 0,
        CC_CDECL = 1,
        CC_MSCPASCAL = (CC_CDECL + 1),
        CC_PASCAL = CC_MSCPASCAL,
        CC_MACPASCAL = (CC_PASCAL + 1),
        CC_STDCALL = (CC_MACPASCAL + 1),
        CC_FPFASTCALL = (CC_STDCALL + 1),
        CC_SYSCALL = (CC_FPFASTCALL + 1),
        CC_MPWCDECL = (CC_SYSCALL + 1),
        CC_MPWPASCAL = (CC_MPWCDECL + 1),
        CC_MAX = (CC_MPWPASCAL + 1)
        );

    TFUNCKIND = (
        FUNC_VIRTUAL = 0,
        FUNC_PUREVIRTUAL = (FUNC_VIRTUAL + 1),
        FUNC_NONVIRTUAL = (FUNC_PUREVIRTUAL + 1),
        FUNC_STATIC = (FUNC_NONVIRTUAL + 1),
        FUNC_DISPATCH = (FUNC_STATIC + 1)
        );

    TINVOKEKIND = (
        INVOKE_FUNC = 1,
        INVOKE_PROPERTYGET = 2,
        INVOKE_PROPERTYPUT = 4,
        INVOKE_PROPERTYPUTREF = 8
        );

    TFUNCDESC = record
        memid: TMEMBERID;
        lprgscode: PSCODE;
        lprgelemdescParam: PELEMDESC;
        funckind: TFUNCKIND;
        invkind: TINVOKEKIND;
        callconv: TCALLCONV;
        cParams: SHORT;
        cParamsOpt: SHORT;
        oVft: SHORT;
        cScodes: SHORT;
        elemdescFunc: TELEMDESC;
        wFuncFlags: word;
    end;
    PFUNCDESC = ^TFUNCDESC;


    TVARKIND = (
        VAR_PERINSTANCE = 0,
        VAR_STATIC = (VAR_PERINSTANCE + 1),
        VAR_CONST = (VAR_STATIC + 1),
        VAR_DISPATCH = (VAR_CONST + 1)
        );



const
    IMPLTYPEFLAG_FDEFAULT = ($1);
    IMPLTYPEFLAG_FSOURCE = ($2);
    IMPLTYPEFLAG_FRESTRICTED = ($4);
    IMPLTYPEFLAG_FDEFAULTVTABLE = ($8);

type
    TVARDESC = record
        memid: TMEMBERID;
        lpstrSchema: POLESTR;
        case integer of
            0: (oInst: ULONG;
                elemdescVar: TELEMDESC;
                wVarFlags: word;
                varkind: TVARKIND;);
            1: (lpvarValue: PVARIANT);
    end;
    PVARDESC = ^TVARDESC;

    TTYPEFLAGS = (
        TYPEFLAG_FAPPOBJECT = $1,
        TYPEFLAG_FCANCREATE = $2,
        TYPEFLAG_FLICENSED = $4,
        TYPEFLAG_FPREDECLID = $8,
        TYPEFLAG_FHIDDEN = $10,
        TYPEFLAG_FCONTROL = $20,
        TYPEFLAG_FDUAL = $40,
        TYPEFLAG_FNONEXTENSIBLE = $80,
        TYPEFLAG_FOLEAUTOMATION = $100,
        TYPEFLAG_FRESTRICTED = $200,
        TYPEFLAG_FAGGREGATABLE = $400,
        TYPEFLAG_FREPLACEABLE = $800,
        TYPEFLAG_FDISPATCHABLE = $1000,
        TYPEFLAG_FREVERSEBIND = $2000,
        TYPEFLAG_FPROXY = $4000
        );

    TFUNCFLAGS = (
        FUNCFLAG_FRESTRICTED = $1,
        FUNCFLAG_FSOURCE = $2,
        FUNCFLAG_FBINDABLE = $4,
        FUNCFLAG_FREQUESTEDIT = $8,
        FUNCFLAG_FDISPLAYBIND = $10,
        FUNCFLAG_FDEFAULTBIND = $20,
        FUNCFLAG_FHIDDEN = $40,
        FUNCFLAG_FUSESGETLASTERROR = $80,
        FUNCFLAG_FDEFAULTCOLLELEM = $100,
        FUNCFLAG_FUIDEFAULT = $200,
        FUNCFLAG_FNONBROWSABLE = $400,
        FUNCFLAG_FREPLACEABLE = $800,
        FUNCFLAG_FIMMEDIATEBIND = $1000
        );

    TVARFLAGS = (
        VARFLAG_FREADONLY = $1,
        VARFLAG_FSOURCE = $2,
        VARFLAG_FBINDABLE = $4,
        VARFLAG_FREQUESTEDIT = $8,
        VARFLAG_FDISPLAYBIND = $10,
        VARFLAG_FDEFAULTBIND = $20,
        VARFLAG_FHIDDEN = $40,
        VARFLAG_FRESTRICTED = $80,
        VARFLAG_FDEFAULTCOLLELEM = $100,
        VARFLAG_FUIDEFAULT = $200,
        VARFLAG_FNONBROWSABLE = $400,
        VARFLAG_FREPLACEABLE = $800,
        VARFLAG_FIMMEDIATEBIND = $1000
        );

    TCLEANLOCALSTORAGE = record
        pInterface: IUnknown;
        pStorage: pointer;
        flags: DWORD;
    end;
    PCLEANLOCALSTORAGE = ^TCLEANLOCALSTORAGE;

    TCUSTDATAITEM = record
        guid: TGUID;
        varValue: TVARIANTARG;
    end;
    PCUSTDATAITEM = ^TCUSTDATAITEM;



    TCUSTDATA = record
        cCustData: DWORD;
        prgCustData: LPCUSTDATAITEM;
    end;
    PCUSTDATA = ^TCUSTDATA;




    ICreateTypeInfo = interface(IUnknown)
        ['{00020405-0000-0000-C000-000000000046}']
        function SetGuid(const guid: TGUID): HResult; stdcall;
        function SetTypeFlags(uTypeFlags: UINT): HResult; stdcall;
        function SetDocString(pStrDoc: POLESTR): HResult; stdcall;
        function SetHelpContext(dwHelpContext: DWORD): HResult; stdcall;
        function SetVersion(wMajorVerNum: word; wMinorVerNum: word): HResult; stdcall;
        function AddRefTypeInfo(pTInfo: ITypeInfo; phRefType: PHREFTYPE): HResult; stdcall;
        function AddFuncDesc(index: UINT; pFuncDesc: PFUNCDESC): HResult; stdcall;
        function AddImplType(index: UINT; hRefType: THREFTYPE): HResult; stdcall;
        function SetImplTypeFlags(index: UINT; implTypeFlags: INT32): HResult; stdcall;
        function SetAlignment(cbAlignment: word): HResult; stdcall;
        function SetSchema(pStrSchema: POLESTR): HResult; stdcall;
        function AddVarDesc(index: UINT; pVarDesc: PVARDESC): HResult; stdcall;
        function SetFuncAndParamNames(index: UINT; rgszNames: POLESTR; cNames: UINT): HResult; stdcall;
        function SetVarName(index: UINT; szName: POLESTR): HResult; stdcall;
        function SetTypeDescAlias(pTDescAlias: PTYPEDESC): HResult; stdcall;
        function DefineFuncAsDllEntry(index: UINT; szDllName: POLESTR; szProcName: POLESTR): HResult; stdcall;
        function SetFuncDocString(index: UINT; szDocString: POLESTR): HResult; stdcall;
        function SetVarDocString(index: UINT; szDocString: POLESTR): HResult; stdcall;
        function SetFuncHelpContext(index: UINT; dwHelpContext: DWORD): HResult; stdcall;
        function SetVarHelpContext(index: UINT; dwHelpContext: DWORD): HResult; stdcall;
        function SetMops(index: UINT; bstrMops: BSTR): HResult; stdcall;
        function SetTypeIdldesc(pIdlDesc: IDLDESC): HResult; stdcall;
        function LayOut(): HResult; stdcall;
    end;

    PICreateTypeInfo = ^ICreateTypeInfo;

    ICreateTypeInfo2 = interface(ICreateTypeInfo)
        ['{0002040E-0000-0000-C000-000000000046}']
        function DeleteFuncDesc(index: UINT): HResult; stdcall;
        function DeleteFuncDescByMemId(memid: TMEMBERID; invKind: TINVOKEKIND): HResult; stdcall;
        function DeleteVarDesc(index: UINT): HResult; stdcall;
        function DeleteVarDescByMemId(memid: TMEMBERID): HResult; stdcall;
        function DeleteImplType(index: UINT): HResult; stdcall;
        function SetCustData(const guid: TGUID; pVarVal: PVARIANT): HResult; stdcall;
        function SetFuncCustData(index: UINT; const guid: TGUID; pVarVal: PVARIANT): HResult; stdcall;
        function SetParamCustData(indexFunc: UINT; indexParam: UINT; const guid: TGUID; pVarVal: PVARIANT): HResult; stdcall;
        function SetVarCustData(index: UINT; const guid: TGUID; pVarVal: PVARIANT): HResult; stdcall;
        function SetImplTypeCustData(index: UINT; const guid: TGUID; pVarVal: PVARIANT): HResult; stdcall;
        function SetHelpStringContext(dwHelpStringContext: ULONG): HResult; stdcall;
        function SetFuncHelpStringContext(index: UINT; dwHelpStringContext: ULONG): HResult; stdcall;
        function SetVarHelpStringContext(index: UINT; dwHelpStringContext: ULONG): HResult; stdcall;
        function Invalidate(): HResult; stdcall;
        function SetName(szName: POLESTR): HResult; stdcall;
    end;

    PICreateTypeInfo2 = ^ICreateTypeInfo2;


    ICreateTypeLib = interface(IUnknown)
        ['{00020406-0000-0000-C000-000000000046}']
        function CreateTypeInfo(szName: POLESTR; tkind: TTYPEKIND; out ppCTInfo: ICreateTypeInfo): HResult; stdcall;
        function SetName(szName: POLESTR): HResult; stdcall;
        function SetVersion(wMajorVerNum: word; wMinorVerNum: word): HResult; stdcall;
        function SetGuid(const guid: TGUID): HResult; stdcall;
        function SetDocString(szDoc: POLESTR): HResult; stdcall;
        function SetHelpFileName(szHelpFileName: POLESTR): HResult; stdcall;
        function SetHelpContext(dwHelpContext: DWORD): HResult; stdcall;
        function SetLcid(lcid: TLCID): HResult; stdcall;
        function SetLibFlags(uLibFlags: UINT): HResult; stdcall;
        function SaveAllChanges(): HResult; stdcall;
    end;

    PICreateTypeLib = ^ICreateTypeLib;

    ICreateTypeLib2 = interface(ICreateTypeLib)
        ['{0002040F-0000-0000-C000-000000000046}']
        function DeleteTypeInfo(szName: POLESTR): HResult; stdcall;
        function SetCustData(const guid: TGUID; pVarVal: PVARIANT): HResult; stdcall;
        function SetHelpStringContext(dwHelpStringContext: ULONG): HResult; stdcall;
        function SetHelpStringDll(szFileName: POLESTR): HResult; stdcall;
    end;

    PICreateTypeLib2 = ^ICreateTypeLib2;


{ DISPID reserved to indicate an "unknown" name }
{ only reserved for data members (properties); reused as a method dispid below }
const
    DISPID_UNKNOWN = (-1);

    { DISPID reserved for the "value" property }
    DISPID_VALUE = (0);

{ The following DISPID is reserved to indicate the param
 * that is the right-hand-side (or "put" value) of a PropertyPut
 }
    DISPID_PROPERTYPUT = (-3);

    { DISPID reserved for the standard "NewEnum" method }
    DISPID_NEWENUM = (-4);

    { DISPID reserved for the standard "Evaluate" method }
    DISPID_EVALUATE = (-5);

    DISPID_CONSTRUCTOR = (-6);

    DISPID_DESTRUCTOR = (-7);

    DISPID_COLLECT = (-8);

{ The range -500 through -999 is reserved for Controls }
{ The range $80010000 through $8001FFFF is reserved for Controls }
{ The range -5000 through -5499 is reserved for ActiveX Accessability }
{ The range -2000 through -2499 is reserved for VB5 }
{ The range -3900 through -3999 is reserved for Forms }
{ The range -5500 through -5550 is reserved for Forms }
{ The remainder of the negative DISPIDs are reserved for future use }



type
    IDispatch = interface(IUnknown)
        ['{00020400-0000-0000-C000-000000000046}']
        function GetTypeInfoCount(out pctinfo: UINT): HResult; stdcall;
        function GetTypeInfo(iTInfo: UINT; lcid: TLCID; out ppTInfo: ITypeInfo): HResult; stdcall;
        function GetIDsOfNames(const riid: TIID; rgszNames: POLESTR; cNames: UINT; lcid: TLCID; out rgDispId: PDISPID): HResult; stdcall;
        function Invoke(dispIdMember: TDISPID; const riid: TIID; lcid: TLCID; wFlags: word; pDispParams: PDISPPARAMS;
            out pVarResult: TVARIANT; out pExcepInfo: TEXCEPINFO; out puArgErr: UINT): HResult; stdcall;
    end;

    PIDispatch = ^IDispatch;

    IEnumVARIANT = interface(IUnknown)
        ['{00020404-0000-0000-C000-000000000046}']
        function Next(celt: ULONG; out rgVar: PVARIANT; out pCeltFetched: ULONG): HResult; stdcall;
        function Skip(celt: ULONG): HResult; stdcall;
        function Reset(): HResult; stdcall;
        function Clone(out ppEnum: IEnumVARIANT): HResult; stdcall;
    end;


    PIEnumVARIANT = ^IEnumVARIANT;

    TDESCKIND = (
        DESCKIND_NONE = 0,
        DESCKIND_FUNCDESC = (DESCKIND_NONE + 1),
        DESCKIND_VARDESC = (DESCKIND_FUNCDESC + 1),
        DESCKIND_TYPECOMP = (DESCKIND_VARDESC + 1),
        DESCKIND_IMPLICITAPPOBJ = (DESCKIND_TYPECOMP + 1),
        DESCKIND_MAX = (DESCKIND_IMPLICITAPPOBJ + 1)
        );

    ITypeComp = interface;

    TBINDPTR = record
        case integer of
            0: (lpfuncdesc: PFUNCDESC);
            1: (lpvardesc: PVARDESC);
            2: (lptcomp: ITypeComp);
    end;
    PBINDPTR = ^TBINDPTR;


    ITypeComp = interface(IUnknown)
        ['{00020403-0000-0000-C000-000000000046}']
        function Bind(szName: LPOLESTR; lHashVal: ULONG; wFlags: word; out ppTInfo: ITypeInfo; out pDescKind: TDESCKIND;
            out pBindPtr: TBINDPTR): HResult; stdcall;
        function BindType(szName: LPOLESTR; lHashVal: ULONG; out ppTInfo: ITypeInfo; out ppTComp: ITypeComp): HResult; stdcall;
    end;

    PITypeComp = ^ITypeComp;


    ITypeInfo = interface(IUnknown)
        ['{00020401-0000-0000-C000-000000000046}']
        function GetTypeAttr(out ppTypeAttr: PTYPEATTR): HResult; stdcall;
        function GetTypeComp(out ppTComp: ITypeComp): HResult; stdcall;
        function GetFuncDesc(index: UINT; out ppFuncDesc: PFUNCDESC): HResult; stdcall;
        function GetVarDesc(index: UINT; out ppVarDesc: PVARDESC): HResult; stdcall;
        function GetNames(memid: TMEMBERID; rgBstrNames: PBSTR; cMaxNames: UINT; out pcNames: UINT): HResult; stdcall;
        function GetRefTypeOfImplType(index: UINT; out pRefType: THREFTYPE): HResult; stdcall;
        function GetImplTypeFlags(index: UINT; out pImplTypeFlags: INT32): HResult; stdcall;
        function GetIDsOfNames(rgszNames: LPOLESTR; cNames: UINT; out pMemId: PMEMBERID): HResult; stdcall;
        function Invoke(pvInstance: pointer; memid: TMEMBERID; wFlags: word; var pDispParams: TDISPPARAMS;
            out pVarResult: variant; out pExcepInfo: TEXCEPINFO; out puArgErr: UINT): HResult; stdcall;
        function GetDocumentation(memid: TMEMBERID; out pBstrName: BSTR; out pBstrDocString: BSTR; out pdwHelpContext: DWORD;
            out pBstrHelpFile: BSTR): HResult; stdcall;
        function GetDllEntry(memid: TMEMBERID; invKind: TINVOKEKIND; out pBstrDllName: BSTR; out pBstrName: BSTR;
            out pwOrdinal: word): HResult; stdcall;
        function GetRefTypeInfo(hRefType: THREFTYPE; out ppTInfo: ITypeInfo): HResult; stdcall;
        function AddressOfMember(memid: TMEMBERID; invKind: TINVOKEKIND; out ppv: pointer): HResult; stdcall;
        function CreateInstance(pUnkOuter: IUnknown; const riid: TIID; out ppvObj): HResult; stdcall;
        function GetMops(memid: TMEMBERID; out pBstrMops: BSTR): HResult; stdcall;
        function GetContainingTypeLib(out ppTLib: ITypeLib; out pIndex: UINT): HResult; stdcall;
        procedure ReleaseTypeAttr(pTypeAttr: PTYPEATTR); stdcall;
        procedure ReleaseFuncDesc(pFuncDesc: PFUNCDESC); stdcall;
        procedure ReleaseVarDesc(pVarDesc: PVARDESC); stdcall;
    end;

    PITypeInfo = ^ITypeInfo;

    ITypeInfo2 = interface(ITypeInfo)
        ['{00020412-0000-0000-C000-000000000046}']
        function GetTypeKind(out pTypeKind: TTYPEKIND): HResult; stdcall;
        function GetTypeFlags(out pTypeFlags: ULONG): HResult; stdcall;
        function GetFuncIndexOfMemId(memid: TMEMBERID; invKind: TINVOKEKIND; out pFuncIndex: UINT): HResult; stdcall;
        function GetVarIndexOfMemId(memid: TMEMBERID; out pVarIndex: UINT): HResult; stdcall;
        function GetCustData(const guid: TGUID; out pVarVal: variant): HResult; stdcall;
        function GetFuncCustData(index: UINT; const guid: TGUID; out pVarVal: variant): HResult; stdcall;
        function GetParamCustData(indexFunc: UINT; indexParam: UINT; const guid: TGUID; out pVarVal: variant): HResult; stdcall;
        function GetVarCustData(index: UINT; const guid: TGUID; out pVarVal: variant): HResult; stdcall;
        function GetImplTypeCustData(index: UINT; const guid: TGUID; out pVarVal: variant): HResult; stdcall;
        function GetDocumentation2(memid: TMEMBERID; lcid: TLCID; out pbstrHelpString: BSTR; out pdwHelpStringContext: DWORD;
            out pbstrHelpStringDll: BSTR): HResult; stdcall;
        function GetAllCustData(out pCustData: TCUSTDATA): HResult; stdcall;
        function GetAllFuncCustData(index: UINT; out pCustData: TCUSTDATA): HResult; stdcall;
        function GetAllParamCustData(indexFunc: UINT; indexParam: UINT; out pCustData: TCUSTDATA): HResult; stdcall;
        function GetAllVarCustData(index: UINT; out pCustData: TCUSTDATA): HResult; stdcall;
        function GetAllImplTypeCustData(index: UINT; out pCustData: TCUSTDATA): HResult; stdcall;
    end;

    PITypeInfo2 = ^ITypeInfo2;

    TSYSKIND = (
        SYS_WIN16 = 0,
        SYS_WIN32 = (SYS_WIN16 + 1),
        SYS_MAC = (SYS_WIN32 + 1),
        SYS_WIN64 = (SYS_MAC + 1)
        );
    PSYSKIND = ^TSYSKIND;

    TLIBFLAGS = (
        LIBFLAG_FRESTRICTED = $1,
        LIBFLAG_FCONTROL = $2,
        LIBFLAG_FHIDDEN = $4,
        LIBFLAG_FHASDISKIMAGE = $8
        );
    PLIBFLAGS = ^TLIBFLAGS;

    TTLIBATTR = record
        guid: TGUID;
        lcid: TLCID;
        syskind: TSYSKIND;
        wMajorVerNum: word;
        wMinorVerNum: word;
        wLibFlags: word;
    end;
    PTLIBATTR = ^TTLIBATTR;

    ITypeLib = interface(IUnknown)
        ['{00020402-0000-0000-C000-000000000046}']
        function GetTypeInfoCount(): UINT; stdcall;

        function GetTypeInfo(index: UINT; out ppTInfo: ITypeInfo): HResult; stdcall;

        function GetTypeInfoType(index: UINT; out pTKind: TTYPEKIND): HResult; stdcall;

        function GetTypeInfoOfGuid(const guid: TGUID; out ppTinfo: ITypeInfo): HResult; stdcall;

        function GetLibAttr(out ppTLibAttr: PTLIBATTR): HResult; stdcall;

        function GetTypeComp(out ppTComp: ITypeComp): HResult; stdcall;

        function GetDocumentation(index: INT32; out pBstrName: BSTR; out pBstrDocString: BSTR; out pdwHelpContext: DWORD;
            out pBstrHelpFile: BSTR): HResult; stdcall;

        function IsName(var szNameBuf: LPOLESTR; lHashVal: ULONG; out pfName: boolean): HResult; stdcall;

        function FindName(var szNameBuf: LPOLESTR; lHashVal: ULONG; out ppTInfo: PITypeInfo; out rgMemId: PMEMBERID;
            var pcFound: USHORT): HResult; stdcall;

        procedure ReleaseTLibAttr(pTLibAttr: PTLIBATTR); stdcall;

    end;

    PITypeLib = ^ITypeLib;


    ITypeLib2 = interface(ITypeLib)
        ['{00020411-0000-0000-C000-000000000046}']
        function GetCustData(const guid: TGUID; out pVarVal: variant): HResult; stdcall;
        function GetLibStatistics(out pcUniqueNames: ULONG; out pcchUniqueNames: ULONG): HResult; stdcall;
        function GetDocumentation2(index: INT32; lcid: LCID; out pbstrHelpString: BSTR; out pdwHelpStringContext: DWORD;
            out pbstrHelpStringDll: BSTR): HResult; stdcall;
        function GetAllCustData(out pCustData: TCUSTDATA): HResult; stdcall;
    end;

    PITypeLib2 = ^ITypeLib2;

    TCHANGEKIND = (
        CHANGEKIND_ADDMEMBER = 0,
        CHANGEKIND_DELETEMEMBER = (CHANGEKIND_ADDMEMBER + 1),
        CHANGEKIND_SETNAMES = (CHANGEKIND_DELETEMEMBER + 1),
        CHANGEKIND_SETDOCUMENTATION = (CHANGEKIND_SETNAMES + 1),
        CHANGEKIND_GENERAL = (CHANGEKIND_SETDOCUMENTATION + 1),
        CHANGEKIND_INVALIDATE = (CHANGEKIND_GENERAL + 1),
        CHANGEKIND_CHANGEFAILED = (CHANGEKIND_INVALIDATE + 1),
        CHANGEKIND_MAX = (CHANGEKIND_CHANGEFAILED + 1)
        );




    ITypeChangeEvents = interface(IUnknown)
        ['{00020410-0000-0000-C000-000000000046}']
        function RequestTypeChange(changeKind: TCHANGEKIND; pTInfoBefore: ITypeInfo; pStrName: POLESTR;
            out pfCancel: INT32): HResult; stdcall;
        function AfterTypeChange(changeKind: TCHANGEKIND; pTInfoAfter: ITypeInfo; pStrName: POLESTR): HResult; stdcall;
    end;

    PITypeChangeEvents = ^ITypeChangeEvents;



    IErrorInfo = interface(IUnknown)
        ['{1CF2B120-547D-101B-8E65-08002B2BD119}']
        function GetGUID(out pGUID: TGUID): HResult; stdcall;
        function GetSource(out pBstrSource: BSTR): HResult; stdcall;
        function GetDescription(out pBstrDescription: BSTR): HResult; stdcall;
        function GetHelpFile(out pBstrHelpFile: BSTR): HResult; stdcall;
        function GetHelpContext(out pdwHelpContext: DWORD): HResult; stdcall;
    end;

    PIErrorInfo = ^IErrorInfo;

    ICreateErrorInfo = interface(IUnknown)
        ['{22F03340-547D-101B-8E65-08002B2BD119}']
        function SetGUID(const rguid: TGUID): HResult; stdcall;
        function SetSource(szSource: POLESTR): HResult; stdcall;
        function SetDescription(szDescription: POLESTR): HResult; stdcall;
        function SetHelpFile(szHelpFile: POLESTR): HResult; stdcall;
        function SetHelpContext(dwHelpContext: DWORD): HResult; stdcall;
    end;

    PICreateErrorInfo = ^ICreateErrorInfo;


    ISupportErrorInfo = interface(IUnknown)
        ['{DF0B3D60-548F-101B-8E65-08002B2BD119}']
        function InterfaceSupportsErrorInfo(const riid: TIID): HResult; stdcall;
    end;

    PISupportErrorInfo = ^ISupportErrorInfo;

    ITypeFactory = interface(IUnknown)
        ['{0000002E-0000-0000-C000-000000000046}']
        function CreateFromTypeInfo(pTypeInfo: ITypeInfo; const riid: TGUID; out ppv: IUnknown): HResult; stdcall;
    end;


    ITypeMarshal = interface(IUnknown)
        ['{0000002D-0000-0000-C000-000000000046}']
        function Size(pvType: pointer; dwDestContext: DWORD; pvDestContext: pointer; out pSize: ULONG): HResult; stdcall;
        function Marshal(pvType: pointer; dwDestContext: DWORD; pvDestContext: pointer; cbBufferLength: ULONG;
            out pBuffer: PBYTE; out pcbWritten: ULONG): HResult; stdcall;
        function Unmarshal(out pvType: pointer; dwFlags: DWORD; cbBufferLength: ULONG; pBuffer: PBYTE;
            out pcbRead: ULONG): HResult; stdcall;
        function Free(pvType: pointer): HResult; stdcall;
    end;

    IRecordInfo = interface(IUnknown)
        ['{0000002F-0000-0000-C000-000000000046}']
        function RecordInit(out pvNew: pointer): HResult; stdcall;
        function RecordClear(pvExisting: pointer): HResult; stdcall;
        function RecordCopy(pvExisting: pointer; out pvNew: pointer): HResult; stdcall;
        function GetGuid(out pguid: TGUID): HResult; stdcall;
        function GetName(out pbstrName: BSTR): HResult; stdcall;
        function GetSize(out pcbSize: ULONG): HResult; stdcall;
        function GetTypeInfo(out ppTypeInfo: ITypeInfo): HResult; stdcall;
        function GetField(pvData: pointer; szFieldName: PCOLESTR; out pvarField: variant): HResult; stdcall;
        function GetFieldNoCopy(pvData: pointer; szFieldName: PCOLESTR; out pvarField: variant;
            out ppvDataCArray: pointer): HResult; stdcall;
        function PutField(wFlags: ULONG; var pvData: pointer; szFieldName: PCOLESTR; pvarField: PVARIANT): HResult; stdcall;
        function PutFieldNoCopy(wFlags: ULONG; var pvData: pointer; szFieldName: PCOLESTR; pvarField: PVARIANT): HResult; stdcall;
        function GetFieldNames(var pcNames: ULONG; out rgBstrNames: PBSTR): HResult; stdcall;
        function IsMatchingType(pRecordInfo: IRecordInfo): boolean; stdcall;
        function RecordCreate(): Pointer; stdcall;
        function RecordCreateCopy(pvSource: pointer; out ppvDest: pointer): HResult; stdcall;
        function RecordDestroy(pvRecord: pointer): HResult; stdcall;
    end;

    PIRecordInfo = ^IRecordInfo;


    IErrorLog = interface(IUnknown)
        ['{3127CA40-446E-11CE-8135-00AA004BB851}']
        function AddError(pszPropName: PCOLESTR; pExcepInfo: PEXCEPINFO): HResult; stdcall;
    end;

    PIErrorLog = ^IErrorLog;

    IPropertyBag = interface(IUnknown)
        ['{55272A00-42CB-11CE-8135-00AA004BB851}']
        function Read(pszPropName: PCOLESTR; var pVar: variant; pErrorLog: IErrorLog): HResult; stdcall;
        function Write(pszPropName: PCOLESTR; pVar: PVARIANT): HResult; stdcall;
    end;

    PIPropertyBag = ^IPropertyBag;



implementation

end.
