(******************************************************************************
 *                                                                            *
 *  Usermanager                                                               *
 *  NTUser -- Core unit                                                       *
 *                                                                            *
 *  This Source Code Form is subject to the terms of the Mozilla Public       *
 *  License, v. 2.0. If a copy of the MPL was not distributed with this       *
 *  file, You can obtain one at http://mozilla.org/MPL/2.0/.                  *
 *                                                                            *
 *  Copyright (c) 2006 Michael Puff  http://www.michael-puff.de               *
 *                                                                            *
 *  Many thanks to motzi for his work on this unit.                           *
 *                                                                            *
 ******************************************************************************)

unit NTUser;

{$I ..\..\CompilerSwitches.inc}

interface

uses
  Windows,
  NetAPI,
  lsaapi,
  List,
  Exceptions,
  ActiveX;

type
  TGroup = class;
  TGroupCollection = class;

//------------------------------------------------------------------------------
// Basisklasse für Treeview-Items (User / Group)
//------------------------------------------------------------------------------
  TTVEntry = class
  protected
    FServer: WideString;
  public
    function GetCaption: WideString; virtual; abstract;
    function GetImageIndex: Integer; virtual; abstract;
    function GetChildList: TList; virtual; abstract;
    property Server: WideString read FServer;
  end;

//------------------------------------------------------------------------------
// Kapselt alle Infos für einen Account
//------------------------------------------------------------------------------
  TUser = class(TTVEntry)
  private
    FModified: Boolean;
    FEditable: Boolean;
    FInitialized: Boolean;
    Fui3: TUserInfo3;
    FGroups: TGroupCollection;
    FAutoLoginPW: WideString;
    procedure Initialize();
    procedure SetStrings(ui3: PUserInfo3);
    function GetGroups: TGroupCollection;
    function GetName: WideString;
    function GetFullName: WideString;
    procedure SetFullName(const Value: WideString);
    function GetInternetDomainTrustAccount: Boolean;
    function GetNormalAccount: Boolean;
    function GetTempDublicateAccount: Boolean;
    function GetWorkstationTrustAccount: Boolean;
    function GetServerTrustAccount: Boolean;
    function GetAccountExpires: Cardinal;
    function GetAutoLogin: Boolean;
    function GetCantChangePW: Boolean;
    function GetCountLogons: Cardinal;
    function GetDeactivated: Boolean;
    function GetDescription: WideString;
    function GetDontExpire: Boolean;
    function GetErroneousLogons: Cardinal;
    function GetHideAccount: Boolean;
    function GetHomeDir: WideString;
    function GetLastLogon: Cardinal;
    function GetMustChangePW: Boolean;
    function GetPWAge: Cardinal;
    function GetQuota: Cardinal;
    function GetScriptPath: WideString;
    function GetUserID: Cardinal;
    procedure SetName(const Value: WideString);
    procedure SetAccountExpires(const Value: DWORD);
    procedure SetAutoLogin(const Value: Boolean);
    procedure SetAutoLoginPW(const Value: WideString);
    procedure SetCantChangePW(const Value: Boolean);
    procedure SetInternetDomainTrustAccount(const Value: Boolean);
    procedure SetNormalAccount(const Value: Boolean);
    procedure SetTempDublicateAccount(const Value: Boolean);
    procedure SetWorkstationTrustAccount(const Value: Boolean);
    procedure SetServerTrustAccount(const Value: Boolean);
    procedure SetDeactivated(const Value: Boolean);
    procedure SetDescription(const Value: WideString);
    procedure SetDontExpire(const Value: Boolean);
    procedure SetHideAccount(const Value: Boolean);
    procedure SetHomeDir(const Value: WideString);
    procedure SetMustChangePW(const Value: Boolean);
    procedure SetPassword(const Value: WideString);
    procedure SetScriptPath(const Value: WideString);
    procedure AddToGroup(const Value: WideString);
    procedure RemoveFromGroup(const Value: WideString);
    function GetEditable: Boolean;
  public
    constructor Create(const server: WideString; ui3: PUserInfo3); overload;
    constructor Create(const server: WideString; lgmi: PLocalGroupMembersInfo3); overload;
    destructor Destroy; override;
    procedure Add;
    procedure Save;
    procedure Del;
    function GetCaption: WideString; override;
    function GetImageIndex: Integer; override;
    function GetChildList: TList; override;
    property Groups: TGroupCollection read GetGroups;
    property Modified: Boolean read FModified write FModified;
    property Editable: Boolean read GetEditable;
    property Name: WideString read GetName write SetName;
    property FullName: WideString read GetFullName write SetFullName;
    property Description: WideString read GetDescription write SetDescription;
    property InternetDomainTrustAccount: Boolean read GetInternetDomainTrustAccount write
      SetInternetDomainTrustAccount;
    property NormalAccount: Boolean read GetNormalAccount write SetNormalAccount;
    property TempDublicateAccount: Boolean read GetTempDublicateAccount write SetTempDublicateAccount;
    property WorkStationTrustAccount: Boolean read GetWorkstationTrustAccount write SetWorkstationTrustAccount;
    property ServerTrustAccount: Boolean read GetServerTrustAccount write SetServerTrustAccount;
    property HomeDir: WideString read GetHomeDir write SetHomeDir;
    property ScriptPath: WideString read GetScriptPath write SetScriptPath;
    property Password: WideString write SetPassword;
    property CantChangePW: Boolean read GetCantChangePW write SetCantChangePW;
    property DontExpire: Boolean read GetDontExpire write SetDontExpire;
    property MustChangePW: Boolean read GetMustChangePW write SetMustChangePW;
    property Deactivated: Boolean read GetDeactivated write SetDeactivated;
    property AutoLogin: Boolean read GetAutoLogin write SetAutoLogin;
    property AutoLoginPW: WideString write SetAutoLoginPW;
    property HideAccount: Boolean read GetHideAccount write SetHideAccount;
    property AddGroup: WideString write AddToGroup;
    property RemoveGroup: WideString write RemoveFromGroup;
    property PWAge: Cardinal read GetPWAge;
    property LastLogon: Cardinal read GetLastLogon;
    property CountLogons: Cardinal read GetCountLogons;
    property ErroneousLogons: Cardinal read GetErroneousLogons;
    property AccountExpires: Cardinal read GetAccountExpires;
    property Quota: Cardinal read GetQuota;
    property UserID: Cardinal read GetUserID;
  end;

