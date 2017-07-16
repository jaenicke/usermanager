(******************************************************************************
 *                                                                            *
 *  Project: Usermanager, Benutzerverwaltung für Windows NT, 2000, XP, Vista  *
 *  File   : GroupManagerDlg, Gruppenmanager Dialog                           *                                                      
 *                                                                            *
 *  Copyright (c) Michael Puff  http://www.michael-puff.de                    *
 *                                                                            *
 ******************************************************************************)

{$I ..\..\CompilerSwitches.inc}

unit GroupManagerDlg;

interface

uses
  Windows,
  Messages,
  CommCtrl,
  Consts,
  MpuTools,
  Exceptions,
  GUIHelpers,
  NTUser,
  NetAPI,
  HTMLHlp;

function groupmandlgproc(hDlg: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): bool; stdcall;

type
  TInfo = packed record
    hParent: THandle;
    CurComputer: WideString;
  end;
  PInfo = ^Tinfo;

  TThreadParams = record
    hParent: THandle;
  end;
  PThreadParams = ^TThreadParams;

  TAddThreadParams = packed record
    GroupName: WideString;
    Comment: WideString;
  end;
  PAddThreadParams = ^TAddThreadParams;

  TDelThreadParams = packed record
    GroupNmae: WideString;
  end;
  PDelThreadParams = ^TDelThreadParams;

implementation

var
  hDialog           : THandle;
  CurComputer       : WideString;

{$I .\units\includes\ResStrings.inc}

procedure WaitThread(ThreadFunc: TThreadFunc; Params: Pointer; Info: TWaitInfo);
var
  hThread           : THandle;
  ThreadID          : Cardinal;
  waitstate         : DWORD;
begin
  waitstate := 0;
  EnableWindow(Info.hParent, False);
  hThread := BeginThread(nil, 0, @ThreadFunc, Params, 0, ThreadID);
  repeat
    GetExitCodeThread(hThread, waitstate);
    ProcessMessages(info.hParent);
    sleep(1);
  until waitstate = 0;
  EnableWindow(info.hParent, True);
end;

procedure MakeColumnsGroups(hParent: THandle; ID: Integer);
var
  lvc               : TLVColumnW;
begin
  lvc.mask := LVCF_TEXT or LVCF_WIDTH;
  lvc.pszText := 'Gruppe';
  lvc.cx := 410;
  SendMessage(GetDlgItem(hParent, ID), LVM_INSERTCOLUMNW, 1, Integer(@lvc));
//  lvc.pszText := 'Kommentar';
//  lvc.cx := 270;
//  SendMessage(GetDlgItem(hParent, ID), LVM_INSERTCOLUMNW, 2, Integer(@lvc));
end;

procedure FillLVGroups(hParent: THandle; ID: Integer);
var
  Groups            : TGroupCollection;
  Privileges        : TPrivilegeCollection;
  i                 : Integer;
  lvi               : TLVItemW;
begin
  ListView_DeleteAllItems(GetDlgItem(hDialog, ID_LV_GROUPS));
  ZeroMemory(@lvi, sizeof(TLVItemW));
  lvi.mask := LVIF_TEXT or LVIF_IMAGE or LVIF_PARAM;
  lvi.iImage := 0;
  Groups := TGroupCollection.GetAll(CurComputer);
  for i := 0 to Groups.Count - 1 do
  begin
    Privileges := TPrivilegeCollection.GetUserPrivileges(CurComputer, Groups.Items[i].Name);
    lvi.iItem := i;
    // Benutzerprivilegien als Zeiger im lParam speichern
    lvi.lParam := Integer(Privileges);
    lvi.pszText := PWideChar(Groups.Items[i].Name);
    SendDlgItemMessage(hParent, ID, LVM_INSERTITEMW, 0, Integer(@lvi));
    SetLVSubItemTextW(hParent, ID_LV_GROUPS, i, 1, '???');
  end;
end;

procedure MakeColumnsPrivileges(hParent: THandle; ID: Integer);
var
  lvc               : TLVColumnW;
