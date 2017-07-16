(******************************************************************************
 *                                                                            *
 *                             XP Usermanager                                 *
 *                             ==============                                 *
 *                                                                            *
 *  Project: Usermanager, Benutzerverwaltung für Windows NT, 2000, XP, Vista  *
 *  File   : Usermanager.dpr, Hauptprojektdatei mit Hauptdialog-Funktion      *
 *                                                                            *
 *  Copyright (c) Michael Puff  http://www.michael-puff.de                    *
 *                                                                            *
 ******************************************************************************)

{.$APPTYPE CONSOLE}
{.$DEFINE DEMO}

{$I CompilerSwitches.inc}

program Usermanager;

uses
  windows,
  CommCtrl,
  messages,
  ShellAPI,
  ActiveX,
  ShlObj,
  NTUser in 'units\core\NTUser.pas',
  List in 'units\helpers\List.pas',
  NetAPI in 'units\core\NetAPI.pas',
  MpuTools in 'units\common\MpuTools.pas',
  MpuRegistry in 'units\common\MpuRegistry.pas',
  AssasControls in 'units\helpers\AssasControls.pas',
  MpuWinNT in 'units\common\MpuWinNT.pas',
  CommCtrlW in 'units\helpers\CommCtrlW.pas',
  AboutDlg in 'units\dialogs\AboutDlg.pas',
  TabDlgs in 'units\dialogs\TabDlgs.pas',
  BrowseForFolderCls in 'units\helpers\BrowseForFolderCls.pas',
  GUIHelpers in 'units\helpers\GUIHelpers.pas',
  Consts in 'units\common\Consts.pas',
  ChooseComputerDlg in 'units\dialogs\ChooseComputerDlg.pas',
  Network in 'units\helpers\Network.pas',
  Settings in 'units\common\Settings.pas',
  Exceptions in 'units\helpers\Exceptions.pas',
  HtmlHlp in 'units\helpers\HtmlHlp.pas',
  GroupManagerDlg in 'units\dialogs\GroupManagerDlg.pas',
  lsaapi in 'units\core\lsaapi.pas',
  Export in 'units\helpers\Export.pas',
  MSXML2_TLB_Light in 'units\XML\MSXML2_TLB_Light.pas',
  ComObj_Light in 'units\XML\ComObj_Light.pas',
  Import in 'units\helpers\Import.pas';

{$R .\resources\resource1.res}
{$R .\resources\manifest.res}
{$I .\units\includes\ResStrings.inc}

type
  TThreadParams = record
    hParent: THandle;
    Filename: WideString;
  end;
  PThreadParams = ^TThreadParams;

var
  hApp              : THandle; // global Dialog Handle
  OldWndProc        : Pointer;
  bFirstTime        : Boolean = True;
  hMsgBoxHook       : THandle;

  CurComputer       : WideString;
  CurrentUser       : TUser;

  whitebrush        : HBRUSH = 0;
  WhiteLB           : TLogBrush =
    (
    lbStyle: BS_SOLID;
    lbColor: $00FFFFFF;
    lbHatch: 0
    );

////////////////////////////////////////////////////////////////////////////////

procedure WaitThread(ThreadFunc: TThreadFunc; Params: Pointer; Info: TWaitInfo);
var
  hThread           : THandle;
  ThreadID          : Cardinal;
  ExitCode          : DWORD;
  hToolbar          : THandle;
  dc                : THandle;
  hFont             : THandle;
  hObject           : THandle;
  tbRect            : TRect;
begin
  EnableWindow(Info.hParent, False);
  hToolbar := GetDlgItem(hApp, ID_TOOLBAR);
  GetClientRect(hToolbar, tbRect);
  tbRect.Right := tbRect.Right - 20;
  tbRect.Top := tbRect.Top + 7;
  dc := GetDC(hToolbar);
  SetBkMode(dc, TRANSPARENT);
  hFont := CreateFont(-12, 0, 0, 0, 0, 0, 0, 0, ANSI_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
    DEFAULT_QUALITY, DEFAULT_PITCH, 'Tahoma');
  hObject := SelectObject(dc, hFont);
  DrawTextW(dc, PWideChar(Info.InfoText), Length(Info.InfoText), tbRect, DT_RIGHT or DT_VCENTER);
  SetCursor(LoadCursor(0, IDC_WAIT));
  hThread := BeginThread(nil, 0, @ThreadFunc, Params, 0, ThreadID);
  repeat
    GetExitCodeThread(hThread, ExitCode);
    ProcessMessages(info.hParent);
    sleep(1);
  until ExitCode = 0;
  SelectObject(dc, hObject);
  DeleteObject(hFont);
  ReleaseDC(hApp, dc);
  InvalidateRect(hToolbar, @tbRect, True);
  SetCursor(LoadCursor(0, IDC_ARROW));
  EnableWindow(info.hParent, True);
end;

///// MainDlg - Helpers ////////////////////////////////////////////////////////

procedure DoClearTV(Tree: THandle; Item: HTREEITEM; Code: Integer);
var
  tvi               : TTVItemW;
  ItemText          : string[255];
begin
  while Assigned(Item) do
  begin
    ZeroMemory(@tvi, sizeof(TTVItemW));
    tvi.hItem := Item;
    tvi.mask := TVIF_PARAM or TVIF_TEXT or TVIF_CHILDREN;
    tvi.pszText := @ItemText[1];
    tvi.cchTextMax := sizeof(ItemText);
    CommCtrlW.TreeView_GetItemW(Tree, tvi);
    if Assigned(TObject(tvi.lParam)) then
    begin
      TObject(tvi.lParam).Free;
//      MessageBoxW(hApp, PWideChar(tvi.pszText), '', 0);
    end;
    if tvi.cChildren > 0 then
      DoClearTV(Tree, Treeview_GetNextItem(Tree, Item, TVGN_CHILD), 0);

    Item := TreeView_GetNextItem(Tree, Item, TVGN_NEXT);
  end;
end;

procedure FillTreeView(const Computer: WideString; items: TList);
var
  i, j              : Integer;
  tvi               : TTVInsertStructW;
  hr                : HTREEITEM;
  hParent           : HTREEITEM;
//  hTVItem           : HTREEITEM;
  hTV               : HWND;
  childList         : TList;
begin
  hTV := GetDlgItem(hApp, ID_TV);
  SendMessage(hTV, WM_SETREDRAW, Integer(False), 0);

  // in lParam gepeicherte Objektreferenzen freigeben
  //hTVItem := TreeView_GetRoot(hTV);
  //DoClearTV(hTV, hTVItem, TVGN_CHILD);

  TreeView_DeleteAllItems(hTV);

  if (items = nil) or (items.Count = 0) then
    Exit;

  ZeroMemory(@tvi, sizeof(tvi));
  tvi.hParent := nil;
  tvi.hInsertAfter := TVI_ROOT;
  tvi.item.mask := TVIF_TEXT or TVIF_IMAGE or TVIF_SELECTEDIMAGE or TVIF_PARAM;
  tvi.item.iImage := 3;
  tvi.item.iSelectedImage := 3;
  tvi.item.pszText := PWideChar(Computer);
  tvi.item.lParam := 0;
  hr := TreeView_InsertItemW(hTV, tvi);

  for i := 0 to items.Count - 1 do
  begin
    tvi.hParent := hr;
    tvi.hInsertAfter := TVI_SORT;
    tvi.item.iImage := TTVEntry(items[i]).GetImageIndex;
    tvi.item.iSelectedImage := tvi.item.iImage;
    tvi.item.pszText := PWideChar(TTVEntry(items[i]).GetCaption);
    tvi.item.lParam := LPARAM(items[i]);
    hParent := TreeView_InsertItemW(hTV, tvi);
    childList := TTVEntry(items[i]).GetChildList;
    if (childList <> nil) then
      for j := 0 to childList.Count - 1 do
      begin
        tvi.hParent := hParent;
        tvi.item.iImage := TTVEntry(childList[j]).GetImageIndex;
        tvi.item.iSelectedImage := tvi.item.iImage;
        tvi.item.pszText := PWideChar(TTVEntry(childList[j]).GetCaption);
        tvi.item.lParam := LPARAM(childList[j]);
        TreeView_InsertItemW(hTV, tvi);
      end;
  end;
  TreeView_Expand(hTV, hr, TVE_EXPAND);
  ExpandAll(hApp, ID_TV, GetMenuItemCheck(GetMenu(hApp), ID_MNU_EXPAND));
  SendMessage(hTV, WM_SETREDRAW, Integer(True), 0);
  items.Free;

  MyEnableMenuItem(GetMenu(hApp), ID_MNU_NEW, True);
  MyEnableMenuItem(GetMenu(hApp), ID_MNU_EXPAND, True);
  MyEnableMenuItem(GetMenu(hApp), ID_MNU_REFRESH, True);
  MyEnableMenuItem(GetMenu(hApp), ID_MNU_USER, True);
  MyEnableMenuItem(GetMenu(hApp), ID_MNU_GROUP, True);
  MyEnableMenuItem(GetMenu(hApp), ID_MNU_GRPMNG, True);
  MyEnableMenuItem(GetMenu(hApp), ID_MNU_EXPORT_CSV, True);
  MyEnableMenuItem(GetMenu(hApp), ID_MNU_EXPORT_XML, True);
  MyEnableMenuItem(GetMenu(hApp), ID_MNU_IMPORT_XML, True);
