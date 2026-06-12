<#
.SYNOPSIS
    Retrieve Active Directory domain controller2 objects using ADSI..

.DESCRIPTION
    Retrieve Active Directory domain controller2 objects using ADSI..

.PARAMETER descending
    descending.

.EXAMPLE
    PS C:\> .\Get-IADDomainController2.ps1
    Run the script to perform the described operation.
#>

function Get-IADDomainController2 { 
  
 param ( 
  [switch]$descending

 )   
  
 $domaindn = ([ADSI]"").distinguishedName 
 $searcher = New-Object System.DirectoryServices.DirectorySearcher
 $searcher.searchroot = "LDAP://OU=Domain Controllers,$domaindn"
 $searcher.filter = "objectCategory=computer"
 $searcher.sort.propertyname = "name"
 
 if ($descending)
 {
  $searcher.sort.direction = "Descending"
 } 
  
 $searcher.FindAll() | Foreach-Object { $_.GetDirectoryEntry() }
}