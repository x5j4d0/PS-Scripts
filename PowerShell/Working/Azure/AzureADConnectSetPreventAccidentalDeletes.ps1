<#
.SYNOPSIS
    PowerShell Commands to Configure Accidental Deletion Functionality (Prevent Accidental Deletes).

.DESCRIPTION
    PowerShell Commands to Configure Accidental Deletion Functionality (Prevent Accidental
    Deletes).

.EXAMPLE
    PS C:\> .\AzureADConnectSetPreventAccidentalDeletes.ps1
    PowerShell Commands to Configure Accidental Deletion Functionality (Prevent Accidental Deletes).

.NOTES
    Requires:   ADSync
#>

#Import the Azure AD Connect Sync module

Import-Module ADSync

#Disable / Enable ADSync export deletion threshold

Disable-ADSyncExportDeletionThreshold

#Enable-ADSyncExportDeletionThreshold

#Confirm the status of the 'ADSyncExportDeletionThreshold' property

Get-ADSyncExportDeletionThreshold