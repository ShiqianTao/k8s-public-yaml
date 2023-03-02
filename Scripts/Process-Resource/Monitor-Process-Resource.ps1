filter Timestamp { "$(Get-Date -Format o): $_" }
$LogFilepath = ".\process-resource-" + $(Get-Date -f yyyyMMdd-HHmmss) + ".log"
$ProcessNumber = 20 # top 20 processes of memory usage
$Interval = 60 # 60 second
$MaxTime = 60 * 60  * 24 * 3 # 3 days
for ($curTime = 0; $curTime -lt $MaxTime; $curTime+=$Interval) {
    Timestamp | Out-File -Append -Filepath $LogFilepath        
    Get-WmiObject Win32_OperatingSystem | Select-Object FreePhysicalMemory, FreeVirtualMemory | Out-File -Append -Filepath $LogFilepath
    Get-Process | Sort-Object WorkingSet -Descending | Select-Object -First $ProcessNumber | Out-File -Append -Filepath $LogFilepath
    Start-Sleep -s $Interval
}
