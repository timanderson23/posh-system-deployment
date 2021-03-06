#Install_ISAClient.ps1
#Install the Microsoft ISA Server Client on the host computer
#Tim Anderson 6/23/2016

echo ""
echo "[-- ISA Client --]"

$Result = Test-Path "C:\Program Files (x86)\Microsoft Firewall Client 2004\FwcMgmt.exe"

	if ($Result) {
	
		Write-Host -ForegroundColor Green "Microsoft ISA Client is already installed. Skipping..."
	
	}
	elseif (!$Result) {
	
		#Install ISA Client
		Set-Location "T:\Installs\Microsoft\ISA Server\Firewall Client\ISACLIENT-KB929556-ENU\"
		$Install_ISAClient = "msiexec /i MS_FWC.MSI SERVER_NAME_OR_IP=isa2 ENABLE_AUTO_DETECT=0 REFRESH_WEB_PROXY=0 /qb"
		Invoke-Expression $Install_ISAClient
		Start-Sleep -s 5
		
		Do {
		
			$ISAProcess = Get-Process | where {$_.ProcessName -like "FwcMgmt"}
		
			#If the ISA process does not exist, keep waiting. Wait until the process exists (which means the installer finished)
			if(!$ISAProcess) {
			
				#Do nothing...
				Start-Sleep -s 3
			
			}
		} Until ($ISAProcess)
		
		Write-Host -ForegroundColor Green "Done!"
	
	}
	else {
	
		Write-Host -ForegroundColor Red "Unexpected Result!"
	
	}