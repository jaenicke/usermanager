(*======================================================================*
 | Project  :                                                           |
 | Unit     : MpuNTUser.pas                                             |
 |                                                                      |
 | Notes    : Unit for administrating user-accounts on a NT machines.   |
 |                                                                      |
 |                                                                      |
 | Copyright (c) 2005, 2006 Michael Puff (MPu)                          |
 | Url      : http://www.michael-puff.de                                |
 | Mail     : mpuff@michael-puff.de                                     |
 |                                                                      |
 | Version  Date        By    Description                               |
 | -------  ----------  ----  ------------------------------------------|
 | 1.0      2003-12-08  MPu                                             |
 | 2.0      2004-10-01  MPu   Bugs fixed. Own header translations       |
 | 2.1      2004-10-20  MPu   Bugs fixed.                               |
 | 2.2      2004-10-24  Mpu   even more bugs fixed                      |
 | 2.3      2004-10-30  MPu   added GetMembersInGroup                   |
 | 2.4      2005-02-16  MPu   Fixed password bug                        |
 | 2.5      2005-10-12  MPu   added UserModalsGet                       |
 | 3.0      2005-11-14  MPu   Moved Usermanager API function            |
 |                            deklarations from MpuWinNT.pas to         |
 |                            MpuNTUser.pas                             |
 | 3.1      2006-03-01  MPu   StrSIDToName                              |
 | 4.0      2006-04-30  MPu   Callbacks                                 |
 |                                                                      |
 *======================================================================*)

(*======================================================================*
 |                                                                      |
 |                        COPYRIGHT NOTICE                              |
 |                                                                      |
 | Copyright (c) 2001-2005, Michael Puff ["copyright holder(s)"]        |
 | All rights reserved.                                                 |
 |                                                                      |
 | Redistribution and use in source and binary forms, with or without   |
 | modification, are permitted provided that the following conditions   |
 | are met:                                                             |
 |                                                                      |
 | 1. Redistributions of source code must retain the above copyright    |
 |    notice, this list of conditions and the following disclaimer.     |
 | 2. Redistributions in binary form must reproduce the above copyright |
 |    notice, this list of conditions and the following disclaimer in   |
 |    the documentation and/or other materials provided with the        |
 |    distribution.                                                     |
 | 3. The name(s) of the copyright holder(s) may not be used to endorse |
 |    or promote products derived from this software without specific   |
 |    prior written permission.                                         |
 |                                                                      |
 | THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS  |
 | "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT    |
 | LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS    |
 | FORA PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE        |
 | REGENTS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,          |
 | INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, |
 | BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;     |
 | LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER     |
 | CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT   |
 | LIABILITY, OR TORT INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY |
 | WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE          |
 | POSSIBILITY OF SUCH DAMAGE.                                          |
 |                                                                      |
 *======================================================================*)

{.$DEFINE USEREGFUNCTIONS}

{$I CompilerSwitches.inc}

unit MPuNTUser;

interface

uses
  windows,
{$IFDEF USEREGFUNCTIONS}
  MpuRegistry,
{$ENDIF}
  ActiveX;

type
  NET_API_STATUS = DWORD;

///// User account structures /////////////////////////////////////////////////

type
  LocalGroupInfo0 = record
    lgrpi0_name: LPWSTR;
  end;
  PLocalGroupInfo0 = ^LocalGroupInfo0;

