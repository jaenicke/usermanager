(******************************************************************************
 *                                                                            *
 *  Project: Usermanager, Benutzerverwaltung für Windows NT, 2000, XP, Vista  *
 *  File   : ChooseComputerDlg, Dialog-Funktion für Computer im Netzwerk      *
 *                                                                            *
 *  Copyright (c) Michael Puff  http://www.michael-puff.de                    *
 *                                                                            *
 ******************************************************************************)

{$I ..\..\CompilerSwitches.inc}

unit ChooseComputerDlg;

interface

uses
  Windows,
  Messages,
  Consts,
  GUIHelpers,
  MpuTools,
  MpuRegistry,
  Network,
  HTMLHlp;

type
  TSelCmpData = packed record
    Computer: string[255];
    Success: Boolean;
  end;
  PSelCmpData = ^TSelCmpData;

  TCurCompData = packed record
    Computer: string[255];
    ParentHandle: THandle;
  end;
  PCurCompData = ^TCurCompData;

var
  CurComputer       : WideString;

{$I .\units\includes\resStrings.inc}

function ChooseCompDlgFunc(hDlg: HWND; umsg: Cardinal; wparam: WPARAM; lparam: LPARAM): BOOL; stdcall;

implementation

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

function ChooseCompDlgFunc(hDlg: HWND; umsg: Cardinal; wparam: WPARAM; lparam: LPARAM): BOOL; stdcall;
var
  rect, rect1       : TRect;
  x, y              : Cardinal;
  s                 : string;
  ws                : WideString;
  len               : Integer;
  SelCmpData        : PSelCmpData;
  Computer          : WideString;
  User              : WideString;
  PW                : WideString;
  ret               : DWORD;
  reg               : TMpuRegistry;
  bSaveNetUserName  : Boolean;
  HelpFilename      : string;
  Url               : string;
resourcestring
  rsLinkTimeStamp   = '%s - %s';
