# setup-and-run.ps1

$curlPath = (Get-Command curl.exe -ErrorAction SilentlyContinue).Source

$ToolName = "---[CMF Extensions Python Set-up]:"

if (-not $curlPath) {
    Write-Host "$ToolName curl.exe not found. Installing via winget..." -ForegroundColor Yellow

    winget install --id curl.se.curl -e --source winget

    winget install Python.Python.3.13s

    Write-Host ""
    Write-Host "$ToolName curl has been installed." -ForegroundColor Green
    Write-Host "$ToolName Please CLOSE this PowerShell window and open a new one," -ForegroundColor Cyan
    Write-Host "$ToolName then re-run this script to continue." -ForegroundColor Cyan
    exit
}

Write-Host "$ToolName curl.exe found at $curlPath" -ForegroundColor Green
Write-Host "$ToolName Ending process... Go back to https://github.com/PurpleWorksKirnotP/OP/blob/main/Mains/README.md to run any script."
start-sleep -Seconds 10