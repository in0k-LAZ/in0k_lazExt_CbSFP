unit CbSFP_ideGENERAL;

//----------------------\\-----------------------------------------------------=
//  ╔═╗┌┐ ╔═╗╔═╗╔═╗      \\  Configuration by Source File Path                 =
//  ║  ├┴┐╚═╗╠╣ ╠═╝      //  Конфигурация по пути исходного файла              =
//  ╚═╝└─┘╚═╝╚  ╩ v0.9  //   [ideGENERAL]                                      =
//---------------------//------------------------------------------------------=
// реализация ОСНОВНОГО пукта Меню
//------------------------------------------------------------------------------

{$mode objfpc}{$H+}

interface

uses IDEOptionsIntf, LazIDEIntf, LazFileUtils, LCLIntf,


    //in0k_LazExt_CBSP__General_Options,
  Classes, StdCtrls, EditBtn, Buttons
  {$ifNDef uiDevelopPRJ}
  {$else}
    sysutils
  {$endIf};


const

  cIn0k_LazExt_CbSFP__IdeOPTIONs__GroupGeneral='Config by SRC file path';
  cIn0k_LazExt_CbSFP__IdeOPTIONs__Node_General='General';
  cIn0k_LazExt_CbSFP__Config_Name             ='in0k_LazExt_CbSFP';
  cIn0k_LazExt_CbSFP__def_Enabled             = true;



type

 //tCbSFP_ideCallEditor
 //tCbSFP_ideCallCenter
 //tCbSFP_GeneralEditor
 //tCbSFP_GeneralConfig


 tIn0kLE_CBSP__General_Options=class(TAbstractIDEEnvironmentOptions)
  protected
   _mustSAVE:boolean;
  protected
   _enabled:boolean;
   _CNFsDIR:string;
    procedure _set_enabled(const value:boolean);
    procedure _set_CNFsDIR(const value:string);
  protected
    procedure _Init;
    procedure _Save;
    procedure _Load;
  public
    function _get_configFileName:string;
  public
    constructor Create;
    destructor Destroy; override;
  public
    class function GetGroupCaption: string;          override;
    class function GetInstance: TAbstractIDEOptions; override;
  public
    procedure LOAD;
    procedure SAVE;
  public
    property enabled:boolean read _enabled write _set_enabled;
    property CNFsDIR:string  read _CNFsDIR write _set_CNFsDIR;
  end;

 { Tin0kLE_CBSP_ideEDTR__General }

 Tin0kLE_CBSP_ideEDTR__General=class(TAbstractIDEOptionsEditor)
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
    procedure Setup(ADialog:TAbstractOptionsEditorDialog); override;
    procedure ReadSettings(AOptions:TAbstractIDEOptions);  override;
    procedure WriteSettings(AOptions:TAbstractIDEOptions); override;
  end;


function CbSFP_ideGENERAL__ConfigRootPath:string;

implementation

//uses CbSFP__Intf_1;


function CbSFP_ideGENERAL__ConfigFileName:string;
begin
   result:=LazarusIDE.GetPrimaryConfigPath;
   result:=AppendPathDelim(result)+cIn0k_LazExt_CbSFP__Config_Name;
end;

function CbSFP_ideGENERAL__ConfigRootPath:string;
begin
    result:=AppendPathDelim(CbSFP_ideGENERAL__ConfigFileName);
end;

{function _get_PrimaryConfigPath:string;
begin
    {$ifNDef uiDevelopPRJ}
    result:=LazarusIDE.GetPrimaryConfigPath;
    {$else}
    result:={CleanAndExpandDirectory}(ExtractFileDir(ParamStr(0)));
    {$endIf}
end; }



{$R *.lfm}

procedure Tin0kLE_CBSP_ideEDTR__General.SpeedButton1Click(Sender: TObject);
begin
   OpenDocument(Edit1.Text)
end;

constructor Tin0kLE_CBSP_ideEDTR__General.Create(TheOwner:TComponent);
begin
    inherited;
    SpeedButton1.LoadGlyphFromLazarusResource('laz_open');
end;

destructor Tin0kLE_CBSP_ideEDTR__General.Destroy;
begin
    inherited;
end;

//------------------------------------------------------------------------------

function Tin0kLE_CBSP_ideEDTR__General.GetTitle:String;
begin
    result:=cIn0k_LazExt_CbSFP__IdeOPTIONs__Node_General;
end;

class function Tin0kLE_CBSP_ideEDTR__General.SupportedOptionsClass:TAbstractIDEOptionsClass;
begin
    result:=TAbstractIDEOptions;
end;

//------------------------------------------------------------------------------

procedure Tin0kLE_CBSP_ideEDTR__General.Setup(ADialog:TAbstractOptionsEditorDialog);
begin
    memo1.Append('Setup');
end;

