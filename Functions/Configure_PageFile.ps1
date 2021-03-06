#Configure_PageFile.ps1
#Checks the page file setting, and adjusts if needed
#Converted to function 6/22/2016 Tim Anderson

echo " "
echo "[-- Page File --]"

$PageFile = Get-WmiObject Win32_PageFileSetting | Select InitialSize, MaximumSize

if ($PageFile.MaximumSize -eq 4096) {

	Write-Host -ForegroundColor Green "The Page file is already setup correctly. Skipping..."
	
}

elseif ($PageFile.MaximumSize -ne 4096) {

	try {
	
		Write-Host -ForegroundColor Cyan "Updating page file settings..."
		$PageFile.InitialSize = 4096
		$PageFile.MaximumSize = 4096
		$PageFile.Put()
	
	}
	catch {
	
		Write-Host -ForegroundColor Red "Failed. Review the page file settings."
	
	}

}
	
else {

	Write-Host -ForegroundColor Red "Unexpected Result!"

}