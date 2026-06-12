<#
.SYNOPSIS
    Import List Items from a CSV File via CSOM (SPOnline).

.DESCRIPTION
    Import List Items from a CSV File via CSOM (SPOnline).

.PARAMETER csv
    Change the path to the CSV file to match your environment.

.PARAMETER siteUrl
    Change this site URL to match your environment.

.PARAMETER listName
    Change this list name to match your environment.

.PARAMETER userName
    Change this to match your o365 tenant user name.

.EXAMPLE
    PS C:\> .\SPOnlineUpdateListItemsFromCSV.ps1
    Edit the variables section and run to import List Items from a CSV File via CSOM (SPOnline).

.NOTES
    Resources:  http://sharepoint-community.net/profiles/blogs/powershell-import-list-items-from-csv-client-object-model
#>

# Load the SharePoint CSOM binaries
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client")
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client.Runtime")

$csv = Import-CSV data.csv #Change the path to the CSV file to match your environment

$siteUrl = "https://yoursite.sharepoint.com" #Change this site URL to match your environment

$listName = "YourList" #Change this list name to match your environment

$userName  = "user.name@yourtenant.onmicrosoft.com" #Change this to match your o365 tenant user name
 
$password = Read-Host -Prompt "Enter password" -AsSecureString

$ctx = New-Object Microsoft.SharePoint.Client.ClientContext($siteUrl)

$credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($userName, $password)

$context = New-Object Microsoft.SharePoint.Client.ClientContext($siteUrl)

$context.Credentials = $credentials

[Microsoft.SharePoint.Client.Web]$web = $context.Web

[Microsoft.SharePoint.Client.List]$list = $web.Lists.GetByTitle($listName)

$query = [Microsoft.SharePoint.Client.CamlQuery]::CreateAllItemsQuery(10000, 'Title')

$items = $list.GetItems( $query )

$context.load($items)

$context.ExecuteQuery();

$count = $items.Count - 1

write-host "$count items found. Deleting."

$deleteGroup = 0

for($intIndex = $count; $intIndex -gt -1; $intIndex--)

{

        $items[$intIndex].DeleteObject();

        write-host "`r".padleft(40," ") -nonewline

        write-host "Remaining items $intIndex" -nonewline

        $deleteGroup++

        if($deleteGroup -eq 20)

        {

            $context.ExecuteQuery();

            $deleteGroup = 0;

        }

}

$intIndex = 0;

$addGroup = 0;

write-host "`nImporting data..."

foreach ($row in $csv) {

    [Microsoft.SharePoint.Client.ListItemCreationInformation]$itemCreateInfo = New-Object Microsoft.SharePoint.Client.ListItemCreationInformation;

    [Microsoft.SharePoint.Client.ListItem]$item = $list.AddItem($itemCreateInfo);

    $item["Title"] = $row.Title;
    
    ############################

    # Add additional columns mappings here 
    
    # Important: For the SharePoint Online List Item columns you will need to provide the 'internal' StaticName property that can be determined from the Object Model (http://spcb.codeplex.com)
	
	$item["Test_x0020_Name"] = $row."Test Name".ToString();
	$item["Test_x0020_Content"] = $row."Test Content".ToString();

    ############################

    $item.Update();

    $addGroup++

    if($addGroup -eq 20)

    {

        $context.ExecuteQuery();

        $addGroup = 0;

    }

    write-host "`r".padleft(40," ") -nonewline

    write-host "Count : $intIndex" -nonewline

    $intIndex++

}

Write-Host "Import completed"
