@echo off
REM ===========================================================================
REM  Paperclip - stop dev services cleanly on Windows
REM  Stops the dev-runner via its pidfile, then force-frees the dev ports
REM  (3100 = API/UI, 54329 = embedded PostgreSQL) in case a child orphaned.
REM ===========================================================================
setlocal
cd /d "%~dp0"

echo [Paperclip] Stopping dev services...
call pnpm dev:stop

echo [Paperclip] Checking for leftover processes on ports 3100 and 54329...
for %%P in (3100 54329) do (
  for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":%%P " ^| findstr LISTENING') do (
    echo [Paperclip] Freeing port %%P - killing leftover PID %%a
    taskkill /F /PID %%a >nul 2>&1
  )
)

echo [Paperclip] Stopped.
