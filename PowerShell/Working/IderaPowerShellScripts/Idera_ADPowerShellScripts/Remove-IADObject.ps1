<#
.SYNOPSIS
    Remove Active Directory object objects using ADSI..

.DESCRIPTION
    Remove Active Directory object objects using ADSI..

.PARAMETER whatif
    whatif.

.PARAMETER confirm
    confirm.

.EXAMPLE
    PS C:\> .\Remove-IADObject.ps1
    Run the script to perform the described operation.
#>

filter Remove-IADObject {
 param (
  [switch]$whatif,
  [switch]$confirm
 ) 
  
  
 if($_ -is [ADSI])
 {
  if($whatif)
  {
   Write-Host "What if: Performing operation 'Remove AD Object' on Target '$($_.distinguishedName)'."
   return
  } 
  if($confirm)
  {
   $caption = "Confirm"
   $message = "Are you sure you want to perform this action?`nPerforming operation 'Remove AD Object' on Target '$($_.distinguishedName)'"
   $yes = new-Object System.Management.Automation.Host.ChoiceDescription "&Yes","Continue with only the next step of the operation.";
   $no = new-Object System.Management.Automation.Host.ChoiceDescription "&No","Skip this operation and proceed with the next operation.";
   $choices = [System.Management.Automation.Host.ChoiceDescription[]]($yes,$no);
   $answer = $Host.ui.PromptForChoice($caption,$message,$choices,0)
   
   $object = $_
   switch ($answer)
   {
    0 {
     $scn = $object.psbase.SchemaClassName
     $object.psbase.parent.delete($scn,"CN="+$object.cn)
     return
    }
    
    1 {return}
   }
  }
  
  $scn = $_.psbase.SchemaClassName
  $_.psbase.parent.delete($scn,"CN="+$_.cn)
 }
} 