end;

procedure ResetDetails;
var
  Groups            : TGroupCollection;
  i                 : Integer;
  s                 : WideString;
begin
  bSetDetails := True;
  // Tab Konto
  SetItemTextW(hTabDlgs[0], ID_EDT_USER, '');
  SetItemTextW(hTabDlgs[0], ID_EDT_FULLNAME, '');
  SetItemTextW(hTabDlgs[0], ID_EDT_DESCRIPTION, '');
  SetItemTextW(hTabDlgs[0], ID_EDT_PW, '');
  SetItemTextW(hTabDlgs[0], ID_EDT_PW2, '');
  // Tab Einstellugen
  SetDlgBtnCheck(hTabDlgs[1], ID_CHK_MUST_CHANGE_PW, False);
  SetDlgBtnCheck(hTabDlgs[1], ID_CHK_CANT_CHANGE_PW, False);
  SetDlgBtnCheck(hTabDlgs[1], ID_CHK_PW_DONT_EXPIRE, False);
  SetDlgBtnCheck(hTabDlgs[1], ID_CHK_ACCOUNT_DISABLED, False);
  SetItemTextW(hTabDlgs[1], ID_EDT_HOMEDIR, '');
  SetItemTextW(hTabDlgs[1], ID_EDT_SCRIPT_PATH, '');
  // Tab Login
  SetDlgBtnCheck(htabDlgs[2], ID_CHK_AUTO_LOGIN, False);
  EnableControl(hTabDlgs[2], ID_EDT_AUTO_LOGIN, False);
  SetDlgItemText(hTabDlgs[2], ID_EDT_AUTO_LOGIN, '');
  SetDlgBtnCheck(hTabDlgs[2], ID_CHK_HIDE_ACCOUNT, False);
  // Tab Gruppen
  SendDlgItemMessage(hTabDlgs[3], ID_LV_USERGROUPS, LVM_DELETEALLITEMS, 0, 0);
  Groups := TGroupCollection.GetAll(CurComputer);
  try
    for i := 0 to Groups.Count - 1 do
    begin
      s := Groups.Items[i].GetCaption;
      LVAddCaptionW(hTabDlgs[3], ID_LV_USERGROUPS, i, s, 2);
    end;
  finally
    Groups.Free;
  end;
  ListView_SetCheckState(GetDlgItem(hTabDlgs[3], ID_LV_USERGROUPS), -1, False);
  // Listview
  SetLVSubItemtextW(hApp, ID_LV, 0, 1, '');
  SetLVSubItemTextW(hApp, ID_LV, 1, 1, '');
  SetLVSubItemTextW(hApp, ID_LV, 2, 1, '');
  SetLVSubItemTextW(hApp, ID_LV, 3, 1, '');
  SetLVSubItemTextW(hApp, ID_LV, 4, 1, '');
  SetLVSubItemTextW(hApp, ID_LV, 5, 1, '');
  SetLVSubItemTextW(hApp, ID_LV, 6, 1, '');

  bPWHasChanged := False;

  SendDlgItemMessage(hTabDlgs[0], ID_EDT_USER, EM_SETREADONLY, Integer(True), 0);
  Enable_ToolbarButton(GetDlgItem(hApp, ID_TOOLBAR), ID_MNU_SAVE, False);
  MyEnableMenuItem(GetMenu(hApp), ID_MNU_SAVE, False);
  Enable_ToolbarButton(GetDlgItem(hApp, ID_TOOLBAR), ID_MNU_SAVE, False);
  MyEnableMenuItem(GetMenu(hApp), ID_MNU_DEL, False);

  bSetDetails := False;
end;

procedure SetDetails(User: TUser);
var
  i                 : Integer;
  lvfi              : TLVFindInfoW;
  idx               : Integer;
begin
  ResetDetails;
  bSetDetails := True;
  try
    with User do
    begin
      // Tab Konto
      SetItemTextW(hTabDlgs[0], ID_EDT_USER, Name);
      SetItemTextW(hTabDlgs[0], ID_EDT_FULLNAME, FullName);
      SetItemTextW(hTabDlgs[0], ID_EDT_DESCRIPTION, Description);
      SetItemTextW(hTabDlgs[0], ID_EDT_HOMEDIR, HomeDir);
      SetItemTextW(hTabDlgs[0], ID_EDT_SCRIPT_PATH, ScriptPath);

      // Tab Einstellugen
      SetDlgBtnCheck(hTabDlgs[1], ID_CHK_MUST_CHANGE_PW, MustChangePW);
      SetDlgBtnCheck(hTabDlgs[1], ID_CHK_CANT_CHANGE_PW, CantChangePW);
      SetDlgBtnCheck(hTabDlgs[1], ID_CHK_PW_DONT_EXPIRE, DontExpire);
      SetDlgBtnCheck(hTabDlgs[1], ID_CHK_ACCOUNT_DISABLED, Deactivated);
      // Tab Login
      SetDlgBtnCheck(htabDlgs[2], ID_CHK_AUTO_LOGIN, AutoLogin);
      EnableControl(hTabDlgs[2], ID_EDT_AUTO_LOGIN, AutoLogin);
      SetDlgBtnCheck(hTabDlgs[2], ID_CHK_HIDE_ACCOUNT, HideAccount);
      // Tab Gruppen
      if Assigned(user.Groups) then
      begin
        ZeroMemory(@lvfi, sizeof(TLVFindInfoW));
        lvfi.flags := LVFI_STRING;
        for i := 0 to User.Groups.Count - 1 do
        begin
          lvfi.psz := PWideChar(User.Groups.Items[i].GetCaption);
          idx := SendDlgItemMessageW(hTabDlgs[3], ID_LV_USERGROUPS, LVM_FINDITEMW, NativeUInt(-1), LPARAM(@lvfi));
          if idx > -1 then
            ListView_SetCheckState(GetDlgItem(hTabDlgs[3], ID_LV_USERGROUPS), idx, True);
        end;
      end;
      // Listview
      SetLVSubItemtextW(hApp, ID_LV, 0, 1, FormatTime(Int64(PWAge) * 1000));
      SetLVSubItemTextW(hApp, ID_LV, 1, 1, SecsToDateTime(LastLogon));
      SetLVSubItemTextW(hApp, ID_LV, 2, 1, IntToStr(CountLogons));
      if AccountExpires = DWORD(-1) then
        SetLVSubItemTextW(hApp, ID_LV, 3, 1, rsDontExpire)
      else
        SetLVSubItemTextW(hApp, ID_LV, 3, 1, SecsToDateTime(AccountExpires));
    end;
  except
    // do nothing
  end;
  Enable_ToolbarButton(GetDlgItem(hApp, ID_TOOLBAR), ID_MNU_SAVE, False);
  MyEnableMenuItem(GetMenu(hApp), ID_MNU_SAVE, False);

  bSetDetails := False;
