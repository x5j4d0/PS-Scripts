<#
.SYNOPSIS
    Retrieve Mailbox Folder Statistics.

.DESCRIPTION
    Retrieve Mailbox Folder Statistics.

.PARAMETER Server
    Server.

.EXAMPLE
    PS C:\> .\Get-IEXMailboxFolderStatistics.ps1

#>

#requires -pssnapin Microsoft.Exchange.Management.PowerShell.Admin 

function Get-IEXMailboxFolderStatistics
{  
  
    param( 
       [string]$Server=$(Throw "parameter 'Server' cannot be empty"),
       [string]$Identity="*" 
    ) 
 
 
  
 $Now = Get-Date 

 Get-Mailbox -ResultSize Unlimited -Identity $Identity -Server $Server | Foreach-Object {
 
  $Mailbox = $_
  $FolderStatistics = Get-MailboxFolderStatistics -Identity $Mailbox -IncludeOldestAndNewestItems | Sort-Object -Descending NewestItemReceivedDate,OldestItemReceivedDate  
  

  $FolderStatistics | Foreach-Object { 
 
  
   trap { 
      Write-Error$_
      Continue
   }
 
   $_ | Add-Member -MemberType NoteProperty -Name UserName -Value $Mailbox.Name
 
  
   if($_.NewestItemReceivedDate) {
    $_ | Add-Member -MemberType NoteProperty -Name "NewestItemReceivedDate(Days)" -Value $Now.Subtract($_.NewestItemReceivedDate).Days
   } 

 
   if($_.OldestItemReceivedDate) {
    $_ | Add-Member -MemberType NoteProperty -Name "OldestItemReceivedDate(Days)" -Value $Now.Subtract($_.OldestItemReceivedDate).Days
   } 

  } 

  $FolderStatistics 

 }
} 
