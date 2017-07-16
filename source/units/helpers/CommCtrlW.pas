{$I ..\..\CompilerSwitches.inc}

unit CommCtrlW;

interface

uses
  Windows, CommCtrl;

  function TreeView_InsertItemW(hwnd: HWND; const lpis: TTVInsertStructW): HTreeItem;
  function TreeView_GetItemW(hwnd: HWND; var pitem: TTVItemW): Bool;
  function ListView_GetItemTextW(hwndLV: HWND; i, iSubItem: Integer;
  pszText: PWideChar; cchTextMax: Integer): Integer;

implementation

function TreeView_InsertItemW(hwnd: HWND; const lpis: TTVInsertStructW): HTreeItem;
begin
  Result := HTreeItem( SendMessage(hwnd, TVM_INSERTITEMW, 0, Longint(@lpis)) );
end;

function TreeView_GetItemW(hwnd: HWND; var pitem: TTVItemW): Bool;
begin
  Result := Bool( SendMessage(hwnd, TVM_GETITEMW, 0, Longint(@pitem)) );
end;

function ListView_GetItemTextW(hwndLV: HWND; i, iSubItem: Integer;
  pszText: PWideChar; cchTextMax: Integer): Integer;
var
  Item: TLVItemW;
begin
  Item.iSubItem := iSubItem;
  Item.cchTextMax := cchTextMax;
  Item.pszText := pszText;
  Result := SendMessage(hwndLV, LVM_GETITEMTEXTW, i, Longint(@Item));
end;

end.
