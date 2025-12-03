#!/bin/bash
# Validation script to verify proprietary code removal

echo "=== Validating Proprietary Code Removal ==="
echo ""

ERRORS=0

# Check 1: Proprietary directory should not exist
echo "✓ Checking if proprietary directory exists..."
if [ -d "app/proprietary" ]; then
    echo "  ❌ ERROR: app/proprietary directory still exists!"
    ERRORS=$((ERRORS + 1))
else
    echo "  ✅ OK: app/proprietary directory removed"
fi

# Check 2: settings.gradle should not include proprietary
echo ""
echo "✓ Checking settings.gradle..."
if grep -q "proprietary" settings.gradle 2>/dev/null; then
    echo "  ❌ ERROR: settings.gradle still references proprietary"
    ERRORS=$((ERRORS + 1))
else
    echo "  ✅ OK: settings.gradle clean"
fi

# Check 3: build.gradle should not have proprietary dependency
echo ""
echo "✓ Checking build.gradle files..."
if grep -q "project(':proprietary')" build.gradle app/core/build.gradle 2>/dev/null; then
    echo "  ❌ ERROR: build.gradle still has proprietary dependency"
    ERRORS=$((ERRORS + 1))
else
    echo "  ✅ OK: build.gradle files clean"
fi

# Check 4: No actual imports of proprietary classes (comments are OK)
echo ""
echo "✓ Checking for proprietary imports in Java files..."
IMPORT_COUNT=$(find app/core app/common -name "*.java" -exec grep -l "^import.*proprietary" {} \; 2>/dev/null | wc -l | tr -d ' ')
if [ "$IMPORT_COUNT" -gt 0 ]; then
    echo "  ❌ ERROR: Found $IMPORT_COUNT Java file(s) with proprietary imports"
    find app/core app/common -name "*.java" -exec grep -l "^import.*proprietary" {} \;
    ERRORS=$((ERRORS + 1))
else
    echo "  ✅ OK: No proprietary imports found"
fi

# Check 5: LICENSE should be pure MIT
echo ""
echo "✓ Checking LICENSE file..."
if grep -q "app/proprietary" LICENSE 2>/dev/null; then
    echo "  ❌ ERROR: LICENSE still references proprietary directory"
    ERRORS=$((ERRORS + 1))
else
    echo "  ✅ OK: LICENSE is clean"
fi

# Check 6: SPDFApplication should not scan proprietary package
echo ""
echo "✓ Checking SPDFApplication scanBasePackages..."
if grep -q '"stirling.software.proprietary"' app/core/src/main/java/stirling/software/SPDF/SPDFApplication.java 2>/dev/null; then
    echo "  ❌ ERROR: SPDFApplication still scans proprietary package"
    ERRORS=$((ERRORS + 1))
else
    echo "  ✅ OK: SPDFApplication does not scan proprietary package"
fi

# Summary
echo ""
echo "=== Validation Summary ==="
if [ $ERRORS -eq 0 ]; then
    echo "✅ All checks passed! Code is ready for MIT-only distribution."
    exit 0
else
    echo "❌ Found $ERRORS error(s). Please fix them before proceeding."
    exit 1
fi

