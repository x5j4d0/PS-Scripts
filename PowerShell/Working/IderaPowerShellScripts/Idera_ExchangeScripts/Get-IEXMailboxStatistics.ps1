<#
.SYNOPSIS
    Retrieve Mailbox Statistics.

.DESCRIPTION
    Retrieve Mailbox Statistics.

.PARAMETER Server
    Server.

.PARAMETER Identity
    Identity.

.PARAMETER AddUserProperties
    Add User Properties.

.EXAMPLE
    PS C:\> .\Get-IEXMailboxStatistics.ps1

#>

#requires -pssnapin Microsoft.Exchange.Management.PowerShell.Admin  
 

function Get-IEXMailboxStatistics
{
 param(
  [string]$Server,
  [string]$Identity,
  [string[]]$AddUserProperties
 )
 
 
 if($Server -AND $Identity)
 {
  Throw "Parameter set cannot be resolved using the specified named parameters."
 }
 
 if($Server)
 {
  if($AddUserProperties)
  {
   Get-MailboxStatistics -Server $Server | Where-Object {$_.ObjectClass -eq 'mailbox'} | Foreach-Object {
   
    $user = Get-User $_.DisplayName
    $mbx = $_
   
    $AddUserProperties | Foreach-Object {   
     Add-Member -InputObject $mbx -MemberType NoteProperty -Name $_ -Value $user.$_
    }
   
    $mbx
   }
  }
  else
  {
   Get-MailboxStatistics -Server $Server
  }
 }
 
 if($Identity)
 { 
  if($AddUserProperties)
  {
   $mbx = Get-MailboxStatistics -Identity $Identity
  
   if($mbx.ObjectClass -eq 'mailbox')
   {  
    $user = Get-User $mbx.DisplayName
    $AddUserProperties | Foreach-Object {   
     Add-Member -InputObject $mbx -MemberType NoteProperty -Name $_ -Value $user.$_
    }
    $mbx
   }
   else
   {
    Write-Error "$Identity has no AD user, no additional properties attached."
    Get-MailboxStatistics -Identity $Identity
   }
  }
  else
  {
   Get-MailboxStatistics -Identity $Identity 
  }
 }
}
 