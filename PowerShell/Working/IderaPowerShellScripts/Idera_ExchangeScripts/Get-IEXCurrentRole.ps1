<#
.SYNOPSIS
    Retrieve Current Role.

.DESCRIPTION
    Retrieve Current Role.

.EXAMPLE
    PS C:\> .\Get-IEXCurrentRole.ps1

#>

#requires -pssnapin Microsoft.Exchange.Management.PowerShell.Admin 
 
function Get-IEXCurrentRole  
{
    $user = [Security.Principal.WindowsIdentity]::GetCurrent().Name
    Get-ExchangeAdministrator -Identity $user
} 
  
