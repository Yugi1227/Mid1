$ErrorActionPreference = "Stop"

function Invoke-Git {
  git @args
  if ($LASTEXITCODE -ne 0) {
    throw "Git command failed: git $args"
  }
}

$base = Join-Path $PSScriptRoot "_run"
$repo = Join-Path $base "branch-demo"
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
  "Main branch file" | Out-File -FilePath notes.txt -Encoding utf8
  Invoke-Git add notes.txt
  Invoke-Git commit -m "Initial commit"
  Invoke-Git branch -M main
  Invoke-Git checkout -b MITS
  "Change from MITS branch" | Out-File -FilePath notes.txt -Append -Encoding utf8
  Invoke-Git add notes.txt
  Invoke-Git commit -m "Update notes from MITS branch"
  Invoke-Git checkout main
  Invoke-Git merge MITS
  Invoke-Git log --oneline --graph --all
}
finally {
  if ((Get-Location).Path -eq $repo) {
    Pop-Location
  }
  $env:GIT_CEILING_DIRECTORIES = $previousCeiling
}

Write-Host "Experiment completed."
