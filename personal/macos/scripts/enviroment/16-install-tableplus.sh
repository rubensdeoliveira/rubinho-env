#!/usr/bin/env bash

set -e

echo "=============================================="
echo "========= [23] INSTALLING TABLEPLUS =========="
echo "=============================================="
echo ""
echo "TablePlus is a modern database client for macOS"
echo "(alternative to HeidiSQL)"
echo ""

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
  echo "❌ Homebrew is required. Please install it first."
  exit 1
fi

# Check if TablePlus is already installed
if brew list --cask tableplus &> /dev/null 2>&1; then
    echo "✓ TablePlus is already installed"
    echo "Skipping installation..."
else
    echo "Installing TablePlus via Homebrew..."
    brew install --cask tableplus
    
    # Verify installation
    if [ -d "/Applications/TablePlus.app" ]; then
        echo "✓ TablePlus installed successfully"
    else
        echo "⚠️  TablePlus installation may have failed"
    fi
fi

echo "=============================================="
echo "============== [17] DONE ===================="
echo "=============================================="
echo ""
echo "📝 TablePlus is a modern database client that supports:"
echo "   - MySQL, PostgreSQL, SQLite, Redis, and many more"
echo "   - Native macOS app with beautiful interface"
echo "   - Similar functionality to HeidiSQL"
echo ""
echo "🎉 All development tools installation complete!"

