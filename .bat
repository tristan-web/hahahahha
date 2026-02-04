@echo off
setlocal

REM === CONFIG ===
set "RAW_URL=https://raw.githubusercontent.com/tristan-web/fdgg/main/game.py"
set "APPDIR=%LOCALAPPDATA%\FDGG"
set "PYFILE=%APPDIR%\game.py"
REM ==============

echo Installing FDGG...
if not exist "%APPDIR%" mkdir "%APPDIR%" >nul 2>&1

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$ProgressPreference='SilentlyContinue';" ^
  "try { Invoke-WebRequest -Uri '%RAW_URL%' -OutFile '%PYFILE%'; exit 0 } catch { exit 1 }" ^
  >nul 2>&1

if errorlevel 1 (
  echo Check your internet connection
  pause
  exit /b 1
)

REM Check for Python
python --version >nul 2>&1
if errorlevel 1 (
  echo Python is not installed (or not in PATH).
  echo Install Python from https://www.python.org/downloads/
  pause
  exit /b 1
)

echo Launching FDGG...
python "%PYFILE%"
exit /b 0
