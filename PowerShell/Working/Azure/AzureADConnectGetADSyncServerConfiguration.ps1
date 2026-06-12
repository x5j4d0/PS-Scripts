<#
.SYNOPSIS
    Script to Get the Azure Active Directory Synchronization Client Configuration XML Files (Azure AD Connect / AAD Connect).

.DESCRIPTION
    Script to Get the Azure Active Directory Synchronization Client Configuration XML Files
    (Azure AD Connect / AAD Connect).

.PARAMETER ConfigurationPath
    Change this path to match your environment.

.EXAMPLE
    PS C:\> .\AzureADConnectGetADSyncServerConfiguration.ps1
    Edit the variables section and run to script to Get the Azure Active Directory Synchronization Client Configuration XML Files (Azure AD Connect / AAD Connect).

.NOTES
    Requires:   ADSync
#>

$ConfigurationPath = "C:\BoxBuild\AzureADConnectSyncDocumenter\Data\MachineName" #Change this path to match your environment

Import-Module ADSync

Get-ADSyncServerConfiguration -Path "$ConfigurationPath"

Get-ChildItem $ConfigurationPath