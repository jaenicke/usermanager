(******************************************************************************
 *                                                                            *
 *  NetAPI -- NetAPI function declarations                                    *
 *                                                                            *
 *  This Source Code Form is subject to the terms of the Mozilla Public       *
 *  License, v. 2.0. If a copy of the MPL was not distributed with this       *
 *  file, You can obtain one at http://mozilla.org/MPL/2.0/.                  *
 *                                                                            *
 *  Copyright (c) 2006 Michael Puff  http://www.michael-puff.de               *
 *                                                                            *
 ******************************************************************************)

{$I ..\..\CompilerSwitches.inc}

unit NetAPI;

interface

uses
  windows,
  MpuTools;


function GetOS(const Computer: WideString): string;
function GetServerCommentW(const Computer: WideString; var Comment: WideString): DWORD;

type
  NET_API_STATUS = DWORD;

type
  TLocalGroupInfo0 = record
    lgrpi0_name: LPWSTR;
  end;
  PLocalGroupInfo0 = ^TLocalGroupInfo0;

  TLocalGroupInfo1 = record
    lgrpi1_name: LPWSTR;
    lgrpi1_comment: LPWSTR;
  end;
  PLocalGroupInfo1 = ^TLocalGroupInfo1;

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

  UF_TEMP_DUPLICATE_ACCOUNT = $0100;
  UF_NORMAL_ACCOUNT = $0200;
  UF_INTERDOMAIN_TRUST_ACCOUNT = $0800;
  UF_WORKSTATION_TRUST_ACCOUNT = $1000;
  UF_SERVER_TRUST_ACCOUNT = $2000;

  TIMEQ_FOREVER     = DWord(-1);

  DNLEN             = 15;

///// Network stuff //////////////////////////////////////////////////////////////

type
  PGroupInfo0 = ^TGroupInfo0;
  _GROUP_INFO_0 = record
    grpi0_name: LPWSTR;
  end;
  TGroupInfo0 = _GROUP_INFO_0;
  GROUP_INFO_0 = _GROUP_INFO_0;

type
  TSERVER_INFO_101 = packed record
    sv101_platform_ID: DWORD;
    sv101_name: PWChar;
    sv101_version_major: DWORD;
    sv101_version_minor: DWORD;
    sv101_type: DWORD; // not yet defined here!
    sv101_comment: PWChar;
  end;
  PSERVER_INFO_101 = ^TSERVER_INFO_101;

const
  MAX_PREFERRED_LENGTH = DWORD(-1);
  NERR_SUCCESS      = 0;
  NERR_BASE         = 2100;
  NERR_InvalidComputer = (NERR_BASE + 251);
  NERR_NotPrimary   = (NERR_BASE + 126);
  NERR_SpeGroupOp   = (NERR_BASE + 134);
  NERR_LastAdmin    = (NERR_BASE + 352);
  NERR_BadPassword  = (NERR_BASE + 103);
  NERR_PasswordTooShort = (NERR_BASE + 145);
  NERR_UserNotFound = (NERR_BASE + 121);
  NERR_GroupNotFound = (NERR_BASE + 120);

function NetUserGetLocalGroups(servername: LPCWSTR; username: LPCWSTR; level: DWORD; flags: DWORD; var bufptr: Pointer;
  prefmaxlen: DWORD; var entriesread: DWORD; var totalentries: DWORD): NET_API_STATUS; stdcall;
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
function NetLocalGroupGetInfo(severname: LPCWSTR; groupname: LPCWSTR; level: DWORD; var bufptr: Pointer): NET_API_STATUS;
function NetLocalGroupAddMembers(servername: LPCWSTR; groupname: LPCWSTR; level: DWORD; buf: Pointer; totalentries:
  DWORD): NET_API_STATUS; stdcall;
function NetLocalGroupDelMembers(servername: LPCWSTR; username: LPCWSTR; level: DWORD; buf: Pointer; totalentries:
  DWORD): NET_API_STATUS; stdcall;
function NetUserModalsGet(Servername: LPCWSTR; Level: DWORD; var bufptr: Pointer): DWORD; stdcall;
function NetLocalGroupAdd(servername: LPCWSTR; Level: DWORD; buf: Pointer; parm_err: PDWORD): NET_API_STATUS; stdcall;
function NetLocalGroupDel(servername: LPCWSTR; groupname: LPCWSTR): NET_API_STATUS; stdcall;

function NetWkstaGetInfo(const servername: PWChar; const level: DWord; const bufptr: Pointer): NET_API_STATUS; stdcall;

function NetServerGetInfo(const servername: PWChar; level: DWORD; bufptr: Pointer): NET_API_STATUS; stdcall;

function NetApiBufferFree(Buffer: Pointer): NET_API_STATUS; stdcall;

implementation

const
  netapi32lib       = 'netapi32.dll';

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
function NetLocalGroupGetInfo; external netapi32lib name 'NetLocalGroupGetInfo';
function NetLocalGroupAddMembers; external netapi32lib name
  'NetLocalGroupAddMembers';
function NetLocalGroupDelMembers; external netapi32lib name
  'NetLocalGroupDelMembers';
function NetUserModalsGet; external netapi32lib name 'NetUserModalsGet';
function NetLocalGroupAdd; external netapi32lib name 'NetLocalGroupAdd';
function NetLocalGroupDel; external netapi32lib name 'NetLocalGroupDel';

function NetWkstaGetInfo; external netapi32lib name 'NetWkstaGetInfo';
function NetServerGetInfo; external netapi32lib name 'NetServerGetInfo';

function NetApiBufferFree; external netapi32lib name 'NetApiBufferFree';

////////////////////////////////////////////////////////////////////////////////

function GetOS(const Computer: WideString): string;
var
  res               : DWORD;
  s                 : string;
  si                : Pointer;
  Major             : DWORD;
  Minor             : DWORD;
resourcestring
  rsErrorOSUnknown = 'Betriebssystem unbekannt';
begin
  si := nil;
  s := '';
  res := NetServerGetInfo(PWideChar(Computer), 101, @si);
  if res = NERR_Success then
  begin
    Major := PSERVER_INFO_101(si)^.sv101_version_major;
    Minor := PSERVER_INFO_101(si)^.sv101_version_minor;
    if (Major = 4) and (Minor = 0) then
    begin
      s := 'Windows NT 4.0';
    end
    else if (Major = 5) and (Minor = 0) then
    begin
      s := 'Windows 2000';
    end
    else if (Major = 5) and (Minor = 1) then
    begin
      s := 'Windows XP';
    end
    else if (Major = 5) and (Minor = 2) then
    begin
      s := 'Windows 2003 Server Family';
    end
    else if (Major = 6) and (Minor = 0) then
      s := 'Windows Vista'
	else if (Major = 6) and (Minor = 1) then
      s := 'Windows 7'
    else
      s := rsErrorOSUnknown;

    NetApiBufferFree(si);
  end
  else
    s := rsErrorOSUnknown;
  result := s;
end;

////////////////////////////////////////////////////////////////////////////////

function GetServerCommentW(const Computer: WideString; var Comment: WideString): DWORD;
var
  res               : DWORD;
  si                : Pointer;
begin
  si := nil;
  res := NetServerGetInfo(PWideChar(Computer), 101, @si);
  if res = NERR_Success then
  begin
    comment := PSERVER_INFO_101(si)^.sv101_comment;
  end;
  NetApiBufferFree(si);
  result := res;
end;

end.

