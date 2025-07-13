@echo off
REM ================================================================
REM  Phoenix Plugin: System Info Reporter
REM  Description: Displays basic system and hardware information.
REM ================================================================

cls
echo ================================================================
echo                Phoenix Plugin: System Information
echo ================================================================
echo.

echo [INFO] Gathering basic system details...
echo ----------------------------------------------------------------
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Type" /C:"Total Physical Memory"
echo.

echo [INFO] Gathering CPU details...
echo ----------------------------------------------------------------
wmic cpu get name, numberofcores, maxclockspeed
echo.

echo [INFO] Gathering basic network IP configuration...
echo ----------------------------------------------------------------
ipconfig | findstr /R /C:"IPv4 Address" /C:"Subnet Mask" /C:"Default Gateway"
echo.

echo.
echo [SUCCESS] System information report complete.
echo.