end;

function RefreshThread(p: Pointer): Integer;
var
  tvi               : TTVInsertStructW;
  hTV               : THandle;
begin

  hTV := GetDlgItem(hApp, ID_TV);
  try
    if GetMenuItemCheck(GetMenu(hApp), ID_MNU_USER) then
      FillTreeView(CurComputer, TUserCollection.GetAll(CurComputer))
    else
      FillTreeView(CurComputer, TGroupCollection.GetAll(CurComputer));
  except
    on
      E: Exception do
    begin
      TreeView_DeleteAllItems(hTV);
      ZeroMemory(@tvi, sizeof(TTVInsertStructW));
      tvi.hParent := nil;
      tvi.hInsertAfter := TVI_ROOT;
      tvi.item.mask := TVIF_TEXT and not TVIF_IMAGE and not TVIF_SELECTEDIMAGE;
      tvi.item.iImage := -1;
      tvi.item.pszText := 'keine Benutzerliste verfügbar';
      TreeView_InsertItemW(hTV, tvi);
      MyEnableMenuItem(GetMenu(hApp), ID_MNU_NEW, False);
      MyEnableMenuItem(GetMenu(hApp), ID_MNU_EXPAND, False);
      MyEnableMenuItem(GetMenu(hApp), ID_MNU_REFRESH, False);
      MyEnableMenuItem(GetMenu(hApp), ID_MNU_USER, False);
      MyEnableMenuItem(GetMenu(hApp), ID_MNU_GROUP, False);
      MyEnableMenuItem(GetMenu(hApp), ID_MNU_GRPMNG, False);
      MyEnableMenuItem(GetMenu(hApp), ID_MNU_EXPORT_CSV, False);
      MyEnableMenuItem(GetMenu(hApp), ID_MNU_EXPORT_XML, False);
      MyEnableMenuItem(GetMenu(hApp), ID_MNU_IMPORT_XML, False);
      DisplayExceptionMsg(hApp, E.Errorcode, E.Message, rsErrorSelComputer);
      result := 0;
      exit;
    end;
  end;

  Dispose(p);
  ResetDetails;

  result := 0;
end;

procedure Refresh;
var
  Info              : TWaitInfo;
  ThreadParams      : PThreadParams;
begin
  Info.hParent := hApp;
  Info.InfoText := rsWaitUserDetails;
  Info.Caption := rsWaitUserDetailsCaption;

  New(ThreadParams);
  ThreadParams.hParent := hApp;
  WaitThread(RefreshThread, ThreadParams, Info);
  //BringWindowToTop(hApp);
end;

function SaveThread(p: Pointer): Integer;
var
  tvi               : TTVInsertStructW;
  hTV               : THandle;
  i                 : Integer;
  s                 : WideString;
  NewUser           : TUser;
  ui3               : PUserInfo3;

begin
  if (EditMode and MODE_NEWUSER) = MODE_NEWUSER then
  begin
    GetMem(ui3, sizeof(TUserInfo3));
    ZeroMemory(ui3, sizeof(TUserInfo3));
    ui3.usri3_name := PWideChar(GetItemTextW(hTabDlgs[0], ID_EDT_USER));
    NewUser := TUser.Create(WideString(CurComputer), ui3);
    FreeMemory(ui3);
    try
      NewUser.Password := GetItemTextW(hTabDlgs[0], ID_EDT_PW);
      NewUser.Add;
      CurrentUser := NewUser;
    except
      on E: Exception do
      begin
        DisplayExceptionMsg(hApp, E.Errorcode, E.Message, rsErrorAddUser);
        ResetDetails;
        result := 0;
        Exit;
      end;
    end;
  end;

  with CurrentUser do
  begin
    try
      FullName := GetItemTextW(hTabDlgs[0], ID_EDT_FULLNAME);
      Description := GetItemTextW(hTabDlgs[0], ID_EDT_DESCRIPTION);
      if bPWHasChanged then
      begin
        Password := GetItemTextW(hTabDlgs[0], ID_EDT_PW);
        bPWHasChanged := False;
      end;
      if GetDlgBtnCheck(hTabDlgs[0], ID_CHK_RESET_PW) then
        Password := '';

      MustChangePW := GetDlgBtnCheck(hTabDlgs[1], ID_CHK_MUST_CHANGE_PW);
      CantChangePW := GetDlgBtnCheck(hTabDlgs[1], ID_CHK_CANT_CHANGE_PW);
      DontExpire := GetDlgBtnCheck(hTabDlgs[1], ID_CHK_PW_DONT_EXPIRE);
      Deactivated := GetDlgBtnCheck(hTabDlgs[1], ID_CHK_ACCOUNT_DISABLED);
      HomeDir := GetItemTextW(hTabDlgs[1], ID_EDT_HOMEDIR);
      ScriptPath := GetItemTextW(hTabDlgs[1], ID_EDT_SCRIPT_PATH);

      AutoLoginPW := GetItemTextW(hTabDlgs[2], ID_EDT_AUTO_LOGIN);
      if bAutoLoginHasChanged then
        AutoLogin := GetDlgBtnCheck(hTabDlgs[2], ID_CHK_AUTO_LOGIN);
      bAutoLoginHasChanged := False;
      HideAccount := GetDlgBtnCheck(hTabDlgs[2], ID_CHK_HIDE_ACCOUNT);

      for i := 0 to SendDlgItemMessage(hTabDlgs[3], ID_LV_USERGROUPS, LVM_GETITEMCOUNT, 0, 0) - 1 do
      begin
        s := GetLVItemText(hTabDlgs[3], ID_LV_USERGROUPS, i);
        if ListView_GetCheckState(GetDlgItem(hTabDlgs[3], ID_LV_USERGROUPS), i) <> 0 then
          AddGroup := s
        else
          RemoveGroup := s;
      end;

      CurrentUser.Save;
    except
      on E: Exception do
      begin
        DisplayExceptionMsg(hApp, E.Errorcode, E.Message, rsErrorSaveUser);
      end;
    end;
  end;

  hTV := GetDlgItem(hApp, ID_TV);
  try
    if GetMenuItemCheck(GetMenu(hApp), ID_MNU_USER) then
      FillTreeView(CurComputer, TUserCollection.GetAll(CurComputer))
    else
      FillTreeView(CurComputer, TGroupCollection.GetAll(CurComputer));
  except
    on
      E: Exception do
    begin
      TreeView_DeleteAllItems(hTV);
      ZeroMemory(@tvi, sizeof(TTVInsertStructW));
      tvi.hParent := nil;
      tvi.hInsertAfter := TVI_ROOT;
      tvi.item.mask := TVIF_TEXT and not TVIF_IMAGE and not TVIF_SELECTEDIMAGE;
      tvi.item.iImage := -1;
      tvi.item.pszText := 'keine Benutzerliste verfügbar';
      TreeView_InsertItemW(hTV, tvi);
      DisplayExceptionMsg(hApp, E.Errorcode, E.Message, rsErrorSelComputer);
    end;
  end;

  EditMode := MODE_NEUTRAL;
  Dispose(p);
  ResetDetails;

  result := 0;
end;

procedure Save;
var
  Info              : TWaitInfo;
  ThreadParams      : PThreadParams;
begin
  Info.hParent := hApp;
  Info.InfoText := rsWaitUserDetails;
  Info.Caption := rsWaitUserDetailsCaption;

  New(ThreadParams);
  ThreadParams.hParent := hApp;
  WaitThread(SaveThread, ThreadParams, Info);
end;

