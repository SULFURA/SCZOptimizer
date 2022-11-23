:: Copyright (C) 2022 SULFURAX
:: 
:: This program is free software: you can redistribute it and/or modify
:: it under the terms of the GNU Affero General Public License as published
:: by the Free Software Foundation, either version 3 of the License, or
:: (at your option) any later version.
:: 
:: This program is distributed in the hope that it will be useful,
:: but WITHOUT ANY WARRANTY; without even the implied warranty of
:: MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
:: GNU Affero General Public License for more details.
:: 
:: You should have received a copy of the GNU Affero General Public License
:: along with this program.  If not, see <https://www.gnu.org/licenses/>.

@echo off
color 03
Mode 128,29
title Script SCZOptimizer 2.0
setlocal EnableDelayedExpansion

SET msgboxTitle=INFORMATION
SET msgboxBody=Please save your work before using the script
SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
WSCRIPT "%tmpmsgbox%"

:: Disable LUA
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "0" /f

:: Dossier
mkdir C:\Users\%username%\Documents\SULFURAX\SCZOptimizer >nul 2>&1
mkdir C:\Users\%username%\Documents\SULFURAX\Backup >nul 2>&1
cd C:\Users\%username%\Documents\SULFURAX\SCZOptimizer >nul 2>&1

:: Run Admin
Reg.exe add HKLM /F >nul 2>&1
if %errorlevel% neq 0 start "" /wait /I /min powershell -NoProfile -Command start -verb runas "'%~s0'" && exit /b

:: Show details BSOD
Reg add "HKLM\System\CurrentControlSet\Control\CrashControl" /v "DisplayParameters" /t REG_DWORD /d "1" /f >nul 2>&1

:: Blank/Color Character
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "DEL=%%a" & set "COL=%%b")

:: Add ANSI escape sequences
Reg add HKCU\CONSOLE /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1

:: NSudo
curl -g -L -# -o "C:\Users\%username%\Documents\SULFURAX\SCZOptimizer\NSudo.exe" "https://github.com/SULFURA/SCZOptimizer/raw/main/files/NSudo.exe"

:: Check Updates
goto CheckUpdates

:CheckUpdates
set local=2.0
set localtwo=%local%
if exist "%temp%\Updater.bat" DEL /S /Q /F "%temp%\Updater.bat" >nul 2>&1
curl -g -L -# -o "%temp%\Updater.bat" "https://raw.githubusercontent.com/SULFURA/SCZOptimizer/main/files/SCZOptimizer_Version" >nul 2>&1
call "%temp%\Updater.bat"
IF "%local%" gtr "%localtwo%" (
	cls
	Mode 65,16
	echo.
	echo                        You need to Update
    echo                         - SCZOptimizer -
	echo  ______________________________________________________________
	echo.
	echo                       Current version: %localtwo%
	echo.
	echo                         New version: %local%
	echo.
	echo  ______________________________________________________________
	echo.
	echo      [ Y ] To Update SCZOptimizer
	echo.
	echo      [ N ] Skip Update
	echo.
	%SystemRoot%\System32\choice.exe /c:YN /n /m "%DEL%                                >:"
	set choice=!errorlevel!
	if !choice! equ 1 (
		curl -L -o %0 "https://github.com/SULFURA/SCZOptimizer/releases/latest/download/SCZOptimizer.cmd" >nul 2>&1
		call %0
		exit /b
	)
	Mode 130,45
)

:: Restore Point
powershell -ExecutionPolicy Unrestricted -NoProfile Enable-ComputerRestore -Drive 'C:\', 'D:\', 'E:\', 'F:\', 'G:\' >nul 2>&1
powershell -ExecutionPolicy Unrestricted -NoProfile Checkpoint-Computer -Description 'SCZOptimizer Restore Point' >nul 2>&1

::HKCU & HKLM backup
for /F "tokens=2" %%i in ('date /t') do set date=%%i
set date1=%date:/=.%
>nul 2>&1 md C:\Users\%username%\Documents\SULFURAX\Backup\%date1%
reg export HKCU C:\Users\%username%\Documents\SULFURAX\Backup\%date1%\HKLM.reg /y >nul 2>&1
reg export HKCU C:\Users\%username%\Documents\SULFURAX\Backup\%date1%\HKCU.reg /y >nul 2>&1

