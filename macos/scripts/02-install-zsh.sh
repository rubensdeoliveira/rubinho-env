#!/usr/bin/env bash

set -e

echo "=============================================="
echo "========= [02] INSTALLING ZSH ================"
echo "=============================================="

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  # Add Homebrew to PATH for Apple Silicon Macs
  if [[ $(uname -m) == "arm64" ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
else
  echo "Homebrew already installed."
fi

# Install zsh if not already installed (usually comes with macOS)
if ! command -v zsh &> /dev/null; then
  echo "Installing ZSH..."
  brew install zsh
else
  echo "ZSH already installed."
fi

# Install git and curl if not available
if ! command -v git &> /dev/null; then
  brew install git
fi

if ! command -v curl &> /dev/null; then
  brew install curl
fi

ZSH_BIN=$(which zsh)

echo "=============================================="
echo "===== [02] SETTING DEFAULT SHELL ============"
echo "=============================================="

if [ "$SHELL" != "$ZSH_BIN" ]; then
  # Add zsh to /etc/shells if not already there
  if ! grep -q "$ZSH_BIN" /etc/shells; then
    echo "$ZSH_BIN" | sudo tee -a /etc/shells
  fi
  chsh -s "$ZSH_BIN"
  echo "✔ Default shell changed to ZSH"
else
  echo "✔ ZSH is already the default shell"
fi

echo "=============================================="
echo "===== [02] CREATING MINIMAL .zshrc ==========="
echo "=============================================="

cat > ~/.zshrc << 'EOF'
# ==========================================
#  Minimal ZSH bootstrap configuration file
# ==========================================

# Initialize completion system
autoload -Uz compinit
compinit

# Additional helper configurations will be appended below
# --------------------------------------------
EOF

echo "=============================================="
echo "===== [02] MINIMAL CONFIG CREATED ============"
echo "=============================================="
echo "Full ZSH configuration will be added by script 04"

echo "=============================================="
echo "============== [02] DONE ===================="
echo "=============================================="
echo "⚠️  Please close the terminal and open it again."
echo "▶ Next, run: bash 03-install-zinit.sh"

