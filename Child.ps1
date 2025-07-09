# Check the instructions here on how to use it https://github.com/Blindsinner/Phoenix-Windows-Utility-Suite

$ErrorActionPreference = "Stop"
# Enable TLSv1.2 for compatibility with older clients
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

$DownloadURL = 'https://raw.githubusercontent.com/Blindsinner/Phoenix-Windows-Utility-Suite/2277b30bb484d261535df9651a19f029ec075eef/PX.cmd'
$DownloadURL2 = 'https://raw.githubusercontent.com/Blindsinner/Phoenix-Windows-Utility-Suite/2277b30bb484d261535df9651a19f029ec075eef/PX.cmd'

$rand = Get-Random -Maximum 99999999
$isAdmin = [bool]([Security.Principal.WindowsIdentity]::GetCurrent().Groups -match 'S-1-5-32-544')
$FilePath = if ($isAdmin) { "$env:SystemRoot\Temp\PX_$rand.cmd" } else { "$env:TEMP\PX_$rand.cmd" }

try {
    $response = Invoke-WebRequest -Uri $DownloadURL -UseBasicParsing
}
catch {
    $response = Invoke-WebRequest -Uri $DownloadURL2 -UseBasicParsing
}

$ScriptArgs = "$args "
$prefix = "@REM $rand `r`n"
$content = $prefix + $response.Content
Set-Content -Path $FilePath -Value $content

Start-Process $FilePath $ScriptArgs -Wait

$FilePaths = @("$env:TEMP\PX_*.cmd", "$env:SystemRoot\Temp\PX_*.cmd")
foreach ($Path in $FilePaths) { 
    $matchingFiles = Get-Item $Path -ErrorAction SilentlyContinue
    if ($null -ne $matchingFiles) {
        $matchingFiles | Remove-Item -Force
    }
}
