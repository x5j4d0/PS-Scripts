<#
.SYNOPSIS
    Get MAXDOP.

.DESCRIPTION
    Get MAXDOP.

.PARAMETER OutputFile
    Output File.

.EXAMPLE
    PS C:\> .\GetMAXDOP.ps1
    Get MAXDOP.

.NOTES
    Requires:   SqlServerCmdletSnapin100
#>

#Gets the SQL MAXDOP running value and outputs to a given file
param
(		
	[String]$OutputFile
)

Add-PSSnapin SqlServerCmdletSnapin100 -EA 0

#Get the MAXDOP setting and output to a file
Invoke-sqlcmd -Query 'sp_configure "max degree of parallelism"' | Format-List | Out-File -filePath $OutputFile