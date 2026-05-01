$ErrorActionPreference = "Stop"

$base = Join-Path $PSScriptRoot "_run"
$classes = Join-Path $base "classes"
$mainJava = Join-Path $PSScriptRoot "sample-app\src\main\java\Calculator.java"
$testJava = Join-Path $PSScriptRoot "sample-app\src\test\java\TestCalculator.java"

if (Test-Path $base) {
  Remove-Item -LiteralPath $base -Recurse -Force
}
New-Item -ItemType Directory -Path $classes | Out-Null

javac -d $classes $mainJava $testJava
if ($LASTEXITCODE -ne 0) {
  Write-Host "Java compilation failed. Make sure JDK is installed and javac is available."
  exit 1
}

java -cp $classes TestCalculator
if ($LASTEXITCODE -ne 0) {
  Write-Host "Continuous testing failed."
  exit 1
}

Write-Host "Experiment completed."
