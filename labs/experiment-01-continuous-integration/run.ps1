$ErrorActionPreference = "Stop"

function Invoke-Git {
  git @args
  if ($LASTEXITCODE -ne 0) {
    throw "Git command failed: git $args"
  }
}

$base = Join-Path $PSScriptRoot "_run"
$project = Join-Path $base "ci-lab-demo"
$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$previousCeiling = $env:GIT_CEILING_DIRECTORIES
$previousPythonNoBytecode = $env:PYTHONDONTWRITEBYTECODE
$env:GIT_CEILING_DIRECTORIES = $repoRoot

if (Test-Path $base) {
  Remove-Item -LiteralPath $base -Recurse -Force
}

New-Item -ItemType Directory -Force -Path (Join-Path $project ".github\workflows") | Out-Null
Copy-Item -LiteralPath (Join-Path $PSScriptRoot "app.py") -Destination $project
Copy-Item -LiteralPath (Join-Path $PSScriptRoot "test_app.py") -Destination $project
Copy-Item -LiteralPath (Join-Path $PSScriptRoot ".github\workflows\ci-pipeline.yml") -Destination (Join-Path $project ".github\workflows")

try {
  Push-Location $project
  $env:PYTHONDONTWRITEBYTECODE = "1"
  python test_app.py
  if ($LASTEXITCODE -ne 0) {
    throw "Python test failed."
  }
  $env:PYTHONDONTWRITEBYTECODE = $previousPythonNoBytecode

  Invoke-Git init
  Invoke-Git config user.name "Lab User"
  Invoke-Git config user.email "lab@example.com"
  Invoke-Git add .
  Invoke-Git commit -m "Add CI pipeline demo"
  Invoke-Git branch -M main
  Invoke-Git log --oneline
}
finally {
  if ((Get-Location).Path -eq $project) {
    Pop-Location
  }
  if ($null -ne $previousPythonNoBytecode) {
    $env:PYTHONDONTWRITEBYTECODE = $previousPythonNoBytecode
  }
  $env:GIT_CEILING_DIRECTORIES = $previousCeiling
}

Write-Host "Experiment completed."
