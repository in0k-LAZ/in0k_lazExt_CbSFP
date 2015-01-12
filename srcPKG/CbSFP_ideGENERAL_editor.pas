unit CbSFP_ideGENERAL_editor;

//----------------------\\-----------------------------------------------------=
//  ╔═╗┌┐ ╔═╗╔═╗╔═╗      \\  Configuration by Source File Path                 =
//  ║  ├┴┐╚═╗╠╣ ╠═╝      //  Конфигурация по пути исходного файла              =
//  ╚═╝└─┘╚═╝╚  ╩ v0.9  //   [ideGENERAL]                                      =
//---------------------//------------------------------------------------------=
// реализация ОСНОВНОГО пукта Меню и ОСНОВНОГО хранителя _Options
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

{$define ideLazExtMODE}  //<----------------------- боевой режм "Расширения IDE"

{$ifDef uiDevelopPRJ}
    {$undef ideLazExtMODE}
{$endif}

interface

uses IDEOptionsIntf, LCLIntf,  CbSFP_ideCenter,
    sysutils, Classes, StdCtrls, Buttons,
    CbSFP_ideGENERAL, CbSFP_ideGENERAL_config;

type

 { tCbSFP_ideGeneral_Editor }

 tCbSFP_ideGeneral_Editor=class(TAbstractIDEOptionsEditor)
    Button1: TButton;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    ListBox1: TListBox;
    Memo1: TMemo;
    SpeedButton1: TSpeedButton;
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
  protected
    procedure DEBUG(const msgType,msgText:string);
  public
    function GetTitle: String; override;
    class function SupportedOptionsClass:TAbstractIDEOptionsClass; override;
  public
    procedure Setup({%H-}ADialog:TAbstractOptionsEditorDialog); override;
    procedure ReadSettings ({%H-}AOptions:TAbstractIDEOptions); override;
    procedure WriteSettings({%H-}AOptions:TAbstractIDEOptions); override;
  end;


implementation
{.$ifdef ideLazExtMODE}

{.$endif}

{.$ifdef ideLazExtMODE}
const cCbSFP_ideGeneral_Editor__frmTitle=cIn0k_LazExt_CbSFP__Node_General;
{.$else}
//const cCbSFP_ideGeneral_Editor__frmTitle='';
{.$endif}

{$region tCbSFP_ideGeneral_Editor}
{$R *.lfm}

procedure tCbSFP_ideGeneral_Editor.SpeedButton1Click(Sender: TObject);
begin
    OpenDocument(Edit1.Text)
end;

procedure tCbSFP_ideGeneral_Editor.Button1Click(Sender: TObject);
begin
    CbSFP_ideCenter_DEBUG_Show;
end;

constructor tCbSFP_ideGeneral_Editor.Create(TheOwner:TComponent);
begin
    inherited;
    {$ifDEF ideLazExtMODE}
        SpeedButton1.LoadGlyphFromLazarusResource('laz_open');
    {$endIF}
end;

destructor tCbSFP_ideGeneral_Editor.Destroy;
begin
    inherited;
end;

//------------------------------------------------------------------------------

function tCbSFP_ideGeneral_Editor.GetTitle:String;
begin
    result:=cCbSFP_ideGeneral_Editor__frmTitle;
end;

class function tCbSFP_ideGeneral_Editor.SupportedOptionsClass:TAbstractIDEOptionsClass;
begin
    result:=tCbSFP_ideGeneral_Config;
end;

//------------------------------------------------------------------------------

{$ifOpt D+}
procedure tCbSFP_ideGeneral_Editor.DEBUG(const msgType,msgText:string);
begin
    CbSFP_ideCenter_DEBUG_main(nil,msgType,msgText);
end;
{$endIf}

//------------------------------------------------------------------------------

procedure tCbSFP_ideGeneral_Editor.Setup(ADialog:TAbstractOptionsEditorDialog);
begin
   {$ifOpt D+}
       DEBUG('M','Setup ..');
   {$endIf}
   //--------------------------------------------------------------------------
   // do nofing
   //--------------------------------------------------------------------------
   {$ifOpt D+}
       DEBUG('M','Setup 0k');
   {$endIf}
end;

procedure tCbSFP_ideGeneral_Editor.ReadSettings(AOptions:TAbstractIDEOptions);
begin
    {$ifOpt D+}
        DEBUG('M','ReadSettings ..');
    {$endIf}
    //--------------------------------------------------------------------------
    //CbSFP_ideCenter_DEBUG('M','ReadSettings');
    Edit1.Text:=CbSFP_ConfigsRootPath;
    memo1.Append('ReadSettings'+IntToHex(integer(AOptions),8));
    if AOptions is tCbSFP_ideGeneral_Config
    then begin
       memo1.Append('OK TYPE');
       //if _CbSFP_ideGeneral_Config_=AOptions then memo1.Append('OK');
       if AOptions=NIL then memo1.Append('NIL');
    end;
    //--------------------------------------------------------------------------
    {$ifOpt D+}
        DEBUG('M','ReadSettings 0k');
    {$endIf}
end;

procedure tCbSFP_ideGeneral_Editor.WriteSettings(AOptions:TAbstractIDEOptions);
begin
   {$ifOpt D+}
       DEBUG('M','WriteSettings ..');
   {$endIf}
   //--------------------------------------------------------------------------

   memo1.Append('WriteSettings'+IntToHex(integer(AOptions),8));
   if AOptions is tCbSFP_ideGeneral_Config
   then begin
      memo1.Append('OK TYPE');
      //if _CbSFP_ideGeneral_Config_=AOptions then memo1.Append('OK');
      if AOptions=NIL then memo1.Append('NIL');
   end;
   //--------------------------------------------------------------------------
   {$ifOpt D+}
       DEBUG('M','WriteSettings 0k');
   {$endIf}
end;
{$endRegion}

end.

