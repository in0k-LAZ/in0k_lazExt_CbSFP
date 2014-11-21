unit CbSFP_SubScriber;

//----------------------\\-----------------------------------------------------=
//  ╔═╗┌┐ ╔═╗╔═╗╔═╗      \\  Configuration by Source File Path                 =
//  ║  ├┴┐╚═╗╠╣ ╠═╝      //  Конфигурация по пути исходного файла              =
//  ╚═╝└─┘╚═╝╚  ╩ v0.9  //   [..SubScriber..]                                  =
//---------------------//------------------------------------------------------=
// описание прав и обязанностей ПОДПИСЧИКА
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

uses Forms;

type

  // [CNFG]
  // абстрактный объект "КОНФИГУРАЦИЯ"
 tCbSFP_SubScriber_cnfOBJ = pointer;

  // абстрактный "подписчик" на конфигурации
 tCbSFP_SubScriber=pointer;

  // [HNDL]
  //
 tCbSFP_SubScriber_handle = class
  public
    // идентификатор подписчика (уникальное среди используемых)
    class function Identifier:string; virtual;
  public //< работа с объектом "КОНФИГУРАЦИЯ"
    // СОЗДАТЬ объект
    function  ConfigOBJ_CRT:tCbSFP_SubScriber_cnfOBJ;            virtual; abstract;
    // УНИЧТОЖить объект
    procedure ConfigOBJ_DST(const Obj:tCbSFP_SubScriber_cnfOBJ); virtual; abstract;
    // установить ПЕРВИЧНые (согласованные и безопасные) значения
    procedure ConfigOBJ_DEF(const Obj:tCbSFP_SubScriber_cnfOBJ); virtual; abstract;
  public //< работа с файлом
    // расширение файла
    function  ConfigOBJ_FileEXT:string; virtual; abstract;
    // Сохранить "Объект Конфигурация" в файле
    function  ConfigOBJ_Save(const Obj:tCbSFP_SubScriber_cnfOBJ; const FileName:string; const Used:boolean):boolean; virtual; abstract;
    // Загрузить "Объект Конфигурация" из файла
    function  ConfigOBJ_Load(const Obj:tCbSFP_SubScriber_cnfOBJ; const FileName:string; var   Used:boolean):boolean; virtual; abstract;
  end;
 tCbSFP_SubScriberTHandle = class of tCbSFP_SubScriber_handle;

  // [EDTR] -- редактор
  // "фрейм" для визуального редактирования свойств Объекта "Конфигурация"
 TCbSFP_SubScriber_editor=class(TFrame)
  public
    function GetTitle:string; virtual;
  public
    // загрузить данные из объекта во фрейм
    procedure Settings_LOAD(const {%H-}Obj:pointer); virtual; abstract;
    // сохранить данные из фрейма в объекте
    procedure Settings_SAVE(const {%H-}Obj:pointer); virtual; abstract;
  end;
 tCbSFP_SubScriberTEditor = class of TCbSFP_SubScriber_editor;

implementation

class function tCbSFP_SubScriber_handle.Identifier:string;
begin
    result:=self.ClassName;
end;

//------------------------------------------------------------------------------

// строка отображаемая в "дереве" Опции
function TCbSFP_SubScriber_editor.GetTitle:String;
begin
    result:=self.ClassName;
end;

end.

