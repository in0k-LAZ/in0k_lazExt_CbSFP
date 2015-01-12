unit CbSFP_wnd_DEBUG;

{$mode objfpc}{$H+}

interface

uses CbSFP_SubScriber,
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TCbSFP_wndDEBUG }

  TCbSFP_wndDEBUG = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
   _subScriber_:tCbSFP_SubScriber;
  public
    constructor Create(subScriber:tCbSFP_SubScriber);
  public
    procedure message(const mText:string);
    //procedure message(const mType,mText:string);
  end;

implementation
uses CbSFP_ideCenter;

{$R *.lfm}

procedure TCbSFP_wndDEBUG.FormClose(Sender:TObject; var CloseAction:TCloseAction);
begin
    CbSFP_ideCenter_DEBUG_outGoing(_subScriber_);
    CloseAction:=caFree;
end;

procedure TCbSFP_wndDEBUG.FormShow(Sender: TObject);
begin
    if Assigned(_subScriber_) then begin
        caption:=CbSFP_ideCenter_SubScriber_INDF(_subScriber_)+' [DEBUGing]'
    end;
end;

constructor TCbSFP_wndDEBUG.Create(subScriber:tCbSFP_SubScriber);
begin
    inherited Create(nil);
   _subScriber_:=subScriber;
end;

procedure TCbSFP_wndDEBUG.message(const mText:string);
begin
    memo1.Lines.Insert(0,TimeToStr(now)+' '+mText);
    memo1.SelStart:=0;
    memo1.SelLength:=0;
end;

{procedure TCbSFP_wndDEBUG.Message(const mType,mText:string);
begin
    if mType<>''
    then message(' ['+mType+'] '+mText)
    else message(mText);
end;}

end.

