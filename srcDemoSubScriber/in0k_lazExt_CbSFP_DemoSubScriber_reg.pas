unit in0k_lazExt_CbSFP_DemoSubScriber_reg;

//----------------------\\-----------------------------------------------------=
//  ╔═╗┌┐ ╔═╗╔═╗╔═╗      \\  Configuration by Source File Path                 =
//  ║  ├┴┐╚═╗╠╣ ╠═╝      //  Конфигурация по пути исходного файла              =
//  ╚═╝└─┘╚═╝╚  ╩ v0.9  //                                                     =
//---------------------//------------------------------------------------------=
// пример реализации регистрации в системе
//------------------------------------------------------------------------------

{$mode objfpc}{$H+}

interface

uses CbSFP__Intf, CbSFP_DemoSubScriber_EDTR, CbSFP_DemoSubScriber_HNDL;

procedure Register;

implementation

procedure Register;
begin
    CbSFP_SubScriber__REGISTER(tCbSFP_DemoSubScriber_HNDL,TCbSFP_DemoSubScriber_EDTR);
end;

end.

