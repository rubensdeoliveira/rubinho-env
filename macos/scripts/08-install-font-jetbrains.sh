#!/usr/bin/env bash

set -e

echo "=============================================="
echo "========= [08] INSTALLING JETBRAINS FONT ====="
echo "=============================================="

# Install required packages via Homebrew
if ! command -v brew &> /dev/null; then
  echo "❌ Homebrew is required. Please install it first."
  exit 1
fi

if ! command -v wget &> /dev/null; then
  echo "Installing wget..."
  brew install wget
fi

FONT_DIR="$HOME/Library/Fonts"
mkdir -p "$FONT_DIR"

echo "Downloading JetBrainsMono Nerd Font..."
cd /tmp
wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip

echo "Extracting font..."
unzip -o JetBrainsMono.zip -d "$FONT_DIR" > /dev/null
rm JetBrainsMono.zip

echo "Font installed successfully."
echo "You may need to restart your terminal/editor to see the font."

echo "=============================================="
echo "============== [08] DONE ===================="
echo "=============================================="
echo "▶ Next, run: bash 10-configure-ssh.sh"

