#!/usr/bin/env bash

set -e

echo "=============================================="
echo "========= COMPLETE INSTALLATION =============="
echo "=============================================="
echo ""
echo "This script will install and configure your development environment."
echo ""
echo "⚠️  ATTENTION:"
echo "   - After Docker installation (final step), you may need to"
echo "     logout/login to use Docker without sudo (Linux only)."
echo ""
read -p "Do you want to continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Installation cancelled."
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Part 1: Initial setup (01-02)
echo ""
echo "=============================================="
echo "PHASE 1: Initial Setup"
echo "=============================================="

echo ""
echo "Running script 01: configure-git.sh"
echo "=============================================="
bash "$SCRIPT_DIR/01-configure-git.sh"

echo ""
echo "Running script 02: install-zsh.sh"
echo "=============================================="
bash "$SCRIPT_DIR/02-install-zsh.sh"

echo ""
echo "=============================================="
echo "PHASE 2: Environment Configuration"
echo "=============================================="

# Part 2: Environment setup (03-04)
echo ""
echo "Running script 03: install-zinit.sh"
echo "=============================================="
bash "$SCRIPT_DIR/03-install-zinit.sh"

echo ""
echo "Running script 04: install-starship.sh"
echo "=============================================="
bash "$SCRIPT_DIR/04-install-starship.sh"

# Load NVM (it will be available in .zshrc after restart)
echo ""
echo "Loading NVM configuration..."
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  \. "$NVM_DIR/nvm.sh"
  echo "✓ NVM loaded"
else
  echo "⚠️  NVM not found yet, will be available after restart"
fi

echo ""
echo "=============================================="
echo "PHASE 3: Development Tools"
echo "=============================================="

# Part 3: Development tools (05-08)
scripts=(
  "05-install-node-nvm.sh"
  "06-install-yarn.sh"
  "07-install-tools.sh"
  "08-install-font-jetbrains.sh"
)

for script in "${scripts[@]}"; do
  echo ""
  echo "Running: $script"
  echo "=============================================="
  
  # Before each script, reload NVM if it exists
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" || true
  
  bash "$SCRIPT_DIR/$script"
done

echo ""
echo "=============================================="
echo "PHASE 4: Application Setup"
echo "=============================================="

# Part 4: Applications and configuration
scripts=(
  "09-install-cursor.sh"
  "10-configure-keyboard.sh"
  "11-configure-terminal.sh"
  "12-configure-ssh.sh"
  "14-configure-inotify.sh"
  "15-install-cursor-extensions.sh"
  "16-configure-cursor.sh"
  "17-install-docker.sh"
)

for script in "${scripts[@]}"; do
  echo ""
  echo "Running: $script"
  echo "=============================================="
  
  # Before each script, reload NVM if it exists
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" || true
  
  bash "$SCRIPT_DIR/$script"
done

echo ""
echo "=============================================="
echo "🎉 INSTALLATION COMPLETE!"
echo "=============================================="
echo "All scripts have been executed successfully!"
echo ""
echo "⚠️  IMPORTANT:"
echo "   - Close and reopen your terminal to ensure"
echo "     all configurations are loaded."
echo "   - On Linux: You may need to logout/login to"
echo "     use Docker without sudo."
echo ""
echo "After restarting, verify installations:"
echo "  node -v"
echo "  yarn -v"
echo "  docker --version"
echo ""

