# Safe Rename Guide: Stirling-PDF → PDF-Converter

## ⚠️ Important: Not All References Should Be Changed!

Some references are **cosmetic** (safe to change) while others are **structural** (will break the build if changed).

---

## ✅ SAFE to Change (Cosmetic - Display Names)

These are just display names and won't affect functionality:

### In build.gradle:

```gradle
// ✅ SAFE - Display name only
appName = "PDF Converter"                    // Line ~253
appDescription = "PDF Converter - Your Local PDF Editor"  // Line ~256
vendor = "PDF Converter Inc"                  // Line ~255
copyright = "Copyright © 2025 PDF Converter Inc."  // Line ~357

// ✅ SAFE - Manifest title
attributes "Implementation-Title": "PDF-Converter",  // Line ~46

// ✅ SAFE - Installer names
winMenuGroup = "PDF Converter"               // Line ~288
installDir = "C:/Program Files/PDF-Converter"  // Line ~293
macPackageName = "PDF Converter"             // Line ~302
macPackageIdentifier = "PDF Converter"       // Line ~301
installDir = "/opt/PDF-Converter"           // Line ~332

// ✅ SAFE - Launch4j output
outfile="PDF-Converter.exe"                  // Line ~486
mutexName="PDF-Converter"                    // Line ~506
windowTitle="PDF-Converter"                  // Line ~507
messagesStartupError="An error occurred while starting PDF-Converter"  // Line ~509
messagesInstanceAlreadyExists="PDF-Converter is already running."  // Line ~513

// ✅ SAFE - JAR file name (but also update mainJar reference)
mainJar = "PDF-Converter-${project.version}.jar"  // Line ~252
```

### In settings.gradle:

```gradle
// ✅ SAFE - Root project display name
rootProject.name = 'PDF Converter'  // Line 5
```

---

## ❌ DO NOT Change (Structural - Will Break Build)

These are module names, package names, or code references:

### In build.gradle:

```gradle
// ❌ DO NOT CHANGE - Module name (must match settings.gradle)
if (project.name != "stirling-pdf") {  // Line ~99
if (name == 'stirling-pdf') {          // Line ~180
dependsOn(":stirling-pdf:bootJar")     // Line ~83, ~249
dependsOn ':stirling-pdf:bootRun'      // Line ~235, ~585
dependsOn ':stirling-pdf:bootJar'      // Line ~595
project(":stirling-pdf").tasks.bootJar // Line ~493

// ❌ DO NOT CHANGE - Java package name (would break all imports)
group = 'stirling.software'             // Line ~66
mainClass = 'stirling.software.SPDF.SPDFApplication'  // Line ~57

// ❌ DO NOT CHANGE - Environment variable (used in Java code)
"-DSTIRLING_PDF_DESKTOP_UI=true",      // Line ~264, ~406
System.getenv("STIRLING_PDF_DESKTOP_UI")  // Line ~488, ~498
variables=["BROWSER_OPEN=true", "STIRLING_PDF_DESKTOP_UI=true"]  // Line ~499
```

### In settings.gradle:

```gradle
// ❌ DO NOT CHANGE - Module name (structural)
include 'stirling-pdf', 'common'       // Line 7
project(':stirling-pdf').projectDir = file('app/core')  // Line 9
```

### In Java Code:

```java
// ❌ DO NOT CHANGE - Package names (would break all imports)
package stirling.software.SPDF;
import stirling.software.common.*;

// ❌ DO NOT CHANGE - Environment variable (used in code)
System.getProperty("STIRLING_PDF_DESKTOP_UI", "false")
```

---

## 📋 Recommended Changes

### Step 1: Update settings.gradle (Display Name Only)
```gradle
rootProject.name = 'PDF Converter'  // ✅ Safe - display name only
// Keep module name as 'stirling-pdf'  // ❌ Don't change
```

### Step 2: Update build.gradle (Cosmetic Only)

Create a script or manually change these **display names only**:

```gradle
// Display names
appName = "PDF Converter"
appDescription = "PDF Converter - Your Local PDF Editor"
vendor = "PDF Converter Inc"
copyright = "Copyright © 2025 PDF Converter Inc"

// Installer paths
installDir = "C:/Program Files/PDF-Converter"
installDir = "/opt/PDF-Converter"

// Executable names
outfile="PDF-Converter.exe"
mainJar = "PDF-Converter-${project.version}.jar"

// Menu/Window names
winMenuGroup = "PDF Converter"
mutexName="PDF-Converter"
windowTitle="PDF-Converter"
```

### Step 3: Keep Structural References

**DO NOT CHANGE:**
- Module name: `stirling-pdf`
- Package name: `stirling.software`
- Environment variable: `STIRLING_PDF_DESKTOP_UI`
- Module references: `:stirling-pdf:`

---

## 🎯 Summary

**Safe to Change:**
- ✅ Display names (appName, appDescription, vendor)
- ✅ Installer paths and menu names
- ✅ Executable file names
- ✅ Root project display name

**DO NOT Change:**
- ❌ Module names (`stirling-pdf`)
- ❌ Package names (`stirling.software`)
- ❌ Environment variables (`STIRLING_PDF_DESKTOP_UI`)
- ❌ Module references (`:stirling-pdf:`)

---

## ⚠️ Warning

If you change module names or package names, you would need to:
1. Rename the `app/core` directory structure
2. Update all Java package declarations
3. Update all imports across the codebase
4. Update settings.gradle module names
5. This is a **major refactoring** and not recommended

**Recommendation:** Only change the **display/cosmetic** names, not the structural ones.

