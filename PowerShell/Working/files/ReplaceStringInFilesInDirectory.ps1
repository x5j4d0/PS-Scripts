<#
.SYNOPSIS
    PowerShell Script to Search For And Replace Strings In Specific Files In A Directory.

.DESCRIPTION
    PowerShell Script to Search For And Replace Strings In Specific Files In A Directory.

.PARAMETER FileType
    Replace this with a '*' for all files if you don't want a file type filter.

.EXAMPLE
    PS C:\> .\ReplaceStringInFilesInDirectory.ps1
    Edit the variables section and run to powerShell Script to Search For And Replace Strings In Specific Files In A Directory.
#>

### Start Variables ###
$FilePath = "C:\BoxBuild\Scripts\Monitors"
$FileType = "ps1" #Replace this with a '*' for all files if you don't want a file type filter
$OriginalString = "email.yourorg.com"
$NewString = "appmail.yourorg.com"

### End Variables ###

cd $FilePath

$configFiles=get-childitem . *.$FileType -recurse
foreach ($file in $configFiles)
{
(Get-Content $file.PSPath) | 
Foreach-Object {$_ -replace $OriginalString, $NewString} | 
Set-Content $file.PSPath
}