<#
.SYNOPSIS
    Create a new Address List.

.DESCRIPTION
    Create a new Address List.

.PARAMETER Name
    Name.

.EXAMPLE
    PS C:\> .\New-IEXAddressList.ps1

#>

#requires -pssnapin Microsoft.Exchange.Management.PowerShell.Admin 

  
filter New-IEXAddressList
{
 
 param (
  [string]$Name
 ) 

 if($_ -is [Microsoft.Exchange.Data.Directory.Management.DistributionGroup])
 { 

  trap
  {
   Write-Error $_
   continue
  } 

  $groupDN = $_.Identity.DistinguishedName 

  if(!$Name)
  {
   Write-Warning "No Name has been specified, the DistributionGroup name will be used instead."
   $Name = $_.Name
  }
  
  
  New-AddressList -Name $Name -RecipientFilter "MemberOfGroup -eq '$groupDN'" | Update-AddressList
 }
 else
 {
  Write-Warning "Wrong object type, only DistributionGroup objects are allowed.`nUsage example: Get-DistributionGroup TestGroup | New-IEXAddressList -Name TestAL."
 }
} 

  
