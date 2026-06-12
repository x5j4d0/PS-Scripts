<#
.SYNOPSIS
    Retrieve Active Directory alt recipient objects using ADSI..

.DESCRIPTION
    Retrieve Active Directory alt recipient objects using ADSI..

.EXAMPLE
    PS C:\> .\Get-IADAltRecipient.ps1
    Run the script to perform the described operation.
#>

function Get-IADAltRecipient 
{ 

 $searcher = New-Object System.DirectoryServices.DirectorySearcher
 $searcher.SearchRoot = [ADSI]""
 $searcher.PageSize = 1000
 $searcher.filter = "(&(sAMAccountType=805306368)(mail=*)(altRecipient=*))" 
  
 $searcher.FindAll() | Foreach-Object {
  $pso = "" | select Name,DN,Description,AltRecipient
  $pso.Name = [string]$_.Properties.name
  $pso.DN = [string]$_.Properties.distinguishedname
  $pso.Description = [string]$_.Properties.description
  $pso.AltRecipient = [string]$_.Properties.altrecipient
  $pso
 }
}