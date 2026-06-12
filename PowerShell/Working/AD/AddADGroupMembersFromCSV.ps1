<#
.SYNOPSIS
    PowerShell Script to Add and Remove Users from AD Security Groups based on CSV File.

.DESCRIPTION
    PowerShell Script to Add and Remove Users from AD Security Groups based on CSV File.

.EXAMPLE
    PS C:\> .\AddADGroupMembersFromCSV.ps1
    PowerShell Script to Add and Remove Users from AD Security Groups based on CSV File.

.NOTES
    Requires:   ActiveDirectory
    Resources:  http://mikefrobbins.com/2016/02/25/use-powershell-to-add-active-directory-users-to-specific-groups-based-on-a-csv-file
#>

Import-Module ActiveDirectory

$FilePath = "C:\tmp\UserGroups.csv"

Import-Csv -Path $FilePath | Format-Table

$Header = ((Get-Content -Path $FilePath -TotalCount 1) -split ',').Trim()
$Users = Import-Csv -Path $FilePath
foreach ($Group in $Header[1..($Header.Count -1)]) {
    Add-ADGroupMember -Identity $Group -Members ($Users | Where-Object $Group -eq 'X' | Select-Object -ExpandProperty $Header[0])
    Remove-ADGroupMember -Identity $Group -Members ($Users | Where-Object $Group -ne 'X' | Select-Object -ExpandProperty $Header[0]) -Confirm:$false
}