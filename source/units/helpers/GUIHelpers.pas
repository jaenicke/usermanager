(******************************************************************************
 *                                                                            *
 *  Usermanager                                                               *
 *  GUIHelpers -- <Kommentar>                                                 *
 *                                                                            *
 *  This Source Code Form is subject to the terms of the Mozilla Public       *
 *  License, v. 2.0. If a copy of the MPL was not distributed with this       *
 *  file, You can obtain one at http://mozilla.org/MPL/2.0/.                  *
 *                                                                            *
 *  Copyright (c) 2006 Michael Puff  http://www.michael-puff.de               *
 *                                                                            *
 ******************************************************************************)

{$I ..\..\CompilerSwitches.inc}

unit GUIHelpers;

interface

uses
  MpuTools,
  Windows,
  Messages,
  commctrl,
  HTMLHlp,
  Consts,
  CommCtrlW;

const
  BooleanToInteger: array[Boolean] of Integer = (0, 1);
  IntegerToBoolean: array[0..1] of Boolean = (False, True);

function BringToFrontEx(AWnd: HWND): Boolean;

procedure DisplayErrorMsg(hParent: THandle; ErrorCode: Integer; Msg, Caption: WideString);
procedure DisplayExceptionMsg(hParent: THandle; ErrorCode: Integer; Msg, Caption: String); overload;
{$IFNDEF UNICODE}
procedure DisplayExceptionMsg(hParent: THandle; ErrorCode: Integer; Msg, Caption: WideString); overload;
{$ENDIF}

procedure ListBoxAddString(Handle: Integer; ID: Integer; const s: string);
procedure SetDlgBtnCheck(Handle: THandle; ID: Integer; bCheck: Boolean);
function GetDlgBtnCheck(hParent: THandle; ID: Integer): Boolean;
procedure SetItemTextW(Handle: THandle; ID: Integer; const Text: WideString);
function GetItemTextW(hParent: THandle; ID: Integer): WideString;
function LVAddCaptionW(Parent: THandle; ID_LV: Integer; Item: Integer; const Text: WideString; ImageIdx: Integer): Integer;
procedure SetLVSubItemTextW(Parent: THandle; ID_LV: Integer; Item, SubItem: Integer; const Text: WideString);
function GetLVItemText(Parent: THandle; ID_LV: Integer; idxItem: Integer): WideString;
procedure ExpandAll(hParent: THandle; ID: Integer; expand: Boolean);
function SetMenuItemCheck(hMenu: THandle; ID_ITEM: DWORD; bCheck: Boolean): DWORD;
function GetMenuItemCheck(hMenu: THandle; ID_ITEM: DWORD): Boolean;
procedure Enable_ToolbarButton(hToolbar: THandle; const BtnID: Integer; const fEnable: boolean);
procedure MyEnableMenuItem(hMenu: THandle; ID_Menu: DWORD; Enable: Boolean);
procedure EnableChildWindows(ParentWindow: THandle;Enable: Boolean);

procedure ShowHelpHandle(ChildHandle: THandle; ContextId: Integer);
procedure ShowHelpMousePos(Pt: TPoint; ContextId: Integer);

function FormatTime(t: int64): string; { (gettime by Assarbad) }
function SecsToDateTime(secs: int64): string;

function DrawShadowText(hdc: HDC; pszText: LPCWSTR; cch: UINT; const pRect: PRect; dwFlags: DWORD; crText: COLORREF;
  crShadow: COLORREF; ixOffset: Integer; iyOffset: Integer): Integer; stdcall; external 'ComCtl32.dll';

resourcestring
  rsErrorUnknown = 'Ein unbekannter Fehler ist aufgetreten.';
  rsErrorMsgTemplate = 'Es ist folgender Fehler aufgetreten:' + #13#10#13#10 +
    'Fehlercode: %d' + #13#10 +
    'Fehlertext: %s';

implementation

function Int32x32To64(const a, b: dword): int64;
begin
  Result := int64(a) * int64(b);
end;

