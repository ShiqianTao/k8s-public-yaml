filter Timestamp { "$(Get-Date -Format o): $_" }
$LogFilepath = ".\log-process-resource-" + $(Get-Date -f yyyyMMdd-HHmmss) + ".log"
Timestamp | Out-File -Append -Filepath $LogFilepath        
systeminfo | find "Virtual Memory" | Out-File -Append -Filepath $LogFilepath
Get-Process | Sort-Object WorkingSet -Descending | Select-Object | Out-File -Append -Filepath $LogFilepath