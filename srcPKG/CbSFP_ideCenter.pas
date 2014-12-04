unit CbSFP_ideCenter;

//----------------------\\-----------------------------------------------------=
//  ╔═╗┌┐ ╔═╗╔═╗╔═╗      \\  Configuration by Source File Path                 =
//  ║  ├┴┐╚═╗╠╣ ╠═╝      //  Конфигурация по пути исходного файла              =
//  ╚═╝└─┘╚═╝╚  ╩ v0.9  //   [tCbSFP_ideCallCenter]                            =
//---------------------//------------------------------------------------------=
// реализует основную функциональность
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

uses sysutils, LazFileUtils, IDEOptionsIntf,
    {$ifDef ideLazExtMODE}
    BaseIDEIntf,
    LazConfigStorage,
    {$endif}
    {$ifDef uiDevelopPRJ}
    XMLConf,
    {$endif}
    CbSFP_SubScriber;

type

 pCbSFP_base=^rCbSFP_base;
 rCbSFP_base=record
    next:pCbSFP_base;
    CNFG:pointer; //< конфигурация
    TEXT:string;  //< строка идентификатор
    USED:boolean; //< флаг Используется
  end;
 pCbSFP_OPTN=pCbSFP_base;
 pCbSFP_PTTN=pCbSFP_base;

 pCbSFP_Node=^rCbSFP_Node;
 rCbSFP_Node=record
    next      :pCbSFP_Node;
    SubSiCLASS:tCbSFP_SubScriber_Handle;
    SubStFRAME:tCbSFP_SubScriberTEditor;
    IDEOptERec:PIDEOptionsEditorRec;
    list_OPTNs:pCbSFP_OPTN;
    list_PTTNs:pCbSFP_PTTN;
  end;

 tCbSFP_ideFileStorage={$ifDef ideLazExtMODE} //< боевой режим
                        TConfigStorage
                       {$else}
                        TXMLConfig
                       {$endif};



 tCbSFP_ideCallCenter=class
  {%region --- работа с УЗЛАМИ pCbSFP_Node ------------------------ /fold}
  private
    procedure _node_CRT(out   node:pCbSFP_Node; const HNDL:tCbSFP_SubScriberTHandle; const EDTR:tCbSFP_SubScriberTEditor);
    procedure _node_INI(const node:pCbSFP_Node);
    procedure _node_DST(const node:pCbSFP_Node);
  protected
    function  _node_identifier(const node:pCbSFP_Node):string; inline;
    function  _node_cnfFileEXT(const node:pCbSFP_Node):string; inline;
  private
    function  _node_LOAD_CNFG (const node:pCbSFP_Node; const OPTN:pCbSFP_OPTN):boolean;
    function  _node_SAVE_CNFG (const node:pCbSFP_Node; const OPTN:pCbSFP_OPTN):boolean;
  {%endregion}
  {%region --- работа с ОЧЕРЕДЬЮ pCbSFP_Node ---------------------- /fold}
  private
   _lair:pCbSFP_Node;
    procedure _lair_CRT;
    procedure _lair_ADD(const node:pCbSFP_Node);
    procedure _lair_DST;
    function  _lair_FND_byIDEOptERec(const value:PIDEOptionsEditorRec):pCbSFP_Node;
    function  _lair_FND_byIdentifier(const value:string):pCbSFP_Node;
  {%endregion}
  {%region --- работа с ПУТЯМИ файловой системы ------------------- /fold}
  protected
    function _callCenter_rootPath:string;
    function _subScriber_node_fileName(const node:pCbSFP_Node):string;
    function _subScriber_OPTN_rootPath(const node:pCbSFP_Node):string;
    function _subScriber_OPTN_fileName(const node:pCbSFP_Node; const itm:pCbSFP_OPTN):string;
    function _fileName_to_OPTN_Name   (const fileName:string):string;
  {%endregion}
  {%region --- работа с файловой системы -------------------------- /fold}
  protected
    procedure _forceDirectories_(const Path:string);                    inline;
    procedure _forceDirectories_callCenter;                             inline;
    procedure _forceDirectories_subScriber(const node:pCbSFP_Node); inline;
    procedure _deleteFileFromFS_subScriber(const node:pCbSFP_Node; const itm:pCbSFP_OPTN); inline;
  {%endregion}
  {%region --- Сохранение и Загрузка ------------------------------ /fold}
  private
    function  _node_configStorageCRT(const file_Name:string):tCbSFP_ideFileStorage; overload;
    function  _node_configStorageCRT(const node:pCbSFP_Node):tCbSFP_ideFileStorage; overload;
  private
    procedure _node_load_ListItmSEEK(const node:pCbSFP_Node; const fileSTRG:tCbSFP_ideFileStorage);
    procedure _node_load_ListItmOPTN(const node:pCbSFP_Node);
    procedure _node_load_ListOptnUSE(const node:pCbSFP_Node; const fileSTRG:tCbSFP_ideFileStorage);
    procedure _node_LOAD            (const node:pCbSFP_Node);
  private
    procedure _node_save_ListItmSEEK(const node:pCbSFP_Node; const fileSTRG:tCbSFP_ideFileStorage);
    procedure _node_save_ListItmOPTN(const node:pCbSFP_Node);
    procedure _node_save_ListOptnUSE(const node:pCbSFP_Node; const fileSTRG:tCbSFP_ideFileStorage);
    procedure _node_SAVE            (const node:pCbSFP_Node);
  {%endregion}
  {%region --- работа с УЗЛАМИ pCbSFP_BASE ------------------------ /fold}
  private //< рождение и смерть
    procedure _itmBase_CLR(const itm:pCbSFP_base); inline;
    procedure _itmBase_CRT(out   itm:pCbSFP_base); inline;
    procedure _itmBase_DST(const itm:pCbSFP_base); inline;
  private //< операции с УЗЛОМ
    function  _itmBase_getNext (const itm:pCbSFP_base):pCbSFP_base;              inline;
    procedure _itmBase_setNext (const itm:pCbSFP_base; const value:pCbSFP_base); inline;
    function  _itmBase_getCNFG (const itm:pCbSFP_base):pointer;                          inline;
    procedure _itmBase_setCNFG (const itm:pCbSFP_base; const value:pointer);             inline;
    function  _itmBase_getTEXT (const itm:pCbSFP_base):string;                           inline;
    procedure _itmBase_setTEXT (const itm:pCbSFP_base; const value:string);              inline;
    function  _itmBase_getUSED (const itm:pCbSFP_base):boolean;                          inline;
    procedure _itmBase_setUSED (const itm:pCbSFP_base; const value:boolean);             inline;
  private //< операции на СПИСКЕ
    procedure _lstBase_insLast (var first:pCbSFP_base; const itm:pCbSFP_base);
    procedure _lstBase_cutItem (var first:pCbSFP_base; const itm:pCbSFP_base);
    function  _lstBase_vldText (const itm:pCbSFP_base; const TXT:string; const withOut:pCbSFP_base=nil):boolean;
    function  _lstBase_newText (const itm:pCbSFP_base; const TXT:string):string;
  {%endregion}
  {%region --- работа с УЗЛАМИ pCbSFP_OPTN ------------------------ /fold}
  private
    procedure _lstOPTN_CLEAR   (const node:pCbSFP_Node; var FIRST:pCbSFP_OPTN);
    function  _lstOPTN_getFirst(const node:pCbSFP_Node):pCbSFP_OPTN;
    procedure _lstOPTN_setFirst(const node:pCbSFP_Node; const item:pCbSFP_OPTN);
    procedure _lstOPTN_insLast (const node:pCbSFP_Node; const item:pCbSFP_OPTN);
    procedure _lstOPTN_cutItem (const node:pCbSFP_Node; const item:pCbSFP_OPTN);
    function  _lstOPTN_fndNAME (const node:pCbSFP_Node; const name:string):pCbSFP_OPTN;
    function  _lstOPTN_vldNAME (const node:pCbSFP_Node; const name:string; const withOut:pCbSFP_OPTN=nil):boolean;
  private
    function  _lstOPTN_defOPTNs(const node:pCbSFP_Node):pCbSFP_OPTN;
  private
    function  _itmOPTN_crt8ini (const node:pCbSFP_Node):pCbSFP_OPTN;
    procedure _itmOPTN_destroy (const node:pCbSFP_Node; const item:pCbSFP_OPTN);
  private
    procedure _itmOPTN_setNext (const item:pCbSFP_OPTN; const value:pCbSFP_OPTN);
    procedure _itmOPTN_setCNFG (const item:pCbSFP_OPTN; const value:pointer);
    procedure _itmOPTN_setName (const item:pCbSFP_OPTN; const value:string);
    procedure _itmOPTN_setUsed (const item:pCbSFP_OPTN; const value:boolean);
  private
    function  _itmOPTN_getNext (const item:pCbSFP_OPTN):pCbSFP_OPTN;
    function  _itmOPTN_getCNFG (const item:pCbSFP_OPTN):pointer;
    function  _itmOPTN_getName (const item:pCbSFP_OPTN):string;
    function  _itmOPTN_getUsed (const item:pCbSFP_OPTN):boolean;
  {%endregion}
  {%region --- работа с УЗЛАМИ pCbSFP_PTTN ------------------------ /fold}
  private
    procedure _lstPTTN_CLEAR   (var FIRST:pCbSFP_PTTN);
    function  _lstPTTN_getFirst(const node:pCbSFP_Node):pCbSFP_PTTN;
    procedure _lstPTTN_setFirst(const node:pCbSFP_Node; const item:pCbSFP_PTTN);
    procedure _lstPTTN_insLast (const node:pCbSFP_Node; const item:pCbSFP_PTTN);
    procedure _lstPTTN_cutItem (const node:pCbSFP_Node; const item:pCbSFP_PTTN);
    function  _lstPTTN_vldSEEK (const node:pCbSFP_Node; const SEEK:string; const withOut:pCbSFP_PTTN=nil):boolean;
  private
    function  _itmPTTN_crt8ini (const node:pCbSFP_Node; const seek:string=''):pCbSFP_PTTN;
    procedure _itmPTTN_destroy (const item:pCbSFP_PTTN);
  private
    procedure _itmPTTN_setNext (const item:pCbSFP_PTTN; const value:pCbSFP_PTTN);
    procedure _itmPTTN_setOPTN (const item:pCbSFP_PTTN; const value:pCbSFP_OPTN);
    procedure _itmPTTN_setSeek (const item:pCbSFP_PTTN; const value:string);
    procedure _itmPTTN_setUsed (const item:pCbSFP_PTTN; const value:boolean);
  private
    function  _itmPTTN_getNext (const item:pCbSFP_PTTN):pCbSFP_PTTN;
    function  _itmPTTN_getOPTN (const item:pCbSFP_PTTN):pCbSFP_OPTN;
    function  _itmPTTN_getSeek (const item:pCbSFP_PTTN):string;
    function  _itmPTTN_getUsed (const item:pCbSFP_PTTN):boolean;
  private
    function  _itmPTTN_getNAME (const item:pCbSFP_PTTN):string;
    function  _itmPTTN_getCNFG (const item:pCbSFP_PTTN):pointer;
  {%endregion}
  {%region --- SubScriber поиск ----------------------------------- /fold}
  protected
    function  _SubScrbr_REGISTER(const HNDL:tCbSFP_SubScriberTHandle; const EDTR:tCbSFP_SubScriberTEditor):pCbSFP_Node;
  public
    function   SubScriber_byIdeREC(const value:PIDEOptionsEditorRec):tCbSFP_SubScriber;
    function   SubScriber_byEDITOR(const value:TAbstractIDEOptionsEditor):tCbSFP_SubScriber;
  {%endregion}
  public
    constructor Create;
    destructor DESTROY; override;
  end;

 {$ifDef ideLazExtMODE} //<------------------------ боевой режм "Расширения IDE"

 tCbSFP_ideCallCenterIDE=class(tCbSFP_ideCallCenter)
  public
    function SubScriber_REGISTER(HNDL:tCbSFP_SubScriberTHandle; EDTR:tCbSFP_SubScriberTEditor; const AGroup,AIndex:Integer; const AParent:Integer=NoParent):tCbSFP_SubScriber; overload;
    function SubScriber_REGISTER(HNDL:tCbSFP_SubScriberTHandle; EDTR:tCbSFP_SubScriberTEditor):tCbSFP_SubScriber; overload;
  end;

 {$else} //<------------------------------------------------- режим ТЕСТИРОВАНИЯ

  {$ifDef uiDevelopPRJ}
 tCbSFP_ideCallCenterTST=class(tCbSFP_ideCallCenter)
  public
    function SubScriber_REGISTER(HNDL:tCbSFP_SubScriberTHandle; EDTR:tCbSFP_SubScriberTEditor):tCbSFP_SubScriber;
  end;
  {$endIf}

 {$endIf}

 tCbSFP_ideEditorNODE=class
  {%region --- внутренняя кухня для работы ------------------------ /fold}
  private
   _CallCenter_:tCbSFP_ideCallCenter;
   _SubScriber_:pCbSFP_Node;
  private
   _old_lOPTNs_:pCbSFP_OPTN; //< список как ДО начала при редактирования
   _old_lPTTNs_:pCbSFP_PTTN; //< список как ДО начала при редактирования
   _del_lOPTNs_:pCbSFP_OPTN; //< список УДАЛЕННЫХ при редактировании
   _del_lPTTNs_:pCbSFP_PTTN; //< список УДАЛЕННЫХ при редактировании
    function _IsEDITED:boolean; inline;
  private //< "копирование" данных
    function _lstOPTN_addCOPY(const Item:pCbSFP_OPTN):pCbSFP_OPTN;
    function _lstPTTN_addCOPY(const Item:pCbSFP_PTTN):pCbSFP_PTTN;
  {%endregion}
  public
    constructor Create(const CallCenter:tCbSFP_ideCallCenter; const Node:pCbSFP_Node);
    destructor DESTROY; override;
  public
    function  Identifier:string;
    function  EDITtFRAME:tCbSFP_SubScriberTEditor;
    procedure EDIT_Start;
    procedure EDIT_doEnd(const WithSAVE:boolean);
  {%region --- работа с УЗЛАМИ pCbSFP_OPTN -------------------- /fold}
  public //< работа со списком
    function  lstOPTN_getFirst:pCbSFP_OPTN;
    procedure lstOPTN_setFirst(const item:pCbSFP_OPTN);
    function  lstOPTN_getNEXT (const item:pCbSFP_OPTN):pCbSFP_OPTN;
    procedure lstOPTN_setNEXT (const item:pCbSFP_OPTN; const value:pCbSFP_OPTN);
    function  lstOPTN_vldName (const Name:string; const withOut:pCbSFP_OPTN=nil):boolean;
    procedure lstOPTN_delItem (const item:pCbSFP_PTTN);
  public //< добавка элементов в структуру
    function  lstOPTN_addItem :pCbSFP_OPTN;
  public
    function  lstOPTN_defOPTNs:pCbSFP_OPTN;
    function  lstOPTN_defCNFGs:pointer;
  public //< только это и можно установить
    procedure itmOPTN_setName (const item:pCbSFP_OPTN; const value:string);
    procedure itmOPTN_setUsed (const item:pCbSFP_OPTN; const value:boolean);
  public //< это можно почитать
    function  itmOPTN_getCNFG (const item:pCbSFP_OPTN):pointer;
    function  itmOPTN_getName (const item:pCbSFP_OPTN):string;
    function  itmOPTN_getUsed (const item:pCbSFP_OPTN):boolean;
  {%endregion}
  {%region --- работа с УЗЛАМИ pCbSFP_PTTN -------------------- /fold}
  public //< работа со списком
    function  lstPTTN_getFirst:pCbSFP_PTTN;
    procedure lstPTTN_setFirst(const item:pCbSFP_PTTN);
    function  lstPTTN_getNEXT (const item:pCbSFP_PTTN):pCbSFP_PTTN;
    procedure lstPTTN_setNEXT (const item:pCbSFP_PTTN; const value:pCbSFP_PTTN);
    function  lstPTTN_vldSeek (const Seek:string; const withOut:pCbSFP_OPTN=nil):boolean;
    function  lstPTTN_cntOPTN (const item:pCbSFP_OPTN):integer;
    procedure lstPTTN_delItem (const item:pCbSFP_PTTN);
  public //< добавка элементов в структуру
    function  lstPTTN_addFromOPTN(const OPTN:pCbSFP_OPTN):pCbSFP_PTTN;
    function  lstPTTN_addFromPTTN(const PTTN:pCbSFP_PTTN):pCbSFP_PTTN;
  public //< только это и можно установить
    procedure itmPTTN_setOPTN (const item:pCbSFP_PTTN; const value:pCbSFP_OPTN);
    procedure itmPTTN_setSeek (const item:pCbSFP_PTTN; const value:string);
    procedure itmPTTN_setUsed (const item:pCbSFP_PTTN; const value:boolean);
  public //< это можно почитать
    function  itmPTTN_getOPTN (const item:pCbSFP_PTTN):pCbSFP_OPTN;
    function  itmPTTN_getCNFG (const item:pCbSFP_PTTN):pointer;
    function  itmPTTN_getName (const item:pCbSFP_PTTN):string;
    function  itmPTTN_getSeek (const item:pCbSFP_PTTN):string;
    function  itmPTTN_getUsed (const item:pCbSFP_PTTN):boolean;
  {%endregion}
  end;

