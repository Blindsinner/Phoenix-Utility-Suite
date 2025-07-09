@echo off
REM ================================================================
REM                      Phoenix Utility Suite
REM              (Developed by MD Faysal Mahmud – Revised)
REM
REM  Description: All-in-one toolkit for repairing Windows Update,
REM               optimizing performance, fixing drivers, and
REM               resolving network issues.
REM  Usage: Save as .bat, right-click, “Run as administrator”.
REM ================================================================

setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

:check_admin
    openfiles >nul 2>&1
    if %errorlevel% neq 0 (
        cls
        echo [ERROR] This script requires administrative privileges.
        echo Please right-click and select “Run as administrator”.
        pause
        exit /b
    )

:menu
    cls
    color 0B
    title Phoenix Utility Suite - Main Menu

    echo ================================================================
    echo                      PHOENIX UTILITY SUITE
    echo                   (Developed by MD Faysal Mahmud)
    echo ================================================================
    echo.
    echo   [1] Full Windows Update ^& Component Repair
    echo   [2] System Performance ^& Health Optimization
    echo   [3] Driver ^& Hardware Reset
    echo   [4] Complete Network Stack ^& Firewall Reset
    echo   [5] Run Security Scan (Microsoft Defender)
    echo   [6] System Restart
    echo   [0] Exit
    echo.
    echo ================================================================
    set /p "choice=Enter your choice [0-6]: "

    rem Dispatch
    if "%choice%"=="1" goto update_fix
    if "%choice%"=="2" goto performance_fix
    if "%choice%"=="3" goto driver_fix
    if "%choice%"=="4" goto network_fix
    if "%choice%"=="5" goto security_scan
    if "%choice%"=="6" goto restart_pc
    if "%choice%"=="0" exit /b

    rem Invalid selection
    echo.
    echo [ERROR] Invalid choice. Please select a number between 0 and 6.
    pause
    goto menu

:update_fix
    cls
    title Windows Update ^& Component Repair
    echo [*] Performing Update Repair...
    echo.

    echo [1/8] Stopping services...
    for %%S in (wuauserv bits cryptsvc msiserver trustedinstaller) do (
        net stop %%S >nul 2>&1
    )
    echo      Done.
    echo.

    echo [2/8] Clearing Update caches...
    rd /s /q "%windir%\SoftwareDistribution"    >nul 2>&1
    rd /s /q "%windir%\System32\catroot2"        >nul 2>&1
    md "%windir%\SoftwareDistribution"           >nul
    md "%windir%\System32\catroot2"              >nul
    echo      Done.
    echo.

    echo [3/8] Re-registering Update DLLs...
    for %%D in (wuapi.dll wups.dll wuaueng.dll wucltui.dll msxml3.dll) do (
        regsvr32.exe /s %%D >nul 2>&1
    )
    echo      Done.
    echo.

    echo [4/8] Resetting OSUpgrade registry keys...
    reg delete   "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade\Rollback" /f >nul 2>&1
    reg add      "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade"    /f >nul 2>&1
    echo      Done.
    echo.

    echo [5/8] Running SFC (System File Checker)...
    echo      This may take several minutes...
    sfc /scannow
    echo      SFC complete.
    echo.

    echo [6/8] Running DISM RestoreHealth...
    echo      This may also take a while...
    DISM /Online /Cleanup-Image /RestoreHealth
    echo      DISM complete.
    echo.

    echo [7/8] Restarting services...
    for %%S in (wuauserv bits cryptsvc msiserver trustedinstaller) do (
        net start %%S >nul 2>&1
    )
    echo      Done.
    echo.

    echo [8/8] Forcing new update detection...
    wuauclt /resetauthorization /detectnow >nul 2>&1
    if exist "%windir%\System32\UsoClient.exe" (
        UsoClient StartScan >nul 2>&1
    ) else (
        wuauclt /updatenow >nul 2>&1
    )
    echo      Scan initiated.
    echo.

    echo ================================================================
    echo [SUCCESS] Update repair complete. Check Settings -^> Windows Update.
    echo ================================================================
    pause
    goto menu

