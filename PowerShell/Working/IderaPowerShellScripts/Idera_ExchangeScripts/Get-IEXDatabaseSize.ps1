<#
.SYNOPSIS
    Retrieve Database Size.

.DESCRIPTION
    Retrieve Database Size.

.PARAMETER Server
    Server.

.PARAMETER env
    env.

.EXAMPLE
    PS C:\> .\Get-IEXDatabaseSize.ps1

#>

#requires -pssnapin Microsoft.Exchange.Management.PowerShell.Admin 
 
function Get-IEXDatabaseSize
{
 
 param(
  [string]$Server=$env:COMPUTERNAME
 ) 
  

 if ((Get-MailboxServer).RedundantMachines)
 {
  $server = (Get-ClusteredMailboxServerStatus).Identity
 }
 
 $Size = @{Name="Size(MB)";Expression={"{0:N2}" -f ((Get-ChildItem $_.EdbFilePath).Length/1MB)}}
 Get-MailboxDatabase -Server $Server | Select-Object Server,Name,StorageGroupName,$Size
} 


   