#!/usr/bin/env bash

set -e

echo "=============================================="
echo "========= [02] INSTALLING PREZTO ============="
echo "=============================================="

ZSH_BIN=$(which zsh)

if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
  echo "Installing Prezto..."
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
else
  echo "Prezto already installed."
fi

echo "Creating Prezto runcom symlinks..."
# Use Zsh to create symlinks (Zsh syntax required for glob patterns)
TMP_ZSH_SCRIPT=$(mktemp /tmp/prezto_symlinks.XXXXXX)
cat > "$TMP_ZSH_SCRIPT" << 'ZSH_EOF'
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -sf "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
ZSH_EOF

$ZSH_BIN "$TMP_ZSH_SCRIPT"
rm "$TMP_ZSH_SCRIPT"

echo "Writing .zpreztorc (module config)..."
cat > ~/.zpreztorc << 'EOF'
zstyle ':prezto:load' pmodule \
  'environment' \
  'terminal' \
  'editor' \
  'history' \
  'directory' \
  'spectrum' \
  'utility' \
  'completion' \
  'autosuggestions' \
  'syntax-highlighting'
EOF

echo "=============================================="
echo "============== [02] DONE ===================="
echo "=============================================="
echo "▶ Next, run: bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/03-install-starship.sh)"

