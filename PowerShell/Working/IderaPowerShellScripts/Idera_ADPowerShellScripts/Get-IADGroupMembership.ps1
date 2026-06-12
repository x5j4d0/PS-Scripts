<#
.SYNOPSIS
    Retrieve Active Directory group membership objects using ADSI..

.DESCRIPTION
    Retrieve Active Directory group membership objects using ADSI..

.PARAMETER ExpandNested
    Expand Nested.

.PARAMETER Resolve
    Resolve.

.EXAMPLE
    PS C:\> .\Get-IADGroupMembership.ps1
    Run the script to perform the described operation.
#>

filter Get-IADGroupMembership {
 param(
  [switch]$ExpandNested,
  [switch]$Resolve
 ) 
  
  
 if($_ -is [ADSI] -and $_.MemberOf)
 {
  trap
  {
   Write-Error $_
   continue
  } 
  $_.MemberOf | foreach {
  
   if($Resolve)
   {
    $group = [ADSI]"LDAP://$_"       
    $group
    
    if($ExpandNested)
    {     
     $group  | Get-IADGroupMembership -ExpandNested:$ExpandNested -Resolve:$Resolve  
    }   
   }
   elseif($ExpandNested)
   {
    $group = [ADSI]"LDAP://$_"       
    $group  
    $group | Get-IADGroupMembership -ExpandNested:$ExpandNested 
   }
   else
   {
    $_
   }
  }
 }
}