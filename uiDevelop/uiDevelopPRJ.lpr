program uiDevelopPRJ;

//----------------------\\-----------------------------------------------------=
//  ╔═╗┌┐ ╔═╗╔═╗╔═╗      \\  Configuration by Source File Path                 =
//  ║  ├┴┐╚═╗╠╣ ╠═╝      //  Конфигурация по пути исходного файла              =
//  ╚═╝└─┘╚═╝╚  ╩ v0.9  //   [uiDevelopPRJ]                                    =
//---------------------//------------------------------------------------------=
// приложение для разработки пользовательского интерфейса (тестовое)
// !!! ВНИМАНИЕ !!! для компиляции должен быть параметр [-duiDevelopPRJ]
//------------------------------------------------------------------------------

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  //---
  uiDevelopWND,
  //---
  CbSFP_SubScriber,
  CbSFP_ideEditor,
  CbSFP_ideCenter,
  //---
  CbSFP_DemoSubScriber_CNFG,
  CbSFP_DemoSubScriber_HNDL,
  CbSFP_DemoSubScriber_EDTR;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TmainWND, mainWND);
  Application.Run;
end.

