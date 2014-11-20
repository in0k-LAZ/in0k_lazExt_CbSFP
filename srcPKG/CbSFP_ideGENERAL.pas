unit CbSFP_ideGENERAL;

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

interface

uses IDEOptionsIntf, LazIDEIntf, LazFileUtils, LazConfigStorage, BaseIDEIntf,
  StdCtrls, Buttons, Classes, CbSFP_SubScriber, CbSFP_ideEditor;


const

  cIn0k_LazExt_CbSFP__IDENTIFICATOR='in0k_LazExt_CbSFP';
  cIn0k_LazExt_CbSFP__GroupGeneral ='Config by SRC file path';
  cIn0k_LazExt_CbSFP__Node_General ='General';

  cIn0k_LazExt_CbSFP__defCnfFileExt='.xml';

type

  tCbSFP_ideGeneral_Config=class(TAbstractIDEEnvironmentOptions)
   protected
    _mustSAVE:boolean;
   protected
     procedure _Init;
     procedure _Save;
     procedure _Load;
   public
     constructor Create;
     destructor Destroy; override;
   public
     class function GetGroupCaption: string;         override;
     class function GetInstance:TAbstractIDEOptions; override;
   public
     procedure LOAD;
     procedure SAVE;
   end;


  type

 { tCbSFP_ideGeneral_Editor }

 tCbSFP_ideGeneral_Editor=class(TAbstractIDEOptionsEditor)
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Memo1: TMemo;
    SpeedButton1: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
  public
    function GetTitle: String; override;
    class function SupportedOptionsClass:TAbstractIDEOptionsClass; override;
  public
    procedure Setup({%H-}ADialog:TAbstractOptionsEditorDialog); override;
    procedure ReadSettings ({%H-}AOptions:TAbstractIDEOptions); override;
    procedure WriteSettings({%H-}AOptions:TAbstractIDEOptions); override;
  end;


// директория внутри которой будем хранить наши настройки
function CbSFP_ideGENERAL__ConfigsRootPath:string;

function CbSFP_ideGENERAL__register_SubScrbr(const AGroup,AIndex:Integer;
            const AParent:Integer=NoParent
            ):tCbSFP_SubScriber;
function CbSFP_ideGENERAL__register_SubScrbr:tCbSFP_SubScriber;



procedure Register;

function CbSFP_ideGENERAL__ConfigFileName:string;

implementation

{%region --- tCbSFP_ideGeneral_Config  -----------------------------------}

function CbSFP_ideGENERAL__ConfigFileName:string;
begin
   result:=LazarusIDE.GetPrimaryConfigPath;
   result:=AppendPathDelim(result)+cIn0k_LazExt_CbSFP__IDENTIFICATOR;
end;

function CbSFP_ideGENERAL__ConfigsRootPath:string;
begin
    result:=LazarusIDE.GetPrimaryConfigPath;
    result:=AppendPathDelim(result);
    result:=result+cIn0k_LazExt_CbSFP__IDENTIFICATOR;
    result:=AppendPathDelim(CbSFP_ideGENERAL__ConfigFileName);
end;

{%endregion}


var

 _CBSP_IdeOptions_GRP_:PIDEOptionsGroupRec;
 _CBSP_IdeOtnsEDT_GNR_:PIDEOptionsEditorRec;

function _Ide_OptnCBSP_isRGSTER:boolean;
begin
    result:=( Assigned(_CBSP_IdeOptions_GRP_) and Assigned(_CBSP_IdeOtnsEDT_GNR_));
end;

procedure _Ide_OptnCBSP_REGISTER;
begin
    _CBSP_IdeOptions_GRP_:=RegisterIDEOptionsGroup (GroupEditor                 ,tCbSFP_ideGeneral_Config,TRUE);
    _CBSP_IdeOtnsEDT_GNR_:=RegisterIDEOptionsEditor(_CBSP_IdeOptions_GRP_^.Index,tCbSFP_ideGeneral_Editor,0);
end;

procedure REGISTER_in_IdeOptions;
begin
    if not _Ide_OptnCBSP_isRGSTER then _Ide_OptnCBSP_REGISTER;
end;

procedure Register;
begin
    REGISTER_in_IdeOptions;
end;


function CbSFP_ideGENERAL__register_SubScrbr(
            const AGroup,AIndex:Integer;
            const AParent:Integer=NoParent
            ):tCbSFP_SubScriber;
begin
    result:=RegisterIDEOptionsEditor(AGroup,tCbSFP_ideCallEditor,AIndex,AParent,TRUE);
end;

function CbSFP_ideGENERAL__register_SubScrbr:tCbSFP_SubScriber;
begin
    result:=CbSFP_ideGENERAL__register_SubScrbr(_CBSP_IdeOptions_GRP_^.Index,GetFreeIDEOptionsIndex(_CBSP_IdeOptions_GRP_^.Index,0));
end;



{$region tCbSFP_ideGeneral_Config}

//------------------------------------------------------------------------------
{%region --- INSTANCE --------------------------------------------= /fold}

var _CbSFP_ideGeneral_Config_:tCbSFP_ideGeneral_Config;

procedure _CbSFP_ideOptions__INI_; inline;
begin
   _CbSFP_ideGeneral_Config_:=nil;
end;

procedure _CbSFP_ideOptions__DST_; inline;
begin
   _CbSFP_ideGeneral_Config_.Free;
   _CbSFP_ideGeneral_Config_:=nil;
end;

function _CbSFP_ideGeneral_Config__GET_:tCbSFP_ideGeneral_Config; inline;
begin
    if not Assigned(_CbSFP_ideGeneral_Config_) then begin
       _CbSFP_ideGeneral_Config_:=tCbSFP_ideGeneral_Config.Create;
    end;
    result:=_CbSFP_ideGeneral_Config_;
