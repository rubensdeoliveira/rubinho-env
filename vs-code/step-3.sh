#!/usr/bin/env bash
set -e

echo "=============================================="
echo "======= DEV ENVIRONMENT FULL INSTALL ========="
echo "=============================================="

############################################################
# GIT + GLOBAL CONFIG
############################################################
echo "----------------------------------------------"
echo "  [GIT] Installing Git"
echo "----------------------------------------------"
sudo apt update -y
sudo apt install -y git

echo "----------------------------------------------"
echo "  [GIT] Setting up Git identity"
echo "----------------------------------------------"
git config --global user.name "rubinho"
git config --global user.email "rubensojunior6@gmail.com"
git config --global init.defaultBranch main
git config --global color.ui auto


############################################################
# DOCKER
############################################################
echo "----------------------------------------------"
echo "  [DOCKER] Updating system"
echo "----------------------------------------------"
sudo apt update -y && sudo apt upgrade -y

echo "----------------------------------------------"
echo "  [DOCKER] Removing old Docker installations"
echo "----------------------------------------------"
sudo apt remove -y docker docker-engine docker.io containerd runc || true

echo "----------------------------------------------"
echo "  [DOCKER] Installing required dependencies"
echo "----------------------------------------------"
sudo apt install -y ca-certificates curl gnupg lsb-release

echo "----------------------------------------------"
echo "  [DOCKER] Adding Docker GPG Key"
echo "----------------------------------------------"
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "----------------------------------------------"
echo "  [DOCKER] Adding Docker Repository"
echo "----------------------------------------------"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update -y

echo "----------------------------------------------"
echo "  [DOCKER] Installing Docker Engine"
echo "----------------------------------------------"
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "----------------------------------------------"
echo "  [DOCKER] Testing Docker"
echo "----------------------------------------------"
sudo docker run hello-world || true

echo "----------------------------------------------"
echo "  [DOCKER] Adding current user to docker group"
echo "----------------------------------------------"
sudo usermod -aG docker $USER
echo "⚠️  Logout/Login required to use Docker without sudo"


############################################################
# NODE + NVM + YARN
############################################################
echo "----------------------------------------------"
echo "  [NODE] Installing NVM"
echo "----------------------------------------------"
export NVM_DIR="$HOME/.nvm"

if [ ! -d "$NVM_DIR" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
else
  echo "NVM already installed."
fi

source "$NVM_DIR/nvm.sh"

echo "----------------------------------------------"
echo "  [NODE] Installing Node 22"
echo "----------------------------------------------"
nvm install 22
nvm alias default 22

echo "Node  -> $(node -v)"
echo "NPM   -> $(npm -v)"

echo "----------------------------------------------"
echo "  [YARN] Enabling Corepack + Yarn 1"
echo "----------------------------------------------"
corepack enable
corepack prepare yarn@1 --activate

echo "Yarn  -> $(yarn -v)"


############################################################
# JETBRAINS MONO NERD FONT
############################################################
echo "----------------------------------------------"
echo "  [FONTS] Installing JetBrainsMono Nerd Font"
echo "----------------------------------------------"

FONT_DIR="$HOME/.local/share/fonts/JetBrainsMono"
mkdir -p "$FONT_DIR"

wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -o JetBrainsMono.zip -d "$FONT_DIR" > /dev/null
rm JetBrainsMono.zip

fc-cache -fv
echo "Font installed successfully."


############################################################
# CURSOR EDITOR
############################################################
echo "----------------------------------------------"
echo "  [CURSOR] Installing Cursor Editor"
echo "----------------------------------------------"

curl -L "https://downloads.cursor.com/linux/appImage/x64" -o cursor.AppImage
chmod +x cursor.AppImage
sudo mv cursor.AppImage /usr/local/bin/cursor

echo "Cursor installed!"
cursor --version || echo "Cursor version could not be displayed."


############################################################
# KEYBOARD LAYOUT (US intl + ç fix)
############################################################
echo "----------------------------------------------"
echo "  [KEYBOARD] Setting US International layout"
echo "----------------------------------------------"
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us+intl')]"

echo "----------------------------------------------"
echo "  [KEYBOARD] Enabling cedilla (ç) fix"
echo "----------------------------------------------"
gsettings set org.gnome.desktop.input-sources xkb-options "['lv3:ralt_switch']"


############################################################
# GNOME TERMINAL — CREATE DRACULA PROFILE "rubinho"
############################################################
echo "----------------------------------------------"
echo "  [TERMINAL] Creating new GNOME Terminal profile: rubinho"
echo "----------------------------------------------"

NEW_PROFILE_ID=$(uuidgen)

# Add to GNOME Terminal list
OLD_LIST=$(gsettings get org.gnome.Terminal.ProfilesList list)
NEW_LIST=$(echo "$OLD_LIST" | sed "s/]/, '$NEW_PROFILE_ID']/")
gsettings set org.gnome.Terminal.ProfilesList list "$NEW_LIST"

PROFILE_KEY="/org/gnome/terminal/legacy/profiles:/:$NEW_PROFILE_ID/"

dconf write "${PROFILE_KEY}visible-name" "'rubinho'"
dconf write "${PROFILE_KEY}use-system-font" "false"
dconf write "${PROFILE_KEY}font" "'JetBrainsMono Nerd Font 13'"
dconf write "${PROFILE_KEY}use-theme-colors" "false"
dconf write "${PROFILE_KEY}foreground-color" "'#f8f8f2'"
dconf write "${PROFILE_KEY}background-color" "'#282a36'"
dconf write "${PROFILE_KEY}palette" "['#000000', '#ff5555', '#50fa7b', '#f1fa8c', '#bd93f9', '#ff79c6', '#8be9fd', '#bbbbbb', '#44475a', '#ff6e6e', '#69ff94', '#ffffa5', '#d6caff', '#ff92df', '#a6f0ff', '#ffffff']"

echo "----------------------------------------------"
echo "  [TERMINAL] Setting rubinho as default profile"
echo "----------------------------------------------"
gsettings set org.gnome.Terminal.ProfilesList default "'$NEW_PROFILE_ID'"


############################################################
# REMOVE OLD TERMINAL PROFILES
############################################################
echo "----------------------------------------------"
echo "  [TERMINAL] Cleaning up old profiles"
echo "----------------------------------------------"

ALL_PROFILES=$(gsettings get org.gnome.Terminal.ProfilesList list | tr -d "[],'")

for PID in $ALL_PROFILES; do
  if [ "$PID" != "$NEW_PROFILE_ID" ]; then
    echo "Removing old profile: $PID"
    dconf reset -f "/org/gnome/terminal/legacy/profiles:/:$PID/"
  fi
done

gsettings set org.gnome.Terminal.ProfilesList list "['$NEW_PROFILE_ID']"
echo "Profile successfully applied."


############################################################
# DONE
############################################################
echo ""
echo "=============================================="
echo "   DEV ENVIRONMENT INSTALLED SUCCESSFULLY! 🎉"
echo "=============================================="
echo "Restart your terminal to apply all settings."
