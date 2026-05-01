$ErrorActionPreference = "Stop"

function Invoke-Git {
  git @args
  if ($LASTEXITCODE -ne 0) {
    throw "Git command failed: git $args"
  }
}

$base = Join-Path $PSScriptRoot "_run"
$repo = Join-Path $base "log-demo"
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
  "Line 1" | Out-File -FilePath history.txt -Encoding utf8
  Invoke-Git add history.txt
  Invoke-Git commit -m "Add first line"
  "Line 2" | Out-File -FilePath history.txt -Append -Encoding utf8
  Invoke-Git add history.txt
  Invoke-Git commit -m "Add second line"
  "Line 3" | Out-File -FilePath history.txt -Append -Encoding utf8
  Invoke-Git add history.txt
  Invoke-Git commit -m "Add third line"
  Invoke-Git log --oneline
  $hash = git rev-parse HEAD
  Write-Host "Latest commit hash: $hash"
}
finally {
  if ((Get-Location).Path -eq $repo) {
    Pop-Location
  }
  $env:GIT_CEILING_DIRECTORIES = $previousCeiling
}

Write-Host "Experiment completed."
