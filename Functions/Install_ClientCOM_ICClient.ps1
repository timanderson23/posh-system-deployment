#Install_ClientCOM_ICClient.ps1
#Install the ININ IC Client on the host computer
#Tim Anderson 6/23/2016

echo ""
echo "[-- IC ClientCOM/Client --]"

#ClientCOM
$Result = Test-Path "C:\Program Files (x86)\Interactive Intelligence\ClientCom\ClientCOMA.dll"

	if ($Result) {
	
		Write-Host -ForegroundColor Green "ClientCOM is already installed. Skipping..."
	
	}
	elseif (!$Result) {
	
		#Install ClientCOM
		Set-Location \\cic3\IC_ClientCOM
		$Install_ClientCOM = "msiexec.exe /i ClientCOM_SU10.msi ICSERVERNAME=cic4 /qb"
		Invoke-Expression $Install_ClientCOM
		Start-Sleep -s 5
		
		Do {
		
			$ClientCOMProcess = Get-Process | where {$_.ProcessName -like "i3trace_initializer-w32r-1-1"}
		
			#If the ClientOM-based process above does not exist, keep waiting. Wait until the process exists (which means the installer finished)
			if(!$Result) {
			
				#Do nothing...
				Start-Sleep -s 3
			
			}
		} Until ($Result)
	
	}
	else {
	
		Write-Host -ForegroundColor Red "Unexpected Result!"
	
	}
	
#IC Client
$Result = Test-Path "C:\Program Files (x86)\Interactive Intelligence\ICUserApps\InteractionClient.exe"

if ($Result) {

	Write-Host -ForegroundColor Green "IC Client is already installed. Skipping..."

}
elseif (!$Result) {

	#Install IC Client
	Set-Location \\cic3\IC_UserApps
	$Install_ICClient = "msiexec.exe /i ICUserApps_SU10.msi ICSERVERNAME=cic4 /qb"
	Invoke-Expression $Install_ICClient
	Start-Sleep -s 5
	
	Do {
	
		$ICLauncher = Test-Path "C:\Program Files (x86)\Interactive Intelligence\ICUserApps\InteractionClient.exe"
	
		#If the IC Client launcher does not exist, keep waiting. Wait until the file exists (which means the installer finished, or is about to finish)
		if(!$ICLauncher) {
		
			#Do nothing...
			Start-Sleep -s 3
		
		}
	} Until ($ICLauncher)
	
	Write-Host -ForegroundColor Green "Done!"

}
else {

	Write-Host -ForegroundColor Red "Unexpected Result!"

}

Start-Sleep -Seconds 5