@echo off
echo Kompilieren der Ressourcen...
echo =============================
rcstamp resources\resource1.rc 6.1.*.+
brcc32.exe resources\resource1.rc -foresources\resource1.res -v
brcc32.exe resources\manifest.rc -foresources\manifest.res -v
echo.
echo Loeschen alter kompilierte Units...
echo ===================================
 del /s *.dcu
echo.
echo Kompilieren der Anwendung...
echo.
echo Erstelle Demo-Version.....
dcc32 -DDEMO Usermanager.dpr
cd ..
rename Usermanager.exe Usermanager_Demo.exe
echo Erstelle Vollversion...
cd source
dcc32 Usermanager.dpr
echo.
echo Loeschen der temporaeren Dateien und der kompilierten Units...
echo ==============================================================
del /s *.~*
del /s *.dcu
echo.
echo Packen mit UPX...
echo =================
upx -9 ..\Usermanager_Demo.exe
upx -9 ..\Usermanager.exe
echo.
set /P CHS=Programm starten mit [Return]. Beenden mit "E":
if /I "%CHS%"=="E" goto :ENDE

start ..\Usermanager.exe

:ENDE