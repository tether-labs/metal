#!/bin/bash
# macOS install script
INSTALL_DIR="/usr/local/bin"

# Create /usr/local/bin if it doesn't exist
sudo mkdir -p "$INSTALL_DIR"

# Copy binary
sudo cp myprogram "$INSTALL_DIR/"
sudo chmod +x "$INSTALL_DIR/fabric"

echo "fabric installed to $INSTALL_DIR"
echo "Make sure $INSTALL_DIR is in your PATH"
