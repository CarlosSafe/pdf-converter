# Quick Windows Build Guide

## 🎯 Goal: Create a Windows installer that users can download and run (no Java needed)

## ✅ Best Option: jpackage

Creates a **Windows installer (.exe)** with embedded Java - users just download, install, and run!

### Requirements
- Windows machine (or Windows VM)
- Java 17+ installed
- WiX Toolset (for installer)

### Quick Build Steps

```powershell
# 1. Open PowerShell in the Stirling-PDF directory

# 2. Set environment variables
$env:DISABLE_ADDITIONAL_FEATURES = "true"
$env:STIRLING_PDF_DESKTOP_UI = "true"
$env:BROWSER_OPEN = "true"

# 3. Build the application
.\gradlew.bat clean build -x test -x spotlessCheck

# 4. Create Windows installer (this takes a few minutes)
.\gradlew.bat jpackage
```

### Output
The installer will be created at:
```
build/jpackage/Stirling-PDF-1.6.0.exe
```

### What Users Do
1. Download `Stirling-PDF-1.6.0.exe`
2. Double-click to install
3. Run from Start Menu
4. **No Java installation needed!** ✅

---

## 📦 Alternative: launch4j (Simpler, but requires Java)

If you want a simpler build (but users need Java installed):

```powershell
# Build
.\gradlew.bat clean build -x test

# Create executable
.\gradlew.bat createExe
```

Output: `Stirling-PDF.exe` (users still need Java installed)

---

## 🔧 Installing WiX Toolset (for jpackage)

### Option 1: Chocolatey (Easiest)
```powershell
choco install wix
```

### Option 2: Manual Download
1. Download from: https://wixtoolset.org/releases/
2. Install the .exe
3. Add to PATH if needed

---

## 📝 Notes

- **jpackage** must be run on Windows (can't cross-compile from macOS/Linux)
- The installer includes everything - no dependencies needed
- File size will be ~150-200MB (includes embedded JRE)
- Users get a professional installer experience

---

## 🚀 For CI/CD (GitHub Actions)

The repository already has GitHub Actions workflows that build Windows installers automatically. Check `.github/workflows/` for examples.

