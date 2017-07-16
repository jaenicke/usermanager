(******************************************************************************
 *                                                                            *
 *  Usermanager                                                               *
 *  Export -- Export class for exporting users into a csv file                *
 *                                                                            *
 *  Copyright Michael Puff  http://www.michael-puff.de                        *
 *                                                                            *
 *                                                                            *
 ******************************************************************************)

{$I ..\..\CompilerSwitches.inc}

unit Export;

interface

uses Windows, MPuTools, Exceptions, NTUser;

type
  TExport = class(TObject)
  private
    FFilename: WideString;
    FComputer: WideString;
    FUsers: TUserCollection;
    procedure SetFilename(Filename: WideString);
    function GetFilename: WideString;
    procedure SetComputer(Computer: WideString);
    function GetComputer: WideString;
    procedure SetUsers(Users: TUserCollection);
  public
    property Filename: WideString read GetFilename write SetFilename;
    property Computer: WideString read GetComputer write SetComputer;
    property Users: TUserCollection write SetUsers;
    procedure ExportToCSV;
    procedure ExportToXML;
  end;

implementation

uses List;

function BoolToStr(b: Boolean): string;
const
  BoolStr           : array[Boolean] of string = ('0', '-1');
begin
  result := BoolStr[b];
end;

{ TExport }

procedure TExport.ExportToCSV;
const
  CSV_SEP           = ';';
var
  f                 : TextFile;
  i                 : Integer;
  s                 : WideString;
  Groups            : TGroupCollection;
  j                 : Integer;
  strGroups         : string;
begin
  AssignFile(f, FFilename);
{$I-}
  Rewrite(f);
{$I+}
  if IOResult = 0 then
  begin
    s := 'Name' + CSV_SEP + 'FullName' + CSV_SEP + 'Description' + CSV_SEP + 'HomeDir' + CSV_SEP + 'ScriptPath' +
      CSV_SEP + 'CantChangePW' + CSV_SEP + 'AccountDontExpires' + CSV_SEP + 'MustChangePW' + CSV_SEP +
      'AccountIsDeactivated' + CSV_SEP + 'AutoLogin' + CSV_SEP + 'IsAccountHidde' + CSV_SEP + 'Groups' + CSV_SEP;
    Writeln(f, s);
    s := '';
    for i := 0 to FUsers.Count - 1 do
    begin
      Groups := FUsers.Items[i].Groups;
      for j := 0 to Groups.GetUserGroups(FUsers.Items[i]).Count - 1 do
      begin
        strGroups := strGroups + Groups.Items[j].Name + ',';
      end;
      // letzte Komma abschneiden
      strGroups := copy(strGroups, 1, length(strGroups) - 1);

      with FUsers do
      begin
        s := s + FUsers.Items[i].Name + CSV_SEP + FUsers.Items[i].FullName + CSV_SEP + Items[i].Description + CSV_SEP +
          Items[i].HomeDir + CSV_SEP + Items[i].ScriptPath + CSV_SEP + BoolToStr(Items[i].CantChangePW) + CSV_SEP +
          BoolToStr(Items[i].DontExpire) + CSV_SEP + BoolToStr(Items[i].MustChangePW) + CSV_SEP +
          BoolToStr(Items[i].Deactivated) + CSV_SEP + BoolToStr(Items[i].AutoLogin) + CSV_SEP +
          BoolToStr(Items[i].HideAccount) + CSV_SEP + strGroups + CSV_SEP;
      end;
      Writeln(f, s);
      s := '';
      strGroups := '';
    end;
    CloseFile(f);
  end
  else
    raise Exception.Create(SysErrorMessage(GetLastError), GetLastError);
end;

procedure TExport.ExportToXML;
const
  LB                = #13#10;
  INDENT            = #9;

  function WriteStartNode(s: WideString): WideString; overload;
  begin
    result := FormatW('<%s>', [s]);
  end;

  function WriteStartNode(s: WideString; Attribut: WideString; Value: WideString): WideString; overload;
  begin
    result := FormatW('<%s %s="%s">', [s, Attribut, Value]);
  end;

  function WriteEndNode(s: WideString): WideString;
  begin
    result := FormatW('</%s>', [s]);
  end;

