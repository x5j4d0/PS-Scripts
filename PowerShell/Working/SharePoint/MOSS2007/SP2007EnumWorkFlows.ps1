<#
.SYNOPSIS
    PowerShell Script to Enumerate All Workflows in a SharePoint Farm.

.DESCRIPTION
    PowerShell Script to Enumerate All Workflows in a SharePoint Farm.

.EXAMPLE
    PS C:\> .\SP2007EnumWorkFlows.ps1
    PowerShell Script to Enumerate All Workflows in a SharePoint Farm.

.NOTES
    Resources:  http://www.jeffholliday.com/2012/05/powershell-script-identify-all.html
#>

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint") > $null 
$outputFile = Read-Host "Location and Filename (e.g. C:\output.txt)"

$farm = [Microsoft.SharePoint.Administration.SPFarm]::local
$websvcs = $farm.Services | where -FilterScript {$_.GetType() -eq [Microsoft.SharePoint.Administration.SPWebService]} 
$webapps = @() 

$outputHeader = "Url;List;Workflow;Running Instances" > $outputFile

foreach ($websvc in $websvcs) { 

    foreach ($webapp in $websvc.WebApplications) { 
		foreach ($site in $webapp.Sites) {
			foreach ($web in $site.AllWebs) {
				foreach ($List in $web.Lists) {
					foreach ($workflow in $List.WorkflowAssociations) {
						$output = $web.Url + ";" + $List.Title + ";" + $workflow.Name + ";" + $workflow.RunningInstances
						Write-Output $output >> $outputFile
				}}
				} 
			} 
		}
	}
$Web.Dispose();
$site.Dispose();

