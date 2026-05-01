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
  Test-DockerReady
  Invoke-Docker compose up -d
  Invoke-Docker compose ps
}
finally {
  Pop-Location
}

Write-Host "Experiment 17 is running at http://localhost:8081"
Write-Host "phpMyAdmin login: root / root"
