param([int]$Port = 8766)
$ErrorActionPreference = 'Stop'
$ProjectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location -LiteralPath $ProjectRoot
$PythonExe = Join-Path $ProjectRoot '.venv\Scripts\python.exe'
if (-not (Test-Path -LiteralPath $PythonExe)) { throw 'Create .venv and install requirements.txt first.' }
if (-not (Test-Path -LiteralPath 'config.toml')) { Copy-Item -LiteralPath 'config.example.toml' -Destination 'config.toml' }
if (Get-NetTCPConnection -LocalPort $Port -State Listen -ErrorAction SilentlyContinue) { throw "Port $Port is occupied. Choose -Port with a free port." }
# The mitm capture posts tokens back to this port; keep it in step with -Port.
$env:SUSTECH_APP_PORT = "$Port"
Write-Host "http://127.0.0.1:$Port"
& $PythonExe -m uvicorn app:app --host 127.0.0.1 --port $Port