//------------------------------------------------------------------------------
// Typisierte TList - Verwaltet eine Liste von TUser-Objekten
//------------------------------------------------------------------------------
  TUserCollection = class(TList)
  private
    function Get(Index: Integer): TUser;
    procedure Put(Index: Integer; const Value: TUser);
  public
    class function GetAll(const Server: WideString; filter: DWord = FILTER_NORMAL_ACCOUNT): TUserCollection;
    class function GetGroupMembers(Group: TGroup): TUserCollection;
    function Add(Item: TUser): Integer;
    function First: TUser;
    function IndexOf(Item: TUser): Integer;
    property Items[Index: Integer]: TUser read Get write Put; default;
  end;

//------------------------------------------------------------------------------
// Kapselt alle Infos für eine Gruppe
//------------------------------------------------------------------------------
  TGroup = class(TTVEntry)
  private
    Flgi0: TLocalGroupInfo0;
    Flgi1: TLocalGroupInfo1;
    FMembers: TUserCollection;
    function GetName: WideString;
    function GetUsers: TUserCollection;

  public
    constructor Create(const Server: WideString; lgi0: PLocalGroupInfo0); overload;
    constructor Create(const Server: WideString; lgi1: TLocalGroupInfo1); overload;
    destructor Destroy; override;
    function GetCaption: WideString; override;
    function GetImageIndex: Integer; override;
    function GetChildList: TList; override;
    property Members: TUserCollection read GetUsers;
    property Name: WideString read GetName;
    function GetComment: WideString;
    procedure Add;
    procedure Del;
  end;

//------------------------------------------------------------------------------
// Typisierte TList - Verwaltet eine Liste von TGroup-Objekten
//------------------------------------------------------------------------------
  TGroupCollection = class(TList)
  private
    function Get(Index: Integer): TGroup;
    procedure Put(Index: Integer; const Value: TGroup);
  public
    class function GetAll(const Server: WideString): TGroupCollection;
    class function GetUserGroups(User: TUser): TGroupCollection;
    function Add(Item: TGroup): Integer;
    procedure Delete(const Group: WideString);
    function First: TGroup;
    function IndexOf(Item: TGroup): Integer;
    property Items[Index: Integer]: TGroup read Get write Put; default;
  end;

//------------------------------------------------------------------------------
// Kapselt alle Infos für ein Privileg
//------------------------------------------------------------------------------
  TPrivilege = class(TObject)
  private
    FServer: string;
    FRightConstant: string;
    FRightDescription: string;
    function GetRightConstant: string;
    function GetDescription: string;
    procedure SetDescription(const RightConstant: string);
  public
    constructor Create(const Server, RightConstant: string);
    property Constant: string read GetRightConstant;
    property Description: string read GetDescription;
  end;

//------------------------------------------------------------------------------
// Typisierte TList - Verwaltet eine Liste von TPrivilege-Objekten
//------------------------------------------------------------------------------
  TPrivilegeCollection = class(TList)
  private
    function Get(Index: Integer): TPrivilege;
    procedure Put(Index: Integer; const Value: TPrivilege);
  public
    class function GetAll(const Server: WideString): TPrivilegeCollection;
    class function GetUserPrivileges(const Server, User: WideString): TPrivilegeCollection;
    function Add(Item: TPrivilege): Integer;
    function IndexOf(Item: TPrivilege): Integer;
    property Items[Index: Integer]: TPrivilege read Get write Put; default;
  end;

procedure GrantPrivilege(const Server, Group, Privilege: string; Grant: Boolean);

const
  PrivArray         : array[0..27] of string = ('SeInteractiveLogonRight', 'SeNetworkLogonRight', 'SeBatchLogonRight',
    'SeServiceLogonRight', 'SeCreateTokenPrivilege', 'SeAssignPrimaryTokenPrivilege', 'SeLockMemoryPrivilege',
    'SeIncreaseQuotaPrivilege', 'SeUnsolicitedInputPrivilege', 'SeMachineAccountPrivilege', 'SeTcbPrivilege',
    'SeSecurityPrivilege', 'SeTakeOwnershipPrivilege', 'SeLoadDriverPrivilege', 'SeSystemProfilePrivilege',
    'SeSystemtimePrivilege', 'SeProfileSingleProcessPrivilege', 'SeIncreaseBasePriorityPrivilege',
    'SeCreatePagefilePrivilege', 'SeCreatePermanentPrivilege', 'SeBackupPrivilege', 'SeRestorePrivilege',
    'SeShutdownPrivilege', 'SeDebugPrivilege', 'SeAuditPrivilege', 'SeSystemEnvironmentPrivilege',
    'SeChangeNotifyPrivilege', 'SeRemoteShutdownPrivilege');

implementation

uses
  MpuTools,
  MpuRegistry;

procedure FillPWideCharFromString(var pwc: PWideChar; str: string);
var
  cchLen            : DWORD;
begin
  pwc := nil;
  if (Length(str) > 0) then
  begin
    cchLen := Length(str) + 1;
    pwc := PWideChar(GlobalAlloc(GPTR, cchLen * sizeof(WideChar)));
    MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, @str[1], Length(str), pwc, cchLen);
  end;
end;

////////////////////////////////////////////////////////////////////////////////

function IsInGroup(const Value: WideString; Groups: TGroupCollection): Boolean;
var
  i                 : Integer;
  s                 : WideString;
begin
  result := false;
  for i := 0 to Groups.Count - 1 do
  begin
    s := Groups.Items[i].GetName;
    if (s = Value) then
    begin
      result := True;
      exit;
    end;
  end;
end;

{$HINTS OFF}

procedure GrantPrivilege(const Server, Group, Privilege: string; Grant: Boolean);
var
  sid               : PSID;
  sidSize, sidNameUse: DWORD;
  domainNameSize    : DWORD;
  domainName        : array[0..DNLEN] of Char;
  attributes        : TLsaObjectAttributes;
  policyHandle      : LSA_HANDLE;
  lsaComputerName, rightsLsaUnicodeString: TLSAUnicodeStr;
  status            : NTStatus;

