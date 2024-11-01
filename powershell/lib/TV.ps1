. "$PSScriptRoot\WoL.ps1"

# Turn TV on
function Start-TV {
    $tvMacAddress = "24:E8:53:D8:59:EC"
    Send-WakeOnLan -MACAddress $tvMacAddress
}