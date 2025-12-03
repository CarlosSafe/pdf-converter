# Build and Test Instructions

## Prerequisites
- Java 17 or higher (Java 21 recommended)
- Gradle (or use the included Gradle wrapper)

## Quick Build Test

To verify the application builds correctly after removing proprietary code:

```bash
# Clean and build (skip tests for faster verification)
./gradlew clean build -x test -x spotlessCheck --no-daemon

# Or just compile without running tests
./gradlew compileJava --no-daemon
```

## Run the Application

```bash
# Build the application
./gradlew bootJar --no-daemon

# Run the application
java -jar app/core/build/libs/Stirling-PDF-*.jar
```

Or use Gradle to run directly:
```bash
./gradlew bootRun --no-daemon
```

## Expected Behavior

After removing proprietary code:
- ✅ Application should start with "default" profile (not "security" profile)
- ✅ No errors about missing proprietary classes
- ✅ Core PDF functionality should work
- ❌ Security features (login, authentication, etc.) will not be available
- ❌ Admin endpoints will not be available

## Verification Checklist

- [ ] Application compiles without errors
- [ ] Application starts successfully
- [ ] Web UI is accessible (default: http://localhost:8080)
- [ ] Core PDF operations work (merge, split, convert, etc.)
- [ ] No references to proprietary classes in runtime logs

## Troubleshooting

If you encounter errors:

1. **Missing class errors**: Check that all proprietary imports have been removed
2. **Build errors**: Verify `settings.gradle` and `build.gradle` don't reference proprietary module
3. **Runtime errors**: Check that `SPDFApplication` uses "default" profile

## Notes

- The `isClassPresent()` method in `SPDFApplication.java` is kept for backwards compatibility but will always return false for SecurityConfiguration
- The `isSecurityDisabled()` function in root `build.gradle` always returns true now
- All proprietary security features have been removed - implement MIT-compliant alternatives if needed

