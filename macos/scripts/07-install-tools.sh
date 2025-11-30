#!/usr/bin/env bash

set -e

echo "=============================================="
echo "========= [07] INSTALLING TOOLS ============"
echo "=============================================="

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
  echo "❌ Homebrew is required. Please install it first."
  exit 1
fi

echo "Installing productivity tools..."

# Install tools via Homebrew
brew install zoxide
brew install fzf
brew install fd
brew install bat
brew install lsd
brew install lazygit

# Install FZF keybindings
echo ""
echo "Installing FZF keybindings..."
$(brew --prefix)/opt/fzf/install --all

echo ""
echo "Installed tools:"
echo "  ✓ zoxide - smart cd"
echo "  ✓ fzf - fuzzy finder"
echo "  ✓ fd - fast find"
echo "  ✓ bat - better cat"
echo "  ✓ lsd - better ls"
echo "  ✓ lazygit - git TUI"

echo "=============================================="
echo "============== [07] DONE ===================="
echo "=============================================="
echo "▶ Next, run: bash 08-install-font-jetbrains.sh"

