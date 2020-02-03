(******************************************************************************
 *                                                                            *
 *  MpuTools.pas                                                              *
 *  Contains helper functions for programming without the VCL                 *
 *                                                                            *
 *  This Source Code Form is subject to the terms of the Mozilla Public       *
 *  License, v. 2.0. If a copy of the MPL was not distributed with this       *
 *  file, You can obtain one at http://mozilla.org/MPL/2.0/.                  *
 *                                                                            *
 *  Copyright (c) Michael Puff  http://www.michael-puff.de                    *
 *                                                                            *
 ******************************************************************************)
{$I CompilerSwitches.inc}

unit MpuTools;

interface

uses
  Windows,
  Messages,
  ShlObj,
  CommDlg,
  commctrl,
  ActiveX;

const
  fmOpenRead        = $0000;
  fmOpenWrite       = $0001;
  fmOpenReadWrite   = $0002;

  fmShareCompat     = $0000;
  fmShareExclusive  = $0010;
  fmShareDenyWrite  = $0020;
  fmShareDenyRead   = $0030;
  fmShareDenyNone   = $0040;

const
  CSIDL_FLAG_CREATE = $8000;
  CSIDL_ADMINTOOLS  = $0030;
  CSIDL_ALTSTARTUP  = $001D;
  CSIDL_APPDATA     = $001A;
  CSIDL_BITBUCKET   = $000A;
  CSIDL_CDBURN_AREA = $003B;
  CSIDL_COMMON_ADMINTOOLS = $002F;
  CSIDL_COMMON_ALTSTARTUP = $001E;
  CSIDL_COMMON_APPDATA = $0023;
  CSIDL_COMMON_DESKTOPDIRECTORY = $0019;
  CSIDL_COMMON_DOCUMENTS = $002E;
  CSIDL_COMMON_FAVORITES = $001F;
  CSIDL_COMMON_MUSIC = $0035;
  CSIDL_COMMON_PICTURES = $0036;
  CSIDL_COMMON_PROGRAMS = $0017;
  CSIDL_COMMON_STARTMENU = $0016;
  CSIDL_COMMON_STARTUP = $0018;
  CSIDL_COMMON_TEMPLATES = $002D;
  CSIDL_COMMON_VIDEO = $0037;
  CSIDL_CONTROLS    = $0003;
  CSIDL_COOKIES     = $0021;
  CSIDL_DESKTOP     = $0000;
  CSIDL_DESKTOPDIRECTORY = $0010;
  CSIDL_DRIVES      = $0011;
  CSIDL_FAVORITES   = $0006;
  CSIDL_FONTS       = $0014;
  CSIDL_HISTORY     = $0022;
  CSIDL_INTERNET    = $0001;
  CSIDL_INTERNET_CACHE = $0020;
  CSIDL_LOCAL_APPDATA = $001C;
  CSIDL_MYDOCUMENTS = $000C;
  CSIDL_MYMUSIC     = $000D;
  CSIDL_MYPICTURES  = $0027;
  CSIDL_MYVIDEO     = $000E;
  CSIDL_NETHOOD     = $0013;
  CSIDL_NETWORK     = $0012;
  CSIDL_PERSONAL    = $0005;
  CSIDL_PRINTERS    = $0004;
  CSIDL_PRINTHOOD   = $001B;
  CSIDL_PROFILE     = $0028;
  CSIDL_PROFILES    = $003E;
  CSIDL_PROGRAM_FILES = $0026;
  CSIDL_PROGRAM_FILES_COMMON = $002B;
  CSIDL_PROGRAMS    = $0002;
  CSIDL_RECENT      = $0008;
  CSIDL_SENDTO      = $0009;
  CSIDL_STARTMENU   = $000B;
  CSIDL_STARTUP     = $0007;
  CSIDL_SYSTEM      = $0025;
  CSIDL_TEMPLATES   = $0015;
  CSIDL_WINDOWS     = $0024;

const
{$EXTERNALSYM OPENFILENAME_SIZE_VERSION_400A}
  OPENFILENAME_SIZE_VERSION_400A = sizeof(TOpenFileNameA) -
    sizeof(pointer) - (2 * sizeof(dword));
{$EXTERNALSYM OPENFILENAME_SIZE_VERSION_400W}
  OPENFILENAME_SIZE_VERSION_400W = sizeof(TOpenFileNameW) -
    sizeof(pointer) - (2 * sizeof(dword));
{$EXTERNALSYM OPENFILENAME_SIZE_VERSION_400}
  OPENFILENAME_SIZE_VERSION_400 = OPENFILENAME_SIZE_VERSION_400A;

const
  BIF_NEWDIALOGSTYLE = $0040;

const
  TTS_BALLOON       = $40;

var
  hTooltip          : Cardinal;
  ti                : TToolInfo;

{$IFDEF CONDITIONALEXPRESSIONS}
{$if CompilerVersion >= 20}
 // Delphi 2009 oder höher
{$DEFINE TOSVERSIONINFOEX_DEFINED}
{$IFEND}
{$ENDIF}
{$IFNDEF TOSVERSIONINFOEX_DEFINED}
     
type
  POSVersionInfoEx = ^TOSVersionInfoEx;
  TOSVersionInfoEx = packed record
    dwOSVersionInfoSize: DWORD;
    dwMajorVersion: DWORD;
    dwMinorVersion: DWORD;
    dwBuildNumber: DWORD;
    dwPlatformId: DWORD;
    szCSDVersion: array[0..127] of AnsiChar;
    wServicePackMajor: Word;
    wServicePackMinor: Word;
    wSuiteMask: Word;
    wProductType: Byte;
    wReserved: Byte;
  end;
{$ENDIF} // TOSVERSIONINFOEX_DEFINED

const
  VER_SERVER_NT     = $80000000;
{$EXTERNALSYM VER_SERVER_NT}
  VER_WORKSTATION_NT = $40000000;
{$EXTERNALSYM VER_WORKSTATION_NT}
  VER_SUITE_SMALLBUSINESS = $00000001;
{$EXTERNALSYM VER_SUITE_SMALLBUSINESS}
  VER_SUITE_ENTERPRISE = $00000002;
{$EXTERNALSYM VER_SUITE_ENTERPRISE}
  VER_SUITE_BACKOFFICE = $00000004;
{$EXTERNALSYM VER_SUITE_BACKOFFICE}
  VER_SUITE_COMMUNICATIONS = $00000008;
{$EXTERNALSYM VER_SUITE_COMMUNICATIONS}
  VER_SUITE_TERMINAL = $00000010;
{$EXTERNALSYM VER_SUITE_TERMINAL}
  VER_SUITE_SMALLBUSINESS_RESTRICTED = $00000020;
{$EXTERNALSYM VER_SUITE_SMALLBUSINESS_RESTRICTED}
  VER_SUITE_EMBEDDEDNT = $00000040;
{$EXTERNALSYM VER_SUITE_EMBEDDEDNT}
  VER_SUITE_DATACENTER = $00000080;
{$EXTERNALSYM VER_SUITE_DATACENTER}
  VER_SUITE_SINGLEUSERTS = $00000100;
{$EXTERNALSYM VER_SUITE_SINGLEUSERTS}
  VER_SUITE_PERSONAL = $00000200;
{$EXTERNALSYM VER_SUITE_PERSONAL}
  VER_SUITE_BLADE   = $00000400;
{$EXTERNALSYM VER_SUITE_BLADE}
  VER_SUITE_EMBEDDED_RESTRICTED = $00000800;
{$EXTERNALSYM VER_SUITE_EMBEDDED_RESTRICTED}
  VER_SUITE_SECURITY_APPLIANCE = $00001000;
{$EXTERNALSYM VER_SUITE_SECURITY_APPLIANCE}

