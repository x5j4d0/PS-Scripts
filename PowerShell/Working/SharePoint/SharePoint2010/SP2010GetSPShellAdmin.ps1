<#
.SYNOPSIS
    PowerShell Script to list all accounts granted the SPShell Admin Role (SPShellAdmin) in the Farm.

.DESCRIPTION
    PowerShell Script to list all accounts granted the SPShell Admin Role (SPShellAdmin) in
    the Farm.

.EXAMPLE
    PS C:\> .\SP2010GetSPShellAdmin.ps1
    PowerShell Script to list all accounts granted the SPShell Admin Role (SPShellAdmin) in the Farm.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
    Resources:  http://geekswithblogs.net/bjackett/archive/2011/01/04/sharepoint-2010-powershell-script-to-find-all-spshelladmins-with-database.aspx
#>

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue

# declare an array to store results
$results = @()
 
# fetch databases (only configuration and content DBs are needed)
$databasesToQuery = Get-SPDatabase |
    Where-Object {$_.Type -eq 'Configuration Database' -or $_.Type -eq 'Content Database'} |
    Sort-Object –Property Name
 
# for each database get spshelladmins and add db name and username to result
$databasesToQuery |
    ForEach-Object {$dbName = $_.Name;
                    Get-SPShellAdmin -database $_.id |
                        Sort-Object $_.username |
                        ForEach-Object {$results += @{$dbName=$($_.username)}}}
 
# sort results by db name and pipe to table with auto sizing of col width
$results.GetEnumerator() | ft -AutoSize