begin
  lvc.mask := LVCF_TEXT or LVCF_WIDTH;
  lvc.pszText := 'Privileg';
  lvc.cx := 410;
  SendMessage(GetDlgItem(hParent, ID), LVM_INSERTCOLUMNW, 1, Integer(@lvc));
end;

procedure FillLVPrivileges(hParent: THandle; ID: Integer);
var
  Privileges        : TPrivilegeCollection;
  i                 : Integer;
  lvi               : TLVItem;
begin
  ZeroMemory(@lvi, sizeof(TLVItem));
  lvi.mask := LVIF_TEXT or LVIF_PARAM or LVIF_IMAGE;
  lvi.iImage := 1;
  Privileges := TPrivilegeCollection.GetAll(CurComputer);
  for i := 0 to Privileges.Count - 1 do
  begin
    lvi.iItem := i;
    lvi.pszText := PChar(Privileges.Items[i].Description);
    lvi.lParam := LPARAM(Privileges.Items[i]);
    SendDlgItemMessage(hParent, ID, LVM_INSERTITEM, 0, Integer(@lvi));
  end;
end;

function Thread(p: PThreadParams): Integer;
begin
  try
    FillLVGroups(p.hParent, ID_LV_GROUPS);
    FillLVPrivileges(p.hParent, ID_LV_PRIVILEGES);
  except
    on E: Exception do
      DisplayExceptionMsg(p.hParent, E.Errorcode, E.Message, rsErrorGetPrivilegesCap);
  end;
  Dispose(p);
  result := 0;
end;

procedure AddGroup(const Group, Comment: WideString);
var
  grp               : TGroup;
  lgi1              : TLocalGroupInfo1;
  hWnd              : THandle;
begin
  lgi1.lgrpi1_name := PWideChar(Group);
  lgi1.lgrpi1_comment := PWideChar(Comment);
  grp := TGroup.Create(CurComputer, lgi1);
  try
    grp.Add;
    SetItemTextW(hDialog, ID_EDT_GROUP, '');
    SetItemTextW(hDialog, ID_EDT_COMMENT, '');
    hWnd := FindWindowW(nil, PWideChar(WideString(rsWaitAddGroupCaption)));
    SetItemTextW(hWnd, 501, WideString(rsWaitPrivileges));
    FillLVGroups(hDialog, ID_LV_GROUPS);
  finally
    grp.Free;
  end;
end;

function AddThread(p: PAddThreadParams): Integer;
begin
  try
    AddGroup(p.GroupName, p.Comment);
  except
    on E: Exception do
      DisplayExceptionMsg(hDialog, E.Errorcode, E.Message, rsErrorAddGroup);
  end;
  Dispose(p);
  result := 0;
end;

procedure DelGroup(const Group: WideString);
var
  grp               : TGroup;
  lgi1              : TLocalGroupInfo1;
  hWnd              : THandle;
begin
  lgi1.lgrpi1_name := PwideChar(Group);
  grp := TGroup.Create(CurComputer, lgi1);
  try
    grp.Del;
    SetItemTextW(hDialog, ID_EDT_GROUP, '');
    SetItemTextW(hDialog, ID_EDT_COMMENT, '');
    hWnd := FindWindowW(nil, PWideChar(WideString(rsWaitDelGroupCaption)));
    SetItemTextW(hWnd, 501, WideString(rsWaitPrivileges));
    FillLVGroups(hDialog, ID_LV_GROUPS);
  finally
    grp.Free;
  end;
end;

function DelThread(p: PDelThreadParams): Integer;
begin
  try
    DelGroup(p.GroupNmae);
  except
    on E: Exception do
      DisplayExceptionMsg(hDialog, E.Errorcode, E.Message, rsErrorDelGroup);
  end;
  Dispose(p);
  result := 0;
end;

