param (
    [string]$GameID, # The game ID or URL for the game
    [string]$GameProcess # The name of the game's process
)

# Start the game using the launcher URL
try {
    Start-Process "com.epicgames.launcher://apps/${GameID}?action=launch&silent=true" -ErrorAction Stop
    Write-Host "Launching game..."
}
catch {
    Write-Host "Failed to launch the game. Error: $_"
    exit
}

# Sleep to let the game start
Start-Sleep -Seconds 20

# Define a loop to check if the game is still running
$gameRunning = $true
while ($gameRunning) {
    Start-Sleep -Seconds 5
    $gameRunning = Get-Process -Name $GameProcess -ErrorAction SilentlyContinue
}

# Sleep to ensure cloud-saves are uploaded
Start-Sleep -Seconds 20

# Close the launcher processes after the game exits
try {
    Write-Host "Closing launcher..."
    Stop-Process -Name "EpicGamesLauncher" -Force -ErrorAction Stop
    Stop-Process -Name "EpicWebHelper" -Force -ErrorAction Stop
}
catch {
    Write-Host "Failed to close the launcher. Error: $_"
}