begin
  status := STATUS_SUCCESS;
  sidSize := 65536;
  GetMem(sid, sidSize);
  domainNameSize := DNLEN + 1;
  try
    if LookupAccountName(PChar(Server), PChar(Group), sid, sidSize, domainName, domainNameSize, sidNameUse) then
    begin
      lsaComputerName := TLsaUnicodeStr.CreateFromStrW(Server);
      try
        FillChar(attributes, SizeOf(attributes), 0);
        status := LsaOpenPolicy(lsaComputerName.value, attributes, POLICY_CREATE_ACCOUNT or POLICY_LOOKUP_NAMES,
          policyHandle);
        if status = STATUS_SUCCESS then
        try
          rightsLsaUnicodeString := TLsaUnicodeStr.CreateFromStrW(privilege);
          try
            if Grant then
              status := LsaAddAccountRights(PolicyHandle, sid, @rightsLsaUnicodeString.value, 1)
            else
              status := LsaRemoveAccountRights(PolicyHandle, sid, False, @rightsLsaUnicodeString.value, 1);
          finally
            rightsLsaUnicodeString.Free
          end
        finally
          LsaClose(PolicyHandle)
        end
      finally
        lsaComputerName.Free
      end
    end
  finally
    FreeMem(sid)
  end;
  //if status <> STATUS_SUCCESS then
    //raise ENetAPIError.Create(LsaNtStatusToWinError(status));
end;
{$HINTS ON}

////////////////////////////////////////////////////////////////////////////////

function GetAccountSid(const Server, User: WideString; var Sid: PSID): DWORD;
var
  dwDomainSize, dwSidSize: DWord;
  R                 : LongBool;
  wDomain           : WideString;
  Use               : DWord;
begin
  Result := 0;
  SetLastError(0);
  dwSidSize := 0;
  dwDomainSize := 0;
  R := LookupAccountNameW(PWideChar(Server), PWideChar(User), nil, dwSidSize,
    nil, dwDomainSize, Use);
  if (not R) and (GetLastError = ERROR_INSUFFICIENT_BUFFER) then
  begin
    SetLength(wDomain, dwDomainSize);
    Sid := GetMemory(dwSidSize);
    R := LookupAccountNameW(PWideChar(Server), PWideChar(User), Sid,
      dwSidSize, PWideChar(wDomain), dwDomainSize, Use);
    if not R then
    begin
      FreeMemory(Sid);
      Sid := nil;
    end;
  end
  else
    Result := GetLastError;
end;

////////////////////////////////////////////////////////////////////////////////

function AutoLogIn(Computer, User: string): Boolean;
var
  MyReg             : TMpuRegistry;
  AutoLogon         : WideString;
  DefaultUsername   : WideString;
begin
  MyReg := TMpuRegistry.CreateW(Computer, HKEY_LOCAL_MACHINE);
  try
    with MyReg do
    begin
      if Connect = 0 then
      begin
        if OpenKey('SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon', KEY_READ) = 0 then
        begin
          ReadStringW('AutoAdminLogon', AutoLogon);
          ReadStringW('DefaultUsername', DefaultUsername);
        end;
      end;
    end;
  finally
    MyReg.Free;
  end;
  result := (AutoLogon = '1') and (DefaultUsername = User);
end;

////////////////////////////////////////////////////////////////////////////////

function SetWinlogonPassword(const Server, Password: WideString): Boolean;
var
  oa                : TLSAObjectAttributes;
  hPolicy           : LSA_HANDLE;
  usServer          : TLSAUnicodeString;
  usKeyName         : TLSAUnicodeString;
  usPassWord        : TLSAUnicodeString;
  Status            : NTSTATUS;
begin
  ZeroMemory(@oa, sizeof(oa));
  oa.Length := sizeof(oa);
  try
    RtlInitUnicodeString(@usServer, PWideChar(Server));
    Status := LsaOpenPolicy(usServer, oa, POLICY_CREATE_SECRET, hPolicy);
    if (NT_SUCCESS(Status)) then
    begin
      RtlInitUnicodeString(@usKeyName, 'DefaultPassword');
      RtlInitUnicodeString(@usPassWord, PWideChar(Password));
      Status := LsaStorePrivateData(hPolicy, usKeyName, usPassword);
    end;
  finally
    LsaClose(hPolicy);
  end;
  Result := NT_SUCCESS(Status);
end;

////////////////////////////////////////////////////////////////////////////////

function SetAutoWinlogon(Server: WideString; Activate: Boolean; Username, Password: WideString): Boolean;
var
  usPassword        : TLSAUnicodeString;
  usServer          : TLSAUnicodeString;
  reg               : TMpuRegistry;
begin
  Result := False;
  reg := TMpuRegistry.CreateW(Server, HKEY_LOCAL_MACHINE);
  if (Assigned(reg)) then
  try
    reg.Connect;
    if reg.OpenKeyW('Software\Microsoft\Windows NT\CurrentVersion\Winlogon', KEY_WRITE) = 0 then
    begin
      // Username
      if Username <> '' then
        reg.WriteStringW('DefaultUserName', Username)
      else
        reg.DeleteValueName('DefaultUserName');

      // Domain
      if Server <> '' then
        reg.WriteStringW('DefaultDomainName', Server)
      else
        reg.DeleteValueName('DefaultDomainName');

      // Init unicode string
      RtlInitUnicodeString(@usPassword, PWideChar(Password));
      RtlInitUnicodeString(@usServer, PWideChar(Server));
      // Set the password in secret stash
      if SetWinlogonPassword(usServer.Buffer, usPassword.Buffer) then
      begin
        Result := True;
      end;
      reg.DeleteValueName('DefaultPassword');

      // Activate autologon
      reg.WriteString('AutoAdminLogon', IntToStr(ord(Activate)));
    end;
  finally
    reg.Free;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

function RemoveAutoLogin(const Machine: string): LongInt;
var
  MyReg             : TMpuRegistry;
  ret               : LongInt;
begin
  MyReg := TMpuRegistry.CreateW(Machine, HKEY_LOCAL_MACHINE);
  try
    with MyReg do
    begin
      ret := Connect;
      if ret = 0 then
      begin
        ret :=
          OpenKey('SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon',
          KEY_WRITE);
        if ret = 0 then
        begin
          DeleteValueName('DefaultPassword');
          ret := WriteString('AutoAdminLogon', '0');
        end;
      end;
    end;
  finally
    MyReg.Free;
  end;
  result := ret;
end;

////////////////////////////////////////////////////////////////////////////////

