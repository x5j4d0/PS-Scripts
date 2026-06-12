<#
.SYNOPSIS
    PowerShell Script To Report On Sizes Of All Sites And Their Content Databases With OutPut To A CSV File.

.DESCRIPTION
    PowerShell Script To Report On Sizes Of All Sites And Their Content Databases With OutPut
    To A CSV File.

.PARAMETER FilePath
    Change this file path to match your environment.

.EXAMPLE
    PS C:\> .\SP2013EnumSiteCollectionSizes.ps1
    Edit the variables section and run to powerShell Script To Report On Sizes Of All Sites And Their Content Databases With OutPut To A CSV File.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
    Resources:  http://www.khamis.net/Blog/Post/327/Output-a-list-of-SharePoint-content-databases,-site-collections-within-them-and-their-size-via-PowerShell
#>

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue 

$FilePath = "C:\BoxBuild\Scripts\SPContentDatabases.csv" #Change this file path to match your environment

$all="Content Database,Site URL,Size`r`n";Get-SPContentDatabase | %{foreach($site in $_.Sites){$url=$site.url;$size=[System.Math]::Round([int64]$site.Usage.Storage/1MB,2); $output="$($_.Name),$($url),$($size)MB`r`n";$all+=$output}}; $all | out-file $FilePath -force  -Encoding default