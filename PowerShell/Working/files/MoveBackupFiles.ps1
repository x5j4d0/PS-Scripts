<#
.SYNOPSIS
    Script To Move File Types From One Location To Another.

.DESCRIPTION
    Script To Move File Types From One Location To Another.

.PARAMETER file
    # This will be your source backup folder.

.PARAMETER archive
    # This will be your destination folder.

.EXAMPLE
    PS C:\> .\MoveBackupFiles.ps1
    Edit the variables section and run to script To Move File Types From One Location To Another.
#>

$file = "F:\temp\Job_logs" ## This will be your source backup folder
$archive = "F:\temp\archive\" ## This will be your destination folder

foreach ($file in gci $file -include *.bak -recurse) ## Change the file type here to suit other backup file types
{
Move-Item -path $file.FullName -destination $archive ## Move the files to the archive folder
}
