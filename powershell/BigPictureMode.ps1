. "$PSScriptRoot\lib\TV.ps1"
Start-TV
Start-Sleep -Seconds 5

# Switch to external monitor (TV)
Write-Host "Switching to external monitor..."
DisplaySwitch.exe /external

# Launch Steam Big Picture using URL
Write-Host "Launching Steam Big Picture..."
Start-Process "steam://open/bigpicture"
Start-Sleep -Seconds 10

# Check if the Steam Big Picture window is open
Write-Host "Waiting for Steam Big Picture mode to close..."
do {
    $bigPictureWindow = Get-Process -Name "steamwebhelper" -ErrorAction SilentlyContinue | Where-Object {
        $_.MainWindowTitle -match "Steam Big Picture Mode"
    }
    Start-Sleep -Seconds 1
} while ($bigPictureWindow)

# Switch back to primary monitor
Write-Host "Steam Big Picture mode has closed, switching to internal monitor..."
DisplaySwitch.exe /internal