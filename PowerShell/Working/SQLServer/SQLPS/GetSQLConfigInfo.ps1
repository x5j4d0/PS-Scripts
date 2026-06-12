<#
.SYNOPSIS
    Get SQL Config Info.

.DESCRIPTION
    Get SQL Config Info.

.PARAMETER OutputFile
    Output File.

.EXAMPLE
    PS C:\> .\GetSQLConfigInfo.ps1
    Get SQL Config Info.

.NOTES
    Requires:   SqlServerCmdletSnapin100
#>

#Gets the general config settings for SQL
param
(		
	[String]$OutputFile
)

Add-PSSnapin SqlServerCmdletSnapin100 -EA 0

#Get the setting and output to a file
Invoke-sqlcmd -Query 'exec sp_configure' | Format-List | Out-File -filePath $OutputFile