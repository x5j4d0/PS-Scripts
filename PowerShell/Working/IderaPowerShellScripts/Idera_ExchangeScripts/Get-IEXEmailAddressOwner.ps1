<#
.SYNOPSIS
    Retrieve Email Address Owner.

.DESCRIPTION
    Retrieve Email Address Owner.

.PARAMETER EmailAddress
    Email Address.

.EXAMPLE
    PS C:\> .\Get-IEXEmailAddressOwner.ps1

#>

#requires -pssnapin Microsoft.Exchange.Management.PowerShell.Admin 
 
function Get-IEXEmailAddressOwner
{

 param(
  [string]$EmailAddress
 )

 
    if([Microsoft.Exchange.Data.SmtpProxyAddress]::Parse($EmailAddress).ParseException)
    {
        Throw "Invalid email address: '$EmailAddress'"
    } 

    Get-Mailbox -Filter {EmailAddresses -eq $EmailAddress}
}

