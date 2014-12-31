unit CbSFP_ideEditor;

//----------------------\\-----------------------------------------------------=
//  ╔═╗┌┐ ╔═╗╔═╗╔═╗      \\  Configuration by Source File Path                 =
//  ║  ├┴┐╚═╗╠╣ ╠═╝      //  Конфигурация по пути исходного файла              =
//  ╚═╝└─┘╚═╝╚  ╩ v0.9  //   [tCbSFP_ideCallEditor]                            =
//---------------------//------------------------------------------------------=
// Фрейм-Контейнер для пользовательских TCbSFP_SubScriber_edtFrm
// реализует основную функциональность по настройке и привязке к путям
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
{.$define CbSFP_log_ON}  //<----------------------- логирование ПОВЕДЕНИЯ
{$ifDef uiDevelopPRJ}
    {$undef ideLazExtMODE}
{$endif}


interface

uses sysutils, Classes, Graphics,  Dialogs,
     StdCtrls, Controls, Buttons, ActnList, ExtCtrls, CheckLst,
     //---
     {$ifDef CbSFP_log_ON}
     eventlog,
     {$endIf}
     CbSFP_ideCenter, CbSFP_SubScriber,
     {$ifDef ideLazExtMODE}
     SrcEditorIntf,
     {$endIf}
     IDEOptionsIntf, types;

type

 { tCbSFP_ideCallEditor }

 tCbSFP_ideCallEditor=class(TAbstractIDEOptionsEditor)
    //---
    ActionList: TActionList;
    aOPTN_aDEL: TAction;
    aOPTN_aAdd: TAction;
    aPTTN_aAdd: TAction;
    aPTTN_aDEL: TAction;
    aPTTN_mwUP: TAction;
    aPTTN_mwDW: TAction;
    aCNFG__DEF: TAction;
    Button1: TButton;
    //---
    CMMN_Panel: TPanel;
    CNFG_toDEF: TSpeedButton;
    Common_CHB: TCheckBox;
    Common_CPT: TLabel;
    Common_EDT: TEdit;
    Common_i_1: TImage;
    Common_L_1: TLabel;
    Common_L_2: TLabel;
    Common_OPT: TComboBox;
    Common_PNL: TPanel;
    Common_sh1: TShape;
    Common_sh2: TShape;
    //---
    GBox_Panel: TPanel;
    Shape1: TShape;
    TESTs_lbl0: TLabel;
    TESTs_lbl1: TLabel;
    TESTs_lbl2: TLabel;
    Splitter_1: TSplitter;
    Splitter_2: TSplitter;
    //---
    OPTNs_GBox: TGroupBox;
    OPTNs_lBox: TCheckListBox;
    OPTNs_bAdd: TSpeedButton;
    OPTNs_bDel: TSpeedButton;
    //---
    PTTNs_GBox: TGroupBox;
    PTTNs_lBox: TCheckListBox;
    PTTNs_bAdd: TSpeedButton;
    PTTNs_bDel: TSpeedButton;
    PTTNs_bUp : TSpeedButton;
    PTTNs_bDwn: TSpeedButton;
    //---
    TESTs_gBOX: TGroupBox;
    procedure Button1Click(Sender: TObject);
    procedure OPTNs_lBoxDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure TESTs_lbl1Resize(Sender: TObject);



 protected //<-----------------------------------------------------------------
    {$ifDef CbSFP_log_ON}
   _EventLog_: TEventLog;
    {$endIf}
  {%region --- выход на CallCenter -------------------------------- /fold}
  strict private
   _ideEditorNODE_:pointer;
    procedure _ideEditorNODE_CLR; inline;
    procedure _ideEditorNODE_SET; inline;
  protected
    function nodeEditor:tCbSFP_ideEditorNODE;
  {%endregion}
  {%region --- выход на IDE lazarus ------------------------------- /fold}
  protected
   _testFileName:string;
    procedure _testFileName_set(const value:string);
    procedure _testFileName_ini;
    {$ifDef ideLazExtMODE}
    function _ideLazarus_ActivEditFileName:string;
    {$endIf}
  {%endregion}
  {%region --- основные контроля списков_... ---------------------- /fold}
  protected
    procedure _OPTNs_lBox__onSelectionChange(Sender:TObject; User:boolean);
    procedure _OPTNs_lBox__onClickCheck     (Sender:TObject);
    procedure _OPTNs_lBox__doSelectConfigure(const CNFG:pointer);
    function  _OPTNs_lBox__getOPTN (const i:integer):pointer;
    function  _OPTNs_lBox__getCNFG (const i:integer):pointer;
    function  _OPTNs_lBox__fndOPTN (const OPTN:pCbSFP_OPTN):integer;
  protected
    procedure _OPTNs_bAdd__onChangeBounds(Sender:TObject);
  protected
    procedure _PTTNs_lBox__onSelectionChange(Sender:TObject; User:boolean);
    procedure _PTTNs_lBox__onClickCheck     (Sender:TObject);
    procedure _PTTNs_lBox__doUnLckSingleMode(const OPTN:pCbSFP_OPTN);
    procedure _PTTNs_lBox__doUnLckSelectNull(const OPTN:pCbSFP_OPTN);
    function  _PTTNs_lBox__getPTTN (const i:integer):pointer;
    function  _PTTNs_lBox__getOPTN (const i:integer):pointer;
    function  _PTTNs_lBox__getCNFG (const i:integer):pointer;
  protected
    function  _OPTNs_lBox__clcCPTN(const itm:pCbSFP_OPTN; const cnt:integer):string;
    function  _OPTNs_lBox__clcCPTN(const itm:pCbSFP_OPTN):string;
    function  _PTTNs_lBox__clcCPTN(const itm:pCbSFP_PTTN):string;
  protected
    procedure _lBOXs_reSetITEMs;
    procedure _OPTNs_lBox__reSetITEM(const i:integer);
    procedure _PTTNs_lBox__reSetITEM(const i:integer);
  {%endregion}
  {%region --- общие контролы Common_... -------------------------- /fold}
  protected //<--- фрейм для отображения пользовательской НАСТРОЙКИ
   _common_FRM_:TCbSFP_SubScriber_editor;
    procedure _common_FRM__Tst2CRT;
    procedure _common_FRM__DESTROY;
  protected //<-----------------------------------------------------------------
    procedure _Common_CHB_asOPTN__onChange(Sender: TObject);
    procedure _Common_CHB_asPTTN__onChange(Sender: TObject);
  protected //<-----------------------------------------------------------------
    procedure _Common_EDT_asOPTN__onChange(Sender: TObject);
    procedure _Common_EDT_asOPTN__onEnter (Sender: TObject);
    procedure _Common_EDT_asOPTN__onExit  (Sender: TObject);
    procedure _Common_EDT_asPTTN__onChange(Sender: TObject);
    procedure _Common_EDT_asPTTN__onEnter (Sender: TObject);
    procedure _Common_EDT_asPTTN__onExit  (Sender: TObject);
  protected //<-----------------------------------------------------------------
    procedure _Common_OPT_asPTTN__onEnter (Sender: TObject);
    procedure _Common_OPT_asPTTN__onChange(Sender: TObject);
    procedure _Common_OPT_asPTTN__onExit  (Sender: TObject);
    procedure _common_OPT_asPTTN__doSelect(const OPTN:pCbSFP_OPTN);
    procedure _common_OPT_asPTTN__fillList;
    function  _common_OPT_asPTTN__findOPTN(const OPTN:pCbSFP_OPTN):integer;
  protected //<-----------------------------------------------------------------
    procedure _common__setFromPATTERNs;
    procedure _common__setFromOPTIONs;
  {%endregion}
  {%region --- что КОНКРЕКТНО выделено _slctd_...------------------ /fold}
  protected
   _slctd_FROM_:integer; //< см. consts cILECBSPiEOA_selected_..
   _slctd_INDX_:integer; //< номер строки из TCheckListBox
   _slctd_ITEM_:pointer; //< что КОНКРЕТНО выделено
   _slctd_CNFG_:pointer; //< текущая РЕДАКТИРУЕМАЯ конфигурация
    procedure _common_FRM__CNFG_SET(const CNFG:pointer);
    procedure _selected_SET_OPTNs(const INDeX:integer);
    procedure _selected_SET_PTTNs(const INDeX:integer);
    procedure _doSelected_DEFAULT_ITM;
  {%endregion}
  {%region --- события tActions .. -------------------------------- /fold}
  protected
    procedure _aOPTN_aAdd_onExecute(Sender: TObject);
    procedure _aOPTN_aAdd_onUpdate (Sender: TObject);
    procedure _aOPTN_aDEL_onExecute(Sender: TObject);
    procedure _aOPTN_aDEL_onUpdate (Sender: TObject);
  protected
    procedure _aCNFG__DEF_onExecute(Sender: TObject);
    procedure _aCNFG__DEF_onUpdate (Sender: TObject);
  protected
    procedure _aPTTN_aAdd_onExecute(Sender: TObject);
    procedure _aPTTN_aAdd_onUpdate (Sender: TObject);
    procedure _aPTTN_aDEL_onExecute(Sender: TObject);
    procedure _aPTTN_aDEL_onUpdate (Sender: TObject);
    procedure _aPTTN_mwUP_onExecute(Sender: TObject);
    procedure _aPTTN_mwUP_onUpdate (Sender: TObject);
    procedure _aPTTN_mwDW_onExecute(Sender: TObject);
    procedure _aPTTN_mwDW_onUpdate (Sender: TObject);
  {%endregion}
  {%region --- сохранение и загрузка .. --------------------------- /fold}
  protected
    procedure _settingsLOAD__OPTNs_lBox__Load;
    procedure _settingsLOAD__PTTNs_lBox__Load;
    procedure _settingsLOAD_;
    procedure _settingsSAVE__OPTNs_lBox__Save;
    procedure _settingsSAVE__PTTNs_lBox__Save;
    procedure _settingsSAVE_;
  {%endregion}

  {%region ---  .. --------------------------- /fold}
  protected
   _tst_TEXT_:string;
    procedure _TST_setLBLs(const tst_TEXT:string);
    procedure _TST_setLBLs(const t0,t1,t2:string);
    procedure _TST_re_CALC(const SRC,PTTN:string);
    procedure _TST__update;
  {%endregion}
  protected //<-----------------------------------------------------------------
    procedure _onCreate_fixHimSelfName;
    procedure _onCreate_fixActionsName;
    procedure _onCreate_setActionsEVNT;
    procedure _onCreate_setButtonsIMGs;
    procedure _onResize_controlsPosSET(Sender:TObject);
    procedure _onSetup_gBox_setConstraints;
  protected //<-----------------------------------------------------------------
    procedure _frame_setSizes(const v1,v2:integer);
    procedure _frame_getSizes(out   v1,v2:integer);
  public
    constructor Create(TheOwner: TComponent); override;
    destructor DESTROY; override;
  public
    {$ifDef uiDevelopPRJ}
    property testFileName:string read _testFileName write _testFileName_set;
    {$endif}
  public
    function GetTitle: String; override;
    class function SupportedOptionsClass:TAbstractIDEOptionsClass; override;
  public
    procedure  Setup({%H-}ADialog:TAbstractOptionsEditorDialog);   override;
    procedure  ReadSettings({%H-}AOptions:TAbstractIDEOptions);    override;
    procedure  WriteSettings({%H-}AOptions:TAbstractIDEOptions);   override;
    procedure  RestoreSettings({%H-}AOptions:TAbstractIDEOptions); override;
  end;

