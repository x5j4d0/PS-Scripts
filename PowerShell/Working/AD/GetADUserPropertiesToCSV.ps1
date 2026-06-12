<#
.SYNOPSIS
    PowerShell Script That Uses The Get-ADUser Commandlet To Retrieve User Properties Against An OU With Output To A CSV File.

.DESCRIPTION
    PowerShell Script That Uses The Get-ADUser Commandlet To Retrieve User Properties Against
    An OU With Output To A CSV File.

.EXAMPLE
    PS C:\> .\GetADUserPropertiesToCSV.ps1
    PowerShell Script That Uses The Get-ADUser Commandlet To Retrieve User Properties Against An OU With Output To A CSV File.

.NOTES
    Requires:   ActiveDirectory
#>

Import-Module ActiveDirectory -ErrorAction SilentlyContinue

Get-ADUser -Filter * -Prop GivenName,Surname,SamAccountName,EmailAddress,Description,whenCreated,DistinguishedName -Server "ServerName.ext.YourDomain.com" -SearchBase "OU=External Users,DC=ext,DC=YourDomain,DC=com" |
Export-CSV "C:\BoxBuild\Scripts\ADUsersReport.csv" -NoTypeInformation #Change this path to match your environment with a local drive or network location