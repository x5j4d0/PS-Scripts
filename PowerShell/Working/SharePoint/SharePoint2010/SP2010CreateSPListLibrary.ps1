<#
.SYNOPSIS
    PowerShell Function to Create List Libraries from the SPList Template Types.

.DESCRIPTION
    PowerShell Function to Create List Libraries from the SPList Template Types.

.PARAMETER Web
    Web.

.PARAMETER ListName
    List Name.

.PARAMETER Description
    Description.

.EXAMPLE
    PS C:\> .\SP2010CreateSPListLibrary.ps1
    PowerShell Function to Create List Libraries from the SPList Template Types.

.NOTES
    Requires:   Microsoft.SharePoint.Powershell
    Resources:  https://msdn.microsoft.com/en-us/library/microsoft.sharepoint.splisttemplatetype.aspx; http://www.sharepointdiary.com/2013/04/create-form-library-in-sharepoint-using-powershell.html
#>

Add-PSSnapin "Microsoft.SharePoint.Powershell" -ErrorAction SilentlyContinue
 
Function Create-ListLibrary
{
 Param
 ( 
  [Microsoft.SharePoint.SPWeb]$Web,
  [String] $ListName,
  [String] $Description
 )
 #Get the List Library template
 $ListTemplate = [Microsoft.Sharepoint.SPListTemplateType]::XMLForm #Change the 'SPListTemplateType' here if you want to provision another type of list template
  
 #Check if the list already exists
 if( ($web.Lists.TryGetList($ListName)) -eq $null)
 {
  #Create the list
     $Web.Lists.Add($ListName,$Description,$ListTemplate) 
   
  #You can Set Properties of Library such as OnQuickLaunch, etc
  $ListLib = $Web.Lists[$ListName] 
  $ListLib.OnQuickLaunch = $true
  $ListLib.Update()
   
  Write-Host "'$ListName' library created successfully!"
 }
 else
 {
  Write-Host "'$ListName' library already exists!"
 }
 #Dispose web object
    $Web.Dispose()    
}
 
#Get the Web
$web = Get-SPWeb "https://yoursharepointwebsite" #Change this path to match your SharePoint web site
 
#Example Call the function to create the library
Create-ListLibrary $web "YourListName" "Your List Description"
