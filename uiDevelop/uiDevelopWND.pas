unit uiDevelopWND;

//----------------------\\-----------------------------------------------------=
//  ╔═╗┌┐ ╔═╗╔═╗╔═╗      \\  Configuration by Source File Path                 =
//  ║  ├┴┐╚═╗╠╣ ╠═╝      //  Конфигурация по пути исходного файла              =
//  ╚═╝└─┘╚═╝╚  ╩ v0.9  //   [uiDevelopWND]                                    =
//---------------------//------------------------------------------------------=
// окошко для эмулирования поведения IDEOptionsDlg.TIDEOptionsDialog
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

uses Forms, Dialogs, ExtCtrls, StdCtrls, EditBtn,
  //--- что тестируем
  CbSFP_ideGENERAL_config,
  CbSFP_ideCenter, CbSFP_ideEditor, CbSFP_SubScriber,   CbSFP__Intf,
  //--- чем тестируем
  CbSFP_DemoSubScriber_HNDL, //< тестовый Обработчик
  CbSFP_DemoSubScriber_EDTR, Classes; //< тестовый Редактор

type

  { TmainWND }

  TmainWND = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CbSFP_ideCallEditor1: TCbSFP_ideCallEditor;
    Panel1: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    SubScriber:tCbSFP_SubScriber;
  end;

var mainWND: TmainWND;

implementation

{$R *.lfm}

procedure TmainWND.FormCreate(Sender: TObject);
begin
    CbSFP_ideCenter_DEBUG_Show;
    // регистрируем ЕДИНСТВЕННОГО абонента в системе
    SubScriber:=CbSFP_SubScriber__REGISTER(tCbSFP_DemoSubScriber_HNDL,TCbSFP_DemoSubScriber_EDTR);
end;

//------------------------------------------------------------------------------

procedure TmainWND.FormShow(Sender: TObject);
begin
    Caption:=CbSFP_ideCallEditor1.GetTitle;
    // эмулирует поведение IDEOptionsDlg.TIDEOptionsDialog.CreateEditors
    // ... чето-делает
    CbSFP_ideCallEditor1.Setup(nil);
    // ... чето-делает
    CbSFP_ideCallEditor1.ReadSettings(CbSFP_ideGeneral_Config__GET);
end;

//------------------------------------------------------------------------------

procedure TmainWND.Button1Click(Sender:TObject);
begin
    CbSFP_ideCallEditor1.WriteSettings(CbSFP_ideGeneral_Config__GET);
end;

procedure TmainWND.Button2Click(Sender:TObject);
begin
    CbSFP_ideCallEditor1.RestoreSettings(CbSFP_ideGeneral_Config__GET);
end;

end.

