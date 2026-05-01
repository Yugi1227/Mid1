$ErrorActionPreference = "Stop"

function Show-Board($board, $title) {
  Write-Host ""
  Write-Host $title
  Write-Host "----------------"
  foreach ($column in $board.PSObject.Properties) {
    Write-Host "[$($column.Name)]"
    foreach ($task in $column.Value) {
      Write-Host " - $task"
    }
  }
}

$base = Join-Path $PSScriptRoot "_run"
if (Test-Path $base) {
  Remove-Item -LiteralPath $base -Recurse -Force
}
New-Item -ItemType Directory -Path $base | Out-Null

$board = Get-Content -Raw -LiteralPath (Join-Path $PSScriptRoot "board.json") | ConvertFrom-Json
Show-Board $board "Initial Kanban Board"

$task = $board.'To Do'[0]
$board.'To Do' = @($board.'To Do' | Where-Object { $_ -ne $task })
$board.'In Progress' = @($board.'In Progress') + $task

Show-Board $board "Updated Kanban Board"
$board | ConvertTo-Json -Depth 5 | Out-File -FilePath (Join-Path $base "kanban-board.json") -Encoding utf8

Write-Host ""
Write-Host "Experiment completed."
