$ErrorActionPreference = "Continue"

function Invoke-Docker {
  $oldErrorActionPreference = $ErrorActionPreference
  $ErrorActionPreference = "Continue"
  & docker @args
  $code = $LASTEXITCODE
  $ErrorActionPreference = $oldErrorActionPreference
  if ($code -ne 0) {
    Write-Host "Docker command failed: docker $args"
    exit 1
  }
}

function Test-DockerReady {
  $oldErrorActionPreference = $ErrorActionPreference
  $ErrorActionPreference = "Continue"
  & docker info *> $null
  $code = $LASTEXITCODE
  $ErrorActionPreference = $oldErrorActionPreference
  if ($code -ne 0) {
    Write-Host "Docker Desktop is not running. Start Docker Desktop, wait until it is ready, then run this script again."
    exit 1
  }
}

Push-Location $PSScriptRoot
try {
  Invoke-Docker --version
  Test-DockerReady
  Invoke-Docker run --rm ubuntu:latest cat /etc/os-release
  Invoke-Docker build -t exp13-custom-image .
  Invoke-Docker run --rm exp13-custom-image
}
finally {
  Pop-Location
}

Write-Host "Experiment completed."
