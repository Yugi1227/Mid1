$ErrorActionPreference = "Continue"

$container = "exp14-html-nginx"
$image = "exp14-html-nginx"

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
  & docker rm -f $container *> $null
  Invoke-Docker build -t $image .
  Invoke-Docker run -d -p 8080:80 --name $container $image
  Invoke-Docker ps --filter "name=$container"
}
finally {
  Pop-Location
}

Write-Host "Experiment 14 is running at http://localhost:8080"
Write-Host "Stop it with: docker rm -f $container"
