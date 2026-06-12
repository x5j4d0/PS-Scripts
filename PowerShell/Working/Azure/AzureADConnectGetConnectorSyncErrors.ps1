<#
.SYNOPSIS
    PowerShell Script to Export and Analyse the AAD Connect FIM Client Sync Errors.

.DESCRIPTION
    PowerShell Script to Export and Analyse the AAD Connect FIM Client Sync Errors.

.EXAMPLE
    PS C:\> .\AzureADConnectGetConnectorSyncErrors.ps1
    PowerShell Script to Export and Analyse the AAD Connect FIM Client Sync Errors.

.NOTES
    Resources:  http://www.highclouder.com/azure-ad-connect-export-user-error-data; https://technet.microsoft.com/en-us/library/jj590346(v=ws.10).aspx
#>

### Start Variables ###
$ConnectorName = "YourTenant.onmicrosoft.com - AAD"
$ErrorsFile = "C:\BoxBuild\Errors-Export.xml"
$ReportFile = "C:\BoxBuild\Errors-Export.csv"
### End Variables ###

cd  "C:\Program Files\Microsoft Azure AD Sync\bin"

# Export the errors to an XML file
./CSExport.exe $ConnectorName $ErrorsFile /f:e

# Process the errors XML to a CSV file for analysis
./CSExportAnalyzer.exe  $ErrorsFile > $ReportFile
