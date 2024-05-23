$DownloadURL = 'https://raw.githubusercontent.com/NaeemBolchhi/IDM-Startup-Trial-Reset/main/IAS.cmd'

$FilePath = "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\IAS.cmd"

try {
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($DownloadURL, $FilePath)
} catch {
    Write-Error $_
    Return
}

if (Test-Path $FilePath) {
    Start-Process $FilePath -Wait
    # $item = Get-Item -LiteralPath $FilePath
    # $item.Delete()
}
