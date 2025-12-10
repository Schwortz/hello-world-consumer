#!/bin/bash
# Setup script for hello-world-consumer project

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Devpi configuration
DEVPI_HOST="localhost:3141"
DEVPI_INDEX="root/public"
DEVPI_USERNAME="${DEVPI_USERNAME:-consumer}"
DEVPI_PASSWORD="${DEVPI_PASSWORD:-consumer123}"
# URL with authentication
DEVPI_URL="http://${DEVPI_USERNAME}:${DEVPI_PASSWORD}@${DEVPI_HOST}/${DEVPI_INDEX}/+simple/"

echo "Setting up hello-world-consumer project..."
echo ""

# Check if devpi server is accessible
echo "Checking devpi server..."
if ! curl -s "http://localhost:3141/" > /dev/null 2>&1; then
    echo "ERROR: Devpi server is not accessible at http://localhost:3141"
    echo "Please make sure the devpi server is running:"
    echo "  cd ../devpi && docker compose up -d"
    exit 1
fi
echo "✓ Devpi server is accessible"
echo ""

# Install the package from private repo (using extra-index-url to allow PyPI fallback for dependencies)
echo "Installing hello-world-test-private-repo from private devpi server..."
python3 -m pip install --extra-index-url "$DEVPI_URL" hello-world-test-private-repo
echo "✓ Package installed successfully"
echo ""

# Run the application
echo "Running the application..."
echo ""
python3 main.py

