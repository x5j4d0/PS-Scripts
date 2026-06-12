<#
.SYNOPSIS
    PowerShell Script to Get Recently Created Users With CSV Output.

.DESCRIPTION
    PowerShell Script to Get Recently Created Users With CSV Output.

.PARAMETER When
    Change the 'AddDays' property to match the number of Days back you want to query.

.EXAMPLE
    PS C:\> .\GetRecentADUserAccounts.ps1
    Edit the variables section and run to powerShell Script to Get Recently Created Users With CSV Output.

.NOTES
    Requires:   activedirectory
#>

Import-Module activedirectory
$When = ((Get-Date).AddDays(-1)).Date #Change the 'AddDays' property to match the number of Days back you want to query
Get-ADUser -Filter {whenCreated -ge $When} -Properties * | Select UserPrincipalName, DisplayName, GivenName, Surname, Title, EmailAddress, Department, OfficePhone, MobilePhone, Office, Company, Enabled, EmployeeNumber, @{N='Manager';E={$_.Manager.Substring($_.Manager.IndexOf("=") + 1, $_.Manager.IndexOf(",") - $_.Manager.IndexOf("=") - 1)}}, WhenCreated | Export-CSV "C:\BoxBuild\Scripts\RecentlyCreatedUsers.csv" -NoTypeInformation -Encoding "Default"