:: Menu
goto Menu

:Menu
cls
echo.
echo.
call :ColorText 08  "                                                             Version 2.0 
echo.
echo.
echo.                                                       .d8888.  .o88b. d88888D 
echo.                                                       88'  YP d8P  Y8 YP  d8'
echo.                                                       `8bo.   8P         d8' 
echo.                                                         `Y8b. 8b        d8'  
echo.                                                       db   8D Y8b  d8  d8' db 
echo.                                                       `8888Y'  `Y88P' d88888P
echo.
echo. 
call :ColorText 08 "                         ________________________________________________________________________________"
echo.
echo.
echo.
call :ColorText 8 "                         [ "
call :ColorText B " 1 "
call :ColorText 8 " ] " 
call :ColorText F " Start (DON'T SKIP IT)"
call :ColorText 8 "                                     [ "
call :ColorText B " 2 "
call :ColorText 8 " ] " 
call :ColorText F " Programs "
echo.
echo.
echo.
call :ColorText 8 "                         [ "
call :ColorText B " 3 "
call :ColorText 8 " ] " 
call :ColorText F " Optimization "
call :ColorText 8 "                                              [ "
call :ColorText B " 4 "
call :ColorText 8 " ] " 
call :ColorText F " Games "
echo.
echo.
echo.
call :ColorText 8 "                                                          [ X for Leave ]"
echo.
echo.
call :ColorText 08 "                         ________________________________________________________________________________"
echo.
echo.
set /p choose="Select > "

if /i "%choose%"=="1" (goto Start)
if /i "%choose%"=="2" (goto Programs)
if /i "%choose%"=="3" (goto Optimization)
if /i "%choose%"=="4" (goto Games)
if /i "%choose%"=="X" (goto Exit)
goto Menu

:: Start

:Start
cls
echo.
echo.
call :ColorText 08  "                                                             Version 2.0 
echo.
echo.
echo.                                                       .d8888.  .o88b. d88888D 
echo.                                                       88'  YP d8P  Y8 YP  d8'
echo.                                                       `8bo.   8P         d8' 
echo.                                                         `Y8b. 8b        d8'  
echo.                                                       db   8D Y8b  d8  d8' db 
echo.                                                       `8888Y'  `Y88P' d88888P
echo. 
call :ColorText 08 "                         _________________________________________________________________________________"
echo.
echo.
echo.
call :ColorText 8 "                         [ "
call :ColorText B " 1 "
call :ColorText 8 " ] " 
call :ColorText F " Site to get the ISO "
call :ColorText 8 "                            [ "
call :ColorText B " 2 "
call :ColorText 8 " ] " 
call :ColorText F " Put the ISO on Rufus "
echo.
echo.
echo.
call :ColorText 8 "                                             [ "
call :ColorText B " 3 "
call :ColorText 8 " ] " 
call :ColorText F " Install Windows 10 or 11 correctly "
echo.
echo.
echo.
call :ColorText 8 "                                                          [ X for Leave ]"                                            [ X for Leave ]"
echo.
echo.
call :ColorText 08 "                         _________________________________________________________________________________"
echo.
echo.
set /p choose="Select > "

if /i "%choose%"=="1" (goto iso)
if /i "%choose%"=="2" (goto rufus)
if /i "%choose%"=="3" (goto installwin)
if /i "%choose%"=="X" (goto Menu)

:iso
cls
echo.
echo.
call :ColorText 08  "                                                             Version 2.0 
echo.
echo.
echo.                                                       .d8888.  .o88b. d88888D 
echo.                                                       88'  YP d8P  Y8 YP  d8'
echo.                                                       `8bo.   8P         d8' 
echo.                                                         `Y8b. 8b        d8'  
echo.                                                       db   8D Y8b  d8  d8' db 
echo.                                                       `8888Y'  `Y88P' d88888P
echo.
echo. 
call :ColorText 08 "                         ________________________________________________________________________________"
echo.
echo.
echo.
call :ColorText 8 "                          [ "
call :ColorText B " 1 "
call :ColorText 8 " ] " 
call :ColorText F " Windows 10 ISO"
call :ColorText 8 "                                     [ "
call :ColorText B " 2 "
call :ColorText 8 " ] " 
call :ColorText F " Windows 11 ISO"
echo.
echo.
echo.
call :ColorText 8 "                                                          [ X for Leave ]"
echo.
echo.
call :ColorText 08 "                         ________________________________________________________________________________"
echo.
echo.
set /p choose="Select > "