begin
  Result := TRUE;
  case umsg of
    WM_INITDIALOG:
      begin
        // Window-Icons
        if SendMessage(hDlg, WM_SETICON, ICON_SMALL, Integer(LoadIcon(hInstance, MAKEINTRESOURCE(5)))) = 0 then
          SendMessage(hDlg, WM_SETICON, ICON_BIG, Integer(LoadIcon(hInstance, MAKEINTRESOURCE(5))));
        // center dialog
        GetWindowRect(PCurCompData(lparam)^.ParentHandle, rect);
        GetWindowRect(hDlg, rect1);
        x := rect.Left - ((rect.Left - rect.Right) div 2) - ((rect1.Right - rect1.Left) div 2);
        y := rect.Top - ((rect.Top - rect.Bottom) div 2) - ((rect1.Bottom - rect1.Top) div 2);
        SetWindowPos(hDlg, 0, x, y, 0, 0, SWP_NOSIZE);
        SetWindowPos(GetDlgItem(hDlg, 299), 0, 0, 0, 305, 2, SWP_NOMOVE or SWP_SHOWWINDOW);

        CurComputer := PCurCompData(lparam)^.Computer;

        FreeMemory(PCurCompData(lparam));

        EnableControl(hDlg, ID_BTN_OK_X, False);
        EnableControl(hDlg, ID_BTN_HELP, FileExists(ExtractFilepath(ParamStr(0)) + HELPFILE));

        // read registry settings
        reg := TMpuRegistry.CreateW('', HKEY_CURRENT_USER);
        try
          if reg.Connect = 0 then
          begin
            if reg.OpenKeyW(XPUM_REG_KEY, KEY_READ) = 0 then
            begin
              if reg.ReadBoolW(REG_SAVENETUSERNAME, bSaveNetUserName) = 0 then
              begin
                SetDlgBtnCheck(hDlg, ID_CHK_SAVEUSERNAME, bSaveNetUserName);
                if bSaveNetUserName then
                begin
                  reg.ReadStringW(REG_NETUSERNAME, ws);
                  SetItemTextW(hDlg, ID_EDT_ACCOUNT_X, ws);
                  reg.ReadStringW(REG_REMOTECOMPUTER, ws);
                  SetItemTextW(hDlg, ID_EDT_COMP_X, ws);
                end;
              end;
              //else if GetLastError <> 0 then
                //DisplayErrorMsg(hDlg, GetLastError, SysErrorMessage(GetLastError), APPNAME);
            end;
            //else if GetLastError <> 0 then
              //DisplayErrorMsg(hDlg, GetLastError, SysErrorMessage(GetLastError), APPNAME);
          end;
          //else
            //DisplayErrorMsg(hDlg, GetLastError, SysErrorMessage(GetLastError), APPNAME);
        finally
          reg.Free;
        end;
      end;
    WM_HELP:
      begin
        if PHelpInfo(lParam)^.dwContextId > 0 then
          ShowHelpHandle(PHelpInfo(lParam)^.hItemHandle, PHelpInfo(lParam)^.dwContextId)
        else
          //DefDlgProc(hDlg, uMsg, wParam, lParam);
          Exit;
      end;
    WM_LBUTTONDOWN:
      Sendmessage(hDlg, WM_NCLBUTTONDOWN, HTCAPTION, lParam);
    WM_CLOSE:
      begin
        SelCmpData := GetMemory(SizeOf(TSelCmpData));
        SelCmpData.Success := False;
        EndDialog(hDlg, Integer(SelCmpData));
      end;
    WM_DESTROY:
      begin
        // Save user name to registry
        reg := TMpuRegistry.CreateW('', HKEY_CURRENT_USER);
        try
          if reg.Connect = 0 then
          begin
            if reg.OpenKeyW(XPUM_REG_KEY, KEY_WRITE) = 0 then
            begin
              // save
              if GetDlgBtnCheck(hDlg, ID_CHK_SAVEUSERNAME) then
              begin
                Computer := GetItemTextW(hDlg, ID_EDT_COMP_X);
                User := GetItemTextW(hDlg, ID_EDT_ACCOUNT_X);
                reg.WriteBoolW(REG_SAVENETUSERNAME, True);
                reg.WriteStringW(REG_NETUSERNAME, User);
                reg.WriteStringW(REG_REMOTECOMPUTER, Computer);
              end
              else // don't save / delete
              begin
                reg.WriteBoolW(REG_SAVENETUSERNAME, False);
                reg.DeleteValueName(REG_NETUSERNAME);
                reg.DeleteValueName(REG_REMOTECOMPUTER);
              end;
            end
            else if GetLastError <> 0 then
              MessageBoxW(hDlg, PWideChar(WideString(SysErrorMessage(GetLastError))),
                PWideChar(WideString(APPNAME)), MB_ICONERROR);
          end;
        finally
          reg.Free;
        end;
      end;
    WM_COMMAND:
      begin
        if wParam = ID_CANCEL then
          SendMessage(hDlg, WM_CLOSE, 0, 0);
        if HiWord(wParam) = EN_CHANGE then
        begin
          case LoWord(wParam) of
            ID_EDT_COMP_X:
              begin
                len := SendDlgItemMessage(hDlg, ID_EDT_COMP_X, WM_GETTEXTLENGTH, 0, 0);
                EnableControl(hDlg, ID_BTN_OK_X, len > 0);
              end;
          end;
        end;
        if HiWord(wParam) = BN_CLICKED then
          case LoWord(wParam) of
            ID_BTN_HELP:
              begin
                HelpFilename := ExtractFilepath(ParamStr(0)) + HELPFILE;
                Url := string(HelpFilename + '::/hilfe.html#3');
                HtmlHelp(hDlg, PChar(Url), HH_DISPLAY_TOPIC, 0);
              end;
            ID_BTN_SEARCH_X:
              begin
                if FindComputer(hDlg, rsSelComputer, s) then
                begin
                  SetDlgItemText(hDlg, ID_EDT_COMP_X, PChar(s));
                end;
              end;
            ID_BTN_CLOSE_X:
              begin
                //SelCmpData := GetMemory(SizeOf(TSelCmpData));
                //SelCmpData.Success := False;
                SendMessage(hDlg, WM_CLOSE, 0, 0);
                //EndDialog(hDlg, Integer(SelCmpData));
              end;
            ID_BTN_OK_X:
              begin
                Computer := GetItemTextW(hDlg, ID_EDT_COMP_X);
                User := GetItemTextW(hDlg, ID_EDT_ACCOUNT_X);
                PW := GetItemTextW(hDlg, ID_EDT_PW_X);

                DisconnectNetworkDrivew(CurComputer);

                ret := ConnectToNetworkDriveW('', Computer + '\IPC$', User, PW, False);
                if ret = 0 then
                begin
                  SelCmpData := GetMemory(sizeof(TSelCmpData));
                  SelCmpData.Computer := Computer;
                  SelCmpData.Success := True;
                  EndDialog(hDlg, Integer(SelCmpData));
                end
                else
                begin
                  DisplayErrorMsg(hDlg, ret, SysErrorMessage(ret), rsErrorConnectNetWork);
                  case ret of
                    53:
                      begin
                        SetItemTextW(hDlg, ID_EDT_COMP_X, '');
                        SetFocus(GetDlgItem(hDlg, ID_EDT_COMP_X));
                      end;
                    1385:
                      begin
                        SetItemTextW(hDlg, ID_EDT_ACCOUNT_X, '');
                        SetItemTextW(hDlg, ID_EDT_PW_X, '');
                        SetFocus(GetDlgItem(hDlg, ID_EDT_ACCOUNT_X));
                      end;
                  end;
                end;
              end;
          end;
      end;
  else
    result := false;
  end;
end;

end.