function CbSFP_ideCenter__SubScriberREGISTER(const HNDL:tCbSFP_SubScriberTHandle; const EDTR:tCbSFP_SubScriberTEditor):tCbSFP_SubScriber;
{$ifDef ideLazExtMODE} //< боевой режм "Расширения IDE"
function CbSFP_ideCenter__SubScriberREGISTER(const HNDL:tCbSFP_SubScriberTHandle; const EDTR:tCbSFP_SubScriberTEditor; const AGroup,AIndex:Integer; const AParent:Integer=NoParent):tCbSFP_SubScriber;
{$endIf}
function CbSFP_ideCenter__EditorNODE(const value:TAbstractIDEOptionsEditor):tCbSFP_ideEditorNODE;

implementation

{$ifDef ideLazExtMODE}
uses CbSFP_ideGENERAL;
{$endIf}

const
    cItmOPTN_DEFAULT_name='DEFAULT';
    cItmOPTN_DEFCUST_name='custom';
    cItmSeek_DEFCUST_name='fileName';

//------------------------------------------------------------------------------

constructor tCbSFP_ideCallCenter.Create;
begin
   _lair_CRT;
end;

destructor tCbSFP_ideCallCenter.DESTROY;
begin
   _lair_DST;
end;

//------------------------------------------------------------------------------

