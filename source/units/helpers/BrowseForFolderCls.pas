// -----------------------------------------------------------------------------
//
// TFolderBrowser-Klasse
// Copyright (c) 2003/2004 Delphi-Forum
// Tino, Popov, "Peter Lustig" (PL), Luckie, Aton, Mathias Simmack (msi)
//
// basiert auf den folgenden Beiträgen
//   - http://www.delphi-forum.de/viewtopic.php?t=11240
//   - http://www.delphi-forum.de/viewtopic.php?t=21471
//   * http://www.delphi-forum.de/viewtopic.php?t=25302
//   - http://www.delphi-forum.de/viewtopic.php?t=27010&start=0
//
// -----------------------------------------------------------------------------

// -- Revision history ---------------------------------------------------------
//
//   * ursprüngliche Version von PL (s. Link #3)
//   * Fehlerkorrekturen von Luckie
//       - Result bei Callback ergänzt
//       - Properties als private deklariert
//       - Bugs in "Execute"-Methode behoben
//   * Dateifilter in Callback-Funktion
//       - Idee (Aton)
//       - globale Stringvariable (msi)
//       - TFolderBrowser-Klasse (PL)
//   * Unterstützung für mehrere Filter ergänzt (msi)
//   * Unterstützung für verschiedene Root-Ordner (msi)
//   * Änderungen bei den Properties (msi)
//       - "SelFolder" in "SelectedItem" umbenannt
//       - "FNewFolder" als "NewFolderButton" verfügbar
//       - "FShowFiles" als "ShowFiles" verfügbar
//       - "FNoTT" als "NoTargetTranslation" verfügbar (XP-Flag)
//   * Funktion zum Ermitteln von Verknüpfungszielen ergänzt (msi)
//       - Ergänzung, um Umgebungsvariablen umzuwandeln
//   * "InitFolder" (s. Create) umbenannt in "PreSelectedFolder" (PL)
//
// -----------------------------------------------------------------------------

{$I ..\..\CompilerSwitches.inc}

unit BrowseForFolderCls;

interface

uses
  ShlObj, ActiveX, Windows, Messages;

type
  TFolderBrowser = class
  private
    // alles private gemacht; geht niemanden was an,
    // da nachträglicher Zugriff sinnlos (Luckie)
    FHandle: THandle;
    FCaption: string;
    FShowFiles: boolean;
    FNewFolder: boolean;
    FStatusText: boolean;
    FNoTT: boolean;
    FInitFolder: string;
    FSelected: string;

    // mehrere Filter müssen durch #0 voneinander getrennt
    // werden, bspw. '*.txt'#0'*.*htm*'#0'*.xml'
    // der letzte Filter kann mit #0#0 enden, muss er aber
    // nicht, weil die Funktion "CheckFilter" diese beiden
    // Zeichen automatisch anhängt (Mathias)
    FFilter: string;
    FRoot: PItemIdList;
    procedure FreeItemIDList(var pidl: pItemIDList);
  public
    constructor Create(Handle: THandle; const Caption: string;
      const PreSelectedFolder: string = ''; ShowFiles: Boolean = False;
      NewFolder: Boolean = False);
    destructor Destroy; override;
    function SetDefaultRoot: boolean;
    function SetRoot(const SpecialFolderId: integer): boolean; overload;
    function SetRoot(const Path: string): boolean; overload;
    function Execute: Boolean; overload;
    function TranslateLink(const LnkFile: string): string;

    property SelectedItem: string read FSelected;
    property Filter: string read FFilter write FFilter;
    property NewFolderButton: boolean read FNewFolder write FNewFolder;
    property ShowFiles: boolean read FShowFiles write FShowFiles;
    property StatusText: boolean read FStatusText write FStatusText;
    property NoTargetTranslation: boolean read FNoTT write FNoTT;
  end;

implementation

