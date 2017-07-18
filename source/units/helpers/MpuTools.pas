(******************************************************************************
 *                                                                            *
 *  Eigene Funktiosnsammlung                                                  *
 *  Own function collection                                                   *
 *                                                                            *
 *  This Source Code Form is subject to the terms of the Mozilla Public       *
 *  License, v. 2.0. If a copy of the MPL was not distributed with this       *
 *  file, You can obtain one at http://mozilla.org/MPL/2.0/.                  *
 *                                                                            *
 *  Copyright (c) 2010 Michael Puff  http://www.michael-puff.de               *
 *                                                                            *
 ******************************************************************************)

unit MpuTools;

interface

uses
  Windows,
  Messages,
  SysUtils,
  ShlObj, // GetShellFolder
  ActiveX; // GetShellFolder

function FormatW(fmt: WideString; params: array of const): WideString;
function ExtractFilepathW(s: WideString): WideString;
function ExtractFilenameW(s: WideString): WideString;
function GetImageLinkTimeStamp(const FileName: string): DWORD;
procedure MyMessageBox(hWnd: HWND; caption, Text: string; IDIcon: DWORD);
function LoadResStr(hInstance: THandle; ID: DWORD): string;
function PutBinresToHDD(binresname, path: string): Boolean;
procedure ProcessMessages(hWnd: DWORD);
function GetCurrentUserName: string;
function GetCompName: string;
function IsAdmin: LongBool;
function GetWinDir(): string;
function GetSysDir(): string;
function GetTempDir: string;
function GetShellFolder(CSIDL: integer): string;
function GetAppDir: string;
function IsNT5OrHigher: Boolean;
function GetOSDisplayString: string;
function GetOSLanguageIDStr: string;
function GetOSLanguageStr: string;
procedure EnablePrivilege(const Privilege: string; fEnable: Boolean; out PreviousState: Boolean);
function UnixTimeToDateString(i: PDWORD): string;
function UnixTimeToFileTime(t: LongWord): FILETIME;
function UnixTimeToTimeString(i: PDWORD): string;

const
  CSIDL_FLAG_CREATE = $8000;
  CSIDL_ADMINTOOLS = $0030;
  CSIDL_ALTSTARTUP = $001D;
  CSIDL_APPDATA = $001A;
  CSIDL_BITBUCKET = $000A;
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
  CSIDL_CONTROLS = $0003;
  CSIDL_COOKIES = $0021;
  CSIDL_DESKTOP = $0000;
  CSIDL_DESKTOPDIRECTORY = $0010;
  CSIDL_DRIVES = $0011;
  CSIDL_FAVORITES = $0006;
  CSIDL_FONTS = $0014;
  CSIDL_HISTORY = $0022;
  CSIDL_INTERNET = $0001;
  CSIDL_INTERNET_CACHE = $0020;
  CSIDL_LOCAL_APPDATA = $001C;
  CSIDL_MYDOCUMENTS = $000C;
  CSIDL_MYMUSIC = $000D;
  CSIDL_MYPICTURES = $0027;
  CSIDL_MYVIDEO = $000E;
  CSIDL_NETHOOD = $0013;
  CSIDL_NETWORK = $0012;
  CSIDL_PERSONAL = $0005;
  CSIDL_PRINTERS = $0004;
  CSIDL_PRINTHOOD = $001B;
  CSIDL_PROFILE = $0028;
  CSIDL_PROFILES = $003E;
  CSIDL_PROGRAM_FILES = $0026;
  CSIDL_PROGRAM_FILES_COMMON = $002B;
  CSIDL_PROGRAMS = $0002;
  CSIDL_RECENT = $0008;
  CSIDL_SENDTO = $0009;
  CSIDL_STARTMENU = $000B;
  CSIDL_STARTUP = $0007;
  CSIDL_SYSTEM = $0025;
  CSIDL_TEMPLATES = $0015;
  CSIDL_WINDOWS = $0024;

implementation

function FormatW(fmt: WideString; params: array of const): WideString;
var
  pdw1, pdw2: PDWORD;
  i: integer;
  pc: PWIDECHAR;
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
  GetMem(pc, length(params) * sizeof(Pointer));
  try
    ZeroMemory(pc, length(params) * sizeof(Pointer));
    SetString(Result, pc, wvsprintfW(pc, PWIDECHAR(fmt), PCHAR(pdw1)));
  except
    Result := '';
  end;
  if (pdw1 <> nil) then
    FreeMem(pdw1);
  if (pc <> nil) then
    FreeMem(pc);
end;

procedure MyMessageBox(hWnd: HWND; caption, Text: string; IDIcon: DWORD);
var
  MsgInfo: TMsgBoxParams;
