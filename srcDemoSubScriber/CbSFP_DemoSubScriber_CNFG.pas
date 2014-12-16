unit CbSFP_DemoSubScriber_CNFG;

//----------------------\\-----------------------------------------------------=
//  ╔═╗┌┐ ╔═╗╔═╗╔═╗      \\  Configuration by Source File Path                 =
//  ║  ├┴┐╚═╗╠╣ ╠═╝      //  Конфигурация по пути исходного файла              =
//  ╚═╝└─┘╚═╝╚  ╩ v0.9  //   [custom CNFG]                                     =
//---------------------//------------------------------------------------------=
// пример реализации "пользовательской конфигурации"
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
    Obj^.III:=10;
    Obj^.SSS:='test'
end;

end.

