<#
.SYNOPSIS
    Retrieve Database Quota Statistics.

.DESCRIPTION
    Retrieve Database Quota Statistics.

.EXAMPLE
    PS C:\> .\Get-IEXDatabaseQuotaStatistics.ps1

#>

#requires -pssnapin Microsoft.Exchange.Management.PowerShell.Admin 


function Get-IEXDatabaseQuotaStatistics
{ 
 
  Get-Mailbox -ResultSize Unlimited -RecipientTypeDetails UserMailbox -Filter {UseDatabaseQuotaDefaults -eq $false} | Foreach-Object{ 

  trap { 

     Write-Error $_ 

     Continue 

  } 



  $Stats = Get-MailboxStatistics $_.Identity 

  $mbx = $_ | Select-Object Name,ServerName,Database,MaxSendSize,MaxReceiveSize,UseDatabaseQuotaDefaults,IssueWarningQuota,RulesQuota,ProhibitSendQuota,ProhibitSendReceiveQuota
  Add-Member -Input $mbx -MemberType NoteProperty -Name MailboxSize -Value $Stats.TotalItemSize
  Add-Member -Input $mbx -MemberType NoteProperty -Name StorageLimitStatus -Value $Stats.StorageLimitStatus 

  $TotalItemSize = $Stats.TotalItemSize 

  $IssueWarningQuota = $mbx.IssueWarningQuota
  $ProhibitSendQuota = $mbx.ProhibitSendQuota
  $ProhibitSendReceiveQuota = $mbx.ProhibitSendReceiveQuota 

  

  if($TotalItemSize -gt 0)
  { 


   $TotalItemSize = [double]$TotalItemSize 

  

   if($IssueWarningQuota -AND $IssueWarningQuota -gt 0)
   { 

    $IssueWarningQuota = [double]$IssueWarningQuota.Value.ToBytes() 

    Add-Member -Input $mbx -MemberType NoteProperty -Name IssueWarningPercentage -Value ("{0:P2}" -f ($TotalItemSize/$IssueWarningQuota))
   }
   else
   {
    Add-Member -Input $mbx -MemberType NoteProperty -Name IssueWarningPercentage -Value $null
   } 

  

   if($ProhibitSendQuota -AND $ProhibitSendQuota -gt 0)
   { 

    $ProhibitSendQuota = [double]$ProhibitSendQuota.Value.ToBytes() 

    Add-Member -Input $mbx -MemberType NoteProperty -Name ProhibitSendPercentage -Value ("{0:P2}" -f ($TotalItemSize/$ProhibitSendQuota))
   }
   else
   {
    Add-Member -Input $mbx -MemberType NoteProperty -Name ProhibitSendPercentage -Value $null
   } 

  

   if($ProhibitSendReceiveQuota -AND $ProhibitSendReceiveQuota -gt 0)
   { 

    $ProhibitSendReceiveQuota = [double]$ProhibitSendReceiveQuota.Value.ToBytes() 

    Add-Member -Input $mbx -MemberType NoteProperty -Name ProhibitSendReceivePercentage -Value ("{0:P2}" -f ($TotalItemSize/$ProhibitSendReceiveQuota))
   }
   else
   {
    Add-Member -Input $mbx -MemberType NoteProperty -Name ProhibitSendReceivePercentage -Value $null
   } 


  } 

  $mbx
 }
} 
