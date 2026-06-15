@echo off
REM ===========================================================================
REM  Paperclip - start dev services (API + UI) on Windows
REM  Double-click this file, or run "start.bat" from a terminal.
REM  This window becomes the live server console. Use stop.bat to stop cleanly.
REM ===========================================================================
setlocal
cd /d "%~dp0"

where pnpm >nul 2>&1
if errorlevel 1 (
  echo [Paperclip] pnpm not found on PATH - enabling via corepack...
  call corepack enable
  call corepack prepare pnpm@9.15.4 --activate
)

echo [Paperclip] Starting dev services (API + UI) at http://127.0.0.1:3100
echo [Paperclip] Keep this window open. Run stop.bat (in another terminal) to stop cleanly.
echo.

call pnpm dev

REM If pnpm dev exits (Ctrl-C or error), pause so the window stays readable.
echo.
echo [Paperclip] Dev process exited. Run stop.bat to clean up any leftover services.
pause
