# Function to send a Wake-on-LAN (WoL) magic packet
function Send-WakeOnLan {
    param(
        [Parameter(Mandatory = $true)]
        [string]$MACAddress
    )

    $broadcastAddress = [System.Net.IPAddress]::Parse("10.1.1.255")
    $udpClient = New-Object System.Net.Sockets.UdpClient
    $udpClient.Connect($broadcastAddress, 9)  # WoL uses port 9

    $macBytes = ($MACAddress -replace "[:-]", '') -split '(?<=\G.{2})' -ne '' | ForEach-Object { [byte]('0x' + $_) }
    
    # Create the magic packet: 6 bytes of FF followed by 16 repetitions of the MAC address
    $magicPacket = [byte[]](0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF) + ($macBytes * 16)

    # Send the magic packet
    $udpClient.Send($magicPacket, $magicPacket.Length)
    $udpClient.Close()

    Write-Host "Magic packet sent to $MACAddress"
}