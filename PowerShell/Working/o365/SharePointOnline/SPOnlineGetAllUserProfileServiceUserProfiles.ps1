<#
.SYNOPSIS
    PowerShell Script to Export User Profile Service Profiles Data From a Tenant via CSOM (SPOnline).

.DESCRIPTION
    PowerShell Script to Export User Profile Service Profiles Data From a Tenant via CSOM
    (SPOnline).

.EXAMPLE
    PS C:\> .\SPOnlineGetAllUserProfileServiceUserProfiles.ps1
    PowerShell Script to Export User Profile Service Profiles Data From a Tenant via CSOM (SPOnline).

.NOTES
    Resources:  http://social.technet.microsoft.com/wiki/contents/articles/29415.export-sharepoint-online-user-profile-information-using-powershell-csom.aspx
#>

#Adding the CSOM Assemblies
Add-Type -Path "C:\ztemp\SPDLLs\Microsoft.SharePoint.Client.dll" #Change this path to match your environment
Add-Type -Path "C:\ztemp\SPDLLs\Microsoft.SharePoint.Client.Runtime.dll"  #Change this path to match your environment
Add-Type -Path 'C:\ztemp\SPDLLs\Microsoft.SharePoint.Client.UserProfiles.dll' #Change this path to match your environment

#Mysite URL
$site = 'https://TenantName-my.sharepoint.com/'

#Admin User Principal Name
$admin = 'User.Name@TenantName.onmicrosoft.com'

#Get Password as secure String
$password = Read-Host 'Enter Password' -AsSecureString

#Get the Client Context and Bind the Site Collection
$context = New-Object Microsoft.SharePoint.Client.ClientContext($site)

#Authenticate
$credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($admin , $password)
$context.Credentials = $credentials

#Fetch the users in Site Collection
$users = $context.Web.SiteUsers
$context.Load($users)
$context.ExecuteQuery()

#Create an Object [People Manager] to retrieve profile information
$people = New-Object Microsoft.SharePoint.Client.UserProfiles.PeopleManager($context)
$collection = @()
Foreach($user in $users)
{
    $userprofile = $people.GetPropertiesFor($user.LoginName)
    $context.Load($userprofile)
    $context.ExecuteQuery()
    if($userprofile.Email -ne $null)
    {
        $upp = $userprofile.UserProfileProperties
        foreach($ups in $upp)
        {
            #Add required User Information fields.
            $profileData = "" | Select "AccountName", "FirstName" , "LastName" , "Department", "WorkEmail" , "Title" , "Responsibility"
            $profileData.AccountName = $ups.AccountName
            $profileData.FirstName = $ups.FirstName
            $profileData.LastName = $ups.LastName
            $profileData.Department = $ups.Department
            $profileData.WorkEmail = $ups.WorkEmail
            $profileData.Responsibility = $ups.'SPS-Responsibility'
            $collection += $profileData
        }
    }
}
$collection | Export-Csv 'C:\ztemp\SPDLLs\SPOnlineUserProfileInformation.csv' -NoTypeInformation -Encoding UTF8 #Change the 'Export-Csv' path to match your environment