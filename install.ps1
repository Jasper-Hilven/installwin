    Write-Host "Installing"

    & "$PSScriptRoot\installWinget.ps1"
    & "$PSScriptRoot\installWingetApps.ps1"
    & "$PSScriptRoot\installChoco.ps1"
    & "$PSScriptRoot\installChocoApps.ps1"
