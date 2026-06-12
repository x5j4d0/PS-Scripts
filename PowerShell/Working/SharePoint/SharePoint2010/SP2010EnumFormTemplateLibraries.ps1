<#
.SYNOPSIS
    PowerShell Script To List All InfoPath Form Template Libraries In A Web Application.

.DESCRIPTION
    PowerShell Script To List All InfoPath Form Template Libraries In A Web Application.

.PARAMETER WebAppURL
    Edit this URL to suit your environment.

.PARAMETER ReportPath
    Edit this path to suit your environment.

.EXAMPLE
    PS C:\> .\SP2010EnumFormTemplateLibraries.ps1
    Edit the variables section and run to powerShell Script To List All InfoPath Form Template Libraries In A Web Application.
#>

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint") > $null
 
function global:Get-SPSite($url){
    return new-Object Microsoft.SharePoint.SPSite($url)
}
 
#Get the web application
$WebAppURL= "http://YourWebApp.com" #Edit this URL to suit your environment
$ReportPath = "C:\YourPath\InfoPath_Templates_Report.csv" #Edit this path to suit your environment
$SiteColletion = Get-SPSite($WebAppURL)
$WebApp = $SiteColletion.WebApplication
 
#Write the CSV header
"Site Collection `t Site `t List Name `t List Url `t Docs Count `t Last Modified `t Work Flow Count `t Live Work Flow `t Live Work Flow Names `t Form Template Path" > "$ReportPath"
 
#Loop through all site collections of the web app
    foreach ($site in $WebApp.Sites)
    {
       # get the collection of webs
       foreach($web in $site.AllWebs)
        {
            write-host "Scaning Site" $web.title "@" $web.URL
               foreach($list in $web.lists)
               {
                   if( $list.BaseType -eq "DocumentLibrary" -and $list.BaseTemplate -eq "XMLForm")
       {
                $listModDate = $list.LastItemModifiedDate.ToShortDateString()
                $listTemplate = $list.ServerRelativeDocumentTemplateUrl
                $listWorkflowCount = $list.WorkflowAssociations.Count
                $listLiveWorkflowCount = 0
                $listLiveWorkflows = ""
        
                foreach ($wf in $list.WorkflowAssociations)
        {
                    if ($wf.Enabled)
         {
                        $listLiveWorkflowCount++
                        if ($listLiveWorkflows.Length -gt 0)
         {
                            $listLiveWorkflows = "$listLiveWorkflows, $($wf.Name)"
                        }
                        else
         {
                            $listLiveWorkflows = $wf.Name
                        }
                     }
                 }
       #Write data to CSV File
                   $site.RootWeb.Title +"`t" + $web.Title +"`t" + $list.title +"`t" + $Web.Url + "/" + $List.RootFolder.Url  +"`t" + $list.ItemCount +"`t" + $listModDate +"`t" + $listWorkflowCount +"`t" + $listLiveWorkflowCount +"`t" + $listLiveWorkflows +"`t" + $listTemplate >> "$ReportPath"
             }
               }
        }
    }
 
#Dispose of the site object
$siteColletion.Dispose()
Write-host  "Report Generated in the $ReportPath folder" -foregroundcolor green