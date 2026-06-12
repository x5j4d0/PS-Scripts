<#
.SYNOPSIS
    PowerShell Function to 'resolve' the Edit vs. Contribute Role Permissions Change.

.DESCRIPTION
    PowerShell Function to 'resolve' the Edit vs. Contribute Role Permissions Change.

.EXAMPLE
    PS C:\> .\SP2013ResolveEditVsContributePermissions.ps1
    PowerShell Function to 'resolve' the Edit vs. Contribute Role Permissions Change.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
    Resources:  http://paulliebrand.com/2014/04/18/sharepoint-2013-edit-vs-contribute-solution; http://test/sites/site
#>

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue
 
function Fix-PLEditContribute {
    param (
    [Parameter(Mandatory=$true, HelpMessage="Please provide SPWebApplication object", ValueFromPipeline=$true)]
    $webApplication)
 
    BEGIN {}
 
    PROCESS {
 
        Write-Verbose "Process $($webApplication.DisplayName)"
 
        $webApplication.Sites | Fix-PLEditContributeSite
 
    }
 
    END {}
 
}
 
function Fix-PLEditContributeSite {
    param (
    [Parameter(Mandatory=$true, ValueFromPipeline=$true,HelpMessage="Please provide an SPSite object")]
    [Microsoft.SharePoint.SPSite] $site
    )
 
    BEGIN {}
 
    PROCESS {
 
        foreach ($web in $site.AllWebs)
        {
            Write-Verbose "`t$($web.Url)"
            try
            {
                if (!$web.HasUniquePerm)
                {
                    Write-Verbose "Web is inheriting permissions, skipping..."
                    continue;
                }
 
                $editRole = $web.RoleDefinitions["Edit"]
                $contributeRole = $web.RoleDefinitions["Contribute"]
 
                $roleAssignments = $web.RoleAssignments | ? {$_.RoleDefinitionBindings -eq $editRole}
 
                foreach ($roleAssignment in $roleAssignments)
                {
                    if ($roleAssignment.RoleDefinitionBindings.Contains($contributeRole))
                    {
                        Write-Verbose "Already contains Contribute, skipping..."
                        continue;
                    }
 
                    $roleAssignment.RoleDefinitionBindings.Add($contributeRole);
                    $roleAssignment.RoleDefinitionBindings.Remove($editRole);
 
                    $roleAssignment.Update()
                }
 
                $web.Update()
            }
            finally
            {
                if ($web)
                {
                    $web.Dispose()
                }
            }
        }
 
        $rootWeb = $site.RootWeb
        $editRole = $web.RoleDefinitions["Edit"]
        if ($editRole)
        {
            Write-Verbose "Removing Edit Permission"
            $rootWeb.RoleDefinitions.Delete("Edit")
        }  
 
        $site.Dispose()
 
    }
 
    END {}
}