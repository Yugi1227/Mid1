$ErrorActionPreference = "Continue"

$image = "exp15-alpine-nano"

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
  Invoke-Docker build -t $image .
  Invoke-Docker run --rm $image nano --version
}
finally {
  Pop-Location
}

Write-Host "Experiment completed."
Write-Host "For interactive nano, run:"
Write-Host "docker run -it --rm $image"
