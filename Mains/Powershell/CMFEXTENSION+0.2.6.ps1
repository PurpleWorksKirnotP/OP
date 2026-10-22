# CMF Extension - simulated "threat scan" for demonstration purposes.
# It only reads file names/sizes under your user profile and prints them.
# It does NOT touch the clipboard, the network adapters or the power state.
# Usage: powershell -ExecutionPolicy Bypass -File .\CMFEXTENSION+0.2.6.ps1

Write-Host @"
   ______  ____    ____  ________       ________  ____  ____  _________  ________  ____  _____   ______   _____   ___   ____  _____              ____     _______       _____   
 .' ___  ||_   \  /   _||_   __  |     |_   __  ||_  _||_  _||  _   _  ||_   __  ||_   \|_   _|.' ____ \ |_   _|.'   `.|_   \|_   _|           .'    '.  |  _____|     / ___ `. 
/ .'   \_|  |   \/   |    | |_ \_|______ | |_ \_|  \ \  / /  |_/ | | \_|  | |_ \_|  |   \ | |  | (___ \_|  | | /  .-.  \ |   \ | |    _   __  |  .--.  | | |____      |_/___) | 
| |         | |\  /| |    |  _|  |______||  _| _    > `' <       | |      |  _| _   | |\ \| |   _.____`.   | | | |   | | | |\ \| |   [ \ [  ] | |    | | '_.____''.    .'____.' 
\ `.___.'\ _| |_\/_| |_  _| |_          _| |__/ | _/ /'`\ \_    _| |_    _| |__/ | _| |_\   |_ | \____) | _| |_\  `-'  /_| |_\   |_   \ \/ /  |  `--'  |_| \____) | _ / /_____  
 `.____ .'|_____||_____||_____|        |________||____||____|  |_____|  |________||_____|\____| \______.'|_____|`.___.'|_____|\____|   \__/    '.____.'(_)\______.'(_)|_______| 
                                                                                                                                                                                
"@ -ForegroundColor Magenta

Write-Host "---[[CMF-E-V0.5.2]]: Scanning for threats..." -ForegroundColor Magenta
start-sleep -Milliseconds 50

$userProfilePath = [Environment]::GetFolderPath('UserProfile')

if (Test-Path $userProfilePath) {
    $files = Get-ChildItem -Path $userProfilePath -Recurse -File | Sort-Object FullName

    foreach ($file in $files) {
        $fileSizeKB = [math]::Round($file.Length / 1024, 2)
        $createdDate = $file.CreationTime.ToString('yyyy-MM-dd HH:mm:ss')
        Write-Host "---[[CMF-E-V0.5.2]]: $($file.Name) | SIZE: $fileSizeKB KB | ThreatLEVEL: 0 | DATE CREATED: $createdDate | $($file.FullName)" -ForegroundColor Magenta
    }
} else {
    Write-Host "---[[CMF-E-V0.5.2]]: User profile folder not found." -ForegroundColor Yellow
}
start-sleep -Milliseconds 50
Write-Host "---[[CMF-E-V0.5.2]]: Compiled Array of files. Proceeding to do thorough search." -ForegroundColor Magenta

$loadingSeconds = 52
for ($i = 1; $i -le $loadingSeconds; $i++) {
    $percent = [int](($i / $loadingSeconds) * 100)
    $barLength = [int](($i / $loadingSeconds) * 40)
    $bar = "#" * $barLength + "-" * (40 - $barLength)
    Write-Progress -Activity "Scanning system files" -Status "[$bar] $percent% complete" -PercentComplete $percent
    Start-Sleep -Seconds 1
}
Write-Progress -Activity "Scanning system files" -Completed

Write-Host "---[[CMF-E-V0.5.2]]: Scan complete. Nothing was disabled or deleted." -ForegroundColor Green
Write-Host "---[[CMF-E-V0.5.2]]: (Simulation only - no adapters were touched and the PC will not reboot.)" -ForegroundColor Green
start-sleep -Seconds 2
