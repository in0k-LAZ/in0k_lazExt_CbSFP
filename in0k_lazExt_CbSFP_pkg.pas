{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit in0k_lazExt_CbSFP_pkg;

interface

uses
  CbSFP__Intf, CbSFP_SubScriber, CbSFP_ideCenter, CbSFP_ideEditor, 
  CbSFP_ideGENERAL, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('CbSFP_ideCenter', @CbSFP_ideCenter.Register);
end;

initialization
  RegisterPackage('in0k_lazExt_CbSFP_pkg', @Register);
end.
