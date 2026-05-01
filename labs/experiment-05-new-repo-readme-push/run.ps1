$ErrorActionPreference = "Stop"

function Invoke-Git {
  git @args
  if ($LASTEXITCODE -ne 0) {
    throw "Git command failed: git $args"
  }
}

$base = Join-Path $PSScriptRoot "_run"
$repo = Join-Path $base "readme-project"
$remote = Join-Path $base "remote.git"
$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$previousCeiling = $env:GIT_CEILING_DIRECTORIES
$env:GIT_CEILING_DIRECTORIES = $repoRoot

if (Test-Path $base) {
  Remove-Item -LiteralPath $base -Recurse -Force
}

New-Item -ItemType Directory -Path $repo | Out-Null

try {
  Invoke-Git init --bare $remote
  Push-Location $repo
  Invoke-Git init
  Invoke-Git config user.name "Lab User"
  Invoke-Git config user.email "lab@example.com"
  "# My New Repository" | Out-File -FilePath README.md -Encoding utf8
  Invoke-Git add README.md
  Invoke-Git commit -m "Initial commit: add README"
  Invoke-Git remote add origin $remote
  Invoke-Git branch -M main
  Invoke-Git push -u origin main
  Invoke-Git status --short --branch
}
finally {
  if ((Get-Location).Path -eq $repo) {
    Pop-Location
  }
  $env:GIT_CEILING_DIRECTORIES = $previousCeiling
}

Write-Host "Experiment completed."