{%region --- работа с ОЧЕРЕДЬЮ pCbSFP_Node ------------------------ /fold}

procedure tCbSFP_ideCallCenter._lair_CRT;
begin
   _lair:=nil;
end;

procedure tCbSFP_ideCallCenter._lair_ADD(const node:pCbSFP_Node);
begin
    node^.next:=_lair;
   _lair:=node;
end;

procedure tCbSFP_ideCallCenter._lair_DST;
var p:pCbSFP_Node;
begin
    p:=_lair;
    while Assigned(p) do begin
       _lair:=p^.next;
       _node_DST(p);
        p:=_lair;
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tCbSFP_ideCallCenter._lair_FND_byIdentifier(const value:string):pCbSFP_Node;
begin
    result:=_lair;
    while Assigned(result) do begin
        if _node_identifier(result)=value then break;
        result:=result^.next;
    end;
end;

function tCbSFP_ideCallCenter._lair_FND_byIDEOptERec(const value:PIDEOptionsEditorRec):pCbSFP_Node;
begin
    result:=_lair;
    while Assigned(result) do begin
        if result^.IDEOptERec=value then break;
        result:=result^.next;
    end;
end;

{%endregion}

{%region --- работа с УЗЛАМИ pCbSFP_Node -------------------------- /fold}

procedure tCbSFP_ideCallCenter._node_CRT(out node:pCbSFP_Node; const HNDL:tCbSFP_SubScriberTHandle; const EDTR:tCbSFP_SubScriberTEditor);
begin
    new(node);
    with node^ do begin
        next      :=nil;
        IDEOptERec:=nil;
        SubStFRAME:=EDTR;
        SubSiCLASS:=HNDL.Create;
        list_OPTNs:=nil;
        list_PTTNs:=nil;
    end;
end;

procedure tCbSFP_ideCallCenter._node_INI(const node:pCbSFP_Node);
begin
    // чистим ВСЕ списки
   _lstPTTN_CLEAR  (node^.list_PTTNs);
   _lstOPTN_CLEAR  (node,node^.list_OPTNs);
    // создаем главный "По Умолчанию" и задаем его "стандартное" имя
   _lstOPTN_insLast(node,_itmOPTN_crt8ini(node)); //< он станет ПЕРВЫМ
   _itmOPTN_setName(_lstOPTN_defOPTNs(node),cItmOPTN_DEFAULT_name);
end;

procedure tCbSFP_ideCallCenter._node_DST(const node:pCbSFP_Node);
begin
   _lstPTTN_CLEAR(node^.list_PTTNs);
   _lstOPTN_CLEAR(node,node^.list_OPTNs);
    node^.SubSiCLASS.FREE;
    dispose(node);
end;

//------------------------------------------------------------------------------

function tCbSFP_ideCallCenter._node_identifier(const node:pCbSFP_Node):string;
begin
    result:=node^.SubSiCLASS.Identifier;
end;

function tCbSFP_ideCallCenter._node_cnfFileEXT(const node:pCbSFP_Node):string;
begin
    result:=node^.SubSiCLASS.ConfigOBJ_FileEXT;
end;

//------------------------------------------------------------------------------

function tCbSFP_ideCallCenter._node_LOAD_CNFG(const node:pCbSFP_Node; const OPTN:pCbSFP_OPTN):boolean;
begin
    result:=FALSE;
    try result:=node^.SubSiCLASS.ConfigOBJ_Load(OPTN^.CNFG,_subScriber_OPTN_fileName(node,OPTN));
    except
        result:=FALSE;
    end;
    if NOT result then node^.SubSiCLASS.ConfigOBJ_DEF(OPTN^.CNFG);
end;

function tCbSFP_ideCallCenter._node_SAVE_CNFG(const node:pCbSFP_Node; const OPTN:pCbSFP_OPTN):boolean;
begin
    result:=FALSE;
    try result:=node^.SubSiCLASS.ConfigOBJ_Save(OPTN^.CNFG,_subScriber_OPTN_fileName(node,OPTN));
    except
        result:=FALSE;
    end;
end;

{%endregion}

{%region --- работа с ПУТЯМИ файловой системы --------------------- /fold}

const
   cCbSFP_fileStorageEXT='.xml';


function tCbSFP_ideCallCenter._callCenter_rootPath:string;
begin
  {$ifDef ideLazExtMODE}
    result:=CbSFP_ideGENERAL__ConfigsRootPath;
  {$else} //< режим ТЕСТИРОВАНИЯ
    {$ifDef uiDevelopPRJ}
    result:=ExtractFileDir(ParamStr(0))+'\TMP\';
    {$else}
    {$error method is implemented}
    {$endif}
  {$endIf}
end;

// имя файла КОНФИГУРАЦИИ конкретного узла
function tCbSFP_ideCallCenter._subScriber_node_fileName(const node:pCbSFP_Node):string;
begin
    result:=_callCenter_rootPath+_node_identifier(node)+cCbSFP_fileStorageEXT;
end;

function tCbSFP_ideCallCenter._subScriber_OPTN_rootPath(const node:pCbSFP_Node):string;
begin
    result:=AppendPathDelim(_callCenter_rootPath+_node_identifier(node));
end;

function tCbSFP_ideCallCenter._subScriber_OPTN_fileName(const node:pCbSFP_Node; const itm:pCbSFP_OPTN):string;
begin
    result:=_subScriber_OPTN_rootPath(node)+_itmOPTN_getName(itm)+_node_cnfFileEXT(node);
end;

function tCbSFP_ideCallCenter._fileName_to_OPTN_Name(const fileName:string):string;
begin
    result:=ChangeFileExt(ExtractFileName(fileName),'');
end;

{%endregion}

{%region --- работа с файловой системы ---------------------------- /fold}

procedure tCbSFP_ideCallCenter._forceDirectories_(const Path:string);
begin
    ForceDirectories(Path);
end;

procedure tCbSFP_ideCallCenter._forceDirectories_callCenter;
begin
   _forceDirectories_(_callCenter_rootPath);
end;

procedure tCbSFP_ideCallCenter._forceDirectories_subScriber(const node:pCbSFP_Node);
begin
   _forceDirectories_(_subScriber_OPTN_rootPath(node));
end;

procedure tCbSFP_ideCallCenter._deleteFileFromFS_subScriber(const node:pCbSFP_Node; const itm:pCbSFP_OPTN);
var S:string;
begin
    s:=_subScriber_OPTN_fileName(node,itm);
    if FileExists(s) then begin
       DeleteFile(s);
    end;
end;

{%endregion}

{%region --- Сохранение и Загрузка -------------------------------- /fold}



function tCbSFP_ideCallCenter._node_configStorageCRT(const file_Name:string):tCbSFP_ideFileStorage;
begin
  {$ifDef ideLazExtMODE}
    // создаем и если он есть читаем
    result:=GetIDEConfigStorage(file_Name,FileExists(file_Name));
  {$else}
    {$ifDef uiDevelopPRJ}
    result:=TXMLConfig.Create(nil);
    result.Filename:=file_Name;
    {$else}
    {$error method is implemented}
    {$endif}
  {$endif}
