<#
.SYNOPSIS
    Script To Telnet To Remote Hosts And Run Commands Against Them With Output To A File.

.DESCRIPTION
    Script To Telnet To Remote Hosts And Run Commands Against Them With Output To A File.

.PARAMETER remoteHost
    remote Host.

.PARAMETER port
    port.

.PARAMETER username
    username.

.PARAMETER password
    password.

.PARAMETER termlength
    termlength.

.PARAMETER enable
    enable.

.PARAMETER enablepassword
    enablepassword.

.PARAMETER command1
    command1.

.EXAMPLE
    PS C:\> .\PowerShellTelnetRemoteSession.ps1
    Script To Telnet To Remote Hosts And Run Commands Against Them With Output To A File.
#>

param(
    [string] $remoteHost = "", 
    [int] $port = 23,
    [string] $username = "",
    [string] $password = "",
    [string] $termlength = "term len 0", #Useful for older consoles that have line display limitations
    [string] $enable = "en", #Useful for appliances like Cisco switches that have an 'enable' command mode
    [string] $enablepassword = "",
    [string] $command1 = "show interface", #You can add additional commands below here with additonal strings if you want
    [int] $commandDelay = 1000
   )
 
[string] $output = ""

## Read output from a remote host
function GetOutput
{
  ## Create a buffer to receive the response
  $buffer = new-object System.Byte[] 1024
  $encoding = new-object System.Text.AsciiEncoding
 
  $outputBuffer = ""
  $foundMore = $false
 
  ## Read all the data available from the stream, writing it to the
  ## output buffer when done.
  do
  {
    ## Allow data to buffer for a bit
    start-sleep -m 1000
 
    ## Read what data is available
    $foundmore = $false
    $stream.ReadTimeout = 1000
 
    do
    {
      try
      {
        $read = $stream.Read($buffer, 0, 1024)
 
        if($read -gt 0)
        {
          $foundmore = $true
          $outputBuffer += ($encoding.GetString($buffer, 0, $read))
        }
      } catch { $foundMore = $false; $read = 0 }
    } while($read -gt 0)
  } while($foundmore)
 
  $outputBuffer
}
 
function Main
{
  ## Open the socket, and connect to the computer on the specified port

  write-host "Connecting to $remoteHost on port $port"
 
  trap { Write-Error "Could not connect to remote computer: $_"; exit }
  $socket = new-object System.Net.Sockets.TcpClient($remoteHost, $port)
 
  write-host "Connected. Press ^D followed by [ENTER] to exit.`n"
 
  $stream = $socket.GetStream()
 
  $writer = new-object System.IO.StreamWriter $stream

    ## Receive the output that has buffered so far
    $SCRIPT:output += GetOutput

        $writer.WriteLine($username)
        $writer.Flush()
        Start-Sleep -m $commandDelay
                $writer.WriteLine($password)
        $writer.Flush()
        Start-Sleep -m $commandDelay
                $writer.WriteLine($termlength)
        $writer.Flush()
        Start-Sleep -m $commandDelay
                $writer.WriteLine($enable)
        $writer.Flush()
        Start-Sleep -m $commandDelay
                $writer.WriteLine($enablepassword)
        $writer.Flush()
        Start-Sleep -m $commandDelay
                $writer.WriteLine($command1) #Add additional entries below here for additional 'strings' you created above
        $writer.Flush()
        Start-Sleep -m $commandDelay
        $SCRIPT:output += GetOutput
                
 
 
  ## Close the streams
  $writer.Close()
  $stream.Close()
 
  $output | Out-File ("C:\BoxBuild\$remoteHost.txt") #Change this to suit your environment
}
. Main