<#
.SYNOPSIS
    PowerShell Script To Loop Through All Users In All Site Collections And Updates Their User Names.

.DESCRIPTION
    PowerShell Script To Loop Through All Users In All Site Collections And Updates Their
    User Names.

.PARAMETER log
    Change this to suit your environment.

.PARAMETER webapp
    Change this to suit your environment.

.EXAMPLE
    PS C:\> .\SP2010UpdateUserDisplayNames.ps1
    Edit the variables section and run to powerShell Script To Loop Through All Users In All Site Collections And Updates Their User Names.

.NOTES
    Requires:   Microsoft.SharePoint.Powershell
#>

# Loading Microsoft.SharePoint.PowerShell
$snapin = Get-PSSnapin | Where-Object {$_.Name -eq 'Microsoft.SharePoint.Powershell'}
if ($snapin -eq $null) {  
  Add-PSSnapin "Microsoft.SharePoint.Powershell"
}

# Loading Needed Assemblies
[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint") | out-null
[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.Office.Server") | out-null
[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.Office.Server.UserProfiles") | out-null


<# --------------------------------
  These values can be changed
-------------------------------- #>
# -- Format of the date for the log file
# --
$date = Get-Date -uformat "%d_%m_%Y_%H_%M"

# -- Name of the log file
# -- Create Folder if not exists
$log = "C:\BoxBuild\Scripts\PowerShell\SP2010UpdateUserDisplayNames_$date.log" #Change this to suit your environment

# -- Url of the web application
# --
$webapp = Get-SPWebApplication "http://YourSharepointApp/" #Change this to suit your environment

# -----------END CHANGE-----------
  
  
# Logging!! 
Start-Transcript -path $log 

# Write Starting Date
$processDate = Get-Date
Write-Host "Starting Profile Info Update:" $processDate

# Create the stopwatch
[System.Diagnostics.Stopwatch] $sw;
$sw = New-Object System.Diagnostics.StopWatch
$sw.Start()

<# --------------------------------
  GET ProfilService
-------------------------------- #>
$upm = New-Object Microsoft.Office.Server.UserProfiles.UserProfileManager( [Microsoft.Office.Server.ServerContext]::Default )
if ($upm -eq $null){
  Write-Host "Could not find User Profile Manager!"
  exit
}

<# --------------------------------
  Looping through all sites 
  to check if stored user info 
  has changed.
-------------------------------- #>
try {  
  foreach($site in $webapp.Sites) {
    $web = $site.RootWeb
    $siteCollUsers = $web.SiteUsers
    
    Write-Host "> SiteCollection: " $site.Url
    
    foreach( $user in $siteCollUsers ) {  
      $login = $user.LoginName                    
      $dispname = $user.Name
      
      if ($upm.UserExists($login)){
        $profile = $upm.GetUserProfile($login);
        $profilename = $profile["PreferredName"].ToString();
        if ($dispname -ne $profilename){
          Write-Host "  >> Changing '" $dispname "' >> '" $profilename "'"
          $user.Name = $profilename
          $user.Update()
        }          
      }
      
    }
    $web.Dispose()
    $site.Dispose()
  }
}
catch [System.Exception] {
  $_.Exception.ToString();
  Write-Host "Error while updating user info tables."
  Stop-Transcript
  exit
} 
  
$sw.Stop()
Write-Host "Time Elapsed: " $sw.Elapsed.ToString()
Write-Host "User Display Names successfully updated !"
Stop-Transcript