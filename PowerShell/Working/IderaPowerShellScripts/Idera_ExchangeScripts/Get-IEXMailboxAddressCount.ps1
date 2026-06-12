<#
.SYNOPSIS
    Retrieve Mailbox Address Count.

.DESCRIPTION
    Retrieve Mailbox Address Count.

.EXAMPLE
    PS C:\> .\Get-IEXMailboxAddressCount.ps1

#>

#requires -pssnapin Microsoft.Exchange.Management.PowerShell.Admin 


function Get-IEXMailboxAddressCount
{
 Get-Mailbox -resultSize unlimited | Where-Object {$_.EmailAddresses.count -gt 1}
} 

 