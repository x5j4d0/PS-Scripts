<#
.SYNOPSIS
    Retrieve Active Directory current forest objects using ADSI..

.DESCRIPTION
    Retrieve Active Directory current forest objects using ADSI..

.EXAMPLE
    PS C:\> .\Get-IADCurrentForest.ps1
    Run the script to perform the described operation.
#>

function Get-IADCurrentForest {  
 [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest()
} 