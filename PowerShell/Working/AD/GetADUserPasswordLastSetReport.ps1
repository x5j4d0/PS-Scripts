<#
.SYNOPSIS
    PowerShell Script to Check when Users Passwords Were Last Set (Changed) With CSV Output.

.DESCRIPTION
    PowerShell Script to Check when Users Passwords Were Last Set (Changed) With CSV Output.

.PARAMETER When
    Change the 'AddDays' property to match the number of Days back you want to query.

.EXAMPLE
    PS C:\> .\GetADUserPasswordLastSetReport.ps1
    Edit the variables section and run to powerShell Script to Check when Users Passwords Were Last Set (Changed) With CSV Output.

.NOTES
    Requires:   activedirectory
#>

Import-Module activedirectory
$When = ((Get-Date).AddDays(-30)).Date #Change the 'AddDays' property to match the number of Days back you want to query
Get-ADUser -filter {whenCreated -ge $When} -properties * | sort-object UserPrincipalName | select-object UserPrincipalName, Name, passwordlastset, passwordneverexpires | Export-CSV -path "c:\BoxBuild\RecentUserPassWordChanges.csv" -NoTypeInformation #Change this path to match your environment