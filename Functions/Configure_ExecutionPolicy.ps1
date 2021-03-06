#Configure_ExecutionPolicy.ps1
#Sets the PowerShell Execution Policy on the host computer to RemoteSigned
#Dave May/Tim Anderson. Converted to function 6/22/2016

# Resolves the error -- File xxx.ps1 cannot be loaded because running scripts is disabled on this system.
echo ""
echo "[-- Execution Policy --]"

$Result = Get-ExecutionPolicy

	if ($Result -like "RemoteSigned") {
	
		Write-Host -ForegroundColor Green "Powershell Execution Policy is already configured. Skipping..."
	
	}
	elseif ($Result -notlike "RemoteSigned") {
	
		Write-Host -ForegroundColor Cyan "Setting PowerShell Execution Policy to RemoteSigned..."
		Set-ExecutionPolicy RemoteSigned
	
	}
	else {
	
		Write-Host -ForegroundColor Red "Unexpected Result!"
	
	}