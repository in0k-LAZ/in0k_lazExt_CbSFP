{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit in0k_lazExt_CbSFP_pkg;

interface

uses
  CbSFP_ideGENERAL, CbSFP_ideREGISTER, CbSFP__Intf, CbSFP_SubScriber, 
  CbSFP_ideEditor, CbSFP_ideCenter, CbSFP_ideGENERAL_editor, 
  CbSFP_ideGENERAL_config, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('CbSFP_ideREGISTER', @CbSFP_ideREGISTER.Register);
end;

initialization
  RegisterPackage('in0k_lazExt_CbSFP_pkg', @Register);
end.
