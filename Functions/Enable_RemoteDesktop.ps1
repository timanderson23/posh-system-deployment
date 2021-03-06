#Enable_RemoteDesktop.ps1
#Enables Remote Desktop on the host computer
#Converted to Function on 6/22/2016 - Tim Anderson

echo " "
echo "[-- Remote Desktop --]"

#Enable RDP connections
$TSRegistryKey = Get-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'

if ($TSRegistryKey.fDenyTSConnections -eq 0) {

    Write-Host -Foreground Green "RDP Connections are already allowed. Skipping..."

}
elseif ($TSRegistryKey.fDenyTSConnections -eq 1) {

    echo "Enabling RDP Connections..."
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -Value 0

}
else {Write-Host -Foreground Red "Unexpected Result!"}

#Open RDP in firewall
$RDPFirewallRule = Get-NetFirewallRule -DisplayGroup "Remote Desktop"

if ($RDPFirewallRule.Enabled -like "True") {

    Write-Host -Foreground Green "RDP Firewall Rule already enabled. Skipping..."

}
elseif ($RDPFirewallRule.Enabled -like "False") {

    echo "Enabling RDP Firewall rule..."
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

}
else {Write-Host -Foreground Red "Unexpected Result!"}

#Enable file and Printer Sharing
$FPSFirewallRule = Get-NetFirewallRule -Group "@FirewallAPI.dll,-28502" | Where-Object{$_.Name -like "FPS-NB_Session-In-TCP"}
$FPSFirewallRuleEnabled = $FPSFirewallRule.Enabled

if ($FPSFirewallRuleEnabled -like "True") {

    Write-Host -Foreground Green "File and Printer Sharing is already enabled. Skipping..."

}
elseif ($FPSFirewallRuleEnabled -like "False") {

    echo "Enabling File and Printer Sharing..."
    Enable-NetFirewallRule -Group "@FirewallAPI.dll,-28502"

}
else {Write-Host -Foreground Red "Unexpected Result!"}