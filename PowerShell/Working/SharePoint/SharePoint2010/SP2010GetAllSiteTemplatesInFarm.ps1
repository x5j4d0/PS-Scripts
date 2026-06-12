<#
.SYNOPSIS
    PowerShell Script To List Details On All Site Templates In A Farm.

.DESCRIPTION
    PowerShell Script To List Details On All Site Templates In A Farm.

.EXAMPLE
    PS C:\> .\SP2010GetAllSiteTemplatesInFarm.ps1
    PowerShell Script To List Details On All Site Templates In A Farm.

.NOTES
    Requires:   Microsoft.Sharepoint.PowerShell
#>

Add-PSSnapin "Microsoft.Sharepoint.PowerShell" -ErrorAction SilentlyContinue

function Get-SPWebTemplateWithId
{
    $templates = Get-SPWebTemplate | Sort-Object "Name"
    $templates | ForEach-Object {
        $templateValues = @{
            "Title" = $_.Title
            "Name" = $_.Name
            "ID" = $_.ID
            "Custom" = $_.Custom
            "LocaleId" = $_.LocaleId
        }
        New-Object PSObject -Property $templateValues | Select @("Name","Title","LocaleId","Custom","ID")
    }
}

# Examples:
Get-SPWebTemplateWithId | Format-Table
Get-SPWebTemplateWithId | Format-Table | Out-File "C:\BoxBuild\Scripts\PowerShell\SP_Site_Templates.txt"