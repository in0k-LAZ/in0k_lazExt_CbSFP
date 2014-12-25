unit uiGeneralWND;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  CbSFP_ideGENERAL_editor, CbSFP_ideGENERAL_config;

type

  { TGnrlWND }

  TGnrlWND = class(TForm)
    CbSFP_ideGeneral_Editor1: TCbSFP_ideGeneral_Editor;
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  GnrlWND: TGnrlWND;

implementation

{$R *.lfm}

{ TGnrlWND }

procedure TGnrlWND.FormShow(Sender: TObject);
begin
    //Caption:=CbSFP_ideCallEditor1.GetTitle;
    // эмулирует поведение IDEOptionsDlg.TIDEOptionsDialog.CreateEditors
    // ... чето-делает
    CbSFP_ideGeneral_Editor1.Setup(nil);
    // ... чето-делает
    CbSFP_ideGeneral_Editor1.ReadSettings(CbSFP_ideGeneral_Config__GET);
end;

end.

