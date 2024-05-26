do {
  # Prompt the user for input
  Write-Host " "
  Write-Host "Which drive is Windows installed in?"
  Write-Host " "
  $name = Read-Host "Write only one letter"

  # Check if the input length is 1 character
  if ($name.Length -eq 1) {
    # Exit the loop if it's one character
    Write-Host " "
    break
  } else {
    # Inform user about incorrect input and prompt again
    Write-Host " "
    Write-Host "Please enter only one character (a letter)."
    Write-Host " "
  }
} while ($true)  # Loop continues until a single character is entered

Write-Host "Drive $name selected as Windows location."
Write-Host " "

$DownloadURL = 'https://raw.githubusercontent.com/NaeemBolchhi/IDM-Startup-Trial-Reset/main/IAS.cmd'

$FilePathOld = "${name}:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\IAS.cmd"

$FilePath = "${name}:\ProgramData\IAS.cmd"

if (Test-Path $FilePathOld) {
    $item = Get-Item -LiteralPath $FilePathOld
    $item.Delete()
}

# Define the task name
$taskName = "IDM Startup Trial Reset"

# Check if the task exists
$taskExists = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue

Write-Host " "
Write-Host "Checking for duplicate tasks..."
Write-Host " "

if ($taskExists) {
    # Delete the task
    Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
    Write-Output "Duplicate task was found and deleted."
} else {
    Write-Output "No duplicate task was found."
}

Write-Host " "
Write-Host "Checking for duplicate scripts..."
Write-Host " "

if (Test-Path $FilePath) {
    $item = Get-Item -LiteralPath $FilePath
    $item.Delete()
    Write-Output "Duplicate script was found and deleted."
} else {
    Write-Output "No duplicate script was found."
}

Write-Host " "
Write-Host " "
Write-Host "Downloading IDM Reset script..."
Write-Host " "

try {
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($DownloadURL, $FilePath)
} catch {
    Write-Error $_
    Write-Host "Report this error to NaeemBolchhi. (#1)"
    Return
}

if (Test-Path $FilePath) {
    #Start-Process $FilePath -Wait
    Write-Host "Placed IDM Reset script in ${FilePath}."
} else {
    Write-Host "Report this error to NaeemBolchhi. (#2)"
}

Write-Host " "
Write-Host "Setting up an automated task in Task Scheduler..."

# Define the XML for the task
$taskXml = @"
<?xml version="1.0" encoding="UTF-16"?>
<Task version="1.3" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
  <RegistrationInfo>
    <Date>$(Get-Date -Format 'yyyy-MM-ddTHH:mm:ss')</Date>
    <Author>$(whoami)</Author>
    <Description>Reset IDM's trial period on startup without UAC prompt.</Description>
  </RegistrationInfo>
  <Triggers>
    <LogonTrigger>
      <Enabled>true</Enabled>
    </LogonTrigger>
  </Triggers>
  <Principals>
    <Principal id="Author">
      <UserId>$(whoami)</UserId>
      <LogonType>InteractiveToken</LogonType>
      <RunLevel>HighestAvailable</RunLevel>
    </Principal>
  </Principals>
  <Settings>
    <MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>
    <DisallowStartIfOnBatteries>false</DisallowStartIfOnBatteries>
    <StopIfGoingOnBatteries>false</StopIfGoingOnBatteries>
    <AllowHardTerminate>false</AllowHardTerminate>
    <StartWhenAvailable>true</StartWhenAvailable>
    <RunOnlyIfNetworkAvailable>false</RunOnlyIfNetworkAvailable>
    <IdleSettings>
      <StopOnIdleEnd>false</StopOnIdleEnd>
      <RestartOnIdle>false</RestartOnIdle>
    </IdleSettings>
    <AllowStartOnDemand>true</AllowStartOnDemand>
    <Enabled>true</Enabled>
    <Hidden>false</Hidden>
    <RunOnlyIfIdle>false</RunOnlyIfIdle>
    <WakeToRun>false</WakeToRun>
    <ExecutionTimeLimit>PT0S</ExecutionTimeLimit>
    <Priority>7</Priority>
  </Settings>
  <Actions Context="Author">
    <Exec>
      <Command>${FilePath}</Command>
    </Exec>
  </Actions>
</Task>
"@

# Save the XML to a file
$taskXmlPath = "$env:temp\MyTask.xml"
$taskXml | Out-File -FilePath $taskXmlPath -Encoding UTF8

# Register the task using the XML definition
Register-ScheduledTask -Xml (Get-Content $taskXmlPath | Out-String) -TaskName $taskName

$taskExists2 = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue

if ($taskExists2) {
    Write-Host " "
    Write-Host "Task created successfully."
    Write-Host " "
    Write-Host "Task will run once automatically."
    Start-ScheduledTask -TaskName $taskName
} else {
    Write-Host " "
    Write-Host "Task creation failed."
    Write-Host " "
    Write-Host "Report this error to NaeemBolchhi. (#3)"
}

Write-Host " "