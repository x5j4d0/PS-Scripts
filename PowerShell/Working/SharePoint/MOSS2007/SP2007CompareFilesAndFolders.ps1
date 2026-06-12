<#
.SYNOPSIS
    PowerShell Commands To Compare Files And Folders Between Servers.

.DESCRIPTION
    PowerShell Commands To Compare Files And Folders Between Servers.

.EXAMPLE
    PS C:\> .\SP2007CompareFilesAndFolders.ps1
    PowerShell Commands To Compare Files And Folders Between Servers.
#>

$Server1 =  Dir "\\spcharon1\c$\Program Files\Common Files\Microsoft Shared\Web Server Extensions\12\TEMPLATE\FEATURES"
$Server2 =  Dir "\\spleda3\c$\Program Files\Common Files\Microsoft Shared\Web Server Extensions\12\TEMPLATE\FEATURES"

Compare-Object $Server1 $Server2
