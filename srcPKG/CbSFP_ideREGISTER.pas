unit CbSFP_ideREGISTER;

{$mode objfpc}{$H+}

interface

{$define ideLazExtMODE}  //<----------------------- боевой режм "Расширения IDE"

{$ifDef uiDevelopPRJ}
    {$undef ideLazExtMODE}
{$endif}

uses
  {$ifDef ideLazExtMODE}
  IDEOptionsIntf,
  {$else}
      {$ifDef uiDevelopPRJ}
      //XMLConf
      {$endif}
  {$endif}
  CbSFP_ideEditor, CbSFP_ideGENERAL_config, CbSFP_ideGENERAL_editor;

function CbSFP_ideREGISTER_register_SubScrbr(const AGroup,AIndex:Integer; const AParent:Integer=NoParent):PIDEOptionsEditorRec;
function CbSFP_ideREGISTER_register_SubScrbr:PIDEOptionsEditorRec;

procedure Register;

implementation

var
 _CBSP_IdeOptions_GRP_:PIDEOptionsGroupRec;
 _CBSP_IdeOtnsEDT_GNR_:PIDEOptionsEditorRec;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function _CbSFP_ideREGISTER_isREGISTER_:boolean;
begin
    result:=( Assigned(_CBSP_IdeOptions_GRP_) and Assigned(_CBSP_IdeOtnsEDT_GNR_));
end;

procedure _CbSFP_ideREGISTER_doREGISTER_;
begin
   _CBSP_IdeOptions_GRP_:=RegisterIDEOptionsGroup (GroupEditor                 ,tCbSFP_ideGeneral_Config,TRUE);
   _CBSP_IdeOtnsEDT_GNR_:=RegisterIDEOptionsEditor(_CBSP_IdeOptions_GRP_^.Index,tCbSFP_ideGeneral_Editor,0);
end;

procedure _CbSFP_ideREGISTER_Test8RGSTR_;
begin
    if not _CbSFP_ideREGISTER_isREGISTER_ then _CbSFP_ideREGISTER_doREGISTER_;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function CbSFP_ideREGISTER_register_SubScrbr(const AGroup,AIndex:Integer; const AParent:Integer=NoParent):PIDEOptionsEditorRec;
begin
    Assert(false,'CbSFP_ideREGISTER_register_SubScrbr: result==NIL');
   _CbSFP_ideREGISTER_Test8RGSTR_;
    result:=RegisterIDEOptionsEditor(AGroup,tCbSFP_ideCallEditor,AIndex,AParent,TRUE);
    Assert(Assigned(result),'CbSFP_ideREGISTER_register_SubScrbr: result==NIL');
end;

function CbSFP_ideREGISTER_register_SubScrbr:PIDEOptionsEditorRec;
begin
   _CbSFP_ideREGISTER_Test8RGSTR_;
    result:=CbSFP_ideREGISTER_register_SubScrbr(_CBSP_IdeOptions_GRP_^.Index,GetFreeIDEOptionsIndex(_CBSP_IdeOptions_GRP_^.Index,0));
end;

//------------------------------------------------------------------------------

procedure Register;
begin
   _CbSFP_ideREGISTER_Test8RGSTR_;
end;

initialization
   _CBSP_IdeOptions_GRP_:=nil;
   _CBSP_IdeOtnsEDT_GNR_:=nil;

end.

