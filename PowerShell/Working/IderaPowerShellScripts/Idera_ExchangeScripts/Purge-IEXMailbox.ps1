<#
.SYNOPSIS
    Purge Mailbox.

.DESCRIPTION
    Purge Mailbox.

.PARAMETER Server
    Server.

.EXAMPLE
    PS C:\> .\Purge-IEXMailbox.ps1

#>

#requires -pssnapin Microsoft.Exchange.Management.PowerShell.Admin 
   
function Purge-IEXMailbox {
 
 param(
  [string]$Server=$(throw "Server parameter cannot be empty"),
  [switch]$Confirm
 )
 
 Get-MailboxStatistics -Server $Server | Where-Object {$_.DisconnectDate} | Foreach-Object {
  Remove-Mailbox -Database $_.Database -StoreMailboxIdentity $_.MailboxGuid -Confirm:$Confirm
 }
} 

  