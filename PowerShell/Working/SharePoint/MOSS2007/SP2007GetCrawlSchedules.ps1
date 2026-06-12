<#
.SYNOPSIS
    PowerShell Script To Get Details On The Crawl Schedules For SSP Or Search Service Applications.

.DESCRIPTION
    PowerShell Script To Get Details On The Crawl Schedules For SSP Or Search Service
    Applications.

.EXAMPLE
    PS C:\> .\SP2007GetCrawlSchedules.ps1
    PowerShell Script To Get Details On The Crawl Schedules For SSP Or Search Service Applications.
#>

function Get-Crawl-Scheduled-Information([string]$SiteCollectionURL) 
{ 
    [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint") > $null 
    [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.Office.Server.Search") > $null 

    $site = new-object Microsoft.SharePoint.SPSite($SiteCollectionURL) 
    Write-Host "SiteCollectionURL", $SiteCollectionURL 
    $context =  [Microsoft.Office.Server.Search.Administration.SearchContext]::GetContext($site) 

    $site.Dispose() 
    $sspcontent = new-object Microsoft.Office.Server.Search.Administration.Content($context) 
    $sspContentSources =  $sspcontent.ContentSources 
    foreach ($cs in $sspContentSources) 
    { 
        Write-Host " ------------------------------------------------------ " 
        Write-Host "NAME: ", $cs.Name, " - ID: ", $cs.Id, " - CrawlStatus: ", $cs.CrawlStatus 
        $myFullCrawlschedule = $cs.FullCrawlSchedule 
        Write-Host "Full Crawl Schedule Description: ", $myFullCrawlschedule.Description 
        $myIncrementalschedule = $cs.IncrementalCrawlSchedule 
        Write-Host "Incremental Crawl Schedule Description: ", $myIncrementalschedule.Description 
    } 
    Write-Host " ------------------------------------------------------ " 
} 

Get-Crawl-Scheduled-Information "http://SSPWebApplicationFullPath" #Replace this with your SSP / Search Application full path