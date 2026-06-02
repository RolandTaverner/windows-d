# Get the https://github.com/microsoft/win32metadata

error "DoAll.ps1 cannot be loaded because running scripts is disabled on this system"

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser


error "The script 'DoAll.ps1' cannot be run because it contained a "#requires" statement for Windows PowerShell 7.0"
Install PowerShell 7
winget search --id Microsoft.PowerShell --exact
winget install --id Microsoft.PowerShell --source winget


Install required components
.\scripts\Install-VS.ps1
winget install Microsoft.DotNet.SDK.8

run
.\DoAll.ps1

# windows-d

git config --global core.longpaths true
git submodule update --init --recursive

