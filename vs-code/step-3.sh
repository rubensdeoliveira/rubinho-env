#!/usr/bin/env bash

set -e

echo "======================================="
echo "===== INSTALAÇÃO DO AMBIENTE DEV ====="
echo "======================================="

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

# Download estável da AppImage
curl -L "https://downloads.cursor.com/linux/appImage/x64" -o cursor.AppImage

chmod +x cursor.AppImage

# Instalar globalmente
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
# 6. TEMA DRACULA + FONTE NO TERMINAL
###########################################################################

echo "===== [DRACULA] Instalando tema Dracula no GNOME Terminal ====="

# Descobre UUID do perfil padrão
PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")

if [ -z "$PROFILE_ID" ]; then
  echo "Erro: não foi possível encontrar o profile do GNOME Terminal."
  exit 1
fi

echo "Perfil padrão encontrado: $PROFILE_ID"

# Define fonte JetBrainsMono Nerd Font 13
echo "Aplicando fonte JetBrainsMono Nerd Font..."
gsettings set \
  org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ \
  font 'JetBrainsMono Nerd Font 13'

# Instalar Dracula
TMP_DRACULA="/tmp/dracula-term"
rm -rf "$TMP_DRACULA"
git clone https://github.com/dracula/gnome-terminal.git "$TMP_DRACULA"
cd "$TMP_DRACULA"

./install.sh --scheme Dracula --profile "$PROFILE_ID" --force

cd ~

echo "===== [DRACULA] Tema aplicado com sucesso ====="

###########################################################################
# 7. FINAL
###########################################################################

echo ""
echo "======================================="
echo " AMBIENTE DEV CONFIGURADO COM SUCESSO! "
echo "======================================="
echo "Reabra seu terminal para aplicar fontes e temas."