const
  VER_NT_WORKSTATION = $0000001;
{$EXTERNALSYM VER_NT_WORKSTATION}
  VER_NT_DOMAIN_CONTROLLER = $0000002;
{$EXTERNALSYM VER_NT_DOMAIN_CONTROLLER}
  VER_NT_SERVER     = $0000003;
{$EXTERNALSYM VER_NT_SERVER}

function StrToInt(s: string): Int64;
function StrToFloat(s: string): Extended;
function IntToStr(Int: Int64): string;
function FloatToStr(Value: Extended; Width, Decimals: Integer): string;
function Format(fmt: string; params: array of const): string;
function FormatW(const S: WideString; const Args: array of const): WideString;
function UpperCase(const S: string): string;
function LowerCase(const S: string): string;
function Trim(const S: WideString): WideString;
function StrIComp(const Str1, Str2: PChar): Integer; assembler;
function AnsiStrComp(S1, S2: PChar): Integer;
function AnsiStrIComp(S1, S2: PChar): Integer;

function FileExists(const FileName: string): Boolean;
function DirectoryExists(const Directory: string): Boolean;
function ChangeFileExt(const szFilename, szNewExt: string): string;
function ExtractFilepath(s: string): string;
function ExtractFilepathW(s: WideString): WideString;
function ExtractFilename(s: string): string;
function ExtractFilenameW(s: WideString): WideString;
function HasBackslash(Dir: string): Boolean;
function DelBackSlash(Dir: string): string;
function ForceDirectories(Dir: string): Boolean;
function GetFileSize(Filename: String): Int64;
function FileCreate(const FileName: string): Integer;
function FileOpen(const FileName: string; Mode: LongWord): Integer;
procedure FileClose(Handle: Integer);
function FileRead(Handle: Integer; var Buffer; Count: LongWord): Integer;
function FileSeek(Handle, Offset, Origin: Integer): Integer;
function FileWrite(Handle: Integer; const Buffer; Count: LongWord): Integer;
function GetFileVersion(const Filename: string): string;
function GetImageLinkTimeStamp(const FileName: string): DWORD;

function SysErrorMessage(ErrorCode: Integer): WideString;
procedure MyMessageBox(hWnd: HWND; caption, Text: WideString; IDIcon: DWORD);
procedure EnableControl(hParent: THandle; ID: DWORD; Enable: Boolean);
function LoadStr(ID: DWORD): string;
function LoadDLLStr(hDll: THandle; ID: DWORD): string;
function putbinrestohdd(binresname, path: string): Boolean;
function GetSystemFont: TLogFont;
function GetSystemFontName: WideString;
procedure ShowHelpText(hLib: THandle; wParam: WPARAM; lParam: LPARAM; hSB: HWND);
function CreateToolTips(hWnd: Cardinal; bBalloon: Boolean = False): Boolean;
procedure AddToolTip(hwnd, id: Cardinal; ti: PToolInfo; Text: string; Caption: string = ''; IDIcon: DWORD = 0);
procedure ProcessMessages(hWnd: DWORD);

function OpenFile(hParent: THandle; Filter: string): string;
function SaveFileAs(hParent: THandle; const Filter, Ext: string): string;
function GetFolder(hWnd: THandle; root: Integer; Caption: string; var Folder: string): DWORD;
function FindComputer(hWnd: THandle; Prompt: String; var Computer: String): boolean;
function FindDomain(hWnd: THandle; Prompt: String; var Domain: String): boolean;

function GetCurrUserName: string;
function GetCompName: string;
function IsAdmin: LongBool;
function GetWinDir(): string;
function GetSysDir(): string;
function GetShellFolder(CSIDL: integer): string;
function GetAppDir: string;
function IsNT5OrHigher: Boolean;
function GetOSVersionInfo(var Info: TOSVersionInfoEx): Boolean;
function GetOSVersionText: string;
function GetOSLanguageIDStr: string;
function GetOSLanguageStr: string;
function EnablePrivilege(const Privilege: string; fEnable: Boolean; out PreviousState: Boolean): DWORD;

function UnixTimeToDateString(i: PDWORD): string;
function UnixTimeToFileTime(t: LongWord): FILETIME;
function UnixTimeToTimeString(i: PDWORD): string;

function Min(x, y: Cardinal): Integer;

implementation

////////////////////////////////////////////////////////////////////////////////
//// SysUtils //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Procedure : StrToInt
// Comment   :

function StrToInt(s: string): Int64;
var
  code              : integer;
begin
  val(s, result, code);
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : StrToFloat
// Comment   :

function StrToFloat(s: string): Extended;
var
  code              : integer;
begin
  val(s, result, code);
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : IntToStr
// Comment   :

function IntToStr(Int: Int64): string;
begin
  Str(Int, result);
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : FloatToStr
// Comment   :

function FloatToStr(Value: Extended; Width, Decimals: Integer): string;
begin
  Str(Value: Width: Decimals, result);
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : Format
// Comment   : Formats a string according to the formatdiscriptors

function Format(fmt: string; params: array of const): string;
var
  pdw1, pdw2        : PDWORD;
  i                 : integer;
  pc                : PCHAR;
begin
  pdw1 := nil;
  if length(params) > 0 then
    GetMem(pdw1, length(params) * sizeof(Pointer));
  pdw2 := pdw1;
  for i := 0 to high(params) do
  begin
    pdw2^ := DWORD(PDWORD(@params[i])^);
    inc(pdw2);
  end;
  GetMem(pc, 1024 - 1);
  try
    ZeroMemory(pc, 1024 - 1);
    SetString(Result, pc, wvsprintf(pc, PCHAR(fmt), PCHAR(pdw1)));
  except
    Result := '';
  end;
  if (pdw1 <> nil) then
    FreeMem(pdw1);
  if (pc <> nil) then
    FreeMem(pc);
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : Format
// Comment   : Formats a widestring according to the formatdiscriptors
function FormatW(const S: WideString; const Args: array of const): WideString;
var
  StrBuffer2        : array[0..1023] of WideChar;
  A                 : array[0..15] of {$IFDEF Win64}PInt64{$ELSE}LongWord{$IFEND};
  i                 : Integer;
begin
  for i := High(Args) downto 0 do
    A[i] := Args[i].{$IFDEF Win64}VInt64{$ELSE}VInteger{$IFEND};
  wvsprintfW(@StrBuffer2, PWideChar(S), @A);
  Result := PWideChar(@StrBuffer2);
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : UpperCase
// Author    :
// Comment   :
function UpperCase(const S: string): string;
var
  Ch                : Char;
  L                 : Integer;
  Source, Dest      : PChar;
begin
  L := Length(S);
  SetLength(Result, L);
  Source := Pointer(S);
  Dest := Pointer(Result);
  while L <> 0 do
  begin
    Ch := Source^;
    if (Ch >= 'a') and (Ch <= 'z') then
      Dec(Ch, 32);
    Dest^ := Ch;
    Inc(Source);
    Inc(Dest);
    Dec(L);
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : LowerCase
// Author    :
// Comment   :
function LowerCase(const S: string): string;
var
  Ch                : Char;
  L                 : Integer;
  Source, Dest      : PChar;
begin
  L := Length(S);
  SetLength(Result, L);
  Source := Pointer(S);
  Dest := Pointer(Result);
  while L <> 0 do
  begin
    Ch := Source^;
    if (Ch >= 'A') and (Ch <= 'Z') then
      Inc(Ch, 32);
    Dest^ := Ch;
    Inc(Source);
    Inc(Dest);
    Dec(L);
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : Trim
// Author    :
// Comment   :
function Trim(const S: WideString): WideString;
var
  I, L              : Integer;