:performance_fix
    cls
    title System Performance ^& Health Optimization
    echo [*] Optimizing Performance ^& Health...
    echo.

    echo [1/5] Cleaning temp files...
    del /q /f /s "%SystemRoot%\Temp\*" >nul 2>&1
    del /q /f /s "%SystemRoot%\Prefetch\*" >nul 2>&1
    for /d %%U in ("C:\Users\*") do (
        if exist "%%U\AppData\Local\Temp" (
            del /q /f /s "%%U\AppData\Local\Temp\*" >nul 2>&1
        )
    )
    echo      Done.
    echo.

    echo [2/5] Running SFC...
    echo      Please wait...
    sfc /scannow
    echo      Done.
    echo.

    echo [3/5] Running DISM RestoreHealth...
    DISM /Online /Cleanup-Image /RestoreHealth
    echo      Done.
    echo.

    echo [4/5] Optimizing disk (Defrag ^& Trim)...
    defrag C: /O >nul
    echo      Done.
    echo.

    echo [5/5] Launching Disk Cleanup UI...
    start "" /wait cleanmgr /sageset:1
    start "" /wait cleanmgr /sagerun:1
    echo      Done.
    echo.

    echo ================================================================
    echo [SUCCESS] Performance optimization complete.
    echo ================================================================
    pause
    goto menu

:driver_fix
    cls
    title Driver ^& Hardware Reset
    echo [*] Resetting Drivers ^& Hardware...
    echo.
    echo [WARNING] Screen flicker possible. A reboot is recommended.
    echo.
    set /p "confirm=Proceed with driver reset? (Y/N): "
    if /i not "%confirm%"=="Y" goto menu
    echo.

    echo [1/2] Backing up drivers to C:\PhoenixDriverBackup...
    md C:\PhoenixDriverBackup >nul 2>&1
    pnputil /export-driver * C:\PhoenixDriverBackup >nul 2>&1
    echo      Backup complete.
    echo.

    echo [2/2] Scanning for hardware changes...
    pnputil /scan-devices
    echo      Scan complete.
    echo.

    echo ================================================================
    echo [SUCCESS] Driver reset complete. Please reboot your PC.
    echo ================================================================
    pause
    goto menu

:network_fix
    cls
    title Network Stack ^& Firewall Reset
    echo [*] Resetting Network Stack ^& Firewall...
    echo.

    echo [1/5] IP/DNS flush ^& renew...
    ipconfig /flushdns   >nul 2>&1
    ipconfig /release    >nul 2>&1
    ipconfig /renew      >nul 2>&1
    ipconfig /registerdns>nul 2>&1
    echo      Done.
    echo.

    echo [2/5] Winsock reset...
    netsh winsock reset   >nul 2>&1
    echo      Done.
    echo.

    echo [3/5] TCP/IP reset...
    netsh int ip reset    >nul 2>&1
    echo      Done.
    echo.

    echo [4/5] Resetting Windows Firewall...
    netsh advfirewall reset>nul 2>&1
    echo      Done.
    echo.

    echo ================================================================
    echo [SUCCESS] Network reset complete. A restart is required.
    echo ================================================================
    pause
    goto menu

:security_scan
    cls
    title Microsoft Defender Security Scan
    echo [*] Running Microsoft Defender Quick Scan...
    echo.

    echo [1/2] Updating definitions...
    "%ProgramFiles%\Windows Defender\MpCmdRun.exe" -SignatureUpdate
    echo.
    echo [2/2] Quick scan in progress...
    "%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 1
    echo.

    echo ================================================================
    echo [SUCCESS] Defender scan complete. Review results above.
    echo ================================================================
    pause
    goto menu

:restart_pc
    cls
    title System Restart
    echo This will restart your PC in 15 seconds.
    echo Save all work before proceeding.
    echo.
    set /p "confirm=Press Y to restart, any other key to cancel: "
    if /i "%confirm%"=="Y" (
        shutdown /r /t 15 /c "Restart initiated by Phoenix Utility Suite." /f
        echo Restart command sent. Exiting...
        timeout /t 5 >nul
        exit /b
    ) else (
        goto menu
    )
