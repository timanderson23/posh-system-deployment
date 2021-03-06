#Install_PackageMangers.ps1
#Install Package Providers on the host computer. Chocolatey, etc.
#Dave May/Tim Anderson 6/23/2016

echo " "
echo "[-- Install Package Providers/Repositories --]"

# Install NuGet provider
$NugetPackage = Get-PackageProvider | Where {$_.Name -like "*NuGet*"}

	if ($NugetPackage) {
	
		Write-Host -ForegroundColor Green "NuGet has already been installed. Skipping..."
	
	}
	elseif (!$NugetPackage) {
	
		Write-Host -ForegroundColor Cyan "Installing NuGet package provider..."
		Install-PackageProvider -Name NuGet -Force
	
	}
	else {
	
		Write-Host -ForegroundColor Red "Unexpected Result!"
	
	}

# Trust PSGallery repo
$PSRepositoryStatus = Get-PSRepository

	if ($PSRepositoryStatus.InstallationPolicy -like "*Trusted*") {
	
		Write-Host -ForegroundColor Green "PSRepository is already trusted. Skipping..."
	
	}
	elseif ($PSRepositoryStatus.InstallationPolicy -notlike "*Trusted*") {
	
		Write-Host -Foreground Cyan "Trusting PSGallery repository..."
		Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
	
	}
	else {
	
		Write-Host -ForegroundColor Red "Unexpected Result!"
	
	}

# Install Chocolatey
$ChocoPackage = choco version all

	if ($ChocoPackage) {
	
		Write-Host -ForegroundColor Green "Chocolatey is already installed. Skipping..."
	
	}
	elseif (!$ChocoPackage) {
	
		Write-Host -Foreground Cyan "Installing Chocolatey..."
		#iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
		iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
	
	}
	else {
	
		Write-Host -ForegroundColor Red "Unexpected Result!"
	
	}