begin
  L := Length(S);
  I := 1;
  while (I <= L) and (S[I] <= ' ') do
    Inc(I);
  if I > L then
    Result := ''
  else
  begin
    while S[L] <= ' ' do
      Dec(L);
    Result := Copy(S, I, L - I + 1);
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : StrIComp
// Author    :
// Comment   :
function StrIComp(const Str1, Str2: PChar): Integer; assembler;
{$IFDEF  WIN64}
begin
  Result := AnsiStrIComp(Str1, Str2);
end;
{$ELSE}
asm
        PUSH    EDI
        PUSH    ESI
        MOV     EDI,EDX
        MOV     ESI,EAX
        MOV     ECX,0FFFFFFFFH
        XOR     EAX,EAX
        REPNE   SCASB
        NOT     ECX
        MOV     EDI,EDX
        XOR     EDX,EDX
@@1:    REPE    CMPSB
        JE      @@4
        MOV     AL,[ESI-1]
        CMP     AL,'a'
        JB      @@2
        CMP     AL,'z'
        JA      @@2
        SUB     AL,20H
@@2:    MOV     DL,[EDI-1]
        CMP     DL,'a'
        JB      @@3
        CMP     DL,'z'
        JA      @@3
        SUB     DL,20H
@@3:    SUB     EAX,EDX
        JE      @@1
@@4:    POP     ESI
        POP     EDI
end;
{$ENDIF}

////////////////////////////////////////////////////////////////////////////////
//  AnsiStrComp
//    AnsiStrComp compares S1 to S2, with case-sensitivity. The compare
//    operation is controlled by the current user locale. The return value
//    is the same as for CompareStr
//

function AnsiStrComp(S1, S2: PChar): Integer;
begin
  Result := CompareString(LOCALE_USER_DEFAULT, 0, S1, -1, S2, -1) - 2;
end;

////////////////////////////////////////////////////////////////////////////////
//
//  AnsiStrIComp
//    AnsiStrIComp compares S1 to S2, without case-sensitivity. The compare
//    operation is controlled by the current user locale. The return value
//    is the same as for CompareStr.
//

function AnsiStrIComp(S1, S2: PChar): Integer;
begin
  Result := CompareString(LOCALE_USER_DEFAULT, NORM_IGNORECASE, S1, -1,
    S2, -1) - 2;
end;

////////////////////////////////////////////////////////////////////////////////
//// AppTools //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Procedure : SysErrorMessage
// Comment   : Returns last error as formated string

function SysErrorMessage(ErrorCode: Integer): WideString;

  function MAKELANGID(usPrimaryLanguage, usSubLanguage: BYTE): WORD;
  begin
    Result := (usSubLanguage shl 10) or usPrimaryLanguage;
  end;

var
  MsgBuffer         : array[0..2047] of WideChar;
  len               : Integer;
begin
  len := FormatMessageW(FORMAT_MESSAGE_FROM_SYSTEM, nil, ErrorCode, MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
    MsgBuffer, sizeof(MsgBuffer), nil);

  if len > 0 then
  begin
    SetString(Result, MsgBuffer, len);
  end
  else
    Result := '';
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : MyMessageBox
// Comment   : Wrapper for MsgBoxParams

procedure MyMessageBox(hWnd: HWND; Caption, Text: WideString; IDIcon: DWORD);
var
  MsgInfo           : TMsgBoxParamsW;
begin
  MsgInfo.cbSize := SizeOf(TMsgBoxParams);
  MsgInfo.hwndOwner := hWnd;
  MsgInfo.hInstance := GetWindowLong(hWnd, GWL_HINSTANCE);
  MsgInfo.lpszText := @Text[1];
  MsgInfo.lpszCaption := @Caption[1];
  MsgInfo.dwStyle := MB_USERICON;
  MsgInfo.lpszIcon := MAKEINTRESOURCEW(IDICON);
  MessageBoxIndirectW(MsgInfo);
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : EnableControl
// Author    :
// Comment   :
procedure EnableControl(hParent: THandle; ID: DWORD; Enable: Boolean);
var
  hWnd              : THandle;
begin
  hWnd := GetFocus;
  // jump to next control if control to disable has the focus
  // otherwise we will get stuck and TAB won't work
  if hWnd = GetDlgItem(hParent, ID) then
    SendMessage(hParent, WM_NEXTDLGCTL, 0, 0);
  EnableWindow(GetDlgItem(hParent, ID), Enable);
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : LoadStr
// Comment   : Loads a resource string
function LoadStr(ID: DWORD): string;
var
  buffer            : array[0..255] of Char;
begin
  LoadString(hInstance, ID, buffer, 255);
  result := string(buffer);
end;

////////////////////////////////////////////////////////////////////////////////
//  LoadDLLStr
//  Comment: Loads a StringResource from a DLL
function LoadDLLStr(hDll: THandle; ID: DWORD): string;
var
  buffer            : array[0..255] of Char;
begin
  LoadString(hDll, ID, buffer, 255);
  result := string(buffer);
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : ProcessMessages
// Comment   : Replacement for ProcessMessages of TApplication
procedure ProcessMessages(hWnd: DWORD);
var
  Msg               : TMsg;
begin
  while PeekMessage(Msg, hWnd, 0, 0, PM_REMOVE) do
  begin
    TranslateMessage(Msg);
    DispatchMessage(Msg);
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : GetAppDir
// Author    :
// Comment   : uses ShlObj;
function GetAppDir: string;
var
  pidl              : PItemIdList;
  FolderPath        : string;
  SystemFolder      : Integer;
begin
  SystemFolder := CSIDL_APPDATA;
  if SUCCEEDED(SHGetSpecialFolderLocation(0, SystemFolder, pidl)) then
  begin
    SetLength(FolderPath, max_path);
    if SHGetPathFromIDList(pidl, PChar(FolderPath)) then
    begin
      SetLength(FolderPath, length(PChar(FolderPath)) + 1);
    end;
  end;
  Result := FolderPath;
end;

////////////////////////////////////////////////////////////////////////////////
//// UnixDateTimeTools /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Procedure : UnixTimeToDateString
// Comment   : Converts a Unixtimestamp to local systemtime
//             and returns a formated date string
function UnixTimeToDateString(i: PDWORD): string;
var
  umt               : DWORD;
  st                : TSystemTime;
  ft                : TFileTime;
  li                : ULARGE_INTEGER;
  buf               : array[0..255] of char;
begin
  result := '';
  if i = nil then
    exit;
  umt := i^;
  st.wYear := 1970;
  st.wMonth := 1;
  st.wDayOfWeek := 0;
  st.wDay := 1;
  st.wHour := 0;
  st.wMinute := 0;
  st.wSecond := 0;
  st.wMilliseconds := 0;
  SystemTimeToFileTime(st, ft);
  li.QuadPart := (umt * 10000000) + ULARGE_INTEGER(ft).QuadPart;
  ft.dwLowDateTime := li.LowPart;
  ft.dwHighDateTime := li.HighPart;
  FileTimeToSystemTime(ft, st);
  ZeroMemory(@buf, sizeof(buf));
  if (GetDateFormat(LOCALE_USER_DEFAULT, DATE_SHORTDATE, @st, nil, buf,
    sizeof(buf)) > 0) then
    Result := string(buf);
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : UnixTimeToTimeString
// Comment   : Converts a Unixtimestamp to local systemtime
//             and returns a formated time string
function UnixTimeToTimeString(i: PDWORD): string;
var
  umt               : int64;
  st                : SystemTime;
  ft                : FileTime;
  li                : ULARGE_INTEGER;
  buf               : array[0..255] of char;
