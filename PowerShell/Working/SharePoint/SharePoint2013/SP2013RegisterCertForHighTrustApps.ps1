<#
.SYNOPSIS
    PowerShell Script To Register Certificates For High Trust Provider Hosted Apps On A SharePoint Farm.

.DESCRIPTION
    PowerShell Script To Register Certificates For High Trust Provider Hosted Apps On A
    SharePoint Farm.

.PARAMETER publicCertPath
    Change this path to match your environment. CER certificate type should be 'Base-64 encoded X.509'.

.PARAMETER issuerId
    IssuerId GUID requires lower case alpha characters.

.PARAMETER spurl
    Change this Web Application URL to match your environment.

.EXAMPLE
    PS C:\> .\SP2013RegisterCertForHighTrustApps.ps1
    Edit the variables section and run to powerShell Script To Register Certificates For High Trust Provider Hosted Apps On A SharePoint Farm.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
    Resources:  http://technet.microsoft.com/en-us/library/ff607642.aspx; http://technet.microsoft.com/en-us/library/ff607623.aspx
#>

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue

$publicCertPath = "C:\BoxBuild\Certs\spproviderhostedapps.YourDomain.com.cer" #Change this path to match your environment. CER certificate type should be 'Base-64 encoded X.509'

#$issuerId = [System.Guid]::NewGuid().ToString()
$issuerId = ([Guid]"8390d39c-117f-44da-8dd6-a11efca05516").ToString() #IssuerId GUID requires lower case alpha characters

$spurl ="http://intranet.YourDomain.com" #Change this Web Application URL to match your environment

$spweb = Get-SPWeb $spurl

$sc = Get-SPServiceContext $spweb.site

$realm = Get-SPAuthenticationRealm -ServiceContext $sc
$realm

$certificate = Get-PfxCertificate $publicCertPath

$fullIssuerIdentifier = $issuerId + '@' + $realm

New-SPTrustedSecurityTokenIssuer -Name $issuerId -Certificate $certificate -RegisteredIssuerName $fullIssuerIdentifier IsTrustBroker

iisreset

write-host "Full Issuer ID: " -nonewline
write-host $fullIssuerIdentifier -ForegroundColor Red
write-host "Issuer ID for web.config: " -nonewline
write-host $issuerId -ForegroundColor Red

#Enable / Disable OAuth HTTP Authentication Depending on your environment

$serviceConfig = Get-SPSecurityTokenServiceConfig
$serviceConfig.AllowOAuthOverHttp = $true #Change this value to '$false' if you don't want to allow OAuth over HTTP - Good idea for Production environments
$serviceConfig.Update()

New-SPTrustedRootAuthority -Name "$($certificate.Subject)_$($certificate.Thumbprint)" -Certificate $certificate