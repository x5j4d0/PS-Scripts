<#
.SYNOPSIS
    PowerShell Script to Add a Certificate File (.cer) to the Farm Trust.

.DESCRIPTION
    PowerShell Script to Add a Certificate File (.cer) to the Farm Trust.

.EXAMPLE
    PS C:\> .\SP2013AddCertificateToManageTrust.ps1
    PowerShell Script to Add a Certificate File (.cer) to the Farm Trust.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
#>

### Start Variables ###

$CertPath = "C:\BoxBuild\Certs\WorkflowFarm.cer"
$TrustName = "Workflow Manager Farm"

### End Variables ###

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue

$trustCert = Get-PfxCertificate $CertPath

New-SPTrustedRootAuthority -Name $TrustName -Certificate $trustCert