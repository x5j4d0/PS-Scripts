<#
.SYNOPSIS
    Create Job Using SMO.

.DESCRIPTION
    Create Job Using SMO.

.PARAMETER server
    server.

.EXAMPLE
    PS C:\> .\Create-MSSQLJob-UsingSMO.ps1

#>

param
(
  	[string]$server = "(local)",
	[string]$jobname = "PowerShellJob",
	[string]$taskDesc = "Perform some task",
	[string]$category = "[Uncategorized (Local)]",
	[string]$psScript = "C:\TEMP\test.ps1",
	[int]$hrSchedule = 2,
	[int]$minSchedule = 0,
	[switch]$verbose,
	[switch]$debug
)

function main()
{
	if ($verbose) {$VerbosePreference = "Continue"}
	if ($debug) {$DebugPreference = "Continue"}
	Create-MSSQLJob-UsingSMO $server $jobName $taskDesc $category $psScript $hrSchedule $minSchedule
}

function Create-MSSQLJob-UsingSMO($server, $jobName, $taskDesc, $category, `
									$psScript, $hrSched, $minSched)
{
	# TIP: using PowerShell to create an exception handler
   trap [Exception] 
	{
      write-error $("TRAPPED: " + $_.Exception.Message);
      continue;
   }

	# Load SMO assembly
	[void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO')
	
	# Instantiate SMO server object
	# TIP: instantiate object with parameters
	$namedInstance = new-object ('Microsoft.SqlServer.Management.Smo.Server') ($server)
	
	# Instantiate an Agent Job object, set its properties, and create it
	Write-Debug "Create SQL Agent job ..."
	$job = new-object ('Microsoft.SqlServer.Management.Smo.Agent.Job') ($namedInstance.JobServer, $jobName)
	$job.Description = $taskDesc
	$job.Category = $category
	$job.OwnerLoginName = 'sa'
	
	# Create will fail if job already exists
	#  so don't build the job step or schedule
	if (!$job.Create())
	{
		# Create the step to execute the PowerShell script
		#   and specify that we want the command shell with command to execute script, 
		Write-Debug "Create SQL Agent job step..."
		$jobStep = new-object ('Microsoft.SqlServer.Management.Smo.Agent.JobStep') ($job, 'Step 1')
		$jobStep.SubSystem = "CmdExec"
		$runScript = "powershell " + "'" + $psScript + "'"
		$jobStep.Command = $runScript
		$jobStep.OnSuccessAction = "QuitWithSuccess"
		$jobStep.OnFailAction = "QuitWithFailure"
		$jobStep.Create()
		
		# Alter the Job to set the target server and tell it what step should execute first
		Write-Debug "Alter SQL Agent to use designated job step..."
		$job.ApplyToTargetServer($namedInstance.Name)
		$job.StartStepID = $jobStep.ID
		$job.Alter()
	
		# Create start and end timespan objects to use for scheduling
		# TIP: using PowerShell to create a .Net Timespan object
		Write-Debug "Create timespan objects for scheduling the time for 2am..."
		$StartTS = new-object System.Timespan($hrSched, $minSched, 0)
		$EndTS = new-object System.Timespan(23, 59, 59)
		
		# Create a JobSchedule object and set its properties and create the schedule
		Write-Debug "Create SQL Agent Job Schedule..."
		$jobSchedule = new-object ('Microsoft.SqlServer.Management.Smo.Agent.JobSchedule') ($job, 'Sched 01')
		$jobSchedule.FrequencyTypes = "Daily"
		$jobSchedule.FrequencySubDayTypes = "Once"
		$jobSchedule.ActiveStartTimeOfDay = $StartTS
		$jobSchedule.ActiveEndTimeOfDay = $EndTS
		$jobSchedule.FrequencyInterval = 1
		$jobSchedule.ActiveStartDate = get-date
		$jobSchedule.Create()
		
		Write-Host SQL Agent Job: $jobName was created
	}
}

main