if /i "%choose%"=="1" (goto iso_win10)
if /i "%choose%"=="2" (goto iso_win11)
if /i "%choose%"=="X" (goto Menu)
goto Start

:iso_win10
cls
cmd /C start https://www.microsoft.com/fr-fr/software-download/windows10
cmd /C start https://youtu.be/TWs2pkSfEFI
cls
goto start

:iso_win11
cls
cmd /C start https://www.microsoft.com/fr-fr/software-download/windows11
cmd /C start https://youtu.be/DF9lfGvUYW0
cls
goto start

:rufus
cls
cmd /C start https://rufus.ie/fr/
curl -g -L -# -o "C:\Users\%username%\Documents\SULFURAX\SCZOptimizer\Rufus.jpg" "https://raw.githubusercontent.com/SULFURA/SCZOptimizer/main/files/Rufus.jpg"
C:
cd "C:\Users\%username%\Documents\SULFURAX\SCZOptimizer
start Rufus.jpg
cls
goto start

:installwin
cls
SET msgboxTitle=INFORMATION
SET msgboxBody=Unplug your Ethernet cable, if during the installation you are asked to connect to the Internet you should ignore, do not connect and create a local account.
SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
WSCRIPT "%tmpmsgbox%"
echo Unplug your Ethernet cable, if during the installation you are asked to connect to the Internet you should ignore, do not connect and create a local account.
echo.
echo.

SET msgboxTitle=INFORMATION
SET msgboxBody=Remember to say no to everything they ask you to accept during the installation.
SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
WSCRIPT "%tmpmsgbox%"
echo Remember to say no to everything they ask you to accept during the installation.
echo.
echo.

SET msgboxTitle=INFORMATION
SET msgboxBody=When you are on your Windows desktop, press Windows + R and type: regedit
SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
WSCRIPT "%tmpmsgbox%"
echo When you are on your Windows desktop, press Windows + R and type: regedit
echo.
echo.

SET msgboxTitle=INFORMATION
SET msgboxBody=Go to HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching
SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
WSCRIPT "%tmpmsgbox%"
echo Go to HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching
echo.
echo.

SET msgboxTitle=INFORMATION
SET msgboxBody=When you are inside this key, double-click on SearchOrderConfig and set the value to 0.
SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
WSCRIPT "%tmpmsgbox%"
echo When you are inside this key, double-click on SearchOrderConfig and set the value to 0.
echo.
echo.

SET msgboxTitle=INFORMATION
SET msgboxBody=Then restart your computer, once back on your Windows desktop you can reactivate your Internet connection.
SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
WSCRIPT "%tmpmsgbox%"
echo Then restart your computer, once back on your Windows desktop you can reactivate your Internet connection.
echo.
echo.

pause
goto start

:: Programs

:Programs
cls
echo.
echo.
call :ColorText 08  "                                                             Version 2.0 
echo.
echo.
echo.                                                       .d8888.  .o88b. d88888D 
echo.                                                       88'  YP d8P  Y8 YP  d8'
echo.                                                       `8bo.   8P         d8' 
echo.                                                         `Y8b. 8b        d8'  
echo.                                                       db   8D Y8b  d8  d8' db 
echo.                                                       `8888Y'  `Y88P' d88888P
echo.
echo. 
call :ColorText 08 "                         _________________________________________________________________________________"
echo.
echo.
echo.
call :ColorText 8 "                         [ "
call :ColorText B " 1 "
call :ColorText 8 " ] " 
call :ColorText F " Programs "
call :ColorText 8 "                                     [ "
call :ColorText B " 2 "
call :ColorText 8 " ] " 
call :ColorText F " KMS Pico (Crack Windows)"
echo.
echo.
echo.
call :ColorText 8 "                         [ "
call :ColorText B " 3 "
call :ColorText 8 " ] " 
call :ColorText F " Office 365 ISO "
call :ColorText 8 "                               [ "
call :ColorText B " 4 "
call :ColorText 8 " ] " 
call :ColorText F " Office 365 (Crack) "
echo.
echo.
echo.
call :ColorText 8 "                                                          [ X for Leave ]"
echo.
echo.
call :ColorText 08 "                         _________________________________________________________________________________"
echo.
echo.
set /p choose="Select > "

