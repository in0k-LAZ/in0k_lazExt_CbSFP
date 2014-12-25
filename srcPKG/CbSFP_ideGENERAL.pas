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

uses LazFileUtils, sysutils,
  {StdCtrls,} Buttons, XMLConf;//,
  //CbSFP_ideGENERAL_editor, CbSFP_ideGENERAL_config;

const

  cIn0k_LazExt_CbSFP__IDENTIFICATOR='in0k_LazExt_CbSFP';
  cIn0k_LazExt_CbSFP__GroupGeneral ='Config by SRC file path';
  cIn0k_LazExt_CbSFP__Node_General ='General';

  cIn0k_LazExt_CbSFP__defCnfFileExt='.xml';

{%region --- file, dir names--------------------------------------- /fold}

function  CbSFP_Config_RootPath:string;
function  CbSFP_Config_FileName:string;
function  CbSFP_ConfigsRootPath:string;

{%endregion}

{%region --- forceDir.. ------------------------------------------- /fold}

procedure CbSFP_forceDirectories(const dir:string); inline;
procedure CbSFP_forceDir_Config_RootPath;           inline;
procedure CbSFP_forceDir_ConfigsRootPath;           inline;

{%endregion}

{%region --- tCbSFP_configFile ------------------------------------ /fold}

type
  // хранитель настроек
 tCbSFP_configFile={$ifDef ideLazExtMODE} //< боевой режим
                    TConfigStorage
                   {$else}
                    TXMLConfig
                   {$endif};

function CbSFP_configFile_CREATE(const fileName:string):tCbSFP_configFile;
function CbSFP_configFile_DELETE(const fileName:string):boolean;

{%endregion}


// директория внутри которой будем хранить наши настройки
//function CbSFP_ConfigsRootPath:string;

//function CbSFP_ideGENERAL__register_SubScrbr(const AGroup,AIndex:Integer; const AParent:Integer=NoParent):PIDEOptionsEditorRec; overload;
//function CbSFP_ideGENERAL__register_SubScrbr:PIDEOptionsEditorRec;                                                              overload;

//procedure Register;

//function CbSFP_ideGENERAL__ConfigFileName:string;

implementation

{%ReGioN --- inLine functions ------------------------------------- /fold}


function _forceDirectories_(const dirPath:string):boolean;
begin
    result:=ForceDirectories(dirPath);
end;

function _fileDelete_(const fileName:string):boolean;
begin
    result:=DeleteFile(fileName);
end;

function _fileExists_(const fileName:string):boolean;
begin
    result:=FileExists(fileName);
end;

{%endRegion}

{%region --- file, dir names--------------------------------------- /fold}

{$ifDef uiDevelopPRJ}
const cUiDevelopPRJ_rootConfigDIR='CNFGs';
{$endif}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// корень-Директория хранения конфигов
function CbSFP_Config_RootPath:string;
begin
    {$ifDef ideLazExtMODE}
      result:=LazarusIDE.GetPrimaryConfigPath;
    {$else} //< режим ТЕСТИРОВАНИЯ
      {$ifDef uiDevelopPRJ}
      {todo: заменить на нормально место хранения, системное}
      result:=ExtractFileDir(ParamStr(0));
      result:=AppendPathDelim(result)+cUiDevelopPRJ_rootConfigDIR;
      {$else}
      {$error method is implemented}
      {$endif}
    {$endIf}
    result:=AppendPathDelim(result);
end;

// ПОЛНОЕ имя фала собственного конфигурационного файла
function CbSFP_Config_FileName:string;
begin
    result:=CbSFP_Config_RootPath;
    result:=result+cIn0k_LazExt_CbSFP__IDENTIFICATOR;
    result:=result+cIn0k_LazExt_CbSFP__defCnfFileExt;
end;

// корень-Директория для хранения конфигов "ПОДПИСЧИКОВ"
function CbSFP_ConfigsRootPath:string;
begin
    result:=CbSFP_Config_RootPath;
    result:=result+cIn0k_LazExt_CbSFP__IDENTIFICATOR;
    result:=AppendPathDelim(result);
end;

{%endregion}

{%region --- forceDir.. ------------------------------------------- /fold}

procedure CbSFP_forceDirectories(const dir:string);
begin
   _forceDirectories_(dir);
end;

procedure CbSFP_forceDir_Config_RootPath;
begin
    CbSFP_forceDirectories(CbSFP_Config_RootPath);
end;

procedure CbSFP_forceDir_ConfigsRootPath;
begin
    CbSFP_forceDirectories(CbSFP_ConfigsRootPath);
end;

{%endregion}

{%region --- tCbSFP_configFile ------------------------------------ /fold}

function CbSFP_configFile_CREATE(const fileName:string):tCbSFP_configFile;
begin
    {$ifDef ideLazExtMODE}
      // создаем и если он есть читаем
      result:=GetIDEConfigStorage(fileName,_fileExists_(fileName));
    {$else}
      {$ifDef uiDevelopPRJ}
      result:=TXMLConfig.Create(nil);
      result.Filename:=fileName;
      {$else}
      {$error method is implemented}
      {$endif}
    {$endif}
end;

function CbSFP_configFile_DELETE(const fileName:string):boolean;
begin
    if _fileExists_(fileName) then begin
       _fileDelete_(fileName);
    end;
end;

{%endregion}

//------------------------------------------------------------------------------

{
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
     }

{function CbSFP_ideGENERAL__register_SubScrbr(const AGroup,AIndex:Integer; const AParent:Integer=NoParent):PIDEOptionsEditorRec;
begin
    REGISTER_in_IdeOptions;
    result:=RegisterIDEOptionsEditor(AGroup,tCbSFP_ideCallEditor,AIndex,AParent,TRUE);
end;}

{function CbSFP_ideGENERAL__register_SubScrbr:PIDEOptionsEditorRec;
begin
    REGISTER_in_IdeOptions;
    result:=CbSFP_ideGENERAL__register_SubScrbr(_CBSP_IdeOptions_GRP_^.Index,GetFreeIDEOptionsIndex(_CBSP_IdeOptions_GRP_^.Index,0));
end;}


end.

