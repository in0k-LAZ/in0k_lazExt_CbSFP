unit CbSFP_DemoSubScriber_EDTR;

//----------------------\\-----------------------------------------------------=
//  ╔═╗┌┐ ╔═╗╔═╗╔═╗      \\  Configuration by Source File Path                 =
//  ║  ├┴┐╚═╗╠╣ ╠═╝      //  Конфигурация по пути исходного файла              =
//  ╚═╝└─┘╚═╝╚  ╩ v0.9  //   [custom EDTR]                                     =
//---------------------//------------------------------------------------------=
// пример реализации "пользовательского редактора для конфигурации"
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

uses SysUtils, StdCtrls,
  CbSFP_SubScriber,
  CbSFP_DemoSubScriber_CNFG;

type

  TCbSFP_DemoSubScriber_EDTR = class(TCbSFP_SubScriber_editor)
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
  private
    procedure _custom_load_(const config:pCbSFP_DemoSubScriber_CNFG);
    procedure _custom_save_(const config:pCbSFP_DemoSubScriber_CNFG);
  public
    procedure Settings_LOAD(const Obj:tCbSFP_SubScriber_cnfOBJ); override;
    procedure Settings_SAVE(const Obj:tCbSFP_SubScriber_cnfOBJ); override;
  end;

implementation

{$R *.lfm}

procedure TCbSFP_DemoSubScriber_EDTR.Settings_LOAD(const Obj:tCbSFP_SubScriber_cnfOBJ);
begin
   _custom_load_(pCbSFP_DemoSubScriber_CNFG(Obj));
end;

procedure TCbSFP_DemoSubScriber_EDTR.Settings_SAVE(const Obj:tCbSFP_SubScriber_cnfOBJ);
begin
   _custom_save_(pCbSFP_DemoSubScriber_CNFG(Obj));
end;

//------------------------------------------------------------------------------

procedure TCbSFP_DemoSubScriber_EDTR._custom_load_(const config:pCbSFP_DemoSubScriber_CNFG);
begin
    edit1.Text:=IntToStr(config^.INT);
    edit2.Text:=config^.TXT;
end;

procedure TCbSFP_DemoSubScriber_EDTR._custom_save_(const config:pCbSFP_DemoSubScriber_CNFG);
begin
    config^.INT:=strtoint(edit1.Text);
    config^.TXT:=edit2.Text;
end;

end.