var
  f                 : TextFile;
  s                 : string;
  i                 : Integer;
  Groups            : TGroupCollection;
  j                 : Integer;
  strGroups         : string;
begin
  AssignFile(f, FFilename);
{$I-}
  Rewrite(f);
{$I+}
  if IOResult = 0 then
  begin
    s := '<?xml version="1.0" encoding="ISO-8859-1"?>';
    Writeln(f, s);
    s := WriteStartNode('xpusermanager');
    Writeln(f, s);
    s := WriteStartNode('users');
    Writeln(f, s);
    for i := 0 to FUsers.Count - 1 do
    begin
      Groups := FUsers.Items[i].Groups;
      for j := 0 to Groups.GetUserGroups(FUsers.Items[i]).Count - 1 do
      begin
        strGroups := strGroups + WriteStartNode('group') +Groups.Items[j].Name + WriteEndNode('group');
      end;

      with FUsers do
      begin
        s := WriteStartNode('account', 'value', Items[i].Name) + LB +
          INDENT + WriteStartNode('properties') + LB +
          INDENT + INDENT + WriteStartNode('password') + '' + WriteEndNode('password') + LB +
          INDENT + INDENT + WriteStartNode('fullname') + Items[i].FullName + WriteEndNode('fullname') + LB +
          INDENT + INDENT + WriteStartNode('description') + Items[i].Description + WriteEndNode('description') + LB +
          INDENT + INDENT + WriteStartNode('homedir') + Items[i].HomeDir + WriteEndNode('homedir') + LB +
          INDENT + INDENT + WriteStartNode('scriptpath') + Items[i].ScriptPath + WriteEndNode('scriptpath') + LB +
          INDENT + INDENT + WriteStartNode('cantchangepw') + BoolToStr(Items[i].CantChangePW) +
            WriteEndNode('cantchangepw') + LB +
          INDENT + INDENT + WriteStartNode('accountdontexpires') + BoolToStr(Items[i].DontExpire) +
            WriteEndNode('accountdontexpires') + LB +
          INDENT + INDENT + WriteStartNode('mustchangepw') + BoolToStr(Items[i].MustChangePW) +
            WriteEndNode('mustchangepw') + LB +
          INDENT + INDENT + WriteStartNode('accountisdeactivated') + BoolToStr(Items[i].Deactivated) +
            WriteEndNode('accountisdeactivated') + LB +
          INDENT + INDENT + WriteStartNode('autologin') + BoolToStr(Items[i].AutoLogin) + WriteEndNode('autologin') + LB
            +
          INDENT + INDENT + WriteStartNode('isaccounthidden') + BoolToStr(Items[i].HideAccount) +
            WriteEndNode('isaccounthidden') + LB +
          INDENT + WriteEndNode('properties')+ LB +
          INDENT + WriteStartNode('groups') + LB +
          INDENT + INDENT + strGroups + LB +
          INDENT + WriteEndNode('groups');
      end;
      Writeln(f, s);
      Writeln(f, WriteEndNode('account'));
      s := '';
      strGroups := '';
    end;

    s := WriteEndNode('users');
    Writeln(f, s);
    s := WriteEndNode('xpusermanager');
    Writeln(f, s);

    CloseFile(f);
  end
  else
    raise Exception.Create(SysErrorMessage(GetLastError), GetLastError);
end;

function TExport.GetComputer: WideString;
begin
  result := FComputer
end;

function TExport.GetFilename: WideString;
begin
  result := FFilename;
end;

procedure TExport.SetComputer(Computer: WideString);
begin
  FComputer := copy(Computer, 3, length(Computer));
end;

procedure TExport.SetFilename(Filename: WideString);
begin
  FFilename := Filename
end;

procedure TExport.SetUsers(Users: TUserCollection);
begin
  if Assigned(Users) then
    FUsers := Users;
end;

end.

