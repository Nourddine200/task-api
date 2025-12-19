@echo off
REM Test script for Task API (Windows)
REM Usage: test-api.bat [base-url]
REM Example: test-api.bat https://nour-tasks.Nourddine200.replit.app
REM Example with insecure: test-api.bat -k https://workspace.Nourddine200.replit.app

setlocal enabledelayedexpansion

set "BASE_URL=%~2"
set "USE_INSECURE=%~1"
set "CURL_FLAGS="

REM If first argument is -k, use insecure flag
if "%1"=="-k" (
    set "CURL_FLAGS=-k"
    set "BASE_URL=%~2"
) else (
    set "BASE_URL=%~1"
)

if "%BASE_URL%"=="" set "BASE_URL=http://localhost:8080"

echo ==========================================
echo Testing Task API
echo ==========================================
echo Base URL: %BASE_URL%
echo Curl flags: %CURL_FLAGS%
echo.

REM Test 1: GET / (Welcome message)
echo Test 1: GET / (Welcome message)
curl -s %CURL_FLAGS% "%BASE_URL%/"
if %errorlevel% equ 0 (
    echo [SUCCESS]
) else (
    echo [FAILED]
)
echo.

REM Test 2: GET /tasks (Get all tasks)
echo Test 2: GET /tasks (Get all tasks)
curl -s %CURL_FLAGS% "%BASE_URL%/tasks"
if %errorlevel% equ 0 (
    echo [SUCCESS]
) else (
    echo [FAILED]
)
echo.

REM Test 3: POST /tasks (Create task)
echo Test 3: POST /tasks (Create new task)
for /f "tokens=*" %%i in ('curl -s %CURL_FLAGS% -X POST "%BASE_URL%/tasks" -H "Content-Type: application/json" -d "{\"title\": \"Test Task\"}"') do set "RESPONSE=%%i"
echo !RESPONSE!
if %errorlevel% equ 0 (
    echo [SUCCESS]
    REM Extract task ID (simple extraction)
    for /f "tokens=2 delims=:}" %%a in ("!RESPONSE!") do (
        for /f "tokens=1 delims=," %%b in ("%%a") do set "TASK_ID=%%b"
    )
) else (
    echo [FAILED]
    set "TASK_ID="
)
echo.

REM Test 4: PUT /tasks/:id (Update task)
if defined TASK_ID (
    echo Test 4: PUT /tasks/!TASK_ID! (Update task)
    curl -s %CURL_FLAGS% -X PUT "%BASE_URL%/tasks/!TASK_ID!" -H "Content-Type: application/json" -d "{\"title\": \"Updated Task\", \"completed\": true}"
    if %errorlevel% equ 0 (
        echo [SUCCESS]
    ) else (
        echo [FAILED]
    )
    echo.
    
    REM Test 5: DELETE /tasks/:id (Delete task)
    echo Test 5: DELETE /tasks/!TASK_ID! (Delete task)
    curl -s %CURL_FLAGS% -X DELETE "%BASE_URL%/tasks/!TASK_ID!"
    if %errorlevel% equ 0 (
        echo [SUCCESS]
    ) else (
        echo [FAILED]
    )
    echo.
) else (
    echo [SKIP] PUT and DELETE tests (no task ID available)
    echo.
)

echo ==========================================
echo Testing complete!
echo ==========================================

endlocal
