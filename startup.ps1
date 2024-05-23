do {
  # Prompt the user for input
  Write-Host "Which drive is Windows installed in?"
  Write-Host " "
  $userInput = Read-Host "Write one letter only"

  # Check if the input length is 1 character
  if ($userInput.Length -eq 1) {
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

# Assign the user's valid input (single character) to the $name variable
$name = $userInput

Write-Host "$name Drive selected as Windows location."
Write-Host " "

$DownloadURL = 'https://raw.githubusercontent.com/NaeemBolchhi/IDM-Startup-Trial-Reset/main/IAS.cmd'

$FilePath = "${name}:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\IAS.cmd"

if (Test-Path $FilePath) {
    $item = Get-Item -LiteralPath $FilePath
    $item.Delete()
}

try {
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($DownloadURL, $FilePath)
} catch {
    Write-Error $_
    Return
}

if (Test-Path $FilePath) {
    Start-Process $FilePath -Wait
}
