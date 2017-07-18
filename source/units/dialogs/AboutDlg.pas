(******************************************************************************
 *                                                                            *
 *  Usermanager                                                               *
 *  AboutDlg -- dialog function for the About dialog                          *
 *                                                                            *
 *  This Source Code Form is subject to the terms of the Mozilla Public       *
 *  License, v. 2.0. If a copy of the MPL was not distributed with this       *
 *  file, You can obtain one at http://mozilla.org/MPL/2.0/.                  *
 *                                                                            *
 *  Copyright (c) 2006 Michael Puff  http://www.michael-puff.de               *
 *                                                                            *
 ******************************************************************************)

{$I ..\..\CompilerSwitches.inc}

unit AboutDlg;

interface

uses
  Windows, Messages, Consts, AssasControls, MpuTools;

{$R .\resources\thanks.res}

function AboutDlgFunc(hDlg: HWND; umsg: Cardinal; wparam: WPARAM; lparam: LPARAM): BOOL; stdcall;

implementation

function ResToString(Instance: hInst; ResName, ResType: PChar): string;
(*
  Functionality:
    This function returns a string from a text file contained as a resource.
    See binres on my webpage, too.
    [GENERIC]
*)
var
  ResSize,
    HG,
    HI              : Cardinal;
  pc                : PChar;
begin
  result := '';
  // Get reference to resource.
  HI := FindResource(Instance, ResName, ResType);
  if HI <> 0 then
  begin
    // Load it
    HG := LoadResource(Instance, HI);
    if HG <> 0 then
    try
      ResSize := SizeOfResource(Instance, HI);
      // Get a pointer to the resource.
      pc := LockResource(HG);
      // Set the return value.
      SetString(result, pc, ResSize);
    except;
    end;
  end;
end;

function GetVersion: string;
var
  VerInfoSize       : DWORD;
  VerInfo           : Pointer;
  VerValueSize      : DWORD;
  VerValue          : PVSFixedFileInfo;
  Dummy             : DWORD;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
  with VerValue^ do
  begin
    Result := IntToStr(dwFileVersionMS shr 16);
    Result := Result + '.' + IntToStr(dwFileVersionMS and $FFFF);
    Result := Result + '.' + IntToStr(dwFileVersionLS shr 16);
    Result := Result + '.' + IntToStr(dwFileVersionLS and $FFFF);
  end;
  FreeMem(VerInfo, VerInfoSize);
end;

function AboutDlgFunc(hDlg: HWND; umsg: Cardinal; wparam: WPARAM; lparam: LPARAM): BOOL; stdcall;
var
  s, s2             : string;
  rect, rect1       : TRect;
  x, y              : Cardinal;
  MyFont            : HFONT;
  DateStamp         : DWORD;
  TimeStamp         : DWORD;
resourcestring
  rsLinkTimeStamp   = '%s - %s';
begin
  Result := TRUE;
  case umsg of
    WM_INITDIALOG:
      begin
        GetWindowRect(lparam, rect);
        GetWindowRect(hDlg, rect1);
        x := rect.Left - ((rect.Left - rect.Right) div 2) - ((rect1.Right - rect1.Left) div 2);
        y := rect.Top - ((rect.Top - rect.Bottom) div 2) - ((rect1.Bottom - rect1.Top) div 2);
        SetWindowPos(hDlg, 0, x, y, 0, 0, SWP_NOSIZE);
        SetWindowText(hDlg, PChar('Info - ' + APPNAME));
        MyFont := CreateFont(-14, 0, 0, 0, 900, 0, 0, 0, ANSI_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
          DEFAULT_QUALITY, DEFAULT_PITCH, FontName);
        if MyFont <> 0 then
          SendDlgItemMessage(hDlg, ID_STC_APPNAME, WM_SETFONT, Integer(MyFont), Integer(true));
        s := Format(APPNAME + ' - %s', [GetVersion]);
        SetDlgItemText(hDlg, ID_STC_APPNAME, PChar(s));
        DateStamp := GetImageLinkTimeStamp(ParamStr(0));
        s2 := UnixTimeToDateString(@DateStamp);
        TimeStamp := GetImageLinkTimeStamp(ParamStr(0));
        s := UnixTimeToTimeString(@TimeStamp);
        SetDlgItemText(hDlg, ID_STC_DATE, PChar(Format(rsLinkTimeStamp, [s2, s])));
        SetDlgItemText(hDlg, ID_STC_DESCRIPTION, PChar(DESCRIPTION));
        SetDlgItemText(hDlg, ID_STC_COPYRIGHT, PChar(COPYRIGHT + #13#10 + HOMEPAGE));
        MyFont := CreateFont(-12, 0, 0, 0, FW_NORMAL, 0, 0, 0, ANSI_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
          DEFAULT_QUALITY, DEFAULT_PITCH, FONTNAME);
        SendDlgItemMessage(hDlg, ID_CUSTOM_SCROLL, WM_SETFONT, MyFont, Integer(true));
        SendDlgItemMessage(hDlg, ID_CUSTOM_SCROLL, WM_ASSASETCOLORS, GetSysColor(COLOR_BTNTEXT), RGB($FF, $FF, $FF));
        SendDlgItemMessage(hDlg, ID_CUSTOM_SCROLL, WM_ASSASETSCROLLDELAY, 35, 0);
        s := ResToString(HInstance, MAKEINTRESOURCE(1), 'BINRES');
        SetDlgItemText(hDlg, ID_CUSTOM_SCROLL, PChar(s));
      end;
    WM_CLOSE:
      EndDialog(hDlg, 0);
    WM_LBUTTONDOWN:
      Sendmessage(hDlg, WM_NCLBUTTONDOWN, HTCAPTION, lParam);
    WM_COMMAND:
      begin
        if wParam = ID_CANCEL then
          SendMessage(hDlg, WM_CLOSE, 0, 0);
        if HiWord(wParam) = BN_CLICKED then
          case LoWord(wParam) of
            ID_BTN_CLOSE: SendMessage(hDlg, WM_CLOSE, 0, 0);
          end;
      end;
  else
    result := false;
  end;
end;


end.
