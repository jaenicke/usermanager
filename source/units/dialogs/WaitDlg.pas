(******************************************************************************
 *                                                                            *
 *  Usermanager                                                               *
 *  WaitDlg -- WaitDialog                                                     *
 *                                                                            *
 *  Copyright (c) 2006 Michael Puff  http://www.michael-puff.de               *
 *                                                                            *
 ******************************************************************************)

{$I ..\..\CompilerSwitches.inc} 

unit WaitDlg;

interface

uses
  Windows,
  Messages,
  MpuTools;

const
  ID_STC_INFO       = 501;

type
  TWaitInfo = record
    hParent: THandle;
    InfoText: WideString;
    Caption: WideString;
  end;
  PWaitInfo = ^TWaitInfo;

function waitdlgproc(hDlg: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): bool; stdcall;

implementation

function waitdlgproc(hDlg: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): bool; stdcall;
var
  rect, rect1       : TRect;
  x, y              : Cardinal;
  hParent           : THandle;
  Text              : WideString;
begin
  Result := true;
  case uMsg of
    WM_INITDIALOG:
      begin
        hParent := PWaitInfo(lParam)^.hParent;
        Text := PWaitInfo(lParam)^.InfoText;
        GetWindowRect(hParent, rect);
        GetWindowRect(hDlg, rect1);
        x := rect.Left - ((rect.Left - rect.Right) div 2) - ((rect1.Right - rect1.Left) div 2);
        y := rect.Top - ((rect.Top - rect.Bottom) div 2) - ((rect1.Bottom - rect1.Top) div 2);
        SetWindowPos(hDlg, 0, x, y, 0, 0, SWP_NOSIZE);
        SetWindowPos(GetDlgItem(hDlg, 299), 0, 0, 0, 305, 2, SWP_NOMOVE or SWP_SHOWWINDOW);
        SetWindowTextW(hDlg, PWideChar(PWaitInfo(lParam)^.Caption));
        SetDlgItemTextW(hDlg, ID_STC_INFO, PWideChar(Text));
      end;
  else
    Result := false;
  end;
end;

end.