end;

function tCbSFP_ideCallCenter._node_configStorageCRT(const node:pCbSFP_Node):tCbSFP_ideFileStorage;
begin
    result:=_node_configStorageCRT(_subScriber_node_fileName(node));
end;

//------------------------------------------------------------------------------

const
      cPathDelim='/';
      cAsterisk ='*';

const
      cTXT_PattensList='PattensList';
      cTXT_OptionsUsed='OptionsUsed';
      //---
      cTXT_Count='Count';
      cTXT_Item ='Item';
      //---
      cTXT_used ='used';
      cTXT_name ='name';
      cTXT_seek ='seek';

//------------------------------------------------------------------------------

procedure tCbSFP_ideCallCenter._node_save_ListItmSEEK(const node:pCbSFP_Node; const fileSTRG:tCbSFP_ideFileStorage);
var cfgPATH:string;
    tmpPTTN:pCbSFP_PTTN;
    cnt_idx:integer;
begin
    cfgPATH:=cTXT_PattensList;
    fileSTRG.DeletePath(cfgPATH);
    // пишем новое, как оно счас есть
    tmpPTTN:=_lstPTTN_getFirst(node);
    cnt_idx:=0;
    while tmpPTTN<>nil do begin
        cfgPATH:=cTXT_PattensList+cPathDelim+cTXT_Item+inttostr(cnt_idx)+cPathDelim;
        fileSTRG.SetValue(cfgPATH+cTXT_used,_itmPTTN_getUsed(tmpPTTN));
        fileSTRG.SetValue(cfgPATH+cTXT_name,_itmPTTN_getNAME(tmpPTTN));
        fileSTRG.SetValue(cfgPATH+cTXT_seek,_itmPTTN_getSeek(tmpPTTN));
        //---
        tmpPTTN:=_itmPTTN_getNext(tmpPTTN);
        inc(cnt_idx);
    end;
    cfgPATH:=cTXT_PattensList+cPathDelim;
    fileSTRG.SetDeleteValue(cfgPATH+cTXT_count,cnt_idx,0);
end;

procedure tCbSFP_ideCallCenter._node_load_ListItmSEEK(const node:pCbSFP_Node; const fileSTRG:tCbSFP_ideFileStorage);
var CfgPATH:string;
    count,i:integer;
    tmpPTTN:pCbSFP_PTTN;
    tmpOPTN:pCbSFP_PTTN;
    tmpNAME:string;
    tmpSEEK:string;
    tmpUSED:boolean;
begin
    CfgPATH:=cTXT_PattensList+cPathDelim;
    count  :=fileSTRG.GetValue(CfgPATH+cTXT_count,0);
    // теперь про каждый из них
    for i:=0 to count-1 do begin
        CfgPATH:=cTXT_PattensList+cPathDelim+cTXT_Item+inttostr(i)+cPathDelim;
        //--- читаем из файла
        tmpPTTN:=nil;
        tmpOPTN:=nil;
        tmpNAME:= fileSTRG.GetValue(CfgPATH+cTXT_name,'');
        tmpSEEK:= fileSTRG.GetValue(CfgPATH+cTXT_seek,'');
        tmpUSED:= fileSTRG.GetValue(CfgPATH+cTXT_used,false);
        //--- пытаемся привязать к уже загруженному
        tmpOPTN:=_lstOPTN_fndNAME(node,tmpNAME);
        if not _lstPTTN_vldSEEK(Node,tmpSEEK)
        then tmpSEEK:='';
        //--- проверяем корректност, создаем и включаем в список
        if Assigned(tmpOPTN) and (tmpSEEK<>'') then begin
            tmpPTTN:=_itmPTTN_crt8ini(Node,tmpSEEK);
           _itmPTTN_setOPTN(tmpPTTN,tmpOPTN);
           _itmPTTN_setUsed(tmpPTTN,tmpUSED);
            //-->
           _lstPTTN_insLast(node,tmpPTTN);
        end;
    end;
end;

//------------------------------------------------------------------------------

procedure tCbSFP_ideCallCenter._node_save_ListItmOPTN(const node:pCbSFP_Node);
var tmpOPTN:pCbSFP_OPTN;
begin
   _forceDirectories_subScriber(node);
    tmpOPTN:=_lstOPTN_getFirst(node);
    while tmpOPTN<>nil do begin
       _node_SAVE_CNFG(node,tmpOPTN);
        tmpOPTN:=_itmOPTN_getNext(tmpOPTN);
    end;
end;

procedure tCbSFP_ideCallCenter._node_load_ListItmOPTN(const node:pCbSFP_Node);
var srchRec:TSearchRec;
    tmpName:string;
    tmpOPNT:pCbSFP_OPTN;
begin
   _forceDirectories_subScriber(node);
    tmpOPNT:=nil;
    tmpName:=_subScriber_OPTN_rootPath(node)+cAsterisk+_node_cnfFileEXT(node);
    if FindFirst(tmpName,faAnyFile,srchRec)=0 then
    repeat
        If (srchRec.Attr and faDirectory)<>faDirectory then begin
            tmpName:=_fileName_to_OPTN_Name(srchRec.Name);
            if tmpName=cItmOPTN_DEFAULT_name then begin //< "поУМОЛЧАНИЮ"
                // он ВСЕГДА ЕСТЬ и он самый ПЕРВЫЙ
                tmpOPNT:=_lstOPTN_defOPTNs(node);
               _node_LOAD_CNFG(node,tmpOPNT);
               _itmOPTN_setUsed(tmpOPNT,TRUE); //< ВСЕГДА используется
            end
            else begin
                if not Assigned(tmpOPNT) then tmpOPNT:=_itmOPTN_crt8ini(node);
               _itmOPTN_setName(tmpOPNT,tmpName);
                if _node_LOAD_CNFG(node,tmpOPNT) then begin
                   _lstOPTN_insLast(node,tmpOPNT);
                end;
            end;
            tmpOPNT:=nil;
        end;
    until FindNext(srchRec)<>0;
    FindClose(srchRec);
    if Assigned(tmpOPNT) then _itmOPTN_destroy(node,tmpOPNT);
end;

//------------------------------------------------------------------------------

procedure tCbSFP_ideCallCenter._node_save_ListOptnUSE(const node:pCbSFP_Node; const fileSTRG:tCbSFP_ideFileStorage);
var cfgPATH:string;
    tmpOPTN:pCbSFP_PTTN;
    cnt_idx:integer;
begin
    cfgPATH:=cTXT_OptionsUsed;
    fileSTRG.DeletePath(cfgPATH);
    // пишем новое, как оно счас есть (КРОМЕ первого, которое по умолчанию)
    tmpOPTN:=_lstOPTN_getFirst(node); // всегда ЕСТЬ и всегда ИСПОЛЬЗУЕТСЯ
    cnt_idx:=0;
    while tmpOPTN<>nil do begin //< идем по всем и сохраняем имена тех
        if (tmpOPTN<>_lstOPTN_defOPTNs(node))and(_itmOPTN_getUsed(tmpOPTN)) then begin
            // если это не DEF и используется то пишем
            cfgPATH:=cTXT_OptionsUsed+cPathDelim+cTXT_Item+inttostr(cnt_idx)+cPathDelim;
            fileSTRG.SetValue(cfgPATH+cTXT_name,_itmOPTN_getNAME(tmpOPTN));
            inc(cnt_idx);
        end;
        //-->
        tmpOPTN:=_itmOPTN_getNext(tmpOPTN);
    end;
    cfgPATH:=cTXT_OptionsUsed+cPathDelim;
    fileSTRG.SetDeleteValue(cfgPATH+cTXT_count,cnt_idx,0);
end;

procedure tCbSFP_ideCallCenter._node_load_ListOptnUSE(const node:pCbSFP_Node; const fileSTRG:tCbSFP_ideFileStorage);
var CfgPATH:string;
    count,i:integer;
    tmpNAME:string;
var tmpOPTN:pCbSFP_OPTN;
begin
    CfgPATH:=cTXT_OptionsUsed+cPathDelim;
    count  :=fileSTRG.GetValue(CfgPATH+cTXT_count,0);
    // теперь про каждый из них
    for i:=0 to count-1 do begin
        CfgPATH:=cTXT_OptionsUsed+cPathDelim+cTXT_Item+inttostr(i)+cPathDelim;
        //--- читаем из файла
        tmpNAME:=fileSTRG.GetValue(CfgPATH+cTXT_name,'');
        //--- исчем такой, и ставим отметку ИСПОЛЬЗУЕТСЯ
        tmpOPTN:=_lstOPTN_fndNAME(node,tmpNAME);
        if Assigned(tmpOPTN) then _itmOPTN_setUsed(tmpOPTN,TRUE);
    end;
    // теперь по УМОЛЧАНИЮ, он всегда ЕСТЬ и всегда ИСПОЛЬЗУЕТСЯ
   _itmOPTN_setUsed(_lstOPTN_defOPTNs(node),TRUE);
