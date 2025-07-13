@echo off
REM ================================================================
REM  Phoenix Plugin: Show Saved Wi-Fi Passwords (v3 - Final)
REM ================================================================

cls
echo ================================================================
echo           Phoenix Plugin: Show Saved Wi-Fi Passwords
echo ================================================================
echo.
echo [INFO] Retrieving all saved Wi-Fi profiles and their passwords...
echo.

rem Create a temporary PowerShell script
>"%temp%\GetWifiPasswords.ps1" echo (netsh wlan show profiles) ^| Select-String "\s+:\s(.*)" ^| ForEach-Object {
>>"%temp%\GetWifiPasswords.ps1" echo     $name = $_.Matches.Groups[1].Value.Trim()
>>"%temp%\GetWifiPasswords.ps1" echo     $pass = (netsh wlan show profile name="$name" key=clear) ^| Select-String "Key Content\s+:\s(.*)" ^| ForEach-Object {$_.Matches.Groups[1].Value.Trim()}
>>"%temp%\GetWifiPasswords.ps1" echo     if ($pass) {
>>"%temp%\GetWifiPasswords.ps1" echo         [pscustomobject]@{
>>"%temp%\GetWifiPasswords.ps1" echo             SSID = $name
>>"%temp%\GetWifiPasswords.ps1" echo             Password = $pass
>>"%temp%\GetWifiPasswords.ps1" echo         }
>>"%temp%\GetWifiPasswords.ps1" echo     }
>>"%temp%\GetWifiPasswords.ps1" echo } ^| Format-Table -AutoSize

rem Run the temporary script
powershell -ExecutionPolicy Bypass -File "%temp%\GetWifiPasswords.ps1"

rem Delete the temporary script
del "%temp%\GetWifiPasswords.ps1"

echo.
echo ================================================================
echo      Finished retrieving passwords.
echo ================================================================
echo.
pause