<#
.SYNOPSIS
    PowerShell Script To Export All WSP Solutions From The Farm Solution Store.

.DESCRIPTION
    PowerShell Script To Export All WSP Solutions From The Farm Solution Store.

.EXAMPLE
    PS C:\> .\SP2010ExportAllSolutionsFromSolutionStore.ps1
    PowerShell Script To Export All WSP Solutions From The Farm Solution Store.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
#>

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue

foreach($solution in Get-SPSolution)
{
    try
        {
        $filename = $solution.Name;
        $solution.SolutionFile.SaveAs("C:\BoxBuild\Solutions\$filename") #Change this path to suit your environment
        }
    catch
        {
        Write-Host "-error:$_"-foreground red
        }
}