end;

//------------------------------------------------------------------------------

procedure tCbSFP_ideCallCenter._node_LOAD(const node:pCbSFP_Node);
var fileSTRG:tCbSFP_ideFileStorage;
begin
   _forceDirectories_callCenter;
    fileSTRG:=_node_configStorageCRT(node);
    try
       _node_load_ListItmOPTN(node);
       _node_load_ListOptnUSE(node,fileSTRG);
       _node_load_ListItmSEEK(node,fileSTRG);
    finally
        fileSTRG.FREE;
    end;
end;

procedure tCbSFP_ideCallCenter._node_SAVE(const node:pCbSFP_Node);
var fileSTRG:tCbSFP_ideFileStorage;
begin
   _forceDirectories_callCenter;
    fileSTRG:=_node_configStorageCRT(node);
    try
       _node_save_ListItmOPTN(node);
       _node_save_ListOptnUSE(node,fileSTRG);
       _node_save_ListItmSEEK(node,fileSTRG);
    finally
        fileSTRG.FREE;
    end;
end;

{%endregion}

{%region --- работа с УЗЛАМИ itmBase ------------------------------ /fold}

procedure tCbSFP_ideCallCenter._itmBase_CLR(const itm:pCbSFP_base);
begin
    with itm^ do begin
	    next:=nil;
	    CNFG:=nil;
	    TEXT:='';
	    USED:=false;
	end;
end;

procedure tCbSFP_ideCallCenter._itmBase_CRT(out itm:pCbSFP_base);
begin
    new(itm);
   _itmBase_CLR(itm);
end;

procedure tCbSFP_ideCallCenter._itmBase_DST(const itm:pCbSFP_base);
begin
   _itmBase_CLR(itm);
    dispose(itm);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tCbSFP_ideCallCenter._itmBase_getNext(const itm:pCbSFP_base):pCbSFP_base;
begin
    result:=itm^.next;
end;

procedure tCbSFP_ideCallCenter._itmBase_setNext(const itm:pCbSFP_base; const value:pCbSFP_base);
begin
    itm^.next:=value;
end;

function tCbSFP_ideCallCenter._itmBase_getCNFG(const itm:pCbSFP_base):pointer;
begin
    result:=itm^.CNFG;
end;

procedure tCbSFP_ideCallCenter._itmBase_setCNFG(const itm:pCbSFP_base; const value:pointer);
begin
    itm^.CNFG:=value;
end;

function tCbSFP_ideCallCenter._itmBase_getTEXT(const itm:pCbSFP_base):string;
begin
    result:=itm^.TEXT;
end;

procedure tCbSFP_ideCallCenter._itmBase_setTEXT(const itm:pCbSFP_base; const value:string);
begin
    itm^.TEXT:=value;
end;

function tCbSFP_ideCallCenter._itmBase_getUSED(const itm:pCbSFP_base):boolean;
begin
    result:=itm^.USED;
end;

procedure tCbSFP_ideCallCenter._itmBase_setUSED(const itm:pCbSFP_base; const value:boolean);
begin
    itm^.USED:=value;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tCbSFP_ideCallCenter._lstBase_insLast(var first:pCbSFP_base; const itm:pCbSFP_base);
var tmp:pCbSFP_base;
begin
    if Assigned(first) then begin
        tmp:=first;
        while Assigned(_itmBase_getNext(tmp)) do tmp:=_itmBase_getNext(tmp);
       _itmBase_setNext(tmp,itm);
    end
    else first:=itm;
end;

procedure tCbSFP_ideCallCenter._lstBase_cutItem(var first:pCbSFP_base; const itm:pCbSFP_base);
var tmp:pCbSFP_base;
begin
    if first<>itm then begin
        tmp:=first;
        while Assigned(tmp) and (_itmBase_getNext(tmp)<>itm) do tmp:=_itmBase_getNext(tmp);
        if Assigned(tmp) then _itmBase_setNext(tmp,_itmBase_getNext(itm));
    end
    else first:=_itmBase_getNext(itm);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tCbSFP_ideCallCenter._lstBase_vldText(const itm:pCbSFP_base; const TXT:string; const withOut:pCbSFP_base=nil):boolean;
var tmp:pCbSFP_base;
begin
    result:=true;
    tmp:=itm;
    while Assigned(tmp) do begin
        if (tmp<>withOut)and(_itmBase_getTEXT(tmp)=TXT) then begin
            result:=false;
            BREAK;
        end;
        tmp:=_itmBase_getNext(tmp)
    end;
end;

function tCbSFP_ideCallCenter._lstBase_newText(const itm:pCbSFP_base; const TXT:string):string;
var i:integer;
begin
    i:=0;
    result:=TXT;
    while not _lstBase_vldText(itm,result) do begin
        inc(i);
        str(i,result);
        result:=TXT+result;
    end;
end;

{%endregion}

{%region --- работа с УЗЛАМИ pCbSFP_OPTN -------------------------- /fold}

procedure tCbSFP_ideCallCenter._lstOPTN_CLEAR(const node:pCbSFP_Node; var FIRST:pCbSFP_OPTN);
var tmp:pCbSFP_OPTN;
begin
    tmp:=FIRST;
    while tmp<>nil do begin
        FIRST:=_itmOPTN_getNext(tmp);
       _itmOPTN_destroy(node,tmp);
        tmp:=FIRST;
    end;
end;

//------------------------------------------------------------------------------

function tCbSFP_ideCallCenter._lstOPTN_defOPTNs(const node:pCbSFP_Node):pCbSFP_OPTN;
begin //< да да да, по умолчанию у нас ВСЕГДА первый в списке
    result:=_lstOPTN_getFirst(node);
end;

//------------------------------------------------------------------------------

function tCbSFP_ideCallCenter._lstOPTN_getFirst(const node:pCbSFP_Node):pCbSFP_OPTN;
begin
    result:=node^.list_OPTNs;
end;

procedure tCbSFP_ideCallCenter._lstOPTN_setFirst(const node:pCbSFP_Node; const item:pCbSFP_OPTN);
begin
    node^.list_OPTNs:=item;
end;

procedure tCbSFP_ideCallCenter._lstOPTN_insLast(const node:pCbSFP_Node; const item:pCbSFP_OPTN);
begin
   _lstBase_insLast(node^.list_OPTNs,item);
end;

procedure tCbSFP_ideCallCenter._lstOPTN_cutItem(const node:pCbSFP_Node; const item:pCbSFP_OPTN);
begin
   _lstBase_cutItem(node^.list_OPTNs,item);
end;

function tCbSFP_ideCallCenter._lstOPTN_fndNAME(const node:pCbSFP_Node; const name:string):pCbSFP_OPTN;
begin
    result:=_lstOPTN_getFirst(node);
    while result<>nil do begin
        if _itmOPTN_getName(result)=name then BREAK;
        result:=_itmOPTN_getNext(result);
    end;
end;

function tCbSFP_ideCallCenter._lstOPTN_vldNAME(const node:pCbSFP_Node; const name:string; const withOut:pCbSFP_OPTN=nil):boolean;
begin
    result:=_lstBase_vldText(_lstOPTN_getFirst(node),name,withOut);
end;

//------------------------------------------------------------------------------

function tCbSFP_ideCallCenter._itmOPTN_crt8ini(const node:pCbSFP_Node):pCbSFP_OPTN;
begin
   _itmBase_CRT(result);
    if Assigned(node) and Assigned(node^.SubSiCLASS) then begin
       _itmOPTN_setName(result,_lstBase_newText(_lstOPTN_getFirst(node),cItmOPTN_DEFCUST_name));
       _itmOPTN_setCNFG(result,node^.SubSiCLASS.ConfigOBJ_CRT);
        node^.SubSiCLASS.ConfigOBJ_DEF(_itmOPTN_getCNFG(result));
    end;
end;

procedure tCbSFP_ideCallCenter._itmOPTN_destroy(const node:pCbSFP_Node; const item:pCbSFP_OPTN);
begin
    if Assigned(node) and Assigned(node^.SubSiCLASS) AND
       Assigned(item) and Assigned(_itmOPTN_getCNFG(item))
    then begin
        node^.SubSiCLASS.ConfigOBJ_DST(_itmOPTN_getCNFG(item));
    end;
   _itmBase_DST(item);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tCbSFP_ideCallCenter._itmOPTN_getNext(const item:pCbSFP_OPTN):pCbSFP_OPTN;