function IsAccountHidden(const Machine, User: string): Boolean;
var
  MyReg             : TMpuRegistry;
  ret               : Integer;
  Hidden            : LongInt;
begin
  Hidden := 0;
  result := False;
  MyReg := TMpuRegistry.CreateW(Machine, HKEY_LOCAL_MACHINE);
  try
    with MyReg do
    begin
      ret := Connect;
      if ret = 0 then
      begin
        ret := OpenKey('SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList', KEY_READ);
        if ret = 0 then
        begin
          ReadInt(User, Hidden);
          result := Hidden = 0;
        end
        else
          result := False;
      end;
    end;
  finally
    MyReg.Free;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

function HideAccountFnc(const Computer, User: string; Hide: Boolean): LongInt;
var
  MyReg             : TMpuRegistry;
  ret               : LongInt;
begin
  MyReg := TMpuRegistry.CreateW(Computer, HKEY_LOCAL_MACHINE);
  try
    with MyReg do
    begin
      ret := Connect;
      if ret = 0 then
      begin
        ret := CreateKey('SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList');
        if ret = 0 then
        begin
          if Hide then
            ret := WriteInt(User, 0)
          else
            ret := WriteInt(User, 1);
        end;
      end;
    end;
  finally
    MyReg.Free;
  end;
  result := ret;
end;

////////////////////////////////////////////////////////////////////////////////

{ TUser }

constructor TUser.Create(const server: WideString; ui3: PUserInfo3);
begin
  FEditable := True;
  FInitialized := True;
  FServer := server;
  Fui3 := ui3^; // DWords kopieren

  // LPWSTRs müssen extra kopiert werden
  SetStrings(ui3);
end;

////////////////////////////////////////////////////////////////////////////////

constructor TUser.Create(const server: WideString; lgmi: PLocalGroupMembersInfo3);
begin
  FEditable := False;
  FInitialized := False;
  FServer := server;
  Fui3.usri3_name := SysAllocString(PWideChar(ExtractFilenameW(lgmi.lgrmi3_domainandname)));
end;

////////////////////////////////////////////////////////////////////////////////

destructor TUser.Destroy;
begin
  FGroups.Free;
  SysFreeString(Fui3.usri3_name);
  SysFreeString(Fui3.usri3_home_dir);
  SysFreeString(Fui3.usri3_comment);
  SysFreeString(Fui3.usri3_script_path);
  SysFreeString(Fui3.usri3_full_name);
  SysFreeString(Fui3.usri3_usr_comment);
  SysFreeString(Fui3.usri3_parms);
  SysFreeString(Fui3.usri3_workstations);
  SysFreeString(Fui3.usri3_logon_server);
  SysFreeString(Fui3.usri3_profile);
  SysFreeString(Fui3.usri3_home_dir_drive);
  inherited;
end;

////////////////////////////////////////////////////////////////////////////////

function TUser.GetAutoLogin: Boolean;
var
  AutoLogon         : WideString;
  DefaultUsername   : WideString;
begin
  with TMpuRegistry.CreateW(FServer, HKEY_LOCAL_MACHINE) do
  try
    Connect;
    if OpenKeyW('SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon', KEY_READ) = 0 then
    begin
      ReadStringW('AutoAdminLogon', AutoLogon);
      ReadStringW('DefaultUsername', DefaultUsername);
    end;
  finally
    Free;
  end;
  result := (AutoLogon = '1') and (DefaultUsername = Name);
end;

////////////////////////////////////////////////////////////////////////////////

function TUser.GetAccountExpires: Cardinal;
begin
  Initialize();
  Result := Fui3.usri3_acct_expires;
end;

////////////////////////////////////////////////////////////////////////////////

function TUser.GetCantChangePW: Boolean;
begin
  Initialize();
  Result := (Fui3.usri3_flags and UF_PASSWD_CANT_CHANGE) = UF_PASSWD_CANT_CHANGE;
end;

////////////////////////////////////////////////////////////////////////////////

function TUser.GetCaption: WideString;
begin
  Result := Name;
end;

////////////////////////////////////////////////////////////////////////////////

function TUser.GetChildList: TList;
begin
  Result := Groups;
end;

////////////////////////////////////////////////////////////////////////////////

function TUser.GetDeactivated: Boolean;
begin
  Initialize();
  Result := (Fui3.usri3_flags and UF_ACCOUNTDISABLE) = UF_ACCOUNTDISABLE;
end;

////////////////////////////////////////////////////////////////////////////////

function TUser.GetInternetDomainTrustAccount: Boolean;
begin
  Initialize();
  Result := (Fui3.usri3_flags and UF_INTERDOMAIN_TRUST_ACCOUNT) = UF_INTERDOMAIN_TRUST_ACCOUNT;
end;

////////////////////////////////////////////////////////////////////////////////

function TUser.GetNormalAccount: Boolean;
begin
  Initialize();
  Result := (Fui3.usri3_flags and UF_NORMAL_ACCOUNT) = UF_NORMAL_ACCOUNT;
end;

////////////////////////////////////////////////////////////////////////////////

function TUser.GetTempDublicateAccount: Boolean;
begin
  Initialize();
  Result := (Fui3.usri3_flags and UF_TEMP_DUPLICATE_ACCOUNT) = UF_TEMP_DUPLICATE_ACCOUNT;
end;

////////////////////////////////////////////////////////////////////////////////

function TUser.GetWorkstationTrustAccount: Boolean;
begin
  Initialize();
  Result := (Fui3.usri3_flags and UF_WORKSTATION_TRUST_ACCOUNT) = UF_WORKSTATION_TRUST_ACCOUNT;
end;

////////////////////////////////////////////////////////////////////////////////

function TUser.GetServerTrustAccount: Boolean;
begin
  Initialize();
  Result := (Fui3.usri3_flags and UF_SERVER_TRUST_ACCOUNT) = UF_SERVER_TRUST_ACCOUNT;
end;

////////////////////////////////////////////////////////////////////////////////

function TUser.GetDontExpire: Boolean;
begin
  Initialize();
  Result := (Fui3.usri3_flags and UF_DONT_EXPIRE_PASSWD) = UF_DONT_EXPIRE_PASSWD;
end;

////////////////////////////////////////////////////////////////////////////////

function TUser.GetDescription: WideString;
begin
  Initialize();
  Result := Fui3.usri3_comment;
end;

////////////////////////////////////////////////////////////////////////////////

