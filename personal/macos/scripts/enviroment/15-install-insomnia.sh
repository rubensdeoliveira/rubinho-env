#!/usr/bin/env bash

set -e

echo "=============================================="
echo "========= [22] INSTALLING INSOMNIA ==========="
echo "=============================================="

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
  echo "❌ Homebrew is required. Please install it first."
  exit 1
fi

# Check if Insomnia is already installed
if brew list --cask insomnia &> /dev/null 2>&1; then
    echo "✓ Insomnia is already installed"
    echo "Skipping installation..."
else
    echo "Installing Insomnia via Homebrew..."
    brew install --cask insomnia
    
    # Verify installation
    if [ -d "/Applications/Insomnia.app" ]; then
        echo "✓ Insomnia installed successfully"
    else
        echo "⚠️  Insomnia installation may have failed"
    fi
fi

echo "=============================================="
echo "============== [22] DONE ===================="
echo "=============================================="
echo "▶ Next, run: bash 16-install-tableplus.sh"