type
  TUserInfo1 = record
    usri1_name: LPWSTR;
    usri1_password: LPWSTR;
    usri1_password_age: DWORD;
    usri1_priv: DWORD;
    usri1_home_dir: LPWSTR;
    usri1_comment: LPWSTR;
    usri1_flags: DWORD;
    usri1_script_path: LPWSTR;
  end;
  PUserInfo1 = ^TUserInfo1;

  TUserInfo3 = record
    usri3_name: LPWSTR;
    usri3_password: LPWSTR;
    usri3_password_age: DWORD;
    usri3_priv: DWORD;
    usri3_home_dir: LPWSTR;
    usri3_comment: LPWSTR;
    usri3_flags: DWORD;
    usri3_script_path: LPWSTR;
    usri3_auth_flags: DWORD;
    usri3_full_name: LPWSTR;
    usri3_usr_comment: LPWSTR;
    usri3_parms: LPWSTR;
    usri3_workstations: LPWSTR;
    usri3_last_logon: DWORD;
    usri3_last_logoff: DWORD;
    usri3_acct_expires: DWORD;
    usri3_max_storage: DWORD;
    usri3_units_per_week: DWORD;
    usri3_logon_hours: PBYTE;
    usri3_bad_pw_count: DWORD;
    usri3_num_logons: DWORD;
    usri3_logon_server: LPWSTR;
    usri3_country_code: DWORD;
    usri3_code_page: DWORD;
    usri3_user_id: DWORD;
    usri3_primary_group_id: DWORD;
    usri3_profile: LPWSTR;
    usri3_home_dir_drive: LPWSTR;
    usri3_password_expired: DWORD;
  end;
  PUserInfo3 = ^TUserInfo3;

  TUSER_MODALS_INFO_0 = record
    usrmod0_min_passwd_len: DWORD;
    usrmod0_max_passwd_age: DWORD;
    usrmod0_min_passwd_age: DWORD;
    usrmod0_force_logoff: DWORD;
    usrmod0_password_hist_len: DWORD;
  end;
  PUser_Modals_Info_0 = ^TUser_Modals_Info_0;

  TLocalGroupMembersInfo3 = record
    lgrmi3_domainandname: LPWSTR;
  end;
  PLocalGroupMembersInfo3 = ^TLocalGroupMembersInfo3;

  TGroupInfo0 = record
    grpi0_name: LPWSTR;
  end;
  PGroupInfo0 = ^TGroupInfo0;

const
  FILTER_TEMP_DUPLICATE_ACCOUNT = $0001;
  FILTER_NORMAL_ACCOUNT = $0002;
  FILTER_PROXY_ACCOUNT = $0004;
  FILTER_INTERDOMAIN_TRUST_ACCOUNT = $0008;
  FILTER_WORKSTATION_TRUST_ACCOUNT = $0010;
  FILTER_SERVER_TRUST_ACCOUNT = $0020;

  UF_PASSWD_CANT_CHANGE = $0040;
  UF_DONT_EXPIRE_PASSWD = $10000;
  UF_ACCOUNTDISABLE = $0002;

  TIMEQ_FOREVER     = DWord(-1);

//// Constants ////////////////////////////////////////////////////////////////

const
  MAX_PREFERRED_LENGTH = DWORD(-1);
  NERR_Success      = 0;
  NERR_BASE         = 2100;
  NERR_InvalidComputer = (NERR_BASE + 251);
  NERR_NotPrimary   = (NERR_BASE + 126);
  NERR_SpeGroupOp   = (NERR_BASE + 134);
  NERR_LastAdmin    = (NERR_BASE + 352);
  NERR_BadPassword  = (NERR_BASE + 103);
  NERR_PasswordTooShort = (NERR_BASE + 145);
  NERR_UserNotFound = (NERR_BASE + 121);
  NERR_GroupNotFound = (NERR_BASE + 120);

//// Callback Function prototypes //////////////////////////////////////////////////////

type
  TEnumUers = function(Username: string; cntUsers: Integer; Data: Pointer): Boolean;
  TEnumGroups = function(Group: string; cntGroups: Integer; Data: Pointer): Boolean;
  TEnumUserGroups = function(UserGroup: string; cntGroups: Integer; Data: Pointer): Boolean;
  TEnumMembers = function(Member: string; cntMembers: Integer; Data: Pointer): Boolean;

//// external function declarations ///////////////////////////////////////////

function NetUserGetLocalGroups(servername: LPCWSTR; username: LPCWSTR; level: DWORD; flags: DWORD; var bufptr:
  Pointer; prefmaxlen: DWORD; var entriesread: DWORD; var totalentries: DWORD): NET_API_STATUS; stdcall;
function NetLocalGroupEnum(servername: LPCWSTR; level: DWORD; var bufptr: Pointer; prefmaxlen: DWORD; var entriesread:
  DWORD; var totalentries: DWORD; resumehandle: PDWORD): NET_API_STATUS; stdcall;
function NetUserEnum(servername: LPCWSTR; level: DWORD; filter: DWORD; var buf: Pointer; prefmaxlen: DWORD; var
  entriesred: DWORD; var totalentries: DWORD; resumehandle: PDWORD): NET_API_STATUS; stdcall;