if /i "%choose%"=="1" (goto ProgramsScript)
if /i "%choose%"=="2" (goto KMSPico)
if /i "%choose%"=="3" (goto Office)
if /i "%choose%"=="4" (goto OfficeCrack)
if /i "%choose%"=="X" (goto Menu)
goto Programs

:ProgramsScript
cls
curl -g -L -# -o "C:\Users\%username%\Documents\SULFURAX\SCZOptimizer\Programs.cmd" "https://raw.githubusercontent.com/SULFURA/SCZOptimizer/main/files/Programs.cmd"
cd "C:\Users\%username%\Documents\SULFURAX\SCZOptimizer"
start Programs.cmd
goto Programs

:KMSPico
cls
SET msgboxTitle=INFORMATION
SET msgboxBody=First of all you have to deactivate your Antivirus, when it's done press a button to continue
SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
WSCRIPT "%tmpmsgbox%"
echo First of all you have to deactivate your Antivirus, when it's done press a button to continue
echo.
echo.
pause
cmd /c start https://www35.zippyshare.com/d/JaKKk3h4/28502/KMSpico%2010.2.0%20Final%20%2b%20Portable.rar
goto Programs

:Office
cls
DEL /F /Q "%temp%\tmpmsgbox.vbs"
SET msgboxTitle=INFORMATION
SET msgboxBody=It is necessary to make right click Mount on the .iso then open the Setup.exe in it and wait
SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
WSCRIPT "%tmpmsgbox%"
echo It is necessary to make right click Mount on the .iso then open the Setup.exe in it and wait
echo.
echo.
cmd /C start https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/en-US/ProPlus2019Retail.img
pause
goto Programs

:OfficeCrack
cls
curl -g -L -# -o "C:\Users\%username%\Documents\SULFURAX\SCZOptimizer\Office.cmd" "https://raw.githubusercontent.com/SULFURA/SCZOptimizer/main/files/Office.cmd"
C:
cd "C:\Users\%username%\Documents\SULFURAX\SCZOptimizer\"
start Office.cmd
goto Programs

:: Optimization

:Optimization
cls
echo.
echo.
call :ColorText 08  "                                                             Version 2.0 
echo.
echo.
echo.                                                       .d8888.  .o88b. d88888D 
echo.                                                       88'  YP d8P  Y8 YP  d8'
echo.                                                       `8bo.   8P         d8' 
echo.                                                         `Y8b. 8b        d8'  
echo.                                                       db   8D Y8b  d8  d8' db 
echo.                                                       `8888Y'  `Y88P' d88888P
echo. 
call :ColorText 08 "                         _________________________________________________________________________________"
echo.
echo.
echo.
call :ColorText 8 "                         [ "
call :ColorText B " 1 "
call :ColorText 8 " ] " 
call :ColorText F " Optimizations "
call :ColorText 8 "                                             [ "
call :ColorText B " 2 "
call :ColorText 8 " ] " 
call :ColorText F " Mouse Fix "
echo.
echo.
echo.
call :ColorText 8 "                         [ "
call :ColorText B " 3 "
call :ColorText 8 " ] " 
call :ColorText F " NVIDIA "
call :ColorText 8 "                                                    [ "
call :ColorText B " 4 "
call :ColorText 8 " ] " 
call :ColorText F " AMD "
echo.
echo.
echo.
call :ColorText 8 "                         [ "
call :ColorText B " 5 "
call :ColorText 8 " ] " 
call :ColorText F " Intel iGPU "
call :ColorText 8 "                                                [ "
call :ColorText B " 6 "
call :ColorText 8 " ] " 
call :ColorText F " ISLC "
echo.
echo.
call :ColorText 8 "                                                          [ X for Leave ]"
echo.
echo.
call :ColorText 08 "                         _________________________________________________________________________________"
echo.
echo.
set /p choose="Select > "

