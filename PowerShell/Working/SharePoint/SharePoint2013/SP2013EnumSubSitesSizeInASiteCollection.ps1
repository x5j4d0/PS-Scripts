<#
.SYNOPSIS
    PowerShell Script to Enumerate the Sub Sites (Webs) Size in a Site Collection.

.DESCRIPTION
    PowerShell Script to Enumerate the Sub Sites (Webs) Size in a Site Collection.

.PARAMETER SiteURL
    Provide the site collection URL here.

.EXAMPLE
    PS C:\> .\SP2013EnumSubSitesSizeInASiteCollection.ps1
    Edit the variables section and run to powerShell Script to Enumerate the Sub Sites (Webs) Size in a Site Collection.
#>

#Get Size of all Sub-sites in a Site Collection
[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint")
 
# Function to calculate folder size
Function CalculateFolderSize($Folder)
{
    [long]$FolderSize = 0
  
    foreach ($File in $Folder.Files)
    {
   #Get File Size
        $FolderSize += $file.TotalLength;
    
  #Get the Versions Size
        foreach ($FileVersion in $File.Versions)
        {
            $FolderSize += $FileVersion.Size
        }
    }
 #Iterate through all subfolders
    foreach ($SubFolder in $Folder.SubFolders)
    {
  #Call the function recursively
        $FolderSize += CalculateFolderSize $SubFolder
    }
    return $FolderSize
}
 
  
$SiteURL = "http://YourSiteURL.com" #Provide the site collection URL here
$Site = new-object Microsoft.SharePoint.SPSite($SiteURL)
  
  foreach($Web in $Site.AllWebs)
  {
    #Call function to calculate Folder Size
    [long]$WebSize = CalculateFolderSize($Web.RootFolder)
    
    #Get Recycle Bin Size
    foreach($RecycleBinItem in $Web.RecycleBin)
        {
           $WebSize += $RecycleBinItem.Size
        }
  
        $Size = [Math]::Round($WebSize/1MB, 2)
        Write-Host  $web.Url ":`t" $Size "MB"
 
    #Dispose the object
    $web.dispose()
   }