function DelThread(p: Pointer): Integer;
var
  hTV               : THandle;
  tvi               : TTVInsertStructW;
begin

  try
    CurrentUser.Del;
  except
    on E: Exception do
    begin
      DisplayExceptionMsg(hApp, E.Errorcode, E.Message, rsErrorDelUser);
      ResetDetails;
      result := 0;
      exit
    end;
  end;

  hTV := GetDlgItem(hApp, ID_TV);
  try
    if GetMenuItemCheck(GetMenu(hApp), ID_MNU_USER) then
      FillTreeView(CurComputer, TUserCollection.GetAll(CurComputer))
    else
      FillTreeView(CurComputer, TGroupCollection.GetAll(CurComputer));
  except
    on
      E: Exception do
    begin
      TreeView_DeleteAllItems(hTV);
      ZeroMemory(@tvi, sizeof(TTVInsertStructW));
      tvi.hParent := nil;
      tvi.hInsertAfter := TVI_ROOT;
      tvi.item.mask := TVIF_TEXT and not TVIF_IMAGE and not TVIF_SELECTEDIMAGE;
      tvi.item.iImage := -1;
      tvi.item.pszText := 'keine Benutzerliste verfügbar';
      TreeView_InsertItemW(hTV, tvi);
      DisplayExceptionMsg(hApp, E.Errorcode, E.Message, rsErrorSelComputer);
    end;
  end;

  Dispose(p);

  result := 0;
end;

procedure Del;
var
  Info              : TWaitInfo;
  ThreadParams      : PThreadParams;
begin
  Info.hParent := hApp;
  Info.InfoText := rsWaitDel;
  Info.Caption := rsWaitDelCaption;

  New(ThreadParams);
  ThreadParams.hParent := hApp;
  WaitThread(DelThread, ThreadParams, Info);
end;

function ExportCSVThread(p: Pointer): Integer;
var
  ExportUsers       : TExport;
  hDlg              : THandle;
  Filename          : WideString;
begin
  hDlg := PThreadParams(p)^.hParent;
  Filename := PThreadParams(p)^.Filename;
  ExportUsers := TExport.Create;
  try
    ExportUsers.Filename := Filename;
    ExportUsers.Users := TUserCollection.GetAll(CurComputer);
    ExportUsers.ExportToCSV;
  except
    on E: Exception do
      MessageBoxW(hDlg, PWideChar(E.Message), PWideChar(WideString(rsErrorExport)), MB_ICONSTOP);
  end;
  Result := 0;
end;

procedure ExportCSV(Filename: WideString);
var
  Info              : TWaitInfo;
  ThreadParams      : PThreadParams;
begin
  Info.hParent := hApp;
  Info.InfoText := rsWaitExportCSV;
  Info.Caption := rsWaitExportCSVCaption;

  New(ThreadParams);
  ThreadParams.hParent := hApp;
  ThreadParams.Filename := Filename;
  WaitThread(ExportCSVThread, ThreadParams, Info);
  BringWindowToTop(hApp);
end;

function ExportXMLThread(p: Pointer): Integer;
var
  ExportUsers       : TExport;
  hDlg              : THandle;
  Filename          : WideString;
begin
  hDlg := PThreadParams(p)^.hParent;
  Filename := PThreadParams(p)^.Filename;
  ExportUsers := TExport.Create;
  try
    ExportUsers.Filename := Filename;
    ExportUsers.Computer := CurComputer;
    ExportUsers.Users := TUserCollection.GetAll(CurComputer);
    ExportUsers.ExportToXML;
  except
    on E: Exception do
      MessageBoxW(hDlg, PWideChar(E.Message), PWideChar(WideString(rsErrorExport)), MB_ICONSTOP);
  end;
  Result := 0;
end;

procedure ExportXML(Filename: WideString);
var
  Info              : TWaitInfo;
  ThreadParams      : PThreadParams;
begin
  Info.hParent := hApp;
  Info.InfoText := rsWaitExportXML;
  Info.Caption := rsWaitExportXMLCaption;

  New(ThreadParams);
  ThreadParams.hParent := hApp;
  ThreadParams.Filename := Filename;
  WaitThread(ExportXMLThread, ThreadParams, Info);
  BringWindowToTop(hApp);
end;

function ImportXMLThread(p: Pointer): Integer;
var
  ImPort            : TImport;
  Filename          : WideString;
begin
  Filename := PThreadParams(p)^.Filename;
  Import := TImport.Create(CurComputer, Filename);
  try
    if not Import.Import then
    begin
      SetCursor(LoadCursor(0, IDC_ARROW));
      case MessageBox(hApp, PChar(Format(rsImportError, [ExtractFilepath(ParamStr(0)) + LOGFILE])), PChar(APPNAME),
        MB_ICONWARNING or MB_YESNO) of
        IDYES: ShellExecute(hApp, 'open', PChar(ExtractFilepath(ParamStr(0)) + LOGFILE), nil, nil, SW_NORMAL);
      end;
    end;
  finally
    Import.Free;
  end;
  Result := 0;
end;

procedure ImportXML(Filename: WideString);
var
  Info              : TWaitInfo;
  ThreadParams      : PThreadParams;
begin
  Info.hParent := hApp;
  Info.InfoText := rsWaitImport;
  Info.Caption := rsWaitImportXMLCaption;

  New(ThreadParams);
  ThreadParams.hParent := hApp;
  ThreadParams.Filename := Filename;
  WaitThread(ImportXMLThread, ThreadParams, Info);
end;

procedure MakeColumnsUserInfo;
var
  lvc               : TLVColumnW;
begin
  lvc.mask := LVCF_TEXT or LVCF_WIDTH;
  lvc.pszText := 'Parameter';
  lvc.cx := 140;
  SendMessage(GetDlgItem(hApp, ID_LV), LVM_INSERTCOLUMNW, 1, Integer(@lvc));
  lvc.pszText := 'Wert';
  lvc.cx := 160;
  SendMessage(GetDlgItem(hApp, ID_LV), LVM_INSERTCOLUMNW, 2, Integer(@lvc));
end;

procedure MakeColumnsUserGroups;
var
  lvc               : TLVColumnW;
begin
  lvc.mask := LVCF_TEXT or LVCF_WIDTH;
  lvc.pszText := PWideChar(WideString(rsUserGroups));
  lvc.cx := 285;
  SendMessage(GetDlgItem(hTabDlgs[3], ID_LV_USERGROUPS), LVM_INSERTCOLUMNW, 1, Integer(@lvc));
end;

procedure FillLVGroups;
var
  Groups            : TGroupCollection;
  i                 : Integer;
  s                 : WideString;
begin
  ListView_DeleteAllItems(GetDlgItem(hTabDlgs[3], ID_LV_USERGROUPS));
  Groups := TGroupCollection.GetAll(CurComputer);
  try
    for i := 0 to Groups.Count - 1 do
    begin
      s := Groups.Items[i].Name;
      LVAddCaptionW(hTabDlgs[3], ID_LV_USERGROUPS, i, s, 2);
    end;
  finally
    Groups.Free;
  end;
end;

procedure LabelFirstColumn;
const
  ItemTextArray     : array[0..3] of string = (rsPWAge, rsLastLogon, rsCntLogons, rsAccountExpires);
var
  lvi               : TLVItem;
  i                 : Integer;
begin
  lvi.mask := LVIF_TEXT;
  for i := 0 to length(ItemTextArray) - 1 do
  begin
    lvi.iItem := i;
    lvi.iSubItem := 0;
    lvi.pszText := PChar(ItemTextArray[i]);
    SendDlgItemMessage(hApp, ID_LV, LVM_INSERTITEM, 0, Integer(@lvi));
  end;
end;

///// MainDlg //////////////////////////////////////////////////////////////////

function LabelWndProc(hLabel: THandle; uMsg: DWORD; wParam, lParam: DWORD): DWORD; stdcall;
var
  ps                : TPAINTSTRUCT;
  brush             : HBRUSH;
  dc                : HDC;
  hFont             : THandle;
  rect              : TRect;
  OldObject         : DWORD;
