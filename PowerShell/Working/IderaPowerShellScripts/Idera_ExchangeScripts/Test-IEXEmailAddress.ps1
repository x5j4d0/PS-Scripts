<#
.SYNOPSIS
    Test Email Address.

.DESCRIPTION
    Test Email Address.

.PARAMETER EmailAddress
    Email Address.

.EXAMPLE
    PS C:\> .\Test-IEXEmailAddress.ps1

#>

#requires -pssnapin Microsoft.Exchange.Management.PowerShell.Admin 


function Test-IEXEmailAddress
{
 param(
  [string]$EmailAddress=$(throw "EmailAddress cannot be empty.")
 ) 
 
 ![Microsoft.Exchange.Data.SmtpProxyAddress]::Parse($EmailAddress).ParseException
} 