procedure Tin0kLE_CBSP_ideEDTR__General.ReadSettings(AOptions:TAbstractIDEOptions);
begin
    memo1.Append('ReadSettings');
    if AOptions is tIn0kLE_CBSP__General_Options then
        with tIn0kLE_CBSP__General_Options(AOptions) do begin
            LOAD;
            //---
            CheckBox1.Checked:=enabled;
            Edit1.Text:=CNFsDIR;
        end;
end;

procedure Tin0kLE_CBSP_ideEDTR__General.WriteSettings(AOptions:TAbstractIDEOptions);
begin
    memo1.Append('WriteSettings');
   { if AOptions is tIn0kLE_CBSP__General_Options then
        with tIn0kLE_CBSP__General_Options(AOptions) do begin
            enabled:=CheckBox1.Checked;
            CNFsDIR:=DirectoryEdit1.Directory;
            //---
            SAVE;
        end; }
end;


const

  cCBSP__pathDELIM='/';
  cCBSP__General_Options__enabled='enabled';
  cCBSP__General_Options__CNFsDIR='CNFsDIR';


var _CBSP_GnrlOtns_:tIn0kLE_CBSP__General_Options=nil;

function _Get_IDEOptionsGRP_: tIn0kLE_CBSP__General_Options;
begin
    if not Assigned(_CBSP_GnrlOtns_) then begin
       _CBSP_GnrlOtns_:=tIn0kLE_CBSP__General_Options.Create;
    end;
    result:=_CBSP_GnrlOtns_;
end;

//------------------------------------------------------------------------------

constructor tIn0kLE_CBSP__General_Options.Create;
begin
    inherited;
   _Init;
   _Load;
end;

destructor tIn0kLE_CBSP__General_Options.Destroy;
begin
   _CBSP_GnrlOtns_:=NIL;
    inherited;
end;

//------------------------------------------------------------------------------

class function tIn0kLE_CBSP__General_Options.GetGroupCaption:string;
begin
    result:=cIn0k_LazExt_CbSFP__IdeOPTIONs__GroupGeneral;
end;

class function tIn0kLE_CBSP__General_Options.GetInstance:TAbstractIDEOptions;
begin
    result:=_Get_IDEOptionsGRP_;
end;

//------------------------------------------------------------------------------

function tIn0kLE_CBSP__General_Options._get_configFileName:string;
begin
    result:=CbSFP_ideGENERAL__ConfigFileName;
end;

//------------------------------------------------------------------------------

procedure tIn0kLE_CBSP__General_Options._Init;
begin
   _enabled:=cIn0k_LazExt_CbSFP__def_Enabled;
   _CNFsDIR:=CbSFP_ideGENERAL__ConfigRootPath;
end;

procedure tIn0kLE_CBSP__General_Options._Save;
//var Config:TConfigStorage;
begin
 {   Config:=GetIDEConfigStorage(_get_configFileName,false);
    try if Assigned(Config) then begin
            Config.SetDeleteValue(cCBSP__General_Options__enabled,_enabled,cIn0k_LazExt_CBSP_def_Enabled);
            Config.SetDeleteValue(cCBSP__General_Options__CNFsDIR,_CNFsDIR,_get_defaultCNFsDIR);
        end;
       _mustSAVE:=false;
    finally
        Config.Free;
    end; }
end;

procedure tIn0kLE_CBSP__General_Options._Load;
//var Config:TConfigStorage;
begin
  {  Config:=GetIDEConfigStorage(_get_configFileName,true);
    try if Assigned(Config) then begin
           _enabled:=Config.GetValue(cCBSP__General_Options__enabled,cIn0k_LazExt_CBSP_def_Enabled);
           _CNFsDIR:=Config.GetValue(cCBSP__General_Options__CNFsDIR,_get_defaultCNFsDIR);
        end;
       _mustSAVE:=false;
    finally
       Config.Free;
    end;}
end;

//------------------------------------------------------------------------------

procedure tIn0kLE_CBSP__General_Options.LOAD;
begin
    //---
end;

procedure tIn0kLE_CBSP__General_Options.SAVE;
begin
    if _mustSAVE then _Save;
end;

//------------------------------------------------------------------------------

procedure tIn0kLE_CBSP__General_Options._set_enabled(const value:boolean);
begin
    if _enabled<>value then begin
       _enabled:=value;
       _mustSAVE:=TRUE;
    end;
end;

procedure tIn0kLE_CBSP__General_Options._set_CNFsDIR(const value:string);
begin
    if _CNFsDIR<>value then begin
       _CNFsDIR:=value;
       _mustSAVE:=TRUE;
    end;
end;

initialization
   _CBSP_GnrlOtns_:=nil;

finalization
    if Assigned(_CBSP_GnrlOtns_) then begin
       _CBSP_GnrlOtns_.Free;
       _CBSP_GnrlOtns_:=nil;
    end;
end.