begin
  result := '';
  if i = nil then
    exit;
  umt := i^;
  st.wYear := 1970;
  st.wMonth := 1;
  st.wDayOfWeek := 0;
  st.wDay := 1;
  st.wHour := 0;
  st.wMinute := 0;
  st.wSecond := 0;
  st.wMilliseconds := 0;
  SystemTimeToFileTime(st, ft);
  li.QuadPart := (umt * 10000000);
  ft.dwLowDateTime := li.LowPart;
  ft.dwHighDateTime := li.HighPart;
  FileTimeToSystemTime(ft, st);
  ZeroMemory(@buf, sizeof(buf));
  if (GetTimeFormat(LOCALE_USER_DEFAULT, TIME_FORCE24HOURFORMAT, @st, nil, buf,
    sizeof(buf)) > 0) then
    Result := string(buf);
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : UnixTimeToFileTime
// Comment   : Converts a UnixTimeStamp to a FILETIME stamp
function UnixTimeToFileTime(t: LongWord): FILETIME;
var
  ll                : int64;
begin
  ll := (Int64(t) * 10000000) + int64(116444736000000000);
  result.dwLowDateTime := LongWord(ll);
  result.dwHighDateTime := ll shr 32;
end;

////////////////////////////////////////////////////////////////////////////////
//// DialogTools ///////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Procedure : IsNT5OrHigher
// Author    : 
// Comment   :
function IsNT5OrHigher: Boolean;
var
  ovi               : TOSVERSIONINFO;
begin
  ZeroMemory(@ovi, sizeof(TOSVERSIONINFO));
  ovi.dwOSVersionInfoSize := SizeOf(TOSVERSIONINFO);
  GetVersionEx(ovi);
  if (ovi.dwPlatformId = VER_PLATFORM_WIN32_NT) and (ovi.dwMajorVersion >= 5) then
    result := TRUE
  else
    result := FALSE;
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : OpenFile
// Comment   : returns the selected file including its path
function OpenFile(hParent: THandle; Filter: string): string;
var
  ofn               : TOpenFilename;
  Buffer            : array[0..MAX_PATH - 1] of Char;
