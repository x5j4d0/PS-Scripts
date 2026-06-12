<#
.SYNOPSIS
    Retrieve Active Directory group member objects using ADSI..

.DESCRIPTION
    Retrieve Active Directory group member objects using ADSI..

.PARAMETER Resolve
    Resolve.

.EXAMPLE
    PS C:\> .\Get-IADGroupMember.ps1
    Run the script to perform the described operation.
#>

filter Get-IADGroupMember {
param (
[switch]$Resolve
) 
  

 if($_ -is [ADSI] -and $_.psbase.SchemaClassName -eq 'group')
 {
  if ($Resolve) {
   $_.member |foreach {[ADSI]"LDAP://$_"}
  }
  else {
   $_.member
  }
 }
 else
 {
  Write-Warning "Invalid object type. Only 'Group' objects are allowed"
 }
} 