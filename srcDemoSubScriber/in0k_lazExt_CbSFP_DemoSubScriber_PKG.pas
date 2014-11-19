{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit in0k_lazExt_CbSFP_DemoSubScriber_PKG;

interface

uses
  in0k_lazExt_CbSFP_DemoSubScriber_reg, CbSFP_DemoSubScriber_CNFG, 
  CbSFP_DemoSubScriber_EDTR, CbSFP_DemoSubScriber_HNDL, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('in0k_lazExt_CbSFP_DemoSubScriber_reg', 
    @in0k_lazExt_CbSFP_DemoSubScriber_reg.Register);
end;

initialization
  RegisterPackage('in0k_lazExt_CbSFP_DemoSubScriber_PKG', @Register);
end.
