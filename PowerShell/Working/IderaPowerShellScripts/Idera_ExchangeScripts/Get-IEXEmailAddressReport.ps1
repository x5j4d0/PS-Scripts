<#
.SYNOPSIS
    Retrieve Email Address Report.

.DESCRIPTION
    Retrieve Email Address Report.

.PARAMETER Server
    Server.

.EXAMPLE
    PS C:\> .\Get-IEXEmailAddressReport.ps1

#>

#requires -pssnapin Microsoft.Exchange.Management.PowerShell.Admin 

function Get-IEXEmailAddressReport
{ 

 param(
  [string]$Server = $(Throw 'Please, specify a server name.'), 
  [Microsoft.Exchange.Configuration.Tasks.OrganizationalUnitIdParameter]$OrganizationalUnit = $null  
 ) 

 Get-Mailbox -ResultSize unlimited -Server $Server -OrganizationalUnit $OrganizationalUnit | Select-Object DisplayName -ExpandProperty EmailAddresses | Where-Object {$_.SmtpAddress} | Select-Object DisplayName,SmtpAddress 

} 
