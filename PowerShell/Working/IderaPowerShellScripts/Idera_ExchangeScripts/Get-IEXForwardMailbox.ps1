<#
.SYNOPSIS
    Retrieve Forward Mailbox.

.DESCRIPTION
    Retrieve Forward Mailbox.

.EXAMPLE
    PS C:\> .\Get-IEXForwardMailbox.ps1

#>

#requires -pssnapin Microsoft.Exchange.Management.PowerShell.Admin 
 
function Get-IEXForwardMailbox
{          
  Get-Mailbox -Filter {ForwardingAddress -ne $null} | Select-Object Name,ForwardingAddress,DeliverToMailboxAndForward      
} 
 