if /i "%choose%"=="1" (goto Opti)
if /i "%choose%"=="2" (goto MouseFix)
if /i "%choose%"=="3" (goto NVIDIA)
if /i "%choose%"=="4" (goto AMD)
if /i "%choose%"=="5" (goto Intel)
if /i "%choose%"=="6" (goto ISLC)
if /i "%choose%"=="X" (goto Menu)

:Opti
cls
curl -g -L -# -o "C:\Users\%username%\Documents\SULFURAX\SCZOptimizer\Optimizations.cmd" "https://raw.githubusercontent.com/SULFURA/SCZOptimizer/main/files/Optimizations.cmd"
NSudo.exe -U:T -P:E "C:\Users\%username%\Documents\SULFURAX\SCZOptimizer\Optimizations.cmd"
goto Optimization

:MouseFix
cls
Reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "SmoothMouseXCurve" /t REG_BINARY /d "0000000000000000156e000000000000004001000000000029dc0300000000000000280000000000" /f >nul 2>&1
Reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "SmoothMouseYCurve" /t REG_BINARY /d "0000000000000000fd11010000000000002404000000000000fc12000000000000c0bb0100000000" /f >nul 2>&1
echo Go to your Settings Panel, System and Display, then type your Display Scaling Percentage. 100, 125 or 150 ?
set /p choice=" Scale >  "
Reg add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f >nul 2>&1
Reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f >nul 2>&1
Reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f >nul 2>&1
Reg add "HKCU\Control Panel\Mouse" /v "MouseSensitivity" /t REG_SZ /d "10" /f >nul 2>&1
Reg add "HKCU\Control Panel\Mouse" /v "SmoothMouseYCurve" /t REG_BINARY /d "0000000000000000000038000000000000007000000000000000A800000000000000E00000000000" /f >nul 2>&1
if /i "%choice%"=="100" Reg add "HKCU\Control Panel\Mouse" /v "SmoothMouseXCurve" /t REG_BINARY /d "0000000000000000C0CC0C0000000000809919000000000040662600000000000033330000000000" /f >nul 2>&1
if /i "%choice%"=="125" Reg add "HKCU\Control Panel\Mouse" /v "SmoothMouseXCurve" /t REG_BINARY /d "00000000000000000000100000000000000020000000000000003000000000000000400000000000" /f >nul 2>&1
if /i "%choice%"=="150" Reg add "HKCU\Control Panel\Mouse" /v "SmoothMouseXCurve" /t REG_BINARY /d "0000000000000000303313000000000060662600000000009099390000000000C0CC4C0000000000" /f >nul 2>&1
goto Optimization

:NVIDIA
cls
SET msgboxTitle=INFORMATION
SET msgboxBody=First, you have to uninstall your NVIDIA driver with DDU Uninstaller, follow the YouTube tutorial I made
SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
WSCRIPT "%tmpmsgbox%"
echo First, you have to uninstall your NVIDIA driver with DDU Uninstaller, follow the YouTube tutorial I made
echo.
echo.
pause
cmd /c start https://www.youtube.com/watch?v=jm7Y1EDz9YY
cmd /c start https://www.guru3d.com/files-get/display-driver-uninstaller-download,1.html
pause
SET msgboxTitle=INFORMATION
SET msgboxBody=Secondly, you need to install the latest version of your driver. Also follow the YouTube tutorial I made
SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
WSCRIPT "%tmpmsgbox%"
echo Secondly, you need to install the latest version of your driver. Also follow the YouTube tutorial I made
echo.
echo.
pause
cmd /c start https://www.youtube.com/watch?v=66gj_x51q8M
cmd /c start https://www.techpowerup.com/download/techpowerup-nvcleanstall/
pause
SET msgboxTitle=INFORMATION
SET msgboxBody=If you have uninstalled and reinstalled your graphics driver, press a key to continue, otherwise finish the previous steps before pressing a key
SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
WSCRIPT "%tmpmsgbox%"
echo If you have uninstalled and reinstalled your graphics driver, press a key to continue, otherwise finish the previous steps before pressing a key
echo.
echo.
pause
curl -g -L -# -o "C:\Users\%username%\Documents\SULFURAX\SCZOptimizer\NVIDIA.cmd" "https://raw.githubusercontent.com/SULFURA/SCZOptimizer/main/files/NVIDIA.cmd"
NSudo.exe -U:T -P:E "C:\Users\%username%\Documents\SULFURAX\SCZOptimizer\NVIDIA.cmd"
goto Optimization

