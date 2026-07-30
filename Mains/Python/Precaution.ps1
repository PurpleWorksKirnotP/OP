# setup-and-run.ps1

$curlPath = (Get-Command curl.exe -ErrorAction SilentlyContinue).Source

if (-not $curlPath) {
    Write-Host "curl.exe not found. Installing via winget..." -ForegroundColor Yellow

    winget install --id curl.se.curl -e --source winget

    Write-Host ""
    Write-Host "curl has been installed." -ForegroundColor Green
    Write-Host "Please CLOSE this PowerShell window and open a new one," -ForegroundColor Cyan
    Write-Host "then re-run this script to continue." -ForegroundColor Cyan
    exit
}

Write-Host "curl.exe found at $curlPath" -ForegroundColor Green
Write-Host "Fetching and running the Python script..." -ForegroundColor Cyan

$scriptUrl = "https://raw.githubusercontent.com/PurpleWorksKirnotP/OP/refs/heads/main/Mains/Python/CMFExtensionPython0.0.1.py"

curl.exe -s $scriptUrl | python -