begin
  MsgInfo.cbSize := SizeOf(TMsgBoxParams);
  MsgInfo.hwndOwner := hWnd;
  MsgInfo.hInstance := GetWindowLong(hWnd, GWL_HINSTANCE);
  MsgInfo.lpszText := @Text[1];
  MsgInfo.lpszCaption := @Caption[1];
  MsgInfo.dwStyle := MB_USERICON;
  MsgInfo.lpszIcon := MAKEINTRESOURCE(IDICON);
  MessageBoxIndirect(MsgInfo);
end;

function LoadResStr(hInstance: THandle; ID: DWORD): string;
var
  Len: DWORD;
  Size: DWORD;
begin
  Size := 255;
  SetLength(Result, Size);
  len := LoadString(hInstance, ID, PChar(Result), 255);
  if Len > 0  then
    SetLength(result, len)
  else
    raise Exception.Create(SysErrorMessage(GetLastError));
end;

procedure ProcessMessages(hWnd: DWORD);
var
  Msg: TMsg;
begin
  while PeekMessage(Msg, hWnd, 0, 0, PM_REMOVE) do
  begin
    TranslateMessage(Msg);
    DispatchMessage(Msg);
  end;
end;

function UnixTimeToDateString(i: PDWORD): string;
var
  umt: int64;
  st: TSystemTime;
  ft: TFileTime;
  li: ULARGE_INTEGER;
  buf: array[0..255] of char;
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

function UnixTimeToTimeString(i: PDWORD): string;
var
  umt: int64;
  st: SystemTime;
  ft: FileTime;
  li: ULARGE_INTEGER;
  buf: array[0..255] of char;
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

function UnixTimeToFileTime(t: LongWord): FILETIME;
var
  ll: int64;
begin
  ll := (Int64(t) * 10000000) + int64(116444736000000000);
  result.dwLowDateTime := LongWord(ll);
  result.dwHighDateTime := ll shr 32;
end;

function IsNT5OrHigher: Boolean;
var
  ovi: TOSVERSIONINFO;
begin
  ZeroMemory(@ovi, sizeof(TOSVERSIONINFO));
  ovi.dwOSVersionInfoSize := SizeOf(TOSVERSIONINFO);
  if GetVersionEx(ovi) then
  begin
    if (ovi.dwPlatformId = VER_PLATFORM_WIN32_NT) and (ovi.dwMajorVersion >= 5) then
      result := TRUE
    else
      result := FALSE;
  end
  else
    raise Exception.Create(SysErrorMessage(GetLastError));
end;

// Author: Manuel Pöter

function ExtractFilepathW(s: WideString): WideString;
var
  i: integer;
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

// Author: Manuel Pöter

function ExtractFilenameW(s: WideString): WideString;
var
  i: integer;
begin
  result := s;
  for i := length(s) downto 1 do
    if s[i] = '\' then
    begin
      result := copy(s, i + 1, length(s));
      break;
    end;
end;

// Author: Oliver Schneider

function PutBinresToHDD(binresname, path: string): Boolean;
var
  hi, hg, ResSize, SizeWritten, hFile: Cardinal;
begin
  result := false;
  hi := FindResource(hInstance, @binresname[1], 'BINRES');
  if hi <> 0 then
  begin
    hg := LoadResource(hInstance, hi);
    if hg <> 0 then
    begin
      ResSize := SizeofResource(hInstance, hi);
      hFile := CreateFile(@path[1], GENERIC_READ or GENERIC_WRITE, FILE_SHARE_READ or FILE_SHARE_WRITE, nil,
        CREATE_ALWAYS, FILE_ATTRIBUTE_ARCHIVE, 0);
      if hFile <> INVALID_HANDLE_VALUE then
      try
        result := (WriteFile(hFile, LockResource(HG)^, ResSize, SizeWritten, nil) and (SizeWritten = ResSize));
      finally
        CloseHandle(hFile);
      end;
    end;
  end;
end;

// Author    : Nico Bendlin

function GetImageLinkTimeStamp(const FileName: string): DWORD;
const
  INVALID_SET_FILE_POINTER = DWORD(-1);
  BorlandMagicTimeStamp = $2A425E19; // Delphi 4-6 (and above?)
  FileTime1970: TFileTime = (dwLowDateTime: $D53E8000; dwHighDateTime: $019DB1DE);
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
  FileHandle: THandle;
  BytesRead: DWORD;
  ImageDosHeader: TImageDosHeader;
  ImageNtHeaders: TImageNtHeaders;
  SectionHeaders: PImageSectionHeaders;
  Section: Word;
  ResDirRVA: DWORD;
  ResDirSize: DWORD;
  ResDirRaw: DWORD;
  ResDirTable: TImageResourceDirectory;
  FileTime: TFileTime;
