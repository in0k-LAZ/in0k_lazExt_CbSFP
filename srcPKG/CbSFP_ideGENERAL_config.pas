unit CbSFP_ideGENERAL_config;

//----------------------\\-----------------------------------------------------=
//  ╔═╗┌┐ ╔═╗╔═╗╔═╗      \\  Configuration by Source File Path                 =
//  ║  ├┴┐╚═╗╠╣ ╠═╝      //  Конфигурация по пути исходного файла              =
//  ╚═╝└─┘╚═╝╚  ╩ v0.9  //   [ideGENERAL]                                      =
//---------------------//------------------------------------------------------=
// реализация ОСНОВНОГО хранителя.
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

uses IDEOptionsIntf, LazConfigStorage, BaseIDEIntf,
  sysutils;

type

  tCbSFP_ideGeneral_Config=class(TAbstractIDEEnvironmentOptions)
   protected
    _mustSAVE:boolean;
   protected //< почемуто рекомендуют использовать именно это
     function _ConfigStorage_get:TConfigStorage;
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
     procedure SubScriber_saveEditorVALUEs(const INDF:string; const V1,V2:integer);
     procedure SubScriber_loadEditorVALUEs(const INDF:string; out   V1,V2:integer);
   end;


implementation
{$ifDef ideLazExtMODE}
uses CbSFP_ideGENERAL;
{$endif}

{$ifdef ideLazExtMODE}
const cCbSFP_ideGeneral_Config__GroupGeneral=cIn0k_LazExt_CbSFP__GroupGeneral;
{$else}
const cCbSFP_ideGeneral_Config__GroupGeneral='';
{$endif}


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
    result:=cCbSFP_ideGeneral_Config__GroupGeneral;
end;

class function tCbSFP_ideGeneral_Config.GetInstance:TAbstractIDEOptions;
begin
    result:=_CbSFP_ideGeneral_Config__GET_;
end;


//------------------------------------------------------------------------------

function tCbSFP_ideGeneral_Config._ConfigStorage_get:TConfigStorage;
begin
    result:=GetIDEConfigStorage(
        CbSFP_ideGENERAL__Config_fileName,
        FileExists(CbSFP_ideGENERAL__Config_fileName) //< если он есть то ЧИТАЕМ
                );
end;

//------------------------------------------------------------------------------

procedure tCbSFP_ideGeneral_Config._Init;
begin
    {do-Nothing}
end;

procedure tCbSFP_ideGeneral_Config._Save;
var Config:TConfigStorage;
begin
    Config:=_ConfigStorage_get;
    try if Assigned(Config) then begin
            //Config.SetDeleteValue(cCBSP__General_Options__enabled,_enabled,cIn0k_LazExt_CBSP_def_Enabled);
            //Config.SetDeleteValue('dd','asdfasdf','asdf');
        end;
       _mustSAVE:=false;
    finally
        Config.Free;
    end;
end;

procedure tCbSFP_ideGeneral_Config._Load;
var Config:TConfigStorage;
begin
    Config:=_ConfigStorage_get;
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

const
  cPathDELIM='/';
  cNodeName_V1='V1';
  cNodeName_V2='V2';

procedure tCbSFP_ideGeneral_Config.SubScriber_saveEditorVALUEs(const INDF:string; const V1,V2:integer);
var Config:TConfigStorage;
begin
    Config:=_ConfigStorage_get;
    try Config.SetValue(INDF+cPathDELIM+cNodeName_V1,V1);
        Config.SetValue(INDF+cPathDELIM+cNodeName_V2,V2);
        Config.WriteToDisk;
    finally
       Config.Free;
    end;
end;

procedure tCbSFP_ideGeneral_Config.SubScriber_loadEditorVALUEs(const INDF:string; out V1,V2:integer);
var Config:TConfigStorage;
begin
    Config:=_ConfigStorage_get;
    try V1:=Config.GetValue(INDF+cPathDELIM+cNodeName_V1,V1);
        V2:=Config.GetValue(INDF+cPathDELIM+cNodeName_V2,V2);
    finally
       Config.Free;
    end;
end;

initialization
   _CbSFP_ideOptions__INI_;

finalization
   _CbSFP_ideOptions__DST_;

end.

