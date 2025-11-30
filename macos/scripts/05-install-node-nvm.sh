#!/usr/bin/env bash

set -e

echo "=============================================="
echo "========= [05] INSTALLING NODE + NVM ========="
echo "=============================================="

export NVM_DIR="$HOME/.nvm"

if [ ! -d "$NVM_DIR" ]; then
  echo "Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
else
  echo "NVM already installed."
fi

# Load NVM
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

echo "Installing Node 22..."
if [ -s "$NVM_DIR/nvm.sh" ]; then
  # Source NVM again to ensure it's loaded
  source "$NVM_DIR/nvm.sh"
  
  # Install Node 22
  nvm install 22 || {
    echo "⚠️  Failed to install Node 22. Trying to continue..."
    exit 1
  }
  
  # Set as default and use it
  nvm alias default 22
  nvm use 22
  
  # Verify installation
  if command -v node &> /dev/null; then
    echo "✓ Node  -> $(node -v)"
    echo "✓ NPM   -> $(npm -v)"
  else
    echo "⚠️  Node installed but not in PATH. Please restart terminal."
  fi
else
  echo "⚠️  NVM installation failed. Please check the installation."
  exit 1
fi

echo "=============================================="
echo "============== [05] DONE ===================="
echo "=============================================="
echo "▶ Next, run: bash 06-install-yarn.sh"

