unit Win32.DirectXMath;

{$mode delphi}

interface

uses
  Classes, SysUtils;

type
  //------------------------------------------------------------------------------
// 3D Vector; 32 bit floating point components

{ TXMFLOAT3 }

TXMFLOAT3 = record
     x:single;
     y:single;
     z:single;

(*    XMFLOAT3() XM_CTOR_DEFAULT
    XM_CONSTEXPR XMFLOAT3(float _x, float _y, float _z) : x(_x), y(_y), z(_z) {}
    explicit XMFLOAT3(_In_reads_(3) const float *pArray) : x(pArray[0]), y(pArray[1]), z(pArray[2]) {}    *)
end;

implementation

{ TXMFLOAT3 }

end.

