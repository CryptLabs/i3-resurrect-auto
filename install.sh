#!/bin/bash

# i3-resurrect-auto installer
# https://github.com/YOUR_USERNAME/i3-resurrect-auto

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="$HOME/.config/i3/scripts"
PROFILE_DIR="$HOME/.i3/i3-resurrect/profiles"

echo "Installing i3-resurrect-auto..."

# Check for i3-resurrect
if ! command -v i3-resurrect &> /dev/null; then
    echo "Warning: i3-resurrect is not installed."
    echo "Install it with: pip install i3-resurrect"
    echo "Or on Arch: yay -S i3-resurrect"
    echo ""
fi

# Check for rofi
if ! command -v rofi &> /dev/null; then
    echo "Warning: rofi is not installed."
    echo "The rofi menu script will not work without it."
    echo ""
fi

# Create directories
echo "Creating directories..."
mkdir -p "$INSTALL_DIR"
mkdir -p "$PROFILE_DIR"

# Copy scripts
echo "Copying scripts to $INSTALL_DIR..."
cp "$SCRIPT_DIR/scripts/"*.sh "$INSTALL_DIR/"

# Make scripts executable
echo "Making scripts executable..."
chmod +x "$INSTALL_DIR/"*.sh

echo ""
echo "Installation complete!"
echo ""
echo "Next steps:"
echo ""
echo "1. Edit the workspace mapping in:"
echo "   $INSTALL_DIR/config.sh"
echo ""
echo "2. Add to your ~/.config/i3/config:"
echo ""
echo "   # Restore workspaces on startup"
echo "   exec --no-startup-id $INSTALL_DIR/restore-workspaces.sh"
echo ""
echo "   # Optional: keybinding for rofi menu"
echo "   bindsym \$mod+Shift+r exec --no-startup-id $INSTALL_DIR/i3-resurrect-rofi.sh"
echo ""
echo "   # Alternative: simple rofi menu (individual profiles only)"
echo "   # bindsym \$mod+Shift+r exec --no-startup-id $INSTALL_DIR/i3-resurrect-rofi-simple.sh"
echo ""
echo "3. Integrate save script with your power menu by adding:"
echo "   $INSTALL_DIR/save-workspaces.sh"
echo "   before shutdown/reboot/logout commands."
echo ""
echo "4. Reload i3: i3-msg reload"
echo ""
echo "5. Save your current workspaces:"
echo "   $INSTALL_DIR/save-workspaces.sh"
