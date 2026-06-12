<#
.SYNOPSIS
    Create a new Test Mailbox.

.DESCRIPTION
    Create a new Test Mailbox.

.PARAMETER Name
    Name.

.PARAMETER Password
    Password.

.PARAMETER Database
    Database.

.EXAMPLE
    PS C:\> .\New-IEXTestMailbox.ps1

#>

#requires -pssnapin Microsoft.Exchange.Management.PowerShell.Admin 

  
function New-IEXTestMailbox
{ 
 param(
  [string]$Name="Test", 
  [string]$Password='P@ssw0rd',
  [string]$Database=$(Throw "Parameter 'Database' cannot be empty"),
  [string]$OrganizationalUnit,
  [int]$Count=1,
  [switch]$WhatIf,
  [switch]$Confirm
 )
 
 trap {
  Write-Error $_
  continue
 }
 
 $DomainFQDN = ([ADSI]"").distinguishedName -replace 'dc=' -replace ',','.'
 
 if(!$OrganizationalUnit)
 {
  $OrganizationalUnit = "$DomainFQDN/Users"
 } 

 $db = Get-MailboxDatabase | Where-Object {$_.Name -eq $Database}
 if(!$db)
 {
  Throw "Database '$Database' could not be found"
 }
 
 $Pwd = ConvertTo-SecureString -String $Password -AsPlainText -Force
 
 1..$Count | ForEach-Object { 
  $UPN = "$Name{0:00}@$DomainFQDN" -f $_
  $NewName = "$Name{0:00}" -f $_
  New-Mailbox -Name $NewName -Password $Pwd -Database $db -UserPrincipalName $UPN -OrganizationalUnit $OrganizationalUnit -WhatIf:$WhatIf -Confirm:$Confirm
}
 
} 