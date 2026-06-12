<#
.SYNOPSIS
    Retrieve Active Directory object by sid objects using ADSI..

.DESCRIPTION
    Retrieve Active Directory object by sid objects using ADSI..

.PARAMETER SID
    SID.

.EXAMPLE
    PS C:\> .\Get-IADObjectBySID.ps1
    Run the script to perform the described operation.
#>

function Get-IADObjectBySID 
{

 param(
  [string]$SID
 ) 
  
 $si = New-Object System.Security.Principal.SecurityIdentifier $SID
 
 if($si.IsAccountSid())
 {  
  $si.Translate([System.Security.Principal.NTAccount]).Value
 }
 else
 {
  Write-Error "'$si' is not a valid Windows account SID."
 }
}