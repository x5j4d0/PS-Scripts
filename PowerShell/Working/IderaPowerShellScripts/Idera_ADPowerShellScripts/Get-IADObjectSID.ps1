<#
.SYNOPSIS
    Retrieve Active Directory object sid objects using ADSI..

.DESCRIPTION
    Retrieve Active Directory object sid objects using ADSI..

.PARAMETER InputObject
    Input Object.

.EXAMPLE
    PS C:\> .\Get-IADObjectSID.ps1
    Run the script to perform the described operation.
#>

function Get-IADObjectSID 
{ 

    param (
      $InputObject
    )  

 
 $type = $InputObject.psbase.GetType().Name
 
 if($type -notmatch '^(string|DirectoryEntry)$')
 {
  Throw "InputObject must of type 'String' or 'ADSI'"
 } 

  
 switch($type)
 {
  "DirectoryEntry"
  {
   $Object=$InputObject
   break
  }  
  "String"
  {   
   if(![ADSI]::Exists("LDAP://$InputObject"))
   {
    Throw "ADSI Object '$InputObject' doesn't exist"
   }
   else
   {
    $Object = [ADSI]"LDAP://$InputObject"
    break   
   }
  }
 } 
 
 $objectSid = [byte[]]$Object.objectSid.value
 $sid = new-object System.Security.Principal.SecurityIdentifier $objectSid,0
 $sid.value
}