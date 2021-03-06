#Enable_RemotePowerShell.ps1
#Enables WinRM on the host computer to enable the host to receive remote powershell requests
#Dave May/Tim Anderson 6/22/2016

echo ""
echo "[-- Remote PowerShell --]"

$Result = [bool](Test-WSMan -ComputerName localhost -ErrorAction SilentlyContinue)

	if ($Result) {
	
		Write-Host -ForegroundColor Green "Remote PowerShell is already enabled. Skipping..."
	
	}
	elseif (!$Result) {
	
		Write-Host -Foreground Cyan "Enabling Remote PowerShell..."
		Enable-PSRemoting -force
	
	}
	else {
	
		Write-Host -ForegroundColor Red "Unexpected Result!"
	
	}

