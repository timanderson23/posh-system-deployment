#Install_Snagit.ps1
#Install Snagit v9 on the host computer
#Tim Anderson 6/23/2016

echo ""
echo "[-- Snagit --]"

$Result = Test-Path "C:\Program Files (x86)\TechSmith\Snagit 9\Snagit32.exe"

	if ($Result) {
	
		Write-Host -ForegroundColor Green "Snagit is already installed. Skipping..."
	
	}
	elseif (!$Result) {
	
		#Install Snagit v9
		Set-Location "T:\Installs\SnagIt\Install_Files\v9.1.3\snagit.msi"
		$Install_Snagit = "msiexec.exe /i snagit.msi /qb"
		Invoke-Expression $Install_Snagit
		Start-Sleep -s 5
		
		Do {
		
			$SnagitProcess = Get-Process | where {$_.ProcessName -like "Snagit32"}
		
			#If the Snagit process does not exist, keep waiting. Wait until the process exists (which means the installer finished)
			if(!$SnagitProcess) {
			
				#Do nothing...
				Start-Sleep -s 3
			
			}
		} Until ($SnagitProcess)
		
		Write-Host -ForegroundColor Green "Done!"
	
	}
	else {
	
		Write-Host -ForegroundColor Red "Unexpected Result!"
	
	}