begin
  Result := 0;
  case uMsg of
    WM_PAINT:
      begin
        dc := BeginPaint(hLabel, ps);
        GetClientRect(hLabel, rect);
        brush := CreateSolidBrush(RGB(255, 255, 255));
        FillRect(dc, rect, brush);

        hFont := CreateFont(FontSize, 0, 0, 0, 900, 0, 0, 0, ANSI_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
          DEFAULT_QUALITY, DEFAULT_PITCH, FontName);
        OldObject := SelectObject(dc, hFont);

        DrawTextW(dc, PWideChar(WideString(APPNAME)), length(APPNAME), rect, DT_CENTER or DT_VCENTER or
          DT_SINGLELINE);
        //DrawShadowText(dc, PWideChar(WideString(APPNAME)), length(APPNAME), @rect, DT_CENTER or DT_VCENTER or
//          DT_SINGLELINE, COLORREF(RGB(1, 0, 0)), COLORREF(RGB(150, 150, 150)), 3, 4);

        DeleteObject(SelectObject(dc, OldObject));

{$IFDEF DEMO}
        SetTextColor(dc, RGB(255, 0, 0));
        rect.Top := rect.Top + 3;
        rect.Right := rect.Right - 10;
        DrawText(dc, PChar(rsDemo), length(rsDemo), rect, DT_CENTER);
{$ENDIF}
        EndPaint(hLabel, ps);
      end;
  else
    Result := CallWindowProc(OldWndProc, hLabel, uMsg, wParam, lParam);
  end;
end;

function CBTProc(nCode: Integer; wP: WPARAM; lP: LPARAM): LRESULT; stdcall;
var
  Handle            : THandle;
  hBtn              : THandle;
begin
  if nCode < 0 then
  begin
    result := CallNextHookEx(hMsgBoxHook, nCode, wP, lP);
    exit;
  end;
  case nCode of
    HCBT_ACTIVATE:
      begin
        Handle := wP;
        hBtn := GetDlgItem(Handle, IDABORT);
        SetWindowText(hBtn, PChar(rsAbort));
        hBtn := GetDlgItem(Handle, IDRETRY);
        SetWindowText(hBtn, PChar(rsRetry));
        hBtn := GetDlgItem(Handle, IDIGNORE);
        SetWindowText(hBtn, PChar(rsIgnore));
        result := 0;
        exit;
      end;
  end;
  result := CallNextHookEx(hMsgBoxHook, nCode, wP, lP);
end;

function MainDlgFunc(hDlg: hWnd; uMsg: dword; wParam: wParam; lParam: lParam): bool; stdcall;
var
  s, s1             : WideString;
  Handle            : THandle;
  hIcon             : THandle;
  hBitmap           : THandle;
  hToolbar          : THandle;
  aBmp              : TTBAddBitmap;
  cm                : TColorMap;
  hImageList        : THandle;
  rec, rec2         : TRect;
  pt1, pt2          : TPoint;
  HeightTB          : Cardinal;
  TabIndex          : Integer;
  tcItem            : TTcItem;
  PanelWidth        : array[0..4] of Integer;
  i                 : Integer;
  ps                : TPaintStruct;

  CurCompData       : PCurCompData;
  ErrorCode         : DWORD;
  ret               : Integer;

  Settings          : TSettings;

  obj               : TObject;

  Info              : Pinfo;

  Filename          : WideString;

  hTVItem           : HTREEITEM;

