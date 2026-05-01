$ErrorActionPreference = "Stop"

function Invoke-Git {
  git @args
  if ($LASTEXITCODE -ne 0) {
    throw "Git command failed: git $args"
  }
}

$base = Join-Path $PSScriptRoot "_run"
$repo = Join-Path $base "basic-git-demo"
$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$previousCeiling = $env:GIT_CEILING_DIRECTORIES
$env:GIT_CEILING_DIRECTORIES = $repoRoot

if (Test-Path $base) {
  Remove-Item -LiteralPath $base -Recurse -Force
}

New-Item -ItemType Directory -Path $repo | Out-Null

try {
  Push-Location $repo
  Invoke-Git init
  Invoke-Git config user.name "Lab User"
  Invoke-Git config user.email "lab@example.com"
  "# Basic Git Demo" | Out-File -FilePath README.md -Encoding utf8
  Invoke-Git status --short
  Invoke-Git add README.md
  Invoke-Git commit -m "Add README"
  Invoke-Git branch
  Invoke-Git log --oneline
  Invoke-Git remote -v
}
finally {
  if ((Get-Location).Path -eq $repo) {
    Pop-Location
  }
  $env:GIT_CEILING_DIRECTORIES = $previousCeiling
}

Write-Host "Experiment completed."
