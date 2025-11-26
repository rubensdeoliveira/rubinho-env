#!/usr/bin/env zsh

set -e

echo "===== Instalando ZSH ====="
sudo apt update -y
sudo apt install -y zsh curl git

echo "===== Alterando shell padrão para ZSH ====="
CHSH_PATH=$(which zsh)
if [ "$SHELL" != "$CHSH_PATH" ]; then
  chsh -s "$CHSH_PATH"
fi

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

echo "===== Instalando Starship ====="
curl -sS https://starship.rs/install.sh | sh

echo "===== Baixando starship.toml do GitHub ====="
mkdir -p ~/.config
curl -Ls https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/vs-code/starship.toml -o ~/.config/starship.toml

echo "===== Criando .zshrc personalizado ====="
cat > ~/.zshrc << 'EOF'
# Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Starship prompt
eval "$(starship init zsh)"
EOF

echo "===== TUDO CONCLUÍDO! ====="
echo "👉 Agora rode: source ~/.zshrc"
echo "👉 E depois faça logout/login para ativar o ZSH como shell padrão."
