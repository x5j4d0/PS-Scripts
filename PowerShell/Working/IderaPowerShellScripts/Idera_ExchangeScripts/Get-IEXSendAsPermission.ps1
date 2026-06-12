<#
.SYNOPSIS
    Retrieve Send As Permission.

.DESCRIPTION
    Retrieve Send As Permission.

.PARAMETER Server
    Server.

.EXAMPLE
    PS C:\> .\Get-IEXSendAsPermission.ps1

#>

#requires -pssnapin Microsoft.Exchange.Management.PowerShell.Admin 
 
function Get-IEXSendAsPermission
{
 param(


  [string]$Server = $(Throw 'Please, specify a server name.'), 

  [switch]$Inherited
 )
 
 Get-Mailbox -ResultSize Unlimited -Server $server | Get-ADPermission | Where-Object { ($_.ExtendedRights -like "*Send-As*") -AND ($_.IsInherited -eq $Inherited) -AND ($_.User -notlike "*NT AUTHORITY\SELF*") } 

} 
