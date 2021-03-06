unit CbSFP_DemoSubScriber_HNDL;

//----------------------\\-----------------------------------------------------=
//  ╔═╗┌┐ ╔═╗╔═╗╔═╗      \\  Configuration by Source File Path                 =
//  ║  ├┴┐╚═╗╠╣ ╠═╝      //  Конфигурация по пути исходного файла              =
//  ╚═╝└─┘╚═╝╚  ╩ v0.9  //   [custom HNDL]                                     =
//---------------------//------------------------------------------------------=
// пример реализации "пользовательского обработчика конфигурации"
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

uses IniFiles,
     CbSFP_SubScriber,
     CbSFP_DemoSubScriber_core,
     CbSFP_DemoSubScriber_CNFG;

type

 tCbSFP_DemoSubScriber_HNDL=class(tCbSFP_SubScriber_handle)
  public
    class function  Identifier:string; override;
  public
    function  ConfigOBJ_CRT:tCbSFP_SubScriber_cnfOBJ;            override;
    procedure ConfigOBJ_DST(const Obj:tCbSFP_SubScriber_cnfOBJ); override;
    procedure ConfigOBJ_DEF(const Obj:tCbSFP_SubScriber_cnfOBJ); override;
  public
    function  ConfigOBJ_FileEXT:string; override;
    function  ConfigOBJ_Save(const Obj:tCbSFP_SubScriber_cnfOBJ; const FileName:string):boolean; override;
    function  ConfigOBJ_Load(const Obj:tCbSFP_SubScriber_cnfOBJ; const FileName:string):boolean; override;
  end;

implementation

class function tCbSFP_DemoSubScriber_HNDL.Identifier:string;
begin
    result:=cCbSFP_DemoSubScriber__Identifier;
end;

//------------------------------------------------------------------------------

function tCbSFP_DemoSubScriber_HNDL.ConfigOBJ_CRT:pointer;
begin
    result:=CbSFP_DemoSubScriber_CNFG__CRT;
end;

procedure tCbSFP_DemoSubScriber_HNDL.ConfigOBJ_DST(const Obj:pointer);
begin
    CbSFP_DemoSubScriber_CNFG__DST(Obj);
end;

procedure tCbSFP_DemoSubScriber_HNDL.ConfigOBJ_DEF(const Obj:pointer);
begin
    CbSFP_DemoSubScriber_CNFG__DEF(Obj);
end;

//------------------------------------------------------------------------------

const
   _cCbSFPdSS__FileEXT    ='.ini';
   _cCbSFPdSS__section_Name='DSS';
   _cCbSFPdSS__nodeName_INT='INT';
   _cCbSFPdSS__nodeName_TXT='TXT';

function tCbSFP_DemoSubScriber_HNDL.ConfigOBJ_FileEXT:string;
begin
    result:=_cCbSFPdSS__FileEXT;
end;

function tCbSFP_DemoSubScriber_HNDL.ConfigOBJ_Save(const Obj:pointer; const FileName:string):boolean;
var tmp:pCbSFP_DemoSubScriber_CNFG;
    ini:TIniFile;
begin
    tmp:=Obj;
    result:=false;
    try
        ini:=TIniFile.Create(FileName);
        //---
        ini.WriteInteger(_cCbSFPdSS__section_Name,_cCbSFPdSS__nodeName_INT,tmp^.INT);
        ini.WriteString (_cCbSFPdSS__section_Name,_cCbSFPdSS__nodeName_TXT,tmp^.TXT);
        //---
        ini.FREE;
        result:=TRUE;
    except
        result:=false;
    end;
end;

function tCbSFP_DemoSubScriber_HNDL.ConfigOBJ_Load(const Obj:pointer; const FileName:string):boolean;
var tmp:pCbSFP_DemoSubScriber_CNFG;
    ini:TIniFile;
begin
    tmp:=Obj;
    result:=false;
    try
        ini:=TIniFile.Create(FileName);
        tmp^.INT:=ini.ReadInteger(_cCbSFPdSS__section_Name,_cCbSFPdSS__nodeName_INT,tmp^.INT);
        tmp^.TXT:=ini.ReadString (_cCbSFPdSS__section_Name,_cCbSFPdSS__nodeName_TXT,tmp^.TXT);
        //---
        ini.FREE;
        result:=TRUE;
    except
        result:=false;
    end;
end;

end.