implementation
{$ifDef ideLazExtMODE}
uses CbSFP_ideGENERAL_config;
{$endIf}

{%region --- inLine .. -------------------------------------------- /fold}

const
  cILECBSPiEOA_OPTNs_DefIDX= 0; //< это по УМОЛЧАНИЮ пункт
  cILECBSPiEOA_selected_NDF=-1; //< это НАЧАЛО
  cILECBSPiEOA_selected_OPT= 1; //< выбрана ОПЦИЯ
  cILECBSPiEOA_selected_PTN= 2; //< выбран ШАБЛОН

{%endregion}

{$R *.lfm}

constructor tCbSFP_ideCallEditor.Create(TheOwner:TComponent);
begin
    inherited;
    self.Rec:=NIL;
    {$ifDef CbSFP_log_ON}
   _EventLog_:=TEventLog.Create(self);
   _EventLog_.LogType :=ltFile;
   _EventLog_.FileName:=self.ClassName+'.log';
    {$endIf}
   _onCreate_fixHimSelfName;
   _onCreate_fixActionsName;
   _onCreate_setActionsEVNT;
   _onCreate_setButtonsIMGs;
    //---
   _testFileName:='';
    {$ifDef ideLazExtMODE}
   _testFileName_set(_ideLazarus_ActivEditFileName);
    {$endIf}
    //---
   _ideEditorNODE_:=NIL;
    //---
   _common_FRM_:=nil;
   _slctd_FROM_:=cILECBSPiEOA_selected_NDF;
   _slctd_INDX_:=cILECBSPiEOA_selected_NDF;
   _slctd_ITEM_:=nil;
   _slctd_CNFG_:=nil;
    //---
    OPTNs_lBox.DoubleBuffered:=TRUE;
    OPTNs_lBox.OnSelectionChange:=@_OPTNs_lBox__onSelectionChange;
    OPTNs_lBox.OnClickCheck     :=@_OPTNs_lBox__onClickCheck;
    //---
    OPTNs_bAdd.OnChangeBounds   :=@_OPTNs_bAdd__onChangeBounds;
    //---
    PTTNs_lBox.DoubleBuffered:=TRUE;
    PTTNs_lBox.OnSelectionChange:=@_PTTNs_lBox__onSelectionChange;
    PTTNs_lBox.OnClickCheck     :=@_PTTNs_lBox__onClickCheck;
    //---
    self.OnResize:=@_onResize_controlsPosSET;
    {$ifDef CbSFP_log_ON}
   _EventLog_.Debug('CreatED');
    {$endIf}
   _testFileName_ini;
end;

destructor tCbSFP_ideCallEditor.DESTROY;
begin // !!! порядок ВАЖЕН !!!
    {$ifDef CbSFP_log_ON}
   _EventLog_.Debug('Destroy');
    {$endIf}
   _common_FRM__DESTROY; //< уничтожение ФРЕЙМА
   _ideEditorNODE_CLR;   //< чистим объекта
    {$ifDef CbSFP_log_ON}
   _EventLog_.Debug('DestroyED');
    {$endIf}
    inherited;
end;

//------------------------------------------------------------------------------

{%region --- внутренняя КУХНЯ .. ---------------------------------- /fold}

procedure tCbSFP_ideCallEditor._onCreate_fixHimSelfName;
begin {--- объяснительная --- [fold]
       *  при создании ОДИНАКОВЫХ (с одним self.Name) возникает ошибка,
       *  поэтому для КАЖДОВОГО НОВОГО фрейма задаем "УНИКАЛЬНОЕ" имя,
       *  основанное на его УКАЗАТЕЛЕ.
       *  Будем надеяться что этого будет достаточно
       *---------------------------}
      Name:=Name+IntToHex(PtrUInt(self),sizeOf(PtrUInt)*2);
end;

procedure tCbSFP_ideCallEditor._onCreate_fixActionsName;
begin
    {$ifDEF uiDevelopPRJ}
    aOPTN_aAdd.Caption:='aAdd';
    aOPTN_aDEL.Caption:='aDEL';
    aPTTN_aAdd.Caption:='aAdd';
    aPTTN_aDEL.Caption:='aDEL';
    aPTTN_mwUP.Caption:='a_Up';
    aPTTN_mwDW.Caption:='aDwn';
    aCNFG__DEF.Caption:='toDEF';
    {$else}
    aOPTN_aAdd.Caption:='';
    aOPTN_aDEL.Caption:='';
    aPTTN_aAdd.Caption:='';
    aPTTN_aDEL.Caption:='';
    aPTTN_mwUP.Caption:='';
    aPTTN_mwDW.Caption:='';
    aCNFG__DEF.Caption:='';
    {$endIf}
