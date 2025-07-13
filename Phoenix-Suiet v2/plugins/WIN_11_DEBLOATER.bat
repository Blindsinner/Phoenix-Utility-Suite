@echo off
REM ================================================================
REM  Phoenix Plugin: Windows 11 Debloater
REM  Description: Launches a third-party Windows 11 debloating
REM               script from debloat.raphi.re.
REM ================================================================

cls
echo ================================================================
echo            Phoenix Plugin: Windows 11 Debloater
echo ================================================================
echo.
echo [EXTREME WARNING] Debloating tools make significant changes
echo                   to your operating system and can cause
echo                   unexpected issues.
echo.
echo [RECOMMENDATION] It is STRONGLY recommended to create a
echo                  System Restore Point before continuing.
echo.
set /p "confirm=Do you understand the risk and want to proceed? (Y/N): "
if /i not "%confirm%"=="Y" (
    echo.
    echo Operation cancelled by user.
    goto :eof
)

echo.
echo [INFO] The debloating utility will open in a NEW window.
echo        Please follow the instructions there.
echo.
echo        Launching now...
echo.

rem This command uses PowerShell to download and execute the script.
powershell -ExecutionPolicy Bypass -Command "& ([scriptblock]::Create((irm 'https://debloat.raphi.re/')))"

echo.
echo [SUCCESS] The debloating script has been launched.
echo.