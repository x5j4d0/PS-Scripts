<#
.SYNOPSIS
    PowerShell Script to Disable the Creation of Office 365 Groups in Outlook Web Access.

.DESCRIPTION
    PowerShell Script to Disable the Creation of Office 365 Groups in Outlook Web Access.

.PARAMETER OwaMailboxPolicyName
    Change this Policy to match your tenant if required.

.EXAMPLE
    PS C:\> .\ExchangeOnlineDisableOffice365GroupCreation.ps1
    Edit the variables section and run to powerShell Script to Disable the Creation of Office 365 Groups in Outlook Web Access.

.NOTES
    Resources:  https://support.office.com/en-us/article/Use-PowerShell-to-manage-Office-365-Groups-Admin-help-aeb669aa-1770-4537-9de2-a82ac11b0540?ui=en-US&rs=en-US&ad=US; https://technet.microsoft.com/en-us/library/dd351097(v=exchg.150).aspx
#>

$OwaMailboxPolicyName = "OwaMailboxPolicy-Default" #Change this Policy to match your tenant if required

#$LiveCred = Get-Credential

$ExchangeCredential= Get-Credential

$Session=New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $LiveCred -Authentication Basic –AllowRedirection

Import-PSSession $Session

## Get the current 'GroupCreationEnabled' property for the Outlook Web App mailbox policy
Get-OwaMailboxPolicy -Identity $OwaMailboxPolicyName | Select GroupCreationEnabled 

## Set the current 'GroupCreationEnabled' property for the Outlook Web App mailbox policy to 'False'
Set-OwaMailboxPolicy -Identity $OwaMailboxPolicyName -GroupCreationEnabled $false #Change this property to '$true' if you ever want to Re-enable this  

## Check the current 'GroupCreationEnabled' property for the Outlook Web App mailbox policy
Get-OwaMailboxPolicy -Identity $OwaMailboxPolicyName | Select GroupCreationEnabled 