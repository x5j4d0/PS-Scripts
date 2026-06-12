<#
.SYNOPSIS
    PowerShell Script to Get All Groups and Users From a Site Collection and Sub Sites.

.DESCRIPTION
    PowerShell Script to Get All Groups and Users From a Site Collection and Sub Sites.

.EXAMPLE
    PS C:\> .\SP2010GetAllGroupsAndUsers.ps1
    PowerShell Script to Get All Groups and Users From a Site Collection and Sub Sites.
#>

### Start Variables ###
$ReportLocation = "C:\BoxBuild\SPUsersList.txt"
$URL= "https://yourspsite.com"
### End Variables ###

Add-PsSnapin Microsoft.SharePoint.PowerShell

$site = Get-SPSite $URL
 
#Write the Header to "Tab Separated Text File"
 "Site Name `t Group Name `t User Name “| out-file "$ReportLocation"
       
#Iterate through all Webs (All Sub rooms)
      foreach ($web in $site.AllWebs)
      {

#Write the Header to "Tab Separated Text File"
        "$($web.title) `t" | out-file "$ReportLocation" -append

#Get all Groups  
         foreach ($group in $Web.groups)
         {
                "`t $($Group.Name)" | out-file "$ReportLocation" -append
             
                        foreach ($user in $group.users)
                        {
                           #Exclude Built-in User Accounts                            

                                "`t `t $($user.name)" | out-file "$ReportLocation" -append
                        }
         }
     }

write-host "Report Generated at $ReportLocation"