end;

procedure tCbSFP_ideCallEditor._onCreate_setActionsEVNT;
begin //< тупо ради красоты
    aOPTN_aAdd.OnExecute:=@_aOPTN_aAdd_onExecute;
    aOPTN_aAdd.OnUpdate :=@_aOPTN_aAdd_onUpdate;
    aOPTN_aDEL.OnExecute:=@_aOPTN_aDEL_onExecute;
    aOPTN_aDEL.OnUpdate :=@_aOPTN_aDEL_onUpdate;
    //---
    aPTTN_aAdd.OnExecute:=@_aPTTN_aAdd_onExecute;
    aPTTN_aAdd.OnUpdate :=@_aPTTN_aAdd_onUpdate;
    aPTTN_aDEL.OnExecute:=@_aPTTN_aDEL_onExecute;
    aPTTN_aDEL.OnUpdate :=@_aPTTN_aDEL_onUpdate;
    aPTTN_mwUP.OnExecute:=@_aPTTN_mwUP_onExecute;
    aPTTN_mwUP.OnUpdate :=@_aPTTN_mwUP_onUpdate;
    aPTTN_mwDW.OnExecute:=@_aPTTN_mwDW_onExecute;
    aPTTN_mwDW.OnUpdate :=@_aPTTN_mwDW_onUpdate;
    //---
    aCNFG__DEF.OnExecute:=@_aCNFG__DEF_onExecute;
    aCNFG__DEF.OnUpdate :=@_aCNFG__DEF_onUpdate;
end;

procedure tCbSFP_ideCallEditor._onCreate_setButtonsIMGs;
begin
    {$ifDEF ideLazExtMODE}
        OPTNs_bAdd.LoadGlyphFromLazarusResource('laz_add');
        OPTNs_bDel.LoadGlyphFromLazarusResource('laz_delete');
        //---
        PTTNs_bAdd.LoadGlyphFromLazarusResource('laz_add');
        PTTNs_bDel.LoadGlyphFromLazarusResource('laz_delete');
        PTTNs_bUp .LoadGlyphFromLazarusResource('arrow_up');
        PTTNs_bDwn.LoadGlyphFromLazarusResource('arrow_down');
        //---
        CNFG_toDEF.LoadGlyphFromLazarusResource('pkg_inherited');
    {$endIf}
end;

//------------------------------------------------------------------------------

procedure tCbSFP_ideCallEditor._frame_setSizes(const v1,v2:integer);
begin
   OPTNs_GBox.Height:=v1;
   GBox_Panel.Width:=v2;
end;

procedure tCbSFP_ideCallEditor._frame_getSizes(out v1,v2:integer);
begin
    v1:=OPTNs_GBox.Height;
    v2:=GBox_Panel.Width;
end;

//------------------------------------------------------------------------------

procedure tCbSFP_ideCallEditor._onResize_controlsPosSET(Sender:TObject);
var W:integer;
begin
    Common_sh2.BorderSpacing.Top:=(Common_OPT.Height div 2)+1;
    Common_PNL.BorderSpacing.Top:= Common_sh2.BorderSpacing.Top;
    Common_PNL.BorderSpacing.Right:=Splitter_1.Width div 2;
    CNFG_toDEF.BorderSpacing.Right:=Splitter_1.Width div 2;
    //---
    w:=0;
    with Common_CHB do if W<Width then W:=Width;
    with Common_L_2 do if W<Width then W:=Width;
    Common_EDT.BorderSpacing.Left:=W+16;
    //---
    Common_EDT.BorderSpacing.Right:=Common_i_1.Width+Common_i_1.BorderSpacing.Right*2;
end;

//------------------------------------------------------------------------------

procedure tCbSFP_ideCallEditor._onSetup_gBox_setConstraints;
begin {todo: переделать}
    // тупое определение минимального размера
    OPTNs_GBox.Constraints.MinHeight:=OPTNs_bAdd.Height*6;
    PTTNs_GBox.Constraints.MinHeight:=OPTNs_GBox.Constraints.MinHeight;
    GBox_Panel.Constraints.MinWidth :=OPTNs_bAdd.Height*8;
end;

{%endregion}

