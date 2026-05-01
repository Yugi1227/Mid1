$ErrorActionPreference = "Stop"

function Invoke-Git {
  git @args
  if ($LASTEXITCODE -ne 0) {
    throw "Git command failed: git $args"
  }
}

$base = Join-Path $PSScriptRoot "_run"
$source = Join-Path $base "SourceRepo"
$remote = Join-Path $base "remote.git"
$clone = Join-Path $base "ClonedRepo"
$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$previousCeiling = $env:GIT_CEILING_DIRECTORIES
$env:GIT_CEILING_DIRECTORIES = $repoRoot

if (Test-Path $base) {
  Remove-Item -LiteralPath $base -Recurse -Force
}

New-Item -ItemType Directory -Path $source | Out-Null

try {
  Push-Location $source
  Invoke-Git init
  Invoke-Git config user.name "Lab User"
  Invoke-Git config user.email "lab@example.com"
  "# Source Repository" | Out-File -FilePath README.md -Encoding utf8
  Invoke-Git add README.md
  Invoke-Git commit -m "Add README"
  Invoke-Git branch -M main
  Pop-Location

  Invoke-Git clone --bare $source $remote
  Invoke-Git clone $remote $clone

  Push-Location $clone
  Get-ChildItem
  Invoke-Git remote -v
}
finally {
  if ((Get-Location).Path -eq $clone -or (Get-Location).Path -eq $source) {
    Pop-Location
  }
  $env:GIT_CEILING_DIRECTORIES = $previousCeiling
}

Write-Host "Experiment completed."
