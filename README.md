# XP Usermanager
Der UserManager dient dazu Benutzerkonten auf NT ff. Maschinen anzulegen, zu löschen, Benutzer Gruppen zu zuordnen und deren Konten zu verwalten. All dies kann man auch mit der Windows internen Benutzerverwaltung, nur nicht so übersichtlich, wie ich denke.
Man kann mit dem Usermanager auch lokale Benutzerkonten auf remote Computer im Netzwerk verwalten. Was allerdings nicht mit Windows XP Home funktioniert, da XP Home den remote Zugriff nicht gestattet.

![Screenshot](https://user-images.githubusercontent.com/8652602/28248141-bb7f84c6-6a3f-11e7-9546-de5839681536.jpg)

Der Autor ist Michael Puff. Ich habe das Projekt mit seinem Einverständnis hier veröffentlicht. Den Link zu seiner ehemaligen Webseite habe ich nun hier aufgrund des dreisten Kaperns der Domain für Werbezwecke entfernt. Seine Webseite ist dort nicht mehr erreichbar. Sie ist im Webarchiv noch zu finden:
http://web.archive.org/web/20211215120725/http://michael-puff.de/

# Unterstützte Betriebssysteme
- Windows NT 4.0, vermutlich, nicht getestet.
- Windows 2000
- Windows XP (32-Bit), Windows XP Home wird nicht remote unterstützt.
- Windows Vista 32-Bit
- Windows 7 32-Bit, 64-Bit

# Features
- Auswahl des zu bearbeitenden Computers (und ist damit netzwerktauglich)
- Anzeige des Betriebsystems des Remotecomputers
- Anzeigen des ausgewählten Computers und Benutzers in der Titelzeile
- Statusanzeige beim Übertragen der Konten und Kontendaten in der Statusleiste
- Auflistung sämtlicher Konten in einer Baumstruktur (einschließlich Systemkonten wie z.B. Hilfeassistent)
- Hervorheben von deaktivierten Konten durch ein anderes Symbol
- Ansicht kann zwischen Benutzern und Gruppen umgeschaltet werden
- Details mit Angabe des Benutzer-Namens, vollständiger Name, Beschreibung, Stammverzeichnis und Script
- Checkboxen zur schnellen Konfiguration des ausgewählten Kontos bezüglich Kennwort und anderen Daten
- Direkte Anzeige der Zuordnung zu Gruppen sowie Anzeige aller verfügbaren Gruppen
- Direkte Anzeige sämtlicher Parameter des Kontos
- Benutzer können in eine CSV Datei exportiert werden
- Es können mehrere Benutzer auf einmal über eine Vorlagendatei angelegt und wieder gelöscht werden
- Integrierte Gruppenverwaltung
- Toolbar mit Schaltflächen für die wichtigsten Funktionen
- Export der Benutzer von und Import von Benutzer aus einer XML-Dateien neu
- Modernere Icons neu
- Ausführliche kontextsensitive Hilfe

# Unterstützte Delphiversionen
- Delphi 6 bis Delphi 10.2 Tokyo
  Sollte es beim Öffnen des Projekts einen Fehler geben, bitte einfach
  alle Dateien Usermanager.* bis auf die Usermanager.dpr löschen!
