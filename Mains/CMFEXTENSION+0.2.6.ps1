# Turns off Wi-Fi and shuts down the computer
# Usage: Run PowerShell as Administrator, then: .\WifiOff-Shutdown.ps1

#Requires -RunAsAdministrator

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
        $fileSizeKB = [math]::Round($file.Length / 1KB, 2)
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

start-sleep -Milliseconds 125
Write-Host "---[[CMF-E-V0.5.2]]: WARNING!!! FOUND THREATS. DISABLING WIFI + REBOOTING SYSTEM AND REMOVING THREATS" -ForegroundColor Red
start-sleep -Milliseconds 50

try {
    # Get all Wi-Fi adapters (works even if there are multiple)
    $wifiAdapters = Get-NetAdapter | Where-Object { $_.InterfaceDescription -match "Wireless|Wi-Fi|802.11" -and $_.Status -eq "Up" }

    if ($wifiAdapters) {
        foreach ($adapter in $wifiAdapters) {
            Disable-NetAdapter -Name $adapter.Name -Confirm:$false
            Write-Host "Disabled adapter: $($adapter.Name)" -ForegroundColor Magenta
        }
    } else {
        # Fallback: try toggling via netsh
        netsh interface set interface "Wi-Fi" admin=disable
        Write-Host "Wi-Fi disabled via netsh." -ForegroundColor Magenta
    }
} catch {
    Write-Host "Could not disable Wi-Fi automatically. Error: $_" -ForegroundColor Red
}
start-sleep -Milliseconds 125
Write-Host "---[[CMF-E-V0.5.2]]: DISABLED WIFI, MOVING TO THREAT REMOVAL!!!" -ForegroundColor Red

for ($i = 1; $i -le 50; $i++) {
    Write-Host "---[[CMF-E-V0.5.2]]: REMOVING THREATS!!!" -ForegroundColor Red
    [Console]::Beep(1000, 50)
    Start-Sleep -Milliseconds 15
}

for ($i = 1; $i -le 50; $i++) {
    Write-Host "---[[CMF-E-V0.5.2]]: FATAL ERROR!!! MOVING TO LAST RESORT!!!" -ForegroundColor Red
    [Console]::Beep(1000, 50)
    Start-Sleep -Milliseconds 25
}

Start-Sleep -Seconds 5

Stop-Computer -Force