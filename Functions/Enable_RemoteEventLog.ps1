#Enable_RemoteEventLog.ps1
#Open remote event log management
#Dave May/Tim Andesron. Converted to function 6/22/2016 TA

echo " "
echo "[-- Remote Event Log --]"

$EventLogFirewallRule = Get-NetFirewallRule -DisplayGroup "Remote Event Log Management" | Where{$_.Name -like "RemoteEventLogSvc-In-TCP-NoScope"}

	if ($EventLogFirewallRule.Enabled -like "True") {
	
		Write-Host -ForegroundColor Green "Remote Event Log Management has already been enabled. Skipping..."
	
	}
	elseif ($EventLogFirewallRule.Enabled -like "False") {
	
		Write-Host -Foreground Cyan "Enabling Remote Event Log Management..."
		Enable-NetFirewallRule -DisplayGroup "Remote Event Log Management"
	
	}
	else {
	
		Write-Host -ForegroundColor Red "Unexpected Result!"
	
	}