function TUser.GetCountLogons: Cardinal;
begin
  Initialize();
  Result := Fui3.usri3_num_logons;
end;

////////////////////////////////////////////////////////////////////////////////

function TUser.GetEditable: Boolean;
begin
  if not FInitialized then
    Initialize();

  Result := FEditable;
end;

////////////////////////////////////////////////////////////////////////////////

function TUser.GetErroneousLogons: Cardinal;
begin
  Initialize();
  Result := Fui3.usri3_bad_pw_count;
end;

////////////////////////////////////////////////////////////////////////////////

function TUser.GetFullName: WideString;
begin
  Initialize;
  Result := Fui3.usri3_full_name;
end;

////////////////////////////////////////////////////////////////////////////////

function TUser.GetGroups: TGroupCollection;
begin
  if FGroups = nil then
    FGroups := TGroupCollection.GetUserGroups(Self);
  Result := FGroups;
end;

////////////////////////////////////////////////////////////////////////////////

function TUser.GetHideAccount: Boolean;
begin
  Initialize();
  result := IsAccountHidden(self.Server, Self.GetName);
end;

////////////////////////////////////////////////////////////////////////////////

function TUser.GetHomeDir: WideString;
begin
  Initialize();
  Result := Fui3.usri3_home_dir;
end;

////////////////////////////////////////////////////////////////////////////////

function TUser.GetImageIndex: Integer;
const
  imageIndex        : array[Boolean] of Integer = (1, 4);
begin
  Result := imageIndex[Deactivated or not Editable];
end;

////////////////////////////////////////////////////////////////////////////////

function TUser.GetLastLogon: Cardinal;
begin
  Initialize();
  Result := Fui3.usri3_last_logon;
end;

////////////////////////////////////////////////////////////////////////////////

function TUser.GetMustChangePW: Boolean;
begin
  Initialize();
  Result := Fui3.usri3_password_expired <> 0;
end;

////////////////////////////////////////////////////////////////////////////////

function TUser.GetName: WideString;
begin
  // kein Initialize() -> Name ist immer gesetzt!
  Result := Fui3.usri3_name;
end;

////////////////////////////////////////////////////////////////////////////////

function TUser.GetQuota: Cardinal;
begin
  Initialize();
  Result := Fui3.usri3_max_storage;
end;

////////////////////////////////////////////////////////////////////////////////

function TUser.GetUserID: Cardinal;
begin
  Initialize();
  Result := Fui3.usri3_user_id;
end;

////////////////////////////////////////////////////////////////////////////////

function TUser.GetScriptPath: WideString;
begin
  Initialize();
  Result := Fui3.usri3_script_path;
end;

////////////////////////////////////////////////////////////////////////////////

function TUser.GetPWAge: Cardinal;
begin
  Initialize();
  Result := Fui3.usri3_password_age;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUser.Initialize();
var
  ui3               : PUserInfo3;
  error             : DWORD;
begin
  if FInitialized then
    Exit;

  FInitialized := True;
  ui3 := nil;
  try
    error := NetUserGetInfo(PWideChar(Server), Fui3.usri3_name, 3, Pointer(ui3));
    if error = NERR_UserNotFound then
      Exit
    else if (error <> NERR_SUCCESS) then
      raise ENetAPIError.Create(error);

    FEditable := True;
    SysFreeString(Fui3.usri3_name);
    Fui3 := ui3^;
    SetStrings(ui3);
  finally
    NetApiBufferFree(ui3);
  end;
end;

procedure TUser.SetAccountExpires(const Value: DWORD);
begin
  Fui3.usri3_acct_expires := TIMEQ_FOREVER;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUser.SetAutoLogin(const Value: Boolean);
var
  lpwcsPassword,
    lpwcsServer,
    lpwcsUsername   : PWideChar;
begin
  FillPWideCharFromString(lpwcsUsername, string(self.Name));
  FillPWideCharFromString(lpwcsServer, string(FServer));
  FillPWideCharFromString(lpwcsPassword, string(FAutoLoginPW));

  if Value then
    SetAutoWinlogon(lpwcsServer, Value, lpwcsUsername, lpwcsPassword)
  else
    RemoveAutoLogin(FServer);

  if (Assigned(lpwcsUsername)) then
    GlobalFree(HGLOBAL(lpwcsUsername));
  if (Assigned(lpwcsServer)) then
    GlobalFree(HGLOBAL(lpwcsServer));
  if (Assigned(lpwcsPassword)) then
    GlobalFree(HGLOBAL(lpwcsPassword));
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUser.SetInternetDomainTrustAccount(const Value: Boolean);
begin
  if Value then
    Fui3.usri3_flags := Fui3.usri3_flags or UF_INTERDOMAIN_TRUST_ACCOUNT
  else
    Fui3.usri3_flags := Fui3.usri3_flags and not UF_INTERDOMAIN_TRUST_ACCOUNT
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUser.SetNormalAccount(const Value: Boolean);
begin
  if Value then
    Fui3.usri3_flags := Fui3.usri3_flags or UF_NORMAL_ACCOUNT
  else
    Fui3.usri3_flags := Fui3.usri3_flags and not UF_NORMAL_ACCOUNT
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUser.SetTempDublicateAccount(const Value: Boolean);
begin
  if Value then
    Fui3.usri3_flags := Fui3.usri3_flags or UF_TEMP_DUPLICATE_ACCOUNT
  else
    Fui3.usri3_flags := Fui3.usri3_flags and not UF_TEMP_DUPLICATE_ACCOUNT
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUser.SetWorkstationTrustAccount(const Value: Boolean);
begin
  if Value then
    Fui3.usri3_flags := Fui3.usri3_flags or UF_WORKSTATION_TRUST_ACCOUNT
  else
    Fui3.usri3_flags := Fui3.usri3_flags and not UF_WORKSTATION_TRUST_ACCOUNT
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUser.SetServerTrustAccount(const Value: Boolean);
begin
  if Value then
    Fui3.usri3_flags := Fui3.usri3_flags or UF_SERVER_TRUST_ACCOUNT
  else
    Fui3.usri3_flags := Fui3.usri3_flags and not UF_SERVER_TRUST_ACCOUNT
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUser.SetDeactivated(const Value: Boolean);
begin
  if Value then
    Fui3.usri3_flags := Fui3.usri3_flags or UF_ACCOUNTDISABLE
  else
    Fui3.usri3_flags := Fui3.usri3_flags and not UF_ACCOUNTDISABLE
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUser.SetDontExpire(const Value: Boolean);
begin
  if Value then
    Fui3.usri3_flags := Fui3.usri3_flags or UF_DONT_EXPIRE_PASSWD
  else
    Fui3.usri3_flags := Fui3.usri3_flags and not UF_DONT_EXPIRE_PASSWD;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUser.SetDescription(const Value: WideString);