begin
  result := '';
  ZeroMemory(@Buffer[0], sizeof(Buffer));
  ZeroMemory(@ofn, sizeof(TOpenFilename));
  if IsNt5OrHigher then
    ofn.lStructSize := sizeof(TOpenFilename)
  else
    ofn.lStructSize := OPENFILENAME_SIZE_VERSION_400;
  ofn.hWndOwner := hParent;
  ofn.hInstance := hInstance;
  ofn.lpstrFile := @Buffer[0];
  ofn.nMaxFile := sizeof(Buffer);
  ofn.Flags := OFN_EXPLORER;
  ofn.lpstrFilter := PChar(Filter + #0#0);
  { Datei-Öffnen-Dialog aufrufen }
  if GetOpenFileName(ofn) then
    result := ofn.lpstrFile;
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : SaveFileAs
// Comment   : returns the selected file including its path
function SaveFileAs(hParent: THandle; const Filter, Ext: string): string;
var
  ofn               : TOpenFilename;
  Buffer            : array[0..MAX_PATH - 1] of Char;
begin
  result := '';
  ZeroMemory(@Buffer[0], sizeof(Buffer));
  ZeroMemory(@ofn, sizeof(TOpenFilename));
  if IsNt5OrHigher then
    ofn.lStructSize := sizeof(TOpenFilename)
  else
    ofn.lStructSize := OPENFILENAME_SIZE_VERSION_400;
  ofn.hWndOwner := hParent;
  ofn.hInstance := hInstance;
  ofn.lpstrFile := @Buffer[0];
  ofn.lpstrFilter := PChar(Filter+ #0#0);
  ofn.lpstrDefExt := PChar(Ext);
  ofn.nMaxFile := sizeof(Buffer);
  ofn.Flags := OFN_LONGNAMES;

  { Datei-Öffnen-Dialog aufrufen }
  if GetSaveFileName(ofn) then
    result := ofn.lpstrFile;
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : GetFolder
// Author    : 
// Comment   :
function GetFolder(hWnd: THandle; root: Integer; Caption: string; var Folder: string): DWORD;
var
  bi                : TBrowseInfo;
  lpBuffer          : PChar;
  pidlPrograms,
    pidlBrowse      : PItemIDList;
begin
  result := 0;
  if (not SUCCEEDED(SHGetSpecialFolderLocation(GetActiveWindow, root, pidlPrograms))) then
  begin
    result := GetLastError;
    exit;
  end;
  lpBuffer := GetMemory(MAX_PATH);
  if Assigned(lpBuffer) then
  begin
    try
      bi.hwndOwner := hWnd;
      bi.pidlRoot := pidlPrograms;
      bi.pszDisplayName := lpBuffer;
      bi.lpszTitle := PChar(Caption);
      bi.ulFlags := BIF_RETURNONLYFSDIRS;
      bi.lpfn := nil;
      bi.lParam := 0;
      pidlBrowse := SHBrowseForFolder(bi);
      if (pidlBrowse <> nil) then
        if SHGetPathFromIDList(pidlBrowse, lpBuffer) then
          Folder := string(lpBuffer);
    finally
      FreeMemory(lpBuffer);
    end;
  end
  else
    result := GetLastError;
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : FindComputer
// Author    : 
// Comment   :
function FindComputer(hWnd: THandle; Prompt: String; var Computer: String): boolean;
const
  BIF_NEWDIALOGSTYLE = $0040;
  BIF_USENEWUI      = BIF_NEWDIALOGSTYLE or BIF_EDITBOX;
  BIF_BROWSEINCLUDEURLS = $0080;
  BIF_UAHINT        = $0100;
  BIF_NONEWFOLDERBUTTON = $0200;
  BIF_NOTRANSLATETARGETS = $0400;
  BIF_SHAREABLE     = $8000;

  BFFM_IUNKNOWN     = 5;
  BFFM_SETOKTEXT    = WM_USER + 105; // Unicode only
  BFFM_SETEXPANDED  = WM_USER + 106; // Unicode only
var
  bi                : TBrowseInfo;
  ca                : array[0..MAX_PATH] of char;
  pidl, pidlSelected: PItemIDList;
  m                 : IMalloc;
begin
  if Failed(SHGetSpecialFolderLocation(hWnd, CSIDL_NETWORK, pidl)) then
  begin
    result := False;
    exit;
  end;
  try
    FillChar(bi, SizeOf(bi), 0);
    with bi do
    begin
      hwndOwner := hWnd;
      pidlRoot := pidl;
      pszDisplayName := ca;
      lpszTitle := PChar(Prompt);
      ulFlags := BIF_BROWSEFORCOMPUTER;
    end;
    pidlSelected := SHBrowseForFolder(bi);
    Result := Assigned(pidlSelected);
    if Result then
      Computer := '\\' + string(ca);
  finally
    if Succeeded(SHGetMalloc(m)) then
      m.Free(pidl);
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : FindDomain
// Comment   :
function FindDomain(hWnd: THandle; Prompt: String; var Domain: String): boolean;
const
  BIF_NEWDIALOGSTYLE = $0040;
  BIF_USENEWUI      = BIF_NEWDIALOGSTYLE or BIF_EDITBOX;
  BIF_BROWSEINCLUDEURLS = $0080;
  BIF_UAHINT        = $0100;
  BIF_NONEWFOLDERBUTTON = $0200;
  BIF_NOTRANSLATETARGETS = $0400;
  BIF_SHAREABLE     = $8000;

  BFFM_IUNKNOWN     = 5;
  BFFM_SETOKTEXT    = WM_USER + 105; // Unicode only
  BFFM_SETEXPANDED  = WM_USER + 106; // Unicode only
var
  bi                : TBrowseInfo;
  ca                : array[0..MAX_PATH] of char;
  pidl, pidlSelected: PItemIDList;
  m                 : IMalloc;
begin
  if Failed(SHGetSpecialFolderLocation(hWnd, CSIDL_NETWORK, pidl)) then
  begin
    result := False;
    exit;
  end;
  try
    FillChar(bi, SizeOf(bi), 0);
    with bi do
    begin
      hwndOwner := hWnd;
      pidlRoot := pidl;
      pszDisplayName := ca;
      lpszTitle := PChar(Prompt);
      ulFlags := BIF_DONTGOBELOWDOMAIN;
    end;
    pidlSelected := SHBrowseForFolder(bi);
    Result := Assigned(pidlSelected);
    if Result then
      Domain := string(ca);
  finally
    if Succeeded(SHGetMalloc(m)) then
      m.Free(pidl);
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//// FileTools /////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Procedure : FileExists
// Comment   : -
function FileExists(const FileName: string): Boolean;
var
  Attr: Cardinal;
begin
  Attr := GetFileAttributes(Pointer(Filename));
  Result := (Attr <> $FFFFFFFF) and (Attr and FILE_ATTRIBUTE_DIRECTORY = 0);
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : DirectoryExists
// Comment   : -
function DirectoryExists(const Directory: string): Boolean;
var
  Code: Cardinal;
begin
  Code := GetFileAttributes(PChar(Directory));
  Result := (Code <> $FFFFFFFF) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : ExtractFilename
// Comment   :
function ExtractFilename(s: string): string;
var
  i                 : integer;
begin
  result := s;
  for i := length(s) downto 1 do
    // Von hinten den Backslash suchen. Wenn gefunden alles ab Backslash kopieren
    if s[i] = '\' then
    begin
      result := copy(s, i + 1, length(s));
      // Nach dem ersten Backslash beenden
      break;
    end;
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : ExtractFilenameW
// Author    : MPö
// Comment   :
function ExtractFilenameW(s: WideString): WideString;
var
  i                 : integer;
begin
  result := s;
  for i := length(s) downto 1 do
    // Von hinten den Backslash suchen. Wenn gefunden alles ab Backslash kopieren
    if s[i] = '\' then
    begin
      result := copy(s, i + 1, length(s));
      // Nach dem ersten Backslash beenden
      break;
    end;
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : ExtractFilepath
// Comment   :
function ExtractFilepath(s: string): string;
var
  i                 : integer;
begin
  result := s;
  for i := length(s) downto 1 do
    // Von hinten den Backslash suchen. Wenn gefunden alles bis inkl. Backslash kopieren
    if s[i] = '\' then
    begin
      result := copy(s, 1, i);
      // Nach dem ersten Backslash beenden
      break;
    end;
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : ExtractFilepathW
// Author    : MPö
// Comment   :
function ExtractFilepathW(s: WideString): WideString;
var
  i                 : integer;
begin
  result := s;
  for i := length(s) downto 1 do
    // Von hinten den Backslash suchen. Wenn gefunden alles bis inkl. Backslash kopieren
    if s[i] = '\' then
    begin
      result := copy(s, 1, i);
      // Nach dem ersten Backslash beenden
      break;
    end;
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : HasBackslash
// Comment   : Checks whether path ends with a backslash or not
function HasBackslash(Dir: string): Boolean;
begin
  result := False;
  if length(Dir) > 0 then
    result := Dir[length(Dir)] = '\';
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : DelBackSlash
// Comment   : Removes the last backslash of a path
function DelBackSlash(Dir: string): string;
begin
  result := Dir;
  if (length(dir) > 0) and (Dir[length(Dir)] = '\') then
    SetLength(Result, Length(Result) - 1);
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : ForceDirectories
// Comment   : Creates directories and its subdirectories
function ForceDirectories(Dir: string): Boolean;
begin
  Result := True;
  if Length(Dir) = 0 then
    exit;
  if HasBackslash(Dir) then
    Dir := DelBackSlash(Dir);
  if (Length(Dir) < 3) or DirectoryExists(Dir)
    or (ExtractFilePath(Dir) = Dir) then
    Exit; // avoid 'xyz:\' problem.
  Result := ForceDirectories(ExtractFilePath(Dir)) and CreateDirectory(PChar(Dir), nil);
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : ChangeFileExt
// Comment   : Changes the file extension
function ChangeFileExt(const szFilename, szNewExt: string): string;
var
  rpos              : integer;
begin
  rpos := length(szFilename);
  if (pos('.', szFilename) > 0) then
    while (szFilename[rpos] <> '.') and (rpos > 0) do
      dec(rpos);

  Result := copy(szFilename, 1, rpos - 1) + szNewExt;
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : GetFileSize
// Comment   : Returns the filesize
function GetFileSize(Filename: String): Int64;
var
  fFile             : THandle;
  wfd               : TWIN32FINDDATA;
begin
  result := -1;
  if not FileExists(Filename) then
    exit;
  fFile := FindFirstfile(pchar(Filename), wfd);
  if fFile = INVALID_HANDLE_VALUE then
    exit;
  result := (wfd.nFileSizeHigh * (Int64(MAXDWORD) + 1)) + wfd.nFileSizeLow;
  windows.FindClose(fFile);
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : FileCreate
// Author    : 
// Comment   :
function FileCreate(const FileName: string): Integer;
begin
  Result := Integer(CreateFile(PChar(FileName), GENERIC_READ or GENERIC_WRITE,
    0, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0));
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : FileOpen
// Comment   : Opens a file. Returns its handle
function FileOpen(const FileName: string; Mode: LongWord): Integer;
const
  AccessMode        : array[0..2] of LongWord = (
    GENERIC_READ,
    GENERIC_WRITE,
    GENERIC_READ or GENERIC_WRITE);
  ShareMode         : array[0..4] of LongWord = (
    0,
    0,
    FILE_SHARE_READ,
    FILE_SHARE_WRITE,
    FILE_SHARE_READ or FILE_SHARE_WRITE);
begin
  Result := Integer(CreateFile(PChar(FileName), AccessMode[Mode and 3],
    ShareMode[(Mode and $F0) shr 4], nil, OPEN_EXISTING,
    FILE_ATTRIBUTE_NORMAL, 0));
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : FileSeek
// Comment   : Positions the filepointer
function FileSeek(Handle, Offset, Origin: Integer): Integer;
begin
  Result := SetFilePointer(THandle(Handle), Offset, nil, Origin);
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : FileRead
// Comment   : Reads the given amount of bytes into a buffer
function FileRead(Handle: Integer; var Buffer; Count: LongWord): Integer;
begin
  if not ReadFile(THandle(Handle), Buffer, Count, LongWord(Result), nil) then
    Result := -1;
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : FileWrite
// Comment   : Writes the buffer into the file
function FileWrite(Handle: Integer; const Buffer; Count: LongWord): Integer;
begin
  if not WriteFile(THandle(Handle), Buffer, Count, LongWord(Result), nil) then
    Result := -1;
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : FileClose
// Comment   : Closes the file handle open with FileOpen
procedure FileClose(Handle: Integer);
begin
  CloseHandle(THandle(Handle));
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : putbinrestohdd
// Comment   : Writes a binary resource to HDD
function putbinrestohdd(binresname, path: string): Boolean;
var
  hi, hg, ResSize,
    SizeWritten, hFile: cardinal;
begin
  result := false;
  hi := FindResource(hInstance, @binresname[1], 'BINRES');
  if hi <> 0 then
  begin
    hg := LoadResource(hInstance, hi);
    if hg <> 0 then
    begin
      ResSize := SizeofResource(hInstance, hi);
      hFile := CreateFile(@path[1], GENERIC_READ or GENERIC_WRITE,
        FILE_SHARE_READ or FILE_SHARE_WRITE, nil, CREATE_ALWAYS,
        FILE_ATTRIBUTE_ARCHIVE, 0);
      if hFile <> INVALID_HANDLE_VALUE then
      try
        result := (WriteFile(hFile, LockResource(HG)^, ResSize,
          SizeWritten, nil) and (SizeWritten = ResSize));
      finally
        CloseHandle(hFile);
      end;
    end;
  end;
end;

function GetSystemFont: TLogFont;
begin
  GetObject(GetStockObject(DEFAULT_GUI_FONT), sizeof(Result), @Result);
end;

function GetSystemFontName: WideString;
var
  ncMetrics: TNonClientMetricsW;
begin
  ncMetrics.cbSize := SizeOf(TNonClientMetricsW);
  SystemParametersInfo(SPI_GETNONCLIENTMETRICS, SizeOf(TNonClientMetricsW), @ncMetrics, 0);
  //Result := ncMetrics.
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : GetFileVersion
// Comment   :
function GetFileVersion(const Filename: string): string;
type
  PDWORDArr = ^DWORDArr;
  DWORDArr = array[0..0] of DWORD;
var
  VerInfoSize       : DWORD;
  VerInfo           : Pointer;
  VerValueSize      : DWORD;
  VerValue          : PVSFixedFileInfo;
  LangID            : DWORD;
begin
  result := '';
  VerInfoSize := GetFileVersionInfoSize(PChar(Filename), LangID);
  if VerInfoSize <> 0 then
  begin
    VerInfo := Pointer(GlobalAlloc(GPTR, VerInfoSize));
    if Assigned(VerInfo) then
    try
      if GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo) then
      begin
        if VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize) then
        begin
          with VerValue^ do
          begin
            result := Format('%d.%d.%d.%d', [dwFileVersionMS shr 16, dwFileVersionMS and $FFFF,
              dwFileVersionLS shr 16, dwFileVersionLS and $FFFF]);
          end;
        end
        else
          result := '';
      end;
    finally
      GlobalFree(THandle(VerInfo));
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : GetImageLinkTimeStamp
// Author    : NBe
// Comment   : Get the 'link time stamp' of an portable executable image file (PE32)
//             (written for Delphi 5, some types missing in Windows.pas of Delphi 4)
function GetImageLinkTimeStamp(const FileName: string): DWORD;
const
  INVALID_SET_FILE_POINTER = DWORD(-1);
  BorlandMagicTimeStamp = $2A425E19; // Delphi 4-6 (and above?)
  FileTime1970      : TFileTime = (dwLowDateTime: $D53E8000; dwHighDateTime: $019DB1DE);
type
  PImageSectionHeaders = ^TImageSectionHeaders;
  TImageSectionHeaders = array[Word] of TImageSectionHeader;
type
  PImageResourceDirectory = ^TImageResourceDirectory;
  TImageResourceDirectory = packed record
    Characteristics: DWORD;
    TimeDateStamp: DWORD;
    MajorVersion: Word;
    MinorVersion: Word;
    NumberOfNamedEntries: Word;
    NumberOfIdEntries: Word;
  end;
var
  FileHandle        : THandle;
  BytesRead         : DWORD;
  ImageDosHeader    : TImageDosHeader;
  ImageNtHeaders    : TImageNtHeaders;
  SectionHeaders    : PImageSectionHeaders;
  Section           : Word;
  ResDirRVA         : DWORD;
  ResDirSize        : DWORD;
  ResDirRaw         : DWORD;
  ResDirTable       : TImageResourceDirectory;
  FileTime          : TFileTime;
begin
  Result := 0;
  // Open file for read access
  FileHandle := CreateFile(PChar(FileName), GENERIC_READ, FILE_SHARE_READ, nil,
    OPEN_EXISTING, 0, 0);
  if (FileHandle <> INVALID_HANDLE_VALUE) then
  try
    // Read MS-DOS header to get the offset of the PE32 header
    // (not required on WinNT based systems - but mostly available)
    if not ReadFile(FileHandle, ImageDosHeader, SizeOf(TImageDosHeader),
      BytesRead, nil) or (BytesRead <> SizeOf(TImageDosHeader)) or
      (ImageDosHeader.e_magic <> IMAGE_DOS_SIGNATURE) then
    begin
      ImageDosHeader._lfanew := 0;
    end;
    // Read PE32 header (including optional header
    if (SetFilePointer(FileHandle, ImageDosHeader._lfanew, nil, FILE_BEGIN) =
      INVALID_SET_FILE_POINTER) then
    begin
      Exit;
    end;
    if not (ReadFile(FileHandle, ImageNtHeaders, SizeOf(TImageNtHeaders),
      BytesRead, nil) and (BytesRead = SizeOf(TImageNtHeaders))) then
    begin
      Exit;
    end;
    // Validate PE32 image header
    if (ImageNtHeaders.Signature <> IMAGE_NT_SIGNATURE) then
    begin
      Exit;
    end;
    // Seconds since 1970 (UTC)
    Result := ImageNtHeaders.FileHeader.TimeDateStamp;

    // Check for Borland's magic value for the link time stamp
    // (we take the time stamp from the resource directory table)
    if (ImageNtHeaders.FileHeader.TimeDateStamp = BorlandMagicTimeStamp) then
      with ImageNtHeaders, FileHeader, OptionalHeader do
      begin
        // Validate Optional header
        if (SizeOfOptionalHeader < IMAGE_SIZEOF_NT_OPTIONAL_HEADER) or
          (Magic <> IMAGE_NT_OPTIONAL_HDR_MAGIC) then
        begin
          Exit;
        end;
        // Read section headers
        SectionHeaders :=
          GetMemory(NumberOfSections * SizeOf(TImageSectionHeader));
        if Assigned(SectionHeaders) then
        try
          if (SetFilePointer(FileHandle,
            SizeOfOptionalHeader - IMAGE_SIZEOF_NT_OPTIONAL_HEADER, nil,
            FILE_CURRENT) = INVALID_SET_FILE_POINTER) then
          begin
            Exit;
          end;
          if not (ReadFile(FileHandle, SectionHeaders^, NumberOfSections *
            SizeOf(TImageSectionHeader), BytesRead, nil) and (BytesRead =
            NumberOfSections * SizeOf(TImageSectionHeader))) then
          begin
            Exit;
          end;
          // Get RVA and size of the resource directory
          with DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE] do
          begin
            ResDirRVA := VirtualAddress;
            ResDirSize := Size;
          end;
          // Search for section which contains the resource directory
          ResDirRaw := 0;
          for Section := 0 to NumberOfSections - 1 do
            with SectionHeaders[Section] do
              if (VirtualAddress <= ResDirRVA) and
                (VirtualAddress + SizeOfRawData >= ResDirRVA + ResDirSize) then
              begin
                ResDirRaw := PointerToRawData - (VirtualAddress - ResDirRVA);
                Break;
              end;
          // Resource directory table found?
          if (ResDirRaw = 0) then
          begin
            Exit;
          end;
          // Read resource directory table
          if (SetFilePointer(FileHandle, ResDirRaw, nil, FILE_BEGIN) =
            INVALID_SET_FILE_POINTER) then
          begin
            Exit;
          end;
          if not (ReadFile(FileHandle, ResDirTable,
            SizeOf(TImageResourceDirectory), BytesRead, nil) and
            (BytesRead = SizeOf(TImageResourceDirectory))) then
          begin
            Exit;
          end;
          // Convert from DosDateTime to SecondsSince1970
          if DosDateTimeToFileTime(HiWord(ResDirTable.TimeDateStamp),
            LoWord(ResDirTable.TimeDateStamp), FileTime) then
          begin
            // FIXME: Borland's linker uses the local system time
            // of the user who linked the executable image file.
            // (is that information anywhere?)
            Result := (ULARGE_INTEGER(FileTime).QuadPart -
              ULARGE_INTEGER(FileTime1970).QuadPart) div 10000000;
          end;
        finally
          FreeMemory(SectionHeaders);
        end;
      end;
  finally
    CloseHandle(FileHandle);
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//// GUITools //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Procedure : ShowHelpText
// Author    : 
// Comment   :
procedure ShowHelpText(hLib: THandle; wParam: WPARAM; lParam: LPARAM; hSB: HWND);
var
  bla               : array of Cardinal;
