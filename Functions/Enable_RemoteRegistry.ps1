#Enable_RemoteRegistry.ps1
#Enables Remote Registry on the host computer
#Tim Anderson - Converted to function 6/22/2016

echo " "
echo "[-- Remote Registry -]"

$RemoteRegistryWMIObject = Get-WmiObject -Class Win32_Service -Property StartMode -Filter "Name='RemoteRegistry'"
$RemoteRegistryStartupType = $RemoteRegistryWMIObject.StartMode

	if ($RemoteRegistryStartupType -like "Auto") {
	
		Write-Host -Foreground Green "Remote Registry is already set to automatic. Skipping..."
	
	}
	else {
	
		Get-Service -Name "RemoteRegistry" | Set-Service -StartupType Automatic
		Write-Host -Foreground Red "Setting Remote Registry service to Automatic."
	
	}
	
$RemoteRegistryService = Get-Service -Name "RemoteRegistry"
$RemoteRegistryStatus = $RemoteRegistryService.Status

	if ($RemoteRegistryStatus -like "Running") {
	
		Write-Host -ForegroundColor Green "The Remote Registry Service is already started. Skipping..."
	
	}
	else {
	
		Write-Host -Foreground Red "Starting the Remote Registry Service..."
		Get-Service -Name "RemoteRegistry" | Start-Service
	
	}