function FormatTime(t: int64): string; { (gettime by Assarbad) }
begin
  //result := IntToStr(t mod 1000);
  case t mod 1000 < 100 of
    true: result := {'0' +} result;
  end;
  t := t div 1000; // -> seconds
  {result := IntToStr(t mod 60) + ' Sekunden ' + result;
  case t mod 60 < 10 of
    true: result := '0' + result;
  end;}
  t := t div 60; //minutes
  result := IntToStr(t mod 60) + ' Min ' + result;
  case t mod 60 < 10 of
    true: result := '0' + result;
  end;
  t := t div 60; //hours
  result := IntToStr(t mod 24) + ' Std ' + result;
  case t mod 60 < 10 of
    true: result := '0' + result;
  end;
  result := IntToStr(t div 24) + ' T ' + result;
end;

function SecsToDateTime(secs: int64): string;
var
  ft                : TFILETIME;
  st                : TSYSTEMTIME;
  lt                : TSYSTEMTIME;
  li                : int64;
  buf1, buf2        : array[0..255] of Char;
begin
  if secs = 0 then
  begin
    result := '';
    exit;
  end;
  st.wYear := 1970;
  st.wMonth := 1;
  st.wDayOfWeek := 0;
  st.wDay := 1;
  st.wHour := 1;
  st.wMinute := 0;
  st.wSecond := 0;
  st.wMilliseconds := 0;
  SystemTimeToFileTime(st, ft);
  { Version 1 }
  {ui.QuadPart := Int32x32To64(PUserInfo11(ui11)^.usri11_last_logon, 10000000)
        + 116444736000000000;
  FileTimeToSystemTime(TFileTime(ui),st);
  FileTimeToSystemTime(TFileTime(ui),st);}
  { Version 2 }
  li := Int32x32To64(secs, 10000000) + 116444736000000000;
  ft.dwLowDateTime := DWORD(li);
  ft.dwHighDateTime := li shr 32;
  FileTimeToSystemTime(TFileTime(ft), st);
  SystemTimeToTzSpecificLocalTime(nil, st, lt);
  GetTimeFormat(LOCALE_USER_DEFAULT, TIME_FORCE24HOURFORMAT, @lt, nil, buf1, sizeof(buf1));
  GetDateFormat(LOCALE_USER_DEFAULT, DATE_SHORTDATE, @lt, nil, buf2, sizeof(buf2));
  result := string(buf2) + ' / ' + string(buf1);
end;

function BringToFrontEx(AWnd: HWND): Boolean;
var
  FgWindow: HWND;
  ThreadId: DWORD;
  Attached: BOOL;
begin
  FgWindow := GetForegroundWindow();
  ThreadId := GetWindowThreadProcessId(FgWindow, nil);
  Attached := AttachThreadInput(GetCurrentThreadId(), ThreadId, True);
  if Attached or (ThreadId = GetCurrentThreadId()) then
    Result := SetFocus(AWnd) <> 0
  else
    Result := SetForegroundWindow(AWnd);
  if Attached then
    AttachThreadInput(GetCurrentThreadId(), ThreadId, False);
end;

procedure DisplayErrorMsg(hParent: THandle; ErrorCode: Integer; Msg, Caption: WideString);
var
  s: WideString;
begin
  if Msg = '' then
    Msg := rsErrorUnknown;

  s := FormatW(rsErrorMsgTemplate, [ErrorCode, Msg]);
  MessageBoxW(hParent, PWideChar(s), PwideChar(Caption), MB_ICONSTOP);
end;

procedure DisplayExceptionMsg(hParent: THandle; ErrorCode: Integer; Msg, Caption: String);
var
  s: String;
begin
  if Msg = '' then
    Msg := rsErrorUnknown;

  s := Format(rsErrorMsgTemplate, [ErrorCode, Msg]);
  MessageBox(hParent, PChar(s), PChar(Caption), MB_ICONSTOP or MB_APPLMODAL);
end;

{$IFNDEF UNICODE}
procedure DisplayExceptionMsg(hParent: THandle; ErrorCode: Integer; Msg, Caption: WideString);
var
  s: String;
