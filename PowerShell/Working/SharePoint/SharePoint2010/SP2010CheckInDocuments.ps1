<#
.SYNOPSIS
    PowerShell Script To Automatically Check In Documents Across A Document Library.

.DESCRIPTION
    PowerShell Script To Automatically Check In Documents Across A Document Library.

.PARAMETER site
    Change this to suit your environment.

.PARAMETER folder
    Change this to suit your environment.

.EXAMPLE
    PS C:\> .\SP2010CheckInDocuments.ps1
    Edit the variables section and run to powerShell Script To Automatically Check In Documents Across A Document Library.

.NOTES
    Resources:  http://blogs.msdn.com/b/paulking/archive/2011/10/14/using-powershell-to-clean-up-sharepoint-document-library-files-with-no-versions.aspx
#>

[system.reflection.assembly]::LoadWithPartialName("Microsoft.Sharepoint") 
$site = New-Object Microsoft.SharePoint.SPSite("http://YourSiteURL.com") #Change this to suit your environment
$root = $site.allwebs[0] 
$folder = $root.GetFolder("Your Document Library") #Change this to suit your environment

#============================================================
# Function Set-CheckInFolderItems is a recursive function that will CheckIn all items in a list recursively 
#============================================================
function Set-CheckInFolderItems([Microsoft.SharePoint.SPFolder]$folder) 
{
    # Create query object
    $query = New-Object Microsoft.SharePoint.SPQuery
    $query.Folder = $folder
 
    # Get SPWeb object
    $web = $folder.ParentWeb
 
    # Get SPList 
    $list = $web.Lists[$folder.ParentListId]

    # Get a collection of items in the specified $folder
    $itemCollection = $list.GetItems($query)

    # If the folder is the root of the list, display information
    if ($folder.ParentListID -ne $folder.ParentFolder.ParentListID) 
    {
        Write-Host("Recursively checking in all files in " + $folder.Name)
    }

    # Iterate through each item in the $folder - Note sub folders and list items are both considered items
    foreach ($item in $itemCollection) 
    {
        # If the item is a folder
        if ($item.Folder -ne $null) 
        {
            # Write the Subfolder information 
            Write-Host("Folder: " + $item.Name + " Parent Folder: " + $folder.Name) 
 
            # Call the Get-Items function recursively for the found sub-solder
            Set-CheckInFolderItems $item.Folder 
        }
 
        # If the item is not a folder
        if ($item.Folder -eq $null) 
        {
            if ($item.File.CheckOutType -ne "None")
            {
                if ($item.File.Versions.Count -eq 0) #This is set to check for any files that currently have a Version Count of 0
                {
                    # Check in the file
                    Write-Host "Check in File: "$item.Name" Version count " $item.File.Versions.Count -foregroundcolor Green
                    $item.File.CheckIn("Checked in By Administrator")
                }
            }
        }
    }

    $web.dispose()
    $web = $null
}


Set-CheckInFolderItems $folder