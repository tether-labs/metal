#!/bin/bash
set -e

# macOS install script for fabric-cli
INSTALL_DIR="/usr/local/bin"
REPO="vic-Rokx/fabric-cli"
VERSION="v1.0.2"
TARBALL="fabric-1.0.2-darwin-arm64.tar.gz"
BINARY_NAME="fabric"

echo "Installing fabric-cli..."

# Check if running on Apple Silicon
if [[ $(uname -m) != "arm64" ]]; then
    echo "Error: This installer is for Apple Silicon Macs only"
    exit 1
fi

# Download the release tarball with error checking
echo "Downloading $TARBALL..."
if ! curl -L -o /tmp/$TARBALL https://github.com/$REPO/releases/download/$VERSION/$TARBALL; then
    echo "Error: Failed to download release tarball"
    echo "Make sure the release asset exists at: https://github.com/$REPO/releases/tag/$VERSION"
    exit 1
fi

# Check if download was successful (file size > 100 bytes)
if [[ $(stat -f%z /tmp/$TARBALL 2>/dev/null || echo 0) -lt 100 ]]; then
    echo "Error: Downloaded file is too small (likely an error page)"
    echo "Check if the release asset exists: https://github.com/$REPO/releases/tag/$VERSION"
    rm -f /tmp/$TARBALL
    exit 1
fi

cd /tmp
tar -xzf $TARBALL

# Copy binary from the extracted structure
sudo cp fabric-1.0.2-darwin-arm64/bin/$BINARY_NAME $INSTALL_DIR/
sudo chmod +x $INSTALL_DIR/$BINARY_NAME

# Cleanup
rm -rf /tmp/$TARBALL /tmp/fabric-1.0.2-darwin-arm64

echo "fabric installed successfully!"
echo "You can now run: fabric"
