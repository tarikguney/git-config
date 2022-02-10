param(
    # Email that will be used in git commits
    [Parameter(Mandatory=$true)][Alias("e")][string]
    $Email,
    # Name that will be used in git commits.
    [Parameter(Mandatory=$true)][Alias("n")][string]
    $Name)

$currentOS = [System.Environment]::OSVersion.Platform

$gitConfigFilePath = ""
if ($currentOs -eq "Unix")
{
    $gitConfigFilePath = "$env:HOME/.gitconfig"
}
elseif($currentOS -eq "Win32NT")
{
    $gitConfigFilePath = "$env:HOMEPATH/.gitconfig"
}

if ((Test-Path $gitConfigFilePath) -eq $true)
{
    Write-Host "Git config file is found at $gitConfigFilePath" -ForegroundColor Yellow
}
else
{
    Write-Host "Git config file could not be found at $gitConfigFilePath" -ForegroundColor Red
    Write-Host "Terminating the operation" -ForegroundColor Red
    return
}

$gitConfigContent = Get-Content git-config

$gitConfigContent = $gitConfigContent -replace "<email>", $Email -replace "<name>", $Name

Add-Content -Path $gitConfigFilePath -Value $gitConfigContent

Write-Host "The git config has been updated" -ForegroundColor Green