begin
    result:=_itmBase_getNext(item);
end;

procedure tCbSFP_ideCallCenter._itmOPTN_setNext(const item:pCbSFP_OPTN; const value:pCbSFP_OPTN);
begin
   _itmBase_setNext(item,value);
end;

function tCbSFP_ideCallCenter._itmOPTN_getCNFG(const item:pCbSFP_OPTN):pointer;
begin
    result:=_itmBase_getCNFG(item);
end;

procedure tCbSFP_ideCallCenter._itmOPTN_setCNFG(const item:pCbSFP_OPTN; const value:pointer);
begin
   _itmBase_setCNFG(item,value);
end;

function tCbSFP_ideCallCenter._itmOPTN_getName(const item:pCbSFP_OPTN):string;
begin
    result:=_itmBase_getTEXT(item);
end;

procedure tCbSFP_ideCallCenter._itmOPTN_setName(const item:pCbSFP_OPTN; const value:string);
begin
   _itmBase_setTEXT(item,value)
end;

function tCbSFP_ideCallCenter._itmOPTN_getUsed(const item:pCbSFP_OPTN):boolean;
begin
    result:=_itmBase_getUSED(item)
end;

procedure tCbSFP_ideCallCenter._itmOPTN_setUsed(const item:pCbSFP_OPTN; const value:boolean);
begin
   _itmBase_setUSED(item,value)
end;

{%endregion}

{%region --- работа с УЗЛАМИ pCbSFP_PTTN -------------------------- /fold}

procedure tCbSFP_ideCallCenter._lstPTTN_CLEAR(var FIRST:pCbSFP_PTTN);
var tmp:pCbSFP_PTTN;
begin
    tmp:=FIRST;
    while tmp<>nil do begin
        FIRST:=_itmPTTN_getNext(tmp);
       _itmPTTN_destroy(tmp);
        tmp:=FIRST;
    end;
end;

//------------------------------------------------------------------------------

function tCbSFP_ideCallCenter._lstPTTN_getFirst(const node:pCbSFP_Node):pCbSFP_PTTN;
begin
    result:=node^.list_PTTNs;
end;

procedure tCbSFP_ideCallCenter._lstPTTN_setFirst(const node:pCbSFP_Node; const item:pCbSFP_PTTN);
begin
    node^.list_PTTNs:=item;
end;

procedure tCbSFP_ideCallCenter._lstPTTN_insLast(const node:pCbSFP_Node; const item:pCbSFP_PTTN);
begin
   _lstBase_insLast(node^.list_PTTNs,item);
end;

procedure tCbSFP_ideCallCenter._lstPTTN_cutItem(const node:pCbSFP_Node; const item:pCbSFP_PTTN);
begin
   _lstBase_cutItem(node^.list_PTTNs,item);
end;

function tCbSFP_ideCallCenter._lstPTTN_vldSEEK(const node:pCbSFP_Node; const SEEK:string; const withOut:pCbSFP_PTTN=nil):boolean;
begin
    result:=_lstBase_vldText(_lstPTTN_getFirst(node),SEEK,withOut);
end;

//------------------------------------------------------------------------------

function tCbSFP_ideCallCenter._itmPTTN_crt8ini(const node:pCbSFP_Node; const seek:string=''):pCbSFP_PTTN;
begin
    _itmBase_CRT(result);
     if seek<>'' then _itmPTTN_setSeek(result,_lstBase_newText(_lstPTTN_getFirst(node),     seek))
     else _itmPTTN_setSeek(result,_lstBase_newText(_lstPTTN_getFirst(node),cItmSeek_DEFCUST_name))
end;

procedure tCbSFP_ideCallCenter._itmPTTN_destroy(const item:pCbSFP_PTTN);
begin
    if Assigned(item)then begin
       _itmBase_DST(item);
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tCbSFP_ideCallCenter._itmPTTN_getNext(const item:pCbSFP_PTTN):pCbSFP_PTTN;
begin
    result:=_itmBase_getNext(item);
end;

procedure tCbSFP_ideCallCenter._itmPTTN_setNext(const item:pCbSFP_PTTN; const value:pCbSFP_PTTN);
begin
   _itmBase_setNext(item,value);
end;

function tCbSFP_ideCallCenter._itmPTTN_getOPTN(const item:pCbSFP_PTTN):pCbSFP_OPTN;
begin
    result:=_itmBase_getCNFG(item);
end;

procedure tCbSFP_ideCallCenter._itmPTTN_setOPTN(const item:pCbSFP_PTTN; const value:pCbSFP_OPTN);
begin
   _itmBase_setCNFG(item,value);
end;

function tCbSFP_ideCallCenter._itmPTTN_getSeek(const item:pCbSFP_PTTN):string;
begin
    result:=_itmBase_getTEXT(item);
end;

procedure tCbSFP_ideCallCenter._itmPTTN_setSeek(const item:pCbSFP_PTTN; const value:string);
begin
   _itmBase_setTEXT(item,value)
end;

function tCbSFP_ideCallCenter._itmPTTN_getUsed(const item:pCbSFP_PTTN):boolean;
begin
    result:=_itmBase_getUSED(item)
end;

procedure tCbSFP_ideCallCenter._itmPTTN_setUsed(const item:pCbSFP_PTTN; const value:boolean);
begin
   _itmBase_setUSED(item,value)
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tCbSFP_ideCallCenter._itmPTTN_getNAME(const item:pCbSFP_PTTN):string;
var tmp:pCbSFP_OPTN;
begin
    result:='';
    tmp:=_itmPTTN_getOPTN(item);
    if Assigned(tmp) then result:=_itmOPTN_getName(tmp);
end;

function tCbSFP_ideCallCenter._itmPTTN_getCNFG(const item:pCbSFP_PTTN):pointer;
begin
    result:=_itmPTTN_getOPTN(item);
    if Assigned(result) then result:=_itmOPTN_getCNFG(result);
end;

{%endregion}

{%region --- SubScriber поиск ------------------------------------- /fold}

function tCbSFP_ideCallCenter._SubScrbr_REGISTER(const HNDL:tCbSFP_SubScriberTHandle; const EDTR:tCbSFP_SubScriberTEditor):pCbSFP_Node;
begin
    result:=_lair_FND_byIdentifier(HNDL.Identifier);
    if Assigned(result) then begin //< это ПЛОХО ... мы не сможем добавть
        result:=NIL;
    end
    else begin
       _node_CRT (result,HNDL,EDTR);
       _node_INI (result);
       _node_LOAD(result);
       _lair_ADD (result);
    end;
end;

//------------------------------------------------------------------------------

function tCbSFP_ideCallCenter.SubScriber_byIdeREC(const value:PIDEOptionsEditorRec):tCbSFP_SubScriber;
begin
    result:=_lair_FND_byIDEOptERec(value);
end;

function tCbSFP_ideCallCenter.SubScriber_byEDITOR(const value:TAbstractIDEOptionsEditor):tCbSFP_SubScriber;
begin
    result:=_lair_FND_byIDEOptERec(value.Rec);
end;

{%endregion}

{$region --- CallCenter .. РАСШИРЕНИЯ  ---------------------------- /fold}

{$ifDef ideLazExtMODE} //<------------------------- боевой режм "Расширения IDE"

function tCbSFP_ideCallCenterIDE.SubScriber_REGISTER(
            HNDL:tCbSFP_SubScriberTHandle;
            EDTR:tCbSFP_SubScriberTEditor;
            //---
            const AGroup,AIndex:Integer;
            const AParent:Integer=NoParent
            ):tCbSFP_SubScriber;
begin
    result:=_SubScrbr_REGISTER(HNDL,EDTR);
    if Assigned(result) then begin
        pCbSFP_Node(result)^.IDEOptERec:=CbSFP_ideGENERAL__register_SubScrbr(AGroup,AIndex,AParent);
    end;
end;

function tCbSFP_ideCallCenterIDE.SubScriber_REGISTER(
            HNDL:tCbSFP_SubScriberTHandle;
            EDTR:tCbSFP_SubScriberTEditor
            ):tCbSFP_SubScriber;
begin
    result:=_SubScrbr_REGISTER(HNDL,EDTR);
    if Assigned(result) then begin
        pCbSFP_Node(result)^.IDEOptERec:=CbSFP_ideGENERAL__register_SubScrbr;
    end;
end;

{$else} //<-------------------------------------------------- режим ТЕСТИРОВАНИЯ

