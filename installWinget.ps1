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

winget source remove msstore
winget source add -n msstore -a https://storeedgefd.dsx.mp.microsoft.com/v9.0
winget source remove winget
winget source add -n winget -a https://cdn.winget.microsoft.com/cache
winget source list
