<#
.SYNOPSIS
    Retrieve Mailbox Count Report.

.DESCRIPTION
    Retrieve Mailbox Count Report.

.PARAMETER Server
    Server.

.EXAMPLE
    PS C:\> .\Get-IEXMailboxCountReport.ps1

#>

#requires -pssnapin Microsoft.Exchange.Management.PowerShell.Admin 
   

function Get-IEXMailboxCountReport{ 
 param( 
     [string]$Server = $(Throw 'Please specify a server name.') 
 )  
  
 Get-Mailbox -Server $Server | Group-Object {$_.Database.Name} -NoElement | Sort-Object -Property Count -Descending 
}
  