begin
  SysFreeString(Fui3.usri3_comment);
  Fui3.usri3_comment := SysAllocString(PWideChar(Value));
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUser.SetCantChangePW(const Value: Boolean);
begin
  if Value then
    Fui3.usri3_flags := Fui3.usri3_flags or UF_PASSWD_CANT_CHANGE
  else
    Fui3.usri3_flags := Fui3.usri3_flags and not UF_PASSWD_CANT_CHANGE;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUser.SetAutoLoginPW(const Value: WideString);
begin
  FAutoLoginPW := Value;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUser.SetName(const Value: WideString);
begin
  Initialize;
  SysFreeString(Fui3.usri3_name);
  Fui3.usri3_name := SysAllocString(PWideChar(Value));
end;

procedure TUser.SetFullName(const Value: WideString);
begin
  SysFreeString(Fui3.usri3_full_name);
  Fui3.usri3_full_name := SysAllocString(PWideChar(Value));
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUser.SetScriptPath(const Value: WideString);
begin
  SysFreeString(Fui3.usri3_script_path);
  Fui3.usri3_script_path := SysAllocString(PWideChar(Value));
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUser.SetPassword(const Value: WideString);
begin
  SysFreeString(Fui3.usri3_password);
  Fui3.usri3_password := SysAllocString(PWideChar(Value));
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUser.SetHideAccount(const Value: Boolean);
begin
  HideAccountFnc(FServer, self.GetName, Value);
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUser.SetMustChangePW(const Value: Boolean);
begin
  Fui3.usri3_password_expired := Ord(Value);
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUser.SetHomeDir(const Value: WideString);
begin
  SysFreeString(Fui3.usri3_home_dir);
  Fui3.usri3_home_dir := SysAllocString(PWideChar(Value));
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUser.AddToGroup(const Value: WideString);
var
  pSID              : Pointer;
  error             : Integer;
begin
  error := 0;
  FGroups := TGroupCollection.Create;
  try
    FGroups.GetUserGroups(self);
    // check whether user is in group
    // if not, add to group
    if not IsInGroup(Value, self.GetGroups) then
    begin
      if (GetAccountSid(FServer, self.GetName, pSID) = 0) and Assigned(pSID) then
      begin
        error := NetLocalGroupAddMembers(PWideChar(Server), PWideChar(Value), 0, @pSID, 1);
        FreeMemory(pSID);
        if (error <> NERR_SUCCESS) and (error <> 1378) then
          raise ENetAPIError.Create(error);
      end
      else
        raise ENetAPIError.Create(error);
    end;
  finally
    Fgroups.Free;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUser.RemoveFromGroup(const Value: WideString);
var
  error             : Integer;
  Member            : PLocalGroupMembersInfo3;