function groupmandlgproc(hDlg: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): bool; stdcall;
var
  rect, rect1       : TRect;
  x, y              : Cardinal;
  hParent           : THandle;
  hImageList        : THandle;
  hIcon             : THandle;
  Info              : TWaitInfo;
  ThreadParams      : PThreadParams;

  Privileges        : TPrivilegeCollection;
  lvi               : TLVItemW;
  i                 : Integer;
  lvfi              : TLVFindInfo;
  idx               : Integer;
  OldState          : Integer;
  NewState          : Integer;
  Privilege         : string;

  AddThreadParams   : PAddThreadParams;
  DelThreadParams   : PDelThreadParams;
  BtnMsgBox         : DWORD;
  Group             : WideString;
  Comment           : WideString;

  HelpFilename      : string;
  Url               : string;
begin
  Result := true;

  case uMsg of
    WM_INITDIALOG:
      begin
        hParent := PInfo(lParam).hParent;
        hDialog := hDlg;
        CurComputer := PInfo(lParam).CurComputer;

        GetWindowRect(hParent, rect);
        GetWindowRect(hDlg, rect1);
        x := rect.Left - ((rect.Left - rect.Right) div 2) - ((rect1.Right - rect1.Left) div 2);
        y := rect.Top - ((rect.Top - rect.Bottom) div 2) - ((rect1.Bottom - rect1.Top) div 2);
        SetWindowPos(hDlg, 0, x, y, 0, 0, SWP_NOSIZE);
        SetWindowPos(GetDlgItem(hDlg, 499), 0, 0, 0, rect.Right, 2, SWP_NOMOVE or SWP_SHOWWINDOW);

        SetWindowContextHelpId(GetDlgItem(hDlg, ID_LV_GROUPS), 16);
        SetWindowContextHelpId(GetDlgItem(hDlg, ID_LV_PRIVILEGES), 17);
        SetWindowContextHelpId(GetDlgItem(hDlg, ID_EDT_GROUP), 18);
        SetWindowContextHelpId(GetDlgItem(hDlg, ID_EDT_COMMENT), 19);
        SetWindowContextHelpId(GetDlgItem(hDlg, ID_BTN_SAVE_GRP), 20);
        SetWindowContextHelpId(GetDlgItem(hDlg, ID_BTN_DEL_GRP), 21);

        if SendMessage(hDlg, WM_SETICON, ICON_SMALL, Integer(LoadIcon(hInstance, MAKEINTRESOURCE(7)))) = 0 then
          SendMessage(hDlg, WM_SETICON, ICON_BIG, Integer(LoadIcon(hInstance, MAKEINTRESOURCE(7))));

        hImageList := ImageList_Create(16, 16, ILC_COLORDDB or ILC_MASK, 1, 0);
        hIcon := LoadIcon(hInstance, MAKEINTRESOURCE(3));
        ImageList_AddIcon(hImageList, hIcon);
        hIcon := LoadIcon(hInstance, MAKEINTRESOURCE(8));
        ImageList_AddIcon(hImageList, hIcon);
        SendDlgItemMessage(hDlg, ID_LV_GROUPS, LVM_SETIMAGELIST, LVSIL_SMALL, hImageList);
        SendDlgItemMessage(hDlg, ID_LV_PRIVILEGES, LVM_SETIMAGELIST, LVSIL_SMALL, hImageList);

        MakeColumnsGroups(hDlg, ID_LV_GROUPS);
        MakeColumnsPrivileges(hDlg, ID_LV_PRIVILEGES);
        SendDlgItemMessage(hDlg, ID_LV_PRIVILEGES, LVM_SETEXTENDEDLISTVIEWSTYLE, 0, LVS_EX_CHECKBOXES);

        Info.hParent := hDlg;
        Info.InfoText := rsWaitPrivileges;
        Info.Caption := rsWaitPrivilegesCaption;
        New(ThreadParams);
        ThreadParams.hParent := hDlg;
        WaitThread(@Thread, ThreadParams, Info);
        EnableControl(hDlg, ID_BTN_APPLYPRV, False);
        EnableControl(hDlg, ID_BTN_UNDO, False);
        EnableControl(hDlg, ID_BTN_HELP_GM, FileExists(ExtractFilepath(ParamStr(0)) + HELPFILE));
      end;
    WM_CLOSE:
      begin
        EndDialog(hDlg, 0);
      end;
    WM_COMMAND:
      begin
        if wParam = ID_CANCEL then
          EndDialog(hDlg, 0);
        if HiWord(wParam) = BN_CLICKED then
        begin
          case LoWord(wParam) of
            ID_BTN_HELP_GM:
              begin
                HelpFilename := ExtractFilepath(ParamStr(0)) + HELPFILE;
                Url := string(HelpFilename + '::hilfe.html#2');
                HtmlHelp(hDlg, PChar(Url), HH_DISPLAY_TOPIC, 0);
              end;
            ID_BTN_APPLYPRV:
              begin
                Group := GetLVItemText(hDlg, ID_LV_GROUPS, SendDlgItemMessage(hDlg, ID_LV_GROUPS, LVM_GETNEXTITEM, -1,
                  LVNI_FOCUSED));
                for i := 0 to SendDlgItemMessage(hDlg, ID_LV_PRIVILEGES, LVM_GETITEMCOUNT, 0, 0) - 1 do
                begin
                  lvi.mask := LVIF_PARAM;
                  lvi.iItem := i;
                  ListView_GetItemW(GetDlgItem(hDlg, ID_LV_PRIVILEGES), lvi);
                  Privilege := TPrivilege(lvi.lParam).Constant;
                  GrantPrivilege(CurComputer, Group, Privilege, ListView_GetCheckState(GetDlgItem(hDlg,
                    ID_LV_PRIVILEGES), i) <> 0);
                end;
                FillLVGroups(hDlg, ID_LV_GROUPS);
                ListView_SetCheckState(GetDlgItem(hDlg, ID_LV_PRIVILEGES), -1, False);
                EnableControl(hDlg, ID_BTN_APPLYPRV, False);
                EnableControl(hDlg, ID_BTN_UNDO, False);
                SetItemTextW(hDlg, ID_EDT_GROUP, '');
                SetItemTextW(hDlg, ID_EDT_COMMENT, '');
              end;
            ID_BTN_UNDO:
              begin
                ListView_SetCheckState(GetDlgItem(hDlg, ID_LV_PRIVILEGES), -1, False);
                ZeroMemory(@lvi, sizeof(lvi));
                lvi.mask := LVIF_TEXT or LVIF_PARAM;
                lvi.iItem := SendDlgItemMessage(hDlg, ID_LV_GROUPS, LVM_GETNEXTITEM, -1, LVNI_FOCUSED);
                ListView_GetItemW(GetDlgItem(hDlg, ID_LV_GROUPS), lvi);
                Privileges := TPrivilegeCollection(lvi.lParam);
                ZeroMemory(@lvfi, sizeof(lvfi));
                lvfi.flags := LVFI_STRING;
                for i := 0 to Privileges.Count - 1 do
                begin
                  lvfi.psz := PChar(Privileges.Items[i].Description);
                  idx := ListView_FindItem(GetDlgItem(hDlg, ID_LV_PRIVILEGES), -1, lvfi);
                  if idx > -1 then
                    ListView_SetCheckState(GetDlgItem(hDlg, ID_LV_PRIVILEGES), idx, True);
                end;
                EnableControl(hDlg, ID_BTN_APPLYPRV, False);
                EnableControl(hDlg, ID_BTN_UNDO, False);
              end;
            ID_BTN_SAVE_GRP:
              begin
                Group := GetItemTextW(hDlg, ID_EDT_GROUP);
                Comment := GetItemTextW(hDlg, ID_EDT_COMMENT);
                Info.hParent := hDlg;
                Info.InfoText := rsWaitAddGroup;
                Info.Caption := rsWaitAddGroupCaption;
                New(AddThreadParams);
                AddThreadParams.GroupName := Group;
                AddThreadParams.Comment := Comment;
                WaitThread(@AddThread, AddThreadParams, Info);
              end;
            ID_BTN_DEL_GRP:
              begin
                Group := GetItemTextW(hDlg, ID_EDT_GROUP);
                BtnMsgBox := MessageBox(hDlg, PChar(Format(rsDoDelGroup, [string(Group)])), PChar(rsCaptionDelGroup),
                  MB_YESNO or MB_ICONWARNING or MB_DEFBUTTON2);
                if BtnMsgBox = IDYES then
                begin
                  Info.hParent := hDlg;
                  Info.InfoText := rsWaitDelGroup;
                  Info.Caption := rsWaitDelGroupCaption;
                  New(DelThreadParams);
                  DelThreadParams.GroupNmae := Group;
                  WaitThread(@DelThread, DelThreadParams, Info);
                end;
              end;
            ID_BTN_GMCLOSE: EndDialog(hDlg, 0);
          end;
        end;
        if HiWord(wParam) = EN_CHANGE then
        begin
          case LoWord(wParam) of
            ID_EDT_GROUP:
              begin
                EnableControl(hDlg, ID_BTN_SAVE_GRP, Length(GetItemTextW(hDlg, ID_EDT_GROUP)) > 0);
                EnableControl(hDlg, ID_BTN_DEL_GRP, Length(GetItemTextW(hDlg, ID_EDT_GROUP)) > 0);
              end;
          end;
        end;
      end;
    WM_NOTIFY:
      begin
        if (PNMHdr(lParam).idFrom = ID_LV_GROUPS) then
        begin
          case PNMHDR(lParam)^.code of
            LVN_ITEMCHANGED:
              begin
                ListView_SetCheckState(GetDlgItem(hDlg, ID_LV_PRIVILEGES), -1, False);
                ZeroMemory(@lvi, sizeof(lvi));
                lvi.mask := LVIF_TEXT or LVIF_PARAM;
                lvi.iItem := PNMLISTVIEW(lParam)^.iItem;
                ListView_GetItemW(GetDlgItem(hDlg, ID_LV_GROUPS), lvi);
                // Gruppenname in Edit anzeigen
                Group := GetLVItemText(hDlg, ID_LV_GROUPS, lvi.iItem);
                //Group := GetLVItemTextW(hDlg, ID_LV_GROUPS, lvi);
                SetItemTextW(hDlg, ID_EDT_GROUP, Group);
                // Benutzerprivilegien wieder aus dem lParam hervorzaubern
                Privileges := TPrivilegeCollection(lvi.lParam);
                ZeroMemory(@lvfi, sizeof(lvfi));
                lvfi.flags := LVFI_STRING;
                for i := 0 to Privileges.Count - 1 do
                begin
                  lvfi.psz := PChar(Privileges.Items[i].Description);
                  idx := ListView_FindItem(GetDlgItem(hDlg, ID_LV_PRIVILEGES), -1, lvfi);
                  if idx > -1 then
                    ListView_SetCheckState(GetDlgItem(hDlg, ID_LV_PRIVILEGES), idx, True);
                end;
                EnableControl(hDlg, ID_BTN_APPLYPRV, False);
                EnableControl(hDlg, ID_BTN_UNDO, False)
              end;
          end;
        end;
        if (PNMHdr(lParam).idFrom = ID_LV_PRIVILEGES) then
        begin
          case PNMHDR(lParam)^.code of
            LVN_ITEMCHANGED:
              begin
                OldState := (PNMLISTVIEW(lParam)^.uOldState and LVIS_STATEIMAGEMASK shr 12) - 1;
                NewState := (PNMLISTVIEW(lParam)^.uNewState and LVIS_STATEIMAGEMASK shr 12) - 1;
                EnableControl(hDlg, ID_BTN_APPLYPRV, OldState <> NewState);
                EnableControl(hDlg, ID_BTN_UNDO, OldState <> NewState);
              end;
          end;
        end;
      end
  else
    Result := false;
  end;
end;

end.

