<#
.SYNOPSIS
    PowerShell Script to Query Logon and Logoff Events from Computers in an OU.

.DESCRIPTION
    PowerShell Script to Query Logon and Logoff Events from Computers in an OU.

.EXAMPLE
    PS C:\> .\GetUsersLogonLogoffEvents.ps1
    PowerShell Script to Query Logon and Logoff Events from Computers in an OU.

.NOTES
    Requires:   ActiveDirectory
#>

Import-Module "ActiveDirectory"

## Find all computers in the My Desktops OU
 
$Computers = (Get-ADComputer -SearchBase 'OU=My Desktops,DC=lab,DC=local’ -Filter * | Select-Object Name).Name
 
## Build the Xpath filter to only retrieve event IDs 4647 or 4648
$EventFilterXPath = "(Event[System[EventID='4647']] or Event[System[EventID='4648']])"
 
## Build out all of the calculated properties ahead of time to pull the computer name, the event of "Logon" or "Logoff", the time the event was generated and the account in the message field.  If the ID is 4647, we need to find the first instance of "Account Name:" but if it's 4648 we need to find the second instance.  Regex groupings are ugly but powerful.
 
$SelectOuput = @(
    @{n='ComputerName';e={$_.MachineName}},
    @{n='Event';e={if ($_.Id -eq '4648') { 'Logon' } else { 'LogOff'}}},
    @{n='Time';e={$_.TimeCreated}},
    @{n='Account';e={if ($_.Id -eq '4647') { $i = 1 } else { $i = 3 } [regex]::Matches($_.Message,'Account Name:\s+(.*)\n’).Groups[$i].Value.Trim()}}
)
 
## Query all the computers and output all the information we need
 
foreach ($Computer in $Computers) {
    Get-WinEvent -ComputerName $Computer -LogName Security -FilterXPath $EventFilterXPath | Select-Object $SelectOuput | Format-Table -AutoSize
}