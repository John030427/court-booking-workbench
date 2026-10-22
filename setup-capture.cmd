@echo off
chcp 65001 >nul
cd /d "%~dp0"
if not exist ".venv\Scripts\python.exe" (
  echo [!] .venv not found. Set up the workbench environment first, then start it with run-local.ps1.
  pause
  exit /b 1
)
".venv\Scripts\python.exe" scripts\capture_setup.py %*
pause
