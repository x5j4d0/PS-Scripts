<#
.SYNOPSIS
    Retrieve Inactive Mailbox.

.DESCRIPTION
    Retrieve Inactive Mailbox.

.PARAMETER Server
    Server.

.EXAMPLE
    PS C:\> .\Get-IEXInactiveMailbox.ps1

#>

#requires -pssnapin Microsoft.Exchange.Management.PowerShell.Admin 

function Get-IEXInactiveMailbox
{
 param(
  [string]$Server=$(Throw "parameter 'Server' cannot be empty"),
  [int]$Days=180
 )  
 
 
 $Now = Get-Date 

 Get-Mailbox -ResultSize Unlimited -Server $Server | Foreach-Object {
 
   trap { 
      Write-Error$_
      Continue
   }

  $Mailbox = $_
  $FolderStatistics = Get-MailboxFolderStatistics -Identity $Mailbox -IncludeOldestAndNewestItems -FolderScope SentItems | Where-Object {$_.FolderType -eq 'SentItems'}
  Add-Member -Input $FolderStatistics -MemberType NoteProperty -Name UserName -Value $Mailbox.Name 
  
  if($FolderStatistics.NewestItemReceivedDate)
  {
   Add-Member -Input $FolderStatistics -MemberType NoteProperty -Name "LastEmailSent(Days)" -Value $Now.Subtract($FolderStatistics.NewestItemReceivedDate).Days  
  }
  else
  {
   Add-Member -Input $FolderStatistics -MemberType NoteProperty -Name "LastEmailSent(Days)" -Value "No Items Found"
  } 


  $LastEmailSent = $FolderStatistics."LastEmailSent(Days)" 

  if($LastEmailSent -ge $Days -OR $LastEmailSent -eq "No Items Found")
  {
   $FolderStatistics | Select-Object UserName,"LastEmailSent(Days)"
  }
 }
} 
  