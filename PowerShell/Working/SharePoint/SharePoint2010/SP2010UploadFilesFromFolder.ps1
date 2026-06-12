<#
.SYNOPSIS
    PowerShell Function To Upload Documents From A File Location To A SharePoint Library.

.DESCRIPTION
    PowerShell Function To Upload Documents From A File Location To A SharePoint Library.

.PARAMETER Files
    You can filter files by: -filter “*.pdf”.

.EXAMPLE
    PS C:\> .\SP2010UploadFilesFromFolder.ps1
    Edit the variables section and run to powerShell Function To Upload Documents From A File Location To A SharePoint Library.
#>

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint") > $null
  
 
#Function to Upload File
function UploadAllFilesFromDir($WebURL, $DocLibName, $FolderPath)
{
 
#Get the Web & Lists to upload the file
 $site = New-Object Microsoft.SharePoint.SPSite($WebURL)
 $web= $site.OpenWeb()
       
 
#Get the Target Document Library to upload
$List = $Web.GetFolder($DocLibName)
  
#Get the Files from Local Folder
$Files = Get-ChildItem $FolderPath #You can filter files by: -filter “*.pdf” 
 
#upload the files
foreach ($File in $Files)
{
    #Get the Contents of the file to FileStream 
    $stream = (Get-Item $file.FullName).OpenRead()
     
    # Set Metadata Hashtable For the file - OPTIONAL
    $Metadata = @{"Country" = "United States"; "Domain" = "Sales"}
     
    #upload the file              
    $uploaded = $List.Files.Add($File.Name, $stream,$Metadata, $TRUE)
     
    #dispose FileStream Object
    $stream.Dispose()
}
  
#Dispose the site object
$site.Dispose()
}

