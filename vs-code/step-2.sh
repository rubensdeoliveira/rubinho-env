#!/usr/bin/env bash

set -e

echo "===== Iniciando configuração de Prezto + Starship ====="

ZSH_BIN=$(which zsh)

echo "===== Criando script temporário ZSH ====="
TMP_ZSH_SCRIPT=$(mktemp /tmp/zsh_script.XXXXXX)

cat > "$TMP_ZSH_SCRIPT" << 'EOF'
set -e

echo "===== Instalando Prezto ====="
if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
else
  echo "Prezto já instalado."
fi

echo "===== Criando symlinks dos runcoms ====="
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -sf "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

echo "===== Configurando módulos essenciais do Prezto ====="
cat > ~/.zpreztorc << 'ZPREZTOEOF'
#
# Configuração dos módulos do Prezto
#

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
  'syntax-highlighting' \
  'prompt'
ZPREZTOEOF

echo "===== Instalando Starship ====="
curl -sS https://starship.rs/install.sh | sh

echo "===== Baixando starship.toml ====="
mkdir -p ~/.config
curl -Ls https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/vs-code/step-2-aux-1 -o ~/.config/starship.toml

echo "===== Criando .zshrc final ====="
cat > ~/.zshrc << 'ENDZSH'
#
# Arquivo .zshrc final — Prezto + Starship
#

# Carregar Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Iniciar Starship
eval "$(starship init zsh)"
ENDZSH

echo "===== CONFIGURAÇÃO CONCLUÍDA ====="
EOF

echo "===== Executando script ZSH ====="
$ZSH_BIN "$TMP_ZSH_SCRIPT"

echo "===== Limpando arquivo temporário ====="
rm "$TMP_ZSH_SCRIPT"

echo "===== INSTALAÇÃO COMPLETA ====="
echo "👉 Rode: source ~/.zshrc"
echo "👉 Depois faça logout/login para ativar 100%"
echo "👉 Rode: bash <(curl -Ls https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/vs-code/step-3-dev-stack.sh)"

