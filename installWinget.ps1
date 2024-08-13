# Define the URL for the latest App Installer .appxbundle file
$url = "https://github.com/microsoft/winget-cli/releases/latest/download/AppInstaller.appxbundle"

# Define the path to save the downloaded file
$outputPath = "$env:TEMP\AppInstaller.appxbundle"

# Download the latest App Installer .appxbundle
Invoke-WebRequest -Uri $url -OutFile $outputPath

# Install the App Installer .appxbundle
Add-AppxPackage -Path $outputPath

# Clean up
Remove-Item -Path $outputPath

# Verify installation and display the installed version of winget
winget --version