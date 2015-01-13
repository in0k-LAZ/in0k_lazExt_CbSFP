unit CbSFP__Intf;

//----------------------\\-----------------------------------------------------=
//  ╔═╗┌┐ ╔═╗╔═╗╔═╗      \\  Configuration by Source File Path                 =
//  ║  ├┴┐╚═╗╠╣ ╠═╝      //  Конфигурация по пути исходного файла              =
//  ╚═╝└─┘╚═╝╚  ╩ v0.9  //   [INTF]                                            =
//---------------------//------------------------------------------------------=
// как аналог в системе IDE Lazarus Intf
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

{$define ideLazExtMODE}  //<----------------------- боевой режм "Расширения IDE"
{$ifDef uiDevelopPRJ}
    {$undef ideLazExtMODE}
{$endif}


uses
    {$ifDef ideLazExtMODE}
    IDEOptionsIntf, SrcEditorIntf,
    CbSFP_ideREGISTER,
    {$else}
        {$ifDef uiDevelopPRJ}
        {$endif}
    {$endif}
    CbSFP_ideCenter, CbSFP_SubScriber;


function  CbSFP_SubScriber__REGISTER(const Handle:tCbSFP_SubScriberTHandle; const Editor:tCbSFP_SubScriberTEditor):tCbSFP_SubScriber;
procedure CbSFP_SubScriber__DebugMSG(const SubScriber:tCbSFP_SubScriber;    const mType,mText:string);

{$ifDef ideLazExtMODE} //< боевой режм "Расширения IDE"
//function CbSFP_SubScriber__REGISTER(const Handle:tCbSFP_SubScriberTHandle; const Editor:tCbSFP_SubScriberTEditor; const AGroup,AIndex:Integer; const AParent:Integer=NoParent):tCbSFP_SubScriber;

function CbSFP_SubScriber__ideLazarus_ActiveEditor_sourceFileName:string;
function CbSFP_SubScriber__cnfg_OBJ(const SubScriber:tCbSFP_SubScriber; const srcFileName:string):pointer;
function CbSFP_SubScriber__cnfg_OBJ(const SubScriber:tCbSFP_SubScriber):pointer;
{$endIf}

implementation

// зарегистрировать Подписчика в системе
function CbSFP_SubScriber__REGISTER(const Handle:tCbSFP_SubScriberTHandle; const Editor:tCbSFP_SubScriberTEditor):tCbSFP_SubScriber;
begin
    {$ifDef ideLazExtMODE}
    result:=CbSFP_ideCenter__SubScriber_REGISTER(Handle,Editor,CbSFP_ideREGISTER_register_SubScrbr);
    {$else}
    result:=CbSFP_ideCenter__SubScriber_REGISTER(Handle,Editor);
    {$endif}
end;

{$ifDef ideLazExtMODE} //< боевой режм "Расширения IDE"
{function CbSFP_SubScriber__REGISTER(const Handle:tCbSFP_SubScriberTHandle; const Editor:tCbSFP_SubScriberTEditor; const AGroup,AIndex:Integer; const AParent:Integer=NoParent):tCbSFP_SubScriber;
begin
    result:=CbSFP_ideCenter.CbSFP_ideCenter__SubScriberREGISTER(Handle,Editor, AGroup,AIndex,AParent);
end;}

{$endIf}

//------------------------------------------------------------------------------

// отправить DEBUG-сообщение в DEBUG-окно Подписчика
procedure CbSFP_SubScriber__DebugMSG(const SubScriber:tCbSFP_SubScriber; const mType,mText:string);
begin
    CbSFP_ideCenter_DEBUG_node(SubScriber, mType,mText);
end;

//------------------------------------------------------------------------------

{$ifDef ideLazExtMODE} //< боевой режм "Расширения IDE"

// имя файла в "АКТИВНОЙ вкладке редактора исходного кода"
function CbSFP_SubScriber__ideLazarus_ActiveEditor_sourceFileName:string;
var tmp:TSourceEditorInterface;
begin
    result:='';
    tmp:=SourceEditorManagerIntf.ActiveEditor;
    if Assigned(tmp) then begin
        result:=tmp.FileName;
    end;
end;

{$endif}

//------------------------------------------------------------------------------

{$ifDef ideLazExtMODE} //< боевой режм "Расширения IDE"

// получить настройки по ПутиФайла
function CbSFP_SubScriber__cnfg_OBJ(const SubScriber:tCbSFP_SubScriber; const srcFileName:string):pointer;
begin
    result:=CbSFP_ideCenter.CbSFP_ideCenter__SubScriber_CnfgOBJ(SubScriber,srcFileName);
    {$ifOpt D+}
    CbSFP_ideCenter.CbSFP_ideCenter_DEBUG_main(SubScriber,'getCNFIG',CbSFP_pointer2text(result)+'<->'+srcFileName);
    {$endIf}
end;

// получить настройки для файла в "АКТИВНОЙ вкладке редактора исходного кода"
function CbSFP_SubScriber__cnfg_OBJ(const SubScriber:tCbSFP_SubScriber):pointer;
begin
    result:=CbSFP_SubScriber__cnfg_OBJ(SubScriber,CbSFP_SubScriber__ideLazarus_ActiveEditor_sourceFileName);
end;

{$endif}

end.

