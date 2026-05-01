$ErrorActionPreference = "Stop"

function Ensure-Selenium {
  python -c "import selenium" 2>$null
  if ($LASTEXITCODE -ne 0) {
    python -m pip install -r ..\requirements.txt
    if ($LASTEXITCODE -ne 0) {
      throw "Selenium is not installed and automatic install failed. Run: python -m pip install -r ..\requirements.txt"
    }
  }
}

Push-Location $PSScriptRoot
try {
  Ensure-Selenium
  python .\inspect_google_element.py
  if ($LASTEXITCODE -ne 0) {
    Write-Host "Experiment 10 failed."
    exit 1
  }
}
finally {
  Pop-Location
}