:AMD
cls
curl -g -L -# -o "C:\Users\%username%\Documents\SULFURAX\SCZOptimizer\AMD.cmd" "https://raw.githubusercontent.com/SULFURA/SCZOptimizer/main/files/AMD.cmd"
NSudo.exe -U:T -P:E "C:\Users\%username%\Documents\SULFURAX\SCZOptimizer\AMD.cmd"
goto Optimization

:Intel
cls
curl -g -L -# -o "C:\Users\%username%\Documents\SULFURAX\SCZOptimizer\Intel.cmd" "https://raw.githubusercontent.com/SULFURA/SCZOptimizer/main/files/Intel.cmd"
NSudo.exe -U:T -P:E "C:\Users\%username%\Documents\SULFURAX\SCZOptimizer\Intel.cmd"
goto Optimization

:ISLC
cls
SET msgboxTitle=INFORMATION
SET msgboxBody=Click on the first Official Download Here you see and remember to put it in your documents folder please
SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
WSCRIPT "%tmpmsgbox%"
echo Click on the first Official Download Here you see and remember to put it in your documents folder please
echo.
echo.
pause
cmd /c start https://www.wagnardsoft.com/forums/viewtopic.php?t=1256
pause
SET msgboxTitle=INFORMATION
SET msgboxBody=Follow the instructions on the open image to configure it once you have unzipped and opened it
SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
WSCRIPT "%tmpmsgbox%"
echo Follow the instructions on the open image to configure it once you have unzipped and opened it
echo.
echo.
curl -g -L -# -o "C:\Users\%username%\Documents\SULFURAX\SCZOptimizer\ISLC.png" "https://raw.githubusercontent.com/SULFURA/SCZOptimizer/main/files/ISLC.png"
C:
cd "C:\Users\%username%\Documents\SULFURAX\SCZOptimizer
start ISLC.png
pause
goto Optimization

:Games
cls
echo.
echo.
call :ColorText 08  "                                                             Version 2.0 
echo.
echo.
echo.                                                       .d8888.  .o88b. d88888D 
echo.                                                       88'  YP d8P  Y8 YP  d8'
echo.                                                       `8bo.   8P         d8' 
echo.                                                         `Y8b. 8b        d8'  
echo.                                                       db   8D Y8b  d8  d8' db 
echo.                                                       `8888Y'  `Y88P' d88888P
echo.
echo. 
call :ColorText 08 "                         _________________________________________________________________________________"
echo.
echo.
echo.
call :ColorText 8 "                         [ "
call :ColorText B " 1 "
call :ColorText 8 " ] " 
call :ColorText F " MCOptimizer "
echo.
echo.
echo.
call :ColorText 8 "                                                          [ X for Leave ]"
echo.
echo.
call :ColorText 08 "                         _________________________________________________________________________________"
echo.
echo.
set /p choose="Select > "

if /i "%choose%"=="1" (goto MCOptimizer)
if /i "%choose%"=="X" (goto Menu)

:MCOptimizer
cls
curl -g -L -# -o "C:\Users\%username%\Documents\SULFURAX\SCZOptimizer\MCOptimizer.cmd" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/MCOptimizer.cmd"
C:
cd "C:\Users\%username%\Documents\SULFURAX\SCZOptimizer"
start MCOptimizer.cmd
goto Games

:Exit
exit

:ColorText
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul  
goto :eof