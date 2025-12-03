@echo off
REM PDF Converter Windows Launcher
REM This script runs PDF Converter on Windows

echo ========================================
echo PDF Converter - Starting Application
echo ========================================
echo.

REM Check if Java is installed
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Java is not installed or not in PATH
    echo.
    echo Please install Java 17 or higher from:
    echo https://adoptium.net/temurin/releases/
    echo.
    echo After installing Java, restart this script.
    pause
    exit /b 1
)

echo Java found! Starting PDF Converter...
echo.
echo The application will open in your browser at: http://localhost:8080
echo.
echo Press Ctrl+C to stop the application
echo ========================================
echo.

REM Run the application
java -jar "pdf-converter-1.6.0.jar" --spring.profiles.active=default

pause

