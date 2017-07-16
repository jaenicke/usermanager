(******************************************************************************
 *                                                                            *
 *  Usermanager                                                               *
 *  Import -- <Kommentar>                                                     *
 *                                                                            *
 *  Copyright Michael Puff  http://www.michael-puff.de                        *
 *                                                                            *
 ******************************************************************************)

{$I ..\..\CompilerSwitches.inc}

unit Import;

interface

uses
  Windows, MpuTools, List, NTUser, NetAPI, Exceptions, MSXML2_TLB_Light, ActiveX, Consts;

{$I .\units\includes\ResStrings.inc}

type
  TImport = class(TObject)
  private
    FComputer: WideString;
    FXMLFile: WideString;
  public
    constructor Create(Computer, XMLFile: WideString);
    function Import: Boolean;
  end;

implementation

constructor TImport.Create(Computer, XMLFile: WideString);
begin
  inherited Create;
  FComputer := Computer;
  FXMLFile := XMLFile;
end;

function TImport.Import: Boolean;
var
  User: TUser;
  ui3: PUserInfo3;
  XMLDoc: IXMLDOMDocument;
  XMLNode: IXMLDOMNode;
  Users: IXMLDOMNodeList;
  Groups: IXMLDOMNodeList;
  GroupNode: IXMLDOMNode;
  UserNode: IXMLDOMNode;
  i, j: Integer;
  hLogFile: THandle;
  s: string;
  ErrorSuccess: Boolean;
begin
  CoInitialize(nil);
  ErrorSuccess := True;
  XMLDoc := CoDOMDocument40.Create;

  // Logging
  hLogFile := FileCreate(ExtractFilepath(ParamStr(0)) + LOGFILE);
  if (hLogFile <> 0) then
  begin
    FileWrite(hLogFile, s[1], Length(s));
    s := Format(rsLogfileImport, ['', FXMLFile]);
    if XMLDoc.load(FXMLFile) then
    begin
      XMLNode := XMLDoc.selectSingleNode('xpusermanager');
      if Assigned(XMLNode) then
      begin
        Users := XMLDoc.documentElement.selectNodes('users/*');
        for i := 0 to Users.length - 1 do
        begin
          try
            GetMem(ui3, sizeof(TUserInfo3));
            ZeroMemory(ui3, sizeof(TUserInfo3));
            UserNode := Users.item[i].selectSingleNode('@value');
            ui3.usri3_name := PWideChar(UserNode.text);
            User := TUser.Create(FComputer, ui3);
            UserNode := Users.item[i].selectSingleNode('properties/password');
            User.Password := UserNode.text;
            User.Add;
            UserNode := Users.item[i].selectSingleNode('properties/fullname');
            User.FullName := UserNode.text;
            UserNode := Users.item[i].selectSingleNode('properties/description');
            User.Description := UserNode.text;
            UserNode := Users.item[i].selectSingleNode('properties/homedir');
            User.HomeDir := UserNode.text;
            UserNode := Users.item[i].selectSingleNode('properties/scriptpath');
            User.ScriptPath := UserNode.text;
            UserNode := Users.item[i].selectSingleNode('properties/cantchangepw');
            User.CantChangePW := Boolean(StrToInt(UserNode.text));
            UserNode := Users.item[i].selectSingleNode('properties/accountdontexpires');
            User.DontExpire := Boolean(StrToInt(UserNode.text));
            UserNode := Users.item[i].selectSingleNode('properties/mustchangepw');
            User.MustChangePW := Boolean(StrToInt(UserNode.text));
            UserNode := Users.item[i].selectSingleNode('properties/accountisdeactivated');
            User.Deactivated := Boolean(StrToInt(UserNode.text));
            UserNode := Users.item[i].selectSingleNode('properties/autologin');
            User.AutoLogin := Boolean(StrToInt(UserNode.text));
            UserNode := Users.item[i].selectSingleNode('properties/isaccounthidden');
            User.HideAccount := Boolean(StrToInt(UserNode.text));
            User.Save;
            Groups := Users.item[i].selectNodes('groups/*');
            for j := 0 to Groups.length - 1 do
            begin
              GroupNode := Groups.item[j];
              User.AddGroup := GroupNode.text;
            end;
            s := Format(rsLogfileOK + #13#10, [string(User.Name)]);
            FileWrite(hLogFile, s[1], Length(s));
          except
            on E: Exception do
            begin
              ErrorSuccess := False;
              s := Format(rsLogfileError + #13#10, [string(User.Name), string(E.Errorcode), string(E.Message)]);
              FileWrite(hLogFile, s[1], Length(s));
            end;
          end;
        end;
      end
      else
        raise Exception.CreateFmt(rsImpFileError, [FXMLFile]);
    end
    else
    begin
      raise Exception.CreateFmt(rsImpXMLError, [FXMLFile]);
    end;
    FileClose(hLogFile);
  end;
  CoUninitialize;
  Result := ErrorSuccess;
end;

end.

