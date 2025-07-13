@echo off
REM ================================================================
REM  Phoenix Plugin: Toggle Hidden Files Visibility
REM ================================================================

cls
echo ================================================================
echo        Phoenix Plugin: Toggle Hidden Files Visibility
echo ================================================================
echo.
echo [INFO] This will toggle the setting and restart Windows Explorer.
echo        Your screen will flash briefly.
echo.
pause
cls
echo [*] Applying changes...
echo.

powershell -Command "$val = Get-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name Hidden; if($val.Hidden -eq 1){Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name Hidden -Value 0; Write-Host 'Hidden files are now VISIBLE.'}else{Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name Hidden -Value 1; Write-Host 'Hidden files are now HIDDEN.'}; Stop-Process -Name explorer"

echo.
echo ================================================================
echo      Setting has been changed.
echo ================================================================
echo.
pause