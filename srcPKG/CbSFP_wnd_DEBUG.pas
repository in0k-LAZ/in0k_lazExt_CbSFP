unit CbSFP_wnd_DEBUG;

{$mode objfpc}{$H+}

interface

uses CbSFP_SubScriber,
    Classes, SysUtils, Forms, StdCtrls, ActnList;

type

  { TCbSFP_wndDEBUG }

  TCbSFP_wndDEBUG = class(TForm)
    a_CLEAR: TAction;
    ActionList1: TActionList;
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    procedure a_CLEARExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
   _subScriber_:tCbSFP_SubScriber;
  public
    constructor Create(subScriber:tCbSFP_SubScriber);
  public
    procedure message(const mText:string);
  end;

implementation
uses CbSFP_ideCenter;

{$R *.lfm}

constructor TCbSFP_wndDEBUG.Create(subScriber:tCbSFP_SubScriber);
begin
    inherited Create(nil);
    Memo1.Clear;
   _subScriber_:=subScriber;
end;

//------------------------------------------------------------------------------

procedure TCbSFP_wndDEBUG.FormShow(Sender: TObject);
begin
    if Assigned(_subScriber_) then begin
        caption:='[DEBUGing] '+CbSFP_ideCenter_SubScriber_INDF(_subScriber_);
    end;
end;

procedure TCbSFP_wndDEBUG.FormClose(Sender:TObject; var CloseAction:TCloseAction);
begin
    CbSFP_ideCenter_DEBUG_onClose(_subScriber_);
    CloseAction:=caFree;
end;

//------------------------------------------------------------------------------

procedure TCbSFP_wndDEBUG.message(const mText:string);
begin
    memo1.Lines.Insert(0,TimeToStr(now)+' '+mText);
    memo1.SelStart:=0;
    memo1.SelLength:=0;
end;

//------------------------------------------------------------------------------

procedure TCbSFP_wndDEBUG.a_CLEARExecute(Sender: TObject);
begin
    Memo1.Clear;
end;

end.

