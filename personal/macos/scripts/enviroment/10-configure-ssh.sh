#!/usr/bin/env bash

set -e

echo "=============================================="
echo "========= [10] CONFIGURING SSH =============="
echo "=============================================="

# Use provided email or prompt for it
if [ -z "$GIT_USER_EMAIL" ]; then
    read -p "Enter your email for SSH key: " GIT_USER_EMAIL
    if [ -z "$GIT_USER_EMAIL" ]; then
        echo "⚠️  Email is required for SSH key"
        exit 1
    fi
fi

echo "Generating SSH key with email: $GIT_USER_EMAIL"
if [ ! -f ~/.ssh/id_ed25519 ]; then
  ssh-keygen -t ed25519 -C "$GIT_USER_EMAIL" -f ~/.ssh/id_ed25519 -N ""
else
  echo "SSH key already exists."
fi

echo "Starting SSH agent..."
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

echo "Setting correct permissions..."
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub

echo "Copying public key to clipboard..."
cat ~/.ssh/id_ed25519.pub | pbcopy

echo "=============================================="
echo "============== [10] DONE ===================="
echo "=============================================="
echo "✅ SSH public key copied to clipboard!"
echo "   Go to GitHub/GitLab Settings → SSH Keys and paste it."
echo "▶ Next, run: bash 10-configure-file-watchers.sh"

