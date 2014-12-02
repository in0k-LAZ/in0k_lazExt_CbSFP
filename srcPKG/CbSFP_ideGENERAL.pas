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

uses IDEOptionsIntf, LazIDEIntf, LazFileUtils,
  StdCtrls, Buttons, CbSFP_ideEditor,
  CbSFP_ideGENERAL_editor, CbSFP_ideGENERAL_config;

const

  cIn0k_LazExt_CbSFP__IDENTIFICATOR='in0k_LazExt_CbSFP';
  cIn0k_LazExt_CbSFP__GroupGeneral ='Config by SRC file path';
  cIn0k_LazExt_CbSFP__Node_General ='General';

  cIn0k_LazExt_CbSFP__defCnfFileExt='.xml';


function CbSFP_ideGENERAL__Config_fileName:string;

// директория внутри которой будем хранить наши настройки
function CbSFP_ideGENERAL__ConfigsRootPath:string;

function CbSFP_ideGENERAL__register_SubScrbr(const AGroup,AIndex:Integer; const AParent:Integer=NoParent):PIDEOptionsEditorRec; overload;
function CbSFP_ideGENERAL__register_SubScrbr:PIDEOptionsEditorRec;                                                              overload;

procedure Register;

function CbSFP_ideGENERAL__ConfigFileName:string;

implementation


{%region --- tCbSFP_ideGeneral_Config  -----------------------------------}

function CbSFP_ideGENERAL__ConfigFileName:string;
begin
   result:=LazarusIDE.GetPrimaryConfigPath;
   result:=AppendPathDelim(result)+cIn0k_LazExt_CbSFP__IDENTIFICATOR;
end;

function CbSFP_ideGENERAL__Config_fileName:string;
begin
    result:=LazarusIDE.GetPrimaryConfigPath;
    result:=AppendPathDelim(result);
    result:=result+cIn0k_LazExt_CbSFP__IDENTIFICATOR+cIn0k_LazExt_CbSFP__defCnfFileExt;
    //result:=AppendPathDelim(CbSFP_ideGENERAL__ConfigFileName);
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


function CbSFP_ideGENERAL__register_SubScrbr(const AGroup,AIndex:Integer; const AParent:Integer=NoParent):PIDEOptionsEditorRec;
begin
    REGISTER_in_IdeOptions;
    result:=RegisterIDEOptionsEditor(AGroup,tCbSFP_ideCallEditor,AIndex,AParent,TRUE);
end;

function CbSFP_ideGENERAL__register_SubScrbr:PIDEOptionsEditorRec;
begin
    REGISTER_in_IdeOptions;
    result:=CbSFP_ideGENERAL__register_SubScrbr(_CBSP_IdeOptions_GRP_^.Index,GetFreeIDEOptionsIndex(_CBSP_IdeOptions_GRP_^.Index,0));
end;


end.

