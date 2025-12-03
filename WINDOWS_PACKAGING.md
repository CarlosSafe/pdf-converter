# Windows Packaging Guide

This guide explains how to create a Windows installer/executable that users can download and run without installing Java or building anything.

## 🎯 Two Packaging Options

### Option 1: jpackage (Recommended) ⭐
Creates a **Windows installer (.exe)** with embedded JRE - users don't need Java installed!

### Option 2: launch4j
Creates a simple **.exe wrapper** - requires users to have Java installed.

---

## 📦 Option 1: jpackage - Full Installer (Best for Distribution)

### What It Creates
- Windows installer (.exe) file
- Includes embedded Java Runtime (JRE)
- Users can install like any Windows application
- Creates Start Menu entry and desktop shortcut
- No Java installation required for end users

### Requirements
- **Windows machine** (or Windows VM/CI)
- Java 17+ installed
- WiX Toolset (for installer creation)

### Build Steps

#### On Windows:

```powershell
# 1. Install WiX Toolset (if not already installed)
# Download from: https://wixtoolset.org/releases/
# Or use Chocolatey: choco install wix

# 2. Set environment variables
$env:DISABLE_ADDITIONAL_FEATURES = "true"
$env:STIRLING_PDF_DESKTOP_UI = "true"
$env:BROWSER_OPEN = "true"

# 3. Build the application
.\gradlew.bat clean build -x test

# 4. Create Windows installer
.\gradlew.bat jpackage
```

#### Output Location
```
build/jpackage/Stirling-PDF-1.6.0.exe
```

### What Users Get
1. Download the `.exe` file
2. Double-click to install
3. Application installed to `C:\Program Files\Stirling-PDF`
4. Start Menu entry created
5. Desktop shortcut (optional)
6. Run from Start Menu - no Java needed!

---

## 📦 Option 2: launch4j - Simple Executable Wrapper

### What It Creates
- Simple `.exe` file that wraps the JAR
- Requires Java 17+ to be installed on user's machine
- Smaller file size
- Faster to create

### Requirements
- Java 17+ installed
- launch4j plugin (already configured)

### Build Steps

```powershell
# 1. Build the application
.\gradlew.bat clean build -x test

# 2. Create executable
.\gradlew.bat createExe
```

#### Output Location
```
Stirling-PDF.exe
```

### What Users Get
1. Download `Stirling-PDF.exe` and the JAR file
2. Ensure Java 17+ is installed
3. Double-click `Stirling-PDF.exe` to run
4. If Java not found, shows helpful error with download link

---

## 🚀 Quick Start - Build on Windows

### Prerequisites Check
```powershell
# Check Java version
java -version

# Check Gradle
.\gradlew.bat --version
```

### Complete Build Process (jpackage)

```powershell
# Navigate to project directory
cd Stirling-PDF

# Set environment variables
$env:DISABLE_ADDITIONAL_FEATURES = "true"
$env:STIRLING_PDF_DESKTOP_UI = "true"
$env:BROWSER_OPEN = "true"

# Clean and build
.\gradlew.bat clean build -x test -x spotlessCheck

# Create Windows installer
.\gradlew.bat jpackage

# The installer will be at:
# build/jpackage/Stirling-PDF-1.6.0.exe
```

### Complete Build Process (launch4j)

```powershell
# Navigate to project directory
cd Stirling-PDF

# Build
.\gradlew.bat clean build -x test

# Create executable
.\gradlew.bat createExe

# The executable will be at:
# Stirling-PDF.exe
```

---

## 📋 Configuration Details

### jpackage Configuration
Located in `build.gradle`:
- **Install Directory**: `C:\Program Files\Stirling-PDF`
- **Start Menu Group**: "Stirling PDF"
- **Desktop Shortcut**: Optional (user choice)
- **Icon**: Uses favicon.ico
- **Version**: From project version (1.6.0)

### launch4j Configuration
Located in `build.gradle`:
- **Output**: `Stirling-PDF.exe`
- **Min Java Version**: 17
- **Icon**: Uses favicon.ico
- **Single Instance**: Yes (prevents multiple instances)

---

## 🔧 Building on macOS/Linux for Windows

You can cross-compile for Windows, but it's easier on Windows. However, if needed:

### Using Docker (Recommended for cross-platform)

```bash
# Build in Windows container
docker run --rm -v "$PWD":/workspace -w /workspace \
  mcr.microsoft.com/windows/servercore:ltsc2022 \
  powershell -Command ".\gradlew.bat jpackage"
```

### Using GitHub Actions
The repository has GitHub Actions workflows that automatically build Windows installers. Check `.github/workflows/` directory.

---

## 📦 Distribution Package Contents

### jpackage Installer Includes:
- ✅ Application JAR
- ✅ Embedded Java Runtime (JRE)
- ✅ All dependencies
- ✅ Configuration files
- ✅ Installer/uninstaller

### launch4j Package Includes:
- ✅ `Stirling-PDF.exe`
- ✅ `stirling-pdf-1.6.0.jar` (from `app/core/build/libs/`)
- ⚠️ User must have Java installed

---

## 🎯 Recommendation

**For end users who want "download and run":**
→ Use **jpackage** (Option 1)
- No Java installation needed
- Professional installer experience
- Better user experience

**For developers or users with Java already installed:**
→ Use **launch4j** (Option 2)
- Smaller download
- Faster to create
- Simpler distribution

---

## 🐛 Troubleshooting

### jpackage Issues

**Error: WiX Toolset not found**
```powershell
# Install WiX Toolset
choco install wix
# Or download from: https://wixtoolset.org/releases/
```

**Error: Java not found**
```powershell
# Set JAVA_HOME
$env:JAVA_HOME = "C:\Program Files\Java\jdk-21"
```

### launch4j Issues

**Error: JAR not found**
- Ensure you've run `.\gradlew.bat build` first
- Check that JAR exists in `app/core/build/libs/`

---

## 📝 Notes

- The build process removes proprietary code automatically (MIT-compliant)
- The installer includes all necessary dependencies
- Users don't need to configure anything - just install and run
- The application will be available at `http://localhost:8080` after installation

