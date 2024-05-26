do {
  # Prompt the user for input
  Write-Host ""
  Write-Host "Which drive is Windows installed in?"
  Write-Host ""
  $name = Read-Host "Write only one letter"

  # Check if the input length is 1 character
  if ($name.Length -eq 1) {
    # Exit the loop if it's one character
    Write-Host ""
    break
  } else {
    # Inform user about incorrect input and prompt again
    Write-Host ""
    Write-Host "Please enter only one character (a letter)."
    Write-Host ""
  }
} while ($true)  # Loop continues until a single character is entered

Write-Host "Drive $name selected as Windows location."
Write-Host ""

$FilePathOld = "${name}:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\IAS.cmd"

$FilePath = "${name}:\ProgramData\IAS.cmd"

if (Test-Path $FilePathOld) {
    $item = Get-Item -LiteralPath $FilePathOld
    $item.Delete()
    Write-Host ""
    Write-Host "Removed a file from $FilePathOld."
}

if (Test-Path $FilePath) {
    $item = Get-Item -LiteralPath $FilePath
    $item.Delete()
    Write-Host ""
    Write-Host "Removed a file from $FilePath."
}

# Define the task name
$taskName = "IDM Startup Trial Reset"

# Check if the task exists
$taskExists = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue

if ($taskExists) {
    # Delete the task
    Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
    Write-Host ""
    Write-Host "Removed a scheduled task."
}

Write-Host ""
Write-Host "Scheduled task and remnant files were successfully removed."
Write-Host ""