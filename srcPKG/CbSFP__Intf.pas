unit CbSFP__Intf;

//----------------------\\-----------------------------------------------------=
//  ╔═╗┌┐ ╔═╗╔═╗╔═╗      \\  Configuration by Source File Path                 =
//  ║  ├┴┐╚═╗╠╣ ╠═╝      //  Конфигурация по пути исходного файла              =
//  ╚═╝└─┘╚═╝╚  ╩ v0.9  //   [INTF]                                            =
//---------------------//------------------------------------------------------=
// как аналог в системе IDE Lazarus Intf
//------------------------------------------------------------------------------

{$mode objfpc}{$H+}

interface

uses IDEOptionsIntf, CbSFP_ideCenter, CbSFP_SubScriber;

function CbSFP_SubScriber__REGISTER(const Handle:tCbSFP_SubScriberTHandle; const Editor:tCbSFP_SubScriberTEditor):tCbSFP_SubScriber;
function CbSFP_SubScriber__REGISTER(const Handle:tCbSFP_SubScriberTHandle; const Editor:tCbSFP_SubScriberTEditor; const AGroup,AIndex:Integer; const AParent:Integer=NoParent):tCbSFP_SubScriber;

implementation

function CbSFP_SubScriber__REGISTER(const Handle:tCbSFP_SubScriberTHandle; const Editor:tCbSFP_SubScriberTEditor):tCbSFP_SubScriber;
begin
    result:=CbSFP_ideCenter.CbSFP_ideCenter__SubScriberREGISTER(Handle,Editor);
end;

function CbSFP_SubScriber__REGISTER(const Handle:tCbSFP_SubScriberTHandle; const Editor:tCbSFP_SubScriberTEditor; const AGroup,AIndex:Integer; const AParent:Integer=NoParent):tCbSFP_SubScriber;
begin
    result:=CbSFP_ideCenter.CbSFP_ideCenter__SubScriberREGISTER(Handle,Editor, AGroup,AIndex,AParent);
end;

end.

