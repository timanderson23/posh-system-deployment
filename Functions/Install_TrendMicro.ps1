#Install_TrendMicro.ps1
#Install the Trend Micro Office Scan Agent on the host computer
#Tim Anderson 6/23/2016

echo ""
echo "[-- Trend Micro Agent --]"

$Result = Test-Path "C:\Program Files (x86)\Trend Micro\OfficeScan Client\PccNTMon.exe"

	if ($Result) {
	
		Write-Host -ForegroundColor Green "Trend Micro is already installed. Skipping..."
	
	}
	elseif (!$Result) {
	
		#Install Trend Micro Agent
		Set-Location "t:\Installs\TrendMicro\Install Files\v11-x64"
		$Install_TrendMicro = "msiexec.exe /i agent_cloud_x64.msi /passive"
		Invoke-Expression $Install_TrendMicro
		Start-Sleep -s 5
		
		Do {
		
			$TrendProcess = Get-Process | where {$_.ProcessName -like "PCCNTMon"}
		
			#If the Trend Micro process does not exist, keep waiting. Wait until the process exists (which means the installer finished)
			if(!$TrendProcess) {
			
				#Do nothing...
				Start-Sleep -s 3
			
			}
		} Until ($TrendProcess)
		
		Write-Host -ForegroundColor Green "Done!"
	
	}
	else {
	
		Write-Host -ForegroundColor Red "Unexpected Result!"
	
	}