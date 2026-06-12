<#
.SYNOPSIS
    PowerShell Script To Toggle The Developer Dashboard On All Web Apps In A Farm.

.DESCRIPTION
    PowerShell Script To Toggle The Developer Dashboard On All Web Apps In A Farm.

.EXAMPLE
    PS C:\> .\SP2010EnableDeveloperDashboard.ps1
    PowerShell Script To Toggle The Developer Dashboard On All Web Apps In A Farm.

.NOTES
    Requires:   Microsoft.SharePoint.Powershell
#>

Add-PSSnapin "Microsoft.SharePoint.Powershell" -ErrorAction SilentlyContinue

$DevDashboardSettings = [Microsoft.SharePoint.Administration.SPWebService]::ContentService.DeveloperDashboardSettings;
$DevDashboardSettings.DisplayLevel = 'OnDemand'; #Change this value to either: 'OnDemand'; 'On'; 'Off'
$DevDashboardSettings.RequiredPermissions = 'EmptyMask';
$DevDashboardSettings.TraceEnabled = $true;
$DevDashboardsettings.Update()