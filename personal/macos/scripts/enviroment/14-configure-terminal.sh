#!/usr/bin/env bash

set -e

echo "=============================================="
echo "===== [15] CONFIGURE iTERM2 TERMINAL ========="
echo "=============================================="

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
  echo "❌ Homebrew is required. Please install it first."
  exit 1
fi

# Check if iTerm2 is installed
ITerm2_INSTALLED=false
if [ -d "/Applications/iTerm.app" ]; then
  ITerm2_INSTALLED=true
  echo "✓ iTerm2 is already installed"
elif brew list --cask iterm2 &> /dev/null 2>&1; then
  ITerm2_INSTALLED=true
  echo "✓ iTerm2 is installed via Homebrew"
fi

# Install iTerm2 if not installed
if [ "$ITerm2_INSTALLED" = false ]; then
  echo "Installing iTerm2..."
  brew install --cask iterm2
  echo "✓ iTerm2 installed"
fi

echo ""
echo "Downloading Catppuccin Mocha theme for iTerm2..."

# Create directory for themes
THEMES_DIR="$HOME/.iterm2-themes"
mkdir -p "$THEMES_DIR"

# Download Catppuccin Mocha theme
CATPPUCCIN_FILE="$THEMES_DIR/catppuccin-mocha.itermcolors"
if [ ! -f "$CATPPUCCIN_FILE" ]; then
  echo "Downloading Catppuccin Mocha theme..."
  curl -fsSL https://raw.githubusercontent.com/catppuccin/iterm/main/colors/catppuccin-mocha.itermcolors -o "$CATPPUCCIN_FILE"
  echo "✓ Catppuccin Mocha theme downloaded"
else
  echo "✓ Catppuccin Mocha theme already exists"
fi

echo ""
echo "=============================================="
echo "📝 MANUAL CONFIGURATION REQUIRED"
echo "=============================================="
echo ""
echo "Please follow these steps to configure iTerm2:"
echo ""
echo "1. Open iTerm2 → Preferences (⌘,)"
echo ""
echo "2. Go to Profiles tab"
echo ""
echo "3. Select your profile (or create a new one named 'rubinho')"
echo ""
echo "4. In the Text tab:"
echo "   • Click 'Change Font'"
echo "   • Select 'JetBrainsMono Nerd Font'"
echo "   • Set size to 16"
echo ""
echo "5. In the Colors tab:"
echo "   • Click 'Color Presets...' (bottom right)"
echo "   • Click 'Import...'"
echo "   • Navigate to: $CATPPUCCIN_FILE"
echo "   • Select the file and click 'Open'"
echo "   • Click 'Color Presets...' again"
echo "   • Select 'catppuccin-mocha' from the list"
echo ""
echo "6. Click 'Other Actions...' (at the bottom)"
echo "   • Select 'Set as Default'"
echo ""
echo "7. Close Preferences and restart iTerm2 (⌘Q)"
echo ""
echo "=============================================="
echo "============== [15] DONE ===================="
echo "=============================================="
echo ""
echo "🎉 INSTALLATION COMPLETE!"
echo "=============================================="
echo "All scripts have been executed successfully!"
echo "Restart the terminal to apply all changes."

