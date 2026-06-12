<#
.SYNOPSIS
    PowerShell Script To Assign Service Plan Licenses To Office 365 Users From a CSV File (o365).

.DESCRIPTION
    PowerShell Script To Assign Service Plan Licenses To Office 365 Users From a CSV File
    (o365).

.PARAMETER AccountSkuId
    Change this to match your 'AccountSkuId'.

.PARAMETER UsageLocation
    Change this to match your usage location (Country Code).

.PARAMETER Users
    Change this path to the CSV file location.

.EXAMPLE
    PS C:\> .\AssignMSOnlineUserPlanLicenses.ps1
    Edit the variables section and run to powerShell Script To Assign Service Plan Licenses To Office 365 Users From a CSV File (o365).

.NOTES
    Requires:   MSOnline, MSOnlineExtended
#>

Import-Module MSOnline
Import-Module MSOnlineExtended
# launches the prompt for your 'onmicrosoft.com' account credentials
$cred=Get-Credential
Connect-MsolService -Credential $cred

## Get the AccountSkuId and license options associated with the tenant Enterprise Plan
Get-MsolAccountSku | ft AccountSkuId,SkuPartNumber
Get-MsolAccountSku | Where-Object {$_.SkuPartNumber -eq 'ENTERPRISEPACK'} | ForEach-Object {$_.ServiceStatus}

## Set the license options required. Any license options not required should be set under '-DisabledPlans'
$MSOnlineLicenses = New-MsolLicenseOptions -AccountSkuId tgf:ENTERPRISEPACK -DisabledPlans YAMMER_ENTERPRISE,RMS_S_ENTERPRISE,MCOSTANDARD,SHAREPOINTWAC,SHAREPOINTENTERPRISE,EXCHANGE_S_ENTERPRISE

## Now set the license plans against the user
#Set-MsolUser -UserPrincipalName "Johannes.Hunger@theglobalfund.org" -UsageLocation "CH"
#Set-MsolUserLicense -UserPrincipalName "Johannes.Hunger@theglobalfund.org" -AddLicenses "tgf:ENTERPRISEPACK" -LicenseOptions $MSOnlineLicenses

$AccountSkuId = "tgf:ENTERPRISEPACK" #Change this to match your 'AccountSkuId'
$UsageLocation = "CH" #Change this to match your usage location (Country Code)
$Users = Import-Csv "C:\ss_vnc\TGF_Employees_Test.csv" #Change this path to the CSV file location
$Users | ForEach-Object {
Set-MsolUser -UserPrincipalName $_.UserPrincipalName -UsageLocation $UsageLocation
Set-MsolUserLicense -UserPrincipalName $_.UserPrincipalName -AddLicenses $AccountSkuId -LicenseOptions $MSOnlineLicenses
}