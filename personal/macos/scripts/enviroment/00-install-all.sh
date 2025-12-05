#!/usr/bin/env bash

set -e

echo "=============================================="
echo "========= COMPLETE INSTALLATION =============="
echo "=============================================="
echo ""
echo "This script will install and configure your development environment."
echo ""

# Collect user information
echo "📝 Please provide the following information:"
echo ""

# Get Git user name
if [ -z "$GIT_USER_NAME" ]; then
    read -p "Enter your Git user name (e.g., John Doe): " GIT_USER_NAME
    if [ -z "$GIT_USER_NAME" ]; then
        echo "⚠️  Git user name is required. Using default: 'Developer'"
        GIT_USER_NAME="Developer"
    fi
fi

# Get Git email
if [ -z "$GIT_USER_EMAIL" ]; then
    read -p "Enter your Git email (e.g., john.doe@example.com): " GIT_USER_EMAIL
    if [ -z "$GIT_USER_EMAIL" ]; then
        echo "⚠️  Git email is required. Exiting..."
        exit 1
    fi
fi

# Export variables for child scripts
export GIT_USER_NAME
export GIT_USER_EMAIL

echo ""
echo "=============================================="
echo "Configuration summary:"
echo "  Git Name: $GIT_USER_NAME"
echo "  Git Email: $GIT_USER_EMAIL"
echo "=============================================="
echo ""
echo "⚠️  ATTENTION:"
echo "   - After Docker installation, you may need to"
echo "     restart Docker Desktop (macOS)."
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
  "10-configure-file-watchers.sh"
  "11-install-cursor-extensions.sh"
  "12-configure-cursor.sh"
  "13-install-docker.sh"
  "14-configure-terminal.sh"
  "15-install-insomnia.sh"
  "16-install-tableplus.sh"
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
echo ""
echo "After restarting, verify installations:"
echo "  node -v"
echo "  yarn -v"
echo "  docker --version"
echo ""