begin
  if BOOL(HIWORD(wParam) and MF_POPUP) or
    BOOL(HIWORD(wParam) and MF_SEPARATOR) or
    (HIWORD(wParam) = $FFFF) {// leave menu} then
    SendMessage(hSB, SB_SIMPLE, 0, 0)
  else
    MenuHelp(WM_MENUSELECT, wParam, lParam, HMENU(lParam), hLib, hSB, @bla);
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : CreateToolTips
// Comment   : Creates a Tooltip-Window
function CreateToolTips(hWnd: Cardinal; bBalloon: Boolean = False): Boolean;
const
  TTF_PARSELINKS    = $1000;
var
  Styles            : DWORD;
begin
  Styles := TTS_ALWAYSTIP;
  if bBalloon then
    Styles := Styles or TTS_BALLOON;
  result := False;
  hToolTip := CreateWindowEx(0, 'Tooltips_Class32', nil, Styles,
    Integer(CW_USEDEFAULT), Integer(CW_USEDEFAULT), Integer(CW_USEDEFAULT),
    Integer(CW_USEDEFAULT), hWnd, 0, hInstance, nil);
  if hToolTip <> 0 then
  begin
    SetWindowPos(hToolTip, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or
      SWP_NOSIZE or SWP_NOACTIVATE);
    ti.cbSize := SizeOf(TToolInfo);
    ti.uFlags := TTF_SUBCLASS or TTF_PARSELINKS;
    ti.hInst := hInstance;
    result := True;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : AddToolTip
// Comment   : Adds a tooltip to a window
procedure AddToolTip(hwnd, id: Cardinal; ti: PToolInfo; Text: String; Caption: String = ''; IDIcon: DWORD = 0);
const
  TTM_SETTITLE      = WM_USER + 32;
var
  Item              : THandle;
  Rect              : TRect;
begin
  Item := GetDlgItem(hWnd, id);
  if (Item <> 0) and (GetClientRect(Item, Rect)) then
  begin
    //ZeroMemory(@ti, sizeof(TToolInfo));
    ti.hwnd := Item;
    ti.Rect := Rect;
    ti.lpszText := PChar(Text);
    SendMessage(hToolTip, TTM_ADDTOOL, 0, Integer(ti));
    SendMessage(hToolTip, TTM_SETTITLE, IDIcon, Integer(@Caption[1]));
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//// WinTools //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Procedure : GetWinDir
// Comment   : Returns the Windows directory
function GetWinDir(): string;
begin
  SetLength(Result, MAX_PATH + 1);
  SetLength(Result, GetWindowsDirectory(PChar(Result), MAX_PATH));
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : ComputerName
// Comment   : Returns the computername
function GetCompName: string;
var
  Buf               : array[0..MAX_COMPUTERNAME_LENGTH] of Char;
  Size              : DWORD;
begin
  Size := SizeOf(Buf);
  if GetComputerName(Buf, Size) then
    Result := Buf
  else
    Result := '';
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : ExpandEnvStr
// Comment   : Mathias Simmack
function ExpandEnvStr(const szInput: string): string;
const
  MAXSIZE = 32768;
begin
  SetLength(Result,MAXSIZE);
  SetLength(Result,ExpandEnvironmentStrings(pchar(szInput),
    @Result[1],length(Result)));
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : UserName
// Comment   : Returns the name of the currently loggon user
function GetCurrUserName: string;
var
  Size              : DWORD;
begin
  Size := MAX_COMPUTERNAME_LENGTH + 1;
  SetLength(Result, Size);
  if GetUserName(PChar(Result), Size) then
    SetLength(Result, Size)
  else
    Result := '';
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : GetSysDir
// Comment   : Returns the System directory
function GetSysDir(): string;
begin
  SetLength(Result, MAX_PATH + 1);
  SetLength(Result, GetSystemDirectory(PChar(Result), MAX_PATH));
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : GetOSLanguageID
// Comment   : Returns the language of the OS
function GetOSLanguageStr: string;
begin
  SetLength(Result, MAX_PATH);
  SetLength(Result, VerLanguageName(GetSystemDefaultLangId,
    @Result[1], length(Result)));
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : GetOSLanguageStr
// Comment   : Returns the language ID-String
function GetOSLanguageIDStr: string;
var
  Buffer            : array[0..MAX_PATH] of char;
  len               : Integer;
begin
  ZeroMemory(@Buffer, sizeof(Buffer));
  len := GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_SABBREVLANGNAME, Buffer,
    sizeof(Buffer));
  SetString(result, Buffer, len);