begin
  error := 0;
  FGroups := TGroupCollection.Create;
  try
    FGroups.GetUserGroups(self);
    // remover group from group list
    Self.FGroups.Delete(Value);
    // check whether user is in group
    // if user is not in group, remove from group
    if not IsInGroup(Value, self.GetGroups) then
    begin
      GetMem(Member, sizeof(TLocalGroupMembersInfo3));
      try
      //Self.FGroups.Delete(Value);  // 2006-12-08
        Member.lgrmi3_domainandname := PWideChar(copy(FServer, 3, length(FServer)) + '\' + self.GetName);
        error := NetLocalGroupDelMembers(PWideChar(FServer), PWideChar(Value), 3, Member, 1);
      finally
        FreeMem(Member, sizeof(TLocalGroupMembersInfo3));
      // ignore error if user is not in group
      // because we are iterating through all avaiable groups
        if (error <> NERR_Success) and (error <> ERROR_MEMBER_NOT_IN_ALIAS) then
          raise ENetAPIError.Create(error);
      end;
    end;
  finally
    Self.FGroups.Free;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUser.SetStrings(ui3: PUserInfo3);
begin
  with ui3^ do
  begin
    Fui3.usri3_name := SysAllocString(usri3_name);
    Fui3.usri3_home_dir := SysAllocString(usri3_home_dir);
    Fui3.usri3_comment := SysAllocString(usri3_comment);
    Fui3.usri3_script_path := SysAllocString(usri3_script_path);
    Fui3.usri3_full_name := SysAllocString(usri3_full_name);
    Fui3.usri3_usr_comment := SysAllocString(usri3_usr_comment);
    Fui3.usri3_parms := SysAllocString(usri3_parms);
    Fui3.usri3_workstations := SysAllocString(usri3_workstations);
    Fui3.usri3_logon_server := SysAllocString(usri3_logon_server);
    Fui3.usri3_profile := SysAllocString(usri3_profile);
    Fui3.usri3_home_dir_drive := SysAllocString(usri3_home_dir_drive);
    //Fui3.usri3_password := SysAllocString(usri3_password);
  end;
end;

////////////////////////////////////////////////////////////////////////////////

{ TUserCollection }

function TUserCollection.Add(Item: TUser): Integer;
begin
  Result := inherited Add(Item);
end;

////////////////////////////////////////////////////////////////////////////////

function TUserCollection.First: TUser;
begin
  Result := inherited First();
end;

////////////////////////////////////////////////////////////////////////////////

function TUserCollection.Get(Index: Integer): TUser;
begin
  Result := inherited Get(Index);
end;

////////////////////////////////////////////////////////////////////////////////

class function TUserCollection.GetAll(const Server: WideString;
  filter: DWord = FILTER_NORMAL_ACCOUNT): TUserCollection;
var
  bufPtr            : Pointer;
  pCurrent          : PUserInfo3;
  readCount, totalCount: DWord;
  error             : DWord;
  i                 : Integer;
begin
  Result := nil;
  if Server = '' then
    raise EArgumentNull.Create('Server');

  bufPtr := nil;
  try
    error := NetUserEnum(PWideChar(Server), 3, filter, bufPtr,
      MAX_PREFERRED_LENGTH, readCount, totalCount, nil);
    if (error <> NERR_SUCCESS) then
      raise ENetAPIError.Create(error);

    Result := TUserCollection.Create();
    pCurrent := bufPtr;
    Result.SetCapacity(readCount);
    for i := 0 to readCount - 1 do
    begin
      Result.Add(TUser.Create(Server, pCurrent));
      Inc(pCurrent);
    end;
  finally
    NetApiBufferFree(bufPtr);
  end;
end;

////////////////////////////////////////////////////////////////////////////////

class function TUserCollection.GetGroupMembers(Group: TGroup): TUserCollection;
var
  bufPtr            : Pointer;
  pCurrent          : PLocalGroupMembersInfo3;
  readCount, totalCount: DWord;
  error             : DWord;
  i                 : Integer;
begin
  Result := nil;
  if Group = nil then
    raise EArgumentNull.Create('Group');

  bufPtr := nil;
  try
    error := NetLocalGroupGetMembers(PWideChar(Group.Server), PWideChar(Group.Name),
      3, bufPtr, MAX_PREFERRED_LENGTH, readCount, totalCount, nil);
    if (error <> NERR_SUCCESS) then
      raise ENetAPIError.Create(error);

    Result := TUserCollection.Create();
    pCurrent := bufPtr;
    Result.SetCapacity(readCount);
    for i := 0 to readCount - 1 do
    begin
      Result.Add(TUser.Create(Group.Server, pCurrent));
      Inc(pCurrent);
    end;
  finally
    NetApiBufferFree(bufPtr);
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUser.Add;
const
  DOMAIN_GROUP_RID_USERS = $00000201;
var
  error             : DWORD;
begin
  Fui3.usri3_primary_group_id := DOMAIN_GROUP_RID_USERS;
  error := NetUserAdd(PWideChar(FServer), 3, @Fui3, nil);
  if error <> 0 then
    raise ENetAPIError.Create(error);
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUser.Save;
var
  error             : DWORD;
begin
  Fui3.usri3_logon_hours := nil;
  Fui3.usri3_acct_expires := TIMEQ_FOREVER;
  error := NetUserSetInfo(PWideChar(FServer), PWideChar(GetCaption), 3, @Fui3, nil);
  if error <> 0 then
    raise ENetAPIError.Create(error);
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUser.Del;
var
  error             : DWORD;
begin
  error := NetUserDel(PWideChar(FServer), PWideChar(self.GetCaption));
  if error <> 0 then
    raise ENetAPIError.Create(error);
end;

////////////////////////////////////////////////////////////////////////////////

function TUserCollection.IndexOf(Item: TUser): Integer;
begin
  Result := inherited IndexOf(Item);
end;

////////////////////////////////////////////////////////////////////////////////

procedure TUserCollection.Put(Index: Integer; const Value: TUser);
begin
  inherited Put(Index, Value);
end;

////////////////////////////////////////////////////////////////////////////////

{ TGroup }

constructor TGroup.Create(const Server: WideString; lgi0: PLocalGroupInfo0);
begin
  FServer := Server;
  Flgi0.lgrpi0_name := SysAllocString(lgi0^.lgrpi0_name);
end;

////////////////////////////////////////////////////////////////////////////////

constructor TGroup.Create(const Server: WideString; lgi1: TLocalGroupInfo1);
begin
  FServer := Server;
  Flgi1 := lgi1;
end;

////////////////////////////////////////////////////////////////////////////////

destructor TGroup.Destroy;
begin
  FMembers.Free;
  SysFreeString(Flgi0.lgrpi0_name);
  inherited;
end;

////////////////////////////////////////////////////////////////////////////////

function TGroup.GetCaption: WideString;
begin
  Result := Name;
end;

////////////////////////////////////////////////////////////////////////////////

function TGroup.GetChildList: TList;
begin
  Result := Members;
end;

////////////////////////////////////////////////////////////////////////////////

function TGroup.GetImageIndex: Integer;
begin
  Result := 2;
end;

////////////////////////////////////////////////////////////////////////////////

function TGroup.GetName: WideString;
begin
  Result := Flgi0.lgrpi0_name;
end;

////////////////////////////////////////////////////////////////////////////////

function TGroup.GetComment: WideString;
var
  bufPtr            : Pointer;
  error             : DWORD;
begin
  error := NetLocalGroupGetInfo(PWideChar(FServer), PWideChar(self.Name), 1, bufPtr);
  if (error <> NERR_SUCCESS) then
    raise ENetAPIError.Create(error);
  Result := PLocalGroupInfo1(bufPtr)^.lgrpi1_comment;
  NetApiBufferFree(bufPtr)
end;

////////////////////////////////////////////////////////////////////////////////

function TGroup.GetUsers: TUserCollection;
begin
  if FMembers = nil then
    FMembers := TUserCollection.GetGroupMembers(Self);
  Result := FMembers;
end;

///////////////////////////////////////////////////////////////////////////////

procedure TGroup.Add;
var
  error             : DWORD;
begin
  error := NetLocalGroupAdd(PWideChar(FServer), 1, @Flgi1, nil);
  if error <> NERR_SUCCESS then
    raise ENetAPIError.Create(error);
end;

///////////////////////////////////////////////////////////////////////////////

procedure TGroup.Del;
var
  error             : DWORD;
  Group             : WideString;
begin
  Group := Flgi1.lgrpi1_name;
  error := NetLocalGroupDel(PWideChar(FServer), PWideChar(Group));
  if error <> NERR_SUCCESS then
    raise ENetAPIError.Create(error);
end;

///////////////////////////////////////////////////////////////////////////////

{ TGroupCollection }

function TGroupCollection.Get(Index: Integer): TGroup;
begin
  Result := inherited Get(Index);
end;

////////////////////////////////////////////////////////////////////////////////

function TGroupCollection.Add(Item: TGroup): Integer;
begin
  Result := inherited Add(Item);
end;

////////////////////////////////////////////////////////////////////////////////

procedure TGroupCollection.Delete(const Group: WideString);
var
  i                 : Integer;
  s                 : WideString;
begin
  for i := self.Count - 1 downto 0 do
  begin
    s := self.Items[i].GetName;
    if Group = s then
    begin
      inherited Delete(i);
      exit;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

function TGroupCollection.First: TGroup;
begin
  Result := inherited First();
end;

////////////////////////////////////////////////////////////////////////////////

class function TGroupCollection.GetAll(const Server: WideString): TGroupCollection;
var
  bufPtr            : Pointer;
  pCurrent          : PLocalGroupInfo0;
  readCount, totalCount: DWord;
  error             : DWord;
  i                 : Integer;
begin
  Result := nil;
  if Server = '' then
    raise EArgumentNull.Create('Server');

  bufPtr := nil;
  try
    error := NetLocalGroupEnum(PWideChar(Server), 0, bufPtr, MAX_PREFERRED_LENGTH, readCount, totalCount, nil);
    if (error <> NERR_SUCCESS) then
      raise ENetAPIError(error);

    Result := TGroupCollection.Create();
    pCurrent := bufPtr;
    Result.SetCapacity(readCount);
    for i := 0 to readCount - 1 do
    begin
      Result.Add(TGroup.Create(Server, pCurrent));
      Inc(pCurrent);
    end;
  finally
    NetApiBufferFree(bufPtr)
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TGroupCollection.Put(Index: Integer; const Value: TGroup);
begin
  inherited Put(Index, Value);
end;

////////////////////////////////////////////////////////////////////////////////

function TGroupCollection.IndexOf(Item: TGroup): Integer;
begin
  Result := inherited IndexOf(Item);
end;

////////////////////////////////////////////////////////////////////////////////

class function TGroupCollection.GetUserGroups(User: TUser): TGroupCollection;
var
  bufPtr            : Pointer;
  pCurrent          : PLocalGroupInfo0;
  readCount, totalCount: DWord;
  error             : DWord;
  i                 : Integer;
begin
  Result := nil;
  if User = nil then
    raise EArgumentNull.Create('User');

  bufPtr := nil;
  try
    error := NetUserGetLocalGroups(PWideChar(User.Server), PWideChar(User.Name), 0, 0, bufPtr, MAX_PREFERRED_LENGTH,
      readCount, totalCount);
    if (error <> NERR_SUCCESS) then
      raise ENetAPIError.Create(error);

    Result := TGroupCollection.Create();
    pCurrent := bufPtr;
    Result.SetCapacity(readCount);
    for i := 0 to readCount - 1 do
    begin
      Result.Add(TGroup.Create(User.Server, pCurrent));
      Inc(pCurrent);
    end;
  finally
    NetApiBufferFree(bufPtr)
  end;
end;

{ TPrivilege }

constructor TPrivilege.Create(const Server, RightConstant: string);
begin
  FServer := Server;
  FRightConstant := RightConstant;
  self.SetDescription(RightConstant);
end;

function TPrivilege.GetDescription: string;
begin
  Result := self.FRightDescription;
end;

function TPrivilege.GetRightConstant: string;
begin
  result := self.FRightConstant;
end;

procedure TPrivilege.SetDescription(const RightConstant: string);
var
  languageID        : Cardinal;
  buffer            : array[0..256] of Char;
  bufSize           : Cardinal;
begin
  bufSize := sizeof(buffer);
  if LookupPrivilegeDisplayName(PChar(FServer), PChar(self.Constant), buffer, bufSize, languageID) then
    FRightDescription := string(buffer)
  else
    FRightDescription := self.Constant;
end;

{ TPrivilegeCollection }

function TPrivilegeCollection.Add(Item: TPrivilege): Integer;
begin
  Result := inherited Add(Item);
end;

function TPrivilegeCollection.Get(Index: Integer): TPrivilege;
begin
  Result := inherited Get(Index);
end;

class function TPrivilegeCollection.GetAll(const Server: WideString): TPrivilegeCollection;
var
  i                 : Integer;
begin
  Result := TPrivilegeCollection.Create;
  for i := 0 to length(PrivArray) - 1 do
  begin
    Result.Add(TPrivilege.Create(Server, PrivArray[i]));
  end;
end;

class function TPrivilegeCollection.GetUserPrivileges(const Server, User: WideString): TPrivilegeCollection;
var
  sid               : PSID;
  sidSize           : DWORD;
  sidNameUse        : SID_NAME_USE;
  domainName        : array[0..DNLEN + 1] of Char;
  domainNameSize    : DWORD;
  lsaComputerName   : TLsaUnicodeStr;
  lsaRights, p      : PLsaUnicodeString;
  objectAttributes  : TLsaObjectAttributes;
  policyHandle      : LSA_HANDLE;
  status            : NTSTATUS;
  rightsCount, i, err: Integer;
begin
  status := 0;
  Result := TPrivilegeCollection.Create;
  rightsCount := 0;
  sidSize := 65536;
  GetMem(sid, sidSize);
  try
    domainNameSize := DNLEN + 1;
    if LookupAccountName(PChar(string(Server)), PChar(string(User)), sid, sidSize, domainName, domainNameSize,
      sidNameUse) then
    begin
      ReallocMem(sid, sidSize);
      lsaComputerName := TLsaUnicodeStr.CreateFromStrW(Server);
      try
        FillChar(objectAttributes, sizeof(objectAttributes), 0);
        status := lsaapi.LsaOpenPolicy(lsaComputername.Value, ObjectAttributes, POLICY_LOOKUP_NAMES, PolicyHandle);
        if status = STATUS_SUCCESS then
        try
          status := LsaEnumerateAccountRights(PolicyHandle, sid, lsaRights, rightsCount);
          if status = STATUS_SUCCESS then
          try
            p := lsaRights;
            for i := 0 to rightsCount - 1 do
            begin
              Result.Add(TPrivilege.Create(Server, LsaUnicodeStringToStr(p^)));
              Inc(p)
            end;
          finally
            LsaFreeMemory(lsaRights)
          end
          else
          begin
            err := LsaNTStatusToWinError(status);
            if (err <> 2) and (err <> 5) then
              raise ENetAPIError.Create(err);
          end
        finally
          LsaClose(PolicyHandle)
        end
        else
        begin
          err := LsaNTStatusToWinError(status);
          raise ENetAPIError.Create(err);
        end;
      finally
        lsaComputerName.Free
      end
    end
    else
    begin
      err := LsaNTStatusToWinError(status);
      raise ENetAPIError.Create(err);
    end;
  finally
    FreeMem(sid)
  end;
end;

function TPrivilegeCollection.IndexOf(Item: TPrivilege): Integer;
begin
  Result := inherited IndexOf(Item);
end;

procedure TPrivilegeCollection.Put(Index: Integer; const Value: TPrivilege);
begin

end;

end.

