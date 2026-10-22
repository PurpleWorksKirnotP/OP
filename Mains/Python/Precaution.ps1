# setup-and-run.ps1

$curlPath = (Get-Command curl.exe -ErrorAction SilentlyContinue).Source
$pythonPath = (Get-Command python -ErrorAction SilentlyContinue).Source

$ToolName = "---[CMF Extensions Python Set-up]:"

if (-not $curlPath -or -not $pythonPath) {
    if (-not $curlPath) {
        Write-Host "$ToolName curl.exe not found. Installing via winget..." -ForegroundColor Yellow
        winget install --id cURL.cURL -e --source winget
    }

    if (-not $pythonPath) {
        Write-Host "$ToolName python not found. Installing via winget..." -ForegroundColor Yellow
        winget install --id Python.Python.3.13 -e --source winget
    }

    Write-Host ""
    Write-Host "$ToolName Missing prerequisites installed." -ForegroundColor Green
    Write-Host "$ToolName Please CLOSE this PowerShell window and open a new one," -ForegroundColor Cyan
    Write-Host "$ToolName then re-run this script to continue." -ForegroundColor Cyan
    exit
}

Write-Host "$ToolName curl.exe found at $curlPath" -ForegroundColor Green
Write-Host "$ToolName python found at $pythonPath" -ForegroundColor Green
Write-Host "$ToolName Ending process... Go back to https://github.com/PurpleWorksKirnotP/OP/blob/main/Mains/CmdPurps.md to run any script."
start-sleep -Seconds 10