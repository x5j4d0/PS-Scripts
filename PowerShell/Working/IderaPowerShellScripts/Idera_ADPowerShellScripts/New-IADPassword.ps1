<#
.SYNOPSIS
    Create a new Active Directory password objects using ADSI..

.DESCRIPTION
    Create a new Active Directory password objects using ADSI..

.PARAMETER Length
    Length.

.PARAMETER NumberOfNonAlphanumericCharacters
    Number Of Non Alphanumeric Characters.

.PARAMETER HowMany
    How Many.

.EXAMPLE
    PS C:\> .\New-IADPassword.ps1
    Run the script to perform the described operation.
#>

function New-IADPassword 

{ 

 param(
  [int]$Length,
  [int]$NumberOfNonAlphanumericCharacters,
  [int]$HowMany=1
  )
  


 begin
 { 

  
 
 $null = [Reflection.Assembly]::LoadWithPartialName("System.Web") 

  

  if($NumberOfNonAlphanumericCharacters -lt 1 -or $NumberOfNonAlphanumericCharacters -gt 128)
  {
   Throw "Length must be between 1 and 128."
  }
   
  if($HowMany -lt 1)
  {
   Throw "HowMany must be equal or greater than 1."
  }
   

 } 

  

 process
 {
  for($i=0; $i -lt $HowMany; $i++)
  {
   [System.Web.Security.Membership]::GeneratePassword($length,$NumberOfNonAlphanumericCharacters)
  }
 }
}