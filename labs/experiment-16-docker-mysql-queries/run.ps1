$ErrorActionPreference = "Continue"

$container = "exp16-mysql"

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

Test-DockerReady
& docker rm -f $container *> $null
Invoke-Docker run --name $container -e MYSQL_ROOT_PASSWORD=root -d -p 3306:3306 mysql:latest | Out-Null

Write-Host "Waiting for MySQL to accept connections..."
$ready = $false
for ($i = 0; $i -lt 60; $i++) {
  docker exec $container mysqladmin ping -uroot -proot --silent 2>$null
  if ($LASTEXITCODE -eq 0) {
    $ready = $true
    break
  }
  Start-Sleep -Seconds 2
}

if (-not $ready) {
  Write-Host "MySQL did not become ready in time."
  exit 1
}

Get-Content -Raw -LiteralPath (Join-Path $PSScriptRoot "queries.sql") | docker exec -i $container mysql -uroot -proot
if ($LASTEXITCODE -ne 0) {
  Write-Host "Failed to execute queries.sql in $container."
  exit 1
}

Write-Host "Experiment completed."
Write-Host "Stop it with: docker rm -f $container"