//
// erweiterte SHBrowseForFolder-Eigenschaften
// (Deklaration ist notwendig, weil u.U. nicht in jeder Delphi-Version
// bekannt und verfügbar)
//
const
  BIF_NEWDIALOGSTYLE = $0040;
  BIF_USENEWUI = BIF_NEWDIALOGSTYLE or BIF_EDITBOX;
  BIF_BROWSEINCLUDEURLS = $0080;
  BIF_UAHINT = $0100;
  BIF_NONEWFOLDERBUTTON = $0200;
  BIF_NOTRANSLATETARGETS = $0400;
  BIF_SHAREABLE = $8000;

  BFFM_IUNKNOWN = 5;
  BFFM_SETOKTEXT = WM_USER + 105; // Unicode only
  BFFM_SETEXPANDED = WM_USER + 106; // Unicode only

// -- helper functions ---------------------------------------------------------

function fileexists(const FileName: string): boolean;
var
  Handle: THandle;
  FindData: TWin32FindData;
begin
  Handle := FindFirstFile(pchar(FileName), FindData);
  Result := (Handle <> INVALID_HANDLE_VALUE);

  if (Result) then
    FindClose(Handle);
end;

function CheckFilter(const Path, Filter: string): boolean;
var
  p: pchar;
begin
  // Standardergebnis
  Result := false;
  if (Path = '') or (Filter = '') then
    exit;

  // #0#0 an den Filter anhängen, damit später das Ende
  // korrekt erkannt wird
  p := pchar(Filter + #0#0);
  while (p[0] <> #0) do
  begin
    // Datei mit entsprechendem Filter wurde gefunden, ...
    if (fileexists(Path + '\' + p)) then
    begin
    // ... Ergebnis auf TRUE setzen, und Schleife abbrechen
      Result := true;
      break;
    end;

    // ansonsten zum nächsten Filter
    inc(p, lstrlen(p) + 1);
  end;
end;

function SHGetIDListFromPath(const Path: string; out pidl: PItemIDList):
  boolean;
var
  ppshf: IShellFolder;
  wpath: array[0..MAX_PATH] of widechar;
  pchEaten,
    dwAttributes: Cardinal;
begin
  // Standardergebnis
  Result := false;

  // IShellFolder-Handle holen
  if (SHGetDesktopFolder(ppshf) = S_OK) then
  try
    if (StringToWideChar(Path, wpath, sizeof(wpath)) <> nil) then
    begin
      // Pfadname in "PItemIdList" umwandeln
      ppshf.ParseDisplayName(0, nil, wpath, pchEaten, pidl, dwAttributes);
      Result := pidl <> nil;
    end;
  finally
    ppshf := nil;
  end;
end;

//
// "CreateComObject" (modifizierte Version; Mathias)
//

function CreateComObject(const ClassID: TGUID;
  out OleResult: HRESULT): IUnknown;
begin
  OleResult := CoCreateInstance(ClassID, nil, CLSCTX_INPROC_SERVER or
    CLSCTX_LOCAL_SERVER, IUnknown, Result);
end;

// -----------------------------------------------------------------------------
//
// TFolderBrowser-Klasse
//
// -----------------------------------------------------------------------------

function FolderCallback(wnd: HWND; uMsg: UINT; lp, lpData: LPARAM): LRESULT;
  stdcall;
var
  path: array[0..MAX_PATH + 1] of char;
  fb: TFolderBrowser;
begin
  fb := TFolderBrowser(lpData);

  case uMsg of
    // Dialog wurde initialisiert
    BFFM_INITIALIZED:
      begin
        // Ordner auswählen, ...
        if (fb.FInitFolder <> '') then
          SendMessage(wnd, BFFM_SETSELECTION, WPARAM(true),
            LPARAM(pchar(fb.FInitFolder)));

        // ... & OK-Button deaktivieren, wenn Filter benutzt werden
        SendMessage(wnd, BFFM_ENABLEOK, 0, LPARAM(fb.FFilter = ''));
        // oder anders gesagt: OK-Button aktivieren, wenn keine
        // Filter benutzt werden. ;o)
        // (Mathias)
      end;
    BFFM_SELCHANGED:
      if (PItemIdList(lp) <> nil) and (fb.FFilter <> '') then
      begin
        // den aktuellen Pfadnamen holen, ...
        ZeroMemory(@path, sizeof(path));
        if (SHGetPathFromIdList(PItemIdList(lp), path)) then
        begin
        // ... & anzeigen
          SendMessage(wnd, BFFM_SETSTATUSTEXT, 0, LPARAM(@path));

        // gibt´s Dateien mit dem Filter?
        // nur dann wird der OK-Button des Dialogs aktiviert
          SendMessage(wnd, BFFM_ENABLEOK, 0, LPARAM(CheckFilter(path,
            fb.FFilter)));
        end;
      end;
  end;

  Result := 0; // von Luckie hinzugefügt, hatte ich vergessen (oops)
end;

constructor TFolderBrowser.Create(Handle: THandle; const Caption: string;
  const PreSelectedFolder: string = ''; ShowFiles: Boolean = False;
  NewFolder: Boolean = False);
begin
  FHandle := Handle;
  FCaption := Caption;
  FInitFolder := PreSelectedFolder;
  FShowFiles := ShowFiles;
  FNewFolder := NewFolder;
  FStatusText := true;
  FNoTT := false;
  FFilter := '';
  FRoot := nil;
end;

destructor TFolderBrowser.Destroy;
begin
  // ggf. belegte "PItemIdList" freigeben
  if (FRoot <> nil) then
    self.FreeItemIdList(FRoot);

  inherited Destroy;
end;

function TFolderBrowser.SetDefaultRoot: boolean;
begin
  // altes Objekt freigeben
  if (FRoot <> nil) then
    self.FreeItemIDList(FRoot);

  // und alles zurücksetzen
  FRoot := nil;
  Result := true;
end;

function TFolderBrowser.SetRoot(const SpecialFolderId: integer): boolean;
begin
  // altes Objekt freigeben
  if (FRoot <> nil) then
    self.FreeItemIDList(FRoot);

  // SpecialFolderId kann eine der CSIDL_*-Konstanten sein,
  //   CSIDL_DESKTOP
  //   CSIDL_STARTMENU
  //   CSIDL_PERSONAL
  //   ...
  // s. PSDK

  // neuen Root setzen
  Result := SHGetSpecialFolderLocation(FHandle, SpecialFolderId, FRoot) = S_OK;
end;

function TFolderBrowser.SetRoot(const Path: string): boolean;
begin
  // altes Objekt freigeben
  if (FRoot <> nil) then
    self.FreeItemIDList(FRoot);

  // neuen Root setzen
  Result := SHGetIDListFromPath(Path, FRoot);
end;

function TFolderBrowser.Execute: Boolean;
var
  BrowseInfo: TBrowseInfo;
  pidlResult: PItemIDList;
  DisplayName,
    Path: array[0..MAX_PATH + 1] of char;
begin
  Result := false;

  //if (CoInitialize(nil) = S_OK) then
  try
    // "BrowseInfo" mit Werten füllen
    ZeroMemory(@BrowseInfo, sizeof(BrowseInfo));
    BrowseInfo.hwndOwner := FHandle;
    BrowseInfo.pidlRoot := FRoot;
    BrowseInfo.pszDisplayName := @Displayname;
    BrowseInfo.lpszTitle := pchar(FCaption);
    BrowseInfo.lpfn := @FolderCallBack;

    // TFolderBrowser-Klasse als Referenz für Callback-Funktion
    // übergeben (PL)
    BrowseInfo.lParam := LPARAM(self);

    // Flags
    if (FStatusText) then
      BrowseInfo.ulFlags := BrowseInfo.ulFlags or BIF_STATUSTEXT;

    // BIF_USENEWUI sorgt dafür dass besagter Button immer angezeigt wird,
    // egal, ob BIF_BROWSEINCLUDEFILES gesetzt wird oder nicht, daher
    // rausgenommen (Luckie)
    if (FShowFiles) then
      BrowseInfo.ulFlags := BrowseInfo.ulFlags or BIF_BROWSEINCLUDEFILES;

    // Button zum Erstellen neuer Ordner anzeigen? (Luckie, PL)
    if (FNewFolder) then
      BrowseInfo.ulFlags := BrowseInfo.ulFlags or BIF_NEWDIALOGSTYLE
    else
      BrowseInfo.ulFlags := BrowseInfo.ulFlags or BIF_NONEWFOLDERBUTTON;

    // Windows XP sucht automatisch die Verknüpfungsziele von
    // Shortcuts heraus; soll stattdessen aber der Name der
    // Verknüpfung angezeigt werden, ist das Flag BIF_NOTRANSLATETARGETS
    // erforderlich; Sinn macht es nur unter Windows XP
    if (FNoTT) then
      BrowseInfo.ulFlags := BrowseInfo.ulFlags or BIF_NOTRANSLATETARGETS;
    // für die älteren Windows-Versionen gibt es mit der Funktion
    // "TranslateLink" (s. weiter unten) eine Entsprechung, um die
    // Ziele von Shortcuts zu ermitteln (Mathias)

    // Dialog aufrufen
    pidlResult := SHBrowseForFolder(BrowseInfo);
    if (pidlResult <> nil) then
    begin
      if (FSelected = '') then
        if (SHGetPathFromIdList(pidlResult, Path)) and
          (Path[0] <> #0) then
        begin
          FSelected := Path;
          Result := true;
        end;

      self.FreeItemIdList(pidlResult);
    end;
  finally
    CoUninitialize;
  end;
end;

function TFolderBrowser.TranslateLink(const LnkFile: string): string;

  function ExpandEnvStr(const szInput: string): string;
  const
    MAXSIZE = 32768;
  begin
    SetLength(Result, MAXSIZE);
    SetLength(Result, ExpandEnvironmentStrings(pchar(szInput),
      @Result[1], length(Result)));
  end;

var
  link: IShellLink;
  hr: HRESULT;
  afile: IPersistFile;
  pwcLnkFile: array[0..MAX_PATH] of widechar;
  szData: array[0..MAX_PATH] of char;
  FindData: TWin32FindData;
begin
  // Standardergebnis
  Result := '';
  link := nil;
  afile := nil;

  if (CoInitialize(nil) = S_OK) then
  try
    // IShellLink-Interface erzeugen, ...
    link := CreateComObject(CLSID_ShellLink, hr) as IShellLink;
    if (hr = S_OK) and (link <> nil) then
    begin
    // ... & Verknüpfung laden
      StringToWideChar(LnkFile, pwcLnkFile, sizeof(pwcLnkFile));
      afile := link as IPersistFile;

      if (afile <> nil) and
        (afile.Load(pwcLnkFile, STGM_READ) = S_OK) then
      begin
        ZeroMemory(@szData, sizeof(szData));

    // Pfad + Dateiname ermitteln, ...
        if (link.GetPath(szData, sizeof(szData), FindData,
          SLGP_RAWPATH) = S_OK) then
        begin
          SetString(Result, szData, lstrlen(szData));
    // ... & evtl. Umgebungsvariablen filtern
          Result := ExpandEnvStr(Result);
        end;
      end;
    end;
  finally
    if (afile <> nil) then
      afile := nil;
    if (link <> nil) then
      link := nil;

    CoUninitialize;
  end;
end;

procedure TFolderBrowser.FreeItemIDList(var pidl: pItemIDList);
var
  ppMalloc: iMalloc;
begin
  if (SHGetMalloc(ppMalloc) = S_OK) then
  try
    ppMalloc.Free(pidl);
    pidl := nil;
  finally
    ppMalloc := nil;
  end;
end;

end.