end;

{%endregion}
//------------------------------------------------------------------------------

constructor tCbSFP_ideGeneral_Config.Create;
begin
    inherited;
   _Init;
   _Load;
end;

destructor tCbSFP_ideGeneral_Config.Destroy;
begin
    if _mustSAVE then _Save; //< сохранимся если надо
   _CbSFP_ideGeneral_Config_:=NIL;  //< отпишимся от поддержки ЭКЗЕМПЛЯРА
    inherited;
end;

//------------------------------------------------------------------------------

class function tCbSFP_ideGeneral_Config.GetGroupCaption:string;
begin
    result:=cIn0k_LazExt_CbSFP__GroupGeneral;
end;

class function tCbSFP_ideGeneral_Config.GetInstance:TAbstractIDEOptions;
begin
    result:=_CbSFP_ideGeneral_Config__GET_;
end;

//------------------------------------------------------------------------------

const cCbSFP__General_Options__fileName='qwe';//cIn0k_LazExt_CbSFP__IDENTIFICATOR+cIn0k_LazExt_CbSFP__defCnfFileExt;


procedure tCbSFP_ideGeneral_Config._Init;
begin
    //_enabled:=cIn0k_LazExt_CbSFP__def_Enabled;
    //_CNFsDIR:=CbSFP_ideGENERAL__ConfigsRootPath;
end;

procedure tCbSFP_ideGeneral_Config._Save;
var Config:TConfigStorage;
begin
    Config:=GetIDEConfigStorage(cCbSFP__General_Options__fileName,false);
    try if Assigned(Config) then begin
            //Config.SetDeleteValue(cCBSP__General_Options__enabled,_enabled,cIn0k_LazExt_CBSP_def_Enabled);
            Config.SetDeleteValue('dd','asdfasdf','asdf');
        end;
       _mustSAVE:=false;
    finally
        Config.Free;
    end;
end;

procedure tCbSFP_ideGeneral_Config._Load;
var Config:TConfigStorage;
begin
    Config:=GetIDEConfigStorage(cCbSFP__General_Options__fileName,true);
    try if Assigned(Config) then begin
        //   _enabled:=Config.GetValue(cCBSP__General_Options__enabled,cIn0k_LazExt_CBSP_def_Enabled);
        //   _CNFsDIR:=Config.GetValue(cCBSP__General_Options__CNFsDIR,_get_defaultCNFsDIR);
        end;
       _mustSAVE:=false;
    finally
       Config.Free;
    end;
end;

//------------------------------------------------------------------------------

procedure tCbSFP_ideGeneral_Config.LOAD;
begin
    {doNofing}//--- мы загружаемся ОДИН раз в момент создания
end;

procedure tCbSFP_ideGeneral_Config.SAVE;
begin
    if _mustSAVE then _Save;
end;
{$endRegion}

{$region tCbSFP_ideGeneral_Editor}
{$R *.lfm}

procedure tCbSFP_ideGeneral_Editor.SpeedButton1Click(Sender: TObject);
begin
   // OpenDocument(Edit1.Text)
end;

constructor tCbSFP_ideGeneral_Editor.Create(TheOwner:TComponent);
begin
    inherited;
    SpeedButton1.LoadGlyphFromLazarusResource('laz_open');
end;

destructor tCbSFP_ideGeneral_Editor.Destroy;
begin
    inherited;
end;

//------------------------------------------------------------------------------

function tCbSFP_ideGeneral_Editor.GetTitle:String;
begin
    result:=cIn0k_LazExt_CbSFP__Node_General;
end;

class function tCbSFP_ideGeneral_Editor.SupportedOptionsClass:TAbstractIDEOptionsClass;
begin
    result:=tCbSFP_ideGeneral_Config;
end;

//------------------------------------------------------------------------------

procedure tCbSFP_ideGeneral_Editor.Setup(ADialog:TAbstractOptionsEditorDialog);
begin
    memo1.Append('Setup');
end;

procedure tCbSFP_ideGeneral_Editor.ReadSettings(AOptions:TAbstractIDEOptions);
begin
    {memo1.Append('ReadSettings'+IntToHex(integer(AOptions),8));
    if AOptions is tCbSFP_ideGeneral_Config
    then begin
       memo1.Append('OK TYPE');
       if _CbSFP_ideOptions_=AOptions then memo1.Append('OK');
       if _CbSFP_ideOptions_=NIL then memo1.Append('NIL');
    end;}


    {if AOptions is tCbSFP_ideGeneral_Config then
        with tCbSFP_ideGeneral_Config(AOptions) do begin
            LOAD;
            //---
            CheckBox1.Checked:=enabled;
            Edit1.Text:=CNFsDIR;
        end;}
end;

procedure tCbSFP_ideGeneral_Editor.WriteSettings(AOptions:TAbstractIDEOptions);
begin
   {memo1.Append('WriteSettings'+IntToHex(integer(AOptions),8));
   if AOptions is tCbSFP_ideGeneral_Config
   then begin
      memo1.Append('OK TYPE');
      if _CbSFP_ideOptions_=AOptions then memo1.Append('OK');
   end;}
   { if AOptions is tCbSFP_ideGeneral_Config then
        with tCbSFP_ideGeneral_Config(AOptions) do begin
            enabled:=CheckBox1.Checked;
            CNFsDIR:=DirectoryEdit1.Directory;
            //---
            SAVE;
        end; }
end;
{$endRegion}


initialization
   _CbSFP_ideOptions__INI_;

finalization
   _CbSFP_ideOptions__DST_;

end.