function NetLocalGroupGetMembers(servername: LPCWSTR; localgroupname: LPCWSTR; level: DWORD; var bufptr: Pointer;
  prefmaxlen: DWORD; var entriesread: DWORD; var totalentries: DWORD; resumehandle: PDWORD): NET_API_STATUS; stdcall;
function NetUserGetInfo(servername: LPCWSTR; username: LPCWSTR; level: DWORD; var bufptr: Pointer): NET_API_STATUS;
stdcall;
function NetUserAdd(severname: LPCWSTR; level: DWORD; buf: Pointer; parm_err: PDWORD): NET_API_STATUS; stdcall;
function NetUserSetInfo(servername: LPCWSTR; username: LPCWSTR; level: DWORD; buf: Pointer; parm_err: PDWORD):
  NET_API_STATUS; stdcall;
function NetUserDel(servername: LPCWSTR; username: LPCWSTR): NET_API_STATUS; stdcall;
function NetLocalGroupAddMembers(servername: LPCWSTR; groupname: LPCWSTR; level: DWORD; buf: Pointer; totalentries:
  DWORD): NET_API_STATUS; stdcall;
function NetLocalGroupDelMembers(servername: LPCWSTR; username: LPCWSTR; level: DWORD; buf: Pointer; totalentries:
  DWORD): NET_API_STATUS; stdcall;
function NetUserModalsGet(Servername: LPCWSTR; Level: DWORD; var bufptr: Pointer): DWORD; stdcall;
function NetApiBufferFree(Buffer: Pointer): NET_API_STATUS; stdcall;

//// Helper functions /////////////////////////////////////////////////////////

function GetAccountSid(const Server, User: WideString; var Sid: PSID): DWORD;
function StrSIDToName(const StrSID: WideString; var Name: string; var SIDType: DWORD): Boolean;

function EnumUserGroups(const Server, User: WideString; Callback: TEnumUserGroups; Data: Pointer): DWORD;
function EnumGroups(const Server: WideString; Callback: TEnumGroups; Data: Pointer): DWORD;
function EnumMembersInGroup(const Server: WideString; Group: WideString; Callback: TEnumMembers; Data: Pointer): DWORD;
function GetUserInfo(const Server, User: WideString; var ret: TUserInfo3): NET_API_STATUS;
function SetUserInfo(const Server, User: WideString; const UserInfo: TUserInfo3; PasswordHasChanged: Boolean):
  NET_API_STATUS;
function EnumUsers(const Server: WideString; filter: DWORD; Callback: TEnumUers; Data: Pointer): DWORD;
function AddUser(const Server, User, Password: WideString): NET_API_STATUS;
function DelUser(const Server, User: WideString): NET_API_STATUS;
function RemoveFromGroup(const Server, User, Group: WideString): NET_API_STATUS;
function AddToGroup(const Server, User, Group: WideString): NET_API_STATUS;
function IsAccountDisabled(const Server, User: WideString): Boolean;
function UserModalsGet(const Server: WideString): TUSER_MODALS_INFO_0;
function NetErrorStr(dwNetError: DWORD): string;

//// Registry functions ///////////////////////////////////////////////////////

{$IFDEF USEREGFUNCTIONS}
function AutoLogIn(Computer, User: string): Boolean;
function SetAutoLogin(const Machine, User, PW: string): LongInt;
function RemoveAutoLogin(const Machine: string): LongInt;
function HideAccount(const Computer, User: string; Hide: Boolean): LongInt;
function IsAccountHidden(const Machine, User: string): Boolean;
{$ENDIF}

implementation

const
  netapi32lib       = 'netapi32.dll';
  advapi32          = 'advapi32.dll';
  shlwapi           = 'shlwapi.dll';

function NetUserGetLocalGroups; external netapi32lib name
  'NetUserGetLocalGroups';
function NetLocalGroupEnum; external netapi32lib name 'NetLocalGroupEnum';
function NetUserEnum; external netapi32lib name 'NetUserEnum';
function NetLocalGroupGetMembers; external netapi32lib name
  'NetLocalGroupGetMembers';
function NetUserGetInfo; external netapi32lib name 'NetUserGetInfo';
function NetUserAdd; external netapi32lib name 'NetUserAdd';
function NetUserSetInfo; external netapi32lib name 'NetUserSetInfo';
function NetUserDel; external netapi32lib name 'NetUserDel';
function NetLocalGroupAddMembers; external netapi32lib name
  'NetLocalGroupAddMembers';