{$ifDef uiDevelopPRJ}
function tCbSFP_ideCallCenterTST.SubScriber_REGISTER(HNDL:tCbSFP_SubScriberTHandle; EDTR:tCbSFP_SubScriberTEditor):tCbSFP_SubScriber;
begin // очищаем ВСЕ и создаем ЗАНОГО, чтобы был тока ЕДИНСТВЕННЫЙ
   _lair_DST;
   _lair_CRT;
    result:=_SubScrbr_REGISTER(HNDL,EDTR);
end;
{$endIf}

{$endIf}

{$endRegion}

//------------------------------------------------------------------------------

{$region --- tCbSFP_ideEditorNODE --------------------------------- /fold}

constructor tCbSFP_ideEditorNODE.Create(const CallCenter:tCbSFP_ideCallCenter; const Node:pCbSFP_Node);
begin
   _CallCenter_:=CallCenter;
   _SubScriber_:=Node;
   _old_lOPTNs_:=nil;
   _old_lPTTNs_:=nil;
   _del_lOPTNs_:=nil;
   _del_lPTTNs_:=nil;
end;

destructor tCbSFP_ideEditorNODE.DESTROY;
begin
    EDIT_doEnd(FALSE); //< это уничтожит структуры созданные для редактирования
end;

//------------------------------------------------------------------------------

function tCbSFP_ideEditorNODE.EDITtFRAME:tCbSFP_SubScriberTEditor;
begin
    result:=_SubScriber_^.SubStFRAME;
end;

function tCbSFP_ideEditorNODE.Identifier:string;
begin
    result:=_SubScriber_^.SubSiCLASS.Identifier;
end;

//------------------------------------------------------------------------------

function tCbSFP_ideEditorNODE._lstOPTN_addCOPY(const Item:pCbSFP_OPTN):pCbSFP_OPTN;
begin
    result:=_CallCenter_._itmOPTN_crt8ini(_SubScriber_);
   _CallCenter_._itmOPTN_setName(result,_CallCenter_._itmOPTN_getName(Item));
    //---
    if _CallCenter_._node_LOAD_CNFG(_SubScriber_,result) then begin
        if _CallCenter_._itmOPTN_getName(result)=cItmOPTN_DEFAULT_name then begin //< "поУМОЛЧАНИЮ"
            // он ВСЕГДА ЕСТЬ и он самый ПЕРВЫЙ
           _CallCenter_._itmOPTN_setNext(result,_CallCenter_._lstOPTN_defOPTNs(_SubScriber_));
           _CallCenter_._lstOPTN_setFirst(_SubScriber_,result);
           _CallCenter_._itmOPTN_setUsed(result,TRUE);
        end
        else begin
           _CallCenter_._lstOPTN_insLast(_SubScriber_,result);
           _CallCenter_._itmOPTN_setUsed(result,_CallCenter_._itmOPTN_getUsed(Item));
        end;
    end
    else begin
        _CallCenter_._itmOPTN_destroy(_SubScriber_,result);
         result:=nil;
    end;
end;

function tCbSFP_ideEditorNODE._lstPTTN_addCOPY(const Item:pCbSFP_PTTN):pCbSFP_PTTN;
var tmpOPTN:pointer;
begin
    tmpOPTN:=_CallCenter_._itmPTTN_getOPTN(Item);
    tmpOPTN:=_CallCenter_._lstOPTN_fndNAME(_SubScriber_,_CallCenter_._itmOPTN_getName(tmpOPTN));
    if Assigned(tmpOPTN) then begin
         result:=_CallCenter_._itmPTTN_crt8ini(_SubScriber_,_CallCenter_._itmPTTN_getSeek(Item));
        _CallCenter_._itmPTTN_setUsed(result,_CallCenter_._itmPTTN_getUsed(Item));
        _CallCenter_._itmPTTN_setOPTN(result,tmpOPTN);
        _CallCenter_._lstPTTN_insLast(_SubScriber_,result);
    end;
end;

//------------------------------------------------------------------------------

function tCbSFP_ideEditorNODE._IsEDITED:boolean;
begin
    result:=Assigned(_old_lOPTNs_); //< если тут что-то лежит => мы РЕДАКТИРУЕМСЯ
end;

procedure tCbSFP_ideEditorNODE.EDIT_Start;
var tmp:pointer;
begin
    if not _IsEDITED then begin
        //--- переносим в сохраненное (СТАРОЕ)
       _old_lOPTNs_:=_CallCenter_._lstOPTN_getFirst(_SubScriber_);
       _CallCenter_._lstOPTN_setFirst(_SubScriber_,nil);
       _old_lPTTNs_:=_CallCenter_._lstPTTN_getFirst(_SubScriber_);
       _CallCenter_._lstPTTN_setFirst(_SubScriber_,nil);
        //--- копируем
        tmp:=_old_lOPTNs_;
        while tmp<>nil do begin
           _lstOPTN_addCOPY(tmp);
            tmp:=_CallCenter_._itmOPTN_getNext(tmp);
        end;
        tmp:=_old_lPTTNs_;
        while tmp<>nil do begin
           _lstPTTN_addCOPY(tmp);
            tmp:=_CallCenter_._itmPTTN_getNext(tmp);
        end;
    end;
end;

procedure tCbSFP_ideEditorNODE.EDIT_doEnd(const WithSAVE:boolean);
var tmp:pointer;
begin
    if _IsEDITED then begin
        if WithSAVE then begin
            // уничтожение файлов УДАЛЕННЫХ настроек
            tmp:=_del_lOPTNs_;
            while tmp<>nil do begin
               _CallCenter_._deleteFileFromFS_subScriber(_SubScriber_,tmp);
                tmp:=_CallCenter_._itmOPTN_getNext(tmp);
            end;
            // продолжение чистки, уничтожаем СТАРЫЕ настройки
           _CallCenter_._lstPTTN_CLEAR(_old_lPTTNs_);
           _CallCenter_._lstOPTN_CLEAR(_SubScriber_,_old_lOPTNs_);
            //---
           _CallCenter_._node_SAVE(_SubScriber_);
        end
        else begin //< возвращаем ПЕРВИЧНОЕ состояние
            //--- меняем PTTN
            tmp:=_CallCenter_._lstPTTN_getFirst(_SubScriber_);
           _CallCenter_._lstPTTN_CLEAR(tmp);
           _CallCenter_._lstPTTN_setFirst(_SubScriber_,_old_lPTTNs_);
           _old_lPTTNs_:=nil; //< на всяк ПЖС
            //--- меняем OPTN
            tmp:=_CallCenter_._lstOPTN_getFirst(_SubScriber_);
           _CallCenter_._lstOPTN_CLEAR(_SubScriber_,tmp);
           _CallCenter_._lstOPTN_setFirst(_SubScriber_,_old_lOPTNs_);
           _old_lOPTNs_:=nil; //< на всяк ПЖС
        end;
        //--- что там по удаляли? ... тоже уничтожим
       _CallCenter_._lstPTTN_CLEAR(_del_lPTTNs_);
       _CallCenter_._lstOPTN_CLEAR(_SubScriber_,_del_lOPTNs_);
    end;
end;

//------------------------------------------------------------------------------

{%region --- работа с УЗЛАМИ pCbSFP_OPTN ---------------------- /fold}

function tCbSFP_ideEditorNODE.lstOPTN_getFirst:pCbSFP_OPTN;
begin
    result:=_CallCenter_._lstOPTN_getFirst(_SubScriber_);
end;

procedure tCbSFP_ideEditorNODE.lstOPTN_setFirst(const item:pCbSFP_OPTN);
begin
   _CallCenter_._lstOPTN_setFirst(_SubScriber_,item);
end;

function tCbSFP_ideEditorNODE.lstOPTN_getNEXT(const item:pCbSFP_OPTN):pCbSFP_OPTN;
begin
    result:=_CallCenter_._itmOPTN_getNext(item);
end;

procedure tCbSFP_ideEditorNODE.lstOPTN_setNEXT(const item:pCbSFP_OPTN; const value:pCbSFP_OPTN);
begin
   _CallCenter_._itmOPTN_setNext(item,value);
end;

function tCbSFP_ideEditorNODE.lstOPTN_defOPTNs:pCbSFP_OPTN;
begin
    result:=_CallCenter_._lstOPTN_defOPTNs(_SubScriber_);
end;

function tCbSFP_ideEditorNODE.lstOPTN_defCNFGs:pointer;
begin
    result:=lstOPTN_defOPTNs;
    if Assigned(result) then result:=itmOPTN_getCNFG(result);
end;

function tCbSFP_ideEditorNODE.lstOPTN_vldName(const Name:string; const withOut:pCbSFP_OPTN=nil):boolean;
begin
    result:=_CallCenter_._lstOPTN_vldNAME(_SubScriber_,Name,withOut);