{$region --- safeCall`s TCbSFP_SubScriber_editor methods ---------- /fold}
// не то чтоб я не доверяю ... но надо проверить и обезопаситься

const cPRMisNIL_megaFAIL='in0k Mega FAIL !!! '+LineEnding+'parameter is NULL'+LineEnding;
type  tPRMisNIL=class(Exception) end;

//------------------------------------------------------------------------------

function _safeCall__editor__getTitle_(const cFRM:TCbSFP_SubScriber_editor):string;
begin
    try // проверка моих косяков
        if not Assigned(cFRM) then raise tPRMisNIL.Create('_safeCall__editor__getTitle_ : cFRM');
        // ВНЕШНИЙ .. вызов
        result:=cFRM.GetTitle;
    except
        on E:tPRMisNIL do begin
            ShowMessage(cPRMisNIL_megaFAIL+e.Message);
        end;
        on E:Exception do begin
            result:=cFRM.ClassName;
            ShowMessage(cFRM.ClassName+'.GetTitle : ERROR'+LineEnding+E.Message);
        end;
    end;
end;

procedure _safeCall__editor__Settings_SAVE_(const cFRM:TCbSFP_SubScriber_editor; const CNFG:pointer);
begin
    try // проверка моих косяков
        if not Assigned(cFRM) then raise tPRMisNIL.Create('_safeCall__editor__Settings_SAVE_ : cFRM');
        if not Assigned(CNFG) then raise tPRMisNIL.Create('_safeCall__editor__Settings_SAVE_ : CNFG');
        // ВНЕШНИЙ .. вызов
        cFRM.Settings_SAVE(CNFG);
    except
        on E:tPRMisNIL do begin
            ShowMessage(cPRMisNIL_megaFAIL+e.Message);
        end;
        on E:Exception do begin
            ShowMessage(cFRM.ClassName+'.Settings_SAVE : ERROR'+LineEnding+E.Message);
        end;
    end;
end;

procedure _safeCall__editor__Settings_LOAD_(const cFRM:TCbSFP_SubScriber_editor; const CNFG:pointer);
begin
    try // проверка моих косяков
        if not Assigned(cFRM) then raise tPRMisNIL.Create('_safeCall__editor__Settings_LOAD_ : cFRM');
        if not Assigned(CNFG) then raise tPRMisNIL.Create('_safeCall__editor__Settings_LOAD_ : CNFG');
        // ВНЕШНИЙ .. вызов
        cFRM.Settings_LOAD(CNFG);
    except
        on E:tPRMisNIL do begin
            ShowMessage(cPRMisNIL_megaFAIL+e.Message);
        end;
        on E:Exception do begin
            ShowMessage(cFRM.ClassName+'.Settings_LOAD : ERROR'+LineEnding+E.Message);
        end;
    end;
end;

{$endregion}

{$region --- выход на CallCenter ---------------------------------- /fold}

procedure tCbSFP_ideCallEditor.TESTs_lbl1Resize(Sender: TObject);
begin
    with TESTs_lbl1 do begin
        if TESTs_lbl1.Width<=1 then Shape1.Hide
        else begin
            {todo: взять стандартные размеры}
            Shape1.SetBounds(Left-2,Top-1,Width+5,Height+2);
            Shape1.Show;
        end;
    end;
end;

procedure tCbSFP_ideCallEditor.OPTNs_lBoxDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
begin
  //
end;

procedure tCbSFP_ideCallEditor.Button1Click(Sender: TObject);
begin
    nodeEditor.DEBUG_Show;
end;

procedure tCbSFP_ideCallEditor._ideEditorNODE_CLR;
begin
    tCbSFP_ideEditorNODE(_ideEditorNODE_).FREE;
   _ideEditorNODE_:=nil;
end;

procedure tCbSFP_ideCallEditor._ideEditorNODE_SET;
begin
   _ideEditorNODE_:=CbSFP_ideCenter__EditorNODE(self);
    Assert(Assigned(_ideEditorNODE_),'CallCenterNodeForEDIT NOT found');
end;

function tCbSFP_ideCallEditor.nodeEditor:tCbSFP_ideEditorNODE;
begin
    if not Assigned(_ideEditorNODE_) then begin
       _ideEditorNODE_SET;
    end;
    result:=tCbSFP_ideEditorNODE(_ideEditorNODE_);
    if result=nil then ShowMessage('nodeEditor=nil');

end;

{$endregion}

procedure tCbSFP_ideCallEditor._testFileName_set(const value:string);
begin
    if _testFileName<>value then begin
        _testFileName:=value;
        _lBOXs_reSetITEMs;
    end;
   _TST__update;
end;

procedure tCbSFP_ideCallEditor._testFileName_ini;
begin
    {$ifDef ideLazExtMODE}
   _testFileName_set('dfgsdf'{_ideLazarus_ActivEditFileName});
    {$else}
   _testFileName_set(ParamStr(0));
    {$endIf}
end;

{$ifDef ideLazExtMODE}
function tCbSFP_ideCallEditor._ideLazarus_ActivEditFileName:string;
var tmp:TSourceEditorInterface;
begin
    result:='';
    tmp:=SourceEditorManagerIntf.ActiveEditor;
    if Assigned(tmp) then begin
        result:=tmp.FileName;
    end;
end;
{$endIf}

{%region --- основные контроля списков_ ... ----------------------- /fold}

procedure tCbSFP_ideCallEditor._OPTNs_lBox__onSelectionChange(Sender: TObject; User: boolean);
begin
    if User then begin
       _PTTNs_lBox__doUnLckSelectNull(_OPTNs_lBox__getOPTN(OPTNs_lBox.ItemIndex));
       _selected_SET_OPTNs(OPTNs_lBox.ItemIndex);
    end
    else begin
       _PTTNs_lBox__doUnLckSingleMode(_OPTNs_lBox__getOPTN(OPTNs_lBox.ItemIndex));
    end;
end;

procedure tCbSFP_ideCallEditor._OPTNs_lBox__onClickCheck(Sender:TObject);
begin
    with TCheckListBox(Sender) do begin
      if ItemIndex<>0 then begin
        if (_slctd_FROM_=cILECBSPiEOA_selected_OPT)and(_slctd_INDX_=ItemIndex) then begin
            Common_CHB.Checked:=Checked[ItemIndex];
        end
        else begin
            nodeEditor.itmOPTN_setUsed(_OPTNs_lBox__getOPTN(ItemIndex), Checked[ItemIndex]);
            OnSelectionChange(Sender,TRUE);
        end;
      end
      else Checked[0]:=TRUE;
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tCbSFP_ideCallEditor._OPTNs_lBox__doSelectConfigure(const CNFG:pointer);
var idx:integer;
    tmp:boolean;
begin
    OPTNs_lBox.Items.BeginUpdate;
    for idx:=0 to OPTNs_lBox.Count-1 do begin
        // по ходу нету там такой проверки
        tmp:=_OPTNs_lBox__getCNFG(idx)=CNFG;
        if tmp<>OPTNs_lBox.Selected[idx] then OPTNs_lBox.Selected[idx]:=tmp;
    end;
    OPTNs_lBox.Items.EndUpdate;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tCbSFP_ideCallEditor._OPTNs_lBox__getOPTN(const i:integer):pointer;
begin
    if (0<=i)and(i<OPTNs_lBox.Count) then result:=OPTNs_lBox.Items.Objects[i]
    else result:=nil;
end;

function tCbSFP_ideCallEditor._OPTNs_lBox__getCNFG(const i:integer):pointer;
begin
    result:=_OPTNs_lBox__getOPTN(i);
    if Assigned(result) then result:=nodeEditor.itmOPTN_getCNFG(result);
end;

function tCbSFP_ideCallEditor._OPTNs_lBox__fndOPTN(const OPTN:pCbSFP_OPTN):integer;
var idx:integer;
begin
    result:=-1;
    for idx:=0 to OPTNs_lBox.Count-1 do begin
        if _OPTNs_lBox__getOPTN(idx)=OPTN then begin
            result:=idx;
            BREAK;
        end;
    end;
end;

//------------------------------------------------------------------------------

procedure tCbSFP_ideCallEditor._OPTNs_bAdd__onChangeBounds(Sender:TObject);
begin
   _onSetup_gBox_setConstraints;
end;

//------------------------------------------------------------------------------

procedure tCbSFP_ideCallEditor._PTTNs_lBox__onSelectionChange(Sender: TObject; User: boolean);
begin
    if User then begin
        PTTNs_lBox.ItemEnabled[PTTNs_lBox.ItemIndex]:=true;
       _OPTNs_lBox__doSelectConfigure(_PTTNs_lBox__getCNFG(PTTNs_lBox.ItemIndex));
       _selected_SET_PTTNs(PTTNs_lBox.ItemIndex);
    end
    else begin
        {doNOFING}
    end;
end;

procedure tCbSFP_ideCallEditor._PTTNs_lBox__onClickCheck(Sender:TObject);
begin
    with TCheckListBox(Sender) do begin
        if (_slctd_FROM_=cILECBSPiEOA_selected_PTN)and(_slctd_INDX_=ItemIndex) then begin
            Common_CHB.Checked:=Checked[ItemIndex];
        end
        else begin
            nodeEditor.itmPTTN_setUsed(_PTTNs_lBox__getPTTN(ItemIndex), Checked[ItemIndex]);
            OnSelectionChange(Sender,TRUE);
        end;
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tCbSFP_ideCallEditor._PTTNs_lBox__doUnLckSingleMode(const OPTN:pCbSFP_OPTN);
var idx:integer;
    tmp:boolean;
begin
    PTTNs_lBox.Items.BeginUpdate;
    for idx:=0 to PTTNs_lBox.Count-1 do begin
        tmp:=_PTTNs_lBox__getOPTN(idx)=OPTN;
        if tmp<>PTTNs_lBox.ItemEnabled[idx] then PTTNs_lBox.ItemEnabled[idx]:=tmp;
    end;
    PTTNs_lBox.Items.EndUpdate;
end;

procedure tCbSFP_ideCallEditor._PTTNs_lBox__doUnLckSelectNull(const OPTN:pCbSFP_OPTN);
var idx:integer;
    tmp:boolean;
begin
    PTTNs_lBox.Items.BeginUpdate;
    for idx:=0 to PTTNs_lBox.Count-1 do begin
        tmp:=_PTTNs_lBox__getOPTN(idx)=OPTN;
        if tmp<>PTTNs_lBox.ItemEnabled[idx] then PTTNs_lBox.ItemEnabled[idx]:=tmp;
        if PTTNs_lBox.Selected[idx] then PTTNs_lBox.Selected[idx]:=false;
    end;
    PTTNs_lBox.Items.EndUpdate;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tCbSFP_ideCallEditor._PTTNs_lBox__getPTTN(const i:integer):pointer;
begin
    if (0<=i)and(i<PTTNs_lBox.Count) then result:=PTTNs_lBox.Items.Objects[i]
    else result:=nil;
end;

function tCbSFP_ideCallEditor._PTTNs_lBox__getOPTN(const i:integer):pointer;
begin
    result:=_PTTNs_lBox__getPTTN(i);
    if Assigned(result) then result:=nodeEditor.itmPTTN_getOPTN(result);
end;

function tCbSFP_ideCallEditor._PTTNs_lBox__getCNFG(const i:integer):pointer;
begin
    result:=_PTTNs_lBox__getPTTN(i);
    if Assigned(result) then result:=nodeEditor.itmPTTN_getCNFG(result);
end;

//------------------------------------------------------------------------------

function tCbSFP_ideCallEditor._OPTNs_lBox__clcCPTN(const itm:pCbSFP_OPTN; const cnt:integer):string;
begin
    result:=nodeEditor.itmOPTN_getName(itm);
    if cnt>0
    then result:=result+' ['+inttostr(cnt)+']';
    //---
    if (_testFileName<>'') then begin
        if (nodeEditor.itmOPTN_find(itm,_testFileName)=itm) then begin
            result:='*'+result;
        end;
    end;
end;

function tCbSFP_ideCallEditor._OPTNs_lBox__clcCPTN(const itm:pCbSFP_OPTN):string;
var cnt:integer;
begin
    cnt:=nodeEditor.lstPTTN_cntOPTN(itm);
    result:=_OPTNs_lBox__clcCPTN(itm,cnt);
end;

function tCbSFP_ideCallEditor._PTTNs_lBox__clcCPTN(const itm:pCbSFP_PTTN):string;
begin
    result:=nodeEditor.itmPTTN_getSeek(itm);
    //---
    if (_testFileName<>'') then begin
        if (nodeEditor.itmPTTN_find(itm,_testFileName)=itm) then begin
            result:='(*)->'+result;
        end;
        if (nodeEditor.itmPTTN_test(itm,_testFileName)) then begin
            result:=result+'<-[+]';
        end;
    end;
end;

//------------------------------------------------------------------------------

procedure tCbSFP_ideCallEditor._OPTNs_lBox__reSetITEM(const i:integer);
var itm:pointer;
    cnt:integer;
begin
    itm:=_OPTNs_lBox__getOPTN(i);
    if Assigned(itm) then begin
        cnt:=nodeEditor.lstPTTN_cntOPTN(itm);
        OPTNs_lBox.Items.Strings[i]:=_OPTNs_lBox__clcCPTN(itm,cnt);
        OPTNs_lBox.Checked      [i]:=(i=0) or nodeEditor.itmOPTN_getUsed(itm);
        OPTNs_lBox.ItemEnabled  [i]:=(i=0) or (0<cnt);
    end
    else begin
        OPTNs_lBox.Items.Strings[i]:='ndf';
        OPTNs_lBox.Checked      [i]:=false;
        OPTNs_lBox.ItemEnabled  [i]:=false;
    end;
end;

procedure tCbSFP_ideCallEditor._PTTNs_lBox__reSetITEM(const i:integer);
var itm:pointer;
begin
    itm:=PTTNs_lBox.Items.Objects[i];
    if Assigned(itm) then begin
        PTTNs_lBox.Items.Strings[i]:=_PTTNs_lBox__clcCPTN(itm);
        PTTNs_lBox.Checked      [i]:= nodeEditor.itmPTTN_getUsed(itm);
    end
    else begin
        PTTNs_lBox.Items.Strings[i]:='ndf';
        PTTNs_lBox.Checked      [i]:=false;
    end;
end;

procedure tCbSFP_ideCallEditor._lBOXs_reSetITEMs;
var i:integer;
begin
    for i:=0 to PTTNs_lBox.Count-1 do _PTTNs_lBox__reSetITEM(i);
    for i:=0 to OPTNs_lBox.Count-1 do _OPTNs_lBox__reSetITEM(i);
end;

{%endregion}

{%region --- общие контролы Common_.. ----------------------------- /fold}

{проверить создан ли уже подчиненный фрейм, и если нет то создать}
procedure tCbSFP_ideCallEditor._common_FRM__Tst2CRT;
begin {todo : отправить заявку на ФИКС?}
    // по идее это должно идти в self.Create или self.Setup, но в LazarusIDE
    // установка свойства self.Rec (необходимого МНЕ для создания вложенного
    // фрейма) происходит ПОСЛЕ self.Setup, что навероне не правельно.
    // На данный момент, вызов производим из ReadSettings.
    //------
    // детали см в IDEOptionsDlg.TIDEOptionsDialog.CreateEditors
    if not Assigned(_common_FRM_) then begin
       _common_FRM_:=nodeEditor.EDITtFRAME.Create(self);
        with _common_FRM_ do begin
            Parent:=Common_PNL;
            Align :=alClient;
        end;
    end;
end;

procedure tCbSFP_ideCallEditor._common_FRM__DESTROY;
begin
   _common_FRM_.FREE;
   _common_FRM_:=nil;
end;

//------------------------------------------------------------------------------

procedure tCbSFP_ideCallEditor._Common_CHB_asOPTN__onChange(Sender: TObject);
begin
    if (_slctd_FROM_=cILECBSPiEOA_selected_OPT)and(Assigned(_slctd_ITEM_)) then begin
        nodeEditor.itmOPTN_setUsed(_slctd_ITEM_,TCheckBox(Sender).Checked);
        // OPTNs_lBox.Checked[_slctd_INDX_]:=TCheckBox(Sender).Checked;
       _lBOXs_reSetITEMs;
    end;
end;

procedure tCbSFP_ideCallEditor._Common_CHB_asPTTN__onChange(Sender: TObject);
begin
    if (_slctd_FROM_=cILECBSPiEOA_selected_PTN)and(Assigned(_slctd_ITEM_)) then begin
        nodeEditor.itmPTTN_setUsed(_slctd_ITEM_,TCheckBox(Sender).Checked);
        // PTTNs_lBox.Checked[_slctd_INDX_]:=TCheckBox(Sender).Checked;
       _lBOXs_reSetITEMs;
    end;
end;

//------------------------------------------------------------------------------

procedure tCbSFP_ideCallEditor._Common_EDT_asOPTN__onChange(Sender: TObject);
var tmpNAME:string;
begin
    tmpNAME:= trim(tEdit(Sender).Text);
    if nodeEditor.lstOPTN_vldName(tmpNAME,_slctd_ITEM_) then begin
        nodeEditor.itmOPTN_setName(_slctd_ITEM_,tmpNAME);
        OPTNs_lBox.Items.Strings[_slctd_INDX_]:=_OPTNs_lBox__clcCPTN(_slctd_ITEM_);
        tEdit(Sender).Font.Color:=clDefault;
    end
    else begin
        tEdit(Sender).Font.Color:=clRED;
    end;
end;

procedure tCbSFP_ideCallEditor._Common_EDT_asOPTN__onEnter(Sender: TObject);
begin
    tEdit(Sender).OnChange:=@_Common_EDT_asOPTN__onChange;
end;

procedure tCbSFP_ideCallEditor._Common_EDT_asOPTN__onExit(Sender: TObject);
var tmpNAME:string;
begin
    tEdit(Sender).OnChange:=nil;
    //---
    tmpNAME:= trim(tEdit(Sender).Text);
    if not nodeEditor.lstOPTN_vldName(tmpNAME,_slctd_ITEM_) then begin
        tEdit(Sender).Text:=nodeEditor.itmOPTN_getName(_slctd_ITEM_);
        tEdit(Sender).Font.Color:=clDefault;
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tCbSFP_ideCallEditor._Common_EDT_asPTTN__onChange(Sender: TObject);
var tmpSEEK:string;
begin
    tmpSEEK:= trim(tEdit(Sender).Text);
    if nodeEditor.lstPTTN_vldSeek(tmpSEEK,_slctd_ITEM_) then begin
        nodeEditor.itmPTTN_setSeek(_slctd_ITEM_,tmpSEEK);
        PTTNs_lBox.Items.Strings[_slctd_INDX_]:=_PTTNs_lBox__clcCPTN(_slctd_ITEM_);
        tEdit(Sender).Font.Color:=clDefault;
    end
    else begin
        tEdit(Sender).Font.Color:=clRED;
    end;
   _TST__update;
end;

procedure tCbSFP_ideCallEditor._Common_EDT_asPTTN__onEnter(Sender: TObject);
begin
    tEdit(Sender).OnChange:=@_Common_EDT_asPTTN__onChange;
end;

procedure tCbSFP_ideCallEditor._Common_EDT_asPTTN__onExit(Sender: TObject);
var tmpSEEK:string;
begin
    tEdit(Sender).OnChange:=nil;
    //---
    tmpSEEK:= trim(tEdit(Sender).Text);
    if not nodeEditor.lstPTTN_vldSeek(tmpSEEK,_slctd_ITEM_) then begin
        tEdit(Sender).Text:=nodeEditor.itmPTTN_getSeek(_slctd_ITEM_);
        tEdit(Sender).Font.Color:=clDefault;
    end;
end;

//------------------------------------------------------------------------------

procedure tCbSFP_ideCallEditor._Common_OPT_asPTTN__onEnter(Sender: TObject);
begin
    TComboBox(Sender).OnChange:=@_Common_OPT_asPTTN__onChange;
end;

procedure tCbSFP_ideCallEditor._Common_OPT_asPTTN__onChange(Sender:TObject);
begin
    //-- изменяем СТАРЫЙ
    nodeEditor.itmPTTN_setOPTN(_slctd_ITEM_, pointer(Common_OPT.Items.Objects[Common_OPT.ItemIndex]));
   _PTTNs_lBox__onSelectionChange(PTTNs_lBox,TRUE);
    //--
   _lBOXs_reSetITEMs;
end;

procedure tCbSFP_ideCallEditor._Common_OPT_asPTTN__onExit(Sender: TObject);
begin
    TComboBox(Sender).OnChange:=nil;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tCbSFP_ideCallEditor._common_OPT_asPTTN__fillList;
var i:integer;
  tmp:pointer;
begin
    Common_OPT.Items.BeginUpdate;
        Common_OPT.Items.Clear;
        for i:=0 to OPTNs_lBox.Count-1 do begin
            tmp:=_OPTNs_lBox__getOPTN(i);
            if Assigned(tmp)
            then Common_OPT.Items.AddObject(nodeEditor.itmOPTN_getName(tmp),tObject(tmp));
        end;
    Common_OPT.Items.EndUpdate;
end;

function tCbSFP_ideCallEditor._common_OPT_asPTTN__findOPTN(const OPTN:pCbSFP_OPTN):integer;
var idx:integer;
begin
    result:=-1;
    for idx:=0 to Common_OPT.Items.Count-1 do begin
        if pointer(Common_OPT.Items.Objects[idx])=OPTN then begin
            result:=idx;
            BREAK;
        end;
    end;
end;

procedure tCbSFP_ideCallEditor._common_OPT_asPTTN__doSelect(const OPTN:pCbSFP_OPTN);
begin
    Common_OPT.ItemIndex:=_common_OPT_asPTTN__findOPTN(OPTN);
end;

//------------------------------------------------------------------------------

procedure tCbSFP_ideCallEditor._common__setFromOPTIONs;
begin
    if _slctd_FROM_<>cILECBSPiEOA_selected_OPT then begin
        Common_CPT.Caption:=' OPTION ';
        Common_OPT.Hide;
       _slctd_FROM_:=cILECBSPiEOA_selected_OPT;
        //---
        Common_CHB.OnChange:=@_Common_CHB_asOPTN__onChange;
        Common_EDT.OnEnter :=@_Common_EDT_asOPTN__onEnter;
        Common_EDT.OnChange:=nil; //< на всяк ПЖС
        Common_EDT.OnExit  :=@_Common_EDT_asOPTN__onExit;
        Common_OPT.OnEnter :=nil; //< на всяк ПЖС
        Common_OPT.OnChange:=nil; //< на всяк ПЖС
        Common_OPT.OnExit  :=nil; //< на всяк ПЖС
    end;
end;

procedure tCbSFP_ideCallEditor._common__setFromPATTERNs;
begin
    if _slctd_FROM_<>cILECBSPiEOA_selected_PTN then begin
        Common_CPT.Caption:=' PATTERN ';
       _common_OPT_asPTTN__fillList;
        Common_OPT.Show;
       _slctd_FROM_:=cILECBSPiEOA_selected_PTN;
        //---
        Common_CHB.OnChange:=@_Common_CHB_asPTTN__onChange;
        Common_EDT.OnEnter :=@_Common_EDT_asPTTN__onEnter;
        Common_EDT.OnChange:=nil; //< на всяк ПЖС
        Common_EDT.OnExit  :=@_Common_EDT_asPTTN__onExit;
        Common_OPT.OnEnter :=@_Common_OPT_asPTTN__onEnter;
        Common_OPT.OnChange:=nil; //< на всяк ПЖС
        Common_OPT.OnExit  :=@_Common_OPT_asPTTN__onExit;
    end;
end;

{%endregion}

{%region --- что КОНКРЕКТНО выделено _slctd_.. -------------------- /fold}

procedure tCbSFP_ideCallEditor._common_FRM__CNFG_SET(const CNFG:pointer);
begin
   _common_FRM__Tst2CRT;
    if Assigned(_slctd_CNFG_) then _safeCall__editor__Settings_SAVE_(_common_FRM_,_slctd_CNFG_);
    if _slctd_CNFG_<>CNFG then begin
       _slctd_CNFG_:=CNFG;
        //---
        if Assigned(_slctd_CNFG_) then _safeCall__editor__Settings_LOAD_(_common_FRM_,_slctd_CNFG_)
        else begin
           _common_FRM_.Enabled:=false;
        end;
    end;
end;

//------------------------------------------------------------------------------

procedure tCbSFP_ideCallEditor._selected_SET_OPTNs(const INDeX:integer);
begin
   _common__setFromOPTIONs;
    //---
   _slctd_INDX_:=INDeX;
   _slctd_ITEM_:=_OPTNs_lBox__getOPTN(INDeX);
    //---
    if _slctd_INDX_=0 then Common_CHB.OnChange:=nil
    else Common_CHB.OnChange:=@_Common_CHB_asOPTN__onChange;

    Common_CHB.Checked:=nodeEditor.itmOPTN_getUsed(_slctd_ITEM_);
    Common_EDT.Text   :=nodeEditor.itmOPTN_getName(_slctd_ITEM_);
    //---
    Common_CHB.Enabled:=_slctd_INDX_<>0;
    Common_EDT.Enabled:=_slctd_INDX_<>0;
    //---
   _common_FRM__CNFG_SET(nodeEditor.itmOPTN_getCNFG(_slctd_ITEM_));
end;

procedure tCbSFP_ideCallEditor._selected_SET_PTTNs(const INDeX:integer);
begin
   _common__setFromPATTERNs;
    //---
   _slctd_INDX_:= INDeX;
   _slctd_ITEM_:=_PTTNs_lBox__getPTTN(INDeX);
    //---
    Common_CHB.Checked:=nodeEditor.itmPTTN_getUsed(_slctd_ITEM_);
    Common_EDT.Text   :=nodeEditor.itmPTTN_getSeek(_slctd_ITEM_);
   _common_OPT_asPTTN__doSelect(nodeEditor.itmPTTN_getOPTN(_slctd_ITEM_));
   _TST__update;
    //---
    Common_CHB.Enabled:=TRUE;
    Common_EDT.Enabled:=TRUE;
    //---
   _common_FRM__CNFG_SET(nodeEditor.itmPTTN_getCNFG(_slctd_ITEM_));
end;

//------------------------------------------------------------------------------

procedure tCbSFP_ideCallEditor._doSelected_DEFAULT_ITM;
begin
    if OPTNs_lBox.Count>0 then begin
        OPTNs_lBox.ItemIndex:=cILECBSPiEOA_OPTNs_DefIDX;
       _OPTNs_lBox__onSelectionChange(OPTNs_lBox,TRUE);
    end;
    if self.Focused then OPTNs_lBox.SetFocus;
end;

{%endregion}

{%region --- события tActions .. ---------------------------------- /fold}

procedure tCbSFP_ideCallEditor._aOPTN_aAdd_onExecute(Sender: TObject);
var tmp:pCbSFP_OPTN;
    idx:integer;
begin
    //--- добавляем и "копируем" настройки из текущей
    tmp:=nodeEditor.lstOPTN_addItem;
    if Assigned(_slctd_CNFG_) then
   _safeCall__editor__Settings_SAVE_(_common_FRM_,nodeEditor.itmOPTN_getCNFG(tmp));
    //--- вставляем в контрол
    idx:=OPTNs_lBox.Items.AddObject('',tObject(tmp));
   _OPTNs_lBox__reSetITEM(idx);
    OPTNs_lBox.ItemIndex:=idx;
   _selected_SET_OPTNs(OPTNs_lBox.ItemIndex);
    OPTNs_lBox.SetFocus;
end;

procedure tCbSFP_ideCallEditor._aOPTN_aAdd_onUpdate(Sender: TObject);
begin
    tAction(Sender).Enabled:=_slctd_FROM_ in [cILECBSPiEOA_selected_OPT,cILECBSPiEOA_selected_PTN];;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tCbSFP_ideCallEditor._aOPTN_aDEL_onUpdate(Sender: TObject);
begin
    tAction(Sender).Enabled:=(_slctd_FROM_=cILECBSPiEOA_selected_OPT)and
                             (0<=OPTNs_lBox.ItemIndex)and
                             (OPTNs_lBox.ItemIndex<OPTNs_lBox.Count)and
                             (OPTNs_lBox.ItemIndex<>cILECBSPiEOA_OPTNs_DefIDX)and
                             (0=nodeEditor.lstPTTN_cntOPTN(_OPTNs_lBox__getOPTN(OPTNs_lBox.ItemIndex)))
end;

procedure tCbSFP_ideCallEditor._aOPTN_aDEL_onExecute(Sender: TObject);
var tmp:pCbSFP_OPTN;
    idx:integer;
begin
    //--- вырезаем из контрола
    idx:=OPTNs_lBox.ItemIndex;
    tmp:=_OPTNs_lBox__getOPTN(idx);
    OPTNs_lBox.Items.Objects[idx]:=nil;
    OPTNs_lBox.Items.Delete(idx);
    //--- вырезаем из списка
    nodeEditor.lstOPTN_delItem(tmp);
    //--- выделяем, устанавливаем фокус
    if OPTNs_lBox.Count<=idx then idx:=OPTNs_lBox.Count-1;
    OPTNs_lBox.ItemIndex:=idx;
   _OPTNs_lBox__onSelectionChange(OPTNs_lBox,TRUE);
    OPTNs_lBox.SetFocus;
end;

//------------------------------------------------------------------------------

procedure tCbSFP_ideCallEditor._aPTTN_aAdd_onUpdate(Sender: TObject);
begin
    tAction(Sender).Enabled:=_slctd_FROM_ in [cILECBSPiEOA_selected_OPT,cILECBSPiEOA_selected_PTN];
end;

procedure tCbSFP_ideCallEditor._aPTTN_aAdd_onExecute(Sender: TObject);
var tmp:pCbSFP_PTTN;
    idx:integer;
begin
    //--- создаем в зависимости от того где мы стоим
    case _slctd_FROM_ of
        cILECBSPiEOA_selected_OPT:begin
            tmp:=nodeEditor.lstPTTN_addFromOPTN(_slctd_ITEM_);
            idx:=_slctd_INDX_;
        end;
        cILECBSPiEOA_selected_PTN:begin
            tmp:=nodeEditor.lstPTTN_addFromPTTN(_slctd_ITEM_);
            idx:=_OPTNs_lBox__fndOPTN(nodeEditor.itmPTTN_getOPTN(_slctd_ITEM_));
        end;
    end;
    //--- отразим изменения в целевой
   _OPTNs_lBox__reSetITEM(idx); //< у него теперь изменится
    //--- добавляем в список, выделяем, устанавливаем фокус
    if PTTNs_lBox.SelCount=0 //< выбираем КУДА именно вставлять
    then idx:=PTTNs_lBox.Count        //< ничего не выбрано => тупо в конец
    else idx:=PTTNs_lBox.ItemIndex+1; //< следующим после выделенного
    PTTNs_lBox.Items.InsertObject(idx,'',tObject(tmp));
   _PTTNs_lBox__reSetITEM(idx);
    PTTNs_lBox.ItemIndex:=idx;
   _PTTNs_lBox__onSelectionChange(PTTNs_lBox,TRUE);
    PTTNs_lBox.SetFocus;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tCbSFP_ideCallEditor._aPTTN_aDEL_onUpdate(Sender: TObject);
begin
   tAction(Sender).Enabled:=(_slctd_FROM_=cILECBSPiEOA_selected_PTN)and
            (0<=PTTNs_lBox.ItemIndex)and(PTTNs_lBox.ItemIndex<PTTNs_lBox.Count);
end;

procedure tCbSFP_ideCallEditor._aPTTN_aDEL_onExecute(Sender: TObject);
var tmp:pCbSFP_PTTN;
    idx:integer;
begin
    //--- вырезаем из контрола
    idx:=PTTNs_lBox.ItemIndex;
    tmp:=_PTTNs_lBox__getPTTN(idx);
    PTTNs_lBox.Items.Objects[idx]:=nil;
    PTTNs_lBox.Items.Delete(idx);
    //--- вырезаем из списка
    nodeEditor.lstPTTN_delItem(tmp);
    //--- отразим изменения в целевой
    //  _OPTNs_lBox__reSetITEM(_OPTNs_lBox__fndOPTN(nodeEditor.itmPTTN_getOPTN(tmp))); //< у него теперь изменится
   _lBOXs_reSetITEMs;
    //--- выделяем, устанавливаем фокус
    if PTTNs_lBox.Count=0 then begin
       _OPTNs_lBox__onSelectionChange(OPTNs_lBox,TRUE);
        OPTNs_lBox.SetFocus
    end
    else begin
        if PTTNs_lBox.Count<=idx then idx:=PTTNs_lBox.Count-1;
        PTTNs_lBox.ItemIndex:=idx;
       _PTTNs_lBox__onSelectionChange(PTTNs_lBox,TRUE);
        PTTNs_lBox.SetFocus;
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tCbSFP_ideCallEditor._aPTTN_mwUP_onUpdate(Sender: TObject);
begin
    tAction(Sender).Enabled:=(_slctd_FROM_=cILECBSPiEOA_selected_PTN)and
             (0<PTTNs_lBox.ItemIndex)and(PTTNs_lBox.ItemIndex<PTTNs_lBox.Count);
end;

procedure tCbSFP_ideCallEditor._aPTTN_mwUP_onExecute(Sender: TObject);
var i:integer;
begin
    i:=PTTNs_lBox.ItemIndex-1;
    PTTNs_lBox.Items.Move(PTTNs_lBox.ItemIndex,i);
    PTTNs_lBox.Selected[i]:=TRUE;
    PTTNs_lBox.SetFocus;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tCbSFP_ideCallEditor._aPTTN_mwDW_onUpdate(Sender: TObject);
begin
    tAction(Sender).Enabled:=(_slctd_FROM_=cILECBSPiEOA_selected_PTN)and
          (0<=PTTNs_lBox.ItemIndex)and(PTTNs_lBox.ItemIndex<PTTNs_lBox.Count-1);
end;

procedure tCbSFP_ideCallEditor._aPTTN_mwDW_onExecute(Sender: TObject);
var i:integer;
begin
    i:=PTTNs_lBox.ItemIndex+1;
    PTTNs_lBox.Items.Move(PTTNs_lBox.ItemIndex,i);
    PTTNs_lBox.Selected[i]:=TRUE;
    PTTNs_lBox.SetFocus;
end;

//------------------------------------------------------------------------------

procedure tCbSFP_ideCallEditor._aCNFG__DEF_onExecute(Sender:TObject);
begin
    if Assigned(_slctd_CNFG_) then begin //< на всяк ПЖС. (_aCNFG__DEF_onUpdate)
       _safeCall__editor__Settings_SAVE_(_common_FRM_,_slctd_CNFG_);
        nodeEditor.itmCNFG_toDEF(_slctd_CNFG_);
       _safeCall__editor__Settings_LOAD_(_common_FRM_,_slctd_CNFG_);
    end;
end;

procedure tCbSFP_ideCallEditor._aCNFG__DEF_onUpdate(Sender:TObject);
begin
    tAction(Sender).Enabled:=Assigned(_slctd_CNFG_);
end;

{%endregion}

{%region --- сохранение и загрузка .. ----------------------------- /fold}

procedure tCbSFP_ideCallEditor._settingsLOAD__OPTNs_lBox__Load;
var tmp:pCbSFP_OPTN;
    idx:integer;
begin
    OPTNs_lBox.Items.BeginUpdate;
        OPTNs_lBox.Clear;
        tmp:=nodeEditor.lstOPTN_getFirst;
        while tmp<>nil do begin
            idx:=OPTNs_lBox.Items.AddObject('',tObject(tmp));
           _OPTNs_lBox__reSetITEM(idx);
            tmp:=nodeEditor.lstOPTN_getNEXT(tmp);
        end;
    OPTNs_lBox.Items.EndUpdate;
end;

procedure tCbSFP_ideCallEditor._settingsLOAD__PTTNs_lBox__Load;
var tmp:pCbSFP_PTTN;
    idx:integer;
begin
    PTTNs_lBox.Items.BeginUpdate;
        PTTNs_lBox.Clear;
        tmp:=nodeEditor.lstPTTN_getFirst;
        while tmp<>nil do begin
            idx:=PTTNs_lBox.Items.AddObject('',tObject(tmp));
           _PTTNs_lBox__reSetITEM(idx);
            tmp:=nodeEditor.lstPTTN_getNEXT(tmp);
        end;
    PTTNs_lBox.Items.EndUpdate;
end;

procedure tCbSFP_ideCallEditor._settingsLOAD_;
begin
    // готовим к редактированию
    nodeEditor.EDIT_Start;
    // загружаем данные
   _settingsLOAD__OPTNs_lBox__Load;
   _settingsLOAD__PTTNs_lBox__Load;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tCbSFP_ideCallEditor._settingsSAVE__OPTNs_lBox__Save;
begin
    {do nofing}
end;

procedure tCbSFP_ideCallEditor._settingsSAVE__PTTNs_lBox__Save;
var tmp:pCbSFP_PTTN;
    idx:integer;
begin //< сохранения ПОРЯДКА следования
    if PTTNs_lBox.Count>0 then begin
        tmp:=_PTTNs_lBox__getPTTN(0);
        nodeEditor.lstPTTN_setFirst(tmp);
        nodeEditor.lstPTTN_setNEXT(tmp,nil);
        for idx:=1 to PTTNs_lBox.Count-1 do begin
            nodeEditor.lstPTTN_setNEXT(tmp,_PTTNs_lBox__getPTTN(idx));
            tmp:=_PTTNs_lBox__getPTTN(idx);
            nodeEditor.lstPTTN_setNEXT(tmp,nil);
        end;
    end;
end;

procedure tCbSFP_ideCallEditor._settingsSAVE_;
begin
    // сохраним состояние текущего пользовательского фрейма
   _common_FRM__CNFG_SET(_slctd_CNFG_);
    // сохраняем ВСЕ данные (в основном это ПОРЯДОК)
   _settingsSAVE__OPTNs_lBox__Save;
   _settingsSAVE__PTTNs_lBox__Save;
    //
    nodeEditor.EDIT_doEnd(TRUE); //<да, ЗАПИСЫВАЕМ изменения
end;

{%endregion}

{%region ---  .. --------------------------- /fold}

procedure tCbSFP_ideCallEditor._TST_SetLBLs(const t0,t1,t2:string);
begin
    TESTs_lbl0.Caption:=t0;
    TESTs_lbl1.Caption:=t1;
    TESTs_lbl2.Caption:=t2;
end;

procedure tCbSFP_ideCallEditor._TST_SetLBLs(const tst_TEXT:string);
begin
   _TST_SetLBLs(tst_TEXT,'','');
end;

procedure tCbSFP_ideCallEditor._TST_re_CALC(const SRC,PTTN:string);
var mathPos,mathLen:PtrInt;
    t0,t1,t2:string;
begin
    if (SRC<>'')and(PTTN<>'')AND(nodeEditor.FindPttnInSource(SRC,PTTN, mathPos,mathLen))
    then begin
        t0:=Copy(SRC,0,mathPos-1);
        t1:=Copy(SRC,mathPos,mathLen);
        t2:=Copy(SRC,mathPos+mathLen,Length(src)-(mathPos+mathLen)+1);
       _TST_SetLBLs(t0,t1,t2);
    end
    else begin
       _TST_SetLBLs(SRC);
    end;
end;

procedure tCbSFP_ideCallEditor._TST__update;
begin
    if _slctd_FROM_<>cILECBSPiEOA_selected_PTN then begin
        _TST_re_CALC(_testFileName,'')
    end
    else begin
        _TST_re_CALC(_testFileName,nodeEditor.itmPTTN_getSeek(_slctd_ITEM_));
    end;
end;

{%endregion}


//------------------------------------------------------------------------------

function tCbSFP_ideCallEditor.GetTitle:String;
begin
   _common_FRM__Tst2CRT;
    if Assigned(_common_FRM_) then result:=_safeCall__editor__getTitle_(_common_FRM_)
    else result:=self.Name;
end;

class function tCbSFP_ideCallEditor.SupportedOptionsClass:TAbstractIDEOptionsClass;
begin
    {$ifDef ideLazExtMODE}
    result:=tCbSFP_ideGeneral_Config;
    {$else}
        {$ifDef uiDevelopPRJ}
    result:=nil;
        {$endif}
    {$endIf}
end;

//------------------------------------------------------------------------------

procedure tCbSFP_ideCallEditor.Setup(ADialog:TAbstractOptionsEditorDialog);
begin



    ShowMessage('SETUP');
    try
    nodeEditor.DEBUG_MSG('M','Setup ..');
    finally
    end;
    {$ifDef CbSFP_log_ON}
   _EventLog_.Debug('Setup');
    {$endIf}
    try
    //nodeEditor.DEBUG_MSG('M','Setup 0k');
    finally
    end;
end;

procedure tCbSFP_ideCallEditor.ReadSettings(AOptions:TAbstractIDEOptions);
{$ifDef ideLazExtMODE}
var v1,v2:integer;
{$endIf}
begin
    nodeEditor.DEBUG_MSG('M','ReadSettings ..');
    {$ifDef CbSFP_log_ON}
   _EventLog_.Debug('ReadSettings');
    {$endIf}
    {$ifDef ideLazExtMODE}
    tCbSFP_ideGeneral_Config(AOptions).SubScriber_loadEditorVALUEs(nodeEditor.Identifier,V1,V2);
   _frame_setSizes(V1,V2);
    {$else}
        {$ifDef uiDevelopPRJ}
       _frame_setSizes(0,0);
        {$endif}
    {$endIf}
   _common_FRM__Tst2CRT; //< НЕ хорошо (см. реализацию)
   _settingsLOAD_;
   _doSelected_DEFAULT_ITM;
    nodeEditor.DEBUG_MSG('M','ReadSettings 0k');
end;

procedure tCbSFP_ideCallEditor.WriteSettings(AOptions:TAbstractIDEOptions);
{$ifDef ideLazExtMODE}
var v1,v2:integer;
{$endIf}
begin
    nodeEditor.DEBUG_MSG('M','WriteSettings ..');
    {$ifDef CbSFP_log_ON}
   _EventLog_.Debug('WriteSettings');
    {$endIf}
    {$ifDef ideLazExtMODE}
   _frame_getSizes(V1,V2);
    with tCbSFP_ideGeneral_Config(AOptions) do begin
        SubScriber_saveEditorVALUEs(nodeEditor.Identifier,V1,V2);
    end;
    {$endIf}
   _settingsSAVE_;
   _settingsLOAD_;
   _doSelected_DEFAULT_ITM;
    nodeEditor.DEBUG_MSG('M','WriteSettings 0k');
end;

procedure tCbSFP_ideCallEditor.RestoreSettings({%H-}AOptions:TAbstractIDEOptions);
begin
    nodeEditor.DEBUG_MSG('M','RestoreSettings ..');
    {$ifDef CbSFP_log_ON}
   _EventLog_.Debug('RestoreSettings');
    {$endIf}
    nodeEditor.EDIT_doEnd(FALSE); //<НЕТ, ОТМЕНЯЕМ все изменения
   _settingsLOAD_;
   _doSelected_DEFAULT_ITM;
    nodeEditor.DEBUG_MSG('M','RestoreSettings 0k');
end;

end.

