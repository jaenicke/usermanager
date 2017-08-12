(******************************************************************************
 *                                                                            *
 *  Usermanager                                                               *
 *  Import -- <Kommentar>                                                     *
 *                                                                            *
 *  This Source Code Form is subject to the terms of the Mozilla Public       *
 *  License, v. 2.0. If a copy of the MPL was not distributed with this       *
 *  file, You can obtain one at http://mozilla.org/MPL/2.0/.                  *
 *                                                                            *
 *  Copyright Michael Puff  http://www.michael-puff.de                        *
 *                                                                            *
 ******************************************************************************)

{$I ..\..\CompilerSwitches.inc}

unit Import;

interface

uses
  Windows, MpuTools, List, NTUser, NetAPI, Exceptions, MSXML2_TLB_Light, ActiveX, Consts,
  SysUtils;

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

procedure WriteLog(const ALogFileHandle: THandle; const ALogText: string);
const
  ByteOrderMark : Word = $FEFF;
var
  LogFilesize: Int64;
begin
  Int64Rec(LogFilesize).Lo := Windows.GetFileSize(ALogFileHandle, @Int64Rec(LogFilesize).Hi);
  if LogFilesize = 0 then
    FileWrite(ALogFileHandle, ByteOrderMark, SizeOf(ByteOrderMark));
  FileWrite(ALogFileHandle, ALogText[1], Length(ALogText) * SizeOf(Char));
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
begin
  CoInitialize(nil);
  Result := False;

  // Logging
  hLogFile := FileCreate(ExtractFilepath(ParamStr(0)) + LOGFILE);
  if (hLogFile <> 0) then
  begin
    XMLDoc := CoDOMDocument60.Create;
    if not Assigned(XMLDoc) then
      XMLDoc := CoDOMDocument40.Create;
    if not Assigned(XMLDoc) then
    begin
      WriteLog(hLogFile, rsXMLError);
      Exit;
    end;
    WriteLog(hLogFile, Format(rsLogfileImport, ['', FXMLFile]));
    if XMLDoc.load(FXMLFile) then
    begin
      XMLNode := XMLDoc.selectSingleNode('xpusermanager');
      if Assigned(XMLNode) then
      begin
        Users := XMLDoc.documentElement.selectNodes('users/*');
        for i := 0 to Users.length - 1 do
        begin
          GetMem(ui3, sizeof(TUserInfo3));
          ZeroMemory(ui3, sizeof(TUserInfo3));
          UserNode := Users.item[i].selectSingleNode('@value');
          ui3.usri3_name := PWideChar(UserNode.text);
          User := TUser.Create(FComputer, ui3);
          try
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
            WriteLog(hLogFile, Format(rsLogfileOK + #13#10, [string(User.Name)]));
            Result := True;
          except
            on E: Exception do
              WriteLog(hLogFile, Format(rsLogfileError + #13#10, [string(User.Name), string(E.ClassName), string(E.Message)]));
          end;
        end;
      end
      else
        WriteLog(hLogFile, Format(rsImpFileError, [FXMLFile]));
    end
    else
      WriteLog(hLogFile, Format(rsImpXMLError, [FXMLFile]));
    FileClose(hLogFile);
  end;
  CoUninitialize;
end;

end.

