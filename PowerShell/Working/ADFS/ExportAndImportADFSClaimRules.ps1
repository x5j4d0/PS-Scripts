<#
.SYNOPSIS
    PowerShell Script That Uses The ADFS PowerShell Snapin To Export And Import Relying Party Trust Claim Rules.

.DESCRIPTION
    PowerShell Script That Uses The ADFS PowerShell Snapin To Export And Import Relying Party
    Trust Claim Rules.

.PARAMETER SourceRelyingPartyTrust
    The name of your Source Relying Party Trust.

.PARAMETER TargetRelyingPartyTrust
    The name of your Target Relying Party Trust.

.PARAMETER XMLFilePath
    The file path and name of the Claim Rules XML export.

.EXAMPLE
    PS C:\> .\ExportAndImportADFSClaimRules.ps1
    Edit the variables section and run to powerShell Script That Uses The ADFS PowerShell Snapin To Export And Import Relying Party Trust Claim Rules.

.NOTES
    Requires:   Microsoft.ADFS.PowerShell
#>

Add-PSSnapin "Microsoft.ADFS.PowerShell" -ErrorAction SilentlyContinue

##### BEGIN VARIABLES #####
$SourceRelyingPartyTrust = "ServiceNow Dev Instance" #The name of your Source Relying Party Trust
$TargetRelyingPartyTrust = "ServiceNow Prod Instance" #The name of your Target Relying Party Trust
$XMLFilePath = "C:\BoxBuild\Scripts\PowerShell\RelyingPartyTrustClaimRules.xml" #The file path and name of the Claim Rules XML export
##### END VARIABLES #####

##Export Relying Party Trust Claims
Get-ADFSRelyingPartyTrust -Name $SourceRelyingPartyTrust | Export-Clixml $XMLFilePath

##Import Relying Party Trust Claims
Import-Clixml $XMLFilePath | foreach-object {Set-ADFSRelyingPartyTrust -TargetName $TargetRelyingPartyTrust -IssuanceTransformRules $_.IssuanceTransformRules}