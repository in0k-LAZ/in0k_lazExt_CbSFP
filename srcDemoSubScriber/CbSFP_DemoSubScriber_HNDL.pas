unit CbSFP_DemoSubScriber_HNDL;

//----------------------\\-----------------------------------------------------=
//  ╔═╗┌┐ ╔═╗╔═╗╔═╗      \\  Configuration by Source File Path                 =
//  ║  ├┴┐╚═╗╠╣ ╠═╝      //  Конфигурация по пути исходного файла              =
//  ╚═╝└─┘╚═╝╚  ╩ v0.9  //   [custom HNDL]                                     =
//---------------------//------------------------------------------------------=
// пример реализации "пользовательского обработчика конфигурации"
//------------------------------------------------------------------------------

{$mode objfpc}{$H+}

interface

uses IniFiles,
     CbSFP_SubScriber,
     CbSFP_DemoSubScriber_CNFG;

type

 tCbSFP_DemoSubScriber_HNDL=class(tCbSFP_SubScriber_handle)
  public
    class function  Identifier:string; override;
  public
    function  ConfigOBJ_CRT:tCbSFP_SubScriber_cnfOBJ;            override;
    procedure ConfigOBJ_DST(const Obj:tCbSFP_SubScriber_cnfOBJ); override;
    procedure ConfigOBJ_DEF(const Obj:tCbSFP_SubScriber_cnfOBJ); override;
  public
    function  ConfigOBJ_FileEXT:string; override;
    function  ConfigOBJ_Save(const Obj:tCbSFP_SubScriber_cnfOBJ; const FileName:string; const Used:boolean):boolean; override;
    function  ConfigOBJ_Load(const Obj:tCbSFP_SubScriber_cnfOBJ; const FileName:string; var   Used:boolean):boolean; override;
  end;

implementation

class function tCbSFP_DemoSubScriber_HNDL.Identifier:string;
begin
    result:='CbSFP_DemoSubScriber';
end;

//------------------------------------------------------------------------------

function tCbSFP_DemoSubScriber_HNDL.ConfigOBJ_CRT:pointer;
begin
    result:=CbSFP_DemoSubScriber_CNFG__CRT;
end;

procedure tCbSFP_DemoSubScriber_HNDL.ConfigOBJ_DST(const Obj:pointer);
begin
    CbSFP_DemoSubScriber_CNFG__DST(Obj);
end;

procedure tCbSFP_DemoSubScriber_HNDL.ConfigOBJ_DEF(const Obj:pointer);
begin
    CbSFP_DemoSubScriber_CNFG__DEF(Obj);
end;

//------------------------------------------------------------------------------

function tCbSFP_DemoSubScriber_HNDL.ConfigOBJ_FileEXT:string;
begin
    result:='.ini';
end;

function tCbSFP_DemoSubScriber_HNDL.ConfigOBJ_Save(const Obj:pointer; const FileName:string; const Used:boolean):boolean;
var tmp:pCbSFP_DemoSubScriber_CNFG;
    ini:TIniFile;
begin
    tmp:=Obj;
    result:=false;
    try
        ini:=TIniFile.Create(FileName);
        //---
        ini.WriteBool('main','Used',Used);
        //---
        ini.WriteInteger('main','III',tmp^.III);
        ini.WriteString ('main','SSS',tmp^.SSS);
        //---
        ini.FREE;
        result:=TRUE;
    except
        result:=false;
    end;
end;

function tCbSFP_DemoSubScriber_HNDL.ConfigOBJ_Load(const Obj:pointer; const FileName:string; var Used:boolean):boolean;
var tmp:pCbSFP_DemoSubScriber_CNFG;
    ini:TIniFile;
begin
    tmp:=Obj;
    result:=false;
    try
        ini:=TIniFile.Create(FileName);
        //---
        Used    :=ini.ReadBool   ('main','Used',   Used);
        tmp^.III:=ini.ReadInteger('main','III',tmp^.III);
        tmp^.SSS:=ini.ReadString ('main','SSS',tmp^.SSS);
        //---
        ini.FREE;
        result:=TRUE;
    except
        result:=false;
    end;
end;

end.

