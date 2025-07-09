# Phoenix Utility Suite - Robust Downloader
# Developed by MD Faysal Mahmud
# This version launches the main script and lets it self-delete to prevent crashes.

$ErrorActionPreference = "Stop"
# Enable TLSv1.2 for compatibility with older clients
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

# The direct URL to your raw batch file on GitHub.
$DownloadURL = 'https://raw.githubusercontent.com/Blindsinner/Phoenix-Windows-Utility-Suite/main/PX.cmd'
$DownloadURL2 = 'https://raw.githubusercontent.com/Blindsinner/Phoenix-Windows-Utility-Suite/main/PX.cmd'

$rand = Get-Random -Maximum 99999999
$isAdmin = [bool]([Security.Principal.WindowsIdentity]::GetCurrent().Groups -match 'S-1-5-32-544')
$FilePath = if ($isAdmin) { "$env:SystemRoot\Temp\PX_$rand.cmd" } else { "$env:TEMP\PX_$rand.cmd" }

try {
    # Attempt to download the script content from the primary URL.
    try {
        $response = Invoke-WebRequest -Uri $DownloadURL -UseBasicParsing
    }
    catch {
        # If the primary URL fails, try the fallback URL.
        $response = Invoke-WebRequest -Uri $DownloadURL2 -UseBasicParsing
    }

    $ScriptArgs = "$args "
    $prefix = "@REM $rand `r`n"
    $content = $prefix + $response.Content
    Set-Content -Path $FilePath -Value $content

    # Start the process and immediately exit. The batch file will handle its own cleanup.
    Start-Process -FilePath $FilePath -ArgumentList $ScriptArgs -Verb RunAs
}
catch {
    # If any part of the 'try' block fails, display the error.
    Write-Error "A critical error occurred during download or execution: $_"
    pause
}
