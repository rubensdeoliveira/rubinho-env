#!/usr/bin/env bash

set -e

echo "===== Atualizando sistema ====="
sudo apt update -y
sudo apt install -y zsh git curl

echo "===== Alterando shell padrão para Zsh ====="
chsh -s $(which zsh)

echo "===== Instalando Prezto ====="
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

echo "===== Criando symlinks dos runcoms ====="
setopt EXTENDED_GLOB || true
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -sf "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

echo "===== Instalando Starship ====="
curl -sS https://starship.rs/install.sh | sh

echo "===== Criando diretório de configuração do Starship ====="
mkdir -p ~/.config

echo "===== Criando arquivo starship.toml ====="
cat > ~/.config/starship.toml << 'EOF'
[username]
style_user = "green bold"
style_root = "red bold"
format = "[$user]($style) "
disabled = false
show_always = true

[hostname]
disabled = true

[character]
success_symbol = "[➜](bold green)"
error_symbol = "[✗](bold red)"

[directory]
read_only = " "
truncation_length = 10
truncate_to_repo = true
style = "bold italic blue"

[cmd_duration]
min_time = 4
show_milliseconds = false
disabled = false
style = "bold italic red"

[aws]
symbol = "  "

[conda]
symbol = " "

[dart]
symbol = " "

[docker_context]
symbol = " "
format = "via [$symbol$context]($style) "
style = "blue bold"
only_with_files = true
detect_files = ["docker-compose.yml", "docker-compose.yaml", "Dockerfile"]
detect_folders = []
disabled = false

[elixir]
symbol = " "

[elm]
symbol = " "

[git_branch]
symbol = " "

[git_status]
format = '([\[$all_status$ahead_behind\]]($style) )'
stashed = "[${count}*](green)"
modified = "[${count}+](yellow)"
deleted = "[${count}-](red)"
conflicted = "[${count}~](red)"
ahead = "⇡${count}"
behind = "⇣${count}"
untracked = "[${count}?](blue)"
staged = "[${count}+](green)"

[git_state]
style = "bold red"
format = "[$state( $progress_current/$progress_total) ]($style)"

[golang]
symbol = " "

[hg_branch]
symbol = " "

[java]
symbol = " "

[julia]
symbol = " "

[haskell]
symbol = "λ "

[memory_usage]
symbol = " "

[nim]
symbol = " "

[nix_shell]
symbol = " "

[package]
symbol = " "

[perl]
symbol = " "

[php]
symbol = " "

[python]
symbol = "🐍 "
format = 'via [${symbol}python (${version} )(\($virtualenv\) )]($style)'
style = "bold yellow"
pyenv_prefix = "venv "
python_binary = ["./venv/bin/python", "python", "python3", "python2"]
detect_extensions = ["py"]
version_format = "v${raw}"

[ruby]
symbol = " "

[rust]
symbol = " "

[scala]
symbol = " "

[shlvl]
symbol = " "

[swift]
symbol = "ﯣ "

[custom.ts]
command = "echo TS"
format = "via [ TS](bold blue) "
detect_files = ["tsconfig.json","tsconfig.base.json"]
detect_folders = ["node_modules"]

[dotnet]
disabled = true

[nodejs]
disabled = true
EOF

echo "===== Atualizando .zshrc ====="
cat > ~/.zshrc << 'EOF'
# Carregar Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Iniciar Starship
eval "$(starship init zsh)"
EOF

echo "===== Tudo pronto! ====="
echo "⚠️ Deslogue e logue novamente ou rode: source ~/.zshrc"
