@echo off
setlocal ENABLEEXTENSIONS
setlocal ENABLEDELAYEDEXPANSION

REM ==================================================================
REM                      Phoenix Utility Suite
REM              (Developed by MD Faysal Mahmud)
REM
REM  Description: The ultimate all-in-one toolkit for repairing
REM               Windows Update, optimizing performance, fixing
REM               drivers, and resolving network issues.
REM
REM  Usage: Save as a .bat file, right-click, and select
REM         "Run as administrator".
REM ==================================================================

:check_admin
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    cls
    echo [ERROR] Administrative Privileges Required!
    echo.
    echo Please right-click this script and choose "Run as administrator".
    echo.
    pause
    exit /b
)

:menu
cls
color 0B
title Phoenix Utility Suite - Main Menu

echo ==================================================================
echo                      PHOENIX UTILITY SUITE
echo                   (Developed by MD Faysal Mahmud)
echo ==================================================================
echo.
echo   Please select a function:
echo.
echo   [1] Full Windows Update ^& Component Repair
echo   [2] System Performance ^& Health Optimization
echo   [3] Driver ^& Hardware Reset
echo   [4] Complete Network Stack ^& Firewall Reset
echo   [5] Run Security Scan (Microsoft Defender)
echo   [6] System Restart
echo   [0] Exit
echo.
echo ==================================================================
set /p "choice=Enter your choice [0-6]: "

if "%choice%"=="1" goto :update_fix
if "%choice%"=="2" goto :performance_fix
if "%choice%"=="3" goto :driver_fix
if "%choice%"=="4" goto :network_fix
if "%choice%"=="5" goto :security_scan
if "%choice%"=="6" goto :restart_pc
if "%choice%"=="0" exit /b

echo Invalid choice. Press any key to return to the menu...
pause >nul
goto :menu

REM ==================================================================
:update_fix
cls
title Phoenix Utility Suite - Performing Update Repair...
echo [*] Initiating Full Windows Update ^& Component Repair...
echo.

echo [1/8] Stopping essential services (Update, BITS, Crypto, Installer)...
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
net stop cryptsvc >nul 2>&1
net stop msiserver >nul 2>&1
net stop trustedinstaller >nul 2>&1
echo      Services stopped.
echo.

echo [2/8] Clearing Update caches (SoftwareDistribution ^& catroot2)...
if exist "%windir%\SoftwareDistribution" rd /s /q "%windir%\SoftwareDistribution"
if exist "%windir%\System32\catroot2" rd /s /q "%windir%\System32\catroot2"
md "%windir%\SoftwareDistribution"
md "%windir%\System32\catroot2"
echo      Caches cleared.
echo.

echo [3/8] Re-registering critical Update DLLs...
regsvr32.exe /s wuapi.dll >nul 2>&1
regsvr32.exe /s wups.dll >nul 2>&1
regsvr32.exe /s wuaueng.dll >nul 2>&1
regsvr32.exe /s wucltui.dll >nul 2>&1
regsvr32.exe /s msxml3.dll >nul 2>&1
echo      DLLs re-registered.
echo.

echo [4/8] Resetting OS Upgrade and Rollback registry keys...
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade\Rollback" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade" /f >nul 2>&1
echo      Registry keys reset.
echo.

echo [5/8] Running System File Checker (SFC) to fix corrupted files...
echo      This may take several minutes. Please be patient.
sfc /scannow
echo      SFC scan complete.
echo.

echo [6/8] Running DISM to restore component store health...
echo      This may also take a long time.
DISM /Online /Cleanup-Image /RestoreHealth
echo      DISM health restore complete.
echo.

echo [7/8] Restarting all stopped services...
net start wuauserv >nul 2>&1
net start bits >nul 2>&1
net start cryptsvc >nul 2>&1
net start msiserver >nul 2>&1
net start trustedinstaller >nul 2>&1
echo      Services restarted.
echo.

echo [8/8] Forcing a new update detection cycle...
wuauclt /resetauthorization /detectnow >nul 2>&1
if exist "%windir%\System32\UsoClient.exe" (UsoClient StartScan >nul 2>&1) else (wuauclt /updatenow >nul 2>&1)
echo      Update scan initiated.
echo.

echo ==================================================================
echo  [SUCCESS] Windows Update repair process is complete.
echo            Please check for updates manually in Settings.
echo ==================================================================
pause
goto :menu

REM ==================================================================
:performance_fix
cls
title Phoenix Utility Suite - Optimizing System Performance...
echo [*] Initiating System Performance ^& Health Optimization...
echo.