begin

  Result := True;
  case uMsg of
    WM_INITDIALOG:
      begin
        OldWndProc := Pointer(SetWindowLong(GetDlgItem(hDlg, 101), GWL_WNDPROC, Integer(@LabelWndProc)));
        hApp := hDlg;
        CurComputer := '\\' + GetCompName;

        SetWindowContextHelpId(GetDlgItem(hDlg, ID_TV), 15);
        SetWindowContextHelpId(GetDlgItem(hDlg, 101), 22);

        // Window-Icons
        if SendMessage(hDlg, WM_SETICON, ICON_SMALL, Integer(LoadIcon(hInstance, MAKEINTRESOURCE(1)))) = 0 then
          SendMessage(hDlg, WM_SETICON, ICON_BIG, Integer(LoadIcon(hInstance, MAKEINTRESOURCE(1))));
        SetWindowTextW(hDlg, PWideChar(FormatW(rsWndCaption, [CurComputer, WideString(APPNAME)])));
        // Banner
        Handle := CreateFont(FontSize, 0, 0, 0, 900, 0, 0, 0, ANSI_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
          DEFAULT_QUALITY, DEFAULT_PITCH, FontName);
        if Handle <> 0 then
          SendDlgItemMessage(hDlg, 101, WM_SETFONT, Integer(Handle), Integer(true));

        // Menü
        MyEnableMenuItem(GetMenu(hDlg), ID_MNU_HELP, FileExists(ExtractFilepath(ParamStr(0)) + HELPFILE));

        // Toolbar
        cm.cFrom := $00C7C7C7; // der graue Hintergrund in deiner Bitmap
        cm.cTo := GetSysColor(COLOR_BTNFACE);
        hBitmap := CreateMappedBitmap(hInstance, 199, 0, @cm, 1);
        hToolbar := CreateWindowEx(0, TOOLBARCLASSNAME, nil, WS_CHILD or WS_VISIBLE or TBSTYLE_FLAT or
          TBSTYLE_TOOLTIPS, 0, 0, 0, 0, hDlg, ID_TOOLBAR, hInstance, nil);
        SendMessage(hToolBar, TB_BUTTONSTRUCTSIZE, sizeof(TTBBUTTON), 0);
        SendMessage(hToolbar, TB_SETBITMAPSIZE, 0, MAKELONG(24, 30));
        SendMessage(hToolBar, TB_ADDBUTTONS, 7, Integer(@TBButtons));
        aBmp.hInst := 0;
        aBmp.nID := hBitmap;
        SendMessage(hToolBar, TB_ADDBITMAP, 5, Integer(@aBmp));

        // Tabcontrol
        tcItem.mask := TCIF_TEXT;
        tcItem.pszText := PChar(rsTabAccount);
        SendMessage(GetDlgItem(hDlg, ID_TAB), TCM_INSERTITEM, 0, Integer(@tcItem));
        tcItem.pszText := PChar(rsTabSettings);

        SendMessage(GetDlgItem(hDlg, ID_TAB), TCM_INSERTITEM, 1, Integer(@tcItem));
        tcItem.pszText := PChar(rsTabLogin);
        SendMessage(GetDlgItem(hDlg, ID_TAB), TCM_INSERTITEM, 2, Integer(@tcItem));
        tcItem.pszText := PCHar(rsTabGroups);

        SendMessage(GetDlgItem(hDlg, ID_TAB), TCM_INSERTITEM, 3, Integer(@tcItem));
        for i := 0 to length(hTabDlgs) - 1 do
        begin
          hTabDlgs[i] := CreateDialogParam(hInstance, MAKEINTRESOURCE(100 + 10 * (i + 1)), hDlg, @tabdlgfunc, hDlg);
          ShowWindow(hTabDlgs[i], SW_HIDE);
          LoadThemeDLL(hTabDlgs[i], ETDT_ENABLE or ETDT_USETABTEXTURE);
        end;
        GetWindowRect(GetDlgItem(hDlg, ID_TAB), rec);
        pt1.X := rec.Left;
        pt1.Y := rec.Top;
        pt2.X := rec.Right;
        pt2.Y := rec.Bottom;
        ScreenToClient(hDlg, pt1);
        ScreenToClient(hDlg, pt2);
        SetWindowPos(hTabDlgs[0], 0, pt1.X + 1, pt1.Y + 21, pt2.X - pt1.X - 4, pt2.Y - pt1.Y - 25, SWP_SHOWWINDOW);

        // Statusbar
        Handle := CreateWindowEx(0, STATUSCLASSNAME, nil, WS_CHILD or WS_VISIBLE or SBT_TOOLTIPS, 0, 0, 0, 0, hDlg,
          ID_STATBAR, hInstance, nil);
        PanelWidth[0] := 250;
        PanelWidth[1] := 380;
        PanelWidth[2] := 535;
        PanelWidth[3] := -1;
        SendMessage(Handle, SB_SETPARTS, 4, Integer(@PanelWidth));
        hIcon := LoadImage(HInstance, MAKEINTRESOURCE(4), IMAGE_ICON, 16, 16, LR_DEFAULTCOLOR);
        SendMessage(Handle, SB_SETICON, 0, hIcon);
        hIcon := LoadImage(HInstance, MAKEINTRESOURCE(10), IMAGE_ICON, 16, 16, LR_DEFAULTCOLOR);
        SendMessage(Handle, SB_SETICON, 1, hIcon);
        hIcon := LoadImage(HInstance, MAKEINTRESOURCE(2), IMAGE_ICON, 16, 16, LR_DEFAULTCOLOR);
        SendMessage(Handle, SB_SETICON, 2, hIcon);
        ErrorCode := GetServerCommentW(CurComputer, s1);
        if ErrorCode = 0 then
        begin
          s := CurComputer + ' ' + '"' + s1 + '"';
          SendMessageW(Handle, SB_SETTEXTW, 0, Integer(@s[1]));
          SendMessageW(Handle, SB_SETTIPTEXTW, 0, Integer(@s[1]));
        end
        else
          DisplayErrorMsg(hDlg, ErrorCode, SysErrorMessage(ErrorCode), rsErrorGetServerComment);
        s := '';
        s := GetOS(CurComputer);
        SendMessageW(Handle, SB_SETTEXTW, 1, Integer(PWideChar(s)));
        SendMessageW(Handle, SB_SETTIPTEXTW, 1, Integer(PWideChar(s)));
        s := GetCurrUserName;
        SendMessageW(Handle, SB_SETTEXTW, 2, Integer(PWideChar(s)));
        SendMessageW(Handle, SB_SETTIPTEXTW, 2, Integer(PWideChar(s)));

        SendMessage(Handle, SB_SETTEXT, 3, Integer(PChar(GetFileVersion(ParamStr(0)))));

        // ImageList
        hImageList := ImageList_Create(16, 16, ILC_COLORDDB or ILC_MASK, 7, 0);
        for i := 1 to 4 do
        begin
          hIcon := LoadIcon(hInstance, MAKEINTRESOURCE(i));
          ImageList_AddIcon(hImageList, hIcon);
        end;
        hIcon := LoadIcon(hInstance, MAKEINTRESOURCE(9));
        ImageList_AddIcon(hImageList, hIcon);

        // Treeview
        TreeView_SetImageList(GetDlgItem(hDlg, ID_TV), hImageList, TVSIL_NORMAL);

        // Listview
        MakeColumnsUserInfo;
        LabelFirstColumn;

        // Groups
        MakeColumnsUserGroups;
        SendDlgItemMessage(hTabDlgs[3], ID_LV_USERGROUPS, LVM_SETIMAGELIST, LVSIL_SMALL, hImageList);
        SendDlgItemMessage(hTabDlgs[3], ID_LV_USERGROUPS, LVM_SETEXTENDEDLISTVIEWSTYLE, 0, LVS_EX_CHECKBOXES);
        FillLVGroups;

        Settings := TSettings.Create(CurComputer, HKEY_CURRENT_USER);
        try
          SetMenuItemCheck(GetMenu(hDlg), ID_MNU_EXPAND, Settings.ExpandAll);
          if Settings.ShowUsers then
            CheckMenuRadioItem(GetMenu(hDlg), ID_MNU_USER, ID_MNU_GROUP, ID_MNU_USER, MF_BYCOMMAND or MF_CHECKED)
          else
            CheckMenuRadioItem(GetMenu(hDlg), ID_MNU_USER, ID_MNU_GROUP, ID_MNU_GROUP, MF_BYCOMMAND or MF_CHECKED);
        finally
          Settings.Free;
        end;

        //Refresh;
      end;
    WM_PAINT:
      begin
        BeginPaint(hDlg, ps);
        if bFirstTime then
        begin
          bFirstTime := False;
{$IFDEF DEMO}
          // lokalen CBT-Hook installieren
          hMsgBoxHook := SetWindowsHookEx(WH_CBT, @CBTProc, 0, GetCurrentThreadId);
          if hMsgBoxHook <> 0 then
          begin
            // MessageBox aufrufen
            case MessageBoxW(hDlg, PWideChar(WideString(rsDemo)), PWideChar(WideString(APPNAME)), MB_ABORTRETRYIGNORE
              or
              MB_ICONINFORMATION)
              of
              IDABORT: Shellexecute(hDlg, 'open', 'http://xpusermanager.de', nil, nil, SW_SHOWNORMAL);
              IDIGNORE:
                begin
                  PostMessage(hDlg, WM_CLOSE, 0, 0);
                end;
            end;
            // Hook deinstallieren
            UnhookWindowsHookEx(hMsgBoxHook);
          end;
{$ENDIF}
          Refresh;
        end;
        EndPaint(hDlg, ps);
      end;
    WM_HELP:
      begin
        if PHelpInfo(lParam)^.dwContextId > 0 then
          ShowHelpHandle(PHelpInfo(lParam)^.hItemHandle, PHelpInfo(lParam)^.dwContextId)
        else
          //DefDlgProc(hDlg, uMsg, wParam, lParam);
          Exit;
      end;
    WM_SIZE:
      begin
        GetWindowRect(hDlg, rec);
        GetWindowRect(GetDlgItem(hDlg, ID_TOOLBAR), rec2);
        HeightTB := rec2.Bottom - rec2.Top;
        SetWindowPos(GetDlgItem(hDlg, 101), 0, 0, 3 + HeightTB, rec.Right - rec.Left, 75, SWP_NOZORDER or
          SWP_SHOWWINDOW);
        SetWindowPos(GetDlgItem(hDlg, 106), 0, 0, 3 + HeightTB, rec.Right - rec.Left, 2, SWP_NOZORDER or
          SWP_SHOWWINDOW);
        SetWindowPos(GetDlgItem(hDlg, 102), 0, 0, 76 + HeightTB, rec.Right - rec.Left, 2, SWP_NOZORDER or
          SWP_SHOWWINDOW);
        SetWindowPos(GetDlgItem(hDlg, 103), 0, 0, HeightTB + 3, rec.Right - rec.Left, 2, SWP_NOZORDER or
          SWP_SHOWWINDOW);
        //SetDlgItemText(hDlg, 101, PChar(APPNAME));
        SetFocus(GetDlgItem(hDlg, ID_TV));
      end;
    WM_CTLCOLORSTATIC:
      begin
        case GetDlgCtrlId(lParam) of
          101:
            begin
              whitebrush := CreateBrushIndirect(WhiteLB);
              SetBkColor(wParam, WhiteLB.lbColor);
              Result := BOOL(whitebrush);
            end;
          ID_EDT_USER:
            begin
              if EditMode <> MODE_NEWUSER then
              begin
                SetBkMode(wParam, TRANSPARENT);
                Result := BOOL(GetSysColorBrush(COLOR_WINDOW));
              end;
            end
        else
          Result := False;
        end;
      end;
    { Removed because causes bugs after using the tabs
      See: http://www.delphipraxis.net/1125074-post957.html }
    {WM_LBUTTONDOWN:
      begin
        SetCursor(LoadCursor(0, IDC_SIZEALL));
        SendMessage(hDlg, WM_NCLBUTTONDOWN, HTCAPTION, lParam);
      end;}
    WM_CLOSE:
      begin
        Settings := TSettings.Create(GetCompName, HKEY_CURRENT_USER);
        try
          try
            Settings.ShowUsers := GetMenuItemCheck(GetMenu(hDlg), ID_MNU_USER);
            Settings.ExpandAll := GetMenuItemCheck(GetMenu(hDlg), ID_MNU_EXPAND);
          except
            on E: Exception do
              DisplayExceptionMsg(hDlg, E.Errorcode, E.Message, rsErrorSaveSettings);
          end;
        finally
          Settings.Free;
        end;

        DisconnectNetworkDriveW(CurComputer + '\IPC$');

        hTVItem := TreeView_GetRoot(GetDlgItem(hDlg, ID_TV));
        DoClearTV(GetDlgItem(hDlg, ID_TV), hTVItem, TVGN_CHILD);

        DestroyWindow(hDlg);
        PostQuitMessage(0);
      end;
    WM_COMMAND:
      begin
        // accel for closing the dialog with ESC
        if wParam = ID_CANCEL then
          SendMessage(hDlg, WM_CLOSE, 0, 0);
        // button and menu clicks
        if HiWord(wParam) = BN_CLICKED then
        begin
          case LoWord(wParam) of
            ID_MNU_LOKAL_COMP:
              begin
                CurComputer := '\\' + GetCompName;
                GetServerCommentW(CurComputer, s1);
                if s1 <> '' then
                  s := CurComputer + ' ' + '"' + s1 + '"'
                else
                  s := CurComputer;
                SetWindowTextW(hDlg, PWideChar(FormatW(rsWndCaption, [CurComputer, WideString(APPNAME)])));
                SendMessageW(GetDlgItem(hDlg, ID_STATBAR), SB_SETTEXTW, 0, Integer(@s[1]));
                SendMessageW(GetDlgItem(hDlg, ID_STATBAR), SB_SETTEXTW, 0, Integer(@s[1]));
                Refresh;
              end;
            ID_MNU_USER:
              begin
                CheckMenuRadioItem(GetMenu(hDlg), ID_MNU_USER, ID_MNU_GROUP, ID_MNU_USER, MF_BYCOMMAND or
                  MF_CHECKED);
                FillTreeView(CurComputer, TUserCollection.GetAll(CurComputer));
              end;
            ID_MNU_GROUP:
              begin
                CheckMenuRadioItem(GetMenu(hDlg), ID_MNU_USER, ID_MNU_GROUP, ID_MNU_GROUP, MF_BYCOMMAND or
                  MF_CHECKED);
                FillTreeView(CurComputer, TGroupCollection.GetAll(CurComputer))
              end;
            ID_MNU_EXPAND:
              begin
                ExpandAll(hDlg, ID_TV, not GetMenuItemCheck(GetMenu(hDlg), ID_MNU_EXPAND));
                SetMenuItemCheck(GetMenu(hDlg), ID_MNU_EXPAND, not GetMenuItemCheck(GetMenu(hDlg), ID_MNU_EXPAND));
              end;
            ID_MNU_REFRESH: Refresh;
            ID_MNU_HELP: Shellexecute(hDlg, 'open', PChar(ExtractFilePath(ParamStr(0)) + HELPFILE), nil, nil,
                SW_SHOWNORMAL);
            ID_MNU_ABOUT:
              begin
                DialogBoxParam(HInstance, MAKEINTRESOURCE(300), hDlg, @AboutDlgFunc, hDlg);
              end;
            ID_MNU_CHOOSE_COMP:
              begin
                CurCompData := GetMemory(SizeOf(TcurCompData));
                CurCompData.Computer := AnsiString(CurComputer);
                CurCompData.ParentHandle := hDlg;

                ret := DialogBoxParam(HInstance, MAKEINTRESOURCE(200), hDlg, @ChooseCompDlgFunc, Integer(CurCompData));
                if PSelCmpData(ret)^.Success then // erfolgreich verbunden
                begin
                  ResetDetails;
                  CurComputer := string(PSelCmpData(ret)^.Computer);

                  ErrorCode := GetServerCommentW(CurComputer, s1);
                  if ErrorCode = 0 then // genug Berechtigungen für getServerComment vorhanden -> für Rest dann auch
                  begin
                    s := CurComputer + ' ' + '"' + s1 + '"';
                    SetWindowTextW(hDlg, PWideChar(FormatW(rsWndCaption, [CurComputer, WideString(APPNAME)])));
                    SendMessageW(GetDlgItem(hDlg, ID_STATBAR), SB_SETTEXTW, 0, Integer(PWideChar(s)));
                    SendMessageW(GetDlgItem(hDlg, ID_STATBAR), SB_SETTEXTW, 0, Integer(PWideChar(s)));

                    Refresh;
                  end;
                  FreeMemory(PSelCmpData(ret));
                end
                else
                begin
                  // nix machen nur Speicher freigeben
                  FreeMemory(PSelCmpData(ret));
                end;
              end;
            ID_MNU_NEW:
              begin
                ResetDetails;
                SendDlgItemMessage(hTabDlgs[0], ID_EDT_USER, EM_SETREADONLY, Integer(False), 0);
                SetFocus(GetDlgItem(hTabDlgs[0], ID_EDT_USER));
                EditMode := EditMode or MODE_NEWUSER;
                EnableWindow(hTabDlgs[0], True);
                EnableWindow(hTabDlgs[1], True);
                EnableWindow(hTabDlgs[2], True);
                EnableWindow(hTabDlgs[3], True);
                Enable_ToolbarButton(GetDlgItem(hApp, ID_TOOLBAR), ID_MNU_SAVE, False);
                MyEnableMenuItem(GetMenu(hApp), ID_MNU_SAVE, False);
                Enable_ToolbarButton(GetDlgItem(hApp, ID_TOOLBAR), ID_MNU_DEL, False);
                MyEnableMenuItem(GetMenu(hApp), ID_MNU_DEL, False);

                // alle Fenster unsichtbar machen
                for i := 0 to length(hTabDlgs) - 1 do
                  ShowWindow(hTabDlgs[i], SW_HIDE);
                // ersten Seitenreiter auswählen
                SendDlgItemMessage(hDlg, ID_TAB, TCM_SETCURSEL, 0, 0);
                // erstes Seitenreiterfenster sichtbar machen
                ShowWindow(hTabDlgs[0], SW_SHOW);
                SetFocus(GetDlgItem(hTabDlgs[0], ID_EDT_USER));
              end;
            ID_MNU_SAVE:
              begin
                Save;
                Enable_ToolbarButton(GetDlgItem(hApp, ID_TOOLBAR), ID_MNU_SAVE, False);
                MyEnableMenuItem(GetMenu(hApp), ID_MNU_SAVE, False);
                Enable_ToolbarButton(GetDlgItem(hApp, ID_TOOLBAR), ID_MNU_DEL, False);
                MyEnableMenuItem(GetMenu(hApp), ID_MNU_DEL, False);
              end;
            ID_MNU_DEL:
              begin
{$IFDEF DEMO}
                MessageBoxW(hDlg, PWideChar(WideString(rsDemoFeature)), PWideChar(WideString(rsCaptionDelete)),
                  MB_ICONINFORMATION);
{$ELSE}
                if MessageBoxW(hDlg, PWideChar(FormatW(rsDoDelete, [CurrentUser.GetCaption])),
                  PWideChar(WideString(rsCaptionDelete)), MB_YESNO or MB_ICONWARNING or MB_DEFBUTTON2) = ID_YES then
                  Del;
{$ENDIF}
              end;
            ID_MNU_GRPMNG:
              begin
                New(Info);
                Info.hParent := hDlg;
                Info.CurComputer := CurComputer;
                DialogBoxParam(HInstance, MAKEINTRESOURCE(400), hDlg, @groupmandlgproc, Integer(Info));
                Dispose(Info);
                FillLVGroups;
                Enable_ToolbarButton(GetDlgItem(hApp, ID_TOOLBAR), ID_MNU_SAVE, False);
                MyEnableMenuItem(GetMenu(hApp), ID_MNU_SAVE, False);
              end;
            ID_MNU_EXPORT_CSV:
              begin
                Filename := SaveFileAs(hDlg, CSVFilter, 'csv');
                if Filename <> '' then
                begin
                  ExportCSV(Filename);
                end;
              end;
            ID_MNU_EXPORT_XML:
              begin
{$IFDEF DEMO}
                MessageBoxW(hDlg, PWideChar(WideString(rsDemoFeature)), PWideChar(WideString(rsWaitExportXMLCaption)),
                  MB_ICONINFORMATION);
{$ELSE}
                Filename := SaveFileAs(hDlg, XMLFilter, 'xml');
                if Filename <> '' then
                begin
                  ExportXML(Filename);

                end;
{$ENDIF}
              end;
            ID_MNU_IMPORT_XML:
              begin
{$IFDEF DEMO}
                MessageBoxW(hDlg, PWideChar(WideString(rsDemoFeature)), PWideChar(WideString(rsWaitImportXMLCaption)),
                  MB_ICONINFORMATION);
{$ELSE}
                Filename := OpenFile(hDlg, XMLFilter);
                if Filename <> '' then
                begin
                  ImportXML(Filename);
                  SendMessage(hDlg, WM_COMMAND, MakeWParam(ID_MNU_REFRESH, 0), 0);
                end;
{$ENDIF}
              end;
            ID_MNU_CLOSE: SendMessage(hDlg, WM_CLOSE, 0, 0);
          end;
        end;
        if hiword(wParam) = 1 then
        begin
          case loword(wParam) of
            ID_ACCEL_CHOOSE_COMP: SendMessage(hDlg, WM_COMMAND, MakeWParam(ID_MNU_CHOOSE_COMP, 0), 0);
            ID_ACCEL_LOCAL_COMP: SendMessage(hDlg, WM_COMMAND, MakeWParam(ID_MNU_LOKAL_COMP, 0), 0);
            ID_ACCEL_NEW: SendMessage(hDlg, WM_COMMAND, MakeWParam(ID_MNU_NEW, 0), 0);
            ID_ACCEL_SAVE: SendMessage(hDlg, WM_COMMAND, MakeWParam(ID_MNU_SAVE, 0), 0);
            ID_ACCEL_DEL: SendMessage(hDlg, WM_COMMAND, MakeWParam(ID_MNU_DEL, 0), 0);
            ID_ACCEL_REFRESH: SendMessage(hDlg, WM_COMMAND, MakeWParam(ID_MNU_REFRESH, 0), 0);
            //ID_ACCEL_HELP: SendMessage(hDlg, WM_COMMAND, MakeWParam(ID_MNU_HELP, 0), 0);
            ID_ACCEL_GRPMGN: SendMessage(hDlg, WM_COMMAND, MakeWParam(ID_MNU_GRPMNG, 0), 0);
          end;
        end;
      end;
    WM_NOTIFY:
      begin
        if PNMHdr(lParam).idFrom = ID_TV then
        begin
          case PNMHDR(lParam)^.code of
            TVN_SELCHANGING:
              begin

              end;
            TVN_SELCHANGED: // treeview item selection has changed
              begin
                obj := TObject(PNMTreeViewW(PNMHDR(lParam))^.itemNew.lParam);
                if obj is TUser then
                begin
                  CurrentUser := TUser(obj);
                  SetDetails(CurrentUser);
                  Enable_ToolbarButton(GetDlgItem(hDlg, ID_TOOLBAR), ID_MNU_DEL, True);
                  MyEnableMenuItem(GetMenu(hApp), ID_MNU_DEL, True);
                  EnableChildWindows(hTabDlgs[0], True);
                  EnableChildWindows(hTabDlgs[1], True);
                  EnableChildWindows(hTabDlgs[2], True);
                  EnableChildWindows(hTabDlgs[3], True);
                end
                else
                begin
                  ResetDetails;
                  Enable_ToolbarButton(GetDlgItem(hDlg, ID_TOOLBAR), ID_MNU_DEL, False);
                  MyEnableMenuItem(GetMenu(hApp), ID_MNU_DEL, False);
                  EnableChildWindows(hTabDlgs[0], False);
                  EnableChildWindows(hTabDlgs[1], False);
                  EnableChildWindows(hTabDlgs[2], False);
                  EnableChildWindows(hTabDlgs[3], False);
                end;
                SendDlgItemMessage(hTabDlgs[0], ID_EDT_USER, EM_SETREADONLY, Integer(True), 0);
                EditMode := MODE_NEUTRAL;
              end;
          end;
        end; // PNMHdr(lParam).idFrom = ID_TV
        if PNMHdr(lParam).idFrom = ID_TAB then
        begin
          case PNMHDR(lParam)^.code of
            TCN_SELCHANGE: // tab selection changed
              begin
              { which one was activated? }
                TabIndex := SendMessage(GetDlgItem(hDlg, ID_TAB), TCM_GETCURSEL, 0, 0);
                for i := 0 to length(hTabDlgs) - 1 do
                begin
                { hide not selected tab dialog }
                  case i = TabIndex of
                    FALSE: ShowWindow(hTabDlgs[i], SW_HIDE);
                  else
                    begin
                      GetWindowRect(GetDlgItem(hDlg, ID_TAB), rec);
                      pt1.X := rec.Left;
                      pt1.Y := rec.Top;
                      pt2.X := rec.Right;
                      pt2.Y := rec.Bottom;
                      ScreenToClient(hDlg, pt1);
                      ScreenToClient(hDlg, pt2);
                      SetWindowPos(hTabDlgs[TabIndex], 0, pt1.X + 1, pt1.Y + 21, pt2.X - pt1.X - 4, pt2.Y - pt1.Y -
                        25, SWP_SHOWWINDOW)
                    end; // else case
                  end; // case
                end; // for
              end; // TCN_SELCHANGE:
          end; // case PNMHDR(lParam)^.code
        end; // PNMHdr(lParam).idFrom = ID_TAB
        //if PNMHdr(lParam)^.idFrom = ID_TOOLBAR then
        //begin
        case PNMToolBar(lParam)^.hdr.code of
          TTN_NEEDTEXT:
            case PToolTipText(lParam).hdr.idFrom of
              ID_MNU_CHOOSE_COMP: PToolTipText(lParam).lpszText := PChar(rsTBBChooseCmp);
              ID_MNU_NEW: PToolTipText(lParam).lpszText := PChar(rsTBBNew);
              ID_MNU_SAVE: PToolTipText(lParam).lpszText := PChar(rsTBBSave);
              ID_MNU_DEL: PToolTipText(lParam).lpszText := PChar(rsTBBDel);
              ID_MNU_GRPMNG: PToolTipText(lParam).lpszText := PChar(rsTBBGrpMng);
            end; // case
        end; // case
        //end; // PNMHdr(lParam)^.idFrom = ID_TOOLBAR
      end // WM_NOTIFY
  else
    Result := False;
  end;
end;

var
  ret               : LongBool = True;
  hAccelTbl         : THandle;
  msg               : tagMSG;

begin

  InitCommonControls;
  CoInitialize(nil);
  CreateDialog(hInstance, MAKEINTRESOURCE(100), 0, @MainDlgfunc);
  { load acceltable }
  hAccelTbl := LoadAccelerators(hInstance, MAKEINTRESOURCE(4000));

  while Ret do
  begin
    Ret := GetMessage(msg, 0, 0, 0);
    if Integer(Ret) = -1 then
      Ret := True;
    if (not Ret) then
      break;
    { no accel was pressed, go ahead }
    if TranslateAccelerator(hApp, hAccelTbl, msg) = 0 then
      { it is no dialog message, go ahead }
      if IsDialogMessage(hApp, msg) = FALSE then
      begin
        TranslateMessage(msg);
        DispatchMessage(msg);
      end;
  end;
  CoUninitialize;
  ExitCode := msg.wParam;
end.

