unit CbSFP_ideConfigStorage;
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

uses BaseIDEIntf, LazConfigStorage, SysUtils;

type tCbSFP_ConfigStorage=TConfigStorage;

function CbSFP_ideConfigStorage_GET(const FileName:string):tCbSFP_ConfigStorage;

implementation

function CbSFP_ideConfigStorage_GET(const FileName:string):tCbSFP_ConfigStorage;
begin
 {   result:=GetIDEConfigStorage(
        FileName,
        FileExists(CbSFP_ideGENERAL__Config_fileName) //< если он есть то ЧИТАЕМ
            );  }
end;

end.

