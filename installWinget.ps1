# Check if winget is installed
if (!(Get-Command "winget" -ErrorAction SilentlyContinue)) {
    Write-Host "winget is not installed. Attempting to install it."

    # Define the URL for the App Installer package from Microsoft
    $appInstallerUrl = "https://aka.ms/getwinget"

    # Download the App Installer
    $downloadPath = "$env:TEMP\AppInstaller.zip"
    Invoke-WebRequest -Uri $appInstallerUrl -OutFile $downloadPath

    # Extract the zip file to a temporary directory
    $extractPath = "$env:TEMP\AppInstaller"
    Expand-Archive -Path $downloadPath -DestinationPath $extractPath -Force

    # Install the App Installer package
    $appInstallerFile = Get-ChildItem -Path $extractPath -Filter "*.msixbundle" -Recurse | Select-Object -First 1
    if ($appInstallerFile) {
        Add-AppxPackage -Path $appInstallerFile.FullName
        Write-Host "winget (App Installer) has been installed successfully."
    } else {
        Write-Host "Failed to find the App Installer package."
    }

    # Clean up temporary files
    Remove-Item -Path $downloadPath -Force
    Remove-Item -Path $extractPath -Recurse -Force
} else {
    Write-Host "winget is already installed."
}

winget source add -n winget2 -a https://cdn.winget.microsoft.com/cache

winget upgrade --id Microsoft.Winget.Source
