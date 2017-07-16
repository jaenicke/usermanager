{$I ..\..\CompilerSwitches.inc}

unit ComObj_Light;

interface

function CreateComObject(const ClassID: TGUID): IUnknown;

function CreateRemoteComObject(const MachineName: WideString;
  const ClassID: TGUID): IUnknown;

implementation

uses
  Windows, ActiveX;

function AnsiCompareText(const S1, S2: string): Integer;
begin
  Result := CompareString(LOCALE_USER_DEFAULT, NORM_IGNORECASE, PChar(S1),
    Length(S1), PChar(S2), Length(S2)) - 2;
end;

function OleCheck(Value: HResult): Boolean;
begin
  Result := Succeeded(Value);
end;

function CreateComObject(const ClassID: TGUID): IUnknown;
begin
  if not OleCheck(CoCreateInstance(ClassID, nil, CLSCTX_INPROC_SERVER or
     CLSCTX_LOCAL_SERVER, IUnknown, Result)) then
    Result := nil;
end;

function CreateRemoteComObject(const MachineName: WideString;
  const ClassID: TGUID): IUnknown;
const
  LocalFlags = CLSCTX_LOCAL_SERVER or CLSCTX_REMOTE_SERVER or CLSCTX_INPROC_SERVER;
  RemoteFlags = CLSCTX_REMOTE_SERVER;
var
  MQI: TMultiQI;
  ServerInfo: TCoServerInfo;
  IID_IUnknown: TGuid;
  Flags, Size: DWORD;
  LocalMachine: array [0..MAX_COMPUTERNAME_LENGTH] of char;
begin
  Result := nil;
  if @CoCreateInstanceEx <> nil then
  begin
    FillChar(ServerInfo, sizeof(ServerInfo), 0);
    ServerInfo.pwszName := PWideChar(MachineName);
    IID_IUnknown := IUnknown;
    MQI.IID := @IID_IUnknown;
    MQI.itf := nil;
    MQI.hr := 0;
    { If a MachineName is specified check to see if it the local machine.
      If it isn't, do not allow LocalServers to be used. }
    if Length(MachineName) > 0 then
    begin
      Size := Sizeof(LocalMachine);  // Win95 is hypersensitive to size
      if GetComputerName(LocalMachine, Size) and
         (AnsiCompareText(LocalMachine, MachineName) = 0) then
        Flags := LocalFlags else
        Flags := RemoteFlags;
    end else
      Flags := LocalFlags;
    if OleCheck(CoCreateInstanceEx(ClassID, nil, Flags, @ServerInfo, 1, @MQI)) then
      if OleCheck(MQI.HR) then
        Result := MQI.itf
  end;
end;

end.