echo [1/5] Cleaning all user ^& system temporary file caches...
del /q /f /s "%SystemRoot%\Temp\*" >nul 2>&1
del /q /f /s "%SystemRoot%\prefetch\*" >nul 2>&1
for /d %%p in ("C:\Users\*") do (
    if exist "%%p\AppData\Local\Temp" (
        del /q /f /s "%%p\AppData\Local\Temp\*" >nul 2>&1
    )
)
echo      Temporary files cleared.
echo.

echo [2/5] Running System File Checker (SFC)... This may take several minutes.
sfc /scannow
echo      SFC complete.
echo.

echo [3/5] Running DISM Health Restore... This may also take a long time.
DISM /Online /Cleanup-Image /RestoreHealth
echo      DISM complete.
echo.

echo [4/5] Optimizing and Defragmenting primary disk...
defrag C: /O
echo      Disk optimization complete.
echo.

echo [5/5] Launching Disk Cleanup...
echo      Please select items to clean in the window that appears, then click OK.
start "" /wait cleanmgr /sageset:1
echo      When ready, Disk Cleanup will run. This may take some time.
start "" /wait cleanmgr /sagerun:1
echo      Disk Cleanup finished.
echo.

echo ==================================================================
echo  [SUCCESS] Performance and health optimization is complete.
echo ==================================================================
pause
goto :menu

REM ==================================================================
:driver_fix
cls
title Phoenix Utility Suite - Resetting Drivers...
echo [*] Initiating Driver ^& Hardware Reset...
echo.
echo [WARNING] This can cause screen flickering. It is generally safe
echo           but a system restart afterwards is recommended.
echo.
set /p "confirm=Are you sure you want to continue? (Y/N): "
if /i not "%confirm%"=="Y" goto :menu

echo [1/2] Backing up current third-party drivers to C:\PhoenixDriverBackup...
md C:\PhoenixDriverBackup >nul 2>&1
pnputil /export-driver * C:\PhoenixDriverBackup >nul 2>&1
echo      Backup complete.
echo.

echo [2/2] Scanning for hardware changes to reinstall devices...
pnputil /scan-devices
echo      Hardware scan complete.
echo.

echo ==================================================================
echo  [SUCCESS] Driver and hardware reset is complete.
echo            For best results, please restart your computer.
echo ==================================================================
pause
goto :menu

REM ==================================================================
:network_fix
cls
title Phoenix Utility Suite - Resetting Network...
echo [*] Initiating Complete Network Stack ^& Firewall Reset...
echo.

echo [1/5] Flushing, releasing, renewing, and re-registering DNS/IP...
ipconfig /flushdns >nul 2>&1
ipconfig /release >nul 2>&1
ipconfig /renew >nul 2>&1
ipconfig /registerdns >nul 2>&1
echo      IP and DNS reset.
echo.

echo [2/5] Resetting Winsock Catalog...
netsh winsock reset >nul 2>&1
echo      Winsock reset.
echo.

echo [3/5] Resetting TCP/IP Stack...
netsh int ip reset >nul 2>&1
echo      TCP/IP reset.
echo.

echo [4/5] Resetting Windows Firewall to default configuration...
netsh advfirewall reset >nul 2>&1
echo      Firewall reset.
echo.

echo ==================================================================
echo  [SUCCESS] Network stack has been fully reset.
echo            A RESTART IS REQUIRED for all changes to take effect.
echo ==================================================================
pause
goto :menu

REM ==================================================================
:security_scan
cls
title Phoenix Utility Suite - Running Security Scan...
echo [*] Initiating Microsoft Defender Security Scan...
echo.

echo [1/2] Updating Microsoft Defender security intelligence...
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -SignatureUpdate
echo.

echo [2/2] Starting a Quick Scan... (This window will remain active)
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 1
echo.

echo ==================================================================
echo  [SUCCESS] Defender scan is complete. Review results above.
echo ==================================================================
pause
goto :menu

REM ==================================================================
:restart_pc
cls
title Phoenix Utility Suite - System Restart
echo This will restart your computer in 15 seconds.
echo Save all your work before proceeding.
echo.
set /p "confirm=Press (Y) to restart now or any other key to cancel: "
if /i not "%confirm%"=="Y" goto :menu

shutdown /r /t 15 /c "System restart initiated by the Phoenix Utility Suite." /f
echo The restart command has been sent. This window will close.
timeout /t 3 >nul
exit /b
