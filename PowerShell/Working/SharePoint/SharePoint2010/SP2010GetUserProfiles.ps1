<#
.SYNOPSIS
    PowerShell Script To Extract All User Profile Details From A Web Application.

.DESCRIPTION
    PowerShell Script To Extract All User Profile Details From A Web Application.

.PARAMETER serviceContext
    Change this URL to suit your environment.

.EXAMPLE
    PS C:\> .\SP2010GetUserProfiles.ps1
    Edit the variables section and run to powerShell Script To Extract All User Profile Details From A Web Application.

.NOTES
    Requires:   Microsoft.Sharepoint.PowerShell
    Resources:  http://csefi.blogspot.in/2012/02/sharepoint-2010-user-profile-export-to.html
#>

Add-PSSnapin "Microsoft.Sharepoint.PowerShell" -ErrorAction SilentlyContinue
function AppendValue([string] $propertyName)
{
	if($userProfile[$propertyName] -ne "")
	{
		$sb.AppendFormat("{0};", $userProfile[$propertyName])
	}
	else
	{
		$sb.Append(";")
	}
}
$sb = New-Object System.Text.StringBuilder 
	$sb.AppendLine("UserProfile_GUID;AccountName;FirstName;SPS-PhoneticFirstName;LastName;SPS-PhoneticLastName;PreferredName;SPS-PhoneticDisplayName;WorkPhone;Department;Title;SPS-JobTitle;Manager;AboutMe;PersonalSpace;PictureURL;UserName;QuickLinks;WebSite;PublicSiteRedirect;SPS-DataSource;SPS-MemberOf;SPS-Dotted-line;SPS-Peers;SPS-Responsibility;SPS-SipAddress;SPS-MySiteUpgrade;SPS-DontSuggestList;SPS-ProxyAddresses;SPS-HireDate;SPS-DisplayOrder;SPS-ClaimID;SPS-ClaimProviderID;SPS-ClaimProviderType;SPS-LastColleagueAdded;SPS-OWAUrl;SPS-SavedAccountName;SPS-ResourceAccountName;SPS-ObjectExists;SPS-MasterAccountName;SPS-DistinguishedName;SPS-SourceObjectDN;SPS-LastKeywordAdded;WorkEmail;CellPhone;Fax;HomePhone;Office;SPS-Location;SPS-TimeZone;Assistant;SPS-PastProjects;SPS-Skills;SPS-School;SPS-Birthday;SPS-StatusNotes;SPS-Interests;SPS-EmailOptin;")
$serviceContext = Get-SPServiceContext -Site http://YourWebApplication.com #Change this URL to suit your environment
$profileManager = New-Object Microsoft.Office.Server.UserProfiles.UserProfileManager($serviceContext);
$profiles = $profileManager.GetEnumerator()
foreach($userProfile in $profiles)
{
	AppendValue("UserProfile_GUID")
	AppendValue("AccountName")
	AppendValue("FirstName")
	AppendValue("SPS-PhoneticFirstName")
	AppendValue("LastName")
	AppendValue("SPS-PhoneticLastName")
	AppendValue("PreferredName")
	AppendValue("SPS-PhoneticDisplayName")
	AppendValue("WorkPhone")
	AppendValue("Department")
	AppendValue("Title")
	AppendValue("SPS-JobTitle")
	AppendValue("Manager")
	AppendValue("AboutMe")
	AppendValue("PersonalSpace")
	AppendValue("PictureURL")
	AppendValue("UserName")
	AppendValue("QuickLinks")
	AppendValue("WebSite")
	AppendValue("PublicSiteRedirect")
	AppendValue("SPS-DataSource")
	AppendValue("SPS-MemberOf")
	AppendValue("SPS-Dotted-line")
	AppendValue("SPS-Peers")
	AppendValue("SPS-Responsibility")
	AppendValue("SPS-SipAddress")
	AppendValue("SPS-MySiteUpgrade")
	AppendValue("SPS-DontSuggestList")
	AppendValue("SPS-ProxyAddresses")
	AppendValue("SPS-HireDate")
	AppendValue("SPS-DisplayOrder")
	AppendValue("SPS-ClaimID")
	AppendValue("SPS-ClaimProviderID")
	AppendValue("SPS-ClaimProviderType")
	AppendValue("SPS-LastColleagueAdded")
	AppendValue("SPS-OWAUrl")
	AppendValue("SPS-SavedAccountName")
	AppendValue("SPS-ResourceAccountName")
	AppendValue("SPS-ObjectExists")
	AppendValue("SPS-MasterAccountName")
	AppendValue("SPS-DistinguishedName")
	AppendValue("SPS-SourceObjectDN")
	AppendValue("SPS-LastKeywordAdded")
	AppendValue("WorkEmail")
	AppendValue("CellPhone")
	AppendValue("Fax")
	AppendValue("HomePhone")
	AppendValue("Office")
	AppendValue("SPS-Location")
	AppendValue("SPS-TimeZone")
	AppendValue("Assistant")
	AppendValue("SPS-PastProjects")
	AppendValue("SPS-Skills")
	AppendValue("SPS-School")
	AppendValue("SPS-Birthday")
	AppendValue("SPS-StatusNotes")
	AppendValue("SPS-Interests")
	AppendValue("SPS-EmailOptin")
$sb.AppendLine()
}
Add-Content UserProfileExport.csv $sb #Change the csv file details to suit your environment