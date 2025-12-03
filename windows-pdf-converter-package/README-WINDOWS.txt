========================================
PDF Converter - Windows Package
========================================

This is a portable version of PDF Converter for Windows.

REQUIREMENTS:
-------------
- Windows 7 or later
- Java 17 or higher (Java 21 recommended)

If you don't have Java installed:
1. Download from: https://adoptium.net/temurin/releases/
2. Choose "Windows x64" and "JDK 21" (or JDK 17)
3. Install it
4. Restart your computer (recommended)

HOW TO RUN:
-----------
1. Double-click "run-windows.bat"
2. Wait for the application to start (takes 10-30 seconds)
3. Your browser should open automatically to http://localhost:8080
4. If browser doesn't open, manually go to: http://localhost:8080

TO STOP:
--------
- Close the command window, OR
- Press Ctrl+C in the command window

FILES INCLUDED:
---------------
- pdf-converter-1.6.0.jar    - The main application
- run-windows.bat             - Launcher script (double-click this!)
- README-WINDOWS.txt         - This file
- configs/                    - Configuration folder (created on first run)

TROUBLESHOOTING:
---------------
Problem: "Java is not recognized"
Solution: Install Java and restart your computer, or add Java to PATH

Problem: Port 8080 already in use
Solution: Close any other applications using port 8080, or change port in configs/settings.yml

Problem: Application won't start
Solution: Check that Java 17+ is installed: java -version

NOTES:
------
- This is a testing package - all proprietary code has been removed
- The application runs on port 8080 by default
- Configuration files are saved in the "configs" folder
- Logs are saved in the "logs" folder

For questions or issues, check the main README.md file.

Enjoy using PDF Converter!