begin
  if Msg = '' then
    Msg := rsErrorUnknown;

  s := Format(rsErrorMsgTemplate, [ErrorCode, Msg]);
  MessageBoxW(hParent, PWideChar(WideString(s)), PWideChar(WideString(Caption)), MB_ICONSTOP or MB_APPLMODAL);
end;
{$ENDIF}

procedure SetItemTextW(Handle: THandle; ID: Integer; const Text: WideString);
begin
  SetDlgItemTextW(Handle, ID, PWideChar(Text));
end;

function GetItemTextW(hParent: THandle; ID: Integer): Widestring;
var
  p                 : PWideChar;
  len               : Integer;
  s                 : string;
begin
  p := nil;
  s := '';
  len := SendDlgItemMessage(hParent, ID, WM_GETTEXTLENGTH, 0, 0);
  if len > 0 then
  begin
    try
      p := GetMemory(len*2+1);
      if Assigned(p) then
      begin
        GetDlgItemTextW(hParent, ID, p, len+1);
        s := String(p);
      end;
    finally
      FreeMemory(p);
    end;
  end;
  result := s;
end;

procedure SetDlgBtnCheck(Handle: THandle; ID: Integer; bCheck: Boolean);
const
  Check             : array[Boolean] of Integer = (BST_UNCHECKED, BST_CHECKED);
begin
  CheckDlgButton(Handle, ID, Check[bCheck]);
end;

function GetDlgBtnCheck(hParent: THandle; ID: Integer): Boolean;
begin
  result := IsDlgButtonChecked(hParent, ID) = BST_CHECKED;
end;

procedure ListBoxAddString(Handle: Integer; ID: Integer; const s: string);
begin
  SendDlgItemMessage(Handle, ID, LB_ADDSTRING, 0, LPARAM(PChar(s)));
end;

function LVAddCaptionW(Parent: THandle; ID_LV: Integer; Item: Integer; const Text: WideString; ImageIdx: Integer): Integer;
var
  lvi               : TLVItemW;
begin
  ZeroMemory(@lvi, sizeof(TLVItemW));
  lvi.mask := LVIF_TEXT or LVIF_IMAGE;
  lvi.iImage := ImageIdx;
  lvi.iItem := Item;
  lvi.pszText := PWideChar(Text);
  result := SendDlgItemMessage(Parent, ID_LV, LVM_INSERTITEMW, 0, Integer(@lvi));
end;

procedure SetLVSubItemTextW(Parent: THandle; ID_LV: Integer; Item, SubItem: Integer; const Text: WideString);
var
  lvi               : TLVItemW;
begin
  ZeroMemory(@lvi, sizeof(TLVItemW));
  lvi.mask := LVIF_TEXT;
  lvi.iItem := Item;
  lvi.iSubItem := SubItem;
  lvi.pszText := PWideChar(Text);
  SendDlgItemMessage(Parent, ID_LV, LVM_SETITEMW, Item, Integer(@lvi));
end;

function GetLVItemText(Parent: THandle; ID_LV: Integer; idxItem: Integer): WideString;
var
  Buffer: array[0..511] of WideChar;
begin
  ZeroMemory(@Buffer, sizeof(Buffer));
  result := '';
  CommCtrlW.ListView_GetItemTextW(GetDlgItem(Parent, ID_LV), idxItem, 0, Buffer, sizeof(Buffer));
  result := String(Buffer);
end;

procedure ExpandAll(hParent: THandle; ID: Integer; expand: Boolean);
const
  szCode            : array[Boolean] of WPARAM = (TVE_COLLAPSE, TVE_EXPAND);
var
  hTV               : HWND;
  hItem, hNewItem   : HTREEITEM;
begin
  hTV := GetDlgItem(hParent, ID);
  hItem := TreeView_GetRoot(hTV);
  while hItem <> nil do
  begin
    TreeView_Expand(hTV, hItem, szCode[expand]);
    hNewItem := TreeView_GetChild(hTV, hItem);
    if hNewItem = nil then
      hNewItem := TreeView_GetNextSibling(hTV, hItem);
    if hNewItem = nil then
      hNewItem := TreeView_GetNextSibling(hTV, TreeView_GetParent(hTV, hItem));
    hItem := hNewItem;
  end;
  TreeView_Expand(hTV, TreeView_GetRoot(hTV), TVE_EXPAND);
