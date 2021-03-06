#Install_Offce2007.ps1
#Installs Office 2007 on the host computer
#Tim Anderson 6/23/2016

echo ""
echo "[-- Microsoft Office 2007 --]"

$Result = Test-Path "C:\Program Files (x86)\Microsoft Office\Office12\OUTLOOK.EXE"

	if ($Result) {
	
		Write-Host -ForegroundColor Green "Microsoft Office 2007 is already installed. Skipping..."
	
	}
	elseif (!$Result) {

	Set-Location t:\Installs\Microsoft\Office\2007

	#Define Variables
	$Install_Office2007 = ".\setup.exe /config .\Standard.WW\config.xml"

	Write-Host -ForegroundColor Cyan "Installing Office 2007..."

	#Start the install
	Invoke-Expression $Install_Office2007
	Start-Sleep -Seconds 5

		#Check if the setup.exe process exists, halt further script execution if it does. If not, continue.
		do {
		
			$SetupProcess = Get-Process | where {$_.ProcessName -like "setup"}
			
			if ($SetupProcess) {
				
				#Do nothing. The installer is still running.
				Start-Sleep -Seconds 3
			
			}
			
		} Until (!$SetupProcess)

	Write-Host -ForegroundColor Green "Done!"

}
else {

	Write-Host -ForegroundColor Red "Unexpected Result!"

}