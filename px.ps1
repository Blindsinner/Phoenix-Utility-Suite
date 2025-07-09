# Phoenix Utility Suite - Robust Downloader
# Developed by MD Faysal Mahmud
# This script uses a more fundamental download method to avoid potential network/proxy issues.

$ErrorActionPreference = "Stop"
# Enable TLSv1.2 for compatibility with older clients
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

# The direct URL to your raw batch file on GitHub.
$DownloadURL = 'https://raw.githubusercontent.com/Blindsinner/Phoenix-Windows-Utility-Suite/main/PX.cmd'

Write-Host "Preparing to download the Phoenix Utility Suite..."

# --- Temporary File Setup ---
$rand = Get-Random -Maximum 99999999
$isAdmin = [bool]([Security.Principal.WindowsIdentity]::GetCurrent().Groups -match 'S-1-5-32-544')
$FilePath = if ($isAdmin) { "$env:SystemRoot\Temp\PX_$rand.cmd" } else { "$env:TEMP\PX_$rand.cmd" }

Write-Host "Temporary file will be created at: $FilePath"

# --- Download and Execution ---
try {
    # Use the more robust .NET WebClient for downloading
    $WebClient = New-Object System.Net.WebClient
    $WebClient.Headers.Add("Cache-Control", "no-cache") # Add no-cache header
    
    Write-Host "Downloading from: $DownloadURL"
    $WebClient.DownloadFile($DownloadURL, $FilePath)
    
    Write-Host "Download complete. Executing the suite..."
    
    # Start the downloaded batch file and wait for it to complete.
    Start-Process -FilePath $FilePath -ArgumentList $args -Wait -Verb RunAs

}
catch {
    # If any part of the 'try' block fails, display the error.
    Write-Error "A critical error occurred during download or execution: $_"
    pause
}
finally {
    # --- Cleanup ---
    # This block runs regardless of whether the script succeeded or failed.
    Write-Host "Execution finished. Cleaning up temporary files..."
    if (Test-Path -Path $FilePath) {
        Remove-Item -Path $FilePath -Force -ErrorAction SilentlyContinue
        Write-Host "Temporary file removed."
    }
}

Write-Host "Process complete."
