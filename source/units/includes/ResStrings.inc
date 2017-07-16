(******************************************************************************
 *                                                                            *
 *  Usermanager                                                               *
 *  ResStrings.inc -- resourcestrings                                         *
 *                                                                            *
 *  Copyright (c) 2006 Michael Puff  http://www.michael-puff.de               *
 *                                                                            *
 ******************************************************************************)

resourcestring
  rsWndCaption      = '%s - %s';
  // Demo
  rsDemo            = 'Dies ist eine nicht lizensierte Demo-Version!';
  rsDemoFeature     = 'In der nicht lizensierten Demo-Version ist dieses Feature deaktiviert.' + #13#10#13#10 +
    'Wie Sie eine lizensierte Vollversion beziehen können, erfahren Sie auf meiner Webseite:' + #13#10 +
    'http://www.xpusermanager.de';
  rsAbort           = 'Lizensieren';
  rsRetry           = 'Weiter';
  rsIgnore          = 'Abbrechen';

  rsWaitUserDetails = 'Benutzerkonten werden ausgelesen...';
  rsWaitUserDetailsCaption = 'Benutzerdaten auslesen';
  rsWaitDel         = 'Benutzer wird gelöscht...';
  rsWaitDelCaption  = 'Benutzer löschen';
  rsWaitPrivileges  = 'Benutzergruppen und Privilegien werden ausgelesen...';
  rsWaitPrivilegesCaption = 'Gruppenverwaltung öffnen';
  rsWaitAddGroupCaption = 'Gruppe anlegen';
  rsWaitAddGroup    = 'Neue Gruppe wird angelegt...';
  rsWaitDelGroupCaption = 'Gruppe löschen';
  rsWaitDelGroup    = 'Gruppe wird gelöscht...';
  rsWaitExportXMLCaption = 'Benutzer XML-Export';
  rsWaitExportXML   = 'Benutzerkonten werden in XML-Datei exportiert...';
  rsWaitExportCSVCaption = 'Benutzer CSV-Export';
  rsWaitExportCSV   = 'Benutzerkonten werden in CSV-Datei exportiert...';
  rsWaitImportXMLCaption = 'Benutzer importieren';
  rsWaitImport      = 'Benutzer werden angelegt...';

  rsTBBChooseCmp    = 'Wählt einen Computer im Netzwerk aus';
  rsTBBNew          = 'Legt einen neuen Benutzer an';
  rsTBBSave         = 'Speichert den neuen Benutzer oder Änderungen am Benutzerkonto';
  rsTBBDel          = 'Löscht das ausgewählte Benutzerkonto';
  rsTBBGrpMng       = 'Ruft den Gruppenmanager auf';

  // Delete user
  rsCaptionDelete   = 'Benutzer löschen';
  rsDoDelete        = 'Soll der Benutzer "%s" gelöscht werden?' + #13#10 +
    'Dieser Vorgang kann nicht wieder rückgängig gemacht werden.';

  rsErrorOSUnknown  = 'Betriebssystem unbekannt';
  rsErrorUnknown    = 'Ein unbekannter Fehler ist aufgetreten.';
  rsErrorGetServerComment = 'Fehler - GetServerComment';
  rsErrorSelComputer = 'Fehler - Computer wählen';
  rsErrorConnectNetWork = 'Fehler - Mit Computer verbinden';
  rsErrorLoadSettings = 'Fehler - Einstellungen laden';
  rsErrorSaveSettings = 'Fehler - Einstellungen speichern';
  rsErrorSaveUser   = 'Fehler - Benutzer speichern';
  rsErrorAddUser    = 'Fehler - Neuen Benutzer anlegen';
  rsErrorDelUser    = 'Fehler - Benutzer löschen';
  rsErrorValueCantChangeCap = 'Fehler - Kontotyp ändern';
  rsErrorValueCantChange = 'Der Wert kann nicht geändert werden';
  rsErrorGetPrivilegesCap = 'Fehler - Privilegien ermitteln';
  rsErrorExport     = 'Fehler - Benutzer exportieren';

  rsErrorAddGroup   = 'Fehler - neue Gruppe anlegen';
  rsErrorDelGroup   = 'Fehler - Gruppe löschen';

  rsImpFileError    = 'Die Datei %s ist keine gültige XP Usermanager Import-Datei.';
  rsImpXMLError     = 'Die Datei %s ist keine gültig XML-Datei. Überprüfen Sie die Datei auf Fehler.';
  rsLogfileImport   = 'Datum: %s' + #13#10 + 'Importdatei: %s';
  rsLogfileOK       = 'Konto: %s' + #13#10 + 'Status: OK' + #13#10;
  rsLogfileError    = 'Konto: %s' + #13#10 + 'Status: [%d] %s' + #13#10;
  rsImportError     = 'Es sind Fehler beim Import aufgetreten.' + #13#10 +
    'Die Logdatei wurde gespeichert unter %s' + #13#10 +
    'Wollen Sie die Logdatei jetzt betrachten?';

  //Delete group
  rsCaptionDelGroup = 'Gruppe löschen';
  rsDoDelGroup      = 'Soll die Gruppe "%s" gelöscht werden?';

  rsUserGroups      = 'Gruppenzugehörigkeit';
  rsAccountType     = 'Kontotyp';

  // Listview
  rsPWAge           = 'Passwortalter';
  rsLastLogon       = 'Letzte Anmeldung';
  rsCntLogons       = 'Anmeldungen';
  rsAccountExpires  = 'Konto läuft ab';
  rsDontExpire      = 'Nein';

  // Tabdialogs
  rsTabAccount      = '&Konto';
  rsTabSettings     = '&Einstellungen';
  rsTabLogin        = '&Login';
  rsTabGroups       = '&Gruppenzugehörigkeit';
  rsDlgHomeDir      = 'Wählen Sie ein Verzeichnis aus...';

  // Choose computer
  rsSelComputer     = 'Wählen Sie einen Computer aus';

