<#
.SYNOPSIS
    PowerShell Script to create and reconfigure your locations for your Diagnostic and Usage Analysis Logs.

.DESCRIPTION
    PowerShell Script to create and reconfigure your locations for your Diagnostic and Usage
    Analysis Logs.

.PARAMETER DiagnosticLogMaxDiskSpaceUsageEnabled
    Default should be '$True'.

.PARAMETER DiagnosticLogDiskSpaceUsageGB
    Default is 1000 GB.

.PARAMETER DiagnosticLogCutInterval
    Default is 30 minutes.

.PARAMETER UsageAnalysisLogMaxSpaceGB
    Default is 5 GB.

.PARAMETER UsageAnalysisLogCutTime
    Default is 5 minutes.

.EXAMPLE
    PS C:\> .\SP2010SetLoggingDirectories.ps1
    Edit the variables section and run to powerShell Script to create and reconfigure your locations for your Diagnostic and Usage Analysis Logs.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
#>

# Edit the parameters below to suit your environment

$DiagnosticLogsPath = "D:\SharePoint\DiagnosticLogs"
$DiagnosticLogsDays = "3"
$DiagnosticLogMaxDiskSpaceUsageEnabled = $True #Default should be '$True'
$DiagnosticLogDiskSpaceUsageGB = "20" #Default is 1000 GB
$DiagnosticLogCutInterval = "30" #Default is 30 minutes
$UsageAnalysisPath = "D:\SharePoint\UsageAnalysis"
$UsageAnalysisLogMaxSpaceGB = "5" #Default is 5 GB
$UsageAnalysisLogCutTime = "5" #Default is 5 minutes

Add-PSSnapin Microsoft.SharePoint.PowerShell

#Stop your SharePoint Services

net stop SPTraceV4
net stop SPTimerV4

# Tip: Use 'Get-SPDiagnosticConfig' to view additional parameters that can be set

md $DiagnosticLogsPath

Set-SPDiagnosticConfig -LogLocation $DiagnosticLogsPath -DaysToKeepLogs $DiagnosticLogsDays -LogMaxDiskSpaceUsageEnabled:$DiagnosticLogMaxDiskSpaceUsageEnabled -LogDiskSpaceUsageGB $DiagnosticLogDiskSpaceUsageGB -LogCutInterval $DiagnosticLogCutInterval


# Tip: Use 'Get-SPUsageService' to view additional parameters that can be set


md $UsageAnalysisPath

Set-SPUsageService -UsageLogLocation $UsageAnalysisPath -UsageLogMaxSpaceGB $UsageAnalysisLogMaxSpaceGB -UsageLogCutTime $UsageAnalysisLogCutTime


#Start your SharePoint Services

net start SPTraceV4
net start SPTimerV4

Write-Host Diagnostic Logs now at $DiagnosticLogsPath
Write-Host Usage Analysis Logs now at $UsageAnalysisPath

## Important - If using the 'AutoSPInstaller' solution:
# The EnterpriseSearchService Index location should have been set in your 'AutoSPInstallerInput' XML file
# IndexLocation=