end;

function SetMenuItemCheck(hMenu: THandle; ID_ITEM: DWORD; bCheck: Boolean): DWORD;
begin
  if bCheck then
    result := CheckMenuItem(hMenu, ID_ITEM, MF_BYCOMMAND or MF_CHECKED)
  else
    result := CheckMenuItem(hMenu, ID_ITEM, MF_BYCOMMAND or MF_UNCHECKED)
end;

function GetMenuItemCheck(hMenu: THandle; ID_ITEM: DWORD): Boolean;
begin
  result := GetMenuState(hMenu, ID_ITEM, MF_BYCOMMAND) and MF_CHECKED = MF_CHECKED;
end;

procedure Enable_ToolbarButton(hToolbar: THandle; const BtnID: Integer; const fEnable: boolean);
begin
  SendMessage(hToolbar,TB_ENABLEBUTTON,BtnID,MAKELPARAM(integer(fEnable),0));
end;

procedure MyEnableMenuItem(hMenu: THandle; ID_Menu: DWORD; Enable: Boolean);
const
  MF_STATUS              : array[Boolean] of Byte = (MF_GRAYED, MF_ENABLED);
begin
  EnableMenuItem(hMenu, ID_Menu, MF_BYCOMMAND or MF_STATUS[Enable]);
end;

procedure ShowHelpMousePos(Pt: TPoint; ContextId: Integer);
const
  rect              : TRect = (Left: - 1; Top: - 1; Right: - 1; Bottom: - 1);
var
  Popup             : THHPopup;
  URL               : string;
begin
  URL := '::/popup.txt';

  if (ContextId >= 0) then
  begin
    FillChar(Popup, SizeOf(Popup), 0);
    Popup.cbStruct := SizeOf(Popup);
    Popup.hinst := 0;
    Popup.idString := 0;

    Popup.pszText := PChar(ContextInfo[ContextId]);
    Popup.pt := Pt;
    Popup.clrForeGround := TColorRef(-1);
    Popup.clrBackground := TColorRef(-1);
    Popup.rcMargins := rect;
    Popup.pszFont := '';

    HtmlHelp(0, @URL[1], HH_DISPLAY_TEXT_POPUP, dword(@Popup));
  end;
end;

procedure ShowHelpHandle(ChildHandle: THandle; ContextId: Integer);
const
  marginrect              : TRect = (Left: - 1; Top: - 1; Right: - 1; Bottom: - 1);
var
  Popup             : THHPopup;
  URL               : string;
  rect: TRect;
  pt: TPoint;
begin
  URL := '::/popup.txt';

  if (ContextId >= 0) then
  begin
    FillChar(Popup, SizeOf(Popup), 0);
    Popup.cbStruct := SizeOf(Popup);
    Popup.hinst := 0;
    Popup.idString := 0;

    Popup.pszText := PChar(ContextInfo[ContextId]);

    GetWindowRect(ChildHandle, rect);
    pt.X := rect.Left + 100;
    pt.Y := rect.Top + 25;
    Popup.pt := pt;
    Popup.clrForeGround := TColorRef(-1);
    Popup.clrBackground := TColorRef(-1);
    Popup.rcMargins := marginrect;
    Popup.pszFont := '';

    HtmlHelp(0, @URL[1], HH_DISPLAY_TEXT_POPUP, dword(@Popup));
  end;
end;

procedure EnableChildWindows(ParentWindow: THandle; Enable: Boolean);

  function EnumProc(wnd: HWND; lparam: LPARAM): BOOL; stdcall;
  begin
    result := True;
    EnableWindow(wnd, IntegerToBoolean[lparam]);
  end;

var
  Param: Integer;

begin
  Param := BooleanToInteger[Enable];
  EnumChildWindows(ParentWindow, @EnumProc, Param);
end;

end.

