<#
.SYNOPSIS
    PowerShell Script To Deploy The SharePoint 2010 STSADM Commands and PowerShell Cmdlets WSP.

.DESCRIPTION
    PowerShell Script To Deploy The SharePoint 2010 STSADM Commands and PowerShell Cmdlets
    WSP.

.PARAMETER SolutionLocation
    Change this path to suit your environment.

.EXAMPLE
    PS C:\> .\SP2010DeploySTSADMExtensionsWithPowerShellCmdlets.ps1
    Edit the variables section and run to powerShell Script To Deploy The SharePoint 2010 STSADM Commands and PowerShell Cmdlets WSP.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
#>

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue

# User-modifiable variables
$SolutionName = "Lapointe.SharePoint2010.Automation.wsp"
$SolutionLocation = "D:\BoxBuild\SharePointSolutions" #Change this path to suit your environment
# Non-modifiable variables
$caWebApp = [Microsoft.SharePoint.Administration.SPAdministrationWebApplication]::Local
$caWebApp.Sites[0].Url

Add-SPSolution -LiteralPath $SolutionLocation\$SolutionName
Write-Host -ForegroundColor Yellow "Added the solution: $SolutionName"
Install-SPSolution -Identity $SolutionName -GACDeployment
Write-Host -ForegroundColor Yellow "Check your solution status at:" ($caWebApp.Sites[0].Url + "/_admin/Solutions.aspx")