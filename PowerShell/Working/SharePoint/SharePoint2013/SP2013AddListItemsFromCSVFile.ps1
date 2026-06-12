<#
.SYNOPSIS
    PowerShell Script To Add Items To A List Library From A CSV File.

.DESCRIPTION
    PowerShell Script To Add Items To A List Library From A CSV File.

.PARAMETER FilePath
    Change this path to suit your environment.

.PARAMETER docliburl
    Change this URL to suit your environment (full path to the list library).

.EXAMPLE
    PS C:\> .\SP2013AddListItemsFromCSVFile.ps1
    Edit the variables section and run to powerShell Script To Add Items To A List Library From A CSV File.
#>

$FilePath = "YourCSVFile.csv" #Change this path to suit your environment
$docliburl="http://YourWebAppURL/TestContacts"; #Change this URL to suit your environment (full path to the list library)

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint") > $null;

$site=new-object Microsoft.SharePoint.SPSite($docliburl);
$web=$site.openweb();
$list=$web.GetList($docliburl);
$csv_file = Import-Csv $FilePath;
foreach ($line in $csv_file) 
{ 
Write-Output $line.Title;
  $item = $list.Items.Add();
  $item["FirstName"] = $line.FirstName;
  $item["LastName"] = $line.LastName;
  $item["Phone"] = $line.Phone;
  $item["Address"] = $line.Address;
  $item.Update();
}