function NetLocalGroupDelMembers; external netapi32lib name
  'NetLocalGroupDelMembers';
function NetUserModalsGet; external netapi32lib name 'NetUserModalsGet';
function NetApiBufferFree; external netapi32lib name 'NetApiBufferFree';

function ConvertStringSidToSid(StringSid: PWideChar; var Sid: PSID): Boolean; stdcall; external 'advapi32.dll' name
  'ConvertStringSidToSidW';

(*
 * Procedure  : SysErrorMessage
 * Author     : MPu
 *)
function SysErrorMessage(ErrorCode: Integer): string;
var
  Len               : Integer;
  Buffer            : array[0..255] of Char;
begin
  Len := FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM or
    FORMAT_MESSAGE_ARGUMENT_ARRAY, nil, ErrorCode, 0, Buffer,
    SizeOf(Buffer), nil);
  while (Len > 0) and (Buffer[Len - 1] in [#0..#32, '.']) do
    Dec(Len);
  SetString(Result, Buffer, Len);
end;

(*
 * Procedure  : NetErrorStr
 * Author     : MPu
 *)
function NetErrorStr(dwNetError: DWORD): string;
var
  s, s1                 : string;
resourcestring
  rsERROR_ACCESS_DENIED = 'Zugriff verweigert';
  rsERROR_INVALID_PARAMETER = 'Ungültiger Parameter';
  rsNERR_InvalidComputer = 'Ungültiger Computer';
  rsNERR_NotPrimary =
    'Operation darf nur auf dem Domain-Controller ausgeführt werden';
  rsNERR_SpeGroupOp =
    'Operation darf nicht auf diese Gruppe angewandt werden';
  rsNERR_LastAdmin  =
    'Der letzte Administrator Account kann nicht gelöscht werden';
  rsNERR_BadPassword = 'Ungültiges Passwort';
  rsNERR_PasswordTooShort = 'Passwort zu kurz';
  rsNERR_UserNotFound = 'Ungültiger Benutzer';
  rsNERR_GroupNotFound = 'Gruppe nicht gefunden';
  rsERROR_NO_SUCH_MEMBER = 'Benutzer existiert nicht';
  rsERROR_INVALID_MEMBER = 'Ungültiges Konto';
  rsERROR_MEMBER_IN_ALIAS = 'Benutzer ist schon Mitglied dieser Gruppe';
  rsUnknownError    = 'unbekannter Fehler: ';
  rsErrorCode       = 'Fehlercode ';
begin
  case dwNetError of
    ERROR_ACCESS_DENIED: s := rsERROR_ACCESS_DENIED;
    ERROR_INVALID_PARAMETER: s := rsERROR_INVALID_PARAMETER;
    NERR_InvalidComputer: s := rsNERR_InvalidComputer;
    NERR_NotPrimary: s := rsNERR_NotPrimary;
    NERR_SpeGroupOp: s := rsNERR_SpeGroupOp;
    NERR_LastAdmin: s := rsNERR_LastAdmin;
    NERR_BadPassword: s := rsNERR_BadPassword;
    NERR_PasswordTooShort: s := rsNERR_BadPassword;
    NERR_UserNotFound: s := rsNERR_UserNotFound;
    NERR_GroupNotFound: s := rsNERR_GroupNotFound;
    ERROR_NO_SUCH_MEMBER: s := rsERROR_NO_SUCH_MEMBER;
    ERROR_INVALID_MEMBER: s := rsERROR_INVALID_MEMBER;
    ERROR_MEMBER_IN_ALIAS: s := rsERROR_MEMBER_IN_ALIAS;
  else
    s := rsUnknownError;
  end;
  Str(dwNetError, s1);
  result := rsErrorCode + s1 + ': ' + s;
end;

(*
 * Procedure  : GetAccountSid
 * Author     : MPu
 *)
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

(*
 * Procedure  : StrSIDToName
 * Author     : MPu
 *)
function StrSIDToName(const StrSID: Widestring; var Name: string; var SIDType: DWORD): Boolean;
var
  SID               : PSID;
  Buffer            : PChar;
  NameLen, TempLen  : Cardinal;
  err               : Boolean;
begin
  SID := nil;
  err := ConvertStringSIDToSID(PWideChar(StrSID), SID);
  if err then
  begin
    NameLen := 0;
    TempLen := 0;
    LookupAccountSidA(nil, SID, nil, NameLen, nil, TempLen, SIDType);
    GetMem(Buffer, NameLen);
    try
      err := LookupAccountSidA(nil, SID, Buffer, NameLen, nil, TempLen, SIDType);
      if err then
        SetString(Name, Buffer, Namelen);
    finally
      FreeMem(Buffer);
    end;
  end;
  if Assigned(SID) then
    LocalFree(Cardinal(SID));
  result := err;
end;

(*
 * Procedure  : EnumUserGroups
 * Author     : MPu
 * Enumrates the groups the specific user belongs to
 *)
function EnumUserGroups(const Server, User: WideString; Callback: TEnumUserGroups; Data: Pointer): DWORD;
var
  gui0, pWork       : Pointer;
  Loop              : Integer;
  NetError          : DWORD;
  EntriesRead, EntriesTotal: DWORD;
begin
  gui0 := nil;
  pWork := nil;
  try
    NetError := NetUserGetLocalGroups(PWideChar(Server), PWideChar(User),
      0, 0, gui0, MAX_PREFERRED_LENGTH, EntriesRead, EntriesTotal);
    if (NetError = NERR_SUCCESS) and (EntriesRead > 0) then
    begin
      pwork := gui0;
      if Assigned(Callback) then
      begin
        for Loop := 0 to EntriesRead - 1 do
        begin
          if not Callback(PGroupInfo0(gui0)^.grpi0_name, EntriesRead, Data) then
            break;
          Inc(Integer(gui0), sizeof(Pointer));
        end;
      end;
    end;
  finally
    NetApiBufferFree(pWork);
  end;
  Result := NetError;
end;

(*
 * Procedure  : EnumGroups
 * Author     : MPu
 * Enumerates local groups
 *)
function EnumGroups(const Server: WideString; Callback: TEnumGroups; Data: Pointer): DWORD;
var
  lgi01             : Pointer;
  pWork             : Pointer;
  EntriesRead       : DWORD;
  EntriesTotal      : DWORD;
  NetError          : DWORD;
  Loop              : Integer;
begin
  lgi01 := nil;
  pWork := nil;
  try
    NetError := NetLocalGroupEnum(PWideChar(Server), 0, lgi01, MAX_PREFERRED_LENGTH, EntriesRead, EntriesTotal, nil);
    if (NetError = NERR_SUCCESS) and (EntriesRead > 0) then
    begin
      pWork := lgi01;
      if Assigned(Callback) then
      begin
        for Loop := 0 to EntriesRead - 1 do
        begin
          if not Callback(PLocalGroupInfo0(lgi01)^.lgrpi0_name, EntriesRead, Data) then
            break;
          Inc(Integer(lgi01), sizeof(Pointer));
        end;
      end;
    end;
  finally
    NetApiBufferFree(pWork)
  end;
  Result := NetError;
end;

(*
 * Procedure  : GetUserInfo
 * Author     : MPu
 * gets user details
 *)
function GetUserInfo(const Server, User: WideString; var ret: TUserInfo3): NET_API_STATUS;
var
  ui3               : PUserInfo3;
  NetError          : DWORD;
begin
  ui3 := nil;
  NetError := 0;
  if User <> '' then
  begin
    try
      NetError := NetUserGetInfo(PWideChar(Server), PWideChar(User), 3,
        Pointer(ui3));
      if NetError = NERR_SUCCESS then
      begin
        with ret do
        begin
          usri3_flags := 0;
          usri3_name := SysAllocString(ui3^.usri3_name);
          usri3_full_name := SysAllocString(ui3^.usri3_full_name);
          usri3_comment := SysAllocString(ui3^.usri3_comment);
          usri3_home_dir := SysAllocString(ui3^.usri3_home_dir);
          usri3_script_path := SysAllocString(ui3^.usri3_script_path);

          usri3_password_age := ui3^.usri3_password_age;
          usri3_last_logon := ui3^.usri3_last_logon;
          usri3_num_logons := ui3^.usri3_num_logons;
          usri3_acct_expires := ui3^.usri3_acct_expires;
          usri3_max_storage := ui3^.usri3_max_storage;
          usri3_user_id := ui3^.usri3_user_id;
          usri3_bad_pw_count := ui3^.usri3_bad_pw_count;
          usri3_password_expired := ui3^.usri3_password_expired;

          if (DWORD(ui3^.usri3_flags and UF_PASSWD_CANT_CHANGE) =
            UF_PASSWD_CANT_CHANGE) then
            usri3_flags := usri3_flags or UF_PASSWD_CANT_CHANGE;
          if (DWORD(ui3^.usri3_flags and UF_DONT_EXPIRE_PASSWD) =
            UF_DONT_EXPIRE_PASSWD) then
            usri3_flags := usri3_flags or UF_DONT_EXPIRE_PASSWD;
          if (DWORD(ui3^.usri3_flags and UF_ACCOUNTDISABLE) =
            UF_ACCOUNTDISABLE) then
            usri3_flags := usri3_flags or UF_ACCOUNTDISABLE;
        end;
      end;
    finally
      NetApiBufferFree(ui3);
    end;
  end;
  result := NetError;
end;

(*
 * Procedure  : SetUserInfo
 * Author     : MPu
 * Sets user details
 *)
function SetUserInfo(const Server, User: WideString; const UserInfo:
  TUserInfo3; PasswordHasChanged: Boolean): NET_API_STATUS;
var
  ui3               : PUserInfo3;
  NetError          : DWORD;
begin
  ui3 := nil;
  NetError := 0;
  if User <> '' then
  begin
    try
      if NetUserGetInfo(PWideChar(Server), PWideChar(User), 3,
        Pointer(ui3)) = NERR_SUCCESS then
      begin
        with ui3^ do
        begin
          usri3_name := UserInfo.usri3_name;
          usri3_full_name := UserInfo.usri3_full_name;
          if PasswordHasChanged then
            usri3_password := UserInfo.usri3_password;
          usri3_home_dir := UserInfo.usri3_home_dir;
          usri3_comment := UserInfo.usri3_comment;
          usri3_usr_comment := UserInfo.usri3_usr_comment;
          usri3_priv := UserInfo.usri3_priv;
          usri3_script_path := UserInfo.usri3_script_path;
          usri3_auth_flags := UserInfo.usri3_auth_flags;
          usri3_parms := UserInfo.usri3_parms;
          usri3_workstations := UserInfo.usri3_workstations;
          usri3_acct_expires := UserInfo.usri3_acct_expires;
          usri3_max_storage := UserInfo.usri3_max_storage;
          usri3_home_dir_drive := UserInfo.usri3_home_dir_drive;
          usri3_profile := UserInfo.usri3_profile;
          usri3_password_expired := UserInfo.usri3_password_expired;
          usri3_flags := UserInfo.usri3_flags;
        end;
        NetError := NetUserSetInfo(PWideChar(Server), PWideChar(User), 3, ui3, nil);
      end;
    finally
      NetApiBufferFree(ui3);
    end;
  end;
  Result := NetError;
end;

(*
 * Procedure  : EnumUsers
 * Author     : MPu
 * Enumerates local users
 *)
function EnumUsers(const Server: WideString; filter: DWORD; Callback: TEnumUers; Data: Pointer): DWORD;
var
  ui1               : Pointer;
  pWork             : Pointer;
  EntriesRead       : DWORD;
  EntriesTotal      : DWORD;
  NetError          : DWORD;
  Loop              : Integer;
begin
  ui1 := nil;
  pWork := nil;
  try
    NetError := NetUserEnum(PWideChar(Server), 0, filter, ui1, MAX_PREFERRED_LENGTH, EntriesRead, EntriesTotal, nil);
    if (NetError = NERR_SUCCESS) and (EntriesRead > 0) then
    begin
      pWork := ui1;
      if Assigned(Callback) then
      begin
        for Loop := 0 to EntriesRead - 1 do
        begin
          if not Callback(PUserInfo1(ui1)^.usri1_name, EntriesRead, Data) then
            break;
          Inc(Integer(ui1), sizeof(Pointer));
        end;
      end;
    end;
  finally
    NetApiBufferFree(pWork);
  end;
  Result := NetError;
end;

(*
 * Procedure  : EnumMembersInGroup
 * Author     : MPu
 * Enumerates the members of a specific group
 *)
function EnumMembersInGroup(const Server: WideString; Group: WideString; Callback: TEnumMembers; Data: Pointer): DWORD;
var
  Member            : Pointer;
  pWork             : Pointer;
  EntriesRead       : DWORD;
  EntriesTotal      : DWORD;
  NetError          : NET_API_STATUS;
  Loop              : Integer;
begin
  Member := nil;
  pWork := nil;
  try
    NetError := NetLocalGroupGetMembers(PWideChar(Server), PWideChar(Group), 3, Member, MAX_PREFERRED_LENGTH,
      EntriesRead, EntriesTotal, nil);
    if (NetError = NERR_SUCCESS) and (EntriesRead > 0) then
    begin
      pWork := Member;
      if Assigned(Callback) then
      begin
        for Loop := 0 to EntriesRead - 1 do
        begin
          if not Callback(PLocalGroupMembersInfo3(Member)^.lgrmi3_domainandname, EntriesRead, Data) then
            break;
          Inc(Integer(Member), sizeof(Pointer));
        end;
      end;
    end;
  finally
    NetApiBufferFree(pWork);
  end;
  Result := NetError;
end;

(*
 * Procedure  : AddUser
 * Author     : MPu
 * Adds a local account
 *)
function AddUser(const Server, User, Password: WideString): NET_API_STATUS;
const
  DOMAIN_GROUP_RID_USERS = $00000201;
var
  ui3               : TUserInfo3;
  NetError          : DWORD;
begin
//  ui3 := nil;
  NetError := 0;
  if User <> '' then
  begin
    ZeroMemory(@ui3, sizeof(TUserInfo3));
    ui3.usri3_name := PWideChar(User);
    ui3.usri3_password := PWideChar(Password);
    ui3.usri3_primary_group_id := DOMAIN_GROUP_RID_USERS;
    NetError := NetUserAdd(PWideChar(Server), 3, @ui3, nil);
  end;
  result := NetError;
end;

(*
 * Procedure  : DelUser
 * Author     : MPu
 * Deletes a local account
 *)
function DelUser(const Server, User: WideString): NET_API_STATUS;
var
  NetError          : DWORD;
begin
  NetError := 0;
  if (Server <> '') and (User <> '') then
  begin
    NetError := NetUserDel(PWideChar(Server), PWideChar(User));
  end;
  result := NetError;
end;

(*
 * Procedure  : RemoveFromGroup
 * Author     : MPu
 * Removes a local account from a local group
 *)
function RemoveFromGroup(const Server, User, Group: WideString): NET_API_STATUS;
var
  Member            : PLocalGroupMembersInfo3;
  NetError          : DWORD;
begin
  NetError := 0;
  if (User <> '') and (Group <> '') and (Server <> '') then
  begin
    GetMem(Member, sizeof(TLocalGroupMembersInfo3));
    try
      Member.lgrmi3_domainandname := PWideChar(copy(Server, 3, length(Server)) + '\' + User);
      NetError := NetLocalGroupDelMembers(PWideChar(Server), PWideChar(Group), 3, Member, 1);
    finally
      FreeMem(Member, sizeof(TLocalGroupMembersInfo3));
    end;
  end;
  result := NetError;
end;

(*
 * Procedure  : AddToGroup
 * Author     : MPu
 * Adds a local account o a local group
 *)
function AddToGroup(const Server, User, Group: WideString): NET_API_STATUS;
var
  pSID              : Pointer;
  NetError          : DWORD;
begin
  pSID := nil;
  NetError := 0;
  if (User <> '') and (Group <> '') and (Server <> '') then
  begin
    if (GetAccountSid(Server, User, pSID) = 0) and Assigned(pSID) then
    begin
      NetError := NetLocalGroupAddMembers(PWideChar(Server), PWideChar(Group), 0, @pSID, 1);
      FreeMemory(pSID);
    end;
  end;
  result := NetError;
end;

(*
 * Procedure  : IsAccountDisabled
 * Author     : MPu
 *)
function IsAccountDisabled(const Server, User: WideString): Boolean;
var
  ui3               : PUserInfo3;
  NetError          : DWORD;
begin
  result := True;
  ui3 := nil;
  if User <> '' then
  begin
    try
      NetError := NetUserGetInfo(PWideChar(Server), PWideChar(User), 3, Pointer(ui3));
      if NetError = NERR_SUCCESS then
        result := (DWORD(ui3^.usri3_flags and UF_ACCOUNTDISABLE) = UF_ACCOUNTDISABLE);
    finally
      NetApiBufferFree(ui3);
    end;
  end;
end;

(*
 * Procedure  : UserModalsGet
 * Author     : MPu
 * Password stuff
 *)
function UserModalsGet(const Server: WideString): TUSER_MODALS_INFO_0;
var
  UserModalsInfo    : PUSER_MODALS_INFO_0;
  dwRet             : DWORD;
begin
  UserModalsInfo := nil;
  dwRet := NetUserModalsGet(nil, 0, Pointer(UserModalsInfo));
  if ((dwRet = NERR_Success) and Assigned(UserModalsInfo)) then
  begin
    result.usrmod0_min_passwd_len := UserModalsInfo.usrmod0_min_passwd_len;
    result.usrmod0_max_passwd_age := UserModalsInfo.usrmod0_max_passwd_age;
    result.usrmod0_min_passwd_age := UserModalsInfo.usrmod0_min_passwd_age;
    result.usrmod0_force_logoff := UserModalsInfo.usrmod0_force_logoff;
    result.usrmod0_password_hist_len := UserModalsInfo.usrmod0_password_hist_len;
    NetApiBufferFree(UserModalsInfo);
  end;
end;

{$IFDEF USEREGFUNCTIONS}

(*
 * Procedure  : AutoLogIn
 * Author     : MPu
 * Queries whether autologin ist enabled for the local user
 *)
function AutoLogIn(Computer, User: string): Boolean;
var
  MyReg             : TMpuRegistry;
  AutoLogon         : string;
  DefaultUsername   : string;
begin
  MyReg := TMpuRegistry.Create(Computer, HKEY_LOCAL_MACHINE);
  try
    with MyReg do
    begin
      Connect;
      if OpenKey('SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon', KEY_READ) = 0 then
      begin
        ReadString('AutoAdminLogon', AutoLogon);
        ReadString('DefaultUsername', DefaultUsername);
      end;
    end;
  finally
    MyReg.Free;
  end;
  result := (AutoLogon = '1') and (DefaultUsername = User);
end;

(*
 * Procedure  : SetAutoLogin
 * Author     : MPu
 * Enables autologin
 *)
function SetAutoLogin(const Machine, User, PW: string): LongInt;
var
  MyReg             : TMpuRegistry;
  ret               : LongInt;
begin
  MyReg := TMpuRegistry.Create(Machine, HKEY_LOCAL_MACHINE);
  try
    with MyReg do
    begin
      ret := Connect;
      if ret = 0 then
      begin
        ret := OpenKey('SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon', KEY_WRITE);
        if ret = 0 then
        begin
          WriteStringW('DefaultUsername', User);
          WriteStringW('DefaultPassword', PW);
          WriteStringW('AutoAdminLogon', '1');
        end;
      end;
    end;
  finally
    MyReg.Free;
  end;
  result := ret;
end;

(*
 * Procedure  : RemoveAutoLogin
 * Author     : MPu
 * Removes autologin entries from the registry
 *)
function RemoveAutoLogin(const Machine: string): LongInt;
var
  MyReg             : TMpuRegistry;
  ret               : LongInt;
begin
  MyReg := TMpuRegistry.Create(Machine, HKEY_LOCAL_MACHINE);
  try
    with MyReg do
    begin
      ret := Connect;
      if ret = 0 then
      begin
        ret := OpenKey('SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon', KEY_WRITE);
        if ret = 0 then
        begin
          ret := DeleteValueName('DefaultPassword');
          ret := WriteString('AutoAdminLogon', '0');
        end;
      end;
    end;
  finally
    MyReg.Free;
  end;
  result := ret;
end;

(*
 * Procedure  : IsAccountHidden
 * Author     : MPu
 *)
function IsAccountHidden(const Machine, User: string): Boolean;
var
  MyReg             : TMpuRegistry;
  ret               : Integer;
  Hidden            : LongInt;
begin
  result := False;
  MyReg := TMpuRegistry.Create(Machine, HKEY_LOCAL_MACHINE);
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

(*
 * Procedure  : HideAccount
 * Author     : MPu
 *)
function HideAccount(const Computer, User: string; Hide: Boolean): LongInt;
var
  MyReg             : TMpuRegistry;
  ret               : LongInt;
begin
  MyReg := TMpuRegistry.Create(Computer, HKEY_LOCAL_MACHINE);
  try
    with MyReg do
    begin
      ret := Connect;
      if ret = 0 then
      begin
        ret := CreateKey(HKEY_LOCAL_MACHINE,
          'SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList');
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

{$ENDIF}

end.