begin
  Result := 0;
  // Open file for read access
  FileHandle := CreateFile(PChar(FileName), GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, 0, 0);
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

function GetWinDir(): string;
var
  Size: DWORD;
  Len: DWORD;
begin
  Size := MAX_PATH;
  SetLength(Result, Size);
  Len := GetWindowsDirectory(PChar(Result), Size);
  if Len > 0 then
    SetLength(Result, Len)
  else
    raise Exception.Create(SysErrorMessage(GetLastError));
end;

function GetSysDir(): string;
var
  Size: DWORD;
  Len: DWORD;
begin
  Size := MAX_PATH;
  SetLength(Result, Size);
  Len := GetSystemDirectory(PChar(Result), Size);
  if Len > 0 then
    SetLength(Result, Len)
  else
    raise Exception.Create(SysErrorMessage(GetLastError));
end;

function GetTempDir(): string;
var
  Size: DWORD;
  Len: DWORD;
begin
  Size := MAX_PATH;
  SetLength(Result, Size);
  Len := GetTempPath(Size, PChar(Result));
  if Len > 0 then
    SetLength(Result, Len)
  else
    raise Exception.Create(SysErrorMessage(GetLastError));
end;

function GetAppDir: string;
var
  ReturnCode: DWORD;
  pidl: PItemIdList;
  FolderPath: string;
  SystemFolder: Integer;
begin
  SystemFolder := CSIDL_APPDATA;
  ReturnCode := SHGetSpecialFolderLocation(0, SystemFolder, pidl);
  if ReturnCode = S_OK then
  begin
    SetLength(FolderPath, max_path);
    if SHGetPathFromIDList(pidl, PChar(FolderPath)) then
    begin
      SetLength(FolderPath, length(PChar(FolderPath)) + 1);
    end
    else
      raise Exception.Create('SHGetPathFromIDList');
  end
  else
    raise Exception.Create('SHGetSpecialFolderLocation: ' + IntToStr(ReturnCode));
  Result := FolderPath;
end;

function GetShellFolder(CSIDL: integer): string;
var
  pidl: PItemIdList;
  FolderPath: string;
  SystemFolder: Integer;
  Malloc: IMalloc;
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

function GetCompName: string;
var
  Size: DWORD;
begin
  Size := MAX_COMPUTERNAME_LENGTH;
  SetLength(Result, Size);
  if GetComputerName(PChar(Result), Size) then
    SetLength(Result, Size)
  else
    raise Exception.Create(SysErrorMessage(GetLastError));
end;

function GetCurrentUserName: string;
const
  UNLEN = 256;
var
  Size: DWORD;
begin
  Size := UNLEN + 1;
  SetLength(Result, Size);
  if GetUserName(PChar(Result), Size) then
    SetLength(Result, Size - 1)
  else
    raise Exception.Create(SysErrorMessage(GetLastError));
end;

function GetOSLanguageStr: string;
begin
  SetLength(Result, MAX_PATH);
  SetLength(Result, VerLanguageName(GetSystemDefaultLangId,
    @Result[1], length(Result)));
end;

function GetOSLanguageIDStr: string;
var
  Size: DWORD;
  Len: Integer;
begin
  Size := MAX_PATH;
  SetLength(Result, Size);
  Len := GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_SABBREVLANGNAME, PCHar(Result), Size);
  if Len > 0 then
    SetLength(Result, Len)
  else
    raise Exception.Create(SysErrorMessage(GetLastError));
end;

// Author    : Nico Bendlin

function IsAdmin: LongBool;

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
var
  TokenHandle: THandle;
  ReturnLength: DWORD;
  TokenInformation: PTokenGroups;
  AdminSid: PSID;
  Loop: Integer;
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

function GetOSDisplayString: string;
begin
end;

procedure EnablePrivilege(const Privilege: string; fEnable: Boolean; out PreviousState: Boolean);
var
  Token: THandle;
  NewState: TTokenPrivileges;
  Luid: TLargeInteger;
  PrevState: TTokenPrivileges;
  Return: DWORD;
begin
  PreviousState := True;
  if not OpenProcessToken(GetCurrentProcess(), MAXIMUM_ALLOWED, Token) then
    raise Exception.Create(SysErrorMessage(GetLastError))
  else
  try
    if not LookupPrivilegeValue(nil, PChar(Privilege), Luid) then
      raise Exception.Create(SysErrorMessage(GetLastError))
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
        raise Exception.Create(SysErrorMessage(GetLastError))
      else
      begin
        PreviousState :=
          (PrevState.Privileges[0].Attributes and SE_PRIVILEGE_ENABLED <> 0);
      end;
    end;
  finally
    CloseHandle(Token);
  end;
end;

end.