end;

////////////////////////////////////////////////////////////////////////////////
//  GetShellFolder
//  Returns the special shell folders
//  uses: ActiveX, ShlObj;
function GetShellFolder(CSIDL: integer): string;
var
  pidl              : PItemIdList;
  FolderPath        : string;
  SystemFolder      : Integer;
  Malloc            : IMalloc;
begin
  Malloc := nil;
  FolderPath := '';
  SHGetMalloc(Malloc);
  if Malloc = nil then
  begin
    Result := FolderPath;
    Exit;
  end;
  try
    SystemFolder := CSIDL;
    if SUCCEEDED(SHGetSpecialFolderLocation(0, SystemFolder, pidl)) then
    begin
      SetLength(FolderPath, max_path);
      if SHGetPathFromIDList(pidl, PChar(FolderPath)) then
      begin
        SetLength(FolderPath, length(PChar(FolderPath)));
      end;
    end;
    Result := FolderPath;
  finally
    Malloc.Free(pidl);
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : GetAdminSid
// Author    : NBe
// Comment   :
function GetAdminSid: PSID;
const
  // bekannte SIDs ... (WinNT.h)
  SECURITY_NT_AUTHORITY: TSIDIdentifierAuthority = (Value: (0, 0, 0, 0, 0, 5));
  // bekannte RIDs ... (WinNT.h)
  SECURITY_BUILTIN_DOMAIN_RID: DWORD = $00000020;
  DOMAIN_ALIAS_RID_ADMINS: DWORD = $00000220;
begin
  Result := nil;
  AllocateAndInitializeSid(SECURITY_NT_AUTHORITY, 2,
    SECURITY_BUILTIN_DOMAIN_RID, DOMAIN_ALIAS_RID_ADMINS,
    0, 0, 0, 0, 0, 0, Result);
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : IsAdmin
// Author    : NBe
// Comment   :
function IsAdmin: LongBool;
var
  TokenHandle       : THandle;
  ReturnLength      : DWORD;
  TokenInformation  : PTokenGroups;
  AdminSid          : PSID;
  Loop              : Integer;
