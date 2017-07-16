(******************************************************************************
 *                                                                            *
 *  XP Usermanager                                                            *
 *  TabDlgs, Tabdialogs dialog function                                       *
 *  2012-01-03                                                                *
 *                                                                            *
 *  Michael Puff  http://www.michael-puff.de                                  *
 *                                                                            *
 ******************************************************************************)

{$I ..\..\CompilerSwitches.inc}

unit TabDlgs;

interface

uses
  Windows,
  Messages,
  CommCtrl,
  BrowseForFolderCls,
  Consts,
  MpuTools,
  GUIHelpers;

{$I '.\units\includes\resStrings.inc'}

function tabdlgfunc(hDlg: hWnd; uMsg: dword; wParam: wParam; lParam: lParam): bool; stdcall;

var
  bPWHasChanged: Boolean = False;
  bAutoLoginHasChanged: Boolean = False;

implementation

var
  hApp: THandle;



function tabdlgfunc(hDlg: hWnd; uMsg: dword; wParam: wParam; lParam: lParam): bool; stdcall;
var
  Filename: string;
  bff: TFolderBrowser;
  OldState: Integer;
  NewState: Integer;
begin
  result := true;
  case uMsg of
    WM_INITDIALOG:
      begin
        hApp := lParam;
        SetWindowContextHelpId(GetDlgItem(hDlg, ID_EDT_USER), 1);
        SetWindowContextHelpId(GetDlgItem(hDlg, ID_EDT_FULLNAME), 2);
        SetWindowContextHelpId(GetDlgItem(hDlg, ID_EDT_DESCRIPTION), 3);
        SetWindowContextHelpId(GetDlgItem(hDlg, ID_EDT_PW), 4);
        SetWindowContextHelpId(GetDlgItem(hDlg, ID_EDT_PW2), 4);
        SetWindowContextHelpId(GetDlgItem(hDlg, ID_CHK_RESET_PW), 4);
        SetWindowContextHelpId(GetDlgItem(hDlg, ID_CHK_MUST_CHANGE_PW), 6);
        SetWindowContextHelpId(GetDlgItem(hDlg, ID_CHK_CANT_CHANGE_PW), 7);
        SetWindowContextHelpId(GetDlgItem(hDlg, ID_CHK_PW_DONT_EXPIRE), 8);
        SetWindowContextHelpId(GetDlgItem(hDlg, ID_CHK_ACCOUNT_DISABLED), 9);
        SetWindowContextHelpId(GetDlgItem(hDlg, ID_EDT_HOMEDIR), 10);
        SetWindowContextHelpId(GetDlgItem(hDlg, ID_EDT_SCRIPT_PATH), 11);
        SetWindowContextHelpId(GetDlgItem(hDlg, ID_CHK_AUTO_LOGIN), 12);
        SetWindowContextHelpId(GetDlgItem(hDlg, ID_EDT_AUTO_LOGIN), 12);
        SetWindowContextHelpId(GetDlgItem(hDlg, ID_CHK_HIDE_ACCOUNT), 13);
        SetWindowContextHelpId(GetDlgItem(hDlg, ID_LV_USERGROUPS), 14);
      end;
    WM_HELP:
      begin
        //ShowHelpMousePos(PHelpInfo(lParam)^.MousePos, PHelpInfo(lParam)^.dwContextId);
        ShowHelpHandle(PHelpInfo(lParam)^.hItemHandle, PHelpInfo(lParam)^.dwContextId);
      end;
    WM_COMMAND:
      begin
        // OnChange edits
        if hiword(wParam) = EN_CHANGE then
        begin
          case loword(wParam) of
            ID_EDT_USER, ID_EDT_FULLNAME, ID_EDT_DESCRIPTION, ID_EDT_HOMEDIR, ID_EDT_SCRIPT_PATH:
              begin
                EditMode := EditMode or MODE_EDIT;
                Enable_ToolbarButton(GetDlgItem(hApp, ID_TOOLBAR), ID_MNU_SAVE, True);
                MyEnableMenuItem(GetMenu(hApp), ID_MNU_SAVE, True);
              end;
            ID_EDT_PW:
              begin
                bPWHasChanged := True;
                EditMode := EditMode or MODE_EDIT;
                Enable_ToolbarButton(GetDlgItem(hApp, ID_TOOLBAR), ID_MNU_SAVE, True);
                MyEnableMenuItem(GetMenu(hApp), ID_MNU_SAVE, True);
              end;
          end;
        end;
        if HiWord(wParam) = BN_CLICKED then
        begin
          case loword(WParam) of
            ID_BTN_SCRIPT_PATH:
              begin
                Filename := OpenFile(hTabDlgs[0], '');
                if Filename <> '' then
                  SetDlgItemText(hDlg, ID_EDT_SCRIPT_PATH, PChar(Filename));
              end;
            ID_BTN_HOMEDIR:
              begin
                bff := TFolderBrowser.Create(hTabDlgs[0], rsDlgHomeDir);
                try
                  if bff.Execute then
                  begin
                    SetDlgItemText(hTabDlgs[0], ID_EDT_HOMEDIR, PChar(bff.SelectedItem));
                  end;
                finally
                end;
              end;
            ID_CHK_RESET_PW, ID_CHK_MUST_CHANGE_PW, ID_CHK_CANT_CHANGE_PW, ID_CHK_PW_DONT_EXPIRE, ID_CHK_ACCOUNT_DISABLED, ID_CHK_HIDE_ACCOUNT:
              begin
                EditMode := EditMode or MODE_EDIT;
                Enable_ToolbarButton(GetDlgItem(hApp, ID_TOOLBAR), ID_MNU_SAVE, True);
                MyEnableMenuItem(GetMenu(hApp), ID_MNU_SAVE, True);
              end;
            ID_CHK_AUTO_LOGIN:
              begin
                EnableControl(hTabDlgs[2], ID_EDT_AUTO_LOGIN, IsDlgButtonChecked(hTabDlgs[2], ID_CHK_AUTO_LOGIN) =
                  BST_CHECKED);
                EditMode := EditMode or MODE_EDIT;
                bAutoLoginHasChanged := True;
                Enable_ToolbarButton(GetDlgItem(hApp, ID_TOOLBAR), ID_MNU_SAVE, True);
                MyEnableMenuItem(GetMenu(hApp), ID_MNU_SAVE, True);
              end;
            {D_CHK_PW_DONT_EXPIRE:
              begin
                EditMode := EditMode or MODE_EDIT;
                Enable_ToolbarButton(GetDlgItem(hApp, ID_TOOLBAR), ID_MNU_SAVE, True);
                MyEnableMenuItem(GetMenu(hApp), ID_MNU_SAVE, True);
              end;}
          end;
        end;
      end;
    WM_NOTIFY:
      begin
        if (PNMHdr(lParam).idFrom = ID_LV_USERGROUPS) then
        begin
          case PNMHDR(lParam)^.code of
            LVN_ITEMCHANGED:
              begin
                OldState := (PNMLISTVIEW(lParam)^.uOldState and LVIS_STATEIMAGEMASK shr 12) - 1;
                NewState := (PNMLISTVIEW(lParam)^.uNewState and LVIS_STATEIMAGEMASK shr 12) - 1;
                Enable_ToolbarButton(GetDlgItem(hApp, ID_TOOLBAR), ID_MNU_SAVE, OldState <> NewState);
                MyEnableMenuItem(GetMenu(hApp), ID_MNU_SAVE, OldState <> NewState);
              end;
          end;
        end;
      end;
  else
    result := false;
  end;
end;

end.

