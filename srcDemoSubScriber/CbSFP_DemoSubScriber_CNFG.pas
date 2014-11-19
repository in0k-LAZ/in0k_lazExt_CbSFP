unit CbSFP_DemoSubScriber_CNFG;

//----------------------\\-----------------------------------------------------=
//  ╔═╗┌┐ ╔═╗╔═╗╔═╗      \\  Configuration by Source File Path                 =
//  ║  ├┴┐╚═╗╠╣ ╠═╝      //  Конфигурация по пути исходного файла              =
//  ╚═╝└─┘╚═╝╚  ╩ v0.9  //   [custom CNFG]                                     =
//---------------------//------------------------------------------------------=
// пример реализации "пользовательской конфигурации"
//------------------------------------------------------------------------------

{$mode objfpc}{$H+}

interface

type

 rCbSFP_DemoSubScriber_CNFG=record
    III:integer;
    SSS:string;
  end;
 pCbSFP_DemoSubScriber_CNFG=^rCbSFP_DemoSubScriber_CNFG;

function  CbSFP_DemoSubScriber_CNFG__CRT          :pCbSFP_DemoSubScriber_CNFG;
procedure CbSFP_DemoSubScriber_CNFG__DST(const Obj:pCbSFP_DemoSubScriber_CNFG);
procedure CbSFP_DemoSubScriber_CNFG__DEF(const Obj:pCbSFP_DemoSubScriber_CNFG);

implementation

function CbSFP_DemoSubScriber_CNFG__CRT:pCbSFP_DemoSubScriber_CNFG;
begin
    new(pCbSFP_DemoSubScriber_CNFG(result))
end;

procedure CbSFP_DemoSubScriber_CNFG__DST(const Obj:pCbSFP_DemoSubScriber_CNFG);
begin
    dispose(Obj)
end;

procedure CbSFP_DemoSubScriber_CNFG__DEF(const Obj:pCbSFP_DemoSubScriber_CNFG);
begin
    Obj^.III:=0;
    Obj^.SSS:=''
end;

end.

