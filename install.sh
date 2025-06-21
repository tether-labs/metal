#!/bin/bash
set -e

# macOS install script for fabric-cli
INSTALL_DIR="/usr/local/bin"
REPO="vic-Rokx/fabric-cli"
VERSION="v1.0.0"
TARBALL="fabric-1.0.0-darwin-arm64.tar.gz"
BINARY_NAME="fabric"

echo "Installing fabric-cli..."

# Check if running on Apple Silicon
if [[ $(uname -m) != "arm64" ]]; then
    echo "Error: This installer is for Apple Silicon Macs only"
    exit 1
fi

# Download the release tarball (not source code)
curl -L -o /tmp/$TARBALL https://github.com/$REPO/releases/download/$VERSION/$TARBALL

cd /tmp
tar -xzf $TARBALL

# Navigate to extracted directory and copy binary
cd fabric-1.0.0-darwin-arm64
sudo cp bin/$BINARY_NAME $INSTALL_DIR/
sudo chmod +x $INSTALL_DIR/$BINARY_NAME

# Cleanup
rm -rf /tmp/$TARBALL /tmp/fabric-1.0.0-darwin-arm64

echo "fabric installed successfully!"
echo "You can now run: fabric"
