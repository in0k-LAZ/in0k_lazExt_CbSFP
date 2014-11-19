unit uiDevelopWND;

//----------------------\\-----------------------------------------------------=
//  ╔═╗┌┐ ╔═╗╔═╗╔═╗      \\  Configuration by Source File Path                 =
//  ║  ├┴┐╚═╗╠╣ ╠═╝      //  Конфигурация по пути исходного файла              =
//  ╚═╝└─┘╚═╝╚  ╩ v0.9  //   [uiDevelopWND]                                    =
//---------------------//------------------------------------------------------=
// окошко для эмулирования поведения IDEOptionsDlg.TIDEOptionsDialog
//------------------------------------------------------------------------------

{$mode objfpc}{$H+}

interface

uses Forms, Dialogs, ExtCtrls, StdCtrls,
  //--- что тестируем
  CbSFP_ideCenter, CbSFP_ideEditor,
  //--- чем тестируем
  CbSFP_DemoSubScriber_HNDL, //< тестовый Обработчик
  CbSFP_DemoSubScriber_EDTR; //< тестовый Редактор

type

  TmainWND = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CbSFP_ideCallEditor1: TCbSFP_ideCallEditor;
    Panel1: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  end;

var mainWND: TmainWND;

implementation

{$R *.lfm}

procedure TmainWND.FormCreate(Sender: TObject);
begin
    // регистрируем ЕДИНСТВЕННОГО абонента в системе
    CbSFP_ideCenter__SubScriberREGISTER(tCbSFP_DemoSubScriber_HNDL,TCbSFP_DemoSubScriber_EDTR);
end;

//------------------------------------------------------------------------------

procedure TmainWND.FormShow(Sender: TObject);
begin
    Caption:=CbSFP_ideCallEditor1.GetTitle;
    // эмулирует поведение IDEOptionsDlg.TIDEOptionsDialog.CreateEditors
    // ... чето-делает
    CbSFP_ideCallEditor1.Setup(nil);
    // ... чето-делает
    CbSFP_ideCallEditor1.ReadSettings(nil);
end;

//------------------------------------------------------------------------------

procedure TmainWND.Button1Click(Sender:TObject);
begin
    CbSFP_ideCallEditor1.WriteSettings(nil);
    Dialogs.ShowMessage('Write Settings END!');
end;

procedure TmainWND.Button2Click(Sender:TObject);
begin
    CbSFP_ideCallEditor1.RestoreSettings(nil);
    Dialogs.ShowMessage('Restore Settings END!');
end;

end.