end;

function tCbSFP_ideEditorNODE.lstOPTN_addItem:pCbSFP_OPTN;
begin
    result:=_CallCenter_._itmOPTN_crt8ini(_SubScriber_);
   _CallCenter_._lstOPTN_insLast(_SubScriber_,result);
end;

procedure tCbSFP_ideEditorNODE.lstOPTN_delItem(const item:pCbSFP_PTTN);
begin
   _CallCenter_._lstOPTN_cutItem(_SubScriber_,item);
   _CallCenter_._itmOPTN_setNext(item,_del_lOPTNs_);
   _del_lOPTNs_:=item;
end;

//------------------------------------------------------------------------------

function tCbSFP_ideEditorNODE.itmOPTN_getCNFG(const item:pCbSFP_OPTN):pointer;
begin
    result:=_CallCenter_._itmOPTN_getCNFG(item);
end;

function tCbSFP_ideEditorNODE.itmOPTN_getName(const item:pCbSFP_OPTN):string;
begin
    result:=_CallCenter_._itmOPTN_getName(item);
end;

procedure tCbSFP_ideEditorNODE.itmOPTN_setName(const item:pCbSFP_OPTN; const value:string);
begin
   _CallCenter_._itmOPTN_setName(item,value);
end;

function tCbSFP_ideEditorNODE.itmOPTN_getUsed(const item:pCbSFP_OPTN):boolean;
begin
    result:=_CallCenter_._itmOPTN_getUsed(item);
end;

procedure tCbSFP_ideEditorNODE.itmOPTN_setUsed(const item:pCbSFP_OPTN; const value:boolean);
begin
   _CallCenter_._itmOPTN_setUsed(item,value);
end;

{%endregion}

{%region --- работа с УЗЛАМИ pCbSFP_PTTN ---------------------- /fold}

function tCbSFP_ideEditorNODE.lstPTTN_getFirst:pCbSFP_PTTN;
begin
    result:=_CallCenter_._lstPTTN_getFirst(_SubScriber_);
end;

procedure tCbSFP_ideEditorNODE.lstPTTN_setFirst(const item:pCbSFP_PTTN);
begin
   _CallCenter_._lstPTTN_setFirst(_SubScriber_,item);
end;

function tCbSFP_ideEditorNODE.lstPTTN_getNEXT(const item:pCbSFP_PTTN):pCbSFP_PTTN;
begin
    result:=_CallCenter_._itmPTTN_getNext(item);
end;

procedure tCbSFP_ideEditorNODE.lstPTTN_setNEXT(const item:pCbSFP_PTTN; const value:pCbSFP_PTTN);
begin
   _CallCenter_._itmPTTN_setNext(item,value);
end;

function tCbSFP_ideEditorNODE.lstPTTN_vldSeek(const Seek:string; const withOut:pCbSFP_OPTN=nil):boolean;
begin
    result:=_CallCenter_._lstPTTN_vldSEEK(_SubScriber_,Seek,withOut);
end;

function tCbSFP_ideEditorNODE.lstPTTN_cntOPTN(const item:pCbSFP_OPTN):integer;
var tmp:pointer;
begin
    result:=0;
    tmp:=lstPTTN_getFirst;
    while tmp<>nil do begin
        if itmPTTN_getOPTN(tmp)=item then inc(result);
        tmp:=lstPTTN_getNEXT(tmp);
    end;
end;

procedure tCbSFP_ideEditorNODE.lstPTTN_delItem(const item:pCbSFP_PTTN);
begin
   _CallCenter_._lstPTTN_cutItem(_SubScriber_,item);
   _CallCenter_._itmPTTN_setNext(item,_del_lPTTNs_);
   _del_lPTTNs_:=item;
end;

//------------------------------------------------------------------------------

function tCbSFP_ideEditorNODE.lstPTTN_addFromOPTN(const OPTN:pCbSFP_OPTN):pCbSFP_PTTN;
begin
    result:=_CallCenter_._itmPTTN_crt8ini(_SubScriber_);
   _CallCenter_._itmPTTN_setOPTN(result,OPTN);
   _CallCenter_._lstPTTN_insLast(_SubScriber_,result);
end;

function tCbSFP_ideEditorNODE.lstPTTN_addFromPTTN(const PTTN:pCbSFP_PTTN):pCbSFP_PTTN;
begin
    result:=_CallCenter_._itmPTTN_crt8ini(_SubScriber_,_CallCenter_._itmPTTN_getSeek(PTTN));
   _CallCenter_._itmPTTN_setOPTN(result,_CallCenter_._itmPTTN_getOPTN(PTTN));
   _CallCenter_._lstPTTN_insLast(_SubScriber_,result);
end;

//------------------------------------------------------------------------------

function tCbSFP_ideEditorNODE.itmPTTN_getOPTN(const item:pCbSFP_PTTN):pCbSFP_OPTN;
begin
    result:=_CallCenter_._itmPTTN_getOPTN(item);
end;

procedure tCbSFP_ideEditorNODE.itmPTTN_setOPTN(const item:pCbSFP_PTTN; const value:pCbSFP_OPTN);
begin
   _CallCenter_._itmPTTN_setOPTN(item,value);
end;

function tCbSFP_ideEditorNODE.itmPTTN_getName(const item:pCbSFP_PTTN):string;
begin
    result:=_CallCenter_._itmPTTN_getNAME(item);
end;

function tCbSFP_ideEditorNODE.itmPTTN_getCNFG(const item:pCbSFP_PTTN):pointer;
begin
    result:=_CallCenter_._itmPTTN_getCNFG(item);
end;

function tCbSFP_ideEditorNODE.itmPTTN_getSeek(const item:pCbSFP_PTTN):string;
begin
    result:=_CallCenter_._itmPTTN_getSeek(item);
end;

procedure tCbSFP_ideEditorNODE.itmPTTN_setSeek(const item:pCbSFP_PTTN; const value:string);
begin
   _CallCenter_._itmPTTN_setSeek(item,value);
end;

function tCbSFP_ideEditorNODE.itmPTTN_getUsed(const item:pCbSFP_PTTN):boolean;
begin
    result:=_CallCenter_._itmPTTN_getUsed(item);
end;

procedure tCbSFP_ideEditorNODE.itmPTTN_setUsed(const item:pCbSFP_PTTN; const value:boolean);
begin
   _CallCenter_._itmPTTN_setUsed(item,value);
end;

{%endregion}

{$endRegion}

//------------------------------------------------------------------------------

{%region --- ЭКЗЕМПЛЯР _CallCenter_:tCbSFP_ideCallCenter ---------- /fold}

var _CallCenter_:tCbSFP_ideCallCenter;

function CbSFP_ideCenter__EditorNODE(const value:TAbstractIDEOptionsEditor):tCbSFP_ideEditorNODE;
begin
    result:=tCbSFP_ideEditorNODE.Create(_CallCenter_,_CallCenter_.SubScriber_byEDITOR(value));
end;

{$ifNDef uiDevelopPRJ} //< боевой режм "Расширения IDE"

function CbSFP_ideCenter__SubScriberREGISTER(const HNDL:tCbSFP_SubScriberTHandle; const EDTR:tCbSFP_SubScriberTEditor):tCbSFP_SubScriber;
begin
    result:=tCbSFP_ideCallCenterIDE(_CallCenter_).SubScriber_REGISTER(HNDL,EDTR);
end;

function CbSFP_ideCenter__SubScriberREGISTER(const HNDL:tCbSFP_SubScriberTHandle; const EDTR:tCbSFP_SubScriberTEditor; const AGroup,AIndex:Integer; const AParent:Integer=NoParent):tCbSFP_SubScriber;
begin
    result:=tCbSFP_ideCallCenterIDE(_CallCenter_).SubScriber_REGISTER(HNDL,EDTR, AGroup,AIndex,AParent);
end;

{$else} //< режим ТЕСТИРОВАНИЯ

function CbSFP_ideCenter__SubScriberREGISTER(const HNDL:tCbSFP_SubScriberTHandle; const EDTR:tCbSFP_SubScriberTEditor):tCbSFP_SubScriber;
begin
    result:=tCbSFP_ideCallCenterTST(_CallCenter_).SubScriber_REGISTER(HNDL,EDTR);
end;

{$endIf}

{%endregion}

initialization

   _CallCenter_:=
        {$ifDef ideLazExtMODE}
            tCbSFP_ideCallCenterIDE
        {$else}
            {$ifDef uiDevelopPRJ}
            tCbSFP_ideCallCenterTST
            {$endIf}
        {$endIf}.Create;

finalization
   _CallCenter_.FREE;
   _CallCenter_:=nil;

end.

