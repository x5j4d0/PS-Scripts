<#
.SYNOPSIS
    Retrieve Database Statistics.

.DESCRIPTION
    Retrieve Database Statistics.

.PARAMETER Server
    Server.

.EXAMPLE
    PS C:\> .\Get-IEXDatabaseStatistics.ps1

#>

#requires -pssnapin Microsoft.Exchange.Management.PowerShell.Admin 

function Get-IEXDatabaseStatistics
{
 param(
  [string]$Server=$(Throw "parameter 'Server' cannot be empty")
 ) 
  
 trap { Throw $_} 
  
 $MbxCount = @{Name="MailboxCount";Expression={ $_.Count }}
 $TotalSize = @{Name="TotalSize(GB)";Expression={ "{0:N2}" -f (($_.group | Measure-Object TotalItemSize -Sum).Sum/1GB)}} 

 Get-MailboxStatistics -Server $Server | Group-Object Database | Select-Object Name,$MbxCount,$TotalSize
} 
