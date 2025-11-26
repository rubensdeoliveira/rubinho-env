#!/usr/bin/env bash
set -e

echo "======================================="
echo "===== INSTALAÇÃO DO AMBIENTE DEV ====="
echo "======================================="

###########################################################################
# GIT E GITCONFIG
###########################################################################

echo "===== [GIT] Instalando Git ====="
sudo apt update -y
sudo apt install -y git

echo "===== [GIT] Configurando identidade ====="
git config --global user.name "rubinho"
git config --global user.email "rubensojunior6@gmail.com"
git config --global init.defaultBranch main
git config --global color.ui auto

###########################################################################
# 1. DOCKER
###########################################################################

echo "===== [DOCKER] Atualizando sistema ====="
sudo apt update -y && sudo apt upgrade -y

echo "===== [DOCKER] Removendo instalações antigas ====="
sudo apt remove -y docker docker-engine docker.io containerd runc || true

echo "===== [DOCKER] Instalando dependências ====="
sudo apt install -y ca-certificates curl gnupg lsb-release

echo "===== [DOCKER] Adicionando chave GPG ====="
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "===== [DOCKER] Adicionando repositório ====="
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update -y

echo "===== [DOCKER] Instalando Docker ====="
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "===== [DOCKER] Testando Docker ====="
sudo docker run hello-world || true

echo "===== [DOCKER] Adicionando usuário ao grupo docker ====="
sudo usermod -aG docker $USER
echo "⚠ Deslogue e logue novamente para usar Docker sem sudo!"

###########################################################################
# 2. NODE + NVM + YARN
###########################################################################

echo "===== [NODE] Instalando NVM ====="
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
else
  echo "NVM já instalado"
fi

# Carregar NVM na sessão atual
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"

echo "===== [NODE] Instalando Node 22 ====="
nvm install 22
nvm alias default 22

echo "Node -> $(node -v)"
echo "NPM  -> $(npm -v)"

echo "===== [YARN] Habilitando Corepack ====="
corepack enable
corepack prepare yarn@1 --activate

echo "Yarn -> $(yarn -v)"

###########################################################################
# 3. JETBRAINS MONO NERD FONT
###########################################################################

echo "===== [FONTS] Instalando JetBrainsMono Nerd Font ====="

FONT_DIR="$HOME/.local/share/fonts/JetBrainsMono"
mkdir -p "$FONT_DIR"

wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -o JetBrainsMono.zip -d "$FONT_DIR" > /dev/null
rm JetBrainsMono.zip

fc-cache -fv

echo "===== [FONTS] JetBrainsMono Nerd Font instalada ====="

###########################################################################
# 4. CURSOR 
###########################################################################

echo "===== [CURSOR] Instalando Cursor Editor ====="

curl -L "https://downloads.cursor.com/linux/appImage/x64" -o cursor.AppImage
chmod +x cursor.AppImage
sudo mv cursor.AppImage /usr/local/bin/cursor

echo "Cursor -> instalado com sucesso!"
cursor --version || echo "Cursor instalado, mas versão não pôde ser exibida."

###########################################################################
# 5. TECLADO EUA INTERNACIONAL + cedilha
###########################################################################

echo "===== [KEYBOARD] Configurando teclado EUA internacional ====="
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us+intl')]"

echo "===== [KEYBOARD] Fix cedilha (ç) ====="
gsettings set org.gnome.desktop.input-sources xkb-options "['lv3:ralt_switch']"

###########################################################################
# 6. TERMINAL: Criar novo perfil 'rubinho', aplicar Dracula e deletar os demais
###########################################################################

echo "===== [TERMINAL] Criando perfil rubinho ====="

# Gerar UUID novo
NEW_PROFILE_ID=$(uuidgen)

# Adicionar na lista
OLD_LIST=$(gsettings get org.gnome.Terminal.ProfilesList list)
NEW_LIST=$(echo "$OLD_LIST" | sed "s/]/, '$NEW_PROFILE_ID']/")
gsettings set org.gnome.Terminal.ProfilesList list "$NEW_LIST"

# Criar o profile na árvore do dconf
PROFILE_KEY="/org/gnome/terminal/legacy/profiles:/:$NEW_PROFILE_ID/"
dconf write "${PROFILE_KEY}visible-name" "'rubinho'"
dconf write "${PROFILE_KEY}use-system-font" "false"
dconf write "${PROFILE_KEY}font" "'JetBrainsMono Nerd Font 13'"
dconf write "${PROFILE_KEY}use-theme-colors" "false"
dconf write "${PROFILE_KEY}foreground-color" "'#f8f8f2'"
dconf write "${PROFILE_KEY}background-color" "'#282a36'"

# Paleta Dracula
dconf write "${PROFILE_KEY}palette" "['#000000', '#ff5555', '#50fa7b', '#f1fa8c', '#bd93f9', '#ff79c6', '#8be9fd', '#bbbbbb', '#44475a', '#ff6e6e', '#69ff94', '#ffffa5', '#d6caff', '#ff92df', '#a6f0ff', '#ffffff']"

echo "===== [TERMINAL] Definindo rubinho como default ====="
gsettings set org.gnome.Terminal.ProfilesList default "'$NEW_PROFILE_ID'"

###########################################################################
# Remover perfis antigos (somente mantém o rubinho)
###########################################################################

echo "===== [TERMINAL] Removendo perfis antigos ====="

ALL_PROFILES=$(gsettings get org.gnome.Terminal.ProfilesList list | tr -d "[]'," )

for PID in $ALL_PROFILES; do
  if [ "$PID" != "$NEW_PROFILE_ID" ]; then
    echo "Removendo perfil: $PID"
    dconf reset -f "/org/gnome/terminal/legacy/profiles:/:$PID/"
  fi
done

# Ajustar lista final
gsettings set org.gnome.Terminal.ProfilesList list "['$NEW_PROFILE_ID']"

echo "===== [TERMINAL] Perfil final aplicado: rubinho ====="
echo "UUID: $NEW_PROFILE_ID"

###########################################################################
# FINAL
###########################################################################

echo ""
echo "======================================="
echo " AMBIENTE DEV CONFIGURADO COM SUCESSO! "
echo "======================================="
echo "Reabra seu terminal para aplicar fontes e tema Dracula."
