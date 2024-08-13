    Write-Host "Installing"

    & "$PSScriptRoot\installChoco.ps1"
    & "$PSScriptRoot\installWinget.ps1"
    & "$PSScriptRoot\installWingetApps.ps1"