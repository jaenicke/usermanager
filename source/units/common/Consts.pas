(******************************************************************************
 *                                                                            *
 *  Project: Usermanager, Benutzerverwaltung für Windows NT, 2000, XP, Vista  *
 *  File   : Consts, Konstanten                                               *
 *                                                                            *
 *  Copyright (c) Michael Puff  http://www.michael-puff.de                    *
 *                                                                            *
 ******************************************************************************)

{$I CompilerSwitches.inc}

unit Consts;

interface

uses
  CommCtrl,
  Messages;

type
  TWaitInfo = record
    hParent: THandle;
    InfoText: WideString;
    Caption: WideString;
  end;
  PWaitInfo = ^TWaitInfo;

const
  APPNAME = 'XP Usermanager';
  DESCRIPTION = 'Benutzerverwaltung für Windows XP / Vista / Windows 7';
  COPYRIGHT = 'Copyright © Michael Puff';
  HOMEPAGE = 'http://www.michael-puff.de';

  FONTNAME = 'Tahoma';
  FONTSIZE = -20;

  HELPFILE = 'hilfe.chm';
  LOGFILE = 'import.log';

  XPM_REFRESH = WM_USER + 1; // Refresh Message

  XPUM_REG_KEY = 'Software\MichaelPuff\XPUsermanager';
  // HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\DontShowMeThisDialogAgain
  REG_SAVENETUSERNAME = 'SaveNetUserName';
  REG_NETUSERNAME = 'NetUserName';
  REG_REMOTECOMPUTER = 'RemoteComputer';
  REG_HINT_NO_ADMIN = 'XPUsermanager_Hint_No_Adim';

  // MainDlg
  ID_TV = 10901;
  ID_LV = 10903;
  ID_STATBAR = 10904;
  ID_TAB = 10905;
  ID_TOOLBAR = 10906;
  ID_MNU_CHOOSE_COMP = 40130;
  ID_MNU_LOKAL_COMP = 40160;
  ID_MNU_NEW = 40020;
  ID_MNU_SAVE = 40030;
  ID_MNU_DEL = 40040;
  ID_MNU_CLOSE = 40006;
  ID_MNU_USER = 40007;
  ID_MNU_GROUP = 40008;
  ID_MNU_EXPAND = 40009;
  ID_MNU_REFRESH = 40140;
  ID_MNU_HELP = 40010;
  ID_MNU_ABOUT = 40011;
  ID_MNU_GRPMNG = 40200;
  ID_MNU_EXPORT_CSV = 40201;
  ID_MNU_EXPORT_XML = 40202;
  ID_MNU_IMPORT_XML = 40203;

  ID_ACCEL_NEW = 4002;
  ID_ACCEL_SAVE = 4003;
  ID_ACCEL_DEL = 4004;
  ID_ACCEL_HELP = 4010;
  ID_ACCEL_CHOOSE_COMP = 4013;
  ID_ACCEL_REFRESH = 4014;
  ID_ACCEL_LOCAL_COMP = 4016;
  ID_ACCEL_GRPMGN = 4020;

  // first tab - Konto
  ID_EDT_USER = 10202;
  ID_EDT_FULLNAME = 10203;
  ID_EDT_DESCRIPTION = 10204;
  ID_EDT_PW = 113;
  ID_EDT_PW2 = 112;
  ID_CHK_RESET_PW = 111;
  // second tab - Eigenschaften
  ID_CHK_MUST_CHANGE_PW = 221;
  ID_CHK_CANT_CHANGE_PW = 222;
  ID_CHK_PW_DONT_EXPIRE = 223;
  ID_CHK_ACCOUNT_DISABLED = 226;
  ID_EDT_HOMEDIR = 125;
  ID_BTN_HOMEDIR = 124;
  ID_EDT_SCRIPT_PATH = 122;
  ID_BTN_SCRIPT_PATH = 123;
  // third tab - Login
  ID_CHK_AUTO_LOGIN = 231;
  ID_EDT_AUTO_LOGIN = 10216;
  ID_CHK_HIDE_ACCOUNT = 233;
  // fourth tab - Gruppen
  ID_LV_USERGROUPS = 141;
  // Choose Computer Dlg
  ID_BTN_OK_X = 201;
  ID_BTN_CLOSE_X = 202;
  ID_EDT_ACCOUNT_X = 203;
  ID_EDT_PW_X = 204;
  ID_CHK_SAVEUSERNAME = 205;
  ID_EDT_COMP_X = 206;
  ID_BTN_SEARCH_X = 207;
  ID_BTN_HELP = 211;
  // About Dlg
  ID_STC_APPNAME = 301;
  ID_STC_DESCRIPTION = 305;
  ID_CUSTOM_SCROLL = 302;
  ID_STC_COPYRIGHT = 303;
  ID_BTN_CLOSE = 304;
  ID_STC_DATE = 306;
  // Groupmanager
  ID_LV_GROUPS = 401;
  ID_LV_PRIVILEGES = 402;
  ID_BTN_APPLYPRV = 403;
  ID_BTN_UNDO = 404;
  ID_EDT_GROUP = 405;
  ID_EDT_COMMENT = 406;
  ID_BTN_SAVE_GRP = 407;
  ID_BTN_DEL_GRP = 408;
  ID_BTN_GMCLOSE = 409;
  ID_BTN_HELP_GM = 410;

  SB_SIMPLEID = $00FF;

  MODE_NEUTRAL = 0;
  MODE_NEWUSER = 1;
  MODE_EDIT = 2;

const
  CSVFilter = 'CSV-Dateien (*.csv)'#0'*.csv';
  XMLFilter = 'XML-Dateien (*.xml)'#0'*.xml';

