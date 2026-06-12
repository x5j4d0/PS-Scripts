<#
.SYNOPSIS
    Script to Monitor Files In Directories and Moves or Copies Files To A Destination When New Files Are Created.

.DESCRIPTION
    Script to Monitor Files In Directories and Moves or Copies Files To A Destination When
    New Files Are Created.

.PARAMETER folder
    <-- set your source folder here.

.PARAMETER filter
    <-- set this filter according to your requirements.

.PARAMETER destination
    <-- set your destination folder here.

.EXAMPLE
    PS C:\> .\DirectoryFilesMonitor.ps1
    Edit the variables section and run to script to Monitor Files In Directories and Moves or Copies Files To A Destination When New Files Are Created.
#>

$folder = 'C:\ztemp\FileMonitorSource\' # <-- set your source folder here
$filter = '*.*'                             # <-- set this filter according to your requirements
$destination = 'C:\ztemp\FileMonitorDestination\' # <-- set your destination folder here
$fsw = New-Object IO.FileSystemWatcher $folder, $filter -Property @{
 IncludeSubdirectories = $false # <-- set this to 'true' or 'false' according to your requirements
 NotifyFilter = [IO.NotifyFilters]'FileName, LastWrite'
}
$onCreated = Register-ObjectEvent $fsw Created -SourceIdentifier FileCreated -Action {
 $path = $Event.SourceEventArgs.FullPath
 $name = $Event.SourceEventArgs.Name
 $changeType = $Event.SourceEventArgs.ChangeType
 $timeStamp = $Event.TimeGenerated
 Write-Host "The file '$name' was $changeType at $timeStamp"
 #Move-Item -Path $path -Destination $destination -Force -Verbose # Force will overwrite files with same name
 Copy-Item -Path $path -Destination $destination -Force -Verbose # Force will overwrite files with same name
}

# The subscription will be 'Unregistered' when PowerShell closes, or you can use this command:
#Unregister-Event -SourceIdentifier FileCreated