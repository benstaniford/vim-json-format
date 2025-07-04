#!/bin/bash

# vim-json-format installation script

echo "Installing vim-json-format plugin..."

# Check if Python3 is available in Vim
vim --version | grep -q '+python3'
if [ $? -eq 0 ]; then
    echo "✓ Python3 support detected in Vim"
else
    echo "✗ Warning: Python3 support not detected in Vim"
    echo "  This plugin requires Vim with Python3 support"
fi

# Check Vim version
VIM_VERSION=$(vim --version | head -n 1 | grep -o '[0-9]\+\.[0-9]\+')
echo "Detected Vim version: $VIM_VERSION"

# Create help tags
echo "Generating help tags..."
vim -c "helptags doc/" -c "quit"

echo "Installation complete!"
echo ""
echo "Usage:"
echo "  - Open any .json file to see automatic formatting"
echo "  - Use :JsonFormat to manually format"
echo "  - Use :JsonFormatToggle to toggle auto-formatting"
echo "  - See :help vim-json-format for full documentation"
