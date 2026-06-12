<#
.SYNOPSIS
    Move Active Directory object objects using ADSI..

.DESCRIPTION
    Move Active Directory object objects using ADSI..

.PARAMETER ObjectDN
    Object DN.

.PARAMETER NewLocationDN
    New Location DN.

.EXAMPLE
    PS C:\> .\Move-IADObject.ps1
    Run the script to perform the described operation.
#>

function Move-IADObject { 


 param(
  [object[]]$ObjectDN,
  [string]$NewLocationDN=$(Throw "Parameter 'NewLocationDN' must have a value")
 ) 
  

    
 begin
 {
  if(![ADSI]::Exists("LDAP://$NewLocationDN"))
  {
   Throw "'$NewLocationDN' doesn't exist, please check the value."
  }
  else
  {
   $NewRoot = [ADSI]"LDAP://$NewLocationDN"
  }
 }
 
 process
 {
 
  trap
  {
   Write-Error $_
   continue
  }
  
  if($_ -is [ADSI])
  {
   $_.psbase.MoveTo($NewRoot)
  }
  else
  { 

   $ObjectDN | Foreach-Object { 
    if(!$_)
    {
     Write-Error "ObjectDN must have a value."
    }
    elseif(![ADSI]::Exists("LDAP://$_"))
    {
     Write-Error "ObjectDN '$_' doesn't exist, please check the value."
    }
    else
    {
     $obj = [ADSI]("LDAP://$_")
     $obj.psbase.MoveTo($NewRoot)
    }
   } 
  }   
 }
}