begin
  Result := False;
  TokenHandle := 0;
  if OpenProcessToken(GetCurrentProcess, TOKEN_QUERY, TokenHandle) then
  try
    ReturnLength := 0;
    GetTokenInformation(TokenHandle, TokenGroups, nil, 0, ReturnLength);
    TokenInformation := GetMemory(ReturnLength);
    if Assigned(TokenInformation) then
    try
      if GetTokenInformation(TokenHandle, TokenGroups, TokenInformation,
        ReturnLength, ReturnLength) then
      begin
        AdminSid := GetAdminSid;
        for Loop := 0 to TokenInformation^.GroupCount - 1 do
        begin
          if EqualSid(TokenInformation^.Groups[Loop].Sid, AdminSid) then
          begin
            Result := True;
            Break;
          end;
        end;
        FreeSid(AdminSid);
      end;
    finally
      FreeMemory(TokenInformation);
    end;
  finally
    CloseHandle(TokenHandle);
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : GetOSVersionInfo
// Author    : NBe
// Comment   :
function GetOSVersionInfo(var Info: TOSVersionInfoEx): Boolean;
begin
  FillChar(Info, SizeOf(TOSVersionInfoEx), 0);
  Info.dwOSVersionInfoSize := SizeOf(TOSVersionInfoEx);
  Result := GetVersionEx(TOSVersionInfo(Addr(Info)^));
  if (not Result) then
  begin
    FillChar(Info, SizeOf(TOSVersionInfoEx), 0);
    Info.dwOSVersionInfoSize := SizeOf(TOSVersionInfoEx);
    Result := GetVersionEx(TOSVersionInfo(Addr(Info)^));
    if (not Result) then
      Info.dwOSVersionInfoSize := 0;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : GetOSVersionText
// Author    : NBe
// Comment   :
function GetOSVersionText: string;
var
  Info              : TOSVersionInfoEx;
  Key               : HKEY;
begin
  Result := '';
  if (not GetOSVersionInfo(Info)) then
    Exit;
  case Info.dwPlatformId of
    { Win32s }
    VER_PLATFORM_WIN32s:
      Result := 'Microsoft Win32s';
    { Windows 9x }
    VER_PLATFORM_WIN32_WINDOWS:
      if (Info.dwMajorVersion = 4) and (Info.dwMinorVersion = 0) then
      begin
        Result := 'Microsoft Windows 95';
        if (Info.szCSDVersion[1] in ['B', 'C']) then
          Result := Result + ' OSR2';
      end
      else if (Info.dwMajorVersion = 4) and (Info.dwMinorVersion = 10) then
      begin
        Result := 'Microsoft Windows 98';
        if (Info.szCSDVersion[1] = 'A') then
          Result := Result + ' SE';
      end
      else if (Info.dwMajorVersion = 4) and (Info.dwMinorVersion = 90) then
        Result := 'Microsoft Windows Millennium Edition';
    { Windows NT }
    VER_PLATFORM_WIN32_NT:
      begin
        { Version }
        if (Info.dwMajorVersion = 5) and (Info.dwMinorVersion = 2) then
          Result := 'Microsoft Windows Server 2003'
        else if (Info.dwMajorVersion = 5) and (Info.dwMinorVersion = 1) then
          Result := 'Microsoft Windows XP'
        else if (Info.dwMajorVersion = 5) and (Info.dwMinorVersion = 0) then
          Result := 'Microsoft Windows 2000'
        else
          Result := 'Microsoft Windows NT';
        { Extended }
        if (Info.dwOSVersionInfoSize >= SizeOf(TOSVersionInfoEx)) then
        begin
          { ProductType }
          if (Info.wProductType = VER_NT_WORKSTATION) then
          begin
            if (Info.dwMajorVersion = 4) then
              Result := Result + #10'Workstation 4.0'
            else if (Info.wSuiteMask and VER_SUITE_PERSONAL <> 0) then
              Result := Result + #10'Home Edition'
            else
              Result := Result + #10'Professional';
          end
          else if (Info.wProductType = VER_NT_SERVER) then
          begin
            if (Info.dwMajorVersion = 5) and (Info.dwMinorVersion = 2) then
            begin
              if (Info.wSuiteMask and VER_SUITE_DATACENTER <> 0) then
                Result := Result + #10'Datacenter Edition'
              else if (Info.wSuiteMask and VER_SUITE_ENTERPRISE <> 0) then
                Result := Result + #10'Enterprise Edition'
              else if (Info.wSuiteMask = VER_SUITE_BLADE) then
                Result := Result + #10'Web Edition'
              else
                Result := Result + #10'Standard Edition';
            end
            else if (Info.dwMajorVersion = 5) and (Info.dwMinorVersion = 0) then
            begin
              if (Info.wSuiteMask and VER_SUITE_DATACENTER <> 0) then
                Result := Result + #10'Datacenter Server'
              else if (Info.wSuiteMask and VER_SUITE_ENTERPRISE <> 0) then
                Result := Result + #10'Advanced Server'
              else
                Result := Result + #10'Server';
            end
            else
            begin
              Result := Result + #10'Server ' +
                IntToStr(Info.dwMajorVersion) + '.' +
                IntToStr(Info.dwMinorVersion);
              if (Info.wSuiteMask and VER_SUITE_ENTERPRISE <> 0) then
                Result := Result + ', Enterprise Edition';
            end;
          end;
        end;
        { CSDVersion }
        if (Info.dwMajorVersion = 4) and
          (StrIComp(Info.szCSDVersion, 'Service Pack 6') = 0) and
          (RegOpenKeyEx(HKEY_LOCAL_MACHINE,
          'SOFTWARE\Microsoft\Windows NT\CurrentVersion\Hotfix\Q246009', 0,
          KEY_QUERY_VALUE, Key) = ERROR_SUCCESS) then
        begin
          Result := Result + #10'Service Pack 6a';
          RegCloseKey(Key);
        end
        else
          Result := Result + #10 + string(Info.szCSDVersion);
        Result := Result + #10'(Build ' +
          IntToStr(Info.dwBuildNumber and $FFFF) + ')';
      end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : EnablePrivilege
// Author    : 
// Comment   :
function EnablePrivilege(const Privilege: string; fEnable: Boolean; out PreviousState: Boolean): DWORD;
var
  Token             : THandle;
  NewState          : TTokenPrivileges;
  Luid              : TLargeInteger;
  PrevState         : TTokenPrivileges;
  Return            : DWORD;
begin
  PreviousState := True;
  if (GetVersion() > $80000000) then
    // Win9x
    Result := ERROR_SUCCESS
  else
  begin
    // WinNT
    if not OpenProcessToken(GetCurrentProcess(), MAXIMUM_ALLOWED, Token) then
      Result := GetLastError()
    else
    try
      if not LookupPrivilegeValue(nil, PChar(Privilege), Luid) then
        Result := GetLastError()
      else
      begin
        NewState.PrivilegeCount := 1;
        NewState.Privileges[0].Luid := Luid;
        if fEnable then
          NewState.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED
        else
          NewState.Privileges[0].Attributes := 0;
        if not AdjustTokenPrivileges(Token, False, NewState,
          SizeOf(TTokenPrivileges), PrevState, Return) then
          Result := GetLastError()
        else
        begin
          Result := ERROR_SUCCESS;
          PreviousState :=
            (PrevState.Privileges[0].Attributes and SE_PRIVILEGE_ENABLED <> 0);
        end;
      end;
    finally
      CloseHandle(Token);
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// Procedure : Min
// Author    : 
// Comment   :
function Min(x, y: Cardinal): Integer;
begin
  if x < y then
    result := x
  else
    result := y;
end;

end.
