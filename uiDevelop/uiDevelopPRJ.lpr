program uiDevelopPRJ;

//----------------------\\-----------------------------------------------------=
//  ╔═╗┌┐ ╔═╗╔═╗╔═╗      \\  Configuration by Source File Path                 =
//  ║  ├┴┐╚═╗╠╣ ╠═╝      //  Конфигурация по пути исходного файла              =
//  ╚═╝└─┘╚═╝╚  ╩ v0.9  //   [uiDevelopPRJ]                                    =
//---------------------//------------------------------------------------------=
// приложение для разработки пользовательского интерфейса (тестовое)
// !!! ВНИМАНИЕ !!! для компиляции должен быть параметр [-duiDevelopPRJ]
//------------------------------------------------------------------------------

{/--[License]-[fold]----------------------------------------------------//
//                                                                      //----//
//  Copyright 2014 in0k                                                       //
//                                                                            //
//  Licensed under the Apache License, Version 2.0 (the "License");           //
//  you may not use this file except in compliance with the License.          //
//  You may obtain a copy of the License at                                   //
//                                                                            //
//      http://www.apache.org/licenses/LICENSE-2.0                            //
//                                                                            //
//  Unless required by applicable law or agreed to in writing, software       //
//  distributed under the License is distributed on an "AS IS" BASIS,         //
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  //
//  See the License for the specific language governing permissions and       //
//  limitations under the License.                                            //
//                                                                            //
//----------------------------------------------------------------------------/}

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
//        wnd_DEBUG
  //---
  CbSFP_DemoSubScriber_CNFG, CbSFP_DemoSubScriber_HNDL,
  CbSFP_DemoSubScriber_EDTR, CbSFP_wnd_DEBUG, CbSFP_ideGENERAL_editor,
  CbSFP_ideGENERAL_config, uiGeneralWND;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TmainWND, mainWND);
  Application.CreateForm(TGnrlWND, GnrlWND);
  Application.Run;
end.

