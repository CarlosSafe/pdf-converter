#!/bin/bash
# Script to run Stirling-PDF application

export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"

cd "$(dirname "$0")"

echo "=========================================="
echo "Starting Stirling-PDF Application"
echo "=========================================="
echo ""
echo "JAR Location: app/core/build/libs/stirling-pdf-1.6.0.jar"
echo "Java Version:"
java -version
echo ""
echo "Starting application..."
echo "The application will be available at: http://localhost:8080"
echo "Press Ctrl+C to stop the application"
echo ""
echo "=========================================="
echo ""

java -jar app/core/build/libs/stirling-pdf-1.6.0.jar