const
  ContextInfo: array[1..22] of string =
  ('Name des Benutzers, entspricht dem Kontonamen. Wird kein vollständiger Name angegeben, erscheint dieser Name im' +
    ' Login-Bildschirm von Windows XP.',
    'Vollständiger Name des Benutzers. Wird ein vollständiger Name angegeben, erscheint dieser Name im Login-Bildschirm' +
    ' von Windows XP anstatt des Kontonamens.',
    'Nähere Beschreibung des Kontos oder ein frei wählbarer Kommentar.',
    'Kennwort für das Benutzerkonto, welches beim Einloggen eingegeben werden muss.' +
    ' Setzen Sie den Haken bei "zurücksetzen", wenn Sie das Kennwort zurücksetzen wollen.',
    'Typ des Kontos.' + #13#10 +
    'INTERDOMAIN_TRUST_ACCOUNT: This is a permit to trust account for a domain that trusts other domains.' + #13#10 +
    'NORMAL_ACCOUNT: Standard Benutzerkonto' + #13#10 +
    'TEMP_DUPLICATE_ACCOUNT: This is an account for users whose primary account is in another domain.' + #13#10 +
    ' This account provides user access to this domain, but not to any domain that trusts this domain.' + #13#10 +
    ' The User Manager refers to this account type as a local user account.' + #13#10 +
    'WORKSTATION_TRUST_ACCOUNT: Computer Konto für einen Computer, der ein Mitglieder dieser Domain ist.' + #13#10 +
    'SERVER_TRUST_ACCOUNT: Computer Konto für einen Backup Domain Controller, der ein Mitglied dieser Domain ist.',
    'Bei der nächsten Anmeldung muss der Benutzer das Kennwort bei der Anmeldung ändern.',
    'Der Benutzer kann das Kennwort nicht selbst ändern.',
    'Das Kennwort läuft nicht ab.',
    'Das Konto wurde vom Administrator gesperrt.',
    'Stammverzeichnis des Benutzerkontos.',
    'Anmeldeskript für das Benutzerkonto, welches bei der Anmeldung ausgeführt wird.',
    'Aktivieren Sie diese Checkbox, wenn der ausgewählte Benutzer automatisch beim Start von Windows angemeldet' +
    ' werden soll. Ist das Konto mit einem Kennwort versehen, geben Sie es in das Eingabefeld "Kennwort" ein.',
    'Aktivieren Sie diese Checkbox, wenn das ausgewählte Konto nicht im Anmeldebildschirm von Windows ercheinen soll.' +
    ' Dies gilt nur für den Anmeldebildschirm von Windows XP.',
    'Liste der verfügbaren Benutzergruppen. Ist ein Haken vor einer Benutzergruppe gesetzt, so ist der ausgewählte' +
    ' Benutzer Mitglied dieser Gruppe. Setzen oder entfernen Sie entsprechend die Häkchen, um einen Benutzer einer' +
    ' Benutzergruppe hinzuzufügen oder ihn aus einer zu entfernen.',
    'Liste der Benutzer und Gruppen. Wählen Sie einen Benutzer aus, um die Kontoeinstellungen zu bearbeiten oder den' +
    ' Benutzer zu löschen.' + #13#10 +
    'Sie können im Menü "Ansicht" diese Ansicht umschalten.',
    'Liste der auf dem aktuellen Rechner verfügbaren Benutzergruppen.',
    'Liste der verfügbaren Privilegien. Ist ein Haken vor einem Privileg gesetzt, so besitzt diese Benutzergruppe' +
    ' dieses Privileg.',
    'Geben Sie hier den Name der neu zu erstellenden Gruppe ein.',
    'Geben Sie hier eine Beschreibung für die neue Gruppe ein. Diese Angabe ist optional.',
    'Diese Schaltfläche legt die neue Gruppe an.',
    'Diese Schaltfläche löscht die ausgewählte Gruppe.',
    'Pay me my money down' + #13#10 + 'Pay me, pay me my money down'#13#10 + 'Pay me or go to jail' + #13#10 +
    'Pay me my money down'
    );

var
  hTabDlgs: array[0..3] of THandle;
  EditMode: Integer = 0;
  bSetDetails: Boolean;

  tbButtons: array[0..6] of TTBButton = (
    (iBitmap: 0;
    idCommand: ID_MNU_CHOOSE_COMP;
    fsState: TBSTATE_ENABLED;
    fsStyle: TBSTYLE_BUTTON;
    dwData: 0;
    iString: 2;
    ),
    (iBitmap: 0;
    idCommand: - 1;
    fsState: TBSTATE_ENABLED;
    fsStyle: TBSTYLE_SEP;
    dwData: 0;
    iString: - 1;
    ),
    (iBitmap: 1;
    idCommand: ID_MNU_NEW;
    fsState: TBSTATE_ENABLED;
    fsStyle: TBSTYLE_BUTTON;
    dwData: 0;
    iString: 0;
    ),
    (iBitmap: 2;
    idCommand: ID_MNU_SAVE;
    fsState: TBSTATE_ENABLED;
    fsStyle: TBSTYLE_BUTTON;
    dwData: 0;
    iString: 0;
    ),
    (iBitmap: 3;
    idCommand: ID_MNU_DEL;
    fsState: TBSTATE_ENABLED;
    fsStyle: TBSTYLE_BUTTON;
    dwData: 0;
    iString: 2;
    ),
    (iBitmap: 0;
    idCommand: - 1;
    fsState: TBSTATE_ENABLED;
    fsStyle: TBSTYLE_SEP;
    dwData: 0;
    iString: - 1;
    ),
    (iBitmap: 4;
    idCommand: ID_MNU_GRPMNG;
    fsState: TBSTATE_ENABLED;
    fsStyle: TBSTYLE_BUTTON;
    dwData: 0;
    iString: - 1;
    )
    );

implementation

end.

